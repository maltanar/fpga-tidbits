package utils

import chisel3._
import chisel3.util._
import chisel3.iotesters._
import org.scalatest._

import fpgatidbits.utils.BitExtraction

class TestWrapper extends MultiIOModule {
  val io = IO( new Bundle {
    val word = Input(UInt(32.W))
    val high = Input(UInt(8.W))
    val low = Input(UInt(8.W))
    val result = Output(UInt(32.W))
  })

  io.result := BitExtraction(io.word, io.high, io.low)
}



class TestUtils(dut: TestWrapper) extends PeekPokeTester(dut) {
  def TestBitExtraction(in: Int, h: Int, l: Int) = {

    poke(dut.io.word, in.U)
    poke(dut.io.high, h.U)
    poke(dut.io.low, l.U)
    step(1)
    expect(dut.io.result, in.U(32.W)(h,l))
  }

  TestBitExtraction(123456789,8,1)
  TestBitExtraction(123456789,7,6)
  TestBitExtraction(123456789,32,4)
  TestBitExtraction(123456789,3,0)
}



class SimpleSpec extends FlatSpec with Matchers {
/*
  val t = new TestUtils
  "BitExtraction" should "pass" in {
    t.TestBitExtraction()
  }
 */
    "BitExtraction" should "pass" in {
        chisel3.iotesters.Driver(
          () => new TestWrapper)
        {
          c => new TestUtils(c)
        } should be (true)
    }

}