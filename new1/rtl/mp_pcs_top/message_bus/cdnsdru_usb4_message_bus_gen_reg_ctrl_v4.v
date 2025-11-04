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
//   Module Name    : cdnsdru_usb4_message_bus_gen_reg_ctrl_v4
//
//   Author         : Dongdong Wang
//
//   Date           : July 23, 2025
//
//   Limitations    :
//
//   Notes          : Based on cdnsdru_pcie_message_bus_gen_reg_ctrl_v4 authored by Thomas Faison
//---------------------------------------------------------------------------------
//   Description    :	Register Controller Module
//			The purpose of this module is to co-ordinate between the
//			PIPE Tx, PIPE Rx and PMA Tx/Rx modules. This block contains
//			the following logics
//			1. Master FSM to co-ordinate both PIPE and PMA interfaces
//			2. Manages the decision during conflicting/error situations
//			3. Manages the PHY address map
//
//---------------------------------------------------------------------------------

module cdnsdru_usb4_message_bus_gen_reg_ctrl_v4 (

input			pipe_mac2phy_clk,	      	// PHY: MB Clock based on PIPE interface data width --> 500MHz (32-bit) or 1GHz (16-bit)
input			pipe_mac2phy_rstn,     		// PHY: MB Reset. Active Low
input			mb_enable,			// PHY: MB Enable when PCIe Gen4 and P0 state

input			mb_cdb_reset,			// PHY CDB: Soft Reset for entire MB block including all sub-blocks
input			mb_cdb_ctrl_reset,		// PHY CDB: Soft Reset for entire MB Controller

output reg		mb_cdb_invalid_addr_uncom,	// PHY CDB: Invalid address detected during MAC uncommitted write
output reg		mb_cdb_invalid_addr_com,	// PHY CDB: Invalid address detected during MAC committed write
input			mb_rx_cmd_complete,		// MB Rx Controller: MB command received successfully (independent of validity)
input		[3:0]	mb_rx_command,			// MB Rx Controller: MB received command
input		[7:0]	mb_rx_data,			// MB Rx Controller: MB received data
input		[11:0]	mb_rx_address,			// MB Rx Controller: MB received command address

input		[5:0]	mb_tx_cmd_done,			// MB Tx Controller: Command Transmitted Acknowledgement
output reg		mb_tx_cmd_req,			// MB Tx Controller: Command Transmission Request
output reg		mb_tx_ack_req,			// MB Tx Controller: ACK Transmission Request
output reg	[2:0]	mb_tx_wrb_cnt,			// MB Tx Controller: Transmit Uncommitted writes count
output reg	[23:0]	mb_tx_bus_values_r0,		// MB Tx Controller: Transmit Command values
output reg	[23:0]	mb_tx_bus_values_r1,		// MB Tx Controller: Transmit Command values
output reg	[23:0]	mb_tx_bus_values_r2,		// MB Tx Controller: Transmit Command values
output reg	[23:0]	mb_tx_bus_values_r3,		// MB Tx Controller: Transmit Command values
output reg	[23:0]	mb_tx_bus_values_r4,		// MB Tx Controller: Transmit Command values

// Outputs going to rest of PHY
output	reg		eb_ctrl_upd,			// PHY PCS: Elastcity Buffer Control Update
output	wire	[7:0]	eb_ctrl,			// PHY PCS: Elasticity Buffer Control 

//Common MB register outputs
//output reg              rx_write_ack,			// PHY has received a write-ACK
output                  lm_rx_write_ack,		// PHY has received a write-ACK related to key LM writes
//output                  rx_write_com,
output          [16:0]  prio_tx_writes_done,

//I/O with LM block
output reg      [3:0]   phy_reg000,
output reg      [7:0]   phy_reg001,
input           [7:0]   mac_reg000,
input           [7:0]   mac_reg001,
input           [7:0]   mac_reg002,
input           [7:0]   mac_reg003,
input           [3:0]   lm_tx_writes,
input   		ebsts_tx_write,
input 			lm_dep,



//I/O with Coefficient block
input                   allfslf_sent_mac2phy_sync,
input           [17:0]  tx_preset_coef_legacy_reg,
input           [23:0]  tx_preset_coef_g67_reg,
input                   coef_legacy_tx_write,
input                   coef_g67_tx_write,
input                   cofslf_tx_write,
input                   cog4fslf_tx_write,
input                   cog5fslf_tx_write,
input                   fslf_tx_write,
input                   g4fslf_tx_write,
input                   g5fslf_tx_write,
input                   g67fslf_tx_write,
input           [7:0]   local_fs_reg,
input           [7:0]   local_lf_reg,
//output reg              fslf_sent,
//output reg              g4fslf_sent,
//output reg              g5fslf_sent,
//output reg              g67fslf_sent,
input                   pclk64_rate_change,
`ifdef PAM4_RESTRICTED_LEVELS
output                  PAM4RestrictedLevels,
`endif
output                  NELBEnable,
output          [2:0]   NELBPosition,

//I/O with RX eval block
input                   eval_g67_tx_write,
input                   eval_legacy_tx_write,
input                   fom_tx_write,
input  [7:0]     	rx_link_eval_status0,
input  [7:0]     	rx_link_eval_status1,
input  [7:0]     	rx_link_eval_status2,
input  [7:0]     	rx_link_eval_status3,

//IO with recal/training blocks
input                   phyiorecalreq_tx_write,
input                   iorecaldone_tx_write,
input                   rx_eq_training_cmpl_tx_write,
output                  rx_m2p_recal_req,
output reg 		phyiorecalreq_sent,
output reg 		iorecaldone_sent,

//4.4.1 pins decoded from message bus registers
output                  rx_polarity,
output          [17:0]  tx_deemph,
output          [23:0]  tx_deemph_cx,
output reg              tx_deemph_strobe,
output          [5:0]   tx_local_preset_index,
output                  tx_get_local_preset_coef,
output                  rx_eq_training,
output                  rx_invalid_request,
output                  rx_eq_in_progress,
output                  rx_eq_eval,
//output          [1:0]   tx_pattern,
output                  tx_ones_zeros,
//output          [7:0]   tx_fs,
//output          [7:0]   tx_lf,
output                  tx_swing,
output          [2:0]   tx_margin,
output reg              tx_swgmgn_strobe,
output                  tx_128b_enc_byp,
output                  tx_lfps_select,
output                  eb_mode

);

//--------------------------------------------------------------------
// FSM Parameters
//--------------------------------------------------------------------

   localparam MB_CTRL_IDLE		= 4'b0000;
   localparam MB_CTRL_TX_WR_DATA	= 4'b0001;
   localparam MB_CTRL_WT_TX_WR_DATA     = 4'b0010;
   localparam MB_CTRL_WT_RX_WR_ACK	= 4'b0011;
   localparam MB_CTRL_TX_WR_ACK	        = 4'b0100;
   localparam MB_CTRL_WT_TX_WR_ACK	= 4'b0101;
   localparam MB_CTRL_TX_WR_STS         = 4'b0110;
   localparam MB_CTRL_WT_TX_WR_STS      = 4'b0111;
   localparam MB_CTRL_WT_RX_WR_ACK1     = 4'b1000;
   localparam MB_CTRL_TX_RD_COMP	= 4'b1001;
   localparam MB_CTRL_WT_TX_RD_COMP     = 4'b1010;


//--------------------------------------------------------------------
// Local Variables
//--------------------------------------------------------------------

   reg 	     load_tx_read_data;
   reg 	     load_tx_write_ack;
   reg 	     load_tx_write_data;
   reg [5:0] mb_tx_cmd_done_reg;
   reg 	     mb_tx_cmd_req_en;
   reg 	     mb_tx_cmd_req_en_reg;
   reg 	     mb_tx_cmd_req_rst;
   reg 	     tx_read_completion;
   reg 	     tx_read_completion_rst;
   reg 	     tx_read_pending;
   reg 	     tx_write_ack_trans;
   reg 	     tx_write_ack_trans_en;
   reg 	     tx_write_ack_trans_rst;
   reg 	     tx_read_completion_trans;
   reg 	     tx_read_completion_trans_en;
   reg 	     tx_read_completion_trans_rst;
   reg 	     tx_write_ack;
   reg 	     tx_write_ack_rst;
   reg 	     rx_write_ack_rst;

   reg 	     allfslf_ack_wait;

   reg [7:0] tx_read_data;
   reg [3:0] mb_ctrl_next_state;
   reg [3:0] mb_ctrl_state;
   reg [16:0] prio_tx_writes;

   reg        rx_write_ack;

   reg [7:0] phy_reg002;
   reg [1:0] phy_reg003;
   reg [2:0] phy_reg004;
   reg [2:0] phy_reg006;
   reg [7:0] phy_reg007;
   //reg [1:0] phy_reg400;
   reg 	     phy_reg401;
   reg [5:0] phy_reg402;
   reg [5:0] phy_reg403;
   reg [5:0] phy_reg404;
   reg [6:0] phy_reg405;
   reg [7:0] phy_reg406;
   reg [7:0] phy_reg407;
   reg [3:0] phy_reg408;
   reg [5:0] phy_reg409;
   reg [1:0] phy_reg800;
   reg [3:0] phy_reg801;

   wire       cmd_req_seq_rst;
   wire       coef_legacy_load_tx_write_data;
   wire       coef_g67_load_tx_write_data;
   wire       cofslf_load_tx_write_data;
   wire       ctrl_soft_reset;
   wire       fslf_load_tx_write_data;
   wire       g4fslf_load_tx_write_data;
   wire       g5fslf_load_tx_write_data;
   wire       g67fslf_load_tx_write_data;
   wire       ebsts_load_tx_write_data;
   wire       lmstart_load_tx_write_data;
   wire       lmdat_load_tx_write_data;
   wire       lmofst_load_tx_write_data;
   wire       lmend_load_tx_write_data;
   wire       rx_read;
   wire       rx_read_pending;
   wire       rx_write_uncom;
   wire [5:0] edge_mb_tx_cmd_done;
   wire       tx_writes;
   wire       mb_tx_ack_req_comb;
   wire       rx_write_com;
   
   // Shadow registers
   reg [4:0]  phy_shad000;
   reg [8:0]  phy_shad001;
   reg [8:0]  phy_shad002;
   reg [2:0]  phy_shad003;
   reg [3:0]  phy_shad004;
   reg [3:0]  phy_shad006;
   reg [8:0]  phy_shad007;
   //reg [2:0]  phy_shad400;
   reg [1:0]  phy_shad401;
   reg [6:0]  phy_shad402;
   reg [6:0]  phy_shad403;
   reg [6:0]  phy_shad404;
   reg [7:0]  phy_shad405;
   reg [8:0]  phy_shad406;
   reg [8:0]  phy_shad407;
   reg [4:0]  phy_shad408;
   reg [6:0]  phy_shad409;
   reg [2:0]  phy_shad800;
   reg [4:0]  phy_shad801;


