package fpgatidbits.dma

import chisel3._
import chisel3.util._
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
  val start = Input(Bool())
  val active = Output(Bool())
  val finished = Output(Bool())
  val error = Output(Bool())
  val baseAddr = Input(UInt(p.addrWidth.W))
  val byteCount = Input(UInt(32.W))
  // stream data input
  val in = Flipped(Decoupled(UInt(w.W)))
  // interface towards memory port
  val req = Decoupled(new GenericMemoryRequest(p))
  val wdat = Decoupled(UInt(p.dataWidth.W))
  val rsp = Flipped(Decoupled(new GenericMemoryResponse(p)))
}

class StreamWriter(val p: StreamWriterParams) extends Module {
  val io = IO(new StreamWriterIF(p.streamWidth, p.mem))
  val StreamElem = UInt(p.streamWidth.W)

  // always ready to receive write responses
  io.rsp.ready := true.B
  // count write responses to determine finished
  val regNumPendingReqs = RegInit(0.U(32.W))
  val regRequestedBytes = RegInit(0.U(32.W))
  when(!io.start) {
    regNumPendingReqs := 0.U
    regRequestedBytes := 0.U
  } .otherwise {
    val reqFired = io.req.valid & io.req.ready
    val rspFired = io.rsp.valid & io.rsp.ready
    regRequestedBytes := regRequestedBytes + Mux(reqFired, io.req.bits.numBytes, 0.U)
    when(reqFired && !rspFired) { regNumPendingReqs := regNumPendingReqs + 1.U}
    .elsewhen(!reqFired && rspFired) { regNumPendingReqs := regNumPendingReqs - 1.U }
  }
  // finished when:
  // - all bytes have been requested
  // - there are no pending (un-responded) requests left
  val fin = (regRequestedBytes === io.byteCount) & (regNumPendingReqs === 0.U)
  io.finished := io.start & fin

  // write request generator
  val wg = Module(new WriteReqGen(p.mem, p.chanID, p.maxBeats)).io
  wg.ctrl.start := io.start
  wg.ctrl.baseAddr := io.baseAddr
  wg.ctrl.byteCount := io.byteCount // TODO must be multiple of write size!
  wg.ctrl.throttle := false.B
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
