module clk_div2_noreset (
    input  logic clock_in,
    output logic clock_out = 1'b0   // 声明时初始化，避免 initial + always_ff 多驱动
);
    always @(posedge clock_in)
        clock_out <= ~clock_out;
endmodule