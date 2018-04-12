#cd /media/sf_ravvenShare/baseline/project/baseline.sdk
#hsi::open_hw_design design_1_wrapper.hdf
#hsi::set_repo_path /opt/Xilinx/SDK/2017.4/data/embeddedsw/lib/sw_apps
#hsi::generate_app -os standalone -proc ps7_cortexa9_0 -app zynq_fsbl -compile -sw fsbl -dir /ravvenlab/fsbl2

cd /media/sf_ravvenShare/baseline/project/baseline.sdk
set hwdsgn [open_hw_design design_1_wrapper.hdf]
generate_app -hw $hwdsgn -os standalone -proc ps7_cortexa9_0 -app zynq_fsbl -compile -sw fsbl -dir /ravvenlab/fsbl
exit