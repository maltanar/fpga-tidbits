package fpgatidbits.PlatformWrapper

import Chisel._
import fpgatidbits.dma._
import fpgatidbits.regfile._
import fpgatidbits.ocm._
import ConveyInterfaces._

// Wrapper for the Convey Wolverine hardware platform
// (made for WX690T, may work for others)

object WX690TParams extends PlatformWrapperParams {
  val platformName = "WX690T"
  val memAddrBits = 48
  val memDataBits = 64
  val memIDBits = 32
  val memMetaBits = 1
  val numMemPorts = 32 // max possible ports,
                       // will be adjusted to match accelerator
  val sameIDInOrder = false
  val typicalMemLatencyCycles = 128
  val burstBeats = 8
  val coherentMem = false
}

// TODO plug unused platform ports if accel has less mem ports

class WolverinePlatformWrapper(instFxn: PlatformWrapperParams => GenericAccelerator)
extends PlatformWrapper(WX690TParams, instFxn) {
  val useAEGforRegFile = false

  val wolverineDriverFiles = if(useAEGforRegFile) {
    Array[String]("platform-wolverine-debug.cpp", "wolverineregdriverdebug.hpp")
  } else {
    Array[String]("platform-wolverine.cpp", "wolverineregdriver.hpp")
  }

  val platformDriverFiles = baseDriverFiles ++ wolverineDriverFiles


  val driverRegType = "AccelReg"
  val driverBaseHeader = if(useAEGforRegFile) "wolverineregdriverdebug.h" else "wolverineregdriver.h"
  val driverBaseClass = if(useAEGforRegFile) "WolverineRegDriverDebug" else "WolverineRegDriver"
  val driverConstructor = fullName + "() : "+driverBaseClass+"(\""+fullName+"\") {}"

  // the Convey wrapper itself always expects at least one memory port
  // if no mem ports are desired, we still create one and drive outputs to 0
  val nmp = if(accel.numMemPorts == 0) 1 else accel.numMemPorts

  val io = new ConveyPersonalityVerilogIF(nmp, p.memIDBits)
  // rename io signals to be compatible with Verilog template
  io.renameSignals()

  // the base class instantiates:
  // - the accelerator as "accel"
  // - the register file as "regFile"

  io.dispException := UInt(0) // TODO Convey: support exceptions

  // for now, our Convey wrapper accepts a single instructions, then never
  // returns (just keeps idle low and stall high)
  // TODO add a platform-level register to control this
  val regBusy = Reg(init = Bool(false))
  when (!regBusy) {regBusy := io.dispInstValid}
  io.dispIdle := !regBusy
  io.dispStall := regBusy

  if(useAEGforRegFile) {
    // use the Convey AEG interface for controlling the register file
    // useful mostly for debugging in simulation, since the Convey simulation
    // infrastructure does not seem to support CSR r/w
    io.dispAegCnt := UInt(numRegs)
    io.dispRtnValid := regFile.extIF.readData.valid
    io.dispRtnData := regFile.extIF.readData.bits
    regFile.extIF.cmd.bits.regID := io.dispRegID
    regFile.extIF.cmd.bits.read := io.dispRegRead
    regFile.extIF.cmd.bits.write := io.dispRegWrite
    regFile.extIF.cmd.bits.writeData := io.dispRegWrData
    regFile.extIF.cmd.valid := io.dispRegRead || io.dispRegWrite
    // plug the CSR IF
    io.csrReadAck := Bool(false)
    io.csrReadData := UInt(0)

    // hack: special treatment for the "start" register
    // accelerator must not start issuing memreqs before dispatch comes
    // TODO add platform-level start-active-finished signals
    if(regFileMap.contains("start")) {
      println("====> Rewiring start to Convey instruction dispatch")
      accel("start") := regBusy
      when (regBusy) {regBusy := !(accel("finished").toBool())}
    }
    println("====> RegFile is using the Convey AEG interface")
  } else {
    // hack: write 2 to register 0 to un-busy the accelerator
    // why 2? does not overlap with the reset controls in PlatformWrapper
    // this allows a clear detach (don't need to reload same bitfile next time)
    // TODO find a cleaner way to do all this!
    val magicDMatch = io.csrWrData === UInt(2)
    val clearBusyMagic = (io.csrAddr === UInt(0)) & io.csrWrValid & magicDMatch
    when (regBusy & clearBusyMagic) { regBusy := Bool(false)}

    // use the Convey CSR interface for controlling the register file
    // use a single, constant register for the AEGs
    io.dispAegCnt := UInt(1)
    io.dispRtnValid := Reg(next = io.dispRegRead)
    io.dispRtnData := UInt("hdeadbeef")

    // use Convey CSR interface to talk to our regfile
    regFile.extIF.cmd.bits.regID := io.csrAddr
    regFile.extIF.cmd.bits.read := io.csrRdValid
    regFile.extIF.cmd.bits.write := io.csrWrValid
    regFile.extIF.cmd.bits.writeData := io.csrWrData
    regFile.extIF.cmd.valid := io.csrRdValid || io.csrWrValid
    io.csrReadAck := regFile.extIF.readData.valid
    io.csrReadData := regFile.extIF.readData.bits
    println("====> RegFile is using the Convey CSR interface, remember to enable the CSR agent")
  }

  io.mcReqValid := UInt(0)
  io.mcReqRtnCtl := UInt(0)
  io.mcReqData := UInt(0)
  io.mcReqAddr := UInt(0)
  io.mcReqSize := UInt(0)
  io.mcReqCmd := UInt(0)
  io.mcReqSCmd := UInt(0)
  io.mcResStall := UInt(0)
  io.mcReqFlush := UInt(0)

  // wire up memory port adapters
  // TODO add support for write flush
  if (accel.numMemPorts != 0) {
    if(nmp > p.numMemPorts) {
      throw new Exception("Too many mem ports in accelerator")
    }

    val adps = Vec.fill(nmp) {
      Module(new ConveyGenericMemAdapter(p.toMemReqParams())).io
    }

    for(i <- 0 until nmp) { accel.io.memPort(i) <> adps(i).genericMem }

    // Convey's interface semantics (stall-valid) are a bit more different than
    // just a decoupled (inverted ready)-valid:
    // X1) valid and stall asserted together can still mean a transferred element
    //     (i.e valid may not go down for up to 2 cycles after stall is asserted)
    // X2) valid on Convey IF must actually go down after stall is asserted

    def mpHelper(extr: ConveyMemMasterIF => Bits): Bits = {
      Cat(adps.map(x => x.conveyMem).map(extr).reverse)
    }
    type mp = ConveyMemMasterIF

    io.mcReqRtnCtl := mpHelper({mp => mp.req.bits.rtnCtl})
    io.mcReqAddr := mpHelper({mp => mp.req.bits.addr})
    io.mcReqSize := mpHelper({mp => mp.req.bits.size})
    io.mcReqCmd := mpHelper({mp => mp.req.bits.cmd})
    io.mcReqSCmd := mpHelper({mp => mp.req.bits.scmd})
    io.mcReqData := mpHelper({mp => mp.req.bits.writeData})

    // memory response handling:
    // compensate for interface semantics mismatch for memory responses (X1) with
    // little queues
    // - personality receives responses through queue
    // - Convey mem.port's stall is driven by "almost full" from queue
    // TODO generalize this idea into an interface adapter + use for reqs too
    val respQueElems = 8
    val respQueues = Vec.fill(nmp) {
      Module(
          new FPGAQueue(new ConveyMemResponse(p.memIDBits, p.memDataBits), respQueElems)
        ).io
    }

    // an "almost full" derived from the queue count is used
    // to drive the Convey mem resp port's stall input
    // this is quite conservative (stall when FIFO is half full) but
    // it seems to work (there may be a deeper problem here)
    val respStall = Cat(respQueues.map(x => (x.count >= UInt(respQueElems/2))))
    // Cat concatenation order needs to be reversed
    io.mcResStall := Reverse(respStall)

    // drive personality inputs
    for(i <- 0 until nmp) {
      respQueues(i).enq.valid := io.mcResValid(i)
      respQueues(i).enq.bits.rtnCtl := io.mcResRtnCtl(32*(i+1)-1, 32*i)
      respQueues(i).enq.bits.readData := io.mcResData(64*(i+1)-1, 64*i)
      respQueues(i).enq.bits.cmd := io.mcResCmd(3*(i+1)-1, 3*i)
      respQueues(i).enq.bits.scmd := io.mcResSCmd(4*(i+1)-1, 4*i)
      // note that we don't use the enq.ready signal from the queue --
      // we generate our own variant of ready when half-full

      // adapter receives responses from this queue
      adps(i).conveyMem.rsp <> respQueues(i).deq

      // drive req.ready from inverse of req.stall
      adps(i).conveyMem.req.ready := ~io.mcReqStall(i)
    }

    // to compensate for X2, we AND the valid with the inverse of stall before
    // outputting valid
    // TODO do not create potential combinational loop -- make queue-based sln
    io.mcReqValid := mpHelper({mp => mp.req.valid & mp.req.ready})
  }

  // print some warnings to remind the user to change the Makefile values
  println(s"====> Remember to set NUM_MC_PORTS=$nmp in Makefile.include")
  val numRtnCtlBits = p.memIDBits
  println(s"====> Remember to set RTNCTL_WIDTH=$numRtnCtlBits in Makefile.include")
}

