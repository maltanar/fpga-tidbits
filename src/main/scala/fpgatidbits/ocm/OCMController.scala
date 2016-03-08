package fpgatidbits.ocm

import Chisel._

// a definitions and helpers for FPGA On-Chip Memory (OCM)
// (typically "BRAM" for Xilinx and "embedded memory" for Altera)

// a collection of values that define the OCM
// for now we require all ports to have the same dimensions
class OCMParameters(b: Int, rWidth: Int, wWidth: Int, pts: Int, lat: Int) {
  // minimum port width
  val minW: Int = math.min(rWidth, wWidth)
  // address width is determined by min port width
  val addrWidth: Int = log2Up(b/minW)
  val readDepth: Int = b/rWidth
  val readWidth: Int = rWidth
  val writeDepth: Int = b/wWidth
  val writeWidth: Int = wWidth
  val readLatency: Int = lat
  val portCount: Int = pts
  val bits: Int = b

  def makeReadAddr(x: UInt): UInt = {
    if (rWidth <= wWidth) x else (x << UInt(log2Up(rWidth/wWidth)))
  }

  def makeWriteAddr(x: UInt): UInt = {
    if (wWidth <= rWidth) x else (x << UInt(log2Up(wWidth/rWidth)))
  }

  def printParams() {
    println("OCM parameters:")
    println("Address width: " + addrWidth.toString)
    println("Total # bits: " + bits.toString)
    println("Read width: " + readWidth.toString)
    println("Read depth: " + readDepth.toString)
    println("Write width: " + writeWidth.toString)
    println("Write depth: " + writeDepth.toString)
    println("Read latency: " + readLatency.toString)
  }
}

class OCMRequest(writeWidth: Int, addrWidth: Int) extends Bundle {
  val addr = UInt(width = addrWidth)
  val writeData = UInt(width = writeWidth)
  val writeEn = Bool()

  override def clone = {new OCMRequest(writeWidth, addrWidth).asInstanceOf[this.type]}
}

object NullOCMRequest {
  def apply(p: OCMParameters) = {
    val ocmr = new OCMRequest(p.writeWidth, p.addrWidth)
    ocmr.addr := UInt(0)
    ocmr.writeEn := Bool(false)
    ocmr.writeData := UInt(0)
    ocmr
  }
}

class OCMResponse(readWidth: Int) extends Bundle {
  val readData = UInt(width = readWidth)

  override def clone = {new OCMResponse(readWidth).asInstanceOf[this.type]}
}

// master interface for an OCM access port (read/write, possibly with different
// widths)
class OCMMasterIF(writeWidth: Int, readWidth: Int, addrWidth: Int) extends Bundle {
  val req = new OCMRequest(writeWidth, addrWidth).asOutput()
  val rsp = new OCMResponse(readWidth).asInput()

  override def clone =
    { new OCMMasterIF(writeWidth, readWidth, addrWidth).asInstanceOf[this.type] }
}

// slave interface is just the master interface flipped
class OCMSlaveIF(writeWidth: Int, readWidth: Int, addrWidth: Int) extends Bundle {
  val req = new OCMRequest(writeWidth, addrWidth).asInput()
  val rsp = new OCMResponse(readWidth).asOutput()

  override def clone =
    { new OCMSlaveIF(writeWidth, readWidth, addrWidth).asInstanceOf[this.type] }
}

class OnChipMemoryBlackBoxIF(p: OCMParameters)extends Bundle {
  val ports = Vec.fill(p.portCount) {
    new OCMSlaveIF(p.writeWidth, p.readWidth, p.addrWidth)}
}

// we assume the actual OCM instance is generated via vendor-provided tools
// so this is just a BlackBox (wrapper module)
class OnChipMemory(p: OCMParameters, ocmName: String) extends BlackBox {
  moduleName = ocmName
  val io = new OnChipMemoryBlackBoxIF(p)

  def renameSignals() {
    val portLetters = Array("a", "b")
    for(i <- 0 until p.portCount) {
      io.ports(i).req.writeEn.setName("we"+portLetters(i))
      io.ports(i).req.writeData.setName("din"+portLetters(i))
      io.ports(i).req.addr.setName("addr"+portLetters(i))
      io.ports(i).rsp.readData.setName("dout"+portLetters(i))
    }
  }

  renameSignals()
  this.addClock(Driver.implicitClock)
}

class OCMControllerIF(p: OCMParameters) extends Bundle {
  // control/status interface
  val mode = UInt(INPUT, 1)
  val start = Bool(INPUT)
  val done = Bool(OUTPUT)
  val fillPort = Decoupled(UInt(width = p.writeWidth)).flip
  val dumpPort = Decoupled(UInt(width = p.readWidth))
  val busy = Bool(OUTPUT)
  // word index to start with during fill/dump
  val fillDumpStart = UInt(INPUT, width = p.addrWidth+1)
  // number of OCM words to fill/dump
  val fillDumpCount = UInt(INPUT, width = p.addrWidth+1)
}

