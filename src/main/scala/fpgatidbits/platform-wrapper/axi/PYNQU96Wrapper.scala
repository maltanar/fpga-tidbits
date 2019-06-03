package fpgatidbits.PlatformWrapper

import Chisel._

// platform wrapper for PYNQ on Ultra-96

object PYNQU96Params extends PlatformWrapperParams {
  val platformName = "PYNQU96"
  val memAddrBits = 32
  val memDataBits = 64
  val memIDBits = 6
  val memMetaBits = 1
  val numMemPorts = 4
  val sameIDInOrder = true
  val typicalMemLatencyCycles = 32
  val burstBeats = 8  // TODO why cap bursts at 8? AXI can do more
  val coherentMem = false
}

class PYNQU96Wrapper(instFxn: PlatformWrapperParams => GenericAccelerator)
  extends AXIPlatformWrapper(PYNQU96Params, instFxn) {
  val platformDriverFiles = baseDriverFiles ++ Array[String](
    "platform-ultra96-xlnk.cpp", "xlnkdriver.hpp"
  )
  setName("PYNQU96Wrapper")
  setModuleName("PYNQU96Wrapper")
}
