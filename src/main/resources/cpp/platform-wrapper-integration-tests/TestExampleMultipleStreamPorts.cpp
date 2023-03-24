#include <iostream>
using namespace std;

#include "ExampleMultipleStreamPorts.hpp"
#include "platform.h"
#include <cstdlib>
#include <time.h>


bool passed = true;

void assert(bool cond, string msg) {
    if (!cond) {
        cout << "Assertion failed: " << msg << endl;
        passed = false;
    }
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
  ExampleMultipleStreamPorts *t = new ExampleMultipleStreamPorts(platform);

  cout << "Running ExampleMultipleStreamPorts integration test ..." <<endl;
  int passed_tests = 0;
  uint32_t x;

  for (int i=0; i<n_tests && passed; i++) {
      x = rand();
      t->set_streamInPort_0_bits_data(x);
      t->set_streamInPort_0_valid(1);

      if (x % 2 == 0) {
        // Even number
        while (t->get_streamOutPort_0_valid() == 0) {};
        assert(t->get_streamOutPort_0_valid() == 1, "streamOutPort not valid");
        assert(t->get_streamOutPort_0_bits_data() == x, "streamOutPort wrong data");
        t->set_streamOutPort_0_ready(1);
        assert(t->get_streamOutPort_0_bits_data() == 0, "");
        assert(t->get_streamOutPort_0_valid() == 0, "");

      } else {
        // Odd number
        while (t->get_streamOutPort_1_valid() == 0) {};
        assert(t->get_streamOutPort_1_valid() == 1, "invalid ");
        assert(t->get_streamOutPort_1_bits_data() == x, "streamOutPort wrong data");
        t->set_streamOutPort_1_ready(1);
        assert(t->get_streamOutPort_1_bits_data() == 0, "Data not reset");
        assert(t->get_streamOutPort_1_valid() == 0, "valid not reset");
      }
    }

  delete t;

  deinitPlatform(platform);
    if (passed) {
        cout <<"ExampleMultipleStreamPort passed" <<endl;
        return 0;
    } else {
        cout <<"ExampleMultipleStreamPort FAILED" <<endl;
        return 1;
    }

}
