#include <iostream>
#include "platform.h"
#include "TestBRAMMasked.hpp"
#include <string>

using namespace std;

int main() {
  WrapperRegDriver * platform = initPlatform();

  TestBRAMMasked t(platform);

  cout << "Signature: " << hex << t.get_signature() << dec << endl;

  string cmd;
  unsigned int addr, dat, writeMask;

  cin >> cmd;

  // commands:
  // r [address] -- read data from [address] and print out
  // w [address] [data] [writeMask] -- write data to address with given write mask

  while(cmd != "q") {
    if(cmd == "r") {
        cin >> addr;
        t.set_ports_0_req_addr(addr);
        cout << "addr " << addr << " = " << t.get_ports_0_rsp_readData() << endl;
    } else if (cmd == "w") {
        cin >> addr >> dat >> writeMask;
        t.set_ports_0_req_addr(addr);
        t.set_ports_0_req_writeData(dat);
        t.set_ports_0_req_writeMask_0(writeMask & 1);
        t.set_ports_0_req_writeMask_1((writeMask & 2) >> 1);
        t.set_ports_0_req_writeMask_2((writeMask & 4) >> 2);
        t.set_ports_0_req_writeMask_3((writeMask & 8) >> 3);
        t.set_ports_0_req_writeEn(1);
        t.set_ports_0_req_writeEn(0);
        cout << "wrote " << dat << " to " << addr << endl;
      } else cout << "unrecognized" << endl;

    cin >> cmd;
  }

  return 0;
}
