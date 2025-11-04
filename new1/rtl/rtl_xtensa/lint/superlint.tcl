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

###!!!Change Top name
elaborate -top uc
#elaborate -bbox_m pma_ana -top top

check_superlint -extract

check_superlint -report -violation -order category -file ./superlint_violations.csv  -force -csv  -detailed

check_superlint -report -summary
