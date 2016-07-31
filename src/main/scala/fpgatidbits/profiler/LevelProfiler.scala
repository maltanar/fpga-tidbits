package fpgatidbits.profiler

import Chisel._

class LevelProfilerOutput(ctrW: Int) extends Bundle {
  val sum = UInt(OUTPUT, ctrW)     // accumulated sum
  val cycles = UInt(OUTPUT, ctrW)  // # of cycles monitored

  override def cloneType: this.type = new LevelProfilerOutput(ctrW).asInstanceOf[this.type]
}

class LevelProfiler(inpW: Int, ctrW: Int, name: String = "lvl") extends Module {
  val io = new Bundle {
    val probe = UInt(INPUT, inpW)       // level to measure
    val enable = Bool(INPUT)            // enable/disable monitoring
    val out = new LevelProfilerOutput(ctrW)
  }

  val regActive = Reg(next = io.enable)
  val regSum = Reg(init = UInt(0, ctrW))
  val regCycleCount = Reg(init = UInt(0, ctrW))
  val regProbeValue = Reg(next = io.probe)

  when(!regActive & io.enable) {
    regSum := UInt(0)
    regCycleCount := UInt(0)
  } .elsewhen(regActive) {
    regCycleCount := regCycleCount + UInt(1)
    regSum := regSum + regProbeValue
  }

  when(regActive & !io.enable) {
    //printf(name + " avg level: %d \n", regSum / regCycleCount)
    printf(name + " sum = %d cycles = %d \n", regSum, regCycleCount)
  }

  io.out.sum := regSum
  io.out.cycles := regCycleCount
}

object LevelProfiler {
  def apply(probe: UInt, enable: Bool, name: String): LevelProfilerOutput = {
    val profiler = Module(new LevelProfiler(probe.getWidth(), 32, name)).io
    profiler.probe := probe
    profiler.enable := enable
    profiler.out
  }
}
