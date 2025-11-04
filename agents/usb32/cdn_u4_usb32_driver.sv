
//
// Template for UVM-compliant physical-level transactor
//

`ifndef cdn_u4_usb32_driver__SV
`define cdn_u4_usb32_driver__SV

typedef class cdn_u4_usb32_driver;
class cdn_u4_usb32_driver extends cdn_phy_driver_base;
    
    //--------------------------------
    // Member
    //--------------------------------
    cdn_u4_usb32_symbol_pattern               symbol_pattern;
    cdn_u4_usb32_symbol_pattern               symbol_pattern_received;
    cdn_u4_usb32_symbol_pattern               symbol_pattern_received_q[$];
	cdn_u4_usb32_symbol_pattern               symbol_pattern_copy;
    cdn_u4_usb32_transmitter_transaction      tx_ctx;
    cdn_u4_usb32_config                       m_cfg;
    cdn_u4_usb32_physical_timer_cfg           timer_cfg;
    cdn_u4_usb32_shared_obj                   m_shared_obj;
    cdn_u4_usb32_transaction                  host_trans;
    cdn_u4_usb32_transaction                  devc_trans;
    event over_clk; 
    event gen_block_done; 
    //cdn_phy_vif_t m_vif;
    bit running_disparity;
    int test_index;
    int half_period;
    int fd;
    int lane_id;
    int PD_WIDTH = tb_param::PD_WIDTH;
    bit [1023 :0] TxData;
    bit [39:0] pd_data;
    bit [255:0] TxDataK;
    bit[7:0] data_buff;
    int spilt_count; //spilt PD_WIDTH into spilt_count, for example 1 PCLK can send spilt_counts bytes 
    int os_count;
    int full_period;
    int skp_sent_num ;
    int skp_num_gen1x2 ;
    int byte_index;
    int symbol_count_Y;
    int block_count;
    bit is_k_code; 
    bit bit_buff[$]; 
    bit bit_buff_serdes[$]; 
    bit is_skp_insert; 
    int retimer_number ;//to simulater retimer adjust SKP function ,for U32 SKP used
    int skp_transmit_number; //4 -36 multiple 4
    int symbol_num_in_one_block ;
    int symbol_num; // one Order set or Data set can contains symbols bytes
    bit sync_period = 1; 
    bit TxStartBlock ;
    bit [8:0] host_txdata_buf_Gen2_lane0[16]; // 319+4 is the longest block in USB32 and give it to Scoreboard to check random data TODO
    bit [8:0] host_txdata_buf_Gen2_lane1[16];
    bit [8:0] devc_txdata_buf_Gen2_lane0[16];
    bit [8:0] devc_txdata_buf_Gen2_lane1[16];
    
    bit [8:0] host_txdata_buf_Gen1_lane0[16]; //the highest bit is K and low 8 bits is 8-bit data give it to Scoreboard to check random data
    bit [8:0] host_txdata_buf_Gen1_lane1[16];
    bit [8:0] devc_txdata_buf_Gen1_lane0[16];
    bit [8:0] devc_txdata_buf_Gen1_lane1[16];
    //---------------------------------------
    //scramble variables
    //---------------------------------------
    bit[22:0] cur_lfsr_gen2 ;
    bit[22:0] next_lfsr_gen2;
    bit[15:0] cur_lfsr;
    bit[15:0] next_lfsr;
    bit scramble_en;
    bit advance_scramble;
    bit drop = 0;
    //int m_vif.usb32_debug_intf.index_in_one_clk;
    //---------------------------------------
    // Factory 
    //---------------------------------------
    `uvm_component_utils(cdn_u4_usb32_driver)
    `uvm_register_cb(cdn_u4_usb32_driver,cdn_callback)
     
	//-------------------------------------
	// Model will receive symbol_pattern on this port from ltssm operation
	//-------------------------------------
    uvm_analysis_export #(cdn_u4_usb32_symbol_pattern)   cdn_u4_usb32_symbol_export_ep;
    uvm_tlm_analysis_fifo #(cdn_u4_usb32_symbol_pattern) cdn_u4_usb32_symbol_fifo; //imp
	//-------------------------------------
	// scb
    // //-------------------------------------
    uvm_analysis_port#(cdn_u4_usb32_transaction)   drv2scb_stim_ap_host;
    uvm_analysis_port#(cdn_u4_usb32_transaction)   drv2scb_stim_ap_devc;
    //---------------------------------------
    // Constructor
    //---------------------------------------
    function new (string name = "cdn_u4_usb32_driver", uvm_component parent);
        super.new(name,parent);
    endfunction : new
    extern function void build_phase(uvm_phase phase);
    extern function void connect_phase(uvm_phase phase);
    extern function void update_interface();
    
	//-------------------------------------
	//  byte encode functions , byte encode means encode based from 8b/10b, can used in U32 Gen1,PCIe Gen1/2 and DP
	//-------------------------------------
    extern function void gen_TxDataK();//only Original in byte encode
    extern function void gen_TxData_byte_encode();
    extern function void skp_insert_byte_encode();
    extern task drv_byte_data();
    extern task send_loopback_stream_byte_encode();
    extern task skp_insert_judge();
    
	//-------------------------------------
	//  block encode functions , block encode means encode based from 128/13x 64/66, can used in U32 Gen2,PCIe Gen3/4 and DP
	//-------------------------------------
    extern function void assert_TxStartBlock_and_TxSyncHeader();//only Original Pipe will drive TxStartBlock and TxSyncHeader 
    extern function void deassert_TxStartBlock_and_TxSyncHeader();//only Original Pipe will drive TxStartBlock and TxSyncHeader
    extern function void gen_block_header();
    extern function void gen_TxData_block_payload();
    extern function void insert_sync_os();
    extern function void assert_TxDataValid_in_block_encode();
    extern task drv_block_data();
    extern task patch_block_header_for_serdes();

    extern function [31:0] big_endian_transfer_byte(input bit en,input bit[31:0] data_in,input int width);//big_endian transfer, can trans to LSB first
    extern function reset_interface();
    extern function [15:0]reset_lfsr();
    extern function [22:0]reset_lfsr_gen2();
	//-------------------------------------
    // usb32 special polling lfps functions
	//-------------------------------------
    extern task gen_polling_lfps();
    extern task gen_lowpower_lfps_wake();
    extern task gen_loopback_exit();
	//-------------------------------------
    // other function
	//-------------------------------------
    extern task gen_power_down(input bit[3:0] PowerDown);
    extern task gen_loopback_data();
    
	//-------------------------------------
    // callback function
	//-------------------------------------
    extern virtual function void pre_usb32_symbol_pattern(cdn_u4_usb32_symbol_pattern symbol_pattern, ref bit drop);
    extern virtual function void pre_usb32_loopback_data(cdn_u4_usb32_transmitter_transaction tx_ctx, ref bit drop);
    extern virtual function void pre_usb32_gen1_TxData(cdn_u4_usb32_transmitter_transaction tx_ctx, ref bit drop);
    extern virtual function void pre_usb32_gen1_skp_symbol(cdn_u4_usb32_transmitter_transaction tx_ctx, ref bit drop);
    
    extern task get_symbol_pattern();
    extern task driver_symbol_set();
    extern task run_phase(uvm_phase phase);
