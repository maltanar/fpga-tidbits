package fpgatidbits.ocm

import chisel3._
import chisel3.util._
import fpgatidbits.utils.SubWordAssignment

// creates a BRAM of desired size, which supports partial writes at "unit"
// granularity. which parts will be written is determined by the writeMask.
// internally, this is accomplished by instantiating a number of standard
// dual-port BRAMs of width = unit, and routing the write/read data accordingly

class DualPortMaskedBRAM(addrBits: Int, dataBits: Int, unit: Int = 8)
extends Module {
  val numBanks = dataBits/unit
  val io = IO(new DualPortMaskedBRAMIO(addrBits, dataBits, numBanks))

  val banksExt = VecInit(Seq.fill(numBanks) {
    Module(new DualPortBRAM(addrBits, unit)).io
  })

  val banks = for (i <- 0 until numBanks) yield {
    Wire(new DualPortBRAMIOWrapper(addrBits, unit))
  }

  (banksExt zip banks).map({
    case (ext, int) =>
      ext.clk := clock
      ext.a.connect(int.ports(0))
      ext.b.connect(int.ports(1))
      int.ports.map(_.driveDefaults())
  })

  val wiresReadOut =VecInit(Seq.fill(2)(VecInit(Seq.fill(numBanks)(WireInit(0.U(unit.W))))))



  for(i <- 0 until numBanks) {
    for(p <- 0 until 2) {
      // base request data goes to all banks
      banks(i).ports(p).req.addr := io.ports(p).req.addr
      // each bank gets one byte of data
      val bankWrData = io.ports(p).req.writeData((i+1)*unit-1, i*unit)
      banks(i).ports(p).req.writeData := bankWrData
      // each bank's write enable is computed separately
      val bankWrEn = io.ports(p).req.writeEn & io.ports(p).req.writeMask(i)
      banks(i).ports(p).req.writeEn := bankWrEn
      // use partial assignment to concatenate read data
      // erlingr: chisel3 doesnt support subword assignment
      wiresReadOut(p)(i) := banks(i).ports(p).rsp.readData
    }
  }

  // Concatenate output
  for (p <- 0 until 2) {
    io.ports(p).rsp.readData := wiresReadOut(p).asUInt
  }
}

class OCMMaskedRequest(writeWidth: Int, addrWidth: Int, maskWidth: Int)
extends OCMRequest(writeWidth, addrWidth) {
  if(writeWidth % maskWidth != 0)
    throw new Exception("Mask-writable BRAM needs data width % mask width = 0")

  val writeMask = Vec(maskWidth, Bool())

}

class OCMMaskedSlaveIF(dataWidth: Int, addrWidth: Int, maskWidth: Int)
extends Bundle {
  val req = Input(new OCMMaskedRequest(dataWidth, addrWidth, maskWidth))
  val rsp = Output(new OCMResponse(dataWidth))

}

class DualPortMaskedBRAMIO(addrBits: Int, dataBits: Int, maskBits: Int)
extends Bundle {
  val ports = Vec(2, new OCMMaskedSlaveIF(dataBits, addrBits, maskBits))
}
