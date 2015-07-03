package TidbitsDMA

import Chisel._
import TidbitsAXIDefs._

class AXIMemReqAdp(p: MemReqParams) extends Module {
  val io = new Bundle {
    val genericReqIn = Decoupled(new GenericMemoryRequest(p)).flip
    val axiReqOut = Decoupled(new AXIAddress(p.addrWidth, p.idWidth))
  }

  io.genericReqIn.ready := io.axiReqOut.ready
  io.axiReqOut.valid := genericReqIn.valid

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
  io.rspOut.valid := io.axiReadRspIn.valid
  io.axiReadRspIn.ready := io.rspOut.ready

  val axiIn = io.axiReadRspIn.bits
  val rspOut = io.genericRspOut.bits

  rspOut.readData := axiIn.data
  rspOut.channelID := axiIn.id
  rspOut.metaData := UInt(0) // TODO add last/resp from AXI response?
}

class AXIWriteRspAdp(p: MemReqParams) extends Module {
  val io = new Bundle {
    val axiWriteRspIn = Decoupled(new AXIWriteResponse(p.idWidth)).flip
    val genericRspOut = Decoupled(new GenericMemoryResponse(p))
  }
  io.rspOut.valid := io.axiWriteRspIn.valid
  io.axiReadRspIn.ready := io.rspOut.ready

  val axiIn = io.axiWriteRspIn.bits
  val rspOut = io.genericRspOut.bits

  rspOut.readData := UInt(0)
  rspOut.channelID := axiIn.id
  rspOut.metaData := UInt(0) // TODO add resp from AXI response?
}
