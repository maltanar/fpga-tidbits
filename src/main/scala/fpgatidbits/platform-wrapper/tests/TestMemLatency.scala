package fpgatidbits.Testbenches

import chisel3._
import chisel3.util._
import fpgatidbits.PlatformWrapper._
import fpgatidbits.dma._
import fpgatidbits.streams._

// very similar to TestSum, except a StreamReader with configurable # of
// outstanding memory requests is used. by increasing the number of outstanding
// requests in software, the cycles per word should converge to TODO
// (the +TODO is due to inefficiencies in the ReadOrderCache -- needs 2 cycles
// between bursts, so here we need x+2 cycles for x words)

class TestMemLatency(p: PlatformWrapperParams) extends GenericAccelerator(p) {
  val numMemPorts = 1
  val io = new GenericAcceleratorIF(numMemPorts, p) {
    val start = Input(Bool())
    val finished = Output(Bool())
    val baseAddr = Input(UInt(64.W))
    val byteCount = Input(UInt(32.W))
    val sum = Output(UInt(32.W))
    val cycleCount = Output(UInt(32.W))
    // controls for ID pool reinit
    val doInit = Input(Bool())                // pulse this to re-init ID pool
    val initCount = Input(UInt(8.W))  // # IDs to initialize
  }
  io.signature := makeDefaultSignature()
  plugMemWritePort(0)

  val rdP = new StreamReaderParams(
    streamWidth = 64, fifoElems = 8, mem = p.toMemReqParams(),
    maxBeats = 8, chanID = 0,
    disableThrottle = true, // outstanding reqs limits request rate
    readOrderCache = true,  // enable read order cache
    readOrderTxns = 16      // outstanding mem reqs. capped at 16
  )

  val reader = Module(new StreamReader(rdP)).io
  val red = Module(new StreamReducer(64, 0, {_+_})).io

  reader.start := io.start
  reader.baseAddr := io.baseAddr
  reader.byteCount := io.byteCount
  reader.doInit := io.doInit
  reader.initCount := io.initCount

  red.start := io.start
  red.byteCount := io.byteCount

  io.sum := red.reduced
  io.finished := red.finished

  reader.req <> io.memPort(0).memRdReq
  io.memPort(0).memRdRsp <> reader.rsp

  reader.out <> red.streamIn

  val regCycleCount = RegInit(0.U(32.W))
  io.cycleCount := regCycleCount
  when(!io.start) {regCycleCount := 0.U}
  .elsewhen(io.start & !io.finished) {regCycleCount := regCycleCount + 1.U}
}
