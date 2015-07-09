package TidbitsTestbenches

import Chisel._
import TidbitsAXI._

class WrapperTestSum(p: AXIAccelWrapperParams) extends AXIWrappableAccel(p) {
  override lazy val accelVersion = "1.0.0"
  plugRegOuts()
  plugMemWritePort()
  plugMemReadPort()

  val in = new Bundle {
    val op = Vec.fill(2) {UInt(width = 32)}
  }

  val out = new Bundle {
    val sum = UInt(width = 32)
  }
  manageRegIO(in, out)

  out.sum := in.op(0) + in.op(1)
}
