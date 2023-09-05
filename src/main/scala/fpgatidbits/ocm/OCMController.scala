package fpgatidbits.ocm

import chisel3._
import chisel3.util._

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
    if (rWidth <= wWidth) x else x << (log2Ceil(rWidth/wWidth))
  }

  def makeWriteAddr(x: UInt): UInt = {
    if (wWidth <= rWidth) x else x << (log2Ceil(wWidth/rWidth))
  }

  def printParams(): Unit =  {
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

class OCMRequest(private val writeWidth: Int, private val addrWidth: Int) extends Bundle {
  val addr = UInt(addrWidth.W)
  val writeData = UInt(writeWidth.W)
  val writeEn = Bool()
}

object NullOCMRequest {
  def apply(p: OCMParameters) = {
    val ocmr = new OCMRequest(p.writeWidth, p.addrWidth)
    ocmr.addr := 0.U
    ocmr.writeEn := false.B
    ocmr.writeData := 0.U
    ocmr
  }
}

class OCMResponse(private val readWidth: Int) extends Bundle {
  val readData = UInt(readWidth.W)
}

// master interface for an OCM access port (read/write, possibly with different
// widths)
class OCMMasterIF(writeWidth: Int, readWidth: Int, addrWidth: Int) extends Bundle {
  val req = Output(new OCMRequest(writeWidth, addrWidth))
  val rsp = Input(new OCMResponse(readWidth))

  def driveDefaults(): Unit = {
    req.writeEn := false.B
    req.writeData := DontCare
    req.addr := DontCare
  }
}

// slave interface is just the master interface flipped
class OCMSlaveIF(writeWidth: Int, readWidth: Int, addrWidth: Int) extends Bundle {
  val req = Input(new OCMRequest(writeWidth, addrWidth))
  val rsp = Output(new OCMResponse(readWidth))

}

class OnChipMemoryBlackBoxIF(p: OCMParameters) extends Bundle {
  val ports = Output(Vec(p.portCount, new OCMSlaveIF(p.writeWidth, p.readWidth, p.addrWidth)))
}

// we assume the actual OCM instance is generated via vendor-provided tools
// so this is just a BlackBox (wrapper module)
class OnChipMemory(p: OCMParameters, ocmName: String) extends BlackBox {
  override def desiredName = ocmName
  val io = IO(new OnChipMemoryBlackBoxIF(p))


  def renameSignals(): Unit = {
    val portLetters = Array("a", "b")
    for(i <- 0 until p.portCount) {
      io.ports(i).req.writeEn.suggestName("we"+portLetters(i))
      io.ports(i).req.writeData.suggestName("din"+portLetters(i))
      io.ports(i).req.addr.suggestName("addr"+portLetters(i))
      io.ports(i).rsp.readData.suggestName("dout"+portLetters(i))
    }
  }

  renameSignals()

  // Missing adding clock?

}
class OCMControllerIF(p: OCMParameters) extends Bundle {
  // control/status interface
  val mode = Input(UInt(1.W))
  val start = Input(Bool())
  val done = Output(Bool())
  val fillPort = Flipped(Decoupled(UInt(p.writeWidth.W)))
  val dumpPort = Decoupled(UInt(p.readWidth.W))
  val busy = Output(Bool())
  // word index to start with during fill/dump
  val fillDumpStart = Input(UInt((p.addrWidth+1).W))
  // number of OCM words to fill/dump
  val fillDumpCount = Input(UInt((p.addrWidth+1).W))
}

// TODO support fill/dump through all ports (width*count)

class OCMController(p: OCMParameters) extends Module {
  val io = IO(new Bundle {
    val mcif = new OCMControllerIF(p)
    // master port to connect to the OCM instance
    val ocm = new OCMMasterIF(p.writeWidth, p.readWidth, p.addrWidth)
  })
  // TODO test fill port functionality
  // TODO test dump port functionality
  val sIdle :: sFill :: sDump :: sFinished :: Nil = Enum(4)
  val regState = RegInit(sIdle)

  val ocm = io.ocm

  io.mcif.busy := (regState =/= sIdle)

  // use a FIFO queue to make burst reads with latency easier
  // TODO parametrize # entires in dump queue
  val fifoCapacity = 16
  val regDumpValid = RegInit(false.B)
  val dumpQ = Module(new Queue(UInt(p.readWidth.W), entries = fifoCapacity))
  // shift registers to compensate for OCM read latency (address to valid)
  // -1 since this is already sourced from a register
  dumpQ.io.enq.valid := ShiftRegister(regDumpValid, p.readLatency-1)
  dumpQ.io.enq.bits := ocm.rsp.readData
  dumpQ.io.deq <> io.mcif.dumpPort

  // TODO use instead "programmable full" threshold on Xilinx FIFOs
  // the 2x here is probably overly cautious, but better safe than sorry
  // (since we don't wait before all responses are committed before checking room)
  val hasRoom = (dumpQ.io.count < ((fifoCapacity-2*p.readLatency-1)).U)

  // address register, for both reads and writes (we do only one at once)
  // +1 in width to not overflow to zero if we increment too much
  val regAddr = RegInit(0.U((p.addrWidth+1).W))
  val regFillDumpCount = RegInit(0.U((p.addrWidth+1).W))

  // default outputs
  io.mcif.done := false.B
  io.mcif.fillPort.ready := false.B
  ocm.req.addr := 0.U
  ocm.req.writeEn := false.B
  ocm.req.writeData := io.mcif.fillPort.bits

  // default assignment to valid shiftreg
  regDumpValid := false.B

  switch(regState) {
      is(sIdle) {
        regAddr := io.mcif.fillDumpStart
        regFillDumpCount := io.mcif.fillDumpCount
        when(io.mcif.start) {
          when (io.mcif.mode === 0.U) { regState := sFill }
          .elsewhen (io.mcif.mode === 1.U) { regState := sDump }
        }
      }

      is(sFill) {
        io.mcif.fillPort.ready := true.B
        ocm.req.addr := p.makeWriteAddr(regAddr)

        when (regAddr === regFillDumpCount) {regState := sFinished}
        .elsewhen (io.mcif.fillPort.valid) {
          ocm.req.writeEn := true.B
          regAddr := regAddr + 1.U
        }
      }

      is(sDump) {
        ocm.req.addr := p.makeReadAddr(regAddr)
        when (regAddr === regFillDumpCount) {regState := sFinished}
        .elsewhen (hasRoom & dumpQ.io.enq.ready) {
          regDumpValid := true.B
          regAddr := regAddr + 1.U
        }
      }

      is(sFinished) {
        io.mcif.done := true.B
        when (!io.mcif.start) {regState := sIdle}
      }
  }
}

// convenience module for instantiating an OCM and a coupled controller
class OCMAndController(p: OCMParameters, ocmName: String, blackbox: Boolean) extends Module {
  val io = IO(new Bundle {
    val mcif = new OCMControllerIF(p)
    val ocmUser = VecInit(Seq.fill(p.portCount){
      new OCMSlaveIF(p.writeWidth, p.readWidth, p.addrWidth)})
  })

  assert(blackbox == false, "We have instantiated the wrong OCMAndController (should be Blackbox)")
  // instantiate the OCM controller
  val ocmControllerInst = Module(new OCMController(p))
  // connect the MCIF
  io.mcif <> ocmControllerInst.io.mcif

  // instantiate the OCM
  val ocmInst  = Module(new AsymDualPortRAM(p))
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

class OCMAndControllerBlackBox(p: OCMParameters, ocmName: String, blackbox: Boolean) extends Module {
  val io = IO(new Bundle {
    val mcif = new OCMControllerIF(p)
    val ocmUser = VecInit(Seq.fill(p.portCount){
      new OCMSlaveIF(p.writeWidth, p.readWidth, p.addrWidth)})
  })

  // instantiate the OCM controller
  val ocmControllerInst = Module(new OCMController(p))
  // connect the MCIF
  io.mcif <> ocmControllerInst.io.mcif

  // instantiate the OCM
  val ocmInst  = Module(new OnChipMemory(p, ocmName))
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