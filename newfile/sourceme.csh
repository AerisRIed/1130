#!/bin/tcsh -f
#----------------------------------------------------------------------
#
#  Base Sourceme that calls the design and verification 
# 
#
#----------------------------------------------------------------------
setenv PROJ_NAME           Timberwolf_U4
setenv PHY_WORK_AREA       $PWD
setenv PHY_DESIGN_AREA     ${PHY_WORK_AREA}/trunk
setenv PHY_VERIF_AREA      ${PHY_WORK_AREA}/verif
setenv PHY_IPXACT_HOME     ${PHY_VERIF_AREA}/reg_model/ipxact
setenv PHY_UPF_DIR         ${PHY_DESIGN_AREA}/upf
setenv PHY_SCRIPTS_DIR     ${PHY_VERIF_AREA}/scripts
setenv VM_DIR              ${PHY_VERIF_AREA}/vm
setenv VPLAN_DIR           ${PHY_VERIF_AREA}/vplan
setenv VUNIT_DIR           ${PHY_VERIF_AREA}/vunit
setenv PHY_AGENT_AREA      ${PHY_VERIF_AREA}/agent
setenv COVERAGE_DIR        ${PHY_VERIF_AREA}/coverage
setenv PMA_HLM_HOME        ${PHY_DESIGN_AREA}/design/reuse/pma/models/hlm
setenv PMA_MLM_HOME        ${PHY_DESIGN_AREA}/design/reuse/pma/models/mlm
setenv PMA_REUSE_HOME      ${PHY_DESIGN_AREA}/design/reuse/pma/reuse
setenv PMA_RTL_HOME        ${PHY_DESIGN_AREA}/design/reuse/pma/rtl
setenv CDNSDRU_DIR         ${PHY_DESIGN_AREA}/design/reuse/pma/reuse
setenv CDN_VIP_LIB_PATH    ${PHY_VERIF_AREA}/u4_vip/examples/multiProtocol/uvmConfigPipeExamplePhyDut/vip_lib
setenv DENALIRC            ${PHY_VERIF_AREA}/u4_vip/denalirc_dir
#For unr scripts
setenv UNR_GROUP_SEL data_path_b2b_group
#PMA

if(${HOST} =~ "noi*") then
#-------------------------------------------------------------------------------------------------
# Loading Verification Modules
#-------------------------------------------------------------------------------------------------
    module unload python
    module unload git
    module unload vipcat
    module unload ius 
    module unload incisiv 
    module unload incisive    
    module unload mdv
    module unload xcelium
    module unload jasper
    module unload spectre
    module unload vmanager

    module load python/3.7.0
    module load git/2.31.1
    module load vipcat/113/11.30.106
    module load xceliumml/2503/25.03.002
    module load xcelium/2503/25.03.001
    module load vdebug/2503/25.03.001
    module load jasper/2503/25.03.001
    module load vmanager/2503/25.03.001
    #module load vapps/2503/25.03.001
    
    #For wrun
    setenv WRUN_DIR /home/zbyin/wrun_v0r2_temp/FE_DV_sources/wrun/
    alias wrun      '/grid/common/pkgs/python/v3.7.0/bin/python3 -B /home/zbyin/wrun_v1r0_temp/FE_DV_sources/wrun/wrun_core.py'
    alias wrun_beta '/grid/common/pkgs/python/v3.7.0/bin/python3 -B /home/zbyin/wrun_beta/FE_DV_sources/wrun/wrun_core.py'

     # Regressions
    setenv REGRESSION_AREA       /projects/sd3101_n4p/users/${USER}/Regression_dir/${PROJ_NAME}
    setenv VM_SERVER             noivld-ssenjdv:3333
    setenv LSF_VMGR_QUEUE        'int_work -R "OSNAME==Linux && (OSREL>=EE80)"'
    setenv LSF_REGRESSION_QUEUE  'lnx64 -R "OSNAME==Linux && (OSREL>=EE80)"'
    setenv JENKINS_SERVER        noivld-ssenjdv:8080

    setenv CDN_VIP_ROOT        /apps/ssg_tools/production/vipcat/113/11.30.106
    setenv MDV_XLM_HOME        /apps/ssg_tools/production/xcelium/2503/25.03.001
    setenv VMGR_HOME           /apps/ssg_tools/production/vmanager/2503/25.03.001
   

