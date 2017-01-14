#include <iostream>
using namespace std;
#include <string.h>
#include "platform.h"

bool Run_TestHostCopy(WrapperRegDriver * platform) {
  platform->attach("TestHostCopy");
  cout << "HostCopy test" << endl;
  unsigned int ub = 0;
  cout << "Enter number of words to generate and copy: " << endl;
  cin >> ub;

  uint64_t * hostSrc = new uint64_t[ub];
  unsigned int bufsize = ub * sizeof(uint64_t);
  unsigned int golden = (ub*(ub+1))/2;

  for(uint64_t i = 0; i < ub; i++) { hostSrc[i] = i+1; }

  void * accelBuf = platform->allocAccelBuffer(bufsize);
  platform->copyBufferHostToAccel(hostSrc, accelBuf, bufsize);

  uint64_t * hostDst = new uint64_t[ub];
  platform->copyBufferAccelToHost(accelBuf, hostDst, bufsize);

  platform->deallocAccelBuffer(accelBuf);

  int res = memcmp(hostSrc, hostDst, bufsize);

  delete [] hostSrc;
  delete [] hostDst;

  cout << "memcmp result: " << res << endl;

  return res == 0;
}

int main()
{
  WrapperRegDriver * platform = initPlatform();

  Run_TestHostCopy(platform);

  deinitPlatform(platform);

  return 0;
}
