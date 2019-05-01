// platform init-deinit functions for the TesterWrapper
// note that this assumes the peripheral lives at address 0x43c00000

#include "platform.h"
#include "verilatedtesterdriver.hpp"

VerilatedTesterRegDriver * platform = 0;

WrapperRegDriver * initPlatform() {
  if(!platform) {
    platform = new VerilatedTesterRegDriver(); // real setup done inside attach()
  }
  return (WrapperRegDriver *) platform;
}

void deinitPlatform(WrapperRegDriver * driver) {
  if(platform) {
    delete platform;
    platform = 0;
  }
}
