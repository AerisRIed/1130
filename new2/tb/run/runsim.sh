#!/bin/sh
#
# ----------------------------------------------------------------------
# NOTE: run_vdebug (waveform viewer script) will be generated inside the
# results directory after the script creates and cds into it. See below.
# ----------------------------------------------------------------------


if [ $# -lt 1 ]
then
   exit
fi

if [ $1 = "help" ]
then
   echo "Command line format = runsim.sh <test name without the .v> <option1> <option2> ..."
   echo "Options:"
   echo "no_waves - Default is for the sim to dump waves.  This option prevents this."
   echo "speedup - Default is to run without speedup configured.  This option enables sim speedup mode."
   echo "relpathdotf - Default is to use file lists with full path references.  This option enables use of relative path file lists."
   # echo "mbncn: mp_basic_reduced - Reduced Raw + basic PIPE."
   # echo "msnfn: mp_ss_full - Full Raw + SS PIPE."
   # echo "msncn: mp_ss_reduced - Reduced Raw + SS PIPE."
   # echo "pbn: pipe_basic - Basic PIPE only."
   # echo "psn: pipe_ss - SS PIPE only."
   # echo "rfn: raw_full - Full Raw only."
   # echo "rcn: raw_reduced - Reduced Raw only."
   echo "The default PHY configuration is Full Raw + basic PIPE."
   echo "lps - Default is to run without low power.  This option enables running with low power. "
   echo "auto - Sets PCIe auto configuration define."
   echo "pg_pins - Default is for the design to not have power/ground pins. This option includes the power/ground pins."
   echo "gates < min | max | typ | zero > - Default is to run rtl."
   echo "The default is a 4-lane PHY/PMA in a 22 configuration.  Other PHY/PMA configurations are selected"
   echo "     with 10, 11, 44, 55, 66, 80 and 88 options."
   exit
fi

TC_NAME="$1"
export TC_NAME
TC_LOG_NAME=${TC_NAME}

# Build output directory from all script arguments joined by underscores
# If no additional args, use TC_NAME; sanitize spaces to underscores
ARGS_JOINED="$(printf "%s_" "$@" | sed 's/ $//; s/\s\+/_/g' | sed 's/_$//')"
if [ -z "$ARGS_JOINED" ]; then
   ARGS_JOINED="$TC_NAME"
fi
# Replace any characters that are unsafe for filenames with underscore
OUTPUT_DIR="results_$(echo "$ARGS_JOINED" | sed 's/[^A-Za-z0-9._-]/_/g')"
mkdir -p "$OUTPUT_DIR"
echo "Results will be written to: $OUTPUT_DIR"

# XRUN log path inside output directory
XRUN_LOG="xrun.log"

# Change into the output directory so the remainder of the script runs there
pushd "$OUTPUT_DIR" >/dev/null

# Remember original working directory in case we need absolute paths
ORIG_PWD="$(pwd -P)"

# ----------------------------------------------------------------------
# Generate Verisium waveform viewer script inside the results directory
# ----------------------------------------------------------------------
VIEW_SCRIPT_NAME="run_vdebug.sh"

echo "#!/bin/sh" > $VIEW_SCRIPT_NAME
echo 'SCRIPT_DIR="$(cd "$(dirname "$0")" && pwd)"' >> $VIEW_SCRIPT_NAME
echo 'cd "$SCRIPT_DIR"' >> $VIEW_SCRIPT_NAME
echo 'bsub -I -q verif_eusb2v2 -R "OSNAME==Linux && (OSREL>=EE80)" verisium -lwd "$SCRIPT_DIR/xcelium.d" -wave_db "$SCRIPT_DIR/waveform_rtl.shm" &' >> $VIEW_SCRIPT_NAME
chmod +x $VIEW_SCRIPT_NAME
echo "Waveform viewer script generated: ./$VIEW_SCRIPT_NAME"

if [ -f $TC_LOG_NAME.PASS ]
then
   rm $TC_LOG_NAME.PASS
fi
if [ -f $TC_LOG_NAME.FAIL ]
then
   rm $TC_LOG_NAME.FAIL
fi

# LN_CFG=11
LPS_ENABLE=0

# =============================================================================
# determine if in release environment (vs development environment)
# and adapt some variables according to current environment
# =============================================================================

USE_RELPATH_DOTF=0
if pwd | grep -E "/func_ver/sanity/"; then
IS_RELEASE=1
else 
IS_RELEASE=0
fi
echo $IS_RELEASE
export IS_RELEASE

PHY_DOT_F_FILE="-f $PHY_DESIGN_AREA/design/filelist/output/timberwolf_phy_hlm_sim.f" #TODO for different branch
TC_LOG_NAME=${TC_NAME}_mbnfn
DEFINES_ARG=" -define CDN_TESTCHIP_UC_DBGR -define CDN_MP_PHY_UC_ECC_EN -define CND_UCTLR_DUAL_PORT_RAM   " # -define CDN_MPPHY_RMV_DTB
DEFINES_ARG+=' -define CDNS_PHY_PWR_AWARE '
DEFINES_ARG+=' -define LM_DEP_OPTION '
DEFINES_ARG+=' -define MP_128B_PATH '
DEFINES_ARG+=' -define MP_128B_PATH_32_BIT '
DEFINES_ARG+=' -define MP_USB '
# DEFINES_ARG+=' -define MP_PCIE '
DEFINES_ARG+=' -define MP_USB3_2 '
DEFINES_ARG+=' -define MP_RATE_CHG_A2_EN '

while [ $# -gt 1 ]; do
   case $2 in
      no_waves) TB_SANITY_WAVES="-define DISABLE_WAVES"
      export TB_SANITY_WAVES
      ;;
      speedup) TB_SPEEDUP="-define CDN_SIM_SPEEDUP "
      export TB_SPEEDUP
      ;;
      # auto) TB_AUTO_PCIE_CFG="-define CDN_MPPHY_PCIE_AUTO_CFG"
      # export TB_AUTO_PCIE_CFG
      # ;;
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
      gates) shift
      SDF_TYPE="$2"
      NETLIST_TYPE="gates"
      ;;
      hlm) PHY_DOT_F_FILE="-f $PHY_DESIGN_AREA/design/filelist/output/timberwolf_phy_hlm_sim.f"
      ;;
      mlm) PHY_DOT_F_FILE="-f $PHY_DESIGN_AREA/design/filelist/output/timberwolf_phy_mlm_sim.f"
      ;;
      jump_rxdet) DEFINES_ARG+=" -define JUMP_RXDET "
      ;;
      dp_only) DEFINES_ARG+=" -define DP_ONLY "
      ;;
      1lane)    DEFINES_ARG+=" -define X1_LANE " 
      ;;
      2lane)    DEFINES_ARG+=" -define X2_LANE " 
      ;;
      4lane)    DEFINES_ARG+=" -define X4_LANE " 
      ;;
      gen1)     DEFINES_ARG+=" -define GEN1    " 
      ;;
      gen2)     DEFINES_ARG+=" -define GEN2    " 
      ;;
      gen3)     DEFINES_ARG+=" -define GEN3    " 
      ;; 
      uhbr20)   DEFINES_ARG+=" -define UHBR20  " 
      ;;
      uhbr13p5) DEFINES_ARG+=" -define UHBR13P5" 
      ;;
      uhbr10)   DEFINES_ARG+=" -define UHBR10  " 
      ;;
      hbr3)     DEFINES_ARG+=" -define HBR3    " 
      ;;
      hbr2)     DEFINES_ARG+=" -define HBR2    " 
      ;;
      hbr)      DEFINES_ARG+=" -define HBR     " 
      ;;
      rbr)      DEFINES_ARG+=" -define RBR     " 
      ;;
      pwr_switch_test)  DEFINES_ARG+=" -define PWR_SWITCH_TEST   "
      ;;
      # mbncn) PHY_DOT_F_FILE="-f $PHY_RTL_HOME/mp_phy_top/cdn_sd0801mbncn.f"
      # TC_LOG_NAME=${TC_NAME}_mbncn
      # ;;
      # msnfn) PHY_DOT_F_FILE="-f $PHY_RTL_HOME/mp_phy_top/cdn_sd0801msnfn.f"
      # TC_LOG_NAME=${TC_NAME}_msnfn
      # ;;
      # msncn) PHY_DOT_F_FILE="-f $PHY_RTL_HOME/mp_phy_top/cdn_sd0801msncn.f"
      # TC_LOG_NAME=${TC_NAME}_msncn
      # ;;
      # pbn) PHY_DOT_F_FILE="-f $PHY_RTL_HOME/mp_phy_top/cdn_sd0801pbn.f"
      # TC_LOG_NAME=${TC_NAME}_pbn
      # ;;
      # psn) PHY_DOT_F_FILE="-f $PHY_RTL_HOME/mp_phy_top/cdn_sd0801psn.f"
      # TC_LOG_NAME=${TC_NAME}_psn
      # ;;
      # rfn) PHY_DOT_F_FILE="-f $PHY_RTL_HOME/mp_phy_top/cdn_sd0801rfn.f"
      # TC_LOG_NAME=${TC_NAME}_rfn
      # ;;
      # rcn) PHY_DOT_F_FILE="-f $PHY_RTL_HOME/mp_phy_top/cdn_sd0801rcn.f"
      # TC_LOG_NAME=${TC_NAME}_rcn
      # ;;
      # slave) PHY_CLOCK_CFG="$PHY_RTL_HOME/tb_mp_phy/tb_slave_only_defines.v"
      # ;;
      # master) PHY_CLOCK_CFG="$PHY_RTL_HOME/tb_mp_phy/tb_master_only_defines.v"
      # ;;
      # 10) LN_CFG=10
      # ;;
      # 22) LN_CFG=22
      # ;;
      # 44) LN_CFG=44
      # ;;
      lps) LPS_ENABLE=1
      ;;
      cov) TB_COVERAGE="-coverage all -covtest $1 -covoverwrite -covdut ${PHY_DEFINE}"
      export TB_COVERAGE
      ;;
   esac
   shift
