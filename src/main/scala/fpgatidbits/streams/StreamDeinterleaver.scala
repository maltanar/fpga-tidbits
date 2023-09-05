package fpgatidbits.streams

import chisel3._
import chisel3.util._
import fpgatidbits.ocm.FPGAQueue

// deinterleavers a input stream with identifiers onto one of the output
// streams, based on the ID value and a routing function
// TODO the current implementation is likely to cause timing problems
// due to high-fanout signals and combinational paths
// - to avoid high-fanout signals: implement decoding as e.g shiftreg
// - to avoid combinational paths, pipeline the deinterleaver

class StreamDeinterleaverIF[T <: Data](numDests: Int, gen: T) extends Bundle {
  val in = Flipped(Decoupled(gen))
  val out = Vec(numDests, Decoupled(gen))
  val decodeErrors = Output(UInt(32.W))
}

class StreamDeinterleaver[T <: Data](numDests: Int, gen: T, route: T => UInt)
extends Module {
  val io = new StreamDeinterleaverIF(numDests, gen)

  val regDecodeErrors = RegInit(0.U(32.W))

  for(i <- 0 until numDests) {
    io.out(i).bits := io.in.bits
    io.out(i).valid := false.B
  }

  io.in.ready := false.B
  io.decodeErrors := regDecodeErrors

  val destPipe = route(io.in.bits)
  val invalidChannel = (destPipe >= (numDests.U))
  val canProceed = io.in.valid && io.out(destPipe).ready

  when (invalidChannel) {
    // do not let the entire pipe stall because head of line has invalid dest
    // increment error counter and move on
    regDecodeErrors := regDecodeErrors + 1.U
    io.in.ready := true.B
  }
  .elsewhen (canProceed) {
    io.in.ready := true.B
    io.out(destPipe).valid := true.B
  }
}

class StreamDeinterleaverQueued[T <: Data](numDests: Int, gen: T, route: T => UInt, capacity: Int)
extends Module {
  val io = new StreamDeinterleaverIF(numDests, gen)

  val deintl = Module(new StreamDeinterleaver(numDests, gen, route)).io

  FPGAQueue(io.in, 2) <> deintl.in
  io.decodeErrors := deintl.decodeErrors

  for(i <- 0 until numDests) {
    val q = Module(new FPGAQueue(gen, capacity)).io
    q.enq <> deintl.out(i)
    io.out(i) <> q.deq
  }
}
