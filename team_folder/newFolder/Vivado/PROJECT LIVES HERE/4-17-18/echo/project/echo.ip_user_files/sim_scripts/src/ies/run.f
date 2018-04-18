-makelib ies/xil_defaultlib -sv \
  "C:/Xilinx/Vivado/2017.2/data/ip/xpm/xpm_cdc/hdl/xpm_cdc.sv" \
-endlib
-makelib ies/xpm \
  "C:/Xilinx/Vivado/2017.2/data/ip/xpm/xpm_VCOMP.vhd" \
-endlib
-makelib ies/xil_defaultlib \
  "../../../../../src/ip/design_1_processing_system7_0_0/design_1_processing_system7_0_0_sim_netlist.vhdl" \
  "../../../../../src/ip/design_1_blink_0_0/design_1_blink_0_0_sim_netlist.vhdl" \
  "../../../../../src/ipshared/e885/hdl/ultrasonic_sensor_axi_v1_0_S00_AXI.vhd" \
  "../../../../../src/ipshared/e885/hdl/ultrasonic_sensor_axi_v1_0.vhd" \
  "../../../../../src/ip/design_1_ultrasonic_sensor_axi_0_0/sim/design_1_ultrasonic_sensor_axi_0_0.vhd" \
-endlib
-makelib ies/lib_cdc_v1_0_2 \
  "../../../../../src/ipshared/52cb/hdl/lib_cdc_v1_0_rfs.vhd" \
-endlib
-makelib ies/proc_sys_reset_v5_0_11 \
  "../../../../../src/ipshared/5db7/hdl/proc_sys_reset_v5_0_vh_rfs.vhd" \
-endlib
-makelib ies/xil_defaultlib \
  "../../../../../src/ip/design_1_rst_ps7_0_50M_0/sim/design_1_rst_ps7_0_50M_0.vhd" \
  "../../../../../src/hdl/design_1.vhd" \
  "s:/echo/echo/src/ip/design_1_echo_pulse_measurer_0_0/design_1_echo_pulse_measurer_0_0_sim_netlist.vhdl" \
  "s:/echo/echo/src/ip/design_1_echo_pulse_measurer_1_0/design_1_echo_pulse_measurer_1_0_sim_netlist.vhdl" \
  "s:/echo/echo/src/ip/design_1_echo_pulse_measurer_2_0/design_1_echo_pulse_measurer_2_0_sim_netlist.vhdl" \
  "../../../../../src/ip/design_1_auto_pc_0/design_1_auto_pc_0_sim_netlist.vhdl" \
-endlib
-makelib ies/xil_defaultlib \
  glbl.v
-endlib

