module ecc(
    gen,
    correct_n,
    datain,
    chkin,
    err_detect,
    err_multpl,
    dataout,
    chkout
);

parameter synd_sel = 0;

input         [31:0] datain;
input                gen;
input                correct_n;
input          [6:0] chkin;
output               err_detect;
output               err_multpl;
output        [31:0] dataout;
output         [6:0] chkout;

generate

    if (synd_sel == 1) begin : ecc_wr

        CW_ecc_legacy_width32_chkbits7_synd_sel1 U1 (
            .gen        (gen),
            .correct_n  (correct_n),
            .datain     (datain),
            .chkin      (chkin),
            .err_detect (err_detect),
            .err_multpl (err_multpl),
            .dataout    (dataout),
            .chkout     (chkout)
        );


    end

    if (synd_sel == 0) begin : ecc_rd

        CW_ecc_legacy_width32_chkbits7_synd_sel0 U1 (
            .gen        (gen),
            .correct_n  (correct_n),
            .datain     (datain),
            .chkin      (chkin),
            .err_detect (err_detect),
            .err_multpl (err_multpl),
            .dataout    (dataout),
            .chkout     (chkout)
        );

    end

endgenerate


endmodule

