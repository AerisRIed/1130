#!/bin/csh -f

rm -rf jasper_cdc_run*

if(${HOST} =~ "noi*") then
    bsub -q int_work ./scripts/core/jasper/common/RunJasper.pl -app cdc -gui
else if(${HOSTNAME} =~ "kdt*") then
    bsub -Is -q normal ./scripts/core/jasper/common/RunJasper.pl -app cdc -gui
endif

