package fpgatidbits.dma

import Chisel._
import fpgatidbits.axi._

class AXIMemReqAdp(p: MemReqParams) extends Module {
  val io = new Bundle {
    val genericReqIn = Decoupled(new GenericMemoryRequest(p)).flip
    val axiReqOut = Decoupled(new AXIAddress(p.addrWidth, p.idWidth))
  }

  io.genericReqIn.ready := io.axiReqOut.ready
  io.axiReqOut.valid := io.genericReqIn.valid

  val reqIn = io.genericReqIn.bits
  val axiOut = io.axiReqOut.bits

  axiOut.addr := reqIn.addr
  axiOut.size := UInt(log2Up((p.dataWidth/8)-1)) // only full-width
  val beats = (reqIn.numBytes / UInt(p.dataWidth/8))
  axiOut.len := beats - UInt(1) // AXI defines len = beats-1
  axiOut.burst := UInt(1) // incrementing burst
  axiOut.id := reqIn.channelID
  axiOut.lock := Bool(false)
  // TODO use metadata to alter cache bits as desired?
  axiOut.cache := UInt("b0010") // no alloc, modifiable, no buffer
  axiOut.prot := UInt(0)
  axiOut.qos := UInt(0)
}

class AXIReadRspAdp(p: MemReqParams) extends Module {
  val io = new Bundle {
    val axiReadRspIn = Decoupled(new AXIReadData(p.dataWidth, p.idWidth)).flip
    val genericRspOut = Decoupled(new GenericMemoryResponse(p))
  }
  io.genericRspOut.valid := io.axiReadRspIn.valid
  io.axiReadRspIn.ready := io.genericRspOut.ready

  val axiIn = io.axiReadRspIn.bits
  val rspOut = io.genericRspOut.bits

  rspOut.readData := axiIn.data
  rspOut.channelID := axiIn.id
  rspOut.metaData := UInt(0) // TODO add resp code from AXI response?
  rspOut.isWrite := Bool(false)
  rspOut.isLast := axiIn.last
}

class AXIWriteRspAdp(p: MemReqParams) extends Module {
  val io = new Bundle {
    val axiWriteRspIn = Decoupled(new AXIWriteResponse(p.idWidth)).flip
    val genericRspOut = Decoupled(new GenericMemoryResponse(p))
  }
  io.genericRspOut.valid := io.axiWriteRspIn.valid
  io.axiWriteRspIn.ready := io.genericRspOut.ready

  val axiIn = io.axiWriteRspIn.bits
  val rspOut = io.genericRspOut.bits

  rspOut.readData := UInt(0)
  rspOut.channelID := axiIn.id
  rspOut.metaData := UInt(0) // TODO add resp from AXI response?
  rspOut.isWrite := Bool(true)
  rspOut.isLast := Bool(false)  // not applicable for write responses
}

class AXIReqToGenReqAdp(axiAddrW: Int, axiIDW: Int, p: MemReqParams) extends Module {
  val io = new Bundle {
    val axiReqIn = Decoupled(new AXIAddress(axiAddrW, axiIDW)).flip
    val genericReqOut = Decoupled(new GenericMemoryRequest(p))
  }

  io.genericReqOut.valid := io.axiReqIn.valid
  io.axiReqIn.ready := io.genericReqOut.ready

  val axiIn = io.axiReqIn.bits
  val genericOut = io.genericReqOut.bits

  genericOut.addr := axiIn.addr
  genericOut.numBytes := (axiIn.len + UInt(1)) * UInt(p.dataWidth/8)
  genericOut.channelID := axiIn.id
}

class GenRspToAXIReadRspAdp(axiDataW: Int, axiIDW: Int, p: MemReqParams) extends Module {
  val io = new Bundle {
    val genericRspIn = Decoupled(new GenericMemoryResponse(p)).flip
    val axiRspOut = Decoupled(new AXIReadData(axiDataW, axiIDW))
  }
  io.axiRspOut.valid := io.genericRspIn.valid
  io.genericRspIn.ready := io.axiRspOut.ready

  val genericIn = io.genericRspIn.bits
  val axiOut = io.axiRspOut.bits

  axiOut.data := genericIn.readData
  axiOut.id := genericIn.channelID
  axiOut.resp := UInt(0)
  axiOut.last := genericIn.isLast
}

class GenRspToAXIWriteRspAdp(axiIDW: Int, p: MemReqParams) extends Module {
  val io = new Bundle {
    val genericRspIn = Decoupled(new GenericMemoryResponse(p)).flip
    val axiRspOut = Decoupled(new AXIWriteResponse(axiIDW))
  }
  io.axiRspOut.valid := io.genericRspIn.valid
  io.genericRspIn.ready := io.axiRspOut.ready

  val genericIn = io.genericRspIn.bits
  val axiOut = io.axiRspOut.bits

  axiOut.id := genericIn.channelID
  axiOut.resp := UInt(0)
}

class AXIWrDatToGenWrDatAdp(axiDataW: Int, p: MemReqParams) extends Module {
  val io = new Bundle {
    val axiIn = Decoupled(new AXIWriteData(axiDataW)).flip
    val genericOut = Decoupled(UInt(width = p.dataWidth))
  }
  if(axiDataW != p.dataWidth)
    throw new Exception("AXI<>generic adapters do not support datawidth conversion")
  io.genericOut.valid := io.axiIn.valid
  io.genericOut.bits := io.axiIn.bits.data
  io.axiIn.ready := io.genericOut.ready
}
