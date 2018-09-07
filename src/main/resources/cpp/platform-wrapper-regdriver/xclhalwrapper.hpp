/******************************************************************************
 *  Copyright (c) 2018, Xilinx, Inc.
 *  All rights reserved.
 *  Author: Yaman Umuroglu
 *
 *  Redistribution and use in source and binary forms, with or without
 *  modification, are permitted provided that the following conditions are met:
 *
 *  1.  Redistributions of source code must retain the above copyright notice,
 *     this list of conditions and the following disclaimer.
 *
 *  2.  Redistributions in binary form must reproduce the above copyright
 *      notice, this list of conditions and the following disclaimer in the
 *      documentation and/or other materials provided with the distribution.
 *
 *  3.  Neither the name of the copyright holder nor the names of its
 *      contributors may be used to endorse or promote products derived from
 *      this software without specific prior written permission.
 *
 *  THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS "AS IS"
 *  AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO,
 *  THE IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR
 *  PURPOSE ARE DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT HOLDER OR
 *  CONTRIBUTORS BE LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL,
 *  EXEMPLARY, OR CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT LIMITED TO,
 *  PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES; LOSS OF USE, DATA, OR PROFITS;
 *  OR BUSINESS INTERRUPTION). HOWEVER CAUSED AND ON ANY THEORY OF LIABILITY,
 *  WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT (INCLUDING NEGLIGENCE OR
 *  OTHERWISE) ARISING IN ANY WAY OUT OF THE USE OF THIS SOFTWARE, EVEN IF
 *  ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
 *
 *****************************************************************************/
/******************************************************************************
 *
 *
 * @file xclhalwrapper.hpp
 *
 * implement WrapperRegDriver calls using xclhal2
 *
 *
 *****************************************************************************/
#ifndef XCLHALWRAPPER_H
#define XCLHALWRAPPER_H

#include "wrapperregdriver.h"
#include <xclhal2.h>
#include <cassert>
#include <iostream>

using namespace std;

void loadBitfile(const char * accelName);

class XCLHalWrapperRegDriver : public WrapperRegDriver {
public:
  XCLHalWrapperRegDriver() {}
  virtual ~XCLHalWrapperRegDriver() {}

  virtual std::string platformID() {
		return "XCLHalWrapperRegDriver";
	}

  virtual void copyBufferHostToAccel(void* hostBuffer, void* accelBuffer, unsigned int numBytes) {
    const uint64_t dram_offset = (uint64_t) accelBuffer;
    int nret = xclUnmgdPwrite(m_device, 0, hostBuffer, numBytes, dram_offset);
    assert(nret >= 0);
	}

	virtual void copyBufferAccelToHost(void* accelBuffer, void* hostBuffer, unsigned int numBytes) {
    const uint64_t dram_offset = (uint64_t) accelBuffer;
    int nret = xclUnmgdPread(m_device, 0, hostBuffer, numBytes, dram_offset);
    assert(nret >= 0);
	}

	virtual void* allocAccelBuffer(unsigned int numBytes) {
    // TODO need to cater for aligned alloc here?
    uint64_t ret = xclAllocDeviceBuffer2(
      m_device, numBytes, XCL_MEM_DEVICE_RAM, XCL_DEVICE_RAM_BANK0
    );
    assert(ret != 0xffffffffffffffffL);
    return (void *) ret;
	}

	virtual void deallocAccelBuffer(void* buffer) {
    xclFreeDeviceBuffer(m_device, (uint64_t)buffer);
	}

  // (optional) functions for accelerator attach-detach handling
  virtual void attach(const char * name) {
    // make sure there is at least one device available
    assert(xclProbe() >= 1);
    // open and get exclusive access to the device
    m_device = xclOpen(0, "xcl.log", XCL_QUIET);
    xclLockDevice(m_device);
    // set the clock frequency if FCLK_MHZ was defined
#ifdef FCLK_MHZ
    const unsigned short targetFreqMHz[4] = {FCLK_MHZ, FCLK_MHZ, 0, 0};
    xclReClock2(m_device, 0, targetFreqMHz);
#endif
    // load the xclbin contents into memory
    int n_i0 = load_file_to_memory(name, (char **) &m_kernelbinary);
    assert(n_i0 >= 0);
    // load the xclbin into the device
    int xclbin_ret = xclLoadXclBin(m_device, (const xclBin *)m_kernelbinary);
    assert(xclbin_ret == 0);
  }

  virtual void detach() {
    xclUnlockDevice(m_device);
    xclClose(m_device);
    free(m_kernelbinary);
  }

  // (mandatory) register access methods for the platform wrapper
  virtual void writeReg(unsigned int regInd, AccelReg regValue) {
    const uint64_t reg_offset = regInd * sizeof(AccelReg);
    size_t nret = xclWrite(
      m_device, m_csr_addrspace, m_csr_base + reg_offset, (void*)&regValue,
      sizeof(AccelReg)
    );
    assert(nret == sizeof(AccelReg));
  }

  virtual AccelReg readReg(unsigned int regInd) {
    const uint64_t reg_offset = regInd * sizeof(AccelReg);
    uint32_t ret = 0;
    size_t nret = xclRead(m_device, m_csr_addrspace, m_csr_base + reg_offset, (void*)&ret, 4);
    assert(nret == 4);
    return ret;
  }

protected:
  xclDeviceHandle m_device;
  unsigned char * m_kernelbinary;
  const unsigned long long int m_csr_base = CSR_BASE_ADDR;
  const xclAddressSpace m_csr_addrspace = XCL_ADDR_KERNEL_CTRL; // XCL_ADDR_KERNEL_CTRL

  int load_file_to_memory(const char *filename, char **result)
  {
      uint size = 0;
      FILE *f = fopen(filename, "rb");
      if (f == NULL) {
          *result = NULL;
          return -1;
      }
      fseek(f, 0, SEEK_END);
      size = ftell(f);
      fseek(f, 0, SEEK_SET);
      // allocate enough memory to hold the xclbin
      *result = (char *)malloc(size+1);
      if (size != fread(*result, sizeof(char), size, f)) {
          free(*result);
          return -2;
      }
      fclose(f);
      (*result)[size] = 0;
      return size;
  }
};

#endif // XCLHALWRAPPER_H
