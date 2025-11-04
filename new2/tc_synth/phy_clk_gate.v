//------------------------------------------------------------------------------
//  $Id$
//------------------------------------------------------------------------------
//                                     
//            CADENCE                    Copyright (c) 2013
//                                       Cadence Design Systems, Inc.
//            SoCR                       All rights reserved.
//
//  This work may not be copied, modified, re-published, uploaded, executed, or
//  distributed in any way, in any medium, whether in whole or in part, without
//  prior written permission from Cadence Design Systems, Inc.
//------------------------------------------------------------------------------
//                                     
//   Module Name    : phy_clk_gate
//
//   Filename       : phy_clk_gate.v
//
//   Author         : Steven Ho
//
//   Date           : 17 Jun 2013
//
//   Limitations    : 
//
//------------------------------------------------------------------------------
//   Description    : Latch based clock gate.
//                    Can be replaced by customer to instantiate specific
//                    clock gate cell.
//
//------------------------------------------------------------------------------
//   Revision Control
//
//   see cvs log
//------------------------------------------------------------------------------
 
module phy_clk_gate (

  input       clk_in,
  input       clk_en,
  input       scanen,
  output      clk_out
  
);
  
//  reg     latch_enabled;
//  
//  // Bypass latch if scan testing
//  wire    enable;
//  assign  enable  = clk_en || scanen;
//  
//  always@(clk_in or enable)
//  begin
//    if (~clk_in)
//      latch_enabled  <=  enable;
//  end
//  
//  assign  clk_out = clk_in && latch_enabled;

clk_gating_cell_synth u_clk_gating_cell_synth(
    .clk_in       (clk_in),
    .en_synced    (clk_en),
    .scanen       (scanen),
    .clk_out      (clk_out)
);

endmodule
