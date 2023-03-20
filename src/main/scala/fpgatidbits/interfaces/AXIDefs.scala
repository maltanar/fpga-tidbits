package fpgatidbits.axi

import chisel3._
import chisel3.util._


// Part 0: The definitions of the actual external AXI interface exposed to the rest of the system
//  currently we have the Xilinx system in mind and do naming based on that.
//  The AXIExternalIF is instantiated in the Top level of our accelerator and provides the external interface
//  It is done in this way so that we can adhere to the naming standards expected by Vivado. It will recognize
//  this as an AXI memory mapped master/slave and we can click and connect it to other IP
//  We also provide functions for connecting our internal representation (introduced in Part 1) to this

class AXIExternalIF(addrWidthBits: Int, dataWidthBits:Int, idBits: Int) extends Bundle {

    // Read address channel
    val ARADDR = Output(UInt(addrWidthBits.W))
    val ARSIZE = Output(UInt(3.W))
    val ARLEN = Output(UInt(8.W))
    val ARBURST = Output(UInt(2.W))
    val ARID = Output(UInt(idBits.W))
    val ARLOCK = Output(Bool())
    val ARCACHE = Output(UInt(4.W))
    val ARPROT = Output(UInt(3.W))
    val ARQOS = Output(UInt(4.W))
    val ARREADY = Input(Bool())
    val ARVALID = Output(Bool())

    // Write address channel
    val AWADDR = Output(UInt(addrWidthBits.W))
    val AWSIZE = Output(UInt(3.W))
    val AWLEN = Output(UInt(8.W))
    val AWBURST = Output(UInt(2.W))
    val AWID = Output(UInt(idBits.W))
    val AWLOCK = Output(Bool())
    val AWCACHE = Output(UInt(4.W))
    val AWPROT = Output(UInt(3.W))
    val AWQOS = Output(UInt(4.W))
    val AWREADY = Input(Bool())
    val AWVALID = Output(Bool())

    // Write data channel
    val WDATA = Output(UInt(dataWidthBits.W))
    val WSTRB = Output(UInt((dataWidthBits / 8).W))
    val WLAST = Output(Bool())
    val WVALID = Output(Bool())
    val WREADY = Input(Bool())

    // Write response channel
    val BRESP = Input(UInt(2.W))
    val BID = Input(UInt(idBits.W))
    val BVALID = Input(Bool())
    val BREADY = Output(Bool())

    // Read response channel
    val RID = Input(UInt(idBits.W))
    val RDATA = Input(UInt(dataWidthBits.W))
    val RRESP = Input(UInt(2.W))
    val RLAST = Input(Bool())
    val RVALID = Input(Bool())
    val RREADY = Output(Bool())

    //
  def connect(in: AXIMasterIF): Unit  = {
    // Write address
    AWADDR := in.writeAddr.bits.addr
    AWPROT := in.writeAddr.bits.prot
    AWSIZE := in.writeAddr.bits.size
    AWLEN := in.writeAddr.bits.len
    AWBURST := in.writeAddr.bits.burst
    AWLOCK := in.writeAddr.bits.lock
    AWCACHE := in.writeAddr.bits.cache
    AWQOS := in.writeAddr.bits.qos
    AWID := in.writeAddr.bits.id
    AWVALID := in.writeAddr.valid
    in.writeAddr.ready := AWREADY
    //read address
    ARADDR:=in.readAddr.bits.addr
    ARPROT :=in.readAddr.bits.prot
    ARSIZE :=in.readAddr.bits.size
    ARLEN :=in.readAddr.bits.len
    ARBURST :=in.readAddr.bits.burst
    ARLOCK :=in.readAddr.bits.lock
    ARCACHE :=in.readAddr.bits.cache
    ARQOS :=in.readAddr.bits.qos
    ARID :=in.readAddr.bits.id
    ARVALID := in.readAddr.valid
    in.readAddr.ready := ARREADY
    // write data
    WDATA := in.writeData.bits.data
    WSTRB := in.writeData.bits.strb
    WLAST := in.writeData.bits.last
    WVALID := in.writeData.valid
    in.writeData.ready := WREADY

    // write resp
    in.writeResp.bits.resp := BRESP;
    in.writeResp.bits.id := BID
    in.writeResp.valid := BVALID
    BREADY := in.writeResp.ready

    // read resp
    RREADY := in.readData.ready
    in.readData.valid := RVALID
    in.readData.bits.data := RDATA
    in.readData.bits.resp := RRESP
    in.readData.bits.last := RLAST
    in.readData.bits.id := RID
  }

  override def cloneType = { new AXIExternalIF(addrWidthBits, dataWidthBits, idBits).asInstanceOf[this.type] }
}


class AXIReadOnlyExternalIF(addrWidthBits: Int, dataWidthBits:Int, idBits: Int) extends Bundle {

  // Read address channel
  val ARADDR = Output(UInt(addrWidthBits.W))
  val ARSIZE = Output(UInt(3.W))
  val ARLEN = Output(UInt(8.W))
  val ARBURST = Output(UInt(2.W))
  val ARID = Output(UInt(idBits.W))
  val ARLOCK = Output(Bool())
  val ARCACHE = Output(UInt(4.W))
  val ARPROT = Output(UInt(3.W))
  val ARQOS = Output(UInt(4.W))
  val ARREADY = Input(Bool())
  val ARVALID = Output(Bool())

