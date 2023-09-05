package PlatformWrapper

import org.scalatest.flatspec.AnyFlatSpec
import chiseltest._
import chisel3._
import fpgatidbits.PlatformWrapper._
import fpgatidbits.examples.ExampleSum

class TestTesterWrapper extends AnyFlatSpec with ChiselScalatestTester {
  def initClocks(c: TesterWrapper): Unit = {
    c.accio.memPort.map(mp => {
      mp.memRdRsp.initSink().setSinkClock(c.clock)
      mp.memRdReq.initSource().setSourceClock(c.clock)
      mp.memWrRsp.initSink().setSinkClock(c.clock)
      mp.memWrReq.initSource().setSourceClock(c.clock)
      mp.memWrDat.initSink().setSinkClock(c.clock)
    }
    )
  }

  type AccelInstFxn = PlatformWrapperParams => GenericAccelerator
  type AccelMap = Map[String, AccelInstFxn]

  def makeInstFxn(): AccelInstFxn = {
    return { (p: PlatformWrapperParams) => new ExampleSum(p) }
  }

  behavior of "TesterWrapper"

  it should "Initialize correctly" in {
    test(new TesterWrapper(makeInstFxn(), targetDir = "._tmp") { c =>
      initClocks(c)
      c.accio.memPort(0).memRdReq.ready.expect(true.B)
      c.accio.memPort(0).memRdRsp.valid.expect(false.B)
    })
  }
}