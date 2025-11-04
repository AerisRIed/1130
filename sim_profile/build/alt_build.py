import wrun_build_env
from wrun_build_env import build_def
build_def(
   build_name      ="alt_mode_base_build",
   comp_args       ="+define+ALT_MODE +define+PD_WIDTH=32 +define+SERDES_WIDTH=40 +define+CDNS_PHY_PWR_AWARE +define+CDN_MPPHY_UC_ECC_EN +define+CDN_TC_UC_SRAM_128KB ",
   tb_fl           ="$PHY_VERIF_AREA/top/tb_filelist.f",
   dut_fl          ="${PHY_DESIGN_AREA}/design/filelist/output/timberwolf_phy_hlm_sim.f",
   pre_build       =" "
)

