package fpgatidbits.profiler

import chisel3._
import chisel3.util._

class LevelProfilerOutput(ctrW: Int) extends Bundle {
  val sum = Output(UInt(ctrW.W))     // accumulated sum
  val cycles = Output(UInt(ctrW.W))  // # of cycles monitored
}

class LevelProfiler(inpW: Int, ctrW: Int, name: String = "lvl") extends Module {
  val io = new Bundle {
    val probe = Input(UInt(inpW.W))       // level to measure
    val enable = Input(Bool())            // enable/disable monitoring
    val out = new LevelProfilerOutput(ctrW)
  }

  val regActive = RegNext(io.enable)
  val regSum = RegInit(0.U(ctrW.W))
  val regCycleCount = RegInit(0.U(ctrW.W))
  val regProbeValue = RegNext(io.probe)

  when(!regActive & io.enable) {
    regSum := 0.U
    regCycleCount := 0.U
  } .elsewhen(regActive) {
    regCycleCount := regCycleCount + 1.U
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
    val profiler = Module(new LevelProfiler(probe.getWidth, 32, name)).io
    profiler.probe := probe
    profiler.enable := enable
    profiler.out
  }
}
