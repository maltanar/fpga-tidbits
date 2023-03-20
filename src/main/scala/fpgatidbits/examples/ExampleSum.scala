package fpgatidbits.examples

import chisel3._
import fpgatidbits.PlatformWrapper._
import fpgatidbits.dma._
import fpgatidbits.streams._


class ExampleSumIO(p: PlatformWrapperParams) extends GenericAcceleratorIF(1, p) {
  val start = Input(Bool())
  val finished = Output(Bool())
  val baseAddr = Input(UInt(64.W))
  val byteCount = Input(UInt(32.W))
  val sum = Output(UInt(32.W))
  val cycleCount = Output(UInt(32.W))
}
// read and sum a contiguous stream of 32-bit uints from main memory
class ExampleSum(p: PlatformWrapperParams) extends GenericAccelerator(p) {
  val numMemPorts = 1
  val io = IO(new ExampleSumIO(p))
  io.signature := makeDefaultSignature()
  plugMemWritePort(0)

  val rdP = new StreamReaderParams(
    streamWidth = 32, fifoElems = 8, mem = p.toMemReqParams(),
    maxBeats = 1, chanID = 0, disableThrottle = true
  )

  val reader = Module(new StreamReader(rdP)).io
  val red = Module(new StreamReducer(32, 0, {_+_})).io

  reader.start := io.start
  reader.baseAddr := io.baseAddr
  reader.byteCount := io.byteCount

  // Added by erlingrj because chisel3 complains they are not initialized
  //  when inspecting verilog output of chisel2 synthesis they are commented out of the
  //  module interface of StreamReader, how?
  reader.doInit := false.B
  reader.initCount := 8.U

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
