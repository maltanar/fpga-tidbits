#ifndef WOLVERINEREGDRIVER_H
#define WOLVERINEREGDRIVER_H

#include <stdint.h>
#include "wrapperregdriver.h"
#include "libcnyfwd.h"

typedef uint64_t AccelReg;

// TODO add error checks on all cny_fwd* functions

class WolverineRegDriver : public WrapperRegDriver<AccelReg>
{
protected:
    // (mandatory) register access methods for the platform wrapper
    virtual void writeReg(unsigned int regInd, AccelReg regValue) {
        // TODO support finer-grained writes by adjusting mask
        cny_fwd_write("aemc0", 0x30000 + 0x8 * regInd, regValue, 0xffffffffffffffff);
    }

    virtual AccelReg readReg(unsigned int regInd) {
        AccelReg ret;
        cny_fwd_read("aemc0", 0x30000 + 0x8*regInd, &ret);
        return ret;
    }

    // (optional) functions to ensure coherency across host-accelerator
    // TODO

    // (optional) functions to initialize and deinitialize the wrapper
    virtual bool initialize() {
        cny_fwd_open();
        cny_fwd_cmd("fpga sca aemc0 1\n", 0, NULL, NULL);
    }
    virtual bool deinitialize() {
        cny_fwd_close();
    }

};

#endif // WOLVERINEREGDRIVER_H
