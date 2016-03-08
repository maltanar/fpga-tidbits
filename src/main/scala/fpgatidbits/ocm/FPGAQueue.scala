package fpgatidbits.ocm

import Chisel._

class Q_srl(depthElems: Int, widthBits: Int) extends BlackBox {
  val io = new Bundle {
    val iValid = Bool(INPUT)
    val iData = UInt(INPUT, width = widthBits)
    val iBackPressure = Bool(OUTPUT)
    val oValid = Bool(OUTPUT)
    val oData = UInt(OUTPUT, width = widthBits)
    val oBackPressure = Bool(INPUT)
    val count = UInt(OUTPUT, width = log2Up(depthElems+1))

    iValid.setName("i_v")
    iData.setName("i_d")
    iBackPressure.setName("i_b")
    oValid.setName("o_v")
    oData.setName("o_d")
    oBackPressure.setName("o_b")
    count.setName("count")
  }

  setVerilogParameters(new VerilogParameters {
    val depth = depthElems
    val width = widthBits
  })

  // the clock/reset does not get added to the BlackBox interface by default
  // add clock and reset, rename as needed
  addClock(Driver.implicitClock)
  renameClock(Driver.implicitClock, "clock")
  addResetPin(Driver.implicitReset)

  // TODO add a proper simulation model -- for now we just instantiate a
  // regular Chisel Queue as mock SRL queue "behavioral model"
  val mockQ = Module(new Queue(UInt(width = widthBits), depthElems)).io
  io.count := mockQ.count
  mockQ.enq.valid := io.iValid
  mockQ.enq.bits := io.iData
  io.oData := mockQ.deq.bits
  io.oValid := mockQ.deq.valid
  // ready signals connected to backpressure and vice versa
  io.iBackPressure := !mockQ.enq.ready
  mockQ.deq.ready := !io.oBackPressure
}

class SRLQueue[T <: Data](gen: T, val entries: Int) extends Module {
  val io = new QueueIO(gen, entries)
  val srlQ = Module(new Q_srl(entries, gen.getWidth())).io

  io.count := srlQ.count
  srlQ.iValid := io.enq.valid
  srlQ.iData := io.enq.bits.toBits
  io.deq.valid := srlQ.oValid
  io.deq.bits := io.deq.bits.fromBits(srlQ.oData)
  // Q_srl uses backpressure, while Chisel queues use "ready"
  // invert signals while connecting
  srlQ.oBackPressure := !io.deq.ready
  io.enq.ready := !srlQ.iBackPressure
}


class BRAMQueue[T <: Data](gen: T, val entries: Int) extends Module {
  val io = new QueueIO(gen, entries)

  // create a big queue that will use FPGA BRAMs as storage
  // the source code here is mostly copy-pasted from the regular Chisel
  // Queue, but with DualPortBRAM as the data storage
  // some simplifications has been applied, since pipe = false and
  // flow = false (no comb. paths between prod/cons read/valid signals)

  val enq_ptr = Counter(entries)
  val deq_ptr = Counter(entries)
  val maybe_full = Reg(init=Bool(false))

  // due to the 1-cycle read latency of BRAMs, we add a small regular
  // SRLQueue at the output to correct the interface semantics by
  // "prefetching" the top two elements ("handshaking across latency")
  // TODO support higher BRAM latencies with parametrization here
  val readLatency = 1
  val pf = Module(new FPGAQueue(gen, readLatency + 2)).io
  // will be used as the "ready" signal for the prefetch queue
  // the threshold here needs to be (pfQueueCap-BRAM latency)
  val canPrefetch = (pf.count < UInt(2))

  val bram = Module(new DualPortBRAM(log2Up(entries), gen.getWidth())).io
  val writePort = bram.ports(0)
  val readPort = bram.ports(1)
  writePort.req.writeData := io.enq.bits.toBits
  writePort.req.writeEn := Bool(false)
  writePort.req.addr := enq_ptr.value

  readPort.req.writeData := UInt(0)
  readPort.req.writeEn := Bool(false)
  readPort.req.addr := deq_ptr.value

  val ptr_match = enq_ptr.value === deq_ptr.value
  val empty = ptr_match && !maybe_full
  val full = ptr_match && maybe_full

  val do_enq = io.enq.ready && io.enq.valid
  val do_deq = canPrefetch && !empty
  when (do_enq) {
    writePort.req.writeEn := Bool(true)
    enq_ptr.inc()
  }
  when (do_deq) {
    deq_ptr.inc()
  }
  when (do_enq != do_deq) {
    maybe_full := do_enq
  }

  io.enq.ready := !full

  pf.enq.valid := Reg(init = Bool(false), next = do_deq)
  pf.enq.bits := pf.enq.bits.fromBits(readPort.rsp.readData)

  pf.deq <> io.deq

  // TODO this count may be off by 1 (elem about to enter the pf queue)
  val ptr_diff = enq_ptr.value - deq_ptr.value
  if (isPow2(entries)) {
    io.count := Cat(maybe_full && ptr_match, ptr_diff) + pf.count
  } else {
    io.count := Mux(ptr_match,
                    Mux(maybe_full,
                      UInt(entries), UInt(0)),
                    Mux(deq_ptr.value > enq_ptr.value,
                      UInt(entries) + ptr_diff, ptr_diff)) + pf.count
  }
}


// creates a queue either using standard Chisel queues (for smaller queues)
// or with FPGA TDP BRAMs as the storage (for larger queues)
class FPGAQueue[T <: Data](gen: T, val entries: Int) extends Module {
  val thresholdBigQueue = 64 // threshold for deciding big or small queue impl
  val io = new QueueIO(gen, entries)
  if(entries < thresholdBigQueue) {
    // create a shift register (SRL)-based queue
    val theQueue = Module(new SRLQueue(gen, entries)).io
    theQueue <> io
  } else {
    // create a BRAM queue
    val theQueue = Module(new BRAMQueue(gen, entries)).io
    theQueue <> io
  }
}

object FPGAQueue
{
  def apply[T <: Data](enq: DecoupledIO[T], entries: Int = 2): DecoupledIO[T]  = {
    val q = Module(new FPGAQueue(enq.bits.cloneType, entries))
    q.io.enq.valid := enq.valid // not using <> so that override is allowed
    q.io.enq.bits := enq.bits
    enq.ready := q.io.enq.ready
    q.io.deq
  }
}
