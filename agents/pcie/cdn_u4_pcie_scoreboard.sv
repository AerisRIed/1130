//
// Template for UVM-compliant physical-level monitor
//

`ifndef cdn_u4_pcie_scoreboard__SV
`define cdn_u4_pcie_scoreboard__SV

`uvm_analysis_imp_decl(_host_drv2scb)
`uvm_analysis_imp_decl(_device_drv2scb)
`uvm_analysis_imp_decl(_host_mon2scb_pipe)
`uvm_analysis_imp_decl(_device_mon2scb_pipe)
`uvm_analysis_imp_decl(_host_mon2scb_ser)
`uvm_analysis_imp_decl(_device_mon2scb_ser)

class cdn_u4_pcie_scoreboard extends cdn_phy_scoreboard_base;

   //---------------------------------
   // Member config and interface
   //---------------------------------
   cdn_u4_pcie_transaction  host_drv_exp_trans_q[$];
   cdn_u4_pcie_transaction  device_drv_exp_trans_q[$];
   cdn_u4_pcie_transaction  host_mon_pipe_trans_window[$];
   cdn_u4_pcie_transaction  device_mon_pipe_trans_window[$];
   cdn_u4_pcie_transaction  host_mon_ser_trans_window[$];
   cdn_u4_pcie_transaction  device_mon_ser_trans_window[$];
   bit device_match;
   bit host_match;
   `uvm_component_utils_begin(cdn_u4_pcie_scoreboard)
      // ToDo: Add uvm monitor member if any class property added later through field macros

   `uvm_component_utils_end

	uvm_analysis_imp_host_drv2scb #(cdn_u4_pcie_transaction, cdn_u4_pcie_scoreboard) host_drv_exp;
	uvm_analysis_imp_device_drv2scb #(cdn_u4_pcie_transaction, cdn_u4_pcie_scoreboard) device_drv_exp;
	uvm_analysis_imp_host_mon2scb_pipe #(cdn_u4_pcie_transaction, cdn_u4_pcie_scoreboard) host_mon_pipe;
	uvm_analysis_imp_device_mon2scb_pipe #(cdn_u4_pcie_transaction, cdn_u4_pcie_scoreboard) device_mon_pipe;
	uvm_analysis_imp_host_mon2scb_ser #(cdn_u4_pcie_transaction, cdn_u4_pcie_scoreboard) host_mon_ser;
	uvm_analysis_imp_device_mon2scb_ser #(cdn_u4_pcie_transaction, cdn_u4_pcie_scoreboard) device_mon_ser;
   extern function void write_host_drv2scb(cdn_u4_pcie_transaction trans);
   extern function void write_device_drv2scb(cdn_u4_pcie_transaction trans);
   extern function void write_host_mon2scb_pipe(cdn_u4_pcie_transaction trans);
   extern function void write_device_mon2scb_pipe(cdn_u4_pcie_transaction trans);
   extern function void write_host_mon2scb_ser(cdn_u4_pcie_transaction trans);
   extern function void write_device_mon2scb_ser(cdn_u4_pcie_transaction trans);

   extern function new (string name= "cdn_u4_pcie_scoreboard", uvm_component parent);
   extern virtual function void build_phase(uvm_phase phase);
   extern virtual function void connect_phase(uvm_phase phase);
   extern virtual task configure_phase(uvm_phase phase);
   extern virtual function void search_compare(ref cdn_u4_pcie_transaction window[$], ref cdn_u4_pcie_transaction exp_trans_q[$],ref bit match);
   extern virtual function void order_compare(cdn_u4_pcie_transaction act_trans, ref cdn_u4_pcie_transaction exp_trans_q[$]);
   extern virtual function bit compare_block_gen12(cdn_u4_pcie_transaction exp, cdn_u4_pcie_transaction act);
   extern virtual function bit compare_block_gen34(cdn_u4_pcie_transaction exp, cdn_u4_pcie_transaction act);

endclass: cdn_u4_pcie_scoreboard


function cdn_u4_pcie_scoreboard::new(string name = "cdn_u4_pcie_scoreboard",uvm_component parent);
   super.new(name, parent);
endfunction: new

function void cdn_u4_pcie_scoreboard::build_phase(uvm_phase phase);
   super.build_phase(phase);
	host_drv_exp = new("host_drv_exp",this);
	device_drv_exp = new("device_drv_exp",this);
	host_mon_pipe = new("host_mon_pipe",this);
	device_mon_pipe = new("device_mon_pipe",this);
	host_mon_ser = new("host_mon_ser",this);
	device_mon_ser = new("device_mon_ser",this);
