package TidbitsSimUtils

import Chisel._
import TidbitsAXI._
import TidbitsDMA._
import TidbitsRegFile._

// testing infrastructure for wrappable accelerators
// provides "main memory" simulation and a convenient way of setting up the
// control/status registers for setting up the accelerator --
// just like how a CPU would in an SoC-like setting


class WrappableAccelHarness(
  val p: AXIAccelWrapperParams,
  fxn: AXIAccelWrapperParams => AXIWrappableAccel,
  memWords: Int) extends Module {
  val rfAddrBits = log2Up(p.numRegs)
  val memAddrBits = log2Up(memWords)
  val memUnitBytes = UInt(p.memDataWidth/8)
  val io = new Bundle {
    // register file access
    val regFileIF = new RegFileSlaveIF(rfAddrBits, p.csrDataWidth)
    // memory access
    val memAddr = UInt(INPUT, p.addrWidth)
    val memWriteEn = Bool(INPUT)
    val memWriteData = UInt(INPUT, p.memDataWidth)
    val memReadData = UInt(OUTPUT, p.memDataWidth)
  }
  val accel = Module(fxn(p))
  val accio = accel.io

  // instantiate regfile
  val regFile = Module(new RegFile(p.numRegs, rfAddrBits, p.csrDataWidth)).io

  // connect regfile to accel ports
  for(i <- 0 until p.numRegs) {
    regFile.regIn(i) <> accel.io.regOut(i)
    accel.io.regIn(i) := regFile.regOut(i)
  }
  // expose regfile interface
  io.regFileIF <> regFile.extIF

  val mem = Mem(UInt(width=p.memDataWidth), memWords)

  // testbench memory access
  def addrToWord(x: UInt) = {x >> UInt(log2Up(p.memDataWidth/8))}
  val memWord = addrToWord(io.memAddr)
  io.memReadData := mem(memWord)

  when (io.memWriteEn) {mem(memWord) := io.memWriteData}

  // accelerator memory access
  // reads
  val sWaitRd :: sRead :: Nil = Enum(UInt(), 2)
  val regStateRead = Reg(init = UInt(sWaitRd))
  val regReadRequest = Reg(init = GenericMemoryRequest(p.toMRP()))

  accio.memRdReq.ready := Bool(false)
  accio.memRdRsp.valid := Bool(false)
  accio.memRdRsp.bits.channelID := regReadRequest.channelID
  accio.memRdRsp.bits.metaData := UInt(0)
  accio.memRdRsp.bits.readData := mem(addrToWord(regReadRequest.addr))

  switch(regStateRead) {
      is(sWaitRd) {
        accio.memRdReq.ready := Bool(true)
        when (accio.memRdReq.valid) {
          regReadRequest := accio.memRdReq.bits
          regStateRead := sRead
        }
      }

      is(sRead) {
        when(regReadRequest.numBytes === UInt(0)) { regStateRead := sWaitRd }
        .otherwise {
          accio.memRdRsp.valid := Bool(true)
          when (accio.memRdRsp.ready) {
            regReadRequest.numBytes := regReadRequest.numBytes - memUnitBytes
            regReadRequest.addr := regReadRequest.addr + UInt(memUnitBytes)
          }
        }
      }
  }
  // TODO writes
}

class WrappableAccelTester(c: WrappableAccelHarness) extends Tester(c) {
  // TODO add functions for initializing memory
  val regFile = c.io.regFileIF
  def nameToRegInd(regName: String): Int = {
    return c.accel.regMap(regName).toInt
  }

  def readReg(regName: String): BigInt = {
    val ind = nameToRegInd(regName)
    poke(regFile.cmd.bits.regID, ind)
    poke(regFile.cmd.bits.read, 1)
    poke(regFile.cmd.bits.write, 0)
    poke(regFile.cmd.bits.writeData, 0)
    poke(regFile.cmd.valid, 1)
    step(1)
    poke(regFile.cmd.valid, 0)
    return peek(regFile.readData.bits)
  }

  def expectReg(regName: String, value: BigInt): Boolean = {
    return expect(readReg(regName)==value, regName)
  }

  def writeReg(regName: String, value: BigInt) = {
    val ind = nameToRegInd(regName)
    poke(regFile.cmd.bits.regID, ind)
    poke(regFile.cmd.bits.read, 0)
    poke(regFile.cmd.bits.write, 1)
    poke(regFile.cmd.bits.writeData, value)
    poke(regFile.cmd.valid, 1)
    step(1)
    poke(regFile.cmd.valid, 0)
  }

  def readMem(addr: BigInt): BigInt = {
    poke(c.io.memAddr, addr)
    return peek(c.io.memReadData)
  }

  def expectMem(addr: BigInt, value: BigInt): Boolean = {
    return expect(readMem(addr) == value, "Mem: "+addr.toString)
  }

  def writeMem(addr: BigInt, value: BigInt) = {
    poke(c.io.memAddr, addr)
    poke(c.io.memWriteEn, 1)
    poke(c.io.memWriteData, value)
    step(1)
    poke(c.io.memWriteEn, 0)
  }

  // let the accelerator do internal init (such as writing to the regfile)
  step(10)
  // launch the default test, as defined by the accelerator
  c.accel.defaultTest(this)
}
