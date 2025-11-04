################################################################################
# Copyright (c) 2025 by Cadence Design Systems Inc. ALL RIGHTS RESERVED.       #
# These coded instructions, statements, and computer programs are the          #
# copyrighted works and confidential proprietary information of Cadence Design #
# Systems Inc. They may not be modified, copied, reproduced, distributed, or   #
# disclosed to third parties in any manner, medium, or form, in whole or in    #
# part, without the prior written consent of Cadence Design Systems Inc.       #
################################################################################

#########################################################
# This file serves as the primary user interface to the	#
# Omega flow. Modify the variables below according to	#
# their descriptions.					#
#########################################################

#########################################################
#                 CUSTOM USER VARIABLES			#
#							#
# Status: optional					#
# 							#
# Specify any design-specific TCL variables as needed	#
# below this comment, such as embedded paths or control	#
# settings within the SDC.				#
#########################################################

#########################################################
#                 GLOBAL USER VARIABLES			#
#							#
# Status: mandatory					#
#########################################################

#########################################################
#          Common variables for multiple tools		#
#							#
# The following section contains variables that are	#
# used by multiple tools in the Omega flow; each	#
# variable indicates the tools for which it is needed.	#
#########################################################

# Controls whether a single PVT corner or entire MMMC
# view definition file should be used for library
# setup. If set to 0, the "single_corner_libs" variable
# must contain all needed Liberty files for a single
# PVT corner.
# Used by: Litmus, Joules-RTLDS
# For Litmus:
#     If set to 1, the "litmus_user_mmmc.tcl" script must
#     be filled in with all required view definitions. The
#     MMMC flow cannot be used in hierarchical comparison mode.
#     Status: mandatory
# For Joules-RTLDS:
#     If set to 1, the "mmmc_file" variable must specify the
#     path to the MMMC view definition file.
#     Status: mandatory (RTL), optional (gate)
set use_mmmc 0

# Provides the Liberty files for a single PVT corner. For example:
# set single_corner_libs "/tsmc/tsmc5/base.lib ../analog/macro.lib"
# Used by: Litmus, Jasper, CLP, Joules-RTLDS
# For Litmus:
#     Required only if "use_mmmc" is set to 0 or if using
#     hierarchical comparison mode.
#     Status: mandatory (SMSC or hierarchical), optional (MMMC)
# For Jasper:
#     The Jasper Apps only require these if there are direct
#     Liberty cell instantiations in the input RTL or if
#     performing a gate-level analysis.
#     Status: optional (RTL), mandatory (gate)
#     Used by App: all
# For CLP:
#     Status: mandatory
# For Joules-RTLDS:
#     Required only if "use_mmmc" is set to 0.
#     Status: mandatory (RTL), optional (gate)
set single_corner_libs ""

# Provides the list of physical reference libraries in LEF format.
# If specifying multiple files, the technology LEF (containing the
# metal layer definitions) must be listed first. For example:
# set lef_list "/tsmc/tsmc5/base.lef ../analog/macro.lef"
# Status: mandatory
# Used by: CLP, Joules-RTLDS
set lef_list ""

# Controls analysis type; if set to 1, the Verilog file
# list(s) specified with "golden_vf_file" is used to load
# design RTL.
# Status: mandatory
# Used by: Litmus, Jasper, CLP, Joules-RTLDS
# For Litmus:
#     If set to 0, the gate-level netlist specified with
#     "golden_netlist_file" is used instead.
# For Jasper:
#     If set to 0, the gate-level netlist specified with
#     "golden_netlist_file" is used instead.
#     Used by App: CDC
# For CLP:
#     If set to 0, the gate-level netlist specified with
#     "golden_netlist_file" is used instead. If running in
#     compare mode, this setting is ignored and the tool
#     will load both RTL and gate-level netlists.
# For Joules-RTLDS:
#     If set to 0, the existing database specified with
#     "golden_db_file" is used instead.
set rtl_flow 1

# Name of top-level design to be analyzed. This must correspond
# to the design described by any of the "golden_vf_file",
# "golden_netlist_file", or "golden_db_file" variables.
# For example:
# set top_design "Xtsubsystem"
# Status: mandatory
# Used by: Litmus, Jasper, CLP, Joules-RTLDS
# For Jasper:
#     Used by App: all
set top_design "cdn_sd3101x_n4p_22_vs130_1xah1xbv1xch1xdv1yah1ybv4yhvhv2z"

