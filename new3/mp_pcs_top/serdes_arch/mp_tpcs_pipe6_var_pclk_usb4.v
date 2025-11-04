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
// Module         : mp_tpcs_pipe6_var_pclk_usb4
// Author         : Dongdong Wang
// Created        : July 23, 2025
// Abstract       : Transmit data path for PIPE7 SerDes architecture
//
//                  Performs the PIPE Tx data to PMA Tx data bit shifting
//                  based on the data rate.
//   
//                  Performs Tx data metering as required.  If no data
//                  metering is needed, PIPE Tx data drives PMA Tx data 
//                  directly.
//
// Notes          : Based on mp_tpcs_pipe6_var_pclk authored by Fred Stivers
// 
//----------------------------------------------------------------------------

module mp_tpcs_pipe6_var_pclk_usb4 (
// PIPE interface signals
input       [1:0]  pipe_rate,
input       [39:0] pipe_tx_data,
input       [3:0]  pipe_tx_elec_idle,
input              pipe_tx_data_valid,

// PMA interface signals
output reg  [31:0] pma_tx_td,
output reg         pma_tx_elec_idle,

input              override_en
);

// *****************************************************
// Declarations
reg [31:0] int_pipe_tx_data;
reg        int_pipe_tx_elec_idle;

// *****************************************************
// Drive TxElecIdle high if TxDataValid low
always @*
begin
if (pipe_tx_data_valid)
   begin
   int_pipe_tx_elec_idle = pipe_tx_elec_idle[0];
   end
else
   begin
   int_pipe_tx_elec_idle = 1'b1;
   end
end

// *****************************************************
// As necessary, shift PIPE Tx data based on data rate.
always @*
begin
if (override_en)
   begin
   int_pipe_tx_data = pipe_tx_data[31:0];
   end
else
   begin
   case (pipe_rate)
   // USB4 Gen 3 @20G (128/132 encoding)
   2'b01  : begin // only lower 40bits used: extract 8bits from every 10bits
             int_pipe_tx_data = {pipe_tx_data[37:30], pipe_tx_data[27:20],
                                 pipe_tx_data[17:10], pipe_tx_data[7:0]};             
            end
   //// USB4 Gen 4 @40G
   //2'b10  : begin // 56bit are used, mapping to 28bits*2, how?
   //          int_pipe_tx_data   = {4'b0, pipe_tx_data[27:0]};
   //          int_pipe_tx_data_1 = {4'b0, pipe_tx_data[55:28]};
   //         end
   // USB4 Gen 2 @10G (128/132 encoding)
   default : begin // only lower 40bits used: extract 8bits from every 10bits
             int_pipe_tx_data = {pipe_tx_data[37:30], pipe_tx_data[27:20],
                                 pipe_tx_data[17:10], pipe_tx_data[7:0]};             
             end
   endcase
   end
end

// *****************************************************
always @*
begin
pma_tx_td = int_pipe_tx_data;
if (pipe_rate == 2'b10)
   // Gen 4 - only bits 0 used
   begin
   pma_tx_elec_idle = int_pipe_tx_elec_idle;
   end
else
   // All other rates
   begin
   pma_tx_elec_idle = int_pipe_tx_elec_idle;
   end
end

endmodule
