package fpgatidbits.dma

import chisel3._
import chisel3.util._
import fpgatidbits.streams._

// interface for "gather"-accelerators
// gather is defined as an indirectly index memory operation; e.g. given
// two arrays ind and val, produce a third array res where
// the res array is constructed by indexing the val array by the ind array

// a single gather request
class GatherReq(indWidth: Int, tagWidth: Int) extends PrintableBundle {
  val ind = UInt(indWidth.W)  // index to be loaded
  val tag = UInt(tagWidth.W)  // tag associated with this request

  val printfStr = "gatherReq: ind = %d tag = %d \n"
  val printfElems = {() => Seq(ind, tag)}

  override def cloneType: this.type =
    new GatherReq(indWidth, tagWidth).asInstanceOf[this.type]
}

// response to a single gather request
class GatherRsp(datWidth: Int, tagWidth: Int) extends PrintableBundle {
  val dat = UInt(datWidth.W)  // return data
  val tag = UInt(tagWidth.W)  // tag of original request

  val printfStr = "GatherRsp: dat = %d tag = %d \n"
  val printfElems = {() => Seq(dat, tag)}

  override def cloneType: this.type =
    new GatherRsp(datWidth, tagWidth).asInstanceOf[this.type]
}

// interface used by gather accelerators, taking in a stream of requests, and
// emitting a stream of responses
/* TODO IMPROVEMENT: carry in-order / out-of-order info here? */
class GatherIF(indWidth: Int, datWidth: Int, tagWidth: Int, mrp: MemReqParams)
extends Bundle {
  val base = Input(UInt(mrp.addrWidth.W))
  val in = Flipped(Decoupled(new GatherReq(indWidth, tagWidth)))
  val out = Decoupled(new GatherRsp(datWidth, tagWidth))
  override def cloneType: this.type =
    new GatherIF(indWidth, datWidth, tagWidth, mrp).asInstanceOf[this.type]
}