# Verilog file list(s) containing all of the RTL
# required to implement the design specified by the
# "top_design" variable. Required only if "rtl_flow"
# is set to 1. Relative paths are supported. Verilog
# command files are supported. This is a TCL dictionary
# structure in which file list(s) to be read are specified
# as the first entry (key), and the HDL LRM type for
# those files is specified second (value). The
# three LRM values that are valid for every tool are:
# "v2k"  = Verilog 2001
# "sv"   = SystemVerilog (most recent standard per tool)
# "vhdl" = VHDL 2008
# However more specific settings are supported by the
# individual tools as follows:
# Litmus: v1995,v2001,sv,vhdl
# Jasper: v95,verilog,v2k,vams,sv,sv05,sv09,sv12,sv17,
#         vhdl,vhdl93,vhdl2k,vhdl08
# CLP:    v1995,verilog,verilog2k,systemverilog,sva,sv,
#         sv09,sv12,vhdl [87 | 93 | 2008]
# Joules: v1995,v2001,sv,vhdl
# Create as many dictionary entries as required to specify the
# design; the files will be loaded in the order provided.
# For example, if loading a design for which portions are
# written in all three global languages:
# dict set golden_vf_file "../../v2k_a.f ../../v2k_b.f" "v2k"
# dict set golden_vf_file "/path/to/sv.f" "sv"
# dict set golden_vf_file "/path/to/vhdl.f" "vhdl"
# Status: mandatory (RTL), optional (gate)
# Used by: Litmus, Jasper, CLP, Joules-RTLDS
# For Jasper:
#     Used by App: all
# For CLP:
#     Also mandatory if running in "compare" mode.
dict set golden_vf_file "../../../../filelist/output/timberwolf_phy_hlm_sim.f" "sv"
#dict set golden_vf_file "/projects/sd3101_n4p/users/ddwang/Timberwolf_USB4_T4GP/trunk/design/filelist/output/timberwolf_phy_hlm_sim.f" "sv"

# Set of all define statements required to properly
# configure the input RTL. Used only if "rtl_flow"
# is set to 1. Assignments should not have spaces;
# each space indicates a separate define statement.
# All tools support Verilog command files to the
# "golden_vf_file" variable, which can also contain
# define statements, in which case those listed here
# are optional additional statements.
# For example:
# set rtl_defines "SYNTHESIS PIF_WIDTH=128"
# Status: optional
# Used by: Litmus, Jasper, CLP, Joules-RTLDS
# For Jasper:
#     Used by App: all
set rtl_defines "META_SYNC_DISABLE CDN_MPPHY_UC_ECC_EN CDN_TESTCHIP_UC_DBGR"

# Set of all design modules that should be black-boxed
# during elaboration. The unique name of each module should
# be specified without reference to design hierarchy.
# Wildcards are suppported. For example:
# set bbox_module_list "DW02_multp DW02_tree"
# Status: optional
# Used by: Litmus, Jasper
# For Jasper:
#     If performing the hierarchical flow, there is no need
#     to add the hierarchical submodules explicitly to this
#     variable, as it will be done automatically in the flow.
#     Used by App: all
set bbox_module_list "cmn_ana txm_ana rxtxm_ana Xm_serdes_128id0256d1_fusaXttop"

# Netlist file(s) for the design specified by "top_design".
# Required only if "rtl_flow" is set to 0. Relative paths
# are supported. For example:
# set golden_netlist_file "/home/netlist/Xtsubsystem_syn.v"
# Status: optional (RTL), mandatory (gate)
# Used by: Litmus, Jasper, CLP
# For Jasper:
#     Used by App: CDC
# For CLP:
#     Also mandatory if running in "compare" mode.
set golden_netlist_file ""

