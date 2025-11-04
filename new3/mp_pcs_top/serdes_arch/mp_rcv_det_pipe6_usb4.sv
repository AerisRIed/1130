//------------------------------------------------------------------------------
//                                     
//            CADENCE                    Copyright (c) 2014
//                                       Cadence Design Systems, Inc.
//            SoCR                       All rights reserved.
//
//  This work may not be copied, modified, re-published, uploaded, executed, or
//  distributed in any way, in any medium, whether in whole or in part, without
//  prior written permission from Cadence Design Systems, Inc.
//------------------------------------------------------------------------------
//                                      
//   Module Name    : mp_rcv_det_pipe6_usb4
//   Author         : Dongdong Wang
//   Created        : July 23, 2025
//------------------------------------------------------------------------------
//   Description    : Receiver detection module.  This module initiates a PMA
//                    receiver detection operation as directed.
// 
//                    PMA interface:  The interface to the PMA follows a request/
//                    acknowledgement handshake.  The PCS asserts pma_rcv_detect
//                    signal.  Upon completion, the PMA asserts pma_rcv_detect_done.
//                    Upon assertion of pma_rcv_detect_done, pma_rcv_detected signal
//                    is valid:  0 = no receiver detected, 1 = receiver detected.
//
//                    PIPE interface:  For PCIe, Rcvr detection can only be initiated
//                    when in the P1 power state.  pipe_tx_det_rx_lpbk is asserted high
//                    to initiate a Rcvr detect operation.  It must remain asserted
//                    until the operation is completed.  Completion is signaled by
//                    assertion of pipe_phy_status for 1 clock cycle.  pipe_rx_status
//                    provides the results of the operation (0x0 = no receiver detected,
//                    0x3 = receiver detected).
//                    For USB, Rcvr detection can be initiated in the P2 or P3 power
//                    states.  PIPE signaling is the same as PCIe for the P2 power
//                    state.  However, for the P3 power state, upon completion,
//                    pipe_phy_status is asserted high and pipe_rx_status holds the
//                    result until pipe-tx_det_rx_lpbk is de-asserted low.
//
//                    The module contains an override input (rcv_det_inihibit)
//                    which prevents intiation of a Rcvr detect operation when
//                    asserted.  There may be times (i.e. upon start-up) when a 
//                    Rcvr Detect operation has to be delayed.
//
//                    Mod from v0:  Eliminated the registering of PIPE signals
//                      onto PIPE clock.  Use already registered versions.
//
//                    Mod from v1:  Added ability for RcvrDetect in PCIe P2 power state
//
//                    pipe6 varient: For PIPE clock as input mode only.
//
// Notes            : Based on mp_rcv_det_pipe6 authored by Fred Stivers
//------------------------------------------------------------------------------
 
module mp_rcv_det_pipe6_usb4 (

input              pipe_clk,
input              pipe_rst_n,

input              ref_clk,
input              ref_rst_n,

input              pipe_tx_det_rx_lpbk,
input              pipe_tx_elec_idle,
input       [2:0]  pipe_powerdown,

output reg         pma_rcv_detect,
input              pma_rcv_detect_done,
input              pma_rcv_detected,

input       [15:0] pcs_rcv_det_cnt_load, // Load for inhibit counter
output wire        phy_status_rcv_det,
output wire [2:0]  rx_status_rcv_det

);

//------------------------------------------------------------------------------
// Internal signals
wire        p_rcv_detect_done;

wire [2:0]  ref_powerdown;
wire        ref_tx_det_rx_lpbk;
wire        ref_rcv_detect_done;

reg         p_do_rcv_det_tgl;
reg         ref_do_rcv_det_tgl_d0;
reg         ref_do_rcv_det_tgl_d1;
reg         ref_tx_det_rx_lpbk_d0;
reg         ref_tx_det_rx_lpbk_d1;
reg  [2:0]  p_pipe_powerdown_d0;

reg         p_phy_status;
reg  [2:0]  p_rx_status;
reg         p_rcv_detect_done_d;

