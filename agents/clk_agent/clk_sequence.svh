//********************************************************
//* Cadence.
//*
//*Author                   : chao.huang 
//*Email                    : chaoh@cadence.com
//*Filename                 : clk_sequence.svh
//*Description  :                                         
//
//
//--------------------------------------------------------
//* Date	          Modified By		   Reason
//2025-05-22 03:02
//
//--------------------------------------------------------
//*******************************************************

class clk_sequence #(parameter NUM_CLK_EN = 1) extends uvm_sequence ;

    //---------------------------------------
    // Member
    //---------------------------------------
    clk_trans_t  m_trans;
    t_set_one_clk_para t_clk_para;
    t_set_one_ssc_clk_para t_ssc_clk_para;
    //---------------------------------------
    // Factory 
    //---------------------------------------
    `uvm_object_param_utils(clk_sequence #(.NUM_CLK_EN(NUM_CLK_EN)))
     
    //---------------------------------------
    // Constructor
    //---------------------------------------
    function new (string name = "clk_sequence");
        super.new(name);
        m_trans = clk_trans_t::type_id::create("m_trans");
    endfunction : new

    //---------------------------------------
    // Methods 
    //---------------------------------------
    extern task body();
    extern function void set_one_en(bit enable, int clk_index);
    extern function void set_all_en(bit enable);
    extern function void set_one_ini_period(real period, int clk_index);
    extern function void set_one_ini_period_rand(real ini_period_high_limit=INI_PERIOD_HIGH_LIMIT, real ini_period_low_limit=INI_PERIOD_LOW_LIMIT, int clk_index);
    extern function void set_all_ini_period_rand(real ini_period_high_limit=INI_PERIOD_HIGH_LIMIT, real ini_period_low_limit=INI_PERIOD_LOW_LIMIT);
    extern function void set_one_high_period(real period, int clk_index);
    extern function void set_one_low_period(real period, int clk_index);
    //extern function void set_one_clk_config(int clk_index, bit clk_en, real clk_frequency_MHz=10**2, real clk_duty_cycle=0.5, bit set_ini_period_rand=1);
    extern function void set_one_clk_config();
    extern function void set_one_ssc_clk_config();
endclass : clk_sequence


/////////////////////////////////////////
// Task : run_phase
//   uvm run_phase
/////////////////////////////////////////
task clk_sequence::body();
/*{{{*/
    `uvm_info(get_name(), "Starting the clock sequence body...", UVM_HIGH);
    start_item(m_trans);
    finish_item(m_trans);

endtask : body /*}}}*/

/////////////////////////////////////////
// Function : set_one_en
//   set one clk_en to enable
// Input  : enable, clk_index
// Output : Void
/////////////////////////////////////////
function void clk_sequence::set_one_en(bit enable, int clk_index);
/*{{{*/
    m_trans.clk_en[clk_index] = enable;
endfunction : set_one_en /*}}}*/

/////////////////////////////////////////
// Function : set_all_en
//   set all clk_en to enable
// Input  : enable
// Output : Void
/////////////////////////////////////////
function void clk_sequence::set_all_en(bit enable);
/*{{{*/
    foreach( m_trans.clk_en[i] )
        m_trans.clk_en[i] = enable;
endfunction : set_all_en /*}}}*/

/////////////////////////////////////////
// Function : set_one_ini_period
//   set one clk_ini_period to period
// Input  : period, clk_index
// Output : Void
/////////////////////////////////////////
function void clk_sequence::set_one_ini_period(real period, int clk_index);
/*{{{*/
      m_trans.clk_ini_period[clk_index] = period;
endfunction : set_one_ini_period /*}}}*/

