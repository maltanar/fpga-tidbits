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
  def accelName: String
  def memAddrBits: Int
  def memDataBits: Int
  def memIDBits: Int
  def memMetaBits: Int
  def csrDataBits: Int

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
  val fullName: String = p.accelName+p.platformName
  setName(fullName)

  type RegFileMap = LinkedHashMap[String, Int]

  // instantiate the accelerators
  val accel = Module(instFxn(p)).io
  // separate out the mem port signals, won't map the to the regfile
  val ownFilter = {x: (String, Bits) => !(x._1.startsWith("memPort"))}
  val ownIO = accel.flatten.filter(ownFilter)
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

  def driverBaseHeader: String
  def driverBaseClass: String
  def driverConstructor: String
  def driverRegType: String

  def makeRegReadFxn(regName: String): String = {
    var fxnStr: String = ""
    fxnStr += "  " + driverRegType + " get_" + regName + "()"
    fxnStr += " {return readReg(" + regFileMap(regName).toString + ");} "
    return fxnStr
  }

  def makeRegWriteFxn(regName: String): String = {
    var fxnStr: String = ""
    fxnStr += "  void set_" + regName + "(" + driverRegType +" value)"
    fxnStr += " {writeReg(" + regFileMap(regName).toString + ", value);} "
    return fxnStr
  }

  def generateRegDriver(targetDir: String) = {
    var driverStr: String = ""
    val driverName: String = fullName
    driverStr += ("#ifndef " + driverName + "_H") + "\n"
    driverStr += ("#define " + driverName + "_H") + "\n"
    driverStr += "#include \""+driverBaseHeader + "\"\n"
    driverStr += "class " + driverName + ": public " + driverBaseClass + " {\n"
    driverStr += "public:" + "\n"
    driverStr += driverConstructor + "\n"
    for((name, bits) <- ownIO) {
      if(bits.dir == INPUT) {
        driverStr += makeRegWriteFxn(name) + "\n"
      } else if(bits.dir == OUTPUT) {
        driverStr += makeRegReadFxn(name) + "\n"
      }
    }
    driverStr += "};\n"
    driverStr += ("#endif") + "\n"

    import java.io._
    val writer = new PrintWriter(new File(targetDir+"/"+driverName+".hpp" ))
    writer.write(driverStr)
    writer.close()
    println("=======> Driver written to "+driverName+".hpp")
  }
}
