package fpgatidbits.dma

import Chisel._
import fpgatidbits.ocm._
import fpgatidbits.streams._

class ReadOrderCacheParams (
  val mrp: MemReqParams,
  val maxBurst: Int,        // largest burst size (in beats) to handle
  val outstandingReqs: Int, // max # of simultaneous outstanding requests
  val chanIDBase: Int      // base channel id value for output mem reqs
)

class ReadOrderCacheIO(p: MemReqParams, maxBurst: Int) extends Bundle {
  // interface towards in-order processing elements
  val reqOrdered = Decoupled(new GenericMemoryRequest(p)).flip
  val rspOrdered = Decoupled(new GenericMemoryResponse(p))

  // unordered interface towards out-of-order memory system
  val reqMem = Decoupled(new GenericMemoryRequest(p))
  val rspMem = Decoupled(new GenericMemoryResponse(p)).flip

  // controls for ID queue reinit
  val doInit = Bool(INPUT)                // re-initialize queue
  val initCount = UInt(INPUT, width = 8)  // # IDs to initializes
}

class ReadOrderCache(p: ReadOrderCacheParams) extends Module {
  val io = new ReadOrderCacheIO(p.mrp, p.maxBurst)
  val beat = UInt(0, width = p.mrp.dataWidth)
  val rid = UInt(0, width = p.mrp.idWidth)
  val mreq = new GenericMemoryRequest(p.mrp)
  val mrsp = new GenericMemoryResponse(p.mrp)

  // queue with pool of available request IDs
  val freeReqID = Module(new ReqIDQueue(
    p.mrp.idWidth, p.outstandingReqs, p.chanIDBase)).io
  freeReqID.doInit := io.doInit
  freeReqID.initCount := io.initCount

  // queue with issued requests
  val busyReqs = Module(new FPGAQueue(mreq, p.outstandingReqs)).io

  // multichannel queue for buffering received read data
  val storage = Module(new MultiChanQueueSimple(
    gen = mrsp, chans = p.outstandingReqs, elemsPerChan = p.maxBurst,
    getChan = {x: GenericMemoryResponse => x.channelID - UInt(p.chanIDBase)}
  )).io

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


  // buffer incoming responses in the multichannel queue
  io.rspMem <> storage.in

  // ordered response data comes from the appropriate storage queue
  io.rspOrdered.bits.readData := storage.out.bits.readData
  io.rspOrdered.bits.isWrite := Bool(false)
  io.rspOrdered.bits.metaData := UInt(0)

  // create a "repeated" version of the head of the busy queue -- each repeat
  // corresponds to one burst beat
  val repBitWidth = 1 + log2Up(p.maxBurst)
  val busyRep = Module(new StreamRepeatElem(mreq.getWidth(), repBitWidth)).io
  val bytesInBeat = UInt(p.mrp.dataWidth/8) // TODO correct for sub-word reads?
  busyRep.inElem.valid := busyReqs.deq.valid
  busyRep.inRepCnt.valid := busyReqs.deq.valid
  busyRep.inElem.bits := busyReqs.deq.bits.toBits
  busyRep.inRepCnt.bits := busyReqs.deq.bits.numBytes / bytesInBeat
  busyReqs.deq.ready := busyRep.inElem.ready

  val busyRepHead = mreq.fromBits(busyRep.out.bits)
  storage.outSel := busyRepHead.channelID - UInt(p.chanIDBase)

  // join the storage.out and busyRep.out streams
  io.rspOrdered.valid := storage.out.valid & busyRep.out.valid
  storage.out.ready := io.rspOrdered.ready & busyRep.out.valid
  busyRep.out.ready := io.rspOrdered.ready & storage.out.valid

  // the head-of-line ID will be recycled when we are done with it
  freeReqID.idIn.valid := Bool(false)
  freeReqID.idIn.bits := busyRepHead.channelID

  // restore the original request's channel ID with lookup
  io.rspOrdered.bits.channelID := origReqID(busyRepHead.channelID)

  val regBeatCounter = Reg(init = UInt(0, repBitWidth))
  when(busyRep.out.valid & busyRep.out.ready) {
    regBeatCounter := regBeatCounter + UInt(1)
    when(regBeatCounter === (busyRepHead.numBytes / bytesInBeat) - UInt(1)) {
      regBeatCounter := UInt(0)
      freeReqID.idIn.valid := Bool(true) // always room in the ID pool
    }
  }
}

// a queue for storing the available request IDs, plus a little initializer
// to initially fill it with the range of available IDs --
// essentially the "pool of available request IDs". supports auto on-reset
// intialization (just fills with max # IDs) as well as manual re-init
// to limit the # of IDs in the pool further (requester becomes less aggressive)
// NOTE: make sure all IDs have been returned to the pool before doing
// manual re-initialization, weird things will happen otherwise
class ReqIDQueue(idWidth: Int, maxEntries: Int, startID: Int) extends Module {
  val idElem = UInt(width = idWidth)
  val io = new Bundle {
    val doInit = Bool(INPUT)                // re-initialize queue
    val initCount = UInt(INPUT, width = 8)  // # IDs to initializes
    val idIn = Decoupled(idElem).flip       // recycled IDs into the pool
    val idOut = Decoupled(idElem)           // available IDs from the pool
  }
  val initGen = Module(new SequenceGenerator(idWidth)).io
  // initialize contents once upon reset, and when requested afterwards
  val regFirstInit = Reg(init = Bool(true))  // distinguish reset & manual init
  val regDoInit = Reg(init = Bool(true))
  when(io.doInit) { regDoInit := Bool(true) } // trigger manual reinit
  when(regDoInit & initGen.finished) {
    regDoInit := Bool(false)
    regFirstInit := Bool(false)
  }
  // clear queue contents prior to manual reinit
  val resetQueue = reset | (io.doInit & !regDoInit)
  val idQ = Module(new Queue(idElem, maxEntries, _reset=resetQueue)).io
  idQ.deq <> io.idOut

  initGen.start := regDoInit
  // on-reset init fills the queue with max # elements
  initGen.count := Mux(regFirstInit, UInt(maxEntries), io.initCount)
  initGen.step := UInt(1)
  initGen.init := UInt(startID)

  val idSources = Seq(io.idIn, initGen.seq)
  DecoupledInputMux(regDoInit, idSources) <> idQ.enq
}

// BRAM-based reqID queue, suitable for larger ID pools. does not support
// reinitialization with a smaller pool of elements
class ReqIDQueueBRAM(idWidth: Int, maxEntries: Int, startID: Int) extends Module {
  val idElem = UInt(width = idWidth)
  val io = new Bundle {
    val idIn = Decoupled(idElem).flip       // recycled IDs into the pool
    val idOut = Decoupled(idElem)           // available IDs from the pool
  }
  val initGen = Module(new SequenceGenerator(idWidth)).io
  // initialize contents once upon reset, and when requested afterwards
  val regDoInit = Reg(init = Bool(true))
  when(regDoInit & initGen.finished) {
    regDoInit := Bool(false)
  }

  val idQ = Module(new BRAMQueue(idElem, maxEntries)).io
  idQ.deq <> io.idOut

  initGen.start := regDoInit
  // on-reset init fills the queue with max # elements
  initGen.count := UInt(maxEntries)
  initGen.step := UInt(1)
  initGen.init := UInt(startID)

  val idSources = Seq(io.idIn, initGen.seq)
  DecoupledInputMux(regDoInit, idSources) <> idQ.enq
}
