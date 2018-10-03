#ifndef VERILATEDTESTERDRIVER_H
#define VERILATEDTESTERDRIVER_H

#include <iostream>
#include <string.h>
using namespace std;
#include "wrapperregdriver.h"
#include "VTesterWrapper.h"

#ifdef DEBUG
#define __TESTERDRIVER_DEBUG_PRINT(x) (cout << x << endl)
#define __TESTERDRIVER_DEBUG(x) (x)
#elif DEBUG_HW
#define __TESTERDRIVER_DEBUG_PRINT(x) (0)
#define __TESTERDRIVER_DEBUG(x) (x)
#else
#define __TESTERDRIVER_DEBUG_PRINT(x) (0)
#define __TESTERDRIVER_DEBUG(x) (0)
#endif

#ifdef TRACE
#include "verilated_vcd_c.h"
#endif

// register driver for the verilated testers (useful for e.g. Chisel-generated TesterWrapper verilog plus external verilog modules for blackboxes)
// note that VTesterWrapper.h must be generated for each new accelerator, it is the
// model header not just for the wrapper, but the entire system (wrapper+accel)

class VerilatedTesterRegDriver : public WrapperRegDriver {
public:
  VerilatedTesterRegDriver() {m_freePtr = 0; m_time = 0; Verilated::traceEverOn(true);}

  virtual void attach(const char * name) {
    m_inst = new VTesterWrapper();
#ifdef TRACE
    m_tfp = new VerilatedVcdC;
    m_inst->trace(m_tfp, 4);
    m_tfp->open("trace.vcd");
#endif

    // get # words in the memory -- TODO get from verilator?
    m_memWords = 64*1024*1024;
    // initialize and reset the model
    reset();
    m_regCount = m_inst->io_regFileIF_regCount;
  }

  virtual void detach() {
#ifdef TRACE
    m_tfp->close();
    delete m_tfp;
#endif
    delete m_inst;
  }

  virtual std::string platformID() {
		return "VerilatedEmuDriver";
	}

  virtual void copyBufferHostToAccel(void * hostBuffer, void * accelBuffer, unsigned int numBytes) {
    uint64_t accelBufBase = (uint64_t) accelBuffer;
    __TESTERDRIVER_DEBUG_PRINT("host2accel(" << (uint64_t) hostBuffer << " -> " << accelBufBase << " : " << numBytes << " bytes)");

    if((numBytes % 8 == 0) && (accelBufBase % 8 == 0))
      alignedCopyBufferHostToAccel(hostBuffer, accelBuffer, numBytes);
    else {
      // align base and size
      uint64_t alignedBase = accelBufBase - (accelBufBase % 8);
      uint64_t startDiff = accelBufBase - alignedBase;
      unsigned int alignedSize = (startDiff + numBytes + 7) / 8 * 8;
      // copy containing block into host memory
      char * tmp = new char[alignedSize];
      alignedCopyBufferAccelToHost((void *)alignedBase, (void *) tmp, alignedSize);
      // do host-to-host unaligned copy
      memcpy((void *)&tmp[startDiff], hostBuffer, numBytes);
      // write containing block back to accel memory
      alignedCopyBufferHostToAccel((void *)tmp, (void *)alignedBase, alignedSize);
      delete [] tmp;
    }
  }

  virtual void copyBufferAccelToHost(void * accelBuffer, void * hostBuffer, unsigned int numBytes) {
    uint64_t accelBufBase = (uint64_t) accelBuffer;
    __TESTERDRIVER_DEBUG_PRINT("accel2host(" << accelBufBase << " -> " << (uint64_t) hostBuffer << " : " << numBytes << " bytes)");

    if((numBytes % 8 == 0) && (accelBufBase % 8 == 0))
      alignedCopyBufferAccelToHost(accelBuffer, hostBuffer, numBytes);
    else {
      // implement unaligned accel-to-host
      // align base and size
      uint64_t alignedBase = accelBufBase - (accelBufBase % 8);
      uint64_t startDiff = accelBufBase - alignedBase;
      unsigned int alignedSize = (startDiff + numBytes + 7) / 8 * 8;
      // copy containing block into host memory
      char * tmp = new char[alignedSize];
      alignedCopyBufferAccelToHost((void *)alignedBase, (void *) tmp, alignedSize);
      // do host-to-host unaligned copy
      memcpy(hostBuffer, (void *)&tmp[startDiff],numBytes);
      delete [] tmp;
    }
  }

