#ifndef TESTERDRIVER_H
#define TESTERDRIVER_H

#include <iostream>
using namespace std;
#include "wrapperregdriver.h"
#include "TesterWrapper.h"

// register driver for the Tester platform, using the Chisel-generated C++ model to
// interface with the accelerator model
// note that TesterWrapper.h must be generated for each new accelerator, it is the
// model header not just for the wrapper, but the entire system (wrapper+accel)

class TesterRegDriver : public WrapperRegDriver {
public:
  virtual void attach(const char * name) {
    m_inst = new TesterWrapper_t();
    // get # words in the memory
    m_memWords = m_inst->TesterWrapper__mem.length();
    // initialize and reset the model
    m_inst->init();
    reset();
    m_regCount = m_inst->TesterWrapper__io_regFileIF_regCount.to_ulong();
  }

  virtual void detach() { delete m_inst; }

  virtual void copyBufferHostToAccel(void * hostBuffer, void * accelBuffer, unsigned int numBytes) {
    // TODO implement memory writes
  }

  virtual void copyBufferAccelToHost(void * accelBuffer, void * hostBuffer, unsigned int numBytes) {
    // TODO implement memory reads
  }

  virtual void * allocAccelBuffer(unsigned int numBytes) {
    // TODO implement simple memory bookkeeping + return buffer
    return 0;
  }

  // register access methods for the platform wrapper
  virtual void writeReg(unsigned int regInd, AccelReg regValue) {
    m_inst->TesterWrapper__io_regFileIF_cmd_bits_writeData = regValue;
    m_inst->TesterWrapper__io_regFileIF_cmd_bits_write  = 1;
    m_inst->TesterWrapper__io_regFileIF_cmd_bits_regID = regInd;
    m_inst->TesterWrapper__io_regFileIF_cmd_valid = 1;
    step();
    m_inst->TesterWrapper__io_regFileIF_cmd_valid = 0;
    m_inst->TesterWrapper__io_regFileIF_cmd_bits_write = 0;
    step(5);  // extra delay on write completion to be realistic
  }

  virtual AccelReg readReg(unsigned int regInd) {
    AccelReg ret;

    m_inst->TesterWrapper__io_regFileIF_cmd_bits_regID = regInd;
    m_inst->TesterWrapper__io_regFileIF_cmd_valid = 1;
    m_inst->TesterWrapper__io_regFileIF_cmd_bits_read = 1;
    step(); // don't actually need 1 cycle, regfile reads are combinational

    if(!m_inst->TesterWrapper__io_regFileIF_readData_valid.to_bool())
      throw "Could not read register";

    m_inst->TesterWrapper__io_regFileIF_cmd_valid = 0;
    m_inst->TesterWrapper__io_regFileIF_cmd_bits_read = 0;

    ret = m_inst->TesterWrapper__io_regFileIF_readData_bits.to_ulong();

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
  TesterWrapper_t * m_inst;
  unsigned int m_memWords;
  unsigned int m_regCount;

  void reset() {
    m_inst->clock(1);
    m_inst->clock(0);
    // Chisel c++ backend requires this workaround to get out the correct values
    m_inst->clock_lo(0);
  }

  void step(int n = 1) {
    for(int i = 0; i < n; i++) {
      m_inst->clock(0);
      // Chisel c++ backend requires this workaround to get out the correct values
      m_inst->clock_lo(0);
    }
  }
};

#endif
