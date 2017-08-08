package fpgatidbits.PlatformWrapper

import Chisel._

// platform wrapper for PYNQ

object PYNQParams extends PlatformWrapperParams {
  val platformName = "PYNQ"
  val memAddrBits = 32
  val memDataBits = 64
  val memIDBits = 6
  val memMetaBits = 1
  val numMemPorts = 0
  val sameIDInOrder = true
  val typicalMemLatencyCycles = 32
  val burstBeats = 8  // TODO why cap bursts at 8? AXI can do more
}

class PYNQWrapper(instFxn: PlatformWrapperParams => GenericAccelerator)
  extends AXIPlatformWrapper(PYNQParams, instFxn) {
  val platformDriverFiles = baseDriverFiles ++ Array[String](
    "platform-xlnk.cpp", "xlnkdriver.hpp"
  )
}
