package ConveyInterfaces

import Chisel._
import fpgatidbits.dma._
import fpgatidbits.regfile._

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
