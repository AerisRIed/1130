//-----------------------------------------------------------------------------
//    This confidential and proprietary HDL soft description of a Hardware
//    component may be used only as authorized by a licensing agreement from
//    Cadence. In the event of publication, the following notice 
//    is applicable:
//
//                       (C) COPYRIGHT 2010 Cadence
//                         ALL RIGHTS RESERVED
//
//     The entire notice above must be reproduced on all authorized
//     copies of this code.
//-----------------------------------------------------------------------------
//-----------------------------------------------------------------------------
//
// Filename       : phy_clock_mux.v
// Version        : $Revision: 429 $
// Date / Time    : $Date: 2011-11-30 14:03:02 -0500 (Wed, 30 Nov 2011) $
// 
// Author         : Loren Reiss
// Abstract       : 
//    This module is simply a parameterizable MUX for clock selection purposes.
//    It is implemented as a stand alone module to help out with physical
//    design (so the physical designers can easily identify clock MUXes and
//    their respective pins).
//    
//    *** Note : It is assumed that the maximum number of input clocks is 8.
//    
//-----------------------------------------------------------------------------
 
module phy_clock_mux 
#(
   parameter
      NUM_CLOCKS = 2,    // Number of clocks that can be selected by this module.
      NUM_CLOCK_SEL = 1  // Number of  clock select signals.  
                         // *** Note that it is up to the user to set this
                         //     to a value that makes sense for the number
                         //     of clocks that are specified for example:
                         //     - 2 clock bits, 1 select bit.
                         //     - 4 clock bits, 2 select bit.
) (
   input  [NUM_CLOCKS-1:0]    clk_in,
   input  [NUM_CLOCK_SEL-1:0] clk_sel,
   output reg                 clk_out
);

   //-----------------------------------------------------------------------------
   // Implementing this using an if then else structure based on NUM_CLOCKS.
   // Originally we started with the code in the else part of this structure.
   // This worked perfectly for simulations, but for some reason, it never really
   // synthesized well.
   //-----------------------------------------------------------------------------

//generate
//   // 2 input clock MUX.
//   if (NUM_CLOCKS == 2)
//   begin: CLOCK_MUX_2
//      always @(*)
//      begin
//         case (clk_sel)  // cadence map_to_mux
//            1'b0    : clk_out = clk_in[0];
//            default : clk_out = clk_in[1];
//         endcase
//      end  
//   end
//
//   // 3 input clock MUX.
//   else if (NUM_CLOCKS == 3)
//   begin: CLOCK_MUX_3
//      always @(*)
//      begin
//         case (clk_sel)  // cadence map_to_mux
//            2'b00   : clk_out = clk_in[0];
//            2'b01   : clk_out = clk_in[1];
//            default : clk_out = clk_in[2];
//         endcase
//      end  
//   end
//
//   // 4 input clock MUX.
//   else if (NUM_CLOCKS == 4)
//   begin: CLOCK_MUX_4
//      always @(*)
//      begin
//         case (clk_sel)  // cadence map_to_mux
//            2'b00   : clk_out = clk_in[0];
//            2'b01   : clk_out = clk_in[1];
//            2'b10   : clk_out = clk_in[2];
//            default : clk_out = clk_in[3];
//         endcase
//      end  
//   end
//
//   // All other clock MUXes.
//   else
//   begin: CLOCK_MUX_GTR4
//      //-----------------------------------------------------------------------------
//      // Internal signal definitions.
//      //-----------------------------------------------------------------------------
//
//      wire [7:0] clk_in_int;
//      wire [2:0] clk_sel_int;
//      
//      //-----------------------------------------------------------------------------
//      // Expand input pins to fit internal versions of signals.
//      //-----------------------------------------------------------------------------
//      
//      assign clk_in_int = {{8-NUM_CLOCKS{1'b0}}, clk_in};
//      assign clk_sel_int = {{3-NUM_CLOCK_SEL{1'b0}}, clk_sel};
//      
//      //-----------------------------------------------------------------------------
//      // Actual MUX implementation.
//      //-----------------------------------------------------------------------------
//
//      always @(*)
//      begin
//         case (clk_sel_int)
//            3'b000  : clk_out = clk_in_int[0];
//            3'b001  : clk_out = clk_in_int[1];
//            3'b010  : clk_out = clk_in_int[2];
//            3'b011  : clk_out = clk_in_int[3];
//            3'b100  : clk_out = clk_in_int[4];
//            3'b101  : clk_out = clk_in_int[5];
//            3'b110  : clk_out = clk_in_int[6];
//            default : clk_out = clk_in_int[7];
//         endcase
//      end  
//   end 
//endgenerate

