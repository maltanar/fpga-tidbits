package TidbitsDMA

import Chisel._

class RespDeinterleaver(numPipes: Int, p: MemReqParams) extends Module {
  val io = new Bundle {
    // interleaved responses in
    val rspIn = Decoupled(new GenericMemoryResponse(p)).flip
    // deinterleaved responses out
    val rspOut = Vec.fill(numPipes) {Decoupled(new GenericMemoryResponse(p))}
    // TODO add statistics?
  }

  // TODO add ability to customize routing function
  def idToPipe(x: UInt): UInt = {x}

  // TODO the current implementation is likely to cause timing problems
  // due to high-fanout signals and combinational paths
  // - to avoid high-fanout signals: implement decoding as e.g shiftreg
  // - to avoid combinational paths, pipeline the deinterleaver
  for(i <- 0 until numPipes) {
    io.rspOut(i).bits := io.rspIn.bits
    io.rspOut(i).valid := Bool(false)
  }

  io.rspIn.ready := Bool(false)
  val destPipe = idToPipe(io.rspIn.bits.channelID)
  val canProceed = io.rspIn.valid && io.rspOut(destPipe).ready

  when (canProceed) {
    io.rspIn.ready := Bool(true)
    io.rspOut(destPipe).valid := Bool(true)
  }
}
