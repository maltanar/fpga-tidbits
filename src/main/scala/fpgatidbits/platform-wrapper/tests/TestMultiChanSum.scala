package fpgatidbits.Testbenches

import Chisel._
import fpgatidbits.PlatformWrapper._
import fpgatidbits.axi._
import fpgatidbits.dma._
import fpgatidbits.streams._

class TestMultiChanSum(p: PlatformWrapperParams) extends GenericAccelerator(p) {
  val numMemPorts = 1
  val numChans = 2
  val io = new GenericAcceleratorIF(numMemPorts, p) {
    val start = Bool(INPUT)
    val baseAddr = Vec.fill(numChans) {UInt(INPUT, width=64)}
    val byteCount = Vec.fill(numChans) {UInt(INPUT, width=32)}
    val sum = Vec.fill(numChans) {UInt(OUTPUT, width=32)}
    val status = Bool(OUTPUT)
  }
  plugMemWritePort(0) // write ports not used
  io.signature := makeDefaultSignature()
  val mrp = p.toMemReqParams()

  def makeReader(id: Int) = {
    Module(new StreamReader(new StreamReaderParams(
      streamWidth = 32, fifoElems = 8, mem = mrp,
      maxBeats = 1, chanID = id, disableThrottle = true
    ))).io
  }

  val readers = Vec.tabulate(numChans) {i:Int => makeReader(i)}
  val reducers = Vec.fill(numChans) {
    Module(new StreamReducer(32, 0, {_+_})).io
  }

  val intl = Module(new ReqInterleaver(numChans, mrp)).io
  val deintl = Module(new QueuedDeinterleaver(numChans, mrp, 4)).io

  // regGen -> intl -> (memRdReq) -> (memRdRsp) -> deintl -> reducer

  for(i <- 0 until numChans) {
    readers(i).start := io.start
    readers(i).baseAddr := io.baseAddr(i)
    readers(i).byteCount := io.byteCount(i)

    readers(i).req <> intl.reqIn(i)
    deintl.rspOut(i) <> readers(i).rsp
    readers(i).out <> reducers(i).streamIn

    reducers(i).start := io.start
    reducers(i).byteCount := io.byteCount(i)
    io.sum(i) := reducers(i).reduced
  }

  intl.reqOut <> io.memPort(0).memRdReq
  deintl.rspIn <> io.memPort(0).memRdRsp

  io.status := reducers.forall(x => x.finished)
}
