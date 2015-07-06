package TidbitsStreams

import Chisel._
import TidbitsAXI._

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
