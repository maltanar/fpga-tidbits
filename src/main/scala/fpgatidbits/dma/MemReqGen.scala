package fpgatidbits.dma

import Chisel._

// control interface for (simple) request generators
class ReqGenCtrl(addrWidth: Int) extends Bundle {
  val start = Bool(INPUT)
  val throttle = Bool(INPUT)
  val baseAddr = UInt(INPUT, width = addrWidth)
  val byteCount = UInt(INPUT, width = addrWidth)
}

// status interface for (simple) request generators
class ReqGenStatus() extends Bundle {
  val finished = Bool(OUTPUT)
  val active = Bool(OUTPUT)
  val error = Bool(OUTPUT)
}

// a generic memory request generator,
// only for contiguous accesses for now (no indirects, no strides)
// only burst-aligned addresses (no error checking!)
// will report error if start address is not word-aligned
// TODO do we want to support sub-word accesses?
class ReadReqGen(p: MemReqParams, chanID: Int, maxBeats: Int) extends Module {
  val reqGenParams = p
  val io = new Bundle {
    // control/status interface
    val ctrl = new ReqGenCtrl(p.addrWidth)
    val stat = new ReqGenStatus()
    // requests
    val reqs = Decoupled(new GenericMemoryRequest(p))
  }
  // shorthands for convenience
  val bytesPerBeat = (p.dataWidth/8)
  val bytesPerBurst = maxBeats * bytesPerBeat
  // state machine definitions & internal registers
  val sIdle :: sRun :: sFinished :: sError :: Nil = Enum(UInt(), 4)
  val regState = Reg(init = UInt(sIdle))
  val regAddr = Reg(init = UInt(0, p.addrWidth))
  val regBytesLeft = Reg(init = UInt(0, p.addrWidth))
  // default outputs
  io.stat.error := Bool(false)
  io.stat.finished := Bool(false)
  io.stat.active := (regState != sIdle)
  io.reqs.valid := Bool(false)
  io.reqs.bits.channelID := UInt(chanID)
  io.reqs.bits.isWrite := Bool(false)
  io.reqs.bits.addr := regAddr
  io.reqs.bits.metaData := UInt(0)
  // decide on length of burst depending on #bytes left
  val doBurst = (regBytesLeft >= UInt(bytesPerBurst))
  val burstLen = Mux(doBurst, UInt(bytesPerBurst), UInt(bytesPerBeat))
  io.reqs.bits.numBytes := burstLen

  // address needs to be aligned to burst size
  val numZeroAddrBits = log2Up(bytesPerBurst)
  val unalignedAddr = (io.ctrl.baseAddr(numZeroAddrBits-1, 0) != UInt(0))
  // number of bytes needs to be aligned to bus width
  val numZeroSizeBits = log2Up(bytesPerBeat)
  val unalignedSize = (io.ctrl.byteCount(numZeroSizeBits-1, 0) != UInt(0))
  val isUnaligned = unalignedSize || unalignedAddr

  switch(regState) {
      is(sIdle) {
        regAddr := io.ctrl.baseAddr
        regBytesLeft := io.ctrl.byteCount
        when (io.ctrl.start) { regState := Mux(isUnaligned, sError, sRun) }
      }

      is(sRun) {
        when (regBytesLeft === UInt(0)) { regState := sFinished }
        .elsewhen (!io.ctrl.throttle) {
          // issue the current request
          io.reqs.valid := Bool(true)
          when (io.reqs.ready) {
            // next request: update address & left request count
            regAddr := regAddr + burstLen
            regBytesLeft := regBytesLeft - burstLen
          }
        }
      }

      is(sFinished) {
        io.stat.finished := Bool(true)
        when (!io.ctrl.start) { regState := sIdle }
      }

      is(sError) {
        // only way out is reset
        io.stat.error := Bool(true)
        printf("Error in MemReqGen! regAddr = %x byteCount = %d \n", regAddr, io.ctrl.byteCount)
        printf("Unaligned addr? %d size? %d \n", unalignedAddr, unalignedSize)
      }
  }
}

// turn a stream of UInts into a stream of memory requests, treating the
// input stream UInt values as array indices
// the width of each element in the array is assumed to be equal to the
// memory data width
class IndsToMemReq(p: MemReqParams) extends Module {
  val io = new Bundle {
    // base address of the array start
    val base = UInt(INPUT, width = p.addrWidth)
    val isWrite = Bool(INPUT)
    val chanID = UInt(INPUT, width = p.idWidth)
    // array indices in
    val inds = Decoupled(UInt(width = p.dataWidth)).flip
    // memory requests out
    val reqs = Decoupled(GenericMemoryRequest(p))
  }
  io.reqs.valid := io.inds.valid
  io.inds.ready := io.reqs.ready

  io.reqs.bits.channelID := io.chanID
  io.reqs.bits.isWrite := io.isWrite
  io.reqs.bits.addr := io.base + UInt(p.dataWidth/8) * io.inds.bits
  io.reqs.bits.numBytes := UInt(p.dataWidth/8)
  io.reqs.bits.metaData := UInt(0)
}

