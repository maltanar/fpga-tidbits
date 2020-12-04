package fpgatidbits.streams

import chisel3._
import chisel3.util._
import fpgatidbits.axi._

class AXIStreamInputMux(dataWidth: Int) extends Module {
  val io = IO(new Bundle {
    val sel = Input(UInt(1.W))
    val in0 = Flipped(new AXIStreamIF(UInt(dataWidth.W)))
    val in1 = Flipped(new AXIStreamIF(UInt(dataWidth.W)))
    val strm = new AXIStreamIF(UInt(dataWidth.W))
  })

  io.strm.suggestName("strm")
  io.in0.suggestName("in0")
  io.in1.suggestName("in1")

  io.strm.TDATA := Mux(io.sel === 0.U, io.in0.TDATA, io.in1.TDATA)
  io.strm.TVALID := Mux(io.sel === 0.U, io.in0.TVALID, io.in1.TVALID)

  io.in0.TREADY := (io.sel === 0.U) & io.strm.TREADY
  io.in1.TREADY := (io.sel === 1.U) & io.strm.TREADY
}


class DecoupledInputMuxIO[T <: Data](gen: T, numChans: Int) extends Bundle {
  val sel = Input(UInt(log2Ceil(numChans).W))
  val in = Vec(numChans, Flipped(Decoupled(gen)))
  val out = Decoupled(gen)
}

class DecoupledInputMux[T <: Data](gen: T, numChans: Int) extends Module {
  val io = IO(new DecoupledInputMuxIO(gen, numChans))

  io.out.bits := io.in(io.sel).bits
  io.out.valid := io.in(io.sel).valid

  for(i <- 0 until numChans) {
    io.in(i).ready := io.out.ready & (io.sel === i.U)
  }
}

object DecoupledInputMux {
  def apply[T <: Data](sel: UInt, chans: Seq[DecoupledIO[T]]): DecoupledIO[T] = {
    val inst = Module(new DecoupledInputMux(chans(0).bits.cloneType, chans.size)).io
    for(i <- 0 until chans.size) {inst.in(i) <> chans(i)}
    inst.sel := sel
    inst.out
  }
}
