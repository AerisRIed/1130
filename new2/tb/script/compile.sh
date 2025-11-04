#!/bin/sh
#
if [ "$1" = "help" ]
then
   echo "Command line format = compile.sh <option1> <option2> ..."
   echo "Options:"
   echo "no_waves - Default is for the sim to dump waves.  This option prevents this."
   echo "speedup - Default is to run without speedup configured.  This option enables sim speedup mode."
   echo "relpathdotf - Default is to use file lists with full path references.  This option enables use of relative path file lists."
   echo "mbncn: mp_basic_reduced - Reduced Raw + basic PIPE."
   echo "msnfn: mp_ss_full - Full Raw + SS PIPE."
   echo "msncn: mp_ss_reduced - Reduced Raw + SS PIPE."
   echo "pbn: pipe_basic - Basic PIPE only."
   echo "psn: pipe_ss - SS PIPE only."
   echo "rfn: raw_full - Full Raw only."
   echo "rcn: raw_reduced - Reduced Raw only."
   echo "The default PHY configuration is Full Raw + basic PIPE."
   echo "lps - Default is to run without low power.  This option enables running with low power. Only valid for 11 or 22 configuration"
   echo "pg_pins - Default is for the design to not have power/ground pins. This option includes the power/ground pins."
   echo "The default is a 4-lane PHY/PMA in a 22 configuration.  Other PHY/PMA configurations are selected"
   echo "     with 10, 11, 44, 55, 66, 80 and 88 options."
   exit
fi

TC_NAME="tc_basic_loopback_usb"
export TC_NAME
TC_LOG_NAME=${TC_NAME}

if [ -f $TC_LOG_NAME.PASS ]
then
   rm $TC_LOG_NAME.PASS
fi
if [ -f $TC_LOG_NAME.FAIL ]
then
   rm $TC_LOG_NAME.FAIL
fi

LN_CFG=22
LPS_ENABLE=0

# =============================================================================
# determine if in release environment (vs development environment)
# and adapt some variables according to current environment
# =============================================================================

USE_RELPATH_DOTF=0
IS_RELEASE=1
echo $IS_RELEASE
export IS_RELEASE

PHY_DOT_F_FILE="-f $PHY_RTL_HOME/mp_phy_top/cdn_sd0801mbnfn.f"
TC_LOG_NAME=${TC_NAME}_mbnfn
DEFINES_ARG=""

while [ $# -ne 0 ]; do
   case $1 in
      no_waves) TB_SANITY_WAVES="-define DISABLE_WAVES"
      export TB_SANITY_WAVES
      ;;
      speedup) TB_SPEEDUP="-define CDN_SIM_SPEEDUP -define CDN_ANA_DPI_TAU_SPEEDUP"
      export TB_SPEEDUP
      ;;
      relpathdotf) USE_RELPATH_DOTF=1
      ;;
      speedup_disable) TB_SPEEDUP_DISABLE="-define CDNS_LM_DISABLE_SPEEDUP"
      export TB_SPEEDUP_DISABLE
      ;;
      speedup_scnt) TB_SPEEDUP_SCNT="-define CDNS_LM_SCNT_SPEEDUP"
      export TB_SPEEDUP_SCNT
      ;;
      speedup_ecnt) TB_SPEEDUP_ECNT="-define CDNS_LM_ECNT_SPEEDUP"
      export TB_SPEEDUP_ECNT
      ;;
      pg_pins) DEFINE_PWR_GND_PINS="-define CDNS_PHY_PWR_AWARE -define CDNS_PMA_PWR_AWARE"
      ;;
      mbncn) PHY_DOT_F_FILE="-f $PHY_RTL_HOME/mp_phy_top/cdn_sd0801mbncn.f"
      TC_LOG_NAME=${TC_NAME}_mbncn
      ;;
      msnfn) PHY_DOT_F_FILE="-f $PHY_RTL_HOME/mp_phy_top/cdn_sd0801msnfn.f"
      TC_LOG_NAME=${TC_NAME}_msnfn
      ;;
      msncn) PHY_DOT_F_FILE="-f $PHY_RTL_HOME/mp_phy_top/cdn_sd0801msncn.f"
      TC_LOG_NAME=${TC_NAME}_msncn
      ;;
      pbn) PHY_DOT_F_FILE="-f $PHY_RTL_HOME/mp_phy_top/cdn_sd0801pbn.f"
      TC_LOG_NAME=${TC_NAME}_pbn
      ;;
      psn) PHY_DOT_F_FILE="-f $PHY_RTL_HOME/mp_phy_top/cdn_sd0801psn.f"
      TC_LOG_NAME=${TC_NAME}_psn
      ;;
      rfn) PHY_DOT_F_FILE="-f $PHY_RTL_HOME/mp_phy_top/cdn_sd0801rfn.f"
      TC_LOG_NAME=${TC_NAME}_rfn
      ;;
      rcn) PHY_DOT_F_FILE="-f $PHY_RTL_HOME/mp_phy_top/cdn_sd0801rcn.f"
      TC_LOG_NAME=${TC_NAME}_rcn
      ;;
      slave) PHY_CLOCK_CFG="$PHY_RTL_HOME/tb_mp_phy/tb_slave_only_defines.v"
      ;;
      master) PHY_CLOCK_CFG="$PHY_RTL_HOME/tb_mp_phy/tb_master_only_defines.v"
      ;;
      10) LN_CFG=10
      ;;
      11) LN_CFG=11
      ;;
      44) LN_CFG=44
      ;;
      lps) LPS_ENABLE=1
      ;;
      cov) TB_COVERAGE="-coverage all -covtest $1 -covoverwrite -covdut ${PHY_DEFINE}"
      export TB_COVERAGE
      ;;
   esac
   shift
