package fpgatidbits.dma

import chisel3._
import chisel3.util._
import fpgatidbits.ocm._
import fpgatidbits.streams._

// a read order cache design, heavily based on BRAMs to facilitate scaling
// to larger # outstanding transactions.
// in this design, BRAMs are used both for keeping the state of each burst and
// each burst (e.g. how many responses received so far) as well as the received
// burst data.

class ReadOrderCacheBRAM(p: ReadOrderCacheParams) extends Module {
  val io = IO(new ReadOrderCacheIO(p.mrp, p.maxBurst))
  val beat = 0.U(p.mrp.dataWidth.W)
  val rid = 0.U(p.mrp.idWidth.W)
  val mreq = new GenericMemoryRequest(p.mrp)
  val mrsp = new GenericMemoryResponse(p.mrp)

  // queue with pool of available request IDs
  val freeReqID = Module(new ReqIDQueue(
    p.mrp.idWidth, p.outstandingReqs, 0)).io
  freeReqID.doInit := io.doInit
  freeReqID.initCount := io.initCount

  // queue with issued requests
  val busyReqs = Module(new FPGAQueue(mreq, p.outstandingReqs)).io
  // headRsps is used for handshaking-over-latency for reading rsps from BRAM
  // capacity = 1 (BRAM latency) + 2 (needed for full throughput)
  val headRsps = Module(new FPGAQueue(mrsp, 3)).io

  // issue new requests: sync freeReqID and incoming reqs
  val readyReqs = StreamJoin(
    inA = freeReqID.idOut, inB = io.reqOrdered, genO = mreq,
    join = {(freeID: UInt, r: GenericMemoryRequest) => GenericMemoryRequest(
      p = p.mrp, addr = r.addr, write = false.B, id = freeID,
      numBytes = r.numBytes
    )}
  )

  // save original request ID upon entry
  // TODO should replace this with Cloakroom structure
  val origReqID = SyncReadMem(p.outstandingReqs, mreq.channelID.cloneType)
  when(readyReqs.ready & readyReqs.valid) {
    origReqID(freeReqID.idOut.bits) := io.reqOrdered.bits.channelID
  }

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
  val regCtrLast = RegNext(io.rspMem.bits.isLast)
  // bypass logic to compensate for BRAM latency
  val regDoBypass = RegNext(ctrWr.req.writeEn & (ctrRd.req.addr === ctrWr.req.addr))
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
  // store received data in BRAM
  val storage = Module(new DualPortBRAM(
    addrBits = log2Up(p.outstandingReqs * p.maxBurst),
    dataBits = p.mrp.dataWidth
  )).io
  val dataRd = storage.ports(0)
  val dataWr = storage.ports(1)
  dataRd.req.writeEn := false.B
  dataWr.req.writeData := regCtrData
  // compute where the newly arrived data goes
  dataWr.req.addr := regCtrInd * p.maxBurst.U + ctrOldVal
  // store data when available
  dataWr.req.writeEn := regCtrValid

  // bitfield to keep track of burst finished status
  val regBurstFinished = RegInit(0.U(p.outstandingReqs.W))
  val burstFinishedSet = WireInit(0.U(p.outstandingReqs.W))
  val burstFinishedClr = WireInit(0.U(p.outstandingReqs.W))
  regBurstFinished := (regBurstFinished & (~burstFinishedClr).asUInt) | burstFinishedSet

  // set finished flag on last beat received
  when(regCtrValid & regCtrLast) {
    burstFinishedSet := UIntToOH(regCtrInd, p.outstandingReqs)
  }

  // =========================================================================

  // pop response when appropriate
  val headReq = busyReqs.deq.bits
  val headReqID = headReq.channelID
  val headReqBeats = headReq.numBytes / (p.mrp.dataWidth/8).U
  val headReqValid = busyReqs.deq.valid
  val headReqBurstFinished = regBurstFinished(headReqID)
  // keep track of how many elems have been emitted for the head request
  val regRspsPopped = RegInit(0.U(4.W))

  // handshaking-over-latency to read out results
  val canPopRsp = headRsps.count < 2.U
  val isRspAvailable = headReqValid & headReqBurstFinished
  val doPopRsp = canPopRsp & isRspAvailable
  dataRd.req.addr := (headReqID * (p.maxBurst).U) + regRspsPopped

  headRsps.enq.valid := RegNext(doPopRsp)
  headRsps.enq.bits.readData := dataRd.rsp.readData
  headRsps.enq.bits.channelID := RegNext(headReqID)  // internal ID
  freeReqID.idIn.bits := headReqID
  busyReqs.deq.ready := false.B
  freeReqID.idIn.valid := false.B

  when(doPopRsp) {
    when(regRspsPopped === headReqBeats - 1.U) {
      // when emitted responses = burst size, we are done
      // pop from busyReqs, recycle the ID and reset the counter
      regRspsPopped := 0.U
      burstFinishedClr := UIntToOH(headReqID, p.outstandingReqs)
      freeReqID.idIn.valid := true.B
      busyReqs.deq.ready := true.B
    } .otherwise {
      regRspsPopped := regRspsPopped + 1.U
    }
  }

  headRsps.deq <> io.rspOrdered
  // restore original request ID
  io.rspOrdered.bits.channelID := origReqID(headRsps.deq.bits.channelID)

  // =========================================================================
  // debug
  //StreamMonitor(io.reqOrdered, true.B, "reqOrdered", true)
  //StreamMonitor(io.rspOrdered, true.B, "rspOrdered", true)
  //StreamMonitor(io.reqMem, true.B, "memRdReq", true)
  //StreamMonitor(io.rspMem, true.B, "memRdRsp", true)
}
