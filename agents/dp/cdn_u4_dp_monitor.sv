//
// Template for UVM-compliant physical-level monitor
//

`ifndef CDN_U4_DP_MONITOR__SV
`define CDN_U4_DP_MONITOR__SV


typedef class cdn_u4_dp_transaction;
typedef class cdn_u4_dp_monitor;


   

class cdn_u4_dp_monitor extends cdn_phy_monitor_base;

   //---------------------------------
   // Member config and interface
   //---------------------------------
   cdn_u4_dp_config  m_cfg;
  // //uvm_analysis_port #(cdn_u4_dp_transaction) mon_analysis_port;  //TLM analysis port
  // typedef virtual cdn_phy_interface_base v_if;
  // v_if mon_if;

   //---------------------------------
   // Member variables
   //---------------------------------
   bit [31:0] dp_raw_txdata_q[$];
   bit [31:0] dp_ser_rxdata_q[$];

   //---------------------------------
   // Analysis port declaration
   //---------------------------------
   uvm_analysis_port #(bit [31:0]) mon_raw_txdata_ap;
   uvm_analysis_port #(bit [31:0]) mon_ser_rxdata_ap;

   //---------------------------------------
   // Factory 
   //---------------------------------------
   // ToDo: Add another class property if required
   `uvm_component_utils_begin(cdn_u4_dp_monitor)
      // ToDo: Add uvm monitor member if any class property added later through field macros

   `uvm_component_utils_end
      // ToDo: Add required short hand override method

   //---------------------------------
   // UVM functions and tasks
   //---------------------------------
   extern function new(string name = "cdn_u4_dp_monitor",uvm_component parent);
   extern virtual function void build_phase(uvm_phase phase);
   extern virtual function void end_of_elaboration_phase(uvm_phase phase);
   extern virtual function void start_of_simulation_phase(uvm_phase phase);
   extern virtual function void connect_phase(uvm_phase phase);
   extern virtual task reset_phase(uvm_phase phase);
   extern virtual task configure_phase(uvm_phase phase);
   extern virtual task run_phase(uvm_phase phase);

   //---------------------------------
   // User functions and tasks
   //---------------------------------
   extern virtual task dp_tx_monitor();
   extern virtual task dp_raw_txdata_mon();
   extern virtual task dp_ser_rxdata_mon();
   extern virtual task dp_ser_rxtps_mon();
   extern virtual function void write_raw_txdata();
   extern virtual function void write_ser_rxdata();

endclass: cdn_u4_dp_monitor


function cdn_u4_dp_monitor::new(string name = "cdn_u4_dp_monitor",uvm_component parent);
   super.new(name, parent);
   //mon_analysis_port = new ("mon_analysis_port",this);
endfunction: new

