// Copyright 1986-2017 Xilinx, Inc. All Rights Reserved.
// --------------------------------------------------------------------------------
// Tool Version: Vivado v.2017.2 (win64) Build 1909853 Thu Jun 15 18:39:09 MDT 2017
// Date        : Tue Apr 17 16:27:50 2018
// Host        : 706-DXKIEE-148 running 64-bit Service Pack 1  (build 7601)
// Command     : write_verilog -force -mode funcsim
//               c:/dkaputa/blink_rover_axi/src/ip/design_1_blink_0_0/design_1_blink_0_0_sim_netlist.v
// Design      : design_1_blink_0_0
// Purpose     : This verilog netlist is a functional simulation representation of the design and should not be modified
//               or synthesized. This netlist cannot be used for SDF annotated simulation.
// Device      : xc7z010clg400-1
// --------------------------------------------------------------------------------
`timescale 1 ps / 1 ps

(* CHECK_LICENSE_TYPE = "design_1_blink_0_0,blink,{}" *) (* downgradeipidentifiedwarnings = "yes" *) (* x_core_info = "blink,Vivado 2017.2" *) 
(* NotValidForBitStream *)
module design_1_blink_0_0
   (clk,
    reset_n,
    blink_out);
  (* x_interface_info = "xilinx.com:signal:clock:1.0 clk CLK" *) input clk;
  (* x_interface_info = "xilinx.com:signal:reset:1.0 reset_n RST" *) input reset_n;
  output blink_out;

  wire blink_out;
  wire clk;
  wire reset_n;

  design_1_blink_0_0_blink U0
       (.blink_out(blink_out),
        .clk(clk),
        .reset_n(reset_n));
endmodule

(* ORIG_REF_NAME = "blink" *) 
module design_1_blink_0_0_blink
   (blink_out,
    clk,
    reset_n);
  output blink_out;
  input clk;
  input reset_n;

  wire blink_out;
  wire clk;
  wire [12:0]count_sig;
  wire count_sig0_carry__0_i_1_n_0;
  wire count_sig0_carry__0_i_2_n_0;
  wire count_sig0_carry__0_i_3_n_0;
  wire count_sig0_carry__0_i_4_n_0;
  wire count_sig0_carry__0_n_0;
  wire count_sig0_carry__0_n_1;
  wire count_sig0_carry__0_n_2;
  wire count_sig0_carry__0_n_3;
  wire count_sig0_carry__1_i_1_n_0;
  wire count_sig0_carry__1_i_2_n_0;
  wire count_sig0_carry__1_i_3_n_0;
  wire count_sig0_carry__1_i_4_n_0;
  wire count_sig0_carry__1_n_1;
  wire count_sig0_carry__1_n_2;
  wire count_sig0_carry__1_n_3;
  wire count_sig0_carry_i_1_n_0;
  wire count_sig0_carry_i_2_n_0;
  wire count_sig0_carry_i_3_n_0;
  wire count_sig0_carry_i_4_n_0;
  wire count_sig0_carry_n_0;
  wire count_sig0_carry_n_1;
  wire count_sig0_carry_n_2;
  wire count_sig0_carry_n_3;
  wire [12:0]count_sig_0;
  wire [12:1]data0;
  wire output_sig_i_1_n_0;
  wire output_sig_i_2_n_0;
  wire output_sig_i_3_n_0;
  wire output_sig_i_4_n_0;
  wire reset_n;
  wire [3:3]NLW_count_sig0_carry__1_CO_UNCONNECTED;

  CARRY4 count_sig0_carry
       (.CI(1'b0),
        .CO({count_sig0_carry_n_0,count_sig0_carry_n_1,count_sig0_carry_n_2,count_sig0_carry_n_3}),
        .CYINIT(count_sig[0]),
        .DI({1'b0,1'b0,1'b0,1'b0}),
        .O(data0[4:1]),
        .S({count_sig0_carry_i_1_n_0,count_sig0_carry_i_2_n_0,count_sig0_carry_i_3_n_0,count_sig0_carry_i_4_n_0}));
  CARRY4 count_sig0_carry__0
       (.CI(count_sig0_carry_n_0),
        .CO({count_sig0_carry__0_n_0,count_sig0_carry__0_n_1,count_sig0_carry__0_n_2,count_sig0_carry__0_n_3}),
        .CYINIT(1'b0),
        .DI({1'b0,1'b0,1'b0,1'b0}),
        .O(data0[8:5]),
        .S({count_sig0_carry__0_i_1_n_0,count_sig0_carry__0_i_2_n_0,count_sig0_carry__0_i_3_n_0,count_sig0_carry__0_i_4_n_0}));
  LUT1 #(
    .INIT(2'h2)) 
    count_sig0_carry__0_i_1
       (.I0(count_sig[8]),
        .O(count_sig0_carry__0_i_1_n_0));
  LUT1 #(
    .INIT(2'h2)) 
    count_sig0_carry__0_i_2
       (.I0(count_sig[7]),
        .O(count_sig0_carry__0_i_2_n_0));
  LUT1 #(
    .INIT(2'h2)) 
    count_sig0_carry__0_i_3
       (.I0(count_sig[6]),
        .O(count_sig0_carry__0_i_3_n_0));
  LUT1 #(
    .INIT(2'h2)) 
    count_sig0_carry__0_i_4
       (.I0(count_sig[5]),
        .O(count_sig0_carry__0_i_4_n_0));
  CARRY4 count_sig0_carry__1
       (.CI(count_sig0_carry__0_n_0),
        .CO({NLW_count_sig0_carry__1_CO_UNCONNECTED[3],count_sig0_carry__1_n_1,count_sig0_carry__1_n_2,count_sig0_carry__1_n_3}),
        .CYINIT(1'b0),
        .DI({1'b0,1'b0,1'b0,1'b0}),
        .O(data0[12:9]),
        .S({count_sig0_carry__1_i_1_n_0,count_sig0_carry__1_i_2_n_0,count_sig0_carry__1_i_3_n_0,count_sig0_carry__1_i_4_n_0}));
  LUT1 #(
    .INIT(2'h2)) 
    count_sig0_carry__1_i_1
       (.I0(count_sig[12]),
        .O(count_sig0_carry__1_i_1_n_0));
  LUT1 #(
    .INIT(2'h2)) 
    count_sig0_carry__1_i_2
       (.I0(count_sig[11]),
        .O(count_sig0_carry__1_i_2_n_0));
  LUT1 #(
    .INIT(2'h2)) 
    count_sig0_carry__1_i_3
       (.I0(count_sig[10]),
        .O(count_sig0_carry__1_i_3_n_0));
  LUT1 #(
    .INIT(2'h2)) 
    count_sig0_carry__1_i_4
       (.I0(count_sig[9]),
        .O(count_sig0_carry__1_i_4_n_0));
  LUT1 #(
    .INIT(2'h2)) 
    count_sig0_carry_i_1
       (.I0(count_sig[4]),
        .O(count_sig0_carry_i_1_n_0));
  LUT1 #(
    .INIT(2'h2)) 
    count_sig0_carry_i_2
       (.I0(count_sig[3]),
        .O(count_sig0_carry_i_2_n_0));
  LUT1 #(
    .INIT(2'h2)) 
    count_sig0_carry_i_3
       (.I0(count_sig[2]),
        .O(count_sig0_carry_i_3_n_0));
  LUT1 #(
    .INIT(2'h2)) 
    count_sig0_carry_i_4
       (.I0(count_sig[1]),
        .O(count_sig0_carry_i_4_n_0));
  LUT5 #(
    .INIT(32'h0000FFFD)) 
    \count_sig[0]_i_1 
       (.I0(output_sig_i_3_n_0),
        .I1(output_sig_i_4_n_0),
        .I2(count_sig[1]),
        .I3(count_sig[2]),
        .I4(count_sig[0]),
        .O(count_sig_0[0]));
  LUT6 #(
    .INIT(64'hFFFFFFFD00000000)) 
    \count_sig[10]_i_1 
       (.I0(output_sig_i_3_n_0),
        .I1(output_sig_i_4_n_0),
        .I2(count_sig[1]),
        .I3(count_sig[2]),
        .I4(count_sig[0]),
        .I5(data0[10]),
        .O(count_sig_0[10]));
  LUT6 #(
    .INIT(64'hFFFFFFFD00000000)) 
    \count_sig[11]_i_1 
       (.I0(output_sig_i_3_n_0),
        .I1(output_sig_i_4_n_0),
        .I2(count_sig[1]),
        .I3(count_sig[2]),
        .I4(count_sig[0]),
        .I5(data0[11]),
        .O(count_sig_0[11]));
  LUT6 #(
    .INIT(64'hFFFFFFFD00000000)) 
    \count_sig[12]_i_1 
       (.I0(output_sig_i_3_n_0),
        .I1(output_sig_i_4_n_0),
        .I2(count_sig[1]),
        .I3(count_sig[2]),
        .I4(count_sig[0]),
        .I5(data0[12]),
        .O(count_sig_0[12]));
  LUT6 #(
    .INIT(64'hFFFFFFFD00000000)) 
    \count_sig[1]_i_1 
       (.I0(output_sig_i_3_n_0),
        .I1(output_sig_i_4_n_0),
        .I2(count_sig[1]),
        .I3(count_sig[2]),
        .I4(count_sig[0]),
        .I5(data0[1]),
        .O(count_sig_0[1]));
  LUT6 #(
    .INIT(64'hFFFFFFFD00000000)) 
    \count_sig[2]_i_1 
       (.I0(output_sig_i_3_n_0),
        .I1(output_sig_i_4_n_0),
        .I2(count_sig[1]),
        .I3(count_sig[2]),
        .I4(count_sig[0]),
        .I5(data0[2]),
        .O(count_sig_0[2]));
  LUT6 #(
    .INIT(64'hFFFFFFFD00000000)) 
    \count_sig[3]_i_1 
       (.I0(output_sig_i_3_n_0),
        .I1(output_sig_i_4_n_0),
        .I2(count_sig[1]),
        .I3(count_sig[2]),
        .I4(count_sig[0]),
        .I5(data0[3]),
        .O(count_sig_0[3]));
  LUT6 #(
    .INIT(64'hFFFFFFFD00000000)) 
    \count_sig[4]_i_1 
       (.I0(output_sig_i_3_n_0),
        .I1(output_sig_i_4_n_0),
        .I2(count_sig[1]),
        .I3(count_sig[2]),
        .I4(count_sig[0]),
        .I5(data0[4]),
        .O(count_sig_0[4]));
  LUT6 #(
    .INIT(64'hFFFFFFFD00000000)) 
    \count_sig[5]_i_1 
       (.I0(output_sig_i_3_n_0),
        .I1(output_sig_i_4_n_0),
        .I2(count_sig[1]),
        .I3(count_sig[2]),
        .I4(count_sig[0]),
        .I5(data0[5]),
        .O(count_sig_0[5]));
  LUT6 #(
    .INIT(64'hFFFFFFFD00000000)) 
    \count_sig[6]_i_1 
       (.I0(output_sig_i_3_n_0),
        .I1(output_sig_i_4_n_0),
        .I2(count_sig[1]),
        .I3(count_sig[2]),
        .I4(count_sig[0]),
        .I5(data0[6]),
        .O(count_sig_0[6]));
  LUT6 #(
    .INIT(64'hFFFFFFFD00000000)) 
    \count_sig[7]_i_1 
       (.I0(output_sig_i_3_n_0),
        .I1(output_sig_i_4_n_0),
        .I2(count_sig[1]),
        .I3(count_sig[2]),
        .I4(count_sig[0]),
        .I5(data0[7]),
        .O(count_sig_0[7]));
  LUT6 #(
    .INIT(64'hFFFFFFFD00000000)) 
    \count_sig[8]_i_1 
       (.I0(output_sig_i_3_n_0),
        .I1(output_sig_i_4_n_0),
        .I2(count_sig[1]),
        .I3(count_sig[2]),
        .I4(count_sig[0]),
        .I5(data0[8]),
        .O(count_sig_0[8]));
  LUT6 #(
    .INIT(64'hFFFFFFFD00000000)) 
    \count_sig[9]_i_1 
       (.I0(output_sig_i_3_n_0),
        .I1(output_sig_i_4_n_0),
        .I2(count_sig[1]),
        .I3(count_sig[2]),
        .I4(count_sig[0]),
        .I5(data0[9]),
        .O(count_sig_0[9]));
  FDCE #(
    .INIT(1'b0)) 
    \count_sig_reg[0] 
       (.C(clk),
        .CE(1'b1),
        .CLR(output_sig_i_2_n_0),
        .D(count_sig_0[0]),
        .Q(count_sig[0]));
  FDCE #(
    .INIT(1'b0)) 
    \count_sig_reg[10] 
       (.C(clk),
        .CE(1'b1),
        .CLR(output_sig_i_2_n_0),
        .D(count_sig_0[10]),
        .Q(count_sig[10]));
  FDCE #(
    .INIT(1'b0)) 
    \count_sig_reg[11] 
       (.C(clk),
        .CE(1'b1),
        .CLR(output_sig_i_2_n_0),
        .D(count_sig_0[11]),
        .Q(count_sig[11]));
  FDCE #(
    .INIT(1'b0)) 
    \count_sig_reg[12] 
       (.C(clk),
        .CE(1'b1),
        .CLR(output_sig_i_2_n_0),
        .D(count_sig_0[12]),
        .Q(count_sig[12]));
  FDCE #(
    .INIT(1'b0)) 
    \count_sig_reg[1] 
       (.C(clk),
        .CE(1'b1),
        .CLR(output_sig_i_2_n_0),
        .D(count_sig_0[1]),
        .Q(count_sig[1]));
  FDCE #(
    .INIT(1'b0)) 
    \count_sig_reg[2] 
       (.C(clk),
        .CE(1'b1),
        .CLR(output_sig_i_2_n_0),
        .D(count_sig_0[2]),
        .Q(count_sig[2]));
  FDCE #(
    .INIT(1'b0)) 
    \count_sig_reg[3] 
       (.C(clk),
        .CE(1'b1),
        .CLR(output_sig_i_2_n_0),
        .D(count_sig_0[3]),
        .Q(count_sig[3]));
  FDCE #(
    .INIT(1'b0)) 
    \count_sig_reg[4] 
       (.C(clk),
        .CE(1'b1),
        .CLR(output_sig_i_2_n_0),
        .D(count_sig_0[4]),
        .Q(count_sig[4]));
  FDCE #(
    .INIT(1'b0)) 
    \count_sig_reg[5] 
       (.C(clk),
        .CE(1'b1),
        .CLR(output_sig_i_2_n_0),
        .D(count_sig_0[5]),
        .Q(count_sig[5]));
  FDCE #(
    .INIT(1'b0)) 
    \count_sig_reg[6] 
       (.C(clk),
        .CE(1'b1),
        .CLR(output_sig_i_2_n_0),
        .D(count_sig_0[6]),
        .Q(count_sig[6]));
  FDCE #(
    .INIT(1'b0)) 
    \count_sig_reg[7] 
       (.C(clk),
        .CE(1'b1),
        .CLR(output_sig_i_2_n_0),
        .D(count_sig_0[7]),
        .Q(count_sig[7]));
  FDCE #(
    .INIT(1'b0)) 
    \count_sig_reg[8] 
       (.C(clk),
        .CE(1'b1),
        .CLR(output_sig_i_2_n_0),
        .D(count_sig_0[8]),
        .Q(count_sig[8]));
  FDCE #(
    .INIT(1'b0)) 
    \count_sig_reg[9] 
       (.C(clk),
        .CE(1'b1),
        .CLR(output_sig_i_2_n_0),
        .D(count_sig_0[9]),
        .Q(count_sig[9]));
  LUT6 #(
    .INIT(64'hFFFFFFFD00000002)) 
    output_sig_i_1
       (.I0(output_sig_i_3_n_0),
        .I1(output_sig_i_4_n_0),
        .I2(count_sig[1]),
        .I3(count_sig[2]),
        .I4(count_sig[0]),
        .I5(blink_out),
        .O(output_sig_i_1_n_0));
  LUT1 #(
    .INIT(2'h1)) 
    output_sig_i_2
       (.I0(reset_n),
        .O(output_sig_i_2_n_0));
  LUT6 #(
    .INIT(64'h0000010000000000)) 
    output_sig_i_3
       (.I0(count_sig[10]),
        .I1(count_sig[4]),
        .I2(count_sig[6]),
        .I3(count_sig[8]),
        .I4(count_sig[5]),
        .I5(count_sig[9]),
        .O(output_sig_i_3_n_0));
  LUT4 #(
    .INIT(16'hFF7F)) 
    output_sig_i_4
       (.I0(count_sig[12]),
        .I1(count_sig[3]),
        .I2(count_sig[7]),
        .I3(count_sig[11]),
        .O(output_sig_i_4_n_0));
  FDCE output_sig_reg
       (.C(clk),
        .CE(1'b1),
        .CLR(output_sig_i_2_n_0),
        .D(output_sig_i_1_n_0),
        .Q(blink_out));
endmodule
`ifndef GLBL
`define GLBL
`timescale  1 ps / 1 ps