// TODO support fill/dump through all ports (width*count)

class OCMController(p: OCMParameters) extends Module {
  val io = new Bundle {
    val mcif = new OCMControllerIF(p)
    // master port to connect to the OCM instance
    val ocm = new OCMMasterIF(p.writeWidth, p.readWidth, p.addrWidth)
  }
  // TODO test fill port functionality
  // TODO test dump port functionality
  val sIdle :: sFill :: sDump :: sFinished :: Nil = Enum(UInt(), 4)
  val regState = Reg(init = UInt(sIdle))

  val ocm = io.ocm

  io.mcif.busy := (regState != sIdle)

  // use a FIFO queue to make burst reads with latency easier
  // TODO parametrize # entires in dump queue
  val fifoCapacity = 16
  val regDumpValid = Reg(init = Bool(false))
  val dumpQ = Module(new Queue(UInt(width = p.readWidth), entries = fifoCapacity))
  // shift registers to compensate for OCM read latency (address to valid)
  // -1 since this is already sourced from a register
  dumpQ.io.enq.valid := ShiftRegister(in=regDumpValid, n=p.readLatency-1)
  dumpQ.io.enq.bits := ocm.rsp.readData
  dumpQ.io.deq <> io.mcif.dumpPort

  // TODO use instead "programmable full" threshold on Xilinx FIFOs
  // the 2x here is probably overly cautious, but better safe than sorry
  // (since we don't wait before all responses are committed before checking room)
  val hasRoom = (dumpQ.io.count < UInt((fifoCapacity-2*p.readLatency-1)))

  // address register, for both reads and writes (we do only one at once)
  // +1 in width to not overflow to zero if we increment too much
  val regAddr = Reg(init = UInt(0, p.addrWidth+1))
  val regFillDumpCount = Reg(init = UInt(0, p.addrWidth+1))

  // default outputs
  io.mcif.done := Bool(false)
  io.mcif.fillPort.ready := Bool(false)
  ocm.req.addr := UInt(0)
  ocm.req.writeEn := Bool(false)
  ocm.req.writeData := io.mcif.fillPort.bits

  // default assignment to valid shiftreg
  regDumpValid := Bool(false)

  switch(regState) {
      is(sIdle) {
        regAddr := io.mcif.fillDumpStart
        regFillDumpCount := io.mcif.fillDumpCount
        when(io.mcif.start) {
          when (io.mcif.mode === UInt(0)) { regState := sFill }
          .elsewhen (io.mcif.mode === UInt(1)) { regState := sDump }
        }
      }

      is(sFill) {
        io.mcif.fillPort.ready := Bool(true)
        ocm.req.addr := p.makeWriteAddr(regAddr)

        when (regAddr === regFillDumpCount) {regState := sFinished}
        .elsewhen (io.mcif.fillPort.valid) {
          ocm.req.writeEn := Bool(true)
          regAddr := regAddr + UInt(1)
        }
      }

      is(sDump) {
        ocm.req.addr := p.makeReadAddr(regAddr)
        when (regAddr === regFillDumpCount) {regState := sFinished}
        .elsewhen (hasRoom & dumpQ.io.enq.ready) {
          regDumpValid := Bool(true)
          regAddr := regAddr + UInt(1)
        }
      }

      is(sFinished) {
        io.mcif.done := Bool(true)
        when (!io.mcif.start) {regState := sIdle}
      }
  }
}

// convenience module for instantiating an OCM and a coupled controller
class OCMAndController(p: OCMParameters, ocmName: String, blackbox: Boolean) extends Module {
  val io = new Bundle {
    val mcif = new OCMControllerIF(p)
    val ocmUser = Vec.fill(p.portCount){
      new OCMSlaveIF(p.writeWidth, p.readWidth, p.addrWidth)}
  }

  // instantiate the OCM controller
  val ocmControllerInst = Module(new OCMController(p))
  // connect the MCIF
  io.mcif <> ocmControllerInst.io.mcif

  // instantiate the OCM
  val ocmInst = Module(if (blackbox) new OnChipMemory(p, ocmName) else new AsymDualPortRAM(p))
  // connect OCM controller with passthrough logic:
  // port 0 is driven by the MC when MC is busy, by the user port otherwise
  val enablePassthrough = !ocmControllerInst.io.mcif.busy
  val mcifPort = ocmControllerInst.io.ocm
  val sharedPort = ocmInst.io.ports(0)

  sharedPort.req := Mux(enablePassthrough, io.ocmUser(0).req, mcifPort.req)
  mcifPort.rsp := sharedPort.rsp
  io.ocmUser(0).rsp := sharedPort.rsp

  // connect the rest of the ports
  for(i <- 1 until p.portCount) {
    ocmInst.io.ports(i) <> io.ocmUser(i)
  }

}