/////////////////////////////////////////
// Function : set_one_ini_period_rand
//   set one clk_ini_period to random
// Input  : ini_period_high_limit, ini_period_low_limit, clk_index
// Output : Void
/////////////////////////////////////////
function void clk_sequence::set_one_ini_period_rand(real ini_period_high_limit=INI_PERIOD_HIGH_LIMIT, real ini_period_low_limit=INI_PERIOD_LOW_LIMIT, int clk_index);
/*{{{*/
    m_trans.clk_ini_period[clk_index] = $urandom_range(
        int'(ini_period_high_limit),
        int'(ini_period_low_limit ));
endfunction : set_one_ini_period_rand /*}}}*/

/////////////////////////////////////////
// Function : set_all_ini_period_rand
//   set all clk_ini_period to random
// Input  : ini_period_high_limit, ini_period_low_limit
// Output : Void
/////////////////////////////////////////
function void clk_sequence::set_all_ini_period_rand(real ini_period_high_limit=INI_PERIOD_HIGH_LIMIT, real ini_period_low_limit=INI_PERIOD_LOW_LIMIT);
/*{{{*/
    foreach( m_trans.clk_ini_period[i] )
        set_one_ini_period_rand(ini_period_high_limit, ini_period_low_limit, i);
endfunction : set_all_ini_period_rand /*}}}*/

/////////////////////////////////////////
// Function : set_one_high_period
//   set one clk_high_period to period
// Input  : period, clk_index
// Output : Void
/////////////////////////////////////////
function void clk_sequence::set_one_high_period(real period, int clk_index);
/*{{{*/
    m_trans.clk_high_period[clk_index] = period;
endfunction : set_one_high_period /*}}}*/

/////////////////////////////////////////
// Function : set_one_low_period
//   set one clk_low_period to period
// Input  : period, clk_index
// Output : Void
/////////////////////////////////////////
function void clk_sequence::set_one_low_period(real period, int clk_index);
/*{{{*/
    m_trans.clk_low_period[clk_index] = period;
endfunction : set_one_low_period /*}}}*/

/////////////////////////////////////////
// Function : set_one_clk_config
//   config one clk
// Input  : 
//   clk_index : the clk index
//   clk_en : enable of one clk
//   clk_frequency_MHz : the frequency of one clk , unit is MHz
//   clk_duty_cycle : the duty cycle of one clk
//   set_ini_period_rand : enable randomize of ini period
// Output : Void
/////////////////////////////////////////
function void clk_sequence::set_one_clk_config();
/*{{{*/
  real period_calcu;

  if( t_clk_para.set_ini_period_rand )
    set_one_ini_period_rand(,,t_clk_para.clk_index);
  if(t_clk_para.clk_frequency_MHz == 0) begin
    `uvm_fatal(get_name(),$psprintf("clk_frequency is 0, please check"))
  end
  period_calcu = ( 10**3 / t_clk_para.clk_frequency_MHz) * (t_clk_para.clk_duty_cycle);
  set_one_high_period(period_calcu, t_clk_para.clk_index);

  period_calcu = ( 10**3 / t_clk_para.clk_frequency_MHz) * (1-t_clk_para.clk_duty_cycle);
  set_one_low_period(period_calcu, t_clk_para.clk_index);
  
  set_one_en(t_clk_para.clk_en, t_clk_para.clk_index);

endfunction : set_one_clk_config /*}}}*/


/////////////////////////////////////////
// Function : set_one_ssc_clk_config
//   config one clk
/////////////////////////////////////////
function void clk_sequence::set_one_ssc_clk_config();  /*{{{*/
    real period_calcu;
    real delta_tmp;
    bit  rand_for_center_down=0;
    bit delta_mode =1;//defalut
    //if( set_ini_period_rand )
    //    set_one_ini_period_rand(,,clk_index);
  

    if(~t_ssc_clk_para.set_ini_period_rand) begin
        period_calcu = ( 10**3 / t_ssc_clk_para.clk_frequency_MHz) * (0.5);
        set_one_high_period(period_calcu, t_ssc_clk_para.clk_index);

        period_calcu = ( 10**3 / t_ssc_clk_para.clk_frequency_MHz) * (0.5);
        set_one_low_period(period_calcu, t_ssc_clk_para.clk_index);
    end else begin
        period_calcu = ( 10**3 / t_ssc_clk_para.start_freq_Mhz) * (0.5);
        set_one_high_period(period_calcu, t_ssc_clk_para.clk_index);

        period_calcu = ( 10**3 / t_ssc_clk_para.start_freq_Mhz) * (0.5);
        set_one_low_period(period_calcu, t_ssc_clk_para.clk_index);
    end
    set_one_en(t_ssc_clk_para.clk_en, t_ssc_clk_para.clk_index);

    // new for ssc
    m_trans.set_ini_period_rand[t_ssc_clk_para.clk_index] = t_ssc_clk_para.set_ini_period_rand;
    m_trans.clk_ssc_en[t_ssc_clk_para.clk_index] = t_ssc_clk_para.clk_ssc_en;
    m_trans.clk_ssc_mode[t_ssc_clk_para.clk_index] = delta_mode;
    //m_trans.gen_clk_jitter[clk_index] = jitter_en;

    m_trans.clk_ssc_delta_period[t_ssc_clk_para.clk_index] = t_ssc_clk_para.delta_time;
    m_trans.accuracy_count[t_ssc_clk_para.clk_index] = t_ssc_clk_para.accuracy_count;

    if( rand_for_center_down) begin // center
        if(delta_mode==1) begin
            delta_tmp = ( 10**3 / (t_ssc_clk_para.clk_frequency_MHz-(t_ssc_clk_para.delta_frequency_MHz/2)))*0.5;
            m_trans.clk_ssc_delta_max[t_ssc_clk_para.clk_index] = delta_tmp;//5.00125;
            delta_tmp = ( 10**3 / (t_ssc_clk_para.clk_frequency_MHz+(t_ssc_clk_para.delta_frequency_MHz/2)))*0.5;
            m_trans.clk_ssc_delta_min[t_ssc_clk_para.clk_index] = delta_tmp;//4.99875;
        end else begin
            m_trans.clk_ssc_delta_max[t_ssc_clk_para.clk_index] = (t_ssc_clk_para.clk_frequency_MHz+(t_ssc_clk_para.delta_frequency_MHz/2));//100.025
            m_trans.clk_ssc_delta_min[t_ssc_clk_para.clk_index] = (t_ssc_clk_para.clk_frequency_MHz-(t_ssc_clk_para.delta_frequency_MHz/2));// 99.975
        end
    end else begin
        if(delta_mode==1) begin //actully used down spred 
            delta_tmp = ( 10**3 / (t_ssc_clk_para.clk_frequency_MHz-t_ssc_clk_para.delta_frequency_MHz))*0.5;
            m_trans.clk_ssc_delta_max[t_ssc_clk_para.clk_index] = delta_tmp;//5.0251;
            delta_tmp = ( 10**3 / (t_ssc_clk_para.clk_frequency_MHz))*0.5;
            m_trans.clk_ssc_delta_min[t_ssc_clk_para.clk_index] = delta_tmp;//5.0000;
        end else begin
            m_trans.clk_ssc_delta_max[t_ssc_clk_para.clk_index] = (t_ssc_clk_para.clk_frequency_MHz);//100.00
            m_trans.clk_ssc_delta_min[t_ssc_clk_para.clk_index] = (t_ssc_clk_para.clk_frequency_MHz-t_ssc_clk_para.delta_frequency_MHz);// 99.95
        end
    end

endfunction : set_one_ssc_clk_config /*}}}*/

typedef clk_sequence #(.NUM_CLK_EN(tb_param::NUM_CLK_EN))      clk_seq_t;

