package fpgatidbits.math

import Chisel._

class BinaryMathOperands(val w: Int) extends Bundle {
  val first = UInt(width = w)
  val second = UInt(width = w)

  override def clone = {
    new BinaryMathOperands(w).asInstanceOf[this.type]
  }
}

object BinaryMathOperands {
  def apply(first: UInt, second: UInt) = {
    if(first.getWidth() != second.getWidth()) {
      throw new Exception("Operand widths do not match")
    }
    val sop = new BinaryMathOperands(first.getWidth())
    sop.first := first
    sop.second := second
    sop
  }
}

class BinaryMathOpIO(w: Int) extends Bundle {
  val in = Decoupled(new BinaryMathOperands(w)).flip
  val out = Decoupled(UInt(width = w))
}

// abstract base class for binary operators
// exposes a Valid-wrapped (UInt, UInt) => UInt interface, and the op latency
abstract class BinaryMathOp(val w: Int) extends Module {
  val io = new BinaryMathOpIO(w)
  def latency: Int
}

// systolic reg to parametrize op stages flexibly
// this essentially behaves like a single-element queue with no
// fallthrough, so it can be used to add forced latency to an op
// the ready signal is still combinatorially linked to allow fast
// handshakes, like a Chisel queue with pipe=true flow=false
// supports defining a transfer function from input to output, to support
// building decoupled pipelined operators
// parameters:

class SystolicRegParams[TI <: Data, TO <: Data](
  val tIn: TI, // wIn: width of input stream in bits
  val tOut: TO, // wOut: width of output stream in bits
  val fxn: TI => TO // fxn: function to apply on the way out
)

class SystolicReg[TI <: Data, TO <: Data](val p: SystolicRegParams[TI, TO])
extends Module {
  val io = new Bundle {
    val in = Decoupled(p.tIn.cloneType).flip
    val out = Decoupled(p.tOut.cloneType)
  }
  val regValid = Reg(init = Bool(false))
  val resetVal = UInt(0, width = p.tOut.getWidth())
  val regData = RegInit[TO](p.tOut.fromBits(resetVal))
  val allowNewData = (!regValid || io.out.ready)

  io.out.bits := regData
  io.out.valid := regValid
  io.in.ready := allowNewData
  // somehow this needs to be outside the when (mux) below,
  // otherwise Chisel complains about "no default value on wire"
  val updData: TO = p.fxn(io.in.bits)

  when(allowNewData) {
    regData := updData
    regValid := io.in.valid
  }
}

// convenience constructor for SystolicReg
object SystolicReg {
  def apply(w: Int) = {
    val uintP = new SystolicRegParams[UInt, UInt](
      UInt(width = w), UInt(width = w), fxn = {x: UInt => x}
    )
    Module(new SystolicReg[UInt, UInt](uintP)).io
  }
  def apply[TI <: Data, TO <: Data](tIn: TI, tOut: TO, fxn: TI => TO) = {
    val p = new SystolicRegParams[TI,TO](tIn, tOut, fxn)
    Module(new SystolicReg[TI,TO](p)).io
  }

  def apply[TI <: Data, TO <: Data](tIn: TI, tOut: TO, fxn: TI => TO,
    in: DecoupledIO[TI]
  ) = {
    val p = new SystolicRegParams[TI,TO](tIn, tOut, fxn)
    val mod = Module(new SystolicReg[TI,TO](p)).io
    in <> mod.in
    mod.out
  }
}
