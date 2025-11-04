//
// Template for UVM-compliant physical-level monitor
//

`ifndef CDN_U4_USB4_MONITOR__SV
`define CDN_U4_USB4_MONITOR__SV


typedef class cdn_u4_usb4_transaction;
typedef class cdn_u4_usb4_monitor;


   

class cdn_u4_usb4_monitor extends cdn_phy_monitor_base;

   //uvm_analysis_port #(cdn_u4_usb4_transaction) mon_analysis_port;  //TLM analysis port
  // typedef virtual cdn_phy_interface_base v_if;
  // v_if mon_if;
   cdn_u4_usb4_config               m_cfg;
   cdn_u4_usb4_physical_timer_cfg   timer_cfg;
   cdn_phy_vif_t                     m_vif;
   cdn_u4_usb4_symbol_pattern       symbol_pattern;
   cdn_u4_usb4_port_status          port_status;
   uvm_analysis_port #(cdn_u4_usb4_transaction) mon2scb_stim_ap_host;  //TLM analysis port
   uvm_analysis_port #(cdn_u4_usb4_transaction) mon2scb_stim_ap_devc;  //TLM analysis port
   cdn_u4_usb4_transaction host_trans;
   cdn_u4_usb4_transaction devc_trans;
   bit [9:0] cur_data;
   bit [22:0] cur_lfsr;
   bit [22:0] next_lfsr;
   bit [63:0] decode_fifo[$];
   bit [63:0] decode_fifo_ts[$];
   bit [127:0] decode_fifo_128[$];
   bit [127:0] decode_fifo_ts_128[$];
   int lane_id;
   int bit_cursor;
   int symbol_count = 32;
   int tseq_half_cnt;
   // ToDo: Add another class property if required
   extern function new(string name = "cdn_u4_usb4_monitor",uvm_component parent);
   `uvm_component_utils_begin(cdn_u4_usb4_monitor)
      // ToDo: Add uvm monitor member if any class property added later through field macros

   `uvm_component_utils_end
      // ToDo: Add required short hand override method


   extern virtual function void build_phase(uvm_phase phase);
   extern virtual function void end_of_elaboration_phase(uvm_phase phase);
   extern virtual function void start_of_simulation_phase(uvm_phase phase);
   extern virtual function void connect_phase(uvm_phase phase);
   extern virtual function bit is_valid_header(input int header_num,input bit[3:0] header);
   extern virtual task reset_phase(uvm_phase phase);
   extern virtual task configure_phase(uvm_phase phase);
   extern virtual task run_phase(uvm_phase phase);
   extern virtual task monitor_lfps_wake();
   extern virtual task monitor_Ux_exit();
   extern virtual task monitor_usb4_data_6466_serial();
   extern virtual task monitor_usb4_data_128132_serial();
   extern virtual task monitor_usb4_data_6466_parallel();
   extern virtual task monitor_usb4_data_128132_parallel();
   extern virtual task decode_slos_sequence_6466();
   extern virtual task decode_slos_sequence_128132();
   extern virtual task decode_ts_sequence_6466();
   extern virtual task decode_ts_sequence_128132();
   extern function [31:0] big_endian_transfer_byte(input bit en,input bit[31:0] data_in,input int width);//big_endian transfer, can trans to LSB first
   extern function [22:0] reset_lfsr(); 

endclass: cdn_u4_usb4_monitor


function cdn_u4_usb4_monitor::new(string name = "cdn_u4_usb4_monitor",uvm_component parent);
   super.new(name, parent);
   //mon_analysis_port = new ("mon_analysis_port",this);
endfunction: new

function void cdn_u4_usb4_monitor::build_phase(uvm_phase phase);
   super.build_phase(phase);
   //ToDo : Implement this phase here
   symbol_pattern = new();
   mon2scb_stim_ap_host = new("mon2scb_stim_ap_host",this);
   mon2scb_stim_ap_devc = new("mon2scb_stim_ap_devc",this);
   host_trans = new();
   devc_trans = new();
endfunction: build_phase

function void cdn_u4_usb4_monitor::connect_phase(uvm_phase phase);
   super.connect_phase(phase);
   //uvm_config_db#(v_if)::get(this, "", "usb4_mon_if", mon_if);
   //if (mon_if == null)
   //    `uvm_fatal("NO_CONN", "Virtual port not connected to the actual interface instance");   
endfunction: connect_phase

