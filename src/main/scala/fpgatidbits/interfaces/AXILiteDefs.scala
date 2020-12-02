package fpgatidbits.axi

import chisel3._
import chisel3.util._

// Part 0: Definitons for the external AXILite interface. This is what is visible to the rest of the system
class AXILiteExternalIF(addrWidthBits: Int, dataWidthBits: Int) extends Bundle {
  // Read address channel
  val ARADDR = Output(UInt(addrWidthBits.W))
  val ARPROT = Output(UInt(3.W))
  val ARREADY = Input(Bool())
  val ARVALID = Output(Bool())

  // Write address channel
  val AWADDR = Output(UInt(addrWidthBits.W))
  val AWPROT = Output(UInt(3.W))
  val AWREADY = Input(Bool())
  val AWVALID = Output(Bool())

  // Write data channel
  val WDATA = Output(UInt(dataWidthBits.W))
  val WSTRB = Output(UInt((dataWidthBits / 8).W))
  val WVALID = Output(Bool())
  val WREADY = Input(Bool())

  // Write response channel
  val BRESP = Input(UInt(2.W))
  val BVALID = Input(Bool())
  val BREADY = Output(Bool())

  // Read response channel
  val RDATA = Input(UInt(dataWidthBits.W))
  val RRESP = Input(UInt(2.W))
  val RVALID = Input(Bool())
  val RREADY = Output(Bool())

  //
  def connect(in: AXILiteMasterIF): Unit  = {
    // Write address
    AWADDR := in.writeAddr.bits.addr
    AWPROT := in.writeAddr.bits.prot
    AWVALID := in.writeAddr.valid
    in.writeAddr.ready := AWREADY
    //read address
    ARADDR:=in.readAddr.bits.addr
    ARPROT :=in.readAddr.bits.prot
    ARVALID := in.readAddr.valid
    in.readAddr.ready := ARREADY
    // write data
    WDATA := in.writeData.bits.data
    WSTRB := in.writeData.bits.strb
    WVALID := in.writeData.valid
    in.writeData.ready := WREADY

    // write resp
    in.writeResp.valid := BVALID
    BREADY := in.writeResp.ready
    in.writeResp.bits := BRESP

    // read resp
    RREADY := in.readData.ready
    in.readData.valid := RVALID
    in.readData.bits.data := RDATA
    in.readData.bits.resp := RRESP
  }

  def connect(in: AXILiteSlaveIF) : Unit = {
    // Write address
    in.writeAddr.bits.addr := AWADDR
    in.writeAddr.bits.prot := AWPROT
    in.writeAddr.valid := AWVALID
    AWREADY := in.writeAddr.ready

    //read address
    in.readAddr.bits.addr := ARADDR
    in.readAddr.bits.prot := ARPROT
    in.readAddr.valid  := ARVALID
    ARREADY := in.readAddr.ready

      // write data
    in.writeData.bits.data :=  WDATA
    in.writeData.bits.strb :=  WSTRB
    in.writeData.valid := WVALID
    WREADY := in.writeData.ready

    // write resp
    BVALID := in.writeResp.valid
    in.writeResp.ready := BREADY
    BRESP := in.writeResp.bits

    // read resp
    in.readData.ready := RREADY
    RVALID := in.readData.valid
    RDATA := in.readData.bits.data
    RRESP := in.readData.bits.resp
  }

  override def cloneType = { new AXILiteExternalIF(addrWidthBits, dataWidthBits).asInstanceOf[this.type] }
}


class AXILiteWriteOnlyExternalIF(addrWidthBits: Int, dataWidthBits: Int) extends Bundle {

  // Write address channel
  val AWADDR = Output(UInt(addrWidthBits.W))
  val AWPROT = Output(UInt(3.W))
  val AWREADY = Input(Bool())
  val AWVALID = Output(Bool())

  // Write data channel
  val WDATA = Output(UInt(dataWidthBits.W))
  val WSTRB = Output(UInt((dataWidthBits / 8).W))
  val WVALID = Output(Bool())
  val WREADY = Input(Bool())

