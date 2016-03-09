#!/bin/sh

VERILATOR_SRC_DIR="/usr/share/verilator/include"

# call verilator to translate verilog to C++
verilator --cc TesterWrapper.v +define+SYNTHESIS=1 -Wno-fatal -Wno-lint -Wno-style -Wno-COMBDLY --Mdir verilated
# add verilated.cpp from source dirs
cp -f $VERILATOR_SRC_DIR/verilated.cpp .
# compile everything
g++ -std=c++11 -I$VERILATOR_SRC_DIR -Iverilated *.cpp verilated/*.cpp -o VerilatedTesterWrapper

