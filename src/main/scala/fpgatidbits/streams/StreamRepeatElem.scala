package fpgatidbits.streams

import Chisel._
import fpgatidbits.axi._


// takes in two streams (<element> and <repCnt>) and repeats each
// element in <element> <repCnt> times. example:
// <element> = A B C D E F
// <repCnt> = 2 1 0 3
// <out> = A A B D D D

object StreamRepeatElem {
  def apply(inElem: DecoupledIO[UInt], inRepCnt: DecoupledIO[UInt]):
  DecoupledIO[UInt] = {
    val repgen = Module(new StreamRepeatElem(inElem.bits.getWidth(),
                        inRepCnt.bits.getWidth())).io
    repgen.inElem <> inElem
    repgen.inRepCnt <> inRepCnt
    repgen.out
  }

  def apply[Te <: Data](gen: Te, inElem: DecoupledIO[Te], inRepCnt: DecoupledIO[UInt]):
  DecoupledIO[Te] = {
    val repgen = Module(new StreamRepeatElem(gen.getWidth(),
                        inRepCnt.bits.getWidth())).io
    val ret = Decoupled(gen)
    repgen.inElem.bits := inElem.bits.toBits
    repgen.inElem.valid := inElem.valid
    inElem.ready := repgen.inElem.ready

    repgen.inRepCnt <> inRepCnt
    ret.valid := repgen.out.valid
    ret.bits := gen.fromBits(repgen.out.bits)
    repgen.out.ready := ret.ready

    ret
  }
}

class StreamRepeatElem(dataWidth: Int, repWidth: Int) extends Module {
  val io = new Bundle {
    val inElem = new AXIStreamSlaveIF(UInt(width = dataWidth))
    val inRepCnt = new AXIStreamSlaveIF(UInt(width = repWidth))
    val out = new AXIStreamMasterIF(UInt(width = dataWidth))
  }

  io.inElem.ready := Bool(false)
  io.inRepCnt.ready := Bool(false)
  io.out.valid := Bool(false)

  val regElem = Reg(init = UInt(0, dataWidth))
  val regRep = Reg(init = UInt(0, repWidth))

  io.out.bits := regElem

  val bothValid = io.inElem.valid & io.inRepCnt.valid

  when(regRep === UInt(0)) {
    when (bothValid) {
      regElem := io.inElem.bits
      regRep := io.inRepCnt.bits
      io.inElem.ready := Bool(true)
      io.inRepCnt.ready := Bool(true)
    }
  }
  .otherwise {
    io.out.valid := Bool(true)
    when(io.out.ready) {
      regRep := regRep - UInt(1)
      // last repetition? prefetch in read
      when(regRep === UInt(1)) {
        // prefetch elem and repcount, if possible
        when (bothValid) {
          regElem := io.inElem.bits
          regRep := io.inRepCnt.bits
          io.inElem.ready := Bool(true)
          io.inRepCnt.ready := Bool(true)
        }
      }
    }
  }
}

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
