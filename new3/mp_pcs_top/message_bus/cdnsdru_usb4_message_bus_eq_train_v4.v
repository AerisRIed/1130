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
//   Module Name    : cdnsdru_usb4_message_bus_eq_train_v4
//
//   Author         : Dongdong Wang
//
//   Date           : July 23, 2025
//
//   Limitations    :
//
//   Notes          : Based on cdnsdru_pcie_message_bus_eq_train_v4 authored by Thomas Faison
//---------------------------------------------------------------------------------
//   Description    :	Handle interface for IORecal function
//			Manage signals between PHY and MB registers:
//			   * Accept signal from PHY to make recal request
//			   * When recal request comes from MAC send recal signal to PHY
//			   * When PHY completes recal trigger RecalDone transmission to MAC
//
//---------------------------------------------------------------------------------

module cdnsdru_usb4_message_bus_eq_train_v4 (

input			pipe_mac2phy_clk,		// PHY: MB Clock based on PIPE interface data width --> 500MHz (32-bit) or 1GHz (16-bit)
input			pipe_mac2phy_rstn,		// PHY: MB Reset. Active Low

input			cdb_reset,			// PHY CDB: Soft Reset for entire MB block including all sub-blocks
input			cdb_ctrl_reset,		        // PHY CDB: Soft Reset for entire MB Controller

input			rx_eq_training_cmpl_stb,  	// PHY: EQ trainig done indication (to MB)
input			prio_tx_writes_done_eqt,  	// MAC Write is complete

output reg 		rx_eq_training_cmpl_tx_write	// Gen reg ctrl: Trigger to send recal_done (towards MAC)

);
/*
 Algorithm for this block:
 -- Get req from PHY/Create trigger (using rx_eq_training_cmpl_stb)
 -- Assert rx_eq_training_cmpl_tx_write
 -- When write made, deassert rx_eq_training_cmpl_tx_write
*/

//--------------------------------------------------------------------
// Local variables
//--------------------------------------------------------------------


   wire ctrl_soft_reset;


//--------------------------------------------------------------------
// Resets
//--------------------------------------------------------------------

   assign ctrl_soft_reset = (cdb_reset | cdb_ctrl_reset);

//--------------------------------------------------------------------
// Update state machine state
//
// Generate trigger for PHY-to-MAC Recal request from the rising edge
// of the recal-request register bit (written by the MAC to the PHY)
//--------------------------------------------------------------------

   always @(posedge pipe_mac2phy_clk or negedge pipe_mac2phy_rstn)
     begin
	if (~pipe_mac2phy_rstn)
	  begin
	     rx_eq_training_cmpl_tx_write <= 1'b0;
	  end
	else if (ctrl_soft_reset)
	  begin
	     rx_eq_training_cmpl_tx_write <= 1'b0;
	  end
	else
	  begin
	     if (rx_eq_training_cmpl_stb) rx_eq_training_cmpl_tx_write <= 1'b1;
	     else if (prio_tx_writes_done_eqt) rx_eq_training_cmpl_tx_write <= 1'b0;
	     else rx_eq_training_cmpl_tx_write <= rx_eq_training_cmpl_tx_write;
	  end
     end


endmodule

