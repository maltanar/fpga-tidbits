package fpgatidbits.ocm

//import chisel3._
import chisel3.util._
import chisel3._
import chisel3.util._

// A module for inferring true dual-pPort BRAMs on FPGAs

// Since (Xilinx) FPGA synthesis tools do not infer TDP BRAMs from
// Chisel-generated Verilog (both ports in the same "always" block),
// we use a BlackBox with a premade Verilog BRAM template.
class DualPortBRAMExternalIO(addrBits: Int, dataBits: Int) extends Bundle {

    val addr = Output(UInt(addrBits.W))
    val din = Output(UInt(dataBits.W))
    val wr = Output(Bool())
    val dout = Input(UInt(dataBits.W))

    override def cloneType: this.type =
      new DualPortBRAMExternalIO(addrBits, dataBits).asInstanceOf[this.type]

  def connect(in: OCMSlaveIF): Unit  = {
    in.req.addr := addr
    in.req.writeData := din
    in.req.writeEn := wr
    dout := in.rsp.readData
  }

  def connect(in: OCMMasterIF): Unit  = {
    addr := in.req.addr
    din := in.req.writeData
    wr := in.req.writeEn
    in.rsp.readData := dout
  }
}


class DualPortBRAMIO(addrBits: Int, dataBits: Int) extends Bundle {
  val ports = Vec(2, new OCMSlaveIF(dataBits, dataBits, addrBits))

  override def cloneType: this.type =
    new DualPortBRAMIO(addrBits, dataBits).asInstanceOf[this.type]

}

// variant of DualPortBRAM with the desired number of registers at input and
// output. should help achieve higher Fmax with large BRAMs, at the cost of
// latency.
class PipelinedDualPortBRAM(addrBits: Int, dataBits: Int,
  regIn: Int,   // number of registers at input
  regOut: Int   // number of registers at output
) extends Module {
  val io = IO(new DualPortBRAMIO(addrBits, dataBits))
  // instantiate the desired BRAM
  val bram = if(dataBits <= 36 && addrBits <= 4) {
    // use pure Chisel for small memories (just synth to LUTs)
    Module(new DualPortBRAM_NoBlackBox(addrBits, dataBits)).io
  } else {
    Module(new DualPortBRAM(addrBits, dataBits)).io
  }


  // Messy stuff. We instantiate the internal representation of the BRAM interface
  val bramInternal = Wire(new DualPortBRAMIO(addrBits, dataBits))
  // Then we access the two EXTERNAL ports (with the correct naming) and connect them to the internal interface
  bram.a.connect(bramInternal.ports(0))
  bram.b.connect(bramInternal.ports(1))

  // From here we just use the normal internal representation
  bramInternal.ports(0).req := ShiftRegister(io.ports(0).req, regIn)
  bramInternal.ports(1).req := ShiftRegister(io.ports(1).req, regIn)

  io.ports(0).rsp := ShiftRegister(bramInternal.ports(0).rsp, regOut)
  io.ports(1).rsp := ShiftRegister(bramInternal.ports(1).rsp, regOut)
}

class DualPortBRAM(addrBits: Int, dataBits: Int) extends BlackBox(Map("DATA"->dataBits, "ADDR" -> addrBits)) {

  val io = IO(new Bundle {
    val a = Flipped(new DualPortBRAMExternalIO(addrBits, dataBits))
    val b = Flipped(new DualPortBRAMExternalIO(addrBits, dataBits))
  })


  // the clock does not get added to the BlackBox interface by default
//  addClock(Driver.implicitClock)

  // simulation model for TDP BRAM
  // for the C++ backend, this generates a model that should be roughly
  // equivalent, although there's no guarantee about what happens on
  // collisions (sim access to same address with two memory ports)

  //val mem = Mem(UInt(width = dataBits), 1 << addrBits)
  /*
  val mem = SyncReadMem(1 << addrBits, UInt(dataBits.W))

  for (i <- 0 until 2) {
    val req = io.ports(i).req
    val regAddr = RegNext(io.ports(i).req.addr)

    io.ports(i).rsp.readData := mem(regAddr)

    when (req.writeEn) {
      mem(req.addr) := req.writeData
    }
  }

   */
}

// no BlackBox (pure Chisel) version. won't synthesize to BRAM, but sometimes
// (if the depth is small) this may be more desirable.
class DualPortBRAM_NoBlackBox(addrBits: Int, dataBits: Int) extends MultiIOModule {

  val io = IO(new Bundle {
    val a = Flipped(new DualPortBRAMExternalIO(addrBits, dataBits))
    val b = Flipped(new DualPortBRAMExternalIO(addrBits, dataBits))
  })

  val ioInternal = new DualPortBRAMIO(addrBits, dataBits)


  io.a.connect(ioInternal.ports(0))
  io.b.connect(ioInternal.ports(1))

  //val mem = Mem(UInt(width = dataBits), 1 << addrBits)
  val mem = SyncReadMem(1 << addrBits, UInt(dataBits.W))
  for (i <- 0 until 2) {
    val req = ioInternal.ports(i).req
    val regAddr = RegNext(ioInternal.ports(i).req.addr)

    ioInternal.ports(i).rsp.readData := mem(regAddr)

    when (req.writeEn) {
      mem(req.addr) := req.writeData
    }
  }
}

// the dual-port BRAM Verilog below is adapted from Dan Strother's example:
// http://danstrother.com/2010/09/11/inferring-rams-in-fpgas/
/*

module DualPortBRAM #(
    parameter DATA = 72,
    parameter ADDR = 10
) (
    input   wire               clk,

    // Port A
    input   wire                a_wr,
    input   wire    [ADDR-1:0]  a_addr,
    input   wire    [DATA-1:0]  a_din,
    output  reg     [DATA-1:0]  a_dout,

    // Port B
    input   wire                b_wr,
    input   wire    [ADDR-1:0]  b_addr,
    input   wire    [DATA-1:0]  b_din,
    output  reg     [DATA-1:0]  b_dout
);

// Shared memory
reg [DATA-1:0] mem [(2**ADDR)-1:0];

// Port A
always @(posedge clk) begin
    a_dout      <= mem[a_addr];
    if(a_wr) begin
        a_dout      <= a_din;
        mem[a_addr] <= a_din;
    end
end

// Port B
always @(posedge clk) begin
    b_dout      <= mem[b_addr];
    if(b_wr) begin
        b_dout      <= b_din;
        mem[b_addr] <= b_din;
    end
end

endmodule
*/
