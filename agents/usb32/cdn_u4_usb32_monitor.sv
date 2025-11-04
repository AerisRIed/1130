
//
// Template for UVM-compliant physical-level monitor
//

`ifndef CDN_U4_USB32_MONITOR__SV
`define CDN_U4_USB32_MONITOR__SV


typedef class cdn_u4_usb32_transaction;
typedef class cdn_u4_usb32_monitor;


   

class cdn_u4_usb32_monitor extends cdn_phy_monitor_base;

   //uvm_analysis_port #(cdn_u4_usb32_transaction) mon_analysis_port;  //TLM analysis port
  // typedef virtual cdn_phy_interface_base v_if;
  // v_if mon_if;
   cdn_u4_usb32_config               m_cfg;
   cdn_u4_usb32_physical_timer_cfg   timer_cfg;
   cdn_phy_vif_t                     m_vif;
   cdn_u4_usb32_symbol_pattern       symbol_pattern;
   cdn_u4_usb32_port_status          port_status;
   uvm_analysis_port #(cdn_u4_usb32_transaction) mon2scb_stim_ap_host;  //TLM analysis port
   uvm_analysis_port #(cdn_u4_usb32_transaction) mon2scb_stim_ap_devc;  //TLM analysis port
   cdn_u4_usb32_transaction host_trans;
   cdn_u4_usb32_transaction devc_trans;
   bit ts1_seen;
   bit tseq_seen;
   bit ts2_seen;
   bit ts1_detected;
   bit ts2_detected;
   bit tseq_detected;
   bit idle_packet_detected;
   int fd;
   int lane_id;
   bit u0_period;
   bit sequence_lock;
   
   bit [8:0] host_rxdata_buf_lane0[16];
   bit [8:0] host_rxdata_buf_lane1[16];   
   bit [8:0] devc_rxdata_buf_lane0[16];
   bit [8:0] devc_rxdata_buf_lane1[16];
   bit [8:0] host_txdata_buf_lane0[16];
   bit [8:0] host_txdata_buf_lane1[16];   
   bit [8:0] devc_txdata_buf_lane0[16];
   bit [8:0] devc_txdata_buf_lane1[16];
   

   
   bit [9:0] cur_data;
   bit [22:0] cur_lfsr_gen2 ;
   bit [22:0] next_lfsr_gen2;
   bit [15:0] cur_lfsr  ;
   bit [15:0] next_lfsr;
   bit [7:0] decode_fifo[$];
   bit kcode_fifo[$];
   bit [7:0] decode_fifo_loopback[$];
   int bit_cursor;
   int symbol_count = 32;
   int tseq_half_cnt;
   bit  symbol_lock;
   // ToDo: Add another class property if required
   extern function new(string name = "cdn_u4_usb32_monitor",uvm_component parent);
   `uvm_component_utils_begin(cdn_u4_usb32_monitor)
      // ToDo: Add uvm monitor member if any class property added later through field macros

   `uvm_component_utils_end
      // ToDo: Add required short hand override method


   extern virtual function void build_phase(uvm_phase phase);
   extern virtual function void end_of_elaboration_phase(uvm_phase phase);
   extern virtual function void start_of_simulation_phase(uvm_phase phase);
   extern virtual function void connect_phase(uvm_phase phase);
   extern virtual function bit is_valid_header(input bit[3:0] header);
   extern virtual task reset_phase(uvm_phase phase);
   extern virtual task configure_phase(uvm_phase phase);
   extern virtual task run_phase(uvm_phase phase);
   extern virtual task monitor_lfps_wake();
   extern virtual task monitor_Ux_exit();
   extern virtual task monitor_usb32_data_gen1_parallel();//RxData
   extern virtual task monitor_usb32_data_gen2_parallel();
   extern virtual task monitor_usb32_data_gen1_serial();
   extern virtual task monitor_usb32_data_gen2_serial();
   extern virtual task decode_loopback_gen1();
   extern virtual task decode_ts_sequence_gen1();
   extern virtual task decode_ts_sequence_gen2();
   extern function [31:0] big_endian_transfer_byte(input bit en,input bit[31:0] data_in,input int width);//big_endian transfer, can trans to LSB first
   extern function [15:0]reset_lfsr();
   extern function [22:0]reset_lfsr_gen2();

endclass: cdn_u4_usb32_monitor


function cdn_u4_usb32_monitor::new(string name = "cdn_u4_usb32_monitor",uvm_component parent);
   super.new(name, parent);
   //mon_analysis_port = new ("mon_analysis_port",this);
endfunction: new

function void cdn_u4_usb32_monitor::build_phase(uvm_phase phase);
   super.build_phase(phase);
   //ToDo : Implement this phase here
   mon2scb_stim_ap_host = new("mon2scb_stim_ap_host",this);
   mon2scb_stim_ap_devc = new("mon2scb_stim_ap_devc",this);
   host_trans = new();
   devc_trans = new();
   symbol_pattern = new();
   //fd = $fopen("host_lane0_rxdata.txt","w");
