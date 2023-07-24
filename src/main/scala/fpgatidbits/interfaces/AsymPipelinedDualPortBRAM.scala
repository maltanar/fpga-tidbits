package fpgatidbits.ocm

import Chisel._

// Dual-port pipelined BRAM with asymmetric r/w widths
class AsymPipelinedDualPortBRAM(
  p: OCMParameters, regIn: Int, regOut: Int
) extends Module {
  val ocmParams = p
  val io = new Bundle {
    val ports = Vec.fill(2) {new OCMSlaveIF(p.writeWidth, p.readWidth, p.addrWidth)}
  }
  // note that we assume the user left-shifts the address as necessary
  // (this is what Xilinx BRAMs assume as well -- not sure about Altera)
  // e.g the address is always given in the terms of the smallest granularity

  // calculate the minimum of required port widths & instantiate memory
  // according to this
  val minWidth = math.min(p.writeWidth, p.readWidth)
  val maxWidth = math.max(p.writeWidth, p.readWidth)
  val asymRatio = maxWidth / minWidth
  val memBits = p.writeDepth * p.writeWidth
  val addr_bits = log2Up(memBits / minWidth)
  val addrOfUnit_bits = log2Up(asymRatio)
  val addrInUnit_bits = addr_bits - addrOfUnit_bits
  if(asymRatio == 1) {
    // just instantiate a regular PipelinedDualPortBRAM
    val mem = Module(new PipelinedDualPortBRAM(
      addrBits = addr_bits, dataBits = minWidth, regIn = regIn,
      regOut = regOut
    )).io

    mem <> io
  } else {
    Predef.assert(asymRatio > 1)
    Predef.assert(isPow2(asymRatio))
    Predef.assert(p.writeDepth * p.writeWidth == p.readDepth * p.readWidth)
    // instantiate unit-sized mems, based on the minimum width
    val mem = Vec.fill(asymRatio) {
      Module(new PipelinedDualPortBRAM(
        addrBits = addrInUnit_bits, dataBits = minWidth, regIn = regIn,
        regOut = regOut
      )).io
    }

    // use both ports
    for(pn <- 0 until 2) {
      val addrOfUnit = io.ports(pn).req.addr(addrOfUnit_bits-1, 0)
      val addrInUnit = io.ports(pn).req.addr(addr_bits-1, addrOfUnit_bits)
      // all units get the same addrInUnit
      mem.map(_.ports(pn).req.addr := addrInUnit)
      // rest of logic depends on whether read or write width is smaller
      if(p.readWidth > p.writeWidth) {
        // small writes, large reads
        // all units get the same write data
        mem.map(_.ports(pn).req.writeData := io.ports(pn).req.writeData)
        // only right unit gets write enable
        for(j <- 0 until asymRatio) {
          mem(j).ports(pn).req.writeEn := io.ports(pn).req.writeEn & (UInt(j) === addrOfUnit)
        }
        // read data is several unit reads concatenated
        io.ports(pn).rsp.readData := Cat(mem.map(_.ports(pn).rsp.readData).reverse)
      } else {
        // small reads, large writes
        // all ports get the same write enable
        mem.map(_.ports(pn).req.writeEn := io.ports(pn).req.writeEn)
        // split up the write data between units
        for(j <- 0 until asymRatio) {
          mem(j).ports(pn).req.writeData := io.ports(pn).req.writeData((j+1)*minWidth-1, j*minWidth)
        }
        // read data is returned from the correct unit
        io.ports(pn).rsp.readData := mem(addrOfUnit).ports(pn).rsp.readData
      }
    }
  }
}
