#!/bin/bash
set -e

if [ -z "$TIDBITS_ROOT" ]; then
    echo "Need to set TIDBITS_ROOT"
    exit 1
fi  

if [ "$#" -ne 5 ]; then
  echo "Usage: $0 <platform> <accel-verilog> <project-name> <project-dir> <freq-MHz>" >&2
  exit 1
fi

PLATFORM="$1"
ACCEL_VERILOG="$2"
PROJECT_NAME="$3"
PROJECT_DIR="$4"
FREQ_MHZ=$5

TCL_PATH=$TIDBITS_ROOT/src/main/script/vivado-platformwrapper-$PLATFORM.tcl
echo $TCL_PATH
vivado -mode batch -source $TCL_PATH -tclargs $TIDBITS_ROOT $ACCEL_VERILOG $PROJECT_NAME $PROJECT_DIR $FREQ_MHZ
