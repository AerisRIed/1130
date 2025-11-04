//------------------------------------------------------------------------------
//
//                   Copyright (c) 2016
//                   Cadence Design Systems, Inc.
//                   All rights reserved.
//
//  This work may not be copied, modified, re-published, uploaded, executed, or
//  distributed in any way, in any medium, whether in whole or in part, without
//  prior written permission from Cadence Design Systems, Inc.
//------------------------------------------------------------------------------
//
//   Module Name    : cdnsdru_message_bus_top_v4
//
//   Author         : Dongdong Wang
//
//   Date           : July 23, 2025
//
//   Limitations    :
//
//   Notes          : Based on cdnsdru_pcie_message_bus_top_v4 authored by Thomas Faison
//---------------------------------------------------------------------------------
//   Description    :	PCIe Message Bus Top Module
//			This module is the top level module of the PCIe message bus
//			including PIPE interface transmit/receive, PMA interface transmit/
//			receive and co-ordination between PIPE and PMA interfaces.
//---------------------------------------------------------------------------------

module cdnsdru_usb4_message_bus_top_v4 (

input			mb_mac2phy_clk, 		// PHY MB MAC2PHY Clock: Based on PIPE interface data width --> 500MHz (32-bit) or 1GHz (16-bit)
input			mb_mac2phy_rstn,		// PHY MB MAC2PHY Reset: Active Low

input			mb_phy2mac_clk, 	       	// PHY MB PHY2MAC Clock: Based on PIPE interface data width --> 500MHz (32-bit) or 1GHz (16-bit)
input			mb_phy2mac_rstn,		// PHY MB PHY2MAC Reset: Active Low
input			scanmode,			// PHY scan mode signal

input			rx_signal_detect,		// PMA: Receiver Signal Detect
input			rx_mrgn_valid,			// PMA: Receiver Margin Valid
input		[5:0]	rx_mrgn_errcnt,			// PMA: Receiver Margin Error Count

input			mb_cdb_reset,			// PHY CDB: Soft Reset for entire MB block including all sub-blocks
input			mb_cdb_rx_reset,		// PHY CDB: Soft Reset for PIPE interface receive logic (mb_pipe_rx_ctrl.v)
input			mb_cdb_tx_reset,		// PHY CDB: Soft Reset for PIPE interface transmit logic (mb_pipe_tx_ctrl.v)
input			mb_cdb_pma_reset,		// PHY CDB: Soft Reset for PMA interface transmit/receive logics (lm_pma_txrx_ctrl.v)
input			mb_cdb_ctrl_reset,		// PHY CDB: Soft Reset for master co-ordintation controller logics (lm_phy_ctrl.v)
input		[3:0]	lm_cdb_pma_wait,		// PHY CDB: Programmable wait time for between rx_mrgn_offset loading and rx_mrgn_req assertion
input		[5:0]	lm_cdb_sample_3logn,		// PHY CDB: Programmable Rx margining sample count
input		[7:0]	lm_cdb_sample_max,		// PHY CDB: Programmable Rx margining sample count max value (Default: 8'd127)
input		[7:0]	lm_cdb_sample_threshold,	// PHY CDB: Programmable Rx margining sample count threshold (Default: 8'd129)
input		[7:0]	lm_cdb_pma_direction,		// PHY CDB: Programmable margin direction to handle PIPE and PMA encodings for margin direction
input		[5:0]	lm_cdb_error_max,		// PHY CDB: Programmable Rx margining error count max value (Default: 6'd63)
input		[5:0]	lm_cdb_error_threshold,		// PHY CDB: Programmable Rx margining error count threshold (Default: 6'd63)
input		[5:0]	lm_cdb_timing_offset,		// PHY CDB: Programmable Max timing offset value supported by PMA
input		[6:0]	lm_cdb_voltage_offset,		// PHY CDB: Programmable Max voltage offset value supported by PMA

input			rx_eq_training_cmpl_stb,        // Single cycle strobe to initiate a write to MAC Rx Status0 register (bit 0)

// Elastic buffer control/status
input			lm_eb_sts_upd,			// PHY PCS: Elastic Buffer Status Update
input		[7:0]	lm_eb_sts,			// PHY PCS: Elastic Buffer Status
output	wire		lm_eb_ctrl_upd,			// PHY PCS: Elastic Buffer Control Update
output	wire	[7:0]	lm_eb_ctrl,			// PHY PCS: Elastic Buffer Control 

`ifdef LM_DEP_OPTION
input                   lm_dep,
`endif



output	wire		mb_cdb_invalid_addr_uncom,	// PHY CDB: Invalid address detected during MAC uncommitted write
output 	wire		mb_cdb_invalid_addr_com,	// PHY CDB: Invalid address detected during MAC committed write
output	wire		lm_cdb_smplcnt_saturated,	// PHY CDB: Sample Count Saturated
output	wire		lm_cdb_errcnt_saturated,	// PHY CDB: Error Count Saturated

output	wire		rx_mrgn_req,			// PMA: Receiver Margin Request
output	wire	[1:0]	rx_mrgn_dir,			// PMA: Receiver Margin Direction
output	wire	[6:0]	rx_mrgn_offset,			// PMA: Receiver Margin Offset

// IO Recal interface with PHY
input			p2m_recal_req,
input			phy_recal_done,
output			m2p_recal_req,

`ifdef PAM4_RESTRICTED_LEVELS
output                  PAM4RestrictedLevels,
`endif
output                  NELBEnable,
output          [2:0]   NELBPosition,


//Output signals that replace pre-PIPE5 wires
output wire             rx_polarity,
output wire     [17:0]  tx_deemph,
output wire     [23:0]  tx_deemph_cx,
output wire             tx_deemph_strobe,
output wire     [5:0]   tx_local_preset_index,
output wire             tx_get_local_preset_coef,
output wire             rx_eq_training,
output wire             rx_invalid_request,
output wire             rx_eq_in_progress,
output wire             rx_eq_eval,
//output wire     [1:0]   tx_pattern,
output wire             tx_ones_zeros,
//output wire     [7:0]   tx_fs_g67,
//output wire     [7:0]   tx_lf_g67,
//output wire     [5:0]   tx_fs_legacy,
//output wire     [5:0]   tx_lf_legacy,
output wire             tx_swing,
output wire     [2:0]   tx_margin,
output wire             tx_swgmgn_strobe,
output wire             tx_128b_enc_byp,
output wire             tx_lfps_select,
output wire             eb_mode,

//Inputs to collect pre-PIPE5 wires onto message bus
input  wire             pcs_pipe_lnn_clk_out_en,
input  wire     [5:0]   local_fs_g67,
input  wire     [5:0]   local_lf_g67,
input  wire     [5:0]   local_fs_legacy,
input  wire     [5:0]   local_lf_legacy,
input  wire             tx_coef_valid,
input  wire             tx_local_fs_lf_valid,
input  wire    [17:0]   tx_preset_coef_legacy,
input  wire    [23:0]   tx_preset_coef_g67,
input  wire             rx_eq_eval_sel,
input  wire    [11:0]   rx_link_eval_fb_dir_change_g67,
input  wire     [5:0]   rx_link_eval_fb_dir_change_legacy,
input  wire     [7:0]   rx_link_eval_fb_fom,
input  wire     [3:0]   pipe_rate,
input  wire             phy_status,

//M2P and P2M data busses
input		[7:0]	mb_pipe_rx_data,		// PHY: PIPE Lane Margining Receive data bus
output	wire	[7:0]	mb_pipe_tx_data,		// PHY: PIPE Lane Margining Transmit data bus
input			mb_pipe_tx_disable		// PHY: PIPE Lane Margining Transmit data bus disable

);

