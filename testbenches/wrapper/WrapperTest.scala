package TidbitsTestbenches

import Chisel._
import TidbitsAXI._

class WrapperTest(p: AXIAccelWrapperParams) extends AXIWrappableAccel(p) {

  // continuously write reg(0)+reg(1) to reg(2)
  io.regOut(2).valid := Bool(true)
  io.regOut(2).bits := io.regIn(0) + io.regIn(1)

  // write a constant value to reg(3)
  io.regOut(3).valid := Bool(true)
  io.regOut(3).bits := UInt("hdeadbeef")
}
