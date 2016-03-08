package fpgatidbits.streams

import Chisel._

// combinational join for two streams -> one stream
// join function can be customized

class StreamJoin[TiA <: Data, TiB <: Data, TO <: Data]
(genA: TiA, genB: TiB, genOut: TO, join: (TiA, TiB) => TO) extends Module {
  val io = new Bundle {
    val inA = Decoupled(genA).flip
    val inB = Decoupled(genB).flip
    val out = Decoupled(genOut)
  }

  io.out.valid := io.inA.valid & io.inB.valid
  io.out.bits := join(io.inA.bits, io.inB.bits)

  io.inA.ready := io.out.ready & io.inB.valid
  io.inB.ready := io.out.ready & io.inA.valid
}

object StreamJoin {
  def apply[TiA <: Data, TiB <: Data, TO <: Data]
  (inA: DecoupledIO[TiA], inB: DecoupledIO[TiB], genO: TO,
  join: (TiA, TiB) => TO): DecoupledIO[TO] = {
    val joiner = Module(new StreamJoin(inA.bits, inB.bits, genO, join)).io
    joiner.inA <> inA
    joiner.inB <> inB
    joiner.out
  }
}
