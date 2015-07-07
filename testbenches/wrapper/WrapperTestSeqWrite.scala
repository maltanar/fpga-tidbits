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

  val wrReqGen = Module(new WriteReqGen(p.toMRP(), 0)).io
  wrReqGen.reqs <> io.memWrReq

  // use a reducer to count the write responses
  val redFxn = {(a: UInt, b: UInt) => a+b}
  val reducer = Module(new StreamReducer(32, 0, redFxn)).io
  // downsizer still needed to count # responses correctly
  val ds = Module(new AXIStreamDownsizer(p.memDataWidth, 32)).io

  // reg(0) for identification
  io.regOut(0).bits := UInt("hfeedbead")
  io.regOut(0).valid := Bool(true)

  // reg(1) for start control
  wrReqGen.ctrl.start := io.regIn(1)(0)
  reducer.start := io.regIn(1)(0)

  wrReqGen.ctrl.throttle := Bool(false)
  wrReqGen.ctrl.baseAddr := io.regIn(2) // reg(2) for mem write base
  wrReqGen.ctrl.byteCount := io.regIn(3) // reg(3) for write byte count
  reducer.byteCount := io.regIn(3)
  reducer.streamIn <> ds.out

  ds.in.valid := io.memWrRsp.valid
  ds.in.bits := io.memWrRsp.bits.readData
  io.memWrRsp.ready := ds.in.ready

  // write data from sequence
  val wrDataGen = Module(new SequenceGenerator(32)).io
  wrDataGen.init := UInt(1)
  wrDataGen.count := io.regIn(3) / UInt(4)
  wrDataGen.step := UInt(1)
  wrDataGen.start := io.regIn(1)(0)

  val us = Module(new AXIStreamUpsizer(32,64)).io
  us.in <> wrDataGen.seq
  us.out <> io.memWrDat

  // reg(4) for status
  io.regOut(4).valid := Bool(true)
  io.regOut(4).bits := reducer.finished
}
