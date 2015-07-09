package TidbitsTestbenches

import Chisel._
import TidbitsAXI._
import TidbitsDMA._
import TidbitsStreams._

class WrapperTestSeqRead(p: AXIAccelWrapperParams) extends AXIWrappableAccel(p) {
  // plug unused ports / set defaults
  plugRegOuts()
  plugMemWritePort()
  // plugMemReadPort -- bulk interface connection <> won't work otherwise

  val in = new Bundle {
    val start = Bool()
    val baseAddr = UInt(width = 32)
    val byteCount = UInt(width = 32)
  }

  val out = new Bundle {
    val sum = UInt(width = 32)
    val status = UInt(width = 2)
  }
  manageRegIO(in, out)


  val readReqGen = Module(new ReadReqGen(p.toMRP(), 0)).io
  val redFxn = {(a: UInt, b: UInt) => a+b}
  val reducer = Module(new StreamReducer(32, 0, redFxn)).io
  val ds = Module(new AXIStreamDownsizer(p.memDataWidth, 32)).io

  // reg(0) for start control
  readReqGen.reqs <> io.memRdReq
  readReqGen.ctrl.start := in.start
  reducer.start := in.start

  readReqGen.ctrl.throttle := Bool(false)
  readReqGen.ctrl.baseAddr := in.baseAddr
  readReqGen.ctrl.byteCount := in.byteCount
  reducer.byteCount := in.byteCount
  reducer.streamIn <> ds.out

  ds.in.valid := io.memRdRsp.valid
  ds.in.bits := io.memRdRsp.bits.readData
  io.memRdRsp.ready := ds.in.ready

  // reg(3) for status
  out.status := Cat(List(reducer.finished, readReqGen.stat.finished))

  // reg(4) for sum
  out.sum := reducer.reduced
}
