package TidbitsPlatformWrapper

import Chisel._
import TidbitsDMA._
import TidbitsRegFile._

// Wrapper for the Convey Wolverine hardware platform
// (made for WX690T, may work for others)

// TODO implement muxing for memory ports?

trait WX690TParams extends PlatformWrapperParams {
  val platformName = "wx690t"
  val memAddrBits = 48
  val memDataBits = 64
  val memIDBits = 32
  val memMetaBits = 1
  val csrDataBits = 64
  val useAEGforRegFile = 0
}

class WolverinePlatformWrapper(p: WX690TParams,
instFxn: PlatformWrapperParams => GenericAccelerator)
extends PlatformWrapper(p, instFxn) {
  val driverBaseHeader = "wolverineregdriver.h"
  val driverBaseClass = "WolverineRegDriver"
  val driverRegType = "AccelReg"

  // the Convey wrapper itself always expects at least one memory port
  // if no mem ports are desired, we still create one and drive outputs to 0
  val numCalculatedMemPorts = if(p.numMemPorts == 0) 1 else p.numMemPorts

  val io = new ConveyPersonalityVerilogIF(numCalculatedMemPorts, p.memIDBits)
  // rename io signals to be compatible with Verilog template
  io.renameSignals()

  // the base class instantiates:
  // - the accelerator as "accel"
  // - the register file as "regFile"

  io.dispException := UInt(0) // TODO Convey: support exceptions

  if(p.useAEGforRegFile == 1) {
    // use the Convey AEG interface for controlling the register file
    io.dispAegCnt := UInt(numRegs)
    io.dispRtnValid := regFile.extIF.readData.valid
    io.dispRtnData := regFile.extIF.readData.bits
    regFile.extIF.cmd.bits.regID := io.dispRegID
    regFile.extIF.cmd.bits.read := io.dispRegRead
    regFile.extIF.cmd.bits.write := io.dispRegWrite
    regFile.extIF.cmd.bits.writeData := io.dispRegWrData
    regFile.extIF.cmd.valid := io.dispRegRead || io.dispRegWrite
    // plug the CSR IF
    io.csrReadAck := Bool(false)
    io.csrReadData := UInt(0)
    println("====> RegFile is using the Convey AEG interface")
  } else {
    // use the Convey CSR interface for controlling the register file
    // use a single, constant register for the AEGs
    io.dispAegCnt := UInt(1)
    io.dispRtnValid := Reg(next = io.dispRegRead)
    io.dispRtnData := UInt("hdeadbeef")

    // use Convey CSR interface to talk to our regfile
    regFile.extIF.cmd.bits.regID := io.csrAddr
    regFile.extIF.cmd.bits.read := io.csrRdValid
    regFile.extIF.cmd.bits.write := io.csrWrValid
    regFile.extIF.cmd.bits.writeData := io.csrWrData
    regFile.extIF.cmd.valid := io.csrRdValid || io.csrWrValid
    io.csrReadAck := regFile.extIF.readData.valid
    io.csrReadData := regFile.extIF.readData.bits
    println("====> RegFile is using the Convey CSR interface, remember to enable the CSR agent")
  }

  // for now, our Convey wrapper accepts a single instructions, then never
  // returns (just keeps idle low and stall high)
  // TODO add a platform-level register to control this
  val regBusy = Reg(init = Bool(false))
  when (!regBusy) {regBusy := io.dispInstValid}
  io.dispIdle := !regBusy
  io.dispStall := regBusy

  io.mcReqValid := UInt(0)
  io.mcReqRtnCtl := UInt(0)
  io.mcReqData := UInt(0)
  io.mcReqAddr := UInt(0)
  io.mcReqSize := UInt(0)
  io.mcReqCmd := UInt(0)
  io.mcReqSCmd := UInt(0)
  io.mcResStall := UInt(0)
  io.mcReqFlush := UInt(0)

  // wire up memory port adapters
  // TODO also enable the write channels -- use simplex generic channel
  // TODO use adapter modules instead of manual adapting
  // TODO add support for write flush
  if (p.numMemPorts != 0) {
    // Convey's interface semantics (stall-valid) are a bit more different than
    // just a decoupled (inverted ready)-valid:
    // X1) valid and stall asserted together can still mean a transferred element
    //     (i.e valid may not go down for up to 2 cycles after stall is asserted)
    // X2) valid on Convey IF must actually go down after stall is asserted

    def mpHelper(extr: GenericMemoryMasterPort => Bits): Bits = {
      Cat(accel.memPort.map(extr).reverse)
    }
    type mp = GenericMemoryMasterPort

    io.mcReqRtnCtl := mpHelper({mp => mp.memRdReq.bits.channelID})
    io.mcReqAddr := mpHelper({mp => mp.memRdReq.bits.addr})

    // TODO only full words for now -- also support sub-word writes/reads
    if(p.memDataBits != 64) {
      throw new Exception("Convey wrapper only supports 64-bit data for now")}

    io.mcReqSize := Fill(UInt(log2Up(p.memDataBits/8)), p.numMemPorts)

    // TODO more rigorous check for burst sizes?
    // TODO write will change command here
    def cmdMux(x: UInt): UInt = {Mux(x === UInt(64), UInt(7), UInt(1))}
    io.mcReqCmd := mpHelper({mp => cmdMux(mp.memRdReq.bits.numBytes)})
    io.mcReqSCmd := UInt(0) // TODO add support for atomics?

    // memory response handling:
    // compensate for interface semantics mismatch for memory responses (X1) with
    // little queues
    // - personality receives responses through queue
    // - Convey mem.port's stall is driven by "almost full" from queue
    // TODO generalize this idea into an interface adapter + use for reqs too
    val respQueElems = 8
    val respQueues = Vec.fill(p.numMemPorts) {
      Module(
          new Queue(new ConveyMemResponse(p.memIDBits, p.memDataBits), respQueElems)
        ).io
    }

    // an "almost full" derived from the queue count is used
    // to drive the Convey mem resp port's stall input
    // this is quite conservative (stall when FIFO is half full) but
    // it seems to work (there may be a deeper problem here)
    val respStall = Cat(respQueues.map(x => (x.count >= UInt(respQueElems/2))))
    // Cat concatenation order needs to be reversed
    io.mcResStall := Reverse(respStall)

    // drive personality inputs
    for(i <- 0 until p.numMemPorts) {
      respQueues(i).enq.valid := io.mcResValid(i)
      respQueues(i).enq.bits.rtnCtl := io.mcResRtnCtl(32*(i+1)-1, 32*i)
      respQueues(i).enq.bits.readData := io.mcResData(64*(i+1)-1, 64*i)
      respQueues(i).enq.bits.cmd := io.mcResCmd(3*(i+1)-1, 3*i)
      respQueues(i).enq.bits.scmd := io.mcResSCmd(4*(i+1)-1, 4*i)
      // note that we don't use the enq.ready signal from the queue --
      // we generate our own variant of ready when half-full

      // personality receives responses from the queue, through an adapter
      val rspAdp = Module(new ConveyMemRspAdp(p.toMemReqParams())).io
      accel.memPort(i).memRdRsp <> rspAdp.genericRspOut
      rspAdp.conveyRspIn <> respQueues(i).deq

      accel.memPort(i).memRdReq.ready := ~io.mcReqStall(i)
    }

    // to compensate for X2, we AND the valid with the inverse of stall before
    // outputting valid
    // TODO do not create potential combinational loop -- make queue-based sln
    io.mcReqValid := mpHelper({mp => mp.memRdReq.valid & mp.memRdReq.ready})
  }

  // print some warnings to remind the user to change the cae_pers.v values
  println(s"====> Remember to set NUM_MC_PORTS=$numCalculatedMemPorts in cae_pers.v")
  val numRtnCtlBits = p.memIDBits
  println(s"====> Remember to set RTNCTL_WIDTH=$numRtnCtlBits in cae_pers.v")
}



