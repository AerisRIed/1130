# Using JasperGold version jasper/2103/21.03.002
# Rehash Verification environment

# run command: jg -cdc cdn_jcdc.tcl

clear -all

#treat_boundaries_as_unclocked true
#treat_bbox_domain false

# ---------------------------------------------------------------------------------------------------------------------------------
# Modify below info based on your project
# ---------------------------------------------------------------------------------------------------------------------------------


set SUFFIX ""

# modify to target project
set TOP_MODULE  "cdn_sd3101x_n4p_22_vs130_1xah1xbv1xch1xdv1yah1ybv4yhvhv2z"

set RTL_F_FILE  "../filelist/output/timberwolf_phy_hlm_sim.f"
set PROJ_CONST  "constraint.tcl"
set WAIVERS     "waivers.tcl"

# ---------------------------------------------------------------------------------------------------------------------------------
# Read in the design
# ---------------------------------------------------------------------------------------------------------------------------------
analyze -sv \
        -F $RTL_F_FILE +define+META_SYNC_DISABLE+CDN_MPPHY_UC_ECC_EN+CDN_TESTCHIP_UC_DBGR
        #-F $RTL_F_FILE +define+META_SYNC_DISABLE +define+CDN_MPPHY_UC_ECC_EN +define+CDN_TESTCHIP_UC_DBGR

# ---------------------------------------------------------------------------------------------------------------------------------
# Elaborate the design
# ---------------------------------------------------------------------------------------------------------------------------------
elaborate -bbox_m {cmn_ana txm_ana rxtxm_ana} \
          -top $TOP_MODULE

# ---------------------------------------------------------------------------------------------------------------------------------
# Setup Phase 
#     static/Constant 
#     resets 
#     clocks
#     false path
#     waivers
#     ......
# ---------------------------------------------------------------------------------------------------------------------------------

# ---------------------------------------------------------------------------------------------------------------------------------
# CONSTRAINTS
# ---------------------------------------------------------------------------------------------------------------------------------
source $PROJ_CONST

# ---------------------------------------------------------------------------------------------------------------------------------
# WAIVERS
# ---------------------------------------------------------------------------------------------------------------------------------
source $WAIVERS


# ---------------------------------------------------------------------------------------------------------------------------------
# Tool Setup
# ---------------------------------------------------------------------------------------------------------------------------------
# Set relationships of all defined clocks
config_rtlds -rule -parameter {all_clocks_sync_by_default = false}

config_rtlds -rule -parameter {src_unit_domain = same} -domain CDC

#config_rtlds -rule -disable -tag CDC_PR_FOUT
#config_rtlds -rule -parameter {strict_ndff_detection = false}

# Clock domain detection
check_cdc -clock_domain -find

# ---------------------------------------------------------------------------------------------------------------------------------
# Perfrom CDC analysis
# ---------------------------------------------------------------------------------------------------------------------------------
check_cdc -pair -find
check_cdc -scheme -find
check_cdc -group -find
check_cdc -reset -find


####################################################################################################
# REPORT PHASE - REPORT GENERATION
# Only CSV reports are available at the current time.
# Tool enhancement expected in March release to support HTML, TXT and XML
#####################################################################################################
#print_report
#print_summary

check_cdc -report -violation -file ./jgproject/jcdc_violations_phy.csv -force    -grouping none  


# generate database
# check_cdc -export -database -file eusb.jdb -force
