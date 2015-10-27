package TidbitsTestbenches

import Chisel._
import TidbitsPlatformWrapper._
import TidbitsAXI._
import TidbitsDMA._
import TidbitsStreams._

class TestMultiChanSum(p: PlatformWrapperParams) extends GenericAccelerator(p) {
  val numMemPorts = 1
  val numChans = 2
  val io = new GenericAcceleratorIF(numMemPorts, p) {
    val start = Bool(INPUT)
    val baseAddr = Vec.fill(numChans) {UInt(INPUT, width=32)}
    val byteCount = Vec.fill(numChans) {UInt(INPUT, width=32)}
    val sum = Vec.fill(numChans) {UInt(OUTPUT, width=32)}
    val status = Bool(OUTPUT)
  }
  plugMemWritePort(0) // write ports not used
  io.signature := makeDefaultSignature()

  val mrp = p.toMemReqParams()
  val reqGens = Vec.tabulate(numChans) {i:Int => Module(new ReadReqGen(mrp, i, 1)).io}
  val redFxn = {(a: UInt, b: UInt) => a+b}
  val reducers = Vec.fill(numChans) {
    Module(new StreamReducer(32, 0, redFxn)).io
  }

  val intl = Module(new ReqInterleaver(numChans, mrp)).io
  val deintl = Module(new QueuedDeinterleaver(numChans, mrp, 4)).io

  // regGen -> intl -> (memRdReq) -> (memRdRsp) -> deintl -> reducer

  for(i <- 0 until numChans) {
    reqGens(i).reqs <> intl.reqIn(i)
    reqGens(i).ctrl.start := io.start
    reqGens(i).ctrl.throttle := Bool(false)
    reqGens(i).ctrl.baseAddr := io.baseAddr(i)
    reqGens(i).ctrl.byteCount := io.byteCount(i)

    val respStream = ReadRespFilter(deintl.rspOut(i))

    if (p.memDataBits > 32) {
      reducers(i).streamIn <> StreamDownsizer(respStream, 32)
    } else if (p.memDataBits == 32) {
      reducers(i).streamIn <> respStream
    } else throw new Exception("Sub-32 bit data buses not supported")

    reducers(i).start := io.start
    reducers(i).byteCount := io.byteCount(i)
    io.sum(i) := reducers(i).reduced
  }

  intl.reqOut <> io.memPort(0).memRdReq
  deintl.rspIn <> io.memPort(0).memRdRsp

  io.status := reducers.forall(x => x.finished)
}
