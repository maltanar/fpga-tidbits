package TidbitsTestbenches

import Chisel._
import TidbitsAXI._
import TidbitsDMA._
import TidbitsStreams._

class WrapperTestMultiChanSum(numChans: Int, p: AXIAccelWrapperParams) extends AXIWrappableAccel(p) {
  // plug unused ports / set defaults
  plugRegOuts()
  plugMemWritePort()
  // no plugMemReadPort -- bulk interface connection <> won't work otherwise

  val in = new Bundle {
    val start = Bool()
    val baseAddr = Vec.fill(numChans) {UInt(width=32)}
    val byteCount = Vec.fill(numChans) {UInt(width=32)}
  }

  val out = new Bundle {
    val sum = Vec.fill(numChans) {UInt(width=32)}
    val status = Bool()
  }

  manageRegIO(in, out)

  val mrp = p.toMRP()
  val reqGens = Vec.tabulate(numChans) {i:Int => Module(new ReadReqGen(mrp, i, 8)).io}
  val redFxn = {(a: UInt, b: UInt) => a+b}
  val reducers = Vec.fill(numChans) {Module(new StreamReducer(32, 0, redFxn)).io}
  val dss = Vec.fill(numChans) {Module(new AXIStreamDownsizer(p.memDataWidth, 32)).io}
  val intl = Module(new ReqInterleaver(numChans, mrp)).io
  val deintl = Module(new QueuedDeinterleaver(numChans, mrp, 4)).io

  // regGen -> intl -> (memRdReq) -> (memRdRsp) -> deintl -> dss -> reducer

  for(i <- 0 until numChans) {
    reqGens(i).reqs <> intl.reqIn(i)
    reqGens(i).ctrl.start := in.start
    reqGens(i).ctrl.throttle := Bool(false)
    reqGens(i).ctrl.baseAddr := in.baseAddr(i)
    reqGens(i).ctrl.byteCount := in.byteCount(i)
    dss(i).in.valid := deintl.rspOut(i).valid
    dss(i).in.bits := deintl.rspOut(i).bits.readData
    deintl.rspOut(i).ready := dss(i).in.ready
    dss(i).out <> reducers(i).streamIn
    reducers(i).start := in.start
    reducers(i).byteCount := in.byteCount(i)
    out.sum(i) := reducers(i).reduced
  }

  intl.reqOut <> io.memRdReq
  deintl.rspIn <> io.memRdRsp

  out.status := reducers.forall(x => x.finished)
}
