package fpgatidbits.PlatformWrapper

import chisel3._
import chisel3.util._
import fpgatidbits.dma._
//import fpgatidbits.hlstools.TemplatedHLSBlackBox
import scala.collection.mutable.ArrayBuffer

// TODO should the parameters for GenericAccelerator be separated from the
// parameters for PlatformWrapper?

// interface definition for GenericAccelerator-derived modules
class GenericAcceleratorIF(numMemPorts: Int, p: PlatformWrapperParams) extends Bundle {
  // memory ports
  val memPort = Vec(numMemPorts,new GenericMemoryMasterPort(p.toMemReqParams()))
  // use the signature field for sanity and version checks
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

  def hexSignature(): String = {
    /*import java.util.Date
    import java.text.SimpleDateFormat
    val dateFormat = new SimpleDateFormat("yyyyMMdd");
    val date = new Date();
    val dateString = dateFormat.format(date);*/
    // removing date from signature due to discrepancies that this causes
    // when HW and driver are generated on different days
    val fullSignature = this.getClass.getSimpleName/* + "-" + dateString*/
    return hexcrc32(fullSignature)
  }

  def makeDefaultSignature(): UInt = {
    return ("h" + hexSignature()).U
  }

  // drive default values for memory read port i
  def plugMemReadPort(i: Int) {
    io.memPort(i).memRdReq.valid := false.B
    io.memPort(i).memRdReq.bits.driveDefaults()
    io.memPort(i).memRdRsp.ready := false.B
  }
  // drive default values for memory write port i
  def plugMemWritePort(i: Int) {
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
