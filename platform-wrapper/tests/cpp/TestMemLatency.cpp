#include <iostream>
#include <stdint.h>
using namespace std;

#include "TestMemLatency.hpp"
#include "platform.h"

// issue a number of 8-beat bursts, with a parametrizable number of outstanding
// memory requests. the memory latency can be estimated from the number of
// cycles it takes per word; when the cycles/word is approx TODO, the latency
// is completely hidden by outstanding requests
// thus, the minimum # of outstanding reqs (OMR) that hides the latency can
// be used to estimate the average latency as L = OMR * 8
// (since the accelerator uses 8-beat bursts)

bool Run_TestMemLatency(WrapperRegDriver * platform) {
	TestMemLatency t(platform);

	cout << "Signature: " << hex << t.get_signature() << dec << endl;

	while(1) {
		unsigned int omr = 16;
		cout << "Enter # of outstanding mem requests (max 16, 0 to exit):" << endl;
		cin >> omr;

		if(omr == 0) break;

		unsigned int ub = 0;
		cout << "Enter upper bound of sum (divisable by 8): " << endl;
		cin >> ub;

		typedef uint64_t AccelWord;
		AccelWord * hostBuf = new AccelWord[ub];
		unsigned int bufsize = ub * sizeof(AccelWord);
		unsigned int golden = (ub*(ub+1))/2;

		for(unsigned int i = 0; i < ub; i++) { hostBuf[i] = i+1; }

		void * accelBuf = platform->allocAccelBuffer(bufsize);
		platform->copyBufferHostToAccel(hostBuf, accelBuf, bufsize);

		t.set_baseAddr((AccelDblReg) accelBuf);
		t.set_byteCount(bufsize);

		// set # outstanding mem requests and pulse doInit to reinitialize pool
		t.set_initCount(omr);
		t.set_doInit(1);
		t.set_doInit(0);

		t.set_start(1);

		while(t.get_finished() != 1);

		platform->deallocAccelBuffer(accelBuf);
		delete [] hostBuf;

		AccelReg res = t.get_sum();
		cout << "Result = " << res << " expected " << golden << endl;
		unsigned int cc = t.get_cycleCount();
		cout << "#cycles = " << cc << " cycles per word = " << (float)cc/(float)ub << endl;
		t.set_start(0);
	}

	return true;
}

int main()
{
	WrapperRegDriver * platform = initPlatform();

	Run_TestMemLatency(platform);

	deinitPlatform(platform);

	return 0;
}
