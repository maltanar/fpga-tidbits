`timescale 1 ns / 1 ps

`include "pdk_fpga_defines.vh"

(* keep_hierarchy = "true" *)
module cae_pers #(
   parameter    NUM_MC_PORTS = 1,
   parameter    RTNCTL_WIDTH = 32
) (
   //
   // Clocks and Resets
   //
   input		clk,		// Personalitycore clock
   input		clkhx,		// half-rate clock
   input		clk2x,		// 2x rate clock
   input		i_reset,	// global reset synchronized to clk

   //
   // Dispatch Interface
   //
   input                disp_inst_vld,
   input  [4:0]         disp_inst,
   input  [17:0]        disp_aeg_idx,
   input                disp_aeg_rd,
   input                disp_aeg_wr,
   input  [63:0]        disp_aeg_wr_data,

   output [17:0]        disp_aeg_cnt,
   output [15:0]        disp_exception,
   output               disp_idle,
   output               disp_rtn_data_vld,
   output [63:0]        disp_rtn_data,
   output               disp_stall,

   //
   // MC Interface(s)
   //
   output [NUM_MC_PORTS*1-1 :0]         mc_rq_vld,
   output [NUM_MC_PORTS*RTNCTL_WIDTH-1:0]         mc_rq_rtnctl,
   output [NUM_MC_PORTS*64-1:0]         mc_rq_data,
   output [NUM_MC_PORTS*48-1:0]         mc_rq_vadr,
   output [NUM_MC_PORTS*2-1 :0]         mc_rq_size,
   output [NUM_MC_PORTS*3-1 :0]         mc_rq_cmd,
   output [NUM_MC_PORTS*4-1 :0]         mc_rq_scmd,
   input  [NUM_MC_PORTS*1-1 :0]         mc_rq_stall,

   input  [NUM_MC_PORTS*1-1 :0]         mc_rs_vld,
   input  [NUM_MC_PORTS*3-1 :0]         mc_rs_cmd,
   input  [NUM_MC_PORTS*4-1 :0]         mc_rs_scmd,
   input  [NUM_MC_PORTS*64-1:0]         mc_rs_data,
   input  [NUM_MC_PORTS*RTNCTL_WIDTH-1:0]         mc_rs_rtnctl,
   output [NUM_MC_PORTS*1-1 :0]         mc_rs_stall,

   // Write flush
   output [NUM_MC_PORTS*1-1 :0]         mc_rq_flush,
   input  [NUM_MC_PORTS*1-1 :0]         mc_rs_flush_cmplt,

   //
   // AE-to-AE Interface not used
   //

   //
   // Management/Debug Interface
   //
   input				csr_wr_vld,
   input				csr_rd_vld,
   input  [15:0]			csr_address,
   input  [63:0]			csr_wr_data,
   output				csr_rd_ack,
   output [63:0]			csr_rd_data,

   //
   // Miscellaneous
   //
   input  [3:0]		i_aeid
);

`include "pdk_fpga_param.vh"

  // Convey-recommended way of registering the global reset signal
  wire r_reset;
  FDSE rst (.C(clk),.S(i_reset),.CE(r_reset),.D(!r_reset),.Q(r_reset));

   WolverinePlatformWrapper pers(
    .clk(clk),
    .reset(r_reset),
    .disp_inst_vld(disp_inst_vld),
    .disp_inst(disp_inst),
    .disp_aeg_idx(disp_aeg_idx),
    .disp_aeg_rd(disp_aeg_rd),
    .disp_aeg_wr(disp_aeg_wr),
    .disp_aeg_wr_data(disp_aeg_wr_data),
    .disp_aeg_cnt(disp_aeg_cnt),
    .disp_exception(disp_exception),
    .disp_idle(disp_idle),
    .disp_rtn_data_vld(disp_rtn_data_vld),
    .disp_rtn_data(disp_rtn_data),
    .disp_stall(disp_stall),
    .mc_rq_vld(mc_rq_vld),
    .mc_rq_rtnctl(mc_rq_rtnctl),
    .mc_rq_data(mc_rq_data),
    .mc_rq_vadr(mc_rq_vadr),
    .mc_rq_size(mc_rq_size),
    .mc_rq_cmd(mc_rq_cmd),
    .mc_rq_scmd(mc_rq_scmd),
    .mc_rq_stall(mc_rq_stall),
    .mc_rs_vld(mc_rs_vld),
    .mc_rs_cmd(mc_rs_cmd),
    .mc_rs_scmd(mc_rs_scmd),
    .mc_rs_data(mc_rs_data),
    .mc_rs_rtnctl(mc_rs_rtnctl),
    .mc_rs_stall(mc_rs_stall),
    .mc_rq_flush(mc_rq_flush),
    .mc_rs_flush_cmplt(mc_rs_flush_cmplt),
    .csr_wr_vld(csr_wr_vld),
    .csr_rd_vld(csr_rd_vld),
    .csr_address(csr_address),
    .csr_wr_data(csr_wr_data),
    .csr_rd_ack(csr_rd_ack),
    .csr_rd_data(csr_rd_data),
    .i_aeid(i_aeid)
   );

   /* ---------- debug & synopsys off blocks  ---------- */

   // synopsys translate_off

   // Parameters: 1-Severity: Don't Stop, 2-start check only after negedge of reset
   //assert_never #(1, 2, "***ERROR ASSERT: unimplemented instruction cracked") a0 (.clk(clk), .reset_n(!i_reset), .test_expr(r_unimplemented_inst));

   // Parameters: 0-Severity: Stop, 2-start check only after negedge of reset
   //assert_never #(0, 2, "***ERROR ASSERT: Number of MC Ports must be a power of 2") a1 (.clk(clk), .reset_n(!i_reset), .test_expr(|config_err));

    // synopsys translate_on

endmodule // cae_pers
