package fpgatidbits.Testbenches

import Chisel._
import fpgatidbits.PlatformWrapper._
import fpgatidbits.dma._
import fpgatidbits.streams._

class TestSeqWrite(p: PlatformWrapperParams) extends GenericAccelerator(p) {
  val numMemPorts = 1
  val io = new GenericAcceleratorIF(numMemPorts, p) {
    val start = Bool(INPUT)
    val finished = Bool(OUTPUT)
    val baseAddr = UInt(INPUT, width = 64)
    val init = UInt(INPUT, width = 32)
    val step = UInt(INPUT, width = 32)
    val count = UInt(INPUT, width = 32)
  }
  plugMemReadPort(0)  // read port not used
  io.signature := makeDefaultSignature()

  val sw = Module(new StreamWriter(new StreamWriterParams(
    streamWidth = p.memDataBits, mem = p.toMemReqParams(), chanID = 0
  ))).io

  sw.start := io.start
  sw.baseAddr := io.baseAddr
  sw.byteCount := io.count * UInt(p.memDataBits/8)
  io.finished := sw.finished

  val sg = Module(new SequenceGenerator(p.memDataBits)).io
  sg.start := io.start
  sg.init := io.init
  sg.step := io.step
  sg.count := io.count

  sg.seq <> sw.in
  sw.req <> io.memPort(0).memWrReq
  sw.wdat <> io.memPort(0).memWrDat
  io.memPort(0).memWrRsp <> sw.rsp
}
