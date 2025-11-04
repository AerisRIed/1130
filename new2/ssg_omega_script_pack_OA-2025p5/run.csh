#!/bin/csh -f

# Usage: ./run.csh <lint|cdc> [clean] | setup | clean
# Allowed arguments only: setup lint cdc clean
# Rules:
#   lint  : runs SuperLint; may combine with clean (lint clean) - automatically calls setup
#   cdc   : runs CDC; may combine with clean (cdc clean) - automatically calls setup
#   clean : alone -> remove all jasper_* run directories; with lint/cdc -> remove corresponding dirs before run
# Examples:
#   ./run.csh lint
#   ./run.csh cdc clean
#   ./run.csh clean
# Any other argument results in an error and exit.
# Host-based queue selection logic is reused for both lint and cdc modes.

if ( $#argv == 0 ) then
    echo "[ERROR] No arguments provided."
    echo "Usage: $0 <lint|cdc> [clean] | setup | clean"
    echo "Examples:";
    echo "  $0 lint";
    echo "  $0 cdc clean";
    echo "  $0 clean";
    echo "  $0 setup";
    exit 1
endif

set mode="lint"
set do_clean=0
set do_setup=0
set mode_explicit=0

# Argument parsing - order insensitive; first lint/cdc decides mode; clean may appear once; setup must be alone
foreach arg ( $argv )
    if ( "$arg" == "lint" ) then
        if ( $do_setup ) then
            echo "[ERROR] setup cannot be combined with lint/cdc."
            exit 2
        endif
        set mode="lint"
        set mode_explicit=1
    else if ( "$arg" == "cdc" ) then
        if ( $do_setup ) then
            echo "[ERROR] setup cannot be combined with lint/cdc."
            exit 2
        endif
        set mode="cdc"
        set mode_explicit=1
    else if ( "$arg" == "clean" ) then
        set do_clean=1
    else if ( "$arg" == "setup" ) then
        if ( $mode_explicit || $do_clean ) then
            echo "[ERROR] setup must be used alone."
            exit 2
        endif
        set do_setup=1
    else
    echo "[ERROR] Invalid argument '$arg'. Allowed: setup lint cdc clean"
        exit 1
    endif
end

if ( $do_setup ) then
    goto setup_environment
endif

# Cleaning logic
if ( $do_clean ) then
    if ( "$#argv" == 1 && "$argv[1]" == "clean" ) then
        echo "[INFO] Cleaning all jasper run directories (cdc + superlint)."
        rm -rf jasper_cdc_run*
        rm -rf jasper_superlint_run*
        if ( $mode_explicit == 0 ) then
            echo "[INFO] Clean-only done, exiting."
            exit 0
        endif
    else
        if ( "$mode" == "cdc" ) then
            echo "[INFO] Cleaning CDC jasper run directories before submission."
            rm -rf jasper_cdc_run*
        else if ( "$mode" == "lint" ) then
            echo "[INFO] Cleaning SuperLint jasper run directories before submission."
            rm -rf jasper_superlint_run*
        endif
    endif
endif

if ( $mode_explicit == 0 ) then
    echo "[INFO] No lint/cdc mode specified."
    exit 13
endif

# Automatically call setup environment for lint/cdc operations
echo "[INFO] Automatically calling setup before ${mode} execution..."
goto setup_environment
continue_execution:

# (Legacy unconditional CDC cleanup removed; replaced by conditional above.)

set app="superlint"
if ("$mode" == "cdc") then
    set app="cdc"
endif

if(${HOST} =~ "noi*") then
    if ("$mode" == "lint") then
        bsub -q int_work ./scripts/core/jasper/common/RunJasper.pl -app ${app} -gui &
    else
        bsub -q int_work ./scripts/core/jasper/common/RunJasper.pl -app ${app} -gui &
    endif
else if(${HOSTNAME} =~ "kdt*") then
    bsub -Is -q normal ./scripts/core/jasper/common/RunJasper.pl -app ${app} -gui &
else
    # Fallback if HOST/HOSTNAME pattern not matched
    bsub -Is -q normal ./scripts/core/jasper/common/RunJasper.pl -app ${app} -gui &
endif

echo "Submitted Jasper job for mode='${mode}' app='${app}' (setup=${do_setup} clean=${do_clean})"
exit 0

# Setup environment task
setup_environment:
echo "[INFO] Performing environment setup..."
set orig_dir=`pwd`
# Replicate setup.csh steps
cd ../../../
if ( $status != 0 ) then
    echo "[ERROR] Failed to cd to repository root (../../../)."
    exit 10
endif
if ( -e sourceme.csh ) then
    source /etc/profile.d/modules.csh
    source sourceme.csh
else
    echo "[WARN] sourceme.csh not found at expected location; continuing."
endif
sleep 1
cd $orig_dir
if ( $status != 0 ) then
    echo "[ERROR] Failed to return to original script directory: $orig_dir"
    exit 11
endif
if ( $?MODULESHOME ) then
    module unload jasper
endif
unalias module
if ( -e ./scripts/core/common/omega_tool_setup.sh ) then
    source ./scripts/core/common/omega_tool_setup.sh
    if ( $status != 0 ) then
        echo "[ERROR] omega_tool_setup.sh returned non-zero status=$status"
        exit $status
    endif
else
    echo "[ERROR] omega_tool_setup.sh not found (./scripts/core/common/omega_tool_setup.sh)"
    exit 12
endif
echo "[INFO] Environment setup completed."

if ( $do_setup ) then
    echo "[INFO] Setup-only mode completed, exiting."
    exit 0
else
    goto continue_execution
endif


