vlib work
vcom -93 -work work ../../src/lab2.vhd
vcom -93 -work work ../src/lab2_tb.vhd
vsim -novopt lab2_tb
do wave.do
run 1 sec
