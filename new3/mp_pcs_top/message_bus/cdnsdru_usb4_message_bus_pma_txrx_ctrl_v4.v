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
//   Module Name    : cdnsdru_lm_pma_txrx_ctrl_v4
//
//   Author         : Dongdong Wang
//
//   Date           : July 23, 2025
//
//   Limitations    :
//
//   Notes          : Based on cdnsdru_pcie_message_bus_pma_txrx_ctrl_v4 authored by Thomas Faison
//---------------------------------------------------------------------------------
//   Description    :	PMA Interface Transmit/Receive Logic Module
//			The purpose of this module is to accept the request from 
//			the LM controller and issue Rx margining request to the
//			PMA via PMA's Rx margining interface.
//---------------------------------------------------------------------------------

module cdnsdru_usb4_message_bus_pma_txrx_ctrl_v4 (

input			pipe_mac2phy_clk,	// PHY: LM Clock based on PIPE interface data width --> 500MHz (32-bit) or 1GHz (16-bit)
input			pipe_mac2phy_rstn,	// PHY: LM Reset. Active Low
input			mb_enable,		// PHY: LM Enable when PCIe Gen4 and P0 state

input			mb_cdb_reset,		// PHY CDB: Soft Reset for entire LM block including all sub-blocks
input			mb_cdb_pma_reset,	// PHY CDB: Soft Reset for PMA interface transmit/receive logic 
input		[3:0]	lm_cdb_pma_wait,	// PHY CDB: Programmable wait time between PMA offset and request
input		[7:0]	lm_cdb_pma_direction,	// PHY CDB: Programmable PMA Rx margining direction

input			lm_dep, 		// LM Controller: Request to initiate PMA Rx margining
input			lm_pma_req,		// LM Controller: Request to initiate PMA Rx margining
input		[1:0]	lm_pma_direction,	// LM Controller: Direction (East/West/North/South) for PMA Rx margining
input		[6:0]	lm_pma_offset,		// LM Controller: Offset for PMA Rx margining
output	reg		lm_pma_ack,		// LM Controller: PMA Rx margining completed acknowledgment
output	reg	[5:0]	lm_pma_errcnt,		// LM Controller: PMA Rx margining error count

input			rx_signal_detect,	// PMA: Receiver Signal Detect
input			rx_mrgn_valid,		// PMA: Rx margin valid indicating that PMA finished current rx margining
input		[5:0]	rx_mrgn_errcnt,		// PMA: Rx margin error count for the current rx margining iteration
output	reg		rx_mrgn_req,		// PMA: Request to initiate PMA Rx margining
output	reg	[1:0]	rx_mrgn_dir,		// PMA: Direction (East/West/North/South) for PMA Rx margining
output	reg	[6:0]	rx_mrgn_offset		// PMA: Offset for PMA Rx margining

);

//--------------------------------------------------------------------
// FSM Parameters
//--------------------------------------------------------------------

   localparam RX_MRGN_IDLE	= 3'b000;
   localparam RX_MRGN_WAIT	= 3'b001;
   localparam RX_MRGN_REQUEST	= 3'b010;
   localparam RX_MRGN_VALID	= 3'b011;
   localparam RX_MRGN_ACK	= 3'b100;

//--------------------------------------------------------------------
// Local Variables
//--------------------------------------------------------------------

   wire 	pma_soft_reset;
   wire 	wait_cnt_reached;

   reg		load_mrgn_attributes;
   reg 		wait_cnt_en;
   reg 		wait_cnt_rst;
   reg 		rx_mrgn_req_int;
   reg 		lm_pma_ack_int;
   reg 		load_lm_errcnt;
   reg [2:0] 	lm_pma_state;
   reg [2:0] 	lm_pma_next_state;
   reg [3:0] 	wait_cnt;

//--------------------------------------------------------------------
// Flops to register the final outputs lm_pma_ack and rx_mrgn_req
//--------------------------------------------------------------------

always @(posedge pipe_mac2phy_clk or negedge pipe_mac2phy_rstn)
begin
	if (~pipe_mac2phy_rstn)
	begin
		lm_pma_ack 	<= 1'b0;
		rx_mrgn_req 	<= 1'b0;
	end
	else if (pma_soft_reset)
	begin
		lm_pma_ack 	<= 1'b0;
		rx_mrgn_req 	<= 1'b0;
	end
	else
	begin
		lm_pma_ack 	<= lm_pma_ack_int;
		rx_mrgn_req 	<= rx_mrgn_req_int;
	end
end

