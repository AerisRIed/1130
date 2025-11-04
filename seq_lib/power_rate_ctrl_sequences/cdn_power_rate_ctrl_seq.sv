`ifndef CDN_POWER_RATE_CTRL_SEQ
`define CDN_POWER_RATE_CTRL_SEQ

class cdn_power_rate_ctrl_seq extends cdn_phy_bring_up_seq;

    function new(string name = "cdn_power_rate_ctrl_seq");
        super.new(name);
    endfunction


    extern virtual task pre_body();
    extern virtual task body();
    

endclass

task cdn_power_rate_ctrl_seq::pre_body();
    super.pre_body();
endtask
 
task cdn_power_rate_ctrl_seq::body();
    super.body();
endtask



`endif 