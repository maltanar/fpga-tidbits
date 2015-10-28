/*
PlatformWrapper serves as the base class for creating a wrapper for a certain
FPGA platform. This wrapper connects the particular interfaces and services
provided by the platform to the generic control/status and memory interfaces
expected by GenericAccelerator.
*/

package TidbitsPlatformWrapper

import Chisel._
import TidbitsDMA._
import TidbitsRegFile._
import scala.collection.mutable.LinkedHashMap

// TODO need cleaner separation of accel and platform parameters, also a way
// of dynamically instantiating and combining these to e.g command-line
// parametrize creation: makeVerilogWrapper("wx690t", "my-accelerator")

// parameters for the platform
trait PlatformWrapperParams {
  def numMemPorts: Int
  def platformName: String
  def memAddrBits: Int
  def memDataBits: Int
  def memIDBits: Int
  def memMetaBits: Int
  val csrDataBits: Int = 32 // TODO let platforms configure own CSR width

  def toMemReqParams(): MemReqParams = {
    new MemReqParams(memAddrBits, memDataBits, memIDBits, memMetaBits)
  }
}

// actual wrappers must derive from this class and implement the following:
// - define the io Bundle for the platform
// - connect the platform mem ports to the GenericAccelerator mem ports
// - do reads/writes to the regfile from the platform memory-mapped interface
abstract class PlatformWrapper
(val p: PlatformWrapperParams,
val instFxn: PlatformWrapperParams => GenericAccelerator)
extends Module {
  type RegFileMap = LinkedHashMap[String, Int]

  // instantiate the accelerators
  val accel = Module(instFxn(p))

  val fullName: String = accel.getClass.getSimpleName+p.platformName
  setName(fullName)

  // separate out the mem port signals, won't map the to the regfile
  val ownFilter = {x: (String, Bits) => !(x._1.startsWith("memPort"))}
  val ownIO = accel.io.flatten.filter(ownFilter)

  val bigIOFilter = {x: (String, Bits) => (x._2.getWidth() > p.csrDataBits)}
  val numBigIOs = ownIO.filter(bigIOFilter).size
  // TODO for now, each i/o is one register in the regfile
  val numRegs = ownIO.size

  // instantiate the register file
  val regAddrBits = log2Up(numRegs)
  val regFile = Module(new RegFile(numRegs, regAddrBits, p.csrDataBits)).io

  println("Generating register file mappings...")
  // traverse the accel I/Os and connect to the register file
  var allocReg = 0
  var regFileMap = new RegFileMap
  for((name, bits) <- ownIO) {
    // TODO add support for wide signals
    if(bits.getWidth() > p.csrDataBits) {
      throw new Exception("GenericAccelerator I/O " + name + " is too wide")
    }
    regFileMap(name) = allocReg
    // connect the I/O signal to the register file appropriately
    if(bits.dir == INPUT) {
      // handle Bool input cases,"multi-bit signal to Bool" error
      if(bits.getWidth() == 1) {
        bits := regFile.regOut(allocReg)(0)
      } else { bits := regFile.regOut(allocReg) }
      // disable internal write for this register
      regFile.regIn(allocReg).valid := Bool(false)

    } else if(bits.dir == OUTPUT) {
      // TODO don't always write (change detect?)
      regFile.regIn(allocReg).valid := Bool(true)
      regFile.regIn(allocReg).bits := bits
    } else { throw new Exception("Wire in IO: "+name) }

    println("Signal " + name + " mapped to reg " + allocReg.toString)

    allocReg += 1
  }

  def makeRegReadFxn(regName: String): String = {
    var fxnStr: String = ""
    fxnStr += "  AccelReg get_" + regName + "()"
    fxnStr += " {return readReg(" + regFileMap(regName).toString + ");} "
    return fxnStr
  }

  def makeRegWriteFxn(regName: String): String = {
    var fxnStr: String = ""
    fxnStr += "  void set_" + regName + "(AccelReg value)"
    fxnStr += " {writeReg(" + regFileMap(regName).toString + ", value);} "
    return fxnStr
  }

  def generateRegDriver(targetDir: String) = {
    var driverStr: String = ""
    val driverName: String = accel.getClass.getSimpleName
    driverStr += ("#ifndef " + driverName + "_H") + "\n"
    driverStr += ("#define " + driverName + "_H") + "\n"
    driverStr += "#include \"wrapperregdriver.h\"\n\n"
    driverStr += "class " + driverName + " {\n"
    driverStr += "public:" + "\n"
    driverStr += driverName + "(WrapperRegDriver * platform) {" + "\n"
    driverStr += "m_platform = platform; attach();}\n"
    driverStr += "~" + driverName + "() {detach();}\n\n"
    for((name, bits) <- ownIO) {
      if(bits.dir == INPUT) {
        driverStr += makeRegWriteFxn(name) + "\n"
      } else if(bits.dir == OUTPUT) {
        driverStr += makeRegReadFxn(name) + "\n"
      }
    }
    driverStr += "\nprotected: " + "\n"
    driverStr += "WrapperRegDriver * m_platform;" + "\n"
    driverStr += "AccelReg readReg(unsigned int i) {return m_platform->readReg(i);}\n"
    driverStr += "void writeReg(unsigned int i, AccelReg v) {\n"
    driverStr += "m_platform->writeReg(i,v);}\n"
    driverStr += "void attach() {m_platform->attach(\"" + driverName + "\");}\n"
    driverStr += "void detach() {m_platform->detach();}\n"

    driverStr += "};\n"
    driverStr += ("#endif") + "\n"

    import java.io._
    val writer = new PrintWriter(new File(targetDir+"/"+driverName+".hpp" ))
    writer.write(driverStr)
    writer.close()
    println("=======> Driver written to "+driverName+".hpp")
  }
}