function void cdn_u4_usb4_monitor::end_of_elaboration_phase(uvm_phase phase);
   super.end_of_elaboration_phase(phase); 
   //ToDo: Implement this phase here

endfunction: end_of_elaboration_phase


function void cdn_u4_usb4_monitor::start_of_simulation_phase(uvm_phase phase);
   super.start_of_simulation_phase(phase);
   //ToDo: Implement this phase here

endfunction: start_of_simulation_phase


task cdn_u4_usb4_monitor::reset_phase(uvm_phase phase);
   super.reset_phase(phase);
   // ToDo: Implement reset here

endtask: reset_phase


task cdn_u4_usb4_monitor::configure_phase(uvm_phase phase);
   super.configure_phase(phase);
   cur_lfsr = reset_lfsr();
   //ToDo: Configure your component here
endtask:configure_phase


task cdn_u4_usb4_monitor::run_phase(uvm_phase phase);
   //super.run_phase(phase);
  // phase.raise_objection(this,""); //Raise/drop objections in sequence file
    fork
        if(m_cfg.usb4_gen_speed == GEN2_SPEED && m_cfg.fec_off)
            if(m_cfg.port_mode == HOST) begin
            `ifndef DUT_BYPASS
                monitor_usb4_data_6466_parallel();
            `else
                monitor_usb4_data_6466_serial();
            `endif
            end else begin
                monitor_usb4_data_6466_serial();
            end
        else
            if(m_cfg.port_mode == HOST) begin
            `ifndef DUT_BYPASS
                monitor_usb4_data_128132_parallel();
            `else
                monitor_usb4_data_128132_serial();
            `endif
            end else begin
                monitor_usb4_data_128132_serial();
            end
        monitor_lfps_wake();
        monitor_Ux_exit();
    join
  // phase.drop_objection(this);

endtask: run_phase

task cdn_u4_usb4_monitor::monitor_lfps_wake(); //Link Parterner 2
    time start_time;
    time detect_time;
    forever begin
        @(posedge m_vif.serdes_rx.receive_lfps);
    end
endtask: monitor_lfps_wake

task cdn_u4_usb4_monitor::monitor_Ux_exit();//Link Parterner 1
    forever begin
        @(posedge m_vif.serdes_rx.receive_lfps);
    end
endtask: monitor_Ux_exit


task cdn_u4_usb4_monitor::decode_slos_sequence_128132();
    bit slos1_match =1;
    bit slos2_match =1;
    while (decode_fifo_128.size>=16)begin 
        for(int i = 0; i <16 ; i++) begin
            if(decode_fifo_128[i] !== {symbol_pattern.SLOS1_6664[2*i],symbol_pattern.SLOS1_6664[2*i+1]} ) begin
                slos1_match = 0;
                m_vif.usb4_debug_intf.slos1_received_count = 0;
            end
            if(decode_fifo_128[i] !== {symbol_pattern.SLOS2_6664[2*i],symbol_pattern.SLOS2_6664[2*i+1]} ) begin
                slos2_match = 0;
                m_vif.usb4_debug_intf.slos2_received_count = 0;
            end
        end

        if(slos1_match ) begin
            m_vif.usb4_debug_intf.slos1_received_count++;
        end else if(slos2_match)begin
            m_vif.usb4_debug_intf.slos2_received_count++;
        end else begin
            //$display("match is %d %d %d",tseq_match,ts1_match,ts2_match);
        end
        for(int i = 0; i <16 ; i++) begin
            decode_fifo_128.pop_front();
        end
    end
endtask

task cdn_u4_usb4_monitor::decode_ts_sequence_128132();
    bit ts1_match =1;
    bit ts2_match =1;
        if(decode_fifo_ts_128[0]!=={symbol_pattern.TS1[63:0],symbol_pattern.TS1[63:0]}) begin
            ts1_match = 0;
            m_vif.usb4_debug_intf.ts1_received_count = 0;
        end
        if(decode_fifo_ts_128[0]!=={symbol_pattern.TS2[63:0],symbol_pattern.TS2[63:0]}) begin
            ts2_match = 0;
            m_vif.usb4_debug_intf.ts2_received_count = 0;
        end

        if(ts1_match ) begin
            m_vif.usb4_debug_intf.ts1_received_count= m_vif.usb4_debug_intf.ts1_received_count+2;
        end else if(ts2_match)begin
            m_vif.usb4_debug_intf.ts2_received_count= m_vif.usb4_debug_intf.ts2_received_count+2;
        end else begin
            //$display("match is %d %d %d",tseq_match,ts1_match,ts2_match);
        end
        decode_fifo_ts_128.pop_front();
