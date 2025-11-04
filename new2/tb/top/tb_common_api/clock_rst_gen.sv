`ifndef CLOCK_RST_GEN__SV
`define CLOCK_RST_GEN__SV
    //CLOCK gen
    logic APB_CLK_250M;
    clock_generator#(.PERIOD(4),.DUTY_CYCLE(0.5),.JITTER(0.2),.SKEW(1.5)) u_APB_CLK_250M(.clk(APB_CLK_250M),.rst_n(1));

    logic APB_CLK_500M;
    clock_generator#(.PERIOD(2),.DUTY_CYCLE(0.5),.JITTER(0.2),.SKEW(1.5)) u_APB_CLK_250M(.clk(APB_CLK_500M),.rst_n(1));

    //RST gen
    //TODO just a demo from torrent
    initial
        #100;
        phy_reset_n = 1'b0;
        apb_preset_n = 1'b0;
        trst_n = 1'b0;

        #100;
        apb_preset_n = 1'b1;
    end

`endif