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
//   Module Name    : cdnsdru_usb4_message_bus_preset_coef_regs_v4
//
//   Author         : Dongdong Wang
//
//   Date           : July 23, 2025
//
//   Limitations    :
//
//   Notes          : Based on cdnsdru_pcie_message_bus_preset_coef_regs_v4 authored by Thomas Faison
//---------------------------------------------------------------------------------
//   Description    :	Preset Coefficient Controller Module
//			This module is co-ordinates the
//			coefficient registers and accesses to the MAC.
//			It also handles the FS/LF registers.
//
//---------------------------------------------------------------------------------

module cdnsdru_usb4_message_bus_preset_coef_regs_v4 (

input			pipe_mac2phy_clk,		// PHY: MB Clock based on PIPE interface data width --> 500MHz (32-bit) or 1GHz (16-bit)
input			pipe_mac2phy_rstn,		// PHY: MB Reset. Active Low
input			pipe_phy2mac_clk, 	       	// PHY MB PHY2MAC Clock: Based on PIPE interface data width --> 500MHz (32-bit) or 1GHz (16-bit)
input			pipe_phy2mac_rstn,		// PHY MB PHY2MAC Reset: Active Low
input			mb_enable,			// PHY: MB Enable when PCIe Gen4 and P0 state

input			cdb_reset,			// PHY CDB: Soft Reset for entire MB block including all sub-blocks
input			cdb_ctrl_reset,			// PHY CDB: Soft Reset for entire MB Controller


input			tx_coef_valid_mac2phy_sync,	// PCS: Coefficient valid signal
input [6:0]		prio_tx_writes_done_coef,	// MB Reg Controller: Command Transmitted Acknowledgement
input			tx_get_local_preset_coef,       // MB Reg Controller: Register bit from PHY TX Control5
input [3:0]		pipe_rate_mac2phy_sync,		// PIPE rate bus
input                   tx_local_fs_lf_valid,
input [5:0]             local_fs_g67,                    // PCS: FS
input [5:0]             local_lf_g67,                    // PCS: LF
input [5:0]             local_fs_legacy,                // PCS: FS
input [5:0]             local_lf_legacy,                // PCS: LF
input [5:0] 		tx_local_preset_index,          // MB Reg Controller: local preset index field
//input 			rx_write_ack,			// MB Reg Controller: indication (from RX) that MAC has ACKed P2M write
//input 			fslf_sent,			// MB Reg Controller: indication that fslf pair sent to MAC
//input 			g4fslf_sent,			// MB Reg Controller: indication that g4fslf pair sent to MAC
//input 			g5fslf_sent,			// MB Reg Controller: indication that g5fslf pair sent to MAC
//input 			g67fslf_sent,			// MB Reg Controller: indication that g5fslf pair sent to MAC
input 			wait_for_valid_mac2phy_sync,	// From allfslf: Post-reset-fslf not sent due to low valid
input 			allfslf_sent_mac2phy_sync,	// MB Reg Controller: indication that all fslf pairs sent to MAC
input 			pcs_pipe_lnn_clk_out_en_sync,   // PHY (via reset synchronizer) lane-wise clock out enable

output  		pclk64_rate_change,	        // MB Reg Controller: Rate has changed to 64GT (or higher) (to clear PAM4RL bit)
output  		g67rate,			// MB Reg Controller: Index shows rate of G67

output reg 		coef_legacy_tx_write,		// MB Reg Controller: TX Write request
output reg 		coef_g67_tx_write,		// MB Reg Controller: TX Write request
output  		cofslf_tx_write,	        // MB Reg Controller: TX Write request
output  		cog4fslf_tx_write,	        // MB Reg Controller: TX Write request
output  		cog5fslf_tx_write,	        // MB Reg Controller: TX Write request
output reg 		fslf_tx_write,		        // MB Reg Controller: TX Write request
output reg 		g4fslf_tx_write,	        // MB Reg Controller: TX Write request
output reg 		g5fslf_tx_write,	        // MB Reg Controller: TX Write request
output reg 		g67fslf_tx_write,	        // MB Reg Controller: TX Write request
output reg [7:0]        local_fs_reg,                   // PCS: FS
output reg [7:0]        local_lf_reg                   // PCS: LF
//output reg 		physt_trig                      // PCS: trigger for phystatus response to rate change
);

