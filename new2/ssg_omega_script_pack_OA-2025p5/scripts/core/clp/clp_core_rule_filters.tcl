################################################################################
# Copyright (c) 2024 by Cadence Design Systems Inc. ALL RIGHTS RESERVED.       #
# These coded instructions, statements, and computer programs are the          #
# copyrighted works and confidential proprietary information of Cadence Design #
# Systems Inc. They may not be modified, copied, reproduced, distributed, or   #
# disclosed to third parties in any manner, medium, or form, in whole or in    #
# part, without the prior written consent of Cadence Design Systems Inc.       #
################################################################################

#########################################################
# This file is used to define all CLP rule filters.     #
# Individual rules or entire rule classes can be        #
# suppressed or have their severities adjusted.         #
#########################################################

#########################################################
# Changing rule severity or supressing messages         #
#########################################################
# Unconnected inputs are not an error in RTL
if {$rtl_flow} {
  set_rule_handling STRC3 -warning
}

# Top boundary port does not have a driver
set_rule_handling STRUCT_UNDRIVEN_PIN_LP_TOP -warning
# A supply net has multiple supply sources
set_rule_handling PG_CONN_SUPPLY_NET_MULTI_SOURCE -warning
# add_power_state should have same voltage as Liberty files
set_rule_handling SUPPLY_SET_OPER_VOLTAGE_CONFLICT -warning
set_rule_handling SUPPLY_SET_OPER_VOLTAGE_CONFLICT_LP -warning
set_rule_handling SUPPLY_SET_OPER_VOLTAGE_CONFLICT_MACRO -warning

# Conflict between power and nwell or ground and pwell
set_rule_handling 1801_SUPPLY_SET_WELL_REVERSE_BIAS -warning

# Ground is connect to a voltage higher than 0
set_rule_handling 1801_SUPPLY_STATE_GND_TOO_HIGH -warning

# Power is connected to a 0 voltage
set_rule_handling 1801_SUPPLY_STATE_PWR_TOO_LOW -warning
