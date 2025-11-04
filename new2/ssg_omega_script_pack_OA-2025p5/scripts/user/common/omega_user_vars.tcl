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
set rtl_defines "META_SYNC_DISABLE CDN_MPPHY_UC_ECC_EN CDN_TESTCHIP_UC_DBGR CDN_TC_UC_SRAM_128KB"

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
set bbox_module_list "cmn_ana \
                      txm_ana \
                      rxtxm_ana \
                      Xm_serdes_128id0256d1_fusaXttop \
                      CW_ecc_legacy_width32_chkbits7_synd_sel0 \
                      CW_ecc_legacy_width32_chkbits7_synd_sel1"

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
#     Status: mandatory (CDC,MCP), optional (Superlint,XPROP)
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

# Use the following TCL dictionary structure to control the process of
# reset initialization. Once the clock and reset port declarations are
# added as part of the signal binding process, Jasper can either set all
# registers into a specific reset state or simulate a reset sequence. The
# reset state or sequence can be specified in Jasper's internal format, or
# it can be extracted from a set of supported external formats. Multiple
# dictionary entries can be specified, however only one can be enabled.
# Supported syntax:
# dict set reset_init_file "<rst_type>" "<f_type>" "<f_path>" "<enabled>" "<addnl_args>"
# Allowed values are:
# rst_type   = sequence, init_state
# f_type     = internal, fsdb, vcd, shm, vwdb
# f_path     = relative or absolute path to file
# enabled    = 0,1
# addnl_args = any further arguments to the Jasper "reset" command
# For example:
# dict set reset_init_file "sequence" "vcd" "../waiti.vcd" "1" ""
# Status: optional
# Used by: Jasper
# Used by App: all
dict set reset_init_file "sequence" "internal" "../jasper/common/jasper_common_user_reset_sequence.tcl" "0" ""

# Use the following TCL dictionary structure to control both the source
# of X's in the design (points that will be set to X prior to analysis),
# as well as the targets for analysis (points that will have their status
# checked for propagated X's during the formal proof). Setting the value
# to 1 enables this source/target of X's, while setting to 0 disables it.
# Note that the default settings below are the minimum required to be
# considered X-free as part of the Omega flow validation process. The
# definitions for each type are as follows:
# X-sources:
#     src_uninit_regs    - Set default value of uninitialized flops to X
#     src_bbox_outputs   - Set all black-boxed module outputs to X
#     src_bus_contention - Set multiply driven busses to X
#     src_bus_floating   - Set undriven busses to X
#     src_int_undriven   - Set undriven/floating internal signals to X
#     src_input_ports    - Set primary inputs to X
#     src_stopats        - Set all declared stopat signals to X
#     src_reg_rst_abst   - Set reset-value abstractions of flops to X
#     src_reg_init_abst  - Set abstracted initial values of signals to X
# X-targets:
#     targ_clk_and_rst   - Clock and reset signals
#     targ_control       - Control structures such as conditionals
#     targ_data          - Data assignment structures
#     targ_index         - Array index expression structures
#     targ_output_ports  - Primary output ports
#     targ_bbox_inputs   - Black-boxed module inputs
#     targ_reg_rst_pin   - Flops with a reset pin
#     targ_reg_rst_val   - Flops with a reset value
#     targ_counter       - Flops that make up counters
#     targ_fsm           - Flops that make up finite state machines
# Status: mandatory
# Used by: Jasper
# Used by App: XPROP
# Sources:
dict set xprop_src_targ "src_uninit_regs" "1"
dict set xprop_src_targ "src_bbox_outputs" "1"
dict set xprop_src_targ "src_bus_contention" "1"
dict set xprop_src_targ "src_bus_floating" "1"
dict set xprop_src_targ "src_int_undriven" "1"
dict set xprop_src_targ "src_input_ports" "0"
dict set xprop_src_targ "src_stopats" "0"
dict set xprop_src_targ "src_reg_rst_abst" "0"
dict set xprop_src_targ "src_reg_init_abst" "0"
# Targets:
dict set xprop_src_targ "targ_clk_and_rst" "1"
dict set xprop_src_targ "targ_control" "1"
dict set xprop_src_targ "targ_data" "1"
dict set xprop_src_targ "targ_index" "1"
dict set xprop_src_targ "targ_output_ports" "1"
dict set xprop_src_targ "targ_bbox_inputs" "1"
dict set xprop_src_targ "targ_reg_rst_pin" "1"
dict set xprop_src_targ "targ_reg_rst_val" "1"
dict set xprop_src_targ "targ_counter" "1"
dict set xprop_src_targ "targ_fsm" "1"

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
# Used by: Joules-RTLDS (Flow1, Flow2, Flow3)
set mmmc_file ""

