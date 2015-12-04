package TidbitsDMA

import Chisel._
import TidbitsStreams._
import TidbitsOCM._

class ReadChanParams(
  val name: String,
  val maxReadTxns: Int,
  // following will be assigned by MultiChanReadPort
  val chanBase: Int = 0,
  val physPipeNum: Int = 0
)

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

  // build the channel map, determining the baseID for each channel
  var chanMap = scala.collection.mutable.Map[String, ReadChanParams]()
  for(i <- 0 until numChans) {
    chanMap(chans(i).name) = new ReadChanParams(
      chans(i).name, chans(i).maxReadTxns, i << chanReqIDBits, i
    )
  }
  def getPipeNum(name: String): Int = { chanMap(name).physPipeNum }
  def getChanBaseID(name: String): Int = { chanMap(name).chanBase }
  def getChanReadTxns(name: String): Int = { chanMap(name).maxReadTxns }

  val io = new Bundle {
    // interface towards channels
    val req = Vec.fill(numChans) { Decoupled(new GenericMemoryResponse(mrp)).flip }
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