endtask

task cdn_u4_usb4_monitor::decode_slos_sequence_6466();
    bit slos1_match =1;
    bit slos2_match =1;
    while (decode_fifo.size==32)begin 
        for(int i = 0; i <32 ; i++) begin
            if(decode_fifo[i] !== {symbol_pattern.SLOS1_6664[i]}) begin
                //if(m_cfg.port_mode == DEVICE) begin
                //`uvm_error(get_name(),$psprintf("decode data[%d] is %b",i,decode_fifo[i]))
                //`uvm_error(get_name(),$psprintf("golden slos1[%d] is %b",i,symbol_pattern.SLOS1_6664[i]))
                //end
                slos1_match = 0;
                m_vif.usb4_debug_intf.slos1_received_count = 0;
            end
            if(decode_fifo[i] !== {symbol_pattern.SLOS2_6664[i]}) begin
                slos2_match = 0;
                m_vif.usb4_debug_intf.slos2_received_count = 0;
            end
        end

        if(slos1_match ) begin
            m_vif.usb4_debug_intf.slos1_received_count++;
        end else if(slos2_match)begin
            m_vif.usb4_debug_intf.slos2_received_count++;
        end else begin
            //$display("match is %d %d %d",tseq_match,ts1_match,ts2_match);
        end
        repeat(32) begin    
            decode_fifo.pop_front();
        end
    end
endtask

task cdn_u4_usb4_monitor::decode_ts_sequence_6466();
    bit ts1_match =1;
    bit ts2_match =1;
        if(decode_fifo_ts[0]!==symbol_pattern.TS1[63:0]) begin
            ts1_match = 0;
            m_vif.usb4_debug_intf.ts1_received_count = 0;
        end
        if(decode_fifo_ts[0]!==symbol_pattern.TS2[63:0]) begin
            ts2_match = 0;
            m_vif.usb4_debug_intf.ts2_received_count = 0;
        end

        if(ts1_match ) begin
            m_vif.usb4_debug_intf.ts1_received_count= m_vif.usb4_debug_intf.ts1_received_count+1;
        end else if(ts2_match)begin
            m_vif.usb4_debug_intf.ts2_received_count= m_vif.usb4_debug_intf.ts2_received_count+1;
        end else begin
            //$display("match is %d %d %d",tseq_match,ts1_match,ts2_match);
        end
        decode_fifo_ts.pop_front();
endtask

task cdn_u4_usb4_monitor::monitor_usb4_data_6466_parallel(); //32bit PD_WIDTH
  bit data_q[$];
  bit [65:0] data_buff;
  bit [7:0] symbol_data;
  bit [65:0] slos_pattern_lock = {2'b10,64'b01000000001010000001000100001010_10100100000001101000001110010001};
  //bit [65:0] slos_pattern_lock = {2'b10,64'b01010101010101010101010101010101_01010101010101010101010101010101};
  bit [65:0] block_data;
  int block_num = 66;
 
  wait(m_vif.usb4_debug_intf.serdes_tx_valid== 1);
  forever begin
    @(posedge m_vif.pipe_intf.RxCLK);    
    //step 1 : push data into queue
    for(int j=0 ;j<4 ;j++) begin
        for(int i= 0 ; i<8 ;i++) begin
            data_q.push_back(m_vif.pipe_intf.RxData[10*j + i]);
        end
    end
    
    //step 2 : look for SYNC
    if(data_q.size() >= 160) begin // 5 PCLK has passed and data size is 160
        if(!m_vif.usb4_debug_intf.symbol_lock) begin
            for(int i =0; i<data_q.size()-66 ;i++)begin
                for(int j =0; j<=65 ;j++) begin
                    data_buff[65-j] = data_q[j];
                end
                //lock
                if(data_buff == slos_pattern_lock) begin
                    m_vif.usb4_debug_intf.symbol_lock = 1;
                    block_data = data_buff;
                    `uvm_info(get_name(),$psprintf("locked! at cnt %d block data is %h size is %d",i,block_data,data_q.size()) , UVM_LOW)
                    decode_fifo.push_back(block_data[63:0]);    
                    decode_fifo_ts.push_back(block_data[63:0]);    
                    repeat(block_num) begin
                        data_q.pop_front();
                    end
                    break;
                end 
                   // `uvm_info(get_name(),$psprintf("block_data is %b",data_buff) , UVM_LOW)
                //not lock, shift one bit
                data_q.pop_front();
            end
        end else begin //locked
            for(int j =0; j<=65 ;j++) begin
                block_data[65-j] = data_q[j];
            end
            if(~is_valid_header(2,block_data[65:64])) begin
                m_vif.usb4_debug_intf.symbol_lock = 0;
                `uvm_error(get_name(),$psprintf("[BLOCK HEADER ERROR] BLOCK HEADER ERROR DETECTED!!"));
            end else begin // data valid then can decode
                if(block_data[9:0] == symbol_pattern.SCR)begin//SCRAMBLE EN
                    for(int i =0 ; i<=7 ;i++) begin
                        block_data[63 -8*i -: 8]=scramble_lfsr23(big_endian_transfer_byte(1,block_data[63 -8*i -: 8],8),cur_lfsr,next_lfsr);
                        block_data[63 -8*i -: 8] = big_endian_transfer_byte(1,block_data[63 -8*i -: 8],8);
                        cur_lfsr = next_lfsr;
                    end
                    block_data[9:0] = symbol_pattern.SCR;
                //`uvm_error(get_name(),$psprintf("block_data is %b",block_data));
                end
                decode_fifo.push_back(block_data[63:0]);    
                decode_fifo_ts.push_back(block_data[63:0]);
            end 
            //need to add control block condition TODO
            decode_slos_sequence_6466();
            decode_ts_sequence_6466();
            repeat(66) begin
                data_q.pop_front();
            end
        end
    end
  end 
