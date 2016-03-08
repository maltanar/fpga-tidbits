// header file defining the platform init-deinit functions
// include the appropriate platform-*.cpp file that implements
// these, and call initPlatform() at the start of your program to
// get a WrapperRegDriver handle

#ifndef PLATFORM_H_
#define PLATFORM_H_
#include "wrapperregdriver.h"

WrapperRegDriver * initPlatform();
void deinitPlatform(WrapperRegDriver * driver);


#endif /* PLATFORM_H_ */
