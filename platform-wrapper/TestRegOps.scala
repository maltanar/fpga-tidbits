package TidbitsTestbenches

import Chisel._
import TidbitsPlatformWrapper._

class TestRegOps(p: PlatformWrapperParams) extends GenericAccelerator(p) {
  override lazy val accelVersion = "1.0.0"
  plugRegOuts()

  val in = new Bundle {
    val op = Vec.fill(2) {UInt(width = 64)}
  }

  val out = new Bundle {
    val sum = UInt(width = 64)
  }
  override lazy val regMap = manageRegIO(in, out)

  io.idle := Bool(true)
  out.sum := in.op(0) + in.op(1)
}

trait TestRegOpsParams extends PlatformWrapperParams {
  val numMemPorts = 0
  val numRegs = 4
}

object TestRegOpsWolverine extends PlatformWrapperParams with TestRegOpsParams with WX690TParams {

}

object TestRegOpsMain {
  def apply() = {
    val instFxn = {p: PlatformWrapperParams => new TestRegOps(p)}
    chiselMain(Array("--v"), () => Module(new WolverinePlatformWrapper(TestRegOpsWolverine, instFxn)))
  }
}
