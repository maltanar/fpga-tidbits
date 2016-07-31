#include <iostream>
#include <stdint.h>
#include <string>
#include <stdio.h>
using namespace std;

#include "TestGather.hpp"
#include "platform.h"

typedef uint64_t AccelWord;
typedef uint32_t RandAccInd;

RandAccInd * readInfData(std::string fileName, unsigned int & numInds) {
  FILE *f = fopen(fileName.c_str(), "rb");
  if(!f) throw (std::string("Could not open file: ") + fileName).c_str();
  fseek(f, 0, SEEK_END);
  unsigned int fsize = ftell(f);
  fseek(f, 0, SEEK_SET);

  numInds = fsize / sizeof(RandAccInd);

  RandAccInd * buf = new RandAccInd[numInds];
  unsigned int r = fread((void *) buf, 1, fsize, f);

  if(r != fsize) throw "Read error";

  fclose(f);

  return buf;
}

bool Run_TestGather(WrapperRegDriver * platform) {
  TestGather t(platform);

  cout << "Signature: " << hex << t.get_signature() << dec << endl;
  unsigned int numVals, numInds;
  cout << "Number of values to generate: ";
  cin >> numVals;

  // allocate memory and generate indices with predictable structure
  AccelWord * hostBufVal = new AccelWord[numVals];
  unsigned int valbufsize = numVals * sizeof(AccelWord);
  for(unsigned int i = 0; i < numVals; i++) { hostBufVal[i] = i; }

  void * accelBufVal = platform->allocAccelBuffer(valbufsize);
  platform->copyBufferHostToAccel(hostBufVal, accelBufVal, valbufsize);

  t.set_valsBase((AccelDblReg) accelBufVal);

  // read random access indices from a file and copy into accel memory
  cout << "Enter filename to get rand.acc. indices (or eye): ";
  string indsFileName;
  cin >> indsFileName;

  RandAccInd * hostBufInds;
  if(indsFileName == "eye") {
    numInds = numVals;
    hostBufInds = new RandAccInd[numInds];
    for(unsigned int i = 0; i < numInds; i++) { hostBufInds[i] = i; }
  } else {
    hostBufInds = readInfData(indsFileName, numInds);
  }

  unsigned int indsbufsize = numInds * sizeof(RandAccInd);

  void * accelBufInds = platform->allocAccelBuffer(indsbufsize);
  platform->copyBufferHostToAccel(hostBufInds, accelBufInds, indsbufsize);

  t.set_indsBase((AccelDblReg) accelBufInds);
  t.set_count((AccelReg) numInds);

  cout << "Starting accelerator..." << endl;

  t.set_start(1);

  while(t.get_finished() != 1);

  cout << "Passed: " << t.get_resultsOK() << endl;
  cout << "Failed: " << t.get_resultsNotOK() << endl;

  // display performance counters
  cout << endl << "Performance counters: " << endl << "=====================" << endl;
  map<string, vector<unsigned int>> regMap = t.getStatusRegs();
  string prefix = "perf_";

  for(auto & keyVal : regMap) {
    if(keyVal.first.substr(0, prefix.size()) == prefix)
      cout << keyVal.first << " : " << t.readStatusReg(keyVal.first) << endl;
  }

  t.set_start(0);

  platform->deallocAccelBuffer(accelBufInds);
  platform->deallocAccelBuffer(accelBufVal);
  delete [] hostBufVal;
  delete [] hostBufInds;

  return true;
}

int main()
{
  WrapperRegDriver * platform = initPlatform();
  Run_TestGather(platform);
  deinitPlatform(platform);
  return 0;
}
