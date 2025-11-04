//------------------------------------------------------------------------------
//  $Id: phy_clk_inv.v 8751 2017-11-08 22:04:41Z freds $
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
//   Module Name    : phy_clk_inv
//
//   Filename       : phy_clk_inv.v
//
//   Author         : Dave Masters
//
//   Date           : 23 Jun 2016
//
//   Limitations    : 
//
//------------------------------------------------------------------------------
//   Description    : clock inverter.
//                    Can be replaced by customer to instantiate specific
//                    clock inverter cell.
//
//------------------------------------------------------------------------------
//   Revision Control
//
//   see cvs log
//------------------------------------------------------------------------------
 
module phy_clk_inv (

  input       clk_in,
  output      clk_out_n
  
);
  
//assign  clk_out_n = ~clk_in;
  
`ifdef USE_TSMC_N4P_LIB
  CKNMVPMZD16BWP210H6P51CNODLVT u_dont_touch_ck_inv (
      .I    (clk_in),
      .ZN   (clk_out_n)
  );

`else
  "ERROR: Need Define TSMC_N4P LIB"
`endif

endmodule

