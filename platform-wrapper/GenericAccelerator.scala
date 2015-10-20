package TidbitsPlatformWrapper

import Chisel._
import TidbitsDMA._
import scala.collection.mutable.LinkedHashMap

// TODO should the parameters for GenericAccelerator be separated from the
// parameters for PlatformWrapper?

// interface definition for GenericAccelerator-derived modules
class GenericAcceleratorIF(p: PlatformWrapperParams) extends Bundle {
  // memory ports
  val memPort = Vec.fill(p.numMemPorts) {new GenericMemoryMasterPort(p.toMemReqParams())}
  // use the signature field for sanity and version checks
  val signature = UInt(OUTPUT, p.csrDataBits)
}

// GenericAccelerator, serving as a base class for creating portable accelerators
// support managing the accelerator I/O as control-status registers and generating
// a register map driver for talking to the accelerator from software
class GenericAccelerator(val p: PlatformWrapperParams) extends Module {
  val io = new GenericAcceleratorIF(p)

  // drive default values for memory read ports
  def plugMemReadPorts() {
    for(i <- 0 until p.numMemPorts) {
      io.memPort(i).memRdReq.valid := Bool(false)
      io.memPort(i).memRdReq.bits.driveDefaults()
      io.memPort(i).memRdRsp.ready := Bool(false)
    }
  }
  // drive default values for memory write ports
  def plugMemWritePorts() {
    for(i <- 0 until p.numMemPorts) {
      io.memPort(i).memWrReq.valid := Bool(false)
      io.memPort(i).memWrReq.bits.driveDefaults()
      io.memPort(i).memWrDat.valid := Bool(false)
      io.memPort(i).memWrDat.bits := UInt(0)
      io.memPort(i).memWrRsp.ready := Bool(false)
    }
  }

  override def clone = { new GenericAccelerator(p).asInstanceOf[this.type] }
}
