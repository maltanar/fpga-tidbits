package fpgatidbits.PlatformWrapper

import Chisel._

// platform wrapper for the ZedBoard

object ZedBoardParams extends PlatformWrapperParams {
  val platformName = "ZedBoard"
  val memAddrBits = 32
  val memDataBits = 64
  val memIDBits = 6
  val memMetaBits = 1
  val numMemPorts = 4
  val sameIDInOrder = true
  val typicalMemLatencyCycles = 32
  val burstBeats = 8  // TODO why cap bursts at 8? AXI can do more
  val coherentMem = false // TODO add CC version
}


class ZedBoardWrapper(instFxn: PlatformWrapperParams => GenericAccelerator)
  extends AXIPlatformWrapper(ZedBoardParams, instFxn) {
  val platformDriverFiles = baseDriverFiles ++ Array[String](
    "platform-zedboard.cpp", "zedboardregdriver.hpp", "axiregdriver.hpp"
  )
}

class ZedBoardLinuxWrapper(instFxn: PlatformWrapperParams => GenericAccelerator)
extends AXIPlatformWrapper(ZedBoardParams, instFxn) {
  val platformDriverFiles = baseDriverFiles ++ Array[String](
    "platform-zedboard-linux.cpp", "linuxphysregdriver.hpp", "axiregdriver.hpp"
  )
}
