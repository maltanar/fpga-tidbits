#include <iostream>
using namespace std;

#include "TestSum.hpp"
#include "platform.h"

bool Run_TestSum(WrapperRegDriver * platform, int upper) {
	TestSum t(platform);



	unsigned int * hostBuf = new unsigned int[upper];
	unsigned int bufsize = upper * sizeof(unsigned int);
	unsigned int golden = (upper*(upper+1))/2;

	for(unsigned int i = 0; i < upper; i++) { hostBuf[i] = i+1; }

	void * accelBuf = platform->allocAccelBuffer(bufsize);
	platform->copyBufferHostToAccel(hostBuf, accelBuf, bufsize);

	t.set_baseAddr((AccelDblReg) accelBuf);
	t.set_byteCount(bufsize);

	t.set_start(1);

	while(t.get_finished() != 1);

	platform->deallocAccelBuffer(accelBuf);
	delete [] hostBuf;

	AccelReg res = t.get_sum();
	unsigned int cc = t.get_cycleCount();
	t.set_start(0);
	return res == golden;
}

int main()
{


    int testPassed = 0;
    cout << "Running TestSum integration test ... " <<endl;
    for (int i = 0; i<100; i++) {
        WrapperRegDriver * platform = initPlatform();
        if (Run_TestSum(platform, i)) {
            testPassed++;
        } else{
            cout << "TestSum failed for i=" <<i <<endl;
            return -1;
        }

        deinitPlatform(platform);
    }

    cout << "Passed " <<testPassed <<" tests" <<endl;




	return 0;
}
