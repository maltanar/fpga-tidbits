#include <iostream>
using namespace std;

#include "TestMultiChanSum.hpp"
#include "platform.h"

bool Run_TestMultiChanSum(WrapperRegDriver * platform) {
	TestMultiChanSum t(platform);

	cout << "Signature: " << hex << t.get_signature() << dec << endl;
	unsigned int ub = 0, offs = 0;
	cout << "Enter upper bound of sum and channel 1 const offset: " << endl;
	cin >> ub >> offs;

	unsigned int * hostBuf0 = new unsigned int[ub];
	unsigned int * hostBuf1 = new unsigned int[ub];
	unsigned int bufsize = ub * sizeof(unsigned int);

	for(unsigned int i = 0; i < ub; i++) {hostBuf0[i] = i+1; hostBuf1[i] = i+1 + offs;}

	void * accBuf0 = platform->allocAccelBuffer(bufsize);
	void * accBuf1 = platform->allocAccelBuffer(bufsize);

	platform->copyBufferHostToAccel((void *) hostBuf0, accBuf0, bufsize);
	platform->copyBufferHostToAccel((void *) hostBuf1, accBuf1, bufsize);

	t.set_byteCount_0(bufsize);  t.set_byteCount_1(bufsize);
	t.set_baseAddr_0((AccelDblReg) accBuf0); t.set_baseAddr_1((AccelDblReg) accBuf1);

	t.set_start(1);

	while(t.get_status() != 1);

	unsigned int res0 = t.get_sum_0();	unsigned int res1 = t.get_sum_1();
	unsigned int exp0 = (ub*(ub+1))/2; unsigned int exp1 = exp0 + ub*offs;

	t.set_start(0);

	cout << "Chan 0 sum = " << res0 << " expected = " << exp0 << endl;
	cout << "Chan 1 sum = " << res1 << " expected = " << exp1 << endl;

	platform->deallocAccelBuffer(accBuf0);
	platform->deallocAccelBuffer(accBuf1);

	delete [] hostBuf0;
	delete [] hostBuf1;

	return (res0 == exp0) && (res1 == exp1);
}

int main()
{
	WrapperRegDriver * platform = initPlatform();

	Run_TestMultiChanSum(platform);

	deinitPlatform(platform);

	return 0;
}
