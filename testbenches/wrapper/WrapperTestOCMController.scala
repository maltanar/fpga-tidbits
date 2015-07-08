package TidbitsTestbenches

import Chisel._
import TidbitsAXI._
import TidbitsDMA._
import TidbitsStreams._
import TidbitsOCM._

class SubStream[Tin <: Data, Tout <: Data]
  (genI: Tin, genO: Tout, filterFxn: Tin => Tout  ) extends Module {
    val io = new Bundle {
      val in = Decoupled(genI).flip
      val out = Decoupled(genO)
    }
    io.out.valid := io.in.valid
    io.out.bits := filterFxn(io.in.bits)
    io.in.ready := io.out.ready
}

object SubStream {
  def apply[Tin <: Data, Tout <: Data]
  (in: DecoupledIO[Tin], out: DecoupledIO[Tout], filterFxn: Tin=>Tout) = {
    val ss = Module(new SubStream[Tin, Tout](in.bits.clone, out.bits.clone, filterFxn)).io
    ss.in <> in
    ss.out <> out
    ss
  }

}
class WrapperTestOCMController(p: AXIAccelWrapperParams) extends AXIWrappableAccel(p) {
  // plug unused ports / set defaults
  plugRegOuts()
  //plugMemWritePort()
  //plugMemReadPort()

  // const identity register
  io.regOut(0).bits := UInt("h0c0c0c0c")
  io.regOut(0).valid := Bool(true)

  val pMR = p.toMRP()
  val pOCM = new OCMParameters(64*1024, 64, 64, 2, 1)
  pOCM.printParams()

  val ocmInst = Module(new OCMAndController(pOCM, "WrapperBRAM64x1024", true)).io
  // plug user ports (unused for now) -- accessed only via controller
  ocmInst.ocmUser(0).req := NullOCMRequest(pOCM)
  ocmInst.ocmUser(1).req := NullOCMRequest(pOCM)

  // read-write request generators for fills and dumps
  val rrq = Module(new ReadReqGen(pMR, 0)).io
  val wrq = Module(new WriteReqGen(pMR, 0)).io
  rrq.reqs <> io.memRdReq
  wrq.reqs <> io.memWrReq
  io.memWrDat <> Queue(ocmInst.mcif.dumpPort, 16)
  val filterFxn = {x: GenericMemoryResponse => x.readData}
  SubStream(io.memRdRsp, ocmInst.mcif.fillPort, filterFxn)
  // use a reducer to count the write responses
  val redFxn = {(a: UInt, b: UInt) => a+b}
  val reducer = Module(new StreamReducer(64, 0, redFxn)).io
  SubStream(io.memWrRsp, reducer.streamIn, filterFxn)

  // wire up control
  val ctl = io.regIn(1)
  val readBase = io.regIn(3)
  val writeBase = io.regIn(4)
  val byteCount = UInt(pOCM.bits/8)

  ocmInst.mcif.start := ctl(0)
  ocmInst.mcif.mode := ctl(1)
  val startFill = ctl(0) && !ctl(1)
  val startDump = ctl(0) && ctl(1)
  rrq.ctrl.start := startFill
  wrq.ctrl.start := startDump
  reducer.start := startDump
  rrq.ctrl.baseAddr := readBase
  rrq.ctrl.byteCount := byteCount
  wrq.ctrl.baseAddr := writeBase
  wrq.ctrl.byteCount := byteCount
  reducer.byteCount := byteCount

  rrq.ctrl.throttle := Bool(false)
  wrq.ctrl.throttle := Bool(false)

  // wire up status
  io.regOut(2).valid := Bool(true)
  val statusList = List(   rrq.stat.finished, wrq.stat.finished,
                           reducer.finished, ocmInst.mcif.done)
  io.regOut(2).bits := Cat(statusList)

  // memory port operation counters
  // TODO make these an optional part of the infrastructure,
  // can be quite useful for debugging
  val regReadReqCount = Reg(init = UInt(0, 32))
  val regWriteReqCount = Reg(init = UInt(0, 32))
  val regWriteDataCount = Reg(init = UInt(0, 32))
  val regReadRspCount = Reg(init = UInt(0, 32))
  val regWriteRspCount = Reg(init = UInt(0, 32))


  when(io.memRdReq.valid & io.memRdReq.ready) {
    regReadReqCount := regReadReqCount + UInt(1)
  }

  when(io.memWrReq.valid & io.memWrReq.ready) {
    regWriteReqCount := regWriteReqCount + UInt(1)
  }

  when(io.memWrDat.valid & io.memWrDat.ready) {
    regWriteDataCount := regWriteDataCount + UInt(1)
  }

  when(io.memRdRsp.valid & io.memRdRsp.ready) {
    regReadRspCount := regReadRspCount + UInt(1)
  }

  when(io.memWrRsp.valid & io.memWrRsp.ready) {
    regWriteRspCount := regWriteRspCount + UInt(1)
  }

  io.regOut(5).valid := Bool(true)
  io.regOut(5).bits := regReadReqCount
  io.regOut(6).valid := Bool(true)
  io.regOut(6).bits := regWriteReqCount
  io.regOut(7).valid := Bool(true)
  io.regOut(7).bits := regWriteDataCount
  io.regOut(8).valid := Bool(true)
  io.regOut(8).bits := regReadRspCount
  io.regOut(9).valid := Bool(true)
  io.regOut(9).bits := regWriteRspCount
}
