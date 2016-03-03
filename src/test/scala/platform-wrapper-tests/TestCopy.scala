package TidbitsTestbenches

import Chisel._
import fpgatidbits.PlatformWrapper._
import fpgatidbits.dma._
import fpgatidbits.streams._

// TODO support non-word-aligned sizes in byteCount

class TestCopy(p: PlatformWrapperParams) extends GenericAccelerator(p) {
  val numMemPorts = 1
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
  val wrg = Module(new WriteReqGen(p.toMemReqParams(), 0)).io

  rrg.ctrl.start := io.start
  rrg.ctrl.throttle := Bool(false)
  rrg.ctrl.baseAddr := io.srcAddr
  rrg.ctrl.byteCount := io.byteCount
  rrg.reqs <> io.memPort(0).memRdReq

  wrg.ctrl.start := io.start
  wrg.ctrl.throttle := Bool(false)
  wrg.ctrl.baseAddr := io.dstAddr
  wrg.ctrl.byteCount := io.byteCount
  wrg.reqs <> io.memPort(0).memWrReq

  // pull out read response as write data
  ReadRespFilter(io.memPort(0).memRdRsp) <> io.memPort(0).memWrDat

  // count write responses to determine finished
  val regCompletes = Reg(init = UInt(0, 32))

  io.memPort(0).memWrRsp.ready := Bool(true)

  when (!io.start) { regCompletes := UInt(0)}
  .elsewhen (io.memPort(0).memWrRsp.valid) {
    regCompletes := regCompletes + UInt(p.memDataBits/8)
  }

  io.finished := io.start & (regCompletes === io.byteCount)
  io.finBytes := regCompletes
}
