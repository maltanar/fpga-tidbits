package TidbitsSimUtils

import Chisel._
import TidbitsAXI._

// testing infrastructure for wrappable accelerators
// provides "main memory" simulation and a convenient way of setting up the
// control/status registers for setting up the accelerator --
// just like how a CPU would in an SoC-like setting

// TODO how should the implementation here be partitioned?

class WrappableAccelHarness(fxn: AXIAccelWrapperParams => AXIWrappableAccel)
  extends Module
{
  val io = new Bundle {
    // TODO decide on I/O for the harness
  }
  // TODO add memory simulation support
  // TODO add a convenieny way of reading/writing CSRs
  // the register map manager in the wrapper (if existing) should be helpful
  // for this
}


class WrappableAccelTester(c: WrappableAccelHarness) extends Tester(c) {

}