# Joules-generated DB file for the design specified
# by "top_design". Required only if "rtl_flow" is set
# to 0. For example:
# set golden_db_file "/home/netlist/top_design_map.db"
# Status: optional (RTL), mandatory (gate)
# Used by: Joules-RTLDS (Flow1, Flow2, Flow3)
set golden_db_file ""

# Specify the location of the stimulus files to be used
# for toggle and power analysis. The format of the file
# is deduced by its extension; supported extensions are
# of the set {vcd,shm,phy,fsdb,saif,tcf,sdb}. For example:
# set stimulus_file_list "/home/diags/high.vcd /home/diags/low.phy"
# Status: mandatory (Flow1 and Flow2), optional (Flow3)
# Used by: Joules-RTLDS (Flow1, Flow2, Flow3)
set stimulus_file_list ""

# Specify the hierarchical path to the Design Under Test (DUT)
# in the provided stimulus files. This should correspond
# to the instance of the "top_design" module as it appears
# in the testbench hierarchy. For example:
# set path_to_dut "/tb_top/dut/u_mp_pma/u_pma_rev/u_xcvr_ln_1"
# Status: mandatory (Flow1 and Flow2), optional (Flow3)
# Used by: Joules-RTLDS (Flow1, Flow2, Flow3)
set path_to_dut ""

# Specify the transitive fanin/fanout threshold value above
# which more detailed reports of the sequential elements are
# generated. For example:
# set structure_threshold 100
# Status: mandatory (Flow3), optional (Flow1 and Flow2)
# Used by: Joules-RTLDS (Flow1, Flow2, Flow3)
set structure_threshold 100

# Specify the path depth threshold value above which the
# instances and paths are reported. For example:
# set depth_threshold 10
# Status: mandatory (Flow3), optional (Flow1 and Flow2)
# Used by: Joules-RTLDS (Flow1, Flow2, Flow3)
set depth_threshold 10

# Specify the transitive fanin/fanout cutoff above which the
# paths are reported. For example:
# set depth_fan_in_out_threshold 100
# Status: mandatory (Flow3), optional (Flow1 and Flow2)
# Used by: Joules-RTLDS (Flow1, Flow2, Flow3)
set depth_fan_in_out_threshold 100

# Enables tool-inserted clock gating. Setting to "1" inserts
# additional clock gates, while setting to "0" will maintain
# whatever clock gating is present in the input RTL.
# Status: mandatory 
# Used by: Joules-RTLDS (Flow1, Flow2, Flow3)
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
# Used by: Joules-RTLDS (Flow1, Flow2, Flow3)
set cts_root_fanout 3
set cts_branch_fanout 7
set cts_leaf_fanout 20
set cts_root_buffer ""
set cts_branch_buffer ""
set cts_leaf_buffer ""

# The following variable is used to set the Library process node
# for trial synthesis. This should be an integer corresponding to
# the target library feature size in nanometers. For example,
# TSMC N3E would use a value of "3".
# Status: optional
# Used by: Joules-RTLDS (Flow3)
set lib_process_node 7

# Provides the list of Verilog simulation files in .v format.
# This list is used only to run ATPG during trial synthesis
# and can be left blank if not using ATPG or not inserting scan.
# Status: optional
# Used by: Joules-RTLDS (Flow3)
set verilog_sim_lib ""

# Provide a list of standard cell names from the target library
# that should not be used during trial synthesis. Wildcards are
# supported.
# Status: optional
# Used by: Joules-RTLDS (Flow3)
set dont_use_cells ""

