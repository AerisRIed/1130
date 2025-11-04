//-----------------------------------------------------------------------------
//    This confidential and proprietary HDL soft description of a Hardware
//    component may be used only as authorized by a licensing agreement from
//    Cadence. In the event of publication, the following notice 
//    is applicable:
//
//                       (C) COPYRIGHT 2019 Cadence
//                         ALL RIGHTS RESERVED
//
//     The entire notice above must be reproduced on all authorized
//     copies of this code.
//-----------------------------------------------------------------------------
//-----------------------------------------------------------------------------
//
// Filename        : phy_mux4to1_synt.v
// Version         : $Revision: 418 $
// Date / Time     : $Date: 2011-11-10 17:20:59 -0500 (Thu, 10 Nov 2011) $
// 
// Author          : Fred Stivers
// Abstract        : This module is a single bit 4 to 1 mux.
//                   This is created so that the synthesis tool can be used to
//		     preserve and synthesize this into a mux gate with a
//		     specific name ( name of the module here) aiding in place
//		     and route and constraint definitions on mux pins.
// 
//-----------------------------------------------------------------------------
 
module phy_mux4to1_synth  
(
   input            muxin_a,      
   input            muxin_b,      
   input            muxin_c,      
   input            muxin_d,      
   input      [1:0] sel,      
   output reg       muxout      
);

//always @*
//begin
//case (sel)
//2'd0 : muxout = muxin_a;
//2'd1 : muxout = muxin_b;
//2'd2 : muxout = muxin_c;
//2'd3 : muxout = muxin_d;
//endcase
//end
`ifdef USE_TSMC_N4P_LIB
     CKMUX2MZD4BWP210H6P51CNODLVT u_dont_touch_ck_mux_0 (
         .I0    (muxin_a),
         .I1    (muxin_b),
         .S     (sel[0]),
         .Z     (n0)
     );

     CKMUX2MZD4BWP210H6P51CNODLVT u_dont_touch_ck_mux_1 (
         .I0    (muxin_c),
         .I1    (muxin_d),
         .S     (sel[0]),
         .Z     (n1)
     );

     CKMUX2MZD4BWP210H6P51CNODLVT u_dont_touch_ck_mux_2 (
         .I0    (n0),
         .I1    (n1),
         .S     (sel[1]),
         .Z     (muxout)
     );
`else
     "ERROR: Need Define TSMC_N4P LIB"
`endif


endmodule


