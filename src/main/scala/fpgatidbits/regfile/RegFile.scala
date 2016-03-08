package fpgatidbits.regfile

import Chisel._

// command bundle for read/writes to AEG/CSR registers
class RegCommand(idBits: Int, dataBits: Int) extends Bundle {
  val regID     = UInt(width = idBits)
  val read      = Bool()
  val write     = Bool()
  val writeData = UInt(width = dataBits)

  override def clone = { new RegCommand(idBits, dataBits).asInstanceOf[this.type] }

  def driveDefaults() = {
    regID := UInt(0)
    read := Bool(false)
    write := Bool(false)
    writeData := UInt(0)
  }
}

// register file interface
class RegFileSlaveIF(idBits: Int, dataBits: Int) extends Bundle {
  // register read/write commands
  // the "valid" signal here should be connected to (.read OR .write)
  val cmd         = Valid(new RegCommand(idBits, dataBits)).flip
  // returned read data
  val readData    = Valid(UInt(width = dataBits))
  // number of registers
  val regCount    = UInt(OUTPUT, width = idBits)

  override def clone = { new RegFileSlaveIF(idBits, dataBits).asInstanceOf[this.type] }
}


class RegFile(numRegs: Int, idBits: Int, dataBits: Int) extends Module {
  val io = new Bundle {
    // external command interface
    val extIF = new RegFileSlaveIF(idBits, dataBits)
    // exposed values of all registers, for internal use
    val regOut = Vec.fill(numRegs) { UInt(OUTPUT, width = dataBits) }
    // valid pipes for writing new values for all registers, for internal use
    // (extIF takes priority over this)
    val regIn = Vec.fill(numRegs) { Valid(UInt(width = dataBits)).flip }
  }
  // drive num registers to compile-time constant
  io.extIF.regCount := UInt(numRegs)

  // instantiate the registers in the file
  val regFile = Vec.fill(numRegs) { Reg(init = UInt(0, width = dataBits)) }

  // latch the incoming commands
  val regCommand = Reg(next = io.extIF.cmd.bits)
  val regDoCmd = Reg(init = Bool(false), next = io.extIF.cmd.valid)

  val hasExtReadCommand = (regDoCmd && regCommand.read)
  val hasExtWriteCommand = (regDoCmd && regCommand.write)

  // register read logic
  io.extIF.readData.valid := hasExtReadCommand
  // make sure regID stays within range for memory read
  when (regCommand.regID < UInt(numRegs)) {
    io.extIF.readData.bits  := regFile(regCommand.regID)
  } .otherwise {
    // return 0 otherwise
    io.extIF.readData.bits  := UInt(0)
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
