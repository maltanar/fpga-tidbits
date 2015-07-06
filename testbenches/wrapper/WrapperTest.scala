package TidbitsTestbenches

import Chisel._
import TidbitsAXI._
import TidbitsDMA._
import TidbitsStreams._

class WrapperTest(p: AXIAccelWrapperParams) extends AXIWrappableAccel(p) {
  val readReqGen = Module(new ReadReqGen(p.toMRP(), 0)).io
  val redFxn = {(a: UInt, b: UInt) => a+b}
  val reducer = Module(new StreamReducer(32, 0, redFxn)).io
  val ds = Module(new AXIStreamDownsizer(p.memDataWidth, 32)).io

  // reg(0) for start control
  readReqGen.reqs <> io.memRdReq
  readReqGen.ctrl.start := io.regIn(0)(0)
  reducer.start := io.regIn(0)(0)

  readReqGen.ctrl.throttle := Bool(false)
  readReqGen.ctrl.baseAddr := io.regIn(1) // reg(1) for mem read base
  readReqGen.ctrl.byteCount := io.regIn(2) // reg(2) for read byte count
  reducer.byteCount := io.regIn(2)
  reducer.streamIn <> ds.out

  ds.in.valid := io.memRdRsp.valid
  ds.in.bits := io.memRdRsp.bits.readData
  io.memRdRsp.ready := ds.in.ready

  // reg(3) for status
  io.regOut(3).valid := Bool(true)
  io.regOut(3).bits := Cat(List(reducer.finished, readReqGen.stat.finished))

  // reg(4) for sum
  io.regOut(4).valid := reducer.finished
  io.regOut(4).bits := reducer.reduced

  // use reg(5) as fixed identifier
  io.regOut(5).valid := Bool(true)
  io.regOut(5).bits := UInt("hdeadbeef")
}
