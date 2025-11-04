import wrun_build_env
from wrun_build_env import build_def
common_args = ' '
build_def(
   build_name      ="usb32_demo_build",
   # comp_args       ="+define+USB4_ENV  ",
   comp_args       ='+define+DUT_BYPASS +define+SERDES_WIDTH=32 +define+USB32' + common_args,
   tb_fl           ="$PHY_VERIF_AREA/top/tb_filelist.f",
   # dut_fl          ="$PHY_DESIGN_AREA/../filelist/dut.f ",

   pre_build       =" "
)