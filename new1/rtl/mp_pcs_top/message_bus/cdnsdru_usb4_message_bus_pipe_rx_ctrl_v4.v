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
//   Module Name    : cdnsdru_lm_pipe_rx_ctrl_v4
//
//   Author         : Dongdong Wang
//
//   Date           : July 23, 2025
//
//   Limitations    :
//
//   Notes          : Based on cdnsdru_pcie_message_bus_pipe_rx_ctrl_v4 authored by Thomas Faison
//---------------------------------------------------------------------------------
//   Description    :	PIPE Interface Receive Logic Module
//			The purpose of this module is to decoded the incoming 
//			commands from the MAC via the PIPE interface's lane
//			margining receive bus and present the details to the lane
//			margining controller where the PHY registers are updated.
//			This module supports the following commands 
// 			*********************************************************
// 			Commands			Type		Support
// 			*********************************************************
// 			NOP			Request			Yes
// 			write_uncommitted	Request			Yes
// 			write_committed		Request			Yes
// 			read			Request			Yes
// 			read_completion		Acknowledgement		N/A
// 			write_ack		Acknowledgement		Yes
// 			All others		Reserved		Yes
// 			*********************************************************
//---------------------------------------------------------------------------------

module cdnsdru_usb4_message_bus_pipe_rx_ctrl_v4 (

input			pipe_mac2phy_clk,	// PHY: MB Clock based on PIPE interface data width --> 500MHz (32-bit) or 1GHz (16-bit)
input			pipe_mac2phy_rstn,	// PHY: MB Reset. Active Low
input			mb_enable,		// PHY: MB Enable when PCIe Gen4 and P0 state

input			mb_cdb_reset,		// PHY CDB: Soft Reset for entire MB block including all sub-blocks
input			mb_cdb_rx_reset,	// PHY CDB: Soft Reset for PIPE interface receive logic 

input		[7:0]	mb_pipe_rx_data,	// PHY: PIPE Lane Margining Receive data bus

output	reg		mb_rx_cmd_complete,	// MB Controller: MB command received successfully (independent of validity)
output 	reg	[3:0]	mb_rx_command,		// MB Controller: MB received command
output	reg	[7:0]	mb_rx_data,		// MB Controller: MB received data
output	reg	[11:0]	mb_rx_address		// MB Controller: MB received command address

);

//--------------------------------------------------------------------
// FSM Parameters
//--------------------------------------------------------------------

   localparam MB_RX_IDLE	= 2'b00;
   localparam MB_RX_CYCLE2	= 2'b01;
   localparam MB_RX_CYCLE3	= 2'b10;
   localparam MB_RX_COMPLETE	= 2'b11;
   
//--------------------------------------------------------------------
// Local Variables
//--------------------------------------------------------------------

   wire       bus_active;
   wire       rx_start;
   wire       rx_store_addr_en;
   wire       rx_store_data_en;
   wire       rx_one_cycle_cmd;
   wire       rx_two_cycle_cmd;
   wire       rx_soft_reset;
   
   reg 	      rx_cmd;
   reg 	      rx_addr;
   reg 	      rx_data;
   reg 	      rx_finish;
   reg 	      rx_store_addr;
   reg 	      rx_store_data;
   reg [1:0]  mb_rx_state;
   reg [1:0]  mb_rx_next_state;
   reg [7:0]  mb_pipe_rx_data_reg1;
   reg [7:0]  mb_pipe_rx_data_reg2;

//--------------------------------------------------------------------
// This block will be reset when any one of the followign conditions
// are true
// 1. MB Disabled (PHY is not in Gen4 P0 state)
// 2. MB soft reset (Software)
// 3. MB Block level soft reset (Software)
//--------------------------------------------------------------------

assign rx_soft_reset = (~mb_enable | mb_cdb_reset | mb_cdb_rx_reset);


//--------------------------------------------------------------------
// Register the incoming PIPE data bus
// -- to take care of timing closure concerns at 1GHz 
//    (Gen4 16-bit mode)
// -- to detect the bus transition which indicates the a new
//    transfer has started
// The below process block also registers the rx_finish
//--------------------------------------------------------------------

always @(posedge pipe_mac2phy_clk or negedge pipe_mac2phy_rstn)
begin
	if (~pipe_mac2phy_rstn)
	begin
		mb_pipe_rx_data_reg1 <= 8'h00;
		mb_pipe_rx_data_reg2 <= 8'h00;
	end
	else if (rx_soft_reset)
	begin
		mb_pipe_rx_data_reg1 <= 8'h00;
		mb_pipe_rx_data_reg2 <= 8'h00;
	end
	else 
	begin
		mb_pipe_rx_data_reg1 <= mb_pipe_rx_data;
		mb_pipe_rx_data_reg2 <= mb_pipe_rx_data_reg1;
	end
