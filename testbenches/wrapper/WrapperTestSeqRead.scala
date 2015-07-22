package TidbitsTestbenches

import Chisel._
import TidbitsAXI._
import TidbitsDMA._
import TidbitsStreams._
import TidbitsSimUtils._

class WrapperTestSeqRead(p: AXIAccelWrapperParams) extends AXIWrappableAccel(p) {
  // plug unused ports / set defaults
  plugRegOuts()
  plugMemWritePorts()
  // plugMemReadPorts -- bulk interface connection <> won't work otherwise

  val in = new Bundle {
    val start = Bool()
    val baseAddr = UInt(width = 32)
    val byteCount = UInt(width = 32)
  }

  val out = new Bundle {
    val sum = UInt(width = 32)
    val status = UInt(width = 2)
  }
  override lazy val regMap = manageRegIO(in, out)


  val readReqGen = Module(new ReadReqGen(p.toMRP(), 0, 8)).io
  val redFxn = {(a: UInt, b: UInt) => a+b}
  val reducer = Module(new StreamReducer(32, 0, redFxn)).io
  val ds = Module(new AXIStreamDownsizer(p.memDataWidth, 32)).io

  // reg(0) for start control
  readReqGen.reqs <> io.mp(0).memRdReq
  readReqGen.ctrl.start := in.start
  reducer.start := in.start

  readReqGen.ctrl.throttle := Bool(false)
  readReqGen.ctrl.baseAddr := in.baseAddr
  readReqGen.ctrl.byteCount := in.byteCount
  reducer.byteCount := in.byteCount
  reducer.streamIn <> ds.out

  ds.in.valid := io.mp(0).memRdRsp.valid
  ds.in.bits := io.mp(0).memRdRsp.bits.readData
  io.mp(0).memRdRsp.ready := ds.in.ready

  // reg(3) for status
  out.status := Cat(List(reducer.finished, readReqGen.stat.finished))

  // reg(4) for sum
  out.sum := reducer.reduced

  // default test
  override def defaultTest(t: WrappableAccelTester): Boolean = {
    super.defaultTest(t)
    for(i <- 0 until 64) {
      t.writeMem(i*8, i+1)
    }
    for(i <- 0 until 64) {
      t.expectMem(i*8, i+1)
    }
    t.writeReg("in_baseAddr", 0)
    t.writeReg("in_byteCount", 64*8)
    t.writeReg("in_start", 1)

    while(t.readReg("out_status") != 3) { t.step(1) }

    t.expectReg("out_sum", 65*32)

    return true
  }
}
