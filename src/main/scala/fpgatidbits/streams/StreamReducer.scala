package fpgatidbits.streams

import Chisel._

class StreamReducer(w: Int, initVal: Int, fxn: (UInt,UInt)=>UInt) extends Module {

  val io = new Bundle {
    val start = Input(Bool())
    val finished = Output(Bool())
    val reduced = UInt(OUTPUT, width = w )
    val byteCount = UInt(INPUT, width = 32)
    val streamIn = Decoupled(UInt(width = w)).flip
  }
  val bytesPerElem = w/8

  val sIdle :: sRunning :: sFinished :: Nil = Enum(UInt(), 3)
  val regState = Reg(init = UInt(sIdle))
  val regReduced = Reg(init = UInt(initVal, width = w))
  val regBytesLeft = Reg(init = UInt(0, 32))

  io.finished := false.B
  io.reduced := regReduced
  io.streamIn.ready := false.B

  switch(regState) {
      is(sIdle) {
        regReduced := UInt(initVal)
        regBytesLeft := io.byteCount

        when (io.start) { regState := sRunning }
      }

      is(sRunning) {
        when (regBytesLeft === 0.U) { regState := sFinished}
        .otherwise {
          io.streamIn.ready := true.B
          when (io.streamIn.valid) {
            regReduced := fxn(regReduced, io.streamIn.bits)
            regBytesLeft := regBytesLeft - UInt(bytesPerElem)
          }
        }
      }

      is(sFinished) {
        io.finished := true.B
        when (!io.start) { regState := sIdle}
      }
  }
}
