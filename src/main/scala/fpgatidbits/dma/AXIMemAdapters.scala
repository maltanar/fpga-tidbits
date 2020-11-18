package fpgatidbits.dma

import chisel3._
import chisel3.util._
import fpgatidbits.axi._

class AXIMemReqAdp(p: MemReqParams) extends Module {
  val io = new Bundle {
    val genericReqIn = Flipped(Decoupled(new GenericMemoryRequest(p)))
    val axiReqOut = Decoupled(new AXIAddress(p.addrWidth, p.idWidth))
  }

  io.genericReqIn.ready := io.axiReqOut.ready
  io.axiReqOut.valid := io.genericReqIn.valid

  val reqIn = io.genericReqIn.bits
  val axiOut = io.axiReqOut.bits

  axiOut.addr := reqIn.addr
  axiOut.size := log2Ceil((p.dataWidth/8)-1).U // only full-width
  val beats = (reqIn.numBytes / (p.dataWidth/8).U)
  axiOut.len := beats - 1.U // AXI defines len = beats-1
  axiOut.burst := 1.U // incrementing burst
  axiOut.id := reqIn.channelID
  axiOut.lock := false.B
  // TODO use metadata to alter cache bits as desired?
  axiOut.cache := "b0010".U // no alloc, modifiable, no buffer
  axiOut.prot := 0.U
  axiOut.qos := 0.U
}

class AXIReadRspAdp(p: MemReqParams) extends Module {
  val io = new Bundle {
    val axiReadRspIn = Flipped(Decoupled(new AXIReadData(p.dataWidth, p.idWidth)))
    val genericRspOut = Decoupled(new GenericMemoryResponse(p))
  }
  io.genericRspOut.valid := io.axiReadRspIn.valid
  io.axiReadRspIn.ready := io.genericRspOut.ready

  val axiIn = io.axiReadRspIn.bits
  val rspOut = io.genericRspOut.bits

  rspOut.readData := axiIn.data
  rspOut.channelID := axiIn.id
  rspOut.metaData := 0.U // TODO add resp code from AXI response?
  rspOut.isWrite := false.B
  rspOut.isLast := axiIn.last
}

class AXIWriteRspAdp(p: MemReqParams) extends Module {
  val io = new Bundle {
    val axiWriteRspIn = Flipped(Decoupled(new AXIWriteResponse(p.idWidth)))
    val genericRspOut = Decoupled(new GenericMemoryResponse(p))
  }
  io.genericRspOut.valid := io.axiWriteRspIn.valid
  io.axiWriteRspIn.ready := io.genericRspOut.ready

  val axiIn = io.axiWriteRspIn.bits
  val rspOut = io.genericRspOut.bits

  rspOut.readData := 0.U
  rspOut.channelID := axiIn.id
  rspOut.metaData := 0.U // TODO add resp from AXI response?
  rspOut.isWrite := true.B
  rspOut.isLast := false.B  // not applicable for write responses
}

class AXIReqToGenReqAdp(axiAddrW: Int, axiIDW: Int, p: MemReqParams) extends Module {
  val io = new Bundle {
    val axiReqIn = Flipped(Decoupled(new AXIAddress(axiAddrW, axiIDW)))
    val genericReqOut = Decoupled(new GenericMemoryRequest(p))
  }

  io.genericReqOut.valid := io.axiReqIn.valid
  io.axiReqIn.ready := io.genericReqOut.ready

  val axiIn = io.axiReqIn.bits
  val genericOut = io.genericReqOut.bits

  genericOut.addr := axiIn.addr
  genericOut.numBytes := (axiIn.len + 1.U) * (p.dataWidth/8).U
  genericOut.channelID := axiIn.id
}

class GenRspToAXIReadRspAdp(axiDataW: Int, axiIDW: Int, p: MemReqParams) extends Module {
  val io = new Bundle {
    val genericRspIn = Flipped(Decoupled(new GenericMemoryResponse(p)))
    val axiRspOut = Decoupled(new AXIReadData(axiDataW, axiIDW))
  }
  io.axiRspOut.valid := io.genericRspIn.valid
  io.genericRspIn.ready := io.axiRspOut.ready

