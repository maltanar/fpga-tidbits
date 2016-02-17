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
    val resultsOK = UInt(OUTPUT, 32)
    val resultsNotOK = UInt(OUTPUT, 32)
  }
  io.signature := makeDefaultSignature()
  val mrp = p.toMemReqParams()

  // # bits per index, 32-bit integers are generally enough
  val indWidth = 32
  val datWidth = 64
  val bytesPerInd = UInt(indWidth/8)

  val regIndCount = Reg(next = io.count)

  // instantiate a StreamReader to read out the indices array
  val inds = Module(new StreamReader(new StreamReaderParams(
    streamWidth = indWidth, fifoElems = 8, mem = mrp, chanID = 0,
    maxBeats = p.burstBeats, disableThrottle = true, readOrderCache = true,
    readOrderTxns = p.seqStreamTxns(), streamName = "inds"
  ))).io

  inds.start := io.start
  inds.baseAddr := io.indsBase
  inds.byteCount := bytesPerInd * regIndCount

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

  // examine incoming results from gatherer
  // -- compare against known good value
  val regResultsOK = Reg(init = UInt(0, 32))
  val regResultsNotOK = Reg(init = UInt(0, 32))
  val regActive = Reg(init = Bool(false))

  gather.out.ready := Bool(true)
  io.finished := Bool(false)

  when(!regActive) {
    regResultsOK := UInt(0)
    regResultsNotOK := UInt(0)
    regActive := io.start
  } .otherwise {
    // watch incoming gather responses
    when(gather.out.ready & gather.out.valid) {
      val expVal = gather.out.bits.tag
      when(expVal === gather.out.bits.dat) {
        regResultsOK := regResultsOK + UInt(1)
      } .otherwise {
        regResultsNotOK := regResultsNotOK + UInt(1)
      }
    }
    val totalResps = regResultsOK + regResultsNotOK
    when(totalResps === regIndCount) {
      io.finished := Bool(true)
      when(!io.start) {regActive := Bool(false)}
    }
  }

  io.resultsOK := regResultsOK
  io.resultsNotOK := regResultsNotOK
}
