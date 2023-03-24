#ifndef WRAPPER_REG_DRIVER_H
#define WRAPPER_REG_DRIVER_H

#include "platform-s4noc.h"

typedef int wrapper_reg_driver_t;
typedef accel_reg_t unsigned int;
typedef accel_dbl_reg_t uint64_t;

void write_reg(wrapper_reg_driver_t *self, unsigned int reg_idx,
               accel_reg_t reg_value);

accel_reg_t read_reg(wrapper_reg_driver_t *self, , unsigned int reg_idx);

void write_arr(wrapper_reg_driver_t *self, unsigned int reg_idx,
               accel_reg_t *reg_value, size_t size);

void write_stream_start(wrapper_reg_driver_t *self, unsigned int reg_idx);
void write_stream(wrapper_reg_driver_t *self, accel_reg_t val);
void write_stream_stop(wrapper_reg_driver_t *self, unsigned int reg_idx);

               
const char *platform_id();

#endif