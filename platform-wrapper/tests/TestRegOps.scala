package TidbitsTestbenches

import Chisel._
import TidbitsPlatformWrapper._

class TestRegOps(p: PlatformWrapperParams) extends GenericAccelerator(p) {
  val numMemPorts = 0
  val io = new GenericAcceleratorIF(numMemPorts, p) {
    val op = Vec.fill(2) {UInt(INPUT, width = 64)}
    val sum = UInt(OUTPUT, width = 64)
  }


  // TODO generate signature with digest function
  io.signature := UInt(20151020)
  io.sum := io.op(0) + io.op(1)
}

object TestRegOpsMain {
  def apply() = {
    val instAccel = {p: PlatformWrapperParams => new TestRegOps(p)}
    val instTop = {() => Module(new ZedBoardWrapper(instAccel))}
    
    chiselMain(Array("--v"), instTop)
    //new WolverinePlatformWrapper(TestRegOpsWolverine, instFxn).generateRegDriver(".")
  }
}
