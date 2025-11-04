//
// Template for UVM-compliant physical-level transactor
//

`ifndef cdn_u4_usb4_driver__SV
`define cdn_u4_usb4_driver__SV

typedef class cdn_u4_usb4_driver;
class cdn_u4_usb4_driver extends cdn_phy_driver_base;
    
    //--------------------------------
    // Member
    //--------------------------------
    cdn_u4_usb4_symbol_pattern      symbol_pattern;
	cdn_u4_usb4_symbol_pattern      symbol_pattern_copy;
    cdn_u4_usb4_config              m_cfg;
    cdn_u4_usb4_physical_timer_cfg   timer_cfg;
    cdn_u4_usb4_transaction          host_trans;
    cdn_u4_usb4_transaction          devc_trans;
    
    //cdn_phy_vif_t m_vif;
    int lane_id;
    int PD_WIDTH = tb_param::PD_WIDTH;
    bit [1023 :0] TxData;
    bit [39:0] pd_data;
    bit[7:0] data_buff;
    int spilt_count; //spilt PD_WIDTH into spilt_count, for example 1 PCLK can send spilt_counts bytes 
    int os_count;
    int byte_index;
    int block_count;
    bit bit_buff[$]; 
    bit bit_buff_serdes[$]; 
    int retimer_number ;//to simulater retimer adjust SKP function ,for U32 SKP used
    int symbol_num_in_one_block ;
    int os_number ;
    int symbol_num; // one Order set or Data set can contains symbols bytes
    bit sync_period = 1; 
    bit TxStartBlock ;
    //---------------------------------------
    //scramble variables
    //---------------------------------------
    bit[22:0] cur_lfsr ;
    bit[22:0] next_lfsr;
    bit drop = 0;
    //---------------------------------------
    // Factory 
    //---------------------------------------
    `uvm_component_utils(cdn_u4_usb4_driver)
    //`uvm_register_cb(cdn_u4_usb4_driver,cdn_callback)
     
	//-------------------------------------
	// Model will receive symbol_pattern on this port from ltssm operation
	//-------------------------------------
    uvm_analysis_export #(cdn_u4_usb4_symbol_pattern)   cdn_u4_usb4_symbol_export_ep;
    uvm_tlm_analysis_fifo #(cdn_u4_usb4_symbol_pattern) cdn_u4_usb4_symbol_fifo; //imp
	//-------------------------------------
	// scb
    // //-------------------------------------
    uvm_analysis_port#(cdn_u4_usb4_transaction)   drv2scb_stim_ap_host;
    uvm_analysis_port#(cdn_u4_usb4_transaction)   drv2scb_stim_ap_devc;
    //---------------------------------------
    // Constructor
    //---------------------------------------
    function new (string name = "cdn_u4_usb4_driver", uvm_component parent);
        super.new(name,parent);
    endfunction : new
    extern function void build_phase(uvm_phase phase);
    extern function void connect_phase(uvm_phase phase);
    extern function void update_interface();
    
	//-------------------------------------
	//  block encode functions , block encode means encode based from 128/13x 64/66, can used in U32 Gen2,PCIe Gen3/4 and DP
	//-------------------------------------
    extern function void gen_block_header();
    extern function void gen_TxData_block_payload();
    extern task send_stream_block_encode();

    extern function [31:0] big_endian_transfer_byte(input bit en,input bit[31:0] data_in,input int width);//big_endian transfer, can trans to LSB first
    extern function reset_interface();
    extern function [22:0] reset_lfsr();
	//-------------------------------------
    // usb4 special polling lfps functions
	//-------------------------------------
    extern task gen_lowpower_lfps_wake();
	//-------------------------------------
    // other function
	//-------------------------------------
    extern task gen_power_down(input bit[3:0] PowerDown);
    
	//-------------------------------------
    // callback function
	//-------------------------------------
    //extern virtual function void pre_usb4_symbol_pattern(cdn_u4_usb4_symbol_pattern symbol_pattern, ref bit drop);
    
    extern task get_symbol_pattern();
    extern task driver_symbol_set();
    extern task run_phase(uvm_phase phase);
endclass

function void cdn_u4_usb4_driver::build_phase(uvm_phase phase);
	super.build_phase(phase);/*{{{*/
	
	cdn_u4_usb4_symbol_export_ep = new("cdn_u4_usb4_symbol_export_ep", this);
	cdn_u4_usb4_symbol_fifo      = new("cdn_u4_usb4_symbol_fifo", this);
	symbol_pattern_copy= new();
    host_trans      = new();
    devc_trans      = new();
    drv2scb_stim_ap_host = new("drv2scb_stim_ap_host",this);
    drv2scb_stim_ap_devc = new("drv2scb_stim_ap_devc",this);
    //timer_cfg = new("timer_cfg");

