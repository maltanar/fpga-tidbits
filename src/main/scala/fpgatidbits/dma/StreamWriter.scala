package fpgatidbits.dma

import Chisel._
import fpgatidbits.streams._

// write contiguous streams of data to main memory
// note that start address and total byte count to write must be aligned to
// the memory bus size

// TODO add support for burst writes
class StreamWriterParams(
  val streamWidth: Int,
  val mem: MemReqParams,
  val chanID: Int,
  val maxBeats: Int = 1
)

class StreamWriterIF(w: Int, p: MemReqParams) extends Bundle {
  val start = Bool(INPUT)
  val active = Bool(OUTPUT)
  val finished = Bool(OUTPUT)
  val error = Bool(OUTPUT)
  val baseAddr = UInt(INPUT, p.addrWidth)
  val byteCount = UInt(INPUT, 32)
  // stream data input
  val in = Decoupled(UInt(width = w)).flip
  // interface towards memory port
  val req = Decoupled(new GenericMemoryRequest(p))
  val wdat = Decoupled(UInt(width = p.dataWidth))
  val rsp = Decoupled(new GenericMemoryResponse(p)).flip
}

class StreamWriter(val p: StreamWriterParams) extends Module {
  val io = new StreamWriterIF(p.streamWidth, p.mem)
  val StreamElem = UInt(width = p.streamWidth)

  // always ready to receive write responses
  io.rsp.ready := Bool(true)
  // count write responses to determine finished
  val regNumPendingReqs = Reg(init = UInt(0, 32))
  val regRequestedBytes = Reg(init = UInt(0, 32))
  when(!io.start) {
    regNumPendingReqs := UInt(0)
    regRequestedBytes := UInt(0)
  } .otherwise {
    val reqFired = io.req.valid & io.req.ready
    val rspFired = io.rsp.valid & io.rsp.ready
    regRequestedBytes := regRequestedBytes + Mux(reqFired, io.req.bits.numBytes, UInt(0))
    when(reqFired && !rspFired) { regNumPendingReqs := regNumPendingReqs + UInt(1)}
    .elsewhen(!reqFired && rspFired) { regNumPendingReqs := regNumPendingReqs - UInt(1) }
  }
  // finished when:
  // - all bytes have been requested
  // - there are no pending (un-responded) requests left
  val fin = (regRequestedBytes === io.byteCount) & (regNumPendingReqs === UInt(0))
  io.finished := io.start & fin

  // write request generator
  val wg = Module(new WriteReqGen(p.mem, p.chanID, p.maxBeats)).io
  wg.ctrl.start := io.start
  wg.ctrl.baseAddr := io.baseAddr
  wg.ctrl.byteCount := io.byteCount // TODO must be multiple of write size!
  wg.ctrl.throttle := Bool(false)
  io.active := (io.start & !fin)
  io.error := wg.stat.error

  // push out the generated write requests
  wg.reqs <> io.req

  // add a resizer between input data and write data
  if(p.streamWidth == p.mem.dataWidth) {io.in <> io.wdat}
  else if(p.streamWidth > p.mem.dataWidth) {
    StreamDownsizer(io.in, p.mem.dataWidth) <> io.wdat
  } else {
    StreamUpsizer(io.in, p.mem.dataWidth) <> io.wdat
  }
}
