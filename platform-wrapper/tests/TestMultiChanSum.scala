package TidbitsTestbenches

import Chisel._
import TidbitsPlatformWrapper._
import TidbitsAXI._
import TidbitsDMA._
import TidbitsStreams._

trait TestMultiChanSumParams extends PlatformWrapperParams {
  val numMemPorts = 1
  val accelName = "TestMultiChanSum"
}

class TestMultiChanSum(p: PlatformWrapperParams) extends GenericAccelerator(p) {
  val numChans = 2
  override val io = new GenericAcceleratorIF(p) {
    val start = Bool(INPUT)
    val baseAddr = Vec.fill(numChans) {UInt(INPUT, width=p.csrDataBits)}
    val byteCount = Vec.fill(numChans) {UInt(INPUT, width=p.csrDataBits)}
    val sum = Vec.fill(numChans) {UInt(OUTPUT, width=p.csrDataBits)}
    val status = Bool(OUTPUT)
  }
  plugMemWritePorts() // write ports not used
  io.signature := UInt(20151021)

  val mrp = p.toMemReqParams()
  val reqGens = Vec.tabulate(numChans) {i:Int => Module(new ReadReqGen(mrp, i, 8)).io}
  val redFxn = {(a: UInt, b: UInt) => a+b}
  val reducers = Vec.fill(numChans) {
    Module(new StreamReducer(p.memDataBits, 0, redFxn)).io
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

    reducers(i).streamIn.valid := deintl.rspOut(i).valid
    reducers(i).streamIn.bits := deintl.rspOut(i).bits.readData
    deintl.rspOut(i).ready := reducers(i).streamIn.ready

    reducers(i).start := io.start
    reducers(i).byteCount := io.byteCount(i)
    io.sum(i) := reducers(i).reduced
  }

  intl.reqOut <> io.memPort(0).memRdReq
  deintl.rspIn <> io.memPort(0).memRdRsp

  io.status := reducers.forall(x => x.finished)
}

object TestMultiChanSumParamsWolverine extends WX690TParams with TestMultiChanSumParams

object TestMultiChanSumMain {
  def apply() = {
    val instFxnAccel = {p: PlatformWrapperParams => new TestMultiChanSum(p)}
    def instFxnWrapper() = {new WolverinePlatformWrapper(TestMultiChanSumParamsWolverine, instFxnAccel)}
    val instFxnTop = {() => Module(instFxnWrapper())}
    chiselMain(Array("--v"), instFxnTop)
    instFxnWrapper().generateRegDriver(".")
  }
}
