//********************************************************
//* Cadence.
//*
//*Author                   : chao.huang 
//*Email                    : chaoh@cadence.com
//*Filename                 : clk_cfg.svh
//*Description  :                                         
//
//
//--------------------------------------------------------
//* Date	          Modified By		   Reason
//2025-05-22 01:48
//
//--------------------------------------------------------
//*******************************************************
class clk_cfg #(parameter NUM_CLK_EN = 1) extends uvm_object;

    //---------------------------------------
    // Member
    //---------------------------------------
    bit     gen_clk_jitter[NUM_CLK_EN];
    bit     display_en = 1;
    string  seqr_name;
    int    UI_PPM_shift_half_period[NUM_CLK_EN];

    //---------------------------------------
    // Factory
    //---------------------------------------
    `uvm_object_param_utils_begin(clk_cfg #(.NUM_CLK_EN(NUM_CLK_EN)))
        `uvm_field_sarray_int(gen_clk_jitter,   UVM_PRINT | UVM_COPY) 
        `uvm_field_int       (display_en,       UVM_PRINT | UVM_COPY) 
        `uvm_field_sarray_int(UI_PPM_shift_half_period,       UVM_PRINT | UVM_COPY) 
    `uvm_object_utils_end

    //---------------------------------------
    // Constructor
    //---------------------------------------
    function new (string name = "clk_cfg");
        super.new(name);
    endfunction : new
    
    //---------------------------------------
    // Methods 
    //---------------------------------------
    extern function void   set_default_config();
    extern function void   set_default_jitter(bit jitter_en);
    extern function void   set_jitter(int clk_index);
    extern function void   set_display_en(bit en);
    extern function void   set_seqr_name(string i_seqr_name="m_clk_sqr");

endclass : clk_cfg


/////////////////////////////////////////
// Function : set_default_config
//   config the clk cfg use default
// Input  : Void
// Output : Void
/////////////////////////////////////////
function void clk_cfg::set_default_config();
/*{{{*/
    set_default_jitter(CLK_JITTER_DEFAULT_EN);
    set_seqr_name();
endfunction : set_default_config /*}}}*/


/////////////////////////////////////////
// Function : set_jitter
//   set one clk jitter to 1
// Input  : clk_index
// Output : Void
/////////////////////////////////////////
function void clk_cfg::set_jitter(int clk_index);
/*{{{*/
    gen_clk_jitter[clk_index] = 1;
endfunction : set_jitter /*}}}*/


/////////////////////////////////////////
// Function : set_default_jitter
//   set all clk jitter to jitter_en
// Input  : jitter_en
// Output : Void
/////////////////////////////////////////
function void clk_cfg::set_default_jitter(bit jitter_en);
/*{{{*/
    foreach( gen_clk_jitter[i] )
        gen_clk_jitter[i] = jitter_en;
endfunction : set_default_jitter /*}}}*/

/////////////////////////////////////////
// Function : set_display_en
//   set set_display_en to en
// Input  : en
// Output : Void
/////////////////////////////////////////
function void clk_cfg::set_display_en(bit en);
/*{{{*/
    display_en = en;
endfunction : set_display_en /*}}}*/

/////////////////////////////////////////
// Function : set_seqr_name
/////////////////////////////////////////
function void clk_cfg::set_seqr_name(string i_seqr_name="m_clk_sqr");
/*{{{*/
    seqr_name = i_seqr_name;
endfunction : set_seqr_name /*}}}*/

typedef clk_cfg #(.NUM_CLK_EN(tb_param::NUM_CLK_EN)) clk_cfg_t;
