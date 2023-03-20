# The  run all the integration tests

TESTS = "ExampleMultiChanSum" "ExampleSum" "ExampleRegOps" "ExampleBRAM" "ExampleBRAMMasked"



.PHONY: integration-tests
integration-tests: $(TEST_RESULTS) bootloader-test

# For all TEST_SRCS, go into the directory. Build the test program
# run the emulator on it (so env.bash must be called). And parse results
Example%:
	echo "Compiling chisel for $@"
	sbt "run test $@ Tester"
	cd "integration-tests/$@";
	echo "Compiling Verilator for $t"
	eval "./verilator-build.sh"
	eval "./VerilatedTesterWrapper $N_TESTS"
	cd "../.."



$(TEST_DIR)/%/test_res.txt: $(TEST_DIR)/% @echo Executing $^
	@cd $^; make recompile
	@cd $^; make run | tee test_res.txt
	@$(RES_PARSER) $@

bootloader-test:
	@cd programs/helloWorld; make clean; make app;
	@cd programs/bootloader; make recompile;
	@cd programs/bootloader; $(IP_EMU) bootloader.mem ../helloWorld/helloworld.app | tee test_res.txt
	@cd programs/bootloader; $(RES_PARSER) test_res.txt

.PHONY: integration-clean
# Loop through all the test dirs and do `make clean` which should remove all
# generated files. It is done in bash oneliner to enable cd'ing into the directory
# and doing some commands inside it.
integration-clean: $(TEST_SRCS)
	@for test in $^ ; do \
	 	cur=$$(pwd);\
		cd $$test; \
		make clean; \
		cd $$cur; \
	done




integration-test:


.phony integration-test
