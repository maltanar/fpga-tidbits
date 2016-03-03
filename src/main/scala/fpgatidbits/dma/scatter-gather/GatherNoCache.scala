package fpgatidbits.dma

import Chisel._
import fpgatidbits.ocm._

// a gather accelerator that services the reads directly from the memory
// system, without caching any data

class GatherNoCache(
  chanBaseID: Int,        // base channel ID for memory system
  outstandingTxns: Int,   // number of outstanding memory transactions
  forceInOrder: Boolean,  // use a ReadOrderCache to guarantee in-order resps
  indWidth: Int,
  datWidth: Int,
  tagWidth: Int,
  mrp: MemReqParams
) extends Module {
  val io = new GatherIF(indWidth, datWidth, tagWidth, mrp) {
    // req - rsp interface for memory reads
    val memRdReq = Decoupled(new GenericMemoryRequest(mrp))
    val memRdRsp = Decoupled(new GenericMemoryResponse(mrp)).flip
  }
  // the user-defined tags in the requests and the internal tags used for IDing
  // requests are separate. we keep the user-defined tags in a cloakroom until
  // the request is ready to be served.
  // define types for internal requests and responses:
  class InternalReq extends CloakroomBundle(outstandingTxns) {
    val ind = UInt(width = indWidth)
    override def cloneType: this.type =
      new InternalReq().asInstanceOf[this.type]
  }
  class InternalRsp extends CloakroomBundle(outstandingTxns) {
    val dat = UInt(width = datWidth)
    override def cloneType: this.type =
      new InternalRsp().asInstanceOf[this.type]
  }
  val ireq = new InternalReq()
  val irsp = new InternalRsp()
  val bytesPerVal = UInt(datWidth/8)

  /* TODO IMPROVEMENT: add support for subword-sized gather*/
  if(mrp.dataWidth != datWidth)
    throw new Exception("Subword gathers not yet supported in GatherNoCache")

  // ==========================================================================
  // the cloakroom - push/pop entering/exiting user-defined tags
  def undressFxn(ext: GatherReq): InternalReq = {
    val int = new InternalReq()
    int.ind := ext.ind
    int
  }

  def dressFxn(extIn: GatherReq, int: InternalRsp): GatherRsp = {
    val extOut = io.out.bits.cloneType
    extOut.dat := int.dat
    extOut.tag := extIn.tag
    extOut
  }

  val cloakroom = Module(new CloakroomLUTRAM(
    num = outstandingTxns, genA = io.in.bits.cloneType, undress = undressFxn,
    genC = irsp, dress = dressFxn
  )).io

  io.in <> cloakroom.extIn
  val readyReqs = FPGAQueue(cloakroom.intOut, 2)
  val readyRspQ = Module(new FPGAQueue(cloakroom.intIn.bits, 2)).io
  readyRspQ.deq <> cloakroom.intIn
  val readyRsps = readyRspQ.enq
  cloakroom.extOut <> io.out

  // ==========================================================================
  // instantiate read order cache, if desired
  val roc = Module(new ReadOrderCache(new ReadOrderCacheParams(
    mrp = mrp, maxBurst = 1, outstandingReqs = outstandingTxns,
    chanIDBase = chanBaseID
  ))).io
  // mostly here as a Chisel bug workaround: in case the read order cache is
  // instantiated but not connected, the generated Verilog will have a syntax
  // error (due to the comma following the reset port, and nothing else coming
  // afterwards)
  roc.doInit := Bool(false)

  if(forceInOrder) {
    roc.reqMem <> io.memRdReq
    io.memRdRsp <> roc.rspMem
  }

  // ==========================================================================
  // push ready-to-go requests to external memory
  val memreq = if(forceInOrder) roc.reqOrdered else io.memRdReq

  memreq.valid := readyReqs.valid
  readyReqs.ready := memreq.ready

  // offset internal cloakroom ID with the desired channel base ID
  memreq.bits.channelID := readyReqs.bits.id + UInt(chanBaseID)
  memreq.bits.isWrite := Bool(false)
  // calculate address of desired element
  memreq.bits.addr := io.base + bytesPerVal * readyReqs.bits.ind
  memreq.bits.numBytes := bytesPerVal
  memreq.bits.metaData := UInt(0)

  // ==========================================================================
  // accept responses from external memory
  val memrsp = if(forceInOrder) roc.rspOrdered else io.memRdRsp

  readyRsps.valid := memrsp.valid
  memrsp.ready := readyRsps.ready

  readyRsps.bits.id := memrsp.bits.channelID - UInt(chanBaseID)
  readyRsps.bits.dat := memrsp.bits.readData

}
