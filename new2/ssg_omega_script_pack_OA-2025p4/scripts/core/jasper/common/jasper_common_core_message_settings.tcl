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
# Perform message severity manipulation and message	#
# supression across all Jasper Apps.			#
#########################################################

set_message -default -all

set jg_message_to_disable {ICD011 ILIB002 VERI-1018 VERI-1173 VERI-1209 VERI-2518 WG002 WLIB008 WLIB009 WLIB011 WLIB012 WSR007}
set jg_message_to_info {}
set jg_message_to_warning {}
set jg_message_to_error {}

foreach jm_to_disable $jg_message_to_disable {
  set_message -disable $jm_to_disable
}
foreach jm_to_info $jg_message_to_info {
  set_message -info $jm_to_info
}
foreach jm_to_warning $jg_message_to_warning {
  set_message -warning $jm_to_warning
}
foreach jm_to_error $jg_message_to_error {
  set_message -error $jm_to_error
}
