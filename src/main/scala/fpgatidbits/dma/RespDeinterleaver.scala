package fpgatidbits.dma

import chisel3._
import chisel3.util._
import fpgatidbits.ocm._

class RespDeinterleaverIF(numPipes: Int, p: MemReqParams) extends Bundle {
  // interleaved responses in
  val rspIn = Flipped(Decoupled(new GenericMemoryResponse(p)))
  // deinterleaved responses out
  val rspOut = Vec(numPipes, Decoupled(new GenericMemoryResponse(p)))
  // number of decode errors (ID width no matching pipe)
  val decodeErrors = Output(UInt(32.W))

}

class QueuedDeinterleaver(numPipes: Int, p: MemReqParams, n: Int,
  routeFxn: GenericMemoryResponse => UInt = {x: GenericMemoryResponse => x.channelID}
) extends Module {

  val io = IO(new RespDeinterleaverIF(numPipes,p))
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
  val io = IO(new RespDeinterleaverIF(numPipes, p))

  val regDecodeErrors = RegInit(0.U(32.W))

  // TODO the current implementation is likely to cause timing problems
  // due to high-fanout signals and combinational paths
  // - to avoid high-fanout signals: implement decoding as e.g shiftreg
  // - to avoid combinational paths, pipeline the deinterleaver
  for(i <- 0 until numPipes) {
    io.rspOut(i).bits := io.rspIn.bits
    io.rspOut(i).valid := false.B
  }

  io.rspIn.ready := false.B
  io.decodeErrors := regDecodeErrors

  val destPipe = routeFxn(io.rspIn.bits)
  val invalidChannel = (destPipe >= (numPipes).U)
  val canProceed = io.rspIn.valid && io.rspOut(destPipe).ready

  when (invalidChannel) {
    // do not let the entire pipe stall because head of line has invalid dest
    // increment error counter and move on
    regDecodeErrors := regDecodeErrors + 1.U
    io.rspIn.ready := true.B
    printf("RespDeinterleaver decode error! chanID = %d dest = %d \n",
      io.rspIn.bits.channelID, destPipe
    )
  }
  .elsewhen (canProceed) {
    io.rspIn.ready := true.B
    io.rspOut(destPipe).valid := true.B
  }
}
