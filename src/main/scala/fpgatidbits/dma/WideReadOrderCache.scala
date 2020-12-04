package fpgatidbits.dma

import chisel3._
import chisel3.util._
import fpgatidbits.ocm._
import fpgatidbits.streams._
import fpgatidbits.utils._
// a burst-oriented read order cache that outputs the entire burst content at
// once. useful for filling cachelines. design is almost identical to
// ReadOrderCacheBRAM, just with wide (instead of deep) BRAMs for the storage.

class WideReadOrderCache(p: ReadOrderCacheParams) extends Module {
  val burstBits = p.mrp.dataWidth * p.maxBurst
  val burstBytes = burstBits / 8
  val io = IO(new Bundle {
    // interface towards in-order processing elements
    // note the difference from the regular ReadOrderCache req/rsp interface;
    // all metadata is stripped
    val reqOrdered = Flipped(Decoupled(UInt(p.mrp.addrWidth.W)))
    val rspOrdered = Decoupled(UInt(burstBits.W))

    // unordered interface towards out-of-order memory system
    val reqMem = Decoupled(new GenericMemoryRequest(p.mrp))
    val rspMem = Flipped(Decoupled(new GenericMemoryResponse(p.mrp)))
  })

  val beat = 0.U(p.mrp.dataWidth.W)
  val fullBurst = UInt(burstBits.W)
  val rid = 0.U(p.mrp.idWidth.W)
  val mreq = new GenericMemoryRequest(p.mrp)
  // build a clonetype for the wide memory rsps
  val modMRP = new MemReqParams(p.mrp.addrWidth, burstBits, p.mrp.idWidth,
  p.mrp.metaDataWidth, p.mrp.sameIDInOrder)
  val mrsp = new GenericMemoryResponse(modMRP)

  // queue with pool of available request IDs
  val freeReqID = Module(new ReqIDQueue(
    p.mrp.idWidth, p.outstandingReqs, 0)).io

  // queue with issued requests
  val busyReqs = Module(new FPGAQueue(mreq, p.outstandingReqs)).io
  // headRsps is used for handshaking-over-latency for reading rsps from BRAM
  // capacity = 1 (BRAM latency) + 2 (needed for full throughput)
  val headRsps = Module(new FPGAQueue(mrsp, 3)).io

  // issue new requests: sync freeReqID and incoming reqs
  val readyReqs = StreamJoin(
    inA = freeReqID.idOut, inB = io.reqOrdered, genO = mreq,
    join = {(freeID: UInt, r: UInt) => GenericMemoryRequest(
      p = p.mrp, addr = r, write = false.B, id = freeID,
      numBytes = (burstBytes).U
    )}
  )

  // issued requests go to both mem req channel and busyReqs queue
  val reqIssueFork = Module(new StreamFork(
    genIn = mreq, genA = mreq, genB = mreq,
    forkA = {x: GenericMemoryRequest => x},
    forkB = {x: GenericMemoryRequest => x}
  )).io

  readyReqs <> reqIssueFork.in
  reqIssueFork.outA <> io.reqMem
  reqIssueFork.outB <> busyReqs.enq

  io.reqMem.bits.channelID := p.chanIDBase.U + reqIssueFork.outA.bits.channelID

  //==========================================================================

  val ctrBits = log2Up(p.maxBurst)
  val reqIDBits = log2Up(p.outstandingReqs)
  // since burst responses can be interleaved, each in-flight burst can have
  // a number of elements it has already received. we use the following BRAM
  // as a counter to keep track of the number of elements received for each
  // in-flight burst. we do a read-modify-write through this BRAM to do this.
  val rspCounters = Module(new DualPortBRAM(reqIDBits, ctrBits)).io
  val ctrRd = rspCounters.ports(0)
  val ctrWr = rspCounters.ports(1)
  // an issued request always means its storage space is ready, so we can always
  // accept memory responses.
  io.rspMem.ready := true.B
  // subtract chanIDBase to get index of counter to read & use as read addr
  val ctrRdInd = io.rspMem.bits.channelID - p.chanIDBase.U
  ctrRd.req.addr := ctrRdInd
  ctrRd.req.writeEn := false.B

  val regCtrInd = RegNext(ctrRdInd)
  val regCtrValid = RegNext(io.rspMem.valid)
  val regCtrData = RegNext(io.rspMem.bits.readData)
  val regCtrLast = RegNext( io.rspMem.bits.isLast)
  // bypass logic to compensate for BRAM latency
  val regDoBypass = RegNext( ctrWr.req.writeEn & (ctrRd.req.addr === ctrWr.req.addr))
  val regNewVal = RegInit(0.U(ctrBits.W))
  val ctrOldVal = Mux(regDoBypass, regNewVal, ctrRd.rsp.readData)
  // use regCtrLast to clear counter at end of burst
  val ctrNewVal = Mux(regCtrLast, 0.U, ctrOldVal + 1.U)
  regNewVal := ctrNewVal
  ctrWr.req.addr := regCtrInd
  ctrWr.req.writeEn := regCtrValid
  ctrWr.req.writeData := ctrNewVal

