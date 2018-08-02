package fpgatidbits.streams

import Chisel._

// Generates an arithmetic sequence with a given <init> and <step>
// going up to a max of <cap>. Example: <init>=1 <step>=2 <cap>=6
// seq = 1 3 5 6
class SequenceGeneratorCapped(w: Int) extends Module {
  val io = new Bundle {
    val start = Bool(INPUT)
    val init = UInt(INPUT, width = w)
    val cap = UInt(INPUT, width = w)
    val step = UInt(INPUT, width = w)
    val finished = Bool(OUTPUT)
    val seq = Decoupled(UInt(width = w))
  }

  val regSeqElem = Reg(init = UInt(0, w))
  val regStep = Reg(init = UInt(0, w))
  io.finished := Bool(false)
  io.seq.valid := Bool(false)
  io.seq.bits := regSeqElem

  val sIdle :: sRun :: sFinished :: Nil = Enum(UInt(), 3)
  val regState = Reg(init = UInt(sIdle))

  switch(regState) {
      is(sIdle) {
        when(io.start) {
          regStep := io.step
          regState := sRun
          regCap := io.cap
          regSeqElem := io.init
        }
      }

      is(sRun) {
        io.seq.valid := Bool(true)
        when(io.seq.ready) {
          val next_cand = regSeqElem + regStep
          regSeqElem := Mux(next_cand > regCap, regCap, next_cand)
          regState := Mux(regSeqElem === regCap, sFinished, sRun)
        }
      }

      is(sFinished) {
        io.finished := Bool(true)
        when(!io.start) {
          regState := sIdle
        }
      }
  }
}
