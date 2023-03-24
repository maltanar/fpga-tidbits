#include "platform.h"
#include "platform_s4noc.h"

wrapper_reg_driver_t * init_platform(void * arg) {
    wrapper_reg_driver_t * base = new wrapper_reg_driver_t();
    s4noc_reg_driver_t * driver = new s4noc_reg_driver_t();
    driver->node_id = (unsigned int) arg;
    driver->base = base;

    return driver;
}

void deinit_platform(wrapper_reg_driver_t* driver) {
    s4noc_reg_driver_t * s4noc = (s4noc_reg_driver_t *) driver;
    free(s4noc->base);
    free(s4noc);
}
