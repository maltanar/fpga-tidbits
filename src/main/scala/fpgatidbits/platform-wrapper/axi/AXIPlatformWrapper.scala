package fpgatidbits.PlatformWrapper

import chisel3._
import chisel3.util._
import fpgatidbits.dma._
import fpgatidbits.regfile._
import fpgatidbits.axi._
import fpgatidbits.ocm._

// wrapper for AXI platforms

abstract class AXIPlatformWrapper(p: PlatformWrapperParams,
                                  instFxn: PlatformWrapperParams => GenericAccelerator)
  extends PlatformWrapper(p, instFxn) {

  val csr = Wire(new AXILiteSlaveIF(p.memAddrBits, p.csrDataBits))
  val mem = Wire(Vec(p.numMemPorts, new AXIMasterIF(p.memAddrBits, p.memDataBits, p.memIDBits)))

  // add the actual external interfaces with the correct naming
  val extMemIf = VecInit(Seq.tabulate(p.numMemPorts) {idx => IO(new AXIExternalIF(p.memAddrBits, p.memDataBits, p.memIDBits)).suggestName(s"mem${idx}")})
  val extCsrIf = IO(Flipped(new AXILiteExternalIF(p.memAddrBits, p.csrDataBits))).suggestName("csr")

  // Make the connections between the external and internal AXI interface
  for ((extIf, intIf) <- extMemIf zip mem ) {
    extIf.connect(intIf)
  }
  extCsrIf.connect(csr)



    // memory port adapters and connections
  // TODO use accel numMemPorts and plug unused
  for(i <- 0 until accel.numMemPorts) {
    // instantiate AXI request and response adapters for the mem interface
    val mrp = p.toMemReqParams()
    // read requests
    val readReqAdp = Module(new AXIMemReqAdp(mrp)).io
    readReqAdp.genericReqIn <> accel.io.memPort(i).memRdReq
    readReqAdp.axiReqOut <> mem(i).readAddr
    // read responses
    val readRspAdp = Module(new AXIReadRspAdp(mrp)).io
    readRspAdp.axiReadRspIn <> mem(i).readData
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
    writeBurstAdp.in_writeData.bits.strb := ~0.U((p.memDataBits/8).W)
    // burst adapter will set this appropriately
    writeBurstAdp.in_writeData.bits.last := false.B
    writeBurstAdp.in_writeData.valid := accel.io.memPort(i).memWrDat.valid
    accel.io.memPort(i).memWrDat.ready := writeBurstAdp.in_writeData.ready
    writeBurstAdp.out_writeAddr <> mem(i).writeAddr
    // add a small write data queue to ensure we can provide both req ready and
    // data ready at the same time (otherwise this is up to the AXI slave)
    FPGAQueue(writeBurstAdp.out_writeData, 2) <> mem(i).writeData
    // write responses
    val writeRspAdp = Module(new AXIWriteRspAdp(mrp)).io
    writeRspAdp.axiWriteRspIn <> mem(i).writeResp
    writeRspAdp.genericRspOut <> accel.io.memPort(i).memWrRsp
  }

  // the accelerator may be using fewer memory ports than what the platform
  // exposes; plug the unused ones
  for(i <- accel.numMemPorts until p.numMemPorts) {
    println("Plugging unused memory port " + i.toString)
    mem(i).driveDefaults()
  }

  // AXI regfile read/write logic
  // slow and clumsy, but ctrl/status is not supposed to be performance-
  // critical anyway

  csr.writeAddr.ready := false.B
  csr.writeData.ready := false.B
  csr.writeResp.valid := false.B
  csr.writeResp.bits := 0.U
  csr.readAddr.ready := false.B
  csr.readData.valid := false.B
  csr.readData.bits.data := regFile.extIF.readData.bits
  csr.readData.bits.resp := 0.U

  regFile.extIF.cmd.valid := false.B
  regFile.extIF.cmd.bits.driveDefaults()

  val sRead :: sReadRsp :: sWrite :: sWriteD :: sWriteRsp :: Nil = Enum(5)
  val regState = RegInit(sRead)
  val regModeWrite = RegInit(false.B)
  val regRdReq = RegInit(false.B)
  val regRdAddr = RegInit(0.U(p.memAddrBits.W))
  val regWrReq = RegInit(false.B)
  val regWrAddr = RegInit(0.U(p.memAddrBits.W))
  val regWrData = RegInit(0.U(p.csrDataBits.W))
  // AXI typically uses byte addressing, whereas regFile indices are
  // element indices -- so the AXI addr needs to be divided by #bytes
  // in one element to get the regFile ind
  // Note that this permits reading/writing only the entire width of one
  // register
  val addrDiv = (p.csrDataBits/8).U

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
      csr.readAddr.ready := true.B

      when(csr.readAddr.valid) {
        regRdReq := true.B
        regRdAddr := csr.readAddr.bits.addr
        regModeWrite := false.B
        regState := sReadRsp
      }.otherwise {
        regState := sWrite
      }
    }

    is(sReadRsp) {
      println("sReadRsp")
      csr.readData.valid := regFile.extIF.readData.valid
      when (csr.readData.ready & regFile.extIF.readData.valid) {
        regState := sWrite
        regRdReq := false.B
      }
    }

    is(sWrite) {
      csr.writeAddr.ready := true.B

      when(csr.writeAddr.valid) {
        regModeWrite := true.B
        regWrReq := false.B // need to wait until data is here
        regWrAddr := csr.writeAddr.bits.addr
        regState := sWriteD
      } .otherwise {
        regState := sRead
      }
    }

    is(sWriteD) {
      csr.writeData.ready := true.B
      when(csr.writeData.valid) {
        regWrData := csr.writeData.bits.data
        regWrReq := true.B // now we can set the request
        regState := sWriteRsp
      }
    }

    is(sWriteRsp) {
      csr.writeResp.valid := true.B
      when(csr.writeResp.ready) {
        regWrReq := false.B
        regState := sRead
      }
    }
  }
}
