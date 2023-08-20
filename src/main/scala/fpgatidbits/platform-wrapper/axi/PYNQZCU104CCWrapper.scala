package fpgatidbits.PlatformWrapper

import chisel3._

// platform wrapper for PYNQ on Ultra-96 with one cache-coherent port

object PYNQZCU104CCParams extends PlatformWrapperParams {
  val platformName = "PYNQZCU104CC"
  val memAddrBits = 32
  val memDataBits = 64
  val memIDBits = 6
  val memMetaBits = 1
  val numMemPorts = 1
  val sameIDInOrder = true
  val typicalMemLatencyCycles = 32
  val burstBeats = 8  // TODO why cap bursts at 8? AXI can do more
  val coherentMem = true
}

class PYNQZCU104CCWrapper(instFxn: PlatformWrapperParams => GenericAccelerator)
  extends AXIPlatformWrapper(PYNQZCU104Params, instFxn) {
  val platformDriverFiles = baseDriverFiles ++ Array[String](
    "platform-mpsoc-cc-xlnk.cpp", "xlnkdriver.hpp"
  )
  suggestName("PYNQZCU104CCWrapper")
  // override AXI MM signals for cache coherency
  mem(0).readAddr.bits.cache := "b1100".U
  mem(0).writeAddr.bits.cache := "b1100".U
  mem(0).readAddr.bits.prot := "b10".U
  mem(0).writeAddr.bits.prot := "b10".U
}
