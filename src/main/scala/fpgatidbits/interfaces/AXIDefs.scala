package fpgatidbits.axi

import Chisel._

// Part I: Definitions for the actual data carried over AXI channels
// in part II we will provide definitions for the actual AXI interfaces
// by wrapping the part I types in Decoupled (ready/valid) bundles

// AXI channel data definitions

class AXIAddress(addrWidthBits: Int, idBits: Int) extends Bundle {
  // address for the transaction, should be burst aligned if bursts are used
  val addr    = UInt(width = addrWidthBits)
  // size of data beat in bytes
  // set to UInt(log2Ceil((dataBits/8)-1)) for full-width bursts
  val size    = UInt(width = 3)
  // number of data beats -1 in burst: max 255 for incrementing, 15 for wrapping
  val len     = UInt(width = 8)
  // burst mode: 0 for fixed, 1 for incrementing, 2 for wrapping
  val burst   = UInt(width = 2)
  // transaction ID for multiple outstanding requests
  val id      = UInt(width = idBits)
  // set to 1 for exclusive access
  val lock    = Bool()
  // cachability, set to 0010 or 0011
  val cache   = UInt(width = 4)
  // generally ignored, set to to all zeroes
  val prot    = UInt(width = 3)
  // not implemented, set to zeroes
  val qos     = UInt(width = 4)
  override def clone = { new AXIAddress(addrWidthBits, idBits).asInstanceOf[this.type] }
}

class AXIWriteData(dataWidthBits: Int) extends Bundle {
  val data    = UInt(width = dataWidthBits)
  val strb    = UInt(width = dataWidthBits/8)
  val last    = Bool()
  override def clone = { new AXIWriteData(dataWidthBits).asInstanceOf[this.type] }
}

class AXIWriteResponse(idBits: Int) extends Bundle {
  val id      = UInt(width = idBits)
  val resp    = UInt(width = 2)
  override def clone = { new AXIWriteResponse(idBits).asInstanceOf[this.type] }
}

class AXIReadData(dataWidthBits: Int, idBits: Int) extends Bundle {
  val data    = UInt(width = dataWidthBits)
  val id      = UInt(width = idBits)
  val last    = Bool()
  val resp    = UInt(width = 2)
  override def clone = { new AXIReadData(dataWidthBits, idBits).asInstanceOf[this.type] }
}



// Part II: Definitions for the actual AXI interfaces

// TODO add full slave interface definition

class AXIMasterIF(addrWidthBits: Int, dataWidthBits: Int, idBits: Int) extends Bundle {
  // write address channel
  val writeAddr   = Decoupled(new AXIAddress(addrWidthBits, idBits))
  // write data channel
  val writeData   = Decoupled(new AXIWriteData(dataWidthBits))
  // write response channel (for memory consistency)
  val writeResp   = Decoupled(new AXIWriteResponse(idBits)).flip

  // read address channel
  val readAddr    = Decoupled(new AXIAddress(addrWidthBits, idBits))
  // read data channel
  val readData    = Decoupled(new AXIReadData(dataWidthBits, idBits)).flip

  // drive default/"harmless" values to leave no output uninitialized
  def driveDefaults() {
    writeAddr.valid := false.B
    writeData.valid := false.B
    writeResp.ready := false.B
    readAddr.valid := false.B
    readData.ready := false.B
    // write address channel
    writeAddr.bits.addr := 0.U
    writeAddr.bits.prot := 0.U
    writeAddr.bits.size := 0.U
    writeAddr.bits.len := 0.U
    writeAddr.bits.burst := 0.U
    writeAddr.bits.lock := false.B
    writeAddr.bits.cache := 0.U
    writeAddr.bits.qos := 0.U
    writeAddr.bits.id := 0.U
    // write data channel
    writeData.bits.data := 0.U
    writeData.bits.strb := 0.U
    writeData.bits.last := false.B
    // read address channel
    readAddr.bits.addr := 0.U
    readAddr.bits.prot := 0.U
    readAddr.bits.size := 0.U
    readAddr.bits.len := 0.U
    readAddr.bits.burst := 0.U
    readAddr.bits.lock := false.B
    readAddr.bits.cache := 0.U
    readAddr.bits.qos := 0.U
    readAddr.bits.id := 0.U
  }

