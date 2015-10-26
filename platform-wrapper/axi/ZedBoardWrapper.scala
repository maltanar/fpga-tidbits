package TidbitsPlatformWrapper

import Chisel._

// platform wrapper for the ZedBoard

object ZedBoardParams extends PlatformWrapperParams {
  val platformName = "zedboard"
  val memAddrBits = 32
  val memDataBits = 64
  val memIDBits = 6
  val memMetaBits = 1
  val csrDataBits = 64
  val numMemPorts = 1
}


class ZedBoardWrapper(instFxn: PlatformWrapperParams => GenericAccelerator)
  extends AXIPlatformWrapper(ZedBoardParams, instFxn) {

  val driverRegType = "unsigned int"
  val driverBaseHeader = "zedboardregdriver.h"
  val driverBaseClass = "ZedBoardRegDriver"
  val driverConstructor =   fullName + "(unsigned int baseAddr) : " +
                            driverBaseClass+"(\""+fullName+"\") {" +
                            "m_baseAddr = baseAddr; }"

}