object ReadArray {
  def apply(inds: DecoupledIO[UInt], base: UInt, id: UInt, p: MemReqParams) = {
    val arrayReadGen = Module(new IndsToMemReq(p)).io
    arrayReadGen.base := base
    arrayReadGen.isWrite := Bool(false)
    arrayReadGen.chanID := id
    inds <> arrayReadGen.inds
    arrayReadGen.reqs
  }
}

object WriteArray {
  def apply(inds: DecoupledIO[UInt], base: UInt, id: UInt, p: MemReqParams) = {
    val arrayReadGen = Module(new IndsToMemReq(p)).io
    arrayReadGen.base := base
    arrayReadGen.isWrite := Bool(true)
    arrayReadGen.chanID := id
    inds <> arrayReadGen.inds
    arrayReadGen.reqs
  }
}

class TestReadReqGenWrapper() extends Module {
  val p = new MemReqParams(48, 64, 4, 1)

  val io = new Bundle {
    val ctrl = new ReqGenCtrl(p.addrWidth)
    val stat = new ReqGenStatus()
    val reqQOut = Decoupled(new GenericMemoryRequest(p))
  }

  val dut = Module(new ReadReqGen(p, 0, 8))
  val reqQ = Module(new Queue(new GenericMemoryRequest(p), 4096))
  dut.io.reqs <> reqQ.io.enq
  reqQ.io.deq <> io.reqQOut
  io.ctrl <> dut.io.ctrl
  io.stat <> dut.io.stat
}

class TestReadReqGen(c: TestReadReqGenWrapper) extends Tester(c) {
  // TODO update test case to try non-burst-aligned size as well
  c.io.reqQOut.ready := Bool(false)

  val byteCount = 1024
  val baseAddr = 128

  val expectedReqCount = byteCount / (c.dut.bytesPerBurst)

  def waitUntilFinished(): Unit = {
    while(peek(c.io.stat.finished) != 1) {
      peek(c.reqQ.io.enq.valid)
      peek(c.reqQ.io.enq.bits)
      step(1)
      peek(c.reqQ.io.count)
    }
  }

  // Test 1: check request count and addresses, no throttling
  // set up the reqgen
  poke(c.io.ctrl.start, 0)
  poke(c.io.ctrl.throttle, 0)
  poke(c.io.ctrl.baseAddr, baseAddr)
  poke(c.io.ctrl.byteCount, byteCount)
  poke(c.io.reqQOut.ready, 0)
  step(1)
  expect(c.io.stat.finished, 0)
  expect(c.io.stat.active, 0)
  // activate and checki
  poke(c.io.ctrl.start, 1)
  step(1)
  expect(c.io.stat.finished, 0)
  expect(c.io.stat.active, 1)
  waitUntilFinished()
  // check number of emitted requests
  expect(c.reqQ.io.count, expectedReqCount)
  var expAddr = baseAddr
  // pop requests and check addresses
  while(peek(c.io.reqQOut.valid) == 1) {
    expect(c.io.reqQOut.bits.isWrite, 0)
    expect(c.io.reqQOut.bits.addr, expAddr)
    expect(c.io.reqQOut.bits.numBytes, c.dut.bytesPerBurst)
    poke(c.io.reqQOut.ready, 1)
    step(1)
    expAddr += c.dut.bytesPerBurst
  }
  // deinitialize and check
  poke(c.io.ctrl.start, 0)
  poke(c.io.reqQOut.ready, 0)
  step(1)
  expect(c.io.stat.finished, 0)
  expect(c.io.stat.active, 0)
  expect(c.reqQ.io.count, 0)

  // Test 2: repeat Test 1 with throttling
  poke(c.io.ctrl.start, 1)
  poke(c.io.ctrl.throttle, 1)
  step(1)
  expect(c.io.stat.finished, 0)
  expect(c.io.stat.active, 1)
  step(10)
  // verify that no requests appear
  expect(c.reqQ.io.count, 0)
  // remove throttling
  poke(c.io.ctrl.throttle, 0)
  waitUntilFinished()
  // check number of emitted requests
  expect(c.reqQ.io.count, expectedReqCount)
  expAddr = baseAddr
  // pop requests and check addresses
  while(peek(c.io.reqQOut.valid) == 1) {
    expect(c.io.reqQOut.bits.isWrite, 0)
    expect(c.io.reqQOut.bits.addr, expAddr)
    expect(c.io.reqQOut.bits.numBytes, c.dut.bytesPerBurst)
    poke(c.io.reqQOut.ready, 1)
    step(1)
    expAddr += c.dut.bytesPerBurst
  }
  // deinitialize and check
  poke(c.io.ctrl.start, 0)
  poke(c.io.reqQOut.ready, 0)
  step(1)
  expect(c.io.stat.finished, 0)
  expect(c.io.stat.active, 0)
  expect(c.reqQ.io.count, 0)
}

class WriteReqGen(p: MemReqParams, chanID: Int, maxBeats: Int = 1) extends ReadReqGen(p, chanID, maxBeats) {
  // force single beat per burst for now
  // TODO support write bursts -- needs support in interleaver
  io.reqs.bits.isWrite := Bool(true)
}
