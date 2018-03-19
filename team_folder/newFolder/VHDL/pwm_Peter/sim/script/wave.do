onerror {resume}
quietly WaveActivateNextPane {} 0
add wave -noupdate /pwm_tb/reset_n
add wave -noupdate /pwm_tb/clock
add wave -noupdate /pwm_tb/enable
add wave -noupdate -radix unsigned /pwm_tb/pwm_period
add wave -noupdate -radix unsigned /pwm_tb/pwm_duty_cycle
add wave -noupdate /pwm_tb/pwm
TreeUpdate [SetDefaultTree]
WaveRestoreCursors {{Period Start} {99220030 ns} 0} {{Period End} {99250970 ns} 0} {{Duty Cycle} {99360030 ns} 0}
quietly wave cursor active 3
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
WaveRestoreZoom {96882807 ns} {100164063 ns}
