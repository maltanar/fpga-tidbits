package fpgatidbits.ocm

//import chisel3._
import chisel3.util._
import chisel3._
import chisel3.util._

class Q_srl(depthElems: Int, widthBits: Int) extends BlackBox(Map( "depth" -> depthElems, "width" -> widthBits))
{
    val io = IO(new Bundle {
      val i_v = Input(Bool())
      val i_d = Input(UInt(widthBits.W))
      val i_b = Output(Bool())
      val o_v = Output(Bool())
      val o_d = Output(UInt(widthBits.W))
      val o_b = Input(Bool())
      val count = Output(UInt(log2Ceil(depthElems+1).W))
      val clock = Input(Clock())
      val reset = Input(Reset())

      /*
      val iValid = Input(Bool()).suggestName("i_v")
      val iData = Input(UInt(widthBits.W)).suggestName("i_d")
      val iBackPressure = Output(Bool()).suggestName("i_b")
      val oValid = Output(Bool()).suggestName("o_v")
      val oData = Output(UInt(widthBits.W)).suggestName("o_d")
      val oBackPressure = Input(Bool()).suggestName("o_b")
      val count = Output(UInt(log2Ceil(depthElems+1).W)).suggestName("count")
      val clock = Input(Clock())
      val reset = Input(Reset())

      iValid.suggestName("i_v")
      iData.suggestName("i_d")
      iBackPressure.suggestName("i_b")
      oValid.suggestName("o_v")
      oData.suggestName("o_d")
      oBackPressure.suggestName("o_b")
      count.suggestName("count")
    */

    })



  // the clock/reset does not get added to the BlackBox interface by default
  // add clock and reset, rename as needed
  //addClock(Driver.implicitClock)
  //renameClock(Driver.implicitClock, "clock")
  //addResetPin(Driver.implicitReset)

  // TODO add a proper simulation model -- for now we just instantiate a
  // regular Chisel Queue as mock SRL queue "behavioral model"

  /*
  val mockQ = Module(new Queue(UInt(), depthElems)).io
  io.count := mockQ.count
  mockQ.enq.valid := io.iValid
  mockQ.enq.bits := io.iData
  io.oData := mockQ.deq.bits
  io.oValid := mockQ.deq.valid
  // ready signals connected to backpressure and vice versa
  io.iBackPressure := !mockQ.enq.ready
  mockQ.deq.ready := !io.oBackPressure
*/
}


class SRLQueue[T <: Data](gen: T, val entries: Int) extends Module {
  val io = IO(new QueueIO(gen, entries))
  val srlQ = Module(new Q_srl(entries, gen.getWidth)).io

  io.count := srlQ.count
  srlQ.i_v := io.enq.valid
  srlQ.i_d := io.enq.bits.asUInt
  srlQ.clock := clock
  srlQ.reset := reset

  io.deq.valid := srlQ.o_v
  io.deq.bits := srlQ.o_d.asTypeOf(io.deq.bits)
  // Q_srl uses backpressure, while Chisel queues use "ready"
  // invert signals while connecting
  srlQ.o_b := !io.deq.ready
  io.enq.ready := !srlQ.i_b
}


class BRAMQueue[T <: Data](gen: T, val entries: Int) extends Module {
  val io = IO(new QueueIO(gen, entries))

  // create a big queue that will use FPGA BRAMs as storage
  // the source code here is mostly copy-pasted from the regular Chisel
  // Queue, but with DualPortBRAM as the data storage
  // some simplifications has been applied, since pipe = false and
  // flow = false (no comb. paths between prod/cons read/valid signals)

  val enq_ptr = Counter(entries)
  val deq_ptr = Counter(entries)
  val maybe_full = RegInit(false.B)

  // due to the 1-cycle read latency of BRAMs, we add a small regular
  // SRLQueue at the output to correct the interface semantics by
  // "prefetching" the top two elements ("handshaking across latency")
  // TODO support higher BRAM latencies with parametrization here
  val readLatency = 1
  val pf = Module(new FPGAQueue(gen, readLatency + 2)).io
  // will be used as the "ready" signal for the prefetch queue
  // the threshold here needs to be (pfQueueCap-BRAM latency)
  val canPrefetch = (pf.count < 2.U)

  val bramExt = Module(new DualPortBRAM(log2Up(entries), gen.getWidth)).io
  val bram = Wire(new DualPortBRAMIOWrapper(log2Up(entries), gen.getWidth))
  bramExt.clk := clock
  bramExt.a.connect(bram.ports(0))
  bramExt.b.connect(bram.ports(1))

  val writePort = bram.ports(0)
  val readPort = bram.ports(1)
  writePort.req.writeData := io.enq.bits
  writePort.req.writeEn := false.B
  writePort.req.addr := enq_ptr.value

  readPort.req.writeData := 0.U
  readPort.req.writeEn := false.B
  readPort.req.addr := deq_ptr.value

  val ptr_match = enq_ptr.value === deq_ptr.value
  val empty = ptr_match && !maybe_full
  val full = ptr_match && maybe_full

  val do_enq = io.enq.ready && io.enq.valid
  val do_deq = canPrefetch && !empty
  when (do_enq) {
    writePort.req.writeEn := true.B
    enq_ptr.inc()
  }
  when (do_deq) {
    deq_ptr.inc()
  }
  when (do_enq =/= do_deq) {
    maybe_full := do_enq
  }

  io.enq.ready := !full

  //pf.enq.valid := Reg(init = false.B, next = do_deq)
  pf.enq.valid := RegInit(false.B)
  pf.enq.valid := do_deq
  pf.enq.bits := readPort.rsp.readData.asTypeOf(pf.enq.bits)

  pf.deq <> io.deq

  // TODO this count may be off by 1 (elem about to enter the pf queue)
  val ptr_diff = enq_ptr.value - deq_ptr.value
  if (isPow2(entries)) {
    io.count := Cat(maybe_full && ptr_match, ptr_diff) + pf.count
  } else {
    io.count := Mux(ptr_match,
                    Mux(maybe_full,
                      entries.U, 0.U),
                    Mux(deq_ptr.value > enq_ptr.value,
                      entries.U + ptr_diff, ptr_diff)) + pf.count
  }
}


// creates a queue either using standard Chisel queues (for smaller queues)
// or with FPGA TDP BRAMs as the storage (for larger queues)
class FPGAQueue[T <: Data](gen: T, val entries: Int) extends Module {
  val thresholdBigQueue = 64 // threshold for deciding big or small queue impl
  val io = IO(new QueueIO(gen, entries))
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
