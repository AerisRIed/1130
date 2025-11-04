//********************************************************
//* Cadence.
//*
//*Author                   : chao.huang 
//*Email                    : chaoh@cadence.com
//*Filename                 : clk_driver.svh
//*Description  :                                         
//
//
//--------------------------------------------------------
//* Date	          Modified By		   Reason
//2025-05-22 01:46
//
//--------------------------------------------------------
//*******************************************************
class clk_driver #(parameter NUM_CLK_EN = 1) extends uvm_driver #(clk_trans #(.NUM_CLK_EN(NUM_CLK_EN)));

    //---------------------------------------
    // Member
    //---------------------------------------
    clk_vif_t    m_vif;
    clk_cfg_t    m_cfg;
    clk_trans_t  m_trans;
    real         jitter_calu_high[NUM_CLK_EN];
    real         jitter_calu_low[NUM_CLK_EN];
    
    real         UI_PPM_shift_half_period[NUM_CLK_EN];
    //---------------------------------------
    // Factory 
    //---------------------------------------
    `uvm_component_param_utils(clk_driver #(.NUM_CLK_EN(NUM_CLK_EN)))
     
    //---------------------------------------
    // Constructor
    //---------------------------------------
    function new (string name = "clk_driver", uvm_component parent);
        super.new(name,parent);
        m_trans = clk_trans_t::type_id::create("m_trans");
    endfunction : new

    //---------------------------------------
    // Methods 
    //---------------------------------------
    extern virtual task run_phase(uvm_phase phase);
    extern virtual task get_trans();
    extern virtual task drive_trans();
    extern virtual task gen_one_clk(int clk_index);
    extern virtual function real jitter_calculate(real period);

    extern virtual function void re_deep_copy(clk_trans_t t);

endclass : clk_driver


/////////////////////////////////////////
// Task : run_phase
//   uvm run_phase
/////////////////////////////////////////
task clk_driver::run_phase(uvm_phase phase);
/*{{{*/
    `uvm_info(get_name(), "Start in run_phase", UVM_MEDIUM);
    
    fork 
        get_trans();
        drive_trans();
    join

endtask : run_phase /*}}}*/

