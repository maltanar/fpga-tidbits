package fpgatidbits.streams

import Chisel._
import fpgatidbits.axi._

class ParallelInSerialOut(parWidth: Int, serWidth: Int) extends Module {
  val numShiftSteps = parWidth/serWidth

  val io = new Bundle {
    val parIn = UInt(INPUT, parWidth)
    val parWrEn = Bool(INPUT)
    val serIn = UInt(INPUT, serWidth)
    val serOut = UInt(OUTPUT, serWidth)
    val shiftEn = Bool(INPUT)
  }

  val stages = Vec.fill(numShiftSteps) { Reg(init = UInt(0, serWidth)) }

  when( io.parWrEn ) {
    // load entire register from parallel input
    for(i <- 0 to numShiftSteps-1) {
      stages(i) := io.parIn((i+1)*serWidth-1, i*serWidth)
    }
  } .elsewhen( io.shiftEn ) {
    // load highest stage from serial input
    stages(numShiftSteps-1) := io.serIn
    // shift all stages to the right
    for(i <- 1 to numShiftSteps-1) {
      stages(i-1) := stages(i)
    }
  }

  // provide serial output from lowest stage
  io.serOut := stages(0)
}

class PISOTester(c: ParallelInSerialOut) extends Tester(c) {
  peek(c.io.serOut)
  poke(c.io.shiftEn, 0)
  poke(c.io.serIn, 0)
  poke(c.io.parIn, UInt("xdeadbeefcafebabe", 64).litValue())
  poke(c.io.parWrEn, 0)
  step(1)
  peek(c.io.serOut)
  poke(c.io.parWrEn, 1)
  step(1)
  poke(c.io.parWrEn, 0)

  for(i <-0 to 7) {
    peek(c.io.serOut)
    poke(c.io.shiftEn, 1)
    step(1)
  }

}

object StreamDownsizer {
  def apply(in: DecoupledIO[UInt], outW: Int): DecoupledIO[UInt] = {
    val ds = Module(new AXIStreamDownsizer(in.bits.getWidth(), outW)).io
    ds.in <> in
    ds.out
  }
}

class AXIStreamDownsizer(inWidth: Int, outWidth: Int) extends Module {
  val numShiftSteps = inWidth/outWidth
  val io = new Bundle {
    val in = new AXIStreamSlaveIF(UInt(width = inWidth))
    val out = new AXIStreamMasterIF(UInt(width = outWidth))
  }

  // rename signals to infer AXI stream interfaces in Vivado
  io.in.renameSignals("wide")
  io.out.renameSignals("narrow")

  // the shift register
  val shiftReg = Module(new ParallelInSerialOut(inWidth, outWidth))
  shiftReg.io.parIn := io.in.bits
  shiftReg.io.serIn := UInt(0)
  io.out.bits := UInt(shiftReg.io.serOut)
  shiftReg.io.parWrEn := Bool(false)
  shiftReg.io.shiftEn := Bool(false)

  // FSM and register definitions
  val sWaitInput :: sShift :: sLastStep :: Nil = Enum(UInt(), 3)
  val regState = Reg(init = UInt(sWaitInput))
  val regShiftCount = Reg(init = UInt(0, width = log2Up(numShiftSteps)))

  // default outputs
  io.in.ready := Bool(false)
  io.out.valid := Bool(false)

  // state machine
  switch( regState ) {
    is( sWaitInput ) {
      // enable parallel load to shift register
      shiftReg.io.parWrEn := Bool(true)
      // signal to input that we are ready to go
      io.in.ready := Bool(true)
      // reset the count register
      regShiftCount := UInt(0)
      // wait until data is available at the input
      when ( io.in.valid ) { regState := sShift }
    }

    is( sShift ) {
      // signal to output that data is available
      io.out.valid := Bool(true)
      // wait for ack from output
      when (io.out.ready) {
        // increment shift counter
        regShiftCount := regShiftCount + UInt(1)
        // enable shift
        shiftReg.io.shiftEn := Bool(true)
        // go to last state when appropriate, stay here otherwise
        // note that we don't have to shift the very last step,
        // hence the one before last is numShiftSteps-2
        when (regShiftCount === UInt(numShiftSteps-2)) { regState := sLastStep }
      }
    }

    is( sLastStep ) {
      // signal to output that data is available
      io.out.valid := Bool(true)
      // wait for ack from output
      when (io.out.ready) {
        // next action depends on both the in and out sides
        when ( io.in.valid ) {
          // new data already available on input, grab it
          shiftReg.io.parWrEn := Bool(true)
          io.in.ready := Bool(true)
          // reset counter and go to shift state
          regShiftCount := UInt(0)
          regState := sShift
        } .otherwise {
          // go to sWaitInput
          regState := sWaitInput
        }
      }
    }
  }
}

