#ifndef WRAPPERREGDRIVER_H
#define WRAPPERREGDRIVER_H

#include <stdint.h>
#include <string>

// TODO wrapper driver should be a singleton
typedef unsigned int AccelReg;
typedef uint64_t AccelDblReg;

class WrapperRegDriver
{
public:
  virtual ~WrapperRegDriver() {}
  // (optional) functions for host-accelerator buffer management
  virtual void copyBufferHostToAccel(void * hostBuffer, void * accelBuffer, unsigned int numBytes) {}
  virtual void copyBufferAccelToHost(void * accelBuffer, void * hostBuffer, unsigned int numBytes) {}
  virtual void * allocAccelBuffer(unsigned int numBytes) { throw "allocAccelBuffer not supported"; }
  virtual void deallocAccelBuffer(void * buffer) {}
  // return CPU-accessible address for a buffer returned from allocAccelBuffer
  // only makes sense for some (shared-memory) platforms
  // facilitates SW that takes advantage of cache coherency
  virtual void * phys2virt(void * accelBuffer) { throw "phys2virt not supported"; }
  virtual bool is_coherent() { return false; }

  // (optional) functions for accelerator attach-detach handling
  virtual void attach(const char * name) {}
  virtual void detach() {}

  // (mandatory) register access methods for the platform wrapper
  virtual void writeReg(unsigned int regInd, AccelReg regValue) = 0;
  virtual AccelReg readReg(unsigned int regInd) = 0;
  virtual std::string platformID() = 0;

};

#endif // WRAPPERREGDRIVER_H
