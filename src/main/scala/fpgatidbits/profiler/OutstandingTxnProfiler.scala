package fpgatidbits.profiler

import chisel3._
import chisel3.util._

class OutstandingTxnProfilerOutput(w: Int) extends Bundle {
  val sum = Output(UInt(w.W))
  val cycles = Output(UInt(w.W))
}

class OutstandingTxnProfiler(w: Int) extends Module {
  val io = new Bundle {
    val enable = Input(Bool())
    val probeReqValid = Input(Bool())
    val probeReqReady = Input(Bool())
    val probeRspValid = Input(Bool())
    val probeRspReady = Input(Bool())

    val out = new OutstandingTxnProfilerOutput(w)
  }

  val regCycles = RegInit(0.U(32.W))
  val regTotalReq = RegInit(0.U(32.W))
  val regTotalRsp = RegInit(0.U(32.W))
  val regActiveTxns = RegInit(0.U(32.W))

  val regActive = RegInit(false.B)
  regActive := io.enable

  val reqTxn = io.probeReqReady & io.probeReqValid
  val rspTxn = io.probeRspValid & io.probeRspReady

  when(!regActive & io.enable) {
    // reset all counters when first enabled
    regCycles := 0.U
    regTotalReq := 0.U
    regTotalRsp := 0.U
    regActiveTxns := 0.U
  } .elsewhen(regActive & io.enable) {
    regCycles := regCycles + 1.U
    when(reqTxn) { regTotalReq := regTotalReq + 1.U }
    when(rspTxn) { regTotalRsp := regTotalRsp + 1.U }
    regActiveTxns := regActiveTxns + (regTotalReq - regTotalRsp)
  }

  io.out.cycles := regCycles
  io.out.sum := regActiveTxns
}


object OutstandingTxnProfiler {
  def apply[T <: Data](
    req: DecoupledIO[T],
    rsp: DecoupledIO[T],
    enable: Bool): OutstandingTxnProfilerOutput = {
    val mon = Module(new OutstandingTxnProfiler(32))
    mon.io.enable := enable
    mon.io.probeReqValid := req.valid
    mon.io.probeReqReady := req.ready
    mon.io.probeRspValid := rsp.valid
    mon.io.probeRspReady := rsp.ready

    return mon.io.out
  }
}
