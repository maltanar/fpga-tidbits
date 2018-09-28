import Chisel._
import fpgatidbits.math.Counter
import org.scalatest.junit.JUnitSuite
import org.junit.Test


// Tester-derived class to give stimulus and observe the outputs for the
// Module to be tested
class CounterTester(c: Counter) extends Tester(c) {
  val r = scala.util.Random
  val n_reps = 5

  def resetAndSetSteps(n: Int) = {
    poke(c.io.enable, 0)
    reset(1)
    poke(c.io.nsteps, n)
    step(1)
    peek(c.io.current)
  }

  for(rep <- 0 until n_reps) {
    val nsteps = r.nextInt(10)
    var acc_golden = 0
    var overflow_golden = 0
    resetAndSetSteps(nsteps)
    poke(c.io.enable, 0)
    for(i <- 0 to 20) {
      expect(c.io.current, acc_golden)
      val incr = r.nextInt(2)
      poke(c.io.enable, incr)
      step(1)
      acc_golden += incr
      if(acc_golden == nsteps) { acc_golden = 0 }
    }
  }
}

class TestCounter extends JUnitSuite {
  @Test def CounterTest {
    for(w <- 32 to 32) {
      // Chisel arguments to pass to chiselMainTest
      def testArgs = TestHelpers.stdArgs
      // function that instantiates the Module to be tested
      def testModuleInstFxn = () => { Module(new Counter(w = w)) }
      // function that instantiates the Tester to test the Module
      def testTesterInstFxn = (c: Counter) => new CounterTester(c)
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