endclass

function void cdn_u4_usb32_driver::build_phase(uvm_phase phase);
	super.build_phase(phase);/*{{{*/
    cdn_u4_usb32_symbol_export_ep = new("cdn_u4_usb32_symbol_export_ep", this);
	cdn_u4_usb32_symbol_fifo      = new("cdn_u4_usb32_symbol_fifo", this);
    host_trans      = new();
    devc_trans      = new();
    drv2scb_stim_ap_host = new("drv2scb_stim_ap_host",this);
    drv2scb_stim_ap_devc = new("drv2scb_stim_ap_devc",this);
    symbol_pattern_copy= new();
    symbol_pattern_received= new();
    m_shared_obj = new();
    tx_ctx =new();
    //timer_cfg = new("timer_cfg");
    //fd = $fopen("devc_lane0_txdata.txt","w");

endfunction : build_phase/*}}}*/

function void cdn_u4_usb32_driver::connect_phase(uvm_phase phase);
	super.connect_phase(phase);
	cdn_u4_usb32_symbol_export_ep.connect(cdn_u4_usb32_symbol_fifo.analysis_export);/*{{{*/
endfunction : connect_phase/*}}}*/

task cdn_u4_usb32_driver::run_phase(uvm_phase phase);
    super.run_phase(phase);
	cur_lfsr      = reset_lfsr();
	cur_lfsr_gen2 = reset_lfsr_gen2();
    if(~m_cfg.SerdesArch)  spilt_count   =  PD_WIDTH / 8; 
    else  spilt_count   =  PD_WIDTH / 10; 
    fork 
        forever begin
            get_symbol_pattern();
        end
        forever begin
            //#0;
            driver_symbol_set();
        end
        patch_block_header_for_serdes();
    join
endtask : run_phase

task cdn_u4_usb32_driver::get_symbol_pattern();
        cdn_u4_usb32_symbol_fifo.get(symbol_pattern);
        //`uvm_info(get_name(), $psprintf("symbol gen obj = %s", symbol_pattern.sprint()), UVM_LOW);
		//`uvm_info(get_name(), $psprintf("symbol gen copy before obj = %s", symbol_pattern_copy.sprint()), UVM_LOW);
        symbol_pattern_received.do_copy(symbol_pattern);
        //if(symbol_pattern.loopback_test_pattern_en) begin
        //    byte_index = 0;
        //end else begin
        #0;  
        fork
            begin
                wait(byte_index == symbol_pattern_copy.symbol_count);
            end
            begin
                wait(byte_index == symbol_pattern_copy.symbol_count -2);
                @ over_clk;
            end
        join_any
        
        //if(half_period) @ over_clk; //for gen1 skp insert
        reset_interface();//when get a new orderset
        //symbol_pattern_copy = new();
        symbol_pattern_copy.do_copy(symbol_pattern_received);
		test_index ++;
        //drv2scb();
        `uvm_info(get_name(), $psprintf("symbol gen copy obj = %s", symbol_pattern_copy.sprint()), UVM_LOW);
		//`uvm_info(get_name(), $psprintf("half_period = %d", half_period), UVM_LOW);
endtask : get_symbol_pattern

task cdn_u4_usb32_driver::driver_symbol_set();
    forever begin
        @(posedge m_vif.pclk);
        #0;
        pre_usb32_symbol_pattern(symbol_pattern_copy,drop);
        
        if(is_skp_insert) begin
            symbol_num_in_one_block= skp_transmit_number + 4; //SKP's BLOCK symbol number is not 16 symbol 36 * 8 +4
        end else begin
            symbol_num_in_one_block= symbol_pattern_copy.symbol_count;
        end
        symbol_num = symbol_pattern_copy.symbol_count;
        
        if(symbol_pattern_copy.lfps_gen_en) begin
            if(lane_id ==0 ) begin
                gen_polling_lfps();
            end
        end else if (symbol_pattern_copy.tseq_gen_en||symbol_pattern_copy.ts1_gen_en||symbol_pattern_copy.ts2_gen_en||symbol_pattern_copy.idle_packet_gen_en)begin
            if(m_cfg.usb32_gen_speed==GEN1_SPEED) begin
                drv_byte_data(); 
            end else begin
                drv_block_data();
            end
        end else if ((symbol_pattern_copy.random_packet_gen_en ||(symbol_pattern_copy.loopback_test_pattern_en&&m_cfg.loopback_enable)) && ~symbol_pattern_copy.loopback_exit_gen_en)begin //loopback master
            if(m_cfg.usb32_gen_speed==GEN1_SPEED) begin
                if(symbol_pattern_copy.loopback_test_pattern_en&&m_cfg.loopback_enable) begin
                    send_loopback_stream_byte_encode(); 
                end else if(~symbol_pattern_copy.loopback_test_pattern_en) begin
                    drv_byte_data(); 
                end
            end else begin
                drv_block_data();
            end
        end else if (symbol_pattern_copy.electric_idle_en) begin
            m_vif.usb32_debug_intf.serdes_tx_valid = 0;
            m_vif.pipe_intf.TxElecIdle = 1;
            gen_power_down(P1_STATE);
        end
        
        if(symbol_pattern_copy.loopback_exit_gen_en) begin
            reset_interface();//when get a new orderset
            m_vif.usb32_debug_intf.serdes_tx_valid = 0;
            gen_loopback_exit();
        end
        if(symbol_pattern_copy.loopback_test_pattern_en && ~m_cfg.loopback_enable) begin //loopback slave
            gen_loopback_data();
        end
        
        if(symbol_pattern_copy.u1_exit_gen_en||symbol_pattern_copy.u2_exit_gen_en||symbol_pattern_copy.u3_exit_gen_en) begin
            gen_lowpower_lfps_wake();
        end
        //----------------------TODO may use case instead
    end
