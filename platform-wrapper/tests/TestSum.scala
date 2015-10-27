package TidbitsTestbenches

import Chisel._
import TidbitsPlatformWrapper._
import TidbitsDMA._
import TidbitsStreams._

class TestSum(p: PlatformWrapperParams) extends GenericAccelerator(p) {
  val numMemPorts = 1
  val io = new GenericAcceleratorIF(numMemPorts, p) {
    val start = Bool(INPUT)
    val finished = Bool(OUTPUT)
    val baseAddr = UInt(INPUT, width = 32)
    val byteCount = UInt(INPUT, width = 32)
    val sum = UInt(OUTPUT, width = 32)
  }
  io.signature := makeDefaultSignature()

  val rg = Module(new ReadReqGen(p.toMemReqParams(), 0, 1)).io
  val red = Module(new StreamReducer(32, 0, {_+_})).io

  rg.ctrl.start := io.start
  rg.ctrl.throttle := Bool(false)
  rg.ctrl.baseAddr := io.baseAddr
  rg.ctrl.byteCount := io.byteCount

  red.start := io.start
  red.byteCount := io.byteCount

  io.sum := red.reduced
  io.finished := red.finished

  rg.reqs <> io.memPort(0).memRdReq

  val readStream = ReadRespFilter(io.memPort(0).memRdRsp)

  if(p.memDataBits > 32) {
    // use a downsizer
    red.streamIn <> StreamDownsizer(readStream, 32)
  } else if(p.memDataBits == 32) {
    // connect memory read responses directly to reducer
    red.streamIn <> readStream
  } else throw new Exception("Sub-32 bit data buses not supported")

}