// various interface definitions for Convey systems

// dispatch slave interface
// for accepting instructions and AEG register operations
class DispatchSlaveIF() extends Bundle {
  // instruction opcode
  // note that this interface is defined as stall-valid instead of ready-valid
  // by Convey, so the ready signal should be inverted from stall
  val instr       = Decoupled(UInt(width = 5)).flip
  // register file access
  val aeg         = new RegFileSlaveIF(18, 64)
  // output for signalling instruction exceptions
  val exception   = UInt(OUTPUT, width = 16)

  override def clone = { new DispatchSlaveIF().asInstanceOf[this.type] }
}

// command (request) bundle for memory read/writes
class ConveyMemRequest(rtnCtlBits: Int, addrBits: Int, dataBits: Int) extends Bundle {
  val rtnCtl      = UInt(width = rtnCtlBits)
  val writeData   = UInt(width = dataBits)
  val addr        = UInt(width = addrBits)
  val size        = UInt(width = 2)
  val cmd         = UInt(width = 3)
  val scmd        = UInt(width = 4)

  override def clone = {
    new ConveyMemRequest(rtnCtlBits, addrBits, dataBits).asInstanceOf[this.type] }
}

// response bundle for return read data or write completes (?)
class ConveyMemResponse(rtnCtlBits: Int, dataBits: Int) extends Bundle {
  val rtnCtl      = UInt(width = rtnCtlBits)
  val readData    = UInt(width = dataBits)
  val cmd         = UInt(width = 3)
  val scmd        = UInt(width = 4)

