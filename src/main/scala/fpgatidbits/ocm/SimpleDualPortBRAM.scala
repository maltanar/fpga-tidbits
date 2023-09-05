package fpgatidbits.ocm

import chisel3._

// Targeting the Simple Dual Port BRAMs of Xilinx.
// We can have 1 read port and 1 write port that is accessed simoultaneously

class SimpleDualPortBRAM(addrBits: Int, dataBits: Int) extends Module {

  val io = IO( new Bundle {
    val read = new OCMSlaveIF(dataBits, dataBits, addrBits)
    val write = new OCMSlaveIF(dataBits, dataBits, addrBits)
  })
  // Port 0 is read port
  // Port 1 is write port
  assert(!io.read.req.writeEn, "[SDP BRAM] can only read from readport")
  io.write.rsp.readData := DontCare
  io.read.rsp.readData := DontCare

  val mem = SyncReadMem(1 << addrBits, UInt(dataBits.W))

  val rdPort = mem(io.read.req.addr)

  io.read.rsp.readData := rdPort
  when (io.write.req.writeEn) {mem(io.write.req.addr) := io.write.req.writeData}
}
