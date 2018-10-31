package fpgatidbits.streams

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

// convenience constructor for making two identical copies of the stream
object StreamCopy {
  def apply[T <: Data]
  (in: DecoupledIO[T], outA: DecoupledIO[T], outB: DecoupledIO[T]) = {
    val m = Module(new StreamFork(
      genIn = in.bits, genA = outA.bits, genB = outB.bits,
      forkA = {x: T => x}, forkB = {x: T => x}
    )).io
    in <> m.in
    m.outA <> outA
    m.outB <> outB
  }

  def apply[T <: Data]
  (in: DecoupledIO[T], out: Seq[DecoupledIO[T]]) = {
    for(o <- out) {
      o.bits := in.bits
      o.valid := in.valid & out.filterNot(_ == o).map(_.ready).reduce(_&_)
    }
    in.ready := out.map(_.ready).reduce(_ & _)
  }
}
