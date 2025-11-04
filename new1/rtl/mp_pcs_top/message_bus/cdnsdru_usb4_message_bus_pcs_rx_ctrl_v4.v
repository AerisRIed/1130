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
//   Module Name    : cdnsdru_usb4_message_bus_pcs_rx_ctrl_v4
//
//   Author         : Dongdong Wang
//
//   Date           : July 23, 2025
//
//   Limitations    :
//
//   Notes          : Based on cdnsdru_pcie_message_bus_pcs_rx_ctrl_v4 authored by Thomas Faison
//---------------------------------------------------------------------------------
//   Description    :	PCS Interface Receive Logic
//			This module syncs signals coming from the PCS for use with the
//			common message bus clock.
//---------------------------------------------------------------------------------

module cdnsdru_usb4_message_bus_pcs_rx_ctrl_v4 (

 //input 		   pipe_mac2phy_clk,
 //input 		   pipe_mac2phy_rstn,
 input 		   pipe_phy2mac_clk,
 input 		   pipe_phy2mac_rstn,

 input 		   tx_coef_valid,
 input [17:0] 	   tx_preset_coef_legacy,
 input [23:0] 	   tx_preset_coef_g67,
 //input [3:0] 	   pipe_rate_mac2phy_sync,
 input 		   g67rate,

 //output 	   tx_coef_valid_mac2phy_sync,
 output [17:0] 	   tx_preset_coef_legacy_reg,
 output reg [23:0] tx_preset_coef_g67_reg

);

   reg 		    tx_coef_valid_reg;
   //wire 	    tx_coef_valid_2cy;

   //assign tx_coef_valid_2cy = tx_coef_valid | tx_coef_valid_reg;
   assign tx_preset_coef_legacy_reg = tx_preset_coef_g67_reg[17:0];

//--------------------------------------------------------------------
// Capture the preset coef bus whenever the valid occurs.
// Synchronize the valid to the mac2phy clock.
//--------------------------------------------------------------------

   always @(posedge pipe_phy2mac_clk or negedge pipe_phy2mac_rstn)
     begin
	if (~pipe_phy2mac_rstn)
	  begin
	     tx_preset_coef_g67_reg <= 24'h000000;
	     tx_coef_valid_reg <= 1'b0;
	  end
	else
	  begin
	     tx_coef_valid_reg <= tx_coef_valid;
	     if (tx_coef_valid == 1'b1)
	       begin
		  if (g67rate) tx_preset_coef_g67_reg <= tx_preset_coef_g67;
		  else tx_preset_coef_g67_reg <= {6'h00,tx_preset_coef_legacy};
	       end
	     else
	       begin
		  tx_preset_coef_g67_reg <= tx_preset_coef_g67_reg;
	       end
	  end
     end

   //phy_tpsync u_coef_valid_sync (
   //  .a_clk      (pipe_phy2mac_clk),
   //  .a_rst_n    (pipe_phy2mac_rstn),
   //  .b_clk      (pipe_mac2phy_clk),
   //  .b_rst_n    (pipe_mac2phy_rstn),
   //  .data_i     (tx_coef_valid_2cy),
   //  .data_o     (tx_coef_valid_mac2phy_sync)
   //  );

endmodule
