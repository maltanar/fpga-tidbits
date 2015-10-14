package TidbitsPlatformWrapper

import Chisel._
import TidbitsDMA._
import scala.collection.mutable.LinkedHashMap

// TODO should the parameters for GenericAccelerator be separated from the
// parameters for PlatformWrapper?

// interface definition for GenericAccelerator
class GenericAcceleratorIF(p: PlatformWrapperParams) extends Bundle {
  // register in-outs for control and status
  // valid on regOut implies register write
  val regIn = Vec.fill(p.numRegs) { UInt(INPUT, width = p.csrDataBits) }
  val regOut = Vec.fill(p.numRegs) { Valid(UInt(width = p.csrDataBits)) }
  // memory ports
  val memPort = Vec.fill(p.numMemPorts) {new GenericMemoryMasterPort(p.toMemReqParams())}
  // basic control and status
  val start = Bool(INPUT)
  val idle = Bool(OUTPUT)
}

// GenericAccelerator, serving as a base class for creating portable accelerators
// support managing the accelerator I/O as control-status registers and generating
// a register map driver for talking to the accelerator from software
class GenericAccelerator(val p: PlatformWrapperParams) extends Module {
  val io = new GenericAcceleratorIF(p)

  // human-readable accelerator version string
  lazy val accelVersion: String = "1.0.0"
  // 4-byte signature for accelerator (in hex string format)
  lazy val accelSignature: String = makeSignature()
  // name-to-index mapping for registers
  lazy val regMap = LinkedHashMap[String, Int]()

  // TODO refactor WrappableAccelTester and re-enable
  /*
  // module-defined tests
  def defaultTest(t: WrappableAccelTester): Boolean = {
    t.expectReg("signature", UInt("h" + accelSignature).litValue())
  }
  */

  // build a signature for this class
  def makeSignature() = {
    var signBase:String = this.getClass.getSimpleName
    signBase = signBase + "-" + accelVersion
    import java.util.zip.CRC32
    val crc=new CRC32
    crc.update(signBase.getBytes)
    crc.getValue.toHexString
  }

  // a call to this (optional) function and you won't have to
  // manage your register maps by hand anymore!
  // just define the inB and outB types as Bundles with what
  // your accelerator needs -- the function will allocate register
  // indices, wire the bundles to the register file, and generate
  // a C++ header for manipulating the regs
  def manageRegIO(inB: => Bundle, outB: => Bundle): LinkedHashMap[String, Int] = {
    val regW = p.csrDataBits
    var regs: Int = 0
    // use reg 0 for signature
    io.regOut(0).bits := UInt("h" + accelSignature)
    io.regOut(0).valid := Bool(true)
    regs += 1
    // output registers (outputs from accelerator)
    var outputInds = LinkedHashMap[String, Int]()
    val (rN, oB) = bundleToInds(outB, regs)
    regs = rN
    outputInds = oB
    for((n,d) <- outB.flatten) {
      val i = outputInds(n)
      io.regOut(i).bits := d
      io.regOut(i).valid := Bool(true) // TODO don't always write
    }
    // input registers (inputs to accelerator)
    var inputInds = LinkedHashMap[String, Int]()
    val (rNN, oI) = bundleToInds(inB, regs)
    regs = rNN
    inputInds = oI
    for((n,d) <- inB.flatten) {
      val i = inputInds(n)
      if(d.getWidth() < regW) {
        // avoid "multi-bit signal to Bool" error
        d := io.regIn(i)(d.getWidth()-1, 0)
      } else {d := io.regIn(i)}
    }
    outputInds("signature") = 0

    return inputInds++outputInds
  }

  // TODO add support for defining custom register accesser fxns, so we can
  // e.g. generate drivers for accessing Convey regs too
  def buildDriver(targetDir: String) = {
    var driverStr: String = ""
    val driverName: String = this.getClass.getSimpleName + "Driver"
    driverStr = driverStr + ("#ifndef " + driverName + "_H")
    driverStr = driverStr + "\n" + ("#define " + driverName + "_H")
    driverStr = driverStr + "\n" + ("#include <assert.h>")
    driverStr = driverStr + "\n" + ("class " + driverName + " {")
    driverStr = driverStr + "\n" + ("public:")
    driverStr = driverStr + "\n" + (f" static unsigned int expSignature() {return 0x$accelSignature%s;};")
    driverStr = driverStr + "\n" + (" " + driverName + "(volatile unsigned int * baseAddr) {")
    driverStr = driverStr + "\n" + ("  m_baseAddr = baseAddr; assert(signature() == expSignature());};")

    for((n: String, i: Int) <- regMap) {
      driverStr = driverStr + "\n" + (f" // read+write register: $n%s index: $i%s")
      driverStr = driverStr + "\n" + (f" void $n%s(unsigned int v) {m_baseAddr[$i%d] = v;};")
      driverStr = driverStr + "\n" + (f" unsigned int $n%s() {return m_baseAddr[$i%d];};")
    }

    driverStr = driverStr + "\n\n" + ("protected:")
    driverStr = driverStr + "\n" + (" volatile unsigned int * m_baseAddr;")
    driverStr = driverStr + "\n" + ("};")
    driverStr = driverStr + "\n" + ("#endif") + "\n"
    import java.io._
    val writer = new PrintWriter(new File(targetDir+"/"+driverName+".hpp" ))
    writer.write(driverStr)
    writer.close()
    println("=======> Driver written to "+driverName+".hpp")
  }

  // traverse elements in a Bundle and assign an index to each
  // returns (<number of indices used>, <the name->index map>)
  // TODO pack smaller width elems into single register
  def bundleToInds(inB: Bundle, iStart: Int):(Int, LinkedHashMap[String, Int]) = {
    val regW = p.csrDataBits
    val e = inB.flatten
    var res = LinkedHashMap[String, Int]()
    var upperInd: Int = iStart

    for((n,d) <- e) {
      if(d.getWidth() > regW) {
        println("BundleToRegInds does not yet support wide Bundle elems")
        System.exit(-1)
      }
      res(n) = upperInd
      upperInd += 1
    }
    (upperInd, res)
  }

  // drive default values for output registers
  def plugRegOuts() {
    for(i <- 0 until p.numRegs) {
      io.regOut(i).valid := Bool(false)
      io.regOut(i).bits := UInt(0)
    }
  }

  // drive default values for memory read ports
  def plugMemReadPorts() {
    for(i <- 0 until p.numMemPorts) {
      io.memPort(i).memRdReq.valid := Bool(false)
      io.memPort(i).memRdReq.bits.driveDefaults()
      io.memPort(i).memRdRsp.ready := Bool(false)
    }
  }
  // drive default values for memory write ports
  def plugMemWritePorts() {
    for(i <- 0 until p.numMemPorts) {
      io.memPort(i).memWrReq.valid := Bool(false)
      io.memPort(i).memWrReq.bits.driveDefaults()
      io.memPort(i).memWrDat.valid := Bool(false)
      io.memPort(i).memWrDat.bits := UInt(0)
      io.memPort(i).memWrRsp.ready := Bool(false)
    }
  }

  override def clone = { new GenericAccelerator(p).asInstanceOf[this.type] }
}
