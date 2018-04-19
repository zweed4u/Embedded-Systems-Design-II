// Copyright 1986-2017 Xilinx, Inc. All Rights Reserved.
// --------------------------------------------------------------------------------
// Tool Version: Vivado v.2017.2 (win64) Build 1909853 Thu Jun 15 18:39:09 MDT 2017
// Date        : Tue Apr 17 16:27:50 2018
// Host        : 706-DXKIEE-148 running 64-bit Service Pack 1  (build 7601)
// Command     : write_verilog -force -mode synth_stub
//               c:/dkaputa/blink_rover_axi/src/ip/design_1_blink_0_0/design_1_blink_0_0_stub.v
// Design      : design_1_blink_0_0
// Purpose     : Stub declaration of top-level module interface
// Device      : xc7z010clg400-1
// --------------------------------------------------------------------------------

// This empty module with port declaration file causes synthesis tools to infer a black box for IP.
// The synthesis directives are for Synopsys Synplify support to prevent IO buffer insertion.
// Please paste the declaration into a Verilog source file or add the file as an additional source.
(* x_core_info = "blink,Vivado 2017.2" *)
module design_1_blink_0_0(clk, reset_n, blink_out)
/* synthesis syn_black_box black_box_pad_pin="clk,reset_n,blink_out" */;
  input clk;
  input reset_n;
  output blink_out;
endmodule