package TidbitsDMA

import Chisel._
import TidbitsOCM._
import TidbitsStreams._

class ReadOrderCacheParams (
  val mrp: MemReqParams,
  val maxBurst: Int,        // largest burst size (in beats) to handle
  val outstandingReqs: Int, // max # of simultaneous outstanding requests
  val chanIDBase: Int,      // base channel id value for output mem reqs
  val outputStreamID: Int   // channel id value for the ordered responses
)

class ReadOrderCacheIO(p: MemReqParams, maxBurst: Int) extends Bundle {
  // interface towards in-order processing elements
  val reqOrdered = Decoupled(new GenericMemoryRequest(p)).flip
  val rspOrdered = Decoupled(new GenericMemoryResponse(p))

  // unordered interface towards out-of-order memory system
  val reqMem = Decoupled(new GenericMemoryRequest(p))
  val rspMem = Decoupled(new GenericMemoryResponse(p)).flip
}

class ReadOrderCache(p: ReadOrderCacheParams) extends Module {
  val io = new ReadOrderCacheIO(p.mrp, p.maxBurst)
  val beat = UInt(0, width = p.mrp.dataWidth)
  val rid = UInt(0, width = p.mrp.idWidth)
  val mreq = new GenericMemoryRequest(p.mrp)

  // queue with pool of available request IDs
  val freeReqID = Module(new ReqIDQueue(
    p.mrp.idWidth, p.outstandingReqs, p.chanIDBase)).io

  // queue with issued requests
  val busyReqs = Module(new FPGAQueue(mreq, p.outstandingReqs)).io

  // storage queues for buffering received read data
  val storageQ = Vec.fill(p.outstandingReqs) {
    Module(new FPGAQueue(beat, p.maxBurst)).io
  }

  // issue new requests: sync freeReqID and incoming reqs
  val readyReqs = StreamJoin(
    inA = freeReqID.idOut, inB = io.reqOrdered, genO = mreq,
    join = {(freeID: UInt, r: GenericMemoryRequest) => GenericMemoryRequest(
      p = p.mrp, addr = r.addr, write = Bool(false), id = freeID,
      numBytes = r.numBytes
    )}
  )

  //StreamMonitor(readyReqs, Bool(true), "readyReqs")

  // issued requests go to both mem req channel and busyReqs queue
  val reqIssueFork = Module(new StreamFork(
    genIn = mreq, genA = mreq, genB = mreq,
    forkA = {x: GenericMemoryRequest => x},
    forkB = {x: GenericMemoryRequest => x}
  )).io

  readyReqs <> reqIssueFork.in
  reqIssueFork.outA <> io.reqMem
  reqIssueFork.outB <> busyReqs.enq

  // buffer incoming responses into appropriate storageQ
  ReadRespFilter(io.rspMem) <> DecoupledOutputDemux(
    sel = io.rspMem.bits.channelID - UInt(p.chanIDBase),
    chans = storageQ.map({x: QueueIO[UInt] => x.enq})
  )

  // finite state machine to drain the storage queues in-order
  val regBurstQueueID = Reg(init = UInt(0, width = p.mrp.idWidth))
  val regBurstBytesLeft = Reg(init = UInt(0, width = 8))

  val targetQ = DecoupledInputMux(
    sel = regBurstQueueID,
    chans = storageQ.map({x: QueueIO[UInt] => x.deq})
  )
  // ordered response data comes from the appropriate storage queue
  io.rspOrdered.bits.readData := targetQ.bits
  io.rspOrdered.bits.channelID := UInt(p.outputStreamID)
  io.rspOrdered.bits.isWrite := Bool(false)
  io.rspOrdered.bits.metaData := UInt(0)

  // FSM will set the control flow flags as appropriate
  io.rspOrdered.valid := Bool(false)
  targetQ.ready := Bool(false)
  busyReqs.deq.ready := Bool(false)

  // the head-of-line ID will be recycled when we are done with it
  freeReqID.idIn.valid := Bool(false)
  freeReqID.idIn.bits := regBurstQueueID + UInt(p.chanIDBase)

  // TODO correct for sub-word reads, if needed
  val bytesInBeat = UInt(p.mrp.dataWidth/8)

  val sWaitReq :: sWaitData :: sRecycleID :: Nil = Enum(UInt(), 3)
  val regState = Reg(init = UInt(sWaitReq))

  switch(regState) {
      is(sWaitReq) {
        regBurstQueueID := busyReqs.deq.bits.channelID - UInt(p.chanIDBase)
        regBurstBytesLeft := busyReqs.deq.bits.numBytes
        busyReqs.deq.ready := Bool(true)
        when(busyReqs.deq.valid) {regState := sWaitData}
      }

      is(sWaitData) {
        // connect storageQ output to ordered response output
        io.rspOrdered.valid := targetQ.valid
        targetQ.ready := io.rspOrdered.ready
        // watch for transactions and decrement counter
        when(targetQ.ready & targetQ.valid) {
          regBurstBytesLeft := regBurstBytesLeft - bytesInBeat
        }
        // when no more bytes left in burst, go to recycle ID state
        when (regBurstBytesLeft === UInt(0)) {regState := sRecycleID}
      }

      is(sRecycleID) {
        // we are finished handling a burst --
        // recycle request id back into the free pool
        freeReqID.idIn.valid := Bool(true)
        when(freeReqID.idIn.ready) {regState := sWaitReq}
      }
  }
}

// a queue for storing the available request IDs, plus a little initializer
// to initially fill it with the range of available IDs
// essentially the "pool of available request IDs"
class ReqIDQueue(idWidth: Int, entries: Int, startID: Int) extends Module {
  val idElem = UInt(width = idWidth)
  val io = new Bundle {
    val idIn = Decoupled(idElem).flip
    val idOut = Decoupled(idElem)
  }
  val initGen = Module(new SequenceGenerator(idWidth)).io
  // initialize contents once upon reset
  val regDoInit = Reg(init = Bool(true))
  when(regDoInit & initGen.finished) {regDoInit := Bool(false)}

  val idQ = Module(new FPGAQueue(idElem, entries)).io
  idQ.deq <> io.idOut

  initGen.start := regDoInit
  initGen.count := UInt(entries)
  initGen.step := UInt(1)
  initGen.init := UInt(startID)

  val idSources = Seq(io.idIn, initGen.seq)
  DecoupledInputMux(regDoInit, idSources) <> idQ.enq
}