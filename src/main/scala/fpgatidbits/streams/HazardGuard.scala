package fpgatidbits.streams
import Chisel._

// a hazard guard, useful for performing interleaved reductions
// with high-latency operators

// the hazard guard keeps a copy of the internal state of the consumer
// (e.g a pipelined operator) to avoid read-after-write hazards (e.g two threads
// with same ID must not be in the reduce pipeline).
// new data is not allowed to enter the consumer until the consumer is ready
// and the hazard has passed

object OperandWithID {
  def apply(op: UInt, id: UInt) = {
    val oid = new OperandWithID(op.getWidth(), id.getWidth())
    oid.data := op
    oid.id := id
    oid
  }
}

class OperandWithID(wOp: Int, wId: Int) extends Bundle {
  val data = UInt(width = wOp)
  val id = UInt(width = wId)
  override def clone = {
    new OperandWithID(wOp, wId).asInstanceOf[this.type]
  }
}


// a queue that stores operand-id pairs. each ID in the queue is guaranteed
// to be unique; trying to enqueue an operand-id pair with id already existing
// in the queue will result in a stall (ready will go low)
class UniqueQueue(dataWidth: Int, idWidth: Int, entries: Int) extends Module {
  val io = new Bundle {
    val enq = Decoupled(new OperandWithID(dataWidth, idWidth)).flip
    val deq = Decoupled(new OperandWithID(dataWidth, idWidth))
    val hazard = Bool(OUTPUT)
    val count = UInt(OUTPUT, width = log2Up(entries+1))
  }
  // mostly copied from Chisel Queue, with a few modifications:
  // - vector of registers instead of Mem, to expose all outputs
  // - id values already in the queue not allowed to get in
  val dt = new OperandWithID(dataWidth, idWidth)
  val ram = Vec.fill(entries) { Reg(init = dt) }
  val ramValid = Vec.fill(entries) { Reg(init = Bool(false)) }

  val enq_ptr = Counter(entries)
  val deq_ptr = Counter(entries)
  val maybe_full = Reg(init=Bool(false))

  val ptr_match = enq_ptr.value === deq_ptr.value
  val empty = ptr_match && !maybe_full
  val full = ptr_match && maybe_full

  val do_enq = io.enq.ready && io.enq.valid
  val do_deq = io.deq.ready && io.deq.valid
  when (do_enq) {
    ram(enq_ptr.value) := io.enq.bits
    ramValid(enq_ptr.value) := Bool(true)
    enq_ptr.inc()
  }
  when (do_deq) {
    ramValid(deq_ptr.value) := Bool(false)
    deq_ptr.inc()
  }
  when (do_enq != do_deq) {
    maybe_full := do_enq
  }

  // <hazard guard logic>
  val newData = io.enq.bits.id
  val hits = Vec.tabulate(entries) {i: Int => ram(i).id === newData & ramValid(i)}
  val hazardDetected = hits.exists({x:Bool => x}) & io.enq.valid
  io.hazard := hazardDetected
  // </hazard guard logic>

  io.deq.valid := !empty
  io.enq.ready := !full & !hazardDetected
  io.deq.bits := ram(deq_ptr.value)

  val ptr_diff = enq_ptr.value - deq_ptr.value
  if (isPow2(entries)) {
    io.count := Cat(maybe_full && ptr_match, ptr_diff)
  } else {
    io.count := Mux(ptr_match,
                  Mux(maybe_full, UInt(entries), UInt(0)),
                  Mux(deq_ptr.value > enq_ptr.value,
                      UInt(entries) + ptr_diff, ptr_diff)
                    )
  }
}


// TODO break long combinatorial paths in here - OK to add some latency
class HazardGuard(dataWidth: Int, idWidth: Int, hazardStages: Int) extends Module {
  val io = new Bundle {
    val streamIn = Decoupled(new OperandWithID(dataWidth, idWidth)).flip
    val streamOut = Decoupled(new OperandWithID(dataWidth, idWidth))
    val hazardStalls = UInt(OUTPUT, width = 32)
    val hazardHits = UInt(OUTPUT, width = hazardStages)
  }
  // extra bit in each stage to indicate a valid entry (bit 0)
  val stages = Vec.fill(hazardStages) { Reg(init=UInt(0, width=idWidth+1)) }

  val hazardCandidate = io.streamIn.bits.id

  val hits = UInt(Cat(stages.map({x:UInt => x(0) & (x(idWidth, 1) === hazardCandidate)})))
  val hazardDetected = orR(hits)
  io.hazardHits := hits

  val downstreamReady = io.streamOut.ready
  val upstreamValid  = io.streamIn.valid

  io.streamIn.ready := downstreamReady & !hazardDetected
  io.streamOut.valid := upstreamValid & !hazardDetected
  io.streamOut.bits := io.streamIn.bits

  when(downstreamReady) {
    stages(0) := Mux(hazardDetected, UInt(0), Cat(io.streamIn.bits.id, io.streamIn.valid))
    for(i <- 1 until hazardStages) {
      stages(i) := stages(i-1)
    }
  }

  // generate statistics
  val regHazardStalls = Reg(init = UInt(0, 32))
  io.hazardStalls := regHazardStalls
  when (downstreamReady & upstreamValid & hazardDetected) {
    regHazardStalls := regHazardStalls + UInt(1)
  }

}
