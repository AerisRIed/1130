//-----------------------------------------------------------------------------
//    This confidential and proprietary HDL soft description of a Hardware
//    component may be used only as authorized by a licensing agreement from
//    Cadence. In the event of publication, the following notice 
//    is applicable:
//
//                       (C) COPYRIGHT 2007 Cadence
//                         ALL RIGHTS RESERVED
//
//     The entire notice above must be reproduced on all authorized
//     copies of this code.
//-----------------------------------------------------------------------------
//-----------------------------------------------------------------------------
//
// Filename       : phy_reset_sync.v
// Version        : $Revision: 429 $
// Date / Time    : $Date: 2011-11-30 14:03:02 -0500 (Wed, 30 Nov 2011) $
// 
// Author         : Loren Reiss
// Abstract       : 
//    This module sychronizes the input reset signal to the input clock signal.
//    The upstream_reset_in_n input is used to cascade multiple resets together 
//    where the release of one reset is dependent on the prior release of an
//    upstream reset.  If there are no upstream resets, this input can be set
//    to 1.  
//
//    Note: The reset implemented in this module is an active low reset.
//    
//    This module also adds a scan mux at the end to select a specified 
//    reset signal for scan.
//    
// Reference      : 
// 
//-----------------------------------------------------------------------------
 
module phy_reset_sync 
#( 
   parameter
      NUM_FLOPS = 2
)(   
   input  sync_clock_in,        // Clock that reset is to be synchronized to.
   input  reset_in_n,           // Input (unsynchronized) reset.
   output reset_out_n,          // Output (synchronized) reset.
   input  upstream_reset_in_n,  // Upstream reset signal.
   input  scan_mode_en_in,      // Scan mode enable.
   input  scan_reset_in_n       // Scan reset.
);

   wire   reset_n_synced;


   reg [NUM_FLOPS-1:0] reset_sync_flop;

phy_scan_mux u_phy_scan_mux_reset_in_n(
   .scan_mode_en_in (scan_mode_en_in),
   .scan_signal_in  (scan_reset_in_n), 
   .fcn_signal_in   (reset_in_n),  
   .fcn_signal_out  (scan_reset_out_n) 
);

generate
   if (NUM_FLOPS == 0)
   begin : NO_SYNC_FLOPS
   assign reset_n_synced = scan_reset_out_n;
   end

   else
   begin : WITH_SYNC_FLOPS
//   always @(posedge sync_clock_in or negedge scan_reset_out_n) 
//   begin
//      if (!scan_reset_out_n) 
//         reset_sync_flop <= {NUM_FLOPS{1'b0}};
//      else 
//         reset_sync_flop <= {reset_sync_flop[NUM_FLOPS-2:0], upstream_reset_in_n};
//   end
// 
//   assign reset_n_synced = reset_sync_flop[NUM_FLOPS-1];

reset_sync_synth #(
    .NUM_FLOPS (NUM_FLOPS)
  ) u_reset_sync_synth(
    .sync_clock_in           (sync_clock_in),
    .reset_in_n              (scan_reset_out_n),
    .upstream_reset_in_n     (upstream_reset_in_n),
    .reset_n_synced          (reset_n_synced)
  );

   end
endgenerate


phy_scan_mux u_phy_scan_mux_reset_n_out(
   .scan_mode_en_in (scan_mode_en_in),
   .scan_signal_in  (scan_reset_in_n), 
   .fcn_signal_in   (reset_n_synced),  
   .fcn_signal_out  (reset_out_n) 
);


endmodule
