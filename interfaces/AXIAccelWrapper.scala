package TidbitsAXI

import Chisel._
import TidbitsRegFile._
import TidbitsDMA._

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

  override def clone = { new AXIWrappableAccel(p).asInstanceOf[this.type] }
}

// the actual wrapper component
class AXIAccelWrapper(val p: AXIAccelWrapperParams,
                      val instFxn: AXIAccelWrapperParams => AXIWrappableAccel)
                      extends Module {
  val io = new Bundle {
    // AXI slave interface for control-status registers
    val csr = new AXILiteSlaveIF(p.addrWidth, p.csrDataWidth)
    // AXI master interface for reading and writing memory
    val mem = new AXIMasterIF(p.addrWidth, p.memDataWidth, p.idWidth)
  }
  // rename signals to support Vivado interface inference
  io.csr.renameSignals("csr")
  io.mem.renameSignals("mem")

  // instantiate the wrapped accelerator
  val accel = Module(instFxn(p)).io

  // instantiate AXI requets and response adapters for the mem interface
  // read requests
  val readReqAdp = Module(new AXIMemReqAdp(p.toMRP())).io
  readReqAdp.genericReqIn <> accel.memRdReq
  readReqAdp.axiReqOut <> io.mem.readAddr
  // read responses
  val readRspAdp = Module(new AXIReadRspAdp(p.toMRP())).io
  readRspAdp.axiReadRspIn <> io.mem.readData
  readRspAdp.genericRspOut <> accel.memRdRsp
  // write requests
  val writeReqAdp = Module(new AXIMemReqAdp(p.toMRP())).io
  writeReqAdp.genericReqIn <> accel.memWrReq
  writeReqAdp.axiReqOut <> io.mem.writeAddr
  // write data
  // TODO handle this with own adapter?
  io.mem.writeData.bits.data := accel.memWrDat.bits
  io.mem.writeData.bits.strb := ~UInt(0) // TODO forces all bytelanes valid!
  io.mem.writeData.bits.last := Bool(true) // TODO write bursts won't work properly
  io.mem.writeData.valid := accel.memWrDat.valid
  accel.memWrDat.ready := io.mem.writeData.ready
  // write responses
  val writeRspAdp = Module(new AXIWriteRspAdp(p.toMRP())).io
  writeRspAdp.axiWriteRspIn <> io.mem.writeResp
  writeRspAdp.genericRspOut <> accel.memWrRsp

  // instantiate regfile
  val regAddrBits = log2Up(p.numRegs)
  val regFile = Module(new RegFile(p.numRegs, regAddrBits, p.csrDataWidth)).io

  // connect regfile to accel ports
  for(i <- 0 until p.numRegs) {
    regFile.regIn(i) <> accel.regOut(i)
    accel.regIn(i) := regFile.regOut(i)
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
  val regRdAddr = Reg(init=UInt(0, regAddrBits))
  val regWrReq = Reg(init=Bool(false))
  val regWrAddr = Reg(init=UInt(0, regAddrBits))
  val regWrData = Reg(init=UInt(0, p.csrDataWidth))

  when(!regModeWrite) {
    regFile.extIF.cmd.valid := regRdReq
    regFile.extIF.cmd.bits.read := Bool(true)
    regFile.extIF.cmd.bits.regID := regRdAddr
  } .otherwise {
    regFile.extIF.cmd.valid := regWrReq
    regFile.extIF.cmd.bits.write := Bool(true)
    regFile.extIF.cmd.bits.regID := regWrAddr
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
          regWrData := io.csr.writeData.bits
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
