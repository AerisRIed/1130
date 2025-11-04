import wrun_build_env
from wrun_build_env import build_def

build_def(
   build_name      ="dp_base_build",
   comp_args       ="+define+DP +define+PD_WIDTH=32 +define+SERDES_WIDTH=32 +define+CDNS_PHY_PWR_AWARE +define+CDN_MPPHY_UC_ECC_EN +define+CDN_TC_UC_SRAM_128KB ",
   # comp_args       ='+define+DUT_BYPASS +define+SERDES_WIDTH=32 +define+DP' + common_args,
   tb_fl           ="$PHY_VERIF_AREA/top/tb_filelist.f",
  # dut_fl          ="$PHY_DESIGN_AREA/../filelist/dut.f ",
   dut_fl          ="${PHY_DESIGN_AREA}/design/filelist/output/timberwolf_phy_hlm_sim.f",
   pre_build       =" "
)
