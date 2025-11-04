#############################################################################################
#        Copyright (c) 2014-2025 by Cadence Design Systems Inc. ALL RIGHTS RESERVED.        #
# These coded instructions, statements, and computer programs are the                       #
# copyrighted works and confidential proprietary information of Cadence Design Systems Inc. #
# They may not be modified, copied, reproduced, distributed, or disclosed to                #
# third parties in any manner, medium, or form, in whole or in part, without                #
# the prior written consent of Cadence Design Systems Inc.                                  #
#############################################################################################

##########################################################
# This Innovus script is included prior to the design    #
# and library loading steps. It is called internally by  #
# the Genus iSpatial flow.                               #
##########################################################

source -echo -verbose Genus_generic_define.tcl
set_message -id ENCDF-84 -severity error
set_message -id ENCLF-223 -severity warn
set_message -id IMPLF-223 -severity warn
set_message -id IMPLF-302 -severity warn
set_message -id IMPSP-365 -severity error
set_message -id IMPSP-377 -severity warn
set_message -id TCLCMD-917 -severity warn
set_message -id TCLCMD-1208 -severity warn
set_message -id TECHLIB-1398 -severity warn
