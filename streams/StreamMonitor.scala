package TidbitsStreams

import Chisel._

// while enabled, monitors the ready-valid inputs of a given stream
// and keeps track of #active cycles (where both ready and valid were high)
// as well as the total # cycles

object StreamMonitor {
  def apply[T <: Data](stream: DecoupledIO[T], enable: Bool): StreamMonitorOutIF = {
    val mon = Module(new StreamMonitor()).io
    mon.enable := enable
    mon.validIn := stream.valid
    mon.readyIn := stream.ready
    return mon.out
  }
}

class StreamMonitorOutIF() extends Bundle {
  val totalCycles = UInt(OUTPUT, 32)
  val activeCycles = UInt(OUTPUT, 32)
}

class StreamMonitor() extends Module {
  val io = new Bundle {
    val enable = Bool(INPUT)
    val validIn = Bool(INPUT)
    val readyIn = Bool(INPUT)
    val out = new StreamMonitorOutIF()
  }
  val sIdle :: sRun :: Nil = Enum(UInt(), 2)
  val regState = Reg(init = UInt(sIdle))

  val regActiveCycles = Reg(init = UInt(0, 32))
  val regTotalCycles = Reg(init = UInt(0, 32))

  io.out.totalCycles := regTotalCycles
  io.out.activeCycles := regActiveCycles

  switch(regState) {
      is(sIdle) {
        when(io.enable) {
          regState := sRun
          regActiveCycles := UInt(0)
          regTotalCycles := UInt(0)
        }
      }

      is(sRun) {
        when(!io.enable) { regState := sIdle}
        .otherwise {
          regTotalCycles := regTotalCycles + UInt(1)
          when (io.validIn & io.readyIn) {
            regActiveCycles := regActiveCycles + UInt(1)
          }
        }
      }
  }
}
