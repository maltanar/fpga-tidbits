package fpgatidbits.axi

import Chisel._

// Part I: Definitions for the actual data carried over AXI channels
// in part II we will provide definitions for the actual AXI interfaces
// by wrapping the part I types in Decoupled (ready/valid) bundles


// AXI Lite channel data definitions

class AXILiteAddress(addrWidthBits: Int) extends Bundle {
  val addr    = UInt(width = addrWidthBits)
  val prot    = UInt(width = 3)
  override def clone = { new AXILiteAddress(addrWidthBits).asInstanceOf[this.type] }
}

class AXILiteWriteData(dataWidthBits: Int) extends Bundle {
  val data    = UInt(width = dataWidthBits)
  val strb    = UInt(width = dataWidthBits/8)
  override def clone = { new AXILiteWriteData(dataWidthBits).asInstanceOf[this.type] }
}

class AXILiteReadData(dataWidthBits: Int) extends Bundle {
  val data    = UInt(width = dataWidthBits)
  val resp    = UInt(width = 2)
  override def clone = { new AXILiteReadData(dataWidthBits).asInstanceOf[this.type] }
}

// Part II: Definitions for the actual AXI interfaces

class AXILiteSlaveIF(addrWidthBits: Int, dataWidthBits: Int) extends Bundle {
  // write address channel
  val writeAddr   = Decoupled(new AXILiteAddress(addrWidthBits)).flip
  // write data channel
  val writeData   = Decoupled(new AXILiteWriteData(dataWidthBits)).flip
  // write response channel (for memory consistency)
  val writeResp   = Decoupled(UInt(width = 2))

  // read address channel
  val readAddr    = Decoupled(new AXILiteAddress(addrWidthBits)).flip
  // read data channel
  val readData    = Decoupled(new AXILiteReadData(dataWidthBits))

  // rename signals to be compatible with those in the Xilinx template
  def renameSignals(ifName: String) {
    writeAddr.bits.addr.setName(ifName + "_AWADDR")
    writeAddr.bits.prot.setName(ifName + "_AWPROT")
    writeAddr.valid.setName(ifName + "_AWVALID")
    writeAddr.ready.setName(ifName + "_AWREADY")
    writeData.bits.data.setName(ifName + "_WDATA")
    writeData.bits.strb.setName(ifName + "_WSTRB")
    writeData.valid.setName(ifName + "_WVALID")
    writeData.ready.setName(ifName + "_WREADY")
    writeResp.bits.setName(ifName + "_BRESP")
    writeResp.valid.setName(ifName + "_BVALID")
    writeResp.ready.setName(ifName + "_BREADY")
    readAddr.bits.addr.setName(ifName + "_ARADDR")
    readAddr.bits.prot.setName(ifName + "_ARPROT")
    readAddr.valid.setName(ifName + "_ARVALID")
    readAddr.ready.setName(ifName + "_ARREADY")
    readData.bits.data.setName(ifName + "_RDATA")
    readData.bits.resp.setName(ifName + "_RRESP")
    readData.valid.setName(ifName + "_RVALID")
    readData.ready.setName(ifName + "_RREADY")
  }

  override def clone = { new AXILiteSlaveIF(addrWidthBits, dataWidthBits).asInstanceOf[this.type] }
}



class AXILiteMasterIF(addrWidthBits: Int, dataWidthBits: Int) extends Bundle {
  // write address channel
  val writeAddr   = Decoupled(new AXILiteAddress(addrWidthBits))
  // write data channel
  val writeData   = Decoupled(new AXILiteWriteData(dataWidthBits))
  // write response channel (for memory consistency)
  val writeResp   = Decoupled(UInt(width = 2)).flip

  // read address channel
  val readAddr    = Decoupled(new AXILiteAddress(addrWidthBits))
  // read data channel
  val readData    = Decoupled(new AXILiteReadData(dataWidthBits)).flip

  // rename signals to be compatible with those in the Xilinx template
  def renameSignals(ifName: String) {
    writeAddr.bits.addr.setName(ifName + "_AWADDR")
    writeAddr.bits.prot.setName(ifName + "_AWPROT")
    writeAddr.valid.setName(ifName + "_AWVALID")
    writeAddr.ready.setName(ifName + "_AWREADY")
    writeData.bits.data.setName(ifName + "_WDATA")
    writeData.bits.strb.setName(ifName + "_WSTRB")
    writeData.valid.setName(ifName + "_WVALID")
    writeData.ready.setName(ifName + "_WREADY")
    writeResp.bits.setName(ifName + "_BRESP")
    writeResp.valid.setName(ifName + "_BVALID")
    writeResp.ready.setName(ifName + "_BREADY")
    readAddr.bits.addr.setName(ifName + "_ARADDR")
    readAddr.bits.prot.setName(ifName + "_ARPROT")
    readAddr.valid.setName(ifName + "_ARVALID")
    readAddr.ready.setName(ifName + "_ARREADY")
    readData.bits.data.setName(ifName + "_RDATA")
    readData.bits.resp.setName(ifName + "_RRESP")
    readData.valid.setName(ifName + "_RVALID")
    readData.ready.setName(ifName + "_RREADY")
  }

  override def clone = { new AXILiteMasterIF(addrWidthBits, dataWidthBits).asInstanceOf[this.type] }
}

class AXILiteMasterWriteOnlyIF(addrWidthBits: Int, dataWidthBits: Int) extends Bundle {
  // write address channel
  val writeAddr   = Decoupled(new AXILiteAddress(addrWidthBits))
  // write data channel
  val writeData   = Decoupled(new AXILiteWriteData(dataWidthBits))
  // write response channel (for memory consistency)
  val writeResp   = Decoupled(UInt(width = 2)).flip

  // rename signals to be compatible with those in the Xilinx template
  def renameSignals(ifName: String) {
    writeAddr.bits.addr.setName(ifName + "_AWADDR")
    writeAddr.bits.prot.setName(ifName + "_AWPROT")
    writeAddr.valid.setName(ifName + "_AWVALID")
    writeAddr.ready.setName(ifName + "_AWREADY")
    writeData.bits.data.setName(ifName + "_WDATA")
    writeData.bits.strb.setName(ifName + "_WSTRB")
    writeData.valid.setName(ifName + "_WVALID")
    writeData.ready.setName(ifName + "_WREADY")
    writeResp.bits.setName(ifName + "_BRESP")
    writeResp.valid.setName(ifName + "_BVALID")
    writeResp.ready.setName(ifName + "_BREADY")
  }

  override def clone = { new AXILiteMasterWriteOnlyIF(addrWidthBits, dataWidthBits).asInstanceOf[this.type] }
}
