
SBT ?= sbt
SBT_FLAGS ?= -Dsbt.log.noformat=true
CC = gcc

CHISEL_FLAGS :=

top_srcdir ?= .
top_file := src/main/scala/Main.scala
executables := $(filter-out top, $(notdir $(basename $(wildcard $(srcdir)/*.scala))))
integration_test_script = test-all.sh


default: emulator

all: verilog

clean:
	-rm -f *.h *.hex *.flo *.cpp *.o *.out *.v *.vcd $(executables)
	sbt clean
	-rm -rf project/target/ target/ verilator

verilog:
	$(SBT) $(SBT_FLAGS) "verilog $(ACCEL) $(PLATFORM)"

driver:
	$(SBT) $(SBT_FLAGS) "driver $(ACCEL) $(PLATFORM)"

emulator:
	$(SBT) $(SBT_FLAGS) "emulator $(ACCEL) $(PLATFORM)"

unit-test:
	$(SBT) $(SBT_FLAGS) test

integration-test:
	./$(integration_test_script)

test: unit-test integration-test

.PHONY: all emulator verilog driver test unit-test integration-test
