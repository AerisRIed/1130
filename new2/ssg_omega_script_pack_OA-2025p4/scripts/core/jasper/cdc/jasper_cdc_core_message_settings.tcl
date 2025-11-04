################################################################################
# Copyright (c) 2025 by Cadence Design Systems Inc. ALL RIGHTS RESERVED.       #
# These coded instructions, statements, and computer programs are the          #
# copyrighted works and confidential proprietary information of Cadence Design #
# Systems Inc. They may not be modified, copied, reproduced, distributed, or   #
# disclosed to third parties in any manner, medium, or form, in whole or in    #
# part, without the prior written consent of Cadence Design Systems Inc.       #
################################################################################

#########################################################
# This file should not require any user modification	#
#########################################################

#########################################################
# Use this file to override message control settings	#
# from the jasper/common/ area.				#
#########################################################

if {($prl_hier_flow == 1) && ($prl_run_cdc == 1)} {
  set hier_cdc_error_to_warning {ECDC100 ECDC101 ECDC102 ECDC103 ECDC104 ECDC105}
  foreach hcetw $hier_cdc_error_to_warning {
    set_message -warning $hcetw
  }
}
