package fpgatidbits.PlatformWrapper

import Chisel._

// wrapper for a "generic" SDAccel platform

object GenericSDAccelParams extends PlatformWrapperParams {
  val platformName = "GenericSDAccel"
  val memAddrBits = 64
  val memDataBits = 512
  val memIDBits = 6
  val memMetaBits = 1
  val numMemPorts = 1
  val sameIDInOrder = true
  val typicalMemLatencyCycles = 128
  val burstBeats = 8
}

class GenericSDAccelWrapper(instFxn: PlatformWrapperParams => GenericAccelerator)
  extends AXIPlatformWrapper(GenericSDAccelParams, instFxn) {
  val platformDriverFiles = baseDriverFiles ++ Array[String](
    "platform-genericsdaccel.cpp", "xclhalwrapper.hpp"
  )
  setName("GenericSDAccelWrapper")
  setModuleName("GenericSDAccelWrapper")
}
