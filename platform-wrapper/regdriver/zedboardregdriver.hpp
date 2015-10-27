#ifndef ZEDBOARDREGDRIVER_H
#define ZEDBOARDREGDRIVER_H

#include "axiregdriver.hpp"
#include <string.h>
#include <stdlib.h>
#include "xil_cache.h"

class ZedBoardRegDriver :  public AXIRegDriver {
public:
  ZedBoardRegDriver(void *baseAddr) : AXIRegDriver(baseAddr) {}

  // functions for host-accelerator buffer management
  virtual void copyBufferHostToAccel(void * hostBuffer, void * accelBuffer, unsigned int numBytes) {
    memcpy(accelBuffer, hostBuffer, numBytes);
    Xil_DCacheFlushRange((unsigned int) accelBuffer, numBytes);
  }

  virtual void copyBufferAccelToHost(void * accelBuffer, void * hostBuffer, unsigned int numBytes) {
    Xil_DCacheInvalidateRange((unsigned int) accelBuffer, numBytes);
    memcpy(hostBuffer,accelBuffer, numBytes);
  }

  virtual void * allocAccelBuffer(unsigned int numBytes) { return malloc(numBytes);}
  virtual void deallocAccelBuffer(void * buffer) { free(buffer);}
};

#endif
