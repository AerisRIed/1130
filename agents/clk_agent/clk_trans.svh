//********************************************************
//* Cadence.
//*
//*Author                   : chao.huang 
//*Email                    : chaoh@cadence.com
//*Filename                 : clk_trans.svh
//*Description  :                                         
//
//
//--------------------------------------------------------
//* Date	          Modified By		   Reason
//2025-05-22 01:41
//
//--------------------------------------------------------
//*******************************************************
////////////////////////////////////////////////
class clk_trans #(parameter NUM_CLK_EN = 1) extends uvm_sequence_item ;

    //---------------------------------------
    // Member
    //---------------------------------------
    bit  clk_en[NUM_CLK_EN];
    real clk_ini_period[NUM_CLK_EN];
    real clk_high_period[NUM_CLK_EN];
    real clk_low_period[NUM_CLK_EN];

    bit  clk_ssc_en[NUM_CLK_EN];
    bit  clk_ssc_mode[NUM_CLK_EN];
    bit  set_ini_period_rand[NUM_CLK_EN];
    // 0: equal delta f; 1: equal delta t;
    real clk_ssc_delta_period[NUM_CLK_EN];
    real clk_ssc_delta_max[NUM_CLK_EN];
    real clk_ssc_delta_min[NUM_CLK_EN];
    int accuracy_count[NUM_CLK_EN];

    //---------------------------------------
    // Factory 
    //---------------------------------------
    `uvm_object_param_utils_begin(clk_trans #(.NUM_CLK_EN(NUM_CLK_EN)))
        //`uvm_field_sarray_int(clk_en,          UVM_PRINT | UVM_COPY)  
        //`uvm_field_sarray_int(clk_ssc_en,      UVM_PRINT | UVM_COPY)  
        //`uvm_field_sarray_int(clk_ssc_mode,    UVM_PRINT | UVM_COPY)  
    `uvm_object_utils_end

    //---------------------------------------
    // Constructor
    //---------------------------------------
    function new (string name = "clk_trans");
        super.new(name);
    endfunction : new

    //------------------------------------
    // Methods 
    //------------------------------------
    extern function void do_copy (uvm_object rhs);
    extern function void do_print (uvm_printer printer);

endclass : clk_trans


//------------------------------------------
// do_copy
//------------------------------------------
function void clk_trans::do_copy (uvm_object rhs);
    clk_trans #(.NUM_CLK_EN(NUM_CLK_EN))  m_rhs;
    super.do_copy(rhs);

    $cast(m_rhs, rhs);
    foreach(clk_en[i]) begin
        clk_en[i]               = m_rhs.clk_en[i];
        clk_ini_period[i]       = m_rhs.clk_ini_period[i];
        clk_high_period[i]      = m_rhs.clk_high_period[i];
        clk_low_period[i]       = m_rhs.clk_low_period[i];
        clk_ssc_en[i]           = m_rhs.clk_ssc_en[i];
        clk_ssc_mode[i]         = m_rhs.clk_ssc_mode[i];
        clk_ssc_delta_period[i] = m_rhs.clk_ssc_delta_period[i];
        clk_ssc_delta_max[i]    = m_rhs.clk_ssc_delta_max[i];
        clk_ssc_delta_min[i]    = m_rhs.clk_ssc_delta_min[i];
        set_ini_period_rand[i]  = m_rhs.set_ini_period_rand[i];
        accuracy_count[i]    = m_rhs.accuracy_count[i];
    end
endfunction : do_copy

//------------------------------------------
// do_print
//------------------------------------------
function void clk_trans::do_print (uvm_printer printer);
    //super.do_print(printer);
    foreach(clk_en[i]) begin
        printer.print_int($sformatf("clk_en[%0d]", i),clk_en[i],1);
        printer.print_real($sformatf("clk_ini_period[%0d]", i),clk_ini_period[i]);
        printer.print_real($sformatf("clk_high_period[%0d]", i),clk_high_period[i]);
        printer.print_real($sformatf("clk_low_period[%0d]", i),clk_low_period[i]);
        if(clk_ssc_en[i]==1) begin
            printer.print_int($sformatf("clk_ssc_en[%0d]", i),clk_ssc_en[i],1);
            printer.print_int($sformatf("clk_ssc_mode[%0d]", i),clk_ssc_mode[i],1);
            printer.print_real($sformatf("clk_ssc_delta_period[%0d]", i),clk_ssc_delta_period[i]);
            printer.print_real($sformatf("clk_ssc_delta_max[%0d]", i),clk_ssc_delta_max[i]);
            printer.print_real($sformatf("clk_ssc_delta_min[%0d]", i),clk_ssc_delta_min[i]);
        end
    end
endfunction : do_print

typedef clk_trans#(.NUM_CLK_EN(tb_param::NUM_CLK_EN))     clk_trans_t;
