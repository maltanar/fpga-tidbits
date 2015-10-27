package TidbitsDMA

import Chisel._
import TidbitsStreams._

class StreamReaderParams(
  val streamWidth: Int,
  val fifoElems: Int,
  val mem: MemReqParams,
  val maxBeats: Int,
  val chanID: Int
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
}

class StreamReader(val p: StreamReaderParams) extends Module {
  val io = new StreamReaderIF(p.streamWidth, p.mem)
  val StreamElem = UInt(width = p.streamWidth)

  // read request generator
  val rg = Module(new ReadReqGen(p.mem, p.chanID, p.maxBeats)).io
  // FIFO to store read data
  val fifo = Module(new Queue(StreamElem, p.fifoElems)).io

  rg.ctrl.start := io.start
  // TODO add throttling logic based on FIFO level
  rg.ctrl.throttle := Bool(false)
  // TODO add pointer/size aligners here?
  rg.ctrl.baseAddr := io.baseAddr
  rg.ctrl.byteCount := io.byteCount

  // active and finished are generated based not only on the status
  // of the req.gen but also if all responses are finished (FIFO empty)
  io.active := rg.stat.active | (fifo.count > UInt(0))
  io.finished := rg.stat.finished & (fifo.count === UInt(0))
  io.error := rg.stat.error

  // push out memory requests to memRdReq channel
  rg.reqs <> io.req

  // TODO add StreamLimiter here?
  // read data responses (id etc filtered out)
  val rsp = ReadRespFilter(io.rsp)
  // TODO add a StreamResizer to handle all 3 cases
  if (p.mem.dataWidth == p.streamWidth) { rsp <> fifo.enq }
  else if (p.mem.dataWidth > p.streamWidth) {
    StreamDownsizer(rsp, p.streamWidth) <> fifo.enq
  } else if (p.mem.dataWidth < p.streamWidth) {
    // TODO implement upsizing
    throw new Exception("StreamUpsizer not yet implemented")
  }

  // expose FIFO output as the stream output
  fifo.deq <> io.out

  // TODO add support for statistics?
  // - average req, rsp, data consume latencies (histograms?)
}
