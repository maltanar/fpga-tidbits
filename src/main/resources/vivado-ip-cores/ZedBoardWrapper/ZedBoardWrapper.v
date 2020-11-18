module ReadReqGen(input clk, input reset,
    input  io_ctrl_start,
    input  io_ctrl_throttle,
    input [31:0] io_ctrl_baseAddr,
    input [31:0] io_ctrl_byteCount,
    output io_stat_finished,
    output io_stat_active,
    output io_stat_error,
    input  io_reqs_ready,
    output io_reqs_valid,
    output[5:0] io_reqs_bits_channelID,
    output io_reqs_bits_isWrite,
    output[31:0] io_reqs_bits_addr,
    output[7:0] io_reqs_bits_numBytes,
    output io_reqs_bits_metaData
);

  wire T0;
  wire T1;
  wire T2;
  reg [1:0] regState;
  wire[1:0] T37;
  wire[1:0] T3;
  wire[1:0] T4;
  wire[1:0] T5;
  wire[1:0] T6;
  wire isUnaligned;
  wire unalignedAddr;
  wire[2:0] T7;
  wire unalignedSize;
  wire[2:0] T8;
  wire T9;
  wire T10;
  wire T11;
  wire T12;
  reg [31:0] regBytesLeft;
  wire[31:0] T38;
  wire[31:0] T13;
  wire[31:0] T14;
  wire[31:0] T15;
  wire T16;
  wire T17;
  wire T18;
  wire T19;
  wire T20;
  wire T21;
  wire T22;
  wire T23;
  wire T24;
  wire T25;
  wire T26;
  wire[215:0] T27;
  wire T28;
  wire T29;
  wire[31:0] T30;
  wire[31:0] T31;
  reg [31:0] regAddr;
  wire[31:0] T39;
  wire[31:0] T32;
  wire[31:0] T33;
  wire[31:0] T34;
  wire[503:0] T35;
  wire T36;

`ifndef SYNTHESIS
// synthesis translate_off
  integer initvar;
  initial begin
    #0.002;
    regState = {1{$random}};
    regBytesLeft = {1{$random}};
    regAddr = {1{$random}};
  end
// synthesis translate_on
`endif

  assign T0 = T2 & T1;
  assign T1 = reset ^ 1'h1;
  assign T2 = 2'h3 == regState;
  assign T37 = reset ? 2'h0 : T3;
  assign T3 = T22 ? 2'h0 : T4;
  assign T4 = T11 ? 2'h2 : T5;
  assign T5 = T9 ? T6 : regState;
  assign T6 = isUnaligned ? 2'h3 : 2'h1;
  assign isUnaligned = unalignedSize | unalignedAddr;
  assign unalignedAddr = T7 != 3'h0;
  assign T7 = io_ctrl_baseAddr[2:0];
  assign unalignedSize = T8 != 3'h0;
  assign T8 = io_ctrl_byteCount[2:0];
  assign T9 = T10 & io_ctrl_start;
  assign T10 = 2'h0 == regState;
  assign T11 = T21 & T12;
  assign T12 = regBytesLeft == 32'h0;
  assign T38 = reset ? 32'h0 : T13;
  assign T13 = T16 ? T15 : T14;
  assign T14 = T10 ? io_ctrl_byteCount : regBytesLeft;
  assign T15 = regBytesLeft - 32'h8;
  assign T16 = T17 & io_reqs_ready;
  assign T17 = T21 & T18;
  assign T18 = T20 & T19;
  assign T19 = io_ctrl_throttle ^ 1'h1;
  assign T20 = T12 ^ 1'h1;
  assign T21 = 2'h1 == regState;
  assign T22 = T24 & T23;
  assign T23 = io_ctrl_start ^ 1'h1;
  assign T24 = 2'h2 == regState;
  assign T25 = unalignedSize;
  assign T26 = unalignedAddr;
  assign T28 = T2 & T29;
  assign T29 = reset ^ 1'h1;
  assign T30 = io_ctrl_byteCount;
  assign T31 = regAddr;
  assign T39 = reset ? 32'h0 : T32;
  assign T32 = T16 ? T34 : T33;
  assign T33 = T10 ? io_ctrl_baseAddr : regAddr;
  assign T34 = regAddr + 32'h8;
  assign io_reqs_bits_metaData = 1'h0;
  assign io_reqs_bits_numBytes = 8'h8;
  assign io_reqs_bits_addr = regAddr;
  assign io_reqs_bits_isWrite = 1'h0;
  assign io_reqs_bits_channelID = 6'h0;
  assign io_reqs_valid = T17;
  assign io_stat_error = T2;
  assign io_stat_active = T36;
  assign T36 = regState != 2'h0;
  assign io_stat_finished = T24;

  always @(posedge clk) begin
    if(reset) begin
      regState <= 2'h0;
    end else if(T22) begin
      regState <= 2'h0;
    end else if(T11) begin
      regState <= 2'h2;
    end else if(T9) begin
      regState <= T6;
    end
    if(reset) begin
      regBytesLeft <= 32'h0;
    end else if(T16) begin
      regBytesLeft <= T15;
    end else if(T10) begin
      regBytesLeft <= io_ctrl_byteCount;
    end
    if(reset) begin
      regAddr <= 32'h0;
    end else if(T16) begin
      regAddr <= T34;
    end else if(T10) begin
      regAddr <= io_ctrl_baseAddr;
    end
`ifndef SYNTHESIS
// synthesis translate_off
`ifdef PRINTF_COND
    if (`PRINTF_COND)
`endif
      if (T28)
        $fwrite(32'h80000002, "Error in MemReqGen! regAddr = %h byteCount = %d \n", T31, T30);
// synthesis translate_on
`endif
`ifndef SYNTHESIS
// synthesis translate_off
`ifdef PRINTF_COND
    if (`PRINTF_COND)
`endif
      if (T0)
        $fwrite(32'h80000002, "Unaligned addr? %d size? %d \n", T26, T25);
// synthesis translate_on
`endif
  end
endmodule

module SRLQueue_1(input clk, input reset,
    output io_enq_ready,
    input  io_enq_valid,
    input [31:0] io_enq_bits,
    input  io_deq_ready,
    output io_deq_valid,
    output[31:0] io_deq_bits,
    output[3:0] io_count
);

  wire T0;
  wire T1;
  wire Q_srl_i_b;
  wire Q_srl_o_v;
  wire[31:0] Q_srl_o_d;
  wire[3:0] Q_srl_count;


  assign T0 = io_deq_ready ^ 1'h1;
  assign io_count = Q_srl_count;
  assign io_deq_bits = Q_srl_o_d;
  assign io_deq_valid = Q_srl_o_v;
  assign io_enq_ready = T1;
  assign T1 = Q_srl_i_b ^ 1'h1;
  Q_srl # (
    .depth(8),
    .width(32)
  ) Q_srl(.clock(clk), .reset(reset),
       .i_v( io_enq_valid ),
       .i_d( io_enq_bits ),
       .i_b( Q_srl_i_b ),
       .o_v( Q_srl_o_v ),
       .o_d( Q_srl_o_d ),
       .o_b( T0 ),
       .count( Q_srl_count )
  );
endmodule

module FPGAQueue_1(input clk, input reset,
    output io_enq_ready,
    input  io_enq_valid,
    input [31:0] io_enq_bits,
    input  io_deq_ready,
    output io_deq_valid,
    output[31:0] io_deq_bits,
    output[3:0] io_count
);

  wire SRLQueue_io_enq_ready;
  wire SRLQueue_io_deq_valid;
  wire[31:0] SRLQueue_io_deq_bits;
  wire[3:0] SRLQueue_io_count;


  assign io_count = SRLQueue_io_count;
  assign io_deq_bits = SRLQueue_io_deq_bits;
  assign io_deq_valid = SRLQueue_io_deq_valid;
  assign io_enq_ready = SRLQueue_io_enq_ready;
  SRLQueue_1 SRLQueue(.clk(clk), .reset(reset),
       .io_enq_ready( SRLQueue_io_enq_ready ),
       .io_enq_valid( io_enq_valid ),
       .io_enq_bits( io_enq_bits ),
       .io_deq_ready( io_deq_ready ),
       .io_deq_valid( SRLQueue_io_deq_valid ),
       .io_deq_bits( SRLQueue_io_deq_bits ),
       .io_count( SRLQueue_io_count )
  );
endmodule

module StreamFilter(
    output io_in_ready,
    input  io_in_valid,
    input [5:0] io_in_bits_channelID,
    input [63:0] io_in_bits_readData,
    input  io_in_bits_isWrite,
    input  io_in_bits_isLast,
    input  io_in_bits_metaData,
    input  io_out_ready,
    output io_out_valid,
    output[63:0] io_out_bits
);



  assign io_out_bits = io_in_bits_readData;
  assign io_out_valid = io_in_valid;
  assign io_in_ready = io_out_ready;
endmodule

module ParallelInSerialOut(input clk, input reset,
    input [63:0] io_parIn,
    input  io_parWrEn,
    input [31:0] io_serIn,
    output[31:0] io_serOut,
    input  io_shiftEn
);

  reg [31:0] stages_0;
  wire[31:0] T8;
  wire[31:0] T0;
  wire[31:0] T1;
  wire[31:0] T2;
  reg [31:0] stages_1;
  wire[31:0] T9;
  wire[31:0] T3;
  wire[31:0] T4;
  wire[31:0] T5;
  wire T6;
  wire T7;

`ifndef SYNTHESIS
// synthesis translate_off
  integer initvar;
  initial begin
    #0.002;
    stages_0 = {1{$random}};
    stages_1 = {1{$random}};
  end
// synthesis translate_on
`endif

  assign io_serOut = stages_0;
  assign T8 = reset ? 32'h0 : T0;
  assign T0 = T6 ? stages_1 : T1;
  assign T1 = io_parWrEn ? T2 : stages_0;
  assign T2 = io_parIn[31:0];
  assign T9 = reset ? 32'h0 : T3;
  assign T3 = T6 ? io_serIn : T4;
  assign T4 = io_parWrEn ? T5 : stages_1;
  assign T5 = io_parIn[63:32];
  assign T6 = T7 & io_shiftEn;
  assign T7 = io_parWrEn ^ 1'h1;

  always @(posedge clk) begin
    if(reset) begin
      stages_0 <= 32'h0;
    end else if(T6) begin
      stages_0 <= stages_1;
    end else if(io_parWrEn) begin
      stages_0 <= T2;
    end
    if(reset) begin
      stages_1 <= 32'h0;
    end else if(T6) begin
      stages_1 <= io_serIn;
    end else if(io_parWrEn) begin
      stages_1 <= T5;
    end
  end
endmodule

module AXIStreamDownsizer(input clk, input reset,
    output wide_TREADY,
    input  wide_TVALID,
    input [63:0] wide_TDATA,
    input  narrow_TREADY,
    output narrow_TVALID,
    output[31:0] narrow_TDATA
);

  wire T0;
  wire T1;
  reg [1:0] regState;
  wire[1:0] T22;
  wire[1:0] T2;
  wire[1:0] T3;
  wire[1:0] T4;
  wire[1:0] T5;
  wire T6;
  wire T7;
  wire T8;
  wire T9;
  reg  regShiftCount;
  wire T23;
  wire T10;
  wire T11;
  wire T12;
  wire T13;
  wire T14;
  wire T15;
  wire T16;
  wire T17;
  wire T18;
  wire T19;
  wire T20;
  wire T21;
  wire[31:0] shiftReg_io_serOut;

