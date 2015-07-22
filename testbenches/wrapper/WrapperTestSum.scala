package TidbitsTestbenches

import Chisel._
import TidbitsAXI._
import TidbitsSimUtils._

class WrapperTestSum(p: AXIAccelWrapperParams) extends AXIWrappableAccel(p) {
  override lazy val accelVersion = "1.0.0"
  plugRegOuts()
  plugMemWritePorts()
  plugMemReadPorts()

  val in = new Bundle {
    val op = Vec.fill(2) {UInt(width = 32)}
  }

  val out = new Bundle {
    val sum = UInt(width = 32)
  }
  override lazy val regMap = manageRegIO(in, out)

  out.sum := in.op(0) + in.op(1)

  // default test
  override def defaultTest(t: WrappableAccelTester): Boolean = {
    t.expectReg("signature", UInt("h" + accelSignature).litValue())
    t.writeReg("in_op_0", 100)
    t.writeReg("in_op_1", 200)
    t.step(10)
    t.expectReg("out_sum", 300)

    return true
  }
}