# This variable is used to enable DFT scan insertion and chain
# stitching during trial synthesis. Set to 1 to enable scan
# insertion or set to 0 to disable scan insertion.
# Status: mandatory
# Used by: Joules-RTLDS (Flow3)
set insert_scan 1

# Enable Automatic Test Pattern Generation (ATPG) to compute
# estimated scan coverage and ATPG coverage during trial
# synthesis. If "run_atpg" is set to 1, then the above
# "insert_scan" variable must also be set to 1; the tool will
# error out otherwise. The fault sample size used for ATPG
# of 20,000 provides a good trade-off between runtime and accuracy.
# Status: mandatory
# Used by: Joules-RTLDS (Flow3)
set run_atpg 0

# Use the following "dft_shift_en" TCL dictionary structure
# to specify the shift enable signals for DFT during trial synthesis.
# Use a new dictionary entry per signal. If no dft_shift_en dict values
# are specified the tool will create a new "active high" shift enable
# signal called "test_se". While specifying the shift enable signal you
# need to specify the name of the signal and its polarity (active high/low)
# in this format:
# dict set dft_shift_en "<shift_enable_port>" "<shift_enable_signal_name>" "<active_polarity>"
# Example:
# dict set dft_shift_en "TModeClkGateOverride" "TModeClkGateOverride" "high"
# dict set dft_shift_en "Shift_en" "Shift_en_signal" "high"
# If intending to use a dedicated DFT clock gate bypass signal, it must
# also be defined in this "dft_shift_en" dictionary.
# Status: optional
# Used by: Joules-RTLDS (Flow3)
# dict set dft_shift_en "" "" ""

# Use the following "dft_test_clocks" TCL dictionary structure
# to specify the test clocks for DFT during trial synthesis.
# Use a new dictionary entry per signal. If no dft_test_clocks dict values
# are specified the tool will take all the SDC-defined clocks in the design
# that have an input source and define them as test clocks. While specifying
# the test clocks you need to specify the clock port and clock name
# in this format:
# dict set dft_test_clocks "<clock_port>" <clock_signal_name>"
# Example:
# dict set dft_test_clocks "clk" "clk"
# dict set dft_test_clocks "apb_clk" "apb_clk"
# Status: optional
# Used by: Joules-RTLDS (Flow3)
# dict set dft_test_clocks "" ""

# Use the following "dft_test_modes" TCL dictionary structure
# to specify the test mode signals for DFT during trial synthesis.
# Use a new dictionary entry per signal. If no dft_test_modes dict values
# are specified the tool will create a new "active high" test mode signal
# called "scan_mode". While specifying the test mode signal you need to
# specify the name of the signal and its polarity (active high/low)
# in this format:
# dict set dft_test_modes "<test_mode_port>" "<test_mode_signal_name>" "<active_polarity>"
# Example:
# dict set dft_test_modes "TMode" "TMode" "high"
# dict set dft_test_modes "TestMode" "TestMode" "high"
# Status: optional
# Used by: Joules-RTLDS (Flow3)
# dict set dft_test_modes "" "" ""

# Use the following "dft_async_reset_ports" TCL dictionary structure
# to specify the asynchronous reset signals for DFT during trial synthesis.
# Use a new dictionary entry per signal. The dft_async_reset_ports should be
# set for all asynchronously reset designs. You can neglect this variable for
# fully synchronously reset designs. While specifying the dft_async_reset_ports
# signal you need to specify the name of the signal and its polarity (active high/low)
# in this format:
# dict set dft_async_reset_ports "<async_reset_port>" "<async_reset_signal_name>" "<active_polarity>"
# Example:
# dict set dft_async_reset_ports "DReset" "DReset" "low"
# dict set dft_async_reset_ports "PRESETn" "PRESETn" "high"
# Status: optional
# Used by: Joules-RTLDS (Flow3)
# dict set dft_async_reset_ports "" "" ""

# If using a dedicated DFT clock gate bypass signal, use this "dft_cg_en"
# variable to specify this signal name. This signal should already be defined
# as part of the "dft_shift_en" dictionary structure above.
# Status: optional
# Used by: Joules-RTLDS (Flow3)
set dft_cg_en ""
