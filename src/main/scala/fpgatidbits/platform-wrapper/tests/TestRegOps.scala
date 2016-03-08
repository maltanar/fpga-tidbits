package fpgatidbits.Testbenches

import Chisel._
import fpgatidbits.PlatformWrapper._

// test for register reads and writes:
// add two 64-bit values
class TestRegOps(p: PlatformWrapperParams) extends GenericAccelerator(p) {
  val numMemPorts = 0
  val io = new GenericAcceleratorIF(numMemPorts, p) {
    val op = Vec.fill(2) {UInt(INPUT, width = 64)}
    val sum = UInt(OUTPUT, width = 64)
    val cc = UInt(OUTPUT, width = 32)
  }
  io.signature := makeDefaultSignature()
  io.sum := io.op(0) + io.op(1)

  val regCC = Reg(init = UInt(0, 32))
  regCC := regCC + UInt(1)

  io.cc := regCC
}
