package fpgatidbits.ocm

import chisel3._
import chisel3.util._
import fpgatidbits.streams._

// interface definition for multichannel queues
class MultiChanQueueIO[T <: Data](gen: T, chans: Int) extends Bundle {
  val in = Flipped(Decoupled(gen))
  val out = Decoupled(gen)
  val outSel = Input(UInt(log2Ceil(chans).W))

  override def cloneType: this.type =
    new MultiChanQueueIO(gen, chans).asInstanceOf[this.type]
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
  val io = IO(new MultiChanQueueIO(gen, chans))

  val storage = VecInit(Seq.fill(chans) {Module(new FPGAQueue(gen, elemsPerChan)).io})
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
  val io = IO(new MultiChanQueueIO(gen, chans))

  val bramWidthBits = gen.getWidth
  val bramDepth = chans * elemsPerChan
  val bramAddrBits = log2Up(bramDepth)

  if(!isPow2(elemsPerChan))
    throw new Exception("Elements per channel must be power of 2")

  val ctrBits = log2Up(elemsPerChan)

  val storage = Module(new DualPortBRAM(bramAddrBits, bramWidthBits)).io

  val vec_enq_ptr = RegInit(VecInit(Seq.fill(chans) {0.U(ctrBits.W)}))
  val vec_deq_ptr = RegInit(VecInit(Seq.fill(chans) {0.U(ctrBits.W)}))
  val vec_maybe_full = RegInit(VecInit(Seq.fill(chans) {false.B}))
  val vec_ptr_match = (vec_enq_ptr zip vec_deq_ptr).map({ case(l,r) => l === r})


  val enqChan = getChan(io.in.bits)
  val deqChan = io.outSel
  val simEnqDeq = (enqChan === deqChan)

  val enq_ptr = vec_enq_ptr(enqChan)
  val deq_ptr = vec_deq_ptr(deqChan)

  val enq_offs = enqChan * (elemsPerChan).U
  val deq_offs = deqChan * (elemsPerChan).U

  // the rest is adapted from BRAMQueue (see FPGAQueue.scala)

  // due to the 1-cycle read latency of BRAMs, we add a small regular
  // SRLQueue at the output to correct the interface semantics by
  // "prefetching" the top two elements ("handshaking across latency")
  val readLatency = 1
  val pf = Module(new FPGAQueue(gen, readLatency + 2)).io

  // will be used as the "ready" signal for the prefetch queue
  // the threshold here needs to be (pfQueueCap-BRAM latency)
  val canPrefetch = (pf.count < 2.U)


  val writePort = storage.ports(0)
  val readPort = storage.ports(1)
  writePort.req.writeData := io.in.bits
  writePort.req.writeEn := false.B
  writePort.req.addr := enq_ptr + enq_offs

  readPort.req.writeData := 0.U
  readPort.req.writeEn := false.B
  readPort.req.addr := deq_ptr + deq_offs

  val ptr_match_enq = false.B
  val ptr_match_deq = false.B
  for (i <- 0 until chans) {
    when(i.U === enqChan) {
      ptr_match_enq := vec_ptr_match(i)
    }
    when (i.U === deqChan) {
      ptr_match_deq := vec_ptr_match(i)
    }
  }


  val maybe_full_enq = vec_maybe_full(enqChan)
  val maybe_full_deq = vec_maybe_full(deqChan)

  val empty = ptr_match_deq && !maybe_full_deq
  val full = ptr_match_enq && maybe_full_enq

  val do_enq = io.in.ready && io.in.valid
  val do_deq = canPrefetch && !empty && io.out.ready

  // update maybe_full regs for each channel
  val vec_do_enq = Mux(do_enq, UIntToOH(enqChan, chans), 0.U)
  val vec_do_deq = Mux(do_deq, UIntToOH(deqChan, chans), 0.U)

  for(i <- 0 until chans) {
    when(vec_do_enq(i) =/= vec_do_deq(i)) {
      vec_maybe_full(i) := vec_do_enq(i)
    }
  }

  when (do_enq) {
    writePort.req.writeEn := true.B
    enq_ptr := enq_ptr + 1.U
  }
  when (do_deq) {
    deq_ptr := deq_ptr + 1.U
  }

  io.in.ready := !full

  pf.enq.valid := RegNext(next = do_deq, init = false.B)
  pf.enq.bits := readPort.rsp.readData

  pf.deq <> io.out
}
