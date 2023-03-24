package fpgatidbits.examples

import chisel3._
import chisel3.util.Queue
import fpgatidbits.PlatformWrapper._

class ExampleMultipleStreamPortsIO(ap: AcceleratorParams, p: PlatformWrapperParams) extends GenericAcceleratorIF(ap,p) {
}
class ExampleMultipleStreamPorts(p: PlatformWrapperParams) extends GenericAccelerator(p) {
  val accelParams = AcceleratorParams(
    numMemPorts = 0,
    numStreamInPorts = 1,
    numStreamOutPorts = 2
  )

  val io = IO(new ExampleMultipleStreamPortsIO(accelParams, p))
  io.driveDefault()

  io.signature := makeDefaultSignature()
  val q = Queue(io.streamInPort(0))

  q.ready := io.streamOutPort(0).ready && io.streamOutPort(1).ready
  when(q.fire) {
    when (q.bits.data(0) === 0.U) {
      io.streamOutPort(0).bits.data := q.bits.data
      io.streamOutPort(0).valid := true.B
    }.otherwise {
      io.streamOutPort(1).bits.data := q.bits.data
      io.streamOutPort(1).valid := true.B
    }
  }
}
