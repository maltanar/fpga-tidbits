#ifndef AXIREGDRIVER_H
#define AXIREGDRIVER_H

#include <stdint.h>
#include "wrapperregdriver.h"

typedef uint32_t AccelReg;

class AXIRegDriver :  public WrapperRegDriver<AccelReg> {
  public:
    AXIRegDriver(void *baseAddr) {
      m_baseAddr = (AccelReg *) baseAddr;
    }

  protected:
    AccelReg * m_baseAddr;

    virtual void writeReg(unsigned int regInd, AccelReg regValue) {
      m_baseAddr[regInd] = regValue;
    }

    virtual AccelReg readReg(unsigned int regInd) {
      return m_baseAddr[regInd];
    }
};

#endif
