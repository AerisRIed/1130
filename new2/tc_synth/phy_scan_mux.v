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
// Filename       : phy_scan_mux.v
// Version        : $Revision: 429 $
// Date / Time    : $Date: 2011-11-30 14:03:02 -0500 (Wed, 30 Nov 2011) $
// 
// Author         : Loren Reiss
// Abstract       : 
//    This module is simply a two input MUX for scan purposes.  It is to be
//    used for muxing the scan clock with the functional clock and muxing the 
//    scan reset with the functional reset.
//    
//    The purpose of having the scan MUX explicately created in a stand 
//    alone module is to help out with the physical design clock tree 
//    generation.  The physical designer requested that a named MUX be used
//    for the scan MUX, so they have a known solid starting point to generate
//    the clock trees from.
//    
//    This module is the MUX in its RTL form only.  It is intended to be 
//    replaced at synthesis by one the desired technology specific MUX for a 
//    given design.
//    
// Reference      : 
// 
//-----------------------------------------------------------------------------
 
// Putting in these pragmas so this module is not accidentally used for synthesis.
module phy_scan_mux (
   input  scan_mode_en_in, // Scan mode enable.
   input  scan_signal_in,  // Scan signal (scan clock, scan reset, etc).
   input  fcn_signal_in,   // Functional signal (input) to have scan mux added to.
   output fcn_signal_out   // Functional signal (output) to have scan mux added to.
);

//   assign fcn_signal_out = scan_mode_en_in ? // cadence map_to_mux 
//                           scan_signal_in : fcn_signal_in;

`ifdef USE_TSMC_N4P_LIB
  CKMUX2MZD4BWP210H6P51CNODLVT u_dont_touch_scan_mux (
      .I0    (fcn_signal_in),
      .I1    (scan_signal_in),
      .S     (scan_mode_en_in),
      .Z     (fcn_signal_out)
  );
`else
  "ERROR: Need Define TSMC_N4P LIB"
`endif

endmodule
