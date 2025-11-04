`timescale 1ps/100fs
module decode_parallel_lock (
    input  logic        clk,
    input  logic        rst_n,
    input  logic        enable,
    input  logic        din_valid,    // active-low: 0 = sample this cycle
    input  logic [31:0] din,
    output logic [31:0] dout,
    output logic        valid,        // 1-cycle pulse when dout is valid after lock
    output logic        locked       // stays high after comma found
    // output logic        dout_clk      // same pulse as valid
);

    localparam logic [31:0] COMMA = 32'hDEADBEEF;

    // Serial detect shift register (pre-lock only): new bit enters bit31 (right shift)
    logic [31:0] shift_sr;

    // Lock state and offset info
    logic        locked_r;
    logic  [4:0] comma_end_idx;   // bit index (0..31) in current din where COMMA ends
    logic  [5:0] offset_reg;      // (i+1) % 32: first bit after COMMA relative to 32-bit boundary
    logic        offset_valid;

    // Detection flags
    logic        detect_this_cycle;
    logic  [4:0] detect_idx_tmp;

    // Raw words for alignment window (previous and current sampled din)
    logic [31:0] prev_raw;
    logic [31:0] curr_raw;

    // One-cycle delay after lock before first aligned output
    logic        post_lock_phase;

    // Combinational detection (simulate 32 serial shifts within sampled word)
    always @* begin
        detect_this_cycle = 1'b0;
        detect_idx_tmp    = 5'd0;

        if (!din_valid && enable && !locked_r) begin
            logic [31:0] tmp = shift_sr;
            int i;
            for (i = 0; i < 32; i++) begin
                // New bit enters MSB (bit31), shift right
                tmp = { din[i], tmp[31:1] };
                if (!detect_this_cycle && tmp == COMMA) begin
                    detect_this_cycle = 1'b1;
                    detect_idx_tmp    = i[4:0];
                end
            end
        end
    end

    // Sequential logic
    always @(posedge clk or negedge rst_n) begin
        if (!rst_n) begin
            shift_sr        <= 32'd0;
            locked_r        <= 1'b0;
            comma_end_idx   <= 5'd0;
            offset_reg      <= 6'd0;
            offset_valid    <= 1'b0;
            prev_raw        <= 32'd0;
            curr_raw        <= 32'd0;
            post_lock_phase <= 1'b0;
            dout            <= 32'd0;
            valid           <= 1'b0;
            // dout_clk        <= 1'b0;
        end else begin
            valid    <= 1'b0;
            // dout_clk <= 1'b0;

            if (!enable) begin
                locked_r        <= 1'b0;
                offset_valid    <= 1'b0;
                post_lock_phase <= 1'b0;
            end else if (!din_valid) begin
                // New parallel word sampled
                prev_raw <= curr_raw;
                curr_raw <= din;

                if (!locked_r) begin
                    // Perform 32 serial shifts to update shift_sr end state
                    logic [31:0] tmp = shift_sr;
                    int j;
                    for (j = 0; j < 32; j++) begin
                        tmp = { din[j], tmp[31:1] };
                    end
                    shift_sr <= tmp;

                    if (detect_this_cycle) begin
                        locked_r        <= 1'b1;
                        comma_end_idx   <= detect_idx_tmp;
                        offset_reg      <= (detect_idx_tmp + 6'd1) & 6'h1F;
                        offset_valid    <= 1'b1;
                        post_lock_phase <= 1'b1; // defer first aligned output
                    end
                end else begin
                    // Post-lock aligned output
                    if (offset_valid) begin
                        if (post_lock_phase) begin
                            post_lock_phase <= 1'b0;
                        end else begin
                            // 64-bit window = current (high) + previous (low)
                            logic [63:0] win;
                            win = { curr_raw, prev_raw };
                            // Extract aligned 32 bits starting at offset_reg
                            dout     <= win[ offset_reg +: 32 ];
                            valid    <= 1'b1;
                            // dout_clk <= 1'b1;
                        end
                    end
                end
            end
        end
    end

    assign locked = locked_r;

endmodule