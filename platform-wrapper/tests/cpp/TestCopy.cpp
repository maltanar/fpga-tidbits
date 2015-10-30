#include <iostream>
using namespace std;
#include <string.h>
#include "TestCopy.hpp"
#include "platform.h"

bool Run_TestCopy(WrapperRegDriver * platform) {
  TestCopy t(platform);
  cout << "TestCopy test" << endl;
  cout << "Signature: " << hex << t.get_signature() << dec << endl;
  unsigned int ub = 0;
  cout << "Enter number of words to generate and copy: " << endl;
  cin >> ub;

  uint64_t * hostSrc = new uint64_t[ub];
  unsigned int bufsize = ub * sizeof(uint64_t);
  unsigned int golden = (ub*(ub+1))/2;

  for(uint64_t i = 0; i < ub; i++) { hostSrc[i] = i+1; }

  void * accelSrc = platform->allocAccelBuffer(bufsize);
  platform->copyBufferHostToAccel(hostSrc, accelSrc, bufsize);

  void * accelDst = platform->allocAccelBuffer(bufsize);

  t.set_srcAddr((AccelDblReg) accelSrc);
  t.set_dstAddr((AccelDblReg) accelDst);
  t.set_byteCount(bufsize);

  t.set_start(1);

  while(t.get_finished() != 1);

  uint64_t * hostDst = new uint64_t[ub];
  platform->copyBufferAccelToHost(accelDst, hostDst, bufsize);

  t.set_start(0);

  platform->deallocAccelBuffer(accelSrc);
  platform->deallocAccelBuffer(accelDst);

  int res = memcmp(hostSrc, hostDst, bufsize);

  delete [] hostSrc;
  delete [] hostDst;

  cout << "memcmp result: " << res << endl;

  return res == 0;
}

int main()
{
  WrapperRegDriver * platform = initPlatform();

  Run_TestCopy(platform);

  deinitPlatform(platform);

  return 0;
}
