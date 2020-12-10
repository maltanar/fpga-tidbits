#include <iostream>
#include "platform.h"
#include "TestBRAM.hpp"
#include <string>
#include <time.h>

using namespace std;

int main(int argc, char** argv) {

  if (argc != 2) {
    cout << "Please pass the number of tests to run as the only command line argument" <<endl;
    return -1;
  }
  int n_tests = atoi(argv[1]);
  srand(time(NULL));

  cout << "Running TestBRAM integration test with " <<n_tests <<" tests ..." <<endl;

  WrapperRegDriver * platform = initPlatform();
  TestBRAM t(platform);

  int passed_tests = 0;

  for (int i = 0; i<n_tests; i++) {
     uint32_t data = rand();
     uint32_t addr = rand() % 1024;
     uint32_t read_data = 0;
     if (i % 2 == 0) {
          t.set_ports_0_req_addr(addr);
          t.set_ports_0_req_writeData(data);
          t.set_ports_0_req_writeEn(1);
          t.set_ports_0_req_writeEn(0);

          t.set_ports_1_req_addr(addr);
          read_data = t.get_ports_1_rsp_readData();
     } else {
          t.set_ports_1_req_addr(addr);
          t.set_ports_1_req_writeData(data);
          t.set_ports_1_req_writeEn(1);
          t.set_ports_1_req_writeEn(0);

          t.set_ports_0_req_addr(addr);
          read_data = t.get_ports_0_rsp_readData();
     }
     if (read_data == data) {
        passed_tests++;
     } else {
        cout <<"BRAM test " <<i <<"failed for addr=" <<addr <<" data=" <<data <<endl;
        return -1;
     }
  }

  cout << "TestBRAM passed "<<passed_tests <<" tests" <<endl;

  return 0;
}
