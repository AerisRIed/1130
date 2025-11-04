################################################################################
# Copyright (c) 2024 by Cadence Design Systems Inc. ALL RIGHTS RESERVED.       #
# These coded instructions, statements, and computer programs are the          #
# copyrighted works and confidential proprietary information of Cadence Design #
# Systems Inc. They may not be modified, copied, reproduced, distributed, or   #
# disclosed to third parties in any manner, medium, or form, in whole or in    #
# part, without the prior written consent of Cadence Design Systems Inc.       #
################################################################################

#########################################################
# This file contains all non-default attributes to      #
# control overall tool behavior as well as the results  #
# of specific rules.                                    #
#########################################################
###################
# General         #
###################
tclmode

set_dofile_abort off

# Set undefined cells are blackbox instead of erroring out
set_undefined_cell Black_box

# Use 1801
set_lowpower_option -native_1801

# No limit for error categories
set_lowpower_option -witness_limit 0

###################
# Low Power       #
###################
# Enable data path buffer checking
set_lowpower_option -buffer_path_check all

# Check maximum fanout of isolation control signal
if {$rtl_flow == 0} {
  set_lowpower_option -isolation_limit 10000
  set_lowpower_option -analysis_style post_synthesis
} else {
  set_lowpower_option -analysis_style pre_synthesis
}

# Doesnt check logical constants driving a domain output
set_lowpower_option -local_constants

# -location in set_isolation, set_level_shifter and set_repeater commands will be relative to domain rather than hierarchy
set_lowpower_option -no_use_strategy_location_as_hierarchy

# Enable terminal boundary support
set_lowpower_option -enable_terminal_boundary_support

set_naming_rule %L_%s %L_%d_%s %s -instance

#####################
# HDL options       #
#####################
# Will compile logic to design space
set_hdl_options -v_to_vd on
