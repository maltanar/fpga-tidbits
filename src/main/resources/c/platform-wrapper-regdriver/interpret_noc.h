#ifndef INTERPRET_NOC_H
#define INTERPRET_NOC_H

#include <stdint.h>
#include <flexpret_types.h>

// A 32 bit header which is always sent first
typedef struct {
  unsigned int write : 1;
  unsigned int port : 14;     // 14 bits for the package type
  unsigned int length : 14;  // 14 bits for the package length
  unsigned int flags : 3;    // 3 bits for package flags
} noc_header_t;

#define NOC_HEADER_INIT(write, port, length, flags) { .write=write, .port=port, .length=length, .flags=flags }
#define NOC_HEADER_INIT_WRITE_REG(port) NOC_HEADER_INIT(1,port,0,0)
#define NOC_HEADER_INIT_READ_REG(port) NOC_HEADER_INIT(0,port,0,0) 
#define NOC_HEADER_INIT_WRITE_ARR(port, length) NOC_HEADER_INIT(1,port,length,0) 

/**
 * @brief Send a word over the NoC. Depending on the value of the timeout, the 
 * function will exhibit a different behavior:
 *  * Blocking send is performed if timeout value is TIMEOUT_FOREVER,
 *  * Non blocking send is performed if the timeout value is TIMEOUT_NEVER,
 *  * And send within the given timeout, otherwise.
 *
 * @param addr: id of the core to send to
 * @param data: The data value to send
 * @param timeout: the timeout in ns
 *
 * @return fp_ret_t: FP_SUCCESS, if sending is successful, FP_FAILIURE otherwise
 **/
fp_ret_t noc_send(uint32_t addr, uint32_t data);


/**
 * Receive a word over the NoC. Depending on the value of the timeout, the function
 * will exhibit a different behavior:
 *  * Blocking receive is performed if timeout value is TIMEOUT_FOREVER,
 *  * Non blocking receive is performed if the timeout value is TIMEOUT_NEVER,
 *  * And receive within the given timeout, otherwise.
 *
 * @param data: pointer to where the data will be written, if any
 * @param timeout: the timeout in ns
 * FIXME: Should the data type be passed as well?
 *
 * @return fp_ret_t: FP_SUCCESS, if sending is successful, FP_FAILIURE otherwise
 **/
fp_ret_t noc_receive(uint32_t* data);


#endif
