package fpgatidbits.ocm

import chisel3._
import chisel3.util._
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
  val id = UInt(log2Ceil(num).W)

  val printfStr = "id = %d\n"
  val printfElems = {() => Seq(id)}

  override def cloneType: this.type = new CloakroomBundle(num).asInstanceOf[this.type]
}

class CloakroomIF
[TA <: Data, TB <: CloakroomBundle, TC <: CloakroomBundle, TD <: Data]
(genA: TA,
 undress: TA => TB,
 genC: TC,
 dress: (TA, TC) => TD,
 genB: TB,
 genD: TD)
extends Bundle {
  val extIn = Flipped(Decoupled(genA.cloneType)) //GatherReq
  val intOut = Decoupled(genB.cloneType) //Undress(InternalReq)
  val intIn = Flipped(Decoupled(genC.cloneType)) //GatherResp
  val extOut = Decoupled(genD.cloneType) //InternalResp

  override def cloneType: this.type = new CloakroomIF(genA, undress, genC, dress, genB, genD).asInstanceOf[this.type]
}


// based on LUTRAM, shouldn't be used for large cloakrooms
/* TODO add input/output queues? */
class CloakroomLUTRAM
[TA <: Data, TB <: CloakroomBundle, TC <: CloakroomBundle, TD <: Data]
(num: Int,
 genA: TA,
 undress: TA => TB,
 genC: TC,
 dress: (TA, TC) => TD,
 genB: TB,
 genD: TD)
