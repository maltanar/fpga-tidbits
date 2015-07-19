A collection of Chisel hardware generators for small but useful components. 

A better description and more documentation may appear here someday. Until then, here is a rought description of what the components in each folder do:

dma - tools for burst-oriented memory access interfaces. defines an own, simple "intermediate representation" for memory requests/responses, which can be converted to platform-specific memory interfaces via adapters.

interfaces - interface definitions, currently AXI MM/stream. also includes "AXIWrappableAccel" for making accelerators based on a simple template (one memory port for register file (control/status regs) access, one memory port for main memory access). the wrapper AXIAccelWrapper has support for mapping accel I/O signals (given as Chisel Bundles) to register file indices, and generating a C++ drive to read/write these registers.

on-chip-memory - tools for working with embedded SRAMs in FPGAs, including a simple memory controller for initializing/dumping SRAM contents from main memory. also a model for dual-port RAM with asymmetric widths (not intended for synthesis -- only for testing in simulation).

profiler - tools for performance profiling hardware. currently only includes StateProfiler, which monitors a "state output" every cycle and increments a counter (thus building a state histogram).

regfile - a register file with one command-based interface (for e.g linking to a memory-mapped bus to r/w registers) and per-register signal-level interfaces (for using on the accelerator side). used in AXIAccelWrapper to provide regfile support.

sim-utils - utilities for testing hardware in simulation. WrappableAccelHarness here can be used as a harness for accelerators derived from AXIWrappableAccel, providing functions for register reads/writes and memory accesses (such as initializing a block of memory from file, or dumping mem contents to a file). also contains a high-latency memory model to have a simplistic DRAM model (which does not yet work).

streams - quite a few modules for working on data streams, all compatible with Chisel Decoupled-style interfaces or AXI stream interfaces (which are equivalent really). see module comments for descriptions.

testbenches - testes for some of the components. perhaps most interesting here is the wrapper/ subdirectory, which contains essentially synthesizable testbenches demonstrating AXIWrappableAccel. these can be either run in simulation (with WrappableAccelHarness) or synthesized (with AXIAccelWrapper) and run on the FPGA.
