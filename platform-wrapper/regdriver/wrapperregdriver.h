#ifndef WRAPPERREGDRIVER_H
#define WRAPPERREGDRIVER_H

// TODO wrapper driver should be a singleton

template <class T>
class WrapperRegDriver
{
public:
  // (optional) functions for host-accelerator buffer management
  virtual void copyBufferHostToAccel(void * hostBuffer, void * accelBuffer, unsigned int numBytes) {}
  virtual void copyBufferAccelToHost(void * accelBuffer, void * hostBuffer, unsigned int numBytes) {}
  virtual void * allocAccelBuffer(unsigned int numBytes) {return NULL;}
  virtual void deallocAccelBuffer(void * buffer) {}

protected:
  // (mandatory) register access methods for the platform wrapper
  virtual void writeReg(unsigned int regInd, T regValue) = 0;
  virtual T readReg(unsigned int regInd) = 0;


};

#endif // WRAPPERREGDRIVER_H
