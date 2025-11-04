# ----------------------------------------
# JasperGold Version Info
# tool      : JasperGold 2020.06
# platform  : Linux 3.10.0-1160.2.2.el7.x86_64
# version   : 2020.06p002 64 bits
# build date: 2020.08.25 18:12:38 PDT
# ----------------------------------------
# started   : 2025-10-13 07:13:30 CST
# hostname  : kdt-utility04.cadence.com
# pid       : 244454
# arguments : '-label' 'session_0' '-console' '//127.0.0.1:40630' '-style' 'windows' '-data' 'AQAAADx/////AAAAAAAAA3oAAAAQAEwATQBSAEUATQBPAFYARQAAAAAAAAHgAAAAAAAAADwB' '-proj' '/projects/sd3101_t4gp_fe/users/canchen/Timberwolf_USB4_T4GP/trunk/design/rtl/rtl_xtensa/lint/jgproject/sessionLogs/session_0' '-init' '-hidden' '/projects/sd3101_t4gp_fe/users/canchen/Timberwolf_USB4_T4GP/trunk/design/rtl/rtl_xtensa/lint/jgproject/.tmp/.initCmds.tcl' 'superlint.tcl'
check_superlint -init
#CMD: jg -superlint superlint.tcl &
#Step1: Prepare filelist
#Step2: Change Top name

#set top = Need to change;

analyze -clear

config_rtlds -rule -load ./Superlint_Rulefile_IPG_2019_06.def

config_rtlds -rule -disable -domain all
config_rtlds -rule -enable -domain {LINT}

###!!!Change Filelist
analyze -sv09 -F filelist.f
