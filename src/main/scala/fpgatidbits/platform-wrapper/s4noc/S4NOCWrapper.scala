package fpgatidbits.PlatformWrapper

import chisel3._
import chisel3.util._
import fpgatidbits.dma._
import fpgatidbits.regfile._
import fpgatidbits.axi._
import fpgatidbits.ocm._
import chisel3.experimental.noPrefix
import fpgatidbits.TidbitsMakeUtils.fileCopyBulk

import java.nio.file.Paths

object S4NOCWrapperParams extends PlatformWrapperParams {

  val driverTargetDir = "s4noc"
  val platformName = "S4NOCAccel"
  val memAddrBits = 48
  val memDataBits = 32
  val memIDBits = 32
  val memMetaBits = 1
  val numMemPorts = 0 // No direct memory ports
  val sameIDInOrder = true
  val typicalMemLatencyCycles = 16
  val burstBeats = 8
  val coherentMem = false
  val hasStreamInterface = true
}
class StreamEntry(private val dt: UInt) extends Bundle {
  val data = dt.cloneType
  val addr = UInt(8.W)
}
object StreamEntry {
  def apply(dt: UInt) = {
    new StreamEntry(dt)
  }
}
class S4NOCIO(p: PlatformWrapperParams) extends Bundle {
  val tx = Decoupled(new StreamEntry(UInt(p.csrDataBits.W)))
  val rx = Flipped(Decoupled(new StreamEntry(UInt(p.csrDataBits.W))))

  def driveDefault(): Unit = {
    tx.valid := false.B
    tx.bits := 0.U.asTypeOf(StreamEntry(UInt(p.csrDataBits.W)))
    rx.ready := false.B
  }
}

