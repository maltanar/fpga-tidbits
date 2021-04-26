module Queue(
  input        clock,
  input        reset,
  output       io_enq_ready,
  input        io_enq_valid,
  input  [7:0] io_enq_bits_els_0_value,
  input  [5:0] io_enq_bits_els_0_col,
  input  [7:0] io_enq_bits_els_1_value,
  input  [5:0] io_enq_bits_els_1_col,
  input  [7:0] io_enq_bits_els_2_value,
  input  [5:0] io_enq_bits_els_2_col,
  input  [7:0] io_enq_bits_els_3_value,
  input  [5:0] io_enq_bits_els_3_col,
  input  [7:0] io_enq_bits_els_4_value,
  input  [5:0] io_enq_bits_els_4_col,
  input  [7:0] io_enq_bits_els_5_value,
  input  [5:0] io_enq_bits_els_5_col,
  input  [7:0] io_enq_bits_els_6_value,
  input  [5:0] io_enq_bits_els_6_col,
  input  [7:0] io_enq_bits_els_7_value,
  input  [5:0] io_enq_bits_els_7_col,
  input        io_deq_ready,
  output       io_deq_valid,
  output [7:0] io_deq_bits_els_0_value,
  output [5:0] io_deq_bits_els_0_col,
  output [7:0] io_deq_bits_els_1_value,
  output [5:0] io_deq_bits_els_1_col,
  output [7:0] io_deq_bits_els_2_value,
  output [5:0] io_deq_bits_els_2_col,
  output [7:0] io_deq_bits_els_3_value,
  output [5:0] io_deq_bits_els_3_col,
  output [7:0] io_deq_bits_els_4_value,
  output [5:0] io_deq_bits_els_4_col,
  output [7:0] io_deq_bits_els_5_value,
  output [5:0] io_deq_bits_els_5_col,
  output [7:0] io_deq_bits_els_6_value,
  output [5:0] io_deq_bits_els_6_col,
  output [7:0] io_deq_bits_els_7_value,
  output [5:0] io_deq_bits_els_7_col
);
`ifdef RANDOMIZE_MEM_INIT
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
  reg [31:0] _RAND_13;
  reg [31:0] _RAND_14;
  reg [31:0] _RAND_15;
`endif // RANDOMIZE_MEM_INIT
`ifdef RANDOMIZE_REG_INIT
  reg [31:0] _RAND_16;
  reg [31:0] _RAND_17;
  reg [31:0] _RAND_18;
`endif // RANDOMIZE_REG_INIT
  reg [7:0] ram_els_0_value [0:7]; // @[Decoupled.scala 218:16]
  wire [7:0] ram_els_0_value_io_deq_bits_MPORT_data; // @[Decoupled.scala 218:16]
  wire [2:0] ram_els_0_value_io_deq_bits_MPORT_addr; // @[Decoupled.scala 218:16]
  wire [7:0] ram_els_0_value_MPORT_data; // @[Decoupled.scala 218:16]
  wire [2:0] ram_els_0_value_MPORT_addr; // @[Decoupled.scala 218:16]
  wire  ram_els_0_value_MPORT_mask; // @[Decoupled.scala 218:16]
  wire  ram_els_0_value_MPORT_en; // @[Decoupled.scala 218:16]
  reg [5:0] ram_els_0_col [0:7]; // @[Decoupled.scala 218:16]
  wire [5:0] ram_els_0_col_io_deq_bits_MPORT_data; // @[Decoupled.scala 218:16]
  wire [2:0] ram_els_0_col_io_deq_bits_MPORT_addr; // @[Decoupled.scala 218:16]
  wire [5:0] ram_els_0_col_MPORT_data; // @[Decoupled.scala 218:16]
  wire [2:0] ram_els_0_col_MPORT_addr; // @[Decoupled.scala 218:16]
  wire  ram_els_0_col_MPORT_mask; // @[Decoupled.scala 218:16]
  wire  ram_els_0_col_MPORT_en; // @[Decoupled.scala 218:16]
  reg [7:0] ram_els_1_value [0:7]; // @[Decoupled.scala 218:16]
  wire [7:0] ram_els_1_value_io_deq_bits_MPORT_data; // @[Decoupled.scala 218:16]
  wire [2:0] ram_els_1_value_io_deq_bits_MPORT_addr; // @[Decoupled.scala 218:16]
  wire [7:0] ram_els_1_value_MPORT_data; // @[Decoupled.scala 218:16]
  wire [2:0] ram_els_1_value_MPORT_addr; // @[Decoupled.scala 218:16]
  wire  ram_els_1_value_MPORT_mask; // @[Decoupled.scala 218:16]
  wire  ram_els_1_value_MPORT_en; // @[Decoupled.scala 218:16]
  reg [5:0] ram_els_1_col [0:7]; // @[Decoupled.scala 218:16]
  wire [5:0] ram_els_1_col_io_deq_bits_MPORT_data; // @[Decoupled.scala 218:16]
  wire [2:0] ram_els_1_col_io_deq_bits_MPORT_addr; // @[Decoupled.scala 218:16]
  wire [5:0] ram_els_1_col_MPORT_data; // @[Decoupled.scala 218:16]
  wire [2:0] ram_els_1_col_MPORT_addr; // @[Decoupled.scala 218:16]
  wire  ram_els_1_col_MPORT_mask; // @[Decoupled.scala 218:16]
  wire  ram_els_1_col_MPORT_en; // @[Decoupled.scala 218:16]
  reg [7:0] ram_els_2_value [0:7]; // @[Decoupled.scala 218:16]
  wire [7:0] ram_els_2_value_io_deq_bits_MPORT_data; // @[Decoupled.scala 218:16]
  wire [2:0] ram_els_2_value_io_deq_bits_MPORT_addr; // @[Decoupled.scala 218:16]
  wire [7:0] ram_els_2_value_MPORT_data; // @[Decoupled.scala 218:16]
  wire [2:0] ram_els_2_value_MPORT_addr; // @[Decoupled.scala 218:16]
  wire  ram_els_2_value_MPORT_mask; // @[Decoupled.scala 218:16]
  wire  ram_els_2_value_MPORT_en; // @[Decoupled.scala 218:16]
  reg [5:0] ram_els_2_col [0:7]; // @[Decoupled.scala 218:16]
  wire [5:0] ram_els_2_col_io_deq_bits_MPORT_data; // @[Decoupled.scala 218:16]
  wire [2:0] ram_els_2_col_io_deq_bits_MPORT_addr; // @[Decoupled.scala 218:16]
  wire [5:0] ram_els_2_col_MPORT_data; // @[Decoupled.scala 218:16]
  wire [2:0] ram_els_2_col_MPORT_addr; // @[Decoupled.scala 218:16]
  wire  ram_els_2_col_MPORT_mask; // @[Decoupled.scala 218:16]
  wire  ram_els_2_col_MPORT_en; // @[Decoupled.scala 218:16]
  reg [7:0] ram_els_3_value [0:7]; // @[Decoupled.scala 218:16]
  wire [7:0] ram_els_3_value_io_deq_bits_MPORT_data; // @[Decoupled.scala 218:16]
  wire [2:0] ram_els_3_value_io_deq_bits_MPORT_addr; // @[Decoupled.scala 218:16]
  wire [7:0] ram_els_3_value_MPORT_data; // @[Decoupled.scala 218:16]
  wire [2:0] ram_els_3_value_MPORT_addr; // @[Decoupled.scala 218:16]
  wire  ram_els_3_value_MPORT_mask; // @[Decoupled.scala 218:16]
  wire  ram_els_3_value_MPORT_en; // @[Decoupled.scala 218:16]
  reg [5:0] ram_els_3_col [0:7]; // @[Decoupled.scala 218:16]
  wire [5:0] ram_els_3_col_io_deq_bits_MPORT_data; // @[Decoupled.scala 218:16]
  wire [2:0] ram_els_3_col_io_deq_bits_MPORT_addr; // @[Decoupled.scala 218:16]
  wire [5:0] ram_els_3_col_MPORT_data; // @[Decoupled.scala 218:16]
  wire [2:0] ram_els_3_col_MPORT_addr; // @[Decoupled.scala 218:16]
  wire  ram_els_3_col_MPORT_mask; // @[Decoupled.scala 218:16]
  wire  ram_els_3_col_MPORT_en; // @[Decoupled.scala 218:16]
  reg [7:0] ram_els_4_value [0:7]; // @[Decoupled.scala 218:16]
  wire [7:0] ram_els_4_value_io_deq_bits_MPORT_data; // @[Decoupled.scala 218:16]
  wire [2:0] ram_els_4_value_io_deq_bits_MPORT_addr; // @[Decoupled.scala 218:16]
  wire [7:0] ram_els_4_value_MPORT_data; // @[Decoupled.scala 218:16]
  wire [2:0] ram_els_4_value_MPORT_addr; // @[Decoupled.scala 218:16]
  wire  ram_els_4_value_MPORT_mask; // @[Decoupled.scala 218:16]
  wire  ram_els_4_value_MPORT_en; // @[Decoupled.scala 218:16]
  reg [5:0] ram_els_4_col [0:7]; // @[Decoupled.scala 218:16]
  wire [5:0] ram_els_4_col_io_deq_bits_MPORT_data; // @[Decoupled.scala 218:16]
  wire [2:0] ram_els_4_col_io_deq_bits_MPORT_addr; // @[Decoupled.scala 218:16]
  wire [5:0] ram_els_4_col_MPORT_data; // @[Decoupled.scala 218:16]
  wire [2:0] ram_els_4_col_MPORT_addr; // @[Decoupled.scala 218:16]
  wire  ram_els_4_col_MPORT_mask; // @[Decoupled.scala 218:16]
  wire  ram_els_4_col_MPORT_en; // @[Decoupled.scala 218:16]
  reg [7:0] ram_els_5_value [0:7]; // @[Decoupled.scala 218:16]
  wire [7:0] ram_els_5_value_io_deq_bits_MPORT_data; // @[Decoupled.scala 218:16]
  wire [2:0] ram_els_5_value_io_deq_bits_MPORT_addr; // @[Decoupled.scala 218:16]
  wire [7:0] ram_els_5_value_MPORT_data; // @[Decoupled.scala 218:16]
  wire [2:0] ram_els_5_value_MPORT_addr; // @[Decoupled.scala 218:16]
  wire  ram_els_5_value_MPORT_mask; // @[Decoupled.scala 218:16]
  wire  ram_els_5_value_MPORT_en; // @[Decoupled.scala 218:16]
  reg [5:0] ram_els_5_col [0:7]; // @[Decoupled.scala 218:16]
  wire [5:0] ram_els_5_col_io_deq_bits_MPORT_data; // @[Decoupled.scala 218:16]
  wire [2:0] ram_els_5_col_io_deq_bits_MPORT_addr; // @[Decoupled.scala 218:16]
  wire [5:0] ram_els_5_col_MPORT_data; // @[Decoupled.scala 218:16]
  wire [2:0] ram_els_5_col_MPORT_addr; // @[Decoupled.scala 218:16]
  wire  ram_els_5_col_MPORT_mask; // @[Decoupled.scala 218:16]
  wire  ram_els_5_col_MPORT_en; // @[Decoupled.scala 218:16]
  reg [7:0] ram_els_6_value [0:7]; // @[Decoupled.scala 218:16]
  wire [7:0] ram_els_6_value_io_deq_bits_MPORT_data; // @[Decoupled.scala 218:16]
  wire [2:0] ram_els_6_value_io_deq_bits_MPORT_addr; // @[Decoupled.scala 218:16]
  wire [7:0] ram_els_6_value_MPORT_data; // @[Decoupled.scala 218:16]
  wire [2:0] ram_els_6_value_MPORT_addr; // @[Decoupled.scala 218:16]
  wire  ram_els_6_value_MPORT_mask; // @[Decoupled.scala 218:16]
  wire  ram_els_6_value_MPORT_en; // @[Decoupled.scala 218:16]
  reg [5:0] ram_els_6_col [0:7]; // @[Decoupled.scala 218:16]
  wire [5:0] ram_els_6_col_io_deq_bits_MPORT_data; // @[Decoupled.scala 218:16]
  wire [2:0] ram_els_6_col_io_deq_bits_MPORT_addr; // @[Decoupled.scala 218:16]
  wire [5:0] ram_els_6_col_MPORT_data; // @[Decoupled.scala 218:16]
  wire [2:0] ram_els_6_col_MPORT_addr; // @[Decoupled.scala 218:16]
  wire  ram_els_6_col_MPORT_mask; // @[Decoupled.scala 218:16]
  wire  ram_els_6_col_MPORT_en; // @[Decoupled.scala 218:16]
  reg [7:0] ram_els_7_value [0:7]; // @[Decoupled.scala 218:16]
  wire [7:0] ram_els_7_value_io_deq_bits_MPORT_data; // @[Decoupled.scala 218:16]
  wire [2:0] ram_els_7_value_io_deq_bits_MPORT_addr; // @[Decoupled.scala 218:16]
  wire [7:0] ram_els_7_value_MPORT_data; // @[Decoupled.scala 218:16]
  wire [2:0] ram_els_7_value_MPORT_addr; // @[Decoupled.scala 218:16]
  wire  ram_els_7_value_MPORT_mask; // @[Decoupled.scala 218:16]
  wire  ram_els_7_value_MPORT_en; // @[Decoupled.scala 218:16]
  reg [5:0] ram_els_7_col [0:7]; // @[Decoupled.scala 218:16]
  wire [5:0] ram_els_7_col_io_deq_bits_MPORT_data; // @[Decoupled.scala 218:16]
  wire [2:0] ram_els_7_col_io_deq_bits_MPORT_addr; // @[Decoupled.scala 218:16]
  wire [5:0] ram_els_7_col_MPORT_data; // @[Decoupled.scala 218:16]
  wire [2:0] ram_els_7_col_MPORT_addr; // @[Decoupled.scala 218:16]
  wire  ram_els_7_col_MPORT_mask; // @[Decoupled.scala 218:16]
  wire  ram_els_7_col_MPORT_en; // @[Decoupled.scala 218:16]
  reg [2:0] enq_ptr_value; // @[Counter.scala 60:40]
  reg [2:0] deq_ptr_value; // @[Counter.scala 60:40]
  reg  maybe_full; // @[Decoupled.scala 221:27]
  wire  ptr_match = enq_ptr_value == deq_ptr_value; // @[Decoupled.scala 223:33]
  wire  empty = ptr_match & ~maybe_full; // @[Decoupled.scala 224:25]
  wire  full = ptr_match & maybe_full; // @[Decoupled.scala 225:24]
  wire  do_enq = io_enq_ready & io_enq_valid; // @[Decoupled.scala 40:37]
  wire  do_deq = io_deq_ready & io_deq_valid; // @[Decoupled.scala 40:37]
  wire [2:0] _value_T_1 = enq_ptr_value + 3'h1; // @[Counter.scala 76:24]
  wire [2:0] _value_T_3 = deq_ptr_value + 3'h1; // @[Counter.scala 76:24]
  assign ram_els_0_value_io_deq_bits_MPORT_addr = deq_ptr_value;
  assign ram_els_0_value_io_deq_bits_MPORT_data = ram_els_0_value[ram_els_0_value_io_deq_bits_MPORT_addr]; // @[Decoupled.scala 218:16]
  assign ram_els_0_value_MPORT_data = io_enq_bits_els_0_value;
  assign ram_els_0_value_MPORT_addr = enq_ptr_value;
  assign ram_els_0_value_MPORT_mask = 1'h1;
  assign ram_els_0_value_MPORT_en = io_enq_ready & io_enq_valid;
  assign ram_els_0_col_io_deq_bits_MPORT_addr = deq_ptr_value;
  assign ram_els_0_col_io_deq_bits_MPORT_data = ram_els_0_col[ram_els_0_col_io_deq_bits_MPORT_addr]; // @[Decoupled.scala 218:16]
  assign ram_els_0_col_MPORT_data = io_enq_bits_els_0_col;
  assign ram_els_0_col_MPORT_addr = enq_ptr_value;
  assign ram_els_0_col_MPORT_mask = 1'h1;
  assign ram_els_0_col_MPORT_en = io_enq_ready & io_enq_valid;
  assign ram_els_1_value_io_deq_bits_MPORT_addr = deq_ptr_value;
  assign ram_els_1_value_io_deq_bits_MPORT_data = ram_els_1_value[ram_els_1_value_io_deq_bits_MPORT_addr]; // @[Decoupled.scala 218:16]
  assign ram_els_1_value_MPORT_data = io_enq_bits_els_1_value;
  assign ram_els_1_value_MPORT_addr = enq_ptr_value;
  assign ram_els_1_value_MPORT_mask = 1'h1;
  assign ram_els_1_value_MPORT_en = io_enq_ready & io_enq_valid;
  assign ram_els_1_col_io_deq_bits_MPORT_addr = deq_ptr_value;
  assign ram_els_1_col_io_deq_bits_MPORT_data = ram_els_1_col[ram_els_1_col_io_deq_bits_MPORT_addr]; // @[Decoupled.scala 218:16]
  assign ram_els_1_col_MPORT_data = io_enq_bits_els_1_col;
  assign ram_els_1_col_MPORT_addr = enq_ptr_value;
  assign ram_els_1_col_MPORT_mask = 1'h1;
  assign ram_els_1_col_MPORT_en = io_enq_ready & io_enq_valid;
  assign ram_els_2_value_io_deq_bits_MPORT_addr = deq_ptr_value;
  assign ram_els_2_value_io_deq_bits_MPORT_data = ram_els_2_value[ram_els_2_value_io_deq_bits_MPORT_addr]; // @[Decoupled.scala 218:16]
  assign ram_els_2_value_MPORT_data = io_enq_bits_els_2_value;
  assign ram_els_2_value_MPORT_addr = enq_ptr_value;
  assign ram_els_2_value_MPORT_mask = 1'h1;
  assign ram_els_2_value_MPORT_en = io_enq_ready & io_enq_valid;
  assign ram_els_2_col_io_deq_bits_MPORT_addr = deq_ptr_value;
  assign ram_els_2_col_io_deq_bits_MPORT_data = ram_els_2_col[ram_els_2_col_io_deq_bits_MPORT_addr]; // @[Decoupled.scala 218:16]
  assign ram_els_2_col_MPORT_data = io_enq_bits_els_2_col;
  assign ram_els_2_col_MPORT_addr = enq_ptr_value;
  assign ram_els_2_col_MPORT_mask = 1'h1;
  assign ram_els_2_col_MPORT_en = io_enq_ready & io_enq_valid;
  assign ram_els_3_value_io_deq_bits_MPORT_addr = deq_ptr_value;
  assign ram_els_3_value_io_deq_bits_MPORT_data = ram_els_3_value[ram_els_3_value_io_deq_bits_MPORT_addr]; // @[Decoupled.scala 218:16]
  assign ram_els_3_value_MPORT_data = io_enq_bits_els_3_value;
  assign ram_els_3_value_MPORT_addr = enq_ptr_value;
  assign ram_els_3_value_MPORT_mask = 1'h1;
  assign ram_els_3_value_MPORT_en = io_enq_ready & io_enq_valid;
  assign ram_els_3_col_io_deq_bits_MPORT_addr = deq_ptr_value;
  assign ram_els_3_col_io_deq_bits_MPORT_data = ram_els_3_col[ram_els_3_col_io_deq_bits_MPORT_addr]; // @[Decoupled.scala 218:16]
  assign ram_els_3_col_MPORT_data = io_enq_bits_els_3_col;
  assign ram_els_3_col_MPORT_addr = enq_ptr_value;
  assign ram_els_3_col_MPORT_mask = 1'h1;
  assign ram_els_3_col_MPORT_en = io_enq_ready & io_enq_valid;
  assign ram_els_4_value_io_deq_bits_MPORT_addr = deq_ptr_value;
  assign ram_els_4_value_io_deq_bits_MPORT_data = ram_els_4_value[ram_els_4_value_io_deq_bits_MPORT_addr]; // @[Decoupled.scala 218:16]
  assign ram_els_4_value_MPORT_data = io_enq_bits_els_4_value;
  assign ram_els_4_value_MPORT_addr = enq_ptr_value;
  assign ram_els_4_value_MPORT_mask = 1'h1;
  assign ram_els_4_value_MPORT_en = io_enq_ready & io_enq_valid;
  assign ram_els_4_col_io_deq_bits_MPORT_addr = deq_ptr_value;
  assign ram_els_4_col_io_deq_bits_MPORT_data = ram_els_4_col[ram_els_4_col_io_deq_bits_MPORT_addr]; // @[Decoupled.scala 218:16]
  assign ram_els_4_col_MPORT_data = io_enq_bits_els_4_col;
  assign ram_els_4_col_MPORT_addr = enq_ptr_value;
  assign ram_els_4_col_MPORT_mask = 1'h1;
  assign ram_els_4_col_MPORT_en = io_enq_ready & io_enq_valid;
  assign ram_els_5_value_io_deq_bits_MPORT_addr = deq_ptr_value;
  assign ram_els_5_value_io_deq_bits_MPORT_data = ram_els_5_value[ram_els_5_value_io_deq_bits_MPORT_addr]; // @[Decoupled.scala 218:16]
  assign ram_els_5_value_MPORT_data = io_enq_bits_els_5_value;
  assign ram_els_5_value_MPORT_addr = enq_ptr_value;
  assign ram_els_5_value_MPORT_mask = 1'h1;
  assign ram_els_5_value_MPORT_en = io_enq_ready & io_enq_valid;
  assign ram_els_5_col_io_deq_bits_MPORT_addr = deq_ptr_value;
  assign ram_els_5_col_io_deq_bits_MPORT_data = ram_els_5_col[ram_els_5_col_io_deq_bits_MPORT_addr]; // @[Decoupled.scala 218:16]
  assign ram_els_5_col_MPORT_data = io_enq_bits_els_5_col;
  assign ram_els_5_col_MPORT_addr = enq_ptr_value;
  assign ram_els_5_col_MPORT_mask = 1'h1;
  assign ram_els_5_col_MPORT_en = io_enq_ready & io_enq_valid;
  assign ram_els_6_value_io_deq_bits_MPORT_addr = deq_ptr_value;
  assign ram_els_6_value_io_deq_bits_MPORT_data = ram_els_6_value[ram_els_6_value_io_deq_bits_MPORT_addr]; // @[Decoupled.scala 218:16]
  assign ram_els_6_value_MPORT_data = io_enq_bits_els_6_value;
  assign ram_els_6_value_MPORT_addr = enq_ptr_value;
  assign ram_els_6_value_MPORT_mask = 1'h1;
  assign ram_els_6_value_MPORT_en = io_enq_ready & io_enq_valid;
  assign ram_els_6_col_io_deq_bits_MPORT_addr = deq_ptr_value;
  assign ram_els_6_col_io_deq_bits_MPORT_data = ram_els_6_col[ram_els_6_col_io_deq_bits_MPORT_addr]; // @[Decoupled.scala 218:16]
  assign ram_els_6_col_MPORT_data = io_enq_bits_els_6_col;
  assign ram_els_6_col_MPORT_addr = enq_ptr_value;
  assign ram_els_6_col_MPORT_mask = 1'h1;
  assign ram_els_6_col_MPORT_en = io_enq_ready & io_enq_valid;
  assign ram_els_7_value_io_deq_bits_MPORT_addr = deq_ptr_value;
  assign ram_els_7_value_io_deq_bits_MPORT_data = ram_els_7_value[ram_els_7_value_io_deq_bits_MPORT_addr]; // @[Decoupled.scala 218:16]
  assign ram_els_7_value_MPORT_data = io_enq_bits_els_7_value;
  assign ram_els_7_value_MPORT_addr = enq_ptr_value;
  assign ram_els_7_value_MPORT_mask = 1'h1;
  assign ram_els_7_value_MPORT_en = io_enq_ready & io_enq_valid;
  assign ram_els_7_col_io_deq_bits_MPORT_addr = deq_ptr_value;
  assign ram_els_7_col_io_deq_bits_MPORT_data = ram_els_7_col[ram_els_7_col_io_deq_bits_MPORT_addr]; // @[Decoupled.scala 218:16]
  assign ram_els_7_col_MPORT_data = io_enq_bits_els_7_col;
  assign ram_els_7_col_MPORT_addr = enq_ptr_value;
  assign ram_els_7_col_MPORT_mask = 1'h1;
  assign ram_els_7_col_MPORT_en = io_enq_ready & io_enq_valid;
  assign io_enq_ready = ~full; // @[Decoupled.scala 241:19]
  assign io_deq_valid = ~empty; // @[Decoupled.scala 240:19]
  assign io_deq_bits_els_0_value = ram_els_0_value_io_deq_bits_MPORT_data; // @[Decoupled.scala 242:15]
  assign io_deq_bits_els_0_col = ram_els_0_col_io_deq_bits_MPORT_data; // @[Decoupled.scala 242:15]
  assign io_deq_bits_els_1_value = ram_els_1_value_io_deq_bits_MPORT_data; // @[Decoupled.scala 242:15]
  assign io_deq_bits_els_1_col = ram_els_1_col_io_deq_bits_MPORT_data; // @[Decoupled.scala 242:15]
  assign io_deq_bits_els_2_value = ram_els_2_value_io_deq_bits_MPORT_data; // @[Decoupled.scala 242:15]
  assign io_deq_bits_els_2_col = ram_els_2_col_io_deq_bits_MPORT_data; // @[Decoupled.scala 242:15]
  assign io_deq_bits_els_3_value = ram_els_3_value_io_deq_bits_MPORT_data; // @[Decoupled.scala 242:15]
  assign io_deq_bits_els_3_col = ram_els_3_col_io_deq_bits_MPORT_data; // @[Decoupled.scala 242:15]
  assign io_deq_bits_els_4_value = ram_els_4_value_io_deq_bits_MPORT_data; // @[Decoupled.scala 242:15]
  assign io_deq_bits_els_4_col = ram_els_4_col_io_deq_bits_MPORT_data; // @[Decoupled.scala 242:15]
  assign io_deq_bits_els_5_value = ram_els_5_value_io_deq_bits_MPORT_data; // @[Decoupled.scala 242:15]
  assign io_deq_bits_els_5_col = ram_els_5_col_io_deq_bits_MPORT_data; // @[Decoupled.scala 242:15]
  assign io_deq_bits_els_6_value = ram_els_6_value_io_deq_bits_MPORT_data; // @[Decoupled.scala 242:15]
  assign io_deq_bits_els_6_col = ram_els_6_col_io_deq_bits_MPORT_data; // @[Decoupled.scala 242:15]
  assign io_deq_bits_els_7_value = ram_els_7_value_io_deq_bits_MPORT_data; // @[Decoupled.scala 242:15]
  assign io_deq_bits_els_7_col = ram_els_7_col_io_deq_bits_MPORT_data; // @[Decoupled.scala 242:15]
  always @(posedge clock) begin
    if(ram_els_0_value_MPORT_en & ram_els_0_value_MPORT_mask) begin
      ram_els_0_value[ram_els_0_value_MPORT_addr] <= ram_els_0_value_MPORT_data; // @[Decoupled.scala 218:16]
    end
    if(ram_els_0_col_MPORT_en & ram_els_0_col_MPORT_mask) begin
      ram_els_0_col[ram_els_0_col_MPORT_addr] <= ram_els_0_col_MPORT_data; // @[Decoupled.scala 218:16]
    end
    if(ram_els_1_value_MPORT_en & ram_els_1_value_MPORT_mask) begin
      ram_els_1_value[ram_els_1_value_MPORT_addr] <= ram_els_1_value_MPORT_data; // @[Decoupled.scala 218:16]
    end
    if(ram_els_1_col_MPORT_en & ram_els_1_col_MPORT_mask) begin
      ram_els_1_col[ram_els_1_col_MPORT_addr] <= ram_els_1_col_MPORT_data; // @[Decoupled.scala 218:16]
    end
    if(ram_els_2_value_MPORT_en & ram_els_2_value_MPORT_mask) begin
      ram_els_2_value[ram_els_2_value_MPORT_addr] <= ram_els_2_value_MPORT_data; // @[Decoupled.scala 218:16]
    end
    if(ram_els_2_col_MPORT_en & ram_els_2_col_MPORT_mask) begin
      ram_els_2_col[ram_els_2_col_MPORT_addr] <= ram_els_2_col_MPORT_data; // @[Decoupled.scala 218:16]
    end
    if(ram_els_3_value_MPORT_en & ram_els_3_value_MPORT_mask) begin
      ram_els_3_value[ram_els_3_value_MPORT_addr] <= ram_els_3_value_MPORT_data; // @[Decoupled.scala 218:16]
    end
    if(ram_els_3_col_MPORT_en & ram_els_3_col_MPORT_mask) begin
      ram_els_3_col[ram_els_3_col_MPORT_addr] <= ram_els_3_col_MPORT_data; // @[Decoupled.scala 218:16]
    end
    if(ram_els_4_value_MPORT_en & ram_els_4_value_MPORT_mask) begin
      ram_els_4_value[ram_els_4_value_MPORT_addr] <= ram_els_4_value_MPORT_data; // @[Decoupled.scala 218:16]
    end
    if(ram_els_4_col_MPORT_en & ram_els_4_col_MPORT_mask) begin
      ram_els_4_col[ram_els_4_col_MPORT_addr] <= ram_els_4_col_MPORT_data; // @[Decoupled.scala 218:16]
    end
    if(ram_els_5_value_MPORT_en & ram_els_5_value_MPORT_mask) begin
      ram_els_5_value[ram_els_5_value_MPORT_addr] <= ram_els_5_value_MPORT_data; // @[Decoupled.scala 218:16]
    end
    if(ram_els_5_col_MPORT_en & ram_els_5_col_MPORT_mask) begin
      ram_els_5_col[ram_els_5_col_MPORT_addr] <= ram_els_5_col_MPORT_data; // @[Decoupled.scala 218:16]
    end
    if(ram_els_6_value_MPORT_en & ram_els_6_value_MPORT_mask) begin
      ram_els_6_value[ram_els_6_value_MPORT_addr] <= ram_els_6_value_MPORT_data; // @[Decoupled.scala 218:16]
    end
    if(ram_els_6_col_MPORT_en & ram_els_6_col_MPORT_mask) begin
      ram_els_6_col[ram_els_6_col_MPORT_addr] <= ram_els_6_col_MPORT_data; // @[Decoupled.scala 218:16]
    end
    if(ram_els_7_value_MPORT_en & ram_els_7_value_MPORT_mask) begin
      ram_els_7_value[ram_els_7_value_MPORT_addr] <= ram_els_7_value_MPORT_data; // @[Decoupled.scala 218:16]
    end
    if(ram_els_7_col_MPORT_en & ram_els_7_col_MPORT_mask) begin
      ram_els_7_col[ram_els_7_col_MPORT_addr] <= ram_els_7_col_MPORT_data; // @[Decoupled.scala 218:16]
    end
    if (reset) begin // @[Counter.scala 60:40]
      enq_ptr_value <= 3'h0; // @[Counter.scala 60:40]
    end else if (do_enq) begin // @[Decoupled.scala 229:17]
      enq_ptr_value <= _value_T_1; // @[Counter.scala 76:15]
    end
    if (reset) begin // @[Counter.scala 60:40]
      deq_ptr_value <= 3'h0; // @[Counter.scala 60:40]
    end else if (do_deq) begin // @[Decoupled.scala 233:17]
      deq_ptr_value <= _value_T_3; // @[Counter.scala 76:15]
    end
    if (reset) begin // @[Decoupled.scala 221:27]
      maybe_full <= 1'h0; // @[Decoupled.scala 221:27]
    end else if (do_enq != do_deq) begin // @[Decoupled.scala 236:28]
      maybe_full <= do_enq; // @[Decoupled.scala 237:16]
    end
  end
// Register and memory initialization
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
`ifdef RANDOMIZE_MEM_INIT
  _RAND_0 = {1{`RANDOM}};
  for (initvar = 0; initvar < 8; initvar = initvar+1)
    ram_els_0_value[initvar] = _RAND_0[7:0];
  _RAND_1 = {1{`RANDOM}};
  for (initvar = 0; initvar < 8; initvar = initvar+1)
    ram_els_0_col[initvar] = _RAND_1[5:0];
  _RAND_2 = {1{`RANDOM}};
  for (initvar = 0; initvar < 8; initvar = initvar+1)
    ram_els_1_value[initvar] = _RAND_2[7:0];
  _RAND_3 = {1{`RANDOM}};
  for (initvar = 0; initvar < 8; initvar = initvar+1)
    ram_els_1_col[initvar] = _RAND_3[5:0];
  _RAND_4 = {1{`RANDOM}};
  for (initvar = 0; initvar < 8; initvar = initvar+1)
    ram_els_2_value[initvar] = _RAND_4[7:0];
  _RAND_5 = {1{`RANDOM}};
  for (initvar = 0; initvar < 8; initvar = initvar+1)
    ram_els_2_col[initvar] = _RAND_5[5:0];
  _RAND_6 = {1{`RANDOM}};
  for (initvar = 0; initvar < 8; initvar = initvar+1)
    ram_els_3_value[initvar] = _RAND_6[7:0];
  _RAND_7 = {1{`RANDOM}};
  for (initvar = 0; initvar < 8; initvar = initvar+1)
    ram_els_3_col[initvar] = _RAND_7[5:0];
  _RAND_8 = {1{`RANDOM}};
  for (initvar = 0; initvar < 8; initvar = initvar+1)
    ram_els_4_value[initvar] = _RAND_8[7:0];
  _RAND_9 = {1{`RANDOM}};
  for (initvar = 0; initvar < 8; initvar = initvar+1)
    ram_els_4_col[initvar] = _RAND_9[5:0];
  _RAND_10 = {1{`RANDOM}};
  for (initvar = 0; initvar < 8; initvar = initvar+1)
    ram_els_5_value[initvar] = _RAND_10[7:0];
  _RAND_11 = {1{`RANDOM}};
  for (initvar = 0; initvar < 8; initvar = initvar+1)
    ram_els_5_col[initvar] = _RAND_11[5:0];
  _RAND_12 = {1{`RANDOM}};
  for (initvar = 0; initvar < 8; initvar = initvar+1)
    ram_els_6_value[initvar] = _RAND_12[7:0];
  _RAND_13 = {1{`RANDOM}};
  for (initvar = 0; initvar < 8; initvar = initvar+1)
    ram_els_6_col[initvar] = _RAND_13[5:0];
  _RAND_14 = {1{`RANDOM}};
  for (initvar = 0; initvar < 8; initvar = initvar+1)
    ram_els_7_value[initvar] = _RAND_14[7:0];
  _RAND_15 = {1{`RANDOM}};
  for (initvar = 0; initvar < 8; initvar = initvar+1)
    ram_els_7_col[initvar] = _RAND_15[5:0];
`endif // RANDOMIZE_MEM_INIT
`ifdef RANDOMIZE_REG_INIT
  _RAND_16 = {1{`RANDOM}};
  enq_ptr_value = _RAND_16[2:0];
  _RAND_17 = {1{`RANDOM}};
  deq_ptr_value = _RAND_17[2:0];
  _RAND_18 = {1{`RANDOM}};
  maybe_full = _RAND_18[0:0];
`endif // RANDOMIZE_REG_INIT
  `endif // RANDOMIZE
end // initial
`ifdef FIRRTL_AFTER_INITIAL
`FIRRTL_AFTER_INITIAL
`endif
`endif // SYNTHESIS
endmodule
module BramController(
  input          clock,
  input          reset,
  output         io_unassignedAgents_ready,
  input          io_unassignedAgents_valid,
  input  [5:0]   io_unassignedAgents_bits_agent,
  input          io_requestedAgents_ready,
  output         io_requestedAgents_valid,
  output [5:0]   io_requestedAgents_bits_agent,
  output         io_agentRowAddrReq_req_valid,
  output [5:0]   io_agentRowAddrReq_req_bits_addr,
  output         io_agentRowAddrReq_rsp_ready,
  input  [6:0]   io_agentRowAddrReq_rsp_bits_rdata_rowAddr,
  input  [5:0]   io_agentRowAddrReq_rsp_bits_rdata_length,
  output [8:0]   io_bramReq_req_addr,
  input  [119:0] io_bramReq_rsp_readData,
  input          io_dataDistOut_ready,
  output         io_dataDistOut_valid,
  output [7:0]   io_dataDistOut_bits_els_0_reward,
  output [5:0]   io_dataDistOut_bits_els_0_idx,
  output [7:0]   io_dataDistOut_bits_els_1_reward,
  output [5:0]   io_dataDistOut_bits_els_1_idx,
  output [7:0]   io_dataDistOut_bits_els_2_reward,
  output [5:0]   io_dataDistOut_bits_els_2_idx,
  output [7:0]   io_dataDistOut_bits_els_3_reward,
  output [5:0]   io_dataDistOut_bits_els_3_idx,
  output [7:0]   io_dataDistOut_bits_els_4_reward,
  output [5:0]   io_dataDistOut_bits_els_4_idx,
  output [7:0]   io_dataDistOut_bits_els_5_reward,
  output [5:0]   io_dataDistOut_bits_els_5_idx,
  output [7:0]   io_dataDistOut_bits_els_6_reward,
  output [5:0]   io_dataDistOut_bits_els_6_idx,
  output [7:0]   io_dataDistOut_bits_els_7_reward,
  output [5:0]   io_dataDistOut_bits_els_7_idx,
  output         io_dataDistOut_bits_last
);
`ifdef RANDOMIZE_REG_INIT
  reg [31:0] _RAND_0;
  reg [31:0] _RAND_1;
  reg [31:0] _RAND_2;
  reg [31:0] _RAND_3;
  reg [31:0] _RAND_4;
`endif // RANDOMIZE_REG_INIT
  wire  Queue_clock; // @[BramController.scala 77:25]
  wire  Queue_reset; // @[BramController.scala 77:25]
  wire  Queue_io_enq_ready; // @[BramController.scala 77:25]
  wire  Queue_io_enq_valid; // @[BramController.scala 77:25]
  wire [7:0] Queue_io_enq_bits_els_0_value; // @[BramController.scala 77:25]
  wire [5:0] Queue_io_enq_bits_els_0_col; // @[BramController.scala 77:25]
  wire [7:0] Queue_io_enq_bits_els_1_value; // @[BramController.scala 77:25]
  wire [5:0] Queue_io_enq_bits_els_1_col; // @[BramController.scala 77:25]
  wire [7:0] Queue_io_enq_bits_els_2_value; // @[BramController.scala 77:25]
  wire [5:0] Queue_io_enq_bits_els_2_col; // @[BramController.scala 77:25]
  wire [7:0] Queue_io_enq_bits_els_3_value; // @[BramController.scala 77:25]
  wire [5:0] Queue_io_enq_bits_els_3_col; // @[BramController.scala 77:25]
  wire [7:0] Queue_io_enq_bits_els_4_value; // @[BramController.scala 77:25]
  wire [5:0] Queue_io_enq_bits_els_4_col; // @[BramController.scala 77:25]
  wire [7:0] Queue_io_enq_bits_els_5_value; // @[BramController.scala 77:25]
  wire [5:0] Queue_io_enq_bits_els_5_col; // @[BramController.scala 77:25]
  wire [7:0] Queue_io_enq_bits_els_6_value; // @[BramController.scala 77:25]
  wire [5:0] Queue_io_enq_bits_els_6_col; // @[BramController.scala 77:25]
  wire [7:0] Queue_io_enq_bits_els_7_value; // @[BramController.scala 77:25]
  wire [5:0] Queue_io_enq_bits_els_7_col; // @[BramController.scala 77:25]
  wire  Queue_io_deq_ready; // @[BramController.scala 77:25]
  wire  Queue_io_deq_valid; // @[BramController.scala 77:25]
  wire [7:0] Queue_io_deq_bits_els_0_value; // @[BramController.scala 77:25]
  wire [5:0] Queue_io_deq_bits_els_0_col; // @[BramController.scala 77:25]
  wire [7:0] Queue_io_deq_bits_els_1_value; // @[BramController.scala 77:25]
  wire [5:0] Queue_io_deq_bits_els_1_col; // @[BramController.scala 77:25]
  wire [7:0] Queue_io_deq_bits_els_2_value; // @[BramController.scala 77:25]
  wire [5:0] Queue_io_deq_bits_els_2_col; // @[BramController.scala 77:25]
  wire [7:0] Queue_io_deq_bits_els_3_value; // @[BramController.scala 77:25]
  wire [5:0] Queue_io_deq_bits_els_3_col; // @[BramController.scala 77:25]
  wire [7:0] Queue_io_deq_bits_els_4_value; // @[BramController.scala 77:25]
  wire [5:0] Queue_io_deq_bits_els_4_col; // @[BramController.scala 77:25]
  wire [7:0] Queue_io_deq_bits_els_5_value; // @[BramController.scala 77:25]
  wire [5:0] Queue_io_deq_bits_els_5_col; // @[BramController.scala 77:25]
  wire [7:0] Queue_io_deq_bits_els_6_value; // @[BramController.scala 77:25]
  wire [5:0] Queue_io_deq_bits_els_6_col; // @[BramController.scala 77:25]
  wire [7:0] Queue_io_deq_bits_els_7_value; // @[BramController.scala 77:25]
  wire [5:0] Queue_io_deq_bits_els_7_col; // @[BramController.scala 77:25]
  reg [5:0] regNumBramWordsLeft; // @[BramController.scala 70:36]
  reg [5:0] regAgentRowAddr; // @[BramController.scala 71:32]
  reg  regBramRspValid; // @[BramController.scala 72:32]
  reg [5:0] regAgentReq_agent; // @[BramController.scala 73:28]
  reg  regState; // @[BramController.scala 83:25]
  wire  _T_16 = ~regState; // @[Conditional.scala 37:30]
  wire  _T_17 = io_unassignedAgents_ready & io_unassignedAgents_valid; // @[Decoupled.scala 40:37]
  wire [12:0] _T_18 = {io_agentRowAddrReq_rsp_bits_rdata_rowAddr,io_agentRowAddrReq_rsp_bits_rdata_length}; // @[BramController.scala 96:72]
  wire  _T_21 = _T_18[5:0] > 6'h0; // @[BramController.scala 98:36]
  wire [5:0] _GEN_0 = _T_18[5:0] > 6'h0 ? _T_18[5:0] : regNumBramWordsLeft; // @[BramController.scala 98:43 BramController.scala 100:33 BramController.scala 70:36]
  wire [6:0] _GEN_1 = _T_18[5:0] > 6'h0 ? _T_18[12:6] : {{1'd0}, regAgentRowAddr}; // @[BramController.scala 98:43 BramController.scala 101:29 BramController.scala 71:32]
  wire [6:0] _GEN_3 = _T_18[5:0] > 6'h0 ? _T_18[12:6] : 7'h0; // @[BramController.scala 98:43 BramController.scala 105:33 BramController.scala 51:22]
  wire  _GEN_5 = _T_18[5:0] > 6'h0 | regState; // @[BramController.scala 98:43 BramController.scala 109:22 BramController.scala 83:25]
  wire [6:0] _GEN_11 = _T_17 ? _GEN_1 : {{1'd0}, regAgentRowAddr}; // @[BramController.scala 89:43 BramController.scala 71:32]
  wire [6:0] _GEN_13 = _T_17 ? _GEN_3 : 7'h0; // @[BramController.scala 89:43 BramController.scala 51:22]
  wire  _GEN_14 = _T_17 & _T_21; // @[BramController.scala 89:43 BramController.scala 74:19]
  wire  _GEN_16 = Queue_io_enq_ready; // @[BramController.scala 87:34 BramController.scala 88:35 BramController.scala 47:28]
  wire  _GEN_19 = Queue_io_enq_ready & _T_17; // @[BramController.scala 87:34 BramController.scala 53:31]
  wire [6:0] _GEN_22 = Queue_io_enq_ready ? _GEN_11 : {{1'd0}, regAgentRowAddr}; // @[BramController.scala 87:34 BramController.scala 71:32]
  wire [6:0] _GEN_24 = Queue_io_enq_ready ? _GEN_13 : 7'h0; // @[BramController.scala 87:34 BramController.scala 51:22]
  wire  _GEN_25 = Queue_io_enq_ready & _GEN_14; // @[BramController.scala 87:34 BramController.scala 74:19]
  wire  _T_23 = io_dataDistOut_ready & io_requestedAgents_ready; // @[BramController.scala 116:34]
  wire  _T_24 = Queue_io_deq_ready & Queue_io_deq_valid; // @[Decoupled.scala 40:37]
  wire  _T_34 = regNumBramWordsLeft > 6'h1; // @[BramController.scala 137:36]
  wire [5:0] _T_36 = regAgentRowAddr + 6'h1; // @[BramController.scala 139:52]
  wire [5:0] _T_38 = regNumBramWordsLeft - 6'h1; // @[BramController.scala 143:56]
  wire [5:0] _GEN_28 = regNumBramWordsLeft > 6'h1 ? _T_36 : 6'h0; // @[BramController.scala 137:43 BramController.scala 139:33 BramController.scala 51:22]
  wire [5:0] _GEN_30 = regNumBramWordsLeft > 6'h1 ? _T_38 : regNumBramWordsLeft; // @[BramController.scala 137:43 BramController.scala 143:33 BramController.scala 70:36]
  wire [5:0] _GEN_31 = regNumBramWordsLeft > 6'h1 ? _T_36 : regAgentRowAddr; // @[BramController.scala 137:43 BramController.scala 144:29 BramController.scala 71:32]
  wire  _GEN_32 = regNumBramWordsLeft > 6'h1 ? 1'h0 : 1'h1; // @[BramController.scala 137:43 BramController.scala 48:27 BramController.scala 146:38]
  wire  _GEN_35 = regNumBramWordsLeft > 6'h1 & regState; // @[BramController.scala 137:43 BramController.scala 83:25 BramController.scala 148:22]
  wire [5:0] _GEN_63 = _T_24 ? _GEN_28 : 6'h0; // @[BramController.scala 118:34 BramController.scala 51:22]
  wire  _GEN_64 = _T_24 & _T_34; // @[BramController.scala 118:34 BramController.scala 74:19]
  wire [5:0] _GEN_65 = _T_24 ? _GEN_30 : regNumBramWordsLeft; // @[BramController.scala 118:34 BramController.scala 70:36]
  wire [5:0] _GEN_66 = _T_24 ? _GEN_31 : regAgentRowAddr; // @[BramController.scala 118:34 BramController.scala 71:32]
  wire  _GEN_67 = _T_24 & _GEN_32; // @[BramController.scala 118:34 BramController.scala 48:27]
  wire  _GEN_70 = _T_24 ? _GEN_35 : regState; // @[BramController.scala 118:34 BramController.scala 83:25]
  wire  _GEN_97 = io_dataDistOut_ready & io_requestedAgents_ready & _T_24; // @[BramController.scala 116:63 BramController.scala 57:23]
  wire [5:0] _GEN_99 = io_dataDistOut_ready & io_requestedAgents_ready ? _GEN_63 : 6'h0; // @[BramController.scala 116:63 BramController.scala 51:22]
  wire  _GEN_100 = io_dataDistOut_ready & io_requestedAgents_ready & _GEN_64; // @[BramController.scala 116:63 BramController.scala 74:19]
  wire [5:0] _GEN_102 = io_dataDistOut_ready & io_requestedAgents_ready ? _GEN_66 : regAgentRowAddr; // @[BramController.scala 116:63 BramController.scala 71:32]
  wire  _GEN_103 = io_dataDistOut_ready & io_requestedAgents_ready & _GEN_67; // @[BramController.scala 116:63 BramController.scala 48:27]
  wire  _GEN_107 = regState & _T_23; // @[Conditional.scala 39:67 BramController.scala 80:23]
  wire  _GEN_133 = regState & _GEN_97; // @[Conditional.scala 39:67 BramController.scala 57:23]
  wire [5:0] _GEN_135 = regState ? _GEN_99 : 6'h0; // @[Conditional.scala 39:67 BramController.scala 51:22]
  wire  _GEN_136 = regState & _GEN_100; // @[Conditional.scala 39:67 BramController.scala 74:19]
  wire [5:0] _GEN_138 = regState ? _GEN_102 : regAgentRowAddr; // @[Conditional.scala 39:67 BramController.scala 71:32]
  wire  _GEN_139 = regState & _GEN_103; // @[Conditional.scala 39:67 BramController.scala 48:27]
  wire [6:0] _GEN_149 = _T_16 ? _GEN_22 : {{1'd0}, _GEN_138}; // @[Conditional.scala 40:58]
  wire [6:0] _GEN_151 = _T_16 ? _GEN_24 : {{1'd0}, _GEN_135}; // @[Conditional.scala 40:58]
  Queue Queue ( // @[BramController.scala 77:25]
    .clock(Queue_clock),
    .reset(Queue_reset),
    .io_enq_ready(Queue_io_enq_ready),
    .io_enq_valid(Queue_io_enq_valid),
    .io_enq_bits_els_0_value(Queue_io_enq_bits_els_0_value),
    .io_enq_bits_els_0_col(Queue_io_enq_bits_els_0_col),
    .io_enq_bits_els_1_value(Queue_io_enq_bits_els_1_value),
    .io_enq_bits_els_1_col(Queue_io_enq_bits_els_1_col),
    .io_enq_bits_els_2_value(Queue_io_enq_bits_els_2_value),
    .io_enq_bits_els_2_col(Queue_io_enq_bits_els_2_col),
    .io_enq_bits_els_3_value(Queue_io_enq_bits_els_3_value),
    .io_enq_bits_els_3_col(Queue_io_enq_bits_els_3_col),
    .io_enq_bits_els_4_value(Queue_io_enq_bits_els_4_value),
    .io_enq_bits_els_4_col(Queue_io_enq_bits_els_4_col),
    .io_enq_bits_els_5_value(Queue_io_enq_bits_els_5_value),
    .io_enq_bits_els_5_col(Queue_io_enq_bits_els_5_col),
    .io_enq_bits_els_6_value(Queue_io_enq_bits_els_6_value),
    .io_enq_bits_els_6_col(Queue_io_enq_bits_els_6_col),
    .io_enq_bits_els_7_value(Queue_io_enq_bits_els_7_value),
    .io_enq_bits_els_7_col(Queue_io_enq_bits_els_7_col),
    .io_deq_ready(Queue_io_deq_ready),
    .io_deq_valid(Queue_io_deq_valid),
    .io_deq_bits_els_0_value(Queue_io_deq_bits_els_0_value),
    .io_deq_bits_els_0_col(Queue_io_deq_bits_els_0_col),
    .io_deq_bits_els_1_value(Queue_io_deq_bits_els_1_value),
    .io_deq_bits_els_1_col(Queue_io_deq_bits_els_1_col),
    .io_deq_bits_els_2_value(Queue_io_deq_bits_els_2_value),
    .io_deq_bits_els_2_col(Queue_io_deq_bits_els_2_col),
    .io_deq_bits_els_3_value(Queue_io_deq_bits_els_3_value),
    .io_deq_bits_els_3_col(Queue_io_deq_bits_els_3_col),
    .io_deq_bits_els_4_value(Queue_io_deq_bits_els_4_value),
    .io_deq_bits_els_4_col(Queue_io_deq_bits_els_4_col),
    .io_deq_bits_els_5_value(Queue_io_deq_bits_els_5_value),
    .io_deq_bits_els_5_col(Queue_io_deq_bits_els_5_col),
    .io_deq_bits_els_6_value(Queue_io_deq_bits_els_6_value),
    .io_deq_bits_els_6_col(Queue_io_deq_bits_els_6_col),
    .io_deq_bits_els_7_value(Queue_io_deq_bits_els_7_value),
    .io_deq_bits_els_7_col(Queue_io_deq_bits_els_7_col)
  );
  assign io_unassignedAgents_ready = _T_16 & _GEN_16; // @[Conditional.scala 40:58 BramController.scala 47:28]
  assign io_requestedAgents_valid = _T_16 ? 1'h0 : _GEN_139; // @[Conditional.scala 40:58 BramController.scala 48:27]
  assign io_requestedAgents_bits_agent = regAgentReq_agent; // @[BramController.scala 137:43 BramController.scala 147:37]
  assign io_agentRowAddrReq_req_valid = _T_16 & _GEN_19; // @[Conditional.scala 40:58 BramController.scala 53:31]
  assign io_agentRowAddrReq_req_bits_addr = io_unassignedAgents_bits_agent; // @[BramController.scala 89:43 BramController.scala 95:44]
  assign io_agentRowAddrReq_rsp_ready = _T_16 & _GEN_19; // @[Conditional.scala 40:58 BramController.scala 53:31]
  assign io_bramReq_req_addr = {{2'd0}, _GEN_151}; // @[Conditional.scala 40:58]
  assign io_dataDistOut_valid = _T_16 ? 1'h0 : _GEN_133; // @[Conditional.scala 40:58 BramController.scala 57:23]
  assign io_dataDistOut_bits_els_0_reward = Queue_io_deq_bits_els_0_value; // @[BramController.scala 118:34 BramController.scala 133:31]
  assign io_dataDistOut_bits_els_0_idx = Queue_io_deq_bits_els_0_col; // @[BramController.scala 118:34 BramController.scala 133:31]
  assign io_dataDistOut_bits_els_1_reward = Queue_io_deq_bits_els_1_value; // @[BramController.scala 118:34 BramController.scala 133:31]
  assign io_dataDistOut_bits_els_1_idx = Queue_io_deq_bits_els_1_col; // @[BramController.scala 118:34 BramController.scala 133:31]
  assign io_dataDistOut_bits_els_2_reward = Queue_io_deq_bits_els_2_value; // @[BramController.scala 118:34 BramController.scala 133:31]
  assign io_dataDistOut_bits_els_2_idx = Queue_io_deq_bits_els_2_col; // @[BramController.scala 118:34 BramController.scala 133:31]
  assign io_dataDistOut_bits_els_3_reward = Queue_io_deq_bits_els_3_value; // @[BramController.scala 118:34 BramController.scala 133:31]
  assign io_dataDistOut_bits_els_3_idx = Queue_io_deq_bits_els_3_col; // @[BramController.scala 118:34 BramController.scala 133:31]
  assign io_dataDistOut_bits_els_4_reward = Queue_io_deq_bits_els_4_value; // @[BramController.scala 118:34 BramController.scala 133:31]
  assign io_dataDistOut_bits_els_4_idx = Queue_io_deq_bits_els_4_col; // @[BramController.scala 118:34 BramController.scala 133:31]
  assign io_dataDistOut_bits_els_5_reward = Queue_io_deq_bits_els_5_value; // @[BramController.scala 118:34 BramController.scala 133:31]
  assign io_dataDistOut_bits_els_5_idx = Queue_io_deq_bits_els_5_col; // @[BramController.scala 118:34 BramController.scala 133:31]
  assign io_dataDistOut_bits_els_6_reward = Queue_io_deq_bits_els_6_value; // @[BramController.scala 118:34 BramController.scala 133:31]
  assign io_dataDistOut_bits_els_6_idx = Queue_io_deq_bits_els_6_col; // @[BramController.scala 118:34 BramController.scala 133:31]
  assign io_dataDistOut_bits_els_7_reward = Queue_io_deq_bits_els_7_value; // @[BramController.scala 118:34 BramController.scala 133:31]
  assign io_dataDistOut_bits_els_7_idx = Queue_io_deq_bits_els_7_col; // @[BramController.scala 118:34 BramController.scala 133:31]
  assign io_dataDistOut_bits_last = regNumBramWordsLeft == 6'h1; // @[BramController.scala 130:51]
  assign Queue_clock = clock;
  assign Queue_reset = reset;
  assign Queue_io_enq_valid = regBramRspValid; // @[BramController.scala 79:23]
  assign Queue_io_enq_bits_els_0_value = io_bramReq_rsp_readData[13:6]; // @[BramController.scala 78:57]
  assign Queue_io_enq_bits_els_0_col = io_bramReq_rsp_readData[5:0]; // @[BramController.scala 78:57]
  assign Queue_io_enq_bits_els_1_value = io_bramReq_rsp_readData[27:20]; // @[BramController.scala 78:57]
  assign Queue_io_enq_bits_els_1_col = io_bramReq_rsp_readData[19:14]; // @[BramController.scala 78:57]
  assign Queue_io_enq_bits_els_2_value = io_bramReq_rsp_readData[41:34]; // @[BramController.scala 78:57]
  assign Queue_io_enq_bits_els_2_col = io_bramReq_rsp_readData[33:28]; // @[BramController.scala 78:57]
  assign Queue_io_enq_bits_els_3_value = io_bramReq_rsp_readData[55:48]; // @[BramController.scala 78:57]
  assign Queue_io_enq_bits_els_3_col = io_bramReq_rsp_readData[47:42]; // @[BramController.scala 78:57]
  assign Queue_io_enq_bits_els_4_value = io_bramReq_rsp_readData[69:62]; // @[BramController.scala 78:57]
  assign Queue_io_enq_bits_els_4_col = io_bramReq_rsp_readData[61:56]; // @[BramController.scala 78:57]
  assign Queue_io_enq_bits_els_5_value = io_bramReq_rsp_readData[83:76]; // @[BramController.scala 78:57]
  assign Queue_io_enq_bits_els_5_col = io_bramReq_rsp_readData[75:70]; // @[BramController.scala 78:57]
  assign Queue_io_enq_bits_els_6_value = io_bramReq_rsp_readData[97:90]; // @[BramController.scala 78:57]
  assign Queue_io_enq_bits_els_6_col = io_bramReq_rsp_readData[89:84]; // @[BramController.scala 78:57]
  assign Queue_io_enq_bits_els_7_value = io_bramReq_rsp_readData[111:104]; // @[BramController.scala 78:57]
  assign Queue_io_enq_bits_els_7_col = io_bramReq_rsp_readData[103:98]; // @[BramController.scala 78:57]
  assign Queue_io_deq_ready = _T_16 ? 1'h0 : _GEN_107; // @[Conditional.scala 40:58 BramController.scala 80:23]
  always @(posedge clock) begin
    if (reset) begin // @[BramController.scala 70:36]
      regNumBramWordsLeft <= 6'h0; // @[BramController.scala 70:36]
    end else if (_T_16) begin // @[Conditional.scala 40:58]
      if (Queue_io_enq_ready) begin // @[BramController.scala 87:34]
        if (_T_17) begin // @[BramController.scala 89:43]
          regNumBramWordsLeft <= _GEN_0;
        end
      end
    end else if (regState) begin // @[Conditional.scala 39:67]
      if (io_dataDistOut_ready & io_requestedAgents_ready) begin // @[BramController.scala 116:63]
        regNumBramWordsLeft <= _GEN_65;
      end
    end
    if (reset) begin // @[BramController.scala 71:32]
      regAgentRowAddr <= 6'h0; // @[BramController.scala 71:32]
    end else begin
      regAgentRowAddr <= _GEN_149[5:0];
    end
    if (reset) begin // @[BramController.scala 72:32]
      regBramRspValid <= 1'h0; // @[BramController.scala 72:32]
    end else if (_T_16) begin // @[Conditional.scala 40:58]
      regBramRspValid <= _GEN_25;
    end else begin
      regBramRspValid <= _GEN_136;
    end
    if (reset) begin // @[BramController.scala 73:28]
      regAgentReq_agent <= 6'h0; // @[BramController.scala 73:28]
    end else if (_T_16) begin // @[Conditional.scala 40:58]
      if (Queue_io_enq_ready) begin // @[BramController.scala 87:34]
        if (_T_17) begin // @[BramController.scala 89:43]
          regAgentReq_agent <= io_unassignedAgents_bits_agent; // @[BramController.scala 91:23]
        end
      end
    end
    if (reset) begin // @[BramController.scala 83:25]
      regState <= 1'h0; // @[BramController.scala 83:25]
    end else if (_T_16) begin // @[Conditional.scala 40:58]
      if (Queue_io_enq_ready) begin // @[BramController.scala 87:34]
        if (_T_17) begin // @[BramController.scala 89:43]
          regState <= _GEN_5;
        end
      end
    end else if (regState) begin // @[Conditional.scala 39:67]
      if (io_dataDistOut_ready & io_requestedAgents_ready) begin // @[BramController.scala 116:63]
        regState <= _GEN_70;
      end
    end
  end
// Register and memory initialization
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
  regNumBramWordsLeft = _RAND_0[5:0];
  _RAND_1 = {1{`RANDOM}};
  regAgentRowAddr = _RAND_1[5:0];
  _RAND_2 = {1{`RANDOM}};
  regBramRspValid = _RAND_2[0:0];
  _RAND_3 = {1{`RANDOM}};
  regAgentReq_agent = _RAND_3[5:0];
  _RAND_4 = {1{`RANDOM}};
  regState = _RAND_4[0:0];
`endif // RANDOMIZE_REG_INIT
  `endif // RANDOMIZE
end // initial
`ifdef FIRRTL_AFTER_INITIAL
`FIRRTL_AFTER_INITIAL
`endif
`endif // SYNTHESIS
endmodule
module ControllerBram(
  input         clock,
  input         reset,
  output        io_rfCtrl_finished,
  input         io_rfInfo_start,
  input  [63:0] io_rfInfo_baseAddr,
  input  [31:0] io_rfInfo_nAgents,
  input  [31:0] io_rfInfo_nObjects,
  output        io_dram2bram_start,
  input         io_dram2bram_finished,
  output [63:0] io_dram2bram_baseAddr,
  output [5:0]  io_dram2bram_nRows,
  output [5:0]  io_dram2bram_nCols,
  output        io_unassignedAgentsIn_ready,
  input         io_unassignedAgentsIn_valid,
  input  [7:0]  io_unassignedAgentsIn_bits_agent,
  input         io_unassignedAgentsOut_ready,
  output        io_unassignedAgentsOut_valid,
  output [7:0]  io_unassignedAgentsOut_bits_agent,
  output        io_requestedAgentsIn_ready,
  input         io_requestedAgentsIn_valid,
  input  [7:0]  io_requestedAgentsIn_bits_agent,
  input         io_requestedAgentsOut_ready,
  output        io_requestedAgentsOut_valid,
  output [7:0]  io_requestedAgentsOut_bits_agent,
  output        io_doWriteBack,
  input         io_writeBackDone,
  output        io_reinit
);
`ifdef RANDOMIZE_REG_INIT
  reg [31:0] _RAND_0;
  reg [31:0] _RAND_1;
  reg [31:0] _RAND_2;
`endif // RANDOMIZE_REG_INIT
  reg [2:0] regState; // @[ControllerBram.scala 61:25]
  reg [5:0] regCount; // @[ControllerBram.scala 62:25]
  reg [3:0] regBackDownCount; // @[ControllerBram.scala 63:33]
  wire  _T = io_requestedAgentsOut_ready & io_requestedAgentsOut_valid; // @[Decoupled.scala 40:37]
  wire [3:0] _GEN_0 = _T ? 4'ha : regBackDownCount; // @[ControllerBram.scala 68:39 ControllerBram.scala 69:22 ControllerBram.scala 63:33]
  wire  _T_1 = 3'h0 == regState; // @[Conditional.scala 37:30]
  wire [31:0] _T_4 = io_rfInfo_nAgents - 32'h1; // @[ControllerBram.scala 77:39]
  wire [31:0] _GEN_2 = io_rfInfo_start ? _T_4 : {{26'd0}, regCount}; // @[ControllerBram.scala 75:41 ControllerBram.scala 77:18 ControllerBram.scala 62:25]
  wire  _T_5 = 3'h1 == regState; // @[Conditional.scala 37:30]
  wire  _GEN_3 = io_dram2bram_finished ? 1'h0 : 1'h1; // @[ControllerBram.scala 86:36 ControllerBram.scala 87:28 ControllerBram.scala 84:26]
  wire  _T_6 = 3'h2 == regState; // @[Conditional.scala 37:30]
  wire  _T_7 = io_unassignedAgentsOut_ready & io_unassignedAgentsOut_valid; // @[Decoupled.scala 40:37]
  wire [5:0] _T_10 = regCount - 6'h1; // @[ControllerBram.scala 100:32]
  wire [2:0] _GEN_5 = regCount == 6'h0 ? 3'h3 : regState; // @[ControllerBram.scala 97:33 ControllerBram.scala 98:20 ControllerBram.scala 61:25]
  wire [5:0] _GEN_6 = regCount == 6'h0 ? regCount : _T_10; // @[ControllerBram.scala 97:33 ControllerBram.scala 62:25 ControllerBram.scala 100:20]
  wire [2:0] _GEN_7 = _T_7 ? _GEN_5 : regState; // @[ControllerBram.scala 96:44 ControllerBram.scala 61:25]
  wire [5:0] _GEN_8 = _T_7 ? _GEN_6 : regCount; // @[ControllerBram.scala 96:44 ControllerBram.scala 62:25]
  wire  _T_11 = 3'h3 == regState; // @[Conditional.scala 37:30]
  wire [3:0] _T_19 = regBackDownCount - 4'h1; // @[ControllerBram.scala 114:48]
  wire [3:0] _GEN_9 = regBackDownCount > 4'h0 ? _T_19 : _GEN_0; // @[ControllerBram.scala 113:39 ControllerBram.scala 114:28]
  wire [2:0] _GEN_10 = ~io_requestedAgentsIn_valid & ~io_unassignedAgentsIn_valid & regBackDownCount == 4'h0 ? 3'h4 :
    regState; // @[ControllerBram.scala 110:102 ControllerBram.scala 111:18 ControllerBram.scala 61:25]
  wire [3:0] _GEN_11 = ~io_requestedAgentsIn_valid & ~io_unassignedAgentsIn_valid & regBackDownCount == 4'h0 ? _GEN_0 :
    _GEN_9; // @[ControllerBram.scala 110:102]
  wire  _T_20 = 3'h4 == regState; // @[Conditional.scala 37:30]
  wire [2:0] _GEN_12 = io_writeBackDone ? 3'h5 : regState; // @[ControllerBram.scala 120:31 ControllerBram.scala 121:18 ControllerBram.scala 61:25]
  wire  _T_21 = 3'h5 == regState; // @[Conditional.scala 37:30]
  wire [2:0] _GEN_14 = io_rfInfo_start ? 3'h0 : regState; // @[ControllerBram.scala 126:30 ControllerBram.scala 128:18 ControllerBram.scala 61:25]
  wire [2:0] _GEN_17 = _T_21 ? _GEN_14 : regState; // @[Conditional.scala 39:67 ControllerBram.scala 61:25]
  wire [2:0] _GEN_19 = _T_20 ? _GEN_12 : _GEN_17; // @[Conditional.scala 39:67]
  wire  _GEN_20 = _T_20 ? 1'h0 : _T_21; // @[Conditional.scala 39:67 ControllerBram.scala 42:21]
  wire  _GEN_21 = _T_20 ? 1'h0 : _T_21 & io_rfInfo_start; // @[Conditional.scala 39:67 ControllerBram.scala 44:12]
  wire  _GEN_24 = _T_11 & io_unassignedAgentsIn_valid; // @[Conditional.scala 39:67 ControllerBram.scala 107:30 ControllerBram.scala 39:31]
  wire  _GEN_25 = _T_11 & io_unassignedAgentsOut_ready; // @[Conditional.scala 39:67 ControllerBram.scala 107:30 ControllerBram.scala 38:30]
  wire [2:0] _GEN_26 = _T_11 ? _GEN_10 : _GEN_19; // @[Conditional.scala 39:67]
  wire [3:0] _GEN_27 = _T_11 ? _GEN_11 : _GEN_0; // @[Conditional.scala 39:67]
  wire  _GEN_28 = _T_11 ? 1'h0 : _T_20; // @[Conditional.scala 39:67 ControllerBram.scala 41:17]
  wire  _GEN_29 = _T_11 ? 1'h0 : _GEN_20; // @[Conditional.scala 39:67 ControllerBram.scala 42:21]
  wire  _GEN_30 = _T_11 ? 1'h0 : _GEN_21; // @[Conditional.scala 39:67 ControllerBram.scala 44:12]
  wire  _GEN_31 = _T_6 | _GEN_24; // @[Conditional.scala 39:67 ControllerBram.scala 93:36]
  wire [5:0] _GEN_35 = _T_6 ? _GEN_8 : regCount; // @[Conditional.scala 39:67 ControllerBram.scala 62:25]
  wire  _GEN_36 = _T_6 ? 1'h0 : _GEN_25; // @[Conditional.scala 39:67 ControllerBram.scala 38:30]
  wire  _GEN_38 = _T_6 ? 1'h0 : _GEN_28; // @[Conditional.scala 39:67 ControllerBram.scala 41:17]
  wire  _GEN_39 = _T_6 ? 1'h0 : _GEN_29; // @[Conditional.scala 39:67 ControllerBram.scala 42:21]
  wire  _GEN_40 = _T_6 ? 1'h0 : _GEN_30; // @[Conditional.scala 39:67 ControllerBram.scala 44:12]
  wire [63:0] _GEN_41 = _T_5 ? io_rfInfo_baseAddr : 64'h0; // @[Conditional.scala 39:67 ControllerBram.scala 81:29 ControllerBram.scala 48:24]
  wire [31:0] _GEN_42 = _T_5 ? io_rfInfo_nAgents : 32'h0; // @[Conditional.scala 39:67 ControllerBram.scala 82:26 ControllerBram.scala 47:21]
  wire [31:0] _GEN_43 = _T_5 ? io_rfInfo_nObjects : 32'h0; // @[Conditional.scala 39:67 ControllerBram.scala 83:26 ControllerBram.scala 46:21]
  wire  _GEN_44 = _T_5 & _GEN_3; // @[Conditional.scala 39:67 ControllerBram.scala 45:21]
  wire  _GEN_46 = _T_5 ? 1'h0 : _GEN_31; // @[Conditional.scala 39:67 ControllerBram.scala 39:31]
  wire [5:0] _GEN_49 = _T_5 ? regCount : _GEN_35; // @[Conditional.scala 39:67 ControllerBram.scala 62:25]
  wire  _GEN_50 = _T_5 ? 1'h0 : _GEN_36; // @[Conditional.scala 39:67 ControllerBram.scala 38:30]
  wire  _GEN_52 = _T_5 ? 1'h0 : _GEN_38; // @[Conditional.scala 39:67 ControllerBram.scala 41:17]
  wire  _GEN_53 = _T_5 ? 1'h0 : _GEN_39; // @[Conditional.scala 39:67 ControllerBram.scala 42:21]
  wire  _GEN_54 = _T_5 ? 1'h0 : _GEN_40; // @[Conditional.scala 39:67 ControllerBram.scala 44:12]
  wire [31:0] _GEN_56 = _T_1 ? _GEN_2 : {{26'd0}, _GEN_49}; // @[Conditional.scala 40:58]
  wire [31:0] _GEN_58 = _T_1 ? 32'h0 : _GEN_42; // @[Conditional.scala 40:58 ControllerBram.scala 47:21]
  wire [31:0] _GEN_59 = _T_1 ? 32'h0 : _GEN_43; // @[Conditional.scala 40:58 ControllerBram.scala 46:21]
  assign io_rfCtrl_finished = _T_1 ? 1'h0 : _GEN_53; // @[Conditional.scala 40:58 ControllerBram.scala 42:21]
  assign io_dram2bram_start = _T_1 ? 1'h0 : _GEN_44; // @[Conditional.scala 40:58 ControllerBram.scala 45:21]
  assign io_dram2bram_baseAddr = _T_1 ? 64'h0 : _GEN_41; // @[Conditional.scala 40:58 ControllerBram.scala 48:24]
  assign io_dram2bram_nRows = _GEN_58[5:0];
  assign io_dram2bram_nCols = _GEN_59[5:0];
  assign io_unassignedAgentsIn_ready = _T_1 ? 1'h0 : _GEN_50; // @[Conditional.scala 40:58 ControllerBram.scala 38:30]
  assign io_unassignedAgentsOut_valid = _T_1 ? 1'h0 : _GEN_46; // @[Conditional.scala 40:58 ControllerBram.scala 39:31]
  assign io_unassignedAgentsOut_bits_agent = _T_6 ? {{2'd0}, regCount} : io_unassignedAgentsIn_bits_agent; // @[Conditional.scala 39:67 ControllerBram.scala 94:41]
  assign io_requestedAgentsIn_ready = io_requestedAgentsOut_ready; // @[ControllerBram.scala 66:24]
  assign io_requestedAgentsOut_valid = io_requestedAgentsIn_valid; // @[ControllerBram.scala 66:24]
  assign io_requestedAgentsOut_bits_agent = io_requestedAgentsIn_bits_agent; // @[ControllerBram.scala 66:24]
  assign io_doWriteBack = _T_1 ? 1'h0 : _GEN_52; // @[Conditional.scala 40:58 ControllerBram.scala 41:17]
  assign io_reinit = _T_1 ? 1'h0 : _GEN_54; // @[Conditional.scala 40:58 ControllerBram.scala 44:12]
  always @(posedge clock) begin
    if (reset) begin // @[ControllerBram.scala 61:25]
      regState <= 3'h0; // @[ControllerBram.scala 61:25]
    end else if (_T_1) begin // @[Conditional.scala 40:58]
      if (io_rfInfo_start) begin // @[ControllerBram.scala 75:41]
        regState <= 3'h1; // @[ControllerBram.scala 76:18]
      end
    end else if (_T_5) begin // @[Conditional.scala 39:67]
      if (io_dram2bram_finished) begin // @[ControllerBram.scala 86:36]
        regState <= 3'h2; // @[ControllerBram.scala 88:18]
      end
    end else if (_T_6) begin // @[Conditional.scala 39:67]
      regState <= _GEN_7;
    end else begin
      regState <= _GEN_26;
    end
    if (reset) begin // @[ControllerBram.scala 62:25]
      regCount <= 6'h0; // @[ControllerBram.scala 62:25]
    end else begin
      regCount <= _GEN_56[5:0];
    end
    if (reset) begin // @[ControllerBram.scala 63:33]
      regBackDownCount <= 4'h0; // @[ControllerBram.scala 63:33]
    end else if (_T_1) begin // @[Conditional.scala 40:58]
      regBackDownCount <= _GEN_0;
    end else if (_T_5) begin // @[Conditional.scala 39:67]
      regBackDownCount <= _GEN_0;
    end else if (_T_6) begin // @[Conditional.scala 39:67]
      regBackDownCount <= _GEN_0;
    end else begin
      regBackDownCount <= _GEN_27;
    end
  end
// Register and memory initialization
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
  regState = _RAND_0[2:0];
  _RAND_1 = {1{`RANDOM}};
  regCount = _RAND_1[5:0];
  _RAND_2 = {1{`RANDOM}};
  regBackDownCount = _RAND_2[3:0];
`endif // RANDOMIZE_REG_INIT
  `endif // RANDOMIZE
end // initial
`ifdef FIRRTL_AFTER_INITIAL
`FIRRTL_AFTER_INITIAL
`endif
`endif // SYNTHESIS
endmodule
module AccountantExtPriceNonPipelined(
  input         clock,
  input         reset,
  output        io_searchResultIn_ready,
  input         io_searchResultIn_valid,
  input  [5:0]  io_searchResultIn_bits_winner,
  input  [7:0]  io_searchResultIn_bits_bid,
  input         io_unassignedAgents_ready,
  output        io_unassignedAgents_valid,
  output [7:0]  io_unassignedAgents_bits_agent,
  output        io_requestedAgents_ready,
  input         io_requestedAgents_valid,
  input  [7:0]  io_requestedAgents_bits_agent,
  input  [31:0] io_rfInfo_nObjects,
  input         io_doWriteBack,
  output        io_writeBackDone,
  output        io_writeBackStream_start,
  input         io_writeBackStream_wrData_ready,
  output        io_writeBackStream_wrData_valid,
  output [63:0] io_writeBackStream_wrData_bits,
  input         io_writeBackStream_finished,
  output        io_priceStore_req_valid,
  output        io_priceStore_req_bits_wen,
  output [5:0]  io_priceStore_req_bits_addr,
  output [7:0]  io_priceStore_req_bits_wdata,
  input         io_priceStore_rsp_valid,
  input  [7:0]  io_priceStore_rsp_bits_rdata,
  output        io_notifyPEsContinue
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
  reg [31:0] _RAND_13;
  reg [31:0] _RAND_14;
  reg [31:0] _RAND_15;
  reg [31:0] _RAND_16;
  reg [31:0] _RAND_17;
  reg [31:0] _RAND_18;
  reg [31:0] _RAND_19;
  reg [31:0] _RAND_20;
  reg [31:0] _RAND_21;
  reg [31:0] _RAND_22;
  reg [31:0] _RAND_23;
  reg [31:0] _RAND_24;
  reg [31:0] _RAND_25;
  reg [31:0] _RAND_26;
  reg [31:0] _RAND_27;
  reg [31:0] _RAND_28;
  reg [31:0] _RAND_29;
  reg [31:0] _RAND_30;
  reg [31:0] _RAND_31;
  reg [31:0] _RAND_32;
  reg [31:0] _RAND_33;
  reg [31:0] _RAND_34;
  reg [31:0] _RAND_35;
  reg [31:0] _RAND_36;
  reg [31:0] _RAND_37;
  reg [31:0] _RAND_38;
  reg [31:0] _RAND_39;
  reg [31:0] _RAND_40;
  reg [31:0] _RAND_41;
  reg [31:0] _RAND_42;
  reg [31:0] _RAND_43;
  reg [31:0] _RAND_44;
  reg [31:0] _RAND_45;
  reg [31:0] _RAND_46;
  reg [31:0] _RAND_47;
  reg [31:0] _RAND_48;
  reg [31:0] _RAND_49;
  reg [31:0] _RAND_50;
  reg [31:0] _RAND_51;
  reg [31:0] _RAND_52;
  reg [31:0] _RAND_53;
  reg [31:0] _RAND_54;
  reg [31:0] _RAND_55;
  reg [31:0] _RAND_56;
  reg [31:0] _RAND_57;
  reg [31:0] _RAND_58;
  reg [31:0] _RAND_59;
  reg [31:0] _RAND_60;
  reg [31:0] _RAND_61;
  reg [31:0] _RAND_62;
  reg [31:0] _RAND_63;
  reg [31:0] _RAND_64;
  reg [31:0] _RAND_65;
  reg [31:0] _RAND_66;
  reg [31:0] _RAND_67;
  reg [31:0] _RAND_68;
  reg [31:0] _RAND_69;
  reg [31:0] _RAND_70;
  reg [31:0] _RAND_71;
  reg [31:0] _RAND_72;
  reg [31:0] _RAND_73;
  reg [31:0] _RAND_74;
  reg [31:0] _RAND_75;
  reg [31:0] _RAND_76;
  reg [31:0] _RAND_77;
  reg [31:0] _RAND_78;
  reg [31:0] _RAND_79;
  reg [31:0] _RAND_80;
  reg [31:0] _RAND_81;
  reg [31:0] _RAND_82;
  reg [31:0] _RAND_83;
  reg [31:0] _RAND_84;
  reg [31:0] _RAND_85;
  reg [31:0] _RAND_86;
  reg [31:0] _RAND_87;
  reg [31:0] _RAND_88;
  reg [31:0] _RAND_89;
  reg [31:0] _RAND_90;
  reg [31:0] _RAND_91;
  reg [31:0] _RAND_92;
  reg [31:0] _RAND_93;
  reg [31:0] _RAND_94;
  reg [31:0] _RAND_95;
  reg [31:0] _RAND_96;
  reg [31:0] _RAND_97;
  reg [31:0] _RAND_98;
  reg [31:0] _RAND_99;
  reg [31:0] _RAND_100;
  reg [31:0] _RAND_101;
  reg [31:0] _RAND_102;
  reg [31:0] _RAND_103;
  reg [31:0] _RAND_104;
  reg [31:0] _RAND_105;
  reg [31:0] _RAND_106;
  reg [31:0] _RAND_107;
  reg [31:0] _RAND_108;
  reg [31:0] _RAND_109;
  reg [31:0] _RAND_110;
  reg [31:0] _RAND_111;
  reg [31:0] _RAND_112;
  reg [31:0] _RAND_113;
  reg [31:0] _RAND_114;
  reg [31:0] _RAND_115;
  reg [31:0] _RAND_116;
  reg [31:0] _RAND_117;
  reg [31:0] _RAND_118;
  reg [31:0] _RAND_119;
  reg [31:0] _RAND_120;
  reg [31:0] _RAND_121;
  reg [31:0] _RAND_122;
  reg [31:0] _RAND_123;
  reg [31:0] _RAND_124;
  reg [31:0] _RAND_125;
  reg [31:0] _RAND_126;
  reg [31:0] _RAND_127;
  reg [31:0] _RAND_128;
  reg [31:0] _RAND_129;
  reg [31:0] _RAND_130;
  reg [31:0] _RAND_131;
  reg [31:0] _RAND_132;
  reg [63:0] _RAND_133;
`endif // RANDOMIZE_REG_INIT
  reg [5:0] regAssignments_0_agent; // @[AccountantExtPrice.scala 53:31]
  reg  regAssignments_0_valid; // @[AccountantExtPrice.scala 53:31]
  reg [5:0] regAssignments_1_agent; // @[AccountantExtPrice.scala 53:31]
  reg  regAssignments_1_valid; // @[AccountantExtPrice.scala 53:31]
  reg [5:0] regAssignments_2_agent; // @[AccountantExtPrice.scala 53:31]
  reg  regAssignments_2_valid; // @[AccountantExtPrice.scala 53:31]
  reg [5:0] regAssignments_3_agent; // @[AccountantExtPrice.scala 53:31]
  reg  regAssignments_3_valid; // @[AccountantExtPrice.scala 53:31]
  reg [5:0] regAssignments_4_agent; // @[AccountantExtPrice.scala 53:31]
  reg  regAssignments_4_valid; // @[AccountantExtPrice.scala 53:31]
  reg [5:0] regAssignments_5_agent; // @[AccountantExtPrice.scala 53:31]
  reg  regAssignments_5_valid; // @[AccountantExtPrice.scala 53:31]
  reg [5:0] regAssignments_6_agent; // @[AccountantExtPrice.scala 53:31]
  reg  regAssignments_6_valid; // @[AccountantExtPrice.scala 53:31]
  reg [5:0] regAssignments_7_agent; // @[AccountantExtPrice.scala 53:31]
  reg  regAssignments_7_valid; // @[AccountantExtPrice.scala 53:31]
  reg [5:0] regAssignments_8_agent; // @[AccountantExtPrice.scala 53:31]
  reg  regAssignments_8_valid; // @[AccountantExtPrice.scala 53:31]
  reg [5:0] regAssignments_9_agent; // @[AccountantExtPrice.scala 53:31]
  reg  regAssignments_9_valid; // @[AccountantExtPrice.scala 53:31]
  reg [5:0] regAssignments_10_agent; // @[AccountantExtPrice.scala 53:31]
  reg  regAssignments_10_valid; // @[AccountantExtPrice.scala 53:31]
  reg [5:0] regAssignments_11_agent; // @[AccountantExtPrice.scala 53:31]
  reg  regAssignments_11_valid; // @[AccountantExtPrice.scala 53:31]
  reg [5:0] regAssignments_12_agent; // @[AccountantExtPrice.scala 53:31]
  reg  regAssignments_12_valid; // @[AccountantExtPrice.scala 53:31]
  reg [5:0] regAssignments_13_agent; // @[AccountantExtPrice.scala 53:31]
  reg  regAssignments_13_valid; // @[AccountantExtPrice.scala 53:31]
  reg [5:0] regAssignments_14_agent; // @[AccountantExtPrice.scala 53:31]
  reg  regAssignments_14_valid; // @[AccountantExtPrice.scala 53:31]
  reg [5:0] regAssignments_15_agent; // @[AccountantExtPrice.scala 53:31]
  reg  regAssignments_15_valid; // @[AccountantExtPrice.scala 53:31]
  reg [5:0] regAssignments_16_agent; // @[AccountantExtPrice.scala 53:31]
  reg  regAssignments_16_valid; // @[AccountantExtPrice.scala 53:31]
  reg [5:0] regAssignments_17_agent; // @[AccountantExtPrice.scala 53:31]
  reg  regAssignments_17_valid; // @[AccountantExtPrice.scala 53:31]
  reg [5:0] regAssignments_18_agent; // @[AccountantExtPrice.scala 53:31]
  reg  regAssignments_18_valid; // @[AccountantExtPrice.scala 53:31]
  reg [5:0] regAssignments_19_agent; // @[AccountantExtPrice.scala 53:31]
  reg  regAssignments_19_valid; // @[AccountantExtPrice.scala 53:31]
  reg [5:0] regAssignments_20_agent; // @[AccountantExtPrice.scala 53:31]
  reg  regAssignments_20_valid; // @[AccountantExtPrice.scala 53:31]
  reg [5:0] regAssignments_21_agent; // @[AccountantExtPrice.scala 53:31]
  reg  regAssignments_21_valid; // @[AccountantExtPrice.scala 53:31]
  reg [5:0] regAssignments_22_agent; // @[AccountantExtPrice.scala 53:31]
  reg  regAssignments_22_valid; // @[AccountantExtPrice.scala 53:31]
  reg [5:0] regAssignments_23_agent; // @[AccountantExtPrice.scala 53:31]
  reg  regAssignments_23_valid; // @[AccountantExtPrice.scala 53:31]
  reg [5:0] regAssignments_24_agent; // @[AccountantExtPrice.scala 53:31]
  reg  regAssignments_24_valid; // @[AccountantExtPrice.scala 53:31]
  reg [5:0] regAssignments_25_agent; // @[AccountantExtPrice.scala 53:31]
  reg  regAssignments_25_valid; // @[AccountantExtPrice.scala 53:31]
  reg [5:0] regAssignments_26_agent; // @[AccountantExtPrice.scala 53:31]
  reg  regAssignments_26_valid; // @[AccountantExtPrice.scala 53:31]
  reg [5:0] regAssignments_27_agent; // @[AccountantExtPrice.scala 53:31]
  reg  regAssignments_27_valid; // @[AccountantExtPrice.scala 53:31]
  reg [5:0] regAssignments_28_agent; // @[AccountantExtPrice.scala 53:31]
  reg  regAssignments_28_valid; // @[AccountantExtPrice.scala 53:31]
  reg [5:0] regAssignments_29_agent; // @[AccountantExtPrice.scala 53:31]
  reg  regAssignments_29_valid; // @[AccountantExtPrice.scala 53:31]
  reg [5:0] regAssignments_30_agent; // @[AccountantExtPrice.scala 53:31]
  reg  regAssignments_30_valid; // @[AccountantExtPrice.scala 53:31]
  reg [5:0] regAssignments_31_agent; // @[AccountantExtPrice.scala 53:31]
  reg  regAssignments_31_valid; // @[AccountantExtPrice.scala 53:31]
  reg [5:0] regAssignments_32_agent; // @[AccountantExtPrice.scala 53:31]
  reg  regAssignments_32_valid; // @[AccountantExtPrice.scala 53:31]
  reg [5:0] regAssignments_33_agent; // @[AccountantExtPrice.scala 53:31]
  reg  regAssignments_33_valid; // @[AccountantExtPrice.scala 53:31]
  reg [5:0] regAssignments_34_agent; // @[AccountantExtPrice.scala 53:31]
  reg  regAssignments_34_valid; // @[AccountantExtPrice.scala 53:31]
  reg [5:0] regAssignments_35_agent; // @[AccountantExtPrice.scala 53:31]
  reg  regAssignments_35_valid; // @[AccountantExtPrice.scala 53:31]
  reg [5:0] regAssignments_36_agent; // @[AccountantExtPrice.scala 53:31]
  reg  regAssignments_36_valid; // @[AccountantExtPrice.scala 53:31]
  reg [5:0] regAssignments_37_agent; // @[AccountantExtPrice.scala 53:31]
  reg  regAssignments_37_valid; // @[AccountantExtPrice.scala 53:31]
  reg [5:0] regAssignments_38_agent; // @[AccountantExtPrice.scala 53:31]
  reg  regAssignments_38_valid; // @[AccountantExtPrice.scala 53:31]
  reg [5:0] regAssignments_39_agent; // @[AccountantExtPrice.scala 53:31]
  reg  regAssignments_39_valid; // @[AccountantExtPrice.scala 53:31]
  reg [5:0] regAssignments_40_agent; // @[AccountantExtPrice.scala 53:31]
  reg  regAssignments_40_valid; // @[AccountantExtPrice.scala 53:31]
  reg [5:0] regAssignments_41_agent; // @[AccountantExtPrice.scala 53:31]
  reg  regAssignments_41_valid; // @[AccountantExtPrice.scala 53:31]
  reg [5:0] regAssignments_42_agent; // @[AccountantExtPrice.scala 53:31]
  reg  regAssignments_42_valid; // @[AccountantExtPrice.scala 53:31]
  reg [5:0] regAssignments_43_agent; // @[AccountantExtPrice.scala 53:31]
  reg  regAssignments_43_valid; // @[AccountantExtPrice.scala 53:31]
  reg [5:0] regAssignments_44_agent; // @[AccountantExtPrice.scala 53:31]
  reg  regAssignments_44_valid; // @[AccountantExtPrice.scala 53:31]
  reg [5:0] regAssignments_45_agent; // @[AccountantExtPrice.scala 53:31]
  reg  regAssignments_45_valid; // @[AccountantExtPrice.scala 53:31]
  reg [5:0] regAssignments_46_agent; // @[AccountantExtPrice.scala 53:31]
  reg  regAssignments_46_valid; // @[AccountantExtPrice.scala 53:31]
  reg [5:0] regAssignments_47_agent; // @[AccountantExtPrice.scala 53:31]
  reg  regAssignments_47_valid; // @[AccountantExtPrice.scala 53:31]
  reg [5:0] regAssignments_48_agent; // @[AccountantExtPrice.scala 53:31]
  reg  regAssignments_48_valid; // @[AccountantExtPrice.scala 53:31]
  reg [5:0] regAssignments_49_agent; // @[AccountantExtPrice.scala 53:31]
  reg  regAssignments_49_valid; // @[AccountantExtPrice.scala 53:31]
  reg [5:0] regAssignments_50_agent; // @[AccountantExtPrice.scala 53:31]
  reg  regAssignments_50_valid; // @[AccountantExtPrice.scala 53:31]
  reg [5:0] regAssignments_51_agent; // @[AccountantExtPrice.scala 53:31]
  reg  regAssignments_51_valid; // @[AccountantExtPrice.scala 53:31]
  reg [5:0] regAssignments_52_agent; // @[AccountantExtPrice.scala 53:31]
  reg  regAssignments_52_valid; // @[AccountantExtPrice.scala 53:31]
  reg [5:0] regAssignments_53_agent; // @[AccountantExtPrice.scala 53:31]
  reg  regAssignments_53_valid; // @[AccountantExtPrice.scala 53:31]
  reg [5:0] regAssignments_54_agent; // @[AccountantExtPrice.scala 53:31]
  reg  regAssignments_54_valid; // @[AccountantExtPrice.scala 53:31]
  reg [5:0] regAssignments_55_agent; // @[AccountantExtPrice.scala 53:31]
  reg  regAssignments_55_valid; // @[AccountantExtPrice.scala 53:31]
  reg [5:0] regAssignments_56_agent; // @[AccountantExtPrice.scala 53:31]
  reg  regAssignments_56_valid; // @[AccountantExtPrice.scala 53:31]
  reg [5:0] regAssignments_57_agent; // @[AccountantExtPrice.scala 53:31]
  reg  regAssignments_57_valid; // @[AccountantExtPrice.scala 53:31]
  reg [5:0] regAssignments_58_agent; // @[AccountantExtPrice.scala 53:31]
  reg  regAssignments_58_valid; // @[AccountantExtPrice.scala 53:31]
  reg [5:0] regAssignments_59_agent; // @[AccountantExtPrice.scala 53:31]
  reg  regAssignments_59_valid; // @[AccountantExtPrice.scala 53:31]
  reg [5:0] regAssignments_60_agent; // @[AccountantExtPrice.scala 53:31]
  reg  regAssignments_60_valid; // @[AccountantExtPrice.scala 53:31]
  reg [5:0] regAssignments_61_agent; // @[AccountantExtPrice.scala 53:31]
  reg  regAssignments_61_valid; // @[AccountantExtPrice.scala 53:31]
  reg [5:0] regAssignments_62_agent; // @[AccountantExtPrice.scala 53:31]
  reg  regAssignments_62_valid; // @[AccountantExtPrice.scala 53:31]
  reg [5:0] regAssignments_63_agent; // @[AccountantExtPrice.scala 53:31]
  reg  regAssignments_63_valid; // @[AccountantExtPrice.scala 53:31]
  reg [7:0] regCurrentAgent; // @[AccountantExtPrice.scala 54:32]
  reg [5:0] regObject; // @[AccountantExtPrice.scala 56:26]
  reg [7:0] regBid; // @[AccountantExtPrice.scala 57:23]
  reg [7:0] regCurrentPrice; // @[AccountantExtPrice.scala 58:32]
  reg [2:0] regState; // @[AccountantExtPrice.scala 62:25]
  reg [63:0] regWBCount; // @[AccountantExtPrice.scala 64:27]
  wire  _T = 3'h0 == regState; // @[Conditional.scala 37:30]
  wire  _T_1 = io_searchResultIn_ready & io_searchResultIn_valid; // @[Decoupled.scala 40:37]
  wire  _T_10 = 3'h1 == regState; // @[Conditional.scala 37:30]
  wire  _T_11 = regBid > 8'h0; // @[AccountantExtPrice.scala 90:20]
  wire [5:0] _GEN_11 = 6'h1 == regObject ? regAssignments_1_agent : regAssignments_0_agent; // @[AccountantExtPrice.scala 93:35 AccountantExtPrice.scala 93:35]
  wire  _GEN_12 = 6'h1 == regObject ? regAssignments_1_valid : regAssignments_0_valid; // @[AccountantExtPrice.scala 93:35 AccountantExtPrice.scala 93:35]
  wire [5:0] _GEN_13 = 6'h2 == regObject ? regAssignments_2_agent : _GEN_11; // @[AccountantExtPrice.scala 93:35 AccountantExtPrice.scala 93:35]
  wire  _GEN_14 = 6'h2 == regObject ? regAssignments_2_valid : _GEN_12; // @[AccountantExtPrice.scala 93:35 AccountantExtPrice.scala 93:35]
  wire [5:0] _GEN_15 = 6'h3 == regObject ? regAssignments_3_agent : _GEN_13; // @[AccountantExtPrice.scala 93:35 AccountantExtPrice.scala 93:35]
  wire  _GEN_16 = 6'h3 == regObject ? regAssignments_3_valid : _GEN_14; // @[AccountantExtPrice.scala 93:35 AccountantExtPrice.scala 93:35]
  wire [5:0] _GEN_17 = 6'h4 == regObject ? regAssignments_4_agent : _GEN_15; // @[AccountantExtPrice.scala 93:35 AccountantExtPrice.scala 93:35]
  wire  _GEN_18 = 6'h4 == regObject ? regAssignments_4_valid : _GEN_16; // @[AccountantExtPrice.scala 93:35 AccountantExtPrice.scala 93:35]
  wire [5:0] _GEN_19 = 6'h5 == regObject ? regAssignments_5_agent : _GEN_17; // @[AccountantExtPrice.scala 93:35 AccountantExtPrice.scala 93:35]
  wire  _GEN_20 = 6'h5 == regObject ? regAssignments_5_valid : _GEN_18; // @[AccountantExtPrice.scala 93:35 AccountantExtPrice.scala 93:35]
  wire [5:0] _GEN_21 = 6'h6 == regObject ? regAssignments_6_agent : _GEN_19; // @[AccountantExtPrice.scala 93:35 AccountantExtPrice.scala 93:35]
  wire  _GEN_22 = 6'h6 == regObject ? regAssignments_6_valid : _GEN_20; // @[AccountantExtPrice.scala 93:35 AccountantExtPrice.scala 93:35]
  wire [5:0] _GEN_23 = 6'h7 == regObject ? regAssignments_7_agent : _GEN_21; // @[AccountantExtPrice.scala 93:35 AccountantExtPrice.scala 93:35]
  wire  _GEN_24 = 6'h7 == regObject ? regAssignments_7_valid : _GEN_22; // @[AccountantExtPrice.scala 93:35 AccountantExtPrice.scala 93:35]
  wire [5:0] _GEN_25 = 6'h8 == regObject ? regAssignments_8_agent : _GEN_23; // @[AccountantExtPrice.scala 93:35 AccountantExtPrice.scala 93:35]
  wire  _GEN_26 = 6'h8 == regObject ? regAssignments_8_valid : _GEN_24; // @[AccountantExtPrice.scala 93:35 AccountantExtPrice.scala 93:35]
  wire [5:0] _GEN_27 = 6'h9 == regObject ? regAssignments_9_agent : _GEN_25; // @[AccountantExtPrice.scala 93:35 AccountantExtPrice.scala 93:35]
  wire  _GEN_28 = 6'h9 == regObject ? regAssignments_9_valid : _GEN_26; // @[AccountantExtPrice.scala 93:35 AccountantExtPrice.scala 93:35]
  wire [5:0] _GEN_29 = 6'ha == regObject ? regAssignments_10_agent : _GEN_27; // @[AccountantExtPrice.scala 93:35 AccountantExtPrice.scala 93:35]
  wire  _GEN_30 = 6'ha == regObject ? regAssignments_10_valid : _GEN_28; // @[AccountantExtPrice.scala 93:35 AccountantExtPrice.scala 93:35]
  wire [5:0] _GEN_31 = 6'hb == regObject ? regAssignments_11_agent : _GEN_29; // @[AccountantExtPrice.scala 93:35 AccountantExtPrice.scala 93:35]
  wire  _GEN_32 = 6'hb == regObject ? regAssignments_11_valid : _GEN_30; // @[AccountantExtPrice.scala 93:35 AccountantExtPrice.scala 93:35]
  wire [5:0] _GEN_33 = 6'hc == regObject ? regAssignments_12_agent : _GEN_31; // @[AccountantExtPrice.scala 93:35 AccountantExtPrice.scala 93:35]
  wire  _GEN_34 = 6'hc == regObject ? regAssignments_12_valid : _GEN_32; // @[AccountantExtPrice.scala 93:35 AccountantExtPrice.scala 93:35]
  wire [5:0] _GEN_35 = 6'hd == regObject ? regAssignments_13_agent : _GEN_33; // @[AccountantExtPrice.scala 93:35 AccountantExtPrice.scala 93:35]
  wire  _GEN_36 = 6'hd == regObject ? regAssignments_13_valid : _GEN_34; // @[AccountantExtPrice.scala 93:35 AccountantExtPrice.scala 93:35]
  wire [5:0] _GEN_37 = 6'he == regObject ? regAssignments_14_agent : _GEN_35; // @[AccountantExtPrice.scala 93:35 AccountantExtPrice.scala 93:35]
  wire  _GEN_38 = 6'he == regObject ? regAssignments_14_valid : _GEN_36; // @[AccountantExtPrice.scala 93:35 AccountantExtPrice.scala 93:35]
  wire [5:0] _GEN_39 = 6'hf == regObject ? regAssignments_15_agent : _GEN_37; // @[AccountantExtPrice.scala 93:35 AccountantExtPrice.scala 93:35]
  wire  _GEN_40 = 6'hf == regObject ? regAssignments_15_valid : _GEN_38; // @[AccountantExtPrice.scala 93:35 AccountantExtPrice.scala 93:35]
  wire [5:0] _GEN_41 = 6'h10 == regObject ? regAssignments_16_agent : _GEN_39; // @[AccountantExtPrice.scala 93:35 AccountantExtPrice.scala 93:35]
  wire  _GEN_42 = 6'h10 == regObject ? regAssignments_16_valid : _GEN_40; // @[AccountantExtPrice.scala 93:35 AccountantExtPrice.scala 93:35]
  wire [5:0] _GEN_43 = 6'h11 == regObject ? regAssignments_17_agent : _GEN_41; // @[AccountantExtPrice.scala 93:35 AccountantExtPrice.scala 93:35]
  wire  _GEN_44 = 6'h11 == regObject ? regAssignments_17_valid : _GEN_42; // @[AccountantExtPrice.scala 93:35 AccountantExtPrice.scala 93:35]
  wire [5:0] _GEN_45 = 6'h12 == regObject ? regAssignments_18_agent : _GEN_43; // @[AccountantExtPrice.scala 93:35 AccountantExtPrice.scala 93:35]
  wire  _GEN_46 = 6'h12 == regObject ? regAssignments_18_valid : _GEN_44; // @[AccountantExtPrice.scala 93:35 AccountantExtPrice.scala 93:35]
  wire [5:0] _GEN_47 = 6'h13 == regObject ? regAssignments_19_agent : _GEN_45; // @[AccountantExtPrice.scala 93:35 AccountantExtPrice.scala 93:35]
  wire  _GEN_48 = 6'h13 == regObject ? regAssignments_19_valid : _GEN_46; // @[AccountantExtPrice.scala 93:35 AccountantExtPrice.scala 93:35]
  wire [5:0] _GEN_49 = 6'h14 == regObject ? regAssignments_20_agent : _GEN_47; // @[AccountantExtPrice.scala 93:35 AccountantExtPrice.scala 93:35]
  wire  _GEN_50 = 6'h14 == regObject ? regAssignments_20_valid : _GEN_48; // @[AccountantExtPrice.scala 93:35 AccountantExtPrice.scala 93:35]
  wire [5:0] _GEN_51 = 6'h15 == regObject ? regAssignments_21_agent : _GEN_49; // @[AccountantExtPrice.scala 93:35 AccountantExtPrice.scala 93:35]
  wire  _GEN_52 = 6'h15 == regObject ? regAssignments_21_valid : _GEN_50; // @[AccountantExtPrice.scala 93:35 AccountantExtPrice.scala 93:35]
  wire [5:0] _GEN_53 = 6'h16 == regObject ? regAssignments_22_agent : _GEN_51; // @[AccountantExtPrice.scala 93:35 AccountantExtPrice.scala 93:35]
  wire  _GEN_54 = 6'h16 == regObject ? regAssignments_22_valid : _GEN_52; // @[AccountantExtPrice.scala 93:35 AccountantExtPrice.scala 93:35]
  wire [5:0] _GEN_55 = 6'h17 == regObject ? regAssignments_23_agent : _GEN_53; // @[AccountantExtPrice.scala 93:35 AccountantExtPrice.scala 93:35]
  wire  _GEN_56 = 6'h17 == regObject ? regAssignments_23_valid : _GEN_54; // @[AccountantExtPrice.scala 93:35 AccountantExtPrice.scala 93:35]
  wire [5:0] _GEN_57 = 6'h18 == regObject ? regAssignments_24_agent : _GEN_55; // @[AccountantExtPrice.scala 93:35 AccountantExtPrice.scala 93:35]
  wire  _GEN_58 = 6'h18 == regObject ? regAssignments_24_valid : _GEN_56; // @[AccountantExtPrice.scala 93:35 AccountantExtPrice.scala 93:35]
  wire [5:0] _GEN_59 = 6'h19 == regObject ? regAssignments_25_agent : _GEN_57; // @[AccountantExtPrice.scala 93:35 AccountantExtPrice.scala 93:35]
  wire  _GEN_60 = 6'h19 == regObject ? regAssignments_25_valid : _GEN_58; // @[AccountantExtPrice.scala 93:35 AccountantExtPrice.scala 93:35]
  wire [5:0] _GEN_61 = 6'h1a == regObject ? regAssignments_26_agent : _GEN_59; // @[AccountantExtPrice.scala 93:35 AccountantExtPrice.scala 93:35]
  wire  _GEN_62 = 6'h1a == regObject ? regAssignments_26_valid : _GEN_60; // @[AccountantExtPrice.scala 93:35 AccountantExtPrice.scala 93:35]
  wire [5:0] _GEN_63 = 6'h1b == regObject ? regAssignments_27_agent : _GEN_61; // @[AccountantExtPrice.scala 93:35 AccountantExtPrice.scala 93:35]
  wire  _GEN_64 = 6'h1b == regObject ? regAssignments_27_valid : _GEN_62; // @[AccountantExtPrice.scala 93:35 AccountantExtPrice.scala 93:35]
  wire [5:0] _GEN_65 = 6'h1c == regObject ? regAssignments_28_agent : _GEN_63; // @[AccountantExtPrice.scala 93:35 AccountantExtPrice.scala 93:35]
  wire  _GEN_66 = 6'h1c == regObject ? regAssignments_28_valid : _GEN_64; // @[AccountantExtPrice.scala 93:35 AccountantExtPrice.scala 93:35]
  wire [5:0] _GEN_67 = 6'h1d == regObject ? regAssignments_29_agent : _GEN_65; // @[AccountantExtPrice.scala 93:35 AccountantExtPrice.scala 93:35]
  wire  _GEN_68 = 6'h1d == regObject ? regAssignments_29_valid : _GEN_66; // @[AccountantExtPrice.scala 93:35 AccountantExtPrice.scala 93:35]
  wire [5:0] _GEN_69 = 6'h1e == regObject ? regAssignments_30_agent : _GEN_67; // @[AccountantExtPrice.scala 93:35 AccountantExtPrice.scala 93:35]
  wire  _GEN_70 = 6'h1e == regObject ? regAssignments_30_valid : _GEN_68; // @[AccountantExtPrice.scala 93:35 AccountantExtPrice.scala 93:35]
  wire [5:0] _GEN_71 = 6'h1f == regObject ? regAssignments_31_agent : _GEN_69; // @[AccountantExtPrice.scala 93:35 AccountantExtPrice.scala 93:35]
  wire  _GEN_72 = 6'h1f == regObject ? regAssignments_31_valid : _GEN_70; // @[AccountantExtPrice.scala 93:35 AccountantExtPrice.scala 93:35]
  wire [5:0] _GEN_73 = 6'h20 == regObject ? regAssignments_32_agent : _GEN_71; // @[AccountantExtPrice.scala 93:35 AccountantExtPrice.scala 93:35]
  wire  _GEN_74 = 6'h20 == regObject ? regAssignments_32_valid : _GEN_72; // @[AccountantExtPrice.scala 93:35 AccountantExtPrice.scala 93:35]
  wire [5:0] _GEN_75 = 6'h21 == regObject ? regAssignments_33_agent : _GEN_73; // @[AccountantExtPrice.scala 93:35 AccountantExtPrice.scala 93:35]
  wire  _GEN_76 = 6'h21 == regObject ? regAssignments_33_valid : _GEN_74; // @[AccountantExtPrice.scala 93:35 AccountantExtPrice.scala 93:35]
  wire [5:0] _GEN_77 = 6'h22 == regObject ? regAssignments_34_agent : _GEN_75; // @[AccountantExtPrice.scala 93:35 AccountantExtPrice.scala 93:35]
  wire  _GEN_78 = 6'h22 == regObject ? regAssignments_34_valid : _GEN_76; // @[AccountantExtPrice.scala 93:35 AccountantExtPrice.scala 93:35]
  wire [5:0] _GEN_79 = 6'h23 == regObject ? regAssignments_35_agent : _GEN_77; // @[AccountantExtPrice.scala 93:35 AccountantExtPrice.scala 93:35]
  wire  _GEN_80 = 6'h23 == regObject ? regAssignments_35_valid : _GEN_78; // @[AccountantExtPrice.scala 93:35 AccountantExtPrice.scala 93:35]
  wire [5:0] _GEN_81 = 6'h24 == regObject ? regAssignments_36_agent : _GEN_79; // @[AccountantExtPrice.scala 93:35 AccountantExtPrice.scala 93:35]
  wire  _GEN_82 = 6'h24 == regObject ? regAssignments_36_valid : _GEN_80; // @[AccountantExtPrice.scala 93:35 AccountantExtPrice.scala 93:35]
  wire [5:0] _GEN_83 = 6'h25 == regObject ? regAssignments_37_agent : _GEN_81; // @[AccountantExtPrice.scala 93:35 AccountantExtPrice.scala 93:35]
  wire  _GEN_84 = 6'h25 == regObject ? regAssignments_37_valid : _GEN_82; // @[AccountantExtPrice.scala 93:35 AccountantExtPrice.scala 93:35]
  wire [5:0] _GEN_85 = 6'h26 == regObject ? regAssignments_38_agent : _GEN_83; // @[AccountantExtPrice.scala 93:35 AccountantExtPrice.scala 93:35]
  wire  _GEN_86 = 6'h26 == regObject ? regAssignments_38_valid : _GEN_84; // @[AccountantExtPrice.scala 93:35 AccountantExtPrice.scala 93:35]
  wire [5:0] _GEN_87 = 6'h27 == regObject ? regAssignments_39_agent : _GEN_85; // @[AccountantExtPrice.scala 93:35 AccountantExtPrice.scala 93:35]
  wire  _GEN_88 = 6'h27 == regObject ? regAssignments_39_valid : _GEN_86; // @[AccountantExtPrice.scala 93:35 AccountantExtPrice.scala 93:35]
  wire [5:0] _GEN_89 = 6'h28 == regObject ? regAssignments_40_agent : _GEN_87; // @[AccountantExtPrice.scala 93:35 AccountantExtPrice.scala 93:35]
  wire  _GEN_90 = 6'h28 == regObject ? regAssignments_40_valid : _GEN_88; // @[AccountantExtPrice.scala 93:35 AccountantExtPrice.scala 93:35]
  wire [5:0] _GEN_91 = 6'h29 == regObject ? regAssignments_41_agent : _GEN_89; // @[AccountantExtPrice.scala 93:35 AccountantExtPrice.scala 93:35]
  wire  _GEN_92 = 6'h29 == regObject ? regAssignments_41_valid : _GEN_90; // @[AccountantExtPrice.scala 93:35 AccountantExtPrice.scala 93:35]
  wire [5:0] _GEN_93 = 6'h2a == regObject ? regAssignments_42_agent : _GEN_91; // @[AccountantExtPrice.scala 93:35 AccountantExtPrice.scala 93:35]
  wire  _GEN_94 = 6'h2a == regObject ? regAssignments_42_valid : _GEN_92; // @[AccountantExtPrice.scala 93:35 AccountantExtPrice.scala 93:35]
  wire [5:0] _GEN_95 = 6'h2b == regObject ? regAssignments_43_agent : _GEN_93; // @[AccountantExtPrice.scala 93:35 AccountantExtPrice.scala 93:35]
  wire  _GEN_96 = 6'h2b == regObject ? regAssignments_43_valid : _GEN_94; // @[AccountantExtPrice.scala 93:35 AccountantExtPrice.scala 93:35]
  wire [5:0] _GEN_97 = 6'h2c == regObject ? regAssignments_44_agent : _GEN_95; // @[AccountantExtPrice.scala 93:35 AccountantExtPrice.scala 93:35]
  wire  _GEN_98 = 6'h2c == regObject ? regAssignments_44_valid : _GEN_96; // @[AccountantExtPrice.scala 93:35 AccountantExtPrice.scala 93:35]
  wire [5:0] _GEN_99 = 6'h2d == regObject ? regAssignments_45_agent : _GEN_97; // @[AccountantExtPrice.scala 93:35 AccountantExtPrice.scala 93:35]
  wire  _GEN_100 = 6'h2d == regObject ? regAssignments_45_valid : _GEN_98; // @[AccountantExtPrice.scala 93:35 AccountantExtPrice.scala 93:35]
  wire [5:0] _GEN_101 = 6'h2e == regObject ? regAssignments_46_agent : _GEN_99; // @[AccountantExtPrice.scala 93:35 AccountantExtPrice.scala 93:35]
  wire  _GEN_102 = 6'h2e == regObject ? regAssignments_46_valid : _GEN_100; // @[AccountantExtPrice.scala 93:35 AccountantExtPrice.scala 93:35]
  wire [5:0] _GEN_103 = 6'h2f == regObject ? regAssignments_47_agent : _GEN_101; // @[AccountantExtPrice.scala 93:35 AccountantExtPrice.scala 93:35]
  wire  _GEN_104 = 6'h2f == regObject ? regAssignments_47_valid : _GEN_102; // @[AccountantExtPrice.scala 93:35 AccountantExtPrice.scala 93:35]
  wire [5:0] _GEN_105 = 6'h30 == regObject ? regAssignments_48_agent : _GEN_103; // @[AccountantExtPrice.scala 93:35 AccountantExtPrice.scala 93:35]
  wire  _GEN_106 = 6'h30 == regObject ? regAssignments_48_valid : _GEN_104; // @[AccountantExtPrice.scala 93:35 AccountantExtPrice.scala 93:35]
  wire [5:0] _GEN_107 = 6'h31 == regObject ? regAssignments_49_agent : _GEN_105; // @[AccountantExtPrice.scala 93:35 AccountantExtPrice.scala 93:35]
  wire  _GEN_108 = 6'h31 == regObject ? regAssignments_49_valid : _GEN_106; // @[AccountantExtPrice.scala 93:35 AccountantExtPrice.scala 93:35]
  wire [5:0] _GEN_109 = 6'h32 == regObject ? regAssignments_50_agent : _GEN_107; // @[AccountantExtPrice.scala 93:35 AccountantExtPrice.scala 93:35]
  wire  _GEN_110 = 6'h32 == regObject ? regAssignments_50_valid : _GEN_108; // @[AccountantExtPrice.scala 93:35 AccountantExtPrice.scala 93:35]
  wire [5:0] _GEN_111 = 6'h33 == regObject ? regAssignments_51_agent : _GEN_109; // @[AccountantExtPrice.scala 93:35 AccountantExtPrice.scala 93:35]
  wire  _GEN_112 = 6'h33 == regObject ? regAssignments_51_valid : _GEN_110; // @[AccountantExtPrice.scala 93:35 AccountantExtPrice.scala 93:35]
  wire [5:0] _GEN_113 = 6'h34 == regObject ? regAssignments_52_agent : _GEN_111; // @[AccountantExtPrice.scala 93:35 AccountantExtPrice.scala 93:35]
  wire  _GEN_114 = 6'h34 == regObject ? regAssignments_52_valid : _GEN_112; // @[AccountantExtPrice.scala 93:35 AccountantExtPrice.scala 93:35]
  wire [5:0] _GEN_115 = 6'h35 == regObject ? regAssignments_53_agent : _GEN_113; // @[AccountantExtPrice.scala 93:35 AccountantExtPrice.scala 93:35]
  wire  _GEN_116 = 6'h35 == regObject ? regAssignments_53_valid : _GEN_114; // @[AccountantExtPrice.scala 93:35 AccountantExtPrice.scala 93:35]
  wire [5:0] _GEN_117 = 6'h36 == regObject ? regAssignments_54_agent : _GEN_115; // @[AccountantExtPrice.scala 93:35 AccountantExtPrice.scala 93:35]
  wire  _GEN_118 = 6'h36 == regObject ? regAssignments_54_valid : _GEN_116; // @[AccountantExtPrice.scala 93:35 AccountantExtPrice.scala 93:35]
  wire [5:0] _GEN_119 = 6'h37 == regObject ? regAssignments_55_agent : _GEN_117; // @[AccountantExtPrice.scala 93:35 AccountantExtPrice.scala 93:35]
  wire  _GEN_120 = 6'h37 == regObject ? regAssignments_55_valid : _GEN_118; // @[AccountantExtPrice.scala 93:35 AccountantExtPrice.scala 93:35]
  wire [5:0] _GEN_121 = 6'h38 == regObject ? regAssignments_56_agent : _GEN_119; // @[AccountantExtPrice.scala 93:35 AccountantExtPrice.scala 93:35]
  wire  _GEN_122 = 6'h38 == regObject ? regAssignments_56_valid : _GEN_120; // @[AccountantExtPrice.scala 93:35 AccountantExtPrice.scala 93:35]
  wire [5:0] _GEN_123 = 6'h39 == regObject ? regAssignments_57_agent : _GEN_121; // @[AccountantExtPrice.scala 93:35 AccountantExtPrice.scala 93:35]
  wire  _GEN_124 = 6'h39 == regObject ? regAssignments_57_valid : _GEN_122; // @[AccountantExtPrice.scala 93:35 AccountantExtPrice.scala 93:35]
  wire [5:0] _GEN_125 = 6'h3a == regObject ? regAssignments_58_agent : _GEN_123; // @[AccountantExtPrice.scala 93:35 AccountantExtPrice.scala 93:35]
  wire  _GEN_126 = 6'h3a == regObject ? regAssignments_58_valid : _GEN_124; // @[AccountantExtPrice.scala 93:35 AccountantExtPrice.scala 93:35]
  wire [5:0] _GEN_127 = 6'h3b == regObject ? regAssignments_59_agent : _GEN_125; // @[AccountantExtPrice.scala 93:35 AccountantExtPrice.scala 93:35]
  wire  _GEN_128 = 6'h3b == regObject ? regAssignments_59_valid : _GEN_126; // @[AccountantExtPrice.scala 93:35 AccountantExtPrice.scala 93:35]
  wire [5:0] _GEN_129 = 6'h3c == regObject ? regAssignments_60_agent : _GEN_127; // @[AccountantExtPrice.scala 93:35 AccountantExtPrice.scala 93:35]
  wire  _GEN_130 = 6'h3c == regObject ? regAssignments_60_valid : _GEN_128; // @[AccountantExtPrice.scala 93:35 AccountantExtPrice.scala 93:35]
  wire [5:0] _GEN_131 = 6'h3d == regObject ? regAssignments_61_agent : _GEN_129; // @[AccountantExtPrice.scala 93:35 AccountantExtPrice.scala 93:35]
  wire  _GEN_132 = 6'h3d == regObject ? regAssignments_61_valid : _GEN_130; // @[AccountantExtPrice.scala 93:35 AccountantExtPrice.scala 93:35]
  wire [5:0] _GEN_133 = 6'h3e == regObject ? regAssignments_62_agent : _GEN_131; // @[AccountantExtPrice.scala 93:35 AccountantExtPrice.scala 93:35]
  wire  _GEN_134 = 6'h3e == regObject ? regAssignments_62_valid : _GEN_132; // @[AccountantExtPrice.scala 93:35 AccountantExtPrice.scala 93:35]
  wire [5:0] _GEN_135 = 6'h3f == regObject ? regAssignments_63_agent : _GEN_133; // @[AccountantExtPrice.scala 93:35 AccountantExtPrice.scala 93:35]
  wire  _GEN_136 = 6'h3f == regObject ? regAssignments_63_valid : _GEN_134; // @[AccountantExtPrice.scala 93:35 AccountantExtPrice.scala 93:35]
  wire [5:0] _GEN_137 = 6'h0 == regObject ? regCurrentAgent[5:0] : regAssignments_0_agent; // @[AccountantExtPrice.scala 99:41 AccountantExtPrice.scala 99:41 AccountantExtPrice.scala 53:31]
  wire [5:0] _GEN_138 = 6'h1 == regObject ? regCurrentAgent[5:0] : regAssignments_1_agent; // @[AccountantExtPrice.scala 99:41 AccountantExtPrice.scala 99:41 AccountantExtPrice.scala 53:31]
  wire [5:0] _GEN_139 = 6'h2 == regObject ? regCurrentAgent[5:0] : regAssignments_2_agent; // @[AccountantExtPrice.scala 99:41 AccountantExtPrice.scala 99:41 AccountantExtPrice.scala 53:31]
  wire [5:0] _GEN_140 = 6'h3 == regObject ? regCurrentAgent[5:0] : regAssignments_3_agent; // @[AccountantExtPrice.scala 99:41 AccountantExtPrice.scala 99:41 AccountantExtPrice.scala 53:31]
  wire [5:0] _GEN_141 = 6'h4 == regObject ? regCurrentAgent[5:0] : regAssignments_4_agent; // @[AccountantExtPrice.scala 99:41 AccountantExtPrice.scala 99:41 AccountantExtPrice.scala 53:31]
  wire [5:0] _GEN_142 = 6'h5 == regObject ? regCurrentAgent[5:0] : regAssignments_5_agent; // @[AccountantExtPrice.scala 99:41 AccountantExtPrice.scala 99:41 AccountantExtPrice.scala 53:31]
  wire [5:0] _GEN_143 = 6'h6 == regObject ? regCurrentAgent[5:0] : regAssignments_6_agent; // @[AccountantExtPrice.scala 99:41 AccountantExtPrice.scala 99:41 AccountantExtPrice.scala 53:31]
  wire [5:0] _GEN_144 = 6'h7 == regObject ? regCurrentAgent[5:0] : regAssignments_7_agent; // @[AccountantExtPrice.scala 99:41 AccountantExtPrice.scala 99:41 AccountantExtPrice.scala 53:31]
  wire [5:0] _GEN_145 = 6'h8 == regObject ? regCurrentAgent[5:0] : regAssignments_8_agent; // @[AccountantExtPrice.scala 99:41 AccountantExtPrice.scala 99:41 AccountantExtPrice.scala 53:31]
  wire [5:0] _GEN_146 = 6'h9 == regObject ? regCurrentAgent[5:0] : regAssignments_9_agent; // @[AccountantExtPrice.scala 99:41 AccountantExtPrice.scala 99:41 AccountantExtPrice.scala 53:31]
  wire [5:0] _GEN_147 = 6'ha == regObject ? regCurrentAgent[5:0] : regAssignments_10_agent; // @[AccountantExtPrice.scala 99:41 AccountantExtPrice.scala 99:41 AccountantExtPrice.scala 53:31]
  wire [5:0] _GEN_148 = 6'hb == regObject ? regCurrentAgent[5:0] : regAssignments_11_agent; // @[AccountantExtPrice.scala 99:41 AccountantExtPrice.scala 99:41 AccountantExtPrice.scala 53:31]
  wire [5:0] _GEN_149 = 6'hc == regObject ? regCurrentAgent[5:0] : regAssignments_12_agent; // @[AccountantExtPrice.scala 99:41 AccountantExtPrice.scala 99:41 AccountantExtPrice.scala 53:31]
  wire [5:0] _GEN_150 = 6'hd == regObject ? regCurrentAgent[5:0] : regAssignments_13_agent; // @[AccountantExtPrice.scala 99:41 AccountantExtPrice.scala 99:41 AccountantExtPrice.scala 53:31]
  wire [5:0] _GEN_151 = 6'he == regObject ? regCurrentAgent[5:0] : regAssignments_14_agent; // @[AccountantExtPrice.scala 99:41 AccountantExtPrice.scala 99:41 AccountantExtPrice.scala 53:31]
  wire [5:0] _GEN_152 = 6'hf == regObject ? regCurrentAgent[5:0] : regAssignments_15_agent; // @[AccountantExtPrice.scala 99:41 AccountantExtPrice.scala 99:41 AccountantExtPrice.scala 53:31]
  wire [5:0] _GEN_153 = 6'h10 == regObject ? regCurrentAgent[5:0] : regAssignments_16_agent; // @[AccountantExtPrice.scala 99:41 AccountantExtPrice.scala 99:41 AccountantExtPrice.scala 53:31]
  wire [5:0] _GEN_154 = 6'h11 == regObject ? regCurrentAgent[5:0] : regAssignments_17_agent; // @[AccountantExtPrice.scala 99:41 AccountantExtPrice.scala 99:41 AccountantExtPrice.scala 53:31]
  wire [5:0] _GEN_155 = 6'h12 == regObject ? regCurrentAgent[5:0] : regAssignments_18_agent; // @[AccountantExtPrice.scala 99:41 AccountantExtPrice.scala 99:41 AccountantExtPrice.scala 53:31]
  wire [5:0] _GEN_156 = 6'h13 == regObject ? regCurrentAgent[5:0] : regAssignments_19_agent; // @[AccountantExtPrice.scala 99:41 AccountantExtPrice.scala 99:41 AccountantExtPrice.scala 53:31]
  wire [5:0] _GEN_157 = 6'h14 == regObject ? regCurrentAgent[5:0] : regAssignments_20_agent; // @[AccountantExtPrice.scala 99:41 AccountantExtPrice.scala 99:41 AccountantExtPrice.scala 53:31]
  wire [5:0] _GEN_158 = 6'h15 == regObject ? regCurrentAgent[5:0] : regAssignments_21_agent; // @[AccountantExtPrice.scala 99:41 AccountantExtPrice.scala 99:41 AccountantExtPrice.scala 53:31]
  wire [5:0] _GEN_159 = 6'h16 == regObject ? regCurrentAgent[5:0] : regAssignments_22_agent; // @[AccountantExtPrice.scala 99:41 AccountantExtPrice.scala 99:41 AccountantExtPrice.scala 53:31]
  wire [5:0] _GEN_160 = 6'h17 == regObject ? regCurrentAgent[5:0] : regAssignments_23_agent; // @[AccountantExtPrice.scala 99:41 AccountantExtPrice.scala 99:41 AccountantExtPrice.scala 53:31]
  wire [5:0] _GEN_161 = 6'h18 == regObject ? regCurrentAgent[5:0] : regAssignments_24_agent; // @[AccountantExtPrice.scala 99:41 AccountantExtPrice.scala 99:41 AccountantExtPrice.scala 53:31]
  wire [5:0] _GEN_162 = 6'h19 == regObject ? regCurrentAgent[5:0] : regAssignments_25_agent; // @[AccountantExtPrice.scala 99:41 AccountantExtPrice.scala 99:41 AccountantExtPrice.scala 53:31]
  wire [5:0] _GEN_163 = 6'h1a == regObject ? regCurrentAgent[5:0] : regAssignments_26_agent; // @[AccountantExtPrice.scala 99:41 AccountantExtPrice.scala 99:41 AccountantExtPrice.scala 53:31]
  wire [5:0] _GEN_164 = 6'h1b == regObject ? regCurrentAgent[5:0] : regAssignments_27_agent; // @[AccountantExtPrice.scala 99:41 AccountantExtPrice.scala 99:41 AccountantExtPrice.scala 53:31]
  wire [5:0] _GEN_165 = 6'h1c == regObject ? regCurrentAgent[5:0] : regAssignments_28_agent; // @[AccountantExtPrice.scala 99:41 AccountantExtPrice.scala 99:41 AccountantExtPrice.scala 53:31]
  wire [5:0] _GEN_166 = 6'h1d == regObject ? regCurrentAgent[5:0] : regAssignments_29_agent; // @[AccountantExtPrice.scala 99:41 AccountantExtPrice.scala 99:41 AccountantExtPrice.scala 53:31]
  wire [5:0] _GEN_167 = 6'h1e == regObject ? regCurrentAgent[5:0] : regAssignments_30_agent; // @[AccountantExtPrice.scala 99:41 AccountantExtPrice.scala 99:41 AccountantExtPrice.scala 53:31]
  wire [5:0] _GEN_168 = 6'h1f == regObject ? regCurrentAgent[5:0] : regAssignments_31_agent; // @[AccountantExtPrice.scala 99:41 AccountantExtPrice.scala 99:41 AccountantExtPrice.scala 53:31]
  wire [5:0] _GEN_169 = 6'h20 == regObject ? regCurrentAgent[5:0] : regAssignments_32_agent; // @[AccountantExtPrice.scala 99:41 AccountantExtPrice.scala 99:41 AccountantExtPrice.scala 53:31]
  wire [5:0] _GEN_170 = 6'h21 == regObject ? regCurrentAgent[5:0] : regAssignments_33_agent; // @[AccountantExtPrice.scala 99:41 AccountantExtPrice.scala 99:41 AccountantExtPrice.scala 53:31]
  wire [5:0] _GEN_171 = 6'h22 == regObject ? regCurrentAgent[5:0] : regAssignments_34_agent; // @[AccountantExtPrice.scala 99:41 AccountantExtPrice.scala 99:41 AccountantExtPrice.scala 53:31]
  wire [5:0] _GEN_172 = 6'h23 == regObject ? regCurrentAgent[5:0] : regAssignments_35_agent; // @[AccountantExtPrice.scala 99:41 AccountantExtPrice.scala 99:41 AccountantExtPrice.scala 53:31]
  wire [5:0] _GEN_173 = 6'h24 == regObject ? regCurrentAgent[5:0] : regAssignments_36_agent; // @[AccountantExtPrice.scala 99:41 AccountantExtPrice.scala 99:41 AccountantExtPrice.scala 53:31]
  wire [5:0] _GEN_174 = 6'h25 == regObject ? regCurrentAgent[5:0] : regAssignments_37_agent; // @[AccountantExtPrice.scala 99:41 AccountantExtPrice.scala 99:41 AccountantExtPrice.scala 53:31]
  wire [5:0] _GEN_175 = 6'h26 == regObject ? regCurrentAgent[5:0] : regAssignments_38_agent; // @[AccountantExtPrice.scala 99:41 AccountantExtPrice.scala 99:41 AccountantExtPrice.scala 53:31]
  wire [5:0] _GEN_176 = 6'h27 == regObject ? regCurrentAgent[5:0] : regAssignments_39_agent; // @[AccountantExtPrice.scala 99:41 AccountantExtPrice.scala 99:41 AccountantExtPrice.scala 53:31]
  wire [5:0] _GEN_177 = 6'h28 == regObject ? regCurrentAgent[5:0] : regAssignments_40_agent; // @[AccountantExtPrice.scala 99:41 AccountantExtPrice.scala 99:41 AccountantExtPrice.scala 53:31]
  wire [5:0] _GEN_178 = 6'h29 == regObject ? regCurrentAgent[5:0] : regAssignments_41_agent; // @[AccountantExtPrice.scala 99:41 AccountantExtPrice.scala 99:41 AccountantExtPrice.scala 53:31]
  wire [5:0] _GEN_179 = 6'h2a == regObject ? regCurrentAgent[5:0] : regAssignments_42_agent; // @[AccountantExtPrice.scala 99:41 AccountantExtPrice.scala 99:41 AccountantExtPrice.scala 53:31]
  wire [5:0] _GEN_180 = 6'h2b == regObject ? regCurrentAgent[5:0] : regAssignments_43_agent; // @[AccountantExtPrice.scala 99:41 AccountantExtPrice.scala 99:41 AccountantExtPrice.scala 53:31]
  wire [5:0] _GEN_181 = 6'h2c == regObject ? regCurrentAgent[5:0] : regAssignments_44_agent; // @[AccountantExtPrice.scala 99:41 AccountantExtPrice.scala 99:41 AccountantExtPrice.scala 53:31]
  wire [5:0] _GEN_182 = 6'h2d == regObject ? regCurrentAgent[5:0] : regAssignments_45_agent; // @[AccountantExtPrice.scala 99:41 AccountantExtPrice.scala 99:41 AccountantExtPrice.scala 53:31]
  wire [5:0] _GEN_183 = 6'h2e == regObject ? regCurrentAgent[5:0] : regAssignments_46_agent; // @[AccountantExtPrice.scala 99:41 AccountantExtPrice.scala 99:41 AccountantExtPrice.scala 53:31]
  wire [5:0] _GEN_184 = 6'h2f == regObject ? regCurrentAgent[5:0] : regAssignments_47_agent; // @[AccountantExtPrice.scala 99:41 AccountantExtPrice.scala 99:41 AccountantExtPrice.scala 53:31]
  wire [5:0] _GEN_185 = 6'h30 == regObject ? regCurrentAgent[5:0] : regAssignments_48_agent; // @[AccountantExtPrice.scala 99:41 AccountantExtPrice.scala 99:41 AccountantExtPrice.scala 53:31]
  wire [5:0] _GEN_186 = 6'h31 == regObject ? regCurrentAgent[5:0] : regAssignments_49_agent; // @[AccountantExtPrice.scala 99:41 AccountantExtPrice.scala 99:41 AccountantExtPrice.scala 53:31]
  wire [5:0] _GEN_187 = 6'h32 == regObject ? regCurrentAgent[5:0] : regAssignments_50_agent; // @[AccountantExtPrice.scala 99:41 AccountantExtPrice.scala 99:41 AccountantExtPrice.scala 53:31]
  wire [5:0] _GEN_188 = 6'h33 == regObject ? regCurrentAgent[5:0] : regAssignments_51_agent; // @[AccountantExtPrice.scala 99:41 AccountantExtPrice.scala 99:41 AccountantExtPrice.scala 53:31]
  wire [5:0] _GEN_189 = 6'h34 == regObject ? regCurrentAgent[5:0] : regAssignments_52_agent; // @[AccountantExtPrice.scala 99:41 AccountantExtPrice.scala 99:41 AccountantExtPrice.scala 53:31]
  wire [5:0] _GEN_190 = 6'h35 == regObject ? regCurrentAgent[5:0] : regAssignments_53_agent; // @[AccountantExtPrice.scala 99:41 AccountantExtPrice.scala 99:41 AccountantExtPrice.scala 53:31]
  wire [5:0] _GEN_191 = 6'h36 == regObject ? regCurrentAgent[5:0] : regAssignments_54_agent; // @[AccountantExtPrice.scala 99:41 AccountantExtPrice.scala 99:41 AccountantExtPrice.scala 53:31]
  wire [5:0] _GEN_192 = 6'h37 == regObject ? regCurrentAgent[5:0] : regAssignments_55_agent; // @[AccountantExtPrice.scala 99:41 AccountantExtPrice.scala 99:41 AccountantExtPrice.scala 53:31]
  wire [5:0] _GEN_193 = 6'h38 == regObject ? regCurrentAgent[5:0] : regAssignments_56_agent; // @[AccountantExtPrice.scala 99:41 AccountantExtPrice.scala 99:41 AccountantExtPrice.scala 53:31]
  wire [5:0] _GEN_194 = 6'h39 == regObject ? regCurrentAgent[5:0] : regAssignments_57_agent; // @[AccountantExtPrice.scala 99:41 AccountantExtPrice.scala 99:41 AccountantExtPrice.scala 53:31]
  wire [5:0] _GEN_195 = 6'h3a == regObject ? regCurrentAgent[5:0] : regAssignments_58_agent; // @[AccountantExtPrice.scala 99:41 AccountantExtPrice.scala 99:41 AccountantExtPrice.scala 53:31]
  wire [5:0] _GEN_196 = 6'h3b == regObject ? regCurrentAgent[5:0] : regAssignments_59_agent; // @[AccountantExtPrice.scala 99:41 AccountantExtPrice.scala 99:41 AccountantExtPrice.scala 53:31]
  wire [5:0] _GEN_197 = 6'h3c == regObject ? regCurrentAgent[5:0] : regAssignments_60_agent; // @[AccountantExtPrice.scala 99:41 AccountantExtPrice.scala 99:41 AccountantExtPrice.scala 53:31]
  wire [5:0] _GEN_198 = 6'h3d == regObject ? regCurrentAgent[5:0] : regAssignments_61_agent; // @[AccountantExtPrice.scala 99:41 AccountantExtPrice.scala 99:41 AccountantExtPrice.scala 53:31]
  wire [5:0] _GEN_199 = 6'h3e == regObject ? regCurrentAgent[5:0] : regAssignments_62_agent; // @[AccountantExtPrice.scala 99:41 AccountantExtPrice.scala 99:41 AccountantExtPrice.scala 53:31]
  wire [5:0] _GEN_200 = 6'h3f == regObject ? regCurrentAgent[5:0] : regAssignments_63_agent; // @[AccountantExtPrice.scala 99:41 AccountantExtPrice.scala 99:41 AccountantExtPrice.scala 53:31]
  wire  _GEN_201 = 6'h0 == regObject | regAssignments_0_valid; // @[AccountantExtPrice.scala 100:41 AccountantExtPrice.scala 100:41 AccountantExtPrice.scala 53:31]
  wire  _GEN_202 = 6'h1 == regObject | regAssignments_1_valid; // @[AccountantExtPrice.scala 100:41 AccountantExtPrice.scala 100:41 AccountantExtPrice.scala 53:31]
  wire  _GEN_203 = 6'h2 == regObject | regAssignments_2_valid; // @[AccountantExtPrice.scala 100:41 AccountantExtPrice.scala 100:41 AccountantExtPrice.scala 53:31]
  wire  _GEN_204 = 6'h3 == regObject | regAssignments_3_valid; // @[AccountantExtPrice.scala 100:41 AccountantExtPrice.scala 100:41 AccountantExtPrice.scala 53:31]
  wire  _GEN_205 = 6'h4 == regObject | regAssignments_4_valid; // @[AccountantExtPrice.scala 100:41 AccountantExtPrice.scala 100:41 AccountantExtPrice.scala 53:31]
  wire  _GEN_206 = 6'h5 == regObject | regAssignments_5_valid; // @[AccountantExtPrice.scala 100:41 AccountantExtPrice.scala 100:41 AccountantExtPrice.scala 53:31]
  wire  _GEN_207 = 6'h6 == regObject | regAssignments_6_valid; // @[AccountantExtPrice.scala 100:41 AccountantExtPrice.scala 100:41 AccountantExtPrice.scala 53:31]
  wire  _GEN_208 = 6'h7 == regObject | regAssignments_7_valid; // @[AccountantExtPrice.scala 100:41 AccountantExtPrice.scala 100:41 AccountantExtPrice.scala 53:31]
  wire  _GEN_209 = 6'h8 == regObject | regAssignments_8_valid; // @[AccountantExtPrice.scala 100:41 AccountantExtPrice.scala 100:41 AccountantExtPrice.scala 53:31]
  wire  _GEN_210 = 6'h9 == regObject | regAssignments_9_valid; // @[AccountantExtPrice.scala 100:41 AccountantExtPrice.scala 100:41 AccountantExtPrice.scala 53:31]
  wire  _GEN_211 = 6'ha == regObject | regAssignments_10_valid; // @[AccountantExtPrice.scala 100:41 AccountantExtPrice.scala 100:41 AccountantExtPrice.scala 53:31]
  wire  _GEN_212 = 6'hb == regObject | regAssignments_11_valid; // @[AccountantExtPrice.scala 100:41 AccountantExtPrice.scala 100:41 AccountantExtPrice.scala 53:31]
  wire  _GEN_213 = 6'hc == regObject | regAssignments_12_valid; // @[AccountantExtPrice.scala 100:41 AccountantExtPrice.scala 100:41 AccountantExtPrice.scala 53:31]
  wire  _GEN_214 = 6'hd == regObject | regAssignments_13_valid; // @[AccountantExtPrice.scala 100:41 AccountantExtPrice.scala 100:41 AccountantExtPrice.scala 53:31]
  wire  _GEN_215 = 6'he == regObject | regAssignments_14_valid; // @[AccountantExtPrice.scala 100:41 AccountantExtPrice.scala 100:41 AccountantExtPrice.scala 53:31]
  wire  _GEN_216 = 6'hf == regObject | regAssignments_15_valid; // @[AccountantExtPrice.scala 100:41 AccountantExtPrice.scala 100:41 AccountantExtPrice.scala 53:31]
  wire  _GEN_217 = 6'h10 == regObject | regAssignments_16_valid; // @[AccountantExtPrice.scala 100:41 AccountantExtPrice.scala 100:41 AccountantExtPrice.scala 53:31]
  wire  _GEN_218 = 6'h11 == regObject | regAssignments_17_valid; // @[AccountantExtPrice.scala 100:41 AccountantExtPrice.scala 100:41 AccountantExtPrice.scala 53:31]
  wire  _GEN_219 = 6'h12 == regObject | regAssignments_18_valid; // @[AccountantExtPrice.scala 100:41 AccountantExtPrice.scala 100:41 AccountantExtPrice.scala 53:31]
  wire  _GEN_220 = 6'h13 == regObject | regAssignments_19_valid; // @[AccountantExtPrice.scala 100:41 AccountantExtPrice.scala 100:41 AccountantExtPrice.scala 53:31]
  wire  _GEN_221 = 6'h14 == regObject | regAssignments_20_valid; // @[AccountantExtPrice.scala 100:41 AccountantExtPrice.scala 100:41 AccountantExtPrice.scala 53:31]
  wire  _GEN_222 = 6'h15 == regObject | regAssignments_21_valid; // @[AccountantExtPrice.scala 100:41 AccountantExtPrice.scala 100:41 AccountantExtPrice.scala 53:31]
  wire  _GEN_223 = 6'h16 == regObject | regAssignments_22_valid; // @[AccountantExtPrice.scala 100:41 AccountantExtPrice.scala 100:41 AccountantExtPrice.scala 53:31]
  wire  _GEN_224 = 6'h17 == regObject | regAssignments_23_valid; // @[AccountantExtPrice.scala 100:41 AccountantExtPrice.scala 100:41 AccountantExtPrice.scala 53:31]
  wire  _GEN_225 = 6'h18 == regObject | regAssignments_24_valid; // @[AccountantExtPrice.scala 100:41 AccountantExtPrice.scala 100:41 AccountantExtPrice.scala 53:31]
  wire  _GEN_226 = 6'h19 == regObject | regAssignments_25_valid; // @[AccountantExtPrice.scala 100:41 AccountantExtPrice.scala 100:41 AccountantExtPrice.scala 53:31]
  wire  _GEN_227 = 6'h1a == regObject | regAssignments_26_valid; // @[AccountantExtPrice.scala 100:41 AccountantExtPrice.scala 100:41 AccountantExtPrice.scala 53:31]
  wire  _GEN_228 = 6'h1b == regObject | regAssignments_27_valid; // @[AccountantExtPrice.scala 100:41 AccountantExtPrice.scala 100:41 AccountantExtPrice.scala 53:31]
  wire  _GEN_229 = 6'h1c == regObject | regAssignments_28_valid; // @[AccountantExtPrice.scala 100:41 AccountantExtPrice.scala 100:41 AccountantExtPrice.scala 53:31]
  wire  _GEN_230 = 6'h1d == regObject | regAssignments_29_valid; // @[AccountantExtPrice.scala 100:41 AccountantExtPrice.scala 100:41 AccountantExtPrice.scala 53:31]
  wire  _GEN_231 = 6'h1e == regObject | regAssignments_30_valid; // @[AccountantExtPrice.scala 100:41 AccountantExtPrice.scala 100:41 AccountantExtPrice.scala 53:31]
  wire  _GEN_232 = 6'h1f == regObject | regAssignments_31_valid; // @[AccountantExtPrice.scala 100:41 AccountantExtPrice.scala 100:41 AccountantExtPrice.scala 53:31]
  wire  _GEN_233 = 6'h20 == regObject | regAssignments_32_valid; // @[AccountantExtPrice.scala 100:41 AccountantExtPrice.scala 100:41 AccountantExtPrice.scala 53:31]
  wire  _GEN_234 = 6'h21 == regObject | regAssignments_33_valid; // @[AccountantExtPrice.scala 100:41 AccountantExtPrice.scala 100:41 AccountantExtPrice.scala 53:31]
  wire  _GEN_235 = 6'h22 == regObject | regAssignments_34_valid; // @[AccountantExtPrice.scala 100:41 AccountantExtPrice.scala 100:41 AccountantExtPrice.scala 53:31]
  wire  _GEN_236 = 6'h23 == regObject | regAssignments_35_valid; // @[AccountantExtPrice.scala 100:41 AccountantExtPrice.scala 100:41 AccountantExtPrice.scala 53:31]
  wire  _GEN_237 = 6'h24 == regObject | regAssignments_36_valid; // @[AccountantExtPrice.scala 100:41 AccountantExtPrice.scala 100:41 AccountantExtPrice.scala 53:31]
  wire  _GEN_238 = 6'h25 == regObject | regAssignments_37_valid; // @[AccountantExtPrice.scala 100:41 AccountantExtPrice.scala 100:41 AccountantExtPrice.scala 53:31]
  wire  _GEN_239 = 6'h26 == regObject | regAssignments_38_valid; // @[AccountantExtPrice.scala 100:41 AccountantExtPrice.scala 100:41 AccountantExtPrice.scala 53:31]
  wire  _GEN_240 = 6'h27 == regObject | regAssignments_39_valid; // @[AccountantExtPrice.scala 100:41 AccountantExtPrice.scala 100:41 AccountantExtPrice.scala 53:31]
  wire  _GEN_241 = 6'h28 == regObject | regAssignments_40_valid; // @[AccountantExtPrice.scala 100:41 AccountantExtPrice.scala 100:41 AccountantExtPrice.scala 53:31]
  wire  _GEN_242 = 6'h29 == regObject | regAssignments_41_valid; // @[AccountantExtPrice.scala 100:41 AccountantExtPrice.scala 100:41 AccountantExtPrice.scala 53:31]
  wire  _GEN_243 = 6'h2a == regObject | regAssignments_42_valid; // @[AccountantExtPrice.scala 100:41 AccountantExtPrice.scala 100:41 AccountantExtPrice.scala 53:31]
  wire  _GEN_244 = 6'h2b == regObject | regAssignments_43_valid; // @[AccountantExtPrice.scala 100:41 AccountantExtPrice.scala 100:41 AccountantExtPrice.scala 53:31]
  wire  _GEN_245 = 6'h2c == regObject | regAssignments_44_valid; // @[AccountantExtPrice.scala 100:41 AccountantExtPrice.scala 100:41 AccountantExtPrice.scala 53:31]
  wire  _GEN_246 = 6'h2d == regObject | regAssignments_45_valid; // @[AccountantExtPrice.scala 100:41 AccountantExtPrice.scala 100:41 AccountantExtPrice.scala 53:31]
  wire  _GEN_247 = 6'h2e == regObject | regAssignments_46_valid; // @[AccountantExtPrice.scala 100:41 AccountantExtPrice.scala 100:41 AccountantExtPrice.scala 53:31]
  wire  _GEN_248 = 6'h2f == regObject | regAssignments_47_valid; // @[AccountantExtPrice.scala 100:41 AccountantExtPrice.scala 100:41 AccountantExtPrice.scala 53:31]
  wire  _GEN_249 = 6'h30 == regObject | regAssignments_48_valid; // @[AccountantExtPrice.scala 100:41 AccountantExtPrice.scala 100:41 AccountantExtPrice.scala 53:31]
  wire  _GEN_250 = 6'h31 == regObject | regAssignments_49_valid; // @[AccountantExtPrice.scala 100:41 AccountantExtPrice.scala 100:41 AccountantExtPrice.scala 53:31]
  wire  _GEN_251 = 6'h32 == regObject | regAssignments_50_valid; // @[AccountantExtPrice.scala 100:41 AccountantExtPrice.scala 100:41 AccountantExtPrice.scala 53:31]
  wire  _GEN_252 = 6'h33 == regObject | regAssignments_51_valid; // @[AccountantExtPrice.scala 100:41 AccountantExtPrice.scala 100:41 AccountantExtPrice.scala 53:31]
  wire  _GEN_253 = 6'h34 == regObject | regAssignments_52_valid; // @[AccountantExtPrice.scala 100:41 AccountantExtPrice.scala 100:41 AccountantExtPrice.scala 53:31]
  wire  _GEN_254 = 6'h35 == regObject | regAssignments_53_valid; // @[AccountantExtPrice.scala 100:41 AccountantExtPrice.scala 100:41 AccountantExtPrice.scala 53:31]
  wire  _GEN_255 = 6'h36 == regObject | regAssignments_54_valid; // @[AccountantExtPrice.scala 100:41 AccountantExtPrice.scala 100:41 AccountantExtPrice.scala 53:31]
  wire  _GEN_256 = 6'h37 == regObject | regAssignments_55_valid; // @[AccountantExtPrice.scala 100:41 AccountantExtPrice.scala 100:41 AccountantExtPrice.scala 53:31]
  wire  _GEN_257 = 6'h38 == regObject | regAssignments_56_valid; // @[AccountantExtPrice.scala 100:41 AccountantExtPrice.scala 100:41 AccountantExtPrice.scala 53:31]
  wire  _GEN_258 = 6'h39 == regObject | regAssignments_57_valid; // @[AccountantExtPrice.scala 100:41 AccountantExtPrice.scala 100:41 AccountantExtPrice.scala 53:31]
  wire  _GEN_259 = 6'h3a == regObject | regAssignments_58_valid; // @[AccountantExtPrice.scala 100:41 AccountantExtPrice.scala 100:41 AccountantExtPrice.scala 53:31]
  wire  _GEN_260 = 6'h3b == regObject | regAssignments_59_valid; // @[AccountantExtPrice.scala 100:41 AccountantExtPrice.scala 100:41 AccountantExtPrice.scala 53:31]
  wire  _GEN_261 = 6'h3c == regObject | regAssignments_60_valid; // @[AccountantExtPrice.scala 100:41 AccountantExtPrice.scala 100:41 AccountantExtPrice.scala 53:31]
  wire  _GEN_262 = 6'h3d == regObject | regAssignments_61_valid; // @[AccountantExtPrice.scala 100:41 AccountantExtPrice.scala 100:41 AccountantExtPrice.scala 53:31]
  wire  _GEN_263 = 6'h3e == regObject | regAssignments_62_valid; // @[AccountantExtPrice.scala 100:41 AccountantExtPrice.scala 100:41 AccountantExtPrice.scala 53:31]
  wire  _GEN_264 = 6'h3f == regObject | regAssignments_63_valid; // @[AccountantExtPrice.scala 100:41 AccountantExtPrice.scala 100:41 AccountantExtPrice.scala 53:31]
  wire [7:0] _T_13 = regCurrentPrice + regBid; // @[AccountantExtPrice.scala 102:45]
  wire  _T_17 = io_unassignedAgents_ready & io_unassignedAgents_valid; // @[Decoupled.scala 40:37]
  wire  _GEN_268 = regBid > 8'h0 & _GEN_136; // @[AccountantExtPrice.scala 90:27 AccountantExtPrice.scala 94:20]
  wire  _T_19 = _T_17 | ~_GEN_268; // @[AccountantExtPrice.scala 105:39]
  wire [2:0] _GEN_265 = _T_17 | ~_GEN_268 ? 3'h0 : 3'h1; // @[AccountantExtPrice.scala 105:55 AccountantExtPrice.scala 106:20 AccountantExtPrice.scala 109:20]
  wire  _GEN_404 = regBid > 8'h0 & _T_19; // @[AccountantExtPrice.scala 90:27 AccountantExtPrice.scala 43:23]
  wire  _T_20 = 3'h2 == regState; // @[Conditional.scala 37:30]
  wire [63:0] _GEN_1435 = {{32'd0}, io_rfInfo_nObjects}; // @[AccountantExtPrice.scala 117:23]
  wire  _T_21 = regWBCount == _GEN_1435; // @[AccountantExtPrice.scala 117:23]
  wire [5:0] _GEN_407 = 6'h1 == regWBCount[5:0] ? regAssignments_1_agent : regAssignments_0_agent; // @[AccountantExtPrice.scala 122:40 AccountantExtPrice.scala 122:40]
  wire [5:0] _GEN_409 = 6'h2 == regWBCount[5:0] ? regAssignments_2_agent : _GEN_407; // @[AccountantExtPrice.scala 122:40 AccountantExtPrice.scala 122:40]
  wire [5:0] _GEN_411 = 6'h3 == regWBCount[5:0] ? regAssignments_3_agent : _GEN_409; // @[AccountantExtPrice.scala 122:40 AccountantExtPrice.scala 122:40]
  wire [5:0] _GEN_413 = 6'h4 == regWBCount[5:0] ? regAssignments_4_agent : _GEN_411; // @[AccountantExtPrice.scala 122:40 AccountantExtPrice.scala 122:40]
  wire [5:0] _GEN_415 = 6'h5 == regWBCount[5:0] ? regAssignments_5_agent : _GEN_413; // @[AccountantExtPrice.scala 122:40 AccountantExtPrice.scala 122:40]
  wire [5:0] _GEN_417 = 6'h6 == regWBCount[5:0] ? regAssignments_6_agent : _GEN_415; // @[AccountantExtPrice.scala 122:40 AccountantExtPrice.scala 122:40]
  wire [5:0] _GEN_419 = 6'h7 == regWBCount[5:0] ? regAssignments_7_agent : _GEN_417; // @[AccountantExtPrice.scala 122:40 AccountantExtPrice.scala 122:40]
  wire [5:0] _GEN_421 = 6'h8 == regWBCount[5:0] ? regAssignments_8_agent : _GEN_419; // @[AccountantExtPrice.scala 122:40 AccountantExtPrice.scala 122:40]
  wire [5:0] _GEN_423 = 6'h9 == regWBCount[5:0] ? regAssignments_9_agent : _GEN_421; // @[AccountantExtPrice.scala 122:40 AccountantExtPrice.scala 122:40]
  wire [5:0] _GEN_425 = 6'ha == regWBCount[5:0] ? regAssignments_10_agent : _GEN_423; // @[AccountantExtPrice.scala 122:40 AccountantExtPrice.scala 122:40]
  wire [5:0] _GEN_427 = 6'hb == regWBCount[5:0] ? regAssignments_11_agent : _GEN_425; // @[AccountantExtPrice.scala 122:40 AccountantExtPrice.scala 122:40]
  wire [5:0] _GEN_429 = 6'hc == regWBCount[5:0] ? regAssignments_12_agent : _GEN_427; // @[AccountantExtPrice.scala 122:40 AccountantExtPrice.scala 122:40]
  wire [5:0] _GEN_431 = 6'hd == regWBCount[5:0] ? regAssignments_13_agent : _GEN_429; // @[AccountantExtPrice.scala 122:40 AccountantExtPrice.scala 122:40]
  wire [5:0] _GEN_433 = 6'he == regWBCount[5:0] ? regAssignments_14_agent : _GEN_431; // @[AccountantExtPrice.scala 122:40 AccountantExtPrice.scala 122:40]
  wire [5:0] _GEN_435 = 6'hf == regWBCount[5:0] ? regAssignments_15_agent : _GEN_433; // @[AccountantExtPrice.scala 122:40 AccountantExtPrice.scala 122:40]
  wire [5:0] _GEN_437 = 6'h10 == regWBCount[5:0] ? regAssignments_16_agent : _GEN_435; // @[AccountantExtPrice.scala 122:40 AccountantExtPrice.scala 122:40]
  wire [5:0] _GEN_439 = 6'h11 == regWBCount[5:0] ? regAssignments_17_agent : _GEN_437; // @[AccountantExtPrice.scala 122:40 AccountantExtPrice.scala 122:40]
  wire [5:0] _GEN_441 = 6'h12 == regWBCount[5:0] ? regAssignments_18_agent : _GEN_439; // @[AccountantExtPrice.scala 122:40 AccountantExtPrice.scala 122:40]
  wire [5:0] _GEN_443 = 6'h13 == regWBCount[5:0] ? regAssignments_19_agent : _GEN_441; // @[AccountantExtPrice.scala 122:40 AccountantExtPrice.scala 122:40]
  wire [5:0] _GEN_445 = 6'h14 == regWBCount[5:0] ? regAssignments_20_agent : _GEN_443; // @[AccountantExtPrice.scala 122:40 AccountantExtPrice.scala 122:40]
  wire [5:0] _GEN_447 = 6'h15 == regWBCount[5:0] ? regAssignments_21_agent : _GEN_445; // @[AccountantExtPrice.scala 122:40 AccountantExtPrice.scala 122:40]
  wire [5:0] _GEN_449 = 6'h16 == regWBCount[5:0] ? regAssignments_22_agent : _GEN_447; // @[AccountantExtPrice.scala 122:40 AccountantExtPrice.scala 122:40]
  wire [5:0] _GEN_451 = 6'h17 == regWBCount[5:0] ? regAssignments_23_agent : _GEN_449; // @[AccountantExtPrice.scala 122:40 AccountantExtPrice.scala 122:40]
  wire [5:0] _GEN_453 = 6'h18 == regWBCount[5:0] ? regAssignments_24_agent : _GEN_451; // @[AccountantExtPrice.scala 122:40 AccountantExtPrice.scala 122:40]
  wire [5:0] _GEN_455 = 6'h19 == regWBCount[5:0] ? regAssignments_25_agent : _GEN_453; // @[AccountantExtPrice.scala 122:40 AccountantExtPrice.scala 122:40]
  wire [5:0] _GEN_457 = 6'h1a == regWBCount[5:0] ? regAssignments_26_agent : _GEN_455; // @[AccountantExtPrice.scala 122:40 AccountantExtPrice.scala 122:40]
  wire [5:0] _GEN_459 = 6'h1b == regWBCount[5:0] ? regAssignments_27_agent : _GEN_457; // @[AccountantExtPrice.scala 122:40 AccountantExtPrice.scala 122:40]
  wire [5:0] _GEN_461 = 6'h1c == regWBCount[5:0] ? regAssignments_28_agent : _GEN_459; // @[AccountantExtPrice.scala 122:40 AccountantExtPrice.scala 122:40]
  wire [5:0] _GEN_463 = 6'h1d == regWBCount[5:0] ? regAssignments_29_agent : _GEN_461; // @[AccountantExtPrice.scala 122:40 AccountantExtPrice.scala 122:40]
  wire [5:0] _GEN_465 = 6'h1e == regWBCount[5:0] ? regAssignments_30_agent : _GEN_463; // @[AccountantExtPrice.scala 122:40 AccountantExtPrice.scala 122:40]
  wire [5:0] _GEN_467 = 6'h1f == regWBCount[5:0] ? regAssignments_31_agent : _GEN_465; // @[AccountantExtPrice.scala 122:40 AccountantExtPrice.scala 122:40]
  wire [5:0] _GEN_469 = 6'h20 == regWBCount[5:0] ? regAssignments_32_agent : _GEN_467; // @[AccountantExtPrice.scala 122:40 AccountantExtPrice.scala 122:40]
  wire [5:0] _GEN_471 = 6'h21 == regWBCount[5:0] ? regAssignments_33_agent : _GEN_469; // @[AccountantExtPrice.scala 122:40 AccountantExtPrice.scala 122:40]
  wire [5:0] _GEN_473 = 6'h22 == regWBCount[5:0] ? regAssignments_34_agent : _GEN_471; // @[AccountantExtPrice.scala 122:40 AccountantExtPrice.scala 122:40]
  wire [5:0] _GEN_475 = 6'h23 == regWBCount[5:0] ? regAssignments_35_agent : _GEN_473; // @[AccountantExtPrice.scala 122:40 AccountantExtPrice.scala 122:40]
  wire [5:0] _GEN_477 = 6'h24 == regWBCount[5:0] ? regAssignments_36_agent : _GEN_475; // @[AccountantExtPrice.scala 122:40 AccountantExtPrice.scala 122:40]
  wire [5:0] _GEN_479 = 6'h25 == regWBCount[5:0] ? regAssignments_37_agent : _GEN_477; // @[AccountantExtPrice.scala 122:40 AccountantExtPrice.scala 122:40]
  wire [5:0] _GEN_481 = 6'h26 == regWBCount[5:0] ? regAssignments_38_agent : _GEN_479; // @[AccountantExtPrice.scala 122:40 AccountantExtPrice.scala 122:40]
  wire [5:0] _GEN_483 = 6'h27 == regWBCount[5:0] ? regAssignments_39_agent : _GEN_481; // @[AccountantExtPrice.scala 122:40 AccountantExtPrice.scala 122:40]
  wire [5:0] _GEN_485 = 6'h28 == regWBCount[5:0] ? regAssignments_40_agent : _GEN_483; // @[AccountantExtPrice.scala 122:40 AccountantExtPrice.scala 122:40]
  wire [5:0] _GEN_487 = 6'h29 == regWBCount[5:0] ? regAssignments_41_agent : _GEN_485; // @[AccountantExtPrice.scala 122:40 AccountantExtPrice.scala 122:40]
  wire [5:0] _GEN_489 = 6'h2a == regWBCount[5:0] ? regAssignments_42_agent : _GEN_487; // @[AccountantExtPrice.scala 122:40 AccountantExtPrice.scala 122:40]
  wire [5:0] _GEN_491 = 6'h2b == regWBCount[5:0] ? regAssignments_43_agent : _GEN_489; // @[AccountantExtPrice.scala 122:40 AccountantExtPrice.scala 122:40]
  wire [5:0] _GEN_493 = 6'h2c == regWBCount[5:0] ? regAssignments_44_agent : _GEN_491; // @[AccountantExtPrice.scala 122:40 AccountantExtPrice.scala 122:40]
  wire [5:0] _GEN_495 = 6'h2d == regWBCount[5:0] ? regAssignments_45_agent : _GEN_493; // @[AccountantExtPrice.scala 122:40 AccountantExtPrice.scala 122:40]
  wire [5:0] _GEN_497 = 6'h2e == regWBCount[5:0] ? regAssignments_46_agent : _GEN_495; // @[AccountantExtPrice.scala 122:40 AccountantExtPrice.scala 122:40]
  wire [5:0] _GEN_499 = 6'h2f == regWBCount[5:0] ? regAssignments_47_agent : _GEN_497; // @[AccountantExtPrice.scala 122:40 AccountantExtPrice.scala 122:40]
  wire [5:0] _GEN_501 = 6'h30 == regWBCount[5:0] ? regAssignments_48_agent : _GEN_499; // @[AccountantExtPrice.scala 122:40 AccountantExtPrice.scala 122:40]
  wire [5:0] _GEN_503 = 6'h31 == regWBCount[5:0] ? regAssignments_49_agent : _GEN_501; // @[AccountantExtPrice.scala 122:40 AccountantExtPrice.scala 122:40]
  wire [5:0] _GEN_505 = 6'h32 == regWBCount[5:0] ? regAssignments_50_agent : _GEN_503; // @[AccountantExtPrice.scala 122:40 AccountantExtPrice.scala 122:40]
  wire [5:0] _GEN_507 = 6'h33 == regWBCount[5:0] ? regAssignments_51_agent : _GEN_505; // @[AccountantExtPrice.scala 122:40 AccountantExtPrice.scala 122:40]
  wire [5:0] _GEN_509 = 6'h34 == regWBCount[5:0] ? regAssignments_52_agent : _GEN_507; // @[AccountantExtPrice.scala 122:40 AccountantExtPrice.scala 122:40]
  wire [5:0] _GEN_511 = 6'h35 == regWBCount[5:0] ? regAssignments_53_agent : _GEN_509; // @[AccountantExtPrice.scala 122:40 AccountantExtPrice.scala 122:40]
  wire [5:0] _GEN_513 = 6'h36 == regWBCount[5:0] ? regAssignments_54_agent : _GEN_511; // @[AccountantExtPrice.scala 122:40 AccountantExtPrice.scala 122:40]
  wire [5:0] _GEN_515 = 6'h37 == regWBCount[5:0] ? regAssignments_55_agent : _GEN_513; // @[AccountantExtPrice.scala 122:40 AccountantExtPrice.scala 122:40]
  wire [5:0] _GEN_517 = 6'h38 == regWBCount[5:0] ? regAssignments_56_agent : _GEN_515; // @[AccountantExtPrice.scala 122:40 AccountantExtPrice.scala 122:40]
  wire [5:0] _GEN_519 = 6'h39 == regWBCount[5:0] ? regAssignments_57_agent : _GEN_517; // @[AccountantExtPrice.scala 122:40 AccountantExtPrice.scala 122:40]
  wire [5:0] _GEN_521 = 6'h3a == regWBCount[5:0] ? regAssignments_58_agent : _GEN_519; // @[AccountantExtPrice.scala 122:40 AccountantExtPrice.scala 122:40]
  wire [5:0] _GEN_523 = 6'h3b == regWBCount[5:0] ? regAssignments_59_agent : _GEN_521; // @[AccountantExtPrice.scala 122:40 AccountantExtPrice.scala 122:40]
  wire [5:0] _GEN_525 = 6'h3c == regWBCount[5:0] ? regAssignments_60_agent : _GEN_523; // @[AccountantExtPrice.scala 122:40 AccountantExtPrice.scala 122:40]
  wire [5:0] _GEN_527 = 6'h3d == regWBCount[5:0] ? regAssignments_61_agent : _GEN_525; // @[AccountantExtPrice.scala 122:40 AccountantExtPrice.scala 122:40]
  wire [5:0] _GEN_529 = 6'h3e == regWBCount[5:0] ? regAssignments_62_agent : _GEN_527; // @[AccountantExtPrice.scala 122:40 AccountantExtPrice.scala 122:40]
  wire [5:0] _GEN_531 = 6'h3f == regWBCount[5:0] ? regAssignments_63_agent : _GEN_529; // @[AccountantExtPrice.scala 122:40 AccountantExtPrice.scala 122:40]
  wire  _T_23 = io_writeBackStream_wrData_ready & io_writeBackStream_wrData_valid; // @[Decoupled.scala 40:37]
  wire [63:0] _T_25 = regWBCount + 64'h1; // @[AccountantExtPrice.scala 124:36]
  wire [63:0] _GEN_533 = _T_23 ? _T_25 : regWBCount; // @[AccountantExtPrice.scala 123:48 AccountantExtPrice.scala 124:22 AccountantExtPrice.scala 64:27]
  wire [63:0] _GEN_534 = regWBCount == _GEN_1435 ? 64'h0 : _GEN_533; // @[AccountantExtPrice.scala 117:47 AccountantExtPrice.scala 118:20]
  wire [2:0] _GEN_535 = regWBCount == _GEN_1435 ? 3'h3 : regState; // @[AccountantExtPrice.scala 117:47 AccountantExtPrice.scala 119:18 AccountantExtPrice.scala 62:25]
  wire  _GEN_536 = regWBCount == _GEN_1435 ? 1'h0 : 1'h1; // @[AccountantExtPrice.scala 117:47 AccountantExtPrice.scala 38:34 AccountantExtPrice.scala 121:41]
  wire  _T_26 = 3'h3 == regState; // @[Conditional.scala 37:30]
  wire [2:0] _GEN_540 = _T_21 ? 3'h4 : regState; // @[AccountantExtPrice.scala 130:48 AccountantExtPrice.scala 132:18 AccountantExtPrice.scala 62:25]
  wire  _T_35 = 3'h4 == regState; // @[Conditional.scala 37:30]
  wire [2:0] _GEN_545 = io_writeBackStream_finished ? 3'h0 : regState; // @[AccountantExtPrice.scala 143:53 AccountantExtPrice.scala 144:18 AccountantExtPrice.scala 62:25]
  wire  _GEN_546 = io_writeBackStream_finished ? 1'h0 : regAssignments_0_valid; // @[AccountantExtPrice.scala 143:53 AccountantExtPrice.scala 145:30 AccountantExtPrice.scala 53:31]
  wire [5:0] _GEN_547 = io_writeBackStream_finished ? 6'h0 : regAssignments_0_agent; // @[AccountantExtPrice.scala 143:53 AccountantExtPrice.scala 145:30 AccountantExtPrice.scala 53:31]
  wire  _GEN_548 = io_writeBackStream_finished ? 1'h0 : regAssignments_1_valid; // @[AccountantExtPrice.scala 143:53 AccountantExtPrice.scala 145:30 AccountantExtPrice.scala 53:31]
  wire [5:0] _GEN_549 = io_writeBackStream_finished ? 6'h0 : regAssignments_1_agent; // @[AccountantExtPrice.scala 143:53 AccountantExtPrice.scala 145:30 AccountantExtPrice.scala 53:31]
  wire  _GEN_550 = io_writeBackStream_finished ? 1'h0 : regAssignments_2_valid; // @[AccountantExtPrice.scala 143:53 AccountantExtPrice.scala 145:30 AccountantExtPrice.scala 53:31]
  wire [5:0] _GEN_551 = io_writeBackStream_finished ? 6'h0 : regAssignments_2_agent; // @[AccountantExtPrice.scala 143:53 AccountantExtPrice.scala 145:30 AccountantExtPrice.scala 53:31]
  wire  _GEN_552 = io_writeBackStream_finished ? 1'h0 : regAssignments_3_valid; // @[AccountantExtPrice.scala 143:53 AccountantExtPrice.scala 145:30 AccountantExtPrice.scala 53:31]
  wire [5:0] _GEN_553 = io_writeBackStream_finished ? 6'h0 : regAssignments_3_agent; // @[AccountantExtPrice.scala 143:53 AccountantExtPrice.scala 145:30 AccountantExtPrice.scala 53:31]
  wire  _GEN_554 = io_writeBackStream_finished ? 1'h0 : regAssignments_4_valid; // @[AccountantExtPrice.scala 143:53 AccountantExtPrice.scala 145:30 AccountantExtPrice.scala 53:31]
  wire [5:0] _GEN_555 = io_writeBackStream_finished ? 6'h0 : regAssignments_4_agent; // @[AccountantExtPrice.scala 143:53 AccountantExtPrice.scala 145:30 AccountantExtPrice.scala 53:31]
  wire  _GEN_556 = io_writeBackStream_finished ? 1'h0 : regAssignments_5_valid; // @[AccountantExtPrice.scala 143:53 AccountantExtPrice.scala 145:30 AccountantExtPrice.scala 53:31]
  wire [5:0] _GEN_557 = io_writeBackStream_finished ? 6'h0 : regAssignments_5_agent; // @[AccountantExtPrice.scala 143:53 AccountantExtPrice.scala 145:30 AccountantExtPrice.scala 53:31]
  wire  _GEN_558 = io_writeBackStream_finished ? 1'h0 : regAssignments_6_valid; // @[AccountantExtPrice.scala 143:53 AccountantExtPrice.scala 145:30 AccountantExtPrice.scala 53:31]
  wire [5:0] _GEN_559 = io_writeBackStream_finished ? 6'h0 : regAssignments_6_agent; // @[AccountantExtPrice.scala 143:53 AccountantExtPrice.scala 145:30 AccountantExtPrice.scala 53:31]
  wire  _GEN_560 = io_writeBackStream_finished ? 1'h0 : regAssignments_7_valid; // @[AccountantExtPrice.scala 143:53 AccountantExtPrice.scala 145:30 AccountantExtPrice.scala 53:31]
  wire [5:0] _GEN_561 = io_writeBackStream_finished ? 6'h0 : regAssignments_7_agent; // @[AccountantExtPrice.scala 143:53 AccountantExtPrice.scala 145:30 AccountantExtPrice.scala 53:31]
  wire  _GEN_562 = io_writeBackStream_finished ? 1'h0 : regAssignments_8_valid; // @[AccountantExtPrice.scala 143:53 AccountantExtPrice.scala 145:30 AccountantExtPrice.scala 53:31]
  wire [5:0] _GEN_563 = io_writeBackStream_finished ? 6'h0 : regAssignments_8_agent; // @[AccountantExtPrice.scala 143:53 AccountantExtPrice.scala 145:30 AccountantExtPrice.scala 53:31]
  wire  _GEN_564 = io_writeBackStream_finished ? 1'h0 : regAssignments_9_valid; // @[AccountantExtPrice.scala 143:53 AccountantExtPrice.scala 145:30 AccountantExtPrice.scala 53:31]
  wire [5:0] _GEN_565 = io_writeBackStream_finished ? 6'h0 : regAssignments_9_agent; // @[AccountantExtPrice.scala 143:53 AccountantExtPrice.scala 145:30 AccountantExtPrice.scala 53:31]
  wire  _GEN_566 = io_writeBackStream_finished ? 1'h0 : regAssignments_10_valid; // @[AccountantExtPrice.scala 143:53 AccountantExtPrice.scala 145:30 AccountantExtPrice.scala 53:31]
  wire [5:0] _GEN_567 = io_writeBackStream_finished ? 6'h0 : regAssignments_10_agent; // @[AccountantExtPrice.scala 143:53 AccountantExtPrice.scala 145:30 AccountantExtPrice.scala 53:31]
  wire  _GEN_568 = io_writeBackStream_finished ? 1'h0 : regAssignments_11_valid; // @[AccountantExtPrice.scala 143:53 AccountantExtPrice.scala 145:30 AccountantExtPrice.scala 53:31]
  wire [5:0] _GEN_569 = io_writeBackStream_finished ? 6'h0 : regAssignments_11_agent; // @[AccountantExtPrice.scala 143:53 AccountantExtPrice.scala 145:30 AccountantExtPrice.scala 53:31]
  wire  _GEN_570 = io_writeBackStream_finished ? 1'h0 : regAssignments_12_valid; // @[AccountantExtPrice.scala 143:53 AccountantExtPrice.scala 145:30 AccountantExtPrice.scala 53:31]
  wire [5:0] _GEN_571 = io_writeBackStream_finished ? 6'h0 : regAssignments_12_agent; // @[AccountantExtPrice.scala 143:53 AccountantExtPrice.scala 145:30 AccountantExtPrice.scala 53:31]
  wire  _GEN_572 = io_writeBackStream_finished ? 1'h0 : regAssignments_13_valid; // @[AccountantExtPrice.scala 143:53 AccountantExtPrice.scala 145:30 AccountantExtPrice.scala 53:31]
  wire [5:0] _GEN_573 = io_writeBackStream_finished ? 6'h0 : regAssignments_13_agent; // @[AccountantExtPrice.scala 143:53 AccountantExtPrice.scala 145:30 AccountantExtPrice.scala 53:31]
  wire  _GEN_574 = io_writeBackStream_finished ? 1'h0 : regAssignments_14_valid; // @[AccountantExtPrice.scala 143:53 AccountantExtPrice.scala 145:30 AccountantExtPrice.scala 53:31]
  wire [5:0] _GEN_575 = io_writeBackStream_finished ? 6'h0 : regAssignments_14_agent; // @[AccountantExtPrice.scala 143:53 AccountantExtPrice.scala 145:30 AccountantExtPrice.scala 53:31]
  wire  _GEN_576 = io_writeBackStream_finished ? 1'h0 : regAssignments_15_valid; // @[AccountantExtPrice.scala 143:53 AccountantExtPrice.scala 145:30 AccountantExtPrice.scala 53:31]
  wire [5:0] _GEN_577 = io_writeBackStream_finished ? 6'h0 : regAssignments_15_agent; // @[AccountantExtPrice.scala 143:53 AccountantExtPrice.scala 145:30 AccountantExtPrice.scala 53:31]
  wire  _GEN_578 = io_writeBackStream_finished ? 1'h0 : regAssignments_16_valid; // @[AccountantExtPrice.scala 143:53 AccountantExtPrice.scala 145:30 AccountantExtPrice.scala 53:31]
  wire [5:0] _GEN_579 = io_writeBackStream_finished ? 6'h0 : regAssignments_16_agent; // @[AccountantExtPrice.scala 143:53 AccountantExtPrice.scala 145:30 AccountantExtPrice.scala 53:31]
  wire  _GEN_580 = io_writeBackStream_finished ? 1'h0 : regAssignments_17_valid; // @[AccountantExtPrice.scala 143:53 AccountantExtPrice.scala 145:30 AccountantExtPrice.scala 53:31]
  wire [5:0] _GEN_581 = io_writeBackStream_finished ? 6'h0 : regAssignments_17_agent; // @[AccountantExtPrice.scala 143:53 AccountantExtPrice.scala 145:30 AccountantExtPrice.scala 53:31]
  wire  _GEN_582 = io_writeBackStream_finished ? 1'h0 : regAssignments_18_valid; // @[AccountantExtPrice.scala 143:53 AccountantExtPrice.scala 145:30 AccountantExtPrice.scala 53:31]
  wire [5:0] _GEN_583 = io_writeBackStream_finished ? 6'h0 : regAssignments_18_agent; // @[AccountantExtPrice.scala 143:53 AccountantExtPrice.scala 145:30 AccountantExtPrice.scala 53:31]
  wire  _GEN_584 = io_writeBackStream_finished ? 1'h0 : regAssignments_19_valid; // @[AccountantExtPrice.scala 143:53 AccountantExtPrice.scala 145:30 AccountantExtPrice.scala 53:31]
  wire [5:0] _GEN_585 = io_writeBackStream_finished ? 6'h0 : regAssignments_19_agent; // @[AccountantExtPrice.scala 143:53 AccountantExtPrice.scala 145:30 AccountantExtPrice.scala 53:31]
  wire  _GEN_586 = io_writeBackStream_finished ? 1'h0 : regAssignments_20_valid; // @[AccountantExtPrice.scala 143:53 AccountantExtPrice.scala 145:30 AccountantExtPrice.scala 53:31]
  wire [5:0] _GEN_587 = io_writeBackStream_finished ? 6'h0 : regAssignments_20_agent; // @[AccountantExtPrice.scala 143:53 AccountantExtPrice.scala 145:30 AccountantExtPrice.scala 53:31]
  wire  _GEN_588 = io_writeBackStream_finished ? 1'h0 : regAssignments_21_valid; // @[AccountantExtPrice.scala 143:53 AccountantExtPrice.scala 145:30 AccountantExtPrice.scala 53:31]
  wire [5:0] _GEN_589 = io_writeBackStream_finished ? 6'h0 : regAssignments_21_agent; // @[AccountantExtPrice.scala 143:53 AccountantExtPrice.scala 145:30 AccountantExtPrice.scala 53:31]
  wire  _GEN_590 = io_writeBackStream_finished ? 1'h0 : regAssignments_22_valid; // @[AccountantExtPrice.scala 143:53 AccountantExtPrice.scala 145:30 AccountantExtPrice.scala 53:31]
  wire [5:0] _GEN_591 = io_writeBackStream_finished ? 6'h0 : regAssignments_22_agent; // @[AccountantExtPrice.scala 143:53 AccountantExtPrice.scala 145:30 AccountantExtPrice.scala 53:31]
  wire  _GEN_592 = io_writeBackStream_finished ? 1'h0 : regAssignments_23_valid; // @[AccountantExtPrice.scala 143:53 AccountantExtPrice.scala 145:30 AccountantExtPrice.scala 53:31]
  wire [5:0] _GEN_593 = io_writeBackStream_finished ? 6'h0 : regAssignments_23_agent; // @[AccountantExtPrice.scala 143:53 AccountantExtPrice.scala 145:30 AccountantExtPrice.scala 53:31]
  wire  _GEN_594 = io_writeBackStream_finished ? 1'h0 : regAssignments_24_valid; // @[AccountantExtPrice.scala 143:53 AccountantExtPrice.scala 145:30 AccountantExtPrice.scala 53:31]
  wire [5:0] _GEN_595 = io_writeBackStream_finished ? 6'h0 : regAssignments_24_agent; // @[AccountantExtPrice.scala 143:53 AccountantExtPrice.scala 145:30 AccountantExtPrice.scala 53:31]
  wire  _GEN_596 = io_writeBackStream_finished ? 1'h0 : regAssignments_25_valid; // @[AccountantExtPrice.scala 143:53 AccountantExtPrice.scala 145:30 AccountantExtPrice.scala 53:31]
  wire [5:0] _GEN_597 = io_writeBackStream_finished ? 6'h0 : regAssignments_25_agent; // @[AccountantExtPrice.scala 143:53 AccountantExtPrice.scala 145:30 AccountantExtPrice.scala 53:31]
  wire  _GEN_598 = io_writeBackStream_finished ? 1'h0 : regAssignments_26_valid; // @[AccountantExtPrice.scala 143:53 AccountantExtPrice.scala 145:30 AccountantExtPrice.scala 53:31]
  wire [5:0] _GEN_599 = io_writeBackStream_finished ? 6'h0 : regAssignments_26_agent; // @[AccountantExtPrice.scala 143:53 AccountantExtPrice.scala 145:30 AccountantExtPrice.scala 53:31]
  wire  _GEN_600 = io_writeBackStream_finished ? 1'h0 : regAssignments_27_valid; // @[AccountantExtPrice.scala 143:53 AccountantExtPrice.scala 145:30 AccountantExtPrice.scala 53:31]
  wire [5:0] _GEN_601 = io_writeBackStream_finished ? 6'h0 : regAssignments_27_agent; // @[AccountantExtPrice.scala 143:53 AccountantExtPrice.scala 145:30 AccountantExtPrice.scala 53:31]
  wire  _GEN_602 = io_writeBackStream_finished ? 1'h0 : regAssignments_28_valid; // @[AccountantExtPrice.scala 143:53 AccountantExtPrice.scala 145:30 AccountantExtPrice.scala 53:31]
  wire [5:0] _GEN_603 = io_writeBackStream_finished ? 6'h0 : regAssignments_28_agent; // @[AccountantExtPrice.scala 143:53 AccountantExtPrice.scala 145:30 AccountantExtPrice.scala 53:31]
  wire  _GEN_604 = io_writeBackStream_finished ? 1'h0 : regAssignments_29_valid; // @[AccountantExtPrice.scala 143:53 AccountantExtPrice.scala 145:30 AccountantExtPrice.scala 53:31]
  wire [5:0] _GEN_605 = io_writeBackStream_finished ? 6'h0 : regAssignments_29_agent; // @[AccountantExtPrice.scala 143:53 AccountantExtPrice.scala 145:30 AccountantExtPrice.scala 53:31]
  wire  _GEN_606 = io_writeBackStream_finished ? 1'h0 : regAssignments_30_valid; // @[AccountantExtPrice.scala 143:53 AccountantExtPrice.scala 145:30 AccountantExtPrice.scala 53:31]
  wire [5:0] _GEN_607 = io_writeBackStream_finished ? 6'h0 : regAssignments_30_agent; // @[AccountantExtPrice.scala 143:53 AccountantExtPrice.scala 145:30 AccountantExtPrice.scala 53:31]
  wire  _GEN_608 = io_writeBackStream_finished ? 1'h0 : regAssignments_31_valid; // @[AccountantExtPrice.scala 143:53 AccountantExtPrice.scala 145:30 AccountantExtPrice.scala 53:31]
  wire [5:0] _GEN_609 = io_writeBackStream_finished ? 6'h0 : regAssignments_31_agent; // @[AccountantExtPrice.scala 143:53 AccountantExtPrice.scala 145:30 AccountantExtPrice.scala 53:31]
  wire  _GEN_610 = io_writeBackStream_finished ? 1'h0 : regAssignments_32_valid; // @[AccountantExtPrice.scala 143:53 AccountantExtPrice.scala 145:30 AccountantExtPrice.scala 53:31]
  wire [5:0] _GEN_611 = io_writeBackStream_finished ? 6'h0 : regAssignments_32_agent; // @[AccountantExtPrice.scala 143:53 AccountantExtPrice.scala 145:30 AccountantExtPrice.scala 53:31]
  wire  _GEN_612 = io_writeBackStream_finished ? 1'h0 : regAssignments_33_valid; // @[AccountantExtPrice.scala 143:53 AccountantExtPrice.scala 145:30 AccountantExtPrice.scala 53:31]
  wire [5:0] _GEN_613 = io_writeBackStream_finished ? 6'h0 : regAssignments_33_agent; // @[AccountantExtPrice.scala 143:53 AccountantExtPrice.scala 145:30 AccountantExtPrice.scala 53:31]
  wire  _GEN_614 = io_writeBackStream_finished ? 1'h0 : regAssignments_34_valid; // @[AccountantExtPrice.scala 143:53 AccountantExtPrice.scala 145:30 AccountantExtPrice.scala 53:31]
  wire [5:0] _GEN_615 = io_writeBackStream_finished ? 6'h0 : regAssignments_34_agent; // @[AccountantExtPrice.scala 143:53 AccountantExtPrice.scala 145:30 AccountantExtPrice.scala 53:31]
  wire  _GEN_616 = io_writeBackStream_finished ? 1'h0 : regAssignments_35_valid; // @[AccountantExtPrice.scala 143:53 AccountantExtPrice.scala 145:30 AccountantExtPrice.scala 53:31]
  wire [5:0] _GEN_617 = io_writeBackStream_finished ? 6'h0 : regAssignments_35_agent; // @[AccountantExtPrice.scala 143:53 AccountantExtPrice.scala 145:30 AccountantExtPrice.scala 53:31]
  wire  _GEN_618 = io_writeBackStream_finished ? 1'h0 : regAssignments_36_valid; // @[AccountantExtPrice.scala 143:53 AccountantExtPrice.scala 145:30 AccountantExtPrice.scala 53:31]
  wire [5:0] _GEN_619 = io_writeBackStream_finished ? 6'h0 : regAssignments_36_agent; // @[AccountantExtPrice.scala 143:53 AccountantExtPrice.scala 145:30 AccountantExtPrice.scala 53:31]
  wire  _GEN_620 = io_writeBackStream_finished ? 1'h0 : regAssignments_37_valid; // @[AccountantExtPrice.scala 143:53 AccountantExtPrice.scala 145:30 AccountantExtPrice.scala 53:31]
  wire [5:0] _GEN_621 = io_writeBackStream_finished ? 6'h0 : regAssignments_37_agent; // @[AccountantExtPrice.scala 143:53 AccountantExtPrice.scala 145:30 AccountantExtPrice.scala 53:31]
  wire  _GEN_622 = io_writeBackStream_finished ? 1'h0 : regAssignments_38_valid; // @[AccountantExtPrice.scala 143:53 AccountantExtPrice.scala 145:30 AccountantExtPrice.scala 53:31]
  wire [5:0] _GEN_623 = io_writeBackStream_finished ? 6'h0 : regAssignments_38_agent; // @[AccountantExtPrice.scala 143:53 AccountantExtPrice.scala 145:30 AccountantExtPrice.scala 53:31]
  wire  _GEN_624 = io_writeBackStream_finished ? 1'h0 : regAssignments_39_valid; // @[AccountantExtPrice.scala 143:53 AccountantExtPrice.scala 145:30 AccountantExtPrice.scala 53:31]
  wire [5:0] _GEN_625 = io_writeBackStream_finished ? 6'h0 : regAssignments_39_agent; // @[AccountantExtPrice.scala 143:53 AccountantExtPrice.scala 145:30 AccountantExtPrice.scala 53:31]
  wire  _GEN_626 = io_writeBackStream_finished ? 1'h0 : regAssignments_40_valid; // @[AccountantExtPrice.scala 143:53 AccountantExtPrice.scala 145:30 AccountantExtPrice.scala 53:31]
  wire [5:0] _GEN_627 = io_writeBackStream_finished ? 6'h0 : regAssignments_40_agent; // @[AccountantExtPrice.scala 143:53 AccountantExtPrice.scala 145:30 AccountantExtPrice.scala 53:31]
  wire  _GEN_628 = io_writeBackStream_finished ? 1'h0 : regAssignments_41_valid; // @[AccountantExtPrice.scala 143:53 AccountantExtPrice.scala 145:30 AccountantExtPrice.scala 53:31]
  wire [5:0] _GEN_629 = io_writeBackStream_finished ? 6'h0 : regAssignments_41_agent; // @[AccountantExtPrice.scala 143:53 AccountantExtPrice.scala 145:30 AccountantExtPrice.scala 53:31]
  wire  _GEN_630 = io_writeBackStream_finished ? 1'h0 : regAssignments_42_valid; // @[AccountantExtPrice.scala 143:53 AccountantExtPrice.scala 145:30 AccountantExtPrice.scala 53:31]
  wire [5:0] _GEN_631 = io_writeBackStream_finished ? 6'h0 : regAssignments_42_agent; // @[AccountantExtPrice.scala 143:53 AccountantExtPrice.scala 145:30 AccountantExtPrice.scala 53:31]
  wire  _GEN_632 = io_writeBackStream_finished ? 1'h0 : regAssignments_43_valid; // @[AccountantExtPrice.scala 143:53 AccountantExtPrice.scala 145:30 AccountantExtPrice.scala 53:31]
  wire [5:0] _GEN_633 = io_writeBackStream_finished ? 6'h0 : regAssignments_43_agent; // @[AccountantExtPrice.scala 143:53 AccountantExtPrice.scala 145:30 AccountantExtPrice.scala 53:31]
  wire  _GEN_634 = io_writeBackStream_finished ? 1'h0 : regAssignments_44_valid; // @[AccountantExtPrice.scala 143:53 AccountantExtPrice.scala 145:30 AccountantExtPrice.scala 53:31]
  wire [5:0] _GEN_635 = io_writeBackStream_finished ? 6'h0 : regAssignments_44_agent; // @[AccountantExtPrice.scala 143:53 AccountantExtPrice.scala 145:30 AccountantExtPrice.scala 53:31]
  wire  _GEN_636 = io_writeBackStream_finished ? 1'h0 : regAssignments_45_valid; // @[AccountantExtPrice.scala 143:53 AccountantExtPrice.scala 145:30 AccountantExtPrice.scala 53:31]
  wire [5:0] _GEN_637 = io_writeBackStream_finished ? 6'h0 : regAssignments_45_agent; // @[AccountantExtPrice.scala 143:53 AccountantExtPrice.scala 145:30 AccountantExtPrice.scala 53:31]
  wire  _GEN_638 = io_writeBackStream_finished ? 1'h0 : regAssignments_46_valid; // @[AccountantExtPrice.scala 143:53 AccountantExtPrice.scala 145:30 AccountantExtPrice.scala 53:31]
  wire [5:0] _GEN_639 = io_writeBackStream_finished ? 6'h0 : regAssignments_46_agent; // @[AccountantExtPrice.scala 143:53 AccountantExtPrice.scala 145:30 AccountantExtPrice.scala 53:31]
  wire  _GEN_640 = io_writeBackStream_finished ? 1'h0 : regAssignments_47_valid; // @[AccountantExtPrice.scala 143:53 AccountantExtPrice.scala 145:30 AccountantExtPrice.scala 53:31]
  wire [5:0] _GEN_641 = io_writeBackStream_finished ? 6'h0 : regAssignments_47_agent; // @[AccountantExtPrice.scala 143:53 AccountantExtPrice.scala 145:30 AccountantExtPrice.scala 53:31]
  wire  _GEN_642 = io_writeBackStream_finished ? 1'h0 : regAssignments_48_valid; // @[AccountantExtPrice.scala 143:53 AccountantExtPrice.scala 145:30 AccountantExtPrice.scala 53:31]
  wire [5:0] _GEN_643 = io_writeBackStream_finished ? 6'h0 : regAssignments_48_agent; // @[AccountantExtPrice.scala 143:53 AccountantExtPrice.scala 145:30 AccountantExtPrice.scala 53:31]
  wire  _GEN_644 = io_writeBackStream_finished ? 1'h0 : regAssignments_49_valid; // @[AccountantExtPrice.scala 143:53 AccountantExtPrice.scala 145:30 AccountantExtPrice.scala 53:31]
  wire [5:0] _GEN_645 = io_writeBackStream_finished ? 6'h0 : regAssignments_49_agent; // @[AccountantExtPrice.scala 143:53 AccountantExtPrice.scala 145:30 AccountantExtPrice.scala 53:31]
  wire  _GEN_646 = io_writeBackStream_finished ? 1'h0 : regAssignments_50_valid; // @[AccountantExtPrice.scala 143:53 AccountantExtPrice.scala 145:30 AccountantExtPrice.scala 53:31]
  wire [5:0] _GEN_647 = io_writeBackStream_finished ? 6'h0 : regAssignments_50_agent; // @[AccountantExtPrice.scala 143:53 AccountantExtPrice.scala 145:30 AccountantExtPrice.scala 53:31]
  wire  _GEN_648 = io_writeBackStream_finished ? 1'h0 : regAssignments_51_valid; // @[AccountantExtPrice.scala 143:53 AccountantExtPrice.scala 145:30 AccountantExtPrice.scala 53:31]
  wire [5:0] _GEN_649 = io_writeBackStream_finished ? 6'h0 : regAssignments_51_agent; // @[AccountantExtPrice.scala 143:53 AccountantExtPrice.scala 145:30 AccountantExtPrice.scala 53:31]
  wire  _GEN_650 = io_writeBackStream_finished ? 1'h0 : regAssignments_52_valid; // @[AccountantExtPrice.scala 143:53 AccountantExtPrice.scala 145:30 AccountantExtPrice.scala 53:31]
  wire [5:0] _GEN_651 = io_writeBackStream_finished ? 6'h0 : regAssignments_52_agent; // @[AccountantExtPrice.scala 143:53 AccountantExtPrice.scala 145:30 AccountantExtPrice.scala 53:31]
  wire  _GEN_652 = io_writeBackStream_finished ? 1'h0 : regAssignments_53_valid; // @[AccountantExtPrice.scala 143:53 AccountantExtPrice.scala 145:30 AccountantExtPrice.scala 53:31]
  wire [5:0] _GEN_653 = io_writeBackStream_finished ? 6'h0 : regAssignments_53_agent; // @[AccountantExtPrice.scala 143:53 AccountantExtPrice.scala 145:30 AccountantExtPrice.scala 53:31]
  wire  _GEN_654 = io_writeBackStream_finished ? 1'h0 : regAssignments_54_valid; // @[AccountantExtPrice.scala 143:53 AccountantExtPrice.scala 145:30 AccountantExtPrice.scala 53:31]
  wire [5:0] _GEN_655 = io_writeBackStream_finished ? 6'h0 : regAssignments_54_agent; // @[AccountantExtPrice.scala 143:53 AccountantExtPrice.scala 145:30 AccountantExtPrice.scala 53:31]
  wire  _GEN_656 = io_writeBackStream_finished ? 1'h0 : regAssignments_55_valid; // @[AccountantExtPrice.scala 143:53 AccountantExtPrice.scala 145:30 AccountantExtPrice.scala 53:31]
  wire [5:0] _GEN_657 = io_writeBackStream_finished ? 6'h0 : regAssignments_55_agent; // @[AccountantExtPrice.scala 143:53 AccountantExtPrice.scala 145:30 AccountantExtPrice.scala 53:31]
  wire  _GEN_658 = io_writeBackStream_finished ? 1'h0 : regAssignments_56_valid; // @[AccountantExtPrice.scala 143:53 AccountantExtPrice.scala 145:30 AccountantExtPrice.scala 53:31]
  wire [5:0] _GEN_659 = io_writeBackStream_finished ? 6'h0 : regAssignments_56_agent; // @[AccountantExtPrice.scala 143:53 AccountantExtPrice.scala 145:30 AccountantExtPrice.scala 53:31]
  wire  _GEN_660 = io_writeBackStream_finished ? 1'h0 : regAssignments_57_valid; // @[AccountantExtPrice.scala 143:53 AccountantExtPrice.scala 145:30 AccountantExtPrice.scala 53:31]
  wire [5:0] _GEN_661 = io_writeBackStream_finished ? 6'h0 : regAssignments_57_agent; // @[AccountantExtPrice.scala 143:53 AccountantExtPrice.scala 145:30 AccountantExtPrice.scala 53:31]
  wire  _GEN_662 = io_writeBackStream_finished ? 1'h0 : regAssignments_58_valid; // @[AccountantExtPrice.scala 143:53 AccountantExtPrice.scala 145:30 AccountantExtPrice.scala 53:31]
  wire [5:0] _GEN_663 = io_writeBackStream_finished ? 6'h0 : regAssignments_58_agent; // @[AccountantExtPrice.scala 143:53 AccountantExtPrice.scala 145:30 AccountantExtPrice.scala 53:31]
  wire  _GEN_664 = io_writeBackStream_finished ? 1'h0 : regAssignments_59_valid; // @[AccountantExtPrice.scala 143:53 AccountantExtPrice.scala 145:30 AccountantExtPrice.scala 53:31]
  wire [5:0] _GEN_665 = io_writeBackStream_finished ? 6'h0 : regAssignments_59_agent; // @[AccountantExtPrice.scala 143:53 AccountantExtPrice.scala 145:30 AccountantExtPrice.scala 53:31]
  wire  _GEN_666 = io_writeBackStream_finished ? 1'h0 : regAssignments_60_valid; // @[AccountantExtPrice.scala 143:53 AccountantExtPrice.scala 145:30 AccountantExtPrice.scala 53:31]
  wire [5:0] _GEN_667 = io_writeBackStream_finished ? 6'h0 : regAssignments_60_agent; // @[AccountantExtPrice.scala 143:53 AccountantExtPrice.scala 145:30 AccountantExtPrice.scala 53:31]
  wire  _GEN_668 = io_writeBackStream_finished ? 1'h0 : regAssignments_61_valid; // @[AccountantExtPrice.scala 143:53 AccountantExtPrice.scala 145:30 AccountantExtPrice.scala 53:31]
  wire [5:0] _GEN_669 = io_writeBackStream_finished ? 6'h0 : regAssignments_61_agent; // @[AccountantExtPrice.scala 143:53 AccountantExtPrice.scala 145:30 AccountantExtPrice.scala 53:31]
  wire  _GEN_670 = io_writeBackStream_finished ? 1'h0 : regAssignments_62_valid; // @[AccountantExtPrice.scala 143:53 AccountantExtPrice.scala 145:30 AccountantExtPrice.scala 53:31]
  wire [5:0] _GEN_671 = io_writeBackStream_finished ? 6'h0 : regAssignments_62_agent; // @[AccountantExtPrice.scala 143:53 AccountantExtPrice.scala 145:30 AccountantExtPrice.scala 53:31]
  wire  _GEN_672 = io_writeBackStream_finished ? 1'h0 : regAssignments_63_valid; // @[AccountantExtPrice.scala 143:53 AccountantExtPrice.scala 145:30 AccountantExtPrice.scala 53:31]
  wire [5:0] _GEN_673 = io_writeBackStream_finished ? 6'h0 : regAssignments_63_agent; // @[AccountantExtPrice.scala 143:53 AccountantExtPrice.scala 145:30 AccountantExtPrice.scala 53:31]
  wire [2:0] _GEN_676 = _T_35 ? _GEN_545 : regState; // @[Conditional.scala 39:67 AccountantExtPrice.scala 62:25]
  wire  _GEN_677 = _T_35 ? _GEN_546 : regAssignments_0_valid; // @[Conditional.scala 39:67 AccountantExtPrice.scala 53:31]
  wire [5:0] _GEN_678 = _T_35 ? _GEN_547 : regAssignments_0_agent; // @[Conditional.scala 39:67 AccountantExtPrice.scala 53:31]
  wire  _GEN_679 = _T_35 ? _GEN_548 : regAssignments_1_valid; // @[Conditional.scala 39:67 AccountantExtPrice.scala 53:31]
  wire [5:0] _GEN_680 = _T_35 ? _GEN_549 : regAssignments_1_agent; // @[Conditional.scala 39:67 AccountantExtPrice.scala 53:31]
  wire  _GEN_681 = _T_35 ? _GEN_550 : regAssignments_2_valid; // @[Conditional.scala 39:67 AccountantExtPrice.scala 53:31]
  wire [5:0] _GEN_682 = _T_35 ? _GEN_551 : regAssignments_2_agent; // @[Conditional.scala 39:67 AccountantExtPrice.scala 53:31]
  wire  _GEN_683 = _T_35 ? _GEN_552 : regAssignments_3_valid; // @[Conditional.scala 39:67 AccountantExtPrice.scala 53:31]
  wire [5:0] _GEN_684 = _T_35 ? _GEN_553 : regAssignments_3_agent; // @[Conditional.scala 39:67 AccountantExtPrice.scala 53:31]
  wire  _GEN_685 = _T_35 ? _GEN_554 : regAssignments_4_valid; // @[Conditional.scala 39:67 AccountantExtPrice.scala 53:31]
  wire [5:0] _GEN_686 = _T_35 ? _GEN_555 : regAssignments_4_agent; // @[Conditional.scala 39:67 AccountantExtPrice.scala 53:31]
  wire  _GEN_687 = _T_35 ? _GEN_556 : regAssignments_5_valid; // @[Conditional.scala 39:67 AccountantExtPrice.scala 53:31]
  wire [5:0] _GEN_688 = _T_35 ? _GEN_557 : regAssignments_5_agent; // @[Conditional.scala 39:67 AccountantExtPrice.scala 53:31]
  wire  _GEN_689 = _T_35 ? _GEN_558 : regAssignments_6_valid; // @[Conditional.scala 39:67 AccountantExtPrice.scala 53:31]
  wire [5:0] _GEN_690 = _T_35 ? _GEN_559 : regAssignments_6_agent; // @[Conditional.scala 39:67 AccountantExtPrice.scala 53:31]
  wire  _GEN_691 = _T_35 ? _GEN_560 : regAssignments_7_valid; // @[Conditional.scala 39:67 AccountantExtPrice.scala 53:31]
  wire [5:0] _GEN_692 = _T_35 ? _GEN_561 : regAssignments_7_agent; // @[Conditional.scala 39:67 AccountantExtPrice.scala 53:31]
  wire  _GEN_693 = _T_35 ? _GEN_562 : regAssignments_8_valid; // @[Conditional.scala 39:67 AccountantExtPrice.scala 53:31]
  wire [5:0] _GEN_694 = _T_35 ? _GEN_563 : regAssignments_8_agent; // @[Conditional.scala 39:67 AccountantExtPrice.scala 53:31]
  wire  _GEN_695 = _T_35 ? _GEN_564 : regAssignments_9_valid; // @[Conditional.scala 39:67 AccountantExtPrice.scala 53:31]
  wire [5:0] _GEN_696 = _T_35 ? _GEN_565 : regAssignments_9_agent; // @[Conditional.scala 39:67 AccountantExtPrice.scala 53:31]
  wire  _GEN_697 = _T_35 ? _GEN_566 : regAssignments_10_valid; // @[Conditional.scala 39:67 AccountantExtPrice.scala 53:31]
  wire [5:0] _GEN_698 = _T_35 ? _GEN_567 : regAssignments_10_agent; // @[Conditional.scala 39:67 AccountantExtPrice.scala 53:31]
  wire  _GEN_699 = _T_35 ? _GEN_568 : regAssignments_11_valid; // @[Conditional.scala 39:67 AccountantExtPrice.scala 53:31]
  wire [5:0] _GEN_700 = _T_35 ? _GEN_569 : regAssignments_11_agent; // @[Conditional.scala 39:67 AccountantExtPrice.scala 53:31]
  wire  _GEN_701 = _T_35 ? _GEN_570 : regAssignments_12_valid; // @[Conditional.scala 39:67 AccountantExtPrice.scala 53:31]
  wire [5:0] _GEN_702 = _T_35 ? _GEN_571 : regAssignments_12_agent; // @[Conditional.scala 39:67 AccountantExtPrice.scala 53:31]
  wire  _GEN_703 = _T_35 ? _GEN_572 : regAssignments_13_valid; // @[Conditional.scala 39:67 AccountantExtPrice.scala 53:31]
  wire [5:0] _GEN_704 = _T_35 ? _GEN_573 : regAssignments_13_agent; // @[Conditional.scala 39:67 AccountantExtPrice.scala 53:31]
  wire  _GEN_705 = _T_35 ? _GEN_574 : regAssignments_14_valid; // @[Conditional.scala 39:67 AccountantExtPrice.scala 53:31]
  wire [5:0] _GEN_706 = _T_35 ? _GEN_575 : regAssignments_14_agent; // @[Conditional.scala 39:67 AccountantExtPrice.scala 53:31]
  wire  _GEN_707 = _T_35 ? _GEN_576 : regAssignments_15_valid; // @[Conditional.scala 39:67 AccountantExtPrice.scala 53:31]
  wire [5:0] _GEN_708 = _T_35 ? _GEN_577 : regAssignments_15_agent; // @[Conditional.scala 39:67 AccountantExtPrice.scala 53:31]
  wire  _GEN_709 = _T_35 ? _GEN_578 : regAssignments_16_valid; // @[Conditional.scala 39:67 AccountantExtPrice.scala 53:31]
  wire [5:0] _GEN_710 = _T_35 ? _GEN_579 : regAssignments_16_agent; // @[Conditional.scala 39:67 AccountantExtPrice.scala 53:31]
  wire  _GEN_711 = _T_35 ? _GEN_580 : regAssignments_17_valid; // @[Conditional.scala 39:67 AccountantExtPrice.scala 53:31]
  wire [5:0] _GEN_712 = _T_35 ? _GEN_581 : regAssignments_17_agent; // @[Conditional.scala 39:67 AccountantExtPrice.scala 53:31]
  wire  _GEN_713 = _T_35 ? _GEN_582 : regAssignments_18_valid; // @[Conditional.scala 39:67 AccountantExtPrice.scala 53:31]
  wire [5:0] _GEN_714 = _T_35 ? _GEN_583 : regAssignments_18_agent; // @[Conditional.scala 39:67 AccountantExtPrice.scala 53:31]
  wire  _GEN_715 = _T_35 ? _GEN_584 : regAssignments_19_valid; // @[Conditional.scala 39:67 AccountantExtPrice.scala 53:31]
  wire [5:0] _GEN_716 = _T_35 ? _GEN_585 : regAssignments_19_agent; // @[Conditional.scala 39:67 AccountantExtPrice.scala 53:31]
  wire  _GEN_717 = _T_35 ? _GEN_586 : regAssignments_20_valid; // @[Conditional.scala 39:67 AccountantExtPrice.scala 53:31]
  wire [5:0] _GEN_718 = _T_35 ? _GEN_587 : regAssignments_20_agent; // @[Conditional.scala 39:67 AccountantExtPrice.scala 53:31]
  wire  _GEN_719 = _T_35 ? _GEN_588 : regAssignments_21_valid; // @[Conditional.scala 39:67 AccountantExtPrice.scala 53:31]
  wire [5:0] _GEN_720 = _T_35 ? _GEN_589 : regAssignments_21_agent; // @[Conditional.scala 39:67 AccountantExtPrice.scala 53:31]
  wire  _GEN_721 = _T_35 ? _GEN_590 : regAssignments_22_valid; // @[Conditional.scala 39:67 AccountantExtPrice.scala 53:31]
  wire [5:0] _GEN_722 = _T_35 ? _GEN_591 : regAssignments_22_agent; // @[Conditional.scala 39:67 AccountantExtPrice.scala 53:31]
  wire  _GEN_723 = _T_35 ? _GEN_592 : regAssignments_23_valid; // @[Conditional.scala 39:67 AccountantExtPrice.scala 53:31]
  wire [5:0] _GEN_724 = _T_35 ? _GEN_593 : regAssignments_23_agent; // @[Conditional.scala 39:67 AccountantExtPrice.scala 53:31]
  wire  _GEN_725 = _T_35 ? _GEN_594 : regAssignments_24_valid; // @[Conditional.scala 39:67 AccountantExtPrice.scala 53:31]
  wire [5:0] _GEN_726 = _T_35 ? _GEN_595 : regAssignments_24_agent; // @[Conditional.scala 39:67 AccountantExtPrice.scala 53:31]
  wire  _GEN_727 = _T_35 ? _GEN_596 : regAssignments_25_valid; // @[Conditional.scala 39:67 AccountantExtPrice.scala 53:31]
  wire [5:0] _GEN_728 = _T_35 ? _GEN_597 : regAssignments_25_agent; // @[Conditional.scala 39:67 AccountantExtPrice.scala 53:31]
  wire  _GEN_729 = _T_35 ? _GEN_598 : regAssignments_26_valid; // @[Conditional.scala 39:67 AccountantExtPrice.scala 53:31]
  wire [5:0] _GEN_730 = _T_35 ? _GEN_599 : regAssignments_26_agent; // @[Conditional.scala 39:67 AccountantExtPrice.scala 53:31]
  wire  _GEN_731 = _T_35 ? _GEN_600 : regAssignments_27_valid; // @[Conditional.scala 39:67 AccountantExtPrice.scala 53:31]
  wire [5:0] _GEN_732 = _T_35 ? _GEN_601 : regAssignments_27_agent; // @[Conditional.scala 39:67 AccountantExtPrice.scala 53:31]
  wire  _GEN_733 = _T_35 ? _GEN_602 : regAssignments_28_valid; // @[Conditional.scala 39:67 AccountantExtPrice.scala 53:31]
  wire [5:0] _GEN_734 = _T_35 ? _GEN_603 : regAssignments_28_agent; // @[Conditional.scala 39:67 AccountantExtPrice.scala 53:31]
  wire  _GEN_735 = _T_35 ? _GEN_604 : regAssignments_29_valid; // @[Conditional.scala 39:67 AccountantExtPrice.scala 53:31]
  wire [5:0] _GEN_736 = _T_35 ? _GEN_605 : regAssignments_29_agent; // @[Conditional.scala 39:67 AccountantExtPrice.scala 53:31]
  wire  _GEN_737 = _T_35 ? _GEN_606 : regAssignments_30_valid; // @[Conditional.scala 39:67 AccountantExtPrice.scala 53:31]
  wire [5:0] _GEN_738 = _T_35 ? _GEN_607 : regAssignments_30_agent; // @[Conditional.scala 39:67 AccountantExtPrice.scala 53:31]
  wire  _GEN_739 = _T_35 ? _GEN_608 : regAssignments_31_valid; // @[Conditional.scala 39:67 AccountantExtPrice.scala 53:31]
  wire [5:0] _GEN_740 = _T_35 ? _GEN_609 : regAssignments_31_agent; // @[Conditional.scala 39:67 AccountantExtPrice.scala 53:31]
  wire  _GEN_741 = _T_35 ? _GEN_610 : regAssignments_32_valid; // @[Conditional.scala 39:67 AccountantExtPrice.scala 53:31]
  wire [5:0] _GEN_742 = _T_35 ? _GEN_611 : regAssignments_32_agent; // @[Conditional.scala 39:67 AccountantExtPrice.scala 53:31]
  wire  _GEN_743 = _T_35 ? _GEN_612 : regAssignments_33_valid; // @[Conditional.scala 39:67 AccountantExtPrice.scala 53:31]
  wire [5:0] _GEN_744 = _T_35 ? _GEN_613 : regAssignments_33_agent; // @[Conditional.scala 39:67 AccountantExtPrice.scala 53:31]
  wire  _GEN_745 = _T_35 ? _GEN_614 : regAssignments_34_valid; // @[Conditional.scala 39:67 AccountantExtPrice.scala 53:31]
  wire [5:0] _GEN_746 = _T_35 ? _GEN_615 : regAssignments_34_agent; // @[Conditional.scala 39:67 AccountantExtPrice.scala 53:31]
  wire  _GEN_747 = _T_35 ? _GEN_616 : regAssignments_35_valid; // @[Conditional.scala 39:67 AccountantExtPrice.scala 53:31]
  wire [5:0] _GEN_748 = _T_35 ? _GEN_617 : regAssignments_35_agent; // @[Conditional.scala 39:67 AccountantExtPrice.scala 53:31]
  wire  _GEN_749 = _T_35 ? _GEN_618 : regAssignments_36_valid; // @[Conditional.scala 39:67 AccountantExtPrice.scala 53:31]
  wire [5:0] _GEN_750 = _T_35 ? _GEN_619 : regAssignments_36_agent; // @[Conditional.scala 39:67 AccountantExtPrice.scala 53:31]
  wire  _GEN_751 = _T_35 ? _GEN_620 : regAssignments_37_valid; // @[Conditional.scala 39:67 AccountantExtPrice.scala 53:31]
  wire [5:0] _GEN_752 = _T_35 ? _GEN_621 : regAssignments_37_agent; // @[Conditional.scala 39:67 AccountantExtPrice.scala 53:31]
  wire  _GEN_753 = _T_35 ? _GEN_622 : regAssignments_38_valid; // @[Conditional.scala 39:67 AccountantExtPrice.scala 53:31]
  wire [5:0] _GEN_754 = _T_35 ? _GEN_623 : regAssignments_38_agent; // @[Conditional.scala 39:67 AccountantExtPrice.scala 53:31]
  wire  _GEN_755 = _T_35 ? _GEN_624 : regAssignments_39_valid; // @[Conditional.scala 39:67 AccountantExtPrice.scala 53:31]
  wire [5:0] _GEN_756 = _T_35 ? _GEN_625 : regAssignments_39_agent; // @[Conditional.scala 39:67 AccountantExtPrice.scala 53:31]
  wire  _GEN_757 = _T_35 ? _GEN_626 : regAssignments_40_valid; // @[Conditional.scala 39:67 AccountantExtPrice.scala 53:31]
  wire [5:0] _GEN_758 = _T_35 ? _GEN_627 : regAssignments_40_agent; // @[Conditional.scala 39:67 AccountantExtPrice.scala 53:31]
  wire  _GEN_759 = _T_35 ? _GEN_628 : regAssignments_41_valid; // @[Conditional.scala 39:67 AccountantExtPrice.scala 53:31]
  wire [5:0] _GEN_760 = _T_35 ? _GEN_629 : regAssignments_41_agent; // @[Conditional.scala 39:67 AccountantExtPrice.scala 53:31]
  wire  _GEN_761 = _T_35 ? _GEN_630 : regAssignments_42_valid; // @[Conditional.scala 39:67 AccountantExtPrice.scala 53:31]
  wire [5:0] _GEN_762 = _T_35 ? _GEN_631 : regAssignments_42_agent; // @[Conditional.scala 39:67 AccountantExtPrice.scala 53:31]
  wire  _GEN_763 = _T_35 ? _GEN_632 : regAssignments_43_valid; // @[Conditional.scala 39:67 AccountantExtPrice.scala 53:31]
  wire [5:0] _GEN_764 = _T_35 ? _GEN_633 : regAssignments_43_agent; // @[Conditional.scala 39:67 AccountantExtPrice.scala 53:31]
  wire  _GEN_765 = _T_35 ? _GEN_634 : regAssignments_44_valid; // @[Conditional.scala 39:67 AccountantExtPrice.scala 53:31]
  wire [5:0] _GEN_766 = _T_35 ? _GEN_635 : regAssignments_44_agent; // @[Conditional.scala 39:67 AccountantExtPrice.scala 53:31]
  wire  _GEN_767 = _T_35 ? _GEN_636 : regAssignments_45_valid; // @[Conditional.scala 39:67 AccountantExtPrice.scala 53:31]
  wire [5:0] _GEN_768 = _T_35 ? _GEN_637 : regAssignments_45_agent; // @[Conditional.scala 39:67 AccountantExtPrice.scala 53:31]
  wire  _GEN_769 = _T_35 ? _GEN_638 : regAssignments_46_valid; // @[Conditional.scala 39:67 AccountantExtPrice.scala 53:31]
  wire [5:0] _GEN_770 = _T_35 ? _GEN_639 : regAssignments_46_agent; // @[Conditional.scala 39:67 AccountantExtPrice.scala 53:31]
  wire  _GEN_771 = _T_35 ? _GEN_640 : regAssignments_47_valid; // @[Conditional.scala 39:67 AccountantExtPrice.scala 53:31]
  wire [5:0] _GEN_772 = _T_35 ? _GEN_641 : regAssignments_47_agent; // @[Conditional.scala 39:67 AccountantExtPrice.scala 53:31]
  wire  _GEN_773 = _T_35 ? _GEN_642 : regAssignments_48_valid; // @[Conditional.scala 39:67 AccountantExtPrice.scala 53:31]
  wire [5:0] _GEN_774 = _T_35 ? _GEN_643 : regAssignments_48_agent; // @[Conditional.scala 39:67 AccountantExtPrice.scala 53:31]
  wire  _GEN_775 = _T_35 ? _GEN_644 : regAssignments_49_valid; // @[Conditional.scala 39:67 AccountantExtPrice.scala 53:31]
  wire [5:0] _GEN_776 = _T_35 ? _GEN_645 : regAssignments_49_agent; // @[Conditional.scala 39:67 AccountantExtPrice.scala 53:31]
  wire  _GEN_777 = _T_35 ? _GEN_646 : regAssignments_50_valid; // @[Conditional.scala 39:67 AccountantExtPrice.scala 53:31]
  wire [5:0] _GEN_778 = _T_35 ? _GEN_647 : regAssignments_50_agent; // @[Conditional.scala 39:67 AccountantExtPrice.scala 53:31]
  wire  _GEN_779 = _T_35 ? _GEN_648 : regAssignments_51_valid; // @[Conditional.scala 39:67 AccountantExtPrice.scala 53:31]
  wire [5:0] _GEN_780 = _T_35 ? _GEN_649 : regAssignments_51_agent; // @[Conditional.scala 39:67 AccountantExtPrice.scala 53:31]
  wire  _GEN_781 = _T_35 ? _GEN_650 : regAssignments_52_valid; // @[Conditional.scala 39:67 AccountantExtPrice.scala 53:31]
  wire [5:0] _GEN_782 = _T_35 ? _GEN_651 : regAssignments_52_agent; // @[Conditional.scala 39:67 AccountantExtPrice.scala 53:31]
  wire  _GEN_783 = _T_35 ? _GEN_652 : regAssignments_53_valid; // @[Conditional.scala 39:67 AccountantExtPrice.scala 53:31]
  wire [5:0] _GEN_784 = _T_35 ? _GEN_653 : regAssignments_53_agent; // @[Conditional.scala 39:67 AccountantExtPrice.scala 53:31]
  wire  _GEN_785 = _T_35 ? _GEN_654 : regAssignments_54_valid; // @[Conditional.scala 39:67 AccountantExtPrice.scala 53:31]
  wire [5:0] _GEN_786 = _T_35 ? _GEN_655 : regAssignments_54_agent; // @[Conditional.scala 39:67 AccountantExtPrice.scala 53:31]
  wire  _GEN_787 = _T_35 ? _GEN_656 : regAssignments_55_valid; // @[Conditional.scala 39:67 AccountantExtPrice.scala 53:31]
  wire [5:0] _GEN_788 = _T_35 ? _GEN_657 : regAssignments_55_agent; // @[Conditional.scala 39:67 AccountantExtPrice.scala 53:31]
  wire  _GEN_789 = _T_35 ? _GEN_658 : regAssignments_56_valid; // @[Conditional.scala 39:67 AccountantExtPrice.scala 53:31]
  wire [5:0] _GEN_790 = _T_35 ? _GEN_659 : regAssignments_56_agent; // @[Conditional.scala 39:67 AccountantExtPrice.scala 53:31]
  wire  _GEN_791 = _T_35 ? _GEN_660 : regAssignments_57_valid; // @[Conditional.scala 39:67 AccountantExtPrice.scala 53:31]
  wire [5:0] _GEN_792 = _T_35 ? _GEN_661 : regAssignments_57_agent; // @[Conditional.scala 39:67 AccountantExtPrice.scala 53:31]
  wire  _GEN_793 = _T_35 ? _GEN_662 : regAssignments_58_valid; // @[Conditional.scala 39:67 AccountantExtPrice.scala 53:31]
  wire [5:0] _GEN_794 = _T_35 ? _GEN_663 : regAssignments_58_agent; // @[Conditional.scala 39:67 AccountantExtPrice.scala 53:31]
  wire  _GEN_795 = _T_35 ? _GEN_664 : regAssignments_59_valid; // @[Conditional.scala 39:67 AccountantExtPrice.scala 53:31]
  wire [5:0] _GEN_796 = _T_35 ? _GEN_665 : regAssignments_59_agent; // @[Conditional.scala 39:67 AccountantExtPrice.scala 53:31]
  wire  _GEN_797 = _T_35 ? _GEN_666 : regAssignments_60_valid; // @[Conditional.scala 39:67 AccountantExtPrice.scala 53:31]
  wire [5:0] _GEN_798 = _T_35 ? _GEN_667 : regAssignments_60_agent; // @[Conditional.scala 39:67 AccountantExtPrice.scala 53:31]
  wire  _GEN_799 = _T_35 ? _GEN_668 : regAssignments_61_valid; // @[Conditional.scala 39:67 AccountantExtPrice.scala 53:31]
  wire [5:0] _GEN_800 = _T_35 ? _GEN_669 : regAssignments_61_agent; // @[Conditional.scala 39:67 AccountantExtPrice.scala 53:31]
  wire  _GEN_801 = _T_35 ? _GEN_670 : regAssignments_62_valid; // @[Conditional.scala 39:67 AccountantExtPrice.scala 53:31]
  wire [5:0] _GEN_802 = _T_35 ? _GEN_671 : regAssignments_62_agent; // @[Conditional.scala 39:67 AccountantExtPrice.scala 53:31]
  wire  _GEN_803 = _T_35 ? _GEN_672 : regAssignments_63_valid; // @[Conditional.scala 39:67 AccountantExtPrice.scala 53:31]
  wire [5:0] _GEN_804 = _T_35 ? _GEN_673 : regAssignments_63_agent; // @[Conditional.scala 39:67 AccountantExtPrice.scala 53:31]
  wire  _GEN_806 = _T_26 | _T_35; // @[Conditional.scala 39:67 AccountantExtPrice.scala 129:32]
  wire [63:0] _GEN_807 = _T_26 ? _GEN_534 : regWBCount; // @[Conditional.scala 39:67 AccountantExtPrice.scala 64:27]
  wire [2:0] _GEN_808 = _T_26 ? _GEN_540 : _GEN_676; // @[Conditional.scala 39:67]
  wire  _GEN_809 = _T_26 & _GEN_536; // @[Conditional.scala 39:67 AccountantExtPrice.scala 38:34]
  wire  _GEN_813 = _T_26 ? regAssignments_0_valid : _GEN_677; // @[Conditional.scala 39:67 AccountantExtPrice.scala 53:31]
  wire [5:0] _GEN_814 = _T_26 ? regAssignments_0_agent : _GEN_678; // @[Conditional.scala 39:67 AccountantExtPrice.scala 53:31]
  wire  _GEN_815 = _T_26 ? regAssignments_1_valid : _GEN_679; // @[Conditional.scala 39:67 AccountantExtPrice.scala 53:31]
  wire [5:0] _GEN_816 = _T_26 ? regAssignments_1_agent : _GEN_680; // @[Conditional.scala 39:67 AccountantExtPrice.scala 53:31]
  wire  _GEN_817 = _T_26 ? regAssignments_2_valid : _GEN_681; // @[Conditional.scala 39:67 AccountantExtPrice.scala 53:31]
  wire [5:0] _GEN_818 = _T_26 ? regAssignments_2_agent : _GEN_682; // @[Conditional.scala 39:67 AccountantExtPrice.scala 53:31]
  wire  _GEN_819 = _T_26 ? regAssignments_3_valid : _GEN_683; // @[Conditional.scala 39:67 AccountantExtPrice.scala 53:31]
  wire [5:0] _GEN_820 = _T_26 ? regAssignments_3_agent : _GEN_684; // @[Conditional.scala 39:67 AccountantExtPrice.scala 53:31]
  wire  _GEN_821 = _T_26 ? regAssignments_4_valid : _GEN_685; // @[Conditional.scala 39:67 AccountantExtPrice.scala 53:31]
  wire [5:0] _GEN_822 = _T_26 ? regAssignments_4_agent : _GEN_686; // @[Conditional.scala 39:67 AccountantExtPrice.scala 53:31]
  wire  _GEN_823 = _T_26 ? regAssignments_5_valid : _GEN_687; // @[Conditional.scala 39:67 AccountantExtPrice.scala 53:31]
  wire [5:0] _GEN_824 = _T_26 ? regAssignments_5_agent : _GEN_688; // @[Conditional.scala 39:67 AccountantExtPrice.scala 53:31]
  wire  _GEN_825 = _T_26 ? regAssignments_6_valid : _GEN_689; // @[Conditional.scala 39:67 AccountantExtPrice.scala 53:31]
  wire [5:0] _GEN_826 = _T_26 ? regAssignments_6_agent : _GEN_690; // @[Conditional.scala 39:67 AccountantExtPrice.scala 53:31]
  wire  _GEN_827 = _T_26 ? regAssignments_7_valid : _GEN_691; // @[Conditional.scala 39:67 AccountantExtPrice.scala 53:31]
  wire [5:0] _GEN_828 = _T_26 ? regAssignments_7_agent : _GEN_692; // @[Conditional.scala 39:67 AccountantExtPrice.scala 53:31]
  wire  _GEN_829 = _T_26 ? regAssignments_8_valid : _GEN_693; // @[Conditional.scala 39:67 AccountantExtPrice.scala 53:31]
  wire [5:0] _GEN_830 = _T_26 ? regAssignments_8_agent : _GEN_694; // @[Conditional.scala 39:67 AccountantExtPrice.scala 53:31]
  wire  _GEN_831 = _T_26 ? regAssignments_9_valid : _GEN_695; // @[Conditional.scala 39:67 AccountantExtPrice.scala 53:31]
  wire [5:0] _GEN_832 = _T_26 ? regAssignments_9_agent : _GEN_696; // @[Conditional.scala 39:67 AccountantExtPrice.scala 53:31]
  wire  _GEN_833 = _T_26 ? regAssignments_10_valid : _GEN_697; // @[Conditional.scala 39:67 AccountantExtPrice.scala 53:31]
  wire [5:0] _GEN_834 = _T_26 ? regAssignments_10_agent : _GEN_698; // @[Conditional.scala 39:67 AccountantExtPrice.scala 53:31]
  wire  _GEN_835 = _T_26 ? regAssignments_11_valid : _GEN_699; // @[Conditional.scala 39:67 AccountantExtPrice.scala 53:31]
  wire [5:0] _GEN_836 = _T_26 ? regAssignments_11_agent : _GEN_700; // @[Conditional.scala 39:67 AccountantExtPrice.scala 53:31]
  wire  _GEN_837 = _T_26 ? regAssignments_12_valid : _GEN_701; // @[Conditional.scala 39:67 AccountantExtPrice.scala 53:31]
  wire [5:0] _GEN_838 = _T_26 ? regAssignments_12_agent : _GEN_702; // @[Conditional.scala 39:67 AccountantExtPrice.scala 53:31]
  wire  _GEN_839 = _T_26 ? regAssignments_13_valid : _GEN_703; // @[Conditional.scala 39:67 AccountantExtPrice.scala 53:31]
  wire [5:0] _GEN_840 = _T_26 ? regAssignments_13_agent : _GEN_704; // @[Conditional.scala 39:67 AccountantExtPrice.scala 53:31]
  wire  _GEN_841 = _T_26 ? regAssignments_14_valid : _GEN_705; // @[Conditional.scala 39:67 AccountantExtPrice.scala 53:31]
  wire [5:0] _GEN_842 = _T_26 ? regAssignments_14_agent : _GEN_706; // @[Conditional.scala 39:67 AccountantExtPrice.scala 53:31]
  wire  _GEN_843 = _T_26 ? regAssignments_15_valid : _GEN_707; // @[Conditional.scala 39:67 AccountantExtPrice.scala 53:31]
  wire [5:0] _GEN_844 = _T_26 ? regAssignments_15_agent : _GEN_708; // @[Conditional.scala 39:67 AccountantExtPrice.scala 53:31]
  wire  _GEN_845 = _T_26 ? regAssignments_16_valid : _GEN_709; // @[Conditional.scala 39:67 AccountantExtPrice.scala 53:31]
  wire [5:0] _GEN_846 = _T_26 ? regAssignments_16_agent : _GEN_710; // @[Conditional.scala 39:67 AccountantExtPrice.scala 53:31]
  wire  _GEN_847 = _T_26 ? regAssignments_17_valid : _GEN_711; // @[Conditional.scala 39:67 AccountantExtPrice.scala 53:31]
  wire [5:0] _GEN_848 = _T_26 ? regAssignments_17_agent : _GEN_712; // @[Conditional.scala 39:67 AccountantExtPrice.scala 53:31]
  wire  _GEN_849 = _T_26 ? regAssignments_18_valid : _GEN_713; // @[Conditional.scala 39:67 AccountantExtPrice.scala 53:31]
  wire [5:0] _GEN_850 = _T_26 ? regAssignments_18_agent : _GEN_714; // @[Conditional.scala 39:67 AccountantExtPrice.scala 53:31]
  wire  _GEN_851 = _T_26 ? regAssignments_19_valid : _GEN_715; // @[Conditional.scala 39:67 AccountantExtPrice.scala 53:31]
  wire [5:0] _GEN_852 = _T_26 ? regAssignments_19_agent : _GEN_716; // @[Conditional.scala 39:67 AccountantExtPrice.scala 53:31]
  wire  _GEN_853 = _T_26 ? regAssignments_20_valid : _GEN_717; // @[Conditional.scala 39:67 AccountantExtPrice.scala 53:31]
  wire [5:0] _GEN_854 = _T_26 ? regAssignments_20_agent : _GEN_718; // @[Conditional.scala 39:67 AccountantExtPrice.scala 53:31]
  wire  _GEN_855 = _T_26 ? regAssignments_21_valid : _GEN_719; // @[Conditional.scala 39:67 AccountantExtPrice.scala 53:31]
  wire [5:0] _GEN_856 = _T_26 ? regAssignments_21_agent : _GEN_720; // @[Conditional.scala 39:67 AccountantExtPrice.scala 53:31]
  wire  _GEN_857 = _T_26 ? regAssignments_22_valid : _GEN_721; // @[Conditional.scala 39:67 AccountantExtPrice.scala 53:31]
  wire [5:0] _GEN_858 = _T_26 ? regAssignments_22_agent : _GEN_722; // @[Conditional.scala 39:67 AccountantExtPrice.scala 53:31]
  wire  _GEN_859 = _T_26 ? regAssignments_23_valid : _GEN_723; // @[Conditional.scala 39:67 AccountantExtPrice.scala 53:31]
  wire [5:0] _GEN_860 = _T_26 ? regAssignments_23_agent : _GEN_724; // @[Conditional.scala 39:67 AccountantExtPrice.scala 53:31]
  wire  _GEN_861 = _T_26 ? regAssignments_24_valid : _GEN_725; // @[Conditional.scala 39:67 AccountantExtPrice.scala 53:31]
  wire [5:0] _GEN_862 = _T_26 ? regAssignments_24_agent : _GEN_726; // @[Conditional.scala 39:67 AccountantExtPrice.scala 53:31]
  wire  _GEN_863 = _T_26 ? regAssignments_25_valid : _GEN_727; // @[Conditional.scala 39:67 AccountantExtPrice.scala 53:31]
  wire [5:0] _GEN_864 = _T_26 ? regAssignments_25_agent : _GEN_728; // @[Conditional.scala 39:67 AccountantExtPrice.scala 53:31]
  wire  _GEN_865 = _T_26 ? regAssignments_26_valid : _GEN_729; // @[Conditional.scala 39:67 AccountantExtPrice.scala 53:31]
  wire [5:0] _GEN_866 = _T_26 ? regAssignments_26_agent : _GEN_730; // @[Conditional.scala 39:67 AccountantExtPrice.scala 53:31]
  wire  _GEN_867 = _T_26 ? regAssignments_27_valid : _GEN_731; // @[Conditional.scala 39:67 AccountantExtPrice.scala 53:31]
  wire [5:0] _GEN_868 = _T_26 ? regAssignments_27_agent : _GEN_732; // @[Conditional.scala 39:67 AccountantExtPrice.scala 53:31]
  wire  _GEN_869 = _T_26 ? regAssignments_28_valid : _GEN_733; // @[Conditional.scala 39:67 AccountantExtPrice.scala 53:31]
  wire [5:0] _GEN_870 = _T_26 ? regAssignments_28_agent : _GEN_734; // @[Conditional.scala 39:67 AccountantExtPrice.scala 53:31]
  wire  _GEN_871 = _T_26 ? regAssignments_29_valid : _GEN_735; // @[Conditional.scala 39:67 AccountantExtPrice.scala 53:31]
  wire [5:0] _GEN_872 = _T_26 ? regAssignments_29_agent : _GEN_736; // @[Conditional.scala 39:67 AccountantExtPrice.scala 53:31]
  wire  _GEN_873 = _T_26 ? regAssignments_30_valid : _GEN_737; // @[Conditional.scala 39:67 AccountantExtPrice.scala 53:31]
  wire [5:0] _GEN_874 = _T_26 ? regAssignments_30_agent : _GEN_738; // @[Conditional.scala 39:67 AccountantExtPrice.scala 53:31]
  wire  _GEN_875 = _T_26 ? regAssignments_31_valid : _GEN_739; // @[Conditional.scala 39:67 AccountantExtPrice.scala 53:31]
  wire [5:0] _GEN_876 = _T_26 ? regAssignments_31_agent : _GEN_740; // @[Conditional.scala 39:67 AccountantExtPrice.scala 53:31]
  wire  _GEN_877 = _T_26 ? regAssignments_32_valid : _GEN_741; // @[Conditional.scala 39:67 AccountantExtPrice.scala 53:31]
  wire [5:0] _GEN_878 = _T_26 ? regAssignments_32_agent : _GEN_742; // @[Conditional.scala 39:67 AccountantExtPrice.scala 53:31]
  wire  _GEN_879 = _T_26 ? regAssignments_33_valid : _GEN_743; // @[Conditional.scala 39:67 AccountantExtPrice.scala 53:31]
  wire [5:0] _GEN_880 = _T_26 ? regAssignments_33_agent : _GEN_744; // @[Conditional.scala 39:67 AccountantExtPrice.scala 53:31]
  wire  _GEN_881 = _T_26 ? regAssignments_34_valid : _GEN_745; // @[Conditional.scala 39:67 AccountantExtPrice.scala 53:31]
  wire [5:0] _GEN_882 = _T_26 ? regAssignments_34_agent : _GEN_746; // @[Conditional.scala 39:67 AccountantExtPrice.scala 53:31]
  wire  _GEN_883 = _T_26 ? regAssignments_35_valid : _GEN_747; // @[Conditional.scala 39:67 AccountantExtPrice.scala 53:31]
  wire [5:0] _GEN_884 = _T_26 ? regAssignments_35_agent : _GEN_748; // @[Conditional.scala 39:67 AccountantExtPrice.scala 53:31]
  wire  _GEN_885 = _T_26 ? regAssignments_36_valid : _GEN_749; // @[Conditional.scala 39:67 AccountantExtPrice.scala 53:31]
  wire [5:0] _GEN_886 = _T_26 ? regAssignments_36_agent : _GEN_750; // @[Conditional.scala 39:67 AccountantExtPrice.scala 53:31]
  wire  _GEN_887 = _T_26 ? regAssignments_37_valid : _GEN_751; // @[Conditional.scala 39:67 AccountantExtPrice.scala 53:31]
  wire [5:0] _GEN_888 = _T_26 ? regAssignments_37_agent : _GEN_752; // @[Conditional.scala 39:67 AccountantExtPrice.scala 53:31]
  wire  _GEN_889 = _T_26 ? regAssignments_38_valid : _GEN_753; // @[Conditional.scala 39:67 AccountantExtPrice.scala 53:31]
  wire [5:0] _GEN_890 = _T_26 ? regAssignments_38_agent : _GEN_754; // @[Conditional.scala 39:67 AccountantExtPrice.scala 53:31]
  wire  _GEN_891 = _T_26 ? regAssignments_39_valid : _GEN_755; // @[Conditional.scala 39:67 AccountantExtPrice.scala 53:31]
  wire [5:0] _GEN_892 = _T_26 ? regAssignments_39_agent : _GEN_756; // @[Conditional.scala 39:67 AccountantExtPrice.scala 53:31]
  wire  _GEN_893 = _T_26 ? regAssignments_40_valid : _GEN_757; // @[Conditional.scala 39:67 AccountantExtPrice.scala 53:31]
  wire [5:0] _GEN_894 = _T_26 ? regAssignments_40_agent : _GEN_758; // @[Conditional.scala 39:67 AccountantExtPrice.scala 53:31]
  wire  _GEN_895 = _T_26 ? regAssignments_41_valid : _GEN_759; // @[Conditional.scala 39:67 AccountantExtPrice.scala 53:31]
  wire [5:0] _GEN_896 = _T_26 ? regAssignments_41_agent : _GEN_760; // @[Conditional.scala 39:67 AccountantExtPrice.scala 53:31]
  wire  _GEN_897 = _T_26 ? regAssignments_42_valid : _GEN_761; // @[Conditional.scala 39:67 AccountantExtPrice.scala 53:31]
  wire [5:0] _GEN_898 = _T_26 ? regAssignments_42_agent : _GEN_762; // @[Conditional.scala 39:67 AccountantExtPrice.scala 53:31]
  wire  _GEN_899 = _T_26 ? regAssignments_43_valid : _GEN_763; // @[Conditional.scala 39:67 AccountantExtPrice.scala 53:31]
  wire [5:0] _GEN_900 = _T_26 ? regAssignments_43_agent : _GEN_764; // @[Conditional.scala 39:67 AccountantExtPrice.scala 53:31]
  wire  _GEN_901 = _T_26 ? regAssignments_44_valid : _GEN_765; // @[Conditional.scala 39:67 AccountantExtPrice.scala 53:31]
  wire [5:0] _GEN_902 = _T_26 ? regAssignments_44_agent : _GEN_766; // @[Conditional.scala 39:67 AccountantExtPrice.scala 53:31]
  wire  _GEN_903 = _T_26 ? regAssignments_45_valid : _GEN_767; // @[Conditional.scala 39:67 AccountantExtPrice.scala 53:31]
  wire [5:0] _GEN_904 = _T_26 ? regAssignments_45_agent : _GEN_768; // @[Conditional.scala 39:67 AccountantExtPrice.scala 53:31]
  wire  _GEN_905 = _T_26 ? regAssignments_46_valid : _GEN_769; // @[Conditional.scala 39:67 AccountantExtPrice.scala 53:31]
  wire [5:0] _GEN_906 = _T_26 ? regAssignments_46_agent : _GEN_770; // @[Conditional.scala 39:67 AccountantExtPrice.scala 53:31]
  wire  _GEN_907 = _T_26 ? regAssignments_47_valid : _GEN_771; // @[Conditional.scala 39:67 AccountantExtPrice.scala 53:31]
  wire [5:0] _GEN_908 = _T_26 ? regAssignments_47_agent : _GEN_772; // @[Conditional.scala 39:67 AccountantExtPrice.scala 53:31]
  wire  _GEN_909 = _T_26 ? regAssignments_48_valid : _GEN_773; // @[Conditional.scala 39:67 AccountantExtPrice.scala 53:31]
  wire [5:0] _GEN_910 = _T_26 ? regAssignments_48_agent : _GEN_774; // @[Conditional.scala 39:67 AccountantExtPrice.scala 53:31]
  wire  _GEN_911 = _T_26 ? regAssignments_49_valid : _GEN_775; // @[Conditional.scala 39:67 AccountantExtPrice.scala 53:31]
  wire [5:0] _GEN_912 = _T_26 ? regAssignments_49_agent : _GEN_776; // @[Conditional.scala 39:67 AccountantExtPrice.scala 53:31]
  wire  _GEN_913 = _T_26 ? regAssignments_50_valid : _GEN_777; // @[Conditional.scala 39:67 AccountantExtPrice.scala 53:31]
  wire [5:0] _GEN_914 = _T_26 ? regAssignments_50_agent : _GEN_778; // @[Conditional.scala 39:67 AccountantExtPrice.scala 53:31]
  wire  _GEN_915 = _T_26 ? regAssignments_51_valid : _GEN_779; // @[Conditional.scala 39:67 AccountantExtPrice.scala 53:31]
  wire [5:0] _GEN_916 = _T_26 ? regAssignments_51_agent : _GEN_780; // @[Conditional.scala 39:67 AccountantExtPrice.scala 53:31]
  wire  _GEN_917 = _T_26 ? regAssignments_52_valid : _GEN_781; // @[Conditional.scala 39:67 AccountantExtPrice.scala 53:31]
  wire [5:0] _GEN_918 = _T_26 ? regAssignments_52_agent : _GEN_782; // @[Conditional.scala 39:67 AccountantExtPrice.scala 53:31]
  wire  _GEN_919 = _T_26 ? regAssignments_53_valid : _GEN_783; // @[Conditional.scala 39:67 AccountantExtPrice.scala 53:31]
  wire [5:0] _GEN_920 = _T_26 ? regAssignments_53_agent : _GEN_784; // @[Conditional.scala 39:67 AccountantExtPrice.scala 53:31]
  wire  _GEN_921 = _T_26 ? regAssignments_54_valid : _GEN_785; // @[Conditional.scala 39:67 AccountantExtPrice.scala 53:31]
  wire [5:0] _GEN_922 = _T_26 ? regAssignments_54_agent : _GEN_786; // @[Conditional.scala 39:67 AccountantExtPrice.scala 53:31]
  wire  _GEN_923 = _T_26 ? regAssignments_55_valid : _GEN_787; // @[Conditional.scala 39:67 AccountantExtPrice.scala 53:31]
  wire [5:0] _GEN_924 = _T_26 ? regAssignments_55_agent : _GEN_788; // @[Conditional.scala 39:67 AccountantExtPrice.scala 53:31]
  wire  _GEN_925 = _T_26 ? regAssignments_56_valid : _GEN_789; // @[Conditional.scala 39:67 AccountantExtPrice.scala 53:31]
  wire [5:0] _GEN_926 = _T_26 ? regAssignments_56_agent : _GEN_790; // @[Conditional.scala 39:67 AccountantExtPrice.scala 53:31]
  wire  _GEN_927 = _T_26 ? regAssignments_57_valid : _GEN_791; // @[Conditional.scala 39:67 AccountantExtPrice.scala 53:31]
  wire [5:0] _GEN_928 = _T_26 ? regAssignments_57_agent : _GEN_792; // @[Conditional.scala 39:67 AccountantExtPrice.scala 53:31]
  wire  _GEN_929 = _T_26 ? regAssignments_58_valid : _GEN_793; // @[Conditional.scala 39:67 AccountantExtPrice.scala 53:31]
  wire [5:0] _GEN_930 = _T_26 ? regAssignments_58_agent : _GEN_794; // @[Conditional.scala 39:67 AccountantExtPrice.scala 53:31]
  wire  _GEN_931 = _T_26 ? regAssignments_59_valid : _GEN_795; // @[Conditional.scala 39:67 AccountantExtPrice.scala 53:31]
  wire [5:0] _GEN_932 = _T_26 ? regAssignments_59_agent : _GEN_796; // @[Conditional.scala 39:67 AccountantExtPrice.scala 53:31]
  wire  _GEN_933 = _T_26 ? regAssignments_60_valid : _GEN_797; // @[Conditional.scala 39:67 AccountantExtPrice.scala 53:31]
  wire [5:0] _GEN_934 = _T_26 ? regAssignments_60_agent : _GEN_798; // @[Conditional.scala 39:67 AccountantExtPrice.scala 53:31]
  wire  _GEN_935 = _T_26 ? regAssignments_61_valid : _GEN_799; // @[Conditional.scala 39:67 AccountantExtPrice.scala 53:31]
  wire [5:0] _GEN_936 = _T_26 ? regAssignments_61_agent : _GEN_800; // @[Conditional.scala 39:67 AccountantExtPrice.scala 53:31]
  wire  _GEN_937 = _T_26 ? regAssignments_62_valid : _GEN_801; // @[Conditional.scala 39:67 AccountantExtPrice.scala 53:31]
  wire [5:0] _GEN_938 = _T_26 ? regAssignments_62_agent : _GEN_802; // @[Conditional.scala 39:67 AccountantExtPrice.scala 53:31]
  wire  _GEN_939 = _T_26 ? regAssignments_63_valid : _GEN_803; // @[Conditional.scala 39:67 AccountantExtPrice.scala 53:31]
  wire [5:0] _GEN_940 = _T_26 ? regAssignments_63_agent : _GEN_804; // @[Conditional.scala 39:67 AccountantExtPrice.scala 53:31]
  wire  _GEN_941 = _T_26 ? 1'h0 : _T_35 & io_writeBackStream_finished; // @[Conditional.scala 39:67 AccountantExtPrice.scala 36:19]
  wire  _GEN_942 = _T_20 | _GEN_806; // @[Conditional.scala 39:67 AccountantExtPrice.scala 116:32]
  wire  _GEN_945 = _T_20 ? _GEN_536 : _GEN_809; // @[Conditional.scala 39:67]
  wire [7:0] _GEN_946 = _T_20 ? {{2'd0}, _GEN_531} : io_priceStore_rsp_bits_rdata; // @[Conditional.scala 39:67]
  wire  _GEN_947 = _T_20 ? 1'h0 : _GEN_809; // @[Conditional.scala 39:67 AccountantExtPrice.scala 40:26]
  wire  _GEN_1078 = _T_20 ? 1'h0 : _GEN_941; // @[Conditional.scala 39:67 AccountantExtPrice.scala 36:19]
  wire  _GEN_1079 = _T_10 & _GEN_268; // @[Conditional.scala 39:67 AccountantExtPrice.scala 33:28]
  wire  _GEN_1210 = _T_10 ? _T_11 : _GEN_947; // @[Conditional.scala 39:67]
  wire [63:0] _GEN_1212 = _T_10 ? {{58'd0}, regObject} : regWBCount; // @[Conditional.scala 39:67]
  wire [7:0] _GEN_1213 = _T_10 ? _T_13 : 8'h0; // @[Conditional.scala 39:67]
  wire  _GEN_1215 = _T_10 & _GEN_404; // @[Conditional.scala 39:67 AccountantExtPrice.scala 43:23]
  wire  _GEN_1216 = _T_10 ? 1'h0 : _GEN_942; // @[Conditional.scala 39:67 AccountantExtPrice.scala 37:27]
  wire  _GEN_1218 = _T_10 ? 1'h0 : _GEN_945; // @[Conditional.scala 39:67 AccountantExtPrice.scala 38:34]
  wire  _GEN_1221 = _T_10 ? 1'h0 : _GEN_1078; // @[Conditional.scala 39:67 AccountantExtPrice.scala 36:19]
  wire  _GEN_1223 = _T & _T_1; // @[Conditional.scala 40:58 AccountantExtPrice.scala 35:27]
  wire [63:0] _GEN_1229 = _T ? {{58'd0}, io_searchResultIn_bits_winner} : _GEN_1212; // @[Conditional.scala 40:58]
  assign io_searchResultIn_ready = 3'h0 == regState; // @[Conditional.scala 37:30]
  assign io_unassignedAgents_valid = _T ? 1'h0 : _GEN_1079; // @[Conditional.scala 40:58 AccountantExtPrice.scala 33:28]
  assign io_unassignedAgents_bits_agent = {{2'd0}, _GEN_135}; // @[AccountantExtPrice.scala 93:35 AccountantExtPrice.scala 93:35]
  assign io_requestedAgents_ready = _T & _T_1; // @[Conditional.scala 40:58 AccountantExtPrice.scala 35:27]
  assign io_writeBackDone = _T ? 1'h0 : _GEN_1221; // @[Conditional.scala 40:58 AccountantExtPrice.scala 36:19]
  assign io_writeBackStream_start = _T ? 1'h0 : _GEN_1216; // @[Conditional.scala 40:58 AccountantExtPrice.scala 37:27]
  assign io_writeBackStream_wrData_valid = _T ? 1'h0 : _GEN_1218; // @[Conditional.scala 40:58 AccountantExtPrice.scala 38:34]
  assign io_writeBackStream_wrData_bits = {{56'd0}, _GEN_946}; // @[Conditional.scala 39:67]
  assign io_priceStore_req_valid = _T ? _T_1 : _GEN_1210; // @[Conditional.scala 40:58]
  assign io_priceStore_req_bits_wen = _T ? 1'h0 : _T_10; // @[Conditional.scala 40:58]
  assign io_priceStore_req_bits_addr = _GEN_1229[5:0];
  assign io_priceStore_req_bits_wdata = _T ? 8'h0 : _GEN_1213; // @[Conditional.scala 40:58]
  assign io_notifyPEsContinue = _T ? 1'h0 : _GEN_1215; // @[Conditional.scala 40:58 AccountantExtPrice.scala 43:23]
  always @(posedge clock) begin
    if (reset) begin // @[AccountantExtPrice.scala 53:31]
      regAssignments_0_agent <= 6'h0; // @[AccountantExtPrice.scala 53:31]
    end else if (!(_T)) begin // @[Conditional.scala 40:58]
      if (_T_10) begin // @[Conditional.scala 39:67]
        if (regBid > 8'h0) begin // @[AccountantExtPrice.scala 90:27]
          regAssignments_0_agent <= _GEN_137;
        end
      end else if (!(_T_20)) begin // @[Conditional.scala 39:67]
        regAssignments_0_agent <= _GEN_814;
      end
    end
    if (reset) begin // @[AccountantExtPrice.scala 53:31]
      regAssignments_0_valid <= 1'h0; // @[AccountantExtPrice.scala 53:31]
    end else if (!(_T)) begin // @[Conditional.scala 40:58]
      if (_T_10) begin // @[Conditional.scala 39:67]
        if (regBid > 8'h0) begin // @[AccountantExtPrice.scala 90:27]
          regAssignments_0_valid <= _GEN_201;
        end
      end else if (!(_T_20)) begin // @[Conditional.scala 39:67]
        regAssignments_0_valid <= _GEN_813;
      end
    end
    if (reset) begin // @[AccountantExtPrice.scala 53:31]
      regAssignments_1_agent <= 6'h0; // @[AccountantExtPrice.scala 53:31]
    end else if (!(_T)) begin // @[Conditional.scala 40:58]
      if (_T_10) begin // @[Conditional.scala 39:67]
        if (regBid > 8'h0) begin // @[AccountantExtPrice.scala 90:27]
          regAssignments_1_agent <= _GEN_138;
        end
      end else if (!(_T_20)) begin // @[Conditional.scala 39:67]
        regAssignments_1_agent <= _GEN_816;
      end
    end
    if (reset) begin // @[AccountantExtPrice.scala 53:31]
      regAssignments_1_valid <= 1'h0; // @[AccountantExtPrice.scala 53:31]
    end else if (!(_T)) begin // @[Conditional.scala 40:58]
      if (_T_10) begin // @[Conditional.scala 39:67]
        if (regBid > 8'h0) begin // @[AccountantExtPrice.scala 90:27]
          regAssignments_1_valid <= _GEN_202;
        end
      end else if (!(_T_20)) begin // @[Conditional.scala 39:67]
        regAssignments_1_valid <= _GEN_815;
      end
    end
    if (reset) begin // @[AccountantExtPrice.scala 53:31]
      regAssignments_2_agent <= 6'h0; // @[AccountantExtPrice.scala 53:31]
    end else if (!(_T)) begin // @[Conditional.scala 40:58]
      if (_T_10) begin // @[Conditional.scala 39:67]
        if (regBid > 8'h0) begin // @[AccountantExtPrice.scala 90:27]
          regAssignments_2_agent <= _GEN_139;
        end
      end else if (!(_T_20)) begin // @[Conditional.scala 39:67]
        regAssignments_2_agent <= _GEN_818;
      end
    end
    if (reset) begin // @[AccountantExtPrice.scala 53:31]
      regAssignments_2_valid <= 1'h0; // @[AccountantExtPrice.scala 53:31]
    end else if (!(_T)) begin // @[Conditional.scala 40:58]
      if (_T_10) begin // @[Conditional.scala 39:67]
        if (regBid > 8'h0) begin // @[AccountantExtPrice.scala 90:27]
          regAssignments_2_valid <= _GEN_203;
        end
      end else if (!(_T_20)) begin // @[Conditional.scala 39:67]
        regAssignments_2_valid <= _GEN_817;
      end
    end
    if (reset) begin // @[AccountantExtPrice.scala 53:31]
      regAssignments_3_agent <= 6'h0; // @[AccountantExtPrice.scala 53:31]
    end else if (!(_T)) begin // @[Conditional.scala 40:58]
      if (_T_10) begin // @[Conditional.scala 39:67]
        if (regBid > 8'h0) begin // @[AccountantExtPrice.scala 90:27]
          regAssignments_3_agent <= _GEN_140;
        end
      end else if (!(_T_20)) begin // @[Conditional.scala 39:67]
        regAssignments_3_agent <= _GEN_820;
      end
    end
    if (reset) begin // @[AccountantExtPrice.scala 53:31]
      regAssignments_3_valid <= 1'h0; // @[AccountantExtPrice.scala 53:31]
    end else if (!(_T)) begin // @[Conditional.scala 40:58]
      if (_T_10) begin // @[Conditional.scala 39:67]
        if (regBid > 8'h0) begin // @[AccountantExtPrice.scala 90:27]
          regAssignments_3_valid <= _GEN_204;
        end
      end else if (!(_T_20)) begin // @[Conditional.scala 39:67]
        regAssignments_3_valid <= _GEN_819;
      end
    end
    if (reset) begin // @[AccountantExtPrice.scala 53:31]
      regAssignments_4_agent <= 6'h0; // @[AccountantExtPrice.scala 53:31]
    end else if (!(_T)) begin // @[Conditional.scala 40:58]
      if (_T_10) begin // @[Conditional.scala 39:67]
        if (regBid > 8'h0) begin // @[AccountantExtPrice.scala 90:27]
          regAssignments_4_agent <= _GEN_141;
        end
      end else if (!(_T_20)) begin // @[Conditional.scala 39:67]
        regAssignments_4_agent <= _GEN_822;
      end
    end
    if (reset) begin // @[AccountantExtPrice.scala 53:31]
      regAssignments_4_valid <= 1'h0; // @[AccountantExtPrice.scala 53:31]
    end else if (!(_T)) begin // @[Conditional.scala 40:58]
      if (_T_10) begin // @[Conditional.scala 39:67]
        if (regBid > 8'h0) begin // @[AccountantExtPrice.scala 90:27]
          regAssignments_4_valid <= _GEN_205;
        end
      end else if (!(_T_20)) begin // @[Conditional.scala 39:67]
        regAssignments_4_valid <= _GEN_821;
      end
    end
    if (reset) begin // @[AccountantExtPrice.scala 53:31]
      regAssignments_5_agent <= 6'h0; // @[AccountantExtPrice.scala 53:31]
    end else if (!(_T)) begin // @[Conditional.scala 40:58]
      if (_T_10) begin // @[Conditional.scala 39:67]
        if (regBid > 8'h0) begin // @[AccountantExtPrice.scala 90:27]
          regAssignments_5_agent <= _GEN_142;
        end
      end else if (!(_T_20)) begin // @[Conditional.scala 39:67]
        regAssignments_5_agent <= _GEN_824;
      end
    end
    if (reset) begin // @[AccountantExtPrice.scala 53:31]
      regAssignments_5_valid <= 1'h0; // @[AccountantExtPrice.scala 53:31]
    end else if (!(_T)) begin // @[Conditional.scala 40:58]
      if (_T_10) begin // @[Conditional.scala 39:67]
        if (regBid > 8'h0) begin // @[AccountantExtPrice.scala 90:27]
          regAssignments_5_valid <= _GEN_206;
        end
      end else if (!(_T_20)) begin // @[Conditional.scala 39:67]
        regAssignments_5_valid <= _GEN_823;
      end
    end
    if (reset) begin // @[AccountantExtPrice.scala 53:31]
      regAssignments_6_agent <= 6'h0; // @[AccountantExtPrice.scala 53:31]
    end else if (!(_T)) begin // @[Conditional.scala 40:58]
      if (_T_10) begin // @[Conditional.scala 39:67]
        if (regBid > 8'h0) begin // @[AccountantExtPrice.scala 90:27]
          regAssignments_6_agent <= _GEN_143;
        end
      end else if (!(_T_20)) begin // @[Conditional.scala 39:67]
        regAssignments_6_agent <= _GEN_826;
      end
    end
    if (reset) begin // @[AccountantExtPrice.scala 53:31]
      regAssignments_6_valid <= 1'h0; // @[AccountantExtPrice.scala 53:31]
    end else if (!(_T)) begin // @[Conditional.scala 40:58]
      if (_T_10) begin // @[Conditional.scala 39:67]
        if (regBid > 8'h0) begin // @[AccountantExtPrice.scala 90:27]
          regAssignments_6_valid <= _GEN_207;
        end
      end else if (!(_T_20)) begin // @[Conditional.scala 39:67]
        regAssignments_6_valid <= _GEN_825;
      end
    end
    if (reset) begin // @[AccountantExtPrice.scala 53:31]
      regAssignments_7_agent <= 6'h0; // @[AccountantExtPrice.scala 53:31]
    end else if (!(_T)) begin // @[Conditional.scala 40:58]
      if (_T_10) begin // @[Conditional.scala 39:67]
        if (regBid > 8'h0) begin // @[AccountantExtPrice.scala 90:27]
          regAssignments_7_agent <= _GEN_144;
        end
      end else if (!(_T_20)) begin // @[Conditional.scala 39:67]
        regAssignments_7_agent <= _GEN_828;
      end
    end
    if (reset) begin // @[AccountantExtPrice.scala 53:31]
      regAssignments_7_valid <= 1'h0; // @[AccountantExtPrice.scala 53:31]
    end else if (!(_T)) begin // @[Conditional.scala 40:58]
      if (_T_10) begin // @[Conditional.scala 39:67]
        if (regBid > 8'h0) begin // @[AccountantExtPrice.scala 90:27]
          regAssignments_7_valid <= _GEN_208;
        end
      end else if (!(_T_20)) begin // @[Conditional.scala 39:67]
        regAssignments_7_valid <= _GEN_827;
      end
    end
    if (reset) begin // @[AccountantExtPrice.scala 53:31]
      regAssignments_8_agent <= 6'h0; // @[AccountantExtPrice.scala 53:31]
    end else if (!(_T)) begin // @[Conditional.scala 40:58]
      if (_T_10) begin // @[Conditional.scala 39:67]
        if (regBid > 8'h0) begin // @[AccountantExtPrice.scala 90:27]
          regAssignments_8_agent <= _GEN_145;
        end
      end else if (!(_T_20)) begin // @[Conditional.scala 39:67]
        regAssignments_8_agent <= _GEN_830;
      end
    end
    if (reset) begin // @[AccountantExtPrice.scala 53:31]
      regAssignments_8_valid <= 1'h0; // @[AccountantExtPrice.scala 53:31]
    end else if (!(_T)) begin // @[Conditional.scala 40:58]
      if (_T_10) begin // @[Conditional.scala 39:67]
        if (regBid > 8'h0) begin // @[AccountantExtPrice.scala 90:27]
          regAssignments_8_valid <= _GEN_209;
        end
      end else if (!(_T_20)) begin // @[Conditional.scala 39:67]
        regAssignments_8_valid <= _GEN_829;
      end
    end
    if (reset) begin // @[AccountantExtPrice.scala 53:31]
      regAssignments_9_agent <= 6'h0; // @[AccountantExtPrice.scala 53:31]
    end else if (!(_T)) begin // @[Conditional.scala 40:58]
      if (_T_10) begin // @[Conditional.scala 39:67]
        if (regBid > 8'h0) begin // @[AccountantExtPrice.scala 90:27]
          regAssignments_9_agent <= _GEN_146;
        end
      end else if (!(_T_20)) begin // @[Conditional.scala 39:67]
        regAssignments_9_agent <= _GEN_832;
      end
    end
    if (reset) begin // @[AccountantExtPrice.scala 53:31]
      regAssignments_9_valid <= 1'h0; // @[AccountantExtPrice.scala 53:31]
    end else if (!(_T)) begin // @[Conditional.scala 40:58]
      if (_T_10) begin // @[Conditional.scala 39:67]
        if (regBid > 8'h0) begin // @[AccountantExtPrice.scala 90:27]
          regAssignments_9_valid <= _GEN_210;
        end
      end else if (!(_T_20)) begin // @[Conditional.scala 39:67]
        regAssignments_9_valid <= _GEN_831;
      end
    end
    if (reset) begin // @[AccountantExtPrice.scala 53:31]
      regAssignments_10_agent <= 6'h0; // @[AccountantExtPrice.scala 53:31]
    end else if (!(_T)) begin // @[Conditional.scala 40:58]
      if (_T_10) begin // @[Conditional.scala 39:67]
        if (regBid > 8'h0) begin // @[AccountantExtPrice.scala 90:27]
          regAssignments_10_agent <= _GEN_147;
        end
      end else if (!(_T_20)) begin // @[Conditional.scala 39:67]
        regAssignments_10_agent <= _GEN_834;
      end
    end
    if (reset) begin // @[AccountantExtPrice.scala 53:31]
      regAssignments_10_valid <= 1'h0; // @[AccountantExtPrice.scala 53:31]
    end else if (!(_T)) begin // @[Conditional.scala 40:58]
      if (_T_10) begin // @[Conditional.scala 39:67]
        if (regBid > 8'h0) begin // @[AccountantExtPrice.scala 90:27]
          regAssignments_10_valid <= _GEN_211;
        end
      end else if (!(_T_20)) begin // @[Conditional.scala 39:67]
        regAssignments_10_valid <= _GEN_833;
      end
    end
    if (reset) begin // @[AccountantExtPrice.scala 53:31]
      regAssignments_11_agent <= 6'h0; // @[AccountantExtPrice.scala 53:31]
    end else if (!(_T)) begin // @[Conditional.scala 40:58]
      if (_T_10) begin // @[Conditional.scala 39:67]
        if (regBid > 8'h0) begin // @[AccountantExtPrice.scala 90:27]
          regAssignments_11_agent <= _GEN_148;
        end
      end else if (!(_T_20)) begin // @[Conditional.scala 39:67]
        regAssignments_11_agent <= _GEN_836;
      end
    end
    if (reset) begin // @[AccountantExtPrice.scala 53:31]
      regAssignments_11_valid <= 1'h0; // @[AccountantExtPrice.scala 53:31]
    end else if (!(_T)) begin // @[Conditional.scala 40:58]
      if (_T_10) begin // @[Conditional.scala 39:67]
        if (regBid > 8'h0) begin // @[AccountantExtPrice.scala 90:27]
          regAssignments_11_valid <= _GEN_212;
        end
      end else if (!(_T_20)) begin // @[Conditional.scala 39:67]
        regAssignments_11_valid <= _GEN_835;
      end
    end
    if (reset) begin // @[AccountantExtPrice.scala 53:31]
      regAssignments_12_agent <= 6'h0; // @[AccountantExtPrice.scala 53:31]
    end else if (!(_T)) begin // @[Conditional.scala 40:58]
      if (_T_10) begin // @[Conditional.scala 39:67]
        if (regBid > 8'h0) begin // @[AccountantExtPrice.scala 90:27]
          regAssignments_12_agent <= _GEN_149;
        end
      end else if (!(_T_20)) begin // @[Conditional.scala 39:67]
        regAssignments_12_agent <= _GEN_838;
      end
    end
    if (reset) begin // @[AccountantExtPrice.scala 53:31]
      regAssignments_12_valid <= 1'h0; // @[AccountantExtPrice.scala 53:31]
    end else if (!(_T)) begin // @[Conditional.scala 40:58]
      if (_T_10) begin // @[Conditional.scala 39:67]
        if (regBid > 8'h0) begin // @[AccountantExtPrice.scala 90:27]
          regAssignments_12_valid <= _GEN_213;
        end
      end else if (!(_T_20)) begin // @[Conditional.scala 39:67]
        regAssignments_12_valid <= _GEN_837;
      end
    end
    if (reset) begin // @[AccountantExtPrice.scala 53:31]
      regAssignments_13_agent <= 6'h0; // @[AccountantExtPrice.scala 53:31]
    end else if (!(_T)) begin // @[Conditional.scala 40:58]
      if (_T_10) begin // @[Conditional.scala 39:67]
        if (regBid > 8'h0) begin // @[AccountantExtPrice.scala 90:27]
          regAssignments_13_agent <= _GEN_150;
        end
      end else if (!(_T_20)) begin // @[Conditional.scala 39:67]
        regAssignments_13_agent <= _GEN_840;
      end
    end
    if (reset) begin // @[AccountantExtPrice.scala 53:31]
      regAssignments_13_valid <= 1'h0; // @[AccountantExtPrice.scala 53:31]
    end else if (!(_T)) begin // @[Conditional.scala 40:58]
      if (_T_10) begin // @[Conditional.scala 39:67]
        if (regBid > 8'h0) begin // @[AccountantExtPrice.scala 90:27]
          regAssignments_13_valid <= _GEN_214;
        end
      end else if (!(_T_20)) begin // @[Conditional.scala 39:67]
        regAssignments_13_valid <= _GEN_839;
      end
    end
    if (reset) begin // @[AccountantExtPrice.scala 53:31]
      regAssignments_14_agent <= 6'h0; // @[AccountantExtPrice.scala 53:31]
    end else if (!(_T)) begin // @[Conditional.scala 40:58]
      if (_T_10) begin // @[Conditional.scala 39:67]
        if (regBid > 8'h0) begin // @[AccountantExtPrice.scala 90:27]
          regAssignments_14_agent <= _GEN_151;
        end
      end else if (!(_T_20)) begin // @[Conditional.scala 39:67]
        regAssignments_14_agent <= _GEN_842;
      end
    end
    if (reset) begin // @[AccountantExtPrice.scala 53:31]
      regAssignments_14_valid <= 1'h0; // @[AccountantExtPrice.scala 53:31]
    end else if (!(_T)) begin // @[Conditional.scala 40:58]
      if (_T_10) begin // @[Conditional.scala 39:67]
        if (regBid > 8'h0) begin // @[AccountantExtPrice.scala 90:27]
          regAssignments_14_valid <= _GEN_215;
        end
      end else if (!(_T_20)) begin // @[Conditional.scala 39:67]
        regAssignments_14_valid <= _GEN_841;
      end
    end
    if (reset) begin // @[AccountantExtPrice.scala 53:31]
      regAssignments_15_agent <= 6'h0; // @[AccountantExtPrice.scala 53:31]
    end else if (!(_T)) begin // @[Conditional.scala 40:58]
      if (_T_10) begin // @[Conditional.scala 39:67]
        if (regBid > 8'h0) begin // @[AccountantExtPrice.scala 90:27]
          regAssignments_15_agent <= _GEN_152;
        end
      end else if (!(_T_20)) begin // @[Conditional.scala 39:67]
        regAssignments_15_agent <= _GEN_844;
      end
    end
    if (reset) begin // @[AccountantExtPrice.scala 53:31]
      regAssignments_15_valid <= 1'h0; // @[AccountantExtPrice.scala 53:31]
    end else if (!(_T)) begin // @[Conditional.scala 40:58]
      if (_T_10) begin // @[Conditional.scala 39:67]
        if (regBid > 8'h0) begin // @[AccountantExtPrice.scala 90:27]
          regAssignments_15_valid <= _GEN_216;
        end
      end else if (!(_T_20)) begin // @[Conditional.scala 39:67]
        regAssignments_15_valid <= _GEN_843;
      end
    end
    if (reset) begin // @[AccountantExtPrice.scala 53:31]
      regAssignments_16_agent <= 6'h0; // @[AccountantExtPrice.scala 53:31]
    end else if (!(_T)) begin // @[Conditional.scala 40:58]
      if (_T_10) begin // @[Conditional.scala 39:67]
        if (regBid > 8'h0) begin // @[AccountantExtPrice.scala 90:27]
          regAssignments_16_agent <= _GEN_153;
        end
      end else if (!(_T_20)) begin // @[Conditional.scala 39:67]
        regAssignments_16_agent <= _GEN_846;
      end
    end
    if (reset) begin // @[AccountantExtPrice.scala 53:31]
      regAssignments_16_valid <= 1'h0; // @[AccountantExtPrice.scala 53:31]
    end else if (!(_T)) begin // @[Conditional.scala 40:58]
      if (_T_10) begin // @[Conditional.scala 39:67]
        if (regBid > 8'h0) begin // @[AccountantExtPrice.scala 90:27]
          regAssignments_16_valid <= _GEN_217;
        end
      end else if (!(_T_20)) begin // @[Conditional.scala 39:67]
        regAssignments_16_valid <= _GEN_845;
      end
    end
    if (reset) begin // @[AccountantExtPrice.scala 53:31]
      regAssignments_17_agent <= 6'h0; // @[AccountantExtPrice.scala 53:31]
    end else if (!(_T)) begin // @[Conditional.scala 40:58]
      if (_T_10) begin // @[Conditional.scala 39:67]
        if (regBid > 8'h0) begin // @[AccountantExtPrice.scala 90:27]
          regAssignments_17_agent <= _GEN_154;
        end
      end else if (!(_T_20)) begin // @[Conditional.scala 39:67]
        regAssignments_17_agent <= _GEN_848;
      end
    end
    if (reset) begin // @[AccountantExtPrice.scala 53:31]
      regAssignments_17_valid <= 1'h0; // @[AccountantExtPrice.scala 53:31]
    end else if (!(_T)) begin // @[Conditional.scala 40:58]
      if (_T_10) begin // @[Conditional.scala 39:67]
        if (regBid > 8'h0) begin // @[AccountantExtPrice.scala 90:27]
          regAssignments_17_valid <= _GEN_218;
        end
      end else if (!(_T_20)) begin // @[Conditional.scala 39:67]
        regAssignments_17_valid <= _GEN_847;
      end
    end
    if (reset) begin // @[AccountantExtPrice.scala 53:31]
      regAssignments_18_agent <= 6'h0; // @[AccountantExtPrice.scala 53:31]
    end else if (!(_T)) begin // @[Conditional.scala 40:58]
      if (_T_10) begin // @[Conditional.scala 39:67]
        if (regBid > 8'h0) begin // @[AccountantExtPrice.scala 90:27]
          regAssignments_18_agent <= _GEN_155;
        end
      end else if (!(_T_20)) begin // @[Conditional.scala 39:67]
        regAssignments_18_agent <= _GEN_850;
      end
    end
    if (reset) begin // @[AccountantExtPrice.scala 53:31]
      regAssignments_18_valid <= 1'h0; // @[AccountantExtPrice.scala 53:31]
    end else if (!(_T)) begin // @[Conditional.scala 40:58]
      if (_T_10) begin // @[Conditional.scala 39:67]
        if (regBid > 8'h0) begin // @[AccountantExtPrice.scala 90:27]
          regAssignments_18_valid <= _GEN_219;
        end
      end else if (!(_T_20)) begin // @[Conditional.scala 39:67]
        regAssignments_18_valid <= _GEN_849;
      end
    end
    if (reset) begin // @[AccountantExtPrice.scala 53:31]
      regAssignments_19_agent <= 6'h0; // @[AccountantExtPrice.scala 53:31]
    end else if (!(_T)) begin // @[Conditional.scala 40:58]
      if (_T_10) begin // @[Conditional.scala 39:67]
        if (regBid > 8'h0) begin // @[AccountantExtPrice.scala 90:27]
          regAssignments_19_agent <= _GEN_156;
        end
      end else if (!(_T_20)) begin // @[Conditional.scala 39:67]
        regAssignments_19_agent <= _GEN_852;
      end
    end
    if (reset) begin // @[AccountantExtPrice.scala 53:31]
      regAssignments_19_valid <= 1'h0; // @[AccountantExtPrice.scala 53:31]
    end else if (!(_T)) begin // @[Conditional.scala 40:58]
      if (_T_10) begin // @[Conditional.scala 39:67]
        if (regBid > 8'h0) begin // @[AccountantExtPrice.scala 90:27]
          regAssignments_19_valid <= _GEN_220;
        end
      end else if (!(_T_20)) begin // @[Conditional.scala 39:67]
        regAssignments_19_valid <= _GEN_851;
      end
    end
    if (reset) begin // @[AccountantExtPrice.scala 53:31]
      regAssignments_20_agent <= 6'h0; // @[AccountantExtPrice.scala 53:31]
    end else if (!(_T)) begin // @[Conditional.scala 40:58]
      if (_T_10) begin // @[Conditional.scala 39:67]
        if (regBid > 8'h0) begin // @[AccountantExtPrice.scala 90:27]
          regAssignments_20_agent <= _GEN_157;
        end
      end else if (!(_T_20)) begin // @[Conditional.scala 39:67]
        regAssignments_20_agent <= _GEN_854;
      end
    end
    if (reset) begin // @[AccountantExtPrice.scala 53:31]
      regAssignments_20_valid <= 1'h0; // @[AccountantExtPrice.scala 53:31]
    end else if (!(_T)) begin // @[Conditional.scala 40:58]
      if (_T_10) begin // @[Conditional.scala 39:67]
        if (regBid > 8'h0) begin // @[AccountantExtPrice.scala 90:27]
          regAssignments_20_valid <= _GEN_221;
        end
      end else if (!(_T_20)) begin // @[Conditional.scala 39:67]
        regAssignments_20_valid <= _GEN_853;
      end
    end
    if (reset) begin // @[AccountantExtPrice.scala 53:31]
      regAssignments_21_agent <= 6'h0; // @[AccountantExtPrice.scala 53:31]
    end else if (!(_T)) begin // @[Conditional.scala 40:58]
      if (_T_10) begin // @[Conditional.scala 39:67]
        if (regBid > 8'h0) begin // @[AccountantExtPrice.scala 90:27]
          regAssignments_21_agent <= _GEN_158;
        end
      end else if (!(_T_20)) begin // @[Conditional.scala 39:67]
        regAssignments_21_agent <= _GEN_856;
      end
    end
    if (reset) begin // @[AccountantExtPrice.scala 53:31]
      regAssignments_21_valid <= 1'h0; // @[AccountantExtPrice.scala 53:31]
    end else if (!(_T)) begin // @[Conditional.scala 40:58]
      if (_T_10) begin // @[Conditional.scala 39:67]
        if (regBid > 8'h0) begin // @[AccountantExtPrice.scala 90:27]
          regAssignments_21_valid <= _GEN_222;
        end
      end else if (!(_T_20)) begin // @[Conditional.scala 39:67]
        regAssignments_21_valid <= _GEN_855;
      end
    end
    if (reset) begin // @[AccountantExtPrice.scala 53:31]
      regAssignments_22_agent <= 6'h0; // @[AccountantExtPrice.scala 53:31]
    end else if (!(_T)) begin // @[Conditional.scala 40:58]
      if (_T_10) begin // @[Conditional.scala 39:67]
        if (regBid > 8'h0) begin // @[AccountantExtPrice.scala 90:27]
          regAssignments_22_agent <= _GEN_159;
        end
      end else if (!(_T_20)) begin // @[Conditional.scala 39:67]
        regAssignments_22_agent <= _GEN_858;
      end
    end
    if (reset) begin // @[AccountantExtPrice.scala 53:31]
      regAssignments_22_valid <= 1'h0; // @[AccountantExtPrice.scala 53:31]
    end else if (!(_T)) begin // @[Conditional.scala 40:58]
      if (_T_10) begin // @[Conditional.scala 39:67]
        if (regBid > 8'h0) begin // @[AccountantExtPrice.scala 90:27]
          regAssignments_22_valid <= _GEN_223;
        end
      end else if (!(_T_20)) begin // @[Conditional.scala 39:67]
        regAssignments_22_valid <= _GEN_857;
      end
    end
    if (reset) begin // @[AccountantExtPrice.scala 53:31]
      regAssignments_23_agent <= 6'h0; // @[AccountantExtPrice.scala 53:31]
    end else if (!(_T)) begin // @[Conditional.scala 40:58]
      if (_T_10) begin // @[Conditional.scala 39:67]
        if (regBid > 8'h0) begin // @[AccountantExtPrice.scala 90:27]
          regAssignments_23_agent <= _GEN_160;
        end
      end else if (!(_T_20)) begin // @[Conditional.scala 39:67]
        regAssignments_23_agent <= _GEN_860;
      end
    end
    if (reset) begin // @[AccountantExtPrice.scala 53:31]
      regAssignments_23_valid <= 1'h0; // @[AccountantExtPrice.scala 53:31]
    end else if (!(_T)) begin // @[Conditional.scala 40:58]
      if (_T_10) begin // @[Conditional.scala 39:67]
        if (regBid > 8'h0) begin // @[AccountantExtPrice.scala 90:27]
          regAssignments_23_valid <= _GEN_224;
        end
      end else if (!(_T_20)) begin // @[Conditional.scala 39:67]
        regAssignments_23_valid <= _GEN_859;
      end
    end
    if (reset) begin // @[AccountantExtPrice.scala 53:31]
      regAssignments_24_agent <= 6'h0; // @[AccountantExtPrice.scala 53:31]
    end else if (!(_T)) begin // @[Conditional.scala 40:58]
      if (_T_10) begin // @[Conditional.scala 39:67]
        if (regBid > 8'h0) begin // @[AccountantExtPrice.scala 90:27]
          regAssignments_24_agent <= _GEN_161;
        end
      end else if (!(_T_20)) begin // @[Conditional.scala 39:67]
        regAssignments_24_agent <= _GEN_862;
      end
    end
    if (reset) begin // @[AccountantExtPrice.scala 53:31]
      regAssignments_24_valid <= 1'h0; // @[AccountantExtPrice.scala 53:31]
    end else if (!(_T)) begin // @[Conditional.scala 40:58]
      if (_T_10) begin // @[Conditional.scala 39:67]
        if (regBid > 8'h0) begin // @[AccountantExtPrice.scala 90:27]
          regAssignments_24_valid <= _GEN_225;
        end
      end else if (!(_T_20)) begin // @[Conditional.scala 39:67]
        regAssignments_24_valid <= _GEN_861;
      end
    end
    if (reset) begin // @[AccountantExtPrice.scala 53:31]
      regAssignments_25_agent <= 6'h0; // @[AccountantExtPrice.scala 53:31]
    end else if (!(_T)) begin // @[Conditional.scala 40:58]
      if (_T_10) begin // @[Conditional.scala 39:67]
        if (regBid > 8'h0) begin // @[AccountantExtPrice.scala 90:27]
          regAssignments_25_agent <= _GEN_162;
        end
      end else if (!(_T_20)) begin // @[Conditional.scala 39:67]
        regAssignments_25_agent <= _GEN_864;
      end
    end
    if (reset) begin // @[AccountantExtPrice.scala 53:31]
      regAssignments_25_valid <= 1'h0; // @[AccountantExtPrice.scala 53:31]
    end else if (!(_T)) begin // @[Conditional.scala 40:58]
      if (_T_10) begin // @[Conditional.scala 39:67]
        if (regBid > 8'h0) begin // @[AccountantExtPrice.scala 90:27]
          regAssignments_25_valid <= _GEN_226;
        end
      end else if (!(_T_20)) begin // @[Conditional.scala 39:67]
        regAssignments_25_valid <= _GEN_863;
      end
    end
    if (reset) begin // @[AccountantExtPrice.scala 53:31]
      regAssignments_26_agent <= 6'h0; // @[AccountantExtPrice.scala 53:31]
    end else if (!(_T)) begin // @[Conditional.scala 40:58]
      if (_T_10) begin // @[Conditional.scala 39:67]
        if (regBid > 8'h0) begin // @[AccountantExtPrice.scala 90:27]
          regAssignments_26_agent <= _GEN_163;
        end
      end else if (!(_T_20)) begin // @[Conditional.scala 39:67]
        regAssignments_26_agent <= _GEN_866;
      end
    end
    if (reset) begin // @[AccountantExtPrice.scala 53:31]
      regAssignments_26_valid <= 1'h0; // @[AccountantExtPrice.scala 53:31]
    end else if (!(_T)) begin // @[Conditional.scala 40:58]
      if (_T_10) begin // @[Conditional.scala 39:67]
        if (regBid > 8'h0) begin // @[AccountantExtPrice.scala 90:27]
          regAssignments_26_valid <= _GEN_227;
        end
      end else if (!(_T_20)) begin // @[Conditional.scala 39:67]
        regAssignments_26_valid <= _GEN_865;
      end
    end
    if (reset) begin // @[AccountantExtPrice.scala 53:31]
      regAssignments_27_agent <= 6'h0; // @[AccountantExtPrice.scala 53:31]
    end else if (!(_T)) begin // @[Conditional.scala 40:58]
      if (_T_10) begin // @[Conditional.scala 39:67]
        if (regBid > 8'h0) begin // @[AccountantExtPrice.scala 90:27]
          regAssignments_27_agent <= _GEN_164;
        end
      end else if (!(_T_20)) begin // @[Conditional.scala 39:67]
        regAssignments_27_agent <= _GEN_868;
      end
    end
    if (reset) begin // @[AccountantExtPrice.scala 53:31]
      regAssignments_27_valid <= 1'h0; // @[AccountantExtPrice.scala 53:31]
    end else if (!(_T)) begin // @[Conditional.scala 40:58]
      if (_T_10) begin // @[Conditional.scala 39:67]
        if (regBid > 8'h0) begin // @[AccountantExtPrice.scala 90:27]
          regAssignments_27_valid <= _GEN_228;
        end
      end else if (!(_T_20)) begin // @[Conditional.scala 39:67]
        regAssignments_27_valid <= _GEN_867;
      end
    end
    if (reset) begin // @[AccountantExtPrice.scala 53:31]
      regAssignments_28_agent <= 6'h0; // @[AccountantExtPrice.scala 53:31]
    end else if (!(_T)) begin // @[Conditional.scala 40:58]
      if (_T_10) begin // @[Conditional.scala 39:67]
        if (regBid > 8'h0) begin // @[AccountantExtPrice.scala 90:27]
          regAssignments_28_agent <= _GEN_165;
        end
      end else if (!(_T_20)) begin // @[Conditional.scala 39:67]
        regAssignments_28_agent <= _GEN_870;
      end
    end
    if (reset) begin // @[AccountantExtPrice.scala 53:31]
      regAssignments_28_valid <= 1'h0; // @[AccountantExtPrice.scala 53:31]
    end else if (!(_T)) begin // @[Conditional.scala 40:58]
      if (_T_10) begin // @[Conditional.scala 39:67]
        if (regBid > 8'h0) begin // @[AccountantExtPrice.scala 90:27]
          regAssignments_28_valid <= _GEN_229;
        end
      end else if (!(_T_20)) begin // @[Conditional.scala 39:67]
        regAssignments_28_valid <= _GEN_869;
      end
    end
    if (reset) begin // @[AccountantExtPrice.scala 53:31]
      regAssignments_29_agent <= 6'h0; // @[AccountantExtPrice.scala 53:31]
    end else if (!(_T)) begin // @[Conditional.scala 40:58]
      if (_T_10) begin // @[Conditional.scala 39:67]
        if (regBid > 8'h0) begin // @[AccountantExtPrice.scala 90:27]
          regAssignments_29_agent <= _GEN_166;
        end
      end else if (!(_T_20)) begin // @[Conditional.scala 39:67]
        regAssignments_29_agent <= _GEN_872;
      end
    end
    if (reset) begin // @[AccountantExtPrice.scala 53:31]
      regAssignments_29_valid <= 1'h0; // @[AccountantExtPrice.scala 53:31]
    end else if (!(_T)) begin // @[Conditional.scala 40:58]
      if (_T_10) begin // @[Conditional.scala 39:67]
        if (regBid > 8'h0) begin // @[AccountantExtPrice.scala 90:27]
          regAssignments_29_valid <= _GEN_230;
        end
      end else if (!(_T_20)) begin // @[Conditional.scala 39:67]
        regAssignments_29_valid <= _GEN_871;
      end
    end
    if (reset) begin // @[AccountantExtPrice.scala 53:31]
      regAssignments_30_agent <= 6'h0; // @[AccountantExtPrice.scala 53:31]
    end else if (!(_T)) begin // @[Conditional.scala 40:58]
      if (_T_10) begin // @[Conditional.scala 39:67]
        if (regBid > 8'h0) begin // @[AccountantExtPrice.scala 90:27]
          regAssignments_30_agent <= _GEN_167;
        end
      end else if (!(_T_20)) begin // @[Conditional.scala 39:67]
        regAssignments_30_agent <= _GEN_874;
      end
    end
    if (reset) begin // @[AccountantExtPrice.scala 53:31]
      regAssignments_30_valid <= 1'h0; // @[AccountantExtPrice.scala 53:31]
    end else if (!(_T)) begin // @[Conditional.scala 40:58]
      if (_T_10) begin // @[Conditional.scala 39:67]
        if (regBid > 8'h0) begin // @[AccountantExtPrice.scala 90:27]
          regAssignments_30_valid <= _GEN_231;
        end
      end else if (!(_T_20)) begin // @[Conditional.scala 39:67]
        regAssignments_30_valid <= _GEN_873;
      end
    end
    if (reset) begin // @[AccountantExtPrice.scala 53:31]
      regAssignments_31_agent <= 6'h0; // @[AccountantExtPrice.scala 53:31]
    end else if (!(_T)) begin // @[Conditional.scala 40:58]
      if (_T_10) begin // @[Conditional.scala 39:67]
        if (regBid > 8'h0) begin // @[AccountantExtPrice.scala 90:27]
          regAssignments_31_agent <= _GEN_168;
        end
      end else if (!(_T_20)) begin // @[Conditional.scala 39:67]
        regAssignments_31_agent <= _GEN_876;
      end
    end
    if (reset) begin // @[AccountantExtPrice.scala 53:31]
      regAssignments_31_valid <= 1'h0; // @[AccountantExtPrice.scala 53:31]
    end else if (!(_T)) begin // @[Conditional.scala 40:58]
      if (_T_10) begin // @[Conditional.scala 39:67]
        if (regBid > 8'h0) begin // @[AccountantExtPrice.scala 90:27]
          regAssignments_31_valid <= _GEN_232;
        end
      end else if (!(_T_20)) begin // @[Conditional.scala 39:67]
        regAssignments_31_valid <= _GEN_875;
      end
    end
    if (reset) begin // @[AccountantExtPrice.scala 53:31]
      regAssignments_32_agent <= 6'h0; // @[AccountantExtPrice.scala 53:31]
    end else if (!(_T)) begin // @[Conditional.scala 40:58]
      if (_T_10) begin // @[Conditional.scala 39:67]
        if (regBid > 8'h0) begin // @[AccountantExtPrice.scala 90:27]
          regAssignments_32_agent <= _GEN_169;
        end
      end else if (!(_T_20)) begin // @[Conditional.scala 39:67]
        regAssignments_32_agent <= _GEN_878;
      end
    end
    if (reset) begin // @[AccountantExtPrice.scala 53:31]
      regAssignments_32_valid <= 1'h0; // @[AccountantExtPrice.scala 53:31]
    end else if (!(_T)) begin // @[Conditional.scala 40:58]
      if (_T_10) begin // @[Conditional.scala 39:67]
        if (regBid > 8'h0) begin // @[AccountantExtPrice.scala 90:27]
          regAssignments_32_valid <= _GEN_233;
        end
      end else if (!(_T_20)) begin // @[Conditional.scala 39:67]
        regAssignments_32_valid <= _GEN_877;
      end
    end
    if (reset) begin // @[AccountantExtPrice.scala 53:31]
      regAssignments_33_agent <= 6'h0; // @[AccountantExtPrice.scala 53:31]
    end else if (!(_T)) begin // @[Conditional.scala 40:58]
      if (_T_10) begin // @[Conditional.scala 39:67]
        if (regBid > 8'h0) begin // @[AccountantExtPrice.scala 90:27]
          regAssignments_33_agent <= _GEN_170;
        end
      end else if (!(_T_20)) begin // @[Conditional.scala 39:67]
        regAssignments_33_agent <= _GEN_880;
      end
    end
    if (reset) begin // @[AccountantExtPrice.scala 53:31]
      regAssignments_33_valid <= 1'h0; // @[AccountantExtPrice.scala 53:31]
    end else if (!(_T)) begin // @[Conditional.scala 40:58]
      if (_T_10) begin // @[Conditional.scala 39:67]
        if (regBid > 8'h0) begin // @[AccountantExtPrice.scala 90:27]
          regAssignments_33_valid <= _GEN_234;
        end
      end else if (!(_T_20)) begin // @[Conditional.scala 39:67]
        regAssignments_33_valid <= _GEN_879;
      end
    end
    if (reset) begin // @[AccountantExtPrice.scala 53:31]
      regAssignments_34_agent <= 6'h0; // @[AccountantExtPrice.scala 53:31]
    end else if (!(_T)) begin // @[Conditional.scala 40:58]
      if (_T_10) begin // @[Conditional.scala 39:67]
        if (regBid > 8'h0) begin // @[AccountantExtPrice.scala 90:27]
          regAssignments_34_agent <= _GEN_171;
        end
      end else if (!(_T_20)) begin // @[Conditional.scala 39:67]
        regAssignments_34_agent <= _GEN_882;
      end
    end
    if (reset) begin // @[AccountantExtPrice.scala 53:31]
      regAssignments_34_valid <= 1'h0; // @[AccountantExtPrice.scala 53:31]
    end else if (!(_T)) begin // @[Conditional.scala 40:58]
      if (_T_10) begin // @[Conditional.scala 39:67]
        if (regBid > 8'h0) begin // @[AccountantExtPrice.scala 90:27]
          regAssignments_34_valid <= _GEN_235;
        end
      end else if (!(_T_20)) begin // @[Conditional.scala 39:67]
        regAssignments_34_valid <= _GEN_881;
      end
    end
    if (reset) begin // @[AccountantExtPrice.scala 53:31]
      regAssignments_35_agent <= 6'h0; // @[AccountantExtPrice.scala 53:31]
    end else if (!(_T)) begin // @[Conditional.scala 40:58]
      if (_T_10) begin // @[Conditional.scala 39:67]
        if (regBid > 8'h0) begin // @[AccountantExtPrice.scala 90:27]
          regAssignments_35_agent <= _GEN_172;
        end
      end else if (!(_T_20)) begin // @[Conditional.scala 39:67]
        regAssignments_35_agent <= _GEN_884;
      end
    end
    if (reset) begin // @[AccountantExtPrice.scala 53:31]
      regAssignments_35_valid <= 1'h0; // @[AccountantExtPrice.scala 53:31]
    end else if (!(_T)) begin // @[Conditional.scala 40:58]
      if (_T_10) begin // @[Conditional.scala 39:67]
        if (regBid > 8'h0) begin // @[AccountantExtPrice.scala 90:27]
          regAssignments_35_valid <= _GEN_236;
        end
      end else if (!(_T_20)) begin // @[Conditional.scala 39:67]
        regAssignments_35_valid <= _GEN_883;
      end
    end
    if (reset) begin // @[AccountantExtPrice.scala 53:31]
      regAssignments_36_agent <= 6'h0; // @[AccountantExtPrice.scala 53:31]
    end else if (!(_T)) begin // @[Conditional.scala 40:58]
      if (_T_10) begin // @[Conditional.scala 39:67]
        if (regBid > 8'h0) begin // @[AccountantExtPrice.scala 90:27]
          regAssignments_36_agent <= _GEN_173;
        end
      end else if (!(_T_20)) begin // @[Conditional.scala 39:67]
        regAssignments_36_agent <= _GEN_886;
      end
    end
    if (reset) begin // @[AccountantExtPrice.scala 53:31]
      regAssignments_36_valid <= 1'h0; // @[AccountantExtPrice.scala 53:31]
    end else if (!(_T)) begin // @[Conditional.scala 40:58]
      if (_T_10) begin // @[Conditional.scala 39:67]
        if (regBid > 8'h0) begin // @[AccountantExtPrice.scala 90:27]
          regAssignments_36_valid <= _GEN_237;
        end
      end else if (!(_T_20)) begin // @[Conditional.scala 39:67]
        regAssignments_36_valid <= _GEN_885;
      end
    end
    if (reset) begin // @[AccountantExtPrice.scala 53:31]
      regAssignments_37_agent <= 6'h0; // @[AccountantExtPrice.scala 53:31]
    end else if (!(_T)) begin // @[Conditional.scala 40:58]
      if (_T_10) begin // @[Conditional.scala 39:67]
        if (regBid > 8'h0) begin // @[AccountantExtPrice.scala 90:27]
          regAssignments_37_agent <= _GEN_174;
        end
      end else if (!(_T_20)) begin // @[Conditional.scala 39:67]
        regAssignments_37_agent <= _GEN_888;
      end
    end
    if (reset) begin // @[AccountantExtPrice.scala 53:31]
      regAssignments_37_valid <= 1'h0; // @[AccountantExtPrice.scala 53:31]
    end else if (!(_T)) begin // @[Conditional.scala 40:58]
      if (_T_10) begin // @[Conditional.scala 39:67]
        if (regBid > 8'h0) begin // @[AccountantExtPrice.scala 90:27]
          regAssignments_37_valid <= _GEN_238;
        end
      end else if (!(_T_20)) begin // @[Conditional.scala 39:67]
        regAssignments_37_valid <= _GEN_887;
      end
    end
    if (reset) begin // @[AccountantExtPrice.scala 53:31]
      regAssignments_38_agent <= 6'h0; // @[AccountantExtPrice.scala 53:31]
    end else if (!(_T)) begin // @[Conditional.scala 40:58]
      if (_T_10) begin // @[Conditional.scala 39:67]
        if (regBid > 8'h0) begin // @[AccountantExtPrice.scala 90:27]
          regAssignments_38_agent <= _GEN_175;
        end
      end else if (!(_T_20)) begin // @[Conditional.scala 39:67]
        regAssignments_38_agent <= _GEN_890;
      end
    end
    if (reset) begin // @[AccountantExtPrice.scala 53:31]
      regAssignments_38_valid <= 1'h0; // @[AccountantExtPrice.scala 53:31]
    end else if (!(_T)) begin // @[Conditional.scala 40:58]
      if (_T_10) begin // @[Conditional.scala 39:67]
        if (regBid > 8'h0) begin // @[AccountantExtPrice.scala 90:27]
          regAssignments_38_valid <= _GEN_239;
        end
      end else if (!(_T_20)) begin // @[Conditional.scala 39:67]
        regAssignments_38_valid <= _GEN_889;
      end
    end
    if (reset) begin // @[AccountantExtPrice.scala 53:31]
      regAssignments_39_agent <= 6'h0; // @[AccountantExtPrice.scala 53:31]
    end else if (!(_T)) begin // @[Conditional.scala 40:58]
      if (_T_10) begin // @[Conditional.scala 39:67]
        if (regBid > 8'h0) begin // @[AccountantExtPrice.scala 90:27]
          regAssignments_39_agent <= _GEN_176;
        end
      end else if (!(_T_20)) begin // @[Conditional.scala 39:67]
        regAssignments_39_agent <= _GEN_892;
      end
    end
    if (reset) begin // @[AccountantExtPrice.scala 53:31]
      regAssignments_39_valid <= 1'h0; // @[AccountantExtPrice.scala 53:31]
    end else if (!(_T)) begin // @[Conditional.scala 40:58]
      if (_T_10) begin // @[Conditional.scala 39:67]
        if (regBid > 8'h0) begin // @[AccountantExtPrice.scala 90:27]
          regAssignments_39_valid <= _GEN_240;
        end
      end else if (!(_T_20)) begin // @[Conditional.scala 39:67]
        regAssignments_39_valid <= _GEN_891;
      end
    end
    if (reset) begin // @[AccountantExtPrice.scala 53:31]
      regAssignments_40_agent <= 6'h0; // @[AccountantExtPrice.scala 53:31]
    end else if (!(_T)) begin // @[Conditional.scala 40:58]
      if (_T_10) begin // @[Conditional.scala 39:67]
        if (regBid > 8'h0) begin // @[AccountantExtPrice.scala 90:27]
          regAssignments_40_agent <= _GEN_177;
        end
      end else if (!(_T_20)) begin // @[Conditional.scala 39:67]
        regAssignments_40_agent <= _GEN_894;
      end
    end
    if (reset) begin // @[AccountantExtPrice.scala 53:31]
      regAssignments_40_valid <= 1'h0; // @[AccountantExtPrice.scala 53:31]
    end else if (!(_T)) begin // @[Conditional.scala 40:58]
      if (_T_10) begin // @[Conditional.scala 39:67]
        if (regBid > 8'h0) begin // @[AccountantExtPrice.scala 90:27]
          regAssignments_40_valid <= _GEN_241;
        end
      end else if (!(_T_20)) begin // @[Conditional.scala 39:67]
        regAssignments_40_valid <= _GEN_893;
      end
    end
    if (reset) begin // @[AccountantExtPrice.scala 53:31]
      regAssignments_41_agent <= 6'h0; // @[AccountantExtPrice.scala 53:31]
    end else if (!(_T)) begin // @[Conditional.scala 40:58]
      if (_T_10) begin // @[Conditional.scala 39:67]
        if (regBid > 8'h0) begin // @[AccountantExtPrice.scala 90:27]
          regAssignments_41_agent <= _GEN_178;
        end
      end else if (!(_T_20)) begin // @[Conditional.scala 39:67]
        regAssignments_41_agent <= _GEN_896;
      end
    end
    if (reset) begin // @[AccountantExtPrice.scala 53:31]
      regAssignments_41_valid <= 1'h0; // @[AccountantExtPrice.scala 53:31]
    end else if (!(_T)) begin // @[Conditional.scala 40:58]
      if (_T_10) begin // @[Conditional.scala 39:67]
        if (regBid > 8'h0) begin // @[AccountantExtPrice.scala 90:27]
          regAssignments_41_valid <= _GEN_242;
        end
      end else if (!(_T_20)) begin // @[Conditional.scala 39:67]
        regAssignments_41_valid <= _GEN_895;
      end
    end
    if (reset) begin // @[AccountantExtPrice.scala 53:31]
      regAssignments_42_agent <= 6'h0; // @[AccountantExtPrice.scala 53:31]
    end else if (!(_T)) begin // @[Conditional.scala 40:58]
      if (_T_10) begin // @[Conditional.scala 39:67]
        if (regBid > 8'h0) begin // @[AccountantExtPrice.scala 90:27]
          regAssignments_42_agent <= _GEN_179;
        end
      end else if (!(_T_20)) begin // @[Conditional.scala 39:67]
        regAssignments_42_agent <= _GEN_898;
      end
    end
    if (reset) begin // @[AccountantExtPrice.scala 53:31]
      regAssignments_42_valid <= 1'h0; // @[AccountantExtPrice.scala 53:31]
    end else if (!(_T)) begin // @[Conditional.scala 40:58]
      if (_T_10) begin // @[Conditional.scala 39:67]
        if (regBid > 8'h0) begin // @[AccountantExtPrice.scala 90:27]
          regAssignments_42_valid <= _GEN_243;
        end
      end else if (!(_T_20)) begin // @[Conditional.scala 39:67]
        regAssignments_42_valid <= _GEN_897;
      end
    end
    if (reset) begin // @[AccountantExtPrice.scala 53:31]
      regAssignments_43_agent <= 6'h0; // @[AccountantExtPrice.scala 53:31]
    end else if (!(_T)) begin // @[Conditional.scala 40:58]
      if (_T_10) begin // @[Conditional.scala 39:67]
        if (regBid > 8'h0) begin // @[AccountantExtPrice.scala 90:27]
          regAssignments_43_agent <= _GEN_180;
        end
      end else if (!(_T_20)) begin // @[Conditional.scala 39:67]
        regAssignments_43_agent <= _GEN_900;
      end
    end
    if (reset) begin // @[AccountantExtPrice.scala 53:31]
      regAssignments_43_valid <= 1'h0; // @[AccountantExtPrice.scala 53:31]
    end else if (!(_T)) begin // @[Conditional.scala 40:58]
      if (_T_10) begin // @[Conditional.scala 39:67]
        if (regBid > 8'h0) begin // @[AccountantExtPrice.scala 90:27]
          regAssignments_43_valid <= _GEN_244;
        end
      end else if (!(_T_20)) begin // @[Conditional.scala 39:67]
        regAssignments_43_valid <= _GEN_899;
      end
    end
    if (reset) begin // @[AccountantExtPrice.scala 53:31]
      regAssignments_44_agent <= 6'h0; // @[AccountantExtPrice.scala 53:31]
    end else if (!(_T)) begin // @[Conditional.scala 40:58]
      if (_T_10) begin // @[Conditional.scala 39:67]
        if (regBid > 8'h0) begin // @[AccountantExtPrice.scala 90:27]
          regAssignments_44_agent <= _GEN_181;
        end
      end else if (!(_T_20)) begin // @[Conditional.scala 39:67]
        regAssignments_44_agent <= _GEN_902;
      end
    end
    if (reset) begin // @[AccountantExtPrice.scala 53:31]
      regAssignments_44_valid <= 1'h0; // @[AccountantExtPrice.scala 53:31]
    end else if (!(_T)) begin // @[Conditional.scala 40:58]
      if (_T_10) begin // @[Conditional.scala 39:67]
        if (regBid > 8'h0) begin // @[AccountantExtPrice.scala 90:27]
          regAssignments_44_valid <= _GEN_245;
        end
      end else if (!(_T_20)) begin // @[Conditional.scala 39:67]
        regAssignments_44_valid <= _GEN_901;
      end
    end
    if (reset) begin // @[AccountantExtPrice.scala 53:31]
      regAssignments_45_agent <= 6'h0; // @[AccountantExtPrice.scala 53:31]
    end else if (!(_T)) begin // @[Conditional.scala 40:58]
      if (_T_10) begin // @[Conditional.scala 39:67]
        if (regBid > 8'h0) begin // @[AccountantExtPrice.scala 90:27]
          regAssignments_45_agent <= _GEN_182;
        end
      end else if (!(_T_20)) begin // @[Conditional.scala 39:67]
        regAssignments_45_agent <= _GEN_904;
      end
    end
    if (reset) begin // @[AccountantExtPrice.scala 53:31]
      regAssignments_45_valid <= 1'h0; // @[AccountantExtPrice.scala 53:31]
    end else if (!(_T)) begin // @[Conditional.scala 40:58]
      if (_T_10) begin // @[Conditional.scala 39:67]
        if (regBid > 8'h0) begin // @[AccountantExtPrice.scala 90:27]
          regAssignments_45_valid <= _GEN_246;
        end
      end else if (!(_T_20)) begin // @[Conditional.scala 39:67]
        regAssignments_45_valid <= _GEN_903;
      end
    end
    if (reset) begin // @[AccountantExtPrice.scala 53:31]
      regAssignments_46_agent <= 6'h0; // @[AccountantExtPrice.scala 53:31]
    end else if (!(_T)) begin // @[Conditional.scala 40:58]
      if (_T_10) begin // @[Conditional.scala 39:67]
        if (regBid > 8'h0) begin // @[AccountantExtPrice.scala 90:27]
          regAssignments_46_agent <= _GEN_183;
        end
      end else if (!(_T_20)) begin // @[Conditional.scala 39:67]
        regAssignments_46_agent <= _GEN_906;
      end
    end
    if (reset) begin // @[AccountantExtPrice.scala 53:31]
      regAssignments_46_valid <= 1'h0; // @[AccountantExtPrice.scala 53:31]
    end else if (!(_T)) begin // @[Conditional.scala 40:58]
      if (_T_10) begin // @[Conditional.scala 39:67]
        if (regBid > 8'h0) begin // @[AccountantExtPrice.scala 90:27]
          regAssignments_46_valid <= _GEN_247;
        end
      end else if (!(_T_20)) begin // @[Conditional.scala 39:67]
        regAssignments_46_valid <= _GEN_905;
      end
    end
    if (reset) begin // @[AccountantExtPrice.scala 53:31]
      regAssignments_47_agent <= 6'h0; // @[AccountantExtPrice.scala 53:31]
    end else if (!(_T)) begin // @[Conditional.scala 40:58]
      if (_T_10) begin // @[Conditional.scala 39:67]
        if (regBid > 8'h0) begin // @[AccountantExtPrice.scala 90:27]
          regAssignments_47_agent <= _GEN_184;
        end
      end else if (!(_T_20)) begin // @[Conditional.scala 39:67]
        regAssignments_47_agent <= _GEN_908;
      end
    end
    if (reset) begin // @[AccountantExtPrice.scala 53:31]
      regAssignments_47_valid <= 1'h0; // @[AccountantExtPrice.scala 53:31]
    end else if (!(_T)) begin // @[Conditional.scala 40:58]
      if (_T_10) begin // @[Conditional.scala 39:67]
        if (regBid > 8'h0) begin // @[AccountantExtPrice.scala 90:27]
          regAssignments_47_valid <= _GEN_248;
        end
      end else if (!(_T_20)) begin // @[Conditional.scala 39:67]
        regAssignments_47_valid <= _GEN_907;
      end
    end
    if (reset) begin // @[AccountantExtPrice.scala 53:31]
      regAssignments_48_agent <= 6'h0; // @[AccountantExtPrice.scala 53:31]
    end else if (!(_T)) begin // @[Conditional.scala 40:58]
      if (_T_10) begin // @[Conditional.scala 39:67]
        if (regBid > 8'h0) begin // @[AccountantExtPrice.scala 90:27]
          regAssignments_48_agent <= _GEN_185;
        end
      end else if (!(_T_20)) begin // @[Conditional.scala 39:67]
        regAssignments_48_agent <= _GEN_910;
      end
    end
    if (reset) begin // @[AccountantExtPrice.scala 53:31]
      regAssignments_48_valid <= 1'h0; // @[AccountantExtPrice.scala 53:31]
    end else if (!(_T)) begin // @[Conditional.scala 40:58]
      if (_T_10) begin // @[Conditional.scala 39:67]
        if (regBid > 8'h0) begin // @[AccountantExtPrice.scala 90:27]
          regAssignments_48_valid <= _GEN_249;
        end
      end else if (!(_T_20)) begin // @[Conditional.scala 39:67]
        regAssignments_48_valid <= _GEN_909;
      end
    end
    if (reset) begin // @[AccountantExtPrice.scala 53:31]
      regAssignments_49_agent <= 6'h0; // @[AccountantExtPrice.scala 53:31]
    end else if (!(_T)) begin // @[Conditional.scala 40:58]
      if (_T_10) begin // @[Conditional.scala 39:67]
        if (regBid > 8'h0) begin // @[AccountantExtPrice.scala 90:27]
          regAssignments_49_agent <= _GEN_186;
        end
      end else if (!(_T_20)) begin // @[Conditional.scala 39:67]
        regAssignments_49_agent <= _GEN_912;
      end
    end
    if (reset) begin // @[AccountantExtPrice.scala 53:31]
      regAssignments_49_valid <= 1'h0; // @[AccountantExtPrice.scala 53:31]
    end else if (!(_T)) begin // @[Conditional.scala 40:58]
      if (_T_10) begin // @[Conditional.scala 39:67]
        if (regBid > 8'h0) begin // @[AccountantExtPrice.scala 90:27]
          regAssignments_49_valid <= _GEN_250;
        end
      end else if (!(_T_20)) begin // @[Conditional.scala 39:67]
        regAssignments_49_valid <= _GEN_911;
      end
    end
    if (reset) begin // @[AccountantExtPrice.scala 53:31]
      regAssignments_50_agent <= 6'h0; // @[AccountantExtPrice.scala 53:31]
    end else if (!(_T)) begin // @[Conditional.scala 40:58]
      if (_T_10) begin // @[Conditional.scala 39:67]
        if (regBid > 8'h0) begin // @[AccountantExtPrice.scala 90:27]
          regAssignments_50_agent <= _GEN_187;
        end
      end else if (!(_T_20)) begin // @[Conditional.scala 39:67]
        regAssignments_50_agent <= _GEN_914;
      end
    end
    if (reset) begin // @[AccountantExtPrice.scala 53:31]
      regAssignments_50_valid <= 1'h0; // @[AccountantExtPrice.scala 53:31]
    end else if (!(_T)) begin // @[Conditional.scala 40:58]
      if (_T_10) begin // @[Conditional.scala 39:67]
        if (regBid > 8'h0) begin // @[AccountantExtPrice.scala 90:27]
          regAssignments_50_valid <= _GEN_251;
        end
      end else if (!(_T_20)) begin // @[Conditional.scala 39:67]
        regAssignments_50_valid <= _GEN_913;
      end
    end
    if (reset) begin // @[AccountantExtPrice.scala 53:31]
      regAssignments_51_agent <= 6'h0; // @[AccountantExtPrice.scala 53:31]
    end else if (!(_T)) begin // @[Conditional.scala 40:58]
      if (_T_10) begin // @[Conditional.scala 39:67]
        if (regBid > 8'h0) begin // @[AccountantExtPrice.scala 90:27]
          regAssignments_51_agent <= _GEN_188;
        end
      end else if (!(_T_20)) begin // @[Conditional.scala 39:67]
        regAssignments_51_agent <= _GEN_916;
      end
    end
    if (reset) begin // @[AccountantExtPrice.scala 53:31]
      regAssignments_51_valid <= 1'h0; // @[AccountantExtPrice.scala 53:31]
    end else if (!(_T)) begin // @[Conditional.scala 40:58]
      if (_T_10) begin // @[Conditional.scala 39:67]
        if (regBid > 8'h0) begin // @[AccountantExtPrice.scala 90:27]
          regAssignments_51_valid <= _GEN_252;
        end
      end else if (!(_T_20)) begin // @[Conditional.scala 39:67]
        regAssignments_51_valid <= _GEN_915;
      end
    end
    if (reset) begin // @[AccountantExtPrice.scala 53:31]
      regAssignments_52_agent <= 6'h0; // @[AccountantExtPrice.scala 53:31]
    end else if (!(_T)) begin // @[Conditional.scala 40:58]
      if (_T_10) begin // @[Conditional.scala 39:67]
        if (regBid > 8'h0) begin // @[AccountantExtPrice.scala 90:27]
          regAssignments_52_agent <= _GEN_189;
        end
      end else if (!(_T_20)) begin // @[Conditional.scala 39:67]
        regAssignments_52_agent <= _GEN_918;
      end
    end
    if (reset) begin // @[AccountantExtPrice.scala 53:31]
      regAssignments_52_valid <= 1'h0; // @[AccountantExtPrice.scala 53:31]
    end else if (!(_T)) begin // @[Conditional.scala 40:58]
      if (_T_10) begin // @[Conditional.scala 39:67]
        if (regBid > 8'h0) begin // @[AccountantExtPrice.scala 90:27]
          regAssignments_52_valid <= _GEN_253;
        end
      end else if (!(_T_20)) begin // @[Conditional.scala 39:67]
        regAssignments_52_valid <= _GEN_917;
      end
    end
    if (reset) begin // @[AccountantExtPrice.scala 53:31]
      regAssignments_53_agent <= 6'h0; // @[AccountantExtPrice.scala 53:31]
    end else if (!(_T)) begin // @[Conditional.scala 40:58]
      if (_T_10) begin // @[Conditional.scala 39:67]
        if (regBid > 8'h0) begin // @[AccountantExtPrice.scala 90:27]
          regAssignments_53_agent <= _GEN_190;
        end
      end else if (!(_T_20)) begin // @[Conditional.scala 39:67]
        regAssignments_53_agent <= _GEN_920;
      end
    end
    if (reset) begin // @[AccountantExtPrice.scala 53:31]
      regAssignments_53_valid <= 1'h0; // @[AccountantExtPrice.scala 53:31]
    end else if (!(_T)) begin // @[Conditional.scala 40:58]
      if (_T_10) begin // @[Conditional.scala 39:67]
        if (regBid > 8'h0) begin // @[AccountantExtPrice.scala 90:27]
          regAssignments_53_valid <= _GEN_254;
        end
      end else if (!(_T_20)) begin // @[Conditional.scala 39:67]
        regAssignments_53_valid <= _GEN_919;
      end
    end
    if (reset) begin // @[AccountantExtPrice.scala 53:31]
      regAssignments_54_agent <= 6'h0; // @[AccountantExtPrice.scala 53:31]
    end else if (!(_T)) begin // @[Conditional.scala 40:58]
      if (_T_10) begin // @[Conditional.scala 39:67]
        if (regBid > 8'h0) begin // @[AccountantExtPrice.scala 90:27]
          regAssignments_54_agent <= _GEN_191;
        end
      end else if (!(_T_20)) begin // @[Conditional.scala 39:67]
        regAssignments_54_agent <= _GEN_922;
      end
    end
    if (reset) begin // @[AccountantExtPrice.scala 53:31]
      regAssignments_54_valid <= 1'h0; // @[AccountantExtPrice.scala 53:31]
    end else if (!(_T)) begin // @[Conditional.scala 40:58]
      if (_T_10) begin // @[Conditional.scala 39:67]
        if (regBid > 8'h0) begin // @[AccountantExtPrice.scala 90:27]
          regAssignments_54_valid <= _GEN_255;
        end
      end else if (!(_T_20)) begin // @[Conditional.scala 39:67]
        regAssignments_54_valid <= _GEN_921;
      end
    end
    if (reset) begin // @[AccountantExtPrice.scala 53:31]
      regAssignments_55_agent <= 6'h0; // @[AccountantExtPrice.scala 53:31]
    end else if (!(_T)) begin // @[Conditional.scala 40:58]
      if (_T_10) begin // @[Conditional.scala 39:67]
        if (regBid > 8'h0) begin // @[AccountantExtPrice.scala 90:27]
          regAssignments_55_agent <= _GEN_192;
        end
      end else if (!(_T_20)) begin // @[Conditional.scala 39:67]
        regAssignments_55_agent <= _GEN_924;
      end
    end
    if (reset) begin // @[AccountantExtPrice.scala 53:31]
      regAssignments_55_valid <= 1'h0; // @[AccountantExtPrice.scala 53:31]
    end else if (!(_T)) begin // @[Conditional.scala 40:58]
      if (_T_10) begin // @[Conditional.scala 39:67]
        if (regBid > 8'h0) begin // @[AccountantExtPrice.scala 90:27]
          regAssignments_55_valid <= _GEN_256;
        end
      end else if (!(_T_20)) begin // @[Conditional.scala 39:67]
        regAssignments_55_valid <= _GEN_923;
      end
    end
    if (reset) begin // @[AccountantExtPrice.scala 53:31]
      regAssignments_56_agent <= 6'h0; // @[AccountantExtPrice.scala 53:31]
    end else if (!(_T)) begin // @[Conditional.scala 40:58]
      if (_T_10) begin // @[Conditional.scala 39:67]
        if (regBid > 8'h0) begin // @[AccountantExtPrice.scala 90:27]
          regAssignments_56_agent <= _GEN_193;
        end
      end else if (!(_T_20)) begin // @[Conditional.scala 39:67]
        regAssignments_56_agent <= _GEN_926;
      end
    end
    if (reset) begin // @[AccountantExtPrice.scala 53:31]
      regAssignments_56_valid <= 1'h0; // @[AccountantExtPrice.scala 53:31]
    end else if (!(_T)) begin // @[Conditional.scala 40:58]
      if (_T_10) begin // @[Conditional.scala 39:67]
        if (regBid > 8'h0) begin // @[AccountantExtPrice.scala 90:27]
          regAssignments_56_valid <= _GEN_257;
        end
      end else if (!(_T_20)) begin // @[Conditional.scala 39:67]
        regAssignments_56_valid <= _GEN_925;
      end
    end
    if (reset) begin // @[AccountantExtPrice.scala 53:31]
      regAssignments_57_agent <= 6'h0; // @[AccountantExtPrice.scala 53:31]
    end else if (!(_T)) begin // @[Conditional.scala 40:58]
      if (_T_10) begin // @[Conditional.scala 39:67]
        if (regBid > 8'h0) begin // @[AccountantExtPrice.scala 90:27]
          regAssignments_57_agent <= _GEN_194;
        end
      end else if (!(_T_20)) begin // @[Conditional.scala 39:67]
        regAssignments_57_agent <= _GEN_928;
      end
    end
    if (reset) begin // @[AccountantExtPrice.scala 53:31]
      regAssignments_57_valid <= 1'h0; // @[AccountantExtPrice.scala 53:31]
    end else if (!(_T)) begin // @[Conditional.scala 40:58]
      if (_T_10) begin // @[Conditional.scala 39:67]
        if (regBid > 8'h0) begin // @[AccountantExtPrice.scala 90:27]
          regAssignments_57_valid <= _GEN_258;
        end
      end else if (!(_T_20)) begin // @[Conditional.scala 39:67]
        regAssignments_57_valid <= _GEN_927;
      end
    end
    if (reset) begin // @[AccountantExtPrice.scala 53:31]
      regAssignments_58_agent <= 6'h0; // @[AccountantExtPrice.scala 53:31]
    end else if (!(_T)) begin // @[Conditional.scala 40:58]
      if (_T_10) begin // @[Conditional.scala 39:67]
        if (regBid > 8'h0) begin // @[AccountantExtPrice.scala 90:27]
          regAssignments_58_agent <= _GEN_195;
        end
      end else if (!(_T_20)) begin // @[Conditional.scala 39:67]
        regAssignments_58_agent <= _GEN_930;
      end
    end
    if (reset) begin // @[AccountantExtPrice.scala 53:31]
      regAssignments_58_valid <= 1'h0; // @[AccountantExtPrice.scala 53:31]
    end else if (!(_T)) begin // @[Conditional.scala 40:58]
      if (_T_10) begin // @[Conditional.scala 39:67]
        if (regBid > 8'h0) begin // @[AccountantExtPrice.scala 90:27]
          regAssignments_58_valid <= _GEN_259;
        end
      end else if (!(_T_20)) begin // @[Conditional.scala 39:67]
        regAssignments_58_valid <= _GEN_929;
      end
    end
    if (reset) begin // @[AccountantExtPrice.scala 53:31]
      regAssignments_59_agent <= 6'h0; // @[AccountantExtPrice.scala 53:31]
    end else if (!(_T)) begin // @[Conditional.scala 40:58]
      if (_T_10) begin // @[Conditional.scala 39:67]
        if (regBid > 8'h0) begin // @[AccountantExtPrice.scala 90:27]
          regAssignments_59_agent <= _GEN_196;
        end
      end else if (!(_T_20)) begin // @[Conditional.scala 39:67]
        regAssignments_59_agent <= _GEN_932;
      end
    end
    if (reset) begin // @[AccountantExtPrice.scala 53:31]
      regAssignments_59_valid <= 1'h0; // @[AccountantExtPrice.scala 53:31]
    end else if (!(_T)) begin // @[Conditional.scala 40:58]
      if (_T_10) begin // @[Conditional.scala 39:67]
        if (regBid > 8'h0) begin // @[AccountantExtPrice.scala 90:27]
          regAssignments_59_valid <= _GEN_260;
        end
      end else if (!(_T_20)) begin // @[Conditional.scala 39:67]
        regAssignments_59_valid <= _GEN_931;
      end
    end
    if (reset) begin // @[AccountantExtPrice.scala 53:31]
      regAssignments_60_agent <= 6'h0; // @[AccountantExtPrice.scala 53:31]
    end else if (!(_T)) begin // @[Conditional.scala 40:58]
      if (_T_10) begin // @[Conditional.scala 39:67]
        if (regBid > 8'h0) begin // @[AccountantExtPrice.scala 90:27]
          regAssignments_60_agent <= _GEN_197;
        end
      end else if (!(_T_20)) begin // @[Conditional.scala 39:67]
        regAssignments_60_agent <= _GEN_934;
      end
    end
    if (reset) begin // @[AccountantExtPrice.scala 53:31]
      regAssignments_60_valid <= 1'h0; // @[AccountantExtPrice.scala 53:31]
    end else if (!(_T)) begin // @[Conditional.scala 40:58]
      if (_T_10) begin // @[Conditional.scala 39:67]
        if (regBid > 8'h0) begin // @[AccountantExtPrice.scala 90:27]
          regAssignments_60_valid <= _GEN_261;
        end
      end else if (!(_T_20)) begin // @[Conditional.scala 39:67]
        regAssignments_60_valid <= _GEN_933;
      end
    end
    if (reset) begin // @[AccountantExtPrice.scala 53:31]
      regAssignments_61_agent <= 6'h0; // @[AccountantExtPrice.scala 53:31]
    end else if (!(_T)) begin // @[Conditional.scala 40:58]
      if (_T_10) begin // @[Conditional.scala 39:67]
        if (regBid > 8'h0) begin // @[AccountantExtPrice.scala 90:27]
          regAssignments_61_agent <= _GEN_198;
        end
      end else if (!(_T_20)) begin // @[Conditional.scala 39:67]
        regAssignments_61_agent <= _GEN_936;
      end
    end
    if (reset) begin // @[AccountantExtPrice.scala 53:31]
      regAssignments_61_valid <= 1'h0; // @[AccountantExtPrice.scala 53:31]
    end else if (!(_T)) begin // @[Conditional.scala 40:58]
      if (_T_10) begin // @[Conditional.scala 39:67]
        if (regBid > 8'h0) begin // @[AccountantExtPrice.scala 90:27]
          regAssignments_61_valid <= _GEN_262;
        end
      end else if (!(_T_20)) begin // @[Conditional.scala 39:67]
        regAssignments_61_valid <= _GEN_935;
      end
    end
    if (reset) begin // @[AccountantExtPrice.scala 53:31]
      regAssignments_62_agent <= 6'h0; // @[AccountantExtPrice.scala 53:31]
    end else if (!(_T)) begin // @[Conditional.scala 40:58]
      if (_T_10) begin // @[Conditional.scala 39:67]
        if (regBid > 8'h0) begin // @[AccountantExtPrice.scala 90:27]
          regAssignments_62_agent <= _GEN_199;
        end
      end else if (!(_T_20)) begin // @[Conditional.scala 39:67]
        regAssignments_62_agent <= _GEN_938;
      end
    end
    if (reset) begin // @[AccountantExtPrice.scala 53:31]
      regAssignments_62_valid <= 1'h0; // @[AccountantExtPrice.scala 53:31]
    end else if (!(_T)) begin // @[Conditional.scala 40:58]
      if (_T_10) begin // @[Conditional.scala 39:67]
        if (regBid > 8'h0) begin // @[AccountantExtPrice.scala 90:27]
          regAssignments_62_valid <= _GEN_263;
        end
      end else if (!(_T_20)) begin // @[Conditional.scala 39:67]
        regAssignments_62_valid <= _GEN_937;
      end
    end
    if (reset) begin // @[AccountantExtPrice.scala 53:31]
      regAssignments_63_agent <= 6'h0; // @[AccountantExtPrice.scala 53:31]
    end else if (!(_T)) begin // @[Conditional.scala 40:58]
      if (_T_10) begin // @[Conditional.scala 39:67]
        if (regBid > 8'h0) begin // @[AccountantExtPrice.scala 90:27]
          regAssignments_63_agent <= _GEN_200;
        end
      end else if (!(_T_20)) begin // @[Conditional.scala 39:67]
        regAssignments_63_agent <= _GEN_940;
      end
    end
    if (reset) begin // @[AccountantExtPrice.scala 53:31]
      regAssignments_63_valid <= 1'h0; // @[AccountantExtPrice.scala 53:31]
    end else if (!(_T)) begin // @[Conditional.scala 40:58]
      if (_T_10) begin // @[Conditional.scala 39:67]
        if (regBid > 8'h0) begin // @[AccountantExtPrice.scala 90:27]
          regAssignments_63_valid <= _GEN_264;
        end
      end else if (!(_T_20)) begin // @[Conditional.scala 39:67]
        regAssignments_63_valid <= _GEN_939;
      end
    end
    if (reset) begin // @[AccountantExtPrice.scala 54:32]
      regCurrentAgent <= 8'h0; // @[AccountantExtPrice.scala 54:32]
    end else if (_T) begin // @[Conditional.scala 40:58]
      if (_T_1) begin // @[AccountantExtPrice.scala 70:39]
        regCurrentAgent <= io_requestedAgents_bits_agent; // @[AccountantExtPrice.scala 75:25]
      end
    end
    if (reset) begin // @[AccountantExtPrice.scala 56:26]
      regObject <= 6'h0; // @[AccountantExtPrice.scala 56:26]
    end else if (_T) begin // @[Conditional.scala 40:58]
      if (_T_1) begin // @[AccountantExtPrice.scala 70:39]
        regObject <= io_searchResultIn_bits_winner; // @[AccountantExtPrice.scala 73:19]
      end
    end
    if (reset) begin // @[AccountantExtPrice.scala 57:23]
      regBid <= 8'h0; // @[AccountantExtPrice.scala 57:23]
    end else if (_T) begin // @[Conditional.scala 40:58]
      if (_T_1) begin // @[AccountantExtPrice.scala 70:39]
        regBid <= io_searchResultIn_bits_bid; // @[AccountantExtPrice.scala 74:16]
      end
    end
    if (reset) begin // @[AccountantExtPrice.scala 58:32]
      regCurrentPrice <= 8'h0; // @[AccountantExtPrice.scala 58:32]
    end else if (_T) begin // @[Conditional.scala 40:58]
      if (_T_1) begin // @[AccountantExtPrice.scala 70:39]
        regCurrentPrice <= io_priceStore_rsp_bits_rdata; // @[AccountantExtPrice.scala 78:25]
      end
    end
    if (reset) begin // @[AccountantExtPrice.scala 62:25]
      regState <= 3'h0; // @[AccountantExtPrice.scala 62:25]
    end else if (_T) begin // @[Conditional.scala 40:58]
      if (io_doWriteBack) begin // @[AccountantExtPrice.scala 83:28]
        regState <= 3'h2; // @[AccountantExtPrice.scala 84:18]
      end else if (_T_1) begin // @[AccountantExtPrice.scala 70:39]
        regState <= 3'h1; // @[AccountantExtPrice.scala 80:18]
      end
    end else if (_T_10) begin // @[Conditional.scala 39:67]
      if (regBid > 8'h0) begin // @[AccountantExtPrice.scala 90:27]
        regState <= _GEN_265;
      end else begin
        regState <= 3'h0; // @[AccountantExtPrice.scala 112:18]
      end
    end else if (_T_20) begin // @[Conditional.scala 39:67]
      regState <= _GEN_535;
    end else begin
      regState <= _GEN_808;
    end
    if (reset) begin // @[AccountantExtPrice.scala 64:27]
      regWBCount <= 64'h0; // @[AccountantExtPrice.scala 64:27]
    end else if (!(_T)) begin // @[Conditional.scala 40:58]
      if (!(_T_10)) begin // @[Conditional.scala 39:67]
        if (_T_20) begin // @[Conditional.scala 39:67]
          regWBCount <= _GEN_534;
        end else begin
          regWBCount <= _GEN_807;
        end
      end
    end
    `ifndef SYNTHESIS
    `ifdef PRINTF_COND
      if (`PRINTF_COND) begin
    `endif
        if (_GEN_1223 & ~(io_requestedAgents_valid | reset)) begin
          $fwrite(32'h80000002,
            "Assertion failed\n    at AccountantExtPrice.scala:72 assert(io.requestedAgents.valid === true.B)\n"); // @[AccountantExtPrice.scala 72:15]
        end
    `ifdef PRINTF_COND
      end
    `endif
    `endif // SYNTHESIS
    `ifndef SYNTHESIS
    `ifdef STOP_COND
      if (`STOP_COND) begin
    `endif
        if (_GEN_1223 & ~(io_requestedAgents_valid | reset)) begin
          $fatal; // @[AccountantExtPrice.scala 72:15]
        end
    `ifdef STOP_COND
      end
    `endif
    `endif // SYNTHESIS
    `ifndef SYNTHESIS
    `ifdef PRINTF_COND
      if (`PRINTF_COND) begin
    `endif
        if (_GEN_1223 & ~(io_priceStore_rsp_valid | reset)) begin
          $fwrite(32'h80000002,"Assertion failed\n    at RegStore.scala:63 assert(req.ready && rsp.valid)\n"); // @[RegStore.scala 63:10]
        end
    `ifdef PRINTF_COND
      end
    `endif
    `endif // SYNTHESIS
    `ifndef SYNTHESIS
    `ifdef STOP_COND
      if (`STOP_COND) begin
    `endif
        if (_GEN_1223 & ~(io_priceStore_rsp_valid | reset)) begin
          $fatal; // @[RegStore.scala 63:10]
        end
    `ifdef STOP_COND
      end
    `endif
    `endif // SYNTHESIS
    `ifndef SYNTHESIS
    `ifdef PRINTF_COND
      if (`PRINTF_COND) begin
    `endif
        if (~_T & ~_T_10 & ~_T_20 & _T_26 & ~_T_21 & ~(io_priceStore_rsp_valid | reset)) begin
          $fwrite(32'h80000002,"Assertion failed\n    at RegStore.scala:63 assert(req.ready && rsp.valid)\n"); // @[RegStore.scala 63:10]
        end
    `ifdef PRINTF_COND
      end
    `endif
    `endif // SYNTHESIS
    `ifndef SYNTHESIS
    `ifdef STOP_COND
      if (`STOP_COND) begin
    `endif
        if (~_T & ~_T_10 & ~_T_20 & _T_26 & ~_T_21 & ~(io_priceStore_rsp_valid | reset)) begin
          $fatal; // @[RegStore.scala 63:10]
        end
    `ifdef STOP_COND
      end
    `endif
    `endif // SYNTHESIS
  end
// Register and memory initialization
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
  regAssignments_0_agent = _RAND_0[5:0];
  _RAND_1 = {1{`RANDOM}};
  regAssignments_0_valid = _RAND_1[0:0];
  _RAND_2 = {1{`RANDOM}};
  regAssignments_1_agent = _RAND_2[5:0];
  _RAND_3 = {1{`RANDOM}};
  regAssignments_1_valid = _RAND_3[0:0];
  _RAND_4 = {1{`RANDOM}};
  regAssignments_2_agent = _RAND_4[5:0];
  _RAND_5 = {1{`RANDOM}};
  regAssignments_2_valid = _RAND_5[0:0];
  _RAND_6 = {1{`RANDOM}};
  regAssignments_3_agent = _RAND_6[5:0];
  _RAND_7 = {1{`RANDOM}};
  regAssignments_3_valid = _RAND_7[0:0];
  _RAND_8 = {1{`RANDOM}};
  regAssignments_4_agent = _RAND_8[5:0];
  _RAND_9 = {1{`RANDOM}};
  regAssignments_4_valid = _RAND_9[0:0];
  _RAND_10 = {1{`RANDOM}};
  regAssignments_5_agent = _RAND_10[5:0];
  _RAND_11 = {1{`RANDOM}};
  regAssignments_5_valid = _RAND_11[0:0];
  _RAND_12 = {1{`RANDOM}};
  regAssignments_6_agent = _RAND_12[5:0];
  _RAND_13 = {1{`RANDOM}};
  regAssignments_6_valid = _RAND_13[0:0];
  _RAND_14 = {1{`RANDOM}};
  regAssignments_7_agent = _RAND_14[5:0];
  _RAND_15 = {1{`RANDOM}};
  regAssignments_7_valid = _RAND_15[0:0];
  _RAND_16 = {1{`RANDOM}};
  regAssignments_8_agent = _RAND_16[5:0];
  _RAND_17 = {1{`RANDOM}};
  regAssignments_8_valid = _RAND_17[0:0];
  _RAND_18 = {1{`RANDOM}};
  regAssignments_9_agent = _RAND_18[5:0];
  _RAND_19 = {1{`RANDOM}};
  regAssignments_9_valid = _RAND_19[0:0];
  _RAND_20 = {1{`RANDOM}};
  regAssignments_10_agent = _RAND_20[5:0];
  _RAND_21 = {1{`RANDOM}};
  regAssignments_10_valid = _RAND_21[0:0];
  _RAND_22 = {1{`RANDOM}};
  regAssignments_11_agent = _RAND_22[5:0];
  _RAND_23 = {1{`RANDOM}};
  regAssignments_11_valid = _RAND_23[0:0];
  _RAND_24 = {1{`RANDOM}};
  regAssignments_12_agent = _RAND_24[5:0];
  _RAND_25 = {1{`RANDOM}};
  regAssignments_12_valid = _RAND_25[0:0];
  _RAND_26 = {1{`RANDOM}};
  regAssignments_13_agent = _RAND_26[5:0];
  _RAND_27 = {1{`RANDOM}};
  regAssignments_13_valid = _RAND_27[0:0];
  _RAND_28 = {1{`RANDOM}};
  regAssignments_14_agent = _RAND_28[5:0];
  _RAND_29 = {1{`RANDOM}};
  regAssignments_14_valid = _RAND_29[0:0];
  _RAND_30 = {1{`RANDOM}};
  regAssignments_15_agent = _RAND_30[5:0];
  _RAND_31 = {1{`RANDOM}};
  regAssignments_15_valid = _RAND_31[0:0];
  _RAND_32 = {1{`RANDOM}};
  regAssignments_16_agent = _RAND_32[5:0];
  _RAND_33 = {1{`RANDOM}};
  regAssignments_16_valid = _RAND_33[0:0];
  _RAND_34 = {1{`RANDOM}};
  regAssignments_17_agent = _RAND_34[5:0];
  _RAND_35 = {1{`RANDOM}};
  regAssignments_17_valid = _RAND_35[0:0];
  _RAND_36 = {1{`RANDOM}};
  regAssignments_18_agent = _RAND_36[5:0];
  _RAND_37 = {1{`RANDOM}};
  regAssignments_18_valid = _RAND_37[0:0];
  _RAND_38 = {1{`RANDOM}};
  regAssignments_19_agent = _RAND_38[5:0];
  _RAND_39 = {1{`RANDOM}};
  regAssignments_19_valid = _RAND_39[0:0];
  _RAND_40 = {1{`RANDOM}};
  regAssignments_20_agent = _RAND_40[5:0];
  _RAND_41 = {1{`RANDOM}};
  regAssignments_20_valid = _RAND_41[0:0];
  _RAND_42 = {1{`RANDOM}};
  regAssignments_21_agent = _RAND_42[5:0];
  _RAND_43 = {1{`RANDOM}};
  regAssignments_21_valid = _RAND_43[0:0];
  _RAND_44 = {1{`RANDOM}};
  regAssignments_22_agent = _RAND_44[5:0];
  _RAND_45 = {1{`RANDOM}};
  regAssignments_22_valid = _RAND_45[0:0];
  _RAND_46 = {1{`RANDOM}};
  regAssignments_23_agent = _RAND_46[5:0];
  _RAND_47 = {1{`RANDOM}};
  regAssignments_23_valid = _RAND_47[0:0];
  _RAND_48 = {1{`RANDOM}};
  regAssignments_24_agent = _RAND_48[5:0];
  _RAND_49 = {1{`RANDOM}};
  regAssignments_24_valid = _RAND_49[0:0];
  _RAND_50 = {1{`RANDOM}};
  regAssignments_25_agent = _RAND_50[5:0];
  _RAND_51 = {1{`RANDOM}};
  regAssignments_25_valid = _RAND_51[0:0];
  _RAND_52 = {1{`RANDOM}};
  regAssignments_26_agent = _RAND_52[5:0];
  _RAND_53 = {1{`RANDOM}};
  regAssignments_26_valid = _RAND_53[0:0];
  _RAND_54 = {1{`RANDOM}};
  regAssignments_27_agent = _RAND_54[5:0];
  _RAND_55 = {1{`RANDOM}};
  regAssignments_27_valid = _RAND_55[0:0];
  _RAND_56 = {1{`RANDOM}};
  regAssignments_28_agent = _RAND_56[5:0];
  _RAND_57 = {1{`RANDOM}};
  regAssignments_28_valid = _RAND_57[0:0];
  _RAND_58 = {1{`RANDOM}};
  regAssignments_29_agent = _RAND_58[5:0];
  _RAND_59 = {1{`RANDOM}};
  regAssignments_29_valid = _RAND_59[0:0];
  _RAND_60 = {1{`RANDOM}};
  regAssignments_30_agent = _RAND_60[5:0];
  _RAND_61 = {1{`RANDOM}};
  regAssignments_30_valid = _RAND_61[0:0];
  _RAND_62 = {1{`RANDOM}};
  regAssignments_31_agent = _RAND_62[5:0];
  _RAND_63 = {1{`RANDOM}};
  regAssignments_31_valid = _RAND_63[0:0];
  _RAND_64 = {1{`RANDOM}};
  regAssignments_32_agent = _RAND_64[5:0];
  _RAND_65 = {1{`RANDOM}};
  regAssignments_32_valid = _RAND_65[0:0];
  _RAND_66 = {1{`RANDOM}};
  regAssignments_33_agent = _RAND_66[5:0];
  _RAND_67 = {1{`RANDOM}};
  regAssignments_33_valid = _RAND_67[0:0];
  _RAND_68 = {1{`RANDOM}};
  regAssignments_34_agent = _RAND_68[5:0];
  _RAND_69 = {1{`RANDOM}};
  regAssignments_34_valid = _RAND_69[0:0];
  _RAND_70 = {1{`RANDOM}};
  regAssignments_35_agent = _RAND_70[5:0];
  _RAND_71 = {1{`RANDOM}};
  regAssignments_35_valid = _RAND_71[0:0];
  _RAND_72 = {1{`RANDOM}};
  regAssignments_36_agent = _RAND_72[5:0];
  _RAND_73 = {1{`RANDOM}};
  regAssignments_36_valid = _RAND_73[0:0];
  _RAND_74 = {1{`RANDOM}};
  regAssignments_37_agent = _RAND_74[5:0];
  _RAND_75 = {1{`RANDOM}};
  regAssignments_37_valid = _RAND_75[0:0];
  _RAND_76 = {1{`RANDOM}};
  regAssignments_38_agent = _RAND_76[5:0];
  _RAND_77 = {1{`RANDOM}};
  regAssignments_38_valid = _RAND_77[0:0];
  _RAND_78 = {1{`RANDOM}};
  regAssignments_39_agent = _RAND_78[5:0];
  _RAND_79 = {1{`RANDOM}};
  regAssignments_39_valid = _RAND_79[0:0];
  _RAND_80 = {1{`RANDOM}};
  regAssignments_40_agent = _RAND_80[5:0];
  _RAND_81 = {1{`RANDOM}};
  regAssignments_40_valid = _RAND_81[0:0];
  _RAND_82 = {1{`RANDOM}};
  regAssignments_41_agent = _RAND_82[5:0];
  _RAND_83 = {1{`RANDOM}};
  regAssignments_41_valid = _RAND_83[0:0];
  _RAND_84 = {1{`RANDOM}};
  regAssignments_42_agent = _RAND_84[5:0];
  _RAND_85 = {1{`RANDOM}};
  regAssignments_42_valid = _RAND_85[0:0];
  _RAND_86 = {1{`RANDOM}};
  regAssignments_43_agent = _RAND_86[5:0];
  _RAND_87 = {1{`RANDOM}};
  regAssignments_43_valid = _RAND_87[0:0];
  _RAND_88 = {1{`RANDOM}};
  regAssignments_44_agent = _RAND_88[5:0];
  _RAND_89 = {1{`RANDOM}};
  regAssignments_44_valid = _RAND_89[0:0];
  _RAND_90 = {1{`RANDOM}};
  regAssignments_45_agent = _RAND_90[5:0];
  _RAND_91 = {1{`RANDOM}};
  regAssignments_45_valid = _RAND_91[0:0];
  _RAND_92 = {1{`RANDOM}};
  regAssignments_46_agent = _RAND_92[5:0];
  _RAND_93 = {1{`RANDOM}};
  regAssignments_46_valid = _RAND_93[0:0];
  _RAND_94 = {1{`RANDOM}};
  regAssignments_47_agent = _RAND_94[5:0];
  _RAND_95 = {1{`RANDOM}};
  regAssignments_47_valid = _RAND_95[0:0];
  _RAND_96 = {1{`RANDOM}};
  regAssignments_48_agent = _RAND_96[5:0];
  _RAND_97 = {1{`RANDOM}};
  regAssignments_48_valid = _RAND_97[0:0];
  _RAND_98 = {1{`RANDOM}};
  regAssignments_49_agent = _RAND_98[5:0];
  _RAND_99 = {1{`RANDOM}};
  regAssignments_49_valid = _RAND_99[0:0];
  _RAND_100 = {1{`RANDOM}};
  regAssignments_50_agent = _RAND_100[5:0];
  _RAND_101 = {1{`RANDOM}};
  regAssignments_50_valid = _RAND_101[0:0];
  _RAND_102 = {1{`RANDOM}};
  regAssignments_51_agent = _RAND_102[5:0];
  _RAND_103 = {1{`RANDOM}};
  regAssignments_51_valid = _RAND_103[0:0];
  _RAND_104 = {1{`RANDOM}};
  regAssignments_52_agent = _RAND_104[5:0];
  _RAND_105 = {1{`RANDOM}};
  regAssignments_52_valid = _RAND_105[0:0];
  _RAND_106 = {1{`RANDOM}};
  regAssignments_53_agent = _RAND_106[5:0];
  _RAND_107 = {1{`RANDOM}};
  regAssignments_53_valid = _RAND_107[0:0];
  _RAND_108 = {1{`RANDOM}};
  regAssignments_54_agent = _RAND_108[5:0];
  _RAND_109 = {1{`RANDOM}};
  regAssignments_54_valid = _RAND_109[0:0];
  _RAND_110 = {1{`RANDOM}};
  regAssignments_55_agent = _RAND_110[5:0];
  _RAND_111 = {1{`RANDOM}};
  regAssignments_55_valid = _RAND_111[0:0];
  _RAND_112 = {1{`RANDOM}};
  regAssignments_56_agent = _RAND_112[5:0];
  _RAND_113 = {1{`RANDOM}};
  regAssignments_56_valid = _RAND_113[0:0];
  _RAND_114 = {1{`RANDOM}};
  regAssignments_57_agent = _RAND_114[5:0];
  _RAND_115 = {1{`RANDOM}};
  regAssignments_57_valid = _RAND_115[0:0];
  _RAND_116 = {1{`RANDOM}};
  regAssignments_58_agent = _RAND_116[5:0];
  _RAND_117 = {1{`RANDOM}};
  regAssignments_58_valid = _RAND_117[0:0];
  _RAND_118 = {1{`RANDOM}};
  regAssignments_59_agent = _RAND_118[5:0];
  _RAND_119 = {1{`RANDOM}};
  regAssignments_59_valid = _RAND_119[0:0];
  _RAND_120 = {1{`RANDOM}};
  regAssignments_60_agent = _RAND_120[5:0];
  _RAND_121 = {1{`RANDOM}};
  regAssignments_60_valid = _RAND_121[0:0];
  _RAND_122 = {1{`RANDOM}};
  regAssignments_61_agent = _RAND_122[5:0];
  _RAND_123 = {1{`RANDOM}};
  regAssignments_61_valid = _RAND_123[0:0];
  _RAND_124 = {1{`RANDOM}};
  regAssignments_62_agent = _RAND_124[5:0];
  _RAND_125 = {1{`RANDOM}};
  regAssignments_62_valid = _RAND_125[0:0];
  _RAND_126 = {1{`RANDOM}};
  regAssignments_63_agent = _RAND_126[5:0];
  _RAND_127 = {1{`RANDOM}};
  regAssignments_63_valid = _RAND_127[0:0];
  _RAND_128 = {1{`RANDOM}};
  regCurrentAgent = _RAND_128[7:0];
  _RAND_129 = {1{`RANDOM}};
  regObject = _RAND_129[5:0];
  _RAND_130 = {1{`RANDOM}};
  regBid = _RAND_130[7:0];
  _RAND_131 = {1{`RANDOM}};
  regCurrentPrice = _RAND_131[7:0];
  _RAND_132 = {1{`RANDOM}};
  regState = _RAND_132[2:0];
  _RAND_133 = {2{`RANDOM}};
  regWBCount = _RAND_133[63:0];
`endif // RANDOMIZE_REG_INIT
  `endif // RANDOMIZE
end // initial
`ifdef FIRRTL_AFTER_INITIAL
`FIRRTL_AFTER_INITIAL
`endif
`endif // SYNTHESIS
endmodule
module Queue_1(
  input        clock,
  input        reset,
  output       io_enq_ready,
  input        io_enq_valid,
  input  [7:0] io_enq_bits_els_0_reward,
  input  [5:0] io_enq_bits_els_0_idx,
  input  [7:0] io_enq_bits_els_1_reward,
  input  [5:0] io_enq_bits_els_1_idx,
  input  [7:0] io_enq_bits_els_2_reward,
  input  [5:0] io_enq_bits_els_2_idx,
  input  [7:0] io_enq_bits_els_3_reward,
  input  [5:0] io_enq_bits_els_3_idx,
  input  [7:0] io_enq_bits_els_4_reward,
  input  [5:0] io_enq_bits_els_4_idx,
  input  [7:0] io_enq_bits_els_5_reward,
  input  [5:0] io_enq_bits_els_5_idx,
  input  [7:0] io_enq_bits_els_6_reward,
  input  [5:0] io_enq_bits_els_6_idx,
  input  [7:0] io_enq_bits_els_7_reward,
  input  [5:0] io_enq_bits_els_7_idx,
  input        io_enq_bits_last,
  input        io_deq_ready,
  output       io_deq_valid,
  output [7:0] io_deq_bits_els_0_reward,
  output [5:0] io_deq_bits_els_0_idx,
  output [7:0] io_deq_bits_els_1_reward,
  output [5:0] io_deq_bits_els_1_idx,
  output [7:0] io_deq_bits_els_2_reward,
  output [5:0] io_deq_bits_els_2_idx,
  output [7:0] io_deq_bits_els_3_reward,
  output [5:0] io_deq_bits_els_3_idx,
  output [7:0] io_deq_bits_els_4_reward,
  output [5:0] io_deq_bits_els_4_idx,
  output [7:0] io_deq_bits_els_5_reward,
  output [5:0] io_deq_bits_els_5_idx,
  output [7:0] io_deq_bits_els_6_reward,
  output [5:0] io_deq_bits_els_6_idx,
  output [7:0] io_deq_bits_els_7_reward,
  output [5:0] io_deq_bits_els_7_idx,
  output       io_deq_bits_last
);
`ifdef RANDOMIZE_MEM_INIT
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
  reg [31:0] _RAND_13;
  reg [31:0] _RAND_14;
  reg [31:0] _RAND_15;
  reg [31:0] _RAND_16;
`endif // RANDOMIZE_MEM_INIT
`ifdef RANDOMIZE_REG_INIT
  reg [31:0] _RAND_17;
  reg [31:0] _RAND_18;
  reg [31:0] _RAND_19;
`endif // RANDOMIZE_REG_INIT
  reg [7:0] ram_els_0_reward [0:7]; // @[Decoupled.scala 218:16]
  wire [7:0] ram_els_0_reward_io_deq_bits_MPORT_data; // @[Decoupled.scala 218:16]
  wire [2:0] ram_els_0_reward_io_deq_bits_MPORT_addr; // @[Decoupled.scala 218:16]
  wire [7:0] ram_els_0_reward_MPORT_data; // @[Decoupled.scala 218:16]
  wire [2:0] ram_els_0_reward_MPORT_addr; // @[Decoupled.scala 218:16]
  wire  ram_els_0_reward_MPORT_mask; // @[Decoupled.scala 218:16]
  wire  ram_els_0_reward_MPORT_en; // @[Decoupled.scala 218:16]
  reg [5:0] ram_els_0_idx [0:7]; // @[Decoupled.scala 218:16]
  wire [5:0] ram_els_0_idx_io_deq_bits_MPORT_data; // @[Decoupled.scala 218:16]
  wire [2:0] ram_els_0_idx_io_deq_bits_MPORT_addr; // @[Decoupled.scala 218:16]
  wire [5:0] ram_els_0_idx_MPORT_data; // @[Decoupled.scala 218:16]
  wire [2:0] ram_els_0_idx_MPORT_addr; // @[Decoupled.scala 218:16]
  wire  ram_els_0_idx_MPORT_mask; // @[Decoupled.scala 218:16]
  wire  ram_els_0_idx_MPORT_en; // @[Decoupled.scala 218:16]
  reg [7:0] ram_els_1_reward [0:7]; // @[Decoupled.scala 218:16]
  wire [7:0] ram_els_1_reward_io_deq_bits_MPORT_data; // @[Decoupled.scala 218:16]
  wire [2:0] ram_els_1_reward_io_deq_bits_MPORT_addr; // @[Decoupled.scala 218:16]
  wire [7:0] ram_els_1_reward_MPORT_data; // @[Decoupled.scala 218:16]
  wire [2:0] ram_els_1_reward_MPORT_addr; // @[Decoupled.scala 218:16]
  wire  ram_els_1_reward_MPORT_mask; // @[Decoupled.scala 218:16]
  wire  ram_els_1_reward_MPORT_en; // @[Decoupled.scala 218:16]
  reg [5:0] ram_els_1_idx [0:7]; // @[Decoupled.scala 218:16]
  wire [5:0] ram_els_1_idx_io_deq_bits_MPORT_data; // @[Decoupled.scala 218:16]
  wire [2:0] ram_els_1_idx_io_deq_bits_MPORT_addr; // @[Decoupled.scala 218:16]
  wire [5:0] ram_els_1_idx_MPORT_data; // @[Decoupled.scala 218:16]
  wire [2:0] ram_els_1_idx_MPORT_addr; // @[Decoupled.scala 218:16]
  wire  ram_els_1_idx_MPORT_mask; // @[Decoupled.scala 218:16]
  wire  ram_els_1_idx_MPORT_en; // @[Decoupled.scala 218:16]
  reg [7:0] ram_els_2_reward [0:7]; // @[Decoupled.scala 218:16]
  wire [7:0] ram_els_2_reward_io_deq_bits_MPORT_data; // @[Decoupled.scala 218:16]
  wire [2:0] ram_els_2_reward_io_deq_bits_MPORT_addr; // @[Decoupled.scala 218:16]
  wire [7:0] ram_els_2_reward_MPORT_data; // @[Decoupled.scala 218:16]
  wire [2:0] ram_els_2_reward_MPORT_addr; // @[Decoupled.scala 218:16]
  wire  ram_els_2_reward_MPORT_mask; // @[Decoupled.scala 218:16]
  wire  ram_els_2_reward_MPORT_en; // @[Decoupled.scala 218:16]
  reg [5:0] ram_els_2_idx [0:7]; // @[Decoupled.scala 218:16]
  wire [5:0] ram_els_2_idx_io_deq_bits_MPORT_data; // @[Decoupled.scala 218:16]
  wire [2:0] ram_els_2_idx_io_deq_bits_MPORT_addr; // @[Decoupled.scala 218:16]
  wire [5:0] ram_els_2_idx_MPORT_data; // @[Decoupled.scala 218:16]
  wire [2:0] ram_els_2_idx_MPORT_addr; // @[Decoupled.scala 218:16]
  wire  ram_els_2_idx_MPORT_mask; // @[Decoupled.scala 218:16]
  wire  ram_els_2_idx_MPORT_en; // @[Decoupled.scala 218:16]
  reg [7:0] ram_els_3_reward [0:7]; // @[Decoupled.scala 218:16]
  wire [7:0] ram_els_3_reward_io_deq_bits_MPORT_data; // @[Decoupled.scala 218:16]
  wire [2:0] ram_els_3_reward_io_deq_bits_MPORT_addr; // @[Decoupled.scala 218:16]
  wire [7:0] ram_els_3_reward_MPORT_data; // @[Decoupled.scala 218:16]
  wire [2:0] ram_els_3_reward_MPORT_addr; // @[Decoupled.scala 218:16]
  wire  ram_els_3_reward_MPORT_mask; // @[Decoupled.scala 218:16]
  wire  ram_els_3_reward_MPORT_en; // @[Decoupled.scala 218:16]
  reg [5:0] ram_els_3_idx [0:7]; // @[Decoupled.scala 218:16]
  wire [5:0] ram_els_3_idx_io_deq_bits_MPORT_data; // @[Decoupled.scala 218:16]
  wire [2:0] ram_els_3_idx_io_deq_bits_MPORT_addr; // @[Decoupled.scala 218:16]
  wire [5:0] ram_els_3_idx_MPORT_data; // @[Decoupled.scala 218:16]
  wire [2:0] ram_els_3_idx_MPORT_addr; // @[Decoupled.scala 218:16]
  wire  ram_els_3_idx_MPORT_mask; // @[Decoupled.scala 218:16]
  wire  ram_els_3_idx_MPORT_en; // @[Decoupled.scala 218:16]
  reg [7:0] ram_els_4_reward [0:7]; // @[Decoupled.scala 218:16]
  wire [7:0] ram_els_4_reward_io_deq_bits_MPORT_data; // @[Decoupled.scala 218:16]
  wire [2:0] ram_els_4_reward_io_deq_bits_MPORT_addr; // @[Decoupled.scala 218:16]
  wire [7:0] ram_els_4_reward_MPORT_data; // @[Decoupled.scala 218:16]
  wire [2:0] ram_els_4_reward_MPORT_addr; // @[Decoupled.scala 218:16]
  wire  ram_els_4_reward_MPORT_mask; // @[Decoupled.scala 218:16]
  wire  ram_els_4_reward_MPORT_en; // @[Decoupled.scala 218:16]
  reg [5:0] ram_els_4_idx [0:7]; // @[Decoupled.scala 218:16]
  wire [5:0] ram_els_4_idx_io_deq_bits_MPORT_data; // @[Decoupled.scala 218:16]
  wire [2:0] ram_els_4_idx_io_deq_bits_MPORT_addr; // @[Decoupled.scala 218:16]
  wire [5:0] ram_els_4_idx_MPORT_data; // @[Decoupled.scala 218:16]
  wire [2:0] ram_els_4_idx_MPORT_addr; // @[Decoupled.scala 218:16]
  wire  ram_els_4_idx_MPORT_mask; // @[Decoupled.scala 218:16]
  wire  ram_els_4_idx_MPORT_en; // @[Decoupled.scala 218:16]
  reg [7:0] ram_els_5_reward [0:7]; // @[Decoupled.scala 218:16]
  wire [7:0] ram_els_5_reward_io_deq_bits_MPORT_data; // @[Decoupled.scala 218:16]
  wire [2:0] ram_els_5_reward_io_deq_bits_MPORT_addr; // @[Decoupled.scala 218:16]
  wire [7:0] ram_els_5_reward_MPORT_data; // @[Decoupled.scala 218:16]
  wire [2:0] ram_els_5_reward_MPORT_addr; // @[Decoupled.scala 218:16]
  wire  ram_els_5_reward_MPORT_mask; // @[Decoupled.scala 218:16]
  wire  ram_els_5_reward_MPORT_en; // @[Decoupled.scala 218:16]
  reg [5:0] ram_els_5_idx [0:7]; // @[Decoupled.scala 218:16]
  wire [5:0] ram_els_5_idx_io_deq_bits_MPORT_data; // @[Decoupled.scala 218:16]
  wire [2:0] ram_els_5_idx_io_deq_bits_MPORT_addr; // @[Decoupled.scala 218:16]
  wire [5:0] ram_els_5_idx_MPORT_data; // @[Decoupled.scala 218:16]
  wire [2:0] ram_els_5_idx_MPORT_addr; // @[Decoupled.scala 218:16]
  wire  ram_els_5_idx_MPORT_mask; // @[Decoupled.scala 218:16]
  wire  ram_els_5_idx_MPORT_en; // @[Decoupled.scala 218:16]
  reg [7:0] ram_els_6_reward [0:7]; // @[Decoupled.scala 218:16]
  wire [7:0] ram_els_6_reward_io_deq_bits_MPORT_data; // @[Decoupled.scala 218:16]
  wire [2:0] ram_els_6_reward_io_deq_bits_MPORT_addr; // @[Decoupled.scala 218:16]
  wire [7:0] ram_els_6_reward_MPORT_data; // @[Decoupled.scala 218:16]
  wire [2:0] ram_els_6_reward_MPORT_addr; // @[Decoupled.scala 218:16]
  wire  ram_els_6_reward_MPORT_mask; // @[Decoupled.scala 218:16]
  wire  ram_els_6_reward_MPORT_en; // @[Decoupled.scala 218:16]
  reg [5:0] ram_els_6_idx [0:7]; // @[Decoupled.scala 218:16]
  wire [5:0] ram_els_6_idx_io_deq_bits_MPORT_data; // @[Decoupled.scala 218:16]
  wire [2:0] ram_els_6_idx_io_deq_bits_MPORT_addr; // @[Decoupled.scala 218:16]
  wire [5:0] ram_els_6_idx_MPORT_data; // @[Decoupled.scala 218:16]
  wire [2:0] ram_els_6_idx_MPORT_addr; // @[Decoupled.scala 218:16]
  wire  ram_els_6_idx_MPORT_mask; // @[Decoupled.scala 218:16]
  wire  ram_els_6_idx_MPORT_en; // @[Decoupled.scala 218:16]
  reg [7:0] ram_els_7_reward [0:7]; // @[Decoupled.scala 218:16]
  wire [7:0] ram_els_7_reward_io_deq_bits_MPORT_data; // @[Decoupled.scala 218:16]
  wire [2:0] ram_els_7_reward_io_deq_bits_MPORT_addr; // @[Decoupled.scala 218:16]
  wire [7:0] ram_els_7_reward_MPORT_data; // @[Decoupled.scala 218:16]
  wire [2:0] ram_els_7_reward_MPORT_addr; // @[Decoupled.scala 218:16]
  wire  ram_els_7_reward_MPORT_mask; // @[Decoupled.scala 218:16]
  wire  ram_els_7_reward_MPORT_en; // @[Decoupled.scala 218:16]
  reg [5:0] ram_els_7_idx [0:7]; // @[Decoupled.scala 218:16]
  wire [5:0] ram_els_7_idx_io_deq_bits_MPORT_data; // @[Decoupled.scala 218:16]
  wire [2:0] ram_els_7_idx_io_deq_bits_MPORT_addr; // @[Decoupled.scala 218:16]
  wire [5:0] ram_els_7_idx_MPORT_data; // @[Decoupled.scala 218:16]
  wire [2:0] ram_els_7_idx_MPORT_addr; // @[Decoupled.scala 218:16]
  wire  ram_els_7_idx_MPORT_mask; // @[Decoupled.scala 218:16]
  wire  ram_els_7_idx_MPORT_en; // @[Decoupled.scala 218:16]
  reg  ram_last [0:7]; // @[Decoupled.scala 218:16]
  wire  ram_last_io_deq_bits_MPORT_data; // @[Decoupled.scala 218:16]
  wire [2:0] ram_last_io_deq_bits_MPORT_addr; // @[Decoupled.scala 218:16]
  wire  ram_last_MPORT_data; // @[Decoupled.scala 218:16]
  wire [2:0] ram_last_MPORT_addr; // @[Decoupled.scala 218:16]
  wire  ram_last_MPORT_mask; // @[Decoupled.scala 218:16]
  wire  ram_last_MPORT_en; // @[Decoupled.scala 218:16]
  reg [2:0] enq_ptr_value; // @[Counter.scala 60:40]
  reg [2:0] deq_ptr_value; // @[Counter.scala 60:40]
  reg  maybe_full; // @[Decoupled.scala 221:27]
  wire  ptr_match = enq_ptr_value == deq_ptr_value; // @[Decoupled.scala 223:33]
  wire  empty = ptr_match & ~maybe_full; // @[Decoupled.scala 224:25]
  wire  full = ptr_match & maybe_full; // @[Decoupled.scala 225:24]
  wire  do_enq = io_enq_ready & io_enq_valid; // @[Decoupled.scala 40:37]
  wire  do_deq = io_deq_ready & io_deq_valid; // @[Decoupled.scala 40:37]
  wire [2:0] _value_T_1 = enq_ptr_value + 3'h1; // @[Counter.scala 76:24]
  wire [2:0] _value_T_3 = deq_ptr_value + 3'h1; // @[Counter.scala 76:24]
  assign ram_els_0_reward_io_deq_bits_MPORT_addr = deq_ptr_value;
  assign ram_els_0_reward_io_deq_bits_MPORT_data = ram_els_0_reward[ram_els_0_reward_io_deq_bits_MPORT_addr]; // @[Decoupled.scala 218:16]
  assign ram_els_0_reward_MPORT_data = io_enq_bits_els_0_reward;
  assign ram_els_0_reward_MPORT_addr = enq_ptr_value;
  assign ram_els_0_reward_MPORT_mask = 1'h1;
  assign ram_els_0_reward_MPORT_en = io_enq_ready & io_enq_valid;
  assign ram_els_0_idx_io_deq_bits_MPORT_addr = deq_ptr_value;
  assign ram_els_0_idx_io_deq_bits_MPORT_data = ram_els_0_idx[ram_els_0_idx_io_deq_bits_MPORT_addr]; // @[Decoupled.scala 218:16]
  assign ram_els_0_idx_MPORT_data = io_enq_bits_els_0_idx;
  assign ram_els_0_idx_MPORT_addr = enq_ptr_value;
  assign ram_els_0_idx_MPORT_mask = 1'h1;
  assign ram_els_0_idx_MPORT_en = io_enq_ready & io_enq_valid;
  assign ram_els_1_reward_io_deq_bits_MPORT_addr = deq_ptr_value;
  assign ram_els_1_reward_io_deq_bits_MPORT_data = ram_els_1_reward[ram_els_1_reward_io_deq_bits_MPORT_addr]; // @[Decoupled.scala 218:16]
  assign ram_els_1_reward_MPORT_data = io_enq_bits_els_1_reward;
  assign ram_els_1_reward_MPORT_addr = enq_ptr_value;
  assign ram_els_1_reward_MPORT_mask = 1'h1;
  assign ram_els_1_reward_MPORT_en = io_enq_ready & io_enq_valid;
  assign ram_els_1_idx_io_deq_bits_MPORT_addr = deq_ptr_value;
  assign ram_els_1_idx_io_deq_bits_MPORT_data = ram_els_1_idx[ram_els_1_idx_io_deq_bits_MPORT_addr]; // @[Decoupled.scala 218:16]
  assign ram_els_1_idx_MPORT_data = io_enq_bits_els_1_idx;
  assign ram_els_1_idx_MPORT_addr = enq_ptr_value;
  assign ram_els_1_idx_MPORT_mask = 1'h1;
  assign ram_els_1_idx_MPORT_en = io_enq_ready & io_enq_valid;
  assign ram_els_2_reward_io_deq_bits_MPORT_addr = deq_ptr_value;
  assign ram_els_2_reward_io_deq_bits_MPORT_data = ram_els_2_reward[ram_els_2_reward_io_deq_bits_MPORT_addr]; // @[Decoupled.scala 218:16]
  assign ram_els_2_reward_MPORT_data = io_enq_bits_els_2_reward;
  assign ram_els_2_reward_MPORT_addr = enq_ptr_value;
  assign ram_els_2_reward_MPORT_mask = 1'h1;
  assign ram_els_2_reward_MPORT_en = io_enq_ready & io_enq_valid;
  assign ram_els_2_idx_io_deq_bits_MPORT_addr = deq_ptr_value;
  assign ram_els_2_idx_io_deq_bits_MPORT_data = ram_els_2_idx[ram_els_2_idx_io_deq_bits_MPORT_addr]; // @[Decoupled.scala 218:16]
  assign ram_els_2_idx_MPORT_data = io_enq_bits_els_2_idx;
  assign ram_els_2_idx_MPORT_addr = enq_ptr_value;
  assign ram_els_2_idx_MPORT_mask = 1'h1;
  assign ram_els_2_idx_MPORT_en = io_enq_ready & io_enq_valid;
  assign ram_els_3_reward_io_deq_bits_MPORT_addr = deq_ptr_value;
  assign ram_els_3_reward_io_deq_bits_MPORT_data = ram_els_3_reward[ram_els_3_reward_io_deq_bits_MPORT_addr]; // @[Decoupled.scala 218:16]
  assign ram_els_3_reward_MPORT_data = io_enq_bits_els_3_reward;
  assign ram_els_3_reward_MPORT_addr = enq_ptr_value;
  assign ram_els_3_reward_MPORT_mask = 1'h1;
  assign ram_els_3_reward_MPORT_en = io_enq_ready & io_enq_valid;
  assign ram_els_3_idx_io_deq_bits_MPORT_addr = deq_ptr_value;
  assign ram_els_3_idx_io_deq_bits_MPORT_data = ram_els_3_idx[ram_els_3_idx_io_deq_bits_MPORT_addr]; // @[Decoupled.scala 218:16]
  assign ram_els_3_idx_MPORT_data = io_enq_bits_els_3_idx;
  assign ram_els_3_idx_MPORT_addr = enq_ptr_value;
  assign ram_els_3_idx_MPORT_mask = 1'h1;
  assign ram_els_3_idx_MPORT_en = io_enq_ready & io_enq_valid;
  assign ram_els_4_reward_io_deq_bits_MPORT_addr = deq_ptr_value;
  assign ram_els_4_reward_io_deq_bits_MPORT_data = ram_els_4_reward[ram_els_4_reward_io_deq_bits_MPORT_addr]; // @[Decoupled.scala 218:16]
  assign ram_els_4_reward_MPORT_data = io_enq_bits_els_4_reward;
  assign ram_els_4_reward_MPORT_addr = enq_ptr_value;
  assign ram_els_4_reward_MPORT_mask = 1'h1;
  assign ram_els_4_reward_MPORT_en = io_enq_ready & io_enq_valid;
  assign ram_els_4_idx_io_deq_bits_MPORT_addr = deq_ptr_value;
  assign ram_els_4_idx_io_deq_bits_MPORT_data = ram_els_4_idx[ram_els_4_idx_io_deq_bits_MPORT_addr]; // @[Decoupled.scala 218:16]
  assign ram_els_4_idx_MPORT_data = io_enq_bits_els_4_idx;
  assign ram_els_4_idx_MPORT_addr = enq_ptr_value;
  assign ram_els_4_idx_MPORT_mask = 1'h1;
  assign ram_els_4_idx_MPORT_en = io_enq_ready & io_enq_valid;
  assign ram_els_5_reward_io_deq_bits_MPORT_addr = deq_ptr_value;
  assign ram_els_5_reward_io_deq_bits_MPORT_data = ram_els_5_reward[ram_els_5_reward_io_deq_bits_MPORT_addr]; // @[Decoupled.scala 218:16]
  assign ram_els_5_reward_MPORT_data = io_enq_bits_els_5_reward;
  assign ram_els_5_reward_MPORT_addr = enq_ptr_value;
  assign ram_els_5_reward_MPORT_mask = 1'h1;
  assign ram_els_5_reward_MPORT_en = io_enq_ready & io_enq_valid;
  assign ram_els_5_idx_io_deq_bits_MPORT_addr = deq_ptr_value;
  assign ram_els_5_idx_io_deq_bits_MPORT_data = ram_els_5_idx[ram_els_5_idx_io_deq_bits_MPORT_addr]; // @[Decoupled.scala 218:16]
  assign ram_els_5_idx_MPORT_data = io_enq_bits_els_5_idx;
  assign ram_els_5_idx_MPORT_addr = enq_ptr_value;
  assign ram_els_5_idx_MPORT_mask = 1'h1;
  assign ram_els_5_idx_MPORT_en = io_enq_ready & io_enq_valid;
  assign ram_els_6_reward_io_deq_bits_MPORT_addr = deq_ptr_value;
  assign ram_els_6_reward_io_deq_bits_MPORT_data = ram_els_6_reward[ram_els_6_reward_io_deq_bits_MPORT_addr]; // @[Decoupled.scala 218:16]
  assign ram_els_6_reward_MPORT_data = io_enq_bits_els_6_reward;
  assign ram_els_6_reward_MPORT_addr = enq_ptr_value;
  assign ram_els_6_reward_MPORT_mask = 1'h1;
  assign ram_els_6_reward_MPORT_en = io_enq_ready & io_enq_valid;
  assign ram_els_6_idx_io_deq_bits_MPORT_addr = deq_ptr_value;
  assign ram_els_6_idx_io_deq_bits_MPORT_data = ram_els_6_idx[ram_els_6_idx_io_deq_bits_MPORT_addr]; // @[Decoupled.scala 218:16]
  assign ram_els_6_idx_MPORT_data = io_enq_bits_els_6_idx;
  assign ram_els_6_idx_MPORT_addr = enq_ptr_value;
  assign ram_els_6_idx_MPORT_mask = 1'h1;
  assign ram_els_6_idx_MPORT_en = io_enq_ready & io_enq_valid;
  assign ram_els_7_reward_io_deq_bits_MPORT_addr = deq_ptr_value;
  assign ram_els_7_reward_io_deq_bits_MPORT_data = ram_els_7_reward[ram_els_7_reward_io_deq_bits_MPORT_addr]; // @[Decoupled.scala 218:16]
  assign ram_els_7_reward_MPORT_data = io_enq_bits_els_7_reward;
  assign ram_els_7_reward_MPORT_addr = enq_ptr_value;
  assign ram_els_7_reward_MPORT_mask = 1'h1;
  assign ram_els_7_reward_MPORT_en = io_enq_ready & io_enq_valid;
  assign ram_els_7_idx_io_deq_bits_MPORT_addr = deq_ptr_value;
  assign ram_els_7_idx_io_deq_bits_MPORT_data = ram_els_7_idx[ram_els_7_idx_io_deq_bits_MPORT_addr]; // @[Decoupled.scala 218:16]
  assign ram_els_7_idx_MPORT_data = io_enq_bits_els_7_idx;
  assign ram_els_7_idx_MPORT_addr = enq_ptr_value;
  assign ram_els_7_idx_MPORT_mask = 1'h1;
  assign ram_els_7_idx_MPORT_en = io_enq_ready & io_enq_valid;
  assign ram_last_io_deq_bits_MPORT_addr = deq_ptr_value;
  assign ram_last_io_deq_bits_MPORT_data = ram_last[ram_last_io_deq_bits_MPORT_addr]; // @[Decoupled.scala 218:16]
  assign ram_last_MPORT_data = io_enq_bits_last;
  assign ram_last_MPORT_addr = enq_ptr_value;
  assign ram_last_MPORT_mask = 1'h1;
  assign ram_last_MPORT_en = io_enq_ready & io_enq_valid;
  assign io_enq_ready = ~full; // @[Decoupled.scala 241:19]
  assign io_deq_valid = ~empty; // @[Decoupled.scala 240:19]
  assign io_deq_bits_els_0_reward = ram_els_0_reward_io_deq_bits_MPORT_data; // @[Decoupled.scala 242:15]
  assign io_deq_bits_els_0_idx = ram_els_0_idx_io_deq_bits_MPORT_data; // @[Decoupled.scala 242:15]
  assign io_deq_bits_els_1_reward = ram_els_1_reward_io_deq_bits_MPORT_data; // @[Decoupled.scala 242:15]
  assign io_deq_bits_els_1_idx = ram_els_1_idx_io_deq_bits_MPORT_data; // @[Decoupled.scala 242:15]
  assign io_deq_bits_els_2_reward = ram_els_2_reward_io_deq_bits_MPORT_data; // @[Decoupled.scala 242:15]
  assign io_deq_bits_els_2_idx = ram_els_2_idx_io_deq_bits_MPORT_data; // @[Decoupled.scala 242:15]
  assign io_deq_bits_els_3_reward = ram_els_3_reward_io_deq_bits_MPORT_data; // @[Decoupled.scala 242:15]
  assign io_deq_bits_els_3_idx = ram_els_3_idx_io_deq_bits_MPORT_data; // @[Decoupled.scala 242:15]
  assign io_deq_bits_els_4_reward = ram_els_4_reward_io_deq_bits_MPORT_data; // @[Decoupled.scala 242:15]
  assign io_deq_bits_els_4_idx = ram_els_4_idx_io_deq_bits_MPORT_data; // @[Decoupled.scala 242:15]
  assign io_deq_bits_els_5_reward = ram_els_5_reward_io_deq_bits_MPORT_data; // @[Decoupled.scala 242:15]
  assign io_deq_bits_els_5_idx = ram_els_5_idx_io_deq_bits_MPORT_data; // @[Decoupled.scala 242:15]
  assign io_deq_bits_els_6_reward = ram_els_6_reward_io_deq_bits_MPORT_data; // @[Decoupled.scala 242:15]
  assign io_deq_bits_els_6_idx = ram_els_6_idx_io_deq_bits_MPORT_data; // @[Decoupled.scala 242:15]
  assign io_deq_bits_els_7_reward = ram_els_7_reward_io_deq_bits_MPORT_data; // @[Decoupled.scala 242:15]
  assign io_deq_bits_els_7_idx = ram_els_7_idx_io_deq_bits_MPORT_data; // @[Decoupled.scala 242:15]
  assign io_deq_bits_last = ram_last_io_deq_bits_MPORT_data; // @[Decoupled.scala 242:15]
  always @(posedge clock) begin
    if(ram_els_0_reward_MPORT_en & ram_els_0_reward_MPORT_mask) begin
      ram_els_0_reward[ram_els_0_reward_MPORT_addr] <= ram_els_0_reward_MPORT_data; // @[Decoupled.scala 218:16]
    end
    if(ram_els_0_idx_MPORT_en & ram_els_0_idx_MPORT_mask) begin
      ram_els_0_idx[ram_els_0_idx_MPORT_addr] <= ram_els_0_idx_MPORT_data; // @[Decoupled.scala 218:16]
    end
    if(ram_els_1_reward_MPORT_en & ram_els_1_reward_MPORT_mask) begin
      ram_els_1_reward[ram_els_1_reward_MPORT_addr] <= ram_els_1_reward_MPORT_data; // @[Decoupled.scala 218:16]
    end
    if(ram_els_1_idx_MPORT_en & ram_els_1_idx_MPORT_mask) begin
      ram_els_1_idx[ram_els_1_idx_MPORT_addr] <= ram_els_1_idx_MPORT_data; // @[Decoupled.scala 218:16]
    end
    if(ram_els_2_reward_MPORT_en & ram_els_2_reward_MPORT_mask) begin
      ram_els_2_reward[ram_els_2_reward_MPORT_addr] <= ram_els_2_reward_MPORT_data; // @[Decoupled.scala 218:16]
    end
    if(ram_els_2_idx_MPORT_en & ram_els_2_idx_MPORT_mask) begin
      ram_els_2_idx[ram_els_2_idx_MPORT_addr] <= ram_els_2_idx_MPORT_data; // @[Decoupled.scala 218:16]
    end
    if(ram_els_3_reward_MPORT_en & ram_els_3_reward_MPORT_mask) begin
      ram_els_3_reward[ram_els_3_reward_MPORT_addr] <= ram_els_3_reward_MPORT_data; // @[Decoupled.scala 218:16]
    end
    if(ram_els_3_idx_MPORT_en & ram_els_3_idx_MPORT_mask) begin
      ram_els_3_idx[ram_els_3_idx_MPORT_addr] <= ram_els_3_idx_MPORT_data; // @[Decoupled.scala 218:16]
    end
    if(ram_els_4_reward_MPORT_en & ram_els_4_reward_MPORT_mask) begin
      ram_els_4_reward[ram_els_4_reward_MPORT_addr] <= ram_els_4_reward_MPORT_data; // @[Decoupled.scala 218:16]
    end
    if(ram_els_4_idx_MPORT_en & ram_els_4_idx_MPORT_mask) begin
      ram_els_4_idx[ram_els_4_idx_MPORT_addr] <= ram_els_4_idx_MPORT_data; // @[Decoupled.scala 218:16]
    end
    if(ram_els_5_reward_MPORT_en & ram_els_5_reward_MPORT_mask) begin
      ram_els_5_reward[ram_els_5_reward_MPORT_addr] <= ram_els_5_reward_MPORT_data; // @[Decoupled.scala 218:16]
    end
    if(ram_els_5_idx_MPORT_en & ram_els_5_idx_MPORT_mask) begin
      ram_els_5_idx[ram_els_5_idx_MPORT_addr] <= ram_els_5_idx_MPORT_data; // @[Decoupled.scala 218:16]
    end
    if(ram_els_6_reward_MPORT_en & ram_els_6_reward_MPORT_mask) begin
      ram_els_6_reward[ram_els_6_reward_MPORT_addr] <= ram_els_6_reward_MPORT_data; // @[Decoupled.scala 218:16]
    end
    if(ram_els_6_idx_MPORT_en & ram_els_6_idx_MPORT_mask) begin
      ram_els_6_idx[ram_els_6_idx_MPORT_addr] <= ram_els_6_idx_MPORT_data; // @[Decoupled.scala 218:16]
    end
    if(ram_els_7_reward_MPORT_en & ram_els_7_reward_MPORT_mask) begin
      ram_els_7_reward[ram_els_7_reward_MPORT_addr] <= ram_els_7_reward_MPORT_data; // @[Decoupled.scala 218:16]
    end
    if(ram_els_7_idx_MPORT_en & ram_els_7_idx_MPORT_mask) begin
      ram_els_7_idx[ram_els_7_idx_MPORT_addr] <= ram_els_7_idx_MPORT_data; // @[Decoupled.scala 218:16]
    end
    if(ram_last_MPORT_en & ram_last_MPORT_mask) begin
      ram_last[ram_last_MPORT_addr] <= ram_last_MPORT_data; // @[Decoupled.scala 218:16]
    end
    if (reset) begin // @[Counter.scala 60:40]
      enq_ptr_value <= 3'h0; // @[Counter.scala 60:40]
    end else if (do_enq) begin // @[Decoupled.scala 229:17]
      enq_ptr_value <= _value_T_1; // @[Counter.scala 76:15]
    end
    if (reset) begin // @[Counter.scala 60:40]
      deq_ptr_value <= 3'h0; // @[Counter.scala 60:40]
    end else if (do_deq) begin // @[Decoupled.scala 233:17]
      deq_ptr_value <= _value_T_3; // @[Counter.scala 76:15]
    end
    if (reset) begin // @[Decoupled.scala 221:27]
      maybe_full <= 1'h0; // @[Decoupled.scala 221:27]
    end else if (do_enq != do_deq) begin // @[Decoupled.scala 236:28]
      maybe_full <= do_enq; // @[Decoupled.scala 237:16]
    end
  end
// Register and memory initialization
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
`ifdef RANDOMIZE_MEM_INIT
  _RAND_0 = {1{`RANDOM}};
  for (initvar = 0; initvar < 8; initvar = initvar+1)
    ram_els_0_reward[initvar] = _RAND_0[7:0];
  _RAND_1 = {1{`RANDOM}};
  for (initvar = 0; initvar < 8; initvar = initvar+1)
    ram_els_0_idx[initvar] = _RAND_1[5:0];
  _RAND_2 = {1{`RANDOM}};
  for (initvar = 0; initvar < 8; initvar = initvar+1)
    ram_els_1_reward[initvar] = _RAND_2[7:0];
  _RAND_3 = {1{`RANDOM}};
  for (initvar = 0; initvar < 8; initvar = initvar+1)
    ram_els_1_idx[initvar] = _RAND_3[5:0];
  _RAND_4 = {1{`RANDOM}};
  for (initvar = 0; initvar < 8; initvar = initvar+1)
    ram_els_2_reward[initvar] = _RAND_4[7:0];
  _RAND_5 = {1{`RANDOM}};
  for (initvar = 0; initvar < 8; initvar = initvar+1)
    ram_els_2_idx[initvar] = _RAND_5[5:0];
  _RAND_6 = {1{`RANDOM}};
  for (initvar = 0; initvar < 8; initvar = initvar+1)
    ram_els_3_reward[initvar] = _RAND_6[7:0];
  _RAND_7 = {1{`RANDOM}};
  for (initvar = 0; initvar < 8; initvar = initvar+1)
    ram_els_3_idx[initvar] = _RAND_7[5:0];
  _RAND_8 = {1{`RANDOM}};
  for (initvar = 0; initvar < 8; initvar = initvar+1)
    ram_els_4_reward[initvar] = _RAND_8[7:0];
  _RAND_9 = {1{`RANDOM}};
  for (initvar = 0; initvar < 8; initvar = initvar+1)
    ram_els_4_idx[initvar] = _RAND_9[5:0];
  _RAND_10 = {1{`RANDOM}};
  for (initvar = 0; initvar < 8; initvar = initvar+1)
    ram_els_5_reward[initvar] = _RAND_10[7:0];
  _RAND_11 = {1{`RANDOM}};
  for (initvar = 0; initvar < 8; initvar = initvar+1)
    ram_els_5_idx[initvar] = _RAND_11[5:0];
  _RAND_12 = {1{`RANDOM}};
  for (initvar = 0; initvar < 8; initvar = initvar+1)
    ram_els_6_reward[initvar] = _RAND_12[7:0];
  _RAND_13 = {1{`RANDOM}};
  for (initvar = 0; initvar < 8; initvar = initvar+1)
    ram_els_6_idx[initvar] = _RAND_13[5:0];
  _RAND_14 = {1{`RANDOM}};
  for (initvar = 0; initvar < 8; initvar = initvar+1)
    ram_els_7_reward[initvar] = _RAND_14[7:0];
  _RAND_15 = {1{`RANDOM}};
  for (initvar = 0; initvar < 8; initvar = initvar+1)
    ram_els_7_idx[initvar] = _RAND_15[5:0];
  _RAND_16 = {1{`RANDOM}};
  for (initvar = 0; initvar < 8; initvar = initvar+1)
    ram_last[initvar] = _RAND_16[0:0];
`endif // RANDOMIZE_MEM_INIT
`ifdef RANDOMIZE_REG_INIT
  _RAND_17 = {1{`RANDOM}};
  enq_ptr_value = _RAND_17[2:0];
  _RAND_18 = {1{`RANDOM}};
  deq_ptr_value = _RAND_18[2:0];
  _RAND_19 = {1{`RANDOM}};
  maybe_full = _RAND_19[0:0];
`endif // RANDOMIZE_REG_INIT
  `endif // RANDOMIZE
end // initial
`ifdef FIRRTL_AFTER_INITIAL
`FIRRTL_AFTER_INITIAL
`endif
`endif // SYNTHESIS
endmodule
module DataDistributorSparse(
  input        clock,
  input        reset,
  output       io_bramWordIn_ready,
  input        io_bramWordIn_valid,
  input  [7:0] io_bramWordIn_bits_els_0_reward,
  input  [5:0] io_bramWordIn_bits_els_0_idx,
  input  [7:0] io_bramWordIn_bits_els_1_reward,
  input  [5:0] io_bramWordIn_bits_els_1_idx,
  input  [7:0] io_bramWordIn_bits_els_2_reward,
  input  [5:0] io_bramWordIn_bits_els_2_idx,
  input  [7:0] io_bramWordIn_bits_els_3_reward,
  input  [5:0] io_bramWordIn_bits_els_3_idx,
  input  [7:0] io_bramWordIn_bits_els_4_reward,
  input  [5:0] io_bramWordIn_bits_els_4_idx,
  input  [7:0] io_bramWordIn_bits_els_5_reward,
  input  [5:0] io_bramWordIn_bits_els_5_idx,
  input  [7:0] io_bramWordIn_bits_els_6_reward,
  input  [5:0] io_bramWordIn_bits_els_6_idx,
  input  [7:0] io_bramWordIn_bits_els_7_reward,
  input  [5:0] io_bramWordIn_bits_els_7_idx,
  input        io_bramWordIn_bits_last,
  input        io_peOut_0_ready,
  output       io_peOut_0_valid,
  output [7:0] io_peOut_0_bits_reward,
  output [5:0] io_peOut_0_bits_idx,
  output       io_peOut_0_bits_last,
  output       io_peOut_1_valid,
  output [7:0] io_peOut_1_bits_reward,
  output [5:0] io_peOut_1_bits_idx,
  output       io_peOut_1_bits_last,
  output       io_peOut_2_valid,
  output [7:0] io_peOut_2_bits_reward,
  output [5:0] io_peOut_2_bits_idx,
  output       io_peOut_2_bits_last,
  output       io_peOut_3_valid,
  output [7:0] io_peOut_3_bits_reward,
  output [5:0] io_peOut_3_bits_idx,
  output       io_peOut_3_bits_last,
  output       io_peOut_4_valid,
  output [7:0] io_peOut_4_bits_reward,
  output [5:0] io_peOut_4_bits_idx,
  output       io_peOut_4_bits_last,
  output       io_peOut_5_valid,
  output [7:0] io_peOut_5_bits_reward,
  output [5:0] io_peOut_5_bits_idx,
  output       io_peOut_5_bits_last,
  output       io_peOut_6_valid,
  output [7:0] io_peOut_6_bits_reward,
  output [5:0] io_peOut_6_bits_idx,
  output       io_peOut_6_bits_last,
  output       io_peOut_7_valid,
  output [7:0] io_peOut_7_bits_reward,
  output [5:0] io_peOut_7_bits_idx,
  output       io_peOut_7_bits_last
);
  wire  qData_clock; // @[DataDistributor.scala 83:21]
  wire  qData_reset; // @[DataDistributor.scala 83:21]
  wire  qData_io_enq_ready; // @[DataDistributor.scala 83:21]
  wire  qData_io_enq_valid; // @[DataDistributor.scala 83:21]
  wire [7:0] qData_io_enq_bits_els_0_reward; // @[DataDistributor.scala 83:21]
  wire [5:0] qData_io_enq_bits_els_0_idx; // @[DataDistributor.scala 83:21]
  wire [7:0] qData_io_enq_bits_els_1_reward; // @[DataDistributor.scala 83:21]
  wire [5:0] qData_io_enq_bits_els_1_idx; // @[DataDistributor.scala 83:21]
  wire [7:0] qData_io_enq_bits_els_2_reward; // @[DataDistributor.scala 83:21]
  wire [5:0] qData_io_enq_bits_els_2_idx; // @[DataDistributor.scala 83:21]
  wire [7:0] qData_io_enq_bits_els_3_reward; // @[DataDistributor.scala 83:21]
  wire [5:0] qData_io_enq_bits_els_3_idx; // @[DataDistributor.scala 83:21]
  wire [7:0] qData_io_enq_bits_els_4_reward; // @[DataDistributor.scala 83:21]
  wire [5:0] qData_io_enq_bits_els_4_idx; // @[DataDistributor.scala 83:21]
  wire [7:0] qData_io_enq_bits_els_5_reward; // @[DataDistributor.scala 83:21]
  wire [5:0] qData_io_enq_bits_els_5_idx; // @[DataDistributor.scala 83:21]
  wire [7:0] qData_io_enq_bits_els_6_reward; // @[DataDistributor.scala 83:21]
  wire [5:0] qData_io_enq_bits_els_6_idx; // @[DataDistributor.scala 83:21]
  wire [7:0] qData_io_enq_bits_els_7_reward; // @[DataDistributor.scala 83:21]
  wire [5:0] qData_io_enq_bits_els_7_idx; // @[DataDistributor.scala 83:21]
  wire  qData_io_enq_bits_last; // @[DataDistributor.scala 83:21]
  wire  qData_io_deq_ready; // @[DataDistributor.scala 83:21]
  wire  qData_io_deq_valid; // @[DataDistributor.scala 83:21]
  wire [7:0] qData_io_deq_bits_els_0_reward; // @[DataDistributor.scala 83:21]
  wire [5:0] qData_io_deq_bits_els_0_idx; // @[DataDistributor.scala 83:21]
  wire [7:0] qData_io_deq_bits_els_1_reward; // @[DataDistributor.scala 83:21]
  wire [5:0] qData_io_deq_bits_els_1_idx; // @[DataDistributor.scala 83:21]
  wire [7:0] qData_io_deq_bits_els_2_reward; // @[DataDistributor.scala 83:21]
  wire [5:0] qData_io_deq_bits_els_2_idx; // @[DataDistributor.scala 83:21]
  wire [7:0] qData_io_deq_bits_els_3_reward; // @[DataDistributor.scala 83:21]
  wire [5:0] qData_io_deq_bits_els_3_idx; // @[DataDistributor.scala 83:21]
  wire [7:0] qData_io_deq_bits_els_4_reward; // @[DataDistributor.scala 83:21]
  wire [5:0] qData_io_deq_bits_els_4_idx; // @[DataDistributor.scala 83:21]
  wire [7:0] qData_io_deq_bits_els_5_reward; // @[DataDistributor.scala 83:21]
  wire [5:0] qData_io_deq_bits_els_5_idx; // @[DataDistributor.scala 83:21]
  wire [7:0] qData_io_deq_bits_els_6_reward; // @[DataDistributor.scala 83:21]
  wire [5:0] qData_io_deq_bits_els_6_idx; // @[DataDistributor.scala 83:21]
  wire [7:0] qData_io_deq_bits_els_7_reward; // @[DataDistributor.scala 83:21]
  wire [5:0] qData_io_deq_bits_els_7_idx; // @[DataDistributor.scala 83:21]
  wire  qData_io_deq_bits_last; // @[DataDistributor.scala 83:21]
  Queue_1 qData ( // @[DataDistributor.scala 83:21]
    .clock(qData_clock),
    .reset(qData_reset),
    .io_enq_ready(qData_io_enq_ready),
    .io_enq_valid(qData_io_enq_valid),
    .io_enq_bits_els_0_reward(qData_io_enq_bits_els_0_reward),
    .io_enq_bits_els_0_idx(qData_io_enq_bits_els_0_idx),
    .io_enq_bits_els_1_reward(qData_io_enq_bits_els_1_reward),
    .io_enq_bits_els_1_idx(qData_io_enq_bits_els_1_idx),
    .io_enq_bits_els_2_reward(qData_io_enq_bits_els_2_reward),
    .io_enq_bits_els_2_idx(qData_io_enq_bits_els_2_idx),
    .io_enq_bits_els_3_reward(qData_io_enq_bits_els_3_reward),
    .io_enq_bits_els_3_idx(qData_io_enq_bits_els_3_idx),
    .io_enq_bits_els_4_reward(qData_io_enq_bits_els_4_reward),
    .io_enq_bits_els_4_idx(qData_io_enq_bits_els_4_idx),
    .io_enq_bits_els_5_reward(qData_io_enq_bits_els_5_reward),
    .io_enq_bits_els_5_idx(qData_io_enq_bits_els_5_idx),
    .io_enq_bits_els_6_reward(qData_io_enq_bits_els_6_reward),
    .io_enq_bits_els_6_idx(qData_io_enq_bits_els_6_idx),
    .io_enq_bits_els_7_reward(qData_io_enq_bits_els_7_reward),
    .io_enq_bits_els_7_idx(qData_io_enq_bits_els_7_idx),
    .io_enq_bits_last(qData_io_enq_bits_last),
    .io_deq_ready(qData_io_deq_ready),
    .io_deq_valid(qData_io_deq_valid),
    .io_deq_bits_els_0_reward(qData_io_deq_bits_els_0_reward),
    .io_deq_bits_els_0_idx(qData_io_deq_bits_els_0_idx),
    .io_deq_bits_els_1_reward(qData_io_deq_bits_els_1_reward),
    .io_deq_bits_els_1_idx(qData_io_deq_bits_els_1_idx),
    .io_deq_bits_els_2_reward(qData_io_deq_bits_els_2_reward),
    .io_deq_bits_els_2_idx(qData_io_deq_bits_els_2_idx),
    .io_deq_bits_els_3_reward(qData_io_deq_bits_els_3_reward),
    .io_deq_bits_els_3_idx(qData_io_deq_bits_els_3_idx),
    .io_deq_bits_els_4_reward(qData_io_deq_bits_els_4_reward),
    .io_deq_bits_els_4_idx(qData_io_deq_bits_els_4_idx),
    .io_deq_bits_els_5_reward(qData_io_deq_bits_els_5_reward),
    .io_deq_bits_els_5_idx(qData_io_deq_bits_els_5_idx),
    .io_deq_bits_els_6_reward(qData_io_deq_bits_els_6_reward),
    .io_deq_bits_els_6_idx(qData_io_deq_bits_els_6_idx),
    .io_deq_bits_els_7_reward(qData_io_deq_bits_els_7_reward),
    .io_deq_bits_els_7_idx(qData_io_deq_bits_els_7_idx),
    .io_deq_bits_last(qData_io_deq_bits_last)
  );
  assign io_bramWordIn_ready = qData_io_enq_ready; // @[DataDistributor.scala 84:17]
  assign io_peOut_0_valid = qData_io_deq_valid; // @[DataDistributor.scala 92:16]
  assign io_peOut_0_bits_reward = qData_io_deq_bits_els_0_reward; // @[DataDistributor.scala 93:22]
  assign io_peOut_0_bits_idx = qData_io_deq_bits_els_0_idx; // @[DataDistributor.scala 94:19]
  assign io_peOut_0_bits_last = qData_io_deq_bits_last; // @[DataDistributor.scala 95:20]
  assign io_peOut_1_valid = qData_io_deq_valid; // @[DataDistributor.scala 92:16]
  assign io_peOut_1_bits_reward = qData_io_deq_bits_els_1_reward; // @[DataDistributor.scala 93:22]
  assign io_peOut_1_bits_idx = qData_io_deq_bits_els_1_idx; // @[DataDistributor.scala 94:19]
  assign io_peOut_1_bits_last = qData_io_deq_bits_last; // @[DataDistributor.scala 95:20]
  assign io_peOut_2_valid = qData_io_deq_valid; // @[DataDistributor.scala 92:16]
  assign io_peOut_2_bits_reward = qData_io_deq_bits_els_2_reward; // @[DataDistributor.scala 93:22]
  assign io_peOut_2_bits_idx = qData_io_deq_bits_els_2_idx; // @[DataDistributor.scala 94:19]
  assign io_peOut_2_bits_last = qData_io_deq_bits_last; // @[DataDistributor.scala 95:20]
  assign io_peOut_3_valid = qData_io_deq_valid; // @[DataDistributor.scala 92:16]
  assign io_peOut_3_bits_reward = qData_io_deq_bits_els_3_reward; // @[DataDistributor.scala 93:22]
  assign io_peOut_3_bits_idx = qData_io_deq_bits_els_3_idx; // @[DataDistributor.scala 94:19]
  assign io_peOut_3_bits_last = qData_io_deq_bits_last; // @[DataDistributor.scala 95:20]
  assign io_peOut_4_valid = qData_io_deq_valid; // @[DataDistributor.scala 92:16]
  assign io_peOut_4_bits_reward = qData_io_deq_bits_els_4_reward; // @[DataDistributor.scala 93:22]
  assign io_peOut_4_bits_idx = qData_io_deq_bits_els_4_idx; // @[DataDistributor.scala 94:19]
  assign io_peOut_4_bits_last = qData_io_deq_bits_last; // @[DataDistributor.scala 95:20]
  assign io_peOut_5_valid = qData_io_deq_valid; // @[DataDistributor.scala 92:16]
  assign io_peOut_5_bits_reward = qData_io_deq_bits_els_5_reward; // @[DataDistributor.scala 93:22]
  assign io_peOut_5_bits_idx = qData_io_deq_bits_els_5_idx; // @[DataDistributor.scala 94:19]
  assign io_peOut_5_bits_last = qData_io_deq_bits_last; // @[DataDistributor.scala 95:20]
  assign io_peOut_6_valid = qData_io_deq_valid; // @[DataDistributor.scala 92:16]
  assign io_peOut_6_bits_reward = qData_io_deq_bits_els_6_reward; // @[DataDistributor.scala 93:22]
  assign io_peOut_6_bits_idx = qData_io_deq_bits_els_6_idx; // @[DataDistributor.scala 94:19]
  assign io_peOut_6_bits_last = qData_io_deq_bits_last; // @[DataDistributor.scala 95:20]
  assign io_peOut_7_valid = qData_io_deq_valid; // @[DataDistributor.scala 92:16]
  assign io_peOut_7_bits_reward = qData_io_deq_bits_els_7_reward; // @[DataDistributor.scala 93:22]
  assign io_peOut_7_bits_idx = qData_io_deq_bits_els_7_idx; // @[DataDistributor.scala 94:19]
  assign io_peOut_7_bits_last = qData_io_deq_bits_last; // @[DataDistributor.scala 95:20]
  assign qData_clock = clock;
  assign qData_reset = reset;
  assign qData_io_enq_valid = io_bramWordIn_valid; // @[DataDistributor.scala 84:17]
  assign qData_io_enq_bits_els_0_reward = io_bramWordIn_bits_els_0_reward; // @[DataDistributor.scala 84:17]
  assign qData_io_enq_bits_els_0_idx = io_bramWordIn_bits_els_0_idx; // @[DataDistributor.scala 84:17]
  assign qData_io_enq_bits_els_1_reward = io_bramWordIn_bits_els_1_reward; // @[DataDistributor.scala 84:17]
  assign qData_io_enq_bits_els_1_idx = io_bramWordIn_bits_els_1_idx; // @[DataDistributor.scala 84:17]
  assign qData_io_enq_bits_els_2_reward = io_bramWordIn_bits_els_2_reward; // @[DataDistributor.scala 84:17]
  assign qData_io_enq_bits_els_2_idx = io_bramWordIn_bits_els_2_idx; // @[DataDistributor.scala 84:17]
  assign qData_io_enq_bits_els_3_reward = io_bramWordIn_bits_els_3_reward; // @[DataDistributor.scala 84:17]
  assign qData_io_enq_bits_els_3_idx = io_bramWordIn_bits_els_3_idx; // @[DataDistributor.scala 84:17]
  assign qData_io_enq_bits_els_4_reward = io_bramWordIn_bits_els_4_reward; // @[DataDistributor.scala 84:17]
  assign qData_io_enq_bits_els_4_idx = io_bramWordIn_bits_els_4_idx; // @[DataDistributor.scala 84:17]
  assign qData_io_enq_bits_els_5_reward = io_bramWordIn_bits_els_5_reward; // @[DataDistributor.scala 84:17]
  assign qData_io_enq_bits_els_5_idx = io_bramWordIn_bits_els_5_idx; // @[DataDistributor.scala 84:17]
  assign qData_io_enq_bits_els_6_reward = io_bramWordIn_bits_els_6_reward; // @[DataDistributor.scala 84:17]
  assign qData_io_enq_bits_els_6_idx = io_bramWordIn_bits_els_6_idx; // @[DataDistributor.scala 84:17]
  assign qData_io_enq_bits_els_7_reward = io_bramWordIn_bits_els_7_reward; // @[DataDistributor.scala 84:17]
  assign qData_io_enq_bits_els_7_idx = io_bramWordIn_bits_els_7_idx; // @[DataDistributor.scala 84:17]
  assign qData_io_enq_bits_last = io_bramWordIn_bits_last; // @[DataDistributor.scala 84:17]
  assign qData_io_deq_ready = io_peOut_0_ready; // @[DataDistributor.scala 87:22]
endmodule
module Queue_2(
  input        clock,
  input        reset,
  output       io_enq_ready,
  input        io_enq_valid,
  input  [7:0] io_enq_bits_agent,
  input        io_deq_ready,
  output       io_deq_valid,
  output [7:0] io_deq_bits_agent
);
`ifdef RANDOMIZE_MEM_INIT
  reg [31:0] _RAND_0;
`endif // RANDOMIZE_MEM_INIT
`ifdef RANDOMIZE_REG_INIT
  reg [31:0] _RAND_1;
  reg [31:0] _RAND_2;
  reg [31:0] _RAND_3;
`endif // RANDOMIZE_REG_INIT
  reg [7:0] ram_agent [0:15]; // @[Decoupled.scala 218:16]
  wire [7:0] ram_agent_io_deq_bits_MPORT_data; // @[Decoupled.scala 218:16]
  wire [3:0] ram_agent_io_deq_bits_MPORT_addr; // @[Decoupled.scala 218:16]
  wire [7:0] ram_agent_MPORT_data; // @[Decoupled.scala 218:16]
  wire [3:0] ram_agent_MPORT_addr; // @[Decoupled.scala 218:16]
  wire  ram_agent_MPORT_mask; // @[Decoupled.scala 218:16]
  wire  ram_agent_MPORT_en; // @[Decoupled.scala 218:16]
  reg [3:0] enq_ptr_value; // @[Counter.scala 60:40]
  reg [3:0] deq_ptr_value; // @[Counter.scala 60:40]
  reg  maybe_full; // @[Decoupled.scala 221:27]
  wire  ptr_match = enq_ptr_value == deq_ptr_value; // @[Decoupled.scala 223:33]
  wire  empty = ptr_match & ~maybe_full; // @[Decoupled.scala 224:25]
  wire  full = ptr_match & maybe_full; // @[Decoupled.scala 225:24]
  wire  do_enq = io_enq_ready & io_enq_valid; // @[Decoupled.scala 40:37]
  wire  do_deq = io_deq_ready & io_deq_valid; // @[Decoupled.scala 40:37]
  wire [3:0] _value_T_1 = enq_ptr_value + 4'h1; // @[Counter.scala 76:24]
  wire [3:0] _value_T_3 = deq_ptr_value + 4'h1; // @[Counter.scala 76:24]
  assign ram_agent_io_deq_bits_MPORT_addr = deq_ptr_value;
  assign ram_agent_io_deq_bits_MPORT_data = ram_agent[ram_agent_io_deq_bits_MPORT_addr]; // @[Decoupled.scala 218:16]
  assign ram_agent_MPORT_data = io_enq_bits_agent;
  assign ram_agent_MPORT_addr = enq_ptr_value;
  assign ram_agent_MPORT_mask = 1'h1;
  assign ram_agent_MPORT_en = io_enq_ready & io_enq_valid;
  assign io_enq_ready = ~full; // @[Decoupled.scala 241:19]
  assign io_deq_valid = ~empty; // @[Decoupled.scala 240:19]
  assign io_deq_bits_agent = ram_agent_io_deq_bits_MPORT_data; // @[Decoupled.scala 242:15]
  always @(posedge clock) begin
    if(ram_agent_MPORT_en & ram_agent_MPORT_mask) begin
      ram_agent[ram_agent_MPORT_addr] <= ram_agent_MPORT_data; // @[Decoupled.scala 218:16]
    end
    if (reset) begin // @[Counter.scala 60:40]
      enq_ptr_value <= 4'h0; // @[Counter.scala 60:40]
    end else if (do_enq) begin // @[Decoupled.scala 229:17]
      enq_ptr_value <= _value_T_1; // @[Counter.scala 76:15]
    end
    if (reset) begin // @[Counter.scala 60:40]
      deq_ptr_value <= 4'h0; // @[Counter.scala 60:40]
    end else if (do_deq) begin // @[Decoupled.scala 233:17]
      deq_ptr_value <= _value_T_3; // @[Counter.scala 76:15]
    end
    if (reset) begin // @[Decoupled.scala 221:27]
      maybe_full <= 1'h0; // @[Decoupled.scala 221:27]
    end else if (do_enq != do_deq) begin // @[Decoupled.scala 236:28]
      maybe_full <= do_enq; // @[Decoupled.scala 237:16]
    end
  end
// Register and memory initialization
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
`ifdef RANDOMIZE_MEM_INIT
  _RAND_0 = {1{`RANDOM}};
  for (initvar = 0; initvar < 16; initvar = initvar+1)
    ram_agent[initvar] = _RAND_0[7:0];
`endif // RANDOMIZE_MEM_INIT
`ifdef RANDOMIZE_REG_INIT
  _RAND_1 = {1{`RANDOM}};
  enq_ptr_value = _RAND_1[3:0];
  _RAND_2 = {1{`RANDOM}};
  deq_ptr_value = _RAND_2[3:0];
  _RAND_3 = {1{`RANDOM}};
  maybe_full = _RAND_3[0:0];
`endif // RANDOMIZE_REG_INIT
  `endif // RANDOMIZE
end // initial
`ifdef FIRRTL_AFTER_INITIAL
`FIRRTL_AFTER_INITIAL
`endif
`endif // SYNTHESIS
endmodule
module SimpleDualPortBRAM(
  input          clock,
  input  [8:0]   io_read_req_addr,
  output [119:0] io_read_rsp_readData,
  input  [8:0]   io_write_req_addr,
  input  [119:0] io_write_req_writeData,
  input          io_write_req_writeEn
);
`ifdef RANDOMIZE_MEM_INIT
  reg [127:0] _RAND_0;
`endif // RANDOMIZE_MEM_INIT
`ifdef RANDOMIZE_REG_INIT
  reg [31:0] _RAND_1;
`endif // RANDOMIZE_REG_INIT
  reg [119:0] mem [0:511]; // @[SimpleDualPortBRAM.scala 20:24]
  wire [119:0] mem_rdPort_data; // @[SimpleDualPortBRAM.scala 20:24]
  wire [8:0] mem_rdPort_addr; // @[SimpleDualPortBRAM.scala 20:24]
  wire [119:0] mem_MPORT_data; // @[SimpleDualPortBRAM.scala 20:24]
  wire [8:0] mem_MPORT_addr; // @[SimpleDualPortBRAM.scala 20:24]
  wire  mem_MPORT_mask; // @[SimpleDualPortBRAM.scala 20:24]
  wire  mem_MPORT_en; // @[SimpleDualPortBRAM.scala 20:24]
  reg [8:0] mem_rdPort_addr_pipe_0;
  assign mem_rdPort_addr = mem_rdPort_addr_pipe_0;
  assign mem_rdPort_data = mem[mem_rdPort_addr]; // @[SimpleDualPortBRAM.scala 20:24]
  assign mem_MPORT_data = io_write_req_writeData;
  assign mem_MPORT_addr = io_write_req_addr;
  assign mem_MPORT_mask = 1'h1;
  assign mem_MPORT_en = io_write_req_writeEn;
  assign io_read_rsp_readData = mem_rdPort_data; // @[SimpleDualPortBRAM.scala 24:24]
  always @(posedge clock) begin
    if(mem_MPORT_en & mem_MPORT_mask) begin
      mem[mem_MPORT_addr] <= mem_MPORT_data; // @[SimpleDualPortBRAM.scala 20:24]
    end
    mem_rdPort_addr_pipe_0 <= io_read_req_addr;
  end
// Register and memory initialization
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
`ifdef RANDOMIZE_MEM_INIT
  _RAND_0 = {4{`RANDOM}};
  for (initvar = 0; initvar < 512; initvar = initvar+1)
    mem[initvar] = _RAND_0[119:0];
`endif // RANDOMIZE_MEM_INIT
`ifdef RANDOMIZE_REG_INIT
  _RAND_1 = {1{`RANDOM}};
  mem_rdPort_addr_pipe_0 = _RAND_1[8:0];
`endif // RANDOMIZE_REG_INIT
  `endif // RANDOMIZE
end // initial
`ifdef FIRRTL_AFTER_INITIAL
`FIRRTL_AFTER_INITIAL
`endif
`endif // SYNTHESIS
endmodule
module RegStore(
  input        clock,
  input        reset,
  output       io_rPorts_0_req_ready,
  input        io_rPorts_0_req_valid,
  input  [5:0] io_rPorts_0_req_bits_addr,
  input        io_rPorts_0_rsp_ready,
  output [7:0] io_rPorts_0_rsp_bits_rdata,
  output       io_rPorts_1_req_ready,
  input        io_rPorts_1_req_valid,
  input  [5:0] io_rPorts_1_req_bits_addr,
  input        io_rPorts_1_rsp_ready,
  output [7:0] io_rPorts_1_rsp_bits_rdata,
  output       io_rPorts_2_req_ready,
  input        io_rPorts_2_req_valid,
  input  [5:0] io_rPorts_2_req_bits_addr,
  input        io_rPorts_2_rsp_ready,
  output [7:0] io_rPorts_2_rsp_bits_rdata,
  output       io_rPorts_3_req_ready,
  input        io_rPorts_3_req_valid,
  input  [5:0] io_rPorts_3_req_bits_addr,
  input        io_rPorts_3_rsp_ready,
  output [7:0] io_rPorts_3_rsp_bits_rdata,
  output       io_rPorts_4_req_ready,
  input        io_rPorts_4_req_valid,
  input  [5:0] io_rPorts_4_req_bits_addr,
  input        io_rPorts_4_rsp_ready,
  output [7:0] io_rPorts_4_rsp_bits_rdata,
  output       io_rPorts_5_req_ready,
  input        io_rPorts_5_req_valid,
  input  [5:0] io_rPorts_5_req_bits_addr,
  input        io_rPorts_5_rsp_ready,
  output [7:0] io_rPorts_5_rsp_bits_rdata,
  output       io_rPorts_6_req_ready,
  input        io_rPorts_6_req_valid,
  input  [5:0] io_rPorts_6_req_bits_addr,
  input        io_rPorts_6_rsp_ready,
  output [7:0] io_rPorts_6_rsp_bits_rdata,
  output       io_rPorts_7_req_ready,
  input        io_rPorts_7_req_valid,
  input  [5:0] io_rPorts_7_req_bits_addr,
  input        io_rPorts_7_rsp_ready,
  output [7:0] io_rPorts_7_rsp_bits_rdata,
  output       io_rwPorts_0_req_ready,
  input        io_rwPorts_0_req_valid,
  input        io_rwPorts_0_req_bits_wen,
  input  [5:0] io_rwPorts_0_req_bits_addr,
  input  [7:0] io_rwPorts_0_req_bits_wdata,
  output       io_rwPorts_0_rsp_valid,
  output [7:0] io_rwPorts_0_rsp_bits_rdata
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
  reg [31:0] _RAND_13;
  reg [31:0] _RAND_14;
  reg [31:0] _RAND_15;
  reg [31:0] _RAND_16;
  reg [31:0] _RAND_17;
  reg [31:0] _RAND_18;
  reg [31:0] _RAND_19;
  reg [31:0] _RAND_20;
  reg [31:0] _RAND_21;
  reg [31:0] _RAND_22;
  reg [31:0] _RAND_23;
  reg [31:0] _RAND_24;
  reg [31:0] _RAND_25;
  reg [31:0] _RAND_26;
  reg [31:0] _RAND_27;
  reg [31:0] _RAND_28;
  reg [31:0] _RAND_29;
  reg [31:0] _RAND_30;
  reg [31:0] _RAND_31;
  reg [31:0] _RAND_32;
  reg [31:0] _RAND_33;
  reg [31:0] _RAND_34;
  reg [31:0] _RAND_35;
  reg [31:0] _RAND_36;
  reg [31:0] _RAND_37;
  reg [31:0] _RAND_38;
  reg [31:0] _RAND_39;
  reg [31:0] _RAND_40;
  reg [31:0] _RAND_41;
  reg [31:0] _RAND_42;
  reg [31:0] _RAND_43;
  reg [31:0] _RAND_44;
  reg [31:0] _RAND_45;
  reg [31:0] _RAND_46;
  reg [31:0] _RAND_47;
  reg [31:0] _RAND_48;
  reg [31:0] _RAND_49;
  reg [31:0] _RAND_50;
  reg [31:0] _RAND_51;
  reg [31:0] _RAND_52;
  reg [31:0] _RAND_53;
  reg [31:0] _RAND_54;
  reg [31:0] _RAND_55;
  reg [31:0] _RAND_56;
  reg [31:0] _RAND_57;
  reg [31:0] _RAND_58;
  reg [31:0] _RAND_59;
  reg [31:0] _RAND_60;
  reg [31:0] _RAND_61;
  reg [31:0] _RAND_62;
  reg [31:0] _RAND_63;
`endif // RANDOMIZE_REG_INIT
  reg [7:0] data_0; // @[RegStore.scala 104:21]
  reg [7:0] data_1; // @[RegStore.scala 104:21]
  reg [7:0] data_2; // @[RegStore.scala 104:21]
  reg [7:0] data_3; // @[RegStore.scala 104:21]
  reg [7:0] data_4; // @[RegStore.scala 104:21]
  reg [7:0] data_5; // @[RegStore.scala 104:21]
  reg [7:0] data_6; // @[RegStore.scala 104:21]
  reg [7:0] data_7; // @[RegStore.scala 104:21]
  reg [7:0] data_8; // @[RegStore.scala 104:21]
  reg [7:0] data_9; // @[RegStore.scala 104:21]
  reg [7:0] data_10; // @[RegStore.scala 104:21]
  reg [7:0] data_11; // @[RegStore.scala 104:21]
  reg [7:0] data_12; // @[RegStore.scala 104:21]
  reg [7:0] data_13; // @[RegStore.scala 104:21]
  reg [7:0] data_14; // @[RegStore.scala 104:21]
  reg [7:0] data_15; // @[RegStore.scala 104:21]
  reg [7:0] data_16; // @[RegStore.scala 104:21]
  reg [7:0] data_17; // @[RegStore.scala 104:21]
  reg [7:0] data_18; // @[RegStore.scala 104:21]
  reg [7:0] data_19; // @[RegStore.scala 104:21]
  reg [7:0] data_20; // @[RegStore.scala 104:21]
  reg [7:0] data_21; // @[RegStore.scala 104:21]
  reg [7:0] data_22; // @[RegStore.scala 104:21]
  reg [7:0] data_23; // @[RegStore.scala 104:21]
  reg [7:0] data_24; // @[RegStore.scala 104:21]
  reg [7:0] data_25; // @[RegStore.scala 104:21]
  reg [7:0] data_26; // @[RegStore.scala 104:21]
  reg [7:0] data_27; // @[RegStore.scala 104:21]
  reg [7:0] data_28; // @[RegStore.scala 104:21]
  reg [7:0] data_29; // @[RegStore.scala 104:21]
  reg [7:0] data_30; // @[RegStore.scala 104:21]
  reg [7:0] data_31; // @[RegStore.scala 104:21]
  reg [7:0] data_32; // @[RegStore.scala 104:21]
  reg [7:0] data_33; // @[RegStore.scala 104:21]
  reg [7:0] data_34; // @[RegStore.scala 104:21]
  reg [7:0] data_35; // @[RegStore.scala 104:21]
  reg [7:0] data_36; // @[RegStore.scala 104:21]
  reg [7:0] data_37; // @[RegStore.scala 104:21]
  reg [7:0] data_38; // @[RegStore.scala 104:21]
  reg [7:0] data_39; // @[RegStore.scala 104:21]
  reg [7:0] data_40; // @[RegStore.scala 104:21]
  reg [7:0] data_41; // @[RegStore.scala 104:21]
  reg [7:0] data_42; // @[RegStore.scala 104:21]
  reg [7:0] data_43; // @[RegStore.scala 104:21]
  reg [7:0] data_44; // @[RegStore.scala 104:21]
  reg [7:0] data_45; // @[RegStore.scala 104:21]
  reg [7:0] data_46; // @[RegStore.scala 104:21]
  reg [7:0] data_47; // @[RegStore.scala 104:21]
  reg [7:0] data_48; // @[RegStore.scala 104:21]
  reg [7:0] data_49; // @[RegStore.scala 104:21]
  reg [7:0] data_50; // @[RegStore.scala 104:21]
  reg [7:0] data_51; // @[RegStore.scala 104:21]
  reg [7:0] data_52; // @[RegStore.scala 104:21]
  reg [7:0] data_53; // @[RegStore.scala 104:21]
  reg [7:0] data_54; // @[RegStore.scala 104:21]
  reg [7:0] data_55; // @[RegStore.scala 104:21]
  reg [7:0] data_56; // @[RegStore.scala 104:21]
  reg [7:0] data_57; // @[RegStore.scala 104:21]
  reg [7:0] data_58; // @[RegStore.scala 104:21]
  reg [7:0] data_59; // @[RegStore.scala 104:21]
  reg [7:0] data_60; // @[RegStore.scala 104:21]
  reg [7:0] data_61; // @[RegStore.scala 104:21]
  reg [7:0] data_62; // @[RegStore.scala 104:21]
  reg [7:0] data_63; // @[RegStore.scala 104:21]
  wire  _T = io_rPorts_0_req_ready & io_rPorts_0_req_valid; // @[Decoupled.scala 40:37]
  wire [7:0] _GEN_1 = 6'h1 == io_rPorts_0_req_bits_addr ? data_1 : data_0; // @[]
  wire [7:0] _GEN_2 = 6'h2 == io_rPorts_0_req_bits_addr ? data_2 : _GEN_1; // @[]
  wire [7:0] _GEN_3 = 6'h3 == io_rPorts_0_req_bits_addr ? data_3 : _GEN_2; // @[]
  wire [7:0] _GEN_4 = 6'h4 == io_rPorts_0_req_bits_addr ? data_4 : _GEN_3; // @[]
  wire [7:0] _GEN_5 = 6'h5 == io_rPorts_0_req_bits_addr ? data_5 : _GEN_4; // @[]
  wire [7:0] _GEN_6 = 6'h6 == io_rPorts_0_req_bits_addr ? data_6 : _GEN_5; // @[]
  wire [7:0] _GEN_7 = 6'h7 == io_rPorts_0_req_bits_addr ? data_7 : _GEN_6; // @[]
  wire [7:0] _GEN_8 = 6'h8 == io_rPorts_0_req_bits_addr ? data_8 : _GEN_7; // @[]
  wire [7:0] _GEN_9 = 6'h9 == io_rPorts_0_req_bits_addr ? data_9 : _GEN_8; // @[]
  wire [7:0] _GEN_10 = 6'ha == io_rPorts_0_req_bits_addr ? data_10 : _GEN_9; // @[]
  wire [7:0] _GEN_11 = 6'hb == io_rPorts_0_req_bits_addr ? data_11 : _GEN_10; // @[]
  wire [7:0] _GEN_12 = 6'hc == io_rPorts_0_req_bits_addr ? data_12 : _GEN_11; // @[]
  wire [7:0] _GEN_13 = 6'hd == io_rPorts_0_req_bits_addr ? data_13 : _GEN_12; // @[]
  wire [7:0] _GEN_14 = 6'he == io_rPorts_0_req_bits_addr ? data_14 : _GEN_13; // @[]
  wire [7:0] _GEN_15 = 6'hf == io_rPorts_0_req_bits_addr ? data_15 : _GEN_14; // @[]
  wire [7:0] _GEN_16 = 6'h10 == io_rPorts_0_req_bits_addr ? data_16 : _GEN_15; // @[]
  wire [7:0] _GEN_17 = 6'h11 == io_rPorts_0_req_bits_addr ? data_17 : _GEN_16; // @[]
  wire [7:0] _GEN_18 = 6'h12 == io_rPorts_0_req_bits_addr ? data_18 : _GEN_17; // @[]
  wire [7:0] _GEN_19 = 6'h13 == io_rPorts_0_req_bits_addr ? data_19 : _GEN_18; // @[]
  wire [7:0] _GEN_20 = 6'h14 == io_rPorts_0_req_bits_addr ? data_20 : _GEN_19; // @[]
  wire [7:0] _GEN_21 = 6'h15 == io_rPorts_0_req_bits_addr ? data_21 : _GEN_20; // @[]
  wire [7:0] _GEN_22 = 6'h16 == io_rPorts_0_req_bits_addr ? data_22 : _GEN_21; // @[]
  wire [7:0] _GEN_23 = 6'h17 == io_rPorts_0_req_bits_addr ? data_23 : _GEN_22; // @[]
  wire [7:0] _GEN_24 = 6'h18 == io_rPorts_0_req_bits_addr ? data_24 : _GEN_23; // @[]
  wire [7:0] _GEN_25 = 6'h19 == io_rPorts_0_req_bits_addr ? data_25 : _GEN_24; // @[]
  wire [7:0] _GEN_26 = 6'h1a == io_rPorts_0_req_bits_addr ? data_26 : _GEN_25; // @[]
  wire [7:0] _GEN_27 = 6'h1b == io_rPorts_0_req_bits_addr ? data_27 : _GEN_26; // @[]
  wire [7:0] _GEN_28 = 6'h1c == io_rPorts_0_req_bits_addr ? data_28 : _GEN_27; // @[]
  wire [7:0] _GEN_29 = 6'h1d == io_rPorts_0_req_bits_addr ? data_29 : _GEN_28; // @[]
  wire [7:0] _GEN_30 = 6'h1e == io_rPorts_0_req_bits_addr ? data_30 : _GEN_29; // @[]
  wire [7:0] _GEN_31 = 6'h1f == io_rPorts_0_req_bits_addr ? data_31 : _GEN_30; // @[]
  wire [7:0] _GEN_32 = 6'h20 == io_rPorts_0_req_bits_addr ? data_32 : _GEN_31; // @[]
  wire [7:0] _GEN_33 = 6'h21 == io_rPorts_0_req_bits_addr ? data_33 : _GEN_32; // @[]
  wire [7:0] _GEN_34 = 6'h22 == io_rPorts_0_req_bits_addr ? data_34 : _GEN_33; // @[]
  wire [7:0] _GEN_35 = 6'h23 == io_rPorts_0_req_bits_addr ? data_35 : _GEN_34; // @[]
  wire [7:0] _GEN_36 = 6'h24 == io_rPorts_0_req_bits_addr ? data_36 : _GEN_35; // @[]
  wire [7:0] _GEN_37 = 6'h25 == io_rPorts_0_req_bits_addr ? data_37 : _GEN_36; // @[]
  wire [7:0] _GEN_38 = 6'h26 == io_rPorts_0_req_bits_addr ? data_38 : _GEN_37; // @[]
  wire [7:0] _GEN_39 = 6'h27 == io_rPorts_0_req_bits_addr ? data_39 : _GEN_38; // @[]
  wire [7:0] _GEN_40 = 6'h28 == io_rPorts_0_req_bits_addr ? data_40 : _GEN_39; // @[]
  wire [7:0] _GEN_41 = 6'h29 == io_rPorts_0_req_bits_addr ? data_41 : _GEN_40; // @[]
  wire [7:0] _GEN_42 = 6'h2a == io_rPorts_0_req_bits_addr ? data_42 : _GEN_41; // @[]
  wire [7:0] _GEN_43 = 6'h2b == io_rPorts_0_req_bits_addr ? data_43 : _GEN_42; // @[]
  wire [7:0] _GEN_44 = 6'h2c == io_rPorts_0_req_bits_addr ? data_44 : _GEN_43; // @[]
  wire [7:0] _GEN_45 = 6'h2d == io_rPorts_0_req_bits_addr ? data_45 : _GEN_44; // @[]
  wire [7:0] _GEN_46 = 6'h2e == io_rPorts_0_req_bits_addr ? data_46 : _GEN_45; // @[]
  wire [7:0] _GEN_47 = 6'h2f == io_rPorts_0_req_bits_addr ? data_47 : _GEN_46; // @[]
  wire [7:0] _GEN_48 = 6'h30 == io_rPorts_0_req_bits_addr ? data_48 : _GEN_47; // @[]
  wire [7:0] _GEN_49 = 6'h31 == io_rPorts_0_req_bits_addr ? data_49 : _GEN_48; // @[]
  wire [7:0] _GEN_50 = 6'h32 == io_rPorts_0_req_bits_addr ? data_50 : _GEN_49; // @[]
  wire [7:0] _GEN_51 = 6'h33 == io_rPorts_0_req_bits_addr ? data_51 : _GEN_50; // @[]
  wire [7:0] _GEN_52 = 6'h34 == io_rPorts_0_req_bits_addr ? data_52 : _GEN_51; // @[]
  wire [7:0] _GEN_53 = 6'h35 == io_rPorts_0_req_bits_addr ? data_53 : _GEN_52; // @[]
  wire [7:0] _GEN_54 = 6'h36 == io_rPorts_0_req_bits_addr ? data_54 : _GEN_53; // @[]
  wire [7:0] _GEN_55 = 6'h37 == io_rPorts_0_req_bits_addr ? data_55 : _GEN_54; // @[]
  wire [7:0] _GEN_56 = 6'h38 == io_rPorts_0_req_bits_addr ? data_56 : _GEN_55; // @[]
  wire [7:0] _GEN_57 = 6'h39 == io_rPorts_0_req_bits_addr ? data_57 : _GEN_56; // @[]
  wire [7:0] _GEN_58 = 6'h3a == io_rPorts_0_req_bits_addr ? data_58 : _GEN_57; // @[]
  wire [7:0] _GEN_59 = 6'h3b == io_rPorts_0_req_bits_addr ? data_59 : _GEN_58; // @[]
  wire [7:0] _GEN_60 = 6'h3c == io_rPorts_0_req_bits_addr ? data_60 : _GEN_59; // @[]
  wire [7:0] _GEN_61 = 6'h3d == io_rPorts_0_req_bits_addr ? data_61 : _GEN_60; // @[]
  wire [7:0] _GEN_62 = 6'h3e == io_rPorts_0_req_bits_addr ? data_62 : _GEN_61; // @[]
  wire  _T_8 = io_rPorts_1_req_ready & io_rPorts_1_req_valid; // @[Decoupled.scala 40:37]
  wire [7:0] _GEN_67 = 6'h1 == io_rPorts_1_req_bits_addr ? data_1 : data_0; // @[]
  wire [7:0] _GEN_68 = 6'h2 == io_rPorts_1_req_bits_addr ? data_2 : _GEN_67; // @[]
  wire [7:0] _GEN_69 = 6'h3 == io_rPorts_1_req_bits_addr ? data_3 : _GEN_68; // @[]
  wire [7:0] _GEN_70 = 6'h4 == io_rPorts_1_req_bits_addr ? data_4 : _GEN_69; // @[]
  wire [7:0] _GEN_71 = 6'h5 == io_rPorts_1_req_bits_addr ? data_5 : _GEN_70; // @[]
  wire [7:0] _GEN_72 = 6'h6 == io_rPorts_1_req_bits_addr ? data_6 : _GEN_71; // @[]
  wire [7:0] _GEN_73 = 6'h7 == io_rPorts_1_req_bits_addr ? data_7 : _GEN_72; // @[]
  wire [7:0] _GEN_74 = 6'h8 == io_rPorts_1_req_bits_addr ? data_8 : _GEN_73; // @[]
  wire [7:0] _GEN_75 = 6'h9 == io_rPorts_1_req_bits_addr ? data_9 : _GEN_74; // @[]
  wire [7:0] _GEN_76 = 6'ha == io_rPorts_1_req_bits_addr ? data_10 : _GEN_75; // @[]
  wire [7:0] _GEN_77 = 6'hb == io_rPorts_1_req_bits_addr ? data_11 : _GEN_76; // @[]
  wire [7:0] _GEN_78 = 6'hc == io_rPorts_1_req_bits_addr ? data_12 : _GEN_77; // @[]
  wire [7:0] _GEN_79 = 6'hd == io_rPorts_1_req_bits_addr ? data_13 : _GEN_78; // @[]
  wire [7:0] _GEN_80 = 6'he == io_rPorts_1_req_bits_addr ? data_14 : _GEN_79; // @[]
  wire [7:0] _GEN_81 = 6'hf == io_rPorts_1_req_bits_addr ? data_15 : _GEN_80; // @[]
  wire [7:0] _GEN_82 = 6'h10 == io_rPorts_1_req_bits_addr ? data_16 : _GEN_81; // @[]
  wire [7:0] _GEN_83 = 6'h11 == io_rPorts_1_req_bits_addr ? data_17 : _GEN_82; // @[]
  wire [7:0] _GEN_84 = 6'h12 == io_rPorts_1_req_bits_addr ? data_18 : _GEN_83; // @[]
  wire [7:0] _GEN_85 = 6'h13 == io_rPorts_1_req_bits_addr ? data_19 : _GEN_84; // @[]
  wire [7:0] _GEN_86 = 6'h14 == io_rPorts_1_req_bits_addr ? data_20 : _GEN_85; // @[]
  wire [7:0] _GEN_87 = 6'h15 == io_rPorts_1_req_bits_addr ? data_21 : _GEN_86; // @[]
  wire [7:0] _GEN_88 = 6'h16 == io_rPorts_1_req_bits_addr ? data_22 : _GEN_87; // @[]
  wire [7:0] _GEN_89 = 6'h17 == io_rPorts_1_req_bits_addr ? data_23 : _GEN_88; // @[]
  wire [7:0] _GEN_90 = 6'h18 == io_rPorts_1_req_bits_addr ? data_24 : _GEN_89; // @[]
  wire [7:0] _GEN_91 = 6'h19 == io_rPorts_1_req_bits_addr ? data_25 : _GEN_90; // @[]
  wire [7:0] _GEN_92 = 6'h1a == io_rPorts_1_req_bits_addr ? data_26 : _GEN_91; // @[]
  wire [7:0] _GEN_93 = 6'h1b == io_rPorts_1_req_bits_addr ? data_27 : _GEN_92; // @[]
  wire [7:0] _GEN_94 = 6'h1c == io_rPorts_1_req_bits_addr ? data_28 : _GEN_93; // @[]
  wire [7:0] _GEN_95 = 6'h1d == io_rPorts_1_req_bits_addr ? data_29 : _GEN_94; // @[]
  wire [7:0] _GEN_96 = 6'h1e == io_rPorts_1_req_bits_addr ? data_30 : _GEN_95; // @[]
  wire [7:0] _GEN_97 = 6'h1f == io_rPorts_1_req_bits_addr ? data_31 : _GEN_96; // @[]
  wire [7:0] _GEN_98 = 6'h20 == io_rPorts_1_req_bits_addr ? data_32 : _GEN_97; // @[]
  wire [7:0] _GEN_99 = 6'h21 == io_rPorts_1_req_bits_addr ? data_33 : _GEN_98; // @[]
  wire [7:0] _GEN_100 = 6'h22 == io_rPorts_1_req_bits_addr ? data_34 : _GEN_99; // @[]
  wire [7:0] _GEN_101 = 6'h23 == io_rPorts_1_req_bits_addr ? data_35 : _GEN_100; // @[]
  wire [7:0] _GEN_102 = 6'h24 == io_rPorts_1_req_bits_addr ? data_36 : _GEN_101; // @[]
  wire [7:0] _GEN_103 = 6'h25 == io_rPorts_1_req_bits_addr ? data_37 : _GEN_102; // @[]
  wire [7:0] _GEN_104 = 6'h26 == io_rPorts_1_req_bits_addr ? data_38 : _GEN_103; // @[]
  wire [7:0] _GEN_105 = 6'h27 == io_rPorts_1_req_bits_addr ? data_39 : _GEN_104; // @[]
  wire [7:0] _GEN_106 = 6'h28 == io_rPorts_1_req_bits_addr ? data_40 : _GEN_105; // @[]
  wire [7:0] _GEN_107 = 6'h29 == io_rPorts_1_req_bits_addr ? data_41 : _GEN_106; // @[]
  wire [7:0] _GEN_108 = 6'h2a == io_rPorts_1_req_bits_addr ? data_42 : _GEN_107; // @[]
  wire [7:0] _GEN_109 = 6'h2b == io_rPorts_1_req_bits_addr ? data_43 : _GEN_108; // @[]
  wire [7:0] _GEN_110 = 6'h2c == io_rPorts_1_req_bits_addr ? data_44 : _GEN_109; // @[]
  wire [7:0] _GEN_111 = 6'h2d == io_rPorts_1_req_bits_addr ? data_45 : _GEN_110; // @[]
  wire [7:0] _GEN_112 = 6'h2e == io_rPorts_1_req_bits_addr ? data_46 : _GEN_111; // @[]
  wire [7:0] _GEN_113 = 6'h2f == io_rPorts_1_req_bits_addr ? data_47 : _GEN_112; // @[]
  wire [7:0] _GEN_114 = 6'h30 == io_rPorts_1_req_bits_addr ? data_48 : _GEN_113; // @[]
  wire [7:0] _GEN_115 = 6'h31 == io_rPorts_1_req_bits_addr ? data_49 : _GEN_114; // @[]
  wire [7:0] _GEN_116 = 6'h32 == io_rPorts_1_req_bits_addr ? data_50 : _GEN_115; // @[]
  wire [7:0] _GEN_117 = 6'h33 == io_rPorts_1_req_bits_addr ? data_51 : _GEN_116; // @[]
  wire [7:0] _GEN_118 = 6'h34 == io_rPorts_1_req_bits_addr ? data_52 : _GEN_117; // @[]
  wire [7:0] _GEN_119 = 6'h35 == io_rPorts_1_req_bits_addr ? data_53 : _GEN_118; // @[]
  wire [7:0] _GEN_120 = 6'h36 == io_rPorts_1_req_bits_addr ? data_54 : _GEN_119; // @[]
  wire [7:0] _GEN_121 = 6'h37 == io_rPorts_1_req_bits_addr ? data_55 : _GEN_120; // @[]
  wire [7:0] _GEN_122 = 6'h38 == io_rPorts_1_req_bits_addr ? data_56 : _GEN_121; // @[]
  wire [7:0] _GEN_123 = 6'h39 == io_rPorts_1_req_bits_addr ? data_57 : _GEN_122; // @[]
  wire [7:0] _GEN_124 = 6'h3a == io_rPorts_1_req_bits_addr ? data_58 : _GEN_123; // @[]
  wire [7:0] _GEN_125 = 6'h3b == io_rPorts_1_req_bits_addr ? data_59 : _GEN_124; // @[]
  wire [7:0] _GEN_126 = 6'h3c == io_rPorts_1_req_bits_addr ? data_60 : _GEN_125; // @[]
  wire [7:0] _GEN_127 = 6'h3d == io_rPorts_1_req_bits_addr ? data_61 : _GEN_126; // @[]
  wire [7:0] _GEN_128 = 6'h3e == io_rPorts_1_req_bits_addr ? data_62 : _GEN_127; // @[]
  wire  _T_16 = io_rPorts_2_req_ready & io_rPorts_2_req_valid; // @[Decoupled.scala 40:37]
  wire [7:0] _GEN_133 = 6'h1 == io_rPorts_2_req_bits_addr ? data_1 : data_0; // @[]
  wire [7:0] _GEN_134 = 6'h2 == io_rPorts_2_req_bits_addr ? data_2 : _GEN_133; // @[]
  wire [7:0] _GEN_135 = 6'h3 == io_rPorts_2_req_bits_addr ? data_3 : _GEN_134; // @[]
  wire [7:0] _GEN_136 = 6'h4 == io_rPorts_2_req_bits_addr ? data_4 : _GEN_135; // @[]
  wire [7:0] _GEN_137 = 6'h5 == io_rPorts_2_req_bits_addr ? data_5 : _GEN_136; // @[]
  wire [7:0] _GEN_138 = 6'h6 == io_rPorts_2_req_bits_addr ? data_6 : _GEN_137; // @[]
  wire [7:0] _GEN_139 = 6'h7 == io_rPorts_2_req_bits_addr ? data_7 : _GEN_138; // @[]
  wire [7:0] _GEN_140 = 6'h8 == io_rPorts_2_req_bits_addr ? data_8 : _GEN_139; // @[]
  wire [7:0] _GEN_141 = 6'h9 == io_rPorts_2_req_bits_addr ? data_9 : _GEN_140; // @[]
  wire [7:0] _GEN_142 = 6'ha == io_rPorts_2_req_bits_addr ? data_10 : _GEN_141; // @[]
  wire [7:0] _GEN_143 = 6'hb == io_rPorts_2_req_bits_addr ? data_11 : _GEN_142; // @[]
  wire [7:0] _GEN_144 = 6'hc == io_rPorts_2_req_bits_addr ? data_12 : _GEN_143; // @[]
  wire [7:0] _GEN_145 = 6'hd == io_rPorts_2_req_bits_addr ? data_13 : _GEN_144; // @[]
  wire [7:0] _GEN_146 = 6'he == io_rPorts_2_req_bits_addr ? data_14 : _GEN_145; // @[]
  wire [7:0] _GEN_147 = 6'hf == io_rPorts_2_req_bits_addr ? data_15 : _GEN_146; // @[]
  wire [7:0] _GEN_148 = 6'h10 == io_rPorts_2_req_bits_addr ? data_16 : _GEN_147; // @[]
  wire [7:0] _GEN_149 = 6'h11 == io_rPorts_2_req_bits_addr ? data_17 : _GEN_148; // @[]
  wire [7:0] _GEN_150 = 6'h12 == io_rPorts_2_req_bits_addr ? data_18 : _GEN_149; // @[]
  wire [7:0] _GEN_151 = 6'h13 == io_rPorts_2_req_bits_addr ? data_19 : _GEN_150; // @[]
  wire [7:0] _GEN_152 = 6'h14 == io_rPorts_2_req_bits_addr ? data_20 : _GEN_151; // @[]
  wire [7:0] _GEN_153 = 6'h15 == io_rPorts_2_req_bits_addr ? data_21 : _GEN_152; // @[]
  wire [7:0] _GEN_154 = 6'h16 == io_rPorts_2_req_bits_addr ? data_22 : _GEN_153; // @[]
  wire [7:0] _GEN_155 = 6'h17 == io_rPorts_2_req_bits_addr ? data_23 : _GEN_154; // @[]
  wire [7:0] _GEN_156 = 6'h18 == io_rPorts_2_req_bits_addr ? data_24 : _GEN_155; // @[]
  wire [7:0] _GEN_157 = 6'h19 == io_rPorts_2_req_bits_addr ? data_25 : _GEN_156; // @[]
  wire [7:0] _GEN_158 = 6'h1a == io_rPorts_2_req_bits_addr ? data_26 : _GEN_157; // @[]
  wire [7:0] _GEN_159 = 6'h1b == io_rPorts_2_req_bits_addr ? data_27 : _GEN_158; // @[]
  wire [7:0] _GEN_160 = 6'h1c == io_rPorts_2_req_bits_addr ? data_28 : _GEN_159; // @[]
  wire [7:0] _GEN_161 = 6'h1d == io_rPorts_2_req_bits_addr ? data_29 : _GEN_160; // @[]
  wire [7:0] _GEN_162 = 6'h1e == io_rPorts_2_req_bits_addr ? data_30 : _GEN_161; // @[]
  wire [7:0] _GEN_163 = 6'h1f == io_rPorts_2_req_bits_addr ? data_31 : _GEN_162; // @[]
  wire [7:0] _GEN_164 = 6'h20 == io_rPorts_2_req_bits_addr ? data_32 : _GEN_163; // @[]
  wire [7:0] _GEN_165 = 6'h21 == io_rPorts_2_req_bits_addr ? data_33 : _GEN_164; // @[]
  wire [7:0] _GEN_166 = 6'h22 == io_rPorts_2_req_bits_addr ? data_34 : _GEN_165; // @[]
  wire [7:0] _GEN_167 = 6'h23 == io_rPorts_2_req_bits_addr ? data_35 : _GEN_166; // @[]
  wire [7:0] _GEN_168 = 6'h24 == io_rPorts_2_req_bits_addr ? data_36 : _GEN_167; // @[]
  wire [7:0] _GEN_169 = 6'h25 == io_rPorts_2_req_bits_addr ? data_37 : _GEN_168; // @[]
  wire [7:0] _GEN_170 = 6'h26 == io_rPorts_2_req_bits_addr ? data_38 : _GEN_169; // @[]
  wire [7:0] _GEN_171 = 6'h27 == io_rPorts_2_req_bits_addr ? data_39 : _GEN_170; // @[]
  wire [7:0] _GEN_172 = 6'h28 == io_rPorts_2_req_bits_addr ? data_40 : _GEN_171; // @[]
  wire [7:0] _GEN_173 = 6'h29 == io_rPorts_2_req_bits_addr ? data_41 : _GEN_172; // @[]
  wire [7:0] _GEN_174 = 6'h2a == io_rPorts_2_req_bits_addr ? data_42 : _GEN_173; // @[]
  wire [7:0] _GEN_175 = 6'h2b == io_rPorts_2_req_bits_addr ? data_43 : _GEN_174; // @[]
  wire [7:0] _GEN_176 = 6'h2c == io_rPorts_2_req_bits_addr ? data_44 : _GEN_175; // @[]
  wire [7:0] _GEN_177 = 6'h2d == io_rPorts_2_req_bits_addr ? data_45 : _GEN_176; // @[]
  wire [7:0] _GEN_178 = 6'h2e == io_rPorts_2_req_bits_addr ? data_46 : _GEN_177; // @[]
  wire [7:0] _GEN_179 = 6'h2f == io_rPorts_2_req_bits_addr ? data_47 : _GEN_178; // @[]
  wire [7:0] _GEN_180 = 6'h30 == io_rPorts_2_req_bits_addr ? data_48 : _GEN_179; // @[]
  wire [7:0] _GEN_181 = 6'h31 == io_rPorts_2_req_bits_addr ? data_49 : _GEN_180; // @[]
  wire [7:0] _GEN_182 = 6'h32 == io_rPorts_2_req_bits_addr ? data_50 : _GEN_181; // @[]
  wire [7:0] _GEN_183 = 6'h33 == io_rPorts_2_req_bits_addr ? data_51 : _GEN_182; // @[]
  wire [7:0] _GEN_184 = 6'h34 == io_rPorts_2_req_bits_addr ? data_52 : _GEN_183; // @[]
  wire [7:0] _GEN_185 = 6'h35 == io_rPorts_2_req_bits_addr ? data_53 : _GEN_184; // @[]
  wire [7:0] _GEN_186 = 6'h36 == io_rPorts_2_req_bits_addr ? data_54 : _GEN_185; // @[]
  wire [7:0] _GEN_187 = 6'h37 == io_rPorts_2_req_bits_addr ? data_55 : _GEN_186; // @[]
  wire [7:0] _GEN_188 = 6'h38 == io_rPorts_2_req_bits_addr ? data_56 : _GEN_187; // @[]
  wire [7:0] _GEN_189 = 6'h39 == io_rPorts_2_req_bits_addr ? data_57 : _GEN_188; // @[]
  wire [7:0] _GEN_190 = 6'h3a == io_rPorts_2_req_bits_addr ? data_58 : _GEN_189; // @[]
  wire [7:0] _GEN_191 = 6'h3b == io_rPorts_2_req_bits_addr ? data_59 : _GEN_190; // @[]
  wire [7:0] _GEN_192 = 6'h3c == io_rPorts_2_req_bits_addr ? data_60 : _GEN_191; // @[]
  wire [7:0] _GEN_193 = 6'h3d == io_rPorts_2_req_bits_addr ? data_61 : _GEN_192; // @[]
  wire [7:0] _GEN_194 = 6'h3e == io_rPorts_2_req_bits_addr ? data_62 : _GEN_193; // @[]
  wire  _T_24 = io_rPorts_3_req_ready & io_rPorts_3_req_valid; // @[Decoupled.scala 40:37]
  wire [7:0] _GEN_199 = 6'h1 == io_rPorts_3_req_bits_addr ? data_1 : data_0; // @[]
  wire [7:0] _GEN_200 = 6'h2 == io_rPorts_3_req_bits_addr ? data_2 : _GEN_199; // @[]
  wire [7:0] _GEN_201 = 6'h3 == io_rPorts_3_req_bits_addr ? data_3 : _GEN_200; // @[]
  wire [7:0] _GEN_202 = 6'h4 == io_rPorts_3_req_bits_addr ? data_4 : _GEN_201; // @[]
  wire [7:0] _GEN_203 = 6'h5 == io_rPorts_3_req_bits_addr ? data_5 : _GEN_202; // @[]
  wire [7:0] _GEN_204 = 6'h6 == io_rPorts_3_req_bits_addr ? data_6 : _GEN_203; // @[]
  wire [7:0] _GEN_205 = 6'h7 == io_rPorts_3_req_bits_addr ? data_7 : _GEN_204; // @[]
  wire [7:0] _GEN_206 = 6'h8 == io_rPorts_3_req_bits_addr ? data_8 : _GEN_205; // @[]
  wire [7:0] _GEN_207 = 6'h9 == io_rPorts_3_req_bits_addr ? data_9 : _GEN_206; // @[]
  wire [7:0] _GEN_208 = 6'ha == io_rPorts_3_req_bits_addr ? data_10 : _GEN_207; // @[]
  wire [7:0] _GEN_209 = 6'hb == io_rPorts_3_req_bits_addr ? data_11 : _GEN_208; // @[]
  wire [7:0] _GEN_210 = 6'hc == io_rPorts_3_req_bits_addr ? data_12 : _GEN_209; // @[]
  wire [7:0] _GEN_211 = 6'hd == io_rPorts_3_req_bits_addr ? data_13 : _GEN_210; // @[]
  wire [7:0] _GEN_212 = 6'he == io_rPorts_3_req_bits_addr ? data_14 : _GEN_211; // @[]
  wire [7:0] _GEN_213 = 6'hf == io_rPorts_3_req_bits_addr ? data_15 : _GEN_212; // @[]
  wire [7:0] _GEN_214 = 6'h10 == io_rPorts_3_req_bits_addr ? data_16 : _GEN_213; // @[]
  wire [7:0] _GEN_215 = 6'h11 == io_rPorts_3_req_bits_addr ? data_17 : _GEN_214; // @[]
  wire [7:0] _GEN_216 = 6'h12 == io_rPorts_3_req_bits_addr ? data_18 : _GEN_215; // @[]
  wire [7:0] _GEN_217 = 6'h13 == io_rPorts_3_req_bits_addr ? data_19 : _GEN_216; // @[]
  wire [7:0] _GEN_218 = 6'h14 == io_rPorts_3_req_bits_addr ? data_20 : _GEN_217; // @[]
  wire [7:0] _GEN_219 = 6'h15 == io_rPorts_3_req_bits_addr ? data_21 : _GEN_218; // @[]
  wire [7:0] _GEN_220 = 6'h16 == io_rPorts_3_req_bits_addr ? data_22 : _GEN_219; // @[]
  wire [7:0] _GEN_221 = 6'h17 == io_rPorts_3_req_bits_addr ? data_23 : _GEN_220; // @[]
  wire [7:0] _GEN_222 = 6'h18 == io_rPorts_3_req_bits_addr ? data_24 : _GEN_221; // @[]
  wire [7:0] _GEN_223 = 6'h19 == io_rPorts_3_req_bits_addr ? data_25 : _GEN_222; // @[]
  wire [7:0] _GEN_224 = 6'h1a == io_rPorts_3_req_bits_addr ? data_26 : _GEN_223; // @[]
  wire [7:0] _GEN_225 = 6'h1b == io_rPorts_3_req_bits_addr ? data_27 : _GEN_224; // @[]
  wire [7:0] _GEN_226 = 6'h1c == io_rPorts_3_req_bits_addr ? data_28 : _GEN_225; // @[]
  wire [7:0] _GEN_227 = 6'h1d == io_rPorts_3_req_bits_addr ? data_29 : _GEN_226; // @[]
  wire [7:0] _GEN_228 = 6'h1e == io_rPorts_3_req_bits_addr ? data_30 : _GEN_227; // @[]
  wire [7:0] _GEN_229 = 6'h1f == io_rPorts_3_req_bits_addr ? data_31 : _GEN_228; // @[]
  wire [7:0] _GEN_230 = 6'h20 == io_rPorts_3_req_bits_addr ? data_32 : _GEN_229; // @[]
  wire [7:0] _GEN_231 = 6'h21 == io_rPorts_3_req_bits_addr ? data_33 : _GEN_230; // @[]
  wire [7:0] _GEN_232 = 6'h22 == io_rPorts_3_req_bits_addr ? data_34 : _GEN_231; // @[]
  wire [7:0] _GEN_233 = 6'h23 == io_rPorts_3_req_bits_addr ? data_35 : _GEN_232; // @[]
  wire [7:0] _GEN_234 = 6'h24 == io_rPorts_3_req_bits_addr ? data_36 : _GEN_233; // @[]
  wire [7:0] _GEN_235 = 6'h25 == io_rPorts_3_req_bits_addr ? data_37 : _GEN_234; // @[]
  wire [7:0] _GEN_236 = 6'h26 == io_rPorts_3_req_bits_addr ? data_38 : _GEN_235; // @[]
  wire [7:0] _GEN_237 = 6'h27 == io_rPorts_3_req_bits_addr ? data_39 : _GEN_236; // @[]
  wire [7:0] _GEN_238 = 6'h28 == io_rPorts_3_req_bits_addr ? data_40 : _GEN_237; // @[]
  wire [7:0] _GEN_239 = 6'h29 == io_rPorts_3_req_bits_addr ? data_41 : _GEN_238; // @[]
  wire [7:0] _GEN_240 = 6'h2a == io_rPorts_3_req_bits_addr ? data_42 : _GEN_239; // @[]
  wire [7:0] _GEN_241 = 6'h2b == io_rPorts_3_req_bits_addr ? data_43 : _GEN_240; // @[]
  wire [7:0] _GEN_242 = 6'h2c == io_rPorts_3_req_bits_addr ? data_44 : _GEN_241; // @[]
  wire [7:0] _GEN_243 = 6'h2d == io_rPorts_3_req_bits_addr ? data_45 : _GEN_242; // @[]
  wire [7:0] _GEN_244 = 6'h2e == io_rPorts_3_req_bits_addr ? data_46 : _GEN_243; // @[]
  wire [7:0] _GEN_245 = 6'h2f == io_rPorts_3_req_bits_addr ? data_47 : _GEN_244; // @[]
  wire [7:0] _GEN_246 = 6'h30 == io_rPorts_3_req_bits_addr ? data_48 : _GEN_245; // @[]
  wire [7:0] _GEN_247 = 6'h31 == io_rPorts_3_req_bits_addr ? data_49 : _GEN_246; // @[]
  wire [7:0] _GEN_248 = 6'h32 == io_rPorts_3_req_bits_addr ? data_50 : _GEN_247; // @[]
  wire [7:0] _GEN_249 = 6'h33 == io_rPorts_3_req_bits_addr ? data_51 : _GEN_248; // @[]
  wire [7:0] _GEN_250 = 6'h34 == io_rPorts_3_req_bits_addr ? data_52 : _GEN_249; // @[]
  wire [7:0] _GEN_251 = 6'h35 == io_rPorts_3_req_bits_addr ? data_53 : _GEN_250; // @[]
  wire [7:0] _GEN_252 = 6'h36 == io_rPorts_3_req_bits_addr ? data_54 : _GEN_251; // @[]
  wire [7:0] _GEN_253 = 6'h37 == io_rPorts_3_req_bits_addr ? data_55 : _GEN_252; // @[]
  wire [7:0] _GEN_254 = 6'h38 == io_rPorts_3_req_bits_addr ? data_56 : _GEN_253; // @[]
  wire [7:0] _GEN_255 = 6'h39 == io_rPorts_3_req_bits_addr ? data_57 : _GEN_254; // @[]
  wire [7:0] _GEN_256 = 6'h3a == io_rPorts_3_req_bits_addr ? data_58 : _GEN_255; // @[]
  wire [7:0] _GEN_257 = 6'h3b == io_rPorts_3_req_bits_addr ? data_59 : _GEN_256; // @[]
  wire [7:0] _GEN_258 = 6'h3c == io_rPorts_3_req_bits_addr ? data_60 : _GEN_257; // @[]
  wire [7:0] _GEN_259 = 6'h3d == io_rPorts_3_req_bits_addr ? data_61 : _GEN_258; // @[]
  wire [7:0] _GEN_260 = 6'h3e == io_rPorts_3_req_bits_addr ? data_62 : _GEN_259; // @[]
  wire  _T_32 = io_rPorts_4_req_ready & io_rPorts_4_req_valid; // @[Decoupled.scala 40:37]
  wire [7:0] _GEN_265 = 6'h1 == io_rPorts_4_req_bits_addr ? data_1 : data_0; // @[]
  wire [7:0] _GEN_266 = 6'h2 == io_rPorts_4_req_bits_addr ? data_2 : _GEN_265; // @[]
  wire [7:0] _GEN_267 = 6'h3 == io_rPorts_4_req_bits_addr ? data_3 : _GEN_266; // @[]
  wire [7:0] _GEN_268 = 6'h4 == io_rPorts_4_req_bits_addr ? data_4 : _GEN_267; // @[]
  wire [7:0] _GEN_269 = 6'h5 == io_rPorts_4_req_bits_addr ? data_5 : _GEN_268; // @[]
  wire [7:0] _GEN_270 = 6'h6 == io_rPorts_4_req_bits_addr ? data_6 : _GEN_269; // @[]
  wire [7:0] _GEN_271 = 6'h7 == io_rPorts_4_req_bits_addr ? data_7 : _GEN_270; // @[]
  wire [7:0] _GEN_272 = 6'h8 == io_rPorts_4_req_bits_addr ? data_8 : _GEN_271; // @[]
  wire [7:0] _GEN_273 = 6'h9 == io_rPorts_4_req_bits_addr ? data_9 : _GEN_272; // @[]
  wire [7:0] _GEN_274 = 6'ha == io_rPorts_4_req_bits_addr ? data_10 : _GEN_273; // @[]
  wire [7:0] _GEN_275 = 6'hb == io_rPorts_4_req_bits_addr ? data_11 : _GEN_274; // @[]
  wire [7:0] _GEN_276 = 6'hc == io_rPorts_4_req_bits_addr ? data_12 : _GEN_275; // @[]
  wire [7:0] _GEN_277 = 6'hd == io_rPorts_4_req_bits_addr ? data_13 : _GEN_276; // @[]
  wire [7:0] _GEN_278 = 6'he == io_rPorts_4_req_bits_addr ? data_14 : _GEN_277; // @[]
  wire [7:0] _GEN_279 = 6'hf == io_rPorts_4_req_bits_addr ? data_15 : _GEN_278; // @[]
  wire [7:0] _GEN_280 = 6'h10 == io_rPorts_4_req_bits_addr ? data_16 : _GEN_279; // @[]
  wire [7:0] _GEN_281 = 6'h11 == io_rPorts_4_req_bits_addr ? data_17 : _GEN_280; // @[]
  wire [7:0] _GEN_282 = 6'h12 == io_rPorts_4_req_bits_addr ? data_18 : _GEN_281; // @[]
  wire [7:0] _GEN_283 = 6'h13 == io_rPorts_4_req_bits_addr ? data_19 : _GEN_282; // @[]
  wire [7:0] _GEN_284 = 6'h14 == io_rPorts_4_req_bits_addr ? data_20 : _GEN_283; // @[]
  wire [7:0] _GEN_285 = 6'h15 == io_rPorts_4_req_bits_addr ? data_21 : _GEN_284; // @[]
  wire [7:0] _GEN_286 = 6'h16 == io_rPorts_4_req_bits_addr ? data_22 : _GEN_285; // @[]
  wire [7:0] _GEN_287 = 6'h17 == io_rPorts_4_req_bits_addr ? data_23 : _GEN_286; // @[]
  wire [7:0] _GEN_288 = 6'h18 == io_rPorts_4_req_bits_addr ? data_24 : _GEN_287; // @[]
  wire [7:0] _GEN_289 = 6'h19 == io_rPorts_4_req_bits_addr ? data_25 : _GEN_288; // @[]
  wire [7:0] _GEN_290 = 6'h1a == io_rPorts_4_req_bits_addr ? data_26 : _GEN_289; // @[]
  wire [7:0] _GEN_291 = 6'h1b == io_rPorts_4_req_bits_addr ? data_27 : _GEN_290; // @[]
  wire [7:0] _GEN_292 = 6'h1c == io_rPorts_4_req_bits_addr ? data_28 : _GEN_291; // @[]
  wire [7:0] _GEN_293 = 6'h1d == io_rPorts_4_req_bits_addr ? data_29 : _GEN_292; // @[]
  wire [7:0] _GEN_294 = 6'h1e == io_rPorts_4_req_bits_addr ? data_30 : _GEN_293; // @[]
  wire [7:0] _GEN_295 = 6'h1f == io_rPorts_4_req_bits_addr ? data_31 : _GEN_294; // @[]
  wire [7:0] _GEN_296 = 6'h20 == io_rPorts_4_req_bits_addr ? data_32 : _GEN_295; // @[]
  wire [7:0] _GEN_297 = 6'h21 == io_rPorts_4_req_bits_addr ? data_33 : _GEN_296; // @[]
  wire [7:0] _GEN_298 = 6'h22 == io_rPorts_4_req_bits_addr ? data_34 : _GEN_297; // @[]
  wire [7:0] _GEN_299 = 6'h23 == io_rPorts_4_req_bits_addr ? data_35 : _GEN_298; // @[]
  wire [7:0] _GEN_300 = 6'h24 == io_rPorts_4_req_bits_addr ? data_36 : _GEN_299; // @[]
  wire [7:0] _GEN_301 = 6'h25 == io_rPorts_4_req_bits_addr ? data_37 : _GEN_300; // @[]
  wire [7:0] _GEN_302 = 6'h26 == io_rPorts_4_req_bits_addr ? data_38 : _GEN_301; // @[]
  wire [7:0] _GEN_303 = 6'h27 == io_rPorts_4_req_bits_addr ? data_39 : _GEN_302; // @[]
  wire [7:0] _GEN_304 = 6'h28 == io_rPorts_4_req_bits_addr ? data_40 : _GEN_303; // @[]
  wire [7:0] _GEN_305 = 6'h29 == io_rPorts_4_req_bits_addr ? data_41 : _GEN_304; // @[]
  wire [7:0] _GEN_306 = 6'h2a == io_rPorts_4_req_bits_addr ? data_42 : _GEN_305; // @[]
  wire [7:0] _GEN_307 = 6'h2b == io_rPorts_4_req_bits_addr ? data_43 : _GEN_306; // @[]
  wire [7:0] _GEN_308 = 6'h2c == io_rPorts_4_req_bits_addr ? data_44 : _GEN_307; // @[]
  wire [7:0] _GEN_309 = 6'h2d == io_rPorts_4_req_bits_addr ? data_45 : _GEN_308; // @[]
  wire [7:0] _GEN_310 = 6'h2e == io_rPorts_4_req_bits_addr ? data_46 : _GEN_309; // @[]
  wire [7:0] _GEN_311 = 6'h2f == io_rPorts_4_req_bits_addr ? data_47 : _GEN_310; // @[]
  wire [7:0] _GEN_312 = 6'h30 == io_rPorts_4_req_bits_addr ? data_48 : _GEN_311; // @[]
  wire [7:0] _GEN_313 = 6'h31 == io_rPorts_4_req_bits_addr ? data_49 : _GEN_312; // @[]
  wire [7:0] _GEN_314 = 6'h32 == io_rPorts_4_req_bits_addr ? data_50 : _GEN_313; // @[]
  wire [7:0] _GEN_315 = 6'h33 == io_rPorts_4_req_bits_addr ? data_51 : _GEN_314; // @[]
  wire [7:0] _GEN_316 = 6'h34 == io_rPorts_4_req_bits_addr ? data_52 : _GEN_315; // @[]
  wire [7:0] _GEN_317 = 6'h35 == io_rPorts_4_req_bits_addr ? data_53 : _GEN_316; // @[]
  wire [7:0] _GEN_318 = 6'h36 == io_rPorts_4_req_bits_addr ? data_54 : _GEN_317; // @[]
  wire [7:0] _GEN_319 = 6'h37 == io_rPorts_4_req_bits_addr ? data_55 : _GEN_318; // @[]
  wire [7:0] _GEN_320 = 6'h38 == io_rPorts_4_req_bits_addr ? data_56 : _GEN_319; // @[]
  wire [7:0] _GEN_321 = 6'h39 == io_rPorts_4_req_bits_addr ? data_57 : _GEN_320; // @[]
  wire [7:0] _GEN_322 = 6'h3a == io_rPorts_4_req_bits_addr ? data_58 : _GEN_321; // @[]
  wire [7:0] _GEN_323 = 6'h3b == io_rPorts_4_req_bits_addr ? data_59 : _GEN_322; // @[]
  wire [7:0] _GEN_324 = 6'h3c == io_rPorts_4_req_bits_addr ? data_60 : _GEN_323; // @[]
  wire [7:0] _GEN_325 = 6'h3d == io_rPorts_4_req_bits_addr ? data_61 : _GEN_324; // @[]
  wire [7:0] _GEN_326 = 6'h3e == io_rPorts_4_req_bits_addr ? data_62 : _GEN_325; // @[]
  wire  _T_40 = io_rPorts_5_req_ready & io_rPorts_5_req_valid; // @[Decoupled.scala 40:37]
  wire [7:0] _GEN_331 = 6'h1 == io_rPorts_5_req_bits_addr ? data_1 : data_0; // @[]
  wire [7:0] _GEN_332 = 6'h2 == io_rPorts_5_req_bits_addr ? data_2 : _GEN_331; // @[]
  wire [7:0] _GEN_333 = 6'h3 == io_rPorts_5_req_bits_addr ? data_3 : _GEN_332; // @[]
  wire [7:0] _GEN_334 = 6'h4 == io_rPorts_5_req_bits_addr ? data_4 : _GEN_333; // @[]
  wire [7:0] _GEN_335 = 6'h5 == io_rPorts_5_req_bits_addr ? data_5 : _GEN_334; // @[]
  wire [7:0] _GEN_336 = 6'h6 == io_rPorts_5_req_bits_addr ? data_6 : _GEN_335; // @[]
  wire [7:0] _GEN_337 = 6'h7 == io_rPorts_5_req_bits_addr ? data_7 : _GEN_336; // @[]
  wire [7:0] _GEN_338 = 6'h8 == io_rPorts_5_req_bits_addr ? data_8 : _GEN_337; // @[]
  wire [7:0] _GEN_339 = 6'h9 == io_rPorts_5_req_bits_addr ? data_9 : _GEN_338; // @[]
  wire [7:0] _GEN_340 = 6'ha == io_rPorts_5_req_bits_addr ? data_10 : _GEN_339; // @[]
  wire [7:0] _GEN_341 = 6'hb == io_rPorts_5_req_bits_addr ? data_11 : _GEN_340; // @[]
  wire [7:0] _GEN_342 = 6'hc == io_rPorts_5_req_bits_addr ? data_12 : _GEN_341; // @[]
  wire [7:0] _GEN_343 = 6'hd == io_rPorts_5_req_bits_addr ? data_13 : _GEN_342; // @[]
  wire [7:0] _GEN_344 = 6'he == io_rPorts_5_req_bits_addr ? data_14 : _GEN_343; // @[]
  wire [7:0] _GEN_345 = 6'hf == io_rPorts_5_req_bits_addr ? data_15 : _GEN_344; // @[]
  wire [7:0] _GEN_346 = 6'h10 == io_rPorts_5_req_bits_addr ? data_16 : _GEN_345; // @[]
  wire [7:0] _GEN_347 = 6'h11 == io_rPorts_5_req_bits_addr ? data_17 : _GEN_346; // @[]
  wire [7:0] _GEN_348 = 6'h12 == io_rPorts_5_req_bits_addr ? data_18 : _GEN_347; // @[]
  wire [7:0] _GEN_349 = 6'h13 == io_rPorts_5_req_bits_addr ? data_19 : _GEN_348; // @[]
  wire [7:0] _GEN_350 = 6'h14 == io_rPorts_5_req_bits_addr ? data_20 : _GEN_349; // @[]
  wire [7:0] _GEN_351 = 6'h15 == io_rPorts_5_req_bits_addr ? data_21 : _GEN_350; // @[]
  wire [7:0] _GEN_352 = 6'h16 == io_rPorts_5_req_bits_addr ? data_22 : _GEN_351; // @[]
  wire [7:0] _GEN_353 = 6'h17 == io_rPorts_5_req_bits_addr ? data_23 : _GEN_352; // @[]
  wire [7:0] _GEN_354 = 6'h18 == io_rPorts_5_req_bits_addr ? data_24 : _GEN_353; // @[]
  wire [7:0] _GEN_355 = 6'h19 == io_rPorts_5_req_bits_addr ? data_25 : _GEN_354; // @[]
  wire [7:0] _GEN_356 = 6'h1a == io_rPorts_5_req_bits_addr ? data_26 : _GEN_355; // @[]
  wire [7:0] _GEN_357 = 6'h1b == io_rPorts_5_req_bits_addr ? data_27 : _GEN_356; // @[]
  wire [7:0] _GEN_358 = 6'h1c == io_rPorts_5_req_bits_addr ? data_28 : _GEN_357; // @[]
  wire [7:0] _GEN_359 = 6'h1d == io_rPorts_5_req_bits_addr ? data_29 : _GEN_358; // @[]
  wire [7:0] _GEN_360 = 6'h1e == io_rPorts_5_req_bits_addr ? data_30 : _GEN_359; // @[]
  wire [7:0] _GEN_361 = 6'h1f == io_rPorts_5_req_bits_addr ? data_31 : _GEN_360; // @[]
  wire [7:0] _GEN_362 = 6'h20 == io_rPorts_5_req_bits_addr ? data_32 : _GEN_361; // @[]
  wire [7:0] _GEN_363 = 6'h21 == io_rPorts_5_req_bits_addr ? data_33 : _GEN_362; // @[]
  wire [7:0] _GEN_364 = 6'h22 == io_rPorts_5_req_bits_addr ? data_34 : _GEN_363; // @[]
  wire [7:0] _GEN_365 = 6'h23 == io_rPorts_5_req_bits_addr ? data_35 : _GEN_364; // @[]
  wire [7:0] _GEN_366 = 6'h24 == io_rPorts_5_req_bits_addr ? data_36 : _GEN_365; // @[]
  wire [7:0] _GEN_367 = 6'h25 == io_rPorts_5_req_bits_addr ? data_37 : _GEN_366; // @[]
  wire [7:0] _GEN_368 = 6'h26 == io_rPorts_5_req_bits_addr ? data_38 : _GEN_367; // @[]
  wire [7:0] _GEN_369 = 6'h27 == io_rPorts_5_req_bits_addr ? data_39 : _GEN_368; // @[]
  wire [7:0] _GEN_370 = 6'h28 == io_rPorts_5_req_bits_addr ? data_40 : _GEN_369; // @[]
  wire [7:0] _GEN_371 = 6'h29 == io_rPorts_5_req_bits_addr ? data_41 : _GEN_370; // @[]
  wire [7:0] _GEN_372 = 6'h2a == io_rPorts_5_req_bits_addr ? data_42 : _GEN_371; // @[]
  wire [7:0] _GEN_373 = 6'h2b == io_rPorts_5_req_bits_addr ? data_43 : _GEN_372; // @[]
  wire [7:0] _GEN_374 = 6'h2c == io_rPorts_5_req_bits_addr ? data_44 : _GEN_373; // @[]
  wire [7:0] _GEN_375 = 6'h2d == io_rPorts_5_req_bits_addr ? data_45 : _GEN_374; // @[]
  wire [7:0] _GEN_376 = 6'h2e == io_rPorts_5_req_bits_addr ? data_46 : _GEN_375; // @[]
  wire [7:0] _GEN_377 = 6'h2f == io_rPorts_5_req_bits_addr ? data_47 : _GEN_376; // @[]
  wire [7:0] _GEN_378 = 6'h30 == io_rPorts_5_req_bits_addr ? data_48 : _GEN_377; // @[]
  wire [7:0] _GEN_379 = 6'h31 == io_rPorts_5_req_bits_addr ? data_49 : _GEN_378; // @[]
  wire [7:0] _GEN_380 = 6'h32 == io_rPorts_5_req_bits_addr ? data_50 : _GEN_379; // @[]
  wire [7:0] _GEN_381 = 6'h33 == io_rPorts_5_req_bits_addr ? data_51 : _GEN_380; // @[]
  wire [7:0] _GEN_382 = 6'h34 == io_rPorts_5_req_bits_addr ? data_52 : _GEN_381; // @[]
  wire [7:0] _GEN_383 = 6'h35 == io_rPorts_5_req_bits_addr ? data_53 : _GEN_382; // @[]
  wire [7:0] _GEN_384 = 6'h36 == io_rPorts_5_req_bits_addr ? data_54 : _GEN_383; // @[]
  wire [7:0] _GEN_385 = 6'h37 == io_rPorts_5_req_bits_addr ? data_55 : _GEN_384; // @[]
  wire [7:0] _GEN_386 = 6'h38 == io_rPorts_5_req_bits_addr ? data_56 : _GEN_385; // @[]
  wire [7:0] _GEN_387 = 6'h39 == io_rPorts_5_req_bits_addr ? data_57 : _GEN_386; // @[]
  wire [7:0] _GEN_388 = 6'h3a == io_rPorts_5_req_bits_addr ? data_58 : _GEN_387; // @[]
  wire [7:0] _GEN_389 = 6'h3b == io_rPorts_5_req_bits_addr ? data_59 : _GEN_388; // @[]
  wire [7:0] _GEN_390 = 6'h3c == io_rPorts_5_req_bits_addr ? data_60 : _GEN_389; // @[]
  wire [7:0] _GEN_391 = 6'h3d == io_rPorts_5_req_bits_addr ? data_61 : _GEN_390; // @[]
  wire [7:0] _GEN_392 = 6'h3e == io_rPorts_5_req_bits_addr ? data_62 : _GEN_391; // @[]
  wire  _T_48 = io_rPorts_6_req_ready & io_rPorts_6_req_valid; // @[Decoupled.scala 40:37]
  wire [7:0] _GEN_397 = 6'h1 == io_rPorts_6_req_bits_addr ? data_1 : data_0; // @[]
  wire [7:0] _GEN_398 = 6'h2 == io_rPorts_6_req_bits_addr ? data_2 : _GEN_397; // @[]
  wire [7:0] _GEN_399 = 6'h3 == io_rPorts_6_req_bits_addr ? data_3 : _GEN_398; // @[]
  wire [7:0] _GEN_400 = 6'h4 == io_rPorts_6_req_bits_addr ? data_4 : _GEN_399; // @[]
  wire [7:0] _GEN_401 = 6'h5 == io_rPorts_6_req_bits_addr ? data_5 : _GEN_400; // @[]
  wire [7:0] _GEN_402 = 6'h6 == io_rPorts_6_req_bits_addr ? data_6 : _GEN_401; // @[]
  wire [7:0] _GEN_403 = 6'h7 == io_rPorts_6_req_bits_addr ? data_7 : _GEN_402; // @[]
  wire [7:0] _GEN_404 = 6'h8 == io_rPorts_6_req_bits_addr ? data_8 : _GEN_403; // @[]
  wire [7:0] _GEN_405 = 6'h9 == io_rPorts_6_req_bits_addr ? data_9 : _GEN_404; // @[]
  wire [7:0] _GEN_406 = 6'ha == io_rPorts_6_req_bits_addr ? data_10 : _GEN_405; // @[]
  wire [7:0] _GEN_407 = 6'hb == io_rPorts_6_req_bits_addr ? data_11 : _GEN_406; // @[]
  wire [7:0] _GEN_408 = 6'hc == io_rPorts_6_req_bits_addr ? data_12 : _GEN_407; // @[]
  wire [7:0] _GEN_409 = 6'hd == io_rPorts_6_req_bits_addr ? data_13 : _GEN_408; // @[]
  wire [7:0] _GEN_410 = 6'he == io_rPorts_6_req_bits_addr ? data_14 : _GEN_409; // @[]
  wire [7:0] _GEN_411 = 6'hf == io_rPorts_6_req_bits_addr ? data_15 : _GEN_410; // @[]
  wire [7:0] _GEN_412 = 6'h10 == io_rPorts_6_req_bits_addr ? data_16 : _GEN_411; // @[]
  wire [7:0] _GEN_413 = 6'h11 == io_rPorts_6_req_bits_addr ? data_17 : _GEN_412; // @[]
  wire [7:0] _GEN_414 = 6'h12 == io_rPorts_6_req_bits_addr ? data_18 : _GEN_413; // @[]
  wire [7:0] _GEN_415 = 6'h13 == io_rPorts_6_req_bits_addr ? data_19 : _GEN_414; // @[]
  wire [7:0] _GEN_416 = 6'h14 == io_rPorts_6_req_bits_addr ? data_20 : _GEN_415; // @[]
  wire [7:0] _GEN_417 = 6'h15 == io_rPorts_6_req_bits_addr ? data_21 : _GEN_416; // @[]
  wire [7:0] _GEN_418 = 6'h16 == io_rPorts_6_req_bits_addr ? data_22 : _GEN_417; // @[]
  wire [7:0] _GEN_419 = 6'h17 == io_rPorts_6_req_bits_addr ? data_23 : _GEN_418; // @[]
  wire [7:0] _GEN_420 = 6'h18 == io_rPorts_6_req_bits_addr ? data_24 : _GEN_419; // @[]
  wire [7:0] _GEN_421 = 6'h19 == io_rPorts_6_req_bits_addr ? data_25 : _GEN_420; // @[]
  wire [7:0] _GEN_422 = 6'h1a == io_rPorts_6_req_bits_addr ? data_26 : _GEN_421; // @[]
  wire [7:0] _GEN_423 = 6'h1b == io_rPorts_6_req_bits_addr ? data_27 : _GEN_422; // @[]
  wire [7:0] _GEN_424 = 6'h1c == io_rPorts_6_req_bits_addr ? data_28 : _GEN_423; // @[]
  wire [7:0] _GEN_425 = 6'h1d == io_rPorts_6_req_bits_addr ? data_29 : _GEN_424; // @[]
  wire [7:0] _GEN_426 = 6'h1e == io_rPorts_6_req_bits_addr ? data_30 : _GEN_425; // @[]
  wire [7:0] _GEN_427 = 6'h1f == io_rPorts_6_req_bits_addr ? data_31 : _GEN_426; // @[]
  wire [7:0] _GEN_428 = 6'h20 == io_rPorts_6_req_bits_addr ? data_32 : _GEN_427; // @[]
  wire [7:0] _GEN_429 = 6'h21 == io_rPorts_6_req_bits_addr ? data_33 : _GEN_428; // @[]
  wire [7:0] _GEN_430 = 6'h22 == io_rPorts_6_req_bits_addr ? data_34 : _GEN_429; // @[]
  wire [7:0] _GEN_431 = 6'h23 == io_rPorts_6_req_bits_addr ? data_35 : _GEN_430; // @[]
  wire [7:0] _GEN_432 = 6'h24 == io_rPorts_6_req_bits_addr ? data_36 : _GEN_431; // @[]
  wire [7:0] _GEN_433 = 6'h25 == io_rPorts_6_req_bits_addr ? data_37 : _GEN_432; // @[]
  wire [7:0] _GEN_434 = 6'h26 == io_rPorts_6_req_bits_addr ? data_38 : _GEN_433; // @[]
  wire [7:0] _GEN_435 = 6'h27 == io_rPorts_6_req_bits_addr ? data_39 : _GEN_434; // @[]
  wire [7:0] _GEN_436 = 6'h28 == io_rPorts_6_req_bits_addr ? data_40 : _GEN_435; // @[]
  wire [7:0] _GEN_437 = 6'h29 == io_rPorts_6_req_bits_addr ? data_41 : _GEN_436; // @[]
  wire [7:0] _GEN_438 = 6'h2a == io_rPorts_6_req_bits_addr ? data_42 : _GEN_437; // @[]
  wire [7:0] _GEN_439 = 6'h2b == io_rPorts_6_req_bits_addr ? data_43 : _GEN_438; // @[]
  wire [7:0] _GEN_440 = 6'h2c == io_rPorts_6_req_bits_addr ? data_44 : _GEN_439; // @[]
  wire [7:0] _GEN_441 = 6'h2d == io_rPorts_6_req_bits_addr ? data_45 : _GEN_440; // @[]
  wire [7:0] _GEN_442 = 6'h2e == io_rPorts_6_req_bits_addr ? data_46 : _GEN_441; // @[]
  wire [7:0] _GEN_443 = 6'h2f == io_rPorts_6_req_bits_addr ? data_47 : _GEN_442; // @[]
  wire [7:0] _GEN_444 = 6'h30 == io_rPorts_6_req_bits_addr ? data_48 : _GEN_443; // @[]
  wire [7:0] _GEN_445 = 6'h31 == io_rPorts_6_req_bits_addr ? data_49 : _GEN_444; // @[]
  wire [7:0] _GEN_446 = 6'h32 == io_rPorts_6_req_bits_addr ? data_50 : _GEN_445; // @[]
  wire [7:0] _GEN_447 = 6'h33 == io_rPorts_6_req_bits_addr ? data_51 : _GEN_446; // @[]
  wire [7:0] _GEN_448 = 6'h34 == io_rPorts_6_req_bits_addr ? data_52 : _GEN_447; // @[]
  wire [7:0] _GEN_449 = 6'h35 == io_rPorts_6_req_bits_addr ? data_53 : _GEN_448; // @[]
  wire [7:0] _GEN_450 = 6'h36 == io_rPorts_6_req_bits_addr ? data_54 : _GEN_449; // @[]
  wire [7:0] _GEN_451 = 6'h37 == io_rPorts_6_req_bits_addr ? data_55 : _GEN_450; // @[]
  wire [7:0] _GEN_452 = 6'h38 == io_rPorts_6_req_bits_addr ? data_56 : _GEN_451; // @[]
  wire [7:0] _GEN_453 = 6'h39 == io_rPorts_6_req_bits_addr ? data_57 : _GEN_452; // @[]
  wire [7:0] _GEN_454 = 6'h3a == io_rPorts_6_req_bits_addr ? data_58 : _GEN_453; // @[]
  wire [7:0] _GEN_455 = 6'h3b == io_rPorts_6_req_bits_addr ? data_59 : _GEN_454; // @[]
  wire [7:0] _GEN_456 = 6'h3c == io_rPorts_6_req_bits_addr ? data_60 : _GEN_455; // @[]
  wire [7:0] _GEN_457 = 6'h3d == io_rPorts_6_req_bits_addr ? data_61 : _GEN_456; // @[]
  wire [7:0] _GEN_458 = 6'h3e == io_rPorts_6_req_bits_addr ? data_62 : _GEN_457; // @[]
  wire  _T_56 = io_rPorts_7_req_ready & io_rPorts_7_req_valid; // @[Decoupled.scala 40:37]
  wire [7:0] _GEN_463 = 6'h1 == io_rPorts_7_req_bits_addr ? data_1 : data_0; // @[]
  wire [7:0] _GEN_464 = 6'h2 == io_rPorts_7_req_bits_addr ? data_2 : _GEN_463; // @[]
  wire [7:0] _GEN_465 = 6'h3 == io_rPorts_7_req_bits_addr ? data_3 : _GEN_464; // @[]
  wire [7:0] _GEN_466 = 6'h4 == io_rPorts_7_req_bits_addr ? data_4 : _GEN_465; // @[]
  wire [7:0] _GEN_467 = 6'h5 == io_rPorts_7_req_bits_addr ? data_5 : _GEN_466; // @[]
  wire [7:0] _GEN_468 = 6'h6 == io_rPorts_7_req_bits_addr ? data_6 : _GEN_467; // @[]
  wire [7:0] _GEN_469 = 6'h7 == io_rPorts_7_req_bits_addr ? data_7 : _GEN_468; // @[]
  wire [7:0] _GEN_470 = 6'h8 == io_rPorts_7_req_bits_addr ? data_8 : _GEN_469; // @[]
  wire [7:0] _GEN_471 = 6'h9 == io_rPorts_7_req_bits_addr ? data_9 : _GEN_470; // @[]
  wire [7:0] _GEN_472 = 6'ha == io_rPorts_7_req_bits_addr ? data_10 : _GEN_471; // @[]
  wire [7:0] _GEN_473 = 6'hb == io_rPorts_7_req_bits_addr ? data_11 : _GEN_472; // @[]
  wire [7:0] _GEN_474 = 6'hc == io_rPorts_7_req_bits_addr ? data_12 : _GEN_473; // @[]
  wire [7:0] _GEN_475 = 6'hd == io_rPorts_7_req_bits_addr ? data_13 : _GEN_474; // @[]
  wire [7:0] _GEN_476 = 6'he == io_rPorts_7_req_bits_addr ? data_14 : _GEN_475; // @[]
  wire [7:0] _GEN_477 = 6'hf == io_rPorts_7_req_bits_addr ? data_15 : _GEN_476; // @[]
  wire [7:0] _GEN_478 = 6'h10 == io_rPorts_7_req_bits_addr ? data_16 : _GEN_477; // @[]
  wire [7:0] _GEN_479 = 6'h11 == io_rPorts_7_req_bits_addr ? data_17 : _GEN_478; // @[]
  wire [7:0] _GEN_480 = 6'h12 == io_rPorts_7_req_bits_addr ? data_18 : _GEN_479; // @[]
  wire [7:0] _GEN_481 = 6'h13 == io_rPorts_7_req_bits_addr ? data_19 : _GEN_480; // @[]
  wire [7:0] _GEN_482 = 6'h14 == io_rPorts_7_req_bits_addr ? data_20 : _GEN_481; // @[]
  wire [7:0] _GEN_483 = 6'h15 == io_rPorts_7_req_bits_addr ? data_21 : _GEN_482; // @[]
  wire [7:0] _GEN_484 = 6'h16 == io_rPorts_7_req_bits_addr ? data_22 : _GEN_483; // @[]
  wire [7:0] _GEN_485 = 6'h17 == io_rPorts_7_req_bits_addr ? data_23 : _GEN_484; // @[]
  wire [7:0] _GEN_486 = 6'h18 == io_rPorts_7_req_bits_addr ? data_24 : _GEN_485; // @[]
  wire [7:0] _GEN_487 = 6'h19 == io_rPorts_7_req_bits_addr ? data_25 : _GEN_486; // @[]
  wire [7:0] _GEN_488 = 6'h1a == io_rPorts_7_req_bits_addr ? data_26 : _GEN_487; // @[]
  wire [7:0] _GEN_489 = 6'h1b == io_rPorts_7_req_bits_addr ? data_27 : _GEN_488; // @[]
  wire [7:0] _GEN_490 = 6'h1c == io_rPorts_7_req_bits_addr ? data_28 : _GEN_489; // @[]
  wire [7:0] _GEN_491 = 6'h1d == io_rPorts_7_req_bits_addr ? data_29 : _GEN_490; // @[]
  wire [7:0] _GEN_492 = 6'h1e == io_rPorts_7_req_bits_addr ? data_30 : _GEN_491; // @[]
  wire [7:0] _GEN_493 = 6'h1f == io_rPorts_7_req_bits_addr ? data_31 : _GEN_492; // @[]
  wire [7:0] _GEN_494 = 6'h20 == io_rPorts_7_req_bits_addr ? data_32 : _GEN_493; // @[]
  wire [7:0] _GEN_495 = 6'h21 == io_rPorts_7_req_bits_addr ? data_33 : _GEN_494; // @[]
  wire [7:0] _GEN_496 = 6'h22 == io_rPorts_7_req_bits_addr ? data_34 : _GEN_495; // @[]
  wire [7:0] _GEN_497 = 6'h23 == io_rPorts_7_req_bits_addr ? data_35 : _GEN_496; // @[]
  wire [7:0] _GEN_498 = 6'h24 == io_rPorts_7_req_bits_addr ? data_36 : _GEN_497; // @[]
  wire [7:0] _GEN_499 = 6'h25 == io_rPorts_7_req_bits_addr ? data_37 : _GEN_498; // @[]
  wire [7:0] _GEN_500 = 6'h26 == io_rPorts_7_req_bits_addr ? data_38 : _GEN_499; // @[]
  wire [7:0] _GEN_501 = 6'h27 == io_rPorts_7_req_bits_addr ? data_39 : _GEN_500; // @[]
  wire [7:0] _GEN_502 = 6'h28 == io_rPorts_7_req_bits_addr ? data_40 : _GEN_501; // @[]
  wire [7:0] _GEN_503 = 6'h29 == io_rPorts_7_req_bits_addr ? data_41 : _GEN_502; // @[]
  wire [7:0] _GEN_504 = 6'h2a == io_rPorts_7_req_bits_addr ? data_42 : _GEN_503; // @[]
  wire [7:0] _GEN_505 = 6'h2b == io_rPorts_7_req_bits_addr ? data_43 : _GEN_504; // @[]
  wire [7:0] _GEN_506 = 6'h2c == io_rPorts_7_req_bits_addr ? data_44 : _GEN_505; // @[]
  wire [7:0] _GEN_507 = 6'h2d == io_rPorts_7_req_bits_addr ? data_45 : _GEN_506; // @[]
  wire [7:0] _GEN_508 = 6'h2e == io_rPorts_7_req_bits_addr ? data_46 : _GEN_507; // @[]
  wire [7:0] _GEN_509 = 6'h2f == io_rPorts_7_req_bits_addr ? data_47 : _GEN_508; // @[]
  wire [7:0] _GEN_510 = 6'h30 == io_rPorts_7_req_bits_addr ? data_48 : _GEN_509; // @[]
  wire [7:0] _GEN_511 = 6'h31 == io_rPorts_7_req_bits_addr ? data_49 : _GEN_510; // @[]
  wire [7:0] _GEN_512 = 6'h32 == io_rPorts_7_req_bits_addr ? data_50 : _GEN_511; // @[]
  wire [7:0] _GEN_513 = 6'h33 == io_rPorts_7_req_bits_addr ? data_51 : _GEN_512; // @[]
  wire [7:0] _GEN_514 = 6'h34 == io_rPorts_7_req_bits_addr ? data_52 : _GEN_513; // @[]
  wire [7:0] _GEN_515 = 6'h35 == io_rPorts_7_req_bits_addr ? data_53 : _GEN_514; // @[]
  wire [7:0] _GEN_516 = 6'h36 == io_rPorts_7_req_bits_addr ? data_54 : _GEN_515; // @[]
  wire [7:0] _GEN_517 = 6'h37 == io_rPorts_7_req_bits_addr ? data_55 : _GEN_516; // @[]
  wire [7:0] _GEN_518 = 6'h38 == io_rPorts_7_req_bits_addr ? data_56 : _GEN_517; // @[]
  wire [7:0] _GEN_519 = 6'h39 == io_rPorts_7_req_bits_addr ? data_57 : _GEN_518; // @[]
  wire [7:0] _GEN_520 = 6'h3a == io_rPorts_7_req_bits_addr ? data_58 : _GEN_519; // @[]
  wire [7:0] _GEN_521 = 6'h3b == io_rPorts_7_req_bits_addr ? data_59 : _GEN_520; // @[]
  wire [7:0] _GEN_522 = 6'h3c == io_rPorts_7_req_bits_addr ? data_60 : _GEN_521; // @[]
  wire [7:0] _GEN_523 = 6'h3d == io_rPorts_7_req_bits_addr ? data_61 : _GEN_522; // @[]
  wire [7:0] _GEN_524 = 6'h3e == io_rPorts_7_req_bits_addr ? data_62 : _GEN_523; // @[]
  wire  _T_64 = io_rwPorts_0_req_ready & io_rwPorts_0_req_valid; // @[Decoupled.scala 40:37]
  wire [7:0] _GEN_528 = 6'h0 == io_rwPorts_0_req_bits_addr ? io_rwPorts_0_req_bits_wdata : data_0; // @[RegStore.scala 139:33 RegStore.scala 139:33 RegStore.scala 104:21]
  wire [7:0] _GEN_529 = 6'h1 == io_rwPorts_0_req_bits_addr ? io_rwPorts_0_req_bits_wdata : data_1; // @[RegStore.scala 139:33 RegStore.scala 139:33 RegStore.scala 104:21]
  wire [7:0] _GEN_530 = 6'h2 == io_rwPorts_0_req_bits_addr ? io_rwPorts_0_req_bits_wdata : data_2; // @[RegStore.scala 139:33 RegStore.scala 139:33 RegStore.scala 104:21]
  wire [7:0] _GEN_531 = 6'h3 == io_rwPorts_0_req_bits_addr ? io_rwPorts_0_req_bits_wdata : data_3; // @[RegStore.scala 139:33 RegStore.scala 139:33 RegStore.scala 104:21]
  wire [7:0] _GEN_532 = 6'h4 == io_rwPorts_0_req_bits_addr ? io_rwPorts_0_req_bits_wdata : data_4; // @[RegStore.scala 139:33 RegStore.scala 139:33 RegStore.scala 104:21]
  wire [7:0] _GEN_533 = 6'h5 == io_rwPorts_0_req_bits_addr ? io_rwPorts_0_req_bits_wdata : data_5; // @[RegStore.scala 139:33 RegStore.scala 139:33 RegStore.scala 104:21]
  wire [7:0] _GEN_534 = 6'h6 == io_rwPorts_0_req_bits_addr ? io_rwPorts_0_req_bits_wdata : data_6; // @[RegStore.scala 139:33 RegStore.scala 139:33 RegStore.scala 104:21]
  wire [7:0] _GEN_535 = 6'h7 == io_rwPorts_0_req_bits_addr ? io_rwPorts_0_req_bits_wdata : data_7; // @[RegStore.scala 139:33 RegStore.scala 139:33 RegStore.scala 104:21]
  wire [7:0] _GEN_536 = 6'h8 == io_rwPorts_0_req_bits_addr ? io_rwPorts_0_req_bits_wdata : data_8; // @[RegStore.scala 139:33 RegStore.scala 139:33 RegStore.scala 104:21]
  wire [7:0] _GEN_537 = 6'h9 == io_rwPorts_0_req_bits_addr ? io_rwPorts_0_req_bits_wdata : data_9; // @[RegStore.scala 139:33 RegStore.scala 139:33 RegStore.scala 104:21]
  wire [7:0] _GEN_538 = 6'ha == io_rwPorts_0_req_bits_addr ? io_rwPorts_0_req_bits_wdata : data_10; // @[RegStore.scala 139:33 RegStore.scala 139:33 RegStore.scala 104:21]
  wire [7:0] _GEN_539 = 6'hb == io_rwPorts_0_req_bits_addr ? io_rwPorts_0_req_bits_wdata : data_11; // @[RegStore.scala 139:33 RegStore.scala 139:33 RegStore.scala 104:21]
  wire [7:0] _GEN_540 = 6'hc == io_rwPorts_0_req_bits_addr ? io_rwPorts_0_req_bits_wdata : data_12; // @[RegStore.scala 139:33 RegStore.scala 139:33 RegStore.scala 104:21]
  wire [7:0] _GEN_541 = 6'hd == io_rwPorts_0_req_bits_addr ? io_rwPorts_0_req_bits_wdata : data_13; // @[RegStore.scala 139:33 RegStore.scala 139:33 RegStore.scala 104:21]
  wire [7:0] _GEN_542 = 6'he == io_rwPorts_0_req_bits_addr ? io_rwPorts_0_req_bits_wdata : data_14; // @[RegStore.scala 139:33 RegStore.scala 139:33 RegStore.scala 104:21]
  wire [7:0] _GEN_543 = 6'hf == io_rwPorts_0_req_bits_addr ? io_rwPorts_0_req_bits_wdata : data_15; // @[RegStore.scala 139:33 RegStore.scala 139:33 RegStore.scala 104:21]
  wire [7:0] _GEN_544 = 6'h10 == io_rwPorts_0_req_bits_addr ? io_rwPorts_0_req_bits_wdata : data_16; // @[RegStore.scala 139:33 RegStore.scala 139:33 RegStore.scala 104:21]
  wire [7:0] _GEN_545 = 6'h11 == io_rwPorts_0_req_bits_addr ? io_rwPorts_0_req_bits_wdata : data_17; // @[RegStore.scala 139:33 RegStore.scala 139:33 RegStore.scala 104:21]
  wire [7:0] _GEN_546 = 6'h12 == io_rwPorts_0_req_bits_addr ? io_rwPorts_0_req_bits_wdata : data_18; // @[RegStore.scala 139:33 RegStore.scala 139:33 RegStore.scala 104:21]
  wire [7:0] _GEN_547 = 6'h13 == io_rwPorts_0_req_bits_addr ? io_rwPorts_0_req_bits_wdata : data_19; // @[RegStore.scala 139:33 RegStore.scala 139:33 RegStore.scala 104:21]
  wire [7:0] _GEN_548 = 6'h14 == io_rwPorts_0_req_bits_addr ? io_rwPorts_0_req_bits_wdata : data_20; // @[RegStore.scala 139:33 RegStore.scala 139:33 RegStore.scala 104:21]
  wire [7:0] _GEN_549 = 6'h15 == io_rwPorts_0_req_bits_addr ? io_rwPorts_0_req_bits_wdata : data_21; // @[RegStore.scala 139:33 RegStore.scala 139:33 RegStore.scala 104:21]
  wire [7:0] _GEN_550 = 6'h16 == io_rwPorts_0_req_bits_addr ? io_rwPorts_0_req_bits_wdata : data_22; // @[RegStore.scala 139:33 RegStore.scala 139:33 RegStore.scala 104:21]
  wire [7:0] _GEN_551 = 6'h17 == io_rwPorts_0_req_bits_addr ? io_rwPorts_0_req_bits_wdata : data_23; // @[RegStore.scala 139:33 RegStore.scala 139:33 RegStore.scala 104:21]
  wire [7:0] _GEN_552 = 6'h18 == io_rwPorts_0_req_bits_addr ? io_rwPorts_0_req_bits_wdata : data_24; // @[RegStore.scala 139:33 RegStore.scala 139:33 RegStore.scala 104:21]
  wire [7:0] _GEN_553 = 6'h19 == io_rwPorts_0_req_bits_addr ? io_rwPorts_0_req_bits_wdata : data_25; // @[RegStore.scala 139:33 RegStore.scala 139:33 RegStore.scala 104:21]
  wire [7:0] _GEN_554 = 6'h1a == io_rwPorts_0_req_bits_addr ? io_rwPorts_0_req_bits_wdata : data_26; // @[RegStore.scala 139:33 RegStore.scala 139:33 RegStore.scala 104:21]
  wire [7:0] _GEN_555 = 6'h1b == io_rwPorts_0_req_bits_addr ? io_rwPorts_0_req_bits_wdata : data_27; // @[RegStore.scala 139:33 RegStore.scala 139:33 RegStore.scala 104:21]
  wire [7:0] _GEN_556 = 6'h1c == io_rwPorts_0_req_bits_addr ? io_rwPorts_0_req_bits_wdata : data_28; // @[RegStore.scala 139:33 RegStore.scala 139:33 RegStore.scala 104:21]
  wire [7:0] _GEN_557 = 6'h1d == io_rwPorts_0_req_bits_addr ? io_rwPorts_0_req_bits_wdata : data_29; // @[RegStore.scala 139:33 RegStore.scala 139:33 RegStore.scala 104:21]
  wire [7:0] _GEN_558 = 6'h1e == io_rwPorts_0_req_bits_addr ? io_rwPorts_0_req_bits_wdata : data_30; // @[RegStore.scala 139:33 RegStore.scala 139:33 RegStore.scala 104:21]
  wire [7:0] _GEN_559 = 6'h1f == io_rwPorts_0_req_bits_addr ? io_rwPorts_0_req_bits_wdata : data_31; // @[RegStore.scala 139:33 RegStore.scala 139:33 RegStore.scala 104:21]
  wire [7:0] _GEN_560 = 6'h20 == io_rwPorts_0_req_bits_addr ? io_rwPorts_0_req_bits_wdata : data_32; // @[RegStore.scala 139:33 RegStore.scala 139:33 RegStore.scala 104:21]
  wire [7:0] _GEN_561 = 6'h21 == io_rwPorts_0_req_bits_addr ? io_rwPorts_0_req_bits_wdata : data_33; // @[RegStore.scala 139:33 RegStore.scala 139:33 RegStore.scala 104:21]
  wire [7:0] _GEN_562 = 6'h22 == io_rwPorts_0_req_bits_addr ? io_rwPorts_0_req_bits_wdata : data_34; // @[RegStore.scala 139:33 RegStore.scala 139:33 RegStore.scala 104:21]
  wire [7:0] _GEN_563 = 6'h23 == io_rwPorts_0_req_bits_addr ? io_rwPorts_0_req_bits_wdata : data_35; // @[RegStore.scala 139:33 RegStore.scala 139:33 RegStore.scala 104:21]
  wire [7:0] _GEN_564 = 6'h24 == io_rwPorts_0_req_bits_addr ? io_rwPorts_0_req_bits_wdata : data_36; // @[RegStore.scala 139:33 RegStore.scala 139:33 RegStore.scala 104:21]
  wire [7:0] _GEN_565 = 6'h25 == io_rwPorts_0_req_bits_addr ? io_rwPorts_0_req_bits_wdata : data_37; // @[RegStore.scala 139:33 RegStore.scala 139:33 RegStore.scala 104:21]
  wire [7:0] _GEN_566 = 6'h26 == io_rwPorts_0_req_bits_addr ? io_rwPorts_0_req_bits_wdata : data_38; // @[RegStore.scala 139:33 RegStore.scala 139:33 RegStore.scala 104:21]
  wire [7:0] _GEN_567 = 6'h27 == io_rwPorts_0_req_bits_addr ? io_rwPorts_0_req_bits_wdata : data_39; // @[RegStore.scala 139:33 RegStore.scala 139:33 RegStore.scala 104:21]
  wire [7:0] _GEN_568 = 6'h28 == io_rwPorts_0_req_bits_addr ? io_rwPorts_0_req_bits_wdata : data_40; // @[RegStore.scala 139:33 RegStore.scala 139:33 RegStore.scala 104:21]
  wire [7:0] _GEN_569 = 6'h29 == io_rwPorts_0_req_bits_addr ? io_rwPorts_0_req_bits_wdata : data_41; // @[RegStore.scala 139:33 RegStore.scala 139:33 RegStore.scala 104:21]
  wire [7:0] _GEN_570 = 6'h2a == io_rwPorts_0_req_bits_addr ? io_rwPorts_0_req_bits_wdata : data_42; // @[RegStore.scala 139:33 RegStore.scala 139:33 RegStore.scala 104:21]
  wire [7:0] _GEN_571 = 6'h2b == io_rwPorts_0_req_bits_addr ? io_rwPorts_0_req_bits_wdata : data_43; // @[RegStore.scala 139:33 RegStore.scala 139:33 RegStore.scala 104:21]
  wire [7:0] _GEN_572 = 6'h2c == io_rwPorts_0_req_bits_addr ? io_rwPorts_0_req_bits_wdata : data_44; // @[RegStore.scala 139:33 RegStore.scala 139:33 RegStore.scala 104:21]
  wire [7:0] _GEN_573 = 6'h2d == io_rwPorts_0_req_bits_addr ? io_rwPorts_0_req_bits_wdata : data_45; // @[RegStore.scala 139:33 RegStore.scala 139:33 RegStore.scala 104:21]
  wire [7:0] _GEN_574 = 6'h2e == io_rwPorts_0_req_bits_addr ? io_rwPorts_0_req_bits_wdata : data_46; // @[RegStore.scala 139:33 RegStore.scala 139:33 RegStore.scala 104:21]
  wire [7:0] _GEN_575 = 6'h2f == io_rwPorts_0_req_bits_addr ? io_rwPorts_0_req_bits_wdata : data_47; // @[RegStore.scala 139:33 RegStore.scala 139:33 RegStore.scala 104:21]
  wire [7:0] _GEN_576 = 6'h30 == io_rwPorts_0_req_bits_addr ? io_rwPorts_0_req_bits_wdata : data_48; // @[RegStore.scala 139:33 RegStore.scala 139:33 RegStore.scala 104:21]
  wire [7:0] _GEN_577 = 6'h31 == io_rwPorts_0_req_bits_addr ? io_rwPorts_0_req_bits_wdata : data_49; // @[RegStore.scala 139:33 RegStore.scala 139:33 RegStore.scala 104:21]
  wire [7:0] _GEN_578 = 6'h32 == io_rwPorts_0_req_bits_addr ? io_rwPorts_0_req_bits_wdata : data_50; // @[RegStore.scala 139:33 RegStore.scala 139:33 RegStore.scala 104:21]
  wire [7:0] _GEN_579 = 6'h33 == io_rwPorts_0_req_bits_addr ? io_rwPorts_0_req_bits_wdata : data_51; // @[RegStore.scala 139:33 RegStore.scala 139:33 RegStore.scala 104:21]
  wire [7:0] _GEN_580 = 6'h34 == io_rwPorts_0_req_bits_addr ? io_rwPorts_0_req_bits_wdata : data_52; // @[RegStore.scala 139:33 RegStore.scala 139:33 RegStore.scala 104:21]
  wire [7:0] _GEN_581 = 6'h35 == io_rwPorts_0_req_bits_addr ? io_rwPorts_0_req_bits_wdata : data_53; // @[RegStore.scala 139:33 RegStore.scala 139:33 RegStore.scala 104:21]
  wire [7:0] _GEN_582 = 6'h36 == io_rwPorts_0_req_bits_addr ? io_rwPorts_0_req_bits_wdata : data_54; // @[RegStore.scala 139:33 RegStore.scala 139:33 RegStore.scala 104:21]
  wire [7:0] _GEN_583 = 6'h37 == io_rwPorts_0_req_bits_addr ? io_rwPorts_0_req_bits_wdata : data_55; // @[RegStore.scala 139:33 RegStore.scala 139:33 RegStore.scala 104:21]
  wire [7:0] _GEN_584 = 6'h38 == io_rwPorts_0_req_bits_addr ? io_rwPorts_0_req_bits_wdata : data_56; // @[RegStore.scala 139:33 RegStore.scala 139:33 RegStore.scala 104:21]
  wire [7:0] _GEN_585 = 6'h39 == io_rwPorts_0_req_bits_addr ? io_rwPorts_0_req_bits_wdata : data_57; // @[RegStore.scala 139:33 RegStore.scala 139:33 RegStore.scala 104:21]
  wire [7:0] _GEN_586 = 6'h3a == io_rwPorts_0_req_bits_addr ? io_rwPorts_0_req_bits_wdata : data_58; // @[RegStore.scala 139:33 RegStore.scala 139:33 RegStore.scala 104:21]
  wire [7:0] _GEN_587 = 6'h3b == io_rwPorts_0_req_bits_addr ? io_rwPorts_0_req_bits_wdata : data_59; // @[RegStore.scala 139:33 RegStore.scala 139:33 RegStore.scala 104:21]
  wire [7:0] _GEN_588 = 6'h3c == io_rwPorts_0_req_bits_addr ? io_rwPorts_0_req_bits_wdata : data_60; // @[RegStore.scala 139:33 RegStore.scala 139:33 RegStore.scala 104:21]
  wire [7:0] _GEN_589 = 6'h3d == io_rwPorts_0_req_bits_addr ? io_rwPorts_0_req_bits_wdata : data_61; // @[RegStore.scala 139:33 RegStore.scala 139:33 RegStore.scala 104:21]
  wire [7:0] _GEN_590 = 6'h3e == io_rwPorts_0_req_bits_addr ? io_rwPorts_0_req_bits_wdata : data_62; // @[RegStore.scala 139:33 RegStore.scala 139:33 RegStore.scala 104:21]
  wire [7:0] _GEN_591 = 6'h3f == io_rwPorts_0_req_bits_addr ? io_rwPorts_0_req_bits_wdata : data_63; // @[RegStore.scala 139:33 RegStore.scala 139:33 RegStore.scala 104:21]
  wire [7:0] _GEN_593 = 6'h1 == io_rwPorts_0_req_bits_addr ? data_1 : data_0; // @[]
  wire [7:0] _GEN_594 = 6'h2 == io_rwPorts_0_req_bits_addr ? data_2 : _GEN_593; // @[]
  wire [7:0] _GEN_595 = 6'h3 == io_rwPorts_0_req_bits_addr ? data_3 : _GEN_594; // @[]
  wire [7:0] _GEN_596 = 6'h4 == io_rwPorts_0_req_bits_addr ? data_4 : _GEN_595; // @[]
  wire [7:0] _GEN_597 = 6'h5 == io_rwPorts_0_req_bits_addr ? data_5 : _GEN_596; // @[]
  wire [7:0] _GEN_598 = 6'h6 == io_rwPorts_0_req_bits_addr ? data_6 : _GEN_597; // @[]
  wire [7:0] _GEN_599 = 6'h7 == io_rwPorts_0_req_bits_addr ? data_7 : _GEN_598; // @[]
  wire [7:0] _GEN_600 = 6'h8 == io_rwPorts_0_req_bits_addr ? data_8 : _GEN_599; // @[]
  wire [7:0] _GEN_601 = 6'h9 == io_rwPorts_0_req_bits_addr ? data_9 : _GEN_600; // @[]
  wire [7:0] _GEN_602 = 6'ha == io_rwPorts_0_req_bits_addr ? data_10 : _GEN_601; // @[]
  wire [7:0] _GEN_603 = 6'hb == io_rwPorts_0_req_bits_addr ? data_11 : _GEN_602; // @[]
  wire [7:0] _GEN_604 = 6'hc == io_rwPorts_0_req_bits_addr ? data_12 : _GEN_603; // @[]
  wire [7:0] _GEN_605 = 6'hd == io_rwPorts_0_req_bits_addr ? data_13 : _GEN_604; // @[]
  wire [7:0] _GEN_606 = 6'he == io_rwPorts_0_req_bits_addr ? data_14 : _GEN_605; // @[]
  wire [7:0] _GEN_607 = 6'hf == io_rwPorts_0_req_bits_addr ? data_15 : _GEN_606; // @[]
  wire [7:0] _GEN_608 = 6'h10 == io_rwPorts_0_req_bits_addr ? data_16 : _GEN_607; // @[]
  wire [7:0] _GEN_609 = 6'h11 == io_rwPorts_0_req_bits_addr ? data_17 : _GEN_608; // @[]
  wire [7:0] _GEN_610 = 6'h12 == io_rwPorts_0_req_bits_addr ? data_18 : _GEN_609; // @[]
  wire [7:0] _GEN_611 = 6'h13 == io_rwPorts_0_req_bits_addr ? data_19 : _GEN_610; // @[]
  wire [7:0] _GEN_612 = 6'h14 == io_rwPorts_0_req_bits_addr ? data_20 : _GEN_611; // @[]
  wire [7:0] _GEN_613 = 6'h15 == io_rwPorts_0_req_bits_addr ? data_21 : _GEN_612; // @[]
  wire [7:0] _GEN_614 = 6'h16 == io_rwPorts_0_req_bits_addr ? data_22 : _GEN_613; // @[]
  wire [7:0] _GEN_615 = 6'h17 == io_rwPorts_0_req_bits_addr ? data_23 : _GEN_614; // @[]
  wire [7:0] _GEN_616 = 6'h18 == io_rwPorts_0_req_bits_addr ? data_24 : _GEN_615; // @[]
  wire [7:0] _GEN_617 = 6'h19 == io_rwPorts_0_req_bits_addr ? data_25 : _GEN_616; // @[]
  wire [7:0] _GEN_618 = 6'h1a == io_rwPorts_0_req_bits_addr ? data_26 : _GEN_617; // @[]
  wire [7:0] _GEN_619 = 6'h1b == io_rwPorts_0_req_bits_addr ? data_27 : _GEN_618; // @[]
  wire [7:0] _GEN_620 = 6'h1c == io_rwPorts_0_req_bits_addr ? data_28 : _GEN_619; // @[]
  wire [7:0] _GEN_621 = 6'h1d == io_rwPorts_0_req_bits_addr ? data_29 : _GEN_620; // @[]
  wire [7:0] _GEN_622 = 6'h1e == io_rwPorts_0_req_bits_addr ? data_30 : _GEN_621; // @[]
  wire [7:0] _GEN_623 = 6'h1f == io_rwPorts_0_req_bits_addr ? data_31 : _GEN_622; // @[]
  wire [7:0] _GEN_624 = 6'h20 == io_rwPorts_0_req_bits_addr ? data_32 : _GEN_623; // @[]
  wire [7:0] _GEN_625 = 6'h21 == io_rwPorts_0_req_bits_addr ? data_33 : _GEN_624; // @[]
  wire [7:0] _GEN_626 = 6'h22 == io_rwPorts_0_req_bits_addr ? data_34 : _GEN_625; // @[]
  wire [7:0] _GEN_627 = 6'h23 == io_rwPorts_0_req_bits_addr ? data_35 : _GEN_626; // @[]
  wire [7:0] _GEN_628 = 6'h24 == io_rwPorts_0_req_bits_addr ? data_36 : _GEN_627; // @[]
  wire [7:0] _GEN_629 = 6'h25 == io_rwPorts_0_req_bits_addr ? data_37 : _GEN_628; // @[]
  wire [7:0] _GEN_630 = 6'h26 == io_rwPorts_0_req_bits_addr ? data_38 : _GEN_629; // @[]
  wire [7:0] _GEN_631 = 6'h27 == io_rwPorts_0_req_bits_addr ? data_39 : _GEN_630; // @[]
  wire [7:0] _GEN_632 = 6'h28 == io_rwPorts_0_req_bits_addr ? data_40 : _GEN_631; // @[]
  wire [7:0] _GEN_633 = 6'h29 == io_rwPorts_0_req_bits_addr ? data_41 : _GEN_632; // @[]
  wire [7:0] _GEN_634 = 6'h2a == io_rwPorts_0_req_bits_addr ? data_42 : _GEN_633; // @[]
  wire [7:0] _GEN_635 = 6'h2b == io_rwPorts_0_req_bits_addr ? data_43 : _GEN_634; // @[]
  wire [7:0] _GEN_636 = 6'h2c == io_rwPorts_0_req_bits_addr ? data_44 : _GEN_635; // @[]
  wire [7:0] _GEN_637 = 6'h2d == io_rwPorts_0_req_bits_addr ? data_45 : _GEN_636; // @[]
  wire [7:0] _GEN_638 = 6'h2e == io_rwPorts_0_req_bits_addr ? data_46 : _GEN_637; // @[]
  wire [7:0] _GEN_639 = 6'h2f == io_rwPorts_0_req_bits_addr ? data_47 : _GEN_638; // @[]
  wire [7:0] _GEN_640 = 6'h30 == io_rwPorts_0_req_bits_addr ? data_48 : _GEN_639; // @[]
  wire [7:0] _GEN_641 = 6'h31 == io_rwPorts_0_req_bits_addr ? data_49 : _GEN_640; // @[]
  wire [7:0] _GEN_642 = 6'h32 == io_rwPorts_0_req_bits_addr ? data_50 : _GEN_641; // @[]
  wire [7:0] _GEN_643 = 6'h33 == io_rwPorts_0_req_bits_addr ? data_51 : _GEN_642; // @[]
  wire [7:0] _GEN_644 = 6'h34 == io_rwPorts_0_req_bits_addr ? data_52 : _GEN_643; // @[]
  wire [7:0] _GEN_645 = 6'h35 == io_rwPorts_0_req_bits_addr ? data_53 : _GEN_644; // @[]
  wire [7:0] _GEN_646 = 6'h36 == io_rwPorts_0_req_bits_addr ? data_54 : _GEN_645; // @[]
  wire [7:0] _GEN_647 = 6'h37 == io_rwPorts_0_req_bits_addr ? data_55 : _GEN_646; // @[]
  wire [7:0] _GEN_648 = 6'h38 == io_rwPorts_0_req_bits_addr ? data_56 : _GEN_647; // @[]
  wire [7:0] _GEN_649 = 6'h39 == io_rwPorts_0_req_bits_addr ? data_57 : _GEN_648; // @[]
  wire [7:0] _GEN_650 = 6'h3a == io_rwPorts_0_req_bits_addr ? data_58 : _GEN_649; // @[]
  wire [7:0] _GEN_651 = 6'h3b == io_rwPorts_0_req_bits_addr ? data_59 : _GEN_650; // @[]
  wire [7:0] _GEN_652 = 6'h3c == io_rwPorts_0_req_bits_addr ? data_60 : _GEN_651; // @[]
  wire [7:0] _GEN_653 = 6'h3d == io_rwPorts_0_req_bits_addr ? data_61 : _GEN_652; // @[]
  wire [7:0] _GEN_654 = 6'h3e == io_rwPorts_0_req_bits_addr ? data_62 : _GEN_653; // @[]
  wire  _GEN_720 = io_rwPorts_0_req_bits_wen ? 1'h0 : 1'h1; // @[RegStore.scala 138:30 RegStore.scala 92:19 RegStore.scala 149:23]
  assign io_rPorts_0_req_ready = 1'h1; // @[RegStore.scala 117:18]
  assign io_rPorts_0_rsp_bits_rdata = 6'h3f == io_rPorts_0_req_bits_addr ? data_63 : _GEN_62; // @[]
  assign io_rPorts_1_req_ready = 1'h1; // @[RegStore.scala 117:18]
  assign io_rPorts_1_rsp_bits_rdata = 6'h3f == io_rPorts_1_req_bits_addr ? data_63 : _GEN_128; // @[]
  assign io_rPorts_2_req_ready = 1'h1; // @[RegStore.scala 117:18]
  assign io_rPorts_2_rsp_bits_rdata = 6'h3f == io_rPorts_2_req_bits_addr ? data_63 : _GEN_194; // @[]
  assign io_rPorts_3_req_ready = 1'h1; // @[RegStore.scala 117:18]
  assign io_rPorts_3_rsp_bits_rdata = 6'h3f == io_rPorts_3_req_bits_addr ? data_63 : _GEN_260; // @[]
  assign io_rPorts_4_req_ready = 1'h1; // @[RegStore.scala 117:18]
  assign io_rPorts_4_rsp_bits_rdata = 6'h3f == io_rPorts_4_req_bits_addr ? data_63 : _GEN_326; // @[]
  assign io_rPorts_5_req_ready = 1'h1; // @[RegStore.scala 117:18]
  assign io_rPorts_5_rsp_bits_rdata = 6'h3f == io_rPorts_5_req_bits_addr ? data_63 : _GEN_392; // @[]
  assign io_rPorts_6_req_ready = 1'h1; // @[RegStore.scala 117:18]
  assign io_rPorts_6_rsp_bits_rdata = 6'h3f == io_rPorts_6_req_bits_addr ? data_63 : _GEN_458; // @[]
  assign io_rPorts_7_req_ready = 1'h1; // @[RegStore.scala 117:18]
  assign io_rPorts_7_rsp_bits_rdata = 6'h3f == io_rPorts_7_req_bits_addr ? data_63 : _GEN_524; // @[]
  assign io_rwPorts_0_req_ready = 1'h1; // @[RegStore.scala 136:19]
  assign io_rwPorts_0_rsp_valid = _T_64 & _GEN_720; // @[RegStore.scala 137:26 RegStore.scala 92:19]
  assign io_rwPorts_0_rsp_bits_rdata = 6'h3f == io_rwPorts_0_req_bits_addr ? data_63 : _GEN_654; // @[]
  always @(posedge clock) begin
    if (reset) begin // @[RegStore.scala 104:21]
      data_0 <= 8'h0; // @[RegStore.scala 104:21]
    end else if (reset) begin // @[RegStore.scala 155:25]
      data_0 <= 8'h0; // @[RegStore.scala 156:10]
    end else if (_T_64) begin // @[RegStore.scala 137:26]
      if (io_rwPorts_0_req_bits_wen) begin // @[RegStore.scala 138:30]
        data_0 <= _GEN_528;
      end
    end
    if (reset) begin // @[RegStore.scala 104:21]
      data_1 <= 8'h0; // @[RegStore.scala 104:21]
    end else if (reset) begin // @[RegStore.scala 155:25]
      data_1 <= 8'h0; // @[RegStore.scala 156:10]
    end else if (_T_64) begin // @[RegStore.scala 137:26]
      if (io_rwPorts_0_req_bits_wen) begin // @[RegStore.scala 138:30]
        data_1 <= _GEN_529;
      end
    end
    if (reset) begin // @[RegStore.scala 104:21]
      data_2 <= 8'h0; // @[RegStore.scala 104:21]
    end else if (reset) begin // @[RegStore.scala 155:25]
      data_2 <= 8'h0; // @[RegStore.scala 156:10]
    end else if (_T_64) begin // @[RegStore.scala 137:26]
      if (io_rwPorts_0_req_bits_wen) begin // @[RegStore.scala 138:30]
        data_2 <= _GEN_530;
      end
    end
    if (reset) begin // @[RegStore.scala 104:21]
      data_3 <= 8'h0; // @[RegStore.scala 104:21]
    end else if (reset) begin // @[RegStore.scala 155:25]
      data_3 <= 8'h0; // @[RegStore.scala 156:10]
    end else if (_T_64) begin // @[RegStore.scala 137:26]
      if (io_rwPorts_0_req_bits_wen) begin // @[RegStore.scala 138:30]
        data_3 <= _GEN_531;
      end
    end
    if (reset) begin // @[RegStore.scala 104:21]
      data_4 <= 8'h0; // @[RegStore.scala 104:21]
    end else if (reset) begin // @[RegStore.scala 155:25]
      data_4 <= 8'h0; // @[RegStore.scala 156:10]
    end else if (_T_64) begin // @[RegStore.scala 137:26]
      if (io_rwPorts_0_req_bits_wen) begin // @[RegStore.scala 138:30]
        data_4 <= _GEN_532;
      end
    end
    if (reset) begin // @[RegStore.scala 104:21]
      data_5 <= 8'h0; // @[RegStore.scala 104:21]
    end else if (reset) begin // @[RegStore.scala 155:25]
      data_5 <= 8'h0; // @[RegStore.scala 156:10]
    end else if (_T_64) begin // @[RegStore.scala 137:26]
      if (io_rwPorts_0_req_bits_wen) begin // @[RegStore.scala 138:30]
        data_5 <= _GEN_533;
      end
    end
    if (reset) begin // @[RegStore.scala 104:21]
      data_6 <= 8'h0; // @[RegStore.scala 104:21]
    end else if (reset) begin // @[RegStore.scala 155:25]
      data_6 <= 8'h0; // @[RegStore.scala 156:10]
    end else if (_T_64) begin // @[RegStore.scala 137:26]
      if (io_rwPorts_0_req_bits_wen) begin // @[RegStore.scala 138:30]
        data_6 <= _GEN_534;
      end
    end
    if (reset) begin // @[RegStore.scala 104:21]
      data_7 <= 8'h0; // @[RegStore.scala 104:21]
    end else if (reset) begin // @[RegStore.scala 155:25]
      data_7 <= 8'h0; // @[RegStore.scala 156:10]
    end else if (_T_64) begin // @[RegStore.scala 137:26]
      if (io_rwPorts_0_req_bits_wen) begin // @[RegStore.scala 138:30]
        data_7 <= _GEN_535;
      end
    end
    if (reset) begin // @[RegStore.scala 104:21]
      data_8 <= 8'h0; // @[RegStore.scala 104:21]
    end else if (reset) begin // @[RegStore.scala 155:25]
      data_8 <= 8'h0; // @[RegStore.scala 156:10]
    end else if (_T_64) begin // @[RegStore.scala 137:26]
      if (io_rwPorts_0_req_bits_wen) begin // @[RegStore.scala 138:30]
        data_8 <= _GEN_536;
      end
    end
    if (reset) begin // @[RegStore.scala 104:21]
      data_9 <= 8'h0; // @[RegStore.scala 104:21]
    end else if (reset) begin // @[RegStore.scala 155:25]
      data_9 <= 8'h0; // @[RegStore.scala 156:10]
    end else if (_T_64) begin // @[RegStore.scala 137:26]
      if (io_rwPorts_0_req_bits_wen) begin // @[RegStore.scala 138:30]
        data_9 <= _GEN_537;
      end
    end
    if (reset) begin // @[RegStore.scala 104:21]
      data_10 <= 8'h0; // @[RegStore.scala 104:21]
    end else if (reset) begin // @[RegStore.scala 155:25]
      data_10 <= 8'h0; // @[RegStore.scala 156:10]
    end else if (_T_64) begin // @[RegStore.scala 137:26]
      if (io_rwPorts_0_req_bits_wen) begin // @[RegStore.scala 138:30]
        data_10 <= _GEN_538;
      end
    end
    if (reset) begin // @[RegStore.scala 104:21]
      data_11 <= 8'h0; // @[RegStore.scala 104:21]
    end else if (reset) begin // @[RegStore.scala 155:25]
      data_11 <= 8'h0; // @[RegStore.scala 156:10]
    end else if (_T_64) begin // @[RegStore.scala 137:26]
      if (io_rwPorts_0_req_bits_wen) begin // @[RegStore.scala 138:30]
        data_11 <= _GEN_539;
      end
    end
    if (reset) begin // @[RegStore.scala 104:21]
      data_12 <= 8'h0; // @[RegStore.scala 104:21]
    end else if (reset) begin // @[RegStore.scala 155:25]
      data_12 <= 8'h0; // @[RegStore.scala 156:10]
    end else if (_T_64) begin // @[RegStore.scala 137:26]
      if (io_rwPorts_0_req_bits_wen) begin // @[RegStore.scala 138:30]
        data_12 <= _GEN_540;
      end
    end
    if (reset) begin // @[RegStore.scala 104:21]
      data_13 <= 8'h0; // @[RegStore.scala 104:21]
    end else if (reset) begin // @[RegStore.scala 155:25]
      data_13 <= 8'h0; // @[RegStore.scala 156:10]
    end else if (_T_64) begin // @[RegStore.scala 137:26]
      if (io_rwPorts_0_req_bits_wen) begin // @[RegStore.scala 138:30]
        data_13 <= _GEN_541;
      end
    end
    if (reset) begin // @[RegStore.scala 104:21]
      data_14 <= 8'h0; // @[RegStore.scala 104:21]
    end else if (reset) begin // @[RegStore.scala 155:25]
      data_14 <= 8'h0; // @[RegStore.scala 156:10]
    end else if (_T_64) begin // @[RegStore.scala 137:26]
      if (io_rwPorts_0_req_bits_wen) begin // @[RegStore.scala 138:30]
        data_14 <= _GEN_542;
      end
    end
    if (reset) begin // @[RegStore.scala 104:21]
      data_15 <= 8'h0; // @[RegStore.scala 104:21]
    end else if (reset) begin // @[RegStore.scala 155:25]
      data_15 <= 8'h0; // @[RegStore.scala 156:10]
    end else if (_T_64) begin // @[RegStore.scala 137:26]
      if (io_rwPorts_0_req_bits_wen) begin // @[RegStore.scala 138:30]
        data_15 <= _GEN_543;
      end
    end
    if (reset) begin // @[RegStore.scala 104:21]
      data_16 <= 8'h0; // @[RegStore.scala 104:21]
    end else if (reset) begin // @[RegStore.scala 155:25]
      data_16 <= 8'h0; // @[RegStore.scala 156:10]
    end else if (_T_64) begin // @[RegStore.scala 137:26]
      if (io_rwPorts_0_req_bits_wen) begin // @[RegStore.scala 138:30]
        data_16 <= _GEN_544;
      end
    end
    if (reset) begin // @[RegStore.scala 104:21]
      data_17 <= 8'h0; // @[RegStore.scala 104:21]
    end else if (reset) begin // @[RegStore.scala 155:25]
      data_17 <= 8'h0; // @[RegStore.scala 156:10]
    end else if (_T_64) begin // @[RegStore.scala 137:26]
      if (io_rwPorts_0_req_bits_wen) begin // @[RegStore.scala 138:30]
        data_17 <= _GEN_545;
      end
    end
    if (reset) begin // @[RegStore.scala 104:21]
      data_18 <= 8'h0; // @[RegStore.scala 104:21]
    end else if (reset) begin // @[RegStore.scala 155:25]
      data_18 <= 8'h0; // @[RegStore.scala 156:10]
    end else if (_T_64) begin // @[RegStore.scala 137:26]
      if (io_rwPorts_0_req_bits_wen) begin // @[RegStore.scala 138:30]
        data_18 <= _GEN_546;
      end
    end
    if (reset) begin // @[RegStore.scala 104:21]
      data_19 <= 8'h0; // @[RegStore.scala 104:21]
    end else if (reset) begin // @[RegStore.scala 155:25]
      data_19 <= 8'h0; // @[RegStore.scala 156:10]
    end else if (_T_64) begin // @[RegStore.scala 137:26]
      if (io_rwPorts_0_req_bits_wen) begin // @[RegStore.scala 138:30]
        data_19 <= _GEN_547;
      end
    end
    if (reset) begin // @[RegStore.scala 104:21]
      data_20 <= 8'h0; // @[RegStore.scala 104:21]
    end else if (reset) begin // @[RegStore.scala 155:25]
      data_20 <= 8'h0; // @[RegStore.scala 156:10]
    end else if (_T_64) begin // @[RegStore.scala 137:26]
      if (io_rwPorts_0_req_bits_wen) begin // @[RegStore.scala 138:30]
        data_20 <= _GEN_548;
      end
    end
    if (reset) begin // @[RegStore.scala 104:21]
      data_21 <= 8'h0; // @[RegStore.scala 104:21]
    end else if (reset) begin // @[RegStore.scala 155:25]
      data_21 <= 8'h0; // @[RegStore.scala 156:10]
    end else if (_T_64) begin // @[RegStore.scala 137:26]
      if (io_rwPorts_0_req_bits_wen) begin // @[RegStore.scala 138:30]
        data_21 <= _GEN_549;
      end
    end
    if (reset) begin // @[RegStore.scala 104:21]
      data_22 <= 8'h0; // @[RegStore.scala 104:21]
    end else if (reset) begin // @[RegStore.scala 155:25]
      data_22 <= 8'h0; // @[RegStore.scala 156:10]
    end else if (_T_64) begin // @[RegStore.scala 137:26]
      if (io_rwPorts_0_req_bits_wen) begin // @[RegStore.scala 138:30]
        data_22 <= _GEN_550;
      end
    end
    if (reset) begin // @[RegStore.scala 104:21]
      data_23 <= 8'h0; // @[RegStore.scala 104:21]
    end else if (reset) begin // @[RegStore.scala 155:25]
      data_23 <= 8'h0; // @[RegStore.scala 156:10]
    end else if (_T_64) begin // @[RegStore.scala 137:26]
      if (io_rwPorts_0_req_bits_wen) begin // @[RegStore.scala 138:30]
        data_23 <= _GEN_551;
      end
    end
    if (reset) begin // @[RegStore.scala 104:21]
      data_24 <= 8'h0; // @[RegStore.scala 104:21]
    end else if (reset) begin // @[RegStore.scala 155:25]
      data_24 <= 8'h0; // @[RegStore.scala 156:10]
    end else if (_T_64) begin // @[RegStore.scala 137:26]
      if (io_rwPorts_0_req_bits_wen) begin // @[RegStore.scala 138:30]
        data_24 <= _GEN_552;
      end
    end
    if (reset) begin // @[RegStore.scala 104:21]
      data_25 <= 8'h0; // @[RegStore.scala 104:21]
    end else if (reset) begin // @[RegStore.scala 155:25]
      data_25 <= 8'h0; // @[RegStore.scala 156:10]
    end else if (_T_64) begin // @[RegStore.scala 137:26]
      if (io_rwPorts_0_req_bits_wen) begin // @[RegStore.scala 138:30]
        data_25 <= _GEN_553;
      end
    end
    if (reset) begin // @[RegStore.scala 104:21]
      data_26 <= 8'h0; // @[RegStore.scala 104:21]
    end else if (reset) begin // @[RegStore.scala 155:25]
      data_26 <= 8'h0; // @[RegStore.scala 156:10]
    end else if (_T_64) begin // @[RegStore.scala 137:26]
      if (io_rwPorts_0_req_bits_wen) begin // @[RegStore.scala 138:30]
        data_26 <= _GEN_554;
      end
    end
    if (reset) begin // @[RegStore.scala 104:21]
      data_27 <= 8'h0; // @[RegStore.scala 104:21]
    end else if (reset) begin // @[RegStore.scala 155:25]
      data_27 <= 8'h0; // @[RegStore.scala 156:10]
    end else if (_T_64) begin // @[RegStore.scala 137:26]
      if (io_rwPorts_0_req_bits_wen) begin // @[RegStore.scala 138:30]
        data_27 <= _GEN_555;
      end
    end
    if (reset) begin // @[RegStore.scala 104:21]
      data_28 <= 8'h0; // @[RegStore.scala 104:21]
    end else if (reset) begin // @[RegStore.scala 155:25]
      data_28 <= 8'h0; // @[RegStore.scala 156:10]
    end else if (_T_64) begin // @[RegStore.scala 137:26]
      if (io_rwPorts_0_req_bits_wen) begin // @[RegStore.scala 138:30]
        data_28 <= _GEN_556;
      end
    end
    if (reset) begin // @[RegStore.scala 104:21]
      data_29 <= 8'h0; // @[RegStore.scala 104:21]
    end else if (reset) begin // @[RegStore.scala 155:25]
      data_29 <= 8'h0; // @[RegStore.scala 156:10]
    end else if (_T_64) begin // @[RegStore.scala 137:26]
      if (io_rwPorts_0_req_bits_wen) begin // @[RegStore.scala 138:30]
        data_29 <= _GEN_557;
      end
    end
    if (reset) begin // @[RegStore.scala 104:21]
      data_30 <= 8'h0; // @[RegStore.scala 104:21]
    end else if (reset) begin // @[RegStore.scala 155:25]
      data_30 <= 8'h0; // @[RegStore.scala 156:10]
    end else if (_T_64) begin // @[RegStore.scala 137:26]
      if (io_rwPorts_0_req_bits_wen) begin // @[RegStore.scala 138:30]
        data_30 <= _GEN_558;
      end
    end
    if (reset) begin // @[RegStore.scala 104:21]
      data_31 <= 8'h0; // @[RegStore.scala 104:21]
    end else if (reset) begin // @[RegStore.scala 155:25]
      data_31 <= 8'h0; // @[RegStore.scala 156:10]
    end else if (_T_64) begin // @[RegStore.scala 137:26]
      if (io_rwPorts_0_req_bits_wen) begin // @[RegStore.scala 138:30]
        data_31 <= _GEN_559;
      end
    end
    if (reset) begin // @[RegStore.scala 104:21]
      data_32 <= 8'h0; // @[RegStore.scala 104:21]
    end else if (reset) begin // @[RegStore.scala 155:25]
      data_32 <= 8'h0; // @[RegStore.scala 156:10]
    end else if (_T_64) begin // @[RegStore.scala 137:26]
      if (io_rwPorts_0_req_bits_wen) begin // @[RegStore.scala 138:30]
        data_32 <= _GEN_560;
      end
    end
    if (reset) begin // @[RegStore.scala 104:21]
      data_33 <= 8'h0; // @[RegStore.scala 104:21]
    end else if (reset) begin // @[RegStore.scala 155:25]
      data_33 <= 8'h0; // @[RegStore.scala 156:10]
    end else if (_T_64) begin // @[RegStore.scala 137:26]
      if (io_rwPorts_0_req_bits_wen) begin // @[RegStore.scala 138:30]
        data_33 <= _GEN_561;
      end
    end
    if (reset) begin // @[RegStore.scala 104:21]
      data_34 <= 8'h0; // @[RegStore.scala 104:21]
    end else if (reset) begin // @[RegStore.scala 155:25]
      data_34 <= 8'h0; // @[RegStore.scala 156:10]
    end else if (_T_64) begin // @[RegStore.scala 137:26]
      if (io_rwPorts_0_req_bits_wen) begin // @[RegStore.scala 138:30]
        data_34 <= _GEN_562;
      end
    end
    if (reset) begin // @[RegStore.scala 104:21]
      data_35 <= 8'h0; // @[RegStore.scala 104:21]
    end else if (reset) begin // @[RegStore.scala 155:25]
      data_35 <= 8'h0; // @[RegStore.scala 156:10]
    end else if (_T_64) begin // @[RegStore.scala 137:26]
      if (io_rwPorts_0_req_bits_wen) begin // @[RegStore.scala 138:30]
        data_35 <= _GEN_563;
      end
    end
    if (reset) begin // @[RegStore.scala 104:21]
      data_36 <= 8'h0; // @[RegStore.scala 104:21]
    end else if (reset) begin // @[RegStore.scala 155:25]
      data_36 <= 8'h0; // @[RegStore.scala 156:10]
    end else if (_T_64) begin // @[RegStore.scala 137:26]
      if (io_rwPorts_0_req_bits_wen) begin // @[RegStore.scala 138:30]
        data_36 <= _GEN_564;
      end
    end
    if (reset) begin // @[RegStore.scala 104:21]
      data_37 <= 8'h0; // @[RegStore.scala 104:21]
    end else if (reset) begin // @[RegStore.scala 155:25]
      data_37 <= 8'h0; // @[RegStore.scala 156:10]
    end else if (_T_64) begin // @[RegStore.scala 137:26]
      if (io_rwPorts_0_req_bits_wen) begin // @[RegStore.scala 138:30]
        data_37 <= _GEN_565;
      end
    end
    if (reset) begin // @[RegStore.scala 104:21]
      data_38 <= 8'h0; // @[RegStore.scala 104:21]
    end else if (reset) begin // @[RegStore.scala 155:25]
      data_38 <= 8'h0; // @[RegStore.scala 156:10]
    end else if (_T_64) begin // @[RegStore.scala 137:26]
      if (io_rwPorts_0_req_bits_wen) begin // @[RegStore.scala 138:30]
        data_38 <= _GEN_566;
      end
    end
    if (reset) begin // @[RegStore.scala 104:21]
      data_39 <= 8'h0; // @[RegStore.scala 104:21]
    end else if (reset) begin // @[RegStore.scala 155:25]
      data_39 <= 8'h0; // @[RegStore.scala 156:10]
    end else if (_T_64) begin // @[RegStore.scala 137:26]
      if (io_rwPorts_0_req_bits_wen) begin // @[RegStore.scala 138:30]
        data_39 <= _GEN_567;
      end
    end
    if (reset) begin // @[RegStore.scala 104:21]
      data_40 <= 8'h0; // @[RegStore.scala 104:21]
    end else if (reset) begin // @[RegStore.scala 155:25]
      data_40 <= 8'h0; // @[RegStore.scala 156:10]
    end else if (_T_64) begin // @[RegStore.scala 137:26]
      if (io_rwPorts_0_req_bits_wen) begin // @[RegStore.scala 138:30]
        data_40 <= _GEN_568;
      end
    end
    if (reset) begin // @[RegStore.scala 104:21]
      data_41 <= 8'h0; // @[RegStore.scala 104:21]
    end else if (reset) begin // @[RegStore.scala 155:25]
      data_41 <= 8'h0; // @[RegStore.scala 156:10]
    end else if (_T_64) begin // @[RegStore.scala 137:26]
      if (io_rwPorts_0_req_bits_wen) begin // @[RegStore.scala 138:30]
        data_41 <= _GEN_569;
      end
    end
    if (reset) begin // @[RegStore.scala 104:21]
      data_42 <= 8'h0; // @[RegStore.scala 104:21]
    end else if (reset) begin // @[RegStore.scala 155:25]
      data_42 <= 8'h0; // @[RegStore.scala 156:10]
    end else if (_T_64) begin // @[RegStore.scala 137:26]
      if (io_rwPorts_0_req_bits_wen) begin // @[RegStore.scala 138:30]
        data_42 <= _GEN_570;
      end
    end
    if (reset) begin // @[RegStore.scala 104:21]
      data_43 <= 8'h0; // @[RegStore.scala 104:21]
    end else if (reset) begin // @[RegStore.scala 155:25]
      data_43 <= 8'h0; // @[RegStore.scala 156:10]
    end else if (_T_64) begin // @[RegStore.scala 137:26]
      if (io_rwPorts_0_req_bits_wen) begin // @[RegStore.scala 138:30]
        data_43 <= _GEN_571;
      end
    end
    if (reset) begin // @[RegStore.scala 104:21]
      data_44 <= 8'h0; // @[RegStore.scala 104:21]
    end else if (reset) begin // @[RegStore.scala 155:25]
      data_44 <= 8'h0; // @[RegStore.scala 156:10]
    end else if (_T_64) begin // @[RegStore.scala 137:26]
      if (io_rwPorts_0_req_bits_wen) begin // @[RegStore.scala 138:30]
        data_44 <= _GEN_572;
      end
    end
    if (reset) begin // @[RegStore.scala 104:21]
      data_45 <= 8'h0; // @[RegStore.scala 104:21]
    end else if (reset) begin // @[RegStore.scala 155:25]
      data_45 <= 8'h0; // @[RegStore.scala 156:10]
    end else if (_T_64) begin // @[RegStore.scala 137:26]
      if (io_rwPorts_0_req_bits_wen) begin // @[RegStore.scala 138:30]
        data_45 <= _GEN_573;
      end
    end
    if (reset) begin // @[RegStore.scala 104:21]
      data_46 <= 8'h0; // @[RegStore.scala 104:21]
    end else if (reset) begin // @[RegStore.scala 155:25]
      data_46 <= 8'h0; // @[RegStore.scala 156:10]
    end else if (_T_64) begin // @[RegStore.scala 137:26]
      if (io_rwPorts_0_req_bits_wen) begin // @[RegStore.scala 138:30]
        data_46 <= _GEN_574;
      end
    end
    if (reset) begin // @[RegStore.scala 104:21]
      data_47 <= 8'h0; // @[RegStore.scala 104:21]
    end else if (reset) begin // @[RegStore.scala 155:25]
      data_47 <= 8'h0; // @[RegStore.scala 156:10]
    end else if (_T_64) begin // @[RegStore.scala 137:26]
      if (io_rwPorts_0_req_bits_wen) begin // @[RegStore.scala 138:30]
        data_47 <= _GEN_575;
      end
    end
    if (reset) begin // @[RegStore.scala 104:21]
      data_48 <= 8'h0; // @[RegStore.scala 104:21]
    end else if (reset) begin // @[RegStore.scala 155:25]
      data_48 <= 8'h0; // @[RegStore.scala 156:10]
    end else if (_T_64) begin // @[RegStore.scala 137:26]
      if (io_rwPorts_0_req_bits_wen) begin // @[RegStore.scala 138:30]
        data_48 <= _GEN_576;
      end
    end
    if (reset) begin // @[RegStore.scala 104:21]
      data_49 <= 8'h0; // @[RegStore.scala 104:21]
    end else if (reset) begin // @[RegStore.scala 155:25]
      data_49 <= 8'h0; // @[RegStore.scala 156:10]
    end else if (_T_64) begin // @[RegStore.scala 137:26]
      if (io_rwPorts_0_req_bits_wen) begin // @[RegStore.scala 138:30]
        data_49 <= _GEN_577;
      end
    end
    if (reset) begin // @[RegStore.scala 104:21]
      data_50 <= 8'h0; // @[RegStore.scala 104:21]
    end else if (reset) begin // @[RegStore.scala 155:25]
      data_50 <= 8'h0; // @[RegStore.scala 156:10]
    end else if (_T_64) begin // @[RegStore.scala 137:26]
      if (io_rwPorts_0_req_bits_wen) begin // @[RegStore.scala 138:30]
        data_50 <= _GEN_578;
      end
    end
    if (reset) begin // @[RegStore.scala 104:21]
      data_51 <= 8'h0; // @[RegStore.scala 104:21]
    end else if (reset) begin // @[RegStore.scala 155:25]
      data_51 <= 8'h0; // @[RegStore.scala 156:10]
    end else if (_T_64) begin // @[RegStore.scala 137:26]
      if (io_rwPorts_0_req_bits_wen) begin // @[RegStore.scala 138:30]
        data_51 <= _GEN_579;
      end
    end
    if (reset) begin // @[RegStore.scala 104:21]
      data_52 <= 8'h0; // @[RegStore.scala 104:21]
    end else if (reset) begin // @[RegStore.scala 155:25]
      data_52 <= 8'h0; // @[RegStore.scala 156:10]
    end else if (_T_64) begin // @[RegStore.scala 137:26]
      if (io_rwPorts_0_req_bits_wen) begin // @[RegStore.scala 138:30]
        data_52 <= _GEN_580;
      end
    end
    if (reset) begin // @[RegStore.scala 104:21]
      data_53 <= 8'h0; // @[RegStore.scala 104:21]
    end else if (reset) begin // @[RegStore.scala 155:25]
      data_53 <= 8'h0; // @[RegStore.scala 156:10]
    end else if (_T_64) begin // @[RegStore.scala 137:26]
      if (io_rwPorts_0_req_bits_wen) begin // @[RegStore.scala 138:30]
        data_53 <= _GEN_581;
      end
    end
    if (reset) begin // @[RegStore.scala 104:21]
      data_54 <= 8'h0; // @[RegStore.scala 104:21]
    end else if (reset) begin // @[RegStore.scala 155:25]
      data_54 <= 8'h0; // @[RegStore.scala 156:10]
    end else if (_T_64) begin // @[RegStore.scala 137:26]
      if (io_rwPorts_0_req_bits_wen) begin // @[RegStore.scala 138:30]
        data_54 <= _GEN_582;
      end
    end
    if (reset) begin // @[RegStore.scala 104:21]
      data_55 <= 8'h0; // @[RegStore.scala 104:21]
    end else if (reset) begin // @[RegStore.scala 155:25]
      data_55 <= 8'h0; // @[RegStore.scala 156:10]
    end else if (_T_64) begin // @[RegStore.scala 137:26]
      if (io_rwPorts_0_req_bits_wen) begin // @[RegStore.scala 138:30]
        data_55 <= _GEN_583;
      end
    end
    if (reset) begin // @[RegStore.scala 104:21]
      data_56 <= 8'h0; // @[RegStore.scala 104:21]
    end else if (reset) begin // @[RegStore.scala 155:25]
      data_56 <= 8'h0; // @[RegStore.scala 156:10]
    end else if (_T_64) begin // @[RegStore.scala 137:26]
      if (io_rwPorts_0_req_bits_wen) begin // @[RegStore.scala 138:30]
        data_56 <= _GEN_584;
      end
    end
    if (reset) begin // @[RegStore.scala 104:21]
      data_57 <= 8'h0; // @[RegStore.scala 104:21]
    end else if (reset) begin // @[RegStore.scala 155:25]
      data_57 <= 8'h0; // @[RegStore.scala 156:10]
    end else if (_T_64) begin // @[RegStore.scala 137:26]
      if (io_rwPorts_0_req_bits_wen) begin // @[RegStore.scala 138:30]
        data_57 <= _GEN_585;
      end
    end
    if (reset) begin // @[RegStore.scala 104:21]
      data_58 <= 8'h0; // @[RegStore.scala 104:21]
    end else if (reset) begin // @[RegStore.scala 155:25]
      data_58 <= 8'h0; // @[RegStore.scala 156:10]
    end else if (_T_64) begin // @[RegStore.scala 137:26]
      if (io_rwPorts_0_req_bits_wen) begin // @[RegStore.scala 138:30]
        data_58 <= _GEN_586;
      end
    end
    if (reset) begin // @[RegStore.scala 104:21]
      data_59 <= 8'h0; // @[RegStore.scala 104:21]
    end else if (reset) begin // @[RegStore.scala 155:25]
      data_59 <= 8'h0; // @[RegStore.scala 156:10]
    end else if (_T_64) begin // @[RegStore.scala 137:26]
      if (io_rwPorts_0_req_bits_wen) begin // @[RegStore.scala 138:30]
        data_59 <= _GEN_587;
      end
    end
    if (reset) begin // @[RegStore.scala 104:21]
      data_60 <= 8'h0; // @[RegStore.scala 104:21]
    end else if (reset) begin // @[RegStore.scala 155:25]
      data_60 <= 8'h0; // @[RegStore.scala 156:10]
    end else if (_T_64) begin // @[RegStore.scala 137:26]
      if (io_rwPorts_0_req_bits_wen) begin // @[RegStore.scala 138:30]
        data_60 <= _GEN_588;
      end
    end
    if (reset) begin // @[RegStore.scala 104:21]
      data_61 <= 8'h0; // @[RegStore.scala 104:21]
    end else if (reset) begin // @[RegStore.scala 155:25]
      data_61 <= 8'h0; // @[RegStore.scala 156:10]
    end else if (_T_64) begin // @[RegStore.scala 137:26]
      if (io_rwPorts_0_req_bits_wen) begin // @[RegStore.scala 138:30]
        data_61 <= _GEN_589;
      end
    end
    if (reset) begin // @[RegStore.scala 104:21]
      data_62 <= 8'h0; // @[RegStore.scala 104:21]
    end else if (reset) begin // @[RegStore.scala 155:25]
      data_62 <= 8'h0; // @[RegStore.scala 156:10]
    end else if (_T_64) begin // @[RegStore.scala 137:26]
      if (io_rwPorts_0_req_bits_wen) begin // @[RegStore.scala 138:30]
        data_62 <= _GEN_590;
      end
    end
    if (reset) begin // @[RegStore.scala 104:21]
      data_63 <= 8'h0; // @[RegStore.scala 104:21]
    end else if (reset) begin // @[RegStore.scala 155:25]
      data_63 <= 8'h0; // @[RegStore.scala 156:10]
    end else if (_T_64) begin // @[RegStore.scala 137:26]
      if (io_rwPorts_0_req_bits_wen) begin // @[RegStore.scala 138:30]
        data_63 <= _GEN_591;
      end
    end
    `ifndef SYNTHESIS
    `ifdef PRINTF_COND
      if (`PRINTF_COND) begin
    `endif
        if (_T & ~(io_rPorts_0_rsp_ready | reset)) begin
          $fwrite(32'h80000002,
            "Assertion failed\n    at RegStore.scala:119 assert(rp.rsp.ready) // We cannot request data if we are not ready\n"
            ); // @[RegStore.scala 119:13]
        end
    `ifdef PRINTF_COND
      end
    `endif
    `endif // SYNTHESIS
    `ifndef SYNTHESIS
    `ifdef STOP_COND
      if (`STOP_COND) begin
    `endif
        if (_T & ~(io_rPorts_0_rsp_ready | reset)) begin
          $fatal; // @[RegStore.scala 119:13]
        end
    `ifdef STOP_COND
      end
    `endif
    `endif // SYNTHESIS
    `ifndef SYNTHESIS
    `ifdef PRINTF_COND
      if (`PRINTF_COND) begin
    `endif
        if (_T_8 & ~(io_rPorts_1_rsp_ready | reset)) begin
          $fwrite(32'h80000002,
            "Assertion failed\n    at RegStore.scala:119 assert(rp.rsp.ready) // We cannot request data if we are not ready\n"
            ); // @[RegStore.scala 119:13]
        end
    `ifdef PRINTF_COND
      end
    `endif
    `endif // SYNTHESIS
    `ifndef SYNTHESIS
    `ifdef STOP_COND
      if (`STOP_COND) begin
    `endif
        if (_T_8 & ~(io_rPorts_1_rsp_ready | reset)) begin
          $fatal; // @[RegStore.scala 119:13]
        end
    `ifdef STOP_COND
      end
    `endif
    `endif // SYNTHESIS
    `ifndef SYNTHESIS
    `ifdef PRINTF_COND
      if (`PRINTF_COND) begin
    `endif
        if (_T_16 & ~(io_rPorts_2_rsp_ready | reset)) begin
          $fwrite(32'h80000002,
            "Assertion failed\n    at RegStore.scala:119 assert(rp.rsp.ready) // We cannot request data if we are not ready\n"
            ); // @[RegStore.scala 119:13]
        end
    `ifdef PRINTF_COND
      end
    `endif
    `endif // SYNTHESIS
    `ifndef SYNTHESIS
    `ifdef STOP_COND
      if (`STOP_COND) begin
    `endif
        if (_T_16 & ~(io_rPorts_2_rsp_ready | reset)) begin
          $fatal; // @[RegStore.scala 119:13]
        end
    `ifdef STOP_COND
      end
    `endif
    `endif // SYNTHESIS
    `ifndef SYNTHESIS
    `ifdef PRINTF_COND
      if (`PRINTF_COND) begin
    `endif
        if (_T_24 & ~(io_rPorts_3_rsp_ready | reset)) begin
          $fwrite(32'h80000002,
            "Assertion failed\n    at RegStore.scala:119 assert(rp.rsp.ready) // We cannot request data if we are not ready\n"
            ); // @[RegStore.scala 119:13]
        end
    `ifdef PRINTF_COND
      end
    `endif
    `endif // SYNTHESIS
    `ifndef SYNTHESIS
    `ifdef STOP_COND
      if (`STOP_COND) begin
    `endif
        if (_T_24 & ~(io_rPorts_3_rsp_ready | reset)) begin
          $fatal; // @[RegStore.scala 119:13]
        end
    `ifdef STOP_COND
      end
    `endif
    `endif // SYNTHESIS
    `ifndef SYNTHESIS
    `ifdef PRINTF_COND
      if (`PRINTF_COND) begin
    `endif
        if (_T_32 & ~(io_rPorts_4_rsp_ready | reset)) begin
          $fwrite(32'h80000002,
            "Assertion failed\n    at RegStore.scala:119 assert(rp.rsp.ready) // We cannot request data if we are not ready\n"
            ); // @[RegStore.scala 119:13]
        end
    `ifdef PRINTF_COND
      end
    `endif
    `endif // SYNTHESIS
    `ifndef SYNTHESIS
    `ifdef STOP_COND
      if (`STOP_COND) begin
    `endif
        if (_T_32 & ~(io_rPorts_4_rsp_ready | reset)) begin
          $fatal; // @[RegStore.scala 119:13]
        end
    `ifdef STOP_COND
      end
    `endif
    `endif // SYNTHESIS
    `ifndef SYNTHESIS
    `ifdef PRINTF_COND
      if (`PRINTF_COND) begin
    `endif
        if (_T_40 & ~(io_rPorts_5_rsp_ready | reset)) begin
          $fwrite(32'h80000002,
            "Assertion failed\n    at RegStore.scala:119 assert(rp.rsp.ready) // We cannot request data if we are not ready\n"
            ); // @[RegStore.scala 119:13]
        end
    `ifdef PRINTF_COND
      end
    `endif
    `endif // SYNTHESIS
    `ifndef SYNTHESIS
    `ifdef STOP_COND
      if (`STOP_COND) begin
    `endif
        if (_T_40 & ~(io_rPorts_5_rsp_ready | reset)) begin
          $fatal; // @[RegStore.scala 119:13]
        end
    `ifdef STOP_COND
      end
    `endif
    `endif // SYNTHESIS
    `ifndef SYNTHESIS
    `ifdef PRINTF_COND
      if (`PRINTF_COND) begin
    `endif
        if (_T_48 & ~(io_rPorts_6_rsp_ready | reset)) begin
          $fwrite(32'h80000002,
            "Assertion failed\n    at RegStore.scala:119 assert(rp.rsp.ready) // We cannot request data if we are not ready\n"
            ); // @[RegStore.scala 119:13]
        end
    `ifdef PRINTF_COND
      end
    `endif
    `endif // SYNTHESIS
    `ifndef SYNTHESIS
    `ifdef STOP_COND
      if (`STOP_COND) begin
    `endif
        if (_T_48 & ~(io_rPorts_6_rsp_ready | reset)) begin
          $fatal; // @[RegStore.scala 119:13]
        end
    `ifdef STOP_COND
      end
    `endif
    `endif // SYNTHESIS
    `ifndef SYNTHESIS
    `ifdef PRINTF_COND
      if (`PRINTF_COND) begin
    `endif
        if (_T_56 & ~(io_rPorts_7_rsp_ready | reset)) begin
          $fwrite(32'h80000002,
            "Assertion failed\n    at RegStore.scala:119 assert(rp.rsp.ready) // We cannot request data if we are not ready\n"
            ); // @[RegStore.scala 119:13]
        end
    `ifdef PRINTF_COND
      end
    `endif
    `endif // SYNTHESIS
    `ifndef SYNTHESIS
    `ifdef STOP_COND
      if (`STOP_COND) begin
    `endif
        if (_T_56 & ~(io_rPorts_7_rsp_ready | reset)) begin
          $fatal; // @[RegStore.scala 119:13]
        end
    `ifdef STOP_COND
      end
    `endif
    `endif // SYNTHESIS
  end
// Register and memory initialization
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
  data_0 = _RAND_0[7:0];
  _RAND_1 = {1{`RANDOM}};
  data_1 = _RAND_1[7:0];
  _RAND_2 = {1{`RANDOM}};
  data_2 = _RAND_2[7:0];
  _RAND_3 = {1{`RANDOM}};
  data_3 = _RAND_3[7:0];
  _RAND_4 = {1{`RANDOM}};
  data_4 = _RAND_4[7:0];
  _RAND_5 = {1{`RANDOM}};
  data_5 = _RAND_5[7:0];
  _RAND_6 = {1{`RANDOM}};
  data_6 = _RAND_6[7:0];
  _RAND_7 = {1{`RANDOM}};
  data_7 = _RAND_7[7:0];
  _RAND_8 = {1{`RANDOM}};
  data_8 = _RAND_8[7:0];
  _RAND_9 = {1{`RANDOM}};
  data_9 = _RAND_9[7:0];
  _RAND_10 = {1{`RANDOM}};
  data_10 = _RAND_10[7:0];
  _RAND_11 = {1{`RANDOM}};
  data_11 = _RAND_11[7:0];
  _RAND_12 = {1{`RANDOM}};
  data_12 = _RAND_12[7:0];
  _RAND_13 = {1{`RANDOM}};
  data_13 = _RAND_13[7:0];
  _RAND_14 = {1{`RANDOM}};
  data_14 = _RAND_14[7:0];
  _RAND_15 = {1{`RANDOM}};
  data_15 = _RAND_15[7:0];
  _RAND_16 = {1{`RANDOM}};
  data_16 = _RAND_16[7:0];
  _RAND_17 = {1{`RANDOM}};
  data_17 = _RAND_17[7:0];
  _RAND_18 = {1{`RANDOM}};
  data_18 = _RAND_18[7:0];
  _RAND_19 = {1{`RANDOM}};
  data_19 = _RAND_19[7:0];
  _RAND_20 = {1{`RANDOM}};
  data_20 = _RAND_20[7:0];
  _RAND_21 = {1{`RANDOM}};
  data_21 = _RAND_21[7:0];
  _RAND_22 = {1{`RANDOM}};
  data_22 = _RAND_22[7:0];
  _RAND_23 = {1{`RANDOM}};
  data_23 = _RAND_23[7:0];
  _RAND_24 = {1{`RANDOM}};
  data_24 = _RAND_24[7:0];
  _RAND_25 = {1{`RANDOM}};
  data_25 = _RAND_25[7:0];
  _RAND_26 = {1{`RANDOM}};
  data_26 = _RAND_26[7:0];
  _RAND_27 = {1{`RANDOM}};
  data_27 = _RAND_27[7:0];
  _RAND_28 = {1{`RANDOM}};
  data_28 = _RAND_28[7:0];
  _RAND_29 = {1{`RANDOM}};
  data_29 = _RAND_29[7:0];
  _RAND_30 = {1{`RANDOM}};
  data_30 = _RAND_30[7:0];
  _RAND_31 = {1{`RANDOM}};
  data_31 = _RAND_31[7:0];
  _RAND_32 = {1{`RANDOM}};
  data_32 = _RAND_32[7:0];
  _RAND_33 = {1{`RANDOM}};
  data_33 = _RAND_33[7:0];
  _RAND_34 = {1{`RANDOM}};
  data_34 = _RAND_34[7:0];
  _RAND_35 = {1{`RANDOM}};
  data_35 = _RAND_35[7:0];
  _RAND_36 = {1{`RANDOM}};
  data_36 = _RAND_36[7:0];
  _RAND_37 = {1{`RANDOM}};
  data_37 = _RAND_37[7:0];
  _RAND_38 = {1{`RANDOM}};
  data_38 = _RAND_38[7:0];
  _RAND_39 = {1{`RANDOM}};
  data_39 = _RAND_39[7:0];
  _RAND_40 = {1{`RANDOM}};
  data_40 = _RAND_40[7:0];
  _RAND_41 = {1{`RANDOM}};
  data_41 = _RAND_41[7:0];
  _RAND_42 = {1{`RANDOM}};
  data_42 = _RAND_42[7:0];
  _RAND_43 = {1{`RANDOM}};
  data_43 = _RAND_43[7:0];
  _RAND_44 = {1{`RANDOM}};
  data_44 = _RAND_44[7:0];
  _RAND_45 = {1{`RANDOM}};
  data_45 = _RAND_45[7:0];
  _RAND_46 = {1{`RANDOM}};
  data_46 = _RAND_46[7:0];
  _RAND_47 = {1{`RANDOM}};
  data_47 = _RAND_47[7:0];
  _RAND_48 = {1{`RANDOM}};
  data_48 = _RAND_48[7:0];
  _RAND_49 = {1{`RANDOM}};
  data_49 = _RAND_49[7:0];
  _RAND_50 = {1{`RANDOM}};
  data_50 = _RAND_50[7:0];
  _RAND_51 = {1{`RANDOM}};
  data_51 = _RAND_51[7:0];
  _RAND_52 = {1{`RANDOM}};
  data_52 = _RAND_52[7:0];
  _RAND_53 = {1{`RANDOM}};
  data_53 = _RAND_53[7:0];
  _RAND_54 = {1{`RANDOM}};
  data_54 = _RAND_54[7:0];
  _RAND_55 = {1{`RANDOM}};
  data_55 = _RAND_55[7:0];
  _RAND_56 = {1{`RANDOM}};
  data_56 = _RAND_56[7:0];
  _RAND_57 = {1{`RANDOM}};
  data_57 = _RAND_57[7:0];
  _RAND_58 = {1{`RANDOM}};
  data_58 = _RAND_58[7:0];
  _RAND_59 = {1{`RANDOM}};
  data_59 = _RAND_59[7:0];
  _RAND_60 = {1{`RANDOM}};
  data_60 = _RAND_60[7:0];
  _RAND_61 = {1{`RANDOM}};
  data_61 = _RAND_61[7:0];
  _RAND_62 = {1{`RANDOM}};
  data_62 = _RAND_62[7:0];
  _RAND_63 = {1{`RANDOM}};
  data_63 = _RAND_63[7:0];
`endif // RANDOMIZE_REG_INIT
  `endif // RANDOMIZE
end // initial
`ifdef FIRRTL_AFTER_INITIAL
`FIRRTL_AFTER_INITIAL
`endif
`endif // SYNTHESIS
endmodule
module RegStore_1(
  input        clock,
  input        reset,
  output       io_wPorts_0_req_ready,
  input        io_wPorts_0_req_valid,
  input  [5:0] io_wPorts_0_req_bits_addr,
  input  [6:0] io_wPorts_0_req_bits_wdata_rowAddr,
  input  [5:0] io_wPorts_0_req_bits_wdata_length,
  output       io_rPorts_0_req_ready,
  input        io_rPorts_0_req_valid,
  input  [5:0] io_rPorts_0_req_bits_addr,
  input        io_rPorts_0_rsp_ready,
  output [6:0] io_rPorts_0_rsp_bits_rdata_rowAddr,
  output [5:0] io_rPorts_0_rsp_bits_rdata_length
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
  reg [31:0] _RAND_13;
  reg [31:0] _RAND_14;
  reg [31:0] _RAND_15;
  reg [31:0] _RAND_16;
  reg [31:0] _RAND_17;
  reg [31:0] _RAND_18;
  reg [31:0] _RAND_19;
  reg [31:0] _RAND_20;
  reg [31:0] _RAND_21;
  reg [31:0] _RAND_22;
  reg [31:0] _RAND_23;
  reg [31:0] _RAND_24;
  reg [31:0] _RAND_25;
  reg [31:0] _RAND_26;
  reg [31:0] _RAND_27;
  reg [31:0] _RAND_28;
  reg [31:0] _RAND_29;
  reg [31:0] _RAND_30;
  reg [31:0] _RAND_31;
  reg [31:0] _RAND_32;
  reg [31:0] _RAND_33;
  reg [31:0] _RAND_34;
  reg [31:0] _RAND_35;
  reg [31:0] _RAND_36;
  reg [31:0] _RAND_37;
  reg [31:0] _RAND_38;
  reg [31:0] _RAND_39;
  reg [31:0] _RAND_40;
  reg [31:0] _RAND_41;
  reg [31:0] _RAND_42;
  reg [31:0] _RAND_43;
  reg [31:0] _RAND_44;
  reg [31:0] _RAND_45;
  reg [31:0] _RAND_46;
  reg [31:0] _RAND_47;
  reg [31:0] _RAND_48;
  reg [31:0] _RAND_49;
  reg [31:0] _RAND_50;
  reg [31:0] _RAND_51;
  reg [31:0] _RAND_52;
  reg [31:0] _RAND_53;
  reg [31:0] _RAND_54;
  reg [31:0] _RAND_55;
  reg [31:0] _RAND_56;
  reg [31:0] _RAND_57;
  reg [31:0] _RAND_58;
  reg [31:0] _RAND_59;
  reg [31:0] _RAND_60;
  reg [31:0] _RAND_61;
  reg [31:0] _RAND_62;
  reg [31:0] _RAND_63;
  reg [31:0] _RAND_64;
  reg [31:0] _RAND_65;
  reg [31:0] _RAND_66;
  reg [31:0] _RAND_67;
  reg [31:0] _RAND_68;
  reg [31:0] _RAND_69;
  reg [31:0] _RAND_70;
  reg [31:0] _RAND_71;
  reg [31:0] _RAND_72;
  reg [31:0] _RAND_73;
  reg [31:0] _RAND_74;
  reg [31:0] _RAND_75;
  reg [31:0] _RAND_76;
  reg [31:0] _RAND_77;
  reg [31:0] _RAND_78;
  reg [31:0] _RAND_79;
  reg [31:0] _RAND_80;
  reg [31:0] _RAND_81;
  reg [31:0] _RAND_82;
  reg [31:0] _RAND_83;
  reg [31:0] _RAND_84;
  reg [31:0] _RAND_85;
  reg [31:0] _RAND_86;
  reg [31:0] _RAND_87;
  reg [31:0] _RAND_88;
  reg [31:0] _RAND_89;
  reg [31:0] _RAND_90;
  reg [31:0] _RAND_91;
  reg [31:0] _RAND_92;
  reg [31:0] _RAND_93;
  reg [31:0] _RAND_94;
  reg [31:0] _RAND_95;
  reg [31:0] _RAND_96;
  reg [31:0] _RAND_97;
  reg [31:0] _RAND_98;
  reg [31:0] _RAND_99;
  reg [31:0] _RAND_100;
  reg [31:0] _RAND_101;
  reg [31:0] _RAND_102;
  reg [31:0] _RAND_103;
  reg [31:0] _RAND_104;
  reg [31:0] _RAND_105;
  reg [31:0] _RAND_106;
  reg [31:0] _RAND_107;
  reg [31:0] _RAND_108;
  reg [31:0] _RAND_109;
  reg [31:0] _RAND_110;
  reg [31:0] _RAND_111;
  reg [31:0] _RAND_112;
  reg [31:0] _RAND_113;
  reg [31:0] _RAND_114;
  reg [31:0] _RAND_115;
  reg [31:0] _RAND_116;
  reg [31:0] _RAND_117;
  reg [31:0] _RAND_118;
  reg [31:0] _RAND_119;
  reg [31:0] _RAND_120;
  reg [31:0] _RAND_121;
  reg [31:0] _RAND_122;
  reg [31:0] _RAND_123;
  reg [31:0] _RAND_124;
  reg [31:0] _RAND_125;
  reg [31:0] _RAND_126;
  reg [31:0] _RAND_127;
`endif // RANDOMIZE_REG_INIT
  reg [6:0] data_0_rowAddr; // @[RegStore.scala 104:21]
  reg [5:0] data_0_length; // @[RegStore.scala 104:21]
  reg [6:0] data_1_rowAddr; // @[RegStore.scala 104:21]
  reg [5:0] data_1_length; // @[RegStore.scala 104:21]
  reg [6:0] data_2_rowAddr; // @[RegStore.scala 104:21]
  reg [5:0] data_2_length; // @[RegStore.scala 104:21]
  reg [6:0] data_3_rowAddr; // @[RegStore.scala 104:21]
  reg [5:0] data_3_length; // @[RegStore.scala 104:21]
  reg [6:0] data_4_rowAddr; // @[RegStore.scala 104:21]
  reg [5:0] data_4_length; // @[RegStore.scala 104:21]
  reg [6:0] data_5_rowAddr; // @[RegStore.scala 104:21]
  reg [5:0] data_5_length; // @[RegStore.scala 104:21]
  reg [6:0] data_6_rowAddr; // @[RegStore.scala 104:21]
  reg [5:0] data_6_length; // @[RegStore.scala 104:21]
  reg [6:0] data_7_rowAddr; // @[RegStore.scala 104:21]
  reg [5:0] data_7_length; // @[RegStore.scala 104:21]
  reg [6:0] data_8_rowAddr; // @[RegStore.scala 104:21]
  reg [5:0] data_8_length; // @[RegStore.scala 104:21]
  reg [6:0] data_9_rowAddr; // @[RegStore.scala 104:21]
  reg [5:0] data_9_length; // @[RegStore.scala 104:21]
  reg [6:0] data_10_rowAddr; // @[RegStore.scala 104:21]
  reg [5:0] data_10_length; // @[RegStore.scala 104:21]
  reg [6:0] data_11_rowAddr; // @[RegStore.scala 104:21]
  reg [5:0] data_11_length; // @[RegStore.scala 104:21]
  reg [6:0] data_12_rowAddr; // @[RegStore.scala 104:21]
  reg [5:0] data_12_length; // @[RegStore.scala 104:21]
  reg [6:0] data_13_rowAddr; // @[RegStore.scala 104:21]
  reg [5:0] data_13_length; // @[RegStore.scala 104:21]
  reg [6:0] data_14_rowAddr; // @[RegStore.scala 104:21]
  reg [5:0] data_14_length; // @[RegStore.scala 104:21]
  reg [6:0] data_15_rowAddr; // @[RegStore.scala 104:21]
  reg [5:0] data_15_length; // @[RegStore.scala 104:21]
  reg [6:0] data_16_rowAddr; // @[RegStore.scala 104:21]
  reg [5:0] data_16_length; // @[RegStore.scala 104:21]
  reg [6:0] data_17_rowAddr; // @[RegStore.scala 104:21]
  reg [5:0] data_17_length; // @[RegStore.scala 104:21]
  reg [6:0] data_18_rowAddr; // @[RegStore.scala 104:21]
  reg [5:0] data_18_length; // @[RegStore.scala 104:21]
  reg [6:0] data_19_rowAddr; // @[RegStore.scala 104:21]
  reg [5:0] data_19_length; // @[RegStore.scala 104:21]
  reg [6:0] data_20_rowAddr; // @[RegStore.scala 104:21]
  reg [5:0] data_20_length; // @[RegStore.scala 104:21]
  reg [6:0] data_21_rowAddr; // @[RegStore.scala 104:21]
  reg [5:0] data_21_length; // @[RegStore.scala 104:21]
  reg [6:0] data_22_rowAddr; // @[RegStore.scala 104:21]
  reg [5:0] data_22_length; // @[RegStore.scala 104:21]
  reg [6:0] data_23_rowAddr; // @[RegStore.scala 104:21]
  reg [5:0] data_23_length; // @[RegStore.scala 104:21]
  reg [6:0] data_24_rowAddr; // @[RegStore.scala 104:21]
  reg [5:0] data_24_length; // @[RegStore.scala 104:21]
  reg [6:0] data_25_rowAddr; // @[RegStore.scala 104:21]
  reg [5:0] data_25_length; // @[RegStore.scala 104:21]
  reg [6:0] data_26_rowAddr; // @[RegStore.scala 104:21]
  reg [5:0] data_26_length; // @[RegStore.scala 104:21]
  reg [6:0] data_27_rowAddr; // @[RegStore.scala 104:21]
  reg [5:0] data_27_length; // @[RegStore.scala 104:21]
  reg [6:0] data_28_rowAddr; // @[RegStore.scala 104:21]
  reg [5:0] data_28_length; // @[RegStore.scala 104:21]
  reg [6:0] data_29_rowAddr; // @[RegStore.scala 104:21]
  reg [5:0] data_29_length; // @[RegStore.scala 104:21]
  reg [6:0] data_30_rowAddr; // @[RegStore.scala 104:21]
  reg [5:0] data_30_length; // @[RegStore.scala 104:21]
  reg [6:0] data_31_rowAddr; // @[RegStore.scala 104:21]
  reg [5:0] data_31_length; // @[RegStore.scala 104:21]
  reg [6:0] data_32_rowAddr; // @[RegStore.scala 104:21]
  reg [5:0] data_32_length; // @[RegStore.scala 104:21]
  reg [6:0] data_33_rowAddr; // @[RegStore.scala 104:21]
  reg [5:0] data_33_length; // @[RegStore.scala 104:21]
  reg [6:0] data_34_rowAddr; // @[RegStore.scala 104:21]
  reg [5:0] data_34_length; // @[RegStore.scala 104:21]
  reg [6:0] data_35_rowAddr; // @[RegStore.scala 104:21]
  reg [5:0] data_35_length; // @[RegStore.scala 104:21]
  reg [6:0] data_36_rowAddr; // @[RegStore.scala 104:21]
  reg [5:0] data_36_length; // @[RegStore.scala 104:21]
  reg [6:0] data_37_rowAddr; // @[RegStore.scala 104:21]
  reg [5:0] data_37_length; // @[RegStore.scala 104:21]
  reg [6:0] data_38_rowAddr; // @[RegStore.scala 104:21]
  reg [5:0] data_38_length; // @[RegStore.scala 104:21]
  reg [6:0] data_39_rowAddr; // @[RegStore.scala 104:21]
  reg [5:0] data_39_length; // @[RegStore.scala 104:21]
  reg [6:0] data_40_rowAddr; // @[RegStore.scala 104:21]
  reg [5:0] data_40_length; // @[RegStore.scala 104:21]
  reg [6:0] data_41_rowAddr; // @[RegStore.scala 104:21]
  reg [5:0] data_41_length; // @[RegStore.scala 104:21]
  reg [6:0] data_42_rowAddr; // @[RegStore.scala 104:21]
  reg [5:0] data_42_length; // @[RegStore.scala 104:21]
  reg [6:0] data_43_rowAddr; // @[RegStore.scala 104:21]
  reg [5:0] data_43_length; // @[RegStore.scala 104:21]
  reg [6:0] data_44_rowAddr; // @[RegStore.scala 104:21]
  reg [5:0] data_44_length; // @[RegStore.scala 104:21]
  reg [6:0] data_45_rowAddr; // @[RegStore.scala 104:21]
  reg [5:0] data_45_length; // @[RegStore.scala 104:21]
  reg [6:0] data_46_rowAddr; // @[RegStore.scala 104:21]
  reg [5:0] data_46_length; // @[RegStore.scala 104:21]
  reg [6:0] data_47_rowAddr; // @[RegStore.scala 104:21]
  reg [5:0] data_47_length; // @[RegStore.scala 104:21]
  reg [6:0] data_48_rowAddr; // @[RegStore.scala 104:21]
  reg [5:0] data_48_length; // @[RegStore.scala 104:21]
  reg [6:0] data_49_rowAddr; // @[RegStore.scala 104:21]
  reg [5:0] data_49_length; // @[RegStore.scala 104:21]
  reg [6:0] data_50_rowAddr; // @[RegStore.scala 104:21]
  reg [5:0] data_50_length; // @[RegStore.scala 104:21]
  reg [6:0] data_51_rowAddr; // @[RegStore.scala 104:21]
  reg [5:0] data_51_length; // @[RegStore.scala 104:21]
  reg [6:0] data_52_rowAddr; // @[RegStore.scala 104:21]
  reg [5:0] data_52_length; // @[RegStore.scala 104:21]
  reg [6:0] data_53_rowAddr; // @[RegStore.scala 104:21]
  reg [5:0] data_53_length; // @[RegStore.scala 104:21]
  reg [6:0] data_54_rowAddr; // @[RegStore.scala 104:21]
  reg [5:0] data_54_length; // @[RegStore.scala 104:21]
  reg [6:0] data_55_rowAddr; // @[RegStore.scala 104:21]
  reg [5:0] data_55_length; // @[RegStore.scala 104:21]
  reg [6:0] data_56_rowAddr; // @[RegStore.scala 104:21]
  reg [5:0] data_56_length; // @[RegStore.scala 104:21]
  reg [6:0] data_57_rowAddr; // @[RegStore.scala 104:21]
  reg [5:0] data_57_length; // @[RegStore.scala 104:21]
  reg [6:0] data_58_rowAddr; // @[RegStore.scala 104:21]
  reg [5:0] data_58_length; // @[RegStore.scala 104:21]
  reg [6:0] data_59_rowAddr; // @[RegStore.scala 104:21]
  reg [5:0] data_59_length; // @[RegStore.scala 104:21]
  reg [6:0] data_60_rowAddr; // @[RegStore.scala 104:21]
  reg [5:0] data_60_length; // @[RegStore.scala 104:21]
  reg [6:0] data_61_rowAddr; // @[RegStore.scala 104:21]
  reg [5:0] data_61_length; // @[RegStore.scala 104:21]
  reg [6:0] data_62_rowAddr; // @[RegStore.scala 104:21]
  reg [5:0] data_62_length; // @[RegStore.scala 104:21]
  reg [6:0] data_63_rowAddr; // @[RegStore.scala 104:21]
  reg [5:0] data_63_length; // @[RegStore.scala 104:21]
  wire  _T = io_wPorts_0_req_ready & io_wPorts_0_req_valid; // @[Decoupled.scala 40:37]
  wire  _T_4 = io_rPorts_0_req_ready & io_rPorts_0_req_valid; // @[Decoupled.scala 40:37]
  wire [6:0] _GEN_258 = 6'h1 == io_rPorts_0_req_bits_addr ? data_1_rowAddr : data_0_rowAddr; // @[]
  wire [5:0] _GEN_259 = 6'h1 == io_rPorts_0_req_bits_addr ? data_1_length : data_0_length; // @[]
  wire [6:0] _GEN_260 = 6'h2 == io_rPorts_0_req_bits_addr ? data_2_rowAddr : _GEN_258; // @[]
  wire [5:0] _GEN_261 = 6'h2 == io_rPorts_0_req_bits_addr ? data_2_length : _GEN_259; // @[]
  wire [6:0] _GEN_262 = 6'h3 == io_rPorts_0_req_bits_addr ? data_3_rowAddr : _GEN_260; // @[]
  wire [5:0] _GEN_263 = 6'h3 == io_rPorts_0_req_bits_addr ? data_3_length : _GEN_261; // @[]
  wire [6:0] _GEN_264 = 6'h4 == io_rPorts_0_req_bits_addr ? data_4_rowAddr : _GEN_262; // @[]
  wire [5:0] _GEN_265 = 6'h4 == io_rPorts_0_req_bits_addr ? data_4_length : _GEN_263; // @[]
  wire [6:0] _GEN_266 = 6'h5 == io_rPorts_0_req_bits_addr ? data_5_rowAddr : _GEN_264; // @[]
  wire [5:0] _GEN_267 = 6'h5 == io_rPorts_0_req_bits_addr ? data_5_length : _GEN_265; // @[]
  wire [6:0] _GEN_268 = 6'h6 == io_rPorts_0_req_bits_addr ? data_6_rowAddr : _GEN_266; // @[]
  wire [5:0] _GEN_269 = 6'h6 == io_rPorts_0_req_bits_addr ? data_6_length : _GEN_267; // @[]
  wire [6:0] _GEN_270 = 6'h7 == io_rPorts_0_req_bits_addr ? data_7_rowAddr : _GEN_268; // @[]
  wire [5:0] _GEN_271 = 6'h7 == io_rPorts_0_req_bits_addr ? data_7_length : _GEN_269; // @[]
  wire [6:0] _GEN_272 = 6'h8 == io_rPorts_0_req_bits_addr ? data_8_rowAddr : _GEN_270; // @[]
  wire [5:0] _GEN_273 = 6'h8 == io_rPorts_0_req_bits_addr ? data_8_length : _GEN_271; // @[]
  wire [6:0] _GEN_274 = 6'h9 == io_rPorts_0_req_bits_addr ? data_9_rowAddr : _GEN_272; // @[]
  wire [5:0] _GEN_275 = 6'h9 == io_rPorts_0_req_bits_addr ? data_9_length : _GEN_273; // @[]
  wire [6:0] _GEN_276 = 6'ha == io_rPorts_0_req_bits_addr ? data_10_rowAddr : _GEN_274; // @[]
  wire [5:0] _GEN_277 = 6'ha == io_rPorts_0_req_bits_addr ? data_10_length : _GEN_275; // @[]
  wire [6:0] _GEN_278 = 6'hb == io_rPorts_0_req_bits_addr ? data_11_rowAddr : _GEN_276; // @[]
  wire [5:0] _GEN_279 = 6'hb == io_rPorts_0_req_bits_addr ? data_11_length : _GEN_277; // @[]
  wire [6:0] _GEN_280 = 6'hc == io_rPorts_0_req_bits_addr ? data_12_rowAddr : _GEN_278; // @[]
  wire [5:0] _GEN_281 = 6'hc == io_rPorts_0_req_bits_addr ? data_12_length : _GEN_279; // @[]
  wire [6:0] _GEN_282 = 6'hd == io_rPorts_0_req_bits_addr ? data_13_rowAddr : _GEN_280; // @[]
  wire [5:0] _GEN_283 = 6'hd == io_rPorts_0_req_bits_addr ? data_13_length : _GEN_281; // @[]
  wire [6:0] _GEN_284 = 6'he == io_rPorts_0_req_bits_addr ? data_14_rowAddr : _GEN_282; // @[]
  wire [5:0] _GEN_285 = 6'he == io_rPorts_0_req_bits_addr ? data_14_length : _GEN_283; // @[]
  wire [6:0] _GEN_286 = 6'hf == io_rPorts_0_req_bits_addr ? data_15_rowAddr : _GEN_284; // @[]
  wire [5:0] _GEN_287 = 6'hf == io_rPorts_0_req_bits_addr ? data_15_length : _GEN_285; // @[]
  wire [6:0] _GEN_288 = 6'h10 == io_rPorts_0_req_bits_addr ? data_16_rowAddr : _GEN_286; // @[]
  wire [5:0] _GEN_289 = 6'h10 == io_rPorts_0_req_bits_addr ? data_16_length : _GEN_287; // @[]
  wire [6:0] _GEN_290 = 6'h11 == io_rPorts_0_req_bits_addr ? data_17_rowAddr : _GEN_288; // @[]
  wire [5:0] _GEN_291 = 6'h11 == io_rPorts_0_req_bits_addr ? data_17_length : _GEN_289; // @[]
  wire [6:0] _GEN_292 = 6'h12 == io_rPorts_0_req_bits_addr ? data_18_rowAddr : _GEN_290; // @[]
  wire [5:0] _GEN_293 = 6'h12 == io_rPorts_0_req_bits_addr ? data_18_length : _GEN_291; // @[]
  wire [6:0] _GEN_294 = 6'h13 == io_rPorts_0_req_bits_addr ? data_19_rowAddr : _GEN_292; // @[]
  wire [5:0] _GEN_295 = 6'h13 == io_rPorts_0_req_bits_addr ? data_19_length : _GEN_293; // @[]
  wire [6:0] _GEN_296 = 6'h14 == io_rPorts_0_req_bits_addr ? data_20_rowAddr : _GEN_294; // @[]
  wire [5:0] _GEN_297 = 6'h14 == io_rPorts_0_req_bits_addr ? data_20_length : _GEN_295; // @[]
  wire [6:0] _GEN_298 = 6'h15 == io_rPorts_0_req_bits_addr ? data_21_rowAddr : _GEN_296; // @[]
  wire [5:0] _GEN_299 = 6'h15 == io_rPorts_0_req_bits_addr ? data_21_length : _GEN_297; // @[]
  wire [6:0] _GEN_300 = 6'h16 == io_rPorts_0_req_bits_addr ? data_22_rowAddr : _GEN_298; // @[]
  wire [5:0] _GEN_301 = 6'h16 == io_rPorts_0_req_bits_addr ? data_22_length : _GEN_299; // @[]
  wire [6:0] _GEN_302 = 6'h17 == io_rPorts_0_req_bits_addr ? data_23_rowAddr : _GEN_300; // @[]
  wire [5:0] _GEN_303 = 6'h17 == io_rPorts_0_req_bits_addr ? data_23_length : _GEN_301; // @[]
  wire [6:0] _GEN_304 = 6'h18 == io_rPorts_0_req_bits_addr ? data_24_rowAddr : _GEN_302; // @[]
  wire [5:0] _GEN_305 = 6'h18 == io_rPorts_0_req_bits_addr ? data_24_length : _GEN_303; // @[]
  wire [6:0] _GEN_306 = 6'h19 == io_rPorts_0_req_bits_addr ? data_25_rowAddr : _GEN_304; // @[]
  wire [5:0] _GEN_307 = 6'h19 == io_rPorts_0_req_bits_addr ? data_25_length : _GEN_305; // @[]
  wire [6:0] _GEN_308 = 6'h1a == io_rPorts_0_req_bits_addr ? data_26_rowAddr : _GEN_306; // @[]
  wire [5:0] _GEN_309 = 6'h1a == io_rPorts_0_req_bits_addr ? data_26_length : _GEN_307; // @[]
  wire [6:0] _GEN_310 = 6'h1b == io_rPorts_0_req_bits_addr ? data_27_rowAddr : _GEN_308; // @[]
  wire [5:0] _GEN_311 = 6'h1b == io_rPorts_0_req_bits_addr ? data_27_length : _GEN_309; // @[]
  wire [6:0] _GEN_312 = 6'h1c == io_rPorts_0_req_bits_addr ? data_28_rowAddr : _GEN_310; // @[]
  wire [5:0] _GEN_313 = 6'h1c == io_rPorts_0_req_bits_addr ? data_28_length : _GEN_311; // @[]
  wire [6:0] _GEN_314 = 6'h1d == io_rPorts_0_req_bits_addr ? data_29_rowAddr : _GEN_312; // @[]
  wire [5:0] _GEN_315 = 6'h1d == io_rPorts_0_req_bits_addr ? data_29_length : _GEN_313; // @[]
  wire [6:0] _GEN_316 = 6'h1e == io_rPorts_0_req_bits_addr ? data_30_rowAddr : _GEN_314; // @[]
  wire [5:0] _GEN_317 = 6'h1e == io_rPorts_0_req_bits_addr ? data_30_length : _GEN_315; // @[]
  wire [6:0] _GEN_318 = 6'h1f == io_rPorts_0_req_bits_addr ? data_31_rowAddr : _GEN_316; // @[]
  wire [5:0] _GEN_319 = 6'h1f == io_rPorts_0_req_bits_addr ? data_31_length : _GEN_317; // @[]
  wire [6:0] _GEN_320 = 6'h20 == io_rPorts_0_req_bits_addr ? data_32_rowAddr : _GEN_318; // @[]
  wire [5:0] _GEN_321 = 6'h20 == io_rPorts_0_req_bits_addr ? data_32_length : _GEN_319; // @[]
  wire [6:0] _GEN_322 = 6'h21 == io_rPorts_0_req_bits_addr ? data_33_rowAddr : _GEN_320; // @[]
  wire [5:0] _GEN_323 = 6'h21 == io_rPorts_0_req_bits_addr ? data_33_length : _GEN_321; // @[]
  wire [6:0] _GEN_324 = 6'h22 == io_rPorts_0_req_bits_addr ? data_34_rowAddr : _GEN_322; // @[]
  wire [5:0] _GEN_325 = 6'h22 == io_rPorts_0_req_bits_addr ? data_34_length : _GEN_323; // @[]
  wire [6:0] _GEN_326 = 6'h23 == io_rPorts_0_req_bits_addr ? data_35_rowAddr : _GEN_324; // @[]
  wire [5:0] _GEN_327 = 6'h23 == io_rPorts_0_req_bits_addr ? data_35_length : _GEN_325; // @[]
  wire [6:0] _GEN_328 = 6'h24 == io_rPorts_0_req_bits_addr ? data_36_rowAddr : _GEN_326; // @[]
  wire [5:0] _GEN_329 = 6'h24 == io_rPorts_0_req_bits_addr ? data_36_length : _GEN_327; // @[]
  wire [6:0] _GEN_330 = 6'h25 == io_rPorts_0_req_bits_addr ? data_37_rowAddr : _GEN_328; // @[]
  wire [5:0] _GEN_331 = 6'h25 == io_rPorts_0_req_bits_addr ? data_37_length : _GEN_329; // @[]
  wire [6:0] _GEN_332 = 6'h26 == io_rPorts_0_req_bits_addr ? data_38_rowAddr : _GEN_330; // @[]
  wire [5:0] _GEN_333 = 6'h26 == io_rPorts_0_req_bits_addr ? data_38_length : _GEN_331; // @[]
  wire [6:0] _GEN_334 = 6'h27 == io_rPorts_0_req_bits_addr ? data_39_rowAddr : _GEN_332; // @[]
  wire [5:0] _GEN_335 = 6'h27 == io_rPorts_0_req_bits_addr ? data_39_length : _GEN_333; // @[]
  wire [6:0] _GEN_336 = 6'h28 == io_rPorts_0_req_bits_addr ? data_40_rowAddr : _GEN_334; // @[]
  wire [5:0] _GEN_337 = 6'h28 == io_rPorts_0_req_bits_addr ? data_40_length : _GEN_335; // @[]
  wire [6:0] _GEN_338 = 6'h29 == io_rPorts_0_req_bits_addr ? data_41_rowAddr : _GEN_336; // @[]
  wire [5:0] _GEN_339 = 6'h29 == io_rPorts_0_req_bits_addr ? data_41_length : _GEN_337; // @[]
  wire [6:0] _GEN_340 = 6'h2a == io_rPorts_0_req_bits_addr ? data_42_rowAddr : _GEN_338; // @[]
  wire [5:0] _GEN_341 = 6'h2a == io_rPorts_0_req_bits_addr ? data_42_length : _GEN_339; // @[]
  wire [6:0] _GEN_342 = 6'h2b == io_rPorts_0_req_bits_addr ? data_43_rowAddr : _GEN_340; // @[]
  wire [5:0] _GEN_343 = 6'h2b == io_rPorts_0_req_bits_addr ? data_43_length : _GEN_341; // @[]
  wire [6:0] _GEN_344 = 6'h2c == io_rPorts_0_req_bits_addr ? data_44_rowAddr : _GEN_342; // @[]
  wire [5:0] _GEN_345 = 6'h2c == io_rPorts_0_req_bits_addr ? data_44_length : _GEN_343; // @[]
  wire [6:0] _GEN_346 = 6'h2d == io_rPorts_0_req_bits_addr ? data_45_rowAddr : _GEN_344; // @[]
  wire [5:0] _GEN_347 = 6'h2d == io_rPorts_0_req_bits_addr ? data_45_length : _GEN_345; // @[]
  wire [6:0] _GEN_348 = 6'h2e == io_rPorts_0_req_bits_addr ? data_46_rowAddr : _GEN_346; // @[]
  wire [5:0] _GEN_349 = 6'h2e == io_rPorts_0_req_bits_addr ? data_46_length : _GEN_347; // @[]
  wire [6:0] _GEN_350 = 6'h2f == io_rPorts_0_req_bits_addr ? data_47_rowAddr : _GEN_348; // @[]
  wire [5:0] _GEN_351 = 6'h2f == io_rPorts_0_req_bits_addr ? data_47_length : _GEN_349; // @[]
  wire [6:0] _GEN_352 = 6'h30 == io_rPorts_0_req_bits_addr ? data_48_rowAddr : _GEN_350; // @[]
  wire [5:0] _GEN_353 = 6'h30 == io_rPorts_0_req_bits_addr ? data_48_length : _GEN_351; // @[]
  wire [6:0] _GEN_354 = 6'h31 == io_rPorts_0_req_bits_addr ? data_49_rowAddr : _GEN_352; // @[]
  wire [5:0] _GEN_355 = 6'h31 == io_rPorts_0_req_bits_addr ? data_49_length : _GEN_353; // @[]
  wire [6:0] _GEN_356 = 6'h32 == io_rPorts_0_req_bits_addr ? data_50_rowAddr : _GEN_354; // @[]
  wire [5:0] _GEN_357 = 6'h32 == io_rPorts_0_req_bits_addr ? data_50_length : _GEN_355; // @[]
  wire [6:0] _GEN_358 = 6'h33 == io_rPorts_0_req_bits_addr ? data_51_rowAddr : _GEN_356; // @[]
  wire [5:0] _GEN_359 = 6'h33 == io_rPorts_0_req_bits_addr ? data_51_length : _GEN_357; // @[]
  wire [6:0] _GEN_360 = 6'h34 == io_rPorts_0_req_bits_addr ? data_52_rowAddr : _GEN_358; // @[]
  wire [5:0] _GEN_361 = 6'h34 == io_rPorts_0_req_bits_addr ? data_52_length : _GEN_359; // @[]
  wire [6:0] _GEN_362 = 6'h35 == io_rPorts_0_req_bits_addr ? data_53_rowAddr : _GEN_360; // @[]
  wire [5:0] _GEN_363 = 6'h35 == io_rPorts_0_req_bits_addr ? data_53_length : _GEN_361; // @[]
  wire [6:0] _GEN_364 = 6'h36 == io_rPorts_0_req_bits_addr ? data_54_rowAddr : _GEN_362; // @[]
  wire [5:0] _GEN_365 = 6'h36 == io_rPorts_0_req_bits_addr ? data_54_length : _GEN_363; // @[]
  wire [6:0] _GEN_366 = 6'h37 == io_rPorts_0_req_bits_addr ? data_55_rowAddr : _GEN_364; // @[]
  wire [5:0] _GEN_367 = 6'h37 == io_rPorts_0_req_bits_addr ? data_55_length : _GEN_365; // @[]
  wire [6:0] _GEN_368 = 6'h38 == io_rPorts_0_req_bits_addr ? data_56_rowAddr : _GEN_366; // @[]
  wire [5:0] _GEN_369 = 6'h38 == io_rPorts_0_req_bits_addr ? data_56_length : _GEN_367; // @[]
  wire [6:0] _GEN_370 = 6'h39 == io_rPorts_0_req_bits_addr ? data_57_rowAddr : _GEN_368; // @[]
  wire [5:0] _GEN_371 = 6'h39 == io_rPorts_0_req_bits_addr ? data_57_length : _GEN_369; // @[]
  wire [6:0] _GEN_372 = 6'h3a == io_rPorts_0_req_bits_addr ? data_58_rowAddr : _GEN_370; // @[]
  wire [5:0] _GEN_373 = 6'h3a == io_rPorts_0_req_bits_addr ? data_58_length : _GEN_371; // @[]
  wire [6:0] _GEN_374 = 6'h3b == io_rPorts_0_req_bits_addr ? data_59_rowAddr : _GEN_372; // @[]
  wire [5:0] _GEN_375 = 6'h3b == io_rPorts_0_req_bits_addr ? data_59_length : _GEN_373; // @[]
  wire [6:0] _GEN_376 = 6'h3c == io_rPorts_0_req_bits_addr ? data_60_rowAddr : _GEN_374; // @[]
  wire [5:0] _GEN_377 = 6'h3c == io_rPorts_0_req_bits_addr ? data_60_length : _GEN_375; // @[]
  wire [6:0] _GEN_378 = 6'h3d == io_rPorts_0_req_bits_addr ? data_61_rowAddr : _GEN_376; // @[]
  wire [5:0] _GEN_379 = 6'h3d == io_rPorts_0_req_bits_addr ? data_61_length : _GEN_377; // @[]
  wire [6:0] _GEN_380 = 6'h3e == io_rPorts_0_req_bits_addr ? data_62_rowAddr : _GEN_378; // @[]
  wire [5:0] _GEN_381 = 6'h3e == io_rPorts_0_req_bits_addr ? data_62_length : _GEN_379; // @[]
  assign io_wPorts_0_req_ready = 1'h1; // @[RegStore.scala 108:18]
  assign io_rPorts_0_req_ready = 1'h1; // @[RegStore.scala 117:18]
  assign io_rPorts_0_rsp_bits_rdata_rowAddr = 6'h3f == io_rPorts_0_req_bits_addr ? data_63_rowAddr : _GEN_380; // @[]
  assign io_rPorts_0_rsp_bits_rdata_length = 6'h3f == io_rPorts_0_req_bits_addr ? data_63_length : _GEN_381; // @[]
  always @(posedge clock) begin
    if (reset) begin // @[RegStore.scala 104:21]
      data_0_rowAddr <= 7'h0; // @[RegStore.scala 104:21]
    end else if (reset) begin // @[RegStore.scala 155:25]
      data_0_rowAddr <= 7'h0; // @[RegStore.scala 156:10]
    end else if (_T) begin // @[RegStore.scala 109:25]
      if (6'h0 == io_wPorts_0_req_bits_addr) begin // @[RegStore.scala 111:30]
        data_0_rowAddr <= io_wPorts_0_req_bits_wdata_rowAddr; // @[RegStore.scala 111:30]
      end
    end
    if (reset) begin // @[RegStore.scala 104:21]
      data_0_length <= 6'h0; // @[RegStore.scala 104:21]
    end else if (reset) begin // @[RegStore.scala 155:25]
      data_0_length <= 6'h0; // @[RegStore.scala 156:10]
    end else if (_T) begin // @[RegStore.scala 109:25]
      if (6'h0 == io_wPorts_0_req_bits_addr) begin // @[RegStore.scala 111:30]
        data_0_length <= io_wPorts_0_req_bits_wdata_length; // @[RegStore.scala 111:30]
      end
    end
    if (reset) begin // @[RegStore.scala 104:21]
      data_1_rowAddr <= 7'h0; // @[RegStore.scala 104:21]
    end else if (reset) begin // @[RegStore.scala 155:25]
      data_1_rowAddr <= 7'h0; // @[RegStore.scala 156:10]
    end else if (_T) begin // @[RegStore.scala 109:25]
      if (6'h1 == io_wPorts_0_req_bits_addr) begin // @[RegStore.scala 111:30]
        data_1_rowAddr <= io_wPorts_0_req_bits_wdata_rowAddr; // @[RegStore.scala 111:30]
      end
    end
    if (reset) begin // @[RegStore.scala 104:21]
      data_1_length <= 6'h0; // @[RegStore.scala 104:21]
    end else if (reset) begin // @[RegStore.scala 155:25]
      data_1_length <= 6'h0; // @[RegStore.scala 156:10]
    end else if (_T) begin // @[RegStore.scala 109:25]
      if (6'h1 == io_wPorts_0_req_bits_addr) begin // @[RegStore.scala 111:30]
        data_1_length <= io_wPorts_0_req_bits_wdata_length; // @[RegStore.scala 111:30]
      end
    end
    if (reset) begin // @[RegStore.scala 104:21]
      data_2_rowAddr <= 7'h0; // @[RegStore.scala 104:21]
    end else if (reset) begin // @[RegStore.scala 155:25]
      data_2_rowAddr <= 7'h0; // @[RegStore.scala 156:10]
    end else if (_T) begin // @[RegStore.scala 109:25]
      if (6'h2 == io_wPorts_0_req_bits_addr) begin // @[RegStore.scala 111:30]
        data_2_rowAddr <= io_wPorts_0_req_bits_wdata_rowAddr; // @[RegStore.scala 111:30]
      end
    end
    if (reset) begin // @[RegStore.scala 104:21]
      data_2_length <= 6'h0; // @[RegStore.scala 104:21]
    end else if (reset) begin // @[RegStore.scala 155:25]
      data_2_length <= 6'h0; // @[RegStore.scala 156:10]
    end else if (_T) begin // @[RegStore.scala 109:25]
      if (6'h2 == io_wPorts_0_req_bits_addr) begin // @[RegStore.scala 111:30]
        data_2_length <= io_wPorts_0_req_bits_wdata_length; // @[RegStore.scala 111:30]
      end
    end
    if (reset) begin // @[RegStore.scala 104:21]
      data_3_rowAddr <= 7'h0; // @[RegStore.scala 104:21]
    end else if (reset) begin // @[RegStore.scala 155:25]
      data_3_rowAddr <= 7'h0; // @[RegStore.scala 156:10]
    end else if (_T) begin // @[RegStore.scala 109:25]
      if (6'h3 == io_wPorts_0_req_bits_addr) begin // @[RegStore.scala 111:30]
        data_3_rowAddr <= io_wPorts_0_req_bits_wdata_rowAddr; // @[RegStore.scala 111:30]
      end
    end
    if (reset) begin // @[RegStore.scala 104:21]
      data_3_length <= 6'h0; // @[RegStore.scala 104:21]
    end else if (reset) begin // @[RegStore.scala 155:25]
      data_3_length <= 6'h0; // @[RegStore.scala 156:10]
    end else if (_T) begin // @[RegStore.scala 109:25]
      if (6'h3 == io_wPorts_0_req_bits_addr) begin // @[RegStore.scala 111:30]
        data_3_length <= io_wPorts_0_req_bits_wdata_length; // @[RegStore.scala 111:30]
      end
    end
    if (reset) begin // @[RegStore.scala 104:21]
      data_4_rowAddr <= 7'h0; // @[RegStore.scala 104:21]
    end else if (reset) begin // @[RegStore.scala 155:25]
      data_4_rowAddr <= 7'h0; // @[RegStore.scala 156:10]
    end else if (_T) begin // @[RegStore.scala 109:25]
      if (6'h4 == io_wPorts_0_req_bits_addr) begin // @[RegStore.scala 111:30]
        data_4_rowAddr <= io_wPorts_0_req_bits_wdata_rowAddr; // @[RegStore.scala 111:30]
      end
    end
    if (reset) begin // @[RegStore.scala 104:21]
      data_4_length <= 6'h0; // @[RegStore.scala 104:21]
    end else if (reset) begin // @[RegStore.scala 155:25]
      data_4_length <= 6'h0; // @[RegStore.scala 156:10]
    end else if (_T) begin // @[RegStore.scala 109:25]
      if (6'h4 == io_wPorts_0_req_bits_addr) begin // @[RegStore.scala 111:30]
        data_4_length <= io_wPorts_0_req_bits_wdata_length; // @[RegStore.scala 111:30]
      end
    end
    if (reset) begin // @[RegStore.scala 104:21]
      data_5_rowAddr <= 7'h0; // @[RegStore.scala 104:21]
    end else if (reset) begin // @[RegStore.scala 155:25]
      data_5_rowAddr <= 7'h0; // @[RegStore.scala 156:10]
    end else if (_T) begin // @[RegStore.scala 109:25]
      if (6'h5 == io_wPorts_0_req_bits_addr) begin // @[RegStore.scala 111:30]
        data_5_rowAddr <= io_wPorts_0_req_bits_wdata_rowAddr; // @[RegStore.scala 111:30]
      end
    end
    if (reset) begin // @[RegStore.scala 104:21]
      data_5_length <= 6'h0; // @[RegStore.scala 104:21]
    end else if (reset) begin // @[RegStore.scala 155:25]
      data_5_length <= 6'h0; // @[RegStore.scala 156:10]
    end else if (_T) begin // @[RegStore.scala 109:25]
      if (6'h5 == io_wPorts_0_req_bits_addr) begin // @[RegStore.scala 111:30]
        data_5_length <= io_wPorts_0_req_bits_wdata_length; // @[RegStore.scala 111:30]
      end
    end
    if (reset) begin // @[RegStore.scala 104:21]
      data_6_rowAddr <= 7'h0; // @[RegStore.scala 104:21]
    end else if (reset) begin // @[RegStore.scala 155:25]
      data_6_rowAddr <= 7'h0; // @[RegStore.scala 156:10]
    end else if (_T) begin // @[RegStore.scala 109:25]
      if (6'h6 == io_wPorts_0_req_bits_addr) begin // @[RegStore.scala 111:30]
        data_6_rowAddr <= io_wPorts_0_req_bits_wdata_rowAddr; // @[RegStore.scala 111:30]
      end
    end
    if (reset) begin // @[RegStore.scala 104:21]
      data_6_length <= 6'h0; // @[RegStore.scala 104:21]
    end else if (reset) begin // @[RegStore.scala 155:25]
      data_6_length <= 6'h0; // @[RegStore.scala 156:10]
    end else if (_T) begin // @[RegStore.scala 109:25]
      if (6'h6 == io_wPorts_0_req_bits_addr) begin // @[RegStore.scala 111:30]
        data_6_length <= io_wPorts_0_req_bits_wdata_length; // @[RegStore.scala 111:30]
      end
    end
    if (reset) begin // @[RegStore.scala 104:21]
      data_7_rowAddr <= 7'h0; // @[RegStore.scala 104:21]
    end else if (reset) begin // @[RegStore.scala 155:25]
      data_7_rowAddr <= 7'h0; // @[RegStore.scala 156:10]
    end else if (_T) begin // @[RegStore.scala 109:25]
      if (6'h7 == io_wPorts_0_req_bits_addr) begin // @[RegStore.scala 111:30]
        data_7_rowAddr <= io_wPorts_0_req_bits_wdata_rowAddr; // @[RegStore.scala 111:30]
      end
    end
    if (reset) begin // @[RegStore.scala 104:21]
      data_7_length <= 6'h0; // @[RegStore.scala 104:21]
    end else if (reset) begin // @[RegStore.scala 155:25]
      data_7_length <= 6'h0; // @[RegStore.scala 156:10]
    end else if (_T) begin // @[RegStore.scala 109:25]
      if (6'h7 == io_wPorts_0_req_bits_addr) begin // @[RegStore.scala 111:30]
        data_7_length <= io_wPorts_0_req_bits_wdata_length; // @[RegStore.scala 111:30]
      end
    end
    if (reset) begin // @[RegStore.scala 104:21]
      data_8_rowAddr <= 7'h0; // @[RegStore.scala 104:21]
    end else if (reset) begin // @[RegStore.scala 155:25]
      data_8_rowAddr <= 7'h0; // @[RegStore.scala 156:10]
    end else if (_T) begin // @[RegStore.scala 109:25]
      if (6'h8 == io_wPorts_0_req_bits_addr) begin // @[RegStore.scala 111:30]
        data_8_rowAddr <= io_wPorts_0_req_bits_wdata_rowAddr; // @[RegStore.scala 111:30]
      end
    end
    if (reset) begin // @[RegStore.scala 104:21]
      data_8_length <= 6'h0; // @[RegStore.scala 104:21]
    end else if (reset) begin // @[RegStore.scala 155:25]
      data_8_length <= 6'h0; // @[RegStore.scala 156:10]
    end else if (_T) begin // @[RegStore.scala 109:25]
      if (6'h8 == io_wPorts_0_req_bits_addr) begin // @[RegStore.scala 111:30]
        data_8_length <= io_wPorts_0_req_bits_wdata_length; // @[RegStore.scala 111:30]
      end
    end
    if (reset) begin // @[RegStore.scala 104:21]
      data_9_rowAddr <= 7'h0; // @[RegStore.scala 104:21]
    end else if (reset) begin // @[RegStore.scala 155:25]
      data_9_rowAddr <= 7'h0; // @[RegStore.scala 156:10]
    end else if (_T) begin // @[RegStore.scala 109:25]
      if (6'h9 == io_wPorts_0_req_bits_addr) begin // @[RegStore.scala 111:30]
        data_9_rowAddr <= io_wPorts_0_req_bits_wdata_rowAddr; // @[RegStore.scala 111:30]
      end
    end
    if (reset) begin // @[RegStore.scala 104:21]
      data_9_length <= 6'h0; // @[RegStore.scala 104:21]
    end else if (reset) begin // @[RegStore.scala 155:25]
      data_9_length <= 6'h0; // @[RegStore.scala 156:10]
    end else if (_T) begin // @[RegStore.scala 109:25]
      if (6'h9 == io_wPorts_0_req_bits_addr) begin // @[RegStore.scala 111:30]
        data_9_length <= io_wPorts_0_req_bits_wdata_length; // @[RegStore.scala 111:30]
      end
    end
    if (reset) begin // @[RegStore.scala 104:21]
      data_10_rowAddr <= 7'h0; // @[RegStore.scala 104:21]
    end else if (reset) begin // @[RegStore.scala 155:25]
      data_10_rowAddr <= 7'h0; // @[RegStore.scala 156:10]
    end else if (_T) begin // @[RegStore.scala 109:25]
      if (6'ha == io_wPorts_0_req_bits_addr) begin // @[RegStore.scala 111:30]
        data_10_rowAddr <= io_wPorts_0_req_bits_wdata_rowAddr; // @[RegStore.scala 111:30]
      end
    end
    if (reset) begin // @[RegStore.scala 104:21]
      data_10_length <= 6'h0; // @[RegStore.scala 104:21]
    end else if (reset) begin // @[RegStore.scala 155:25]
      data_10_length <= 6'h0; // @[RegStore.scala 156:10]
    end else if (_T) begin // @[RegStore.scala 109:25]
      if (6'ha == io_wPorts_0_req_bits_addr) begin // @[RegStore.scala 111:30]
        data_10_length <= io_wPorts_0_req_bits_wdata_length; // @[RegStore.scala 111:30]
      end
    end
    if (reset) begin // @[RegStore.scala 104:21]
      data_11_rowAddr <= 7'h0; // @[RegStore.scala 104:21]
    end else if (reset) begin // @[RegStore.scala 155:25]
      data_11_rowAddr <= 7'h0; // @[RegStore.scala 156:10]
    end else if (_T) begin // @[RegStore.scala 109:25]
      if (6'hb == io_wPorts_0_req_bits_addr) begin // @[RegStore.scala 111:30]
        data_11_rowAddr <= io_wPorts_0_req_bits_wdata_rowAddr; // @[RegStore.scala 111:30]
      end
    end
    if (reset) begin // @[RegStore.scala 104:21]
      data_11_length <= 6'h0; // @[RegStore.scala 104:21]
    end else if (reset) begin // @[RegStore.scala 155:25]
      data_11_length <= 6'h0; // @[RegStore.scala 156:10]
    end else if (_T) begin // @[RegStore.scala 109:25]
      if (6'hb == io_wPorts_0_req_bits_addr) begin // @[RegStore.scala 111:30]
        data_11_length <= io_wPorts_0_req_bits_wdata_length; // @[RegStore.scala 111:30]
      end
    end
    if (reset) begin // @[RegStore.scala 104:21]
      data_12_rowAddr <= 7'h0; // @[RegStore.scala 104:21]
    end else if (reset) begin // @[RegStore.scala 155:25]
      data_12_rowAddr <= 7'h0; // @[RegStore.scala 156:10]
    end else if (_T) begin // @[RegStore.scala 109:25]
      if (6'hc == io_wPorts_0_req_bits_addr) begin // @[RegStore.scala 111:30]
        data_12_rowAddr <= io_wPorts_0_req_bits_wdata_rowAddr; // @[RegStore.scala 111:30]
      end
    end
    if (reset) begin // @[RegStore.scala 104:21]
      data_12_length <= 6'h0; // @[RegStore.scala 104:21]
    end else if (reset) begin // @[RegStore.scala 155:25]
      data_12_length <= 6'h0; // @[RegStore.scala 156:10]
    end else if (_T) begin // @[RegStore.scala 109:25]
      if (6'hc == io_wPorts_0_req_bits_addr) begin // @[RegStore.scala 111:30]
        data_12_length <= io_wPorts_0_req_bits_wdata_length; // @[RegStore.scala 111:30]
      end
    end
    if (reset) begin // @[RegStore.scala 104:21]
      data_13_rowAddr <= 7'h0; // @[RegStore.scala 104:21]
    end else if (reset) begin // @[RegStore.scala 155:25]
      data_13_rowAddr <= 7'h0; // @[RegStore.scala 156:10]
    end else if (_T) begin // @[RegStore.scala 109:25]
      if (6'hd == io_wPorts_0_req_bits_addr) begin // @[RegStore.scala 111:30]
        data_13_rowAddr <= io_wPorts_0_req_bits_wdata_rowAddr; // @[RegStore.scala 111:30]
      end
    end
    if (reset) begin // @[RegStore.scala 104:21]
      data_13_length <= 6'h0; // @[RegStore.scala 104:21]
    end else if (reset) begin // @[RegStore.scala 155:25]
      data_13_length <= 6'h0; // @[RegStore.scala 156:10]
    end else if (_T) begin // @[RegStore.scala 109:25]
      if (6'hd == io_wPorts_0_req_bits_addr) begin // @[RegStore.scala 111:30]
        data_13_length <= io_wPorts_0_req_bits_wdata_length; // @[RegStore.scala 111:30]
      end
    end
    if (reset) begin // @[RegStore.scala 104:21]
      data_14_rowAddr <= 7'h0; // @[RegStore.scala 104:21]
    end else if (reset) begin // @[RegStore.scala 155:25]
      data_14_rowAddr <= 7'h0; // @[RegStore.scala 156:10]
    end else if (_T) begin // @[RegStore.scala 109:25]
      if (6'he == io_wPorts_0_req_bits_addr) begin // @[RegStore.scala 111:30]
        data_14_rowAddr <= io_wPorts_0_req_bits_wdata_rowAddr; // @[RegStore.scala 111:30]
      end
    end
    if (reset) begin // @[RegStore.scala 104:21]
      data_14_length <= 6'h0; // @[RegStore.scala 104:21]
    end else if (reset) begin // @[RegStore.scala 155:25]
      data_14_length <= 6'h0; // @[RegStore.scala 156:10]
    end else if (_T) begin // @[RegStore.scala 109:25]
      if (6'he == io_wPorts_0_req_bits_addr) begin // @[RegStore.scala 111:30]
        data_14_length <= io_wPorts_0_req_bits_wdata_length; // @[RegStore.scala 111:30]
      end
    end
    if (reset) begin // @[RegStore.scala 104:21]
      data_15_rowAddr <= 7'h0; // @[RegStore.scala 104:21]
    end else if (reset) begin // @[RegStore.scala 155:25]
      data_15_rowAddr <= 7'h0; // @[RegStore.scala 156:10]
    end else if (_T) begin // @[RegStore.scala 109:25]
      if (6'hf == io_wPorts_0_req_bits_addr) begin // @[RegStore.scala 111:30]
        data_15_rowAddr <= io_wPorts_0_req_bits_wdata_rowAddr; // @[RegStore.scala 111:30]
      end
    end
    if (reset) begin // @[RegStore.scala 104:21]
      data_15_length <= 6'h0; // @[RegStore.scala 104:21]
    end else if (reset) begin // @[RegStore.scala 155:25]
      data_15_length <= 6'h0; // @[RegStore.scala 156:10]
    end else if (_T) begin // @[RegStore.scala 109:25]
      if (6'hf == io_wPorts_0_req_bits_addr) begin // @[RegStore.scala 111:30]
        data_15_length <= io_wPorts_0_req_bits_wdata_length; // @[RegStore.scala 111:30]
      end
    end
    if (reset) begin // @[RegStore.scala 104:21]
      data_16_rowAddr <= 7'h0; // @[RegStore.scala 104:21]
    end else if (reset) begin // @[RegStore.scala 155:25]
      data_16_rowAddr <= 7'h0; // @[RegStore.scala 156:10]
    end else if (_T) begin // @[RegStore.scala 109:25]
      if (6'h10 == io_wPorts_0_req_bits_addr) begin // @[RegStore.scala 111:30]
        data_16_rowAddr <= io_wPorts_0_req_bits_wdata_rowAddr; // @[RegStore.scala 111:30]
      end
    end
    if (reset) begin // @[RegStore.scala 104:21]
      data_16_length <= 6'h0; // @[RegStore.scala 104:21]
    end else if (reset) begin // @[RegStore.scala 155:25]
      data_16_length <= 6'h0; // @[RegStore.scala 156:10]
    end else if (_T) begin // @[RegStore.scala 109:25]
      if (6'h10 == io_wPorts_0_req_bits_addr) begin // @[RegStore.scala 111:30]
        data_16_length <= io_wPorts_0_req_bits_wdata_length; // @[RegStore.scala 111:30]
      end
    end
    if (reset) begin // @[RegStore.scala 104:21]
      data_17_rowAddr <= 7'h0; // @[RegStore.scala 104:21]
    end else if (reset) begin // @[RegStore.scala 155:25]
      data_17_rowAddr <= 7'h0; // @[RegStore.scala 156:10]
    end else if (_T) begin // @[RegStore.scala 109:25]
      if (6'h11 == io_wPorts_0_req_bits_addr) begin // @[RegStore.scala 111:30]
        data_17_rowAddr <= io_wPorts_0_req_bits_wdata_rowAddr; // @[RegStore.scala 111:30]
      end
    end
    if (reset) begin // @[RegStore.scala 104:21]
      data_17_length <= 6'h0; // @[RegStore.scala 104:21]
    end else if (reset) begin // @[RegStore.scala 155:25]
      data_17_length <= 6'h0; // @[RegStore.scala 156:10]
    end else if (_T) begin // @[RegStore.scala 109:25]
      if (6'h11 == io_wPorts_0_req_bits_addr) begin // @[RegStore.scala 111:30]
        data_17_length <= io_wPorts_0_req_bits_wdata_length; // @[RegStore.scala 111:30]
      end
    end
    if (reset) begin // @[RegStore.scala 104:21]
      data_18_rowAddr <= 7'h0; // @[RegStore.scala 104:21]
    end else if (reset) begin // @[RegStore.scala 155:25]
      data_18_rowAddr <= 7'h0; // @[RegStore.scala 156:10]
    end else if (_T) begin // @[RegStore.scala 109:25]
      if (6'h12 == io_wPorts_0_req_bits_addr) begin // @[RegStore.scala 111:30]
        data_18_rowAddr <= io_wPorts_0_req_bits_wdata_rowAddr; // @[RegStore.scala 111:30]
      end
    end
    if (reset) begin // @[RegStore.scala 104:21]
      data_18_length <= 6'h0; // @[RegStore.scala 104:21]
    end else if (reset) begin // @[RegStore.scala 155:25]
      data_18_length <= 6'h0; // @[RegStore.scala 156:10]
    end else if (_T) begin // @[RegStore.scala 109:25]
      if (6'h12 == io_wPorts_0_req_bits_addr) begin // @[RegStore.scala 111:30]
        data_18_length <= io_wPorts_0_req_bits_wdata_length; // @[RegStore.scala 111:30]
      end
    end
    if (reset) begin // @[RegStore.scala 104:21]
      data_19_rowAddr <= 7'h0; // @[RegStore.scala 104:21]
    end else if (reset) begin // @[RegStore.scala 155:25]
      data_19_rowAddr <= 7'h0; // @[RegStore.scala 156:10]
    end else if (_T) begin // @[RegStore.scala 109:25]
      if (6'h13 == io_wPorts_0_req_bits_addr) begin // @[RegStore.scala 111:30]
        data_19_rowAddr <= io_wPorts_0_req_bits_wdata_rowAddr; // @[RegStore.scala 111:30]
      end
    end
    if (reset) begin // @[RegStore.scala 104:21]
      data_19_length <= 6'h0; // @[RegStore.scala 104:21]
    end else if (reset) begin // @[RegStore.scala 155:25]
      data_19_length <= 6'h0; // @[RegStore.scala 156:10]
    end else if (_T) begin // @[RegStore.scala 109:25]
      if (6'h13 == io_wPorts_0_req_bits_addr) begin // @[RegStore.scala 111:30]
        data_19_length <= io_wPorts_0_req_bits_wdata_length; // @[RegStore.scala 111:30]
      end
    end
    if (reset) begin // @[RegStore.scala 104:21]
      data_20_rowAddr <= 7'h0; // @[RegStore.scala 104:21]
    end else if (reset) begin // @[RegStore.scala 155:25]
      data_20_rowAddr <= 7'h0; // @[RegStore.scala 156:10]
    end else if (_T) begin // @[RegStore.scala 109:25]
      if (6'h14 == io_wPorts_0_req_bits_addr) begin // @[RegStore.scala 111:30]
        data_20_rowAddr <= io_wPorts_0_req_bits_wdata_rowAddr; // @[RegStore.scala 111:30]
      end
    end
    if (reset) begin // @[RegStore.scala 104:21]
      data_20_length <= 6'h0; // @[RegStore.scala 104:21]
    end else if (reset) begin // @[RegStore.scala 155:25]
      data_20_length <= 6'h0; // @[RegStore.scala 156:10]
    end else if (_T) begin // @[RegStore.scala 109:25]
      if (6'h14 == io_wPorts_0_req_bits_addr) begin // @[RegStore.scala 111:30]
        data_20_length <= io_wPorts_0_req_bits_wdata_length; // @[RegStore.scala 111:30]
      end
    end
    if (reset) begin // @[RegStore.scala 104:21]
      data_21_rowAddr <= 7'h0; // @[RegStore.scala 104:21]
    end else if (reset) begin // @[RegStore.scala 155:25]
      data_21_rowAddr <= 7'h0; // @[RegStore.scala 156:10]
    end else if (_T) begin // @[RegStore.scala 109:25]
      if (6'h15 == io_wPorts_0_req_bits_addr) begin // @[RegStore.scala 111:30]
        data_21_rowAddr <= io_wPorts_0_req_bits_wdata_rowAddr; // @[RegStore.scala 111:30]
      end
    end
    if (reset) begin // @[RegStore.scala 104:21]
      data_21_length <= 6'h0; // @[RegStore.scala 104:21]
    end else if (reset) begin // @[RegStore.scala 155:25]
      data_21_length <= 6'h0; // @[RegStore.scala 156:10]
    end else if (_T) begin // @[RegStore.scala 109:25]
      if (6'h15 == io_wPorts_0_req_bits_addr) begin // @[RegStore.scala 111:30]
        data_21_length <= io_wPorts_0_req_bits_wdata_length; // @[RegStore.scala 111:30]
      end
    end
    if (reset) begin // @[RegStore.scala 104:21]
      data_22_rowAddr <= 7'h0; // @[RegStore.scala 104:21]
    end else if (reset) begin // @[RegStore.scala 155:25]
      data_22_rowAddr <= 7'h0; // @[RegStore.scala 156:10]
    end else if (_T) begin // @[RegStore.scala 109:25]
      if (6'h16 == io_wPorts_0_req_bits_addr) begin // @[RegStore.scala 111:30]
        data_22_rowAddr <= io_wPorts_0_req_bits_wdata_rowAddr; // @[RegStore.scala 111:30]
      end
    end
    if (reset) begin // @[RegStore.scala 104:21]
      data_22_length <= 6'h0; // @[RegStore.scala 104:21]
    end else if (reset) begin // @[RegStore.scala 155:25]
      data_22_length <= 6'h0; // @[RegStore.scala 156:10]
    end else if (_T) begin // @[RegStore.scala 109:25]
      if (6'h16 == io_wPorts_0_req_bits_addr) begin // @[RegStore.scala 111:30]
        data_22_length <= io_wPorts_0_req_bits_wdata_length; // @[RegStore.scala 111:30]
      end
    end
    if (reset) begin // @[RegStore.scala 104:21]
      data_23_rowAddr <= 7'h0; // @[RegStore.scala 104:21]
    end else if (reset) begin // @[RegStore.scala 155:25]
      data_23_rowAddr <= 7'h0; // @[RegStore.scala 156:10]
    end else if (_T) begin // @[RegStore.scala 109:25]
      if (6'h17 == io_wPorts_0_req_bits_addr) begin // @[RegStore.scala 111:30]
        data_23_rowAddr <= io_wPorts_0_req_bits_wdata_rowAddr; // @[RegStore.scala 111:30]
      end
    end
    if (reset) begin // @[RegStore.scala 104:21]
      data_23_length <= 6'h0; // @[RegStore.scala 104:21]
    end else if (reset) begin // @[RegStore.scala 155:25]
      data_23_length <= 6'h0; // @[RegStore.scala 156:10]
    end else if (_T) begin // @[RegStore.scala 109:25]
      if (6'h17 == io_wPorts_0_req_bits_addr) begin // @[RegStore.scala 111:30]
        data_23_length <= io_wPorts_0_req_bits_wdata_length; // @[RegStore.scala 111:30]
      end
    end
    if (reset) begin // @[RegStore.scala 104:21]
      data_24_rowAddr <= 7'h0; // @[RegStore.scala 104:21]
    end else if (reset) begin // @[RegStore.scala 155:25]
      data_24_rowAddr <= 7'h0; // @[RegStore.scala 156:10]
    end else if (_T) begin // @[RegStore.scala 109:25]
      if (6'h18 == io_wPorts_0_req_bits_addr) begin // @[RegStore.scala 111:30]
        data_24_rowAddr <= io_wPorts_0_req_bits_wdata_rowAddr; // @[RegStore.scala 111:30]
      end
    end
    if (reset) begin // @[RegStore.scala 104:21]
      data_24_length <= 6'h0; // @[RegStore.scala 104:21]
    end else if (reset) begin // @[RegStore.scala 155:25]
      data_24_length <= 6'h0; // @[RegStore.scala 156:10]
    end else if (_T) begin // @[RegStore.scala 109:25]
      if (6'h18 == io_wPorts_0_req_bits_addr) begin // @[RegStore.scala 111:30]
        data_24_length <= io_wPorts_0_req_bits_wdata_length; // @[RegStore.scala 111:30]
      end
    end
    if (reset) begin // @[RegStore.scala 104:21]
      data_25_rowAddr <= 7'h0; // @[RegStore.scala 104:21]
    end else if (reset) begin // @[RegStore.scala 155:25]
      data_25_rowAddr <= 7'h0; // @[RegStore.scala 156:10]
    end else if (_T) begin // @[RegStore.scala 109:25]
      if (6'h19 == io_wPorts_0_req_bits_addr) begin // @[RegStore.scala 111:30]
        data_25_rowAddr <= io_wPorts_0_req_bits_wdata_rowAddr; // @[RegStore.scala 111:30]
      end
    end
    if (reset) begin // @[RegStore.scala 104:21]
      data_25_length <= 6'h0; // @[RegStore.scala 104:21]
    end else if (reset) begin // @[RegStore.scala 155:25]
      data_25_length <= 6'h0; // @[RegStore.scala 156:10]
    end else if (_T) begin // @[RegStore.scala 109:25]
      if (6'h19 == io_wPorts_0_req_bits_addr) begin // @[RegStore.scala 111:30]
        data_25_length <= io_wPorts_0_req_bits_wdata_length; // @[RegStore.scala 111:30]
      end
    end
    if (reset) begin // @[RegStore.scala 104:21]
      data_26_rowAddr <= 7'h0; // @[RegStore.scala 104:21]
    end else if (reset) begin // @[RegStore.scala 155:25]
      data_26_rowAddr <= 7'h0; // @[RegStore.scala 156:10]
    end else if (_T) begin // @[RegStore.scala 109:25]
      if (6'h1a == io_wPorts_0_req_bits_addr) begin // @[RegStore.scala 111:30]
        data_26_rowAddr <= io_wPorts_0_req_bits_wdata_rowAddr; // @[RegStore.scala 111:30]
      end
    end
    if (reset) begin // @[RegStore.scala 104:21]
      data_26_length <= 6'h0; // @[RegStore.scala 104:21]
    end else if (reset) begin // @[RegStore.scala 155:25]
      data_26_length <= 6'h0; // @[RegStore.scala 156:10]
    end else if (_T) begin // @[RegStore.scala 109:25]
      if (6'h1a == io_wPorts_0_req_bits_addr) begin // @[RegStore.scala 111:30]
        data_26_length <= io_wPorts_0_req_bits_wdata_length; // @[RegStore.scala 111:30]
      end
    end
    if (reset) begin // @[RegStore.scala 104:21]
      data_27_rowAddr <= 7'h0; // @[RegStore.scala 104:21]
    end else if (reset) begin // @[RegStore.scala 155:25]
      data_27_rowAddr <= 7'h0; // @[RegStore.scala 156:10]
    end else if (_T) begin // @[RegStore.scala 109:25]
      if (6'h1b == io_wPorts_0_req_bits_addr) begin // @[RegStore.scala 111:30]
        data_27_rowAddr <= io_wPorts_0_req_bits_wdata_rowAddr; // @[RegStore.scala 111:30]
      end
    end
    if (reset) begin // @[RegStore.scala 104:21]
      data_27_length <= 6'h0; // @[RegStore.scala 104:21]
    end else if (reset) begin // @[RegStore.scala 155:25]
      data_27_length <= 6'h0; // @[RegStore.scala 156:10]
    end else if (_T) begin // @[RegStore.scala 109:25]
      if (6'h1b == io_wPorts_0_req_bits_addr) begin // @[RegStore.scala 111:30]
        data_27_length <= io_wPorts_0_req_bits_wdata_length; // @[RegStore.scala 111:30]
      end
    end
    if (reset) begin // @[RegStore.scala 104:21]
      data_28_rowAddr <= 7'h0; // @[RegStore.scala 104:21]
    end else if (reset) begin // @[RegStore.scala 155:25]
      data_28_rowAddr <= 7'h0; // @[RegStore.scala 156:10]
    end else if (_T) begin // @[RegStore.scala 109:25]
      if (6'h1c == io_wPorts_0_req_bits_addr) begin // @[RegStore.scala 111:30]
        data_28_rowAddr <= io_wPorts_0_req_bits_wdata_rowAddr; // @[RegStore.scala 111:30]
      end
    end
    if (reset) begin // @[RegStore.scala 104:21]
      data_28_length <= 6'h0; // @[RegStore.scala 104:21]
    end else if (reset) begin // @[RegStore.scala 155:25]
      data_28_length <= 6'h0; // @[RegStore.scala 156:10]
    end else if (_T) begin // @[RegStore.scala 109:25]
      if (6'h1c == io_wPorts_0_req_bits_addr) begin // @[RegStore.scala 111:30]
        data_28_length <= io_wPorts_0_req_bits_wdata_length; // @[RegStore.scala 111:30]
      end
    end
    if (reset) begin // @[RegStore.scala 104:21]
      data_29_rowAddr <= 7'h0; // @[RegStore.scala 104:21]
    end else if (reset) begin // @[RegStore.scala 155:25]
      data_29_rowAddr <= 7'h0; // @[RegStore.scala 156:10]
    end else if (_T) begin // @[RegStore.scala 109:25]
      if (6'h1d == io_wPorts_0_req_bits_addr) begin // @[RegStore.scala 111:30]
        data_29_rowAddr <= io_wPorts_0_req_bits_wdata_rowAddr; // @[RegStore.scala 111:30]
      end
    end
    if (reset) begin // @[RegStore.scala 104:21]
      data_29_length <= 6'h0; // @[RegStore.scala 104:21]
    end else if (reset) begin // @[RegStore.scala 155:25]
      data_29_length <= 6'h0; // @[RegStore.scala 156:10]
    end else if (_T) begin // @[RegStore.scala 109:25]
      if (6'h1d == io_wPorts_0_req_bits_addr) begin // @[RegStore.scala 111:30]
        data_29_length <= io_wPorts_0_req_bits_wdata_length; // @[RegStore.scala 111:30]
      end
    end
    if (reset) begin // @[RegStore.scala 104:21]
      data_30_rowAddr <= 7'h0; // @[RegStore.scala 104:21]
    end else if (reset) begin // @[RegStore.scala 155:25]
      data_30_rowAddr <= 7'h0; // @[RegStore.scala 156:10]
    end else if (_T) begin // @[RegStore.scala 109:25]
      if (6'h1e == io_wPorts_0_req_bits_addr) begin // @[RegStore.scala 111:30]
        data_30_rowAddr <= io_wPorts_0_req_bits_wdata_rowAddr; // @[RegStore.scala 111:30]
      end
    end
    if (reset) begin // @[RegStore.scala 104:21]
      data_30_length <= 6'h0; // @[RegStore.scala 104:21]
    end else if (reset) begin // @[RegStore.scala 155:25]
      data_30_length <= 6'h0; // @[RegStore.scala 156:10]
    end else if (_T) begin // @[RegStore.scala 109:25]
      if (6'h1e == io_wPorts_0_req_bits_addr) begin // @[RegStore.scala 111:30]
        data_30_length <= io_wPorts_0_req_bits_wdata_length; // @[RegStore.scala 111:30]
      end
    end
    if (reset) begin // @[RegStore.scala 104:21]
      data_31_rowAddr <= 7'h0; // @[RegStore.scala 104:21]
    end else if (reset) begin // @[RegStore.scala 155:25]
      data_31_rowAddr <= 7'h0; // @[RegStore.scala 156:10]
    end else if (_T) begin // @[RegStore.scala 109:25]
      if (6'h1f == io_wPorts_0_req_bits_addr) begin // @[RegStore.scala 111:30]
        data_31_rowAddr <= io_wPorts_0_req_bits_wdata_rowAddr; // @[RegStore.scala 111:30]
      end
    end
    if (reset) begin // @[RegStore.scala 104:21]
      data_31_length <= 6'h0; // @[RegStore.scala 104:21]
    end else if (reset) begin // @[RegStore.scala 155:25]
      data_31_length <= 6'h0; // @[RegStore.scala 156:10]
    end else if (_T) begin // @[RegStore.scala 109:25]
      if (6'h1f == io_wPorts_0_req_bits_addr) begin // @[RegStore.scala 111:30]
        data_31_length <= io_wPorts_0_req_bits_wdata_length; // @[RegStore.scala 111:30]
      end
    end
    if (reset) begin // @[RegStore.scala 104:21]
      data_32_rowAddr <= 7'h0; // @[RegStore.scala 104:21]
    end else if (reset) begin // @[RegStore.scala 155:25]
      data_32_rowAddr <= 7'h0; // @[RegStore.scala 156:10]
    end else if (_T) begin // @[RegStore.scala 109:25]
      if (6'h20 == io_wPorts_0_req_bits_addr) begin // @[RegStore.scala 111:30]
        data_32_rowAddr <= io_wPorts_0_req_bits_wdata_rowAddr; // @[RegStore.scala 111:30]
      end
    end
    if (reset) begin // @[RegStore.scala 104:21]
      data_32_length <= 6'h0; // @[RegStore.scala 104:21]
    end else if (reset) begin // @[RegStore.scala 155:25]
      data_32_length <= 6'h0; // @[RegStore.scala 156:10]
    end else if (_T) begin // @[RegStore.scala 109:25]
      if (6'h20 == io_wPorts_0_req_bits_addr) begin // @[RegStore.scala 111:30]
        data_32_length <= io_wPorts_0_req_bits_wdata_length; // @[RegStore.scala 111:30]
      end
    end
    if (reset) begin // @[RegStore.scala 104:21]
      data_33_rowAddr <= 7'h0; // @[RegStore.scala 104:21]
    end else if (reset) begin // @[RegStore.scala 155:25]
      data_33_rowAddr <= 7'h0; // @[RegStore.scala 156:10]
    end else if (_T) begin // @[RegStore.scala 109:25]
      if (6'h21 == io_wPorts_0_req_bits_addr) begin // @[RegStore.scala 111:30]
        data_33_rowAddr <= io_wPorts_0_req_bits_wdata_rowAddr; // @[RegStore.scala 111:30]
      end
    end
    if (reset) begin // @[RegStore.scala 104:21]
      data_33_length <= 6'h0; // @[RegStore.scala 104:21]
    end else if (reset) begin // @[RegStore.scala 155:25]
      data_33_length <= 6'h0; // @[RegStore.scala 156:10]
    end else if (_T) begin // @[RegStore.scala 109:25]
      if (6'h21 == io_wPorts_0_req_bits_addr) begin // @[RegStore.scala 111:30]
        data_33_length <= io_wPorts_0_req_bits_wdata_length; // @[RegStore.scala 111:30]
      end
    end
    if (reset) begin // @[RegStore.scala 104:21]
      data_34_rowAddr <= 7'h0; // @[RegStore.scala 104:21]
    end else if (reset) begin // @[RegStore.scala 155:25]
      data_34_rowAddr <= 7'h0; // @[RegStore.scala 156:10]
    end else if (_T) begin // @[RegStore.scala 109:25]
      if (6'h22 == io_wPorts_0_req_bits_addr) begin // @[RegStore.scala 111:30]
        data_34_rowAddr <= io_wPorts_0_req_bits_wdata_rowAddr; // @[RegStore.scala 111:30]
      end
    end
    if (reset) begin // @[RegStore.scala 104:21]
      data_34_length <= 6'h0; // @[RegStore.scala 104:21]
    end else if (reset) begin // @[RegStore.scala 155:25]
      data_34_length <= 6'h0; // @[RegStore.scala 156:10]
    end else if (_T) begin // @[RegStore.scala 109:25]
      if (6'h22 == io_wPorts_0_req_bits_addr) begin // @[RegStore.scala 111:30]
        data_34_length <= io_wPorts_0_req_bits_wdata_length; // @[RegStore.scala 111:30]
      end
    end
    if (reset) begin // @[RegStore.scala 104:21]
      data_35_rowAddr <= 7'h0; // @[RegStore.scala 104:21]
    end else if (reset) begin // @[RegStore.scala 155:25]
      data_35_rowAddr <= 7'h0; // @[RegStore.scala 156:10]
    end else if (_T) begin // @[RegStore.scala 109:25]
      if (6'h23 == io_wPorts_0_req_bits_addr) begin // @[RegStore.scala 111:30]
        data_35_rowAddr <= io_wPorts_0_req_bits_wdata_rowAddr; // @[RegStore.scala 111:30]
      end
    end
    if (reset) begin // @[RegStore.scala 104:21]
      data_35_length <= 6'h0; // @[RegStore.scala 104:21]
    end else if (reset) begin // @[RegStore.scala 155:25]
      data_35_length <= 6'h0; // @[RegStore.scala 156:10]
    end else if (_T) begin // @[RegStore.scala 109:25]
      if (6'h23 == io_wPorts_0_req_bits_addr) begin // @[RegStore.scala 111:30]
        data_35_length <= io_wPorts_0_req_bits_wdata_length; // @[RegStore.scala 111:30]
      end
    end
    if (reset) begin // @[RegStore.scala 104:21]
      data_36_rowAddr <= 7'h0; // @[RegStore.scala 104:21]
    end else if (reset) begin // @[RegStore.scala 155:25]
      data_36_rowAddr <= 7'h0; // @[RegStore.scala 156:10]
    end else if (_T) begin // @[RegStore.scala 109:25]
      if (6'h24 == io_wPorts_0_req_bits_addr) begin // @[RegStore.scala 111:30]
        data_36_rowAddr <= io_wPorts_0_req_bits_wdata_rowAddr; // @[RegStore.scala 111:30]
      end
    end
    if (reset) begin // @[RegStore.scala 104:21]
      data_36_length <= 6'h0; // @[RegStore.scala 104:21]
    end else if (reset) begin // @[RegStore.scala 155:25]
      data_36_length <= 6'h0; // @[RegStore.scala 156:10]
    end else if (_T) begin // @[RegStore.scala 109:25]
      if (6'h24 == io_wPorts_0_req_bits_addr) begin // @[RegStore.scala 111:30]
        data_36_length <= io_wPorts_0_req_bits_wdata_length; // @[RegStore.scala 111:30]
      end
    end
    if (reset) begin // @[RegStore.scala 104:21]
      data_37_rowAddr <= 7'h0; // @[RegStore.scala 104:21]
    end else if (reset) begin // @[RegStore.scala 155:25]
      data_37_rowAddr <= 7'h0; // @[RegStore.scala 156:10]
    end else if (_T) begin // @[RegStore.scala 109:25]
      if (6'h25 == io_wPorts_0_req_bits_addr) begin // @[RegStore.scala 111:30]
        data_37_rowAddr <= io_wPorts_0_req_bits_wdata_rowAddr; // @[RegStore.scala 111:30]
      end
    end
    if (reset) begin // @[RegStore.scala 104:21]
      data_37_length <= 6'h0; // @[RegStore.scala 104:21]
    end else if (reset) begin // @[RegStore.scala 155:25]
      data_37_length <= 6'h0; // @[RegStore.scala 156:10]
    end else if (_T) begin // @[RegStore.scala 109:25]
      if (6'h25 == io_wPorts_0_req_bits_addr) begin // @[RegStore.scala 111:30]
        data_37_length <= io_wPorts_0_req_bits_wdata_length; // @[RegStore.scala 111:30]
      end
    end
    if (reset) begin // @[RegStore.scala 104:21]
      data_38_rowAddr <= 7'h0; // @[RegStore.scala 104:21]
    end else if (reset) begin // @[RegStore.scala 155:25]
      data_38_rowAddr <= 7'h0; // @[RegStore.scala 156:10]
    end else if (_T) begin // @[RegStore.scala 109:25]
      if (6'h26 == io_wPorts_0_req_bits_addr) begin // @[RegStore.scala 111:30]
        data_38_rowAddr <= io_wPorts_0_req_bits_wdata_rowAddr; // @[RegStore.scala 111:30]
      end
    end
    if (reset) begin // @[RegStore.scala 104:21]
      data_38_length <= 6'h0; // @[RegStore.scala 104:21]
    end else if (reset) begin // @[RegStore.scala 155:25]
      data_38_length <= 6'h0; // @[RegStore.scala 156:10]
    end else if (_T) begin // @[RegStore.scala 109:25]
      if (6'h26 == io_wPorts_0_req_bits_addr) begin // @[RegStore.scala 111:30]
        data_38_length <= io_wPorts_0_req_bits_wdata_length; // @[RegStore.scala 111:30]
      end
    end
    if (reset) begin // @[RegStore.scala 104:21]
      data_39_rowAddr <= 7'h0; // @[RegStore.scala 104:21]
    end else if (reset) begin // @[RegStore.scala 155:25]
      data_39_rowAddr <= 7'h0; // @[RegStore.scala 156:10]
    end else if (_T) begin // @[RegStore.scala 109:25]
      if (6'h27 == io_wPorts_0_req_bits_addr) begin // @[RegStore.scala 111:30]
        data_39_rowAddr <= io_wPorts_0_req_bits_wdata_rowAddr; // @[RegStore.scala 111:30]
      end
    end
    if (reset) begin // @[RegStore.scala 104:21]
      data_39_length <= 6'h0; // @[RegStore.scala 104:21]
    end else if (reset) begin // @[RegStore.scala 155:25]
      data_39_length <= 6'h0; // @[RegStore.scala 156:10]
    end else if (_T) begin // @[RegStore.scala 109:25]
      if (6'h27 == io_wPorts_0_req_bits_addr) begin // @[RegStore.scala 111:30]
        data_39_length <= io_wPorts_0_req_bits_wdata_length; // @[RegStore.scala 111:30]
      end
    end
    if (reset) begin // @[RegStore.scala 104:21]
      data_40_rowAddr <= 7'h0; // @[RegStore.scala 104:21]
    end else if (reset) begin // @[RegStore.scala 155:25]
      data_40_rowAddr <= 7'h0; // @[RegStore.scala 156:10]
    end else if (_T) begin // @[RegStore.scala 109:25]
      if (6'h28 == io_wPorts_0_req_bits_addr) begin // @[RegStore.scala 111:30]
        data_40_rowAddr <= io_wPorts_0_req_bits_wdata_rowAddr; // @[RegStore.scala 111:30]
      end
    end
    if (reset) begin // @[RegStore.scala 104:21]
      data_40_length <= 6'h0; // @[RegStore.scala 104:21]
    end else if (reset) begin // @[RegStore.scala 155:25]
      data_40_length <= 6'h0; // @[RegStore.scala 156:10]
    end else if (_T) begin // @[RegStore.scala 109:25]
      if (6'h28 == io_wPorts_0_req_bits_addr) begin // @[RegStore.scala 111:30]
        data_40_length <= io_wPorts_0_req_bits_wdata_length; // @[RegStore.scala 111:30]
      end
    end
    if (reset) begin // @[RegStore.scala 104:21]
      data_41_rowAddr <= 7'h0; // @[RegStore.scala 104:21]
    end else if (reset) begin // @[RegStore.scala 155:25]
      data_41_rowAddr <= 7'h0; // @[RegStore.scala 156:10]
    end else if (_T) begin // @[RegStore.scala 109:25]
      if (6'h29 == io_wPorts_0_req_bits_addr) begin // @[RegStore.scala 111:30]
        data_41_rowAddr <= io_wPorts_0_req_bits_wdata_rowAddr; // @[RegStore.scala 111:30]
      end
    end
    if (reset) begin // @[RegStore.scala 104:21]
      data_41_length <= 6'h0; // @[RegStore.scala 104:21]
    end else if (reset) begin // @[RegStore.scala 155:25]
      data_41_length <= 6'h0; // @[RegStore.scala 156:10]
    end else if (_T) begin // @[RegStore.scala 109:25]
      if (6'h29 == io_wPorts_0_req_bits_addr) begin // @[RegStore.scala 111:30]
        data_41_length <= io_wPorts_0_req_bits_wdata_length; // @[RegStore.scala 111:30]
      end
    end
    if (reset) begin // @[RegStore.scala 104:21]
      data_42_rowAddr <= 7'h0; // @[RegStore.scala 104:21]
    end else if (reset) begin // @[RegStore.scala 155:25]
      data_42_rowAddr <= 7'h0; // @[RegStore.scala 156:10]
    end else if (_T) begin // @[RegStore.scala 109:25]
      if (6'h2a == io_wPorts_0_req_bits_addr) begin // @[RegStore.scala 111:30]
        data_42_rowAddr <= io_wPorts_0_req_bits_wdata_rowAddr; // @[RegStore.scala 111:30]
      end
    end
    if (reset) begin // @[RegStore.scala 104:21]
      data_42_length <= 6'h0; // @[RegStore.scala 104:21]
    end else if (reset) begin // @[RegStore.scala 155:25]
      data_42_length <= 6'h0; // @[RegStore.scala 156:10]
    end else if (_T) begin // @[RegStore.scala 109:25]
      if (6'h2a == io_wPorts_0_req_bits_addr) begin // @[RegStore.scala 111:30]
        data_42_length <= io_wPorts_0_req_bits_wdata_length; // @[RegStore.scala 111:30]
      end
    end
    if (reset) begin // @[RegStore.scala 104:21]
      data_43_rowAddr <= 7'h0; // @[RegStore.scala 104:21]
    end else if (reset) begin // @[RegStore.scala 155:25]
      data_43_rowAddr <= 7'h0; // @[RegStore.scala 156:10]
    end else if (_T) begin // @[RegStore.scala 109:25]
      if (6'h2b == io_wPorts_0_req_bits_addr) begin // @[RegStore.scala 111:30]
        data_43_rowAddr <= io_wPorts_0_req_bits_wdata_rowAddr; // @[RegStore.scala 111:30]
      end
    end
    if (reset) begin // @[RegStore.scala 104:21]
      data_43_length <= 6'h0; // @[RegStore.scala 104:21]
    end else if (reset) begin // @[RegStore.scala 155:25]
      data_43_length <= 6'h0; // @[RegStore.scala 156:10]
    end else if (_T) begin // @[RegStore.scala 109:25]
      if (6'h2b == io_wPorts_0_req_bits_addr) begin // @[RegStore.scala 111:30]
        data_43_length <= io_wPorts_0_req_bits_wdata_length; // @[RegStore.scala 111:30]
      end
    end
    if (reset) begin // @[RegStore.scala 104:21]
      data_44_rowAddr <= 7'h0; // @[RegStore.scala 104:21]
    end else if (reset) begin // @[RegStore.scala 155:25]
      data_44_rowAddr <= 7'h0; // @[RegStore.scala 156:10]
    end else if (_T) begin // @[RegStore.scala 109:25]
      if (6'h2c == io_wPorts_0_req_bits_addr) begin // @[RegStore.scala 111:30]
        data_44_rowAddr <= io_wPorts_0_req_bits_wdata_rowAddr; // @[RegStore.scala 111:30]
      end
    end
    if (reset) begin // @[RegStore.scala 104:21]
      data_44_length <= 6'h0; // @[RegStore.scala 104:21]
    end else if (reset) begin // @[RegStore.scala 155:25]
      data_44_length <= 6'h0; // @[RegStore.scala 156:10]
    end else if (_T) begin // @[RegStore.scala 109:25]
      if (6'h2c == io_wPorts_0_req_bits_addr) begin // @[RegStore.scala 111:30]
        data_44_length <= io_wPorts_0_req_bits_wdata_length; // @[RegStore.scala 111:30]
      end
    end
    if (reset) begin // @[RegStore.scala 104:21]
      data_45_rowAddr <= 7'h0; // @[RegStore.scala 104:21]
    end else if (reset) begin // @[RegStore.scala 155:25]
      data_45_rowAddr <= 7'h0; // @[RegStore.scala 156:10]
    end else if (_T) begin // @[RegStore.scala 109:25]
      if (6'h2d == io_wPorts_0_req_bits_addr) begin // @[RegStore.scala 111:30]
        data_45_rowAddr <= io_wPorts_0_req_bits_wdata_rowAddr; // @[RegStore.scala 111:30]
      end
    end
    if (reset) begin // @[RegStore.scala 104:21]
      data_45_length <= 6'h0; // @[RegStore.scala 104:21]
    end else if (reset) begin // @[RegStore.scala 155:25]
      data_45_length <= 6'h0; // @[RegStore.scala 156:10]
    end else if (_T) begin // @[RegStore.scala 109:25]
      if (6'h2d == io_wPorts_0_req_bits_addr) begin // @[RegStore.scala 111:30]
        data_45_length <= io_wPorts_0_req_bits_wdata_length; // @[RegStore.scala 111:30]
      end
    end
    if (reset) begin // @[RegStore.scala 104:21]
      data_46_rowAddr <= 7'h0; // @[RegStore.scala 104:21]
    end else if (reset) begin // @[RegStore.scala 155:25]
      data_46_rowAddr <= 7'h0; // @[RegStore.scala 156:10]
    end else if (_T) begin // @[RegStore.scala 109:25]
      if (6'h2e == io_wPorts_0_req_bits_addr) begin // @[RegStore.scala 111:30]
        data_46_rowAddr <= io_wPorts_0_req_bits_wdata_rowAddr; // @[RegStore.scala 111:30]
      end
    end
    if (reset) begin // @[RegStore.scala 104:21]
      data_46_length <= 6'h0; // @[RegStore.scala 104:21]
    end else if (reset) begin // @[RegStore.scala 155:25]
      data_46_length <= 6'h0; // @[RegStore.scala 156:10]
    end else if (_T) begin // @[RegStore.scala 109:25]
      if (6'h2e == io_wPorts_0_req_bits_addr) begin // @[RegStore.scala 111:30]
        data_46_length <= io_wPorts_0_req_bits_wdata_length; // @[RegStore.scala 111:30]
      end
    end
    if (reset) begin // @[RegStore.scala 104:21]
      data_47_rowAddr <= 7'h0; // @[RegStore.scala 104:21]
    end else if (reset) begin // @[RegStore.scala 155:25]
      data_47_rowAddr <= 7'h0; // @[RegStore.scala 156:10]
    end else if (_T) begin // @[RegStore.scala 109:25]
      if (6'h2f == io_wPorts_0_req_bits_addr) begin // @[RegStore.scala 111:30]
        data_47_rowAddr <= io_wPorts_0_req_bits_wdata_rowAddr; // @[RegStore.scala 111:30]
      end
    end
    if (reset) begin // @[RegStore.scala 104:21]
      data_47_length <= 6'h0; // @[RegStore.scala 104:21]
    end else if (reset) begin // @[RegStore.scala 155:25]
      data_47_length <= 6'h0; // @[RegStore.scala 156:10]
    end else if (_T) begin // @[RegStore.scala 109:25]
      if (6'h2f == io_wPorts_0_req_bits_addr) begin // @[RegStore.scala 111:30]
        data_47_length <= io_wPorts_0_req_bits_wdata_length; // @[RegStore.scala 111:30]
      end
    end
    if (reset) begin // @[RegStore.scala 104:21]
      data_48_rowAddr <= 7'h0; // @[RegStore.scala 104:21]
    end else if (reset) begin // @[RegStore.scala 155:25]
      data_48_rowAddr <= 7'h0; // @[RegStore.scala 156:10]
    end else if (_T) begin // @[RegStore.scala 109:25]
      if (6'h30 == io_wPorts_0_req_bits_addr) begin // @[RegStore.scala 111:30]
        data_48_rowAddr <= io_wPorts_0_req_bits_wdata_rowAddr; // @[RegStore.scala 111:30]
      end
    end
    if (reset) begin // @[RegStore.scala 104:21]
      data_48_length <= 6'h0; // @[RegStore.scala 104:21]
    end else if (reset) begin // @[RegStore.scala 155:25]
      data_48_length <= 6'h0; // @[RegStore.scala 156:10]
    end else if (_T) begin // @[RegStore.scala 109:25]
      if (6'h30 == io_wPorts_0_req_bits_addr) begin // @[RegStore.scala 111:30]
        data_48_length <= io_wPorts_0_req_bits_wdata_length; // @[RegStore.scala 111:30]
      end
    end
    if (reset) begin // @[RegStore.scala 104:21]
      data_49_rowAddr <= 7'h0; // @[RegStore.scala 104:21]
    end else if (reset) begin // @[RegStore.scala 155:25]
      data_49_rowAddr <= 7'h0; // @[RegStore.scala 156:10]
    end else if (_T) begin // @[RegStore.scala 109:25]
      if (6'h31 == io_wPorts_0_req_bits_addr) begin // @[RegStore.scala 111:30]
        data_49_rowAddr <= io_wPorts_0_req_bits_wdata_rowAddr; // @[RegStore.scala 111:30]
      end
    end
    if (reset) begin // @[RegStore.scala 104:21]
      data_49_length <= 6'h0; // @[RegStore.scala 104:21]
    end else if (reset) begin // @[RegStore.scala 155:25]
      data_49_length <= 6'h0; // @[RegStore.scala 156:10]
    end else if (_T) begin // @[RegStore.scala 109:25]
      if (6'h31 == io_wPorts_0_req_bits_addr) begin // @[RegStore.scala 111:30]
        data_49_length <= io_wPorts_0_req_bits_wdata_length; // @[RegStore.scala 111:30]
      end
    end
    if (reset) begin // @[RegStore.scala 104:21]
      data_50_rowAddr <= 7'h0; // @[RegStore.scala 104:21]
    end else if (reset) begin // @[RegStore.scala 155:25]
      data_50_rowAddr <= 7'h0; // @[RegStore.scala 156:10]
    end else if (_T) begin // @[RegStore.scala 109:25]
      if (6'h32 == io_wPorts_0_req_bits_addr) begin // @[RegStore.scala 111:30]
        data_50_rowAddr <= io_wPorts_0_req_bits_wdata_rowAddr; // @[RegStore.scala 111:30]
      end
    end
    if (reset) begin // @[RegStore.scala 104:21]
      data_50_length <= 6'h0; // @[RegStore.scala 104:21]
    end else if (reset) begin // @[RegStore.scala 155:25]
      data_50_length <= 6'h0; // @[RegStore.scala 156:10]
    end else if (_T) begin // @[RegStore.scala 109:25]
      if (6'h32 == io_wPorts_0_req_bits_addr) begin // @[RegStore.scala 111:30]
        data_50_length <= io_wPorts_0_req_bits_wdata_length; // @[RegStore.scala 111:30]
      end
    end
    if (reset) begin // @[RegStore.scala 104:21]
      data_51_rowAddr <= 7'h0; // @[RegStore.scala 104:21]
    end else if (reset) begin // @[RegStore.scala 155:25]
      data_51_rowAddr <= 7'h0; // @[RegStore.scala 156:10]
    end else if (_T) begin // @[RegStore.scala 109:25]
      if (6'h33 == io_wPorts_0_req_bits_addr) begin // @[RegStore.scala 111:30]
        data_51_rowAddr <= io_wPorts_0_req_bits_wdata_rowAddr; // @[RegStore.scala 111:30]
      end
    end
    if (reset) begin // @[RegStore.scala 104:21]
      data_51_length <= 6'h0; // @[RegStore.scala 104:21]
    end else if (reset) begin // @[RegStore.scala 155:25]
      data_51_length <= 6'h0; // @[RegStore.scala 156:10]
    end else if (_T) begin // @[RegStore.scala 109:25]
      if (6'h33 == io_wPorts_0_req_bits_addr) begin // @[RegStore.scala 111:30]
        data_51_length <= io_wPorts_0_req_bits_wdata_length; // @[RegStore.scala 111:30]
      end
    end
    if (reset) begin // @[RegStore.scala 104:21]
      data_52_rowAddr <= 7'h0; // @[RegStore.scala 104:21]
    end else if (reset) begin // @[RegStore.scala 155:25]
      data_52_rowAddr <= 7'h0; // @[RegStore.scala 156:10]
    end else if (_T) begin // @[RegStore.scala 109:25]
      if (6'h34 == io_wPorts_0_req_bits_addr) begin // @[RegStore.scala 111:30]
        data_52_rowAddr <= io_wPorts_0_req_bits_wdata_rowAddr; // @[RegStore.scala 111:30]
      end
    end
    if (reset) begin // @[RegStore.scala 104:21]
      data_52_length <= 6'h0; // @[RegStore.scala 104:21]
    end else if (reset) begin // @[RegStore.scala 155:25]
      data_52_length <= 6'h0; // @[RegStore.scala 156:10]
    end else if (_T) begin // @[RegStore.scala 109:25]
      if (6'h34 == io_wPorts_0_req_bits_addr) begin // @[RegStore.scala 111:30]
        data_52_length <= io_wPorts_0_req_bits_wdata_length; // @[RegStore.scala 111:30]
      end
    end
    if (reset) begin // @[RegStore.scala 104:21]
      data_53_rowAddr <= 7'h0; // @[RegStore.scala 104:21]
    end else if (reset) begin // @[RegStore.scala 155:25]
      data_53_rowAddr <= 7'h0; // @[RegStore.scala 156:10]
    end else if (_T) begin // @[RegStore.scala 109:25]
      if (6'h35 == io_wPorts_0_req_bits_addr) begin // @[RegStore.scala 111:30]
        data_53_rowAddr <= io_wPorts_0_req_bits_wdata_rowAddr; // @[RegStore.scala 111:30]
      end
    end
    if (reset) begin // @[RegStore.scala 104:21]
      data_53_length <= 6'h0; // @[RegStore.scala 104:21]
    end else if (reset) begin // @[RegStore.scala 155:25]
      data_53_length <= 6'h0; // @[RegStore.scala 156:10]
    end else if (_T) begin // @[RegStore.scala 109:25]
      if (6'h35 == io_wPorts_0_req_bits_addr) begin // @[RegStore.scala 111:30]
        data_53_length <= io_wPorts_0_req_bits_wdata_length; // @[RegStore.scala 111:30]
      end
    end
    if (reset) begin // @[RegStore.scala 104:21]
      data_54_rowAddr <= 7'h0; // @[RegStore.scala 104:21]
    end else if (reset) begin // @[RegStore.scala 155:25]
      data_54_rowAddr <= 7'h0; // @[RegStore.scala 156:10]
    end else if (_T) begin // @[RegStore.scala 109:25]
      if (6'h36 == io_wPorts_0_req_bits_addr) begin // @[RegStore.scala 111:30]
        data_54_rowAddr <= io_wPorts_0_req_bits_wdata_rowAddr; // @[RegStore.scala 111:30]
      end
    end
    if (reset) begin // @[RegStore.scala 104:21]
      data_54_length <= 6'h0; // @[RegStore.scala 104:21]
    end else if (reset) begin // @[RegStore.scala 155:25]
      data_54_length <= 6'h0; // @[RegStore.scala 156:10]
    end else if (_T) begin // @[RegStore.scala 109:25]
      if (6'h36 == io_wPorts_0_req_bits_addr) begin // @[RegStore.scala 111:30]
        data_54_length <= io_wPorts_0_req_bits_wdata_length; // @[RegStore.scala 111:30]
      end
    end
    if (reset) begin // @[RegStore.scala 104:21]
      data_55_rowAddr <= 7'h0; // @[RegStore.scala 104:21]
    end else if (reset) begin // @[RegStore.scala 155:25]
      data_55_rowAddr <= 7'h0; // @[RegStore.scala 156:10]
    end else if (_T) begin // @[RegStore.scala 109:25]
      if (6'h37 == io_wPorts_0_req_bits_addr) begin // @[RegStore.scala 111:30]
        data_55_rowAddr <= io_wPorts_0_req_bits_wdata_rowAddr; // @[RegStore.scala 111:30]
      end
    end
    if (reset) begin // @[RegStore.scala 104:21]
      data_55_length <= 6'h0; // @[RegStore.scala 104:21]
    end else if (reset) begin // @[RegStore.scala 155:25]
      data_55_length <= 6'h0; // @[RegStore.scala 156:10]
    end else if (_T) begin // @[RegStore.scala 109:25]
      if (6'h37 == io_wPorts_0_req_bits_addr) begin // @[RegStore.scala 111:30]
        data_55_length <= io_wPorts_0_req_bits_wdata_length; // @[RegStore.scala 111:30]
      end
    end
    if (reset) begin // @[RegStore.scala 104:21]
      data_56_rowAddr <= 7'h0; // @[RegStore.scala 104:21]
    end else if (reset) begin // @[RegStore.scala 155:25]
      data_56_rowAddr <= 7'h0; // @[RegStore.scala 156:10]
    end else if (_T) begin // @[RegStore.scala 109:25]
      if (6'h38 == io_wPorts_0_req_bits_addr) begin // @[RegStore.scala 111:30]
        data_56_rowAddr <= io_wPorts_0_req_bits_wdata_rowAddr; // @[RegStore.scala 111:30]
      end
    end
    if (reset) begin // @[RegStore.scala 104:21]
      data_56_length <= 6'h0; // @[RegStore.scala 104:21]
    end else if (reset) begin // @[RegStore.scala 155:25]
      data_56_length <= 6'h0; // @[RegStore.scala 156:10]
    end else if (_T) begin // @[RegStore.scala 109:25]
      if (6'h38 == io_wPorts_0_req_bits_addr) begin // @[RegStore.scala 111:30]
        data_56_length <= io_wPorts_0_req_bits_wdata_length; // @[RegStore.scala 111:30]
      end
    end
    if (reset) begin // @[RegStore.scala 104:21]
      data_57_rowAddr <= 7'h0; // @[RegStore.scala 104:21]
    end else if (reset) begin // @[RegStore.scala 155:25]
      data_57_rowAddr <= 7'h0; // @[RegStore.scala 156:10]
    end else if (_T) begin // @[RegStore.scala 109:25]
      if (6'h39 == io_wPorts_0_req_bits_addr) begin // @[RegStore.scala 111:30]
        data_57_rowAddr <= io_wPorts_0_req_bits_wdata_rowAddr; // @[RegStore.scala 111:30]
      end
    end
    if (reset) begin // @[RegStore.scala 104:21]
      data_57_length <= 6'h0; // @[RegStore.scala 104:21]
    end else if (reset) begin // @[RegStore.scala 155:25]
      data_57_length <= 6'h0; // @[RegStore.scala 156:10]
    end else if (_T) begin // @[RegStore.scala 109:25]
      if (6'h39 == io_wPorts_0_req_bits_addr) begin // @[RegStore.scala 111:30]
        data_57_length <= io_wPorts_0_req_bits_wdata_length; // @[RegStore.scala 111:30]
      end
    end
    if (reset) begin // @[RegStore.scala 104:21]
      data_58_rowAddr <= 7'h0; // @[RegStore.scala 104:21]
    end else if (reset) begin // @[RegStore.scala 155:25]
      data_58_rowAddr <= 7'h0; // @[RegStore.scala 156:10]
    end else if (_T) begin // @[RegStore.scala 109:25]
      if (6'h3a == io_wPorts_0_req_bits_addr) begin // @[RegStore.scala 111:30]
        data_58_rowAddr <= io_wPorts_0_req_bits_wdata_rowAddr; // @[RegStore.scala 111:30]
      end
    end
    if (reset) begin // @[RegStore.scala 104:21]
      data_58_length <= 6'h0; // @[RegStore.scala 104:21]
    end else if (reset) begin // @[RegStore.scala 155:25]
      data_58_length <= 6'h0; // @[RegStore.scala 156:10]
    end else if (_T) begin // @[RegStore.scala 109:25]
      if (6'h3a == io_wPorts_0_req_bits_addr) begin // @[RegStore.scala 111:30]
        data_58_length <= io_wPorts_0_req_bits_wdata_length; // @[RegStore.scala 111:30]
      end
    end
    if (reset) begin // @[RegStore.scala 104:21]
      data_59_rowAddr <= 7'h0; // @[RegStore.scala 104:21]
    end else if (reset) begin // @[RegStore.scala 155:25]
      data_59_rowAddr <= 7'h0; // @[RegStore.scala 156:10]
    end else if (_T) begin // @[RegStore.scala 109:25]
      if (6'h3b == io_wPorts_0_req_bits_addr) begin // @[RegStore.scala 111:30]
        data_59_rowAddr <= io_wPorts_0_req_bits_wdata_rowAddr; // @[RegStore.scala 111:30]
      end
    end
    if (reset) begin // @[RegStore.scala 104:21]
      data_59_length <= 6'h0; // @[RegStore.scala 104:21]
    end else if (reset) begin // @[RegStore.scala 155:25]
      data_59_length <= 6'h0; // @[RegStore.scala 156:10]
    end else if (_T) begin // @[RegStore.scala 109:25]
      if (6'h3b == io_wPorts_0_req_bits_addr) begin // @[RegStore.scala 111:30]
        data_59_length <= io_wPorts_0_req_bits_wdata_length; // @[RegStore.scala 111:30]
      end
    end
    if (reset) begin // @[RegStore.scala 104:21]
      data_60_rowAddr <= 7'h0; // @[RegStore.scala 104:21]
    end else if (reset) begin // @[RegStore.scala 155:25]
      data_60_rowAddr <= 7'h0; // @[RegStore.scala 156:10]
    end else if (_T) begin // @[RegStore.scala 109:25]
      if (6'h3c == io_wPorts_0_req_bits_addr) begin // @[RegStore.scala 111:30]
        data_60_rowAddr <= io_wPorts_0_req_bits_wdata_rowAddr; // @[RegStore.scala 111:30]
      end
    end
    if (reset) begin // @[RegStore.scala 104:21]
      data_60_length <= 6'h0; // @[RegStore.scala 104:21]
    end else if (reset) begin // @[RegStore.scala 155:25]
      data_60_length <= 6'h0; // @[RegStore.scala 156:10]
    end else if (_T) begin // @[RegStore.scala 109:25]
      if (6'h3c == io_wPorts_0_req_bits_addr) begin // @[RegStore.scala 111:30]
        data_60_length <= io_wPorts_0_req_bits_wdata_length; // @[RegStore.scala 111:30]
      end
    end
    if (reset) begin // @[RegStore.scala 104:21]
      data_61_rowAddr <= 7'h0; // @[RegStore.scala 104:21]
    end else if (reset) begin // @[RegStore.scala 155:25]
      data_61_rowAddr <= 7'h0; // @[RegStore.scala 156:10]
    end else if (_T) begin // @[RegStore.scala 109:25]
      if (6'h3d == io_wPorts_0_req_bits_addr) begin // @[RegStore.scala 111:30]
        data_61_rowAddr <= io_wPorts_0_req_bits_wdata_rowAddr; // @[RegStore.scala 111:30]
      end
    end
    if (reset) begin // @[RegStore.scala 104:21]
      data_61_length <= 6'h0; // @[RegStore.scala 104:21]
    end else if (reset) begin // @[RegStore.scala 155:25]
      data_61_length <= 6'h0; // @[RegStore.scala 156:10]
    end else if (_T) begin // @[RegStore.scala 109:25]
      if (6'h3d == io_wPorts_0_req_bits_addr) begin // @[RegStore.scala 111:30]
        data_61_length <= io_wPorts_0_req_bits_wdata_length; // @[RegStore.scala 111:30]
      end
    end
    if (reset) begin // @[RegStore.scala 104:21]
      data_62_rowAddr <= 7'h0; // @[RegStore.scala 104:21]
    end else if (reset) begin // @[RegStore.scala 155:25]
      data_62_rowAddr <= 7'h0; // @[RegStore.scala 156:10]
    end else if (_T) begin // @[RegStore.scala 109:25]
      if (6'h3e == io_wPorts_0_req_bits_addr) begin // @[RegStore.scala 111:30]
        data_62_rowAddr <= io_wPorts_0_req_bits_wdata_rowAddr; // @[RegStore.scala 111:30]
      end
    end
    if (reset) begin // @[RegStore.scala 104:21]
      data_62_length <= 6'h0; // @[RegStore.scala 104:21]
    end else if (reset) begin // @[RegStore.scala 155:25]
      data_62_length <= 6'h0; // @[RegStore.scala 156:10]
    end else if (_T) begin // @[RegStore.scala 109:25]
      if (6'h3e == io_wPorts_0_req_bits_addr) begin // @[RegStore.scala 111:30]
        data_62_length <= io_wPorts_0_req_bits_wdata_length; // @[RegStore.scala 111:30]
      end
    end
    if (reset) begin // @[RegStore.scala 104:21]
      data_63_rowAddr <= 7'h0; // @[RegStore.scala 104:21]
    end else if (reset) begin // @[RegStore.scala 155:25]
      data_63_rowAddr <= 7'h0; // @[RegStore.scala 156:10]
    end else if (_T) begin // @[RegStore.scala 109:25]
      if (6'h3f == io_wPorts_0_req_bits_addr) begin // @[RegStore.scala 111:30]
        data_63_rowAddr <= io_wPorts_0_req_bits_wdata_rowAddr; // @[RegStore.scala 111:30]
      end
    end
    if (reset) begin // @[RegStore.scala 104:21]
      data_63_length <= 6'h0; // @[RegStore.scala 104:21]
    end else if (reset) begin // @[RegStore.scala 155:25]
      data_63_length <= 6'h0; // @[RegStore.scala 156:10]
    end else if (_T) begin // @[RegStore.scala 109:25]
      if (6'h3f == io_wPorts_0_req_bits_addr) begin // @[RegStore.scala 111:30]
        data_63_length <= io_wPorts_0_req_bits_wdata_length; // @[RegStore.scala 111:30]
      end
    end
    `ifndef SYNTHESIS
    `ifdef PRINTF_COND
      if (`PRINTF_COND) begin
    `endif
        if (_T_4 & ~(io_rPorts_0_rsp_ready | reset)) begin
          $fwrite(32'h80000002,
            "Assertion failed\n    at RegStore.scala:119 assert(rp.rsp.ready) // We cannot request data if we are not ready\n"
            ); // @[RegStore.scala 119:13]
        end
    `ifdef PRINTF_COND
      end
    `endif
    `endif // SYNTHESIS
    `ifndef SYNTHESIS
    `ifdef STOP_COND
      if (`STOP_COND) begin
    `endif
        if (_T_4 & ~(io_rPorts_0_rsp_ready | reset)) begin
          $fatal; // @[RegStore.scala 119:13]
        end
    `ifdef STOP_COND
      end
    `endif
    `endif // SYNTHESIS
  end
// Register and memory initialization
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
  data_0_rowAddr = _RAND_0[6:0];
  _RAND_1 = {1{`RANDOM}};
  data_0_length = _RAND_1[5:0];
  _RAND_2 = {1{`RANDOM}};
  data_1_rowAddr = _RAND_2[6:0];
  _RAND_3 = {1{`RANDOM}};
  data_1_length = _RAND_3[5:0];
  _RAND_4 = {1{`RANDOM}};
  data_2_rowAddr = _RAND_4[6:0];
  _RAND_5 = {1{`RANDOM}};
  data_2_length = _RAND_5[5:0];
  _RAND_6 = {1{`RANDOM}};
  data_3_rowAddr = _RAND_6[6:0];
  _RAND_7 = {1{`RANDOM}};
  data_3_length = _RAND_7[5:0];
  _RAND_8 = {1{`RANDOM}};
  data_4_rowAddr = _RAND_8[6:0];
  _RAND_9 = {1{`RANDOM}};
  data_4_length = _RAND_9[5:0];
  _RAND_10 = {1{`RANDOM}};
  data_5_rowAddr = _RAND_10[6:0];
  _RAND_11 = {1{`RANDOM}};
  data_5_length = _RAND_11[5:0];
  _RAND_12 = {1{`RANDOM}};
  data_6_rowAddr = _RAND_12[6:0];
  _RAND_13 = {1{`RANDOM}};
  data_6_length = _RAND_13[5:0];
  _RAND_14 = {1{`RANDOM}};
  data_7_rowAddr = _RAND_14[6:0];
  _RAND_15 = {1{`RANDOM}};
  data_7_length = _RAND_15[5:0];
  _RAND_16 = {1{`RANDOM}};
  data_8_rowAddr = _RAND_16[6:0];
  _RAND_17 = {1{`RANDOM}};
  data_8_length = _RAND_17[5:0];
  _RAND_18 = {1{`RANDOM}};
  data_9_rowAddr = _RAND_18[6:0];
  _RAND_19 = {1{`RANDOM}};
  data_9_length = _RAND_19[5:0];
  _RAND_20 = {1{`RANDOM}};
  data_10_rowAddr = _RAND_20[6:0];
  _RAND_21 = {1{`RANDOM}};
  data_10_length = _RAND_21[5:0];
  _RAND_22 = {1{`RANDOM}};
  data_11_rowAddr = _RAND_22[6:0];
  _RAND_23 = {1{`RANDOM}};
  data_11_length = _RAND_23[5:0];
  _RAND_24 = {1{`RANDOM}};
  data_12_rowAddr = _RAND_24[6:0];
  _RAND_25 = {1{`RANDOM}};
  data_12_length = _RAND_25[5:0];
  _RAND_26 = {1{`RANDOM}};
  data_13_rowAddr = _RAND_26[6:0];
  _RAND_27 = {1{`RANDOM}};
  data_13_length = _RAND_27[5:0];
  _RAND_28 = {1{`RANDOM}};
  data_14_rowAddr = _RAND_28[6:0];
  _RAND_29 = {1{`RANDOM}};
  data_14_length = _RAND_29[5:0];
  _RAND_30 = {1{`RANDOM}};
  data_15_rowAddr = _RAND_30[6:0];
  _RAND_31 = {1{`RANDOM}};
  data_15_length = _RAND_31[5:0];
  _RAND_32 = {1{`RANDOM}};
  data_16_rowAddr = _RAND_32[6:0];
  _RAND_33 = {1{`RANDOM}};
  data_16_length = _RAND_33[5:0];
  _RAND_34 = {1{`RANDOM}};
  data_17_rowAddr = _RAND_34[6:0];
  _RAND_35 = {1{`RANDOM}};
  data_17_length = _RAND_35[5:0];
  _RAND_36 = {1{`RANDOM}};
  data_18_rowAddr = _RAND_36[6:0];
  _RAND_37 = {1{`RANDOM}};
  data_18_length = _RAND_37[5:0];
  _RAND_38 = {1{`RANDOM}};
  data_19_rowAddr = _RAND_38[6:0];
  _RAND_39 = {1{`RANDOM}};
  data_19_length = _RAND_39[5:0];
  _RAND_40 = {1{`RANDOM}};
  data_20_rowAddr = _RAND_40[6:0];
  _RAND_41 = {1{`RANDOM}};
  data_20_length = _RAND_41[5:0];
  _RAND_42 = {1{`RANDOM}};
  data_21_rowAddr = _RAND_42[6:0];
  _RAND_43 = {1{`RANDOM}};
  data_21_length = _RAND_43[5:0];
  _RAND_44 = {1{`RANDOM}};
  data_22_rowAddr = _RAND_44[6:0];
  _RAND_45 = {1{`RANDOM}};
  data_22_length = _RAND_45[5:0];
  _RAND_46 = {1{`RANDOM}};
  data_23_rowAddr = _RAND_46[6:0];
  _RAND_47 = {1{`RANDOM}};
  data_23_length = _RAND_47[5:0];
  _RAND_48 = {1{`RANDOM}};
  data_24_rowAddr = _RAND_48[6:0];
  _RAND_49 = {1{`RANDOM}};
  data_24_length = _RAND_49[5:0];
  _RAND_50 = {1{`RANDOM}};
  data_25_rowAddr = _RAND_50[6:0];
  _RAND_51 = {1{`RANDOM}};
  data_25_length = _RAND_51[5:0];
  _RAND_52 = {1{`RANDOM}};
  data_26_rowAddr = _RAND_52[6:0];
  _RAND_53 = {1{`RANDOM}};
  data_26_length = _RAND_53[5:0];
  _RAND_54 = {1{`RANDOM}};
  data_27_rowAddr = _RAND_54[6:0];
  _RAND_55 = {1{`RANDOM}};
  data_27_length = _RAND_55[5:0];
  _RAND_56 = {1{`RANDOM}};
  data_28_rowAddr = _RAND_56[6:0];
  _RAND_57 = {1{`RANDOM}};
  data_28_length = _RAND_57[5:0];
  _RAND_58 = {1{`RANDOM}};
  data_29_rowAddr = _RAND_58[6:0];
  _RAND_59 = {1{`RANDOM}};
  data_29_length = _RAND_59[5:0];
  _RAND_60 = {1{`RANDOM}};
  data_30_rowAddr = _RAND_60[6:0];
  _RAND_61 = {1{`RANDOM}};
  data_30_length = _RAND_61[5:0];
  _RAND_62 = {1{`RANDOM}};
  data_31_rowAddr = _RAND_62[6:0];
  _RAND_63 = {1{`RANDOM}};
  data_31_length = _RAND_63[5:0];
  _RAND_64 = {1{`RANDOM}};
  data_32_rowAddr = _RAND_64[6:0];
  _RAND_65 = {1{`RANDOM}};
  data_32_length = _RAND_65[5:0];
  _RAND_66 = {1{`RANDOM}};
  data_33_rowAddr = _RAND_66[6:0];
  _RAND_67 = {1{`RANDOM}};
  data_33_length = _RAND_67[5:0];
  _RAND_68 = {1{`RANDOM}};
  data_34_rowAddr = _RAND_68[6:0];
  _RAND_69 = {1{`RANDOM}};
  data_34_length = _RAND_69[5:0];
  _RAND_70 = {1{`RANDOM}};
  data_35_rowAddr = _RAND_70[6:0];
  _RAND_71 = {1{`RANDOM}};
  data_35_length = _RAND_71[5:0];
  _RAND_72 = {1{`RANDOM}};
  data_36_rowAddr = _RAND_72[6:0];
  _RAND_73 = {1{`RANDOM}};
  data_36_length = _RAND_73[5:0];
  _RAND_74 = {1{`RANDOM}};
  data_37_rowAddr = _RAND_74[6:0];
  _RAND_75 = {1{`RANDOM}};
  data_37_length = _RAND_75[5:0];
  _RAND_76 = {1{`RANDOM}};
  data_38_rowAddr = _RAND_76[6:0];
  _RAND_77 = {1{`RANDOM}};
  data_38_length = _RAND_77[5:0];
  _RAND_78 = {1{`RANDOM}};
  data_39_rowAddr = _RAND_78[6:0];
  _RAND_79 = {1{`RANDOM}};
  data_39_length = _RAND_79[5:0];
  _RAND_80 = {1{`RANDOM}};
  data_40_rowAddr = _RAND_80[6:0];
  _RAND_81 = {1{`RANDOM}};
  data_40_length = _RAND_81[5:0];
  _RAND_82 = {1{`RANDOM}};
  data_41_rowAddr = _RAND_82[6:0];
  _RAND_83 = {1{`RANDOM}};
  data_41_length = _RAND_83[5:0];
  _RAND_84 = {1{`RANDOM}};
  data_42_rowAddr = _RAND_84[6:0];
  _RAND_85 = {1{`RANDOM}};
  data_42_length = _RAND_85[5:0];
  _RAND_86 = {1{`RANDOM}};
  data_43_rowAddr = _RAND_86[6:0];
  _RAND_87 = {1{`RANDOM}};
  data_43_length = _RAND_87[5:0];
  _RAND_88 = {1{`RANDOM}};
  data_44_rowAddr = _RAND_88[6:0];
  _RAND_89 = {1{`RANDOM}};
  data_44_length = _RAND_89[5:0];
  _RAND_90 = {1{`RANDOM}};
  data_45_rowAddr = _RAND_90[6:0];
  _RAND_91 = {1{`RANDOM}};
  data_45_length = _RAND_91[5:0];
  _RAND_92 = {1{`RANDOM}};
  data_46_rowAddr = _RAND_92[6:0];
  _RAND_93 = {1{`RANDOM}};
  data_46_length = _RAND_93[5:0];
  _RAND_94 = {1{`RANDOM}};
  data_47_rowAddr = _RAND_94[6:0];
  _RAND_95 = {1{`RANDOM}};
  data_47_length = _RAND_95[5:0];
  _RAND_96 = {1{`RANDOM}};
  data_48_rowAddr = _RAND_96[6:0];
  _RAND_97 = {1{`RANDOM}};
  data_48_length = _RAND_97[5:0];
  _RAND_98 = {1{`RANDOM}};
  data_49_rowAddr = _RAND_98[6:0];
  _RAND_99 = {1{`RANDOM}};
  data_49_length = _RAND_99[5:0];
  _RAND_100 = {1{`RANDOM}};
  data_50_rowAddr = _RAND_100[6:0];
  _RAND_101 = {1{`RANDOM}};
  data_50_length = _RAND_101[5:0];
  _RAND_102 = {1{`RANDOM}};
  data_51_rowAddr = _RAND_102[6:0];
  _RAND_103 = {1{`RANDOM}};
  data_51_length = _RAND_103[5:0];
  _RAND_104 = {1{`RANDOM}};
  data_52_rowAddr = _RAND_104[6:0];
  _RAND_105 = {1{`RANDOM}};
  data_52_length = _RAND_105[5:0];
  _RAND_106 = {1{`RANDOM}};
  data_53_rowAddr = _RAND_106[6:0];
  _RAND_107 = {1{`RANDOM}};
  data_53_length = _RAND_107[5:0];
  _RAND_108 = {1{`RANDOM}};
  data_54_rowAddr = _RAND_108[6:0];
  _RAND_109 = {1{`RANDOM}};
  data_54_length = _RAND_109[5:0];
  _RAND_110 = {1{`RANDOM}};
  data_55_rowAddr = _RAND_110[6:0];
  _RAND_111 = {1{`RANDOM}};
  data_55_length = _RAND_111[5:0];
  _RAND_112 = {1{`RANDOM}};
  data_56_rowAddr = _RAND_112[6:0];
  _RAND_113 = {1{`RANDOM}};
  data_56_length = _RAND_113[5:0];
  _RAND_114 = {1{`RANDOM}};
  data_57_rowAddr = _RAND_114[6:0];
  _RAND_115 = {1{`RANDOM}};
  data_57_length = _RAND_115[5:0];
  _RAND_116 = {1{`RANDOM}};
  data_58_rowAddr = _RAND_116[6:0];
  _RAND_117 = {1{`RANDOM}};
  data_58_length = _RAND_117[5:0];
  _RAND_118 = {1{`RANDOM}};
  data_59_rowAddr = _RAND_118[6:0];
  _RAND_119 = {1{`RANDOM}};
  data_59_length = _RAND_119[5:0];
  _RAND_120 = {1{`RANDOM}};
  data_60_rowAddr = _RAND_120[6:0];
  _RAND_121 = {1{`RANDOM}};
  data_60_length = _RAND_121[5:0];
  _RAND_122 = {1{`RANDOM}};
  data_61_rowAddr = _RAND_122[6:0];
  _RAND_123 = {1{`RANDOM}};
  data_61_length = _RAND_123[5:0];
  _RAND_124 = {1{`RANDOM}};
  data_62_rowAddr = _RAND_124[6:0];
  _RAND_125 = {1{`RANDOM}};
  data_62_length = _RAND_125[5:0];
  _RAND_126 = {1{`RANDOM}};
  data_63_rowAddr = _RAND_126[6:0];
  _RAND_127 = {1{`RANDOM}};
  data_63_length = _RAND_127[5:0];
`endif // RANDOMIZE_REG_INIT
  `endif // RANDOMIZE
end // initial
`ifdef FIRRTL_AFTER_INITIAL
`FIRRTL_AFTER_INITIAL
`endif
`endif // SYNTHESIS
endmodule
module ReadReqGen(
  input         clock,
  input         reset,
  input         io_ctrl_start,
  input  [31:0] io_ctrl_baseAddr,
  input  [31:0] io_ctrl_byteCount,
  input         io_reqs_ready,
  output        io_reqs_valid,
  output [31:0] io_reqs_bits_addr,
  output [7:0]  io_reqs_bits_numBytes
);
`ifdef RANDOMIZE_REG_INIT
  reg [31:0] _RAND_0;
  reg [31:0] _RAND_1;
  reg [31:0] _RAND_2;
`endif // RANDOMIZE_REG_INIT
  reg [1:0] regState; // @[MemReqGen.scala 40:25]
  reg [31:0] regAddr; // @[MemReqGen.scala 41:24]
  reg [31:0] regBytesLeft; // @[MemReqGen.scala 42:29]
  wire  doBurst = regBytesLeft >= 32'h40; // @[MemReqGen.scala 53:31]
  wire [6:0] burstLen = doBurst ? 7'h40 : 7'h8; // @[MemReqGen.scala 54:21]
  wire  unalignedAddr = io_ctrl_baseAddr[5:0] != 6'h0; // @[MemReqGen.scala 59:63]
  wire  unalignedSize = io_ctrl_byteCount[2:0] != 3'h0; // @[MemReqGen.scala 62:64]
  wire  isUnaligned = unalignedSize | unalignedAddr; // @[MemReqGen.scala 63:35]
  wire  _T = 2'h0 == regState; // @[Conditional.scala 37:30]
  wire  _T_1 = 2'h1 == regState; // @[Conditional.scala 37:30]
  wire [31:0] _GEN_27 = {{25'd0}, burstLen}; // @[MemReqGen.scala 79:32]
  wire [31:0] _regAddr_T_1 = regAddr + _GEN_27; // @[MemReqGen.scala 79:32]
  wire [31:0] _regBytesLeft_T_1 = regBytesLeft - _GEN_27; // @[MemReqGen.scala 80:42]
  wire [31:0] _GEN_1 = io_reqs_ready ? _regAddr_T_1 : regAddr; // @[MemReqGen.scala 77:32 MemReqGen.scala 79:21 MemReqGen.scala 41:24]
  wire [31:0] _GEN_2 = io_reqs_ready ? _regBytesLeft_T_1 : regBytesLeft; // @[MemReqGen.scala 77:32 MemReqGen.scala 80:26 MemReqGen.scala 42:29]
  wire  _GEN_7 = regBytesLeft == 32'h0 ? 1'h0 : 1'h1; // @[MemReqGen.scala 73:37 MemReqGen.scala 47:17]
  wire  _T_4 = 2'h2 == regState; // @[Conditional.scala 37:30]
  wire [1:0] _GEN_10 = ~io_ctrl_start ? 2'h0 : regState; // @[MemReqGen.scala 87:31 MemReqGen.scala 87:42 MemReqGen.scala 40:25]
  wire  _T_6 = 2'h3 == regState; // @[Conditional.scala 37:30]
  wire  _T_8 = ~reset; // @[MemReqGen.scala 93:15]
  wire  _GEN_16 = _T_1 & _GEN_7; // @[Conditional.scala 39:67 MemReqGen.scala 47:17]
  wire  _GEN_35 = ~_T & ~_T_1 & ~_T_4 & _T_6; // @[MemReqGen.scala 93:15]
  assign io_reqs_valid = _T ? 1'h0 : _GEN_16; // @[Conditional.scala 40:58 MemReqGen.scala 47:17]
  assign io_reqs_bits_addr = regAddr; // @[MemReqGen.scala 50:21]
  assign io_reqs_bits_numBytes = {{1'd0}, burstLen}; // @[MemReqGen.scala 54:21]
  always @(posedge clock) begin
    if (reset) begin // @[MemReqGen.scala 40:25]
      regState <= 2'h0; // @[MemReqGen.scala 40:25]
    end else if (_T) begin // @[Conditional.scala 40:58]
      if (io_ctrl_start) begin // @[MemReqGen.scala 69:30]
        if (isUnaligned) begin // @[MemReqGen.scala 69:47]
          regState <= 2'h3;
        end else begin
          regState <= 2'h1;
        end
      end
    end else if (_T_1) begin // @[Conditional.scala 39:67]
      if (regBytesLeft == 32'h0) begin // @[MemReqGen.scala 73:37]
        regState <= 2'h2; // @[MemReqGen.scala 73:48]
      end
    end else if (_T_4) begin // @[Conditional.scala 39:67]
      regState <= _GEN_10;
    end
    if (reset) begin // @[MemReqGen.scala 41:24]
      regAddr <= 32'h0; // @[MemReqGen.scala 41:24]
    end else if (_T) begin // @[Conditional.scala 40:58]
      regAddr <= io_ctrl_baseAddr; // @[MemReqGen.scala 67:17]
    end else if (_T_1) begin // @[Conditional.scala 39:67]
      if (!(regBytesLeft == 32'h0)) begin // @[MemReqGen.scala 73:37]
        regAddr <= _GEN_1;
      end
    end
    if (reset) begin // @[MemReqGen.scala 42:29]
      regBytesLeft <= 32'h0; // @[MemReqGen.scala 42:29]
    end else if (_T) begin // @[Conditional.scala 40:58]
      regBytesLeft <= io_ctrl_byteCount; // @[MemReqGen.scala 68:22]
    end else if (_T_1) begin // @[Conditional.scala 39:67]
      if (!(regBytesLeft == 32'h0)) begin // @[MemReqGen.scala 73:37]
        regBytesLeft <= _GEN_2;
      end
    end
    `ifndef SYNTHESIS
    `ifdef PRINTF_COND
      if (`PRINTF_COND) begin
    `endif
        if (~_T & ~_T_1 & ~_T_4 & _T_6 & ~reset) begin
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
        if (_GEN_35 & _T_8) begin
          $fwrite(32'h80000002,"Unaligned addr? %d size? %d \n",unalignedAddr,unalignedSize); // @[MemReqGen.scala 94:15]
        end
    `ifdef PRINTF_COND
      end
    `endif
    `endif // SYNTHESIS
  end
// Register and memory initialization
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
endmodule
module Queue_4(
  input         clock,
  input         reset,
  output        io_enq_ready,
  input         io_enq_valid,
  input  [63:0] io_enq_bits_readData,
  input         io_deq_ready,
  output        io_deq_valid,
  output [63:0] io_deq_bits_readData
);
`ifdef RANDOMIZE_MEM_INIT
  reg [63:0] _RAND_0;
`endif // RANDOMIZE_MEM_INIT
`ifdef RANDOMIZE_REG_INIT
  reg [31:0] _RAND_1;
  reg [31:0] _RAND_2;
  reg [31:0] _RAND_3;
`endif // RANDOMIZE_REG_INIT
  reg [63:0] ram_readData [0:7]; // @[Decoupled.scala 218:16]
  wire [63:0] ram_readData_io_deq_bits_MPORT_data; // @[Decoupled.scala 218:16]
  wire [2:0] ram_readData_io_deq_bits_MPORT_addr; // @[Decoupled.scala 218:16]
  wire [63:0] ram_readData_MPORT_data; // @[Decoupled.scala 218:16]
  wire [2:0] ram_readData_MPORT_addr; // @[Decoupled.scala 218:16]
  wire  ram_readData_MPORT_mask; // @[Decoupled.scala 218:16]
  wire  ram_readData_MPORT_en; // @[Decoupled.scala 218:16]
  reg [2:0] enq_ptr_value; // @[Counter.scala 60:40]
  reg [2:0] deq_ptr_value; // @[Counter.scala 60:40]
  reg  maybe_full; // @[Decoupled.scala 221:27]
  wire  ptr_match = enq_ptr_value == deq_ptr_value; // @[Decoupled.scala 223:33]
  wire  empty = ptr_match & ~maybe_full; // @[Decoupled.scala 224:25]
  wire  full = ptr_match & maybe_full; // @[Decoupled.scala 225:24]
  wire  do_enq = io_enq_ready & io_enq_valid; // @[Decoupled.scala 40:37]
  wire  do_deq = io_deq_ready & io_deq_valid; // @[Decoupled.scala 40:37]
  wire [2:0] _value_T_1 = enq_ptr_value + 3'h1; // @[Counter.scala 76:24]
  wire [2:0] _value_T_3 = deq_ptr_value + 3'h1; // @[Counter.scala 76:24]
  assign ram_readData_io_deq_bits_MPORT_addr = deq_ptr_value;
  assign ram_readData_io_deq_bits_MPORT_data = ram_readData[ram_readData_io_deq_bits_MPORT_addr]; // @[Decoupled.scala 218:16]
  assign ram_readData_MPORT_data = io_enq_bits_readData;
  assign ram_readData_MPORT_addr = enq_ptr_value;
  assign ram_readData_MPORT_mask = 1'h1;
  assign ram_readData_MPORT_en = io_enq_ready & io_enq_valid;
  assign io_enq_ready = ~full; // @[Decoupled.scala 241:19]
  assign io_deq_valid = ~empty; // @[Decoupled.scala 240:19]
  assign io_deq_bits_readData = ram_readData_io_deq_bits_MPORT_data; // @[Decoupled.scala 242:15]
  always @(posedge clock) begin
    if(ram_readData_MPORT_en & ram_readData_MPORT_mask) begin
      ram_readData[ram_readData_MPORT_addr] <= ram_readData_MPORT_data; // @[Decoupled.scala 218:16]
    end
    if (reset) begin // @[Counter.scala 60:40]
      enq_ptr_value <= 3'h0; // @[Counter.scala 60:40]
    end else if (do_enq) begin // @[Decoupled.scala 229:17]
      enq_ptr_value <= _value_T_1; // @[Counter.scala 76:15]
    end
    if (reset) begin // @[Counter.scala 60:40]
      deq_ptr_value <= 3'h0; // @[Counter.scala 60:40]
    end else if (do_deq) begin // @[Decoupled.scala 233:17]
      deq_ptr_value <= _value_T_3; // @[Counter.scala 76:15]
    end
    if (reset) begin // @[Decoupled.scala 221:27]
      maybe_full <= 1'h0; // @[Decoupled.scala 221:27]
    end else if (do_enq != do_deq) begin // @[Decoupled.scala 236:28]
      maybe_full <= do_enq; // @[Decoupled.scala 237:16]
    end
  end
// Register and memory initialization
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
`ifdef RANDOMIZE_MEM_INIT
  _RAND_0 = {2{`RANDOM}};
  for (initvar = 0; initvar < 8; initvar = initvar+1)
    ram_readData[initvar] = _RAND_0[63:0];
`endif // RANDOMIZE_MEM_INIT
`ifdef RANDOMIZE_REG_INIT
  _RAND_1 = {1{`RANDOM}};
  enq_ptr_value = _RAND_1[2:0];
  _RAND_2 = {1{`RANDOM}};
  deq_ptr_value = _RAND_2[2:0];
  _RAND_3 = {1{`RANDOM}};
  maybe_full = _RAND_3[0:0];
`endif // RANDOMIZE_REG_INIT
  `endif // RANDOMIZE
end // initial
`ifdef FIRRTL_AFTER_INITIAL
`FIRRTL_AFTER_INITIAL
`endif
`endif // SYNTHESIS
endmodule
module DRAM2BRAM(
  input          clock,
  input          reset,
  input          io_dramReq_ready,
  output         io_dramReq_valid,
  output [31:0]  io_dramReq_bits_addr,
  output [7:0]   io_dramReq_bits_numBytes,
  output         io_dramRsp_ready,
  input          io_dramRsp_valid,
  input  [63:0]  io_dramRsp_bits_readData,
  output [8:0]   io_bramCmd_req_addr,
  output [119:0] io_bramCmd_req_writeData,
  output         io_bramCmd_req_writeEn,
  input          io_start,
  output         io_finished,
  input  [63:0]  io_baseAddr,
  input  [5:0]   io_nRows,
  input  [5:0]   io_nCols,
  output         io_agentRowAddress_req_valid,
  output [5:0]   io_agentRowAddress_req_bits_addr,
  output [6:0]   io_agentRowAddress_req_bits_wdata_rowAddr,
  output [5:0]   io_agentRowAddress_req_bits_wdata_length
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
  reg [31:0] _RAND_13;
  reg [31:0] _RAND_14;
  reg [31:0] _RAND_15;
  reg [31:0] _RAND_16;
  reg [31:0] _RAND_17;
  reg [31:0] _RAND_18;
  reg [31:0] _RAND_19;
  reg [31:0] _RAND_20;
  reg [31:0] _RAND_21;
  reg [31:0] _RAND_22;
  reg [31:0] _RAND_23;
  reg [31:0] _RAND_24;
  reg [31:0] _RAND_25;
  reg [31:0] _RAND_26;
  reg [31:0] _RAND_27;
  reg [31:0] _RAND_28;
  reg [31:0] _RAND_29;
`endif // RANDOMIZE_REG_INIT
  wire  rg_clock; // @[DRAM2BRAM.scala 73:18]
  wire  rg_reset; // @[DRAM2BRAM.scala 73:18]
  wire  rg_io_ctrl_start; // @[DRAM2BRAM.scala 73:18]
  wire [31:0] rg_io_ctrl_baseAddr; // @[DRAM2BRAM.scala 73:18]
  wire [31:0] rg_io_ctrl_byteCount; // @[DRAM2BRAM.scala 73:18]
  wire  rg_io_reqs_ready; // @[DRAM2BRAM.scala 73:18]
  wire  rg_io_reqs_valid; // @[DRAM2BRAM.scala 73:18]
  wire [31:0] rg_io_reqs_bits_addr; // @[DRAM2BRAM.scala 73:18]
  wire [7:0] rg_io_reqs_bits_numBytes; // @[DRAM2BRAM.scala 73:18]
  wire  Queue_clock; // @[DRAM2BRAM.scala 80:20]
  wire  Queue_reset; // @[DRAM2BRAM.scala 80:20]
  wire  Queue_io_enq_ready; // @[DRAM2BRAM.scala 80:20]
  wire  Queue_io_enq_valid; // @[DRAM2BRAM.scala 80:20]
  wire [63:0] Queue_io_enq_bits_readData; // @[DRAM2BRAM.scala 80:20]
  wire  Queue_io_deq_ready; // @[DRAM2BRAM.scala 80:20]
  wire  Queue_io_deq_valid; // @[DRAM2BRAM.scala 80:20]
  wire [63:0] Queue_io_deq_bits_readData; // @[DRAM2BRAM.scala 80:20]
  reg [31:0] regBytesLeftInRow; // @[DRAM2BRAM.scala 84:34]
  reg [1:0] regState; // @[DRAM2BRAM.scala 117:25]
  reg [7:0] regBramLine_els_0_value; // @[DRAM2BRAM.scala 118:28]
  reg [5:0] regBramLine_els_0_col; // @[DRAM2BRAM.scala 118:28]
  reg [7:0] regBramLine_els_1_value; // @[DRAM2BRAM.scala 118:28]
  reg [5:0] regBramLine_els_1_col; // @[DRAM2BRAM.scala 118:28]
  reg [7:0] regBramLine_els_2_value; // @[DRAM2BRAM.scala 118:28]
  reg [5:0] regBramLine_els_2_col; // @[DRAM2BRAM.scala 118:28]
  reg [7:0] regBramLine_els_3_value; // @[DRAM2BRAM.scala 118:28]
  reg [5:0] regBramLine_els_3_col; // @[DRAM2BRAM.scala 118:28]
  reg [7:0] regBramLine_els_4_value; // @[DRAM2BRAM.scala 118:28]
  reg [5:0] regBramLine_els_4_col; // @[DRAM2BRAM.scala 118:28]
  reg [7:0] regBramLine_els_5_value; // @[DRAM2BRAM.scala 118:28]
  reg [5:0] regBramLine_els_5_col; // @[DRAM2BRAM.scala 118:28]
  reg [7:0] regBramLine_els_6_value; // @[DRAM2BRAM.scala 118:28]
  reg [5:0] regBramLine_els_6_col; // @[DRAM2BRAM.scala 118:28]
  reg [7:0] regBramLine_els_7_value; // @[DRAM2BRAM.scala 118:28]
  reg [5:0] regBramLine_els_7_col; // @[DRAM2BRAM.scala 118:28]
  reg [2:0] regElCnt; // @[DRAM2BRAM.scala 121:25]
  reg [8:0] regColAddrCnt; // @[DRAM2BRAM.scala 123:30]
  reg [6:0] regAgentRowCnt; // @[DRAM2BRAM.scala 124:31]
  reg [8:0] regBramRowCnt; // @[DRAM2BRAM.scala 125:30]
  reg [5:0] regNRows; // @[DRAM2BRAM.scala 127:25]
  reg [5:0] regNCols; // @[DRAM2BRAM.scala 128:25]
  reg [8:0] regNBytesInRow; // @[DRAM2BRAM.scala 129:31]
  reg [5:0] regNRowsReceived; // @[DRAM2BRAM.scala 132:33]
  reg [6:0] regAgentRowInfo_rowAddr; // @[DRAM2BRAM.scala 136:32]
  reg [5:0] regAgentRowInfo_length; // @[DRAM2BRAM.scala 136:32]
  reg [5:0] regAgentRowInfoAgentIdx; // @[DRAM2BRAM.scala 137:40]
  reg  regAgentHasValid; // @[DRAM2BRAM.scala 138:33]
  wire  _T = 2'h0 == regState; // @[Conditional.scala 37:30]
  wire [2:0] lower = io_nCols[2:0]; // @[StreamReader.scala 45:18]
  wire [2:0] lo = io_nCols[5:3]; // @[StreamReader.scala 46:18]
  wire  isAligned = lower == 3'h0; // @[StreamReader.scala 47:28]
  wire [3:0] _T_1 = {1'h0,lo}; // @[Cat.scala 30:58]
  wire [3:0] hi = _T_1 + 4'h1; // @[StreamReader.scala 48:53]
  wire [6:0] _T_3 = {hi,3'h0}; // @[Cat.scala 30:58]
  wire [6:0] _T_4 = isAligned ? {{1'd0}, io_nCols} : _T_3; // @[StreamReader.scala 48:15]
  wire [12:0] _T_5 = _T_4 * io_nRows; // @[MemoryController.scala 17:15]
  wire [6:0] _T_6 = io_nCols * 1'h1; // @[DRAM2BRAM.scala 163:57]
  wire [2:0] lower_1 = _T_6[2:0]; // @[StreamReader.scala 45:18]
  wire [3:0] lo_1 = _T_6[6:3]; // @[StreamReader.scala 46:18]
  wire  isAligned_1 = lower_1 == 3'h0; // @[StreamReader.scala 47:28]
  wire [4:0] _T_7 = {1'h0,lo_1}; // @[Cat.scala 30:58]
  wire [4:0] hi_1 = _T_7 + 5'h1; // @[StreamReader.scala 48:53]
  wire [7:0] _T_9 = {hi_1,3'h0}; // @[Cat.scala 30:58]
  wire [7:0] _T_10 = isAligned_1 ? {{1'd0}, _T_6} : _T_9; // @[StreamReader.scala 48:15]
  wire [2:0] _GEN_12 = io_start ? 3'h0 : regElCnt; // @[DRAM2BRAM.scala 156:23 DRAM2BRAM.scala 174:18 DRAM2BRAM.scala 121:25]
  wire  _T_11 = 2'h1 == regState; // @[Conditional.scala 37:30]
  wire  _T_12 = Queue_io_deq_ready & Queue_io_deq_valid; // @[Decoupled.scala 40:37]
  wire [7:0] _GEN_31 = regBytesLeftInRow > 32'h0 ? Queue_io_deq_bits_readData[7:0] : 8'h0; // @[DRAM2BRAM.scala 92:37 DRAM2BRAM.scala 93:17]
  wire [7:0] _GEN_32 = regBytesLeftInRow > 32'h1 ? Queue_io_deq_bits_readData[15:8] : 8'h0; // @[DRAM2BRAM.scala 92:37 DRAM2BRAM.scala 93:17]
  wire [7:0] _GEN_33 = regBytesLeftInRow > 32'h2 ? Queue_io_deq_bits_readData[23:16] : 8'h0; // @[DRAM2BRAM.scala 92:37 DRAM2BRAM.scala 93:17]
  wire [7:0] _GEN_34 = regBytesLeftInRow > 32'h3 ? Queue_io_deq_bits_readData[31:24] : 8'h0; // @[DRAM2BRAM.scala 92:37 DRAM2BRAM.scala 93:17]
  wire [7:0] _GEN_35 = regBytesLeftInRow > 32'h4 ? Queue_io_deq_bits_readData[39:32] : 8'h0; // @[DRAM2BRAM.scala 92:37 DRAM2BRAM.scala 93:17]
  wire [7:0] _GEN_36 = regBytesLeftInRow > 32'h5 ? Queue_io_deq_bits_readData[47:40] : 8'h0; // @[DRAM2BRAM.scala 92:37 DRAM2BRAM.scala 93:17]
  wire [7:0] _GEN_37 = regBytesLeftInRow > 32'h6 ? Queue_io_deq_bits_readData[55:48] : 8'h0; // @[DRAM2BRAM.scala 92:37 DRAM2BRAM.scala 93:17]
  wire [7:0] _GEN_38 = regBytesLeftInRow > 32'h7 ? Queue_io_deq_bits_readData[63:56] : 8'h0; // @[DRAM2BRAM.scala 92:37 DRAM2BRAM.scala 93:17]
  wire [31:0] _GEN_1328 = {{23'd0}, regNBytesInRow}; // @[DRAM2BRAM.scala 96:28]
  wire  _T_29 = regBytesLeftInRow == _GEN_1328; // @[DRAM2BRAM.scala 96:28]
  wire [6:0] _T_31 = regAgentRowCnt + 7'h1; // @[DRAM2BRAM.scala 98:39]
  wire [6:0] _GEN_40 = regBytesLeftInRow == _GEN_1328 ? _T_31 : regAgentRowCnt; // @[DRAM2BRAM.scala 96:48 DRAM2BRAM.scala 98:22 DRAM2BRAM.scala 124:31]
  wire [31:0] _T_34 = regBytesLeftInRow - 32'h8; // @[DRAM2BRAM.scala 104:46]
  wire [8:0] _T_36 = regColAddrCnt + 9'h8; // @[DRAM2BRAM.scala 105:38]
  wire [5:0] _T_38 = regNRowsReceived + 6'h1; // @[DRAM2BRAM.scala 111:44]
  wire [31:0] _GEN_41 = regBytesLeftInRow > 32'h8 ? _T_34 : {{23'd0}, regNBytesInRow}; // @[DRAM2BRAM.scala 103:53 DRAM2BRAM.scala 104:25 DRAM2BRAM.scala 109:25]
  wire [8:0] _GEN_42 = regBytesLeftInRow > 32'h8 ? _T_36 : 9'h0; // @[DRAM2BRAM.scala 103:53 DRAM2BRAM.scala 105:21 DRAM2BRAM.scala 110:21]
  wire  _GEN_43 = regBytesLeftInRow > 32'h8 ? 1'h0 : 1'h1; // @[DRAM2BRAM.scala 103:53 DRAM2BRAM.scala 106:19 DRAM2BRAM.scala 108:19]
  wire [5:0] _GEN_44 = regBytesLeftInRow > 32'h8 ? regNRowsReceived : _T_38; // @[DRAM2BRAM.scala 103:53 DRAM2BRAM.scala 132:33 DRAM2BRAM.scala 111:24]
  wire [9:0] _T_39 = {1'h0,regColAddrCnt}; // @[Cat.scala 30:58]
  wire [10:0] _T_41 = {{1'd0}, _T_39}; // @[Utils.scala 20:33]
  wire [9:0] _GEN_1329 = {{4'd0}, regNCols}; // @[Utils.scala 21:15]
  wire [9:0] _T_45 = _T_41[9:0] - _GEN_1329; // @[Utils.scala 22:13]
  wire [9:0] _T_46 = _T_41[9:0] >= _GEN_1329 ? _T_45 : _T_41[9:0]; // @[Utils.scala 21:10]
  wire [9:0] _T_50 = _T_39 + 10'h1; // @[Utils.scala 20:33]
  wire [9:0] _T_53 = _T_50 - _GEN_1329; // @[Utils.scala 22:13]
  wire [9:0] _T_54 = _T_50 >= _GEN_1329 ? _T_53 : _T_50; // @[Utils.scala 21:10]
  wire [9:0] _T_58 = _T_39 + 10'h2; // @[Utils.scala 20:33]
  wire [9:0] _T_61 = _T_58 - _GEN_1329; // @[Utils.scala 22:13]
  wire [9:0] _T_62 = _T_58 >= _GEN_1329 ? _T_61 : _T_58; // @[Utils.scala 21:10]
  wire [9:0] _T_66 = _T_39 + 10'h3; // @[Utils.scala 20:33]
  wire [9:0] _T_69 = _T_66 - _GEN_1329; // @[Utils.scala 22:13]
  wire [9:0] _T_70 = _T_66 >= _GEN_1329 ? _T_69 : _T_66; // @[Utils.scala 21:10]
  wire [9:0] _T_74 = _T_39 + 10'h4; // @[Utils.scala 20:33]
  wire [9:0] _T_77 = _T_74 - _GEN_1329; // @[Utils.scala 22:13]
  wire [9:0] _T_78 = _T_74 >= _GEN_1329 ? _T_77 : _T_74; // @[Utils.scala 21:10]
  wire [9:0] _T_82 = _T_39 + 10'h5; // @[Utils.scala 20:33]
  wire [9:0] _T_85 = _T_82 - _GEN_1329; // @[Utils.scala 22:13]
  wire [9:0] _T_86 = _T_82 >= _GEN_1329 ? _T_85 : _T_82; // @[Utils.scala 21:10]
  wire [9:0] _T_90 = _T_39 + 10'h6; // @[Utils.scala 20:33]
  wire [9:0] _T_93 = _T_90 - _GEN_1329; // @[Utils.scala 22:13]
  wire [9:0] _T_94 = _T_90 >= _GEN_1329 ? _T_93 : _T_90; // @[Utils.scala 21:10]
  wire [9:0] _T_98 = _T_39 + 10'h7; // @[Utils.scala 20:33]
  wire [9:0] _T_101 = _T_98 - _GEN_1329; // @[Utils.scala 22:13]
  wire [9:0] _T_102 = _T_98 >= _GEN_1329 ? _T_101 : _T_98; // @[Utils.scala 21:10]
  wire  _T_103 = _GEN_31 != 8'h0; // @[DRAM2BRAM.scala 194:52]
  wire  _T_104 = _GEN_32 != 8'h0; // @[DRAM2BRAM.scala 194:52]
  wire  _T_105 = _GEN_33 != 8'h0; // @[DRAM2BRAM.scala 194:52]
  wire  _T_106 = _GEN_34 != 8'h0; // @[DRAM2BRAM.scala 194:52]
  wire  _T_107 = _GEN_35 != 8'h0; // @[DRAM2BRAM.scala 194:52]
  wire  _T_108 = _GEN_36 != 8'h0; // @[DRAM2BRAM.scala 194:52]
  wire  _T_109 = _GEN_37 != 8'h0; // @[DRAM2BRAM.scala 194:52]
  wire  _T_110 = _GEN_38 != 8'h0; // @[DRAM2BRAM.scala 194:52]
  wire [1:0] _T_111 = _T_103 + _T_104; // @[Bitwise.scala 47:55]
  wire [1:0] _T_113 = _T_105 + _T_106; // @[Bitwise.scala 47:55]
  wire [2:0] _T_115 = _T_111 + _T_113; // @[Bitwise.scala 47:55]
  wire [1:0] _T_117 = _T_107 + _T_108; // @[Bitwise.scala 47:55]
  wire [1:0] _T_119 = _T_109 + _T_110; // @[Bitwise.scala 47:55]
  wire [2:0] _T_121 = _T_117 + _T_119; // @[Bitwise.scala 47:55]
  wire [3:0] _T_123 = _T_115 + _T_121; // @[Bitwise.scala 47:55]
  wire [5:0] _GEN_45 = _T_103 ? _T_46[5:0] : 6'h0; // @[Utils.scala 36:25 Utils.scala 37:19]
  wire [7:0] _GEN_46 = _T_103 ? _GEN_31 : 8'h0; // @[Utils.scala 36:25 Utils.scala 37:19]
  wire [2:0] _WIRE_33_0 = {{2'd0}, _T_103};
  wire [5:0] _GEN_48 = 3'h0 == _WIRE_33_0 ? _T_54[5:0] : _GEN_45; // @[Utils.scala 44:27 Utils.scala 44:27]
  wire [5:0] _GEN_49 = 3'h1 == _WIRE_33_0 ? _T_54[5:0] : 6'h0; // @[Utils.scala 44:27 Utils.scala 44:27]
  wire [5:0] _GEN_50 = 3'h2 == _WIRE_33_0 ? _T_54[5:0] : 6'h0; // @[Utils.scala 44:27 Utils.scala 44:27]
  wire [5:0] _GEN_51 = 3'h3 == _WIRE_33_0 ? _T_54[5:0] : 6'h0; // @[Utils.scala 44:27 Utils.scala 44:27]
  wire [5:0] _GEN_52 = 3'h4 == _WIRE_33_0 ? _T_54[5:0] : 6'h0; // @[Utils.scala 44:27 Utils.scala 44:27]
  wire [5:0] _GEN_53 = 3'h5 == _WIRE_33_0 ? _T_54[5:0] : 6'h0; // @[Utils.scala 44:27 Utils.scala 44:27]
  wire [5:0] _GEN_54 = 3'h6 == _WIRE_33_0 ? _T_54[5:0] : 6'h0; // @[Utils.scala 44:27 Utils.scala 44:27]
  wire [5:0] _GEN_55 = 3'h7 == _WIRE_33_0 ? _T_54[5:0] : 6'h0; // @[Utils.scala 44:27 Utils.scala 44:27]
  wire [7:0] _GEN_56 = 3'h0 == _WIRE_33_0 ? _GEN_32 : _GEN_46; // @[Utils.scala 44:27 Utils.scala 44:27]
  wire [7:0] _GEN_57 = 3'h1 == _WIRE_33_0 ? _GEN_32 : 8'h0; // @[Utils.scala 44:27 Utils.scala 44:27]
  wire [7:0] _GEN_58 = 3'h2 == _WIRE_33_0 ? _GEN_32 : 8'h0; // @[Utils.scala 44:27 Utils.scala 44:27]
  wire [7:0] _GEN_59 = 3'h3 == _WIRE_33_0 ? _GEN_32 : 8'h0; // @[Utils.scala 44:27 Utils.scala 44:27]
  wire [7:0] _GEN_60 = 3'h4 == _WIRE_33_0 ? _GEN_32 : 8'h0; // @[Utils.scala 44:27 Utils.scala 44:27]
  wire [7:0] _GEN_61 = 3'h5 == _WIRE_33_0 ? _GEN_32 : 8'h0; // @[Utils.scala 44:27 Utils.scala 44:27]
  wire [7:0] _GEN_62 = 3'h6 == _WIRE_33_0 ? _GEN_32 : 8'h0; // @[Utils.scala 44:27 Utils.scala 44:27]
  wire [7:0] _GEN_63 = 3'h7 == _WIRE_33_0 ? _GEN_32 : 8'h0; // @[Utils.scala 44:27 Utils.scala 44:27]
  wire [2:0] _T_134 = _WIRE_33_0 + 3'h1; // @[Utils.scala 45:32]
  wire [5:0] _GEN_64 = _T_104 ? _GEN_48 : _GEN_45; // @[Utils.scala 43:26]
  wire [5:0] _GEN_65 = _T_104 ? _GEN_49 : 6'h0; // @[Utils.scala 43:26]
  wire [5:0] _GEN_66 = _T_104 ? _GEN_50 : 6'h0; // @[Utils.scala 43:26]
  wire [5:0] _GEN_67 = _T_104 ? _GEN_51 : 6'h0; // @[Utils.scala 43:26]
  wire [5:0] _GEN_68 = _T_104 ? _GEN_52 : 6'h0; // @[Utils.scala 43:26]
  wire [5:0] _GEN_69 = _T_104 ? _GEN_53 : 6'h0; // @[Utils.scala 43:26]
  wire [5:0] _GEN_70 = _T_104 ? _GEN_54 : 6'h0; // @[Utils.scala 43:26]
  wire [5:0] _GEN_71 = _T_104 ? _GEN_55 : 6'h0; // @[Utils.scala 43:26]
  wire [7:0] _GEN_72 = _T_104 ? _GEN_56 : _GEN_46; // @[Utils.scala 43:26]
  wire [7:0] _GEN_73 = _T_104 ? _GEN_57 : 8'h0; // @[Utils.scala 43:26]
  wire [7:0] _GEN_74 = _T_104 ? _GEN_58 : 8'h0; // @[Utils.scala 43:26]
  wire [7:0] _GEN_75 = _T_104 ? _GEN_59 : 8'h0; // @[Utils.scala 43:26]
  wire [7:0] _GEN_76 = _T_104 ? _GEN_60 : 8'h0; // @[Utils.scala 43:26]
  wire [7:0] _GEN_77 = _T_104 ? _GEN_61 : 8'h0; // @[Utils.scala 43:26]
  wire [7:0] _GEN_78 = _T_104 ? _GEN_62 : 8'h0; // @[Utils.scala 43:26]
  wire [7:0] _GEN_79 = _T_104 ? _GEN_63 : 8'h0; // @[Utils.scala 43:26]
  wire [2:0] _GEN_80 = _T_104 ? _T_134 : _WIRE_33_0; // @[Utils.scala 43:26 Utils.scala 45:19 Utils.scala 47:19]
  wire [5:0] _GEN_81 = 3'h0 == _GEN_80 ? _T_62[5:0] : _GEN_64; // @[Utils.scala 44:27 Utils.scala 44:27]
  wire [5:0] _GEN_82 = 3'h1 == _GEN_80 ? _T_62[5:0] : _GEN_65; // @[Utils.scala 44:27 Utils.scala 44:27]
  wire [5:0] _GEN_83 = 3'h2 == _GEN_80 ? _T_62[5:0] : _GEN_66; // @[Utils.scala 44:27 Utils.scala 44:27]
  wire [5:0] _GEN_84 = 3'h3 == _GEN_80 ? _T_62[5:0] : _GEN_67; // @[Utils.scala 44:27 Utils.scala 44:27]
  wire [5:0] _GEN_85 = 3'h4 == _GEN_80 ? _T_62[5:0] : _GEN_68; // @[Utils.scala 44:27 Utils.scala 44:27]
  wire [5:0] _GEN_86 = 3'h5 == _GEN_80 ? _T_62[5:0] : _GEN_69; // @[Utils.scala 44:27 Utils.scala 44:27]
  wire [5:0] _GEN_87 = 3'h6 == _GEN_80 ? _T_62[5:0] : _GEN_70; // @[Utils.scala 44:27 Utils.scala 44:27]
  wire [5:0] _GEN_88 = 3'h7 == _GEN_80 ? _T_62[5:0] : _GEN_71; // @[Utils.scala 44:27 Utils.scala 44:27]
  wire [7:0] _GEN_89 = 3'h0 == _GEN_80 ? _GEN_33 : _GEN_72; // @[Utils.scala 44:27 Utils.scala 44:27]
  wire [7:0] _GEN_90 = 3'h1 == _GEN_80 ? _GEN_33 : _GEN_73; // @[Utils.scala 44:27 Utils.scala 44:27]
  wire [7:0] _GEN_91 = 3'h2 == _GEN_80 ? _GEN_33 : _GEN_74; // @[Utils.scala 44:27 Utils.scala 44:27]
  wire [7:0] _GEN_92 = 3'h3 == _GEN_80 ? _GEN_33 : _GEN_75; // @[Utils.scala 44:27 Utils.scala 44:27]
  wire [7:0] _GEN_93 = 3'h4 == _GEN_80 ? _GEN_33 : _GEN_76; // @[Utils.scala 44:27 Utils.scala 44:27]
  wire [7:0] _GEN_94 = 3'h5 == _GEN_80 ? _GEN_33 : _GEN_77; // @[Utils.scala 44:27 Utils.scala 44:27]
  wire [7:0] _GEN_95 = 3'h6 == _GEN_80 ? _GEN_33 : _GEN_78; // @[Utils.scala 44:27 Utils.scala 44:27]
  wire [7:0] _GEN_96 = 3'h7 == _GEN_80 ? _GEN_33 : _GEN_79; // @[Utils.scala 44:27 Utils.scala 44:27]
  wire [2:0] _T_136 = _GEN_80 + 3'h1; // @[Utils.scala 45:32]
  wire [5:0] _GEN_97 = _T_105 ? _GEN_81 : _GEN_64; // @[Utils.scala 43:26]
  wire [5:0] _GEN_98 = _T_105 ? _GEN_82 : _GEN_65; // @[Utils.scala 43:26]
  wire [5:0] _GEN_99 = _T_105 ? _GEN_83 : _GEN_66; // @[Utils.scala 43:26]
  wire [5:0] _GEN_100 = _T_105 ? _GEN_84 : _GEN_67; // @[Utils.scala 43:26]
  wire [5:0] _GEN_101 = _T_105 ? _GEN_85 : _GEN_68; // @[Utils.scala 43:26]
  wire [5:0] _GEN_102 = _T_105 ? _GEN_86 : _GEN_69; // @[Utils.scala 43:26]
  wire [5:0] _GEN_103 = _T_105 ? _GEN_87 : _GEN_70; // @[Utils.scala 43:26]
  wire [5:0] _GEN_104 = _T_105 ? _GEN_88 : _GEN_71; // @[Utils.scala 43:26]
  wire [7:0] _GEN_105 = _T_105 ? _GEN_89 : _GEN_72; // @[Utils.scala 43:26]
  wire [7:0] _GEN_106 = _T_105 ? _GEN_90 : _GEN_73; // @[Utils.scala 43:26]
  wire [7:0] _GEN_107 = _T_105 ? _GEN_91 : _GEN_74; // @[Utils.scala 43:26]
  wire [7:0] _GEN_108 = _T_105 ? _GEN_92 : _GEN_75; // @[Utils.scala 43:26]
  wire [7:0] _GEN_109 = _T_105 ? _GEN_93 : _GEN_76; // @[Utils.scala 43:26]
  wire [7:0] _GEN_110 = _T_105 ? _GEN_94 : _GEN_77; // @[Utils.scala 43:26]
  wire [7:0] _GEN_111 = _T_105 ? _GEN_95 : _GEN_78; // @[Utils.scala 43:26]
  wire [7:0] _GEN_112 = _T_105 ? _GEN_96 : _GEN_79; // @[Utils.scala 43:26]
  wire [2:0] _GEN_113 = _T_105 ? _T_136 : _GEN_80; // @[Utils.scala 43:26 Utils.scala 45:19 Utils.scala 47:19]
  wire [5:0] _GEN_114 = 3'h0 == _GEN_113 ? _T_70[5:0] : _GEN_97; // @[Utils.scala 44:27 Utils.scala 44:27]
  wire [5:0] _GEN_115 = 3'h1 == _GEN_113 ? _T_70[5:0] : _GEN_98; // @[Utils.scala 44:27 Utils.scala 44:27]
  wire [5:0] _GEN_116 = 3'h2 == _GEN_113 ? _T_70[5:0] : _GEN_99; // @[Utils.scala 44:27 Utils.scala 44:27]
  wire [5:0] _GEN_117 = 3'h3 == _GEN_113 ? _T_70[5:0] : _GEN_100; // @[Utils.scala 44:27 Utils.scala 44:27]
  wire [5:0] _GEN_118 = 3'h4 == _GEN_113 ? _T_70[5:0] : _GEN_101; // @[Utils.scala 44:27 Utils.scala 44:27]
  wire [5:0] _GEN_119 = 3'h5 == _GEN_113 ? _T_70[5:0] : _GEN_102; // @[Utils.scala 44:27 Utils.scala 44:27]
  wire [5:0] _GEN_120 = 3'h6 == _GEN_113 ? _T_70[5:0] : _GEN_103; // @[Utils.scala 44:27 Utils.scala 44:27]
  wire [5:0] _GEN_121 = 3'h7 == _GEN_113 ? _T_70[5:0] : _GEN_104; // @[Utils.scala 44:27 Utils.scala 44:27]
  wire [7:0] _GEN_122 = 3'h0 == _GEN_113 ? _GEN_34 : _GEN_105; // @[Utils.scala 44:27 Utils.scala 44:27]
  wire [7:0] _GEN_123 = 3'h1 == _GEN_113 ? _GEN_34 : _GEN_106; // @[Utils.scala 44:27 Utils.scala 44:27]
  wire [7:0] _GEN_124 = 3'h2 == _GEN_113 ? _GEN_34 : _GEN_107; // @[Utils.scala 44:27 Utils.scala 44:27]
  wire [7:0] _GEN_125 = 3'h3 == _GEN_113 ? _GEN_34 : _GEN_108; // @[Utils.scala 44:27 Utils.scala 44:27]
  wire [7:0] _GEN_126 = 3'h4 == _GEN_113 ? _GEN_34 : _GEN_109; // @[Utils.scala 44:27 Utils.scala 44:27]
  wire [7:0] _GEN_127 = 3'h5 == _GEN_113 ? _GEN_34 : _GEN_110; // @[Utils.scala 44:27 Utils.scala 44:27]
  wire [7:0] _GEN_128 = 3'h6 == _GEN_113 ? _GEN_34 : _GEN_111; // @[Utils.scala 44:27 Utils.scala 44:27]
  wire [7:0] _GEN_129 = 3'h7 == _GEN_113 ? _GEN_34 : _GEN_112; // @[Utils.scala 44:27 Utils.scala 44:27]
  wire [2:0] _T_138 = _GEN_113 + 3'h1; // @[Utils.scala 45:32]
  wire [5:0] _GEN_130 = _T_106 ? _GEN_114 : _GEN_97; // @[Utils.scala 43:26]
  wire [5:0] _GEN_131 = _T_106 ? _GEN_115 : _GEN_98; // @[Utils.scala 43:26]
  wire [5:0] _GEN_132 = _T_106 ? _GEN_116 : _GEN_99; // @[Utils.scala 43:26]
  wire [5:0] _GEN_133 = _T_106 ? _GEN_117 : _GEN_100; // @[Utils.scala 43:26]
  wire [5:0] _GEN_134 = _T_106 ? _GEN_118 : _GEN_101; // @[Utils.scala 43:26]
  wire [5:0] _GEN_135 = _T_106 ? _GEN_119 : _GEN_102; // @[Utils.scala 43:26]
  wire [5:0] _GEN_136 = _T_106 ? _GEN_120 : _GEN_103; // @[Utils.scala 43:26]
  wire [5:0] _GEN_137 = _T_106 ? _GEN_121 : _GEN_104; // @[Utils.scala 43:26]
  wire [7:0] _GEN_138 = _T_106 ? _GEN_122 : _GEN_105; // @[Utils.scala 43:26]
  wire [7:0] _GEN_139 = _T_106 ? _GEN_123 : _GEN_106; // @[Utils.scala 43:26]
  wire [7:0] _GEN_140 = _T_106 ? _GEN_124 : _GEN_107; // @[Utils.scala 43:26]
  wire [7:0] _GEN_141 = _T_106 ? _GEN_125 : _GEN_108; // @[Utils.scala 43:26]
  wire [7:0] _GEN_142 = _T_106 ? _GEN_126 : _GEN_109; // @[Utils.scala 43:26]
  wire [7:0] _GEN_143 = _T_106 ? _GEN_127 : _GEN_110; // @[Utils.scala 43:26]
  wire [7:0] _GEN_144 = _T_106 ? _GEN_128 : _GEN_111; // @[Utils.scala 43:26]
  wire [7:0] _GEN_145 = _T_106 ? _GEN_129 : _GEN_112; // @[Utils.scala 43:26]
  wire [2:0] _GEN_146 = _T_106 ? _T_138 : _GEN_113; // @[Utils.scala 43:26 Utils.scala 45:19 Utils.scala 47:19]
  wire [5:0] _GEN_147 = 3'h0 == _GEN_146 ? _T_78[5:0] : _GEN_130; // @[Utils.scala 44:27 Utils.scala 44:27]
  wire [5:0] _GEN_148 = 3'h1 == _GEN_146 ? _T_78[5:0] : _GEN_131; // @[Utils.scala 44:27 Utils.scala 44:27]
  wire [5:0] _GEN_149 = 3'h2 == _GEN_146 ? _T_78[5:0] : _GEN_132; // @[Utils.scala 44:27 Utils.scala 44:27]
  wire [5:0] _GEN_150 = 3'h3 == _GEN_146 ? _T_78[5:0] : _GEN_133; // @[Utils.scala 44:27 Utils.scala 44:27]
  wire [5:0] _GEN_151 = 3'h4 == _GEN_146 ? _T_78[5:0] : _GEN_134; // @[Utils.scala 44:27 Utils.scala 44:27]
  wire [5:0] _GEN_152 = 3'h5 == _GEN_146 ? _T_78[5:0] : _GEN_135; // @[Utils.scala 44:27 Utils.scala 44:27]
  wire [5:0] _GEN_153 = 3'h6 == _GEN_146 ? _T_78[5:0] : _GEN_136; // @[Utils.scala 44:27 Utils.scala 44:27]
  wire [5:0] _GEN_154 = 3'h7 == _GEN_146 ? _T_78[5:0] : _GEN_137; // @[Utils.scala 44:27 Utils.scala 44:27]
  wire [7:0] _GEN_155 = 3'h0 == _GEN_146 ? _GEN_35 : _GEN_138; // @[Utils.scala 44:27 Utils.scala 44:27]
  wire [7:0] _GEN_156 = 3'h1 == _GEN_146 ? _GEN_35 : _GEN_139; // @[Utils.scala 44:27 Utils.scala 44:27]
  wire [7:0] _GEN_157 = 3'h2 == _GEN_146 ? _GEN_35 : _GEN_140; // @[Utils.scala 44:27 Utils.scala 44:27]
  wire [7:0] _GEN_158 = 3'h3 == _GEN_146 ? _GEN_35 : _GEN_141; // @[Utils.scala 44:27 Utils.scala 44:27]
  wire [7:0] _GEN_159 = 3'h4 == _GEN_146 ? _GEN_35 : _GEN_142; // @[Utils.scala 44:27 Utils.scala 44:27]
  wire [7:0] _GEN_160 = 3'h5 == _GEN_146 ? _GEN_35 : _GEN_143; // @[Utils.scala 44:27 Utils.scala 44:27]
  wire [7:0] _GEN_161 = 3'h6 == _GEN_146 ? _GEN_35 : _GEN_144; // @[Utils.scala 44:27 Utils.scala 44:27]
  wire [7:0] _GEN_162 = 3'h7 == _GEN_146 ? _GEN_35 : _GEN_145; // @[Utils.scala 44:27 Utils.scala 44:27]
  wire [2:0] _T_140 = _GEN_146 + 3'h1; // @[Utils.scala 45:32]
  wire [5:0] _GEN_163 = _T_107 ? _GEN_147 : _GEN_130; // @[Utils.scala 43:26]
  wire [5:0] _GEN_164 = _T_107 ? _GEN_148 : _GEN_131; // @[Utils.scala 43:26]
  wire [5:0] _GEN_165 = _T_107 ? _GEN_149 : _GEN_132; // @[Utils.scala 43:26]
  wire [5:0] _GEN_166 = _T_107 ? _GEN_150 : _GEN_133; // @[Utils.scala 43:26]
  wire [5:0] _GEN_167 = _T_107 ? _GEN_151 : _GEN_134; // @[Utils.scala 43:26]
  wire [5:0] _GEN_168 = _T_107 ? _GEN_152 : _GEN_135; // @[Utils.scala 43:26]
  wire [5:0] _GEN_169 = _T_107 ? _GEN_153 : _GEN_136; // @[Utils.scala 43:26]
  wire [5:0] _GEN_170 = _T_107 ? _GEN_154 : _GEN_137; // @[Utils.scala 43:26]
  wire [7:0] _GEN_171 = _T_107 ? _GEN_155 : _GEN_138; // @[Utils.scala 43:26]
  wire [7:0] _GEN_172 = _T_107 ? _GEN_156 : _GEN_139; // @[Utils.scala 43:26]
  wire [7:0] _GEN_173 = _T_107 ? _GEN_157 : _GEN_140; // @[Utils.scala 43:26]
  wire [7:0] _GEN_174 = _T_107 ? _GEN_158 : _GEN_141; // @[Utils.scala 43:26]
  wire [7:0] _GEN_175 = _T_107 ? _GEN_159 : _GEN_142; // @[Utils.scala 43:26]
  wire [7:0] _GEN_176 = _T_107 ? _GEN_160 : _GEN_143; // @[Utils.scala 43:26]
  wire [7:0] _GEN_177 = _T_107 ? _GEN_161 : _GEN_144; // @[Utils.scala 43:26]
  wire [7:0] _GEN_178 = _T_107 ? _GEN_162 : _GEN_145; // @[Utils.scala 43:26]
  wire [2:0] _GEN_179 = _T_107 ? _T_140 : _GEN_146; // @[Utils.scala 43:26 Utils.scala 45:19 Utils.scala 47:19]
  wire [5:0] _GEN_180 = 3'h0 == _GEN_179 ? _T_86[5:0] : _GEN_163; // @[Utils.scala 44:27 Utils.scala 44:27]
  wire [5:0] _GEN_181 = 3'h1 == _GEN_179 ? _T_86[5:0] : _GEN_164; // @[Utils.scala 44:27 Utils.scala 44:27]
  wire [5:0] _GEN_182 = 3'h2 == _GEN_179 ? _T_86[5:0] : _GEN_165; // @[Utils.scala 44:27 Utils.scala 44:27]
  wire [5:0] _GEN_183 = 3'h3 == _GEN_179 ? _T_86[5:0] : _GEN_166; // @[Utils.scala 44:27 Utils.scala 44:27]
  wire [5:0] _GEN_184 = 3'h4 == _GEN_179 ? _T_86[5:0] : _GEN_167; // @[Utils.scala 44:27 Utils.scala 44:27]
  wire [5:0] _GEN_185 = 3'h5 == _GEN_179 ? _T_86[5:0] : _GEN_168; // @[Utils.scala 44:27 Utils.scala 44:27]
  wire [5:0] _GEN_186 = 3'h6 == _GEN_179 ? _T_86[5:0] : _GEN_169; // @[Utils.scala 44:27 Utils.scala 44:27]
  wire [5:0] _GEN_187 = 3'h7 == _GEN_179 ? _T_86[5:0] : _GEN_170; // @[Utils.scala 44:27 Utils.scala 44:27]
  wire [7:0] _GEN_188 = 3'h0 == _GEN_179 ? _GEN_36 : _GEN_171; // @[Utils.scala 44:27 Utils.scala 44:27]
  wire [7:0] _GEN_189 = 3'h1 == _GEN_179 ? _GEN_36 : _GEN_172; // @[Utils.scala 44:27 Utils.scala 44:27]
  wire [7:0] _GEN_190 = 3'h2 == _GEN_179 ? _GEN_36 : _GEN_173; // @[Utils.scala 44:27 Utils.scala 44:27]
  wire [7:0] _GEN_191 = 3'h3 == _GEN_179 ? _GEN_36 : _GEN_174; // @[Utils.scala 44:27 Utils.scala 44:27]
  wire [7:0] _GEN_192 = 3'h4 == _GEN_179 ? _GEN_36 : _GEN_175; // @[Utils.scala 44:27 Utils.scala 44:27]
  wire [7:0] _GEN_193 = 3'h5 == _GEN_179 ? _GEN_36 : _GEN_176; // @[Utils.scala 44:27 Utils.scala 44:27]
  wire [7:0] _GEN_194 = 3'h6 == _GEN_179 ? _GEN_36 : _GEN_177; // @[Utils.scala 44:27 Utils.scala 44:27]
  wire [7:0] _GEN_195 = 3'h7 == _GEN_179 ? _GEN_36 : _GEN_178; // @[Utils.scala 44:27 Utils.scala 44:27]
  wire [2:0] _T_142 = _GEN_179 + 3'h1; // @[Utils.scala 45:32]
  wire [5:0] _GEN_196 = _T_108 ? _GEN_180 : _GEN_163; // @[Utils.scala 43:26]
  wire [5:0] _GEN_197 = _T_108 ? _GEN_181 : _GEN_164; // @[Utils.scala 43:26]
  wire [5:0] _GEN_198 = _T_108 ? _GEN_182 : _GEN_165; // @[Utils.scala 43:26]
  wire [5:0] _GEN_199 = _T_108 ? _GEN_183 : _GEN_166; // @[Utils.scala 43:26]
  wire [5:0] _GEN_200 = _T_108 ? _GEN_184 : _GEN_167; // @[Utils.scala 43:26]
  wire [5:0] _GEN_201 = _T_108 ? _GEN_185 : _GEN_168; // @[Utils.scala 43:26]
  wire [5:0] _GEN_202 = _T_108 ? _GEN_186 : _GEN_169; // @[Utils.scala 43:26]
  wire [5:0] _GEN_203 = _T_108 ? _GEN_187 : _GEN_170; // @[Utils.scala 43:26]
  wire [7:0] _GEN_204 = _T_108 ? _GEN_188 : _GEN_171; // @[Utils.scala 43:26]
  wire [7:0] _GEN_205 = _T_108 ? _GEN_189 : _GEN_172; // @[Utils.scala 43:26]
  wire [7:0] _GEN_206 = _T_108 ? _GEN_190 : _GEN_173; // @[Utils.scala 43:26]
  wire [7:0] _GEN_207 = _T_108 ? _GEN_191 : _GEN_174; // @[Utils.scala 43:26]
  wire [7:0] _GEN_208 = _T_108 ? _GEN_192 : _GEN_175; // @[Utils.scala 43:26]
  wire [7:0] _GEN_209 = _T_108 ? _GEN_193 : _GEN_176; // @[Utils.scala 43:26]
  wire [7:0] _GEN_210 = _T_108 ? _GEN_194 : _GEN_177; // @[Utils.scala 43:26]
  wire [7:0] _GEN_211 = _T_108 ? _GEN_195 : _GEN_178; // @[Utils.scala 43:26]
  wire [2:0] _GEN_212 = _T_108 ? _T_142 : _GEN_179; // @[Utils.scala 43:26 Utils.scala 45:19 Utils.scala 47:19]
  wire [5:0] _GEN_213 = 3'h0 == _GEN_212 ? _T_94[5:0] : _GEN_196; // @[Utils.scala 44:27 Utils.scala 44:27]
  wire [5:0] _GEN_214 = 3'h1 == _GEN_212 ? _T_94[5:0] : _GEN_197; // @[Utils.scala 44:27 Utils.scala 44:27]
  wire [5:0] _GEN_215 = 3'h2 == _GEN_212 ? _T_94[5:0] : _GEN_198; // @[Utils.scala 44:27 Utils.scala 44:27]
  wire [5:0] _GEN_216 = 3'h3 == _GEN_212 ? _T_94[5:0] : _GEN_199; // @[Utils.scala 44:27 Utils.scala 44:27]
  wire [5:0] _GEN_217 = 3'h4 == _GEN_212 ? _T_94[5:0] : _GEN_200; // @[Utils.scala 44:27 Utils.scala 44:27]
  wire [5:0] _GEN_218 = 3'h5 == _GEN_212 ? _T_94[5:0] : _GEN_201; // @[Utils.scala 44:27 Utils.scala 44:27]
  wire [5:0] _GEN_219 = 3'h6 == _GEN_212 ? _T_94[5:0] : _GEN_202; // @[Utils.scala 44:27 Utils.scala 44:27]
  wire [5:0] _GEN_220 = 3'h7 == _GEN_212 ? _T_94[5:0] : _GEN_203; // @[Utils.scala 44:27 Utils.scala 44:27]
  wire [7:0] _GEN_221 = 3'h0 == _GEN_212 ? _GEN_37 : _GEN_204; // @[Utils.scala 44:27 Utils.scala 44:27]
  wire [7:0] _GEN_222 = 3'h1 == _GEN_212 ? _GEN_37 : _GEN_205; // @[Utils.scala 44:27 Utils.scala 44:27]
  wire [7:0] _GEN_223 = 3'h2 == _GEN_212 ? _GEN_37 : _GEN_206; // @[Utils.scala 44:27 Utils.scala 44:27]
  wire [7:0] _GEN_224 = 3'h3 == _GEN_212 ? _GEN_37 : _GEN_207; // @[Utils.scala 44:27 Utils.scala 44:27]
  wire [7:0] _GEN_225 = 3'h4 == _GEN_212 ? _GEN_37 : _GEN_208; // @[Utils.scala 44:27 Utils.scala 44:27]
  wire [7:0] _GEN_226 = 3'h5 == _GEN_212 ? _GEN_37 : _GEN_209; // @[Utils.scala 44:27 Utils.scala 44:27]
  wire [7:0] _GEN_227 = 3'h6 == _GEN_212 ? _GEN_37 : _GEN_210; // @[Utils.scala 44:27 Utils.scala 44:27]
  wire [7:0] _GEN_228 = 3'h7 == _GEN_212 ? _GEN_37 : _GEN_211; // @[Utils.scala 44:27 Utils.scala 44:27]
  wire [2:0] _T_144 = _GEN_212 + 3'h1; // @[Utils.scala 45:32]
  wire [5:0] _GEN_229 = _T_109 ? _GEN_213 : _GEN_196; // @[Utils.scala 43:26]
  wire [5:0] _GEN_230 = _T_109 ? _GEN_214 : _GEN_197; // @[Utils.scala 43:26]
  wire [5:0] _GEN_231 = _T_109 ? _GEN_215 : _GEN_198; // @[Utils.scala 43:26]
  wire [5:0] _GEN_232 = _T_109 ? _GEN_216 : _GEN_199; // @[Utils.scala 43:26]
  wire [5:0] _GEN_233 = _T_109 ? _GEN_217 : _GEN_200; // @[Utils.scala 43:26]
  wire [5:0] _GEN_234 = _T_109 ? _GEN_218 : _GEN_201; // @[Utils.scala 43:26]
  wire [5:0] _GEN_235 = _T_109 ? _GEN_219 : _GEN_202; // @[Utils.scala 43:26]
  wire [5:0] _GEN_236 = _T_109 ? _GEN_220 : _GEN_203; // @[Utils.scala 43:26]
  wire [7:0] _GEN_237 = _T_109 ? _GEN_221 : _GEN_204; // @[Utils.scala 43:26]
  wire [7:0] _GEN_238 = _T_109 ? _GEN_222 : _GEN_205; // @[Utils.scala 43:26]
  wire [7:0] _GEN_239 = _T_109 ? _GEN_223 : _GEN_206; // @[Utils.scala 43:26]
  wire [7:0] _GEN_240 = _T_109 ? _GEN_224 : _GEN_207; // @[Utils.scala 43:26]
  wire [7:0] _GEN_241 = _T_109 ? _GEN_225 : _GEN_208; // @[Utils.scala 43:26]
  wire [7:0] _GEN_242 = _T_109 ? _GEN_226 : _GEN_209; // @[Utils.scala 43:26]
  wire [7:0] _GEN_243 = _T_109 ? _GEN_227 : _GEN_210; // @[Utils.scala 43:26]
  wire [7:0] _GEN_244 = _T_109 ? _GEN_228 : _GEN_211; // @[Utils.scala 43:26]
  wire [2:0] _GEN_245 = _T_109 ? _T_144 : _GEN_212; // @[Utils.scala 43:26 Utils.scala 45:19 Utils.scala 47:19]
  wire [5:0] _GEN_246 = 3'h0 == _GEN_245 ? _T_102[5:0] : _GEN_229; // @[Utils.scala 44:27 Utils.scala 44:27]
  wire [5:0] _GEN_247 = 3'h1 == _GEN_245 ? _T_102[5:0] : _GEN_230; // @[Utils.scala 44:27 Utils.scala 44:27]
  wire [5:0] _GEN_248 = 3'h2 == _GEN_245 ? _T_102[5:0] : _GEN_231; // @[Utils.scala 44:27 Utils.scala 44:27]
  wire [5:0] _GEN_249 = 3'h3 == _GEN_245 ? _T_102[5:0] : _GEN_232; // @[Utils.scala 44:27 Utils.scala 44:27]
  wire [5:0] _GEN_250 = 3'h4 == _GEN_245 ? _T_102[5:0] : _GEN_233; // @[Utils.scala 44:27 Utils.scala 44:27]
  wire [5:0] _GEN_251 = 3'h5 == _GEN_245 ? _T_102[5:0] : _GEN_234; // @[Utils.scala 44:27 Utils.scala 44:27]
  wire [5:0] _GEN_252 = 3'h6 == _GEN_245 ? _T_102[5:0] : _GEN_235; // @[Utils.scala 44:27 Utils.scala 44:27]
  wire [5:0] _GEN_253 = 3'h7 == _GEN_245 ? _T_102[5:0] : _GEN_236; // @[Utils.scala 44:27 Utils.scala 44:27]
  wire [7:0] _GEN_254 = 3'h0 == _GEN_245 ? _GEN_38 : _GEN_237; // @[Utils.scala 44:27 Utils.scala 44:27]
  wire [7:0] _GEN_255 = 3'h1 == _GEN_245 ? _GEN_38 : _GEN_238; // @[Utils.scala 44:27 Utils.scala 44:27]
  wire [7:0] _GEN_256 = 3'h2 == _GEN_245 ? _GEN_38 : _GEN_239; // @[Utils.scala 44:27 Utils.scala 44:27]
  wire [7:0] _GEN_257 = 3'h3 == _GEN_245 ? _GEN_38 : _GEN_240; // @[Utils.scala 44:27 Utils.scala 44:27]
  wire [7:0] _GEN_258 = 3'h4 == _GEN_245 ? _GEN_38 : _GEN_241; // @[Utils.scala 44:27 Utils.scala 44:27]
  wire [7:0] _GEN_259 = 3'h5 == _GEN_245 ? _GEN_38 : _GEN_242; // @[Utils.scala 44:27 Utils.scala 44:27]
  wire [7:0] _GEN_260 = 3'h6 == _GEN_245 ? _GEN_38 : _GEN_243; // @[Utils.scala 44:27 Utils.scala 44:27]
  wire [7:0] _GEN_261 = 3'h7 == _GEN_245 ? _GEN_38 : _GEN_244; // @[Utils.scala 44:27 Utils.scala 44:27]
  wire [5:0] _GEN_262 = _T_110 ? _GEN_246 : _GEN_229; // @[Utils.scala 43:26]
  wire [5:0] _GEN_263 = _T_110 ? _GEN_247 : _GEN_230; // @[Utils.scala 43:26]
  wire [5:0] _GEN_264 = _T_110 ? _GEN_248 : _GEN_231; // @[Utils.scala 43:26]
  wire [5:0] _GEN_265 = _T_110 ? _GEN_249 : _GEN_232; // @[Utils.scala 43:26]
  wire [5:0] _GEN_266 = _T_110 ? _GEN_250 : _GEN_233; // @[Utils.scala 43:26]
  wire [5:0] _GEN_267 = _T_110 ? _GEN_251 : _GEN_234; // @[Utils.scala 43:26]
  wire [5:0] _GEN_268 = _T_110 ? _GEN_252 : _GEN_235; // @[Utils.scala 43:26]
  wire [5:0] _GEN_269 = _T_110 ? _GEN_253 : _GEN_236; // @[Utils.scala 43:26]
  wire [7:0] _GEN_270 = _T_110 ? _GEN_254 : _GEN_237; // @[Utils.scala 43:26]
  wire [7:0] _GEN_271 = _T_110 ? _GEN_255 : _GEN_238; // @[Utils.scala 43:26]
  wire [7:0] _GEN_272 = _T_110 ? _GEN_256 : _GEN_239; // @[Utils.scala 43:26]
  wire [7:0] _GEN_273 = _T_110 ? _GEN_257 : _GEN_240; // @[Utils.scala 43:26]
  wire [7:0] _GEN_274 = _T_110 ? _GEN_258 : _GEN_241; // @[Utils.scala 43:26]
  wire [7:0] _GEN_275 = _T_110 ? _GEN_259 : _GEN_242; // @[Utils.scala 43:26]
  wire [7:0] _GEN_276 = _T_110 ? _GEN_260 : _GEN_243; // @[Utils.scala 43:26]
  wire [7:0] _GEN_277 = _T_110 ? _GEN_261 : _GEN_244; // @[Utils.scala 43:26]
  wire [3:0] _T_147 = {1'h0,regElCnt}; // @[Cat.scala 30:58]
  wire [3:0] _T_149 = _T_147 + _T_123; // @[DRAM2BRAM.scala 198:51]
  wire  _T_150 = _T_123 > 4'h0; // @[DRAM2BRAM.scala 204:26]
  wire  _T_151 = _T_149 > 4'h8; // @[DRAM2BRAM.scala 209:33]
  wire [5:0] _GEN_279 = _T_149 > 4'h8 ? 6'h2 : 6'h1; // @[DRAM2BRAM.scala 209:45 DRAM2BRAM.scala 210:51 DRAM2BRAM.scala 212:51]
  wire [6:0] _GEN_280 = _T_149 > 4'h8 ? regBramRowCnt[6:0] : regBramRowCnt[6:0]; // @[DRAM2BRAM.scala 209:45 DRAM2BRAM.scala 210:51 DRAM2BRAM.scala 212:51]
  wire  _T_153 = _T_149 >= 4'h8; // @[DRAM2BRAM.scala 220:31]
  wire [1:0] _GEN_286 = _T_149 >= 4'h8 ? 2'h2 : 2'h1; // @[DRAM2BRAM.scala 220:44 DRAM2BRAM.scala 221:38 DRAM2BRAM.scala 223:38]
  wire  _GEN_1199 = _T_12 & _GEN_43; // @[DRAM2BRAM.scala 182:30]
  wire  _GEN_1247 = _T_11 & _GEN_1199; // @[Conditional.scala 39:67]
  wire  rowFinished = _T ? 1'h0 : _GEN_1247; // @[Conditional.scala 40:58]
  wire  _GEN_287 = rowFinished & _T_150; // @[DRAM2BRAM.scala 203:30 DRAM2BRAM.scala 60:31]
  wire [8:0] _GEN_292 = rowFinished ? {{2'd0}, regAgentRowInfo_rowAddr} : regBramRowCnt; // @[DRAM2BRAM.scala 203:30 DRAM2BRAM.scala 136:32 DRAM2BRAM.scala 217:37]
  wire [6:0] _GEN_293 = rowFinished ? {{1'd0}, regAgentRowInfoAgentIdx} : regAgentRowCnt; // @[DRAM2BRAM.scala 203:30 DRAM2BRAM.scala 137:40 DRAM2BRAM.scala 218:37]
  wire  _GEN_294 = rowFinished ? regAgentHasValid : _T_150; // @[DRAM2BRAM.scala 203:30 DRAM2BRAM.scala 138:33 DRAM2BRAM.scala 219:30]
  wire [5:0] _GEN_295 = rowFinished ? regAgentRowInfo_length : {{4'd0}, _GEN_286}; // @[DRAM2BRAM.scala 203:30 DRAM2BRAM.scala 136:32]
  wire [5:0] _T_156 = regAgentRowInfo_length + 6'h1; // @[DRAM2BRAM.scala 232:116]
  wire [5:0] _GEN_296 = _T_151 ? _T_156 : regAgentRowInfo_length; // @[DRAM2BRAM.scala 231:43 DRAM2BRAM.scala 232:49 DRAM2BRAM.scala 234:49]
  wire  _GEN_298 = regAgentHasValid | _T_150; // @[DRAM2BRAM.scala 228:35 DRAM2BRAM.scala 229:41 DRAM2BRAM.scala 238:42]
  wire [5:0] _GEN_300 = regAgentHasValid ? _GEN_296 : 6'h1; // @[DRAM2BRAM.scala 228:35 DRAM2BRAM.scala 239:47]
  wire  _GEN_302 = ~regAgentHasValid ? _T_150 : regAgentHasValid; // @[DRAM2BRAM.scala 243:36 DRAM2BRAM.scala 244:30 DRAM2BRAM.scala 138:33]
  wire  _GEN_303 = rowFinished & _GEN_298; // @[DRAM2BRAM.scala 226:33 DRAM2BRAM.scala 60:31]
  wire  _GEN_307 = rowFinished ? regAgentHasValid : _GEN_302; // @[DRAM2BRAM.scala 226:33 DRAM2BRAM.scala 138:33]
  wire  _GEN_1195 = _T_12 ? _T_29 : 1'h1; // @[DRAM2BRAM.scala 182:30]
  wire  _GEN_1243 = _T_11 ? _GEN_1195 : 1'h1; // @[Conditional.scala 39:67]
  wire  newRowStarted = _T | _GEN_1243; // @[Conditional.scala 40:58]
  wire  _GEN_308 = newRowStarted ? _GEN_287 : _GEN_303; // @[DRAM2BRAM.scala 201:29]
  wire [6:0] _GEN_310 = newRowStarted ? regAgentRowCnt : {{1'd0}, regAgentRowInfoAgentIdx}; // @[DRAM2BRAM.scala 201:29]
  wire [5:0] _GEN_311 = newRowStarted ? _GEN_279 : _GEN_300; // @[DRAM2BRAM.scala 201:29]
  wire [6:0] _GEN_312 = newRowStarted ? _GEN_280 : regAgentRowInfo_rowAddr; // @[DRAM2BRAM.scala 201:29]
  wire [8:0] _GEN_313 = newRowStarted ? _GEN_292 : {{2'd0}, regAgentRowInfo_rowAddr}; // @[DRAM2BRAM.scala 201:29 DRAM2BRAM.scala 136:32]
  wire [6:0] _GEN_314 = newRowStarted ? _GEN_293 : {{1'd0}, regAgentRowInfoAgentIdx}; // @[DRAM2BRAM.scala 201:29 DRAM2BRAM.scala 137:40]
  wire  _GEN_315 = newRowStarted ? _GEN_294 : _GEN_307; // @[DRAM2BRAM.scala 201:29]
  wire [5:0] _GEN_316 = newRowStarted ? _GEN_295 : regAgentRowInfo_length; // @[DRAM2BRAM.scala 201:29 DRAM2BRAM.scala 136:32]
  wire [3:0] _GEN_1345 = {{1'd0}, regElCnt}; // @[DRAM2BRAM.scala 252:36]
  wire [3:0] _T_162 = 4'h8 - _GEN_1345; // @[DRAM2BRAM.scala 252:36]
  wire  _T_163 = 3'h0 < regElCnt; // @[DRAM2BRAM.scala 254:22]
  wire [2:0] _T_165 = 3'h0 - regElCnt; // @[DRAM2BRAM.scala 257:31]
  wire [7:0] _GEN_319 = 3'h1 == _T_165 ? _GEN_271 : _GEN_270; // @[DRAM2BRAM.scala 257:18 DRAM2BRAM.scala 257:18]
  wire [5:0] _GEN_320 = 3'h1 == _T_165 ? _GEN_263 : _GEN_262; // @[DRAM2BRAM.scala 257:18 DRAM2BRAM.scala 257:18]
  wire [7:0] _GEN_321 = 3'h2 == _T_165 ? _GEN_272 : _GEN_319; // @[DRAM2BRAM.scala 257:18 DRAM2BRAM.scala 257:18]
  wire [5:0] _GEN_322 = 3'h2 == _T_165 ? _GEN_264 : _GEN_320; // @[DRAM2BRAM.scala 257:18 DRAM2BRAM.scala 257:18]
  wire [7:0] _GEN_323 = 3'h3 == _T_165 ? _GEN_273 : _GEN_321; // @[DRAM2BRAM.scala 257:18 DRAM2BRAM.scala 257:18]
  wire [5:0] _GEN_324 = 3'h3 == _T_165 ? _GEN_265 : _GEN_322; // @[DRAM2BRAM.scala 257:18 DRAM2BRAM.scala 257:18]
  wire [7:0] _GEN_325 = 3'h4 == _T_165 ? _GEN_274 : _GEN_323; // @[DRAM2BRAM.scala 257:18 DRAM2BRAM.scala 257:18]
  wire [5:0] _GEN_326 = 3'h4 == _T_165 ? _GEN_266 : _GEN_324; // @[DRAM2BRAM.scala 257:18 DRAM2BRAM.scala 257:18]
  wire [7:0] _GEN_327 = 3'h5 == _T_165 ? _GEN_275 : _GEN_325; // @[DRAM2BRAM.scala 257:18 DRAM2BRAM.scala 257:18]
  wire [5:0] _GEN_328 = 3'h5 == _T_165 ? _GEN_267 : _GEN_326; // @[DRAM2BRAM.scala 257:18 DRAM2BRAM.scala 257:18]
  wire [7:0] _GEN_329 = 3'h6 == _T_165 ? _GEN_276 : _GEN_327; // @[DRAM2BRAM.scala 257:18 DRAM2BRAM.scala 257:18]
  wire [5:0] _GEN_330 = 3'h6 == _T_165 ? _GEN_268 : _GEN_328; // @[DRAM2BRAM.scala 257:18 DRAM2BRAM.scala 257:18]
  wire [7:0] _GEN_331 = 3'h7 == _T_165 ? _GEN_277 : _GEN_329; // @[DRAM2BRAM.scala 257:18 DRAM2BRAM.scala 257:18]
  wire [5:0] _GEN_332 = 3'h7 == _T_165 ? _GEN_269 : _GEN_330; // @[DRAM2BRAM.scala 257:18 DRAM2BRAM.scala 257:18]
  wire [5:0] _GEN_333 = 3'h0 < regElCnt ? regBramLine_els_0_col : _GEN_332; // @[DRAM2BRAM.scala 254:34 DRAM2BRAM.scala 255:18 DRAM2BRAM.scala 257:18]
  wire [7:0] _GEN_334 = 3'h0 < regElCnt ? regBramLine_els_0_value : _GEN_331; // @[DRAM2BRAM.scala 254:34 DRAM2BRAM.scala 255:18 DRAM2BRAM.scala 257:18]
  wire  _T_166 = 3'h1 < regElCnt; // @[DRAM2BRAM.scala 254:22]
  wire [2:0] _T_168 = 3'h1 - regElCnt; // @[DRAM2BRAM.scala 257:31]
  wire [7:0] _GEN_337 = 3'h1 == _T_168 ? _GEN_271 : _GEN_270; // @[DRAM2BRAM.scala 257:18 DRAM2BRAM.scala 257:18]
  wire [5:0] _GEN_338 = 3'h1 == _T_168 ? _GEN_263 : _GEN_262; // @[DRAM2BRAM.scala 257:18 DRAM2BRAM.scala 257:18]
  wire [7:0] _GEN_339 = 3'h2 == _T_168 ? _GEN_272 : _GEN_337; // @[DRAM2BRAM.scala 257:18 DRAM2BRAM.scala 257:18]
  wire [5:0] _GEN_340 = 3'h2 == _T_168 ? _GEN_264 : _GEN_338; // @[DRAM2BRAM.scala 257:18 DRAM2BRAM.scala 257:18]
  wire [7:0] _GEN_341 = 3'h3 == _T_168 ? _GEN_273 : _GEN_339; // @[DRAM2BRAM.scala 257:18 DRAM2BRAM.scala 257:18]
  wire [5:0] _GEN_342 = 3'h3 == _T_168 ? _GEN_265 : _GEN_340; // @[DRAM2BRAM.scala 257:18 DRAM2BRAM.scala 257:18]
  wire [7:0] _GEN_343 = 3'h4 == _T_168 ? _GEN_274 : _GEN_341; // @[DRAM2BRAM.scala 257:18 DRAM2BRAM.scala 257:18]
  wire [5:0] _GEN_344 = 3'h4 == _T_168 ? _GEN_266 : _GEN_342; // @[DRAM2BRAM.scala 257:18 DRAM2BRAM.scala 257:18]
  wire [7:0] _GEN_345 = 3'h5 == _T_168 ? _GEN_275 : _GEN_343; // @[DRAM2BRAM.scala 257:18 DRAM2BRAM.scala 257:18]
  wire [5:0] _GEN_346 = 3'h5 == _T_168 ? _GEN_267 : _GEN_344; // @[DRAM2BRAM.scala 257:18 DRAM2BRAM.scala 257:18]
  wire [7:0] _GEN_347 = 3'h6 == _T_168 ? _GEN_276 : _GEN_345; // @[DRAM2BRAM.scala 257:18 DRAM2BRAM.scala 257:18]
  wire [5:0] _GEN_348 = 3'h6 == _T_168 ? _GEN_268 : _GEN_346; // @[DRAM2BRAM.scala 257:18 DRAM2BRAM.scala 257:18]
  wire [7:0] _GEN_349 = 3'h7 == _T_168 ? _GEN_277 : _GEN_347; // @[DRAM2BRAM.scala 257:18 DRAM2BRAM.scala 257:18]
  wire [5:0] _GEN_350 = 3'h7 == _T_168 ? _GEN_269 : _GEN_348; // @[DRAM2BRAM.scala 257:18 DRAM2BRAM.scala 257:18]
  wire [5:0] _GEN_351 = 3'h1 < regElCnt ? regBramLine_els_1_col : _GEN_350; // @[DRAM2BRAM.scala 254:34 DRAM2BRAM.scala 255:18 DRAM2BRAM.scala 257:18]
  wire [7:0] _GEN_352 = 3'h1 < regElCnt ? regBramLine_els_1_value : _GEN_349; // @[DRAM2BRAM.scala 254:34 DRAM2BRAM.scala 255:18 DRAM2BRAM.scala 257:18]
  wire  _T_169 = 3'h2 < regElCnt; // @[DRAM2BRAM.scala 254:22]
  wire [2:0] _T_171 = 3'h2 - regElCnt; // @[DRAM2BRAM.scala 257:31]
  wire [7:0] _GEN_355 = 3'h1 == _T_171 ? _GEN_271 : _GEN_270; // @[DRAM2BRAM.scala 257:18 DRAM2BRAM.scala 257:18]
  wire [5:0] _GEN_356 = 3'h1 == _T_171 ? _GEN_263 : _GEN_262; // @[DRAM2BRAM.scala 257:18 DRAM2BRAM.scala 257:18]
  wire [7:0] _GEN_357 = 3'h2 == _T_171 ? _GEN_272 : _GEN_355; // @[DRAM2BRAM.scala 257:18 DRAM2BRAM.scala 257:18]
  wire [5:0] _GEN_358 = 3'h2 == _T_171 ? _GEN_264 : _GEN_356; // @[DRAM2BRAM.scala 257:18 DRAM2BRAM.scala 257:18]
  wire [7:0] _GEN_359 = 3'h3 == _T_171 ? _GEN_273 : _GEN_357; // @[DRAM2BRAM.scala 257:18 DRAM2BRAM.scala 257:18]
  wire [5:0] _GEN_360 = 3'h3 == _T_171 ? _GEN_265 : _GEN_358; // @[DRAM2BRAM.scala 257:18 DRAM2BRAM.scala 257:18]
  wire [7:0] _GEN_361 = 3'h4 == _T_171 ? _GEN_274 : _GEN_359; // @[DRAM2BRAM.scala 257:18 DRAM2BRAM.scala 257:18]
  wire [5:0] _GEN_362 = 3'h4 == _T_171 ? _GEN_266 : _GEN_360; // @[DRAM2BRAM.scala 257:18 DRAM2BRAM.scala 257:18]
  wire [7:0] _GEN_363 = 3'h5 == _T_171 ? _GEN_275 : _GEN_361; // @[DRAM2BRAM.scala 257:18 DRAM2BRAM.scala 257:18]
  wire [5:0] _GEN_364 = 3'h5 == _T_171 ? _GEN_267 : _GEN_362; // @[DRAM2BRAM.scala 257:18 DRAM2BRAM.scala 257:18]
  wire [7:0] _GEN_365 = 3'h6 == _T_171 ? _GEN_276 : _GEN_363; // @[DRAM2BRAM.scala 257:18 DRAM2BRAM.scala 257:18]
  wire [5:0] _GEN_366 = 3'h6 == _T_171 ? _GEN_268 : _GEN_364; // @[DRAM2BRAM.scala 257:18 DRAM2BRAM.scala 257:18]
  wire [7:0] _GEN_367 = 3'h7 == _T_171 ? _GEN_277 : _GEN_365; // @[DRAM2BRAM.scala 257:18 DRAM2BRAM.scala 257:18]
  wire [5:0] _GEN_368 = 3'h7 == _T_171 ? _GEN_269 : _GEN_366; // @[DRAM2BRAM.scala 257:18 DRAM2BRAM.scala 257:18]
  wire [5:0] _GEN_369 = 3'h2 < regElCnt ? regBramLine_els_2_col : _GEN_368; // @[DRAM2BRAM.scala 254:34 DRAM2BRAM.scala 255:18 DRAM2BRAM.scala 257:18]
  wire [7:0] _GEN_370 = 3'h2 < regElCnt ? regBramLine_els_2_value : _GEN_367; // @[DRAM2BRAM.scala 254:34 DRAM2BRAM.scala 255:18 DRAM2BRAM.scala 257:18]
  wire  _T_172 = 3'h3 < regElCnt; // @[DRAM2BRAM.scala 254:22]
  wire [2:0] _T_174 = 3'h3 - regElCnt; // @[DRAM2BRAM.scala 257:31]
  wire [7:0] _GEN_373 = 3'h1 == _T_174 ? _GEN_271 : _GEN_270; // @[DRAM2BRAM.scala 257:18 DRAM2BRAM.scala 257:18]
  wire [5:0] _GEN_374 = 3'h1 == _T_174 ? _GEN_263 : _GEN_262; // @[DRAM2BRAM.scala 257:18 DRAM2BRAM.scala 257:18]
  wire [7:0] _GEN_375 = 3'h2 == _T_174 ? _GEN_272 : _GEN_373; // @[DRAM2BRAM.scala 257:18 DRAM2BRAM.scala 257:18]
  wire [5:0] _GEN_376 = 3'h2 == _T_174 ? _GEN_264 : _GEN_374; // @[DRAM2BRAM.scala 257:18 DRAM2BRAM.scala 257:18]
  wire [7:0] _GEN_377 = 3'h3 == _T_174 ? _GEN_273 : _GEN_375; // @[DRAM2BRAM.scala 257:18 DRAM2BRAM.scala 257:18]
  wire [5:0] _GEN_378 = 3'h3 == _T_174 ? _GEN_265 : _GEN_376; // @[DRAM2BRAM.scala 257:18 DRAM2BRAM.scala 257:18]
  wire [7:0] _GEN_379 = 3'h4 == _T_174 ? _GEN_274 : _GEN_377; // @[DRAM2BRAM.scala 257:18 DRAM2BRAM.scala 257:18]
  wire [5:0] _GEN_380 = 3'h4 == _T_174 ? _GEN_266 : _GEN_378; // @[DRAM2BRAM.scala 257:18 DRAM2BRAM.scala 257:18]
  wire [7:0] _GEN_381 = 3'h5 == _T_174 ? _GEN_275 : _GEN_379; // @[DRAM2BRAM.scala 257:18 DRAM2BRAM.scala 257:18]
  wire [5:0] _GEN_382 = 3'h5 == _T_174 ? _GEN_267 : _GEN_380; // @[DRAM2BRAM.scala 257:18 DRAM2BRAM.scala 257:18]
  wire [7:0] _GEN_383 = 3'h6 == _T_174 ? _GEN_276 : _GEN_381; // @[DRAM2BRAM.scala 257:18 DRAM2BRAM.scala 257:18]
  wire [5:0] _GEN_384 = 3'h6 == _T_174 ? _GEN_268 : _GEN_382; // @[DRAM2BRAM.scala 257:18 DRAM2BRAM.scala 257:18]
  wire [7:0] _GEN_385 = 3'h7 == _T_174 ? _GEN_277 : _GEN_383; // @[DRAM2BRAM.scala 257:18 DRAM2BRAM.scala 257:18]
  wire [5:0] _GEN_386 = 3'h7 == _T_174 ? _GEN_269 : _GEN_384; // @[DRAM2BRAM.scala 257:18 DRAM2BRAM.scala 257:18]
  wire [5:0] _GEN_387 = 3'h3 < regElCnt ? regBramLine_els_3_col : _GEN_386; // @[DRAM2BRAM.scala 254:34 DRAM2BRAM.scala 255:18 DRAM2BRAM.scala 257:18]
  wire [7:0] _GEN_388 = 3'h3 < regElCnt ? regBramLine_els_3_value : _GEN_385; // @[DRAM2BRAM.scala 254:34 DRAM2BRAM.scala 255:18 DRAM2BRAM.scala 257:18]
  wire  _T_175 = 3'h4 < regElCnt; // @[DRAM2BRAM.scala 254:22]
  wire [2:0] _T_177 = 3'h4 - regElCnt; // @[DRAM2BRAM.scala 257:31]
  wire [7:0] _GEN_391 = 3'h1 == _T_177 ? _GEN_271 : _GEN_270; // @[DRAM2BRAM.scala 257:18 DRAM2BRAM.scala 257:18]
  wire [5:0] _GEN_392 = 3'h1 == _T_177 ? _GEN_263 : _GEN_262; // @[DRAM2BRAM.scala 257:18 DRAM2BRAM.scala 257:18]
  wire [7:0] _GEN_393 = 3'h2 == _T_177 ? _GEN_272 : _GEN_391; // @[DRAM2BRAM.scala 257:18 DRAM2BRAM.scala 257:18]
  wire [5:0] _GEN_394 = 3'h2 == _T_177 ? _GEN_264 : _GEN_392; // @[DRAM2BRAM.scala 257:18 DRAM2BRAM.scala 257:18]
  wire [7:0] _GEN_395 = 3'h3 == _T_177 ? _GEN_273 : _GEN_393; // @[DRAM2BRAM.scala 257:18 DRAM2BRAM.scala 257:18]
  wire [5:0] _GEN_396 = 3'h3 == _T_177 ? _GEN_265 : _GEN_394; // @[DRAM2BRAM.scala 257:18 DRAM2BRAM.scala 257:18]
  wire [7:0] _GEN_397 = 3'h4 == _T_177 ? _GEN_274 : _GEN_395; // @[DRAM2BRAM.scala 257:18 DRAM2BRAM.scala 257:18]
  wire [5:0] _GEN_398 = 3'h4 == _T_177 ? _GEN_266 : _GEN_396; // @[DRAM2BRAM.scala 257:18 DRAM2BRAM.scala 257:18]
  wire [7:0] _GEN_399 = 3'h5 == _T_177 ? _GEN_275 : _GEN_397; // @[DRAM2BRAM.scala 257:18 DRAM2BRAM.scala 257:18]
  wire [5:0] _GEN_400 = 3'h5 == _T_177 ? _GEN_267 : _GEN_398; // @[DRAM2BRAM.scala 257:18 DRAM2BRAM.scala 257:18]
  wire [7:0] _GEN_401 = 3'h6 == _T_177 ? _GEN_276 : _GEN_399; // @[DRAM2BRAM.scala 257:18 DRAM2BRAM.scala 257:18]
  wire [5:0] _GEN_402 = 3'h6 == _T_177 ? _GEN_268 : _GEN_400; // @[DRAM2BRAM.scala 257:18 DRAM2BRAM.scala 257:18]
  wire [7:0] _GEN_403 = 3'h7 == _T_177 ? _GEN_277 : _GEN_401; // @[DRAM2BRAM.scala 257:18 DRAM2BRAM.scala 257:18]
  wire [5:0] _GEN_404 = 3'h7 == _T_177 ? _GEN_269 : _GEN_402; // @[DRAM2BRAM.scala 257:18 DRAM2BRAM.scala 257:18]
  wire [5:0] _GEN_405 = 3'h4 < regElCnt ? regBramLine_els_4_col : _GEN_404; // @[DRAM2BRAM.scala 254:34 DRAM2BRAM.scala 255:18 DRAM2BRAM.scala 257:18]
  wire [7:0] _GEN_406 = 3'h4 < regElCnt ? regBramLine_els_4_value : _GEN_403; // @[DRAM2BRAM.scala 254:34 DRAM2BRAM.scala 255:18 DRAM2BRAM.scala 257:18]
  wire  _T_178 = 3'h5 < regElCnt; // @[DRAM2BRAM.scala 254:22]
  wire [2:0] _T_180 = 3'h5 - regElCnt; // @[DRAM2BRAM.scala 257:31]
  wire [7:0] _GEN_409 = 3'h1 == _T_180 ? _GEN_271 : _GEN_270; // @[DRAM2BRAM.scala 257:18 DRAM2BRAM.scala 257:18]
  wire [5:0] _GEN_410 = 3'h1 == _T_180 ? _GEN_263 : _GEN_262; // @[DRAM2BRAM.scala 257:18 DRAM2BRAM.scala 257:18]
  wire [7:0] _GEN_411 = 3'h2 == _T_180 ? _GEN_272 : _GEN_409; // @[DRAM2BRAM.scala 257:18 DRAM2BRAM.scala 257:18]
  wire [5:0] _GEN_412 = 3'h2 == _T_180 ? _GEN_264 : _GEN_410; // @[DRAM2BRAM.scala 257:18 DRAM2BRAM.scala 257:18]
  wire [7:0] _GEN_413 = 3'h3 == _T_180 ? _GEN_273 : _GEN_411; // @[DRAM2BRAM.scala 257:18 DRAM2BRAM.scala 257:18]
  wire [5:0] _GEN_414 = 3'h3 == _T_180 ? _GEN_265 : _GEN_412; // @[DRAM2BRAM.scala 257:18 DRAM2BRAM.scala 257:18]
  wire [7:0] _GEN_415 = 3'h4 == _T_180 ? _GEN_274 : _GEN_413; // @[DRAM2BRAM.scala 257:18 DRAM2BRAM.scala 257:18]
  wire [5:0] _GEN_416 = 3'h4 == _T_180 ? _GEN_266 : _GEN_414; // @[DRAM2BRAM.scala 257:18 DRAM2BRAM.scala 257:18]
  wire [7:0] _GEN_417 = 3'h5 == _T_180 ? _GEN_275 : _GEN_415; // @[DRAM2BRAM.scala 257:18 DRAM2BRAM.scala 257:18]
  wire [5:0] _GEN_418 = 3'h5 == _T_180 ? _GEN_267 : _GEN_416; // @[DRAM2BRAM.scala 257:18 DRAM2BRAM.scala 257:18]
  wire [7:0] _GEN_419 = 3'h6 == _T_180 ? _GEN_276 : _GEN_417; // @[DRAM2BRAM.scala 257:18 DRAM2BRAM.scala 257:18]
  wire [5:0] _GEN_420 = 3'h6 == _T_180 ? _GEN_268 : _GEN_418; // @[DRAM2BRAM.scala 257:18 DRAM2BRAM.scala 257:18]
  wire [7:0] _GEN_421 = 3'h7 == _T_180 ? _GEN_277 : _GEN_419; // @[DRAM2BRAM.scala 257:18 DRAM2BRAM.scala 257:18]
  wire [5:0] _GEN_422 = 3'h7 == _T_180 ? _GEN_269 : _GEN_420; // @[DRAM2BRAM.scala 257:18 DRAM2BRAM.scala 257:18]
  wire [5:0] _GEN_423 = 3'h5 < regElCnt ? regBramLine_els_5_col : _GEN_422; // @[DRAM2BRAM.scala 254:34 DRAM2BRAM.scala 255:18 DRAM2BRAM.scala 257:18]
  wire [7:0] _GEN_424 = 3'h5 < regElCnt ? regBramLine_els_5_value : _GEN_421; // @[DRAM2BRAM.scala 254:34 DRAM2BRAM.scala 255:18 DRAM2BRAM.scala 257:18]
  wire  _T_181 = 3'h6 < regElCnt; // @[DRAM2BRAM.scala 254:22]
  wire [2:0] _T_183 = 3'h6 - regElCnt; // @[DRAM2BRAM.scala 257:31]
  wire [7:0] _GEN_427 = 3'h1 == _T_183 ? _GEN_271 : _GEN_270; // @[DRAM2BRAM.scala 257:18 DRAM2BRAM.scala 257:18]
  wire [5:0] _GEN_428 = 3'h1 == _T_183 ? _GEN_263 : _GEN_262; // @[DRAM2BRAM.scala 257:18 DRAM2BRAM.scala 257:18]
  wire [7:0] _GEN_429 = 3'h2 == _T_183 ? _GEN_272 : _GEN_427; // @[DRAM2BRAM.scala 257:18 DRAM2BRAM.scala 257:18]
  wire [5:0] _GEN_430 = 3'h2 == _T_183 ? _GEN_264 : _GEN_428; // @[DRAM2BRAM.scala 257:18 DRAM2BRAM.scala 257:18]
  wire [7:0] _GEN_431 = 3'h3 == _T_183 ? _GEN_273 : _GEN_429; // @[DRAM2BRAM.scala 257:18 DRAM2BRAM.scala 257:18]
  wire [5:0] _GEN_432 = 3'h3 == _T_183 ? _GEN_265 : _GEN_430; // @[DRAM2BRAM.scala 257:18 DRAM2BRAM.scala 257:18]
  wire [7:0] _GEN_433 = 3'h4 == _T_183 ? _GEN_274 : _GEN_431; // @[DRAM2BRAM.scala 257:18 DRAM2BRAM.scala 257:18]
  wire [5:0] _GEN_434 = 3'h4 == _T_183 ? _GEN_266 : _GEN_432; // @[DRAM2BRAM.scala 257:18 DRAM2BRAM.scala 257:18]
  wire [7:0] _GEN_435 = 3'h5 == _T_183 ? _GEN_275 : _GEN_433; // @[DRAM2BRAM.scala 257:18 DRAM2BRAM.scala 257:18]
  wire [5:0] _GEN_436 = 3'h5 == _T_183 ? _GEN_267 : _GEN_434; // @[DRAM2BRAM.scala 257:18 DRAM2BRAM.scala 257:18]
  wire [7:0] _GEN_437 = 3'h6 == _T_183 ? _GEN_276 : _GEN_435; // @[DRAM2BRAM.scala 257:18 DRAM2BRAM.scala 257:18]
  wire [5:0] _GEN_438 = 3'h6 == _T_183 ? _GEN_268 : _GEN_436; // @[DRAM2BRAM.scala 257:18 DRAM2BRAM.scala 257:18]
  wire [7:0] _GEN_439 = 3'h7 == _T_183 ? _GEN_277 : _GEN_437; // @[DRAM2BRAM.scala 257:18 DRAM2BRAM.scala 257:18]
  wire [5:0] _GEN_440 = 3'h7 == _T_183 ? _GEN_269 : _GEN_438; // @[DRAM2BRAM.scala 257:18 DRAM2BRAM.scala 257:18]
  wire [5:0] _GEN_441 = 3'h6 < regElCnt ? regBramLine_els_6_col : _GEN_440; // @[DRAM2BRAM.scala 254:34 DRAM2BRAM.scala 255:18 DRAM2BRAM.scala 257:18]
  wire [7:0] _GEN_442 = 3'h6 < regElCnt ? regBramLine_els_6_value : _GEN_439; // @[DRAM2BRAM.scala 254:34 DRAM2BRAM.scala 255:18 DRAM2BRAM.scala 257:18]
  wire [2:0] _T_186 = 3'h7 - regElCnt; // @[DRAM2BRAM.scala 257:31]
  wire [7:0] _GEN_445 = 3'h1 == _T_186 ? _GEN_271 : _GEN_270; // @[DRAM2BRAM.scala 257:18 DRAM2BRAM.scala 257:18]
  wire [5:0] _GEN_446 = 3'h1 == _T_186 ? _GEN_263 : _GEN_262; // @[DRAM2BRAM.scala 257:18 DRAM2BRAM.scala 257:18]
  wire [7:0] _GEN_447 = 3'h2 == _T_186 ? _GEN_272 : _GEN_445; // @[DRAM2BRAM.scala 257:18 DRAM2BRAM.scala 257:18]
  wire [5:0] _GEN_448 = 3'h2 == _T_186 ? _GEN_264 : _GEN_446; // @[DRAM2BRAM.scala 257:18 DRAM2BRAM.scala 257:18]
  wire [7:0] _GEN_449 = 3'h3 == _T_186 ? _GEN_273 : _GEN_447; // @[DRAM2BRAM.scala 257:18 DRAM2BRAM.scala 257:18]
  wire [5:0] _GEN_450 = 3'h3 == _T_186 ? _GEN_265 : _GEN_448; // @[DRAM2BRAM.scala 257:18 DRAM2BRAM.scala 257:18]
  wire [7:0] _GEN_451 = 3'h4 == _T_186 ? _GEN_274 : _GEN_449; // @[DRAM2BRAM.scala 257:18 DRAM2BRAM.scala 257:18]
  wire [5:0] _GEN_452 = 3'h4 == _T_186 ? _GEN_266 : _GEN_450; // @[DRAM2BRAM.scala 257:18 DRAM2BRAM.scala 257:18]
  wire [7:0] _GEN_453 = 3'h5 == _T_186 ? _GEN_275 : _GEN_451; // @[DRAM2BRAM.scala 257:18 DRAM2BRAM.scala 257:18]
  wire [5:0] _GEN_454 = 3'h5 == _T_186 ? _GEN_267 : _GEN_452; // @[DRAM2BRAM.scala 257:18 DRAM2BRAM.scala 257:18]
  wire [7:0] _GEN_455 = 3'h6 == _T_186 ? _GEN_276 : _GEN_453; // @[DRAM2BRAM.scala 257:18 DRAM2BRAM.scala 257:18]
  wire [5:0] _GEN_456 = 3'h6 == _T_186 ? _GEN_268 : _GEN_454; // @[DRAM2BRAM.scala 257:18 DRAM2BRAM.scala 257:18]
  wire [7:0] _GEN_457 = 3'h7 == _T_186 ? _GEN_277 : _GEN_455; // @[DRAM2BRAM.scala 257:18 DRAM2BRAM.scala 257:18]
  wire [5:0] _GEN_458 = 3'h7 == _T_186 ? _GEN_269 : _GEN_456; // @[DRAM2BRAM.scala 257:18 DRAM2BRAM.scala 257:18]
  wire [55:0] lo_2 = {_GEN_388,_GEN_387,_GEN_370,_GEN_369,_GEN_352,_GEN_351,_GEN_334,_GEN_333}; // @[DRAM2BRAM.scala 262:54]
  wire [111:0] _T_187 = {_GEN_457,_GEN_458,_GEN_442,_GEN_441,_GEN_424,_GEN_423,_GEN_406,_GEN_405,lo_2}; // @[DRAM2BRAM.scala 262:54]
  wire [3:0] _T_190 = 4'h0 - _T_162; // @[DRAM2BRAM.scala 268:34]
  wire [5:0] _GEN_461 = 3'h0 == _T_190[2:0] ? _GEN_262 : regBramLine_els_0_col; // @[DRAM2BRAM.scala 268:46 DRAM2BRAM.scala 268:46 DRAM2BRAM.scala 118:28]
  wire [5:0] _GEN_462 = 3'h1 == _T_190[2:0] ? _GEN_262 : regBramLine_els_1_col; // @[DRAM2BRAM.scala 268:46 DRAM2BRAM.scala 268:46 DRAM2BRAM.scala 118:28]
  wire [5:0] _GEN_463 = 3'h2 == _T_190[2:0] ? _GEN_262 : regBramLine_els_2_col; // @[DRAM2BRAM.scala 268:46 DRAM2BRAM.scala 268:46 DRAM2BRAM.scala 118:28]
  wire [5:0] _GEN_464 = 3'h3 == _T_190[2:0] ? _GEN_262 : regBramLine_els_3_col; // @[DRAM2BRAM.scala 268:46 DRAM2BRAM.scala 268:46 DRAM2BRAM.scala 118:28]
  wire [5:0] _GEN_465 = 3'h4 == _T_190[2:0] ? _GEN_262 : regBramLine_els_4_col; // @[DRAM2BRAM.scala 268:46 DRAM2BRAM.scala 268:46 DRAM2BRAM.scala 118:28]
  wire [5:0] _GEN_466 = 3'h5 == _T_190[2:0] ? _GEN_262 : regBramLine_els_5_col; // @[DRAM2BRAM.scala 268:46 DRAM2BRAM.scala 268:46 DRAM2BRAM.scala 118:28]
  wire [5:0] _GEN_467 = 3'h6 == _T_190[2:0] ? _GEN_262 : regBramLine_els_6_col; // @[DRAM2BRAM.scala 268:46 DRAM2BRAM.scala 268:46 DRAM2BRAM.scala 118:28]
  wire [5:0] _GEN_468 = 3'h7 == _T_190[2:0] ? _GEN_262 : regBramLine_els_7_col; // @[DRAM2BRAM.scala 268:46 DRAM2BRAM.scala 268:46 DRAM2BRAM.scala 118:28]
  wire [7:0] _GEN_469 = 3'h0 == _T_190[2:0] ? _GEN_270 : regBramLine_els_0_value; // @[DRAM2BRAM.scala 268:46 DRAM2BRAM.scala 268:46 DRAM2BRAM.scala 118:28]
  wire [7:0] _GEN_470 = 3'h1 == _T_190[2:0] ? _GEN_270 : regBramLine_els_1_value; // @[DRAM2BRAM.scala 268:46 DRAM2BRAM.scala 268:46 DRAM2BRAM.scala 118:28]
  wire [7:0] _GEN_471 = 3'h2 == _T_190[2:0] ? _GEN_270 : regBramLine_els_2_value; // @[DRAM2BRAM.scala 268:46 DRAM2BRAM.scala 268:46 DRAM2BRAM.scala 118:28]
  wire [7:0] _GEN_472 = 3'h3 == _T_190[2:0] ? _GEN_270 : regBramLine_els_3_value; // @[DRAM2BRAM.scala 268:46 DRAM2BRAM.scala 268:46 DRAM2BRAM.scala 118:28]
  wire [7:0] _GEN_473 = 3'h4 == _T_190[2:0] ? _GEN_270 : regBramLine_els_4_value; // @[DRAM2BRAM.scala 268:46 DRAM2BRAM.scala 268:46 DRAM2BRAM.scala 118:28]
  wire [7:0] _GEN_474 = 3'h5 == _T_190[2:0] ? _GEN_270 : regBramLine_els_5_value; // @[DRAM2BRAM.scala 268:46 DRAM2BRAM.scala 268:46 DRAM2BRAM.scala 118:28]
  wire [7:0] _GEN_475 = 3'h6 == _T_190[2:0] ? _GEN_270 : regBramLine_els_6_value; // @[DRAM2BRAM.scala 268:46 DRAM2BRAM.scala 268:46 DRAM2BRAM.scala 118:28]
  wire [7:0] _GEN_476 = 3'h7 == _T_190[2:0] ? _GEN_270 : regBramLine_els_7_value; // @[DRAM2BRAM.scala 268:46 DRAM2BRAM.scala 268:46 DRAM2BRAM.scala 118:28]
  wire [5:0] _GEN_477 = 4'h0 >= _T_162 ? _GEN_461 : regBramLine_els_0_col; // @[DRAM2BRAM.scala 267:34 DRAM2BRAM.scala 118:28]
  wire [5:0] _GEN_478 = 4'h0 >= _T_162 ? _GEN_462 : regBramLine_els_1_col; // @[DRAM2BRAM.scala 267:34 DRAM2BRAM.scala 118:28]
  wire [5:0] _GEN_479 = 4'h0 >= _T_162 ? _GEN_463 : regBramLine_els_2_col; // @[DRAM2BRAM.scala 267:34 DRAM2BRAM.scala 118:28]
  wire [5:0] _GEN_480 = 4'h0 >= _T_162 ? _GEN_464 : regBramLine_els_3_col; // @[DRAM2BRAM.scala 267:34 DRAM2BRAM.scala 118:28]
  wire [5:0] _GEN_481 = 4'h0 >= _T_162 ? _GEN_465 : regBramLine_els_4_col; // @[DRAM2BRAM.scala 267:34 DRAM2BRAM.scala 118:28]
  wire [5:0] _GEN_482 = 4'h0 >= _T_162 ? _GEN_466 : regBramLine_els_5_col; // @[DRAM2BRAM.scala 267:34 DRAM2BRAM.scala 118:28]
  wire [5:0] _GEN_483 = 4'h0 >= _T_162 ? _GEN_467 : regBramLine_els_6_col; // @[DRAM2BRAM.scala 267:34 DRAM2BRAM.scala 118:28]
  wire [5:0] _GEN_484 = 4'h0 >= _T_162 ? _GEN_468 : regBramLine_els_7_col; // @[DRAM2BRAM.scala 267:34 DRAM2BRAM.scala 118:28]
  wire [7:0] _GEN_485 = 4'h0 >= _T_162 ? _GEN_469 : regBramLine_els_0_value; // @[DRAM2BRAM.scala 267:34 DRAM2BRAM.scala 118:28]
  wire [7:0] _GEN_486 = 4'h0 >= _T_162 ? _GEN_470 : regBramLine_els_1_value; // @[DRAM2BRAM.scala 267:34 DRAM2BRAM.scala 118:28]
  wire [7:0] _GEN_487 = 4'h0 >= _T_162 ? _GEN_471 : regBramLine_els_2_value; // @[DRAM2BRAM.scala 267:34 DRAM2BRAM.scala 118:28]
  wire [7:0] _GEN_488 = 4'h0 >= _T_162 ? _GEN_472 : regBramLine_els_3_value; // @[DRAM2BRAM.scala 267:34 DRAM2BRAM.scala 118:28]
  wire [7:0] _GEN_489 = 4'h0 >= _T_162 ? _GEN_473 : regBramLine_els_4_value; // @[DRAM2BRAM.scala 267:34 DRAM2BRAM.scala 118:28]
  wire [7:0] _GEN_490 = 4'h0 >= _T_162 ? _GEN_474 : regBramLine_els_5_value; // @[DRAM2BRAM.scala 267:34 DRAM2BRAM.scala 118:28]
  wire [7:0] _GEN_491 = 4'h0 >= _T_162 ? _GEN_475 : regBramLine_els_6_value; // @[DRAM2BRAM.scala 267:34 DRAM2BRAM.scala 118:28]
  wire [7:0] _GEN_492 = 4'h0 >= _T_162 ? _GEN_476 : regBramLine_els_7_value; // @[DRAM2BRAM.scala 267:34 DRAM2BRAM.scala 118:28]
  wire [3:0] _T_194 = 4'h1 - _T_162; // @[DRAM2BRAM.scala 268:34]
  wire [5:0] _GEN_493 = 3'h0 == _T_194[2:0] ? _GEN_263 : _GEN_477; // @[DRAM2BRAM.scala 268:46 DRAM2BRAM.scala 268:46]
  wire [5:0] _GEN_494 = 3'h1 == _T_194[2:0] ? _GEN_263 : _GEN_478; // @[DRAM2BRAM.scala 268:46 DRAM2BRAM.scala 268:46]
  wire [5:0] _GEN_495 = 3'h2 == _T_194[2:0] ? _GEN_263 : _GEN_479; // @[DRAM2BRAM.scala 268:46 DRAM2BRAM.scala 268:46]
  wire [5:0] _GEN_496 = 3'h3 == _T_194[2:0] ? _GEN_263 : _GEN_480; // @[DRAM2BRAM.scala 268:46 DRAM2BRAM.scala 268:46]
  wire [5:0] _GEN_497 = 3'h4 == _T_194[2:0] ? _GEN_263 : _GEN_481; // @[DRAM2BRAM.scala 268:46 DRAM2BRAM.scala 268:46]
  wire [5:0] _GEN_498 = 3'h5 == _T_194[2:0] ? _GEN_263 : _GEN_482; // @[DRAM2BRAM.scala 268:46 DRAM2BRAM.scala 268:46]
  wire [5:0] _GEN_499 = 3'h6 == _T_194[2:0] ? _GEN_263 : _GEN_483; // @[DRAM2BRAM.scala 268:46 DRAM2BRAM.scala 268:46]
  wire [5:0] _GEN_500 = 3'h7 == _T_194[2:0] ? _GEN_263 : _GEN_484; // @[DRAM2BRAM.scala 268:46 DRAM2BRAM.scala 268:46]
  wire [7:0] _GEN_501 = 3'h0 == _T_194[2:0] ? _GEN_271 : _GEN_485; // @[DRAM2BRAM.scala 268:46 DRAM2BRAM.scala 268:46]
  wire [7:0] _GEN_502 = 3'h1 == _T_194[2:0] ? _GEN_271 : _GEN_486; // @[DRAM2BRAM.scala 268:46 DRAM2BRAM.scala 268:46]
  wire [7:0] _GEN_503 = 3'h2 == _T_194[2:0] ? _GEN_271 : _GEN_487; // @[DRAM2BRAM.scala 268:46 DRAM2BRAM.scala 268:46]
  wire [7:0] _GEN_504 = 3'h3 == _T_194[2:0] ? _GEN_271 : _GEN_488; // @[DRAM2BRAM.scala 268:46 DRAM2BRAM.scala 268:46]
  wire [7:0] _GEN_505 = 3'h4 == _T_194[2:0] ? _GEN_271 : _GEN_489; // @[DRAM2BRAM.scala 268:46 DRAM2BRAM.scala 268:46]
  wire [7:0] _GEN_506 = 3'h5 == _T_194[2:0] ? _GEN_271 : _GEN_490; // @[DRAM2BRAM.scala 268:46 DRAM2BRAM.scala 268:46]
  wire [7:0] _GEN_507 = 3'h6 == _T_194[2:0] ? _GEN_271 : _GEN_491; // @[DRAM2BRAM.scala 268:46 DRAM2BRAM.scala 268:46]
  wire [7:0] _GEN_508 = 3'h7 == _T_194[2:0] ? _GEN_271 : _GEN_492; // @[DRAM2BRAM.scala 268:46 DRAM2BRAM.scala 268:46]
  wire [5:0] _GEN_509 = 4'h1 >= _T_162 ? _GEN_493 : _GEN_477; // @[DRAM2BRAM.scala 267:34]
  wire [5:0] _GEN_510 = 4'h1 >= _T_162 ? _GEN_494 : _GEN_478; // @[DRAM2BRAM.scala 267:34]
  wire [5:0] _GEN_511 = 4'h1 >= _T_162 ? _GEN_495 : _GEN_479; // @[DRAM2BRAM.scala 267:34]
  wire [5:0] _GEN_512 = 4'h1 >= _T_162 ? _GEN_496 : _GEN_480; // @[DRAM2BRAM.scala 267:34]
  wire [5:0] _GEN_513 = 4'h1 >= _T_162 ? _GEN_497 : _GEN_481; // @[DRAM2BRAM.scala 267:34]
  wire [5:0] _GEN_514 = 4'h1 >= _T_162 ? _GEN_498 : _GEN_482; // @[DRAM2BRAM.scala 267:34]
  wire [5:0] _GEN_515 = 4'h1 >= _T_162 ? _GEN_499 : _GEN_483; // @[DRAM2BRAM.scala 267:34]
  wire [5:0] _GEN_516 = 4'h1 >= _T_162 ? _GEN_500 : _GEN_484; // @[DRAM2BRAM.scala 267:34]
  wire [7:0] _GEN_517 = 4'h1 >= _T_162 ? _GEN_501 : _GEN_485; // @[DRAM2BRAM.scala 267:34]
  wire [7:0] _GEN_518 = 4'h1 >= _T_162 ? _GEN_502 : _GEN_486; // @[DRAM2BRAM.scala 267:34]
  wire [7:0] _GEN_519 = 4'h1 >= _T_162 ? _GEN_503 : _GEN_487; // @[DRAM2BRAM.scala 267:34]
  wire [7:0] _GEN_520 = 4'h1 >= _T_162 ? _GEN_504 : _GEN_488; // @[DRAM2BRAM.scala 267:34]
  wire [7:0] _GEN_521 = 4'h1 >= _T_162 ? _GEN_505 : _GEN_489; // @[DRAM2BRAM.scala 267:34]
  wire [7:0] _GEN_522 = 4'h1 >= _T_162 ? _GEN_506 : _GEN_490; // @[DRAM2BRAM.scala 267:34]
  wire [7:0] _GEN_523 = 4'h1 >= _T_162 ? _GEN_507 : _GEN_491; // @[DRAM2BRAM.scala 267:34]
  wire [7:0] _GEN_524 = 4'h1 >= _T_162 ? _GEN_508 : _GEN_492; // @[DRAM2BRAM.scala 267:34]
  wire [3:0] _T_198 = 4'h2 - _T_162; // @[DRAM2BRAM.scala 268:34]
  wire [5:0] _GEN_525 = 3'h0 == _T_198[2:0] ? _GEN_264 : _GEN_509; // @[DRAM2BRAM.scala 268:46 DRAM2BRAM.scala 268:46]
  wire [5:0] _GEN_526 = 3'h1 == _T_198[2:0] ? _GEN_264 : _GEN_510; // @[DRAM2BRAM.scala 268:46 DRAM2BRAM.scala 268:46]
  wire [5:0] _GEN_527 = 3'h2 == _T_198[2:0] ? _GEN_264 : _GEN_511; // @[DRAM2BRAM.scala 268:46 DRAM2BRAM.scala 268:46]
  wire [5:0] _GEN_528 = 3'h3 == _T_198[2:0] ? _GEN_264 : _GEN_512; // @[DRAM2BRAM.scala 268:46 DRAM2BRAM.scala 268:46]
  wire [5:0] _GEN_529 = 3'h4 == _T_198[2:0] ? _GEN_264 : _GEN_513; // @[DRAM2BRAM.scala 268:46 DRAM2BRAM.scala 268:46]
  wire [5:0] _GEN_530 = 3'h5 == _T_198[2:0] ? _GEN_264 : _GEN_514; // @[DRAM2BRAM.scala 268:46 DRAM2BRAM.scala 268:46]
  wire [5:0] _GEN_531 = 3'h6 == _T_198[2:0] ? _GEN_264 : _GEN_515; // @[DRAM2BRAM.scala 268:46 DRAM2BRAM.scala 268:46]
  wire [5:0] _GEN_532 = 3'h7 == _T_198[2:0] ? _GEN_264 : _GEN_516; // @[DRAM2BRAM.scala 268:46 DRAM2BRAM.scala 268:46]
  wire [7:0] _GEN_533 = 3'h0 == _T_198[2:0] ? _GEN_272 : _GEN_517; // @[DRAM2BRAM.scala 268:46 DRAM2BRAM.scala 268:46]
  wire [7:0] _GEN_534 = 3'h1 == _T_198[2:0] ? _GEN_272 : _GEN_518; // @[DRAM2BRAM.scala 268:46 DRAM2BRAM.scala 268:46]
  wire [7:0] _GEN_535 = 3'h2 == _T_198[2:0] ? _GEN_272 : _GEN_519; // @[DRAM2BRAM.scala 268:46 DRAM2BRAM.scala 268:46]
  wire [7:0] _GEN_536 = 3'h3 == _T_198[2:0] ? _GEN_272 : _GEN_520; // @[DRAM2BRAM.scala 268:46 DRAM2BRAM.scala 268:46]
  wire [7:0] _GEN_537 = 3'h4 == _T_198[2:0] ? _GEN_272 : _GEN_521; // @[DRAM2BRAM.scala 268:46 DRAM2BRAM.scala 268:46]
  wire [7:0] _GEN_538 = 3'h5 == _T_198[2:0] ? _GEN_272 : _GEN_522; // @[DRAM2BRAM.scala 268:46 DRAM2BRAM.scala 268:46]
  wire [7:0] _GEN_539 = 3'h6 == _T_198[2:0] ? _GEN_272 : _GEN_523; // @[DRAM2BRAM.scala 268:46 DRAM2BRAM.scala 268:46]
  wire [7:0] _GEN_540 = 3'h7 == _T_198[2:0] ? _GEN_272 : _GEN_524; // @[DRAM2BRAM.scala 268:46 DRAM2BRAM.scala 268:46]
  wire [5:0] _GEN_541 = 4'h2 >= _T_162 ? _GEN_525 : _GEN_509; // @[DRAM2BRAM.scala 267:34]
  wire [5:0] _GEN_542 = 4'h2 >= _T_162 ? _GEN_526 : _GEN_510; // @[DRAM2BRAM.scala 267:34]
  wire [5:0] _GEN_543 = 4'h2 >= _T_162 ? _GEN_527 : _GEN_511; // @[DRAM2BRAM.scala 267:34]
  wire [5:0] _GEN_544 = 4'h2 >= _T_162 ? _GEN_528 : _GEN_512; // @[DRAM2BRAM.scala 267:34]
  wire [5:0] _GEN_545 = 4'h2 >= _T_162 ? _GEN_529 : _GEN_513; // @[DRAM2BRAM.scala 267:34]
  wire [5:0] _GEN_546 = 4'h2 >= _T_162 ? _GEN_530 : _GEN_514; // @[DRAM2BRAM.scala 267:34]
  wire [5:0] _GEN_547 = 4'h2 >= _T_162 ? _GEN_531 : _GEN_515; // @[DRAM2BRAM.scala 267:34]
  wire [5:0] _GEN_548 = 4'h2 >= _T_162 ? _GEN_532 : _GEN_516; // @[DRAM2BRAM.scala 267:34]
  wire [7:0] _GEN_549 = 4'h2 >= _T_162 ? _GEN_533 : _GEN_517; // @[DRAM2BRAM.scala 267:34]
  wire [7:0] _GEN_550 = 4'h2 >= _T_162 ? _GEN_534 : _GEN_518; // @[DRAM2BRAM.scala 267:34]
  wire [7:0] _GEN_551 = 4'h2 >= _T_162 ? _GEN_535 : _GEN_519; // @[DRAM2BRAM.scala 267:34]
  wire [7:0] _GEN_552 = 4'h2 >= _T_162 ? _GEN_536 : _GEN_520; // @[DRAM2BRAM.scala 267:34]
  wire [7:0] _GEN_553 = 4'h2 >= _T_162 ? _GEN_537 : _GEN_521; // @[DRAM2BRAM.scala 267:34]
  wire [7:0] _GEN_554 = 4'h2 >= _T_162 ? _GEN_538 : _GEN_522; // @[DRAM2BRAM.scala 267:34]
  wire [7:0] _GEN_555 = 4'h2 >= _T_162 ? _GEN_539 : _GEN_523; // @[DRAM2BRAM.scala 267:34]
  wire [7:0] _GEN_556 = 4'h2 >= _T_162 ? _GEN_540 : _GEN_524; // @[DRAM2BRAM.scala 267:34]
  wire [3:0] _T_202 = 4'h3 - _T_162; // @[DRAM2BRAM.scala 268:34]
  wire [5:0] _GEN_557 = 3'h0 == _T_202[2:0] ? _GEN_265 : _GEN_541; // @[DRAM2BRAM.scala 268:46 DRAM2BRAM.scala 268:46]
  wire [5:0] _GEN_558 = 3'h1 == _T_202[2:0] ? _GEN_265 : _GEN_542; // @[DRAM2BRAM.scala 268:46 DRAM2BRAM.scala 268:46]
  wire [5:0] _GEN_559 = 3'h2 == _T_202[2:0] ? _GEN_265 : _GEN_543; // @[DRAM2BRAM.scala 268:46 DRAM2BRAM.scala 268:46]
  wire [5:0] _GEN_560 = 3'h3 == _T_202[2:0] ? _GEN_265 : _GEN_544; // @[DRAM2BRAM.scala 268:46 DRAM2BRAM.scala 268:46]
  wire [5:0] _GEN_561 = 3'h4 == _T_202[2:0] ? _GEN_265 : _GEN_545; // @[DRAM2BRAM.scala 268:46 DRAM2BRAM.scala 268:46]
  wire [5:0] _GEN_562 = 3'h5 == _T_202[2:0] ? _GEN_265 : _GEN_546; // @[DRAM2BRAM.scala 268:46 DRAM2BRAM.scala 268:46]
  wire [5:0] _GEN_563 = 3'h6 == _T_202[2:0] ? _GEN_265 : _GEN_547; // @[DRAM2BRAM.scala 268:46 DRAM2BRAM.scala 268:46]
  wire [5:0] _GEN_564 = 3'h7 == _T_202[2:0] ? _GEN_265 : _GEN_548; // @[DRAM2BRAM.scala 268:46 DRAM2BRAM.scala 268:46]
  wire [7:0] _GEN_565 = 3'h0 == _T_202[2:0] ? _GEN_273 : _GEN_549; // @[DRAM2BRAM.scala 268:46 DRAM2BRAM.scala 268:46]
  wire [7:0] _GEN_566 = 3'h1 == _T_202[2:0] ? _GEN_273 : _GEN_550; // @[DRAM2BRAM.scala 268:46 DRAM2BRAM.scala 268:46]
  wire [7:0] _GEN_567 = 3'h2 == _T_202[2:0] ? _GEN_273 : _GEN_551; // @[DRAM2BRAM.scala 268:46 DRAM2BRAM.scala 268:46]
  wire [7:0] _GEN_568 = 3'h3 == _T_202[2:0] ? _GEN_273 : _GEN_552; // @[DRAM2BRAM.scala 268:46 DRAM2BRAM.scala 268:46]
  wire [7:0] _GEN_569 = 3'h4 == _T_202[2:0] ? _GEN_273 : _GEN_553; // @[DRAM2BRAM.scala 268:46 DRAM2BRAM.scala 268:46]
  wire [7:0] _GEN_570 = 3'h5 == _T_202[2:0] ? _GEN_273 : _GEN_554; // @[DRAM2BRAM.scala 268:46 DRAM2BRAM.scala 268:46]
  wire [7:0] _GEN_571 = 3'h6 == _T_202[2:0] ? _GEN_273 : _GEN_555; // @[DRAM2BRAM.scala 268:46 DRAM2BRAM.scala 268:46]
  wire [7:0] _GEN_572 = 3'h7 == _T_202[2:0] ? _GEN_273 : _GEN_556; // @[DRAM2BRAM.scala 268:46 DRAM2BRAM.scala 268:46]
  wire [5:0] _GEN_573 = 4'h3 >= _T_162 ? _GEN_557 : _GEN_541; // @[DRAM2BRAM.scala 267:34]
  wire [5:0] _GEN_574 = 4'h3 >= _T_162 ? _GEN_558 : _GEN_542; // @[DRAM2BRAM.scala 267:34]
  wire [5:0] _GEN_575 = 4'h3 >= _T_162 ? _GEN_559 : _GEN_543; // @[DRAM2BRAM.scala 267:34]
  wire [5:0] _GEN_576 = 4'h3 >= _T_162 ? _GEN_560 : _GEN_544; // @[DRAM2BRAM.scala 267:34]
  wire [5:0] _GEN_577 = 4'h3 >= _T_162 ? _GEN_561 : _GEN_545; // @[DRAM2BRAM.scala 267:34]
  wire [5:0] _GEN_578 = 4'h3 >= _T_162 ? _GEN_562 : _GEN_546; // @[DRAM2BRAM.scala 267:34]
  wire [5:0] _GEN_579 = 4'h3 >= _T_162 ? _GEN_563 : _GEN_547; // @[DRAM2BRAM.scala 267:34]
  wire [5:0] _GEN_580 = 4'h3 >= _T_162 ? _GEN_564 : _GEN_548; // @[DRAM2BRAM.scala 267:34]
  wire [7:0] _GEN_581 = 4'h3 >= _T_162 ? _GEN_565 : _GEN_549; // @[DRAM2BRAM.scala 267:34]
  wire [7:0] _GEN_582 = 4'h3 >= _T_162 ? _GEN_566 : _GEN_550; // @[DRAM2BRAM.scala 267:34]
  wire [7:0] _GEN_583 = 4'h3 >= _T_162 ? _GEN_567 : _GEN_551; // @[DRAM2BRAM.scala 267:34]
  wire [7:0] _GEN_584 = 4'h3 >= _T_162 ? _GEN_568 : _GEN_552; // @[DRAM2BRAM.scala 267:34]
  wire [7:0] _GEN_585 = 4'h3 >= _T_162 ? _GEN_569 : _GEN_553; // @[DRAM2BRAM.scala 267:34]
  wire [7:0] _GEN_586 = 4'h3 >= _T_162 ? _GEN_570 : _GEN_554; // @[DRAM2BRAM.scala 267:34]
  wire [7:0] _GEN_587 = 4'h3 >= _T_162 ? _GEN_571 : _GEN_555; // @[DRAM2BRAM.scala 267:34]
  wire [7:0] _GEN_588 = 4'h3 >= _T_162 ? _GEN_572 : _GEN_556; // @[DRAM2BRAM.scala 267:34]
  wire [3:0] _T_206 = 4'h4 - _T_162; // @[DRAM2BRAM.scala 268:34]
  wire [5:0] _GEN_589 = 3'h0 == _T_206[2:0] ? _GEN_266 : _GEN_573; // @[DRAM2BRAM.scala 268:46 DRAM2BRAM.scala 268:46]
  wire [5:0] _GEN_590 = 3'h1 == _T_206[2:0] ? _GEN_266 : _GEN_574; // @[DRAM2BRAM.scala 268:46 DRAM2BRAM.scala 268:46]
  wire [5:0] _GEN_591 = 3'h2 == _T_206[2:0] ? _GEN_266 : _GEN_575; // @[DRAM2BRAM.scala 268:46 DRAM2BRAM.scala 268:46]
  wire [5:0] _GEN_592 = 3'h3 == _T_206[2:0] ? _GEN_266 : _GEN_576; // @[DRAM2BRAM.scala 268:46 DRAM2BRAM.scala 268:46]
  wire [5:0] _GEN_593 = 3'h4 == _T_206[2:0] ? _GEN_266 : _GEN_577; // @[DRAM2BRAM.scala 268:46 DRAM2BRAM.scala 268:46]
  wire [5:0] _GEN_594 = 3'h5 == _T_206[2:0] ? _GEN_266 : _GEN_578; // @[DRAM2BRAM.scala 268:46 DRAM2BRAM.scala 268:46]
  wire [5:0] _GEN_595 = 3'h6 == _T_206[2:0] ? _GEN_266 : _GEN_579; // @[DRAM2BRAM.scala 268:46 DRAM2BRAM.scala 268:46]
  wire [5:0] _GEN_596 = 3'h7 == _T_206[2:0] ? _GEN_266 : _GEN_580; // @[DRAM2BRAM.scala 268:46 DRAM2BRAM.scala 268:46]
  wire [7:0] _GEN_597 = 3'h0 == _T_206[2:0] ? _GEN_274 : _GEN_581; // @[DRAM2BRAM.scala 268:46 DRAM2BRAM.scala 268:46]
  wire [7:0] _GEN_598 = 3'h1 == _T_206[2:0] ? _GEN_274 : _GEN_582; // @[DRAM2BRAM.scala 268:46 DRAM2BRAM.scala 268:46]
  wire [7:0] _GEN_599 = 3'h2 == _T_206[2:0] ? _GEN_274 : _GEN_583; // @[DRAM2BRAM.scala 268:46 DRAM2BRAM.scala 268:46]
  wire [7:0] _GEN_600 = 3'h3 == _T_206[2:0] ? _GEN_274 : _GEN_584; // @[DRAM2BRAM.scala 268:46 DRAM2BRAM.scala 268:46]
  wire [7:0] _GEN_601 = 3'h4 == _T_206[2:0] ? _GEN_274 : _GEN_585; // @[DRAM2BRAM.scala 268:46 DRAM2BRAM.scala 268:46]
  wire [7:0] _GEN_602 = 3'h5 == _T_206[2:0] ? _GEN_274 : _GEN_586; // @[DRAM2BRAM.scala 268:46 DRAM2BRAM.scala 268:46]
  wire [7:0] _GEN_603 = 3'h6 == _T_206[2:0] ? _GEN_274 : _GEN_587; // @[DRAM2BRAM.scala 268:46 DRAM2BRAM.scala 268:46]
  wire [7:0] _GEN_604 = 3'h7 == _T_206[2:0] ? _GEN_274 : _GEN_588; // @[DRAM2BRAM.scala 268:46 DRAM2BRAM.scala 268:46]
  wire [5:0] _GEN_605 = 4'h4 >= _T_162 ? _GEN_589 : _GEN_573; // @[DRAM2BRAM.scala 267:34]
  wire [5:0] _GEN_606 = 4'h4 >= _T_162 ? _GEN_590 : _GEN_574; // @[DRAM2BRAM.scala 267:34]
  wire [5:0] _GEN_607 = 4'h4 >= _T_162 ? _GEN_591 : _GEN_575; // @[DRAM2BRAM.scala 267:34]
  wire [5:0] _GEN_608 = 4'h4 >= _T_162 ? _GEN_592 : _GEN_576; // @[DRAM2BRAM.scala 267:34]
  wire [5:0] _GEN_609 = 4'h4 >= _T_162 ? _GEN_593 : _GEN_577; // @[DRAM2BRAM.scala 267:34]
  wire [5:0] _GEN_610 = 4'h4 >= _T_162 ? _GEN_594 : _GEN_578; // @[DRAM2BRAM.scala 267:34]
  wire [5:0] _GEN_611 = 4'h4 >= _T_162 ? _GEN_595 : _GEN_579; // @[DRAM2BRAM.scala 267:34]
  wire [5:0] _GEN_612 = 4'h4 >= _T_162 ? _GEN_596 : _GEN_580; // @[DRAM2BRAM.scala 267:34]
  wire [7:0] _GEN_613 = 4'h4 >= _T_162 ? _GEN_597 : _GEN_581; // @[DRAM2BRAM.scala 267:34]
  wire [7:0] _GEN_614 = 4'h4 >= _T_162 ? _GEN_598 : _GEN_582; // @[DRAM2BRAM.scala 267:34]
  wire [7:0] _GEN_615 = 4'h4 >= _T_162 ? _GEN_599 : _GEN_583; // @[DRAM2BRAM.scala 267:34]
  wire [7:0] _GEN_616 = 4'h4 >= _T_162 ? _GEN_600 : _GEN_584; // @[DRAM2BRAM.scala 267:34]
  wire [7:0] _GEN_617 = 4'h4 >= _T_162 ? _GEN_601 : _GEN_585; // @[DRAM2BRAM.scala 267:34]
  wire [7:0] _GEN_618 = 4'h4 >= _T_162 ? _GEN_602 : _GEN_586; // @[DRAM2BRAM.scala 267:34]
  wire [7:0] _GEN_619 = 4'h4 >= _T_162 ? _GEN_603 : _GEN_587; // @[DRAM2BRAM.scala 267:34]
  wire [7:0] _GEN_620 = 4'h4 >= _T_162 ? _GEN_604 : _GEN_588; // @[DRAM2BRAM.scala 267:34]
  wire [3:0] _T_210 = 4'h5 - _T_162; // @[DRAM2BRAM.scala 268:34]
  wire [5:0] _GEN_621 = 3'h0 == _T_210[2:0] ? _GEN_267 : _GEN_605; // @[DRAM2BRAM.scala 268:46 DRAM2BRAM.scala 268:46]
  wire [5:0] _GEN_622 = 3'h1 == _T_210[2:0] ? _GEN_267 : _GEN_606; // @[DRAM2BRAM.scala 268:46 DRAM2BRAM.scala 268:46]
  wire [5:0] _GEN_623 = 3'h2 == _T_210[2:0] ? _GEN_267 : _GEN_607; // @[DRAM2BRAM.scala 268:46 DRAM2BRAM.scala 268:46]
  wire [5:0] _GEN_624 = 3'h3 == _T_210[2:0] ? _GEN_267 : _GEN_608; // @[DRAM2BRAM.scala 268:46 DRAM2BRAM.scala 268:46]
  wire [5:0] _GEN_625 = 3'h4 == _T_210[2:0] ? _GEN_267 : _GEN_609; // @[DRAM2BRAM.scala 268:46 DRAM2BRAM.scala 268:46]
  wire [5:0] _GEN_626 = 3'h5 == _T_210[2:0] ? _GEN_267 : _GEN_610; // @[DRAM2BRAM.scala 268:46 DRAM2BRAM.scala 268:46]
  wire [5:0] _GEN_627 = 3'h6 == _T_210[2:0] ? _GEN_267 : _GEN_611; // @[DRAM2BRAM.scala 268:46 DRAM2BRAM.scala 268:46]
  wire [5:0] _GEN_628 = 3'h7 == _T_210[2:0] ? _GEN_267 : _GEN_612; // @[DRAM2BRAM.scala 268:46 DRAM2BRAM.scala 268:46]
  wire [7:0] _GEN_629 = 3'h0 == _T_210[2:0] ? _GEN_275 : _GEN_613; // @[DRAM2BRAM.scala 268:46 DRAM2BRAM.scala 268:46]
  wire [7:0] _GEN_630 = 3'h1 == _T_210[2:0] ? _GEN_275 : _GEN_614; // @[DRAM2BRAM.scala 268:46 DRAM2BRAM.scala 268:46]
  wire [7:0] _GEN_631 = 3'h2 == _T_210[2:0] ? _GEN_275 : _GEN_615; // @[DRAM2BRAM.scala 268:46 DRAM2BRAM.scala 268:46]
  wire [7:0] _GEN_632 = 3'h3 == _T_210[2:0] ? _GEN_275 : _GEN_616; // @[DRAM2BRAM.scala 268:46 DRAM2BRAM.scala 268:46]
  wire [7:0] _GEN_633 = 3'h4 == _T_210[2:0] ? _GEN_275 : _GEN_617; // @[DRAM2BRAM.scala 268:46 DRAM2BRAM.scala 268:46]
  wire [7:0] _GEN_634 = 3'h5 == _T_210[2:0] ? _GEN_275 : _GEN_618; // @[DRAM2BRAM.scala 268:46 DRAM2BRAM.scala 268:46]
  wire [7:0] _GEN_635 = 3'h6 == _T_210[2:0] ? _GEN_275 : _GEN_619; // @[DRAM2BRAM.scala 268:46 DRAM2BRAM.scala 268:46]
  wire [7:0] _GEN_636 = 3'h7 == _T_210[2:0] ? _GEN_275 : _GEN_620; // @[DRAM2BRAM.scala 268:46 DRAM2BRAM.scala 268:46]
  wire [5:0] _GEN_637 = 4'h5 >= _T_162 ? _GEN_621 : _GEN_605; // @[DRAM2BRAM.scala 267:34]
  wire [5:0] _GEN_638 = 4'h5 >= _T_162 ? _GEN_622 : _GEN_606; // @[DRAM2BRAM.scala 267:34]
  wire [5:0] _GEN_639 = 4'h5 >= _T_162 ? _GEN_623 : _GEN_607; // @[DRAM2BRAM.scala 267:34]
  wire [5:0] _GEN_640 = 4'h5 >= _T_162 ? _GEN_624 : _GEN_608; // @[DRAM2BRAM.scala 267:34]
  wire [5:0] _GEN_641 = 4'h5 >= _T_162 ? _GEN_625 : _GEN_609; // @[DRAM2BRAM.scala 267:34]
  wire [5:0] _GEN_642 = 4'h5 >= _T_162 ? _GEN_626 : _GEN_610; // @[DRAM2BRAM.scala 267:34]
  wire [5:0] _GEN_643 = 4'h5 >= _T_162 ? _GEN_627 : _GEN_611; // @[DRAM2BRAM.scala 267:34]
  wire [5:0] _GEN_644 = 4'h5 >= _T_162 ? _GEN_628 : _GEN_612; // @[DRAM2BRAM.scala 267:34]
  wire [7:0] _GEN_645 = 4'h5 >= _T_162 ? _GEN_629 : _GEN_613; // @[DRAM2BRAM.scala 267:34]
  wire [7:0] _GEN_646 = 4'h5 >= _T_162 ? _GEN_630 : _GEN_614; // @[DRAM2BRAM.scala 267:34]
  wire [7:0] _GEN_647 = 4'h5 >= _T_162 ? _GEN_631 : _GEN_615; // @[DRAM2BRAM.scala 267:34]
  wire [7:0] _GEN_648 = 4'h5 >= _T_162 ? _GEN_632 : _GEN_616; // @[DRAM2BRAM.scala 267:34]
  wire [7:0] _GEN_649 = 4'h5 >= _T_162 ? _GEN_633 : _GEN_617; // @[DRAM2BRAM.scala 267:34]
  wire [7:0] _GEN_650 = 4'h5 >= _T_162 ? _GEN_634 : _GEN_618; // @[DRAM2BRAM.scala 267:34]
  wire [7:0] _GEN_651 = 4'h5 >= _T_162 ? _GEN_635 : _GEN_619; // @[DRAM2BRAM.scala 267:34]
  wire [7:0] _GEN_652 = 4'h5 >= _T_162 ? _GEN_636 : _GEN_620; // @[DRAM2BRAM.scala 267:34]
  wire [3:0] _T_214 = 4'h6 - _T_162; // @[DRAM2BRAM.scala 268:34]
  wire [5:0] _GEN_653 = 3'h0 == _T_214[2:0] ? _GEN_268 : _GEN_637; // @[DRAM2BRAM.scala 268:46 DRAM2BRAM.scala 268:46]
  wire [5:0] _GEN_654 = 3'h1 == _T_214[2:0] ? _GEN_268 : _GEN_638; // @[DRAM2BRAM.scala 268:46 DRAM2BRAM.scala 268:46]
  wire [5:0] _GEN_655 = 3'h2 == _T_214[2:0] ? _GEN_268 : _GEN_639; // @[DRAM2BRAM.scala 268:46 DRAM2BRAM.scala 268:46]
  wire [5:0] _GEN_656 = 3'h3 == _T_214[2:0] ? _GEN_268 : _GEN_640; // @[DRAM2BRAM.scala 268:46 DRAM2BRAM.scala 268:46]
  wire [5:0] _GEN_657 = 3'h4 == _T_214[2:0] ? _GEN_268 : _GEN_641; // @[DRAM2BRAM.scala 268:46 DRAM2BRAM.scala 268:46]
  wire [5:0] _GEN_658 = 3'h5 == _T_214[2:0] ? _GEN_268 : _GEN_642; // @[DRAM2BRAM.scala 268:46 DRAM2BRAM.scala 268:46]
  wire [5:0] _GEN_659 = 3'h6 == _T_214[2:0] ? _GEN_268 : _GEN_643; // @[DRAM2BRAM.scala 268:46 DRAM2BRAM.scala 268:46]
  wire [5:0] _GEN_660 = 3'h7 == _T_214[2:0] ? _GEN_268 : _GEN_644; // @[DRAM2BRAM.scala 268:46 DRAM2BRAM.scala 268:46]
  wire [7:0] _GEN_661 = 3'h0 == _T_214[2:0] ? _GEN_276 : _GEN_645; // @[DRAM2BRAM.scala 268:46 DRAM2BRAM.scala 268:46]
  wire [7:0] _GEN_662 = 3'h1 == _T_214[2:0] ? _GEN_276 : _GEN_646; // @[DRAM2BRAM.scala 268:46 DRAM2BRAM.scala 268:46]
  wire [7:0] _GEN_663 = 3'h2 == _T_214[2:0] ? _GEN_276 : _GEN_647; // @[DRAM2BRAM.scala 268:46 DRAM2BRAM.scala 268:46]
  wire [7:0] _GEN_664 = 3'h3 == _T_214[2:0] ? _GEN_276 : _GEN_648; // @[DRAM2BRAM.scala 268:46 DRAM2BRAM.scala 268:46]
  wire [7:0] _GEN_665 = 3'h4 == _T_214[2:0] ? _GEN_276 : _GEN_649; // @[DRAM2BRAM.scala 268:46 DRAM2BRAM.scala 268:46]
  wire [7:0] _GEN_666 = 3'h5 == _T_214[2:0] ? _GEN_276 : _GEN_650; // @[DRAM2BRAM.scala 268:46 DRAM2BRAM.scala 268:46]
  wire [7:0] _GEN_667 = 3'h6 == _T_214[2:0] ? _GEN_276 : _GEN_651; // @[DRAM2BRAM.scala 268:46 DRAM2BRAM.scala 268:46]
  wire [7:0] _GEN_668 = 3'h7 == _T_214[2:0] ? _GEN_276 : _GEN_652; // @[DRAM2BRAM.scala 268:46 DRAM2BRAM.scala 268:46]
  wire [5:0] _GEN_669 = 4'h6 >= _T_162 ? _GEN_653 : _GEN_637; // @[DRAM2BRAM.scala 267:34]
  wire [5:0] _GEN_670 = 4'h6 >= _T_162 ? _GEN_654 : _GEN_638; // @[DRAM2BRAM.scala 267:34]
  wire [5:0] _GEN_671 = 4'h6 >= _T_162 ? _GEN_655 : _GEN_639; // @[DRAM2BRAM.scala 267:34]
  wire [5:0] _GEN_672 = 4'h6 >= _T_162 ? _GEN_656 : _GEN_640; // @[DRAM2BRAM.scala 267:34]
  wire [5:0] _GEN_673 = 4'h6 >= _T_162 ? _GEN_657 : _GEN_641; // @[DRAM2BRAM.scala 267:34]
  wire [5:0] _GEN_674 = 4'h6 >= _T_162 ? _GEN_658 : _GEN_642; // @[DRAM2BRAM.scala 267:34]
  wire [5:0] _GEN_675 = 4'h6 >= _T_162 ? _GEN_659 : _GEN_643; // @[DRAM2BRAM.scala 267:34]
  wire [5:0] _GEN_676 = 4'h6 >= _T_162 ? _GEN_660 : _GEN_644; // @[DRAM2BRAM.scala 267:34]
  wire [7:0] _GEN_677 = 4'h6 >= _T_162 ? _GEN_661 : _GEN_645; // @[DRAM2BRAM.scala 267:34]
  wire [7:0] _GEN_678 = 4'h6 >= _T_162 ? _GEN_662 : _GEN_646; // @[DRAM2BRAM.scala 267:34]
  wire [7:0] _GEN_679 = 4'h6 >= _T_162 ? _GEN_663 : _GEN_647; // @[DRAM2BRAM.scala 267:34]
  wire [7:0] _GEN_680 = 4'h6 >= _T_162 ? _GEN_664 : _GEN_648; // @[DRAM2BRAM.scala 267:34]
  wire [7:0] _GEN_681 = 4'h6 >= _T_162 ? _GEN_665 : _GEN_649; // @[DRAM2BRAM.scala 267:34]
  wire [7:0] _GEN_682 = 4'h6 >= _T_162 ? _GEN_666 : _GEN_650; // @[DRAM2BRAM.scala 267:34]
  wire [7:0] _GEN_683 = 4'h6 >= _T_162 ? _GEN_667 : _GEN_651; // @[DRAM2BRAM.scala 267:34]
  wire [7:0] _GEN_684 = 4'h6 >= _T_162 ? _GEN_668 : _GEN_652; // @[DRAM2BRAM.scala 267:34]
  wire [3:0] _T_218 = 4'h7 - _T_162; // @[DRAM2BRAM.scala 268:34]
  wire [5:0] _GEN_685 = 3'h0 == _T_218[2:0] ? _GEN_269 : _GEN_669; // @[DRAM2BRAM.scala 268:46 DRAM2BRAM.scala 268:46]
  wire [5:0] _GEN_686 = 3'h1 == _T_218[2:0] ? _GEN_269 : _GEN_670; // @[DRAM2BRAM.scala 268:46 DRAM2BRAM.scala 268:46]
  wire [5:0] _GEN_687 = 3'h2 == _T_218[2:0] ? _GEN_269 : _GEN_671; // @[DRAM2BRAM.scala 268:46 DRAM2BRAM.scala 268:46]
  wire [5:0] _GEN_688 = 3'h3 == _T_218[2:0] ? _GEN_269 : _GEN_672; // @[DRAM2BRAM.scala 268:46 DRAM2BRAM.scala 268:46]
  wire [5:0] _GEN_689 = 3'h4 == _T_218[2:0] ? _GEN_269 : _GEN_673; // @[DRAM2BRAM.scala 268:46 DRAM2BRAM.scala 268:46]
  wire [5:0] _GEN_690 = 3'h5 == _T_218[2:0] ? _GEN_269 : _GEN_674; // @[DRAM2BRAM.scala 268:46 DRAM2BRAM.scala 268:46]
  wire [5:0] _GEN_691 = 3'h6 == _T_218[2:0] ? _GEN_269 : _GEN_675; // @[DRAM2BRAM.scala 268:46 DRAM2BRAM.scala 268:46]
  wire [5:0] _GEN_692 = 3'h7 == _T_218[2:0] ? _GEN_269 : _GEN_676; // @[DRAM2BRAM.scala 268:46 DRAM2BRAM.scala 268:46]
  wire [7:0] _GEN_693 = 3'h0 == _T_218[2:0] ? _GEN_277 : _GEN_677; // @[DRAM2BRAM.scala 268:46 DRAM2BRAM.scala 268:46]
  wire [7:0] _GEN_694 = 3'h1 == _T_218[2:0] ? _GEN_277 : _GEN_678; // @[DRAM2BRAM.scala 268:46 DRAM2BRAM.scala 268:46]
  wire [7:0] _GEN_695 = 3'h2 == _T_218[2:0] ? _GEN_277 : _GEN_679; // @[DRAM2BRAM.scala 268:46 DRAM2BRAM.scala 268:46]
  wire [7:0] _GEN_696 = 3'h3 == _T_218[2:0] ? _GEN_277 : _GEN_680; // @[DRAM2BRAM.scala 268:46 DRAM2BRAM.scala 268:46]
  wire [7:0] _GEN_697 = 3'h4 == _T_218[2:0] ? _GEN_277 : _GEN_681; // @[DRAM2BRAM.scala 268:46 DRAM2BRAM.scala 268:46]
  wire [7:0] _GEN_698 = 3'h5 == _T_218[2:0] ? _GEN_277 : _GEN_682; // @[DRAM2BRAM.scala 268:46 DRAM2BRAM.scala 268:46]
  wire [7:0] _GEN_699 = 3'h6 == _T_218[2:0] ? _GEN_277 : _GEN_683; // @[DRAM2BRAM.scala 268:46 DRAM2BRAM.scala 268:46]
  wire [7:0] _GEN_700 = 3'h7 == _T_218[2:0] ? _GEN_277 : _GEN_684; // @[DRAM2BRAM.scala 268:46 DRAM2BRAM.scala 268:46]
  wire [5:0] _GEN_701 = 4'h7 >= _T_162 ? _GEN_685 : _GEN_669; // @[DRAM2BRAM.scala 267:34]
  wire [5:0] _GEN_702 = 4'h7 >= _T_162 ? _GEN_686 : _GEN_670; // @[DRAM2BRAM.scala 267:34]
  wire [5:0] _GEN_703 = 4'h7 >= _T_162 ? _GEN_687 : _GEN_671; // @[DRAM2BRAM.scala 267:34]
  wire [5:0] _GEN_704 = 4'h7 >= _T_162 ? _GEN_688 : _GEN_672; // @[DRAM2BRAM.scala 267:34]
  wire [5:0] _GEN_705 = 4'h7 >= _T_162 ? _GEN_689 : _GEN_673; // @[DRAM2BRAM.scala 267:34]
  wire [5:0] _GEN_706 = 4'h7 >= _T_162 ? _GEN_690 : _GEN_674; // @[DRAM2BRAM.scala 267:34]
  wire [5:0] _GEN_707 = 4'h7 >= _T_162 ? _GEN_691 : _GEN_675; // @[DRAM2BRAM.scala 267:34]
  wire [5:0] _GEN_708 = 4'h7 >= _T_162 ? _GEN_692 : _GEN_676; // @[DRAM2BRAM.scala 267:34]
  wire [7:0] _GEN_709 = 4'h7 >= _T_162 ? _GEN_693 : _GEN_677; // @[DRAM2BRAM.scala 267:34]
  wire [7:0] _GEN_710 = 4'h7 >= _T_162 ? _GEN_694 : _GEN_678; // @[DRAM2BRAM.scala 267:34]
  wire [7:0] _GEN_711 = 4'h7 >= _T_162 ? _GEN_695 : _GEN_679; // @[DRAM2BRAM.scala 267:34]
  wire [7:0] _GEN_712 = 4'h7 >= _T_162 ? _GEN_696 : _GEN_680; // @[DRAM2BRAM.scala 267:34]
  wire [7:0] _GEN_713 = 4'h7 >= _T_162 ? _GEN_697 : _GEN_681; // @[DRAM2BRAM.scala 267:34]
  wire [7:0] _GEN_714 = 4'h7 >= _T_162 ? _GEN_698 : _GEN_682; // @[DRAM2BRAM.scala 267:34]
  wire [7:0] _GEN_715 = 4'h7 >= _T_162 ? _GEN_699 : _GEN_683; // @[DRAM2BRAM.scala 267:34]
  wire [7:0] _GEN_716 = 4'h7 >= _T_162 ? _GEN_700 : _GEN_684; // @[DRAM2BRAM.scala 267:34]
  wire [3:0] _lo_T_1 = _T_123 - _T_162; // @[DRAM2BRAM.scala 272:31]
  wire [8:0] _T_221 = regBramRowCnt + 9'h1; // @[DRAM2BRAM.scala 273:42]
  wire [5:0] _GEN_717 = ~rowFinished & ~newRowStarted ? _T_156 : _GEN_316; // @[DRAM2BRAM.scala 276:49 DRAM2BRAM.scala 277:36]
  wire [1:0] _GEN_718 = rowFinished & _T_151 ? 2'h2 : regState; // @[DRAM2BRAM.scala 281:56 DRAM2BRAM.scala 282:22 DRAM2BRAM.scala 117:25]
  wire  _T_230 = regElCnt > 3'h0; // @[DRAM2BRAM.scala 285:65]
  wire  _T_232 = rowFinished & (_T_150 | regElCnt > 3'h0); // @[DRAM2BRAM.scala 285:32]
  wire [5:0] _GEN_863 = 3'h0 == _GEN_1345[2:0] ? _GEN_262 : regBramLine_els_0_col; // @[DRAM2BRAM.scala 312:47 DRAM2BRAM.scala 312:47 DRAM2BRAM.scala 118:28]
  wire [5:0] _GEN_864 = 3'h1 == _GEN_1345[2:0] ? _GEN_262 : regBramLine_els_1_col; // @[DRAM2BRAM.scala 312:47 DRAM2BRAM.scala 312:47 DRAM2BRAM.scala 118:28]
  wire [5:0] _GEN_865 = 3'h2 == _GEN_1345[2:0] ? _GEN_262 : regBramLine_els_2_col; // @[DRAM2BRAM.scala 312:47 DRAM2BRAM.scala 312:47 DRAM2BRAM.scala 118:28]
  wire [5:0] _GEN_866 = 3'h3 == _GEN_1345[2:0] ? _GEN_262 : regBramLine_els_3_col; // @[DRAM2BRAM.scala 312:47 DRAM2BRAM.scala 312:47 DRAM2BRAM.scala 118:28]
  wire [5:0] _GEN_867 = 3'h4 == _GEN_1345[2:0] ? _GEN_262 : regBramLine_els_4_col; // @[DRAM2BRAM.scala 312:47 DRAM2BRAM.scala 312:47 DRAM2BRAM.scala 118:28]
  wire [5:0] _GEN_868 = 3'h5 == _GEN_1345[2:0] ? _GEN_262 : regBramLine_els_5_col; // @[DRAM2BRAM.scala 312:47 DRAM2BRAM.scala 312:47 DRAM2BRAM.scala 118:28]
  wire [5:0] _GEN_869 = 3'h6 == _GEN_1345[2:0] ? _GEN_262 : regBramLine_els_6_col; // @[DRAM2BRAM.scala 312:47 DRAM2BRAM.scala 312:47 DRAM2BRAM.scala 118:28]
  wire [5:0] _GEN_870 = 3'h7 == _GEN_1345[2:0] ? _GEN_262 : regBramLine_els_7_col; // @[DRAM2BRAM.scala 312:47 DRAM2BRAM.scala 312:47 DRAM2BRAM.scala 118:28]
  wire [7:0] _GEN_871 = 3'h0 == _GEN_1345[2:0] ? _GEN_270 : regBramLine_els_0_value; // @[DRAM2BRAM.scala 312:47 DRAM2BRAM.scala 312:47 DRAM2BRAM.scala 118:28]
  wire [7:0] _GEN_872 = 3'h1 == _GEN_1345[2:0] ? _GEN_270 : regBramLine_els_1_value; // @[DRAM2BRAM.scala 312:47 DRAM2BRAM.scala 312:47 DRAM2BRAM.scala 118:28]
  wire [7:0] _GEN_873 = 3'h2 == _GEN_1345[2:0] ? _GEN_270 : regBramLine_els_2_value; // @[DRAM2BRAM.scala 312:47 DRAM2BRAM.scala 312:47 DRAM2BRAM.scala 118:28]
  wire [7:0] _GEN_874 = 3'h3 == _GEN_1345[2:0] ? _GEN_270 : regBramLine_els_3_value; // @[DRAM2BRAM.scala 312:47 DRAM2BRAM.scala 312:47 DRAM2BRAM.scala 118:28]
  wire [7:0] _GEN_875 = 3'h4 == _GEN_1345[2:0] ? _GEN_270 : regBramLine_els_4_value; // @[DRAM2BRAM.scala 312:47 DRAM2BRAM.scala 312:47 DRAM2BRAM.scala 118:28]
  wire [7:0] _GEN_876 = 3'h5 == _GEN_1345[2:0] ? _GEN_270 : regBramLine_els_5_value; // @[DRAM2BRAM.scala 312:47 DRAM2BRAM.scala 312:47 DRAM2BRAM.scala 118:28]
  wire [7:0] _GEN_877 = 3'h6 == _GEN_1345[2:0] ? _GEN_270 : regBramLine_els_6_value; // @[DRAM2BRAM.scala 312:47 DRAM2BRAM.scala 312:47 DRAM2BRAM.scala 118:28]
  wire [7:0] _GEN_878 = 3'h7 == _GEN_1345[2:0] ? _GEN_270 : regBramLine_els_7_value; // @[DRAM2BRAM.scala 312:47 DRAM2BRAM.scala 312:47 DRAM2BRAM.scala 118:28]
  wire [5:0] _GEN_879 = 4'h0 < _T_123 ? _GEN_863 : regBramLine_els_0_col; // @[DRAM2BRAM.scala 311:33 DRAM2BRAM.scala 118:28]
  wire [5:0] _GEN_880 = 4'h0 < _T_123 ? _GEN_864 : regBramLine_els_1_col; // @[DRAM2BRAM.scala 311:33 DRAM2BRAM.scala 118:28]
  wire [5:0] _GEN_881 = 4'h0 < _T_123 ? _GEN_865 : regBramLine_els_2_col; // @[DRAM2BRAM.scala 311:33 DRAM2BRAM.scala 118:28]
  wire [5:0] _GEN_882 = 4'h0 < _T_123 ? _GEN_866 : regBramLine_els_3_col; // @[DRAM2BRAM.scala 311:33 DRAM2BRAM.scala 118:28]
  wire [5:0] _GEN_883 = 4'h0 < _T_123 ? _GEN_867 : regBramLine_els_4_col; // @[DRAM2BRAM.scala 311:33 DRAM2BRAM.scala 118:28]
  wire [5:0] _GEN_884 = 4'h0 < _T_123 ? _GEN_868 : regBramLine_els_5_col; // @[DRAM2BRAM.scala 311:33 DRAM2BRAM.scala 118:28]
  wire [5:0] _GEN_885 = 4'h0 < _T_123 ? _GEN_869 : regBramLine_els_6_col; // @[DRAM2BRAM.scala 311:33 DRAM2BRAM.scala 118:28]
  wire [5:0] _GEN_886 = 4'h0 < _T_123 ? _GEN_870 : regBramLine_els_7_col; // @[DRAM2BRAM.scala 311:33 DRAM2BRAM.scala 118:28]
  wire [7:0] _GEN_887 = 4'h0 < _T_123 ? _GEN_871 : regBramLine_els_0_value; // @[DRAM2BRAM.scala 311:33 DRAM2BRAM.scala 118:28]
  wire [7:0] _GEN_888 = 4'h0 < _T_123 ? _GEN_872 : regBramLine_els_1_value; // @[DRAM2BRAM.scala 311:33 DRAM2BRAM.scala 118:28]
  wire [7:0] _GEN_889 = 4'h0 < _T_123 ? _GEN_873 : regBramLine_els_2_value; // @[DRAM2BRAM.scala 311:33 DRAM2BRAM.scala 118:28]
  wire [7:0] _GEN_890 = 4'h0 < _T_123 ? _GEN_874 : regBramLine_els_3_value; // @[DRAM2BRAM.scala 311:33 DRAM2BRAM.scala 118:28]
  wire [7:0] _GEN_891 = 4'h0 < _T_123 ? _GEN_875 : regBramLine_els_4_value; // @[DRAM2BRAM.scala 311:33 DRAM2BRAM.scala 118:28]
  wire [7:0] _GEN_892 = 4'h0 < _T_123 ? _GEN_876 : regBramLine_els_5_value; // @[DRAM2BRAM.scala 311:33 DRAM2BRAM.scala 118:28]
  wire [7:0] _GEN_893 = 4'h0 < _T_123 ? _GEN_877 : regBramLine_els_6_value; // @[DRAM2BRAM.scala 311:33 DRAM2BRAM.scala 118:28]
  wire [7:0] _GEN_894 = 4'h0 < _T_123 ? _GEN_878 : regBramLine_els_7_value; // @[DRAM2BRAM.scala 311:33 DRAM2BRAM.scala 118:28]
  wire [2:0] _T_265 = regElCnt + 3'h1; // @[DRAM2BRAM.scala 312:40]
  wire [5:0] _GEN_895 = 3'h0 == _T_265 ? _GEN_263 : _GEN_879; // @[DRAM2BRAM.scala 312:47 DRAM2BRAM.scala 312:47]
  wire [5:0] _GEN_896 = 3'h1 == _T_265 ? _GEN_263 : _GEN_880; // @[DRAM2BRAM.scala 312:47 DRAM2BRAM.scala 312:47]
  wire [5:0] _GEN_897 = 3'h2 == _T_265 ? _GEN_263 : _GEN_881; // @[DRAM2BRAM.scala 312:47 DRAM2BRAM.scala 312:47]
  wire [5:0] _GEN_898 = 3'h3 == _T_265 ? _GEN_263 : _GEN_882; // @[DRAM2BRAM.scala 312:47 DRAM2BRAM.scala 312:47]
  wire [5:0] _GEN_899 = 3'h4 == _T_265 ? _GEN_263 : _GEN_883; // @[DRAM2BRAM.scala 312:47 DRAM2BRAM.scala 312:47]
  wire [5:0] _GEN_900 = 3'h5 == _T_265 ? _GEN_263 : _GEN_884; // @[DRAM2BRAM.scala 312:47 DRAM2BRAM.scala 312:47]
  wire [5:0] _GEN_901 = 3'h6 == _T_265 ? _GEN_263 : _GEN_885; // @[DRAM2BRAM.scala 312:47 DRAM2BRAM.scala 312:47]
  wire [5:0] _GEN_902 = 3'h7 == _T_265 ? _GEN_263 : _GEN_886; // @[DRAM2BRAM.scala 312:47 DRAM2BRAM.scala 312:47]
  wire [7:0] _GEN_903 = 3'h0 == _T_265 ? _GEN_271 : _GEN_887; // @[DRAM2BRAM.scala 312:47 DRAM2BRAM.scala 312:47]
  wire [7:0] _GEN_904 = 3'h1 == _T_265 ? _GEN_271 : _GEN_888; // @[DRAM2BRAM.scala 312:47 DRAM2BRAM.scala 312:47]
  wire [7:0] _GEN_905 = 3'h2 == _T_265 ? _GEN_271 : _GEN_889; // @[DRAM2BRAM.scala 312:47 DRAM2BRAM.scala 312:47]
  wire [7:0] _GEN_906 = 3'h3 == _T_265 ? _GEN_271 : _GEN_890; // @[DRAM2BRAM.scala 312:47 DRAM2BRAM.scala 312:47]
  wire [7:0] _GEN_907 = 3'h4 == _T_265 ? _GEN_271 : _GEN_891; // @[DRAM2BRAM.scala 312:47 DRAM2BRAM.scala 312:47]
  wire [7:0] _GEN_908 = 3'h5 == _T_265 ? _GEN_271 : _GEN_892; // @[DRAM2BRAM.scala 312:47 DRAM2BRAM.scala 312:47]
  wire [7:0] _GEN_909 = 3'h6 == _T_265 ? _GEN_271 : _GEN_893; // @[DRAM2BRAM.scala 312:47 DRAM2BRAM.scala 312:47]
  wire [7:0] _GEN_910 = 3'h7 == _T_265 ? _GEN_271 : _GEN_894; // @[DRAM2BRAM.scala 312:47 DRAM2BRAM.scala 312:47]
  wire [5:0] _GEN_911 = 4'h1 < _T_123 ? _GEN_895 : _GEN_879; // @[DRAM2BRAM.scala 311:33]
  wire [5:0] _GEN_912 = 4'h1 < _T_123 ? _GEN_896 : _GEN_880; // @[DRAM2BRAM.scala 311:33]
  wire [5:0] _GEN_913 = 4'h1 < _T_123 ? _GEN_897 : _GEN_881; // @[DRAM2BRAM.scala 311:33]
  wire [5:0] _GEN_914 = 4'h1 < _T_123 ? _GEN_898 : _GEN_882; // @[DRAM2BRAM.scala 311:33]
  wire [5:0] _GEN_915 = 4'h1 < _T_123 ? _GEN_899 : _GEN_883; // @[DRAM2BRAM.scala 311:33]
  wire [5:0] _GEN_916 = 4'h1 < _T_123 ? _GEN_900 : _GEN_884; // @[DRAM2BRAM.scala 311:33]
  wire [5:0] _GEN_917 = 4'h1 < _T_123 ? _GEN_901 : _GEN_885; // @[DRAM2BRAM.scala 311:33]
  wire [5:0] _GEN_918 = 4'h1 < _T_123 ? _GEN_902 : _GEN_886; // @[DRAM2BRAM.scala 311:33]
  wire [7:0] _GEN_919 = 4'h1 < _T_123 ? _GEN_903 : _GEN_887; // @[DRAM2BRAM.scala 311:33]
  wire [7:0] _GEN_920 = 4'h1 < _T_123 ? _GEN_904 : _GEN_888; // @[DRAM2BRAM.scala 311:33]
  wire [7:0] _GEN_921 = 4'h1 < _T_123 ? _GEN_905 : _GEN_889; // @[DRAM2BRAM.scala 311:33]
  wire [7:0] _GEN_922 = 4'h1 < _T_123 ? _GEN_906 : _GEN_890; // @[DRAM2BRAM.scala 311:33]
  wire [7:0] _GEN_923 = 4'h1 < _T_123 ? _GEN_907 : _GEN_891; // @[DRAM2BRAM.scala 311:33]
  wire [7:0] _GEN_924 = 4'h1 < _T_123 ? _GEN_908 : _GEN_892; // @[DRAM2BRAM.scala 311:33]
  wire [7:0] _GEN_925 = 4'h1 < _T_123 ? _GEN_909 : _GEN_893; // @[DRAM2BRAM.scala 311:33]
  wire [7:0] _GEN_926 = 4'h1 < _T_123 ? _GEN_910 : _GEN_894; // @[DRAM2BRAM.scala 311:33]
  wire [2:0] _T_268 = regElCnt + 3'h2; // @[DRAM2BRAM.scala 312:40]
  wire [5:0] _GEN_927 = 3'h0 == _T_268 ? _GEN_264 : _GEN_911; // @[DRAM2BRAM.scala 312:47 DRAM2BRAM.scala 312:47]
  wire [5:0] _GEN_928 = 3'h1 == _T_268 ? _GEN_264 : _GEN_912; // @[DRAM2BRAM.scala 312:47 DRAM2BRAM.scala 312:47]
  wire [5:0] _GEN_929 = 3'h2 == _T_268 ? _GEN_264 : _GEN_913; // @[DRAM2BRAM.scala 312:47 DRAM2BRAM.scala 312:47]
  wire [5:0] _GEN_930 = 3'h3 == _T_268 ? _GEN_264 : _GEN_914; // @[DRAM2BRAM.scala 312:47 DRAM2BRAM.scala 312:47]
  wire [5:0] _GEN_931 = 3'h4 == _T_268 ? _GEN_264 : _GEN_915; // @[DRAM2BRAM.scala 312:47 DRAM2BRAM.scala 312:47]
  wire [5:0] _GEN_932 = 3'h5 == _T_268 ? _GEN_264 : _GEN_916; // @[DRAM2BRAM.scala 312:47 DRAM2BRAM.scala 312:47]
  wire [5:0] _GEN_933 = 3'h6 == _T_268 ? _GEN_264 : _GEN_917; // @[DRAM2BRAM.scala 312:47 DRAM2BRAM.scala 312:47]
  wire [5:0] _GEN_934 = 3'h7 == _T_268 ? _GEN_264 : _GEN_918; // @[DRAM2BRAM.scala 312:47 DRAM2BRAM.scala 312:47]
  wire [7:0] _GEN_935 = 3'h0 == _T_268 ? _GEN_272 : _GEN_919; // @[DRAM2BRAM.scala 312:47 DRAM2BRAM.scala 312:47]
  wire [7:0] _GEN_936 = 3'h1 == _T_268 ? _GEN_272 : _GEN_920; // @[DRAM2BRAM.scala 312:47 DRAM2BRAM.scala 312:47]
  wire [7:0] _GEN_937 = 3'h2 == _T_268 ? _GEN_272 : _GEN_921; // @[DRAM2BRAM.scala 312:47 DRAM2BRAM.scala 312:47]
  wire [7:0] _GEN_938 = 3'h3 == _T_268 ? _GEN_272 : _GEN_922; // @[DRAM2BRAM.scala 312:47 DRAM2BRAM.scala 312:47]
  wire [7:0] _GEN_939 = 3'h4 == _T_268 ? _GEN_272 : _GEN_923; // @[DRAM2BRAM.scala 312:47 DRAM2BRAM.scala 312:47]
  wire [7:0] _GEN_940 = 3'h5 == _T_268 ? _GEN_272 : _GEN_924; // @[DRAM2BRAM.scala 312:47 DRAM2BRAM.scala 312:47]
  wire [7:0] _GEN_941 = 3'h6 == _T_268 ? _GEN_272 : _GEN_925; // @[DRAM2BRAM.scala 312:47 DRAM2BRAM.scala 312:47]
  wire [7:0] _GEN_942 = 3'h7 == _T_268 ? _GEN_272 : _GEN_926; // @[DRAM2BRAM.scala 312:47 DRAM2BRAM.scala 312:47]
  wire [5:0] _GEN_943 = 4'h2 < _T_123 ? _GEN_927 : _GEN_911; // @[DRAM2BRAM.scala 311:33]
  wire [5:0] _GEN_944 = 4'h2 < _T_123 ? _GEN_928 : _GEN_912; // @[DRAM2BRAM.scala 311:33]
  wire [5:0] _GEN_945 = 4'h2 < _T_123 ? _GEN_929 : _GEN_913; // @[DRAM2BRAM.scala 311:33]
  wire [5:0] _GEN_946 = 4'h2 < _T_123 ? _GEN_930 : _GEN_914; // @[DRAM2BRAM.scala 311:33]
  wire [5:0] _GEN_947 = 4'h2 < _T_123 ? _GEN_931 : _GEN_915; // @[DRAM2BRAM.scala 311:33]
  wire [5:0] _GEN_948 = 4'h2 < _T_123 ? _GEN_932 : _GEN_916; // @[DRAM2BRAM.scala 311:33]
  wire [5:0] _GEN_949 = 4'h2 < _T_123 ? _GEN_933 : _GEN_917; // @[DRAM2BRAM.scala 311:33]
  wire [5:0] _GEN_950 = 4'h2 < _T_123 ? _GEN_934 : _GEN_918; // @[DRAM2BRAM.scala 311:33]
  wire [7:0] _GEN_951 = 4'h2 < _T_123 ? _GEN_935 : _GEN_919; // @[DRAM2BRAM.scala 311:33]
  wire [7:0] _GEN_952 = 4'h2 < _T_123 ? _GEN_936 : _GEN_920; // @[DRAM2BRAM.scala 311:33]
  wire [7:0] _GEN_953 = 4'h2 < _T_123 ? _GEN_937 : _GEN_921; // @[DRAM2BRAM.scala 311:33]
  wire [7:0] _GEN_954 = 4'h2 < _T_123 ? _GEN_938 : _GEN_922; // @[DRAM2BRAM.scala 311:33]
  wire [7:0] _GEN_955 = 4'h2 < _T_123 ? _GEN_939 : _GEN_923; // @[DRAM2BRAM.scala 311:33]
  wire [7:0] _GEN_956 = 4'h2 < _T_123 ? _GEN_940 : _GEN_924; // @[DRAM2BRAM.scala 311:33]
  wire [7:0] _GEN_957 = 4'h2 < _T_123 ? _GEN_941 : _GEN_925; // @[DRAM2BRAM.scala 311:33]
  wire [7:0] _GEN_958 = 4'h2 < _T_123 ? _GEN_942 : _GEN_926; // @[DRAM2BRAM.scala 311:33]
  wire [2:0] _T_271 = regElCnt + 3'h3; // @[DRAM2BRAM.scala 312:40]
  wire [5:0] _GEN_959 = 3'h0 == _T_271 ? _GEN_265 : _GEN_943; // @[DRAM2BRAM.scala 312:47 DRAM2BRAM.scala 312:47]
  wire [5:0] _GEN_960 = 3'h1 == _T_271 ? _GEN_265 : _GEN_944; // @[DRAM2BRAM.scala 312:47 DRAM2BRAM.scala 312:47]
  wire [5:0] _GEN_961 = 3'h2 == _T_271 ? _GEN_265 : _GEN_945; // @[DRAM2BRAM.scala 312:47 DRAM2BRAM.scala 312:47]
  wire [5:0] _GEN_962 = 3'h3 == _T_271 ? _GEN_265 : _GEN_946; // @[DRAM2BRAM.scala 312:47 DRAM2BRAM.scala 312:47]
  wire [5:0] _GEN_963 = 3'h4 == _T_271 ? _GEN_265 : _GEN_947; // @[DRAM2BRAM.scala 312:47 DRAM2BRAM.scala 312:47]
  wire [5:0] _GEN_964 = 3'h5 == _T_271 ? _GEN_265 : _GEN_948; // @[DRAM2BRAM.scala 312:47 DRAM2BRAM.scala 312:47]
  wire [5:0] _GEN_965 = 3'h6 == _T_271 ? _GEN_265 : _GEN_949; // @[DRAM2BRAM.scala 312:47 DRAM2BRAM.scala 312:47]
  wire [5:0] _GEN_966 = 3'h7 == _T_271 ? _GEN_265 : _GEN_950; // @[DRAM2BRAM.scala 312:47 DRAM2BRAM.scala 312:47]
  wire [7:0] _GEN_967 = 3'h0 == _T_271 ? _GEN_273 : _GEN_951; // @[DRAM2BRAM.scala 312:47 DRAM2BRAM.scala 312:47]
  wire [7:0] _GEN_968 = 3'h1 == _T_271 ? _GEN_273 : _GEN_952; // @[DRAM2BRAM.scala 312:47 DRAM2BRAM.scala 312:47]
  wire [7:0] _GEN_969 = 3'h2 == _T_271 ? _GEN_273 : _GEN_953; // @[DRAM2BRAM.scala 312:47 DRAM2BRAM.scala 312:47]
  wire [7:0] _GEN_970 = 3'h3 == _T_271 ? _GEN_273 : _GEN_954; // @[DRAM2BRAM.scala 312:47 DRAM2BRAM.scala 312:47]
  wire [7:0] _GEN_971 = 3'h4 == _T_271 ? _GEN_273 : _GEN_955; // @[DRAM2BRAM.scala 312:47 DRAM2BRAM.scala 312:47]
  wire [7:0] _GEN_972 = 3'h5 == _T_271 ? _GEN_273 : _GEN_956; // @[DRAM2BRAM.scala 312:47 DRAM2BRAM.scala 312:47]
  wire [7:0] _GEN_973 = 3'h6 == _T_271 ? _GEN_273 : _GEN_957; // @[DRAM2BRAM.scala 312:47 DRAM2BRAM.scala 312:47]
  wire [7:0] _GEN_974 = 3'h7 == _T_271 ? _GEN_273 : _GEN_958; // @[DRAM2BRAM.scala 312:47 DRAM2BRAM.scala 312:47]
  wire [5:0] _GEN_975 = 4'h3 < _T_123 ? _GEN_959 : _GEN_943; // @[DRAM2BRAM.scala 311:33]
  wire [5:0] _GEN_976 = 4'h3 < _T_123 ? _GEN_960 : _GEN_944; // @[DRAM2BRAM.scala 311:33]
  wire [5:0] _GEN_977 = 4'h3 < _T_123 ? _GEN_961 : _GEN_945; // @[DRAM2BRAM.scala 311:33]
  wire [5:0] _GEN_978 = 4'h3 < _T_123 ? _GEN_962 : _GEN_946; // @[DRAM2BRAM.scala 311:33]
  wire [5:0] _GEN_979 = 4'h3 < _T_123 ? _GEN_963 : _GEN_947; // @[DRAM2BRAM.scala 311:33]
  wire [5:0] _GEN_980 = 4'h3 < _T_123 ? _GEN_964 : _GEN_948; // @[DRAM2BRAM.scala 311:33]
  wire [5:0] _GEN_981 = 4'h3 < _T_123 ? _GEN_965 : _GEN_949; // @[DRAM2BRAM.scala 311:33]
  wire [5:0] _GEN_982 = 4'h3 < _T_123 ? _GEN_966 : _GEN_950; // @[DRAM2BRAM.scala 311:33]
  wire [7:0] _GEN_983 = 4'h3 < _T_123 ? _GEN_967 : _GEN_951; // @[DRAM2BRAM.scala 311:33]
  wire [7:0] _GEN_984 = 4'h3 < _T_123 ? _GEN_968 : _GEN_952; // @[DRAM2BRAM.scala 311:33]
  wire [7:0] _GEN_985 = 4'h3 < _T_123 ? _GEN_969 : _GEN_953; // @[DRAM2BRAM.scala 311:33]
  wire [7:0] _GEN_986 = 4'h3 < _T_123 ? _GEN_970 : _GEN_954; // @[DRAM2BRAM.scala 311:33]
  wire [7:0] _GEN_987 = 4'h3 < _T_123 ? _GEN_971 : _GEN_955; // @[DRAM2BRAM.scala 311:33]
  wire [7:0] _GEN_988 = 4'h3 < _T_123 ? _GEN_972 : _GEN_956; // @[DRAM2BRAM.scala 311:33]
  wire [7:0] _GEN_989 = 4'h3 < _T_123 ? _GEN_973 : _GEN_957; // @[DRAM2BRAM.scala 311:33]
  wire [7:0] _GEN_990 = 4'h3 < _T_123 ? _GEN_974 : _GEN_958; // @[DRAM2BRAM.scala 311:33]
  wire [2:0] _T_274 = regElCnt + 3'h4; // @[DRAM2BRAM.scala 312:40]
  wire [5:0] _GEN_991 = 3'h0 == _T_274 ? _GEN_266 : _GEN_975; // @[DRAM2BRAM.scala 312:47 DRAM2BRAM.scala 312:47]
  wire [5:0] _GEN_992 = 3'h1 == _T_274 ? _GEN_266 : _GEN_976; // @[DRAM2BRAM.scala 312:47 DRAM2BRAM.scala 312:47]
  wire [5:0] _GEN_993 = 3'h2 == _T_274 ? _GEN_266 : _GEN_977; // @[DRAM2BRAM.scala 312:47 DRAM2BRAM.scala 312:47]
  wire [5:0] _GEN_994 = 3'h3 == _T_274 ? _GEN_266 : _GEN_978; // @[DRAM2BRAM.scala 312:47 DRAM2BRAM.scala 312:47]
  wire [5:0] _GEN_995 = 3'h4 == _T_274 ? _GEN_266 : _GEN_979; // @[DRAM2BRAM.scala 312:47 DRAM2BRAM.scala 312:47]
  wire [5:0] _GEN_996 = 3'h5 == _T_274 ? _GEN_266 : _GEN_980; // @[DRAM2BRAM.scala 312:47 DRAM2BRAM.scala 312:47]
  wire [5:0] _GEN_997 = 3'h6 == _T_274 ? _GEN_266 : _GEN_981; // @[DRAM2BRAM.scala 312:47 DRAM2BRAM.scala 312:47]
  wire [5:0] _GEN_998 = 3'h7 == _T_274 ? _GEN_266 : _GEN_982; // @[DRAM2BRAM.scala 312:47 DRAM2BRAM.scala 312:47]
  wire [7:0] _GEN_999 = 3'h0 == _T_274 ? _GEN_274 : _GEN_983; // @[DRAM2BRAM.scala 312:47 DRAM2BRAM.scala 312:47]
  wire [7:0] _GEN_1000 = 3'h1 == _T_274 ? _GEN_274 : _GEN_984; // @[DRAM2BRAM.scala 312:47 DRAM2BRAM.scala 312:47]
  wire [7:0] _GEN_1001 = 3'h2 == _T_274 ? _GEN_274 : _GEN_985; // @[DRAM2BRAM.scala 312:47 DRAM2BRAM.scala 312:47]
  wire [7:0] _GEN_1002 = 3'h3 == _T_274 ? _GEN_274 : _GEN_986; // @[DRAM2BRAM.scala 312:47 DRAM2BRAM.scala 312:47]
  wire [7:0] _GEN_1003 = 3'h4 == _T_274 ? _GEN_274 : _GEN_987; // @[DRAM2BRAM.scala 312:47 DRAM2BRAM.scala 312:47]
  wire [7:0] _GEN_1004 = 3'h5 == _T_274 ? _GEN_274 : _GEN_988; // @[DRAM2BRAM.scala 312:47 DRAM2BRAM.scala 312:47]
  wire [7:0] _GEN_1005 = 3'h6 == _T_274 ? _GEN_274 : _GEN_989; // @[DRAM2BRAM.scala 312:47 DRAM2BRAM.scala 312:47]
  wire [7:0] _GEN_1006 = 3'h7 == _T_274 ? _GEN_274 : _GEN_990; // @[DRAM2BRAM.scala 312:47 DRAM2BRAM.scala 312:47]
  wire [5:0] _GEN_1007 = 4'h4 < _T_123 ? _GEN_991 : _GEN_975; // @[DRAM2BRAM.scala 311:33]
  wire [5:0] _GEN_1008 = 4'h4 < _T_123 ? _GEN_992 : _GEN_976; // @[DRAM2BRAM.scala 311:33]
  wire [5:0] _GEN_1009 = 4'h4 < _T_123 ? _GEN_993 : _GEN_977; // @[DRAM2BRAM.scala 311:33]
  wire [5:0] _GEN_1010 = 4'h4 < _T_123 ? _GEN_994 : _GEN_978; // @[DRAM2BRAM.scala 311:33]
  wire [5:0] _GEN_1011 = 4'h4 < _T_123 ? _GEN_995 : _GEN_979; // @[DRAM2BRAM.scala 311:33]
  wire [5:0] _GEN_1012 = 4'h4 < _T_123 ? _GEN_996 : _GEN_980; // @[DRAM2BRAM.scala 311:33]
  wire [5:0] _GEN_1013 = 4'h4 < _T_123 ? _GEN_997 : _GEN_981; // @[DRAM2BRAM.scala 311:33]
  wire [5:0] _GEN_1014 = 4'h4 < _T_123 ? _GEN_998 : _GEN_982; // @[DRAM2BRAM.scala 311:33]
  wire [7:0] _GEN_1015 = 4'h4 < _T_123 ? _GEN_999 : _GEN_983; // @[DRAM2BRAM.scala 311:33]
  wire [7:0] _GEN_1016 = 4'h4 < _T_123 ? _GEN_1000 : _GEN_984; // @[DRAM2BRAM.scala 311:33]
  wire [7:0] _GEN_1017 = 4'h4 < _T_123 ? _GEN_1001 : _GEN_985; // @[DRAM2BRAM.scala 311:33]
  wire [7:0] _GEN_1018 = 4'h4 < _T_123 ? _GEN_1002 : _GEN_986; // @[DRAM2BRAM.scala 311:33]
  wire [7:0] _GEN_1019 = 4'h4 < _T_123 ? _GEN_1003 : _GEN_987; // @[DRAM2BRAM.scala 311:33]
  wire [7:0] _GEN_1020 = 4'h4 < _T_123 ? _GEN_1004 : _GEN_988; // @[DRAM2BRAM.scala 311:33]
  wire [7:0] _GEN_1021 = 4'h4 < _T_123 ? _GEN_1005 : _GEN_989; // @[DRAM2BRAM.scala 311:33]
  wire [7:0] _GEN_1022 = 4'h4 < _T_123 ? _GEN_1006 : _GEN_990; // @[DRAM2BRAM.scala 311:33]
  wire [2:0] _T_277 = regElCnt + 3'h5; // @[DRAM2BRAM.scala 312:40]
  wire [5:0] _GEN_1023 = 3'h0 == _T_277 ? _GEN_267 : _GEN_1007; // @[DRAM2BRAM.scala 312:47 DRAM2BRAM.scala 312:47]
  wire [5:0] _GEN_1024 = 3'h1 == _T_277 ? _GEN_267 : _GEN_1008; // @[DRAM2BRAM.scala 312:47 DRAM2BRAM.scala 312:47]
  wire [5:0] _GEN_1025 = 3'h2 == _T_277 ? _GEN_267 : _GEN_1009; // @[DRAM2BRAM.scala 312:47 DRAM2BRAM.scala 312:47]
  wire [5:0] _GEN_1026 = 3'h3 == _T_277 ? _GEN_267 : _GEN_1010; // @[DRAM2BRAM.scala 312:47 DRAM2BRAM.scala 312:47]
  wire [5:0] _GEN_1027 = 3'h4 == _T_277 ? _GEN_267 : _GEN_1011; // @[DRAM2BRAM.scala 312:47 DRAM2BRAM.scala 312:47]
  wire [5:0] _GEN_1028 = 3'h5 == _T_277 ? _GEN_267 : _GEN_1012; // @[DRAM2BRAM.scala 312:47 DRAM2BRAM.scala 312:47]
  wire [5:0] _GEN_1029 = 3'h6 == _T_277 ? _GEN_267 : _GEN_1013; // @[DRAM2BRAM.scala 312:47 DRAM2BRAM.scala 312:47]
  wire [5:0] _GEN_1030 = 3'h7 == _T_277 ? _GEN_267 : _GEN_1014; // @[DRAM2BRAM.scala 312:47 DRAM2BRAM.scala 312:47]
  wire [7:0] _GEN_1031 = 3'h0 == _T_277 ? _GEN_275 : _GEN_1015; // @[DRAM2BRAM.scala 312:47 DRAM2BRAM.scala 312:47]
  wire [7:0] _GEN_1032 = 3'h1 == _T_277 ? _GEN_275 : _GEN_1016; // @[DRAM2BRAM.scala 312:47 DRAM2BRAM.scala 312:47]
  wire [7:0] _GEN_1033 = 3'h2 == _T_277 ? _GEN_275 : _GEN_1017; // @[DRAM2BRAM.scala 312:47 DRAM2BRAM.scala 312:47]
  wire [7:0] _GEN_1034 = 3'h3 == _T_277 ? _GEN_275 : _GEN_1018; // @[DRAM2BRAM.scala 312:47 DRAM2BRAM.scala 312:47]
  wire [7:0] _GEN_1035 = 3'h4 == _T_277 ? _GEN_275 : _GEN_1019; // @[DRAM2BRAM.scala 312:47 DRAM2BRAM.scala 312:47]
  wire [7:0] _GEN_1036 = 3'h5 == _T_277 ? _GEN_275 : _GEN_1020; // @[DRAM2BRAM.scala 312:47 DRAM2BRAM.scala 312:47]
  wire [7:0] _GEN_1037 = 3'h6 == _T_277 ? _GEN_275 : _GEN_1021; // @[DRAM2BRAM.scala 312:47 DRAM2BRAM.scala 312:47]
  wire [7:0] _GEN_1038 = 3'h7 == _T_277 ? _GEN_275 : _GEN_1022; // @[DRAM2BRAM.scala 312:47 DRAM2BRAM.scala 312:47]
  wire [5:0] _GEN_1039 = 4'h5 < _T_123 ? _GEN_1023 : _GEN_1007; // @[DRAM2BRAM.scala 311:33]
  wire [5:0] _GEN_1040 = 4'h5 < _T_123 ? _GEN_1024 : _GEN_1008; // @[DRAM2BRAM.scala 311:33]
  wire [5:0] _GEN_1041 = 4'h5 < _T_123 ? _GEN_1025 : _GEN_1009; // @[DRAM2BRAM.scala 311:33]
  wire [5:0] _GEN_1042 = 4'h5 < _T_123 ? _GEN_1026 : _GEN_1010; // @[DRAM2BRAM.scala 311:33]
  wire [5:0] _GEN_1043 = 4'h5 < _T_123 ? _GEN_1027 : _GEN_1011; // @[DRAM2BRAM.scala 311:33]
  wire [5:0] _GEN_1044 = 4'h5 < _T_123 ? _GEN_1028 : _GEN_1012; // @[DRAM2BRAM.scala 311:33]
  wire [5:0] _GEN_1045 = 4'h5 < _T_123 ? _GEN_1029 : _GEN_1013; // @[DRAM2BRAM.scala 311:33]
  wire [5:0] _GEN_1046 = 4'h5 < _T_123 ? _GEN_1030 : _GEN_1014; // @[DRAM2BRAM.scala 311:33]
  wire [7:0] _GEN_1047 = 4'h5 < _T_123 ? _GEN_1031 : _GEN_1015; // @[DRAM2BRAM.scala 311:33]
  wire [7:0] _GEN_1048 = 4'h5 < _T_123 ? _GEN_1032 : _GEN_1016; // @[DRAM2BRAM.scala 311:33]
  wire [7:0] _GEN_1049 = 4'h5 < _T_123 ? _GEN_1033 : _GEN_1017; // @[DRAM2BRAM.scala 311:33]
  wire [7:0] _GEN_1050 = 4'h5 < _T_123 ? _GEN_1034 : _GEN_1018; // @[DRAM2BRAM.scala 311:33]
  wire [7:0] _GEN_1051 = 4'h5 < _T_123 ? _GEN_1035 : _GEN_1019; // @[DRAM2BRAM.scala 311:33]
  wire [7:0] _GEN_1052 = 4'h5 < _T_123 ? _GEN_1036 : _GEN_1020; // @[DRAM2BRAM.scala 311:33]
  wire [7:0] _GEN_1053 = 4'h5 < _T_123 ? _GEN_1037 : _GEN_1021; // @[DRAM2BRAM.scala 311:33]
  wire [7:0] _GEN_1054 = 4'h5 < _T_123 ? _GEN_1038 : _GEN_1022; // @[DRAM2BRAM.scala 311:33]
  wire [2:0] _T_280 = regElCnt + 3'h6; // @[DRAM2BRAM.scala 312:40]
  wire [5:0] _GEN_1055 = 3'h0 == _T_280 ? _GEN_268 : _GEN_1039; // @[DRAM2BRAM.scala 312:47 DRAM2BRAM.scala 312:47]
  wire [5:0] _GEN_1056 = 3'h1 == _T_280 ? _GEN_268 : _GEN_1040; // @[DRAM2BRAM.scala 312:47 DRAM2BRAM.scala 312:47]
  wire [5:0] _GEN_1057 = 3'h2 == _T_280 ? _GEN_268 : _GEN_1041; // @[DRAM2BRAM.scala 312:47 DRAM2BRAM.scala 312:47]
  wire [5:0] _GEN_1058 = 3'h3 == _T_280 ? _GEN_268 : _GEN_1042; // @[DRAM2BRAM.scala 312:47 DRAM2BRAM.scala 312:47]
  wire [5:0] _GEN_1059 = 3'h4 == _T_280 ? _GEN_268 : _GEN_1043; // @[DRAM2BRAM.scala 312:47 DRAM2BRAM.scala 312:47]
  wire [5:0] _GEN_1060 = 3'h5 == _T_280 ? _GEN_268 : _GEN_1044; // @[DRAM2BRAM.scala 312:47 DRAM2BRAM.scala 312:47]
  wire [5:0] _GEN_1061 = 3'h6 == _T_280 ? _GEN_268 : _GEN_1045; // @[DRAM2BRAM.scala 312:47 DRAM2BRAM.scala 312:47]
  wire [5:0] _GEN_1062 = 3'h7 == _T_280 ? _GEN_268 : _GEN_1046; // @[DRAM2BRAM.scala 312:47 DRAM2BRAM.scala 312:47]
  wire [7:0] _GEN_1063 = 3'h0 == _T_280 ? _GEN_276 : _GEN_1047; // @[DRAM2BRAM.scala 312:47 DRAM2BRAM.scala 312:47]
  wire [7:0] _GEN_1064 = 3'h1 == _T_280 ? _GEN_276 : _GEN_1048; // @[DRAM2BRAM.scala 312:47 DRAM2BRAM.scala 312:47]
  wire [7:0] _GEN_1065 = 3'h2 == _T_280 ? _GEN_276 : _GEN_1049; // @[DRAM2BRAM.scala 312:47 DRAM2BRAM.scala 312:47]
  wire [7:0] _GEN_1066 = 3'h3 == _T_280 ? _GEN_276 : _GEN_1050; // @[DRAM2BRAM.scala 312:47 DRAM2BRAM.scala 312:47]
  wire [7:0] _GEN_1067 = 3'h4 == _T_280 ? _GEN_276 : _GEN_1051; // @[DRAM2BRAM.scala 312:47 DRAM2BRAM.scala 312:47]
  wire [7:0] _GEN_1068 = 3'h5 == _T_280 ? _GEN_276 : _GEN_1052; // @[DRAM2BRAM.scala 312:47 DRAM2BRAM.scala 312:47]
  wire [7:0] _GEN_1069 = 3'h6 == _T_280 ? _GEN_276 : _GEN_1053; // @[DRAM2BRAM.scala 312:47 DRAM2BRAM.scala 312:47]
  wire [7:0] _GEN_1070 = 3'h7 == _T_280 ? _GEN_276 : _GEN_1054; // @[DRAM2BRAM.scala 312:47 DRAM2BRAM.scala 312:47]
  wire [5:0] _GEN_1071 = 4'h6 < _T_123 ? _GEN_1055 : _GEN_1039; // @[DRAM2BRAM.scala 311:33]
  wire [5:0] _GEN_1072 = 4'h6 < _T_123 ? _GEN_1056 : _GEN_1040; // @[DRAM2BRAM.scala 311:33]
  wire [5:0] _GEN_1073 = 4'h6 < _T_123 ? _GEN_1057 : _GEN_1041; // @[DRAM2BRAM.scala 311:33]
  wire [5:0] _GEN_1074 = 4'h6 < _T_123 ? _GEN_1058 : _GEN_1042; // @[DRAM2BRAM.scala 311:33]
  wire [5:0] _GEN_1075 = 4'h6 < _T_123 ? _GEN_1059 : _GEN_1043; // @[DRAM2BRAM.scala 311:33]
  wire [5:0] _GEN_1076 = 4'h6 < _T_123 ? _GEN_1060 : _GEN_1044; // @[DRAM2BRAM.scala 311:33]
  wire [5:0] _GEN_1077 = 4'h6 < _T_123 ? _GEN_1061 : _GEN_1045; // @[DRAM2BRAM.scala 311:33]
  wire [5:0] _GEN_1078 = 4'h6 < _T_123 ? _GEN_1062 : _GEN_1046; // @[DRAM2BRAM.scala 311:33]
  wire [7:0] _GEN_1079 = 4'h6 < _T_123 ? _GEN_1063 : _GEN_1047; // @[DRAM2BRAM.scala 311:33]
  wire [7:0] _GEN_1080 = 4'h6 < _T_123 ? _GEN_1064 : _GEN_1048; // @[DRAM2BRAM.scala 311:33]
  wire [7:0] _GEN_1081 = 4'h6 < _T_123 ? _GEN_1065 : _GEN_1049; // @[DRAM2BRAM.scala 311:33]
  wire [7:0] _GEN_1082 = 4'h6 < _T_123 ? _GEN_1066 : _GEN_1050; // @[DRAM2BRAM.scala 311:33]
  wire [7:0] _GEN_1083 = 4'h6 < _T_123 ? _GEN_1067 : _GEN_1051; // @[DRAM2BRAM.scala 311:33]
  wire [7:0] _GEN_1084 = 4'h6 < _T_123 ? _GEN_1068 : _GEN_1052; // @[DRAM2BRAM.scala 311:33]
  wire [7:0] _GEN_1085 = 4'h6 < _T_123 ? _GEN_1069 : _GEN_1053; // @[DRAM2BRAM.scala 311:33]
  wire [7:0] _GEN_1086 = 4'h6 < _T_123 ? _GEN_1070 : _GEN_1054; // @[DRAM2BRAM.scala 311:33]
  wire [2:0] _T_283 = regElCnt + 3'h7; // @[DRAM2BRAM.scala 312:40]
  wire [5:0] _GEN_1087 = 3'h0 == _T_283 ? _GEN_269 : _GEN_1071; // @[DRAM2BRAM.scala 312:47 DRAM2BRAM.scala 312:47]
  wire [5:0] _GEN_1088 = 3'h1 == _T_283 ? _GEN_269 : _GEN_1072; // @[DRAM2BRAM.scala 312:47 DRAM2BRAM.scala 312:47]
  wire [5:0] _GEN_1089 = 3'h2 == _T_283 ? _GEN_269 : _GEN_1073; // @[DRAM2BRAM.scala 312:47 DRAM2BRAM.scala 312:47]
  wire [5:0] _GEN_1090 = 3'h3 == _T_283 ? _GEN_269 : _GEN_1074; // @[DRAM2BRAM.scala 312:47 DRAM2BRAM.scala 312:47]
  wire [5:0] _GEN_1091 = 3'h4 == _T_283 ? _GEN_269 : _GEN_1075; // @[DRAM2BRAM.scala 312:47 DRAM2BRAM.scala 312:47]
  wire [5:0] _GEN_1092 = 3'h5 == _T_283 ? _GEN_269 : _GEN_1076; // @[DRAM2BRAM.scala 312:47 DRAM2BRAM.scala 312:47]
  wire [5:0] _GEN_1093 = 3'h6 == _T_283 ? _GEN_269 : _GEN_1077; // @[DRAM2BRAM.scala 312:47 DRAM2BRAM.scala 312:47]
  wire [5:0] _GEN_1094 = 3'h7 == _T_283 ? _GEN_269 : _GEN_1078; // @[DRAM2BRAM.scala 312:47 DRAM2BRAM.scala 312:47]
  wire [7:0] _GEN_1095 = 3'h0 == _T_283 ? _GEN_277 : _GEN_1079; // @[DRAM2BRAM.scala 312:47 DRAM2BRAM.scala 312:47]
  wire [7:0] _GEN_1096 = 3'h1 == _T_283 ? _GEN_277 : _GEN_1080; // @[DRAM2BRAM.scala 312:47 DRAM2BRAM.scala 312:47]
  wire [7:0] _GEN_1097 = 3'h2 == _T_283 ? _GEN_277 : _GEN_1081; // @[DRAM2BRAM.scala 312:47 DRAM2BRAM.scala 312:47]
  wire [7:0] _GEN_1098 = 3'h3 == _T_283 ? _GEN_277 : _GEN_1082; // @[DRAM2BRAM.scala 312:47 DRAM2BRAM.scala 312:47]
  wire [7:0] _GEN_1099 = 3'h4 == _T_283 ? _GEN_277 : _GEN_1083; // @[DRAM2BRAM.scala 312:47 DRAM2BRAM.scala 312:47]
  wire [7:0] _GEN_1100 = 3'h5 == _T_283 ? _GEN_277 : _GEN_1084; // @[DRAM2BRAM.scala 312:47 DRAM2BRAM.scala 312:47]
  wire [7:0] _GEN_1101 = 3'h6 == _T_283 ? _GEN_277 : _GEN_1085; // @[DRAM2BRAM.scala 312:47 DRAM2BRAM.scala 312:47]
  wire [7:0] _GEN_1102 = 3'h7 == _T_283 ? _GEN_277 : _GEN_1086; // @[DRAM2BRAM.scala 312:47 DRAM2BRAM.scala 312:47]
  wire [5:0] _GEN_1103 = 4'h7 < _T_123 ? _GEN_1087 : _GEN_1071; // @[DRAM2BRAM.scala 311:33]
  wire [5:0] _GEN_1104 = 4'h7 < _T_123 ? _GEN_1088 : _GEN_1072; // @[DRAM2BRAM.scala 311:33]
  wire [5:0] _GEN_1105 = 4'h7 < _T_123 ? _GEN_1089 : _GEN_1073; // @[DRAM2BRAM.scala 311:33]
  wire [5:0] _GEN_1106 = 4'h7 < _T_123 ? _GEN_1090 : _GEN_1074; // @[DRAM2BRAM.scala 311:33]
  wire [5:0] _GEN_1107 = 4'h7 < _T_123 ? _GEN_1091 : _GEN_1075; // @[DRAM2BRAM.scala 311:33]
  wire [5:0] _GEN_1108 = 4'h7 < _T_123 ? _GEN_1092 : _GEN_1076; // @[DRAM2BRAM.scala 311:33]
  wire [5:0] _GEN_1109 = 4'h7 < _T_123 ? _GEN_1093 : _GEN_1077; // @[DRAM2BRAM.scala 311:33]
  wire [5:0] _GEN_1110 = 4'h7 < _T_123 ? _GEN_1094 : _GEN_1078; // @[DRAM2BRAM.scala 311:33]
  wire [7:0] _GEN_1111 = 4'h7 < _T_123 ? _GEN_1095 : _GEN_1079; // @[DRAM2BRAM.scala 311:33]
  wire [7:0] _GEN_1112 = 4'h7 < _T_123 ? _GEN_1096 : _GEN_1080; // @[DRAM2BRAM.scala 311:33]
  wire [7:0] _GEN_1113 = 4'h7 < _T_123 ? _GEN_1097 : _GEN_1081; // @[DRAM2BRAM.scala 311:33]
  wire [7:0] _GEN_1114 = 4'h7 < _T_123 ? _GEN_1098 : _GEN_1082; // @[DRAM2BRAM.scala 311:33]
  wire [7:0] _GEN_1115 = 4'h7 < _T_123 ? _GEN_1099 : _GEN_1083; // @[DRAM2BRAM.scala 311:33]
  wire [7:0] _GEN_1116 = 4'h7 < _T_123 ? _GEN_1100 : _GEN_1084; // @[DRAM2BRAM.scala 311:33]
  wire [7:0] _GEN_1117 = 4'h7 < _T_123 ? _GEN_1101 : _GEN_1085; // @[DRAM2BRAM.scala 311:33]
  wire [7:0] _GEN_1118 = 4'h7 < _T_123 ? _GEN_1102 : _GEN_1086; // @[DRAM2BRAM.scala 311:33]
  wire [3:0] _GEN_1122 = rowFinished & (_T_150 | regElCnt > 3'h0) ? 4'h0 : _T_149; // @[DRAM2BRAM.scala 285:74 DRAM2BRAM.scala 304:20 DRAM2BRAM.scala 316:20]
  wire [8:0] _GEN_1123 = rowFinished & (_T_150 | regElCnt > 3'h0) ? _T_221 : regBramRowCnt; // @[DRAM2BRAM.scala 285:74 DRAM2BRAM.scala 305:25 DRAM2BRAM.scala 125:30]
  wire [5:0] _GEN_1124 = rowFinished & (_T_150 | regElCnt > 3'h0) ? regBramLine_els_0_col : _GEN_1103; // @[DRAM2BRAM.scala 285:74 DRAM2BRAM.scala 118:28]
  wire [5:0] _GEN_1125 = rowFinished & (_T_150 | regElCnt > 3'h0) ? regBramLine_els_1_col : _GEN_1104; // @[DRAM2BRAM.scala 285:74 DRAM2BRAM.scala 118:28]
  wire [5:0] _GEN_1126 = rowFinished & (_T_150 | regElCnt > 3'h0) ? regBramLine_els_2_col : _GEN_1105; // @[DRAM2BRAM.scala 285:74 DRAM2BRAM.scala 118:28]
  wire [5:0] _GEN_1127 = rowFinished & (_T_150 | regElCnt > 3'h0) ? regBramLine_els_3_col : _GEN_1106; // @[DRAM2BRAM.scala 285:74 DRAM2BRAM.scala 118:28]
  wire [5:0] _GEN_1128 = rowFinished & (_T_150 | regElCnt > 3'h0) ? regBramLine_els_4_col : _GEN_1107; // @[DRAM2BRAM.scala 285:74 DRAM2BRAM.scala 118:28]
  wire [5:0] _GEN_1129 = rowFinished & (_T_150 | regElCnt > 3'h0) ? regBramLine_els_5_col : _GEN_1108; // @[DRAM2BRAM.scala 285:74 DRAM2BRAM.scala 118:28]
  wire [5:0] _GEN_1130 = rowFinished & (_T_150 | regElCnt > 3'h0) ? regBramLine_els_6_col : _GEN_1109; // @[DRAM2BRAM.scala 285:74 DRAM2BRAM.scala 118:28]
  wire [5:0] _GEN_1131 = rowFinished & (_T_150 | regElCnt > 3'h0) ? regBramLine_els_7_col : _GEN_1110; // @[DRAM2BRAM.scala 285:74 DRAM2BRAM.scala 118:28]
  wire [7:0] _GEN_1132 = rowFinished & (_T_150 | regElCnt > 3'h0) ? regBramLine_els_0_value : _GEN_1111; // @[DRAM2BRAM.scala 285:74 DRAM2BRAM.scala 118:28]
  wire [7:0] _GEN_1133 = rowFinished & (_T_150 | regElCnt > 3'h0) ? regBramLine_els_1_value : _GEN_1112; // @[DRAM2BRAM.scala 285:74 DRAM2BRAM.scala 118:28]
  wire [7:0] _GEN_1134 = rowFinished & (_T_150 | regElCnt > 3'h0) ? regBramLine_els_2_value : _GEN_1113; // @[DRAM2BRAM.scala 285:74 DRAM2BRAM.scala 118:28]
  wire [7:0] _GEN_1135 = rowFinished & (_T_150 | regElCnt > 3'h0) ? regBramLine_els_3_value : _GEN_1114; // @[DRAM2BRAM.scala 285:74 DRAM2BRAM.scala 118:28]
  wire [7:0] _GEN_1136 = rowFinished & (_T_150 | regElCnt > 3'h0) ? regBramLine_els_4_value : _GEN_1115; // @[DRAM2BRAM.scala 285:74 DRAM2BRAM.scala 118:28]
  wire [7:0] _GEN_1137 = rowFinished & (_T_150 | regElCnt > 3'h0) ? regBramLine_els_5_value : _GEN_1116; // @[DRAM2BRAM.scala 285:74 DRAM2BRAM.scala 118:28]
  wire [7:0] _GEN_1138 = rowFinished & (_T_150 | regElCnt > 3'h0) ? regBramLine_els_6_value : _GEN_1117; // @[DRAM2BRAM.scala 285:74 DRAM2BRAM.scala 118:28]
  wire [7:0] _GEN_1139 = rowFinished & (_T_150 | regElCnt > 3'h0) ? regBramLine_els_7_value : _GEN_1118; // @[DRAM2BRAM.scala 285:74 DRAM2BRAM.scala 118:28]
  wire  _GEN_1140 = _T_153 | _T_232; // @[DRAM2BRAM.scala 248:40 DRAM2BRAM.scala 261:34]
  wire [111:0] _GEN_1141 = _T_153 ? _T_187 : _T_187; // @[DRAM2BRAM.scala 248:40 DRAM2BRAM.scala 262:36]
  wire [5:0] _GEN_1143 = _T_153 ? _GEN_701 : _GEN_1124; // @[DRAM2BRAM.scala 248:40]
  wire [5:0] _GEN_1144 = _T_153 ? _GEN_702 : _GEN_1125; // @[DRAM2BRAM.scala 248:40]
  wire [5:0] _GEN_1145 = _T_153 ? _GEN_703 : _GEN_1126; // @[DRAM2BRAM.scala 248:40]
  wire [5:0] _GEN_1146 = _T_153 ? _GEN_704 : _GEN_1127; // @[DRAM2BRAM.scala 248:40]
  wire [5:0] _GEN_1147 = _T_153 ? _GEN_705 : _GEN_1128; // @[DRAM2BRAM.scala 248:40]
  wire [5:0] _GEN_1148 = _T_153 ? _GEN_706 : _GEN_1129; // @[DRAM2BRAM.scala 248:40]
  wire [5:0] _GEN_1149 = _T_153 ? _GEN_707 : _GEN_1130; // @[DRAM2BRAM.scala 248:40]
  wire [5:0] _GEN_1150 = _T_153 ? _GEN_708 : _GEN_1131; // @[DRAM2BRAM.scala 248:40]
  wire [7:0] _GEN_1151 = _T_153 ? _GEN_709 : _GEN_1132; // @[DRAM2BRAM.scala 248:40]
  wire [7:0] _GEN_1152 = _T_153 ? _GEN_710 : _GEN_1133; // @[DRAM2BRAM.scala 248:40]
  wire [7:0] _GEN_1153 = _T_153 ? _GEN_711 : _GEN_1134; // @[DRAM2BRAM.scala 248:40]
  wire [7:0] _GEN_1154 = _T_153 ? _GEN_712 : _GEN_1135; // @[DRAM2BRAM.scala 248:40]
  wire [7:0] _GEN_1155 = _T_153 ? _GEN_713 : _GEN_1136; // @[DRAM2BRAM.scala 248:40]
  wire [7:0] _GEN_1156 = _T_153 ? _GEN_714 : _GEN_1137; // @[DRAM2BRAM.scala 248:40]
  wire [7:0] _GEN_1157 = _T_153 ? _GEN_715 : _GEN_1138; // @[DRAM2BRAM.scala 248:40]
  wire [7:0] _GEN_1158 = _T_153 ? _GEN_716 : _GEN_1139; // @[DRAM2BRAM.scala 248:40]
  wire [3:0] _GEN_1159 = _T_153 ? _lo_T_1 : _GEN_1122; // @[DRAM2BRAM.scala 248:40 DRAM2BRAM.scala 272:20]
  wire [8:0] _GEN_1160 = _T_153 ? _T_221 : _GEN_1123; // @[DRAM2BRAM.scala 248:40 DRAM2BRAM.scala 273:25]
  wire [5:0] _GEN_1161 = _T_153 ? _GEN_717 : _GEN_316; // @[DRAM2BRAM.scala 248:40]
  wire [1:0] _GEN_1162 = _T_153 ? _GEN_718 : regState; // @[DRAM2BRAM.scala 248:40 DRAM2BRAM.scala 117:25]
  wire  _T_284 = regNRowsReceived == regNRows; // @[DRAM2BRAM.scala 318:35]
  wire [5:0] _GEN_1163 = _T_163 ? regBramLine_els_0_col : 6'h0; // @[DRAM2BRAM.scala 323:35 DRAM2BRAM.scala 324:18]
  wire [7:0] _GEN_1164 = _T_163 ? regBramLine_els_0_value : 8'h0; // @[DRAM2BRAM.scala 323:35 DRAM2BRAM.scala 324:18]
  wire [5:0] _GEN_1165 = _T_166 ? regBramLine_els_1_col : 6'h0; // @[DRAM2BRAM.scala 323:35 DRAM2BRAM.scala 324:18]
  wire [7:0] _GEN_1166 = _T_166 ? regBramLine_els_1_value : 8'h0; // @[DRAM2BRAM.scala 323:35 DRAM2BRAM.scala 324:18]
  wire [5:0] _GEN_1167 = _T_169 ? regBramLine_els_2_col : 6'h0; // @[DRAM2BRAM.scala 323:35 DRAM2BRAM.scala 324:18]
  wire [7:0] _GEN_1168 = _T_169 ? regBramLine_els_2_value : 8'h0; // @[DRAM2BRAM.scala 323:35 DRAM2BRAM.scala 324:18]
  wire [5:0] _GEN_1169 = _T_172 ? regBramLine_els_3_col : 6'h0; // @[DRAM2BRAM.scala 323:35 DRAM2BRAM.scala 324:18]
  wire [7:0] _GEN_1170 = _T_172 ? regBramLine_els_3_value : 8'h0; // @[DRAM2BRAM.scala 323:35 DRAM2BRAM.scala 324:18]
  wire [5:0] _GEN_1171 = _T_175 ? regBramLine_els_4_col : 6'h0; // @[DRAM2BRAM.scala 323:35 DRAM2BRAM.scala 324:18]
  wire [7:0] _GEN_1172 = _T_175 ? regBramLine_els_4_value : 8'h0; // @[DRAM2BRAM.scala 323:35 DRAM2BRAM.scala 324:18]
  wire [5:0] _GEN_1173 = _T_178 ? regBramLine_els_5_col : 6'h0; // @[DRAM2BRAM.scala 323:35 DRAM2BRAM.scala 324:18]
  wire [7:0] _GEN_1174 = _T_178 ? regBramLine_els_5_value : 8'h0; // @[DRAM2BRAM.scala 323:35 DRAM2BRAM.scala 324:18]
  wire [5:0] _GEN_1175 = _T_181 ? regBramLine_els_6_col : 6'h0; // @[DRAM2BRAM.scala 323:35 DRAM2BRAM.scala 324:18]
  wire [7:0] _GEN_1176 = _T_181 ? regBramLine_els_6_value : 8'h0; // @[DRAM2BRAM.scala 323:35 DRAM2BRAM.scala 324:18]
  wire [55:0] lo_4 = {_GEN_1170,_GEN_1169,_GEN_1168,_GEN_1167,_GEN_1166,_GEN_1165,_GEN_1164,_GEN_1163}; // @[DRAM2BRAM.scala 328:54]
  wire [111:0] _T_294 = {14'h0,_GEN_1176,_GEN_1175,_GEN_1174,_GEN_1173,_GEN_1172,_GEN_1171,lo_4}; // @[DRAM2BRAM.scala 328:54]
  wire  _GEN_1182 = _T_230 & regAgentHasValid; // @[DRAM2BRAM.scala 320:30 DRAM2BRAM.scala 333:40 DRAM2BRAM.scala 60:31]
  wire  _GEN_1186 = regNRowsReceived == regNRows & _T_230; // @[DRAM2BRAM.scala 318:49 DRAM2BRAM.scala 58:25]
  wire  _GEN_1189 = regNRowsReceived == regNRows & _GEN_1182; // @[DRAM2BRAM.scala 318:49 DRAM2BRAM.scala 60:31]
  wire [1:0] _GEN_1194 = regNRowsReceived == regNRows ? 2'h0 : regState; // @[DRAM2BRAM.scala 318:49 DRAM2BRAM.scala 338:18 DRAM2BRAM.scala 117:25]
  wire  _GEN_1201 = _T_12 ? _GEN_308 : _GEN_1189; // @[DRAM2BRAM.scala 182:30]
  wire [6:0] _GEN_1203 = _T_12 ? _GEN_310 : {{1'd0}, regAgentRowInfoAgentIdx}; // @[DRAM2BRAM.scala 182:30]
  wire [8:0] _GEN_1206 = _T_12 ? _GEN_313 : {{2'd0}, regAgentRowInfo_rowAddr}; // @[DRAM2BRAM.scala 182:30 DRAM2BRAM.scala 136:32]
  wire [6:0] _GEN_1207 = _T_12 ? _GEN_314 : {{1'd0}, regAgentRowInfoAgentIdx}; // @[DRAM2BRAM.scala 182:30 DRAM2BRAM.scala 137:40]
  wire  _GEN_1210 = _T_12 ? _GEN_1140 : _GEN_1186; // @[DRAM2BRAM.scala 182:30]
  wire [111:0] _GEN_1211 = _T_12 ? _GEN_1141 : _T_294; // @[DRAM2BRAM.scala 182:30]
  wire [3:0] _GEN_1229 = _T_12 ? _GEN_1159 : {{1'd0}, regElCnt}; // @[DRAM2BRAM.scala 182:30 DRAM2BRAM.scala 121:25]
  wire  _GEN_1232 = _T_12 ? 1'h0 : _T_284; // @[DRAM2BRAM.scala 182:30 DRAM2BRAM.scala 62:14]
  wire  _T_295 = 2'h2 == regState; // @[Conditional.scala 37:30]
  wire [55:0] lo_5 = {regBramLine_els_3_value,regBramLine_els_3_col,regBramLine_els_2_value,regBramLine_els_2_col,
    regBramLine_els_1_value,regBramLine_els_1_col,regBramLine_els_0_value,regBramLine_els_0_col}; // @[DRAM2BRAM.scala 343:53]
  wire [111:0] _T_296 = {regBramLine_els_7_value,regBramLine_els_7_col,regBramLine_els_6_value,regBramLine_els_6_col,
    regBramLine_els_5_value,regBramLine_els_5_col,regBramLine_els_4_value,regBramLine_els_4_col,lo_5}; // @[DRAM2BRAM.scala 343:53]
  wire [1:0] _GEN_1233 = _T_284 ? 2'h0 : 2'h1; // @[DRAM2BRAM.scala 349:44 DRAM2BRAM.scala 350:18 DRAM2BRAM.scala 353:18]
  wire [2:0] _GEN_1239 = _T_295 ? 3'h0 : regElCnt; // @[Conditional.scala 39:67 DRAM2BRAM.scala 347:16 DRAM2BRAM.scala 121:25]
  wire  _GEN_1241 = _T_295 & _T_284; // @[Conditional.scala 39:67 DRAM2BRAM.scala 62:14]
  wire  _GEN_1249 = _T_11 & _GEN_1201; // @[Conditional.scala 39:67 DRAM2BRAM.scala 60:31]
  wire [8:0] _GEN_1254 = _T_11 ? _GEN_1206 : {{2'd0}, regAgentRowInfo_rowAddr}; // @[Conditional.scala 39:67 DRAM2BRAM.scala 136:32]
  wire [6:0] _GEN_1255 = _T_11 ? _GEN_1207 : {{1'd0}, regAgentRowInfoAgentIdx}; // @[Conditional.scala 39:67 DRAM2BRAM.scala 137:40]
  wire  _GEN_1258 = _T_11 ? _GEN_1210 : _T_295; // @[Conditional.scala 39:67]
  wire [111:0] _GEN_1259 = _T_11 ? _GEN_1211 : _T_296; // @[Conditional.scala 39:67]
  wire [3:0] _GEN_1277 = _T_11 ? _GEN_1229 : {{1'd0}, _GEN_1239}; // @[Conditional.scala 39:67]
  wire  _GEN_1280 = _T_11 ? _GEN_1232 : _GEN_1241; // @[Conditional.scala 39:67]
  wire [3:0] _GEN_1294 = _T ? {{1'd0}, _GEN_12} : _GEN_1277; // @[Conditional.scala 40:58]
  wire [8:0] _GEN_1321 = _T ? {{2'd0}, regAgentRowInfo_rowAddr} : _GEN_1254; // @[Conditional.scala 40:58 DRAM2BRAM.scala 136:32]
  wire [6:0] _GEN_1322 = _T ? {{1'd0}, regAgentRowInfoAgentIdx} : _GEN_1255; // @[Conditional.scala 40:58 DRAM2BRAM.scala 137:40]
  ReadReqGen rg ( // @[DRAM2BRAM.scala 73:18]
    .clock(rg_clock),
    .reset(rg_reset),
    .io_ctrl_start(rg_io_ctrl_start),
    .io_ctrl_baseAddr(rg_io_ctrl_baseAddr),
    .io_ctrl_byteCount(rg_io_ctrl_byteCount),
    .io_reqs_ready(rg_io_reqs_ready),
    .io_reqs_valid(rg_io_reqs_valid),
    .io_reqs_bits_addr(rg_io_reqs_bits_addr),
    .io_reqs_bits_numBytes(rg_io_reqs_bits_numBytes)
  );
  Queue_4 Queue ( // @[DRAM2BRAM.scala 80:20]
    .clock(Queue_clock),
    .reset(Queue_reset),
    .io_enq_ready(Queue_io_enq_ready),
    .io_enq_valid(Queue_io_enq_valid),
    .io_enq_bits_readData(Queue_io_enq_bits_readData),
    .io_deq_ready(Queue_io_deq_ready),
    .io_deq_valid(Queue_io_deq_valid),
    .io_deq_bits_readData(Queue_io_deq_bits_readData)
  );
  assign io_dramReq_valid = rg_io_reqs_valid; // @[DRAM2BRAM.scala 74:14]
  assign io_dramReq_bits_addr = rg_io_reqs_bits_addr; // @[DRAM2BRAM.scala 74:14]
  assign io_dramReq_bits_numBytes = rg_io_reqs_bits_numBytes; // @[DRAM2BRAM.scala 74:14]
  assign io_dramRsp_ready = Queue_io_enq_ready; // @[DRAM2BRAM.scala 81:14]
  assign io_bramCmd_req_addr = regBramRowCnt; // @[Conditional.scala 39:67]
  assign io_bramCmd_req_writeData = {{8'd0}, _GEN_1259}; // @[Conditional.scala 39:67]
  assign io_bramCmd_req_writeEn = _T ? 1'h0 : _GEN_1258; // @[Conditional.scala 40:58 DRAM2BRAM.scala 58:25]
  assign io_finished = _T ? 1'h0 : _GEN_1280; // @[Conditional.scala 40:58 DRAM2BRAM.scala 155:19]
  assign io_agentRowAddress_req_valid = _T ? 1'h0 : _GEN_1249; // @[Conditional.scala 40:58 DRAM2BRAM.scala 60:31]
  assign io_agentRowAddress_req_bits_addr = _GEN_1203[5:0];
  assign io_agentRowAddress_req_bits_wdata_rowAddr = _T_12 ? _GEN_312 : regAgentRowInfo_rowAddr; // @[DRAM2BRAM.scala 182:30]
  assign io_agentRowAddress_req_bits_wdata_length = _T_12 ? _GEN_311 : regAgentRowInfo_length; // @[DRAM2BRAM.scala 182:30]
  assign rg_clock = clock;
  assign rg_reset = reset;
  assign rg_io_ctrl_start = _T & io_start; // @[Conditional.scala 40:58 DRAM2BRAM.scala 78:20]
  assign rg_io_ctrl_baseAddr = io_baseAddr[31:0];
  assign rg_io_ctrl_byteCount = {{19'd0}, _T_5}; // @[MemoryController.scala 17:15]
  assign rg_io_reqs_ready = io_dramReq_ready; // @[DRAM2BRAM.scala 74:14]
  assign Queue_clock = clock;
  assign Queue_reset = reset;
  assign Queue_io_enq_valid = io_dramRsp_valid; // @[DRAM2BRAM.scala 81:14]
  assign Queue_io_enq_bits_readData = io_dramRsp_bits_readData; // @[DRAM2BRAM.scala 81:14]
  assign Queue_io_deq_ready = _T ? 1'h0 : _T_11; // @[Conditional.scala 40:58 DRAM2BRAM.scala 82:18]
  always @(posedge clock) begin
    if (reset) begin // @[DRAM2BRAM.scala 84:34]
      regBytesLeftInRow <= 32'h0; // @[DRAM2BRAM.scala 84:34]
    end else if (_T) begin // @[Conditional.scala 40:58]
      if (io_start) begin // @[DRAM2BRAM.scala 156:23]
        regBytesLeftInRow <= {{24'd0}, _T_10}; // @[DRAM2BRAM.scala 165:27]
      end
    end else if (_T_11) begin // @[Conditional.scala 39:67]
      if (_T_12) begin // @[DRAM2BRAM.scala 182:30]
        regBytesLeftInRow <= _GEN_41;
      end
    end
    if (reset) begin // @[DRAM2BRAM.scala 117:25]
      regState <= 2'h0; // @[DRAM2BRAM.scala 117:25]
    end else if (_T) begin // @[Conditional.scala 40:58]
      if (io_start) begin // @[DRAM2BRAM.scala 156:23]
        regState <= 2'h1; // @[DRAM2BRAM.scala 167:18]
      end
    end else if (_T_11) begin // @[Conditional.scala 39:67]
      if (_T_12) begin // @[DRAM2BRAM.scala 182:30]
        regState <= _GEN_1162;
      end else begin
        regState <= _GEN_1194;
      end
    end else if (_T_295) begin // @[Conditional.scala 39:67]
      regState <= _GEN_1233;
    end
    if (reset) begin // @[DRAM2BRAM.scala 118:28]
      regBramLine_els_0_value <= 8'h0; // @[DRAM2BRAM.scala 118:28]
    end else if (_T) begin // @[Conditional.scala 40:58]
      if (io_start) begin // @[DRAM2BRAM.scala 156:23]
        regBramLine_els_0_value <= 8'h0; // @[DRAM2BRAM.scala 175:21]
      end
    end else if (_T_11) begin // @[Conditional.scala 39:67]
      if (_T_12) begin // @[DRAM2BRAM.scala 182:30]
        regBramLine_els_0_value <= _GEN_1151;
      end
    end
    if (reset) begin // @[DRAM2BRAM.scala 118:28]
      regBramLine_els_0_col <= 6'h0; // @[DRAM2BRAM.scala 118:28]
    end else if (_T) begin // @[Conditional.scala 40:58]
      if (io_start) begin // @[DRAM2BRAM.scala 156:23]
        regBramLine_els_0_col <= 6'h0; // @[DRAM2BRAM.scala 175:21]
      end
    end else if (_T_11) begin // @[Conditional.scala 39:67]
      if (_T_12) begin // @[DRAM2BRAM.scala 182:30]
        regBramLine_els_0_col <= _GEN_1143;
      end
    end
    if (reset) begin // @[DRAM2BRAM.scala 118:28]
      regBramLine_els_1_value <= 8'h0; // @[DRAM2BRAM.scala 118:28]
    end else if (_T) begin // @[Conditional.scala 40:58]
      if (io_start) begin // @[DRAM2BRAM.scala 156:23]
        regBramLine_els_1_value <= 8'h0; // @[DRAM2BRAM.scala 175:21]
      end
    end else if (_T_11) begin // @[Conditional.scala 39:67]
      if (_T_12) begin // @[DRAM2BRAM.scala 182:30]
        regBramLine_els_1_value <= _GEN_1152;
      end
    end
    if (reset) begin // @[DRAM2BRAM.scala 118:28]
      regBramLine_els_1_col <= 6'h0; // @[DRAM2BRAM.scala 118:28]
    end else if (_T) begin // @[Conditional.scala 40:58]
      if (io_start) begin // @[DRAM2BRAM.scala 156:23]
        regBramLine_els_1_col <= 6'h0; // @[DRAM2BRAM.scala 175:21]
      end
    end else if (_T_11) begin // @[Conditional.scala 39:67]
      if (_T_12) begin // @[DRAM2BRAM.scala 182:30]
        regBramLine_els_1_col <= _GEN_1144;
      end
    end
    if (reset) begin // @[DRAM2BRAM.scala 118:28]
      regBramLine_els_2_value <= 8'h0; // @[DRAM2BRAM.scala 118:28]
    end else if (_T) begin // @[Conditional.scala 40:58]
      if (io_start) begin // @[DRAM2BRAM.scala 156:23]
        regBramLine_els_2_value <= 8'h0; // @[DRAM2BRAM.scala 175:21]
      end
    end else if (_T_11) begin // @[Conditional.scala 39:67]
      if (_T_12) begin // @[DRAM2BRAM.scala 182:30]
        regBramLine_els_2_value <= _GEN_1153;
      end
    end
    if (reset) begin // @[DRAM2BRAM.scala 118:28]
      regBramLine_els_2_col <= 6'h0; // @[DRAM2BRAM.scala 118:28]
    end else if (_T) begin // @[Conditional.scala 40:58]
      if (io_start) begin // @[DRAM2BRAM.scala 156:23]
        regBramLine_els_2_col <= 6'h0; // @[DRAM2BRAM.scala 175:21]
      end
    end else if (_T_11) begin // @[Conditional.scala 39:67]
      if (_T_12) begin // @[DRAM2BRAM.scala 182:30]
        regBramLine_els_2_col <= _GEN_1145;
      end
    end
    if (reset) begin // @[DRAM2BRAM.scala 118:28]
      regBramLine_els_3_value <= 8'h0; // @[DRAM2BRAM.scala 118:28]
    end else if (_T) begin // @[Conditional.scala 40:58]
      if (io_start) begin // @[DRAM2BRAM.scala 156:23]
        regBramLine_els_3_value <= 8'h0; // @[DRAM2BRAM.scala 175:21]
      end
    end else if (_T_11) begin // @[Conditional.scala 39:67]
      if (_T_12) begin // @[DRAM2BRAM.scala 182:30]
        regBramLine_els_3_value <= _GEN_1154;
      end
    end
    if (reset) begin // @[DRAM2BRAM.scala 118:28]
      regBramLine_els_3_col <= 6'h0; // @[DRAM2BRAM.scala 118:28]
    end else if (_T) begin // @[Conditional.scala 40:58]
      if (io_start) begin // @[DRAM2BRAM.scala 156:23]
        regBramLine_els_3_col <= 6'h0; // @[DRAM2BRAM.scala 175:21]
      end
    end else if (_T_11) begin // @[Conditional.scala 39:67]
      if (_T_12) begin // @[DRAM2BRAM.scala 182:30]
        regBramLine_els_3_col <= _GEN_1146;
      end
    end
    if (reset) begin // @[DRAM2BRAM.scala 118:28]
      regBramLine_els_4_value <= 8'h0; // @[DRAM2BRAM.scala 118:28]
    end else if (_T) begin // @[Conditional.scala 40:58]
      if (io_start) begin // @[DRAM2BRAM.scala 156:23]
        regBramLine_els_4_value <= 8'h0; // @[DRAM2BRAM.scala 175:21]
      end
    end else if (_T_11) begin // @[Conditional.scala 39:67]
      if (_T_12) begin // @[DRAM2BRAM.scala 182:30]
        regBramLine_els_4_value <= _GEN_1155;
      end
    end
    if (reset) begin // @[DRAM2BRAM.scala 118:28]
      regBramLine_els_4_col <= 6'h0; // @[DRAM2BRAM.scala 118:28]
    end else if (_T) begin // @[Conditional.scala 40:58]
      if (io_start) begin // @[DRAM2BRAM.scala 156:23]
        regBramLine_els_4_col <= 6'h0; // @[DRAM2BRAM.scala 175:21]
      end
    end else if (_T_11) begin // @[Conditional.scala 39:67]
      if (_T_12) begin // @[DRAM2BRAM.scala 182:30]
        regBramLine_els_4_col <= _GEN_1147;
      end
    end
    if (reset) begin // @[DRAM2BRAM.scala 118:28]
      regBramLine_els_5_value <= 8'h0; // @[DRAM2BRAM.scala 118:28]
    end else if (_T) begin // @[Conditional.scala 40:58]
      if (io_start) begin // @[DRAM2BRAM.scala 156:23]
        regBramLine_els_5_value <= 8'h0; // @[DRAM2BRAM.scala 175:21]
      end
    end else if (_T_11) begin // @[Conditional.scala 39:67]
      if (_T_12) begin // @[DRAM2BRAM.scala 182:30]
        regBramLine_els_5_value <= _GEN_1156;
      end
    end
    if (reset) begin // @[DRAM2BRAM.scala 118:28]
      regBramLine_els_5_col <= 6'h0; // @[DRAM2BRAM.scala 118:28]
    end else if (_T) begin // @[Conditional.scala 40:58]
      if (io_start) begin // @[DRAM2BRAM.scala 156:23]
        regBramLine_els_5_col <= 6'h0; // @[DRAM2BRAM.scala 175:21]
      end
    end else if (_T_11) begin // @[Conditional.scala 39:67]
      if (_T_12) begin // @[DRAM2BRAM.scala 182:30]
        regBramLine_els_5_col <= _GEN_1148;
      end
    end
    if (reset) begin // @[DRAM2BRAM.scala 118:28]
      regBramLine_els_6_value <= 8'h0; // @[DRAM2BRAM.scala 118:28]
    end else if (_T) begin // @[Conditional.scala 40:58]
      if (io_start) begin // @[DRAM2BRAM.scala 156:23]
        regBramLine_els_6_value <= 8'h0; // @[DRAM2BRAM.scala 175:21]
      end
    end else if (_T_11) begin // @[Conditional.scala 39:67]
      if (_T_12) begin // @[DRAM2BRAM.scala 182:30]
        regBramLine_els_6_value <= _GEN_1157;
      end
    end
    if (reset) begin // @[DRAM2BRAM.scala 118:28]
      regBramLine_els_6_col <= 6'h0; // @[DRAM2BRAM.scala 118:28]
    end else if (_T) begin // @[Conditional.scala 40:58]
      if (io_start) begin // @[DRAM2BRAM.scala 156:23]
        regBramLine_els_6_col <= 6'h0; // @[DRAM2BRAM.scala 175:21]
      end
    end else if (_T_11) begin // @[Conditional.scala 39:67]
      if (_T_12) begin // @[DRAM2BRAM.scala 182:30]
        regBramLine_els_6_col <= _GEN_1149;
      end
    end
    if (reset) begin // @[DRAM2BRAM.scala 118:28]
      regBramLine_els_7_value <= 8'h0; // @[DRAM2BRAM.scala 118:28]
    end else if (_T) begin // @[Conditional.scala 40:58]
      if (io_start) begin // @[DRAM2BRAM.scala 156:23]
        regBramLine_els_7_value <= 8'h0; // @[DRAM2BRAM.scala 175:21]
      end
    end else if (_T_11) begin // @[Conditional.scala 39:67]
      if (_T_12) begin // @[DRAM2BRAM.scala 182:30]
        regBramLine_els_7_value <= _GEN_1158;
      end
    end
    if (reset) begin // @[DRAM2BRAM.scala 118:28]
      regBramLine_els_7_col <= 6'h0; // @[DRAM2BRAM.scala 118:28]
    end else if (_T) begin // @[Conditional.scala 40:58]
      if (io_start) begin // @[DRAM2BRAM.scala 156:23]
        regBramLine_els_7_col <= 6'h0; // @[DRAM2BRAM.scala 175:21]
      end
    end else if (_T_11) begin // @[Conditional.scala 39:67]
      if (_T_12) begin // @[DRAM2BRAM.scala 182:30]
        regBramLine_els_7_col <= _GEN_1150;
      end
    end
    if (reset) begin // @[DRAM2BRAM.scala 121:25]
      regElCnt <= 3'h0; // @[DRAM2BRAM.scala 121:25]
    end else begin
      regElCnt <= _GEN_1294[2:0];
    end
    if (reset) begin // @[DRAM2BRAM.scala 123:30]
      regColAddrCnt <= 9'h0; // @[DRAM2BRAM.scala 123:30]
    end else if (_T) begin // @[Conditional.scala 40:58]
      if (io_start) begin // @[DRAM2BRAM.scala 156:23]
        regColAddrCnt <= 9'h0; // @[DRAM2BRAM.scala 177:23]
      end
    end else if (_T_11) begin // @[Conditional.scala 39:67]
      if (_T_12) begin // @[DRAM2BRAM.scala 182:30]
        regColAddrCnt <= _GEN_42;
      end
    end
    if (reset) begin // @[DRAM2BRAM.scala 124:31]
      regAgentRowCnt <= 7'h0; // @[DRAM2BRAM.scala 124:31]
    end else if (_T) begin // @[Conditional.scala 40:58]
      if (io_start) begin // @[DRAM2BRAM.scala 156:23]
        regAgentRowCnt <= 7'h0; // @[DRAM2BRAM.scala 176:24]
      end
    end else if (_T_11) begin // @[Conditional.scala 39:67]
      if (_T_12) begin // @[DRAM2BRAM.scala 182:30]
        regAgentRowCnt <= _GEN_40;
      end
    end
    if (reset) begin // @[DRAM2BRAM.scala 125:30]
      regBramRowCnt <= 9'h0; // @[DRAM2BRAM.scala 125:30]
    end else if (_T) begin // @[Conditional.scala 40:58]
      if (io_start) begin // @[DRAM2BRAM.scala 156:23]
        regBramRowCnt <= 9'h0; // @[DRAM2BRAM.scala 169:23]
      end
    end else if (_T_11) begin // @[Conditional.scala 39:67]
      if (_T_12) begin // @[DRAM2BRAM.scala 182:30]
        regBramRowCnt <= _GEN_1160;
      end
    end else if (_T_295) begin // @[Conditional.scala 39:67]
      regBramRowCnt <= _T_221; // @[DRAM2BRAM.scala 346:21]
    end
    if (reset) begin // @[DRAM2BRAM.scala 127:25]
      regNRows <= 6'h0; // @[DRAM2BRAM.scala 127:25]
    end else if (_T) begin // @[Conditional.scala 40:58]
      if (io_start) begin // @[DRAM2BRAM.scala 156:23]
        regNRows <= io_nRows; // @[DRAM2BRAM.scala 171:18]
      end
    end
    if (reset) begin // @[DRAM2BRAM.scala 128:25]
      regNCols <= 6'h0; // @[DRAM2BRAM.scala 128:25]
    end else if (_T) begin // @[Conditional.scala 40:58]
      if (io_start) begin // @[DRAM2BRAM.scala 156:23]
        regNCols <= io_nCols; // @[DRAM2BRAM.scala 170:18]
      end
    end
    if (reset) begin // @[DRAM2BRAM.scala 129:31]
      regNBytesInRow <= 9'h0; // @[DRAM2BRAM.scala 129:31]
    end else if (_T) begin // @[Conditional.scala 40:58]
      if (io_start) begin // @[DRAM2BRAM.scala 156:23]
        regNBytesInRow <= {{1'd0}, _T_10}; // @[DRAM2BRAM.scala 164:24]
      end
    end
    if (reset) begin // @[DRAM2BRAM.scala 132:33]
      regNRowsReceived <= 6'h0; // @[DRAM2BRAM.scala 132:33]
    end else if (_T) begin // @[Conditional.scala 40:58]
      if (io_start) begin // @[DRAM2BRAM.scala 156:23]
        regNRowsReceived <= 6'h0; // @[DRAM2BRAM.scala 172:26]
      end
    end else if (_T_11) begin // @[Conditional.scala 39:67]
      if (_T_12) begin // @[DRAM2BRAM.scala 182:30]
        regNRowsReceived <= _GEN_44;
      end
    end
    if (reset) begin // @[DRAM2BRAM.scala 136:32]
      regAgentRowInfo_rowAddr <= 7'h0; // @[DRAM2BRAM.scala 136:32]
    end else begin
      regAgentRowInfo_rowAddr <= _GEN_1321[6:0];
    end
    if (reset) begin // @[DRAM2BRAM.scala 136:32]
      regAgentRowInfo_length <= 6'h0; // @[DRAM2BRAM.scala 136:32]
    end else if (!(_T)) begin // @[Conditional.scala 40:58]
      if (_T_11) begin // @[Conditional.scala 39:67]
        if (_T_12) begin // @[DRAM2BRAM.scala 182:30]
          regAgentRowInfo_length <= _GEN_1161;
        end
      end
    end
    if (reset) begin // @[DRAM2BRAM.scala 137:40]
      regAgentRowInfoAgentIdx <= 6'h0; // @[DRAM2BRAM.scala 137:40]
    end else begin
      regAgentRowInfoAgentIdx <= _GEN_1322[5:0];
    end
    if (reset) begin // @[DRAM2BRAM.scala 138:33]
      regAgentHasValid <= 1'h0; // @[DRAM2BRAM.scala 138:33]
    end else if (!(_T)) begin // @[Conditional.scala 40:58]
      if (_T_11) begin // @[Conditional.scala 39:67]
        if (_T_12) begin // @[DRAM2BRAM.scala 182:30]
          regAgentHasValid <= _GEN_315;
        end
      end
    end
  end
// Register and memory initialization
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
  regBytesLeftInRow = _RAND_0[31:0];
  _RAND_1 = {1{`RANDOM}};
  regState = _RAND_1[1:0];
  _RAND_2 = {1{`RANDOM}};
  regBramLine_els_0_value = _RAND_2[7:0];
  _RAND_3 = {1{`RANDOM}};
  regBramLine_els_0_col = _RAND_3[5:0];
  _RAND_4 = {1{`RANDOM}};
  regBramLine_els_1_value = _RAND_4[7:0];
  _RAND_5 = {1{`RANDOM}};
  regBramLine_els_1_col = _RAND_5[5:0];
  _RAND_6 = {1{`RANDOM}};
  regBramLine_els_2_value = _RAND_6[7:0];
  _RAND_7 = {1{`RANDOM}};
  regBramLine_els_2_col = _RAND_7[5:0];
  _RAND_8 = {1{`RANDOM}};
  regBramLine_els_3_value = _RAND_8[7:0];
  _RAND_9 = {1{`RANDOM}};
  regBramLine_els_3_col = _RAND_9[5:0];
  _RAND_10 = {1{`RANDOM}};
  regBramLine_els_4_value = _RAND_10[7:0];
  _RAND_11 = {1{`RANDOM}};
  regBramLine_els_4_col = _RAND_11[5:0];
  _RAND_12 = {1{`RANDOM}};
  regBramLine_els_5_value = _RAND_12[7:0];
  _RAND_13 = {1{`RANDOM}};
  regBramLine_els_5_col = _RAND_13[5:0];
  _RAND_14 = {1{`RANDOM}};
  regBramLine_els_6_value = _RAND_14[7:0];
  _RAND_15 = {1{`RANDOM}};
  regBramLine_els_6_col = _RAND_15[5:0];
  _RAND_16 = {1{`RANDOM}};
  regBramLine_els_7_value = _RAND_16[7:0];
  _RAND_17 = {1{`RANDOM}};
  regBramLine_els_7_col = _RAND_17[5:0];
  _RAND_18 = {1{`RANDOM}};
  regElCnt = _RAND_18[2:0];
  _RAND_19 = {1{`RANDOM}};
  regColAddrCnt = _RAND_19[8:0];
  _RAND_20 = {1{`RANDOM}};
  regAgentRowCnt = _RAND_20[6:0];
  _RAND_21 = {1{`RANDOM}};
  regBramRowCnt = _RAND_21[8:0];
  _RAND_22 = {1{`RANDOM}};
  regNRows = _RAND_22[5:0];
  _RAND_23 = {1{`RANDOM}};
  regNCols = _RAND_23[5:0];
  _RAND_24 = {1{`RANDOM}};
  regNBytesInRow = _RAND_24[8:0];
  _RAND_25 = {1{`RANDOM}};
  regNRowsReceived = _RAND_25[5:0];
  _RAND_26 = {1{`RANDOM}};
  regAgentRowInfo_rowAddr = _RAND_26[6:0];
  _RAND_27 = {1{`RANDOM}};
  regAgentRowInfo_length = _RAND_27[5:0];
  _RAND_28 = {1{`RANDOM}};
  regAgentRowInfoAgentIdx = _RAND_28[5:0];
  _RAND_29 = {1{`RANDOM}};
  regAgentHasValid = _RAND_29[0:0];
`endif // RANDOMIZE_REG_INIT
  `endif // RANDOMIZE
end // initial
`ifdef FIRRTL_AFTER_INITIAL
`FIRRTL_AFTER_INITIAL
`endif
`endif // SYNTHESIS
endmodule
module WriteReqGen(
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
  wire  _T = 2'h0 == regState; // @[Conditional.scala 37:30]
  wire  _T_1 = 2'h1 == regState; // @[Conditional.scala 37:30]
  wire [31:0] _regAddr_T_1 = regAddr + 32'h8; // @[MemReqGen.scala 79:32]
  wire [31:0] _regBytesLeft_T_1 = regBytesLeft - 32'h8; // @[MemReqGen.scala 80:42]
  wire [31:0] _GEN_1 = io_reqs_ready ? _regAddr_T_1 : regAddr; // @[MemReqGen.scala 77:32 MemReqGen.scala 79:21 MemReqGen.scala 41:24]
  wire [31:0] _GEN_2 = io_reqs_ready ? _regBytesLeft_T_1 : regBytesLeft; // @[MemReqGen.scala 77:32 MemReqGen.scala 80:26 MemReqGen.scala 42:29]
  wire  _GEN_7 = regBytesLeft == 32'h0 ? 1'h0 : 1'h1; // @[MemReqGen.scala 73:37 MemReqGen.scala 47:17]
  wire  _T_4 = 2'h2 == regState; // @[Conditional.scala 37:30]
  wire [1:0] _GEN_10 = ~io_ctrl_start ? 2'h0 : regState; // @[MemReqGen.scala 87:31 MemReqGen.scala 87:42 MemReqGen.scala 40:25]
  wire  _T_6 = 2'h3 == regState; // @[Conditional.scala 37:30]
  wire  _T_8 = ~reset; // @[MemReqGen.scala 93:15]
  wire  _GEN_16 = _T_1 & _GEN_7; // @[Conditional.scala 39:67 MemReqGen.scala 47:17]
  wire  _GEN_32 = ~_T & ~_T_1 & ~_T_4 & _T_6; // @[MemReqGen.scala 93:15]
  assign io_reqs_valid = _T ? 1'h0 : _GEN_16; // @[Conditional.scala 40:58 MemReqGen.scala 47:17]
  assign io_reqs_bits_addr = regAddr; // @[MemReqGen.scala 50:21]
  always @(posedge clock) begin
    if (reset) begin // @[MemReqGen.scala 40:25]
      regState <= 2'h0; // @[MemReqGen.scala 40:25]
    end else if (_T) begin // @[Conditional.scala 40:58]
      if (io_ctrl_start) begin // @[MemReqGen.scala 69:30]
        if (isUnaligned) begin // @[MemReqGen.scala 69:47]
          regState <= 2'h3;
        end else begin
          regState <= 2'h1;
        end
      end
    end else if (_T_1) begin // @[Conditional.scala 39:67]
      if (regBytesLeft == 32'h0) begin // @[MemReqGen.scala 73:37]
        regState <= 2'h2; // @[MemReqGen.scala 73:48]
      end
    end else if (_T_4) begin // @[Conditional.scala 39:67]
      regState <= _GEN_10;
    end
    if (reset) begin // @[MemReqGen.scala 41:24]
      regAddr <= 32'h0; // @[MemReqGen.scala 41:24]
    end else if (_T) begin // @[Conditional.scala 40:58]
      regAddr <= io_ctrl_baseAddr; // @[MemReqGen.scala 67:17]
    end else if (_T_1) begin // @[Conditional.scala 39:67]
      if (!(regBytesLeft == 32'h0)) begin // @[MemReqGen.scala 73:37]
        regAddr <= _GEN_1;
      end
    end
    if (reset) begin // @[MemReqGen.scala 42:29]
      regBytesLeft <= 32'h0; // @[MemReqGen.scala 42:29]
    end else if (_T) begin // @[Conditional.scala 40:58]
      regBytesLeft <= io_ctrl_byteCount; // @[MemReqGen.scala 68:22]
    end else if (_T_1) begin // @[Conditional.scala 39:67]
      if (!(regBytesLeft == 32'h0)) begin // @[MemReqGen.scala 73:37]
        regBytesLeft <= _GEN_2;
      end
    end
    `ifndef SYNTHESIS
    `ifdef PRINTF_COND
      if (`PRINTF_COND) begin
    `endif
        if (~_T & ~_T_1 & ~_T_4 & _T_6 & ~reset) begin
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
        if (_GEN_32 & _T_8) begin
          $fwrite(32'h80000002,"Unaligned addr? %d size? %d \n",unalignedAddr,unalignedSize); // @[MemReqGen.scala 94:15]
        end
    `ifdef PRINTF_COND
      end
    `endif
    `endif // SYNTHESIS
  end
// Register and memory initialization
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
endmodule
module StreamWriter(
  input         clock,
  input         reset,
  input         io_start,
  output        io_finished,
  input  [31:0] io_baseAddr,
  input  [31:0] io_byteCount,
  output        io_in_ready,
  input         io_in_valid,
  input  [63:0] io_in_bits,
  input         io_req_ready,
  output        io_req_valid,
  output [31:0] io_req_bits_addr,
  output [7:0]  io_req_bits_numBytes,
  input         io_wdat_ready,
  output        io_wdat_valid,
  output [63:0] io_wdat_bits,
  output        io_rsp_ready,
  input         io_rsp_valid
);
`ifdef RANDOMIZE_REG_INIT
  reg [31:0] _RAND_0;
  reg [31:0] _RAND_1;
`endif // RANDOMIZE_REG_INIT
  wire  WriteReqGen_clock; // @[StreamWriter.scala 60:18]
  wire  WriteReqGen_reset; // @[StreamWriter.scala 60:18]
  wire  WriteReqGen_io_ctrl_start; // @[StreamWriter.scala 60:18]
  wire [31:0] WriteReqGen_io_ctrl_baseAddr; // @[StreamWriter.scala 60:18]
  wire [31:0] WriteReqGen_io_ctrl_byteCount; // @[StreamWriter.scala 60:18]
  wire  WriteReqGen_io_reqs_ready; // @[StreamWriter.scala 60:18]
  wire  WriteReqGen_io_reqs_valid; // @[StreamWriter.scala 60:18]
  wire [31:0] WriteReqGen_io_reqs_bits_addr; // @[StreamWriter.scala 60:18]
  reg [31:0] regNumPendingReqs; // @[StreamWriter.scala 41:34]
  reg [31:0] regRequestedBytes; // @[StreamWriter.scala 42:34]
  wire  reqFired = io_req_valid & io_req_ready; // @[StreamWriter.scala 47:33]
  wire  rspFired = io_rsp_valid & io_rsp_ready; // @[StreamWriter.scala 48:33]
  wire [7:0] _regRequestedBytes_T = reqFired ? io_req_bits_numBytes : 8'h0; // @[StreamWriter.scala 49:49]
  wire [31:0] _GEN_4 = {{24'd0}, _regRequestedBytes_T}; // @[StreamWriter.scala 49:44]
  wire [31:0] _regRequestedBytes_T_2 = regRequestedBytes + _GEN_4; // @[StreamWriter.scala 49:44]
  wire [31:0] _regNumPendingReqs_T_1 = regNumPendingReqs + 32'h1; // @[StreamWriter.scala 50:74]
  wire [31:0] _regNumPendingReqs_T_3 = regNumPendingReqs - 32'h1; // @[StreamWriter.scala 51:79]
  wire  fin = regRequestedBytes == io_byteCount & regNumPendingReqs == 32'h0; // @[StreamWriter.scala 56:50]
  WriteReqGen WriteReqGen ( // @[StreamWriter.scala 60:18]
    .clock(WriteReqGen_clock),
    .reset(WriteReqGen_reset),
    .io_ctrl_start(WriteReqGen_io_ctrl_start),
    .io_ctrl_baseAddr(WriteReqGen_io_ctrl_baseAddr),
    .io_ctrl_byteCount(WriteReqGen_io_ctrl_byteCount),
    .io_reqs_ready(WriteReqGen_io_reqs_ready),
    .io_reqs_valid(WriteReqGen_io_reqs_valid),
    .io_reqs_bits_addr(WriteReqGen_io_reqs_bits_addr)
  );
  assign io_finished = io_start & fin; // @[StreamWriter.scala 57:27]
  assign io_in_ready = io_wdat_ready; // @[StreamWriter.scala 72:47]
  assign io_req_valid = WriteReqGen_io_reqs_valid; // @[StreamWriter.scala 69:11]
  assign io_req_bits_addr = WriteReqGen_io_reqs_bits_addr; // @[StreamWriter.scala 69:11]
  assign io_req_bits_numBytes = 8'h8; // @[StreamWriter.scala 69:11]
  assign io_wdat_valid = io_in_valid; // @[StreamWriter.scala 72:47]
  assign io_wdat_bits = io_in_bits; // @[StreamWriter.scala 72:47]
  assign io_rsp_ready = 1'h1; // @[StreamWriter.scala 39:16]
  assign WriteReqGen_clock = clock;
  assign WriteReqGen_reset = reset;
  assign WriteReqGen_io_ctrl_start = io_start; // @[StreamWriter.scala 61:17]
  assign WriteReqGen_io_ctrl_baseAddr = io_baseAddr; // @[StreamWriter.scala 62:20]
  assign WriteReqGen_io_ctrl_byteCount = io_byteCount; // @[StreamWriter.scala 63:21]
  assign WriteReqGen_io_reqs_ready = io_req_ready; // @[StreamWriter.scala 69:11]
  always @(posedge clock) begin
    if (reset) begin // @[StreamWriter.scala 41:34]
      regNumPendingReqs <= 32'h0; // @[StreamWriter.scala 41:34]
    end else if (~io_start) begin // @[StreamWriter.scala 43:19]
      regNumPendingReqs <= 32'h0; // @[StreamWriter.scala 44:23]
    end else if (reqFired & ~rspFired) begin // @[StreamWriter.scala 50:33]
      regNumPendingReqs <= _regNumPendingReqs_T_1; // @[StreamWriter.scala 50:53]
    end else if (~reqFired & rspFired) begin // @[StreamWriter.scala 51:38]
      regNumPendingReqs <= _regNumPendingReqs_T_3; // @[StreamWriter.scala 51:58]
    end
    if (reset) begin // @[StreamWriter.scala 42:34]
      regRequestedBytes <= 32'h0; // @[StreamWriter.scala 42:34]
    end else if (~io_start) begin // @[StreamWriter.scala 43:19]
      regRequestedBytes <= 32'h0; // @[StreamWriter.scala 45:23]
    end else begin
      regRequestedBytes <= _regRequestedBytes_T_2; // @[StreamWriter.scala 49:23]
    end
  end
// Register and memory initialization
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
  regNumPendingReqs = _RAND_0[31:0];
  _RAND_1 = {1{`RANDOM}};
  regRequestedBytes = _RAND_1[31:0];
`endif // RANDOMIZE_REG_INIT
  `endif // RANDOMIZE
end // initial
`ifdef FIRRTL_AFTER_INITIAL
`FIRRTL_AFTER_INITIAL
`endif
`endif // SYNTHESIS
endmodule
module ProcessingElementExtPrice(
  input        clock,
  input        reset,
  output       io_priceStore_req_valid,
  output [5:0] io_priceStore_req_bits_addr,
  output       io_priceStore_rsp_ready,
  input  [7:0] io_priceStore_rsp_bits_rdata,
  output       io_rewardIn_ready,
  input        io_rewardIn_valid,
  input  [7:0] io_rewardIn_bits_reward,
  input  [5:0] io_rewardIn_bits_idx,
  input        io_rewardIn_bits_last,
  input        io_PEResultOut_ready,
  output       io_PEResultOut_valid,
  output [7:0] io_PEResultOut_bits_benefit,
  output [5:0] io_PEResultOut_bits_id,
  output       io_PEResultOut_bits_last,
  input        io_accountantNotifyContinue
);
`ifdef RANDOMIZE_REG_INIT
  reg [31:0] _RAND_0;
  reg [31:0] _RAND_1;
  reg [31:0] _RAND_2;
  reg [31:0] _RAND_3;
  reg [31:0] _RAND_4;
  reg [31:0] _RAND_5;
`endif // RANDOMIZE_REG_INIT
  reg [1:0] regState; // @[ProcessingElementExtPrice.scala 40:25]
  reg [7:0] regReward; // @[ProcessingElementExtPrice.scala 41:26]
  reg [5:0] regIdx; // @[ProcessingElementExtPrice.scala 42:23]
  reg [7:0] regBenefit; // @[ProcessingElementExtPrice.scala 43:27]
  reg  regLast; // @[ProcessingElementExtPrice.scala 44:24]
  reg [7:0] regPrice; // @[ProcessingElementExtPrice.scala 45:25]
  wire  _T = 2'h0 == regState; // @[Conditional.scala 37:30]
  wire  _T_1 = io_rewardIn_bits_reward == 8'h0; // @[ProcessingElementExtPrice.scala 56:39]
  wire  _GEN_2 = io_rewardIn_bits_reward == 8'h0 ? 1'h0 : 1'h1; // @[ProcessingElementExtPrice.scala 56:48 ProcessingElementExtPrice.scala 29:25 ProcessingElementExtPrice.scala 64:35]
  wire  _GEN_10 = io_rewardIn_valid & _GEN_2; // @[ProcessingElementExtPrice.scala 55:31 ProcessingElementExtPrice.scala 29:25]
  wire  _T_5 = 2'h1 == regState; // @[Conditional.scala 37:30]
  wire [8:0] _T_6 = {1'b0,$signed(regReward)}; // @[ProcessingElementExtPrice.scala 78:32]
  wire [8:0] _T_7 = {1'b0,$signed(regPrice)}; // @[ProcessingElementExtPrice.scala 78:50]
  wire [8:0] _T_10 = $signed(_T_6) - $signed(_T_7); // @[ProcessingElementExtPrice.scala 78:35]
  wire  _T_15 = 2'h2 == regState; // @[Conditional.scala 37:30]
  wire  _T_16 = io_PEResultOut_ready & io_PEResultOut_valid; // @[Decoupled.scala 40:37]
  wire [1:0] _GEN_16 = regLast ? 2'h3 : 2'h0; // @[ProcessingElementExtPrice.scala 90:24 ProcessingElementExtPrice.scala 91:20 ProcessingElementExtPrice.scala 93:20]
  wire [7:0] _GEN_17 = regLast ? regPrice : 8'h0; // @[ProcessingElementExtPrice.scala 90:24 ProcessingElementExtPrice.scala 45:25 ProcessingElementExtPrice.scala 94:20]
  wire [5:0] _GEN_18 = regLast ? regIdx : 6'h0; // @[ProcessingElementExtPrice.scala 90:24 ProcessingElementExtPrice.scala 42:23 ProcessingElementExtPrice.scala 95:18]
  wire [7:0] _GEN_19 = regLast ? regBenefit : 8'h0; // @[ProcessingElementExtPrice.scala 90:24 ProcessingElementExtPrice.scala 43:27 ProcessingElementExtPrice.scala 96:22]
  wire [7:0] _GEN_20 = regLast ? regReward : 8'h0; // @[ProcessingElementExtPrice.scala 90:24 ProcessingElementExtPrice.scala 41:26 ProcessingElementExtPrice.scala 97:21]
  wire [1:0] _GEN_22 = _T_16 ? _GEN_16 : regState; // @[ProcessingElementExtPrice.scala 89:35 ProcessingElementExtPrice.scala 40:25]
  wire [7:0] _GEN_23 = _T_16 ? _GEN_17 : regPrice; // @[ProcessingElementExtPrice.scala 89:35 ProcessingElementExtPrice.scala 45:25]
  wire [5:0] _GEN_24 = _T_16 ? _GEN_18 : regIdx; // @[ProcessingElementExtPrice.scala 89:35 ProcessingElementExtPrice.scala 42:23]
  wire [7:0] _GEN_25 = _T_16 ? _GEN_19 : regBenefit; // @[ProcessingElementExtPrice.scala 89:35 ProcessingElementExtPrice.scala 43:27]
  wire [7:0] _GEN_26 = _T_16 ? _GEN_20 : regReward; // @[ProcessingElementExtPrice.scala 89:35 ProcessingElementExtPrice.scala 41:26]
  wire  _T_17 = 2'h3 == regState; // @[Conditional.scala 37:30]
  wire [1:0] _GEN_28 = io_accountantNotifyContinue ? 2'h0 : regState; // @[ProcessingElementExtPrice.scala 103:42 ProcessingElementExtPrice.scala 104:18 ProcessingElementExtPrice.scala 40:25]
  wire [7:0] _GEN_29 = io_accountantNotifyContinue ? 8'h0 : regPrice; // @[ProcessingElementExtPrice.scala 103:42 ProcessingElementExtPrice.scala 105:18 ProcessingElementExtPrice.scala 45:25]
  wire [5:0] _GEN_30 = io_accountantNotifyContinue ? 6'h0 : regIdx; // @[ProcessingElementExtPrice.scala 103:42 ProcessingElementExtPrice.scala 106:16 ProcessingElementExtPrice.scala 42:23]
  wire [7:0] _GEN_31 = io_accountantNotifyContinue ? 8'h0 : regBenefit; // @[ProcessingElementExtPrice.scala 103:42 ProcessingElementExtPrice.scala 107:20 ProcessingElementExtPrice.scala 43:27]
  wire [7:0] _GEN_32 = io_accountantNotifyContinue ? 8'h0 : regReward; // @[ProcessingElementExtPrice.scala 103:42 ProcessingElementExtPrice.scala 108:19 ProcessingElementExtPrice.scala 41:26]
  wire  _GEN_33 = io_accountantNotifyContinue ? 1'h0 : regLast; // @[ProcessingElementExtPrice.scala 103:42 ProcessingElementExtPrice.scala 109:17 ProcessingElementExtPrice.scala 44:24]
  wire [1:0] _GEN_34 = _T_17 ? _GEN_28 : regState; // @[Conditional.scala 39:67 ProcessingElementExtPrice.scala 40:25]
  wire [7:0] _GEN_35 = _T_17 ? _GEN_29 : regPrice; // @[Conditional.scala 39:67 ProcessingElementExtPrice.scala 45:25]
  wire [5:0] _GEN_36 = _T_17 ? _GEN_30 : regIdx; // @[Conditional.scala 39:67 ProcessingElementExtPrice.scala 42:23]
  wire [7:0] _GEN_37 = _T_17 ? _GEN_31 : regBenefit; // @[Conditional.scala 39:67 ProcessingElementExtPrice.scala 43:27]
  wire [7:0] _GEN_38 = _T_17 ? _GEN_32 : regReward; // @[Conditional.scala 39:67 ProcessingElementExtPrice.scala 41:26]
  wire  _GEN_39 = _T_17 ? _GEN_33 : regLast; // @[Conditional.scala 39:67 ProcessingElementExtPrice.scala 44:24]
  wire  _GEN_52 = _T_5 ? 1'h0 : _T_15; // @[Conditional.scala 39:67 ProcessingElementExtPrice.scala 27:23]
  assign io_priceStore_req_valid = _T & _GEN_10; // @[Conditional.scala 40:58 ProcessingElementExtPrice.scala 29:25]
  assign io_priceStore_req_bits_addr = io_rewardIn_bits_idx; // @[ProcessingElementExtPrice.scala 56:48 ProcessingElementExtPrice.scala 66:39]
  assign io_priceStore_rsp_ready = _T & _GEN_10; // @[Conditional.scala 40:58 ProcessingElementExtPrice.scala 29:25]
  assign io_rewardIn_ready = 2'h0 == regState; // @[Conditional.scala 37:30]
  assign io_PEResultOut_valid = _T ? 1'h0 : _GEN_52; // @[Conditional.scala 40:58 ProcessingElementExtPrice.scala 27:23]
  assign io_PEResultOut_bits_benefit = regBenefit; // @[Conditional.scala 39:67 ProcessingElementExtPrice.scala 86:35]
  assign io_PEResultOut_bits_id = regIdx; // @[Conditional.scala 39:67 ProcessingElementExtPrice.scala 87:30]
  assign io_PEResultOut_bits_last = regLast; // @[Conditional.scala 39:67 ProcessingElementExtPrice.scala 88:32]
  always @(posedge clock) begin
    if (reset) begin // @[ProcessingElementExtPrice.scala 40:25]
      regState <= 2'h0; // @[ProcessingElementExtPrice.scala 40:25]
    end else if (_T) begin // @[Conditional.scala 40:58]
      if (io_rewardIn_valid) begin // @[ProcessingElementExtPrice.scala 55:31]
        if (io_rewardIn_bits_reward == 8'h0) begin // @[ProcessingElementExtPrice.scala 56:48]
          regState <= 2'h3; // @[ProcessingElementExtPrice.scala 58:20]
        end else begin
          regState <= 2'h1; // @[ProcessingElementExtPrice.scala 71:20]
        end
      end
    end else if (_T_5) begin // @[Conditional.scala 39:67]
      regState <= 2'h2; // @[ProcessingElementExtPrice.scala 80:16]
    end else if (_T_15) begin // @[Conditional.scala 39:67]
      regState <= _GEN_22;
    end else begin
      regState <= _GEN_34;
    end
    if (reset) begin // @[ProcessingElementExtPrice.scala 41:26]
      regReward <= 8'h0; // @[ProcessingElementExtPrice.scala 41:26]
    end else if (_T) begin // @[Conditional.scala 40:58]
      if (io_rewardIn_valid) begin // @[ProcessingElementExtPrice.scala 55:31]
        if (!(io_rewardIn_bits_reward == 8'h0)) begin // @[ProcessingElementExtPrice.scala 56:48]
          regReward <= io_rewardIn_bits_reward; // @[ProcessingElementExtPrice.scala 70:21]
        end
      end
    end else if (!(_T_5)) begin // @[Conditional.scala 39:67]
      if (_T_15) begin // @[Conditional.scala 39:67]
        regReward <= _GEN_26;
      end else begin
        regReward <= _GEN_38;
      end
    end
    if (reset) begin // @[ProcessingElementExtPrice.scala 42:23]
      regIdx <= 6'h0; // @[ProcessingElementExtPrice.scala 42:23]
    end else if (_T) begin // @[Conditional.scala 40:58]
      if (io_rewardIn_valid) begin // @[ProcessingElementExtPrice.scala 55:31]
        if (!(io_rewardIn_bits_reward == 8'h0)) begin // @[ProcessingElementExtPrice.scala 56:48]
          regIdx <= io_rewardIn_bits_idx; // @[ProcessingElementExtPrice.scala 61:18]
        end
      end
    end else if (!(_T_5)) begin // @[Conditional.scala 39:67]
      if (_T_15) begin // @[Conditional.scala 39:67]
        regIdx <= _GEN_24;
      end else begin
        regIdx <= _GEN_36;
      end
    end
    if (reset) begin // @[ProcessingElementExtPrice.scala 43:27]
      regBenefit <= 8'h0; // @[ProcessingElementExtPrice.scala 43:27]
    end else if (!(_T)) begin // @[Conditional.scala 40:58]
      if (_T_5) begin // @[Conditional.scala 39:67]
        if (_T_10[8]) begin // @[ProcessingElementExtPrice.scala 79:24]
          regBenefit <= 8'h0;
        end else begin
          regBenefit <= _T_10[7:0];
        end
      end else if (_T_15) begin // @[Conditional.scala 39:67]
        regBenefit <= _GEN_25;
      end else begin
        regBenefit <= _GEN_37;
      end
    end
    if (reset) begin // @[ProcessingElementExtPrice.scala 44:24]
      regLast <= 1'h0; // @[ProcessingElementExtPrice.scala 44:24]
    end else if (_T) begin // @[Conditional.scala 40:58]
      if (io_rewardIn_valid) begin // @[ProcessingElementExtPrice.scala 55:31]
        if (!(io_rewardIn_bits_reward == 8'h0)) begin // @[ProcessingElementExtPrice.scala 56:48]
          regLast <= io_rewardIn_bits_last; // @[ProcessingElementExtPrice.scala 72:19]
        end
      end
    end else if (!(_T_5)) begin // @[Conditional.scala 39:67]
      if (!(_T_15)) begin // @[Conditional.scala 39:67]
        regLast <= _GEN_39;
      end
    end
    if (reset) begin // @[ProcessingElementExtPrice.scala 45:25]
      regPrice <= 8'h0; // @[ProcessingElementExtPrice.scala 45:25]
    end else if (_T) begin // @[Conditional.scala 40:58]
      if (io_rewardIn_valid) begin // @[ProcessingElementExtPrice.scala 55:31]
        if (!(io_rewardIn_bits_reward == 8'h0)) begin // @[ProcessingElementExtPrice.scala 56:48]
          regPrice <= io_priceStore_rsp_bits_rdata; // @[ProcessingElementExtPrice.scala 68:20]
        end
      end
    end else if (!(_T_5)) begin // @[Conditional.scala 39:67]
      if (_T_15) begin // @[Conditional.scala 39:67]
        regPrice <= _GEN_23;
      end else begin
        regPrice <= _GEN_35;
      end
    end
    `ifndef SYNTHESIS
    `ifdef PRINTF_COND
      if (`PRINTF_COND) begin
    `endif
        if (_T & io_rewardIn_valid & _T_1 & ~(io_rewardIn_bits_last | reset)) begin
          $fwrite(32'h80000002,
            "Assertion failed\n    at ProcessingElementExtPrice.scala:57 assert(io.rewardIn.bits.last)\n"); // @[ProcessingElementExtPrice.scala 57:17]
        end
    `ifdef PRINTF_COND
      end
    `endif
    `endif // SYNTHESIS
    `ifndef SYNTHESIS
    `ifdef STOP_COND
      if (`STOP_COND) begin
    `endif
        if (_T & io_rewardIn_valid & _T_1 & ~(io_rewardIn_bits_last | reset)) begin
          $fatal; // @[ProcessingElementExtPrice.scala 57:17]
        end
    `ifdef STOP_COND
      end
    `endif
    `endif // SYNTHESIS
  end
// Register and memory initialization
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
  regReward = _RAND_1[7:0];
  _RAND_2 = {1{`RANDOM}};
  regIdx = _RAND_2[5:0];
  _RAND_3 = {1{`RANDOM}};
  regBenefit = _RAND_3[7:0];
  _RAND_4 = {1{`RANDOM}};
  regLast = _RAND_4[0:0];
  _RAND_5 = {1{`RANDOM}};
  regPrice = _RAND_5[7:0];
`endif // RANDOMIZE_REG_INIT
  `endif // RANDOMIZE
end // initial
`ifdef FIRRTL_AFTER_INITIAL
`FIRRTL_AFTER_INITIAL
`endif
`endif // SYNTHESIS
endmodule
module SearchTaskPar(
  input        clock,
  input        reset,
  output       io_benefitIn_0_ready,
  input        io_benefitIn_0_valid,
  input  [7:0] io_benefitIn_0_bits_benefit,
  input  [5:0] io_benefitIn_0_bits_id,
  input        io_benefitIn_0_bits_last,
  output       io_benefitIn_1_ready,
  input        io_benefitIn_1_valid,
  input  [7:0] io_benefitIn_1_bits_benefit,
  input  [5:0] io_benefitIn_1_bits_id,
  output       io_benefitIn_2_ready,
  input        io_benefitIn_2_valid,
  input  [7:0] io_benefitIn_2_bits_benefit,
  input  [5:0] io_benefitIn_2_bits_id,
  output       io_benefitIn_3_ready,
  input        io_benefitIn_3_valid,
  input  [7:0] io_benefitIn_3_bits_benefit,
  input  [5:0] io_benefitIn_3_bits_id,
  output       io_benefitIn_4_ready,
  input        io_benefitIn_4_valid,
  input  [7:0] io_benefitIn_4_bits_benefit,
  input  [5:0] io_benefitIn_4_bits_id,
  output       io_benefitIn_5_ready,
  input        io_benefitIn_5_valid,
  input  [7:0] io_benefitIn_5_bits_benefit,
  input  [5:0] io_benefitIn_5_bits_id,
  output       io_benefitIn_6_ready,
  input        io_benefitIn_6_valid,
  input  [7:0] io_benefitIn_6_bits_benefit,
  input  [5:0] io_benefitIn_6_bits_id,
  output       io_benefitIn_7_ready,
  input        io_benefitIn_7_valid,
  input  [7:0] io_benefitIn_7_bits_benefit,
  input  [5:0] io_benefitIn_7_bits_id,
  input        io_resultOut_ready,
  output       io_resultOut_valid,
  output [5:0] io_resultOut_bits_winner,
  output [7:0] io_resultOut_bits_bid
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
  reg [31:0] _RAND_13;
  reg [31:0] _RAND_14;
  reg [31:0] _RAND_15;
  reg [31:0] _RAND_16;
  reg [31:0] _RAND_17;
  reg [31:0] _RAND_18;
  reg [31:0] _RAND_19;
  reg [31:0] _RAND_20;
  reg [31:0] _RAND_21;
  reg [31:0] _RAND_22;
  reg [31:0] _RAND_23;
  reg [31:0] _RAND_24;
  reg [31:0] _RAND_25;
  reg [31:0] _RAND_26;
  reg [31:0] _RAND_27;
  reg [31:0] _RAND_28;
  reg [31:0] _RAND_29;
  reg [31:0] _RAND_30;
  reg [31:0] _RAND_31;
  reg [31:0] _RAND_32;
  reg [31:0] _RAND_33;
  reg [31:0] _RAND_34;
  reg [31:0] _RAND_35;
  reg [31:0] _RAND_36;
  reg [31:0] _RAND_37;
  reg [31:0] _RAND_38;
  reg [31:0] _RAND_39;
  reg [31:0] _RAND_40;
  reg [31:0] _RAND_41;
  reg [31:0] _RAND_42;
  reg [31:0] _RAND_43;
  reg [31:0] _RAND_44;
  reg [31:0] _RAND_45;
  reg [31:0] _RAND_46;
  reg [31:0] _RAND_47;
  reg [31:0] _RAND_48;
  reg [31:0] _RAND_49;
  reg [31:0] _RAND_50;
  reg [31:0] _RAND_51;
  reg [31:0] _RAND_52;
  reg [31:0] _RAND_53;
`endif // RANDOMIZE_REG_INIT
  reg [7:0] compRegs_0_0_benefit; // @[SearchTaskParallel.scala 83:12]
  reg [5:0] compRegs_0_0_id; // @[SearchTaskParallel.scala 83:12]
  reg [7:0] compRegs_0_0_runningBid; // @[SearchTaskParallel.scala 83:12]
  reg [7:0] compRegs_0_1_benefit; // @[SearchTaskParallel.scala 83:12]
  reg [5:0] compRegs_0_1_id; // @[SearchTaskParallel.scala 83:12]
  reg [7:0] compRegs_0_1_runningBid; // @[SearchTaskParallel.scala 83:12]
  reg [7:0] compRegs_0_2_benefit; // @[SearchTaskParallel.scala 83:12]
  reg [5:0] compRegs_0_2_id; // @[SearchTaskParallel.scala 83:12]
  reg [7:0] compRegs_0_2_runningBid; // @[SearchTaskParallel.scala 83:12]
  reg [7:0] compRegs_0_3_benefit; // @[SearchTaskParallel.scala 83:12]
  reg [5:0] compRegs_0_3_id; // @[SearchTaskParallel.scala 83:12]
  reg [7:0] compRegs_0_3_runningBid; // @[SearchTaskParallel.scala 83:12]
  reg [7:0] compRegs_0_4_benefit; // @[SearchTaskParallel.scala 83:12]
  reg [5:0] compRegs_0_4_id; // @[SearchTaskParallel.scala 83:12]
  reg [7:0] compRegs_0_4_runningBid; // @[SearchTaskParallel.scala 83:12]
  reg [7:0] compRegs_0_5_benefit; // @[SearchTaskParallel.scala 83:12]
  reg [5:0] compRegs_0_5_id; // @[SearchTaskParallel.scala 83:12]
  reg [7:0] compRegs_0_5_runningBid; // @[SearchTaskParallel.scala 83:12]
  reg [7:0] compRegs_0_6_benefit; // @[SearchTaskParallel.scala 83:12]
  reg [5:0] compRegs_0_6_id; // @[SearchTaskParallel.scala 83:12]
  reg [7:0] compRegs_0_6_runningBid; // @[SearchTaskParallel.scala 83:12]
  reg [7:0] compRegs_0_7_benefit; // @[SearchTaskParallel.scala 83:12]
  reg [5:0] compRegs_0_7_id; // @[SearchTaskParallel.scala 83:12]
  reg [7:0] compRegs_0_7_runningBid; // @[SearchTaskParallel.scala 83:12]
  reg [7:0] compRegs_1_0_benefit; // @[SearchTaskParallel.scala 83:12]
  reg [5:0] compRegs_1_0_id; // @[SearchTaskParallel.scala 83:12]
  reg [7:0] compRegs_1_0_runningBid; // @[SearchTaskParallel.scala 83:12]
  reg [7:0] compRegs_1_1_benefit; // @[SearchTaskParallel.scala 83:12]
  reg [5:0] compRegs_1_1_id; // @[SearchTaskParallel.scala 83:12]
  reg [7:0] compRegs_1_1_runningBid; // @[SearchTaskParallel.scala 83:12]
  reg [7:0] compRegs_1_2_benefit; // @[SearchTaskParallel.scala 83:12]
  reg [5:0] compRegs_1_2_id; // @[SearchTaskParallel.scala 83:12]
  reg [7:0] compRegs_1_2_runningBid; // @[SearchTaskParallel.scala 83:12]
  reg [7:0] compRegs_1_3_benefit; // @[SearchTaskParallel.scala 83:12]
  reg [5:0] compRegs_1_3_id; // @[SearchTaskParallel.scala 83:12]
  reg [7:0] compRegs_1_3_runningBid; // @[SearchTaskParallel.scala 83:12]
  reg [7:0] compRegs_2_0_benefit; // @[SearchTaskParallel.scala 83:12]
  reg [5:0] compRegs_2_0_id; // @[SearchTaskParallel.scala 83:12]
  reg [7:0] compRegs_2_0_runningBid; // @[SearchTaskParallel.scala 83:12]
  reg [7:0] compRegs_2_1_benefit; // @[SearchTaskParallel.scala 83:12]
  reg [5:0] compRegs_2_1_id; // @[SearchTaskParallel.scala 83:12]
  reg [7:0] compRegs_2_1_runningBid; // @[SearchTaskParallel.scala 83:12]
  reg [7:0] compRegs_3_0_benefit; // @[SearchTaskParallel.scala 83:12]
  reg [5:0] compRegs_3_0_id; // @[SearchTaskParallel.scala 83:12]
  reg [7:0] compRegs_3_0_runningBid; // @[SearchTaskParallel.scala 83:12]
  reg [7:0] runningWinner_benefit; // @[SearchTaskParallel.scala 85:30]
  reg [5:0] runningWinner_id; // @[SearchTaskParallel.scala 85:30]
  reg [7:0] runningWinner_runningBid; // @[SearchTaskParallel.scala 85:30]
  reg  regIsLast_0; // @[SearchTaskParallel.scala 88:26]
  reg  regIsLast_1; // @[SearchTaskParallel.scala 88:26]
  reg  regIsLast_2; // @[SearchTaskParallel.scala 88:26]
  reg  regIsLast_3; // @[SearchTaskParallel.scala 88:26]
  reg [1:0] regState; // @[SearchTaskParallel.scala 92:25]
  reg [1:0] regCompCount; // @[SearchTaskParallel.scala 93:29]
  wire  _T = regState == 2'h1; // @[SearchTaskParallel.scala 98:17]
  wire [7:0] _T_3 = compRegs_0_0_benefit - compRegs_0_1_benefit; // @[SearchTaskParallel.scala 109:44]
  wire [7:0] _T_7 = compRegs_0_1_benefit - compRegs_0_0_benefit; // @[SearchTaskParallel.scala 115:45]
  wire [7:0] _T_12 = compRegs_0_2_benefit - compRegs_0_3_benefit; // @[SearchTaskParallel.scala 109:44]
  wire [7:0] _T_16 = compRegs_0_3_benefit - compRegs_0_2_benefit; // @[SearchTaskParallel.scala 115:45]
  wire [7:0] _T_21 = compRegs_0_4_benefit - compRegs_0_5_benefit; // @[SearchTaskParallel.scala 109:44]
  wire [7:0] _T_25 = compRegs_0_5_benefit - compRegs_0_4_benefit; // @[SearchTaskParallel.scala 115:45]
  wire [7:0] _T_30 = compRegs_0_6_benefit - compRegs_0_7_benefit; // @[SearchTaskParallel.scala 109:44]
  wire [7:0] _T_34 = compRegs_0_7_benefit - compRegs_0_6_benefit; // @[SearchTaskParallel.scala 115:45]
  wire [7:0] _T_39 = compRegs_1_0_benefit - compRegs_1_1_benefit; // @[SearchTaskParallel.scala 109:44]
  wire [7:0] _T_43 = compRegs_1_1_benefit - compRegs_1_0_benefit; // @[SearchTaskParallel.scala 115:45]
  wire [7:0] _T_48 = compRegs_1_2_benefit - compRegs_1_3_benefit; // @[SearchTaskParallel.scala 109:44]
  wire [7:0] _T_52 = compRegs_1_3_benefit - compRegs_1_2_benefit; // @[SearchTaskParallel.scala 115:45]
  wire [7:0] _T_57 = compRegs_2_0_benefit - compRegs_2_1_benefit; // @[SearchTaskParallel.scala 109:44]
  wire [7:0] _T_61 = compRegs_2_1_benefit - compRegs_2_0_benefit; // @[SearchTaskParallel.scala 115:45]
  wire  _T_65 = 2'h0 == regState; // @[Conditional.scala 37:30]
  wire  _T_66 = io_benefitIn_0_ready & io_benefitIn_0_valid; // @[Decoupled.scala 40:37]
  wire  _T_67 = io_benefitIn_1_ready & io_benefitIn_1_valid; // @[Decoupled.scala 40:37]
  wire  _T_68 = io_benefitIn_2_ready & io_benefitIn_2_valid; // @[Decoupled.scala 40:37]
  wire  _T_69 = io_benefitIn_3_ready & io_benefitIn_3_valid; // @[Decoupled.scala 40:37]
  wire  _T_70 = io_benefitIn_4_ready & io_benefitIn_4_valid; // @[Decoupled.scala 40:37]
  wire  _T_71 = io_benefitIn_5_ready & io_benefitIn_5_valid; // @[Decoupled.scala 40:37]
  wire  _T_72 = io_benefitIn_6_ready & io_benefitIn_6_valid; // @[Decoupled.scala 40:37]
  wire  _T_73 = io_benefitIn_7_ready & io_benefitIn_7_valid; // @[Decoupled.scala 40:37]
  wire  _T_97 = 2'h1 == regState; // @[Conditional.scala 37:30]
  wire [1:0] _T_100 = regCompCount + 2'h1; // @[SearchTaskParallel.scala 160:38]
  wire  _T_101 = 2'h2 == regState; // @[Conditional.scala 37:30]
  wire [7:0] _T_104 = compRegs_3_0_benefit - runningWinner_benefit; // @[SearchTaskParallel.scala 172:45]
  wire [7:0] _T_106 = _T_104 < compRegs_3_0_runningBid ? _T_104 : compRegs_3_0_runningBid; // @[SearchTaskParallel.scala 173:40]
  wire [7:0] _T_108 = runningWinner_benefit - compRegs_3_0_benefit; // @[SearchTaskParallel.scala 175:45]
  wire [7:0] _T_110 = _T_108 < runningWinner_runningBid ? _T_108 : runningWinner_runningBid; // @[SearchTaskParallel.scala 176:40]
  wire [5:0] _GEN_82 = compRegs_3_0_benefit > runningWinner_benefit ? compRegs_3_0_id : runningWinner_id; // @[SearchTaskParallel.scala 169:59 SearchTaskParallel.scala 170:26 SearchTaskParallel.scala 85:30]
  wire [7:0] _GEN_83 = compRegs_3_0_benefit > runningWinner_benefit ? compRegs_3_0_benefit : runningWinner_benefit; // @[SearchTaskParallel.scala 169:59 SearchTaskParallel.scala 171:31 SearchTaskParallel.scala 85:30]
  wire [7:0] _GEN_84 = compRegs_3_0_benefit > runningWinner_benefit ? _T_106 : _T_110; // @[SearchTaskParallel.scala 169:59 SearchTaskParallel.scala 173:34 SearchTaskParallel.scala 176:34]
  wire  _T_111 = 2'h3 == regState; // @[Conditional.scala 37:30]
  wire [7:0] _GEN_85 = runningWinner_runningBid == 8'h0 & runningWinner_benefit > 8'h0 ? 8'h1 : runningWinner_runningBid
    ; // @[SearchTaskParallel.scala 189:80 SearchTaskParallel.scala 190:33 SearchTaskParallel.scala 192:33]
  wire [5:0] _GEN_87 = regIsLast_3 ? runningWinner_id : 6'h0; // @[SearchTaskParallel.scala 186:52 SearchTaskParallel.scala 188:34 SearchTaskParallel.scala 46:27]
  wire [7:0] _GEN_88 = regIsLast_3 ? _GEN_85 : 8'h0; // @[SearchTaskParallel.scala 186:52 SearchTaskParallel.scala 47:24]
  wire [1:0] _GEN_89 = regIsLast_3 ? regState : 2'h0; // @[SearchTaskParallel.scala 186:52 SearchTaskParallel.scala 92:25 SearchTaskParallel.scala 196:18]
  wire  _T_116 = io_resultOut_ready & io_resultOut_valid; // @[Decoupled.scala 40:37]
  wire [7:0] _GEN_90 = _T_116 ? 8'h0 : runningWinner_benefit; // @[SearchTaskParallel.scala 199:33 SearchTaskParallel.scala 200:31 SearchTaskParallel.scala 85:30]
  wire [1:0] _GEN_91 = _T_116 ? 2'h0 : _GEN_89; // @[SearchTaskParallel.scala 199:33 SearchTaskParallel.scala 201:18]
  wire [5:0] _GEN_93 = _T_111 ? _GEN_87 : 6'h0; // @[Conditional.scala 39:67 SearchTaskParallel.scala 46:27]
  wire [7:0] _GEN_94 = _T_111 ? _GEN_88 : 8'h0; // @[Conditional.scala 39:67 SearchTaskParallel.scala 47:24]
  wire [1:0] _GEN_95 = _T_111 ? _GEN_91 : regState; // @[Conditional.scala 39:67 SearchTaskParallel.scala 92:25]
  wire [7:0] _GEN_96 = _T_111 ? _GEN_90 : runningWinner_benefit; // @[Conditional.scala 39:67 SearchTaskParallel.scala 85:30]
  wire  _GEN_101 = _T_101 ? 1'h0 : _T_111 & regIsLast_3; // @[Conditional.scala 39:67 SearchTaskParallel.scala 45:21]
  wire [5:0] _GEN_102 = _T_101 ? 6'h0 : _GEN_93; // @[Conditional.scala 39:67 SearchTaskParallel.scala 46:27]
  wire [7:0] _GEN_103 = _T_101 ? 8'h0 : _GEN_94; // @[Conditional.scala 39:67 SearchTaskParallel.scala 47:24]
  wire  _GEN_110 = _T_97 ? 1'h0 : _GEN_101; // @[Conditional.scala 39:67 SearchTaskParallel.scala 45:21]
  assign io_benefitIn_0_ready = 2'h0 == regState; // @[Conditional.scala 37:30]
  assign io_benefitIn_1_ready = 2'h0 == regState; // @[Conditional.scala 37:30]
  assign io_benefitIn_2_ready = 2'h0 == regState; // @[Conditional.scala 37:30]
  assign io_benefitIn_3_ready = 2'h0 == regState; // @[Conditional.scala 37:30]
  assign io_benefitIn_4_ready = 2'h0 == regState; // @[Conditional.scala 37:30]
  assign io_benefitIn_5_ready = 2'h0 == regState; // @[Conditional.scala 37:30]
  assign io_benefitIn_6_ready = 2'h0 == regState; // @[Conditional.scala 37:30]
  assign io_benefitIn_7_ready = 2'h0 == regState; // @[Conditional.scala 37:30]
  assign io_resultOut_valid = _T_65 ? 1'h0 : _GEN_110; // @[Conditional.scala 40:58 SearchTaskParallel.scala 135:26]
  assign io_resultOut_bits_winner = _T_97 ? 6'h0 : _GEN_102; // @[Conditional.scala 39:67 SearchTaskParallel.scala 46:27]
  assign io_resultOut_bits_bid = _T_97 ? 8'h0 : _GEN_103; // @[Conditional.scala 39:67 SearchTaskParallel.scala 47:24]
  always @(posedge clock) begin
    if (reset) begin // @[SearchTaskParallel.scala 83:12]
      compRegs_0_0_benefit <= 8'h0; // @[SearchTaskParallel.scala 83:12]
    end else if (_T_65) begin // @[Conditional.scala 40:58]
      if (_T_66 | _T_67 | _T_68 | _T_69 | _T_70 | _T_71 | _T_72 | _T_73) begin // @[SearchTaskParallel.scala 139:64]
        if (_T_66) begin // @[SearchTaskParallel.scala 144:40]
          compRegs_0_0_benefit <= io_benefitIn_0_bits_benefit; // @[SearchTaskParallel.scala 145:36]
        end else begin
          compRegs_0_0_benefit <= 8'h0; // @[SearchTaskParallel.scala 147:36]
        end
      end
    end
    if (reset) begin // @[SearchTaskParallel.scala 83:12]
      compRegs_0_0_id <= 6'h0; // @[SearchTaskParallel.scala 83:12]
    end else if (_T_65) begin // @[Conditional.scala 40:58]
      if (_T_66 | _T_67 | _T_68 | _T_69 | _T_70 | _T_71 | _T_72 | _T_73) begin // @[SearchTaskParallel.scala 139:64]
        compRegs_0_0_id <= io_benefitIn_0_bits_id; // @[SearchTaskParallel.scala 142:29]
      end
    end
    if (reset) begin // @[SearchTaskParallel.scala 83:12]
      compRegs_0_0_runningBid <= 8'h0; // @[SearchTaskParallel.scala 83:12]
    end else if (_T_65) begin // @[Conditional.scala 40:58]
      if (_T_66 | _T_67 | _T_68 | _T_69 | _T_70 | _T_71 | _T_72 | _T_73) begin // @[SearchTaskParallel.scala 139:64]
        compRegs_0_0_runningBid <= 8'hff; // @[SearchTaskParallel.scala 143:37]
      end
    end
    if (reset) begin // @[SearchTaskParallel.scala 83:12]
      compRegs_0_1_benefit <= 8'h0; // @[SearchTaskParallel.scala 83:12]
    end else if (_T_65) begin // @[Conditional.scala 40:58]
      if (_T_66 | _T_67 | _T_68 | _T_69 | _T_70 | _T_71 | _T_72 | _T_73) begin // @[SearchTaskParallel.scala 139:64]
        if (_T_67) begin // @[SearchTaskParallel.scala 144:40]
          compRegs_0_1_benefit <= io_benefitIn_1_bits_benefit; // @[SearchTaskParallel.scala 145:36]
        end else begin
          compRegs_0_1_benefit <= 8'h0; // @[SearchTaskParallel.scala 147:36]
        end
      end
    end
    if (reset) begin // @[SearchTaskParallel.scala 83:12]
      compRegs_0_1_id <= 6'h0; // @[SearchTaskParallel.scala 83:12]
    end else if (_T_65) begin // @[Conditional.scala 40:58]
      if (_T_66 | _T_67 | _T_68 | _T_69 | _T_70 | _T_71 | _T_72 | _T_73) begin // @[SearchTaskParallel.scala 139:64]
        compRegs_0_1_id <= io_benefitIn_1_bits_id; // @[SearchTaskParallel.scala 142:29]
      end
    end
    if (reset) begin // @[SearchTaskParallel.scala 83:12]
      compRegs_0_1_runningBid <= 8'h0; // @[SearchTaskParallel.scala 83:12]
    end else if (_T_65) begin // @[Conditional.scala 40:58]
      if (_T_66 | _T_67 | _T_68 | _T_69 | _T_70 | _T_71 | _T_72 | _T_73) begin // @[SearchTaskParallel.scala 139:64]
        compRegs_0_1_runningBid <= 8'hff; // @[SearchTaskParallel.scala 143:37]
      end
    end
    if (reset) begin // @[SearchTaskParallel.scala 83:12]
      compRegs_0_2_benefit <= 8'h0; // @[SearchTaskParallel.scala 83:12]
    end else if (_T_65) begin // @[Conditional.scala 40:58]
      if (_T_66 | _T_67 | _T_68 | _T_69 | _T_70 | _T_71 | _T_72 | _T_73) begin // @[SearchTaskParallel.scala 139:64]
        if (_T_68) begin // @[SearchTaskParallel.scala 144:40]
          compRegs_0_2_benefit <= io_benefitIn_2_bits_benefit; // @[SearchTaskParallel.scala 145:36]
        end else begin
          compRegs_0_2_benefit <= 8'h0; // @[SearchTaskParallel.scala 147:36]
        end
      end
    end
    if (reset) begin // @[SearchTaskParallel.scala 83:12]
      compRegs_0_2_id <= 6'h0; // @[SearchTaskParallel.scala 83:12]
    end else if (_T_65) begin // @[Conditional.scala 40:58]
      if (_T_66 | _T_67 | _T_68 | _T_69 | _T_70 | _T_71 | _T_72 | _T_73) begin // @[SearchTaskParallel.scala 139:64]
        compRegs_0_2_id <= io_benefitIn_2_bits_id; // @[SearchTaskParallel.scala 142:29]
      end
    end
    if (reset) begin // @[SearchTaskParallel.scala 83:12]
      compRegs_0_2_runningBid <= 8'h0; // @[SearchTaskParallel.scala 83:12]
    end else if (_T_65) begin // @[Conditional.scala 40:58]
      if (_T_66 | _T_67 | _T_68 | _T_69 | _T_70 | _T_71 | _T_72 | _T_73) begin // @[SearchTaskParallel.scala 139:64]
        compRegs_0_2_runningBid <= 8'hff; // @[SearchTaskParallel.scala 143:37]
      end
    end
    if (reset) begin // @[SearchTaskParallel.scala 83:12]
      compRegs_0_3_benefit <= 8'h0; // @[SearchTaskParallel.scala 83:12]
    end else if (_T_65) begin // @[Conditional.scala 40:58]
      if (_T_66 | _T_67 | _T_68 | _T_69 | _T_70 | _T_71 | _T_72 | _T_73) begin // @[SearchTaskParallel.scala 139:64]
        if (_T_69) begin // @[SearchTaskParallel.scala 144:40]
          compRegs_0_3_benefit <= io_benefitIn_3_bits_benefit; // @[SearchTaskParallel.scala 145:36]
        end else begin
          compRegs_0_3_benefit <= 8'h0; // @[SearchTaskParallel.scala 147:36]
        end
      end
    end
    if (reset) begin // @[SearchTaskParallel.scala 83:12]
      compRegs_0_3_id <= 6'h0; // @[SearchTaskParallel.scala 83:12]
    end else if (_T_65) begin // @[Conditional.scala 40:58]
      if (_T_66 | _T_67 | _T_68 | _T_69 | _T_70 | _T_71 | _T_72 | _T_73) begin // @[SearchTaskParallel.scala 139:64]
        compRegs_0_3_id <= io_benefitIn_3_bits_id; // @[SearchTaskParallel.scala 142:29]
      end
    end
    if (reset) begin // @[SearchTaskParallel.scala 83:12]
      compRegs_0_3_runningBid <= 8'h0; // @[SearchTaskParallel.scala 83:12]
    end else if (_T_65) begin // @[Conditional.scala 40:58]
      if (_T_66 | _T_67 | _T_68 | _T_69 | _T_70 | _T_71 | _T_72 | _T_73) begin // @[SearchTaskParallel.scala 139:64]
        compRegs_0_3_runningBid <= 8'hff; // @[SearchTaskParallel.scala 143:37]
      end
    end
    if (reset) begin // @[SearchTaskParallel.scala 83:12]
      compRegs_0_4_benefit <= 8'h0; // @[SearchTaskParallel.scala 83:12]
    end else if (_T_65) begin // @[Conditional.scala 40:58]
      if (_T_66 | _T_67 | _T_68 | _T_69 | _T_70 | _T_71 | _T_72 | _T_73) begin // @[SearchTaskParallel.scala 139:64]
        if (_T_70) begin // @[SearchTaskParallel.scala 144:40]
          compRegs_0_4_benefit <= io_benefitIn_4_bits_benefit; // @[SearchTaskParallel.scala 145:36]
        end else begin
          compRegs_0_4_benefit <= 8'h0; // @[SearchTaskParallel.scala 147:36]
        end
      end
    end
    if (reset) begin // @[SearchTaskParallel.scala 83:12]
      compRegs_0_4_id <= 6'h0; // @[SearchTaskParallel.scala 83:12]
    end else if (_T_65) begin // @[Conditional.scala 40:58]
      if (_T_66 | _T_67 | _T_68 | _T_69 | _T_70 | _T_71 | _T_72 | _T_73) begin // @[SearchTaskParallel.scala 139:64]
        compRegs_0_4_id <= io_benefitIn_4_bits_id; // @[SearchTaskParallel.scala 142:29]
      end
    end
    if (reset) begin // @[SearchTaskParallel.scala 83:12]
      compRegs_0_4_runningBid <= 8'h0; // @[SearchTaskParallel.scala 83:12]
    end else if (_T_65) begin // @[Conditional.scala 40:58]
      if (_T_66 | _T_67 | _T_68 | _T_69 | _T_70 | _T_71 | _T_72 | _T_73) begin // @[SearchTaskParallel.scala 139:64]
        compRegs_0_4_runningBid <= 8'hff; // @[SearchTaskParallel.scala 143:37]
      end
    end
    if (reset) begin // @[SearchTaskParallel.scala 83:12]
      compRegs_0_5_benefit <= 8'h0; // @[SearchTaskParallel.scala 83:12]
    end else if (_T_65) begin // @[Conditional.scala 40:58]
      if (_T_66 | _T_67 | _T_68 | _T_69 | _T_70 | _T_71 | _T_72 | _T_73) begin // @[SearchTaskParallel.scala 139:64]
        if (_T_71) begin // @[SearchTaskParallel.scala 144:40]
          compRegs_0_5_benefit <= io_benefitIn_5_bits_benefit; // @[SearchTaskParallel.scala 145:36]
        end else begin
          compRegs_0_5_benefit <= 8'h0; // @[SearchTaskParallel.scala 147:36]
        end
      end
    end
    if (reset) begin // @[SearchTaskParallel.scala 83:12]
      compRegs_0_5_id <= 6'h0; // @[SearchTaskParallel.scala 83:12]
    end else if (_T_65) begin // @[Conditional.scala 40:58]
      if (_T_66 | _T_67 | _T_68 | _T_69 | _T_70 | _T_71 | _T_72 | _T_73) begin // @[SearchTaskParallel.scala 139:64]
        compRegs_0_5_id <= io_benefitIn_5_bits_id; // @[SearchTaskParallel.scala 142:29]
      end
    end
    if (reset) begin // @[SearchTaskParallel.scala 83:12]
      compRegs_0_5_runningBid <= 8'h0; // @[SearchTaskParallel.scala 83:12]
    end else if (_T_65) begin // @[Conditional.scala 40:58]
      if (_T_66 | _T_67 | _T_68 | _T_69 | _T_70 | _T_71 | _T_72 | _T_73) begin // @[SearchTaskParallel.scala 139:64]
        compRegs_0_5_runningBid <= 8'hff; // @[SearchTaskParallel.scala 143:37]
      end
    end
    if (reset) begin // @[SearchTaskParallel.scala 83:12]
      compRegs_0_6_benefit <= 8'h0; // @[SearchTaskParallel.scala 83:12]
    end else if (_T_65) begin // @[Conditional.scala 40:58]
      if (_T_66 | _T_67 | _T_68 | _T_69 | _T_70 | _T_71 | _T_72 | _T_73) begin // @[SearchTaskParallel.scala 139:64]
        if (_T_72) begin // @[SearchTaskParallel.scala 144:40]
          compRegs_0_6_benefit <= io_benefitIn_6_bits_benefit; // @[SearchTaskParallel.scala 145:36]
        end else begin
          compRegs_0_6_benefit <= 8'h0; // @[SearchTaskParallel.scala 147:36]
        end
      end
    end
    if (reset) begin // @[SearchTaskParallel.scala 83:12]
      compRegs_0_6_id <= 6'h0; // @[SearchTaskParallel.scala 83:12]
    end else if (_T_65) begin // @[Conditional.scala 40:58]
      if (_T_66 | _T_67 | _T_68 | _T_69 | _T_70 | _T_71 | _T_72 | _T_73) begin // @[SearchTaskParallel.scala 139:64]
        compRegs_0_6_id <= io_benefitIn_6_bits_id; // @[SearchTaskParallel.scala 142:29]
      end
    end
    if (reset) begin // @[SearchTaskParallel.scala 83:12]
      compRegs_0_6_runningBid <= 8'h0; // @[SearchTaskParallel.scala 83:12]
    end else if (_T_65) begin // @[Conditional.scala 40:58]
      if (_T_66 | _T_67 | _T_68 | _T_69 | _T_70 | _T_71 | _T_72 | _T_73) begin // @[SearchTaskParallel.scala 139:64]
        compRegs_0_6_runningBid <= 8'hff; // @[SearchTaskParallel.scala 143:37]
      end
    end
    if (reset) begin // @[SearchTaskParallel.scala 83:12]
      compRegs_0_7_benefit <= 8'h0; // @[SearchTaskParallel.scala 83:12]
    end else if (_T_65) begin // @[Conditional.scala 40:58]
      if (_T_66 | _T_67 | _T_68 | _T_69 | _T_70 | _T_71 | _T_72 | _T_73) begin // @[SearchTaskParallel.scala 139:64]
        if (_T_73) begin // @[SearchTaskParallel.scala 144:40]
          compRegs_0_7_benefit <= io_benefitIn_7_bits_benefit; // @[SearchTaskParallel.scala 145:36]
        end else begin
          compRegs_0_7_benefit <= 8'h0; // @[SearchTaskParallel.scala 147:36]
        end
      end
    end
    if (reset) begin // @[SearchTaskParallel.scala 83:12]
      compRegs_0_7_id <= 6'h0; // @[SearchTaskParallel.scala 83:12]
    end else if (_T_65) begin // @[Conditional.scala 40:58]
      if (_T_66 | _T_67 | _T_68 | _T_69 | _T_70 | _T_71 | _T_72 | _T_73) begin // @[SearchTaskParallel.scala 139:64]
        compRegs_0_7_id <= io_benefitIn_7_bits_id; // @[SearchTaskParallel.scala 142:29]
      end
    end
    if (reset) begin // @[SearchTaskParallel.scala 83:12]
      compRegs_0_7_runningBid <= 8'h0; // @[SearchTaskParallel.scala 83:12]
    end else if (_T_65) begin // @[Conditional.scala 40:58]
      if (_T_66 | _T_67 | _T_68 | _T_69 | _T_70 | _T_71 | _T_72 | _T_73) begin // @[SearchTaskParallel.scala 139:64]
        compRegs_0_7_runningBid <= 8'hff; // @[SearchTaskParallel.scala 143:37]
      end
    end
    if (reset) begin // @[SearchTaskParallel.scala 83:12]
      compRegs_1_0_benefit <= 8'h0; // @[SearchTaskParallel.scala 83:12]
    end else if (regState == 2'h1) begin // @[SearchTaskParallel.scala 98:31]
      if (compRegs_0_0_benefit >= compRegs_0_1_benefit) begin // @[SearchTaskParallel.scala 105:57]
        compRegs_1_0_benefit <= compRegs_0_0_benefit; // @[SearchTaskParallel.scala 108:34]
      end else begin
        compRegs_1_0_benefit <= compRegs_0_1_benefit; // @[SearchTaskParallel.scala 114:34]
      end
    end
    if (reset) begin // @[SearchTaskParallel.scala 83:12]
      compRegs_1_0_id <= 6'h0; // @[SearchTaskParallel.scala 83:12]
    end else if (regState == 2'h1) begin // @[SearchTaskParallel.scala 98:31]
      if (compRegs_0_0_benefit >= compRegs_0_1_benefit) begin // @[SearchTaskParallel.scala 105:57]
        compRegs_1_0_id <= compRegs_0_0_id; // @[SearchTaskParallel.scala 107:29]
      end else begin
        compRegs_1_0_id <= compRegs_0_1_id; // @[SearchTaskParallel.scala 113:29]
      end
    end
    if (reset) begin // @[SearchTaskParallel.scala 83:12]
      compRegs_1_0_runningBid <= 8'h0; // @[SearchTaskParallel.scala 83:12]
    end else if (regState == 2'h1) begin // @[SearchTaskParallel.scala 98:31]
      if (compRegs_0_0_benefit >= compRegs_0_1_benefit) begin // @[SearchTaskParallel.scala 105:57]
        if (_T_3 < compRegs_0_0_runningBid) begin // @[SearchTaskParallel.scala 110:43]
          compRegs_1_0_runningBid <= _T_3;
        end else begin
          compRegs_1_0_runningBid <= compRegs_0_0_runningBid;
        end
      end else if (_T_7 < compRegs_0_1_runningBid) begin // @[SearchTaskParallel.scala 116:43]
        compRegs_1_0_runningBid <= _T_7;
      end else begin
        compRegs_1_0_runningBid <= compRegs_0_1_runningBid;
      end
    end
    if (reset) begin // @[SearchTaskParallel.scala 83:12]
      compRegs_1_1_benefit <= 8'h0; // @[SearchTaskParallel.scala 83:12]
    end else if (regState == 2'h1) begin // @[SearchTaskParallel.scala 98:31]
      if (compRegs_0_2_benefit >= compRegs_0_3_benefit) begin // @[SearchTaskParallel.scala 105:57]
        compRegs_1_1_benefit <= compRegs_0_2_benefit; // @[SearchTaskParallel.scala 108:34]
      end else begin
        compRegs_1_1_benefit <= compRegs_0_3_benefit; // @[SearchTaskParallel.scala 114:34]
      end
    end
    if (reset) begin // @[SearchTaskParallel.scala 83:12]
      compRegs_1_1_id <= 6'h0; // @[SearchTaskParallel.scala 83:12]
    end else if (regState == 2'h1) begin // @[SearchTaskParallel.scala 98:31]
      if (compRegs_0_2_benefit >= compRegs_0_3_benefit) begin // @[SearchTaskParallel.scala 105:57]
        compRegs_1_1_id <= compRegs_0_2_id; // @[SearchTaskParallel.scala 107:29]
      end else begin
        compRegs_1_1_id <= compRegs_0_3_id; // @[SearchTaskParallel.scala 113:29]
      end
    end
    if (reset) begin // @[SearchTaskParallel.scala 83:12]
      compRegs_1_1_runningBid <= 8'h0; // @[SearchTaskParallel.scala 83:12]
    end else if (regState == 2'h1) begin // @[SearchTaskParallel.scala 98:31]
      if (compRegs_0_2_benefit >= compRegs_0_3_benefit) begin // @[SearchTaskParallel.scala 105:57]
        if (_T_12 < compRegs_0_2_runningBid) begin // @[SearchTaskParallel.scala 110:43]
          compRegs_1_1_runningBid <= _T_12;
        end else begin
          compRegs_1_1_runningBid <= compRegs_0_2_runningBid;
        end
      end else if (_T_16 < compRegs_0_3_runningBid) begin // @[SearchTaskParallel.scala 116:43]
        compRegs_1_1_runningBid <= _T_16;
      end else begin
        compRegs_1_1_runningBid <= compRegs_0_3_runningBid;
      end
    end
    if (reset) begin // @[SearchTaskParallel.scala 83:12]
      compRegs_1_2_benefit <= 8'h0; // @[SearchTaskParallel.scala 83:12]
    end else if (regState == 2'h1) begin // @[SearchTaskParallel.scala 98:31]
      if (compRegs_0_4_benefit >= compRegs_0_5_benefit) begin // @[SearchTaskParallel.scala 105:57]
        compRegs_1_2_benefit <= compRegs_0_4_benefit; // @[SearchTaskParallel.scala 108:34]
      end else begin
        compRegs_1_2_benefit <= compRegs_0_5_benefit; // @[SearchTaskParallel.scala 114:34]
      end
    end
    if (reset) begin // @[SearchTaskParallel.scala 83:12]
      compRegs_1_2_id <= 6'h0; // @[SearchTaskParallel.scala 83:12]
    end else if (regState == 2'h1) begin // @[SearchTaskParallel.scala 98:31]
      if (compRegs_0_4_benefit >= compRegs_0_5_benefit) begin // @[SearchTaskParallel.scala 105:57]
        compRegs_1_2_id <= compRegs_0_4_id; // @[SearchTaskParallel.scala 107:29]
      end else begin
        compRegs_1_2_id <= compRegs_0_5_id; // @[SearchTaskParallel.scala 113:29]
      end
    end
    if (reset) begin // @[SearchTaskParallel.scala 83:12]
      compRegs_1_2_runningBid <= 8'h0; // @[SearchTaskParallel.scala 83:12]
    end else if (regState == 2'h1) begin // @[SearchTaskParallel.scala 98:31]
      if (compRegs_0_4_benefit >= compRegs_0_5_benefit) begin // @[SearchTaskParallel.scala 105:57]
        if (_T_21 < compRegs_0_4_runningBid) begin // @[SearchTaskParallel.scala 110:43]
          compRegs_1_2_runningBid <= _T_21;
        end else begin
          compRegs_1_2_runningBid <= compRegs_0_4_runningBid;
        end
      end else if (_T_25 < compRegs_0_5_runningBid) begin // @[SearchTaskParallel.scala 116:43]
        compRegs_1_2_runningBid <= _T_25;
      end else begin
        compRegs_1_2_runningBid <= compRegs_0_5_runningBid;
      end
    end
    if (reset) begin // @[SearchTaskParallel.scala 83:12]
      compRegs_1_3_benefit <= 8'h0; // @[SearchTaskParallel.scala 83:12]
    end else if (regState == 2'h1) begin // @[SearchTaskParallel.scala 98:31]
      if (compRegs_0_6_benefit >= compRegs_0_7_benefit) begin // @[SearchTaskParallel.scala 105:57]
        compRegs_1_3_benefit <= compRegs_0_6_benefit; // @[SearchTaskParallel.scala 108:34]
      end else begin
        compRegs_1_3_benefit <= compRegs_0_7_benefit; // @[SearchTaskParallel.scala 114:34]
      end
    end
    if (reset) begin // @[SearchTaskParallel.scala 83:12]
      compRegs_1_3_id <= 6'h0; // @[SearchTaskParallel.scala 83:12]
    end else if (regState == 2'h1) begin // @[SearchTaskParallel.scala 98:31]
      if (compRegs_0_6_benefit >= compRegs_0_7_benefit) begin // @[SearchTaskParallel.scala 105:57]
        compRegs_1_3_id <= compRegs_0_6_id; // @[SearchTaskParallel.scala 107:29]
      end else begin
        compRegs_1_3_id <= compRegs_0_7_id; // @[SearchTaskParallel.scala 113:29]
      end
    end
    if (reset) begin // @[SearchTaskParallel.scala 83:12]
      compRegs_1_3_runningBid <= 8'h0; // @[SearchTaskParallel.scala 83:12]
    end else if (regState == 2'h1) begin // @[SearchTaskParallel.scala 98:31]
      if (compRegs_0_6_benefit >= compRegs_0_7_benefit) begin // @[SearchTaskParallel.scala 105:57]
        if (_T_30 < compRegs_0_6_runningBid) begin // @[SearchTaskParallel.scala 110:43]
          compRegs_1_3_runningBid <= _T_30;
        end else begin
          compRegs_1_3_runningBid <= compRegs_0_6_runningBid;
        end
      end else if (_T_34 < compRegs_0_7_runningBid) begin // @[SearchTaskParallel.scala 116:43]
        compRegs_1_3_runningBid <= _T_34;
      end else begin
        compRegs_1_3_runningBid <= compRegs_0_7_runningBid;
      end
    end
    if (reset) begin // @[SearchTaskParallel.scala 83:12]
      compRegs_2_0_benefit <= 8'h0; // @[SearchTaskParallel.scala 83:12]
    end else if (regState == 2'h1) begin // @[SearchTaskParallel.scala 98:31]
      if (compRegs_1_0_benefit >= compRegs_1_1_benefit) begin // @[SearchTaskParallel.scala 105:57]
        compRegs_2_0_benefit <= compRegs_1_0_benefit; // @[SearchTaskParallel.scala 108:34]
      end else begin
        compRegs_2_0_benefit <= compRegs_1_1_benefit; // @[SearchTaskParallel.scala 114:34]
      end
    end
    if (reset) begin // @[SearchTaskParallel.scala 83:12]
      compRegs_2_0_id <= 6'h0; // @[SearchTaskParallel.scala 83:12]
    end else if (regState == 2'h1) begin // @[SearchTaskParallel.scala 98:31]
      if (compRegs_1_0_benefit >= compRegs_1_1_benefit) begin // @[SearchTaskParallel.scala 105:57]
        compRegs_2_0_id <= compRegs_1_0_id; // @[SearchTaskParallel.scala 107:29]
      end else begin
        compRegs_2_0_id <= compRegs_1_1_id; // @[SearchTaskParallel.scala 113:29]
      end
    end
    if (reset) begin // @[SearchTaskParallel.scala 83:12]
      compRegs_2_0_runningBid <= 8'h0; // @[SearchTaskParallel.scala 83:12]
    end else if (regState == 2'h1) begin // @[SearchTaskParallel.scala 98:31]
      if (compRegs_1_0_benefit >= compRegs_1_1_benefit) begin // @[SearchTaskParallel.scala 105:57]
        if (_T_39 < compRegs_1_0_runningBid) begin // @[SearchTaskParallel.scala 110:43]
          compRegs_2_0_runningBid <= _T_39;
        end else begin
          compRegs_2_0_runningBid <= compRegs_1_0_runningBid;
        end
      end else if (_T_43 < compRegs_1_1_runningBid) begin // @[SearchTaskParallel.scala 116:43]
        compRegs_2_0_runningBid <= _T_43;
      end else begin
        compRegs_2_0_runningBid <= compRegs_1_1_runningBid;
      end
    end
    if (reset) begin // @[SearchTaskParallel.scala 83:12]
      compRegs_2_1_benefit <= 8'h0; // @[SearchTaskParallel.scala 83:12]
    end else if (regState == 2'h1) begin // @[SearchTaskParallel.scala 98:31]
      if (compRegs_1_2_benefit >= compRegs_1_3_benefit) begin // @[SearchTaskParallel.scala 105:57]
        compRegs_2_1_benefit <= compRegs_1_2_benefit; // @[SearchTaskParallel.scala 108:34]
      end else begin
        compRegs_2_1_benefit <= compRegs_1_3_benefit; // @[SearchTaskParallel.scala 114:34]
      end
    end
    if (reset) begin // @[SearchTaskParallel.scala 83:12]
      compRegs_2_1_id <= 6'h0; // @[SearchTaskParallel.scala 83:12]
    end else if (regState == 2'h1) begin // @[SearchTaskParallel.scala 98:31]
      if (compRegs_1_2_benefit >= compRegs_1_3_benefit) begin // @[SearchTaskParallel.scala 105:57]
        compRegs_2_1_id <= compRegs_1_2_id; // @[SearchTaskParallel.scala 107:29]
      end else begin
        compRegs_2_1_id <= compRegs_1_3_id; // @[SearchTaskParallel.scala 113:29]
      end
    end
    if (reset) begin // @[SearchTaskParallel.scala 83:12]
      compRegs_2_1_runningBid <= 8'h0; // @[SearchTaskParallel.scala 83:12]
    end else if (regState == 2'h1) begin // @[SearchTaskParallel.scala 98:31]
      if (compRegs_1_2_benefit >= compRegs_1_3_benefit) begin // @[SearchTaskParallel.scala 105:57]
        if (_T_48 < compRegs_1_2_runningBid) begin // @[SearchTaskParallel.scala 110:43]
          compRegs_2_1_runningBid <= _T_48;
        end else begin
          compRegs_2_1_runningBid <= compRegs_1_2_runningBid;
        end
      end else if (_T_52 < compRegs_1_3_runningBid) begin // @[SearchTaskParallel.scala 116:43]
        compRegs_2_1_runningBid <= _T_52;
      end else begin
        compRegs_2_1_runningBid <= compRegs_1_3_runningBid;
      end
    end
    if (reset) begin // @[SearchTaskParallel.scala 83:12]
      compRegs_3_0_benefit <= 8'h0; // @[SearchTaskParallel.scala 83:12]
    end else if (regState == 2'h1) begin // @[SearchTaskParallel.scala 98:31]
      if (compRegs_2_0_benefit >= compRegs_2_1_benefit) begin // @[SearchTaskParallel.scala 105:57]
        compRegs_3_0_benefit <= compRegs_2_0_benefit; // @[SearchTaskParallel.scala 108:34]
      end else begin
        compRegs_3_0_benefit <= compRegs_2_1_benefit; // @[SearchTaskParallel.scala 114:34]
      end
    end
    if (reset) begin // @[SearchTaskParallel.scala 83:12]
      compRegs_3_0_id <= 6'h0; // @[SearchTaskParallel.scala 83:12]
    end else if (regState == 2'h1) begin // @[SearchTaskParallel.scala 98:31]
      if (compRegs_2_0_benefit >= compRegs_2_1_benefit) begin // @[SearchTaskParallel.scala 105:57]
        compRegs_3_0_id <= compRegs_2_0_id; // @[SearchTaskParallel.scala 107:29]
      end else begin
        compRegs_3_0_id <= compRegs_2_1_id; // @[SearchTaskParallel.scala 113:29]
      end
    end
    if (reset) begin // @[SearchTaskParallel.scala 83:12]
      compRegs_3_0_runningBid <= 8'h0; // @[SearchTaskParallel.scala 83:12]
    end else if (regState == 2'h1) begin // @[SearchTaskParallel.scala 98:31]
      if (compRegs_2_0_benefit >= compRegs_2_1_benefit) begin // @[SearchTaskParallel.scala 105:57]
        if (_T_57 < compRegs_2_0_runningBid) begin // @[SearchTaskParallel.scala 110:43]
          compRegs_3_0_runningBid <= _T_57;
        end else begin
          compRegs_3_0_runningBid <= compRegs_2_0_runningBid;
        end
      end else if (_T_61 < compRegs_2_1_runningBid) begin // @[SearchTaskParallel.scala 116:43]
        compRegs_3_0_runningBid <= _T_61;
      end else begin
        compRegs_3_0_runningBid <= compRegs_2_1_runningBid;
      end
    end
    if (reset) begin // @[SearchTaskParallel.scala 85:30]
      runningWinner_benefit <= 8'h0; // @[SearchTaskParallel.scala 85:30]
    end else if (!(_T_65)) begin // @[Conditional.scala 40:58]
      if (!(_T_97)) begin // @[Conditional.scala 39:67]
        if (_T_101) begin // @[Conditional.scala 39:67]
          runningWinner_benefit <= _GEN_83;
        end else begin
          runningWinner_benefit <= _GEN_96;
        end
      end
    end
    if (reset) begin // @[SearchTaskParallel.scala 85:30]
      runningWinner_id <= 6'h0; // @[SearchTaskParallel.scala 85:30]
    end else if (!(_T_65)) begin // @[Conditional.scala 40:58]
      if (!(_T_97)) begin // @[Conditional.scala 39:67]
        if (_T_101) begin // @[Conditional.scala 39:67]
          runningWinner_id <= _GEN_82;
        end
      end
    end
    if (reset) begin // @[SearchTaskParallel.scala 85:30]
      runningWinner_runningBid <= 8'h0; // @[SearchTaskParallel.scala 85:30]
    end else if (!(_T_65)) begin // @[Conditional.scala 40:58]
      if (!(_T_97)) begin // @[Conditional.scala 39:67]
        if (_T_101) begin // @[Conditional.scala 39:67]
          runningWinner_runningBid <= _GEN_84;
        end
      end
    end
    if (reset) begin // @[SearchTaskParallel.scala 88:26]
      regIsLast_0 <= 1'h0; // @[SearchTaskParallel.scala 88:26]
    end else if (_T_65) begin // @[Conditional.scala 40:58]
      if (_T_66 | _T_67 | _T_68 | _T_69 | _T_70 | _T_71 | _T_72 | _T_73) begin // @[SearchTaskParallel.scala 139:64]
        regIsLast_0 <= io_benefitIn_0_bits_last; // @[SearchTaskParallel.scala 140:22]
      end
    end
    if (reset) begin // @[SearchTaskParallel.scala 88:26]
      regIsLast_1 <= 1'h0; // @[SearchTaskParallel.scala 88:26]
    end else if (_T) begin // @[SearchTaskParallel.scala 122:31]
      regIsLast_1 <= regIsLast_0; // @[SearchTaskParallel.scala 124:18]
    end
    if (reset) begin // @[SearchTaskParallel.scala 88:26]
      regIsLast_2 <= 1'h0; // @[SearchTaskParallel.scala 88:26]
    end else if (_T) begin // @[SearchTaskParallel.scala 122:31]
      regIsLast_2 <= regIsLast_1; // @[SearchTaskParallel.scala 124:18]
    end
    if (reset) begin // @[SearchTaskParallel.scala 88:26]
      regIsLast_3 <= 1'h0; // @[SearchTaskParallel.scala 88:26]
    end else if (_T) begin // @[SearchTaskParallel.scala 122:31]
      regIsLast_3 <= regIsLast_2; // @[SearchTaskParallel.scala 124:18]
    end
    if (reset) begin // @[SearchTaskParallel.scala 92:25]
      regState <= 2'h0; // @[SearchTaskParallel.scala 92:25]
    end else if (_T_65) begin // @[Conditional.scala 40:58]
      if (_T_66 | _T_67 | _T_68 | _T_69 | _T_70 | _T_71 | _T_72 | _T_73) begin // @[SearchTaskParallel.scala 139:64]
        regState <= 2'h1; // @[SearchTaskParallel.scala 150:18]
      end
    end else if (_T_97) begin // @[Conditional.scala 39:67]
      if (regCompCount == 2'h2) begin // @[SearchTaskParallel.scala 157:53]
        regState <= 2'h2; // @[SearchTaskParallel.scala 158:18]
      end
    end else if (_T_101) begin // @[Conditional.scala 39:67]
      regState <= 2'h3; // @[SearchTaskParallel.scala 180:16]
    end else begin
      regState <= _GEN_95;
    end
    if (reset) begin // @[SearchTaskParallel.scala 93:29]
      regCompCount <= 2'h0; // @[SearchTaskParallel.scala 93:29]
    end else if (_T_65) begin // @[Conditional.scala 40:58]
      if (_T_66 | _T_67 | _T_68 | _T_69 | _T_70 | _T_71 | _T_72 | _T_73) begin // @[SearchTaskParallel.scala 139:64]
        regCompCount <= 2'h0; // @[SearchTaskParallel.scala 151:22]
      end
    end else if (_T_97) begin // @[Conditional.scala 39:67]
      if (!(regCompCount == 2'h2)) begin // @[SearchTaskParallel.scala 157:53]
        regCompCount <= _T_100; // @[SearchTaskParallel.scala 160:22]
      end
    end
  end
// Register and memory initialization
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
  compRegs_0_0_benefit = _RAND_0[7:0];
  _RAND_1 = {1{`RANDOM}};
  compRegs_0_0_id = _RAND_1[5:0];
  _RAND_2 = {1{`RANDOM}};
  compRegs_0_0_runningBid = _RAND_2[7:0];
  _RAND_3 = {1{`RANDOM}};
  compRegs_0_1_benefit = _RAND_3[7:0];
  _RAND_4 = {1{`RANDOM}};
  compRegs_0_1_id = _RAND_4[5:0];
  _RAND_5 = {1{`RANDOM}};
  compRegs_0_1_runningBid = _RAND_5[7:0];
  _RAND_6 = {1{`RANDOM}};
  compRegs_0_2_benefit = _RAND_6[7:0];
  _RAND_7 = {1{`RANDOM}};
  compRegs_0_2_id = _RAND_7[5:0];
  _RAND_8 = {1{`RANDOM}};
  compRegs_0_2_runningBid = _RAND_8[7:0];
  _RAND_9 = {1{`RANDOM}};
  compRegs_0_3_benefit = _RAND_9[7:0];
  _RAND_10 = {1{`RANDOM}};
  compRegs_0_3_id = _RAND_10[5:0];
  _RAND_11 = {1{`RANDOM}};
  compRegs_0_3_runningBid = _RAND_11[7:0];
  _RAND_12 = {1{`RANDOM}};
  compRegs_0_4_benefit = _RAND_12[7:0];
  _RAND_13 = {1{`RANDOM}};
  compRegs_0_4_id = _RAND_13[5:0];
  _RAND_14 = {1{`RANDOM}};
  compRegs_0_4_runningBid = _RAND_14[7:0];
  _RAND_15 = {1{`RANDOM}};
  compRegs_0_5_benefit = _RAND_15[7:0];
  _RAND_16 = {1{`RANDOM}};
  compRegs_0_5_id = _RAND_16[5:0];
  _RAND_17 = {1{`RANDOM}};
  compRegs_0_5_runningBid = _RAND_17[7:0];
  _RAND_18 = {1{`RANDOM}};
  compRegs_0_6_benefit = _RAND_18[7:0];
  _RAND_19 = {1{`RANDOM}};
  compRegs_0_6_id = _RAND_19[5:0];
  _RAND_20 = {1{`RANDOM}};
  compRegs_0_6_runningBid = _RAND_20[7:0];
  _RAND_21 = {1{`RANDOM}};
  compRegs_0_7_benefit = _RAND_21[7:0];
  _RAND_22 = {1{`RANDOM}};
  compRegs_0_7_id = _RAND_22[5:0];
  _RAND_23 = {1{`RANDOM}};
  compRegs_0_7_runningBid = _RAND_23[7:0];
  _RAND_24 = {1{`RANDOM}};
  compRegs_1_0_benefit = _RAND_24[7:0];
  _RAND_25 = {1{`RANDOM}};
  compRegs_1_0_id = _RAND_25[5:0];
  _RAND_26 = {1{`RANDOM}};
  compRegs_1_0_runningBid = _RAND_26[7:0];
  _RAND_27 = {1{`RANDOM}};
  compRegs_1_1_benefit = _RAND_27[7:0];
  _RAND_28 = {1{`RANDOM}};
  compRegs_1_1_id = _RAND_28[5:0];
  _RAND_29 = {1{`RANDOM}};
  compRegs_1_1_runningBid = _RAND_29[7:0];
  _RAND_30 = {1{`RANDOM}};
  compRegs_1_2_benefit = _RAND_30[7:0];
  _RAND_31 = {1{`RANDOM}};
  compRegs_1_2_id = _RAND_31[5:0];
  _RAND_32 = {1{`RANDOM}};
  compRegs_1_2_runningBid = _RAND_32[7:0];
  _RAND_33 = {1{`RANDOM}};
  compRegs_1_3_benefit = _RAND_33[7:0];
  _RAND_34 = {1{`RANDOM}};
  compRegs_1_3_id = _RAND_34[5:0];
  _RAND_35 = {1{`RANDOM}};
  compRegs_1_3_runningBid = _RAND_35[7:0];
  _RAND_36 = {1{`RANDOM}};
  compRegs_2_0_benefit = _RAND_36[7:0];
  _RAND_37 = {1{`RANDOM}};
  compRegs_2_0_id = _RAND_37[5:0];
  _RAND_38 = {1{`RANDOM}};
  compRegs_2_0_runningBid = _RAND_38[7:0];
  _RAND_39 = {1{`RANDOM}};
  compRegs_2_1_benefit = _RAND_39[7:0];
  _RAND_40 = {1{`RANDOM}};
  compRegs_2_1_id = _RAND_40[5:0];
  _RAND_41 = {1{`RANDOM}};
  compRegs_2_1_runningBid = _RAND_41[7:0];
  _RAND_42 = {1{`RANDOM}};
  compRegs_3_0_benefit = _RAND_42[7:0];
  _RAND_43 = {1{`RANDOM}};
  compRegs_3_0_id = _RAND_43[5:0];
  _RAND_44 = {1{`RANDOM}};
  compRegs_3_0_runningBid = _RAND_44[7:0];
  _RAND_45 = {1{`RANDOM}};
  runningWinner_benefit = _RAND_45[7:0];
  _RAND_46 = {1{`RANDOM}};
  runningWinner_id = _RAND_46[5:0];
  _RAND_47 = {1{`RANDOM}};
  runningWinner_runningBid = _RAND_47[7:0];
  _RAND_48 = {1{`RANDOM}};
  regIsLast_0 = _RAND_48[0:0];
  _RAND_49 = {1{`RANDOM}};
  regIsLast_1 = _RAND_49[0:0];
  _RAND_50 = {1{`RANDOM}};
  regIsLast_2 = _RAND_50[0:0];
  _RAND_51 = {1{`RANDOM}};
  regIsLast_3 = _RAND_51[0:0];
  _RAND_52 = {1{`RANDOM}};
  regState = _RAND_52[1:0];
  _RAND_53 = {1{`RANDOM}};
  regCompCount = _RAND_53[1:0];
`endif // RANDOMIZE_REG_INIT
  `endif // RANDOMIZE
end // initial
`ifdef FIRRTL_AFTER_INITIAL
`FIRRTL_AFTER_INITIAL
`endif
`endif // SYNTHESIS
endmodule
module AuctionBram(
  input         clock,
  input         reset,
  input         io_memPort_0_memRdReq_ready,
  output        io_memPort_0_memRdReq_valid,
  output [31:0] io_memPort_0_memRdReq_bits_addr,
  output [7:0]  io_memPort_0_memRdReq_bits_numBytes,
  output        io_memPort_0_memRdRsp_ready,
  input         io_memPort_0_memRdRsp_valid,
  input  [63:0] io_memPort_0_memRdRsp_bits_readData,
  input         io_memPort_0_memWrReq_ready,
  output        io_memPort_0_memWrReq_valid,
  output [31:0] io_memPort_0_memWrReq_bits_addr,
  input         io_memPort_0_memWrDat_ready,
  output        io_memPort_0_memWrDat_valid,
  output [63:0] io_memPort_0_memWrDat_bits,
  input         io_memPort_0_memWrRsp_valid,
  output        io_rfOut_finished,
  output [31:0] io_rfOut_cycleCount,
  input         io_rfIn_start,
  input  [63:0] io_rfIn_baseAddr,
  input  [31:0] io_rfIn_nAgents,
  input  [31:0] io_rfIn_nObjects,
  input  [63:0] io_rfIn_baseAddrRes
);
`ifdef RANDOMIZE_REG_INIT
  reg [31:0] _RAND_0;
  reg [31:0] _RAND_1;
`endif // RANDOMIZE_REG_INIT
  wire  memController_clock; // @[AuctionBram.scala 35:29]
  wire  memController_reset; // @[AuctionBram.scala 35:29]
  wire  memController_io_unassignedAgents_ready; // @[AuctionBram.scala 35:29]
  wire  memController_io_unassignedAgents_valid; // @[AuctionBram.scala 35:29]
  wire [5:0] memController_io_unassignedAgents_bits_agent; // @[AuctionBram.scala 35:29]
  wire  memController_io_requestedAgents_ready; // @[AuctionBram.scala 35:29]
  wire  memController_io_requestedAgents_valid; // @[AuctionBram.scala 35:29]
  wire [5:0] memController_io_requestedAgents_bits_agent; // @[AuctionBram.scala 35:29]
  wire  memController_io_agentRowAddrReq_req_valid; // @[AuctionBram.scala 35:29]
  wire [5:0] memController_io_agentRowAddrReq_req_bits_addr; // @[AuctionBram.scala 35:29]
  wire  memController_io_agentRowAddrReq_rsp_ready; // @[AuctionBram.scala 35:29]
  wire [6:0] memController_io_agentRowAddrReq_rsp_bits_rdata_rowAddr; // @[AuctionBram.scala 35:29]
  wire [5:0] memController_io_agentRowAddrReq_rsp_bits_rdata_length; // @[AuctionBram.scala 35:29]
  wire [8:0] memController_io_bramReq_req_addr; // @[AuctionBram.scala 35:29]
  wire [119:0] memController_io_bramReq_rsp_readData; // @[AuctionBram.scala 35:29]
  wire  memController_io_dataDistOut_ready; // @[AuctionBram.scala 35:29]
  wire  memController_io_dataDistOut_valid; // @[AuctionBram.scala 35:29]
  wire [7:0] memController_io_dataDistOut_bits_els_0_reward; // @[AuctionBram.scala 35:29]
  wire [5:0] memController_io_dataDistOut_bits_els_0_idx; // @[AuctionBram.scala 35:29]
  wire [7:0] memController_io_dataDistOut_bits_els_1_reward; // @[AuctionBram.scala 35:29]
  wire [5:0] memController_io_dataDistOut_bits_els_1_idx; // @[AuctionBram.scala 35:29]
  wire [7:0] memController_io_dataDistOut_bits_els_2_reward; // @[AuctionBram.scala 35:29]
  wire [5:0] memController_io_dataDistOut_bits_els_2_idx; // @[AuctionBram.scala 35:29]
  wire [7:0] memController_io_dataDistOut_bits_els_3_reward; // @[AuctionBram.scala 35:29]
  wire [5:0] memController_io_dataDistOut_bits_els_3_idx; // @[AuctionBram.scala 35:29]
  wire [7:0] memController_io_dataDistOut_bits_els_4_reward; // @[AuctionBram.scala 35:29]
  wire [5:0] memController_io_dataDistOut_bits_els_4_idx; // @[AuctionBram.scala 35:29]
  wire [7:0] memController_io_dataDistOut_bits_els_5_reward; // @[AuctionBram.scala 35:29]
  wire [5:0] memController_io_dataDistOut_bits_els_5_idx; // @[AuctionBram.scala 35:29]
  wire [7:0] memController_io_dataDistOut_bits_els_6_reward; // @[AuctionBram.scala 35:29]
  wire [5:0] memController_io_dataDistOut_bits_els_6_idx; // @[AuctionBram.scala 35:29]
  wire [7:0] memController_io_dataDistOut_bits_els_7_reward; // @[AuctionBram.scala 35:29]
  wire [5:0] memController_io_dataDistOut_bits_els_7_idx; // @[AuctionBram.scala 35:29]
  wire  memController_io_dataDistOut_bits_last; // @[AuctionBram.scala 35:29]
  wire  controller_clock; // @[AuctionBram.scala 40:26]
  wire  controller_reset; // @[AuctionBram.scala 40:26]
  wire  controller_io_rfCtrl_finished; // @[AuctionBram.scala 40:26]
  wire  controller_io_rfInfo_start; // @[AuctionBram.scala 40:26]
  wire [63:0] controller_io_rfInfo_baseAddr; // @[AuctionBram.scala 40:26]
  wire [31:0] controller_io_rfInfo_nAgents; // @[AuctionBram.scala 40:26]
  wire [31:0] controller_io_rfInfo_nObjects; // @[AuctionBram.scala 40:26]
  wire  controller_io_dram2bram_start; // @[AuctionBram.scala 40:26]
  wire  controller_io_dram2bram_finished; // @[AuctionBram.scala 40:26]
  wire [63:0] controller_io_dram2bram_baseAddr; // @[AuctionBram.scala 40:26]
  wire [5:0] controller_io_dram2bram_nRows; // @[AuctionBram.scala 40:26]
  wire [5:0] controller_io_dram2bram_nCols; // @[AuctionBram.scala 40:26]
  wire  controller_io_unassignedAgentsIn_ready; // @[AuctionBram.scala 40:26]
  wire  controller_io_unassignedAgentsIn_valid; // @[AuctionBram.scala 40:26]
  wire [7:0] controller_io_unassignedAgentsIn_bits_agent; // @[AuctionBram.scala 40:26]
  wire  controller_io_unassignedAgentsOut_ready; // @[AuctionBram.scala 40:26]
  wire  controller_io_unassignedAgentsOut_valid; // @[AuctionBram.scala 40:26]
  wire [7:0] controller_io_unassignedAgentsOut_bits_agent; // @[AuctionBram.scala 40:26]
  wire  controller_io_requestedAgentsIn_ready; // @[AuctionBram.scala 40:26]
  wire  controller_io_requestedAgentsIn_valid; // @[AuctionBram.scala 40:26]
  wire [7:0] controller_io_requestedAgentsIn_bits_agent; // @[AuctionBram.scala 40:26]
  wire  controller_io_requestedAgentsOut_ready; // @[AuctionBram.scala 40:26]
  wire  controller_io_requestedAgentsOut_valid; // @[AuctionBram.scala 40:26]
  wire [7:0] controller_io_requestedAgentsOut_bits_agent; // @[AuctionBram.scala 40:26]
  wire  controller_io_doWriteBack; // @[AuctionBram.scala 40:26]
  wire  controller_io_writeBackDone; // @[AuctionBram.scala 40:26]
  wire  controller_io_reinit; // @[AuctionBram.scala 40:26]
  wire  accountant_clock; // @[AuctionBram.scala 45:26]
  wire  accountant_reset; // @[AuctionBram.scala 45:26]
  wire  accountant_io_searchResultIn_ready; // @[AuctionBram.scala 45:26]
  wire  accountant_io_searchResultIn_valid; // @[AuctionBram.scala 45:26]
  wire [5:0] accountant_io_searchResultIn_bits_winner; // @[AuctionBram.scala 45:26]
  wire [7:0] accountant_io_searchResultIn_bits_bid; // @[AuctionBram.scala 45:26]
  wire  accountant_io_unassignedAgents_ready; // @[AuctionBram.scala 45:26]
  wire  accountant_io_unassignedAgents_valid; // @[AuctionBram.scala 45:26]
  wire [7:0] accountant_io_unassignedAgents_bits_agent; // @[AuctionBram.scala 45:26]
  wire  accountant_io_requestedAgents_ready; // @[AuctionBram.scala 45:26]
  wire  accountant_io_requestedAgents_valid; // @[AuctionBram.scala 45:26]
  wire [7:0] accountant_io_requestedAgents_bits_agent; // @[AuctionBram.scala 45:26]
  wire [31:0] accountant_io_rfInfo_nObjects; // @[AuctionBram.scala 45:26]
  wire  accountant_io_doWriteBack; // @[AuctionBram.scala 45:26]
  wire  accountant_io_writeBackDone; // @[AuctionBram.scala 45:26]
  wire  accountant_io_writeBackStream_start; // @[AuctionBram.scala 45:26]
  wire  accountant_io_writeBackStream_wrData_ready; // @[AuctionBram.scala 45:26]
  wire  accountant_io_writeBackStream_wrData_valid; // @[AuctionBram.scala 45:26]
  wire [63:0] accountant_io_writeBackStream_wrData_bits; // @[AuctionBram.scala 45:26]
  wire  accountant_io_writeBackStream_finished; // @[AuctionBram.scala 45:26]
  wire  accountant_io_priceStore_req_valid; // @[AuctionBram.scala 45:26]
  wire  accountant_io_priceStore_req_bits_wen; // @[AuctionBram.scala 45:26]
  wire [5:0] accountant_io_priceStore_req_bits_addr; // @[AuctionBram.scala 45:26]
  wire [7:0] accountant_io_priceStore_req_bits_wdata; // @[AuctionBram.scala 45:26]
  wire  accountant_io_priceStore_rsp_valid; // @[AuctionBram.scala 45:26]
  wire [7:0] accountant_io_priceStore_rsp_bits_rdata; // @[AuctionBram.scala 45:26]
  wire  accountant_io_notifyPEsContinue; // @[AuctionBram.scala 45:26]
  wire  dataMux_clock; // @[AuctionBram.scala 50:23]
  wire  dataMux_reset; // @[AuctionBram.scala 50:23]
  wire  dataMux_io_bramWordIn_ready; // @[AuctionBram.scala 50:23]
  wire  dataMux_io_bramWordIn_valid; // @[AuctionBram.scala 50:23]
  wire [7:0] dataMux_io_bramWordIn_bits_els_0_reward; // @[AuctionBram.scala 50:23]
  wire [5:0] dataMux_io_bramWordIn_bits_els_0_idx; // @[AuctionBram.scala 50:23]
  wire [7:0] dataMux_io_bramWordIn_bits_els_1_reward; // @[AuctionBram.scala 50:23]
  wire [5:0] dataMux_io_bramWordIn_bits_els_1_idx; // @[AuctionBram.scala 50:23]
  wire [7:0] dataMux_io_bramWordIn_bits_els_2_reward; // @[AuctionBram.scala 50:23]
  wire [5:0] dataMux_io_bramWordIn_bits_els_2_idx; // @[AuctionBram.scala 50:23]
  wire [7:0] dataMux_io_bramWordIn_bits_els_3_reward; // @[AuctionBram.scala 50:23]
  wire [5:0] dataMux_io_bramWordIn_bits_els_3_idx; // @[AuctionBram.scala 50:23]
  wire [7:0] dataMux_io_bramWordIn_bits_els_4_reward; // @[AuctionBram.scala 50:23]
  wire [5:0] dataMux_io_bramWordIn_bits_els_4_idx; // @[AuctionBram.scala 50:23]
  wire [7:0] dataMux_io_bramWordIn_bits_els_5_reward; // @[AuctionBram.scala 50:23]
  wire [5:0] dataMux_io_bramWordIn_bits_els_5_idx; // @[AuctionBram.scala 50:23]
  wire [7:0] dataMux_io_bramWordIn_bits_els_6_reward; // @[AuctionBram.scala 50:23]
  wire [5:0] dataMux_io_bramWordIn_bits_els_6_idx; // @[AuctionBram.scala 50:23]
  wire [7:0] dataMux_io_bramWordIn_bits_els_7_reward; // @[AuctionBram.scala 50:23]
  wire [5:0] dataMux_io_bramWordIn_bits_els_7_idx; // @[AuctionBram.scala 50:23]
  wire  dataMux_io_bramWordIn_bits_last; // @[AuctionBram.scala 50:23]
  wire  dataMux_io_peOut_0_ready; // @[AuctionBram.scala 50:23]
  wire  dataMux_io_peOut_0_valid; // @[AuctionBram.scala 50:23]
  wire [7:0] dataMux_io_peOut_0_bits_reward; // @[AuctionBram.scala 50:23]
  wire [5:0] dataMux_io_peOut_0_bits_idx; // @[AuctionBram.scala 50:23]
  wire  dataMux_io_peOut_0_bits_last; // @[AuctionBram.scala 50:23]
  wire  dataMux_io_peOut_1_valid; // @[AuctionBram.scala 50:23]
  wire [7:0] dataMux_io_peOut_1_bits_reward; // @[AuctionBram.scala 50:23]
  wire [5:0] dataMux_io_peOut_1_bits_idx; // @[AuctionBram.scala 50:23]
  wire  dataMux_io_peOut_1_bits_last; // @[AuctionBram.scala 50:23]
  wire  dataMux_io_peOut_2_valid; // @[AuctionBram.scala 50:23]
  wire [7:0] dataMux_io_peOut_2_bits_reward; // @[AuctionBram.scala 50:23]
  wire [5:0] dataMux_io_peOut_2_bits_idx; // @[AuctionBram.scala 50:23]
  wire  dataMux_io_peOut_2_bits_last; // @[AuctionBram.scala 50:23]
  wire  dataMux_io_peOut_3_valid; // @[AuctionBram.scala 50:23]
  wire [7:0] dataMux_io_peOut_3_bits_reward; // @[AuctionBram.scala 50:23]
  wire [5:0] dataMux_io_peOut_3_bits_idx; // @[AuctionBram.scala 50:23]
  wire  dataMux_io_peOut_3_bits_last; // @[AuctionBram.scala 50:23]
  wire  dataMux_io_peOut_4_valid; // @[AuctionBram.scala 50:23]
  wire [7:0] dataMux_io_peOut_4_bits_reward; // @[AuctionBram.scala 50:23]
  wire [5:0] dataMux_io_peOut_4_bits_idx; // @[AuctionBram.scala 50:23]
  wire  dataMux_io_peOut_4_bits_last; // @[AuctionBram.scala 50:23]
  wire  dataMux_io_peOut_5_valid; // @[AuctionBram.scala 50:23]
  wire [7:0] dataMux_io_peOut_5_bits_reward; // @[AuctionBram.scala 50:23]
  wire [5:0] dataMux_io_peOut_5_bits_idx; // @[AuctionBram.scala 50:23]
  wire  dataMux_io_peOut_5_bits_last; // @[AuctionBram.scala 50:23]
  wire  dataMux_io_peOut_6_valid; // @[AuctionBram.scala 50:23]
  wire [7:0] dataMux_io_peOut_6_bits_reward; // @[AuctionBram.scala 50:23]
  wire [5:0] dataMux_io_peOut_6_bits_idx; // @[AuctionBram.scala 50:23]
  wire  dataMux_io_peOut_6_bits_last; // @[AuctionBram.scala 50:23]
  wire  dataMux_io_peOut_7_valid; // @[AuctionBram.scala 50:23]
  wire [7:0] dataMux_io_peOut_7_bits_reward; // @[AuctionBram.scala 50:23]
  wire [5:0] dataMux_io_peOut_7_bits_idx; // @[AuctionBram.scala 50:23]
  wire  dataMux_io_peOut_7_bits_last; // @[AuctionBram.scala 50:23]
  wire  qUnassignedAgents_clock; // @[AuctionBram.scala 53:33]
  wire  qUnassignedAgents_reset; // @[AuctionBram.scala 53:33]
  wire  qUnassignedAgents_io_enq_ready; // @[AuctionBram.scala 53:33]
  wire  qUnassignedAgents_io_enq_valid; // @[AuctionBram.scala 53:33]
  wire [7:0] qUnassignedAgents_io_enq_bits_agent; // @[AuctionBram.scala 53:33]
  wire  qUnassignedAgents_io_deq_ready; // @[AuctionBram.scala 53:33]
  wire  qUnassignedAgents_io_deq_valid; // @[AuctionBram.scala 53:33]
  wire [7:0] qUnassignedAgents_io_deq_bits_agent; // @[AuctionBram.scala 53:33]
  wire  qRequestedAgents_clock; // @[AuctionBram.scala 54:32]
  wire  qRequestedAgents_reset; // @[AuctionBram.scala 54:32]
  wire  qRequestedAgents_io_enq_ready; // @[AuctionBram.scala 54:32]
  wire  qRequestedAgents_io_enq_valid; // @[AuctionBram.scala 54:32]
  wire [7:0] qRequestedAgents_io_enq_bits_agent; // @[AuctionBram.scala 54:32]
  wire  qRequestedAgents_io_deq_ready; // @[AuctionBram.scala 54:32]
  wire  qRequestedAgents_io_deq_valid; // @[AuctionBram.scala 54:32]
  wire [7:0] qRequestedAgents_io_deq_bits_agent; // @[AuctionBram.scala 54:32]
  wire  bram_clock; // @[AuctionBram.scala 58:20]
  wire [8:0] bram_io_read_req_addr; // @[AuctionBram.scala 58:20]
  wire [119:0] bram_io_read_rsp_readData; // @[AuctionBram.scala 58:20]
  wire [8:0] bram_io_write_req_addr; // @[AuctionBram.scala 58:20]
  wire [119:0] bram_io_write_req_writeData; // @[AuctionBram.scala 58:20]
  wire  bram_io_write_req_writeEn; // @[AuctionBram.scala 58:20]
  wire  priceStore_clock; // @[AuctionBram.scala 59:26]
  wire  priceStore_reset; // @[AuctionBram.scala 59:26]
  wire  priceStore_io_rPorts_0_req_ready; // @[AuctionBram.scala 59:26]
  wire  priceStore_io_rPorts_0_req_valid; // @[AuctionBram.scala 59:26]
  wire [5:0] priceStore_io_rPorts_0_req_bits_addr; // @[AuctionBram.scala 59:26]
  wire  priceStore_io_rPorts_0_rsp_ready; // @[AuctionBram.scala 59:26]
  wire [7:0] priceStore_io_rPorts_0_rsp_bits_rdata; // @[AuctionBram.scala 59:26]
  wire  priceStore_io_rPorts_1_req_ready; // @[AuctionBram.scala 59:26]
  wire  priceStore_io_rPorts_1_req_valid; // @[AuctionBram.scala 59:26]
  wire [5:0] priceStore_io_rPorts_1_req_bits_addr; // @[AuctionBram.scala 59:26]
  wire  priceStore_io_rPorts_1_rsp_ready; // @[AuctionBram.scala 59:26]
  wire [7:0] priceStore_io_rPorts_1_rsp_bits_rdata; // @[AuctionBram.scala 59:26]
  wire  priceStore_io_rPorts_2_req_ready; // @[AuctionBram.scala 59:26]
  wire  priceStore_io_rPorts_2_req_valid; // @[AuctionBram.scala 59:26]
  wire [5:0] priceStore_io_rPorts_2_req_bits_addr; // @[AuctionBram.scala 59:26]
  wire  priceStore_io_rPorts_2_rsp_ready; // @[AuctionBram.scala 59:26]
  wire [7:0] priceStore_io_rPorts_2_rsp_bits_rdata; // @[AuctionBram.scala 59:26]
  wire  priceStore_io_rPorts_3_req_ready; // @[AuctionBram.scala 59:26]
  wire  priceStore_io_rPorts_3_req_valid; // @[AuctionBram.scala 59:26]
  wire [5:0] priceStore_io_rPorts_3_req_bits_addr; // @[AuctionBram.scala 59:26]
  wire  priceStore_io_rPorts_3_rsp_ready; // @[AuctionBram.scala 59:26]
  wire [7:0] priceStore_io_rPorts_3_rsp_bits_rdata; // @[AuctionBram.scala 59:26]
  wire  priceStore_io_rPorts_4_req_ready; // @[AuctionBram.scala 59:26]
  wire  priceStore_io_rPorts_4_req_valid; // @[AuctionBram.scala 59:26]
  wire [5:0] priceStore_io_rPorts_4_req_bits_addr; // @[AuctionBram.scala 59:26]
  wire  priceStore_io_rPorts_4_rsp_ready; // @[AuctionBram.scala 59:26]
  wire [7:0] priceStore_io_rPorts_4_rsp_bits_rdata; // @[AuctionBram.scala 59:26]
  wire  priceStore_io_rPorts_5_req_ready; // @[AuctionBram.scala 59:26]
  wire  priceStore_io_rPorts_5_req_valid; // @[AuctionBram.scala 59:26]
  wire [5:0] priceStore_io_rPorts_5_req_bits_addr; // @[AuctionBram.scala 59:26]
  wire  priceStore_io_rPorts_5_rsp_ready; // @[AuctionBram.scala 59:26]
  wire [7:0] priceStore_io_rPorts_5_rsp_bits_rdata; // @[AuctionBram.scala 59:26]
  wire  priceStore_io_rPorts_6_req_ready; // @[AuctionBram.scala 59:26]
  wire  priceStore_io_rPorts_6_req_valid; // @[AuctionBram.scala 59:26]
  wire [5:0] priceStore_io_rPorts_6_req_bits_addr; // @[AuctionBram.scala 59:26]
  wire  priceStore_io_rPorts_6_rsp_ready; // @[AuctionBram.scala 59:26]
  wire [7:0] priceStore_io_rPorts_6_rsp_bits_rdata; // @[AuctionBram.scala 59:26]
  wire  priceStore_io_rPorts_7_req_ready; // @[AuctionBram.scala 59:26]
  wire  priceStore_io_rPorts_7_req_valid; // @[AuctionBram.scala 59:26]
  wire [5:0] priceStore_io_rPorts_7_req_bits_addr; // @[AuctionBram.scala 59:26]
  wire  priceStore_io_rPorts_7_rsp_ready; // @[AuctionBram.scala 59:26]
  wire [7:0] priceStore_io_rPorts_7_rsp_bits_rdata; // @[AuctionBram.scala 59:26]
  wire  priceStore_io_rwPorts_0_req_ready; // @[AuctionBram.scala 59:26]
  wire  priceStore_io_rwPorts_0_req_valid; // @[AuctionBram.scala 59:26]
  wire  priceStore_io_rwPorts_0_req_bits_wen; // @[AuctionBram.scala 59:26]
  wire [5:0] priceStore_io_rwPorts_0_req_bits_addr; // @[AuctionBram.scala 59:26]
  wire [7:0] priceStore_io_rwPorts_0_req_bits_wdata; // @[AuctionBram.scala 59:26]
  wire  priceStore_io_rwPorts_0_rsp_valid; // @[AuctionBram.scala 59:26]
  wire [7:0] priceStore_io_rwPorts_0_rsp_bits_rdata; // @[AuctionBram.scala 59:26]
  wire  agentRowStore_clock; // @[AuctionBram.scala 60:29]
  wire  agentRowStore_reset; // @[AuctionBram.scala 60:29]
  wire  agentRowStore_io_wPorts_0_req_ready; // @[AuctionBram.scala 60:29]
  wire  agentRowStore_io_wPorts_0_req_valid; // @[AuctionBram.scala 60:29]
  wire [5:0] agentRowStore_io_wPorts_0_req_bits_addr; // @[AuctionBram.scala 60:29]
  wire [6:0] agentRowStore_io_wPorts_0_req_bits_wdata_rowAddr; // @[AuctionBram.scala 60:29]
  wire [5:0] agentRowStore_io_wPorts_0_req_bits_wdata_length; // @[AuctionBram.scala 60:29]
  wire  agentRowStore_io_rPorts_0_req_ready; // @[AuctionBram.scala 60:29]
  wire  agentRowStore_io_rPorts_0_req_valid; // @[AuctionBram.scala 60:29]
  wire [5:0] agentRowStore_io_rPorts_0_req_bits_addr; // @[AuctionBram.scala 60:29]
  wire  agentRowStore_io_rPorts_0_rsp_ready; // @[AuctionBram.scala 60:29]
  wire [6:0] agentRowStore_io_rPorts_0_rsp_bits_rdata_rowAddr; // @[AuctionBram.scala 60:29]
  wire [5:0] agentRowStore_io_rPorts_0_rsp_bits_rdata_length; // @[AuctionBram.scala 60:29]
  wire  dram2bram_clock; // @[AuctionBram.scala 68:25]
  wire  dram2bram_reset; // @[AuctionBram.scala 68:25]
  wire  dram2bram_io_dramReq_ready; // @[AuctionBram.scala 68:25]
  wire  dram2bram_io_dramReq_valid; // @[AuctionBram.scala 68:25]
  wire [31:0] dram2bram_io_dramReq_bits_addr; // @[AuctionBram.scala 68:25]
  wire [7:0] dram2bram_io_dramReq_bits_numBytes; // @[AuctionBram.scala 68:25]
  wire  dram2bram_io_dramRsp_ready; // @[AuctionBram.scala 68:25]
  wire  dram2bram_io_dramRsp_valid; // @[AuctionBram.scala 68:25]
  wire [63:0] dram2bram_io_dramRsp_bits_readData; // @[AuctionBram.scala 68:25]
  wire [8:0] dram2bram_io_bramCmd_req_addr; // @[AuctionBram.scala 68:25]
  wire [119:0] dram2bram_io_bramCmd_req_writeData; // @[AuctionBram.scala 68:25]
  wire  dram2bram_io_bramCmd_req_writeEn; // @[AuctionBram.scala 68:25]
  wire  dram2bram_io_start; // @[AuctionBram.scala 68:25]
  wire  dram2bram_io_finished; // @[AuctionBram.scala 68:25]
  wire [63:0] dram2bram_io_baseAddr; // @[AuctionBram.scala 68:25]
  wire [5:0] dram2bram_io_nRows; // @[AuctionBram.scala 68:25]
  wire [5:0] dram2bram_io_nCols; // @[AuctionBram.scala 68:25]
  wire  dram2bram_io_agentRowAddress_req_valid; // @[AuctionBram.scala 68:25]
  wire [5:0] dram2bram_io_agentRowAddress_req_bits_addr; // @[AuctionBram.scala 68:25]
  wire [6:0] dram2bram_io_agentRowAddress_req_bits_wdata_rowAddr; // @[AuctionBram.scala 68:25]
  wire [5:0] dram2bram_io_agentRowAddress_req_bits_wdata_length; // @[AuctionBram.scala 68:25]
  wire  memWriter_clock; // @[AuctionBram.scala 89:25]
  wire  memWriter_reset; // @[AuctionBram.scala 89:25]
  wire  memWriter_io_start; // @[AuctionBram.scala 89:25]
  wire  memWriter_io_finished; // @[AuctionBram.scala 89:25]
  wire [31:0] memWriter_io_baseAddr; // @[AuctionBram.scala 89:25]
  wire [31:0] memWriter_io_byteCount; // @[AuctionBram.scala 89:25]
  wire  memWriter_io_in_ready; // @[AuctionBram.scala 89:25]
  wire  memWriter_io_in_valid; // @[AuctionBram.scala 89:25]
  wire [63:0] memWriter_io_in_bits; // @[AuctionBram.scala 89:25]
  wire  memWriter_io_req_ready; // @[AuctionBram.scala 89:25]
  wire  memWriter_io_req_valid; // @[AuctionBram.scala 89:25]
  wire [31:0] memWriter_io_req_bits_addr; // @[AuctionBram.scala 89:25]
  wire [7:0] memWriter_io_req_bits_numBytes; // @[AuctionBram.scala 89:25]
  wire  memWriter_io_wdat_ready; // @[AuctionBram.scala 89:25]
  wire  memWriter_io_wdat_valid; // @[AuctionBram.scala 89:25]
  wire [63:0] memWriter_io_wdat_bits; // @[AuctionBram.scala 89:25]
  wire  memWriter_io_rsp_ready; // @[AuctionBram.scala 89:25]
  wire  memWriter_io_rsp_valid; // @[AuctionBram.scala 89:25]
  wire  pes_0_clock; // @[AuctionBram.scala 105:11]
  wire  pes_0_reset; // @[AuctionBram.scala 105:11]
  wire  pes_0_io_priceStore_req_valid; // @[AuctionBram.scala 105:11]
  wire [5:0] pes_0_io_priceStore_req_bits_addr; // @[AuctionBram.scala 105:11]
  wire  pes_0_io_priceStore_rsp_ready; // @[AuctionBram.scala 105:11]
  wire [7:0] pes_0_io_priceStore_rsp_bits_rdata; // @[AuctionBram.scala 105:11]
  wire  pes_0_io_rewardIn_ready; // @[AuctionBram.scala 105:11]
  wire  pes_0_io_rewardIn_valid; // @[AuctionBram.scala 105:11]
  wire [7:0] pes_0_io_rewardIn_bits_reward; // @[AuctionBram.scala 105:11]
  wire [5:0] pes_0_io_rewardIn_bits_idx; // @[AuctionBram.scala 105:11]
  wire  pes_0_io_rewardIn_bits_last; // @[AuctionBram.scala 105:11]
  wire  pes_0_io_PEResultOut_ready; // @[AuctionBram.scala 105:11]
  wire  pes_0_io_PEResultOut_valid; // @[AuctionBram.scala 105:11]
  wire [7:0] pes_0_io_PEResultOut_bits_benefit; // @[AuctionBram.scala 105:11]
  wire [5:0] pes_0_io_PEResultOut_bits_id; // @[AuctionBram.scala 105:11]
  wire  pes_0_io_PEResultOut_bits_last; // @[AuctionBram.scala 105:11]
  wire  pes_0_io_accountantNotifyContinue; // @[AuctionBram.scala 105:11]
  wire  pes_1_clock; // @[AuctionBram.scala 105:11]
  wire  pes_1_reset; // @[AuctionBram.scala 105:11]
  wire  pes_1_io_priceStore_req_valid; // @[AuctionBram.scala 105:11]
  wire [5:0] pes_1_io_priceStore_req_bits_addr; // @[AuctionBram.scala 105:11]
  wire  pes_1_io_priceStore_rsp_ready; // @[AuctionBram.scala 105:11]
  wire [7:0] pes_1_io_priceStore_rsp_bits_rdata; // @[AuctionBram.scala 105:11]
  wire  pes_1_io_rewardIn_ready; // @[AuctionBram.scala 105:11]
  wire  pes_1_io_rewardIn_valid; // @[AuctionBram.scala 105:11]
  wire [7:0] pes_1_io_rewardIn_bits_reward; // @[AuctionBram.scala 105:11]
  wire [5:0] pes_1_io_rewardIn_bits_idx; // @[AuctionBram.scala 105:11]
  wire  pes_1_io_rewardIn_bits_last; // @[AuctionBram.scala 105:11]
  wire  pes_1_io_PEResultOut_ready; // @[AuctionBram.scala 105:11]
  wire  pes_1_io_PEResultOut_valid; // @[AuctionBram.scala 105:11]
  wire [7:0] pes_1_io_PEResultOut_bits_benefit; // @[AuctionBram.scala 105:11]
  wire [5:0] pes_1_io_PEResultOut_bits_id; // @[AuctionBram.scala 105:11]
  wire  pes_1_io_PEResultOut_bits_last; // @[AuctionBram.scala 105:11]
  wire  pes_1_io_accountantNotifyContinue; // @[AuctionBram.scala 105:11]
  wire  pes_2_clock; // @[AuctionBram.scala 105:11]
  wire  pes_2_reset; // @[AuctionBram.scala 105:11]
  wire  pes_2_io_priceStore_req_valid; // @[AuctionBram.scala 105:11]
  wire [5:0] pes_2_io_priceStore_req_bits_addr; // @[AuctionBram.scala 105:11]
  wire  pes_2_io_priceStore_rsp_ready; // @[AuctionBram.scala 105:11]
  wire [7:0] pes_2_io_priceStore_rsp_bits_rdata; // @[AuctionBram.scala 105:11]
  wire  pes_2_io_rewardIn_ready; // @[AuctionBram.scala 105:11]
  wire  pes_2_io_rewardIn_valid; // @[AuctionBram.scala 105:11]
  wire [7:0] pes_2_io_rewardIn_bits_reward; // @[AuctionBram.scala 105:11]
  wire [5:0] pes_2_io_rewardIn_bits_idx; // @[AuctionBram.scala 105:11]
  wire  pes_2_io_rewardIn_bits_last; // @[AuctionBram.scala 105:11]
  wire  pes_2_io_PEResultOut_ready; // @[AuctionBram.scala 105:11]
  wire  pes_2_io_PEResultOut_valid; // @[AuctionBram.scala 105:11]
  wire [7:0] pes_2_io_PEResultOut_bits_benefit; // @[AuctionBram.scala 105:11]
  wire [5:0] pes_2_io_PEResultOut_bits_id; // @[AuctionBram.scala 105:11]
  wire  pes_2_io_PEResultOut_bits_last; // @[AuctionBram.scala 105:11]
  wire  pes_2_io_accountantNotifyContinue; // @[AuctionBram.scala 105:11]
  wire  pes_3_clock; // @[AuctionBram.scala 105:11]
  wire  pes_3_reset; // @[AuctionBram.scala 105:11]
  wire  pes_3_io_priceStore_req_valid; // @[AuctionBram.scala 105:11]
  wire [5:0] pes_3_io_priceStore_req_bits_addr; // @[AuctionBram.scala 105:11]
  wire  pes_3_io_priceStore_rsp_ready; // @[AuctionBram.scala 105:11]
  wire [7:0] pes_3_io_priceStore_rsp_bits_rdata; // @[AuctionBram.scala 105:11]
  wire  pes_3_io_rewardIn_ready; // @[AuctionBram.scala 105:11]
  wire  pes_3_io_rewardIn_valid; // @[AuctionBram.scala 105:11]
  wire [7:0] pes_3_io_rewardIn_bits_reward; // @[AuctionBram.scala 105:11]
  wire [5:0] pes_3_io_rewardIn_bits_idx; // @[AuctionBram.scala 105:11]
  wire  pes_3_io_rewardIn_bits_last; // @[AuctionBram.scala 105:11]
  wire  pes_3_io_PEResultOut_ready; // @[AuctionBram.scala 105:11]
  wire  pes_3_io_PEResultOut_valid; // @[AuctionBram.scala 105:11]
  wire [7:0] pes_3_io_PEResultOut_bits_benefit; // @[AuctionBram.scala 105:11]
  wire [5:0] pes_3_io_PEResultOut_bits_id; // @[AuctionBram.scala 105:11]
  wire  pes_3_io_PEResultOut_bits_last; // @[AuctionBram.scala 105:11]
  wire  pes_3_io_accountantNotifyContinue; // @[AuctionBram.scala 105:11]
  wire  pes_4_clock; // @[AuctionBram.scala 105:11]
  wire  pes_4_reset; // @[AuctionBram.scala 105:11]
  wire  pes_4_io_priceStore_req_valid; // @[AuctionBram.scala 105:11]
  wire [5:0] pes_4_io_priceStore_req_bits_addr; // @[AuctionBram.scala 105:11]
  wire  pes_4_io_priceStore_rsp_ready; // @[AuctionBram.scala 105:11]
  wire [7:0] pes_4_io_priceStore_rsp_bits_rdata; // @[AuctionBram.scala 105:11]
  wire  pes_4_io_rewardIn_ready; // @[AuctionBram.scala 105:11]
  wire  pes_4_io_rewardIn_valid; // @[AuctionBram.scala 105:11]
  wire [7:0] pes_4_io_rewardIn_bits_reward; // @[AuctionBram.scala 105:11]
  wire [5:0] pes_4_io_rewardIn_bits_idx; // @[AuctionBram.scala 105:11]
  wire  pes_4_io_rewardIn_bits_last; // @[AuctionBram.scala 105:11]
  wire  pes_4_io_PEResultOut_ready; // @[AuctionBram.scala 105:11]
  wire  pes_4_io_PEResultOut_valid; // @[AuctionBram.scala 105:11]
  wire [7:0] pes_4_io_PEResultOut_bits_benefit; // @[AuctionBram.scala 105:11]
  wire [5:0] pes_4_io_PEResultOut_bits_id; // @[AuctionBram.scala 105:11]
  wire  pes_4_io_PEResultOut_bits_last; // @[AuctionBram.scala 105:11]
  wire  pes_4_io_accountantNotifyContinue; // @[AuctionBram.scala 105:11]
  wire  pes_5_clock; // @[AuctionBram.scala 105:11]
  wire  pes_5_reset; // @[AuctionBram.scala 105:11]
  wire  pes_5_io_priceStore_req_valid; // @[AuctionBram.scala 105:11]
  wire [5:0] pes_5_io_priceStore_req_bits_addr; // @[AuctionBram.scala 105:11]
  wire  pes_5_io_priceStore_rsp_ready; // @[AuctionBram.scala 105:11]
  wire [7:0] pes_5_io_priceStore_rsp_bits_rdata; // @[AuctionBram.scala 105:11]
  wire  pes_5_io_rewardIn_ready; // @[AuctionBram.scala 105:11]
  wire  pes_5_io_rewardIn_valid; // @[AuctionBram.scala 105:11]
  wire [7:0] pes_5_io_rewardIn_bits_reward; // @[AuctionBram.scala 105:11]
  wire [5:0] pes_5_io_rewardIn_bits_idx; // @[AuctionBram.scala 105:11]
  wire  pes_5_io_rewardIn_bits_last; // @[AuctionBram.scala 105:11]
  wire  pes_5_io_PEResultOut_ready; // @[AuctionBram.scala 105:11]
  wire  pes_5_io_PEResultOut_valid; // @[AuctionBram.scala 105:11]
  wire [7:0] pes_5_io_PEResultOut_bits_benefit; // @[AuctionBram.scala 105:11]
  wire [5:0] pes_5_io_PEResultOut_bits_id; // @[AuctionBram.scala 105:11]
  wire  pes_5_io_PEResultOut_bits_last; // @[AuctionBram.scala 105:11]
  wire  pes_5_io_accountantNotifyContinue; // @[AuctionBram.scala 105:11]
  wire  pes_6_clock; // @[AuctionBram.scala 105:11]
  wire  pes_6_reset; // @[AuctionBram.scala 105:11]
  wire  pes_6_io_priceStore_req_valid; // @[AuctionBram.scala 105:11]
  wire [5:0] pes_6_io_priceStore_req_bits_addr; // @[AuctionBram.scala 105:11]
  wire  pes_6_io_priceStore_rsp_ready; // @[AuctionBram.scala 105:11]
  wire [7:0] pes_6_io_priceStore_rsp_bits_rdata; // @[AuctionBram.scala 105:11]
  wire  pes_6_io_rewardIn_ready; // @[AuctionBram.scala 105:11]
  wire  pes_6_io_rewardIn_valid; // @[AuctionBram.scala 105:11]
  wire [7:0] pes_6_io_rewardIn_bits_reward; // @[AuctionBram.scala 105:11]
  wire [5:0] pes_6_io_rewardIn_bits_idx; // @[AuctionBram.scala 105:11]
  wire  pes_6_io_rewardIn_bits_last; // @[AuctionBram.scala 105:11]
  wire  pes_6_io_PEResultOut_ready; // @[AuctionBram.scala 105:11]
  wire  pes_6_io_PEResultOut_valid; // @[AuctionBram.scala 105:11]
  wire [7:0] pes_6_io_PEResultOut_bits_benefit; // @[AuctionBram.scala 105:11]
  wire [5:0] pes_6_io_PEResultOut_bits_id; // @[AuctionBram.scala 105:11]
  wire  pes_6_io_PEResultOut_bits_last; // @[AuctionBram.scala 105:11]
  wire  pes_6_io_accountantNotifyContinue; // @[AuctionBram.scala 105:11]
  wire  pes_7_clock; // @[AuctionBram.scala 105:11]
  wire  pes_7_reset; // @[AuctionBram.scala 105:11]
  wire  pes_7_io_priceStore_req_valid; // @[AuctionBram.scala 105:11]
  wire [5:0] pes_7_io_priceStore_req_bits_addr; // @[AuctionBram.scala 105:11]
  wire  pes_7_io_priceStore_rsp_ready; // @[AuctionBram.scala 105:11]
  wire [7:0] pes_7_io_priceStore_rsp_bits_rdata; // @[AuctionBram.scala 105:11]
  wire  pes_7_io_rewardIn_ready; // @[AuctionBram.scala 105:11]
  wire  pes_7_io_rewardIn_valid; // @[AuctionBram.scala 105:11]
  wire [7:0] pes_7_io_rewardIn_bits_reward; // @[AuctionBram.scala 105:11]
  wire [5:0] pes_7_io_rewardIn_bits_idx; // @[AuctionBram.scala 105:11]
  wire  pes_7_io_rewardIn_bits_last; // @[AuctionBram.scala 105:11]
  wire  pes_7_io_PEResultOut_ready; // @[AuctionBram.scala 105:11]
  wire  pes_7_io_PEResultOut_valid; // @[AuctionBram.scala 105:11]
  wire [7:0] pes_7_io_PEResultOut_bits_benefit; // @[AuctionBram.scala 105:11]
  wire [5:0] pes_7_io_PEResultOut_bits_id; // @[AuctionBram.scala 105:11]
  wire  pes_7_io_PEResultOut_bits_last; // @[AuctionBram.scala 105:11]
  wire  pes_7_io_accountantNotifyContinue; // @[AuctionBram.scala 105:11]
  wire  search_clock; // @[AuctionBram.scala 111:22]
  wire  search_reset; // @[AuctionBram.scala 111:22]
  wire  search_io_benefitIn_0_ready; // @[AuctionBram.scala 111:22]
  wire  search_io_benefitIn_0_valid; // @[AuctionBram.scala 111:22]
  wire [7:0] search_io_benefitIn_0_bits_benefit; // @[AuctionBram.scala 111:22]
  wire [5:0] search_io_benefitIn_0_bits_id; // @[AuctionBram.scala 111:22]
  wire  search_io_benefitIn_0_bits_last; // @[AuctionBram.scala 111:22]
  wire  search_io_benefitIn_1_ready; // @[AuctionBram.scala 111:22]
  wire  search_io_benefitIn_1_valid; // @[AuctionBram.scala 111:22]
  wire [7:0] search_io_benefitIn_1_bits_benefit; // @[AuctionBram.scala 111:22]
  wire [5:0] search_io_benefitIn_1_bits_id; // @[AuctionBram.scala 111:22]
  wire  search_io_benefitIn_2_ready; // @[AuctionBram.scala 111:22]
  wire  search_io_benefitIn_2_valid; // @[AuctionBram.scala 111:22]
  wire [7:0] search_io_benefitIn_2_bits_benefit; // @[AuctionBram.scala 111:22]
  wire [5:0] search_io_benefitIn_2_bits_id; // @[AuctionBram.scala 111:22]
  wire  search_io_benefitIn_3_ready; // @[AuctionBram.scala 111:22]
  wire  search_io_benefitIn_3_valid; // @[AuctionBram.scala 111:22]
  wire [7:0] search_io_benefitIn_3_bits_benefit; // @[AuctionBram.scala 111:22]
  wire [5:0] search_io_benefitIn_3_bits_id; // @[AuctionBram.scala 111:22]
  wire  search_io_benefitIn_4_ready; // @[AuctionBram.scala 111:22]
  wire  search_io_benefitIn_4_valid; // @[AuctionBram.scala 111:22]
  wire [7:0] search_io_benefitIn_4_bits_benefit; // @[AuctionBram.scala 111:22]
  wire [5:0] search_io_benefitIn_4_bits_id; // @[AuctionBram.scala 111:22]
  wire  search_io_benefitIn_5_ready; // @[AuctionBram.scala 111:22]
  wire  search_io_benefitIn_5_valid; // @[AuctionBram.scala 111:22]
  wire [7:0] search_io_benefitIn_5_bits_benefit; // @[AuctionBram.scala 111:22]
  wire [5:0] search_io_benefitIn_5_bits_id; // @[AuctionBram.scala 111:22]
  wire  search_io_benefitIn_6_ready; // @[AuctionBram.scala 111:22]
  wire  search_io_benefitIn_6_valid; // @[AuctionBram.scala 111:22]
  wire [7:0] search_io_benefitIn_6_bits_benefit; // @[AuctionBram.scala 111:22]
  wire [5:0] search_io_benefitIn_6_bits_id; // @[AuctionBram.scala 111:22]
  wire  search_io_benefitIn_7_ready; // @[AuctionBram.scala 111:22]
  wire  search_io_benefitIn_7_valid; // @[AuctionBram.scala 111:22]
  wire [7:0] search_io_benefitIn_7_bits_benefit; // @[AuctionBram.scala 111:22]
  wire [5:0] search_io_benefitIn_7_bits_id; // @[AuctionBram.scala 111:22]
  wire  search_io_resultOut_ready; // @[AuctionBram.scala 111:22]
  wire  search_io_resultOut_valid; // @[AuctionBram.scala 111:22]
  wire [5:0] search_io_resultOut_bits_winner; // @[AuctionBram.scala 111:22]
  wire [7:0] search_io_resultOut_bits_bid; // @[AuctionBram.scala 111:22]
  wire [36:0] _T = io_rfIn_nObjects * 5'h10; // @[AuctionBram.scala 97:45]
  reg  running; // @[AuctionBram.scala 144:24]
  reg [31:0] regCycleCount; // @[AuctionBram.scala 145:30]
  wire [31:0] _T_2 = regCycleCount + 32'h1; // @[AuctionBram.scala 148:36]
  wire  _T_3 = ~running; // @[AuctionBram.scala 149:14]
  BramController memController ( // @[AuctionBram.scala 35:29]
    .clock(memController_clock),
    .reset(memController_reset),
    .io_unassignedAgents_ready(memController_io_unassignedAgents_ready),
    .io_unassignedAgents_valid(memController_io_unassignedAgents_valid),
    .io_unassignedAgents_bits_agent(memController_io_unassignedAgents_bits_agent),
    .io_requestedAgents_ready(memController_io_requestedAgents_ready),
    .io_requestedAgents_valid(memController_io_requestedAgents_valid),
    .io_requestedAgents_bits_agent(memController_io_requestedAgents_bits_agent),
    .io_agentRowAddrReq_req_valid(memController_io_agentRowAddrReq_req_valid),
    .io_agentRowAddrReq_req_bits_addr(memController_io_agentRowAddrReq_req_bits_addr),
    .io_agentRowAddrReq_rsp_ready(memController_io_agentRowAddrReq_rsp_ready),
    .io_agentRowAddrReq_rsp_bits_rdata_rowAddr(memController_io_agentRowAddrReq_rsp_bits_rdata_rowAddr),
    .io_agentRowAddrReq_rsp_bits_rdata_length(memController_io_agentRowAddrReq_rsp_bits_rdata_length),
    .io_bramReq_req_addr(memController_io_bramReq_req_addr),
    .io_bramReq_rsp_readData(memController_io_bramReq_rsp_readData),
    .io_dataDistOut_ready(memController_io_dataDistOut_ready),
    .io_dataDistOut_valid(memController_io_dataDistOut_valid),
    .io_dataDistOut_bits_els_0_reward(memController_io_dataDistOut_bits_els_0_reward),
    .io_dataDistOut_bits_els_0_idx(memController_io_dataDistOut_bits_els_0_idx),
    .io_dataDistOut_bits_els_1_reward(memController_io_dataDistOut_bits_els_1_reward),
    .io_dataDistOut_bits_els_1_idx(memController_io_dataDistOut_bits_els_1_idx),
    .io_dataDistOut_bits_els_2_reward(memController_io_dataDistOut_bits_els_2_reward),
    .io_dataDistOut_bits_els_2_idx(memController_io_dataDistOut_bits_els_2_idx),
    .io_dataDistOut_bits_els_3_reward(memController_io_dataDistOut_bits_els_3_reward),
    .io_dataDistOut_bits_els_3_idx(memController_io_dataDistOut_bits_els_3_idx),
    .io_dataDistOut_bits_els_4_reward(memController_io_dataDistOut_bits_els_4_reward),
    .io_dataDistOut_bits_els_4_idx(memController_io_dataDistOut_bits_els_4_idx),
    .io_dataDistOut_bits_els_5_reward(memController_io_dataDistOut_bits_els_5_reward),
    .io_dataDistOut_bits_els_5_idx(memController_io_dataDistOut_bits_els_5_idx),
    .io_dataDistOut_bits_els_6_reward(memController_io_dataDistOut_bits_els_6_reward),
    .io_dataDistOut_bits_els_6_idx(memController_io_dataDistOut_bits_els_6_idx),
    .io_dataDistOut_bits_els_7_reward(memController_io_dataDistOut_bits_els_7_reward),
    .io_dataDistOut_bits_els_7_idx(memController_io_dataDistOut_bits_els_7_idx),
    .io_dataDistOut_bits_last(memController_io_dataDistOut_bits_last)
  );
  ControllerBram controller ( // @[AuctionBram.scala 40:26]
    .clock(controller_clock),
    .reset(controller_reset),
    .io_rfCtrl_finished(controller_io_rfCtrl_finished),
    .io_rfInfo_start(controller_io_rfInfo_start),
    .io_rfInfo_baseAddr(controller_io_rfInfo_baseAddr),
    .io_rfInfo_nAgents(controller_io_rfInfo_nAgents),
    .io_rfInfo_nObjects(controller_io_rfInfo_nObjects),
    .io_dram2bram_start(controller_io_dram2bram_start),
    .io_dram2bram_finished(controller_io_dram2bram_finished),
    .io_dram2bram_baseAddr(controller_io_dram2bram_baseAddr),
    .io_dram2bram_nRows(controller_io_dram2bram_nRows),
    .io_dram2bram_nCols(controller_io_dram2bram_nCols),
    .io_unassignedAgentsIn_ready(controller_io_unassignedAgentsIn_ready),
    .io_unassignedAgentsIn_valid(controller_io_unassignedAgentsIn_valid),
    .io_unassignedAgentsIn_bits_agent(controller_io_unassignedAgentsIn_bits_agent),
    .io_unassignedAgentsOut_ready(controller_io_unassignedAgentsOut_ready),
    .io_unassignedAgentsOut_valid(controller_io_unassignedAgentsOut_valid),
    .io_unassignedAgentsOut_bits_agent(controller_io_unassignedAgentsOut_bits_agent),
    .io_requestedAgentsIn_ready(controller_io_requestedAgentsIn_ready),
    .io_requestedAgentsIn_valid(controller_io_requestedAgentsIn_valid),
    .io_requestedAgentsIn_bits_agent(controller_io_requestedAgentsIn_bits_agent),
    .io_requestedAgentsOut_ready(controller_io_requestedAgentsOut_ready),
    .io_requestedAgentsOut_valid(controller_io_requestedAgentsOut_valid),
    .io_requestedAgentsOut_bits_agent(controller_io_requestedAgentsOut_bits_agent),
    .io_doWriteBack(controller_io_doWriteBack),
    .io_writeBackDone(controller_io_writeBackDone),
    .io_reinit(controller_io_reinit)
  );
  AccountantExtPriceNonPipelined accountant ( // @[AuctionBram.scala 45:26]
    .clock(accountant_clock),
    .reset(accountant_reset),
    .io_searchResultIn_ready(accountant_io_searchResultIn_ready),
    .io_searchResultIn_valid(accountant_io_searchResultIn_valid),
    .io_searchResultIn_bits_winner(accountant_io_searchResultIn_bits_winner),
    .io_searchResultIn_bits_bid(accountant_io_searchResultIn_bits_bid),
    .io_unassignedAgents_ready(accountant_io_unassignedAgents_ready),
    .io_unassignedAgents_valid(accountant_io_unassignedAgents_valid),
    .io_unassignedAgents_bits_agent(accountant_io_unassignedAgents_bits_agent),
    .io_requestedAgents_ready(accountant_io_requestedAgents_ready),
    .io_requestedAgents_valid(accountant_io_requestedAgents_valid),
    .io_requestedAgents_bits_agent(accountant_io_requestedAgents_bits_agent),
    .io_rfInfo_nObjects(accountant_io_rfInfo_nObjects),
    .io_doWriteBack(accountant_io_doWriteBack),
    .io_writeBackDone(accountant_io_writeBackDone),
    .io_writeBackStream_start(accountant_io_writeBackStream_start),
    .io_writeBackStream_wrData_ready(accountant_io_writeBackStream_wrData_ready),
    .io_writeBackStream_wrData_valid(accountant_io_writeBackStream_wrData_valid),
    .io_writeBackStream_wrData_bits(accountant_io_writeBackStream_wrData_bits),
    .io_writeBackStream_finished(accountant_io_writeBackStream_finished),
    .io_priceStore_req_valid(accountant_io_priceStore_req_valid),
    .io_priceStore_req_bits_wen(accountant_io_priceStore_req_bits_wen),
    .io_priceStore_req_bits_addr(accountant_io_priceStore_req_bits_addr),
    .io_priceStore_req_bits_wdata(accountant_io_priceStore_req_bits_wdata),
    .io_priceStore_rsp_valid(accountant_io_priceStore_rsp_valid),
    .io_priceStore_rsp_bits_rdata(accountant_io_priceStore_rsp_bits_rdata),
    .io_notifyPEsContinue(accountant_io_notifyPEsContinue)
  );
  DataDistributorSparse dataMux ( // @[AuctionBram.scala 50:23]
    .clock(dataMux_clock),
    .reset(dataMux_reset),
    .io_bramWordIn_ready(dataMux_io_bramWordIn_ready),
    .io_bramWordIn_valid(dataMux_io_bramWordIn_valid),
    .io_bramWordIn_bits_els_0_reward(dataMux_io_bramWordIn_bits_els_0_reward),
    .io_bramWordIn_bits_els_0_idx(dataMux_io_bramWordIn_bits_els_0_idx),
    .io_bramWordIn_bits_els_1_reward(dataMux_io_bramWordIn_bits_els_1_reward),
    .io_bramWordIn_bits_els_1_idx(dataMux_io_bramWordIn_bits_els_1_idx),
    .io_bramWordIn_bits_els_2_reward(dataMux_io_bramWordIn_bits_els_2_reward),
    .io_bramWordIn_bits_els_2_idx(dataMux_io_bramWordIn_bits_els_2_idx),
    .io_bramWordIn_bits_els_3_reward(dataMux_io_bramWordIn_bits_els_3_reward),
    .io_bramWordIn_bits_els_3_idx(dataMux_io_bramWordIn_bits_els_3_idx),
    .io_bramWordIn_bits_els_4_reward(dataMux_io_bramWordIn_bits_els_4_reward),
    .io_bramWordIn_bits_els_4_idx(dataMux_io_bramWordIn_bits_els_4_idx),
    .io_bramWordIn_bits_els_5_reward(dataMux_io_bramWordIn_bits_els_5_reward),
    .io_bramWordIn_bits_els_5_idx(dataMux_io_bramWordIn_bits_els_5_idx),
    .io_bramWordIn_bits_els_6_reward(dataMux_io_bramWordIn_bits_els_6_reward),
    .io_bramWordIn_bits_els_6_idx(dataMux_io_bramWordIn_bits_els_6_idx),
    .io_bramWordIn_bits_els_7_reward(dataMux_io_bramWordIn_bits_els_7_reward),
    .io_bramWordIn_bits_els_7_idx(dataMux_io_bramWordIn_bits_els_7_idx),
    .io_bramWordIn_bits_last(dataMux_io_bramWordIn_bits_last),
    .io_peOut_0_ready(dataMux_io_peOut_0_ready),
    .io_peOut_0_valid(dataMux_io_peOut_0_valid),
    .io_peOut_0_bits_reward(dataMux_io_peOut_0_bits_reward),
    .io_peOut_0_bits_idx(dataMux_io_peOut_0_bits_idx),
    .io_peOut_0_bits_last(dataMux_io_peOut_0_bits_last),
    .io_peOut_1_valid(dataMux_io_peOut_1_valid),
    .io_peOut_1_bits_reward(dataMux_io_peOut_1_bits_reward),
    .io_peOut_1_bits_idx(dataMux_io_peOut_1_bits_idx),
    .io_peOut_1_bits_last(dataMux_io_peOut_1_bits_last),
    .io_peOut_2_valid(dataMux_io_peOut_2_valid),
    .io_peOut_2_bits_reward(dataMux_io_peOut_2_bits_reward),
    .io_peOut_2_bits_idx(dataMux_io_peOut_2_bits_idx),
    .io_peOut_2_bits_last(dataMux_io_peOut_2_bits_last),
    .io_peOut_3_valid(dataMux_io_peOut_3_valid),
    .io_peOut_3_bits_reward(dataMux_io_peOut_3_bits_reward),
    .io_peOut_3_bits_idx(dataMux_io_peOut_3_bits_idx),
    .io_peOut_3_bits_last(dataMux_io_peOut_3_bits_last),
    .io_peOut_4_valid(dataMux_io_peOut_4_valid),
    .io_peOut_4_bits_reward(dataMux_io_peOut_4_bits_reward),
    .io_peOut_4_bits_idx(dataMux_io_peOut_4_bits_idx),
    .io_peOut_4_bits_last(dataMux_io_peOut_4_bits_last),
    .io_peOut_5_valid(dataMux_io_peOut_5_valid),
    .io_peOut_5_bits_reward(dataMux_io_peOut_5_bits_reward),
    .io_peOut_5_bits_idx(dataMux_io_peOut_5_bits_idx),
    .io_peOut_5_bits_last(dataMux_io_peOut_5_bits_last),
    .io_peOut_6_valid(dataMux_io_peOut_6_valid),
    .io_peOut_6_bits_reward(dataMux_io_peOut_6_bits_reward),
    .io_peOut_6_bits_idx(dataMux_io_peOut_6_bits_idx),
    .io_peOut_6_bits_last(dataMux_io_peOut_6_bits_last),
    .io_peOut_7_valid(dataMux_io_peOut_7_valid),
    .io_peOut_7_bits_reward(dataMux_io_peOut_7_bits_reward),
    .io_peOut_7_bits_idx(dataMux_io_peOut_7_bits_idx),
    .io_peOut_7_bits_last(dataMux_io_peOut_7_bits_last)
  );
  Queue_2 qUnassignedAgents ( // @[AuctionBram.scala 53:33]
    .clock(qUnassignedAgents_clock),
    .reset(qUnassignedAgents_reset),
    .io_enq_ready(qUnassignedAgents_io_enq_ready),
    .io_enq_valid(qUnassignedAgents_io_enq_valid),
    .io_enq_bits_agent(qUnassignedAgents_io_enq_bits_agent),
    .io_deq_ready(qUnassignedAgents_io_deq_ready),
    .io_deq_valid(qUnassignedAgents_io_deq_valid),
    .io_deq_bits_agent(qUnassignedAgents_io_deq_bits_agent)
  );
  Queue_2 qRequestedAgents ( // @[AuctionBram.scala 54:32]
    .clock(qRequestedAgents_clock),
    .reset(qRequestedAgents_reset),
    .io_enq_ready(qRequestedAgents_io_enq_ready),
    .io_enq_valid(qRequestedAgents_io_enq_valid),
    .io_enq_bits_agent(qRequestedAgents_io_enq_bits_agent),
    .io_deq_ready(qRequestedAgents_io_deq_ready),
    .io_deq_valid(qRequestedAgents_io_deq_valid),
    .io_deq_bits_agent(qRequestedAgents_io_deq_bits_agent)
  );
  SimpleDualPortBRAM bram ( // @[AuctionBram.scala 58:20]
    .clock(bram_clock),
    .io_read_req_addr(bram_io_read_req_addr),
    .io_read_rsp_readData(bram_io_read_rsp_readData),
    .io_write_req_addr(bram_io_write_req_addr),
    .io_write_req_writeData(bram_io_write_req_writeData),
    .io_write_req_writeEn(bram_io_write_req_writeEn)
  );
  RegStore priceStore ( // @[AuctionBram.scala 59:26]
    .clock(priceStore_clock),
    .reset(priceStore_reset),
    .io_rPorts_0_req_ready(priceStore_io_rPorts_0_req_ready),
    .io_rPorts_0_req_valid(priceStore_io_rPorts_0_req_valid),
    .io_rPorts_0_req_bits_addr(priceStore_io_rPorts_0_req_bits_addr),
    .io_rPorts_0_rsp_ready(priceStore_io_rPorts_0_rsp_ready),
    .io_rPorts_0_rsp_bits_rdata(priceStore_io_rPorts_0_rsp_bits_rdata),
    .io_rPorts_1_req_ready(priceStore_io_rPorts_1_req_ready),
    .io_rPorts_1_req_valid(priceStore_io_rPorts_1_req_valid),
    .io_rPorts_1_req_bits_addr(priceStore_io_rPorts_1_req_bits_addr),
    .io_rPorts_1_rsp_ready(priceStore_io_rPorts_1_rsp_ready),
    .io_rPorts_1_rsp_bits_rdata(priceStore_io_rPorts_1_rsp_bits_rdata),
    .io_rPorts_2_req_ready(priceStore_io_rPorts_2_req_ready),
    .io_rPorts_2_req_valid(priceStore_io_rPorts_2_req_valid),
    .io_rPorts_2_req_bits_addr(priceStore_io_rPorts_2_req_bits_addr),
    .io_rPorts_2_rsp_ready(priceStore_io_rPorts_2_rsp_ready),
    .io_rPorts_2_rsp_bits_rdata(priceStore_io_rPorts_2_rsp_bits_rdata),
    .io_rPorts_3_req_ready(priceStore_io_rPorts_3_req_ready),
    .io_rPorts_3_req_valid(priceStore_io_rPorts_3_req_valid),
    .io_rPorts_3_req_bits_addr(priceStore_io_rPorts_3_req_bits_addr),
    .io_rPorts_3_rsp_ready(priceStore_io_rPorts_3_rsp_ready),
    .io_rPorts_3_rsp_bits_rdata(priceStore_io_rPorts_3_rsp_bits_rdata),
    .io_rPorts_4_req_ready(priceStore_io_rPorts_4_req_ready),
    .io_rPorts_4_req_valid(priceStore_io_rPorts_4_req_valid),
    .io_rPorts_4_req_bits_addr(priceStore_io_rPorts_4_req_bits_addr),
    .io_rPorts_4_rsp_ready(priceStore_io_rPorts_4_rsp_ready),
    .io_rPorts_4_rsp_bits_rdata(priceStore_io_rPorts_4_rsp_bits_rdata),
    .io_rPorts_5_req_ready(priceStore_io_rPorts_5_req_ready),
    .io_rPorts_5_req_valid(priceStore_io_rPorts_5_req_valid),
    .io_rPorts_5_req_bits_addr(priceStore_io_rPorts_5_req_bits_addr),
    .io_rPorts_5_rsp_ready(priceStore_io_rPorts_5_rsp_ready),
    .io_rPorts_5_rsp_bits_rdata(priceStore_io_rPorts_5_rsp_bits_rdata),
    .io_rPorts_6_req_ready(priceStore_io_rPorts_6_req_ready),
    .io_rPorts_6_req_valid(priceStore_io_rPorts_6_req_valid),
    .io_rPorts_6_req_bits_addr(priceStore_io_rPorts_6_req_bits_addr),
    .io_rPorts_6_rsp_ready(priceStore_io_rPorts_6_rsp_ready),
    .io_rPorts_6_rsp_bits_rdata(priceStore_io_rPorts_6_rsp_bits_rdata),
    .io_rPorts_7_req_ready(priceStore_io_rPorts_7_req_ready),
    .io_rPorts_7_req_valid(priceStore_io_rPorts_7_req_valid),
    .io_rPorts_7_req_bits_addr(priceStore_io_rPorts_7_req_bits_addr),
    .io_rPorts_7_rsp_ready(priceStore_io_rPorts_7_rsp_ready),
    .io_rPorts_7_rsp_bits_rdata(priceStore_io_rPorts_7_rsp_bits_rdata),
    .io_rwPorts_0_req_ready(priceStore_io_rwPorts_0_req_ready),
    .io_rwPorts_0_req_valid(priceStore_io_rwPorts_0_req_valid),
    .io_rwPorts_0_req_bits_wen(priceStore_io_rwPorts_0_req_bits_wen),
    .io_rwPorts_0_req_bits_addr(priceStore_io_rwPorts_0_req_bits_addr),
    .io_rwPorts_0_req_bits_wdata(priceStore_io_rwPorts_0_req_bits_wdata),
    .io_rwPorts_0_rsp_valid(priceStore_io_rwPorts_0_rsp_valid),
    .io_rwPorts_0_rsp_bits_rdata(priceStore_io_rwPorts_0_rsp_bits_rdata)
  );
  RegStore_1 agentRowStore ( // @[AuctionBram.scala 60:29]
    .clock(agentRowStore_clock),
    .reset(agentRowStore_reset),
    .io_wPorts_0_req_ready(agentRowStore_io_wPorts_0_req_ready),
    .io_wPorts_0_req_valid(agentRowStore_io_wPorts_0_req_valid),
    .io_wPorts_0_req_bits_addr(agentRowStore_io_wPorts_0_req_bits_addr),
    .io_wPorts_0_req_bits_wdata_rowAddr(agentRowStore_io_wPorts_0_req_bits_wdata_rowAddr),
    .io_wPorts_0_req_bits_wdata_length(agentRowStore_io_wPorts_0_req_bits_wdata_length),
    .io_rPorts_0_req_ready(agentRowStore_io_rPorts_0_req_ready),
    .io_rPorts_0_req_valid(agentRowStore_io_rPorts_0_req_valid),
    .io_rPorts_0_req_bits_addr(agentRowStore_io_rPorts_0_req_bits_addr),
    .io_rPorts_0_rsp_ready(agentRowStore_io_rPorts_0_rsp_ready),
    .io_rPorts_0_rsp_bits_rdata_rowAddr(agentRowStore_io_rPorts_0_rsp_bits_rdata_rowAddr),
    .io_rPorts_0_rsp_bits_rdata_length(agentRowStore_io_rPorts_0_rsp_bits_rdata_length)
  );
  DRAM2BRAM dram2bram ( // @[AuctionBram.scala 68:25]
    .clock(dram2bram_clock),
    .reset(dram2bram_reset),
    .io_dramReq_ready(dram2bram_io_dramReq_ready),
    .io_dramReq_valid(dram2bram_io_dramReq_valid),
    .io_dramReq_bits_addr(dram2bram_io_dramReq_bits_addr),
    .io_dramReq_bits_numBytes(dram2bram_io_dramReq_bits_numBytes),
    .io_dramRsp_ready(dram2bram_io_dramRsp_ready),
    .io_dramRsp_valid(dram2bram_io_dramRsp_valid),
    .io_dramRsp_bits_readData(dram2bram_io_dramRsp_bits_readData),
    .io_bramCmd_req_addr(dram2bram_io_bramCmd_req_addr),
    .io_bramCmd_req_writeData(dram2bram_io_bramCmd_req_writeData),
    .io_bramCmd_req_writeEn(dram2bram_io_bramCmd_req_writeEn),
    .io_start(dram2bram_io_start),
    .io_finished(dram2bram_io_finished),
    .io_baseAddr(dram2bram_io_baseAddr),
    .io_nRows(dram2bram_io_nRows),
    .io_nCols(dram2bram_io_nCols),
    .io_agentRowAddress_req_valid(dram2bram_io_agentRowAddress_req_valid),
    .io_agentRowAddress_req_bits_addr(dram2bram_io_agentRowAddress_req_bits_addr),
    .io_agentRowAddress_req_bits_wdata_rowAddr(dram2bram_io_agentRowAddress_req_bits_wdata_rowAddr),
    .io_agentRowAddress_req_bits_wdata_length(dram2bram_io_agentRowAddress_req_bits_wdata_length)
  );
  StreamWriter memWriter ( // @[AuctionBram.scala 89:25]
    .clock(memWriter_clock),
    .reset(memWriter_reset),
    .io_start(memWriter_io_start),
    .io_finished(memWriter_io_finished),
    .io_baseAddr(memWriter_io_baseAddr),
    .io_byteCount(memWriter_io_byteCount),
    .io_in_ready(memWriter_io_in_ready),
    .io_in_valid(memWriter_io_in_valid),
    .io_in_bits(memWriter_io_in_bits),
    .io_req_ready(memWriter_io_req_ready),
    .io_req_valid(memWriter_io_req_valid),
    .io_req_bits_addr(memWriter_io_req_bits_addr),
    .io_req_bits_numBytes(memWriter_io_req_bits_numBytes),
    .io_wdat_ready(memWriter_io_wdat_ready),
    .io_wdat_valid(memWriter_io_wdat_valid),
    .io_wdat_bits(memWriter_io_wdat_bits),
    .io_rsp_ready(memWriter_io_rsp_ready),
    .io_rsp_valid(memWriter_io_rsp_valid)
  );
  ProcessingElementExtPrice pes_0 ( // @[AuctionBram.scala 105:11]
    .clock(pes_0_clock),
    .reset(pes_0_reset),
    .io_priceStore_req_valid(pes_0_io_priceStore_req_valid),
    .io_priceStore_req_bits_addr(pes_0_io_priceStore_req_bits_addr),
    .io_priceStore_rsp_ready(pes_0_io_priceStore_rsp_ready),
    .io_priceStore_rsp_bits_rdata(pes_0_io_priceStore_rsp_bits_rdata),
    .io_rewardIn_ready(pes_0_io_rewardIn_ready),
    .io_rewardIn_valid(pes_0_io_rewardIn_valid),
    .io_rewardIn_bits_reward(pes_0_io_rewardIn_bits_reward),
    .io_rewardIn_bits_idx(pes_0_io_rewardIn_bits_idx),
    .io_rewardIn_bits_last(pes_0_io_rewardIn_bits_last),
    .io_PEResultOut_ready(pes_0_io_PEResultOut_ready),
    .io_PEResultOut_valid(pes_0_io_PEResultOut_valid),
    .io_PEResultOut_bits_benefit(pes_0_io_PEResultOut_bits_benefit),
    .io_PEResultOut_bits_id(pes_0_io_PEResultOut_bits_id),
    .io_PEResultOut_bits_last(pes_0_io_PEResultOut_bits_last),
    .io_accountantNotifyContinue(pes_0_io_accountantNotifyContinue)
  );
  ProcessingElementExtPrice pes_1 ( // @[AuctionBram.scala 105:11]
    .clock(pes_1_clock),
    .reset(pes_1_reset),
    .io_priceStore_req_valid(pes_1_io_priceStore_req_valid),
    .io_priceStore_req_bits_addr(pes_1_io_priceStore_req_bits_addr),
    .io_priceStore_rsp_ready(pes_1_io_priceStore_rsp_ready),
    .io_priceStore_rsp_bits_rdata(pes_1_io_priceStore_rsp_bits_rdata),
    .io_rewardIn_ready(pes_1_io_rewardIn_ready),
    .io_rewardIn_valid(pes_1_io_rewardIn_valid),
    .io_rewardIn_bits_reward(pes_1_io_rewardIn_bits_reward),
    .io_rewardIn_bits_idx(pes_1_io_rewardIn_bits_idx),
    .io_rewardIn_bits_last(pes_1_io_rewardIn_bits_last),
    .io_PEResultOut_ready(pes_1_io_PEResultOut_ready),
    .io_PEResultOut_valid(pes_1_io_PEResultOut_valid),
    .io_PEResultOut_bits_benefit(pes_1_io_PEResultOut_bits_benefit),
    .io_PEResultOut_bits_id(pes_1_io_PEResultOut_bits_id),
    .io_PEResultOut_bits_last(pes_1_io_PEResultOut_bits_last),
    .io_accountantNotifyContinue(pes_1_io_accountantNotifyContinue)
  );
  ProcessingElementExtPrice pes_2 ( // @[AuctionBram.scala 105:11]
    .clock(pes_2_clock),
    .reset(pes_2_reset),
    .io_priceStore_req_valid(pes_2_io_priceStore_req_valid),
    .io_priceStore_req_bits_addr(pes_2_io_priceStore_req_bits_addr),
    .io_priceStore_rsp_ready(pes_2_io_priceStore_rsp_ready),
    .io_priceStore_rsp_bits_rdata(pes_2_io_priceStore_rsp_bits_rdata),
    .io_rewardIn_ready(pes_2_io_rewardIn_ready),
    .io_rewardIn_valid(pes_2_io_rewardIn_valid),
    .io_rewardIn_bits_reward(pes_2_io_rewardIn_bits_reward),
    .io_rewardIn_bits_idx(pes_2_io_rewardIn_bits_idx),
    .io_rewardIn_bits_last(pes_2_io_rewardIn_bits_last),
    .io_PEResultOut_ready(pes_2_io_PEResultOut_ready),
    .io_PEResultOut_valid(pes_2_io_PEResultOut_valid),
    .io_PEResultOut_bits_benefit(pes_2_io_PEResultOut_bits_benefit),
    .io_PEResultOut_bits_id(pes_2_io_PEResultOut_bits_id),
    .io_PEResultOut_bits_last(pes_2_io_PEResultOut_bits_last),
    .io_accountantNotifyContinue(pes_2_io_accountantNotifyContinue)
  );
  ProcessingElementExtPrice pes_3 ( // @[AuctionBram.scala 105:11]
    .clock(pes_3_clock),
    .reset(pes_3_reset),
    .io_priceStore_req_valid(pes_3_io_priceStore_req_valid),
    .io_priceStore_req_bits_addr(pes_3_io_priceStore_req_bits_addr),
    .io_priceStore_rsp_ready(pes_3_io_priceStore_rsp_ready),
    .io_priceStore_rsp_bits_rdata(pes_3_io_priceStore_rsp_bits_rdata),
    .io_rewardIn_ready(pes_3_io_rewardIn_ready),
    .io_rewardIn_valid(pes_3_io_rewardIn_valid),
    .io_rewardIn_bits_reward(pes_3_io_rewardIn_bits_reward),
    .io_rewardIn_bits_idx(pes_3_io_rewardIn_bits_idx),
    .io_rewardIn_bits_last(pes_3_io_rewardIn_bits_last),
    .io_PEResultOut_ready(pes_3_io_PEResultOut_ready),
    .io_PEResultOut_valid(pes_3_io_PEResultOut_valid),
    .io_PEResultOut_bits_benefit(pes_3_io_PEResultOut_bits_benefit),
    .io_PEResultOut_bits_id(pes_3_io_PEResultOut_bits_id),
    .io_PEResultOut_bits_last(pes_3_io_PEResultOut_bits_last),
    .io_accountantNotifyContinue(pes_3_io_accountantNotifyContinue)
  );
  ProcessingElementExtPrice pes_4 ( // @[AuctionBram.scala 105:11]
    .clock(pes_4_clock),
    .reset(pes_4_reset),
    .io_priceStore_req_valid(pes_4_io_priceStore_req_valid),
    .io_priceStore_req_bits_addr(pes_4_io_priceStore_req_bits_addr),
    .io_priceStore_rsp_ready(pes_4_io_priceStore_rsp_ready),
    .io_priceStore_rsp_bits_rdata(pes_4_io_priceStore_rsp_bits_rdata),
    .io_rewardIn_ready(pes_4_io_rewardIn_ready),
    .io_rewardIn_valid(pes_4_io_rewardIn_valid),
    .io_rewardIn_bits_reward(pes_4_io_rewardIn_bits_reward),
    .io_rewardIn_bits_idx(pes_4_io_rewardIn_bits_idx),
    .io_rewardIn_bits_last(pes_4_io_rewardIn_bits_last),
    .io_PEResultOut_ready(pes_4_io_PEResultOut_ready),
    .io_PEResultOut_valid(pes_4_io_PEResultOut_valid),
    .io_PEResultOut_bits_benefit(pes_4_io_PEResultOut_bits_benefit),
    .io_PEResultOut_bits_id(pes_4_io_PEResultOut_bits_id),
    .io_PEResultOut_bits_last(pes_4_io_PEResultOut_bits_last),
    .io_accountantNotifyContinue(pes_4_io_accountantNotifyContinue)
  );
  ProcessingElementExtPrice pes_5 ( // @[AuctionBram.scala 105:11]
    .clock(pes_5_clock),
    .reset(pes_5_reset),
    .io_priceStore_req_valid(pes_5_io_priceStore_req_valid),
    .io_priceStore_req_bits_addr(pes_5_io_priceStore_req_bits_addr),
    .io_priceStore_rsp_ready(pes_5_io_priceStore_rsp_ready),
    .io_priceStore_rsp_bits_rdata(pes_5_io_priceStore_rsp_bits_rdata),
    .io_rewardIn_ready(pes_5_io_rewardIn_ready),
    .io_rewardIn_valid(pes_5_io_rewardIn_valid),
    .io_rewardIn_bits_reward(pes_5_io_rewardIn_bits_reward),
    .io_rewardIn_bits_idx(pes_5_io_rewardIn_bits_idx),
    .io_rewardIn_bits_last(pes_5_io_rewardIn_bits_last),
    .io_PEResultOut_ready(pes_5_io_PEResultOut_ready),
    .io_PEResultOut_valid(pes_5_io_PEResultOut_valid),
    .io_PEResultOut_bits_benefit(pes_5_io_PEResultOut_bits_benefit),
    .io_PEResultOut_bits_id(pes_5_io_PEResultOut_bits_id),
    .io_PEResultOut_bits_last(pes_5_io_PEResultOut_bits_last),
    .io_accountantNotifyContinue(pes_5_io_accountantNotifyContinue)
  );
  ProcessingElementExtPrice pes_6 ( // @[AuctionBram.scala 105:11]
    .clock(pes_6_clock),
    .reset(pes_6_reset),
    .io_priceStore_req_valid(pes_6_io_priceStore_req_valid),
    .io_priceStore_req_bits_addr(pes_6_io_priceStore_req_bits_addr),
    .io_priceStore_rsp_ready(pes_6_io_priceStore_rsp_ready),
    .io_priceStore_rsp_bits_rdata(pes_6_io_priceStore_rsp_bits_rdata),
    .io_rewardIn_ready(pes_6_io_rewardIn_ready),
    .io_rewardIn_valid(pes_6_io_rewardIn_valid),
    .io_rewardIn_bits_reward(pes_6_io_rewardIn_bits_reward),
    .io_rewardIn_bits_idx(pes_6_io_rewardIn_bits_idx),
    .io_rewardIn_bits_last(pes_6_io_rewardIn_bits_last),
    .io_PEResultOut_ready(pes_6_io_PEResultOut_ready),
    .io_PEResultOut_valid(pes_6_io_PEResultOut_valid),
    .io_PEResultOut_bits_benefit(pes_6_io_PEResultOut_bits_benefit),
    .io_PEResultOut_bits_id(pes_6_io_PEResultOut_bits_id),
    .io_PEResultOut_bits_last(pes_6_io_PEResultOut_bits_last),
    .io_accountantNotifyContinue(pes_6_io_accountantNotifyContinue)
  );
  ProcessingElementExtPrice pes_7 ( // @[AuctionBram.scala 105:11]
    .clock(pes_7_clock),
    .reset(pes_7_reset),
    .io_priceStore_req_valid(pes_7_io_priceStore_req_valid),
    .io_priceStore_req_bits_addr(pes_7_io_priceStore_req_bits_addr),
    .io_priceStore_rsp_ready(pes_7_io_priceStore_rsp_ready),
    .io_priceStore_rsp_bits_rdata(pes_7_io_priceStore_rsp_bits_rdata),
    .io_rewardIn_ready(pes_7_io_rewardIn_ready),
    .io_rewardIn_valid(pes_7_io_rewardIn_valid),
    .io_rewardIn_bits_reward(pes_7_io_rewardIn_bits_reward),
    .io_rewardIn_bits_idx(pes_7_io_rewardIn_bits_idx),
    .io_rewardIn_bits_last(pes_7_io_rewardIn_bits_last),
    .io_PEResultOut_ready(pes_7_io_PEResultOut_ready),
    .io_PEResultOut_valid(pes_7_io_PEResultOut_valid),
    .io_PEResultOut_bits_benefit(pes_7_io_PEResultOut_bits_benefit),
    .io_PEResultOut_bits_id(pes_7_io_PEResultOut_bits_id),
    .io_PEResultOut_bits_last(pes_7_io_PEResultOut_bits_last),
    .io_accountantNotifyContinue(pes_7_io_accountantNotifyContinue)
  );
  SearchTaskPar search ( // @[AuctionBram.scala 111:22]
    .clock(search_clock),
    .reset(search_reset),
    .io_benefitIn_0_ready(search_io_benefitIn_0_ready),
    .io_benefitIn_0_valid(search_io_benefitIn_0_valid),
    .io_benefitIn_0_bits_benefit(search_io_benefitIn_0_bits_benefit),
    .io_benefitIn_0_bits_id(search_io_benefitIn_0_bits_id),
    .io_benefitIn_0_bits_last(search_io_benefitIn_0_bits_last),
    .io_benefitIn_1_ready(search_io_benefitIn_1_ready),
    .io_benefitIn_1_valid(search_io_benefitIn_1_valid),
    .io_benefitIn_1_bits_benefit(search_io_benefitIn_1_bits_benefit),
    .io_benefitIn_1_bits_id(search_io_benefitIn_1_bits_id),
    .io_benefitIn_2_ready(search_io_benefitIn_2_ready),
    .io_benefitIn_2_valid(search_io_benefitIn_2_valid),
    .io_benefitIn_2_bits_benefit(search_io_benefitIn_2_bits_benefit),
    .io_benefitIn_2_bits_id(search_io_benefitIn_2_bits_id),
    .io_benefitIn_3_ready(search_io_benefitIn_3_ready),
    .io_benefitIn_3_valid(search_io_benefitIn_3_valid),
    .io_benefitIn_3_bits_benefit(search_io_benefitIn_3_bits_benefit),
    .io_benefitIn_3_bits_id(search_io_benefitIn_3_bits_id),
    .io_benefitIn_4_ready(search_io_benefitIn_4_ready),
    .io_benefitIn_4_valid(search_io_benefitIn_4_valid),
    .io_benefitIn_4_bits_benefit(search_io_benefitIn_4_bits_benefit),
    .io_benefitIn_4_bits_id(search_io_benefitIn_4_bits_id),
    .io_benefitIn_5_ready(search_io_benefitIn_5_ready),
    .io_benefitIn_5_valid(search_io_benefitIn_5_valid),
    .io_benefitIn_5_bits_benefit(search_io_benefitIn_5_bits_benefit),
    .io_benefitIn_5_bits_id(search_io_benefitIn_5_bits_id),
    .io_benefitIn_6_ready(search_io_benefitIn_6_ready),
    .io_benefitIn_6_valid(search_io_benefitIn_6_valid),
    .io_benefitIn_6_bits_benefit(search_io_benefitIn_6_bits_benefit),
    .io_benefitIn_6_bits_id(search_io_benefitIn_6_bits_id),
    .io_benefitIn_7_ready(search_io_benefitIn_7_ready),
    .io_benefitIn_7_valid(search_io_benefitIn_7_valid),
    .io_benefitIn_7_bits_benefit(search_io_benefitIn_7_bits_benefit),
    .io_benefitIn_7_bits_id(search_io_benefitIn_7_bits_id),
    .io_resultOut_ready(search_io_resultOut_ready),
    .io_resultOut_valid(search_io_resultOut_valid),
    .io_resultOut_bits_winner(search_io_resultOut_bits_winner),
    .io_resultOut_bits_bid(search_io_resultOut_bits_bid)
  );
  assign io_memPort_0_memRdReq_valid = dram2bram_io_dramReq_valid; // @[AuctionBram.scala 69:24]
  assign io_memPort_0_memRdReq_bits_addr = dram2bram_io_dramReq_bits_addr; // @[AuctionBram.scala 69:24]
  assign io_memPort_0_memRdReq_bits_numBytes = dram2bram_io_dramReq_bits_numBytes; // @[AuctionBram.scala 69:24]
  assign io_memPort_0_memRdRsp_ready = dram2bram_io_dramRsp_ready; // @[AuctionBram.scala 70:24]
  assign io_memPort_0_memWrReq_valid = memWriter_io_req_valid; // @[AuctionBram.scala 90:20]
  assign io_memPort_0_memWrReq_bits_addr = memWriter_io_req_bits_addr; // @[AuctionBram.scala 90:20]
  assign io_memPort_0_memWrDat_valid = memWriter_io_wdat_valid; // @[AuctionBram.scala 92:26]
  assign io_memPort_0_memWrDat_bits = memWriter_io_wdat_bits; // @[AuctionBram.scala 92:26]
  assign io_rfOut_finished = controller_io_rfCtrl_finished; // @[AuctionBram.scala 142:12]
  assign io_rfOut_cycleCount = regCycleCount; // @[AuctionBram.scala 146:23]
  assign memController_clock = clock;
  assign memController_reset = reset;
  assign memController_io_unassignedAgents_valid = qUnassignedAgents_io_deq_valid; // @[AuctionBram.scala 129:37]
  assign memController_io_unassignedAgents_bits_agent = qUnassignedAgents_io_deq_bits_agent[5:0]; // @[AuctionBram.scala 129:37]
  assign memController_io_requestedAgents_ready = qRequestedAgents_io_enq_ready; // @[AuctionBram.scala 133:36]
  assign memController_io_agentRowAddrReq_rsp_bits_rdata_rowAddr = agentRowStore_io_rPorts_0_rsp_bits_rdata_rowAddr; // @[AuctionBram.scala 115:36]
  assign memController_io_agentRowAddrReq_rsp_bits_rdata_length = agentRowStore_io_rPorts_0_rsp_bits_rdata_length; // @[AuctionBram.scala 115:36]
  assign memController_io_bramReq_rsp_readData = bram_io_read_rsp_readData; // @[AuctionBram.scala 116:28]
  assign memController_io_dataDistOut_ready = dataMux_io_bramWordIn_ready; // @[AuctionBram.scala 114:32]
  assign controller_clock = clock;
  assign controller_reset = reset;
  assign controller_io_rfInfo_start = io_rfIn_start; // @[AuctionBram.scala 141:24]
  assign controller_io_rfInfo_baseAddr = io_rfIn_baseAddr; // @[AuctionBram.scala 141:24]
  assign controller_io_rfInfo_nAgents = io_rfIn_nAgents; // @[AuctionBram.scala 141:24]
  assign controller_io_rfInfo_nObjects = io_rfIn_nObjects; // @[AuctionBram.scala 141:24]
  assign controller_io_dram2bram_finished = dram2bram_io_finished; // @[AuctionBram.scala 77:36]
  assign controller_io_unassignedAgentsIn_valid = accountant_io_unassignedAgents_valid; // @[AuctionBram.scala 131:36]
  assign controller_io_unassignedAgentsIn_bits_agent = accountant_io_unassignedAgents_bits_agent; // @[AuctionBram.scala 131:36]
  assign controller_io_unassignedAgentsOut_ready = qUnassignedAgents_io_enq_ready; // @[AuctionBram.scala 130:28]
  assign controller_io_requestedAgentsIn_valid = qRequestedAgents_io_deq_valid; // @[AuctionBram.scala 134:27]
  assign controller_io_requestedAgentsIn_bits_agent = qRequestedAgents_io_deq_bits_agent; // @[AuctionBram.scala 134:27]
  assign controller_io_requestedAgentsOut_ready = accountant_io_requestedAgents_ready; // @[AuctionBram.scala 135:36]
  assign controller_io_writeBackDone = accountant_io_writeBackDone; // @[AuctionBram.scala 137:31]
  assign accountant_clock = clock;
  assign accountant_reset = reset;
  assign accountant_io_searchResultIn_valid = search_io_resultOut_valid; // @[AuctionBram.scala 125:23]
  assign accountant_io_searchResultIn_bits_winner = search_io_resultOut_bits_winner; // @[AuctionBram.scala 125:23]
  assign accountant_io_searchResultIn_bits_bid = search_io_resultOut_bits_bid; // @[AuctionBram.scala 125:23]
  assign accountant_io_unassignedAgents_ready = controller_io_unassignedAgentsIn_ready; // @[AuctionBram.scala 131:36]
  assign accountant_io_requestedAgents_valid = controller_io_requestedAgentsOut_valid; // @[AuctionBram.scala 135:36]
  assign accountant_io_requestedAgents_bits_agent = controller_io_requestedAgentsOut_bits_agent; // @[AuctionBram.scala 135:36]
  assign accountant_io_rfInfo_nObjects = io_rfIn_nObjects; // @[AuctionBram.scala 139:24]
  assign accountant_io_doWriteBack = controller_io_doWriteBack; // @[AuctionBram.scala 138:29]
  assign accountant_io_writeBackStream_wrData_ready = memWriter_io_in_ready; // @[AuctionBram.scala 94:19]
  assign accountant_io_writeBackStream_finished = memWriter_io_finished; // @[AuctionBram.scala 98:42]
  assign accountant_io_priceStore_rsp_valid = priceStore_io_rwPorts_0_rsp_valid; // @[AuctionBram.scala 126:28]
  assign accountant_io_priceStore_rsp_bits_rdata = priceStore_io_rwPorts_0_rsp_bits_rdata; // @[AuctionBram.scala 126:28]
  assign dataMux_clock = clock;
  assign dataMux_reset = reset;
  assign dataMux_io_bramWordIn_valid = memController_io_dataDistOut_valid; // @[AuctionBram.scala 114:32]
  assign dataMux_io_bramWordIn_bits_els_0_reward = memController_io_dataDistOut_bits_els_0_reward; // @[AuctionBram.scala 114:32]
  assign dataMux_io_bramWordIn_bits_els_0_idx = memController_io_dataDistOut_bits_els_0_idx; // @[AuctionBram.scala 114:32]
  assign dataMux_io_bramWordIn_bits_els_1_reward = memController_io_dataDistOut_bits_els_1_reward; // @[AuctionBram.scala 114:32]
  assign dataMux_io_bramWordIn_bits_els_1_idx = memController_io_dataDistOut_bits_els_1_idx; // @[AuctionBram.scala 114:32]
  assign dataMux_io_bramWordIn_bits_els_2_reward = memController_io_dataDistOut_bits_els_2_reward; // @[AuctionBram.scala 114:32]
  assign dataMux_io_bramWordIn_bits_els_2_idx = memController_io_dataDistOut_bits_els_2_idx; // @[AuctionBram.scala 114:32]
  assign dataMux_io_bramWordIn_bits_els_3_reward = memController_io_dataDistOut_bits_els_3_reward; // @[AuctionBram.scala 114:32]
  assign dataMux_io_bramWordIn_bits_els_3_idx = memController_io_dataDistOut_bits_els_3_idx; // @[AuctionBram.scala 114:32]
  assign dataMux_io_bramWordIn_bits_els_4_reward = memController_io_dataDistOut_bits_els_4_reward; // @[AuctionBram.scala 114:32]
  assign dataMux_io_bramWordIn_bits_els_4_idx = memController_io_dataDistOut_bits_els_4_idx; // @[AuctionBram.scala 114:32]
  assign dataMux_io_bramWordIn_bits_els_5_reward = memController_io_dataDistOut_bits_els_5_reward; // @[AuctionBram.scala 114:32]
  assign dataMux_io_bramWordIn_bits_els_5_idx = memController_io_dataDistOut_bits_els_5_idx; // @[AuctionBram.scala 114:32]
  assign dataMux_io_bramWordIn_bits_els_6_reward = memController_io_dataDistOut_bits_els_6_reward; // @[AuctionBram.scala 114:32]
  assign dataMux_io_bramWordIn_bits_els_6_idx = memController_io_dataDistOut_bits_els_6_idx; // @[AuctionBram.scala 114:32]
  assign dataMux_io_bramWordIn_bits_els_7_reward = memController_io_dataDistOut_bits_els_7_reward; // @[AuctionBram.scala 114:32]
  assign dataMux_io_bramWordIn_bits_els_7_idx = memController_io_dataDistOut_bits_els_7_idx; // @[AuctionBram.scala 114:32]
  assign dataMux_io_bramWordIn_bits_last = memController_io_dataDistOut_bits_last; // @[AuctionBram.scala 114:32]
  assign dataMux_io_peOut_0_ready = pes_0_io_rewardIn_ready; // @[AuctionBram.scala 119:25]
  assign qUnassignedAgents_clock = clock;
  assign qUnassignedAgents_reset = reset;
  assign qUnassignedAgents_io_enq_valid = controller_io_unassignedAgentsOut_valid; // @[AuctionBram.scala 130:28]
  assign qUnassignedAgents_io_enq_bits_agent = controller_io_unassignedAgentsOut_bits_agent; // @[AuctionBram.scala 130:28]
  assign qUnassignedAgents_io_deq_ready = memController_io_unassignedAgents_ready; // @[AuctionBram.scala 129:37]
  assign qRequestedAgents_clock = clock;
  assign qRequestedAgents_reset = reset;
  assign qRequestedAgents_io_enq_valid = memController_io_requestedAgents_valid; // @[AuctionBram.scala 133:36]
  assign qRequestedAgents_io_enq_bits_agent = {{2'd0}, memController_io_requestedAgents_bits_agent}; // @[AuctionBram.scala 133:36]
  assign qRequestedAgents_io_deq_ready = controller_io_requestedAgentsIn_ready; // @[AuctionBram.scala 134:27]
  assign bram_clock = clock;
  assign bram_io_read_req_addr = memController_io_bramReq_req_addr; // @[AuctionBram.scala 116:28]
  assign bram_io_write_req_addr = dram2bram_io_bramCmd_req_addr; // @[AuctionBram.scala 71:24]
  assign bram_io_write_req_writeData = dram2bram_io_bramCmd_req_writeData; // @[AuctionBram.scala 71:24]
  assign bram_io_write_req_writeEn = dram2bram_io_bramCmd_req_writeEn; // @[AuctionBram.scala 71:24]
  assign priceStore_clock = clock;
  assign priceStore_reset = controller_io_reinit; // @[AuctionBram.scala 63:20]
  assign priceStore_io_rPorts_0_req_valid = pes_0_io_priceStore_req_valid; // @[AuctionBram.scala 121:26]
  assign priceStore_io_rPorts_0_req_bits_addr = pes_0_io_priceStore_req_bits_addr; // @[AuctionBram.scala 121:26]
  assign priceStore_io_rPorts_0_rsp_ready = pes_0_io_priceStore_rsp_ready; // @[AuctionBram.scala 121:26]
  assign priceStore_io_rPorts_1_req_valid = pes_1_io_priceStore_req_valid; // @[AuctionBram.scala 121:26]
  assign priceStore_io_rPorts_1_req_bits_addr = pes_1_io_priceStore_req_bits_addr; // @[AuctionBram.scala 121:26]
  assign priceStore_io_rPorts_1_rsp_ready = pes_1_io_priceStore_rsp_ready; // @[AuctionBram.scala 121:26]
  assign priceStore_io_rPorts_2_req_valid = pes_2_io_priceStore_req_valid; // @[AuctionBram.scala 121:26]
  assign priceStore_io_rPorts_2_req_bits_addr = pes_2_io_priceStore_req_bits_addr; // @[AuctionBram.scala 121:26]
  assign priceStore_io_rPorts_2_rsp_ready = pes_2_io_priceStore_rsp_ready; // @[AuctionBram.scala 121:26]
  assign priceStore_io_rPorts_3_req_valid = pes_3_io_priceStore_req_valid; // @[AuctionBram.scala 121:26]
  assign priceStore_io_rPorts_3_req_bits_addr = pes_3_io_priceStore_req_bits_addr; // @[AuctionBram.scala 121:26]
  assign priceStore_io_rPorts_3_rsp_ready = pes_3_io_priceStore_rsp_ready; // @[AuctionBram.scala 121:26]
  assign priceStore_io_rPorts_4_req_valid = pes_4_io_priceStore_req_valid; // @[AuctionBram.scala 121:26]
  assign priceStore_io_rPorts_4_req_bits_addr = pes_4_io_priceStore_req_bits_addr; // @[AuctionBram.scala 121:26]
  assign priceStore_io_rPorts_4_rsp_ready = pes_4_io_priceStore_rsp_ready; // @[AuctionBram.scala 121:26]
  assign priceStore_io_rPorts_5_req_valid = pes_5_io_priceStore_req_valid; // @[AuctionBram.scala 121:26]
  assign priceStore_io_rPorts_5_req_bits_addr = pes_5_io_priceStore_req_bits_addr; // @[AuctionBram.scala 121:26]
  assign priceStore_io_rPorts_5_rsp_ready = pes_5_io_priceStore_rsp_ready; // @[AuctionBram.scala 121:26]
  assign priceStore_io_rPorts_6_req_valid = pes_6_io_priceStore_req_valid; // @[AuctionBram.scala 121:26]
  assign priceStore_io_rPorts_6_req_bits_addr = pes_6_io_priceStore_req_bits_addr; // @[AuctionBram.scala 121:26]
  assign priceStore_io_rPorts_6_rsp_ready = pes_6_io_priceStore_rsp_ready; // @[AuctionBram.scala 121:26]
  assign priceStore_io_rPorts_7_req_valid = pes_7_io_priceStore_req_valid; // @[AuctionBram.scala 121:26]
  assign priceStore_io_rPorts_7_req_bits_addr = pes_7_io_priceStore_req_bits_addr; // @[AuctionBram.scala 121:26]
  assign priceStore_io_rPorts_7_rsp_ready = pes_7_io_priceStore_rsp_ready; // @[AuctionBram.scala 121:26]
  assign priceStore_io_rwPorts_0_req_valid = accountant_io_priceStore_req_valid; // @[AuctionBram.scala 126:28]
  assign priceStore_io_rwPorts_0_req_bits_wen = accountant_io_priceStore_req_bits_wen; // @[AuctionBram.scala 126:28]
  assign priceStore_io_rwPorts_0_req_bits_addr = accountant_io_priceStore_req_bits_addr; // @[AuctionBram.scala 126:28]
  assign priceStore_io_rwPorts_0_req_bits_wdata = accountant_io_priceStore_req_bits_wdata; // @[AuctionBram.scala 126:28]
  assign agentRowStore_clock = clock;
  assign agentRowStore_reset = controller_io_reinit; // @[AuctionBram.scala 64:23]
  assign agentRowStore_io_wPorts_0_req_valid = dram2bram_io_agentRowAddress_req_valid; // @[AuctionBram.scala 76:32]
  assign agentRowStore_io_wPorts_0_req_bits_addr = dram2bram_io_agentRowAddress_req_bits_addr; // @[AuctionBram.scala 76:32]
  assign agentRowStore_io_wPorts_0_req_bits_wdata_rowAddr = dram2bram_io_agentRowAddress_req_bits_wdata_rowAddr; // @[AuctionBram.scala 76:32]
  assign agentRowStore_io_wPorts_0_req_bits_wdata_length = dram2bram_io_agentRowAddress_req_bits_wdata_length; // @[AuctionBram.scala 76:32]
  assign agentRowStore_io_rPorts_0_req_valid = memController_io_agentRowAddrReq_req_valid; // @[AuctionBram.scala 115:36]
  assign agentRowStore_io_rPorts_0_req_bits_addr = memController_io_agentRowAddrReq_req_bits_addr; // @[AuctionBram.scala 115:36]
  assign agentRowStore_io_rPorts_0_rsp_ready = memController_io_agentRowAddrReq_rsp_ready; // @[AuctionBram.scala 115:36]
  assign dram2bram_clock = clock;
  assign dram2bram_reset = reset;
  assign dram2bram_io_dramReq_ready = io_memPort_0_memRdReq_ready; // @[AuctionBram.scala 69:24]
  assign dram2bram_io_dramRsp_valid = io_memPort_0_memRdRsp_valid; // @[AuctionBram.scala 70:24]
  assign dram2bram_io_dramRsp_bits_readData = io_memPort_0_memRdRsp_bits_readData; // @[AuctionBram.scala 70:24]
  assign dram2bram_io_start = controller_io_dram2bram_start; // @[AuctionBram.scala 72:22]
  assign dram2bram_io_baseAddr = controller_io_dram2bram_baseAddr; // @[AuctionBram.scala 73:25]
  assign dram2bram_io_nRows = controller_io_dram2bram_nRows; // @[AuctionBram.scala 74:22]
  assign dram2bram_io_nCols = controller_io_dram2bram_nCols; // @[AuctionBram.scala 75:22]
  assign memWriter_clock = clock;
  assign memWriter_reset = reset;
  assign memWriter_io_start = accountant_io_writeBackStream_start; // @[AuctionBram.scala 95:22]
  assign memWriter_io_baseAddr = io_rfIn_baseAddrRes[31:0]; // @[AuctionBram.scala 96:25]
  assign memWriter_io_byteCount = _T[31:0]; // @[AuctionBram.scala 97:26]
  assign memWriter_io_in_valid = accountant_io_writeBackStream_wrData_valid; // @[AuctionBram.scala 94:19]
  assign memWriter_io_in_bits = accountant_io_writeBackStream_wrData_bits; // @[AuctionBram.scala 94:19]
  assign memWriter_io_req_ready = io_memPort_0_memWrReq_ready; // @[AuctionBram.scala 90:20]
  assign memWriter_io_wdat_ready = io_memPort_0_memWrDat_ready; // @[AuctionBram.scala 92:26]
  assign memWriter_io_rsp_valid = io_memPort_0_memWrRsp_valid; // @[AuctionBram.scala 91:20]
  assign pes_0_clock = clock;
  assign pes_0_reset = reset;
  assign pes_0_io_priceStore_rsp_bits_rdata = priceStore_io_rPorts_0_rsp_bits_rdata; // @[AuctionBram.scala 121:26]
  assign pes_0_io_rewardIn_valid = dataMux_io_peOut_0_valid; // @[AuctionBram.scala 119:25]
  assign pes_0_io_rewardIn_bits_reward = dataMux_io_peOut_0_bits_reward; // @[AuctionBram.scala 119:25]
  assign pes_0_io_rewardIn_bits_idx = dataMux_io_peOut_0_bits_idx; // @[AuctionBram.scala 119:25]
  assign pes_0_io_rewardIn_bits_last = dataMux_io_peOut_0_bits_last; // @[AuctionBram.scala 119:25]
  assign pes_0_io_PEResultOut_ready = search_io_benefitIn_0_ready; // @[AuctionBram.scala 120:27]
  assign pes_0_io_accountantNotifyContinue = accountant_io_notifyPEsContinue; // @[AuctionBram.scala 122:40]
  assign pes_1_clock = clock;
  assign pes_1_reset = reset;
  assign pes_1_io_priceStore_rsp_bits_rdata = priceStore_io_rPorts_1_rsp_bits_rdata; // @[AuctionBram.scala 121:26]
  assign pes_1_io_rewardIn_valid = dataMux_io_peOut_1_valid; // @[AuctionBram.scala 119:25]
  assign pes_1_io_rewardIn_bits_reward = dataMux_io_peOut_1_bits_reward; // @[AuctionBram.scala 119:25]
  assign pes_1_io_rewardIn_bits_idx = dataMux_io_peOut_1_bits_idx; // @[AuctionBram.scala 119:25]
  assign pes_1_io_rewardIn_bits_last = dataMux_io_peOut_1_bits_last; // @[AuctionBram.scala 119:25]
  assign pes_1_io_PEResultOut_ready = search_io_benefitIn_1_ready; // @[AuctionBram.scala 120:27]
  assign pes_1_io_accountantNotifyContinue = accountant_io_notifyPEsContinue; // @[AuctionBram.scala 122:40]
  assign pes_2_clock = clock;
  assign pes_2_reset = reset;
  assign pes_2_io_priceStore_rsp_bits_rdata = priceStore_io_rPorts_2_rsp_bits_rdata; // @[AuctionBram.scala 121:26]
  assign pes_2_io_rewardIn_valid = dataMux_io_peOut_2_valid; // @[AuctionBram.scala 119:25]
  assign pes_2_io_rewardIn_bits_reward = dataMux_io_peOut_2_bits_reward; // @[AuctionBram.scala 119:25]
  assign pes_2_io_rewardIn_bits_idx = dataMux_io_peOut_2_bits_idx; // @[AuctionBram.scala 119:25]
  assign pes_2_io_rewardIn_bits_last = dataMux_io_peOut_2_bits_last; // @[AuctionBram.scala 119:25]
  assign pes_2_io_PEResultOut_ready = search_io_benefitIn_2_ready; // @[AuctionBram.scala 120:27]
  assign pes_2_io_accountantNotifyContinue = accountant_io_notifyPEsContinue; // @[AuctionBram.scala 122:40]
  assign pes_3_clock = clock;
  assign pes_3_reset = reset;
  assign pes_3_io_priceStore_rsp_bits_rdata = priceStore_io_rPorts_3_rsp_bits_rdata; // @[AuctionBram.scala 121:26]
  assign pes_3_io_rewardIn_valid = dataMux_io_peOut_3_valid; // @[AuctionBram.scala 119:25]
  assign pes_3_io_rewardIn_bits_reward = dataMux_io_peOut_3_bits_reward; // @[AuctionBram.scala 119:25]
  assign pes_3_io_rewardIn_bits_idx = dataMux_io_peOut_3_bits_idx; // @[AuctionBram.scala 119:25]
  assign pes_3_io_rewardIn_bits_last = dataMux_io_peOut_3_bits_last; // @[AuctionBram.scala 119:25]
  assign pes_3_io_PEResultOut_ready = search_io_benefitIn_3_ready; // @[AuctionBram.scala 120:27]
  assign pes_3_io_accountantNotifyContinue = accountant_io_notifyPEsContinue; // @[AuctionBram.scala 122:40]
  assign pes_4_clock = clock;
  assign pes_4_reset = reset;
  assign pes_4_io_priceStore_rsp_bits_rdata = priceStore_io_rPorts_4_rsp_bits_rdata; // @[AuctionBram.scala 121:26]
  assign pes_4_io_rewardIn_valid = dataMux_io_peOut_4_valid; // @[AuctionBram.scala 119:25]
  assign pes_4_io_rewardIn_bits_reward = dataMux_io_peOut_4_bits_reward; // @[AuctionBram.scala 119:25]
  assign pes_4_io_rewardIn_bits_idx = dataMux_io_peOut_4_bits_idx; // @[AuctionBram.scala 119:25]
  assign pes_4_io_rewardIn_bits_last = dataMux_io_peOut_4_bits_last; // @[AuctionBram.scala 119:25]
  assign pes_4_io_PEResultOut_ready = search_io_benefitIn_4_ready; // @[AuctionBram.scala 120:27]
  assign pes_4_io_accountantNotifyContinue = accountant_io_notifyPEsContinue; // @[AuctionBram.scala 122:40]
  assign pes_5_clock = clock;
  assign pes_5_reset = reset;
  assign pes_5_io_priceStore_rsp_bits_rdata = priceStore_io_rPorts_5_rsp_bits_rdata; // @[AuctionBram.scala 121:26]
  assign pes_5_io_rewardIn_valid = dataMux_io_peOut_5_valid; // @[AuctionBram.scala 119:25]
  assign pes_5_io_rewardIn_bits_reward = dataMux_io_peOut_5_bits_reward; // @[AuctionBram.scala 119:25]
  assign pes_5_io_rewardIn_bits_idx = dataMux_io_peOut_5_bits_idx; // @[AuctionBram.scala 119:25]
  assign pes_5_io_rewardIn_bits_last = dataMux_io_peOut_5_bits_last; // @[AuctionBram.scala 119:25]
  assign pes_5_io_PEResultOut_ready = search_io_benefitIn_5_ready; // @[AuctionBram.scala 120:27]
  assign pes_5_io_accountantNotifyContinue = accountant_io_notifyPEsContinue; // @[AuctionBram.scala 122:40]
  assign pes_6_clock = clock;
  assign pes_6_reset = reset;
  assign pes_6_io_priceStore_rsp_bits_rdata = priceStore_io_rPorts_6_rsp_bits_rdata; // @[AuctionBram.scala 121:26]
  assign pes_6_io_rewardIn_valid = dataMux_io_peOut_6_valid; // @[AuctionBram.scala 119:25]
  assign pes_6_io_rewardIn_bits_reward = dataMux_io_peOut_6_bits_reward; // @[AuctionBram.scala 119:25]
  assign pes_6_io_rewardIn_bits_idx = dataMux_io_peOut_6_bits_idx; // @[AuctionBram.scala 119:25]
  assign pes_6_io_rewardIn_bits_last = dataMux_io_peOut_6_bits_last; // @[AuctionBram.scala 119:25]
  assign pes_6_io_PEResultOut_ready = search_io_benefitIn_6_ready; // @[AuctionBram.scala 120:27]
  assign pes_6_io_accountantNotifyContinue = accountant_io_notifyPEsContinue; // @[AuctionBram.scala 122:40]
  assign pes_7_clock = clock;
  assign pes_7_reset = reset;
  assign pes_7_io_priceStore_rsp_bits_rdata = priceStore_io_rPorts_7_rsp_bits_rdata; // @[AuctionBram.scala 121:26]
  assign pes_7_io_rewardIn_valid = dataMux_io_peOut_7_valid; // @[AuctionBram.scala 119:25]
  assign pes_7_io_rewardIn_bits_reward = dataMux_io_peOut_7_bits_reward; // @[AuctionBram.scala 119:25]
  assign pes_7_io_rewardIn_bits_idx = dataMux_io_peOut_7_bits_idx; // @[AuctionBram.scala 119:25]
  assign pes_7_io_rewardIn_bits_last = dataMux_io_peOut_7_bits_last; // @[AuctionBram.scala 119:25]
  assign pes_7_io_PEResultOut_ready = search_io_benefitIn_7_ready; // @[AuctionBram.scala 120:27]
  assign pes_7_io_accountantNotifyContinue = accountant_io_notifyPEsContinue; // @[AuctionBram.scala 122:40]
  assign search_clock = clock;
  assign search_reset = reset;
  assign search_io_benefitIn_0_valid = pes_0_io_PEResultOut_valid; // @[AuctionBram.scala 120:27]
  assign search_io_benefitIn_0_bits_benefit = pes_0_io_PEResultOut_bits_benefit; // @[AuctionBram.scala 120:27]
  assign search_io_benefitIn_0_bits_id = pes_0_io_PEResultOut_bits_id; // @[AuctionBram.scala 120:27]
  assign search_io_benefitIn_0_bits_last = pes_0_io_PEResultOut_bits_last; // @[AuctionBram.scala 120:27]
  assign search_io_benefitIn_1_valid = pes_1_io_PEResultOut_valid; // @[AuctionBram.scala 120:27]
  assign search_io_benefitIn_1_bits_benefit = pes_1_io_PEResultOut_bits_benefit; // @[AuctionBram.scala 120:27]
  assign search_io_benefitIn_1_bits_id = pes_1_io_PEResultOut_bits_id; // @[AuctionBram.scala 120:27]
  assign search_io_benefitIn_2_valid = pes_2_io_PEResultOut_valid; // @[AuctionBram.scala 120:27]
  assign search_io_benefitIn_2_bits_benefit = pes_2_io_PEResultOut_bits_benefit; // @[AuctionBram.scala 120:27]
  assign search_io_benefitIn_2_bits_id = pes_2_io_PEResultOut_bits_id; // @[AuctionBram.scala 120:27]
  assign search_io_benefitIn_3_valid = pes_3_io_PEResultOut_valid; // @[AuctionBram.scala 120:27]
  assign search_io_benefitIn_3_bits_benefit = pes_3_io_PEResultOut_bits_benefit; // @[AuctionBram.scala 120:27]
  assign search_io_benefitIn_3_bits_id = pes_3_io_PEResultOut_bits_id; // @[AuctionBram.scala 120:27]
  assign search_io_benefitIn_4_valid = pes_4_io_PEResultOut_valid; // @[AuctionBram.scala 120:27]
  assign search_io_benefitIn_4_bits_benefit = pes_4_io_PEResultOut_bits_benefit; // @[AuctionBram.scala 120:27]
  assign search_io_benefitIn_4_bits_id = pes_4_io_PEResultOut_bits_id; // @[AuctionBram.scala 120:27]
  assign search_io_benefitIn_5_valid = pes_5_io_PEResultOut_valid; // @[AuctionBram.scala 120:27]
  assign search_io_benefitIn_5_bits_benefit = pes_5_io_PEResultOut_bits_benefit; // @[AuctionBram.scala 120:27]
  assign search_io_benefitIn_5_bits_id = pes_5_io_PEResultOut_bits_id; // @[AuctionBram.scala 120:27]
  assign search_io_benefitIn_6_valid = pes_6_io_PEResultOut_valid; // @[AuctionBram.scala 120:27]
  assign search_io_benefitIn_6_bits_benefit = pes_6_io_PEResultOut_bits_benefit; // @[AuctionBram.scala 120:27]
  assign search_io_benefitIn_6_bits_id = pes_6_io_PEResultOut_bits_id; // @[AuctionBram.scala 120:27]
  assign search_io_benefitIn_7_valid = pes_7_io_PEResultOut_valid; // @[AuctionBram.scala 120:27]
  assign search_io_benefitIn_7_bits_benefit = pes_7_io_PEResultOut_bits_benefit; // @[AuctionBram.scala 120:27]
  assign search_io_benefitIn_7_bits_id = pes_7_io_PEResultOut_bits_id; // @[AuctionBram.scala 120:27]
  assign search_io_resultOut_ready = accountant_io_searchResultIn_ready; // @[AuctionBram.scala 125:23]
  always @(posedge clock) begin
    if (reset) begin // @[AuctionBram.scala 144:24]
      running <= 1'h0; // @[AuctionBram.scala 144:24]
    end else if (_T_3) begin // @[AuctionBram.scala 153:18]
      running <= io_rfIn_start; // @[AuctionBram.scala 154:13]
    end else begin
      running <= ~controller_io_rfCtrl_finished; // @[AuctionBram.scala 156:13]
    end
    if (reset) begin // @[AuctionBram.scala 145:30]
      regCycleCount <= 32'h0; // @[AuctionBram.scala 145:30]
    end else if (running) begin // @[AuctionBram.scala 147:17]
      regCycleCount <= _T_2; // @[AuctionBram.scala 148:19]
    end else if (~running & io_rfIn_start) begin // @[AuctionBram.scala 149:41]
      regCycleCount <= 32'h0; // @[AuctionBram.scala 150:19]
    end
  end
// Register and memory initialization
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
  running = _RAND_0[0:0];
  _RAND_1 = {1{`RANDOM}};
  regCycleCount = _RAND_1[31:0];
`endif // RANDOMIZE_REG_INIT
  `endif // RANDOMIZE
end // initial
`ifdef FIRRTL_AFTER_INITIAL
`FIRRTL_AFTER_INITIAL
`endif
`endif // SYNTHESIS
endmodule
module RegFile(
  input         clock,
  input         reset,
  input         io_extIF_cmd_valid,
  input  [3:0]  io_extIF_cmd_bits_regID,
  input         io_extIF_cmd_bits_read,
  input         io_extIF_cmd_bits_write,
  input  [31:0] io_extIF_cmd_bits_writeData,
  output        io_extIF_readData_valid,
  output [31:0] io_extIF_readData_bits,
  output [31:0] io_regOut_1,
  output [31:0] io_regOut_2,
  output [31:0] io_regOut_3,
  output [31:0] io_regOut_4,
  output [31:0] io_regOut_5,
  output [31:0] io_regOut_6,
  output [31:0] io_regOut_7,
  input  [31:0] io_regIn_8_bits,
  input  [31:0] io_regIn_9_bits
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
  reg [31:0] _RAND_13;
  reg [31:0] _RAND_14;
`endif // RANDOMIZE_REG_INIT
  reg [31:0] regFile_0; // @[RegFile.scala 51:24]
  reg [31:0] regFile_1; // @[RegFile.scala 51:24]
  reg [31:0] regFile_2; // @[RegFile.scala 51:24]
  reg [31:0] regFile_3; // @[RegFile.scala 51:24]
  reg [31:0] regFile_4; // @[RegFile.scala 51:24]
  reg [31:0] regFile_5; // @[RegFile.scala 51:24]
  reg [31:0] regFile_6; // @[RegFile.scala 51:24]
  reg [31:0] regFile_7; // @[RegFile.scala 51:24]
  reg [31:0] regFile_8; // @[RegFile.scala 51:24]
  reg [31:0] regFile_9; // @[RegFile.scala 51:24]
  reg [3:0] regCommand_regID; // @[RegFile.scala 58:27]
  reg  regCommand_read; // @[RegFile.scala 58:27]
  reg  regCommand_write; // @[RegFile.scala 58:27]
  reg [31:0] regCommand_writeData; // @[RegFile.scala 58:27]
  reg  regDoCmd; // @[RegFile.scala 59:25]
  wire  hasExtWriteCommand = regDoCmd & regCommand_write; // @[RegFile.scala 63:38]
  wire [31:0] _GEN_1 = 4'h1 == regCommand_regID ? regFile_1 : regFile_0; // @[RegFile.scala 69:29 RegFile.scala 69:29]
  wire [31:0] _GEN_2 = 4'h2 == regCommand_regID ? regFile_2 : _GEN_1; // @[RegFile.scala 69:29 RegFile.scala 69:29]
  wire [31:0] _GEN_3 = 4'h3 == regCommand_regID ? regFile_3 : _GEN_2; // @[RegFile.scala 69:29 RegFile.scala 69:29]
  wire [31:0] _GEN_4 = 4'h4 == regCommand_regID ? regFile_4 : _GEN_3; // @[RegFile.scala 69:29 RegFile.scala 69:29]
  wire [31:0] _GEN_5 = 4'h5 == regCommand_regID ? regFile_5 : _GEN_4; // @[RegFile.scala 69:29 RegFile.scala 69:29]
  wire [31:0] _GEN_6 = 4'h6 == regCommand_regID ? regFile_6 : _GEN_5; // @[RegFile.scala 69:29 RegFile.scala 69:29]
  wire [31:0] _GEN_7 = 4'h7 == regCommand_regID ? regFile_7 : _GEN_6; // @[RegFile.scala 69:29 RegFile.scala 69:29]
  wire [31:0] _GEN_8 = 4'h8 == regCommand_regID ? regFile_8 : _GEN_7; // @[RegFile.scala 69:29 RegFile.scala 69:29]
  wire [31:0] _GEN_9 = 4'h9 == regCommand_regID ? regFile_9 : _GEN_8; // @[RegFile.scala 69:29 RegFile.scala 69:29]
  assign io_extIF_readData_valid = regDoCmd & regCommand_read; // @[RegFile.scala 62:37]
  assign io_extIF_readData_bits = regCommand_regID < 4'ha ? _GEN_9 : 32'h0; // @[RegFile.scala 68:41 RegFile.scala 69:29 RegFile.scala 72:29]
  assign io_regOut_1 = regFile_1; // @[RegFile.scala 89:18]
  assign io_regOut_2 = regFile_2; // @[RegFile.scala 89:18]
  assign io_regOut_3 = regFile_3; // @[RegFile.scala 89:18]
  assign io_regOut_4 = regFile_4; // @[RegFile.scala 89:18]
  assign io_regOut_5 = regFile_5; // @[RegFile.scala 89:18]
  assign io_regOut_6 = regFile_6; // @[RegFile.scala 89:18]
  assign io_regOut_7 = regFile_7; // @[RegFile.scala 89:18]
  always @(posedge clock) begin
    if (reset) begin // @[RegFile.scala 51:24]
      regFile_0 <= 32'h0; // @[RegFile.scala 51:24]
    end else if (hasExtWriteCommand) begin // @[RegFile.scala 79:29]
      if (4'h0 == regCommand_regID) begin // @[RegFile.scala 80:31]
        regFile_0 <= regCommand_writeData; // @[RegFile.scala 80:31]
      end
    end else begin
      regFile_0 <= 32'hc9d60d0a;
    end
    if (reset) begin // @[RegFile.scala 51:24]
      regFile_1 <= 32'h0; // @[RegFile.scala 51:24]
    end else if (hasExtWriteCommand) begin // @[RegFile.scala 79:29]
      if (4'h1 == regCommand_regID) begin // @[RegFile.scala 80:31]
        regFile_1 <= regCommand_writeData; // @[RegFile.scala 80:31]
      end
    end
    if (reset) begin // @[RegFile.scala 51:24]
      regFile_2 <= 32'h0; // @[RegFile.scala 51:24]
    end else if (hasExtWriteCommand) begin // @[RegFile.scala 79:29]
      if (4'h2 == regCommand_regID) begin // @[RegFile.scala 80:31]
        regFile_2 <= regCommand_writeData; // @[RegFile.scala 80:31]
      end
    end
    if (reset) begin // @[RegFile.scala 51:24]
      regFile_3 <= 32'h0; // @[RegFile.scala 51:24]
    end else if (hasExtWriteCommand) begin // @[RegFile.scala 79:29]
      if (4'h3 == regCommand_regID) begin // @[RegFile.scala 80:31]
        regFile_3 <= regCommand_writeData; // @[RegFile.scala 80:31]
      end
    end
    if (reset) begin // @[RegFile.scala 51:24]
      regFile_4 <= 32'h0; // @[RegFile.scala 51:24]
    end else if (hasExtWriteCommand) begin // @[RegFile.scala 79:29]
      if (4'h4 == regCommand_regID) begin // @[RegFile.scala 80:31]
        regFile_4 <= regCommand_writeData; // @[RegFile.scala 80:31]
      end
    end
    if (reset) begin // @[RegFile.scala 51:24]
      regFile_5 <= 32'h0; // @[RegFile.scala 51:24]
    end else if (hasExtWriteCommand) begin // @[RegFile.scala 79:29]
      if (4'h5 == regCommand_regID) begin // @[RegFile.scala 80:31]
        regFile_5 <= regCommand_writeData; // @[RegFile.scala 80:31]
      end
    end
    if (reset) begin // @[RegFile.scala 51:24]
      regFile_6 <= 32'h0; // @[RegFile.scala 51:24]
    end else if (hasExtWriteCommand) begin // @[RegFile.scala 79:29]
      if (4'h6 == regCommand_regID) begin // @[RegFile.scala 80:31]
        regFile_6 <= regCommand_writeData; // @[RegFile.scala 80:31]
      end
    end
    if (reset) begin // @[RegFile.scala 51:24]
      regFile_7 <= 32'h0; // @[RegFile.scala 51:24]
    end else if (hasExtWriteCommand) begin // @[RegFile.scala 79:29]
      if (4'h7 == regCommand_regID) begin // @[RegFile.scala 80:31]
        regFile_7 <= regCommand_writeData; // @[RegFile.scala 80:31]
      end
    end
    if (reset) begin // @[RegFile.scala 51:24]
      regFile_8 <= 32'h0; // @[RegFile.scala 51:24]
    end else if (hasExtWriteCommand) begin // @[RegFile.scala 79:29]
      if (4'h8 == regCommand_regID) begin // @[RegFile.scala 80:31]
        regFile_8 <= regCommand_writeData; // @[RegFile.scala 80:31]
      end
    end else begin
      regFile_8 <= io_regIn_8_bits;
    end
    if (reset) begin // @[RegFile.scala 51:24]
      regFile_9 <= 32'h0; // @[RegFile.scala 51:24]
    end else if (hasExtWriteCommand) begin // @[RegFile.scala 79:29]
      if (4'h9 == regCommand_regID) begin // @[RegFile.scala 80:31]
        regFile_9 <= regCommand_writeData; // @[RegFile.scala 80:31]
      end
    end else begin
      regFile_9 <= io_regIn_9_bits;
    end
    regCommand_regID <= io_extIF_cmd_bits_regID; // @[RegFile.scala 58:27]
    regCommand_read <= io_extIF_cmd_bits_read; // @[RegFile.scala 58:27]
    regCommand_write <= io_extIF_cmd_bits_write; // @[RegFile.scala 58:27]
    regCommand_writeData <= io_extIF_cmd_bits_writeData; // @[RegFile.scala 58:27]
    if (reset) begin // @[RegFile.scala 59:25]
      regDoCmd <= 1'h0; // @[RegFile.scala 59:25]
    end else begin
      regDoCmd <= io_extIF_cmd_valid; // @[RegFile.scala 59:25]
    end
  end
// Register and memory initialization
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
  regFile_8 = _RAND_8[31:0];
  _RAND_9 = {1{`RANDOM}};
  regFile_9 = _RAND_9[31:0];
  _RAND_10 = {1{`RANDOM}};
  regCommand_regID = _RAND_10[3:0];
  _RAND_11 = {1{`RANDOM}};
  regCommand_read = _RAND_11[0:0];
  _RAND_12 = {1{`RANDOM}};
  regCommand_write = _RAND_12[0:0];
  _RAND_13 = {1{`RANDOM}};
  regCommand_writeData = _RAND_13[31:0];
  _RAND_14 = {1{`RANDOM}};
  regDoCmd = _RAND_14[0:0];
`endif // RANDOMIZE_REG_INIT
  `endif // RANDOMIZE
end // initial
`ifdef FIRRTL_AFTER_INITIAL
`FIRRTL_AFTER_INITIAL
`endif
`endif // SYNTHESIS
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
  wire [7:0] beats = io_genericReqIn_bits_numBytes / 4'h8; // @[AXIMemAdapters.scala 21:31]
  assign io_genericReqIn_ready = io_axiReqOut_ready; // @[AXIMemAdapters.scala 13:25]
  assign io_axiReqOut_valid = io_genericReqIn_valid; // @[AXIMemAdapters.scala 14:22]
  assign io_axiReqOut_bits_addr = io_genericReqIn_bits_addr; // @[AXIMemAdapters.scala 19:15]
  assign io_axiReqOut_bits_len = beats - 8'h1; // @[AXIMemAdapters.scala 22:23]
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
  output        io_in_writeData_ready,
  input         io_in_writeData_valid,
  input  [63:0] io_in_writeData_bits_data,
  input         io_out_writeAddr_ready,
  output        io_out_writeAddr_valid,
  output [31:0] io_out_writeAddr_bits_addr,
  output [7:0]  io_out_writeAddr_bits_len,
  input         io_out_writeData_ready,
  output        io_out_writeData_valid,
  output [63:0] io_out_writeData_bits_data,
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
  wire  _GEN_1 = _T_1 | regState; // @[AXIMemAdapters.scala 165:37 AXIMemAdapters.scala 167:18 AXIMemAdapters.scala 155:25]
  wire  isLastBeat = regBeatsLeft == 8'h0; // @[AXIMemAdapters.scala 172:38]
  wire  _T_3 = io_out_writeData_ready & io_out_writeData_valid; // @[Decoupled.scala 40:37]
  wire [7:0] _regBeatsLeft_T_1 = regBeatsLeft - 8'h1; // @[AXIMemAdapters.scala 180:51]
  wire  _GEN_2 = isLastBeat ? 1'h0 : regState; // @[AXIMemAdapters.scala 179:26 AXIMemAdapters.scala 179:37 AXIMemAdapters.scala 155:25]
  wire [7:0] _GEN_3 = isLastBeat ? regBeatsLeft : _regBeatsLeft_T_1; // @[AXIMemAdapters.scala 179:26 AXIMemAdapters.scala 156:29 AXIMemAdapters.scala 180:35]
  wire  _GEN_6 = regState & io_in_writeData_valid; // @[Conditional.scala 39:67 AXIMemAdapters.scala 174:30 AXIMemAdapters.scala 149:26]
  wire  _GEN_7 = regState & io_out_writeData_ready; // @[Conditional.scala 39:67 AXIMemAdapters.scala 175:29 AXIMemAdapters.scala 150:25]
  wire  _GEN_8 = regState & isLastBeat; // @[Conditional.scala 39:67 AXIMemAdapters.scala 176:34 AXIMemAdapters.scala 152:30]
  assign io_in_writeAddr_ready = _T & io_out_writeAddr_ready; // @[Conditional.scala 40:58 AXIMemAdapters.scala 162:29 AXIMemAdapters.scala 148:25]
  assign io_in_writeData_ready = _T ? 1'h0 : _GEN_7; // @[Conditional.scala 40:58 AXIMemAdapters.scala 150:25]
  assign io_out_writeAddr_valid = _T & io_in_writeAddr_valid; // @[Conditional.scala 40:58 AXIMemAdapters.scala 161:30 AXIMemAdapters.scala 147:26]
  assign io_out_writeAddr_bits_addr = io_in_writeAddr_bits_addr; // @[AXIMemAdapters.scala 144:19]
  assign io_out_writeAddr_bits_len = io_in_writeAddr_bits_len; // @[AXIMemAdapters.scala 144:19]
  assign io_out_writeData_valid = _T ? 1'h0 : _GEN_6; // @[Conditional.scala 40:58 AXIMemAdapters.scala 149:26]
  assign io_out_writeData_bits_data = io_in_writeData_bits_data; // @[AXIMemAdapters.scala 145:19]
  assign io_out_writeData_bits_last = _T ? 1'h0 : _GEN_8; // @[Conditional.scala 40:58 AXIMemAdapters.scala 152:30]
  always @(posedge clock) begin
    if (reset) begin // @[AXIMemAdapters.scala 155:25]
      regState <= 1'h0; // @[AXIMemAdapters.scala 155:25]
    end else if (_T) begin // @[Conditional.scala 40:58]
      regState <= _GEN_1;
    end else if (regState) begin // @[Conditional.scala 39:67]
      if (_T_3) begin // @[AXIMemAdapters.scala 177:37]
        regState <= _GEN_2;
      end
    end
    if (reset) begin // @[AXIMemAdapters.scala 156:29]
      regBeatsLeft <= 8'h0; // @[AXIMemAdapters.scala 156:29]
    end else if (_T) begin // @[Conditional.scala 40:58]
      if (_T_1) begin // @[AXIMemAdapters.scala 165:37]
        regBeatsLeft <= io_in_writeAddr_bits_len; // @[AXIMemAdapters.scala 166:22]
      end
    end else if (regState) begin // @[Conditional.scala 39:67]
      if (_T_3) begin // @[AXIMemAdapters.scala 177:37]
        regBeatsLeft <= _GEN_3;
      end
    end
  end
// Register and memory initialization
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
endmodule
module SRLQueue(
  input         clock,
  input         reset,
  output        io_enq_ready,
  input         io_enq_valid,
  input  [63:0] io_enq_bits_data,
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
  wire [71:0] hi = {io_enq_bits_data,8'hff}; // @[FPGAQueue.scala 74:27]
  wire [72:0] _io_deq_bits_WIRE_1 = Q_srl_o_d;
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
  assign io_enq_ready = ~Q_srl_i_b; // @[FPGAQueue.scala 83:19]
  assign io_deq_valid = Q_srl_o_v; // @[FPGAQueue.scala 78:16]
  assign io_deq_bits_data = _io_deq_bits_WIRE_1[72:9]; // @[FPGAQueue.scala 79:35]
  assign io_deq_bits_strb = _io_deq_bits_WIRE_1[8:1]; // @[FPGAQueue.scala 79:35]
  assign io_deq_bits_last = _io_deq_bits_WIRE_1[0]; // @[FPGAQueue.scala 79:35]
  assign Q_srl_i_v = io_enq_valid; // @[FPGAQueue.scala 73:12]
  assign Q_srl_i_d = {hi,io_enq_bits_last}; // @[FPGAQueue.scala 74:27]
  assign Q_srl_o_b = ~io_deq_ready; // @[FPGAQueue.scala 82:15]
  assign Q_srl_clock = clock; // @[FPGAQueue.scala 75:14]
  assign Q_srl_reset = reset; // @[FPGAQueue.scala 76:14]
endmodule
module FPGAQueue(
  input         clock,
  input         reset,
  output        io_enq_ready,
  input         io_enq_valid,
  input  [63:0] io_enq_bits_data,
  input         io_enq_bits_last,
  input         io_deq_ready,
  output        io_deq_valid,
  output [63:0] io_deq_bits_data,
  output [7:0]  io_deq_bits_strb,
  output        io_deq_bits_last
);
  wire  SRLQueue_clock; // @[FPGAQueue.scala 173:26]
  wire  SRLQueue_reset; // @[FPGAQueue.scala 173:26]
  wire  SRLQueue_io_enq_ready; // @[FPGAQueue.scala 173:26]
  wire  SRLQueue_io_enq_valid; // @[FPGAQueue.scala 173:26]
  wire [63:0] SRLQueue_io_enq_bits_data; // @[FPGAQueue.scala 173:26]
  wire  SRLQueue_io_enq_bits_last; // @[FPGAQueue.scala 173:26]
  wire  SRLQueue_io_deq_ready; // @[FPGAQueue.scala 173:26]
  wire  SRLQueue_io_deq_valid; // @[FPGAQueue.scala 173:26]
  wire [63:0] SRLQueue_io_deq_bits_data; // @[FPGAQueue.scala 173:26]
  wire [7:0] SRLQueue_io_deq_bits_strb; // @[FPGAQueue.scala 173:26]
  wire  SRLQueue_io_deq_bits_last; // @[FPGAQueue.scala 173:26]
  SRLQueue SRLQueue ( // @[FPGAQueue.scala 173:26]
    .clock(SRLQueue_clock),
    .reset(SRLQueue_reset),
    .io_enq_ready(SRLQueue_io_enq_ready),
    .io_enq_valid(SRLQueue_io_enq_valid),
    .io_enq_bits_data(SRLQueue_io_enq_bits_data),
    .io_enq_bits_last(SRLQueue_io_enq_bits_last),
    .io_deq_ready(SRLQueue_io_deq_ready),
    .io_deq_valid(SRLQueue_io_deq_valid),
    .io_deq_bits_data(SRLQueue_io_deq_bits_data),
    .io_deq_bits_strb(SRLQueue_io_deq_bits_strb),
    .io_deq_bits_last(SRLQueue_io_deq_bits_last)
  );
  assign io_enq_ready = SRLQueue_io_enq_ready; // @[FPGAQueue.scala 174:14]
  assign io_deq_valid = SRLQueue_io_deq_valid; // @[FPGAQueue.scala 174:14]
  assign io_deq_bits_data = SRLQueue_io_deq_bits_data; // @[FPGAQueue.scala 174:14]
  assign io_deq_bits_strb = SRLQueue_io_deq_bits_strb; // @[FPGAQueue.scala 174:14]
  assign io_deq_bits_last = SRLQueue_io_deq_bits_last; // @[FPGAQueue.scala 174:14]
  assign SRLQueue_clock = clock;
  assign SRLQueue_reset = reset;
  assign SRLQueue_io_enq_valid = io_enq_valid; // @[FPGAQueue.scala 174:14]
  assign SRLQueue_io_enq_bits_data = io_enq_bits_data; // @[FPGAQueue.scala 174:14]
  assign SRLQueue_io_enq_bits_last = io_enq_bits_last; // @[FPGAQueue.scala 174:14]
  assign SRLQueue_io_deq_ready = io_deq_ready; // @[FPGAQueue.scala 174:14]
endmodule
module AXIWriteRspAdp(
  input   io_axiWriteRspIn_valid,
  output  io_genericRspOut_valid
);
  assign io_genericRspOut_valid = io_axiWriteRspIn_valid; // @[AXIMemAdapters.scala 55:26]
endmodule
module ZedBoardWrapper(
  input         clk,
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
  wire  AuctionBram_clock; // @[PlatformWrapper.scala 69:21]
  wire  AuctionBram_reset; // @[PlatformWrapper.scala 69:21]
  wire  AuctionBram_io_memPort_0_memRdReq_ready; // @[PlatformWrapper.scala 69:21]
  wire  AuctionBram_io_memPort_0_memRdReq_valid; // @[PlatformWrapper.scala 69:21]
  wire [31:0] AuctionBram_io_memPort_0_memRdReq_bits_addr; // @[PlatformWrapper.scala 69:21]
  wire [7:0] AuctionBram_io_memPort_0_memRdReq_bits_numBytes; // @[PlatformWrapper.scala 69:21]
  wire  AuctionBram_io_memPort_0_memRdRsp_ready; // @[PlatformWrapper.scala 69:21]
  wire  AuctionBram_io_memPort_0_memRdRsp_valid; // @[PlatformWrapper.scala 69:21]
  wire [63:0] AuctionBram_io_memPort_0_memRdRsp_bits_readData; // @[PlatformWrapper.scala 69:21]
  wire  AuctionBram_io_memPort_0_memWrReq_ready; // @[PlatformWrapper.scala 69:21]
  wire  AuctionBram_io_memPort_0_memWrReq_valid; // @[PlatformWrapper.scala 69:21]
  wire [31:0] AuctionBram_io_memPort_0_memWrReq_bits_addr; // @[PlatformWrapper.scala 69:21]
  wire  AuctionBram_io_memPort_0_memWrDat_ready; // @[PlatformWrapper.scala 69:21]
  wire  AuctionBram_io_memPort_0_memWrDat_valid; // @[PlatformWrapper.scala 69:21]
  wire [63:0] AuctionBram_io_memPort_0_memWrDat_bits; // @[PlatformWrapper.scala 69:21]
  wire  AuctionBram_io_memPort_0_memWrRsp_valid; // @[PlatformWrapper.scala 69:21]
  wire  AuctionBram_io_rfOut_finished; // @[PlatformWrapper.scala 69:21]
  wire [31:0] AuctionBram_io_rfOut_cycleCount; // @[PlatformWrapper.scala 69:21]
  wire  AuctionBram_io_rfIn_start; // @[PlatformWrapper.scala 69:21]
  wire [63:0] AuctionBram_io_rfIn_baseAddr; // @[PlatformWrapper.scala 69:21]
  wire [31:0] AuctionBram_io_rfIn_nAgents; // @[PlatformWrapper.scala 69:21]
  wire [31:0] AuctionBram_io_rfIn_nObjects; // @[PlatformWrapper.scala 69:21]
  wire [63:0] AuctionBram_io_rfIn_baseAddrRes; // @[PlatformWrapper.scala 69:21]
  wire  RegFile_clock; // @[PlatformWrapper.scala 111:23]
  wire  RegFile_reset; // @[PlatformWrapper.scala 111:23]
  wire  RegFile_io_extIF_cmd_valid; // @[PlatformWrapper.scala 111:23]
  wire [3:0] RegFile_io_extIF_cmd_bits_regID; // @[PlatformWrapper.scala 111:23]
  wire  RegFile_io_extIF_cmd_bits_read; // @[PlatformWrapper.scala 111:23]
  wire  RegFile_io_extIF_cmd_bits_write; // @[PlatformWrapper.scala 111:23]
  wire [31:0] RegFile_io_extIF_cmd_bits_writeData; // @[PlatformWrapper.scala 111:23]
  wire  RegFile_io_extIF_readData_valid; // @[PlatformWrapper.scala 111:23]
  wire [31:0] RegFile_io_extIF_readData_bits; // @[PlatformWrapper.scala 111:23]
  wire [31:0] RegFile_io_regOut_1; // @[PlatformWrapper.scala 111:23]
  wire [31:0] RegFile_io_regOut_2; // @[PlatformWrapper.scala 111:23]
  wire [31:0] RegFile_io_regOut_3; // @[PlatformWrapper.scala 111:23]
  wire [31:0] RegFile_io_regOut_4; // @[PlatformWrapper.scala 111:23]
  wire [31:0] RegFile_io_regOut_5; // @[PlatformWrapper.scala 111:23]
  wire [31:0] RegFile_io_regOut_6; // @[PlatformWrapper.scala 111:23]
  wire [31:0] RegFile_io_regOut_7; // @[PlatformWrapper.scala 111:23]
  wire [31:0] RegFile_io_regIn_8_bits; // @[PlatformWrapper.scala 111:23]
  wire [31:0] RegFile_io_regIn_9_bits; // @[PlatformWrapper.scala 111:23]
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
  wire  AXIWriteBurstReqAdapter_io_in_writeData_ready; // @[AXIPlatformWrapper.scala 49:31]
  wire  AXIWriteBurstReqAdapter_io_in_writeData_valid; // @[AXIPlatformWrapper.scala 49:31]
  wire [63:0] AXIWriteBurstReqAdapter_io_in_writeData_bits_data; // @[AXIPlatformWrapper.scala 49:31]
  wire  AXIWriteBurstReqAdapter_io_out_writeAddr_ready; // @[AXIPlatformWrapper.scala 49:31]
  wire  AXIWriteBurstReqAdapter_io_out_writeAddr_valid; // @[AXIPlatformWrapper.scala 49:31]
  wire [31:0] AXIWriteBurstReqAdapter_io_out_writeAddr_bits_addr; // @[AXIPlatformWrapper.scala 49:31]
  wire [7:0] AXIWriteBurstReqAdapter_io_out_writeAddr_bits_len; // @[AXIPlatformWrapper.scala 49:31]
  wire  AXIWriteBurstReqAdapter_io_out_writeData_ready; // @[AXIPlatformWrapper.scala 49:31]
  wire  AXIWriteBurstReqAdapter_io_out_writeData_valid; // @[AXIPlatformWrapper.scala 49:31]
  wire [63:0] AXIWriteBurstReqAdapter_io_out_writeData_bits_data; // @[AXIPlatformWrapper.scala 49:31]
  wire  AXIWriteBurstReqAdapter_io_out_writeData_bits_last; // @[AXIPlatformWrapper.scala 49:31]
  wire  q_clock; // @[FPGAQueue.scala 185:19]
  wire  q_reset; // @[FPGAQueue.scala 185:19]
  wire  q_io_enq_ready; // @[FPGAQueue.scala 185:19]
  wire  q_io_enq_valid; // @[FPGAQueue.scala 185:19]
  wire [63:0] q_io_enq_bits_data; // @[FPGAQueue.scala 185:19]
  wire  q_io_enq_bits_last; // @[FPGAQueue.scala 185:19]
  wire  q_io_deq_ready; // @[FPGAQueue.scala 185:19]
  wire  q_io_deq_valid; // @[FPGAQueue.scala 185:19]
  wire [63:0] q_io_deq_bits_data; // @[FPGAQueue.scala 185:19]
  wire [7:0] q_io_deq_bits_strb; // @[FPGAQueue.scala 185:19]
  wire  q_io_deq_bits_last; // @[FPGAQueue.scala 185:19]
  wire  AXIWriteRspAdp_io_axiWriteRspIn_valid; // @[AXIPlatformWrapper.scala 65:29]
  wire  AXIWriteRspAdp_io_genericRspOut_valid; // @[AXIPlatformWrapper.scala 65:29]
  reg  regWrapperReset; // @[PlatformWrapper.scala 68:32]
  reg [2:0] regState; // @[AXIPlatformWrapper.scala 94:25]
  reg  regModeWrite; // @[AXIPlatformWrapper.scala 95:29]
  reg  regRdReq; // @[AXIPlatformWrapper.scala 96:25]
  reg [31:0] regRdAddr; // @[AXIPlatformWrapper.scala 97:26]
  reg  regWrReq; // @[AXIPlatformWrapper.scala 98:25]
  reg [31:0] regWrAddr; // @[AXIPlatformWrapper.scala 99:26]
  reg [31:0] regWrData; // @[AXIPlatformWrapper.scala 100:26]
  wire [31:0] _T_5 = regRdAddr / 3'h4; // @[AXIPlatformWrapper.scala 111:47]
  wire [31:0] _T_6 = regWrAddr / 3'h4; // @[AXIPlatformWrapper.scala 115:47]
  wire [31:0] _GEN_3 = ~regModeWrite ? _T_5 : _T_6; // @[AXIPlatformWrapper.scala 108:23 AXIPlatformWrapper.scala 111:34 AXIPlatformWrapper.scala 115:34]
  wire  csr_1_readAddr_ready = 3'h0 == regState; // @[Conditional.scala 37:30]
  wire  _GEN_6 = csr_ARVALID | regRdReq; // @[AXIPlatformWrapper.scala 123:32 AXIPlatformWrapper.scala 124:18 AXIPlatformWrapper.scala 96:25]
  wire  _T_8 = 3'h1 == regState; // @[Conditional.scala 37:30]
  wire  _T_10 = 3'h2 == regState; // @[Conditional.scala 37:30]
  wire  _GEN_12 = csr_AWVALID | regModeWrite; // @[AXIPlatformWrapper.scala 145:33 AXIPlatformWrapper.scala 146:22 AXIPlatformWrapper.scala 95:29]
  wire  _GEN_13 = csr_AWVALID ? 1'h0 : regWrReq; // @[AXIPlatformWrapper.scala 145:33 AXIPlatformWrapper.scala 147:18 AXIPlatformWrapper.scala 98:25]
  wire [31:0] _GEN_14 = csr_AWVALID ? csr_AWADDR : regWrAddr; // @[AXIPlatformWrapper.scala 145:33 AXIPlatformWrapper.scala 148:19 AXIPlatformWrapper.scala 99:26]
  wire [2:0] _GEN_15 = csr_AWVALID ? 3'h3 : 3'h0; // @[AXIPlatformWrapper.scala 145:33 AXIPlatformWrapper.scala 149:18 AXIPlatformWrapper.scala 151:18]
  wire  _T_11 = 3'h3 == regState; // @[Conditional.scala 37:30]
  wire [31:0] _GEN_16 = csr_WVALID ? csr_WDATA : regWrData; // @[AXIPlatformWrapper.scala 157:33 AXIPlatformWrapper.scala 158:19 AXIPlatformWrapper.scala 100:26]
  wire  _GEN_17 = csr_WVALID | regWrReq; // @[AXIPlatformWrapper.scala 157:33 AXIPlatformWrapper.scala 159:18 AXIPlatformWrapper.scala 98:25]
  wire [2:0] _GEN_18 = csr_WVALID ? 3'h4 : regState; // @[AXIPlatformWrapper.scala 157:33 AXIPlatformWrapper.scala 160:18 AXIPlatformWrapper.scala 94:25]
  wire  _T_12 = 3'h4 == regState; // @[Conditional.scala 37:30]
  wire  _GEN_19 = csr_BREADY ? 1'h0 : regWrReq; // @[AXIPlatformWrapper.scala 166:33 AXIPlatformWrapper.scala 167:18 AXIPlatformWrapper.scala 98:25]
  wire [2:0] _GEN_20 = csr_BREADY ? 3'h0 : regState; // @[AXIPlatformWrapper.scala 166:33 AXIPlatformWrapper.scala 168:18 AXIPlatformWrapper.scala 94:25]
  wire  _GEN_22 = _T_12 ? _GEN_19 : regWrReq; // @[Conditional.scala 39:67 AXIPlatformWrapper.scala 98:25]
  wire [2:0] _GEN_23 = _T_12 ? _GEN_20 : regState; // @[Conditional.scala 39:67 AXIPlatformWrapper.scala 94:25]
  wire [31:0] _GEN_25 = _T_11 ? _GEN_16 : regWrData; // @[Conditional.scala 39:67 AXIPlatformWrapper.scala 100:26]
  wire  _GEN_26 = _T_11 ? _GEN_17 : _GEN_22; // @[Conditional.scala 39:67]
  wire [2:0] _GEN_27 = _T_11 ? _GEN_18 : _GEN_23; // @[Conditional.scala 39:67]
  wire  _GEN_28 = _T_11 ? 1'h0 : _T_12; // @[Conditional.scala 39:67 AXIPlatformWrapper.scala 83:23]
  wire  _GEN_34 = _T_10 ? 1'h0 : _T_11; // @[Conditional.scala 39:67 AXIPlatformWrapper.scala 82:23]
  wire  _GEN_36 = _T_10 ? 1'h0 : _GEN_28; // @[Conditional.scala 39:67 AXIPlatformWrapper.scala 83:23]
  wire  _GEN_37 = _T_8 & RegFile_io_extIF_readData_valid; // @[Conditional.scala 39:67 AXIPlatformWrapper.scala 135:26 AXIPlatformWrapper.scala 86:22]
  wire  _GEN_40 = _T_8 ? 1'h0 : _T_10; // @[Conditional.scala 39:67 AXIPlatformWrapper.scala 81:23]
  wire  _GEN_44 = _T_8 ? 1'h0 : _GEN_34; // @[Conditional.scala 39:67 AXIPlatformWrapper.scala 82:23]
  wire  _GEN_46 = _T_8 ? 1'h0 : _GEN_36; // @[Conditional.scala 39:67 AXIPlatformWrapper.scala 83:23]
  AuctionBram AuctionBram ( // @[PlatformWrapper.scala 69:21]
    .clock(AuctionBram_clock),
    .reset(AuctionBram_reset),
    .io_memPort_0_memRdReq_ready(AuctionBram_io_memPort_0_memRdReq_ready),
    .io_memPort_0_memRdReq_valid(AuctionBram_io_memPort_0_memRdReq_valid),
    .io_memPort_0_memRdReq_bits_addr(AuctionBram_io_memPort_0_memRdReq_bits_addr),
    .io_memPort_0_memRdReq_bits_numBytes(AuctionBram_io_memPort_0_memRdReq_bits_numBytes),
    .io_memPort_0_memRdRsp_ready(AuctionBram_io_memPort_0_memRdRsp_ready),
    .io_memPort_0_memRdRsp_valid(AuctionBram_io_memPort_0_memRdRsp_valid),
    .io_memPort_0_memRdRsp_bits_readData(AuctionBram_io_memPort_0_memRdRsp_bits_readData),
    .io_memPort_0_memWrReq_ready(AuctionBram_io_memPort_0_memWrReq_ready),
    .io_memPort_0_memWrReq_valid(AuctionBram_io_memPort_0_memWrReq_valid),
    .io_memPort_0_memWrReq_bits_addr(AuctionBram_io_memPort_0_memWrReq_bits_addr),
    .io_memPort_0_memWrDat_ready(AuctionBram_io_memPort_0_memWrDat_ready),
    .io_memPort_0_memWrDat_valid(AuctionBram_io_memPort_0_memWrDat_valid),
    .io_memPort_0_memWrDat_bits(AuctionBram_io_memPort_0_memWrDat_bits),
    .io_memPort_0_memWrRsp_valid(AuctionBram_io_memPort_0_memWrRsp_valid),
    .io_rfOut_finished(AuctionBram_io_rfOut_finished),
    .io_rfOut_cycleCount(AuctionBram_io_rfOut_cycleCount),
    .io_rfIn_start(AuctionBram_io_rfIn_start),
    .io_rfIn_baseAddr(AuctionBram_io_rfIn_baseAddr),
    .io_rfIn_nAgents(AuctionBram_io_rfIn_nAgents),
    .io_rfIn_nObjects(AuctionBram_io_rfIn_nObjects),
    .io_rfIn_baseAddrRes(AuctionBram_io_rfIn_baseAddrRes)
  );
  RegFile RegFile ( // @[PlatformWrapper.scala 111:23]
    .clock(RegFile_clock),
    .reset(RegFile_reset),
    .io_extIF_cmd_valid(RegFile_io_extIF_cmd_valid),
    .io_extIF_cmd_bits_regID(RegFile_io_extIF_cmd_bits_regID),
    .io_extIF_cmd_bits_read(RegFile_io_extIF_cmd_bits_read),
    .io_extIF_cmd_bits_write(RegFile_io_extIF_cmd_bits_write),
    .io_extIF_cmd_bits_writeData(RegFile_io_extIF_cmd_bits_writeData),
    .io_extIF_readData_valid(RegFile_io_extIF_readData_valid),
    .io_extIF_readData_bits(RegFile_io_extIF_readData_bits),
    .io_regOut_1(RegFile_io_regOut_1),
    .io_regOut_2(RegFile_io_regOut_2),
    .io_regOut_3(RegFile_io_regOut_3),
    .io_regOut_4(RegFile_io_regOut_4),
    .io_regOut_5(RegFile_io_regOut_5),
    .io_regOut_6(RegFile_io_regOut_6),
    .io_regOut_7(RegFile_io_regOut_7),
    .io_regIn_8_bits(RegFile_io_regIn_8_bits),
    .io_regIn_9_bits(RegFile_io_regIn_9_bits)
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
    .io_in_writeData_ready(AXIWriteBurstReqAdapter_io_in_writeData_ready),
    .io_in_writeData_valid(AXIWriteBurstReqAdapter_io_in_writeData_valid),
    .io_in_writeData_bits_data(AXIWriteBurstReqAdapter_io_in_writeData_bits_data),
    .io_out_writeAddr_ready(AXIWriteBurstReqAdapter_io_out_writeAddr_ready),
    .io_out_writeAddr_valid(AXIWriteBurstReqAdapter_io_out_writeAddr_valid),
    .io_out_writeAddr_bits_addr(AXIWriteBurstReqAdapter_io_out_writeAddr_bits_addr),
    .io_out_writeAddr_bits_len(AXIWriteBurstReqAdapter_io_out_writeAddr_bits_len),
    .io_out_writeData_ready(AXIWriteBurstReqAdapter_io_out_writeData_ready),
    .io_out_writeData_valid(AXIWriteBurstReqAdapter_io_out_writeData_valid),
    .io_out_writeData_bits_data(AXIWriteBurstReqAdapter_io_out_writeData_bits_data),
    .io_out_writeData_bits_last(AXIWriteBurstReqAdapter_io_out_writeData_bits_last)
  );
  FPGAQueue q ( // @[FPGAQueue.scala 185:19]
    .clock(q_clock),
    .reset(q_reset),
    .io_enq_ready(q_io_enq_ready),
    .io_enq_valid(q_io_enq_valid),
    .io_enq_bits_data(q_io_enq_bits_data),
    .io_enq_bits_last(q_io_enq_bits_last),
    .io_deq_ready(q_io_deq_ready),
    .io_deq_valid(q_io_deq_valid),
    .io_deq_bits_data(q_io_deq_bits_data),
    .io_deq_bits_strb(q_io_deq_bits_strb),
    .io_deq_bits_last(q_io_deq_bits_last)
  );
  AXIWriteRspAdp AXIWriteRspAdp ( // @[AXIPlatformWrapper.scala 65:29]
    .io_axiWriteRspIn_valid(AXIWriteRspAdp_io_axiWriteRspIn_valid),
    .io_genericRspOut_valid(AXIWriteRspAdp_io_genericRspOut_valid)
  );
  assign mem0_ARADDR = AXIMemReqAdp_io_axiReqOut_bits_addr; // @[AXIPlatformWrapper.scala 18:17 AXIPlatformWrapper.scala 40:26]
  assign mem0_ARSIZE = 3'h3; // @[AXIPlatformWrapper.scala 18:17 AXIPlatformWrapper.scala 40:26]
  assign mem0_ARLEN = AXIMemReqAdp_io_axiReqOut_bits_len; // @[AXIPlatformWrapper.scala 18:17 AXIPlatformWrapper.scala 40:26]
  assign mem0_ARBURST = 2'h1; // @[AXIPlatformWrapper.scala 18:17 AXIPlatformWrapper.scala 40:26]
  assign mem0_ARID = 6'h0; // @[AXIPlatformWrapper.scala 18:17 AXIPlatformWrapper.scala 40:26]
  assign mem0_ARLOCK = 1'h0; // @[AXIPlatformWrapper.scala 18:17 AXIPlatformWrapper.scala 40:26]
  assign mem0_ARCACHE = 4'h2; // @[AXIPlatformWrapper.scala 18:17 AXIPlatformWrapper.scala 40:26]
  assign mem0_ARPROT = 3'h0; // @[AXIPlatformWrapper.scala 18:17 AXIPlatformWrapper.scala 40:26]
  assign mem0_ARQOS = 4'h0; // @[AXIPlatformWrapper.scala 18:17 AXIPlatformWrapper.scala 40:26]
  assign mem0_ARVALID = AXIMemReqAdp_io_axiReqOut_valid; // @[AXIPlatformWrapper.scala 18:17 AXIPlatformWrapper.scala 40:26]
  assign mem0_AWADDR = AXIWriteBurstReqAdapter_io_out_writeAddr_bits_addr; // @[AXIPlatformWrapper.scala 18:17 AXIPlatformWrapper.scala 60:33]
  assign mem0_AWSIZE = 3'h3; // @[AXIPlatformWrapper.scala 18:17 AXIPlatformWrapper.scala 60:33]
  assign mem0_AWLEN = AXIWriteBurstReqAdapter_io_out_writeAddr_bits_len; // @[AXIPlatformWrapper.scala 18:17 AXIPlatformWrapper.scala 60:33]
  assign mem0_AWBURST = 2'h1; // @[AXIPlatformWrapper.scala 18:17 AXIPlatformWrapper.scala 60:33]
  assign mem0_AWID = 6'h0; // @[AXIPlatformWrapper.scala 18:17 AXIPlatformWrapper.scala 60:33]
  assign mem0_AWLOCK = 1'h0; // @[AXIPlatformWrapper.scala 18:17 AXIPlatformWrapper.scala 60:33]
  assign mem0_AWCACHE = 4'h2; // @[AXIPlatformWrapper.scala 18:17 AXIPlatformWrapper.scala 60:33]
  assign mem0_AWPROT = 3'h0; // @[AXIPlatformWrapper.scala 18:17 AXIPlatformWrapper.scala 60:33]
  assign mem0_AWQOS = 4'h0; // @[AXIPlatformWrapper.scala 18:17 AXIPlatformWrapper.scala 60:33]
  assign mem0_AWVALID = AXIWriteBurstReqAdapter_io_out_writeAddr_valid; // @[AXIPlatformWrapper.scala 18:17 AXIPlatformWrapper.scala 60:33]
  assign mem0_WDATA = q_io_deq_bits_data; // @[AXIPlatformWrapper.scala 18:17 AXIPlatformWrapper.scala 63:47]
  assign mem0_WSTRB = q_io_deq_bits_strb; // @[AXIPlatformWrapper.scala 18:17 AXIPlatformWrapper.scala 63:47]
  assign mem0_WLAST = q_io_deq_bits_last; // @[AXIPlatformWrapper.scala 18:17 AXIPlatformWrapper.scala 63:47]
  assign mem0_WVALID = q_io_deq_valid; // @[AXIPlatformWrapper.scala 18:17 AXIPlatformWrapper.scala 63:47]
  assign mem0_BREADY = 1'h1; // @[AXIPlatformWrapper.scala 18:17 AXIPlatformWrapper.scala 66:31]
  assign mem0_RREADY = AXIReadRspAdp_io_axiReadRspIn_ready; // @[AXIPlatformWrapper.scala 18:17 AXIPlatformWrapper.scala 43:29]
  assign mem1_ARADDR = 32'h0; // @[AXIPlatformWrapper.scala 18:17 AXIDefs.scala 255:24]
  assign mem1_ARSIZE = 3'h0; // @[AXIPlatformWrapper.scala 18:17 AXIDefs.scala 257:24]
  assign mem1_ARLEN = 8'h0; // @[AXIPlatformWrapper.scala 18:17 AXIDefs.scala 258:23]
  assign mem1_ARBURST = 2'h0; // @[AXIPlatformWrapper.scala 18:17 AXIDefs.scala 259:25]
  assign mem1_ARID = 6'h0; // @[AXIPlatformWrapper.scala 18:17 AXIDefs.scala 263:22]
  assign mem1_ARLOCK = 1'h0; // @[AXIPlatformWrapper.scala 18:17 AXIDefs.scala 260:24]
  assign mem1_ARCACHE = 4'h0; // @[AXIPlatformWrapper.scala 18:17 AXIDefs.scala 261:25]
  assign mem1_ARPROT = 3'h0; // @[AXIPlatformWrapper.scala 18:17 AXIDefs.scala 256:24]
  assign mem1_ARQOS = 4'h0; // @[AXIPlatformWrapper.scala 18:17 AXIDefs.scala 262:23]
  assign mem1_ARVALID = 1'h0; // @[AXIPlatformWrapper.scala 18:17 AXIDefs.scala 238:20]
  assign mem1_AWADDR = 32'h0; // @[AXIPlatformWrapper.scala 18:17 AXIDefs.scala 241:25]
  assign mem1_AWSIZE = 3'h0; // @[AXIPlatformWrapper.scala 18:17 AXIDefs.scala 243:25]
  assign mem1_AWLEN = 8'h0; // @[AXIPlatformWrapper.scala 18:17 AXIDefs.scala 244:24]
  assign mem1_AWBURST = 2'h0; // @[AXIPlatformWrapper.scala 18:17 AXIDefs.scala 245:26]
  assign mem1_AWID = 6'h0; // @[AXIPlatformWrapper.scala 18:17 AXIDefs.scala 249:23]
  assign mem1_AWLOCK = 1'h0; // @[AXIPlatformWrapper.scala 18:17 AXIDefs.scala 246:25]
  assign mem1_AWCACHE = 4'h0; // @[AXIPlatformWrapper.scala 18:17 AXIDefs.scala 247:26]
  assign mem1_AWPROT = 3'h0; // @[AXIPlatformWrapper.scala 18:17 AXIDefs.scala 242:25]
  assign mem1_AWQOS = 4'h0; // @[AXIPlatformWrapper.scala 18:17 AXIDefs.scala 248:24]
  assign mem1_AWVALID = 1'h0; // @[AXIPlatformWrapper.scala 18:17 AXIDefs.scala 235:21]
  assign mem1_WDATA = 64'h0; // @[AXIPlatformWrapper.scala 18:17 AXIDefs.scala 251:25]
  assign mem1_WSTRB = 8'h0; // @[AXIPlatformWrapper.scala 18:17 AXIDefs.scala 252:25]
  assign mem1_WLAST = 1'h0; // @[AXIPlatformWrapper.scala 18:17 AXIDefs.scala 253:25]
  assign mem1_WVALID = 1'h0; // @[AXIPlatformWrapper.scala 18:17 AXIDefs.scala 236:21]
  assign mem1_BREADY = 1'h0; // @[AXIPlatformWrapper.scala 18:17 AXIDefs.scala 237:21]
  assign mem1_RREADY = 1'h0; // @[AXIPlatformWrapper.scala 18:17 AXIDefs.scala 239:20]
  assign mem2_ARADDR = 32'h0; // @[AXIPlatformWrapper.scala 18:17 AXIDefs.scala 255:24]
  assign mem2_ARSIZE = 3'h0; // @[AXIPlatformWrapper.scala 18:17 AXIDefs.scala 257:24]
  assign mem2_ARLEN = 8'h0; // @[AXIPlatformWrapper.scala 18:17 AXIDefs.scala 258:23]
  assign mem2_ARBURST = 2'h0; // @[AXIPlatformWrapper.scala 18:17 AXIDefs.scala 259:25]
  assign mem2_ARID = 6'h0; // @[AXIPlatformWrapper.scala 18:17 AXIDefs.scala 263:22]
  assign mem2_ARLOCK = 1'h0; // @[AXIPlatformWrapper.scala 18:17 AXIDefs.scala 260:24]
  assign mem2_ARCACHE = 4'h0; // @[AXIPlatformWrapper.scala 18:17 AXIDefs.scala 261:25]
  assign mem2_ARPROT = 3'h0; // @[AXIPlatformWrapper.scala 18:17 AXIDefs.scala 256:24]
  assign mem2_ARQOS = 4'h0; // @[AXIPlatformWrapper.scala 18:17 AXIDefs.scala 262:23]
  assign mem2_ARVALID = 1'h0; // @[AXIPlatformWrapper.scala 18:17 AXIDefs.scala 238:20]
  assign mem2_AWADDR = 32'h0; // @[AXIPlatformWrapper.scala 18:17 AXIDefs.scala 241:25]
  assign mem2_AWSIZE = 3'h0; // @[AXIPlatformWrapper.scala 18:17 AXIDefs.scala 243:25]
  assign mem2_AWLEN = 8'h0; // @[AXIPlatformWrapper.scala 18:17 AXIDefs.scala 244:24]
  assign mem2_AWBURST = 2'h0; // @[AXIPlatformWrapper.scala 18:17 AXIDefs.scala 245:26]
  assign mem2_AWID = 6'h0; // @[AXIPlatformWrapper.scala 18:17 AXIDefs.scala 249:23]
  assign mem2_AWLOCK = 1'h0; // @[AXIPlatformWrapper.scala 18:17 AXIDefs.scala 246:25]
  assign mem2_AWCACHE = 4'h0; // @[AXIPlatformWrapper.scala 18:17 AXIDefs.scala 247:26]
  assign mem2_AWPROT = 3'h0; // @[AXIPlatformWrapper.scala 18:17 AXIDefs.scala 242:25]
  assign mem2_AWQOS = 4'h0; // @[AXIPlatformWrapper.scala 18:17 AXIDefs.scala 248:24]
  assign mem2_AWVALID = 1'h0; // @[AXIPlatformWrapper.scala 18:17 AXIDefs.scala 235:21]
  assign mem2_WDATA = 64'h0; // @[AXIPlatformWrapper.scala 18:17 AXIDefs.scala 251:25]
  assign mem2_WSTRB = 8'h0; // @[AXIPlatformWrapper.scala 18:17 AXIDefs.scala 252:25]
  assign mem2_WLAST = 1'h0; // @[AXIPlatformWrapper.scala 18:17 AXIDefs.scala 253:25]
  assign mem2_WVALID = 1'h0; // @[AXIPlatformWrapper.scala 18:17 AXIDefs.scala 236:21]
  assign mem2_BREADY = 1'h0; // @[AXIPlatformWrapper.scala 18:17 AXIDefs.scala 237:21]
  assign mem2_RREADY = 1'h0; // @[AXIPlatformWrapper.scala 18:17 AXIDefs.scala 239:20]
  assign mem3_ARADDR = 32'h0; // @[AXIPlatformWrapper.scala 18:17 AXIDefs.scala 255:24]
  assign mem3_ARSIZE = 3'h0; // @[AXIPlatformWrapper.scala 18:17 AXIDefs.scala 257:24]
  assign mem3_ARLEN = 8'h0; // @[AXIPlatformWrapper.scala 18:17 AXIDefs.scala 258:23]
  assign mem3_ARBURST = 2'h0; // @[AXIPlatformWrapper.scala 18:17 AXIDefs.scala 259:25]
  assign mem3_ARID = 6'h0; // @[AXIPlatformWrapper.scala 18:17 AXIDefs.scala 263:22]
  assign mem3_ARLOCK = 1'h0; // @[AXIPlatformWrapper.scala 18:17 AXIDefs.scala 260:24]
  assign mem3_ARCACHE = 4'h0; // @[AXIPlatformWrapper.scala 18:17 AXIDefs.scala 261:25]
  assign mem3_ARPROT = 3'h0; // @[AXIPlatformWrapper.scala 18:17 AXIDefs.scala 256:24]
  assign mem3_ARQOS = 4'h0; // @[AXIPlatformWrapper.scala 18:17 AXIDefs.scala 262:23]
  assign mem3_ARVALID = 1'h0; // @[AXIPlatformWrapper.scala 18:17 AXIDefs.scala 238:20]
  assign mem3_AWADDR = 32'h0; // @[AXIPlatformWrapper.scala 18:17 AXIDefs.scala 241:25]
  assign mem3_AWSIZE = 3'h0; // @[AXIPlatformWrapper.scala 18:17 AXIDefs.scala 243:25]
  assign mem3_AWLEN = 8'h0; // @[AXIPlatformWrapper.scala 18:17 AXIDefs.scala 244:24]
  assign mem3_AWBURST = 2'h0; // @[AXIPlatformWrapper.scala 18:17 AXIDefs.scala 245:26]
  assign mem3_AWID = 6'h0; // @[AXIPlatformWrapper.scala 18:17 AXIDefs.scala 249:23]
  assign mem3_AWLOCK = 1'h0; // @[AXIPlatformWrapper.scala 18:17 AXIDefs.scala 246:25]
  assign mem3_AWCACHE = 4'h0; // @[AXIPlatformWrapper.scala 18:17 AXIDefs.scala 247:26]
  assign mem3_AWPROT = 3'h0; // @[AXIPlatformWrapper.scala 18:17 AXIDefs.scala 242:25]
  assign mem3_AWQOS = 4'h0; // @[AXIPlatformWrapper.scala 18:17 AXIDefs.scala 248:24]
  assign mem3_AWVALID = 1'h0; // @[AXIPlatformWrapper.scala 18:17 AXIDefs.scala 235:21]
  assign mem3_WDATA = 64'h0; // @[AXIPlatformWrapper.scala 18:17 AXIDefs.scala 251:25]
  assign mem3_WSTRB = 8'h0; // @[AXIPlatformWrapper.scala 18:17 AXIDefs.scala 252:25]
  assign mem3_WLAST = 1'h0; // @[AXIPlatformWrapper.scala 18:17 AXIDefs.scala 253:25]
  assign mem3_WVALID = 1'h0; // @[AXIPlatformWrapper.scala 18:17 AXIDefs.scala 236:21]
  assign mem3_BREADY = 1'h0; // @[AXIPlatformWrapper.scala 18:17 AXIDefs.scala 237:21]
  assign mem3_RREADY = 1'h0; // @[AXIPlatformWrapper.scala 18:17 AXIDefs.scala 239:20]
  assign csr_ARREADY = 3'h0 == regState; // @[Conditional.scala 37:30]
  assign csr_AWREADY = csr_1_readAddr_ready ? 1'h0 : _GEN_40; // @[Conditional.scala 40:58 AXIPlatformWrapper.scala 81:23]
  assign csr_WREADY = csr_1_readAddr_ready ? 1'h0 : _GEN_44; // @[Conditional.scala 40:58 AXIPlatformWrapper.scala 82:23]
  assign csr_BRESP = 2'h0; // @[AXIPlatformWrapper.scala 17:17 AXIPlatformWrapper.scala 84:22]
  assign csr_BVALID = csr_1_readAddr_ready ? 1'h0 : _GEN_46; // @[Conditional.scala 40:58 AXIPlatformWrapper.scala 83:23]
  assign csr_RDATA = RegFile_io_extIF_readData_bits; // @[AXIPlatformWrapper.scala 17:17 AXIPlatformWrapper.scala 87:26]
  assign csr_RRESP = 2'h0; // @[AXIPlatformWrapper.scala 17:17 AXIPlatformWrapper.scala 88:26]
  assign csr_RVALID = csr_1_readAddr_ready ? 1'h0 : _GEN_37; // @[Conditional.scala 40:58 AXIPlatformWrapper.scala 86:22]
  assign AuctionBram_clock = clk;
  assign AuctionBram_reset = reset | regWrapperReset; // @[PlatformWrapper.scala 72:31]
  assign AuctionBram_io_memPort_0_memRdReq_ready = AXIMemReqAdp_io_genericReqIn_ready; // @[AXIPlatformWrapper.scala 39:29]
  assign AuctionBram_io_memPort_0_memRdRsp_valid = AXIReadRspAdp_io_genericRspOut_valid; // @[AXIPlatformWrapper.scala 44:30]
  assign AuctionBram_io_memPort_0_memRdRsp_bits_readData = AXIReadRspAdp_io_genericRspOut_bits_readData; // @[AXIPlatformWrapper.scala 44:30]
  assign AuctionBram_io_memPort_0_memWrReq_ready = AXIMemReqAdp_1_io_genericReqIn_ready; // @[AXIPlatformWrapper.scala 47:30]
  assign AuctionBram_io_memPort_0_memWrDat_ready = AXIWriteBurstReqAdapter_io_in_writeData_ready; // @[AXIPlatformWrapper.scala 59:40]
  assign AuctionBram_io_memPort_0_memWrRsp_valid = AXIWriteRspAdp_io_genericRspOut_valid; // @[AXIPlatformWrapper.scala 67:31]
  assign AuctionBram_io_rfIn_start = RegFile_io_regOut_7[0]; // @[PlatformWrapper.scala 168:45]
  assign AuctionBram_io_rfIn_baseAddr = {RegFile_io_regOut_5,RegFile_io_regOut_6}; // @[Cat.scala 30:58]
  assign AuctionBram_io_rfIn_nAgents = RegFile_io_regOut_4; // @[PlatformWrapper.scala 170:25]
  assign AuctionBram_io_rfIn_nObjects = RegFile_io_regOut_3; // @[PlatformWrapper.scala 170:25]
  assign AuctionBram_io_rfIn_baseAddrRes = {RegFile_io_regOut_1,RegFile_io_regOut_2}; // @[Cat.scala 30:58]
  assign RegFile_clock = clk;
  assign RegFile_reset = reset;
  assign RegFile_io_extIF_cmd_valid = ~regModeWrite ? regRdReq : regWrReq; // @[AXIPlatformWrapper.scala 108:23 AXIPlatformWrapper.scala 109:29 AXIPlatformWrapper.scala 113:29]
  assign RegFile_io_extIF_cmd_bits_regID = _GEN_3[3:0];
  assign RegFile_io_extIF_cmd_bits_read = ~regModeWrite; // @[AXIPlatformWrapper.scala 108:8]
  assign RegFile_io_extIF_cmd_bits_write = ~regModeWrite ? 1'h0 : 1'h1; // @[AXIPlatformWrapper.scala 108:23 RegFile.scala 18:11 AXIPlatformWrapper.scala 114:34]
  assign RegFile_io_extIF_cmd_bits_writeData = ~regModeWrite ? 32'h0 : regWrData; // @[AXIPlatformWrapper.scala 108:23 RegFile.scala 19:15 AXIPlatformWrapper.scala 116:38]
  assign RegFile_io_regIn_8_bits = AuctionBram_io_rfOut_cycleCount; // @[PlatformWrapper.scala 179:40]
  assign RegFile_io_regIn_9_bits = {{31'd0}, AuctionBram_io_rfOut_finished}; // @[PlatformWrapper.scala 179:40]
  assign AXIMemReqAdp_io_genericReqIn_valid = AuctionBram_io_memPort_0_memRdReq_valid; // @[AXIPlatformWrapper.scala 39:29]
  assign AXIMemReqAdp_io_genericReqIn_bits_addr = AuctionBram_io_memPort_0_memRdReq_bits_addr; // @[AXIPlatformWrapper.scala 39:29]
  assign AXIMemReqAdp_io_genericReqIn_bits_numBytes = AuctionBram_io_memPort_0_memRdReq_bits_numBytes; // @[AXIPlatformWrapper.scala 39:29]
  assign AXIMemReqAdp_io_axiReqOut_ready = mem0_ARREADY; // @[AXIPlatformWrapper.scala 21:35 AXIPlatformWrapper.scala 21:35]
  assign AXIReadRspAdp_io_axiReadRspIn_valid = mem0_RVALID; // @[AXIPlatformWrapper.scala 21:35 AXIPlatformWrapper.scala 21:35]
  assign AXIReadRspAdp_io_axiReadRspIn_bits_data = mem0_RDATA; // @[AXIPlatformWrapper.scala 21:35 AXIPlatformWrapper.scala 21:35]
  assign AXIReadRspAdp_io_genericRspOut_ready = AuctionBram_io_memPort_0_memRdRsp_ready; // @[AXIPlatformWrapper.scala 44:30]
  assign AXIMemReqAdp_1_io_genericReqIn_valid = AuctionBram_io_memPort_0_memWrReq_valid; // @[AXIPlatformWrapper.scala 47:30]
  assign AXIMemReqAdp_1_io_genericReqIn_bits_addr = AuctionBram_io_memPort_0_memWrReq_bits_addr; // @[AXIPlatformWrapper.scala 47:30]
  assign AXIMemReqAdp_1_io_genericReqIn_bits_numBytes = 8'h8; // @[AXIPlatformWrapper.scala 47:30]
  assign AXIMemReqAdp_1_io_axiReqOut_ready = AXIWriteBurstReqAdapter_io_in_writeAddr_ready; // @[AXIPlatformWrapper.scala 52:27]
  assign AXIWriteBurstReqAdapter_clock = clk;
  assign AXIWriteBurstReqAdapter_reset = reset;
  assign AXIWriteBurstReqAdapter_io_in_writeAddr_valid = AXIMemReqAdp_1_io_axiReqOut_valid; // @[AXIPlatformWrapper.scala 52:27]
  assign AXIWriteBurstReqAdapter_io_in_writeAddr_bits_addr = AXIMemReqAdp_1_io_axiReqOut_bits_addr; // @[AXIPlatformWrapper.scala 52:27]
  assign AXIWriteBurstReqAdapter_io_in_writeAddr_bits_len = AXIMemReqAdp_1_io_axiReqOut_bits_len; // @[AXIPlatformWrapper.scala 52:27]
  assign AXIWriteBurstReqAdapter_io_in_writeData_valid = AuctionBram_io_memPort_0_memWrDat_valid; // @[AXIPlatformWrapper.scala 58:38]
  assign AXIWriteBurstReqAdapter_io_in_writeData_bits_data = AuctionBram_io_memPort_0_memWrDat_bits; // @[AXIPlatformWrapper.scala 53:42]
  assign AXIWriteBurstReqAdapter_io_out_writeAddr_ready = mem0_AWREADY; // @[AXIPlatformWrapper.scala 21:35 AXIPlatformWrapper.scala 21:35]
  assign AXIWriteBurstReqAdapter_io_out_writeData_ready = q_io_enq_ready; // @[FPGAQueue.scala 188:15]
  assign q_clock = clk;
  assign q_reset = reset;
  assign q_io_enq_valid = AXIWriteBurstReqAdapter_io_out_writeData_valid; // @[FPGAQueue.scala 186:20]
  assign q_io_enq_bits_data = AXIWriteBurstReqAdapter_io_out_writeData_bits_data; // @[FPGAQueue.scala 187:19]
  assign q_io_enq_bits_last = AXIWriteBurstReqAdapter_io_out_writeData_bits_last; // @[FPGAQueue.scala 187:19]
  assign q_io_deq_ready = mem0_WREADY; // @[AXIPlatformWrapper.scala 21:35 AXIPlatformWrapper.scala 21:35]
  assign AXIWriteRspAdp_io_axiWriteRspIn_valid = mem0_BVALID; // @[AXIPlatformWrapper.scala 21:35 AXIPlatformWrapper.scala 21:35]
  always @(posedge clk) begin
    if (reset) begin // @[PlatformWrapper.scala 68:32]
      regWrapperReset <= 1'h0; // @[PlatformWrapper.scala 68:32]
    end else if (RegFile_io_extIF_cmd_valid & RegFile_io_extIF_cmd_bits_write & RegFile_io_extIF_cmd_bits_regID == 4'h0
      ) begin // @[PlatformWrapper.scala 115:67]
      regWrapperReset <= RegFile_io_extIF_cmd_bits_writeData[0]; // @[PlatformWrapper.scala 116:21]
    end
    if (reset) begin // @[AXIPlatformWrapper.scala 94:25]
      regState <= 3'h0; // @[AXIPlatformWrapper.scala 94:25]
    end else if (csr_1_readAddr_ready) begin // @[Conditional.scala 40:58]
      if (csr_ARVALID) begin // @[AXIPlatformWrapper.scala 123:32]
        regState <= 3'h1; // @[AXIPlatformWrapper.scala 127:18]
      end else begin
        regState <= 3'h2; // @[AXIPlatformWrapper.scala 129:18]
      end
    end else if (_T_8) begin // @[Conditional.scala 39:67]
      if (csr_RREADY & RegFile_io_extIF_readData_valid) begin // @[AXIPlatformWrapper.scala 136:64]
        regState <= 3'h2; // @[AXIPlatformWrapper.scala 137:18]
      end
    end else if (_T_10) begin // @[Conditional.scala 39:67]
      regState <= _GEN_15;
    end else begin
      regState <= _GEN_27;
    end
    if (reset) begin // @[AXIPlatformWrapper.scala 95:29]
      regModeWrite <= 1'h0; // @[AXIPlatformWrapper.scala 95:29]
    end else if (csr_1_readAddr_ready) begin // @[Conditional.scala 40:58]
      if (csr_ARVALID) begin // @[AXIPlatformWrapper.scala 123:32]
        regModeWrite <= 1'h0; // @[AXIPlatformWrapper.scala 126:22]
      end
    end else if (!(_T_8)) begin // @[Conditional.scala 39:67]
      if (_T_10) begin // @[Conditional.scala 39:67]
        regModeWrite <= _GEN_12;
      end
    end
    if (reset) begin // @[AXIPlatformWrapper.scala 96:25]
      regRdReq <= 1'h0; // @[AXIPlatformWrapper.scala 96:25]
    end else if (csr_1_readAddr_ready) begin // @[Conditional.scala 40:58]
      regRdReq <= _GEN_6;
    end else if (_T_8) begin // @[Conditional.scala 39:67]
      if (csr_RREADY & RegFile_io_extIF_readData_valid) begin // @[AXIPlatformWrapper.scala 136:64]
        regRdReq <= 1'h0; // @[AXIPlatformWrapper.scala 138:18]
      end
    end
    if (reset) begin // @[AXIPlatformWrapper.scala 97:26]
      regRdAddr <= 32'h0; // @[AXIPlatformWrapper.scala 97:26]
    end else if (csr_1_readAddr_ready) begin // @[Conditional.scala 40:58]
      if (csr_ARVALID) begin // @[AXIPlatformWrapper.scala 123:32]
        regRdAddr <= csr_ARADDR; // @[AXIPlatformWrapper.scala 125:19]
      end
    end
    if (reset) begin // @[AXIPlatformWrapper.scala 98:25]
      regWrReq <= 1'h0; // @[AXIPlatformWrapper.scala 98:25]
    end else if (!(csr_1_readAddr_ready)) begin // @[Conditional.scala 40:58]
      if (!(_T_8)) begin // @[Conditional.scala 39:67]
        if (_T_10) begin // @[Conditional.scala 39:67]
          regWrReq <= _GEN_13;
        end else begin
          regWrReq <= _GEN_26;
        end
      end
    end
    if (reset) begin // @[AXIPlatformWrapper.scala 99:26]
      regWrAddr <= 32'h0; // @[AXIPlatformWrapper.scala 99:26]
    end else if (!(csr_1_readAddr_ready)) begin // @[Conditional.scala 40:58]
      if (!(_T_8)) begin // @[Conditional.scala 39:67]
        if (_T_10) begin // @[Conditional.scala 39:67]
          regWrAddr <= _GEN_14;
        end
      end
    end
    if (reset) begin // @[AXIPlatformWrapper.scala 100:26]
      regWrData <= 32'h0; // @[AXIPlatformWrapper.scala 100:26]
    end else if (!(csr_1_readAddr_ready)) begin // @[Conditional.scala 40:58]
      if (!(_T_8)) begin // @[Conditional.scala 39:67]
        if (!(_T_10)) begin // @[Conditional.scala 39:67]
          regWrData <= _GEN_25;
        end
      end
    end
  end
// Register and memory initialization
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
  regWrAddr = _RAND_6[31:0];
  _RAND_7 = {1{`RANDOM}};
  regWrData = _RAND_7[31:0];
`endif // RANDOMIZE_REG_INIT
  `endif // RANDOMIZE
end // initial
`ifdef FIRRTL_AFTER_INITIAL
`FIRRTL_AFTER_INITIAL
`endif
`endif // SYNTHESIS
endmodule
