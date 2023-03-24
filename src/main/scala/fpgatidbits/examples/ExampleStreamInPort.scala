package fpgatidbits.examples

import chisel3._
import fpgatidbits.PlatformWrapper._

class ExampleStreamInPortIO(ap: AcceleratorParams, p: PlatformWrapperParams) extends GenericAcceleratorIF(ap,p) {
  val sum = Output(UInt(32.W))
}

class ExampleStreamInPort(p: PlatformWrapperParams) extends GenericAccelerator(p) {
  val accelParams = AcceleratorParams(
    numMemPorts = 0,
    numStreamInPorts = 1,
  )

  val io = IO(new ExampleStreamInPortIO(accelParams, p))
  io.signature := makeDefaultSignature()
  val stream = io.streamInPort(0)
  val sum = RegInit(0.U(32.W))
  io.sum := sum
  stream.ready := true.B
  when(stream.fire) {
    sum := sum + stream.bits.data
  }
}