else if(${HOSTNAME} =~ "kdt*") then
#-------------------------------------------------------------------------------------------------
# Loading Verification Modules
#-------------------------------------------------------------------------------------------------

    module unload python
    module unload git
    module unload vipcat
    module unload ius 
    module unload incisiv 
    module unload incisive    
    module unload mdv
    module unload xcelium
    module unload jasper
    module unload spectre
    module unload vmanager

    # module load python/3.8.1
    module load python/3.7.0 #for yaml
    module load git/2.31.1
    module load vipcat/113/11.30.106
    module load xceliumml/2503/25.03.002
    module load xcelium/2503/25.03.001
    module load vdebug/2503/25.03.001
    module load jasper/2503/25.03.001
    module load vmanager/2503/25.03.001

    #For wrun
    setenv WRUN_DIR /rscratch/general/wrun/wrun_v0r2/FE_DV_sources/wrun/
    alias wrun      '/grid/common/pkgs/python/v3.7.0/bin/python3 -B /rscratch/general/wrun/wrun_v1r0/FE_DV_sources/wrun/wrun_core.py'
    alias wrun_beta '/grid/common/pkgs/python/v3.7.0/bin/python3 -B /rscratch/general/wrun/wrun_beta/FE_DV_sources/wrun/wrun_core.py'

    # Regressions
    if (${USER} == zhaoyuan) then
      setenv REGRESSION_AREA        /rscratch/general/yangzhaoyuan/Regression_dir/${PROJ_NAME}
    else 
      setenv REGRESSION_AREA        /rscratch/general/${USER}/Regression_dir/${PROJ_NAME}
    endif
    setenv VM_SERVER              kdt-farm02:6666
    setenv LSF_VMGR_QUEUE         'verif_eusb2v2 -R "OSNAME==Linux && (OSREL>=EE80)"'
    setenv LSF_REGRESSION_QUEUE   'verif_eusb2v2 -R "OSNAME==Linux && (OSREL>=EE80)"'
    setenv JENKINS_SERVER         kdtvld1-jenkins02:8089
 
    setenv CDN_VIP_ROOT        /apps/VIPCAT113/11.30.106
    setenv MDV_XLM_HOME        /apps/XCELIUM2503/25.03.001
    setenv VMGR_HOME           /apps/VMANAGER2503/25.03.001

endif

setenv REGRESS_AREA        ${REGRESSION_AREA}/results
setenv COVDB_AREA          ${REGRESSION_AREA}/covdb
setenv COVERAGE_AREA       ${REGRESSION_AREA}/coverage
setenv REPORT_AREA         ${REGRESS_AREA}/reports
setenv SNAPSHOT_DIR        ${REGRESSION_AREA}/libs

setenv CDS_ARCH            lnx86
setenv SPECMAN_PATH        ${CDN_VIP_ROOT}/packages:${CDN_VIP_LIB_PATH}/64bit

setenv UVM_HOME            ${MDV_XLM_HOME}/tools/methodology/UVM/CDNS-1.2/sv
setenv DENALI              ${CDN_VIP_ROOT}/tools.${CDS_ARCH}/denali_64bit
setenv PATH                ${MDV_XLM_HOME}/tools.${CDS_ARCH}/bin/64bit:${MDV_XLM_HOME}/tools.${CDS_ARCH}/systemc/gcc/bin:${MDV_XLM_HOME}/bin:${VMGR_HOME}/tools.${CDS_ARCH}/bin/64bit:${PATH}
setenv LD_LIBRARY_PATH     ${MDV_XLM_HOME}/tools.${CDS_ARCH}/lib64:${LD_LIBRARY_PATH}