endfunction : build_phase/*}}}*/

function void cdn_u4_usb4_driver::connect_phase(uvm_phase phase);
	super.connect_phase(phase);
	cdn_u4_usb4_symbol_export_ep.connect(cdn_u4_usb4_symbol_fifo.analysis_export);/*{{{*/
endfunction : connect_phase/*}}}*/

task cdn_u4_usb4_driver::run_phase(uvm_phase phase);
    super.run_phase(phase);
    cur_lfsr = reset_lfsr();
    spilt_count   =  PD_WIDTH / 10; 
    fork 
        forever begin
            get_symbol_pattern();
        end
        forever begin
            //#0;
            driver_symbol_set();
        end
    join
endtask : run_phase

task cdn_u4_usb4_driver::get_symbol_pattern();
        cdn_u4_usb4_symbol_fifo.get(symbol_pattern);
        `uvm_info(get_name(), $psprintf("sent the symbol gen obj = %s", symbol_pattern.sprint()), UVM_LOW);
		`uvm_info(get_name(), $psprintf("sent the symbol gen copy before obj = %s", symbol_pattern_copy.sprint()), UVM_LOW);
        wait(byte_index == symbol_pattern_copy.os_number);
        //avoid block boundary break
        reset_interface();//when get a new orderset
        symbol_pattern_copy.do_copy(symbol_pattern);
		`uvm_info(get_name(), $psprintf("sent the symbol gen copy obj = %s", symbol_pattern_copy.sprint()), UVM_LOW);
endtask : get_symbol_pattern

task cdn_u4_usb4_driver::driver_symbol_set();
    forever begin
        @(posedge m_vif.pclk);
        #0;
        symbol_pattern_copy.gen_data();
        //pre_usb4_symbol_pattern(symbol_pattern_copy,drop);
        symbol_num = symbol_pattern_copy.symbol_count;
        //add callback here TODO
        //----------------------
        //----------------------TODO may use case instead
        if(symbol_pattern_copy.lfps_gen_en) begin
            gen_power_down(P0_STATE);
            //gen_polling_lfps();
        end else if (symbol_pattern_copy.slos1_gen_en||symbol_pattern_copy.slos2_gen_en||symbol_pattern_copy.ts1_gen_en||symbol_pattern_copy.ts2_gen_en||symbol_pattern_copy.random_packet_gen_en)begin
            send_stream_block_encode();
        end else if (symbol_pattern_copy.electric_idle_en) begin
            m_vif.usb4_debug_intf.serdes_tx_valid = 0;
            m_vif.pipe_intf.TxElecIdle = 1;
            gen_power_down(P1_STATE);
        end
        
        if(symbol_pattern_copy.cl1_exit_gen_en||symbol_pattern_copy.cl2_exit_gen_en||symbol_pattern_copy.cl0s_exit_gen_en) begin
            gen_lowpower_lfps_wake();
        end
        //----------------------TODO may use case instead
    end
endtask : driver_symbol_set

//function void cdn_u4_usb4_driver::pre_usb4_symbol_pattern(cdn_u4_usb4_symbol_pattern symbol_pattern, ref bit drop);
//	`uvm_do_callbacks(cdn_u4_usb4_driver,cdn_callback, pre_usb4_symbol_pattern(symbol_pattern, drop));
//endfunction : pre_usb4_symbol_pattern/*}}}*/


//--------------gen_power_down--------------//
task cdn_u4_usb4_driver::gen_power_down(input bit[3:0] PowerDown);
    /*{{{*/
        m_vif.pipe_intf.PowerDown = PowerDown;
    /*}}}*/
endtask : gen_power_down

//--------------gen_lowpower_lfps_wake--------------//
task cdn_u4_usb4_driver::gen_lowpower_lfps_wake();
    /*{{{*/
    m_vif.usb4_debug_intf.lfps_transmitter_en = 1;
    m_vif.pipe_intf.TxElecIdle= 0;
    //m_vif.pipe_intf.TxDataValid = 0;
    //burst
    m_vif.pipe_intf.TxDetectRx = 1;
    forever begin
        m_vif.serdes_tx.serial_txp= 1;
        m_vif.serdes_tx.serial_txn= 0;
        #(timer_cfg.t_Period*timer_cfg.t_LFPS_Duty_cycle/100);
        m_vif.serdes_tx.serial_txp= 0;
        m_vif.serdes_tx.serial_txn= 1;
        #(timer_cfg.t_Period*(100-timer_cfg.t_LFPS_Duty_cycle)/100);
        if(m_vif.usb4_debug_intf.low_power_exit_detected) begin 
            gen_power_down(P0_STATE);
            m_vif.usb4_debug_intf.low_power_exit_detected = 0;
            break;
        end
    end
    m_vif.pipe_intf.TxDetectRx = 0;
    symbol_pattern_copy.cl1_exit_gen_en = 0;
    symbol_pattern_copy.cl2_exit_gen_en= 0;
    symbol_pattern_copy.cl0s_exit_gen_en= 0;
    m_vif.usb4_debug_intf.lfps_transmitter_en = 0;
    /*}}}*/