endfunction: build_phase

function void cdn_u4_pcie_scoreboard::connect_phase(uvm_phase phase);
   super.connect_phase(phase);
endfunction: connect_phase

task cdn_u4_pcie_scoreboard::configure_phase(uvm_phase phase);
   super.configure_phase(phase);
endtask: configure_phase

function void cdn_u4_pcie_scoreboard::write_host_drv2scb(cdn_u4_pcie_transaction trans);
  if ((tb_cfg.b2b_dut == 1 || (tb_cfg.b2b_dut == 0 && tb_cfg.port_mode == DEVICE)) && trans.skp) trans.no_compare = 1;
  if (!trans.no_compare) host_drv_exp_trans_q.push_back(trans);
endfunction

function void cdn_u4_pcie_scoreboard::write_device_drv2scb(cdn_u4_pcie_transaction trans);
  if ((tb_cfg.b2b_dut == 1 || (tb_cfg.b2b_dut == 0 && tb_cfg.port_mode == HOST)) && trans.skp) trans.no_compare = 1;
  if (!trans.no_compare) device_drv_exp_trans_q.push_back(trans);
endfunction

function void cdn_u4_pcie_scoreboard::write_host_mon2scb_pipe(cdn_u4_pcie_transaction trans); // when DUT is single DEVICE, will not uesed
  if (tb_cfg.b2b_dut == 0 && trans.skp) trans.no_compare = 1; 
  if (!host_match) begin 
    if (!trans.no_compare) host_mon_pipe_trans_window.push_back(trans);
    if (host_mon_pipe_trans_window.size > 3) search_compare(host_mon_pipe_trans_window,device_drv_exp_trans_q,host_match); 
  end
  else if (!trans.no_compare) begin 
	 `uvm_info("","start to comapre host pipe rxdata(act) with device pipe txdata(exp)",UVM_LOW);
     order_compare(trans,device_drv_exp_trans_q);
  end
endfunction

function void cdn_u4_pcie_scoreboard::write_host_mon2scb_ser(cdn_u4_pcie_transaction trans);  // when DUT is single HOST or b2b, will not uesed
  if (tb_cfg.b2b_dut == 0 && trans.skp) trans.no_compare = 1;   //TODO only for debug because of no DUT
  if (!host_match) begin 
    if (!trans.no_compare) host_mon_ser_trans_window.push_back(trans);
    if (host_mon_ser_trans_window.size > 3) search_compare(host_mon_ser_trans_window,device_drv_exp_trans_q,host_match); 
  end
  else if (!trans.no_compare) begin  //TODO only for debug because of no DUT
	 `uvm_info("","start to comapre device tx serial data(act) with device pipe txdata(exp)",UVM_LOW);
     order_compare(trans,device_drv_exp_trans_q);
  end
endfunction

function void cdn_u4_pcie_scoreboard::write_device_mon2scb_pipe(cdn_u4_pcie_transaction trans); // when DUT is single HOST, will not uesed
  if (tb_cfg.b2b_dut == 0 && trans.skp) trans.no_compare = 1; 
  if (!device_match) begin 
    if (!trans.no_compare) device_mon_pipe_trans_window.push_back(trans);
    if (device_mon_pipe_trans_window.size > 3) search_compare(device_mon_pipe_trans_window,host_drv_exp_trans_q,device_match); 
  end
  else if (!trans.no_compare) begin 
	 `uvm_info("","start to comapre device pipe rxdata(act) with host pipe txdata(exp)",UVM_LOW);
     order_compare(trans,host_drv_exp_trans_q);
  end
endfunction

function void cdn_u4_pcie_scoreboard::write_device_mon2scb_ser(cdn_u4_pcie_transaction trans);  // when DUT is single DEVICE or b2b, will not uesed
  if (!device_match) begin 
    if (!trans.no_compare) device_mon_ser_trans_window.push_back(trans);
    if (device_mon_ser_trans_window.size > 3) search_compare(device_mon_ser_trans_window,host_drv_exp_trans_q,device_match); 
  end
  else begin 
	 `uvm_info("","start to comapre host tx serial data(act) with host pipe txdata(exp)",UVM_LOW);
     order_compare(trans,host_drv_exp_trans_q);
  end
endfunction

