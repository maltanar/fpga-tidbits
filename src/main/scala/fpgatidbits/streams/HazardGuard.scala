package fpgatidbits.streams
import chisel3._
import chisel3.util._

// a hazard guard, useful for performing interleaved reductions
// with high-latency operators

// the hazard guard keeps a copy of the internal state of the consumer
// (e.g a pipelined operator) to avoid read-after-write hazards (e.g two threads
// with same ID must not be in the reduce pipeline).
// new data is not allowed to enter the consumer until the consumer is ready
// and the hazard has passed

object OperandWithID {
  def apply(op: UInt, id: UInt) = {
    val oid = new OperandWithID(op.getWidth, id.getWidth)
    oid.data := op
    oid.id := id
    oid
  }
}

class OperandWithID(wOp: Int, wId: Int) extends Bundle {
  val data = UInt(wOp.W)
  val id = UInt(wId.W)
  override def clone = {
    new OperandWithID(wOp, wId).asInstanceOf[this.type]
  }
}


// a queue that stores operand-id pairs. each ID in the queue is guaranteed
// to be unique; trying to enqueue an operand-id pair with id already existing
// in the queue will result in a stall (ready will go low)
class UniqueQueue(dataWidth: Int, idWidth: Int, entries: Int) extends Module {
  val io = new Bundle {
    val enq = Flipped(Decoupled(new OperandWithID(dataWidth, idWidth)))
    val deq = Decoupled(new OperandWithID(dataWidth, idWidth))
    val hazard = Output(Bool())
    val count = Output(UInt(log2Ceil(entries+1).W))
  }
  // mostly copied from Chisel Queue, with a few modifications:
  // - vector of registers instead of Mem, to expose all outputs
  // - id values already in the queue not allowed to get in
  val dt = new OperandWithID(dataWidth, idWidth)
  val ram = RegInit(VecInit(Seq.fill(entries)(dt)))
  val ramValid = RegInit(VecInit(Seq.fill(entries)(false.B)))

  val enq_ptr = Counter(entries)
  val deq_ptr = Counter(entries)
  val maybe_full = RegInit(false.B)

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
  when (do_enq =/= do_deq) {
    maybe_full := do_enq
  }

  // <hazard guard logic>
  val newData = io.enq.bits.id
  val hits = VecInit(Seq.tabulate(entries)(i => ram(i).id === newData && ramValid(i)))
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
                  Mux(maybe_full, entries.U, 0.U),
                  Mux(deq_ptr.value > enq_ptr.value,
                      entries.U + ptr_diff, ptr_diff)
                    )
  }
}


// TODO break long combinatorial paths in here - OK to add some latency
class HazardGuard(dataWidth: Int, idWidth: Int, hazardStages: Int) extends Module {
  val io = new Bundle {
    val streamIn = Flipped(Decoupled(new OperandWithID(dataWidth, idWidth)))
    val streamOut = Decoupled(new OperandWithID(dataWidth, idWidth))
    val hazardStalls = Output(UInt(32.W))
    val hazardHits = Output(UInt(hazardStages.W))
  }
  // extra bit in each stage to indicate a valid entry (bit 0)
  val stages = RegInit(VecInit(Seq.fill(hazardStages)(0.U((idWidth+1).W))))

  val hazardCandidate = io.streamIn.bits.id

  val hits = Cat(stages.map({x:UInt => x(0) & (x(idWidth, 1) === hazardCandidate)}))
  val hazardDetected = hits.orR
  io.hazardHits := hits

  val downstreamReady = io.streamOut.ready
  val upstreamValid  = io.streamIn.valid

  io.streamIn.ready := downstreamReady & !hazardDetected
  io.streamOut.valid := upstreamValid & !hazardDetected
  io.streamOut.bits := io.streamIn.bits

  when(downstreamReady) {
    stages(0) := Mux(hazardDetected, 0.U, Cat(io.streamIn.bits.id, io.streamIn.valid))
    for(i <- 1 until hazardStages) {
      stages(i) := stages(i-1)
    }
  }

  // generate statistics
  val regHazardStalls = RegInit(0.U(32.W))
  io.hazardStalls := regHazardStalls
  when (downstreamReady & upstreamValid & hazardDetected) {
    regHazardStalls := regHazardStalls + 1.U
  }

}
