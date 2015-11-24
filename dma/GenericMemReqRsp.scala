package TidbitsDMA

import Chisel._

class MemReqParams(aW: Int, dW: Int, iW: Int, mW: Int) {
  // all units are "number of bits"
  val addrWidth: Int = aW       // width of memory addresses
  val dataWidth: Int = dW       // width of reads/writes
  val idWidth: Int = iW         // width of channel ID
  val metaDataWidth: Int = mW   // width of metadata (cache, prot, etc.)

  override def clone = {
    new MemReqParams(aW, dW, iW, mW).asInstanceOf[this.type]
  }
}

// a generic memory request structure, inspired by AXI with some diffs
class GenericMemoryRequest(p: MemReqParams) extends Bundle {
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
}

// a generic memory response structure
class GenericMemoryResponse(p: MemReqParams) extends Bundle {
  // ID of the request channel (useful for out-of-order data returns)
  val channelID = UInt(width = p.idWidth)
  // returned read data (always single beat, bursts broken down into
  // multiple beats while returning)
  val readData = UInt(width = p.dataWidth)
  // is this response from a write?
  val isWrite = Bool()
  // metadata information (can be status/error bits, etc.)
  val metaData = UInt(width = p.metaDataWidth)

  override def clone = {
    new GenericMemoryResponse(p).asInstanceOf[this.type]
  }

  def driveDefaults() = {
    channelID := UInt(0)
    readData := UInt(0)
    metaData := UInt(0)
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

  val rdReqQ = Queue(io.duplex.memRdReq, 2)
  val wrReqQ = Queue(io.duplex.memWrReq, 2)
  val wrDatQ = Queue(io.duplex.memWrDat, 2)

  val simplexReqQ = Module(new Queue(GenericMemoryRequest(p), 2)).io
  val simplexWDQ = Module(new Queue(UInt(width = p.dataWidth), 2)).io

  // simply interleave the read-write reqs onto common req channel
  val mux = Module(new ReqInterleaver(2, p)).io
  rdReqQ <> mux.reqIn(0)
  mux.reqOut <> simplexReqQ.enq
  simplexReqQ.deq <> io.simplex.req
  simplexWDQ.deq <> io.simplex.wrdat

  // to prevent head-of-line blocking from write requests whose data is not
  // yet ready, sync the write request-data streams
  // TODO this won't work for write bursts!
  mux.reqIn(1).valid := wrReqQ.valid & wrDatQ.valid & simplexWDQ.enq.ready
  simplexWDQ.enq.valid := wrReqQ.valid & wrDatQ.valid & mux.reqIn(1).ready
  wrReqQ.ready := wrDatQ.valid & simplexWDQ.enq.ready & mux.reqIn(1).ready
  wrDatQ.ready := wrReqQ.valid &  simplexWDQ.enq.ready & mux.reqIn(1).ready

  mux.reqIn(1).bits := wrReqQ.bits
  simplexWDQ.enq.bits := wrDatQ.bits

  val demux = Module(new QueuedRdWrDeinterleaver(p)).io
  io.simplex.rsp <> demux.rspIn
  demux.rspOut(0) <> io.duplex.memRdRsp
  demux.rspOut(1) <> io.duplex.memWrRsp
}
