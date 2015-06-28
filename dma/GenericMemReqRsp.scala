package TidbitsDMA

import Chisel._

class MemReqParams(aW: Int, dW: Int, iW: Int, mW: Int, b: Int) {
  // all units are "number of bits"
  val addrWidth: Int = aW       // width of memory addresses
  val dataWidth: Int = dW       // width of reads/writes
  val idWidth: Int = iW         // width of channel ID
  val metaDataWidth: Int = mW   // width of metadata (cache, prot, etc.)
  val beatsPerBurst: Int = b    // number of beats in a burst
  val bytesPerBurst: Int = b*(dW/8)

  override def clone = {
    new MemReqParams(aW, dW, iW, mW, b).asInstanceOf[this.type]
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
}

// a generic memory response structure
class GenericMemoryResponse(p: MemReqParams) extends Bundle {
  // ID of the request channel (useful for out-of-order data returns)
  val channelID = UInt(width = p.idWidth)
  // returned read data (always single beat, bursts broken down into
  // multiple beats while returning)
  val readData = UInt(width = p.dataWidth)
  // metadata information (can be status/error bits, etc.)
  val metaData = UInt(width = p.metaDataWidth)

  override def clone = {
    new GenericMemoryResponse(p).asInstanceOf[this.type]
  }
}