`ifdef USE_TSMC_N4P_LIB

generate
   // 2 input clock MUX.
   if (NUM_CLOCKS == 2)
   begin: CLOCK_MUX_2
     CKMUX2MZD4BWP210H6P51CNODLVT u_dont_touch_ck_mux (
         .I0    (clk_in[0]),
         .I1    (clk_in[1]),
         .S     (clk_sel[0]),
         .Z     (clk_out)
     );
   end

   // 3 input clock MUX.
   else if (NUM_CLOCKS == 3)
   begin: CLOCK_MUX_3
     CKMUX2MZD4BWP210H6P51CNODLVT u_dont_touch_ck_mux_0 (
         .I0    (clk_in[0]),
         .I1    (clk_in[1]),
         .S     (clk_sel[0]),
         .Z     (n0)
     );

     CKMUX2MZD4BWP210H6P51CNODLVT u_dont_touch_ck_mux_1 (
         .I0    (n0),
         .I1    (clk_in[2]),
         .S     (clk_sel[1]),
         .Z     (clk_out)
     );
   end

   // 4 input clock MUX.
   else if (NUM_CLOCKS == 4)
   begin: CLOCK_MUX_4
     CKMUX2MZD4BWP210H6P51CNODLVT u_dont_touch_ck_mux_0 (
         .I0    (clk_in[0]),
         .I1    (clk_in[1]),
         .S     (clk_sel[0]),
         .Z     (n0)
     );

     CKMUX2MZD4BWP210H6P51CNODLVT u_dont_touch_ck_mux_1 (
         .I0    (clk_in[2]),
         .I1    (clk_in[3]),
         .S     (clk_sel[0]),
         .Z     (n1)
     );

     CKMUX2MZD4BWP210H6P51CNODLVT u_dont_touch_ck_mux_2 (
         .I0    (n0),
         .I1    (n1),
         .S     (clk_sel[1]),
         .Z     (clk_out)
     );
   end

   // All other clock MUXes.
   else
   begin: CLOCK_MUX_GTR4
      //-----------------------------------------------------------------------------
      // Internal signal definitions.
      //-----------------------------------------------------------------------------

      wire [7:0] clk_in_int;
      wire [2:0] clk_sel_int;
      
      //-----------------------------------------------------------------------------
      // Expand input pins to fit internal versions of signals.
      //-----------------------------------------------------------------------------
      
      assign clk_in_int = {{8-NUM_CLOCKS{1'b0}}, clk_in};
      assign clk_sel_int = {{3-NUM_CLOCK_SEL{1'b0}}, clk_sel};
      
      //-----------------------------------------------------------------------------
      // Actual MUX implementation.
      //-----------------------------------------------------------------------------
      //Level0
      CKMUX2MZD4BWP210H6P51CNODLVT u_dont_touch_ck_mux0 (
          .I0    (clk_in_int[0]),
          .I1    (clk_in_int[1]),
          .S     (clk_sel_int[0]),
          .Z     (n0)
      );

      CKMUX2MZD4BWP210H6P51CNODLVT u_dont_touch_ck_mux1 (
          .I0    (clk_in_int[2]),
          .I1    (clk_in_int[3]),
          .S     (clk_sel_int[0]),
          .Z     (n1)
      );

      CKMUX2MZD4BWP210H6P51CNODLVT u_dont_touch_ck_mux2 (
          .I0    (clk_in_int[4]),
          .I1    (clk_in_int[5]),
          .S     (clk_sel_int[0]),
          .Z     (n2)
      );

      CKMUX2MZD4BWP210H6P51CNODLVT u_dont_touch_ck_mux3 (
          .I0    (clk_in_int[6]),
          .I1    (clk_in_int[7]),
          .S     (clk_sel_int[0]),
          .Z     (n3)
      );
      
      //Level1
      CKMUX2MZD4BWP210H6P51CNODLVT u_dont_touch_ck_mux4 (
          .I0    (n0),
          .I1    (n1),
          .S     (clk_sel_int[1]),
          .Z     (n4)
      );

      CKMUX2MZD4BWP210H6P51CNODLVT u_dont_touch_ck_mux5 (
          .I0    (n2),
          .I1    (n3),
          .S     (clk_sel_int[1]),
          .Z     (n5)
      );

      //Level2
      CKMUX2MZD4BWP210H6P51CNODLVT u_dont_touch_ck_mux6 (
          .I0    (n4),
          .I1    (n5),
          .S     (clk_sel_int[2]),
          .Z     (clk_out)
      );
   end 
endgenerate


`else
  "ERROR: Need Define TSMC_N4P LIB"
`endif


endmodule
