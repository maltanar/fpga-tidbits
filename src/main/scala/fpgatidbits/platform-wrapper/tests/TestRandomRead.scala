package fpgatidbits.Testbenches

import Chisel._
import fpgatidbits.PlatformWrapper._
import fpgatidbits.dma._
import fpgatidbits.streams._

class TestRandomRead(p: PlatformWrapperParams) extends GenericAccelerator(p) {
  val numMemPorts = 2
  val io = new GenericAcceleratorIF(numMemPorts, p) {
    val start = Input(Bool())
    val finished = Output(Bool())
    val indsBase = UInt(INPUT, 64)
    val valsBase = UInt(INPUT, 64)
    val count = UInt(INPUT, 32)
    val sum = UInt(OUTPUT, 32)
  }
  io.signature := makeDefaultSignature()
  // plug unused ports
  plugMemWritePort(0)
  plugMemWritePort(1)

  val rrgInds = Module(new ReadReqGen(p.toMemReqParams(), 0, 1)).io
  val opBytes = UInt(p.memDataBits/8)

  rrgInds.ctrl.start := io.start
  rrgInds.ctrl.throttle := false.B
  rrgInds.ctrl.baseAddr := io.indsBase
  rrgInds.ctrl.byteCount := io.count * opBytes
  rrgInds.reqs <> io.memPort(0).memRdReq

  def idsToReqs(ids: DecoupledIO[UInt]): DecoupledIO[GenericMemoryRequest] = {
    val reqs = Decoupled(new GenericMemoryRequest(p.toMemReqParams())).asDirectionless
    val req = reqs.bits
    req.channelID := 0.U  // TODO parametrize!
    req.isWrite := false.B
    req.addr := io.valsBase + ids.bits * opBytes
    req.numBytes := opBytes // single-beat burst
    req.metaData := 0.U

    reqs.valid := ids.valid
    ids.ready := reqs.ready

    return reqs
  }
  val readDataFilter = {x: GenericMemoryResponse => x.readData}

  val readInds = StreamFilter(io.memPort(0).memRdRsp, UInt(width=p.memDataBits), readDataFilter)
  io.memPort(1).memRdReq <> idsToReqs(readInds)

  val red = Module(new StreamReducer(p.memDataBits, 0, {_+_})).io
  red.start := io.start
  red.byteCount := io.count * opBytes
  red.streamIn <> StreamFilter(io.memPort(1).memRdRsp, UInt(width=p.memDataBits), readDataFilter)

  io.sum := red.reduced
  io.finished := red.finished
}
