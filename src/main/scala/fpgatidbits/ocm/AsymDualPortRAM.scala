package fpgatidbits.ocm

import Chisel._

// simple model for a dual-port OCM with asymmetric r/w widths
// not intended for synthesis, only for simulation
class AsymDualPortRAM(p: OCMParameters) extends Module {
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
  val memBits = p.writeDepth * p.writeWidth
  val mem = Mem(UInt(width = minWidth), memBits/minWidth)

  for(i <- 0 to 1) {  // for each memory port
    val base = io.ports(i).req.addr
    // logic depends on whether read or write width is smaller
    if(p.readWidth > p.writeWidth) {
      // big reads, small writes
      // address corresponds directly to write cell address
      when (io.ports(i).req.writeEn) {
        mem(base) := io.ports(i).req.writeData
      }
      // reads need to concatenate multiple cells
      val wordsToRead = p.readWidth / p.writeWidth
      val rdData = Cat((wordsToRead-1 to 0 by -1).map( {i: Int => mem(base+UInt(i))}))
      // use shift register to satisfy read latency requirement
      io.ports(i).rsp.readData := ShiftRegister(n=p.readLatency, in=rdData)
    } else {
      // small reads, big writes
      // address corresponds directly to read cell address
      val rdData = mem(base)
      io.ports(i).rsp.readData := ShiftRegister(n=p.readLatency, in=rdData)
      // need to write to multiple cells
      val wordsToWrite = p.writeWidth / p.readWidth
      when (io.ports(i).req.writeEn) {
        for(j <- 0 until wordsToWrite) {
          mem(base+UInt(j)) := io.ports(i).req.writeData((j+1)*minWidth-1, j*minWidth)
        }
      }
    }
  }
}

// TODO this test will only work on 8w/32r OCM and tests very little
class AsymDualPortRAMTester(c: AsymDualPortRAM) extends Tester(c) {
  val p = c.ocmParams
  val p0 = c.io.ports(0)

  var wr_data = List(0xef, 0xbe, 0xad, 0xde)
  var addr = 4
  for (i <- wr_data) {
    poke(p0.req.addr, addr)
    poke(p0.req.writeData, i)
    poke(p0.req.writeEn, 1)
    step(1)
    addr = addr + 1
  }
  poke(p0.req.writeEn, 0)
  poke(p0.req.addr, 4)
  step(p.readLatency)
  expect(p0.rsp.readData, 0xdeadbeef)
}
