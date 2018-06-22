// platform init-deinit functions for the ZedBoard
// note that this assumes the peripheral lives at address 0x43c00000

#include "platform.h"
#include "zedboardregdriver.hpp"

ZedBoardRegDriver * platform = 0;

WrapperRegDriver * initPlatform() {
  if(!platform) {
    platform = new ZedBoardRegDriver((void *) 0x43c00000);
  }
  return (WrapperRegDriver *) platform;
}

void deinitPlatform(WrapperRegDriver * driver) {
  // TODO doing a delete here causes the zedboard to go in a loop, debug this
}
