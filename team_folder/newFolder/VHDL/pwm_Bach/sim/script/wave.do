onerror {resume}
quietly WaveActivateNextPane {} 0
add wave -noupdate /pwm_generator_tb/clk
add wave -noupdate /pwm_generator_tb/reset
add wave -noupdate -radix decimal -radixshowbase 1 /pwm_generator_tb/duty
add wave -noupdate -radix decimal -radixshowbase 1 /pwm_generator_tb/period
add wave -noupdate /pwm_generator_tb/enable
add wave -noupdate /pwm_generator_tb/output
add wave -noupdate /pwm_generator_tb/clk_period
TreeUpdate [SetDefaultTree]
WaveRestoreCursors {{Cursor 1} {158601 ns} 0}
quietly wave cursor active 1
configure wave -namecolwidth 207
configure wave -valuecolwidth 100
configure wave -justifyvalue left
configure wave -signalnamewidth 0
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
WaveRestoreZoom {0 ns} {5065506 ns}
