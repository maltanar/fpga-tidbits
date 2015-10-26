import Chisel._
import TidbitsTestbenches._
import TidbitsOCM._
import TidbitsStreams._
import TidbitsSimUtils._
import TidbitsAXI._
import TidbitsDMA._
import TidbitsPlatformWrapper._

object MainObj {
  type AccelInstFxn = PlatformWrapperParams => GenericAccelerator
  type AccelMap = Map[String, AccelInstFxn]
  type PlatformInstFxn = AccelInstFxn => PlatformWrapper
  type PlatformMap = Map[String, PlatformInstFxn]


  val accelMap: AccelMap  = Map(
    "TestRegOps" -> {p => new TestRegOps(p)}
  )

  val platformMap: PlatformMap = Map(
    "ZedBoard" -> {f => new ZedBoardWrapper(f)},
    "WX690T" -> {f => new WolverinePlatformWrapper(f)}
  )

  def makeVerilog(args: Array[String]) = {
    val accelName = args(0)
    val platformName = args(1)
    val accInst = accelMap(accelName)
    val platformInst = platformMap(platformName)
    val chiselArgs = Array("--v")

    chiselMain(chiselArgs, () => Module(platformInst(accInst)))
  }

  def makeDriver(args: Array[String]) = {
    val accelName = args(0)
    val platformName = args(1)
    val accInst = accelMap(accelName)
    val platformInst = platformMap(platformName)

    platformInst(accInst).generateRegDriver(".")
  }


  def main(args: Array[String]): Unit = {
    val op = args(0)
    val rst = args.drop(1)

    if (op == "verilog" || op == "v") {
      makeVerilog(rst)
    } else if (op == "driver" || op == "d") {
      makeDriver(rst)
    } else {
      throw new Exception("Unrecognized operation")
    }
  }
}
