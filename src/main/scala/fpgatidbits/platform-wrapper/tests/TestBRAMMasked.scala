package fpgatidbits.Testbenches

import Chisel._
import fpgatidbits.PlatformWrapper._
import fpgatidbits.dma._
import fpgatidbits.streams._
import fpgatidbits.ocm._

// instantiate a 32-wide 1024-deep dual-port BRAM and directly connect its
// inputs to the module I/O (thus the register file)
// the difference from TestBRAM is that we use the partially-writable variant
// here, e.g. it is possible to do a write to a BRAM address that modifies
// only part of the data there, depending on the write enable signals

class TestBRAMMasked(p: PlatformWrapperParams) extends GenericAccelerator(p) {
  val numMemPorts = 0
  val dataWidth = 32
  val addrWidth = 10
  val maskUnit = 8
  val maskWidth = dataWidth/maskUnit
  val io = new GenericAcceleratorIF(numMemPorts, p) {
    val ports = Vec.fill (2) {new OCMMaskedSlaveIF(dataWidth, addrWidth, maskWidth)}
  }
  io.signature := makeDefaultSignature()

  val mem = Module(new DualPortMaskedBRAM(addrWidth, dataWidth)).io
  mem.ports(0) <> io.ports(0)
  mem.ports(1) <> io.ports(1)
}
