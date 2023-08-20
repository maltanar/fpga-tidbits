package fpgatidbits.streams

import chisel3._

// Generates a "blocked" sequence from a sequence descriptor
// example: descriptor start = 100 count = 10 blockSize = 3
// output sequence:
// start: 100   103   106   109
// count: 3     3     3     1

class BlockSequenceDescriptor(w: Int) extends Bundle {
  val start = UInt(w.W)     // starting element
  val count = UInt(w.W)     // total elements
  val blockSize = UInt(w.W) // preferred block size

  override def clone = {
    new BlockSequenceDescriptor(w).asInstanceOf[this.type]
  }
}

class BlockSequenceOutput(w: Int) extends Bundle {
  val count = UInt(w.W)
  val start = UInt(w.W)

  override def clone = {
    new BlockSequenceOutput(w).asInstanceOf[this.type]
  }
}

class BlockSequenceGenerator(w: Int) extends Module {
  val io = new Bundle {
    val cmd = Decoupled(new BlockSequenceDescriptor(w)).flip
    val out = Decoupled(new BlockSequenceOutput(w))
  }

  val regPtr = Reg(init = UInt(0, w))
  val regBlockSize = Reg(init = UInt(0, w))
  val regElemsLeft = Reg(init = UInt(0, w))

  io.cmd.ready := false.B
  io.out.valid := false.B
  io.out.bits.count := 0.U
  io.out.bits.start := regPtr

  val sIdle :: sRun :: sLast :: Nil = Enum(UInt(), 3)
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
