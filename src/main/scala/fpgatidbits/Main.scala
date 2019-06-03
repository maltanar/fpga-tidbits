package fpgatidbits

import Chisel._
import fpgatidbits.Testbenches._
import fpgatidbits.ocm._
import fpgatidbits.streams._
import fpgatidbits.SimUtils._
import fpgatidbits.axi._
import fpgatidbits.dma._
import fpgatidbits.PlatformWrapper._
import fpgatidbits.hlstools._
import java.io.{File,FileInputStream,FileOutputStream}
import sys.process._

object TidbitsMakeUtils {
  type AccelInstFxn = PlatformWrapperParams => GenericAccelerator
  type PlatformInstFxn = AccelInstFxn => PlatformWrapper
  type PlatformMap = Map[String, PlatformInstFxn]

  val platformMap: PlatformMap = Map(
    "ZedBoard" -> {f => new ZedBoardWrapper(f)},
    "PYNQZ1" -> {f => new PYNQZ1Wrapper(f)},
    "PYNQU96" -> {f => new PYNQU96Wrapper(f)},
    "PYNQU96CC" -> {f => new PYNQU96CCWrapper(f)},
    "GenericSDAccel" -> {f => new GenericSDAccelWrapper(f)},
    "ZC706" -> {f => new ZC706Wrapper(f)},
    "WX690T" -> {f => new WolverinePlatformWrapper(f)},
    "VerilatedTester" -> {f => new VerilatedTesterWrapper(f)},
    "Tester" -> {f => new TesterWrapper(f)}
  )

  // handy to have a few commonly available Xilinx FPGA boards here
  val fpgaPartMap = Map(
    "ZedBoard" -> "xc7z020clg400-1",
    "PYNQZ1" -> "xc7z020clg400-1",
    "PYNQU96" -> "xczu3eg-sbva484-1-i",
    "PYNQU96CC" -> "xczu3eg-sbva484-1-i",
    "ZC706" -> "xc7z045ffg900-2",
    "KU115" -> "xcku115-flvb2104-2-e",
    "VerilatedTester" -> "xczu3eg-sbva484-1-i", // use Ultra96 part for tester
    "VU9P" -> "xcvu9p-flgb2104-2-i"
  )

  def fileCopy(from: String, to: String) = {
    s"cp -f $from $to" !
  }

  def fileCopyBulk(fromDir: String, toDir: String, fileNames: Seq[String]) = {
    for(f <- fileNames)
      fileCopy(s"$fromDir/$f", s"$toDir/$f")
  }

  def makeEmulatorLibrary(accInst: AccelInstFxn, outDir: String, gOpts: Seq[String] = Seq(), chiselOpts: Seq[String] = Seq()) = {
    val fullDir = s"realpath $outDir".!!.filter(_ >= ' ')
    val platformInst = platformMap("Tester")
    val drvDir = getClass.getResource("/cpp/platform-wrapper-regdriver").getPath
    val chiselArgs = Array("--backend","c","--targetDir", fullDir) ++ chiselOpts

    chiselMain(chiselArgs, () => Module(platformInst(accInst)))
    val p = platformInst(accInst)
    // build reg driver
    p.generateRegDriver(s"$fullDir")
    // copy emulator driver and SW support files
    fileCopyBulk(drvDir, fullDir, p.platformDriverFiles)
    val drvFiles = p.platformDriverFiles.map(x => fullDir+"/"+x)
    // get only the cpp files
    val regex = "(.*\\.cpp)"
    val cppDrvFiles = drvFiles.filter(x => x matches regex)
    // call g++ to produce a shared library
    println("Compiling hardware emulator as library...")
    val gc = Seq(
      "g++", "-shared", "-fPIC", "-o", s"$fullDir/driver.a"
    ) ++ gOpts ++ cppDrvFiles ++ Seq(outDir+"/TesterWrapper.cpp")
    println(gc.mkString(" "))
    val gcret = gc.!!
    println(gcret)
    println(s"Hardware emulator library built as $fullDir/driver.a")
  }

