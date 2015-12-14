#ifndef LINUXPHYSREGDRIVER_HPP
#define LINUXPHYSREGDRIVER_HPP

// register file access using /dev/mem
// inspired by Sven Andersson's /dev/mem gpio driver:
// http://svenand.blogdrive.com/files/gpio-dev-mem-test.c

#include <stdint.h>
#include "axiregdriver.hpp"
#include <sys/mman.h>
#include <unistd.h>
#include <fcntl.h>

#include <iostream>
#include <string.h>
using namespace std;

extern void loadBitfile(const char * accelName);

class LinuxPhysRegDriver : public AXIRegDriver {
public:
  LinuxPhysRegDriver(void * baseAddrPhys, void * memBufBasePhys, unsigned int memBufBytes)
    : AXIRegDriver(baseAddrPhys) {
    unsigned int page_addr, page_offset;
    void *ptr;
    unsigned int page_size=sysconf(_SC_PAGESIZE);
    m_memBufSize = memBufBytes;
    // cout << "page size " << page_size << endl;

    /* Open /dev/mem file */
    int fd = open ("/dev/mem", O_RDWR | O_SYNC);
    if (fd < 1) {
        throw "Could not open /dev/mem";
    }

    /* mmap the device into memory */
    // TODO fix for 64-bit addresses, probably 32-bit only for now
    unsigned int baseAddrVal = (unsigned int) baseAddrPhys;
    page_addr = (baseAddrVal & (~(page_size-1)));
    page_offset = baseAddrVal - page_addr;
    m_pagePtr = mmap(NULL, page_size, PROT_READ|PROT_WRITE, MAP_SHARED, fd, page_addr);
    m_baseAddr = (AccelReg *)(((unsigned int) m_pagePtr) + page_offset);

    // assume memBufBase always starts at page boundary
    m_memBufBasePhys = (unsigned int) memBufBasePhys;
    m_memBufBaseVirt = mmap(NULL, m_memBufSize, PROT_READ|PROT_WRITE, MAP_SHARED, fd, (unsigned int)memBufBasePhys);
    m_currentAllocBase = (unsigned int) m_memBufBasePhys;
    // cout << "memBufBase returned: " << hex << m_memBufBaseVirt << dec << endl;

    close(fd);
  }

  virtual ~LinuxPhysRegDriver() {
    unsigned int page_size=sysconf(_SC_PAGESIZE);
    munmap(m_pagePtr, page_size);
    munmap(m_memBufBaseVirt, m_memBufSize);
  }

  // functions for host-accelerator buffer management
  virtual void copyBufferHostToAccel(void * hostBuffer, void * accelBuffer, unsigned int numBytes) {
    memcpy(phys2virt(accelBuffer), hostBuffer, numBytes);
  }

  virtual void copyBufferAccelToHost(void * accelBuffer, void * hostBuffer, unsigned int numBytes) {
    memcpy(hostBuffer, phys2virt(accelBuffer), numBytes);
  }

  virtual void * allocAccelBuffer(unsigned int numBytes) {
    // align base to 64 bytes
    if(m_currentAllocBase % 64 != 0)
      m_currentAllocBase += 64 - (m_currentAllocBase % 64);
    unsigned int ret = m_currentAllocBase;
    // increment alloc base
    m_currentAllocBase += numBytes;
    if(m_currentAllocBase >= m_memBufBasePhys + m_memBufSize)
      throw "allocAccelBuffer out of memory!";
    return (void *) ret;
  }

  virtual void deallocAccelBuffer(void * buffer) {
    (void) buffer;
    // currently does nothing
    // TODO implement a proper dealloc if we have lots of dynamic alloc/delloc
  }

  virtual void attach(const char * name) {
    // call loadBitfile, defined in platform*.cpp
    loadBitfile(name);
  }

protected:
  void * m_pagePtr;
  void * m_memBufBaseVirt;
  unsigned int m_memBufBasePhys;
  unsigned int m_memBufSize;
  unsigned int m_currentAllocBase;

  void * phys2virt(void * physBufAddr) {
    unsigned int virtBuf = (unsigned int) m_memBufBaseVirt;
    virtBuf += ((unsigned int) physBufAddr) - m_memBufBasePhys;
    return (void *) virtBuf;
  }
};


#endif // LINUXPHYSREGDRIVER_HPP
