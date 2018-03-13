package fpgatidbits.ocm

import Chisel._

// A module for inferring true dual-pPort BRAMs on FPGAs

// Since (Xilinx) FPGA synthesis tools do not infer TDP BRAMs from
// Chisel-generated Verilog (both ports in the same "always" block),
// we use a BlackBox with a premade Verilog BRAM template.

class DualPortBRAMIO(addrBits: Int, dataBits: Int) extends Bundle {
  val ports = Vec.fill (2) {new OCMSlaveIF(dataBits, dataBits, addrBits)}

  override def cloneType: this.type =
    new DualPortBRAMIO(addrBits, dataBits).asInstanceOf[this.type]

  ports(0).req.addr.setName("a_addr")
  ports(0).req.writeData.setName("a_din")
  ports(0).req.writeEn.setName("a_wr")
  ports(0).rsp.readData.setName("a_dout")

  ports(1).req.addr.setName("b_addr")
  ports(1).req.writeData.setName("b_din")
  ports(1).req.writeEn.setName("b_wr")
  ports(1).rsp.readData.setName("b_dout")
}

// variant of DualPortBRAM with the desired number of registers at input and
// output. should help achieve higher Fmax with large BRAMs, at the cost of
// latency.
class PipelinedDualPortBRAM(addrBits: Int, dataBits: Int,
  regIn: Int,   // number of registers at input
  regOut: Int   // number of registers at output
) extends Module {
  val io = new DualPortBRAMIO(addrBits, dataBits)
  // instantiate the desired BRAM
  val bram = if(dataBits <= 36 && addrBits <= 4) {
    // use pure Chisel for small memories (just synth to LUTs)
    Module(new DualPortBRAM_NoBlackBox(addrBits, dataBits)).io
  } else {
    Module(new DualPortBRAM(addrBits, dataBits)).io
  }

  bram.ports(0).req := ShiftRegister(io.ports(0).req, regIn)
  bram.ports(1).req := ShiftRegister(io.ports(1).req, regIn)

  io.ports(0).rsp := ShiftRegister(bram.ports(0).rsp, regOut)
  io.ports(1).rsp := ShiftRegister(bram.ports(1).rsp, regOut)
}

class DualPortBRAM(addrBits: Int, dataBits: Int) extends BlackBox {
  val io = new DualPortBRAMIO(addrBits, dataBits)
  setVerilogParameters(new VerilogParameters {
    val DATA = dataBits
    val ADDR = addrBits
  })

  // the clock does not get added to the BlackBox interface by default
  addClock(Driver.implicitClock)

  // simulation model for TDP BRAM
  // for the C++ backend, this generates a model that should be roughly
  // equivalent, although there's no guarantee about what happens on
  // collisions (sim access to same address with two memory ports)

  val mem = Mem(UInt(width = dataBits), 1 << addrBits)

  for (i <- 0 until 2) {
    val req = io.ports(i).req
    val regAddr = Reg(next = io.ports(i).req.addr)

    io.ports(i).rsp.readData := mem(regAddr)

    when (req.writeEn) {
      mem(req.addr) := req.writeData
    }
  }
}

// no BlackBox (pure Chisel) version. won't synthesize to BRAM, but sometimes
// (if the depth is small) this may be more desirable.
class DualPortBRAM_NoBlackBox(addrBits: Int, dataBits: Int) extends Module {
  val io = new DualPortBRAMIO(addrBits, dataBits)

  val mem = Mem(UInt(width = dataBits), 1 << addrBits)

  for (i <- 0 until 2) {
    val req = io.ports(i).req
    val regAddr = Reg(next = io.ports(i).req.addr)

    io.ports(i).rsp.readData := mem(regAddr)

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
