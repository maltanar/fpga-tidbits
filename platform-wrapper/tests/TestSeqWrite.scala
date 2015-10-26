package TidbitsTestbenches

import Chisel._
import TidbitsPlatformWrapper._
import TidbitsDMA._
import TidbitsStreams._

class TestSeqWrite(p: PlatformWrapperParams) extends GenericAccelerator(p) {
  val numMemPorts = 1
  val io = new GenericAcceleratorIF(numMemPorts, p) {
    val start = Bool(INPUT)
    val status = UInt(OUTPUT, 3)
    val baseAddr = UInt(INPUT, width = p.csrDataBits)
    val count = UInt(INPUT, width = p.csrDataBits)
  }
  plugMemReadPort(0)  // read port not used

  io.signature := makeDefaultSignature()

  val sg = Module(new SequenceGenerator(p.memDataBits)).io
  val wg = Module(new WriteReqGen(p.toMemReqParams(), 0)).io

  wg.ctrl.start := io.start
  wg.ctrl.throttle := Bool(false)
  wg.ctrl.baseAddr := io.baseAddr
  wg.ctrl.byteCount := io.count * UInt(p.memDataBits/8)
  wg.reqs <> io.memPort(0).memWrReq

  sg.start := io.start
  sg.init := UInt(0)
  sg.step := UInt(1)
  sg.count := io.count
  sg.seq <> io.memPort(0).memWrDat

  io.memPort(0).memWrRsp.ready := Bool(true)

  val regRspCount = Reg(init = UInt(0, 32))

  when (!io.start) { regRspCount := UInt(0) }
  .elsewhen (io.memPort(0).memWrRsp.valid) {
    regRspCount := regRspCount + UInt(1)
  }

  io.status := UInt(0)
  io.status(0) := wg.stat.finished
  io.status(1) := sg.finished
  io.status(2) := (regRspCount === io.count)
}
