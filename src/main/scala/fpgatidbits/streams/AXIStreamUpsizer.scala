package fpgatidbits.streams

import Chisel._
import fpgatidbits.axi._

class SerialInParallelOutIO(parWidth: Int, serWidth: Int) extends Bundle {
  val serIn = UInt(INPUT, serWidth)
  val parOut = UInt(OUTPUT, parWidth)
  val shiftEn = Bool(INPUT)

  override def cloneType: this.type =
    new SerialInParallelOutIO(parWidth, serWidth).asInstanceOf[this.type]
}

class SerialInParallelOut(parWidth: Int, serWidth: Int) extends Module {
  val numShiftSteps = parWidth/serWidth

  val io = new SerialInParallelOutIO(parWidth, serWidth)

  val stages = Vec.fill(numShiftSteps) { Reg(init = UInt(0, serWidth)) }

  when (io.shiftEn) {
    // fill highest stage from serial input
    stages(numShiftSteps-1) := io.serIn
    // shift all stages to the right
    for(i <- 0 until numShiftSteps-1) {
      stages(i) := stages(i+1)
    }
  }
  // Cat does concat as 0 1 2 .. N
  // reverse the order to get N .. 2 1 0
  io.parOut := Cat(stages.reverse)
}


class AXIStreamUpsizer(inWidth: Int, outWidth: Int) extends Module {
  val io = new Bundle {
    val in = new AXIStreamSlaveIF(UInt(width = inWidth))
    val out = new AXIStreamMasterIF(UInt(width = outWidth))
  }
  if(inWidth >= outWidth) {
    println("AXIStreamUpsizer needs inWidth < outWidth")
    System.exit(-1)
  }
  val numShiftSteps = outWidth/inWidth
  val shiftReg = Module(new SerialInParallelOut(outWidth, inWidth)).io
  shiftReg.serIn := io.in.bits
  shiftReg.shiftEn := Bool(false)

  io.in.ready := Bool(false)
  io.out.valid := Bool(false)
  io.out.bits := shiftReg.parOut

  val sWaitInput :: sWaitOutput :: Nil = Enum(UInt(), 2)
  val regState = Reg(init = UInt(sWaitInput))

  val regAcquiredStages = Reg(init = UInt(0, 32))
  val readyForOutput = (regAcquiredStages === UInt(numShiftSteps-1))

  switch(regState) {
      is(sWaitInput) {
        io.in.ready := Bool(true)
        when (io.in.valid) {
          shiftReg.shiftEn := Bool(true)
          regAcquiredStages := regAcquiredStages + UInt(1)
          regState := Mux(readyForOutput, sWaitOutput, sWaitInput)
        }
      }
      is(sWaitOutput) {
        io.out.valid := Bool(true)
        when (io.out.ready) {
          regAcquiredStages := UInt(0)
          regState := sWaitInput
        }
      }
  }
}

object StreamUpsizer {
  def apply(in: DecoupledIO[UInt], outW: Int): DecoupledIO[UInt] = {
    val ds = Module(new AXIStreamUpsizer(in.bits.getWidth(), outW)).io
    ds.in <> in
    ds.out
  }
}

class AXIStreamUpsizerTester(c: AXIStreamUpsizer) extends Tester(c) {
  // simple test 8 -> 32 upsizing
  expect(c.io.in.ready, 1)
  expect(c.io.out.valid, 0)
  poke(c.io.out.ready, 0)
  poke(c.io.in.valid, 1)
  poke(c.io.in.bits, UInt("hef", 8).litValue())
  step(1)
  poke(c.io.in.bits, UInt("hbe", 8).litValue())
  step(1)
  poke(c.io.in.bits, UInt("had", 8).litValue())
  step(1)
  poke(c.io.in.bits, UInt("hde", 8).litValue())
  step(1)
  poke(c.io.in.valid, 0)
  expect(c.io.in.ready, 0)
  expect(c.io.out.valid, 1)
  expect(c.io.out.bits, UInt("hdeadbeef", 32).litValue())
  step(1)
  poke(c.io.out.ready, 1)
  step(1)
  expect(c.io.in.ready, 1)
  expect(c.io.out.valid, 0)
}
