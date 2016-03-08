package fpgatidbits.ocm

import Chisel._
import fpgatidbits.streams._

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


// variant of MultiChanQueue that uses a single BRAM for storage, sharing it
// equally among a number of FIFO channels. quite a bit less LUTRAM and
// LUTs in exchange for a BRAM, if the chans*elemsPerChan is large.
class MultiChanQueueBRAM[T <: Data](
  gen: T,             // datatype that will be carried in the queues
  chans: Int,         // number of channels
  elemsPerChan: Int,  // number of elements per channel
  getChan: T => UInt  // function that maps carried datatype to the channel ID
) extends Module {
  val io = new MultiChanQueueIO(gen, chans)

  val bramWidthBits = gen.getWidth()
  val bramDepth = chans * elemsPerChan
  val bramAddrBits = log2Up(bramDepth)

  if(!isPow2(elemsPerChan))
    throw new Exception("Elements per channel must be power of 2")

  val ctrBits = log2Up(elemsPerChan)

  val storage = Module(new DualPortBRAM(bramAddrBits, bramWidthBits)).io

  val vec_enq_ptr = Vec.fill(chans) {Reg(init=UInt(0, ctrBits))}
  val vec_deq_ptr = Vec.fill(chans) {Reg(init=UInt(0, ctrBits))}
  val vec_maybe_full = Vec.fill(chans) {Reg(init=Bool(false))}
  val vec_ptr_match = Vec.tabulate(chans) {
    i: Int => vec_enq_ptr(i) === vec_deq_ptr(i)
  }

  val enqChan = getChan(io.in.bits)
  val deqChan = io.outSel
  val simEnqDeq = (enqChan === deqChan)

  val enq_ptr = vec_enq_ptr(enqChan)
  val deq_ptr = vec_deq_ptr(deqChan)

  val enq_offs = enqChan * UInt(elemsPerChan)
  val deq_offs = deqChan * UInt(elemsPerChan)

  // the rest is adapted from BRAMQueue (see FPGAQueue.scala)

  // due to the 1-cycle read latency of BRAMs, we add a small regular
  // SRLQueue at the output to correct the interface semantics by
  // "prefetching" the top two elements ("handshaking across latency")
  val readLatency = 1
  val pf = Module(new FPGAQueue(gen, readLatency + 2)).io

  // will be used as the "ready" signal for the prefetch queue
  // the threshold here needs to be (pfQueueCap-BRAM latency)
  val canPrefetch = (pf.count < UInt(2))


  val writePort = storage.ports(0)
  val readPort = storage.ports(1)
  writePort.req.writeData := io.in.bits.toBits
  writePort.req.writeEn := Bool(false)
  writePort.req.addr := enq_ptr + enq_offs

  readPort.req.writeData := UInt(0)
  readPort.req.writeEn := Bool(false)
  readPort.req.addr := deq_ptr + deq_offs

  val ptr_match_enq = vec_ptr_match(enqChan)
  val maybe_full_enq = vec_maybe_full(enqChan)
  val ptr_match_deq = vec_ptr_match(deqChan)
  val maybe_full_deq = vec_maybe_full(deqChan)

  val empty = ptr_match_deq && !maybe_full_deq
  val full = ptr_match_enq && maybe_full_enq

  val do_enq = io.in.ready && io.in.valid
  val do_deq = canPrefetch && !empty && io.out.ready

  // update maybe_full regs for each channel
  val vec_do_enq = Mux(do_enq, UIntToOH(enqChan, chans), UInt(0))
  val vec_do_deq = Mux(do_deq, UIntToOH(deqChan, chans), UInt(0))

  for(i <- 0 until chans) {
    when(vec_do_enq(i) != vec_do_deq(i)) {
      vec_maybe_full(i) := vec_do_enq(i)
    }
  }

  when (do_enq) {
    writePort.req.writeEn := Bool(true)
    enq_ptr := enq_ptr + UInt(1)
  }
  when (do_deq) {
    deq_ptr := deq_ptr + UInt(1)
  }

  io.in.ready := !full

  pf.enq.valid := Reg(init = Bool(false), next = do_deq)
  pf.enq.bits := pf.enq.bits.fromBits(readPort.rsp.readData)

  pf.deq <> io.out
}
