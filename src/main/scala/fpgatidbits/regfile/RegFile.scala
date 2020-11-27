package fpgatidbits.regfile

import chisel3._
import chisel3.util._

// command bundle for read/writes to AEG/CSR registers
class RegCommand(idBits: Int, dataBits: Int) extends Bundle {
  val regID     = UInt(idBits.W)
  val read      = Bool()
  val write     = Bool()
  val writeData = UInt(dataBits.W)

  override def cloneType = { new RegCommand(idBits, dataBits).asInstanceOf[this.type] }

  def driveDefaults() = {
    regID := 0.U
    read := false.B
    write := false.B
    writeData := 0.U
  }
}

// register file interface
class RegFileSlaveIF(idBits: Int, dataBits: Int) extends Bundle {
  // register read/write commands
  // the "valid" signal here should be connected to (.read OR .write)
  val cmd         = Flipped(Valid(new RegCommand(idBits, dataBits)))
  // returned read data
  val readData    = Valid(UInt(dataBits.W))
  // number of registers
  val regCount    = Output(UInt(idBits.W))

  override def cloneType = { new RegFileSlaveIF(idBits, dataBits).asInstanceOf[this.type] }
}


class RegFile(numRegs: Int, idBits: Int, dataBits: Int) extends Module {
  val io = IO(new Bundle {
    // external command interface
    val extIF = new RegFileSlaveIF(idBits, dataBits)
    // exposed values of all registers, for internal use
    val regOut = Vec(numRegs, Output(UInt(dataBits.W)))
    // valid pipes for writing new values for all registers, for internal use
    // (extIF takes priority over this)
    val regIn = Vec(numRegs, Flipped(Valid(UInt(dataBits.W))))
  })
  // drive num registers to compile-time constant
  io.extIF.regCount := numRegs.U

  // instantiate the registers in the file
  val regFile = RegInit(VecInit(Seq.fill(numRegs){0.U(dataBits.W)}))

  // latch the incoming commands
  val regCommand = RegNext(io.extIF.cmd.bits)
  val regDoCmd = RegNext(next=io.extIF.cmd.valid, init=false.B)


  val hasExtReadCommand = (regDoCmd && regCommand.read)
  val hasExtWriteCommand = (regDoCmd && regCommand.write)

  // register read logic
  io.extIF.readData.valid := hasExtReadCommand
  // make sure regID stays within range for memory read
  when (regCommand.regID < (numRegs).U) {
    io.extIF.readData.bits  := regFile(regCommand.regID)
  } .otherwise {
    // return 0 otherwise
    io.extIF.readData.bits  := 0.U
  }

  // register write logic
  // to avoid multiple ports, we prioritize the extIF writes over the internal
  // ones (e.g if there is an external write present, the internal write will
  // be ignored if it arrives simultaneously)
  when (hasExtWriteCommand) {
    regFile(regCommand.regID) := regCommand.writeData
  } .otherwise {
    for(i <- 0 until numRegs) {
      when (io.regIn(i).valid) { regFile(i) := io.regIn(i).bits }
    }
  }

  // expose all reg outputs for personality's access
  for (i <- 0 to numRegs-1) {
    io.regOut(i) := regFile(i)
  }

  // TODO add testbench for regfile logic
}
