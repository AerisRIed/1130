//////////////////////////////////////////////////////////////////////////////////
// Copyright (c) 2025 by Cadence Design Systems Inc. ALL RIGHTS RESERVED.       //
// These coded instructions, statements, and computer programs are the          //
// copyrighted works and confidential proprietary information of Cadence Design //
// Systems Inc. They may not be modified, copied, reproduced, distributed, or   //
// disclosed to third parties in any manner, medium, or form, in whole or in    //
// part, without the prior written consent of Cadence Design Systems Inc.       //
//////////////////////////////////////////////////////////////////////////////////

//////////////////////////////////////////////////////////
// This file should not require any user modification	//
//////////////////////////////////////////////////////////

// Jasper RTL CDC Rule File
// Tool version: 2025.03p001 (4/23/2025)
// Adapted from: <jasper_install>/etc/res/rtlds/rules/cdc.def
// Each category definition contains the name and description of checks that
// make up the body of the category.

domain CDC "List of categories in CDC domain"
{
 CDC_CONFIGURATION
 CDC_SYNCHRONIZATION
 CDC_CONVERGENCE
 CDC_FUNCTIONAL
 CDC_METASTABILITY
}

domain RDC "List of categories in RDC domain"
{
 RST_SYNCHRONIZATION
 RST_CONFIGURATION
 }

domain SOC_INTEGRATION "List of categories in Hierarchical Domain"
{
 HIER_CONSISTENCY
}

category CDC_CONFIGURATION  // Category of CDC configuration checks
{
PRT_IS_UNCK {severity=Error}   {msg="No clock association for the '%s' port '%s'"}
CLK_IS_CNST {severity=Warning} {msg="Clock '%s' is constant"}
FLP_CK_CNST {severity=Error}   {msg="Clock pin of flop '%s' has a constant value"}
CLK_NO_DECL {severity=Error}   {msg="Undeclared clock port '%s'. It reaches one or more flop's clock pin or Liberty input clock. One such flop/Liberty input clock is '%s'"}
FLP_CK_UDCL {severity=Error}   {msg="Flop '%s' is connected to one or more undeclared clocks, one such clock is '%s'"}
SIG_NO_STAT {severity=Error}   {msg="Signal '%s' is not static"}
SIG_NO_GRAY {severity=Error}   {msg="Signal '%s' is not gray encoded"}
SIG_NO_EXCL {severity=Error}   {msg="Signals '%s' are not mutually toggle exclusive"}
CND_NO_CONS {severity=Error}   {msg="Signal '%s' is not constant"}
MUX_NO_CLKS {severity=Warning} {msg="Unconstrained primary selector '%s' of muxes in clock path"} {status=off}
CLK_IS_CONV {severity=Error}   {msg="Clock Convergence at '%s'. One such clock is '%s'"} {status=off}
CKS_IS_CONV {severity=Error}   {msg="Clock Mux Select Convergence at '%s'. One such signal is '%s'"} {status=off}
CLK_GT_ASYN {severity=Error}   {msg="Clock signal '%s' and enable signal '%s' are asynchronous and converge at '%s'"} {status=off}
ICG_EN_ASYN {severity=Error}   {msg="ICG clock signal '%s' and enable signal '%s' are asynchronous"}
LTC_NO_INIT {severity=Error}   {msg="Uninitialized latch at '%s'"}
SYN_NO_TARG {severity=Info}    {msg="User-defined scheme '%s' of type '%s' does not qualify any CDC pair"} {status=off}
CDC_LP_ISOC {severity=Warning} {msg="Isolation Enable signal '%s' is controlling ISO logic on clock path of clock signal '%s'"}
CDC_LP_ISOR {severity=Warning} {msg="Isolation Enable signal '%s' is controlling ISO logic on reset path of reset signal '%s'"}
}