  // Write response channel
  val BRESP = Input(UInt(2.W))
  val BVALID = Input(Bool())
  val BREADY = Output(Bool())


  def connect(in: AXILiteMasterWriteOnlyIF): Unit  = {
    // Write address
    AWADDR := in.writeAddr.bits.addr
    AWPROT := in.writeAddr.bits.prot
    AWVALID := in.writeAddr.valid
    in.writeAddr.ready := AWREADY

    // write data
    WDATA := in.writeData.bits.data
    WSTRB := in.writeData.bits.strb
    WVALID := in.writeData.valid
    in.writeData.ready := WREADY

    // write resp
    in.writeResp.valid := BVALID
    BREADY := in.writeResp.ready
    in.writeResp.bits := BRESP

  }


  override def cloneType = { new AXILiteWriteOnlyExternalIF(addrWidthBits, dataWidthBits).asInstanceOf[this.type] }
}




// Part I: Definitions for the actual data carried over AXI channels
// in part II we will provide definitions for the actual AXI interfaces
// by wrapping the part I types in Decoupled (ready/valid) bundles


// AXI Lite channel data definitions

class AXILiteAddress(addrWidthBits: Int) extends Bundle {
  val addr    = UInt(addrWidthBits.W)
  val prot    = UInt(3.W)
  override def cloneType = { new AXILiteAddress(addrWidthBits).asInstanceOf[this.type] }
}

class AXILiteWriteData(dataWidthBits: Int) extends Bundle {
  val data    = UInt(dataWidthBits.W)
  val strb    = UInt((dataWidthBits/8).W)
  override def cloneType = { new AXILiteWriteData(dataWidthBits).asInstanceOf[this.type] }
}

class AXILiteReadData(dataWidthBits: Int) extends Bundle {
  val data    = UInt(dataWidthBits.W)
  val resp    = UInt(2.W)
  override def cloneType = { new AXILiteReadData(dataWidthBits).asInstanceOf[this.type] }
}

// Part II: Definitions for the actual AXI interfaces

class AXILiteSlaveIF(addrWidthBits: Int, dataWidthBits: Int) extends Bundle {
  // write address channel
  val writeAddr   = Flipped(Decoupled(new AXILiteAddress(addrWidthBits)))
  // write data channel
  val writeData   = Flipped(Decoupled(new AXILiteWriteData(dataWidthBits)))
  // write response channel (for memory consistency)
  val writeResp   = Decoupled(UInt(2.W))

  // read address channel
  val readAddr    = Flipped(Decoupled(new AXILiteAddress(addrWidthBits)))
  // read data channel
  val readData    = Decoupled(new AXILiteReadData(dataWidthBits))


  override def cloneType = { new AXILiteSlaveIF(addrWidthBits, dataWidthBits).asInstanceOf[this.type] }
}



class AXILiteMasterIF(addrWidthBits: Int, dataWidthBits: Int) extends Bundle {
  // write address channel
  val writeAddr   = Decoupled(new AXILiteAddress(addrWidthBits))
  // write data channel
  val writeData   = Decoupled(new AXILiteWriteData(dataWidthBits))
  // write response channel (for memory consistency)
  val writeResp   = Flipped(Decoupled(UInt(2.W)))

  // read address channel
  val readAddr    = Decoupled(new AXILiteAddress(addrWidthBits))
  // read data channel
  val readData    = Flipped(Decoupled(new AXILiteReadData(dataWidthBits)))


  override def cloneType = { new AXILiteMasterIF(addrWidthBits, dataWidthBits).asInstanceOf[this.type] }
}


class AXILiteMasterWriteOnlyIF(addrWidthBits: Int, dataWidthBits: Int) extends Bundle {
  // write address channel
  val writeAddr   = Decoupled(new AXILiteAddress(addrWidthBits))
  // write data channel
  val writeData   = Decoupled(new AXILiteWriteData(dataWidthBits))
  // write response channel (for memory consistency)
  val writeResp   = Flipped(Decoupled(UInt(2.W)))



  override def cloneType = { new AXILiteMasterWriteOnlyIF(addrWidthBits, dataWidthBits).asInstanceOf[this.type] }
}
