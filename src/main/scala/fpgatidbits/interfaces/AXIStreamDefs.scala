package fpgatidbits.axi

import chisel3._
import chisel3.util._

// Define simple extensions of the Chisel Decoupled interfaces,
// with signal renaming to support auto inference of AXI stream interfaces in Vivado
/*

class AXIStreamMasterIF[T <: Data](gen: T) extends DecoupledIO(gen) {
  def renameSignals(ifName: String) {
    ready.suggestName(ifName + "_TREADY")
    valid.suggestName(ifName + "_TVALID")
    bits.suggestName(ifName + "_TDATA")
  }

  override def clone: this.type = { new AXIStreamMasterIF(gen).asInstanceOf[this.type]; }
}

class AXIStreamSlaveIF[T <: Data](gen: T) extends DecoupledIO(gen) {
  flip()
  def renameSignals(ifName: String) {
    ready.suggestName(ifName + "_TREADY")
    valid.suggestName(ifName + "_TVALID")
    bits.suggestName(ifName + "_TDATA")
  }

  override def clone: this.type = { new AXIStreamSlaveIF(gen).asInstanceOf[this.type]; }
}
*/


// FIXME: Create an AXIStreamSlave and Master and make them
class AXIStreamSlaveIF[T <: Data](private val gen: T) extends Bundle {
  val TREADY = Input(Bool())
  val TVALID = Output(Bool())
  val TDATA = Output(gen)
}
