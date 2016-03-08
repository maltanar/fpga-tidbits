package fpgatidbits.streams

import Chisel._

// interleaves <numSources> input streams onto a single output stream,
// currently just a wrapper for a round-robin arbiter, may eventually
// add some fancier variants and statistics/counting
class StreamInterleaver[T <: Data](numSources: Int, gen: T) extends Module {
  val io = new Bundle {
    val in = Vec.fill(numSources) {Decoupled(gen).flip}
    val out = Decoupled(gen)
  }

  val arb = Module(new RRArbiter(gen, n=numSources)).io
  for (i <- 0 until numSources) {
    arb.in(i) <> io.in(i)
  }
  arb.out <> io.out
}