endtask




task cdn_u4_usb4_monitor::monitor_usb4_data_6466_serial(); //32bit PD_WIDTH
  bit data_q[$];
  bit [65:0] data_buff;
  bit [7:0] symbol_data;
  bit [65:0] slos_pattern_lock = {2'b10,64'b01000000001010000001000100001010_10100100000001101000001110010001};
  //bit [65:0] slos_pattern_lock = {2'b10,64'b01010101010101010101010101010101_01010101010101010101010101010101};
  bit [65:0] block_data;
  int block_num = 66;
 
  wait(m_vif.serdes_rx.rx_pd_valid_out == 1);
  forever begin
    @(posedge m_vif.serdes_rx.rx_pd_clk_out);    
    //step 1 : push data into queue
    for(int i= 0 ; i<=31 ;i++) begin
        data_q.push_back(m_vif.serdes_rx.rx_pd_out[i]);
    end
    
    //step 2 : look for SYNC
    if(data_q.size() >= 200) begin // 5 PCLK has passed and data size is 160
        if(!m_vif.usb4_debug_intf.symbol_lock) begin
            for(int i =0; i<data_q.size()-66 ;i++)begin
                for(int j =0; j<=65 ;j++) begin
                    data_buff[65-j] = data_q[j];
                end
                //lock
                if(data_buff == slos_pattern_lock) begin
                    m_vif.usb4_debug_intf.symbol_lock = 1;
                    block_data = data_buff;
                    `uvm_info(get_name(),$psprintf("locked! at cnt %d block data is %h size is %d",i,block_data,data_q.size()) , UVM_LOW)
                    decode_fifo.push_back(block_data[63:0]);    
                    decode_fifo_ts.push_back(block_data[63:0]);    
                    repeat(block_num) begin
                        data_q.pop_front();
                    end
                    break;
                end 
                   // `uvm_info(get_name(),$psprintf("block_data is %b",data_buff) , UVM_LOW)
                //not lock, shift one bit
                data_q.pop_front();
            end
        end else begin //locked
            for(int j =0; j<=65 ;j++) begin
                block_data[65-j] = data_q[j];
            end
            if(~is_valid_header(2,block_data[65:64])) begin
                m_vif.usb4_debug_intf.symbol_lock = 0;
                `uvm_error(get_name(),$psprintf("[BLOCK HEADER ERROR] BLOCK HEADER ERROR DETECTED!!"));
                `uvm_error(get_name(),$psprintf("[BLOCK HEADER ERROR] block_data is %b",block_data));
            end else begin // data valid then can decode
                if(block_data[9:0] == symbol_pattern.SCR)begin//SCRAMBLE EN
                    for(int i =0 ; i<=7 ;i++) begin
                        block_data[63 -8*i -: 8]=scramble_lfsr23(big_endian_transfer_byte(1,block_data[63 -8*i -: 8],8),cur_lfsr,next_lfsr);
                        block_data[63 -8*i -: 8] = big_endian_transfer_byte(1,block_data[63 -8*i -: 8],8);
                        cur_lfsr = next_lfsr;
                    end
                    block_data[9:0] = symbol_pattern.SCR;
                //`uvm_error(get_name(),$psprintf("block_data is %b",block_data));
                end
                //`uvm_error(get_name(),$psprintf("block_data is %b",block_data));
                decode_fifo.push_back(block_data[63:0]);    
                decode_fifo_ts.push_back(block_data[63:0]);
            end 
            //need to add control block condition TODO
            decode_slos_sequence_6466();
            decode_ts_sequence_6466();
            repeat(66) begin
                data_q.pop_front();
            end
        end
    end
  end 
