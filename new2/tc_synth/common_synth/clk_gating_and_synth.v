module clk_gating_and_synth
(   
   input  en,
   input  clk_in,
   output clk_out
);

   //-----------------------------------------------------------------------------
   // Clock AND gate.
   //-----------------------------------------------------------------------------
`ifdef USE_TSMC_N4P_LIB
  CKAN2MVPMZD8BWP210H6P51CNODLVT u_dont_touch_ck_and (
      .A1    (en),
      .A2    (clk_in),
      .Z     (clk_out)
  );

`else
  "ERROR: Need Define TSMC_N4P LIB"
`endif



endmodule

