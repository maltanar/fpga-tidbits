package fpgatidbits.streams

import Chisel._
import fpgatidbits.ocm._

// make two streams A and B go in lockstep, i.e. A is only popped when B is
// popped, and vice versa.
// this is achieved by first joining then forking the two streams.
// depending on the I/O behavior on the input and output, it may be necessary
// to add input/output queues.

object StreamSync {
  def apply[TA <: Data, TB <: Data](
    inA: DecoupledIO[TA], inB: DecoupledIO[TB],
    outA: DecoupledIO[TA], outB: DecoupledIO[TB],
    queueInput: Boolean = false,  // whether the inputs should be queued
    queueOutput: Boolean = false  // whether the outputs should be queued
  ) = {
      val ss = Module(new StreamSync(
        genA = inA.bits, genB = inB.bits, queueInput = queueInput,
        queueOutput = queueOutput
      )).io
      inA <> ss.inA
      inB <> ss.inB
      ss.outA <> outA
      ss.outB <> outB
    }
}

class StreamSync[TA <: Data, TB <: Data](
  genA: TA,                     // clonetype for first stream
  genB: TB,                     // clonetype for second stream
  queueInput: Boolean = false,  // whether the inputs should be queued
  queueOutput: Boolean = false  // whether the outputs should be queued
) extends Module {
  val io = new Bundle {
    val inA = Decoupled(genA).flip
    val inB = Decoupled(genB).flip
    val outA = Decoupled(genA)
    val outB = Decoupled(genB)
  }
  // define an internal packet type for the synced stream
  class SyncPacket extends Bundle {
    val compA = genA.cloneType
    val compB = genB.cloneType
    override def cloneType: this.type =
      new SyncPacket().asInstanceOf[this.type]
  }
  val syncedData = new SyncPacket()

  def joinFxn(a: TA, b: TB): SyncPacket = {
    val ret = new SyncPacket()
    ret.compA := a
    ret.compB := b
    return ret
  }

  val join = Module(new StreamJoin(
    genA = genA, genB = genB, genOut = syncedData, join = joinFxn
  )).io

  val fork = Module(new StreamFork(
    genIn = syncedData, genA = genA, genB = genB,
    forkA = {s: SyncPacket => s.compA}, forkB = {s: SyncPacket => s.compB}
  )).io

  if(queueInput) {
    FPGAQueue(io.inA, 2) <> join.inA
    FPGAQueue(io.inB, 2) <> join.inB
  } else {
    io.inA <> join.inA
    io.inB <> join.inB
  }

  join.out <> fork.in

  if(queueOutput) {
    FPGAQueue(fork.outA, 2) <> io.outA
    FPGAQueue(fork.outB, 2) <> io.outB
  } else {
    fork.outA <> io.outA
    fork.outB <> io.outB
  }
}
