
class serdes_cfg extends uvm_object;
/*{{{*/    
    //---------------------------------------
    // Member
    //---------------------------------------
    // common
    real           period;
    int            valid_bits;
    real           baud_rate;
    // for RX only
    real           half_period;
    real           over_period;
    int            half_valid_bits;
    bit            diff_type = 1;
    // for TX only
    time           latency;          // the time before first bit transmit
    e_pam_type     m_pam_type = PAM2;
    //---------------------------------------
    // Factory 
    //---------------------------------------
    `uvm_object_utils(serdes_cfg)

    //---------------------------------------
    // Constructor
    //---------------------------------------
    function new (string name = "serdes_cfg");
        super.new(name);
    endfunction : new

    //---------------------------------------
    // Methods 
    //---------------------------------------
    extern virtual function void set_default(real i_period, int i_valid_bits,e_pam_type i_pam_type);

endclass : serdes_cfg /*}}}*/



//------------------------------------------
// set_default
//------------------------------------------
function void serdes_cfg::set_default(real i_period, int i_valid_bits,e_pam_type i_pam_type); 
/*{{{*/
    // common
    period     = i_period;
    valid_bits = i_valid_bits;
    half_valid_bits = valid_bits/2;
    baud_rate  = 1/period;
    m_pam_type = i_pam_type;
    
    // for RX only
    half_period = period*0.5;
    over_period = period*OVER_SAMPLE_PERCENT;
    
    // for TX only
    latency = 0;// TODO
endfunction : set_default/*}}}*/
