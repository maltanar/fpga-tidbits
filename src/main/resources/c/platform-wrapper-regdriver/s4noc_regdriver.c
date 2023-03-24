#include "platform_s4noc.h"
#include "wrapper_reg_driver.h"
#include "interpret_noc.h"


void write_reg(wrapper_reg_driver_t *_self, unsigned int reg_idx, accel_reg_t reg_value) {
    s4noc_reg_driver_t * self = (s4noc_reg_driver_t *) _self;
    noc_header_t header = NOC_HEADER_INIT_WRITE_REG(reg_idx);
    noc_send(self->node_id, (uint32_t) noc_header_t);
    noc_send(self->node_id, reg_value);
}

accel_reg_t read_reg(unsigned int node_idx, unsigned int reg_idx) {
    s4noc_reg_driver_t * self = (s4noc_reg_driver_t *) _self;
    noc_header_t header = NOC_HEADER_INIT_READ_REG(reg_idx);
    noc_send(self->node_id, (uint32_t) noc_header_t);
    noc_send(self->node_id, reg_value);
    uint32_t recv;
    noc_receive(&recv);
    return recv;
}

const char * platform_id() {
    return "S4NOC";
}

void write_arr(wrapper_reg_driver_t *self, unsigned int reg_idx,
               accel_reg_t *reg_value, size_t size) {

    s4noc_reg_driver_t * self = (s4noc_reg_driver_t *) _self;
    noc_header_t header = NOC_HEADER_INIT_WRITE_ARR(reg_idx, size);
    noc_send(self->node_id, (uint32_t) noc_header_t);
    
    for (int i = 0; i<size; i++) {
        noc_send(reg_idx, reg_value[i]);
    }
}

void write_stream_start(wrapper_reg_driver_t *self, unsigned int reg_idx) {
    assert(false);
}

void write_stream(wrapper_reg_driver_t *self, accel_reg_t val) {
    assert(false);
}

void write_stream_stop(wrapper_reg_driver_t *self, unsigned int reg_idx) {
    assert(false);
}