#include <iostream>
using namespace std;

#include "ExampleRegOps.hpp"
#include "platform.h"

bool Run_ExampleRegOps(WrapperRegDriver * platform) {
  ExampleRegOps t(platform);

  cout << "Signature: " << hex << t.get_signature() << dec << endl;
  cout << "Enter two operands to sum: ";
  unsigned int a, b;
  cin >> a >> b;

  t.set_op_0(a);
  t.set_op_1(b);

  cout << "Result: " << t.get_sum() << " expected: " << a+b << endl;

  return (a+b) == t.get_sum();
}

int main()
{
  WrapperRegDriver * platform = initPlatform();

  Run_ExampleRegOps(platform);

  deinitPlatform(platform);

  return 0;
}