//--------------------------------------------------------------------
// Local Variables
//--------------------------------------------------------------------

   wire 		lm_pma_ack;
   wire 		lm_pma_req;
   wire 		mb_cdb_ctrl_reset_mac2phy_sync;
   wire 		mb_cdb_pma_reset_mac2phy_sync;
   wire 		mb_cdb_reset_phy2mac_sync;
   wire 		mb_cdb_reset_mac2phy_sync;
   wire 		mb_cdb_rx_reset_mac2phy_sync;
   wire 		mb_cdb_tx_reset_phy2mac_sync;
   wire 		mb_rx_cmd_complete;
   wire [5:0]		mb_tx_cmd_done;
   wire [5:0]		mb_tx_cmd_done_mac2phy_sync;
   wire 		mb_tx_cmd_req_phy2mac_sync;
   //wire 		rx_write_com;
   wire 		rx_mrgn_valid_sync;
   wire 		rx_signal_detect_sync;
   wire 		wait_for_valid_mac2phy_sync;
   wire 		allfslf_sent_mac2phy_sync;   
   wire 		phy_status_mac2phy_sync;
   wire 		tx_coef_valid_mac2phy_sync;
   wire 		tx_coef_valid_selected;
   wire [11:0] 		mb_rx_address; 
   wire [17:0] 		tx_preset_coef_legacy_reg;
   wire [23:0] 		tx_preset_coef_g67_reg;
   wire [1:0] 		lm_pma_direction;
   wire [3:0] 		mb_rx_command;
   wire [2:0] 		mb_tx_wrb_cnt;
   wire [23:0] 		p2m_mb_tx_bus_values_r0;
   wire [23:0] 		mb_tx_bus_values_r0;
   wire [23:0] 		mb_tx_bus_values_r1;
   wire [23:0] 		mb_tx_bus_values_r2;
   wire [23:0] 		mb_tx_bus_values_r3;
   wire [23:0] 		mb_tx_bus_values_r4;
   wire [3:0] 		phy_reg000;
   wire [5:0] 		lm_pma_errcnt;
   wire [7:0] 		local_fs_reg;
   wire [7:0] 		local_lf_reg;
   wire [6:0] 		lm_pma_offset;
   wire [7:0] 		mac_reg000;
   wire [7:0] 		mac_reg001;
   wire [7:0] 		mac_reg002;
   wire [7:0] 		mac_reg003;
   wire [7:0] 		mb_rx_data;
   wire [7:0] 		phy_reg001;
   wire [7:0] 		rx_link_eval_status0;
   wire [7:0] 		rx_link_eval_status1;
   wire [7:0] 		rx_link_eval_status2;
   wire [7:0] 		rx_link_eval_status3;
   wire [3:0] 		lm_tx_writes;
   //wire [7:0] 		tx_fs;
   //wire [7:0] 		tx_lf;

   wire [3:0] 		pipe_rate_mac2phy_sync;
   wire [16:0] 		prio_tx_writes_done;

   localparam SYNC_DEPTH = 'd5;

   reg [5:0] 		rx_link_eval_fb_dir_change_legacy_reg;
   reg [11:0] 		rx_link_eval_fb_dir_change_g67_reg;
   reg [7:0] 		rx_link_eval_fb_fom_reg;

   wire 		pclk64_rate_change;
//`ifndef PAM4_RESTRICTED_LEVELS
//   wire 		PAM4RestrictedLevels;
//`endif
`ifndef LM_DEP_OPTION
   wire 		lm_dep = 0;
`endif

   wire mb_cdb_tx_reset_disable;

   //wire g4fslf_sent;
   //wire g5fslf_sent;
   //wire g67fslf_sent;
   //wire fslf_sent;
   //wire rx_write_ack;
//--------------------------------------------------------------------
// Remapping/renaming
//--------------------------------------------------------------------
   //assign tx_fs_g67 = tx_fs;
   //assign tx_lf_g67 = tx_lf;
   //assign tx_fs_legacy = tx_fs[5:0];
   //assign tx_lf_legacy = tx_lf[5:0];

//--------------------------------------------------------------------
// Instantiation of PIPE interface transmit logic (mb_pipe_tx_ctrl.v)
//--------------------------------------------------------------------

cdnsdru_usb4_message_bus_pipe_tx_ctrl_v4 u_cdnsdru_usb4_message_bus_pipe_tx_ctrl_v4 (

.pipe_phy2mac_clk       (mb_phy2mac_clk),		// PHY MB PHY2MAC Clock: Based on PIPE interface data width --> 500MHz (32-bit) or 1GHz (16-bit)
.pipe_phy2mac_rstn	(mb_phy2mac_rstn),		// PHY MB PHY2MAC Reset: Active Low
.mb_cdb_reset		(mb_cdb_reset_phy2mac_sync),	// PHY CDB: Synchronized Soft Reset for entire MB block including all sub-blocks
.mb_cdb_tx_reset	(mb_cdb_tx_reset_phy2mac_sync),	// PHY CDB: Synchronized Soft Reset for PIPE interface transmit logic (mb_pipe_rx_ctrl.v)
.mb_tx_cmd_req		(p2m_mb_tx_cmd_req),		// MB Controller: Command Transmission Request
.mb_tx_ack_req		(p2m_mb_tx_ack_req),		// MB Controller: Specific ACK Transmission Request

.mb_tx_wrb_cnt		(mb_tx_wrb_cnt),
.p2m_mb_tx_bus_values_r0 (p2m_mb_tx_bus_values_r0),	// MB Tx Controller: Transmit Command values
.mb_tx_bus_values_r1	(mb_tx_bus_values_r1),		// MB Tx Controller: Transmit Command values
.mb_tx_bus_values_r2	(mb_tx_bus_values_r2),		// MB Tx Controller: Transmit Command values
.mb_tx_bus_values_r3	(mb_tx_bus_values_r3),		// MB Tx Controller: Transmit Command values
.mb_tx_bus_values_r4	(mb_tx_bus_values_r4),		// MB Tx Controller: Transmit Command values

.mb_tx_cmd_done		(mb_tx_cmd_done),		// MB Controller: Command Transmitted Acknowledgement
.mb_pipe_tx_data	(mb_pipe_tx_data)		// PHY: PIPE Lane Margining Transmit data bus

);

