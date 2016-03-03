package TidbitsDMA

import Chisel._

class GatherCache(
  banks: Int,
  linesPerBank: Int,
  nbMissesPerBank: Int,
  indWidth: Int,
  datWidth: Int,
  tagWidth: Int,
  mrp: MemReqParams
) extends Module {
  val io = new GatherIF(indWidth, datWidth, tagWidth, mrp) {
    // req - rsp interface for memory reads
    val memRdReq = Decoupled(new GenericMemoryRequest(mrp))
    val memRdRsp = Decoupled(new GenericMemoryResponse(mrp)).flip
  }

  // TODO instantiate banks and connect logic
}
