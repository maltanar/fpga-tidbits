package ConveyInterfaces

import chisel3._
import chisel3.util._
import fpgatidbits.dma._
import fpgatidbits.regfile._

// various interface definitions for Convey systems

// dispatch slave interface
// for accepting instructions and AEG register operations
class DispatchSlaveIF() extends Bundle {
  // instruction opcode
  // note that this interface is defined as stall-valid instead of ready-valid
  // by Convey, so the ready signal should be inverted from stall
  val instr       = Flipped(Decoupled(UInt(5.W)))
  // register file access
  val aeg         = new RegFileSlaveIF(18, 64)
  // output for signalling instruction exceptions
  val exception   = Output(UInt(16.W))

  override def clone = { new DispatchSlaveIF().asInstanceOf[this.type] }
}

// command (request) bundle for memory read/writes
class ConveyMemRequest(rtnCtlBits: Int, addrBits: Int, dataBits: Int) extends Bundle {
  val rtnCtl      = UInt(rtnCtlBits.W)
  val writeData   = UInt(dataBits.W)
  val addr        = UInt(addrBits.W)
  val size        = UInt(2.W)
  val cmd         = UInt(3.W)
  val scmd        = UInt(4.W)

  override def clone = {
    new ConveyMemRequest(rtnCtlBits, addrBits, dataBits).asInstanceOf[this.type] }
}

// response bundle for return read data or write completes (?)
class ConveyMemResponse(rtnCtlBits: Int, dataBits: Int) extends Bundle {
  val readData    = UInt(dataBits.W)
  val rtnCtl      = UInt(rtnCtlBits.W)
  val cmd         = UInt(3.W)
  val scmd        = UInt(4.W)

  override def clone = {
    new ConveyMemResponse(rtnCtlBits, dataBits).asInstanceOf[this.type] }
}

// memory port master interface
class ConveyMemMasterIF(rtnCtlBits: Int) extends Bundle {
  // note that req and rsp are defined by Convey as stall/valid interfaces
  // (instead of ready/valid as defined here) -- needs adapter
  val req         = Decoupled(new ConveyMemRequest(rtnCtlBits, 48, 64))
  val rsp         = Flipped(Decoupled(new ConveyMemResponse(rtnCtlBits, 64)))
  val flushReq    = Output(Bool())
  val flushOK     = Input(Bool())

  override def clone = {
    new ConveyMemMasterIF(rtnCtlBits).asInstanceOf[this.type] }
}

// interface for a Convey personality (for use in Chisel)
class ConveyPersonalityIF(numMemPorts: Int, rtnCtlBits: Int) extends Bundle {
  val disp = new DispatchSlaveIF()
  val csr  = new RegFileSlaveIF(16, 64)
  val mem  = VecInit(Seq.fill(numMemPorts)(new ConveyMemMasterIF(rtnCtlBits)))

  override def clone = {
    new ConveyPersonalityIF(numMemPorts, rtnCtlBits).asInstanceOf[this.type] }
}

// interface definition for the Convey WX690T (Verilog) personality IF
// this is instantiated inside the cae_pers.v file (remember to set the
// correct number of memory ports and RTNCTL_WIDTH in the cae_pers.v)
class ConveyPersonalityVerilogIF(numMemPorts: Int, rtnctl: Int) extends Bundle {
  // dispatch interface
  val dispInstValid = Input(Bool())
  val dispInstData  = Input(UInt(5.W))
  val dispRegID     = Input(UInt(18.W))
  val dispRegRead   = Input(Bool())
  val dispRegWrite  = Input(Bool())
  val dispRegWrData = Input(UInt(64.W))
  val dispAegCnt    = Output(UInt(18.W))
  val dispException = Output(UInt(16.W))
  val dispIdle      = Output(Bool())
  val dispRtnValid  = Output(Bool())
  val dispRtnData   = Output(UInt(64.W))
  val dispStall     = Output(Bool())
  // memory controller interface
  // request
  val mcReqValid    = Output(UInt(numMemPorts.W))
  val mcReqRtnCtl   = Output(UInt((rtnctl*numMemPorts).W))
  val mcReqData     = Output(UInt((64*numMemPorts).W))
  val mcReqAddr     = Output(UInt((48*numMemPorts).W))
  val mcReqSize     = Output(UInt((2*numMemPorts).W))
  val mcReqCmd      = Output(UInt((3*numMemPorts).W))
  val mcReqSCmd     = Output(UInt((4*numMemPorts).W))
  val mcReqStall    = Input(UInt(numMemPorts.W))
  // response
  val mcResValid    = Input(UInt(numMemPorts.W))
  val mcResCmd      = Input(UInt((3*numMemPorts).W))
  val mcResSCmd     = Input(UInt((4*numMemPorts).W))
  val mcResData     = Input(UInt((64*numMemPorts).W))
  val mcResRtnCtl   = Input(UInt((rtnctl*numMemPorts).W))
  val mcResStall    = Output(UInt(numMemPorts.W))
  // flush
  val mcReqFlush    = Output(UInt(numMemPorts.W))
  val mcResFlushOK  = Input(UInt(numMemPorts.W))
  // control-status register interface
  val csrWrValid      = Input(Bool())
  val csrRdValid      = Input(Bool())
  val csrAddr         = Input(UInt(16.W))
  val csrWrData       = Input(UInt(64.W))
  val csrReadAck      = Output(Bool())
  val csrReadData     = Output(UInt(64.W))
  // misc -- IDs for each AE
  val aeid            = Input(UInt(4.W))

  // rename signals to remain compatible with Verilog template
  def renameSignals(): Unit =  {
    dispInstValid.suggestName("disp_inst_vld")
    dispInstData.suggestName("disp_inst")
    dispRegID.suggestName("disp_aeg_idx")
    dispRegRead.suggestName("disp_aeg_rd")
    dispRegWrite.suggestName("disp_aeg_wr")
    dispRegWrData.suggestName("disp_aeg_wr_data")
    dispAegCnt.suggestName("disp_aeg_cnt")
    dispException.suggestName("disp_exception")
    dispIdle.suggestName("disp_idle")
    dispRtnValid.suggestName("disp_rtn_data_vld")
    dispRtnData.suggestName("disp_rtn_data")
    dispStall.suggestName("disp_stall")
    mcReqValid.suggestName("mc_rq_vld")
    mcReqRtnCtl.suggestName("mc_rq_rtnctl")
    mcReqData.suggestName("mc_rq_data")
    mcReqAddr.suggestName("mc_rq_vadr")
    mcReqSize.suggestName("mc_rq_size")
    mcReqCmd.suggestName("mc_rq_cmd")
    mcReqSCmd.suggestName("mc_rq_scmd")
    mcReqStall.suggestName("mc_rq_stall")
    mcResValid.suggestName("mc_rs_vld")
    mcResCmd.suggestName("mc_rs_cmd")
    mcResSCmd.suggestName("mc_rs_scmd")
    mcResData.suggestName("mc_rs_data")
    mcResRtnCtl.suggestName("mc_rs_rtnctl")
    mcResStall.suggestName("mc_rs_stall")
    mcReqFlush.suggestName("mc_rq_flush")
    mcResFlushOK.suggestName("mc_rs_flush_cmplt")
    csrWrValid.suggestName("csr_wr_vld")
    csrRdValid.suggestName("csr_rd_vld")
    csrAddr.suggestName("csr_address")
    csrWrData.suggestName("csr_wr_data")
    csrReadAck.suggestName("csr_rd_ack")
    csrReadData.suggestName("csr_rd_data")
    aeid.suggestName("i_aeid")
  }
}
