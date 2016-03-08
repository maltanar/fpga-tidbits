// platform init-deinit functions for the Convey Wolverine WX690T

#include "platform.h"
#include "wolverineregdriver.hpp"

WolverineRegDriver * platform = 0;

WrapperRegDriver * initPlatform() {
  if(!platform) {
    platform = new WolverineRegDriver();
  }
  return (WrapperRegDriver *) platform;
}

void deinitPlatform(WrapperRegDriver * driver) {
  (void) driver;
  delete platform;
}