endtask : gen_lowpower_lfps_wake



//--------------send_stream_block_encode--------------//
task cdn_u4_usb4_driver::send_stream_block_encode();
/*{{{*/
    m_vif.pipe_intf.TxDataValid = 1;
    m_vif.pipe_intf.TxElecIdle= 0;
    m_vif.usb4_debug_intf.serdes_tx_valid= 1;
    if((byte_index % symbol_num_in_one_block) ==0) begin 
        block_count++;
        m_vif.usb4_debug_intf.block_count = block_count;
        gen_block_header();
    end else if(byte_index == 0 && block_count == 0)begin
        gen_block_header();
    end
    
    if(byte_index == os_number)begin //
        byte_index = 0;
        m_vif.usb4_debug_intf.byte_index =0;
        os_count ++;
        m_vif.usb4_debug_intf.os_count = os_count;
        update_interface();
    end
    if(m_vif.usb4_debug_intf.serdes_tx_valid== 1) begin
        gen_TxData_block_payload();
    end else begin
        m_vif.pipe_intf.TxData = 'bz; //invalid data
    end
/*}}}*/
endtask :send_stream_block_encode



//--------------update_interface--------------//
function void cdn_u4_usb4_driver::update_interface();
    if(symbol_pattern_copy.slos1_gen_en) begin
        m_vif.usb4_debug_intf.slos1_sent_count = m_vif.usb4_debug_intf.os_count;
    end else if(symbol_pattern_copy.slos2_gen_en)begin
        m_vif.usb4_debug_intf.slos2_sent_count  = m_vif.usb4_debug_intf.os_count;
    end else if(symbol_pattern_copy.ts1_gen_en)begin
        m_vif.usb4_debug_intf.ts1_sent_count  = m_vif.usb4_debug_intf.os_count;
    end else if(symbol_pattern_copy.ts2_gen_en)begin
        m_vif.usb4_debug_intf.ts2_sent_count  = m_vif.usb4_debug_intf.os_count;
    end
endfunction: update_interface

function void cdn_u4_usb4_driver::gen_block_header();
    if(~symbol_pattern_copy.random_packet_gen_en) begin
        if(m_cfg.usb4_gen_speed == GEN2_SPEED && m_cfg.fec_off) begin
            foreach(symbol_pattern_copy.CTRL_BLOCK_HEADER_64[i]) begin
                bit_buff.push_back(symbol_pattern_copy.CTRL_BLOCK_HEADER_64[i]);
            end
        end else begin
            foreach(symbol_pattern_copy.CTRL_BLOCK_HEADER_128[i]) begin
                bit_buff.push_back(symbol_pattern_copy.CTRL_BLOCK_HEADER_128[i]);
            end
        end
    end else begin
        if(m_cfg.usb4_gen_speed == GEN2_SPEED && m_cfg.fec_off) begin
            foreach(symbol_pattern_copy.DATA_BLOCK_HEADER_64[i]) begin
                bit_buff.push_back(symbol_pattern_copy.DATA_BLOCK_HEADER_64[i]);
            end
        end else begin
            foreach(symbol_pattern_copy.DATA_BLOCK_HEADER_128[i]) begin
                bit_buff.push_back(symbol_pattern_copy.DATA_BLOCK_HEADER_128[i]);
            end
        end
    end
endfunction : gen_block_header


