package TidbitsStreams

import Chisel._

// combinational fork for one stream -> two streams
// fork functions can be customized

class StreamFork[Ti <: Data, ToA <: Data, ToB <: Data]
  (genIn: Ti, genA: ToA, genB: ToB, forkA: Ti => ToA, forkB: Ti => ToB)
  extends Module {
  val io = new Bundle {
    val in = Decoupled(genIn).flip
    val outA = Decoupled(genA)
    val outB = Decoupled(genB)
  }

  io.in.ready := io.outA.ready & io.outB.ready

  io.outA.bits := forkA(io.in.bits)
  io.outB.bits := forkB(io.in.bits)

  io.outA.valid := io.in.valid & io.outB.ready
  io.outB.valid := io.in.valid & io.outA.ready
}
