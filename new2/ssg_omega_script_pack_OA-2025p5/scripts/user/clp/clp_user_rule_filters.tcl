################################################################################
# Copyright (c) 2024 by Cadence Design Systems Inc. ALL RIGHTS RESERVED.       #
# These coded instructions, statements, and computer programs are the          #
# copyrighted works and confidential proprietary information of Cadence Design #
# Systems Inc. They may not be modified, copied, reproduced, distributed, or   #
# disclosed to third parties in any manner, medium, or form, in whole or in    #
# part, without the prior written consent of Cadence Design Systems Inc.       #
################################################################################

#########################################################
# This file is used to define CLP message settings      #
# and rule filters for a specific design. Anything set  #
# here will supplement/override the settings in         #
# clp_core_rule_filters.tcl. Individual rules or        #
# entire rule classes can be suppressed or have their   #
# severities adjusted. This file is sourced at the      #
# beginning of the flow; check the applied_filter/      #
# directory for the filter reports.                     #
#########################################################

#add_rule_filter rule1 -rule CPF_ISO1 -and -message '*from ff1/out_f_reg\[0\]/Q*'
