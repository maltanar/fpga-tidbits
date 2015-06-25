import Chisel._
import TidbitsTestbenches._
import TidbitsOCM._

object MainObj {
  val testOutputDir = "testOutput/"
  val verilogOutputDir = "verilogOutput/"
  def makeTestArgs(cmpName: String): Array[String] = {
    return Array( "--targetDir", testOutputDir+cmpName,
                  "--compile", "--test", "--genHarness")
  }

  def makeVerilogBuildArgs(cmpName: String): Array[String] = {
    return Array( "--targetDir", verilogOutputDir+cmpName)
  }

  def main(args: Array[String]): Unit = {
    runTest_OCMAndController()
  }

  def runTest_OCMAndController() {
    val args = makeTestArgs("OCMAndController")
    val p = new OCMParameters(1024, 32, 1, 2, 3)
    p.printParams()
    chiselMainTest(args, () => Module(new OCMFillDump(p))) { c => new TestOCMAndController(c)}
  }
}
