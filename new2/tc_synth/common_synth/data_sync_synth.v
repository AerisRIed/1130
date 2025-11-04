// Module containing the technology specific data sync flops.
module data_sync_synth #(
    parameter RESET_VALUE = 0,
              NUM_FLOPS = 2
) (
    input     clock,
    input     reset_n,
    input     d_in,
    output    d_out
);

wire reset;

`ifdef USE_TSMC_N4P_LIB 
generate
  if(RESET_VALUE == 0) begin: reset_val_0
    
    CKNMVPMZD16BWP210H6P51CNODLVT u_dont_touch_reset_inv (
      .I    (reset_n),
      .ZN   (reset)
    );

    if(NUM_FLOPS == 0) begin: zero_stage
  CKBMVPMZD16BWP210H6P51CNODLVT u_dont_touch_data_sync_buffer(
      .I    (d_in),
      .Z    (d_out)
  );
    end
    else if(NUM_FLOPS == 1) begin: single_stage
      SDFRPQMZD2BWP210H6P51CNODLVT u_dont_touch_data_sync (
          .SI    (1'b0),
          .SE    (1'b0),
          .CD    (reset),
          .D     (d_in),
          .CP    (clock),
          .Q     (d_out)
      );
    end
    else if(NUM_FLOPS == 2) begin: two_stage
      SDFRPQMZD2BWP210H6P51CNODLVT u_dont_touch_data_sync_first (
          .SI    (1'b0),
          .SE    (1'b0),
          .CD    (reset),
          .D     (d_in),
          .CP    (clock),
          .Q     (d1)
      );
    
      SDFRPQMZD2BWP210H6P51CNODLVT u_dont_touch_data_sync_last (
          .SI    (1'b0),
          .SE    (1'b0),
          .CD    (reset),
          .D     (d1),
          .CP    (clock),
          .Q     (d_out)
      );
    end
    else begin: multi_stage
      wire [NUM_FLOPS-1 : 0] stage_wires;

      assign stage_wires[0] = d_in;

      SDFRPQMZD2BWP210H6P51CNODLVT u_dont_touch_data_sync_first (
          .SI    (1'b0),
          .SE    (1'b0),
          .CD    (reset),
          .D     (stage_wires[0]),
          .CP    (clock),
          .Q     (stage_wires[1])
      );
    

      genvar i;
      for(i=1; i<=NUM_FLOPS-2; i=i+1)begin: pipeline_stage
        SDFRPQMZD2BWP210H6P51CNODLVT u_dont_touch_data_sync (
            .SI    (1'b0),
            .SE    (1'b0),
            .CD    (reset),
            .D     (stage_wires[i]),
            .CP    (clock),
            .Q     (stage_wires[i+1])
      );
      end
     
      SDFRPQMZD2BWP210H6P51CNODLVT u_dont_touch_data_sync_last (
          .SI    (1'b0),
          .SE    (1'b0),
          .CD    (reset),
          .D     (stage_wires[NUM_FLOPS-1]),
          .CP    (clock),
          .Q     (d_out)
      );
    end
  end
  else begin: reset_val_1

        if(NUM_FLOPS == 0) begin: zero_stage
  CKBMVPMZD16BWP210H6P51CNODLVT u_dont_touch_data_sync_buffer(
      .I    (d_in),
      .Z    (d_out)
  );
    end
    else if(NUM_FLOPS == 1) begin: single_stage
      SDFSNQMZD2BWP210H6P51CNODLVT u_dont_touch_data_sync (
          .SI    (1'b0),
          .SE    (1'b0),
          .SDN   (reset_n),
          .D     (d_in),
          .CP    (clock),
          .Q     (d_out)
      );
    end
    else if(NUM_FLOPS == 2) begin: two_stage
      SDFSNQMZD2BWP210H6P51CNODLVT u_dont_touch_data_sync_first (
          .SI    (1'b0),
          .SE    (1'b0),
          .SDN   (reset_n),
          .D     (d_in),
          .CP    (clock),
          .Q     (d1)
      );
    
      SDFSNQMZD2BWP210H6P51CNODLVT u_dont_touch_data_sync_last (
          .SI    (1'b0),
          .SE    (1'b0),
          .SDN   (reset_n),
          .D     (d1),
          .CP    (clock),
          .Q     (d_out)
      );
    end
    else begin: multi_stage
      wire [NUM_FLOPS-1 : 0] stage_wires;

      assign stage_wires[0] = d_in;

      SDFSNQMZD2BWP210H6P51CNODLVT u_dont_touch_data_sync_first (
          .SI    (1'b0),
          .SE    (1'b0),
          .SDN   (reset_n),
          .D     (stage_wires[0]),
          .CP    (clock),
          .Q     (stage_wires[1])
      );
    

      genvar i;
      for(i=1; i<=NUM_FLOPS-2; i=i+1)begin: pipeline_stage
        SDFSNQMZD2BWP210H6P51CNODLVT u_dont_touch_data_sync (
            .SI    (1'b0),
            .SE    (1'b0),
            .SDN   (reset_n),
            .D     (stage_wires[i]),
            .CP    (clock),
            .Q     (stage_wires[i+1])
      );
      end
     
      SDFSNQMZD2BWP210H6P51CNODLVT u_dont_touch_data_sync_last (
          .SI    (1'b0),
          .SE    (1'b0),
          .SDN   (reset_n),
          .D     (stage_wires[NUM_FLOPS-1]),
          .CP    (clock),
          .Q     (d_out)
      );
    end
  end

endgenerate
`else
  "ERROR: Need Define TSMC_N4P LIB"
`endif

endmodule

