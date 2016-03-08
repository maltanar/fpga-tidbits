package fpgatidbits.streams

import Chisel._

// StreamCAM: a CAM with stream-style (DecoupledIO) interfaces.
// a CAM with <entires> slots, each slot <tag_bits> wide, is instantiated.
// the <in> interface is used for insertions, and the <rm> interface for
// removals. if the <in> interface blocks (!ready), either the CAM is full
// (indicated by the <full> signal) or the insertion candidate is already
// present (indicated by the <hazard> signal)

class StreamCAM(entries: Int, tag_bits: Int) extends Module {
  val io = new Bundle {
    val hazard = Bool(OUTPUT)
    val full = Bool(OUTPUT)
    val in = Decoupled(UInt(width=tag_bits)).flip
    val rm = Decoupled(UInt(width=tag_bits)).flip
  }

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
  val clear_hit = Bool(INPUT)
  val is_clear_hit = Bool(OUTPUT)
  val clear_tag = Bits(INPUT, tag_bits)

  val tag = Bits(INPUT, tag_bits)
  val hit = Bool(OUTPUT)
  val hits = UInt(OUTPUT, entries)
  val valid_bits = Bits(OUTPUT, entries)
  val write = Bool(INPUT)
  val write_tag = Bits(INPUT, tag_bits)
  val hasFree = Bool(OUTPUT)
  val freeInd = UInt(OUTPUT, log2Up(entries))
}

// TODO make the CAM search/match function customizable?
// (e.g compare only a subset of tag bits or such)
class CAM(entries: Int, tag_bits: Int) extends Module {
  val addr_bits = log2Up(entries)
  val io = new CAMIO(entries, addr_bits, tag_bits)
  val cam_tags = Mem(Bits(width = tag_bits), entries)
  // valid (fullness) of each slot in the CAM
  val vb_array = Reg(init = Bits(0, entries))
  // hit status for clearing
  val clearHits = Vec((0 until entries).map(i => vb_array(i) && cam_tags(i) === io.clear_tag))
  io.is_clear_hit := clearHits.toBits.orR

  // index of first free slot in the CAM (least significant first)
  val freeLocation = PriorityEncoder(~vb_array)
  io.freeInd := freeLocation
  // whether there are any free slots at all
  io.hasFree := orR(~vb_array)

  // produce masks to allow simultaneous write+clear
  val writeMask = Mux(io.write, UIntToOH(freeLocation), Bits(0, entries))
  val clearMask = Mux(io.clear_hit, ~(clearHits.toBits), ~Bits(0, entries))

  vb_array := (vb_array | writeMask) & clearMask

  when (io.write) { cam_tags(freeLocation) := io.write_tag }

  val hits = (0 until entries).map(i => vb_array(i) && cam_tags(i) === io.tag)
  io.valid_bits := vb_array
  io.hits := Vec(hits).toBits
  io.hit := io.hits.orR
}
