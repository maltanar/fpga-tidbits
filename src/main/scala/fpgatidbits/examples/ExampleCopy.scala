package fpgatidbits.examples

import chisel3._
import fpgatidbits.PlatformWrapper._
import fpgatidbits.dma._
import fpgatidbits.ocm.OCMSlaveIF
import fpgatidbits.streams._

class ExampleCopyIO(n: Int, p: PlatformWrapperParams) extends GenericAcceleratorIF(n,p) {
  val start = Input(Bool())
  val finished = Output(Bool())
  val srcAddr = Input(UInt(64.W))
  val dstAddr = Input(UInt(64.W))
  val byteCount = Input(UInt(32.W))
  val finBytes = Output(UInt(32.W))
}
class ExampleCopy(p: PlatformWrapperParams) extends GenericAccelerator(p) {
  val numMemPorts = 2
  val io = IO(new ExampleCopyIO(numMemPorts,p))
  io.signature := makeDefaultSignature()

  val rrg = Module(new ReadReqGen(p.toMemReqParams(), 0, 1)).io
  val wrg = Module(new WriteReqGen(p.toMemReqParams(), 0, 8)).io

  val readPort = io.memPort(0)
  val writePort = io.memPort(1)

  // plug unused valid signals
  readPort.memWrReq.valid := false.B
  readPort.memWrDat.valid := false.B
  writePort.memRdReq.valid := false.B

  rrg.ctrl.start := io.start
  rrg.ctrl.throttle := false.B
  rrg.ctrl.baseAddr := io.srcAddr
  rrg.ctrl.byteCount := io.byteCount
  rrg.reqs <> readPort.memRdReq

  wrg.ctrl.start := io.start
  wrg.ctrl.throttle := false.B
  wrg.ctrl.baseAddr := io.dstAddr
  wrg.ctrl.byteCount := io.byteCount
  wrg.reqs <> writePort.memWrReq

  // pull out read response as write data
  ReadRespFilter(readPort.memRdRsp) <> writePort.memWrDat

  // count write responses to determine finished
  val regNumPendingReqs = RegInit(0.U(32.W))
  val regRequestedBytes = RegInit(0.U(32.W))

  writePort.memWrRsp.ready := true.B

  when(!io.start) {
    regNumPendingReqs := 0.U
    regRequestedBytes := 0.U
  } .otherwise {
    val reqFired = writePort.memWrReq.valid & writePort.memWrReq.ready
    val rspFired = writePort.memWrRsp.valid & writePort.memWrRsp.ready

    regRequestedBytes := regRequestedBytes + Mux(reqFired, writePort.memWrReq.bits.numBytes, 0.U)

    when(reqFired && !rspFired) { regNumPendingReqs := regNumPendingReqs + 1.U}
    .elsewhen(!reqFired && rspFired) { regNumPendingReqs := regNumPendingReqs - 1.U }
  }

  io.finished := io.start & (regRequestedBytes === io.byteCount) & (regNumPendingReqs === 0.U)
  io.finBytes := regRequestedBytes
}