# Top-level SDC file on which analysis will be run. Relative
# paths are supported. For example:
# set golden_sdc_file "/home/sdc/Xtsubsystem.sdc"
# Used by: Litmus, Jasper, Joules-RTLDS
# For Litmus:
#     Required only if "use_mmmc" is set to 0 or if using
#     hierarchical comparison mode. If "use_mmmc" is set to 1,
#     the SDC files will be taken from the MMMC definitions.
#     Status: mandatory (SMSC or hierarchical), optional (MMMC)
# For Jasper:
#     Status: mandatory (CDC,MCP), optional (Superlint)
#     Used by App: all
# For Joules:
#     Required only if "use_mmmc" is set to 0. If "use_mmmc" is
#     set to 1, the SDC files will be taken from the MMMC
#     definitions.
#     Status: mandatory
#set golden_sdc_file ""
set golden_sdc_file "../../../../phy_sdc/phy_sdc.sdc"

# Number of processor cores or threads that any single tool
# can use. All threads will reside on the same host. If the
# $CDNS_MULTITHREAD_COUNT environment variable is defined,
# it will take precedence and override the value below.
# This value should match the LSF resources requested.
# Status: mandatory
# Used by: Litmus, Jasper, CLP, Joules-RTLDS
# For Jasper:
#     Used by App: all
set tool_thread_count 8

#########################################################
#                   Litmus variables			#
#							#
# These variables are used only by the Litmus flow.	#
#########################################################

# Use the following "hier_inst_sdc" TCL dictionary structure
# to specify the {submodule_instance, path_to_SDC} pair for all
# instances to be analyzed as part of the hierarchical comparison
# flow. Note it is the full hierarchical instance of the module
# that must be specified, not the module itself. Each additional
# instance is to be specified on a dedicated line. A relative path
# to the SDC file is supported. For example, if the top-level
# Xtsubsystem design had an instance each of ExternInt and LoadStore,
# each with their own SDC file, the syntax would be:
# dict set hier_inst_sdc "Core0/Xttop/ExternInt" "../../ExternInt.sdc"
# dict set hier_inst_sdc "Core0/Xttop/LoadStore" "/home/sdc/LoadStore.sdc"
# There is no default set for this variable.
# Status: mandatory (hierarchical flow), optional (flat flow)
# Used by: Litmus
# dict set hier_inst_sdc "<hier_instance_path>" "<sdc_file_path>"

#########################################################
#                   Jasper variables			#
#							#
# These variables are used only by the Jasper flow.	#
#########################################################

# Use the following "hier_jdb_mod_app" TCL dictionary structure
# to specify the {path_to_JDB, submodule, Jasper_app} triplet for
# all submodules to be analyzed as part of the hierarchical comparison
# flow. Each additional unique JDB is to be specified on a dedicated
# line. A relative path to the JDB file is supported. The specification
# of the targeted Jasper App allows for a single dictionary construct
# for use across multiple Apps. For example if a top-level Xtsubsystem
# design has submodules ExternInt and LoadStore, for which both CDC and
# Superlint are to be run in the hierarchical comparison flow with JDB
# submodule files stored in different places, the syntax would be:
# dict set hier_jdb_mod_app "../../ExternInt_cdc.jdb" "ExternInt" "cdc"
# dict set hier_jdb_mod_app "/path/to/ExternInt_lint.jdb" "ExternInt" "superlint"
# dict set hier_jdb_mod_app "../LoadStore_cdc.jdb" "LoadStore" "cdc"
# dict set hier_jdb_mod_app "/path/to/LoadStore_lint.jdb" "LoadStore" "superlint"
# The Jasper_app entry can be one of "cdc" or "superlint". There is
# no default set for this variable. There is no requirement to add
# this submodule list to the "bbox_module_list", as it will be done
# automatically within the flow.
# Status: mandatory (hierarchical flow), optional (flat flow)
# Used by: Jasper
# Used by App: CDC, Superlint
# dict set hier_jdb_mod_app "<jdb_file_path>" "<submodule_name>" "<jasper_app>"

# Name-mapping file generated by a Conformal LEC RTL-to-gate
# run. The mapped signals are used to translate config_rtlds
# commands and waivers from an RTL analysis to the mapped
# signals in a gate-level analysis. This is used only if
# "rtl_flow" is set to 0. Relative paths are supported.
# For example:
# set golden_name_map_file "/home/lec/Xtsubsystem.map.do"
# Status: optional
# Used by: Jasper
# Used by App: CDC
set golden_name_map_file ""

#########################################################
#                Conformal-LP variables			#
#							#
# These variables are used only by the CLP flow.	#
#########################################################

