// platform init-deinit functions for the TesterWrapper
// note that this assumes the peripheral lives at address 0x43c00000

#include "platform.h"
#include "testerdriver.hpp"

TesterRegDriver * platform = 0;

WrapperRegDriver * initPlatform() {
  if(!platform) {
    platform = new TesterRegDriver(); // real setup done inside attach()
  }
  return (WrapperRegDriver *) platform;
}

void deinitPlatform(WrapperRegDriver * driver) {
  // TODO deinit tester?
}
