onerror {resume}
quietly WaveActivateNextPane {} 0
add wave -noupdate /encoder_reader_tb/reset_n
add wave -noupdate /encoder_reader_tb/clock
add wave -noupdate /encoder_reader_tb/enable
add wave -noupdate /encoder_reader_tb/reset_pulse_count
add wave -noupdate /encoder_reader_tb/encoder
add wave -noupdate /encoder_reader_tb/uut/encoder_pulse
add wave -noupdate -radix unsigned /encoder_reader_tb/encoder_pulse_count
TreeUpdate [SetDefaultTree]
WaveRestoreCursors {Cursor {0 ns} 0}
quietly wave cursor active 1
configure wave -namecolwidth 177
configure wave -valuecolwidth 81
configure wave -justifyvalue left
configure wave -signalnamewidth 1
configure wave -snapdistance 10
configure wave -datasetprefix 0
configure wave -rowmargin 4
configure wave -childrowmargin 2
configure wave -gridoffset 0
configure wave -gridperiod 1
configure wave -griddelta 40
configure wave -timeline 0
configure wave -timelineunits ns
update
WaveRestoreZoom {0 ns} {4252500 ns}