class NOCHeader(p: PlatformWrapperParams) extends Bundle {
  require(p.memDataBits == 32)
  val write = Bool()
  val port = UInt(14.W)
  val length = UInt(14.W)
  val flags = UInt(3.W)
}
class S4NOCWrapper (instFxn: PlatformWrapperParams => GenericAccelerator, targetDir: String)
  extends PlatformWrapper(S4NOCWrapperParams, instFxn) {
  // -----------------------------------------------------------------------------------------------------------------
  //  File copying
  // -----------------------------------------------------------------------------------------------------------------
  val driverBaseDir = "c/platform-wrapper-regdriver"
  val platformDriverFiles = Array("platform.h", "platform_s4noc.h", "platform_s4noc.c", "s4noc_regdriver.c", "wrapper_regdriver.h")

  // Generate the C-based Register File drivers
  generateCRegDriver(targetDir)

  // Copy over the other needed files
  val resRoot = Paths.get("./src/main/resources")
  fileCopyBulk(s"${resRoot}/${driverBaseDir}", targetDir, platformDriverFiles)
  println(s"=======> Driver files copied to ${targetDir}")

  // -----------------------------------------------------------------------------------------------------------------
  //  Implementing the wrapper
  // -----------------------------------------------------------------------------------------------------------------
  val io = IO(new S4NOCIO(S4NOCWrapperParams))

  val addrBits = regAddrBits + accel.accelParams.streamPortIdBits

  // A decopling queue
  val rxQ = Queue(io.rx)

  // Handle potential arbitration if there are both input and output streams
  // RegFile read responses are written to this wire
  val txArbiter = if (accel.accelParams.numStreamOutPorts > 0) {
    Some(Module(new RRArbiter(new StreamEntry(UInt(p.memDataBits.W)), 2)).io)
  } else {
    None
  }


  // -----------------------------------------------------------------------------------------------------------------
  //  Driving signals to their defaults
  // -----------------------------------------------------------------------------------------------------------------
  accel.io.driveDefaultFlipped()
  regFile.extIF.driveDefault()
  io.driveDefault()

  val csrReadRsp = Wire(DecoupledIO(StreamEntry(UInt(p.csrDataBits.W))))
  csrReadRsp.bits := 0.U.asTypeOf(csrReadRsp.bits)
  csrReadRsp.valid := false.B

  // Connect txArbiter to the top-level TX output. If it exists. If it doesnt exist, this wire is driven
  //  from inside the state machine
  if (txArbiter.isDefined) {
    txArbiter.get.out <> io.tx
    txArbiter.get.in(0) <> csrReadRsp
  } else {
    csrReadRsp <> io.tx
  }


  // -----------------------------------------------------------------------------------------------------------------
  //  Receiving data from the NOC and forwarding it to either the RegFile or the StreamPorts
  // -----------------------------------------------------------------------------------------------------------------
  val sReadHeader :: sWriteReg :: sWriteStreamPort :: sReadReg1 :: sReadReg2 :: Nil = Enum(5)
  val regState = RegInit(sReadHeader)
  val regHeader = RegInit(0.U.asTypeOf(new NOCHeader(p)))
  val regOrigin = RegInit(0.U(8.W))
  val regStreamPortIdx = RegInit(0.U(addrBits.U))
  val wStall = WireDefault(false.B)

  rxQ.ready := !wStall

  switch(regState) {
    is (sReadHeader) {
      when(rxQ.fire) {
        val rx = rxQ.bits.data.asTypeOf(new NOCHeader(p))
        regHeader := rx
        regOrigin := rxQ.bits.addr
        // Chek if this is a RF req or a stream port req
        when(rx.port > numRegs.U) {
          // Verify that this is a write operation
          when (rx.write) {
            regState := sWriteStreamPort
            regStreamPortIdx := rx.port - numRegs.U
          }.otherwise{
            assert(false.B)
          }
        }.otherwise {
          // Normal RF req.
          when(rx.write) {
            regState := sWriteReg
          }.elsewhen(!rx.write && rx.length === 0.U) {
            regState := sReadReg1
          }.otherwise {
            assert(false.B)
          }
        }
      }
    }
    is(sWriteStreamPort) {

      when (regStreamPortIdx < accel.accelParams.numStreamInPorts.U) {
        accel.io.streamInPort(regStreamPortIdx) <> rxQ
      }.otherwise {
        // Cannot write to this port. Just ditch the data
        rxQ.ready := true.B
        assert(false.B)
      }

      when (rxQ.fire) {
        when(regHeader.length > 1.U) {
          regHeader.length := regHeader.length - 1.U
        }.otherwise {
          regState := sReadHeader
        }
      }

    }
    is (sWriteReg) {
      when (rxQ.fire) {

        regFile.extIF.write(regHeader.port, rxQ.bits.data.asUInt)
        when (regHeader.length > 1.U) {
          regHeader.length := regHeader.length - 1.U
        }.otherwise{
          regState := sReadHeader
        }
      }
    }

    is (sReadReg1) {
      wStall := true.B
      regFile.extIF.read(regHeader.port)
      regState := sReadReg2
    }
    is (sReadReg2) {
      wStall := true.B
      regFile.extIF.read(regHeader.port)
      csrReadRsp.bits.data := regFile.extIF.readData.bits
      csrReadRsp.bits.addr := regOrigin
      csrReadRsp.valid := regFile.extIF.readData.valid
      if (txArbiter.isDefined) {
        txArbiter.get.in(0) <> csrReadRsp
      } else {
        io.tx <> csrReadRsp
      }
      assert(regFile.extIF.readData.valid)
      when(csrReadRsp.fire) {
        regState := sReadHeader
      }
    }
  }

  // -----------------------------------------------------------------------------------------------------------------
  //  Handling data written to stream ports from the accel. I have to handle some edge cases due to
  //  the chance of not having streaming ports
  // -----------------------------------------------------------------------------------------------------------------

  // We can have multiple outgoing stream ports. But we have only a single NOC interface. Use an arbiter
  val streamPortTxArbiter = if (accel.accelParams.numStreamOutPorts > 1)
    Some(Module(new RRArbiter(new StreamEntry(UInt(p.memDataBits.W)), accel.accelParams.numStreamOutPorts)).io)
  else
    None


  if (accel.accelParams.numStreamOutPorts > 0) {
    assert(txArbiter.isDefined)
    if (streamPortTxArbiter.isDefined) {
      streamPortTxArbiter.get.out <> txArbiter.get.in(1)
    }
    // Connect each streamOut port to this arbiter
    for (i <- 0 until accel.accelParams.numStreamOutPorts) {
      val q = Queue(accel.io.streamOutPort(i))
      if (streamPortTxArbiter.isDefined) {
        q <> streamPortTxArbiter.get.in(i)
      } else {
        q <> txArbiter.get.in(1)
      }
    }
  }
}


