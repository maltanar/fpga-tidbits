package fpgatidbits.examples

import chisel3._
import fpgatidbits.PlatformWrapper._
import fpgatidbits.ocm._

// instantiate a 32-wide 1024-deep dual-port BRAM and directly connect its
// inputs to the module I/O (thus the register file)

class ExampleBRAMIO(n: Int, p: PlatformWrapperParams) extends GenericAcceleratorIF(n,p) {
  val ports = Vec(2, new OCMSlaveIF(32, 32, 10))
}

class ExampleBRAM(p: PlatformWrapperParams) extends GenericAccelerator(p) {
  val numMemPorts = 0
  val io = IO(new ExampleBRAMIO(numMemPorts, p))
  io.signature := makeDefaultSignature()

  val memExt = Module(new DualPortBRAM(10, 32)).io
  val mem = Wire(new DualPortBRAMIOWrapper(10, 32))
  memExt.clk := clock

  memExt.a.connect(mem.ports(0))
  memExt.b.connect(mem.ports(1))

  mem.ports(0) <> io.ports(0)
  mem.ports(1) <> io.ports(1)
}
