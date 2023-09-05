package fpgatidbits.examples

import chisel3._
import fpgatidbits.PlatformWrapper._
import fpgatidbits.ocm._

class HelloAccelIO(numMemPorts: Int, p: PlatformWrapperParams) extends GenericAcceleratorIF(numMemPorts, p) {
  val op1 = Input(UInt(32.W))
  val op2 = Input(UInt(32.W))
  val res = Output(UInt(32.W))
}

class HelloAccel(p: PlatformWrapperParams) extends GenericAccelerator(p) {
  def numMemPorts=0
  val io = IO(new HelloAccelIO(numMemPorts, p))
  io.signature := makeDefaultSignature()

  io.res := io.op1 + io.op2
}
