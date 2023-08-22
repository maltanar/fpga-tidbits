package fpgatidbits.PlatformWrapper

import chisel3._

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

class PYNQU96Wrapper(instFxn: PlatformWrapperParams => GenericAccelerator, targetDir: String)
  extends AXIPlatformWrapper(PYNQU96Params, instFxn) {
  val platformDriverFiles = baseDriverFiles ++ Array[String](
    "platform-mpsoc-xlnk.cpp", "xlnkdriver.hpp"
  )
  suggestName("PYNQU96Wrapper")
}