  /* TODO IMPROVE potentially long comb path, can hurt frequency --
      can add registers prior to data store BRAM to improve
  */
  // store received data in bank-writable BRAM, each bank is as wide as the
  // mem data bus
  val storage = Module(new DualPortMaskedBRAM(
    addrBits = log2Up(p.outstandingReqs), dataBits = burstBits,
    unit = p.mrp.dataWidth
  )).io
  val dataRd = storage.ports(0)
  val dataWr = storage.ports(1)
  dataRd.req.writeEn := false.B
  // compute where the newly arrived data goes
  dataWr.req.addr := regCtrInd
  // store data when available
  dataWr.req.writeEn := regCtrValid
  // need to align write data into correct position
  // variable leftshift according to ctrOldVal
  dataWr.req.writeData := regCtrData << (ctrOldVal * (p.mrp.dataWidth).U)
  // compute a one-hot write mask with the correct word
  for(i <- 0 until p.maxBurst) {
    dataWr.req.writeMask(i) := (ctrOldVal === i.U)
  }

  // bitfield to keep track of burst finished status
  val regBurstFinished = RegInit(0.U(p.outstandingReqs.W))
  val burstFinishedSet = UInt(p.outstandingReqs.W)
  burstFinishedSet := 0.U(p.outstandingReqs.W)
  val burstFinishedClr = UInt(p.outstandingReqs.W)
  burstFinishedClr := 0.U(p.outstandingReqs)
  regBurstFinished := (regBurstFinished & (~burstFinishedClr).asUInt) | burstFinishedSet

  // set finished flag on last beat received
  when(regCtrValid & regCtrLast) {
    burstFinishedSet := UIntToOH(regCtrInd, p.outstandingReqs)
  }

  // =========================================================================

  // pop response when appropriate
  val headReq = busyReqs.deq.bits
  val headReqID = headReq.channelID
  val headReqValid = busyReqs.deq.valid
  val headReqBurstFinished = regBurstFinished(headReqID)

  // handshaking-over-latency to read out results
  val canPopRsp = headRsps.count < 2.U
  val isRspAvailable = headReqValid & headReqBurstFinished
  val doPopRsp = canPopRsp & isRspAvailable
  dataRd.req.addr := headReqID

  headRsps.enq.valid := RegNext(doPopRsp)
  headRsps.enq.bits.readData := dataRd.rsp.readData
  headRsps.enq.bits.channelID := RegNext(headReqID)  // internal ID
  freeReqID.idIn.bits := headReqID
  busyReqs.deq.ready := false.B
  freeReqID.idIn.valid := false.B

  when(doPopRsp) {
    // pop from busyReqs, recycle the ID and reset the counter
    burstFinishedClr := UIntToOH(headReqID, p.outstandingReqs)
    freeReqID.idIn.valid := true.B
    busyReqs.deq.ready := true.B
  }

  headRsps.deq <> io.rspOrdered
  io.rspOrdered.bits := headRsps.deq.bits.readData

  // =========================================================================
  // debug
  //StreamMonitor(io.reqOrdered, true.B, "reqOrdered", true)
  //StreamMonitor(io.rspOrdered, true.B, "rspOrdered", true)
  //PrintableBundleStreamMonitor(io.reqMem, true.B, "memRdReq", true)
  //PrintableBundleStreamMonitor(io.rspMem, true.B, "memRdRsp", true)
}


// an alternative to WideReadOrderCache: upsize an incoming burst using a
// shift register (StreamUpsizer)
class BurstUpsizer(mIn: MemReqParams, wOut: Int) extends Module {
  val mOut = new MemReqParams(
    mIn.addrWidth, wOut, mIn.dataWidth, mIn.metaDataWidth, mIn.sameIDInOrder
  )
  val io = new Bundle {
    val in = Flipped(Decoupled(new GenericMemoryResponse(mIn)))
    val out = Decoupled(new GenericMemoryResponse(mOut))
  }
  val wIn = mIn.dataWidth
  if(wOut % wIn != 0) throw new Exception("Cannot upsize from unaligned size")

  // copy all fields by default
  io.out.bits := io.in.bits
  // upsize the read data if needed
  var upsized = if(wOut > mIn.dataWidth) StreamUpsizer(ReadRespFilter(io.in), wOut, Decoupled(0.U)) else ReadRespFilter(io.in)

  // use the upsized read data stream to drive output readData and handshake
  io.out.valid := upsized.valid
  upsized.ready := io.out.ready
  io.out.bits.readData := upsized.bits
}