endtask : driver_symbol_set

function void cdn_u4_usb32_driver::pre_usb32_symbol_pattern(cdn_u4_usb32_symbol_pattern symbol_pattern, ref bit drop);
	`uvm_do_callbacks(cdn_u4_usb32_driver,cdn_callback, pre_usb32_symbol_pattern(symbol_pattern, drop));
endfunction : pre_usb32_symbol_pattern/*}}}*/

function void cdn_u4_usb32_driver::pre_usb32_loopback_data(cdn_u4_usb32_transmitter_transaction tx_ctx, ref bit drop);
	`uvm_do_callbacks(cdn_u4_usb32_driver,cdn_callback, pre_usb32_loopback_data(tx_ctx, drop));
endfunction : pre_usb32_symbol_pattern/*}}}*/

function void cdn_u4_usb32_driver::pre_usb32_gen1_TxData(cdn_u4_usb32_transmitter_transaction tx_ctx, ref bit drop);
	`uvm_do_callbacks(cdn_u4_usb32_driver,cdn_callback, pre_usb32_gen1_TxData(tx_ctx, drop));
endfunction : pre_usb32_symbol_pattern/*}}}*/

function void cdn_u4_usb32_driver::pre_usb32_gen1_skp_symbol(cdn_u4_usb32_transmitter_transaction tx_ctx, ref bit drop);
	`uvm_do_callbacks(cdn_u4_usb32_driver,cdn_callback, pre_usb32_gen1_skp_symbol(tx_ctx, drop));
endfunction : pre_usb32_symbol_pattern/*}}}*/

//--------------gen_polling_lfps--------------//
task cdn_u4_usb32_driver::gen_polling_lfps();
    /*{{{*/
    int cycle_count = timer_cfg.t_Burst_Polling/timer_cfg.t_Period;
    m_vif.usb32_debug_intf.lfps_transmitter_en = 1;
    m_vif.pipe_intf.TxElecIdle= 1;
    repeat (16) begin
        //burst
        m_vif.pipe_intf.TxDetectRx = 1;
        repeat(cycle_count) begin
            m_vif.serdes_tx.serial_txp= 1;
            m_vif.serdes_tx.serial_txn= 0;
            #(timer_cfg.t_Period*timer_cfg.t_LFPS_Duty_cycle/100);
            m_vif.serdes_tx.serial_txp= 0;
            m_vif.serdes_tx.serial_txn= 1;
            #(timer_cfg.t_Period*(100-timer_cfg.t_LFPS_Duty_cycle)/100);
        end
        m_vif.pipe_intf.TxDetectRx = 0;
        //t Repeat 
        m_vif.serdes_tx.serial_txp= 1'bz;
        m_vif.serdes_tx.serial_txn= 1'bz;
        #timer_cfg.t_Repeat_Polling;
        m_vif.usb32_debug_intf.lfps_sent_count++;
        //if(!symbol_pattern_copy.lfps_gen_en) begin
        //    m_vif.usb32_debug_intf.lfps_sent_count = 0;
        //    break;
        //end
    end
    m_vif.usb32_debug_intf.lfps_transmitter_en = 0;
    symbol_pattern_copy.lfps_gen_en = 0;
    if(m_cfg.usb32_gen_speed==GEN1_SPEED) begin
        m_vif.pipe_intf.TxElecIdle      = 0;
    end
    /*}}}*/
endtask : gen_polling_lfps

//--------------gen_loopback_data--------------//
task cdn_u4_usb32_driver::gen_loopback_data();
    /*{{{*/
    if(m_vif.pipe_intf.TxDetectRx ==1 && m_cfg.usb32_gen_speed==GEN2_SPEED) begin
        reset_interface();//
        m_vif.usb32_debug_intf.pd_data = m_vif.usb32_debug_intf.loopback_data_gen2[0];
        m_vif.usb32_debug_intf.loopback_data_gen2.pop_front;
    end
    if(m_vif.pipe_intf.TxDetectRx ==1 && m_cfg.usb32_gen_speed==GEN1_SPEED) begin
        reset_interface();//
        m_vif.usb32_debug_intf.pd_data = m_vif.usb32_debug_intf.loopback_data_gen1[0];
        m_vif.usb32_debug_intf.loopback_data_gen1.pop_front;
    end
    /*}}}*/
endtask : gen_loopback_data

//--------------gen_power_down--------------//
task cdn_u4_usb32_driver::gen_power_down(input bit[3:0] PowerDown);
    /*{{{*/
        m_vif.pipe_intf.PowerDown = PowerDown;
    /*}}}*/
endtask : gen_power_down

//--------------gen_lowpower_lfps_wake--------------//
task cdn_u4_usb32_driver::gen_lowpower_lfps_wake();
    /*{{{*/
    m_vif.usb32_debug_intf.lfps_transmitter_en = 1;
    m_vif.pipe_intf.TxElecIdle= 0;
    m_vif.pipe_intf.TxDataValid = 0;
    //burst
    m_vif.pipe_intf.TxDetectRx = 1;
    forever begin
        m_vif.serdes_tx.serial_txp= 1;
        m_vif.serdes_tx.serial_txn= 0;
        #(timer_cfg.t_Period*timer_cfg.t_LFPS_Duty_cycle/100);
        m_vif.serdes_tx.serial_txp= 0;
        m_vif.serdes_tx.serial_txn= 1;
        #(timer_cfg.t_Period*(100-timer_cfg.t_LFPS_Duty_cycle)/100);
        if(m_vif.usb32_debug_intf.low_power_exit_detected) begin 
            gen_power_down(P0_STATE);
            m_vif.usb32_debug_intf.low_power_exit_detected = 0;
            break;
        end
    end
    m_vif.pipe_intf.TxDetectRx = 0;
    symbol_pattern_copy.u1_exit_gen_en = 0;
    symbol_pattern_copy.u2_exit_gen_en = 0;
    symbol_pattern_copy.u3_exit_gen_en = 0;
    m_vif.usb32_debug_intf.lfps_transmitter_en = 0;
    /*}}}*/