/////////////////////////////////////////
// Task : get_trans
//   get the trans from sqr 
/////////////////////////////////////////
task clk_driver::get_trans();
/*{{{*/

  forever begin
      seq_item_port.get_next_item(req);
      `uvm_info(get_name(), $psprintf("clk transaction = \n%s", req.sprint()), UVM_LOW);
      //m_trans.copy(req);
      re_deep_copy(req);

      foreach( jitter_calu_high[i] )
          jitter_calu_high[i] = jitter_calculate(req.clk_high_period[i]);
      foreach( jitter_calu_low[i] )
          jitter_calu_low[i] = jitter_calculate(req.clk_low_period[i]);
      seq_item_port.item_done();
  end
  
endtask : get_trans /*}}}*/

/////////////////////////////////////////
// Task : drive_trans
//   drive based on trans 
/////////////////////////////////////////
task clk_driver::drive_trans();
/*{{{*/

    for(int i=0; i<NUM_CLK_EN; i++) begin
        fork
            automatic int loop_index=i;
            begin
                gen_one_clk(loop_index);
            end
        join_none
    end
  
endtask : drive_trans /*}}}*/

/////////////////////////////////////////
// Task : gen_one_clk
//   gen one of the clk
/////////////////////////////////////////
task clk_driver::gen_one_clk(int clk_index);
/*{{{*/
  
    real  period_high_this_time;
    real  period_low_this_time;

    bit   ssc_switch=0;
    bit   go_on=0;
    real  current_freq;

    //period_high_this_time = m_trans.clk_high_period[clk_index];
    //period_low_this_time  = m_trans.clk_low_period[clk_index];
    //delta_period = 1/(m_trans.clk_ssc_delta_period);

    forever begin
        wait( m_trans.clk_en[clk_index] );
        m_vif.drv_clk_en[clk_index] = 'b1;

        m_vif.drv_clk_gen[clk_index] = 'b1;
        period_high_this_time = m_trans.clk_ini_period[clk_index];
        #period_high_this_time;

        period_high_this_time = m_trans.clk_high_period[clk_index];

        //`uvm_info(get_name(), $psprintf("period_high_this_time is = %f", period_high_this_time),UVM_LOW);
        do 
            begin //jitter for UI PPM shift
            if( m_cfg.gen_clk_jitter[clk_index] == 1 && m_trans.clk_ssc_en[clk_index] == 0) begin
                period_high_this_time = $urandom_range(
                    (m_trans.clk_high_period[clk_index]*PPM- (m_cfg.UI_PPM_shift_half_period[clk_index])*m_trans.clk_high_period[clk_index]), 
                    (m_trans.clk_high_period[clk_index]*PPM+ (m_cfg.UI_PPM_shift_half_period[clk_index])*m_trans.clk_high_period[clk_index])
                );
                period_low_this_time  = $urandom_range(
                    (m_trans.clk_low_period[clk_index]*PPM- (m_cfg.UI_PPM_shift_half_period[clk_index])*m_trans.clk_low_period[clk_index]),  
                    (m_trans.clk_low_period[clk_index]*PPM+ (m_cfg.UI_PPM_shift_half_period[clk_index])*m_trans.clk_low_period[clk_index])
                );
                period_high_this_time = period_high_this_time /PPM;
                period_low_this_time  = period_low_this_time  /PPM;
            //`uvm_info(get_name(), $psprintf("period_high_this_time is = %f", period_high_this_time),UVM_LOW);
            end else if(m_trans.clk_ssc_en[clk_index]) begin // for SSC
                if( m_trans.clk_ssc_mode[clk_index] ) begin // equal delta t
                    if(~ssc_switch)begin
                        period_high_this_time = m_trans.clk_ini_period[clk_index];
                        #period_high_this_time;
                        period_high_this_time = m_trans.clk_high_period[clk_index];
                        ssc_switch = 1;
                        if(m_trans.set_ini_period_rand[clk_index])
                        go_on = 1;
                    end
                    if(go_on) begin
                        if(m_vif.accuracy_count[clk_index] ==  m_trans.accuracy_count[clk_index]) begin
                            period_high_this_time+=m_trans.clk_ssc_delta_period[clk_index];
                        end
                        if(period_high_this_time>=m_trans.clk_ssc_delta_max[clk_index]) begin

                            period_high_this_time = m_trans.clk_ssc_delta_max[clk_index];
                            go_on = 0;
                            ->m_vif.trig_change[clk_index];
                        end
                    end else begin
                        if(m_trans.accuracy_count[clk_index] == 0) begin
                            period_high_this_time-=m_trans.clk_ssc_delta_period[clk_index];
                        end else if(m_vif.accuracy_count[clk_index] == m_trans.accuracy_count[clk_index]) begin
                            period_high_this_time-=m_trans.clk_ssc_delta_period[clk_index];
                        end
                        if(period_high_this_time<=m_trans.clk_ssc_delta_min[clk_index]) begin
                            period_high_this_time = m_trans.clk_ssc_delta_min[clk_index];
                            go_on = 1;
                            ->m_vif.trig_change[clk_index];
                        end
                    end
                    period_low_this_time = period_high_this_time;
                    m_vif.clk_period[clk_index] = (period_high_this_time-m_trans.clk_high_period[clk_index]);
                    m_vif.clk_freq[clk_index] = (500/period_high_this_time-500/m_trans.clk_high_period[clk_index]);
                end else begin // equal delta f
                    current_freq = (10**3)/(period_high_this_time*2);
                    if(go_on) begin
                        current_freq-=m_trans.clk_ssc_delta_period[clk_index];
                        if( current_freq<=m_trans.clk_ssc_delta_min[clk_index]) begin
                            current_freq = m_trans.clk_ssc_delta_min[clk_index];
                            go_on=0;
                            ->m_vif.trig_change[clk_index];
                        end
                    end else begin
                        current_freq+=m_trans.clk_ssc_delta_period[clk_index];
                        if( current_freq>=m_trans.clk_ssc_delta_max[clk_index]) begin
                            current_freq = m_trans.clk_ssc_delta_max[clk_index];
                            go_on=1;
                            ->m_vif.trig_change[clk_index];
                        end
                    end            
                    period_high_this_time = ((10**3)/current_freq)/2;
                    period_low_this_time = period_high_this_time;
                    m_vif.clk_freq[clk_index] = (current_freq-(500/m_trans.clk_high_period[clk_index]));
                    m_vif.clk_period[clk_index] = (period_high_this_time-m_trans.clk_high_period[clk_index]);
                end
            end else begin
                ssc_switch = 0;
                period_high_this_time = m_trans.clk_high_period[clk_index];
                period_low_this_time  = m_trans.clk_low_period[clk_index];
                m_vif.clk_period[clk_index] = period_high_this_time;
            end

            #period_high_this_time m_vif.drv_clk_gen[clk_index] = 'b0;
            #period_low_this_time  m_vif.drv_clk_gen[clk_index] = 'b1;
            m_vif.accuracy_count[clk_index] ++ ;
            if(m_vif.accuracy_count[clk_index] ==  m_trans.accuracy_count[clk_index]+1)
                m_vif.accuracy_count[clk_index] =0;
        end
        while( m_trans.clk_en[clk_index] );
        m_vif.drv_clk_en[clk_index] = 'b0;

    end
 
