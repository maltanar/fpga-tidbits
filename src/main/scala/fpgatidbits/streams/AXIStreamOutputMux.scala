package fpgatidbits.streams

import Chisel._
import fpgatidbits.axi._

class AXIStreamOutputMux(dataWidth: Int) extends Module {
  val io = new Bundle {
    val sel = UInt(INPUT, width = 1)
    val strm = new AXIStreamSlaveIF(UInt(width = dataWidth))
    val out0 = new AXIStreamMasterIF(UInt(width = dataWidth))
    val out1 = new AXIStreamMasterIF(UInt(width = dataWidth))
  }

  io.strm.renameSignals("strm")
  io.out0.renameSignals("out0")
  io.out1.renameSignals("out1")

  io.out0.bits := io.strm.bits
  io.out1.bits := io.strm.bits

  io.out0.valid := (io.sel === UInt(0)) & io.strm.valid
  io.out1.valid := (io.sel === UInt(1)) & io.strm.valid

  io.strm.ready := Mux(io.sel === UInt(0), io.out0.ready, io.out1.ready)
}

class DecoupledOutputDemuxIO[T <: Data](gen: T, numChans: Int) extends Bundle {
  val sel = UInt(INPUT, width = log2Up(numChans))
  val in = Decoupled(gen).flip
  val out = Vec.fill(numChans) {Decoupled(gen)}
}

class DecoupledOutputDemux[T <: Data](gen: T, numChans: Int) extends Module {
  val io = new DecoupledOutputDemuxIO(gen, numChans)

  io.in.ready := io.out(io.sel).ready

  for(i <- 0 until numChans) {
    io.out(i).valid := io.in.valid & (io.sel === UInt(i))
    io.out(i).bits := io.in.bits
  }
}

object DecoupledOutputDemux {
  def apply[T <: Data](sel: UInt, chans: Seq[DecoupledIO[T]]): DecoupledIO[T] = {
    val inst = Module(new DecoupledOutputDemux(chans(0).bits, chans.size)).io
    for(i <- 0 until chans.size) {inst.out(i) <> chans(i)}
    inst.sel := sel
    inst.in
  }
}
