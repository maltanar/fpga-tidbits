module ReadReqGen(
  input         clock,
  input         reset,
  input         io_ctrl_start,
  input  [31:0] io_ctrl_baseAddr,
  input  [31:0] io_ctrl_byteCount,
  input         io_reqs_ready,
  output        io_reqs_valid,
  output [31:0] io_reqs_bits_addr
);
`ifdef RANDOMIZE_REG_INIT
  reg [31:0] _RAND_0;
  reg [31:0] _RAND_1;
  reg [31:0] _RAND_2;
`endif // RANDOMIZE_REG_INIT
  reg [1:0] regState; // @[MemReqGen.scala 40:25]
  reg [31:0] regAddr; // @[MemReqGen.scala 41:24]
  reg [31:0] regBytesLeft; // @[MemReqGen.scala 42:29]
  wire  unalignedAddr = io_ctrl_baseAddr[2:0] != 3'h0; // @[MemReqGen.scala 59:63]
  wire  unalignedSize = io_ctrl_byteCount[2:0] != 3'h0; // @[MemReqGen.scala 62:64]
  wire  isUnaligned = unalignedSize | unalignedAddr; // @[MemReqGen.scala 63:35]
  wire  _T_3 = 2'h0 == regState; // @[Conditional.scala 37:30]
  wire  _T_5 = 2'h1 == regState; // @[Conditional.scala 37:30]
  wire  _T_6 = regBytesLeft == 32'h0; // @[MemReqGen.scala 73:28]
  wire [31:0] _T_9 = regAddr + 32'h8; // @[MemReqGen.scala 79:32]
  wire [31:0] _T_11 = regBytesLeft - 32'h8; // @[MemReqGen.scala 80:42]
  wire  _GEN_7 = _T_6 ? 1'h0 : 1'h1; // @[MemReqGen.scala 73:37]
  wire  _T_12 = 2'h2 == regState; // @[Conditional.scala 37:30]
  wire  _T_13 = ~io_ctrl_start; // @[MemReqGen.scala 87:15]
  wire  _T_14 = 2'h3 == regState; // @[Conditional.scala 37:30]
  wire  _T_16 = ~reset; // @[MemReqGen.scala 93:15]
  wire  _GEN_16 = _T_5 & _GEN_7; // @[Conditional.scala 39:67]
  wire  _GEN_27 = ~_T_3; // @[MemReqGen.scala 93:15]
  wire  _GEN_28 = ~_T_5; // @[MemReqGen.scala 93:15]
  wire  _GEN_29 = _GEN_27 & _GEN_28; // @[MemReqGen.scala 93:15]
  wire  _GEN_30 = ~_T_12; // @[MemReqGen.scala 93:15]
  wire  _GEN_31 = _GEN_29 & _GEN_30; // @[MemReqGen.scala 93:15]
  wire  _GEN_32 = _GEN_31 & _T_14; // @[MemReqGen.scala 93:15]
  assign io_reqs_valid = _T_3 ? 1'h0 : _GEN_16; // @[MemReqGen.scala 47:17 MemReqGen.scala 76:25]
  assign io_reqs_bits_addr = regAddr; // @[MemReqGen.scala 50:21]
`ifdef RANDOMIZE_GARBAGE_ASSIGN
`define RANDOMIZE
`endif
`ifdef RANDOMIZE_INVALID_ASSIGN
`define RANDOMIZE
`endif
`ifdef RANDOMIZE_REG_INIT
`define RANDOMIZE
`endif
`ifdef RANDOMIZE_MEM_INIT
`define RANDOMIZE
`endif
`ifndef RANDOM
`define RANDOM $random
`endif
`ifdef RANDOMIZE_MEM_INIT
  integer initvar;