done

# export LN_CFG

# PMA_DEFINE=SD0801_UMC14FFC_${LN_CFG}_VF162_1P9M4I1E1UAL28KPASV19K
# PHY_DEFINE=SD0801MSNFNX_UMC14FFC_${LN_CFG}_VF162_1P9M4I1E1UAL28KPASV19K
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
   DEFINES_ARG+="-define IS_RELEASE"
   UPF_HOME="$RTL_HOME/cdn_${pma_name_lc}/pwr_intent/upf"
   UPF_TOP="cdn_${pma_name_lc}.upf"
   LIB_MFILE="$TBSANITY_HOME/tb/lib_mfile_${LN_CFG}_release.txt"
   if [ "$NETLIST_TYPE" = "gates" ]; then
      GATESIM_ARGS="-define CDN_GATE_SIM \
	            -vlog_ext +.vg -sysv_ext +.v \
                    -64bit -nontcglitch"
      PHY_DOT_F_FILE="-f $RTL_HOME/cdn_${phy_name_lc}/hdl/hdl_src/cdn_${phy_name_lc}_rtl_pcs.f"
      # PMA_DOT_F_FILE="-f $RTL_HOME/cdn_${pma_name_lc}/hdl/behav_src/cdn_${pma_name_lc}_ana_behav.f"
      TFILES="-tfile $RTL_HOME/cdn_${pma_name_lc}/func_ver/gatesim/tcheck_sync_setuphold_to_ignore_cdn_${pma_name_lc}.tfile \
              -tfile $RTL_HOME/cdn_${pma_name_lc}/func_ver/gatesim/tcheck_sync_recrem_to_ignore_cdn_${pma_name_lc}.tfile"
      SDF_ARGS="-define SDF -sndefine SDF +sdf_verbose +neg_tchk -define NTC \
                $TFILES"
      if [ "$LPS_ENABLE" -eq 1 ]; then
	  # non-physical gates
	  GATES_DOT_F_FILE="-f $RTL_HOME/cdn_${phy_name_lc}/func_ver/sanity/tb/gatesim_setup.f \
                            -f $RTL_HOME/cdn_${pma_name_lc}/func_ver/gatesim/clock_div_override_cdn_${pma_name_lc}.f"
      else
	  # physical gates
	  GATES_DOT_F_FILE="-f $RTL_HOME/cdn_${phy_name_lc}/func_ver/sanity/tb/gatesim_setup_power.f \
                            -f $RTL_HOME/cdn_${pma_name_lc}/func_ver/gatesim/clock_div_override_cdn_${pma_name_lc}.f"
          DEFINE_PWR_GND_PINS="-define CDNS_PHY_PWR_AWARE -define CDNS_PMA_PWR_AWARE"
      fi
   else
      PMA_DOT_F_FILE=""
      if [ $USE_RELPATH_DOTF -eq 1 ]; then
         PHY_DOT_F_FILE="-F $RTL_HOME/cdn_${phy_name_lc}/hdl/hdl_src/cdn*_top_relpath.f"
      else
         PHY_DOT_F_FILE="-f $RTL_HOME/cdn_${phy_name_lc}/hdl/hdl_src/cdn*_top.f"
      fi
      DEFINES_ARG+="-notimingchecks"
   fi
