#include <iostream>
using namespace std;
#include <string.h>
#include "TestSeqWrite.hpp"
#include "platform.h"

bool Run_TestSeqWrite(WrapperRegDriver * platform) {
  TestSeqWrite t(platform);
  cout << "TestSeqWrite test" << endl;
  cout << "Signature: " << hex << t.get_signature() << dec << endl;
  unsigned int init, step, count;
  cout << "Enter init, step and count: " << endl;
  cin >> init >> step >> count;

  uint64_t * hostSrc = new uint64_t[count];
  unsigned int bufsize = count * sizeof(uint64_t);

  for(uint64_t i = 0; i < count; i++) { hostSrc[i] = init+step*i; }

  void * accelSrc = platform->allocAccelBuffer(bufsize);

  t.set_init(init);
  t.set_step(step);
  t.set_count(count);
  t.set_baseAddr((AccelDblReg) accelSrc);


  t.set_start(1);
  while(t.get_finished() != 1);

  uint64_t * hostDst = new uint64_t[count];
  platform->copyBufferAccelToHost(accelSrc, hostDst, bufsize);

  t.set_start(0);

  platform->deallocAccelBuffer(accelSrc);

  int res = memcmp(hostSrc, hostDst, bufsize);

  if(res != 0)
    for(uint64_t i = 0; i < count; i++) {
      cout << i << " " << hostSrc[i] << " " << hostDst[i] << endl;
    }

  delete [] hostSrc;
  delete [] hostDst;

  cout << "memcmp result: " << res << endl;

  return res == 0;
}

int main()
{
  WrapperRegDriver * platform = initPlatform();

  Run_TestSeqWrite(platform);

  deinitPlatform(platform);

  return 0;
}
