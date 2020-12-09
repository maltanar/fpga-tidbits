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


object SubWordAssignment {
  def apply(word: UInt, high: Int, low:Int, subWord: UInt): UInt = {
    val wireOut = WireInit(word)
    // Clean out the desired area
    val highMask = (( (1.U << (high+1)).asUInt) - 1.U)
    val lowMask = ~((1.U << low).asUInt - 1.U)
    val cleanMask = highMask.asUInt & lowMask.asUInt

    // Overwrite that area
    val writeMask =  ((~cleanMask).asUInt & (subWord << low).asUInt)

    wireOut & cleanMask | writeMask
  }
}

