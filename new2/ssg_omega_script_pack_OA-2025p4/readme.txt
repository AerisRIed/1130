
Steps: source setup.csh, and then "./run.csh"

steps in setup.csh:
1, source Timberwolf_USB4_T4GP/sourceme_noi.csh    --- NOTE: 2025-09-11: can only run at NIO server
2, module unload jasper
3, unalias module
4, cd Timberwolf_USB4_T4GP/trunk/design/ssg_omega_script_pack_OA-2025p4
   source ./scripts/core/common/omega_tool_setup.sh

command in run.csh
bsub -q int_work ./scripts/core/jasper/common/RunJasper.pl -app cdc -gui     --- NOI
bsub -Is -q normal ./scripts/core/jasper/common/RunJasper.pl -app cdc -gui   --- KDT


Files used:
1, scripts/user/common/omega_user_vars.tcl 
      top design/filelist/defines/bbox/sdc_file/

2, scripts/user/jasper/common/jasper_common_user_signal_binding.tcl
      constraint/

3, scripts/user/jasper/cdc/jasper_cdc_user_rule_waivers.tcl 
      waiver

4, scripts/user/jasper/cdc/jasper_cdc_user_rule_settings.tcl 
      rules
