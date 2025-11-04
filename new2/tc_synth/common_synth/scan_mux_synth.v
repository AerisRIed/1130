module scan_mux_synth (
   input  scan_mode_en_in, // Scan mode enable.
   input  scan_signal_in,  // Scan signal (scan clock, scan reset, etc).
   input  fcn_signal_in,   // Functional signal (input) to have scan mux added to.
   output fcn_signal_out   // Functional signal (output) to have scan mux added to.
);

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

