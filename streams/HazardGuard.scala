package TidbitsStreams
import Chisel._

// a hazard guard, useful for performing interleaved reductions
// with high-latency operators

// the hazard guard keeps a copy of the internal state of the consumer
// (e.g a pipelined operator) to avoid read-after-write hazards (e.g two threads
// with same ID must not be in the reduce pipeline).
// new data is not allowed to enter the consumer until the consumer is ready
// and the hazard has passed

class HazardGuard(dataWidth: Int, hazardStages: Int) extends Module {
  val io = new Bundle {
    val streamIn = Decoupled(UInt(width = dataWidth)).flip
    val streamOut = Decoupled(UInt(width = dataWidth))
    val hazardStalls = UInt(OUTPUT, width = 32)
  }
  // extra bit in each stage to indicate a valid entry (bit 0)
  val stages = Vec.fill(hazardStages) { Reg(init=UInt(0, dataWidth+1)) }

  val hazardCandidate = io.streamIn.bits

  val hazardDetected = stages.exists({x:UInt => x(0) & (x(dataWidth, 1) === hazardCandidate)})

  val downstreamReady = io.streamOut.ready
  val upstreamValid  = io.streamIn.valid

  io.streamIn.ready := downstreamReady & !hazardDetected
  io.streamOut.valid := upstreamValid & !hazardDetected
  io.streamOut.bits := io.streamIn.bits

  when(downstreamReady) {
    stages(0) := Cat(io.streamIn.bits, io.streamIn.valid)
    for(i <- 1 until hazardStages) {
      stages(i) := stages(i-1)
    }
  }

  // generate statistics
  val regHazardStalls = Reg(init = UInt(0, 32))
  when (downstreamReady & hazardDetected) {
    regHazardStalls := regHazardStalls + UInt(1)
  }

}
