/*
PlatformWrapper serves as the base class for creating a wrapper for a certain
FPGA platform. This wrapper connects the particular interfaces and services
provided by the platform to the generic control/status and memory interfaces
expected by GenericAccelerator.
*/

package fpgatidbits.PlatformWrapper

import Chisel._
import fpgatidbits.dma._
import fpgatidbits.regfile._
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
  def coherentMem: Boolean
  val csrDataBits: Int = 32 // TODO let platforms configure own CSR width

  def toMemReqParams(): MemReqParams = {
    new MemReqParams(memAddrBits, memDataBits, memIDBits, memMetaBits, sameIDInOrder)
  }

  // the values below are useful for characterizing memory system performance,
  // for instance, when deciding how many outstanding txns are needed to hide
  // the memory latency for a big, sequential stream of data
  // TODO latency in cycles depends on clock freq, should use ns and specify fclk
  def typicalMemLatencyCycles: Int
  // TODO expose a list of supported burst sizes instead of a single preferred one
  def burstBeats: Int
  def seqStreamTxns(): Int = { typicalMemLatencyCycles / burstBeats }
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

  // a list of files that will be needed for compiling drivers for platform
  val baseDriverFiles: Array[String] = Array[String](
    "platform.h", "wrapperregdriver.h"
  )
  def platformDriverFiles: Array[String]  // additional files

  // instantiate the accelerator
  val regWrapperReset = Reg(init = Bool(false), clock = Driver.implicitClock)
  val accel = Module(instFxn(p))
  // permits controlling the accelerator's reset from both the wrapper's reset,
  // and by using a special register file command (see hack further down :)
  accel.reset := reset | regWrapperReset

  val fullName: String = accel.getClass.getSimpleName+p.platformName
  setName(fullName)

  // separate out the mem port signals, won't map the to the regfile
  val ownFilter = {x: (String, Bits) => !(x._1.startsWith("memPort"))}

  import scala.collection.immutable.ListMap
  val ownIO = ListMap(accel.io.flatten.filter(ownFilter).toSeq.sortBy(_._1):_*)

  // each I/O is assigned to at least one register index, possibly more if wide
  // round each I/O width to nearest csrWidth multiple, sum, divide by csrWidth
  val wCSR = p.csrDataBits
  def roundMultiple(n: Int, m: Int) = { (n + m-1) / m * m}
  val fxn = {x: (String, Bits) => (roundMultiple(x._2.getWidth(), wCSR))}
  val numRegs = ownIO.map(fxn).reduce({_+_}) / wCSR

  // instantiate the register file
  val regAddrBits = log2Up(numRegs)
  val regFile = Module(new RegFile(numRegs, regAddrBits, wCSR)).io

  // hack: detect writes to register 0 to control accelerator reset
  val rfcmd = regFile.extIF.cmd
  when(rfcmd.valid & rfcmd.bits.write & rfcmd.bits.regID === UInt(0)) {
    regWrapperReset := rfcmd.bits.writeData(0)
  }

  println("Generating register file mappings...")
  // traverse the accel I/Os and connect to the register file
  var regFileMap = new RegFileMap
  var allocReg = 0
  // hand-place the signature register at 0
  regFileMap("signature") = Array(allocReg)
  regFile.regIn(allocReg).valid := Bool(true)
  regFile.regIn(allocReg).bits := ownIO("signature")
  println("Signal signature mapped to single reg " + allocReg.toString)
  allocReg += 1

  for((name, bits) <- ownIO) {
    if(name != "signature") {
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
            val ubound = math.min(i*wCSR+wCSR-1, w-1)
            regFile.regIn(allocReg + i).bits := bits(ubound, i*wCSR)
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
    } else {
      println(s"$regName is split across more than 2 regs, read manually")
    }

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
    } else {
      println(s"$regName is split across more than 2 regs, write manually")
      var r_ind: Int = 0
      for(r <- regs) {
        // single register write
        fxnStr += "  void set_" + regName + s"$r_ind(AccelReg value)"
        fxnStr += " {writeReg(" + r.toString + ", value);}\n"
        r_ind += 1
      }
    }

    return fxnStr
  }

  def generateRegDriver(targetDir: String) = {
    var driverStr: String = ""
    val driverName: String = accel.name
    val expected_signature: String = accel.hexSignature()
    var readWriteFxns: String = ""
    for((name, bits) <- ownIO) {
      if(bits.dir == INPUT) {
        readWriteFxns += makeRegWriteFxn(name) + "\n"
      } else if(bits.dir == OUTPUT) {
        readWriteFxns += makeRegReadFxn(name) + "\n"
      }
    }

    def statRegToCPPMapEntry(regName: String): String = {
      val inds = regFileMap(regName).map(_.toString).reduce(_ + ", " + _)
      return s""" {"$regName", {$inds}} """
    }
    val statRegs = ownIO.filter(x => x._2.dir == OUTPUT).map(_._1)
    val statRegMap = statRegs.map(statRegToCPPMapEntry).reduce(_ + ", " + _)

    var hlsBlackBoxTemplateDefines = ""
    if(accel.hlsBlackBoxes.size != 0) {
      hlsBlackBoxTemplateDefines = accel.hlsBlackBoxes.map(_.generateTemplateDefines()).reduce(_ + "\n" + _)
    }

    driverStr += s"""
#ifndef ${driverName}_H
#define ${driverName}_H
#include "wrapperregdriver.h"
#include <map>
#include <string>
#include <vector>

// template parameters used for instantiating TemplatedHLSBlackBoxes, if any:
${hlsBlackBoxTemplateDefines}

using namespace std;
class $driverName {
public:
  $driverName(WrapperRegDriver * platform) {
    m_platform = platform;
    attach();
    if(readReg(0) != 0x${expected_signature})  {
      throw "Unexpected accelerator signature, is the correct bitfile loaded?";
    }
  }
  ~$driverName() {
    detach();
  }

  $readWriteFxns

  map<string, vector<unsigned int>> getStatusRegs() {
    map<string, vector<unsigned int>> ret = {$statRegMap};
    return ret;
  }

  AccelReg readStatusReg(string regName) {
    map<string, vector<unsigned int>> statRegMap = getStatusRegs();
    if(statRegMap[regName].size() != 1) throw ">32 bit status regs are not yet supported from readStatusReg";
    return readReg(statRegMap[regName][0]);
  }

protected:
  WrapperRegDriver * m_platform;
  AccelReg readReg(unsigned int i) {return m_platform->readReg(i);}
  void writeReg(unsigned int i, AccelReg v) {m_platform->writeReg(i,v);}
  void attach() {m_platform->attach("$driverName");}
  void detach() {m_platform->detach();}
};
#endif
    """

    import java.io._
    val writer = new PrintWriter(new File(targetDir+"/"+driverName+".hpp" ))
    writer.write(driverStr)
    writer.close()
    println("=======> Driver written to "+driverName+".hpp")
  }
}
