// platform init-deinit functions for Linux on the ZC706, using the PL DDR
// as the accelerator memory

// assumes that:
// * 1GB of PL DDR memory is accessible from the host at address 0x40000000
// * the user accelerator AXI slave address is at 0x43c00000

#include "platform.h"
#include "linuxphysregdriver.hpp"
#include <iostream>
#include <string>
using namespace std;

extern "C" {
  #include <unistd.h>
  #include <sys/types.h>
  #include <sys/wait.h>
  #include <stdlib.h>
}

LinuxPhysRegDriver * platform = 0;

WrapperRegDriver * initPlatform() {
  if(!platform) {
    /* TODO correct the slave reg addresses */
    platform = new LinuxPhysRegDriver((void *) 0x50000000, (void *) 0x40000000, 1024 * 1024 * 1024);
  }
  return (WrapperRegDriver *) platform;
}

void deinitPlatform(WrapperRegDriver * driver) {
  // TODO doing a delete here causes the zedboard to go in a loop, debug this
}

void loadBitfile(const char * accelName) {
  pid_t c_pid, pid;
  int status;

  // call a shell script to do the bitfile loading, fork & exec & wait
  char * loader = getenv("ZYNQ_BITFILE_LOADER");
  if(!loader)
    throw "ZYNQ_BITFILE_LOADER must be set";

  c_pid = fork();

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
