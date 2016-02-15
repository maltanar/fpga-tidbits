package TidbitsTestbenches

import Chisel._
import TidbitsPlatformWrapper._
import TidbitsDMA._
import TidbitsStreams._

class TestGather(p: PlatformWrapperParams) extends GenericAccelerator(p) {
  val numMemPorts = 2
  val io = new GenericAcceleratorIF(numMemPorts, p) {
    val start = Bool(INPUT)
    val finished = Bool(OUTPUT)
    val indsBase = UInt(INPUT, 64)
    val valsBase = UInt(INPUT, 64)
    val count = UInt(INPUT, 32)
    val sum = UInt(OUTPUT, 32)
  }
  io.signature := makeDefaultSignature()
  val mrp = p.toMemReqParams()

  // # bits per index, 32-bit integers are generally enough
  val indWidth = 32
  val datWidth = 64
  val bytesPerVal = UInt(datWidth/8)

  // instantiate a StreamReader to read out the indices array
  val inds = Module(new StreamReader(new StreamReaderParams(
    streamWidth = indWidth, fifoElems = 8, mem = mrp, chanID = 0,
    maxBeats = p.burstBeats, disableThrottle = true, readOrderCache = true,
    readOrderTxns = p.seqStreamTxns(), streamName = "inds"
  ))).io

  inds.start := io.start
  inds.baseAddr := io.indsBase
  inds.byteCount := bytesPerVal

  // instantiate the gather accelerator to be tested
  /* TODO parametrize choice of gather accel */
  val gather = Module(new GatherNoCache(
    chanBaseID = 0, outstandingTxns = 16, indWidth = indWidth,
    datWidth = datWidth, tagWidth = indWidth, mrp = mrp
  )).io

  gather.in.valid := inds.out.valid
  inds.out.ready := gather.in.ready
  // use the incoming stream of indices both as load indices and tags --
  // we'll use the tag to check the loaded value
  gather.in.bits.ind := inds.out.bits
  gather.in.bits.tag := inds.out.bits

  // wire up the memory system
  inds.req <> io.memPort(0).memRdReq
  io.memPort(0).memRdRsp <> inds.rsp
  io.memPort(1) <> gather
}