function void cdn_u4_pcie_scoreboard::search_compare(ref cdn_u4_pcie_transaction window[$], ref cdn_u4_pcie_transaction exp_trans_q[$],ref bit match);
  cdn_u4_pcie_transaction exp_trans;
  cdn_u4_pcie_transaction act_trans;
  int idx;

  if (exp_trans_q.size < window.size) `uvm_error("",$sformatf("start seatch compare, exp trans que size is less than window"))
  else begin 
	while(exp_trans_q.size >= window.size - idx) begin
      exp_trans = exp_trans_q.pop_front();
	  act_trans = window[idx];
      if (act_trans.datak_a.size > 0) begin  // gen1/2
		if (compare_block_gen12(exp_trans,act_trans)) begin 
		  idx ++;
		  `uvm_info("",$sformatf("when search compare, gen1 or gen2 trans compare ok. datak_a=%p, block_data=%p",exp_trans.datak_a,exp_trans.block_data),UVM_LOW);
	    end else begin 
		  idx = 0;
		  `uvm_info("",$sformatf("when search compare, gen1 or gen2 trans compare fail. exp :datak_a=%p, block_data=%p | act :datak_a=%p, block_data=%p",exp_trans.datak_a,exp_trans.block_data,act_trans.datak_a,act_trans.block_data),UVM_LOW);
	    end
	  end
      else begin  //gen3/4
		if (compare_block_gen34(exp_trans,act_trans)) begin 
		  idx ++;
		  `uvm_info("",$sformatf("when search compare, gen3 or gen4 trans compare ok. block_head=%2b, block_data=%p",exp_trans.block_head,exp_trans.block_data),UVM_LOW);
	    end else begin 
		  idx = 0;
		  `uvm_info("",$sformatf("when search compare, gen3 or gen4 trans compare fail. exp :block_head=%2b, block_data=%p | act :block_head=%2b, block_data=%p",exp_trans.block_head,exp_trans.block_data,act_trans.block_head,act_trans.block_data),UVM_LOW);
	    end
	  end
	  if (idx >= window.size) begin 
	    `uvm_info("","now search compare done! match=1",UVM_LOW);
		match = 1;
		window.delete();
		break;
	  end
	end 
	if (match == 0) `uvm_error("","search compare fail! exp and act trans cannot match. please check")
  end
endfunction

function void cdn_u4_pcie_scoreboard::order_compare(cdn_u4_pcie_transaction act_trans, ref cdn_u4_pcie_transaction exp_trans_q[$]);
  cdn_u4_pcie_transaction exp_trans;

  if (exp_trans_q.size == 0) `uvm_error("",$sformatf("exp trans que size is empty"))
  else begin 
    exp_trans = exp_trans_q.pop_front();
    if (act_trans.datak_a.size > 0) begin  // gen1/2
	  if (compare_block_gen12(exp_trans,act_trans)) begin 
	    `uvm_info("",$sformatf("when order compare, gen1 or gen2 trans compare ok. datak_a=%p, block_data=%p",exp_trans.datak_a,exp_trans.block_data),UVM_LOW);
	  end else begin 
	    `uvm_error("",$sformatf("when order compare, gen1 or gen2 trans compare fail! \nexp :datak_a=%p, block_data=%p\nact :datak_a=%p, block_data=%p",exp_trans.datak_a,exp_trans.block_data,act_trans.datak_a,act_trans.block_data));
	  end
	end
    else begin  //gen3/4
	  if (compare_block_gen34(exp_trans,act_trans)) begin 
	    `uvm_info("",$sformatf("when order compare, gen3 or gen4 trans compare ok. block_head=%2b, block_data=%p",exp_trans.block_head,exp_trans.block_data),UVM_LOW);
	  end else begin 
	    `uvm_error("",$sformatf("when order compare, gen3 or gen4 trans compare fail! \nexp :block_head=%2b, block_data=%p\nact :block_head=%2b, block_data=%p",exp_trans.block_head,exp_trans.block_data,act_trans.block_head,act_trans.block_data));
	  end
	end
  end
endfunction

function bit cdn_u4_pcie_scoreboard::compare_block_gen12(cdn_u4_pcie_transaction exp, cdn_u4_pcie_transaction act);
  if (exp.datak != act.datak || exp.block_data != act.block_data) begin 
	return 0;
  end
  return 1;
endfunction

function bit cdn_u4_pcie_scoreboard::compare_block_gen34(cdn_u4_pcie_transaction exp, cdn_u4_pcie_transaction act);
  if (exp.block_head != act.block_head) begin 
    return 0;
  end
  else if (exp.block_data != act.block_data) begin 
	return 0;
  end 
  return 1;
endfunction


`endif // cdn_u4_pcie_scoreboard__SV
