//-----------------------------------------------------------------------------
//    This confidential and proprietary HDL soft description of a Hardware
//    component may be used only as authorized by a licensing agreement from
//    Cadence Design Systems, Inc.. In the event of publication, the following 
//    notice is applicable:
//
//               (C) COPYRIGHT 2020 Cadence Design Systems, Inc.
//                           ALL RIGHTS RESERVED
//
//     The entire notice above must be reproduced on all authorized
//     copies of this code.
//-----------------------------------------------------------------------------
//-----------------------------------------------------------------------------
//
// Module         : mp_pcs_lane_pipe6_var_pclk_usb4
// Author         : Dongdong Wang
// Created        : July 23, 2025
// Abstract       : Implements a PIPE 6 PCS - SerDes architecture / PCLK as input
//
// Notes          : Based on mp_pcs_lane_pipe6_var_pclk authored by Fred Stivers and Scott Shelton
// 
//----------------------------------------------------------------------------
 
module mp_pcs_lane_pipe6_var_pclk_usb4 (
// Clock and Reset    
input             pipe_clk,
input             pipe_rst_n, // Reset for pipe_clk_out
input             psm_clk, // Power state machine clock
input             psm_rst_n, // Asynchronous reset
input             rx_rd_clk, // PMA recovered clock (500MHz)
input             rx_rst_n, // Asynchronous reset
//input             ref_clk, // Slow frequency reference clock
//input             ref_rst_n, // Asynchronous reset

input             scan_mode,

input             pipe_data_path_override,
//input  [15:0]     pcs_rcv_det_cnt_load,

output            ln_l0p_en,
output            pipe_clk_en, 

//input             iso_mode_en,

// PMA interface
input             pma_pll_ready,  // CMN startup complete
//output            pma_rcv_detect, // Initiate receiver detection
//input             pma_rcv_detect_done, // PMA completed receiver det
//input             pma_rcv_detected, // PMA detected receiver
input  [5:0]      pma_power_state_ack, // PMA power change ack
output [5:0]      pma_power_state_req, // Request PMA power change

output [2:0]      pma_data_width, // PMA interface width
output [2:0]      pma_standard_mode, // Interface standard

output            pma_xcvr_pll_clk_en, // Xcvr datart clock enable
input             pma_xcvr_pll_clk_en_ack, // Asserted when Xcvr datart clock running
input             pma_xcvr_pll_clk_en_ack_low, // Asserted when Xcvr datart clock running aggregated

input             pma_rx_sigdetect, // PMA detected signal
input  [31:0]     pma_rd, // Receive data from the PMA
output            pma_rx_term,  // Rx termination
output [31:0]     pma_td, // Transmit data to PMA
output            pma_tx_elec_idle, // Set TX output to Idle
input  [5:0]      pma_tx_local_fs,
input  [5:0]      pma_tx_local_lf,

// PIPE interface
`ifdef CDN_PIPE_DEEPPM_INC
input             pipe_restore_n,  // PIPE restore
`endif

input             rx_eq_eval_complete,

input  [1:0]      pipe_rate, // PIPE rate request
input  [2:0]      pipe_powerdown, // Powerdown request
//output            pipe_pclk_change_ok,
//input             pipe_pclk_change_ack,
//input             pipe_tx_det_rx_lpbk, // Receiver detect
output wire       pipe_phy_status, // PHY Status handshake


input             pipe_32bit_en, // 
input  [39:0]     pipe_tx_data, // Data to transmit
input  [3:0]      pipe_tx_elec_idle, // Transmit elec idle
input             pipe_tx_data_valid, // Transmit data valid (used for data metering)
output [5:0]      pipe_tx_local_fs,
output [5:0]      pipe_tx_local_lf,

output [39:0]     pipe_rx_data, // Decoded RX data
output            pipe_rx_valid, // Symbol locked and data valid
//output [2:0]      pipe_rx_status, // Receive status
output            pipe_rx_elec_idle, // Used to indicate signal

input             pipe_rx_termination,
input             pipe_rx_standby,
output            pipe_rx_standby_status

);
   
//wire  [2:0]       rxstatus_det;
//wire              phy_status_rcv_det;
wire              phy_status_pwrst;
wire  [1:0]       cur_pipe_rate;

reg               pipe_clk_running;

wire              rx_standby_status;

wire              pipe_rx_en;

wire              pwr_chg_done;

//---------------------------------------------------------------------------
// Set bit after reset is de-asserted to indicate the PIPE clock is running
//---------------------------------------------------------------------------
always @(posedge pipe_clk or negedge pipe_rst_n)
begin
if (~pipe_rst_n)
   begin
   pipe_clk_running <= 1'b0;
   end
else
   begin
   pipe_clk_running <= 1'b1;
   end
end

//---------------------------------------------------------------------------
// Instantiate mp_cmn_if for common PIPE signals
//---------------------------------------------------------------------------
mp_cmn_if_pipe6_usb4 i_cmn_if (
   .pipe_clk                       (pipe_clk),
   .pipe_rst_n                     (pipe_rst_n),
   `ifdef CDN_PIPE_DEEPPM_INC
   .pipe_restore_n                 (pipe_restore_n),
   `endif
   .pwr_chg_done                   (pwr_chg_done),
   //.perform_rate_chg               (perform_rate_chg),
   //.pipe_pclk_change_ok_int        (pipe_pclk_change_ok_int),
   //.pipe_pclk_change_ok            (pipe_pclk_change_ok),
   //.int_pipe_pclk_change_ok        (int_pipe_pclk_change_ok),
   .pipe_phy_status                (phy_status_pwrst)
   );

