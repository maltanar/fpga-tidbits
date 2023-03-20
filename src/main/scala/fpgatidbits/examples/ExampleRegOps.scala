package fpgatidbits.examples

import chisel3._
import fpgatidbits.PlatformWrapper._

// test for register reads and writes:
// add two 64-bit values

class ExampleRegOpsIO(n: Int, p: PlatformWrapperParams) extends GenericAcceleratorIF(n,p) {
  val op = Vec(2, Input(UInt(64.W)))
  val sum = Output(UInt(64.W))
  val cc = Output(UInt(32.W))
}

class ExampleRegOps(p: PlatformWrapperParams) extends GenericAccelerator(p) {
  val numMemPorts = 0
  val io = IO(new ExampleRegOpsIO(numMemPorts, p))

  io.signature := makeDefaultSignature()
  io.sum := io.op(0) + io.op(1)

  val regCC = RegInit(0.U(32.W))
  regCC := regCC + 1.U

  io.cc := regCC
}