# Golden UPF corresponding to the design in "golden_vf_file"
# for which the CLP analysis will be run. This is used if
# running at the RTL level or in "compare" mode.
# Status: mandatory (RTL/compare), optional (gate)
# Used by: CLP
set rtl_upf ""

# Revised UPF corresponding to the design in "golden_netlist_file"
# for which the CLP analysis will be run. This is used if
# running at the gate level or in "compare" mode.
# Status: mandatory (gate/compare), optional (RTL)
# Used by: CLP
set netlist_upf ""

#########################################################
#                Joules-RTLDS variables			#
#							#
# These variables are used only by the Joules flow.	#
#########################################################

# Provides the path to the MMMC view definition file.
# Required only if "use_mmmc" is set to 1. Note that
# although the full MMMC commands are parsed, only the
# libraries associated with the first set_analysis_view
# command are used. For example:
# set mmmc_file "/home/user/joules_mmmc.tcl"
# Status: mandatory (RTL), optional (gate)
# Used by: Joules-RTLDS
set mmmc_file ""

# Joules-generated DB file for the design specified
# by "top_design". Required only if "rtl_flow" is set
# to 0. For example:
# set golden_db_file "/home/netlist/top_design_map.db"
# Status: optional (RTL), mandatory (gate)
# Used by: Joules-RTLDS
set golden_db_file ""

# Specify the location of the stimulus files to be used
# for toggle and power analysis. The format of the file
# is deduced by its extension; supported extensions are
# of the set {vcd,shm,phy,fsdb,saif,tcf,sdb}. For example:
# set stimulus_file_list "/home/diags/high.vcd /home/diags/low.phy"
# Status: mandatory (Flow1 and Flow2), optional (Flow3)
# Used by: Joules-RTLDS
set stimulus_file_list ""

# Specify the hierarchical path to the Design Under Test (DUT)
# in the provided stimulus files. This should correspond
# to the instance of the "top_design" module as it appears
# in the testbench hierarchy. For example:
# set path_to_dut "/tb_top/dut/u_mp_pma/u_pma_rev/u_xcvr_ln_1"
# Status: mandatory (Flow1 and Flow2), optional (Flow3)
# Used by: Joules-RTLDS
set path_to_dut ""

# Specify the transitive fanin/fanout threshold value above
# which more detailed reports of the sequential elements are
# generated. For example:
# set structure_threshold 100
# Status: mandatory (Flow3), optional (Flow1 and Flow2)
# Used by: Joules-RTLDS
set structure_threshold 100

# Specify the path depth threshold value above which the
# instances and paths are reported. For example:
# set depth_threshold 10
# Status: mandatory (Flow3), optional (Flow1 and Flow2)
# Used by: Joules-RTLDS
set depth_threshold 10

# Specify the transitive fanin/fanout cutoff above which the
# paths are reported. For example:
# set depth_fan_in_out_threshold 100
# Status: mandatory (Flow3), optional (Flow1 and Flow2)
# Used by: Joules-RTLDS
set depth_fan_in_out_threshold 100

# Enables tool-inserted clock gating. Setting to "1" inserts
# additional clock gates, while setting to "0" will maintain
# whatever clock gating is present in the input RTL.
# Status: mandatory 
# Used by: Joules-RTLDS
set insert_clock_gating 1

# The following variables all pertain to clock tree modeling
# within the Joules power estimation engine. To make an accurate
# estimate of clock tree power, Joules needs to know the name
# of the clock buffer cells that should make up the root, branch,
# and leaf levels of the clock distribution network. These cells
# need to be present in the libraries specified via the
# "single_corner_libs" variable or within the MMMC file. Joules
# also needs to know the maximum fanout values allowed for each
# buffer at the root, branch, and leaf levels. For example:
# set cts_root_fanout 3
# set cts_branch_fanout 7
# set cts_leaf_fanout 20
# set cts_root_buffer "CKBD1BWP240H8P57PDLVT"
# set cts_branch_buffer "CKBD1BWP240H8P57PDLVT"
# set cts_leaf_buffer "CKBD1BWP240H8P57PDLVT"
# Status: mandatory (Flow1), optional (Flow2 and Flow3)
# Used by: Joules-RTLDS
set cts_root_fanout 3
set cts_branch_fanout 7
set cts_leaf_fanout 20
set cts_root_buffer ""
set cts_branch_buffer ""
set cts_leaf_buffer ""
