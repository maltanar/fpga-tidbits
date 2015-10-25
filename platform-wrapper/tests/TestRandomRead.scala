package TidbitsTestbenches

import Chisel._
import TidbitsPlatformWrapper._
import TidbitsDMA._
import TidbitsStreams._

trait TestRandomReadParams extends PlatformWrapperParams {
  val numMemPorts = 2
  val accelName = "TestRandomRead"
}

class TestRandomRead(p: PlatformWrapperParams) extends GenericAccelerator(p) {
  override val io = new GenericAcceleratorIF(p) {
    val start = Bool(INPUT)
    val finished = Bool(OUTPUT)
    val indsBase = UInt(INPUT, p.csrDataBits)
    val valsBase = UInt(INPUT, p.csrDataBits)
    val count = UInt(INPUT, p.csrDataBits)
    val sum = UInt(OUTPUT, p.csrDataBits)
  }
  // TODO generate signature with digest function
  io.signature := UInt(20151024)

  val rrgInds = Module(new ReadReqGen(p.toMemReqParams(), 0, 1)).io
  val opBytes = UInt(p.memDataBits/8)

  rrgInds.ctrl.start := io.start
  rrgInds.ctrl.throttle := Bool(false)
  rrgInds.ctrl.baseAddr := io.indsBase
  rrgInds.ctrl.byteCount := io.count * opBytes
  rrgInds.reqs <> io.memPort(0).memRdReq

  def idsToReqs(ids: DecoupledIO[UInt]): DecoupledIO[GenericMemoryRequest] = {
    val reqs = Decoupled(new GenericMemoryRequest(p.toMemReqParams())).asDirectionless
    val req = reqs.bits
    req.channelID := UInt(0)  // TODO parametrize!
    req.isWrite := Bool(false)
    req.addr := io.valsBase + ids.bits * opBytes
    req.numBytes := opBytes // single-beat burst
    req.metaData := UInt(0)

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

object TestRandomReadParamsWolverine extends WX690TParams with TestRandomReadParams {
  override val useAEGforRegFile = false
}

object TestRandomReadMain {
  def apply() = {
    val instFxnAccel = {p: PlatformWrapperParams => new TestRandomRead(p)}
    def instFxnWrapper() = {new WolverinePlatformWrapper(TestRandomReadParamsWolverine, instFxnAccel)}
    val instFxnTop = {() => Module(instFxnWrapper())}
    chiselMain(Array("--v"), instFxnTop)
    instFxnWrapper().generateRegDriver(".")
  }
}
