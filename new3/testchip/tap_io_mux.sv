//-----------------------------------------------------------------------------
//    This confidential and proprietary HDL soft description of a Hardware
//    component may be used only as authorized by a licensing agreement from
//    Cadence. In the event of publication, the following notice 
//    is applicable:
//
//                       (C) COPYRIGHT 2016 Cadence
//                         ALL RIGHTS RESERVED
//
//     The entire notice above must be reproduced on all authorized
//     copies of this code.
//-----------------------------------------------------------------------------
//-----------------------------------------------------------------------------
//
// Filename        : tap_io_mux.v
// 
// Author          : Fred Stivers / Jonathan Tung / Zhenwei Liu
// Abstract        : This module instantiates the IO muxes for the USB Type-C PHY 
//                   testchip. Based on pad_sel_tap, it determines which tap
//                   controller to access
//
//-----------------------------------------------------------------------------

module tap_io_mux (
  // Chip IO Interface
  input       [1:0]   pad_sel_tap,
  input               pad_tap_tck,
  input               pad_tap_tms,
  input               pad_tap_trst_n,
  input               pad_tap_tdi,
  output reg          pad_tap_tdo,
  
  // Shared
  output              mux_tap_tck,
  output              mux_tap_trst_n,
  output              mux_tap_tdi,
  
  // TC JTAG
  output reg          mux_tc_tap_tms,
  input               mux_tc_tap_tdo,
  
  // PHY JTAG
  output reg          mux_tap_tms,
  input               mux_tap_tdo
  
);

//-----------------------------------------------------------------------------------
// Internal IO muxing
//-----------------------------------------------------------------------------------

// Tap controller selection
// 0b00 = USB Type-C PHY Tap controller
// 0b1x = Testchip Tap controller
always @*
begin
if (pad_sel_tap == 2'b00)
   begin
   mux_tc_tap_tms     = 1'b1;
   mux_tap_tms        = pad_tap_tms;
   pad_tap_tdo        = mux_tap_tdo;
   end
else
   begin
   mux_tc_tap_tms     = pad_tap_tms;
   mux_tap_tms        = 1'b1;
   pad_tap_tdo        = mux_tc_tap_tdo;
   end
end

assign mux_tap_tck       = pad_tap_tck; 
assign mux_tap_trst_n    = pad_tap_trst_n;
assign mux_tap_tdi       = pad_tap_tdi;

endmodule