endfunction: build_phase

function void cdn_u4_usb32_monitor::connect_phase(uvm_phase phase);
   super.connect_phase(phase);
   //uvm_config_db#(v_if)::get(this, "", "usb32_mon_if", mon_if);
   //if (mon_if == null)
   //    `uvm_fatal("NO_CONN", "Virtual port not connected to the actual interface instance");   
endfunction: connect_phase

function void cdn_u4_usb32_monitor::end_of_elaboration_phase(uvm_phase phase);
   super.end_of_elaboration_phase(phase); 
   //ToDo: Implement this phase here

endfunction: end_of_elaboration_phase


function void cdn_u4_usb32_monitor::start_of_simulation_phase(uvm_phase phase);
   super.start_of_simulation_phase(phase);
   //ToDo: Implement this phase here

endfunction: start_of_simulation_phase


task cdn_u4_usb32_monitor::reset_phase(uvm_phase phase);
   super.reset_phase(phase);
   // ToDo: Implement reset here

endtask: reset_phase


task cdn_u4_usb32_monitor::configure_phase(uvm_phase phase);
   super.configure_phase(phase);
   `uvm_info(get_name(),$psprintf("FLIP IS %d",m_cfg.flip),UVM_LOW);
   cur_lfsr      = reset_lfsr();
   cur_lfsr_gen2 = reset_lfsr_gen2();
   //ToDo: Configure your component here
endtask:configure_phase


task cdn_u4_usb32_monitor::run_phase(uvm_phase phase);
   //super.run_phase(phase);
  // phase.raise_objection(this,""); //Raise/drop objections in sequence file
    fork
        if(m_cfg.usb32_gen_speed==GEN1_SPEED) begin
            if(m_cfg.port_mode == DEVICE) begin
                monitor_usb32_data_gen1_serial();
            end else begin
            `ifndef DUT_BYPASS
                monitor_usb32_data_gen1_parallel();
            `else
                monitor_usb32_data_gen1_serial();
            `endif
            end
        end else begin
            if(m_cfg.port_mode == DEVICE) begin
                monitor_usb32_data_gen2_serial();
            end else begin
            `ifndef DUT_BYPASS
                monitor_usb32_data_gen2_parallel();
            `else
                monitor_usb32_data_gen2_serial();
            `endif
            end
        end
        monitor_lfps_wake();
        monitor_Ux_exit();
    join
  // phase.drop_objection(this);

endtask: run_phase

task cdn_u4_usb32_monitor::monitor_lfps_wake(); //Link Parterner 2
    time start_time;
    time detect_time;
    forever begin
        @(posedge m_vif.serdes_rx.receive_lfps);
        if(port_status.usb32_ltssm_state== U1) begin
             #timer_cfg.T_u1_exit_t11_t10;//0.3us - 2us
             m_vif.usb32_debug_intf.u1_exit_detected = 1;
             #(timer_cfg.T_u1_exit_t13_t11);
             m_vif.usb32_debug_intf.low_power_exit_detected= 1;
        end else if(port_status.usb32_ltssm_state== U2)begin
             #timer_cfg.T_u2_exit_t11_t10;//0.3us - 2us
             m_vif.usb32_debug_intf.u2_exit_detected = 1;
             #(timer_cfg.T_u2_exit_t13_t11);
             m_vif.usb32_debug_intf.low_power_exit_detected= 1;
        end else if(port_status.usb32_ltssm_state== LOOPBACK_S)begin
             #timer_cfg.T_u2_exit_t11_t10;//0.3us - 2us
             m_vif.usb32_debug_intf.loopback_exit_detected = 1;
             #(timer_cfg.T_u2_exit_t13_t11);
             m_vif.usb32_debug_intf.low_power_exit_detected= 1;
        end else if(port_status.usb32_ltssm_state== U3)begin
             #timer_cfg.T_u3_exit_t11_t10;//0.3us - 2us
             m_vif.usb32_debug_intf.u3_exit_detected = 1;
             #(timer_cfg.T_u3_exit_t13_t11);
             m_vif.usb32_debug_intf.low_power_exit_detected= 1;
        end
    end
endtask: monitor_lfps_wake

task cdn_u4_usb32_monitor::monitor_Ux_exit();//Link Parterner 1
    forever begin
        @(posedge m_vif.serdes_rx.receive_lfps);
        if(port_status.usb32_ltssm_state== U1_EXIT) begin
          #timer_cfg.T_u1_exit_t12_t11; 
          m_vif.usb32_debug_intf.low_power_exit_detected= 1;
        end else if(port_status.usb32_ltssm_state== U2_EXIT) begin
          #timer_cfg.T_u2_exit_t12_t11;
          m_vif.usb32_debug_intf.low_power_exit_detected= 1;
        end else if(port_status.usb32_ltssm_state== LOOPBACK_EXIT) begin
          #timer_cfg.T_u2_exit_t12_t11;
          m_vif.usb32_debug_intf.low_power_exit_detected= 1;
        end else if(port_status.usb32_ltssm_state== U3_EXIT) begin
          #timer_cfg.T_u3_exit_t12_t11; 
          m_vif.usb32_debug_intf.low_power_exit_detected= 1;
        end
    end
endtask: monitor_Ux_exit

task cdn_u4_usb32_monitor::decode_ts_sequence_gen1();
    bit data_period;
    bit ts1_match =1;
    //bit sequence_lock;
    bit skp_detected;
    bit ts2_match =1;
    bit tseq_match =1;
    bit idle_packet_match =1;
    bit [7:0]scrambed_data;
    int skp_index;
    time a;
while (decode_fifo.size>=16)begin : check_ts 
        //for(int i = 0; i <16 ; i++) begin
        //        `uvm_info(get_name(),$psprintf("decoded_byte %d is %h",i,decode_fifo[i]) , UVM_LOW)
        //end
        for(int i = 0; i <16 ; i++) begin //check un scrambled data
            //if(m_cfg.port_mode ==HOST && lane_id ==0) begin
            //    //$fdisplay(fd,"ID is %d, data is %h",i,{kcode_fifo[i],decode_fifo[i]});
            //   //`uvm_info(get_full_name(),$psprintf("ID is %d, data is %h",i,{kcode_fifo[i],decode_fifo[i]}),UVM_LOW);
            //end
            if(decode_fifo[i] == SKP_GEN1 && kcode_fifo[i] == 1) begin
                if(ts1_detected || ts2_detected || tseq_detected) begin
                    kcode_fifo.delete(i);
                    decode_fifo.delete(i);
                    skp_detected = 1;
                    skp_index = i;
                    break;
                end
            end
            if(i == 5 && ts1_match) begin
                m_vif.usb32_debug_intf.loopback_detected = (decode_fifo[i][2] == 1);
            end else if(decode_fifo[i] !== symbol_pattern.TS1_GEN1[i] ) begin
                ts1_detected = 0;
                ts1_match = 0;
                m_vif.usb32_debug_intf.ts1_os_received_count = 0;
                if(ts1_seen&& ~ts2_match && ~data_period && ~ts2_seen) begin
                    for(int j=0;j<i;j++) begin
                    kcode_fifo.delete(j);
                    decode_fifo.delete(j);
                    end
                    symbol_lock = 0;
                    m_vif.usb32_debug_intf.symbol_lock = 0;
                    `uvm_error(get_full_name(),$psprintf("[un matched ts1] un matched TS1 detected"))
                    sequence_lock =0;
                break;
                end
            end
            if(i == 5 && ts2_match) begin
                m_vif.usb32_debug_intf.loopback_detected = (decode_fifo[i][2] == 1);
            end else if(decode_fifo[i] !== symbol_pattern.TS2_GEN1[i] ) begin
                ts2_detected = 0;
                ts2_match = 0;
                m_vif.usb32_debug_intf.ts2_os_received_count = 0;
            end
            if((decode_fifo[i] !== symbol_pattern.TSEQ_GEN1[i]) && (decode_fifo[i] !== symbol_pattern.TSEQ_GEN1[16+i]))begin 
                tseq_detected = 0;
                tseq_match = 0;
                m_vif.usb32_debug_intf.tseq_os_received_count = 0;
                if(tseq_seen && ~ts1_match&& ~ts2_match&& ~ts1_seen)begin
                    for(int j=0;j<i;j++) begin
                    kcode_fifo.delete(j);
                    decode_fifo.delete(j);
                    end
                    sequence_lock =0;
                    symbol_lock = 0;
                    m_vif.usb32_debug_intf.symbol_lock = 0;
                    `uvm_error(get_full_name(),$psprintf("[un matched tseq] un matched TSEQ detected"))
                    break;
                end
            end
        end
        if(!ts1_match && !ts2_match && !tseq_match && sequence_lock) begin //DATA need to be scrambed
            for(int i = 0; i <16 ; i++) begin //check scrambled data
                if(decode_fifo[i] == COM && kcode_fifo[i]) begin // COM RESET LFSR
                    cur_lfsr = reset_lfsr();
                    next_lfsr = cur_lfsr; 
                    decode_fifo[i]= COM;
                end else if(decode_fifo[i] == SKP_GEN1 && kcode_fifo[i]) begin //skp
                    decode_fifo[i]= scramble_lfsr16(decode_fifo[i],cur_lfsr,next_lfsr,0,0);
                    kcode_fifo.delete(i);
                    decode_fifo.delete(i);
                    skp_detected = 1;
                    skp_index = i;
                    break;
                end else if(decode_fifo[i] !== COM && kcode_fifo[i]) begin //other K code, just advance lfsr
                    decode_fifo[i]= scramble_lfsr16(decode_fifo[i],cur_lfsr,next_lfsr,0,1);
                    cur_lfsr  = next_lfsr;
                end else begin //data scrambled 
                        //end
                    decode_fifo[i]= scramble_lfsr16(decode_fifo[i],cur_lfsr,next_lfsr,1,1);
                    cur_lfsr  = next_lfsr;
                    if(decode_fifo[i]!== IDLE_SYMBOL_GEN1 ) begin //IDLE
                        idle_packet_match= 0;
                        m_vif.usb32_debug_intf.Idle_packet_received_count= 0;
                    end
                        //if(m_cfg.port_mode ==HOST && lane_id ==0) begin
                        //    $fdisplay(fd,"cur lfsr is %h, data is %h",cur_lfsr,{kcode_fifo[i],decode_fifo[i]});
                        //end
                        if(m_cfg.port_mode ==HOST && lane_id ==0) begin
                          host_rxdata_buf_lane0[i]=({kcode_fifo[i],decode_fifo[i]});
                          host_trans.host_rxdata_buf_lane0[i] = host_rxdata_buf_lane0[i];
                          //$fdisplay(fd,"data[%d] is %h",i,host_rxdata_buf_lane0[i]);
                          if(i==15) mon2scb_stim_ap_host.write(host_trans);
                        end else if(m_cfg.port_mode ==HOST && lane_id ==1)begin
                          host_rxdata_buf_lane1[i] =({kcode_fifo[i],decode_fifo[i]});
                          host_trans.host_rxdata_buf_lane1[i] = host_rxdata_buf_lane1[i];
                          if(i==15) mon2scb_stim_ap_host.write(host_trans);
                        end else if(m_cfg.port_mode ==DEVICE && lane_id ==0)begin
                          devc_rxdata_buf_lane0[i] =({kcode_fifo[i],decode_fifo[i]});
                          devc_trans.devc_rxdata_buf_lane0[i] = devc_rxdata_buf_lane0[i];
                          if(i==15) mon2scb_stim_ap_devc.write(devc_trans);
                        end else if(m_cfg.port_mode ==DEVICE && lane_id ==1)begin
                          devc_rxdata_buf_lane1[i] =({kcode_fifo[i],decode_fifo[i]});
                          devc_trans.devc_rxdata_buf_lane1[i] = devc_rxdata_buf_lane1[i];
                          if(i==15) mon2scb_stim_ap_devc.write(devc_trans);
                        end
                end
            end
        end
       if(~skp_detected) begin
            if(ts1_match) begin
                sequence_lock =1;
                ts1_seen = 1;
                m_vif.usb32_debug_intf.ts1_os_received_count++;
                ts1_detected =1;
            end else if(ts2_match)begin
                sequence_lock =1;
                ts2_seen = 1;
                m_vif.usb32_debug_intf.ts2_os_received_count++;
                ts2_detected =1;
            end else if(tseq_match) begin
                sequence_lock =1;
                tseq_seen =1;
                tseq_detected =1;
                tseq_half_cnt ++;
                if(tseq_half_cnt==2)begin
                    m_vif.usb32_debug_intf.tseq_os_received_count ++;
                    tseq_half_cnt = 0;
                end
            end else if(idle_packet_match && sequence_lock)begin
                m_vif.usb32_debug_intf.Idle_packet_received_count++;
                data_period = 1;
            end else begin
                if(~data_period) begin
                    //`uvm_error(get_full_name(),$psprintf("[un matched symbol pattern] un matched symbol pattern detected"))
                end 
            end
        end
        
        
        for(int i = 0; i <16 ; i++) begin
            m_vif.usb32_debug_intf.received_data[8*i +: 8] = decode_fifo[i];
        end
        if(~skp_detected) begin
            for(int i = 0; i <16 ; i++) begin
                decode_fifo.pop_front();
            end
            for(int i = 0; i <16 ; i++) begin
                kcode_fifo.pop_front();
            end
        end
    end

