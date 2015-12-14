#!/bin/sh

# See here for an example of using Vivado to convert regular bitfiles to
# the appropriate binfile format for the ZedBoard:
# https://github.com/maltanar/spmv-vector-cache/tree/master/bitfiles

BITFILE_PATH="/root/bitfiles/$1.bin"

if [ ! -f $BITFILE_PATH ]; then
  echo "File not found!"
  exit 1
else
  echo "Loading bitfile: $BITFILE_PATH"
  cat $BITFILE_PATH > /dev/xdevcfg
fi



