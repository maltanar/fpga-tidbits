package TidbitsPlatformWrapper

import Chisel._

// platform wrapper for the ZedBoard

object ZedBoardParams extends PlatformWrapperParams {
  val platformName = "ZedBoard"
  val memAddrBits = 32
  val memDataBits = 64
  val memIDBits = 6
  val memMetaBits = 1
  val csrDataBits = 32
  val numMemPorts = 4
}


class ZedBoardWrapper(instFxn: PlatformWrapperParams => GenericAccelerator)
  extends AXIPlatformWrapper(ZedBoardParams, instFxn) {

  val driverRegType = "AccelReg"
  val driverBaseHeader = "axiregdriver.hpp"
  val driverBaseClass = "AXIRegDriver"
  val driverConstructor =   fullName + "(void* baseAddr) : " +
                            driverBaseClass+"(baseAddr) {}"

}
