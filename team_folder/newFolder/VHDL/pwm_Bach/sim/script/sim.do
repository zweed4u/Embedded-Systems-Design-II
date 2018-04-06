vlib work
vcom -93 -work work ../../src/pwm_generator.vhd
vcom -93 -work work ../src/pwm_generator_tb.vhd
vsim -novopt pwm_generator_tb
do wave.do
run 1 ms