//--------------------------------------------------------------------
// FSM Parameters
//--------------------------------------------------------------------

   localparam COEF_IDLE		= 2'b00;
   localparam COEF_VLD_CHK	= 2'b01;
   localparam COEF_WRITE_HI_START  = 2'b10;
   localparam COEF_WRITE_HI	= 2'b11;

   localparam FSLF_IDLE		= 2'b00;
   localparam FSLF_WAIT_FOR_CLK_EN = 2'b01;
   localparam FSLF_WAIT_FOR_VALID = 2'b11;
   localparam FSLF_WRITE_HI	= 2'b10;

   localparam FSLF_PHYST_IDLE	= 2'b00;
   localparam FSLF_PHYST_SENT	= 2'b01;
   localparam FSLF_PHYST_WAIT	= 2'b10;
   localparam FSLF_PHYST_TRIG	= 2'b11;


//--------------------------------------------------------------------
// Local Variables
//--------------------------------------------------------------------

   reg 			tx_get_local_preset_coef_reg;
   reg [1:0] 		get_coef_state;
   reg [1:0] 		get_coef_next_state;
   reg 			clk_en_det;
   reg 			clk_en_det_d1;
   
   wire 		coef_trigger;
   wire 		g3rate;
   wire 		g4rate;
   wire 		g5rate;
   wire 		g345rate;
   wire 		g6rate;
   wire 		g7rate;

   reg 			reset_detect;
   reg 			reset_detect_d1;
   wire 		posedge_reset_detect;
   wire 		clk_en_rise;

   wire 		pclk8_rate;
   wire			pclk16_rate;
   wire			pclk32_rate;
   wire			pclk64_rate;
   wire 		pclk8_rate_change;
   wire			pclk16_rate_change;
   wire			pclk32_rate_change;
   reg 			pclk8_rate_d1;
   reg			pclk16_rate_d1;
   reg			pclk32_rate_d1;
   reg			pclk64_rate_d1;

   reg [1:0] 		get_fslf_state;
   reg [1:0] 		get_fslf_next_state;
   wire 		fslf_trigger;

   reg [1:0] 		get_g4fslf_state;
   reg [1:0] 		get_g4fslf_next_state;
   wire 		g4fslf_trigger;

   reg [1:0] 		get_g5fslf_state;
   reg [1:0] 		get_g5fslf_next_state;
   wire 		g5fslf_trigger;

   reg [1:0] 		get_g67fslf_state;
   reg [1:0] 		get_g67fslf_next_state;
   wire 		g67fslf_trigger;

   reg 			postrst_allfslf_done;

   //reg [1:0] 		physt_trig_state;
   reg [1:0] 		physt_trig_next_state;

   wire 		tx_local_fs_lf_valid_mac2phy_sync;

// Sync for valid signal
phy_data_sync #(.NUM_FLOPS(5)) u_tx_local_fs_lf_valid_mac2phy_sync (
   .clock    (pipe_mac2phy_clk),
   .reset_n  (pipe_mac2phy_rstn),
   .d_in     (tx_local_fs_lf_valid),
   .d_out    (tx_local_fs_lf_valid_mac2phy_sync)
   );

//--------------------------------------------------------------------
// This block will be reset when any one of the followign conditions
// are true
// 1. MB soft reset (Software)
// 2. MB Block level soft reset (Software)
//--------------------------------------------------------------------

   assign ctrl_soft_reset = (~mb_enable | cdb_reset | cdb_ctrl_reset);


