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
 * @file platform-xlnk.cpp
 *
 * Definition of the platform init-deinit functions, assumes cache coherency
 * Call initPlatform() at the start of your program to
 * get a WrapperRegDriver handle
 *
 *
 *****************************************************************************/
#include <cstring>
#include <iostream>

#include <signal.h>

#include "platform.h"
#include "xlnkdriver.hpp"

extern "C" {
  #include <unistd.h>
  #include <sys/types.h>
  #include <sys/wait.h>
  #include <stdlib.h>
}

static XlnkDriver* platform = 0;

void platformSIGINTHandler(int signum) {
	std::cout << "Caught SIGINT, forcing exit" << std::endl;
	if(platform) {
		platform->detach();
	}
	delete platform;
	exit(1);
}

WrapperRegDriver* initPlatform() {
	if (!platform) {
		platform = new XlnkDriver(0xa0000000, 64 * 1024, true);
	}

	struct sigaction action;
	std::memset(&action, 0, sizeof(struct sigaction));
	action.sa_handler = &platformSIGINTHandler;
	int res = sigaction(SIGINT, &action, NULL);

	return static_cast<WrapperRegDriver*>(platform);
}

void deinitPlatform(WrapperRegDriver* driver) {
	delete platform;
	platform = 0;
}

void loadBitfile(const char* accelName) {
  // TODO add bitfile loader here, if desired
}
