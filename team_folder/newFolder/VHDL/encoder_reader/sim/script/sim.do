vlib work
vcom -93 -work work ../../src/encoder_reader_top.vhd
vcom -93 -work work ../../src/edge_detector.vhd
vcom -93 -work work ../../src/encoder_pulse_counter.vhd
vcom -93 -work work ../src/encoder_reader_tb.vhd
vsim -novopt encoder_reader_tb
do wave.do
run 4.05 ms
