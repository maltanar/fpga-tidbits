package fpgatidbits.PlatformWrapper

import chisel3._
import chisel3.util._
import fpgatidbits.dma._
//import fpgatidbits.hlstools.TemplatedHLSBlackBox
import scala.collection.mutable.ArrayBuffer

// Interface definition for GenericAccelerator-derived modules
abstract class GenericAcceleratorIF(numMemPorts: Int, p: PlatformWrapperParams) extends Bundle {
  // Memory ports
  val memPort = Vec(numMemPorts,new GenericMemoryMasterPort(p.toMemReqParams()))
  // Use the signature field for sanity and version checks
  val signature = Output(UInt(p.csrDataBits.W))
}

// GenericAccelerator, serving as a base class for creating portable accelerators
// support managing the accelerator I/O as control-status registers
abstract class GenericAccelerator(val p: PlatformWrapperParams) extends Module {
  def io: GenericAcceleratorIF
  def numMemPorts: Int

  /*
  val hlsBlackBoxes = ArrayBuffer[TemplatedHLSBlackBox]()

  def HLSBlackBox[T <: TemplatedHLSBlackBox](blackBox: T): T = {
    hlsBlackBoxes += blackBox
    return blackBox
  }
  */


  def hexcrc32(s: String): String = {
    import java.util.zip.CRC32
    val crc=new CRC32
    crc.update(s.getBytes)
    crc.getValue.toHexString
  }

  // Generate an unique ID for the accelerator which is placed in CSR 0.
  def hexSignature(): String = {
    val fullSignature = this.getClass.getSimpleName/* + "-" + dateString*/
    return hexcrc32(fullSignature)
  }

  def makeDefaultSignature(): UInt = {
    return ("h" + hexSignature()).U
  }

  // Drive default values for memory read port i
  def plugMemReadPort(i: Int): Unit = {
    io.memPort(i).memRdReq.valid := false.B
    io.memPort(i).memRdReq.bits.driveDefaults()
    io.memPort(i).memRdRsp.ready := false.B
  }

  // Drive default values for memory write port i
  def plugMemWritePort(i: Int): Unit = {
    io.memPort(i).memWrReq.valid := false.B
    io.memPort(i).memWrReq.bits.driveDefaults()
    io.memPort(i).memWrDat.valid := false.B
    io.memPort(i).memWrDat.bits := 0.U
    io.memPort(i).memWrRsp.ready := false.B
  }

  // Use the class name as the accel name.
  // Just set to something else in derived class if needed
  suggestName(this.getClass.getSimpleName)
}