//--------------------------------------------------------------------
// Instantiation of PIPE interface receive logic (mb_pipe_rx_ctrl.v)
//--------------------------------------------------------------------

cdnsdru_usb4_message_bus_pipe_rx_ctrl_v4 u_cdnsdru_usb4_message_bus_pipe_rx_ctrl_v4 (

.pipe_mac2phy_clk	(mb_mac2phy_clk),		// PHY MB MAC2PHY Clock: Based on PIPE interface data width --> 500MHz (32-bit) or 1GHz (16-bit)
.pipe_mac2phy_rstn	(mb_mac2phy_rstn),		// PHY MB MAC2PHY Reset: Active Low
.mb_enable		(1'b1),				// PHY: MB Enable when PCIe Gen4 and P0 state
.mb_cdb_reset		(mb_cdb_reset_mac2phy_sync),	// PHY CDB: Synchronized Soft Reset for entire MB block including all sub-blocks
.mb_cdb_rx_reset	(mb_cdb_rx_reset_mac2phy_sync),	// PHY CDB: Synchronized Soft Reset for PIPE interface receive logic (mb_pipe_rx_ctrl.v)
.mb_pipe_rx_data	(mb_pipe_rx_data),		// PHY: PIPE Lane Margining Receive data bus
.mb_rx_cmd_complete	(mb_rx_cmd_complete),		// MB Controller: MB command received successfully (independent of validity)
.mb_rx_command		(mb_rx_command),		// MB Controller: MB received command
.mb_rx_data		(mb_rx_data),			// MB Controller: MB received data
.mb_rx_address		(mb_rx_address)			// MB Controller: MB received command address

);

//--------------------------------------------------------------------
// Instantiation of PMA interface transmit/receive logic (lm_pma_txrx_ctrl.v)
//--------------------------------------------------------------------

cdnsdru_usb4_message_bus_pma_txrx_ctrl_v4 u_cdnsdru_usb4_message_bus_pma_txrx_ctrl_v4 (

.pipe_mac2phy_clk	(mb_mac2phy_clk),	// PHY MB MAC2PHY Clock: Based on PIPE interface data width --> 500MHz (32-bit) or 1GHz (16-bit)
.pipe_mac2phy_rstn	(mb_mac2phy_rstn),	// PHY MB MAC2PHY Reset: Active Low
.mb_enable		(1'b1),			// PHY: MB Enable when PCIe Gen4 and P0 state
.mb_cdb_reset		(mb_cdb_reset_mac2phy_sync),	// PHY CDB: Synchronized Soft Reset for entire MB block including all sub-blocks
.mb_cdb_pma_reset	(mb_cdb_pma_reset_mac2phy_sync),	// PHY CDB: Synchronized Soft Reset for PMA interface transmit/receive logic (lm_pma_txrx_ctrl.v)
.lm_cdb_pma_wait	(lm_cdb_pma_wait),	// PHY CDB: Programmable wait time between PMA offset and request
.lm_cdb_pma_direction	(lm_cdb_pma_direction),	// PHY CDB: Programmable PMA Rx margining direction
.lm_dep	   	        (lm_dep),		// PHY select destructive margining
.lm_pma_req		(lm_pma_req),		// LM Controller: Request to initiate PMA Rx margining
.lm_pma_direction	(lm_pma_direction),	// LM Controller: Direction (East/West/North/South) for PMA Rx margining
.lm_pma_offset		(lm_pma_offset),	// LM Controller: Offset for PMA Rx margining
.lm_pma_ack		(lm_pma_ack),		// LM Controller: PMA Rx margining completed acknowledgment
.lm_pma_errcnt		(lm_pma_errcnt),	// LM Controller: PMA Rx margining error count
.rx_signal_detect	(rx_signal_detect_sync),	// PMA: Synchronized Receiver Signal Detect
.rx_mrgn_valid		(rx_mrgn_valid_sync),	// PMA: Synchronized Rx margin valid indicating that PMA finished current rx margining
.rx_mrgn_errcnt		(rx_mrgn_errcnt),	// PMA: Rx margin error count for the current rx margining iteration
.rx_mrgn_req		(rx_mrgn_req),		// PMA: Request to initiate PMA Rx margining
.rx_mrgn_dir		(rx_mrgn_dir),		// PMA: Direction (East/West/North/South) for PMA Rx margining
.rx_mrgn_offset		(rx_mrgn_offset)	// PMA: Offset for PMA Rx margining

);

//--------------------------------------------------------------------
// Instantiation of PIPE interface receive logic (lm_phy_ctrl.v)
//--------------------------------------------------------------------

cdnsdru_usb4_message_bus_gen_reg_ctrl_v4 u_cdnsdru_usb4_message_bus_gen_reg_ctrl_v4 (

.pipe_mac2phy_clk		(mb_mac2phy_clk),		// PHY MB Clock: Based on PIPE interface data width --> 500MHz (32-bit) or 1GHz (16-bit)
.pipe_mac2phy_rstn		(mb_mac2phy_rstn),		// PHY MB MAC2PHY Reset: Active Low
.mb_enable			(1'b1),		// PHY: MB Enable when PCIe Gen4 and P0 state
.mb_cdb_reset			(mb_cdb_reset_mac2phy_sync),		// PHY CDB: Synchronized Soft Reset for entire MB block including all sub-blocks
.mb_cdb_ctrl_reset		(mb_cdb_ctrl_reset_mac2phy_sync),	// PHY CDB: Synchronized Soft Reset for entire MB Controller
.mb_cdb_invalid_addr_uncom	(mb_cdb_invalid_addr_uncom),	// PHY CDB: Invalid address detected during MAC uncommitted write
.mb_cdb_invalid_addr_com	(mb_cdb_invalid_addr_com),	// PHY CDB: Invalid address detected during MAC committed write
.mb_rx_cmd_complete		(mb_rx_cmd_complete),		// MB Rx Controller: MB command received successfully (independent of validity)
.mb_rx_command			(mb_rx_command),		// MB Rx Controller: MB received command
.mb_rx_data			(mb_rx_data),			// MB Rx Controller: MB received data
.mb_rx_address			(mb_rx_address),		// MB Rx Controller: MB received command address
.mb_tx_cmd_done			(mb_tx_cmd_done_mac2phy_sync),	// MB Tx Controller: Command Transmitted Acknowledgement
.mb_tx_cmd_req			(mb_tx_cmd_req),		// MB Tx Controller: Command Transmission Request
.mb_tx_ack_req			(mb_tx_ack_req),		// MB Tx Controller: ACK Transmission Request
.mb_tx_wrb_cnt			(mb_tx_wrb_cnt),		// MB Tx Controller: Transmit Uncommitted writes count
.mb_tx_bus_values_r0		(mb_tx_bus_values_r0),		// MB Tx Controller: Transmit Command values
.mb_tx_bus_values_r1		(mb_tx_bus_values_r1),		// MB Tx Controller: Transmit Command values
.mb_tx_bus_values_r2		(mb_tx_bus_values_r2),		// MB Tx Controller: Transmit Command values
.mb_tx_bus_values_r3		(mb_tx_bus_values_r3),		// MB Tx Controller: Transmit Command values
.mb_tx_bus_values_r4		(mb_tx_bus_values_r4),		// MB Tx Controller: Transmit Command values

// Common control signals to reg blocks
//.rx_write_ack	       	        (rx_write_ack),			// MB reg blocks: rx (M2P) ack has been received
.lm_rx_write_ack       	        (lm_rx_write_ack),		// MB reg blocks: rx (M2P) ack has been received for key lm write
//.rx_write_com	       	        (rx_write_com),			// MB reg blocks: Phy2MAC write in progress
.prio_tx_writes_done	       	(prio_tx_writes_done),		// MB reg blocks: TX ACK-has-been-requested indication for each function
`ifdef PAM4_RESTRICTED_LEVELS
.PAM4RestrictedLevels           (PAM4RestrictedLevels),		// Optional output for PIPE 6.1.1 and above
`endif
.NELBEnable                     (NELBEnable),			// Near-end loopback enable
.NELBPosition                   (NELBPosition),			// Near-end loopback position


// Signals to/from LM register block
.ebsts_tx_write      		(ebsts_tx_write),		// MB LM block: Elastic buffer status (to be sent to MAC)
.mac_reg000			(mac_reg000),			// MB LM block: Local version of register
.mac_reg001			(mac_reg001),			// MB LM block: Local version of register
.mac_reg002			(mac_reg002),			// MB LM block: Local version of register
.mac_reg003			(mac_reg003),			// MB LM block: Local version of register
.phy_reg000			(phy_reg000),			// MB LM block: Local version of register
.phy_reg001			(phy_reg001),			// MB LM block: Local version of register
.lm_tx_writes                   (lm_tx_writes),			// MB LM block: LM tx_write request
.eb_ctrl_upd                    (lm_eb_ctrl_upd),		// MB LM block: Elastic buffer control update indicator
.eb_ctrl                        (lm_eb_ctrl),			// MB LM block: Elastic buffer control
.lm_dep		   	        (lm_dep),			// PHY select destructive margining

// Signals to/from coefficient register block
.allfslf_sent_mac2phy_sync      (allfslf_sent_mac2phy_sync),	// MB allfslf: Post-reset FS/LF sent indication
.tx_preset_coef_legacy_reg	(tx_preset_coef_legacy_reg),	// MB Coef reg ctrl: tx_preset_coef register value (18 bits)
.tx_preset_coef_g67_reg          (tx_preset_coef_g67_reg),	// MB Coef reg ctrl: tx_preset_coef register value (24 bits)
.coef_legacy_tx_write           (coef_legacy_tx_write),		// MB Coef reg ctrl: tx_write request for coefs
.coef_g67_tx_write               (coef_g67_tx_write),		// MB Coef reg ctrl: tx_write request for coefs
.cofslf_tx_write                (cofslf_tx_write),		// MB Coef reg ctrl: tx_write request for coefs + fs/lf
.cog4fslf_tx_write              (cog4fslf_tx_write),		// MB Coef reg ctrl: tx_write request for coefs + G4 fs/lf
.cog5fslf_tx_write              (cog5fslf_tx_write),		// MB Coef reg ctrl: tx_write request for coefs + G5 fs/lf
.fslf_tx_write                  (fslf_tx_write),		// MB Coef reg ctrl: tx_write request for fs/lf
.g4fslf_tx_write                (g4fslf_tx_write),		// MB Coef reg ctrl: tx_write request for G4 fs/lf
.g5fslf_tx_write                (g5fslf_tx_write),		// MB Coef reg ctrl: tx_write request for G5 fs/lf
.g67fslf_tx_write                (g67fslf_tx_write),		// MB Coef reg ctrl: tx_write request for G67 fs/lf
.local_fs_reg                   (local_fs_reg),			// MB Coef reg ctrl: registered PCS FS value
.local_lf_reg                   (local_lf_reg),			// MB Coef reg ctrl: registered PCS LF value
//.fslf_sent                      (fslf_sent),			// MB Coef reg ctrl: fs/lf blocks-sent indicator
//.g4fslf_sent                    (g4fslf_sent),			// MB Coef reg ctrl: G4 fs/lf blocks-sent indicator
//.g5fslf_sent                    (g5fslf_sent),			// MB Coef reg ctrl: G5 fs/lf blocks-sent indicator
//.g67fslf_sent                    (g67fslf_sent),			// MB Coef reg ctrl: G67 fs/lf blocks-sent indicator
.pclk64_rate_change             (pclk64_rate_change),		// MB Coef reg ctrl: Indicate rate change to 64GT

// Signals to/from RX eval status register block
.eval_g67_tx_write               (eval_g67_tx_write),		// MB Eval reg ctrl: tx_write request for eval
.eval_legacy_tx_write           (eval_legacy_tx_write),		// MB Eval reg ctrl: tx_write request for eval
.fom_tx_write                   (fom_tx_write),			// MB Eval reg ctrl: tx_write request for fom
.rx_link_eval_status0           (rx_link_eval_status0),		// MB Eval reg ctrl: Eval status bus
.rx_link_eval_status1           (rx_link_eval_status1),		// MB Eval reg ctrl: Eval status bus
.rx_link_eval_status2           (rx_link_eval_status2),		// MB Eval reg ctrl: Eval status bus
.rx_link_eval_status3           (rx_link_eval_status3),		// MB Eval reg ctrl: Eval status bus

// Signals to/from IORecal and training functions
.phyiorecalreq_tx_write         (phyiorecalreq_tx_write),
.iorecaldone_tx_write           (iorecaldone_tx_write),
.rx_m2p_recal_req               (rx_m2p_recal_req),
.phyiorecalreq_sent             (phyiorecalreq_sent),
.iorecaldone_sent               (iorecaldone_sent),
.rx_eq_training_cmpl_tx_write   (rx_eq_training_cmpl_tx_write),

//4.4.1 pins decoded from message bus registers
.rx_polarity			(rx_polarity),
.tx_deemph			(tx_deemph),
.tx_deemph_cx			(tx_deemph_cx),
.tx_deemph_strobe               (tx_deemph_strobe),
.tx_local_preset_index	       	(tx_local_preset_index),
.tx_get_local_preset_coef      	(tx_get_local_preset_coef),
.rx_eq_training			(rx_eq_training),
.rx_invalid_request	       	(rx_invalid_request),
.rx_eq_in_progress	       	(rx_eq_in_progress),
.rx_eq_eval			(rx_eq_eval),
//.tx_pattern			(tx_pattern),
.tx_ones_zeros			(tx_ones_zeros),
//.tx_fs				(tx_fs),
//.tx_lf				(tx_lf),
.tx_swing			(tx_swing),
.tx_margin			(tx_margin),
.tx_swgmgn_strobe               (tx_swgmgn_strobe),
.tx_128b_enc_byp	       	(tx_128b_enc_byp),
.tx_lfps_select             (tx_lfps_select),
.eb_mode			(eb_mode)
);


cdnsdru_usb4_message_bus_lm_regs_v4 u_cdnsdru_usb4_message_bus_lm_regs_v4 (

.pipe_mac2phy_clk	       	(mb_mac2phy_clk),		// PHY MB Clock: Based on PIPE interface data width --> 500MHz (32-bit) or 1GHz (16-bit)
.pipe_mac2phy_rstn		(mb_mac2phy_rstn),		// PHY MB MAC2PHY Reset: Active Low
.mb_enable			(1'b1),      	// PHY MB Enable when PCIe Gen4 and P0 state
.mb_cdb_reset			(mb_cdb_reset_mac2phy_sync),		// PHY CDB: Synchronized Soft Reset for entire MB block including all sub-blocks
.mb_cdb_ctrl_reset		(mb_cdb_ctrl_reset_mac2phy_sync),	// PHY CDB: Synchronized Soft Reset for entire MB Controller
.lm_cdb_sample_3logn		(lm_cdb_sample_3logn),		// PHY CDB: Programmable Rx margining sample count 3 * log2 (N)
.lm_cdb_sample_max		(lm_cdb_sample_max),		// PHY CDB: Programmable Rx margining sample count max value (Default: 8'd127)
.lm_cdb_sample_threshold	(lm_cdb_sample_threshold),	// PHY CDB: Programmable Rx margining sample count threshold (Default: 8'd129)
.lm_cdb_error_max		(lm_cdb_error_max),		// PHY CDB: Programmable Rx margining error count max value (Default: 6'd63)
.lm_cdb_error_threshold		(lm_cdb_error_threshold),	// PHY CDB: Programmable Rx margining error count threshold (Default: 6'd63)

.lm_cdb_smplcnt_saturated	(lm_cdb_smplcnt_saturated),	// PHY CDB: Sample Count Saturated
.lm_cdb_errcnt_saturated	(lm_cdb_errcnt_saturated),	// PHY CDB: Error Count Saturated
.rx_signal_detect		(rx_signal_detect_sync),	// PMA: Synchronized Receiver Signal Detect
.rx_mrgn_valid		        (rx_mrgn_valid_sync),	        // PMA: Synchronized Rx margin valid indicating that PMA finished current rx margining
 .lm_pma_ack			(lm_pma_ack),			// LM PMA Controller: PMA Rx margining completed acknowledgment
.lm_pma_errcnt			(lm_pma_errcnt),		// LM PMA Controller: PMA Rx margining error count
.lm_pma_req			(lm_pma_req),			// LM PMA Controller: Request to initiate PMA Rx margining
.lm_pma_direction		(lm_pma_direction),		// LM PMA Controller: Direction (East/West/North/South) for PMA Rx margining
.lm_pma_offset			(lm_pma_offset),	       	// LM PMA Controller: Offset for PMA Rx margining
.lm_cdb_timing_offset		(lm_cdb_timing_offset),		// PHY CDB: Programmable Max timing offset value supported by PMA
.lm_cdb_voltage_offset		(lm_cdb_voltage_offset),	// PHY CDB: Programmable Max voltage offset value supported by PMA

.lm_eb_sts_upd			(lm_eb_sts_upd),		// PHY Elastic buffer update
.lm_eb_sts		        (lm_eb_sts),		    	// PHY Elastic buffer status

.lm_dep		   	        (lm_dep),		// PHY select destructive margining

// Control and data signals from the gen reg control block
.ebsts_tx_write      		(ebsts_tx_write),
.prio_tx_writes_done_sts       	(prio_tx_writes_done[0]),
.prio_tx_writes_done_lm	       	(prio_tx_writes_done[4:1]),
//.rx_write_com 			(rx_write_com),
.lm_rx_write_ack         	(lm_rx_write_ack),
.phy_reg000 			(phy_reg000),
.phy_reg001 			(phy_reg001),
.lm_tx_writes			(lm_tx_writes),
.mac_reg000 			(mac_reg000),
.mac_reg001 			(mac_reg001),
.mac_reg002 			(mac_reg002),
.mac_reg003 			(mac_reg003)
);

cdnsdru_usb4_message_bus_preset_coef_regs_v4 u_cdnsdru_usb4_message_bus_preset_coef_regs_v4 (

.pipe_mac2phy_clk	       	(mb_mac2phy_clk),
.pipe_mac2phy_rstn	       	(mb_mac2phy_rstn),
.pipe_phy2mac_clk               (mb_phy2mac_clk),
.pipe_phy2mac_rstn              (mb_phy2mac_rstn),
.mb_enable			(1'b1),
.cdb_reset			(mb_cdb_reset_mac2phy_sync),
.cdb_ctrl_reset			(mb_cdb_ctrl_reset_mac2phy_sync),

.tx_coef_valid_mac2phy_sync	(tx_coef_valid_selected),
.prio_tx_writes_done_coef	({prio_tx_writes_done[13:11],prio_tx_writes_done[6],1'b0,prio_tx_writes_done[16],prio_tx_writes_done[5]}),
.tx_get_local_preset_coef      	(tx_get_local_preset_coef),
.tx_local_preset_index	       	(tx_local_preset_index),
.coef_legacy_tx_write		(coef_legacy_tx_write),
.coef_g67_tx_write		(coef_g67_tx_write),
//.rx_write_ack	         	(rx_write_ack),
//.fslf_sent                      (fslf_sent),
//.g4fslf_sent                    (g4fslf_sent),
//.g5fslf_sent                    (g5fslf_sent),
//.g67fslf_sent                    (g67fslf_sent),
.wait_for_valid_mac2phy_sync    (wait_for_valid_mac2phy_sync),
.allfslf_sent_mac2phy_sync      (allfslf_sent_mac2phy_sync),
.pcs_pipe_lnn_clk_out_en_sync  	(pcs_pipe_lnn_clk_out_en_sync),
.pclk64_rate_change             (pclk64_rate_change),
.g67rate                        (g67rate),
.pipe_rate_mac2phy_sync         (pipe_rate_mac2phy_sync),
.cofslf_tx_write                (cofslf_tx_write),
.cog4fslf_tx_write              (cog4fslf_tx_write),
.cog5fslf_tx_write              (cog5fslf_tx_write),
.fslf_tx_write			(fslf_tx_write),
.g4fslf_tx_write		(g4fslf_tx_write),
.g5fslf_tx_write		(g5fslf_tx_write),
.g67fslf_tx_write		(g67fslf_tx_write),
.tx_local_fs_lf_valid		(tx_local_fs_lf_valid),
.local_fs_g67                    (local_fs_g67),
.local_lf_g67                    (local_lf_g67),
.local_fs_legacy                (local_fs_legacy),
.local_lf_legacy                (local_lf_legacy),
.local_fs_reg                   (local_fs_reg),
.local_lf_reg                   (local_lf_reg)
//.physt_trig                     (/*UNCONNECTED*/)
);

// Capture fb_dir_change and fb_fom on phy_status
   always @(posedge mb_phy2mac_clk or negedge mb_phy2mac_rstn)
     begin
	if (~mb_phy2mac_rstn)
	  begin
	     rx_link_eval_fb_dir_change_g67_reg <= 12'h000;
	     rx_link_eval_fb_dir_change_legacy_reg <= 6'h00;
	     rx_link_eval_fb_fom_reg <= 8'h00;
	  end
	else
	  begin
	     if (phy_status == 1'b1)
	       begin
		  rx_link_eval_fb_dir_change_g67_reg <= rx_link_eval_fb_dir_change_g67;
		  rx_link_eval_fb_dir_change_legacy_reg <= rx_link_eval_fb_dir_change_legacy;
		  rx_link_eval_fb_fom_reg <= rx_link_eval_fb_fom;
	       end
	     else
	       begin
		  rx_link_eval_fb_dir_change_g67_reg <= rx_link_eval_fb_dir_change_g67_reg;
		  rx_link_eval_fb_dir_change_legacy_reg <= rx_link_eval_fb_dir_change_legacy_reg;
		  rx_link_eval_fb_fom_reg <= rx_link_eval_fb_fom_reg;
	       end
	  end
     end

cdnsdru_usb4_message_bus_link_eval_stat_regs_v4 u_cdnsdru_usb4_message_bus_link_eval_stat_regs_v4 (

.pipe_mac2phy_clk               (mb_mac2phy_clk),
.pipe_mac2phy_rstn              (mb_mac2phy_rstn),
.cdb_reset                      (mb_cdb_reset_mac2phy_sync),
.cdb_ctrl_reset                 (mb_cdb_ctrl_reset_mac2phy_sync),
.rx_link_eval_fb_dir_change_g67_reg  (rx_link_eval_fb_dir_change_g67_reg),
.rx_link_eval_fb_dir_change_legacy_reg  (rx_link_eval_fb_dir_change_legacy_reg),
.rx_link_eval_fb_fom_reg            (rx_link_eval_fb_fom_reg),
.prio_tx_writes_done_le		(prio_tx_writes_done[10:8]), //tx_writes_done for link_eval sigs
.rx_eq_eval_sel                 (rx_eq_eval_sel),
.rx_eq_eval			(rx_eq_eval),
.phy_status			(phy_status_mac2phy_sync),
.pipe_rate_mac2phy_sync         (pipe_rate_mac2phy_sync),
.eval_g67_tx_write               (eval_g67_tx_write),
.eval_legacy_tx_write           (eval_legacy_tx_write),
.fom_tx_write                   (fom_tx_write),
.rx_link_eval_status0           (rx_link_eval_status0),
.rx_link_eval_status1           (rx_link_eval_status1),
.rx_link_eval_status2           (rx_link_eval_status2),
.rx_link_eval_status3           (rx_link_eval_status3)
);

//--------------------------------------------------------------------
// Post-reset FS/LF TX request block (P2M clock domain)
//--------------------------------------------------------------------

cdnsdru_usb4_message_bus_allfslf_wr_v4 u_cdnsdru_usb4_message_bus_allfslf_wr_v4 (

.pipe_phy2mac_clk              (mb_phy2mac_clk),
.pipe_phy2mac_rstn             (mb_phy2mac_rstn),
.pipe_rate                     (pipe_rate),
.tx_local_fs_lf_valid	       (tx_local_fs_lf_valid),
.local_fs_g67                   (local_fs_g67),
.local_lf_g67                   (local_lf_g67),
.local_fs_legacy               (local_fs_legacy),
.local_lf_legacy               (local_lf_legacy),
.mb_tx_cmd_req_phy2mac_sync    (mb_tx_cmd_req_phy2mac_sync),
.mb_tx_ack_req_phy2mac_sync    (mb_tx_ack_req_phy2mac_sync),
.mb_pipe_tx_disable            (mb_pipe_tx_disable),
.mb_tx_bus_values_r0           (mb_tx_bus_values_r0),
.p2m_mb_tx_cmd_req             (p2m_mb_tx_cmd_req),
.p2m_mb_tx_ack_req             (p2m_mb_tx_ack_req),
.p2m_mb_tx_bus_values_r0       (p2m_mb_tx_bus_values_r0),
.wait_for_valid                (wait_for_valid),
.allfslf_sent                  (allfslf_sent)
);

//--------------------------------------------------------------------
// IORecal request block
//--------------------------------------------------------------------

cdnsdru_usb4_message_bus_io_recal_v4 u_cdnsdru_usb4_message_bus_io_recal_v4 (

.pipe_mac2phy_clk               (mb_mac2phy_clk),
.pipe_mac2phy_rstn              (mb_mac2phy_rstn),
.mb_enable                      (1'b1),
.cdb_reset                      (mb_cdb_reset_mac2phy_sync),
.cdb_ctrl_reset                 (mb_cdb_ctrl_reset_mac2phy_sync),
.p2m_recal_req                  (p2m_recal_req_phy2mac_sync),  //from PHY
.phy_recal_done                 (phy_recal_done_phy2mac_sync),  //From PHY
.prio_tx_writes_done_ior        (prio_tx_writes_done[15:14]),
.rx_m2p_recal_req               (rx_m2p_recal_req),  //from MAC/MB
.m2p_recal_req                  (m2p_recal_req),   //to PHY 
.phyiorecalreq_tx_write         (phyiorecalreq_tx_write),
.iorecaldone_tx_write           (iorecaldone_tx_write),
.phyiorecalreq_sent             (phyiorecalreq_sent),
.iorecaldone_sent               (iorecaldone_sent)
);

//--------------------------------------------------------------------
// RX EQ Training done block
//--------------------------------------------------------------------

cdnsdru_usb4_message_bus_eq_train_v4 u_cdnsdru_usb4_message_bus_eq_train_v4 (

.pipe_mac2phy_clk               (mb_mac2phy_clk),
.pipe_mac2phy_rstn              (mb_mac2phy_rstn),
.cdb_reset                      (mb_cdb_reset_mac2phy_sync),
.cdb_ctrl_reset                 (mb_cdb_ctrl_reset_mac2phy_sync),
.rx_eq_training_cmpl_stb        (rx_eq_training_cmpl_stb),
.prio_tx_writes_done_eqt        (prio_tx_writes_done[7]),
.rx_eq_training_cmpl_tx_write   (rx_eq_training_cmpl_tx_write)
);


//--------------------------------------------------------------------
// PCS-derived values interface/sync
//--------------------------------------------------------------------

cdnsdru_usb4_message_bus_pcs_rx_ctrl_v4 u_cdnsdru_usb4_message_bus_pcs_rx_ctrl_v4 (
//.pipe_mac2phy_clk              (mb_mac2phy_clk),
//.pipe_mac2phy_rstn             (mb_mac2phy_rstn),
.pipe_phy2mac_clk              (mb_phy2mac_clk),
.pipe_phy2mac_rstn             (mb_phy2mac_rstn),
.tx_coef_valid                 (tx_coef_valid),
.tx_preset_coef_legacy         (tx_preset_coef_legacy),
.tx_preset_coef_g67             (tx_preset_coef_g67),
//.pipe_rate_mac2phy_sync        (pipe_rate_mac2phy_sync),
.g67rate                       (g67rate),
//.tx_coef_valid_mac2phy_sync    (/*floating*/),
.tx_preset_coef_legacy_reg     (tx_preset_coef_legacy_reg),
.tx_preset_coef_g67_reg         (tx_preset_coef_g67_reg)
);

//--------------------------------------------------------------------
// 4-stage data synchronizer for rx_mrgn_valid. It is possible to have
// 1GHz clock for mac2phy_clk (Gen4 16-bit PIPE interface). In general, 
// 2-stage data synchronizer can handle <= 850MHz. Hence adding
// additional 2-stages so that 1GHz could be handled.
//
// 1 extra stage is added to register the signal similar to the other signals.
//--------------------------------------------------------------------

phy_data_sync #(.NUM_FLOPS(SYNC_DEPTH)) u_rx_mrgn_valid (
   .clock    (mb_mac2phy_clk),
   .reset_n  (mb_mac2phy_rstn),
   .d_in     (rx_mrgn_valid),
   .d_out    (rx_mrgn_valid_sync)
   );

//--------------------------------------------------------------------
// TP synchronizer for tx_coef_valid
//--------------------------------------------------------------------

phy_tpsync #(.STB_ONLY(0)) u_tx_coef_valid_mac2phy_sync (
  .a_clk      (mb_phy2mac_clk),
  .a_rst_n    (mb_phy2mac_rstn),
  .b_clk      (mb_mac2phy_clk),
  .b_rst_n    (mb_mac2phy_rstn),
  .data_i     (tx_coef_valid),
  .data_o     (tx_coef_valid_mac2phy_sync)
  );
`ifdef COEF_VALID_NOSYNC
   assign tx_coef_valid_selected = tx_coef_valid;
`else
   assign tx_coef_valid_selected = tx_coef_valid_mac2phy_sync;
`endif

//--------------------------------------------------------------------
// 5-stage data synchronizer for Receiver Signal Detect signal.
//--------------------------------------------------------------------

phy_data_sync #(.NUM_FLOPS(SYNC_DEPTH)) u_rx_signal_detect_sync (
   .clock    (mb_mac2phy_clk),
   .reset_n  (mb_mac2phy_rstn),
   .d_in     (rx_signal_detect),
   .d_out    (rx_signal_detect_sync)
   );

//--------------------------------------------------------------------
// 5-stage data synchronizer for mb_cdb_reset.
//--------------------------------------------------------------------

phy_data_sync #(.NUM_FLOPS(SYNC_DEPTH)) u_mb_cdb_reset_mac2phy_sync (
   .clock    (mb_mac2phy_clk),
   .reset_n  (mb_mac2phy_rstn),
   .d_in     (mb_cdb_reset),
   .d_out    (mb_cdb_reset_mac2phy_sync)
   );

//--------------------------------------------------------------------
// 5-stage data synchronizer for mb_cdb_rx_reset.
//--------------------------------------------------------------------

phy_data_sync #(.NUM_FLOPS(SYNC_DEPTH)) u_mb_cdb_rx_reset_sync (
   .clock    (mb_mac2phy_clk),
   .reset_n  (mb_mac2phy_rstn),
   .d_in     (mb_cdb_rx_reset),
   .d_out    (mb_cdb_rx_reset_mac2phy_sync)
   );

//--------------------------------------------------------------------
// 5-stage data synchronizer for mb_cdb_pma_reset.
//--------------------------------------------------------------------

phy_data_sync #(.NUM_FLOPS(SYNC_DEPTH)) u_mb_cdb_pma_reset_sync (
   .clock    (mb_mac2phy_clk),
   .reset_n  (mb_mac2phy_rstn),
   .d_in     (mb_cdb_pma_reset),
   .d_out    (mb_cdb_pma_reset_mac2phy_sync)
   );

//--------------------------------------------------------------------
// 5-stage data synchronizer for mb_cdb_ctrl_reset.
//--------------------------------------------------------------------

phy_data_sync #(.NUM_FLOPS(SYNC_DEPTH)) u_mb_cdb_ctrl_reset_sync (
   .clock    (mb_mac2phy_clk),
   .reset_n  (mb_mac2phy_rstn),
   .d_in     (mb_cdb_ctrl_reset),
   .d_out    (mb_cdb_ctrl_reset_mac2phy_sync)
   );


//--------------------------------------------------------------------
// 5-stage data synchronizer for mb_tx_cmd_done.
//--------------------------------------------------------------------

phy_data_sync #(.NUM_FLOPS(SYNC_DEPTH)) u_mb_tx_cmd_done_mac2phy_sync0 (
   .clock    (mb_mac2phy_clk),
   .reset_n  (mb_mac2phy_rstn),
   .d_in     (mb_tx_cmd_done[0]),
   .d_out    (mb_tx_cmd_done_mac2phy_sync[0])
   );
phy_data_sync #(.NUM_FLOPS(SYNC_DEPTH)) u_mb_tx_cmd_done_mac2phy_sync1 (
   .clock    (mb_mac2phy_clk),
   .reset_n  (mb_mac2phy_rstn),
   .d_in     (mb_tx_cmd_done[1]),
   .d_out    (mb_tx_cmd_done_mac2phy_sync[1])
   );
phy_data_sync #(.NUM_FLOPS(SYNC_DEPTH)) u_mb_tx_cmd_done_mac2phy_sync2 (
   .clock    (mb_mac2phy_clk),
   .reset_n  (mb_mac2phy_rstn),
   .d_in     (mb_tx_cmd_done[2]),
   .d_out    (mb_tx_cmd_done_mac2phy_sync[2])
   );
phy_data_sync #(.NUM_FLOPS(SYNC_DEPTH)) u_mb_tx_cmd_done_mac2phy_sync3 (
   .clock    (mb_mac2phy_clk),
   .reset_n  (mb_mac2phy_rstn),
   .d_in     (mb_tx_cmd_done[3]),
   .d_out    (mb_tx_cmd_done_mac2phy_sync[3])
   );
phy_data_sync #(.NUM_FLOPS(SYNC_DEPTH)) u_mb_tx_cmd_done_mac2phy_sync4 (
   .clock    (mb_mac2phy_clk),
   .reset_n  (mb_mac2phy_rstn),
   .d_in     (mb_tx_cmd_done[4]),
   .d_out    (mb_tx_cmd_done_mac2phy_sync[4])
   );
phy_data_sync #(.NUM_FLOPS(SYNC_DEPTH)) u_mb_tx_cmd_done_mac2phy_sync5 (
   .clock    (mb_mac2phy_clk),
   .reset_n  (mb_mac2phy_rstn),
   .d_in     (mb_tx_cmd_done[5]),
   .d_out    (mb_tx_cmd_done_mac2phy_sync[5])
   );

//--------------------------------------------------------------------
// 5-stage data synchronizer for allfslf_sent.
//--------------------------------------------------------------------

phy_data_sync #(.NUM_FLOPS(SYNC_DEPTH)) u_allfslf_sent_mac2phy_sync (
   .clock    (mb_mac2phy_clk),
   .reset_n  (mb_mac2phy_rstn),
   .d_in     (allfslf_sent),
   .d_out    (allfslf_sent_mac2phy_sync)
   );

phy_data_sync #(.NUM_FLOPS(SYNC_DEPTH)) u_wait_for_valid_mac2phy_sync (
   .clock    (mb_mac2phy_clk),
   .reset_n  (mb_mac2phy_rstn),
   .d_in     (wait_for_valid),
   .d_out    (wait_for_valid_mac2phy_sync)
   );

//--------------------------------------------------------------------
// 4-stage data synchronizer for pipe_rate
//--------------------------------------------------------------------

phy_mb_data_sync #(.p_width(4),.d_rst_val(4'b0000)) u_pipe_rate (
   .dest_clk     (mb_mac2phy_clk),
   .dest_rst_n   (mb_mac2phy_rstn),
   .source_dat   (pipe_rate),
   .dest_dat     (pipe_rate_mac2phy_sync)
   );

//--------------------------------------------------------------------
// All ASYNC and non-mb_phy2mac_clk domain signals are synchronized here and given to the 
// respective blocks.
//--------------------------------------------------------------------

//--------------------------------------------------------------------
// 5-stage data synchronizer for mb_cdb_reset.
//--------------------------------------------------------------------

phy_data_sync #(.NUM_FLOPS(SYNC_DEPTH)) u_mb_cdb_reset_phy2mac_sync (
   .clock    (mb_phy2mac_clk),
   .reset_n  (mb_phy2mac_rstn),
   .d_in     (mb_cdb_reset),
   .d_out    (mb_cdb_reset_phy2mac_sync)
   );

//--------------------------------------------------------------------
// 5-stage data synchronizer for mb_cdb_tx_reset.
//--------------------------------------------------------------------

assign mb_cdb_tx_reset_disable = mb_cdb_tx_reset | mb_pipe_tx_disable;

phy_data_sync #(.NUM_FLOPS(SYNC_DEPTH)) u_mb_cdb_tx_reset_phy2mac_sync (
   .clock    (mb_phy2mac_clk),
   .reset_n  (mb_phy2mac_rstn),
   .d_in     (mb_cdb_tx_reset_disable),
   .d_out    (mb_cdb_tx_reset_phy2mac_sync)
   );

//--------------------------------------------------------------------
// 5-stage data synchronizer for mb_tx_cmd_req.
//--------------------------------------------------------------------

phy_data_sync #(.NUM_FLOPS(SYNC_DEPTH)) u_lm_tx_cmd_req_phy2mac_sync (
   .clock    (mb_phy2mac_clk),
   .reset_n  (mb_phy2mac_rstn),
   .d_in     (mb_tx_cmd_req),
   .d_out    (mb_tx_cmd_req_phy2mac_sync)
   );

//--------------------------------------------------------------------
// 5-stage data synchronizer for mb_tx_ack_req.
//--------------------------------------------------------------------

phy_data_sync #(.NUM_FLOPS(SYNC_DEPTH)) u_lm_tx_ack_req_phy2mac_sync (
   .clock    (mb_phy2mac_clk),
   .reset_n  (mb_phy2mac_rstn),
   .d_in     (mb_tx_ack_req),
   .d_out    (mb_tx_ack_req_phy2mac_sync)
   );

//--------------------------------------------------------------------
// Recal-related-reset syncronizers
//--------------------------------------------------------------------

phy_tpsync #(.STB_ONLY(1)) u_mb_p2m_recal_req_sync (
.a_clk(mb_phy2mac_clk),
.a_rst_n(mb_phy2mac_rstn),
.b_clk(mb_mac2phy_clk),
.b_rst_n(mb_mac2phy_rstn),
.data_i(p2m_recal_req),
.data_o(p2m_recal_req_phy2mac_sync)
  );
phy_tpsync #(.STB_ONLY(1)) u_mb_p2m_recal_done_sync (
.a_clk(mb_phy2mac_clk),
.a_rst_n(mb_phy2mac_rstn),
.b_clk(mb_mac2phy_clk),
.b_rst_n(mb_mac2phy_rstn),
.data_i(phy_recal_done),
.data_o(phy_recal_done_phy2mac_sync)
  );

// Reset sync to synchronize pcs_pipe_l<>_clk_out_en
phy_reset_sync u_phy_reset_sync_phy_reset_n (
   .sync_clock_in              (mb_mac2phy_clk),
   .reset_in_n                 (pcs_pipe_lnn_clk_out_en & mb_mac2phy_rstn),
   .reset_out_n                (pcs_pipe_lnn_clk_out_en_sync),
   .upstream_reset_in_n        (1'b1),
   .scan_mode_en_in            (scanmode),
   .scan_reset_in_n            (mb_mac2phy_rstn)
   );

//--------------------------------------------------------------------
// phy_status retimer (since it may originate on a different clock than
// the MB runs on).
//--------------------------------------------------------------------

phy_tpsync #(.STB_ONLY(0)) u_phy_tpsync (
  .a_clk      (mb_phy2mac_clk),
  .a_rst_n    (mb_phy2mac_rstn),
  .b_clk      (mb_mac2phy_clk),
  .b_rst_n    (mb_mac2phy_rstn),
  .data_i     (phy_status),
  .data_o     (phy_status_mac2phy_sync)
  );

endmodule
