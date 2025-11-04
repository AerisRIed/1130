//-----------------------------------------------------------------------------
//    This confidential and proprietary HDL soft description of a Hardware
//    component may be used only as authorized by a licensing agreement from
//    Cadence Design Systems, Inc.. In the event of publication, the following 
//    notice is applicable:
//
//               (C) COPYRIGHT 2014 Cadence Design Systems, Inc.
//                           ALL RIGHTS RESERVED
//
//     The entire notice above must be reproduced on all authorized
//     copies of this code.
//-----------------------------------------------------------------------------
//-----------------------------------------------------------------------------
//
// Module         : mp_cmn_if_pipe6_usb4
// Author         : Dongdong Wang
// Created        : July 23, 2025
// Abstract       : Interface module for common PIPE signals that will be
//
// Notes          : Based on mp_cmn_if_pipe6 authored by Fred Stivers and Scott Shelton
// 
//----------------------------------------------------------------------------
 
module mp_cmn_if_pipe6_usb4 (

input             pipe_clk,             // PIPE interface clock for outputs
input             pipe_rst_n,           // Reset for pipe_clk_out

`ifdef CDN_PIPE_DEEPPM_INC
input             pipe_restore_n,       // PIPE restore
`endif

//input             perform_rate_chg,     // Asserted high when performing a rate change
input             pwr_chg_done,         // From Pwr/Rate control on PSM clock
                                        //    Toggles to signal generation
                                        //    of PhyStatus pulse and to de-assert
                                        //    at start-of-day
//input             pipe_pclk_change_ok_int, // From Pwr/Rate control on PSM clock
                                           //   De-asserted with toggle of pwr_change_done

//output reg        int_pipe_pclk_change_ok, // For handshaking with Pwr/Rate ctrl block
//output            pipe_pclk_change_ok,  // PCLK change OK signal
                                        // Must be de-asserted with PHY status
output reg        pipe_phy_status       // PHY Status handshake - a strobe for
                                        //   all rate and power state changes
);
  
  
// Reg and Wire declarations

reg  [1:0]        state;                // phystatus state machine on pipe_clk

reg               p_pwr_chg_done_del;  // Delay for edge detect

// State machine encodings
localparam         p_ST_START  = 2'b00;
localparam         p_ST_DELAY  = 2'b01;
localparam         p_ST_NORM   = 2'b10;
//localparam         p_ST_RTCHG0 = 3'b011;
//localparam         p_ST_RTCHG1 = 3'b100;

// From power controller
phy_mb_data_sync #(.depth(2), .p_width(1),.d_rst_val(1'b0)) i_mb_data_sync_pwr_change (
  .dest_clk   (pipe_clk),
  .dest_rst_n (pipe_rst_n),
  .source_dat (pwr_chg_done),
  .dest_dat   (p_pwr_chg_done)
  //.source_dat ({pwr_chg_done, pipe_pclk_change_ok_int, perform_rate_chg}),
  //.dest_dat   ({p_pwr_chg_done, p_pclk_change_ok_int, p_perform_rate_chg})
  );

`ifdef CDN_PIPE_DEEPPM_INC
// Synchronize pipe_restore_n
phy_data_sync #(.RESET_VALUE (1'b1)) u_phy_data_sync_pipe_restore_n (
   .clock   (pipe_clk),
   .reset_n (pipe_rst_n),
   .d_in    (pipe_restore_n),
   .d_out   (pipe_restore_n_sync)
   );
`endif
  
// Generate pipe_phy_status
//   At start of day upon the assertion of pwr_chg_done
//     and upon the toggle of power_chg_done afterwards
always@(posedge pipe_clk or negedge pipe_rst_n)
begin
if (pipe_rst_n == 1'b0)
   begin
   state                   <= p_ST_START;
   pipe_phy_status         <= 1'b1;
   p_pwr_chg_done_del      <= 1'b0;
   //int_pipe_pclk_change_ok <= 1'b0;
   end
`ifdef CDN_PIPE_DEEPPM_INC
else if (~pipe_restore_n_sync)
   begin
   state                   <= p_ST_NORM;
   pipe_phy_status         <= 1'b0;
   end
`endif
else
   begin
   p_pwr_chg_done_del  <= p_pwr_chg_done;

   case (state)
   // p_ST_START
   // Wait for assertion of pwr_chg_done to indicate that
   //   PHY lane startup is complete and de-assert PIPE PhyStatus
   p_ST_START:
   begin
   if (p_pwr_chg_done)
      begin
      pipe_phy_status <= 1'b0;
      state <= p_ST_DELAY;
      end
   end
   
   // p_ST_DELAY:
   p_ST_DELAY:
      begin
      state <= p_ST_NORM;
      end

   //// p_ST_RTCHG0
   //p_ST_RTCHG0:
   //   // Wait for PIPE PCLK change OK 
   //   //   once PCLK has been turned back on
   //   begin
   //   if (p_pclk_change_ok_int)
   //      begin   
   //      state <= p_ST_RTCHG1;
   //      int_pipe_pclk_change_ok <= 1'b1;
   //      end   
   //   end

   //// p_ST_RTCHG1
   //p_ST_RTCHG1:
   //   // Wait for toggle of PwrChgDone signal
   //   begin
   //   if (p_pwr_chg_done ^ p_pwr_chg_done_del)
   //      begin   
   //      state <= p_ST_NORM;
   //      pipe_phy_status <= 1'b1;
   //      end   
   //   end

   // p_ST_NORM
   // Generate single cycle strobe on PIPE PhyStatus for a power state
   default:
      begin
      pipe_phy_status <= (p_pwr_chg_done ^ p_pwr_chg_done_del);

      //if (p_perform_rate_chg)
      //   // Date rate change - Must synchronize the de-assertion
      //   //   of PIPE PCLK change OK with PIPE PhyStatus strobe
      //   begin
      //   state <= p_ST_RTCHG0;
      //   end
      //else
      //   begin
      //   int_pipe_pclk_change_ok <= 1'b0;
      //   end
      //end
   end
   endcase
   end
end

// Asserted high using pipe_pclk_change_ok_int (from PwrRate control block)
//   De-asserted with int_pipe_pclk_change_ok from local FSM control
//assign pipe_pclk_change_ok = int_pipe_pclk_change_ok | pipe_pclk_change_ok_int;

endmodule
