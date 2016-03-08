package fpgatidbits.streams

import Chisel._

// limits the amount of data passing through a stream
// - when not started, the stream just passes through unhindered
// - after start (must be held high), first <byteCount> bytes of the
//   stream pass through. afterwards, no further data is sent to the output.
//   the input stream is allowed to drain out in order not to clog the upstream.

object StreamLimiter {
  def apply(in: DecoupledIO[UInt], start: Bool, count: UInt): DecoupledIO[UInt] = {
    val limiter = Module(new StreamLimiter(in.bits.getWidth())).io
    limiter.start := start
    limiter.byteCount := count
    limiter.streamIn <> in
    limiter.streamOut
  }
}

class StreamLimiter(w: Int) extends Module {
  val io = new Bundle {
    val start = Bool(INPUT)
    val done = Bool(OUTPUT)
    val byteCount = UInt(INPUT, 32)
    val streamIn = Decoupled(UInt(width=w)).flip
    val streamOut = Decoupled(UInt(width=w))
  }

  io.done := Bool(false)

  io.streamOut.bits := io.streamIn.bits
  io.streamOut.valid := io.streamIn.valid
  io.streamIn.ready := io.streamOut.ready

  val sIdle :: sRun :: sFinished :: Nil = Enum(UInt(), 3)
  val regState = Reg(init = UInt(sIdle))

  val regBytesLeft = Reg(init = UInt(0, 32))

  switch(regState) {
      is(sIdle) {
        regBytesLeft := io.byteCount
        when(io.start) {regState := sRun}
      }

      is(sRun) {
        // count each transaction and decrement counter
        when (io.streamIn.valid & io.streamOut.ready) {
          regBytesLeft := regBytesLeft - UInt(w/8)
          when (regBytesLeft === UInt(w/8)) {regState := sFinished}
        }
      }

      is(sFinished) {
        // do not let any more transactions through towards out
        io.streamOut.valid := Bool(false)
        // let upstream sources continue, do not clog the pipes
        io.streamIn.ready := Bool(true)
        // signal finished
        io.done := Bool(true)
        when(!io.start) {regState := sIdle}
      }
  }
}
