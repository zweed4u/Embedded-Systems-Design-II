#cd /media/sf_ravvenShare/baseline/project/baseline.sdk
#hsi::open_hw_design design_1_wrapper.hdf
#hsi::set_repo_path /ravvenlab/device-tree-xlnx
#hsi::create_sw_design device-tree -os device_tree -proc ps7_cortexa9_0
#hsi::generate_target -dir /ravvenlab/dsk

cd /media/sf_ravvenShare/baseline/project/baseline.sdk
open_hw_design design_1_wrapper.hdf
set_repo_path /ravvenlab/device-tree-xlnx
create_sw_design device-tree -os device_tree -proc ps7_cortexa9_0
generate_target -dir /ravvenlab/device_tree_generated
exit