end

//--------------------------------------------------------------------
// As per PIPE Spec, the bus transition (from zero to non-zero) shall
// be considred as starting of a new command from MAC. The incoming
// PIPE rx data is registered twice to detect the change in value.
// In order to take care of timing closure concerns, *_reg1 is used
// for processing in this block.
//--------------------------------------------------------------------

assign bus_active = (((mb_rx_state == MB_RX_IDLE) && (mb_pipe_rx_data_reg2 == 8'h00) && (mb_pipe_rx_data_reg1 != 8'h00)) ||
		     ((mb_rx_state == MB_RX_COMPLETE) && (mb_pipe_rx_data_reg1 != 8'h00))
		    );

//--------------------------------------------------------------------
// Supported commands. In future, if more commands needs to be added,
// then below statement needs to be updated for new commands. The 
// command validity is checked when the command is recived. If the 
// command is valid and bus_active is asserted (meaning, a new command
// received), then rx_start shall be asserted to move teh FSM. Other
// wise FSM will remain in the IDLE state when it receives NOP or
// Reserved commands. 
//--------------------------------------------------------------------

assign rx_start = ((bus_active == 1'b1) && 
			((mb_pipe_rx_data_reg1[7:4] == `MB_WRITE_UNCOMMITTED	) || 
			 (mb_pipe_rx_data_reg1[7:4] == `MB_WRITE_COMMITTED	) || 
			 (mb_pipe_rx_data_reg1[7:4] == `MB_READ			) ||
			 (mb_pipe_rx_data_reg1[7:4] == `MB_READ_COMPLETION	) ||
			 (mb_pipe_rx_data_reg1[7:4] == `MB_WRITE_ACK		)  	  
			)
		   );

//--------------------------------------------------------------------
// Flops to determinte 1/2/3 cycle commands
//--------------------------------------------------------------------
// rx_store_addr_en	rx_store_data_en		Command
//--------------------------------------------------------------------
//	0			0		Write Ack/NOP/No Command
//	0			1		Read Completion
// 	1			0		Read
//	1			1		Write Committed/Uncommitted
//--------------------------------------------------------------------

assign rx_store_addr_en = ((bus_active == 1'b1) && 
			((mb_pipe_rx_data_reg1[7:4] == `MB_WRITE_UNCOMMITTED	) || 
			 (mb_pipe_rx_data_reg1[7:4] == `MB_WRITE_COMMITTED	) || 
			 (mb_pipe_rx_data_reg1[7:4] == `MB_READ			)
			)
		       );

assign rx_store_data_en = ((bus_active == 1'b1) && 
			((mb_pipe_rx_data_reg1[7:4] == `MB_WRITE_UNCOMMITTED	) || 
			 (mb_pipe_rx_data_reg1[7:4] == `MB_WRITE_COMMITTED	) || 
			 (mb_pipe_rx_data_reg1[7:4] == `MB_READ_COMPLETION	)
			)
		       );

//--------------------------------------------------------------------
// Process to store the variables to indicate store address and/or data
//--------------------------------------------------------------------

always @(posedge pipe_mac2phy_clk or negedge pipe_mac2phy_rstn)
begin
	if (~pipe_mac2phy_rstn)
	begin
		rx_store_addr <= 1'b0;
		rx_store_data <= 1'b0;
	end
	else if (rx_soft_reset | rx_finish)
	begin
		rx_store_addr <= 1'b0;
		rx_store_data <= 1'b0;
	end
	else 
	begin
		if (rx_store_addr_en)
			rx_store_addr <= 1'b1;
		if (rx_store_data_en)
			rx_store_data <= 1'b1;
	end
end

//--------------------------------------------------------------------
// It is evident that both rx_store_addr_en and rx_store_data_en will be
// asserted only for write commands. In all other cases, these signal
// assertion will be mutually exclusive. Based on the assertion of 
// these signals, 1/2/3 cycle commands shall be determined
//--------------------------------------------------------------------
// rx_store_addr	rx_store_data		Command Type
//--------------------------------------------------------------------
//	0			0		One Cycle (Command)
//	0			1		Two Cycle (Command/Data)
// 	1			0		Two Cycle (Command/Address)
//	1			1		Three Cycle (Command/Data/Address)
//--------------------------------------------------------------------
// These information shall be used in the FSM to take appropriate
// flow to receive the commands.
//--------------------------------------------------------------------

assign rx_one_cycle_cmd = (~rx_store_addr_en & ~rx_store_data_en);
assign rx_two_cycle_cmd = (rx_store_addr ^ rx_store_data);

//--------------------------------------------------------------------
// Flops to store the command, address and data for MB controller
// All the stored values are cleared whenever there is no new 
// command from MAC while mb_rx_cmd_complete is asserted.
//--------------------------------------------------------------------

always @(posedge pipe_mac2phy_clk or negedge pipe_mac2phy_rstn)
begin
	if (~pipe_mac2phy_rstn)
	begin
		mb_rx_cmd_complete	<= 1'b0;
		mb_rx_command 		<= 4'd0;
		mb_rx_address 		<= 12'd0;
		mb_rx_data 		<= 8'd0;
	end
	else if (rx_soft_reset | (mb_rx_cmd_complete & ~bus_active))
	begin
		mb_rx_cmd_complete	<= 1'b0;
		mb_rx_command 		<= 4'd0;
		mb_rx_address 		<= 12'd0;
		mb_rx_data 		<= 8'd0;
	end
	else
	begin
		mb_rx_cmd_complete	<= rx_finish;
		if (rx_cmd)
			mb_rx_command 	<= mb_pipe_rx_data_reg1[7:4];
		if (rx_addr)
			mb_rx_address 	<= {mb_pipe_rx_data_reg2[3:0],mb_pipe_rx_data_reg1};
		if (rx_data)
			mb_rx_data 	<= mb_pipe_rx_data_reg1;
	end
end

//--------------------------------------------------------------------
// MB Receive FSM State change register
//--------------------------------------------------------------------

always @(posedge pipe_mac2phy_clk or negedge pipe_mac2phy_rstn)
begin
	if (~pipe_mac2phy_rstn)
		mb_rx_state <= MB_RX_IDLE;
	else if (rx_soft_reset)
		mb_rx_state <= MB_RX_IDLE;
	else 
		mb_rx_state <= mb_rx_next_state;
end

//--------------------------------------------------------------------
// Finite State Machine 
//--------------------------------------------------------------------

always @*
begin

rx_cmd		= 1'b0;
rx_addr		= 1'b0;
rx_data		= 1'b0;
rx_finish	= 1'b0;

	case(mb_rx_state)

	MB_RX_IDLE:
	begin
		// Bus active and Valid command received
		if (rx_start)
		begin
			// Store the command
			rx_cmd = 1'b1;
			// One Cycle Command received
			if (rx_one_cycle_cmd)
			begin
				rx_finish = 1'b1;
				mb_rx_next_state = MB_RX_COMPLETE;
			end
			// Two or Three Cycle Command received
			else
				mb_rx_next_state = MB_RX_CYCLE2;
		end
		else
		begin
			mb_rx_next_state = MB_RX_IDLE;
		end
	end	

	MB_RX_CYCLE2:
	begin
		// Two Cycle Command received ie., depending on the command either rx_store_addr or rx_store_data
		// is asserted.
		if (rx_two_cycle_cmd)
		begin
			rx_addr = rx_store_addr;
			rx_data = rx_store_data;
			rx_finish = 1'b1;
			mb_rx_next_state = MB_RX_COMPLETE;
		end
		// Three Cycle Command received ie., both rx_store_addr and rx_store_data are asserted.
		else
		begin
			rx_addr = rx_store_addr;
			mb_rx_next_state = MB_RX_CYCLE3;
		end
	end	

	MB_RX_CYCLE3:
	begin
		rx_data = rx_store_data;
		rx_finish = 1'b1;
		mb_rx_next_state = MB_RX_COMPLETE;
	end	

	MB_RX_COMPLETE:
	begin
		// Bus active and Valid command received
		if (rx_start)
		begin
			// Store the command
			rx_cmd = 1'b1;
			// One Cycle Command received
			if (rx_one_cycle_cmd)
			begin
				rx_finish = 1'b1;
				mb_rx_next_state = MB_RX_COMPLETE;
			end
			// Two or Three Cycle Command received
			else
				mb_rx_next_state = MB_RX_CYCLE2;
		end
		else
			mb_rx_next_state = MB_RX_IDLE;
	end	

	default: mb_rx_next_state = MB_RX_IDLE;

	endcase
end


endmodule

