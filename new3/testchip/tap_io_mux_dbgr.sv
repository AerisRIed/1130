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
// Filename        : tap_io_mux_dbgr.sv
// 
// Author          : Fred Stivers / Jonathan Tung / Zhenwei Liu
// Abstract        : This module instantiates the IO muxes for the USB Type-C
//                   testchip. Based on pad_sel_tap, it determines which tap
//                   controller to access
//
//-----------------------------------------------------------------------------

module tap_io_mux_dbgr (
  // Chip IO Interface
  input       [3:0]   param_uc_sel_tap,
  input               pad_uc_tap_tck,
  input               pad_uc_tap_tms,
  input               pad_uc_tap_trst_n,
  input               pad_uc_tap_tdi,
  output reg          pad_uc_tap_tdo,
 
  // uC debugger JTAG interfaces for x1 and x2 PHY 

  // Shared signals
  output              mux_uc_tap_tck,
  output              mux_uc_tap_trst,
  output              mux_uc_tap_tdi,

  // x2 PHY lane 0 uC
  output reg          mux_uc_l01_tap_tms,
  input               mux_uc_l01_tap_tdo,

  // x2 PHY lane 1 uC
  output reg          mux_uc_l23_tap_tms,
  input               mux_uc_l23_tap_tdo,

  // x2 PHY top uC
  output reg          mux_uc_top_tap_tms,
  input               mux_uc_top_tap_tdo
);

//-----------------------------------------------------------------------------------
// Internal IO muxing
//-----------------------------------------------------------------------------------

// Tap controller selection
//   0x0     - x2 PHY lane 0/1
//   0x1     - x2 PHY lane 2/3
//   0x2-0xf - x2 PHY top

always @*
begin
case (param_uc_sel_tap)
4'h0 :
   begin
   mux_uc_l01_tap_tms   = pad_uc_tap_tms;
   mux_uc_l23_tap_tms   = 1'b1;
   mux_uc_top_tap_tms   = 1'b1;
   pad_uc_tap_tdo       = mux_uc_l01_tap_tdo;
   end
4'h1 :
   begin
   mux_uc_l01_tap_tms   = 1'b1;
   mux_uc_l23_tap_tms   = pad_uc_tap_tms;
   mux_uc_top_tap_tms   = 1'b1;
   pad_uc_tap_tdo       = mux_uc_l23_tap_tdo;
   end
default :
   begin
   mux_uc_l01_tap_tms   = 1'b1;
   mux_uc_l23_tap_tms   = 1'b1;
   mux_uc_top_tap_tms   = pad_uc_tap_tms;
   pad_uc_tap_tdo       = mux_uc_top_tap_tdo;
   end
endcase
end

assign mux_uc_tap_tck   = pad_uc_tap_tck; 
assign mux_uc_tap_trst  = pad_uc_tap_trst_n;
assign mux_uc_tap_tdi   = pad_uc_tap_tdi;

endmodule

