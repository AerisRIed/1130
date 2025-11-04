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
//   Module Name    : cdnsdru_usb4_message_bus_lm_regs_v4
//
//   Author         : Dongdong Wang
//
//   Date           : July 23, 2025
//
//   Limitations    :
//
//   Notes          : Based on cdnsdru_pcie_message_bus_lm_regs_v4 authored by Thomas Faison
//---------------------------------------------------------------------------------
//   Description    :	Lane Margining Register Controller Module
//			The purpose of this module is to co-ordinate between the
//			PIPE Tx, PIPE Rx and PMA Tx/Rx modules. This block contains
//			the following logics
//			1. Manages the LM PHY registers
//			2. Sample count calculation
//			3. Error count calculation
//---------------------------------------------------------------------------------


module cdnsdru_usb4_message_bus_lm_regs_v4 (

input			pipe_mac2phy_clk,		// PHY: LM Clock based on PIPE interface data width --> 500MHz (32-bit) or 1GHz (16-bit)
input			pipe_mac2phy_rstn,		// PHY: LM Reset. Active Low
input			mb_enable,			// PHY: LM Enable when PCIe Gen4 and P0 state

input			mb_cdb_reset,			// PHY CDB: Soft Reset for entire LM block including all sub-blocks
input			mb_cdb_ctrl_reset,		// PHY CDB: Soft Reset for entire LM Controller
input		[5:0]	lm_cdb_sample_3logn,		// PHY CDB: Programmable Rx margining sample count of 3 * log2 (N)
input		[7:0]	lm_cdb_sample_max,		// PHY CDB: Programmable Rx margining sample count max value (Default: 8'd127)
input		[7:0]	lm_cdb_sample_threshold,	// PHY CDB: Programmable Rx margining sample count threshold (Default: 8'd129)
input		[5:0]	lm_cdb_error_max,		// PHY CDB: Programmable Rx margining error count max value (Default: 6'd63)
input		[5:0]	lm_cdb_error_threshold,		// PHY CDB: Programmable Rx margining error count threshold (Default: 6'd63)

output	wire		lm_cdb_smplcnt_saturated,	// PHY CDB: Sample Count Saturated
output	wire		lm_cdb_errcnt_saturated,	// PHY CDB: Error Count Saturated

input			rx_signal_detect,		// PMA: Receiver Signal Detect


input			rx_mrgn_valid,			// LM PMA: Rx margin valid indicating that PMA finished current rx margining
input			lm_pma_ack,			// LM PMA Controller: PMA Rx margining completed acknowledgment
input		[5:0]	lm_pma_errcnt,			// LM PMA Controller: PMA Rx margining error count
output	reg		lm_pma_req,			// LM PMA Controller: Request to initiate PMA Rx margining
output	wire	[1:0]	lm_pma_direction,		// LM PMA Controller: Direction (East/West/North/South) for PMA Rx margining
output	reg	[6:0]	lm_pma_offset,			// LM PMA Controller: Offset for PMA Rx margining

// PHY PCS
input			lm_eb_sts_upd,			// PHY PCS: Elasticity Buffer Status Update
input		[7:0]	lm_eb_sts,			// PHY PCS: Elasticity Buffer Status 
input		[5:0]	lm_cdb_timing_offset,		// PHY CDB: Programmable Max timing offset value supported by PMA
input		[6:0]	lm_cdb_voltage_offset,		// PHY CDB: Programmable Max voltage offset value supported by PMA

input 			lm_dep,

// PIPE Reg Controller
input           [3:0]	prio_tx_writes_done_lm,
input           	prio_tx_writes_done_sts,
//input 			rx_write_com,
input 			lm_rx_write_ack,
input           [3:0]   phy_reg000,
input           [7:0]   phy_reg001,

output reg 		ebsts_tx_write,
output reg 	[3:0]	lm_tx_writes,
output reg      [7:0]   mac_reg000,
output reg      [7:0]   mac_reg001,
output reg      [7:0]   mac_reg002,
output reg      [7:0]   mac_reg003
);

//--------------------------------------------------------------------
// FSM Parameters
//--------------------------------------------------------------------

   localparam WAIT_STOP = 2'b00;
   localparam WAIT_PMA = 2'b01;
   localparam WAIT_UPDATE = 2'b10;
   localparam WRITE_MB = 2'b11;

//--------------------------------------------------------------------
// Local Variables
//--------------------------------------------------------------------

   wire 	 ctrl_soft_reset;
   wire 	 sample_cnt_rst_trigger;
   wire 	 icnt0_reached;
   wire 	 icnt1_reached;
   wire 	 icnt2_reached;
   wire 	 icnt0_en;
   wire 	 icnt1_en;
   wire 	 icnt2_en;
   wire 	 tx_pma_write_en;
   wire 	 error_cnt_rst_trigger;
   wire 	 posedge_tx_pma_write_en;
   wire 	 error_cnt_write_en;
   wire 	 mrgn_offset_change;
   wire 	 update_cnt_en;
   wire 	 saturation_update;
   wire 	 mrgn_cnt_update;
   wire 	 posedge_start_margin;
   wire 	 negedge_start_margin;
   wire 	 posedge_lm_eb_sts_upd;
   wire 	 stop_mrgn_done;

   wire [6:0] 	 lm_pma_offset_raw;
   wire [30:0] 	 icnt;

   reg [1:0] 	 stop_mrgn_state_next;
   reg [1:0] 	 stop_mrgn_state;
   reg 		 lm_mrgn_en;
   reg 		 sample_cnt_rst;
   reg 		 error_cnt_saturated;
   reg 		 sample_cnt_saturated;
   reg 		 tx_pma_write_en_reg1;
   //reg 		 rx_write_com_reg;
   reg 		 icnt0_reached_reg;
   reg 		 icnt1_reached_reg;
   reg 		 icnt2_reached_reg;
   reg [6:0] 	 error_cnt;
   reg       	 phy_reg000_reg_0;
   reg [6:0] 	 phy_reg001_reg;
   reg [7:0] 	 sample_cnt;
   reg [9:0] 	 icnt0;
   reg [9:0] 	 icnt1;
   reg [9:0] 	 icnt2;
   reg  	 icnt3;
   reg [2:0] 	 update_cnt;
   reg 		 error_cnt_rst;
   reg 		 lm_eb_sts_upd_reg1;
   reg [3:0] 	 lm_tx_writes_pre;
   reg 		 rx_mrgn_valid_reg;
   wire 	 posedge_rx_mrgn_valid;

