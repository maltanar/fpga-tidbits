package fpgatidbits.Testbenches

import Chisel._
import fpgatidbits.PlatformWrapper._
import fpgatidbits.dma._
import fpgatidbits.streams._
import fpgatidbits.ocm._

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
    val perf = new Bundle {
      val cycles = UInt(OUTPUT, 32)
      val monInds = new StreamMonitorOutIF()
      val monRdReq = new StreamMonitorOutIF()
      val monRdRsp = new StreamMonitorOutIF()
      val resultsOoO = UInt(OUTPUT, 32)
    }
  }
  io.signature := makeDefaultSignature()
  val mrp = p.toMemReqParams()
  // plug unused ports (write ports)
  plugMemWritePort(0)
  plugMemWritePort(1)

  // # bits per index, 32-bit integers are generally enough
  val indWidth = 32
  val datWidth = 64
  val bytesPerInd = UInt(indWidth/8)
  val numTxns = 32

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
  val gather = Module(new GatherNBCache_Coalescing(
    lines = 1024, nbMisses = numTxns, elemsPerLine = 8, pipelinedStorage = 0,
    chanBaseID = 0, indWidth = indWidth, datWidth = datWidth,
    tagWidth = indWidth, mrp = mrp, orderRsps = true, coalescePerLine = 8
  )).io

  gather.in.valid := inds.out.valid
  inds.out.ready := gather.in.ready
  // use the incoming stream of indices both as load indices and tags --
  // we'll use the tag to check the loaded value
  gather.in.bits.ind := inds.out.bits
  gather.in.bits.tag := inds.out.bits

  gather.base := io.valsBase

  // wire up the memory system
  inds.req <> io.memPort(0).memRdReq
  io.memPort(0).memRdRsp <> inds.rsp
  io.memPort(1) <> gather

  // examine incoming results from gatherer
  // -- compare against known good value
  val regResultsOK = Reg(init = UInt(0, 32))
  val regResultsNotOK = Reg(init = UInt(0, 32))
  val regTotal = Reg(init = UInt(0, 32))
  val regActive = Reg(init = Bool(false))
  val regCycles = Reg(init = UInt(0, 32))
  val regNumOutOfOrder = Reg(init = UInt(0, 32))

  gather.out.ready := Bool(true)
  io.finished := Bool(false)

  regTotal := regResultsOK + regResultsNotOK

  // keep a copy of all gather requests in the order they arrive,
  // we'll compare them with the gather responses to determine the number of
  // out-of-order responses
  val orderCheckQ = Module(new Queue(gather.in.bits, 2*numTxns)).io
  orderCheckQ.enq.valid := gather.in.valid & gather.in.ready
  orderCheckQ.enq.bits := gather.in.bits
  orderCheckQ.deq.ready := gather.out.ready & gather.out.valid

  when(gather.in.fire() & !orderCheckQ.enq.ready) {
    printf("Error: No space left in orderCheckQ!\n")
  }

  when(!regActive) {
    regResultsOK := UInt(0)
    regResultsNotOK := UInt(0)
    regCycles := UInt(0)
    regNumOutOfOrder := UInt(0)
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
      // increment OoO response counter if appropriate
      when(orderCheckQ.deq.bits.tag != gather.out.bits.tag) {
        printf("Found OoO response at %d, expected %d found %d \n",
          regResultsOK+regResultsNotOK,
          orderCheckQ.deq.bits.tag, gather.out.bits.tag
        )
        regNumOutOfOrder := regNumOutOfOrder + UInt(1)
      }
    }

    when(regTotal === regIndCount) {
      io.finished := Bool(true)
      when(!io.start) {regActive := Bool(false)}
    } .otherwise {
      // still some work to do, keep track of # cycles
      regCycles := regCycles + UInt(1)
    }
  }

  // PrintableBundleStreamMonitor(gather.in, Bool(true), "in", true)
  // PrintableBundleStreamMonitor(gather.out, Bool(true), "out", true)

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
