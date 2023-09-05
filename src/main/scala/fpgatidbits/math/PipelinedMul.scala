package fpgatidbits.math

import chisel3._
import chisel3.util._

class PipelinedMultStageData(w: Int, wMul: Int) extends Bundle {
  val signA = Bool()
  val a = UInt(w.W)
  val signB = Bool()
  val b = UInt(w.W)
  val mulRes = UInt((2*wMul).W)
  val addRes = UInt(w.W)
}

// pipelined 64-bit signed multiplier with backpressure support, hardwired
// for 5 stages. not really optimized but it does the job.
// TODOs:
// - add a more flexible generator for configuring latency, op schedule etc.
// - internally uses signed magnitude, overflow may differ from 2s complement
// - control DSP inference for FPGAs that support it (how?)
class SystolicSInt64Mul_5Stage extends BinaryMathOp(64) {
  val latency = 5
  val wMul: Int = 32
  val metad = new PipelinedMultStageData(64, wMul)

  // stage 0: convert to signed magnitude form
  val fxnS0 = {i: BinaryMathOperands => val m = new PipelinedMultStageData(64, wMul)
    m.signA := i.first(63)
    m.signB := i.second(63)
    m.a := Mux(i.first(63), ~i.first+ 1.U, i.first)
    m.b := Mux(i.second(63), ~i.second + 1.U, i.second)
    m.mulRes := 0.U
    m.addRes := 0.U
    m
  }
  val s0 = SystolicReg(io.in.bits, metad, fxnS0, io.in)

  // stages 1-4: pipelined multiply; 1 wMul-bit multiply and 1 64-bit add per
  // stage.
  // fMaker generates the stage transfer function, where offA and offB control
  // where the values to be multiplied will be taken from within the operands
  // and shiftAdd (should be equal to wMul*sum of offsets for prev stage)
  val fMaker = { (offA: Int, offB: Int, shiftAdd: Int) =>
  {i: PipelinedMultStageData => val m = new PipelinedMultStageData(64, wMul)
    m := i
    // multiply offA-th wMul-wide word of A, off-Bth of B
    m.mulRes := i.a((wMul*(offA+1))-1, wMul*offA) * i.b((wMul*(offB+1))-1, wMul*offB)
    // add partial product and addRes from previous stage
    m.addRes := (i.mulRes << shiftAdd.U) + i.addRes
    m
  }
  }

  val s1 = SystolicReg(metad, metad, fMaker(0, 0, 0), s0)
  val s2 = SystolicReg(metad, metad, fMaker(0, 1, 0), s1)
  val s3 = SystolicReg(metad, metad, fMaker(1, 0, wMul), s2)
  // note that we don't use the highest offsets (1, 1) since this multiplier
  // only returns an 64-bit result (offset 1,1 generates only overflow)
  // the last stage is just used for the add (mul is unused)
  val s4 = SystolicReg(metad, metad, fMaker(0, 0, wMul), s3)

  // convert from signed magnitude back to 2s complement on the way out
  s4.ready := io.out.ready
  io.out.valid := s4.valid

  val magnRes = Cat(0.U(1.W), s4.bits.addRes(62, 0))
  val isResultNegative = s4.bits.signA ^ s4.bits.signB
  io.out.bits := Mux(isResultNegative, ~magnRes + 1.U, magnRes)
}