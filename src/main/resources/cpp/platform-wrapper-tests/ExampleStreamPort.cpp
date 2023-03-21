#include <iostream>
#include "platform.h"
#include "ExampleStreamPort.hpp"
#include <string>

using namespace std;

int main() {
  WrapperRegDriver * platform = initPlatform();

  ExampleStreamPort t(platform);

  cout << "Signature: " << hex << t.get_signature() << dec << endl;

  unsigned int val;
  while(true) {
    cin >> val;
    t.set_streamInPort_0_bits(val);
    t.set_streamInPort_0_valid(1);
    while (t.get_streamInPort_0_ready() != 1) {}
    cout << "Running sum: " <<t.get_sum() <<endl;
  }

  return 0;
}
