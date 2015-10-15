/*
PlatformWrapper serves as the base class for creating a wrapper for a certain
FPGA platform. This wrapper connects the particular interfaces and services
provided by the platform to the generic control/status and memory interfaces
expected by GenericAccelerator.
*/

package TidbitsPlatformWrapper

import Chisel._
import TidbitsDMA._
import TidbitsRegFile._

// parameters for the platform
trait PlatformWrapperParams {
  def numMemPorts: Int
  def numRegs: Int
  def platformName: String
  def accelName: String
  def memAddrBits: Int
  def memDataBits: Int
  def memIDBits: Int
  def memMetaBits: Int
  def csrDataBits: Int

  def toMemReqParams(): MemReqParams = {
    new MemReqParams(memAddrBits, memDataBits, memIDBits, memMetaBits)
  }
}

// actual wrappers must derive from this class and implement the following:
// - define the io Bundle for the platform
// - connect the platform mem ports to the GenericAccelerator mem ports
// - do reads/writes to the regfile from the platform memory-mapped interface
abstract class PlatformWrapper
(val p: PlatformWrapperParams,
val instFxn: PlatformWrapperParams => GenericAccelerator)
extends Module {

  setName(p.platformName+"-"+p.accelName)

  // instantiate the accelerators
  val accel = Module(instFxn(p)).io

  // instantiate register file and connect to accel ports
  val regAddrBits = log2Up(p.numRegs)
  val regFile = Module(new RegFile(p.numRegs, regAddrBits, p.csrDataBits)).io

  for(i <- 0 until p.numRegs) {
    regFile.regIn(i) <> accel.regOut(i)
    accel.regIn(i) := regFile.regOut(i)
  }

}
