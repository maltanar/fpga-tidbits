package fpgatidbits.PlatformWrapper

import Chisel._
import fpgatidbits.dma._
import fpgatidbits.regfile._
import fpgatidbits.axi._
import fpgatidbits.ocm._

// wrapper for AXI platforms

abstract class AXIPlatformWrapper(p: PlatformWrapperParams,
  instFxn: PlatformWrapperParams => GenericAccelerator)
  extends PlatformWrapper(p, instFxn) {

  val io = new Bundle {
    // AXI slave interface for control-status registers
    val csr = new AXILiteSlaveIF(p.memAddrBits, p.csrDataBits)
    // AXI master interfaces for reading and writing memory
    val mem = Vec.fill (p.numMemPorts) {
      new AXIMasterIF(p.memAddrBits, p.memDataBits, p.memIDBits)
    }
  }

  // rename signals to support Vivado interface inference
  io.csr.renameSignals("csr")
  for(i <- 0 until p.numMemPorts) {io.mem(i).renameSignals(s"mem$i")}

  // memory port adapters and connections
  // TODO use accel numMemPorts and plug unused
  for(i <- 0 until accel.numMemPorts) {
    // instantiate AXI request and response adapters for the mem interface
    val mrp = p.toMemReqParams()
    // read requests
    val readReqAdp = Module(new AXIMemReqAdp(mrp)).io
    readReqAdp.genericReqIn <> accel.io.memPort(i).memRdReq
    readReqAdp.axiReqOut <> io.mem(i).readAddr
    // read responses
    val readRspAdp = Module(new AXIReadRspAdp(mrp)).io
    readRspAdp.axiReadRspIn <> io.mem(i).readData
    readRspAdp.genericRspOut <> accel.io.memPort(i).memRdRsp
    // write requests
    val writeReqAdp = Module(new AXIMemReqAdp(mrp)).io
    writeReqAdp.genericReqIn <> accel.io.memPort(i).memWrReq
    writeReqAdp.axiReqOut <> io.mem(i).writeAddr
    // write data
    // add a small write data queue to ensure we can provide both req ready and
    // data ready at the same time (otherwise this is up to the AXI slave)
    val wrDataQ = FPGAQueue(accel.io.memPort(i).memWrDat, 2)
    // TODO handle this with own adapter?
    io.mem(i).writeData.bits.data := wrDataQ.bits
    // TODO fix this: forces all writes bytelanes valid!
    io.mem(i).writeData.bits.strb := ~UInt(0, width=p.memDataBits/8)
    // TODO fix this: write bursts won't work properly!
    io.mem(i).writeData.bits.last := Bool(true)
    io.mem(i).writeData.valid := wrDataQ.valid
    wrDataQ.ready := io.mem(i).writeData.ready
    // write responses
    val writeRspAdp = Module(new AXIWriteRspAdp(mrp)).io
    writeRspAdp.axiWriteRspIn <> io.mem(i).writeResp
    writeRspAdp.genericRspOut <> accel.io.memPort(i).memWrRsp
  }

  // the accelerator may be using fewer memory ports than what the platform
  // exposes; plug the unused ones
  for(i <- accel.numMemPorts until p.numMemPorts) {
    println("Plugging unused memory port " + i.toString)
    io.mem(i).driveDefaults()
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
  val regRdAddr = Reg(init=UInt(0, p.memAddrBits))
  val regWrReq = Reg(init=Bool(false))
  val regWrAddr = Reg(init=UInt(0, p.memAddrBits))
  val regWrData = Reg(init=UInt(0, p.csrDataBits))
  // AXI typically uses byte addressing, whereas regFile indices are
  // element indices -- so the AXI addr needs to be divided by #bytes
  // in one element to get the regFile ind
  // Note that this permits reading/writing only the entire width of one
  // register
  val addrDiv = UInt(p.csrDataBits/8)

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
}