class AXIStreamDownsizerTester(c: AXIStreamDownsizer) extends Tester(c) {
  // simple tester for a 64-to-16 bit downsizer
  poke(c.io.in.valid, 0)
  poke(c.io.in.bits, 0)
  poke(c.io.out.ready, 0)
  step(1)
  expect(c.io.in.ready, 1)  // ready to pull data
  expect(c.io.out.valid, 0) // no data on output
  // scenario 1:
  // expose a single data beat from in
  poke(c.io.in.bits, UInt("xdeadbeefcafebabe", 64).litValue())
  poke(c.io.in.valid, 1)
  step(1)
  poke(c.io.in.valid, 0)
  expect(c.io.in.ready, 0)  // no more pull
  expect(c.io.out.valid, 1) // data on output
  expect(c.io.out.bits, UInt("xbabe", 16).litValue())
  step(1)
  // data on output stays the same since no ready from out
  expect(c.io.in.ready, 0)
  expect(c.io.out.valid, 1)
  expect(c.io.out.bits, UInt("xbabe", 16).litValue())
  poke(c.io.out.ready, 1)
  step(1)
  expect(c.io.out.valid, 1)
  expect(c.io.out.bits, UInt("xcafe", 16).litValue())
  step(1)
  expect(c.io.out.valid, 1)
  expect(c.io.out.bits, UInt("xbeef", 16).litValue())
  step(1)
  expect(c.io.out.valid, 1)
  expect(c.io.out.bits, UInt("xdead", 16).litValue())
  step(1)
  // since no data on input, should go back to sWaitInput
  expect(c.io.in.ready, 1)  // ready to pull data
  expect(c.io.out.valid, 0) // no data on output

  // scenario 2:
  // starts identical to scenario 1,
  // expose another beat right after the first one
  poke(c.io.in.bits, UInt("xdeadbeefcafebabe", 64).litValue())
  poke(c.io.in.valid, 1)
  step(1)
  expect(c.io.in.ready, 0)  // no more pull
  expect(c.io.out.valid, 1) // data on output
  poke(c.io.out.ready, 1)
  expect(c.io.out.bits, UInt("xbabe", 16).litValue())
  step(1)
  expect(c.io.out.valid, 1)
  expect(c.io.out.bits, UInt("xcafe", 16).litValue())
  step(1)
  expect(c.io.out.valid, 1)
  expect(c.io.out.bits, UInt("xbeef", 16).litValue())
  step(1)
  expect(c.io.out.valid, 1)
  expect(c.io.out.bits, UInt("xdead", 16).litValue())
  poke(c.io.in.bits, UInt("xf00dc0debeadfeed", 64).litValue())
  poke(c.io.in.valid, 1)
  expect(c.io.in.ready, 1)  // ready to pull data
  step(1)
  poke(c.io.in.valid, 0)
  // should go right to sShift
  expect(c.io.in.ready, 0)  // no more parallel load
  expect(c.io.out.valid, 1) // serial data available
  expect(c.io.out.bits, UInt("xfeed", 16).litValue())
  poke(c.io.out.ready, 1)
  step(1)
  expect(c.io.out.valid, 1)
  expect(c.io.out.bits, UInt("xbead", 16).litValue())
  step(1)
  expect(c.io.out.valid, 1)
  expect(c.io.out.bits, UInt("xc0de", 16).litValue())
  step(1)
  expect(c.io.out.valid, 1)
  expect(c.io.out.bits, UInt("xf00d", 16).litValue())
  step(1)
  // should be back to sWaitInput
  expect(c.io.in.ready, 1)  // ready to pull data
  expect(c.io.out.valid, 0) // no data on output
}
