#CMD: jg -superlint superlint.tcl &
#Step1: Prepare filelist
#Step2: Change Top name

analyze -clear

config_rtlds -rule -load ./Superlint_Rulefile_IPG_2019_06.def

config_rtlds -rule -disable -domain all
config_rtlds -rule -enable -domain {LINT}

###!!!Change Filelist
analyze -sv09 -F ../filelist/output/timberwolf_phy_synth.f /process/tsmcN4/data/stdcell/n4gp/TSMC/tcbn04p_bwph210l6p51cnod_base_lvt_100b/verilog/tcbn04p_bwph210l6p51cnod_base_lvt.v

###!!!Change Top name
elaborate \
-bbox_m \
{ \
cdn_sd3101_n4p_22_vs130_1xah1xbv1xch1xdv1yah1ybv4yhvhv2z \
Xm_serdes_64i64d0256d1_fusaXttop \
CW_ecc_legacy_width32_chkbits7_synd_sel0 \
CW_ecc_legacy_width32_chkbits7_synd_sel1 \
} \
-top cdn_sd3101x_n4p_22_vs130_1xah1xbv1xch1xdv1yah1ybv4yhvhv2z

check_superlint -extract

check_superlint -report -violation -order category -file ./superlint_violations.csv  -force -csv  -detailed

check_superlint -report -summary
