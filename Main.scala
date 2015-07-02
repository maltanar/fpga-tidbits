import Chisel._
import TidbitsTestbenches._
import TidbitsOCM._
import TidbitsStreams._

object MainObj {
  val testOutputDir = "testOutput/"
  val verilogOutputDir = "verilogOutput/"
  def makeTestArgs(cmpName: String): Array[String] = {
    return Array( "--targetDir", testOutputDir+cmpName,
                  "--compile", "--test", "--genHarness")
  }

  def makeVerilogBuildArgs(cmpName: String): Array[String] = {
    return Array( "--targetDir", verilogOutputDir+cmpName, "--v")
  }

  def main(args: Array[String]): Unit = {
    //runTest_OCMAndController()
    runTest_HazardGuard()
  }

  def runTest_HazardGuard() {
    val p = new HazardGuardTestParams(4, 2, 2, 16, 32)

    val instModule = {() => Module(new HazardGuardTestHarness(p))}
    val instTest = {c => new HazardGuardTestHarnessTester(c)}
    val aT = makeTestArgs("HazardGuard")
    def aV = makeVerilogBuildArgs("HazardGuard")

    chiselMain(aV, instModule)
    chiselMainTest(aT, instModule)(instTest)
  }

  def runTest_OCMAndController() {
    val args = makeTestArgs("OCMAndController")
    val p = new OCMParameters(1024, 32, 1, 2, 3)
    p.printParams()
    chiselMainTest(args, () => Module(new OCMFillDump(p))) { c => new TestOCMAndController(c)}
  }
}