category CDC_SYNCHRONIZATION    // Category of checks related to CDC synchronizers
{
CDC_LP_ASCI {severity=Warning} {msg="Isolation Enable signal '%s' is not synchronized to the clock '%s' of the destination unit '%s'"}
CDC_LP_ASLI {severity=Warning} {msg="Isolation Enable signal '%s' is not synchronized to the clock '%s' of the driving unit '%s'"}
CDC_LP_ASRR {severity=Warning} {msg="Retention Restore signal '%s' is not synchronized to the clock '%s' of the destination unit '%s'"}
CDC_LP_ASRS {severity=Warning} {msg="Retention Save signal '%s' is not synchronized to the clock '%s' of the destination unit '%s'"}
CDC_NO_SYNC {severity=Error}   {msg="No synchronizer between source unit '%s' driven by clock '%s' and destination unit '%s' driven by clock '%s'"}
CDC_PR_LOGC {severity=Error}   {msg="Combo Logic on CDC path between source unit '%s' driven by clock '%s' and destination unit '%s' driven by clock '%s'"}
CDC_PR_FOUT {severity=Warning} {msg="Multiple fanouts of source unit '%s' driven by clock '%s' to the same destination clock domain '%s'. One such fanout destination is '%s'"}
CDC_PR_INAC {severity=Info}    {msg="Inactive CDC path between source unit '%s' driven by clock '%s' and destination unit '%s' driven by clock '%s' due to constraints"} {status=off}
CDC_PR_LTCH {severity=Error}   {msg="CDC on latch unit '%s'. The two inputs of the latch are coming from different asynchronous clock domains. Two such domains are '%s' and '%s'"}
SYN_DF_SLGC {severity=Error}   {msg="Combo Logic in NDFF synchronizer chain '%s' driven by clock '%s'"}
SYN_DF_CKPH {severity=Error}   {msg="Different clock phases drive NDFF synchronizer '%s' clocked by '%s'"}
SYN_DF_FOUT {severity=Error}   {msg="Multiple fanouts of first flop of NDFF scheme '%s' driven by clock '%s'"}
SYN_DF_RDND {severity=Warning} {msg="Redundant synchronizer to clock '%s' on CDC path between source unit '%s' and destination unit '%s'"} {status=off}
SYN_SE_INVL {severity=Error}   {msg="Invalid Sync enable '%s' between source clock domain '%s' and destination clock domain '%s'"}
SYN_GP_ASIP {severity=Error}   {msg="Glitch Protector control signal '%s' and data signal '%s' are from asynchronous source clock domains '%s'"}
SYN_GP_ASOP {severity=Error}   {msg="Glitch Protector control signal '%s' and output signal '%s' are from asynchronous destination clock domains '%s'"}
}

category CDC_CONVERGENCE    // Category of CDC convergence checks
{
CNV_ST_GLCH {severity=Error} {msg="Potential glitch at '%s' in source clock domain '%s'"}
CNV_ST_CONV {severity=Error} {msg="Convergence at '%s' in destination clock domain '%s' after synchronization"}
CNV_ST_BCNV {severity=Error} {msg="Potential convergence of bus '%s' from source clock domain '%s' to destination clock domain '%s' outside the module"} {status=off}
MUX_ST_GLCH {severity=Error} {msg="Potential glitch at '%s' on mux scheme '%s' of type '%s'"} {status=off}
}

category CDC_FUNCTIONAL // Category of CDC functional checks
{
CTL_NO_STBL {severity=Error} {msg="Control path '%s' is not stable long enough to be captured correctly by destination clock '%s'"}
PLS_NO_STBL {severity=Error} {msg="Pulse input '%s' from source clock '%s' is not stable long enough to be captured by destination clock '%s'"}
DAT_NO_STBL {severity=Error} {msg="Data Path '%s' is not stable long enough to be captured by destination clock '%s'"}
DAT_HS_STBL {severity=Error} {msg="Handshake data from source clock '%s' of handshake synchronizer '%s' changes before acknowledge is received from the destination clock '%s'"}
PSH_ON_FULL {severity=Error} {msg="Write to FIFO '%s' from source clock '%s' is possible when full"}
POP_ON_EMTY {severity=Error} {msg="Read from FIFO '%s' in destination clock '%s' is possible when empty"}
GET_NO_STBL {severity=Error} {msg="Signal '%s' controlling the read cycle of the FIFO is not stable long enough for its effect to be captured properly in the write domain by clock '%s'"}
PUT_NO_STBL {severity=Error} {msg="Signal '%s' controlling the write cycle of the FIFO is not stable long enough for its effect to be captured properly in the read domain by clock '%s'"}
GPD_NO_STBL {severity=Error} {msg="Glitch protector data path '%s' is not stable when enable signal '%s' is asserted in destination clock '%s'"}
SYN_NO_STBL {severity=Error} {msg="Sync enabler data path '%s' is not stable when enable signal '%s' is asserted in destination clock '%s'"}
INC_FN_PROP {severity=Error} {msg="Incomplete scheme property generated for synchronizer '%s' in destination clock '%s'"}
USR_FN_PROP {severity=Error} {msg="User defined scheme property '%s' failed for synchronizer '%s'"}
}

