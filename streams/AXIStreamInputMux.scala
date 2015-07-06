package TidbitsStreams

import Chisel._
import TidbitsAXI._

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
