package fpgatidbits.Testbenches

import Chisel._
import fpgatidbits.PlatformWrapper._
import fpgatidbits.dma._
import fpgatidbits.streams._

// TODO support non-word-aligned sizes in byteCount

class TestCopy(p: PlatformWrapperParams) extends GenericAccelerator(p) {
  val numMemPorts = 2
  val io = new GenericAcceleratorIF(numMemPorts, p) {
    val start = Bool(INPUT)
    val finished = Bool(OUTPUT)
    val srcAddr = UInt(INPUT, width = 64)
    val dstAddr = UInt(INPUT, width = 64)
    val byteCount = UInt(INPUT, width = 32)
    val finBytes = UInt(OUTPUT, width = 32)
  }
  io.signature := makeDefaultSignature()

  val rrg = Module(new ReadReqGen(p.toMemReqParams(), 0, 1)).io
  val wrg = Module(new WriteReqGen(p.toMemReqParams(), 0, 8)).io

  val readPort = io.memPort(0)
  val writePort = io.memPort(1)

  // plug unused valid signals
  readPort.memWrReq.valid := Bool(false)
  readPort.memWrDat.valid := Bool(false)
  writePort.memRdReq.valid := Bool(false)

  rrg.ctrl.start := io.start
  rrg.ctrl.throttle := Bool(false)
  rrg.ctrl.baseAddr := io.srcAddr
  rrg.ctrl.byteCount := io.byteCount
  rrg.reqs <> readPort.memRdReq

  wrg.ctrl.start := io.start
  wrg.ctrl.throttle := Bool(false)
  wrg.ctrl.baseAddr := io.dstAddr
  wrg.ctrl.byteCount := io.byteCount
  wrg.reqs <> writePort.memWrReq

  // pull out read response as write data
  ReadRespFilter(readPort.memRdRsp) <> writePort.memWrDat

  // count write responses to determine finished
  val regNumPendingReqs = Reg(init = UInt(0, 32))
  val regRequestedBytes = Reg(init = UInt(0, 32))

  writePort.memWrRsp.ready := Bool(true)

  when(!io.start) {
    regNumPendingReqs := UInt(0)
    regRequestedBytes := UInt(0)
  } .otherwise {
    val reqFired = writePort.memWrReq.valid & writePort.memWrReq.ready
    val rspFired = writePort.memWrRsp.valid & writePort.memWrRsp.ready

    regRequestedBytes := regRequestedBytes + Mux(reqFired, writePort.memWrReq.bits.numBytes, UInt(0))

    when(reqFired && !rspFired) { regNumPendingReqs := regNumPendingReqs + UInt(1)}
    .elsewhen(!reqFired && rspFired) { regNumPendingReqs := regNumPendingReqs - UInt(1) }
  }

  io.finished := io.start & (regRequestedBytes === io.byteCount) & (regNumPendingReqs === UInt(0))
  io.finBytes := regRequestedBytes
}
