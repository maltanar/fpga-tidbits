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
  cout << "Enter command q(uit), r(ead), w(rite): ";
  cin >> cmd;

  while(cmd != "q") {
    if(cmd == "r") {
        cout << "Enter address: ";
        cin >> addr;
        t.set_ports_0_req_addr(addr);
        cout << "addr " << addr << " = " << t.get_ports_0_rsp_readData() << endl;
    } else if (cmd == "w") {
        cout << "Enter address and data: ";
        cin >> addr >> dat;
        t.set_ports_0_req_addr(addr);
        t.set_ports_0_req_writeData(dat);
        t.set_ports_0_req_writeEn(1);
        t.set_ports_0_req_writeEn(0);
        cout << "wrote " << dat << " to " << addr << endl;
      } else cout << "unrecognized" << endl;
    cout << "Enter command q(uit), r(ead), w(rite): ";
    cin >> cmd;
  }

  return 0;
}
