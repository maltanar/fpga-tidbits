package fpgatidbits.streams

import chisel3._
import chisel3.util._
import fpgatidbits.axi._


// takes in two streams (<element> and <repCnt>) and repeats each
// element in <element> <repCnt> times. example:
// <element> = A B C D E F
// <repCnt> = 2 1 0 3
// <out> = A A B D D D

object StreamRepeatElem {
  def apply(inElem: DecoupledIO[UInt], inRepCnt: DecoupledIO[UInt]):
  AXIStreamIF[UInt] = {
    val repgen = Module(new StreamRepeatElem(inElem.bits.getWidth,
                        inRepCnt.bits.getWidth)).io
    repgen.inElem <> inElem
    repgen.inRepCnt <> inRepCnt
    repgen.out
  }

  def apply[Te <: Data](gen: Te, inElem: DecoupledIO[Te], inRepCnt: DecoupledIO[UInt]):
  DecoupledIO[Te] = {
    val repgen = Module(new StreamRepeatElem(gen.getWidth,
                        inRepCnt.bits.getWidth)).io
    val ret = Decoupled(gen)
    repgen.inElem.TDATA := inElem.bits
    repgen.inElem.TVALID := inElem.valid
    inElem.ready := repgen.inElem.TREADY

    repgen.inRepCnt <> inRepCnt
    ret.valid := repgen.out.TVALID
    ret.bits := repgen.out.TDATA
    repgen.out.TREADY := ret.ready

    ret
  }
}

class StreamRepeatElem(dataWidth: Int, repWidth: Int) extends Module {
  val io = IO(new Bundle {
    val inElem =Flipped(new AXIStreamIF(UInt(dataWidth.W)))
    val inRepCnt =Flipped(new AXIStreamIF(UInt(repWidth.W)))
    val out = new AXIStreamIF(UInt(dataWidth.W))
  })

  io.inElem.TREADY := false.B
  io.inRepCnt.TREADY := false.B
  io.out.TVALID := false.B

  val regElem = RegInit(0.U(dataWidth.W))
  val regRep = RegInit(0.U(repWidth.W))

  io.out.TDATA := regElem

  val bothValid = io.inElem.TVALID & io.inRepCnt.TVALID

  when(regRep === 0.U) {
    when (bothValid) {
      regElem := io.inElem.TDATA
      regRep := io.inRepCnt.TDATA
      io.inElem.TREADY := true.B
      io.inRepCnt.TREADY := true.B
    }
  }
  .otherwise {
    io.out.TVALID := true.B
    when(io.out.TREADY) {
      regRep := regRep - 1.U
      // last repetition? prefetch in read
      when(regRep === 1.U) {
        // prefetch elem and repcount, if possible
        when (bothValid) {
          regElem := io.inElem.TDATA
          regRep := io.inRepCnt.TDATA
          io.inElem.TREADY := true.B
          io.inRepCnt.TREADY := true.B
        }
      }
    }
  }
}

/*

class StreamRepeatElemTester(c: StreamRepeatElem) extends Tester(c) {
  var elems = Array(100, 200, 300, 400)
  var reps = Array(3, 0, 2, 1)
  val l = elems.size
  var golden: Array[Int] = Array[Int]()

  for(i <- 0 until l) {
    val r = reps(i)
    for(j <- 0 until r) {
      golden = golden ++ Array(elems(i))
    }
  }

  var res: Array[Int] = Array[Int]()

  def streamToArray(s: DecoupledIO[UInt], a: Array[Int]): Array[Int] = {
    if(peek(s.valid) == 1 && peek(s.ready)==1) {
      return a ++ Array[Int](peek(s.bits).toInt)
    } else return a
  }

  def arrayToStream_preStep(s: DecoupledIO[UInt], a: Array[Int]) = {
    if(a.size > 0) {
      poke(s.bits, a(0))
      poke(s.valid, 1)
    }
  }

  def arrayToStream_postStep(s: DecoupledIO[UInt], a: Array[Int]): Array[Int] = {
    if(peek(s.valid) == 1 && peek(s.ready)==1) {
      return a.drop(1)
    } else return a
  }

  poke(c.io.out.ready, 1)

  while(res.size != golden.size) {
    arrayToStream_preStep(c.io.inElem, elems)
    arrayToStream_preStep(c.io.inRepCnt, reps)
    step(1)
    res=streamToArray(c.io.out, res)
    elems=arrayToStream_postStep(c.io.inElem, elems)
    reps=arrayToStream_postStep(c.io.inRepCnt, reps)
  }

  println(res.deep.mkString(", "))
  println(golden.deep.mkString(", "))

  expect(res.deep == golden.deep, "Result equals golden")
}
*/