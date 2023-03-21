package fpgatidbits.examples

import chisel3._
import fpgatidbits.PlatformWrapper._
import fpgatidbits.dma._
import fpgatidbits.streams._

class ExampleSeqWriteIO(ap: AcceleratorParams, p: PlatformWrapperParams) extends GenericAcceleratorIF(ap,p) {
  val start = Input(Bool())
  val finished = Output(Bool())
  val baseAddr = Input(UInt(64.W))
  val init = Input(UInt(32.W))
  val step = Input(UInt(32.W))
  val count = Input(UInt(32.W))
}

class ExampleSeqWrite(p: PlatformWrapperParams) extends GenericAccelerator(p) {
  val accelParams = AcceleratorParams(
    numMemPorts = 1
  )
  val io = IO(new ExampleSeqWriteIO(accelParams, p))
  plugMemReadPort(0)  // read port not used
  io.signature := makeDefaultSignature()

  val sw = Module(new StreamWriter(new StreamWriterParams(
    streamWidth = p.memDataBits, mem = p.toMemReqParams(), chanID = 0
  ))).io

  sw.start := io.start
  sw.baseAddr := io.baseAddr
  sw.byteCount := io.count * (p.memDataBits/8).U
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