  override def clone = {
    new ConveyMemResponse(rtnCtlBits, dataBits).asInstanceOf[this.type] }
}

// memory port master interface
class ConveyMemMasterIF(rtnCtlBits: Int) extends Bundle {
  // note that req and rsp are defined by Convey as stall/valid interfaces
  // (instead of ready/valid as defined here) -- needs adapter
  val req         = Decoupled(new ConveyMemRequest(rtnCtlBits, 48, 64))
  val rsp         = Decoupled(new ConveyMemResponse(rtnCtlBits, 64)).flip
  val flushReq    = Bool(OUTPUT)
  val flushOK     = Bool(INPUT)

  override def clone = {
    new ConveyMemMasterIF(rtnCtlBits).asInstanceOf[this.type] }
}

class ConveyGenericMemAdapter(p: MemReqParams) extends Bundle {
  val io = new Bundle {
    val genericMem = new GenericMemoryMasterPort(p)
    val conveyMem = new ConveyMemMasterIF(32)
  }

  val muxer = Module(new SimplexAdapter(p)).io
  io.genericMem <> muxer.duplex

  val reqadp = Module(new ConveyMemReqAdp(p, 1, {x: UInt => x})).io
  muxer.simplex.req <> reqadp.genericReqIn
  muxer.simplex.wrdat <> reqadp.writeData(0)
  reqadp.conveyReqOut <> io.conveyMem.req

  val rspadp = Module(new ConveyMemRspAdp(p)).io
  io.conveyMem.rsp <> rspadp.conveyRspIn
  rspadp.genericRspOut <> muxer.simplex.rsp

  // TODO enable flush requests from generic interface somehow?
  io.conveyMem.flushReq := Bool(false)
}


// interface for a Convey personality (for use in Chisel)
class ConveyPersonalityIF(numMemPorts: Int, rtnCtlBits: Int) extends Bundle {
  val disp = new DispatchSlaveIF()
  val csr  = new RegFileSlaveIF(16, 64)
  val mem  = Vec.fill(numMemPorts) { new ConveyMemMasterIF(rtnCtlBits) }

  override def clone = {
    new ConveyPersonalityIF(numMemPorts, rtnCtlBits).asInstanceOf[this.type] }
}

