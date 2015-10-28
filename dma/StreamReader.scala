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
  val fifo = Module(new Queue(StreamElem, p.fifoElems)).io

  rg.ctrl.start := io.start
  // TODO add throttling logic based on FIFO level
  rg.ctrl.throttle := Bool(false)
  rg.ctrl.baseAddr := io.baseAddr
  // make sure byte count is a multiple of the mem data width,
  // otherwise the request generator will never finish
  // the superflous (alignment) bytes will be removed later
  rg.ctrl.byteCount := RoundUpAlign(p.mem.dataWidth/8, io.byteCount)

  // active and finished are generated based not only on the status
  // of the req.gen but also if all responses are finished (FIFO empty)
  io.active := rg.stat.active | (fifo.count > UInt(0))
  io.finished := rg.stat.finished & (fifo.count === UInt(0))
  io.error := rg.stat.error

  // push out memory requests to memRdReq channel
  rg.reqs <> io.req

  // create a StreamLimiter that lets only the first byteCount bytes pass
  // this gets rid of any alignment bytes introduced by RoundUpAlign
  def lim(in: DecoupledIO[UInt]): DecoupledIO[UInt] = {
    StreamLimiter(in, io.start, io.byteCount)
  }

  // read data responses (id etc filtered out)
  val rsp = ReadRespFilter(io.rsp)
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

  // TODO add support for statistics?
  // - average req, rsp, data consume latencies (histograms?)
}
