package fpgatidbits.streams

import chisel3._
import chisel3.util._

class StreamFilter[Tin <: Data, Tout <: Data]
  (genI: Tin, genO: Tout, filterFxn: Tin => Tout  ) extends Module {
    val io = IO(new Bundle {
      val in = Flipped(Decoupled(genI))
      val out = Decoupled(genO)
    })
    io.out.valid := io.in.valid
    io.out.bits := filterFxn(io.in.bits)
    io.in.ready := io.out.ready
}

object StreamFilter {
  def apply[Tin <: Data, Tout <: Data]
    (in: DecoupledIO[Tin], outGen: Tout, filterFxn: Tin => Tout ) = {
      val sf = Module(new StreamFilter[Tin,Tout](in.bits.cloneType,outGen.cloneType, filterFxn)).io
      sf.in <> in
      sf.out
    }
}

import fpgatidbits.dma._

object ReadRespFilter {
  def apply(in: DecoupledIO[GenericMemoryResponse]) = {
    val filterFxn = {r: GenericMemoryResponse => r.readData}
    StreamFilter(in, in.bits.readData, filterFxn)
  }
}