endtask : gen_lowpower_lfps_wake

//--------------gen_loopback_exit--------------//
task cdn_u4_usb32_driver::gen_loopback_exit();
    /*{{{*/
    m_vif.usb32_debug_intf.lfps_transmitter_en = 1;
    m_vif.pipe_intf.TxElecIdle= 0;
    m_vif.pipe_intf.TxDataValid = 0;
    //burst
    m_vif.pipe_intf.TxDetectRx = 1;
    forever begin
        m_vif.serdes_tx.serial_txp= 1;
        m_vif.serdes_tx.serial_txn= 0;
        #(timer_cfg.t_Period*timer_cfg.t_LFPS_Duty_cycle/100);
        m_vif.serdes_tx.serial_txp= 0;
        m_vif.serdes_tx.serial_txn= 1;
        #(timer_cfg.t_Period*(100-timer_cfg.t_LFPS_Duty_cycle)/100);
        if(m_vif.usb32_debug_intf.low_power_exit_detected) begin 
            gen_power_down(P0_STATE);
            m_vif.usb32_debug_intf.low_power_exit_detected = 0;
            break;
        end
    end
    m_vif.pipe_intf.TxDetectRx = 0;
    symbol_pattern_copy.loopback_exit_gen_en = 0;
    m_vif.usb32_debug_intf.lfps_transmitter_en = 0;
    /*}}}*/
endtask : gen_lowpower_lfps_wake


//--------------send_loopback_stream_byte_encode--------------//
task cdn_u4_usb32_driver::send_loopback_stream_byte_encode();
/*{{{*/
//int step_bytes = PD_WIDTH / 8;
    bit[9:0] data_10b;
    bit[7:0] BERT;
    bit is_k_code;
    is_skp_insert = 0;
    m_vif.usb32_debug_intf.skp_period = is_skp_insert;
    if(byte_index == 62) begin 
        byte_index =0;
        m_vif.usb32_debug_intf.byte_index =0;
        os_count ++;
        m_vif.usb32_debug_intf.os_count = os_count;
        //is_skp_insert = os_count % m_cfg.skp_insert_period_gen1 == 0 && os_count!==0 ; //can overwrite per protocol 
        update_interface();
    end 
    skp_insert_byte_encode();
    if(~is_skp_insert) begin
            for (int j = 0 ; j < spilt_count; j++) begin
                 if(byte_index==0) begin //COM
                     tx_ctx.cur_lfsr = 16'hffff;
                     tx_ctx.BERT= COM;
                     tx_ctx.is_k_code = 1;
                 end else if(byte_index==1)begin //BRST
                     tx_ctx.cur_lfsr = 16'hffff;
                     tx_ctx.BERT= BRST;
                     tx_ctx.is_k_code = 0;
                 end else if(byte_index <= 57)begin//BDATA
                     tx_ctx.BERT= scramble_lfsr16(0,tx_ctx.cur_lfsr,next_lfsr);
                     tx_ctx.cur_lfsr = next_lfsr;
                     m_vif.usb32_debug_intf.cur_lfsr = cur_lfsr;
                 end else begin
                     tx_ctx.BERT= BERC;
                     tx_ctx.is_k_code = 1;
                 end
                 //`uvm_info(get_name(),$psprintf("scrambled_data[%d]  is %h",byte_index,scrambled_data) , UVM_LOW)
                 //add call_back
                 pre_usb32_loopback_data(tx_ctx,drop);
                 tx_ctx.TxData[(8*j) +: 8] = big_endian_transfer_byte(m_cfg.big_endian,tx_ctx.BERT,8);
                 tx_ctx.data_10b =  datatrans_8b10b(tx_ctx.BERT,running_disparity,tx_ctx.is_k_code,running_disparity);
                 m_vif.usb32_debug_intf.pd_data[(10*j) +: 10] = big_endian_transfer_byte(m_cfg.big_endian,tx_ctx.data_10b,10); //for serdes tx model
                 byte_index ++;
                 m_vif.usb32_debug_intf.byte_index ++;
                 if(byte_index == 62) begin
                     byte_index = 0;
                     m_vif.usb32_debug_intf.byte_index =0;
                 end
            end
        m_vif.pipe_intf.TxDataValid = 1;
        m_vif.pipe_intf.TxData     = tx_ctx.TxData;
    end
/*}}}*/
endtask:send_loopback_stream_byte_encode

task cdn_u4_usb32_driver::skp_insert_judge();
    if(symbol_count_Y % m_cfg.skp_insert_num_gen1> 0 && symbol_count_Y >=m_cfg.skp_insert_num_gen1) begin
        is_skp_insert = 1;
        m_vif.usb32_debug_intf.skp_period = is_skp_insert;
        -> m_vif.usb32_debug_intf.e_skp_period;
        symbol_count_Y = symbol_count_Y % m_cfg.skp_insert_num_gen1;
        m_vif.usb32_debug_intf.symbol_count_Y = symbol_count_Y;
        if(lane_id == 0) begin // to make skp simultaneously both in lane 0 and lane 1
            m_shared_obj.randomize();
        end
        skp_sent_num = m_shared_obj.skp_num_gen1x2;
    end 
endtask

//--------------drv_byte_data--------------//
task cdn_u4_usb32_driver::drv_byte_data();
    m_vif.usb32_debug_intf.serdes_tx_valid = 1;
    if(skp_sent_num == 0) begin
        is_skp_insert = 0;
        m_vif.usb32_debug_intf.skp_period = is_skp_insert;
    end
    
    if(byte_index == symbol_num ||byte_index == 32 ) begin // full period ocupy with ts os 
        half_period = 0;
        byte_index =0;
        m_vif.usb32_debug_intf.byte_index = 0;
        os_count ++;
        m_vif.usb32_debug_intf.os_count = os_count;
        skp_insert_judge();
        //can overwrite per protocol
        update_interface();
    end else if(byte_index + m_vif.usb32_debug_intf.index_in_one_clk== symbol_num)begin // skp ocupy half period
        half_period = 1;
        byte_index =symbol_num - m_vif.usb32_debug_intf.index_in_one_clk;
        m_vif.usb32_debug_intf.byte_index = symbol_num - m_vif.usb32_debug_intf.index_in_one_clk;
        skp_insert_judge();
    end
    //gen_TxDataK();
    skp_insert_byte_encode();
    if(~(full_period && is_skp_insert))
    gen_TxData_byte_encode();
