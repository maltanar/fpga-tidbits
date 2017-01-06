package fpgatidbits.dma

import Chisel._
import fpgatidbits.ocm._
import fpgatidbits.streams.PrintableBundle

// MemReqParams describes what memory requests look like
class MemReqParams(
  // all units are "number of bits"
  val addrWidth: Int,       // width of memory addresses
  val dataWidth: Int,       // width of reads/writes
  val idWidth: Int,         // width of channel ID
  val metaDataWidth: Int,   // width of metadata (cache, prot, etc.)
  val sameIDInOrder: Boolean = true // whether requests with the same
                                    // ID return in-order, like in AXI
) {
  override def clone = {
    new MemReqParams(
      addrWidth, dataWidth, idWidth, metaDataWidth, sameIDInOrder
    ).asInstanceOf[this.type]
  }
}

// a generic memory request structure, inspired by AXI with some diffs
class GenericMemoryRequest(p: MemReqParams) extends PrintableBundle {
  // ID of the request channel (useful for out-of-order data returns)
  val channelID = UInt(width = p.idWidth)
  // whether this request is a read (if false) or write (if true)
  val isWrite = Bool()
  // start address of the request
  val addr = UInt(width = p.addrWidth)
  // number of bytes to read/write by this request
  val numBytes = UInt(width = 8)
  // metadata information (can be protection bits, caching bits, etc.)
  val metaData = UInt(width = p.metaDataWidth)

  val printfStr = "id %d addr %d numBytes %d \n"
  val printfElems = {() => Seq(channelID, addr, numBytes)}

  override def clone = {
    new GenericMemoryRequest(p).asInstanceOf[this.type]
  }

  def driveDefaults() = {
    channelID := UInt(0)
    isWrite := Bool(false)
    addr := UInt(0)
    numBytes := UInt(0)
    metaData := UInt(0)
  }
}

object GenericMemoryRequest {
  def apply(p: MemReqParams): GenericMemoryRequest = {
    val n = new GenericMemoryRequest(p)
    n.driveDefaults
    n
  }

  def apply(p: MemReqParams, addr: UInt, write:Bool,
    id: UInt, numBytes: UInt): GenericMemoryRequest = {
    val n = new GenericMemoryRequest(p)
    n.metaData := UInt(0)
    n.addr := addr
    n.isWrite := write
    n.channelID := id
    n.numBytes := numBytes
    n
  }
}

// a generic memory response structure
class GenericMemoryResponse(p: MemReqParams) extends PrintableBundle {
  // ID of the request channel (useful for out-of-order data returns)
  val channelID = UInt(width = p.idWidth)
  // returned read data (always single beat, bursts broken down into
  // multiple beats while returning)
  val readData = UInt(width = p.dataWidth)
  // is this response from a write?
  val isWrite = Bool()
  // is this response the last one in a burst of responses?
  val isLast = Bool()
  // metadata information (can be status/error bits, etc.)
  val metaData = UInt(width = p.metaDataWidth)

  val printfStr = "id %d readData %x isLast %d \n"
  val printfElems = {() => Seq(channelID, readData, isLast)}

  override def clone = {
    new GenericMemoryResponse(p).asInstanceOf[this.type]
  }

  def driveDefaults() = {
    channelID := UInt(0)
    readData := UInt(0)
    metaData := UInt(0)
    isLast := Bool(false)
    isWrite := Bool(false)
  }
}

object GenericMemoryResponse {
  def apply(p: MemReqParams): GenericMemoryResponse = {
    val n = new GenericMemoryResponse(p)
    n.driveDefaults
    n
  }
}

class GenericMemoryMasterPort(p: MemReqParams) extends Bundle {
  // req - rsp interface for memory reads
  val memRdReq = Decoupled(new GenericMemoryRequest(p))
  val memRdRsp = Decoupled(new GenericMemoryResponse(p)).flip
  // req - rsp interface for memory writes
  val memWrReq = Decoupled(new GenericMemoryRequest(p))
  val memWrDat = Decoupled(UInt(width = p.dataWidth))
  val memWrRsp = Decoupled(new GenericMemoryResponse(p)).flip
}

