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
//   Module Name    : cdnsdru_usb4_message_bus_allfslf_wr_v4
//
//   Author         : Dongdong Wang
//
//   Date           : July 23, 2025
//
//   Limitations    :
//
//   Notes          : Based on cdnsdru_pcie_message_bus_allfslf_wr_v4 authored by Thomas Faison
//---------------------------------------------------------------------------------
//   Description    :	Quick-write-request module for post-reset FSLF: Writes to
//                      MAC usually require phy2mac and mac2phy handshakes, which
//                      makes the process too slow after reset. So we will generate
//                      requests in the phy2mac domain for this case since we know
//                      exactly what we want to write.
//
//---------------------------------------------------------------------------------

module cdnsdru_usb4_message_bus_allfslf_wr_v4 (

input         pipe_phy2mac_clk,		// PHY: MB Clock based on PIPE interface data width --> 500MHz (32-bit) or 1GHz (16-bit)
input         pipe_phy2mac_rstn,	// PHY: MB Reset. Active Low

input [3:0]   pipe_rate,

input         tx_local_fs_lf_valid,
input [5:0]   local_fs_g67,
input [5:0]   local_lf_g67,
input [5:0]   local_fs_legacy,
input [5:0]   local_lf_legacy,

input         mb_tx_cmd_req_phy2mac_sync,	// GRC: Command transmit request
input         mb_tx_ack_req_phy2mac_sync,	// GRC: ACK transmit request
input         mb_pipe_tx_disable,		// PHY (via sync): disable TX

input [23:0]  mb_tx_bus_values_r0,	// GRC: Transmit Command values

output        p2m_mb_tx_cmd_req,	// TX Controller: Command Transmission Request
output        p2m_mb_tx_ack_req,	// TX Controller: ACK Transmission Request
output [23:0] p2m_mb_tx_bus_values_r0,	// TX Controller: Transmit Command values

output reg    wait_for_valid,		// Coef regs: Tell coef block to wait for valid (now obsolete; always 0)
output reg    allfslf_sent		// Coef regs: Tell coef block reset fslf sent

);

