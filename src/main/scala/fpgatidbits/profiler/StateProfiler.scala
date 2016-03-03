package fpgatidbits.profiler

import Chisel._

class StateProfiler(StateCount: Int) extends Module {
  val io = new Bundle {
    val start = Bool(INPUT)
    val probe = UInt(INPUT, 32)
    val count = UInt(OUTPUT, 32)
    val sel = UInt(INPUT, log2Up(StateCount))
  }

  // create profiling registers for keeping state counts
  val regStateCount = Vec.fill(StateCount) { Reg(init = UInt(0, 32)) }
  // register input state before treatment
  val regInState = Reg(init = UInt(0, 32), next = io.probe)

  // finite state machine for control
  val sIdle :: sRun :: sFinished :: Nil = Enum(UInt(), 3)
  val regState = Reg(init = UInt(sIdle))

  // default outputs
  io.count := regStateCount(io.sel)

  switch(regState) {
      is(sIdle) {
        when ( io.start ) {
          // move to running state
          regState := sRun
          // reset all profiling registers
          for(i <- 0 until StateCount) {
            regStateCount(i) := UInt(0)
          }
        }
      }

      is(sRun) {
        regStateCount(regInState) := regStateCount(regInState) + UInt(1)
        // finish profiling when start goes low
        when( !io.start ) {
          regState := sIdle
        }
      }
  }
}
