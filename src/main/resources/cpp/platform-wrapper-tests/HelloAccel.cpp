#include <iostream>
#include "platform.h"
#include "HelloAccel.hpp"
#include <string>

using namespace std;

int main() {
  WrapperRegDriver * platform = initPlatform();

  HelloAccel t(platform);

  cout << "Signature: " << hex << t.get_signature() << dec << endl;
  unsigned int op1, op2, res;

  while(true) {
    cin >> op1;
    cin >> op2;
    t.set_op1(op1);
    t.set_op2(op2);
    res = t.get_res();
    cout <<op1 <<" + " <<op2 << " = " <<res <<endl;
  }

  return 0;
}