else
   # development environment
   # PMA_DOT_F_FILE="-f $PHY_DESIGN_AREA/design/filelist/timberwolf_pma_hlm.f"
   TBSANITY_HOME="$PHY_DESIGN_AREA/design/tb"
   UPF_HOME="$PMA_RTL_HOME/../constraints"
   UPF_TOP="pma${LN_CFG}.upf"
   LIB_MFILE="$TBSANITY_HOME/scripts/lib_mfile_internal.txt"
   DEFINES_ARG+="-notimingchecks"
fi
export TBSANITY_HOME
# export PMA_DOT_F_FILE
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
   LPS_DEF="$LPS_DEF -nowarn PDNTMCG -nowarn BPTNCON -xmwarn NOISELE -xmwarn ILOBJUE"
   if [ "$NETLIST_TYPE" = "gates" ]; then
      LPS_DEF="$LPS_DEF -lps_iso_off -lps_rtn_off"
   fi
fi

if [ "$SDF_TYPE" = "max" ]; then
  SDF_ARGS="$SDF_ARGS +maxdelays +ncmaxdelays -define SDF_TYPE_MAX -sndefine SDF_TYPE_MAX"
elif [ "$SDF_TYPE" = "min" ]; then
  SDF_ARGS="$SDF_ARGS +mindelays +ncmindelays -define SDF_TYPE_MIN -sndefine SDF_TYPE_MIN"
