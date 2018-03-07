open_system('gm_pwm');
cs.HiliteType = 'user1';
cs.ForegroundColor = 'black';
cs.BackgroundColor = 'blue';
set_param(0, 'HiliteAncestorsData', cs);
hilite_system('gm_pwm/timesTwo/Gain', 'user1');
annotate_port('gm_pwm/timesTwo/Gain', 0, 1, 'cp : 0 ns');
