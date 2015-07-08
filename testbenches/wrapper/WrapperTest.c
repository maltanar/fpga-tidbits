#include <iostream>
#include <assert.h>
// needed for cache disable/flush functions
// CPU and accelerator won't see same data otherwise
#include "xil_cache.h"
using namespace std;

// base pointer to device CSR
volatile unsigned int * deviceRegs = (volatile unsigned int *) 0x40000000;
// base pointer for memory read/write tests
unsigned int * baseP = (unsigned int *) 0x10000000;

void runTest_multiChanWrites() {
	for(int c=0; c<3; c++) {
		for(int i=0; i<1024; i++) {
			baseP[c*1024+i] = i + (c*10);
		}
		deviceRegs[2 + 3*c + 0] = (unsigned int) &baseP[c*1024];
		deviceRegs[2 + 3*c + 1] = 1024*4;
	}

	cout << "Status prior to exec: " << deviceRegs[1] << endl;
	deviceRegs[0] = 1;

	while(deviceRegs[1] == 0);

	cout << "Status after exec: " << deviceRegs[1] << endl;
	for(int c=0; c<3; c++) {
		cout << "Sum " << c << " = " << deviceRegs[2+3*c+2] << endl;
	}
}

void runTest_write() {
	cout << "Signature: " << hex << deviceRegs[0] << dec << endl;
	assert(deviceRegs[0] = 0xfeedbead);

	// clear our write buffer
	for(int i = 0; i < 1024; i++) {
		baseP[i] = 0;
	}

	// set up device regs
	deviceRegs[2] = (unsigned int) baseP;
	deviceRegs[3] = 1024*4;

	cout << "Status prior to exec: " << deviceRegs[4] << endl;
	deviceRegs[1] = 1;

	while(deviceRegs[4] == 0);

	cout << "Status after exec: " << deviceRegs[4] << endl;

	int errs=0;
	for(int i = 0; i < 1024; i++) {
		if(baseP[i] != (unsigned int)i+1) {
			cout << i << " = " << baseP[i] << endl;
			errs++;
		}
	}
	cout << "Errors: " << errs << endl;
}

void printCounters() {
	cout << "Read requests: " << deviceRegs[5] << endl;
	cout << "Read responses: " << deviceRegs[8] << endl;
	cout << "Write requests: " << deviceRegs[6] << endl;
	cout << "Write data: " << deviceRegs[7] << endl;
	cout << "Write responses: " << deviceRegs[9] << endl;
}

void runTest_OCMController() {
	cout << "Signature: " << hex << deviceRegs[0] << dec << endl;
	assert(deviceRegs[0] = 0x0c0c0c0c);

	cout << "Status: " << hex << deviceRegs[2] << dec << endl;
	printCounters();

	unsigned long long * readBuffer = (unsigned long long *) baseP;
	unsigned long long * writeBuffer = &readBuffer[2048];

	for(unsigned long long i =0; i < 1024; i++) {
		readBuffer[i] = i;
		writeBuffer[i] = 0;
	}

	cout << "Size: " << 1024*sizeof(unsigned long long) << endl;

	deviceRegs[3] = (unsigned int) readBuffer;
	deviceRegs[4] = (unsigned int) writeBuffer;
	deviceRegs[1] = 1;

	while(deviceRegs[2] != 9);
	cout << "Fill completed, status: " << deviceRegs[2] << endl;

	printCounters();

	deviceRegs[1] = 0;
	cout << "Cleared command, status: " << deviceRegs[2] << endl;

	cout << "======Starting Dump======="<< endl;
	//char x;
	//cin >> x;
	deviceRegs[1] = 3;

	while(deviceRegs[2] != 7) {cout << "Status:" << deviceRegs[2] << endl;};
	cout << "Status:" << deviceRegs[2] << endl;

	printCounters();

	int diffs=0;
	for(int i =0; i < 1024; i++) {
		//cout << i << " " << readBuffer[i] << " " << writeBuffer[i] << endl;
		if(readBuffer[i] != writeBuffer[i])
			diffs++;
	}

	cout << "Diffs = " << diffs << endl;
}

int main()
{
	Xil_DCacheDisable();

	cout << "Hello World!" << endl;

	// TODO call appropriate wrapper test function based on deviceRegs[0] signature
	runTest_OCMController();

	return 0;
}


