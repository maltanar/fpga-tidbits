package fpgatidbits

import chisel3._
import fpgatidbits.PlatformWrapper._
import fpgatidbits.examples._

import java.io.{File, FileInputStream, FileOutputStream}
import scala.language.postfixOps
import sys.process._
import java.nio.file.{Files, Paths, StandardCopyOption}

object TidbitsMakeUtils {
  type AccelInstFxn = PlatformWrapperParams => GenericAccelerator
  type PlatformInstFxn = (AccelInstFxn, String) => PlatformWrapper
  type PlatformMap = Map[String, PlatformInstFxn]

  val platformMap: PlatformMap = Map(
    "ZedBoard" -> { (f, targetDir) => new ZedBoardWrapper(f, targetDir) },
    "PYNQZ1" -> { (f, targetDir) => new PYNQZ1Wrapper(f, targetDir) },
    "PYNQU96" -> {(f, targetDir) => new PYNQU96Wrapper(f, targetDir)},
    "PYNQU96CC" -> {(f, targetDir) => new PYNQU96CCWrapper(f, targetDir)},
    "PYNQZCU104" -> {(f, targetDir) => new PYNQZCU104Wrapper(f, targetDir)},
    "PYNQZCU104CC" -> {(f, targetDir) => new PYNQZCU104CCWrapper(f, targetDir)},
    "GenericSDAccel" -> {(f, targetDir) => new GenericSDAccelWrapper(f, targetDir)},
    "ZC706" -> {(f, targetDir) => new ZC706Wrapper(f, targetDir)},
    "WX690T" -> {(f, targetDir) => new WolverinePlatformWrapper(f, targetDir)},
    "VerilatedTester" -> { (f, targetDir) => new VerilatedTesterWrapper(f, targetDir) },
    "Tester" -> { (f, targetDir) => new TesterWrapper(f, targetDir) }
  )

  // handy to have a few commonly available Xilinx FPGA boards here
  val fpgaPartMap = Map(
    "ZedBoard" -> "xc7z020clg400-1",
    "PYNQZ1" -> "xc7z020clg400-1",
    "PYNQU96" -> "xczu3eg-sbva484-1-i",
    "PYNQU96CC" -> "xczu3eg-sbva484-1-i",
    "PYNQZCU104" -> "xczu7ev-ffvc1156-2-e",
    "PYNQZCU104CC" -> "xczu7ev-ffvc1156-2-e",
    "ZC706" -> "xc7z045ffg900-2",
    "KU115" -> "xcku115-flvb2104-2-e",
    "VU9P" -> "xcvu9p-flgb2104-2-i",
    "VerilatedTester" -> "xczu3eg-sbva484-1-i" // use Ultra96 part for tester
  )

  def resourceCopy(res: String, to: String) = {
    val resourceStream = Option(getClass.getClassLoader.getResourceAsStream(res))
      .getOrElse(throw new IllegalArgumentException(s"Resource not found: $res"))
    Files.copy(resourceStream, Paths.get(to), StandardCopyOption.REPLACE_EXISTING)
  }

  def resourceCopyBulk(fromDir: String, toDir: String, fileNames: Seq[String]) = {
    for (f <- fileNames) {
        resourceCopy(Paths.get(fromDir).resolve(f).toString, Paths.get(toDir).resolve(f).toString)
      }
  }

  def makeDriverLibrary(p: PlatformWrapper, outDir: String) = {
    val fullDir = s"realpath $outDir".!!.filter(_ >= ' ')
    val drvDir = "/cpp/platform-wrapper-regdriver"
    val mkd = s"mkdir -p $fullDir".!!
    // copy necessary files to build the driver
    resourceCopyBulk(drvDir, fullDir, p.platformDriverFiles)
    val fullFiles = p.platformDriverFiles.map(x => fullDir + "/" + x)
    // call g++ to produce a shared library
    println("Compiling driver as library...")
    val gc = (Seq(
      "g++", "-I/opt/convey/include", "-I/opt/convey/pdk2/latest/wx-690/include",
      "-shared", "-fPIC", "-o", s"$fullDir/driver.a"
    ) ++ fullFiles).!!
    println(s"Hardware driver library built as $fullDir/driver.a")
  }
}

