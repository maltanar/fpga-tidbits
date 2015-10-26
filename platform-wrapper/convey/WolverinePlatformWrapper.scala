package TidbitsPlatformWrapper

import Chisel._
import TidbitsDMA._
import TidbitsRegFile._
import ConveyInterfaces._

// Wrapper for the Convey Wolverine hardware platform
// (made for WX690T, may work for others)

trait WX690TParams extends PlatformWrapperParams {
  val platformName = "wx690t"
  val memAddrBits = 48
  val memDataBits = 64
  val memIDBits = 32
  val memMetaBits = 1
  val csrDataBits = 64
  val useAEGforRegFile = false
}

class WolverinePlatformWrapper(p: WX690TParams,
instFxn: PlatformWrapperParams => GenericAccelerator)
extends PlatformWrapper(p, instFxn) {
  val driverRegType = "AccelReg"
  val driverBaseHeader = if(p.useAEGforRegFile) "wolverineregdriverdebug.h" else "wolverineregdriver.h"
  val driverBaseClass = if(p.useAEGforRegFile) "WolverineRegDriverDebug" else "WolverineRegDriver"
  val driverConstructor = fullName + "() : "+driverBaseClass+"(\""+fullName+"\") {}"

  // the Convey wrapper itself always expects at least one memory port
  // if no mem ports are desired, we still create one and drive outputs to 0
  val numCalculatedMemPorts = if(p.numMemPorts == 0) 1 else p.numMemPorts

  val io = new ConveyPersonalityVerilogIF(numCalculatedMemPorts, p.memIDBits)
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

  if(p.useAEGforRegFile) {
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
    if(regFileMap.contains("start")) {
      println("====> Rewiring start to Convey instruction dispatch")
      accel("start") := regBusy
    }
    println("====> RegFile is using the Convey AEG interface")
  } else {
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
  // TODO also enable the write channels -- use simplex generic channel
  // TODO use adapter modules instead of manual adapting
  // TODO add support for write flush
  if (p.numMemPorts != 0) {
    val adps = Vec.fill(p.numMemPorts) {
      Module(new ConveyGenericMemAdapter(p.toMemReqParams())).io
    }

    for(i <- 0 until p.numMemPorts) { accel.memPort(i) <> adps(i).genericMem }

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
    val respQueues = Vec.fill(p.numMemPorts) {
      Module(
          new Queue(new ConveyMemResponse(p.memIDBits, p.memDataBits), respQueElems)
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
    for(i <- 0 until p.numMemPorts) {
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

  // print some warnings to remind the user to change the cae_pers.v values
  println(s"====> Remember to set NUM_MC_PORTS=$numCalculatedMemPorts in cae_pers.v")
  val numRtnCtlBits = p.memIDBits
  println(s"====> Remember to set RTNCTL_WIDTH=$numRtnCtlBits in cae_pers.v")
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
  io.conveyReqOut.bits.size := UInt( log2Up(p.dataWidth/8) )
  // TODO scmd needs to be set for write bursts
  io.conveyReqOut.bits.scmd := UInt(0)
  io.conveyReqOut.bits.cmd := UInt(0)

  // plug write data ready signals by default
  io.writeData.ready := Bool(false)

  // write must have both request and data ready
  val validWrite = io.genericReqIn.valid & io.writeData.valid

  when (validWrite && io.genericReqIn.bits.isWrite) {
    // write request
    // both request and associated channel data are valid
    io.conveyReqOut.valid := Bool(true)
    // both request and associated channel data must be ready
    io.genericReqIn.ready := io.conveyReqOut.ready
    io.writeData.ready := io.conveyReqOut.ready
  } .elsewhen (io.genericReqIn.valid && !io.genericReqIn.bits.isWrite) {
    // read request
    io.conveyReqOut.valid := Bool(true)
    io.genericReqIn.ready := io.conveyReqOut.ready
  }
  // command according to burst length and r/w flag
  when (io.genericReqIn.bits.numBytes === UInt(64)) {
    io.conveyReqOut.bits.cmd := Mux(io.genericReqIn.bits.isWrite, UInt(6), UInt(7))
  } .elsewhen (io.genericReqIn.bits.numBytes === UInt(8)) {
    io.conveyReqOut.bits.cmd := Mux(io.genericReqIn.bits.isWrite, UInt(2), UInt(1))
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
