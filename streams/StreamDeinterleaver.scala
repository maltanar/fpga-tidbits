package TidbitsStreams

import Chisel._

// deinterleavers a input stream with identifiers onto one of the output
// streams, based on the ID value and a routing function
// TODO the current implementation is likely to cause timing problems
// due to high-fanout signals and combinational paths
// - to avoid high-fanout signals: implement decoding as e.g shiftreg
// - to avoid combinational paths, pipeline the deinterleaver

class StreamDeinterleaver[T <: Data](numDests: Int, gen: T, route: T => UInt)
extends Module {
  val io = new Bundle {
    val in = Decoupled(gen).flip
    val out = Vec.fill(numDests) {Decoupled(gen)}
    val decodeErrors = UInt(OUTPUT, 32)
  }

  val regDecodeErrors = Reg(init = UInt(0, 32))
  val outQ = Vec.fill(numDests) {Decoupled(gen).asDirectionless()}

  for(i <- 0 until numDests) {
    io.out(i) <> Queue(outQ(i),2)

    outQ(i).bits := io.in.bits
    outQ(i).valid := Bool(false)
  }

  io.in.ready := Bool(false)
  io.decodeErrors := regDecodeErrors

  val destPipe = route(io.in.bits)
  val invalidChannel = (destPipe >= UInt(numDests))
  val canProceed = io.in.valid && outQ(destPipe).ready

  when (invalidChannel) {
    // do not let the entire pipe stall because head of line has invalid dest
    // increment error counter and move on
    regDecodeErrors := regDecodeErrors + UInt(1)
    io.in.ready := Bool(true)
  }
  .elsewhen (canProceed) {
    io.in.ready := Bool(true)
    outQ(destPipe).valid := Bool(true)
  }
}