setenv EXAMPLE_DIR         ${PHY_WORK_AREA}/multiProtocol/uvmConfigPipeExamplePhyDut
setenv CDN_USB4_VIP_TEST_NAME cdnUsb4UvmUserMultiProtTest
setenv PYTHONDONTWRITEBYTECODE 1
#----------------------------------------------------------------------
#
# aliases for verification
#
#----------------------------------------------------------------------
# Project Aliases
alias jenkins 'firefox http://${JENKINS_SERVER} &'

alias vplanner  'vplanner -64 -memlimit 16G -server ${VM_SERVER}'
alias vpls      '\vplanner -standalone -64 -memlimit 16G'
alias bvmanager  'bsub -Ip -q ${LSF_VMGR_QUEUE} vmanager -64 -memlimit 16G -admin -server ${VM_SERVER}'
alias bvmanager_daily  'bsub -Ip -q ${LSF_VMGR_QUEUE} vmanager -64 -memlimit 16G -admin -server ${VM_SERVER_DAILY}'
alias bvplanner  'bsub -Ip -q ${LSF_VMGR_QUEUE} vplanner -64 -memlimit 16G -server ${VM_SERVER}'
alias bvpls      'bsub -Ip -q ${LSF_VMGR_QUEUE} \vplanner -standalone -64'

# the following switch has been deprecated
#alias jg        'jg -expert_system'

alias vmake     'make -k -f ${PHY_SCRIPTS_DIR}/Makefile'
alias bvmake    'bsub -Ip -q ${LSF_VMGR_QUEUE} make -k -f ${PHY_SCRIPTS_DIR}/Makefile'
alias gunr      'source ${PHY_SCRIPTS_DIR}/unr/gen_unr.csh'

alias sp        'cd ${PHY_VERIF_AREA}/scripts'
alias tests     'cd ${PHY_VERIF_AREA}/tests'
alias vsif      'cd ${PHY_VERIF_AREA}/tests/regression'
alias vm        'cd ${PHY_VERIF_AREA}/vm'
alias cov       'cd ${PHY_WORK_AREA}/coverage'
alias ver       'cd ${PHY_VERIF_AREA}'
alias wk        'cd ${REGRESSION_AREA}/single_run/'
alias prj        'cd ${PHY_VERIF_AREA}/../'
alias pmar      'cd ${PMA_REUSE_HOME}'
alias hlm       'cd ${PHY_VERIF_AREA}/../trunk/design/reuse/pma/models/hlm'
alias mlm       'cd ${PHY_VERIF_AREA}/../trunk/design/reuse/pma/models/mlm'

#----------------------------------------------------------------------
#
# set pre checkin scripts
#
#----------------------------------------------------------------------
# --- Configuration: Set your target and link name here ---
set TARGET_FILE = "${PHY_SCRIPTS_DIR}/pre-push"
set LINK_NAME   = ".git/hooks/pre-push"

#echo "INFO: Sourcing script to manage symbolic link..."
#echo "      Target: $TARGET_FILE"
#echo "      Link:   $LINK_NAME"

# --- Action: Create the symbolic link ---
# The -f (force) option is crucial here. It ensures that if you source
# this script multiple times, it will overwrite the old link instead of
# failing. This makes the operation idempotent (safe to repeat).
ln -sf $TARGET_FILE $LINK_NAME

# --- Verification ---
# Check the exit status of the last command (`ln -sf`). 0 means success.
if ($status == 0) then
    echo "      SUCCESS: Link '$LINK_NAME' is correctly pointing to the target."
else
    echo "      ERROR: Failed to create symbolic link. Please check paths and permissions."
endif

# --- Cleanup: Unset temporary variables (good practice in sourced scripts) ---
unset TARGET_FILE
unset LINK_NAME

echo "INFO: Link management complete."

