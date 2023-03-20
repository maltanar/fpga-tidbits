package streams

import chisel3._
import chiseltest._
import org.scalatest.flatspec.AnyFlatSpec

import fpgatidbits.streams._

class TestStreamCAM extends AnyFlatSpec with ChiselScalatestTester {
  behavior of "StreamCAM"
  it should "Initalize properly" in {
    test(new CAM(10, 8)) {
      c =>
        c.io.hasFree.expect(true.B)
        c.io.freeInd.expect(0.U)
    }
  }
}
