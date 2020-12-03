package fpgatidbits.dma

//import chisel3._
import chisel3.util._
import chisel3._
import chisel3.util._
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
  val reqOrdered = Flipped(Decoupled(new GenericMemoryRequest(p)))
  val rspOrdered = Decoupled(new GenericMemoryResponse(p))

  // unordered interface towards out-of-order memory system
  val reqMem = Decoupled(new GenericMemoryRequest(p))
  val rspMem = Flipped(Decoupled(new GenericMemoryResponse(p)))

  // controls for ID queue reinit
  val doInit = Input(Bool())                // re-initialize queue
  val initCount = Input(UInt(8.W))  // # IDs to initializes
}

class ReadOrderCache(p: ReadOrderCacheParams) extends Module {
  val io = IO(new ReadOrderCacheIO(p.mrp, p.maxBurst))
  val beat = 0.U(p.mrp.dataWidth.W)
  val rid = 0.U(p.mrp.dataWidth.W)
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
    getChan = {x: GenericMemoryResponse => x.channelID - p.chanIDBase.U}
  )).io

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
  val origReqID = SyncReadMem( p.outstandingReqs, mreq.channelID.cloneType)
  when(readyReqs.ready & readyReqs.valid) {
    origReqID.read(freeReqID.idOut.bits) := io.reqOrdered.bits.channelID
  }

  //StreamMonitor(readyReqs, true.B, "readyReqs")

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
  io.rspOrdered.bits.isWrite := false.B
  io.rspOrdered.bits.metaData := 0.U

  // create a "repeated" version of the head of the busy queue -- each repeat
  // corresponds to one burst beat
  val repBitWidth = 1 + log2Up(p.maxBurst)
  val busyRep = Module(new StreamRepeatElem(mreq.getWidth, repBitWidth)).io
  val bytesInBeat = (p.mrp.dataWidth/8).U // TODO correct for sub-word reads?
  busyRep.inElem.TVALID := busyReqs.deq.valid
  busyRep.inRepCnt.TVALID := busyReqs.deq.valid
  busyRep.inElem.TDATA := busyReqs.deq.bits
  busyRep.inRepCnt.TDATA := busyReqs.deq.bits.numBytes / bytesInBeat
  busyReqs.deq.ready := busyRep.inElem.TREADY

  val busyRepHead = busyRep.out.TDATA.asTypeOf(mreq)
  storage.outSel := busyRepHead.channelID - (p.chanIDBase).U

  // join the storage.out and busyRep.out streams
  io.rspOrdered.valid := storage.out.valid & busyRep.out.TVALID
  storage.out.ready := io.rspOrdered.ready & busyRep.out.TVALID
  busyRep.out.TREADY := io.rspOrdered.ready & storage.out.valid

  // the head-of-line ID will be recycled when we are done with it
  freeReqID.idIn.valid := false.B
  freeReqID.idIn.bits := busyRepHead.channelID

  // restore the original request's channel ID with lookup
  io.rspOrdered.bits.channelID := origReqID(busyRepHead.channelID)

  val regBeatCounter = RegInit(0.U(repBitWidth.W))
  when(busyRep.out.TVALID & busyRep.out.TVALID) {
    regBeatCounter := regBeatCounter + 1.U
    when(regBeatCounter === (busyRepHead.numBytes / bytesInBeat) - 1.U) {
      regBeatCounter := 0.U
      freeReqID.idIn.valid := true.B // always room in the ID pool
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
  val idElem = UInt(idWidth.W)
  val io = IO(new Bundle {
    val doInit = Input(Bool())             // re-initialize queue
    val initCount = Input(UInt(8.W))  // # IDs to initializes
    val idIn = Flipped(Decoupled(idElem))       // recycled IDs into the pool
    val idOut = Decoupled(idElem)           // available IDs from the pool
  })
  val initGen = Module(new SequenceGenerator(idWidth)).io
  // initialize contents once upon reset, and when requested afterwards
  val regFirstInit = RegInit(true.B) // distinguish reset & manual init
  val regDoInit = RegInit(true.B)
  when(io.doInit) { regDoInit := true.B } // trigger manual reinit
  when(regDoInit & initGen.finished) {
    regDoInit := false.B
    regFirstInit := false.B
  }
  // clear queue contents prior to manual reinit
  val resetQueue = reset.asBool | (io.doInit & !regDoInit)
  val idQ = Module(new Queue(UInt(), maxEntries)).io
  idQ.deq <> io.idOut

  initGen.start := regDoInit
  // on-reset init fills the queue with max # elements
  initGen.count := Mux(regFirstInit, (maxEntries).U, io.initCount)
  initGen.step := 1.U
  initGen.init := (startID).U

  val idSources = Seq(io.idIn, initGen.seq)
  DecoupledInputMux(regDoInit, idSources) <> idQ.enq
}

// BRAM-based reqID queue, suitable for larger ID pools. does not support
// reinitialization with a smaller pool of elements
class ReqIDQueueBRAM(idWidth: Int, maxEntries: Int, startID: Int) extends Module {
  val idElem = UInt(idWidth.W)
  val io = IO(new Bundle {
    val idIn = Flipped(Decoupled(idElem))       // recycled IDs into the pool
    val idOut = Decoupled(idElem)           // available IDs from the pool
  })
  val initGen = Module(new SequenceGenerator(idWidth)).io
  // initialize contents once upon reset, and when requested afterwards
  val regDoInit = RegInit(true.B)
  when(regDoInit & initGen.finished) {
    regDoInit := false.B
  }

  val idQ = Module(new BRAMQueue(idElem, maxEntries)).io
  idQ.deq <> io.idOut

  initGen.start := regDoInit
  // on-reset init fills the queue with max # elements
  initGen.count := maxEntries.U
  initGen.step := 1.U
  initGen.init := (startID).U

  val idSources = Seq(io.idIn, initGen.seq)
  DecoupledInputMux(regDoInit, idSources) <> idQ.enq
}
