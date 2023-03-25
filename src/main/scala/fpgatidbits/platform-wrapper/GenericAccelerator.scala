package fpgatidbits.PlatformWrapper

import chisel3._
import chisel3.util._
import fpgatidbits.dma._


case class AcceleratorParams(
                            numMemPorts: Int,
                            numStreamOutPorts: Int = 0,
                            numStreamInPorts: Int = 0,
                            ) {
  def numStreamPorts: Int = numStreamInPorts + numStreamOutPorts
  def streamPortIdBits: Int = if (log2Ceil(numStreamPorts) > 0) log2Ceil(numStreamPorts) else 1
}

// interface definition for GenericAccelerator-derived modules
abstract class GenericAcceleratorIF(ap: AcceleratorParams,
                                     p: PlatformWrapperParams) extends Bundle {
  // memory ports
  val memPort = Vec(ap.numMemPorts,new GenericMemoryMasterPort(p.toMemReqParams()))

  // Streaming ports
  val streamInPort = Vec(ap.numStreamInPorts, Flipped(Decoupled(StreamEntry(UInt(p.csrDataBits.W)))))
  val streamOutPort = Vec(ap.numStreamOutPorts, Decoupled(StreamEntry(UInt(p.csrDataBits.W))))

  // use the signature field for sanity and version checks
  val signature = Output(UInt(p.csrDataBits.W))

  // FIXME: I think we might want a default status register to catch runtime exceptions.

  def driveDefault(): Unit = {
    for (elem <- streamOutPort) {
      elem.bits := 0.U.asTypeOf(elem.bits)
      elem.valid := false.B
    }
    for (elem <- streamInPort) {
      elem.ready := false.B
    }
  }
  def driveDefaultFlipped(): Unit = {
    for (elem <- streamInPort) {
      elem.bits := 0.U.asTypeOf(elem.bits)
      elem.valid := false.B
    }
    for (elem <- streamOutPort) {
      elem.ready := false.B
    }
  }
}

// GenericAccelerator, serving as a base class for creating portable accelerators
// support managing the accelerator I/O as control-status registers
abstract class GenericAccelerator(val p: PlatformWrapperParams) extends Module {
  val io: GenericAcceleratorIF
  val accelParams: AcceleratorParams

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
