package fpgatidbits.axi

import chisel3._
import chisel3.util._

class AXIStreamIF[T <: Data](gen: T) extends DecoupledIO(gen) {
  ready.suggestName("TREADY")
  valid.suggestName("TVALID")
  bits.suggestName("TDATA")
}
