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
//   Module Name    : phy_and_synth
//
//   Filename       : phy_and_synth.v
//
//   Author         : Dave Masters
//
//   Date           : 23 Jun 2016
//
//   Limitations    : 
//
//------------------------------------------------------------------------------
//   Description    : And synth
//                    Can be replaced by customer to instantiate specific
//                    clock inverter cell.
//
//------------------------------------------------------------------------------
//   Revision Control
//
//   see cvs log
//------------------------------------------------------------------------------
 
module phy_and_synth (

  input       A,
  input       B,
  output      Z
  
);
  
//assign  Z = A & B;
`ifdef USE_TSMC_N4P_LIB
  CKAN2MVPMZD8BWP210H6P51CNODLVT u_dont_touch_ck_and (
      .A1    (A),
      .A2    (B),
      .Z     (Z)
  );

`else
  "ERROR: Need Define TSMC_N4P LIB"
`endif


endmodule

