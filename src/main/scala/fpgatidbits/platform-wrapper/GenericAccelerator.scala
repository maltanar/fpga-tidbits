package fpgatidbits.PlatformWrapper

import chisel3._
import chisel3.util._
import fpgatidbits.dma._


// interface definition for GenericAccelerator-derived modules
case class AcceleratorParams(
                            numMemPorts: Int,
                            numStreamOutPorts: Int = 0,
                            numStreamInPorts: Int = 0,
                            streamWidth: Int = 0
                            )

abstract class GenericAcceleratorIF(ap: AcceleratorParams,
                                     p: PlatformWrapperParams) extends Bundle {
  // memory ports
  val memPort = Vec(ap.numMemPorts,new GenericMemoryMasterPort(p.toMemReqParams()))

  // Streaming ports
  val streamInPort = Vec(ap.numStreamInPorts, new GenericStreamInPort(ap.streamWidth))
  val streamOutPort = Vec(ap.numStreamInPorts, new GenericStreamOutPort(ap.streamWidth))

  // use the signature field for sanity and version checks
  val signature = Output(UInt(p.csrDataBits.W))
}

// GenericAccelerator, serving as a base class for creating portable accelerators
// support managing the accelerator I/O as control-status registers
abstract class GenericAccelerator(val p: PlatformWrapperParams) extends Module {
  def io: GenericAcceleratorIF
  def numMemPorts: Int

  def hexcrc32(s: String): String = {
    import java.util.zip.CRC32
    val crc=new CRC32
    crc.update(s.getBytes)
    crc.getValue.toHexString
  }

  def hexSignature(): String = {
    val fullSignature = this.getClass.getSimpleName/* + "-" + dateString*/
    hexcrc32(fullSignature)
  }

  def makeDefaultSignature(): UInt = {
    ("h" + hexSignature()).U
  }

  // drive default values for memory read port i
  def plugMemReadPort(i: Int): Unit = {
    io.memPort(i).memRdReq.valid := false.B
    io.memPort(i).memRdReq.bits.driveDefaults()
    io.memPort(i).memRdRsp.ready := false.B
  }
  // drive default values for memory write port i
  def plugMemWritePort(i: Int): Unit = {
    io.memPort(i).memWrReq.valid := false.B
    io.memPort(i).memWrReq.bits.driveDefaults()
    io.memPort(i).memWrDat.valid := false.B
    io.memPort(i).memWrDat.bits := 0.U
    io.memPort(i).memWrRsp.ready := false.B
  }
  // use the class name as the accel name
  // just set to something else in derived class if needed
  suggestName(this.getClass.getSimpleName)
}
