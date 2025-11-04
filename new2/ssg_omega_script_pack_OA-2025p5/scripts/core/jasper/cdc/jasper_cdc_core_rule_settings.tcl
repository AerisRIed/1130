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
# Use this file to override any attributes, control	#
# variables or rule settings that differ from the	#
# primary rule file. This file is loaded immediately	#
# after reading the default RTL CDC rule file.		#
#########################################################

#################
# Variables	#
#################

check_cdc -check -rule -set {{multi_mode_analysis true}}

#################
# Parameters	#
#################

#################
# Rules		#
#################
