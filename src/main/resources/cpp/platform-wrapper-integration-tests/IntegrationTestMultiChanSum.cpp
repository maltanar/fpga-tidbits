#include <iostream>
using namespace std;

#include "ExampleMultiChanSum.hpp"
#include "platform.h"

bool Run_ExampleMultiChanSum(WrapperRegDriver * platform, uint ub, uint offs) {
	ExampleMultiChanSum t(platform);


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


	platform->deallocAccelBuffer(accBuf0);
	platform->deallocAccelBuffer(accBuf1);

	delete [] hostBuf0;
	delete [] hostBuf1;

	return (res0 == exp0) && (res1 == exp1);
}


int main(int argc, char **argv) {

   if (argc != 2) {
       cout << "Please pass the number of tests to run as the only command line argument" <<endl;
       return -1;
     }
     int n_tests = atoi(argv[1]);

  cout <<"Running ExampleMultiChanSum integration test with " <<n_tests <<" iterations ..." <<endl;


  WrapperRegDriver * platform = initPlatform();
  srand(time(NULL));

  int passed_tests = 0;

  uint32_t upper_bound, offset;

  for(int i = 0; i<n_tests; i++) {
    upper_bound = rand() % 100;
    offset = (uint16_t) rand();


	if(Run_ExampleMultiChanSum(platform, upper_bound, offset) != true) {
	    cout <<"ExampleMultiChanSum failed with ub=" <<upper_bound <<" offset=" <<offset <<endl;
	    return -1;
	} else {
	    passed_tests++;
	}
}

    cout <<"ExampleMultiChanSum passed " <<passed_tests <<" tests" <<endl;
	deinitPlatform(platform);
	return 0;

}
