package fpgatidbits.dma

import Chisel._
import fpgatidbits.streams._
import fpgatidbits.ocm._

class StreamReaderParams(
  val streamWidth: Int,
  val fifoElems: Int,
  val mem: MemReqParams,
  val maxBeats: Int,
  val chanID: Int,
  val disableThrottle: Boolean = false,
  val readOrderCache: Boolean = false,
  val readOrderTxns: Int = 4,
  val streamName: String = "stream"
)

class StreamReaderIF(w: Int, p: MemReqParams) extends Bundle {
  val start = Bool(INPUT)
  val active = Bool(OUTPUT)
  val finished = Bool(OUTPUT)
  val error = Bool(OUTPUT)
  val baseAddr = UInt(INPUT, p.addrWidth)
  val byteCount = UInt(INPUT, 32)
  // stream data output
  val out = Decoupled(UInt(width = w))
  // interface towards memory port
  val req = Decoupled(new GenericMemoryRequest(p))
  val rsp = Decoupled(new GenericMemoryResponse(p)).flip
  // controls for ID queue reinit
  val doInit = Bool(INPUT)                // re-initialize queue
  val initCount = UInt(INPUT, width = 8)  // # IDs to initializes
}

// size alignment in hardware
// if lower bits are not zero (=not aligned), increment upper bits by one,
// concatenate zeroes as the lower bits and return
object RoundUpAlign {
  def apply(align: Int, x: UInt): UInt = {
    val numZeroAddrBits = log2Up(align)
    val numOtherBits = x.getWidth()-numZeroAddrBits
    val lower = x(numZeroAddrBits-1, 0)
    val upper = x(x.getWidth()-1, numZeroAddrBits)
    val isAligned = (lower === UInt(0))
    return Mux(isAligned, x, Cat(upper+UInt(1), UInt(0, width = numZeroAddrBits)))
  }
}

class StreamReader(val p: StreamReaderParams) extends Module {
  val io = new StreamReaderIF(p.streamWidth, p.mem)
  val StreamElem = UInt(width = p.streamWidth)

  // read request generator
  val rg = Module(new ReadReqGen(p.mem, p.chanID, p.maxBeats)).io
  // FIFO to store read data
  val fifo = Module(new FPGAQueue(StreamElem, p.fifoElems)).io
  val streamBytes = UInt(p.streamWidth/8)
  val memWidthBytes = p.mem.dataWidth/8

  rg.ctrl.start := io.start
  rg.ctrl.baseAddr := io.baseAddr
  // make sure byte count is a multiple of the mem data width,
  // otherwise the request generator will never finish
  // the superflous (alignment) bytes will be removed later
  rg.ctrl.byteCount := RoundUpAlign(memWidthBytes, io.byteCount)

  val regDoneBytes = Reg(init = UInt(0, width = 32))
  when(!io.start) { regDoneBytes := UInt(0) }
  .elsewhen(io.out.valid & io.out.ready) {
    regDoneBytes := regDoneBytes + UInt(p.streamWidth/8)
  }
  val allResponsesDone = (regDoneBytes === io.byteCount)
  io.active := io.start & !allResponsesDone
  io.finished := allResponsesDone
  io.error := rg.stat.error

  var orderedResponses = io.rsp

  if(p.readOrderCache) {
    val roc = Module(new ReadOrderCache(new ReadOrderCacheParams(
      mrp = p.mem, maxBurst = p.maxBeats, outstandingReqs = p.readOrderTxns,
      chanIDBase = p.chanID
    ))).io

    roc.doInit := io.doInit
    roc.initCount := io.initCount

    // push requests to read order cache
    rg.reqs <> roc.reqOrdered
    roc.reqMem <> io.req
    // receive ordered responses from the read order cache
    io.rsp <> roc.rspMem
    orderedResponses = roc.rspOrdered
  } else {
    // push out memory requests directly to memory channel
    rg.reqs <> io.req
  }

