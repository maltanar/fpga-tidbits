package TidbitsStreams
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
