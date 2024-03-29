package fpgatidbits.math

import chisel3._
import chisel3.util._
import fpgatidbits.streams._
import fpgatidbits.ocm._
import fpgatidbits.dma.ReqIDQueue

// a streaming reducer that can be used with high-latency math ops. assumes
// that the value groups to be reduced are delivered contiguously.
// inspired by the following paper:
// Gerards, Marco, et al. "Streaming reduction circuit."
// Digital System Design, Architectures, Methods and Tools, 2009. DSD'09.
// 12th Euromicro Conference on. IEEE, 2009.

// will produce results out of order when the opportunity arises (i.e. a 2-len
// group following a 100-len group may be delivered first)

class ReducerWorkUnit(valWidth: Int, indWidth: Int) extends PrintableBundle {
  val groupID = UInt(indWidth.W)
  val groupLen = UInt(indWidth.W)
  val value = UInt(valWidth.W)

  val printfStr = "group %d (%d items) value %d \n"
  val printfElems = {() => Seq(groupID, groupLen, value)}
}

class ReducerOutput(valWidth: Int, indWidth: Int) extends PrintableBundle {
  val groupID = UInt(indWidth.W)
  val value = UInt(valWidth.W)

  val printfStr = "group %d value %d \n"
  val printfElems = {() => Seq(groupID, value)}
}

