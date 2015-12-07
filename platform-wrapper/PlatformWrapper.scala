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
  def sameIDInOrder: Boolean
  val csrDataBits: Int = 32 // TODO let platforms configure own CSR width

  def toMemReqParams(): MemReqParams = {
    new MemReqParams(memAddrBits, memDataBits, memIDBits, memMetaBits, sameIDInOrder)
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
  type RegFileMap = LinkedHashMap[String, Array[Int]]

  // instantiate the accelerators
  val accel = Module(instFxn(p))

  val fullName: String = accel.getClass.getSimpleName+p.platformName
  setName(fullName)

  // separate out the mem port signals, won't map the to the regfile
  val ownFilter = {x: (String, Bits) => !(x._1.startsWith("memPort"))}
  val ownIO = accel.io.flatten.filter(ownFilter)

  // each I/O is assigned to at least one register index, possibly more if wide
  // round each I/O width to nearest csrWidth multiple, sum, divide by csrWidth
  val wCSR = p.csrDataBits
  def roundMultiple(n: Int, m: Int) = { (n + m-1) / m * m}
  val fxn = {x: (String, Bits) => (roundMultiple(x._2.getWidth(), wCSR))}
  val numRegs = ownIO.map(fxn).reduce({_+_}) / wCSR

  // instantiate the register file
  val regAddrBits = log2Up(numRegs)
  val regFile = Module(new RegFile(numRegs, regAddrBits, wCSR)).io

  println("Generating register file mappings...")
  // traverse the accel I/Os and connect to the register file
  var allocReg = 0
  var regFileMap = new RegFileMap
  for((name, bits) <- ownIO) {
    val w = bits.getWidth()
    if(w > wCSR) {
      // signal is wide, maps to several registers
      val numRegsToAlloc = roundMultiple(w, wCSR) / wCSR
      regFileMap(name) = (allocReg until allocReg + numRegsToAlloc).toArray
      // connect the I/O signal to the register file appropriately
      if(bits.dir == INPUT) {
        // concatanate all assigned registers, connect to input
        bits := regFileMap(name).map(regFile.regOut(_)).reduce(Cat(_,_))
        for(i <- 0 until numRegsToAlloc) {
          regFile.regIn(allocReg + i).valid := Bool(false)
        }
      } else if(bits.dir == OUTPUT) {
        for(i <- 0 until numRegsToAlloc) {
          regFile.regIn(allocReg + i).valid := Bool(true)
          regFile.regIn(allocReg + i).bits := bits(i*wCSR+wCSR-1, i*wCSR)
        }
      } else { throw new Exception("Wire in IO: "+name) }

      println("Signal " + name + " mapped to regs " + regFileMap(name).map(_.toString).reduce(_+" "+_))
      allocReg += numRegsToAlloc
    } else {
      // signal is narrow enough, maps to a single register
      regFileMap(name) = Array(allocReg)
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

      println("Signal " + name + " mapped to single reg " + allocReg.toString)
      allocReg += 1
    }
  }

  def makeRegReadFxn(regName: String): String = {
    var fxnStr: String = ""
    val regs = regFileMap(regName)
    if(regs.size == 1) {
      // single register read
      fxnStr += "  AccelReg get_" + regName + "()"
      fxnStr += " {return readReg(" + regs(0).toString + ");} "
    } else if(regs.size == 2) {
      // two-register read
      // TODO this uses a hardcoded assumption about wCSR=32
      if(wCSR != 32) throw new Exception("Violating assumption on wCSR=32")
      fxnStr += "  AccelDblReg get_" + regName + "() "
      fxnStr += "{ return (AccelDblReg)readReg("+regs(1).toString+") << 32 "
      fxnStr += "| (AccelDblReg)readReg("+regs(0).toString+"); }"
    } else { throw new Exception("Multi-reg reads not yet implemented") }

    return fxnStr
  }

  def makeRegWriteFxn(regName: String): String = {
    var fxnStr: String = ""
    val regs = regFileMap(regName)
    if(regs.size == 1) {
      // single register write
      fxnStr += "  void set_" + regName + "(AccelReg value)"
      fxnStr += " {writeReg(" + regs(0).toString + ", value);} "
    } else if(regs.size == 2) {
      // two-register write
      // TODO this uses a hardcoded assumption about wCSR=32
      if(wCSR != 32) throw new Exception("Violating assumption on wCSR=32")
      fxnStr += "  void set_" + regName + "(AccelDblReg value)"
      fxnStr += " { writeReg("+regs(0).toString+", (AccelReg)(value >> 32)); "
      fxnStr += "writeReg("+regs(1).toString+", (AccelReg)(value & 0xffffffff)); }"
    } else { throw new Exception("Multi-reg writes not yet implemented") }

    return fxnStr
  }

  def generateRegDriver(targetDir: String) = {
    var driverStr: String = ""
    val driverName: String = accel.name
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
