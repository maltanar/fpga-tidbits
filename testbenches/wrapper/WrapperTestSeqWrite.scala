package TidbitsTestbenches

import Chisel._
import TidbitsAXI._
import TidbitsDMA._
import TidbitsStreams._
import TidbitsSimUtils._

class WrapperTestSeqWrite(p: AXIAccelWrapperParams) extends AXIWrappableAccel(p) {
  // plug unused ports / set defaults
  plugRegOuts()
  //plugMemWritePorts()
  plugMemReadPorts()

  val in = new Bundle {
    val start = Bool()
    val baseAddr = UInt(width = 32)
    val byteCount = UInt(width = 32)
  }

  val out = new Bundle {
    val status = Bool()
  }
  override lazy val regMap = manageRegIO(in, out)

  val wrReqGen = Module(new WriteReqGen(p.toMRP(), 0)).io
  wrReqGen.reqs <> io.mp(0).memWrReq

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

  ds.in.valid := io.mp(0).memWrRsp.valid
  ds.in.bits := io.mp(0).memWrRsp.bits.readData
  io.mp(0).memWrRsp.ready := ds.in.ready

  // write data from sequence
  val wrDataGen = Module(new SequenceGenerator(32)).io
  wrDataGen.init := UInt(1)
  wrDataGen.count := in.byteCount / UInt(4)
  wrDataGen.step := UInt(1)
  wrDataGen.start := in.start

  val us = Module(new AXIStreamUpsizer(32,64)).io
  us.in <> wrDataGen.seq
  us.out <> io.mp(0).memWrDat

  out.status := reducer.finished

  // default test
  override def defaultTest(t: WrappableAccelTester): Boolean = {
    super.defaultTest(t)
    // initialize write buffer to zeroes
    for(i <- 0 until 64) {
      t.writeMem(i*8, 0)
    }
    // set up accelerator registers
    t.writeReg("in_baseAddr", 0)
    t.writeReg("in_byteCount", 64*8)
    t.writeReg("in_start", 1)
    // wait until completion
    while(t.readReg("out_status") != 1) { t.step(1) }
    // verify written data
    for(i <- 0 until 64) {
      // this accelerator generates a 32-bit-wide sequence, but mem read
      // returns 64 bits -- so we verify 2 elements with each read
      val expVal = Cat(UInt(2*i+2, width=32), UInt(2*i+1, width=32))
      t.expectMem(i*8, expVal.litValue())
    }

    return true
  }
}