category CDC_METASTABILITY // Category of CDC metastability checks
{
CHK_MS_FAIL {severity=Error} {msg="User property '%s' failed due to metastability injection"}
INJ_MS_FAIL {severity=Error} {msg="Injection failure: CDC destination unit '%s' could not be made metastability-aware due to the presence of a previous abstraction"}
}

category RST_CONFIGURATION // Category of Reset Configuration checks
{
RST_NO_DECL {severity=Error} {msg="Undeclared reset source '%s'"}
RST_RS_CNST {severity=Warning} {msg="Reset signal becomes constant at '%s'"}
RST_RS_FSAR {severity=Error} {msg="Reset condition is keeping flop '%s' stuck at its reset value"}
FLP_NO_INIT {severity=Error} {msg="Reset condition of flop '%s' might not be asserted, keeping it stuck at run state"}
FLP_RS_UDCL {severity=Error} {msg="Flop '%s' is connected to one or more undeclared resets, one such reset is '%s'"}
FLP_RS_UPOL {severity=Error} {msg="Reset condition of flop '%s' does not match the reset signal's polarity'"}
}

category RST_SYNCHRONIZATION    // Category of Reset synchronizer checks
{
RST_NO_SYNC {severity=Error}   {msg="Reset signal '%s' driven by clock '%s' is not synchronized to the clock '%s' of the destination unit '%s'"}
RST_RS_CONV {severity=Error}   {msg="Resets '%s' with %s polarities converge at '%s'%s"}
RST_PH_GLCH {severity=Error}   {msg="Potential glitch in the reset path between reset %s and data signal %s"}
RST_NO_CONS {severity=Error}   {msg="Unconstrained reset mux select '%s' with input resets '%s'"}
RDC_RS_SYCA {severity=Error}   {msg="Flops '%s' and '%s' driven by clock '%s' are driven by different reset signals '%s' and '%s' respectively. The source flop is driven asynchronously by a reset source that is fully synchronous"}
RDC_RS_DFRS {severity=Error}   {msg="Flop/port '%s' and flop/port '%s' driven by clock '%s' have different %s '%s' %s. The destination flop is driven by '%s' reset source"}
RST_RS_INAC {severity=Warning} {msg="Inactive reset path between source unit '%s' and destination unit '%s' due to constraints"} {status=off}
RST_RS_RIDP {severity=Error}   {msg="Asynchronous or Synchronized Reset signal '%s' is connected to the data pin of flop/latch '%s' driven by clock/enable '%s'"}
SYN_RS_CKPH {severity=Error}   {msg="The flops of reset synchronizer '%s' are driven by different phases of the clock '%s'"}
SYN_RS_SMDR {severity=Error}   {msg="The flops of reset synchronizer '%s' are not driven by same reset signal"}
SYN_RS_SLGC {severity=Error}   {msg="Combo logic exists between flops of reset synchronizer '%s'"}
SYN_RS_RDND {severity=Warning} {msg="Redundant reset synchronizer on reset path between source clock '%s' to destination clock '%s'"}
RST_RS_FOUT {severity=Error}   {msg="Fanout of reset source '%s' to multiple reset synchronizers in the same destination clock domain '%s'"}
RDC_RS_GLCH {severity=Error}   {msg="Potential glitch at '%s' due to more than one flop from different reset domains combining into a combo logic driving a blackbox input or primary inout/output port"} {status=off}
}

