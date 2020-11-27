package fpgatidbits.streams

import chisel3._
import chisel3.util._
import fpgatidbits.axi._

class SerialInParallelOutIO(parWidth: Int, serWidth: Int) extends Bundle {
  val serIn = Input(UInt(serWidth.W))
  val parOut = Output(UInt(parWidth.W))
  val shiftEn = Input(Bool())

  override def cloneType: this.type =
    new SerialInParallelOutIO(parWidth, serWidth).asInstanceOf[this.type]
}

class SerialInParallelOut(parWidth: Int, serWidth: Int) extends Module {
  val numShiftSteps = parWidth/serWidth

  val io = IO(new SerialInParallelOutIO(parWidth, serWidth))
  val stages = RegInit(VecInit(Seq.fill(numShiftSteps)(0.U(serWidth.W))))

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
  val io = IO(new Bundle {
    val in = Flipped(new AXIStreamIF(UInt(inWidth.W)))
    val out = new AXIStreamIF(UInt(outWidth.W))
  })
  if(inWidth >= outWidth) {
    println("AXIStreamUpsizer needs inWidth < outWidth")
    System.exit(-1)
  }
  val numShiftSteps = outWidth/inWidth
  val shiftReg = Module(new SerialInParallelOut(outWidth, inWidth)).io
  shiftReg.serIn := io.in.TDATA
  shiftReg.shiftEn := false.B

  io.in.TREADY := false.B
  io.out.TVALID := false.B
  io.out.TDATA := shiftReg.parOut

  val sWaitInput :: sWaitOutput :: Nil = Enum(2)
  val regState = RegInit(sWaitInput)

  val regAcquiredStages = RegInit(0.U(32.W))
  val readyForOutput = (regAcquiredStages === (numShiftSteps-1).U)

  switch(regState) {
      is(sWaitInput) {
        io.in.TREADY := true.B
        when (io.in.TVALID) {
          shiftReg.shiftEn := true.B
          regAcquiredStages := regAcquiredStages + 1.U
          regState := Mux(readyForOutput, sWaitOutput, sWaitInput)
        }
      }
      is(sWaitOutput) {
        io.out.TVALID := true.B
        when (io.out.TREADY) {
          regAcquiredStages := 0.U
          regState := sWaitInput
        }
      }
  }
}

object StreamUpsizer {
  def apply(in: AXIStreamIF[UInt], outW: Int, outGen: AXIStreamIF[UInt]): AXIStreamIF[UInt] = {
    val ds = Module(new AXIStreamUpsizer(in.TDATA.getWidth, outW)).io
    ds.in <> in
    ds.out
  }

  def apply(in: DecoupledIO[UInt], outW: Int, outGen: DecoupledIO[UInt]): DecoupledIO[UInt] = {
    val ds = Module(new AXIStreamUpsizer(in.bits.getWidth, outW)).io
    ds.in.TDATA := in.bits
    ds.in.TVALID := in.valid
    in.ready := ds.in.TREADY

    val decoupled_out = Decoupled(UInt(outW.W))
    ds.out.TREADY := decoupled_out.ready
    decoupled_out.bits := ds.out.TDATA
    decoupled_out.valid := ds.out.TVALID

    decoupled_out
  }

  def apply(in: AXIStreamIF[UInt], outW: Int, outGen: DecoupledIO[UInt]): DecoupledIO[UInt] = {
    val ds = Module(new AXIStreamUpsizer(in.TDATA.getWidth, outW)).io
    ds.in <> in

    val decoupled_out = Decoupled(UInt(outW.W))
    ds.out.TREADY := decoupled_out.ready
    decoupled_out.bits := ds.out.TDATA
    decoupled_out.valid := ds.out.TVALID

    decoupled_out
  }

  def apply(in: DecoupledIO[UInt], outW: Int, outGen: AXIStreamIF[UInt] ): AXIStreamIF[UInt] = {
    val ds = Module(new AXIStreamUpsizer(in.bits.getWidth, outW)).io
    ds.in.TDATA := in.bits
    ds.in.TVALID := in.valid
    in.ready := ds.in.TREADY
    ds.out
  }
}




/*

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
*/