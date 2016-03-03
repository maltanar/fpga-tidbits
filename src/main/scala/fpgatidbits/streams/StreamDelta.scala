package fpgatidbits.streams

import Chisel._
import fpgatidbits.axi._

// Computes a delta stream from a stream of samples:
// time -------------------------->>
// samples =  A B C D E
// deltas =   (B-A) (C-B) (D-C) (E-D)

object StreamDelta {
  def apply(in: DecoupledIO[UInt]): DecoupledIO[UInt] = {
    val deltagen = Module(new StreamDelta(in.bits.getWidth())).io
    deltagen.samples <> in
    deltagen.deltas
  }
}

class StreamDelta(dataWidth: Int) extends Module {
  val io = new Bundle {
    val samples = new AXIStreamSlaveIF(UInt(width = dataWidth))
    val deltas = new AXIStreamMasterIF(UInt(width = dataWidth))
  }
  // rename AXI stream interfaces to support Vivado type inference
  io.samples.renameSignals("samples")
  io.deltas.renameSignals("deltas")

  // internal registers
  val regSample1 = Reg(init = UInt(0, dataWidth))
  val regSample2 = Reg(init = UInt(0, dataWidth))
  val sampleDelta = regSample2 - regSample1

  // default outputs
  io.deltas.bits := sampleDelta
  io.deltas.valid := Bool(false)
  io.samples.ready := Bool(false)

  // state machine definitions
  val sIdle :: sWaitNextSample :: sWaitDelta :: sRun :: Nil = Enum(UInt(), 4)
  val regState = Reg(init = UInt(sIdle))

  // FSM for control
  switch ( regState ) {
    is ( sIdle ) {
      io.samples.ready := Bool(true)

      when ( io.samples.valid ) {
        regState := sWaitNextSample
        regSample2 := io.samples.bits
      }
    }

    is ( sWaitNextSample ) {
      io.samples.ready := Bool(true)

      when ( io.samples.valid ) {
        regSample2 := io.samples.bits
        regSample1 := regSample2
        regState := sRun
      }
    }

    is ( sRun ) {
      io.deltas.valid := Bool(true)

      when ( io.deltas.ready ) {
        when ( io.samples.valid ) {
          // next sample already valid: just pop it while
          // staying in the same state
          regSample2 := io.samples.bits
          regSample1 := regSample2
          io.samples.ready := Bool(true)
        } .otherwise {
          // next sample not quite ready yet, wait for it
          regState := sWaitNextSample
        }
      }
    }
  }
}


// a testbed for the SDG: just putting queues on the
// input and output to make testing easier

class StreamDeltaTestBed() extends Module {
  val io = new Bundle {
    val samples = new DecoupledIO(UInt(width = 32)).flip
    val deltas = new DecoupledIO(UInt(width = 32))
    val inQueueCount = UInt(OUTPUT, 32)
    val outQueueCount = UInt(OUTPUT, 32)
  }

  val sdt = Module(new StreamDelta(32))
  val inQueue = Module(new Queue(UInt(width=32), entries = 16))
  val outQueue = Module(new Queue(UInt(width=32), entries = 16))

  inQueue.io.enq <> io.samples
  inQueue.io.deq <> sdt.io.samples
  sdt.io.deltas <> outQueue.io.enq
  outQueue.io.deq <> io.deltas

  io.inQueueCount := inQueue.io.count
  io.outQueueCount := outQueue.io.count
}

class StreamDeltaTester(c: StreamDeltaTestBed) extends Tester(c) {
  // TODO should also test corner cases / latency insensitivity
  val nums = Array(0, 5, 14, 17, 17, 23, 99)
  val count = nums.size

  poke(c.io.deltas.ready, 0)

  // push samples into input queue
  for(i <- 0 until count) {
    poke(c.io.samples.valid, 1)
    poke(c.io.samples.bits, nums(i))
    step(1)
  }

  // check that the deltas appear in the output queue
  for(i <- 0 until count-1) {
    expect(c.io.deltas.valid, 1)
    expect(c.io.deltas.bits, nums(i+1)-nums(i))
    poke(c.io.deltas.ready, 1)
    step(1)
  }
}
