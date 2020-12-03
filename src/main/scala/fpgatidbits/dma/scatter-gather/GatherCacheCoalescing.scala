package fpgatidbits.dma

import Chisel._

import fpgatidbits.dma._
import fpgatidbits.streams._
import fpgatidbits.ocm._

// nonblocking (cache will "set aside" misses and keep servicing up to a point)
// uses a content-associative buffer to "group together" misses to the same
// cacheline, thus saving miss bandwidth

class GatherNBCache_Coalescing(
  lines: Int,
  nbMisses: Int,
  coalescePerLine: Int,
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

    override val printfStr = "req: id = %d hit = %d linersp: %x\n"
    override val printfElems = {() => Seq(id, isHit, dat)}

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
    val offsMax = UInt(datWidth) * (UInt(1) + tagRspQ.deq.bits.cacheOffset) - UInt(1)
    hitQ.enq.bits.dat := tagRspQ.deq.bits.dat(offsMax, offsMin)
  }

  // =========================================================================
  // miss handling

  class CoalescingMissHandlerRsp(maxMissPerLine: Int) extends PrintableBundle {
    val cacheline = UInt(width = bitsPerLine)
    val numMisses = UInt(width = log2Up(maxMissPerLine)+1)
    val misses = Vec.fill(maxMissPerLine){new InternalReq()}

    override val printfStr = "numMisses %d, missed line %d, missed tag %d, cacheline %x \n"
    override val printfElems = {() => Seq(numMisses, misses(0).cacheLine, misses(0).cacheTag, cacheline)}

    override def cloneType: this.type =
      new CoalescingMissHandlerRsp(maxMissPerLine).asInstanceOf[this.type]
  }

  // process a coalesced miss reply and spit out responses to the individual
  // cache misses contained within
  class CoalescedMissRspGen(maxMissPerLine: Int) extends  Module {
    val io = new Bundle {
      val in = Decoupled(new CoalescingMissHandlerRsp(maxMissPerLine)).flip
      val out = Decoupled(new InternalRsp())
    }
    val sIdle :: sProcess :: Nil = Enum(UInt(), 2)
    val regState = Reg(init = UInt(sIdle))
    val regNumLeft = Reg(init = UInt(0, width = log2Up(maxMissPerLine)+1))
    val regCacheline = Reg(init = UInt(0, width = bitsPerLine))
    val regMisses = Vec.fill(maxMissPerLine) {Reg(init = new InternalReq())}

    io.in.ready := Bool(false)
    io.out.valid := Bool(false)

    val currentMiss = regMisses(regNumLeft-UInt(1))
    // copy same-named fields (cloakroom ID info) to handled miss
    io.out.bits := currentMiss

    if(needOffset) {
      // choose appropriate offset from cacheline
      val offsMin = UInt(datWidth) * currentMiss.cacheOffset
      val offsMax = UInt(datWidth) * (UInt(1) + currentMiss.cacheOffset) - UInt(1)
      io.out.bits.dat := regCacheline(offsMax, offsMin)
    } else {
      // line size = word size, copy as-is
      io.out.bits.dat := regCacheline
    }

    switch(regState) {
        is(sIdle) {
          io.in.ready := Bool(true)
          regNumLeft := io.in.bits.numMisses
          regCacheline := io.in.bits.cacheline
          for(i <- 0 until maxMissPerLine) {
            regMisses(i) := io.in.bits.misses(i)
          }
          when(io.in.valid) {
            regState := sProcess
          }
        }

        is(sProcess) {
          when(regNumLeft === UInt(0)) {
            regState := sIdle
          } .otherwise {
            io.out.valid := Bool(true)
            //printf("miss offset: %d \n", currentMiss.cacheOffset)
            //printf("saved cacheline: %x\n", regCacheline)
            //printf("out data: %x \n", io.out.bits.dat)
            // decrement the number of misses left
            when(io.out.ready) {
              regNumLeft := regNumLeft - UInt(1)
            }
          }
        }
    }
  }

  class CoalescingMissHandler(maxMissPerLine: Int) extends Module {
    val io = new Bundle {
      // base memory pointer for loads
      val base = UInt(INPUT, width = mrp.addrWidth)
      // interface towards the cache
      val in = Decoupled(new InternalReq()).flip
      val out = Decoupled(new CoalescingMissHandlerRsp(maxMissPerLine))
      // interface towards the ReadOrderCache for main mem access
      val reqOrdered = Decoupled(new GenericMemoryRequest(mrp))
      val rspOrdered = Decoupled(new GenericMemoryResponse(mrp)).flip
    }
    // content-associative storage for tracking pending cachelines
    val pendingLines = Module(new CAM(nbMisses,  cacheLineNumBits+cacheTagBits)).io
    val regNumMiss = Vec.fill(nbMisses) {Reg(init = UInt(0, width = log2Up(maxMissPerLine)+1))}
    val regTag = Vec.fill(nbMisses) {Reg(init = UInt(0, width = cacheLineNumBits+cacheTagBits))}
    // memory for keeping the pending requests to words
    val memReqs = Vec.fill(nbMisses) { Vec.fill(maxMissPerLine) {Reg(init = new InternalReq())}}
    // internal pool for ID management
    val usedID = Module(new FPGAQueue(UInt(width = log2Up(nbMisses)), nbMisses)).io
    // burst upsizer for getting full cachelines as respnses
    val ups = Module(new BurstUpsizer(mrp, bitsPerLine)).io
    io.rspOrdered <> ups.in

    // default signal values
    usedID.enq.valid := Bool(false)
    usedID.deq.ready := Bool(false)

    pendingLines.clear_hit := Bool(false)
    pendingLines.write := Bool(false)
    val incomingLine = Cat(io.in.bits.cacheTag, io.in.bits.cacheLine)
    pendingLines.write_tag := incomingLine
    pendingLines.tag := incomingLine

    // set up signal values to emit mem request
    io.reqOrdered.valid := Bool(false)
    io.reqOrdered.bits.addr := io.base + bytesPerLine * incomingLine
    io.reqOrdered.bits.numBytes := bytesPerLine

    val newLineID = pendingLines.freeInd
    val foundLineID = PriorityEncoder(pendingLines.hits)
    usedID.enq.bits := newLineID

    val enterAsNew = !pendingLines.hit & pendingLines.hasFree & io.reqOrdered.ready
    val enterAsExisting = pendingLines.hit & (regNumMiss(foundLineID) < UInt(maxMissPerLine))
    io.in.ready := (enterAsNew | enterAsExisting) & !pendingLines.clear_hit

    //printf("## R: %d EN: %d EE: %d B: %d \n", io.in.ready, enterAsNew, enterAsExisting, !pendingLines.clear_hit)
    //printf("%x \n", pendingLines.valid_bits)

    when(io.in.fire()) {
      when(!pendingLines.hit) {
        // new entry
        pendingLines.write := Bool(true)
        usedID.enq.valid := Bool(true)
        // record miss
        regTag(newLineID) := incomingLine
        regNumMiss(newLineID) := UInt(1)
        memReqs(newLineID)(0) := io.in.bits
        // emit memory request
        io.reqOrdered.valid := Bool(true)
      } .otherwise {
        // update old entry with new miss information
        memReqs(foundLineID)(regNumMiss(foundLineID)) := io.in.bits
        regNumMiss(foundLineID) := regNumMiss(foundLineID) + UInt(1)
      }
    }

    // ready to receive main mem resps as long as downstream is ready
    ups.out.ready := io.out.ready
    pendingLines.clear_tag := regTag(usedID.deq.bits)

    // construct coalesced response from received response and memReqs
    io.out.bits.misses := memReqs(usedID.deq.bits)
    io.out.bits.numMisses := regNumMiss(usedID.deq.bits)
    io.out.bits.cacheline := ups.out.bits.readData
    io.out.valid := ups.out.valid

    when(ups.out.fire()) {
      //printf("ups fired, usedID size: %d\n", usedID.count)
      // clear pending line entry
      pendingLines.clear_hit := Bool(true)
      usedID.deq.ready := Bool(true)
    }
  }

  // instantiate the coalescing miss handler components
  val cmh = Module(new CoalescingMissHandler(coalescePerLine)).io
  val cmrg = Module(new CoalescedMissRspGen(coalescePerLine)).io
  // wire up the miss handler components
  cmh.base := io.base
  cmh.reqOrdered <> roc.reqOrdered
  roc.rspOrdered <> cmh.rspOrdered
  missQ.deq <> cmh.in
  FPGAQueue(cmh.out, 2) <> cmrg.in
  cmrg.out <> handledQ.enq

  // update tag and data when handled miss response is available
  tagWr.req.addr := cmh.out.bits.misses(0).cacheLine
  tagWr.req.writeData := Cat(Bool(true), cmh.out.bits.misses(0).cacheTag)
  datWr.req.addr := cmh.out.bits.misses(0).cacheLine
  datWr.req.writeData := cmh.out.bits.cacheline

  when(cmh.out.fire()) {
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

  //val regCnt = Reg(init = UInt(0, 32))
  //when(readyReqs.fire()) { regCnt := regCnt + UInt(1)}
  //val doMon = (regCnt > UInt(0)) && (regCnt < UInt(5882))
  /*
  val doMon = Bool(true)
  val doVerboseDebug = true

  PrintableBundleStreamMonitor(io.in, doMon, "io.in", doVerboseDebug)
  StreamMonitor(cloakroom.extIn, doMon, "cloakroom.extIn", doVerboseDebug)
  StreamMonitor(cloakroom.intOut, doMon, "cloakroom.intOut", doVerboseDebug)
  PrintableBundleStreamMonitor(readyReqs, doMon, "readyReqs", doVerboseDebug)
  PrintableBundleStreamMonitor(tagRspQ.enq, doMon, "tagRspQ.enq", doVerboseDebug)
  StreamMonitor(hitQ.enq, doMon, "hitQ.enq", doVerboseDebug)
  PrintableBundleStreamMonitor(missQ.enq, doMon, "missQ.enq", doVerboseDebug)
  PrintableBundleStreamMonitor(cmh.in, doMon, "cmh.in", doVerboseDebug)
  PrintableBundleStreamMonitor(cmrg.in, doMon, "cmrg.in", doVerboseDebug)
  StreamMonitor(handledQ.enq, doMon, "handledQ.enq", doVerboseDebug)
  PrintableBundleStreamMonitor(readyRsps, doMon, "readyRsps", doVerboseDebug)
  PrintableBundleStreamMonitor(io.out, doMon, "io.out", doVerboseDebug)
  */

  /*
  PrintableBundleStreamMonitor(io.memRdRsp, Bool(true), "memRdRsp", true)
  PrintableBundleStreamMonitor(io.memRdReq, Bool(true), "memRdReq", true)
  */
}
