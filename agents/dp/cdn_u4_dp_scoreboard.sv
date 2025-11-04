//
// Template for UVM Scoreboard

`ifndef CDN_U4_DP_SCOREBOARD__SV
`define CDN_U4_DP_SCOREBOARD__SV

`uvm_analysis_imp_decl(_raw_txdata)
`uvm_analysis_imp_decl(_ser_rxdata)

class cdn_u4_dp_scoreboard extends cdn_phy_scoreboard_base;

   //uvm_analysis_export #(cdn_phy_transaction_base) before_export, after_export;
   //uvm_in_order_class_comparator #(cdn_phy_transaction_base) comparator;

   //---------------------------------
   // Member variables
   //---------------------------------
   bit [31:0] scb_raw_txdata_q[$];
   bit [31:0] scb_ser_rxdata_q[$];
   bit        match_begin=0;
   bit        compare_en=1; // TODO to be opened

   //---------------------------------
   // Analysis imp declaration
   //---------------------------------
   uvm_analysis_imp_raw_txdata #(bit [31:0], cdn_u4_dp_scoreboard) mon_raw_txdata_imp;
   uvm_analysis_imp_ser_rxdata #(bit [31:0], cdn_u4_dp_scoreboard) mon_ser_rxdata_imp;

   //---------------------------------------
   // Factory 
   //---------------------------------------
   `uvm_component_utils(cdn_u4_dp_scoreboard)

   //---------------------------------
   // UVM functions and tasks
   //---------------------------------
   extern function new(string name = "cdn_u4_dp_scoreboard",
                   uvm_component parent = null); 
   extern virtual function void build_phase (uvm_phase phase);
   extern virtual function void connect_phase (uvm_phase phase);
   extern virtual task main_phase(uvm_phase phase);
   extern virtual function void report_phase(uvm_phase phase);

   //---------------------------------
   // User functions and tasks
   //---------------------------------
   extern virtual function void write_raw_txdata(bit [31:0] raw_txdata);
   extern virtual function void write_ser_rxdata(bit [31:0] ser_rxdata);
   extern virtual function void compare_data(bit [31:0] exp_data, bit [31:0] act_data);
   extern virtual task compare_rawtx_serrx();

endclass: cdn_u4_dp_scoreboard


function cdn_u4_dp_scoreboard::new(string name = "cdn_u4_dp_scoreboard",
                 uvm_component parent);
   super.new(name,parent);
endfunction: new

function void cdn_u4_dp_scoreboard::build_phase(uvm_phase phase);
    super.build_phase(phase);
    //before_export = new("before_export", this);
    //after_export  = new("after_export", this);
    //comparator    = new("comparator", this);
    mon_raw_txdata_imp = new("mon_raw_txdata_imp", this);
    mon_ser_rxdata_imp = new("mon_ser_rxdata_imp", this);
endfunction:build_phase

function void cdn_u4_dp_scoreboard::connect_phase(uvm_phase phase);
    //before_export.connect(comparator.before_export);
    //after_export.connect(comparator.after_export);
endfunction:connect_phase

task cdn_u4_dp_scoreboard::main_phase(uvm_phase phase);
    super.main_phase(phase);
    //phase.raise_objection(this,"scbd..");
	//comparator.run();
    //phase.drop_objection(this);
   if(compare_en == 1) begin
     compare_rawtx_serrx();
   end
endtask: main_phase 

function void cdn_u4_dp_scoreboard::report_phase(uvm_phase phase);
    super.report_phase(phase);
    //`uvm_info("SBRPT", $psprintf("Matches = %0d, Mismatches = %0d",
    //           comparator.m_matches, comparator.m_mismatches),
    //           UVM_MEDIUM);
   if(compare_en == 1) begin
     if(scb_raw_txdata_q.size() > 0) begin
       `uvm_error(get_full_name(), $sformatf("scb_raw_txdata_q.size: %0d , is not empty when simulation finish", scb_raw_txdata_q.size()))
       foreach(scb_raw_txdata_q[i]) begin
         `uvm_info(get_full_name(), $sformatf("scb_raw_txdata_q[%0d] : %0x", i, scb_raw_txdata_q[i]), UVM_HIGH)
       end
     end
     if(scb_ser_rxdata_q.size() > 0) begin
       `uvm_error(get_full_name(), $sformatf("scb_ser_rxdata_q.size: %0d , is not empty when simulation finish", scb_ser_rxdata_q.size()))
       foreach(scb_ser_rxdata_q[i]) begin
         `uvm_info(get_full_name(), $sformatf("scb_ser_rxdata_q[%0d] : %0x", i, scb_ser_rxdata_q[i]), UVM_HIGH)
       end
     end
     if(match_begin == 0) begin
       `uvm_error(get_full_name(), $sformatf("match_begin is 0, it does not started comparing yet"))
     end
   end
endfunction:report_phase


function void cdn_u4_dp_scoreboard::write_raw_txdata(bit [31:0] raw_txdata);
   `uvm_info(get_full_name(), $sformatf("Get one raw side 32 bit txdata from monitor : %0x", raw_txdata), UVM_LOW) // TODO compare
   scb_raw_txdata_q.push_back(raw_txdata);
endfunction

function void cdn_u4_dp_scoreboard::write_ser_rxdata(bit [31:0] ser_rxdata);
   `uvm_info(get_full_name(), $sformatf("Get one serial side 32 bit rxdata from monitor : %0x", ser_rxdata), UVM_LOW) // TODO compare
   scb_ser_rxdata_q.push_back(ser_rxdata);
endfunction

function void cdn_u4_dp_scoreboard::compare_data(bit [31:0] exp_data, bit [31:0] act_data);
   if(exp_data == act_data) begin
     `uvm_info(get_full_name(), $sformatf("exp_data %0x and act_data %0x match", exp_data, act_data), UVM_LOW)
   end else begin
     `uvm_error(get_full_name(), $sformatf("exp_data is %0x but act_data is %0x, mismatch!", exp_data, act_data))
   end
endfunction

task cdn_u4_dp_scoreboard::compare_rawtx_serrx();
   bit [31:0] exp_data;
   bit [31:0] act_data;

   forever begin
     //`uvm_info(get_full_name(), $sformatf("wait scb_raw_txdata_q.size(%0d)>0 and scb_ser_rxdata_q.size(%0d)>0", scb_raw_txdata_q.size(), scb_ser_rxdata_q.size()), UVM_LOW) // for debug
     wait(scb_raw_txdata_q.size() > 0 && scb_ser_rxdata_q.size() > 0) begin
       `uvm_info(get_full_name(), $sformatf("wait scb_raw_txdata_q.size(%0d)>0 and scb_ser_rxdata_q.size(%0d)>0", scb_raw_txdata_q.size(), scb_ser_rxdata_q.size()), UVM_LOW) // for debug
       if(match_begin == 1) begin
         exp_data = scb_raw_txdata_q.pop_front();    
         act_data = scb_ser_rxdata_q.pop_front();
         compare_data(exp_data, act_data);
       end else begin
         act_data = scb_ser_rxdata_q.pop_front();
         while(match_begin == 0) begin
           if(scb_raw_txdata_q.size() > 0) begin
             if(scb_raw_txdata_q.size() >= scb_ser_rxdata_q.size()) begin
               exp_data = scb_raw_txdata_q.pop_front();
               if(exp_data == act_data) begin
                 match_begin = 1;
                 `uvm_info(get_full_name(), $sformatf("raw_txdata and ser_rxdata matching begin: %0x", exp_data), UVM_LOW)
               end
             end else begin
               break;
               `uvm_error(get_full_name(), $sformatf("scb_raw_txdata_q.size %0d is less than scb_ser_rxdata_q.size %0d", scb_raw_txdata_q.size(), scb_ser_rxdata_q.size()))
             end
           end else begin
             break;
             `uvm_error(get_full_name(), $sformatf("scb_raw_txdata_q.size is %0d and data mismatch", scb_raw_txdata_q.size()))
           end
         end // while(match_begin == 0)
       end // if(match_begin == 1) else
     end // wait(...)
   end
endtask: compare_rawtx_serrx

`endif // CDN_U4_DP_SCOREBOARD__SV