// interface definition for the Convey WX690T (Verilog) personality IF
// this is instantiated inside the cae_pers.v file (remember to set the
// correct number of memory ports and RTNCTL_WIDTH in the cae_pers.v)
class ConveyPersonalityVerilogIF(numMemPorts: Int, rtnctl: Int) extends Bundle {
  // dispatch interface
  val dispInstValid = Bool(INPUT)
  val dispInstData  = UInt(INPUT, width = 5)
  val dispRegID     = UInt(INPUT, width = 18)
  val dispRegRead   = Bool(INPUT)
  val dispRegWrite  = Bool(INPUT)
  val dispRegWrData = UInt(INPUT, width = 64)
  val dispAegCnt    = UInt(OUTPUT, width = 18)
  val dispException = UInt(OUTPUT, width = 16)
  val dispIdle      = Bool(OUTPUT)
  val dispRtnValid  = Bool(OUTPUT)
  val dispRtnData   = UInt(OUTPUT, width = 64)
  val dispStall     = Bool(OUTPUT)
  // memory controller interface
  // request
  val mcReqValid    = UInt(OUTPUT, width = numMemPorts)
  val mcReqRtnCtl   = UInt(OUTPUT, width = rtnctl*numMemPorts)
  val mcReqData     = UInt(OUTPUT, width = 64*numMemPorts)
  val mcReqAddr     = UInt(OUTPUT, width = 48*numMemPorts)
  val mcReqSize     = UInt(OUTPUT, width = 2*numMemPorts)
  val mcReqCmd      = UInt(OUTPUT, width = 3*numMemPorts)
  val mcReqSCmd     = UInt(OUTPUT, width = 4*numMemPorts)
  val mcReqStall    = UInt(INPUT, width = numMemPorts)
  // response
  val mcResValid    = UInt(INPUT, width = numMemPorts)
  val mcResCmd      = UInt(INPUT, width = 3*numMemPorts)
  val mcResSCmd     = UInt(INPUT, width = 4*numMemPorts)
  val mcResData     = UInt(INPUT, width = 64*numMemPorts)
  val mcResRtnCtl   = UInt(INPUT, width = rtnctl*numMemPorts)
  val mcResStall    = UInt(OUTPUT, width = numMemPorts)
  // flush
  val mcReqFlush    = UInt(OUTPUT, width = numMemPorts)
  val mcResFlushOK  = UInt(INPUT, width = numMemPorts)
  // control-status register interface
  val csrWrValid      = Bool(INPUT)
  val csrRdValid      = Bool(INPUT)
  val csrAddr         = UInt(INPUT, 16)
  val csrWrData       = UInt(INPUT, 64)
  val csrReadAck      = Bool(OUTPUT)
  val csrReadData     = UInt(OUTPUT, 64)
  // misc -- IDs for each AE
  val aeid            = UInt(INPUT, 4)

  override def clone = {
    new ConveyPersonalityVerilogIF(numMemPorts, rtnctl).asInstanceOf[this.type] }

  // rename signals to remain compatible with Verilog template
  def renameSignals() {
    dispInstValid.setName("disp_inst_vld")
    dispInstData.setName("disp_inst")
    dispRegID.setName("disp_aeg_idx")
    dispRegRead.setName("disp_aeg_rd")
    dispRegWrite.setName("disp_aeg_wr")
    dispRegWrData.setName("disp_aeg_wr_data")
    dispAegCnt.setName("disp_aeg_cnt")
    dispException.setName("disp_exception")
    dispIdle.setName("disp_idle")
    dispRtnValid.setName("disp_rtn_data_vld")
    dispRtnData.setName("disp_rtn_data")
    dispStall.setName("disp_stall")
    mcReqValid.setName("mc_rq_vld")
    mcReqRtnCtl.setName("mc_rq_rtnctl")
    mcReqData.setName("mc_rq_data")
    mcReqAddr.setName("mc_rq_vadr")
    mcReqSize.setName("mc_rq_size")
    mcReqCmd.setName("mc_rq_cmd")
    mcReqSCmd.setName("mc_rq_scmd")
    mcReqStall.setName("mc_rq_stall")
    mcResValid.setName("mc_rs_vld")
    mcResCmd.setName("mc_rs_cmd")
    mcResSCmd.setName("mc_rs_scmd")
    mcResData.setName("mc_rs_data")
    mcResRtnCtl.setName("mc_rs_rtnctl")
    mcResStall.setName("mc_rs_stall")
    mcReqFlush.setName("mc_rq_flush")
    mcResFlushOK.setName("mc_rs_flush_cmplt")
    csrWrValid.setName("csr_wr_vld")
    csrRdValid.setName("csr_rd_vld")
    csrAddr.setName("csr_address")
    csrWrData.setName("csr_wr_data")
    csrReadAck.setName("csr_rd_ack")
    csrReadData.setName("csr_rd_data")
    aeid.setName("i_aeid")
  }
}