endtask

task cdn_u4_usb4_monitor::monitor_usb4_data_128132_serial();
  bit data_q[$];
  bit [131:0] data_buff;
  bit [7:0] symbol_data;
  bit [131:0] slos_pattern_lock = {4'b1010,128'b01000000001010000001000100001010_10100100000001101000001110010001_10111010111010100010100001010001_00100010101101010000110000100111};
  bit [131:0] block_data;
  int block_num = 132;
 
  wait(m_vif.serdes_rx.rx_pd_valid_out == 1);
  forever begin
    @(posedge m_vif.serdes_rx.rx_pd_clk_out);    
    //step 1 : push data into queue
    for(int i= 0 ; i<=31 ;i++) begin
        data_q.push_back(m_vif.serdes_rx.rx_pd_out[i]);
    end
    
    //step 2 : look for SYNC
    if(data_q.size() >= 320) begin // 5 PCLK has passed and data size is 160
        if(!m_vif.usb4_debug_intf.symbol_lock) begin
            for(int i =0; i<data_q.size()-132 ;i++)begin
                for(int j =0; j<=131 ;j++) begin
                    data_buff[131-j] = data_q[j];
                end
                //lock
                if(data_buff == slos_pattern_lock) begin
                    m_vif.usb4_debug_intf.symbol_lock = 1;
                    block_data = data_buff;
                    `uvm_info(get_name(),$psprintf("locked! at cnt %d block data is %h size is %d",i,block_data,data_q.size()) , UVM_LOW)
                    decode_fifo_128.push_back(block_data[128:0]);    
                    decode_fifo_ts_128.push_back(block_data[128:0]);    
                    repeat(block_num) begin
                        data_q.pop_front();
                    end
                    break;
                end 
                   // `uvm_info(get_name(),$psprintf("block_data is %b",data_buff) , UVM_LOW)
                //not lock, shift one bit
                data_q.pop_front();
            end
        end else begin //locked
            for(int j =0; j<=131 ;j++) begin
                block_data[131-j] = data_q[j];
            end
            if(~is_valid_header(4,block_data[131:128])) begin
                m_vif.usb4_debug_intf.symbol_lock = 0;
                `uvm_error(get_name(),$psprintf("[BLOCK HEADER ERROR] BLOCK HEADER ERROR DETECTED ,%b!!",block_data));
            end else begin // data valid then can decode
                if(block_data[9:0] == symbol_pattern.SCR && block_data[73:64] == symbol_pattern.SCR)begin//SCRAMBLE EN
                    for(int i =0 ; i<=15 ;i++) begin
                        block_data[127 -8*i -: 8]=scramble_lfsr23(big_endian_transfer_byte(1,block_data[127 -8*i -: 8],8),cur_lfsr,next_lfsr);
                        block_data[127 -8*i -: 8] = big_endian_transfer_byte(1,block_data[127 -8*i -: 8],8);
                        cur_lfsr = next_lfsr;
                    end
                    block_data[9:0] = symbol_pattern.SCR;
                    block_data[73:64] = symbol_pattern.SCR;
                //`uvm_error(get_name(),$psprintf("block_data is %b",block_data));
                end
                //`uvm_error(get_name(),$psprintf("block_data is %b",block_data));
                decode_fifo_128.push_back(block_data[127:0]);    
                decode_fifo_ts_128.push_back(block_data[127:0]);
            end 
            //need to add control block condition TODO
            decode_slos_sequence_128132();
            decode_ts_sequence_128132();
            repeat(132) begin
                data_q.pop_front();
            end
        end
    end
  end 
endtask
 
