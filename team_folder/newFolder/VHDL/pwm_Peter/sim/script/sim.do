vlib work
vcom -93 -work work ../../src/pwm_top.vhd
vcom -93 -work work ../src/pwm_tb.vhd
vsim -novopt pwm_tb
do wave.do
run 100 ms
