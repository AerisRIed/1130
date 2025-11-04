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
// Module         : mp_pwr_rate_ctrl_pipe6_var_pclk_usb4
// Author         : Dongdong Wang
// Created        : July 23, 2025
// Abstract       : Combined power and rate control interface module for MP PCS
//                    for PIPE6 spec with PIPE clock as input.
//                  For all state transitions, PhyStatus is strobed upon
//                    completion.
//                  P2, P1.x and P0p are considered powered down states and 
//                    PLL clock enable is de-asserted.
//                  For rate change, the lane is first put into A3 power state.
//                    Must transition through the A2 power state upon exit.
//                  Support simulataneous rate and power state change (P0 to P1 and 
//                    P0 to P2 only).
//
// Notes          : Based on mp_pwr_rate_ctrl_pipe6_var_pclk authored by Fred Stivers and Scott Shelton
// 
//----------------------------------------------------------------------------

`include "mp_pcs_consts_usb4.vh"
 
module mp_pwr_rate_ctrl_pipe6_var_pclk_usb4 (
  
// System interfaces
input                 clk,                        // PMA PSM clock
input                 reset_n,                    // Asynchronous reset

// PIPE Interface
`ifdef CDN_PIPE_DEEPPM_INC
input                 pipe_restore_n,           // PIPE restore
`endif
input       [2:0]     pipe_powerdown,           // PIPE request on pipe_clk
input       [1:0]     pipe_rate,                // PIPE Data rate request
//output  reg           pipe_pclk_change_ok,      // PIPE PCLK change okay
//input                 pipe_pclk_change_ack,     // PIPE PCLK change ack
//input       [2:0]     pipe_pclk_rate,           // PIPE clock frequency
//input       [1:0]     pipe_tx_width,            // PIPE Tx data width
output  reg           pipe_clk_en,              // Asserted high during a rate change to internally gate
                                                //    PIPE clock

input                 pipe_clk_running,         // Asserted high at start of day to indicate PCLK is running

//input                 iso_mode_en,                // PHY isolation mode enabled

// Handshake for PIPE PhyStatus control during rate change
//output  reg           perform_rate_chg,           // Asserted high to signal rate change has started
//input                 int_pipe_pclk_change_ok,    // Indicates when local FSM can de-assert PCLK change OK

output  reg           pwr_chg_done,               // Toggle on psm_clk
output  reg [1:0]     cur_pipe_rate,              // Current PIPE rate - only changes
                                                  //   after pma_xcvr_pll_clk_en_ack is low
//output  reg [2:0]     cur_pipe_pclk_rate,         // Captured upon a data rate change and start of day
//output  reg [1:0]     cur_pipe_tx_width,          // Captured upon a data rate change and start of day
output  reg           pipe_rx_en,                 // De-assert when Rx path is turned off

output  reg           ln_l0p_en,                  // Signals lane in L0p power state

// PMA interface
input                 pma_pll_ready,              // PMA common PLL ready
output  reg [2:0]     pma_data_width,             // PMA width control
output  reg [2:0]     pma_standard_mode,          // PMA PCIe mode selection
input       [5:0]     pma_pwr_state_ack,          // PMA power state acknowledge
output  reg [5:0]     pma_pwr_state_req,          // PMA power state request
output  reg           pma_xcvr_pll_clk_en,        // PMA PLL clock enable
input                 pma_xcvr_pll_clk_en_ack,    // PMA PLL clock enable acknowledge
input                 pma_xcvr_pll_clk_en_ack_low,// PMA PLL clock enable acknowledge aggregated
input                 pipe_rx_standby,
output                rx_standby_status
);
  
// Handshake signals from cmn_if td_clk domain to psm_clk domain.
wire            rx_standby    ;
wire  [2:0]     req_pipe_pwrst;          // Requested PIPE power state
//wire  [2:0]     req_pipe_rate;           // Requested PIPE data rate
reg   [5:0]     req_pma_pwrst;           // Requested PMA power state
reg   [5:0]     cur_pma_pwrst;           // Current PMA power state

reg   [2:0]     state;                   // Power state machine on psm_clk
reg             pd_req;                  // Set to 1 when PIPE P2, P1.x or P0p power state requested
//reg             rate_chg_req;            // Set to 1 when data rate change requested

//reg   [3:0]     count;                   // Counter

reg             start_of_day;            // Reset high and cleared upon release of reset.
                                         // Used to capture PIPE PCLK rate / PIPE Tx width 
                                         // At start of day
//reg             cmpl_rate_chg_req;

// Pick up PMA encodings from defines...
//localparam p_pma_pcie_gen1_width      = `pipe_pma_pcie_gen1_width;
//localparam p_pma_pcie_gen2_width      = `pipe_pma_pcie_gen2_width;
//localparam p_pma_pcie_gen3_width_32b  = `pipe_pma_pcie_gen3_width_32b;
//localparam p_pma_pcie_gen4_width_32b  = `pipe_pma_pcie_gen4_width_32b;
//localparam p_pma_pcie_gen5_width_32b  = `pipe_pma_pcie_gen5_width_32b;
//localparam p_pma_pcie_gen6_width_64b  = `pipe_pma_pcie_gen6_width_64b;
//localparam p_pma_pcie_gen1_smode      = `pipe_pma_pcie_gen1_standard_mode;
//localparam p_pma_pcie_gen2_smode      = `pipe_pma_pcie_gen2_standard_mode;
//localparam p_pma_pcie_gen3_smode      = `pipe_pma_pcie_gen3_standard_mode;
//localparam p_pma_pcie_gen4_smode      = `pipe_pma_pcie_gen4_standard_mode;
//localparam p_pma_pcie_gen5_smode      = `pipe_pma_pcie_gen5_standard_mode;
//localparam p_pma_pcie_gen6_smode      = `pipe_pma_pcie_gen6_standard_mode;

