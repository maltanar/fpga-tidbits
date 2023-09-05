package fpgatidbits.streams

import chisel3._
import chisel3.util._

class StreamReducer(w: Int, initVal: Int, fxn: (UInt,UInt)=>UInt) extends Module {

  val io = IO(new Bundle {
    val start = Input(Bool())
    val finished = Output(Bool())
    val reduced = Output(UInt(w.W))
    val byteCount = Input(UInt(32.W))
    val streamIn = Flipped(Decoupled(UInt(w.W)))
  })
  val bytesPerElem = w/8

  val sIdle :: sRunning :: sFinished :: Nil = Enum(3)
  val regState = RegInit((sIdle))
  val regReduced = RegInit(initVal.U(w.W))
  val regBytesLeft = RegInit(0.U(32.W))

  io.finished := false.B
  io.reduced := regReduced
  io.streamIn.ready := false.B

  switch(regState) {
      is(sIdle) {
        regReduced := initVal.U
        regBytesLeft := io.byteCount

        when (io.start) { regState := sRunning }
      }

      is(sRunning) {
        when (regBytesLeft === 0.U) { regState := sFinished}
        .otherwise {
          io.streamIn.ready := true.B
          when (io.streamIn.valid) {
            regReduced := fxn(regReduced, io.streamIn.bits)
            regBytesLeft := regBytesLeft - (bytesPerElem).U
          }
        }
      }

      is(sFinished) {
        io.finished := true.B
        when (!io.start) { regState := sIdle}
      }
  }
}
