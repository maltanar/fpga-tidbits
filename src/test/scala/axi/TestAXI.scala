//package fpgatidbits.PlatformWrapper

import chisel3._
import chisel3.util._
import org.scalatest._


//class TestAXI(dut: ZedBoardWrapper) extends PeekPokeTester(dut) {
//
//  // This test uses the AXI CSR interface and writes a value to a register
//  def TestWriteCSR(value: Int, regId: Int) = {
//
//    val addr = regId*4 //We do byte addressing
//
//    // Write register 3 == bytecount register
//    step(4)
//    poke(dut.extCsrIf.AWADDR, addr.U)
//    poke(dut.extCsrIf.AWVALID, 1.U)
//    poke(dut.extCsrIf.WDATA, value.U)
//    poke(dut.extCsrIf.WSTRB, "hFF".U)
//    poke(dut.extCsrIf.WVALID, 1.U)
//    poke(dut.extCsrIf.BREADY, 1.U)
//
//    println(s"Wrote ${value} to reg ${addr}")
//
//    var awready = peek(dut.extCsrIf.AWREADY) == 1
//    var wready = peek(dut.extCsrIf.WREADY) == 1
//    var i = 0
//    while (!awready || !wready) {
//      step(1); i+=1
//      if (!awready) awready = peek(dut.extCsrIf.AWREADY) == 1
//      if (!wready) wready = peek(dut.extCsrIf.WREADY) == 1
//      if (i > 100) {
//        println("awready/wready fail")
//        fail
//        awready=true
//        wready=true
//      };
//    }
//    println("Got awready and wready")
//    step(1)
//
//    poke(dut.extCsrIf.AWADDR, 0.U)
//    poke(dut.extCsrIf.AWVALID, 0.U)
//    poke(dut.extCsrIf.WDATA, 0.U)
//    poke(dut.extCsrIf.WSTRB, 0.U)
//    poke(dut.extCsrIf.WVALID, 0.U)
//
//    var bvalid = peek(dut.extCsrIf.BVALID) == 1
//
//    i = 0
//    while (!bvalid) {
//      step(1); i+=1
//      bvalid = peek(dut.extCsrIf.BVALID) == 1
//
//      if (i > 1000) {
//        println("bvalid fail")
//        fail
//        bvalid = true
//      }
//    }
//    step(1)
//    poke(dut.extCsrIf.BREADY, 0.U)
//
//    println("Write data response")
//    step(5)
//  }
//
//  // TestReadCSR uses the AXI interface to read the value in a given register
//  def TestReadCSR(regId: Int): BigInt = {
//    val addr = regId*4
//    step(4)
//
//
//    poke(dut.extCsrIf.ARADDR, addr.U)
//    poke(dut.extCsrIf.ARVALID, 1.U)
//    poke(dut.extCsrIf.RREADY, 1.U)
//
//
//    var arready = peek(dut.extCsrIf.ARREADY) == 1
//    var i = 0
//    while (!arready) {
//      step(1); i+=1
//      arready = peek(dut.extCsrIf.ARREADY) == 1
//      if (i > 100) {
//        println("arready fail")
//        fail
//        arready=true
//      };
//    }
//    println("Got arready")
//    step(1)
//
//    poke(dut.extCsrIf.ARVALID, 0.U)
//    poke(dut.extCsrIf.ARADDR, 0.U)
//
//    var rvalid = peek(dut.extCsrIf.RVALID) == 1
//
//    i = 0
//    while (!rvalid) {
//      step(1); i+=1
//      rvalid = peek(dut.extCsrIf.RVALID) == 1
//
//      if (i > 1000) {
//        println("rvalid fail")
//        fail
//        rvalid = true
//      }
//    }
//    val result = peek(dut.extCsrIf.RDATA)
//    step(1)
//    poke(dut.extCsrIf.RREADY, 0.U)
//
//    println("Read data response")
//    step(1)
//    result
//  }
//
//  def TestCSRReadAddr() = {
//    step(4)
//    expect(dut.extCsrIf.ARREADY, 1.U)
//  }
//
//
//  // Run the actual tests
//
//  TestCSRReadAddr()
//  TestWriteCSR(value=100, regId=3)
//  val res = TestReadCSR(regId=3)
//  println(s"Wrote 100 and read ${res} from Reg3")
//  assert(TestReadCSR(regId=3) == 100)
//
//}
//
//
//class SimpleSpec extends FlatSpec with Matchers {
//
//  "Tester" should "pass" in {
//  val accel = {p => new ExampleSum(p)}
//  chisel3.iotesters.Driver.
//    execute(Array("--generate-vcd-output", "on", "--wave-form-file-name" ,"TestAXIWave.vcd", "-td" ,"test_run_dir/TestAXI", "--test-seed", "69"),
//      () => new ZedBoardWrapper((accel), targetDir = "_dump", generateRegDriver = false))
//      {
//        c => new TestAXI(c)
//      } should be (true)
//  }
//}