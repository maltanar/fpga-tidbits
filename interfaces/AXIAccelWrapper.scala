package TidbitsAXI

import Chisel._
import TidbitsRegFile._
import TidbitsDMA._
import TidbitsSimUtils._

class AXIAccelWrapperParams(
  val addrWidth: Int,
  val csrDataWidth: Int,
  val memDataWidth: Int,
  val idWidth: Int,
  val numRegs: Int
) {
  def toMRP(): MemReqParams = {
    new MemReqParams(addrWidth, memDataWidth, idWidth, 1, 8)
  }
}

// interface definition for AXI-wrappable accelerator
class AXIWrappableAccelIF(val p: AXIAccelWrapperParams) extends Bundle {
  // register in-outs for control and status
  // valid on regOut implies register write
  val regIn = Vec.fill(p.numRegs) { UInt(INPUT, width = p.csrDataWidth) }
  val regOut = Vec.fill(p.numRegs) { Valid(UInt(width = p.csrDataWidth)) }
  // req - rsp interface for memory reads
  val memRdReq = Decoupled(new GenericMemoryRequest(p.toMRP()))
  val memRdRsp = Decoupled(new GenericMemoryResponse(p.toMRP())).flip
  // req - rsp interface for memory writes
  val memWrReq = Decoupled(new GenericMemoryRequest(p.toMRP()))
  val memWrDat = Decoupled(UInt(width = p.memDataWidth))
  val memWrRsp = Decoupled(new GenericMemoryResponse(p.toMRP())).flip
}

// accelerator to be wrapped must be derived from this class
class AXIWrappableAccel(val p: AXIAccelWrapperParams) extends Module {
  val io = new AXIWrappableAccelIF(p)

  import scala.collection.mutable.LinkedHashMap

  lazy val accelVersion: String = "1.0.0"
  // 4-byte signature for accelerator (in hex string format)
  lazy val accelSignature: String = makeSignature()
  // name-to-index mapping for registers
  lazy val regMap = LinkedHashMap[String, Int]()
  // module-defined tests
  def defaultTest(t: WrappableAccelTester): Boolean = {
    t.expectReg("signature", UInt("h" + accelSignature).litValue())
  }

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
    val regW = p.csrDataWidth
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
    // build driver
    makeRegAccessCode(inputInds, outputInds)
    return inputInds++outputInds
  }

  def makeRegAccessCode(indsIn: LinkedHashMap[String, Int], indsOut: LinkedHashMap[String, Int]) = {
    var driverStr: String = ""
    val driverName: String = this.getClass.getSimpleName + "Driver"
    driverStr = driverStr + ("#ifndef " + driverName + "_H")
    driverStr = driverStr + "\n" + ("#define " + driverName + "_H")
    driverStr = driverStr + "\n" + ("#include <assert.h>")
    driverStr = driverStr + "\n" + ("class " + driverName + " {")
    driverStr = driverStr + "\n" + ("public:")
    driverStr = driverStr + "\n" + (" " + driverName + "(volatile unsigned int * baseAddr) {")
    driverStr = driverStr + "\n" + ("  m_baseAddr = baseAddr; assert(signature() == m_signature);};")
    driverStr = driverStr + "\n\n" + (" // ============== accelerator inputs =================")
    for((n: String, i: Int) <- indsIn) {
      driverStr = driverStr + "\n" + (f" // read+write register: $n%s index: $i%s")
      driverStr = driverStr + "\n" + (f" void $n%s(unsigned int v) {m_baseAddr[$i%d] = v;};")
      driverStr = driverStr + "\n" + (f" unsigned int $n%s() {return m_baseAddr[$i%d];};")
    }
    driverStr = driverStr + "\n\n" + (" // ============== accelerator outputs =================")
    for((n: String, i: Int) <- indsOut) {
      driverStr = driverStr + "\n" + (f" // read-only register: $n%s index: $i%s")
      driverStr = driverStr + "\n" + (f" unsigned int $n%s() {return m_baseAddr[$i%d];};")
    }
    driverStr = driverStr + "\n\n" + ("protected:")
    driverStr = driverStr + "\n" + (" volatile unsigned int * m_baseAddr;")
    driverStr = driverStr + "\n" + (f" const static unsigned int m_signature = 0x$accelSignature%s;")
    driverStr = driverStr + "\n" + ("};")
    driverStr = driverStr + "\n" + ("#endif") + "\n"
    import java.io._
    val writer = new PrintWriter(new File(driverName+".hpp" ))
    writer.write(driverStr)
    writer.close()
    println("=======> Driver written to "+driverName+".hpp")
  }

  // traverse elements in a Bundle and assign an index to each
  // returns (<number of indices used>, <the name->index map>)
  // TODO pack smaller width elems into single register
  def bundleToInds(inB: Bundle, iStart: Int):(Int, LinkedHashMap[String, Int]) = {
    val regW = p.csrDataWidth
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

  def plugRegOuts() {
    for(i <- 0 until p.numRegs) {
      io.regOut(i).valid := Bool(false)
      io.regOut(i).bits := UInt(0)
    }
  }

  def plugMemReadPort() {
    io.memRdReq.valid := Bool(false)
    io.memRdReq.bits.driveDefaults()
    io.memRdRsp.ready := Bool(false)
  }

  def plugMemWritePort() {
    io.memWrReq.valid := Bool(false)
    io.memWrReq.bits.driveDefaults()
    io.memWrDat.valid := Bool(false)
    io.memWrDat.bits := UInt(0)
    io.memWrRsp.ready := Bool(false)
  }

  override def clone = { new AXIWrappableAccel(p).asInstanceOf[this.type] }
}

