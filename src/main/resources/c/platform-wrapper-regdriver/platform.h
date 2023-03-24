#ifndef PLATFORM_H
#define PLATFORM_H


#include "wrapper_reg_driver.h"

wrapper_reg_driver_t * init_platform(void * arg);
void deinit_platform(wrapper_reg_driver_t* driver);

#endif
