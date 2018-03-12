#ifndef WOLVERINEREGDRIVER_H
#define WOLVERINEREGDRIVER_H

extern "C"
{
#include "libcnyfwd.h"
#include <wdm_user.h>
}

#include <stdint.h>
#include "wrapperregdriver.h"
#include <iostream>
using namespace std;

void *memset(void *dst, int c, size_t n)
{
  if (n) {
    char *d = (char *)dst;

    do {
      *d++ = c;
    } while (--n);
  }
  return dst;
}

// TODO add error checks on all cny_fwd* functions

class WolverineRegDriver : public WrapperRegDriver
{
public:
  virtual std::string platformID() {
		return "WolverineDriver";
	}

  virtual void attach(const char * name) {
    m_coproc = WDM_INVALID;

    // reserve and attach to the coprocessor
    m_coproc = wdm_reserve(WDM_CPID_ANY, NULL);

    if (m_coproc == WDM_INVALID) {
        throw  "Unable to reserve coprocessor";
        return;
    }

    if (wdm_attach(m_coproc, name)) {
      throw "Unable to load personality";
      return;
    }

    // open connection to the firmware daemon
    if(cny_fwd_open() != 0)
      throw "cny_fwd_open failed";
    // enable access to CSRs for CSR read/write
    if(cny_fwd_cmd((char *)"fpga sca aemc0 1\n", PEEKPOKE_DEFAULT, NULL, NULL) != 0)
      throw "cny_fwd_cmd failed!";

    // do an instruction dispatch, should never return
    wdm_dispatch_t ds;
    memset((void *)&ds, 0, sizeof(ds));
    if (wdm_dispatch(m_coproc, &ds)) {
      throw "Dispatch error";
      return;
    }
  }

  virtual void detach() {
    // hack: do a write to register 0 to unset the busy flag
    writeReg(0, 2);
    // wait until returned from dispatch?
    int stat = 0;
    while (!(stat = wdm_dispatch_status(m_coproc)));

    if (stat < 0) {
      throw "Dispatch status error";
    }
    // close firmware daemon connection and release coprocessor
    cny_fwd_close();
    wdm_detach(m_coproc);
    wdm_release(m_coproc);
  }

  // functions to ensure coherency across host-accelerator
  virtual void copyBufferHostToAccel(void * hostBuffer, void * accelBuffer, unsigned int numBytes) {
    if(!wdm_memcpy(m_coproc, accelBuffer, hostBuffer, numBytes))
      throw "Error in copyBufferHostToAccel";
  }

  virtual void copyBufferAccelToHost(void * accelBuffer, void * hostBuffer, unsigned int numBytes) {
    if(!wdm_memcpy(m_coproc, hostBuffer, accelBuffer, numBytes))
      throw "Error in copyBufferAccelToHost";
  }

  virtual void * allocAccelBuffer(unsigned int numBytes) {
    void * accelBuf;
    if(wdm_posix_memalign(m_coproc, &accelBuf, 64, numBytes) != 0)
      throw "Error in allocAccelBuffer";
    return accelBuf;
  }

  // register access methods for the platform wrapper
  virtual void writeReg(unsigned int regInd, AccelReg regValue) {
    // TODO support finer-grained writes by adjusting mask
    uint64_t v = regValue;
    cny_fwd_write((char *)"aemc0", 0x30000 + 0x8 * regInd, v, 0xffffffffffffffff);
  }

  virtual AccelReg readReg(unsigned int regInd) {
    uint64_t ret = 0;
    cny_fwd_read((char *)"aemc0", 0x30000 + 0x8*regInd, &ret);
    return (AccelReg) ret;
  }

protected:
  wdm_coproc_t m_coproc;
};

#endif // WOLVERINEREGDRIVER_H
