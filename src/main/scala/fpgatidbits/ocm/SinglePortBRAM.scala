package fpgatidbits.ocm

import chisel3._

// A simple single port BRAM which hopefully is inferred by the Synthesis tools
class SinglePortBRAM(addrBits: Int, dataBits: Int) extends Module {
  val io = IO(new OCMSlaveIF(dataBits, dataBits, addrBits))

  val mem = SyncReadMem(1 << addrBits, UInt(dataBits.W))
  io.rsp.readData := DontCare

  val rdwrPort = mem(io.req.addr)
  when (io.req.writeEn) {rdwrPort := io.req.writeData}
    .otherwise          {io.rsp.readData := rdwrPort}
}


