// platform init-deinit functions for Linux on the ZedBoard
// note that this assumes the peripheral lives at address 0x43c00000

#include "platform.h"
#include "linuxphysregdriver.hpp"
#include <iostream>
#include <string>
using namespace std;

extern "C" {
  #include <unistd.h>
  #include <sys/types.h>
  #include <sys/wait.h>
}

LinuxPhysRegDriver * platform = 0;

WrapperRegDriver * initPlatform() {
  if(!platform) {
    platform = new LinuxPhysRegDriver((void *) 0x43c00000, (void *) 0x17000000, 128 * 1024 * 1024);
  }
  return (WrapperRegDriver *) platform;
}

void deinitPlatform(WrapperRegDriver * driver) {
  // TODO doing a delete here causes the zedboard to go in a loop, debug this
}

void loadBitfile(const char * accelName) {
  pid_t c_pid, pid;
  int status;

  c_pid = fork();
  // call a shell script to do the bitfile loading, fork & exec & wait
  const char * loader = "/root/bitfiles/load-bitfile.sh";

  if (c_pid == 0){
    execl(loader, loader, accelName, NULL);
    throw "execl failed";
  } else if (c_pid > 0){
    if( (pid = wait(&status)) < 0){
      throw "wait failed";
      _exit(1);
    }
  } else{
    throw ("fork failed");
    _exit(1);
  }
  cout << "loadBitfile finished: " << accelName << endl;
}