endtask


task cdn_u4_usb32_monitor::decode_loopback_gen1();
    bit bdat_match =1;
        //for(int i = 0; i <16 ; i++) begin
        //        `uvm_info(get_name(),$psprintf("decoded_byte %d is %h",i,decode_fifo[i]) , UVM_LOW)
        //end
        if(decode_fifo_loopback[0] !== 0 ) begin
            bdat_match= 0;
            m_vif.usb32_debug_intf.bdat_received_count= 0;
            `uvm_error(get_name(),$psprintf("[LOOPBACK_ERR] loopback BDAT wrong, please check!!"))
        end 

        if(bdat_match) begin
            m_vif.usb32_debug_intf.bdat_received_count++;
        end 
        decode_fifo_loopback.pop_front();

endtask

task cdn_u4_usb32_monitor::decode_ts_sequence_gen2();
    bit ts1_match =1;
    bit ts2_match =1;
    bit tseq_match =1;
    bit loopback_test_pattern =1;
    bit idle_packet_match =1;
    while (decode_fifo.size>=16)begin 
        for(int i = 0; i <16 ; i++) begin
            if(i == 5 && ts1_match) begin
                m_vif.usb32_debug_intf.loopback_detected = (decode_fifo[i][2] == 1);
            end else if(decode_fifo[i] !== symbol_pattern.TS1_GEN2[i] ) begin
                ts1_match = 0;
                m_vif.usb32_debug_intf.ts1_os_received_count = 0;
            end
            if(i == 5 && ts2_match) begin
                m_vif.usb32_debug_intf.loopback_detected = (decode_fifo[i][2] == 1);
            end else if(decode_fifo[i] !== symbol_pattern.TS2_GEN2[i] ) begin
                ts2_match = 0;
                m_vif.usb32_debug_intf.ts2_os_received_count = 0;
            end 
            if((decode_fifo[i] !== symbol_pattern.TSEQ_GEN2[i]) )begin 
                tseq_match = 0;
                m_vif.usb32_debug_intf.tseq_os_received_count = 0;
            end 
            if((decode_fifo[i] !== IDLE_SYMBOL_GEN2) )begin 
                idle_packet_match = 0;
                m_vif.usb32_debug_intf.Idle_packet_received_count = 0;
            end 
            if((decode_fifo[i] !== 0) )begin 
                loopback_test_pattern= 0;
                m_vif.usb32_debug_intf.loopback_test_pattern_received_count= 0;
            end 
         end
        for(int i = 0; i <16 ; i++) begin
            if(!ts1_match & !ts2_match & !tseq_match& !idle_packet_match) begin// u0
                if(m_cfg.port_mode == HOST && lane_id == 0) begin
                    host_rxdata_buf_lane0[i] =decode_fifo[i];
                    host_trans.host_rxdata_buf_lane0[i] = host_rxdata_buf_lane0[i];
                    //$fdisplay(fd,"data[%d] is %h",i,host_rxdata_buf_lane0[i]);
                    if(i==15)
                    mon2scb_stim_ap_host.write(host_trans);
                end else if(m_cfg.port_mode == HOST && lane_id == 1)begin
                    host_rxdata_buf_lane1[i] = decode_fifo[i];
                    host_trans.host_rxdata_buf_lane1[i] = host_rxdata_buf_lane1[i];
                    if(i==15)
                    mon2scb_stim_ap_host.write(host_trans);
                end else if(m_cfg.port_mode == DEVICE && lane_id == 0)begin
                    devc_rxdata_buf_lane0[i] = decode_fifo[i];
                    devc_trans.devc_rxdata_buf_lane0[i] = devc_rxdata_buf_lane0[i];
                    if(i==15)
                    mon2scb_stim_ap_devc.write(devc_trans);
                end else if(m_cfg.port_mode == DEVICE && lane_id == 1)begin
                    devc_rxdata_buf_lane1[i] = decode_fifo[i];
                    devc_trans.devc_rxdata_buf_lane1[i] = devc_rxdata_buf_lane1[i];
                    if(i==15)
                    mon2scb_stim_ap_devc.write(devc_trans);
                end
            end
        end

        if(ts1_match ) begin
            m_vif.usb32_debug_intf.ts1_os_received_count++;
        end else if(ts2_match)begin
            m_vif.usb32_debug_intf.ts2_os_received_count++;
        end else if(tseq_match) begin
            m_vif.usb32_debug_intf.tseq_os_received_count ++;
        end else if(idle_packet_match) begin
            m_vif.usb32_debug_intf.Idle_packet_received_count++;
        end else if(loopback_test_pattern) begin
            m_vif.usb32_debug_intf.loopback_test_pattern_received_count++;
        end else begin
            u0_period = 1; 
        end
        for(int i = 0; i <16 ; i++) begin
            decode_fifo.pop_front();
        end
    end

endtask


task cdn_u4_usb32_monitor::monitor_usb32_data_gen1_parallel(); //32bit PIPE_PD_WIDTH
  bit [5:0]  comma_idx = 0;
  bit [31:0] shift_reg = 0;  //
  bit [7:0]  cur_8b;
  bit first_lock_period;
  bit [8:0]  K_and_8bdata;
  
  wait(m_vif.pipe_intf.RxDataValid== 1);
    //m_vif.usb32_debug_intf.symbol_lock = 1;
  forever @(posedge m_vif.pclk) begin
    shift_reg = m_vif.pipe_intf.RxData; 
      for (int i = 0; i <= 3; i++) begin
        cur_8b = shift_reg[i*8 +: 8];
        K_and_8bdata = {m_vif.pipe_intf.RxDataK[i],cur_8b};
        if(cur_8b== symbol_pattern.SKP_GEN1 && m_vif.pipe_intf.RxDataK[i]) begin//SKP
            m_vif.usb32_debug_intf.skp_detected = 1;
        end else begin
            m_vif.usb32_debug_intf.skp_detected = 0;
        end
        if(cur_8b == COM && m_vif.pipe_intf.RxDataK[i] && ~symbol_lock) begin//COM
            `uvm_info(get_name(),$psprintf("locked at %d",i) , UVM_LOW)
            m_vif.usb32_debug_intf.symbol_lock= 1;
            symbol_lock = 1;
            first_lock_period = 1;
        end
        if(symbol_lock) begin
            decode_fifo.push_back(cur_8b);
            kcode_fifo.push_back(K_and_8bdata[8]);
            decode_ts_sequence_gen1();
        end
      end
  end