extends Module {
  val io = IO(new CloakroomIF(genA.cloneType, undress, genC.cloneType, dress, genB, genD))

  // context store (where the "cloaks" will be kept)
  //val ctxStore = Mem(genA.cloneType, num)
  val ctxStore = SyncReadMem(num, genA.cloneType)

  // pool of available request IDs ("tickets" in the cloakrooms)
  val idPool = Module(new ReqIDQueue(log2Ceil(num), num, 0)).io

  //erlingrj initialize fully
  idPool.doInit := false.B
  idPool.initCount := num.U

  // define join fnuction based on the undress function
  def joinFxn(a: TA, b: UInt): TB = {
    val ret = undress(a)
    ret.id := b
    ret
  }

  // join up available IDs with incoming requests, expose as intOut
   StreamJoin(
     inA = io.extIn,
     inB = idPool.idOut,
     genO = io.intOut.bits.cloneType,
     join = joinFxn
  ) <> io.intOut

  // add to context store when intOut is ready to go
  when(io.intOut.ready & io.intOut.valid) {
    ctxStore(idPool.idOut.bits) := io.extIn.bits
  }

  // load context for incoming intIn
  val readyRespCtx = ctxStore(io.intIn.bits.id)

  val readyResps = Module(new StreamFork(
    genIn = genC.cloneType, genA = UInt(log2Ceil(num).W),
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
(num: Int, genA: TA, undress: TA => TB, genC: TC, dress: (TA, TC) => TD, genB: TB, genD: TD)
extends Module {
  val io = IO(new CloakroomIF(genA.cloneType, undress, genC.cloneType, dress, genB, genD))

  // context store (where the "cloaks" will be kept)
  val ctxSize = genA.getWidth
  val ctxLat = 1  // latency to read context
  val ctxStoreExt = Module(new DualPortBRAM(log2Up(num), ctxSize)).io
  val ctxStore = Wire(new DualPortBRAMIOWrapper(log2Up(num), ctxSize))
  ctxStoreExt.clk := clock
  ctxStoreExt.a.connect(ctxStore.ports(0))
  ctxStoreExt.b.connect(ctxStore.ports(1))


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
  ctxWrite.req.writeEn := false.B
  ctxWrite.req.writeData := io.extIn.bits
  ctxWrite.req.addr := idPool.idOut.bits

  when(io.intOut.ready & io.intOut.valid) {
    ctxWrite.req.writeEn := true.B
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
  val canDoRead = (intInWithCtxQ.count < 2.U)

  ctxRead.req.writeEn := false.B
  ctxRead.req.addr := io.intIn.bits.id

  intInWithCtxQ.enq.valid := ShiftRegister(io.intIn.valid & canDoRead, ctxLat)
  intInWithCtxQ.enq.bits.ctx := (ctxRead.rsp.readData)
  intInWithCtxQ.enq.bits.intIn := ShiftRegister(io.intIn.bits, ctxLat)
  io.intIn.ready := canDoRead

  // feed queue through StreamFork to recycle IDs and generate responses
  val readyResps = Module(new StreamFork(
    genIn = intInWithCtx.cloneType, genA = UInt(log2Ceil(num).W),
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
  val io = IO(new Bundle {
    val in = Flipped(Decoupled(genC.cloneType))
    val out = Decoupled(genC.cloneType)
  })
  val idBits = log2Up(num)
  // index of expected (next in order) response
  val regHeadInd = RegInit(0.U(idBits.W))

  // order buffer is dimensioned after the cloakroom, so we are always ready to
  // accept incoming responses
  io.in.ready := true.B

  // TODO do we need bypass logic?

  // storage BRAM for incoming responses
  val storageExt = Module(new DualPortBRAM(
    addrBits = idBits, dataBits = genC.getWidth
  )).io

  val storage = Wire(new DualPortBRAMIOWrapper(
    addrBits = idBits, dataBits = genC.getWidth
  ))
  storageExt.clk := clock


  storageExt.a.connect(storage.ports(0))
  storageExt.b.connect(storage.ports(1))
  storage.ports.map(_.driveDefaults())
  // name BRAM ports for easier access
  val dataRd = storage.ports(0)
  val dataWr = storage.ports(1)

  // bitfield to keep track of response status
  val regFinished = RegInit(0.U(num.W))
  val finishedSet = WireInit(0.U(num.W))
  val finishedClr = WireInit(0.U(num.W))

  regFinished := (regFinished & (~finishedClr).asUInt) | finishedSet

  // headRsps is used for handshaking-over-latency for reading rsps from BRAM
  // capacity = 1 (BRAM latency) + 2 (needed for full throughput)
  val headRsps = Module(new FPGAQueue(genC, 3)).io

  // ===========================================================================
  // write path
  dataWr.req.writeEn := io.in.valid
  dataWr.req.writeData := io.in.bits.asUInt
  dataWr.req.addr := io.in.bits.id

  // set finished flag for id when response received
  when(dataWr.req.writeEn) { finishedSet := UIntToOH(io.in.bits.id, num) }

  // ===========================================================================
  // read path
  val headReadyToGo = regFinished(regHeadInd)
  dataRd.req.writeEn := false.B

  // handshaking-over-latency to read out results
  val canPopRsp = headRsps.count < 2.U
  val isRspAvailable = headReadyToGo
  val doPopRsp = canPopRsp & isRspAvailable
  dataRd.req.addr := regHeadInd

  headRsps.enq.valid := RegNext(doPopRsp)
  headRsps.enq.bits := (dataRd.rsp.readData).asTypeOf(headRsps.enq.bits)

  when(doPopRsp) {
    when(regHeadInd === (num-1).U) { regHeadInd := 0.U }
    .otherwise { regHeadInd := regHeadInd + 1.U }
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
  val extIn = Flipped(Decoupled(genA.cloneType))
  val intOut = Decoupled(undress(genA.cloneType))
  val intIn = Flipped(Decoupled(genC.cloneType))
  val extOut = Decoupled(dress(genA.cloneType, genC.cloneType))

  override def cloneType: this.type = new InOrderCloakroomIF(genA, undress, genC, dress).asInstanceOf[this.type]
}

class InOrderCloakroom
[TA <: Data, TB <: Data, TC <: Data, TD <: Data]
(num: Int, genA: TA, undress: TA => TB, genC: TC, dress: (TA, TC) => TD)
extends Module {
  val io = IO(new InOrderCloakroomIF(genA, undress, genC, dress))

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
