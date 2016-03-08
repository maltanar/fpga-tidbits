package fpgatidbits.streams

import Chisel._

class StreamReducer(w: Int, initVal: Int, fxn: (UInt,UInt)=>UInt) extends Module {

  val io = new Bundle {
    val start = Bool(INPUT)
    val finished = Bool(OUTPUT)
    val reduced = UInt(OUTPUT, width = w )
    val byteCount = UInt(INPUT, width = 32)
    val streamIn = Decoupled(UInt(width = w)).flip
  }
  val bytesPerElem = w/8

  val sIdle :: sRunning :: sFinished :: Nil = Enum(UInt(), 3)
  val regState = Reg(init = UInt(sIdle))
  val regReduced = Reg(init = UInt(initVal, width = w))
  val regBytesLeft = Reg(init = UInt(0, 32))

  io.finished := Bool(false)
  io.reduced := regReduced
  io.streamIn.ready := Bool(false)

  switch(regState) {
      is(sIdle) {
        regReduced := UInt(initVal)
        regBytesLeft := io.byteCount

        when (io.start) { regState := sRunning }
      }

      is(sRunning) {
        when (regBytesLeft === UInt(0)) { regState := sFinished}
        .otherwise {
          io.streamIn.ready := Bool(true)
          when (io.streamIn.valid) {
            regReduced := fxn(regReduced, io.streamIn.bits)
            regBytesLeft := regBytesLeft - UInt(bytesPerElem)
          }
        }
      }

      is(sFinished) {
        io.finished := Bool(true)
        when (!io.start) { regState := sIdle}
      }
  }
}
