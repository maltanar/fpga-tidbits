#!/bin/bash

# This script runs all the tests
set -e
# First run all the Chisel Unit tests
#sbt 'test'

N_TESTS=100

# The  run all the integration tests
declare -a testArr=("ExampleMultiChanSum" "ExampleSum" "ExampleRegOps" "ExampleBRAM" "ExampleBRAMMasked")

for t in "${testArr[@]}"
do
  echo "Compiling chisel for $t"
  sbt "run test $t Tester" > .sbt_log
  cd "integration-tests/$t"
  echo "Compiling Verilator for $t"
  eval "./verilator-build.sh"
  eval "./VerilatedTesterWrapper $N_TESTS"
  cd "../.."
done


