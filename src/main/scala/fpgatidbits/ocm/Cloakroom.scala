package fpgatidbits.ocm

import Chisel._
import fpgatidbits.streams._
import fpgatidbits.dma._

// consider some system that takes in some input consisting of fields A and B,
// making use of only field B, but when it emits a response it also
// has to add the original field A to the response. the "cloakroom" modules
// aim to make the design of such systems easier.

// extIn -> [cloakroom] -> intOut -> [processing] -> intIn -> [cloakroom] -> extOut

// you wouldn't walk around in an indoors party with your jacket on --
// you'd go to the cloakroom, leave your cloak and get a ticket. on your way
// out, you would use the ticket to get back your cloak. this is why this
// family of modules are named "cloakroom".


class CloakroomBundle(num: Int) extends PrintableBundle {
  val id = UInt(width = log2Up(num))

  val printfStr = "id = %d\n"
  val printfElems = {() => Seq(id)}

  override def cloneType: this.type = new CloakroomBundle(num).asInstanceOf[this.type]
}

class CloakroomIF
[TA <: Data, TB <: CloakroomBundle, TC <: CloakroomBundle, TD <: Data]
(genA: TA, undress: TA => TB, genC: TC, dress: (TA, TC) => TD)
extends Bundle {
  val extIn = Decoupled(genA.cloneType).flip
  val intOut = Decoupled(undress(genA.cloneType))
  val intIn = Decoupled(genC.cloneType).flip
  val extOut = Decoupled(dress(genA.cloneType, genC.cloneType))

  override def cloneType: this.type = new CloakroomIF(genA, undress, genC, dress).asInstanceOf[this.type]
}


// based on LUTRAM, shouldn't be used for large cloakrooms
/* TODO add input/output queues? */
class CloakroomLUTRAM
[TA <: Data, TB <: CloakroomBundle, TC <: CloakroomBundle, TD <: Data]
(num: Int, genA: TA, undress: TA => TB, genC: TC, dress: (TA, TC) => TD)
extends Module {
  val io = new CloakroomIF(genA.cloneType, undress, genC.cloneType, dress)

  // context store (where the "cloaks" will be kept)
  val ctxStore = Mem(genA.cloneType, num)
  // pool of available request IDs ("tickets" in the cloakrooms)
  val idPool = Module(new ReqIDQueue(log2Up(num), num, 0)).io

  // define join fnuction based on the undress function
  def joinFxn(a: TA, b: UInt): TB = {
    val ret = undress(a)
    ret.id := b
    ret
  }

  // join up available IDs with incoming requests, expose as intOut
   StreamJoin(inA = io.extIn, inB = idPool.idOut,
    genO = io.intOut.bits.cloneType, join = joinFxn
  ) <> io.intOut

  // add to context store when intOut is ready to go
  when(io.intOut.ready & io.intOut.valid) {
    ctxStore(idPool.idOut.bits) := io.extIn.bits
  }

  // load context for incoming intIn
  val readyRespCtx = ctxStore(io.intIn.bits.id)

  val readyResps = Module(new StreamFork(
    genIn = genC.cloneType, genA = UInt(width = log2Up(num)),
    genB = genC.cloneType,
    forkA = {c: TC => c.id},
    forkB = {c: TC => c}
  )).io


  io.intIn <> readyResps.in
  readyResps.outA <> idPool.idIn  // recycle used tickets back into the pool

  io.extOut.valid := readyResps.outB.valid
  io.extOut.bits := dress(readyRespCtx, readyResps.outB.bits)
  readyResps.outB.ready := io.extOut.ready
}

// cloakroom using BRAM as the context store, can be scaled to larger windows
class CloakroomBRAM
[TA <: Data, TB <: CloakroomBundle, TC <: CloakroomBundle, TD <: Data]
(num: Int, genA: TA, undress: TA => TB, genC: TC, dress: (TA, TC) => TD)
extends Module {
  val io = new CloakroomIF(genA.cloneType, undress, genC.cloneType, dress)

  // context store (where the "cloaks" will be kept)
  val ctxSize = genA.getWidth()
  val ctxLat = 1  // latency to read context
  val ctxStore = Module(new DualPortBRAM(log2Up(num), ctxSize)).io
  val ctxWrite = ctxStore.ports(0)
  val ctxRead = ctxStore.ports(1)

  // pool of available request IDs ("tickets" in the cloakrooms)
  val idPool = Module(new ReqIDQueueBRAM(log2Up(num), num, 0)).io

  // define join fnuction based on the undress function
  def joinFxn(a: TA, b: UInt): TB = {
    val ret = undress(a)
    ret.id := b
    ret
  }

  // join up available IDs with incoming requests, expose as intOut
   StreamJoin(inA = io.extIn, inB = idPool.idOut,
    genO = io.intOut.bits.cloneType, join = joinFxn
  ) <> io.intOut

  // add to context store when intOut is ready to go
  ctxWrite.req.writeEn := Bool(false)
  ctxWrite.req.writeData := io.extIn.bits.toBits
  ctxWrite.req.addr := idPool.idOut.bits

  when(io.intOut.ready & io.intOut.valid) {
    ctxWrite.req.writeEn := Bool(true)
  }

  // load context for incoming intIn
  // define a type for keeping the incoming intIn and its context bundled
  class IntInWithCtx extends Bundle {
    val intIn = genC.cloneType
    val ctx = genA.cloneType
    override def cloneType: this.type = new IntInWithCtx().asInstanceOf[this.type]
  }
  val intInWithCtx = new IntInWithCtx()

  // handshake over latency to retrieve the context
  // put both the context and the incoming intIn into a queue
  val intInWithCtxQ = Module(new FPGAQueue(intInWithCtx, ctxLat + 2)).io
  val canDoRead = (intInWithCtxQ.count < UInt(2))

  ctxRead.req.writeEn := Bool(false)
  ctxRead.req.addr := io.intIn.bits.id

  intInWithCtxQ.enq.valid := ShiftRegister(io.intIn.valid & canDoRead, ctxLat)
  intInWithCtxQ.enq.bits.ctx := genA.fromBits(ctxRead.rsp.readData)
  intInWithCtxQ.enq.bits.intIn := ShiftRegister(io.intIn.bits, ctxLat)
  io.intIn.ready := canDoRead

  // feed queue through StreamFork to recycle IDs and generate responses
  val readyResps = Module(new StreamFork(
    genIn = intInWithCtx.cloneType, genA = UInt(width = log2Up(num)),
    genB = io.extOut.bits.cloneType,
    forkA = {x: IntInWithCtx => x.intIn.id},
    forkB = {x: IntInWithCtx => dress(x.ctx, x.intIn)}
  )).io

  intInWithCtxQ.deq <> readyResps.in
  readyResps.outA <> idPool.idIn  // recycle used tickets back into the pool
  readyResps.outB <> io.extOut
}