localparam p_pma_usb4_gen2_width      = `pipe_pma_usb4_gen2_width;
localparam p_pma_usb4_gen3_width      = `pipe_pma_usb4_gen3_width;
localparam p_pma_usb4_gen4_width      = `pipe_pma_usb4_gen4_width;

localparam p_pma_usb4_gen2_smode      = `pipe_pma_usb4_gen2_standard_mode;
localparam p_pma_usb4_gen3_smode      = `pipe_pma_usb4_gen3_standard_mode;
localparam p_pma_usb4_gen4_smode      = `pipe_pma_usb4_gen4_standard_mode;

// Power state encodings for PMA. Note that A5 is not used.
localparam p_PMA_ST_A0       = 6'b000001;
localparam p_PMA_ST_A1       = 6'b000010;
localparam p_PMA_ST_A2       = 6'b000100;
localparam p_PMA_ST_A3       = 6'b001000;
localparam p_PMA_ST_A4       = 6'b010000;
localparam p_PMA_ST_A5       = 6'b100000;

// State machine encodings for the psm_state machine
localparam STARTUP      = 3'h0;
localparam IDLE         = 3'h1;
localparam PWRST_CHG    = 3'h2;
localparam ENTER_PD     = 3'h3;
//localparam RATE_CHG     = 3'h4;
localparam WAIT_EXIT_PD = 3'h5;
localparam EXIT_PD      = 3'h6;
localparam L0P_ST       = 3'h7;

// Handshake the pipe_powerdown[2:0] and pipe_rate[2:0] signals from PIPE
// clock domain to psm_clk
phy_mb_data_sync #(.depth(2), .p_width(4),.d_rst_val(7'b0000010)) i_mb_data_sync_pwr_rate (
   .dest_clk     (clk),
   .dest_rst_n   (reset_n),
   .source_dat   ({pipe_rx_standby, pipe_powerdown}),
   //.dest_dat     ({rx_standby, req_pipe_rate,req_pipe_pwrst})
   .dest_dat     ({rx_standby, req_pipe_pwrst})
   );

