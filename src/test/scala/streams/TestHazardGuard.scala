package TidbitsTestbenches

import Chisel._
import fpgatidbits.streams._


// set up a test scenario for the HazardGuard: a circuit with a high-latency
// adder and memory (with its own latency) for context save/restores
// the harness contains big FIFOs that should be filled with the test inputs
// prior to setting io.enable = 1

class HazardGuardTestParams(rS: Int, rL: Int, wL: Int, t: Int, w: Int) {
  val reducerStages = rS
  val readLatency = rL
  val writeLatency = wL
  val threadCount = t
  val dataWidth = w
  val threadIDWidth = log2Up(threadCount)
}

class HazardGuardTestHarness(p: HazardGuardTestParams) extends Module {
  val opType = new OperandWithID(p.dataWidth, p.threadIDWidth)
  val io = new Bundle {
    val enable = Bool(INPUT)
    val writeCount = UInt(OUTPUT, width = 32)
    val readCount = UInt(OUTPUT, width = 32)
    val testInData = Decoupled(opType).flip
    val threadOutputs = Vec.fill(p.threadCount) {UInt(OUTPUT, width = p.dataWidth)}
  }

  // internal queues with large capacity for storing test inputs
  val testQueueData = Module(new Queue(opType, 1024)).io
  testQueueData.enq <> io.testInData

  // instantiate the hazard guard
  // depending on how the RAM handles read-write to same address simultaneously,
  // this can be less
  val hazardStages = p.reducerStages + p.readLatency + p.writeLatency
  val guard = Module(new HazardGuard(p.dataWidth, p.threadIDWidth, hazardStages))
  guard.io.streamIn <> testQueueData.deq

  //val idSource = testQueueID.deq
  val idSource = guard.io.streamOut

  // memory for context save and restore
  val mem = Mem(UInt(width = p.dataWidth), p.threadCount)
  // connect threadOutputs to memory
  for(i <- 0 until p.threadCount) {
    io.threadOutputs(i) := mem(i)
  }

  val memReadAddr = UInt(width = p.threadIDWidth)
  val memReadEn = Bool()
  val memReadOutData = ShiftRegister(mem(memReadAddr), p.readLatency)
  val memReadOutValid = ShiftRegister(memReadEn, p.readLatency)
  val memReadOutID = ShiftRegister(memReadAddr, p.readLatency)

  val memWriteAddr = UInt(width = p.threadIDWidth)
  val memWriteEn = Bool()
  val memWriteData = UInt( width = p.dataWidth)

  // writes have always at least 1 cycle latency, hence we subtract 1
  // from the shift reg latency here
  val memWriteRegAddr = ShiftRegister(memWriteAddr, p.writeLatency-1)
  val memWriteRegEn = ShiftRegister(memWriteEn, p.writeLatency-1)
  val memWriteRegData = ShiftRegister(memWriteData, p.writeLatency-1)

  val regWriteCount = Reg(init = UInt(0, 32))
  io.writeCount := regWriteCount
  when (memWriteRegEn) {
    regWriteCount := regWriteCount + UInt(1)
    mem(memWriteRegAddr) := memWriteRegData
  }

  val regReadCount = Reg(init = UInt(0, 32))
  io.readCount := regReadCount
  when (memReadOutValid) {
    regReadCount := regReadCount + UInt(1)
  }

  // instantiate the high-latency reducer
  val reducerInA = UInt(width = p.dataWidth)
  val reducerInB = UInt(width = p.dataWidth)
  val reducerInID = UInt(width = p.threadIDWidth)
  val reducerInValid = Bool()
  val reducerOut = ShiftRegister(reducerInA+reducerInB, p.reducerStages)
  val reducerOutValid = ShiftRegister(reducerInValid, p.reducerStages)
  val reducerOutID = ShiftRegister(reducerInID, p.reducerStages)

  // default values for all inputs
  memReadAddr := UInt(0)
  memReadEn := Bool(false)
  memWriteAddr := UInt(0)
  memWriteEn := Bool(false)
  memWriteData := UInt(0)
  reducerInA := UInt(0)
  reducerInB := UInt(0)
  reducerInID := UInt(0)
  reducerInValid := Bool(false)

  idSource.ready := Bool(false)

  val opDataQueue = Module(new Queue(UInt(width=p.dataWidth),1024)).io
  opDataQueue.enq.bits := idSource.bits.data
  opDataQueue.enq.valid := Bool(false)
  opDataQueue.deq.ready := Bool(false)

  // stream logic
  when (io.enable) {
    // TODO stall the consumer sometimes? always-on for now
    idSource.ready := Bool(true)
    // TODO data queue enq should not be ignored
    opDataQueue.enq.valid := idSource.valid

    opDataQueue.deq.ready := memReadOutValid

    memReadAddr := idSource.bits.id
    memReadEn := idSource.valid

    reducerInA := memReadOutData
    reducerInB := opDataQueue.deq.bits
    reducerInValid := opDataQueue.deq.valid & memReadOutValid
    reducerInID := memReadOutID

    memWriteAddr := reducerOutID
    memWriteEn := reducerOutValid
    memWriteData := reducerOut

  }
}

class HazardGuardTestHarnessTester(c: HazardGuardTestHarness) extends Tester(c) {

  def fillFrom(lID: List[Int], lData: List[Int], q: DecoupledIO[OperandWithID]) {
    for(i <- 0 until lID.size) {
      poke(q.valid, 1)
      poke(q.bits.id, lID(i))
      poke(q.bits.data, lData(i))
      while(peek(q.ready) != 1) {
        step(1)
      }
      step(1)

    }
    poke(q.valid, 0)
  }

  poke(c.io.enable, 0)

  val threads = 5
  val elemsPerThread = 20

  for(t <- 0 until threads) {
    val listID = (1 to elemsPerThread).map(x => t).toList
    val listData = (1 to elemsPerThread).map(x => x+t).toList

    fillFrom(listID, listData, c.io.testInData )
  }

  // verify that all data is written to the queues
  val totalElems = threads*elemsPerThread
  expect(c.testQueueData.count, totalElems)

  // start the real test
  poke(c.io.enable, 1)
  var steps = 0
  val stepLimit = threads*elemsPerThread*(c.hazardStages+2)
  while(peek(c.io.writeCount) != totalElems && steps < stepLimit) {
    peek(c.guard.io)
    step(1)
    steps += 1
  }

  // verify the read and write counts
  expect(c.io.writeCount, totalElems)
  expect(c.io.readCount, totalElems)

  for(t <- 0 until threads) {
    val golden = t*elemsPerThread + (elemsPerThread * (elemsPerThread+1))/2
    expect(c.io.threadOutputs(t), golden)
  }
  println("Took "+steps.toString+" cycles for "+totalElems.toString+" elements")
}
