package fpgatidbits.Testbenches

import chisel3._
import chisel3.util._
import fpgatidbits.PlatformWrapper._
import fpgatidbits.dma._
import fpgatidbits.streams._
import fpgatidbits.ocm._

// instantiate a 512-wide 64-deep single-port BRAM and directly connect its
// inputs to the module I/O (thus the register file)

class TestSinglePortBRAM(p: PlatformWrapperParams) extends GenericAccelerator(p) {
  val numMemPorts = 0
  val bramDataWidth = 512
  val io = IO(new GenericAcceleratorIF(numMemPorts, p) {
    val ports = new OCMSlaveIF(bramDataWidth, bramDataWidth, 8)
  })


  io.signature := makeDefaultSignature()

  val mem = Module(new SinglePortBRAM(8, bramDataWidth))
  mem.io <> io.ports
}

