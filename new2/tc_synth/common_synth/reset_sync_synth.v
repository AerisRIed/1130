module reset_sync_synth #(
    parameter   NUM_FLOPS=2
) (
    input     sync_clock_in,
    input     reset_in_n,
    input     upstream_reset_in_n,
    output    reset_n_synced
);

wire reset_in;


CKNMVPMZD16BWP210H6P51CNODLVT u_dont_touch_reset_inv (
    .I    (reset_in_n),
    .ZN   (reset_in)
);

`ifdef USE_TSMC_N4P_LIB

generate
        if(NUM_FLOPS == 0) begin: zero_stage
  CKBMVPMZD16BWP210H6P51CNODLVT u_dont_touch_reset_sync_buffer(
      .I    (upstream_reset_in_n),
      .Z    (reset_n_synced)
  );
    end
    else  if(NUM_FLOPS==2) begin: two_stage
    SDFRPQMZD2BWP210H6P51CNODLVT u_dont_touch_reset_sync_first (
          .SI    (1'b0),
          .SE    (1'b0),
          .CD    (reset_in),
          .D     (upstream_reset_in_n),
          .CP    (sync_clock_in),
          .Q     (d1)
      );
 
    SDFRPQMZD2BWP210H6P51CNODLVT u_dont_touch_reset_sync_last (
          .SI    (1'b0),
          .SE    (1'b0),
          .CD    (reset_in),
          .D     (d1),
          .CP    (sync_clock_in),
          .Q     (reset_n_synced)
      );
  end
  else begin: multi_stage
      wire [NUM_FLOPS-1 : 0] stage_wires;

      assign stage_wires[0] = upstream_reset_in_n;

      SDFRPQMZD2BWP210H6P51CNODLVT u_dont_touch_reset_sync_first (
          .SI    (1'b0),
          .SE    (1'b0),
          .CD    (reset_in),
          .D     (stage_wires[0]),
          .CP    (sync_clock_in),
          .Q     (stage_wires[1])
      );
    

      genvar i;
      for(i=1; i<=NUM_FLOPS-2; i=i+1)begin: pipeline_stage
        SDFRPQMZD2BWP210H6P51CNODLVT u_dont_touch_reset_sync (
            .SI    (1'b0),
            .SE    (1'b0),
            .CD    (reset_in),
            .D     (stage_wires[i]),
            .CP    (sync_clock_in),
            .Q     (stage_wires[i+1])
      );
      end
     
      SDFRPQMZD2BWP210H6P51CNODLVT u_dont_touch_reset_sync_last (
          .SI    (1'b0),
          .SE    (1'b0),
          .CD    (reset_in),
          .D     (stage_wires[NUM_FLOPS-1]),
          .CP    (sync_clock_in),
          .Q     (reset_n_synced)
      );

  end

endgenerate


`else
  "ERROR: Need Define TSMC_N4P LIB"
`endif


endmodule

