import wrun_build_env
from wrun_build_env import build_def
build_def(
   build_name      ="usb4_base_build",
   comp_args       ="+define+USB4 +define+PD_WIDTH=40 +define+SERDES_WIDTH=40 +define+CDNS_PHY_PWR_AWARE +define+CDN_TC_UC_SRAM_128KB ",
   # comp_args       ='+define+DUT_BYPASS +define+SERDES_WIDTH=32 +define+USB32' + common_args,
   tb_fl           ="$PHY_VERIF_AREA/top/tb_filelist.f",
    dut_fl          ="${PHY_DESIGN_AREA}/design/filelist/output/timberwolf_phy_hlm_sim.f",

   pre_build       =" "
)


usb4_vip_args = " -define DENALI_SV_NC \
	-coverage U \
	-defineall DENALI_USB_NO_HIER +UVM_NO_RELNOTES -libext .sv -defineall CDN_USB4_UVM_CONFIG -defineall WAVEFORM_DEBUGGER_ENABLE -defineall CDN_USB4_PIPEPHY_EN -defineall CDN_USB4_PIPEPHY_HOST_MAC -defineall CDN_USB4_PIPEPHY_PSV_HOST_MAC_MON -defineall CDN_USB4_PIPEPHY_PCS_PMA "
build_def(
   build_name      ="usb4_vip_build",
   comp_args       =" " + usb4_vip_args,
   # comp_args       ='+define+DUT_BYPASS +define+SERDES_WIDTH=32 +define+USB32' + common_args,
   tb_fl           ="$PHY_VERIF_AREA/top/tb_vip_filelist.f",
   # dut_fl          ="$PHY_DESIGN_AREA/../filelist/dut.f ",

   pre_build       =" sed -i 's/-top cdn_phy_tb_top/-top top/g' ./job.sh;"
)

build_def(
   build_name      ="usb4_vip_tb_build",
   comp_args       ="+define+USB4 +define+PD_WIDTH=40 +define+SERDES_WIDTH=40 +define+CDNS_PHY_PWR_AWARE +define+CDN_TC_UC_SRAM_128KB +define+DENALI_USB4_VIP" + usb4_vip_args,
   tb_fl           ="$PHY_VERIF_AREA/top/tb_vip_filelist.f",
   dut_fl          ="${PHY_DESIGN_AREA}/design/filelist/output/timberwolf_phy_hlm_sim.f",
   #pre_build       =" sed -i 's/-top cdn_phy_tb_top/-top top/g' ./job.sh;"
)

build_def(
   build_name      ="usb4_base_mlm_build",
   comp_args       ="+define+USB4 +define+PD_WIDTH=40 +define+SERDES_WIDTH=40 +define+CDNS_PHY_PWR_AWARE +define+CDN_MPPHY_UC_ECC_EN +define+CDN_TC_UC_SRAM_128KB +define+MLM_ENABLE",
   tb_fl           ="$PHY_VERIF_AREA/top/tb_filelist.f",
   dut_fl          ="${PHY_DESIGN_AREA}/design/filelist/output/timberwolf_phy_mlm_sim.f",

   pre_build       =" "
)