class GenericMemorySlavePort(p: MemReqParams) extends Bundle {
  // req - rsp interface for memory reads
  val memRdReq = Decoupled(new GenericMemoryRequest(p)).flip
  val memRdRsp = Decoupled(new GenericMemoryResponse(p))
  // req - rsp interface for memory writes
  val memWrReq = Decoupled(new GenericMemoryRequest(p)).flip
  val memWrDat = Decoupled(UInt(width = p.dataWidth)).flip
  val memWrRsp = Decoupled(new GenericMemoryResponse(p))
}

// variant of the generic memory port where read/write requests
// are multiplexed onto the same channel
class SimplexMemoryMasterPort(p: MemReqParams) extends Bundle {
  val req = Decoupled(new GenericMemoryRequest(p))
  val wrdat = Decoupled(UInt(width = p.dataWidth))
  val rsp = Decoupled(new GenericMemoryResponse(p)).flip
}

class SimplexMemorySlavePort(p: MemReqParams) extends SimplexMemoryMasterPort(p) {
  flip
}

// derive a read-write deinterleaver for handling the responses
class QueuedRdWrDeinterleaver(p: MemReqParams) extends QueuedDeinterleaver(2, p, 4,
 routeFxn = {x: GenericMemoryResponse => Mux(x.isWrite, UInt(1), UInt(0))})

// adapter for duplex <> simplex
class SimplexAdapter(p: MemReqParams) extends Module {
  val io = new Bundle {
    val duplex = new GenericMemorySlavePort(p)
    val simplex = new SimplexMemoryMasterPort(p)
  }

  val rdReqQ = FPGAQueue(io.duplex.memRdReq, 2)
  val wrReqQ = FPGAQueue(io.duplex.memWrReq, 2)
  val wrDatQ = FPGAQueue(io.duplex.memWrDat, 2)

  val simplexReqQ = Module(new FPGAQueue(GenericMemoryRequest(p), 2)).io

  // simply interleave the read-write reqs onto common req channel
  val mux = Module(new ReqInterleaver(2, p)).io
  rdReqQ <> mux.reqIn(0)
  wrReqQ <> mux.reqIn(1)
  mux.reqOut <> simplexReqQ.enq
  simplexReqQ.deq <> io.simplex.req

  wrDatQ <> io.simplex.wrdat

  // (commented out for now to get write bursts working -- do not mix
  // reads and dependent writes in the same channel!)
  // to prevent head-of-line blocking from write requests whose data is not
  // yet ready, sync the write request-data streams
  // TODO this won't work for write bursts!

/*
  val simplexWDQ = Module(new FPGAQueue(UInt(width = p.dataWidth), 2)).io
  simplexWDQ.deq <> io.simplex.wrdat
  mux.reqIn(1).valid := wrReqQ.valid & wrDatQ.valid & simplexWDQ.enq.ready
  simplexWDQ.enq.valid := wrReqQ.valid & wrDatQ.valid & mux.reqIn(1).ready
  wrReqQ.ready := wrDatQ.valid & simplexWDQ.enq.ready & mux.reqIn(1).ready
  wrDatQ.ready := wrReqQ.valid &  simplexWDQ.enq.ready & mux.reqIn(1).ready
  mux.reqIn(1).bits := wrReqQ.bits
  simplexWDQ.enq.bits := wrDatQ.bits
*/

  val demux = Module(new QueuedRdWrDeinterleaver(p)).io
  io.simplex.rsp <> demux.rspIn
  demux.rspOut(0) <> io.duplex.memRdRsp
  demux.rspOut(1) <> io.duplex.memWrRsp
}
