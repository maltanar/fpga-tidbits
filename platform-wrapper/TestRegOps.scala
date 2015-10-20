package TidbitsTestbenches

import Chisel._
import TidbitsPlatformWrapper._

class TestRegOps(p: PlatformWrapperParams) extends GenericAccelerator(p) {
  override val io = new GenericAcceleratorIF(p) {
    val op = Vec.fill(2) {UInt(INPUT, width = 64)}
    val sum = UInt(OUTPUT, width = 64)
  }

  io.signature := UInt(20151020)
  io.sum := io.op(0) + io.op(1)
}

trait TestRegOpsParams extends PlatformWrapperParams {
  val numMemPorts = 0
  val accelName = "TestRegOps"
}

object TestRegOpsWolverine extends WX690TParams with TestRegOpsParams

object TestRegOpsMain {
  def apply() = {
    val instFxn = {p: PlatformWrapperParams => new TestRegOps(p)}
    chiselMain(Array("--v"), () => Module(new WolverinePlatformWrapper(TestRegOpsWolverine, instFxn)))
    new WolverinePlatformWrapper(TestRegOpsWolverine, instFxn).generateRegDriver(".")
  }
}
