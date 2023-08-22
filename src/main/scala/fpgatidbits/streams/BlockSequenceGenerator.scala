package fpgatidbits.streams

import chisel3._
import chisel3.util._

// Generates a "blocked" sequence from a sequence descriptor
// example: descriptor start = 100 count = 10 blockSize = 3
// output sequence:
// start: 100   103   106   109
// count: 3     3     3     1

class BlockSequenceDescriptor(w: Int) extends Bundle {
  val start = UInt(w.W)     // starting element
  val count = UInt(w.W)     // total elements
  val blockSize = UInt(w.W) // preferred block size
}

class BlockSequenceOutput(w: Int) extends Bundle {
  val count = UInt(w.W)
  val start = UInt(w.W)

}

class BlockSequenceGenerator(w: Int) extends Module {
  val io = new Bundle {
    val cmd = Flipped(Decoupled(new BlockSequenceDescriptor(w)))
    val out = Decoupled(new BlockSequenceOutput(w))
  }

  val regPtr = RegInit(0.U(w.W))
  val regBlockSize = RegInit(0.U(32.W))
  val regElemsLeft = RegInit(0.U(32.W))

  io.cmd.ready := false.B
  io.out.valid := false.B
  io.out.bits.count := 0.U
  io.out.bits.start := regPtr

  val sIdle :: sRun :: sLast :: Nil = Enum(3)
  val regState = RegInit(sIdle)

  switch(regState) {
    is(sIdle) {
      io.cmd.ready := true.B
      when(io.cmd.valid) {
        regPtr := io.cmd.bits.start
        regBlockSize := io.cmd.bits.blockSize
        regElemsLeft := io.cmd.bits.count
        regState := sRun
      }
    }

    is(sRun) {
      when(regElemsLeft > regBlockSize) {
        io.out.valid := true.B
        io.out.bits.count := regBlockSize
        when(io.out.ready) {
          regElemsLeft := regElemsLeft - regBlockSize
          regPtr := regPtr + regBlockSize
        }
      } .otherwise {
        regState := sLast
      }
    }

    is(sLast) {
      io.out.valid := true.B
      io.out.bits.count := regElemsLeft
      when(io.out.ready) {
        regState := sIdle
      }
    }
  }
}
