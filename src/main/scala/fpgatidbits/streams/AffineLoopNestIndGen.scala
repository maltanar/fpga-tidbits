package fpgatidbits.streams

import chisel3._
import chisel3.util._

import fpgatidbits.math.Counter

// bundle that describes the iteration space, or a single point
// in the iteration space, of an affine loop
// n: number of nesting levels in the loop
// w: bitwidth of iteration count of a level
class AffineLoopNestDescriptor(n: Int, w: Int) extends Bundle {
  // element 0 is the innermost loop
  val inds = Vec(n, UInt(w.W))
}

// given the number of iterations for a nested affine loop,
// generate the iteration space
// n: number of nesting levels in the loop
// w: bitwidth of iteration count of a level
class AffineLoopNestIndGen(val n: Int, val w: Int) extends Module {
  val io = new Bundle {
    val in = Flipped(Decoupled(new AffineLoopNestDescriptor(n, w)))
    val out = Decoupled(new AffineLoopNestDescriptor(n, w))
  }
  val doStep = WireDefault(false.B)
  // register to keep current descriptor with bounds
  val regBounds = RegInit(io.in.bits)
  // instantiate counters, one for each loop level
  val cntrs = for (i <- 0 until n) yield Module(new Counter(w)).io
  // default values for signals
  io.in.ready := false.B
  io.out.valid := false.B
  // wire up counters
  for(i <- 0 until n) {
    io.out.bits.inds(i) := cntrs(i).current
    cntrs(i).nsteps := regBounds.inds(i)
    if(i == 0) {
      cntrs(i).enable := doStep
    } else {
      cntrs(i).enable := cntrs(i-1).full & cntrs(i-1).enable & doStep
    }
  }
  // finite state machine for decoupled logic
  val sIdle :: sWaitCounterInit :: sRun :: Nil = Enum(3)
  val regState = RegInit(sIdle)
  switch(regState) {
    is(sIdle) {
      io.in.ready := true.B
      when(io.in.valid) {
        regBounds := io.in.bits
        regState := sWaitCounterInit
      }
    }
    is(sWaitCounterInit) {
      regState := sRun
      // TODO consider removing regMax reg from counter to avoid
      // the sWaitCounterInit state
    }
    is(sRun) {
      io.out.valid := true.B
      when(io.out.ready) {
        // note: we send doStep to make all ctrs go back to 0 also at the end
        doStep := true.B
        // finished when the outermost loop level is finished
        when(cntrs(n-1).full && cntrs(n-1).enable) {
          regState := sIdle
        }
      }
    }
  }
}
