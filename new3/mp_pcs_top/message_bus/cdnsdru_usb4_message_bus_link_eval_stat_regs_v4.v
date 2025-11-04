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
//   Module Name    : cdnsdru_usb4_message_bus_link_eval_stat_regs_v4
//
//   Author         : Dongdong Wang
//
//   Date           : July 23, 2025
//
//   Limitations    :
//
//   Notes          : Based on cdnsdru_pcie_message_bus_link_eval_stat_regs_v4 authored by Thomas Faison
//---------------------------------------------------------------------------------
//   Description    :	RX Link Eval Status Reg Controller Module
//			The purpose of this module is to co-ordinate between the
//			PIPE Tx, PIPE Rx and PMA Tx/Rx modules to handle RX
//			Link Eval Status requests and writes to MAC.
//
//---------------------------------------------------------------------------------

module cdnsdru_usb4_message_bus_link_eval_stat_regs_v4 (

input			pipe_mac2phy_clk,		// PHY: MB Clock based on PIPE interface data width --> 500MHz (32-bit) or 1GHz (16-bit)
input			pipe_mac2phy_rstn,		// PHY: MB Reset. Active Low

input			cdb_reset,			// PHY CDB: Soft Reset for entire MB block including all sub-blocks
input			cdb_ctrl_reset,		        // PHY CDB: Soft Reset for entire MB Controller

input [11:0]		rx_link_eval_fb_dir_change_g67_reg,	// PMA: Feedback dir change info
input [5:0]		rx_link_eval_fb_dir_change_legacy_reg,	// PMA: Feedback dir change info
input [7:0]		rx_link_eval_fb_fom_reg,	        // PMA: Feedback Figure Of Merit
input [2:0]		prio_tx_writes_done_le,		// MB Tx Controller: Command Write done
input			rx_eq_eval_sel,	       	        // PHY: Select if we're updating  (0 = dir change and 1 = FoM)
input			rx_eq_eval,       	        // MB Reg Controller: Register bit from PHY RX Control3
input			phy_status,       	        // PCS: Indicates that PHY is ready to send info
input [3:0]		pipe_rate_mac2phy_sync,  	// Pipe rate indication

output reg 		eval_legacy_tx_write,	        // MB Reg Controller: TX Write request for eqeval
output reg 		eval_g67_tx_write,	        // MB Reg Controller: TX Write request for eqeval
output reg 		fom_tx_write,		        // MB Reg Controller: TX Write request for FOM
output reg  [7:0] 	rx_link_eval_status0,	        // MB Reg Controller: Status register value to be written to MAC
output reg  [7:0] 	rx_link_eval_status1,	        // MB Reg Controller: Status register value to be written to MAC
output reg  [7:0] 	rx_link_eval_status2,	        // MB Reg Controller: Status register value to be written to MAC
output reg  [7:0] 	rx_link_eval_status3	        // MB Reg Controller: Status register value to be written to MAC

);

//--------------------------------------------------------------------
// FSM Parameters
//--------------------------------------------------------------------

   localparam EVAL_IDLE		= 2'b00;
   localparam EVAL_WAIT_FOR_PS	= 2'b01;
   localparam EVAL_WRITE_START	= 2'b10;
   localparam EVAL_WRITE_WAIT	= 2'b11;

//--------------------------------------------------------------------
// Local Variables
//--------------------------------------------------------------------

   reg [1:0] eval_state;
   reg [1:0] eval_next_state;
   reg 	     phy_status_d1;
   reg 	     rx_eq_eval_d1;

   wire      rx_eq_eval_status;
   wire      phy_status_rise;
   wire      rx_eq_eval_rise;

//FIXME: generate write for stat regs 2/3

//--------------------------------------------------------------------
// This block will be reset when any one of the followign conditions
// are true
// 1. MB Disabled (PHY is not in Gen4 P0 state)
// 2. MB soft reset (Software)
// 3. MB Block level soft reset (Software)
//--------------------------------------------------------------------

   assign ctrl_soft_reset = (cdb_reset | cdb_ctrl_reset);

//--------------------------------------------------------------------
// Detect rising edge of rx_eq_eval
//--------------------------------------------------------------------

   always @(posedge pipe_mac2phy_clk or negedge pipe_mac2phy_rstn)
     begin
	if (~pipe_mac2phy_rstn)
	  begin
	     phy_status_d1 <= 1'b0;
	     rx_eq_eval_d1 <= 1'b0;
	  end
	else
	  begin
	     phy_status_d1 <= phy_status;
	     rx_eq_eval_d1 <= rx_eq_eval;
	  end
     end
   assign phy_status_rise = phy_status & ~phy_status_d1;
   assign rx_eq_eval_status = phy_status_rise & rx_eq_eval;
   assign rx_eq_eval_rise = ~rx_eq_eval_d1 & rx_eq_eval;