reg         ref_phy_status;
reg  [2:0]  ref_rx_status;
reg         ref_rcv_detect_done_d;

reg         ref_rcv_detect_start;

reg         p_pipe_tx_elec_idle_d0;
reg         p_pipe_tx_det_rx_lpbk_d0;
reg         p_pipe_tx_det_rx_lpbk_d1;

reg [17:0]  rcv_det_inh_cnt;      // Inhibit counter for receiver detect
reg         rcv_det_inh_load;     // Load count value
reg         rcv_det_inhibit;

//------------------------------------------------------------------------------
always @(posedge pipe_clk or negedge pipe_rst_n)
begin
if (~pipe_rst_n)
   begin
   p_pipe_tx_elec_idle_d0     <= 1'b1;
   p_pipe_tx_det_rx_lpbk_d0   <= 1'b0;
   p_pipe_tx_det_rx_lpbk_d1   <= 1'b0;
   p_pipe_powerdown_d0        <= 3'b010;
   end
else
   begin
   p_pipe_tx_elec_idle_d0     <= pipe_tx_elec_idle;
   p_pipe_tx_det_rx_lpbk_d1   <= p_pipe_tx_det_rx_lpbk_d0;
   p_pipe_powerdown_d0        <= pipe_powerdown;

   // Prevent loading of rising edge detection F/Fs if PIPE TxElecIdle is high.
   //   This deals with corner case
   if (pipe_tx_elec_idle)
      begin
      p_pipe_tx_det_rx_lpbk_d0   <= pipe_tx_det_rx_lpbk;
      end
   else
      begin
      p_pipe_tx_det_rx_lpbk_d0   <= 1'b0;
      end
   end
end

//------------------------------------------------------------------------------
// Toggle upon rising edge of pipe_tx_det_rx_lpbk when in PCIe P1/USB P2 power state
//   and TxElecIdle is high
always @(posedge pipe_clk or negedge pipe_rst_n)
begin
if (~pipe_rst_n)
   begin
   p_do_rcv_det_tgl   <= 1'b0;
   end