done

export LN_CFG
PMA_DEFINE=SD0801_UMC14FFC_${LN_CFG}_VF162_1P9M4I1E1UAL28KPASV19K
PHY_DEFINE=SD0801MSNFNX_UMC14FFC_${LN_CFG}_VF162_1P9M4I1E1UAL28KPASV19K
export PMA_DEFINE
export PHY_DEFINE

# Need phy module name
phy_name_lc=`echo $PHY_DEFINE | tr A-Z a-z`
pma_name_lc=`echo $PMA_DEFINE | tr A-Z a-z`

if [ $IS_RELEASE -eq 1 ]; then
   # release environment
   # may be relative path
   COMPILATION_ROOT_DIR=`dirname $0`
   # ensure absolute path
   COMPILATION_ROOT_DIR=`cd ${COMPILATION_ROOT_DIR} && readlink -e .`
   echo "COMPILATION_ROOT_DIR = ${COMPILATION_ROOT_DIR}"
   RTL_HOME=`echo ${COMPILATION_ROOT_DIR} | sed 's/func_ver\/sanity.*/\.\./'`
   TBSANITY_HOME="$RTL_HOME/cdn_${phy_name_lc}/func_ver/sanity"
   TBSANITY_INCDIR_HOME="$TBSANITY_HOME/tb"
   export RTL_HOME
   export TBSANITY_HOME
   export TBSANITY_INCDIR_HOME
   DEFINES_ARG="-define IS_RELEASE"
   UPF_HOME="$RTL_HOME/cdn_${pma_name_lc}/pwr_intent/upf"
   UPF_TOP="cdn_${pma_name_lc}.upf"
   LIB_MFILE="$TBSANITY_HOME/tb/lib_mfile_${LN_CFG}_release.txt"
      PMA_DOT_F_FILE=""
      if [ $USE_RELPATH_DOTF -eq 1 ]; then
         PHY_DOT_F_FILE="-F $RTL_HOME/cdn_${phy_name_lc}/hdl/hdl_src/cdn*_top_relpath.f"
      else
         PHY_DOT_F_FILE="-f $RTL_HOME/cdn_${phy_name_lc}/hdl/hdl_src/cdn*_top.f"
      fi
      DEFINES_ARG+="-notimingchecks"
fi
export TBSANITY_HOME
export PMA_DOT_F_FILE
export PHY_DOT_F_FILE
export UPF_HOME
export UPF_TOP
export DEFINES_ARGS

LPS_DEF=
if [ $LPS_ENABLE -eq 1 ]; then
   LPS_DEF="-lps_1801 $TBSANITY_HOME/tb/tb_sanity.upf"
   LPS_DEF="$LPS_DEF -define CDNS_PMA_UPF_ENABLED"
   LPS_DEF="$LPS_DEF -lps_relax_1801 -lps_dbc -lps_lib_mfile $LIB_MFILE -lps_lib_verbose 1"
   LPS_DEF="$LPS_DEF -nowarn MULTISO -nowarn LGCYWRN -nowarn PRTNCON"
   LPS_DEF="$LPS_DEF -nowarn PDNTMCG -nowarn BPTNCON  "
   if [ "$NETLIST_TYPE" = "gates" ]; then
      LPS_DEF="$LPS_DEF -lps_iso_off -lps_rtn_off"
   fi
fi

cp $TBSANITY_HOME/tests/$TC_NAME.v testcase.v

xrun  -c -define ${PMA_DEFINE} \
      -define META_SYNC_DISABLE \
      -define ABV_ON \
      ${DEFINES_ARG} \
      +access+rwc \
      $TB_SPEEDUP_DISABLE \
      $TB_SPEEDUP_SCNT \
      $TB_SPEEDUP_ECNT \
      $TB_SANITY_WAVES \
      $TB_SPEEDUP \
      $TB_COVERAGE \
      $LPS_DEF \
      $PHY_CLOCK_CFG \
      $PHY_DOT_F_FILE \
      $PMA_DOT_F_FILE \
      $DEFINE_PWR_GND_PINS \
      -f $TBSANITY_HOME/tb/tb_sanity.f  \
      -timescale 1ns/100ps \
      -nowarn CUVWSP \
      -nowarn PDNTMCG \
      -nowarn ILIOPT \
      -ALLOWREDEFINITION

if grep "ERROR" "xrun.log"; then
   mv xrun.log $TC_LOG_NAME.FAIL
else
if grep "*F" "xrun.log"; then
   mv xrun.log $TC_LOG_NAME.FAIL
else
if grep "*E" "xrun.log"; then
   mv xrun.log $TC_LOG_NAME.FAIL
else
   mv xrun.log $TC_LOG_NAME.PASS
fi
fi
fi
rm testcase.v