//--------------------------------------------------------------------


//--------------------------------------------------------------------
// This block will be reset when any one of the followign conditions
// are true
// 1. LM Disabled (PHY is not in Gen4 P0 state)
// 2. LM soft reset (Software)
// 3. LM Block level soft reset (Software)
//--------------------------------------------------------------------

   assign ctrl_soft_reset = (~mb_enable | mb_cdb_reset | mb_cdb_ctrl_reset);


//--------------------------------------------------------------------
// Delay Flops
//--------------------------------------------------------------------

   always @(posedge pipe_mac2phy_clk or negedge pipe_mac2phy_rstn)
     begin
	if (~pipe_mac2phy_rstn)
	  begin
	     phy_reg000_reg_0 	<= 1'd0;
	     phy_reg001_reg 	<= 7'd0;
	     tx_pma_write_en_reg1  <= 1'b0;
	     lm_eb_sts_upd_reg1 <= 1'b0;
	     //rx_write_com_reg 	<= 1'b0;
	     icnt0_reached_reg	<= 1'b0;
	     icnt1_reached_reg	<= 1'b0;
	     icnt2_reached_reg	<= 1'b0;
	  end
	else if (ctrl_soft_reset)
	  begin
	     phy_reg000_reg_0 	<= 1'd0;
	     phy_reg001_reg 	<= 7'd0;
	     tx_pma_write_en_reg1  <= 1'b0;
	     lm_eb_sts_upd_reg1 <= 1'b0;
	     //rx_write_com_reg 	<= 1'b0;
	     icnt0_reached_reg	<= 1'b0;
	     icnt1_reached_reg	<= 1'b0;
	     icnt2_reached_reg	<= 1'b0;
	  end
	else
	  begin
	     phy_reg000_reg_0 	<= phy_reg000[0];
	     phy_reg001_reg 	<= phy_reg001[6:0];
	     tx_pma_write_en_reg1  <= tx_pma_write_en;
	     lm_eb_sts_upd_reg1 <= lm_eb_sts_upd;
	     //rx_write_com_reg 	<= rx_write_com;
	     icnt0_reached_reg	<= icnt0_reached;
	     icnt1_reached_reg	<= icnt1_reached;
	     icnt2_reached_reg	<= icnt2_reached;
	  end
     end

   assign lm_cdb_smplcnt_saturated = sample_cnt_saturated;
   assign lm_cdb_errcnt_saturated = error_cnt_saturated;

//--------------------------------------------------------------------
// Register field definitions
//
// Associations:
//    lm_mrgn_en		= phy_reg000[0]
//    lm_pma_direction[1] 	= phy_reg000[1] (voltage or timing)
//    lm_pma_direction[0]	= phy_reg001[7]	(0=left/up, 1=right/down)
//    error_cnt_rst_trigger	= phy_reg000[2]
//    sample_cnt_rst_trigger	= phy_reg000[3]
//    lm_pma_offset		= phy_reg001[6:0]
//--------------------------------------------------------------------

//--------------------------------------------------------------------
// lm_mrgn_en
//--------------------------------------------------------------------
// 1. lm_mrgn_en is asserted when
//	a. Whenever margin status is sent indicating that the 
//	   received command from MAC is valid
// 2. lm_mrgn_en is de-asserted when
//	a. Last action taken after LM enable deasserted
//--------------------------------------------------------------------
   
   always @(posedge pipe_mac2phy_clk or negedge pipe_mac2phy_rstn)
     begin
	if (~pipe_mac2phy_rstn)
	  lm_mrgn_en <= 1'b0;
	else if (ctrl_soft_reset | prio_tx_writes_done_lm[3])
	  lm_mrgn_en <= 1'b0;
	else if (posedge_start_margin)
	  lm_mrgn_en <= 1'b1;
     end

//--------------------------------------------------------------------
// Lane Margining Direction
//--------------------------------------------------------------------
// [0] - Margin Direction (East/West/Left/Right)
// [1] - Margin Type (Timing or Voltage)
//--------------------------------------------------------------------
   
   assign lm_pma_direction 	= {phy_reg000[1],phy_reg001[7]};
  

//--------------------------------------------------------------------
// Lane Margining Error Count Reset
// Error count is reset whenever Error Count Reset is issued by MAC in phy_reg000[2]
//--------------------------------------------------------------------
   
   assign error_cnt_rst_trigger	= phy_reg000[2];
   
   always @(posedge pipe_mac2phy_clk or negedge pipe_mac2phy_rstn)
     begin
	if (~pipe_mac2phy_rstn)
	  error_cnt_rst <= 1'b0;
	else if (ctrl_soft_reset | error_cnt_rst)
	  error_cnt_rst <= 1'b0;
	else if (error_cnt_rst_trigger)
	  error_cnt_rst <= 1'b1;
     end
   

//--------------------------------------------------------------------
// Lane Margining Sample Count Reset
// Sample count is reset whenever Sample Count Reset is issued by MAC in phy_reg000[3]
//--------------------------------------------------------------------
   
   assign sample_cnt_rst_trigger = phy_reg000[3];
   
   always @(posedge pipe_mac2phy_clk or negedge pipe_mac2phy_rstn)
     begin
	if (~pipe_mac2phy_rstn)
	  sample_cnt_rst <= 1'b0;
	else if (ctrl_soft_reset | sample_cnt_rst)
	  sample_cnt_rst <= 1'b0;
	else if (sample_cnt_rst_trigger)
	  sample_cnt_rst <= 1'b1;
     end
   

