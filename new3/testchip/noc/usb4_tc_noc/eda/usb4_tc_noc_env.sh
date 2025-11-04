#############################################################################################
#        Copyright (c) 2008-2025 by Cadence Design Systems Inc. ALL RIGHTS RESERVED.        #
# These coded instructions, statements, and computer programs are the                       #
# copyrighted works and confidential proprietary information of Cadence Design Systems Inc. #
# They may not be modified, copied, reproduced, distributed, or disclosed to                #
# third parties in any manner, medium, or form, in whole or in part, without                #
# the prior written consent of Cadence Design Systems Inc.                                  #
#############################################################################################

################################################################################
# This file is used to specify design-specific variables                       #
# The file specifies a set of variable/value pairs, one pair per line          #
# The format is as follows:                                                    #
#        # comment(s) following hash until the end of the line                 #
#        variableName  value                                                   #
# where:                                                                       #
#      "variableName" refers to a predefined name and should not be altered.   #
#      "value" can be a text string, an integer, a floating-point number,      #
#      a boolean, or a list specified usingbraces "{ }".                       #
#      The angle brackets "< >" must be removed when replacing                 #
#      the placeholder with the actual value.                                  #
################################################################################

###############################################################################################
## Disclaimer : This EDA Flow is going through internal review process and subject to change  #
###############################################################################################

## Design Variables
# It is mandatory to mention the module name for which synthesis is to be done
setenv DESIGN usb4_tc_noc
# Following field can be left blank if design hierarchy needs to be flattened during synthesis
setenv MODULE_PRESERVE_LIST ""

## RTL-specific variables (Mandatory)
setenv RTL_PATH ..
setenv FILE_LIST ../usb4_tc_noc.f

## Constraint variables (Mandatory to mention path to any one, keep the other blank "")
setenv CONS_FILE ""
setenv SDC_FILE ../usb4_tc_noc.sdc

## Port-related variables (CLK_PORT, CLK_FREQ, RST_PORT and RST_ACTIVE are Mandatory. Others should be mentioned, if available.)
## For multiple ports, specify space separated names within brackets
## For each RST_PORT, mention if each port is active "high" or active "low" in RST_ACTIVE
setenv CLK_PORT "{tap2apb_pclk noc_clk }"
setenv CLK_FREQ "{100 100 }"
setenv RST_PORT "{rst_n }"
setenv RST_ACTIVE "{low }"
setenv SYNC_RESET 0
setenv JTAG_CLK_PORT ""
setenv JTAG_RST_PORT ""

## Miscellaneous variables (Not Mandatory)
setenv PATH_TO_DUT ""

