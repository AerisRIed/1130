################################################################################
# Copyright (c) 2025 by Cadence Design Systems Inc. ALL RIGHTS RESERVED.       #
# These coded instructions, statements, and computer programs are the          #
# copyrighted works and confidential proprietary information of Cadence Design #
# Systems Inc. They may not be modified, copied, reproduced, distributed, or   #
# disclosed to third parties in any manner, medium, or form, in whole or in    #
# part, without the prior written consent of Cadence Design Systems Inc.       #
################################################################################

#########################################################
# Specify additional command arguments beyond those of	#
# the default flow. This is useful for commands that	#
# have dozens of potential arguments; the variables	#
# below will be sourced during command execution to	#
# supplement those of the default flow. The variable	#
# name must be of the form <command>_omega_args, for	#
# example "check_timing_omega_args" for arguments to	#
# the "check_timing" command. These can also include	#
# other TCL or environment variables. For example:	#
# set check_timing_omega_args "-check_only no_drive"	#
#							#
# Supported Litmus1 commands for argument extension:	#
# read_libs						#
# elaborate						#
# report_analysis_coverage				#
# check_timing						#
#########################################################