//--------------------------------------------------------------------
// Lane Margining Offset
//--------------------------------------------------------------------
// Offset is checked against the PMA supported max value.
// If the incoming offset from MAC is greater than the 
// supported value, then lane margining is performed with 
// the maximum supported value instead of the MAC provided
// invalid value.
//--------------------------------------------------------------------
   
   assign lm_pma_offset_raw = phy_reg001[6:0];
   
   always @*
     begin
	if (lm_dep & (stop_mrgn_state != WAIT_STOP))
	  begin
	     lm_pma_offset = 7'h00;
	  end
	else
	  begin

	     // Timing
	     if (phy_reg000[1])
	       begin
		  if (lm_pma_offset_raw >= {1'b0,lm_cdb_timing_offset})
		    lm_pma_offset = {1'b0,lm_cdb_timing_offset};
		  else
		    lm_pma_offset = lm_pma_offset_raw;
	       end
	     // Voltage
	     else
	       begin
		  if (lm_pma_offset_raw >= lm_cdb_voltage_offset)
		    lm_pma_offset = lm_cdb_voltage_offset;
		  else
		    lm_pma_offset = lm_pma_offset_raw;
	       end
	  end
     end


//--------------------------------------------------------------------
// Margin Count Update
//--------------------------------------------------------------------
// Margin status is updated 4 cycles after tx_pma_write_en
// is asserted. These 4 cycles are provided for updating the
// sample count in a pipelined manner to manage timing
// closure issues, as the sample count is a 31-bit counter.
// When mrgn_cnt_update is assrted, tx_write is also
// asserted in the next cycle to signal the FSM to start
// the PHY Status update to the MAC via PIPE interface.
//
// Count 0: icnt0_en asserted for incrementing icnt0 counter
// Count 1: icnt1_en asserted for incrementing icnt1 counter
// Count 2: icnt2_en asserted for incrementing icnt2 counter
// Count 3: icnt3_en asserted for incrementing icnt3 counter
// Count 4: saturation_update asserted for calculation of sample/error count staturation
// Count 5: mrgn_cnt_update asserted for loading the sample/error count into MAC registers
//--------------------------------------------------------------------

   assign update_cnt_en = (posedge_tx_pma_write_en == 1'b1 | update_cnt != 3'd0);
   
   always @(posedge pipe_mac2phy_clk or negedge pipe_mac2phy_rstn)
     begin
	if (~pipe_mac2phy_rstn)
	  update_cnt <= 3'd0;
	else if (ctrl_soft_reset | mrgn_cnt_update | prio_tx_writes_done_lm[3])
	  update_cnt <= 3'd0;
	else if (update_cnt_en)
	  update_cnt <= update_cnt + 3'd1;
     end
   
   assign saturation_update = (update_cnt == 3'd4);
   assign mrgn_cnt_update = (update_cnt == 3'd5);
   

//--------------------------------------------------------------------
// ebsts_tx_write
//--------------------------------------------------------------------
// 1. ebsts_tx_write is asserted whenever PHY receives the
//    lm_eb_sts from the PCS indicating that the EB 
//    depth is updated.
// 2. ebsts_tx_write is de-asserted whenever MB block
//    successfully transmitted the EB status to the MAC and
//    received the ACK for the PHY write
//--------------------------------------------------------------------

   assign posedge_lm_eb_sts_upd = lm_eb_sts_upd & ~lm_eb_sts_upd_reg1;
   
   always @(posedge pipe_mac2phy_clk or negedge pipe_mac2phy_rstn)
     begin
	if (~pipe_mac2phy_rstn)
	  ebsts_tx_write <= 1'b0;
	else if (ctrl_soft_reset | prio_tx_writes_done_sts)
	  ebsts_tx_write <= 1'b0;
	else if (posedge_lm_eb_sts_upd)
	  ebsts_tx_write <= 1'b1;
     end
   


//--------------------------------------------------------------------
// tx_writes and pma requests
//--------------------------------------------------------------------
//
// There are 4 different TX write cases that are handled by the lane
// margining function:
//
// lm_tx_writes[0]: Indicates that the LM has been enabled. This will
//    drive a TX of the Margin Status register
//
// lm_tx_writes[1]: Indicates that the margin offset has changed. This
//    causes a TX write of the margin status register.
//
// lm_tx_writes[2]: Indicates it is time to send sample/error register
//    writes to the MAC.
//
//    It is asserted when PMA Request and Ack
//    are asserted and the sample count is calculated (pipe-lined).
//    It means that the LM controller has initiated
//    the Rx margining in PMA by asserting a req and the PMA 
//    has completed the request by asserting the ack. Hence 
//    when both req and ack are asserted it means 
//    that the PHY can initiate the status update.
//
// lm_tx_writes[3]: Indicates the end of the LM cycle. This will drive
//    TX writes of the sample, error, and status registers.
//
// Note:
//    If lm_eb_sts_upd and ebsts_tx_write are asserted
//    then tx_pma_write_en is not asserted until the EB buffer 
//    status is updated to MAC. This is done so that there is
//    conflict between tx_write and ebsts_tx_write requests
//    and it will help in having simplified FSM.
//--------------------------------------------------------------------
   
   assign tx_pma_write_en = (lm_pma_req & lm_pma_ack & ~lm_eb_sts_upd);
   assign posedge_tx_pma_write_en = (tx_pma_write_en & ~tx_pma_write_en_reg1);


   // Triggers for writes
   assign posedge_start_margin = (~phy_reg000_reg_0 & phy_reg000[0]);
   assign negedge_start_margin = (phy_reg000_reg_0 & ~phy_reg000[0]);

   // In dependent mode we have to delay writes until valid received from PMA
   // so we have to detect the valid posedge
   always @(posedge pipe_mac2phy_clk or negedge pipe_mac2phy_rstn)
     begin
	if (~pipe_mac2phy_rstn)
	  rx_mrgn_valid_reg <= 1'b0;
	else
	  rx_mrgn_valid_reg <= rx_mrgn_valid;
     end
   assign posedge_rx_mrgn_valid = ~rx_mrgn_valid_reg & rx_mrgn_valid;


   // lm_tx_writes[0] (Start of margining)
   // Wait for start-of-margining indication (dependent mode only)
   always @(posedge pipe_mac2phy_clk or negedge pipe_mac2phy_rstn)
     begin
	if (~pipe_mac2phy_rstn)
	  lm_tx_writes_pre[0] <= 1'b0;
	else if (ctrl_soft_reset | prio_tx_writes_done_lm[0] | ~lm_dep)
	  lm_tx_writes_pre[0] <= 1'b0;
	else if (posedge_start_margin & lm_dep)
	  lm_tx_writes_pre[0] <= 1'b1;
     end

   // Write for start-of-margining (wait for valid in dependent mode)
   always @(posedge pipe_mac2phy_clk or negedge pipe_mac2phy_rstn)
     begin
	if (~pipe_mac2phy_rstn)
	  lm_tx_writes[0] <= 1'b0;
	else if (ctrl_soft_reset | prio_tx_writes_done_lm[0])
	  lm_tx_writes[0] <= 1'b0;
	else if (posedge_start_margin & ~lm_dep)
	  lm_tx_writes[0] <= 1'b1;
	else if (posedge_rx_mrgn_valid & lm_dep)
	  lm_tx_writes[0] <= lm_tx_writes_pre[0];
     end


   // lm_tx_writes[1] (Offset change)
   // Wait for offset change indication (dependent mode only)
   always @(posedge pipe_mac2phy_clk or negedge pipe_mac2phy_rstn)
     begin
	if (~pipe_mac2phy_rstn)
	  lm_tx_writes_pre[1] <= 1'b0;
	else if (ctrl_soft_reset | prio_tx_writes_done_lm[1] | ~lm_dep)
	  lm_tx_writes_pre[1] <= 1'b0;
	else if (mrgn_offset_change & lm_dep)
	  lm_tx_writes_pre[1] <= 1'b1;
     end

   // Write for change-of-offset (wait for valid in dependent mode)
   always @(posedge pipe_mac2phy_clk or negedge pipe_mac2phy_rstn)
     begin
	if (~pipe_mac2phy_rstn)
	  lm_tx_writes[1] <= 1'b0;
	else if (ctrl_soft_reset | prio_tx_writes_done_lm[1])
	  lm_tx_writes[1] <= 1'b0;
	else if (mrgn_offset_change & ~lm_dep)
	  lm_tx_writes[1] <= 1'b1;
	else if (posedge_rx_mrgn_valid & lm_dep)
	  lm_tx_writes[1] <= lm_tx_writes_pre[1];
     end


   // lm_tx_writes[2] (sample/error counts) (never sent in dependent mode)
   // Write for sending sample/error counts. Superceded by end-of-margining.
   // If destructive margining is on do not request write.
   //
   // NOTE: lm_tx_writes_pre[2] is currently unused, but given some dummy logic
   // to avoid synthesis complaints
   always @(posedge pipe_mac2phy_clk or negedge pipe_mac2phy_rstn)
     begin
	if (~pipe_mac2phy_rstn)
	  begin
	     lm_tx_writes[2] <= 1'b0;
	     lm_tx_writes_pre[2] <= 1'b0;
	  end
	else if (ctrl_soft_reset | (|prio_tx_writes_done_lm[3:2]) | lm_dep)
	  begin
	     lm_tx_writes[2] <= 1'b0;
	     lm_tx_writes_pre[2] <= 1'b0;
	  end
	else if (mrgn_cnt_update & (stop_mrgn_state == WAIT_STOP))
	  begin
	     lm_tx_writes[2] <= 1'b1;
	     lm_tx_writes_pre[2] <= 1'b1;
	  end
     end


   // lm_tx_writes[3] (End of margining)
   // Wait for end-of-margining indication (dependent mode only)
   always @(posedge pipe_mac2phy_clk or negedge pipe_mac2phy_rstn)
     begin
	if (~pipe_mac2phy_rstn)
	  lm_tx_writes_pre[3] <= 1'b0;
	else if (ctrl_soft_reset | prio_tx_writes_done_lm[3] | ~lm_dep)
	  lm_tx_writes_pre[3] <= 1'b0;
	else if (stop_mrgn_done & lm_dep)
	  lm_tx_writes_pre[3] <= 1'b1;
     end

   // Write based on end-of-margining (wait for valid in dependent mode)
   always @(posedge pipe_mac2phy_clk or negedge pipe_mac2phy_rstn)
     begin
	if (~pipe_mac2phy_rstn)
	  lm_tx_writes[3] <= 1'b0;
	else if (ctrl_soft_reset)
	  lm_tx_writes[3] <= 1'b0;
	else if (posedge_rx_mrgn_valid & lm_dep)
	  lm_tx_writes[3] <= lm_tx_writes_pre[3];
	else
	  lm_tx_writes[3] <= stop_mrgn_done;
     end


   // End-of-margining tracker
   // Detect end-of-margining, waiting for the last PMA request to be completed
   // before making the final write request.

   always @(posedge pipe_mac2phy_clk or negedge pipe_mac2phy_rstn)
     begin
	if (~pipe_mac2phy_rstn)
	  stop_mrgn_state <= 2'b00;
	else if (ctrl_soft_reset | prio_tx_writes_done_lm[3])
	  stop_mrgn_state <= 2'b00;
	else
	  stop_mrgn_state <= stop_mrgn_state_next;
     end

   // Trigger for stop-margin-related writes.
   assign stop_mrgn_done = (stop_mrgn_state == WRITE_MB);

   //State machine to determine when writes should be triggered.
   always @*
     begin
	case (stop_mrgn_state)

	  // Do nothing until we see stop-margining indication
	  WAIT_STOP:
	    begin
	       if (lm_dep)
		 begin
		    if (negedge_start_margin) stop_mrgn_state_next = WAIT_PMA;
		    else stop_mrgn_state_next = WAIT_STOP;
		 end
	       else
		 begin
		    if (negedge_start_margin & lm_pma_ack & mrgn_cnt_update) stop_mrgn_state_next = WRITE_MB;
		    else if (negedge_start_margin & lm_pma_ack & update_cnt_en) stop_mrgn_state_next = WAIT_UPDATE;
		    else if (negedge_start_margin & lm_pma_ack) stop_mrgn_state_next = WRITE_MB;
		    else if (negedge_start_margin) stop_mrgn_state_next = WAIT_PMA;
		    else stop_mrgn_state_next = WAIT_STOP;
		 end
	    end

	  // Wait for the PMA to complete any requests. If we saturated then no requests should be pending.
	  WAIT_PMA:
	    begin
	       if (lm_dep)
		 begin
		    if (posedge_rx_mrgn_valid) stop_mrgn_state_next = WRITE_MB;
		    else stop_mrgn_state_next = WAIT_PMA;
		 end
	       else
		 begin
		    if (error_cnt_saturated | sample_cnt_saturated) stop_mrgn_state_next = WRITE_MB;
		    else if (lm_pma_ack & mrgn_cnt_update) stop_mrgn_state_next = WRITE_MB;
		    else if (lm_pma_ack) stop_mrgn_state_next = WAIT_UPDATE;
		    else stop_mrgn_state_next = WAIT_PMA;
		 end
	    end

	  // Once PMA has responded we wait for margin count update.
	  WAIT_UPDATE:
	    begin
	       if (mrgn_cnt_update) stop_mrgn_state_next = WRITE_MB;
	       else stop_mrgn_state_next = WAIT_UPDATE;
	    end

	  // Write-trigger state. Go back to WAIT_STOP when write is done.
	  WRITE_MB:
	    begin
	       if (prio_tx_writes_done_lm[3]) stop_mrgn_state_next = WAIT_STOP;
	       else stop_mrgn_state_next = WRITE_MB;
	    end
	  default: stop_mrgn_state_next = WAIT_STOP;
	endcase
     end


//--------------------------------------------------------------------
// lm_pma_req
//--------------------------------------------------------------------
// 1. lm_pma_req is asserted when 
//	a. lane margining is requested in the PIPE register by 
//	   the MAC and there is prior lm_pma_req is asserted
// 2. lm_pma_req is de-asserted when 
//	a. ctrl_soft_reset is asserted (soft reset)
//	b. FSM resets the request either as handhsake or 
//         ignoring the status (due to new write committed from 
//	   MAC)
// 	c. lane margining is disabled in the PIPE register by 
//	   the MAC (detected by negedge of lm_mrgn_en)
//	d. rx_signal_detect is de-asserted
//--------------------------------------------------------------------


// This signal helps set tx_pma_write_en
   always @(posedge pipe_mac2phy_clk or negedge pipe_mac2phy_rstn)
     begin
	if (~pipe_mac2phy_rstn)
	  lm_pma_req <= 1'b0;
	else
	  if (lm_dep)
	    begin
	       if (ctrl_soft_reset | lm_rx_write_ack | ~rx_signal_detect | posedge_rx_mrgn_valid)
		 lm_pma_req <= 1'b0;
	       else if (((posedge_start_margin | mrgn_offset_change) & phy_reg000[0]) | negedge_start_margin)
		 lm_pma_req <= 1'b1;
	    end
	  else
	    begin
	       if (ctrl_soft_reset | lm_rx_write_ack | ~rx_signal_detect | (lm_dep & lm_rx_write_ack) | (lm_dep & (stop_mrgn_state != WAIT_STOP)))
		 lm_pma_req <= 1'b0;
	       else if (lm_mrgn_en & ~sample_cnt_saturated & ~error_cnt_saturated & phy_reg000[0])
		 lm_pma_req <= 1'b1;
	    end
     end


//--------------------------------------------------------------------
// Detect Margin Offset change
//--------------------------------------------------------------------

   assign mrgn_offset_change = (phy_reg001[6:0] != phy_reg001_reg[6:0]) & ~posedge_start_margin & ~negedge_start_margin;
   

//--------------------------------------------------------------------
// Sample Count Calculation
//--------------------------------------------------------------------
//
// Sample Count = 3 * log2 (N), where N = Number of bits margined
//
// Within a single lane margining request there will be multiple 
// itertaions of PMA rx margining as PMA performs rx margining for a
// pre-determined number of bits during each iteration. The number of
// bits margined during each iteration is based on 2 PMA parameters
// namely PMA data width (16-bit or 32-bit) and eyesurf_time_preg
// (programmable parameter in eye surf module).
//
// PMA 32-bit interface: 
//		Min: 16384  bits per iteration
//		Max: 262144 bits per iteration
// PMA 16-bit interface: 
//		Min: 8192   bits per iteration
//		Max: 131072 bits per iteration
// Here eyesurf_time_preg = 11 (min) 15 (max)
//
// For calcualtion purpose, lets assume PMA 32-bit interface and
// for each iteration sample count will be updated as follows
//
// Iteration1: 3 * log (N)
// Iteration2: 3 * log (N+N)   ==> 3 * log(2N) ==> 3 * [log2 (N) + log2 (2)]
// Iteration2: 3 * log (N+N+N) ==> 3 * log(3N) ==> 3 * [log2 (N) + log2 (3)]
// ..........
// ..........
// ..........
// ..........
// IterationM: 3 * [log2 (N) + log2 (M)], where
//
// N = Number of bits margined and M = Number of iterations
// As N value is known per iteration ie., N = 8192 (Min value), the formula is as follows
//
// Sample Count = 3 * log2 (8192) + 3 * log2 (M) ==> 39 + 3 * log2 (M)
//
// Here log2 (8192) = 13 (PMA 32-bit interface). Since the value is fixed, it is decided to get this value
// via PHY CDB as it will enable to have simple hardware and also provided flexibility
// to change the values run time via software programming without any change in 
// hardware. The fixed parameter is obtained via lm_cdb_sample_3logn.
//
// Sample Count = lm_cdb_sample_3logn + 3 * log2 (M)
//
// Now all we need to do is to calculate the number of iterations per lane margining
// request and substitute in the above formula. But in order to do that we need to
// identify the number of register bits required for the iteration counter. It is 
// calculated as below. As per PCIe base specification, the maximum sample count
// could be 127. By substituting that in the above formula we could get M
//
// 127 = lm_cdb_sample_3logn + 3 * log2 (M)
// (127 - 39) / 3 = log2 (M)
// 29.33 = log2 (M)
//
// As we know, the value in log2 function shall be represented in the form of 2 to the
// power of X ie., log2 (2 ^ X) = X
//
// With the above assumption, 
// 24.33 = log2 (2 ^ X), where M = 2 ^ X
// Then, X = 29.33
//  
// M = 2 ^ 29.33 ==> 536870912 (~537 million) iterations are possible per lane 
// margining request from MAC. Rounded off to 30 ie., 2^30 to get.a maximum sample count of 127 (129).
// Hence we need 31-bit iteration counter.
//
// Sample Count = lm_cdb_sample_3logn + 3 * log2 (M)
// where M is the 30-bit interation counter
//
// Case statement shall be used to implement the log2 (M) where the MSB bit position of
// the iteration counter shall shall provide the value of log2 (M). In order to simplify
// the hardware, MSB position shall be multiplied by 3 and used for summation.
//
//--------------------------------------------------------------------


//--------------------------------------------------------------------
// Iteration Counter
//--------------------------------------------------------------------
// Iteration counter is 31-bit counter. It is possible to have timing closure issues
// at 1GHz (pipe_mac2phy_clk). Hence the 31-bit counter is sub-divided into 3 10-bit counters
// and a single 1-bit register to accomodate the 31st bit of the counter. Here
// when first 10-bit counter reached 10'3FF, then the flopped version of the count reached is
// used to increment the subsequent 10-bit counter by 1. By this way the delay in each counter 
// will be restricted to 10-bit counter and will be easy to perform timing closure. In the end 
// all 10-bit counters and 1-bit flow are concatenated in order to get the consolidated 31-bit 
// iteration count.
// The 3 10-bit counters are icnt0, icnt1 and icnt2. When icnt0 reached 10'h3FF and tx_pma_write_en
// is asserted, then icnt1 is incremented by 1. Similarly when icnt1 reached 10'h3FF and flopped
// version of icnt0 count reached (based on icnt0 and tx_pma_write_en), then icnt2 is incremented
// by 1. Similarly when icnt2 reached 10'h3FF and flopped version of icnt1 count reached, then 
// icnt2 is incremented by 1.This continues until icnt3 is asserted to indicate that sample 
// count reached its saturation threshold (8'd129). Once the saturation is attained, then 
// icnt0 will not be incremented which will not further increment the icnt1 and icnt2 as these 
// counters are cascaded.
//
// Iteration Counter is counted
//	1. Whenever PMA has completed its margining request which is indicated via
//	   assertion of lm_pma_ack (and lm_pma_req = 1). tx_pma_write_en assertion (1-cycle)
//	   indicates that PHY is going to start the status update from next cycle. Hence
//	   iteration counter is updated when tx_pma_write_en is asserted so that the value
//	   is available in the next cycle when tx_write is asserted based on which FSM
//	   is triggered and sample count is not saturated. 
// Iteration Count is not counted
//	1. Whenever sample counter threshold is reached (see conditions in 
//	   sample count section)
// Iteration Count is reset
//	1. Whenever sample counter is reset (see conditions in sample count section)
//	2. Whenver soft reset is assereted by software
//--------------------------------------------------------------------
   
//--------------------------------------------------------------------
// Counter Enable trigger for first iteration counter (icnt0)
//--------------------------------------------------------------------
// This counter is incremented on every tx_pma_write_en until the sample count saturation
// is reached (ie., icnt3 = 1'b1)
//--------------------------------------------------------------------
   
   assign icnt_en  = posedge_tx_pma_write_en;

//--------------------------------------------------------------------
// Counter Enable for all iteration counters
//--------------------------------------------------------------------
// 1. icnt0 --> Incremented when icnt_en is asserted
// 2. icnt1 --> Incremented when flopped verison of icnt0_reached is asserted
// 3. icnt2 --> Incremented when flopped verison of icnt1_reached is asserted
// 4. icnt3 --> Asserted (1-bit) when flopped verison of icnt2_reached is asserted
//--------------------------------------------------------------------

   assign icnt0_en = (icnt_en);
   assign icnt1_en = (icnt0_reached_reg);
   assign icnt2_en = (icnt1_reached_reg);
   assign icnt3_en = (icnt2_reached_reg);

//--------------------------------------------------------------------
// Counter reached trigger for all iteration counters
//--------------------------------------------------------------------
// icnt0 --> when icnt0 = 10'h3FF and tx_pma_write_en is asserted
// icnt1 --> when icnt1 = 10'h3FF and flopped verion of icnt0_reached is asserted
// icnt2 --> when icnt2 = 10'h3FF and flopped verion of icnt1_reached is asserted
//--------------------------------------------------------------------

   assign icnt0_reached	= (icnt0_en & (&icnt0));
   assign icnt1_reached	= (icnt1_en & (&icnt1));
   assign icnt2_reached	= (icnt2_en & (&icnt2));

//--------------------------------------------------------------------
// Counter for all iteration counters
//--------------------------------------------------------------------

   always @(posedge pipe_mac2phy_clk or negedge pipe_mac2phy_rstn)
     begin
	if (~pipe_mac2phy_rstn)
	  begin
	     icnt0 <= 10'd0;
	     icnt1 <= 10'd0;
	     icnt2 <= 10'd0;
	     icnt3 <= 1'b0;
	  end
	else if (ctrl_soft_reset | sample_cnt_rst)
	  begin
	     icnt0 <= 10'd0;
	     icnt1 <= 10'd0;
	     icnt2 <= 10'd0;
	     icnt3 <= 1'b0;
	  end
	else 
	  begin
	     if (icnt0_en)
	       icnt0 <= icnt0 + 10'd1;
	     if (icnt1_en)
	       icnt1 <= icnt1 + 10'd1;
	     if (icnt2_en)
	       icnt2 <= icnt2 + 10'd1;
	     if (icnt3_en)
	       icnt3 <= 1'b1;
	  end
     end

//--------------------------------------------------------------------
// Sample Count Calculation
//--------------------------------------------------------------------
//	1. Sample Count: lm_cdb_sample_3logn + 3*log2 (interation_count)
// 	2. icnt is the concatenation icnt0 through icnt3
//--------------------------------------------------------------------

   assign icnt = ({icnt3,icnt2,icnt1,icnt0});

   always @*
     begin

	casez(icnt)
	  31'b 0000000000000000000000000000000: sample_cnt = 8'd0;
	  31'b 0000000000000000000000000000001: sample_cnt = ({2'd0,lm_cdb_sample_3logn} + 8'd3);
	  31'b 000000000000000000000000000001?: sample_cnt = ({2'd0,lm_cdb_sample_3logn} + 8'd6);
	  31'b 00000000000000000000000000001??: sample_cnt = ({2'd0,lm_cdb_sample_3logn} + 8'd9);
	  31'b 0000000000000000000000000001???: sample_cnt = ({2'd0,lm_cdb_sample_3logn} + 8'd12);
	  31'b 000000000000000000000000001????: sample_cnt = ({2'd0,lm_cdb_sample_3logn} + 8'd15);
	  31'b 00000000000000000000000001?????: sample_cnt = ({2'd0,lm_cdb_sample_3logn} + 8'd18);
	  31'b 0000000000000000000000001??????: sample_cnt = ({2'd0,lm_cdb_sample_3logn} + 8'd21);
	  31'b 000000000000000000000001???????: sample_cnt = ({2'd0,lm_cdb_sample_3logn} + 8'd24);
	  31'b 00000000000000000000001????????: sample_cnt = ({2'd0,lm_cdb_sample_3logn} + 8'd27);
	  31'b 0000000000000000000001?????????: sample_cnt = ({2'd0,lm_cdb_sample_3logn} + 8'd30);
	  31'b 000000000000000000001??????????: sample_cnt = ({2'd0,lm_cdb_sample_3logn} + 8'd33);
	  31'b 00000000000000000001???????????: sample_cnt = ({2'd0,lm_cdb_sample_3logn} + 8'd36);
	  31'b 0000000000000000001????????????: sample_cnt = ({2'd0,lm_cdb_sample_3logn} + 8'd39);
	  31'b 000000000000000001?????????????: sample_cnt = ({2'd0,lm_cdb_sample_3logn} + 8'd42);
	  31'b 00000000000000001??????????????: sample_cnt = ({2'd0,lm_cdb_sample_3logn} + 8'd45);
	  31'b 0000000000000001???????????????: sample_cnt = ({2'd0,lm_cdb_sample_3logn} + 8'd48);
	  31'b 000000000000001????????????????: sample_cnt = ({2'd0,lm_cdb_sample_3logn} + 8'd51);
	  31'b 00000000000001?????????????????: sample_cnt = ({2'd0,lm_cdb_sample_3logn} + 8'd54);
	  31'b 0000000000001??????????????????: sample_cnt = ({2'd0,lm_cdb_sample_3logn} + 8'd57);
	  31'b 000000000001???????????????????: sample_cnt = ({2'd0,lm_cdb_sample_3logn} + 8'd60);
	  31'b 00000000001????????????????????: sample_cnt = ({2'd0,lm_cdb_sample_3logn} + 8'd63);
	  31'b 0000000001?????????????????????: sample_cnt = ({2'd0,lm_cdb_sample_3logn} + 8'd66);
	  31'b 000000001??????????????????????: sample_cnt = ({2'd0,lm_cdb_sample_3logn} + 8'd69);
	  31'b 00000001???????????????????????: sample_cnt = ({2'd0,lm_cdb_sample_3logn} + 8'd72);
	  31'b 0000001????????????????????????: sample_cnt = ({2'd0,lm_cdb_sample_3logn} + 8'd75);
	  31'b 000001?????????????????????????: sample_cnt = ({2'd0,lm_cdb_sample_3logn} + 8'd78);
	  31'b 00001??????????????????????????: sample_cnt = ({2'd0,lm_cdb_sample_3logn} + 8'd81);
	  31'b 0001???????????????????????????: sample_cnt = ({2'd0,lm_cdb_sample_3logn} + 8'd84);
	  31'b 001????????????????????????????: sample_cnt = ({2'd0,lm_cdb_sample_3logn} + 8'd87);
	  31'b 01?????????????????????????????: sample_cnt = ({2'd0,lm_cdb_sample_3logn} + 8'd90);
	  31'b 1??????????????????????????????: sample_cnt = ({2'd0,lm_cdb_sample_3logn} + 8'd93);
	  default: sample_cnt = 8'd0;
	endcase
     end

