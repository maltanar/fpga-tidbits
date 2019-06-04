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
	XlnkDriver(uint32_t regBase, unsigned int regSize, bool assume_coherency = false):
		m_regSize(regSize), m_assume_coherency(assume_coherency) {
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

	virtual bool is_coherent() {
		return m_assume_coherency;
	}

	virtual void * phys2virt(void * accelBuffer) {
		// the assume_coherency flag doesn't really "do" anything, it's mostly
		// there as a safety net to warn the user if they are using the non-CC
		// variant of the platform (PYNQU96 instead of PYNQU96CC)
		if(!m_assume_coherency) {
			throw "Coherency not enabled for XlnkDriver, you should not use phys2virt";
		}
		return m_physmap[accelBuffer];
	}

	virtual void copyBufferHostToAccel(void* hostBuffer, void* accelBuffer, unsigned int numBytes) {
		for(PhysMap::iterator iter = m_physmap.begin(); iter != m_physmap.end(); ++iter) {
			uint64_t phys_base = (uint64_t) iter->first;
			uint64_t virt_base = (uint64_t) iter->second;
			size_t alloc_size = m_physmap_size[iter->first];
			uint64_t query = (uint64_t) accelBuffer;
			if( (phys_base <= query) && ((query + numBytes) <= (phys_base + alloc_size)) ) {
				uint64_t offset = query - phys_base;
				void * accelBuffer = (void*)(virt_base + offset);
				std::memcpy(accelBuffer, hostBuffer, numBytes);
				return;
			}
		}
		throw "Invalid buffer specified";
	}

	virtual void copyBufferAccelToHost(void* accelBuffer, void* hostBuffer, unsigned int numBytes) {
		for(PhysMap::iterator iter = m_physmap.begin(); iter != m_physmap.end(); ++iter) {
			uint64_t phys_base = (uint64_t) iter->first;
			uint64_t virt_base = (uint64_t) iter->second;
			size_t alloc_size = m_physmap_size[iter->first];
			uint64_t query = (uint64_t) accelBuffer;
			if( (phys_base <= query) && ((query + numBytes) <= (phys_base + alloc_size)) ) {
				uint64_t offset = query - phys_base;
				void * accelBuffer = (void*)(virt_base + offset);
				std::memcpy(hostBuffer, accelBuffer, numBytes);
				return;
			}
		}
		throw "Invalid buffer specified";
	}

	virtual void* allocAccelBuffer(unsigned int numBytes) {
		void* virt = cma_alloc(numBytes, false);
		if (!virt) return 0;
		void* phys = reinterpret_cast<void*>(cma_get_phy_addr(virt));
		m_physmap.insert(std::make_pair(phys, virt));
		m_physmap_size.insert(std::make_pair(phys, numBytes));
		return phys;
	}

	virtual void deallocAccelBuffer(void* buffer) {
		PhysMap::iterator iter = m_physmap.find(buffer);
		if (iter == m_physmap.end()) {
			throw "Invalid pointer freed";
		}
		cma_free(iter->second);
		m_physmap.erase(iter);
		m_physmap_size.erase(iter->first);
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
	typedef std::map<void*, size_t> PhysMapSize;
	PhysMap m_physmap;
	PhysMapSize m_physmap_size;
	AccelReg* m_reg;
	uint32_t m_regSize;
	bool m_assume_coherency;
};


#endif
