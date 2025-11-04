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
# Define all rule check waivers				#
#########################################################

#################################
# Justify auto-waivers by	#
# querying database for reason	#
#################################

set loc_waivers [check_cdc -list waivers]
foreach key [dict keys $loc_waivers] {
  set loc_waiver_type [dict get $loc_waivers $key {Waiver Type}]
  if {$loc_waiver_type == "Auto"} {
    set loc_waiver_id [dict get $loc_waivers $key {Id}]
    check_cdc -waiver -why $loc_waiver_id
  }
}
