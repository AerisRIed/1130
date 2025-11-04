module clk_gating_cell_synth (
    input     clk_in,
    input     en_synced,
    input     scanen,
    output    clk_out
);

`ifdef USE_TSMC_N4P_LIB

  CKLNQMVPMZD16BWP210H6P51CNODLVT u_dont_touch_icg(
      .TE    (scanen),
      .E     (en_synced),
      .CP    (clk_in),
      .Q     (clk_out)
  );

`else
  "ERROR: Need Define TSMC_N4P LIB"
`endif

endmodule