// Convey memory request adapter
class ConveyMemReqAdp(p: MemReqParams) extends Module {
  val io = new Bundle {
    val genericReqIn = Decoupled(new GenericMemoryRequest(p)).flip
    val conveyReqOut = Decoupled(new ConveyMemRequest(p.idWidth, p.addrWidth, p.dataWidth))
    val writeData = Decoupled(UInt(width = p.dataWidth)).flip
  }
  if(p.dataWidth != 64) {
    throw new Exception("ConveyMemReqAdp requires p.dataWidth=64")
  }
  // default outputs
  io.genericReqIn.ready := Bool(false)
  io.conveyReqOut.valid := Bool(false)
  io.conveyReqOut.bits.rtnCtl := io.genericReqIn.bits.channelID
  io.conveyReqOut.bits.writeData := io.writeData.bits
  io.conveyReqOut.bits.addr := io.genericReqIn.bits.addr
  // can actually be smaller for subword writes/reads but those are not
  // supported (so UInt( log2Up(p.dataWidth/8)))
  io.conveyReqOut.bits.size := UInt(3)
  // see Convey PDK Guide 8.3.x for more details on the memreq signals
  // values for cmd:
  // 1 for regular load
  // 2 for regular write
  // 6 for burst write
  // 5 for atomics (not supported in fpga-tidbits)
  // 7 for burst read
  io.conveyReqOut.bits.cmd := UInt(0)
  // values for scmd:
  // supposedly number of beats (quadwords) for burst write -- but not really
  // 0 for everything else (except atomics, which we do not support)
  // scmd is not quite 4 bits and not really the # of words to write,
  // the source code says otherwise (aemc_mc.v):
  // ====================================================================
  // AEMC WR64 - sub cmd
  // Sub-command[2:0] indicates WR64 length, i.e.
  // sub-command  | write size
  //     0	    64 bytes
  //     7	    56 bytes
  //     6	    48 bytes
  //     5	    40 bytes
  //     4	    32 bytes
  //     3	    24 bytes
  //     2	    16 bytes
  //     1	     8 bytes
  //
  //  virtual address[5:3] indicate starting quadword offset
  //
  // The cae_xb_if logic uses sub-command[3] == 1'b1, to indicate the
  // last quadword WR64 cycle, the personality should treat sub-command[3]
  // as reserved
  // ====================================================================
  // since we only support 64byte writes anyway, set scmd to be const zero
  io.conveyReqOut.bits.scmd := UInt(0)

