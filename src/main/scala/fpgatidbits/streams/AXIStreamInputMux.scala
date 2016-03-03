package fpgatidbits.streams

import Chisel._
import fpgatidbits.axi._

class AXIStreamInputMux(dataWidth: Int) extends Module {
  val io = new Bundle {
    val sel = UInt(INPUT, width = 1)
    val in0 = new AXIStreamSlaveIF(UInt(width = dataWidth))
    val in1 = new AXIStreamSlaveIF(UInt(width = dataWidth))
    val strm = new AXIStreamMasterIF(UInt(width = dataWidth))
  }

  io.strm.renameSignals("strm")
  io.in0.renameSignals("in0")
  io.in1.renameSignals("in1")

  io.strm.bits := Mux(io.sel === UInt(0), io.in0.bits, io.in1.bits)
  io.strm.valid := Mux(io.sel === UInt(0), io.in0.valid, io.in1.valid)

  io.in0.ready := (io.sel === UInt(0)) & io.strm.ready
  io.in1.ready := (io.sel === UInt(1)) & io.strm.ready
}


class DecoupledInputMuxIO[T <: Data](gen: T, numChans: Int) extends Bundle {
  val sel = UInt(INPUT, width = log2Up(numChans))
  val in = Vec.fill(numChans) {Decoupled(gen).flip}
  val out = Decoupled(gen)
}

class DecoupledInputMux[T <: Data](gen: T, numChans: Int) extends Module {
  val io = new DecoupledInputMuxIO(gen, numChans)

  io.out.bits := io.in(io.sel).bits
  io.out.valid := io.in(io.sel).valid

  for(i <- 0 until numChans) {
    io.in(i).ready := io.out.ready & (io.sel === UInt(i))
  }
}

object DecoupledInputMux {
  def apply[T <: Data](sel: UInt, chans: Seq[DecoupledIO[T]]): DecoupledIO[T] = {
    val inst = Module(new DecoupledInputMux(chans(0).bits, chans.size)).io
    for(i <- 0 until chans.size) {inst.in(i) <> chans(i)}
    inst.sel := sel
    inst.out
  }
}
