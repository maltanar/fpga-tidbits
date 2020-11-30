package fpgatidbits.PlatformWrapper

import chisel3._
import chisel3.util._

// wrapper for a "generic" SDAccel platform

object GenericSDAccelParams extends PlatformWrapperParams {
  val platformName = "GenericSDAccel"
  val memAddrBits = 64
  val memDataBits = 64
  val memIDBits = 1
  val memMetaBits = 1
  val numMemPorts = 1
  val sameIDInOrder = true
  val typicalMemLatencyCycles = 128
  val burstBeats = 8
  val coherentMem = false
  var regDriverTargetDir: String = "GenericSDAccel"
}

class GenericSDAccelWrapper(instFxn: PlatformWrapperParams => GenericAccelerator, val targetDir: String)
  extends AXIPlatformWrapper(GenericSDAccelParams, instFxn) {
  val platformDriverFiles = baseDriverFiles ++ Array[String](
    "platform-genericsdaccel.cpp", "xclhalwrapper.hpp"
  )
  suggestName("GenericSDAccelWrapper")
  override def desiredName = "GenericSDAccelWrapper"

  this.p.regDriverTargetDir = targetDir
}
