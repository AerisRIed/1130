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

foreach test_cov_tag [list FCV_IS_ESTM FLT_IS_HTST TCV_IS_ESTM] {
  check_superlint -waiver -add -tag $test_cov_tag -comment "Need $test_cov_tag for ATPG coverage test; no need to report"
}
