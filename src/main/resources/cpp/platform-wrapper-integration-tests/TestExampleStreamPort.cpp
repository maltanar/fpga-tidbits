#include <iostream>
using namespace std;

#include "ExampleStreamPort.hpp"
#include "platform.h"
#include <cstdlib>
#include <time.h>


int main(int argc, char **argv)
{
  if (argc != 2) {
      cout << "Please pass the number of tests to run as the only command line argument" <<endl;
      return -1;
    }
    int n_tests = atoi(argv[1]);

  srand(time(NULL));
  WrapperRegDriver * platform = initPlatform();
  ExampleStreamPort *t = new ExampleStreamPort(platform);

  cout << "Running ExampleRegOps integration test ..." <<endl;
  int passed_tests = 0;
  uint32_t x, golden_sum, running_sum;

  golden_sum=0;
  for (int i=0; i<n_tests; i++) {
    x = rand();
    golden_sum += x;
    t->set_streamInPort_0_bits(x);
    t->set_streamInPort_0_valid(1);
    while (t->get_streamInPort_0_ready() != 1) {}
    running_sum = t->get_sum();

    if (running_sum != golden_sum) {
        cout <<"ExampleStreamPOrt failed with golden=" <<golden_sum <<" running=" <<running_sum <<endl;
        return -1;
    }
  }

  cout <<"ExampleStreamPort passed" <<endl;

  delete t;

  deinitPlatform(platform);

  return 0;
}