`ifndef SYNTHESIS
// synthesis translate_off
  integer initvar;
  initial begin
    #0.002;
    regState = {1{$random}};
    regShiftCount = {1{$random}};
  end
// synthesis translate_on
`endif

  assign T0 = T1 & narrow_TREADY;
  assign T1 = 2'h1 == regState;
  assign T22 = reset ? 2'h0 : T2;
  assign T2 = T17 ? 2'h0 : T3;
  assign T3 = T14 ? 2'h1 : T4;
  assign T4 = T8 ? 2'h2 : T5;
  assign T5 = T6 ? 2'h1 : regState;
  assign T6 = T7 & wide_TVALID;
  assign T7 = 2'h0 == regState;
  assign T8 = T0 & T9;
  assign T9 = regShiftCount == 1'h0;
  assign T23 = reset ? 1'h0 : T10;
  assign T10 = T14 ? 1'h0 : T11;
  assign T11 = T0 ? T13 : T12;
  assign T12 = T7 ? 1'h0 : regShiftCount;
  assign T13 = regShiftCount + 1'h1;
  assign T14 = T15 & wide_TVALID;
  assign T15 = T16 & narrow_TREADY;
  assign T16 = 2'h2 == regState;
  assign T17 = T15 & T18;
  assign T18 = wide_TVALID ^ 1'h1;
  assign T19 = T14 ? 1'h1 : T7;
  assign narrow_TDATA = shiftReg_io_serOut;
  assign narrow_TVALID = T20;
  assign T20 = T16 ? 1'h1 : T1;
  assign wide_TREADY = T21;
  assign T21 = T14 ? 1'h1 : T7;
  ParallelInSerialOut shiftReg(.clk(clk), .reset(reset),
       .io_parIn( wide_TDATA ),
       .io_parWrEn( T19 ),
       .io_serIn( 32'h0 ),
       .io_serOut( shiftReg_io_serOut ),
       .io_shiftEn( T0 )
  );

  always @(posedge clk) begin
    if(reset) begin
      regState <= 2'h0;
    end else if(T17) begin
      regState <= 2'h0;
    end else if(T14) begin
      regState <= 2'h1;
    end else if(T8) begin
      regState <= 2'h2;
    end else if(T6) begin
      regState <= 2'h1;
    end
    if(reset) begin
      regShiftCount <= 1'h0;
    end else if(T14) begin
      regShiftCount <= 1'h0;
    end else if(T0) begin
      regShiftCount <= T13;
    end else if(T7) begin
      regShiftCount <= 1'h0;
    end
  end
endmodule

module StreamLimiter(input clk, input reset,
    input  io_start,
    output io_done,
    input [31:0] io_byteCount,
    output io_streamIn_ready,
    input  io_streamIn_valid,
    input [31:0] io_streamIn_bits,
    input  io_streamOut_ready,
    output io_streamOut_valid,
    output[31:0] io_streamOut_bits
);

  wire T0;
  wire T1;
  reg [1:0] regState;
  wire[1:0] T18;
  wire[1:0] T2;
  wire[1:0] T3;
  wire[1:0] T4;
  wire T5;
  wire T6;
  wire T7;
  wire T8;
  reg [31:0] regBytesLeft;
  wire[31:0] T19;
  wire[31:0] T9;
  wire[31:0] T10;
  wire[31:0] T11;
  wire T12;
  wire T13;
  wire T14;
  wire T15;
  wire T16;
  wire T17;

`ifndef SYNTHESIS
// synthesis translate_off
  integer initvar;
  initial begin
    #0.002;
    regState = {1{$random}};
    regBytesLeft = {1{$random}};
  end
// synthesis translate_on
`endif

  assign io_streamOut_bits = io_streamIn_bits;
  assign io_streamOut_valid = T0;
  assign T0 = T1 ? 1'h0 : io_streamIn_valid;
  assign T1 = 2'h2 == regState;
  assign T18 = reset ? 2'h0 : T2;
  assign T2 = T15 ? 2'h0 : T3;
  assign T3 = T7 ? 2'h2 : T4;
  assign T4 = T5 ? 2'h1 : regState;
  assign T5 = T6 & io_start;
  assign T6 = 2'h0 == regState;
  assign T7 = T12 & T8;
  assign T8 = regBytesLeft == 32'h4;
  assign T19 = reset ? 32'h0 : T9;
  assign T9 = T12 ? T11 : T10;
  assign T10 = T6 ? io_byteCount : regBytesLeft;
  assign T11 = regBytesLeft - 32'h4;
  assign T12 = T14 & T13;
  assign T13 = io_streamIn_valid & io_streamOut_ready;
  assign T14 = 2'h1 == regState;
  assign T15 = T1 & T16;
  assign T16 = io_start ^ 1'h1;
  assign io_streamIn_ready = T17;
  assign T17 = T1 ? 1'h1 : io_streamOut_ready;
  assign io_done = T1;

  always @(posedge clk) begin
    if(reset) begin
      regState <= 2'h0;
    end else if(T15) begin
      regState <= 2'h0;
    end else if(T7) begin
      regState <= 2'h2;
    end else if(T5) begin
      regState <= 2'h1;
    end
    if(reset) begin
      regBytesLeft <= 32'h0;
    end else if(T12) begin
      regBytesLeft <= T11;
    end else if(T6) begin
      regBytesLeft <= io_byteCount;
    end
  end
endmodule

module StreamReader(input clk, input reset,
    input  io_start,
    output io_active,
    output io_finished,
    output io_error,
    input [31:0] io_baseAddr,
    input [31:0] io_byteCount,
    input  io_out_ready,
    output io_out_valid,
    output[31:0] io_out_bits,
    input  io_req_ready,
    output io_req_valid,
    output[5:0] io_req_bits_channelID,
    output io_req_bits_isWrite,
    output[31:0] io_req_bits_addr,
    output[7:0] io_req_bits_numBytes,
    output io_req_bits_metaData,
    output io_rsp_ready,
    input  io_rsp_valid,
    input [5:0] io_rsp_bits_channelID,
    input [63:0] io_rsp_bits_readData,
    input  io_rsp_bits_isWrite,
    input  io_rsp_bits_isLast,
    input  io_rsp_bits_metaData
    //input  io_doInit
    //input [7:0] io_initCount
);

  wire[31:0] T0;
  wire[31:0] T1;
  wire[28:0] T2;
  wire[28:0] T3;
  wire T4;
  wire[2:0] T5;
  wire allResponsesDone;
  reg [31:0] regDoneBytes;
  wire[31:0] T15;
  wire[31:0] T6;
  wire[31:0] T7;
  wire T8;
  wire[31:0] T9;
  wire T10;
  wire T11;
  wire T12;
  wire T13;
  wire T14;
  wire ReadReqGen_io_stat_error;
  wire ReadReqGen_io_reqs_valid;
  wire[5:0] ReadReqGen_io_reqs_bits_channelID;
  wire ReadReqGen_io_reqs_bits_isWrite;
  wire[31:0] ReadReqGen_io_reqs_bits_addr;
  wire[7:0] ReadReqGen_io_reqs_bits_numBytes;
  wire ReadReqGen_io_reqs_bits_metaData;
  wire StreamFilter_io_in_ready;
  wire StreamFilter_io_out_valid;
  wire[63:0] StreamFilter_io_out_bits;
  wire StreamLimiter_io_streamIn_ready;
  wire StreamLimiter_io_streamOut_valid;
  wire[31:0] StreamLimiter_io_streamOut_bits;
  wire AXIStreamDownsizer_wide_TREADY;
  wire AXIStreamDownsizer_narrow_TVALID;
  wire[31:0] AXIStreamDownsizer_narrow_TDATA;
  wire FPGAQueue_io_enq_ready;
  wire FPGAQueue_io_deq_valid;
  wire[31:0] FPGAQueue_io_deq_bits;

`ifndef SYNTHESIS
// synthesis translate_off
  integer initvar;
  initial begin
    #0.002;
    regDoneBytes = {1{$random}};
  end
// synthesis translate_on
`endif

  assign T0 = T4 ? io_byteCount : T1;
  assign T1 = {T2, 3'h0};
  assign T2 = T3 + 29'h1;
  assign T3 = io_byteCount[31:3];
  assign T4 = T5 == 3'h0;
  assign T5 = io_byteCount[2:0];
  assign io_rsp_ready = StreamFilter_io_in_ready;
  assign io_req_bits_metaData = ReadReqGen_io_reqs_bits_metaData;
  assign io_req_bits_numBytes = ReadReqGen_io_reqs_bits_numBytes;
  assign io_req_bits_addr = ReadReqGen_io_reqs_bits_addr;
  assign io_req_bits_isWrite = ReadReqGen_io_reqs_bits_isWrite;
  assign io_req_bits_channelID = ReadReqGen_io_reqs_bits_channelID;
  assign io_req_valid = ReadReqGen_io_reqs_valid;
  assign io_out_bits = FPGAQueue_io_deq_bits;
  assign io_out_valid = FPGAQueue_io_deq_valid;
  assign io_error = ReadReqGen_io_stat_error;
  assign io_finished = allResponsesDone;
  assign allResponsesDone = regDoneBytes == io_byteCount;
  assign T15 = reset ? 32'h0 : T6;
  assign T6 = T10 ? T9 : T7;
  assign T7 = T8 ? 32'h0 : regDoneBytes;
  assign T8 = io_start ^ 1'h1;
  assign T9 = regDoneBytes + 32'h4;
  assign T10 = T12 & T11;
  assign T11 = io_out_valid & io_out_ready;
  assign T12 = T8 ^ 1'h1;
  assign io_active = T13;
  assign T13 = io_start & T14;
  assign T14 = allResponsesDone ^ 1'h1;
  ReadReqGen ReadReqGen(.clk(clk), .reset(reset),
       .io_ctrl_start( io_start ),
       .io_ctrl_throttle( 1'h0 ),
       .io_ctrl_baseAddr( io_baseAddr ),
       .io_ctrl_byteCount( T0 ),
       //.io_stat_finished(  )
       //.io_stat_active(  )
       .io_stat_error( ReadReqGen_io_stat_error ),
       .io_reqs_ready( io_req_ready ),
       .io_reqs_valid( ReadReqGen_io_reqs_valid ),
       .io_reqs_bits_channelID( ReadReqGen_io_reqs_bits_channelID ),
       .io_reqs_bits_isWrite( ReadReqGen_io_reqs_bits_isWrite ),
       .io_reqs_bits_addr( ReadReqGen_io_reqs_bits_addr ),
       .io_reqs_bits_numBytes( ReadReqGen_io_reqs_bits_numBytes ),
       .io_reqs_bits_metaData( ReadReqGen_io_reqs_bits_metaData )
  );
  FPGAQueue_1 FPGAQueue(.clk(clk), .reset(reset),
       .io_enq_ready( FPGAQueue_io_enq_ready ),
       .io_enq_valid( StreamLimiter_io_streamOut_valid ),
       .io_enq_bits( StreamLimiter_io_streamOut_bits ),
       .io_deq_ready( io_out_ready ),
       .io_deq_valid( FPGAQueue_io_deq_valid ),
       .io_deq_bits( FPGAQueue_io_deq_bits )
       //.io_count(  )
  );
  StreamFilter StreamFilter(
       .io_in_ready( StreamFilter_io_in_ready ),
       .io_in_valid( io_rsp_valid ),
       .io_in_bits_channelID( io_rsp_bits_channelID ),
       .io_in_bits_readData( io_rsp_bits_readData ),
       .io_in_bits_isWrite( io_rsp_bits_isWrite ),
       .io_in_bits_isLast( io_rsp_bits_isLast ),
       .io_in_bits_metaData( io_rsp_bits_metaData ),
       .io_out_ready( AXIStreamDownsizer_wide_TREADY ),
       .io_out_valid( StreamFilter_io_out_valid ),
       .io_out_bits( StreamFilter_io_out_bits )
  );
  AXIStreamDownsizer AXIStreamDownsizer(.clk(clk), .reset(reset),
       .wide_TREADY( AXIStreamDownsizer_wide_TREADY ),
       .wide_TVALID( StreamFilter_io_out_valid ),
       .wide_TDATA( StreamFilter_io_out_bits ),
       .narrow_TREADY( StreamLimiter_io_streamIn_ready ),
       .narrow_TVALID( AXIStreamDownsizer_narrow_TVALID ),
       .narrow_TDATA( AXIStreamDownsizer_narrow_TDATA )
  );
  StreamLimiter StreamLimiter(.clk(clk), .reset(reset),
       .io_start( io_start ),
       //.io_done(  )
       .io_byteCount( io_byteCount ),
       .io_streamIn_ready( StreamLimiter_io_streamIn_ready ),
       .io_streamIn_valid( AXIStreamDownsizer_narrow_TVALID ),
       .io_streamIn_bits( AXIStreamDownsizer_narrow_TDATA ),
       .io_streamOut_ready( FPGAQueue_io_enq_ready ),
       .io_streamOut_valid( StreamLimiter_io_streamOut_valid ),
       .io_streamOut_bits( StreamLimiter_io_streamOut_bits )
  );

  always @(posedge clk) begin
    if(reset) begin
      regDoneBytes <= 32'h0;
    end else if(T10) begin
      regDoneBytes <= T9;
    end else if(T8) begin
      regDoneBytes <= 32'h0;
    end
  end
endmodule

module StreamReducer(input clk, input reset,
    input  io_start,
    output io_finished,
    output[31:0] io_reduced,
    input [31:0] io_byteCount,
    output io_streamIn_ready,
    input  io_streamIn_valid,
    input [31:0] io_streamIn_bits
);

  wire T0;
  wire T1;
  wire T2;
  reg [31:0] regBytesLeft;
  wire[31:0] T20;
  wire[31:0] T3;
  wire[31:0] T4;
  wire T5;
  reg [1:0] regState;
  wire[1:0] T21;
  wire[1:0] T6;
  wire[1:0] T7;
  wire[1:0] T8;
  wire T9;
  wire T10;
  wire T11;
  wire T12;
  wire T13;
  wire[31:0] T14;
  wire T15;
  wire T16;
  reg [31:0] regReduced;
  wire[31:0] T22;
  wire[31:0] T17;
  wire[31:0] T18;
  wire[31:0] T19;

`ifndef SYNTHESIS
// synthesis translate_off
  integer initvar;
  initial begin
    #0.002;
    regBytesLeft = {1{$random}};
    regState = {1{$random}};
    regReduced = {1{$random}};
  end
// synthesis translate_on
`endif

  assign io_streamIn_ready = T0;
  assign T0 = T16 & T1;
  assign T1 = T2 ^ 1'h1;
  assign T2 = regBytesLeft == 32'h0;
  assign T20 = reset ? 32'h0 : T3;
  assign T3 = T15 ? T14 : T4;
  assign T4 = T5 ? io_byteCount : regBytesLeft;
  assign T5 = 2'h0 == regState;
  assign T21 = reset ? 2'h0 : T6;
  assign T6 = T11 ? 2'h0 : T7;
  assign T7 = T10 ? 2'h2 : T8;
  assign T8 = T9 ? 2'h1 : regState;
  assign T9 = T5 & io_start;
  assign T10 = T16 & T2;
  assign T11 = T13 & T12;
  assign T12 = io_start ^ 1'h1;
  assign T13 = 2'h2 == regState;
  assign T14 = regBytesLeft - 32'h4;
  assign T15 = T0 & io_streamIn_valid;
  assign T16 = 2'h1 == regState;
  assign io_reduced = regReduced;
  assign T22 = reset ? 32'h0 : T17;
  assign T17 = T15 ? T19 : T18;
  assign T18 = T5 ? 32'h0 : regReduced;
  assign T19 = regReduced + io_streamIn_bits;
  assign io_finished = T13;

  always @(posedge clk) begin
    if(reset) begin
      regBytesLeft <= 32'h0;
    end else if(T15) begin
      regBytesLeft <= T14;
    end else if(T5) begin
      regBytesLeft <= io_byteCount;
    end
    if(reset) begin
      regState <= 2'h0;
    end else if(T11) begin
      regState <= 2'h0;
    end else if(T10) begin
      regState <= 2'h2;
    end else if(T9) begin
      regState <= 2'h1;
    end
    if(reset) begin
      regReduced <= 32'h0;
    end else if(T15) begin
      regReduced <= T19;
    end else if(T5) begin
      regReduced <= 32'h0;
    end
  end
endmodule

module TestSum(input clk, input reset,
    input  io_memPort_0_memRdReq_ready,
    output io_memPort_0_memRdReq_valid,
    output[5:0] io_memPort_0_memRdReq_bits_channelID,
    output io_memPort_0_memRdReq_bits_isWrite,
    output[31:0] io_memPort_0_memRdReq_bits_addr,
    output[7:0] io_memPort_0_memRdReq_bits_numBytes,
    output io_memPort_0_memRdReq_bits_metaData,
    output io_memPort_0_memRdRsp_ready,
    input  io_memPort_0_memRdRsp_valid,
    input [5:0] io_memPort_0_memRdRsp_bits_channelID,
    input [63:0] io_memPort_0_memRdRsp_bits_readData,
    input  io_memPort_0_memRdRsp_bits_isWrite,
    input  io_memPort_0_memRdRsp_bits_isLast,
    input  io_memPort_0_memRdRsp_bits_metaData,
    input  io_memPort_0_memWrReq_ready,
    output io_memPort_0_memWrReq_valid,
    output[5:0] io_memPort_0_memWrReq_bits_channelID,
    output io_memPort_0_memWrReq_bits_isWrite,
    output[31:0] io_memPort_0_memWrReq_bits_addr,
    output[7:0] io_memPort_0_memWrReq_bits_numBytes,
    output io_memPort_0_memWrReq_bits_metaData,
    input  io_memPort_0_memWrDat_ready,
    output io_memPort_0_memWrDat_valid,
    output[63:0] io_memPort_0_memWrDat_bits,
    output io_memPort_0_memWrRsp_ready,
    input  io_memPort_0_memWrRsp_valid,
    input [5:0] io_memPort_0_memWrRsp_bits_channelID,
    input [63:0] io_memPort_0_memWrRsp_bits_readData,
    input  io_memPort_0_memWrRsp_bits_isWrite,
    input  io_memPort_0_memWrRsp_bits_isLast,
    input  io_memPort_0_memWrRsp_bits_metaData,
    output[31:0] io_signature,
    input  io_start,
    output io_finished,
    input [63:0] io_baseAddr,
    input [31:0] io_byteCount,
    output[31:0] io_sum,
    output[31:0] io_cycleCount
);

  wire[31:0] T8;
  reg [31:0] regCycleCount;
  wire[31:0] T9;
  wire[31:0] T0;
  wire[31:0] T1;
  wire T2;
  wire[31:0] T3;
  wire T4;
  wire T5;
  wire T6;
  wire T7;
  wire StreamReducer_io_finished;
  wire[31:0] StreamReducer_io_reduced;
  wire StreamReducer_io_streamIn_ready;
  wire StreamReader_io_out_valid;
  wire[31:0] StreamReader_io_out_bits;
  wire StreamReader_io_req_valid;
  wire[5:0] StreamReader_io_req_bits_channelID;
  wire StreamReader_io_req_bits_isWrite;
  wire[31:0] StreamReader_io_req_bits_addr;
  wire[7:0] StreamReader_io_req_bits_numBytes;
  wire StreamReader_io_req_bits_metaData;
  wire StreamReader_io_rsp_ready;

`ifndef SYNTHESIS
// synthesis translate_off
  integer initvar;
  initial begin
    #0.002;
    regCycleCount = {1{$random}};
  end
// synthesis translate_on
`endif

  assign T8 = io_baseAddr[31:0];
  assign io_cycleCount = regCycleCount;
  assign T9 = reset ? 32'h0 : T0;
  assign T0 = T4 ? T3 : T1;
  assign T1 = T2 ? 32'h0 : regCycleCount;
  assign T2 = io_start ^ 1'h1;
  assign T3 = regCycleCount + 32'h1;
  assign T4 = T7 & T5;
  assign T5 = io_start & T6;
  assign T6 = io_finished ^ 1'h1;
  assign T7 = T2 ^ 1'h1;
  assign io_sum = StreamReducer_io_reduced;
  assign io_finished = StreamReducer_io_finished;
  assign io_signature = 32'h47512158;
  assign io_memPort_0_memWrRsp_ready = 1'h0;
  assign io_memPort_0_memWrDat_bits = 64'h0;
  assign io_memPort_0_memWrDat_valid = 1'h0;
  assign io_memPort_0_memWrReq_bits_metaData = 1'h0;
  assign io_memPort_0_memWrReq_bits_numBytes = 8'h0;
  assign io_memPort_0_memWrReq_bits_addr = 32'h0;
  assign io_memPort_0_memWrReq_bits_isWrite = 1'h0;
  assign io_memPort_0_memWrReq_bits_channelID = 6'h0;
  assign io_memPort_0_memWrReq_valid = 1'h0;
  assign io_memPort_0_memRdRsp_ready = StreamReader_io_rsp_ready;
  assign io_memPort_0_memRdReq_bits_metaData = StreamReader_io_req_bits_metaData;
  assign io_memPort_0_memRdReq_bits_numBytes = StreamReader_io_req_bits_numBytes;
  assign io_memPort_0_memRdReq_bits_addr = StreamReader_io_req_bits_addr;
  assign io_memPort_0_memRdReq_bits_isWrite = StreamReader_io_req_bits_isWrite;
  assign io_memPort_0_memRdReq_bits_channelID = StreamReader_io_req_bits_channelID;
  assign io_memPort_0_memRdReq_valid = StreamReader_io_req_valid;
  StreamReader StreamReader(.clk(clk), .reset(reset),
       .io_start( io_start ),
       //.io_active(  )
       //.io_finished(  )
       //.io_error(  )
       .io_baseAddr( T8 ),
       .io_byteCount( io_byteCount ),
       .io_out_ready( StreamReducer_io_streamIn_ready ),
       .io_out_valid( StreamReader_io_out_valid ),
       .io_out_bits( StreamReader_io_out_bits ),
       .io_req_ready( io_memPort_0_memRdReq_ready ),
       .io_req_valid( StreamReader_io_req_valid ),
       .io_req_bits_channelID( StreamReader_io_req_bits_channelID ),
       .io_req_bits_isWrite( StreamReader_io_req_bits_isWrite ),
       .io_req_bits_addr( StreamReader_io_req_bits_addr ),
       .io_req_bits_numBytes( StreamReader_io_req_bits_numBytes ),
       .io_req_bits_metaData( StreamReader_io_req_bits_metaData ),
       .io_rsp_ready( StreamReader_io_rsp_ready ),
       .io_rsp_valid( io_memPort_0_memRdRsp_valid ),
       .io_rsp_bits_channelID( io_memPort_0_memRdRsp_bits_channelID ),
       .io_rsp_bits_readData( io_memPort_0_memRdRsp_bits_readData ),
       .io_rsp_bits_isWrite( io_memPort_0_memRdRsp_bits_isWrite ),
       .io_rsp_bits_isLast( io_memPort_0_memRdRsp_bits_isLast ),
       .io_rsp_bits_metaData( io_memPort_0_memRdRsp_bits_metaData )
       //.io_doInit(  )
       //.io_initCount(  )
  );
  StreamReducer StreamReducer(.clk(clk), .reset(reset),
       .io_start( io_start ),
       .io_finished( StreamReducer_io_finished ),
       .io_reduced( StreamReducer_io_reduced ),
       .io_byteCount( io_byteCount ),
       .io_streamIn_ready( StreamReducer_io_streamIn_ready ),
       .io_streamIn_valid( StreamReader_io_out_valid ),
       .io_streamIn_bits( StreamReader_io_out_bits )
  );

  always @(posedge clk) begin
    if(reset) begin
      regCycleCount <= 32'h0;
    end else if(T4) begin
      regCycleCount <= T3;
    end else if(T2) begin
      regCycleCount <= 32'h0;
    end
  end
endmodule

module RegFile(input clk, input reset,
    input  io_extIF_cmd_valid,
    input [2:0] io_extIF_cmd_bits_regID,
    input  io_extIF_cmd_bits_read,
    input  io_extIF_cmd_bits_write,
    input [31:0] io_extIF_cmd_bits_writeData,
    output io_extIF_readData_valid,
    output[31:0] io_extIF_readData_bits,
    output[2:0] io_extIF_regCount,
    output[31:0] io_regOut_7,
    output[31:0] io_regOut_6,
    output[31:0] io_regOut_5,
    output[31:0] io_regOut_4,
    output[31:0] io_regOut_3,
    output[31:0] io_regOut_2,
    output[31:0] io_regOut_1,
    output[31:0] io_regOut_0,
    input  io_regIn_7_valid,
    input [31:0] io_regIn_7_bits,
    input  io_regIn_6_valid,
    input [31:0] io_regIn_6_bits,
    input  io_regIn_5_valid,
    input [31:0] io_regIn_5_bits,
    input  io_regIn_4_valid,
    input [31:0] io_regIn_4_bits,
    input  io_regIn_3_valid,
    input [31:0] io_regIn_3_bits,
    input  io_regIn_2_valid,
    input [31:0] io_regIn_2_bits,
    input  io_regIn_1_valid,
    input [31:0] io_regIn_1_bits,
    input  io_regIn_0_valid,
    input [31:0] io_regIn_0_bits
);

  reg [31:0] regFile_0;
  wire[31:0] T59;
  wire[31:0] T0;
  wire[31:0] T1;
  reg [31:0] regCommand_writeData;
  wire T2;
  wire T3;
  wire[7:0] T4;
  wire[2:0] T5;
  reg [2:0] regCommand_regID;
  wire hasExtWriteCommand;
  reg  regCommand_write;
  reg  regDoCmd;
  wire T60;
  wire T6;
  wire T7;
  reg [31:0] regFile_1;
  wire[31:0] T61;
  wire[31:0] T8;
  wire[31:0] T9;
  wire T10;
  wire T11;
  wire T12;
  reg [31:0] regFile_2;
  wire[31:0] T62;
  wire[31:0] T13;
  wire[31:0] T14;
  wire T15;
  wire T16;
  wire T17;
  reg [31:0] regFile_3;
  wire[31:0] T63;
  wire[31:0] T18;
  wire[31:0] T19;
  wire T20;
  wire T21;
  wire T22;
  reg [31:0] regFile_4;
  wire[31:0] T64;
  wire[31:0] T23;
  wire[31:0] T24;
  wire T25;
  wire T26;
  wire T27;
  reg [31:0] regFile_5;
  wire[31:0] T65;
  wire[31:0] T28;
  wire[31:0] T29;
  wire T30;
  wire T31;
  wire T32;
  reg [31:0] regFile_6;
  wire[31:0] T66;
  wire[31:0] T33;
  wire[31:0] T34;
  wire T35;
  wire T36;
  wire T37;
  reg [31:0] regFile_7;
  wire[31:0] T67;
  wire[31:0] T38;
  wire[31:0] T39;
  wire T40;
  wire T41;
  wire T42;
  wire[31:0] T43;
  wire[31:0] T44;
  wire[31:0] T45;
  wire[31:0] T46;
  wire T47;
  wire[31:0] T48;
  wire T49;
  wire T50;
  wire[31:0] T51;
  wire[31:0] T52;
  wire T53;
  wire[31:0] T54;
  wire T55;
  wire T56;
  wire T57;
  wire T58;
  wire[3:0] T68;
  wire hasExtReadCommand;
  reg  regCommand_read;

`ifndef SYNTHESIS
// synthesis translate_off
  integer initvar;
  initial begin
    #0.002;
    regFile_0 = {1{$random}};
    regCommand_writeData = {1{$random}};
    regCommand_regID = {1{$random}};
    regCommand_write = {1{$random}};
    regDoCmd = {1{$random}};
    regFile_1 = {1{$random}};
    regFile_2 = {1{$random}};
    regFile_3 = {1{$random}};
    regFile_4 = {1{$random}};
    regFile_5 = {1{$random}};
    regFile_6 = {1{$random}};
    regFile_7 = {1{$random}};
    regCommand_read = {1{$random}};
  end
// synthesis translate_on
`endif

  assign io_regOut_0 = regFile_0;
  assign T59 = reset ? 32'h0 : T0;
  assign T0 = T6 ? io_regIn_0_bits : T1;
  assign T1 = T2 ? regCommand_writeData : regFile_0;
  assign T2 = hasExtWriteCommand & T3;
  assign T3 = T4[0];
  assign T4 = 1'h1 << T5;
  assign T5 = regCommand_regID;
  assign hasExtWriteCommand = regDoCmd & regCommand_write;
  assign T60 = reset ? 1'h0 : io_extIF_cmd_valid;
  assign T6 = T7 & io_regIn_0_valid;
  assign T7 = hasExtWriteCommand ^ 1'h1;
  assign io_regOut_1 = regFile_1;
  assign T61 = reset ? 32'h0 : T8;
  assign T8 = T12 ? io_regIn_1_bits : T9;
  assign T9 = T10 ? regCommand_writeData : regFile_1;
  assign T10 = hasExtWriteCommand & T11;
  assign T11 = T4[1];
  assign T12 = T7 & io_regIn_1_valid;
  assign io_regOut_2 = regFile_2;
  assign T62 = reset ? 32'h0 : T13;
  assign T13 = T17 ? io_regIn_2_bits : T14;
  assign T14 = T15 ? regCommand_writeData : regFile_2;
  assign T15 = hasExtWriteCommand & T16;
  assign T16 = T4[2];
  assign T17 = T7 & io_regIn_2_valid;
  assign io_regOut_3 = regFile_3;
  assign T63 = reset ? 32'h0 : T18;
  assign T18 = T22 ? io_regIn_3_bits : T19;
  assign T19 = T20 ? regCommand_writeData : regFile_3;
  assign T20 = hasExtWriteCommand & T21;
  assign T21 = T4[3];
  assign T22 = T7 & io_regIn_3_valid;
  assign io_regOut_4 = regFile_4;
  assign T64 = reset ? 32'h0 : T23;
  assign T23 = T27 ? io_regIn_4_bits : T24;
  assign T24 = T25 ? regCommand_writeData : regFile_4;
  assign T25 = hasExtWriteCommand & T26;
  assign T26 = T4[4];
  assign T27 = T7 & io_regIn_4_valid;
  assign io_regOut_5 = regFile_5;
  assign T65 = reset ? 32'h0 : T28;
  assign T28 = T32 ? io_regIn_5_bits : T29;
  assign T29 = T30 ? regCommand_writeData : regFile_5;
  assign T30 = hasExtWriteCommand & T31;
  assign T31 = T4[5];
  assign T32 = T7 & io_regIn_5_valid;
  assign io_regOut_6 = regFile_6;
  assign T66 = reset ? 32'h0 : T33;
  assign T33 = T37 ? io_regIn_6_bits : T34;
  assign T34 = T35 ? regCommand_writeData : regFile_6;
  assign T35 = hasExtWriteCommand & T36;
  assign T36 = T4[6];
  assign T37 = T7 & io_regIn_6_valid;
  assign io_regOut_7 = regFile_7;
  assign T67 = reset ? 32'h0 : T38;
  assign T38 = T42 ? io_regIn_7_bits : T39;
  assign T39 = T40 ? regCommand_writeData : regFile_7;
  assign T40 = hasExtWriteCommand & T41;
  assign T41 = T4[7];
  assign T42 = T7 & io_regIn_7_valid;
  assign io_extIF_regCount = 3'h0;
  assign io_extIF_readData_bits = T43;
  assign T43 = T58 ? T44 : 32'h0;
  assign T44 = T57 ? T51 : T45;
  assign T45 = T50 ? T48 : T46;
  assign T46 = T47 ? regFile_1 : regFile_0;
  assign T47 = T5[0];
  assign T48 = T49 ? regFile_3 : regFile_2;
  assign T49 = T5[0];
  assign T50 = T5[1];
  assign T51 = T56 ? T54 : T52;
  assign T52 = T53 ? regFile_5 : regFile_4;
  assign T53 = T5[0];
  assign T54 = T55 ? regFile_7 : regFile_6;
  assign T55 = T5[0];
  assign T56 = T5[1];
  assign T57 = T5[2];
  assign T58 = T68 < 4'h8;
  assign T68 = {1'h0, regCommand_regID};
  assign io_extIF_readData_valid = hasExtReadCommand;
  assign hasExtReadCommand = regDoCmd & regCommand_read;

  always @(posedge clk) begin
    if(reset) begin
      regFile_0 <= 32'h0;
    end else if(T6) begin
      regFile_0 <= io_regIn_0_bits;
    end else if(T2) begin
      regFile_0 <= regCommand_writeData;
    end
    regCommand_writeData <= io_extIF_cmd_bits_writeData;
    regCommand_regID <= io_extIF_cmd_bits_regID;
    regCommand_write <= io_extIF_cmd_bits_write;
    if(reset) begin
      regDoCmd <= 1'h0;
    end else begin
      regDoCmd <= io_extIF_cmd_valid;
    end
    if(reset) begin
      regFile_1 <= 32'h0;
    end else if(T12) begin
      regFile_1 <= io_regIn_1_bits;
    end else if(T10) begin
      regFile_1 <= regCommand_writeData;
    end
    if(reset) begin
      regFile_2 <= 32'h0;
    end else if(T17) begin
      regFile_2 <= io_regIn_2_bits;
    end else if(T15) begin
      regFile_2 <= regCommand_writeData;
    end
    if(reset) begin
      regFile_3 <= 32'h0;
    end else if(T22) begin
      regFile_3 <= io_regIn_3_bits;
    end else if(T20) begin
      regFile_3 <= regCommand_writeData;
    end
    if(reset) begin
      regFile_4 <= 32'h0;
    end else if(T27) begin
      regFile_4 <= io_regIn_4_bits;
    end else if(T25) begin
      regFile_4 <= regCommand_writeData;
    end
    if(reset) begin
      regFile_5 <= 32'h0;
    end else if(T32) begin
      regFile_5 <= io_regIn_5_bits;
    end else if(T30) begin
      regFile_5 <= regCommand_writeData;
    end
    if(reset) begin
      regFile_6 <= 32'h0;
    end else if(T37) begin
      regFile_6 <= io_regIn_6_bits;
    end else if(T35) begin
      regFile_6 <= regCommand_writeData;
    end
    if(reset) begin
      regFile_7 <= 32'h0;
    end else if(T42) begin
      regFile_7 <= io_regIn_7_bits;
    end else if(T40) begin
      regFile_7 <= regCommand_writeData;
    end
    regCommand_read <= io_extIF_cmd_bits_read;
  end
endmodule

module AXIMemReqAdp(
    output io_genericReqIn_ready,
    input  io_genericReqIn_valid,
    input [5:0] io_genericReqIn_bits_channelID,
    input  io_genericReqIn_bits_isWrite,
    input [31:0] io_genericReqIn_bits_addr,
    input [7:0] io_genericReqIn_bits_numBytes,
    input  io_genericReqIn_bits_metaData,
    input  io_axiReqOut_ready,
    output io_axiReqOut_valid,
    output[31:0] io_axiReqOut_bits_addr,
    output[2:0] io_axiReqOut_bits_size,
    output[7:0] io_axiReqOut_bits_len,
    output[1:0] io_axiReqOut_bits_burst,
    output[5:0] io_axiReqOut_bits_id,
    output io_axiReqOut_bits_lock,
    output[3:0] io_axiReqOut_bits_cache,
    output[2:0] io_axiReqOut_bits_prot,
    output[3:0] io_axiReqOut_bits_qos
);

  wire[7:0] T0;
  wire[7:0] beats;


  assign io_axiReqOut_bits_qos = 4'h0;
  assign io_axiReqOut_bits_prot = 3'h0;
  assign io_axiReqOut_bits_cache = 4'h2;
  assign io_axiReqOut_bits_lock = 1'h0;
  assign io_axiReqOut_bits_id = io_genericReqIn_bits_channelID;
  assign io_axiReqOut_bits_burst = 2'h1;
  assign io_axiReqOut_bits_len = T0;
  assign T0 = beats - 8'h1;
  assign beats = io_genericReqIn_bits_numBytes / 4'h8;
  assign io_axiReqOut_bits_size = 3'h3;
  assign io_axiReqOut_bits_addr = io_genericReqIn_bits_addr;
  assign io_axiReqOut_valid = io_genericReqIn_valid;
  assign io_genericReqIn_ready = io_axiReqOut_ready;
endmodule

module AXIReadRspAdp(
    output io_axiReadRspIn_ready,
    input  io_axiReadRspIn_valid,
    input [63:0] io_axiReadRspIn_bits_data,
    input [5:0] io_axiReadRspIn_bits_id,
    input  io_axiReadRspIn_bits_last,
    input [1:0] io_axiReadRspIn_bits_resp,
    input  io_genericRspOut_ready,
    output io_genericRspOut_valid,
    output[5:0] io_genericRspOut_bits_channelID,
    output[63:0] io_genericRspOut_bits_readData,
    output io_genericRspOut_bits_isWrite,
    output io_genericRspOut_bits_isLast,
    output io_genericRspOut_bits_metaData
);



  assign io_genericRspOut_bits_metaData = 1'h0;
  assign io_genericRspOut_bits_isLast = io_axiReadRspIn_bits_last;
  assign io_genericRspOut_bits_isWrite = 1'h0;
  assign io_genericRspOut_bits_readData = io_axiReadRspIn_bits_data;
  assign io_genericRspOut_bits_channelID = io_axiReadRspIn_bits_id;
  assign io_genericRspOut_valid = io_axiReadRspIn_valid;
  assign io_axiReadRspIn_ready = io_genericRspOut_ready;
endmodule

module AXIWriteBurstReqAdapter(input clk, input reset,
    output io_in_writeAddr_ready,
    input  io_in_writeAddr_valid,
    input [31:0] io_in_writeAddr_bits_addr,
    input [2:0] io_in_writeAddr_bits_size,
    input [7:0] io_in_writeAddr_bits_len,
    input [1:0] io_in_writeAddr_bits_burst,
    input [5:0] io_in_writeAddr_bits_id,
    input  io_in_writeAddr_bits_lock,
    input [3:0] io_in_writeAddr_bits_cache,
    input [2:0] io_in_writeAddr_bits_prot,
    input [3:0] io_in_writeAddr_bits_qos,
    output io_in_writeData_ready,
    input  io_in_writeData_valid,
    input [63:0] io_in_writeData_bits_data,
    input [7:0] io_in_writeData_bits_strb,
    input  io_in_writeData_bits_last,
    input  io_out_writeAddr_ready,
    output io_out_writeAddr_valid,
    output[31:0] io_out_writeAddr_bits_addr,
    output[2:0] io_out_writeAddr_bits_size,
    output[7:0] io_out_writeAddr_bits_len,
    output[1:0] io_out_writeAddr_bits_burst,
    output[5:0] io_out_writeAddr_bits_id,
    output io_out_writeAddr_bits_lock,
    output[3:0] io_out_writeAddr_bits_cache,
    output[2:0] io_out_writeAddr_bits_prot,
    output[3:0] io_out_writeAddr_bits_qos,
    input  io_out_writeData_ready,
    output io_out_writeData_valid,
    output[63:0] io_out_writeData_bits_data,
    output[7:0] io_out_writeData_bits_strb,
    output io_out_writeData_bits_last
);

  wire T0;
  wire T1;
  reg [7:0] regBeatsLeft;
  wire[7:0] T20;
  wire[7:0] T2;
  wire[7:0] T3;
  wire T4;
  wire T5;
  wire T6;
  reg  regState;
  wire T21;
  wire T7;
  wire T8;
  wire T9;
  wire T10;
  wire T11;
  wire[7:0] T12;
  wire T13;
  wire T14;
  wire T15;
  wire T16;
  wire T17;
  wire T18;
  wire T19;

`ifndef SYNTHESIS
// synthesis translate_off
  integer initvar;
  initial begin
    #0.002;
    regBeatsLeft = {1{$random}};
    regState = {1{$random}};
  end
// synthesis translate_on
`endif

  assign io_out_writeData_bits_last = T0;
  assign T0 = T15 ? T1 : 1'h0;
  assign T1 = regBeatsLeft == 8'h0;
  assign T20 = reset ? 8'h0 : T2;
  assign T2 = T13 ? T12 : T3;
  assign T3 = T4 ? io_in_writeAddr_bits_len : regBeatsLeft;
  assign T4 = T6 & T5;
  assign T5 = io_out_writeAddr_ready & io_out_writeAddr_valid;
  assign T6 = 1'h0 == regState;
  assign T21 = reset ? 1'h0 : T7;
  assign T7 = T9 ? 1'h0 : T8;
  assign T8 = T4 ? 1'h1 : regState;
  assign T9 = T10 & T1;
  assign T10 = T15 & T11;
  assign T11 = io_out_writeData_ready & io_out_writeData_valid;
  assign T12 = regBeatsLeft - 8'h1;
  assign T13 = T10 & T14;
  assign T14 = T1 ^ 1'h1;
  assign T15 = 1'h1 == regState;
  assign io_out_writeData_bits_strb = io_in_writeData_bits_strb;
  assign io_out_writeData_bits_data = io_in_writeData_bits_data;
  assign io_out_writeData_valid = T16;
  assign T16 = T15 ? io_in_writeData_valid : 1'h0;
  assign io_out_writeAddr_bits_qos = io_in_writeAddr_bits_qos;
  assign io_out_writeAddr_bits_prot = io_in_writeAddr_bits_prot;
  assign io_out_writeAddr_bits_cache = io_in_writeAddr_bits_cache;
  assign io_out_writeAddr_bits_lock = io_in_writeAddr_bits_lock;
  assign io_out_writeAddr_bits_id = io_in_writeAddr_bits_id;
  assign io_out_writeAddr_bits_burst = io_in_writeAddr_bits_burst;
  assign io_out_writeAddr_bits_len = io_in_writeAddr_bits_len;
  assign io_out_writeAddr_bits_size = io_in_writeAddr_bits_size;
  assign io_out_writeAddr_bits_addr = io_in_writeAddr_bits_addr;
  assign io_out_writeAddr_valid = T17;
  assign T17 = T6 ? io_in_writeAddr_valid : 1'h0;
  assign io_in_writeData_ready = T18;
  assign T18 = T15 ? io_out_writeData_ready : 1'h0;
  assign io_in_writeAddr_ready = T19;
  assign T19 = T6 ? io_out_writeAddr_ready : 1'h0;

  always @(posedge clk) begin
    if(reset) begin
      regBeatsLeft <= 8'h0;
    end else if(T13) begin
      regBeatsLeft <= T12;
    end else if(T4) begin
      regBeatsLeft <= io_in_writeAddr_bits_len;
    end
    if(reset) begin
      regState <= 1'h0;
    end else if(T9) begin
      regState <= 1'h0;
    end else if(T4) begin
      regState <= 1'h1;
    end
  end
endmodule

module SRLQueue_0(input clk, input reset,
    output io_enq_ready,
    input  io_enq_valid,
    input [63:0] io_enq_bits_data,
    input [7:0] io_enq_bits_strb,
    input  io_enq_bits_last,
    input  io_deq_ready,
    output io_deq_valid,
    output[63:0] io_deq_bits_data,
    output[7:0] io_deq_bits_strb,
    output io_deq_bits_last,
    output[1:0] io_count
);

  wire T0;
  wire[72:0] T1;
  wire[72:0] T2;
  wire[8:0] T3;
  wire T4;
  wire[7:0] T5;
  wire[63:0] T6;
  wire T7;
  wire Q_srl_i_b;
  wire Q_srl_o_v;
  wire[72:0] Q_srl_o_d;
  wire[1:0] Q_srl_count;


  assign T0 = io_deq_ready ^ 1'h1;
  assign T1 = T2;
  assign T2 = {io_enq_bits_data, T3};
  assign T3 = {io_enq_bits_strb, io_enq_bits_last};
  assign io_count = Q_srl_count;
  assign io_deq_bits_last = T4;
  assign T4 = Q_srl_o_d[0];
  assign io_deq_bits_strb = T5;
  assign T5 = Q_srl_o_d[8:1];
  assign io_deq_bits_data = T6;
  assign T6 = Q_srl_o_d[72:9];
  assign io_deq_valid = Q_srl_o_v;
  assign io_enq_ready = T7;
  assign T7 = Q_srl_i_b ^ 1'h1;
  Q_srl # (
    .depth(2),
    .width(73)
  ) Q_srl(.clock(clk), .reset(reset),
       .i_v( io_enq_valid ),
       .i_d( T1 ),
       .i_b( Q_srl_i_b ),
       .o_v( Q_srl_o_v ),
       .o_d( Q_srl_o_d ),
       .o_b( T0 ),
       .count( Q_srl_count )
  );
endmodule

module FPGAQueue_0(input clk, input reset,
    output io_enq_ready,
    input  io_enq_valid,
    input [63:0] io_enq_bits_data,
    input [7:0] io_enq_bits_strb,
    input  io_enq_bits_last,
    input  io_deq_ready,
    output io_deq_valid,
    output[63:0] io_deq_bits_data,
    output[7:0] io_deq_bits_strb,
    output io_deq_bits_last,
    output[1:0] io_count
);

  wire SRLQueue_io_enq_ready;
  wire SRLQueue_io_deq_valid;
  wire[63:0] SRLQueue_io_deq_bits_data;
  wire[7:0] SRLQueue_io_deq_bits_strb;
  wire SRLQueue_io_deq_bits_last;
  wire[1:0] SRLQueue_io_count;


  assign io_count = SRLQueue_io_count;
  assign io_deq_bits_last = SRLQueue_io_deq_bits_last;
  assign io_deq_bits_strb = SRLQueue_io_deq_bits_strb;
  assign io_deq_bits_data = SRLQueue_io_deq_bits_data;
  assign io_deq_valid = SRLQueue_io_deq_valid;
  assign io_enq_ready = SRLQueue_io_enq_ready;
  SRLQueue_0 SRLQueue(.clk(clk), .reset(reset),
       .io_enq_ready( SRLQueue_io_enq_ready ),
       .io_enq_valid( io_enq_valid ),
       .io_enq_bits_data( io_enq_bits_data ),
       .io_enq_bits_strb( io_enq_bits_strb ),
       .io_enq_bits_last( io_enq_bits_last ),
       .io_deq_ready( io_deq_ready ),
       .io_deq_valid( SRLQueue_io_deq_valid ),
       .io_deq_bits_data( SRLQueue_io_deq_bits_data ),
       .io_deq_bits_strb( SRLQueue_io_deq_bits_strb ),
       .io_deq_bits_last( SRLQueue_io_deq_bits_last ),
       .io_count( SRLQueue_io_count )
  );
endmodule

module AXIWriteRspAdp(
    output io_axiWriteRspIn_ready,
    input  io_axiWriteRspIn_valid,
    input [5:0] io_axiWriteRspIn_bits_id,
    input [1:0] io_axiWriteRspIn_bits_resp,
    input  io_genericRspOut_ready,
    output io_genericRspOut_valid,
    output[5:0] io_genericRspOut_bits_channelID,
    output[63:0] io_genericRspOut_bits_readData,
    output io_genericRspOut_bits_isWrite,
    output io_genericRspOut_bits_isLast,
    output io_genericRspOut_bits_metaData
);



  assign io_genericRspOut_bits_metaData = 1'h0;
  assign io_genericRspOut_bits_isLast = 1'h0;
  assign io_genericRspOut_bits_isWrite = 1'h1;
  assign io_genericRspOut_bits_readData = 64'h0;
  assign io_genericRspOut_bits_channelID = io_axiWriteRspIn_bits_id;
  assign io_genericRspOut_valid = io_axiWriteRspIn_valid;
  assign io_axiWriteRspIn_ready = io_genericRspOut_ready;
endmodule

module ZedBoardWrapper(input clk, input reset,
    output csr_AWREADY,
    input  csr_AWVALID,
    input [31:0] csr_AWADDR,
    input [2:0] csr_AWPROT,
    output csr_WREADY,
    input  csr_WVALID,
    input [31:0] csr_WDATA,
    input [3:0] csr_WSTRB,
    input  csr_BREADY,
    output csr_BVALID,
    output[1:0] csr_BRESP,
    output csr_ARREADY,
    input  csr_ARVALID,
    input [31:0] csr_ARADDR,
    input [2:0] csr_ARPROT,
    input  csr_RREADY,
    output csr_RVALID,
    output[31:0] csr_RDATA,
    output[1:0] csr_RRESP,
    input  mem3_AWREADY,
    output mem3_AWVALID,
    output[31:0] mem3_AWADDR,
    output[2:0] mem3_AWSIZE,
    output[7:0] mem3_AWLEN,
    output[1:0] mem3_AWBURST,
    output[5:0] mem3_AWID,
    output mem3_AWLOCK,
    output[3:0] mem3_AWCACHE,
    output[2:0] mem3_AWPROT,
    output[3:0] mem3_AWQOS,
    input  mem3_WREADY,
    output mem3_WVALID,
    output[63:0] mem3_WDATA,
    output[7:0] mem3_WSTRB,
    output mem3_WLAST,
    output mem3_BREADY,
    input  mem3_BVALID,
    input [5:0] mem3_BID,
    input [1:0] mem3_BRESP,
    input  mem3_ARREADY,
    output mem3_ARVALID,
    output[31:0] mem3_ARADDR,
    output[2:0] mem3_ARSIZE,
    output[7:0] mem3_ARLEN,
    output[1:0] mem3_ARBURST,
    output[5:0] mem3_ARID,
    output mem3_ARLOCK,
    output[3:0] mem3_ARCACHE,
    output[2:0] mem3_ARPROT,
    output[3:0] mem3_ARQOS,
    output mem3_RREADY,
    input  mem3_RVALID,
    input [63:0] mem3_RDATA,
    input [5:0] mem3_RID,
    input  mem3_RLAST,
    input [1:0] mem3_RRESP,
    input  mem2_AWREADY,
    output mem2_AWVALID,
    output[31:0] mem2_AWADDR,
    output[2:0] mem2_AWSIZE,
    output[7:0] mem2_AWLEN,
    output[1:0] mem2_AWBURST,
    output[5:0] mem2_AWID,
    output mem2_AWLOCK,
    output[3:0] mem2_AWCACHE,
    output[2:0] mem2_AWPROT,
    output[3:0] mem2_AWQOS,
    input  mem2_WREADY,
    output mem2_WVALID,
    output[63:0] mem2_WDATA,
    output[7:0] mem2_WSTRB,
    output mem2_WLAST,
    output mem2_BREADY,
    input  mem2_BVALID,
    input [5:0] mem2_BID,
    input [1:0] mem2_BRESP,
    input  mem2_ARREADY,
    output mem2_ARVALID,
    output[31:0] mem2_ARADDR,
    output[2:0] mem2_ARSIZE,
    output[7:0] mem2_ARLEN,
    output[1:0] mem2_ARBURST,
    output[5:0] mem2_ARID,
    output mem2_ARLOCK,
    output[3:0] mem2_ARCACHE,
    output[2:0] mem2_ARPROT,
    output[3:0] mem2_ARQOS,
    output mem2_RREADY,
    input  mem2_RVALID,
    input [63:0] mem2_RDATA,
    input [5:0] mem2_RID,
    input  mem2_RLAST,
    input [1:0] mem2_RRESP,
    input  mem1_AWREADY,
    output mem1_AWVALID,
    output[31:0] mem1_AWADDR,
    output[2:0] mem1_AWSIZE,
    output[7:0] mem1_AWLEN,
    output[1:0] mem1_AWBURST,
    output[5:0] mem1_AWID,
    output mem1_AWLOCK,
    output[3:0] mem1_AWCACHE,
    output[2:0] mem1_AWPROT,
    output[3:0] mem1_AWQOS,
    input  mem1_WREADY,
    output mem1_WVALID,
    output[63:0] mem1_WDATA,
    output[7:0] mem1_WSTRB,
    output mem1_WLAST,
    output mem1_BREADY,
    input  mem1_BVALID,
    input [5:0] mem1_BID,
    input [1:0] mem1_BRESP,
    input  mem1_ARREADY,
    output mem1_ARVALID,
    output[31:0] mem1_ARADDR,
    output[2:0] mem1_ARSIZE,
    output[7:0] mem1_ARLEN,
    output[1:0] mem1_ARBURST,
    output[5:0] mem1_ARID,
    output mem1_ARLOCK,
    output[3:0] mem1_ARCACHE,
    output[2:0] mem1_ARPROT,
    output[3:0] mem1_ARQOS,
    output mem1_RREADY,
    input  mem1_RVALID,
    input [63:0] mem1_RDATA,
    input [5:0] mem1_RID,
    input  mem1_RLAST,
    input [1:0] mem1_RRESP,
    input  mem0_AWREADY,
    output mem0_AWVALID,
    output[31:0] mem0_AWADDR,
    output[2:0] mem0_AWSIZE,
    output[7:0] mem0_AWLEN,
    output[1:0] mem0_AWBURST,
    output[5:0] mem0_AWID,
    output mem0_AWLOCK,
    output[3:0] mem0_AWCACHE,
    output[2:0] mem0_AWPROT,
    output[3:0] mem0_AWQOS,
    input  mem0_WREADY,
    output mem0_WVALID,
    output[63:0] mem0_WDATA,
    output[7:0] mem0_WSTRB,
    output mem0_WLAST,
    output mem0_BREADY,
    input  mem0_BVALID,
    input [5:0] mem0_BID,
    input [1:0] mem0_BRESP,
    input  mem0_ARREADY,
    output mem0_ARVALID,
    output[31:0] mem0_ARADDR,
    output[2:0] mem0_ARSIZE,
    output[7:0] mem0_ARLEN,
    output[1:0] mem0_ARBURST,
    output[5:0] mem0_ARID,
    output mem0_ARLOCK,
    output[3:0] mem0_ARCACHE,
    output[2:0] mem0_ARPROT,
    output[3:0] mem0_ARQOS,
    output mem0_RREADY,
    input  mem0_RVALID,
    input [63:0] mem0_RDATA,
    input [5:0] mem0_RID,
    input  mem0_RLAST,
    input [1:0] mem0_RRESP
);

  wire T44;
  reg  regWrapperReset;
  wire T45;
  wire T46;
  wire T47;
  wire T48;
  wire T49;
  wire T50;
  wire[31:0] T51;
  wire[31:0] T0;
  reg [31:0] regWrData;
  wire[31:0] T52;
  wire[31:0] T1;
  wire T2;
  wire T3;
  reg [2:0] regState;
  wire[2:0] T53;
  wire[2:0] T4;
  wire[2:0] T5;
  wire[2:0] T6;
  wire[2:0] T7;
  wire[2:0] T8;
  wire[2:0] T9;
  wire[2:0] T10;
  wire T11;
  wire T12;
  wire T13;
  wire T14;
  wire T15;
  wire T16;
  wire T17;
  wire T18;
  wire T19;
  wire T20;
  wire T21;
  wire T22;
  wire T23;
  wire T24;
  wire T25;
  reg  regModeWrite;
  wire T54;
  wire T26;
  wire T27;
  wire[2:0] T55;
  wire[31:0] T28;
  wire[31:0] T29;
  wire[31:0] T30;
  reg [31:0] regRdAddr;
  wire[31:0] T56;
  wire[31:0] T31;
  wire[31:0] T32;
  reg [31:0] regWrAddr;
  wire[31:0] T57;
  wire[31:0] T33;
  wire T34;
  wire T35;
  reg  regRdReq;
  wire T58;
  wire T36;
  wire T37;
  reg  regWrReq;
  wire T59;
  wire T38;
  wire T39;
  wire T40;
  wire[63:0] T41;
  wire T42;
  wire T43;
  wire RegFile_io_extIF_readData_valid;
  wire[31:0] RegFile_io_extIF_readData_bits;
  wire[31:0] RegFile_io_regOut_6;
  wire[31:0] RegFile_io_regOut_3;
  wire[31:0] RegFile_io_regOut_2;
  wire[31:0] RegFile_io_regOut_1;
  wire AXIMemReqAdp_io_genericReqIn_ready;
  wire AXIMemReqAdp_io_axiReqOut_valid;
  wire[31:0] AXIMemReqAdp_io_axiReqOut_bits_addr;
  wire[2:0] AXIMemReqAdp_io_axiReqOut_bits_size;
  wire[7:0] AXIMemReqAdp_io_axiReqOut_bits_len;
  wire[1:0] AXIMemReqAdp_io_axiReqOut_bits_burst;
  wire[5:0] AXIMemReqAdp_io_axiReqOut_bits_id;
  wire AXIMemReqAdp_io_axiReqOut_bits_lock;
  wire[3:0] AXIMemReqAdp_io_axiReqOut_bits_cache;
  wire[2:0] AXIMemReqAdp_io_axiReqOut_bits_prot;
  wire[3:0] AXIMemReqAdp_io_axiReqOut_bits_qos;
  wire AXIReadRspAdp_io_axiReadRspIn_ready;
  wire AXIReadRspAdp_io_genericRspOut_valid;
  wire[5:0] AXIReadRspAdp_io_genericRspOut_bits_channelID;
  wire[63:0] AXIReadRspAdp_io_genericRspOut_bits_readData;
  wire AXIReadRspAdp_io_genericRspOut_bits_isWrite;
  wire AXIReadRspAdp_io_genericRspOut_bits_isLast;
  wire AXIReadRspAdp_io_genericRspOut_bits_metaData;
  wire AXIMemReqAdp_1_io_genericReqIn_ready;
  wire AXIMemReqAdp_1_io_axiReqOut_valid;
  wire[31:0] AXIMemReqAdp_1_io_axiReqOut_bits_addr;
  wire[2:0] AXIMemReqAdp_1_io_axiReqOut_bits_size;
  wire[7:0] AXIMemReqAdp_1_io_axiReqOut_bits_len;
  wire[1:0] AXIMemReqAdp_1_io_axiReqOut_bits_burst;
  wire[5:0] AXIMemReqAdp_1_io_axiReqOut_bits_id;
  wire AXIMemReqAdp_1_io_axiReqOut_bits_lock;
  wire[3:0] AXIMemReqAdp_1_io_axiReqOut_bits_cache;
  wire[2:0] AXIMemReqAdp_1_io_axiReqOut_bits_prot;
  wire[3:0] AXIMemReqAdp_1_io_axiReqOut_bits_qos;
  wire AXIWriteBurstReqAdapter_io_in_writeAddr_ready;
  wire AXIWriteBurstReqAdapter_io_in_writeData_ready;
  wire AXIWriteBurstReqAdapter_io_out_writeAddr_valid;
  wire[31:0] AXIWriteBurstReqAdapter_io_out_writeAddr_bits_addr;
  wire[2:0] AXIWriteBurstReqAdapter_io_out_writeAddr_bits_size;
  wire[7:0] AXIWriteBurstReqAdapter_io_out_writeAddr_bits_len;
  wire[1:0] AXIWriteBurstReqAdapter_io_out_writeAddr_bits_burst;
  wire[5:0] AXIWriteBurstReqAdapter_io_out_writeAddr_bits_id;
  wire AXIWriteBurstReqAdapter_io_out_writeAddr_bits_lock;
  wire[3:0] AXIWriteBurstReqAdapter_io_out_writeAddr_bits_cache;
  wire[2:0] AXIWriteBurstReqAdapter_io_out_writeAddr_bits_prot;
  wire[3:0] AXIWriteBurstReqAdapter_io_out_writeAddr_bits_qos;
  wire AXIWriteBurstReqAdapter_io_out_writeData_valid;
  wire[63:0] AXIWriteBurstReqAdapter_io_out_writeData_bits_data;
  wire[7:0] AXIWriteBurstReqAdapter_io_out_writeData_bits_strb;
  wire AXIWriteBurstReqAdapter_io_out_writeData_bits_last;
  wire AXIWriteRspAdp_io_axiWriteRspIn_ready;
  wire AXIWriteRspAdp_io_genericRspOut_valid;
  wire[5:0] AXIWriteRspAdp_io_genericRspOut_bits_channelID;
  wire[63:0] AXIWriteRspAdp_io_genericRspOut_bits_readData;
  wire AXIWriteRspAdp_io_genericRspOut_bits_isWrite;
  wire AXIWriteRspAdp_io_genericRspOut_bits_isLast;
  wire AXIWriteRspAdp_io_genericRspOut_bits_metaData;
  wire FPGAQueue_io_enq_ready;
  wire FPGAQueue_io_deq_valid;
  wire[63:0] FPGAQueue_io_deq_bits_data;
  wire[7:0] FPGAQueue_io_deq_bits_strb;
  wire FPGAQueue_io_deq_bits_last;
  wire TestSum_io_memPort_0_memRdReq_valid;
  wire[5:0] TestSum_io_memPort_0_memRdReq_bits_channelID;
  wire TestSum_io_memPort_0_memRdReq_bits_isWrite;
  wire[31:0] TestSum_io_memPort_0_memRdReq_bits_addr;
  wire[7:0] TestSum_io_memPort_0_memRdReq_bits_numBytes;
  wire TestSum_io_memPort_0_memRdReq_bits_metaData;
  wire TestSum_io_memPort_0_memRdRsp_ready;
  wire TestSum_io_memPort_0_memWrReq_valid;
  wire[5:0] TestSum_io_memPort_0_memWrReq_bits_channelID;
  wire TestSum_io_memPort_0_memWrReq_bits_isWrite;
  wire[31:0] TestSum_io_memPort_0_memWrReq_bits_addr;
  wire[7:0] TestSum_io_memPort_0_memWrReq_bits_numBytes;
  wire TestSum_io_memPort_0_memWrReq_bits_metaData;
  wire TestSum_io_memPort_0_memWrDat_valid;
  wire[63:0] TestSum_io_memPort_0_memWrDat_bits;
  wire TestSum_io_memPort_0_memWrRsp_ready;
  wire[31:0] TestSum_io_signature;
  wire TestSum_io_finished;
  wire[31:0] TestSum_io_sum;
  wire[31:0] TestSum_io_cycleCount;

`ifndef SYNTHESIS
// synthesis translate_off
  integer initvar;
  initial begin
    #0.002;
    regWrapperReset = {1{$random}};
    regWrData = {1{$random}};
    regState = {1{$random}};
    regModeWrite = {1{$random}};
    regRdAddr = {1{$random}};
    regWrAddr = {1{$random}};
    regRdReq = {1{$random}};
    regWrReq = {1{$random}};
  end
// synthesis translate_on
`endif

  assign T44 = reset | regWrapperReset;
  assign T45 = reset ? 1'h0 : T46;
  assign T46 = T48 ? T47 : regWrapperReset;
  assign T47 = T0[0];
  assign T48 = T50 & T49;
  assign T49 = T55 == 3'h0;
  assign T50 = T34 & T24;
  assign T51 = {31'h0, TestSum_io_finished};
  assign T0 = T24 ? regWrData : 32'h0;
  assign T52 = reset ? 32'h0 : T1;
  assign T1 = T2 ? csr_WDATA : regWrData;
  assign T2 = T3 & csr_WVALID;
  assign T3 = 3'h3 == regState;
  assign T53 = reset ? 3'h0 : T4;
  assign T4 = T22 ? 3'h0 : T5;
  assign T5 = T2 ? 3'h4 : T6;
  assign T6 = T20 ? 3'h0 : T7;
  assign T7 = T18 ? 3'h3 : T8;
  assign T8 = T15 ? 3'h2 : T9;
  assign T9 = T13 ? 3'h2 : T10;
  assign T10 = T11 ? 3'h1 : regState;
  assign T11 = T12 & csr_ARVALID;
  assign T12 = 3'h0 == regState;
  assign T13 = T12 & T14;
  assign T14 = csr_ARVALID ^ 1'h1;
  assign T15 = T17 & T16;
  assign T16 = csr_RREADY & RegFile_io_extIF_readData_valid;
  assign T17 = 3'h1 == regState;
  assign T18 = T19 & csr_AWVALID;
  assign T19 = 3'h2 == regState;
  assign T20 = T19 & T21;
  assign T21 = csr_AWVALID ^ 1'h1;
  assign T22 = T23 & csr_BREADY;
  assign T23 = 3'h4 == regState;
  assign T24 = T25 ^ 1'h1;
  assign T25 = regModeWrite ^ 1'h1;
  assign T54 = reset ? 1'h0 : T26;
  assign T26 = T18 ? 1'h1 : T27;
  assign T27 = T11 ? 1'h0 : regModeWrite;
  assign T55 = T28[2:0];
  assign T28 = T24 ? T32 : T29;
  assign T29 = T25 ? T30 : 32'h0;
  assign T30 = regRdAddr / 3'h4;
  assign T56 = reset ? 32'h0 : T31;
  assign T31 = T11 ? csr_ARADDR : regRdAddr;
  assign T32 = regWrAddr / 3'h4;
  assign T57 = reset ? 32'h0 : T33;
  assign T33 = T18 ? csr_AWADDR : regWrAddr;
  assign T34 = T24 ? regWrReq : T35;
  assign T35 = T25 ? regRdReq : 1'h0;
  assign T58 = reset ? 1'h0 : T36;
  assign T36 = T15 ? 1'h0 : T37;
  assign T37 = T11 ? 1'h1 : regRdReq;
  assign T59 = reset ? 1'h0 : T38;
  assign T38 = T22 ? 1'h0 : T39;
  assign T39 = T2 ? 1'h1 : T40;
  assign T40 = T18 ? 1'h0 : regWrReq;
  assign T41 = {RegFile_io_regOut_1, RegFile_io_regOut_2};
  assign T42 = RegFile_io_regOut_6[0];
  assign mem0_RREADY = AXIReadRspAdp_io_axiReadRspIn_ready;
  assign mem0_ARQOS = AXIMemReqAdp_io_axiReqOut_bits_qos;
  assign mem0_ARPROT = AXIMemReqAdp_io_axiReqOut_bits_prot;
  assign mem0_ARCACHE = AXIMemReqAdp_io_axiReqOut_bits_cache;
  assign mem0_ARLOCK = AXIMemReqAdp_io_axiReqOut_bits_lock;
  assign mem0_ARID = AXIMemReqAdp_io_axiReqOut_bits_id;
  assign mem0_ARBURST = AXIMemReqAdp_io_axiReqOut_bits_burst;
  assign mem0_ARLEN = AXIMemReqAdp_io_axiReqOut_bits_len;
  assign mem0_ARSIZE = AXIMemReqAdp_io_axiReqOut_bits_size;
  assign mem0_ARADDR = AXIMemReqAdp_io_axiReqOut_bits_addr;
  assign mem0_ARVALID = AXIMemReqAdp_io_axiReqOut_valid;
  assign mem0_BREADY = AXIWriteRspAdp_io_axiWriteRspIn_ready;
  assign mem0_WLAST = FPGAQueue_io_deq_bits_last;
  assign mem0_WSTRB = FPGAQueue_io_deq_bits_strb;
  assign mem0_WDATA = FPGAQueue_io_deq_bits_data;
  assign mem0_WVALID = FPGAQueue_io_deq_valid;
  assign mem0_AWQOS = AXIWriteBurstReqAdapter_io_out_writeAddr_bits_qos;
  assign mem0_AWPROT = AXIWriteBurstReqAdapter_io_out_writeAddr_bits_prot;
  assign mem0_AWCACHE = AXIWriteBurstReqAdapter_io_out_writeAddr_bits_cache;
  assign mem0_AWLOCK = AXIWriteBurstReqAdapter_io_out_writeAddr_bits_lock;
  assign mem0_AWID = AXIWriteBurstReqAdapter_io_out_writeAddr_bits_id;
  assign mem0_AWBURST = AXIWriteBurstReqAdapter_io_out_writeAddr_bits_burst;
  assign mem0_AWLEN = AXIWriteBurstReqAdapter_io_out_writeAddr_bits_len;
  assign mem0_AWSIZE = AXIWriteBurstReqAdapter_io_out_writeAddr_bits_size;
  assign mem0_AWADDR = AXIWriteBurstReqAdapter_io_out_writeAddr_bits_addr;
  assign mem0_AWVALID = AXIWriteBurstReqAdapter_io_out_writeAddr_valid;
  assign mem1_RREADY = 1'h0;
  assign mem1_ARQOS = 4'h0;
  assign mem1_ARPROT = 3'h0;
  assign mem1_ARCACHE = 4'h0;
  assign mem1_ARLOCK = 1'h0;
  assign mem1_ARID = 6'h0;
  assign mem1_ARBURST = 2'h0;
  assign mem1_ARLEN = 8'h0;
  assign mem1_ARSIZE = 3'h0;
  assign mem1_ARADDR = 32'h0;
  assign mem1_ARVALID = 1'h0;
  assign mem1_BREADY = 1'h0;
  assign mem1_WLAST = 1'h0;
  assign mem1_WSTRB = 8'h0;
  assign mem1_WDATA = 64'h0;
  assign mem1_WVALID = 1'h0;
  assign mem1_AWQOS = 4'h0;
  assign mem1_AWPROT = 3'h0;
  assign mem1_AWCACHE = 4'h0;
  assign mem1_AWLOCK = 1'h0;
  assign mem1_AWID = 6'h0;
  assign mem1_AWBURST = 2'h0;
  assign mem1_AWLEN = 8'h0;
  assign mem1_AWSIZE = 3'h0;
  assign mem1_AWADDR = 32'h0;
  assign mem1_AWVALID = 1'h0;
  assign mem2_RREADY = 1'h0;
  assign mem2_ARQOS = 4'h0;
  assign mem2_ARPROT = 3'h0;
  assign mem2_ARCACHE = 4'h0;
  assign mem2_ARLOCK = 1'h0;
  assign mem2_ARID = 6'h0;
  assign mem2_ARBURST = 2'h0;
  assign mem2_ARLEN = 8'h0;
  assign mem2_ARSIZE = 3'h0;
  assign mem2_ARADDR = 32'h0;
  assign mem2_ARVALID = 1'h0;
  assign mem2_BREADY = 1'h0;
  assign mem2_WLAST = 1'h0;
  assign mem2_WSTRB = 8'h0;
  assign mem2_WDATA = 64'h0;
  assign mem2_WVALID = 1'h0;
  assign mem2_AWQOS = 4'h0;
  assign mem2_AWPROT = 3'h0;
  assign mem2_AWCACHE = 4'h0;
  assign mem2_AWLOCK = 1'h0;
  assign mem2_AWID = 6'h0;
  assign mem2_AWBURST = 2'h0;
  assign mem2_AWLEN = 8'h0;
  assign mem2_AWSIZE = 3'h0;
  assign mem2_AWADDR = 32'h0;
  assign mem2_AWVALID = 1'h0;
  assign mem3_RREADY = 1'h0;
  assign mem3_ARQOS = 4'h0;
  assign mem3_ARPROT = 3'h0;
  assign mem3_ARCACHE = 4'h0;
  assign mem3_ARLOCK = 1'h0;
  assign mem3_ARID = 6'h0;
  assign mem3_ARBURST = 2'h0;
  assign mem3_ARLEN = 8'h0;
  assign mem3_ARSIZE = 3'h0;
  assign mem3_ARADDR = 32'h0;
  assign mem3_ARVALID = 1'h0;
  assign mem3_BREADY = 1'h0;
  assign mem3_WLAST = 1'h0;
  assign mem3_WSTRB = 8'h0;
  assign mem3_WDATA = 64'h0;
  assign mem3_WVALID = 1'h0;
  assign mem3_AWQOS = 4'h0;
  assign mem3_AWPROT = 3'h0;
  assign mem3_AWCACHE = 4'h0;
  assign mem3_AWLOCK = 1'h0;
  assign mem3_AWID = 6'h0;
  assign mem3_AWBURST = 2'h0;
  assign mem3_AWLEN = 8'h0;
  assign mem3_AWSIZE = 3'h0;
  assign mem3_AWADDR = 32'h0;
  assign mem3_AWVALID = 1'h0;
  assign csr_RRESP = 2'h0;
  assign csr_RDATA = RegFile_io_extIF_readData_bits;
  assign csr_RVALID = T43;
  assign T43 = T17 ? RegFile_io_extIF_readData_valid : 1'h0;
  assign csr_ARREADY = T12;
  assign csr_BRESP = 2'h0;
  assign csr_BVALID = T23;
  assign csr_WREADY = T3;
  assign csr_AWREADY = T19;
  TestSum TestSum(.clk(clk), .reset(T44),
       .io_memPort_0_memRdReq_ready( AXIMemReqAdp_io_genericReqIn_ready ),
       .io_memPort_0_memRdReq_valid( TestSum_io_memPort_0_memRdReq_valid ),
       .io_memPort_0_memRdReq_bits_channelID( TestSum_io_memPort_0_memRdReq_bits_channelID ),
       .io_memPort_0_memRdReq_bits_isWrite( TestSum_io_memPort_0_memRdReq_bits_isWrite ),
       .io_memPort_0_memRdReq_bits_addr( TestSum_io_memPort_0_memRdReq_bits_addr ),
       .io_memPort_0_memRdReq_bits_numBytes( TestSum_io_memPort_0_memRdReq_bits_numBytes ),
       .io_memPort_0_memRdReq_bits_metaData( TestSum_io_memPort_0_memRdReq_bits_metaData ),
       .io_memPort_0_memRdRsp_ready( TestSum_io_memPort_0_memRdRsp_ready ),
       .io_memPort_0_memRdRsp_valid( AXIReadRspAdp_io_genericRspOut_valid ),
       .io_memPort_0_memRdRsp_bits_channelID( AXIReadRspAdp_io_genericRspOut_bits_channelID ),
       .io_memPort_0_memRdRsp_bits_readData( AXIReadRspAdp_io_genericRspOut_bits_readData ),
       .io_memPort_0_memRdRsp_bits_isWrite( AXIReadRspAdp_io_genericRspOut_bits_isWrite ),
       .io_memPort_0_memRdRsp_bits_isLast( AXIReadRspAdp_io_genericRspOut_bits_isLast ),
       .io_memPort_0_memRdRsp_bits_metaData( AXIReadRspAdp_io_genericRspOut_bits_metaData ),
       .io_memPort_0_memWrReq_ready( AXIMemReqAdp_1_io_genericReqIn_ready ),
       .io_memPort_0_memWrReq_valid( TestSum_io_memPort_0_memWrReq_valid ),
       .io_memPort_0_memWrReq_bits_channelID( TestSum_io_memPort_0_memWrReq_bits_channelID ),
       .io_memPort_0_memWrReq_bits_isWrite( TestSum_io_memPort_0_memWrReq_bits_isWrite ),
       .io_memPort_0_memWrReq_bits_addr( TestSum_io_memPort_0_memWrReq_bits_addr ),
       .io_memPort_0_memWrReq_bits_numBytes( TestSum_io_memPort_0_memWrReq_bits_numBytes ),
       .io_memPort_0_memWrReq_bits_metaData( TestSum_io_memPort_0_memWrReq_bits_metaData ),
       .io_memPort_0_memWrDat_ready( AXIWriteBurstReqAdapter_io_in_writeData_ready ),
       .io_memPort_0_memWrDat_valid( TestSum_io_memPort_0_memWrDat_valid ),
       .io_memPort_0_memWrDat_bits( TestSum_io_memPort_0_memWrDat_bits ),
       .io_memPort_0_memWrRsp_ready( TestSum_io_memPort_0_memWrRsp_ready ),
       .io_memPort_0_memWrRsp_valid( AXIWriteRspAdp_io_genericRspOut_valid ),
       .io_memPort_0_memWrRsp_bits_channelID( AXIWriteRspAdp_io_genericRspOut_bits_channelID ),
       .io_memPort_0_memWrRsp_bits_readData( AXIWriteRspAdp_io_genericRspOut_bits_readData ),
       .io_memPort_0_memWrRsp_bits_isWrite( AXIWriteRspAdp_io_genericRspOut_bits_isWrite ),
       .io_memPort_0_memWrRsp_bits_isLast( AXIWriteRspAdp_io_genericRspOut_bits_isLast ),
       .io_memPort_0_memWrRsp_bits_metaData( AXIWriteRspAdp_io_genericRspOut_bits_metaData ),
       .io_signature( TestSum_io_signature ),
       .io_start( T42 ),
       .io_finished( TestSum_io_finished ),
       .io_baseAddr( T41 ),
       .io_byteCount( RegFile_io_regOut_3 ),
       .io_sum( TestSum_io_sum ),
       .io_cycleCount( TestSum_io_cycleCount )
  );
  RegFile RegFile(.clk(clk), .reset(reset),
       .io_extIF_cmd_valid( T34 ),
       .io_extIF_cmd_bits_regID( T55 ),
       .io_extIF_cmd_bits_read( T25 ),
       .io_extIF_cmd_bits_write( T24 ),
       .io_extIF_cmd_bits_writeData( T0 ),
       .io_extIF_readData_valid( RegFile_io_extIF_readData_valid ),
       .io_extIF_readData_bits( RegFile_io_extIF_readData_bits ),
       //.io_extIF_regCount(  )
       //.io_regOut_7(  )
       .io_regOut_6( RegFile_io_regOut_6 ),
       //.io_regOut_5(  )
       //.io_regOut_4(  )
       .io_regOut_3( RegFile_io_regOut_3 ),
       .io_regOut_2( RegFile_io_regOut_2 ),
       .io_regOut_1( RegFile_io_regOut_1 ),
       //.io_regOut_0(  )
       .io_regIn_7_valid( 1'h1 ),
       .io_regIn_7_bits( TestSum_io_sum ),
       .io_regIn_6_valid( 1'h0 ),
       //.io_regIn_6_bits(  )
       .io_regIn_5_valid( 1'h1 ),
       .io_regIn_5_bits( T51 ),
       .io_regIn_4_valid( 1'h1 ),
       .io_regIn_4_bits( TestSum_io_cycleCount ),
       .io_regIn_3_valid( 1'h0 ),
       //.io_regIn_3_bits(  )
       .io_regIn_2_valid( 1'h0 ),
       //.io_regIn_2_bits(  )
       .io_regIn_1_valid( 1'h0 ),
       //.io_regIn_1_bits(  )
       .io_regIn_0_valid( 1'h1 ),
       .io_regIn_0_bits( TestSum_io_signature )
  );
`ifndef SYNTHESIS
// synthesis translate_off
    assign RegFile.io_regIn_6_bits = {1{$random}};
    assign RegFile.io_regIn_3_bits = {1{$random}};
    assign RegFile.io_regIn_2_bits = {1{$random}};
    assign RegFile.io_regIn_1_bits = {1{$random}};
// synthesis translate_on
`endif
  AXIMemReqAdp AXIMemReqAdp(
       .io_genericReqIn_ready( AXIMemReqAdp_io_genericReqIn_ready ),
       .io_genericReqIn_valid( TestSum_io_memPort_0_memRdReq_valid ),
       .io_genericReqIn_bits_channelID( TestSum_io_memPort_0_memRdReq_bits_channelID ),
       .io_genericReqIn_bits_isWrite( TestSum_io_memPort_0_memRdReq_bits_isWrite ),
       .io_genericReqIn_bits_addr( TestSum_io_memPort_0_memRdReq_bits_addr ),
       .io_genericReqIn_bits_numBytes( TestSum_io_memPort_0_memRdReq_bits_numBytes ),
       .io_genericReqIn_bits_metaData( TestSum_io_memPort_0_memRdReq_bits_metaData ),
       .io_axiReqOut_ready( mem0_ARREADY ),
       .io_axiReqOut_valid( AXIMemReqAdp_io_axiReqOut_valid ),
       .io_axiReqOut_bits_addr( AXIMemReqAdp_io_axiReqOut_bits_addr ),
       .io_axiReqOut_bits_size( AXIMemReqAdp_io_axiReqOut_bits_size ),
       .io_axiReqOut_bits_len( AXIMemReqAdp_io_axiReqOut_bits_len ),
       .io_axiReqOut_bits_burst( AXIMemReqAdp_io_axiReqOut_bits_burst ),
       .io_axiReqOut_bits_id( AXIMemReqAdp_io_axiReqOut_bits_id ),
       .io_axiReqOut_bits_lock( AXIMemReqAdp_io_axiReqOut_bits_lock ),
       .io_axiReqOut_bits_cache( AXIMemReqAdp_io_axiReqOut_bits_cache ),
       .io_axiReqOut_bits_prot( AXIMemReqAdp_io_axiReqOut_bits_prot ),
       .io_axiReqOut_bits_qos( AXIMemReqAdp_io_axiReqOut_bits_qos )
  );
  AXIReadRspAdp AXIReadRspAdp(
       .io_axiReadRspIn_ready( AXIReadRspAdp_io_axiReadRspIn_ready ),
       .io_axiReadRspIn_valid( mem0_RVALID ),
       .io_axiReadRspIn_bits_data( mem0_RDATA ),
       .io_axiReadRspIn_bits_id( mem0_RID ),
       .io_axiReadRspIn_bits_last( mem0_RLAST ),
       .io_axiReadRspIn_bits_resp( mem0_RRESP ),
       .io_genericRspOut_ready( TestSum_io_memPort_0_memRdRsp_ready ),
       .io_genericRspOut_valid( AXIReadRspAdp_io_genericRspOut_valid ),
       .io_genericRspOut_bits_channelID( AXIReadRspAdp_io_genericRspOut_bits_channelID ),
       .io_genericRspOut_bits_readData( AXIReadRspAdp_io_genericRspOut_bits_readData ),
       .io_genericRspOut_bits_isWrite( AXIReadRspAdp_io_genericRspOut_bits_isWrite ),
       .io_genericRspOut_bits_isLast( AXIReadRspAdp_io_genericRspOut_bits_isLast ),
       .io_genericRspOut_bits_metaData( AXIReadRspAdp_io_genericRspOut_bits_metaData )
  );
  AXIMemReqAdp AXIMemReqAdp_1(
       .io_genericReqIn_ready( AXIMemReqAdp_1_io_genericReqIn_ready ),
       .io_genericReqIn_valid( TestSum_io_memPort_0_memWrReq_valid ),
       .io_genericReqIn_bits_channelID( TestSum_io_memPort_0_memWrReq_bits_channelID ),
       .io_genericReqIn_bits_isWrite( TestSum_io_memPort_0_memWrReq_bits_isWrite ),
       .io_genericReqIn_bits_addr( TestSum_io_memPort_0_memWrReq_bits_addr ),
       .io_genericReqIn_bits_numBytes( TestSum_io_memPort_0_memWrReq_bits_numBytes ),
       .io_genericReqIn_bits_metaData( TestSum_io_memPort_0_memWrReq_bits_metaData ),
       .io_axiReqOut_ready( AXIWriteBurstReqAdapter_io_in_writeAddr_ready ),
       .io_axiReqOut_valid( AXIMemReqAdp_1_io_axiReqOut_valid ),
       .io_axiReqOut_bits_addr( AXIMemReqAdp_1_io_axiReqOut_bits_addr ),
       .io_axiReqOut_bits_size( AXIMemReqAdp_1_io_axiReqOut_bits_size ),
       .io_axiReqOut_bits_len( AXIMemReqAdp_1_io_axiReqOut_bits_len ),
       .io_axiReqOut_bits_burst( AXIMemReqAdp_1_io_axiReqOut_bits_burst ),
       .io_axiReqOut_bits_id( AXIMemReqAdp_1_io_axiReqOut_bits_id ),
       .io_axiReqOut_bits_lock( AXIMemReqAdp_1_io_axiReqOut_bits_lock ),
       .io_axiReqOut_bits_cache( AXIMemReqAdp_1_io_axiReqOut_bits_cache ),
       .io_axiReqOut_bits_prot( AXIMemReqAdp_1_io_axiReqOut_bits_prot ),
       .io_axiReqOut_bits_qos( AXIMemReqAdp_1_io_axiReqOut_bits_qos )
  );
  AXIWriteBurstReqAdapter AXIWriteBurstReqAdapter(.clk(clk), .reset(reset),
       .io_in_writeAddr_ready( AXIWriteBurstReqAdapter_io_in_writeAddr_ready ),
       .io_in_writeAddr_valid( AXIMemReqAdp_1_io_axiReqOut_valid ),
       .io_in_writeAddr_bits_addr( AXIMemReqAdp_1_io_axiReqOut_bits_addr ),
       .io_in_writeAddr_bits_size( AXIMemReqAdp_1_io_axiReqOut_bits_size ),
       .io_in_writeAddr_bits_len( AXIMemReqAdp_1_io_axiReqOut_bits_len ),
       .io_in_writeAddr_bits_burst( AXIMemReqAdp_1_io_axiReqOut_bits_burst ),
       .io_in_writeAddr_bits_id( AXIMemReqAdp_1_io_axiReqOut_bits_id ),
       .io_in_writeAddr_bits_lock( AXIMemReqAdp_1_io_axiReqOut_bits_lock ),
       .io_in_writeAddr_bits_cache( AXIMemReqAdp_1_io_axiReqOut_bits_cache ),
       .io_in_writeAddr_bits_prot( AXIMemReqAdp_1_io_axiReqOut_bits_prot ),
       .io_in_writeAddr_bits_qos( AXIMemReqAdp_1_io_axiReqOut_bits_qos ),
       .io_in_writeData_ready( AXIWriteBurstReqAdapter_io_in_writeData_ready ),
       .io_in_writeData_valid( TestSum_io_memPort_0_memWrDat_valid ),
       .io_in_writeData_bits_data( TestSum_io_memPort_0_memWrDat_bits ),
       .io_in_writeData_bits_strb( 8'hff ),
       .io_in_writeData_bits_last( 1'h0 ),
       .io_out_writeAddr_ready( mem0_AWREADY ),
       .io_out_writeAddr_valid( AXIWriteBurstReqAdapter_io_out_writeAddr_valid ),
       .io_out_writeAddr_bits_addr( AXIWriteBurstReqAdapter_io_out_writeAddr_bits_addr ),
       .io_out_writeAddr_bits_size( AXIWriteBurstReqAdapter_io_out_writeAddr_bits_size ),
       .io_out_writeAddr_bits_len( AXIWriteBurstReqAdapter_io_out_writeAddr_bits_len ),
       .io_out_writeAddr_bits_burst( AXIWriteBurstReqAdapter_io_out_writeAddr_bits_burst ),
       .io_out_writeAddr_bits_id( AXIWriteBurstReqAdapter_io_out_writeAddr_bits_id ),
       .io_out_writeAddr_bits_lock( AXIWriteBurstReqAdapter_io_out_writeAddr_bits_lock ),
       .io_out_writeAddr_bits_cache( AXIWriteBurstReqAdapter_io_out_writeAddr_bits_cache ),
       .io_out_writeAddr_bits_prot( AXIWriteBurstReqAdapter_io_out_writeAddr_bits_prot ),
       .io_out_writeAddr_bits_qos( AXIWriteBurstReqAdapter_io_out_writeAddr_bits_qos ),
       .io_out_writeData_ready( FPGAQueue_io_enq_ready ),
       .io_out_writeData_valid( AXIWriteBurstReqAdapter_io_out_writeData_valid ),
       .io_out_writeData_bits_data( AXIWriteBurstReqAdapter_io_out_writeData_bits_data ),
       .io_out_writeData_bits_strb( AXIWriteBurstReqAdapter_io_out_writeData_bits_strb ),
       .io_out_writeData_bits_last( AXIWriteBurstReqAdapter_io_out_writeData_bits_last )
  );
  FPGAQueue_0 FPGAQueue(.clk(clk), .reset(reset),
       .io_enq_ready( FPGAQueue_io_enq_ready ),
       .io_enq_valid( AXIWriteBurstReqAdapter_io_out_writeData_valid ),
       .io_enq_bits_data( AXIWriteBurstReqAdapter_io_out_writeData_bits_data ),
       .io_enq_bits_strb( AXIWriteBurstReqAdapter_io_out_writeData_bits_strb ),
       .io_enq_bits_last( AXIWriteBurstReqAdapter_io_out_writeData_bits_last ),
       .io_deq_ready( mem0_WREADY ),
       .io_deq_valid( FPGAQueue_io_deq_valid ),
       .io_deq_bits_data( FPGAQueue_io_deq_bits_data ),
       .io_deq_bits_strb( FPGAQueue_io_deq_bits_strb ),
       .io_deq_bits_last( FPGAQueue_io_deq_bits_last )
       //.io_count(  )
  );
  AXIWriteRspAdp AXIWriteRspAdp(
       .io_axiWriteRspIn_ready( AXIWriteRspAdp_io_axiWriteRspIn_ready ),
       .io_axiWriteRspIn_valid( mem0_BVALID ),
       .io_axiWriteRspIn_bits_id( mem0_BID ),
       .io_axiWriteRspIn_bits_resp( mem0_BRESP ),
       .io_genericRspOut_ready( TestSum_io_memPort_0_memWrRsp_ready ),
       .io_genericRspOut_valid( AXIWriteRspAdp_io_genericRspOut_valid ),
       .io_genericRspOut_bits_channelID( AXIWriteRspAdp_io_genericRspOut_bits_channelID ),
       .io_genericRspOut_bits_readData( AXIWriteRspAdp_io_genericRspOut_bits_readData ),
       .io_genericRspOut_bits_isWrite( AXIWriteRspAdp_io_genericRspOut_bits_isWrite ),
       .io_genericRspOut_bits_isLast( AXIWriteRspAdp_io_genericRspOut_bits_isLast ),
       .io_genericRspOut_bits_metaData( AXIWriteRspAdp_io_genericRspOut_bits_metaData )
  );

  always @(posedge clk) begin
    if(reset) begin
      regWrapperReset <= 1'h0;
    end else if(T48) begin
      regWrapperReset <= T47;
    end
    if(reset) begin
      regWrData <= 32'h0;
    end else if(T2) begin
      regWrData <= csr_WDATA;
    end
    if(reset) begin
      regState <= 3'h0;
    end else if(T22) begin
      regState <= 3'h0;
    end else if(T2) begin
      regState <= 3'h4;
    end else if(T20) begin
      regState <= 3'h0;
    end else if(T18) begin
      regState <= 3'h3;
    end else if(T15) begin
      regState <= 3'h2;
    end else if(T13) begin
      regState <= 3'h2;
    end else if(T11) begin
      regState <= 3'h1;
    end
    if(reset) begin
      regModeWrite <= 1'h0;
    end else if(T18) begin
      regModeWrite <= 1'h1;
    end else if(T11) begin
      regModeWrite <= 1'h0;
    end
    if(reset) begin
      regRdAddr <= 32'h0;
    end else if(T11) begin
      regRdAddr <= csr_ARADDR;
    end
    if(reset) begin
      regWrAddr <= 32'h0;
    end else if(T18) begin
      regWrAddr <= csr_AWADDR;
    end
    if(reset) begin
      regRdReq <= 1'h0;
    end else if(T15) begin
      regRdReq <= 1'h0;
    end else if(T11) begin
      regRdReq <= 1'h1;
    end
    if(reset) begin
      regWrReq <= 1'h0;
    end else if(T22) begin
      regWrReq <= 1'h0;
    end else if(T2) begin
      regWrReq <= 1'h1;
    end else if(T18) begin
      regWrReq <= 1'h0;
    end
  end
endmodule

