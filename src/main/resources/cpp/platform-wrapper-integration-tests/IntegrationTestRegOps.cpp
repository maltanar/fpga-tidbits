#include <iostream>
using namespace std;

#include "TestRegOps.hpp"
#include "platform.h"
#include <cstdlib>
#include <time.h>


bool Run_TestRegOps(WrapperRegDriver * platform, uint32_t a, uint32_t b) {
  TestRegOps t(platform);
  t.set_op_0(a);
  t.set_op_1(b);

  return (a+b) == t.get_sum();
}

int main(int argc, char **argv)
{
  if (argc != 2) {
      cout << "Please pass the number of tests to run as the only command line argument" <<endl;
      return -1;
    }
    int n_tests = atoi(argv[1]);

  srand(time(NULL));
  WrapperRegDriver * platform = initPlatform();

  cout << "Running TestRegOps integration test ..." <<endl;
  int passed_tests = 0;

  for (int i=0; i<n_tests; i++) {
    uint32_t a_in = rand();
    uint32_t b_in = rand();
    if(Run_TestRegOps(platform, a_in, b_in)) {
        passed_tests++;
    } else {
        cout <<"TestRegOps failed for a=" <<a_in <<" b=" <<b_in <<endl;
        return -1;
    }
  }

  cout <<"TestRegOps passed " <<passed_tests <<endl;

  deinitPlatform(platform);

  return 0;
}