  def makeDriverLibrary(p: PlatformWrapper, outDir: String) = {
    val fullDir = s"realpath $outDir".!!.filter(_ >= ' ')
    val drvDir = getClass.getResource("/cpp/platform-wrapper-regdriver").getPath
    val mkd = s"mkdir -p $fullDir".!!
    // copy necessary files to build the driver
    fileCopyBulk(drvDir, fullDir, p.platformDriverFiles)
    val fullFiles = p.platformDriverFiles.map(x => fullDir+"/"+x)
    // call g++ to produce a shared library
    println("Compiling driver as library...")
    val gc = (Seq(
      "g++", "-I/opt/convey/include", "-I/opt/convey/pdk2/latest/wx-690/include",
      "-shared", "-fPIC", "-o", s"$fullDir/driver.a"
    ) ++ fullFiles).!!
    println(s"Hardware driver library built as $fullDir/driver.a")
  }

  def makeVerilator(accInst: AccelInstFxn, destDir: String) = {
    val tidbitsDir = getClass.getResource("/").getPath

    val platformInst = {f => new VerilatedTesterWrapper(f)}
    val chiselArgs = Array("--backend","v","--targetDir", s"$destDir")
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

  def makeHLSDependencies(
    // the accelerator instantiation function
    accInst: AccelInstFxn,
    // path to HLS sources, each HLSBlackBox function assumed to live under
    // a .cpp file with its own name under this folder
    hlsSrcDir: String,
    // target directory where generated Verilog will be placed
    destDir: String,
    // include directories for HLS sources
    inclDirs: Seq[String] = Seq(),
    // FPGA part to use during HLS synthesis
    fpgaPart: String = "xc7z020clg400-1",
    // target clock period for HLS synthesis, in nanoseconds
    nsClk: String = "5.0"
  ) = {
    // make an instance of the accelerator using the given function
    val acc = accInst(TesterWrapperParams)

    println("Generating HLS dependencies...")
    // generate HLS for each registered HLSBlackBox dependency
    for(hls_bb <- acc.hlsBlackBoxes) {
      val hls_fxn_name = hls_bb.getClass.getSimpleName
      println(s"Generating HLS for ${hls_fxn_name}")
      // use a temp dir for synthesis, remove if exists
      val synDir = s"/tmp/hls_syn_${hls_fxn_name}"
      s"rm -rf $synDir".!!
      s"mkdir -p $synDir".!!
      // generate include file that sets args for templated functions
      println(s"Writing template defines to ${synDir}/${hls_fxn_name}_TemplateDefs.hpp")
      hls_bb.generateTemplateDefines(s"${synDir}/${hls_fxn_name}_TemplateDefs.hpp")
      val inclDirs_withTemplateDefines = inclDirs ++ Seq(s"${synDir}")
      // call HLS synthesis to generate Verilog
      TidbitsHLSTools.hlsToVerilog(
        s"${hlsSrcDir}/${hls_fxn_name}.cpp",
        destDir, synDir, hls_fxn_name, hls_fxn_name,
        inclDirs_withTemplateDefines, fpgaPart, nsClk
      )
    }
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

  val platformMap = TidbitsMakeUtils.platformMap

  def fileCopy(from: String, to: String) = {
    s"cp -f $from $to".!!
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

    val targetDir = s"emu-$accelName"
    println(s"Creating emulator in $targetDir")
    val accInst = accelMap(accelName)
    val platformInst = platformMap("Tester")
    val chiselArgs = Array("--backend","c","--targetDir", targetDir)

    chiselMain(chiselArgs, () => Module(platformInst(accInst)))
    // build driver
    platformInst(accInst).generateRegDriver(s"$targetDir/")
    // copy emulator driver and SW support files
    val regDrvRoot = getClass.getResource("/cpp/platform-wrapper-regdriver").getPath + "/"
    val files = Array("wrapperregdriver.h", "platform-tester.cpp",
      "platform.h", "testerdriver.hpp")
    for(f <- files) { fileCopy(regDrvRoot + f, s"$targetDir/" + f) }
    val testRoot = getClass.getResource("/cpp/platform-wrapper-tests").getPath + "/"
    fileCopy(testRoot + accelName + ".cpp", s"$targetDir/main.cpp")
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

    val resRoot = getClass.getResource("/").getPath
    // copy blackbox verilog, scripts, driver and SW support files
    fileCopyBulk(s"$resRoot/verilog/", "verilator/", verilogBlackBoxFiles)
    fileCopyBulk(s"$resRoot/script/", "verilator/", scriptFiles)
    fileCopyBulk(s"$resRoot/cpp/platform-wrapper-regdriver/", "verilator/",
      driverFiles)
    // build driver
    platformInst(accInst).generateRegDriver("verilator/")
    // copy test application
    val testRoot = s"$resRoot/cpp/platform-wrapper-tests/"
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
