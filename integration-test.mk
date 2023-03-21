# The  run all the integration tests
TESTS = ExampleStreamPort ExampleMultiChanSum ExampleSum ExampleRegOps ExampleBRAM ExampleBRAMMasked

Example%:
	echo "Compiling chisel for $@"
	sbt "run test $@ Tester"
	cd "integration-tests/$@"; make; ./emu 10

.PHONY: integration-test
integration-test: $(TESTS)
