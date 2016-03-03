package TidbitsTestbenches

import Chisel._
import fpgatidbits.SimUtils._

class SimpleHLMHarness() extends Module {
  val io = new Bundle {
    val start = Bool(INPUT)
    val done = Bool(OUTPUT)
    val error = Bool(OUTPUT)
    val fillCycles = UInt(OUTPUT, width = 32)
    val dumpCycles = UInt(OUTPUT, width = 32)
  }

  io.done := Bool(false)

  val regErr = Reg(init=Bool(false))
  io.error := regErr

  val memParams = new HighLatencyMemParams(64, 1, 32, 32, 4, 32, 20)

  val dut = Module(new HighLatencyMem(memParams)).io
  // plug port defaults
  for(i <- 0 until memParams.numPorts) {
    dut.ports(i).req.valid := Bool(false)
    dut.ports(i).req.bits.driveDefaults
    dut.ports(i).wdt.valid := Bool(false)
    dut.ports(i).wdt.bits := UInt(0)
    dut.ports(i).rsp.ready := Bool(false)
  }

  val sIdle :: sFill :: sDump :: sFinished :: Nil = Enum(UInt(), 4)
  val regState = Reg(init = UInt(sIdle))
  val regAddr = Reg(init = UInt(0, 32))
  val regRespCounter = Reg(init = UInt(0, 32))
  val regFillCycles = Reg(init = UInt(0, 32))
  val regDumpCycles = Reg(init = UInt(0, 32))

  io.fillCycles := regFillCycles
  io.dumpCycles := regDumpCycles

  switch(regState) {
      is(sIdle) {
        when(io.start) {regState := sFill}
      }

      is(sFill) {
        regFillCycles := regFillCycles + UInt(1)
        // push requests
        when(regAddr < UInt(memParams.depth)) {
          val bothReady = dut.ports(0).req.ready & dut.ports(0).wdt.ready
          // write request
          dut.ports(0).req.bits.numBytes := UInt(4)
          dut.ports(0).req.bits.addr := regAddr
          dut.ports(0).req.bits.isWrite := Bool(true)
          dut.ports(0).req.valid := bothReady
          // fixed data
          dut.ports(0).wdt.valid := bothReady
          dut.ports(0).wdt.bits := UInt("hdeadbeef")

          when(bothReady) {
            regAddr := regAddr + UInt(1)
          }
        }
        // handle responses (just count them for now)
        when(regRespCounter === UInt(memParams.depth)) {
          regAddr := UInt(0)
          regRespCounter := UInt(0)
          regState := sDump
        } .otherwise {
          dut.ports(0).rsp.ready := Bool(true)
          when(dut.ports(0).rsp.valid) {
            regRespCounter := regRespCounter + UInt(1)
          }
        }
      }

      is(sDump) {
        regDumpCycles := regDumpCycles + UInt(1)
        // push requests
        when(regAddr < UInt(memParams.depth)) {
          // write request
          dut.ports(0).req.bits.numBytes := UInt(4)
          dut.ports(0).req.bits.addr := regAddr
          dut.ports(0).req.valid := Bool(true)

          when(dut.ports(0).req.ready) {
            regAddr := regAddr + UInt(1)
          }
        }
        // handle responses (just count them for now)
        when(regRespCounter === UInt(memParams.depth)) {
          regAddr := UInt(0)
          regRespCounter := UInt(0)
          regState := sFinished
        } .otherwise {
          dut.ports(0).rsp.ready := Bool(true)
          when(dut.ports(0).rsp.valid) {
            regRespCounter := regRespCounter + UInt(1)
            when(dut.ports(0).rsp.bits.readData != UInt("hdeadbeef")) {
              regState := sFinished
              regErr := Bool(true)
            }
          }
        }
      }

      is(sFinished) {
        io.done := Bool(true)
      }
  }
}


class HLMSimpleTester(c: SimpleHLMHarness) extends Tester(c) {
  poke(c.io.start, 1)

  val cycleLimit = c.memParams.depth*5
  var cycles: Int = 0

  while(cycles < cycleLimit && peek(c.io.done) != 1) {
    peek(c.dut)
    peek(c.regRespCounter)
    step(1)
    cycles += 1
  }
  expect(c.io.done, 1)
  expect(c.io.error, 0)
  val fillElemsPerCycle=(c.memParams.depth.toFloat/peek(c.io.fillCycles).toFloat).toString
  val dumpElemsPerCycle=(c.memParams.depth.toFloat/peek(c.io.dumpCycles).toFloat).toString
  println("Fill elems per cycle: "+fillElemsPerCycle)
  println("Dump elems per cycle: "+dumpElemsPerCycle)
}