task cdn_u4_usb4_monitor::monitor_usb4_data_128132_parallel();
  bit data_q[$];
  bit [131:0] data_buff;
  bit [7:0] symbol_data;
  bit [131:0] slos_pattern_lock = {4'b1010,128'b01000000001010000001000100001010_10100100000001101000001110010001_10111010111010100010100001010001_00100010101101010000110000100111};
  bit [131:0] block_data;
  int block_num = 132;
 
  wait(m_vif.pipe_intf.RxValid== 1);
  forever begin
    @(posedge m_vif.pipe_intf.RxCLK);    
    //step 1 : push data into queue
    for(int j=0 ;j<4 ;j++) begin
        for(int i= 0 ; i<8 ;i++) begin
            data_q.push_back(m_vif.pipe_intf.RxData[10*j + i]);
        end
    end
    
    //step 2 : look for SYNC
    if(data_q.size() >= 320) begin // 5 PCLK has passed and data size is 160
        if(!m_vif.usb4_debug_intf.symbol_lock) begin
            for(int i =0; i<data_q.size()-132 ;i++)begin
                for(int j =0; j<=131 ;j++) begin
                    data_buff[131-j] = data_q[j];
                end
                //lock
                if(data_buff == slos_pattern_lock) begin
                    m_vif.usb4_debug_intf.symbol_lock = 1;
                    block_data = data_buff;
                    `uvm_info(get_name(),$psprintf("locked! at cnt %d block data is %h size is %d",i,block_data,data_q.size()) , UVM_LOW)
                    decode_fifo_128.push_back(block_data[128:0]);    
                    decode_fifo_ts_128.push_back(block_data[128:0]);    
                    repeat(block_num) begin
                        data_q.pop_front();
                    end
                    break;
                end 
                   // `uvm_info(get_name(),$psprintf("block_data is %b",data_buff) , UVM_LOW)
                //not lock, shift one bit
                data_q.pop_front();
            end
        end else begin //locked
            for(int j =0; j<=131 ;j++) begin
                block_data[131-j] = data_q[j];
            end
            if(~is_valid_header(4,block_data[131:128])) begin
                m_vif.usb4_debug_intf.symbol_lock = 0;
                `uvm_error(get_name(),$psprintf("[BLOCK HEADER ERROR] BLOCK HEADER ERROR DETECTED ,%b!!",block_data));
            end else begin // data valid then can decode
                if(block_data[9:0] == symbol_pattern.SCR && block_data[73:64] == symbol_pattern.SCR)begin//SCRAMBLE EN
                    for(int i =0 ; i<=15 ;i++) begin
                        block_data[127 -8*i -: 8]=scramble_lfsr23(big_endian_transfer_byte(1,block_data[127 -8*i -: 8],8),cur_lfsr,next_lfsr);
                        block_data[127 -8*i -: 8] = big_endian_transfer_byte(1,block_data[127 -8*i -: 8],8);
                        cur_lfsr = next_lfsr;
                    end
                    block_data[9:0] = symbol_pattern.SCR;
                    block_data[73:64] = symbol_pattern.SCR;
                //`uvm_error(get_name(),$psprintf("block_data is %b",block_data));
                end
                //`uvm_error(get_name(),$psprintf("block_data is %b",block_data));
                decode_fifo_128.push_back(block_data[127:0]);    
                decode_fifo_ts_128.push_back(block_data[127:0]);
            end 
            //need to add control block condition TODO
            decode_slos_sequence_128132();
            decode_ts_sequence_128132();
            repeat(132) begin
                data_q.pop_front();
            end
        end
    end
  end 
endtask

function bit cdn_u4_usb4_monitor::is_valid_header(input int header_num,input bit[3:0] header);
    if(header_num==4)begin
        return(header == 4'b1010 || header == 4'b0101);
    end else if(header_num==2) begin
        return(header[1:0] == 2'b10 || header[1:0] == 2'b01);
    end
endfunction


function [31:0] cdn_u4_usb4_monitor::big_endian_transfer_byte(input bit en,input bit[31:0] data_in,input int width);
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

function [22:0]cdn_u4_usb4_monitor::reset_lfsr();
    if(~m_cfg.flip) begin //non flip
        if(lane_id == 0) begin
            return (LFSR_LANE0);
        end else begin
            return (LFSR_LANE1);
        end
    end else begin //flip
    `ifdef DUT_BYPASS
        if(lane_id == 0) begin
            return (LFSR_LANE1);
        end else begin
            return (LFSR_LANE0);
        end
    `else
        if(lane_id == 0) begin
            return (LFSR_LANE0);
        end else begin
            return (LFSR_LANE1);
        end
    `endif
    end
endfunction

`endif // cdn_u4_usb4_monitor__SV