//--------------------------------------------------------------------
// Sample Count Saturation
//--------------------------------------------------------------------
// Sample Count is Saturated
//	1. Whenever sample_cnt is equal to the programmable threshold
//	   Default value is 8'd129. It is expected to always have the default value ie.,
//	   for any value of eyesurf_time_preg (between 11 and 15), the maximum sample_cnt
//	   will reach 8'd129 (instead of 8'd127). Hence sample_cnt needs to be checked
//	   with 8'd129. In order to have debug capability, this value is kept programmable.
//
// Based on RTL Review, the below condition is updated to have '>=' instead of '=='
// so that if the Spec limit/formula is updated, then it would help to easier to update 
// the programmable value. It also provides the extra controlabiity on the sample
// count threshould. This update is based on SER-9496.
//--------------------------------------------------------------------

   always @(posedge pipe_mac2phy_clk or negedge pipe_mac2phy_rstn)
     begin
	if (~pipe_mac2phy_rstn)
	  sample_cnt_saturated <= 1'b0;
	else if (ctrl_soft_reset | sample_cnt_rst)
	  sample_cnt_saturated <= 1'b0;
	else if (saturation_update)
	  sample_cnt_saturated <= (sample_cnt >= lm_cdb_sample_threshold);
     end

//--------------------------------------------------------------------
// Sample Count Loading into mac_reg001
//--------------------------------------------------------------------
// mac_reg001 is loaded with Sample Count
//	1. Whenever PMA Rx margining finished an iteration and icnt is
//	   updated, then the new value needs to be updated in sample counter.
//	   Sample count is updated when mrgn_cnt_update is asserted.
// mac_reg001 is reset 
//	1. Via a sample_cnt_rst
//--------------------------------------------------------------------


   always @(posedge pipe_mac2phy_clk or negedge pipe_mac2phy_rstn)
     begin
	if (~pipe_mac2phy_rstn)
	  mac_reg001 <= 8'd0;
	else if (ctrl_soft_reset | sample_cnt_rst)
	  mac_reg001 <= 8'd0;
	else if (mrgn_cnt_update)
	  begin
	     if (sample_cnt_saturated)
	       mac_reg001 <= lm_cdb_sample_max;
	     else
	       mac_reg001 <= sample_cnt;
	  end
     end