category HIER_CONSISTENCY
{
RST_IN_UDEF {severity=Error} {msg="Reset port '%s' from IP level is not connected to a reset definition at the SoC level"}
RST_IN_URST {severity=Error} {msg="Reset port '%s' from IP level is expected to be of type '%s' and clock '%s' but found to be of type '%s' and clock '%s' from the SoC level"}
RST_IN_URAT {severity=Warning} {msg="Reset rating of port '%s' at IP level does not match the driver/load reset at the SoC level"}
RST_IN_UPOL {severity=Error} {msg="Reset port '%s' from IP level is expected to have polarity '%s' but found connected to polarity '%s' at the SoC level"}
RST_IN_RORD {severity=Error} {msg="Reset order for ports '%s' from IP level do not match the reset order at the SoC level"}
PRT_NO_CONS {severity=Error} {msg="Constant port '%s' at IP level is not constant at SoC level"}
PRT_DF_CONS {severity=Error} {msg="Constant port '%s' at IP level with value %d has a different value %d at SoC level"}
CDC_IN_NSYN {severity=error} {msg="IP level output '%s' associated to clock '%s' is not synchronized at the SoC level"}
CLK_IN_UDEF {severity=error} {msg="IP level clock input '%s' is not connected to a clock at the SoC level"}
CLK_IN_UCKF {severity=error} {msg="IP level clock input '%s' is connected to a clock with different factor at the SoC level"}
CLK_IN_UREL {severity=error} {msg="Clock inputs '%s' and '%s' of instance '%s' are declared as '%s' at IP level, but they are '%s' at the SoC level"}
CLK_IN_WREL {severity=warning} {msg="Clock inputs '%s' and '%s' of instance '%s' are declared as '%s' at IP level, but they are '%s' at the SoC level"}
INV_IN_ASUM {severity=error} {msg="Boundary assumption specified at the IP level is not valid at the SoC level"}
INV_IN_PCND {severity=error} {msg="Precondition for conditional waiver specified at the IP level is not valid at the SoC level"}
INT_IN_PROP {severity=warning} {msg="Internal assumptions at the IP level could not be proven at the SoC level"}
PRT_IN_URAT {severity=Warning} {msg="Clock association of port '%s' at IP level does not match the clock association at the SoC level"}
HDB_IN_LDFL {severity=Error} {msg="Unable to load database: '%s'"}
}

//***************************************************************************
//**    Following is the description of the default CDC parameters   **
//***************************************************************************

// *****************************
// Overall CDC parameters
// *****************************

// Specifies whether the tool should automatically waive off
// structural  violations due to constant/static values handling
// or dangling internal nets.
// Valid values: True | False
// Default value: True
params CDC_APP {apply_auto_waivers="True"}

// Specifies whether the automatic scheme detection should be executed.
// Valid values: True | False
// Default value: True
params CDC_APP {automatic_scheme_detection="True"}

// Specifies whether the automatic NDFF detection should be executed.
// Valid values: True | False
// Default value: True
params CDC_APP {ndff_detection="True"}

// Specifies whether the automatic pulse detection should be executed.
// Valid values: True | False
// Default value: True
params CDC_APP {pulse_detection="True"}

// Specifies whether the automatic edge detection should be executed.
// Valid values: True | False
// Default value: True
params CDC_APP {edge_detection="True"}

// Specifies whether the automatic MUX_NDFF detection should be executed.
// Valid values: True | False
// Default value: True
params CDC_APP {mux_ndff_detection="True"}

// Specifies whether the automatic MUX_PULSE detection should be executed.
// Valid values: True | False
// Default value: True
params CDC_APP {mux_pulse_detection="True"}

// Specifies whether the automatic handshake detection should be executed.
// Valid values: True | False
// Default value: False
params CDC_APP {handshake_detection="True"}

// Specifies whether the automatic FIFO detection should be executed.
// Valid values: True | False
// Default value: False
params CDC_APP {fifo_detection="True"}

// Specifies whether the automatic Gated_Clock scheme detection should be executed.
// Valid values: True | False
// Default value: True
params CDC_APP {gated_clock_detection="True"}

