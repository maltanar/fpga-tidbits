#ifndef WOLVERINEREGDRIVER_H
#define WOLVERINEREGDRIVER_H

extern "C"
{
#include "libcnyfwd.h"
}

#include <stdint.h>
#include "wrapperregdriver.h"


typedef uint64_t AccelReg;

// TODO add error checks on all cny_fwd* functions

class WolverineRegDriver : public WrapperRegDriver<AccelReg>
{
public:
  WolverineRegDriver() {
    if(cny_fwd_open() != 0)
      throw "cny_fwd_open failed";
    if(cny_fwd_cmd((char *)"fpga sca aemc0 1\n", PEEKPOKE_DEFAULT, NULL, NULL) != 0)
      throw "cny_fwd_cmd failed!";
  }

  ~WolverineRegDriver() {
    cny_fwd_close();
  }

  // (optional) functions to ensure coherency across host-accelerator
  // TODO

protected:

  // (mandatory) register access methods for the platform wrapper
  virtual void writeReg(unsigned int regInd, AccelReg regValue) {
    // TODO support finer-grained writes by adjusting mask
    cny_fwd_write((char *)"aemc0", 0x30000 + 0x8 * regInd, regValue, 0xffffffffffffffff);
  }

  virtual AccelReg readReg(unsigned int regInd) {
    AccelReg ret;
    cny_fwd_read((char *)"aemc0", 0x30000 + 0x8*regInd, &ret);
    return ret;
  }
};

#endif // WOLVERINEREGDRIVER_H
