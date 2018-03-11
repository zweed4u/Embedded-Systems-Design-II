vlib work
vlib riviera

vlib riviera/xil_defaultlib
vlib riviera/xpm
vlib riviera/lib_cdc_v1_0_2
vlib riviera/proc_sys_reset_v5_0_11

vmap xil_defaultlib riviera/xil_defaultlib
vmap xpm riviera/xpm
vmap lib_cdc_v1_0_2 riviera/lib_cdc_v1_0_2
vmap proc_sys_reset_v5_0_11 riviera/proc_sys_reset_v5_0_11

vlog -work xil_defaultlib  -sv2k12 "+incdir+../../../../../src/ipshared/7e3a/hdl" "+incdir+../../../../../src/ipshared/2ad9/hdl" "+incdir+../../../../../src/ipshared/39ca/hdl/verilog" "+incdir+../../../../../src/ipshared/6eb1/hdl" "+incdir+../../../../../src/ipshared/1d61/hdl" "+incdir+../../../../../src/ipshared/7e3a/hdl" "+incdir+../../../../../src/ipshared/2ad9/hdl" "+incdir+../../../../../src/ipshared/39ca/hdl/verilog" "+incdir+../../../../../src/ipshared/6eb1/hdl" "+incdir+../../../../../src/ipshared/1d61/hdl" \
"C:/Xilinx/Vivado/2017.2/data/ip/xpm/xpm_cdc/hdl/xpm_cdc.sv" \

vcom -work xpm -93 \
"C:/Xilinx/Vivado/2017.2/data/ip/xpm/xpm_VCOMP.vhd" \

vcom -work xil_defaultlib -93 \
"c:/Users/zdw7287/Downloads/custom/axi_test/src/ip/design_1_processing_system7_0_0/design_1_processing_system7_0_0_sim_netlist.vhdl" \

vcom -work lib_cdc_v1_0_2 -93 \
"../../../../../src/ipshared/52cb/hdl/lib_cdc_v1_0_rfs.vhd" \

vcom -work proc_sys_reset_v5_0_11 -93 \
"../../../../../src/ipshared/5db7/hdl/proc_sys_reset_v5_0_vh_rfs.vhd" \

vcom -work xil_defaultlib -93 \
"../../../../../src/ip/design_1_rst_ps7_0_50M_0/sim/design_1_rst_ps7_0_50M_0.vhd" \
"../../../../../src/hdl/design_1.vhd" \
"../../../../../src/ipshared/50cd/hdl/my_pwm_v1_0_S00_AXI.vhd" \
"../../../../../src/ipshared/50cd/src/pwm.vhd" \
"../../../../../src/ipshared/50cd/src/pwm_top.vhd" \
"../../../../../src/ipshared/50cd/hdl/my_pwm_v1_0.vhd" \
"../../../../../src/ip/design_1_my_pwm_0_0/sim/design_1_my_pwm_0_0.vhd" \
"c:/Users/zdw7287/Downloads/custom/axi_test/src/ip/design_1_auto_pc_0/design_1_auto_pc_0_sim_netlist.vhdl" \

vlog -work xil_defaultlib \
"glbl.v"

