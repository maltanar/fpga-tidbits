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

  val mrp = p.toMRP()
  val reqGens = Vec.tabulate(numChans) {i:Int => Module(new ReadReqGen(mrp, i)).io}
  val redFxn = {(a: UInt, b: UInt) => a+b}
  val reducers = Vec.fill(numChans) {Module(new StreamReducer(32, 0, redFxn)).io}
  val dss = Vec.fill(numChans) {Module(new AXIStreamDownsizer(p.memDataWidth, 32)).io}
  val intl = Module(new ReqInterleaver(numChans, mrp)).io
  val deintl = Module(new QueuedDeinterleaver(numChans, mrp, 4)).io

  // regGen -> intl -> (memRdReq) -> (memRdRsp) -> deintl -> dss -> reducer

  for(i <- 0 until numChans) {
    reqGens(i).reqs <> intl.reqIn(i)
    reqGens(i).ctrl.start := io.regIn(0)(0)
    reqGens(i).ctrl.throttle := Bool(false)
    reqGens(i).ctrl.baseAddr := io.regIn(2+3*i)
    reqGens(i).ctrl.byteCount := io.regIn(2+3*i+1)
    dss(i).in.valid := deintl.rspOut(i).valid
    dss(i).in.bits := deintl.rspOut(i).bits.readData
    deintl.rspOut(i).ready := dss(i).in.ready
    dss(i).out <> reducers(i).streamIn
    reducers(i).start := io.regIn(0)(0)
    reducers(i).byteCount := io.regIn(2+3*i+1)
    io.regOut(2+3*i+2).bits := reducers(i).reduced
    io.regOut(2+3*i+2).valid := reducers(i).finished
  }

  intl.reqOut <> io.memRdReq
  deintl.rspIn <> io.memRdRsp


  io.regOut(1).valid := Bool(true)
  io.regOut(1).bits := reducers.forall(x => x.finished)
}