module glbl ();

    parameter ROC_WIDTH = 100000;
    parameter TOC_WIDTH = 0;

//--------   STARTUP Globals --------------
    wire GSR;
    wire GTS;
    wire GWE;
    wire PRLD;
    tri1 p_up_tmp;
    tri (weak1, strong0) PLL_LOCKG = p_up_tmp;

    wire PROGB_GLBL;
    wire CCLKO_GLBL;
    wire FCSBO_GLBL;
    wire [3:0] DO_GLBL;
    wire [3:0] DI_GLBL;
   
    reg GSR_int;
    reg GTS_int;
    reg PRLD_int;

//--------   JTAG Globals --------------
    wire JTAG_TDO_GLBL;
    wire JTAG_TCK_GLBL;
    wire JTAG_TDI_GLBL;
    wire JTAG_TMS_GLBL;
    wire JTAG_TRST_GLBL;

    reg JTAG_CAPTURE_GLBL;
    reg JTAG_RESET_GLBL;
    reg JTAG_SHIFT_GLBL;
    reg JTAG_UPDATE_GLBL;
    reg JTAG_RUNTEST_GLBL;

    reg JTAG_SEL1_GLBL = 0;
    reg JTAG_SEL2_GLBL = 0 ;
    reg JTAG_SEL3_GLBL = 0;
    reg JTAG_SEL4_GLBL = 0;

    reg JTAG_USER_TDO1_GLBL = 1'bz;
    reg JTAG_USER_TDO2_GLBL = 1'bz;
    reg JTAG_USER_TDO3_GLBL = 1'bz;
    reg JTAG_USER_TDO4_GLBL = 1'bz;

    assign (strong1, weak0) GSR = GSR_int;
    assign (strong1, weak0) GTS = GTS_int;
    assign (weak1, weak0) PRLD = PRLD_int;

    initial begin
	GSR_int = 1'b1;
	PRLD_int = 1'b1;
	#(ROC_WIDTH)
	GSR_int = 1'b0;
	PRLD_int = 1'b0;
    end

    initial begin
	GTS_int = 1'b1;
	#(TOC_WIDTH)
	GTS_int = 1'b0;
    end

endmodule
`endif