class CloakroomOrderBuffer[TC <: CloakroomBundle]
(num: Int, genC: TC) extends Module {
  val io = new Bundle {
    val in = Decoupled(genC.cloneType).flip
    val out = Decoupled(genC.cloneType)
  }
  val idBits = log2Up(num)
  // index of expected (next in order) response
  val regHeadInd = Reg(init = UInt(0, idBits))

  // order buffer is dimensioned after the cloakroom, so we are always ready to
  // accept incoming responses
  io.in.ready := Bool(true)

  // TODO do we need bypass logic?

  // storage BRAM for incoming responses
  val storage = Module(new DualPortBRAM(
    addrBits = idBits, dataBits = genC.getWidth()
  )).io
  // name BRAM ports for easier access
  val dataRd = storage.ports(0)
  val dataWr = storage.ports(1)

  // bitfield to keep track of response status
  val regFinished = Reg(init = UInt(0, width = num))
  val finishedSet = UInt(width = num)
  finishedSet := UInt(0, num)
  val finishedClr = UInt(width = num)
  finishedClr := UInt(0, num)
  regFinished := (regFinished & ~finishedClr) | finishedSet

  // headRsps is used for handshaking-over-latency for reading rsps from BRAM
  // capacity = 1 (BRAM latency) + 2 (needed for full throughput)
  val headRsps = Module(new FPGAQueue(genC, 3)).io

  // ===========================================================================
  // write path
  dataWr.req.writeEn := io.in.valid
  dataWr.req.writeData := io.in.bits.toBits
  dataWr.req.addr := io.in.bits.id

  // set finished flag for id when response received
  when(dataWr.req.writeEn) { finishedSet := UIntToOH(io.in.bits.id, num) }

  // ===========================================================================
  // read path
  val headReadyToGo = regFinished(regHeadInd)
  dataRd.req.writeEn := Bool(false)

  // handshaking-over-latency to read out results
  val canPopRsp = headRsps.count < UInt(2)
  val isRspAvailable = headReadyToGo
  val doPopRsp = canPopRsp & isRspAvailable
  dataRd.req.addr := regHeadInd

  headRsps.enq.valid := Reg(next = doPopRsp)
  headRsps.enq.bits := genC.fromBits(dataRd.rsp.readData)

  when(doPopRsp) {
    when(regHeadInd === UInt(num-1)) { regHeadInd := UInt(0) }
    .otherwise { regHeadInd := regHeadInd + UInt(1) }
    finishedClr := UIntToOH(regHeadInd, num)
  }

  headRsps.deq <> io.out
}

// special case of the cloakroom is when the processing is guaranteed to be
// in-order. in this case the context storage turns into a simple FIFO queue
// and it is not necessary to use "tickets" (IDs) on the cloakroom
// entry or exit

class InOrderCloakroomIF
[TA <: Data, TB <: Data, TC <: Data, TD <: Data]
(genA: TA, undress: TA => TB, genC: TC, dress: (TA, TC) => TD)
extends Bundle {
  val extIn = Decoupled(genA.cloneType).flip
  val intOut = Decoupled(undress(genA.cloneType))
  val intIn = Decoupled(genC.cloneType).flip
  val extOut = Decoupled(dress(genA.cloneType, genC.cloneType))

  override def cloneType: this.type = new InOrderCloakroomIF(genA, undress, genC, dress).asInstanceOf[this.type]
}

class InOrderCloakroom
[TA <: Data, TB <: Data, TC <: Data, TD <: Data]
(num: Int, genA: TA, undress: TA => TB, genC: TC, dress: (TA, TC) => TD)
extends Module {
  val io = new InOrderCloakroomIF(genA, undress, genC, dress)

  val storage = Module(new FPGAQueue(genA, num)).io

  val forker = Module(new StreamFork(
    genIn = genA, genA = genA, genB = undress(genA),
    forkA = {a: TA => a}, forkB = undress
  )).io
  io.extIn <> forker.in
  forker.outA <> storage.enq
  forker.outB <> io.intOut

  StreamJoin(storage.deq, io.intIn, io.extOut.bits, dress) <> io.extOut
}
