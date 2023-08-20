package fpgatidbits.streams

import Chisel._
import fpgatidbits.axi._

class StreamResizer(inWidth: Int, outWidth: Int) extends Module {
  val io = new Bundle {
    val in = new AXIStreamSlaveIF(UInt(width = inWidth))
    val out = new AXIStreamMasterIF(UInt(width = outWidth))
  }
  if(inWidth == outWidth) {
    // no need for any resizing, directly connect in/out
    io.out.valid := io.in.valid
    io.out.bits := io.in.bits
    io.in.ready := io.out.ready
  } else if(inWidth < outWidth) {
    Predef.assert(outWidth % inWidth == 0)
    StreamUpsizer(io.in, outWidth) <> io.out
  } else if(inWidth > outWidth) {
    Predef.assert(inWidth % outWidth == 0)
    StreamDownsizer(io.in, outWidth) <> io.out
  }
}
