#!/bin/csh -f

#source ../../verif/sourceme_nj.csh

setenv LSF "bsub -Is -q normal"

set JCDC_TCL_FILE = "./cdn_jcdc.tcl"
set JCDC_CMD_ARGS = "jg -cdc $JCDC_TCL_FILE"

rm -rf jgproject

$LSF $JCDC_CMD_ARGS
