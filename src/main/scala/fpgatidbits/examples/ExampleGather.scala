package fpgatidbits.examples

import chisel3._
import chisel3.util._
import fpgatidbits.PlatformWrapper._
import fpgatidbits.dma._
import fpgatidbits.streams._

class ExampleGatherIO(n: Int, p: PlatformWrapperParams) extends GenericAcceleratorIF(n,p) {
  val start = Input(Bool())
  val finished = Output(Bool())
  val indsBase = Input(UInt(64.W))
  val valsBase = Input(UInt(64.W))
  val count = Input(UInt(32.W))
  val resultsOK = Output(UInt(32.W))
  val resultsNotOK = Output(UInt(32.W))
  val perf = new Bundle {
    val cycles = Output(UInt(32.W))
    val monInds = new StreamMonitorOutIF()
    val monRdReq = new StreamMonitorOutIF()
    val monRdRsp = new StreamMonitorOutIF()
    val resultsOoO = Output(UInt(32.W))
  }
}
class ExampleGather(p: PlatformWrapperParams) extends GenericAccelerator(p) {
  val numMemPorts = 2
  val io = IO(new ExampleGatherIO(numMemPorts, p))
  io.signature := makeDefaultSignature()
  val mrp = p.toMemReqParams()
  // plug unused ports (write ports)
  plugMemWritePort(0)
  plugMemWritePort(1)

  // # bits per index, 32-bit integers are generally enough
  val indWidth = 32
  val datWidth = 64
  val bytesPerInd = (indWidth/8).U
  val numTxns = 32

  val regIndCount = RegNext(io.count)

  // instantiate a StreamReader to read out the indices array
  val inds = Module(new StreamReader(
    new StreamReaderParams(
      streamWidth = indWidth,
      fifoElems = 8,
      mem = mrp,
      chanID = 0,
      maxBeats = p.burstBeats,
      disableThrottle = true,
      readOrderCache = true,
      readOrderTxns = p.seqStreamTxns(),
      streamName = "inds"
  ))).io

  // Set initCount to readOrderTxns because that is passed in to roc to freeReqId
  inds.doInit := true.B
  inds.initCount := 62.U

  inds.start := io.start
  inds.baseAddr := io.indsBase
  inds.byteCount := bytesPerInd * regIndCount

  // instantiate the gather accelerator to be tested
  /* TODO parametrize choice of gather accel */
  val gather = Module(new GatherNBCache_Coalescing(
    lines = 1024,
    nbMisses = numTxns,
    elemsPerLine = 8,
    pipelinedStorage = 0,
    chanBaseID = 0,
    indWidth = indWidth,
    datWidth = datWidth,
    tagWidth = indWidth,
    mrp = mrp,
    orderRsps = true,
    coalescePerLine = 8
  ))

  gather.accel_io.in.valid := inds.out.valid
  inds.out.ready := gather.accel_io.in.ready
  // use the incoming stream of indices both as load indices and tags --
  // we'll use the tag to check the loaded value
  gather.accel_io.in.bits.ind := inds.out.bits
  gather.accel_io.in.bits.tag := inds.out.bits

  gather.accel_io.base := io.valsBase

  // wire up the memory system
  inds.req <> io.memPort(0).memRdReq

  inds.req.ready := io.memPort(0).memRdReq.ready

  io.memPort(0).memRdRsp <> inds.rsp
  io.memPort(1).memRdReq <> gather.mem_io.memRdReq
  io.memPort(1).memRdRsp <> gather.mem_io.memRdRsp

  // examine incoming results from gatherer
  // -- compare against known good value
  val regResultsOK = RegInit(0.U(32.W))
  val regResultsNotOK = RegInit(0.U(32.W))
  val regTotal = RegInit(0.U(32.W))
  val regActive = RegInit(false.B)
  val regCycles = RegInit(0.U(32.W))
  val regNumOutOfOrder = RegInit(0.U(32.W))

  gather.accel_io.out.ready := true.B
  io.finished := false.B

  regTotal := regResultsOK + regResultsNotOK

  // keep a copy of all gather requests in the order they arrive,
  // we'll compare them with the gather responses to determine the number of
  // out-of-order responses
  val orderCheckQ = Module(new Queue(gather.accel_io.in.bits.cloneType, 2*numTxns)).io
  orderCheckQ.enq.valid := gather.accel_io.in.valid & gather.accel_io.in.ready
  orderCheckQ.enq.bits := gather.accel_io.in.bits
  orderCheckQ.deq.ready := gather.accel_io.out.ready & gather.accel_io.out.valid

  when(gather.accel_io.in.fire & !orderCheckQ.enq.ready) {
    printf("Error: No space left in orderCheckQ!\n")
  }

  when(!regActive) {
    regResultsOK := 0.U
    regResultsNotOK := 0.U
    regCycles := 0.U
    regNumOutOfOrder := 0.U
    regActive := io.start
  } .otherwise {
    // watch incoming gather responses
    when(gather.accel_io.out.ready & gather.accel_io.out.valid) {
      val expVal = gather.accel_io.out.bits.tag
      when(expVal === gather.accel_io.out.bits.dat) {
        regResultsOK := regResultsOK + 1.U
      } .otherwise {
        regResultsNotOK := regResultsNotOK + 1.U
      }
      // increment OoO response counter if appropriate
      when(orderCheckQ.deq.bits.tag =/= gather.accel_io.out.bits.tag) {
        printf("Found OoO response at %d, expected %d found %d \n",
          regResultsOK+regResultsNotOK,
          orderCheckQ.deq.bits.tag, gather.accel_io.out.bits.tag
        )
        regNumOutOfOrder := regNumOutOfOrder + 1.U
      }
    }

    when(regTotal === regIndCount) {
      io.finished := true.B
      when(!io.start) {regActive := false.B}
    } .otherwise {
      // still some work to do, keep track of # cycles
      regCycles := regCycles + 1.U
    }
  }

  // PrintableBundleStreamMonitor(gather.in, true.B, "in", true)
  // PrintableBundleStreamMonitor(gather.out, true.B, "out", true)

  io.resultsOK := regResultsOK
  io.resultsNotOK := regResultsNotOK

  // performance counters and monitors
  val doMon = io.start & !io.finished
  io.perf.cycles := regCycles
  io.perf.resultsOoO := regNumOutOfOrder
  io.perf.monInds := StreamMonitor(inds.out, doMon, "inds")
  io.perf.monRdReq := StreamMonitor(io.memPort(1).memRdReq, doMon, "rdreq")
  io.perf.monRdRsp := StreamMonitor(io.memPort(1).memRdRsp, doMon, "rdrsp")
}