//--------------------------------------------------------------------
// Detect request for coefficients and generate coef_tx_write
//
// If the PHY GetLocalPresetCoefficients bit is asserted then we will
// trigger a burst of writes to the MAC containing Local_fs_g67/LF and
// LocalTxPresetCoefficients
//--------------------------------------------------------------------

   always @(posedge pipe_mac2phy_clk or negedge pipe_mac2phy_rstn)
     begin
	if (~pipe_mac2phy_rstn)
	  tx_get_local_preset_coef_reg <= 1'b0;
   	else if (ctrl_soft_reset)
	  tx_get_local_preset_coef_reg <= 1'b0;
	else
	  tx_get_local_preset_coef_reg <= tx_get_local_preset_coef;
     end


   // Detect rising edge of GetLocalPresetCoefficients 
   assign coef_trigger = tx_get_local_preset_coef & ~tx_get_local_preset_coef_reg;
   
   // Determine which registers should be written out when GetLocalPresetCoefficients is set
   // (i.e. coef alone, or coef+fs+lf, or coef+g4fs+g4lf, or coef+g5fs+g5lf)

   assign g3rate = (tx_local_preset_index <= 6'hA);
   assign g4rate = (tx_local_preset_index > 6'hA) && (tx_local_preset_index <= 6'h15);
   assign g5rate = (tx_local_preset_index > 6'h15) && (tx_local_preset_index <= 6'h20);
   assign g6rate = (tx_local_preset_index > 6'h20) && (tx_local_preset_index <= 6'h2C);
   assign g7rate = (tx_local_preset_index > 6'h2C) && (tx_local_preset_index <= 6'h37);

   assign g345rate = g3rate | g4rate | g5rate;
   assign g67rate = g6rate | g7rate;

   //FIXME remove eventually along w/IO
   assign cofslf_tx_write = 1'b0;
   assign cog4fslf_tx_write = 1'b0;
   assign cog5fslf_tx_write = 1'b0;

   // State machine to generate coef_tx_write
   always @(posedge pipe_mac2phy_clk or negedge pipe_mac2phy_rstn)
     begin
	if (~pipe_mac2phy_rstn)
	  get_coef_state <= 2'b00;
   	else if (ctrl_soft_reset)
	  get_coef_state <= 2'b00;
	else
	  get_coef_state <= get_coef_next_state;
     end

   always @*
     begin
	get_coef_next_state = 2'b00;

	case (get_coef_state)

	  //Start cycle based on trigger
	  COEF_IDLE:
	    begin
	       coef_legacy_tx_write = 1'b0;
	       coef_g67_tx_write = 1'b0;
	       if (coef_trigger)
		 get_coef_next_state = COEF_VLD_CHK;
	       else
		 get_coef_next_state = COEF_IDLE;
	    end

	  // Wait until coefs are valid. If another M2P write is committed before the valid is
	  // signalled, then abort the coefficient transmission.
	  COEF_VLD_CHK:
	    begin
	       coef_legacy_tx_write = 1'b0;
	       coef_g67_tx_write = 1'b0;
	       if (tx_coef_valid_mac2phy_sync)
		 get_coef_next_state =  COEF_WRITE_HI_START;
	       else
		 get_coef_next_state = COEF_VLD_CHK;
	       
	    end

	  // Assert appropriate coef*_tx_write
	  COEF_WRITE_HI_START:
	    begin
	       if (g345rate)
		 begin
		    coef_legacy_tx_write = 1'b1;
		    coef_g67_tx_write = 1'b0;
		 end
	       else if (g67rate)
		 begin
		    coef_legacy_tx_write = 1'b0;
		    coef_g67_tx_write = 1'b1;
		 end
	       else
		 begin
		    coef_legacy_tx_write = 1'b1;
		    coef_g67_tx_write = 1'b0;
		 end
	       get_coef_next_state = COEF_WRITE_HI;
	    end

	  // De-assert coef_tx_write when count is complete
	  COEF_WRITE_HI:
	    begin
	       if (g345rate)
		 begin
		    coef_legacy_tx_write = 1'b1;
		    coef_g67_tx_write = 1'b0;
		    if (prio_tx_writes_done_coef[0])
		      begin
			 get_coef_next_state = COEF_IDLE;
		      end
		    else
		      begin
			 get_coef_next_state = COEF_WRITE_HI;
		      end
		 end
	       else if (g67rate)
		 begin
		    coef_legacy_tx_write = 1'b0;
		    coef_g67_tx_write = 1'b1;
		    if (prio_tx_writes_done_coef[1])
		      begin
			 get_coef_next_state = COEF_IDLE;
		      end
		    else
		      begin
			 get_coef_next_state = COEF_WRITE_HI;
		      end
		 end
	       else
		 begin
		    coef_legacy_tx_write = 1'b1;
		    coef_g67_tx_write = 1'b0;
		    if (prio_tx_writes_done_coef[0])
		      begin
			 get_coef_next_state = COEF_IDLE;
		      end
		    else
		      begin
			 get_coef_next_state = COEF_WRITE_HI;
		      end
		 end
	    end     
	  default:
	    begin
	       coef_legacy_tx_write = 1'b0;
	       coef_g67_tx_write = 1'b0;
	       get_coef_next_state = COEF_IDLE;
	    end
	endcase
     end

//--------------------------------------------------------------------
// Detect reset edge and rate changes. These will be used to
// trigger FS/LF-related P2M register write requests.
//--------------------------------------------------------------------

   // End-of-reset detector. This will be used for the all-FSLF request.
   always @(posedge pipe_mac2phy_clk or negedge pipe_mac2phy_rstn)
     begin
	if (~pipe_mac2phy_rstn)
	  begin
	     reset_detect <= 1'b0;
	     reset_detect_d1 <= 1'b0;
	  end
	else
	  begin
	     reset_detect <= 1;
	     reset_detect_d1 <= reset_detect;
	  end
     end

   // PIPE-rate change detector. This will be used for the individual
   // FSLF requests.

   assign pclk8_rate = (pipe_rate_mac2phy_sync == 4'b0010);
   assign pclk16_rate = (pipe_rate_mac2phy_sync == 4'b0011);
   assign pclk32_rate = (pipe_rate_mac2phy_sync == 4'b0100);
   assign pclk64_rate = (pipe_rate_mac2phy_sync == 4'b0101);

   // Maintain previous states to detect changes
   always @(posedge pipe_mac2phy_clk or negedge pipe_mac2phy_rstn)
     begin
	if (~pipe_mac2phy_rstn)
	  begin
	     pclk8_rate_d1 <= 1'b0;
	     pclk16_rate_d1 <= 1'b0;
	     pclk32_rate_d1 <= 1'b0;
	     pclk64_rate_d1 <= 1'b0;
	  end
	else
	  begin
	     pclk8_rate_d1 <= pclk8_rate;
	     pclk16_rate_d1 <= pclk16_rate;
	     pclk32_rate_d1 <= pclk32_rate;
	     pclk64_rate_d1 <= pclk64_rate;
	  end
     end

   assign pclk8_rate_change = pclk8_rate & ~pclk8_rate_d1;
   assign pclk16_rate_change = pclk16_rate & ~pclk16_rate_d1;
   assign pclk32_rate_change = pclk32_rate & ~pclk32_rate_d1;
   assign pclk64_rate_change = pclk64_rate & ~pclk64_rate_d1;


//--------------------------------------------------------------------
// Detect the rising edge of the per-lane clock enable. We will use this
// to hold off responding to the rate change until after the clock has
// stopped and restarted.
//--------------------------------------------------------------------

   always @(posedge pipe_mac2phy_clk or negedge pcs_pipe_lnn_clk_out_en_sync)
     begin
	if (~pcs_pipe_lnn_clk_out_en_sync)
	  begin
	     clk_en_det <= 1'b0;
	     clk_en_det_d1 <= 1'b0;
	  end
   	else if (ctrl_soft_reset)
	  begin
	     clk_en_det <= 1'b0;
	     clk_en_det_d1 <= 1'b0;
	  end
	else
	  begin
	     //clk_en_det <= pcs_pipe_lnn_clk_out_en_sync;
	     clk_en_det <= 1'b1;
	     clk_en_det_d1 <= clk_en_det;
	  end
     end
   assign clk_en_rise = clk_en_det & ~clk_en_det_d1;


   // Generate triggering events for *_tx_write state machines.  
`ifdef CDN_TC_MESSAGEBUS
   assign fslf_trigger = 1'b0;
   assign g4fslf_trigger = 1'b0;
   assign g5fslf_trigger = 1'b0;
   assign g67fslf_trigger = 1'b0;
`else
   assign fslf_trigger = (postrst_allfslf_done & pclk8_rate_change);
   assign g4fslf_trigger = (postrst_allfslf_done & pclk16_rate_change);
   assign g5fslf_trigger = (postrst_allfslf_done & pclk32_rate_change);
   assign g67fslf_trigger = (postrst_allfslf_done & pclk64_rate_change);
`endif


   // FSLF tx_write determination
   always @(posedge pipe_mac2phy_clk or negedge pipe_mac2phy_rstn)
     begin
	if (~pipe_mac2phy_rstn)
	  get_fslf_state <= 2'b00;
   	else if (ctrl_soft_reset)
	  get_fslf_state <= 2'b00;
	else
	  get_fslf_state <= get_fslf_next_state;
     end

   always @*
     begin
	get_fslf_next_state = 2'b00;

	case (get_fslf_state)

	  //Start cycle based on trigger
	  FSLF_IDLE:
	    begin
	       fslf_tx_write = 1'b0;
	       if (fslf_trigger & tx_local_fs_lf_valid_mac2phy_sync)
		 get_fslf_next_state = FSLF_WAIT_FOR_CLK_EN;
	       else if (fslf_trigger)
		 get_fslf_next_state = FSLF_WAIT_FOR_VALID;
	       else
		 get_fslf_next_state = FSLF_IDLE;
	    end

	  //Wait for the valid to be asserted
	  FSLF_WAIT_FOR_VALID:
	    begin
	       fslf_tx_write = 1'b0;
	       if (tx_local_fs_lf_valid_mac2phy_sync)
		 get_fslf_next_state = FSLF_WAIT_FOR_CLK_EN;
	       else
		 get_fslf_next_state = FSLF_WAIT_FOR_VALID;
	    end

	  //Wait for the clock enable to proceed
	  FSLF_WAIT_FOR_CLK_EN:
	    begin
	       fslf_tx_write = 1'b0;
	       if (clk_en_rise)
		 get_fslf_next_state = FSLF_WRITE_HI;
	       else
		 get_fslf_next_state = FSLF_WAIT_FOR_CLK_EN;
	    end


	  // Maintain write state until count is complete
	  FSLF_WRITE_HI:
	    begin
	       fslf_tx_write = 1'b1;
	       if ((~postrst_allfslf_done) | (~pclk8_rate) | (prio_tx_writes_done_coef[4]))
		 begin
		    get_fslf_next_state = FSLF_IDLE;
		 end
	       else
		 begin
		    get_fslf_next_state = FSLF_WRITE_HI;
		 end
	    end     
	  default:
	    begin
	       fslf_tx_write = 1'b0;
	       get_fslf_next_state = FSLF_IDLE;
	    end
	endcase
     end

   // G4 FSLF tx_write determination
   always @(posedge pipe_mac2phy_clk or negedge pipe_mac2phy_rstn)
     begin
	if (~pipe_mac2phy_rstn)
	  get_g4fslf_state <= 2'b00;
   	else if (ctrl_soft_reset)
	  get_g4fslf_state <= 2'b00;
	else
	  get_g4fslf_state <= get_g4fslf_next_state;
     end

   always @*
     begin
	get_g4fslf_next_state = 2'b00;

	case (get_g4fslf_state)

	  // Start cycle based on trigger
	  FSLF_IDLE:
	    begin
	       g4fslf_tx_write = 1'b0;
	       if (g4fslf_trigger & tx_local_fs_lf_valid_mac2phy_sync)
		 get_g4fslf_next_state = FSLF_WAIT_FOR_CLK_EN;
	       else if (g4fslf_trigger)
		 get_g4fslf_next_state = FSLF_WAIT_FOR_VALID;
	       else
		 get_g4fslf_next_state = FSLF_IDLE;
	    end

	  //Wait for the valid to be asserted
	  FSLF_WAIT_FOR_VALID:
	    begin
	       g4fslf_tx_write = 1'b0;
	       if (tx_local_fs_lf_valid_mac2phy_sync)
		 get_g4fslf_next_state = FSLF_WAIT_FOR_CLK_EN;
	       else
		 get_g4fslf_next_state = FSLF_WAIT_FOR_VALID;
	    end

	  //Wait for the clock enable to proceed
	  FSLF_WAIT_FOR_CLK_EN:
	    begin
	       g4fslf_tx_write = 1'b0;
	       if (clk_en_rise)
		 get_g4fslf_next_state = FSLF_WRITE_HI;
	       else if ((~postrst_allfslf_done) | (~pclk16_rate))
		 begin
		    get_g4fslf_next_state = FSLF_IDLE;
		 end
	       else
		 get_g4fslf_next_state = FSLF_WAIT_FOR_CLK_EN;
	    end

	  // Maintain write state until count is complete
	  FSLF_WRITE_HI:
	    begin
	       g4fslf_tx_write = 1'b1;
	       if ((~postrst_allfslf_done) | (~pclk16_rate) | (prio_tx_writes_done_coef[5]))
		 begin
		    get_g4fslf_next_state = FSLF_IDLE;
		 end
	       else
		 begin
		    get_g4fslf_next_state = FSLF_WRITE_HI;
		 end
	    end     

	  default:
	    begin
	       g4fslf_tx_write = 1'b0;
	       get_g4fslf_next_state = FSLF_IDLE;
	    end
	endcase
     end

   // G5 FSLF tx_write determination
   always @(posedge pipe_mac2phy_clk or negedge pipe_mac2phy_rstn)
     begin
	if (~pipe_mac2phy_rstn)
	  get_g5fslf_state <= 2'b00;
   	else if (ctrl_soft_reset)
	  get_g5fslf_state <= 2'b00;
	else
	  get_g5fslf_state <= get_g5fslf_next_state;
     end

   always @*
     begin
	get_g5fslf_next_state = 2'b00;

	case (get_g5fslf_state)

	  //Start cycle based on trigger
	  FSLF_IDLE:
	    begin
	       g5fslf_tx_write = 1'b0;
	       if (g5fslf_trigger & tx_local_fs_lf_valid_mac2phy_sync)
		 get_g5fslf_next_state = FSLF_WAIT_FOR_CLK_EN;
	       else if (g5fslf_trigger)
		 get_g5fslf_next_state = FSLF_WAIT_FOR_VALID;
	       else
		 get_g5fslf_next_state = FSLF_IDLE;
	    end

	  //Wait for the valid to be asserted
	  FSLF_WAIT_FOR_VALID:
	    begin
	       g5fslf_tx_write = 1'b0;
	       if (tx_local_fs_lf_valid_mac2phy_sync)
		 get_g5fslf_next_state = FSLF_WAIT_FOR_CLK_EN;
	       else
		 get_g5fslf_next_state = FSLF_WAIT_FOR_VALID;
	    end

	  //Wait for the clock enable to proceed
	  FSLF_WAIT_FOR_CLK_EN:
	    begin
	       g5fslf_tx_write = 1'b0;
	       if (clk_en_rise)
		 get_g5fslf_next_state = FSLF_WRITE_HI;
	       else if ((~postrst_allfslf_done) | (~pclk32_rate))
		 begin
		    get_g5fslf_next_state = FSLF_IDLE;
		 end
	       else
		 get_g5fslf_next_state = FSLF_WAIT_FOR_CLK_EN;
	    end

	  // Maintain write state until count is complete
	  FSLF_WRITE_HI:
	    begin
	       g5fslf_tx_write = 1'b1;
	       if ((~postrst_allfslf_done) | (~pclk32_rate) | (prio_tx_writes_done_coef[6]))
		 begin
		    get_g5fslf_next_state = FSLF_IDLE;
		 end
	       else
		 begin
		    get_g5fslf_next_state = FSLF_WRITE_HI;
		 end
	    end     

	  default:
	    begin
	       g5fslf_tx_write = 1'b0;
	       get_g5fslf_next_state = FSLF_IDLE;
	    end
	endcase
     end
   
   // G67 FSLF tx_write determination
   always @(posedge pipe_mac2phy_clk or negedge pipe_mac2phy_rstn)
     begin
	if (~pipe_mac2phy_rstn)
	  get_g67fslf_state <= 2'b00;
   	else if (ctrl_soft_reset)
	  get_g67fslf_state <= 2'b00;
	else
	  get_g67fslf_state <= get_g67fslf_next_state;
     end

   always @*
     begin
	get_g67fslf_next_state = 2'b00;

	case (get_g67fslf_state)

	  //Start cycle based on trigger
	  FSLF_IDLE:
	    begin
	       g67fslf_tx_write = 1'b0;
	       if (g67fslf_trigger & tx_local_fs_lf_valid_mac2phy_sync)
		 get_g67fslf_next_state = FSLF_WAIT_FOR_CLK_EN;
	       else if (g67fslf_trigger)
		 get_g67fslf_next_state = FSLF_WAIT_FOR_VALID;
	       else
		 get_g67fslf_next_state = FSLF_IDLE;
	    end

	  //Wait for the valid to be asserted
	  FSLF_WAIT_FOR_VALID:
	    begin
	       g67fslf_tx_write = 1'b0;
	       if (tx_local_fs_lf_valid_mac2phy_sync)
		 get_g67fslf_next_state = FSLF_WAIT_FOR_CLK_EN;
	       else
		 get_g67fslf_next_state = FSLF_WAIT_FOR_VALID;
	    end

	  //Wait for the clock enable to proceed
	  FSLF_WAIT_FOR_CLK_EN:
	    begin
	       g67fslf_tx_write = 1'b0;
	       if (clk_en_rise)
		 get_g67fslf_next_state = FSLF_WRITE_HI;
	       else if ((~postrst_allfslf_done) | (~pclk64_rate))
		 begin
		    get_g67fslf_next_state = FSLF_IDLE;
		 end
	       else
		 get_g67fslf_next_state = FSLF_WAIT_FOR_CLK_EN;
	    end

	  // Maintain write state until count is complete
	  FSLF_WRITE_HI:
	    begin
	       g67fslf_tx_write = 1'b1;
	       if ((~postrst_allfslf_done) | (~pclk64_rate) | (prio_tx_writes_done_coef[3])) //FIXME CHECK THIS!!! write-done may change
		 begin
		    get_g67fslf_next_state = FSLF_IDLE;
		 end
	       else
		 begin
		    get_g67fslf_next_state = FSLF_WRITE_HI;
		 end
	    end     

	  default:
	    begin
	       g67fslf_tx_write = 1'b0;
	       get_g67fslf_next_state = FSLF_IDLE;
	    end
	endcase
     end
   


//--------------------------------------------------------------------
// Detect all-FSLF write completion
// Don't enable fslf-related writes until we see that the post-reset
// allfslf writes are complete.
//--------------------------------------------------------------------
   assign posedge_reset_detect = reset_detect & ~reset_detect_d1;

   always @(posedge pipe_mac2phy_clk or negedge pipe_mac2phy_rstn)
     begin
	if (~pipe_mac2phy_rstn)
	  postrst_allfslf_done <= 1'b0;
	else if (posedge_reset_detect)
	  postrst_allfslf_done <= 1'b0;
	else if (allfslf_sent_mac2phy_sync | wait_for_valid_mac2phy_sync)
	  postrst_allfslf_done <= 1'b1;
     end

//--------------------------------------------------------------------
// Flop coefficients
//--------------------------------------------------------------------

   // NOTE: This is being clocked with the phy2mac clock
   always @(posedge pipe_phy2mac_clk or negedge pipe_phy2mac_rstn)
     begin
	if (~pipe_phy2mac_rstn)
	  begin
	     local_fs_reg <= 8'h0;
	     local_lf_reg <= 8'h0;
	  end
   	else if (ctrl_soft_reset)
	  begin
	     local_fs_reg <= 8'h0;
	     local_lf_reg <= 8'h0;
	  end
	else
	  begin
	     if (tx_local_fs_lf_valid_mac2phy_sync)
	       begin
		  if (pipe_rate_mac2phy_sync == 4'b0101)
		    begin
		       local_fs_reg <= {2'b00,local_fs_g67};
		       local_lf_reg <= {2'b00,local_lf_g67};
		    end
		  else
		    begin
		       local_fs_reg <= {2'b00,local_fs_legacy};
		       local_lf_reg <= {2'b00,local_lf_legacy};
		    end
	       end
	     else
	       begin
		  local_fs_reg <= local_fs_reg;
		  local_lf_reg <= local_lf_reg;
	       end
	  end
     end

//--------------------------------------------------------------------
// PHYSTATUS triggering
// After the fs/lf data is sent to the MAC, and the ACK is sent back,
// we will generate a 1-cycle phystatus trigger
//--------------------------------------------------------------------
   
   //always @(posedge pipe_mac2phy_clk or negedge pipe_mac2phy_rstn)
   //  begin
   // if (~pipe_mac2phy_rstn)
   //   physt_trig_state <= 2'b0;
   //	else if (ctrl_soft_reset)
   //   physt_trig_state <= 2'b0;
   // else
   //   physt_trig_state <= physt_trig_next_state;
   //  end


   //always @*
   //  begin
   // physt_trig_next_state = 2'b0;
   // //physt_trig = 1'b0;

   // case (physt_trig_state)

   //   // Look for fslf-related P2M write
   //   FSLF_PHYST_IDLE:
   //     begin
   //        if (fslf_sent|g4fslf_sent|g5fslf_sent|g67fslf_sent|allfslf_sent_mac2phy_sync)
   // 	 physt_trig_next_state = FSLF_PHYST_WAIT;
   //        else
   // 	 physt_trig_next_state = FSLF_PHYST_IDLE;
   //     end

   //   // Wait for ACK from MAC
   //   FSLF_PHYST_WAIT:
   //     begin
   //        if (rx_write_ack)
   // 	 physt_trig_next_state = FSLF_PHYST_TRIG;
   //        else
   // 	 physt_trig_next_state = FSLF_PHYST_WAIT;
   //     end

   //   // Sent 1-cycle trigger towards phystatus logic
   //   FSLF_PHYST_TRIG:
   //     begin
   //        //physt_trig = 1'b1;
   //        physt_trig_next_state = FSLF_PHYST_IDLE;
   //     end

   //   default:
   //     begin
   //        physt_trig_next_state = FSLF_PHYST_IDLE;
   //     end

   // endcase
   //  end

endmodule