function void cdn_u4_dp_monitor::build_phase(uvm_phase phase);
   super.build_phase(phase);
   // get configs
   if (!uvm_config_db#(cdn_u4_dp_config)::get(this, "", "m_cfg", m_cfg)) begin
     `uvm_fatal(get_type_name(), "m_cfg not set")
   end
   // creation of the analysis port
   mon_raw_txdata_ap = new("mon_raw_txdata_ap",this);
   mon_ser_rxdata_ap = new("mon_ser_rxdata_ap",this);
endfunction: build_phase

function void cdn_u4_dp_monitor::connect_phase(uvm_phase phase);
   super.connect_phase(phase);
  // uvm_config_db#(v_if)::get(this, "", "dp_mon_if", mon_if);
  // if (mon_if == null)
  //     `uvm_fatal("NO_CONN", "Virtual port not connected to the actual interface instance");   
endfunction: connect_phase

function void cdn_u4_dp_monitor::end_of_elaboration_phase(uvm_phase phase);
   super.end_of_elaboration_phase(phase); 
   //ToDo: Implement this phase here

endfunction: end_of_elaboration_phase


function void cdn_u4_dp_monitor::start_of_simulation_phase(uvm_phase phase);
   super.start_of_simulation_phase(phase);
   //ToDo: Implement this phase here

endfunction: start_of_simulation_phase


task cdn_u4_dp_monitor::reset_phase(uvm_phase phase);
   super.reset_phase(phase);
   // ToDo: Implement reset here

endtask: reset_phase


task cdn_u4_dp_monitor::configure_phase(uvm_phase phase);
   super.configure_phase(phase);
   //ToDo: Configure your component here
endtask:configure_phase


task cdn_u4_dp_monitor::run_phase(uvm_phase phase);
   super.run_phase(phase);
  // phase.raise_objection(this,""); //Raise/drop objections in sequence file
   dp_tx_monitor();
  // phase.drop_objection(this);

endtask: run_phase

// monitor dp tx path
task cdn_u4_dp_monitor::dp_tx_monitor();
   fork
     dp_raw_txdata_mon();
     dp_ser_rxdata_mon();
   join
endtask: dp_tx_monitor

// collect raw side txdata
task cdn_u4_dp_monitor::dp_raw_txdata_mon();
   forever begin
     @(negedge m_vif.pipe_intf.pma_tx_td_clk);
     if(m_cfg.port_mode == HOST && m_vif.pipe_intf.pma_tx_elec_idle_ln == 0) begin // TODO LFPS
       dp_raw_txdata_q.push_back(m_vif.pipe_intf.pma_tx_td_ln[31:0]);
     end
     write_raw_txdata();
   end
endtask: dp_raw_txdata_mon

// collect serial side rxdata
task cdn_u4_dp_monitor::dp_ser_rxdata_mon();
   bit ser_data_q[$];
   bit [9:0]   cur_10b;
   bit [19:0]  cur_20b;
   bit [31:0]  cur_32b;
   forever begin
     @(posedge m_vif.serdes_rx.rx_pd_clk_out);
     if(m_cfg.port_mode == DEVICE && m_vif.serdes_rx.rx_pd_valid_out == 1) begin // TODO LFPS
       if(m_cfg.data_rate inside {DP_RBR,DP_HBR,DP_HBR2,DP_HBR3}) begin // 8b10b
         // step 1 : push data into queue
         for(int i=0; i<20; i++) begin
           ser_data_q.push_back(m_vif.serdes_rx.rx_pd_out[i]);
         end
         // step 2 : look for symbol
         if(ser_data_q.size() >= 40) begin 
           if(!m_vif.dp_debug_intf.symbol_lock) begin
             for(int i=0; i<ser_data_q.size()-10; i++)begin
               for(int j=0; j<10; j++) begin
                   cur_10b[j] = ser_data_q[j];
               end
               // locked
               if(cur_10b == 10'h17c || cur_10b == 10'h283) begin
                   m_vif.dp_debug_intf.symbol_lock = 1;
                   break;
               end
               // not lock, shift one bit
               ser_data_q.pop_front();
             end
           end else begin
             // locked, check if the symbol is valid
             for(int j=0; j<20 ;j++) begin
                 cur_20b[j] = ser_data_q[j];
             end
             //if(K_and_8bdata== {1'b1,SUB}) begin //TODO
             //    m_vif.dp_debug_intf.symbol_lock = 0;
             //end
             dp_ser_rxdata_q.push_back({12'h0, cur_20b[19:0]});
             m_vif.dp_debug_intf.symbol_locked_data = cur_20b[19:0];
             repeat(20) begin
                 ser_data_q.pop_front();
             end
           end
         end else if(ser_data_q.size() >= 20) begin
           if(m_vif.dp_debug_intf.symbol_lock) begin
             // locked
             for(int j=0; j<20 ;j++) begin
                 cur_20b[j] = ser_data_q[j];
             end
             dp_ser_rxdata_q.push_back({12'h0, cur_20b[19:0]});
             m_vif.dp_debug_intf.symbol_locked_data = cur_20b[19:0];
             repeat(20) begin
                 ser_data_q.pop_front();
             end
           end
         end
       end else begin  // 128b132b
         // step 1 : push data into queue
         for(int i=0; i<32; i++) begin
           ser_data_q.push_back(m_vif.serdes_rx.rx_pd_out[i]);
         end
         // step 2 : look for symbol
         if(ser_data_q.size() >= 64) begin 
           if(!m_vif.dp_debug_intf.symbol_lock) begin
             for(int i=0; i<ser_data_q.size()-32; i++)begin
               for(int j=0; j<32; j++) begin
                   cur_32b[j] = ser_data_q[j];
               end
               // locked
               if(cur_32b == 32'h33CC_CCCC || cur_32b == 32'h333C_3C3C) begin
                   m_vif.dp_debug_intf.symbol_lock = 1;
                   break;
               end
               // not lock, shift one bit
               ser_data_q.pop_front();
             end
           end else begin
             // locked
             for(int j=0; j<32; j++) begin
                 cur_32b[j] = ser_data_q[j];
             end
             //if(K_and_8bdata== {1'b1,SUB}) begin //TODO
             //    m_vif.dp_debug_intf.symbol_lock = 0;
             //end
             dp_ser_rxdata_q.push_back(cur_32b[31:0]);
             m_vif.dp_debug_intf.symbol_locked_data = cur_32b[31:0];
             repeat(32) begin
                 ser_data_q.pop_front();
             end
           end
         end else if(ser_data_q.size() >= 32) begin
           if(m_vif.dp_debug_intf.symbol_lock) begin
             // locked
             for(int j=0; j<32; j++) begin
                 cur_32b[j] = ser_data_q[j];
             end
             dp_ser_rxdata_q.push_back(cur_32b[31:0]);
             m_vif.dp_debug_intf.symbol_locked_data = cur_32b[31:0];
             repeat(32) begin
                 ser_data_q.pop_front();
             end
           end
         end
       end
     end
     write_ser_rxdata();
   end
endtask: dp_ser_rxdata_mon

// check serial side rxdata tps
task cdn_u4_dp_monitor::dp_ser_rxtps_mon();
   forever begin
	  #2ms; // TODO
   end
endtask: dp_ser_rxtps_mon

// write raw txdata to scb
function void cdn_u4_dp_monitor::write_raw_txdata();
   bit [31:0] raw_txdata;
   while(dp_raw_txdata_q.size() > 0) begin
     raw_txdata = dp_raw_txdata_q.pop_front();
     mon_raw_txdata_ap.write(raw_txdata);
   end
endfunction : write_raw_txdata

// write ser rxdata to scb
function void cdn_u4_dp_monitor::write_ser_rxdata();
   bit [31:0] ser_rxdata;
   while(dp_ser_rxdata_q.size() > 0) begin
     ser_rxdata = dp_ser_rxdata_q.pop_front();
     mon_ser_rxdata_ap.write(ser_rxdata);
   end
endfunction : write_ser_rxdata

`endif // CDN_U4_DP_MONITOR__SV
