package fpgatidbits.dma

import Chisel._

class ReqInterleaver(numPipes: Int, p: MemReqParams) extends Module {
  val io = new Bundle {
    // individual request pipes
    val reqIn = Vec.fill(numPipes) {Decoupled(new GenericMemoryRequest(p)).flip}
    // interleaved request pipe
    val reqOut = Decoupled(new GenericMemoryRequest(p))
  }
  // TODO for now, we just use a round-robin arbiter
  // TODO report statistics from the interleaved mix?
  val arb = Module(new RRArbiter(gen=new GenericMemoryRequest(p), n=numPipes))
  for (i <- 0 until numPipes) {
    arb.io.in(i) <> io.reqIn(i)
  }
  arb.io.out <> io.reqOut
}

class TestReqInterleaverWrapper() extends Module {
  val p = new MemReqParams(48, 64, 4, 1)
  val burstBeats = 8
  val io = new Bundle {
    val reqOut = Decoupled(new GenericMemoryRequest(p))
    val allFinished = Bool(OUTPUT)
    val allActive = Bool(OUTPUT)
  }
  val N = 4
  val bytesPerPipe = 1024
  val reqPipes = Vec.tabulate(N) {i => Module(new ReadReqGen(p, i, burstBeats)).io}
  val dut = Module(new ReqInterleaver(N, p))
  for(i <- 0 until N) {
    reqPipes(i).reqs <> dut.io.reqIn(i)
    reqPipes(i).ctrl.throttle := Bool(false)
    reqPipes(i).ctrl.start := Bool(true)
    reqPipes(i).ctrl.baseAddr := UInt(bytesPerPipe*i)
    reqPipes(i).ctrl.byteCount := UInt(bytesPerPipe)
  }
  val reqQ = Module(new Queue(new GenericMemoryRequest(p), 1024))
  reqQ.io.enq <> dut.io.reqOut
  reqQ.io.deq <> io.reqOut

  io.allFinished := reqPipes.forall( x => x.stat.finished )
  io.allActive := reqPipes.forall( x => x.stat.active )
}

class TestReqInterleaver(c: TestReqInterleaverWrapper) extends Tester(c) {
  poke(c.io.reqOut.ready, 0)
  step(1)
  expect(c.io.allActive, 1)
  expect(c.io.allFinished, 0)
  while(peek(c.io.allFinished) != 1) {
    peek(c.reqQ.io.enq.valid)
    peek(c.reqQ.io.enq.bits)
    peek(c.reqQ.io.count)
    step(1)
  }
  // verify number of requests in the interleaved queue
  val bytesPerBurst = (c.burstBeats*c.p.dataWidth/8)
  val expReqsPerPipe = c.bytesPerPipe / bytesPerBurst
  val expTotalReqs = c.N * expReqsPerPipe
  expect(c.reqQ.io.count, expTotalReqs)
  // verify the request mix from different channels
  var reqsFromChannel:Array[Int] = Array.fill[Int](c.N)(0)
  val channelExpReq:Array[Int] = (0 to c.N-1).map({ i => c.bytesPerPipe*i }).toArray
  while(peek(c.io.reqOut.valid) == 1) {
    val chanID = peek(c.io.reqOut.bits.channelID).toInt
    expect(c.io.reqOut.bits.addr, channelExpReq(chanID))
    reqsFromChannel(chanID) += 1
    channelExpReq(chanID) += bytesPerBurst
    poke(c.io.reqOut.ready, 1)
    step(1)
  }
  poke(c.io.reqOut.ready, 0)
  expect(c.reqQ.io.count, 0)
  for(i <- 0 until c.N) {
    println("Channel " + i.toString + " #reqs= " + reqsFromChannel(i).toString)
    expect(reqsFromChannel(i) == expReqsPerPipe, "Channel has correct #reqs")
  }
}
