package fpgatidbits.streams

import chisel3._
import chisel3.util._

// Generates an arithmetic sequence with a given <init> and <step>
// with <count> elements. Example: <init>=1 <step>=2 <count>=4
// seq = 1 3 5 7
class SequenceGenerator(w: Int, a: Int = 32) extends Module {
  val io = IO(new Bundle {
    val start = Input(Bool())
    val init = Input(UInt(w.W))
    val count = Input(UInt(a.W))
    val step = Input(UInt(w.W))
    val finished = Output(Bool())
    val seq = Decoupled(UInt(w.W))
  })

  val regSeqElem = RegInit(0.U(w.W))
  val regCounter = RegInit(0.U(a.W))
  val regMaxCount = RegInit(0.U(a.W))
  val regStep = RegInit(0.U(a.W))
  io.finished := false.B
  io.seq.valid := false.B
  io.seq.bits := regSeqElem

  val sIdle :: sRun :: sFinished :: Nil = Enum(3)
  val regState = RegInit((sIdle))

  switch(regState) {
      is(sIdle) {
        when(io.start) {
          regStep := io.step
          regState := sRun
          regCounter := 0.U
          regMaxCount := io.count
          regSeqElem := io.init
        }
      }

      is(sRun) {
        when (regCounter === regMaxCount) {
          regState := sFinished
        } .otherwise {
          io.seq.valid := true.B
          when(io.seq.ready) {
            regCounter := regCounter + 1.U
            regSeqElem := regSeqElem + regStep
          }
        }
      }

      is(sFinished) {
        io.finished := true.B
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
    m.init := 0.U
    m.count := count
    m.step := 1.U
    m.seq
  }
}
