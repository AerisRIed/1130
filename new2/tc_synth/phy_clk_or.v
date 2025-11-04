//------------------------------------------------------------------------------
//  $Id: phy_clk_or.v 8751 2017-11-08 22:04:41Z freds $
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
//   Module Name    : phy_clk_or
//
//   Filename       : phy_clk_or.v
//
//   Author         : Dave Masters
//
//   Date           : 4 May 2022
//
//   Limitations    : 
//
//------------------------------------------------------------------------------
//   Description    : clock OR.
//                    Can be replaced by customer to instantiate specific
//                    clock OR cell.
//
//------------------------------------------------------------------------------
//   Revision Control
//
//   see cvs log
//------------------------------------------------------------------------------
 
module phy_clk_or (

  input       clk_in0,
  input       clk_in1,
  output      clk_out
  
);
  
//assign  clk_out = clk_in0 | clk_in1;

`ifdef USE_TSMC_N4P_LIB
  CKOR2MZD4BWP210H6P51CNODLVT  u_dont_touch_ck_or (
      .A1    (clk_in0),
      .A2    (clk_in1),
      .Z     (clk_out)
  );

`else
  "ERROR: Need Define TSMC_N4P LIB"
`endif
  
endmodule

