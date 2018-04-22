#ifndef WOLVERINEREGDRIVERDEBUG_H
#define WOLVERINEREGDRIVERDEBUG_H

extern "C"
{
#include <wdm_user.h>
}

#include <stdint.h>
#include "wrapperregdriver.h"

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


// variant of WolverineRegDriver that uses AEGs instead of CSRs
// - cannot read registers while coprocessor is busy
// - useful for Convey Verilog simulation (since no CSR support there)
// - must call start() after all registers are set up

class WolverineRegDriverDebug : public WrapperRegDriver
{
public:
  virtual std::string platformID() {
		return "WolverineDebugDriver";
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
  }

  virtual void deattach() {
    // hack: do a write to register 0 to unset the busy flag
    writeReg(0, 2);
    // close firmware daemon connection and release coprocessor
    wdm_detach(m_coproc);
    wdm_release(m_coproc);
  }

  void start() {
    // do an instruction dispatch, should never return
    wdm_dispatch_t ds;
    memset((void *)&ds, 0, sizeof(ds));
    if (wdm_dispatch(m_coproc, &ds)) {
      throw "Dispatch error";
      return;
    }
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
    wdm_dispatch_t ds;
    memset((void *)&ds, 0, sizeof(ds));
    uint64_t reg = regValue;
    ds.ae[0].aeg_ptr_s = &reg;
    ds.ae[0].aeg_cnt_s = 1;
    ds.ae[0].aeg_base_s = regInd;
    if(wdm_aeg_write_read(m_coproc, &ds) != 0)
      throw "wdm_aeg_write_read failed in writeReg";
  }

  virtual AccelReg readReg(unsigned int regInd) {
    uint64_t ret;
    wdm_dispatch_t ds;
    memset((void *)&ds, 0, sizeof(ds));
    ds.ae[0].aeg_ptr_r = &ret;
    ds.ae[0].aeg_cnt_r = 1;
    ds.ae[0].aeg_base_r = regInd;
    if(wdm_aeg_write_read(m_coproc, &ds) != 0)
      throw "wdm_aeg_write_read failed in readReg";

    return (AccelReg) ret;
  }

protected:
  wdm_coproc_t m_coproc;

};

#endif // WOLVERINEREGDRIVERDEBUG_H