//---------------------------------------------------------------------------
// Instantiate power and rate change control interface
//---------------------------------------------------------------------------
mp_pwr_rate_ctrl_pipe6_var_pclk_usb4 i_pwr_rate_ctrl (
   .clk                            (psm_clk),
   .reset_n                        (psm_rst_n),
   `ifdef CDN_PIPE_DEEPPM_INC
   .pipe_restore_n                 (pipe_restore_n),
   `endif
   .pipe_powerdown                 (pipe_powerdown),
   .pipe_rate                      (pipe_rate),
   //.pipe_pclk_change_ok            (pipe_pclk_change_ok_int),
   //.pipe_pclk_change_ack           (pipe_pclk_change_ack),
   //.pipe_pclk_rate                 (3'd0),
   //.pipe_tx_width                  (2'd0),
   .pipe_clk_running               (pipe_clk_running),
   //.iso_mode_en                    (iso_mode_en),
   //.perform_rate_chg               (perform_rate_chg),
   //.int_pipe_pclk_change_ok        (int_pipe_pclk_change_ok),
   .pipe_clk_en                    (pipe_clk_en),
   .cur_pipe_rate                  (cur_pipe_rate),
   .pwr_chg_done                   (pwr_chg_done),
   .pipe_rx_en                     (pipe_rx_en),
   .ln_l0p_en                      (ln_l0p_en),
   .pma_pll_ready                  (pma_pll_ready),
   .pma_data_width                 (pma_data_width),
   .pma_standard_mode              (pma_standard_mode),
   .pma_pwr_state_ack              (pma_power_state_ack),
   .pma_pwr_state_req              (pma_power_state_req),
   .pma_xcvr_pll_clk_en            (pma_xcvr_pll_clk_en),
   .pma_xcvr_pll_clk_en_ack        (pma_xcvr_pll_clk_en_ack),
   .pma_xcvr_pll_clk_en_ack_low    (pma_xcvr_pll_clk_en_ack_low),
   .pipe_rx_standby                (pipe_rx_standby),
   .rx_standby_status              (rx_standby_status)
   );

phy_data_sync i_phy_data_sync_rx_standby_status (
   .clock    (pipe_clk),
   .reset_n  (pipe_rst_n),
   .d_in     (rx_standby_status),
   .d_out    (pipe_rx_standby_status)
   );


//---------------------------------------------------------------------------
// Instantiate receiver detection controller
// The pma_rcv_detect signal to the PMA is considered asynchronous and will
// be properly synchronised within the PMA.
// The inputs from the PMA are considered asynchronous.
//---------------------------------------------------------------------------
//mp_rcv_det_pipe6 i_rcv_det (
//   .pipe_clk                      (pipe_clk),
//   .pipe_rst_n                    (pipe_rst_n),
//   .ref_clk                       (ref_clk),
//   .ref_rst_n                     (ref_rst_n),
//   .pipe_tx_elec_idle             (|pipe_tx_elec_idle),
//   .pipe_tx_det_rx_lpbk           (pipe_tx_det_rx_lpbk),
//   .pipe_powerdown                (pipe_powerdown),
//   .pcs_rcv_det_cnt_load          (pcs_rcv_det_cnt_load),
//   .pma_rcv_detect                (pma_rcv_detect),
//   .pma_rcv_detect_done           (pma_rcv_detect_done),
//   .pma_rcv_detected              (pma_rcv_detected),
//   .phy_status_rcv_det            (phy_status_rcv_det),
//   .rx_status_rcv_det             (rxstatus_det)
//   );

//---------------------------------------------------------------------------
// Instantiate TX datapath
//---------------------------------------------------------------------------
mp_tpcs_pipe6_var_pclk_usb4 i_tpcs (
   .override_en                   (pipe_data_path_override),
   .pipe_rate                     (cur_pipe_rate),
   .pipe_tx_data                  (pipe_tx_data),
   .pipe_tx_data_valid            (pipe_tx_data_valid),
   .pipe_tx_elec_idle             (pipe_tx_elec_idle),
   .pma_tx_td                     (pma_td),
   .pma_tx_elec_idle              (pma_tx_elec_idle)
   );

//---------------------------------------------------------------------------
// Instantiate RX datapath
//---------------------------------------------------------------------------
mp_rpcs_pipe6_usb4 i_rpcs (
   .rx_rd_clk                     (rx_rd_clk),
   .rx_rst_n                      (rx_rst_n),
   .scanmode                      (scan_mode),
   .rx_en                         (pipe_rx_en),
   .override_en                   (pipe_data_path_override),
   .pipe_rate                     (cur_pipe_rate),
   .pipe_rx_data                  (pipe_rx_data),
   .pipe_rx_valid                 (pipe_rx_valid),
   .pma_rx_rd                     (pma_rd)
   );

//assign pipe_rx_status = rxstatus_det;
//assign pipe_rx_status = 1'b0;

assign pipe_rx_elec_idle = ~pma_rx_sigdetect;

assign pma_rx_term = pipe_rx_termination;

//assign pipe_phy_status = phy_status_pwrst | phy_status_rcv_det;
assign pipe_phy_status = phy_status_pwrst | rx_eq_eval_complete;

phy_mb_data_sync #(.depth(2), .p_width(6),.d_rst_val(6'h3F)) i_mb_data_sync_pipe_local_fs (
   .dest_clk     (pipe_clk),
   .dest_rst_n   (pipe_rst_n),
   .source_dat   (pma_tx_local_fs),
   .dest_dat     (pipe_tx_local_fs)
   );

phy_mb_data_sync #(.depth(2), .p_width(6),.d_rst_val(6'h15)) i_mb_data_sync_pipe_local_lf (
   .dest_clk     (pipe_clk),
   .dest_rst_n   (pipe_rst_n),
   .source_dat   (pma_tx_local_lf),
   .dest_dat     (pipe_tx_local_lf)
   );

endmodule
