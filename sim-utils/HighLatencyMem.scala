package TidbitsSimUtils

import Chisel._
import TidbitsDMA._

class HighLatencyMemParams(
  val depth: Int,
  val numPorts: Int,
  val portDataWidth: Int,
  val portAddrWidth: Int,
  val portIDWidth: Int,
  val queueDepth: Int,
  val latency: Int
) {

  override def clone = {
    new HighLatencyMemParams( depth, numPorts, portDataWidth, portAddrWidth,
                              portIDWidth, queueDepth, latency).asInstanceOf[this.type]
  }

  def toMemReqParams() = {
    new MemReqParams(portAddrWidth, portDataWidth, portIDWidth, 1, 8)
  }
}

class HighLatencyMemPort(val p: HighLatencyMemParams) extends Bundle {
  // requests
  val req = Decoupled(new GenericMemoryRequest(p.toMemReqParams())).flip
  // write data
  val wdt = Decoupled(UInt(width=p.portDataWidth)).flip
  // responses
  val rsp = Decoupled(new GenericMemoryResponse(p.toMemReqParams()))

  override def clone = {
    new HighLatencyMemPort(p).asInstanceOf[this.type]
  }
}

class HighLatencyMem(val p: HighLatencyMemParams) extends Module {
  val pReq = p.toMemReqParams()
  val reqType = new GenericMemoryRequest(pReq)
  val rspType = new GenericMemoryResponse(pReq)

  val io = new Bundle {
    val ports = Vec.fill(p.numPorts) {new HighLatencyMemPort(p)}
    val reads = Vec.fill(p.numPorts) {UInt(OUTPUT, 32)}
    val writes = Vec.fill(p.numPorts) {UInt(OUTPUT, 32)}
  }

  // the memory
  val mem = Mem(UInt(width = p.portDataWidth),  p.depth)

  // memory port queues
  val reqQ = Vec.fill(p.numPorts) {Module(new Queue(reqType, p.queueDepth)).io}
  val wdtQ = Vec.fill(p.numPorts) {Module(new Queue(UInt(width = p.portDataWidth), p.queueDepth)).io}
  val rspQ = Vec.fill(p.numPorts) {Module(new Queue(rspType, p.queueDepth)).io}

  // port connections and memory logic
  for(i <- 0 until p.numPorts) {
    reqQ(i).enq <> io.ports(i).req
    wdtQ(i).enq <> io.ports(i).wdt
    rspQ(i).deq <> io.ports(i).rsp

    val regReadCnt = Reg(init = UInt(0, 32))
    val regWriteCnt = Reg(init = UInt(0, 32))
    io.reads(i) := regReadCnt
    io.writes(i) := regWriteCnt

    val req = reqQ(i).deq
    val wdt = wdtQ(i).deq
    val rsp = rspQ(i).enq

    // TODO how to add latency to responses?
    // we could connect a shift register to just delay it,
    // but we need to support backpressure as well: something like
    // a FIFO with minimum delay

    req.ready := Bool(false)
    wdt.ready := Bool(false)
    rsp.valid := Bool(false)
    rsp.bits.driveDefaults()

    val sIdle :: sServe :: sBurst :: Nil = Enum(UInt(), 3)
    val regState = Reg(init = UInt(sIdle))

    val regBeatsLeft = Reg(init = UInt(0, 32))
    val regBurstAddr = Reg(init = UInt(0, p.portAddrWidth))
    val regOrigReq = Reg(init = GenericMemoryRequest(pReq))

    switch(regState) {
        is(sIdle) {
          req.ready := Bool(true)
          when(req.valid) {
            // register the original request
            regOrigReq := req.bits
            // switch state based on burst
            when(req.bits.numBytes === UInt(p.portDataWidth/8)) {
              regState := sServe
            } .elsewhen(req.bits.numBytes === UInt(p.portDataWidth)) {
              regState := sBurst
            }
          }
        }

        is(sServe) {
          // serve a single read or write
          val baseAddr = regOrigReq.addr/UInt(p.portDataWidth/8)
          when(rsp.ready) {
            rsp.bits.channelID := regOrigReq.channelID
            when(regOrigReq.isWrite) {
              // need write data for writes
              when(wdt.valid) {
                wdt.ready := Bool(true)
                mem(baseAddr) := wdt.bits
                regWriteCnt := regWriteCnt+UInt(1)
                rsp.valid := Bool(true)
                regState := sIdle
              }
            } .otherwise {
              rsp.valid := Bool(true)
              rsp.bits.readData := mem(baseAddr)
              regReadCnt := regReadCnt+UInt(1)
              regState := sIdle
            }
          }
        }

        is(sBurst) {
          // TODO
        }
    }
  }
}
