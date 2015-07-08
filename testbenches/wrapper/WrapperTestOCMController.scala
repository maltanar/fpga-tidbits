package TidbitsTestbenches

import Chisel._
import TidbitsAXI._
import TidbitsDMA._
import TidbitsStreams._
import TidbitsOCM._

class WrapperTestOCMController(p: AXIAccelWrapperParams) extends AXIWrappableAccel(p) {
  // plug unused ports / set defaults
  plugRegOuts()
  //plugMemWritePort()
  //plugMemReadPort()

  def SubStream[Tin <: Data, Tout <: Data](
    in: DecoupledIO[Tin], gen: Tout, filterFxn: Tin => Tout  ): DecoupledIO[Tout] = {
      val wr = new DecoupledIO(gen)
      wr.valid := in.valid
      in.ready := wr.ready
      wr.bits := filterFxn(in.bits)
      wr.flip
    }

  // const identity register
  io.regOut(0).bits := UInt("h0c0c0c0c")
  io.regOut(0).valid := Bool(true)

  val pMR = p.toMRP()
  val pOCM = new OCMParameters(64*1024, 64, 64, 2, 1)
  pOCM.printParams()

  val ocmInst = Module(new OCMAndController(pOCM, "BRAM64x1024", true)).io
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
  ocmInst.mcif.fillPort <> SubStream(io.memRdRsp, UInt(width=64), filterFxn)
  // use a reducer to count the write responses
  val redFxn = {(a: UInt, b: UInt) => a+b}
  val reducer = Module(new StreamReducer(64, 0, redFxn)).io
  reducer.streamIn <> SubStream(io.memWrRsp, UInt(width=64), filterFxn)

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
}
