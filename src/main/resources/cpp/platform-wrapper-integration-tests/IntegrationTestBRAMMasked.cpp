#include <iostream>
#include "platform.h"
#include "TestBRAMMasked.hpp"
#include <string>

using namespace std;

int main(int argc, char **argv) {

   if (argc != 2) {
       cout << "Please pass the number of tests to run as the only command line argument" <<endl;
       return -1;
     }
     int n_tests = atoi(argv[1]);

  cout <<"Running TestBRAMMasked integration test with " <<n_tests <<" iterations .." <<endl;


  WrapperRegDriver * platform = initPlatform();
  TestBRAMMasked t(platform);
  srand(time(NULL));

  int passed_tests = 0;

  uint32_t addr, data, writeMask, read_data, expected_read_data;

  for(int i = 0; i<n_tests; i++) {
    addr = rand() % 1024;
    data = rand();
    writeMask = rand() % 16;
    // Create a fullsize bitmask so we can calculate the expected results
    uint32_t _mask = 0;
    for (int j = 0; j<4; j++) {
      if (((writeMask >> j) & 1) == 1) {
        _mask = _mask | (255 << (8*j));
      }
    }

    expected_read_data = data & _mask;


    if (i % 2 == 0) {
        t.set_ports_0_req_addr(addr);
        t.set_ports_0_req_writeData(data);
        t.set_ports_0_req_writeMask_0(writeMask & 1);
        t.set_ports_0_req_writeMask_1((writeMask & 2) >> 1);
        t.set_ports_0_req_writeMask_2((writeMask & 4) >> 2);
        t.set_ports_0_req_writeMask_3((writeMask & 8) >> 3);
        t.set_ports_0_req_writeEn(1);
        t.set_ports_0_req_writeEn(0);

        t.set_ports_1_req_addr(addr);
        read_data = t.get_ports_1_rsp_readData();
    } else {
        t.set_ports_1_req_addr(addr);
        t.set_ports_1_req_writeData(data);
        t.set_ports_1_req_writeMask_0(writeMask & 1);
        t.set_ports_1_req_writeMask_1((writeMask & 2) >> 1);
        t.set_ports_1_req_writeMask_2((writeMask & 4) >> 2);
        t.set_ports_1_req_writeMask_3((writeMask & 8) >> 3);
        t.set_ports_1_req_writeEn(1);
        t.set_ports_1_req_writeEn(0);

        t.set_ports_0_req_addr(addr);
        read_data = t.get_ports_0_rsp_readData();
    }

    if (read_data == expected_read_data) {
        passed_tests++;

        // Then we have to write back zeros
        t.set_ports_1_req_addr(addr);
        t.set_ports_1_req_writeData(0);
        t.set_ports_1_req_writeMask_0(1);
        t.set_ports_1_req_writeMask_1(1);
        t.set_ports_1_req_writeMask_2(1);
        t.set_ports_1_req_writeMask_3(1);
        t.set_ports_1_req_writeEn(1);
         t.set_ports_1_req_writeEn(0);

         t.set_ports_0_req_addr(addr);
         t.set_ports_0_req_writeData(0);
         t.set_ports_0_req_writeMask_0(1);
         t.set_ports_0_req_writeMask_1(1);
         t.set_ports_0_req_writeMask_2(1);
         t.set_ports_0_req_writeMask_3(1);
         t.set_ports_0_req_writeEn(1);
         t.set_ports_0_req_writeEn(0);

    } else {
        cout <<"TestBRAM failed for addr=" <<addr <<" data=" <<data <<" writeMask=" <<writeMask;
        cout <<" expected="<<expected_read_data <<" got readData=" <<read_data <<" iteration " <<i <<endl;
        return -1;
    }
  }

  cout <<"TestBRAM passed " <<passed_tests <<" tests" <<endl;

  return 0;
}
