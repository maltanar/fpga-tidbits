package fpgatidbits.streams

import chisel3._
import chisel3.util._

// StreamCAM: a CAM with stream-style (DecoupledIO) interfaces.
// a CAM with <entires> slots, each slot <tag_bits> wide, is instantiated.
// the <in> interface is used for insertions, and the <rm> interface for
// removals. if the <in> interface blocks (!ready), either the CAM is full
// (indicated by the <full> signal) or the insertion candidate is already
// present (indicated by the <hazard> signal)

class StreamCAM(entries: Int, tag_bits: Int) extends Module {
  val io = IO(new Bundle {
    val hazard = Output(Bool())
    val full = Output(Bool())
    val in = Flipped(Decoupled(UInt(tag_bits.W)))
    val rm = Flipped(Decoupled(UInt(tag_bits.W)))
  })

  val cam = Module(new CAM(entries, tag_bits)).io
  // removal logic
  cam.clear_hit := io.rm.valid
  cam.clear_tag := io.rm.bits
  io.rm.ready := cam.is_clear_hit

  // insertion logic
  cam.tag := io.in.bits
  val canInsert = cam.hasFree & !cam.hit
  io.in.ready := canInsert
  cam.write_tag := io.in.bits
  cam.write := canInsert & io.in.valid
  io.hazard := cam.hit & io.in.valid
  io.full := !cam.hasFree
}


// adapted from J. Bachrach's "Advanced Chisel" slides
// interface & implementation for a combinational content-addressable memory

class CAMIO(entries: Int, addr_bits: Int, tag_bits: Int) extends Bundle {
  val clear_hit = Input(Bool())
  val is_clear_hit = Output(Bool())
  val clear_tag = Input(UInt(tag_bits.W))

  val tag = Input(UInt(tag_bits.W))
  val hit = Output(Bool())
  val hits = Output(UInt(entries.W))
  val valid_bits = Output(UInt(entries.W))
  val write = Input(Bool())
  val write_tag = Input(UInt(tag_bits.W))
  val hasFree = Output(Bool())
  val freeInd = Output(UInt(log2Ceil(entries).W))

  override def cloneType: this.type =
    new CAMIO(entries,addr_bits,tag_bits).asInstanceOf[this.type]
}

// TODO make the CAM search/match function customizable?
// (e.g compare only a subset of tag bits or such)
class CAM(entries: Int, tag_bits: Int) extends Module {
  val addr_bits = log2Up(entries)
  val io = IO(new CAMIO(entries, addr_bits, tag_bits))
  val cam_tags = SyncReadMem(entries, UInt(tag_bits.W))
  // valid (fullness) of each slot in the CAM
  val vb_array = RegInit(0.U(entries.W))
  // hit status for clearing
  //val clearHits = Vec((0 until entries).map(i => vb_array(i) && cam_tags(i) === io.clear_tag))
  val clearHits = VecInit(Seq.tabulate(entries){i => vb_array(i) && cam_tags(i) === io.clear_tag})
  io.is_clear_hit := clearHits.asUInt.orR

  // index of first free slot in the CAM (least significant first)
  val freeLocation = PriorityEncoder(~vb_array)
  io.freeInd := freeLocation
  // whether there are any free slots at all
  io.hasFree := ~vb_array.orR

  // produce masks to allow simultaneous write+clear
  val writeMask = Mux(io.write, UIntToOH(freeLocation), (0.U(entries.W)))
  val clearMask = Mux(io.clear_hit, (~clearHits.asUInt).asUInt, (~0.U(entries.W)).asUInt)

  vb_array := ((vb_array | writeMask) & clearMask).asUInt

  when (io.write) { cam_tags(freeLocation) := io.write_tag }

  val hits = VecInit(Seq.tabulate(entries) { (i => vb_array(i) && cam_tags(i) === io.tag) })
  io.valid_bits := vb_array
  io.hits := hits.asUInt
  io.hit := io.hits.orR
}
