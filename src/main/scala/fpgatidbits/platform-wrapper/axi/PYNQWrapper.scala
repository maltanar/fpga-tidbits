package fpgatidbits.PlatformWrapper

import java.nio.file.Paths

import chisel3._
import chisel3.util._
import fpgatidbits.TidbitsMakeUtils.fileCopyBulk

// platform wrapper for PYNQ

object PYNQZ1Params extends PlatformWrapperParams {
  val platformName = "PYNQZ1"
  val memAddrBits = 32
  val memDataBits = 64
  val memIDBits = 6
  val memMetaBits = 1
  val numMemPorts = 4
  val sameIDInOrder = true
  val typicalMemLatencyCycles = 32
  val burstBeats = 8  // TODO why cap bursts at 8? AXI can do more
  val coherentMem = false // TODO add CC version of PYNQZ1 as well
  val hasStreamInterface = false
}

class PYNQZ1Wrapper(instFxn: PlatformWrapperParams => GenericAccelerator, targetDir: String)
  extends AXIPlatformWrapper(PYNQZ1Params, instFxn) {
  val platformDriverFiles = baseDriverFiles ++ Array[String](
    "platform-xlnk.cpp", "xlnkdriver.hpp"
  )
  suggestName("PYNQZ1Wrapper")
  override def desiredName = "PYNQZ1Wrapper"
  // Generate the RegFile driver
  generateCppRegDriver(targetDir)

  // Copy over the other needed files
  val resRoot = Paths.get("./src/main/resources")
  fileCopyBulk(s"${resRoot}/cpp/platform-wrapper-regdriver/", targetDir, platformDriverFiles)
  println(s"=======> Driver files copied to ${targetDir}")
}
