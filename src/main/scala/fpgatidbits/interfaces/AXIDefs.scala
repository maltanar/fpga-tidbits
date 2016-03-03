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
  // set to UInt(log2Up((dataBits/8)-1)) for full-width bursts
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
    writeAddr.valid := Bool(false)
    writeData.valid := Bool(false)
    writeResp.ready := Bool(false)
    readAddr.valid := Bool(false)
    readData.ready := Bool(false)
    // write address channel
    writeAddr.bits.addr := UInt(0)
    writeAddr.bits.prot := UInt(0)
    writeAddr.bits.size := UInt(0)
    writeAddr.bits.len := UInt(0)
    writeAddr.bits.burst := UInt(0)
    writeAddr.bits.lock := Bool(false)
    writeAddr.bits.cache := UInt(0)
    writeAddr.bits.qos := UInt(0)
    writeAddr.bits.id := UInt(0)
    // write data channel
    writeData.bits.data := UInt(0)
    writeData.bits.strb := UInt(0)
    writeData.bits.last := Bool(false)
    // read address channel
    readAddr.bits.addr := UInt(0)
    readAddr.bits.prot := UInt(0)
    readAddr.bits.size := UInt(0)
    readAddr.bits.len := UInt(0)
    readAddr.bits.burst := UInt(0)
    readAddr.bits.lock := Bool(false)
    readAddr.bits.cache := UInt(0)
    readAddr.bits.qos := UInt(0)
    readAddr.bits.id := UInt(0)
  }

  // rename signals to be compatible with those in the Xilinx template
  def renameSignals(ifName: String) {
    // write address channel
    writeAddr.bits.addr.setName(ifName + "_AWADDR")
    writeAddr.bits.prot.setName(ifName + "_AWPROT")
    writeAddr.bits.size.setName(ifName + "_AWSIZE")
    writeAddr.bits.len.setName(ifName + "_AWLEN")
    writeAddr.bits.burst.setName(ifName + "_AWBURST")
    writeAddr.bits.lock.setName(ifName + "_AWLOCK")
    writeAddr.bits.cache.setName(ifName + "_AWCACHE")
    writeAddr.bits.qos.setName(ifName + "_AWQOS")
    writeAddr.bits.id.setName(ifName + "_AWID")
    writeAddr.valid.setName(ifName + "_AWVALID")
    writeAddr.ready.setName(ifName + "_AWREADY")
    // write data channel
    writeData.bits.data.setName(ifName + "_WDATA")
    writeData.bits.strb.setName(ifName + "_WSTRB")
    writeData.bits.last.setName(ifName + "_WLAST")
    writeData.valid.setName(ifName + "_WVALID")
    writeData.ready.setName(ifName + "_WREADY")
    // write response channel
    writeResp.bits.resp.setName(ifName + "_BRESP")
    writeResp.bits.id.setName(ifName + "_BID")
    writeResp.valid.setName(ifName + "_BVALID")
    writeResp.ready.setName(ifName + "_BREADY")
    // read address channel
    readAddr.bits.addr.setName(ifName + "_ARADDR")
    readAddr.bits.prot.setName(ifName + "_ARPROT")
    readAddr.bits.size.setName(ifName + "_ARSIZE")
    readAddr.bits.len.setName(ifName + "_ARLEN")
    readAddr.bits.burst.setName(ifName + "_ARBURST")
    readAddr.bits.lock.setName(ifName + "_ARLOCK")
    readAddr.bits.cache.setName(ifName + "_ARCACHE")
    readAddr.bits.qos.setName(ifName + "_ARQOS")
    readAddr.bits.id.setName(ifName + "_ARID")
    readAddr.valid.setName(ifName + "_ARVALID")
    readAddr.ready.setName(ifName + "_ARREADY")
    // read data channel
    readData.bits.id.setName(ifName + "_RID")
    readData.bits.data.setName(ifName + "_RDATA")
    readData.bits.resp.setName(ifName + "_RRESP")
    readData.bits.last.setName(ifName + "_RLAST")
    readData.valid.setName(ifName + "_RVALID")
    readData.ready.setName(ifName + "_RREADY")
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
    readAddr.bits.addr.setName(ifName + "_ARADDR")
    readAddr.bits.prot.setName(ifName + "_ARPROT")
    readAddr.bits.size.setName(ifName + "_ARSIZE")
    readAddr.bits.len.setName(ifName + "_ARLEN")
    readAddr.bits.burst.setName(ifName + "_ARBURST")
    readAddr.bits.lock.setName(ifName + "_ARLOCK")
    readAddr.bits.cache.setName(ifName + "_ARCACHE")
    readAddr.bits.qos.setName(ifName + "_ARQOS")
    readAddr.bits.id.setName(ifName + "_ARID")
    readAddr.valid.setName(ifName + "_ARVALID")
    readAddr.ready.setName(ifName + "_ARREADY")
    // read data channel
    readData.bits.id.setName(ifName + "_RID")
    readData.bits.data.setName(ifName + "_RDATA")
    readData.bits.resp.setName(ifName + "_RRESP")
    readData.bits.last.setName(ifName + "_RLAST")
    readData.valid.setName(ifName + "_RVALID")
    readData.ready.setName(ifName + "_RREADY")
  }

  override def clone = { new AXIMasterReadOnlyIF(addrWidthBits, dataWidthBits, idBits).asInstanceOf[this.type] }
}
