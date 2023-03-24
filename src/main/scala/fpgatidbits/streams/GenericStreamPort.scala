package fpgatidbits.streams

import chisel3._
import chisel3.util._
import fpgatidbits.PlatformWrapper.StreamEntry

//class GenericStreamOutPort[T <: Data](gen: T, addrBits: Int) extends DecoupledIO(gen)  {
//  val addr = Input(UInt(addrBits.W))
//  def driveDefaultFlipped(): Unit = {
//    ready := false.B
//    addr := 0.U
//  }
//  def driveDefault(): Unit = {
//    valid := false.B
//    bits := 0.U
//  }
//
//  def connectDecoupledEntry(e: DecoupledIO[Entry[UInt]]): Unit = {
//    e.bits.core := addr
//    e.bits.data := bits
//    e.valid := valid
//    ready := e.ready
//  }
//}

//object GenericStreamOutPort {
//  def apply[T <: Data](gen: T, addrBits: Int) = {
//    new GenericStreamOutPort(gen, addrBits)
//  }
//}
//class GenericStreamInPort[T <: Data](gen: T, addrBits: Int) extends DecoupledIO(gen)  {
//  val addr = Input(UInt(addrBits.W))
//  override val ready = Output(Bool())
//  override val valid = Input(Bool())
//  override val bits = Input(gen)
//
//  def driveDefaultFlipped(): Unit = {
//    valid := false.B
//    bits := 0.U
//    addr := 0.U
//  }
//  def driveDefault(): Unit = {
//    ready := false.B
//  }
//
//}
//object GenericStreamInPort {
//  def apply[T <: Data](gen: T, addrBits: Int) = {
//    new GenericStreamInPort(gen, addrBits)
//  }
//}
//
//class StreamPortCommand(idBits: Int, dataBits: Int) extends Bundle {
//  val portId = UInt(idBits.W)
//  val write = Bool()
//  val writeData = UInt(dataBits.W)
//}
//class StreamPortCSRWrapperIO(ap: AcceleratorParams) extends Bundle {
//  val extCmd = Flipped(Valid(new StreamPortCommand(ap.streamPortIdBits, ap.streamWidth)))
//  val extResp = Valid(UInt(ap.streamWidth.W))
//  val streamInPorts = Vec(ap.numStreamInPorts, Flipped(new GenericStreamInPort(ap.streamWidth)))
//  val streamOutPorts = Vec(ap.numStreamOutPorts, new GenericStreamInPort(ap.streamWidth))
//}
//
//class StreamPortCSRWrapper(ap: AcceleratorParams) extends Module {
//  val io = IO(new StreamPortCSRWrapperIO(ap))
//
//  io.streamInPorts.foreach(_.driveDefaultFlipped())
//  io.streamOutPorts.foreach(_.driveDefault())
//  io.extResp.valid := false.B
//  io.extResp.bits := 0.U
//  // latch the incoming commands
//  val regCommand = Reg(io.extCmd.bits)
//  val regDoCmd = RegInit(false.B)
//  val wStall = WireDefault(false.B)
//
//  assert(!wStall, "[GenericStreamPort.scala] Stall in the Muxer. We risk losing data")
//
//  when (!wStall) {
//    regCommand := io.extCmd.bits
//    regDoCmd := io.extCmd.valid
//  } otherwise {
//    assert(!io.extCmd.valid, "[GenericStreamPort.scala] Lost a incoming command due to stalling")
//  }
//
//  val hasExtReadCommand = (regDoCmd && !regCommand.write)
//  val hasExtWriteCommand = (regDoCmd && regCommand.write)
//
//  when (hasExtReadCommand) {
//    val idx = WireInit(regCommand.portId)
//    assert(idx < ap.numStreamInPorts.U)
//
//    io.streamOutPorts(idx).data.ready := true.B
//    io.extResp.bits := io.streamOutPorts(idx).data.bits
//    io.extResp.valid := io.streamOutPorts(idx).data.valid
//
//    // Make sure that the output port actually has data.
//    wStall := !io.streamOutPorts(idx).data.fire
//  }
//
//  when (hasExtWriteCommand) {
//    val idx = WireInit(regCommand.portId - ap.numStreamOutPorts.U)
//    assert(idx < ap.numStreamInPorts.U)
//
//    io.streamInPorts(idx).data.bits := regCommand.writeData
//    io.streamInPorts(idx).data.valid := true.B
//
//    wStall := io.streamInPorts(idx).data.fire
//  }
//}
//
object GenericStreamPort {
//  def handle
}
//
//// First handle the streaming ports. Each streaming port has the following iface:
//// addr, ready, valid, bits. These are all mapped to individual registers which is then connected the accelIO
