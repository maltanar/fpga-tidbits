BOARDS = ZedBoard PYNQZ1 PYNQU96 PYNQU96CC PYNQZCU104CC ZC706 GenericSDAccel WX690T
%:
	echo "Compiling board tst for $@"
	sbt "run v ExampleMultiChanSum $@"

.PHONY: board-test
board-test: $(BOARDS)
	