//--------------------------------------------------------------------
// This block will be reset when any one of the followign conditions
// are true
// 1. MB Disabled (PHY is not in Gen4 P0 state)
// 2. MB soft reset (Software)
// 3. MB Block level soft reset (Software)
//--------------------------------------------------------------------

   assign ctrl_soft_reset = (~mb_enable | mb_cdb_reset | mb_cdb_ctrl_reset);


//--------------------------------------------------------------------
// Register access commands
//--------------------------------------------------------------------

   assign rx_write_uncom	= (mb_rx_cmd_complete == 1'b1 & (mb_rx_command == `MB_WRITE_UNCOMMITTED));
   assign rx_write_com		= (mb_rx_cmd_complete == 1'b1 & (mb_rx_command == `MB_WRITE_COMMITTED));
   assign rx_read		= (mb_rx_cmd_complete == 1'b1 & (mb_rx_command == `MB_READ));
   assign phy_write_ack		= (mb_rx_cmd_complete == 1'b1 & (mb_rx_command == `MB_WRITE_ACK));

//--------------------------------------------------------------------
// PHY Registers
//--------------------------------------------------------------------
// 1. PHY registers are written when rx_write_com is asserted
// 2. PHY registers are loaded with shadow registers if the
//    shadow_reg*[0] flag bit is asserted. Bit [0] is used because
//    not all registers are the same width and we want to have
//    a common flag location.
// 3. Whenever Sample/Error count reset is set by the MAC, it
//    shall be auto cleared by the PHY register so that 1-cycle
//    pulse shall be generated for reseting the sample and error
//    counter logics.
// 4. Whenever invalid address is detected, then it is informed
//    to the software via CDB register write. Please note that
//    the error signal is signalled for 1-cycle and it is 
//    expected to be stretched in the APB clock domain before 
//    being stored in the CDB register. The CDB register is 
//    expected to be read on clear.
// 5. In case if there is an error scenario where both uncommitted
//    and committed write happens to the same address, then the
//    committed write takes precedence and uncommitted write value
//    is ignored. This is implied by use of a case statement.
//
//--------------------------------------------------------------------
// Shadow Registers
//--------------------------------------------------------------------
// 1. Shadow registers are written when rx_write_uncom is asserted
// 2. Shadow registers are reset when rx_write_com is asserted;
//    at the same time shadow register contents will be
//    transferred to the master registers.
// 3. Shadow register contents:
//	a. [8:1] --> Regsiter value from PIPE
//	b. [1] --> Flag bit set on uncommtted write 
// 4. Whenever invalid address is detected, then it is informed
//    to the software via CDB register write. Please note that
//    the error signal is signalled for 1-cycle and it is 
//    expected to be stretched in the APB clock domain before 
//    being stored in the CDB register. The CDB register is 
//    expected to be read on clear.
//--------------------------------------------------------------------

   always @(posedge pipe_mac2phy_clk or negedge pipe_mac2phy_rstn)
     begin
	if (~pipe_mac2phy_rstn)
	  begin
	     phy_reg000 <= 4'h0;
	     phy_reg001 <= 8'h0;
	     phy_reg002 <= 8'h0;
	     phy_reg003 <= 2'h0;
	     phy_reg004 <= 3'h0;
	     phy_reg006 <= 3'h0;
	     phy_reg007 <= 8'h5;
	     //phy_reg400 <= 2'h0;
	     phy_reg401 <= 1'h0;
	     phy_reg402 <= 6'h1;
	     phy_reg403 <= 6'h0;
	     phy_reg404 <= 6'h0;
	     phy_reg405 <= 7'h0;
	     phy_reg406 <= 8'h0;
	     phy_reg407 <= 8'h0;
	     phy_reg408 <= 4'h0;
	     phy_reg409 <= 6'h0;
	     phy_reg800 <= 2'h0;
	     phy_reg801 <= 4'h0;
	     eb_ctrl_upd <= 1'h0;
	     phy_shad000 <= 5'h0;
	     phy_shad001 <= 9'h0;
	     phy_shad002 <= 9'h0;
	     phy_shad003 <= 3'h0;
	     phy_shad004 <= 4'h0;
	     phy_shad006 <= 4'h0;
	     phy_shad007 <= 9'hA;
	     //phy_shad400 <= 3'h0;
	     phy_shad401 <= 2'h0;
	     phy_shad402 <= 7'h2;
	     phy_shad403 <= 7'h0;
	     phy_shad404 <= 7'h0;
	     phy_shad405 <= 8'h0;
	     phy_shad406 <= 9'h0;
	     phy_shad407 <= 9'h0;
	     phy_shad408 <= 5'h0;
	     phy_shad409 <= 7'h0;
	     phy_shad800 <= 3'h0;
	     phy_shad801 <= 5'h0;
	     mb_cdb_invalid_addr_uncom <= 1'h0;
	     tx_deemph_strobe <= 1'b0;
	     tx_swgmgn_strobe <= 1'b0;
	  end
	else if (ctrl_soft_reset)
	  begin
	     phy_reg000 <= 4'h0;
	     phy_reg001 <= 8'h0;
	     phy_reg002 <= 8'h0;
	     phy_reg003 <= 2'h0;
	     phy_reg004 <= 3'h0;
	     phy_reg006 <= 3'h0;
	     phy_reg007 <= 8'h5;
	     //phy_reg400 <= 2'h0;
	     phy_reg401 <= 1'h0;
	     phy_reg402 <= 6'h1;
	     phy_reg403 <= 6'h0;
	     phy_reg404 <= 6'h0;
	     phy_reg405 <= 7'h0;
	     phy_reg406 <= 8'h0;
	     phy_reg407 <= 8'h0;
	     phy_reg408 <= 4'h0;
	     phy_reg409 <= 6'h0;
	     phy_reg800 <= 2'h0;
	     phy_reg801 <= 4'h0;
	     eb_ctrl_upd <= 1'b0;
	     phy_shad000 <= 5'h0;
	     phy_shad001 <= 9'h0;
	     phy_shad002 <= 9'h0;
	     phy_shad003 <= 3'h0;
	     phy_shad004 <= 4'h0;
	     phy_shad006 <= 4'h0;
	     phy_shad007 <= 9'hA;
	     //phy_shad400 <= 3'h0;
	     phy_shad401 <= 2'h0;
	     phy_shad402 <= 7'h2;
	     phy_shad403 <= 7'h0;
	     phy_shad404 <= 7'h0;
	     phy_shad405 <= 8'h0;
	     phy_shad406 <= 9'h0;
	     phy_shad407 <= 9'h0;
	     phy_shad408 <= 5'h0;
	     phy_shad409 <= 7'h0;
	     phy_shad800 <= 3'h0;
	     phy_shad801 <= 5'h0;
	     mb_cdb_invalid_addr_uncom <= 1'b0;
	     tx_deemph_strobe <= 1'b0;
	     tx_swgmgn_strobe <= 1'b0;
	  end
	else if (rx_write_com)
	  begin
	     
	     eb_ctrl_upd <= (mb_rx_address == `PHY_EL_BUF_CTRL) | phy_shad002[0];

	     if (mb_rx_address == `PHY_RX_MRGN_CTRL_0)
	       begin
		  phy_reg000 <= mb_rx_data[3:0];
		  phy_shad000[0] <= 1'b0;
	       end
	     else if (phy_shad000[0] == 1'b1)
	       begin
		  phy_reg000 <= phy_shad000[4:1];
		  phy_shad000[0] <= 1'b0;
	       end

	     if (mb_rx_address == `PHY_RX_MRGN_CTRL_1)
	       begin
		  phy_reg001 <= mb_rx_data;
		  phy_shad001[0] <= 1'b0;
	       end
	     else if (phy_shad001[0] == 1'b1)
	       begin
		  phy_reg001 <= phy_shad001[8:1];
		  phy_shad001[0] <= 1'b0;
	       end

	     if (mb_rx_address == `PHY_EL_BUF_CTRL)
	       begin
		  phy_reg002 <= mb_rx_data;
		  phy_shad002[0] <= 1'b0;
	       end
	     else if (phy_shad002[0] == 1'b1)
	       begin
		  phy_reg002 <= phy_shad002[8:1];
		  phy_shad002[0] <= 1'b0;
	       end

	     if (mb_rx_address == `PHY_RX_CTRL_0)
	       begin
		  phy_reg003 <= mb_rx_data[1:0];
		  phy_shad003[0] <= 1'b0;
	       end
	     else if (phy_shad003[0] == 1'b1)
	       begin
		  phy_reg003 <= phy_shad003[2:1];
		  phy_shad003[0] <= 1'b0;
	       end

	     if (mb_rx_address == `PHY_RX_CTRL_1)
	       begin
		  phy_reg004 <= mb_rx_data[2:0];
		  phy_shad004[0] <= 1'b0;
	       end
	     else if (phy_shad004[0] == 1'b1)
	       begin
		  phy_reg004 <= phy_shad004[3:1];
		  phy_shad004[0] <= 1'b0;
	       end
	     else
	       begin
		  phy_reg004 <= {(phy_reg004[2] & ~pclk64_rate_change),phy_reg004[1:0]};
		  phy_shad004[0] <= phy_shad004[0];
	       end


	     if (mb_rx_address == `PHY_RX_CTRL_3)
	       begin
		  phy_reg006 <= mb_rx_data[2:0];
		  phy_shad006[0] <= 1'b0;
	       end
	     else if (phy_shad006[0] == 1'b1)
	       begin
		  phy_reg006 <= phy_shad006[3:1];
		  phy_shad006[0] <= 1'b0;
	       end

	     if (mb_rx_address == `PHY_EL_BUF_LOC_UP_FRQ)
	       begin
		  phy_reg007 <= mb_rx_data;
		  phy_shad007[0] <= 1'b0;
	       end
	     else if (phy_shad007[0] == 1'b1)
	       begin
		  phy_reg007 <= phy_shad007[8:1];
		  phy_shad007[0] <= 1'b0;
	       end

	     //if (mb_rx_address == `PHY_TX_CTRL_0)
	     //  begin
		 // phy_reg400 <= mb_rx_data[1:0];
		 // phy_shad400[0] <= 1'b0;
	     //  end
	     //else if (phy_shad400[0] == 1'b1)
	     //  begin
		 // phy_reg400 <= phy_shad400[2:1];
		 // phy_shad400[0] <= 1'b0;
	     //  end

	     if (mb_rx_address == `PHY_TX_CTRL_1)
	       begin
		  phy_reg401 <= mb_rx_data[0];
		  phy_shad401[0] <= 1'b0;
	       end
	     else if (phy_shad401[0] == 1'b1)
	       begin
		  phy_reg401 <= phy_shad401[1];
		  phy_shad401[0] <= 1'b0;
	       end

	     if (mb_rx_address == `PHY_TX_CTRL_2)
	       begin
		  phy_reg402 <= mb_rx_data[5:0];
		  phy_shad402[0] <= 1'b0;
	       end
	     else if (phy_shad402[0] == 1'b1)
	       begin
		  phy_reg402 <= phy_shad402[6:1];
		  phy_shad402[0] <= 1'b0;
	       end

	     if (mb_rx_address == `PHY_TX_CTRL_3)
	       begin
		  phy_reg403 <= mb_rx_data[5:0];
		  phy_shad403[0] <= 1'b0;
	       end
	     else if (phy_shad403[0] == 1'b1)
	       begin
		  phy_reg403 <= phy_shad403[6:1];
		  phy_shad403[0] <= 1'b0;
	       end

	     if (mb_rx_address == `PHY_TX_CTRL_4)
	       begin
		  phy_reg404 <= mb_rx_data[5:0];
		  phy_shad404[0] <= 1'b0;
	       end
	     else if (phy_shad404[0] == 1'b1)
	       begin
		  phy_reg404 <= phy_shad404[6:1];
		  phy_shad404[0] <= 1'b0;
	       end

	     if (mb_rx_address == `PHY_TX_CTRL_5)
	       begin
		  phy_reg405[6] <= mb_rx_data[7];
		  phy_reg405[5:0] <= mb_rx_data[5:0];
		  phy_shad405[0] <= 1'b0;
	       end
	     else if (phy_shad405[0] == 1'b1)
	       begin
		  phy_reg405[6] <= phy_shad405[7];
		  phy_reg405[5:0] <= phy_shad405[6:1];
		  phy_shad405[0] <= 1'b0;
	       end

	     if (mb_rx_address == `PHY_TX_CTRL_6)
	       begin
		  phy_reg406 <= mb_rx_data[7:0];
		  phy_shad406[0] <= 1'b0;
	       end
	     else if (phy_shad406[0] == 1'b1)
	       begin
		  phy_reg406 <= phy_shad406[8:1];
		  phy_shad406[0] <= 1'b0;
	       end

	     if (mb_rx_address == `PHY_TX_CTRL_7)
	       begin
		  phy_reg407 <= mb_rx_data[7:0];
		  phy_shad407[0] <= 1'b0;
	       end
	     else if (phy_shad407[0] == 1'b1)
	       begin
		  phy_reg407 <= phy_shad407[8:1];
		  phy_shad407[0] <= 1'b0;
	       end

	     if (mb_rx_address == `PHY_TX_CTRL_8)
	       begin
		  phy_reg408 <= mb_rx_data[3:0];
		  phy_shad408[0] <= 1'b0;
	       end
	     else if (phy_shad408[0] == 1'b1)
	       begin
		  phy_reg408 <= phy_shad408[4:1];
		  phy_shad408[0] <= 1'b0;
	       end

	     if (mb_rx_address == `PHY_TX_CTRL_9)
	       begin
		  phy_reg409 <= mb_rx_data[5:0];
		  phy_shad409[0] <= 1'b0;
	       end
	     else if (phy_shad409[0] == 1'b1)
	       begin
		  phy_reg409 <= phy_shad409[6:1];
		  phy_shad409[0] <= 1'b0;
	       end

	     if (mb_rx_address == `PHY_CMN_CTRL_0)
	       begin
		  phy_reg800 <= mb_rx_data[1:0];
		  phy_shad800[0] <= 1'b0;
	       end	    
	     else if (phy_shad800[0] == 1'b1)
	       begin
		  phy_reg800 <= phy_shad800[2:1];
		  phy_shad800[0] <= 1'b0;
	       end

	     if (mb_rx_address == `PHY_NEL_CTRL_0)
	       begin
		  phy_reg801 <= {mb_rx_data[7],mb_rx_data[2:0]};
		  phy_shad801[0] <= 1'b0;
	       end	    
	     else if (phy_shad801[0] == 1'b1)
	       begin
		  phy_reg801 <= phy_shad801[4:1];
		  phy_shad801[0] <= 1'b0;
	       end

	     // Emph registers (402,403,404,409) come with a strobe indicating one (or more) was written. No extra charge!
	     if ((mb_rx_address == `PHY_TX_CTRL_2) || (mb_rx_address == `PHY_TX_CTRL_3) ||
				 (mb_rx_address == `PHY_TX_CTRL_4) || (mb_rx_address == `PHY_TX_CTRL_9) ||
				 (phy_shad402[0] == 1'b1) || (phy_shad403[0] == 1'b1) || (phy_shad404[0] == 1'b1) ||
				 (phy_shad409[0] == 1'b1))
	       tx_deemph_strobe <= 1'b1;

	     // Swing/margin register generates a strobe when written
	     if ((mb_rx_address == `PHY_TX_CTRL_8) || (phy_shad408[0] == 1'b1))
	       tx_swgmgn_strobe <= 1'b1;

	  end
	else if (rx_write_uncom)
	  begin
	     case (mb_rx_address)
	       `PHY_RX_MRGN_CTRL_0 : 
		 begin
		    phy_shad000 <= {mb_rx_data[3:0],1'b1};
		    mb_cdb_invalid_addr_uncom <= 1'b0;
		 end
	       `PHY_RX_MRGN_CTRL_1 :
		 begin
		    phy_shad001 <= {mb_rx_data,1'b1};
		    mb_cdb_invalid_addr_uncom <= 1'b0;
		 end
	       `PHY_EL_BUF_CTRL :
		 begin
		    phy_shad002 <= {mb_rx_data,1'b1};
		    mb_cdb_invalid_addr_uncom <= 1'b0;
		 end
	       `PHY_RX_CTRL_0 :
		 begin
		    phy_shad003 <= {mb_rx_data[1:0],1'b1};
		    mb_cdb_invalid_addr_uncom <= 1'b0;
		 end
	       `PHY_RX_CTRL_1 :
		 begin
		    phy_shad004 <= {mb_rx_data[2:0],1'b1};
		    mb_cdb_invalid_addr_uncom <= 1'b0;
		 end
	       `PHY_RX_CTRL_2 :
		 begin
		    mb_cdb_invalid_addr_uncom <= 1'b0;
		 end
	       `PHY_RX_CTRL_3 :
		 begin
		    phy_shad006 <= {mb_rx_data[2:0],1'b1};
		    mb_cdb_invalid_addr_uncom <= 1'b0;
		 end
	       `PHY_EL_BUF_LOC_UP_FRQ :
		 begin
		    phy_shad007 <= {mb_rx_data,1'b1};
		    mb_cdb_invalid_addr_uncom <= 1'b0;
		 end
	     //  `PHY_TX_CTRL_0 :
		 //begin
		 //   phy_shad400 <= {mb_rx_data[1:0],1'b1};
		 //   mb_cdb_invalid_addr_uncom <= 1'b0;
		 //end
	       `PHY_TX_CTRL_1 :
		 begin
		    phy_shad401 <= {mb_rx_data[0],1'b1};
		    mb_cdb_invalid_addr_uncom <= 1'b0;
		 end
	       `PHY_TX_CTRL_2 :
		 begin
		    phy_shad402 <= {mb_rx_data[5:0],1'b1};
		    mb_cdb_invalid_addr_uncom <= 1'b0;
		 end
	       `PHY_TX_CTRL_3 :
		 begin
		    phy_shad403 <= {mb_rx_data[5:0],1'b1};
		    mb_cdb_invalid_addr_uncom <= 1'b0;
		 end
	       `PHY_TX_CTRL_4 :
		 begin
		    phy_shad404 <= {mb_rx_data[5:0],1'b1};
		    mb_cdb_invalid_addr_uncom <= 1'b0;
		 end
	       `PHY_TX_CTRL_5 :
		 begin
		    phy_shad405[7] <= mb_rx_data[7];
		    phy_shad405[6:1] <= mb_rx_data[5:0];
		    phy_shad405[0] <= 1'b1;
		    mb_cdb_invalid_addr_uncom <= 1'b0;
		 end
	       `PHY_TX_CTRL_6 :
		 begin
		    phy_shad406 <= {mb_rx_data[7:0],1'b1};
		    mb_cdb_invalid_addr_uncom <= 1'b0;
		 end
	       `PHY_TX_CTRL_7 :
		 begin
		    phy_shad407 <= {mb_rx_data[7:0],1'b1};
		    mb_cdb_invalid_addr_uncom <= 1'b0;
		 end
	       `PHY_TX_CTRL_8 :
		 begin
		    phy_shad408 <= {mb_rx_data[3:0],1'b1};
		    mb_cdb_invalid_addr_uncom <= 1'b0;
		 end
	       `PHY_TX_CTRL_9 :
		 begin
		    phy_shad409 <= {mb_rx_data[5:0],1'b1};
		    mb_cdb_invalid_addr_uncom <= 1'b0;
		 end
	       `PHY_CMN_CTRL_0 :
		 begin
		    phy_shad800 <= {mb_rx_data[1:0],1'b1};
		    mb_cdb_invalid_addr_uncom <= 1'b0;
		 end	    
	       `PHY_NEL_CTRL_0 :
		 begin
		    phy_shad801 <= {mb_rx_data[7],mb_rx_data[2:0],1'b1};
		    mb_cdb_invalid_addr_uncom <= 1'b0;
		 end	    
	       default :
		 begin
		    mb_cdb_invalid_addr_uncom <= 1'b1;
		 end
	     endcase
	
	  end

	else 
	  begin
	     // Zero-out 1-cycle register bits
	     mb_cdb_invalid_addr_uncom <= 1'b0;
	     phy_reg000 <= {2'h0,phy_reg000[1:0]};
	     phy_reg004 <= {(phy_reg004[2] & ~pclk64_rate_change),1'h0,phy_reg004[0]};
	     phy_reg405 <= {1'b0,phy_reg405[5:0]};
	     eb_ctrl_upd <= 1'b0;
	     tx_deemph_strobe <= 1'b0;
	     tx_swgmgn_strobe <= 1'b0;
	  end
     end

   // Invalid address detection
   always @(posedge pipe_mac2phy_clk or negedge pipe_mac2phy_rstn)
     begin
	if (~pipe_mac2phy_rstn)
	  begin
	     mb_cdb_invalid_addr_com <= 1'b0;
	  end
	else if (ctrl_soft_reset)
	  begin
	     mb_cdb_invalid_addr_com <= 1'b0;
	  end
	else if (rx_write_com)
	  begin
	     case (mb_rx_address)
	       `PHY_RX_MRGN_CTRL_0 : 
		 begin
		    mb_cdb_invalid_addr_com <= 1'b0;
		 end
	       `PHY_RX_MRGN_CTRL_1 :
		 begin
		    mb_cdb_invalid_addr_com <= 1'b0;
		 end
	       `PHY_EL_BUF_CTRL :
		 begin
		    mb_cdb_invalid_addr_com <= 1'b0;
		 end
	       `PHY_RX_CTRL_0 :
		 begin
		    mb_cdb_invalid_addr_com <= 1'b0;
		 end
	       `PHY_RX_CTRL_1 :
		 begin
		    mb_cdb_invalid_addr_com <= 1'b0;
		 end
	       `PHY_RX_CTRL_2 :
		 begin
		    mb_cdb_invalid_addr_com <= 1'b0;
		 end
	       `PHY_RX_CTRL_3 :
		 begin
		    mb_cdb_invalid_addr_com <= 1'b0;
		 end
	       `PHY_EL_BUF_LOC_UP_FRQ :
		 begin
		    mb_cdb_invalid_addr_com <= 1'b0;
		 end
	       `PHY_TX_CTRL_0 :
		 begin
		    mb_cdb_invalid_addr_com <= 1'b0;
		 end
	       `PHY_TX_CTRL_1 :
		 begin
		    mb_cdb_invalid_addr_com <= 1'b0;
		 end
	       `PHY_TX_CTRL_2 :
		 begin
		    mb_cdb_invalid_addr_com <= 1'b0;
		 end
	       `PHY_TX_CTRL_3 :
		 begin
		    mb_cdb_invalid_addr_com <= 1'b0;
		 end
	       `PHY_TX_CTRL_4 :
		 begin
		    mb_cdb_invalid_addr_com <= 1'b0;
		 end
	       `PHY_TX_CTRL_5 :
		 begin
		    mb_cdb_invalid_addr_com <= 1'b0;
		 end
	       `PHY_TX_CTRL_6 :
		 begin
		    mb_cdb_invalid_addr_com <= 1'b0;
		 end
	       `PHY_TX_CTRL_7 :
		 begin
		    mb_cdb_invalid_addr_com <= 1'b0;
		 end
	       `PHY_TX_CTRL_8 :
		 begin
		    mb_cdb_invalid_addr_com <= 1'b0;
		 end
	       `PHY_TX_CTRL_9 :
		 begin
		    mb_cdb_invalid_addr_com <= 1'b0;
		 end
	       `PHY_CMN_CTRL_0 :
		 begin
		    mb_cdb_invalid_addr_com <= 1'b0;
		 end	    
	       `PHY_NEL_CTRL_0 :
		 begin
		    mb_cdb_invalid_addr_com <= 1'b0;
		 end	    
	       default :
		 begin
		    mb_cdb_invalid_addr_com <= 1'b1;
		 end
	     endcase
	
	  end
	else
	  begin
	     mb_cdb_invalid_addr_com <= 1'b0;
	  end
     end

//--------------------------------------------------------------------
// MB Controller performs the priority management if there are 
// multiple requests that are pending at the same time. The
// following are possible requests that could arise at the same
// time. 
// 1. MAC Read Completion: MAC could issue read request for which
//    which PHY needs to respond with read completion (read data).
//    Internal flag name is tx_read_completion.
// 2. MAC Write Ack: MAC could issue write request (committed) for
//    which PHY needs to respond with Write Ack. Internal flag name
//    is tx_write_ack.
// 3. PHY Write (Status Updated) and Write Ack from MAC: PHY issues
//    write request (uncommitted followed by committed) for which
//    MAC needs to respond with write Ack. Internal flag name is 
//    tx_write and rx_write_ack.
// 4. PHY Read: Not supported
//
// All the internal flags memtioned above are set below.
//--------------------------------------------------------------------

//--------------------------------------------------------------------
// tx_read_completion and tx_read_data 
//--------------------------------------------------------------------
// 1. tx_read_completion is asserted when PHY receives the
//    Read command from the MAC
// 2. tx_read_completion is de-asserted when the PHY has
//    successfully sent the Read data to the MAC which 
//    will be signalled by mb_tx_cmd_done from the LM Tx Ctrl
//    and there is no pending new read command from MAC. 
//    If there is a pending read command, then the 
//    tx_read_completion is not reset to '0', so that the
//    pending read request is subsequently initiated. Both
//    rx_read_pending and tx_read_pending are used in the
//    condition as the read request might come before or 
//    same time or after the current read completion ie.,
//    tx_read_completion_rst. Hence both the variables are
//    used to ensure that the new read request is taken care
// 3. tx_data is loaded based on the address received in
//    the Read command from the MAC
//--------------------------------------------------------------------

   always @(posedge pipe_mac2phy_clk or negedge pipe_mac2phy_rstn)
     begin
	if (~pipe_mac2phy_rstn)
	  begin
	     tx_read_completion 	<= 1'b0;
	     tx_read_data		<= 8'd0;
	  end
	else if (ctrl_soft_reset | (tx_read_completion_rst & ~rx_read_pending & ~tx_read_pending))
	  begin
	     tx_read_completion 	<= 1'b0;
	     tx_read_data		<= 8'd0;
	  end
	else if (rx_read)
	  begin
	     tx_read_completion 	<= 1'b1;
	     case (mb_rx_address)
	       `PHY_RX_MRGN_CTRL_0:
		 begin
		    tx_read_data <= {4'd0,phy_reg000};
		 end
	       `PHY_RX_MRGN_CTRL_1:
		 begin
		    tx_read_data <= phy_reg001;
		 end
	       `PHY_EL_BUF_CTRL:
		 begin
		    tx_read_data <= phy_reg002;
		 end
	       `PHY_RX_CTRL_0 :
		 begin
		    tx_read_data <= {6'd0,phy_reg003};
		 end
	       `PHY_RX_CTRL_1 :
		 begin
		    tx_read_data <= {5'd0,phy_reg004};
		 end
	       `PHY_RX_CTRL_2 :
		 begin
		    tx_read_data <= 8'h00;
		 end
	       `PHY_RX_CTRL_3 :
		 begin
		    tx_read_data <= {5'd0,phy_reg006};
		 end
	       `PHY_EL_BUF_LOC_UP_FRQ :
		 begin
		    tx_read_data <= phy_reg007;
		 end
	     //  `PHY_TX_CTRL_0 :
		 //begin
		 //   tx_read_data <= {6'd0,phy_reg400};
		 //end
	       `PHY_TX_CTRL_1 :
		 begin
		    tx_read_data <= {7'd0,phy_reg401};
		 end
	       `PHY_TX_CTRL_2 :
		 begin
		    tx_read_data <= {2'd0,phy_reg402};
		 end
	       `PHY_TX_CTRL_3 :
		 begin
		    tx_read_data <= {2'd0,phy_reg403};
		 end
	       `PHY_TX_CTRL_4 :
		 begin
		    tx_read_data <= {2'd0,phy_reg404};
		 end
	       `PHY_TX_CTRL_5 :
		 begin
		    tx_read_data <= {phy_reg405[6],1'b0,phy_reg405[5:0]};
		 end
	       `PHY_TX_CTRL_6 :
		 begin
		    tx_read_data <= phy_reg406;
		 end
	       `PHY_TX_CTRL_7 :
		 begin
		    tx_read_data <= phy_reg407;
		 end
	       `PHY_TX_CTRL_8 :
		 begin
		    tx_read_data <= {4'd0,phy_reg408};
		 end
	       `PHY_TX_CTRL_9 :
		 begin
		    tx_read_data <= {2'd0,phy_reg409};
		 end
	       `PHY_CMN_CTRL_0 :
		 begin
		    tx_read_data <= {6'd0,phy_reg800};
		 end	    
	       `PHY_NEL_CTRL_0 :
		 begin
		    tx_read_data <= {phy_reg801[3],4'b0000,phy_reg801[2:0]};
		 end	    
	       default
		 begin
		    tx_read_data <= 8'd0;
		 end
	     endcase
	  end
     end

//--------------------------------------------------------------------
// tx_read_pending 
//--------------------------------------------------------------------
// 1. tx_read_pending is asserted when tx_read_completion is
//    set ie., there is an ongoing Tx Read and a new Read
//    command (rx_read = 1) is issued by the MAC
// 2. tx_read_pending is de-asserted when the pending read
//    request is initiated and the data transmit has started
//--------------------------------------------------------------------
   
   assign rx_read_pending    = (tx_read_completion & rx_read);
   assign tx_read_pending_rst = load_tx_read_data;
   
   always @(posedge pipe_mac2phy_clk or negedge pipe_mac2phy_rstn)
     begin
	if (~pipe_mac2phy_rstn)
	  tx_read_pending <= 1'b0;
	else if (ctrl_soft_reset | tx_read_pending_rst)
	  tx_read_pending <= 1'b0;
	else if (rx_read_pending)
	  tx_read_pending <= 1'b1;
     end



//--------------------------------------------------------------------
// tx_write_ack
//--------------------------------------------------------------------
// 1. tx_write_ack is asserted when PHY receives write
//    committed request
// 2. tx_write_ack is de-asserted when the PHY has 
//    successfully send the Write Ack to the MAC which will 
//    be signalled by mb_tx_cmd_done from the MB Tx Ctrl
//--------------------------------------------------------------------

   always @(posedge pipe_mac2phy_clk or negedge pipe_mac2phy_rstn)
     begin
	if (~pipe_mac2phy_rstn)
	  tx_write_ack <= 1'b0;
	else if (ctrl_soft_reset | tx_write_ack_rst)
	  tx_write_ack <= 1'b0;
	else if (rx_write_com)
	  tx_write_ack <= 1'b1;
     end

//--------------------------------------------------------------------
// rx_write_ack
//--------------------------------------------------------------------
// 1. rx_write_ack is asserted when PHY receives write
//    ack from the MAC for PHY issued tx write
// 2. rx_write_ack is de-asserted when the PHY has 
//    successfully looked into the Write Ack from the MAC 
//    in the FSM. It is possible that FSM will have to detour
//    to send the Tx Write Ack while it is waiting for Rx Write
//    Ack from the MAC. Hence it is required to store this 
//    value for the FSM to sence when it is back to the 
//    Wait for Rx Write Ack state. Once the FSM has looked
//    in the status update from MAC, then it will de-assert
//    rx_write_ack.
//--------------------------------------------------------------------

   always @(posedge pipe_mac2phy_clk or negedge pipe_mac2phy_rstn)
     begin
	if (~pipe_mac2phy_rstn)
	  rx_write_ack <= 1'b0;
	else if (ctrl_soft_reset | rx_write_ack_rst | (mb_ctrl_state == MB_CTRL_IDLE))
	  rx_write_ack <= 1'b0;
	else if (phy_write_ack)
	  rx_write_ack <= 1'b1;
     end
 
//--------------------------------------------------------------------
// 1. mb_tx_cmd is asserted when
//	a. PHY transmits command/data to the MAC
// 2. mb_tx_cmd_req is de-asserted when
//	a. PHY successfully transmits the command/data to
//	   MAC indicated via posedge of mb_tx_cmd_done
// mb_tx_cmn_req needs to be de-asserted for at least 2 clock cycles.
//   Thus mb_tx_cmd_req_en is registered.
//--------------------------------------------------------------------
   
   always @(posedge pipe_mac2phy_clk or negedge pipe_mac2phy_rstn)
     begin
	if (~pipe_mac2phy_rstn)
	  begin
	     mb_tx_cmd_req_en_reg <= 1'b0;
	  end
	else
	  begin
	     mb_tx_cmd_req_en_reg <= mb_tx_cmd_req_en;
	  end
     end
   
   always @(posedge pipe_mac2phy_clk or negedge pipe_mac2phy_rstn)
     begin
	if (~pipe_mac2phy_rstn)
	  begin
	     mb_tx_cmd_req <= 1'b0;
	  end
	else if (ctrl_soft_reset | mb_tx_cmd_req_rst)
	  begin
	     mb_tx_cmd_req <= 1'b0;
	  end
	else if (mb_tx_cmd_req_en_reg)
	  begin
	     mb_tx_cmd_req <= 1'b1;
	  end
     end

   
//--------------------------------------------------------------------
// Edge of mb_tx_cmd_done
//--------------------------------------------------------------------
   
   always @(posedge pipe_mac2phy_clk or negedge pipe_mac2phy_rstn)
     begin
	if (~pipe_mac2phy_rstn)
	  begin
	     mb_tx_cmd_done_reg <= 6'h00;
	  end
	else if (ctrl_soft_reset)
	  begin
	     mb_tx_cmd_done_reg <= 6'h00;
	  end
	else
	  begin
	     mb_tx_cmd_done_reg <= mb_tx_cmd_done;
	  end
     end

   assign edge_mb_tx_cmd_done = (mb_tx_cmd_done ^ mb_tx_cmd_done_reg);

   
//--------------------------------------------------------------------
// Trigger signals to convert P2M write requests into write
// sequence commands (directed at the TX block). The triggers
// are derived from tx_write requests using a specific block
//  *_tx_write qualified by load_tx_write_data.
//
// Note that some triggers are defined in the FSM because
// they require a specific state to set them.
//--------------------------------------------------------------------

   assign ebsts_load_tx_write_data = load_tx_write_data & prio_tx_writes[0];
   assign lmstart_load_tx_write_data = load_tx_write_data & prio_tx_writes[1];
   assign lmofst_load_tx_write_data = load_tx_write_data & prio_tx_writes[2];
   assign lmdat_load_tx_write_data = load_tx_write_data & prio_tx_writes[3];
   assign lmend_load_tx_write_data = load_tx_write_data & prio_tx_writes[4];
   assign coef_legacy_load_tx_write_data = load_tx_write_data & prio_tx_writes[5];
   assign g67fslf_load_tx_write_data = load_tx_write_data & prio_tx_writes[6];
   assign retc_load_tx_write_data = load_tx_write_data & prio_tx_writes[7];
   assign eval_g67_load_tx_write_data = load_tx_write_data & prio_tx_writes[8];
   assign eval_legacy_load_tx_write_data = load_tx_write_data & prio_tx_writes[9];
   assign fom_load_tx_write_data = load_tx_write_data & prio_tx_writes[10];
   assign fslf_load_tx_write_data = load_tx_write_data & prio_tx_writes[11];
   assign g4fslf_load_tx_write_data = load_tx_write_data & prio_tx_writes[12];
   assign g5fslf_load_tx_write_data = load_tx_write_data & prio_tx_writes[13];
   assign phyiorecalreq_load_tx_write_data = load_tx_write_data & prio_tx_writes[14];
   assign iorecaldone_load_tx_write_data = load_tx_write_data & prio_tx_writes[15];
   assign coef_g67_load_tx_write_data = load_tx_write_data & prio_tx_writes[16];

   assign cofslf_load_tx_write_data = 1'b0; //FIXME remove
   assign cog4fslf_load_tx_write_data = 1'b0; //FIXME remove
   assign cog5fslf_load_tx_write_data = 1'b0; //FIXME remove

   // Soft reset for this function
   assign cmd_req_seq_rst = ctrl_soft_reset | tx_read_completion_rst |
			      tx_write_ack_rst | rx_write_ack_rst;


   // Respond to triggers by sending sequences of P2M write requests to the TX block.
   // Use the write-burst count to allow arbitrarily-long sequences of uncomm writes
   //  before a committed write.
   //
   // *_fslf_sent signals are used to inform the fslf block that the last command
   // request has been made
   always @(posedge pipe_mac2phy_clk or negedge pipe_mac2phy_rstn)
     begin
	if (~pipe_mac2phy_rstn)
	  begin
	     mb_tx_bus_values_r0 <= 24'd0;
	     mb_tx_bus_values_r1 <= 24'd0;
	     mb_tx_bus_values_r2 <= 24'd0;
	     mb_tx_bus_values_r3 <= 24'd0;
	     mb_tx_bus_values_r4 <= 24'd0;
	     //fslf_sent <= 1'b0;
	     //g4fslf_sent <= 1'b0;
	     //g5fslf_sent <= 1'b0;
	     //g67fslf_sent <= 1'b0;
	     phyiorecalreq_sent <= 1'b0;
	     iorecaldone_sent <= 1'b0;
	     mb_tx_wrb_cnt <= 3'h0;
	  end
	else if (cmd_req_seq_rst)
	  begin
	     mb_tx_bus_values_r0 <= 24'd0;
	     mb_tx_bus_values_r1 <= 24'd0;
	     mb_tx_bus_values_r2 <= 24'd0;
	     mb_tx_bus_values_r3 <= 24'd0;
	     mb_tx_bus_values_r4 <= 24'd0;
	     //fslf_sent <= 1'b0;
	     //g4fslf_sent <= 1'b0;
	     //g5fslf_sent <= 1'b0;
	     //g67fslf_sent <= 1'b0;
	     phyiorecalreq_sent <= 1'b0;
	     iorecaldone_sent <= 1'b0;
	     mb_tx_wrb_cnt <= 3'h0;
	  end
	else
	  begin
	     // Request Tx Read Completion
	     if (load_tx_read_data)
	       begin
		  mb_tx_bus_values_r0 <= {tx_read_data,12'h000,`MB_READ_COMPLETION};
		  mb_tx_wrb_cnt <= 3'h0;
	       end
	     // Request Tx Write Ack
	     else if (load_tx_write_ack)
	       begin
		  mb_tx_bus_values_r0 <= {20'h00000,`MB_WRITE_ACK};
		  mb_tx_wrb_cnt <= 3'h0;
	       end

	     // Request Tx Writes for EB status function
	     else if (ebsts_load_tx_write_data)
	       begin
		  mb_tx_bus_values_r0 <= {mac_reg003,`MAC_EL_BUF_STAT,`MB_WRITE_COMMITTED};
		  mb_tx_wrb_cnt <= 3'h0;
	       end

	     // Request Tx Writes for LM
	     // start of LM (includes NAK case)
	     else if (lmstart_load_tx_write_data)
	       begin
		  if (lm_dep)
		    begin
		       mb_tx_bus_values_r0 <= {mac_reg000,`MAC_RX_MRGN_STAT_0,`MB_WRITE_COMMITTED};
		       mb_tx_wrb_cnt <= 3'h0;
		    end
		  else
		    begin
		       mb_tx_bus_values_r0 <= {mac_reg000,`MAC_RX_MRGN_STAT_0,`MB_WRITE_COMMITTED};
		       mb_tx_bus_values_r1 <= {mac_reg002,`MAC_RX_MRGN_STAT_2,`MB_WRITE_UNCOMMITTED};
		       mb_tx_bus_values_r2 <= {mac_reg001,`MAC_RX_MRGN_STAT_1,`MB_WRITE_UNCOMMITTED};
		       mb_tx_wrb_cnt <= 3'h3;
		    end
	       end
	     // offset change (includes NAK case)
	     else if (lmofst_load_tx_write_data)
	       begin
		  if (lm_dep)
		    begin
		       mb_tx_bus_values_r0 <= {mac_reg000,`MAC_RX_MRGN_STAT_0,`MB_WRITE_COMMITTED};
		       mb_tx_wrb_cnt <= 3'h0;
		    end
		  else
		    begin
		       begin
			  mb_tx_bus_values_r0 <= {mac_reg000,`MAC_RX_MRGN_STAT_0,`MB_WRITE_COMMITTED};
			  mb_tx_bus_values_r1 <= {mac_reg002,`MAC_RX_MRGN_STAT_2,`MB_WRITE_UNCOMMITTED};
			  mb_tx_bus_values_r2 <= {mac_reg001,`MAC_RX_MRGN_STAT_1,`MB_WRITE_UNCOMMITTED};
			  mb_tx_wrb_cnt <= 3'h3;
		       end
		    end
	       end
	     // error and sample counts: Updates, clear error, clear sample
	     else if (lmdat_load_tx_write_data)
	       begin
		  if (~lm_dep)
		    begin
		       mb_tx_bus_values_r0 <= {mac_reg002,`MAC_RX_MRGN_STAT_2,`MB_WRITE_COMMITTED};
		       mb_tx_bus_values_r1 <= {mac_reg001,`MAC_RX_MRGN_STAT_1,`MB_WRITE_UNCOMMITTED};
		       mb_tx_wrb_cnt <= 3'h2;
		    end
	       end
	     // End of LM
	     else if (lmend_load_tx_write_data)
	       begin
		  if (lm_dep)
		    begin
		       mb_tx_bus_values_r0 <= {mac_reg000,`MAC_RX_MRGN_STAT_0,`MB_WRITE_COMMITTED};
		       mb_tx_wrb_cnt <= 3'h0;
		    end
		  else
		    begin
		       mb_tx_bus_values_r0 <= {mac_reg000,`MAC_RX_MRGN_STAT_0,`MB_WRITE_COMMITTED};
		       mb_tx_bus_values_r1 <= {mac_reg002,`MAC_RX_MRGN_STAT_2,`MB_WRITE_UNCOMMITTED};
		       mb_tx_bus_values_r2 <= {mac_reg001,`MAC_RX_MRGN_STAT_1,`MB_WRITE_UNCOMMITTED};
		       mb_tx_wrb_cnt <= 3'h3;
		    end
	       end

	     // Request Tx Write Data for coef (legacy)
	     else if ((coef_legacy_load_tx_write_data)|(cofslf_load_tx_write_data)|(cog4fslf_load_tx_write_data)|(cog5fslf_load_tx_write_data))
	       begin
		  mb_tx_bus_values_r0 <= {{2'b0,tx_preset_coef_legacy_reg[17:12]},`MAC_TX_STAT_2,`MB_WRITE_COMMITTED};
		  mb_tx_bus_values_r1 <= {{2'b0,tx_preset_coef_legacy_reg[11:6]},`MAC_TX_STAT_1,`MB_WRITE_UNCOMMITTED};
		  mb_tx_bus_values_r2 <= {{2'b0,tx_preset_coef_legacy_reg[5:0]},`MAC_TX_STAT_0,`MB_WRITE_UNCOMMITTED};
		  mb_tx_wrb_cnt <= 3'h3;
	       end

	     //Request write data for RX EQ Training done
	     else if (retc_load_tx_write_data)
	       begin
		  mb_tx_bus_values_r0 <= {8'h01,`MAC_RX_STAT_0,`MB_WRITE_COMMITTED};
		  mb_tx_wrb_cnt <= 3'h0;
	       end

	     // Request Tx Write for link eval status 2/3
	     else if (eval_g67_load_tx_write_data)
	       begin
		  mb_tx_bus_values_r0 <= {rx_link_eval_status2,`MAC_LINK_EVAL_STAT_2,`MB_WRITE_COMMITTED};
		  mb_tx_bus_values_r1 <= {rx_link_eval_status3,`MAC_LINK_EVAL_STAT_3,`MB_WRITE_UNCOMMITTED};
		  mb_tx_wrb_cnt <= 3'h2;
	       end
	     // Request Tx Write for link eval status 1
	     else if (eval_legacy_load_tx_write_data)
	       begin
		  mb_tx_bus_values_r0 <= {rx_link_eval_status1,`MAC_LINK_EVAL_STAT_1,`MB_WRITE_COMMITTED};
		  mb_tx_wrb_cnt <= 3'h0;
	       end
	     // Request Tx Write for link eval status 0
	     else if (fom_load_tx_write_data)
	       begin
		  mb_tx_bus_values_r0 <= {rx_link_eval_status0,`MAC_LINK_EVAL_STAT_0,`MB_WRITE_COMMITTED};
		  mb_tx_wrb_cnt <= 3'h0;
	       end

	     // Request Tx Write Data for fslf
	     else if (fslf_load_tx_write_data)
	       begin
		  mb_tx_bus_values_r0 <= {local_lf_reg,`MAC_TX_STAT_4,`MB_WRITE_COMMITTED};
		  mb_tx_bus_values_r1 <= {local_fs_reg,`MAC_TX_STAT_3,`MB_WRITE_UNCOMMITTED};
		  //fslf_sent <= 1'b1;
		  mb_tx_wrb_cnt <= 3'h2;
	       end
	     // Request Tx Write Data for g4fslf
	     else if (g4fslf_load_tx_write_data)
	       begin
		  mb_tx_bus_values_r0 <= {local_lf_reg,`MAC_TX_STAT_6,`MB_WRITE_COMMITTED};
		  mb_tx_bus_values_r1 <= {local_fs_reg,`MAC_TX_STAT_5,`MB_WRITE_UNCOMMITTED};
		  //g4fslf_sent <= 1'b1;
		  mb_tx_wrb_cnt <= 3'h2;
	       end
	     // Request Tx Write Data for g5fslf
	     else if (g5fslf_load_tx_write_data)
	       begin
		  mb_tx_bus_values_r0 <= {local_lf_reg,`MAC_RX_STAT_5,`MB_WRITE_COMMITTED};
		  mb_tx_bus_values_r1 <= {local_fs_reg,`MAC_RX_STAT_4,`MB_WRITE_UNCOMMITTED};
		  //g5fslf_sent <= 1'b1;
		  mb_tx_wrb_cnt <= 3'h2;
	       end
	     // Request Tx Write Data for g67fslf
	     else if (g67fslf_load_tx_write_data)
	       begin
		  mb_tx_bus_values_r0 <= {local_lf_reg,`MAC_TX_STAT_9,`MB_WRITE_COMMITTED};
		  mb_tx_bus_values_r1 <= {local_fs_reg,`MAC_TX_STAT_8,`MB_WRITE_UNCOMMITTED};
		  //g67fslf_sent <= 1'b1;
		  mb_tx_wrb_cnt <= 3'h2;
	       end


	     // Request Tx Write for PhyIORecalRequest
	     else if (phyiorecalreq_load_tx_write_data)
	       begin
		  mb_tx_bus_values_r0 <= {8'h01,`MAC_RX_CTRL_0,`MB_WRITE_COMMITTED};
		  phyiorecalreq_sent <= 1'b1;
		  mb_tx_wrb_cnt <= 3'h0;
	       end
	     // Request Tx Write for PhyIORecalRequest
	     else if (iorecaldone_load_tx_write_data)
	       begin
		  mb_tx_bus_values_r0 <= {8'h02,`MAC_RX_STAT_0,`MB_WRITE_COMMITTED};
		  iorecaldone_sent <= 1'b1;
		  mb_tx_wrb_cnt <= 3'h0;
	       end

	     // Request Tx Write Data for coef (g67)
	     else if (coef_g67_load_tx_write_data)
	       begin
		  mb_tx_bus_values_r0 <= {2'h0,tx_preset_coef_g67_reg[23:18],`MAC_TX_STAT_2,`MB_WRITE_COMMITTED};
		  mb_tx_bus_values_r1 <= {2'h0,tx_preset_coef_g67_reg[17:12],`MAC_TX_STAT_1,`MB_WRITE_UNCOMMITTED};
		  mb_tx_bus_values_r2 <= {2'h0,tx_preset_coef_g67_reg[11:6],`MAC_TX_STAT_0,`MB_WRITE_UNCOMMITTED};
		  mb_tx_bus_values_r3 <= {2'h0,tx_preset_coef_g67_reg[5:0],`MAC_TX_STAT_7,`MB_WRITE_UNCOMMITTED};
		  mb_tx_wrb_cnt <= 3'h4;
	       end


	     // If no requests made, just clean up indicators.
	     else
	       begin
		  //fslf_sent <= 1'b0;
		  //g4fslf_sent <= 1'b0;
		  //g5fslf_sent <= 1'b0;
		  phyiorecalreq_sent <= 1'b0;
		  iorecaldone_sent <= 1'b0;
	       end
	  end
     end


//--------------------------------------------------------------------
// Flop to store the tx_write_ack transition in the middle of
// tx_write (PHY Status update). This signal will be used by the 
// FSM to deviate the tx_write flow to send the tx_write_ack and
// again come back to the tx_write flow for receiving the rx_write_ack
//--------------------------------------------------------------------

   always @(posedge pipe_mac2phy_clk or negedge pipe_mac2phy_rstn)
     begin
	if (~pipe_mac2phy_rstn)
	  tx_write_ack_trans <= 1'b0;
	else if (ctrl_soft_reset | tx_write_ack_trans_rst)
	  tx_write_ack_trans <= 1'b0;
	else if (tx_write_ack_trans_en)
	  tx_write_ack_trans <= 1'b1;
     end

   always @(posedge pipe_mac2phy_clk or negedge pipe_mac2phy_rstn)
     begin
	if (~pipe_mac2phy_rstn)
	  tx_read_completion_trans <= 1'b0;
	else if (ctrl_soft_reset | tx_read_completion_trans_rst)
	  tx_read_completion_trans <= 1'b0;
	else if (tx_read_completion_trans_en)
	  tx_read_completion_trans <= 1'b1;
     end


//--------------------------------------------------------------------
// Keep track of which block is driving the current TX write. The
// TX priority circuit will scan the active *_tx_write signals and
// choose the one that should be acted on.
//
// prio_tx_writes[0]  -- ebsts_tx_write
// prio_tx_writes[4:1]  -- lm_tx_writes[3:0]
// prio_tx_writes[5]  -- coef_legacy_tx_write, cofslf_tx_write, cog4fslf_tx_write, cog5fslf_tx_write
// prio_tx_writes[6]  -- g67fslf_tx_write
// prio_tx_writes[7]  -- rx_eq_training_cmpl_tx_write
// prio_tx_writes[8]  -- eval_g67_tx_write
// prio_tx_writes[9]  -- eval_legacy_tx_write
// prio_tx_writes[10]  -- fom_tx_write
// prio_tx_writes[11]  -- fslf_tx_write
// prio_tx_writes[12]  -- g4fslf_tx_write
// prio_tx_writes[13]  -- g5fslf_tx_write
// prio_tx_writes[14]  -- phyiorecalreq_tx_write
// prio_tx_writes[15]  -- iorecaldone_tx_write
// prio_tx_writes[16]  -- coef_g67_load_tx_write_data
//--------------------------------------------------------------------
   
   always @(posedge pipe_mac2phy_clk or negedge pipe_mac2phy_rstn)
     begin
	if (~pipe_mac2phy_rstn)
	  prio_tx_writes <= 17'h0;
	else
	  begin
	     if (mb_ctrl_state == MB_CTRL_IDLE)
	       begin
		  if (ebsts_tx_write) prio_tx_writes <= 17'b0_0000_0000_0000_0001;

		  else if (lm_tx_writes[0]) prio_tx_writes <= 17'b0_0000_0000_0000_0010;
		  else if (lm_tx_writes[1]) prio_tx_writes <= 17'b0_0000_0000_0000_0100;
		  else if (lm_tx_writes[2]) prio_tx_writes <= 17'b0_0000_0000_0000_1000;
		  else if (lm_tx_writes[3]) prio_tx_writes <= 17'b0_0000_0000_0001_0000;

		  else if (coef_legacy_tx_write | cofslf_tx_write | cog4fslf_tx_write | cog5fslf_tx_write) prio_tx_writes <= 17'b0_0000_0000_0010_0000;
		  else if (g67fslf_tx_write) prio_tx_writes <= 17'b0_0000_0000_0100_0000;
		  else if (rx_eq_training_cmpl_tx_write) prio_tx_writes <= 17'b0_0000_0000_1000_0000;
		  else if (eval_g67_tx_write) prio_tx_writes <= 17'b0_0000_0001_0000_0000;
		  else if (eval_legacy_tx_write) prio_tx_writes <= 17'b0_0000_0010_0000_0000;
		  else if (fom_tx_write) prio_tx_writes <= 17'b0_0000_0100_0000_0000;
		  else if (fslf_tx_write) prio_tx_writes <= 17'b0_0000_1000_0000_0000;
		  else if (g4fslf_tx_write) prio_tx_writes <= 17'b0_0001_0000_0000_0000;
		  else if (g5fslf_tx_write) prio_tx_writes <= 17'b0_0010_0000_0000_0000;
		  else if (phyiorecalreq_tx_write) prio_tx_writes <= 17'b0_0100_0000_0000_0000;
		  else if (iorecaldone_tx_write) prio_tx_writes <= 17'b0_1000_0000_0000_0000;
		  else if (coef_g67_tx_write) prio_tx_writes <= 17'b1_0000_0000_0000_0000;
		  else prio_tx_writes <= 17'h0;
	       end
	  end
     end

   // Indicator that the write for a function has been made. This allows functional blocks
   // to stop asking for write.

   assign prio_tx_writes_done = prio_tx_writes & {17{edge_mb_tx_cmd_done[2]}};
   assign lm_rx_write_ack = (lm_dep) ? (|prio_tx_writes[4:1]) & rx_write_ack :
			    (|prio_tx_writes[4:3]) & rx_write_ack;

//--------------------------------------------------------------------
// Detection of post-reset FS/LF transmission:
// After we make the post-reset FS/LF write to the MAC we need to be
// sure that is is ACKed. Since that transmission is governed by
// the allfslf block we need to add a special wait-for-ack trigger
// based on a signal from that block.
//--------------------------------------------------------------------

   always @(posedge pipe_mac2phy_clk or negedge pipe_mac2phy_rstn)
     begin
	if (~pipe_mac2phy_rstn)
	  allfslf_ack_wait <= 1'b0;
	else if (ctrl_soft_reset)
	  allfslf_ack_wait <= 1'b0;
	else if (rx_write_ack_rst)
	  allfslf_ack_wait <= 1'b0;
	else if (allfslf_sent_mac2phy_sync)
	  allfslf_ack_wait <= 1'b1;
     end


//--------------------------------------------------------------------
// MB ctrl FSM State change register
//--------------------------------------------------------------------

   always @(posedge pipe_mac2phy_clk or negedge pipe_mac2phy_rstn)
     begin
	if (~pipe_mac2phy_rstn)
	  mb_ctrl_state <= MB_CTRL_IDLE;
	else if (ctrl_soft_reset)
	  mb_ctrl_state <= MB_CTRL_IDLE;
	else 
	  mb_ctrl_state <= mb_ctrl_next_state;
     end


//--------------------------------------------------------------------
// It is possible that flags tx_read_completion, tx_write and tx_write/rx_write_ack could
// be active at the same time. This module needs to decide on the priority between multiple
// commands valid at the same time. Also few conditions could be invalid. Below truth table
// captures all the possible conditions between these flags and determines the priority
// between them. Here 2 types of transitions are possible ie., when a flag is already 
// asserted another flag could transition (or) more than one flag could transition at the 
// same time. Both these transitions are considered with different encoding so that all 
// cases are covered. 
// Truth table legend is given below
// 0/1: 	Signals already transitioned
// 0 ----> 1: 	One flag transition
// 0--> 1:	More than one flag transition at the same time
//--------------------------------------------------------------------
// 					Truth Table
//--------------------------------------------------------------------
// tx_read_completion(A)   tx_write_ack(B)  tx_write/rx_write_ack(C)   Validity   Priority
//--------------------------------------------------------------------
//	     0			  0		     0			Valid	  No Action
//	     0			  0		     1			Valid	      C 
//	  0---->1		  0		     1			Valid	    C --> A
//	     0		        0---->1		     1			Valid     C --> B --> C
//	     0			  1		     0			Valid	      B
//	  0---->1		  1		     0			Invalid	  Not Applicable
//	     0			  1		   0---->1		Valid	      B
//	     0			 0-->1		    0-->1		Valid	      B
//	  0---->1		  1		     1			Invalid	  Not Applicable
//	     1			  0		     0			Valid	      A 
//	     1		        0---->1		     0			Invalid	  Not Applicable
//	     1			  0		   0---->1		Valid	    A --> C
//	   0-->1		  0		    0-->1		Valid	    A --> C
//	     1		        0---->1		     1			Invalid	  Not Applicable
//	   0-->1		0-->1		     0			Invalid	  Not Applicable
//	     1			  1		   0---->1		Invalid	  Not Applicable
//	   0-->1		0-->1		   0-->1		Invalid	  Not Applicable
//--------------------------------------------------------------------
//
// In essence, based on the above truth table the following is the summary
//
// 1. A and B CANNOT be TRUE at the same time (due to PIPE Spec)
// 2. B and C CAN    be TRUE at the same time (B executed, C ignored due to PHY implementation)
// 3. C and A CAN    be TRUE at the same time (A serviced first followed by B)
// 4. A/B/C   CANNOT be TRUE at the same time (due to above 3 conditions)
//
// Based on the above points, C will be either serviced or ignored when A or B are TRUE at the 
// same time. Therefore in the FSM IDLE state, A or B is given highest priority and C will take
// lowest priority. In the A or B loop, if B is TRUE, then C will be reset (ignored) and if A is 
// TRUE, then A is serviced first and then FSM will come back to IDLE state to service the pending C. 
// There is a special case, where C has already started and B transitioned. In such cases, C will
// completed until rx_wait_ack and then move to service B (so there is no dead lock with MAC) and
// then come back to the rx_wait_ack state to validate the C request.
//--------------------------------------------------------------------
   
//--------------------------------------------------------------------
// Finite State Machine 
//--------------------------------------------------------------------
   
// Detect when TX ACK request should be generated
   assign mb_tx_ack_req_comb = (mb_ctrl_state == MB_CTRL_TX_WR_ACK);

   always @(posedge pipe_mac2phy_clk or negedge pipe_mac2phy_rstn)
     begin
	if (~pipe_mac2phy_rstn)
	  mb_tx_ack_req <= 1'b0;
	else if (ctrl_soft_reset)
	  mb_tx_ack_req <= 1'b0;
	else if (mb_tx_ack_req_comb)
	  mb_tx_ack_req <= ~mb_tx_ack_req;
	else
	  mb_tx_ack_req <= mb_tx_ack_req;
     end


// These are all of the supported P2M writes
   assign tx_writes = (|lm_tx_writes) | eval_legacy_tx_write | eval_g67_tx_write | fom_tx_write |
		      coef_legacy_tx_write | coef_g67_tx_write | cofslf_tx_write | cog4fslf_tx_write | cog5fslf_tx_write |
		      fslf_tx_write | g4fslf_tx_write | g5fslf_tx_write | g67fslf_tx_write |
		      phyiorecalreq_tx_write | iorecaldone_tx_write | rx_eq_training_cmpl_tx_write | ebsts_tx_write;

   always @*
     begin
	
	mb_tx_cmd_req_en	= 1'b0;
	tx_write_ack_rst	= 1'b0;
	rx_write_ack_rst	= 1'b0;
	load_tx_read_data	= 1'b0;
	load_tx_write_ack	= 1'b0;
	mb_tx_cmd_req_rst	= 1'b0;
	load_tx_write_data	= 1'b0;
	tx_write_ack_trans_en	= 1'b0;
	tx_write_ack_trans_rst	= 1'b0;
	tx_read_completion_trans_en	= 1'b0;
	tx_read_completion_trans_rst	= 1'b0;
	tx_read_completion_rst	= 1'b0;

	case(mb_ctrl_state)
	  
	  MB_CTRL_IDLE:
	    begin
	       // Priority: A or B followed by C or Elasticity Buffer Status update. Between A or B, both of them will not be TRUE at the
	       // same time and they will be mutually exclusive as both A and B are responses to the MAC
	       // from PHY. Therefore it is assumed that MAC will not initiate both at the same time. Hence
	       // there is no priority between A or B. 
	       if (allfslf_ack_wait)
		 mb_ctrl_next_state = MB_CTRL_WT_RX_WR_ACK;
	       else if (tx_read_completion)
		 mb_ctrl_next_state = MB_CTRL_TX_RD_COMP;
	       else if (tx_write_ack)
		 mb_ctrl_next_state = MB_CTRL_TX_WR_ACK;
	       else if (tx_writes)
		 mb_ctrl_next_state = MB_CTRL_TX_WR_DATA;
	       else
		 mb_ctrl_next_state = MB_CTRL_IDLE;
	    end

	  MB_CTRL_TX_WR_DATA:
	    begin
	       mb_tx_cmd_req_en = 1'b1;
	       load_tx_write_data = 1'b1;
	       mb_ctrl_next_state = MB_CTRL_WT_TX_WR_DATA;
	    end
	  
	  MB_CTRL_WT_TX_WR_DATA:
	    begin
	       // Wait for the TX to declare it is done with the command
	       if (|edge_mb_tx_cmd_done)
		 begin
		    mb_tx_cmd_req_rst = 1'b1;
		    // Determine if we have sent all of the writes that we expect to for the current operation.
		    // If we have, we'll wait for an ACK.
		    if (|prio_tx_writes)
		      begin
			 mb_ctrl_next_state = MB_CTRL_WT_RX_WR_ACK;
		      end
		    else
		      begin
			 mb_ctrl_next_state = MB_CTRL_TX_WR_DATA;
		      end
		 end
	       else
		 begin
		    mb_ctrl_next_state = MB_CTRL_WT_TX_WR_DATA;
		 end
	    end

	  MB_CTRL_WT_RX_WR_ACK:
	    begin

	       // If you get a new command that requires you to transmit then you should stop waiting for
	       // an ACK for previous transmits.
	       if (tx_write_ack)
		 begin
		    tx_write_ack_trans_en = 1'b1 ;
		    mb_ctrl_next_state = MB_CTRL_TX_WR_ACK;
		 end
	       else
		 begin
		    if (rx_write_ack)
		      begin
			 rx_write_ack_rst = 1'b1;
			 if (tx_write_ack_trans)
			   begin
			      tx_write_ack_trans_rst = 1'b1;
			      mb_ctrl_next_state = MB_CTRL_IDLE;
			   end
			 else
			   begin
			      mb_ctrl_next_state = MB_CTRL_IDLE;
			   end
		      end
		    else if (tx_read_completion)
		      begin
			 //Set the trans bit and service the RdCmp
			 tx_read_completion_trans_en = 1'b1;
			 mb_ctrl_next_state = MB_CTRL_TX_RD_COMP;
		      end
		    else
		      mb_ctrl_next_state = MB_CTRL_WT_RX_WR_ACK;
		 end
	    end	
	  
	  MB_CTRL_TX_WR_ACK:
	    begin
	       mb_tx_cmd_req_en = 1'b1;
	       load_tx_write_ack = 1'b1;
	       mb_ctrl_next_state = MB_CTRL_WT_TX_WR_ACK;
	    end

	  MB_CTRL_WT_TX_WR_ACK:
	    begin
	       // This state could be entered directly from IDLE state or from MB_CTRL_WT_RX_WR_ACK.
	       mb_tx_cmd_req_rst = 1'b1;
	       tx_write_ack_rst = 1'b1;
	       // If we interrupted waiting to RX write ACK go back and wait for it
	       if (tx_write_ack_trans)
		 begin
		    mb_ctrl_next_state = MB_CTRL_WT_RX_WR_ACK;
		 end
	       else
		 mb_ctrl_next_state = MB_CTRL_IDLE;
	    end
	  
	  MB_CTRL_TX_RD_COMP:
	    begin
	       mb_tx_cmd_req_en = 1'b1;
	       load_tx_read_data = 1'b1;
	       mb_ctrl_next_state = MB_CTRL_WT_TX_RD_COMP;
	    end

	  MB_CTRL_WT_TX_RD_COMP:
	    begin
	       if (edge_mb_tx_cmd_done[4])
		 begin
		    mb_tx_cmd_req_rst = 1'b1;
		    tx_read_completion_rst = 1'b1;
		    if (tx_read_completion_trans)
		      begin
			 tx_read_completion_trans_rst = 1'b1;
			 mb_ctrl_next_state = MB_CTRL_WT_RX_WR_ACK;
		      end
		    else
		      mb_ctrl_next_state = MB_CTRL_IDLE;
		 end
	       else
		 mb_ctrl_next_state = MB_CTRL_WT_TX_RD_COMP;
	    end
	  
	  default: mb_ctrl_next_state = MB_CTRL_IDLE;

	endcase

     end


//--------------------------------------------------------------------
// Assign key signals and output pins to message-bus registers
//--------------------------------------------------------------------


// Not needed in this module   assign lm_active = phy_reg000[0];
   assign eb_ctrl = phy_reg002;
   assign eb_mode = phy_reg003[0];
   assign rx_polarity = phy_reg003[1];
   assign rx_eq_training = phy_reg004[0];
   assign rx_m2p_recal_req = phy_reg004[1];
   `ifdef PAM4_RESTRICTED_LEVELS
   assign PAM4RestrictedLevels = phy_reg004[2];
   `endif
   assign rx_invalid_request = phy_reg006[2];
   assign rx_eq_in_progress = phy_reg006[1];
   assign rx_eq_eval = phy_reg006[0];
   //assign tx_pattern = phy_reg400[1:0];
   assign tx_ones_zeros = phy_reg401;
   assign tx_deemph_cx = {phy_reg404,phy_reg403,phy_reg402,phy_reg409};
   assign tx_deemph = {phy_reg404,phy_reg403,phy_reg402};
   assign tx_local_preset_index = phy_reg405[5:0];
   assign tx_get_local_preset_coef = phy_reg405[6]; //This is actually bit 7 in the spec; bit 6 is reserved
   //assign tx_fs = phy_reg406;
   //assign tx_lf = phy_reg407;
   assign tx_swing = phy_reg408[3];
   assign tx_margin = phy_reg408[2:0];
   assign tx_128b_enc_byp = phy_reg800[0];
   assign tx_lfps_select  = phy_reg800[1]; // MAC Transmit LFPS
   assign NELBPosition = phy_reg801[2:0];
   assign NELBEnable = phy_reg801[3]; //This is actually bit 7 in the spec; bits 6:3 are reserved


endmodule
