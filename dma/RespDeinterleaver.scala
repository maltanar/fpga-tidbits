package TidbitsDMA

import Chisel._

class RespDeinterleaver(numPipes: Int, p: MemReqParams) extends Module {
  val io = new Bundle {
    // interleaved responses in
    val rspIn = Decoupled(new GenericMemoryResponse(p)).flip
    // deinterleaved responses out
    val rspOut = Vec.fill(numPipes) {Decoupled(new GenericMemoryResponse(p))}
    // number of decode errors (ID width no matching pipe)
    val decodeErrors = UInt(OUTPUT, width = 32)
  }

  val regDecodeErrors = Reg(init = UInt(0, 32))
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
  io.decodeErrors := regDecodeErrors

  val destPipe = idToPipe(io.rspIn.bits.channelID)
  val invalidChannel = (destPipe >= UInt(numPipes))
  val canProceed = io.rspIn.valid && io.rspOut(destPipe).ready

  when (invalidChannel) {
    // do not let the entire pipe stall because head of line has invalid dest
    // increment error counter and move on
    regDecodeErrors := regDecodeErrors + UInt(1)
    io.rspIn.ready := Bool(true)
  }
  .elsewhen (canProceed) {
    io.rspIn.ready := Bool(true)
    io.rspOut(destPipe).valid := Bool(true)
  }
}