  // rename signals to be compatible with those in the Xilinx template
  def renameSignals(ifName: String) {
    // write address channel
    writeAddr.bits.addr.suggestName(ifName + "_AWADDR")
    writeAddr.bits.prot.suggestName(ifName + "_AWPROT")
    writeAddr.bits.size.suggestName(ifName + "_AWSIZE")
    writeAddr.bits.len.suggestName(ifName + "_AWLEN")
    writeAddr.bits.burst.suggestName(ifName + "_AWBURST")
    writeAddr.bits.lock.suggestName(ifName + "_AWLOCK")
    writeAddr.bits.cache.suggestName(ifName + "_AWCACHE")
    writeAddr.bits.qos.suggestName(ifName + "_AWQOS")
    writeAddr.bits.id.suggestName(ifName + "_AWID")
    writeAddr.valid.suggestName(ifName + "_AWVALID")
    writeAddr.ready.suggestName(ifName + "_AWREADY")
    // write data channel
    writeData.bits.data.suggestName(ifName + "_WDATA")
    writeData.bits.strb.suggestName(ifName + "_WSTRB")
    writeData.bits.last.suggestName(ifName + "_WLAST")
    writeData.valid.suggestName(ifName + "_WVALID")
    writeData.ready.suggestName(ifName + "_WREADY")
    // write response channel
    writeResp.bits.resp.suggestName(ifName + "_BRESP")
    writeResp.bits.id.suggestName(ifName + "_BID")
    writeResp.valid.suggestName(ifName + "_BVALID")
    writeResp.ready.suggestName(ifName + "_BREADY")
    // read address channel
    readAddr.bits.addr.suggestName(ifName + "_ARADDR")
    readAddr.bits.prot.suggestName(ifName + "_ARPROT")
    readAddr.bits.size.suggestName(ifName + "_ARSIZE")
    readAddr.bits.len.suggestName(ifName + "_ARLEN")
    readAddr.bits.burst.suggestName(ifName + "_ARBURST")
    readAddr.bits.lock.suggestName(ifName + "_ARLOCK")
    readAddr.bits.cache.suggestName(ifName + "_ARCACHE")
    readAddr.bits.qos.suggestName(ifName + "_ARQOS")
    readAddr.bits.id.suggestName(ifName + "_ARID")
    readAddr.valid.suggestName(ifName + "_ARVALID")
    readAddr.ready.suggestName(ifName + "_ARREADY")
    // read data channel
    readData.bits.id.suggestName(ifName + "_RID")
    readData.bits.data.suggestName(ifName + "_RDATA")
    readData.bits.resp.suggestName(ifName + "_RRESP")
    readData.bits.last.suggestName(ifName + "_RLAST")
    readData.valid.suggestName(ifName + "_RVALID")
    readData.ready.suggestName(ifName + "_RREADY")
  }

  override def clone = { new AXIMasterIF(addrWidthBits, dataWidthBits, idBits).asInstanceOf[this.type] }
}


class AXIMasterReadOnlyIF(addrWidthBits: Int, dataWidthBits: Int, idBits: Int) extends Bundle {

  // read address channel
  val readAddr    = Decoupled(new AXIAddress(addrWidthBits, idBits))
  // read data channel
  val readData    = Decoupled(new AXIReadData(dataWidthBits, idBits)).flip

  // rename signals to be compatible with those in the Xilinx template
  def renameSignals(ifName: String) {
    // read address channel
    readAddr.bits.addr.suggestName(ifName + "_ARADDR")
    readAddr.bits.prot.suggestName(ifName + "_ARPROT")
    readAddr.bits.size.suggestName(ifName + "_ARSIZE")
    readAddr.bits.len.suggestName(ifName + "_ARLEN")
    readAddr.bits.burst.suggestName(ifName + "_ARBURST")
    readAddr.bits.lock.suggestName(ifName + "_ARLOCK")
    readAddr.bits.cache.suggestName(ifName + "_ARCACHE")
    readAddr.bits.qos.suggestName(ifName + "_ARQOS")
    readAddr.bits.id.suggestName(ifName + "_ARID")
    readAddr.valid.suggestName(ifName + "_ARVALID")
    readAddr.ready.suggestName(ifName + "_ARREADY")
    // read data channel
    readData.bits.id.suggestName(ifName + "_RID")
    readData.bits.data.suggestName(ifName + "_RDATA")
    readData.bits.resp.suggestName(ifName + "_RRESP")
    readData.bits.last.suggestName(ifName + "_RLAST")
    readData.valid.suggestName(ifName + "_RVALID")
    readData.ready.suggestName(ifName + "_RREADY")
  }

  override def clone = { new AXIMasterReadOnlyIF(addrWidthBits, dataWidthBits, idBits).asInstanceOf[this.type] }
}