elif [ "$SDF_TYPE" = "typ" ]; then
  SDF_ARGS="$SDF_ARGS +maxdelays +ncmaxdelays -define SDF_TYPE_TYP -sndefine SDF_TYPE_TYP"
fi
export SDF_ARGS

ln -sf $TBSANITY_HOME/test/testlib/$TC_NAME.sv test_main.sv

bsub -I -q verif_eusb2v2 -R "OSNAME==Linux && (OSREL>=EE80)"\
      xrun  \
      ${DEFINES_ARG} \
      $GATESIM_ARGS \
      $SDF_ARGS \
      +access+rwc \
      $TB_SPEEDUP_DISABLE \
      $TB_SPEEDUP_SCNT \
      $TB_SPEEDUP_ECNT \
      $TB_SANITY_WAVES \
      $TB_SPEEDUP \
      $TB_COVERAGE \
      $LPS_DEF \
      $PHY_DOT_F_FILE \
      $GATES_DOT_F_FILE \
      $DEFINE_PWR_GND_PINS \
      -f $PHY_DESIGN_AREA/design/tb/filelist/filelist.f \
      -top tb_top \
      -timescale 1ns/100ps \
      -ALLOWREDEFINITION \
      -debug \
      -linedebug \
   -lwdgen \
   -sv \
   -seed -1603536716 \
   -l $XRUN_LOG
      # -define ${PMA_DEFINE} \
      # -define META_SYNC_DISABLE \
      # $PMA_DOT_F_FILE \
      # $TB_AUTO_PCIE_CFG \
      # $PHY_CLOCK_CFG \
      # -define ABV_ON \
      # -nowarn CUVWSP \
      # -nowarn PDNTMCG \
      # -nowarn ILIOPT \


if grep "ERROR" "$XRUN_LOG"; then
   mv "$XRUN_LOG" "${TC_LOG_NAME}.FAIL"
elif grep "*F" "$XRUN_LOG"; then
   mv "$XRUN_LOG" "${TC_LOG_NAME}.FAIL"
elif grep "*E" "$XRUN_LOG"; then
   mv "$XRUN_LOG" "${TC_LOG_NAME}.FAIL"
else
   mv "$XRUN_LOG" "${TC_LOG_NAME}.PASS"
fi

# Return to original directory
popd >/dev/null
# rm test_main.v
