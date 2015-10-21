package TidbitsTestbenches

import Chisel._
import TidbitsPlatformWrapper._
import TidbitsDMA._
import TidbitsStreams._

trait TestCopyParams extends PlatformWrapperParams {
  val numMemPorts = 1
  val accelName = "TestCopy"
}

class TestCopy(p: PlatformWrapperParams) extends GenericAccelerator(p) {
  override val io = new GenericAcceleratorIF(p) {
    val start = Bool(INPUT)
    val finished = Bool(OUTPUT)
    val srcAddr = UInt(INPUT, width = p.csrDataBits)
    val dstAddr = UInt(INPUT, width = p.csrDataBits)
    val byteCount = UInt(INPUT, width = p.csrDataBits)
    val finBytes = UInt(OUTPUT, width = p.csrDataBits)
  }
  // TODO generate signature with digest function
  io.signature := UInt(20151021)

  val rrg = Module(new ReadReqGen(p.toMemReqParams(), 0, 8)).io
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
  io.memPort(0).memWrDat.valid := io.memPort(0).memRdRsp.valid
  io.memPort(0).memWrDat.bits := io.memPort(0).memRdRsp.bits.readData
  io.memPort(0).memRdRsp.ready := io.memPort(0).memWrDat.ready

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

object TestCopyParamsWolverine extends WX690TParams with TestCopyParams

object TestCopyMain {
  def apply() = {
    val instFxnAccel = {p: PlatformWrapperParams => new TestCopy(p)}
    def instFxnWrapper() = {new WolverinePlatformWrapper(TestCopyParamsWolverine, instFxnAccel)}
    val instFxnTop = {() => Module(instFxnWrapper())}
    chiselMain(Array("--v"), instFxnTop)
    instFxnWrapper().generateRegDriver(".")
  }
}
