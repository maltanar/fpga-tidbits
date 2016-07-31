package fpgatidbits.dma

import Chisel._
import fpgatidbits.ocm._
import fpgatidbits.streams._

// a read order cache design, heavily based on BRAMs to facilitate scaling
// to larger # outstanding transactions.
// in this design, BRAMs are used both for keeping the state of each burst and
// each burst (e.g. how many responses received so far) as well as the received
// burst data.

class ReadOrderCacheBRAM(p: ReadOrderCacheParams) extends Module {
  val io = new ReadOrderCacheIO(p.mrp, p.maxBurst)
  val beat = UInt(0, width = p.mrp.dataWidth)
  val rid = UInt(0, width = p.mrp.idWidth)
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
      p = p.mrp, addr = r.addr, write = Bool(false), id = freeID,
      numBytes = r.numBytes
    )}
  )

  // save original request ID upon entry
  // TODO should replace this with Cloakroom structure
  val origReqID = Mem(mreq.channelID.cloneType, p.outstandingReqs)
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

  io.reqMem.bits.channelID := UInt(p.chanIDBase) + reqIssueFork.outA.bits.channelID

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
  io.rspMem.ready := Bool(true)
  // subtract chanIDBase to get index of counter to read & use as read addr
  val ctrRdInd = io.rspMem.bits.channelID - UInt(p.chanIDBase)
  ctrRd.req.addr := ctrRdInd
  ctrRd.req.writeEn := Bool(false)

  val regCtrInd = Reg(next = ctrRdInd)
  val regCtrValid = Reg(next = io.rspMem.valid)
  val regCtrData = Reg(next = io.rspMem.bits.readData)
  val regCtrLast = Reg(next = io.rspMem.bits.isLast)
  // bypass logic to compensate for BRAM latency
  val regDoBypass = Reg(next = ctrWr.req.writeEn & (ctrRd.req.addr === ctrWr.req.addr))
  val regNewVal = Reg(init = UInt(0, width = ctrBits))
  val ctrOldVal = Mux(regDoBypass, regNewVal, ctrRd.rsp.readData)
  // use regCtrLast to clear counter at end of burst
  val ctrNewVal = Mux(regCtrLast, UInt(0), ctrOldVal + UInt(1))
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
  dataRd.req.writeEn := Bool(false)
  dataWr.req.writeData := regCtrData
  // compute where the newly arrived data goes
  dataWr.req.addr := regCtrInd * UInt(p.maxBurst) + ctrOldVal
  // store data when available
  dataWr.req.writeEn := regCtrValid

  // bitfield to keep track of burst finished status
  val regBurstFinished = Reg(init = UInt(0, width = p.outstandingReqs))
  val burstFinishedSet = UInt(width = p.outstandingReqs)
  burstFinishedSet := UInt(0, p.outstandingReqs)
  val burstFinishedClr = UInt(width = p.outstandingReqs)
  burstFinishedClr := UInt(0, p.outstandingReqs)
  regBurstFinished := (regBurstFinished & ~burstFinishedClr) | burstFinishedSet

  // set finished flag on last beat received
  when(regCtrValid & regCtrLast) {
    burstFinishedSet := UIntToOH(regCtrInd, p.outstandingReqs)
  }

  // =========================================================================

  // pop response when appropriate
  val headReq = busyReqs.deq.bits
  val headReqID = headReq.channelID
  val headReqBeats = headReq.numBytes / UInt(p.mrp.dataWidth/8)
  val headReqValid = busyReqs.deq.valid
  val headReqBurstFinished = regBurstFinished(headReqID)
  // keep track of how many elems have been emitted for the head request
  val regRspsPopped = Reg(init = UInt(0, 4))

  // handshaking-over-latency to read out results
  val canPopRsp = headRsps.count < UInt(2)
  val isRspAvailable = headReqValid & headReqBurstFinished
  val doPopRsp = canPopRsp & isRspAvailable
  dataRd.req.addr := (headReqID * UInt(p.maxBurst)) + regRspsPopped

  headRsps.enq.valid := Reg(next = doPopRsp)
  headRsps.enq.bits.readData := dataRd.rsp.readData
  headRsps.enq.bits.channelID := Reg(next = headReqID)  // internal ID
  freeReqID.idIn.bits := headReqID
  busyReqs.deq.ready := Bool(false)
  freeReqID.idIn.valid := Bool(false)

  when(doPopRsp) {
    when(regRspsPopped === headReqBeats - UInt(1)) {
      // when emitted responses = burst size, we are done
      // pop from busyReqs, recycle the ID and reset the counter
      regRspsPopped := UInt(0)
      burstFinishedClr := UIntToOH(headReqID, p.outstandingReqs)
      freeReqID.idIn.valid := Bool(true)
      busyReqs.deq.ready := Bool(true)
    } .otherwise {
      regRspsPopped := regRspsPopped + UInt(1)
    }
  }

  headRsps.deq <> io.rspOrdered
  // restore original request ID
  io.rspOrdered.bits.channelID := origReqID(headRsps.deq.bits.channelID)

  // =========================================================================
  // debug
  //StreamMonitor(io.reqOrdered, Bool(true), "reqOrdered", true)
  //StreamMonitor(io.rspOrdered, Bool(true), "rspOrdered", true)
  //StreamMonitor(io.reqMem, Bool(true), "memRdReq", true)
  //StreamMonitor(io.rspMem, Bool(true), "memRdRsp", true)
}
