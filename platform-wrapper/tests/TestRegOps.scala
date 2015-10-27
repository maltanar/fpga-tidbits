package TidbitsTestbenches

import Chisel._
import TidbitsPlatformWrapper._

class TestRegOps(p: PlatformWrapperParams) extends GenericAccelerator(p) {
  val numMemPorts = 0
  val io = new GenericAcceleratorIF(numMemPorts, p) {
    val op = Vec.fill(2) {UInt(INPUT, width = 32)}
    val sum = UInt(OUTPUT, width = 32)
  }
  io.signature := makeDefaultSignature()
  io.sum := io.op(0) + io.op(1)
}
