#include <iostream>
#include <assert.h>
#include "xil_cache.h"
using namespace std;

#include "WrapperTestSumDriver.hpp"
#include "WrapperTestMultiChanSumDriver.hpp"

volatile unsigned int * deviceRegs = (volatile unsigned int *) 0x40000000;
unsigned int * baseP = (unsigned int *) 0x10000000;

void runTest_Sum() {
	WrapperTestSumDriver drv(deviceRegs);

	cout << "Sum before = " << drv.sum() << endl;
	drv.op_0(2001);
	drv.op_1(2002);
	cout << "Sum after = " << drv.sum() << endl;

	if(drv.sum() == drv.op_0() + drv.op_1())
		cout << "Successfully completed" << endl;
	else
		cout << "Incorrect sum" << endl;
}

void runTest_multiChanSum() {
	WrapperTestMultiChanSumDriver drv(deviceRegs);

	cout << "Initializing sum buffers" << endl;

	// TODO do not hardcode for 3 channels
	for(int c=0; c<3; c++) {
		for(int i=0; i<1024; i++) {
			baseP[c*1024+i] = i + 1 + (c*10);
		}
		deviceRegs[2 + 3*c + 0] = (unsigned int) &baseP[c*1024];
		deviceRegs[2 + 3*c + 1] = 1024*4;
	}

	drv.baseAddr_0((unsigned int) &baseP[0*1024]);
	drv.baseAddr_1((unsigned int) &baseP[1*1024]);
	drv.baseAddr_2((unsigned int) &baseP[2*1024]);

	drv.byteCount_0(1024*4);
	drv.byteCount_1(1024*4);
	drv.byteCount_2(1024*4);

	cout << "Status prior to exec: " << drv.status() << endl;

	drv.start(1);

	while(drv.status() == 0);

	cout << "Status after exec: " << drv.status() << endl;

	cout << "Sum 0: " << drv.sum_0() << endl;
	cout << "Sum 1: " << drv.sum_1() << endl;
	cout << "Sum 2: " << drv.sum_2() << endl;
}

int main()
{
	Xil_DCacheDisable();

	cout << "Hello World!" << endl;

	// TODO call appropriate wrapper test function based on deviceRegs[0] signature
	//runTest_Sum();
	runTest_multiChanSum();

	return 0;
}
