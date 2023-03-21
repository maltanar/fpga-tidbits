package fpgatidbits.examples

import chisel3._
import fpgatidbits.PlatformWrapper._

class ExampleStreamPortIO(ap: AcceleratorParams, p: PlatformWrapperParams) extends GenericAcceleratorIF(ap,p) {
  val sum = Output(UInt(32.W))
}

class ExampleStreamPort(p: PlatformWrapperParams) extends GenericAccelerator(p) {
  val accelParams = AcceleratorParams(
    numMemPorts = 0,
    numStreamInPorts = 1,
    numStreamOutPorts = 0,
    streamWidth = 32,
  )

  val io = IO(new ExampleStreamPortIO(accelParams, p))
  io.signature := makeDefaultSignature()
  val stream = io.streamInPort(0)
  val sum = RegInit(0.U(32.W))
  io.sum := sum
  stream.data.ready := true.B
  when(stream.data.fire) {
    sum := sum + stream.data.bits
  }
}