// Specifies whether the automatic Mux_Loop scheme detection should be executed.
// Valid values: True | False
// Default value: True
params CDC_APP {mux_loop_detection="True"}

// Specifies whether the tool only detects NDFF schemes with
// all flops in the same hierarchy or in different hierarchies as long as
// their immediate parent is same.
// Valid values: True | False
// Default value: True
params CDC_APP {strict_ndff_detection="True"}

// Specifies whether the tool detects NDFF schemes with
// logic that does not match the "sync_chain_logic" rule
// between the NDFF synchronizer flops.
// Valid values: True | False
// Default value: False
params CDC_APP {allow_sync_chain_logic="False"}

// Specifies whether the tool detects NDFF schemes with
// fanouts between the NDFF synchronizer flops.
// Valid values: True | False
// Default value: False
params CDC_APP {allow_sync_chain_fanout="False"}

// Specifies whether the information provided by the SDC "-period" switch
// on "create_clock" commands infers the factor for clock declarations.
// Valid values: True | False
// Default value: True
params CDC_APP {use_sdc_clock_period="True"}

// Specifies whether a global stopat should be created for internal
// signals, top outputs and black box inputs defined with
// "config_rtlds -signal -constant".
// Valid values: True | False
// Default value: False
params CDC_APP {add_stopat_for_internal_constants="False"}

// Specifies whether a global stopat should be created for internal
// signals, top outputs and black box inputs defined with
// sdc constant configuration.
// Valid values: True | False
// Default value: True
params CDC_APP {override_sdc_constants="True"}

// Specifies whether the tool should consider all clock signals
// as synchronous by default.
// Valid values: True | False
// Default value: True
params CDC_APP {all_clocks_sync_by_default="True"}

// Specifies whether the tool will treat data ports as asynchronous to all other units.
// NOTE: undeclared reset ports will also follow this behavior.
// NOTE: to set multiple types of ports, use "|" as separator.
// Valid values: all, none, primary_inputs, primary_outputs, primary_inouts, bbox_inputs, bbox_outputs
// Default value: None
params CDC_APP {treat_data_ports_as_async="None"}

// Specifies whether undriven signals should be treated as units in clock analysis
// Valid values: True | False
// Default value: False
params CDC_APP {treat_undriven_as_units="False"}

// Specifies if undeclared (potential) sync enabler should be heuristically detected,
// trying to cover unsynchronized pairs after all composite schemes have been detected
// Valid values: True | False
// Default value: False
params CDC_APP {auto_potential_sync_enabler_detection="False"}

// Specifies whether the tool ignores convergence of data signals that are synchronized
// by complex schemes like FIFO, handshake, and MUX.
// Affects CNV_ST_CONV
// Valid values: True | False
// Default value: False
params CDC_APP {ignore_convergence_from_complex_schemes="False"}

// Specifies whether the tool propagates clocks through mux's selector path
// and discrete gated clock's enable path
// Valid values: True | False
// Default value: True
params CDC_APP {propagate_clock_through_control_path="True"}

// Specifies whether violations should be reported on unconnected load
// Valid values: True | False
// Default value: False
params CDC_APP {report_violations_on_unconnected_load="False"}

// Specifies whether violations covered by a Power-Control-to-Clock constraint
// should be waived or not reported at all
// Valid values: True | False
// Default value: True
params CDC_APP {waive_power_control_to_clock_violations="True"}

// ***************************************************************
// **    Parameters for CDC_CONFIGURATION category of checks    **
// ***************************************************************
// Specifies whether PRT_IS_UNCK violation is automatically waived for Liberty ports with no timing arcs
// Valid values: True | False
// Default value: True
params PRT_IS_UNCK {autowaive_liberty_unclocked_ports_noarc="True"}

// Specifies whether CLK_IS_CONV violations should be reported only when
// asynchronous clocks are involved or if synchronous clocks should also be considered.
// Valid values: True | False
// Default value: False
params CLK_IS_CONV {check_sync_clocks="False"}

