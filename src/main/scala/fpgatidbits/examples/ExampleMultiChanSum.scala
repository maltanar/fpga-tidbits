package fpgatidbits.examples

import chisel3._
import fpgatidbits.PlatformWrapper._
import fpgatidbits.dma._
import fpgatidbits.streams._


class ExampleMultiChanSumIO(ap:AcceleratorParams, p: PlatformWrapperParams, numChans: Int) extends GenericAcceleratorIF(ap,p) {
  val start = Input(Bool())
  val baseAddr = Vec(numChans, Input(UInt(64.W)))
  val byteCount = Vec(numChans, Input(UInt(32.W)))
  val sum = Vec(numChans, Output(UInt(32.W)))
  val status = Output(Bool())
}
class ExampleMultiChanSum(p: PlatformWrapperParams) extends GenericAccelerator(p) {
  val accelParams = AcceleratorParams(
    numMemPorts = 1
  )
  val numChans = 2
  val io = IO(new ExampleMultiChanSumIO(accelParams, p, numChans))
  plugMemWritePort(0) // write ports not used
  io.signature := makeDefaultSignature()
  val mrp = p.toMemReqParams()

  def makeReader(id: Int) = {
    Module(new StreamReader(new StreamReaderParams(
      streamWidth = 32, fifoElems = 8, mem = mrp,
      maxBeats = 1, chanID = id, disableThrottle = true
    ))).io
  }

  val readers = VecInit(Seq.tabulate(numChans) {i:Int => makeReader(i)})
  val reducers = VecInit(Seq.fill(numChans) {
    Module(new StreamReducer(32, 0, {_+_})).io
  })

  val intl = Module(new ReqInterleaver(numChans, mrp)).io
  val deintl = Module(new QueuedDeinterleaver(numChans, mrp, 4)).io

  // regGen -> intl -> (memRdReq) -> (memRdRsp) -> deintl -> reducer

  for(i <- 0 until numChans) {
    readers(i).start := io.start
    readers(i).baseAddr := io.baseAddr(i)
    readers(i).byteCount := io.byteCount(i)

    readers(i).doInit := false.B
    readers(i).initCount := 0.U

    readers(i).req <> intl.reqIn(i)
    deintl.rspOut(i) <> readers(i).rsp
    readers(i).out.ready :=  reducers(i).streamIn.ready
    reducers(i).streamIn.valid := readers(i).out.valid
    reducers(i).streamIn.bits := readers(i).out.bits

    reducers(i).start := io.start
    reducers(i).byteCount := io.byteCount(i)
    io.sum(i) := reducers(i).reduced
  }

  intl.reqOut <> io.memPort(0).memRdReq
  deintl.rspIn <> io.memPort(0).memRdRsp

  io.status := reducers.forall(x => x.finished)
}
