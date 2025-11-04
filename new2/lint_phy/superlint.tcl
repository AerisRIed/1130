#CMD: jg -superlint superlint.tcl &
#Step1: Prepare filelist
#Step2: Change Top name

analyze -clear

config_rtlds -rule -load ./Superlint_Rulefile_IPG_2019_06.def

config_rtlds -rule -disable -domain all
config_rtlds -rule -enable -domain {LINT}

###!!!Change Filelist
analyze -sv09 -F ../filelist/output/timberwolf_phy_hlm_sim.f \
+define+META_SYNC_DISABLE \
+define+CDN_MPPHY_UC_ECC_EN \
+define+CDN_TESTCHIP_UC_DBGR \
+define+CDN_TC_UC_SRAM_128KB \
+define+HBDC_SYNTHESIS

###!!!Change Top name
elaborate \
-bbox_m \
{ \
cmn_ana \
txm_ana \
rxtxm_ana \
Xm_serdes_128id0256d1_fusaXttop \
CW_ecc_legacy_width32_chkbits7_synd_sel0 \
CW_ecc_legacy_width32_chkbits7_synd_sel1 \
} \
-top cdn_sd3101x_n4p_22_vs130_1xah1xbv1xch1xdv1yah1ybv4yhvhv2z

check_superlint -extract

if [file exists ./superlint_waivers.tcl] {
    echo "Using existing waivers file: ./superlint_waivers.tcl.";
    check_superlint -waiver -import -file_name ./superlint_waivers.tcl
}

source ./superlint_waivers.tcl

check_superlint -report -violation -order category -file ./superlint_violations.csv  -force -csv  -detailed

check_superlint -report -summary
