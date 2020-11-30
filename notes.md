# Erlings notes

## Emulator system
The connection to the emulator happens in
testerdriver.hpp. it inclues TesterWrapper.h which is created by the backend.
testerdriver.hpp extends WrapperRegDriver by reading/writing to the public functions (ports) of the emulated design.

