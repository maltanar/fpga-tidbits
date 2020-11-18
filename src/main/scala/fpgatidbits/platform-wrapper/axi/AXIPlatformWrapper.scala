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
    // write burst adapter
    val writeBurstAdp = Module(new AXIWriteBurstReqAdapter(
      p.memAddrBits, p.memDataBits, p.memIDBits
    )).io
    writeReqAdp.axiReqOut <> writeBurstAdp.in_writeAddr
    writeBurstAdp.in_writeData.bits.data := accel.io.memPort(i).memWrDat.bits
    // TODO fix this: forces all writes bytelanes valid!
    writeBurstAdp.in_writeData.bits.strb := ~UInt(0, width=p.memDataBits/8)
    // burst adapter will set this appropriately
    writeBurstAdp.in_writeData.bits.last := false.B
    writeBurstAdp.in_writeData.valid := accel.io.memPort(i).memWrDat.valid
    accel.io.memPort(i).memWrDat.ready := writeBurstAdp.in_writeData.ready
    writeBurstAdp.out_writeAddr <> io.mem(i).writeAddr
    // add a small write data queue to ensure we can provide both req ready and
    // data ready at the same time (otherwise this is up to the AXI slave)
    FPGAQueue(writeBurstAdp.out_writeData, 2) <> io.mem(i).writeData
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

  io.csr.writeAddr.ready := false.B
  io.csr.writeData.ready := false.B
  io.csr.writeResp.valid := false.B
  io.csr.writeResp.bits := 0.U
  io.csr.readAddr.ready := false.B
  io.csr.readData.valid := false.B
  io.csr.readData.bits.data := regFile.extIF.readData.bits
  io.csr.readData.bits.resp := 0.U

  regFile.extIF.cmd.valid := false.B
  regFile.extIF.cmd.bits.driveDefaults()

  val sRead :: sReadRsp :: sWrite :: sWriteD :: sWriteRsp :: Nil = Enum(UInt(), 5)
  val regState = Reg(init = UInt(sRead))

  val regModeWrite = Reg(init=false.B)
  val regRdReq = Reg(init=false.B)
  val regRdAddr = Reg(init=UInt(0, p.memAddrBits))
  val regWrReq = Reg(init=false.B)
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
    regFile.extIF.cmd.bits.read := true.B
    regFile.extIF.cmd.bits.regID := regRdAddr / addrDiv
  } .otherwise {
    regFile.extIF.cmd.valid := regWrReq
    regFile.extIF.cmd.bits.write := true.B
    regFile.extIF.cmd.bits.regID := regWrAddr / addrDiv
    regFile.extIF.cmd.bits.writeData := regWrData
  }

  switch(regState) {
      is(sRead) {
        io.csr.readAddr.ready := true.B

        when(io.csr.readAddr.valid) {
          regRdReq := true.B
          regRdAddr := io.csr.readAddr.bits.addr
          regModeWrite := false.B
          regState := sReadRsp
        }.otherwise {
          regState := sWrite
        }
      }

      is(sReadRsp) {
        io.csr.readData.valid := regFile.extIF.readData.valid
        when (io.csr.readData.ready & regFile.extIF.readData.valid) {
          regState := sWrite
          regRdReq := false.B
        }
      }

      is(sWrite) {
        io.csr.writeAddr.ready := true.B

        when(io.csr.writeAddr.valid) {
          regModeWrite := true.B
          regWrReq := false.B // need to wait until data is here
          regWrAddr := io.csr.writeAddr.bits.addr
          regState := sWriteD
        } .otherwise {
          regState := sRead
        }
      }

      is(sWriteD) {
        io.csr.writeData.ready := true.B
        when(io.csr.writeData.valid) {
          regWrData := io.csr.writeData.bits.data
          regWrReq := true.B // now we can set the request
          regState := sWriteRsp
        }
      }

      is(sWriteRsp) {
        io.csr.writeResp.valid := true.B
        when(io.csr.writeResp.ready) {
          regWrReq := false.B
          regState := sRead
        }
      }
  }
}
