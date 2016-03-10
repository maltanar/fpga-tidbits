package fpgatidbits.streams

import Chisel._

// while enabled, monitors the ready-valid inputs of a given stream
// and keeps track of #active cycles (where both ready and valid were high)
// as well as the total # cycles

object StreamMonitor {
  def apply[T <: Data](stream: DecoupledIO[T], enable: Bool,
    streamName: String = "stream", dbg: Boolean = false): StreamMonitorOutIF = {
    val mon = Module(new StreamMonitor(streamName, dbg))
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

class StreamMonitor(
  streamName: String = "stream",
  dbg: Boolean = false
) extends Module {
  val io = new Bundle {
    val enable = Bool(INPUT)
    val validIn = Bool(INPUT)
    val readyIn = Bool(INPUT)
    val out = new StreamMonitorOutIF()
  }
  val sIdle :: sRun :: Nil = Enum(UInt(), 2)

  // registered version of the inputs
  val regEnable = Reg(next = io.enable)
  val regValidIn = Reg(next = io.validIn)
  val regReadyIn = Reg(next = io.readyIn)

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
        when(regEnable) {
          regState := sRun
          regActiveCycles := UInt(0)
          regTotalCycles := UInt(0)
          regNoValidButReady := UInt(0)
          regNoReadyButValid := UInt(0)
        }
      }

      is(sRun) {
        when(!regEnable) {
          regState := sIdle
          printf("Stream " + streamName + ": act %d - tot %d - nvr %d - vnr %d \n",
            regActiveCycles, regTotalCycles, regNoValidButReady, regNoReadyButValid
          )
        }
        .otherwise {
          regTotalCycles := regTotalCycles + UInt(1)
          when (regValidIn & !regReadyIn) {
            regNoReadyButValid := regNoReadyButValid + UInt(1)
          }
          when (!regValidIn & regReadyIn) {
            regNoValidButReady := regNoValidButReady + UInt(1)
          }
          when (regValidIn & regReadyIn) {
            regActiveCycles := regActiveCycles + UInt(1)
            if(dbg) {
              // printf only active in Chisel C++ emulator
              printf(streamName + " txn: %d \n", regActiveCycles)
            }
          }
        }
      }
  }
}

abstract class PrintableBundle extends Bundle {
  def printfStr: String
  def printfElems: () => Seq[Node]
}

object PrintableBundleStreamMonitor {
  def apply[T <: PrintableBundle](stream: DecoupledIO[T], enable: Bool,
    streamName: String = "stream", dbg: Boolean = false): StreamMonitorOutIF = {
    val mon = Module(new PrintableBundleStreamMonitor(stream.bits, streamName, dbg))
    mon.io.enable := enable
    mon.io.validIn := stream.valid
    mon.io.readyIn := stream.ready
    mon.io.bitsIn := stream.bits
    return mon.io.out
  }
}

class PrintableBundleStreamMonitor[T <: PrintableBundle](
  gen: T,
  streamName: String = "stream",
  dbg: Boolean = false
) extends Module {
  val io = new Bundle {
    val enable = Bool(INPUT)
    val validIn = Bool(INPUT)
    val readyIn = Bool(INPUT)
    val bitsIn = gen.cloneType.asInput
    val out = new StreamMonitorOutIF()
  }
  val sIdle :: sRun :: Nil = Enum(UInt(), 2)
  // registered version of the inputs
  val regEnable = Reg(next = io.enable)
  val regValidIn = Reg(next = io.validIn)
  val regReadyIn = Reg(next = io.readyIn)

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
        when(regEnable) {
          regState := sRun
          regActiveCycles := UInt(0)
          regTotalCycles := UInt(0)
          regNoValidButReady := UInt(0)
          regNoReadyButValid := UInt(0)
        }
      }

      is(sRun) {
        when(!regEnable) {
          regState := sIdle
          printf("Stream " + streamName + ": act %d - tot %d - nvr %d - vnr %d \n",
            regActiveCycles, regTotalCycles, regNoValidButReady, regNoReadyButValid
          )
        }
        .otherwise {
          regTotalCycles := regTotalCycles + UInt(1)
          if(dbg) {
            // use nonregistered probes to avoid stale data
            // this is in emulation, so no timing closure problems anyway
            when (io.validIn & !io.readyIn) {
              regNoReadyButValid := regNoReadyButValid + UInt(1)
            }
            when (!io.validIn & io.readyIn) {
              regNoValidButReady := regNoValidButReady + UInt(1)
            }
            when(io.validIn & io.readyIn) {
              regActiveCycles := regActiveCycles + UInt(1)
              // printf only active in Chisel C++ emulator or verilog sim
              printf(streamName + " (%d) ", regActiveCycles)
              printf(io.bitsIn.printfStr, io.bitsIn.printfElems():_*)
            }
          } else {
            // assume StreamMonitor used as part of synthesis - use registered
            // probes
            when (regValidIn & !regReadyIn) {
              regNoReadyButValid := regNoReadyButValid + UInt(1)
            }
            when (!regValidIn & regReadyIn) {
              regNoValidButReady := regNoValidButReady + UInt(1)
            }
            when (regValidIn & regReadyIn) {
              regActiveCycles := regActiveCycles + UInt(1)
            }
          }
        }
      }
  }
}
