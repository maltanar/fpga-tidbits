package TidbitsStreams

import Chisel._

// while enabled, monitors the ready-valid inputs of a given stream
// and keeps track of #active cycles (where both ready and valid were high)
// as well as the total # cycles

object StreamMonitor {
  def apply[T <: Data](stream: DecoupledIO[T], enable: Bool,
    streamName: String = "stream"): StreamMonitorOutIF = {
    val mon = Module(new StreamMonitor(streamName))
    mon.io.enable := enable
    mon.io.validIn := stream.valid
    mon.io.readyIn := stream.ready
    return mon.io.out
  }
}

class StreamMonitorOutIF() extends Bundle {
  val totalCycles = UInt(OUTPUT, 32)
  val activeCycles = UInt(OUTPUT, 32)
  val noValidButReady = UInt(OUTPUT, 32)
  val noReadyButValid = UInt(OUTPUT, 32)
}

class StreamMonitor(streamName: String = "stream") extends Module {
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
  val regNoValidButReady = Reg(init = UInt(0, 32))
  val regNoReadyButValid = Reg(init = UInt(0, 32))

  io.out.totalCycles := regTotalCycles
  io.out.activeCycles := regActiveCycles
  io.out.noValidButReady := regNoValidButReady
  io.out.noReadyButValid := regNoReadyButValid

  switch(regState) {
      is(sIdle) {
        when(io.enable) {
          regState := sRun
          regActiveCycles := UInt(0)
          regTotalCycles := UInt(0)
          regNoValidButReady := UInt(0)
          regNoReadyButValid := UInt(0)
        }
      }

      is(sRun) {
        when(!io.enable) { regState := sIdle}
        .otherwise {
          regTotalCycles := regTotalCycles + UInt(1)
          when (io.validIn & !io.readyIn) {
            regNoReadyButValid := regNoReadyButValid + UInt(1)
          }
          when (!io.validIn & io.readyIn) {
            regNoValidButReady := regNoValidButReady + UInt(1)
          }
          when (io.validIn & io.readyIn) {
            regActiveCycles := regActiveCycles + UInt(1)
            // printf only active in Chisel C++ emulator
            printf(streamName + " txn: %d \n", regActiveCycles)
          }
        }
      }
  }
}
