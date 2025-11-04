################################################################################
# Copyright (c) 2024 by Cadence Design Systems Inc. ALL RIGHTS RESERVED.       #
# These coded instructions, statements, and computer programs are the          #
# copyrighted works and confidential proprietary information of Cadence Design #
# Systems Inc. They may not be modified, copied, reproduced, distributed, or   #
# disclosed to third parties in any manner, medium, or form, in whole or in    #
# part, without the prior written consent of Cadence Design Systems Inc.       #
################################################################################

#########################################################
# This file is used to set attributes to control	#
# overall tool behavior. Anything set here will		#
# supplement/override the settings in			#
# litmus_core_attributes.tcl.				#
#########################################################

#########################################################
# Pins inferred in the RTL will be named differently	#
# by different tools (i.e. Litmus vs. Genus). Use the	#
# following command to map the constraint pin name used	#
# in the SDC to the tool generate pin name. For example	#
# if the SDC was written for Genus which uses "d" for	#
# generic flop inputs while Litmus uses "D", the	#
# example setting below would be used:			#
# add_constraint_renaming <rule_name> <pattern> <subst>	#
# This is only relevant for the RTL-based flow, i.e.	#
# "rtl_flow" is set to 1.				#
#########################################################
# add_constraint_renaming d2D '/d$' '/D'
