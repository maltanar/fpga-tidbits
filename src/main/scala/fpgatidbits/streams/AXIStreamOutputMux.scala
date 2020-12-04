package fpgatidbits.streams

import chisel3._
import chisel3.util._
import fpgatidbits.axi._

class AXIStreamOutputMux(dataWidth: Int) extends Module {
  val io = IO(new Bundle {
    val sel = Input(UInt(1.W))
    val strm = Flipped(new AXIStreamIF(UInt(dataWidth.W)))
    val out0 = new AXIStreamIF(UInt(dataWidth.W))
    val out1 = new AXIStreamIF(UInt(dataWidth.W))
  })

  io.strm.suggestName("strm")
  io.out0.suggestName("out0")
  io.out1.suggestName("out1")

  io.out0.TDATA := io.strm.TDATA
  io.out1.TDATA := io.strm.TDATA

  io.out0.TVALID := (io.sel === 0.U) & io.strm.TVALID
  io.out1.TVALID := (io.sel === 1.U) & io.strm.TVALID

  io.strm.TREADY := Mux(io.sel === 0.U, io.out0.TREADY, io.out1.TREADY)
}

class DecoupledOutputDemuxIO[T <: Data](gen: T, numChans: Int) extends Bundle {
  val sel = Input(UInt(log2Ceil(numChans).W))
  val in = Flipped(Decoupled(gen))
  val out = Vec(numChans,Decoupled(gen))
}

class DecoupledOutputDemux[T <: Data](gen: T, numChans: Int) extends Module {
  val io = IO(new DecoupledOutputDemuxIO(gen, numChans))

  io.in.ready := io.out(io.sel).ready

  for(i <- 0 until numChans) {
    io.out(i).valid := io.in.valid & (io.sel === i.U)
    io.out(i).bits := io.in.bits
  }
}

object DecoupledOutputDemux {
  def apply[T <: Data](sel: UInt, chans: Seq[DecoupledIO[T]]): DecoupledIO[T] = {
    val inst = Module(new DecoupledOutputDemux(chans(0).bits.cloneType, chans.size)).io
    for(i <- 0 until chans.size) {inst.out(i) <> chans(i)}
    inst.sel := sel
    inst.in
  }
}