  virtual void * allocAccelBuffer(unsigned int numBytes) {
    // all this assumes allocation and mem word size of 64 bytes
    // round requested size to nearest multiple of 64
    unsigned int actualAllocSize = (numBytes + 63) / 64 * 64;
    void * accelBuf = (void *) m_freePtr;
    // update free pointer and sanity check
    m_freePtr += actualAllocSize;
    if(m_freePtr > m_memWords * 8)
      throw "Not enough memory in allocAccelBuffer";
    __TESTERDRIVER_DEBUG_PRINT("allocAccelBuffer(" << numBytes << ", alloc " << actualAllocSize <<") = " << (uint64_t) accelBuf);

    return accelBuf;
  }

  // register access methods for the platform wrapper
  virtual void writeReg(unsigned int regInd, AccelReg regValue) {
    __TESTERDRIVER_DEBUG_PRINT("writeReg(" << regInd << ", " << regValue  << ") ");

    m_inst->io_regFileIF_cmd_bits_writeData = regValue;
    m_inst->io_regFileIF_cmd_bits_write  = 1;
    m_inst->io_regFileIF_cmd_bits_regID = regInd;
    m_inst->io_regFileIF_cmd_valid = 1;
    step();
    m_inst->io_regFileIF_cmd_valid = 0;
    m_inst->io_regFileIF_cmd_bits_write = 0;
    step(5);  // extra delay on write completion to be realistic
  }

  virtual AccelReg readReg(unsigned int regInd) {
    AccelReg ret;

    m_inst->io_regFileIF_cmd_bits_regID = regInd;
    m_inst->io_regFileIF_cmd_valid = 1;
    m_inst->io_regFileIF_cmd_bits_read = 1;
    step(); // don't actually need 1 cycle, regfile reads are combinational

    if(!m_inst->io_regFileIF_readData_valid)
      throw "Could not read register";

    m_inst->io_regFileIF_cmd_valid = 0;
    m_inst->io_regFileIF_cmd_bits_read = 0;

    ret = m_inst->io_regFileIF_readData_bits;

    __TESTERDRIVER_DEBUG_PRINT("readReg(" << regInd << ") = " << ret);

    step(5);  // extra delay on read completion to be realistic

    return ret;
  }

  void printAllRegs() {
    for(unsigned int i = 0; i < m_regCount; i++)  {
        AccelReg val = readReg(i);
        cout << "Reg " << i << " = " << val << " (0x" << hex << val << dec << ")" << endl;
      }

  }

protected:
  VTesterWrapper * m_inst;
  unsigned int m_memWords;
  unsigned int m_regCount;
  uint64_t m_freePtr;
  unsigned int m_time;
  VerilatedVcdC * m_tfp;


  void reset() {
    m_inst->reset = 1;
    step(1);
    m_inst->reset = 0;
    step(1);
  }

  void step(int n = 1) {
    for(int i = 0; i < n; i++) {
      m_inst->clk = 1;
      m_inst->eval();
#ifdef TRACE
      m_tfp->dump(m_time);
#endif
      m_time++;
      m_inst->clk = 0;
      m_inst->eval();
#ifdef TRACE
      m_tfp->dump(m_time);
#endif
      m_time++;
    }
  }

  void memWrite(uint64_t addr, uint64_t value) {
    m_inst->io_memAddr = addr;
    m_inst->io_memWriteData = value;
    m_inst->io_memWriteEn = 1;
    step();
    m_inst->io_memWriteEn = 0;
  }

  uint64_t memRead(uint64_t addr) {
    m_inst->io_memAddr = addr;
    step();
    uint64_t ret = m_inst->io_memReadData;
    return ret;
  }

  // "aligned" copy functions, where accel ptr start and size are guaranteed to be 8-aligned
  void alignedCopyBufferHostToAccel(void * hostBuffer, void * accelBuffer, unsigned int numBytes) {
    uint64_t * host_buf = (uint64_t *) hostBuffer;
    uint64_t accelBufBase = (uint64_t) accelBuffer;
    for(unsigned int i = 0; i < numBytes/8; i++)
        memWrite(accelBufBase + i*8, host_buf[i]);
  }

  void alignedCopyBufferAccelToHost(void * accelBuffer, void * hostBuffer, unsigned int numBytes) {
    uint64_t accelBufBase = (uint64_t) accelBuffer;
    uint64_t * readBuf = (uint64_t *) hostBuffer;
    for(unsigned int i = 0; i < numBytes/8; i++)
      readBuf[i] = memRead(accelBufBase + i*8);
  }
};

#endif