// Meta-sync pipe_clk_running
phy_data_sync i_phy_data_sync_pipe_clk_running (
   .clock    (clk),
   .reset_n  (reset_n),
   .d_in     (pipe_clk_running),
   .d_out    (pipe_clk_running_sync)
   );

// Meta-sync pma_xcvr_pll_clk_en_ack
phy_data_sync i_phy_data_sync_pma_xcvr_pll_clk_en_ack (
   .clock    (clk),
   .reset_n  (reset_n),
   .d_in     (pma_xcvr_pll_clk_en_ack),
   .d_out    (pma_xcvr_pll_clk_en_ack_sync)
   );

// Meta-sync pma_xcvr_pll_clk_en_ack_low
phy_data_sync i_phy_data_sync_pma_xcvr_pll_clk_en_ack_low (
   .clock    (clk),
   .reset_n  (reset_n),
   .d_in     (pma_xcvr_pll_clk_en_ack_low),
   .d_out    (pma_xcvr_pll_clk_en_ack_low_sync)
   );

//phy_data_sync i_phy_data_sync_pipe_pclk_change_ack (
//   .clock    (clk),
//   .reset_n  (reset_n),
//   .d_in     (pipe_pclk_change_ack),
//   .d_out    (pipe_pclk_change_ack_sync)
//   );

//phy_data_sync i_phy_data_sync_int_pipe_pclk_change_ok (
//   .clock    (clk),
//   .reset_n  (reset_n),
//   .d_in     (int_pipe_pclk_change_ok),
//   .d_out    (int_pipe_pclk_change_ok_sync)
//   );

phy_data_sync i_phy_data_sync_pma_pll_ready (
   .clock    (clk),
   .reset_n  (reset_n),
   .d_in     (pma_pll_ready),
   .d_out    (pma_pll_ready_sync)
   );

`ifdef CDN_PIPE_DEEPPM_INC
phy_data_sync #(.RESET_VALUE (1'b1)) u_phy_data_sync_pipe_restore_n (
   .clock   (clk),
   .reset_n (reset_n),
   .d_in    (pipe_restore_n),
   .d_out   (pipe_restore_n_sync)
   );
`endif

// Convert pwr_req_psm to 1-hot pwr_state_req_psm
// U4 power State  rx_standby  power down value    PMA power state
// P0rx              1         000                 A5
// P0                0         000                 A0 
// P1                x         001                 A1 
// P2                x         010                 A1        
// P3                x         011                 A3
// P4                x         100                 A2
// P0tx              x         101                 A4
always@(*)
begin
case (req_pipe_pwrst)
3'b000:    req_pma_pwrst = rx_standby ? p_PMA_ST_A5 : 
                                        p_PMA_ST_A0 ;
3'b001:    req_pma_pwrst =              p_PMA_ST_A1 ;
3'b010:    req_pma_pwrst =              p_PMA_ST_A1 ;
3'b011:    req_pma_pwrst =              p_PMA_ST_A3 ;
3'b100:    req_pma_pwrst =              p_PMA_ST_A2 ;
3'b101:    req_pma_pwrst =              p_PMA_ST_A4 ;
default:   req_pma_pwrst =              p_PMA_ST_A0 ;
endcase
end

// FSM
always@(posedge clk or negedge reset_n)
begin
if (~reset_n)
   begin
   state                 <= STARTUP;
   pwr_chg_done          <= 1'b0;
   cur_pipe_rate         <= 2'b0;
   //cur_pipe_pclk_rate    <= 3'b100;
   //cur_pipe_tx_width     <= 2'b01;
   cur_pma_pwrst         <= 6'b00_0000;
   pd_req                <= 1'b0;
   //rate_chg_req          <= 1'b0;
   pma_pwr_state_req     <= 6'b00_0000;
   pma_xcvr_pll_clk_en   <= 1'b0;
   //count                 <= 4'd0;
   pipe_rx_en            <= 1'b0;
   //pipe_pclk_change_ok   <= 1'b0;
   pma_standard_mode     <= 3'b0;
   pma_data_width        <= 3'b0;
   start_of_day          <= 1'b1;
   ln_l0p_en             <= 1'b0;
   //perform_rate_chg      <= 1'b0;
   pipe_clk_en           <= 1'b1;
   //cmpl_rate_chg_req     <= 1'b0;
   end
