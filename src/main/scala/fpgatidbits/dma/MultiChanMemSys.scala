package fpgatidbits.dma

import Chisel._
import fpgatidbits.streams._
import fpgatidbits.ocm._

// convenience modules for creating multichannel memory systems
// the request interleaver/deinterleavers already permit this, the additions
// here include automatically assigning chanID values and creating the decoding
// function for the deinterleaver

// TODO better documentation here
// MultiChanMultiPort for multiple channels on multiple ports
// MultiChanReadPort for multiple channels on a single port

class ReadChanParams(
  val maxReadTxns: Int,
  val port: Int,  // not needed for MultiChanReadPort
  // following will be assigned by MultiChanMultiPort (they are "outputs")
  var sysPipeNum: Int = 0,  // physical pipe # in the MultiChanMultiPort
  var portPipeNum: Int = 0, // physical pipe # in the corresponding MultiChanReadPort
  var chanBaseID: Int = 0   // computed base ID value for the channel
)

object ReadChanParams {
  def apply(maxReadTxns: Int, port: Int) = {
    new ReadChanParams(maxReadTxns, port)
  }
}

class MultiChanMultiPort(val mrp: MemReqParams, val numPorts: Int,
  chans: Map[String, ReadChanParams])
extends Module {
  val numChans = chans.size
  // internal, mutable chan -> chan param mapping
  var chanMap = scala.collection.mutable.Map[String, ReadChanParams]()
  //  reverse mapping (port -> chan param sequence)
  var portMap = scala.collection.mutable.Map[Int, Seq[ReadChanParams]]()
  var pipeNum: Int = 0
  // copy to internal mutable map and assign physical pipe numbers
  for((n, p) <- chans) {
    if(!portMap.contains(p.port)) portMap(p.port) = Seq[ReadChanParams]()
    chanMap(n) = new ReadChanParams(p.maxReadTxns, p.port,
      sysPipeNum = pipeNum, portPipeNum = portMap(p.port).size
    )
    portMap(p.port) ++= Seq(chanMap(n))
    pipeNum += 1
  }

  // instantiate MultiChanReadPort modules
  val portAdps = (0 until numPorts).map({
    i: Int => Module(new MultiChanReadPort(mrp, portMap(i)))
  })

  // update the chanBaseID values from the MultiChanReadPort outputs
  for((n, x) <- chans) {
    var p = chanMap(n)
    p.chanBaseID = portAdps(p.port).getChanBaseID(p.portPipeNum)
    chanMap(n) = p
  }

  def getChanParams(name: String): ReadChanParams = {chanMap(name)}
  def connectChanReqRsp(name: String, req: DecoupledIO[GenericMemoryRequest],
    rsp: DecoupledIO[GenericMemoryResponse]) = {
    val pipe = chanMap(name).sysPipeNum
    req <> io.req(pipe)
    io.rsp(pipe) <> rsp
  }

  val io = new Bundle {
    // interface towards channels
    val req = Vec.fill(numChans) { Decoupled(new GenericMemoryRequest(mrp)).flip }
    val rsp = Vec.fill(numChans) { Decoupled(new GenericMemoryResponse(mrp)) }
    // interface towards memory port
    val memReq = Vec.fill(numPorts) {Decoupled(new GenericMemoryRequest(mrp))}
    val memRsp = Vec.fill(numPorts) {Decoupled(new GenericMemoryResponse(mrp)).flip}
  }

  for(i <- 0 until numPorts) {
    portAdps(i).io.memReq <> io.memReq(i)
    io.memRsp(i) <> portAdps(i).io.memRsp
  }

  for((n,p) <- chanMap) {
    io.req(p.sysPipeNum) <> portAdps(p.port).io.req(p.portPipeNum)
    portAdps(p.port).io.rsp(p.portPipeNum) <> io.rsp(p.sysPipeNum)
  }
}

class MultiChanReadPort(val mrp: MemReqParams,
  chans: Seq[ReadChanParams]) extends Module {
  val numChans = chans.size
  val maxTxns = chans.map(x => x.maxReadTxns).foldLeft(0)(Math.max)
  // we'll reserve the least significant <chanReqIDBits> of each id for the
  // channel's internal use
  val chanReqIDBits = log2Up(maxTxns)
  val chanIDBits = log2Up(numChans)
  // TODO not really; it's just that we have to use a different id allocation
  // scheme instead of reserving all lower-order bits for chanReqID bits
  if(chanIDBits + chanReqIDBits > mrp.idWidth)
    throw new Exception("Not enough ID bits to create memory channels")

  // build the channel map, determining the baseID for each channel)
  val chanBaseIDs = (0 until numChans).map(i => i << chanReqIDBits)
  def getChanBaseID(i: Int): Int = { chanBaseIDs(i)}

  val io = new Bundle {
    // interface towards channels
    val req = Vec.fill(numChans) { Decoupled(new GenericMemoryRequest(mrp)).flip }
    val rsp = Vec.fill(numChans) { Decoupled(new GenericMemoryResponse(mrp)) }
    // interface towards memory port
    val memReq = Decoupled(new GenericMemoryRequest(mrp))
    val memRsp = Decoupled(new GenericMemoryResponse(mrp)).flip
  }
  // instantiate the interleaver and connect channels
  val intl = Module(new ReqInterleaver(numChans, mrp)).io
  for(i <- 0 until numChans) { io.req(i) <> intl.reqIn(i) }
  // memory port is driven by the interleaved requests
  intl.reqOut <> io.memReq

  // function to decide where the responses go
  val rspDecode = {x: GenericMemoryResponse => x.channelID >> chanReqIDBits}

  // instantiate deinterleaver and connect channels
  val deintl = Module(new QueuedDeinterleaver(numChans, mrp, 4, rspDecode)).io
  io.memRsp <> deintl.rspIn
  for(i <- 0 until numChans) { deintl.rspOut(i) <> io.rsp(i) }
}
