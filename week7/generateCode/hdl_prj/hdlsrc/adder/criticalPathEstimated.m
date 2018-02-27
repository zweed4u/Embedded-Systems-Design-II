open_system('gm_adder');
cs.HiliteType = 'user1';
cs.ForegroundColor = 'black';
cs.BackgroundColor = 'blue';
set_param(0, 'HiliteAncestorsData', cs);
hilite_system('gm_adder/Subsystem/Sum', 'user1');
annotate_port('gm_adder/Subsystem/Sum', 0, 1, 'cp : 1.198 ns');
