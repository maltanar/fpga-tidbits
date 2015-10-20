package TidbitsTestbenches
/*
import Chisel._
import TidbitsPlatformWrapper._
import TidbitsDMA._
import TidbitsStreams._

class TestSum(p: PlatformWrapperParams) extends GenericAccelerator(p) {
  override lazy val accelVersion = "1.0.0"
  plugRegOuts()

  val in = new Bundle {
    val baseAddr = UInt(width = p.csrDataBits)
    val byteCount = UInt(width = p.csrDataBits)
  }

  val out = new Bundle {
    val sum = UInt(width = p.csrDataBits)
  }
  override lazy val regMap = manageRegIO(in, out)

  val rg = Module(new ReadReqGen(p.toMemReqParams(), 0, 8)).io
  val red = Module(new StreamReducer(p.memDataBits, 0, {_+_})).io

  val regActive = Reg(init = Bool(false))

  when (!regActive) {regActive := io.start}
  .otherwise {regActive := !red.finished}

  rg.ctrl.start := regActive
  rg.ctrl.throttle := Bool(false)
  rg.ctrl.baseAddr := in.baseAddr
  rg.ctrl.byteCount := in.byteCount

  red.start := regActive
  red.byteCount := in.byteCount

  out.sum := red.reduced

  rg.reqs <> io.memPort(0).memRdReq
  red.streamIn.valid := io.memPort(0).memRdRsp.valid
  red.streamIn.bits := io.memPort(0).memRdRsp.bits.readData
  io.memPort(0).memRdRsp.ready := red.streamIn.ready

  io.idle := !regActive
}

trait TestSumParams extends PlatformWrapperParams {
  val numMemPorts = 1
  val numRegs = 4
  val accelName = "TestSum"
}

object TestSumParamsWolverine extends WX690TParams with TestSumParams

object TestSumMain {
  def apply() = {
    val instFxn = {p: PlatformWrapperParams => new TestSum(p)}
    chiselMain(Array("--v"), () => Module(new WolverinePlatformWrapper(TestSumParamsWolverine, instFxn)))
  }
}
*/