object MainObj {
  type AccelInstFxn = PlatformWrapperParams => GenericAccelerator
  type AccelMap = Map[String, AccelInstFxn]
  type PlatformInstFxn = AccelInstFxn => PlatformWrapper
  type PlatformMap = Map[String, PlatformInstFxn]

  val accelMap: AccelMap = Map(
    "ExampleRegOps" -> {p => new ExampleRegOps(p)},
    "ExampleSum" -> { p => new ExampleSum(p) },
    "ExampleMultiChanSum" -> {p => new ExampleMultiChanSum(p)},
    "ExampleSeqWrite" -> {p => new ExampleSeqWrite(p)},
    "ExampleCopy" -> {p => new ExampleCopy(p)},
    "ExampleRandomRead" -> {p => new ExampleRandomRead(p)},
    "ExampleBRAM" -> {p => new ExampleBRAM(p)},
    "ExampleBRAMMasked" -> {p => new ExampleBRAMMasked(p)},
    "ExampleMemLatency" -> {p => new ExampleMemLatency(p)},
    "ExampleGather" -> {p => new ExampleGather(p)},
    "ExampleSinglePortBRAM" -> {p => new ExampleSinglePortBRAM(p)},
    "HelloAccel" -> {p => new HelloAccel(p)}
  )

  val platformMap = TidbitsMakeUtils.platformMap


  def directoryDelete(dir: String): Unit = {
    s"rm -rf ${dir}".!!
  }

  def makeVerilog(args: Array[String]) = {
    val accelName = args(0)
    val platformName = args(1)
    val accInst = accelMap(accelName)
    val platformInst = platformMap(platformName)
    val targetDir = Paths.get(".").toString.dropRight(1) + s"$platformName-$accelName-driver/"
    val chiselArgs = Array("")

    (new chisel3.stage.ChiselStage).emitVerilog(platformInst(accInst, targetDir))

    // Copy test application
    //    val resRoot = Paths.get("./src/main/resources").toAbsolutePath
    //    val testRoot = s"$resRoot/cpp/platform-wrapper-tests/"
    //    fileCopy(testRoot + accelName  + ".cpp", s"${targetDir}/main.cpp")

  }

  def makeVerilator(args: Array[String]) = {
    val accelName = args(0)
    val accInst = accelMap(accelName)
    val targetDir = Paths.get(".").toString.dropRight(1) + s"verilator/${accelName}/"
    val chiselArgs = Array("--target-dir", targetDir)

    (new chisel3.stage.ChiselStage).emitVerilog(new VerilatedTesterWrapper(accInst, targetDir), chiselArgs)

    // copy test application
    TidbitsMakeUtils.resourceCopy(s"cpp/platform-wrapper-tests/${accelName}.cpp", s"$targetDir/main.cpp")
  }

  def makeIntegrationTest(args: Array[String]) = {
    val accelName = args(0)
    val targetDir = Paths.get(".").toString.dropRight(1) + s"integration-tests/${accelName}/"
    val accInst = accelMap(accelName)
    val chiselArgs = Array("--target-dir", targetDir)

    (new chisel3.stage.ChiselStage).emitVerilog(new VerilatedTesterWrapper(accInst, targetDir), chiselArgs)

    // copy test application
    TidbitsMakeUtils.resourceCopy( s"cpp/platform-wrapper-integration-tests/Test${accelName}.cpp", s"$targetDir/main.cpp")
  }

  def makeDriver(args: Array[String]) = {
    val accelName = args(0)
    val platformName = args(1)
    val accInst = accelMap(accelName)
    val platformInst = platformMap(platformName)
    // TODO: Is make driver necessary when we always create the regdriver?
    //platformInst(accInst).generateRegDriver(".")
  }

  def showHelp() = {
    println("Usage: run <op> <accel> <platform>")
    println("where:")
    println("<op> = (v)erilog (d)river ve(r)ilator integration (t)est")
    println("<accel> = " + accelMap.keys.reduce({
      _ + " " + _
    }))
    println("<platform> = " + platformMap.keys.reduce({
      _ + " " + _
    }))
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
      //makeDriver(rst)
      println("driver not implemented yet for chisel3")
      return
    } else if (op == "verilator" || op == "r") {
      makeVerilator(rst)
    } else if (op == "test" || op == "t") {
      makeIntegrationTest(rst)
    } else {
      showHelp()
      return
    }
  }
}
