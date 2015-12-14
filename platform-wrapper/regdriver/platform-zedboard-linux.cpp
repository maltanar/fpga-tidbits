// platform init-deinit functions for Linux on the ZedBoard
// note that this assumes the peripheral lives at address 0x43c00000

#include "platform.h"
#include "linuxphysregdriver.hpp"

LinuxPhysRegDriver * platform = 0;

WrapperRegDriver * initPlatform() {
  if(!platform) {
    platform = new LinuxPhysRegDriver((void *) 0x43c00000);
  }
  return (WrapperRegDriver *) platform;
}

void deinitPlatform(WrapperRegDriver * driver) {
  // TODO doing a delete here causes the zedboard to go in a loop, debug this
}

