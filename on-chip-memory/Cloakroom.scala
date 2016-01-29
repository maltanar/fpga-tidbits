package TidbitsOCM

import Chisel._
import TidbitsStreams._
import TidbitsDMA._

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
  val io = new CloakroomIF(genA.cloneType, undress, genC, dress)

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