  // plug write data ready signals by default
  io.writeData.ready := Bool(false)

  // TODO only 64byte bursts for now
  val isBurst = (io.genericReqIn.bits.numBytes === UInt(64))
  val isWriteBurst = io.genericReqIn.bits.isWrite & isBurst

  // regular write must have both request and data ready
  val isWriteReadyToGo = io.genericReqIn.valid & io.writeData.valid
  val isWriteRegular = io.genericReqIn.bits.isWrite & !isBurst

  val sRegular :: sWriteBurst :: Nil = Enum(UInt(), 2)
  val regState = Reg(init = UInt(sRegular))
  // register to keep write burst state
  val regWriteBurst = Reg(init = GenericMemoryRequest(p))
  val regWriteBeatsLeft = Reg(init = UInt(0, width = 32))

  switch(regState) {
    is(sRegular) {
      // "regular" state for the adapter, burst reads and non-burst writes
      when(isWriteRegular & isWriteReadyToGo) {
        // non-burst write request
        io.conveyReqOut.bits.cmd := UInt(2)
        // both request and associated channel data are valid
        io.conveyReqOut.valid := Bool(true)
        // both request and associated channel data must be ready
        io.genericReqIn.ready := io.conveyReqOut.ready
        io.writeData.ready := io.conveyReqOut.ready
      } .elsewhen (io.genericReqIn.valid && !io.genericReqIn.bits.isWrite) {
        // read request, burst or regular
        io.conveyReqOut.bits.cmd := Mux(isBurst, UInt(7), UInt(1))
        io.conveyReqOut.valid := Bool(true)
        io.genericReqIn.ready := io.conveyReqOut.ready
      } .elsewhen(io.genericReqIn.valid & isWriteBurst) {
        // when write burst is detected, switch to sWriteBurst state
        regState := sWriteBurst
        // consume the write burst request
        io.genericReqIn.ready := Bool(true)
        // register the write request and # of beats needed
        regWriteBurst := io.genericReqIn.bits
        regWriteBeatsLeft := io.genericReqIn.bits.numBytes / UInt(8)
      }
    }
    is(sWriteBurst) {
      // use registers to generate the next request of the write burst
      io.conveyReqOut.bits.cmd := UInt(6)
      io.conveyReqOut.bits.rtnCtl := regWriteBurst.channelID
      io.conveyReqOut.bits.addr := regWriteBurst.addr

      io.conveyReqOut.valid := io.writeData.valid
      io.writeData.ready := io.conveyReqOut.ready

      when(io.conveyReqOut.valid & io.conveyReqOut.ready) {
        // update registered request and decrement counter
        regWriteBeatsLeft := regWriteBeatsLeft - UInt(1)
        regWriteBurst.addr := regWriteBurst.addr + UInt(8)
        // back to sRegular when no more write burst beats
        when(regWriteBeatsLeft <= UInt(1)) {
          regState := sRegular
        }
      }
    }
  }
}

