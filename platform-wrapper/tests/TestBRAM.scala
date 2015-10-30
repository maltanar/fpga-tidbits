package TidbitsTestbenches

import Chisel._
import TidbitsPlatformWrapper._
import TidbitsDMA._
import TidbitsStreams._
import TidbitsOCM._


class TestBRAM(p: PlatformWrapperParams) extends GenericAccelerator(p) {
  val numMemPorts = 0
  val io = new GenericAcceleratorIF(numMemPorts, p) {
    val ports = Vec.fill (2) {new OCMSlaveIF(32, 32, 10)}
  }
  io.signature := makeDefaultSignature()

  val mem = Mem(UInt(width = 32), 1024)

  // TODO implement r/w logic

}
