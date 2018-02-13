onerror {resume}
quietly WaveActivateNextPane {} 0
add wave -noupdate /lab2_2_tb/sync
add wave -noupdate /lab2_2_tb/clk
add wave -noupdate /lab2_2_tb/enable_sig
add wave -noupdate /lab2_2_tb/reset
TreeUpdate [SetDefaultTree]
WaveRestoreCursors {{Cursor 1} {50 ns} 0}
quietly wave cursor active 1
configure wave -namecolwidth 177
configure wave -valuecolwidth 40
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
WaveRestoreZoom {9901 ns} {10006 ns}
