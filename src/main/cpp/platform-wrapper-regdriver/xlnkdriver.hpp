// adapted from the xlnk driver in BNN-PYNQ:
// https://github.com/Xilinx/BNN-PYNQ

/******************************************************************************
 *  Copyright (c) 2016, Xilinx, Inc.
 *  All rights reserved.
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
 * @file xlnkdriver.hpp
 *
 * Definition of the WrapperRegDriver methods for PYNQ
 *
 *
 *****************************************************************************/

#ifndef XLNKDRIVER_H
#define XLNKDRIVER_H

#include <cstring>
#include <map>

extern "C" {
#include <libxlnk_cma.h>
}

#include "wrapperregdriver.h"

void loadBitfile(const char * accelName);

class XlnkDriver : public WrapperRegDriver
{
public:
	XlnkDriver(uint32_t regBase, unsigned int regSize):
		m_regSize(regSize) {
		m_reg = reinterpret_cast<AccelReg*>(cma_mmap(regBase, regSize));
		if (!m_reg) throw "Failed to allocate registers";
	}

	virtual ~XlnkDriver() {
		for (PhysMap::iterator iter = m_physmap.begin(); iter != m_physmap.end(); ++iter) {
			cma_free(iter->second);
		}
		cma_munmap(m_reg, m_regSize);
	}

	virtual std::string platformID() {
		return "XlnkDriver";
	}

	virtual void copyBufferHostToAccel(void* hostBuffer, void* accelBuffer, unsigned int numBytes) {
		PhysMap::iterator iter = m_physmap.find(accelBuffer);
		if (iter == m_physmap.end()) {
			throw "Invalid buffer specified";
		}
		void* virt = iter->second;
		std::memcpy(virt, hostBuffer, numBytes);
	}

	virtual void copyBufferAccelToHost(void* accelBuffer, void* hostBuffer, unsigned int numBytes) {
		PhysMap::iterator iter = m_physmap.find(accelBuffer);
		if (iter == m_physmap.end()) {
			throw "Invalid buffer specified";
		}
		void* virt = iter->second;
		std::memcpy(hostBuffer, virt, numBytes);
	}

	virtual void* allocAccelBuffer(unsigned int numBytes) {
		void* virt = cma_alloc(numBytes, false);
		if (!virt) return 0;
		void* phys = reinterpret_cast<void*>(cma_get_phy_addr(virt));
		m_physmap.insert(std::make_pair(phys, virt));
		return phys;
	}

	virtual void deallocAccelBuffer(void* buffer) {
		PhysMap::iterator iter = m_physmap.find(buffer);
		if (iter == m_physmap.end()) {
			throw "Invalid pointer freed";
		}
		cma_free(iter->second);
		m_physmap.erase(iter);
	}

  // (optional) functions for accelerator attach-detach handling
  virtual void attach(const char * name) {
    // call loadBitfile, defined in platform*.cpp
    loadBitfile(name);
  }

  // (mandatory) register access methods for the platform wrapper
  virtual void writeReg(unsigned int regInd, AccelReg regValue) {
    m_reg[regInd] = regValue;
  }

  virtual AccelReg readReg(unsigned int regInd) {
    return m_reg[regInd];
  }

private:
	typedef std::map<void*, void*> PhysMap;
	PhysMap m_physmap;
	AccelReg* m_reg;
	uint32_t m_regSize;
};


#endif