// Convey memory response adapter
class ConveyMemRspAdp(p: MemReqParams) extends Module {
  val io = new Bundle {
    val conveyRspIn = Decoupled(new ConveyMemResponse(32, 64)).flip
    val genericRspOut = Decoupled(new GenericMemoryResponse(p))
  }

  io.conveyRspIn.ready := io.genericRspOut.ready
  io.genericRspOut.valid := io.conveyRspIn.valid

  io.genericRspOut.bits.channelID := io.conveyRspIn.bits.rtnCtl
  io.genericRspOut.bits.readData := io.conveyRspIn.bits.readData
  // TODO handle Convey atomics correctly?
  // this works for reads, writes and bursts, but not atomics
  io.genericRspOut.bits.isWrite := (io.conveyRspIn.bits.cmd === UInt(3))
  // mark the last beat in a read with the isLast flag
  // a single read's response is always last
  val isSingleReadRsp = (io.conveyRspIn.bits.cmd === UInt(2))
  // only supports 8-beat bursts, so a isLast response is always nr 7
  // (first response is #0) TODO Convey atomics won't work with this!
  val isBurstReadRsp = (io.conveyRspIn.bits.cmd === UInt(7))
  val isLastInRdBurst = isBurstReadRsp & (io.conveyRspIn.bits.scmd === UInt(7))
  io.genericRspOut.bits.isLast := isLastInRdBurst | isSingleReadRsp

  // TODO carry cmd and scmd here
  io.genericRspOut.bits.metaData := UInt(0)
}

// Convey memory port adapter
class ConveyGenericMemAdapter(p: MemReqParams) extends Module {
  val io = new Bundle {
    val genericMem = new GenericMemorySlavePort(p)
    val conveyMem = new ConveyMemMasterIF(p.idWidth)
  }

  val muxer = Module(new SimplexAdapter(p)).io
  io.genericMem <> muxer.duplex

  val reqadp = Module(new ConveyMemReqAdp(p)).io
  muxer.simplex.req <> reqadp.genericReqIn
  muxer.simplex.wrdat <> reqadp.writeData
  reqadp.conveyReqOut <> io.conveyMem.req

  val rspadp = Module(new ConveyMemRspAdp(p)).io
  io.conveyMem.rsp <> rspadp.conveyRspIn
  rspadp.genericRspOut <> muxer.simplex.rsp

  // TODO enable flush requests from generic interface somehow?
  io.conveyMem.flushReq := Bool(false)
}