// *****************************************************************
// **    Parameters for CDC_SYNCHRONIZATION category of checks    **
// *****************************************************************
// Specifies the minimum number of DFFs in the NDFF synchronizer.
// Valid values: Any integer greater than 1
// Default value: 2
params CDC_NO_SYNC {n_min="2"}

// Specifies the logic type allowed on the CDC path.
// Valid values: Wire | Buf | Logic | Latch
// Default value: Buf
params CDC_PR_LOGC {cdc_pair_logic="Buf"}

// Specifies the logic type allowed on between the NDFF synchronizer flops.
// Valid values: Wire | Buf | Logic | Latch
// Default value: Buf
params SYN_DF_SLGC {sync_chain_logic="Buf"}

// Specifies whether the tool automatically waives a CDC_PR_LOGC
// violation when the source and destination flops have no reset and
// the logic between them is an AND gate with one input connected to
// a reset signal synchronous to the destination flop domain and the
// other input connected to a flop or primary input.
// Valid values: True | False
// Default value: False
params CDC_PR_LOGC {autowaive_reset_clamp_pair_logic="False"}

// Specifies whether the tool automatically ignores any CDC_PR_LOGC
// violation when the pair is not synchronized in destination domain.
// Valid values: True | False
// Default value: True
params CDC_PR_LOGC {do_not_report_unsynchronized_pair_logic="True"}

// *****************************************************************
// **      Parameters for CDC domains of checks                   **
// *****************************************************************

// Specifies whether the tool reports convergence from the same source
// clock domain only, from different source clock domains only, or from both.
// Affects CNV_ST_CONV, CNV_ST_BCNV
// Valid values: Same | Diff | both
// Default value: Both
params CDC {src_unit_domain="Both"}


// Specifies whether convergence comes from the same only source signal,
// only different source signals or both.
// Affects CNV_ST_GLCH, CNV_ST_CONV, CNV_ST_BCNV
// Valid values: Same | Diff | Both
// Default value: Both
params CDC {src_unit_signal="Both"}

// Specifies whether the tool should use RTL constants only or all
// constants in glitch simplification
// Valid values: True | False
// Default value: False
// Affects CLK_IS_CONV, CKS_IS_CONV, CDC_PR_LOGC, CNV_ST_GLCH, RST_RS_CONV
params CDC {use_only_rtl_constants_for_glitch_simplification="False"}

// Specifies the number of flops after the synchronizer flops and before convergence
// point to be considered for convergence analysis.
// Affects CNV_ST_CONV, CNV_ST_BCNV
// Default value: 2
params CDC {depth="2"}

// Specifies whether the tool attempts to find convergence issues inside
// control synchronizers.
// Affects CNV_ST_CONV, CNV_ST_BCNV
// Valid values: True | False
// Default value: False
params CDC {convergence_inside_ctrl_sync="False"}

// Specifies whether unsynchronized paths should be ignored in convergence analysis.
// Affects CNV_ST_CONV, CNV_ST_BCNV
// Valid values: True | False
// Default value: True
params CDC {ignore_unsync_paths_in_convergence="True"}

// Specifies whether to group and report convergences on an FSM state
// register when at least one of the FSM transitions or states is controlled
// by more than one convergent CDC signals
// Affects CNV_ST_CONV, CNV_ST_BCNV
// Valid values: True | False
// Default value: False
params CDC {group_fsm_convergences="False"}

// Specifies whether the tool propagates constants through flops
// Valid values: True | False
// Default value: False
params CDC {flop_constant_propagation="False"}

// Specifies whether the tool propagates constants through latches
// Valid values: True | False
// Default value: False
params CDC {latch_constant_propagation="False"}

// Specifies whether the tool considers liberty clock pin as datapath
// Valid values: True | False
// Default value: False
params CDC {liberty_clock_pin_as_datapath="False"}

// Specifies whether the glitch should look for glitches for all pairs
// or only the ones that have a synchronizer
// Valid values: All | Covered
// Default value: Covered
params CNV_ST_GLCH {glitch_check="Covered"}

// *****************************
// Overall RDC parameters
// *****************************
// Common parameters for RDC Domain

// Specifies whether the automatic detection of reset synchronizers
// is executed.
// Reset synchronizers are detected only for declared reset signals.
// Valid values: True | False
// Default value: True
params RDC {auto_reset_sync_detection="True"}

