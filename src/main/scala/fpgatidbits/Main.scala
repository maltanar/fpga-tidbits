package fpgatidbits

import Chisel._
import fpgatidbits.Testbenches._
import fpgatidbits.ocm._
import fpgatidbits.streams._
import fpgatidbits.SimUtils._
import fpgatidbits.axi._
import fpgatidbits.dma._
import fpgatidbits.PlatformWrapper._

object TidbitsMakeUtils {
  type AccelInstFxn = PlatformWrapperParams => GenericAccelerator

  def fileCopy(from: String, to: String) = {
    import java.io.{File,FileInputStream,FileOutputStream}
    import sys.process._
    s"cp -f $from $to" !
  }

  def fileCopyBulk(fromDir: String, toDir: String, fileNames: Seq[String]) = {
    for(f <- fileNames)
      fileCopy(s"$fromDir/$f", s"$toDir/$f")
  }

  def makeVerilator(accInst: AccelInstFxn, tidbitsDir: String,
  destDir: String) = {

    val platformInst = {f => new VerilatedTesterWrapper(f)}
    val chiselArgs = Array("--backend","v","--targetDir", "verilator")
    // generate verilog for the accelerator
    chiselMain(chiselArgs, () => Module(platformInst(accInst)))
    val verilogBlackBoxFiles = Seq("Q_srl.v", "DualPortBRAM.v")
    val scriptFiles = Seq("verilator-build.sh")
    val driverFiles = Seq("wrapperregdriver.h", "platform-verilatedtester.cpp",
      "platform.h", "verilatedtesterdriver.hpp")

    // copy blackbox verilog, scripts, driver and SW support files
    fileCopyBulk(s"$tidbitsDir/verilog/", destDir, verilogBlackBoxFiles)
    fileCopyBulk(s"$tidbitsDir/script/", destDir, scriptFiles)
    fileCopyBulk(s"$tidbitsDir/cpp/platform-wrapper-regdriver/", destDir,
      driverFiles)
    // build driver
    platformInst(accInst).generateRegDriver(destDir)
  }
}


object MainObj {
  type AccelInstFxn = PlatformWrapperParams => GenericAccelerator
  type AccelMap = Map[String, AccelInstFxn]
  type PlatformInstFxn = AccelInstFxn => PlatformWrapper
  type PlatformMap = Map[String, PlatformInstFxn]


  val accelMap: AccelMap  = Map(
    "TestRegOps" -> {p => new TestRegOps(p)},
    "TestSum" -> {p => new TestSum(p)},
    "TestMultiChanSum" -> {p => new TestMultiChanSum(p)},
    "TestSeqWrite" -> {p => new TestSeqWrite(p)},
    "TestCopy" -> {p => new TestCopy(p)},
    "TestRandomRead" -> {p => new TestRandomRead(p)},
    "TestBRAM" -> {p => new TestBRAM(p)},
    "TestBRAMMasked" -> {p => new TestBRAMMasked(p)},
    "TestMemLatency" -> {p => new TestMemLatency(p)},
    "TestGather" -> {p => new TestGather(p)}
  )

  val platformMap: PlatformMap = Map(
    "ZedBoard" -> {f => new ZedBoardWrapper(f)},
    "WX690T" -> {f => new WolverinePlatformWrapper(f)},
    "Tester" -> {f => new TesterWrapper(f)}
  )

  def fileCopy(from: String, to: String) = {
    import java.io.{File,FileInputStream,FileOutputStream}
    import sys.process._
    s"cp -f $from $to" !
    /*
    val src = new File(from)
    val dest = new File(to)
    new FileOutputStream(dest) getChannel() transferFrom(
      new FileInputStream(src) getChannel, 0, Long.MaxValue )
      */
  }

  def fileCopyBulk(fromDir: String, toDir: String, fileNames: Seq[String]) = {
    for(f <- fileNames)
      fileCopy(fromDir + f, toDir + f)
  }

  def makeVerilog(args: Array[String]) = {
    val accelName = args(0)
    val platformName = args(1)
    val accInst = accelMap(accelName)
    val platformInst = platformMap(platformName)
    val chiselArgs = Array("--backend", "v")

    chiselMain(chiselArgs, () => Module(platformInst(accInst)))
  }

  def makeEmulator(args: Array[String]) = {
    val accelName = args(0)

    val accInst = accelMap(accelName)
    val platformInst = platformMap("Tester")
    val chiselArgs = Array("--backend","c","--targetDir", "emulator")

    chiselMain(chiselArgs, () => Module(platformInst(accInst)))
    // build driver
    platformInst(accInst).generateRegDriver("emulator/")
    // copy emulator driver and SW support files
    val regDrvRoot = "src/main/cpp/platform-wrapper-regdriver/"
    val files = Array("wrapperregdriver.h", "platform-tester.cpp",
      "platform.h", "testerdriver.hpp")
    for(f <- files) { fileCopy(regDrvRoot + f, "emulator/" + f) }
    val testRoot = "src/main/cpp/platform-wrapper-tests/"
    fileCopy(testRoot + accelName + ".cpp", "emulator/main.cpp")
  }

  def makeVerilator(args: Array[String]) = {
    val accelName = args(0)

    val accInst = accelMap(accelName)
    val platformInst = {f => new VerilatedTesterWrapper(f)}
    val chiselArgs = Array("--backend","v","--targetDir", "verilator")
    // generate verilog for the accelerator
    chiselMain(chiselArgs, () => Module(platformInst(accInst)))
    val verilogBlackBoxFiles = Seq("Q_srl.v", "DualPortBRAM.v")
    val scriptFiles = Seq("verilator-build.sh")
    val driverFiles = Seq("wrapperregdriver.h", "platform-verilatedtester.cpp",
      "platform.h", "verilatedtesterdriver.hpp")

    // copy blackbox verilog, scripts, driver and SW support files
    fileCopyBulk("src/main/verilog/", "verilator/", verilogBlackBoxFiles)
    fileCopyBulk("src/main/script/", "verilator/", scriptFiles)
    fileCopyBulk("src/main/cpp/platform-wrapper-regdriver/", "verilator/",
      driverFiles)
    // build driver
    platformInst(accInst).generateRegDriver("verilator/")
    // copy test application
    val testRoot = "src/main/cpp/platform-wrapper-tests/"
    fileCopy(testRoot + accelName + ".cpp", "verilator/main.cpp")
  }

  def makeDriver(args: Array[String]) = {
    val accelName = args(0)
    val platformName = args(1)
    val accInst = accelMap(accelName)
    val platformInst = platformMap(platformName)

    platformInst(accInst).generateRegDriver(".")
  }

  def showHelp() = {
    println("Usage: run <op> <accel> <platform>")
    println("where:")
    println("<op> = (v)erilog (d)river (e)mulator ve(r)ilator")
    println("<accel> = " + accelMap.keys.reduce({_ + " " +_}))
    println("<platform> = " + platformMap.keys.reduce({_ + " " +_}))
  }

  def main(args: Array[String]): Unit = {
    if (args.size != 3) {
      showHelp()
      return
    }

    val op = args(0)
    val rst = args.drop(1)

    if (op == "verilog" || op == "v") {
      makeVerilog(rst)
    } else if (op == "driver" || op == "d") {
      makeDriver(rst)
    } else if (op == "emulator" || op == "e") {
      makeEmulator(rst)
    } else if (op == "verilator" || op == "r") {
      makeVerilator(rst)
    }else {
      showHelp()
      return
    }
  }
}
