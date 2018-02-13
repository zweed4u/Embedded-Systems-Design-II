#!/bin/bash
/home/zweeden/intelFPGA_pro/17.1/modelsim_ase/bin/vsim -do "$(dirname $(readlink -f "$0"))"/sim_2.do