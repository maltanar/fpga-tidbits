package TidbitsOCM

import Chisel._
import TidbitsStreams._

// interface definition for multichannel queues
class MultiChanQueueIO[T <: Data](gen: T, chans: Int) extends Bundle {
  val in = Decoupled(gen).flip
  val out = Decoupled(gen)
  val outSel = UInt(INPUT, log2Up(chans))
}

// a super simple multichannel queue implementation: basically a bunch of queues,
// a demuxer at entry (selected by the chanID of the entry head) and a muxer
// at the exit, selected by the outSel signal
class MultiChanQueueSimple[T <: Data](
  gen: T,             // datatype that will be carried in the queues
  chans: Int,         // number of channels
  elemsPerChan: Int,  // number of elements per channel
  getChan: T => UInt  // function that maps carried datatype to the channel ID
) extends Module {
  val io = new MultiChanQueueIO(gen, chans)

  val storage = Vec.fill(chans) {Module(new FPGAQueue(gen, elemsPerChan)).io}
  val entry = DecoupledOutputDemux(getChan(io.in.bits), storage.map(x => x.enq))
  val exit = DecoupledInputMux(io.outSel, storage.map(x => x.deq))

  exit <> io.out
  io.in <> entry
}
