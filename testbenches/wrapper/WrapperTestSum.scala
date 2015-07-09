package TidbitsTestbenches

import Chisel._
import TidbitsAXI._

class WrapperTestSum(p: AXIAccelWrapperParams) extends AXIWrappableAccel(p) {
  plugRegOuts()
  plugMemWritePort()
  plugMemReadPort()

  val in = new Bundle {
    val op = Vec.fill(2) {UInt(width = 32)}
  }

  val out = new Bundle {
    val sum = UInt(width = 32)
  }
  manageRegIO(UInt("h12341234"), in, out)

  out.sum := in.op(0) + in.op(1)
}
