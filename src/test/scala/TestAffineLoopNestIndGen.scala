import Chisel._
import org.scalatest.junit.JUnitSuite
import org.junit.Test
import fpgatidbits.streams._

// Tester-derived class to give stimulus and observe the outputs for the
// Module to be tested
class AffineLoopNestIndGenTester(c: AffineLoopNestIndGen) extends Tester(c) {
  val levels = c.n
  val r = scala.util.Random
  val reps = 1 + r.nextInt(5)

  // functions to create the golden values for the affine loop nest
  def balance(current: Seq[Int], desc: Seq[Int]): Seq[Int] = {
    if(current.size == 0) {
      return current
    } else if(current.size == 1) {
      if(current(0) >= desc(0)) {
        return Seq(0)
      } else {
        return current
      }
    } else {
      if(current(0) >= desc(0)) {
        return Seq(0) ++ balance(Seq(current(1)+1) ++ current.drop(2), desc.drop(1))
      } else {
        return Seq(current(0)) ++ balance(current.drop(1), desc.drop(1))
      }
    }
  }
  def make_golden_util(current: Seq[Int], desc: Seq[Int], n: Int): Seq[Seq[Int]] = {
    if(n == 0) {
      return Seq()
    } else {
      val nxt = Seq(current(0)+1) ++ current.drop(1)
      return Seq(current) ++ make_golden_util(balance(nxt, desc), desc, n-1)
    }
  }
  def make_golden(desc: Seq[Int]): Seq[Seq[Int]] = {
    val total_iters = desc.reduce(_*_)
    val start_iter = Seq.fill(desc.length){0}
    return make_golden_util(start_iter, desc, total_iters)
  }

  for(rep <- 0 until reps) {
    // create new random affine loop nest with given #levels
    // avoid 0-sized dims
    val descr = (0 until levels).map(i => r.nextInt(10) + 1)
    // create the expected traversal
    val golden = make_golden(descr)
    // set up the loop nest descriptor
    for(i <- 0 until levels) {
      poke(c.io.in.bits.inds(i), descr(i))
    }
    poke(c.io.in.valid, 1)
    step(1)
    poke(c.io.in.valid, 0)
    // wait for traversal to start
    while(peek(c.io.out.valid) == 0) { step(1) }
    poke(c.io.out.ready, 1)
    for(current_iter <- golden) {
      for(i <- 0 until levels) {
        expect(c.io.out.bits.inds(i), current_iter(i))
      }
      step(1)
    }
    expect(c.io.out.valid, 0)
  }
}

class TestAffineLoopNestIndGen extends JUnitSuite {
  @Test def AffineLoopNestIndGenTest {
    for(w <- 32 to 32) {
      for(n <- 2 to 4) {
        // Chisel arguments to pass to chiselMainTest
        def testArgs = TestHelpers.stdArgs
        // function that instantiates the Module to be tested
        def testModuleInstFxn = () => { Module(new AffineLoopNestIndGen(
          w = w, n = n
        ))}
        // function that instantiates the Tester to test the Module
        def testTesterInstFxn = (c: AffineLoopNestIndGen) => new AffineLoopNestIndGenTester(c)
        // actually run the test
        chiselMainTest(
          testArgs,
          testModuleInstFxn
        ) {
          testTesterInstFxn
        }
      }
    }
  }
}
