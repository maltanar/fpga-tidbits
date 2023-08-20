package fpgatidbits.math

package fpgatidbits.math

import chisel3._

// a simple counter incrementing by 1 every clock cycle when io.enable is set
// up to io.nsteps-1 (upon which io.overflow will be 1), then back to 0
// make sure io.nsteps is held for at least 1 cycle after a change. before
// starting a new counting operation
class Counter(w: Int) extends Module {
  val io = new Bundle {
    val nsteps = Input(UInt(w.W))
    val current = Output(UInt(w.W))
    val enable = Input(Bool())
    val full = Output(Bool())
  }
  val regCount = RegInit(0.U(w.W))
  val regMax = RegNext(io.nsteps - 1.U)
  val limitReached = (regCount === regMax)
  when(io.enable) {
    regCount := Mux(limitReached, 0.U, regCount + 1.U)
  }
  io.full := limitReached
  io.current := regCount
}
