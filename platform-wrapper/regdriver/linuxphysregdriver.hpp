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

class LinuxPhysRegDriver : public AXIRegDriver {
public:
  LinuxPhysRegDriver(void * baseAddr) : AXIRegDriver(baseAddr) {
    unsigned int page_addr, page_offset;
    void *ptr;
    unsigned int page_size=sysconf(_SC_PAGESIZE);

    /* Open /dev/mem file */
    int fd = open ("/dev/mem", O_RDWR);
    if (fd < 1) {
        throw "Could not open /dev/mem";
    }

    /* mmap the device into memory */
    // TODO fix for 64-bit addresses, probably 32-bit only for now
    unsigned int baseAddrVal = (unsigned int) baseAddr;
    page_addr = (baseAddrVal & (~(page_size-1)));
    page_offset = baseAddrVal - page_addr;
    m_pagePtr = mmap(NULL, page_size, PROT_READ|PROT_WRITE, MAP_SHARED, fd, page_addr);
    m_baseAddr = (AccelReg *)(((unsigned int) m_pagePtr) + page_offset);
    close(fd);
  }

  virtual ~LinuxPhysRegDriver() {
    unsigned int page_size=sysconf(_SC_PAGESIZE);
    munmap(m_pagePtr, page_size);
  }

protected:
  void * m_pagePtr;
};


#endif // LINUXPHYSREGDRIVER_HPP
