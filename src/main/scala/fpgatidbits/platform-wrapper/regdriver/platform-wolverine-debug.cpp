// platform init-deinit functions for the Convey Wolverine WX690T
// debug variant using the AEG registers

#include "platform.h"
#include "wolverineregdriverdebug.hpp"

WolverineRegDriverDebug * platform = 0;

WrapperRegDriver * initPlatform() {
  if(!platform) {
    platform = new WolverineRegDriverDebug();
  }
  return (WrapperRegDriver *) platform;
}

void deinitPlatform(WrapperRegDriver * driver) {
  (void) driver;
  delete platform;
}