endtask :drv_byte_data

//--------------drv_block_data--------------//
task cdn_u4_usb32_driver::drv_block_data();
/*{{{*/
    m_vif.usb32_debug_intf.skp_period= is_skp_insert;
    deassert_TxStartBlock_and_TxSyncHeader();
    m_vif.pipe_intf.TxDataValid = 1;
    m_vif.usb32_debug_intf.serdes_tx_valid= 1;
    m_vif.pipe_intf.TxElecIdle= 0;
    if(byte_index == symbol_num_in_one_block) begin 
        sync_period = 0; //one block done
        m_vif.usb32_debug_intf.sync_period = 0;
        byte_index = 0;
        m_vif.usb32_debug_intf.byte_index =0;
        block_count++;
        os_count ++;
        m_vif.usb32_debug_intf.os_count = os_count;
        m_vif.usb32_debug_intf.block_count = block_count;
        update_interface();
        insert_sync_os();        //------SYNC insert
        is_skp_insert = os_count % m_cfg.skp_insert_period_gen2 == 0 && os_count!==0 && ~sync_period; //can overwrite per protocol 
        //is_skp_insert = 0;
        if(is_skp_insert) begin
            retimer_number = 8;//$urandom_range(0,8);//to simulater retimer adjust SKP function
            skp_transmit_number = 4 + 4*retimer_number; //4 -36 multiple 4
        end
        gen_block_header();
        assert_TxStartBlock_and_TxSyncHeader();
    end else if(byte_index == 0)begin //initial block header
        assert_TxStartBlock_and_TxSyncHeader();
        gen_block_header();
        //TODO  can not used in serdes PIPE insert SKP
    end
        assert_TxDataValid_in_block_encode();    
    if(m_vif.pipe_intf.TxDataValid == 1) begin
        gen_TxData_block_payload();
    end else begin
        m_vif.pipe_intf.TxData = 'bz; //invalid data
    end
/*}}}*/
endtask :drv_block_data



//--------------update_interface--------------//
function void cdn_u4_usb32_driver::update_interface();
    if(symbol_pattern_copy.tseq_gen_en) begin
        m_vif.usb32_debug_intf.tseq_os_sent_count = m_vif.usb32_debug_intf.os_count;
    end else if(symbol_pattern_copy.ts1_gen_en)begin
        m_vif.usb32_debug_intf.ts1_os_sent_count  = m_vif.usb32_debug_intf.os_count;
    end else if(symbol_pattern_copy.ts2_gen_en)begin
        m_vif.usb32_debug_intf.ts2_os_sent_count  = m_vif.usb32_debug_intf.os_count;
    end else if(symbol_pattern_copy.idle_packet_gen_en)begin
        m_vif.usb32_debug_intf.Idle_packet_sent_count = m_vif.usb32_debug_intf.os_count;
    end
endfunction: update_interface
//--------------gen_TxDataK--------------//
function void cdn_u4_usb32_driver::gen_TxDataK();
/*{{{*/ 
    if(symbol_pattern_copy.tseq_gen_en) begin
        if(byte_index == 0) begin
            m_vif.pipe_intf.TxDataK = 1;
            is_k_code = 1;
        end else begin
            m_vif.pipe_intf.TxDataK = 0;
            is_k_code = 0;
        end
    end else if(symbol_pattern_copy.ts1_gen_en || symbol_pattern_copy.ts2_gen_en) begin
        if(byte_index ==0||byte_index ==1||byte_index ==2||byte_index ==3) begin
            is_k_code = 1;
            foreach(m_vif.pipe_intf.TxDataK[i]) m_vif.pipe_intf.TxDataK[byte_index] = 1;
        end else begin
            m_vif.pipe_intf.TxDataK = 0;
            is_k_code = 0;
        end
    end else begin // K code for data
        foreach(m_vif.pipe_intf.TxDataK[i]) m_vif.pipe_intf.TxDataK[i] = symbol_pattern_copy.is_k_code[i];
    end
/*}}}*/
endfunction: gen_TxDataK