//--------------------------------------------------------------------
// Flops to load the final outputs of lm_pma_errcnt. Error count coming
// from PMA can be directly loaded into lm_ma_errcnt as it will be 
// stable until the rx_mrgn_req and rx_mrgn_valid are asserted together.
// load_lm_errcnt is asserted on the first cycle of rx_mrgn_req and
// rx_mrgn_valid are asserted. During this cycle value of error
// count will be stable as the de-assertion of rx_mrgn_req going to PMA
// will take few cycles before which rx_mrgn_valid will be de-asserted.
//--------------------------------------------------------------------

always @(posedge pipe_mac2phy_clk or negedge pipe_mac2phy_rstn)
begin
	if (~pipe_mac2phy_rstn)
		lm_pma_errcnt <= 6'd0;
	else if (pma_soft_reset)
		lm_pma_errcnt <= 6'd0;
	else if (load_lm_errcnt)
		lm_pma_errcnt <= rx_mrgn_errcnt;
end

//--------------------------------------------------------------------
// Flops to load the final outputs of rx_mrgn_offset/direction
//--------------------------------------------------------------------
// Process to determine the PMA Rx margining direction from the LM
// Controller. As per PIPE Spec, margining direction is 2-bit wide
// and is provided via Margin Direction [2:1] in PHY address 12'h000.
// But PIPE spec did not defined the description in bits [2:1] on how 
// to decode them ie., Time Vs Voltage margining and North/South/East/
// West direction. In addition, PMA has its own definition for the
// margining direction. Therefore in order to connect all these 
// together, programmable direction register is implemented in PHY
// CDB. The margining direction from the PIPE interface is converted
// to PMA margining direction via 2 step process as described below
// 1. Compare the programmable direction with the Margin Direction [2:1]
//    in PHY address space 12'h000 and understand the actual direction
//    information for each direction
// 2. Now map the understood margining direction into PMA specific
//    margining direction
// PCIe base specification mentions that 0 means East/North (Right/Up)
// and 1 means West/South (Left/Down). But out of the 2-bits in PIPE
// spec, it does not mention which bit could be the direction and which
// bit could be the time/voltage margining. To overcome this situation,
// the programmable register lm_cdb_pma_direction [7:0] has 2-bits for 
// each direction ie., 
// lm_cdb_pma_direction[1:0] --> East/Right (Time)
// lm_cdb_pma_direction[3:2] --> West/Left  (Time)
// lm_cdb_pma_direction[5:4] --> North/Up   (Voltage)
// lm_cdb_pma_direction[7:6] --> South/Down (Voltage)
// With the above understanding, the logic will compare the incoming
// 2-bits of margin direction with the programmable register (for all
// 2-bit sets) and indentify the actual information being conveyed. If
// the encoding is changed in PIPE spec later, then one has to simply
// map the PIPE spec encoding into the programmable register so that 
// the logic will be unchanged. 
// PMA encodings are
// 2'b00 --> North/Up (Voltage)
// 2'b01 --> East/Right (Time)
// 2'b10 --> South/Down (Voltage)
// 2'b11 --> West/Left (Time)
//--------------------------------------------------------------------

always @(posedge pipe_mac2phy_clk or negedge pipe_mac2phy_rstn)
begin
	if (~pipe_mac2phy_rstn)
	begin
		rx_mrgn_offset		<= 7'd0;
		rx_mrgn_dir	 	<= 2'd0;
	end
	else if (pma_soft_reset)
	begin
		rx_mrgn_offset 		<= 7'd0;
		rx_mrgn_dir	 	<= 2'd0;
	end
	else if (load_mrgn_attributes)
	begin
		rx_mrgn_offset 		<= lm_pma_offset;
		// Mapping East Direction for PMA
		if (lm_pma_direction == lm_cdb_pma_direction[1:0])
			rx_mrgn_dir <= `PMA_MRGN_DIR_EAST;
		// Mapping WEST Direction for PMA
		else if (lm_pma_direction == lm_cdb_pma_direction[3:2])
			rx_mrgn_dir <= `PMA_MRGN_DIR_WEST;
		// Mapping NORTH Direction for PMA
		else if (lm_pma_direction == lm_cdb_pma_direction[5:4])
			rx_mrgn_dir <= `PMA_MRGN_DIR_NORTH;
		// Mapping SOUTH Direction for PMA
		else if (lm_pma_direction == lm_cdb_pma_direction[7:6])
			rx_mrgn_dir <= `PMA_MRGN_DIR_SOUTH;
	end
end

//--------------------------------------------------------------------
// This block will be reset when any one of the followign conditions
// are true
// 1. LM Disabled (PHY is not in Gen4 P0 state)
// 2. LM soft reset (Software)
// 3. LM Block level soft reset (Software)
// 4. PMA loses the Gen4 siganling ie., rx_signal_detect = 1'b0
//--------------------------------------------------------------------

