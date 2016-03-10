#!/bin/sh

# requires a recent version of verilator, e.g. 3.878
VERILATOR_SRC_DIR="/usr/local/share/verilator/include"

# call verilator to translate verilog to C++
verilator --cc TesterWrapper.v -Wno-assignin -Wno-fatal -Wno-lint -Wno-style -Wno-COMBDLY -Wno-STMTDLY --Mdir verilated
# if verilator freezes while executing, consider adding +define+SYNTHESIS=1
# to the cmdline here. this will disable the Chisel printfs though.

# add verilated.cpp from source dirs
cp -f $VERILATOR_SRC_DIR/verilated.cpp .
# compile everything
g++ -std=c++11 -I$VERILATOR_SRC_DIR -Iverilated *.cpp verilated/*.cpp -o VerilatedTesterWrapper