endtask : gen_one_clk /*}}}*/

/////////////////////////////////////////
// Function : jitter_calculate
//   calculate the jitter time
// Input  : clk_index
// Output : jitter time
/////////////////////////////////////////
function real clk_driver::jitter_calculate(real period);
/*{{{*/
    return( (CLK_JITTER_PERCENT) / 1000.0 );
endfunction : jitter_calculate /*}}}*/

/////////////////////////////////////////
// Function : re_deep_copy
/////////////////////////////////////////
function void clk_driver::re_deep_copy(clk_trans_t t);
/*{{{*/
    foreach(m_trans.clk_en[i])
        m_trans.clk_en[i] = t.clk_en[i];
    foreach(m_trans.clk_ini_period[i])
        m_trans.clk_ini_period[i] = t.clk_ini_period[i];
    foreach(m_trans.clk_high_period[i])
        m_trans.clk_high_period[i] = t.clk_high_period[i];
    foreach(m_trans.clk_low_period[i])
        m_trans.clk_low_period[i] = t.clk_low_period[i];
    foreach(m_trans.clk_ssc_en[i])
        m_trans.clk_ssc_en[i] = t.clk_ssc_en[i];
    foreach(m_trans.clk_ssc_mode[i])
        m_trans.clk_ssc_mode[i] = t.clk_ssc_mode[i];
    foreach(m_trans.clk_ssc_delta_period[i])
        m_trans.clk_ssc_delta_period[i] = t.clk_ssc_delta_period[i];
    foreach(m_trans.clk_ssc_delta_max[i])
        m_trans.clk_ssc_delta_max[i] = t.clk_ssc_delta_max[i];
    foreach(m_trans.clk_ssc_delta_min[i])
        m_trans.clk_ssc_delta_min[i] = t.clk_ssc_delta_min[i];
    foreach(m_trans.accuracy_count[i])
        m_trans.accuracy_count[i] = t.accuracy_count[i];
endfunction : re_deep_copy /*}}}*/

typedef clk_driver#(.NUM_CLK_EN(tb_param::NUM_CLK_EN))    clk_driver_t;


