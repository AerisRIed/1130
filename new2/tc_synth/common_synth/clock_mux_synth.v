module  clock_mux_synth
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
