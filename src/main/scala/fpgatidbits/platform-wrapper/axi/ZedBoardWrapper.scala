package fpgatidbits.PlatformWrapper

import chisel3._
import chisel3.util._
import java.nio.file.Paths

import fpgatidbits.TidbitsMakeUtils._

import scala.io.Source
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


class ZedBoardWrapper(instFxn: PlatformWrapperParams => GenericAccelerator, targetDir: String, generateRegDriver: Boolean = true)
  extends AXIPlatformWrapper(ZedBoardParams, instFxn) {
  val platformDriverFiles = baseDriverFiles ++ Array[String](
    "platform-zedboard.cpp", "zedboardregdriver.hpp", "axiregdriver.hpp"
  )

  if (generateRegDriver) {
    // Generate the RegFile driver
    println("Generating Register Driver at directory:" + targetDir)
    generateRegDriver(targetDir)
    // Copy over the other needed files
    //val resRoot = getClass.getResource("").getPath
    resourceCopyBulk("cpp/platform-wrapper-regdriver/", targetDir, platformDriverFiles)
    println(s"=======> Driver files copied to ${targetDir}")

  }

}

class ZedBoardLinuxWrapper(instFxn: PlatformWrapperParams => GenericAccelerator, targetDir: String)
extends AXIPlatformWrapper(ZedBoardParams, instFxn) {
  val platformDriverFiles = baseDriverFiles ++ Array[String](
    "platform-zedboard-linux.cpp", "linuxphysregdriver.hpp", "axiregdriver.hpp"
  )

  // Generate the RegFile driver
  generateRegDriver(targetDir)

  // Copy over the other needed files
  resourceCopyBulk("/cpp/platform-wrapper-regdriver/", targetDir, platformDriverFiles)
  println(s"=======> Driver files copied to ${targetDir}")
}
