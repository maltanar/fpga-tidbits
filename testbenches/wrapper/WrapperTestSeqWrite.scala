package TidbitsTestbenches

import Chisel._
import TidbitsAXI._
import TidbitsDMA._
import TidbitsStreams._

class WrapperTestSeqWrite(p: AXIAccelWrapperParams) extends AXIWrappableAccel(p) {
  // plug unused ports / set defaults
  plugRegOuts()
  //plugMemWritePort()
  plugMemReadPort()

  val in = new Bundle {
    val start = Bool()
    val baseAddr = UInt(width = 32)
    val byteCount = UInt(width = 32)
  }

  val out = new Bundle {
    val sum = UInt(width = 32)
    val status = Bool()
  }
  manageRegIO(UInt("hfeadfead"), in, out)

  val wrReqGen = Module(new WriteReqGen(p.toMRP(), 0)).io
  wrReqGen.reqs <> io.memWrReq

  // use a reducer to count the write responses
  val redFxn = {(a: UInt, b: UInt) => a+b}
  val reducer = Module(new StreamReducer(32, 0, redFxn)).io
  // downsizer still needed to count # responses correctly
  val ds = Module(new AXIStreamDownsizer(p.memDataWidth, 32)).io

  // reg(1) for start control
  wrReqGen.ctrl.start := in.start
  reducer.start := in.start

  wrReqGen.ctrl.throttle := Bool(false)
  wrReqGen.ctrl.baseAddr := in.baseAddr
  wrReqGen.ctrl.byteCount := in.byteCount
  reducer.byteCount := in.byteCount
  reducer.streamIn <> ds.out

  ds.in.valid := io.memWrRsp.valid
  ds.in.bits := io.memWrRsp.bits.readData
  io.memWrRsp.ready := ds.in.ready

  // write data from sequence
  val wrDataGen = Module(new SequenceGenerator(32)).io
  wrDataGen.init := UInt(1)
  wrDataGen.count := in.byteCount / UInt(4)
  wrDataGen.step := UInt(1)
  wrDataGen.start := in.start

  val us = Module(new AXIStreamUpsizer(32,64)).io
  us.in <> wrDataGen.seq
  us.out <> io.memWrDat

  out.status := reducer.finished
}