// the actual wrapper component
class AXIAccelWrapper(val instFxn: () => AXIWrappableAccel)
                      extends Module {
  // instantiate the wrapped accelerator
  val accel = Module(instFxn())
  lazy val p = accel.p
  val io = new Bundle {
    // AXI slave interface for control-status registers
    val csr = new AXILiteSlaveIF(p.addrWidth, p.csrDataWidth)
    // AXI master interface for reading and writing memory
    val mem = new AXIMasterIF(p.addrWidth, p.memDataWidth, p.idWidth)
  }
  // rename signals to support Vivado interface inference
  io.csr.renameSignals("csr")
  io.mem.renameSignals("mem")


  // instantiate AXI requets and response adapters for the mem interface
  // read requests
  val readReqAdp = Module(new AXIMemReqAdp(p.toMRP())).io
  readReqAdp.genericReqIn <> accel.io.memRdReq
  readReqAdp.axiReqOut <> io.mem.readAddr
  // read responses
  val readRspAdp = Module(new AXIReadRspAdp(p.toMRP())).io
  readRspAdp.axiReadRspIn <> io.mem.readData
  readRspAdp.genericRspOut <> accel.io.memRdRsp
  // write requests
  val writeReqAdp = Module(new AXIMemReqAdp(p.toMRP())).io
  writeReqAdp.genericReqIn <> accel.io.memWrReq
  writeReqAdp.axiReqOut <> io.mem.writeAddr
  // write data
  // TODO handle this with own adapter?
  io.mem.writeData.bits.data := accel.io.memWrDat.bits
  io.mem.writeData.bits.strb := ~UInt(0, width=p.memDataWidth/8) // TODO forces all bytelanes valid!
  io.mem.writeData.bits.last := Bool(true) // TODO write bursts won't work properly
  io.mem.writeData.valid := accel.io.memWrDat.valid
  accel.io.memWrDat.ready := io.mem.writeData.ready
  // write responses
  val writeRspAdp = Module(new AXIWriteRspAdp(p.toMRP())).io
  writeRspAdp.axiWriteRspIn <> io.mem.writeResp
  writeRspAdp.genericRspOut <> accel.io.memWrRsp

  // instantiate regfile
  val regAddrBits = log2Up(p.numRegs)
  val regFile = Module(new RegFile(p.numRegs, regAddrBits, p.csrDataWidth)).io

  // connect regfile to accel ports
  for(i <- 0 until p.numRegs) {
    regFile.regIn(i) <> accel.io.regOut(i)
    accel.io.regIn(i) := regFile.regOut(i)
  }

  // AXI regfile read/write logic
  // slow and clumsy, but ctrl/status is not supposed to be performance-
  // critical anyway

  io.csr.writeAddr.ready := Bool(false)
  io.csr.writeData.ready := Bool(false)
  io.csr.writeResp.valid := Bool(false)
  io.csr.writeResp.bits := UInt(0)
  io.csr.readAddr.ready := Bool(false)
  io.csr.readData.valid := Bool(false)
  io.csr.readData.bits.data := regFile.extIF.readData.bits
  io.csr.readData.bits.resp := UInt(0)

  regFile.extIF.cmd.valid := Bool(false)
  regFile.extIF.cmd.bits.driveDefaults()

  val sRead :: sReadRsp :: sWrite :: sWriteD :: sWriteRsp :: Nil = Enum(UInt(), 5)
  val regState = Reg(init = UInt(sRead))

  val regModeWrite = Reg(init=Bool(false))
  val regRdReq = Reg(init=Bool(false))
  val regRdAddr = Reg(init=UInt(0, p.addrWidth))
  val regWrReq = Reg(init=Bool(false))
  val regWrAddr = Reg(init=UInt(0, p.addrWidth))
  val regWrData = Reg(init=UInt(0, p.csrDataWidth))
  // AXI typically uses byte addressing, whereas regFile indices are
  // element indices -- so the AXI addr needs to be divided by #bytes
  // in one element to get the regFile ind
  // Note that this permits reading/writing only the entire width of one
  // register
  val addrDiv = UInt(p.csrDataWidth/8)

  when(!regModeWrite) {
    regFile.extIF.cmd.valid := regRdReq
    regFile.extIF.cmd.bits.read := Bool(true)
    regFile.extIF.cmd.bits.regID := regRdAddr / addrDiv
  } .otherwise {
    regFile.extIF.cmd.valid := regWrReq
    regFile.extIF.cmd.bits.write := Bool(true)
    regFile.extIF.cmd.bits.regID := regWrAddr / addrDiv
    regFile.extIF.cmd.bits.writeData := regWrData
  }


  switch(regState) {
      is(sRead) {
        io.csr.readAddr.ready := Bool(true)

        when(io.csr.readAddr.valid) {
          regRdReq := Bool(true)
          regRdAddr := io.csr.readAddr.bits.addr
          regModeWrite := Bool(false)
          regState := sReadRsp
        }.otherwise {
          regState := sWrite
        }
      }

      is(sReadRsp) {
        io.csr.readData.valid := regFile.extIF.readData.valid
        when (io.csr.readData.ready & regFile.extIF.readData.valid) {
          regState := sWrite
          regRdReq := Bool(false)
        }
      }

      is(sWrite) {
        io.csr.writeAddr.ready := Bool(true)

        when(io.csr.writeAddr.valid) {
          regModeWrite := Bool(true)
          regWrReq := Bool(false) // need to wait until data is here
          regWrAddr := io.csr.writeAddr.bits.addr
          regState := sWriteD
        } .otherwise {
          regState := sRead
        }
      }

      is(sWriteD) {
        io.csr.writeData.ready := Bool(true)
        when(io.csr.writeData.valid) {
          regWrData := io.csr.writeData.bits.data
          regWrReq := Bool(true) // now we can set the request
          regState := sWriteRsp
        }
      }

      is(sWriteRsp) {
        io.csr.writeResp.valid := Bool(true)
        when(io.csr.writeResp.ready) {
          regWrReq := Bool(false)
          regState := sRead
        }
      }
  }


  // TODO add support for parametrized generation of PulseGenerator's
  // TODO add support for remapping the reg inds and generating driver
}
