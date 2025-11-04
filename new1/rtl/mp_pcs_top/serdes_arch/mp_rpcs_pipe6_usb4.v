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
// Module         : mp_rpcs_pipe6_usb4
// Author         : Dongdong Wang
// Created        : July 23, 2025
// Abstract       : Receive data path for PIPE6 SerDes architecture
//
//                  Maps the PMA Rx data to the PIPE Rx data based on the data
//                  rate.
//
//                  Sets/clears PIPE RxValid output based on when recovered 
//                  clock is valid.
//
// Notes          : Based on mp_rpcs_pipe6 authored by Fred Stivers
// 
//----------------------------------------------------------------------------

module mp_rpcs_pipe6_usb4 (
// Recovered clock and reset
input              rx_rd_clk,
input              rx_rst_n,

input              scanmode,
// Control signals
input              rx_en,
input       [1:0]  pipe_rate,
input              override_en,

// PIPE interface signals
output reg  [39:0] pipe_rx_data,
output reg         pipe_rx_valid,

// PMA interface signals
input       [31:0] pma_rx_rd
);

// *****************************************************
// Declarations

// *****************************************************
// Drive pipe_rx_data from pma_rx_rd
always @*
begin
if (override_en)
   begin
   pipe_rx_data = {8'b0, pma_rx_rd};
   end
else
   begin
   case (pipe_rate)
   // USB4 Gen 3 @20G. only lower 40bits are used
   2'b01  : pipe_rx_data = {2'd0, pma_rx_rd[31:24], 2'd0, pma_rx_rd[23:16],
                            2'd0, pma_rx_rd[15:8],  2'd0, pma_rx_rd[7:0]};
   //// USB4 Gen 4 @40G. all 56bits are used
   //3'b010  : pipe_rx_data = {pma_rx_rd_1[27:0], pma_rx_rd[27:0]};
   // USB4 Gen 2 @10G. only lower 40bits are used
   default : pipe_rx_data = {2'd0, pma_rx_rd[31:24], 2'd0, pma_rx_rd[23:16],
                             2'd0, pma_rx_rd[15:8],  2'd0, pma_rx_rd[7:0]};
   endcase
   end
end

// --- use below logic if rx_en_sync de-asserted but rx_rd_clk is stopped ---//
// Reset synchronizer for rx_valid
phy_reset_sync u_phy_reset_sync_rx_rx_clk (
   .sync_clock_in              (rx_rd_clk),
   .reset_in_n                 (rx_en & rx_rst_n),
   .reset_out_n                (rx_rd_clk_rst_n),
   .upstream_reset_in_n        (1'b1),
   .scan_mode_en_in            (scanmode),
   .scan_reset_in_n            (rx_rst_n)
   );

// Clear pipe_rx_valid upon a rate change or whenever
//   in a power state where Rx is not enabled.
// Set pipe_rx_valid upon first rising edge of 
//   pipe_rx_clk.  The recovered clock is valid
//   upon start
always @(posedge rx_rd_clk or negedge rx_rd_clk_rst_n)
begin
if (~rx_rd_clk_rst_n)
   begin
   pipe_rx_valid <= 1'b0;
   end
else
   begin
   pipe_rx_valid <= 1'b1;
   end
end


// --- use below code if rx_en_sync is low and rx_rd_clk is still running ---//
//// Reset synchronizer for rx_valid
//phy_reset_sync u_phy_reset_sync_rx_rx_clk (
//   .sync_clock_in              (rx_rd_clk),
//   .reset_in_n                 (rx_rst_n),
//   .reset_out_n                (rx_rd_clk_rst_n),
//   .upstream_reset_in_n        (1'b1),
//   .scan_mode_en_in            (scanmode),
//   .scan_reset_in_n            (rx_rst_n)
//   );
//
//wire rx_en_sync;
//
//// Synchronize pipe_restore_n
//phy_data_sync #(.RESET_VALUE (1'b1)) u_phy_data_sync_rx_en (
//   .clock   (rx_rd_clk),
//   .reset_n (rx_rd_clk_rst_n),
//   .d_in    (rx_en),
//   .d_out   (rx_en_sync)
//   );
//
//always @(posedge rx_rd_clk or negedge rx_rd_clk_rst_n)
//begin
//if (~rx_rd_clk_rst_n)
//   begin
//   pipe_rx_valid <= 1'b0;
//   end
//else if (~rx_en_sync)
//   begin 
//   pipe_rx_valid <= 1'b0;
//   end
//else
//   begin
//   pipe_rx_valid <= 1'b1;
//   end
//end   

endmodule
