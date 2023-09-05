package fpgatidbits.streams

import chisel3._
import chisel3.util._

// limits the amount of data passing through a stream
// - when not started, the stream just passes through unhindered
// - after start (must be held high), first <byteCount> bytes of the
//   stream pass through. afterwards, no further data is sent to the output.
//   the input stream is allowed to drain out in order not to clog the upstream.

object StreamLimiter {
  def apply(in: DecoupledIO[UInt], start: Bool, count: UInt): DecoupledIO[UInt] = {
    val limiter = Module(new StreamLimiter(in.bits.getWidth)).io
    limiter.start := start
    limiter.byteCount := count
    limiter.streamIn <> in
    limiter.streamOut
  }
}

class StreamLimiter(w: Int) extends Module {
  val io = IO(new Bundle {
    val start = Input(Bool())
    val done = Output(Bool())
    val byteCount = Input(UInt(32.W))
    val streamIn = Flipped(Decoupled(UInt(w.W)))
    val streamOut = Decoupled(UInt(w.W))
  })

  io.done := false.B

  io.streamOut.bits := io.streamIn.bits
  io.streamOut.valid := io.streamIn.valid
  io.streamIn.ready := io.streamOut.ready

  val sIdle :: sRun :: sFinished :: Nil = Enum(3)
  val regState = RegInit((sIdle))

  val regBytesLeft = RegInit(0.U(32.W))

  switch(regState) {
      is(sIdle) {
        regBytesLeft := io.byteCount
        when(io.start) {regState := sRun}
      }

      is(sRun) {
        // count each transaction and decrement counter
        when (io.streamIn.valid & io.streamOut.ready) {
          regBytesLeft := regBytesLeft - (w/8).U
          when (regBytesLeft === (w/8).U) {regState := sFinished}
        }
      }

      is(sFinished) {
        // do not let any more transactions through towards out
        io.streamOut.valid := false.B
        // let upstream sources continue, do not clog the pipes
        io.streamIn.ready := true.B
        // signal finished
        io.done := true.B
        when(!io.start) {regState := sIdle}
      }
  }
}