//--------------------------------------------------------------------
// Error Count Calculation
//--------------------------------------------------------------------
// At the end of each rx margining PMA will provide the error count. This error count
// shall be added to the existing error count until the lane margining request is 
// disabled or new lane margining request is sent from MAC. 
// PCIe base specification rev 4.0 ver 0.7, Table 4-19 states that MErrorCount is 6-bits
// but the Table 9-10 states that max value could be 4'd15 PIPE Spec defines the error 
// count field in the PIPE register with 6-bits. Hence PHY implements 6-bits of error
// counter and the error counter will sature when it reaches 6'd63 even though MAC
// will need to report 4'd15 when the error count from the PHY is >= 6'd15. 
// Hence implementation point of view, PHY will keep continuing until the error count
// reaches 6'd63 and then saturates until MAC issues error count reset or new lane
// margining command.
//--------------------------------------------------------------------


//--------------------------------------------------------------------
// Error Count 
//--------------------------------------------------------------------
// Error Count is loaded
// 	1. Whenever PMA has finished rx margining, add the current error count with the 
// 	   new error count coming from PMA tx/rx controller. Here the error count needs
//	   to be checked for over flow condition. For example, while the error count is
//	   6'd62 and the new incoming error count (lm_pma_errcnt) is 6'd5, then the total
//         would be more than 6'd63. In order to take care of this situation, the error
//         count is pre-calculated and checked for saturation condition so that the 
//	   actual error count is stored with 6'd63 or sum of older value and lm_pma_errcnt.
//	   error_cnt_write_en is asserted 1-cycle later than tx_pma_write_en so that the 
//	   error_cnt sum shall be calculated and be ready in the next cycle (as adder
//	   might take some delay) and in the next cycle the final error count is loaded.
// Error Count is reset
//	1. Whenever new margin request is received or MAC issues error count reset
//	2. Software initiated soft reset
//--------------------------------------------------------------------

   assign error_cnt_write_en  = (update_cnt == 3'd1);
   
   always @(posedge pipe_mac2phy_clk or negedge pipe_mac2phy_rstn)
     begin
	if (~pipe_mac2phy_rstn)
	  error_cnt <= 7'd0;
	else if (ctrl_soft_reset | error_cnt_rst)
	  error_cnt <= 7'd0;
	else if (error_cnt_write_en)
	  error_cnt <= (error_cnt + {1'b0,lm_pma_errcnt});
     end

//--------------------------------------------------------------------
// Error Count Saturation
//--------------------------------------------------------------------
// Error Count is Saturated
//	1. Whenever error_cnt is equal to the programmable threshold. The
//	   default value is 6'd63. It is expected that error count threshold
//	   and maximum values will be the same. There is no use case for the error 
//	   count threshold and maximum values to be different (like sample count). 
//	   In order to have debug capability, these values are programmable.
//
// Based on RTL Review, the below condition is updated to have '>=' instead of '=='
// so that if the Spec limit/formula is updated, then it would help to easier to update 
// the programmable value. It also provides the extra controlabiity on the
// error count threshould. This update is based on SER-9496.
//--------------------------------------------------------------------
   
   always @(posedge pipe_mac2phy_clk or negedge pipe_mac2phy_rstn)
     begin
	if (~pipe_mac2phy_rstn)
	  error_cnt_saturated <= 1'b0;
	else if (ctrl_soft_reset | error_cnt_rst)
	  error_cnt_saturated <= 1'b0;
	else if (saturation_update)
	  error_cnt_saturated <= (error_cnt >= {1'b0,lm_cdb_error_threshold});
     end


//--------------------------------------------------------------------
// Error Count Loading into mac_reg002
//--------------------------------------------------------------------
// mac_reg002 is loaded with Error Count
//	1. Whenever PMA Rx margining finished an iteration, lm_pma_errcnt is
//	   available, then this new value needs to be updated in error counter.
//	   Error count is updated when mrgn_cnt_update is asserted.
// mac_reg002 is reset 
//	1. Whenever Error Count Reset or New Margin command is issued by the MAC
//--------------------------------------------------------------------
   
   always @(posedge pipe_mac2phy_clk or negedge pipe_mac2phy_rstn)
     begin
	if (~pipe_mac2phy_rstn)
	  mac_reg002 <= 8'd0;
	else if (ctrl_soft_reset | error_cnt_rst)
	  mac_reg002 <= 8'd0;
	else if (mrgn_cnt_update)
	  begin
	     if (error_cnt_saturated)
	       mac_reg002 <= {2'b0,lm_cdb_error_max};
	     else
	       mac_reg002 <= {1'b0,error_cnt};
	  end
     end

//--------------------------------------------------------------------
// Margin Status Loading into mac_reg000
//--------------------------------------------------------------------
// As per PIPE Spec 5.2, Section 7.2.1 the following has to be performed whenever a new
// margining command is received from the MAC
//
// 1. Margin Status: This has to be set by the PHY to acknowledge a valid change to the
//    Start Margin and Margin Offset. This has to be updated in MAC address space
//    by the PHY via Write Committed Command
//
// Valid Changes:
//--------------------------------------------------------------------
//	a. Margin Voltage/Timing and Direction not changed while Start Margin is '1'
// 	b. Offset outside the supported range
//	c. Offset changed non-monotonically 
// 
// 2. Margin Nak: This has to be set by the PHY to acknowledge an invalid or unsupported
//    Margin Offset during Voltage Margining (Only). This has to be updated in the MAC
//    address space by the PHY via Write Committed Command
//
// PIPE Spec is ambiguous wrt margin status and nak update. In the PHY, Rx margining in
// the PMA happens over multiple iterations. Hence before initiating each iteration, margin
// direction and offset is loaded. Therefore if the direction is changed while start margin
// is asserted, it will not impact the PMA because each time PMA is stopped and started.
// Therefore there is no real need for the NAK to be set wrt our PMA. Due to this reason
// margin status is always '1' and nak is always '0'.
//
//--------------------------------------------------------------------
// mac_reg000 is loaded with Margin Status
//--------------------------------------------------------------------
//	1. Margin Status is updated when the offset or start-margin bits change
//--------------------------------------------------------------------
// mac_reg000 is reset 
//--------------------------------------------------------------------
//	1. Whenever the PHY finished sending write uncommitted/committed as part of
//	   its status update, then this register will be cleared.
//--------------------------------------------------------------------

   always @(posedge pipe_mac2phy_clk or negedge pipe_mac2phy_rstn)
     begin
	if (~pipe_mac2phy_rstn)
	  mac_reg000 <= 8'd0;
	else if (ctrl_soft_reset | prio_tx_writes_done_lm[3] | prio_tx_writes_done_lm[1] | prio_tx_writes_done_lm[0])
	  mac_reg000 <= 8'd0;
	else if (posedge_start_margin | stop_mrgn_done | (mrgn_offset_change))
	  mac_reg000 <= 8'h01;
     end
   
//--------------------------------------------------------------------
// Elasticity Buffer Status Loading into mac_reg003
//--------------------------------------------------------------------
// mac_reg003 is loaded with Elasticity Buffer Status
//	1. Whenever lm_eb_sts_upd is asserted and lm_eb_sts is loaded into 
//	   the mac_reg003
// mac_reg0 is reset 
//	1. Whenever the PHY finished sending write committed for updating the EB Buffer
//         status update, then this register will be cleared.
//--------------------------------------------------------------------
   
   always @(posedge pipe_mac2phy_clk or negedge pipe_mac2phy_rstn)
     begin
	if (~pipe_mac2phy_rstn)
	  mac_reg003 <= 8'd0;
	else if (ctrl_soft_reset | prio_tx_writes_done_sts)
	  mac_reg003 <= 8'd0;
	else if (lm_eb_sts_upd)
	  mac_reg003 <= lm_eb_sts;
     end

endmodule

