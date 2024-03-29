package fpgatidbits.examples

import chisel3._
import fpgatidbits.PlatformWrapper._
import fpgatidbits.ocm._

// instantiate a 512-wide 64-deep single-port BRAM and directly connect its
// inputs to the module I/O (thus the register file)

class ExampleSinglePortBRAMIO(w: Int, a:Int, n: Int, p: PlatformWrapperParams) extends GenericAcceleratorIF(n,p) {
  val ports = new OCMSlaveIF(w, a, 8)
}
class ExampleSinglePortBRAM(p: PlatformWrapperParams) extends GenericAccelerator(p) {
  val numMemPorts = 0
  val bramDataWidth = 512
  val io = IO(new ExampleSinglePortBRAMIO(bramDataWidth, bramDataWidth, numMemPorts,p))
  io.signature := makeDefaultSignature()

  val mem = Module(new SinglePortBRAM(8, bramDataWidth))
  mem.io <> io.ports
}