//--------------------------------------------------------------------
// Detect request for status and generate eval. rx_eq_eval_tx_write is level-sensitive
// so the state machine will --> idle if rx_eq_eval --> 0.
//--------------------------------------------------------------------

   always @(posedge pipe_mac2phy_clk or negedge pipe_mac2phy_rstn)
     begin
	if (~pipe_mac2phy_rstn)
	  eval_state <= 2'b00;
   	else if (ctrl_soft_reset)
	  eval_state <= 2'b00;
	else
	  eval_state <= eval_next_state;
     end

   always @*
     begin
	eval_next_state = 2'b00;

	case (eval_state)

	  // Start EVAL cycle based on eval bit being written
	  EVAL_IDLE:
	    begin
	       eval_g67_tx_write = 1'b0;
	       eval_legacy_tx_write = 1'b0;
	       fom_tx_write = 1'b0;
	       if (rx_eq_eval_status)
		 eval_next_state = EVAL_WRITE_START;
	       else if (rx_eq_eval_rise)
		 eval_next_state = EVAL_WAIT_FOR_PS;
	       else
		 eval_next_state = EVAL_IDLE;
	    end

	  // Wait for phy_status or an abort (rx_eq_eval == 0)
	  EVAL_WAIT_FOR_PS:
	    begin
	       eval_g67_tx_write = 1'b0;
	       eval_legacy_tx_write = 1'b0;
	       fom_tx_write = 1'b0;
	       if (phy_status_rise)
		 eval_next_state = EVAL_WRITE_START;
	       else
		 eval_next_state = EVAL_WAIT_FOR_PS;
	    end

	  // Assert eval if_tx_write request is still valid AND (rx_eq_eval_sel == 0).
	  // Assert fom_tx_write if request is still valid AND (rx_eq_eval_sel == 1).
	  EVAL_WRITE_START:
	    begin
	       if (rx_eq_eval_sel)
		 begin
		    eval_g67_tx_write = 1'b0;
		    eval_legacy_tx_write = 1'b0;
		    fom_tx_write = 1'b1;
		 end
	       else
		 begin
		    if (pipe_rate_mac2phy_sync == 4'b0101)
		      begin
			 eval_g67_tx_write = 1'b1;
			 eval_legacy_tx_write = 1'b0;
		      end
		    else
		      begin
			 eval_g67_tx_write = 1'b0;
			 eval_legacy_tx_write = 1'b1;
		      end

		    fom_tx_write = 1'b0;
		 end
	       eval_next_state = EVAL_WRITE_WAIT;
	    end

	  // Keep write high until main reg FSM has finished sending.
	  EVAL_WRITE_WAIT:
	    begin
	       if (|prio_tx_writes_done_le)
		 begin
		    eval_g67_tx_write = 1'b0;
		    eval_legacy_tx_write = 1'b0;
		    fom_tx_write = 1'b0;
		    eval_next_state = EVAL_IDLE;
		 end
	       else
		 begin
		    if (rx_eq_eval_sel)
		      begin
			 eval_g67_tx_write = 1'b0;
			 eval_legacy_tx_write = 1'b0;
			 fom_tx_write = 1'b1;
		      end
		    else
		      begin
			 if (pipe_rate_mac2phy_sync == 4'b0101)
			   begin
			      eval_g67_tx_write = 1'b1;
			      eval_legacy_tx_write = 1'b0;
			   end
			 else
			   begin
			      eval_g67_tx_write = 1'b0;
			      eval_legacy_tx_write = 1'b1;
			   end
			 fom_tx_write = 1'b0;
		      end
		    eval_next_state = EVAL_WRITE_WAIT;
		 end
	    end     

	  default:
	    begin
	       eval_g67_tx_write = 1'b0;
	       eval_legacy_tx_write = 1'b0;
	       fom_tx_write = 1'b0;
	       eval_next_state = EVAL_IDLE;
	    end
	endcase
     end


//--------------------------------------------------------------------
// Prepare status fields for register
//--------------------------------------------------------------------

   always @(posedge pipe_mac2phy_clk or negedge pipe_mac2phy_rstn)
     begin
	if (~pipe_mac2phy_rstn)
	  begin
	     rx_link_eval_status3 <= 8'h00;
	     rx_link_eval_status2 <= 8'h00;
	     rx_link_eval_status1 <= 8'h00;
	     rx_link_eval_status0 <= 8'h00;
	  end
   	else if (ctrl_soft_reset)
	  begin
	     rx_link_eval_status3 <= 8'h00;
	     rx_link_eval_status2 <= 8'h00;
	     rx_link_eval_status1 <= 8'h00;
	     rx_link_eval_status0 <= 8'h00;
	  end
	else
	  begin
	     if (rx_eq_eval_status)
	       begin
		  //FIXME what is value of reg if corresponding rate not selected?
		  rx_link_eval_status3 <= {1'b0,rx_link_eval_fb_dir_change_g67_reg[11:9],1'b0,rx_link_eval_fb_dir_change_g67_reg[8:6]};
		  rx_link_eval_status2 <= {1'b0,rx_link_eval_fb_dir_change_g67_reg[5:3],1'b0,rx_link_eval_fb_dir_change_g67_reg[2:0]};
		  rx_link_eval_status1 <= {2'b00,rx_link_eval_fb_dir_change_legacy_reg};
		  rx_link_eval_status0 <= rx_link_eval_fb_fom_reg;
	       end
	  end
     end

endmodule