assign pma_soft_reset = (lm_dep) ? (~mb_enable | mb_cdb_reset | mb_cdb_pma_reset | ~rx_signal_detect) :
                                   (~mb_enable | mb_cdb_reset | mb_cdb_pma_reset | ~rx_signal_detect | ~lm_pma_req);
			   

//--------------------------------------------------------------------
// Wait Counter to delay the assertion of rx_mrgn_req after loading 
// the rx_mrgn_offset/direction for PMA.
//--------------------------------------------------------------------

always @(posedge pipe_mac2phy_clk or negedge pipe_mac2phy_rstn)
begin
	if (~pipe_mac2phy_rstn)
		wait_cnt <= 4'd0;
	else if (pma_soft_reset | wait_cnt_rst)
		wait_cnt <= 4'd0;
	else if (wait_cnt_en)
		wait_cnt <= wait_cnt + 4'd1;
end

assign wait_cnt_reached = (wait_cnt == lm_cdb_pma_wait);

//--------------------------------------------------------------------
// LM PMA FSM State change register
//--------------------------------------------------------------------

always @(posedge pipe_mac2phy_clk or negedge pipe_mac2phy_rstn)
begin
	if (~pipe_mac2phy_rstn)
		lm_pma_state <= RX_MRGN_IDLE;
	else if (pma_soft_reset)
		lm_pma_state <= RX_MRGN_IDLE;
	else 
		lm_pma_state <= lm_pma_next_state;
end

//--------------------------------------------------------------------
// Finite State Machine 
//--------------------------------------------------------------------

always @*
begin

load_mrgn_attributes 	= 1'b0;
wait_cnt_en 		= 1'b0;
wait_cnt_rst 		= 1'b0;
load_lm_errcnt		= 1'b0;
rx_mrgn_req_int		= 1'b0;
lm_pma_ack_int		= 1'b0;

	case(lm_pma_state)
	
	RX_MRGN_IDLE:
	begin
		// LM Controller issued a request to initiate PMA Rx margining
		if (lm_pma_req)
		begin
			load_mrgn_attributes = 1'b1;
			lm_pma_next_state = RX_MRGN_WAIT;
		end
		else
			lm_pma_next_state = RX_MRGN_IDLE;
	end
	
	RX_MRGN_WAIT:
	begin
		// Wait for programmable number of cycles before asserting the Rx margining request
		// PMA needs at least 2 cycles of rx_rd_clk between offset/direction and request
		// assertion.
		if (wait_cnt_reached)
		begin
			wait_cnt_rst = 1'b1;
			lm_pma_next_state = RX_MRGN_REQUEST;
		end
		else
		begin
			wait_cnt_en = 1'b1;
			lm_pma_next_state = RX_MRGN_WAIT;
		end
	end
	
	RX_MRGN_REQUEST:
	begin
		// Waitl until PMA Rx margining is finished ie. rx_mrgn_valid is asserted
		if (rx_mrgn_valid)
		begin
			rx_mrgn_req_int = 1'b0;
			load_lm_errcnt = 1'b1;
			lm_pma_next_state = RX_MRGN_VALID;
		end
		else
		begin
			rx_mrgn_req_int = 1'b1;
			lm_pma_next_state = RX_MRGN_REQUEST;
		end
	end
	
	RX_MRGN_VALID:
	begin
		// After PMA Rx margining request is de-asserted, wait until rx_mrgn_valid is de-asserted
		// to ensure that PMA has come to its idle state.
		if (rx_mrgn_valid)
		begin
			lm_pma_next_state = RX_MRGN_VALID;
		end
		else
		begin
			lm_pma_ack_int = 1'b1;
			lm_pma_next_state = RX_MRGN_ACK;
		end
	end
	
	RX_MRGN_ACK:
	begin
		// After lm_pma_ack is asserted, wait until lm_pma_req is de-asserted by the LM Controller
		// to ensure that LM Controller has acknowledged the PMA Rx margining completion. It is possible
		// that LM Controller might be servicing other LM commands and hence lm_pma_req/ack signals are
		// intentionally kept level sensitive to have smooth transfer of information.
		if (lm_pma_req & ~lm_dep)
		begin
			lm_pma_ack_int = 1'b1;
			lm_pma_next_state = RX_MRGN_ACK;
		end
		else
		begin
			lm_pma_ack_int = 1'b0;
			lm_pma_next_state = RX_MRGN_IDLE;
		end
	end

	default:	lm_pma_next_state = RX_MRGN_IDLE;
	
	endcase
end

endmodule