  // create a StreamLimiter that lets only the first byteCount bytes pass
  // this gets rid of any alignment bytes introduced by RoundUpAlign
  def lim(in: DecoupledIO[UInt]): DecoupledIO[UInt] = {
    StreamLimiter(in, io.start, io.byteCount)
  }

  // read data responses (id etc filtered out)
  val rsp = ReadRespFilter(
    orderedResponses
  )
  // TODO add a StreamResizer to handle all 3 cases
  if (p.mem.dataWidth == p.streamWidth) { lim(rsp) <> fifo.enq }
  else if (p.mem.dataWidth > p.streamWidth) {
    lim(StreamDownsizer(rsp, p.streamWidth)) <> fifo.enq
  } else if (p.mem.dataWidth < p.streamWidth) {
    // TODO implement upsizing
    throw new Exception("StreamUpsizer not yet implemented")
  }

  // expose FIFO output as the stream output
  fifo.deq <> io.out

  if(p.disableThrottle) { rg.ctrl.throttle := Bool(false) }
  else {
    // throttling logic: don't ask more than what we can chew, limit the #
    // outstanding requested bytes to FIFO capacity
    val regBytesInFlight = Reg(init = UInt(0, 32))
    val fifoCount = UInt(width = 32)
    val maxElemsInReq = (memWidthBytes * p.maxBeats / (p.streamWidth/8))
    if(p.fifoElems < 2*maxElemsInReq)
      throw new Exception("Too small FIFO in StreamReader")
    // cap the FIFO capacity at size-2*burst to have some slack; might overflow
    // due to stale feedback
    val fifoMax = UInt(p.fifoElems-2*maxElemsInReq, width = 32)
    // cap off the returned count at fifoMax to prevent underflows
    fifoCount := Mux(fifo.count > fifoMax, fifoMax, fifo.count)
    val fifoAvailBytes = (fifoMax - fifoCount) * streamBytes
    // calculate per-cycle updates to # bytes in flight
    val outReqBytes = UInt(width = 32)
    val inRspBytes = UInt(width = 32)
    outReqBytes := UInt(0)
    inRspBytes := UInt(0)
    when(rsp.valid & rsp.ready) { inRspBytes := UInt(memWidthBytes) }
    when(io.req.valid & io.req.ready) { outReqBytes := io.req.bits.numBytes }
    regBytesInFlight := regBytesInFlight + outReqBytes - inRspBytes
    // throttle when we start getting too many requests
    rg.ctrl.throttle := Reg(next=regBytesInFlight >= fifoAvailBytes)
  }

  // TODO add support for statistics?
  // - average req, rsp, data consume latencies (histograms?)

  // uncomment below for performance-debugging StreamReader
  /*
  val regCycleCount = Reg(init = UInt(0, 32))
  val regCycleFifoNotValid = Reg(init = UInt(0, 32))
  val regCycleMemRspNotValid = Reg(init = UInt(0, 32))
  val act = io.start & !io.finished
  val regWasActive = Reg(next = act)
  when(io.active) {
    regCycleCount := regCycleCount + UInt(1)
    when(!fifo.deq.valid) {
      regCycleFifoNotValid := regCycleFifoNotValid + UInt(1)
    }
    when(!rsp.valid) {
      regCycleMemRspNotValid := regCycleMemRspNotValid + UInt(1)
      if(p.streamName == "nzdata")
      printf("mem rsp for " + p.streamName + "not valid: %d \n", regCycleCount)
    }

  }

  when(regWasActive & !act) {
    printf("Stats for " + p.streamName + "\n ======================== \n")
    printf("FIFO not valid cycles: %d \n", regCycleFifoNotValid)
    printf("MemRsp not valid cycles: %d \n", regCycleMemRspNotValid)
    printf("Total cycles: %d \n", regCycleCount)
    printf("\n")
  }

  when(rg.ctrl.throttle) {
    printf("throttling " + p.streamName + "\n")
  }
  */
}
