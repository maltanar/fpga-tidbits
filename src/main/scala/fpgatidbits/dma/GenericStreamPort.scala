package fpgatidbits.dma

import chisel3._
import chisel3.util._

class GenericStreamInPort(width: Int) extends Bundle {
  val data = Flipped(Decoupled(UInt(width.W)))

  def driveDefault(): Unit = {
    data.ready := false.B
  }
}

class GenericStreamOutPort(width: Int) extends Bundle {
  val data = Decoupled(UInt(width.W))

  def driveDefault(): Unit = {
    data.valid := false.B
    data.bits := 0.U
  }
}