function void cdn_u4_usb4_driver::gen_TxData_block_payload();
/*{{{*/
    bit [7:0] scrambled_data;
    
    symbol_num_in_one_block= symbol_pattern_copy.symbol_count;
    os_number= symbol_pattern_copy.os_number;
    for (int j = 0 ; j < spilt_count; j++) begin
        if(symbol_pattern_copy.slos1_gen_en || symbol_pattern_copy.slos2_gen_en|| symbol_pattern_copy.random_packet_gen_en) begin
            scrambled_data = symbol_pattern_copy.data_q[byte_index];
            if(symbol_pattern_copy.random_packet_gen_en) begin
                if(m_cfg.port_mode == HOST && lane_id == 0) begin
                    host_trans.host_txdata_buf_lane0[byte_index] = symbol_pattern_copy.data_q[byte_index];
                    if(m_cfg.usb4_gen_speed==GEN2_SPEED&&byte_index==15) begin
                        drv2scb_stim_ap_host.write(host_trans);
                    end else if(m_cfg.usb4_gen_speed==GEN1_SPEED&&byte_index==7)begin
                        drv2scb_stim_ap_host.write(host_trans);
                    end
                end else if(m_cfg.port_mode == HOST && lane_id == 1)begin
                    host_trans.host_txdata_buf_lane1[byte_index] = symbol_pattern_copy.data_q[byte_index];
                    if(m_cfg.usb4_gen_speed==GEN2_SPEED&&byte_index==15) begin
                        drv2scb_stim_ap_host.write(host_trans);
                    end else if(m_cfg.usb4_gen_speed==GEN1_SPEED&&byte_index==7)begin
                        drv2scb_stim_ap_host.write(host_trans);
                    end
                end else if(m_cfg.port_mode == DEVICE && lane_id == 0)begin
                    devc_trans.devc_txdata_buf_lane0[byte_index] = symbol_pattern_copy.data_q[byte_index];
                    if(m_cfg.usb4_gen_speed==GEN2_SPEED&&byte_index==15) begin
                        drv2scb_stim_ap_host.write(devc_trans);
                    end else if(m_cfg.usb4_gen_speed==GEN1_SPEED&&byte_index==7)begin
                        drv2scb_stim_ap_host.write(devc_trans);
                    end
                end else if(m_cfg.port_mode == DEVICE && lane_id == 1)begin
                    devc_trans.devc_txdata_buf_lane1[byte_index] = symbol_pattern_copy.data_q[byte_index];
                    if(m_cfg.usb4_gen_speed==GEN2_SPEED&&byte_index==15) begin
                        drv2scb_stim_ap_host.write(devc_trans);
                    end else if(m_cfg.usb4_gen_speed==GEN1_SPEED&&byte_index==7)begin
                        drv2scb_stim_ap_host.write(devc_trans);
                    end
                end
            end
        end else if(symbol_pattern_copy.ts1_gen_en||symbol_pattern_copy.ts2_gen_en) begin
            scrambled_data = scramble_lfsr23(symbol_pattern_copy.data_q[byte_index],cur_lfsr,next_lfsr,1);
            if(byte_index ==6 || byte_index ==14) begin
                scrambled_data[7:6] = big_endian_transfer_byte(1,symbol_pattern_copy.SCR[10:9],2);
            end
            if(byte_index ==7 || byte_index ==15) begin
                scrambled_data[7:0] = big_endian_transfer_byte(1,symbol_pattern_copy.SCR[7:0],8);
            end
           cur_lfsr = next_lfsr;
        end
        for(int i = 0 ;i<8 ;i++)begin    
            //scrambled_data = symbol_pattern_copy.data_q[byte_index];
            //scrambled_data =0;
            bit_buff.push_back(scrambled_data[i]);
        end
        for(int i = 0 ;i<8 ;i++)begin
            data_buff[i] = bit_buff[0];
            bit_buff.pop_front();
        end
        data_buff        = big_endian_transfer_byte(m_cfg.big_endian,data_buff,8);//for data big endian adjust
        TxData[(10*j) +: 8] =data_buff;//for serdes SYMBOL_WIDTH is 10
        if(m_cfg.SerdesArch)//serdes model tx data
            pd_data[8*j +: 8] = data_buff;//serdes model tx data
        byte_index ++;

        m_vif.usb4_debug_intf.byte_index ++;
    end
    m_vif.pipe_intf.TxData = TxData;
    m_vif.usb4_debug_intf.cur_lfsr   = cur_lfsr;
    if(m_cfg.SerdesArch)//serdes model tx data
        m_vif.usb4_debug_intf.pd_data = pd_data;//serdes model tx data
/*}}}*/
endfunction : gen_TxData_block_payload

function [31:0] cdn_u4_usb4_driver::big_endian_transfer_byte(input bit en,input bit[31:0] data_in,input int width);
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

function cdn_u4_usb4_driver::reset_interface();
    byte_index = 0;
    os_count = 0;
    m_vif.usb4_debug_intf.byte_index= 0;
    m_vif.usb4_debug_intf.os_count = 0;
    m_vif.usb4_debug_intf.slos1_sent_count = 0;
    m_vif.usb4_debug_intf.slos2_sent_count = 0;
    m_vif.usb4_debug_intf.ts1_sent_count = 0;
    m_vif.usb4_debug_intf.ts2_sent_count =0;
endfunction

function [22:0]cdn_u4_usb4_driver::reset_lfsr();
    if(lane_id == 0) begin
        return (LFSR_LANE0);
    end else begin
        return (LFSR_LANE1);
    end
 endfunction
   
 `endif // cdn_u4_usb4_driver__SV


