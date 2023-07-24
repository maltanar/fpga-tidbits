package fpgatidbits.streams

import Chisel._

// Generates a "blocked" sequence from a sequence descriptor
// example: descriptor start = 100 count = 10 blockSize = 3
// output sequence:
// start: 100   103   106   109
// count: 3     3     3     1

class BlockSequenceDescriptor(w: Int) extends Bundle {
  val start = UInt(width = w)     // starting element
  val count = UInt(width = w)     // total elements
  val blockSize = UInt(width = w) // preferred block size

  override def clone = {
    new BlockSequenceDescriptor(w).asInstanceOf[this.type]
  }
}

class BlockSequenceOutput(w: Int) extends Bundle {
  val start = UInt(width = w)
  val count = UInt(width = w)

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

  io.cmd.ready := Bool(false)
  io.out.valid := Bool(false)
  io.out.bits.count := UInt(0)
  io.out.bits.start := regPtr

  val sIdle :: sRun :: sLast :: Nil = Enum(UInt(), 3)
  val regState = Reg(init = UInt(sIdle))

  switch(regState) {
    is(sIdle) {
      io.cmd.ready := Bool(true)
      when(io.cmd.valid) {
        regPtr := io.cmd.bits.start
        regBlockSize := io.cmd.bits.blockSize
        regElemsLeft := io.cmd.bits.count
        regState := sRun
      }
    }

    is(sRun) {
      when(regElemsLeft > regBlockSize) {
        io.out.valid := Bool(true)
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
      io.out.valid := Bool(true)
      io.out.bits.count := regElemsLeft
      when(io.out.ready) {
        regState := sIdle
      }
    }
  }
}
