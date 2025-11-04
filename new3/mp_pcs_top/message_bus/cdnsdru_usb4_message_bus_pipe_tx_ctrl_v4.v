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
//   Module Name    : cdnsdru_mb_pipe_tx_ctrl_v4
//
//   Author         : Dongdong Wang
//
//   Date           : July 23, 2025
//
//   Limitations    :
//
//   Notes          : Based on cdnsdru_pcie_message_bus_pipe_tx_ctrl_v4 authored by Thomas Faison
//---------------------------------------------------------------------------------
//   Description    :	PIPE Interface Transmit Logic Module
//			The purpose of this module is to decoded the incoming 
//			information from the internal MB Controller and translate
//			that into the MB commands in the PIPE interface.
//			This module supports the following commands 
// 			*********************************************************
// 			Commands			Type		Support
// 			*********************************************************
// 			NOP			Request			Yes
// 			write_uncommitted	Request			Yes
// 			write_committed		Request			Yes
// 			read			Request			No
// 			read_completion		Acknowledgement		Yes
// 			write_ack		Acknowledgement		Yes
// 			All others		Reserved		Yes
// 			*********************************************************
//---------------------------------------------------------------------------------

module cdnsdru_usb4_message_bus_pipe_tx_ctrl_v4 (

input			pipe_phy2mac_clk,	// PHY: MB Clock based on PIPE interface data width --> 500MHz (32-bit) or 1GHz (16-bit)
input			pipe_phy2mac_rstn,	// PHY: MB Reset. Active Low

input			mb_cdb_reset,		// PHY CDB: Soft Reset for entire MB block including all sub-blocks
input			mb_cdb_tx_reset,	// PHY CDB: Soft Reset for PIPE interface transmit logic 

input			mb_tx_cmd_req,		// MB Controller: Command Transmission Request
input			mb_tx_ack_req,		// MB Controller: Specific ACK Transmission Request

input  [2:0] 		mb_tx_wrb_cnt,		// MB Gen controller: Transmit Uncommitted writes count
input [23:0] 		p2m_mb_tx_bus_values_r0,// MB Gen controller: Transmit data, address, command (base)
input [23:0] 		mb_tx_bus_values_r1,	// MB Gen controller: Transmit data, address, command (2nd set)
input [23:0] 		mb_tx_bus_values_r2,	// MB Gen controller: Transmit data, address, command (3rd set)
input [23:0] 		mb_tx_bus_values_r3,	// MB Gen controller: Transmit data, address, command (4th set)
input [23:0] 		mb_tx_bus_values_r4,	// MB Gen controller: Transmit data, address, command (5th set)

output	reg	[5:0]	mb_tx_cmd_done,		// MB Controller: Command Transmitted Acknowledgement

output	reg	[7:0]	mb_pipe_tx_data		// PHY: PIPE Lane Margining Transmit data bus

);

//--------------------------------------------------------------------
// FSM Parameters
//--------------------------------------------------------------------

   localparam MB_TX_IDLE	= 4'b0000;
   localparam MB_TX_CYCLE1	= 4'b0001;
   localparam MB_TX_CYCLE2	= 4'b0010;
   localparam MB_TX_CYCLE3	= 4'b0011;
   localparam MB_TX_COMPLETE	= 4'b0100;
   localparam MB_TX_CYCLE1_b	= 4'b0101;
   localparam MB_TX_CYCLE2_b	= 4'b0110;
   localparam MB_TX_CYCLE3_b	= 4'b0111;
   localparam MB_TX_CYCLE1_ACK	= 4'b1000;
   localparam MB_TX_ACK_COMPLETE = 4'b1001;

//--------------------------------------------------------------------
// Local Variables
//--------------------------------------------------------------------

   wire 	 tx_load_addr_en;
   wire 	 tx_load_data_en;
   wire 	 tx_one_cycle_cmd;
   wire 	 tx_two_cycle_cmd;
   wire 	 tx_soft_reset;

   reg 		 tx_cmd;
   reg 		 tx_addr;
   reg 		 tx_data;
   reg 		 tx_finish;
   reg 		 tx_finish_stretch_st;
   reg 		 tx_load_addr;
   reg 		 tx_load_data;
   reg [3:0] 	 mb_tx_state;
   reg [3:0] 	 mb_tx_next_state;
   reg 		 mb_tx_ack_req_rst;
   reg 		 mb_tx_ack_req_reg;

   reg  [2:0] 	 local_wrb_cnt;
   reg 		 wrb_cmd_sent;
   wire 	 wr_burst_en;
   wire [3:0] 	 mb_tx_command;
   wire 	 mb_tx_ack_req_posedge;
   reg 		 mb_tx_ack_req_d1;

