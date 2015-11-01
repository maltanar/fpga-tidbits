package TidbitsOCM

import Chisel._

// creates a queue either using standard Chisel queues (for smaller queues)
// or with FPGA TDP BRAMs as the storage (for larger queues)

class FPGAQueue[T <: Data](gen: T, val entries: Int) extends Module {
  val io = new QueueIO(gen, entries)
  if(entries < 32) {
    // create a regular Chisel queue, should be fine to use LUTRAMs as storage
    val theQueue = Module(new Queue(gen, entries)).io
    theQueue <> io
  } else {
    // create a big queue that will use FPGA BRAMs as storage
    // the source code here is mostly copy-pasted from the regular Chisel
    // Queue, but with DualPortBRAM as the data storage
    // some simplifications has been applied, since pipe = false and
    // flow = false (no comb. paths between prod/cons read/valid signals)

    val enq_ptr = Counter(entries)
    val deq_ptr = Counter(entries)
    val maybe_full = Reg(init=Bool(false))

    val bram = Module(new DualPortBRAM(log2Up(entries), gen.getWidth())).io
    val writePort = bram.ports(0)
    val readPort = bram.ports(1)
    writePort.req.writeData := io.enq.bits
    writePort.req.writeEn := Bool(false)
    writePort.req.addr := enq_ptr.value

    readPort.req.writeData := UInt(0)
    readPort.req.writeEn := Bool(false)
    readPort.req.addr := deq_ptr.value

    val ptr_match = enq_ptr.value === deq_ptr.value
    val empty = ptr_match && !maybe_full
    val full = ptr_match && maybe_full

    val do_enq = io.enq.ready && io.enq.valid
    val do_deq = io.deq.ready && io.deq.valid
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

    io.deq.valid := !empty
    io.enq.ready := !full
    io.deq.bits := readPort.rsp.readData

    val ptr_diff = enq_ptr.value - deq_ptr.value
    if (isPow2(entries)) {
      io.count := Cat(maybe_full && ptr_match, ptr_diff)
    } else {
      io.count := Mux(ptr_match,
                      Mux(maybe_full,
                        UInt(entries), UInt(0)),
                      Mux(deq_ptr.value > enq_ptr.value,
                        UInt(entries) + ptr_diff, ptr_diff))
    }
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
