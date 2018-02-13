vlib work
vcom -93 -work work ../../src/lab2_2.vhd
vcom -93 -work work ../src/lab2_2_tb.vhd
vsim -novopt lab2_2_tb
do wave_2.do
run 1 sec