//--------------------------------------------------------------------
// This block will be reset when any one of the followign conditions
// are true
// 1. MB Disabled (PHY is not in Gen4 P0 state)
// 2. MB soft reset (Software)
// 3. MB Block level soft reset (Software)
//--------------------------------------------------------------------

   assign tx_soft_reset = (mb_cdb_reset | mb_cdb_tx_reset);



//--------------------------------------------------------------------
// Flops to determinte 1/2/3 cycle commands
//--------------------------------------------------------------------
// tx_load_addr_en	tx_load_data_en		Command
//--------------------------------------------------------------------
//	0			0		Write Ack/NOP/No Command
//	0			1		Read Completion
// 	1			0		Read
//	1			1		Write Committed/Uncommitted
//--------------------------------------------------------------------

   assign mb_tx_command = p2m_mb_tx_bus_values_r0[3:0];

   assign tx_load_addr_en = ((mb_tx_cmd_req == 1'b1) && 
			    ((mb_tx_command == `MB_WRITE_UNCOMMITTED	) || 
			    (mb_tx_command == `MB_WRITE_COMMITTED	) || 
			    (mb_tx_command == `MB_READ			)));

   assign tx_load_data_en = ((mb_tx_cmd_req == 1'b1) && 
			    ((mb_tx_command == `MB_WRITE_UNCOMMITTED	) || 
			    (mb_tx_command == `MB_WRITE_COMMITTED	) || 
			    (mb_tx_command == `MB_READ_COMPLETION	)));

   assign wr_burst_en = (mb_tx_cmd_req == 1'b1) && (mb_tx_wrb_cnt > 3'h0);

//--------------------------------------------------------------------
// Process to load the variables to indicate load address and/or data
//--------------------------------------------------------------------

   always @(posedge pipe_phy2mac_clk or negedge pipe_phy2mac_rstn)
     begin
	if (~pipe_phy2mac_rstn)
	  begin
	     tx_load_addr <= 1'b0;
	     tx_load_data <= 1'b0;
	  end
	else if (tx_soft_reset | tx_finish)
	  begin
	     tx_load_addr <= 1'b0;
	     tx_load_data <= 1'b0;
	  end
	else 
	  begin
	     if (tx_load_addr_en)
	       tx_load_addr <= 1'b1;
	     if (tx_load_data_en)
	       tx_load_data <= 1'b1;
	  end
     end

//--------------------------------------------------------------------
// It is evident that both tx_load_addr_en and tx_load_data_en will be
// asserted only for write commands. In all other cases, these signal
// assertion will be mutually exclusive. Based on the assertion of 
// these signals, 1/2/3 cycle commands shall be determined
//--------------------------------------------------------------------
// tx_load_addr_en	tx_load_data_en		Command Type
//--------------------------------------------------------------------
//	0			0		One Cycle (Command)
//	0			1		Two Cycle (Command/Data)
// 	1			0		Two Cycle (Command/Address)
//	1			1		Three Cycle (Command/Data/Address)
//--------------------------------------------------------------------
// These information shall be used in the FSM to take appropriate
// flow to receive the commands.
//--------------------------------------------------------------------

   assign tx_one_cycle_cmd = (~tx_load_addr & ~tx_load_data);
   assign tx_two_cycle_cmd = (tx_load_addr ^ tx_load_data);

//--------------------------------------------------------------------
// Process to load the PIPE data bus with the required values based on the 
// command that is being requested to transmit.
//--------------------------------------------------------------------
// tx_data   tx_addr   tx_cmd	mb_pipe_tx_data[7:0]
//--------------------------------------------------------------------
//     0        0        0	 No Loading
//     0        1        1	 {mb_tx_command,mb_tx_address[11:8]}
//     0        0        1	 {mb_tx_command,4'b0}
//     0        1        0	 mb_tx_address[7:0]
//     1        x        x	 mb_tx_data[7:0]
//
//
// Mapping for TX command/data/address:
//
// mb_tx_command = p2m_mb_tx_bus_values_r0[3:0];
// mb_tx_data = p2m_mb_tx_bus_values_r0[23:16];
// mb_tx_address = p2m_mb_tx_bus_values_r0[15:4];
//--------------------------------------------------------------------



//--------------------------------------------------------------------

   always @(posedge pipe_phy2mac_clk or negedge pipe_phy2mac_rstn)
     begin
	if (~pipe_phy2mac_rstn)
	  begin
	     mb_pipe_tx_data <= 8'h00;
	  end
	else if (tx_soft_reset | tx_finish)
	  begin
	     mb_pipe_tx_data <= 8'h00;
	  end
	else 
	  begin
	     
	     // Cycle-1 
	     if (tx_cmd)
	       begin
		  if (tx_addr)
		    begin
		       case (local_wrb_cnt)
			 3'b101:
			   begin
			      mb_pipe_tx_data <= {mb_tx_bus_values_r4[3:0],mb_tx_bus_values_r4[15:12]};
			   end
			 3'b100:
			   begin
			      mb_pipe_tx_data <= {mb_tx_bus_values_r3[3:0],mb_tx_bus_values_r3[15:12]};
			   end
			 3'b011:
			   begin
			      mb_pipe_tx_data <= {mb_tx_bus_values_r2[3:0],mb_tx_bus_values_r2[15:12]};
			   end
			 3'b010:
			   begin
			      mb_pipe_tx_data <= {mb_tx_bus_values_r1[3:0],mb_tx_bus_values_r1[15:12]};
			   end
			 default:
			   begin
			      mb_pipe_tx_data <= {p2m_mb_tx_bus_values_r0[3:0],p2m_mb_tx_bus_values_r0[15:12]};
			   end
		       endcase
		    end

		  else if (mb_tx_ack_req_reg == 1'b1)
		    mb_pipe_tx_data <= 8'h50;
		  else
		    mb_pipe_tx_data <= {p2m_mb_tx_bus_values_r0[3:0],4'd0};
	       end

	     // Cycle-2
	     else if (tx_addr)
	       begin
		  case (local_wrb_cnt)
		    3'b101:
		      begin
			 mb_pipe_tx_data <= mb_tx_bus_values_r4[11:4];
		      end
		    3'b100:
		      begin
			 mb_pipe_tx_data <= mb_tx_bus_values_r3[11:4];
		      end
		    3'b011:
		      begin
			 mb_pipe_tx_data <= mb_tx_bus_values_r2[11:4];
		      end
		    3'b010:
		      begin
			 mb_pipe_tx_data <= mb_tx_bus_values_r1[11:4];
		      end
		    default:
		      begin
			 mb_pipe_tx_data <= p2m_mb_tx_bus_values_r0[11:4];
		      end
		  endcase
	       end

	     // Cycle-3
	     else if (tx_data)
	       begin
		  case (local_wrb_cnt)
		    3'b101:
		      begin
			 mb_pipe_tx_data <= mb_tx_bus_values_r4[23:16];
		      end
		    3'b100:
		      begin
			 mb_pipe_tx_data <= mb_tx_bus_values_r3[23:16];
		      end
		    3'b011:
		      begin
			 mb_pipe_tx_data <= mb_tx_bus_values_r2[23:16];
		      end
		    3'b010:
		      begin
			 mb_pipe_tx_data <= mb_tx_bus_values_r1[23:16];
		      end
		    default:
		      begin
			 mb_pipe_tx_data <= p2m_mb_tx_bus_values_r0[23:16];
		      end
		  endcase
	       end

	     else
	       mb_pipe_tx_data <= 8'h00;
	  end
     end

   // Indicators that the command is done (to let function blocks know to stop asking for service).
   // Note that this is a TOGGLE indication (value is inverted when command is done)
   always @(posedge pipe_phy2mac_clk or negedge pipe_phy2mac_rstn)
     begin
	if (~pipe_phy2mac_rstn)
	  mb_tx_cmd_done <= 6'h00;
	else if (tx_soft_reset)
	  mb_tx_cmd_done <= 6'h00;
	else 
	  begin
	     mb_tx_cmd_done[0] <= mb_tx_cmd_done[0]^(tx_finish_stretch_st & (mb_tx_command == `MB_NOP));
	     mb_tx_cmd_done[1] <= mb_tx_cmd_done[1]^(tx_finish_stretch_st & (mb_tx_command == `MB_WRITE_UNCOMMITTED));
	     mb_tx_cmd_done[2] <= mb_tx_cmd_done[2]^(tx_finish_stretch_st & (mb_tx_command == `MB_WRITE_COMMITTED));
	     mb_tx_cmd_done[3] <= mb_tx_cmd_done[3]^(tx_finish_stretch_st & (mb_tx_command == `MB_READ));
	     mb_tx_cmd_done[4] <= mb_tx_cmd_done[4]^(tx_finish_stretch_st & (mb_tx_command == `MB_READ_COMPLETION));
	     mb_tx_cmd_done[5] <= mb_tx_cmd_done[5]^(tx_finish_stretch_st & (mb_tx_command == `MB_WRITE_ACK));
	  end
     end

//--------------------------------------------------------------------
// Special quick-ack indication signal. (We don't need any extra info to create an ACK.)
//--------------------------------------------------------------------

   assign mb_tx_ack_req_posedge = (mb_tx_ack_req & ~mb_tx_ack_req_d1);

   always @(posedge pipe_phy2mac_clk or negedge pipe_phy2mac_rstn)
     begin
	if (~pipe_phy2mac_rstn)
	  mb_tx_ack_req_d1 <= 1'b0;
	else if (tx_soft_reset)
	  mb_tx_ack_req_d1 <= 1'b0;
	else
	  mb_tx_ack_req_d1 <= mb_tx_ack_req;
     end

   always @(posedge pipe_phy2mac_clk or negedge pipe_phy2mac_rstn)
     begin
	if (~pipe_phy2mac_rstn)
	  mb_tx_ack_req_reg <= 1'b0;
	else if (tx_soft_reset | mb_tx_ack_req_rst)
	  mb_tx_ack_req_reg <= 1'b0;
	else if (mb_tx_ack_req_posedge)
	  mb_tx_ack_req_reg <= 1'b1;
     end

//--------------------------------------------------------------------
// MB Transmit FSM State change register
//--------------------------------------------------------------------

   always @(posedge pipe_phy2mac_clk or negedge pipe_phy2mac_rstn)
     begin
	if (~pipe_phy2mac_rstn)
	  mb_tx_state <= MB_TX_IDLE;
	else if (tx_soft_reset)
	  mb_tx_state <= MB_TX_IDLE;
	else 
	  mb_tx_state <= mb_tx_next_state;
     end

//--------------------------------------------------------------------
// Register wr-burst count before we start a TX cycle. Decrement it
// when we send a wrb_cmd until we hit 0.
//--------------------------------------------------------------------

   always @(posedge pipe_phy2mac_clk or negedge pipe_phy2mac_rstn)
     begin
	if (~pipe_phy2mac_rstn)
	  local_wrb_cnt <= 3'h0;
	else if (tx_soft_reset)
	  local_wrb_cnt <= 3'h0;
	else if (mb_tx_state == MB_TX_IDLE)
	  local_wrb_cnt <= mb_tx_wrb_cnt;
	else if ((local_wrb_cnt > 3'h0) & (wrb_cmd_sent))
	  local_wrb_cnt <= local_wrb_cnt - 3'h1;
     end

//--------------------------------------------------------------------
// Finite State Machine 
//--------------------------------------------------------------------

   always @*
     begin

	tx_cmd		= 1'b0;
	tx_addr		= 1'b0;
	tx_data		= 1'b0;
	tx_finish	= 1'b0;
	tx_finish_stretch_st = 1'b0;
	wrb_cmd_sent	= 1'b0;
	mb_tx_ack_req_rst = 1'b0;

	case(mb_tx_state)

	  MB_TX_IDLE:
	    begin
	       // New transmit command request from MB controller
	       if (mb_tx_ack_req_reg | mb_tx_ack_req_posedge)
		 mb_tx_next_state = MB_TX_CYCLE1_ACK;
	       else if (wr_burst_en)
		 mb_tx_next_state = MB_TX_CYCLE1_b;
	       else if (mb_tx_cmd_req)
		 mb_tx_next_state = MB_TX_CYCLE1;
	       else
		 mb_tx_next_state = MB_TX_IDLE;
	    end

	  MB_TX_CYCLE1:
	    begin
	       // One Cycle Command request. No address or data. Just load the command and transmit.
	       if (tx_one_cycle_cmd)
		 begin
		    tx_cmd = 1'b1;
		    tx_finish_stretch_st = 1'b1;
		    mb_tx_next_state = MB_TX_COMPLETE;
		 end
	       // Two or Three Cycle Command request. In case of 2 or 3 cycle command, then lower nibble of
	       // the cycle1 could be address [11:8] or 4'd0. Based on tx_load_addr and tx_load_data signals
	       // tx_addr and tx_data are asserted accordingly. Refer the truth table mentioned earlier for
	       // more details.
	       else
		 begin
		    tx_cmd = 1'b1;
		    tx_addr = tx_load_addr;
		    mb_tx_next_state = MB_TX_CYCLE2;
		 end
	    end

	  MB_TX_CYCLE2:
	    begin
	       // Two Cycle Command request. Based on tx_load_addr and tx_load_data signals, tx_addr and tx_data 
	       // are asserted accordingly so that either address or data is loaded. Refer the truth table mentioned 
	       // earlier for more details.
	       if (tx_two_cycle_cmd)
		 begin
		    tx_addr = tx_load_addr;
		    tx_data = tx_load_data;
		    tx_finish_stretch_st = 1'b1;
		    mb_tx_next_state = MB_TX_COMPLETE;
		 end
	       // Three Cycle Command request ie., both tx_load_addr and tx_load_data signals are asserted. Therefore,
	       // only address needs to be loaded in cycle2.
	       else
		 begin
		    tx_addr = tx_load_addr;
		    mb_tx_next_state = MB_TX_CYCLE3;
		 end
	    end	

	  MB_TX_CYCLE3:
	    begin
	       // Cycle3 - Load the data
	       tx_data = tx_load_data;
	       tx_finish_stretch_st = 1'b1;
	       mb_tx_next_state = MB_TX_COMPLETE;
	    end	

	  MB_TX_COMPLETE:
	    begin
	       if (mb_tx_cmd_req)
		 begin
		    tx_finish = 1'b1;
		    mb_tx_next_state = MB_TX_COMPLETE;
		 end
	       else
		 begin
		    tx_finish = 1'b0;
		    mb_tx_next_state = MB_TX_IDLE;
		 end
	    end	

	  // We have simpler states when we are in a write-burst. We know we'll be sending 3 cycles.
          MB_TX_CYCLE1_b:
	    begin
	       tx_cmd = 1'b1;
	       tx_addr = 1'b1;
	       mb_tx_next_state = MB_TX_CYCLE2_b;
	    end
	  MB_TX_CYCLE2_b:
	    begin
	       tx_addr = 1'b1;
	       mb_tx_next_state = MB_TX_CYCLE3_b;
	    end	
	  MB_TX_CYCLE3_b:
	    begin
	       tx_data = 1'b1;
	       wrb_cmd_sent = 1'b1;
	       if (local_wrb_cnt != 3'h1)
		 begin
		    mb_tx_next_state = MB_TX_CYCLE1_b;
		 end
	       else
		 begin
		    tx_finish_stretch_st = 1'b1;
		    mb_tx_next_state = MB_TX_COMPLETE;
		 end
	    end	

	  // Acks are always the same so we can set one cycle to TX and move to complete
	  MB_TX_CYCLE1_ACK:
	    begin
	       tx_cmd = 1'b1;
	       mb_tx_ack_req_rst = 1'b1;
	       mb_tx_next_state = MB_TX_ACK_COMPLETE;
	    end

	  MB_TX_ACK_COMPLETE:
	    begin
	       tx_finish = 1'b0;
	       if (mb_tx_ack_req_reg | mb_tx_ack_req_posedge)
		 begin
		    mb_tx_next_state = MB_TX_ACK_COMPLETE;
		 end
	       else
		 begin
		    mb_tx_next_state = MB_TX_IDLE;
		 end
	    end	


	  default: mb_tx_next_state = MB_TX_IDLE;

	endcase
     end

endmodule
