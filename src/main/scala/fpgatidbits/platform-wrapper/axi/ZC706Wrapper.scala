package fpgatidbits.PlatformWrapper

import chisel3._

// platform wrapper for the ZC706, not using the dedicated PL DDR

object ZC706Params extends PlatformWrapperParams {
  val platformName = "ZC706"
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


class ZC706Wrapper(instFxn: PlatformWrapperParams => GenericAccelerator, targetDir: String)
  extends AXIPlatformWrapper(ZC706Params, instFxn) {
  val platformDriverFiles = baseDriverFiles ++ Array[String](
    "platform-zc706-linux.cpp", "linuxphysregdriver.hpp", "axiregdriver.hpp"
  )
  suggestName("ZC706Wrapper")
}