function void cdn_u4_usb32_driver::skp_insert_byte_encode();
/*{{{*/
bit[7:0] skp_data_8b = big_endian_transfer_byte(m_cfg.big_endian,symbol_pattern_copy.SKP_GEN1,8);
if(is_skp_insert) begin
    if(skp_sent_num== 2 || m_vif.usb32_debug_intf.index_in_one_clk ==2) begin //half period
        symbol_num = 2;
        for (int j = m_vif.usb32_debug_intf.index_in_one_clk; j< symbol_num + m_vif.usb32_debug_intf.index_in_one_clk; j++) begin
            tx_ctx.skp_symbol_gen1                    = skp_data_8b;
            pre_usb32_gen1_skp_symbol(tx_ctx,drop);
            m_vif.pipe_intf.TxData[(8*j) +: 8]        = tx_ctx.skp_symbol_gen1;
            m_vif.pipe_intf.TxDataK[j]                = 1;
            m_vif.usb32_debug_intf.running_disparity[j]    = running_disparity;
            m_vif.usb32_debug_intf.pd_data[(10*j) +: 10]    = datatrans_8b10b(8'h3c,running_disparity,1,running_disparity);
            m_vif.usb32_debug_intf.data_before_scramble[(8*j) +: 8] = skp_data_8b;
            skp_sent_num --;
        end
            m_vif.usb32_debug_intf.index_in_one_clk = m_vif.usb32_debug_intf.index_in_one_clk +2; //hi
            if(m_vif.usb32_debug_intf.index_in_one_clk ==4) m_vif.usb32_debug_intf.index_in_one_clk = 0; // lo
            full_period = 0;
    end else if(m_vif.usb32_debug_intf.index_in_one_clk == 0)begin //full skp period
        full_period = 1;
        for (int j = 0; j< 4; j++) begin
            tx_ctx.skp_symbol_gen1                    = skp_data_8b;
            pre_usb32_gen1_skp_symbol(tx_ctx,drop);
            m_vif.pipe_intf.TxData[(8*j) +: 8]        = tx_ctx.skp_symbol_gen1;
            m_vif.pipe_intf.TxDataK[j]                = 1;
            m_vif.usb32_debug_intf.running_disparity[j]    = running_disparity;
            m_vif.usb32_debug_intf.pd_data[(10*j) +: 10]    = datatrans_8b10b(8'h3c,running_disparity,1,running_disparity);
            m_vif.usb32_debug_intf.data_before_scramble[(8*j) +: 8] = skp_data_8b;
            skp_sent_num -- ;
        end
    end 
end

/*}}}*/
endfunction

function void cdn_u4_usb32_driver::gen_TxData_byte_encode();
/*{{{*/
    bit[9:0] data_10b;
    bit[7:0] bdat;
    bit[8:0] K_and_8bdata;
    bit[7:0] scrambled_data;
    int index;
    int byte_enable = 4;
    if(~is_skp_insert) begin
        index = 0;
        byte_enable = 4;
    end else begin //SKP insert
        if(m_vif.usb32_debug_intf.index_in_one_clk ==2)begin // hi 
            index = 2;
            byte_enable = 4;
        end else begin //lo
            index =0 ;
            byte_enable = 2;
        end
    end
    for (int j = index; j< byte_enable; j++) begin
         if(symbol_pattern_copy.idle_packet_gen_en || symbol_pattern_copy.random_packet_gen_en) begin //data 
            scramble_en = 1;
            advance_scramble = 1;
            if(symbol_pattern_copy.data_q[byte_index] == COM && symbol_pattern_copy.is_k_code[byte_index]) begin //COM reset lfsr 
                cur_lfsr = reset_lfsr();
                next_lfsr= cur_lfsr; 
                m_vif.usb32_debug_intf.cur_lfsr = cur_lfsr;
                scrambled_data = COM;
            end else if(symbol_pattern_copy.data_q[byte_index] !== COM &&symbol_pattern_copy.is_k_code[byte_index]) begin //other K code
                scrambled_data = scramble_lfsr16(symbol_pattern_copy.data_q[byte_index],cur_lfsr,next_lfsr,0,1);
            end else begin //data 
                scrambled_data = scramble_lfsr16(symbol_pattern_copy.data_q[byte_index],cur_lfsr,next_lfsr,scramble_en,advance_scramble);
         
                if(m_cfg.port_mode ==DEVICE && lane_id ==0)begin
                    devc_trans.devc_txdata_buf_lane0[byte_index]={symbol_pattern_copy.is_k_code[byte_index],symbol_pattern_copy.data_q[byte_index]};
                    //$fdisplay(fd,"data[%d] is %h",byte_index,devc_trans.devc_txdata_buf_lane0[byte_index]);

                    if(byte_index == 16) begin
                        drv2scb_stim_ap_devc.write(devc_trans);
                    end
                end else if(m_cfg.port_mode ==DEVICE && lane_id ==1) begin
                    devc_trans.devc_txdata_buf_lane1[0]={symbol_pattern_copy.is_k_code[byte_index],symbol_pattern_copy.data_q[byte_index]};
                    if(byte_index == 16) begin
                        drv2scb_stim_ap_devc.write(devc_trans);
                    end
                end else if(m_cfg.port_mode ==HOST && lane_id ==0) begin
                    host_trans.host_txdata_buf_lane0[0]={symbol_pattern_copy.is_k_code[byte_index],symbol_pattern_copy.data_q[byte_index]};
                    if(byte_index == 16) begin
                        drv2scb_stim_ap_host.write( host_trans);
                    end
                end else if(m_cfg.port_mode ==HOST && lane_id ==1) begin
                    host_trans.host_txdata_buf_lane1[0]={symbol_pattern_copy.is_k_code[byte_index],symbol_pattern_copy.data_q[byte_index]};
                    if(byte_index == 16) begin
                        drv2scb_stim_ap_host.write(host_trans);
                    end
                end
  
            end
            cur_lfsr = next_lfsr;
         end else begin //Order set
            scramble_en = 0;
            advance_scramble = 0;
            scrambled_data = scramble_lfsr16(symbol_pattern_copy.data_q[byte_index],cur_lfsr,next_lfsr,scramble_en,advance_scramble);
         end
         m_vif.usb32_debug_intf.cur_lfsr = cur_lfsr;
         tx_ctx.TxData[(8*j) +: 8] = big_endian_transfer_byte(m_cfg.big_endian,scrambled_data,8);
         tx_ctx.data_8b = big_endian_transfer_byte(m_cfg.big_endian,scrambled_data,8);
         //add callback
         pre_usb32_gen1_TxData(tx_ctx,drop);
         TxData[(8*j) +: 8]                 = tx_ctx.TxData[(8*j) +: 8];
         m_vif.pipe_intf.TxData[(8*j) +: 8] = tx_ctx.TxData[(8*j) +: 8];
         m_vif.usb32_debug_intf.data_before_scramble[(8*j) +: 8] = symbol_pattern_copy.data_q[byte_index];
         m_vif.pipe_intf.TxDataK[j] = symbol_pattern_copy.is_k_code[byte_index];
         K_and_8bdata = {m_vif.pipe_intf.TxDataK[j],symbol_pattern_copy.data_q[byte_index]};
         m_vif.usb32_debug_intf.running_disparity[j] = running_disparity;
         data_10b = datatrans_8b10b(scrambled_data,running_disparity,m_vif.pipe_intf.TxDataK[j],running_disparity);
         tx_ctx.data_10b = data_10b;
         pre_usb32_gen1_TxData(tx_ctx,drop);
         m_vif.usb32_debug_intf.pd_data[(10*j) +: 10] = big_endian_transfer_byte(m_cfg.big_endian,tx_ctx.data_10b,10); //for serdes tx model
         byte_index ++;
         if(byte_index == 16 && m_vif.usb32_debug_intf.index_in_one_clk !==0) begin // half_period
            half_period = 1;
            byte_index = 0;
            os_count ++;
            m_vif.usb32_debug_intf.os_count = os_count;
            update_interface();
            -> over_clk;
        end
        if(half_period && byte_index==2 || half_period && byte_index==16 ) begin
             -> over_clk;
        end
         m_vif.usb32_debug_intf.byte_index = byte_index;
         symbol_count_Y++;
         m_vif.usb32_debug_intf.symbol_count_Y++;
         if(symbol_pattern_copy.tseq_gen_en) begin symbol_count_Y = 0;  m_vif.usb32_debug_intf.symbol_count_Y = 0; end
    end
        m_vif.pipe_intf.TxDataValid = 1; //only Original
    //end
/*}}}*/
endfunction

function void cdn_u4_usb32_driver::assert_TxStartBlock_and_TxSyncHeader();
/*{{{*/
    if(~m_cfg.SerdesArch && ~(is_skp_insert||sync_period)) begin //only Original
       TxStartBlock = 1;
       m_vif.pipe_intf.TxStartBlock= 1 ;
       m_vif.pipe_intf.TxSyncHeader = DATA_BLOCK_HEADER;
    end else if(~m_cfg.SerdesArch && (is_skp_insert||sync_period))begin
       TxStartBlock = 1;
       m_vif.pipe_intf.TxStartBlock= 1 ;
       m_vif.pipe_intf.TxSyncHeader = CTRL_BLOCK_HEADER;
    end
    -> gen_block_done;
/*}}}*/
endfunction

task cdn_u4_usb32_driver::patch_block_header_for_serdes();
/*{{{*/
//each 8 block patch 32bit bolck header, one block has 4bits block header
bit[3:0] block_header;
bit[323:0] block_data;
int fd;
int byte_count;
if(~m_cfg.SerdesArch && m_cfg.usb32_gen_speed==GEN2_SPEED) begin
    bit flag;
    forever begin
        @(posedge m_vif.pclk);//  312.5 * 32 = 10G  
        #0;
        if(~m_vif.pipe_intf.TxDetectRx) begin
            if(m_vif.pipe_intf.TxStartBlock) begin
                foreach(m_vif.pipe_intf.TxSyncHeader[i])begin
                    block_header = big_endian_transfer_byte(1,m_vif.pipe_intf.TxSyncHeader,4);
                    bit_buff_serdes.push_back(block_header[i]);
                    block_data = 0;
                    block_data[323:320] = block_header;
                end
                byte_count= 0;
            end
            if(m_vif.pipe_intf.TxDataValid)begin
                for(int i =0 ;i <32 ;i++) begin
                    bit_buff_serdes.push_back(m_vif.pipe_intf.TxData[i]);
                end
                    block_data[319 -32*byte_count-: 32] = big_endian_transfer_byte(1, m_vif.pipe_intf.TxData ,32);
                    byte_count++ ;
                    flag = 1;
            end
            for(int i = 0 ;i<32 ;i++)begin
                pd_data[i] = bit_buff_serdes[0];
                bit_buff_serdes.pop_front();
            end
            m_vif.usb32_debug_intf.pd_data = pd_data;
        end
    end
end
/*}}}*/
endtask

function void cdn_u4_usb32_driver::deassert_TxStartBlock_and_TxSyncHeader();
/*{{{*/
    if(~m_cfg.SerdesArch ) begin //only Original
        TxStartBlock = 0;
        m_vif.pipe_intf.TxStartBlock= 0;
        m_vif.pipe_intf.TxSyncHeader = 0;
    end
/*}}}*/
endfunction

function void cdn_u4_usb32_driver::assert_TxDataValid_in_block_encode();
/*{{{*/
    if(~m_cfg.SerdesArch & (block_count==PD_WIDTH/m_cfg.block_rst_num) & block_count!=0 ) begin //only Original
        block_count =0;
        m_vif.usb32_debug_intf.block_count = block_count;
        m_vif.pipe_intf.TxDataValid = 0;
        m_vif.pipe_intf.TxStartBlock = 0;
        TxStartBlock = 0;
    end
/*}}}*/
endfunction

function void cdn_u4_usb32_driver::gen_block_header();
    bit [3:0] header;
    if(m_cfg.SerdesArch && (~is_skp_insert) && (~sync_period)) begin //DATA BLOCK 0011
        header = big_endian_transfer_byte(0,DATA_BLOCK_HEADER,4);
        for(int i = 0; i<4 ; i++) begin
            bit_buff.push_back(header[i]);
        end
    end else if(m_cfg.SerdesArch && (is_skp_insert||sync_period))begin //Control BLOCK 1100
        header = big_endian_transfer_byte(0,CTRL_BLOCK_HEADER,4);
        for(int i = 0; i<4 ; i++) begin
            bit_buff.push_back(header[i]);
        end
    end
endfunction : gen_block_header

function void cdn_u4_usb32_driver::insert_sync_os();
    if((m_vif.usb32_debug_intf.tseq_os_sent_count % 32 == 0 && m_vif.usb32_debug_intf.tseq_os_sent_count !== 0)|| (m_vif.usb32_debug_intf.ts1_os_sent_count % 32 == 0  & m_vif.usb32_debug_intf.ts1_os_sent_count!==0) || (m_vif.usb32_debug_intf.ts2_os_sent_count % 32 == 0 & m_vif.usb32_debug_intf.ts2_os_sent_count !==0)||(m_vif.usb32_debug_intf.os_count <=16 && symbol_pattern_copy.loopback_test_pattern_en))begin
    sync_period = 1;
    m_vif.usb32_debug_intf.sync_period = 1;
    end
endfunction : insert_sync_os

function void cdn_u4_usb32_driver::gen_TxData_block_payload();
/*{{{*/
    bit[7:0] skp_data_8b = big_endian_transfer_byte(m_cfg.big_endian,symbol_pattern_copy.SKP_GEN2,8);
    bit[7:0] skp_end = big_endian_transfer_byte(m_cfg.big_endian,symbol_pattern_copy.SKP_GEN2_END,8);
    bit[22:0] skp_lfsr = big_endian_transfer_byte(m_cfg.big_endian,cur_lfsr_gen2,23);
    bit [7:0] skp_lfsr_high = {~skp_lfsr[22],skp_lfsr[22:16]};
    bit [7:0] skp_lfsr_mid = skp_lfsr[15:8];
    bit [7:0] skp_lfsr_low = skp_lfsr[7:0];
    bit [7:0] scrambled_data;
    
    if(is_skp_insert) begin
        symbol_num_in_one_block= skp_transmit_number ; //SKP's BLOCK symbol number is not 16 symbol
    end else begin
        symbol_num_in_one_block= symbol_pattern_copy.symbol_count;
    end
    for (int j = 0 ; j < spilt_count; j++) begin
        if(symbol_pattern_copy.ts1_gen_en || symbol_pattern_copy.ts2_gen_en) begin
            symbol_pattern_copy.data_q[5][2] = m_cfg.loopback_enable;
        end
        scrambled_data = scramble_lfsr23(symbol_pattern_copy.data_q[byte_index],cur_lfsr_gen2,next_lfsr_gen2);
        //if(symbol_pattern_copy.random_packet_gen_en) scrambled_data = scramble_lfsr23(test_index,cur_lfsr_gen2,next_lfsr_gen2,0);
        //else         scrambled_data = scramble_lfsr23(symbol_pattern_copy.data_q[byte_index],cur_lfsr_gen2,next_lfsr_gen2,0);
        //test_index ++;
        //`uvm_info(get_name(),$psprintf("scrambled_data  is %h",scrambled_data) , UVM_LOW)
        for(int i = 0 ;i<8 ;i++)begin    
            if(is_skp_insert) begin
                if(byte_index<skp_transmit_number) begin
                    bit_buff.push_back(skp_data_8b[i]);
                end else if(byte_index==skp_transmit_number)begin//SKP END
                    bit_buff.push_back(skp_end[i]);
                end else if(byte_index == skp_transmit_number+1)begin//SKP LFSR
                    bit_buff.push_back(skp_lfsr_low[i]);
                end else if(byte_index == skp_transmit_number+2)begin//SKP LFSR
                    bit_buff.push_back(skp_lfsr_mid[i]);
                end else if(byte_index == skp_transmit_number+3)begin//SKP LFSR
                    bit_buff.push_back(skp_lfsr_high[i]);
                end
            end else if(sync_period) begin
                bit_buff.push_back(symbol_pattern_copy.SYNC_GEN2[j][i]);
                cur_lfsr_gen2 = reset_lfsr_gen2();
            end else begin
                //scrambled_data = symbol_pattern_copy.data_q[byte_index];
                //scrambled_data =0;
                bit_buff.push_back(scrambled_data[i]);
                cur_lfsr_gen2 = next_lfsr_gen2;
            end
        end
        
        if((symbol_pattern_copy.random_packet_gen_en) && ~is_skp_insert && ~sync_period) begin
            if(m_cfg.port_mode == HOST && lane_id == 0) begin
                host_trans.host_txdata_buf_lane0[byte_index] = symbol_pattern_copy.data_q[byte_index];
                if(byte_index==15)
                    drv2scb_stim_ap_host.write(host_trans);
            end else if(m_cfg.port_mode == HOST && lane_id == 1)begin
                host_trans.host_txdata_buf_lane1[byte_index] = symbol_pattern_copy.data_q[byte_index];
                if(byte_index==15)
                   drv2scb_stim_ap_host.write(host_trans);
            end else if(m_cfg.port_mode == DEVICE && lane_id == 0)begin
                devc_trans.devc_txdata_buf_lane0[byte_index] = symbol_pattern_copy.data_q[byte_index];
                 //$fdisplay(fd,"data[%d] is %h",byte_index,devc_trans.devc_txdata_buf_lane0[byte_index]);
                if(byte_index==15)
                    drv2scb_stim_ap_devc.write(devc_trans);
            end else if(m_cfg.port_mode == DEVICE && lane_id == 1)begin
                devc_trans.devc_txdata_buf_lane1[byte_index] = symbol_pattern_copy.data_q[byte_index];
                if(byte_index==15)
                    drv2scb_stim_ap_devc.write(devc_trans);
            end
        end
        for(int i = 0 ;i<8 ;i++)begin
            data_buff[i] = bit_buff[0];
            bit_buff.pop_front();
        end
        data_buff        = big_endian_transfer_byte(m_cfg.big_endian,data_buff,8);//for data big endian adjust
        TxData[(tb_param::SYMBOL_WIDTH*j) +: 8] =data_buff;//for serdes SYMBOL_WIDTH is 10
        if(m_cfg.SerdesArch)//serdes model tx data
            pd_data[8*j +: 8] = data_buff;//serdes model tx data
        byte_index ++;

        m_vif.usb32_debug_intf.byte_index ++;
    end
    m_vif.pipe_intf.TxData = TxData;
    m_vif.usb32_debug_intf.cur_lfsr_gen2   = cur_lfsr_gen2;
    if(m_cfg.SerdesArch)//serdes model tx data
        m_vif.usb32_debug_intf.pd_data = pd_data;//serdes model tx data
/*}}}*/
endfunction : gen_TxData_block_payload

function [31:0] cdn_u4_usb32_driver::big_endian_transfer_byte(input bit en,input bit[31:0] data_in,input int width);
/*{{{*/
    bit [31:0] result;
    if(en) begin
        data_in= {<<{data_in}};
        for(int i =0; i<width ; i++) begin
            result[width-i-1] = data_in[31-i];  
        end
        return result;
    end else begin
        return data_in;
    end
/*}}}*/
endfunction:big_endian_transfer_byte

function cdn_u4_usb32_driver::reset_interface();
    if(~symbol_pattern_copy.random_packet_gen_en) begin
        os_count = 0;
        m_vif.usb32_debug_intf.os_count = 0;
        sync_period = 1;
        m_vif.usb32_debug_intf.sync_period = 1;
    end
    m_vif.usb32_debug_intf.tseq_os_sent_count = 0;
    m_vif.usb32_debug_intf.ts1_os_sent_count = 0;
    m_vif.usb32_debug_intf.ts2_os_sent_count =0;
    m_vif.usb32_debug_intf.Idle_packet_sent_count =0;
endfunction


function [15:0]cdn_u4_usb32_driver::reset_lfsr();
    if(lane_id == 0) begin
        return (LFSR_LANE0);
    end else begin
        return (LFSR_LANE1);
    end
endfunction

function [22:0]cdn_u4_usb32_driver::reset_lfsr_gen2();
    if(lane_id == 0) begin
        return (LFSR_GEN2_LANE0);
    end else begin
        return (LFSR_GEN2_LANE1);
    end
endfunction
 `endif // cdn_u4_usb32_driver__SV


