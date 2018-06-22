#include <iostream>
#include "platform.h"
#include "TestBRAM.hpp"
#include <string>

using namespace std;

int main() {
  WrapperRegDriver * platform = initPlatform();

  TestBRAM t(platform);

  cout << "Signature: " << hex << t.get_signature() << dec << endl;

  string cmd;
  unsigned int addr, dat;

  cin >> cmd;

  while(cmd != "q") {
    if(cmd == "r") {
        cin >> addr;
        t.set_ports_0_req_addr(addr);
        cout << "addr " << addr << " = " << t.get_ports_0_rsp_readData() << endl;
    } else if (cmd == "w") {
        cin >> addr >> dat;
        t.set_ports_0_req_addr(addr);
        t.set_ports_0_req_writeData(dat);
        t.set_ports_0_req_writeEn(1);
        t.set_ports_0_req_writeEn(0);
        cout << "wrote " << dat << " to " << addr << endl;
      } else cout << "unrecognized" << endl;

    cin >> cmd;
  }

  return 0;
}
