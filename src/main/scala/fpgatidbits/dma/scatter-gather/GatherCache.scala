package fpgatidbits.dma

import Chisel._

import TidbitsDMA._
import TidbitsStreams._
import TidbitsOCM._

// nonblocking (cache will "set aside" misses and keep servicing up to a point)
// the misses are put in a queue, and a ReadOrderCache is used to ensure that
// they are serviced in-order. however, the cache responses won't be in-order
// since this is still a nonblocking cache (e.g. hit behind miss will be
// serviced first)

class GatherNBCache_InOrderMissHandling(
  lines: Int,
  nbMisses: Int,
  elemsPerLine: Int,
  pipelinedStorage: Int,
  chanBaseID: Int,
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
  if(elemsPerLine != 1)
    throw new Exception("Non-unit-sized cache not yet supported")
  if(mrp.dataWidth != datWidth)
    throw new Exception("Subword gathers not yet supported in GatherNoCache")
  // should support a large enough # of outstanding transactions so that we can
  // keep the cache busy at all times and get good utilization.
  // the +4 here is somewhat arbitrary, but vaguely represents the hit latency.
  val outstandingTxns = nbMisses + 4

  val cacheLineNumBits = log2Up(lines)
  val cacheTagBits = indWidth - cacheLineNumBits
  def cacheLine(ind: UInt): UInt = {ind(cacheLineNumBits-1, 0)}
  def cacheTag(ind: UInt): UInt = {ind(indWidth-1, cacheLineNumBits)}
  /* TODO IMPROVEMENT add support for wide cachelines by defining offset bits */

  // the user-defined tags in the requests and the internal tags used for IDing
  // requests are separate. we keep the user-defined tags in a cloakroom until
  // the request is ready to be served.
  // define types for internal requests and responses:
  class InternalReq extends CloakroomBundle(outstandingTxns) {
    val cacheLine = UInt(width = cacheLineNumBits)
    val cacheTag = UInt(width = cacheTagBits)
    override def cloneType: this.type =
      new InternalReq().asInstanceOf[this.type]
  }
  class InternalTagRsp extends InternalReq {
    val isHit = Bool()
    val dat = UInt(width = datWidth)
    override def cloneType: this.type =
      new InternalTagRsp().asInstanceOf[this.type]
  }
  class InternalRsp extends CloakroomBundle(outstandingTxns) {
    val dat = UInt(width = datWidth)
    override def cloneType: this.type =
      new InternalRsp().asInstanceOf[this.type]
  }
  val ireq = new InternalReq()
  val itagrsp = new InternalTagRsp()
  val irsp = new InternalRsp()
  val bytesPerVal = UInt(datWidth/8)

  // ==========================================================================
  // the cloakroom - push/pop entering/exiting user-defined tags
  def undressFxn(ext: GatherReq): InternalReq = {
    val int = new InternalReq()
    int.cacheLine := cacheLine(ext.ind)
    int.cacheTag := cacheTag(ext.ind)
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
  // instantiate various components for the cache
  val storeLatency = 1 + pipelinedStorage
  val tagStore = Module(new PipelinedDualPortBRAM(
    addrBits = cacheLineNumBits, dataBits = 1 + cacheTagBits,
    regIn = 0, regOut = pipelinedStorage
  )).io
  val tagRd = tagStore.ports(0)
  val tagWr = tagStore.ports(1)
  tagRd.req.writeEn := Bool(false)
  tagRd.req.writeData := UInt(0)
  tagWr.req.writeEn := Bool(false)
  val datStore = Module(new PipelinedDualPortBRAM(
    addrBits = cacheLineNumBits, dataBits = datWidth,
    regIn = 0, regOut = pipelinedStorage
  )).io
  val datRd = datStore.ports(0)
  val datWr = datStore.ports(1)
  datRd.req.writeEn := Bool(false)
  datRd.req.writeData := UInt(0)
  datWr.req.writeEn := Bool(false)

  // various queues that hold intermediate results
  val tagRspQ = Module(new FPGAQueue(itagrsp, 2 + storeLatency)).io
  val hitQ = Module(new FPGAQueue(irsp, 2)).io
  val missQ = Module(new FPGAQueue(ireq, 2)).io
  val pendingQ = Module(new FPGAQueue(ireq, nbMisses)).io
  val handledQ = Module(new FPGAQueue(itagrsp, 2)).io

  // read order cache, critical to handling misses in-order
  val roc = Module(new ReadOrderCacheBRAM(new ReadOrderCacheParams(
    mrp = mrp, maxBurst = 1, outstandingReqs = nbMisses,
    chanIDBase = chanBaseID
  ))).io

  roc.reqMem <> io.memRdReq
  io.memRdRsp <> roc.rspMem

  // ==========================================================================
  // initialize tags (all lines invalid) on reset, using the tagRd port
  val regInitActive = Reg(init = Bool(true))
  val regTagInitAddr = Reg(init = UInt(0, 1+cacheLineNumBits))


  when(regInitActive) {
    tagRd.req.addr := regTagInitAddr
    tagRd.req.writeEn := Bool(true)
    regTagInitAddr := regTagInitAddr + UInt(1)
    when(regTagInitAddr === UInt(lines-1)) { regInitActive := Bool(false)}
  }

  // ==========================================================================
  // wire up tag and data read and write to tag responses
  // handshaking across latency: readyReqs -> [tag & data read] -> tagRspQ
  // also need to check whether tag init after reset is finished
  val lineConflict = tagWr.req.writeEn & (tagWr.req.addr === tagRd.req.addr)
  val canDoTagRsp = (tagRspQ.count < UInt(2)) & !regInitActive & !lineConflict
  val doHandleReq = canDoTagRsp & readyReqs.valid
  val origReq = ShiftRegister(readyReqs.bits, storeLatency)
  val tagMatch = tagRd.rsp.readData(cacheTagBits-1, 0) === origReq.cacheTag
  val tagValid = tagRd.rsp.readData(cacheTagBits)
  readyReqs.ready := canDoTagRsp

  tagRd.req.addr := readyReqs.bits.cacheLine
  datRd.req.addr := readyReqs.bits.cacheLine

  tagRspQ.enq.valid := ShiftRegister(doHandleReq, storeLatency)
  origReq <> tagRspQ.enq.bits
  tagRspQ.enq.bits.dat := datRd.rsp.readData
  tagRspQ.enq.bits.isHit := tagMatch & tagValid

  // tag responses either go into hitQ or missQ
  val tagRspRoute = Module(new DecoupledOutputDemux(itagrsp, 2)).io
  tagRspRoute.sel := tagRspRoute.in.bits.isHit
  tagRspQ.deq <> tagRspRoute.in
  tagRspRoute.out(0) <> missQ.enq
  tagRspRoute.out(1) <> hitQ.enq

  /* TODO add bypass logic / prevent simultaneous read-write to same loc */

  // =========================================================================
  // miss handling
  // issue requests for misses, place copy in pendingQ
  val missFork = Module(new StreamFork(ireq, ireq, ireq,
    {x: InternalReq => x}, {x: InternalReq => x}
  )).io
  missQ.deq <> missFork.in
  missFork.outA <> pendingQ.enq
  roc.reqOrdered.valid := missFork.outB.valid
  val fullInd = Cat(missFork.outB.bits.cacheTag, missFork.outB.bits.cacheLine)
  roc.reqOrdered.bits.addr := io.base + bytesPerVal * fullInd
  roc.reqOrdered.bits.numBytes := bytesPerVal
  missFork.outB.ready := roc.reqOrdered.ready

  // join mem responses and pending misses, emit response to handledQ
  def makeResp(a: InternalReq, b: GenericMemoryResponse): InternalRsp = {
    val theRsp = new InternalRsp()
    theRsp.id := a.id
    theRsp.dat := b.readData
    theRsp
  }

  StreamJoin(
    inA = pendingQ.deq, inB = roc.rspOrdered, genO = irsp, join = makeResp
  ) <> handledQ.enq

  // update tag and data when miss is handled
  tagWr.req.addr := pendingQ.deq.bits.cacheLine
  tagWr.req.writeData := Cat(Bool(true), pendingQ.deq.bits.cacheTag)
  datWr.req.addr := pendingQ.deq.bits.cacheLine
  datWr.req.writeData := roc.rspOrdered.bits.readData
  when(handledQ.enq.fire()) {
    tagWr.req.writeEn := Bool(true)
    datWr.req.writeEn := Bool(true)
  }

  // =========================================================================
  // join up handledQ and hitQ into readyRsps
  val resultMix = Module(new RRArbiter(irsp, 2)).io
  hitQ.deq <> resultMix.in(0)
  handledQ.deq <> resultMix.in(1)
  resultMix.out <> readyRsps

  // =========================================================================
  // debug
  StreamMonitor(readyReqs, Bool(true), "readyReqs", true)
  StreamMonitor(tagRspQ.enq, Bool(true), "tagRspQ.enq", true)
  StreamMonitor(hitQ.enq, Bool(true), "hitQ.enq", true)
  StreamMonitor(missQ.enq, Bool(true), "missQ.enq", true)
  StreamMonitor(pendingQ.enq, Bool(true), "pendingQ.enq", true)
  StreamMonitor(handledQ.enq, Bool(true), "handledQ.enq", true)
  StreamMonitor(readyRsps, Bool(true), "readyRsps", true)

  StreamMonitor(io.memRdReq, Bool(true), "memRdReq", true)
  StreamMonitor(io.memRdRsp, Bool(true), "memRdRsp", true)
}