// Specifies whether only RTL constants can be used in the fanin of classic
// reset synchronizers.
// Valid values: True | False
// Default value: False
params RDC {rtl_constant_for_reset_scheme="False"}

// Specifies whether reset schemes should be detected only when all flops
// in the chain are in the same hierarchy.
// Valid values: True | False
// Default value: True
params RDC {strict_reset_scheme_detection="True"}

// Specifies whether the tool detects reset synchronizers with
// logic that does not match the "reset_sync_chain_logic" rule
// between the reset synchronizer flops.
// Valid values: True | False
// Default value: False
params RDC {allow_reset_sync_chain_logic="False"}

// Switch between optimistic and pessimistic reset modes
// Valid values: True | False
// Default value: False
params RDC {report_violations_on_undeclared_reset="False"}

// Specifies whether the tool treats the reset rating of data ports as
// asynchronous to all resets when not manually rated.
// NOTE: To set multiple types of ports, use "|" as separator.
// Valid values: all, none, primary_inputs, primary_outputs, primary_inouts, bbox_inputs, bbox_outputs
// Default value: None
params RDC {treat_data_ports_reset_as_async="None"}

// Specifies if a non-resettable destination flop should be considered for reporting
// RDC_RS_DFRS and RDC_RS_SYCA violations.
// Valid values: True | False
// Default value: False
params RDC {ignore_non_resettable_flop="False"}

// ***************************************************************
// **    Parameters for RDC_CONFIGURATION category of checks    **
// ***************************************************************

// Specifies whether internal nets in the fan-in of reset pins can be reported
// as undeclared resets even when they are connected to declared resets through
// combinational logic. When this parameter is "false", internal nets are reported
// as undeclared reset in the above scenario. When this parameter is "true",
// internal nets are not reported as undeclared reset in this scenario.
// Affects RST_NO_DECL, FLP_RS_UDCL
// Valid values: True | False
// Default value: False
params RDC {ignore_internal_non_declared_resets="False"}

// *****************************************************************
// **   Parameters for RST_SYNCHRONIZATION category of checks     **
// *****************************************************************

// Specifies the minimum number of flops in the reset synchronizer.
// Valid values: Any integer greater than 1
// Default value: 2
params RST_NO_SYNC {reset_min_dff="2"}

// Specifies the logic type allowed between the flops in the
// synchronizer chain of the reset synchronizer.
// Valid values: Wire | Buf | Logic | Latch
// Default value: Buf
params SYN_RS_SLGC {reset_sync_chain_logic="Buf"}

// Specifies if RST_RS_CONV violations should be automatically waived when the only
// logic present in the reset path is due to the synthesis of preset and clear pins of
// the flop.
// NOTE: This rule must be turned on before elaboration or automatic waivers are not created.
// Valid values: True | False
// Default value: True
params RST_RS_CONV {autowaive_reset_clear_logic="True"}

// Specifies whether RST_RS_CONV violations should be reported when the same net drives all the
// inputs of the convergence. The default is False.
// Valid values: True | False
// Default value: False
params RST_RS_CONV {report_convergence_same_driver="False"}

// Specifies whether "different_reset" violations are automatically waived
// for reset crossing paths that include an NDFF.
// Valid values: True | False
// Default value: True
params RDC_RS_DFRS {autowaive_rdc_with_ndff="True"}

// Specifies whether the tool should generate RDC pairs
// if source and destination are driven by the same user-declared reset
// ignoring logic on the path
// Valid values: True | False
// Default value: True
params RDC_RS_DFRS {ignore_rdc_from_same_reset_source="True"}

// Specifies whether "reset_in_datapath" violations are ignored on
// units that are part of control schemes when the reset source is
// a fully synchronous reset definition.
// Valid values: True | False
// Default value: True
params RST_RS_RIDP {ignore_reset_in_datapath_for_control_sync="True"}

// Specifies whether "different_reset" violations are reported for ports with
// no reset association.
// Valid values: True | False
// Default value: False
params RDC_RS_DFRS {treat_boundaries_as_rdc="False"}
