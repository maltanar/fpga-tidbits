package fpgatidbits.examples

import chisel3._
import chisel3.util.{Decoupled, DecoupledIO}
import fpgatidbits.PlatformWrapper._
import fpgatidbits.dma._

class ExampleGrayScaleIO(p: PlatformWrapperParams) extends GenericAcceleratorIF(1, p) {
  val start = Input(Bool())
  val finished = Output(Bool())
  val baseAddr = Input(UInt(64.W))
  val byteCount = Input(UInt(32.W))
  val resBaseAddr = Input(UInt(64.W))
  val resByteCount = Input(UInt(32.W))
  val cycleCount = Output(UInt(32.W))
}
// read and sum a contiguous stream of 32-bit uints from main memory
class ExampleGrayScale(p: PlatformWrapperParams) extends GenericAccelerator(p) {
  val numMemPorts = 1
  val io = IO(new ExampleGrayScaleIO(p))
  io.signature := makeDefaultSignature()

  val rdP = new StreamReaderParams(
    streamWidth = 24, fifoElems = 8, mem = p.toMemReqParams(),
    maxBeats = 1, chanID = 0, disableThrottle = true
  )

  val wrP = new StreamWriterParams(
    streamWidth = 8, mem=p.toMemReqParams(), chanID = 0, maxBeats = 1
  )

  val reader = Module(new StreamReader(rdP)).io
  val writer = Module(new StreamWriter(wrP)).io

  reader.start := io.start
  reader.baseAddr := io.baseAddr
  reader.byteCount := io.byteCount
  reader.doInit := false.B
  reader.initCount := 8.U

  writer.start := io.start
  writer.baseAddr := io.resBaseAddr
  writer.byteCount := io.resByteCount

  io.finished := writer.finished

  reader.req <> io.memPort(0).memRdReq
  io.memPort(0).memRdRsp <> reader.rsp
  writer.req <> io.memPort(0).memWrReq
  writer.wdat <> io.memPort(0).memWrDat
  writer.rsp <> io.memPort(0).memWrRsp

  val grayFilter = Module(new GrayScaleFilter)
  grayFilter.rgbIn.valid := reader.out.valid
  grayFilter.rgbIn.bits := reader.out.bits.asTypeOf(new Colour)
  reader.out.ready := grayFilter.rgbIn.ready

  grayFilter.grayOut <> writer.in

  val regCycleCount = RegInit(0.U(32.W))
  io.cycleCount := regCycleCount
  when(!io.start) {regCycleCount := 0.U}
    .elsewhen(io.start & !io.finished) {regCycleCount := regCycleCount + 1.U}
}

class Colour extends Bundle {
  val r = UInt(8.W)
  val g = UInt(8.W)
  val b = UInt(8.W)
}

class GrayScaleFilter extends Module {
  val rgbIn = IO(Flipped(Decoupled(new Colour)))
  val grayOut = IO(Decoupled(UInt(8.W)))

  val s1_valid = RegInit(false.B)
  val s1_r1Shifted = RegInit(0.U(8.W))
  val s1_r2Shifted = RegInit(0.U(8.W))
  val s1_g1Shifted = RegInit(0.U(8.W))
  val s1_g2Shifted = RegInit(0.U(8.W))
  val s1_b1Shifted = RegInit(0.U(8.W))
  val s1_b2Shifted = RegInit(0.U(8.W))

  val s2_valid = RegInit(false.B)
  val s2_gray = RegInit(0.U(8.W))

  rgbIn.ready := !s2_valid || grayOut.fire
  grayOut.valid := s2_valid
  grayOut.bits := s2_gray

  when(rgbIn.fire) {
    // Stage 1
    s1_valid := true.B
    val rgb = rgbIn.bits
    val (r,g,b) = (rgb.r, rgb.g, rgb.b)
    s1_r1Shifted := (r >> 2).asUInt
    s1_r2Shifted := (r >> 5).asUInt
    s1_g1Shifted := (g >> 1).asUInt
    s1_g2Shifted := (g >> 4).asUInt
    s1_b1Shifted := (b >> 4).asUInt
    s1_b2Shifted := (b >> 5).asUInt

    // Stage 2
    s2_valid := s1_valid
    s2_gray := s1_r1Shifted + s1_r2Shifted + s1_g1Shifted + s1_g2Shifted + s1_b1Shifted + s1_b2Shifted
  }
}