else
   begin
   if (p_pipe_tx_det_rx_lpbk_d0 & ~p_pipe_tx_det_rx_lpbk_d1 & p_pipe_tx_elec_idle_d0 & 
       (p_pipe_powerdown_d0 == 3'b010))
      begin
      p_do_rcv_det_tgl <= ~p_do_rcv_det_tgl;
      end
   end
end

//------------------------------------------------------------------------------
// Synchronize signals to pipe_clk
phy_data_sync i_phy_data_sync_p_rcv_detect_done (
   .clock    (pipe_clk),
   .reset_n  (pipe_rst_n),
   .d_in     (pma_rcv_detect_done),
   .d_out    (p_rcv_detect_done)
   );

//------------------------------------------------------------------------------
// If PCIe P1, pipe_rx_state and pipe_phy_status are
//  driven off of pipe_clk
always @(posedge pipe_clk or negedge pipe_rst_n)
begin
if (~pipe_rst_n)
   begin
   p_phy_status <= 1'b0;
   p_rx_status  <= 3'd0;
   p_rcv_detect_done_d <= 1'b0;
   end
else
   begin
   p_rcv_detect_done_d <= p_rcv_detect_done;

   if ((pipe_powerdown == 3'b010) & p_rcv_detect_done & ~p_rcv_detect_done_d)
      // Drive on rising edge of pma_rcv_detect_done (re-synchronized)
      begin
      p_phy_status <= 1'b1;
      p_rx_status  <= {1'b0, pma_rcv_detected, pma_rcv_detected};
      end
   else
      begin
      p_phy_status <= 1'b0;
      p_rx_status  <= 3'd0;
      end
   end
end

//------------------------------------------------------------------------------
// Synchronize signals to ref_clk
phy_mb_data_sync #(.depth(2), .p_width(5),.d_rst_val(5'b01010)) i_mb_data_sync_pipe_powerdown (
   .dest_clk     (ref_clk),
   .dest_rst_n   (ref_rst_n),
   .source_dat   ({pipe_tx_det_rx_lpbk, pipe_tx_elec_idle, pipe_powerdown}),
   .dest_dat     ({ref_tx_det_rx_lpbk, ref_tx_elec_idle, ref_powerdown})
   );

phy_data_sync i_phy_data_sync_p_do_rcv_det_tgl (
   .clock    (ref_clk),
   .reset_n  (ref_rst_n),
   .d_in     (p_do_rcv_det_tgl),
   .d_out    (ref_do_rcv_det_tgl)
   );

phy_data_sync i_phy_data_sync_ref_rcv_detect_done (
   .clock    (ref_clk),
   .reset_n  (ref_rst_n),
   .d_in     (pma_rcv_detect_done),
   .d_out    (ref_rcv_detect_done)
   );

// Receiver detect inhibit counter.
// Need to give PMA enough time for it to establish common mode voltages
//    to avoid false positives.
// The PMA macros charge common mode at a slow rate once in P1
//    (A2) state and we need to wait at least 2ms before starting receiver
//    detection to ensure no false positives.
// The RefClk is assumed to be 25 MHz (40 nsec).  The configured value is left
//    shifted by 2 bits to give the 16-bit input value sufficient range.
always@(posedge ref_clk or negedge ref_rst_n)
begin
if (ref_rst_n == 1'b0)
   begin
   rcv_det_inhibit <= 1'b1;
   rcv_det_inh_cnt <= 18'h00000;
   end
else
   begin
   if (rcv_det_inh_load)
      begin
      rcv_det_inhibit <= 1'b1;
      rcv_det_inh_cnt <= {pcs_rcv_det_cnt_load,2'b00};
      end
   else
      begin
      if (rcv_det_inh_cnt == 18'd0)
         begin
         rcv_det_inhibit <= 1'b0;
         end
      else
         begin
         rcv_det_inh_cnt <= rcv_det_inh_cnt - 18'd1;
         end
      end
   end
end

// Load the count value out of reset or when entering L1 substates.
always@(posedge ref_clk or negedge ref_rst_n)
begin
if (ref_rst_n == 1'b0)
   begin
   rcv_det_inh_load  <= 1'b1;
   end
else
   begin
   if (ref_powerdown[2])
      begin
      rcv_det_inh_load  <= 1'b1;
      end
   else
      begin
      rcv_det_inh_load  <= 1'b0;
      end
   end
end

//------------------------------------------------------------------------------
// Initate Rcvr detect operation
//   Only initiate if in PCIe P1 power state or USB P2 or P3 power states
//   Only assert pma_rcv_detect if pma_rcv_detect_done is de-asserted
always @(posedge ref_clk or negedge ref_rst_n)
begin
if (~ref_rst_n)
   begin
   pma_rcv_detect <= 1'b0;
   ref_do_rcv_det_tgl_d0 <= 1'b0;
   ref_do_rcv_det_tgl_d1 <= 1'b0;
   ref_tx_det_rx_lpbk_d0 <= 1'b0;
   ref_tx_det_rx_lpbk_d1 <= 1'b0;
   end
else
   begin
   ref_do_rcv_det_tgl_d0 <= ref_do_rcv_det_tgl;
   ref_do_rcv_det_tgl_d1 <= ref_do_rcv_det_tgl_d0;
   ref_tx_det_rx_lpbk_d1 <= ref_tx_det_rx_lpbk_d0;

   // If TxElecIdle low, clear Ref TxDetRxLpbk so that can see rising edge
   //   Deals with corner case where TxDetRxLpbk is high during P3 Tx LFPS.
   if (ref_tx_elec_idle)
      begin 
      ref_tx_det_rx_lpbk_d0 <= ref_tx_det_rx_lpbk;
      end 
   else
      begin 
      ref_tx_det_rx_lpbk_d0 <= 1'b0;
      end 

   // Initate Rcvr detection
   if (ref_rcv_detect_start & ~ref_rcv_detect_done & ~rcv_det_inhibit)
      begin
      pma_rcv_detect <= 1'b1;
      end
   // De-assert PMA Rcvr detect signal upon completion of operation
   else if (ref_rcv_detect_done)
      begin
      pma_rcv_detect <= 1'b0;
      end
   end
end

// Capture when Rcvr Detection requested
always @(posedge ref_clk or negedge ref_rst_n)
begin
if (~ref_rst_n)
   begin
   ref_rcv_detect_start <= 1'b0;
   end
else
   begin
   // When in PCIe P1 or USB P2 upon toggle of ref_do_rcv_det_tgl from PIPE side
   if (ref_do_rcv_det_tgl_d0 ^ ref_do_rcv_det_tgl_d1)
      begin
      ref_rcv_detect_start <= 1'b1;
      end
   // When in USB P3 upon rising edge of PIPE TxDetRx/Lpbk and PIPE TxElecIdle high
   else if ((ref_powerdown == 3'b011) & ref_tx_elec_idle &
            ref_tx_det_rx_lpbk_d0 & ~ref_tx_det_rx_lpbk_d1)
      begin
      ref_rcv_detect_start <= 1'b1;
      end
   else if (pma_rcv_detect)
      begin
      ref_rcv_detect_start <= 1'b0;
      end
   end
end

//------------------------------------------------------------------------------
// If USB P3 power state, pipe_rx_status and pipe_phy_status are driven off
//   of ref_clk
always @(posedge ref_clk or negedge ref_rst_n)
begin
if (~ref_rst_n)
   begin
   ref_phy_status <= 1'b0;
   ref_rx_status  <= 3'd0;
   ref_rcv_detect_done_d <= 1'b0;
   end
else
   begin
   ref_rcv_detect_done_d <= ref_rcv_detect_done;

   // Upon rising edge of pma_rcv_detect_done, assert phy_status and
   //   capture rx_status
   if ((ref_powerdown == 3'b011) & 
       pma_rcv_detect & ref_rcv_detect_done & ~ref_rcv_detect_done_d)
      begin
      ref_phy_status <= 1'b1;
      ref_rx_status  <= {1'b0, pma_rcv_detected, pma_rcv_detected};
      end
   // Clear upon deassertion of pipe_tx_det_rx_lpbk
   else if (~ref_tx_det_rx_lpbk)
      begin
      ref_phy_status <= 1'b0;
      ref_rx_status  <= 3'd0;
      end
   end
end

//------------------------------------------------------------------------------
// The p_phy_status/p_rx_status and ref_phy_status/ref_rx_status are mutually 
//  exclusive.  They cannot be asserted at the same time.  This is assured
//  based on the PHY's powerstate.
assign phy_status_rcv_det = p_phy_status | ref_phy_status;
assign rx_status_rcv_det  = p_rx_status | ref_rx_status;

`ifdef CDN_PCS_ABV_ON
// pragma synthesis_off
//------------------------------------------------------------------------
// RTL ASSERTIONS and COVERAGE - to include use -sv define ABV_ON
//------------------------------------------------------------------------
mp_rcv_det_pma_rcv_detect_assert_pcie_p1_or_usb_p2_p3_state_only :
   assert property (@(negedge ref_clk) disable iff (~ref_rst_n)
      $rose(pma_rcv_detect) |-> (pipe_powerdown[1]))
      else #1 $fatal(1, "pma_rcv_detect asserted in invalid power state.");

mp_rcv_det_pma_rcv_detect_assert_when_done_high :
   assert property (@(negedge ref_clk) disable iff (~ref_rst_n)
      $rose(pma_rcv_detect) |-> !pma_rcv_detect_done)
      else #1 $fatal(1, "pma_rcv_detect asserted when pma_rcv_detect_done high.");

mp_rcv_det_pma_rcv_detect_assert_when_inhibit_high :
   assert property (@(negedge ref_clk) disable iff (~ref_rst_n)
      $rose(pma_rcv_detect) |-> !rcv_det_inhibit)
      else #1 $fatal(1, "pma_rcv_detect asserted when rcv_det_inhibit high.");

// pragma synthesis_on
`endif

endmodule
