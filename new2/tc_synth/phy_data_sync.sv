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
// Filename       : phy_data_sync.v
// Version        : $Revision: 1302 $
// Date / Time    : $Date: 2012-06-19 14:13:38 -0400 (Tue, 19 Jun 2012) $
// 
// Author         : Loren Reiss
// Abstract       : 
//    This module is a simple dual flop data synchronizer, which simply 
//    synchronizes the incoming data d_in to the clock.  It is a pretty 
//    trivial piece of logic, but we need to do this a lot, so this module
//    was created.
//    
//-----------------------------------------------------------------------------
module phy_data_sync 
#( 
   parameter
      RESET_VALUE = 1'b0,
      NUM_FLOPS = 2,
      OVERRIDE_META = 0
)(   
   input  clock,      // Clock that data is to be synchronized to.
   input  reset_n,    // Reset.
   input  d_in,       // Unsyncronized data in.
   output d_out       // Syncronized data out.
);


data_sync_synth #(
  .RESET_VALUE (RESET_VALUE),
  .NUM_FLOPS   (NUM_FLOPS)
  ) u_data_sync_synth (
        .clock   (clock),
        .reset_n (reset_n),
        .d_in    (d_in),
        .d_out   (d_out)
  );


endmodule

