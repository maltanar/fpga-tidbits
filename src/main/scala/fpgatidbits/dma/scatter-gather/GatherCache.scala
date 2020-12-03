package fpgatidbits.dma

import Chisel._

import fpgatidbits.dma._
import fpgatidbits.streams._
import fpgatidbits.ocm._

// nonblocking (cache will "set aside" misses and keep servicing up to a point)
// the misses are put in a queue, and a ReadOrderCache is used to ensure that
// they are serviced in-order. however, the cache responses won't be in-order
// since this is still a nonblocking cache (e.g. hit behind miss will be
// serviced first) -- unless the orderRsps param is set to true, which will
// instantiate a reorder buffer to guarantee in-order responses.

class GatherNBCache_InOrderMissHandling(
  lines: Int,
  nbMisses: Int,
  elemsPerLine: Int,
  pipelinedStorage: Int,
  chanBaseID: Int,
  indWidth: Int,
  datWidth: Int,
  tagWidth: Int,
  mrp: MemReqParams,
  orderRsps: Boolean = false
) extends Module {
  val io = new GatherIF(indWidth, datWidth, tagWidth, mrp) {
    // req - rsp interface for memory reads
    val memRdReq = Decoupled(new GenericMemoryRequest(mrp))
    val memRdRsp = Decoupled(new GenericMemoryResponse(mrp)).flip
  }
  // number of bits&bytes in each cacheline
  val bitsPerLine = elemsPerLine * datWidth
  val bytesPerLine = UInt(bitsPerLine/8)
  // be extra conservative with allowed cacheline sizes for now
  // (either single or 8-beat bursts)
  if(bitsPerLine != mrp.dataWidth && bitsPerLine != 8*mrp.dataWidth)
    throw new Exception("Unsupported cacheline size")
  val burstBeatsPerLine = bitsPerLine / mrp.dataWidth
  // whether the cache needs offset bits at all
  val needOffset = elemsPerLine > 1

  // should support a large enough # of outstanding transactions so that we can
  // keep the cache busy at all times and get good utilization.
  // the +4 here is somewhat arbitrary, but vaguely represents the hit latency.
  val outstandingTxns = nbMisses + 4

  val cacheOffsetBits = if(needOffset) log2Up(elemsPerLine) else 0
  val cacheLineNumBits = log2Up(lines)
  val cacheTagBits = indWidth - (cacheLineNumBits + cacheOffsetBits)
  // breakdown of gather index into cache fields:
  // MSB ===============================LSB
  // tag bits .. line number .. offset bits
  // ======================================
  def cacheOffset(ind: UInt): UInt = {
    ind(cacheOffsetBits-1, 0)
  }
  def cacheLine(ind: UInt): UInt = {
    ind(cacheOffsetBits+cacheLineNumBits-1, cacheOffsetBits)
  }
  def cacheTag(ind: UInt): UInt = {
    ind(indWidth-1, cacheOffsetBits+cacheLineNumBits)
  }
  // the cpp backend doesn't seem to like zero-length signals so we still
  // declare a 1-bit cache offset even when not needed
  // if the cache offset is unneeded it will be unused anyway
  val cacheOffsetBitsAvoidW0W = if(cacheOffsetBits == 0) 1 else cacheOffsetBits

  // the user-defined tags in the requests and the internal tags used for IDing
  // requests are separate. we keep the user-defined tags in a cloakroom until
  // the request is ready to be served.
  // define types for internal requests and responses:
  class InternalReq extends CloakroomBundle(outstandingTxns) {
    val cacheLine = UInt(width = cacheLineNumBits)
    val cacheTag = UInt(width = cacheTagBits)
    val cacheOffset = UInt(width = cacheOffsetBitsAvoidW0W)

    override val printfStr = "req: id = %d line = %d tag = %d ofs = %d\n"
    override val printfElems = {() => Seq(id, cacheLine, cacheTag, cacheOffset)}

    override def cloneType: this.type =
      new InternalReq().asInstanceOf[this.type]
  }
  class InternalTagRsp extends InternalReq {
    val isHit = Bool()
    val dat = UInt(width = bitsPerLine)

    override val printfStr = "req: id = %d linersp: %x\n"
    override val printfElems = {() => Seq(id, dat)}

    override def cloneType: this.type =
      new InternalTagRsp().asInstanceOf[this.type]
  }
  class InternalRsp extends CloakroomBundle(outstandingTxns) {
    val dat = UInt(width = datWidth)

    override val printfStr = "req: id = %d rsp: %x\n"
    override val printfElems = {() => Seq(id, dat)}

    override def cloneType: this.type =
      new InternalRsp().asInstanceOf[this.type]
  }
  val ireq = new InternalReq()
  val itagrsp = new InternalTagRsp()
  val irsp = new InternalRsp()

  // ==========================================================================
  // the cloakroom - push/pop entering/exiting user-defined tags
  def undressFxn(ext: GatherReq): InternalReq = {
    val int = new InternalReq()
    int.cacheLine := cacheLine(ext.ind)
    int.cacheTag := cacheTag(ext.ind)
    if(needOffset) int.cacheOffset := cacheOffset(ext.ind)
    else int.cacheOffset := UInt(0)
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

  if(orderRsps) {
    // use CloakroomOrderBuffer to ensure in-order responses
    // note that the cache itself is still a nonblocking cache and will produce
    // responses out-of-order. the COB acts as a reorder buffer on the output.
    val cob = Module(new CloakroomOrderBuffer(outstandingTxns, irsp)).io
    readyRspQ.deq <> cob.in
    cob.out <> cloakroom.intIn
  } else {
    // emit the responses in the order produced by the cache
    readyRspQ.deq <> cloakroom.intIn
  }

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
    addrBits = cacheLineNumBits, dataBits = bitsPerLine,
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
  val handledQ = Module(new FPGAQueue(irsp, 2)).io

  // read order cache, critical to handling misses in-order
  val roc = Module(new ReadOrderCacheBRAM(new ReadOrderCacheParams(
    mrp = mrp, maxBurst = burstBeatsPerLine, outstandingReqs = nbMisses,
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

  // move only the requested word at the correct offset if applicable
  if(needOffset) {
    val offsMin = UInt(datWidth) * tagRspQ.deq.bits.cacheOffset
    val offsMax = UInt(datWidth) * (UInt(1) + tagRspQ.deq.bits.cacheOffset)
    hitQ.enq.bits.dat := tagRspQ.deq.bits.dat(offsMax-UInt(1), offsMin)
  }

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
  roc.reqOrdered.bits.addr := io.base + bytesPerLine * fullInd
  roc.reqOrdered.bits.numBytes := bytesPerLine
  missFork.outB.ready := roc.reqOrdered.ready

  // join mem responses and pending misses, emit response to handledQ
  def makeResp(a: InternalReq, b: GenericMemoryResponse): InternalRsp = {
    val theRsp = new InternalRsp()
    theRsp.id := a.id
    if(needOffset) {
      // move only the requested word at the correct offset
      val offsMin = UInt(datWidth) * a.cacheOffset
      val offsMax = UInt(datWidth) * (UInt(1) + a.cacheOffset)
      theRsp.dat := b.readData(offsMax-UInt(1), offsMin)
    } else {
      theRsp.dat := b.readData
    }

    theRsp
  }

  if(needOffset) {
    // instantiate a burst upsizer
    // makeResp will take care of selecting the requested word at offset
    val ups = Module(new BurstUpsizer(mrp, bitsPerLine)).io
    roc.rspOrdered <> ups.in
    StreamJoin(
      inA = pendingQ.deq, inB = ups.out, genO = irsp, join = makeResp
    ) <> handledQ.enq
    datWr.req.writeData := ups.out.bits.readData

  } else {
    // returned data is the entire requested data, can return and write into
    // cache as-is
    StreamJoin(
      inA = pendingQ.deq, inB = roc.rspOrdered, genO = irsp, join = makeResp
    ) <> handledQ.enq
    datWr.req.writeData := handledQ.enq.bits.dat
  }

  // update tag and data when miss is handled
  tagWr.req.addr := pendingQ.deq.bits.cacheLine
  tagWr.req.writeData := Cat(Bool(true), pendingQ.deq.bits.cacheTag)
  datWr.req.addr := pendingQ.deq.bits.cacheLine

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
  /*
  val regCnt = Reg(init = UInt(0, 32))
  when(readyReqs.fire()) { regCnt := regCnt + UInt(1)}
  val doMon = (regCnt > UInt(0)) && (regCnt < UInt(5882))
  val doVerboseDebug = false

  StreamMonitor(cloakroom.extIn, doMon, "cloakroom.extIn", doVerboseDebug)
  StreamMonitor(cloakroom.intOut, doMon, "cloakroom.intOut", doVerboseDebug)
  PrintableBundleStreamMonitor(readyReqs, doMon, "readyReqs", doVerboseDebug)
  PrintableBundleStreamMonitor(readyRsps, doMon, "readyRsps", doVerboseDebug)
  StreamMonitor(tagRspQ.enq, doMon, "tagRspQ.enq", doVerboseDebug)
  StreamMonitor(hitQ.enq, doMon, "hitQ.enq", doVerboseDebug)
  StreamMonitor(missQ.enq, doMon, "missQ.enq", doVerboseDebug)
  StreamMonitor(pendingQ.enq, doMon, "pendingQ.enq", doVerboseDebug)
  StreamMonitor(handledQ.enq, doMon, "handledQ.enq", doVerboseDebug)
  */

  /*
  PrintableBundleStreamMonitor(io.memRdRsp, Bool(true), "memRdRsp", true)
  PrintableBundleStreamMonitor(io.memRdReq, Bool(true), "memRdReq", true)
  */
}