`endif
`ifndef SYNTHESIS
`ifdef FIRRTL_BEFORE_INITIAL
`FIRRTL_BEFORE_INITIAL
`endif
initial begin
  `ifdef RANDOMIZE
    `ifdef INIT_RANDOM
      `INIT_RANDOM
    `endif
    `ifndef VERILATOR
      `ifdef RANDOMIZE_DELAY
        #`RANDOMIZE_DELAY begin end
      `else
        #0.002 begin end
      `endif
    `endif
`ifdef RANDOMIZE_REG_INIT
  _RAND_0 = {1{`RANDOM}};
  regState = _RAND_0[1:0];
  _RAND_1 = {1{`RANDOM}};
  regAddr = _RAND_1[31:0];
  _RAND_2 = {1{`RANDOM}};
  regBytesLeft = _RAND_2[31:0];
`endif // RANDOMIZE_REG_INIT
  `endif // RANDOMIZE
end // initial
`ifdef FIRRTL_AFTER_INITIAL
`FIRRTL_AFTER_INITIAL
`endif
`endif // SYNTHESIS
  always @(posedge clock) begin
    if (reset) begin
      regState <= 2'h0;
    end else if (_T_3) begin
      if (io_ctrl_start) begin
        if (isUnaligned) begin
          regState <= 2'h3;
        end else begin
          regState <= 2'h1;
        end
      end
    end else if (_T_5) begin
      if (_T_6) begin
        regState <= 2'h2;
      end
    end else if (_T_12) begin
      if (_T_13) begin
        regState <= 2'h0;
      end
    end
    if (reset) begin
      regAddr <= 32'h0;
    end else if (_T_3) begin
      regAddr <= io_ctrl_baseAddr;
    end else if (_T_5) begin
      if (!(_T_6)) begin
        if (io_reqs_ready) begin
          regAddr <= _T_9;
        end
      end
    end
    if (reset) begin
      regBytesLeft <= 32'h0;
    end else if (_T_3) begin
      regBytesLeft <= io_ctrl_byteCount;
    end else if (_T_5) begin
      if (!(_T_6)) begin
        if (io_reqs_ready) begin
          regBytesLeft <= _T_11;
        end
      end
    end
    `ifndef SYNTHESIS
    `ifdef PRINTF_COND
      if (`PRINTF_COND) begin
    `endif
        if (_GEN_32 & _T_16) begin
          $fwrite(32'h80000002,"Error in MemReqGen! regAddr = %x byteCount = %d \n",regAddr,io_ctrl_byteCount); // @[MemReqGen.scala 93:15]
        end
    `ifdef PRINTF_COND
      end
    `endif
    `endif // SYNTHESIS
    `ifndef SYNTHESIS
    `ifdef PRINTF_COND
      if (`PRINTF_COND) begin
    `endif
        if (_GEN_32 & _T_16) begin
          $fwrite(32'h80000002,"Unaligned addr? %d size? %d \n",unalignedAddr,unalignedSize); // @[MemReqGen.scala 94:15]
        end
    `ifdef PRINTF_COND
      end
    `endif
    `endif // SYNTHESIS
  end
endmodule
module SRLQueue(
  input         clock,
  input         reset,
  output        io_enq_ready,
  input         io_enq_valid,
  input  [31:0] io_enq_bits,
  input         io_deq_ready,
  output        io_deq_valid,
  output [31:0] io_deq_bits
);
  wire  Q_srl_i_v; // @[FPGAQueue.scala 70:20]
  wire [31:0] Q_srl_i_d; // @[FPGAQueue.scala 70:20]
  wire  Q_srl_i_b; // @[FPGAQueue.scala 70:20]
  wire  Q_srl_o_v; // @[FPGAQueue.scala 70:20]
  wire [31:0] Q_srl_o_d; // @[FPGAQueue.scala 70:20]
  wire  Q_srl_o_b; // @[FPGAQueue.scala 70:20]
  wire [3:0] Q_srl_count; // @[FPGAQueue.scala 70:20]
  wire  Q_srl_clock; // @[FPGAQueue.scala 70:20]
  wire  Q_srl_reset; // @[FPGAQueue.scala 70:20]
  Q_srl #(.depth(8), .width(32)) Q_srl ( // @[FPGAQueue.scala 70:20]
    .i_v(Q_srl_i_v),
    .i_d(Q_srl_i_d),
    .i_b(Q_srl_i_b),
    .o_v(Q_srl_o_v),
    .o_d(Q_srl_o_d),
    .o_b(Q_srl_o_b),
    .count(Q_srl_count),
    .clock(Q_srl_clock),
    .reset(Q_srl_reset)
  );
  assign io_enq_ready = ~Q_srl_i_b; // @[FPGAQueue.scala 83:16]
  assign io_deq_valid = Q_srl_o_v; // @[FPGAQueue.scala 78:16]
  assign io_deq_bits = Q_srl_o_d; // @[FPGAQueue.scala 79:15]
  assign Q_srl_i_v = io_enq_valid; // @[FPGAQueue.scala 73:12]
  assign Q_srl_i_d = io_enq_bits; // @[FPGAQueue.scala 74:12]
  assign Q_srl_o_b = ~io_deq_ready; // @[FPGAQueue.scala 82:12]
  assign Q_srl_clock = clock; // @[FPGAQueue.scala 75:14]
  assign Q_srl_reset = reset; // @[FPGAQueue.scala 76:14]
endmodule
module FPGAQueue(
  input         clock,
  input         reset,
  output        io_enq_ready,
  input         io_enq_valid,
  input  [31:0] io_enq_bits,
  input         io_deq_ready,
  output        io_deq_valid,
  output [31:0] io_deq_bits
);
  wire  SRLQueue_clock; // @[FPGAQueue.scala 168:26]
  wire  SRLQueue_reset; // @[FPGAQueue.scala 168:26]
  wire  SRLQueue_io_enq_ready; // @[FPGAQueue.scala 168:26]
  wire  SRLQueue_io_enq_valid; // @[FPGAQueue.scala 168:26]
  wire [31:0] SRLQueue_io_enq_bits; // @[FPGAQueue.scala 168:26]
  wire  SRLQueue_io_deq_ready; // @[FPGAQueue.scala 168:26]
  wire  SRLQueue_io_deq_valid; // @[FPGAQueue.scala 168:26]
  wire [31:0] SRLQueue_io_deq_bits; // @[FPGAQueue.scala 168:26]
  SRLQueue SRLQueue ( // @[FPGAQueue.scala 168:26]
    .clock(SRLQueue_clock),
    .reset(SRLQueue_reset),
    .io_enq_ready(SRLQueue_io_enq_ready),
    .io_enq_valid(SRLQueue_io_enq_valid),
    .io_enq_bits(SRLQueue_io_enq_bits),
    .io_deq_ready(SRLQueue_io_deq_ready),
    .io_deq_valid(SRLQueue_io_deq_valid),
    .io_deq_bits(SRLQueue_io_deq_bits)
  );
  assign io_enq_ready = SRLQueue_io_enq_ready; // @[FPGAQueue.scala 169:14]
  assign io_deq_valid = SRLQueue_io_deq_valid; // @[FPGAQueue.scala 169:14]
  assign io_deq_bits = SRLQueue_io_deq_bits; // @[FPGAQueue.scala 169:14]
  assign SRLQueue_clock = clock;
  assign SRLQueue_reset = reset;
  assign SRLQueue_io_enq_valid = io_enq_valid; // @[FPGAQueue.scala 169:14]
  assign SRLQueue_io_enq_bits = io_enq_bits; // @[FPGAQueue.scala 169:14]
  assign SRLQueue_io_deq_ready = io_deq_ready; // @[FPGAQueue.scala 169:14]
endmodule
module StreamFilter(
  output        io_in_ready,
  input         io_in_valid,
  input  [63:0] io_in_bits_readData,
  input         io_out_ready,
  output        io_out_valid,
  output [63:0] io_out_bits
);
  assign io_in_ready = io_out_ready; // @[StreamFilter.scala 14:17]
  assign io_out_valid = io_in_valid; // @[StreamFilter.scala 12:18]
  assign io_out_bits = io_in_bits_readData; // @[StreamFilter.scala 13:17]
endmodule
module ParallelInSerialOut(
  input         clock,
  input         reset,
  input  [63:0] io_parIn,
  input         io_parWrEn,
  output [31:0] io_serOut,
  input         io_shiftEn
);
`ifdef RANDOMIZE_REG_INIT
  reg [31:0] _RAND_0;
  reg [31:0] _RAND_1;
`endif // RANDOMIZE_REG_INIT
  reg [31:0] stages_0; // @[AXIStreamDownsizer.scala 18:23]
  reg [31:0] stages_1; // @[AXIStreamDownsizer.scala 18:23]
  assign io_serOut = stages_0; // @[AXIStreamDownsizer.scala 35:13]
`ifdef RANDOMIZE_GARBAGE_ASSIGN
`define RANDOMIZE
`endif
`ifdef RANDOMIZE_INVALID_ASSIGN
`define RANDOMIZE
`endif
`ifdef RANDOMIZE_REG_INIT
`define RANDOMIZE
`endif
`ifdef RANDOMIZE_MEM_INIT
`define RANDOMIZE
`endif
`ifndef RANDOM
`define RANDOM $random
`endif
`ifdef RANDOMIZE_MEM_INIT
  integer initvar;
`endif
`ifndef SYNTHESIS
`ifdef FIRRTL_BEFORE_INITIAL
`FIRRTL_BEFORE_INITIAL
`endif
initial begin
  `ifdef RANDOMIZE
    `ifdef INIT_RANDOM
      `INIT_RANDOM
    `endif
    `ifndef VERILATOR
      `ifdef RANDOMIZE_DELAY
        #`RANDOMIZE_DELAY begin end
      `else
        #0.002 begin end
      `endif
    `endif
`ifdef RANDOMIZE_REG_INIT
  _RAND_0 = {1{`RANDOM}};
  stages_0 = _RAND_0[31:0];
  _RAND_1 = {1{`RANDOM}};
  stages_1 = _RAND_1[31:0];
`endif // RANDOMIZE_REG_INIT
  `endif // RANDOMIZE
end // initial
`ifdef FIRRTL_AFTER_INITIAL
`FIRRTL_AFTER_INITIAL
`endif
`endif // SYNTHESIS
  always @(posedge clock) begin
    if (reset) begin
      stages_0 <= 32'h0;
    end else if (io_parWrEn) begin
      stages_0 <= io_parIn[31:0];
    end else if (io_shiftEn) begin
      stages_0 <= stages_1;
    end
    if (reset) begin
      stages_1 <= 32'h0;
    end else if (io_parWrEn) begin
      stages_1 <= io_parIn[63:32];
    end else if (io_shiftEn) begin
      stages_1 <= 32'h0;
    end
  end
endmodule
module AXIStreamDownsizer(
  input         clock,
  input         reset,
  output        wide_TREADY,
  input         wide_TVALID,
  input  [63:0] wide_TDATA,
  input         narrow_TREADY,
  output        narrow_TVALID,
  output [31:0] narrow_TDATA
);
`ifdef RANDOMIZE_REG_INIT
  reg [31:0] _RAND_0;
  reg [31:0] _RAND_1;
`endif // RANDOMIZE_REG_INIT
  wire  shiftReg_clock; // @[AXIStreamDownsizer.scala 113:24]
  wire  shiftReg_reset; // @[AXIStreamDownsizer.scala 113:24]
  wire [63:0] shiftReg_io_parIn; // @[AXIStreamDownsizer.scala 113:24]
  wire  shiftReg_io_parWrEn; // @[AXIStreamDownsizer.scala 113:24]
  wire [31:0] shiftReg_io_serOut; // @[AXIStreamDownsizer.scala 113:24]
  wire  shiftReg_io_shiftEn; // @[AXIStreamDownsizer.scala 113:24]
  reg [1:0] regState; // @[AXIStreamDownsizer.scala 122:25]
  reg  regShiftCount; // @[AXIStreamDownsizer.scala 123:30]
  wire  _T = 2'h0 == regState; // @[Conditional.scala 37:30]
  wire  _T_1 = 2'h1 == regState; // @[Conditional.scala 37:30]
  wire  _T_3 = regShiftCount + 1'h1; // @[AXIStreamDownsizer.scala 148:40]
  wire [1:0] _GEN_25 = {{1'd0}, regShiftCount}; // @[AXIStreamDownsizer.scala 154:29]
  wire  _T_6 = _GEN_25 == 2'h0; // @[AXIStreamDownsizer.scala 154:29]
  wire  _T_7 = 2'h2 == regState; // @[Conditional.scala 37:30]
  wire  _GEN_8 = narrow_TREADY & wide_TVALID; // @[AXIStreamDownsizer.scala 162:25]
  wire  _GEN_12 = _T_7 & _GEN_8; // @[Conditional.scala 39:67]
  wire  _GEN_15 = _T_1 | _T_7; // @[Conditional.scala 39:67]
  wire  _GEN_17 = _T_1 & narrow_TREADY; // @[Conditional.scala 39:67]
  wire  _GEN_19 = _T_1 ? 1'h0 : _GEN_12; // @[Conditional.scala 39:67]
  ParallelInSerialOut shiftReg ( // @[AXIStreamDownsizer.scala 113:24]
    .clock(shiftReg_clock),
    .reset(shiftReg_reset),
    .io_parIn(shiftReg_io_parIn),
    .io_parWrEn(shiftReg_io_parWrEn),
    .io_serOut(shiftReg_io_serOut),
    .io_shiftEn(shiftReg_io_shiftEn)
  );
  assign wide_TREADY = _T | _GEN_19; // @[AXIStreamDownsizer.scala 126:13 AXIStreamDownsizer.scala 135:17 AXIStreamDownsizer.scala 167:21]
  assign narrow_TVALID = _T ? 1'h0 : _GEN_15; // @[AXIStreamDownsizer.scala 127:14 AXIStreamDownsizer.scala 144:18 AXIStreamDownsizer.scala 160:18]
  assign narrow_TDATA = shiftReg_io_serOut; // @[AXIStreamDownsizer.scala 116:13]
  assign shiftReg_clock = clock;
  assign shiftReg_reset = reset;
  assign shiftReg_io_parIn = wide_TDATA; // @[AXIStreamDownsizer.scala 114:21]
  assign shiftReg_io_parWrEn = _T | _GEN_19; // @[AXIStreamDownsizer.scala 117:23 AXIStreamDownsizer.scala 133:27 AXIStreamDownsizer.scala 166:31]
  assign shiftReg_io_shiftEn = _T ? 1'h0 : _GEN_17; // @[AXIStreamDownsizer.scala 118:23 AXIStreamDownsizer.scala 150:29]
`ifdef RANDOMIZE_GARBAGE_ASSIGN
`define RANDOMIZE
`endif
`ifdef RANDOMIZE_INVALID_ASSIGN
`define RANDOMIZE
`endif
`ifdef RANDOMIZE_REG_INIT
`define RANDOMIZE
`endif
`ifdef RANDOMIZE_MEM_INIT
`define RANDOMIZE
`endif
`ifndef RANDOM
`define RANDOM $random
`endif
`ifdef RANDOMIZE_MEM_INIT
  integer initvar;
`endif
`ifndef SYNTHESIS
`ifdef FIRRTL_BEFORE_INITIAL
`FIRRTL_BEFORE_INITIAL
`endif
initial begin
  `ifdef RANDOMIZE
    `ifdef INIT_RANDOM
      `INIT_RANDOM
    `endif
    `ifndef VERILATOR
      `ifdef RANDOMIZE_DELAY
        #`RANDOMIZE_DELAY begin end
      `else
        #0.002 begin end
      `endif
    `endif
`ifdef RANDOMIZE_REG_INIT
  _RAND_0 = {1{`RANDOM}};
  regState = _RAND_0[1:0];
  _RAND_1 = {1{`RANDOM}};
  regShiftCount = _RAND_1[0:0];
`endif // RANDOMIZE_REG_INIT
  `endif // RANDOMIZE
end // initial
`ifdef FIRRTL_AFTER_INITIAL
`FIRRTL_AFTER_INITIAL
`endif
`endif // SYNTHESIS
  always @(posedge clock) begin
    if (reset) begin
      regState <= 2'h0;
    end else if (_T) begin
      if (wide_TVALID) begin
        regState <= 2'h1;
      end
    end else if (_T_1) begin
      if (narrow_TREADY) begin
        if (_T_6) begin
          regState <= 2'h2;
        end
      end
    end else if (_T_7) begin
      if (narrow_TREADY) begin
        if (wide_TVALID) begin
          regState <= 2'h1;
        end else begin
          regState <= 2'h0;
        end
      end
    end
    if (reset) begin
      regShiftCount <= 1'h0;
    end else if (_T) begin
      regShiftCount <= 1'h0;
    end else if (_T_1) begin
      if (narrow_TREADY) begin
        regShiftCount <= _T_3;
      end
    end else if (_T_7) begin
      if (narrow_TREADY) begin
        if (wide_TVALID) begin
          regShiftCount <= 1'h0;
        end
      end
    end
  end
endmodule
module StreamLimiter(
  input         clock,
  input         reset,
  input         io_start,
  input  [31:0] io_byteCount,
  output        io_streamIn_ready,
  input         io_streamIn_valid,
  input  [31:0] io_streamIn_bits,
  input         io_streamOut_ready,
  output        io_streamOut_valid,
  output [31:0] io_streamOut_bits
);
`ifdef RANDOMIZE_REG_INIT
  reg [31:0] _RAND_0;
  reg [31:0] _RAND_1;
`endif // RANDOMIZE_REG_INIT
  reg [1:0] regState; // @[StreamLimiter.scala 38:25]
  reg [31:0] regBytesLeft; // @[StreamLimiter.scala 40:29]
  wire  _T = 2'h0 == regState; // @[Conditional.scala 37:30]
  wire  _T_1 = 2'h1 == regState; // @[Conditional.scala 37:30]
  wire  _T_2 = io_streamIn_valid & io_streamOut_ready; // @[StreamLimiter.scala 50:33]
  wire [31:0] _T_4 = regBytesLeft - 32'h4; // @[StreamLimiter.scala 51:40]
  wire  _T_5 = regBytesLeft == 32'h4; // @[StreamLimiter.scala 52:30]
  wire  _T_6 = 2'h2 == regState; // @[Conditional.scala 37:30]
  wire  _T_7 = ~io_start; // @[StreamLimiter.scala 63:14]
  wire  _GEN_5 = _T_6 ? 1'h0 : io_streamIn_valid; // @[Conditional.scala 39:67]
  wire  _GEN_6 = _T_6 | io_streamOut_ready; // @[Conditional.scala 39:67]
  wire  _GEN_11 = _T_1 ? io_streamIn_valid : _GEN_5; // @[Conditional.scala 39:67]
  wire  _GEN_12 = _T_1 ? io_streamOut_ready : _GEN_6; // @[Conditional.scala 39:67]
  assign io_streamIn_ready = _T ? io_streamOut_ready : _GEN_12; // @[StreamLimiter.scala 35:21 StreamLimiter.scala 60:27]
  assign io_streamOut_valid = _T ? io_streamIn_valid : _GEN_11; // @[StreamLimiter.scala 34:22 StreamLimiter.scala 58:28]
  assign io_streamOut_bits = io_streamIn_bits; // @[StreamLimiter.scala 33:21]
`ifdef RANDOMIZE_GARBAGE_ASSIGN
`define RANDOMIZE
`endif
`ifdef RANDOMIZE_INVALID_ASSIGN
`define RANDOMIZE
`endif
`ifdef RANDOMIZE_REG_INIT
`define RANDOMIZE
`endif
`ifdef RANDOMIZE_MEM_INIT
`define RANDOMIZE
`endif
`ifndef RANDOM
`define RANDOM $random
`endif
`ifdef RANDOMIZE_MEM_INIT
  integer initvar;
`endif
`ifndef SYNTHESIS
`ifdef FIRRTL_BEFORE_INITIAL
`FIRRTL_BEFORE_INITIAL
`endif
initial begin
  `ifdef RANDOMIZE
    `ifdef INIT_RANDOM
      `INIT_RANDOM
    `endif
    `ifndef VERILATOR
      `ifdef RANDOMIZE_DELAY
        #`RANDOMIZE_DELAY begin end
      `else
        #0.002 begin end
      `endif
    `endif
`ifdef RANDOMIZE_REG_INIT
  _RAND_0 = {1{`RANDOM}};
  regState = _RAND_0[1:0];
  _RAND_1 = {1{`RANDOM}};
  regBytesLeft = _RAND_1[31:0];
`endif // RANDOMIZE_REG_INIT
  `endif // RANDOMIZE
end // initial
`ifdef FIRRTL_AFTER_INITIAL
`FIRRTL_AFTER_INITIAL
`endif
`endif // SYNTHESIS
  always @(posedge clock) begin
    if (reset) begin
      regState <= 2'h0;
    end else if (_T) begin
      if (io_start) begin
        regState <= 2'h1;
      end
    end else if (_T_1) begin
      if (_T_2) begin
        if (_T_5) begin
          regState <= 2'h2;
        end
      end
    end else if (_T_6) begin
      if (_T_7) begin
        regState <= 2'h0;
      end
    end
    if (reset) begin
      regBytesLeft <= 32'h0;
    end else if (_T) begin
      regBytesLeft <= io_byteCount;
    end else if (_T_1) begin
      if (_T_2) begin
        regBytesLeft <= _T_4;
      end
    end
  end
endmodule
module StreamReader(
  input         clock,
  input         reset,
  input         io_start,
  input  [31:0] io_baseAddr,
  input  [31:0] io_byteCount,
  input         io_out_ready,
  output        io_out_valid,
  output [31:0] io_out_bits,
  input         io_req_ready,
  output        io_req_valid,
  output [31:0] io_req_bits_addr,
  output        io_rsp_ready,
  input         io_rsp_valid,
  input  [63:0] io_rsp_bits_readData
);
  wire  ReadReqGen_clock; // @[StreamReader.scala 56:18]
  wire  ReadReqGen_reset; // @[StreamReader.scala 56:18]
  wire  ReadReqGen_io_ctrl_start; // @[StreamReader.scala 56:18]
  wire [31:0] ReadReqGen_io_ctrl_baseAddr; // @[StreamReader.scala 56:18]
  wire [31:0] ReadReqGen_io_ctrl_byteCount; // @[StreamReader.scala 56:18]
  wire  ReadReqGen_io_reqs_ready; // @[StreamReader.scala 56:18]
  wire  ReadReqGen_io_reqs_valid; // @[StreamReader.scala 56:18]
  wire [31:0] ReadReqGen_io_reqs_bits_addr; // @[StreamReader.scala 56:18]
  wire  FPGAQueue_clock; // @[StreamReader.scala 58:20]
  wire  FPGAQueue_reset; // @[StreamReader.scala 58:20]
  wire  FPGAQueue_io_enq_ready; // @[StreamReader.scala 58:20]
  wire  FPGAQueue_io_enq_valid; // @[StreamReader.scala 58:20]
  wire [31:0] FPGAQueue_io_enq_bits; // @[StreamReader.scala 58:20]
  wire  FPGAQueue_io_deq_ready; // @[StreamReader.scala 58:20]
  wire  FPGAQueue_io_deq_valid; // @[StreamReader.scala 58:20]
  wire [31:0] FPGAQueue_io_deq_bits; // @[StreamReader.scala 58:20]
  wire  StreamFilter_io_in_ready; // @[StreamFilter.scala 20:22]
  wire  StreamFilter_io_in_valid; // @[StreamFilter.scala 20:22]
  wire [63:0] StreamFilter_io_in_bits_readData; // @[StreamFilter.scala 20:22]
  wire  StreamFilter_io_out_ready; // @[StreamFilter.scala 20:22]
  wire  StreamFilter_io_out_valid; // @[StreamFilter.scala 20:22]
  wire [63:0] StreamFilter_io_out_bits; // @[StreamFilter.scala 20:22]
  wire  AXIStreamDownsizer_clock; // @[AXIStreamDownsizer.scala 70:20]
  wire  AXIStreamDownsizer_reset; // @[AXIStreamDownsizer.scala 70:20]
  wire  AXIStreamDownsizer_wide_TREADY; // @[AXIStreamDownsizer.scala 70:20]
  wire  AXIStreamDownsizer_wide_TVALID; // @[AXIStreamDownsizer.scala 70:20]
  wire [63:0] AXIStreamDownsizer_wide_TDATA; // @[AXIStreamDownsizer.scala 70:20]
  wire  AXIStreamDownsizer_narrow_TREADY; // @[AXIStreamDownsizer.scala 70:20]
  wire  AXIStreamDownsizer_narrow_TVALID; // @[AXIStreamDownsizer.scala 70:20]
  wire [31:0] AXIStreamDownsizer_narrow_TDATA; // @[AXIStreamDownsizer.scala 70:20]
  wire  StreamLimiter_clock; // @[StreamLimiter.scala 14:25]
  wire  StreamLimiter_reset; // @[StreamLimiter.scala 14:25]
  wire  StreamLimiter_io_start; // @[StreamLimiter.scala 14:25]
  wire [31:0] StreamLimiter_io_byteCount; // @[StreamLimiter.scala 14:25]
  wire  StreamLimiter_io_streamIn_ready; // @[StreamLimiter.scala 14:25]
  wire  StreamLimiter_io_streamIn_valid; // @[StreamLimiter.scala 14:25]
  wire [31:0] StreamLimiter_io_streamIn_bits; // @[StreamLimiter.scala 14:25]
  wire  StreamLimiter_io_streamOut_ready; // @[StreamLimiter.scala 14:25]
  wire  StreamLimiter_io_streamOut_valid; // @[StreamLimiter.scala 14:25]
  wire [31:0] StreamLimiter_io_streamOut_bits; // @[StreamLimiter.scala 14:25]
  wire  _T_2 = io_byteCount[2:0] == 3'h0; // @[StreamReader.scala 46:28]
  wire [28:0] _T_4 = io_byteCount[31:3] + 29'h1; // @[StreamReader.scala 47:39]
  wire [31:0] _T_5 = {_T_4,3'h0}; // @[Cat.scala 29:58]
  ReadReqGen ReadReqGen ( // @[StreamReader.scala 56:18]
    .clock(ReadReqGen_clock),
    .reset(ReadReqGen_reset),
    .io_ctrl_start(ReadReqGen_io_ctrl_start),
    .io_ctrl_baseAddr(ReadReqGen_io_ctrl_baseAddr),
    .io_ctrl_byteCount(ReadReqGen_io_ctrl_byteCount),
    .io_reqs_ready(ReadReqGen_io_reqs_ready),
    .io_reqs_valid(ReadReqGen_io_reqs_valid),
    .io_reqs_bits_addr(ReadReqGen_io_reqs_bits_addr)
  );
  FPGAQueue FPGAQueue ( // @[StreamReader.scala 58:20]
    .clock(FPGAQueue_clock),
    .reset(FPGAQueue_reset),
    .io_enq_ready(FPGAQueue_io_enq_ready),
    .io_enq_valid(FPGAQueue_io_enq_valid),
    .io_enq_bits(FPGAQueue_io_enq_bits),
    .io_deq_ready(FPGAQueue_io_deq_ready),
    .io_deq_valid(FPGAQueue_io_deq_valid),
    .io_deq_bits(FPGAQueue_io_deq_bits)
  );
  StreamFilter StreamFilter ( // @[StreamFilter.scala 20:22]
    .io_in_ready(StreamFilter_io_in_ready),
    .io_in_valid(StreamFilter_io_in_valid),
    .io_in_bits_readData(StreamFilter_io_in_bits_readData),
    .io_out_ready(StreamFilter_io_out_ready),
    .io_out_valid(StreamFilter_io_out_valid),
    .io_out_bits(StreamFilter_io_out_bits)
  );
  AXIStreamDownsizer AXIStreamDownsizer ( // @[AXIStreamDownsizer.scala 70:20]
    .clock(AXIStreamDownsizer_clock),
    .reset(AXIStreamDownsizer_reset),
    .wide_TREADY(AXIStreamDownsizer_wide_TREADY),
    .wide_TVALID(AXIStreamDownsizer_wide_TVALID),
    .wide_TDATA(AXIStreamDownsizer_wide_TDATA),
    .narrow_TREADY(AXIStreamDownsizer_narrow_TREADY),
    .narrow_TVALID(AXIStreamDownsizer_narrow_TVALID),
    .narrow_TDATA(AXIStreamDownsizer_narrow_TDATA)
  );
  StreamLimiter StreamLimiter ( // @[StreamLimiter.scala 14:25]
    .clock(StreamLimiter_clock),
    .reset(StreamLimiter_reset),
    .io_start(StreamLimiter_io_start),
    .io_byteCount(StreamLimiter_io_byteCount),
    .io_streamIn_ready(StreamLimiter_io_streamIn_ready),
    .io_streamIn_valid(StreamLimiter_io_streamIn_valid),
    .io_streamIn_bits(StreamLimiter_io_streamIn_bits),
    .io_streamOut_ready(StreamLimiter_io_streamOut_ready),
    .io_streamOut_valid(StreamLimiter_io_streamOut_valid),
    .io_streamOut_bits(StreamLimiter_io_streamOut_bits)
  );
  assign io_out_valid = FPGAQueue_io_deq_valid; // @[StreamReader.scala 121:12]
  assign io_out_bits = FPGAQueue_io_deq_bits; // @[StreamReader.scala 121:12]
  assign io_req_valid = ReadReqGen_io_reqs_valid; // @[StreamReader.scala 98:13]
  assign io_req_bits_addr = ReadReqGen_io_reqs_bits_addr; // @[StreamReader.scala 98:13]
  assign io_rsp_ready = StreamFilter_io_in_ready; // @[StreamFilter.scala 21:13]
  assign ReadReqGen_clock = clock;
  assign ReadReqGen_reset = reset;
  assign ReadReqGen_io_ctrl_start = io_start; // @[StreamReader.scala 62:17]
  assign ReadReqGen_io_ctrl_baseAddr = io_baseAddr; // @[StreamReader.scala 63:20]
  assign ReadReqGen_io_ctrl_byteCount = _T_2 ? io_byteCount : _T_5; // @[StreamReader.scala 67:21]
  assign ReadReqGen_io_reqs_ready = io_req_ready; // @[StreamReader.scala 98:13]
  assign FPGAQueue_clock = clock;
  assign FPGAQueue_reset = reset;
  assign FPGAQueue_io_enq_valid = StreamLimiter_io_streamOut_valid; // @[StreamReader.scala 114:56]
  assign FPGAQueue_io_enq_bits = StreamLimiter_io_streamOut_bits; // @[StreamReader.scala 114:56]
  assign FPGAQueue_io_deq_ready = io_out_ready; // @[StreamReader.scala 121:12]
  assign StreamFilter_io_in_valid = io_rsp_valid; // @[StreamFilter.scala 21:13]
  assign StreamFilter_io_in_bits_readData = io_rsp_bits_readData; // @[StreamFilter.scala 21:13]
  assign StreamFilter_io_out_ready = AXIStreamDownsizer_wide_TREADY; // @[AXIStreamDownsizer.scala 73:14]
  assign AXIStreamDownsizer_clock = clock;
  assign AXIStreamDownsizer_reset = reset;
  assign AXIStreamDownsizer_wide_TVALID = StreamFilter_io_out_valid; // @[AXIStreamDownsizer.scala 72:18]
  assign AXIStreamDownsizer_wide_TDATA = StreamFilter_io_out_bits; // @[AXIStreamDownsizer.scala 71:17]
  assign AXIStreamDownsizer_narrow_TREADY = StreamLimiter_io_streamIn_ready; // @[AXIStreamDownsizer.scala 76:19]
  assign StreamLimiter_clock = clock;
  assign StreamLimiter_reset = reset;
  assign StreamLimiter_io_start = io_start; // @[StreamLimiter.scala 15:19]
  assign StreamLimiter_io_byteCount = io_byteCount; // @[StreamLimiter.scala 16:23]
  assign StreamLimiter_io_streamIn_valid = AXIStreamDownsizer_narrow_TVALID; // @[StreamLimiter.scala 17:22]
  assign StreamLimiter_io_streamIn_bits = AXIStreamDownsizer_narrow_TDATA; // @[StreamLimiter.scala 17:22]
  assign StreamLimiter_io_streamOut_ready = FPGAQueue_io_enq_ready; // @[StreamReader.scala 114:56]
endmodule
module StreamReducer(
  input         clock,
  input         reset,
  input         io_start,
  output        io_finished,
  output [31:0] io_reduced,
  input  [31:0] io_byteCount,
  output        io_streamIn_ready,
  input         io_streamIn_valid,
  input  [31:0] io_streamIn_bits
);
`ifdef RANDOMIZE_REG_INIT
  reg [31:0] _RAND_0;
  reg [31:0] _RAND_1;
  reg [31:0] _RAND_2;
`endif // RANDOMIZE_REG_INIT
  reg [1:0] regState; // @[StreamReducer.scala 18:25]
  reg [31:0] regReduced; // @[StreamReducer.scala 19:27]
  reg [31:0] regBytesLeft; // @[StreamReducer.scala 20:29]
  wire  _T = 2'h0 == regState; // @[Conditional.scala 37:30]
  wire  _T_1 = 2'h1 == regState; // @[Conditional.scala 37:30]
  wire  _T_2 = regBytesLeft == 32'h0; // @[StreamReducer.scala 35:28]
  wire [31:0] _T_4 = regReduced + io_streamIn_bits; // @[TestSum.scala 30:47]
  wire [31:0] _T_6 = regBytesLeft - 32'h4; // @[StreamReducer.scala 40:42]
  wire  _GEN_4 = _T_2 ? 1'h0 : 1'h1; // @[StreamReducer.scala 35:37]
  wire  _T_7 = 2'h2 == regState; // @[Conditional.scala 37:30]
  wire  _T_8 = ~io_start; // @[StreamReducer.scala 47:15]
  wire  _GEN_11 = _T_1 & _GEN_4; // @[Conditional.scala 39:67]
  wire  _GEN_14 = _T_1 ? 1'h0 : _T_7; // @[Conditional.scala 39:67]
  assign io_finished = _T ? 1'h0 : _GEN_14; // @[StreamReducer.scala 22:15 StreamReducer.scala 46:21]
  assign io_reduced = regReduced; // @[StreamReducer.scala 23:14]
  assign io_streamIn_ready = _T ? 1'h0 : _GEN_11; // @[StreamReducer.scala 24:21 StreamReducer.scala 37:29]
`ifdef RANDOMIZE_GARBAGE_ASSIGN
`define RANDOMIZE
`endif
`ifdef RANDOMIZE_INVALID_ASSIGN
`define RANDOMIZE
`endif
`ifdef RANDOMIZE_REG_INIT
`define RANDOMIZE
`endif
`ifdef RANDOMIZE_MEM_INIT
`define RANDOMIZE
`endif
`ifndef RANDOM
`define RANDOM $random
`endif
`ifdef RANDOMIZE_MEM_INIT
  integer initvar;
`endif
`ifndef SYNTHESIS
`ifdef FIRRTL_BEFORE_INITIAL
`FIRRTL_BEFORE_INITIAL
`endif
initial begin
  `ifdef RANDOMIZE
    `ifdef INIT_RANDOM
      `INIT_RANDOM
    `endif
    `ifndef VERILATOR
      `ifdef RANDOMIZE_DELAY
        #`RANDOMIZE_DELAY begin end
      `else
        #0.002 begin end
      `endif
    `endif
`ifdef RANDOMIZE_REG_INIT
  _RAND_0 = {1{`RANDOM}};
  regState = _RAND_0[1:0];
  _RAND_1 = {1{`RANDOM}};
  regReduced = _RAND_1[31:0];
  _RAND_2 = {1{`RANDOM}};
  regBytesLeft = _RAND_2[31:0];
`endif // RANDOMIZE_REG_INIT
  `endif // RANDOMIZE
end // initial
`ifdef FIRRTL_AFTER_INITIAL
`FIRRTL_AFTER_INITIAL
`endif
`endif // SYNTHESIS
  always @(posedge clock) begin
    if (reset) begin
      regState <= 2'h0;
    end else if (_T) begin
      if (io_start) begin
        regState <= 2'h1;
      end
    end else if (_T_1) begin
      if (_T_2) begin
        regState <= 2'h2;
      end
    end else if (_T_7) begin
      if (_T_8) begin
        regState <= 2'h0;
      end
    end
    if (reset) begin
      regReduced <= 32'h0;
    end else if (_T) begin
      regReduced <= 32'h0;
    end else if (_T_1) begin
      if (!(_T_2)) begin
        if (io_streamIn_valid) begin
          regReduced <= _T_4;
        end
      end
    end
    if (reset) begin
      regBytesLeft <= 32'h0;
    end else if (_T) begin
      regBytesLeft <= io_byteCount;
    end else if (_T_1) begin
      if (!(_T_2)) begin
        if (io_streamIn_valid) begin
          regBytesLeft <= _T_6;
        end
      end
    end
  end
endmodule
module TestSum(
  input         clock,
  input         reset,
  input         io_memPort_0_memRdReq_ready,
  output        io_memPort_0_memRdReq_valid,
  output [31:0] io_memPort_0_memRdReq_bits_addr,
  output        io_memPort_0_memRdRsp_ready,
  input         io_memPort_0_memRdRsp_valid,
  input  [63:0] io_memPort_0_memRdRsp_bits_readData,
  input         io_start,
  output        io_finished,
  input  [63:0] io_baseAddr,
  input  [31:0] io_byteCount,
  output [31:0] io_sum,
  output [31:0] io_cycleCount
);
`ifdef RANDOMIZE_REG_INIT
  reg [31:0] _RAND_0;
`endif // RANDOMIZE_REG_INIT
  wire  StreamReader_clock; // @[TestSum.scala 29:22]
  wire  StreamReader_reset; // @[TestSum.scala 29:22]
  wire  StreamReader_io_start; // @[TestSum.scala 29:22]
  wire [31:0] StreamReader_io_baseAddr; // @[TestSum.scala 29:22]
  wire [31:0] StreamReader_io_byteCount; // @[TestSum.scala 29:22]
  wire  StreamReader_io_out_ready; // @[TestSum.scala 29:22]
  wire  StreamReader_io_out_valid; // @[TestSum.scala 29:22]
  wire [31:0] StreamReader_io_out_bits; // @[TestSum.scala 29:22]
  wire  StreamReader_io_req_ready; // @[TestSum.scala 29:22]
  wire  StreamReader_io_req_valid; // @[TestSum.scala 29:22]
  wire [31:0] StreamReader_io_req_bits_addr; // @[TestSum.scala 29:22]
  wire  StreamReader_io_rsp_ready; // @[TestSum.scala 29:22]
  wire  StreamReader_io_rsp_valid; // @[TestSum.scala 29:22]
  wire [63:0] StreamReader_io_rsp_bits_readData; // @[TestSum.scala 29:22]
  wire  StreamReducer_clock; // @[TestSum.scala 30:19]
  wire  StreamReducer_reset; // @[TestSum.scala 30:19]
  wire  StreamReducer_io_start; // @[TestSum.scala 30:19]
  wire  StreamReducer_io_finished; // @[TestSum.scala 30:19]
  wire [31:0] StreamReducer_io_reduced; // @[TestSum.scala 30:19]
  wire [31:0] StreamReducer_io_byteCount; // @[TestSum.scala 30:19]
  wire  StreamReducer_io_streamIn_ready; // @[TestSum.scala 30:19]
  wire  StreamReducer_io_streamIn_valid; // @[TestSum.scala 30:19]
  wire [31:0] StreamReducer_io_streamIn_bits; // @[TestSum.scala 30:19]
  reg [31:0] regCycleCount; // @[TestSum.scala 54:30]
  wire  _T = ~io_start; // @[TestSum.scala 56:8]
  wire  _T_1 = ~io_finished; // @[TestSum.scala 57:24]
  wire  _T_2 = io_start & _T_1; // @[TestSum.scala 57:22]
  wire [31:0] _T_4 = regCycleCount + 32'h1; // @[TestSum.scala 57:70]
  StreamReader StreamReader ( // @[TestSum.scala 29:22]
    .clock(StreamReader_clock),
    .reset(StreamReader_reset),
    .io_start(StreamReader_io_start),
    .io_baseAddr(StreamReader_io_baseAddr),
    .io_byteCount(StreamReader_io_byteCount),
    .io_out_ready(StreamReader_io_out_ready),
    .io_out_valid(StreamReader_io_out_valid),
    .io_out_bits(StreamReader_io_out_bits),
    .io_req_ready(StreamReader_io_req_ready),
    .io_req_valid(StreamReader_io_req_valid),
    .io_req_bits_addr(StreamReader_io_req_bits_addr),
    .io_rsp_ready(StreamReader_io_rsp_ready),
    .io_rsp_valid(StreamReader_io_rsp_valid),
    .io_rsp_bits_readData(StreamReader_io_rsp_bits_readData)
  );
  StreamReducer StreamReducer ( // @[TestSum.scala 30:19]
    .clock(StreamReducer_clock),
    .reset(StreamReducer_reset),
    .io_start(StreamReducer_io_start),
    .io_finished(StreamReducer_io_finished),
    .io_reduced(StreamReducer_io_reduced),
    .io_byteCount(StreamReducer_io_byteCount),
    .io_streamIn_ready(StreamReducer_io_streamIn_ready),
    .io_streamIn_valid(StreamReducer_io_streamIn_valid),
    .io_streamIn_bits(StreamReducer_io_streamIn_bits)
  );
  assign io_memPort_0_memRdReq_valid = StreamReader_io_req_valid; // @[TestSum.scala 49:14]
  assign io_memPort_0_memRdReq_bits_addr = StreamReader_io_req_bits_addr; // @[TestSum.scala 49:14]
  assign io_memPort_0_memRdRsp_ready = StreamReader_io_rsp_ready; // @[TestSum.scala 50:26]
  assign io_finished = StreamReducer_io_finished; // @[TestSum.scala 47:15]
  assign io_sum = StreamReducer_io_reduced; // @[TestSum.scala 46:10]
  assign io_cycleCount = regCycleCount; // @[TestSum.scala 55:17]
  assign StreamReader_clock = clock;
  assign StreamReader_reset = reset;
  assign StreamReader_io_start = io_start; // @[TestSum.scala 32:16]
  assign StreamReader_io_baseAddr = io_baseAddr[31:0]; // @[TestSum.scala 33:19]
  assign StreamReader_io_byteCount = io_byteCount; // @[TestSum.scala 34:20]
  assign StreamReader_io_out_ready = StreamReducer_io_streamIn_ready; // @[TestSum.scala 52:14]
  assign StreamReader_io_req_ready = io_memPort_0_memRdReq_ready; // @[TestSum.scala 49:14]
  assign StreamReader_io_rsp_valid = io_memPort_0_memRdRsp_valid; // @[TestSum.scala 50:26]
  assign StreamReader_io_rsp_bits_readData = io_memPort_0_memRdRsp_bits_readData; // @[TestSum.scala 50:26]
  assign StreamReducer_clock = clock;
  assign StreamReducer_reset = reset;
  assign StreamReducer_io_start = io_start; // @[TestSum.scala 43:13]
  assign StreamReducer_io_byteCount = io_byteCount; // @[TestSum.scala 44:17]
  assign StreamReducer_io_streamIn_valid = StreamReader_io_out_valid; // @[TestSum.scala 52:14]
  assign StreamReducer_io_streamIn_bits = StreamReader_io_out_bits; // @[TestSum.scala 52:14]
`ifdef RANDOMIZE_GARBAGE_ASSIGN
`define RANDOMIZE
`endif
`ifdef RANDOMIZE_INVALID_ASSIGN
`define RANDOMIZE
`endif
`ifdef RANDOMIZE_REG_INIT
`define RANDOMIZE
`endif
`ifdef RANDOMIZE_MEM_INIT
`define RANDOMIZE
`endif
`ifndef RANDOM
`define RANDOM $random
`endif
`ifdef RANDOMIZE_MEM_INIT
  integer initvar;
`endif
`ifndef SYNTHESIS
`ifdef FIRRTL_BEFORE_INITIAL
`FIRRTL_BEFORE_INITIAL
`endif
initial begin
  `ifdef RANDOMIZE
    `ifdef INIT_RANDOM
      `INIT_RANDOM
    `endif
    `ifndef VERILATOR
      `ifdef RANDOMIZE_DELAY
        #`RANDOMIZE_DELAY begin end
      `else
        #0.002 begin end
      `endif
    `endif
`ifdef RANDOMIZE_REG_INIT
  _RAND_0 = {1{`RANDOM}};
  regCycleCount = _RAND_0[31:0];
`endif // RANDOMIZE_REG_INIT
  `endif // RANDOMIZE
end // initial
`ifdef FIRRTL_AFTER_INITIAL
`FIRRTL_AFTER_INITIAL
`endif
`endif // SYNTHESIS
  always @(posedge clock) begin
    if (reset) begin
      regCycleCount <= 32'h0;
    end else if (_T) begin
      regCycleCount <= 32'h0;
    end else if (_T_2) begin
      regCycleCount <= _T_4;
    end
  end
endmodule
module RegFile(
  input         clock,
  input         reset,
  input         io_extIF_cmd_valid,
  input  [2:0]  io_extIF_cmd_bits_regID,
  input         io_extIF_cmd_bits_read,
  input         io_extIF_cmd_bits_write,
  input  [31:0] io_extIF_cmd_bits_writeData,
  output        io_extIF_readData_valid,
  output [31:0] io_extIF_readData_bits,
  output [31:0] io_regOut_3,
  output [31:0] io_regOut_4,
  output [31:0] io_regOut_5,
  output [31:0] io_regOut_7,
  input  [31:0] io_regIn_1_bits,
  input  [31:0] io_regIn_2_bits,
  input  [31:0] io_regIn_6_bits
);
`ifdef RANDOMIZE_REG_INIT
  reg [31:0] _RAND_0;
  reg [31:0] _RAND_1;
  reg [31:0] _RAND_2;
  reg [31:0] _RAND_3;
  reg [31:0] _RAND_4;
  reg [31:0] _RAND_5;
  reg [31:0] _RAND_6;
  reg [31:0] _RAND_7;
  reg [31:0] _RAND_8;
  reg [31:0] _RAND_9;
  reg [31:0] _RAND_10;
  reg [31:0] _RAND_11;
  reg [31:0] _RAND_12;
`endif // RANDOMIZE_REG_INIT
  reg [31:0] regFile_0; // @[RegFile.scala 51:24]
  reg [31:0] regFile_1; // @[RegFile.scala 51:24]
  reg [31:0] regFile_2; // @[RegFile.scala 51:24]
  reg [31:0] regFile_3; // @[RegFile.scala 51:24]
  reg [31:0] regFile_4; // @[RegFile.scala 51:24]
  reg [31:0] regFile_5; // @[RegFile.scala 51:24]
  reg [31:0] regFile_6; // @[RegFile.scala 51:24]
  reg [31:0] regFile_7; // @[RegFile.scala 51:24]
  reg [2:0] regCommand_regID; // @[RegFile.scala 54:27]
  reg  regCommand_read; // @[RegFile.scala 54:27]
  reg  regCommand_write; // @[RegFile.scala 54:27]
  reg [31:0] regCommand_writeData; // @[RegFile.scala 54:27]
  reg  regDoCmd; // @[RegFile.scala 55:25]
  wire  hasExtWriteCommand = regDoCmd & regCommand_write; // @[RegFile.scala 59:38]
  wire [31:0] _GEN_1 = 3'h1 == regCommand_regID ? regFile_1 : regFile_0; // @[RegFile.scala 65:29]
  wire [31:0] _GEN_2 = 3'h2 == regCommand_regID ? regFile_2 : _GEN_1; // @[RegFile.scala 65:29]
  wire [31:0] _GEN_3 = 3'h3 == regCommand_regID ? regFile_3 : _GEN_2; // @[RegFile.scala 65:29]
  wire [31:0] _GEN_4 = 3'h4 == regCommand_regID ? regFile_4 : _GEN_3; // @[RegFile.scala 65:29]
  wire [31:0] _GEN_5 = 3'h5 == regCommand_regID ? regFile_5 : _GEN_4; // @[RegFile.scala 65:29]
  wire [31:0] _GEN_6 = 3'h6 == regCommand_regID ? regFile_6 : _GEN_5; // @[RegFile.scala 65:29]
  assign io_extIF_readData_valid = regDoCmd & regCommand_read; // @[RegFile.scala 62:27]
  assign io_extIF_readData_bits = 3'h7 == regCommand_regID ? regFile_7 : _GEN_6; // @[RegFile.scala 65:29 RegFile.scala 68:29]
  assign io_regOut_3 = regFile_3; // @[RegFile.scala 85:18]
  assign io_regOut_4 = regFile_4; // @[RegFile.scala 85:18]
  assign io_regOut_5 = regFile_5; // @[RegFile.scala 85:18]
  assign io_regOut_7 = regFile_7; // @[RegFile.scala 85:18]
`ifdef RANDOMIZE_GARBAGE_ASSIGN
`define RANDOMIZE
`endif
`ifdef RANDOMIZE_INVALID_ASSIGN
`define RANDOMIZE
`endif
`ifdef RANDOMIZE_REG_INIT
`define RANDOMIZE
`endif
`ifdef RANDOMIZE_MEM_INIT
`define RANDOMIZE
`endif
`ifndef RANDOM
`define RANDOM $random
`endif
`ifdef RANDOMIZE_MEM_INIT
  integer initvar;
`endif
`ifndef SYNTHESIS
`ifdef FIRRTL_BEFORE_INITIAL
`FIRRTL_BEFORE_INITIAL
`endif
initial begin
  `ifdef RANDOMIZE
    `ifdef INIT_RANDOM
      `INIT_RANDOM
    `endif
    `ifndef VERILATOR
      `ifdef RANDOMIZE_DELAY
        #`RANDOMIZE_DELAY begin end
      `else
        #0.002 begin end
      `endif
    `endif
`ifdef RANDOMIZE_REG_INIT
  _RAND_0 = {1{`RANDOM}};
  regFile_0 = _RAND_0[31:0];
  _RAND_1 = {1{`RANDOM}};
  regFile_1 = _RAND_1[31:0];
  _RAND_2 = {1{`RANDOM}};
  regFile_2 = _RAND_2[31:0];
  _RAND_3 = {1{`RANDOM}};
  regFile_3 = _RAND_3[31:0];
  _RAND_4 = {1{`RANDOM}};
  regFile_4 = _RAND_4[31:0];
  _RAND_5 = {1{`RANDOM}};
  regFile_5 = _RAND_5[31:0];
  _RAND_6 = {1{`RANDOM}};
  regFile_6 = _RAND_6[31:0];
  _RAND_7 = {1{`RANDOM}};
  regFile_7 = _RAND_7[31:0];
  _RAND_8 = {1{`RANDOM}};
  regCommand_regID = _RAND_8[2:0];
  _RAND_9 = {1{`RANDOM}};
  regCommand_read = _RAND_9[0:0];
  _RAND_10 = {1{`RANDOM}};
  regCommand_write = _RAND_10[0:0];
  _RAND_11 = {1{`RANDOM}};
  regCommand_writeData = _RAND_11[31:0];
  _RAND_12 = {1{`RANDOM}};
  regDoCmd = _RAND_12[0:0];
`endif // RANDOMIZE_REG_INIT
  `endif // RANDOMIZE
end // initial
`ifdef FIRRTL_AFTER_INITIAL
`FIRRTL_AFTER_INITIAL
`endif
`endif // SYNTHESIS
  always @(posedge clock) begin
    if (reset) begin
      regFile_0 <= 32'h0;
    end else if (hasExtWriteCommand) begin
      if (3'h0 == regCommand_regID) begin
        regFile_0 <= regCommand_writeData;
      end
    end else begin
      regFile_0 <= 32'h47512158;
    end
    if (reset) begin
      regFile_1 <= 32'h0;
    end else if (hasExtWriteCommand) begin
      if (3'h1 == regCommand_regID) begin
        regFile_1 <= regCommand_writeData;
      end
    end else begin
      regFile_1 <= io_regIn_1_bits;
    end
    if (reset) begin
      regFile_2 <= 32'h0;
    end else if (hasExtWriteCommand) begin
      if (3'h2 == regCommand_regID) begin
        regFile_2 <= regCommand_writeData;
      end
    end else begin
      regFile_2 <= io_regIn_2_bits;
    end
    if (reset) begin
      regFile_3 <= 32'h0;
    end else if (hasExtWriteCommand) begin
      if (3'h3 == regCommand_regID) begin
        regFile_3 <= regCommand_writeData;
      end
    end
    if (reset) begin
      regFile_4 <= 32'h0;
    end else if (hasExtWriteCommand) begin
      if (3'h4 == regCommand_regID) begin
        regFile_4 <= regCommand_writeData;
      end
    end
    if (reset) begin
      regFile_5 <= 32'h0;
    end else if (hasExtWriteCommand) begin
      if (3'h5 == regCommand_regID) begin
        regFile_5 <= regCommand_writeData;
      end
    end
    if (reset) begin
      regFile_6 <= 32'h0;
    end else if (hasExtWriteCommand) begin
      if (3'h6 == regCommand_regID) begin
        regFile_6 <= regCommand_writeData;
      end
    end else begin
      regFile_6 <= io_regIn_6_bits;
    end
    if (reset) begin
      regFile_7 <= 32'h0;
    end else if (hasExtWriteCommand) begin
      if (3'h7 == regCommand_regID) begin
        regFile_7 <= regCommand_writeData;
      end
    end
    regCommand_regID <= io_extIF_cmd_bits_regID;
    regCommand_read <= io_extIF_cmd_bits_read;
    regCommand_write <= io_extIF_cmd_bits_write;
    regCommand_writeData <= io_extIF_cmd_bits_writeData;
    if (reset) begin
      regDoCmd <= 1'h0;
    end else begin
      regDoCmd <= io_extIF_cmd_valid;
    end
  end
endmodule
module AXIMemReqAdp(
  output        io_genericReqIn_ready,
  input         io_genericReqIn_valid,
  input  [31:0] io_genericReqIn_bits_addr,
  input  [7:0]  io_genericReqIn_bits_numBytes,
  input         io_axiReqOut_ready,
  output        io_axiReqOut_valid,
  output [31:0] io_axiReqOut_bits_addr,
  output [7:0]  io_axiReqOut_bits_len
);
  wire [7:0] beats = io_genericReqIn_bits_numBytes / 8'h8; // @[AXIMemAdapters.scala 21:31]
  assign io_genericReqIn_ready = io_axiReqOut_ready; // @[AXIMemAdapters.scala 13:25]
  assign io_axiReqOut_valid = io_genericReqIn_valid; // @[AXIMemAdapters.scala 14:22]
  assign io_axiReqOut_bits_addr = io_genericReqIn_bits_addr; // @[AXIMemAdapters.scala 19:15]
  assign io_axiReqOut_bits_len = beats - 8'h1; // @[AXIMemAdapters.scala 22:14]
endmodule
module AXIReadRspAdp(
  output        io_axiReadRspIn_ready,
  input         io_axiReadRspIn_valid,
  input  [63:0] io_axiReadRspIn_bits_data,
  input         io_genericRspOut_ready,
  output        io_genericRspOut_valid,
  output [63:0] io_genericRspOut_bits_readData
);
  assign io_axiReadRspIn_ready = io_genericRspOut_ready; // @[AXIMemAdapters.scala 38:25]
  assign io_genericRspOut_valid = io_axiReadRspIn_valid; // @[AXIMemAdapters.scala 37:26]
  assign io_genericRspOut_bits_readData = io_axiReadRspIn_bits_data; // @[AXIMemAdapters.scala 43:19]
endmodule
module AXIWriteBurstReqAdapter(
  input         clock,
  input         reset,
  output        io_in_writeAddr_ready,
  input         io_in_writeAddr_valid,
  input  [31:0] io_in_writeAddr_bits_addr,
  input  [7:0]  io_in_writeAddr_bits_len,
  input         io_out_writeAddr_ready,
  output        io_out_writeAddr_valid,
  output [31:0] io_out_writeAddr_bits_addr,
  output [7:0]  io_out_writeAddr_bits_len,
  input         io_out_writeData_ready,
  output        io_out_writeData_valid,
  output        io_out_writeData_bits_last
);
`ifdef RANDOMIZE_REG_INIT
  reg [31:0] _RAND_0;
  reg [31:0] _RAND_1;
`endif // RANDOMIZE_REG_INIT
  reg  regState; // @[AXIMemAdapters.scala 155:25]
  reg [7:0] regBeatsLeft; // @[AXIMemAdapters.scala 156:29]
  wire  _T = ~regState; // @[Conditional.scala 37:30]
  wire  _T_1 = io_out_writeAddr_ready & io_out_writeAddr_valid; // @[Decoupled.scala 40:37]
  wire  _GEN_1 = _T_1 | regState; // @[AXIMemAdapters.scala 165:37]
  wire  _T_3 = regBeatsLeft == 8'h0; // @[AXIMemAdapters.scala 172:38]
  wire  _T_4 = io_out_writeData_ready & io_out_writeData_valid; // @[Decoupled.scala 40:37]
  wire [7:0] _T_6 = regBeatsLeft - 8'h1; // @[AXIMemAdapters.scala 180:51]
  wire  _GEN_8 = regState & _T_3; // @[Conditional.scala 39:67]
  assign io_in_writeAddr_ready = _T & io_out_writeAddr_ready; // @[AXIMemAdapters.scala 144:19 AXIMemAdapters.scala 148:25 AXIMemAdapters.scala 162:29]
  assign io_out_writeAddr_valid = _T & io_in_writeAddr_valid; // @[AXIMemAdapters.scala 144:19 AXIMemAdapters.scala 147:26 AXIMemAdapters.scala 161:30]
  assign io_out_writeAddr_bits_addr = io_in_writeAddr_bits_addr; // @[AXIMemAdapters.scala 144:19]
  assign io_out_writeAddr_bits_len = io_in_writeAddr_bits_len; // @[AXIMemAdapters.scala 144:19]
  assign io_out_writeData_valid = 1'h0; // @[AXIMemAdapters.scala 145:19 AXIMemAdapters.scala 149:26 AXIMemAdapters.scala 174:30]
  assign io_out_writeData_bits_last = _T ? 1'h0 : _GEN_8; // @[AXIMemAdapters.scala 145:19 AXIMemAdapters.scala 152:30 AXIMemAdapters.scala 176:34]
`ifdef RANDOMIZE_GARBAGE_ASSIGN
`define RANDOMIZE
`endif
`ifdef RANDOMIZE_INVALID_ASSIGN
`define RANDOMIZE
`endif
`ifdef RANDOMIZE_REG_INIT
`define RANDOMIZE
`endif
`ifdef RANDOMIZE_MEM_INIT
`define RANDOMIZE
`endif
`ifndef RANDOM
`define RANDOM $random
`endif
`ifdef RANDOMIZE_MEM_INIT
  integer initvar;
`endif
`ifndef SYNTHESIS
`ifdef FIRRTL_BEFORE_INITIAL
`FIRRTL_BEFORE_INITIAL
`endif
initial begin
  `ifdef RANDOMIZE
    `ifdef INIT_RANDOM
      `INIT_RANDOM
    `endif
    `ifndef VERILATOR
      `ifdef RANDOMIZE_DELAY
        #`RANDOMIZE_DELAY begin end
      `else
        #0.002 begin end
      `endif
    `endif
`ifdef RANDOMIZE_REG_INIT
  _RAND_0 = {1{`RANDOM}};
  regState = _RAND_0[0:0];
  _RAND_1 = {1{`RANDOM}};
  regBeatsLeft = _RAND_1[7:0];
`endif // RANDOMIZE_REG_INIT
  `endif // RANDOMIZE
end // initial
`ifdef FIRRTL_AFTER_INITIAL
`FIRRTL_AFTER_INITIAL
`endif
`endif // SYNTHESIS
  always @(posedge clock) begin
    if (reset) begin
      regState <= 1'h0;
    end else if (_T) begin
      regState <= _GEN_1;
    end else if (regState) begin
      if (_T_4) begin
        if (_T_3) begin
          regState <= 1'h0;
        end
      end
    end
    if (reset) begin
      regBeatsLeft <= 8'h0;
    end else if (_T) begin
      if (_T_1) begin
        regBeatsLeft <= io_in_writeAddr_bits_len;
      end
    end else if (regState) begin
      if (_T_4) begin
        if (!(_T_3)) begin
          regBeatsLeft <= _T_6;
        end
      end
    end
  end
endmodule
module SRLQueue_1(
  input         clock,
  input         reset,
  output        io_enq_ready,
  input         io_enq_bits_last,
  input         io_deq_ready,
  output        io_deq_valid,
  output [63:0] io_deq_bits_data,
  output [7:0]  io_deq_bits_strb,
  output        io_deq_bits_last
);
  wire  Q_srl_i_v; // @[FPGAQueue.scala 70:20]
  wire [72:0] Q_srl_i_d; // @[FPGAQueue.scala 70:20]
  wire  Q_srl_i_b; // @[FPGAQueue.scala 70:20]
  wire  Q_srl_o_v; // @[FPGAQueue.scala 70:20]
  wire [72:0] Q_srl_o_d; // @[FPGAQueue.scala 70:20]
  wire  Q_srl_o_b; // @[FPGAQueue.scala 70:20]
  wire [1:0] Q_srl_count; // @[FPGAQueue.scala 70:20]
  wire  Q_srl_clock; // @[FPGAQueue.scala 70:20]
  wire  Q_srl_reset; // @[FPGAQueue.scala 70:20]
  wire [72:0] _T_3 = Q_srl_o_d;
  Q_srl #(.depth(2), .width(73)) Q_srl ( // @[FPGAQueue.scala 70:20]
    .i_v(Q_srl_i_v),
    .i_d(Q_srl_i_d),
    .i_b(Q_srl_i_b),
    .o_v(Q_srl_o_v),
    .o_d(Q_srl_o_d),
    .o_b(Q_srl_o_b),
    .count(Q_srl_count),
    .clock(Q_srl_clock),
    .reset(Q_srl_reset)
  );
  assign io_enq_ready = ~Q_srl_i_b; // @[FPGAQueue.scala 83:16]
  assign io_deq_valid = Q_srl_o_v; // @[FPGAQueue.scala 78:16]
  assign io_deq_bits_data = _T_3[72:9]; // @[FPGAQueue.scala 79:15]
  assign io_deq_bits_strb = _T_3[8:1]; // @[FPGAQueue.scala 79:15]
  assign io_deq_bits_last = _T_3[0]; // @[FPGAQueue.scala 79:15]
  assign Q_srl_i_v = 1'h0; // @[FPGAQueue.scala 73:12]
  assign Q_srl_i_d = {72'hff,io_enq_bits_last}; // @[FPGAQueue.scala 74:12]
  assign Q_srl_o_b = ~io_deq_ready; // @[FPGAQueue.scala 82:12]
  assign Q_srl_clock = clock; // @[FPGAQueue.scala 75:14]
  assign Q_srl_reset = reset; // @[FPGAQueue.scala 76:14]
endmodule
module FPGAQueue_1(
  input         clock,
  input         reset,
  output        io_enq_ready,
  input         io_enq_bits_last,
  input         io_deq_ready,
  output        io_deq_valid,
  output [63:0] io_deq_bits_data,
  output [7:0]  io_deq_bits_strb,
  output        io_deq_bits_last
);
  wire  SRLQueue_clock; // @[FPGAQueue.scala 168:26]
  wire  SRLQueue_reset; // @[FPGAQueue.scala 168:26]
  wire  SRLQueue_io_enq_ready; // @[FPGAQueue.scala 168:26]
  wire  SRLQueue_io_enq_bits_last; // @[FPGAQueue.scala 168:26]
  wire  SRLQueue_io_deq_ready; // @[FPGAQueue.scala 168:26]
  wire  SRLQueue_io_deq_valid; // @[FPGAQueue.scala 168:26]
  wire [63:0] SRLQueue_io_deq_bits_data; // @[FPGAQueue.scala 168:26]
  wire [7:0] SRLQueue_io_deq_bits_strb; // @[FPGAQueue.scala 168:26]
  wire  SRLQueue_io_deq_bits_last; // @[FPGAQueue.scala 168:26]
  SRLQueue_1 SRLQueue ( // @[FPGAQueue.scala 168:26]
    .clock(SRLQueue_clock),
    .reset(SRLQueue_reset),
    .io_enq_ready(SRLQueue_io_enq_ready),
    .io_enq_bits_last(SRLQueue_io_enq_bits_last),
    .io_deq_ready(SRLQueue_io_deq_ready),
    .io_deq_valid(SRLQueue_io_deq_valid),
    .io_deq_bits_data(SRLQueue_io_deq_bits_data),
    .io_deq_bits_strb(SRLQueue_io_deq_bits_strb),
    .io_deq_bits_last(SRLQueue_io_deq_bits_last)
  );
  assign io_enq_ready = SRLQueue_io_enq_ready; // @[FPGAQueue.scala 169:14]
  assign io_deq_valid = SRLQueue_io_deq_valid; // @[FPGAQueue.scala 169:14]
  assign io_deq_bits_data = SRLQueue_io_deq_bits_data; // @[FPGAQueue.scala 169:14]
  assign io_deq_bits_strb = SRLQueue_io_deq_bits_strb; // @[FPGAQueue.scala 169:14]
  assign io_deq_bits_last = SRLQueue_io_deq_bits_last; // @[FPGAQueue.scala 169:14]
  assign SRLQueue_clock = clock;
  assign SRLQueue_reset = reset;
  assign SRLQueue_io_enq_bits_last = io_enq_bits_last; // @[FPGAQueue.scala 169:14]
  assign SRLQueue_io_deq_ready = io_deq_ready; // @[FPGAQueue.scala 169:14]
endmodule
module ZedBoardWrapper(
  input         clock,
  input         reset,
  output [31:0] mem0_ARADDR,
  output [2:0]  mem0_ARSIZE,
  output [7:0]  mem0_ARLEN,
  output [1:0]  mem0_ARBURST,
  output [5:0]  mem0_ARID,
  output        mem0_ARLOCK,
  output [3:0]  mem0_ARCACHE,
  output [2:0]  mem0_ARPROT,
  output [3:0]  mem0_ARQOS,
  input         mem0_ARREADY,
  output        mem0_ARVALID,
  output [31:0] mem0_AWADDR,
  output [2:0]  mem0_AWSIZE,
  output [7:0]  mem0_AWLEN,
  output [1:0]  mem0_AWBURST,
  output [5:0]  mem0_AWID,
  output        mem0_AWLOCK,
  output [3:0]  mem0_AWCACHE,
  output [2:0]  mem0_AWPROT,
  output [3:0]  mem0_AWQOS,
  input         mem0_AWREADY,
  output        mem0_AWVALID,
  output [63:0] mem0_WDATA,
  output [7:0]  mem0_WSTRB,
  output        mem0_WLAST,
  output        mem0_WVALID,
  input         mem0_WREADY,
  input  [1:0]  mem0_BRESP,
  input  [5:0]  mem0_BID,
  input         mem0_BVALID,
  output        mem0_BREADY,
  input  [5:0]  mem0_RID,
  input  [63:0] mem0_RDATA,
  input  [1:0]  mem0_RRESP,
  input         mem0_RLAST,
  input         mem0_RVALID,
  output        mem0_RREADY,
  output [31:0] mem1_ARADDR,
  output [2:0]  mem1_ARSIZE,
  output [7:0]  mem1_ARLEN,
  output [1:0]  mem1_ARBURST,
  output [5:0]  mem1_ARID,
  output        mem1_ARLOCK,
  output [3:0]  mem1_ARCACHE,
  output [2:0]  mem1_ARPROT,
  output [3:0]  mem1_ARQOS,
  input         mem1_ARREADY,
  output        mem1_ARVALID,
  output [31:0] mem1_AWADDR,
  output [2:0]  mem1_AWSIZE,
  output [7:0]  mem1_AWLEN,
  output [1:0]  mem1_AWBURST,
  output [5:0]  mem1_AWID,
  output        mem1_AWLOCK,
  output [3:0]  mem1_AWCACHE,
  output [2:0]  mem1_AWPROT,
  output [3:0]  mem1_AWQOS,
  input         mem1_AWREADY,
  output        mem1_AWVALID,
  output [63:0] mem1_WDATA,
  output [7:0]  mem1_WSTRB,
  output        mem1_WLAST,
  output        mem1_WVALID,
  input         mem1_WREADY,
  input  [1:0]  mem1_BRESP,
  input  [5:0]  mem1_BID,
  input         mem1_BVALID,
  output        mem1_BREADY,
  input  [5:0]  mem1_RID,
  input  [63:0] mem1_RDATA,
  input  [1:0]  mem1_RRESP,
  input         mem1_RLAST,
  input         mem1_RVALID,
  output        mem1_RREADY,
  output [31:0] mem2_ARADDR,
  output [2:0]  mem2_ARSIZE,
  output [7:0]  mem2_ARLEN,
  output [1:0]  mem2_ARBURST,
  output [5:0]  mem2_ARID,
  output        mem2_ARLOCK,
  output [3:0]  mem2_ARCACHE,
  output [2:0]  mem2_ARPROT,
  output [3:0]  mem2_ARQOS,
  input         mem2_ARREADY,
  output        mem2_ARVALID,
  output [31:0] mem2_AWADDR,
  output [2:0]  mem2_AWSIZE,
  output [7:0]  mem2_AWLEN,
  output [1:0]  mem2_AWBURST,
  output [5:0]  mem2_AWID,
  output        mem2_AWLOCK,
  output [3:0]  mem2_AWCACHE,
  output [2:0]  mem2_AWPROT,
  output [3:0]  mem2_AWQOS,
  input         mem2_AWREADY,
  output        mem2_AWVALID,
  output [63:0] mem2_WDATA,
  output [7:0]  mem2_WSTRB,
  output        mem2_WLAST,
  output        mem2_WVALID,
  input         mem2_WREADY,
  input  [1:0]  mem2_BRESP,
  input  [5:0]  mem2_BID,
  input         mem2_BVALID,
  output        mem2_BREADY,
  input  [5:0]  mem2_RID,
  input  [63:0] mem2_RDATA,
  input  [1:0]  mem2_RRESP,
  input         mem2_RLAST,
  input         mem2_RVALID,
  output        mem2_RREADY,
  output [31:0] mem3_ARADDR,
  output [2:0]  mem3_ARSIZE,
  output [7:0]  mem3_ARLEN,
  output [1:0]  mem3_ARBURST,
  output [5:0]  mem3_ARID,
  output        mem3_ARLOCK,
  output [3:0]  mem3_ARCACHE,
  output [2:0]  mem3_ARPROT,
  output [3:0]  mem3_ARQOS,
  input         mem3_ARREADY,
  output        mem3_ARVALID,
  output [31:0] mem3_AWADDR,
  output [2:0]  mem3_AWSIZE,
  output [7:0]  mem3_AWLEN,
  output [1:0]  mem3_AWBURST,
  output [5:0]  mem3_AWID,
  output        mem3_AWLOCK,
  output [3:0]  mem3_AWCACHE,
  output [2:0]  mem3_AWPROT,
  output [3:0]  mem3_AWQOS,
  input         mem3_AWREADY,
  output        mem3_AWVALID,
  output [63:0] mem3_WDATA,
  output [7:0]  mem3_WSTRB,
  output        mem3_WLAST,
  output        mem3_WVALID,
  input         mem3_WREADY,
  input  [1:0]  mem3_BRESP,
  input  [5:0]  mem3_BID,
  input         mem3_BVALID,
  output        mem3_BREADY,
  input  [5:0]  mem3_RID,
  input  [63:0] mem3_RDATA,
  input  [1:0]  mem3_RRESP,
  input         mem3_RLAST,
  input         mem3_RVALID,
  output        mem3_RREADY,
  input  [31:0] csr_ARADDR,
  input  [2:0]  csr_ARPROT,
  output        csr_ARREADY,
  input         csr_ARVALID,
  input  [31:0] csr_AWADDR,
  input  [2:0]  csr_AWPROT,
  output        csr_AWREADY,
  input         csr_AWVALID,
  input  [31:0] csr_WDATA,
  input  [3:0]  csr_WSTRB,
  input         csr_WVALID,
  output        csr_WREADY,
  output [1:0]  csr_BRESP,
  output        csr_BVALID,
  input         csr_BREADY,
  output [31:0] csr_RDATA,
  output [1:0]  csr_RRESP,
  output        csr_RVALID,
  input         csr_RREADY
);
`ifdef RANDOMIZE_REG_INIT
  reg [31:0] _RAND_0;
  reg [31:0] _RAND_1;
  reg [31:0] _RAND_2;
  reg [31:0] _RAND_3;
  reg [31:0] _RAND_4;
  reg [31:0] _RAND_5;
  reg [31:0] _RAND_6;
  reg [31:0] _RAND_7;
`endif // RANDOMIZE_REG_INIT
  wire  TestSum_clock; // @[PlatformWrapper.scala 66:21]
  wire  TestSum_reset; // @[PlatformWrapper.scala 66:21]
  wire  TestSum_io_memPort_0_memRdReq_ready; // @[PlatformWrapper.scala 66:21]
  wire  TestSum_io_memPort_0_memRdReq_valid; // @[PlatformWrapper.scala 66:21]
  wire [31:0] TestSum_io_memPort_0_memRdReq_bits_addr; // @[PlatformWrapper.scala 66:21]
  wire  TestSum_io_memPort_0_memRdRsp_ready; // @[PlatformWrapper.scala 66:21]
  wire  TestSum_io_memPort_0_memRdRsp_valid; // @[PlatformWrapper.scala 66:21]
  wire [63:0] TestSum_io_memPort_0_memRdRsp_bits_readData; // @[PlatformWrapper.scala 66:21]
  wire  TestSum_io_start; // @[PlatformWrapper.scala 66:21]
  wire  TestSum_io_finished; // @[PlatformWrapper.scala 66:21]
  wire [63:0] TestSum_io_baseAddr; // @[PlatformWrapper.scala 66:21]
  wire [31:0] TestSum_io_byteCount; // @[PlatformWrapper.scala 66:21]
  wire [31:0] TestSum_io_sum; // @[PlatformWrapper.scala 66:21]
  wire [31:0] TestSum_io_cycleCount; // @[PlatformWrapper.scala 66:21]
  wire  RegFile_clock; // @[PlatformWrapper.scala 97:23]
  wire  RegFile_reset; // @[PlatformWrapper.scala 97:23]
  wire  RegFile_io_extIF_cmd_valid; // @[PlatformWrapper.scala 97:23]
  wire [2:0] RegFile_io_extIF_cmd_bits_regID; // @[PlatformWrapper.scala 97:23]
  wire  RegFile_io_extIF_cmd_bits_read; // @[PlatformWrapper.scala 97:23]
  wire  RegFile_io_extIF_cmd_bits_write; // @[PlatformWrapper.scala 97:23]
  wire [31:0] RegFile_io_extIF_cmd_bits_writeData; // @[PlatformWrapper.scala 97:23]
  wire  RegFile_io_extIF_readData_valid; // @[PlatformWrapper.scala 97:23]
  wire [31:0] RegFile_io_extIF_readData_bits; // @[PlatformWrapper.scala 97:23]
  wire [31:0] RegFile_io_regOut_3; // @[PlatformWrapper.scala 97:23]
  wire [31:0] RegFile_io_regOut_4; // @[PlatformWrapper.scala 97:23]
  wire [31:0] RegFile_io_regOut_5; // @[PlatformWrapper.scala 97:23]
  wire [31:0] RegFile_io_regOut_7; // @[PlatformWrapper.scala 97:23]
  wire [31:0] RegFile_io_regIn_1_bits; // @[PlatformWrapper.scala 97:23]
  wire [31:0] RegFile_io_regIn_2_bits; // @[PlatformWrapper.scala 97:23]
  wire [31:0] RegFile_io_regIn_6_bits; // @[PlatformWrapper.scala 97:23]
  wire  AXIMemReqAdp_io_genericReqIn_ready; // @[AXIPlatformWrapper.scala 38:28]
  wire  AXIMemReqAdp_io_genericReqIn_valid; // @[AXIPlatformWrapper.scala 38:28]
  wire [31:0] AXIMemReqAdp_io_genericReqIn_bits_addr; // @[AXIPlatformWrapper.scala 38:28]
  wire [7:0] AXIMemReqAdp_io_genericReqIn_bits_numBytes; // @[AXIPlatformWrapper.scala 38:28]
  wire  AXIMemReqAdp_io_axiReqOut_ready; // @[AXIPlatformWrapper.scala 38:28]
  wire  AXIMemReqAdp_io_axiReqOut_valid; // @[AXIPlatformWrapper.scala 38:28]
  wire [31:0] AXIMemReqAdp_io_axiReqOut_bits_addr; // @[AXIPlatformWrapper.scala 38:28]
  wire [7:0] AXIMemReqAdp_io_axiReqOut_bits_len; // @[AXIPlatformWrapper.scala 38:28]
  wire  AXIReadRspAdp_io_axiReadRspIn_ready; // @[AXIPlatformWrapper.scala 42:28]
  wire  AXIReadRspAdp_io_axiReadRspIn_valid; // @[AXIPlatformWrapper.scala 42:28]
  wire [63:0] AXIReadRspAdp_io_axiReadRspIn_bits_data; // @[AXIPlatformWrapper.scala 42:28]
  wire  AXIReadRspAdp_io_genericRspOut_ready; // @[AXIPlatformWrapper.scala 42:28]
  wire  AXIReadRspAdp_io_genericRspOut_valid; // @[AXIPlatformWrapper.scala 42:28]
  wire [63:0] AXIReadRspAdp_io_genericRspOut_bits_readData; // @[AXIPlatformWrapper.scala 42:28]
  wire  AXIMemReqAdp_1_io_genericReqIn_ready; // @[AXIPlatformWrapper.scala 46:29]
  wire  AXIMemReqAdp_1_io_genericReqIn_valid; // @[AXIPlatformWrapper.scala 46:29]
  wire [31:0] AXIMemReqAdp_1_io_genericReqIn_bits_addr; // @[AXIPlatformWrapper.scala 46:29]
  wire [7:0] AXIMemReqAdp_1_io_genericReqIn_bits_numBytes; // @[AXIPlatformWrapper.scala 46:29]
  wire  AXIMemReqAdp_1_io_axiReqOut_ready; // @[AXIPlatformWrapper.scala 46:29]
  wire  AXIMemReqAdp_1_io_axiReqOut_valid; // @[AXIPlatformWrapper.scala 46:29]
  wire [31:0] AXIMemReqAdp_1_io_axiReqOut_bits_addr; // @[AXIPlatformWrapper.scala 46:29]
  wire [7:0] AXIMemReqAdp_1_io_axiReqOut_bits_len; // @[AXIPlatformWrapper.scala 46:29]
  wire  AXIWriteBurstReqAdapter_clock; // @[AXIPlatformWrapper.scala 49:31]
  wire  AXIWriteBurstReqAdapter_reset; // @[AXIPlatformWrapper.scala 49:31]
  wire  AXIWriteBurstReqAdapter_io_in_writeAddr_ready; // @[AXIPlatformWrapper.scala 49:31]
  wire  AXIWriteBurstReqAdapter_io_in_writeAddr_valid; // @[AXIPlatformWrapper.scala 49:31]
  wire [31:0] AXIWriteBurstReqAdapter_io_in_writeAddr_bits_addr; // @[AXIPlatformWrapper.scala 49:31]
  wire [7:0] AXIWriteBurstReqAdapter_io_in_writeAddr_bits_len; // @[AXIPlatformWrapper.scala 49:31]
  wire  AXIWriteBurstReqAdapter_io_out_writeAddr_ready; // @[AXIPlatformWrapper.scala 49:31]
  wire  AXIWriteBurstReqAdapter_io_out_writeAddr_valid; // @[AXIPlatformWrapper.scala 49:31]
  wire [31:0] AXIWriteBurstReqAdapter_io_out_writeAddr_bits_addr; // @[AXIPlatformWrapper.scala 49:31]
  wire [7:0] AXIWriteBurstReqAdapter_io_out_writeAddr_bits_len; // @[AXIPlatformWrapper.scala 49:31]
  wire  AXIWriteBurstReqAdapter_io_out_writeData_ready; // @[AXIPlatformWrapper.scala 49:31]
  wire  AXIWriteBurstReqAdapter_io_out_writeData_valid; // @[AXIPlatformWrapper.scala 49:31]
  wire  AXIWriteBurstReqAdapter_io_out_writeData_bits_last; // @[AXIPlatformWrapper.scala 49:31]
  wire  FPGAQueue_clock; // @[FPGAQueue.scala 180:19]
  wire  FPGAQueue_reset; // @[FPGAQueue.scala 180:19]
  wire  FPGAQueue_io_enq_ready; // @[FPGAQueue.scala 180:19]
  wire  FPGAQueue_io_enq_bits_last; // @[FPGAQueue.scala 180:19]
  wire  FPGAQueue_io_deq_ready; // @[FPGAQueue.scala 180:19]
  wire  FPGAQueue_io_deq_valid; // @[FPGAQueue.scala 180:19]
  wire [63:0] FPGAQueue_io_deq_bits_data; // @[FPGAQueue.scala 180:19]
  wire [7:0] FPGAQueue_io_deq_bits_strb; // @[FPGAQueue.scala 180:19]
  wire  FPGAQueue_io_deq_bits_last; // @[FPGAQueue.scala 180:19]
  reg  regWrapperReset; // @[PlatformWrapper.scala 65:32]
  wire  _T_2 = RegFile_io_extIF_cmd_valid & RegFile_io_extIF_cmd_bits_write; // @[PlatformWrapper.scala 101:20]
  wire  _T_3 = RegFile_io_extIF_cmd_bits_regID == 3'h0; // @[PlatformWrapper.scala 101:58]
  wire  _T_4 = _T_2 & _T_3; // @[PlatformWrapper.scala 101:39]
  reg [2:0] regState; // @[AXIPlatformWrapper.scala 94:25]
  reg  regModeWrite; // @[AXIPlatformWrapper.scala 96:29]
  reg  regRdReq; // @[AXIPlatformWrapper.scala 97:25]
  reg [31:0] regRdAddr; // @[AXIPlatformWrapper.scala 98:26]
  reg  regWrReq; // @[AXIPlatformWrapper.scala 99:25]
  reg  regWrAddr; // @[AXIPlatformWrapper.scala 100:26]
  reg [31:0] regWrData; // @[AXIPlatformWrapper.scala 101:26]
  wire  _T_9 = ~regModeWrite; // @[AXIPlatformWrapper.scala 109:8]
  wire [31:0] _T_10 = regRdAddr / 32'h4; // @[AXIPlatformWrapper.scala 112:47]
  wire [2:0] _GEN_59 = {{2'd0}, regWrAddr}; // @[AXIPlatformWrapper.scala 116:47]
  wire  _T_11 = _GEN_59 / 3'h4; // @[AXIPlatformWrapper.scala 116:47]
  wire [31:0] _GEN_3 = _T_9 ? _T_10 : {{31'd0}, _T_11}; // @[AXIPlatformWrapper.scala 109:23]
  wire  csr_1_readAddr_ready = 3'h0 == regState; // @[Conditional.scala 37:30]
  wire  _GEN_6 = csr_ARVALID | regRdReq; // @[AXIPlatformWrapper.scala 124:32]
  wire  _T_13 = 3'h1 == regState; // @[Conditional.scala 37:30]
  wire  _T_14 = csr_RREADY & RegFile_io_extIF_readData_valid; // @[AXIPlatformWrapper.scala 136:32]
  wire  _T_15 = 3'h2 == regState; // @[Conditional.scala 37:30]
  wire  _GEN_12 = csr_AWVALID | regModeWrite; // @[AXIPlatformWrapper.scala 145:33]
  wire [31:0] _GEN_14 = csr_AWVALID ? csr_AWADDR : {{31'd0}, regWrAddr}; // @[AXIPlatformWrapper.scala 145:33]
  wire  _T_16 = 3'h3 == regState; // @[Conditional.scala 37:30]
  wire  _GEN_17 = csr_WVALID | regWrReq; // @[AXIPlatformWrapper.scala 157:33]
  wire  _T_17 = 3'h4 == regState; // @[Conditional.scala 37:30]
  wire  _GEN_28 = _T_16 ? 1'h0 : _T_17; // @[Conditional.scala 39:67]
  wire [31:0] _GEN_32 = _T_15 ? _GEN_14 : {{31'd0}, regWrAddr}; // @[Conditional.scala 39:67]
  wire  _GEN_34 = _T_15 ? 1'h0 : _T_16; // @[Conditional.scala 39:67]
  wire  _GEN_36 = _T_15 ? 1'h0 : _GEN_28; // @[Conditional.scala 39:67]
  wire  _GEN_37 = _T_13 & RegFile_io_extIF_readData_valid; // @[Conditional.scala 39:67]
  wire  _GEN_40 = _T_13 ? 1'h0 : _T_15; // @[Conditional.scala 39:67]
  wire [31:0] _GEN_43 = _T_13 ? {{31'd0}, regWrAddr} : _GEN_32; // @[Conditional.scala 39:67]
  wire  _GEN_44 = _T_13 ? 1'h0 : _GEN_34; // @[Conditional.scala 39:67]
  wire  _GEN_46 = _T_13 ? 1'h0 : _GEN_36; // @[Conditional.scala 39:67]
  wire [31:0] _GEN_55 = csr_1_readAddr_ready ? {{31'd0}, regWrAddr} : _GEN_43; // @[Conditional.scala 40:58]
  TestSum TestSum ( // @[PlatformWrapper.scala 66:21]
    .clock(TestSum_clock),
    .reset(TestSum_reset),
    .io_memPort_0_memRdReq_ready(TestSum_io_memPort_0_memRdReq_ready),
    .io_memPort_0_memRdReq_valid(TestSum_io_memPort_0_memRdReq_valid),
    .io_memPort_0_memRdReq_bits_addr(TestSum_io_memPort_0_memRdReq_bits_addr),
    .io_memPort_0_memRdRsp_ready(TestSum_io_memPort_0_memRdRsp_ready),
    .io_memPort_0_memRdRsp_valid(TestSum_io_memPort_0_memRdRsp_valid),
    .io_memPort_0_memRdRsp_bits_readData(TestSum_io_memPort_0_memRdRsp_bits_readData),
    .io_start(TestSum_io_start),
    .io_finished(TestSum_io_finished),
    .io_baseAddr(TestSum_io_baseAddr),
    .io_byteCount(TestSum_io_byteCount),
    .io_sum(TestSum_io_sum),
    .io_cycleCount(TestSum_io_cycleCount)
  );
  RegFile RegFile ( // @[PlatformWrapper.scala 97:23]
    .clock(RegFile_clock),
    .reset(RegFile_reset),
    .io_extIF_cmd_valid(RegFile_io_extIF_cmd_valid),
    .io_extIF_cmd_bits_regID(RegFile_io_extIF_cmd_bits_regID),
    .io_extIF_cmd_bits_read(RegFile_io_extIF_cmd_bits_read),
    .io_extIF_cmd_bits_write(RegFile_io_extIF_cmd_bits_write),
    .io_extIF_cmd_bits_writeData(RegFile_io_extIF_cmd_bits_writeData),
    .io_extIF_readData_valid(RegFile_io_extIF_readData_valid),
    .io_extIF_readData_bits(RegFile_io_extIF_readData_bits),
    .io_regOut_3(RegFile_io_regOut_3),
    .io_regOut_4(RegFile_io_regOut_4),
    .io_regOut_5(RegFile_io_regOut_5),
    .io_regOut_7(RegFile_io_regOut_7),
    .io_regIn_1_bits(RegFile_io_regIn_1_bits),
    .io_regIn_2_bits(RegFile_io_regIn_2_bits),
    .io_regIn_6_bits(RegFile_io_regIn_6_bits)
  );
  AXIMemReqAdp AXIMemReqAdp ( // @[AXIPlatformWrapper.scala 38:28]
    .io_genericReqIn_ready(AXIMemReqAdp_io_genericReqIn_ready),
    .io_genericReqIn_valid(AXIMemReqAdp_io_genericReqIn_valid),
    .io_genericReqIn_bits_addr(AXIMemReqAdp_io_genericReqIn_bits_addr),
    .io_genericReqIn_bits_numBytes(AXIMemReqAdp_io_genericReqIn_bits_numBytes),
    .io_axiReqOut_ready(AXIMemReqAdp_io_axiReqOut_ready),
    .io_axiReqOut_valid(AXIMemReqAdp_io_axiReqOut_valid),
    .io_axiReqOut_bits_addr(AXIMemReqAdp_io_axiReqOut_bits_addr),
    .io_axiReqOut_bits_len(AXIMemReqAdp_io_axiReqOut_bits_len)
  );
  AXIReadRspAdp AXIReadRspAdp ( // @[AXIPlatformWrapper.scala 42:28]
    .io_axiReadRspIn_ready(AXIReadRspAdp_io_axiReadRspIn_ready),
    .io_axiReadRspIn_valid(AXIReadRspAdp_io_axiReadRspIn_valid),
    .io_axiReadRspIn_bits_data(AXIReadRspAdp_io_axiReadRspIn_bits_data),
    .io_genericRspOut_ready(AXIReadRspAdp_io_genericRspOut_ready),
    .io_genericRspOut_valid(AXIReadRspAdp_io_genericRspOut_valid),
    .io_genericRspOut_bits_readData(AXIReadRspAdp_io_genericRspOut_bits_readData)
  );
  AXIMemReqAdp AXIMemReqAdp_1 ( // @[AXIPlatformWrapper.scala 46:29]
    .io_genericReqIn_ready(AXIMemReqAdp_1_io_genericReqIn_ready),
    .io_genericReqIn_valid(AXIMemReqAdp_1_io_genericReqIn_valid),
    .io_genericReqIn_bits_addr(AXIMemReqAdp_1_io_genericReqIn_bits_addr),
    .io_genericReqIn_bits_numBytes(AXIMemReqAdp_1_io_genericReqIn_bits_numBytes),
    .io_axiReqOut_ready(AXIMemReqAdp_1_io_axiReqOut_ready),
    .io_axiReqOut_valid(AXIMemReqAdp_1_io_axiReqOut_valid),
    .io_axiReqOut_bits_addr(AXIMemReqAdp_1_io_axiReqOut_bits_addr),
    .io_axiReqOut_bits_len(AXIMemReqAdp_1_io_axiReqOut_bits_len)
  );
  AXIWriteBurstReqAdapter AXIWriteBurstReqAdapter ( // @[AXIPlatformWrapper.scala 49:31]
    .clock(AXIWriteBurstReqAdapter_clock),
    .reset(AXIWriteBurstReqAdapter_reset),
    .io_in_writeAddr_ready(AXIWriteBurstReqAdapter_io_in_writeAddr_ready),
    .io_in_writeAddr_valid(AXIWriteBurstReqAdapter_io_in_writeAddr_valid),
    .io_in_writeAddr_bits_addr(AXIWriteBurstReqAdapter_io_in_writeAddr_bits_addr),
    .io_in_writeAddr_bits_len(AXIWriteBurstReqAdapter_io_in_writeAddr_bits_len),
    .io_out_writeAddr_ready(AXIWriteBurstReqAdapter_io_out_writeAddr_ready),
    .io_out_writeAddr_valid(AXIWriteBurstReqAdapter_io_out_writeAddr_valid),
    .io_out_writeAddr_bits_addr(AXIWriteBurstReqAdapter_io_out_writeAddr_bits_addr),
    .io_out_writeAddr_bits_len(AXIWriteBurstReqAdapter_io_out_writeAddr_bits_len),
    .io_out_writeData_ready(AXIWriteBurstReqAdapter_io_out_writeData_ready),
    .io_out_writeData_valid(AXIWriteBurstReqAdapter_io_out_writeData_valid),
    .io_out_writeData_bits_last(AXIWriteBurstReqAdapter_io_out_writeData_bits_last)
  );
  FPGAQueue_1 FPGAQueue ( // @[FPGAQueue.scala 180:19]
    .clock(FPGAQueue_clock),
    .reset(FPGAQueue_reset),
    .io_enq_ready(FPGAQueue_io_enq_ready),
    .io_enq_bits_last(FPGAQueue_io_enq_bits_last),
    .io_deq_ready(FPGAQueue_io_deq_ready),
    .io_deq_valid(FPGAQueue_io_deq_valid),
    .io_deq_bits_data(FPGAQueue_io_deq_bits_data),
    .io_deq_bits_strb(FPGAQueue_io_deq_bits_strb),
    .io_deq_bits_last(FPGAQueue_io_deq_bits_last)
  );
  assign mem0_ARADDR = AXIMemReqAdp_io_axiReqOut_bits_addr; // @[AXIPlatformWrapper.scala 21:25]
  assign mem0_ARSIZE = 3'h3; // @[AXIPlatformWrapper.scala 21:25]
  assign mem0_ARLEN = AXIMemReqAdp_io_axiReqOut_bits_len; // @[AXIPlatformWrapper.scala 21:25]
  assign mem0_ARBURST = 2'h1; // @[AXIPlatformWrapper.scala 21:25]
  assign mem0_ARID = 6'h0; // @[AXIPlatformWrapper.scala 21:25]
  assign mem0_ARLOCK = 1'h0; // @[AXIPlatformWrapper.scala 21:25]
  assign mem0_ARCACHE = 4'h2; // @[AXIPlatformWrapper.scala 21:25]
  assign mem0_ARPROT = 3'h0; // @[AXIPlatformWrapper.scala 21:25]
  assign mem0_ARQOS = 4'h0; // @[AXIPlatformWrapper.scala 21:25]
  assign mem0_ARVALID = AXIMemReqAdp_io_axiReqOut_valid; // @[AXIPlatformWrapper.scala 21:25]
  assign mem0_AWADDR = AXIWriteBurstReqAdapter_io_out_writeAddr_bits_addr; // @[AXIPlatformWrapper.scala 21:25]
  assign mem0_AWSIZE = 3'h3; // @[AXIPlatformWrapper.scala 21:25]
  assign mem0_AWLEN = AXIWriteBurstReqAdapter_io_out_writeAddr_bits_len; // @[AXIPlatformWrapper.scala 21:25]
  assign mem0_AWBURST = 2'h1; // @[AXIPlatformWrapper.scala 21:25]
  assign mem0_AWID = 6'h0; // @[AXIPlatformWrapper.scala 21:25]
  assign mem0_AWLOCK = 1'h0; // @[AXIPlatformWrapper.scala 21:25]
  assign mem0_AWCACHE = 4'h2; // @[AXIPlatformWrapper.scala 21:25]
  assign mem0_AWPROT = 3'h0; // @[AXIPlatformWrapper.scala 21:25]
  assign mem0_AWQOS = 4'h0; // @[AXIPlatformWrapper.scala 21:25]
  assign mem0_AWVALID = AXIWriteBurstReqAdapter_io_out_writeAddr_valid; // @[AXIPlatformWrapper.scala 21:25]
  assign mem0_WDATA = FPGAQueue_io_deq_bits_data; // @[AXIPlatformWrapper.scala 21:25]
  assign mem0_WSTRB = FPGAQueue_io_deq_bits_strb; // @[AXIPlatformWrapper.scala 21:25]
  assign mem0_WLAST = FPGAQueue_io_deq_bits_last; // @[AXIPlatformWrapper.scala 21:25]
  assign mem0_WVALID = FPGAQueue_io_deq_valid; // @[AXIPlatformWrapper.scala 21:25]
  assign mem0_BREADY = 1'h0; // @[AXIPlatformWrapper.scala 21:25]
  assign mem0_RREADY = AXIReadRspAdp_io_axiReadRspIn_ready; // @[AXIPlatformWrapper.scala 21:25]
  assign mem1_ARADDR = 32'h0; // @[AXIPlatformWrapper.scala 21:25]
  assign mem1_ARSIZE = 3'h0; // @[AXIPlatformWrapper.scala 21:25]
  assign mem1_ARLEN = 8'h0; // @[AXIPlatformWrapper.scala 21:25]
  assign mem1_ARBURST = 2'h0; // @[AXIPlatformWrapper.scala 21:25]
  assign mem1_ARID = 6'h0; // @[AXIPlatformWrapper.scala 21:25]
  assign mem1_ARLOCK = 1'h0; // @[AXIPlatformWrapper.scala 21:25]
  assign mem1_ARCACHE = 4'h0; // @[AXIPlatformWrapper.scala 21:25]
  assign mem1_ARPROT = 3'h0; // @[AXIPlatformWrapper.scala 21:25]
  assign mem1_ARQOS = 4'h0; // @[AXIPlatformWrapper.scala 21:25]
  assign mem1_ARVALID = 1'h0; // @[AXIPlatformWrapper.scala 21:25]
  assign mem1_AWADDR = 32'h0; // @[AXIPlatformWrapper.scala 21:25]
  assign mem1_AWSIZE = 3'h0; // @[AXIPlatformWrapper.scala 21:25]
  assign mem1_AWLEN = 8'h0; // @[AXIPlatformWrapper.scala 21:25]
  assign mem1_AWBURST = 2'h0; // @[AXIPlatformWrapper.scala 21:25]
  assign mem1_AWID = 6'h0; // @[AXIPlatformWrapper.scala 21:25]
  assign mem1_AWLOCK = 1'h0; // @[AXIPlatformWrapper.scala 21:25]
  assign mem1_AWCACHE = 4'h0; // @[AXIPlatformWrapper.scala 21:25]
  assign mem1_AWPROT = 3'h0; // @[AXIPlatformWrapper.scala 21:25]
  assign mem1_AWQOS = 4'h0; // @[AXIPlatformWrapper.scala 21:25]
  assign mem1_AWVALID = 1'h0; // @[AXIPlatformWrapper.scala 21:25]
  assign mem1_WDATA = 64'h0; // @[AXIPlatformWrapper.scala 21:25]
  assign mem1_WSTRB = 8'h0; // @[AXIPlatformWrapper.scala 21:25]
  assign mem1_WLAST = 1'h0; // @[AXIPlatformWrapper.scala 21:25]
  assign mem1_WVALID = 1'h0; // @[AXIPlatformWrapper.scala 21:25]
  assign mem1_BREADY = 1'h0; // @[AXIPlatformWrapper.scala 21:25]
  assign mem1_RREADY = 1'h0; // @[AXIPlatformWrapper.scala 21:25]
  assign mem2_ARADDR = 32'h0; // @[AXIPlatformWrapper.scala 21:25]
  assign mem2_ARSIZE = 3'h0; // @[AXIPlatformWrapper.scala 21:25]
  assign mem2_ARLEN = 8'h0; // @[AXIPlatformWrapper.scala 21:25]
  assign mem2_ARBURST = 2'h0; // @[AXIPlatformWrapper.scala 21:25]
  assign mem2_ARID = 6'h0; // @[AXIPlatformWrapper.scala 21:25]
  assign mem2_ARLOCK = 1'h0; // @[AXIPlatformWrapper.scala 21:25]
  assign mem2_ARCACHE = 4'h0; // @[AXIPlatformWrapper.scala 21:25]
  assign mem2_ARPROT = 3'h0; // @[AXIPlatformWrapper.scala 21:25]
  assign mem2_ARQOS = 4'h0; // @[AXIPlatformWrapper.scala 21:25]
  assign mem2_ARVALID = 1'h0; // @[AXIPlatformWrapper.scala 21:25]
  assign mem2_AWADDR = 32'h0; // @[AXIPlatformWrapper.scala 21:25]
  assign mem2_AWSIZE = 3'h0; // @[AXIPlatformWrapper.scala 21:25]
  assign mem2_AWLEN = 8'h0; // @[AXIPlatformWrapper.scala 21:25]
  assign mem2_AWBURST = 2'h0; // @[AXIPlatformWrapper.scala 21:25]
  assign mem2_AWID = 6'h0; // @[AXIPlatformWrapper.scala 21:25]
  assign mem2_AWLOCK = 1'h0; // @[AXIPlatformWrapper.scala 21:25]
  assign mem2_AWCACHE = 4'h0; // @[AXIPlatformWrapper.scala 21:25]
  assign mem2_AWPROT = 3'h0; // @[AXIPlatformWrapper.scala 21:25]
  assign mem2_AWQOS = 4'h0; // @[AXIPlatformWrapper.scala 21:25]
  assign mem2_AWVALID = 1'h0; // @[AXIPlatformWrapper.scala 21:25]
  assign mem2_WDATA = 64'h0; // @[AXIPlatformWrapper.scala 21:25]
  assign mem2_WSTRB = 8'h0; // @[AXIPlatformWrapper.scala 21:25]
  assign mem2_WLAST = 1'h0; // @[AXIPlatformWrapper.scala 21:25]
  assign mem2_WVALID = 1'h0; // @[AXIPlatformWrapper.scala 21:25]
  assign mem2_BREADY = 1'h0; // @[AXIPlatformWrapper.scala 21:25]
  assign mem2_RREADY = 1'h0; // @[AXIPlatformWrapper.scala 21:25]
  assign mem3_ARADDR = 32'h0; // @[AXIPlatformWrapper.scala 21:25]
  assign mem3_ARSIZE = 3'h0; // @[AXIPlatformWrapper.scala 21:25]
  assign mem3_ARLEN = 8'h0; // @[AXIPlatformWrapper.scala 21:25]
  assign mem3_ARBURST = 2'h0; // @[AXIPlatformWrapper.scala 21:25]
  assign mem3_ARID = 6'h0; // @[AXIPlatformWrapper.scala 21:25]
  assign mem3_ARLOCK = 1'h0; // @[AXIPlatformWrapper.scala 21:25]
  assign mem3_ARCACHE = 4'h0; // @[AXIPlatformWrapper.scala 21:25]
  assign mem3_ARPROT = 3'h0; // @[AXIPlatformWrapper.scala 21:25]
  assign mem3_ARQOS = 4'h0; // @[AXIPlatformWrapper.scala 21:25]
  assign mem3_ARVALID = 1'h0; // @[AXIPlatformWrapper.scala 21:25]
  assign mem3_AWADDR = 32'h0; // @[AXIPlatformWrapper.scala 21:25]
  assign mem3_AWSIZE = 3'h0; // @[AXIPlatformWrapper.scala 21:25]
  assign mem3_AWLEN = 8'h0; // @[AXIPlatformWrapper.scala 21:25]
  assign mem3_AWBURST = 2'h0; // @[AXIPlatformWrapper.scala 21:25]
  assign mem3_AWID = 6'h0; // @[AXIPlatformWrapper.scala 21:25]
  assign mem3_AWLOCK = 1'h0; // @[AXIPlatformWrapper.scala 21:25]
  assign mem3_AWCACHE = 4'h0; // @[AXIPlatformWrapper.scala 21:25]
  assign mem3_AWPROT = 3'h0; // @[AXIPlatformWrapper.scala 21:25]
  assign mem3_AWQOS = 4'h0; // @[AXIPlatformWrapper.scala 21:25]
  assign mem3_AWVALID = 1'h0; // @[AXIPlatformWrapper.scala 21:25]
  assign mem3_WDATA = 64'h0; // @[AXIPlatformWrapper.scala 21:25]
  assign mem3_WSTRB = 8'h0; // @[AXIPlatformWrapper.scala 21:25]
  assign mem3_WLAST = 1'h0; // @[AXIPlatformWrapper.scala 21:25]
  assign mem3_WVALID = 1'h0; // @[AXIPlatformWrapper.scala 21:25]
  assign mem3_BREADY = 1'h0; // @[AXIPlatformWrapper.scala 21:25]
  assign mem3_RREADY = 1'h0; // @[AXIPlatformWrapper.scala 21:25]
  assign csr_ARREADY = 3'h0 == regState; // @[AXILiteDefs.scala 78:13]
  assign csr_AWREADY = csr_1_readAddr_ready ? 1'h0 : _GEN_40; // @[AXILiteDefs.scala 72:13]
  assign csr_WREADY = csr_1_readAddr_ready ? 1'h0 : _GEN_44; // @[AXILiteDefs.scala 84:12]
  assign csr_BRESP = 2'h0; // @[AXILiteDefs.scala 89:11]
  assign csr_BVALID = csr_1_readAddr_ready ? 1'h0 : _GEN_46; // @[AXILiteDefs.scala 87:12]
  assign csr_RDATA = RegFile_io_extIF_readData_bits; // @[AXILiteDefs.scala 94:11]
  assign csr_RRESP = 2'h0; // @[AXILiteDefs.scala 95:11]
  assign csr_RVALID = csr_1_readAddr_ready ? 1'h0 : _GEN_37; // @[AXILiteDefs.scala 93:12]
  assign TestSum_clock = clock;
  assign TestSum_reset = reset | regWrapperReset; // @[PlatformWrapper.scala 69:15]
  assign TestSum_io_memPort_0_memRdReq_ready = AXIMemReqAdp_io_genericReqIn_ready; // @[AXIPlatformWrapper.scala 39:29]
  assign TestSum_io_memPort_0_memRdRsp_valid = AXIReadRspAdp_io_genericRspOut_valid; // @[AXIPlatformWrapper.scala 44:30]
  assign TestSum_io_memPort_0_memRdRsp_bits_readData = AXIReadRspAdp_io_genericRspOut_bits_readData; // @[AXIPlatformWrapper.scala 44:30]
  assign TestSum_io_start = RegFile_io_regOut_7[0]; // @[PlatformWrapper.scala 152:18]
  assign TestSum_io_baseAddr = {RegFile_io_regOut_4,RegFile_io_regOut_5}; // @[PlatformWrapper.scala 130:16]
  assign TestSum_io_byteCount = RegFile_io_regOut_3; // @[PlatformWrapper.scala 154:25]
  assign RegFile_clock = clock;
  assign RegFile_reset = reset;
  assign RegFile_io_extIF_cmd_valid = _T_9 ? regRdReq : regWrReq; // @[AXIPlatformWrapper.scala 90:27 AXIPlatformWrapper.scala 110:29 AXIPlatformWrapper.scala 114:29]
  assign RegFile_io_extIF_cmd_bits_regID = _GEN_3[2:0]; // @[RegFile.scala 16:11 AXIPlatformWrapper.scala 112:34 AXIPlatformWrapper.scala 116:34]
  assign RegFile_io_extIF_cmd_bits_read = ~regModeWrite; // @[RegFile.scala 17:10 AXIPlatformWrapper.scala 111:33]
  assign RegFile_io_extIF_cmd_bits_write = _T_9 ? 1'h0 : 1'h1; // @[RegFile.scala 18:11 AXIPlatformWrapper.scala 115:34]
  assign RegFile_io_extIF_cmd_bits_writeData = _T_9 ? 32'h0 : regWrData; // @[RegFile.scala 19:15 AXIPlatformWrapper.scala 117:38]
  assign RegFile_io_regIn_1_bits = TestSum_io_cycleCount; // @[PlatformWrapper.scala 162:40]
  assign RegFile_io_regIn_2_bits = TestSum_io_sum; // @[PlatformWrapper.scala 162:40]
  assign RegFile_io_regIn_6_bits = {{31'd0}, TestSum_io_finished}; // @[PlatformWrapper.scala 162:40]
  assign AXIMemReqAdp_io_genericReqIn_valid = TestSum_io_memPort_0_memRdReq_valid; // @[AXIPlatformWrapper.scala 39:29]
  assign AXIMemReqAdp_io_genericReqIn_bits_addr = TestSum_io_memPort_0_memRdReq_bits_addr; // @[AXIPlatformWrapper.scala 39:29]
  assign AXIMemReqAdp_io_genericReqIn_bits_numBytes = 8'h8; // @[AXIPlatformWrapper.scala 39:29]
  assign AXIMemReqAdp_io_axiReqOut_ready = mem0_ARREADY; // @[AXIPlatformWrapper.scala 40:26]
  assign AXIReadRspAdp_io_axiReadRspIn_valid = mem0_RVALID; // @[AXIPlatformWrapper.scala 43:29]
  assign AXIReadRspAdp_io_axiReadRspIn_bits_data = mem0_RDATA; // @[AXIPlatformWrapper.scala 43:29]
  assign AXIReadRspAdp_io_genericRspOut_ready = TestSum_io_memPort_0_memRdRsp_ready; // @[AXIPlatformWrapper.scala 44:30]
  assign AXIMemReqAdp_1_io_genericReqIn_valid = 1'h0; // @[AXIPlatformWrapper.scala 47:30]
  assign AXIMemReqAdp_1_io_genericReqIn_bits_addr = 32'h0; // @[AXIPlatformWrapper.scala 47:30]
  assign AXIMemReqAdp_1_io_genericReqIn_bits_numBytes = 8'h0; // @[AXIPlatformWrapper.scala 47:30]
  assign AXIMemReqAdp_1_io_axiReqOut_ready = AXIWriteBurstReqAdapter_io_in_writeAddr_ready; // @[AXIPlatformWrapper.scala 52:27]
  assign AXIWriteBurstReqAdapter_clock = clock;
  assign AXIWriteBurstReqAdapter_reset = reset;
  assign AXIWriteBurstReqAdapter_io_in_writeAddr_valid = AXIMemReqAdp_1_io_axiReqOut_valid; // @[AXIPlatformWrapper.scala 52:27]
  assign AXIWriteBurstReqAdapter_io_in_writeAddr_bits_addr = AXIMemReqAdp_1_io_axiReqOut_bits_addr; // @[AXIPlatformWrapper.scala 52:27]
  assign AXIWriteBurstReqAdapter_io_in_writeAddr_bits_len = AXIMemReqAdp_1_io_axiReqOut_bits_len; // @[AXIPlatformWrapper.scala 52:27]
  assign AXIWriteBurstReqAdapter_io_out_writeAddr_ready = mem0_AWREADY; // @[AXIPlatformWrapper.scala 60:33]
  assign AXIWriteBurstReqAdapter_io_out_writeData_ready = FPGAQueue_io_enq_ready; // @[FPGAQueue.scala 183:15]
  assign FPGAQueue_clock = clock;
  assign FPGAQueue_reset = reset;
  assign FPGAQueue_io_enq_bits_last = AXIWriteBurstReqAdapter_io_out_writeData_bits_last; // @[FPGAQueue.scala 182:19]
  assign FPGAQueue_io_deq_ready = mem0_WREADY; // @[AXIPlatformWrapper.scala 63:47]
`ifdef RANDOMIZE_GARBAGE_ASSIGN
`define RANDOMIZE
`endif
`ifdef RANDOMIZE_INVALID_ASSIGN
`define RANDOMIZE
`endif
`ifdef RANDOMIZE_REG_INIT
`define RANDOMIZE
`endif
`ifdef RANDOMIZE_MEM_INIT
`define RANDOMIZE
`endif
`ifndef RANDOM
`define RANDOM $random
`endif
`ifdef RANDOMIZE_MEM_INIT
  integer initvar;
`endif
`ifndef SYNTHESIS
`ifdef FIRRTL_BEFORE_INITIAL
`FIRRTL_BEFORE_INITIAL
`endif
initial begin
  `ifdef RANDOMIZE
    `ifdef INIT_RANDOM
      `INIT_RANDOM
    `endif
    `ifndef VERILATOR
      `ifdef RANDOMIZE_DELAY
        #`RANDOMIZE_DELAY begin end
      `else
        #0.002 begin end
      `endif
    `endif
`ifdef RANDOMIZE_REG_INIT
  _RAND_0 = {1{`RANDOM}};
  regWrapperReset = _RAND_0[0:0];
  _RAND_1 = {1{`RANDOM}};
  regState = _RAND_1[2:0];
  _RAND_2 = {1{`RANDOM}};
  regModeWrite = _RAND_2[0:0];
  _RAND_3 = {1{`RANDOM}};
  regRdReq = _RAND_3[0:0];
  _RAND_4 = {1{`RANDOM}};
  regRdAddr = _RAND_4[31:0];
  _RAND_5 = {1{`RANDOM}};
  regWrReq = _RAND_5[0:0];
  _RAND_6 = {1{`RANDOM}};
  regWrAddr = _RAND_6[0:0];
  _RAND_7 = {1{`RANDOM}};
  regWrData = _RAND_7[31:0];
`endif // RANDOMIZE_REG_INIT
  `endif // RANDOMIZE
end // initial
`ifdef FIRRTL_AFTER_INITIAL
`FIRRTL_AFTER_INITIAL
`endif
`endif // SYNTHESIS
  always @(posedge clock) begin
    if (reset) begin
      regWrapperReset <= 1'h0;
    end else if (_T_4) begin
      regWrapperReset <= RegFile_io_extIF_cmd_bits_writeData[0];
    end
    if (reset) begin
      regState <= 3'h0;
    end else if (csr_1_readAddr_ready) begin
      if (csr_ARVALID) begin
        regState <= 3'h1;
      end else begin
        regState <= 3'h2;
      end
    end else if (_T_13) begin
      if (_T_14) begin
        regState <= 3'h2;
      end
    end else if (_T_15) begin
      if (csr_AWVALID) begin
        regState <= 3'h3;
      end else begin
        regState <= 3'h0;
      end
    end else if (_T_16) begin
      if (csr_WVALID) begin
        regState <= 3'h4;
      end
    end else if (_T_17) begin
      if (csr_BREADY) begin
        regState <= 3'h0;
      end
    end
    if (reset) begin
      regModeWrite <= 1'h0;
    end else if (csr_1_readAddr_ready) begin
      if (csr_ARVALID) begin
        regModeWrite <= 1'h0;
      end
    end else if (!(_T_13)) begin
      if (_T_15) begin
        regModeWrite <= _GEN_12;
      end
    end
    if (reset) begin
      regRdReq <= 1'h0;
    end else if (csr_1_readAddr_ready) begin
      regRdReq <= _GEN_6;
    end else if (_T_13) begin
      if (_T_14) begin
        regRdReq <= 1'h0;
      end
    end
    if (reset) begin
      regRdAddr <= 32'h0;
    end else if (csr_1_readAddr_ready) begin
      if (csr_ARVALID) begin
        regRdAddr <= csr_ARADDR;
      end
    end
    if (reset) begin
      regWrReq <= 1'h0;
    end else if (!(csr_1_readAddr_ready)) begin
      if (!(_T_13)) begin
        if (_T_15) begin
          if (csr_AWVALID) begin
            regWrReq <= 1'h0;
          end
        end else if (_T_16) begin
          regWrReq <= _GEN_17;
        end else if (_T_17) begin
          if (csr_BREADY) begin
            regWrReq <= 1'h0;
          end
        end
      end
    end
    if (reset) begin
      regWrAddr <= 1'h0;
    end else begin
      regWrAddr <= _GEN_55[0];
    end
    if (reset) begin
      regWrData <= 32'h0;
    end else if (!(csr_1_readAddr_ready)) begin
      if (!(_T_13)) begin
        if (!(_T_15)) begin
          if (_T_16) begin
            if (csr_WVALID) begin
              regWrData <= csr_WDATA;
            end
          end
        end
      end
    end
  end
endmodule
