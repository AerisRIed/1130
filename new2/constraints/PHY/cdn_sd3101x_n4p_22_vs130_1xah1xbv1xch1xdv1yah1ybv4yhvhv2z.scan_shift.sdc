#----------------------------------------------------------------------------
#----------------------------------------------------------------------------
#
# Copyright notice:
# "(c) 2017 Cadence Design System, Inc. All rights reserved worldwide."
#
#
# This work may not be copied, modified, re-published, uploaded, executed, or
# distributed in any way, in any medium, whether in whole or in part, without
# prior written permission from Cadence Design System, Inc.
# 
#----------------------------------------------------------------------------

#####################################################
set sdc_version 1.7

###############################################################################
## set_mode
################################################################################
set_mode -type {cell} scan_shift [get_cells u_mp_pma]

###############################################################################
# set_case_analysis
###############################################################################

set_case_analysis 1 [get_ports { scanmode }]
set_case_analysis 1 [get_ports { scanen }]
set_case_analysis 1 [get_ports { scanen_cg }]
set_case_analysis 0 [get_ports { iddq_en }]

