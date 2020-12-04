package fpgatidbits.utils

import chisel3._
import chisel3.util._

// For testing
import chisel3.tester._
import chisel3.tester.RawTester.test

object BitExtraction {
  def apply(word: UInt, high: UInt, low: UInt): UInt = {

    val width = word.getWidth
    var res = UInt(width.W)
    val highMask = (( (1.U << (high+1.U)).asUInt) - 1.U)(31,0)
    val lowMask = ~((1.U(width.W) << low).asUInt - 1.U)(31,0)
    val mask = highMask.asUInt & lowMask.asUInt
    res = ((word & mask) >> low).asUInt

    res
  }
}