endtask

task cdn_u4_usb32_monitor::monitor_usb32_data_gen1_serial(); //40bit PD_WIDTH
  bit data_q[$];
  bit [9:0]  cur_10b;
  bit [7:0]  decoded_byte;
  bit [8:0]  K_and_8bdata;
  bit is_k_code;
  bit bdata_begin ;  
  
  wait(m_vif.serdes_rx.rx_pd_valid_out == 1);
  forever @(posedge m_vif.serdes_rx.rx_pd_clk_out) begin
    //step 1 : push data into queue
    for(int i= 0 ; i<=39 ;i++) begin
        data_q.push_back(m_vif.serdes_rx.rx_pd_out[i]);
    end
    if(port_status.usb32_ltssm_state== LOOPBACK_S && m_vif.pipe_intf.TxDetectRx) begin
        m_vif.usb32_debug_intf.loopback_data_gen1.push_back(m_vif.serdes_rx.rx_pd_out);
    end
    
    //step 2 : look for SYNC
    if(data_q.size() >= 80) begin 
        if(!m_vif.usb32_debug_intf.symbol_lock) begin
            for(int i =0; i<data_q.size() - 10;i++)begin
                for(int j =0; j<=9 ;j++) begin
                    cur_10b[j] = data_q[j];
                end
                //`uvm_info(get_name(),$psprintf("cur 10b is %h",cur_10b) , UVM_LOW)
                //lock
                if(cur_10b == 10'h17c || cur_10b == 10'h283) begin
                    m_vif.usb32_debug_intf.symbol_lock = 1;
                    break;
                end
                //not lock, shift one bit
                data_q.pop_front();
            end
        end else begin
          // locked，decode from comma_idx 
          repeat(4) begin
            for(int j =0; j<=9 ;j++) begin
                cur_10b[j] = data_q[j];
            end
            repeat(10) begin
                data_q.pop_front();
            end
 
            decoded_byte = datatrans_10b8b(cur_10b);
            is_k_code = datatrans_10b8b(cur_10b)[8];
            K_and_8bdata = {is_k_code,decoded_byte};
            
            if(K_and_8bdata== {1'b1,SUB}) begin
                m_vif.usb32_debug_intf.symbol_lock = 0;
            end
            
            if(K_and_8bdata== {1'b1,SKP_GEN1}) begin//SKP
                m_vif.usb32_debug_intf.skp_detected = 1;
            end else begin
                m_vif.usb32_debug_intf.skp_detected = 0;
            end    
                
            decode_fifo.push_back(decoded_byte);//include skp inside 
            kcode_fifo.push_back(is_k_code);
            decode_ts_sequence_gen1();
            if(port_status.usb32_ltssm_state== LOOPBACK_S&& decoded_byte == BRST) begin
               m_vif.pipe_intf.TxDetectRx = 1;
            end

            if(port_status.usb32_ltssm_state== LOOPBACK_M && decoded_byte == BRST) begin
                cur_lfsr = reset_lfsr();
                bdata_begin = 1;
                m_vif.usb32_debug_intf.bdat_received_count = 0;
            end else if(port_status.usb32_ltssm_state== LOOPBACK_M && bdata_begin&& decoded_byte !==COM && decoded_byte !==BERC)begin
                decoded_byte = scramble_lfsr16(decoded_byte,cur_lfsr,next_lfsr);
                //`uvm_info(get_name(),$psprintf("decoded_byte bdat is %h",decoded_byte) , UVM_LOW)
                cur_lfsr = next_lfsr;
                decode_fifo_loopback.push_back(decoded_byte);
                decode_loopback_gen1();
            end
         end
        end
    end
  end
endtask

task cdn_u4_usb32_monitor::monitor_usb32_data_gen2_parallel(); 
    bit[355:0] block_data; //max size data 40*8
    bit [7:0] symbol_data;
    int count;
    int flag;
    bit[22:0] next_lfsr ;

    wait(m_vif.pipe_intf.RxDataValid== 1); //symbol_lock
    m_vif.usb32_debug_intf.symbol_lock = 1;
    forever begin
        @(posedge m_vif.pclk);//  312.5 * 32 = 10G  
        if(~m_vif.pipe_intf.TxDetectRx) begin //TODO
            if(m_vif.pipe_intf.RxStartBlock) begin
                if(flag == 1) begin
                    if(block_data[355 -: 4] == big_endian_transfer_byte(0,CTRL_BLOCK_HEADER,4) && ( block_data[351 -: 8] ==  big_endian_transfer_byte(1,SKP_GEN2,8)|| block_data[351 -: 8] ==  big_endian_transfer_byte(1,SKP_GEN2_END,8))) begin//SKP check TODO
                    end else if(block_data[355 -: 4] == big_endian_transfer_byte(0,CTRL_BLOCK_HEADER,4)&& block_data[351 -: 128] == SYNC[127:0]) begin //SYNC
                        cur_lfsr_gen2 = reset_lfsr_gen2();
                    end else begin //data
                        for(int i = 0 ;i<16 ;i++) begin
                            symbol_data     =   block_data[351-8*i -: 8];
                            symbol_data     =   big_endian_transfer_byte(1,symbol_data,8);
                            symbol_data     =   scramble_lfsr23(symbol_data,cur_lfsr_gen2,next_lfsr);
                            cur_lfsr_gen2   =   next_lfsr;
                            decode_fifo.push_back(symbol_data);    
                        end
                    end
                    decode_ts_sequence_gen2();
                end
                foreach(m_vif.pipe_intf.RxSyncHeader[i])begin
                    block_data = 0;
                    block_data[355:352] = m_vif.pipe_intf.RxSyncHeader;
                end
                count= 0;
            end
            if(m_vif.pipe_intf.RxDataValid)begin //sync
                    block_data[351 -32*count-: 32] = big_endian_transfer_byte(1, m_vif.pipe_intf.RxData ,32);
                    count++ ;
                    flag = 1;
            end
        end
    end
endtask

task cdn_u4_usb32_monitor::monitor_usb32_data_gen2_serial();
  bit data_q[$];
  bit [131:0] data_buff;
  bit [7:0] symbol_data;
  bit [131:0] sync_pattern = SYNC;
  bit [131:0] block_data;
  int skp_symbol_num;
  int block_num = 132;
  int skp_over_one_block ;
  bit [355:0] decode_data;
 
  wait(m_vif.serdes_rx.rx_pd_valid_out == 1);
  forever begin
    @(posedge m_vif.serdes_rx.rx_pd_clk_out);    
    //step 1 : push data into queue
    for(int i= 0 ; i<=31 ;i++) begin
        data_q.push_back(m_vif.serdes_rx.rx_pd_out[i]);
    end
    if(port_status.usb32_ltssm_state== LOOPBACK_S && m_vif.pipe_intf.TxDetectRx) begin
        m_vif.usb32_debug_intf.loopback_data_gen2.push_back(m_vif.serdes_rx.rx_pd_out);
    end
    
    //step 2 : look for SYNC
    if(data_q.size() >= 350) begin // 5 PCLK has passed and data size is 160
        if(!m_vif.usb32_debug_intf.symbol_lock) begin
            block_num = 132;
            for(int i =0; i<data_q.size()-132 ;i++)begin
                for(int j =0; j<=131 ;j++) begin
                    data_buff[131-j] = data_q[j];
                end
                //lock
                if(data_buff == sync_pattern) begin
                    m_vif.usb32_debug_intf.symbol_lock = 1;
                    block_data = data_buff;
                    `uvm_info(get_name(),$psprintf("locked! at cnt %d block data is %h size is %d",i,block_data,data_q.size()) , UVM_LOW)
                    repeat(block_num) begin
                        data_q.pop_front();
                    end
                    break;
                end 
                //not lock, shift one bit
                data_q.pop_front();
            end
        end else begin //locked
            for(int j =0; j<=131 ;j++) begin
                block_data[131-j] = data_q[j];
            end
            //`uvm_info(get_name(),$psprintf("block data is %h size is %d",block_data,data_q.size()) , UVM_LOW)
            if(~is_valid_header(block_data[131:128])&& ~m_vif.usb32_debug_intf.skp_detected) begin
                m_vif.usb32_debug_intf.symbol_lock = 0;
                `uvm_error(get_name(),$psprintf("[BLOCK HEADER ERROR] BLOCK HEADER ERROR DETECTED!!"));
            end else begin // data valid then can decode
                if(block_data == sync_pattern) begin
                    cur_lfsr_gen2 = reset_lfsr_gen2();
                    skp_over_one_block = 0;
                    if(port_status.usb32_ltssm_state== LOOPBACK_S) begin
                        m_vif.pipe_intf.TxDetectRx = 1;
                        //foreach(block_data[i]) begin
                        //    m_vif.usb32_debug_intf.loopback_data.push_back(block_data[i]);
                        //end
                    end
                end else if(block_data[131:128] == big_endian_transfer_byte(1,CTRL_BLOCK_HEADER,4)&& ~m_vif.usb32_debug_intf.skp_detected) begin // ctrl block to detected SKP
                    while(block_data[127 -: 8] == big_endian_transfer_byte(1,SKP_GEN2_END,8)) begin
                        m_vif.usb32_debug_intf.skp_detected = 1;
                        skp_symbol_num ++;
                        block_data[127:0] = block_data[127:0] << 8;
                        if(skp_symbol_num == 16) begin
                            block_num = 132;
                            skp_over_one_block = 1;
                            break;
                        end
                    end 
                    if(block_data[127 -: 8] == big_endian_transfer_byte(1,SKP_GEN2,8)) begin //skp end
                        block_num = (skp_symbol_num + 4)*8 + 4;
                        if(skp_symbol_num % 4 !==0 || skp_symbol_num > 36) begin
                        `uvm_error(get_name(),$psprintf("[SKP ERROR] SKP detected Symbol Number %d cannot meet the spec. Please refer to USB32 SPEC 6.4.3.3",skp_symbol_num));
                        end
                        skp_symbol_num = 0;
                        m_vif.usb32_debug_intf.skp_detected = 0;
                    end
                end else if(block_data[131 -: 8] == big_endian_transfer_byte(1,SKP_GEN2_END,8)&&m_vif.usb32_debug_intf.skp_detected) begin //ctrl block to detected SKP over one block
                    while(block_data[131 -: 8] == big_endian_transfer_byte(1,SKP_GEN2_END,8)) begin
                        skp_symbol_num ++;
                        block_data[131:0] = block_data[131:0] << 8;
                        if(skp_symbol_num == 32) begin //two block
                            block_num = 128;
                            skp_over_one_block = 1;
                            break;
                        end
                    end 
                    if(block_data[131 -: 8] == big_endian_transfer_byte(1,SKP_GEN2,8)) begin
                        block_num = (skp_symbol_num -16*(skp_symbol_num / 16) + 4)*8 ;
                        m_vif.usb32_debug_intf.skp_detected = 0;
                        if(skp_symbol_num % 4 !==0 || skp_symbol_num > 36) begin
                        `uvm_error(get_name(),$psprintf("[SKP ERROR] SKP detected Symbol Number %d cannot meet the spec. Please refer to USB32 SPEC 6.4.3.3",skp_symbol_num));
                        end
                        skp_symbol_num = 0;
                    end
                end else if(block_data[131 -: 8] ==  big_endian_transfer_byte(1,SKP_GEN2,8)&& m_vif.usb32_debug_intf.skp_detected) begin
                        block_num = (skp_symbol_num -16*(skp_symbol_num / 16) + 4)*8 ;
                        m_vif.usb32_debug_intf.skp_detected = 0;
                        if(skp_symbol_num % 4 !==0 || skp_symbol_num > 36) begin
                        `uvm_error(get_name(),$psprintf("[SKP ERROR] SKP detected Symbol Number %d cannot meet the spec. Please refer to USB32 SPEC 6.4.3.3",skp_symbol_num));
                        end
                        skp_symbol_num = 0;
                end else begin // normal pattern
                    skp_over_one_block = 0;
                    block_num = 132;
                    for(int i = 0 ;i<16 ;i++) begin
                        symbol_data     =   block_data[127-8*i -: 8];
                        symbol_data     =   big_endian_transfer_byte(1,symbol_data,8);
                        symbol_data     =   scramble_lfsr23(symbol_data,cur_lfsr_gen2,next_lfsr_gen2);
                        cur_lfsr_gen2   =   next_lfsr_gen2;
                        decode_fifo.push_back(symbol_data);    
                    end
                end
            end
            decode_ts_sequence_gen2();
            //check data during U0
            if(u0_period) begin
                if(skp_over_one_block == 1 && block_num == 132) begin //skp over one block
                    for(int j =0; j<=block_num-1;j++) begin
                        decode_data[355-j] = data_q[j];
                    end
                end else if(skp_over_one_block ==1)begin//skp over one block reserved
                    for(int j =0; j<=block_num-1;j++) begin
                        decode_data[355-132 -j] = data_q[j];
                    end
                end
                if(skp_over_one_block!==1) begin
                    decode_data = 0;
                    for(int j =0; j<=block_num-1;j++) begin
                        decode_data[355-j] = data_q[j];
                    end
                end
            end
            repeat(block_num) begin
                data_q.pop_front();
            end
        end
    end
  end 
endtask
 
function bit cdn_u4_usb32_monitor::is_valid_header(input bit[3:0] header);
    return(header == CTRL_BLOCK_HEADER || header == DATA_BLOCK_HEADER);
endfunction


function [31:0] cdn_u4_usb32_monitor::big_endian_transfer_byte(input bit en,input bit[31:0] data_in,input int width);
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

function [15:0]cdn_u4_usb32_monitor::reset_lfsr();
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

function [22:0]cdn_u4_usb32_monitor::reset_lfsr_gen2();
    if(~m_cfg.flip) begin
        if(lane_id == 0) begin
            return (LFSR_GEN2_LANE0);
        end else begin
            return (LFSR_GEN2_LANE1);
        end
    end else begin
    `ifdef DUT_BYPASS
        if(lane_id == 0) begin
            return (LFSR_GEN2_LANE1);
        end else begin
            return (LFSR_GEN2_LANE0);
        end
    `else
        if(lane_id == 0) begin
            return (LFSR_GEN2_LANE0);
        end else begin
            return (LFSR_GEN2_LANE1);
        end
    `endif
    end
endfunction
`endif // cdn_u4_usb32_monitor__SV
