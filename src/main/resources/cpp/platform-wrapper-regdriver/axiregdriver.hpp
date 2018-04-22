#ifndef AXIREGDRIVER_H
#define AXIREGDRIVER_H

#include <stdint.h>
#include "wrapperregdriver.h"

class AXIRegDriver :  public WrapperRegDriver {
public:
  AXIRegDriver(void *baseAddr) {
    m_baseAddr = (AccelReg *) baseAddr;
  }

  virtual ~AXIRegDriver() {}

  virtual std::string platformID() {
		return "AXIDriver";
	}

  virtual void writeReg(unsigned int regInd, AccelReg regValue) {
    m_baseAddr[regInd] = regValue;
  }

  virtual AccelReg readReg(unsigned int regInd) {
    return m_baseAddr[regInd];
  }

protected:
  AccelReg * m_baseAddr;

};

#endif
