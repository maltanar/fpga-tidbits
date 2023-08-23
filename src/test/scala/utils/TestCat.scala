package utils
import chisel3._
import chisel3.util._
import chiseltest._
import org.scalatest.flatspec.AnyFlatSpec

class CatExample extends Module {
  val io = IO(new Bundle {
    val out = Vec(2, Output(UInt(32.W)))
    val in  = Vec(2, Vec(4, Input(UInt(8.W))))
  })
  val wiresReadOut =VecInit(Seq.fill(2)(VecInit(Seq.fill(4)(WireInit(0.U(8.W))))))

  for (i <- 0 until 4) {
    for (p <- 0 until 2) {
      wiresReadOut(p)(i) := io.in(p)(i)
    }
  }

  for (i <- 0 until 2) {
    io.out(i) := wiresReadOut(i).asUInt
  }

}


class TestCat extends AnyFlatSpec with ChiselScalatestTester {

  behavior of "SubWordAssignment"
  it should "work" in {
    test(new CatExample) {
      c =>
        c.io.in(0)(0).poke( "hde".U)
        c.io.in(0)(1).poke( "had".U)
        c.io.in(0)(2).poke( "hbe".U)
        c.io.in(0)(3).poke( "hef".U)

        c.io.in(1)(0).poke( "hab".U)
        c.io.in(1)(1).poke( "hed".U)
        c.io.in(1)(2).poke( "hde".U)
        c.io.in(1)(3).poke( "hce".U)

        c.io.out(0).expect("hef_be_ad_de".U)
        c.io.out(1).expect("hce_de_ed_ab".U)

    }
  }
}