//FIXME: remove unneeded variables. Make sure pipe rate lasts long enough for this FSM.
   localparam IDLE = 4'h0;
   localparam SENDFS0 = 4'h1;
   localparam SENDLF0 = 4'h2;
   localparam SENDFS4 = 4'h3;
   localparam SENDLF4 = 4'h4;
   localparam SENDFS5 = 4'h5;
   localparam SENDLF5 = 4'h6;
   localparam SENDFS6 = 4'h7;
   localparam SENDLF6 = 4'h8;
   localparam NOVALID0 = 4'h9;
   localparam NOVALID1 = 4'hA;

   localparam LAST_CNT = 3'h5;

   reg        rst_det;
   reg        rst_pos_det;
   reg        send_cnt_en;
   reg [2:0]  send_cnt;
   wire       allfslf_trigger;
   reg 	      allfslf_sent_comb;
   reg [3:0]  get_allfslf_next_state;
   reg [3:0]  get_allfslf_state;
   reg        allfslf_mb_tx_cmd_req;
   reg [3:0]  allfslf_mb_tx_command;
   reg [7:0]  allfslf_mb_tx_data;
   reg [11:0] allfslf_mb_tx_address;
   reg [3:0]  trig_dly_cnt;
   reg 	      tx_local_fs_lf_valid_seen;
   wire       tx_local_fs_lf_valid_phy2mac_sync;
   reg 	      ack_req_out;
   reg 	      mb_tx_ack_req_phy2mac_sync_d1;


   // Sync for valid signal
   phy_data_sync #(.NUM_FLOPS(2)) u_tx_local_fs_lf_valid_phy2mac_sync (
     .clock    (pipe_phy2mac_clk),
     .reset_n  (pipe_phy2mac_rstn),
     .d_in     (tx_local_fs_lf_valid),
     .d_out    (tx_local_fs_lf_valid_phy2mac_sync)
     );

   assign allfslf_trigger = (trig_dly_cnt == 4'h7);

   // End-of-reset detector used for the all-FSLF trigger
   // The detection is asserted by reset, and cleared when the trigger actually occurs.
   always @(posedge pipe_phy2mac_clk or negedge pipe_phy2mac_rstn)
     begin
	if (~pipe_phy2mac_rstn)
	  begin
	     rst_det <= 1'b1;
	     rst_pos_det <= 1'b0;
	  end
	else
	  begin
	     if (allfslf_trigger) rst_det <= 1'b0;
	     else rst_det <= rst_det;
	     rst_pos_det <= rst_det;
	  end
     end

   //Delay post-reset trigger by 8 clocks. Look for valids to occur during this time.
   always @(posedge pipe_phy2mac_clk or negedge pipe_phy2mac_rstn)
     begin
	if (~pipe_phy2mac_rstn)
	  begin
	     trig_dly_cnt <= 4'h0;
	     tx_local_fs_lf_valid_seen <= 1'b0;
	  end
	else
	  begin
	     if (trig_dly_cnt == 4'h8) trig_dly_cnt <= 4'h8;
	     else if (rst_pos_det | (|trig_dly_cnt[2:0])) trig_dly_cnt <= trig_dly_cnt + 4'h1;
	     else trig_dly_cnt <= 4'h0;

	     tx_local_fs_lf_valid_seen <= tx_local_fs_lf_valid_seen | tx_local_fs_lf_valid_phy2mac_sync;

	  end
     end


//--------------------------------------------------------------------
// Combine allfslf write requests with synced gen_reg_ctrl write requests
// Gate off any special ACK requests during allfslf non-IDLE
//--------------------------------------------------------------------

// Detect toggle and convert to pulse
   always @(posedge pipe_phy2mac_clk or negedge pipe_phy2mac_rstn)
     begin
	if (~pipe_phy2mac_rstn)
	  begin
	     ack_req_out <= 1'b0;
	     mb_tx_ack_req_phy2mac_sync_d1 <= 1'b0;
	  end
	else
	  begin
	     mb_tx_ack_req_phy2mac_sync_d1 <= mb_tx_ack_req_phy2mac_sync;
	     ack_req_out <= mb_tx_ack_req_phy2mac_sync_d1 ^ mb_tx_ack_req_phy2mac_sync;
	  end
     end
assign p2m_mb_tx_ack_req = (get_allfslf_state == IDLE) & ack_req_out;


assign p2m_mb_tx_cmd_req = (allfslf_mb_tx_cmd_req | mb_tx_cmd_req_phy2mac_sync) & (~mb_pipe_tx_disable);
assign p2m_mb_tx_bus_values_r0[3:0] = allfslf_mb_tx_command | mb_tx_bus_values_r0[3:0];
assign p2m_mb_tx_bus_values_r0[23:16] = allfslf_mb_tx_data | mb_tx_bus_values_r0[23:16];
assign p2m_mb_tx_bus_values_r0[15:4] = allfslf_mb_tx_address | mb_tx_bus_values_r0[15:4];

//--------------------------------------------------------------------
// State machine to generate P2M wite requests
//
// When the allfslf_trigger occurs, send up to three sets of FS/LF write
// requests to the TX block (one for each FS/LF rate). All six writes
// should occur as quickly as possible with no interruption.
//--------------------------------------------------------------------


   // Send counter, controlled by the FSM.
   always @(posedge pipe_phy2mac_clk or negedge pipe_phy2mac_rstn)
     begin
	if (~pipe_phy2mac_rstn)
	  begin
	     send_cnt <= 3'h0;
	  end
	else if (~send_cnt_en)
	  begin
	     send_cnt <= 3'h0;
	  end
	else
	  begin
	     send_cnt <= send_cnt + 3'h1;
	  end
     end

   // FSM state flops
   always @(posedge pipe_phy2mac_clk or negedge pipe_phy2mac_rstn)
     begin
	if (~pipe_phy2mac_rstn)
	  begin
	     get_allfslf_state <= 4'h0;
	  end
	else
	  begin
	     get_allfslf_state <= get_allfslf_next_state;
	  end
     end

   // Flop allfslf-sent indicator
   always @(posedge pipe_phy2mac_clk or negedge pipe_phy2mac_rstn)
     begin
	if (~pipe_phy2mac_rstn)
	  begin
	     allfslf_sent <= 1'b0;
	  end
	else
	  begin
	     allfslf_sent <= allfslf_sent_comb;
	  end
     end


   // FSM next-state logic and associated combinational signals
   always @*
     begin
	get_allfslf_next_state = 4'h0;
	send_cnt_en = 1'b1;
	allfslf_sent_comb = 1'b0;
	allfslf_mb_tx_cmd_req = 1'b1;
	allfslf_mb_tx_command = 4'h0;
	allfslf_mb_tx_data = 8'h00;
	allfslf_mb_tx_address = 12'h000;
	wait_for_valid = 1'b0;

	case (get_allfslf_state)

	  // Wait for trigger+valid. If we just get trigger then start waiting for valid.
	  IDLE:
	    begin
	       send_cnt_en = 1'b0;
	       allfslf_mb_tx_cmd_req = 1'b0;
	       if (allfslf_trigger & (tx_local_fs_lf_valid_phy2mac_sync | tx_local_fs_lf_valid_seen)) get_allfslf_next_state = SENDFS0;
	       else if (allfslf_trigger) get_allfslf_next_state = NOVALID0;
	       else get_allfslf_next_state = IDLE;
	    end

	  // Wait for valid
	  NOVALID0:
	    begin
	       send_cnt_en = 1'b0;
	       allfslf_mb_tx_cmd_req = 1'b0;
	       if (tx_local_fs_lf_valid_phy2mac_sync | tx_local_fs_lf_valid_seen) get_allfslf_next_state = SENDFS0;
	       else get_allfslf_next_state = NOVALID0;
	    end

	  // Send FS and protocol bytes to the TX block for MB transmission
	  SENDFS0:
	    begin
	       allfslf_mb_tx_command = 4'h1;

	       //Set data value based on rate
	       if (pipe_rate == 4'b0101) allfslf_mb_tx_data = {2'b00, local_fs_g67};
	       else allfslf_mb_tx_data = {2'b00,local_fs_legacy};

	       //Set address value based on rate
	       if (pipe_rate == 4'b0011) allfslf_mb_tx_address = `MAC_TX_STAT_5;
	       else if (pipe_rate == 4'b0100) allfslf_mb_tx_address = `MAC_RX_STAT_4;
	       else if (pipe_rate == 4'b0101) allfslf_mb_tx_address = `MAC_TX_STAT_8;
	       else allfslf_mb_tx_address = `MAC_TX_STAT_3;

	       if (send_cnt == LAST_CNT) 
		 begin
		    get_allfslf_next_state = SENDLF0;
		    send_cnt_en = 1'b0;
		    allfslf_mb_tx_cmd_req = 1'b0;
		 end
	       else
		 begin
		    get_allfslf_next_state = SENDFS0;
		 end
	       if ((send_cnt == (LAST_CNT - 3'h2)) || (send_cnt == (LAST_CNT - 3'h3)))
		 allfslf_sent_comb = 1'b1;
	       else
		 allfslf_sent_comb = 1'b0;
	    end

	  // Send LF and protocol bytes to the TX block for MB transmission
	  SENDLF0:
	    begin

	       //Set data value based on rate
	       if (pipe_rate == 4'b0101) allfslf_mb_tx_data = {2'b00,local_lf_g67};
	       else allfslf_mb_tx_data = {2'b00,local_lf_legacy};

	       //Set address value based on rate
	       if (pipe_rate == 4'b0011) allfslf_mb_tx_address = `MAC_TX_STAT_6;
	       else if (pipe_rate == 4'b0100) allfslf_mb_tx_address = `MAC_RX_STAT_5;
	       else if (pipe_rate == 4'b0101) allfslf_mb_tx_address = `MAC_TX_STAT_9;
	       else allfslf_mb_tx_address = `MAC_TX_STAT_4;
	       allfslf_mb_tx_command = 4'h2;
	       if (send_cnt == LAST_CNT)
		 begin
		    get_allfslf_next_state = IDLE;
		    send_cnt_en = 1'b0;
		    allfslf_mb_tx_cmd_req = 1'b0;
		 end
	       else
		 begin
		    get_allfslf_next_state = SENDLF0;
		 end
	    end

	  default:
	    begin
	       get_allfslf_next_state = IDLE;
	    end
	endcase

     end

endmodule
