package fpgatidbits.profiler

import Chisel._

class OutstandingTxnProfilerOutput(w: Int) extends Bundle {
  val sum = UInt(OUTPUT, w)
  val cycles = UInt(OUTPUT, w)
}

class OutstandingTxnProfiler(w: Int) extends Module {
  val io = new Bundle {
    val enable = Bool(INPUT)
    val probeReqValid = Bool(INPUT)
    val probeReqReady = Bool(INPUT)
    val probeRspValid = Bool(INPUT)
    val probeRspReady = Bool(INPUT)

    val out = new OutstandingTxnProfilerOutput(w)
  }

  val regCycles = Reg(init = UInt(0, w))
  val regTotalReq = Reg(init = UInt(0, w))
  val regTotalRsp = Reg(init = UInt(0, w))
  val regActiveTxns = Reg(init = UInt(0, w))

  val regActive = Reg(next = io.enable)

  val reqTxn = io.probeReqReady & io.probeReqValid
  val rspTxn = io.probeRspValid & io.probeRspReady

  when(!regActive & io.enable) {
    // reset all counters when first enabled
    regCycles := UInt(0)
    regTotalReq := UInt(0)
    regTotalRsp := UInt(0)
    regActiveTxns := UInt(0)
  } .elsewhen(regActive & io.enable) {
    regCycles := regCycles + UInt(1)
    when(reqTxn) { regTotalReq := regTotalReq + UInt(1) }
    when(rspTxn) { regTotalRsp := regTotalRsp + UInt(1) }
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
