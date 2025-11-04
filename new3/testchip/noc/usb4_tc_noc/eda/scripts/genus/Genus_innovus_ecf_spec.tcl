#############################################################################################
#        Copyright (c) 2014-2025 by Cadence Design Systems Inc. ALL RIGHTS RESERVED.        #
# These coded instructions, statements, and computer programs are the                       #
# copyrighted works and confidential proprietary information of Cadence Design Systems Inc. #
# They may not be modified, copied, reproduced, distributed, or disclosed to                #
# third parties in any manner, medium, or form, in whole or in part, without                #
# the prior written consent of Cadence Design Systems Inc.                                  #
#############################################################################################

##########################################################
# This Innovus script defines the Early Clock Flow (ECF) #
# variables for use during the Genus iSpatial flow.      #
##########################################################

set_ccopt_property buffer_cells $LIB_CLOCK_BUFFERS
set_ccopt_property inverter_cells $LIB_CLOCK_INVERTERS
set_ccopt_property target_max_trans $MAX_CLOCK_TRANSITION
set_ccopt_property target_skew $CLOCK_SKEW
set_ccopt_property auto_limit_insertion_delay_factor $Innovus_InsertionDelayFactor
set_ccopt_property update_io_latency true
set_ccopt_property ccopt_worst_chain_report_timing_too true
set_ccopt_property cts_use_inverters true
set_ccopt_property add_wire_delay_in_detailed_balancer true
set_ccopt_property clone_clock_gates false
set_ccopt_property adjacent_rows_legal false
set_ccopt_property useful_skew_clock_gate_movement_limit 250
set_ccopt_property cts_clock_gate_movement_limit 250
set_ccopt_property route_type_autotrim false

# More restrictive modeling commands:
# set_ccopt_property clock_gating_cells $TARGET_ICG_CELL
# set_ccopt_property max_fanout 64
# set_ccopt_property cell_density 0.5

create_route_type -name route_pref_layers_trunk -top_preferred_layer M9 -bottom_preferred_layer M8
create_route_type -name route_pref_layers_leaf  -top_preferred_layer M7 -bottom_preferred_layer M6
set_ccopt_property route_type -net_type top route_pref_layers_trunk
set_ccopt_property route_type -net_type trunk route_pref_layers_trunk
set_ccopt_property route_type -net_type leaf route_pref_layers_leaf