class ConveyMemReqAdp(p: MemReqParams, numWriteChans: Int, routeFxn: UInt => UInt) extends Module {
  val io = new Bundle {
    val genericReqIn = Decoupled(new GenericMemoryRequest(p)).flip
    val conveyReqOut = Decoupled(new ConveyMemRequest(p.idWidth, p.addrWidth, p.dataWidth))
    val writeData = Vec.fill(numWriteChans) {Decoupled(UInt(width = p.dataWidth)).flip}
  }
  if(p.dataWidth != 64) {
    throw new Exception("ConveyMemReqAdp requires p.dataWidth=64")
  }
  // default outputs
  io.genericReqIn.ready := Bool(false)
  io.conveyReqOut.valid := Bool(false)
  io.conveyReqOut.bits.rtnCtl := io.genericReqIn.bits.channelID
  io.conveyReqOut.bits.writeData := UInt(0)
  io.conveyReqOut.bits.addr := io.genericReqIn.bits.addr
  io.conveyReqOut.bits.size := UInt( log2Up(p.dataWidth/8) )
  // TODO scmd needs to be set for write bursts
  io.conveyReqOut.bits.scmd := UInt(0)
  io.conveyReqOut.bits.cmd := UInt(0)

  // plug write data ready signals
  for(i <- 0 until numWriteChans) {
    io.writeData(i).ready := Bool(false)
  }
  // write must have both request and data ready
  val src = routeFxn(io.genericReqIn.bits.channelID)
  val validWrite = io.genericReqIn.valid & io.writeData(src).valid

  when (validWrite && io.genericReqIn.bits.isWrite) {
    // write request
    // both request and associated channel data are valid
    io.conveyReqOut.valid := Bool(true)
    // both request and associated channel data must be ready
    io.genericReqIn.ready := io.conveyReqOut.ready
    io.writeData(src).ready := io.conveyReqOut.ready
  } .elsewhen (io.genericReqIn.valid && !io.genericReqIn.bits.isWrite) {
    // read request
    io.conveyReqOut.valid := Bool(true)
    io.genericReqIn.ready := io.conveyReqOut.ready
  }
  // command according to burst length and r/w flag
  when (io.genericReqIn.bits.numBytes === UInt(64)) {
    io.conveyReqOut.bits.cmd := Mux(io.genericReqIn.bits.isWrite, UInt(6), UInt(7))
  } .elsewhen (io.genericReqIn.bits.numBytes === UInt(8)) {
    io.conveyReqOut.bits.cmd := Mux(io.genericReqIn.bits.isWrite, UInt(2), UInt(1))
  }
}

class ConveyMemRspAdp(p: MemReqParams) extends Module {
  val io = new Bundle {
    val conveyRspIn = Decoupled(new ConveyMemResponse(32, 64)).flip
    val genericRspOut = Decoupled(new GenericMemoryResponse(p))
  }

  io.conveyRspIn.ready := io.genericRspOut.ready
  io.genericRspOut.valid := io.conveyRspIn.valid

  io.genericRspOut.bits.channelID := io.conveyRspIn.bits.rtnCtl
  io.genericRspOut.bits.readData := io.conveyRspIn.bits.readData
  // TODO carry cmd and scmd here
  io.genericRspOut.bits.metaData := UInt(0)
}
