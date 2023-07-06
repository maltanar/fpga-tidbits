package fpgatidbits.streams

import chisel3._
import chisel3.util._
import fpgatidbits.axi._

class ParallelInSerialOut(parWidth: Int, serWidth: Int) extends Module {
  val numShiftSteps = parWidth/serWidth

  val io = IO(new Bundle {
    val parIn = Input(UInt(parWidth.W))
    val parWrEn = Input(Bool())
    val serIn = Input(UInt(serWidth.W))
    val serOut = Output(UInt(serWidth.W))
    val shiftEn = Input(Bool())
  })

  val stages = RegInit(VecInit(Seq.fill(numShiftSteps)(0.U(serWidth.W))))

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

/*

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

 */

object StreamDownsizer {
  def apply(in: AXIStreamIF[UInt], outW: Int, outGen: AXIStreamIF[UInt] ): AXIStreamIF[UInt] = {
    val ds = Module(new AXIStreamDownsizer(in.TDATA.getWidth, outW))
    ds.in <> in
    ds.out
  }

  def apply(in: DecoupledIO[UInt], outW: Int, outGen: DecoupledIO[UInt]): DecoupledIO[UInt] = {
    val ds = Module(new AXIStreamDownsizer(in.bits.getWidth, outW))
    ds.in.TDATA := in.bits
    ds.in.TVALID := in.valid
    in.ready := ds.in.TREADY

    val decoupled_out = Wire(Decoupled(UInt(outW.W)))
    ds.out.TREADY := decoupled_out.ready
    decoupled_out.bits := ds.out.TDATA
    decoupled_out.valid := ds.out.TVALID

    decoupled_out
  }

  def apply(in: AXIStreamIF[UInt], outW: Int, outGen: DecoupledIO[UInt]): DecoupledIO[UInt] = {
    val ds = Module(new AXIStreamDownsizer(in.TDATA.getWidth, outW))
    ds.in <> in

    val decoupled_out = Decoupled(UInt(outW.W))
    ds.out.TREADY := decoupled_out.ready
    decoupled_out.bits := ds.out.TDATA
    decoupled_out.valid := ds.out.TVALID

    decoupled_out
  }

  def apply(in: DecoupledIO[UInt], outW: Int, outGen: AXIStreamIF[UInt]): AXIStreamIF[UInt] = {
    val ds = Module(new AXIStreamDownsizer(in.bits.getWidth, outW))
    ds.in.TDATA := in.bits
    ds.in.TVALID := in.valid
    in.ready := ds.in.TREADY
    ds.out
  }
}

class AXIStreamDownsizer(inWidth: Int, outWidth: Int) extends Module {
  val numShiftSteps = inWidth/outWidth


  val in = IO(Flipped(new AXIStreamIF(UInt(inWidth.W)))).suggestName("wide")
  val out = IO(new AXIStreamIF(UInt(outWidth.W))).suggestName("narrow")


  // the shift register
  val shiftReg = Module(new ParallelInSerialOut(inWidth, outWidth))
  shiftReg.io.parIn := in.TDATA
  shiftReg.io.serIn := 0.U
  out.TDATA := (shiftReg.io.serOut)
  shiftReg.io.parWrEn := false.B
  shiftReg.io.shiftEn := false.B

  // FSM and register definitions
  val sWaitInput :: sShift :: sLastStep :: Nil = Enum(3)
  val regState = RegInit(sWaitInput)
  val regShiftCount = RegInit(0.U(log2Ceil(numShiftSteps).W))

  // default outputs
  in.TREADY := false.B
  out.TVALID := false.B

  // state machine
  switch( regState ) {
    is( sWaitInput ) {
      // enable parallel load to shift register
      shiftReg.io.parWrEn := true.B
      // signal to input that we are ready to go
      in.TREADY := true.B
      // reset the count register
      regShiftCount := 0.U
      // wait until data is available at the input
      when ( in.TVALID ) { regState := sShift }
    }

    is( sShift ) {
      // signal to output that data is available
      out.TVALID := true.B
      // wait for ack from output
      when (out.TREADY) {
        // increment shift counter
        regShiftCount := regShiftCount + 1.U
        // enable shift
        shiftReg.io.shiftEn := true.B
        // go to last state when appropriate, stay here otherwise
        // note that we don't have to shift the very last step,
        // hence the one before last is numShiftSteps-2
        when (regShiftCount === (numShiftSteps.U-2.U)) { regState := sLastStep }
      }
    }

    is( sLastStep ) {
      // signal to output that data is available
      out.TVALID := true.B
      // wait for ack from output
      when (out.TREADY) {
        // next action depends on both the in and out sides
        when ( in.TVALID ) {
          // new data already available on input, grab it
          shiftReg.io.parWrEn := true.B
          in.TREADY := true.B
          // reset counter and go to shift state
          regShiftCount := 0.U
          regState := sShift
        } .otherwise {
          // go to sWaitInput
          regState := sWaitInput
        }
      }
    }
  }
}


/*
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

*/