  val genericIn = io.genericRspIn.bits
  val axiOut = io.axiRspOut.bits

  axiOut.data := genericIn.readData
  axiOut.id := genericIn.channelID
  axiOut.resp := 0.U
  axiOut.last := genericIn.isLast
}

class GenRspToAXIWriteRspAdp(axiIDW: Int, p: MemReqParams) extends Module {
  val io = new Bundle {
    val genericRspIn = Flipped(Decoupled(new GenericMemoryResponse(p)))
    val axiRspOut = Decoupled(new AXIWriteResponse(axiIDW))
  }
  io.axiRspOut.valid := io.genericRspIn.valid
  io.genericRspIn.ready := io.axiRspOut.ready

  val genericIn = io.genericRspIn.bits
  val axiOut = io.axiRspOut.bits

  axiOut.id := genericIn.channelID
  axiOut.resp := 0.U
}

class AXIWrDatToGenWrDatAdp(axiDataW: Int, p: MemReqParams) extends Module {
  val io = new Bundle {
    val axiIn = Flipped(Decoupled(new AXIWriteData(axiDataW)))
    val genericOut = Decoupled(UInt(p.dataWidth.W))
  }
  if(axiDataW != p.dataWidth)
    throw new Exception("AXI<>generic adapters do not support datawidth conversion")
  io.genericOut.valid := io.axiIn.valid
  io.genericOut.bits := io.axiIn.bits.data
  io.axiIn.ready := io.genericOut.ready
}

// set the .last of the write request correctly for bursts
class AXIWriteBurstReqAdapter(
  addrWidthBits: Int, dataWidthBits: Int, idBits: Int
) extends Module {
  val io = new Bundle {
    // write address channel in
    val in_writeAddr   = Flipped(Decoupled(new AXIAddress(addrWidthBits, idBits)))
    // write data channel in
    val in_writeData   = Flipped(Decoupled(new AXIWriteData(dataWidthBits)))
    // write address channel out
    val out_writeAddr   = Decoupled(new AXIAddress(addrWidthBits, idBits))
    // write data channel out
    val out_writeData   = Decoupled(new AXIWriteData(dataWidthBits))
  }
  // connect the write address and data output directly to input
  io.in_writeAddr <> io.out_writeAddr
  io.in_writeData <> io.out_writeData
  // except the handshake signals -- these will be set from the state machine
  io.out_writeAddr.valid := false.B
  io.in_writeAddr.ready := false.B
  io.out_writeData.valid := false.B
  io.in_writeData.ready := false.B
  // we'll also set the .last field of the write data from the state machine
  io.out_writeData.bits.last := false.B

  val sWaitReq :: sWaitData :: Nil = Enum(2)
  val regState = sWaitReq
  val regBeatsLeft = 0.U(8.W)

  switch(regState) {
    is(sWaitReq) {
      // enable write requests to pass through
      io.out_writeAddr.valid := io.in_writeAddr.valid
      io.in_writeAddr.ready := io.out_writeAddr.ready
      // register the burst count when we get a transaction
      // TODO can this handle non-bursts? is this something we need to consider?
      when(io.out_writeAddr.fire()) {
        regBeatsLeft := io.in_writeAddr.bits.len
        regState := sWaitData
      }

    }
    is(sWaitData) {
      val isLastBeat = (regBeatsLeft === 0.U)
      // enable write data to pass through
      io.out_writeData.valid := io.in_writeData.valid
      io.in_writeData.ready := io.out_writeData.ready
      io.out_writeData.bits.last := isLastBeat
      when(io.out_writeData.fire()) {
        // check if we have any more beats in this burst
        when(isLastBeat) { regState := sWaitReq }
        .otherwise { regBeatsLeft := regBeatsLeft - 1.U }
      }
    }
  }
}