class StreamingReducer(valWidth: Int, indWidth: Int,
                       makeReducer: () => BinaryMathOp) extends Module {
  val io = new Bundle {
    val in = Flipped(Decoupled(new ReducerWorkUnit(valWidth, indWidth)))
    val out = Decoupled(new ReducerOutput(valWidth, indWidth))
  }
  // instantiate the reduction operator, since we'll use its latency to size
  // various components in StreamingReducer
  val op = Module(makeReducer())
  val internalIDWidth = log2Up(op.latency + 8)
  val txns = 1 << internalIDWidth

  // ==========================================================================
  // define internal classes and functions
  class InternalWU extends PrintableBundle {
    val internalID = UInt(internalIDWidth.W)
    val value = UInt(valWidth.W)
    val opsDone = UInt(indWidth.W)
    val needZeroPad = Bool()

    val printfStr = "internalID %d value %d opsDone %d needZeroPad %d \n"
    val printfElems = {() => Seq(internalID, value, opsDone, needZeroPad)}

  }

  class InternalWUPair extends PrintableBundle {
    val internalID = UInt(internalIDWidth.W)
    val valueA = UInt(valWidth.W)
    val valueB = UInt(valWidth.W)
    val opsDone = UInt(indWidth.W)

    val printfStr = "internalID %d valueA %d valueB %d opsDone %d \n"
    val printfElems = {() => Seq(internalID, valueA, valueB, opsDone)}

  }

  val wu = new InternalWU()
  val wup = new InternalWUPair()

  def aggrOps(x: UInt, y: UInt): UInt = {x+y}

  // note that the upsizer always expects an even number of elements from the
  // same group; it is necessary to insert an additional zero for groups with
  // an odd number of elements.
  class ReducerUpsizer extends Module {
    val io = new Bundle {
      val in = Flipped(Decoupled(wu))
      val out = Decoupled(wup)
    }
    val regPendingUpsize = RegInit(false.B)
    val regPendingIndex = RegInit(0.U(indWidth.W))
    val regPendingData = RegInit(0.U(valWidth.W))

    io.in.ready := false.B
    io.out.valid := false.B
    io.out.bits.internalID := regPendingIndex
    io.out.bits.valueA := regPendingData
    io.out.bits.valueB := io.in.bits.value
    // upsizer is intended to sit right after newQ, will only see opsDone=0
    io.out.bits.opsDone := 0.U

    when(!regPendingUpsize) {
      when(io.in.valid & io.in.bits.needZeroPad) {
        io.out.valid := true.B
        io.in.ready := io.out.ready
        io.out.bits.internalID := io.in.bits.internalID
        io.out.bits.valueA := io.in.bits.value
        io.out.bits.valueB := 0.U   // TODO zero from semiring!
      } .otherwise {
        // fill up register buffers
        io.in.ready := true.B
        when(io.in.fire) {
          regPendingUpsize := true.B
          regPendingIndex := io.in.bits.internalID
          regPendingData := io.in.bits.value
        }
      }
    } .otherwise {
      // data valid in register buffers, pair with incoming stream
      io.out.valid := io.in.valid
      io.in.ready := io.out.ready
      when(io.in.fire) {
        regPendingUpsize := false.B
        assert(io.in.bits.internalID === regPendingIndex, "Unmatched IDs in upsizer")
      }
    }
  }

  class CoalescingStorage extends Module {
    val io = new Bundle {
      val in = Flipped(Decoupled(wu))
      val out = Decoupled(wup)
    }
    val inQ = FPGAQueue(io.in, 2)

    val memValid = RegInit(0.U(txns.W))
    val memData = Mem(txns, UInt(valWidth.W))
    val memOpsLeft = Mem(txns, UInt(indWidth.W))

    val inGroupID = inQ.bits.internalID
    val hasPrevData = memValid(inGroupID)
    val prevData = memData(inGroupID)
    val prevOpsLeft = memOpsLeft(inGroupID)

    io.out.valid := false.B
    inQ.ready := false.B
    io.out.bits.internalID := inGroupID
    io.out.bits.valueA := prevData
    io.out.bits.valueB := inQ.bits.value
    io.out.bits.opsDone := aggrOps(prevOpsLeft, inQ.bits.opsDone)

    // incoming input has no previously stored data: pop input and store in mem
    when(inQ.valid & !hasPrevData) {
      inQ.ready := true.B
      memValid(inGroupID) := true.B
      memOpsLeft(inGroupID) := inQ.bits.opsDone
      memData(inGroupID) := inQ.bits.value
    }

    // incoming input does have stored data, make output available
    when(inQ.valid & hasPrevData) {
      io.out.valid := true.B
      inQ.ready := io.out.ready
    }

    // when output is popped, the storage for the corresponding groupID position
    // is set to empty again
    when(io.out.valid & io.out.ready) {
      memValid(inGroupID) := false.B
    }
  }

  def makeWUPair(a: InternalWU, b: InternalWU): InternalWUPair = {
    val ret = new InternalWUPair()
    ret.internalID := a.internalID
    ret.valueA := a.value
    ret.valueB := b.value
    ret.opsDone := aggrOps(a.opsDone, b.opsDone)

    return ret
  }

  def undress(a: InternalWUPair): BinaryMathOperands = {
    val ret = new BinaryMathOperands(valWidth)
    ret.first := a.valueA
    ret.second := a.valueB
    return ret
  }

  def dress(a: InternalWUPair, b: UInt): InternalWU = {
    val ret = new InternalWU()
    ret.internalID := a.internalID
    // increment ops done when coming out of the cloakroom
    ret.opsDone := a.opsDone + 1.U
    ret.value := b
    return ret
  }

  // ==========================================================================
  // instantiate and connect internal modules

  val upsizer = Module(new ReducerUpsizer()).io
  val cStr = Module(new CoalescingStorage()).io
  val idPool = Module(new ReqIDQueue(internalIDWidth, txns, 0)).io

  val oneQ = Module(new FPGAQueue(wu, 2)).io      // 1-elem groups
  val newQ = Module(new FPGAQueue(wu, txns+1)).io    // non-1-elem groups
  val opQ = Module(new FPGAQueue(wup, 2)).io      // opd pairs ready to reduce
  val resQ = Module(new FPGAQueue(wu, 2)).io      // results from op
  val recycleQ = Module(new FPGAQueue(wu, 2)).io  // results back into op
  val retQ = Module(new FPGAQueue(io.out.bits, 2)).io // retiring/finished groups
  // rr arbiter for mixing 1- results into retQ
  val retQArb = Module(new RRArbiter(wu, 2)).io
  // rr arbiter for choosing between regular & bypassed opQ inputs
  val opQArb = Module(new RRArbiter(wup, 2)).io
  opQArb.out <> opQ.enq

  newQ.deq <> upsizer.in
  recycleQ.deq <>  cStr.in

  upsizer.out <> opQArb.in(0)
  cStr.out <> opQArb.in(1)

  val cloakroom = Module(new InOrderCloakroom(
    num = txns, genA = wup, undress = undress, genC = UInt(valWidth.W),
    dress = dress
  )).io

  opQ.deq <> cloakroom.extIn
  cloakroom.intOut <> op.io.in
  op.io.out <> cloakroom.intIn
  cloakroom.extOut <> resQ.enq

  // memory to keep the original group IDs
  val memGroupID = Mem(txns, UInt(indWidth.W))
  val memGroupLen = Mem(txns, UInt(indWidth.W))
  // currently used internal ID, initialized s.t. increment gives 0 as first ID
  val regCurrentInternalID = RegInit(0.U(internalIDWidth.W))
  // currently active group ID, initialized to invalid group
  val regGroupID = RegInit(VecInit(Seq.fill(indWidth)(true.B)))

  val newGroupID = io.in.bits.groupID
  val newGroupLen = io.in.bits.groupLen
  val newGroupIsSingle = newGroupLen === 1.U
  idPool.idOut.ready := false.B

  val inTargets = DecoupledOutputDemux(
    sel = newGroupIsSingle, chans = Seq(newQ.enq, oneQ.enq)
  )
  // ensure id pool is available before accepting a new row
  val stallIn = io.in.valid && (regGroupID.asUInt =/= newGroupID) && !idPool.idOut.valid

  inTargets.valid := io.in.valid && !stallIn
  inTargets.bits <> io.in.bits
  io.in.ready := inTargets.ready && !stallIn

  oneQ.enq.bits.opsDone := 0.U
  newQ.enq.bits.opsDone := 0.U
  newQ.enq.bits.internalID := regCurrentInternalID
  oneQ.enq.bits.internalID := regCurrentInternalID
  oneQ.enq.bits.needZeroPad := false.B
  newQ.enq.bits.needZeroPad := false.B

  when(regGroupID.asUInt =/= newGroupID) {
    when(io.in.valid & io.in.ready) {
      // first element of new group
      // get ID directly from pool
      newQ.enq.bits.internalID := idPool.idOut.bits
      oneQ.enq.bits.internalID := idPool.idOut.bits
      // save group ID
      memGroupID(idPool.idOut.bits) := newGroupID
      regGroupID := newGroupID
      // save number of ops needed for group, add +1 for zero padding as needed
      memGroupLen(idPool.idOut.bits) := Mux(newGroupLen(0), newGroupLen, newGroupLen - 1.U)
      // add a zero to make group length even, if needed
      newQ.enq.bits.needZeroPad := newGroupLen(0)
      // update the current internal ID and pop from id pool
      regCurrentInternalID := idPool.idOut.bits
      idPool.idOut.ready := true.B
      assert(idPool.idOut.valid, "idPool output not valid")
    }
  }


  // lookup number of ops needed to finalize this group
  val neededGroupOps = memGroupLen(resQ.deq.bits.internalID)
  val isGroupFinished = (neededGroupOps === resQ.deq.bits.opsDone)

  // emit to retirement queue when group is finished
  resQ.deq <> DecoupledOutputDemux(
    sel = isGroupFinished, chans = Seq(recycleQ.enq, retQArb.in(0))
  )

  oneQ.deq <> retQArb.in(1)
  retQArb.out <> retQ.enq

  idPool.idIn.valid := false.B
  idPool.idIn.bits := retQArb.out.bits.internalID
  retQ.enq.bits.groupID := memGroupID(retQArb.out.bits.internalID)

  when(retQ.enq.fire) {
    assert(idPool.idIn.ready, "idPool input not ready")
    idPool.idIn.valid := true.B
  }

  retQ.deq <> io.out

  // =========================================================================
  val verboseDebug = true
  if(verboseDebug) {
    val qs = Seq(oneQ, newQ, opQ, resQ, recycleQ, retQ)
    val qnames = Seq("oneQ", "newQ", "opQ", "resQ", "recycleQ", "retQ")
    val doMon = io.in.valid
    for((q, qn) <- qs zip qnames) {
      PrintableBundleStreamMonitor(q.enq, doMon, qn, true)
    }
    PrintableBundleStreamMonitor(upsizer.in, doMon, "upsizer.in", true)
  }
}