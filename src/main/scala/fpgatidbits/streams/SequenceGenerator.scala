package fpgatidbits.streams

import Chisel._

// Generates an arithmetic sequence with a given <init> and <step>
// with <count> elements. Example: <init>=1 <step>=2 <count>=4
// seq = 1 3 5 7
class SequenceGenerator(w: Int, a: Int = 32) extends Module {
  val io = new Bundle {
    val start = Bool(INPUT)
    val init = UInt(INPUT, width = w)
    val count = UInt(INPUT, width = a)
    val step = UInt(INPUT, width = w)
    val finished = Bool(OUTPUT)
    val seq = Decoupled(UInt(width = w))
  }

  val regSeqElem = Reg(init = UInt(0, w))
  val regCounter = Reg(init = UInt(0, a))
  val regMaxCount = Reg(init = UInt(0, a))
  val regStep = Reg(init = UInt(0, a))
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
          regCounter := UInt(0)
          regMaxCount := io.count
          regSeqElem := io.init
        }
      }

      is(sRun) {
        when (regCounter === regMaxCount) {
          regState := sFinished
        } .otherwise {
          io.seq.valid := Bool(true)
          when(io.seq.ready) {
            regCounter := regCounter + UInt(1)
            regSeqElem := regSeqElem + regStep
          }
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

// convenience constructor for natural numbers
object NaturalNumbers {
  def apply(w: Int, start: Bool, count: UInt) = {
    val m = Module(new SequenceGenerator(w)).io
    m.start := start
    m.init := UInt(0)
    m.count := count
    m.step := UInt(1)
    m.seq
  }
}
