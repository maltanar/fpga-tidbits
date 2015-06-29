package TidbitsOCM

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
    if (rWidth < wWidth) x else (x << UInt(log2Up(rWidth/wWidth)))
  }

  def makeWriteAddr(x: UInt): UInt = {
    if (wWidth < rWidth) x else (x << UInt(log2Up(wWidth/rWidth)))
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
}

// TODO support partial fill/dump by start&count registers
// fill/dump ports
// TODO support fill/dump through all ports (width*count)
// TODO slave ports for passthrough mode

class OCMController(p: OCMParameters) extends Module {
  val io = new Bundle {
    val mcif = new OCMControllerIF(p)
    // master port to connect to the OCM instance
    val ocm = new OCMMasterIF(p.writeWidth, p.readWidth, p.addrWidth)
  }
  // TODO test fill port functionality
  // TODO test dump port functionality

  // use a FIFO queue to make burst reads with latency easier
  // TODO parametrize # entires in dump queue
  val fifoCapacity = 16
  val regDumpValid = Reg(init = Bool(false))
  val dumpQ = Module(new Queue(UInt(width = p.readWidth), entries = fifoCapacity))
  // shift registers to compensate for OCM read latency (address to valid)
  // -1 since this is already sourced from a register
  dumpQ.io.enq.valid := ShiftRegister(in=regDumpValid, n=p.readLatency-1)
  dumpQ.io.enq.bits := io.ocm.rsp.readData
  dumpQ.io.deq <> io.mcif.dumpPort

  // TODO use instead "programmable full" threshold on Xilinx FIFOs
  // the 2x here is probably overly cautious, but better safe than sorry
  // (since we don't wait before all responses are committed before checking room)
  val hasRoom = (dumpQ.io.count < UInt((fifoCapacity-2*p.readLatency-1)))

  // address register, for both reads and writes (we do only one at once)
  // +1 in width to not overflow to zero if we increment too much
  val regAddr = Reg(init = UInt(0, p.addrWidth+1))
  // total number of words left in the dump operation
  val regWordsLeft = Reg(init = UInt(0, p.addrWidth))
  // # of words in the next dump burst
  val regReqCount = Reg(init=UInt(0,4))

  // default outputs
  io.mcif.done := Bool(false)
  io.mcif.fillPort.ready := Bool(false)
  io.ocm.req.addr := UInt(0)
  io.ocm.req.writeEn := Bool(false)
  io.ocm.req.writeData := io.mcif.fillPort.bits

  val sIdle :: sFill :: sDumpWait :: sDump :: sFinished :: Nil = Enum(UInt(), 5)
  val regState = Reg(init = UInt(sIdle))

  // default assignment to valid shiftreg
  regDumpValid := Bool(false)

  switch(regState) {
      is(sIdle) {
        regAddr := UInt(0)
        regWordsLeft := UInt(p.readDepth)
        regReqCount := UInt(0)
        when(io.mcif.start) {
          when (io.mcif.mode === UInt(0)) { regState := sFill }
          .elsewhen (io.mcif.mode === UInt(1)) { regState := sDumpWait }
        }
      }

      is(sFill) {
        io.mcif.fillPort.ready := Bool(true)
        io.ocm.req.addr := p.makeWriteAddr(regAddr)

        when (regAddr === UInt(p.writeDepth)) {regState := sFinished}
        .elsewhen (io.mcif.fillPort.valid) {
          io.ocm.req.writeEn := Bool(true)
          regAddr := regAddr + UInt(1)
        }
      }

      is(sDumpWait) {
        when (regWordsLeft === UInt(0)) {regState := sFinished}
        // we only issue requests to BRAM if the FIFO can hold
        // responses from all (bramStages) requests
        .elsewhen (hasRoom) {
          // calculate the next burst length:
          // we might have less than a full burst's worth of words left in BRAM
          val canDoFullReq = (regWordsLeft > UInt(p.readLatency))
          regReqCount := Mux(canDoFullReq, UInt(p.readLatency), regWordsLeft)
          // start burst
          regState := sDump
        }
      }

      is(sDump) {
        io.ocm.req.addr := p.makeReadAddr(regAddr)

        when ( regReqCount === UInt(0) ) {
          // no more requests in burst, wait for more room
          regState := sDumpWait
        } .otherwise {
          // issue requests (one burst beat)
          regDumpValid := Bool(true)
          // one less beat to go
          regReqCount := regReqCount - UInt(1)
          regAddr := regAddr + UInt(1)
          regWordsLeft := regWordsLeft - UInt(1)
          // TODO update count calculations here if we do multi-port dump
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
    // TODO add support for several "external ports" (not connected to the MC)
    val ocmUser = new OCMSlaveIF(p.writeWidth, p.readWidth, p.addrWidth)
  }

  // instantiate the OCM controller
  val ocmControllerInst = Module(new OCMController(p))
  // instantiate the OCM
  val ocmInst = Module(if (blackbox) new OnChipMemory(p, ocmName) else new AsymDualPortRAM(p))

  // connect the interfaces
  io.mcif <> ocmControllerInst.io.mcif
  // TODO do not hardcode port connections
  ocmControllerInst.io.ocm <> ocmInst.io.ports(0)
  ocmInst.io.ports(1) <> io.ocmUser
}
