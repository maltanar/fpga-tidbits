import Chisel._
import fpgatidbits.ocm._
import fpgatidbits.streams.AXIStreamDownsizer

class OCMSuite extends TestSuite {

  @Test def ocmTest {

    class OCMFillDump(val ocmParams : OCMParameters) extends Module {
      val io = new Bundle {
        val start = Bool(INPUT)
        val active = Bool(OUTPUT)
        val done = Bool(OUTPUT)
        val passed = Bool(OUTPUT)
      }

      io.done := Bool(false)
      io.passed := Bool(false)

      val fillWord = UInt("hdeadbeef", 32)
      val dut = Module(new OCMAndController( ocmParams, "", false))

      val mcif = dut.io.mcif
      mcif.mode := UInt(0)
      mcif.start := Bool(false)
      mcif.fillDumpStart := UInt(0)
      mcif.fillDumpCount := UInt(0)

      val regFillData = Reg(init = fillWord)

      val fillQ = Module(new Queue(UInt(width = 32), entries = 16 ))
      val downsize = Module(new AXIStreamDownsizer(32, ocmParams.writeWidth))
      mcif.fillPort <> downsize.io.out
      fillQ.io.deq <> downsize.io.in
      fillQ.io.enq.bits := regFillData
      fillQ.io.enq.valid := Bool(false)

      val dumpQ = Module(new Queue(UInt(width = 32), entries = 16 ))
      mcif.dumpPort <> dumpQ.io.enq
      dumpQ.io.deq.ready := Bool(false)


      val sIdle :: sFill :: sDump :: sFinOK :: sFinErr :: Nil = Enum(UInt(), 5)
      val regState = Reg(init = UInt(sIdle))

      io.active := (regState != sIdle)

      val regFillCount = Reg(init = UInt(0, 32))
      val regDumpCount = Reg(init = UInt(0, 32))

      switch(regState) {
        is(sIdle) {
          regFillCount := UInt(ocmParams.bits/32)
          regDumpCount := UInt(ocmParams.bits/32)
          when(io.start) { regState := sFill }
        }

        is(sFill) {
          when(regFillCount === UInt(0)) {
            mcif.start := Bool(false)
            when(mcif.done) {regState := sDump}
          } .otherwise {
            mcif.fillDumpCount := UInt(ocmParams.writeDepth)
            mcif.mode := UInt(0)
            mcif.start := Bool(true)
            fillQ.io.enq.valid := Bool(true)
            fillQ.io.enq.bits := regFillCount

            when(fillQ.io.enq.ready) {regFillCount := regFillCount - UInt(1)}
          }
        }

        is(sDump) {
          when(regDumpCount === UInt(0)) {
            mcif.start := Bool(false)
            when(mcif.done) {regState := sFinOK}
          } .otherwise {
            mcif.fillDumpCount := UInt(ocmParams.readDepth)
            mcif.mode := UInt(1)
            mcif.start := Bool(true)
            dumpQ.io.deq.ready := Bool(true)

            when(dumpQ.io.deq.valid) {
              when (dumpQ.io.deq.bits === regDumpCount) {
                regDumpCount := regDumpCount - UInt(1)
              } .otherwise {
                regState := sFinErr
              }
            }
          }
        }

        is(sFinOK) {
          io.done := Bool(true)
          io.passed := Bool(true)
        }

        is(sFinErr) {
          io.done := Bool(true)
          io.passed := Bool(false)
        }
      }
    }

    class OCMFillDumpTests(c: OCMFillDump) extends Tester(c) {
      // use to limit duration (may run infinitely in case of bugs)
      val cycleLimit = 2*c.ocmParams.bits

      def waitUntilComplete() {
        var cycles = 0
        while (peek(c.io.done) != 1) {
          peek(c.regState)
          peek(c.regFillCount)
          peek(c.dut.ocmControllerInst.regState)
          peek(c.dut.ocmControllerInst.regAddr)
          peek(c.fillQ.io)
          peek(c.dumpQ.io)
          step(1)
          cycles = cycles + 1
          if(cycles > cycleLimit)
            return
        }

      }
      poke(c.io.start, 0)
      step(1)
      expect(c.io.done, 0)
      expect(c.io.passed, 0)
      expect(c.io.active, 0)
      step(1)
      poke(c.io.start, 1)
      step(1)
      expect(c.io.active, 1)
      waitUntilComplete()
      expect(c.io.passed, 1)
    }

    // Can loop over a combination of parameters to test
    val b = 4
    val rWidth = 8
    val wWidth = 8
    val pts = 4
    val lat = 4
    chiselMainTest(Array("--genHarness", "--compile", "--test", "--backend", "c"), () => {
      Module( new OCMFillDump( new OCMParameters( b, rWidth, wWidth, pts, lat ) ) )
    } ) { c => new OCMFillDumpTests( c ) }

  }
}
