package TidbitsDMA

import Chisel._
import TidbitsStreams._

// write contiguous streams of data to main memory
// note that start address and total byte count to write must be aligned to
// the memory bus size

// TODO add support for burst writes
class StreamWriterParams(
  val streamWidth: Int,
  val mem: MemReqParams,
  val chanID: Int
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
  val wdat = Decoupled(UInt(width = w))
  val rsp = Decoupled(new GenericMemoryResponse(p)).flip
}

class StreamWriter(val p: StreamWriterParams) extends Module {
  val io = new StreamWriterIF(p.streamWidth, p.mem)
  val StreamElem = UInt(width = p.streamWidth)

  // use a reducer to count write responses and decide finished
  val rc = Module(new StreamReducer(p.mem.dataWidth, 0, {_+_})).io
  rc.start := io.start
  rc.byteCount := io.byteCount
  rc.streamIn.valid := io.rsp.valid
  io.rsp.ready := rc.streamIn.ready

  // write request generator
  val wg = Module(new WriteReqGen(p.mem, p.chanID)).io
  wg.ctrl.start := io.start
  wg.ctrl.baseAddr := io.baseAddr
  wg.ctrl.byteCount := io.byteCount // TODO must be multiple of write size!
  wg.ctrl.throttle := Bool(false)
  io.active := (io.start & !rc.finished)
  io.finished := rc.finished  // finished when all write resps. received
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