  // Read response channel
  val RID = Input(UInt(idBits.W))
  val RDATA = Input(UInt(dataWidthBits.W))
  val RRESP = Input(UInt(2.W))
  val RLAST = Input(Bool())
  val RVALID = Input(Bool())
  val RREADY = Output(Bool())

  //
  def connect(in: AXIMasterReadOnlyIF): Unit  = {
    //read address
    ARADDR:=in.readAddr.bits.addr
    ARPROT :=in.readAddr.bits.prot
    ARSIZE :=in.readAddr.bits.size
    ARLEN :=in.readAddr.bits.len
    ARBURST :=in.readAddr.bits.burst
    ARLOCK :=in.readAddr.bits.lock
    ARCACHE :=in.readAddr.bits.cache
    ARQOS :=in.readAddr.bits.qos
    ARID :=in.readAddr.bits.id
    ARVALID := in.readAddr.valid
    in.readAddr.ready := ARREADY

    // read resp
    RREADY := in.readData.ready
    in.readData.valid := RVALID
    in.readData.bits.data := RDATA
    in.readData.bits.resp := RRESP
    in.readData.bits.last := RLAST
    in.readData.bits.id := RID
  }
  override def cloneType = { new AXIReadOnlyExternalIF(addrWidthBits, dataWidthBits, idBits).asInstanceOf[this.type] }
}

// Part I: Definitions for the actual data carried over AXI channels
// in part II we will provide definitions for the actual AXI interfaces
// by wrapping the part I types in Decoupled (ready/valid) bundles

// AXI channel data definitions

class AXIAddress(addrWidthBits: Int, idBits: Int) extends Bundle {
  // address for the transaction, should be burst aligned if bursts are used
  val addr    = UInt(addrWidthBits.W)
  // size of data beat in bytes
  // set to UInt(log2Ceil((dataBits/8)-1)) for full-width bursts
  val size    = UInt(3.W)
  // number of data beats -1 in burst: max 255 for incrementing, 15 for wrapping
  val len     = UInt(8.W)
  // burst mode: 0 for fixed, 1 for incrementing, 2 for wrapping
  val burst   = UInt(2.W)
  // transaction ID for multiple outstanding requests
  val id      = UInt(idBits.W)
  // set to 1 for exclusive access
  val lock    = Bool()
  // cachability, set to 0010 or 0011
  val cache   = UInt(4.W)
  // generally ignored, set to to all zeroes
  val prot    = UInt(3.W)
  // not implemented, set to zeroes
  val qos     = UInt(4.W)
  override def cloneType = { new AXIAddress(addrWidthBits, idBits).asInstanceOf[this.type] }
}

class AXIWriteData(dataWidthBits: Int) extends Bundle {
  val data    = UInt(dataWidthBits.W)
  val strb    = UInt((dataWidthBits/8).W)
  val last    = Bool()
  override def cloneType = { new AXIWriteData(dataWidthBits).asInstanceOf[this.type] }
}

class AXIWriteResponse(idBits: Int) extends Bundle {
  val id      = UInt(idBits.W)
  val resp    = UInt(2.W)
  override def cloneType = { new AXIWriteResponse(idBits).asInstanceOf[this.type] }
}

class AXIReadData(dataWidthBits: Int, idBits: Int) extends Bundle {
  val data    = UInt(dataWidthBits.W)
  val id      = UInt(idBits.W)
  val last    = Bool()
  val resp    = UInt(2.W)
  override def cloneType = { new AXIReadData(dataWidthBits, idBits).asInstanceOf[this.type] }
}



// Part II: Definitions for the actual AXI interfaces

// TODO add full slave interface definition

class AXIMasterIF(addrWidthBits: Int, dataWidthBits: Int, idBits: Int) extends Bundle {
  // write address channel
  val writeAddr   = Decoupled(new AXIAddress(addrWidthBits, idBits))
  // write data channel
  val writeData   = Decoupled(new AXIWriteData(dataWidthBits))
  // write response channel (for memory consistency)
  val writeResp   = Flipped(Decoupled(new AXIWriteResponse(idBits)))

  // read address channel
  val readAddr    = Decoupled(new AXIAddress(addrWidthBits, idBits))
  // read data channel
  val readData    = Flipped(Decoupled(new AXIReadData(dataWidthBits, idBits)))

  // drive default/"harmless" values to leave no output uninitialized
  def driveDefaults(): Unit = {
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

  override def cloneType = { new AXIMasterIF(addrWidthBits, dataWidthBits, idBits).asInstanceOf[this.type] }
}


class AXIMasterReadOnlyIF(addrWidthBits: Int, dataWidthBits: Int, idBits: Int) extends Bundle {

  // read address channel
  val readAddr    = Decoupled(new AXIAddress(addrWidthBits, idBits))
  // read data channel
  val readData    = Flipped(Decoupled(new AXIReadData(dataWidthBits, idBits)))

  // rename signals to be compatible with those in the Xilinx template
  def renameSignals(ifName: String): Unit =  {
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

  override def cloneType = { new AXIMasterReadOnlyIF(addrWidthBits, dataWidthBits, idBits).asInstanceOf[this.type] }
}