`ifdef CDN_PIPE_DEEPPM_INC
else if (~pipe_restore_n_sync)
   begin
   state                   <= WAIT_EXIT_PD;
   pd_req                  <= 1'b0;

   // PHY PIPE inputs are static when pipe_restore_n is low
   cur_pipe_rate           <= pipe_rate;
   //cur_pipe_pclk_rate      <= pipe_pclk_rate;
   //cur_pipe_tx_width       <= pipe_tx_width;
 
   // Current PMA power state based on requested PIPE powerdown
   if (pipe_powerdown[2]) // ???
      begin
      cur_pma_pwrst        <= p_PMA_ST_A4;
      end
   else
      begin
      cur_pma_pwrst        <= p_PMA_ST_A3;
      end

   // Current PMA standard mode is based on current PIPE rate
   case (pipe_rate)
   2'b01 : begin
   // Gen3 @20G
   pma_standard_mode       <= p_pma_usb4_gen3_smode;
   pma_data_width          <= p_pma_usb4_gen3_width;
   end
   2'b10 : begin
   // Gen4 @40G
   pma_standard_mode       <= p_pma_usb4_gen4_smode;
   pma_data_width          <= p_pma_usb4_gen4_width;
   end
   default : begin
   // Gen2 @10G
   pma_standard_mode       <= p_pma_usb4_gen2_smode;
   pma_data_width          <= p_pma_usb4_gen2_width;
   end
   endcase
   end
`endif
else
   begin
   start_of_day          <= 1'b0;
   cur_pipe_rate         <= pipe_rate; // USB4 can only change rate when PHY is in reset   

   case (state)
   // PWRST_CHG
   // Wait for pma_pwr_state_ack.
   //   If rate change and/or a power state change to A3, A4 or A5, 
   //      then go to ENTER_PD state
   //   Otherwise, if only a power state change to A0, A1 or A2,
   //      then return to idle.
   //   Clear pma_pwr_state_ack upon leaving the state
   PWRST_CHG:
   begin
   if (pma_pwr_state_ack == pma_pwr_state_req)
      begin 
      //if (pd_req | rate_chg_req)
      if (pd_req) // pd_req high means req to A3/A4
         begin
         state <= ENTER_PD;
         pma_xcvr_pll_clk_en <= 1'b0;
         //pipe_clk_en <= ~rate_chg_req;
         //pipe_clk_en <= 1'b1; // no rate change, always high
         pma_pwr_state_req <= 6'b00_0000;
         cur_pma_pwrst <= pma_pwr_state_req;
         pipe_rx_en <= 1'b0;
         end
      else if (ln_l0p_en) // ln_l0p_en high means req to A5
         begin
         state <= L0P_ST;
         pma_pwr_state_req <= 6'b00_0000;
         cur_pma_pwrst <= pma_pwr_state_req;
         pwr_chg_done <= ~pwr_chg_done;
         pipe_rx_en <= 1'b0;
         end
      else
         begin
         state <= IDLE;
         pma_pwr_state_req <= 6'b00_0000;
         cur_pma_pwrst <= pma_pwr_state_req;
         //rate_chg_req <= 1'b0;
         if ((pma_pwr_state_req == p_PMA_ST_A0) | (pma_pwr_state_req == p_PMA_ST_A1))
            begin
            pipe_rx_en <= 1'b1;
            end
         else
            begin
            pipe_rx_en <= 1'b0;
            end
 
         //if ((cmpl_rate_chg_req & (req_pma_pwrst == p_PMA_ST_A2)) | ~cmpl_rate_chg_req)
         //   // Toggle pwr_chg_done except for case where completing rate change
         //   //    and not stopping in P1 or PMA A2 power state
         //   //    And clear pipe_pclk_change_ok
         //   begin
         //   pwr_chg_done <= ~pwr_chg_done;
         //   //pipe_pclk_change_ok <= 1'b0;
         //   end
         pwr_chg_done <= ~pwr_chg_done;
         end
      end
   end

   // ENTER_PD
   // Wait for de-assertion of pma_xcvr_pll_clk_en_ack
   //   If a rate change, perform the rate change
   //   If just a power state change, go to WAIT_PD_EXIT state.
   ENTER_PD:
   begin
   if (~pma_xcvr_pll_clk_en_ack_low_sync)
      begin
      //if (rate_chg_req)
      //   begin
      //   state <= RATE_CHG;
      //   count <= 4'd15;
      //   cur_pipe_rate <= req_pipe_rate;
      //   cur_pipe_pclk_rate <= pipe_pclk_rate;
      //   cur_pipe_tx_width <= pipe_tx_width;
      //   pipe_pclk_change_ok <= 1'b1;
      //   end
      //else
      //   begin
      //   state <= WAIT_EXIT_PD;
      //   pwr_chg_done <= ~pwr_chg_done;
      //   end
      state <= WAIT_EXIT_PD;
      pwr_chg_done <= ~pwr_chg_done;
      end
   end

   // RATE_CHG
   // Change standard mode and data width inputs to the PMA based on the requested data rate.
   //   Wait for counter to expire and for pipe_pclk_change_ack to be asserted
   //RATE_CHG:
   //begin
   //case (cur_pipe_rate)
   //3'b001 : begin
   //// Gen3 @20G
   //pma_standard_mode       <= p_pma_usb4_gen3_smode;
   //pma_data_width          <= p_pma_usb4_gen3_width;
   //end
   //3'b010 : begin
   //// Gen4 @40G
   //pma_standard_mode       <= p_pma_usb4_gen4_smode;
   //pma_data_width          <= p_pma_usb4_gen4_width;
   //end
   //default: begin
   //pma_standard_mode       <= p_pma_usb4_gen2_smode;
   //pma_data_width          <= p_pma_usb4_gen2_width;
   //end
   //endcase
   //
   //if ((count == 4'd0) & (int_pipe_pclk_change_ok_sync | (iso_mode_en & pipe_pclk_change_ack_sync)))
   ////if ((count == 4'd0) & pipe_pclk_change_ack_sync & int_pipe_pclk_change_ok_sync)
   //   begin
   //   if (pd_req)
   //      begin
   //      state <= WAIT_EXIT_PD;
   //      pwr_chg_done <= ~pwr_chg_done;
   //      pipe_pclk_change_ok <= 1'b0;
   //      end
   //   else
   //      begin
   //      state <= EXIT_PD;
   //      pma_xcvr_pll_clk_en <= 1'b1;
   //      end
   //   end

   //if (count != 4'd0)
   //   begin
   //   if (pipe_pclk_change_ack_sync)
   //      begin
   //      count <= count - 1'b1;
   //      end
   //   end
   //else
   //   begin
   //   pipe_clk_en <= 1'b1;
   //   perform_rate_chg <= 1'b0;
   //   end
   //end
   
   // WAIT_EXIT_PD
   // Wait for power state change request to leave the A3, A4 or A5 power state
   WAIT_EXIT_PD:
   begin
   if ((cur_pma_pwrst != req_pma_pwrst) & pma_pll_ready_sync)
      begin
      state <= EXIT_PD;
      pma_xcvr_pll_clk_en <= 1'b1;
      end
   end
   
   // EXIT_PD
   // Wait for xcvr_pll_clk_en_ack to be asserted high
   EXIT_PD:
   begin
   if (pma_xcvr_pll_clk_en_ack_sync)
      begin
      state <= PWRST_CHG;
      pd_req <= 1'b0;
      //rate_chg_req <= 1'b0;

      //if (rate_chg_req)
      //   begin
      //   pma_pwr_state_req <= p_PMA_ST_A2;
      //   cmpl_rate_chg_req <= 1'b1;
      //   end
      //else
      //   begin
      //   pma_pwr_state_req <= req_pma_pwrst;
      //   end
      pma_pwr_state_req <= req_pma_pwrst;
      end
   end

   // STARTUP
   // Wait for PMA common startup to complete and then assert Xcvr PLL clock enable
   //   Then wait for Xcvr PLL clock enable ACK
   STARTUP:
   begin
   if (pma_pll_ready_sync) // common PLL ready
      begin
      pma_xcvr_pll_clk_en <= 1'b1;
      end

   if (pma_xcvr_pll_clk_en_ack_sync & pipe_clk_running_sync)
      begin
      state <= IDLE;
      end

   // Start-of-day capture of PIPE PCLK rate and Tx width
   if (start_of_day)
      begin
        //cur_pipe_pclk_rate <= pipe_pclk_rate;
        //cur_pipe_tx_width <= pipe_tx_width;

        // Current PMA standard mode is based on current PIPE rate 
        // update after first power state change
        case (pipe_rate)
          2'b01 : begin
          // Gen3 @20G
          pma_standard_mode       <= p_pma_usb4_gen3_smode;
          pma_data_width          <= p_pma_usb4_gen3_width;
          end
          2'b10 : begin
          // Gen4 @40G
          pma_standard_mode       <= p_pma_usb4_gen4_smode;
          pma_data_width          <= p_pma_usb4_gen4_width;
          end
          default : begin
          // Gen2 @10G
          pma_standard_mode       <= p_pma_usb4_gen2_smode;
          pma_data_width          <= p_pma_usb4_gen2_width;
          end
        endcase
      end

   end

   // L0P_ST
   // Wait for power state change request out of L0P
   L0P_ST :
   begin
   if (cur_pma_pwrst != req_pma_pwrst)
      begin
      state <= PWRST_CHG;
      pma_pwr_state_req <= req_pma_pwrst;
      ln_l0p_en <= 1'b0;

      if ((req_pma_pwrst == p_PMA_ST_A3) | (req_pma_pwrst == p_PMA_ST_A4))
         begin
         pd_req <= 1'b1;
         end
      else
         begin
         pd_req <= 1'b0;
         end
      end
   end
   
   // IDLE
   // This is the starting point for all data rate and power state changes.
   //   Upon detection of a rate change, the A3 PMA power state is requested.
   //   For a power state change only, the selected PMA power state is requested.
   //   Set flags if a data rate change request and/or a power state request to A3, A4 or A5
   default:
   begin
   //cmpl_rate_chg_req <= 1'b0;
   // For USB4, dynamic rate change is not allowed
   //if (cur_pipe_rate != req_pipe_rate)
   //   begin
   //   state <= PWRST_CHG;
   //   pma_pwr_state_req <= p_PMA_ST_A3;
   //   rate_chg_req <= 1'b1;
   //   //pipe_rx_en <= 1'b0;
   //   perform_rate_chg <= 1'b1;
   //   end
   
   if (cur_pma_pwrst != req_pma_pwrst)
      begin
      state <= PWRST_CHG;
      pma_pwr_state_req <= req_pma_pwrst;
      //rate_chg_req <= 1'b0;

      if (req_pma_pwrst == p_PMA_ST_A5)
         begin
         ln_l0p_en <= 1'b1;
         end

      //if ((req_pma_pwrst != p_PMA_ST_A0) & (req_pma_pwrst != p_PMA_ST_A1))
      //   // De-assert Rx enable when requesting a power state other than A0 or A1
      //   begin
      //   pipe_rx_en <= 1'b0;
      //   end
      end

   if (cur_pma_pwrst != req_pma_pwrst)
      begin
      if ((req_pma_pwrst == p_PMA_ST_A3) | (req_pma_pwrst == p_PMA_ST_A4))
      //if ((req_pma_pwrst == p_PMA_ST_A3) | (req_pma_pwrst == p_PMA_ST_A4) | (req_pma_pwrst == p_PMA_ST_A5))
         begin
         pd_req <= 1'b1;
         end
      else
         begin
         pd_req <= 1'b0;
         end
      end
   end
   endcase
   end
end

assign rx_standby_status = ln_l0p_en;

endmodule
