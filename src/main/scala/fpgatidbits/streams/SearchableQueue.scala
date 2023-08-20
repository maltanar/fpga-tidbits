package fpgatidbits.streams
import chisel3._

// a content-searchable queue
// mostly a straightforward copy from ChiselUtils Queue; with modifications
// to permit making the content searchable

class SearchableQueueIO[T <: Data](gen: T, n: Int) extends QueueIO(gen, n) {
  val searchVal = gen.cloneType.asInput
  val foundVal = Bool(OUTPUT)

  override def cloneType: this.type = new SearchableQueueIO(gen, n).asInstanceOf[this.type]
}

class SearchableQueue[T <: Data](gen: T, entries: Int) extends Module {
  val io = new SearchableQueueIO(gen, entries)

  // mostly copied from Chisel Queue, with a few modifications:
  // - simplified to pipe = false flow = false
  // - vector of registers instead of Mem, to expose all outputs

  val ram = Vec.fill(entries) { Reg(init = UInt(0, gen.getWidth())) }
  val ramValid = Vec.fill(entries) { Reg(init = false.B) }

  val enq_ptr = Counter(entries)
  val deq_ptr = Counter(entries)
  val maybe_full = Reg(init=false.B)

  val ptr_match = enq_ptr.value === deq_ptr.value
  val empty = ptr_match && !maybe_full
  val full = ptr_match && maybe_full

  val do_enq = io.enq.ready && io.enq.valid
  val do_deq = io.deq.ready && io.deq.valid
  when (do_enq) {
    ram(enq_ptr.value) := io.enq.bits
    ramValid(enq_ptr.value) := true.B
    enq_ptr.inc()
  }
  when (do_deq) {
    ramValid(deq_ptr.value) := false.B
    deq_ptr.inc()
  }
  when (do_enq != do_deq) {
    maybe_full := do_enq
  }

  // <content search logic>
  val newData = io.searchVal
  val hits = Vec.tabulate(entries) {i: Int => ram(i) === newData & ramValid(i)}
  io.foundVal := hits.exists({x:Bool => x})
  // </content search logic>

  io.deq.valid := !empty
  io.enq.ready := !full
  io.deq.bits := ram(deq_ptr.value)

  val ptr_diff = enq_ptr.value - deq_ptr.value
  if (isPow2(entries)) {
    io.count := Cat(maybe_full && ptr_match, ptr_diff)
  } else {
    io.count := Mux(ptr_match,
                  Mux(maybe_full, UInt(entries), 0.U),
                  Mux(deq_ptr.value > enq_ptr.value,
                      UInt(entries) + ptr_diff, ptr_diff)
                    )
  }
}
