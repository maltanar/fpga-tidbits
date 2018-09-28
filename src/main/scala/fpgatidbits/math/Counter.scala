package fpgatidbits.math

import Chisel._

// a simple counter incrementing by 1 every clock cycle when io.enable is set
// up to io.nsteps-1 (upon which io.overflow will be 1), then back to 0
// make sure io.nsteps is held for at least 1 cycle after a change. before
// starting a new counting operation

class Counter(w: Int) extends Module {
  val io = new Bundle {
    val nsteps = UInt(INPUT, width = w)
    val current = UInt(OUTPUT, width = w)
    val enable = Bool(INPUT)
    val full = Bool(OUTPUT)
  }
  val regCount = Reg(init = UInt(0, w))
  val regMax = Reg(next = io.nsteps - UInt(1))
  val limitReached = (regCount === regMax)
  when(io.enable) {
    regCount := Mux(limitReached, UInt(0, w), regCount + UInt(1))
  }
  io.full := limitReached
  io.current := regCount
}
