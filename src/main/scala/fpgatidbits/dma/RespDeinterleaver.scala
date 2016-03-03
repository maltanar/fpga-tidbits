package fpgatidbits.dma

import Chisel._
import fpgatidbits.ocm._

class RespDeinterleaverIF(numPipes: Int, p: MemReqParams) extends Bundle {
  // interleaved responses in
  val rspIn = Decoupled(new GenericMemoryResponse(p)).flip
  // deinterleaved responses out
  val rspOut = Vec.fill(numPipes) {Decoupled(new GenericMemoryResponse(p))}
  // number of decode errors (ID width no matching pipe)
  val decodeErrors = UInt(OUTPUT, width = 32)

  override def clone = {
    new RespDeinterleaverIF(numPipes, p).asInstanceOf[this.type]
  }
}

class QueuedDeinterleaver(numPipes: Int, p: MemReqParams, n: Int,
  routeFxn: GenericMemoryResponse => UInt = {x: GenericMemoryResponse => x.channelID}
) extends Module {

  val io = new RespDeinterleaverIF(numPipes,p)
  val deint = Module(new RespDeinterleaver(numPipes, p, routeFxn)).io
  deint.rspIn <> io.rspIn
  io.decodeErrors := deint.decodeErrors


  for(i <- 0 until numPipes) {
    val rspQ = Module(new FPGAQueue(new GenericMemoryResponse(p), n)).io
    rspQ.deq <> io.rspOut(i)
    rspQ.enq <> deint.rspOut(i)
  }
}

class RespDeinterleaver(numPipes: Int, p: MemReqParams,
  routeFxn: GenericMemoryResponse => UInt = {x: GenericMemoryResponse => x.channelID}
) extends Module {
  val io = new RespDeinterleaverIF(numPipes, p)

  val regDecodeErrors = Reg(init = UInt(0, 32))

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

  val destPipe = routeFxn(io.rspIn.bits)
  val invalidChannel = (destPipe >= UInt(numPipes))
  val canProceed = io.rspIn.valid && io.rspOut(destPipe).ready

  when (invalidChannel) {
    // do not let the entire pipe stall because head of line has invalid dest
    // increment error counter and move on
    regDecodeErrors := regDecodeErrors + UInt(1)
    io.rspIn.ready := Bool(true)
    printf("RespDeinterleaver decode error! chanID = %d dest = %d \n",
      io.rspIn.bits.channelID, destPipe
    )
  }
  .elsewhen (canProceed) {
    io.rspIn.ready := Bool(true)
    io.rspOut(destPipe).valid := Bool(true)
  }
}
