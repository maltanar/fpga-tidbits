package fpgatidbits.Testbenches

import Chisel._
import fpgatidbits.PlatformWrapper._
import fpgatidbits.dma._
import fpgatidbits.streams._
import fpgatidbits.ocm._

// instantiate a 32-wide 1024-deep dual-port BRAM and directly connect its
// inputs to the module I/O (thus the register file)

class TestBRAM(p: PlatformWrapperParams) extends GenericAccelerator(p) {
  val numMemPorts = 0
  val io = new GenericAcceleratorIF(numMemPorts, p) {
    val ports = Vec.fill (2) {new OCMSlaveIF(32, 32, 10)}
  }
  io.signature := makeDefaultSignature()

  val mem = Module(new DualPortBRAM(10, 32)).io
  mem.ports(0) <> io.ports(0)
  mem.ports(1) <> io.ports(1)
}
