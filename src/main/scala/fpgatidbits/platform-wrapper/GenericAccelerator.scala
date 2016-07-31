package fpgatidbits.PlatformWrapper

import Chisel._
import fpgatidbits.dma._
import scala.collection.mutable.LinkedHashMap

// TODO should the parameters for GenericAccelerator be separated from the
// parameters for PlatformWrapper?

// interface definition for GenericAccelerator-derived modules
class GenericAcceleratorIF(numMemPorts: Int, p: PlatformWrapperParams) extends Bundle {
  // memory ports
  val memPort = Vec.fill(numMemPorts) {new GenericMemoryMasterPort(p.toMemReqParams())}
  // use the signature field for sanity and version checks
  val signature = UInt(OUTPUT, p.csrDataBits)
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

  def makeDefaultSignature(): UInt = {
    import java.util.Date
    import java.text.SimpleDateFormat
    val dateFormat = new SimpleDateFormat("yyyyMMdd");
    val date = new Date();
    val dateString = dateFormat.format(date);
    val fullSignature = this.getClass.getSimpleName + "-" + dateString
    val hexSignature = hexcrc32(fullSignature)

    return UInt("h" + hexSignature)
  }

  // drive default values for memory read port i
  def plugMemReadPort(i: Int) {
    io.memPort(i).memRdReq.valid := Bool(false)
    io.memPort(i).memRdReq.bits.driveDefaults()
    io.memPort(i).memRdRsp.ready := Bool(false)
  }
  // drive default values for memory write port i
  def plugMemWritePort(i: Int) {
    io.memPort(i).memWrReq.valid := Bool(false)
    io.memPort(i).memWrReq.bits.driveDefaults()
    io.memPort(i).memWrDat.valid := Bool(false)
    io.memPort(i).memWrDat.bits := UInt(0)
    io.memPort(i).memWrRsp.ready := Bool(false)
  }
  // use the class name as the accel name
  // just set to something else in derived class if needed
  setName(this.getClass.getSimpleName)
}
