package fpgatidbits.Testbenches

import chisel3._
import chisel3.util._
import fpgatidbits.PlatformWrapper._

// test for register reads and writes:
// add two 64-bit values
class TestRegOps(p: PlatformWrapperParams) extends GenericAccelerator(p) {
  val numMemPorts = 0
  val io = IO(new GenericAcceleratorIF(numMemPorts, p) {
    val op = Vec(2, Input(UInt(64.W)))
    val sum = Output(UInt(64.W))
    val cc = Output(UInt(32.W))
  })
  io.signature := makeDefaultSignature()
  io.sum := io.op(0) + io.op(1)

  val regCC = RegInit(0.U(32.W))
  regCC := regCC + 1.U

  io.cc := regCC
}
