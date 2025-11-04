################################################################################
# Copyright (c) 2025 by Cadence Design Systems Inc. ALL RIGHTS RESERVED.       #
# These coded instructions, statements, and computer programs are the          #
# copyrighted works and confidential proprietary information of Cadence Design #
# Systems Inc. They may not be modified, copied, reproduced, distributed, or   #
# disclosed to third parties in any manner, medium, or form, in whole or in    #
# part, without the prior written consent of Cadence Design Systems Inc.       #
################################################################################

@ RUN_MODULE_LOAD = 1
@ SETUP_ERROR_COUNT = 0
if (`grep -c 'auto_master_lnx_sjtencad' /etc/auto.master` || `grep -c 'auto_master_lnx_tensilica' /etc/auto.master`) then
  if (-x /cad/scripts/genus) then
    echo "Detected Tensilica user with /cad/scripts access: setting tool versions directly for OA-2025.5\n"
    setenv CDN_GENUS_ROOT  /cad/cadence_root/genus/GENUS23.14/23.14-s090_1
    setenv CDN_JLS_ROOT    /cad/cadence_root/joules/JLS231/23.14-s077_1
    setenv VERPLEX_HOME    /cad/cadence_root/conformal/25.10/lec.25.10-p100
    setenv JASPER          /cad/cadence_root/jasper/jasper_2025.03p001
    setenv CDN_LITMUS_ROOT /cad/cadence_root/litmus/LITMUS232/23.20.700
    set path = ( \
		/grid/sfi/lava/CLUSTERS/tencad-grid/bin \
		/grid/sfi/lava/CLUSTERS/tencad-grid/sbin \
		/cad/scripts \
		$CDN_GENUS_ROOT/bin \
		$CDN_JLS_ROOT/bin \
		$VERPLEX_HOME/bin \
		$JASPER/bin \
		$CDN_LITMUS_ROOT/bin \
		$path \
	       )
    @ RUN_MODULE_LOAD = 0
  else
    echo "Detected Tensilica user without /cad/scripts access: loading tool modules instead. Use the -bsub option for all Perl run scripts\n"
  endif
endif
if ($RUN_MODULE_LOAD == 1) then
  if (`alias module` != "") then
    echo "The module command is already aliased - overwriting with Omega flow module setup\n"
    unalias module
  endif
  echo "Performing module flow setup\n"
  if ($?tcsh) then
    set modules_shell="tcsh"
  else
    set modules_shell="csh"
  endif
  alias module 'eval `/usr/bin/tclsh /grid/common/pkgsData/modules-v5.0.0/Linux/RHEL7.0-2017-x86_64/libexec/modulecmd.tcl '$modules_shell '\!*`'
  module use -a /home/cm_admin/modules/Linux/modulefiles
  module use -a /vols/IPG_SCRIPT_INFRA_ROOT/modulefiles_infra/infra/default
  module use -a /vols/IPG_SCRIPT_INFRA_ROOT/CPD/modulefiles
  module use -a /vols/IPG_SCRIPT_INFRA_ROOT/CPD/modulefiles/nu_infra/.tendpc
  module use -a /apps/ssg_tools/modulefiles
  if (-r /grid/sfi/farm/tencad-grid/conf/cshrc.lsf) then
    setenv GRID v4tencad
    source /cad/cad/setup_gridenv
  endif
  echo "Loading modules for required tool versions of OA-2025.5:\n"
  set O_GEN_VER   = "genus/231/23.14-s090_1"
  set O_JLS_VER   = "jls/231/23.14-s077_1"
  set O_CFRML_VER = "confrml/251/25.10.100"
  set O_JG_VER    = "jasper/2503/25.03.001"
  set O_LIT1_VER  = "litmus/232/23.20.700"
  set tool_iteration_list = ($O_GEN_VER $O_JLS_VER $O_CFRML_VER $O_JG_VER $O_LIT1_VER)
  foreach tool_version ($tool_iteration_list)
    module unload $tool_version:h:h
    module load $tool_version
    if (`module info-loaded $tool_version` == "") then
      @ SETUP_ERROR_COUNT = $SETUP_ERROR_COUNT + 1
    endif
  end
endif
if ($SETUP_ERROR_COUNT != 0) then
  echo "\nOmega tool version setup status: FAIL. One or more tool modules failed to load. Request IT to add failing modules"
else
  echo "\nOmega tool version setup status: PASS"
endif
