//
// Template for UVM-compliant physical-level transactor
//

`ifndef CDN_U4_PCIE_DRIVER__SV
`define CDN_U4_PCIE_DRIVER__SV

//typedef class cdn_u4_pcie_driver;

class cdn_u4_pcie_driver extends cdn_phy_driver_base;

   cdn_u4_pcie_symbol_pattern       symbol_pattern;
   cdn_u4_pcie_symbol_pattern       symbol_pattern_local;
   cdn_u4_pcie_physical_timer_cfg   timer_cfg;
   cdn_u4_pcie_config 				m_cfg;
   cdn_phy_tb_config 			    tb_cfg;
   cdn_phy_dut_config            dut_cfg;
   cdn_phy_dut_config            device_dut_cfg;
   //`uvm_register_cb(cdn_u4_pcie_driver,cdn_u4_pcie_driver_callbacks); 
	uvm_analysis_export #(cdn_u4_pcie_symbol_pattern)   cdn_u4_pcie_symbol_export_ep;
    uvm_tlm_analysis_fifo #(cdn_u4_pcie_symbol_pattern) cdn_u4_pcie_symbol_fifo; //imp
	uvm_analysis_export #(cdn_u4_pcie_transaction)   	cdn_u4_pcie_trans_port;

	bit[15:0] cur_lfsr16 = 16'hFFFF;
	bit[15:0] nxt_lfsr16 = 16'hFFFF;
	bit[22:0] cur_lfsr23;
	bit[22:0] nxt_lfsr23;
    bit 	  scramble_en;
	bit 	  skp_insert;
    bit[2:0]  skp_insert_num;
	bit[2:0] skp_start_byte_idx;
	bit[2:0] data_start_byte_idx;
	bit[4:0] skp_symbol_idx;
	bit 	 block_start;
	int 	 block_cnt;
	int 	 skp_block_cnt;
	int 	 symbol_time_cnt;
	skp_type_gen34_enum skp_type_e;
	bit 	 bit_buff[$];
	bit[1:0] state_ff;
    // for EIEOS transmit 
	int ts_transmit_cnt;
    bit pre_valid;
    bit[22:0] cur_lfsr_q[$]; // for both prbs16 and prbs23
	
   
   extern function new(string name = "cdn_u4_pcie_driver",
                       uvm_component parent = null); 
 
      `uvm_component_utils_begin(cdn_u4_pcie_driver)
      // ToDo: Add uvm driver member
      `uvm_component_utils_end
	  `uvm_register_cb(cdn_u4_pcie_driver, cdn_callback)
   // ToDo: Add required short hand override method


   extern virtual function void build_phase(uvm_phase phase);
   extern virtual function void connect_phase(uvm_phase phase);
   extern virtual task configure_phase(uvm_phase phase);
   extern virtual task run_phase(uvm_phase phase);
   extern protected virtual task get_symbol_pattern(); 
   extern protected virtual task drv_symbol_pattern();
   extern protected virtual task update_debug_itf();
   extern protected virtual task drv_rxdetect();
   extern protected virtual task drv_pattern();
   extern protected virtual task drv_data();
   extern protected virtual function void gen_symbol_pattern();
   extern protected virtual function void write2scb();
   extern protected virtual function void cal_skp_symbol_interval(int idx);
   extern protected virtual function void cal_skp_block_interval();
   extern protected virtual function void drv_skp_os();
   extern protected virtual function void drv_block();
   extern protected virtual function void drv_TxDataValid_TxStartBlock_TxSyncHeader();
   //extern protected virtual function void drv_TxStartBlock_TxSyncHeader();
   extern protected virtual function void drv_pd_data();
   extern protected virtual function void clear_block_cnt();
   extern virtual task reconfig_skp_insert_period();
   extern protected virtual function void reconfig_eieos_insert_interval();

endclass: cdn_u4_pcie_driver


function cdn_u4_pcie_driver::new(string name = "cdn_u4_pcie_driver",
                   uvm_component parent = null);
   super.new(name, parent);

   
endfunction: new


function void cdn_u4_pcie_driver::build_phase(uvm_phase phase);
   super.build_phase(phase);
	cdn_u4_pcie_symbol_export_ep = new("cdn_u4_pcie_symbol_export_ep", this);
	cdn_u4_pcie_symbol_fifo      = new("cdn_u4_pcie_symbol_fifo", this);
	cdn_u4_pcie_trans_port = new("cdn_u4_pcie_trans_port",this);
	symbol_pattern_local= new();
    timer_cfg = new("timer_cfg");
	// agent cfg
	if (!uvm_config_db#(cdn_u4_pcie_config)::get(this,"","m_cfg",m_cfg))
	 `uvm_fatal("","driver cannot get m_cfg! please check.")
	// tb cfg
    if (!uvm_config_db#(cdn_phy_tb_config)::get(this,"","tb_cfg",tb_cfg))
	 `uvm_fatal("","driver cannot get tb_cfg! please check.")
	// dut cfg
    if (!uvm_config_db#(cdn_phy_dut_config)::get(this,"","dut_cfg",dut_cfg))
	  `uvm_fatal("","driver cannot get dut_cfg! please check.")
    if (!uvm_config_db#(cdn_phy_dut_config)::get(this,"","device_dut_cfg",device_dut_cfg))
	  `uvm_fatal("","driver cannot get device_dut_cfg! please check.")

endfunction: build_phase

function void cdn_u4_pcie_driver::connect_phase(uvm_phase phase);
   super.connect_phase(phase);
   cdn_u4_pcie_symbol_export_ep.connect(cdn_u4_pcie_symbol_fifo.analysis_export);/*{{{*/

endfunction: connect_phase

task cdn_u4_pcie_driver::configure_phase(uvm_phase phase);
   super.configure_phase(phase);
    this.nxt_lfsr23 = m_cfg.lfsr23_initial;

endtask: configure_phase

task cdn_u4_pcie_driver::run_phase(uvm_phase phase);
   super.run_phase(phase);
   // phase.raise_objection(this,""); //Raise/drop objections in sequence file
   fork 
	  get_symbol_pattern();
      drv_symbol_pattern();
   join
   // phase.drop_objection(this);
endtask: run_phase

task cdn_u4_pcie_driver::get_symbol_pattern();
 forever begin
      cdn_u4_pcie_symbol_fifo.get(symbol_pattern);
	  `uvm_info(get_name(), $psprintf("get the symbol gen obj = %s", symbol_pattern_local.sprint()), UVM_LOW);
	  wait(symbol_pattern_local.data_q.size == 0 && !skp_insert);
	  $cast(symbol_pattern_local,symbol_pattern.clone());
	  symbol_pattern_local.m_cfg = this.m_cfg;
	  symbol_pattern_local.dut_cfg = this.dut_cfg;
	  symbol_pattern_local.tb_cfg = this.tb_cfg;
	  //clear_block_cnt();
	  update_debug_itf();
	  `uvm_info(get_name(), $psprintf("now update debug intf!"), UVM_LOW);
   end
endtask : get_symbol_pattern

task cdn_u4_pcie_driver::drv_symbol_pattern();
  forever begin
	@(posedge m_vif.pclk);
    if (symbol_pattern_local.rxdetect) begin
      //drv_rxdetect();
    end
    else if (symbol_pattern_local.ts1 || symbol_pattern_local.ts2 || symbol_pattern_local.data_en) begin
      drv_pattern();
    end
  end
endtask : drv_symbol_pattern

task cdn_u4_pcie_driver::drv_rxdetect();
	while(1) begin
	  @(posedge m_vif.pclk);
	  if (m_vif.pipe_intf.TxDetectRx === 1'b0 && m_vif.pipe_intf.PhyStatus === 1'b0) begin
	  	m_vif.pipe_intf.TxDetectRx = 1;
	  end 
	  else if (m_vif.pipe_intf.TxDetectRx === 1'b1 && m_vif.pipe_intf.PhyStatus === 1'b1) begin
	      m_vif.pipe_intf.TxDetectRx = 0;
		  break;
	  end
	  else if(m_vif.pipe_intf.TxDetectRx === 1'b0) begin
	  	`uvm_error(get_type_name(),"m_vif.pipe_intf.PhyStatus check fail!");
	  end
	end
endtask : drv_rxdetect

task cdn_u4_pcie_driver::drv_pattern();
	pattern_state_enum nxt_state = PATTERN;
	pattern_state_enum cur_state;
	bit same_clk;

	while(1) begin
	  if (!same_clk) @(posedge m_vif.pclk);
	  if (symbol_pattern_local.data_q.size == 0 && !skp_insert &&
		  !(symbol_pattern_local.ts1||symbol_pattern_local.ts2||symbol_pattern_local.data_en)) begin
		 break;
	  end
	  cur_state = nxt_state;
	  case(cur_state)
		PATTERN:
		  begin
			if (!dut_cfg.pcie_gen_speed[1]) drv_data();  // gen1/gen2
			else  					 		drv_block(); // gen3/gen4
			same_clk = 0;
			// skp transition
		    if (skp_insert) begin 
			  nxt_state = SKP;
			  if (skp_start_byte_idx == tb_param::PD_WIDTH/8) skp_start_byte_idx = 0;
			  else if (skp_start_byte_idx < tb_param::PD_WIDTH/8 && !dut_cfg.pcie_gen_speed[1]) same_clk = 1;
			end
		  end
		SKP:
		  begin
			drv_skp_os();
			same_clk = 0;
			if (!skp_insert) begin 
			  nxt_state = PATTERN;
			  if (data_start_byte_idx > 0) same_clk = 1;
			  // reconfig skp_insert_period 
			  reconfig_skp_insert_period();
			end
		  end
	  endcase
	end

endtask: drv_pattern

task cdn_u4_pcie_driver::drv_data();

	m_vif.pcie_debug_intf.driver_set.skp_insert = 0;

	for(int i=0;i<tb_param::PD_WIDTH/8;i++) begin
	  if (i >= data_start_byte_idx) begin
		#0; 	// for line117 "wait(symbol_pattern_local.data_q.size == 0 && !skp_insert);" triggered!!
	    // gen symbol and do scramble
	    gen_symbol_pattern();
		`uvm_info("",$sformatf("i=%0d, now symbol_pattern_local.data_q size is %0d",i,symbol_pattern_local.data_q.size),UVM_HIGH);
	    // drv datak
		m_vif.pipe_intf.TxDataK[i] = symbol_pattern_local.is_k_code.pop_front();
	    // drv data
		m_vif.pcie_debug_intf.driver_set.txdata_unsrc[8*i+:8] = symbol_pattern_local.data_q.pop_front();
	    m_vif.pcie_debug_intf.driver_set.lfsr16[16*i+:16] = cur_lfsr_q.pop_front(); //23 bit que only use 16bit
	    m_vif.pipe_intf.TxData[8*i+:8] = symbol_pattern_local.data_scr_q.pop_front();
	    // drv pd_data
	    m_vif.pcie_debug_intf.serdes_tx_valid = 1;
	    m_vif.pcie_debug_intf.pd_data[10*i+:10] = datatrans_8b10b(m_vif.pipe_intf.TxData[8*i+:8],m_vif.pcie_debug_intf.running_disparity,m_vif.pipe_intf.TxDataK[i],m_vif.pcie_debug_intf.running_disparity);
	    // calculate symbol cnt
		cal_skp_symbol_interval(i);
	    if (skp_insert) break;
	  end
	end
	data_start_byte_idx = 0;
	
endtask: drv_data

function void cdn_u4_pcie_driver::gen_symbol_pattern();

  if (symbol_pattern_local.data_q.size == 0) begin 
	// check scr que and lfsr que
    if (cur_lfsr_q.size > 0 || symbol_pattern_local.data_scr_q.size > 0) `uvm_error("",$sformatf("when symbol_pattern_local.data_q is empty, cur_lfsr_q or symbol_pattern_local.data_scr_q is not empty! cur_lfsr_q.size=%0d, symbol_pattern_local.data_scr_q.size=%0d",cur_lfsr_q.size, symbol_pattern_local.data_scr_q.size))
	// genenrate packet
    if (dut_cfg.pcie_gen_speed != GEN1_SPEED && (symbol_pattern_local.ts1 || symbol_pattern_local.ts2) && ts_transmit_cnt>=m_cfg.eieos_transmit_interval) begin   // eieos not exist in gen1
  	  symbol_pattern_local.gen_eieos(); 
      ts_transmit_cnt = 0; 
      m_vif.pcie_debug_intf.eieos_sent_count ++; 
	  // update eieos_insert_interval
	  reconfig_eieos_insert_interval();
    end
	else if (symbol_pattern_local.ts1) begin 
	  symbol_pattern_local.gen_ts1(); 
	  ts_transmit_cnt ++; 
	  m_vif.pcie_debug_intf.ts1_sent_count ++; 
	end
    else if (symbol_pattern_local.ts2) begin 
	  symbol_pattern_local.gen_ts2(); 
	  ts_transmit_cnt ++; 
	  m_vif.pcie_debug_intf.ts2_sent_count ++; 
	end
    else if (symbol_pattern_local.data_en) begin 
	  symbol_pattern_local.gen_data();
	  if (symbol_pattern_local.data_type == IDL) 
	    m_vif.pcie_debug_intf.idle_packet_sent_count +=4 ; // one byte is one idle packet
	end
	m_vif.pcie_debug_intf.driver_set.ts_transmit_cnt = ts_transmit_cnt;
    // callback
    `uvm_do_callbacks(cdn_u4_pcie_driver, cdn_callback, pre_symbol_pattern_process(symbol_pattern_local))
	// scramble 
	if (dut_cfg.pcie_gen_speed[1]) begin  // gen3/4
	  for (int i=0;i<symbol_pattern_local.data_q.size;i++) begin
	    cur_lfsr23 = nxt_lfsr23;
	    cur_lfsr_q.push_back(cur_lfsr23);
	    scramble_en = (((symbol_pattern_local.ts1||symbol_pattern_local.ts2)&&i==0) || symbol_pattern_local.fts || symbol_pattern_local.eieos) ? 0 : 1;
	    symbol_pattern_local.data_scr_q.push_back(scramble_lfsr23(symbol_pattern_local.data_q[i], cur_lfsr23, nxt_lfsr23, scramble_en));
	    // reset lfsr_23 after last symbol of EIEOS
	    if (symbol_pattern_local.eieos && i == symbol_pattern_local.data_q.size -1) nxt_lfsr23 = m_cfg.lfsr23_initial;
	  end
	end else begin  	// gen1/2
	  for (int i=0;i<symbol_pattern_local.data_q.size;i++) begin
	    cur_lfsr16 = nxt_lfsr16;
		cur_lfsr_q.push_back(cur_lfsr16);
	    scramble_en = (symbol_pattern_local.ts1 || symbol_pattern_local.ts2 || symbol_pattern_local.fts || symbol_pattern_local.eieos || symbol_pattern_local.is_k_code[i]) ? 0 : 1;
	    symbol_pattern_local.data_scr_q.push_back(scramble_lfsr16(symbol_pattern_local.data_q[i], cur_lfsr16, nxt_lfsr16, scramble_en));
		// reset lfsr when COM 
	    if (symbol_pattern_local.data_q[i] == 8'hBC && symbol_pattern_local.is_k_code[i] == 1) nxt_lfsr16 = 16'hFFFF;
	  end
	end
	// send to scorboard
	write2scb();
  end
endfunction

function void cdn_u4_pcie_driver::write2scb();
  cdn_u4_pcie_transaction trans;

  trans = new();
  if (dut_cfg.pcie_gen_speed[1]) begin //gen3/4
	if (symbol_pattern_local.data_en && !skp_insert) trans.block_head = 2'b00;
	else trans.block_head = 2'b01;
	if (skp_insert == 1 && symbol_pattern_local.skp_data_q.size > 0) begin
      trans.block_data = new[symbol_pattern_local.skp_data_q.size];
	  for(int i=0;i<trans.block_data.size;i++) trans.block_data[i] = symbol_pattern_local.skp_data_q[i];
	  trans.skp = 1;
	end else begin
      trans.block_data = new[symbol_pattern_local.data_q.size];
	  for(int i=0;i<trans.block_data.size;i++) trans.block_data[i] = symbol_pattern_local.data_scr_q[i];
	end
  end
  else begin  	//gen1/2
	if (skp_insert) begin 
	  trans.block_data = new[symbol_pattern_local.skp_data_q.size];
	  trans.datak_a = new[symbol_pattern_local.skp_data_q.size];
	  for(int i =0;i<trans.block_data.size;i++) begin 
		trans.datak_a[i] = 1'b1;
		trans.block_data[i] = symbol_pattern_local.skp_data_q[i];
	  end
	  trans.skp = 1;
	end
	else begin 
	  trans.datak_a = new[symbol_pattern_local.is_k_code.size];
	  trans.block_data = new[symbol_pattern_local.data_scr_q.size];
	  for(int i =0;i<trans.block_data.size;i++) begin 
		trans.datak_a[i] = symbol_pattern_local.is_k_code[i];
		trans.block_data[i] = symbol_pattern_local.data_scr_q[i];
	  end
	end
  end
  cdn_u4_pcie_trans_port.write(trans);	
endfunction

function void cdn_u4_pcie_driver::cal_skp_symbol_interval(int idx);
	symbol_time_cnt ++;
	m_vif.pcie_debug_intf.driver_set.symbol_time_cnt = symbol_time_cnt;
	if (symbol_pattern_local.data_q.size == 0 && symbol_time_cnt >= (symbol_pattern_local.data_en ? m_cfg.skp_insert_period_gen12_l0 : m_cfg.skp_insert_period_gen12_nonl0) && symbol_time_cnt %4 == 0) begin  
	  skp_insert = 1;
	  skp_start_byte_idx = idx+1; // if equal tb_param::PD_WIDTH/8, means skp start at first symbol of next cycle
	  skp_insert_num = symbol_pattern_local.data_en ? m_cfg.skp_insert_period_gen12_l0/1538+1 : 1;
	  //m_vif.pcie_debug_intf.driver_set.skp_start_byte_idx = skp_start_byte_idx;
	  `uvm_info("",$sformatf("it's time to insert skp, skp_start_byte_idx=%0d",skp_start_byte_idx),UVM_LOW);
	  skp_symbol_idx = 0;
	end
endfunction

function void cdn_u4_pcie_driver::cal_skp_block_interval();
	if (symbol_time_cnt%BLOCK_SYMBOL_NUM == 0) begin 
	  block_cnt ++;
	  skp_block_cnt ++;
	  symbol_time_cnt = 0;
	  //m_vif.pcie_debug_intf.driver_set.symbol_time_cnt = symbol_time_cnt;
	end
	m_vif.pcie_debug_intf.driver_set.block_cnt = block_cnt;
	m_vif.pcie_debug_intf.driver_set.skp_block_cnt = skp_block_cnt;
	if (skp_block_cnt%(symbol_pattern_local.data_en ? m_cfg.skp_insert_period_gen34_l0 : m_cfg.skp_insert_period_gen34_nonl0) == 0 && symbol_time_cnt == 0) begin
	  skp_insert = 1;
	  `uvm_info("",$sformatf("it's time to insert skp"),UVM_LOW);
	  skp_symbol_idx = 0;
	end
endfunction

function void cdn_u4_pcie_driver::drv_skp_os();
	m_vif.pcie_debug_intf.driver_set.skp_insert = 1;

	if (!dut_cfg.pcie_gen_speed[1]) begin
	  symbol_time_cnt = 0;
	  m_vif.pcie_debug_intf.driver_set.symbol_time_cnt = symbol_time_cnt;
	  m_vif.pcie_debug_intf.driver_set.skp_start_byte_idx = skp_start_byte_idx;
	  for(int i=0;i<tb_param::PD_WIDTH/8;i++) begin
	    if (i >= skp_start_byte_idx) begin
		  if (skp_symbol_idx == 0) begin 
			symbol_pattern_local.gen_skp(skp_insert_num);
		    // callback
		    `uvm_do_callbacks(cdn_u4_pcie_driver, cdn_callback, pre_symbol_pattern_process(symbol_pattern_local))
			// send to scorboard
			write2scb();
		  end
	      m_vif.pipe_intf.TxData[8*i+:8] = symbol_pattern_local.skp_data_q[skp_symbol_idx];
		  m_vif.pcie_debug_intf.driver_set.txdata_unsrc[8*i+:8] = symbol_pattern_local.skp_data_q[skp_symbol_idx];
	  	  m_vif.pipe_intf.TxDataK[i] = 1'b1;
		  m_vif.pcie_debug_intf.serdes_tx_valid = 1;
	      m_vif.pcie_debug_intf.pd_data[10*i+:10] = datatrans_8b10b(m_vif.pipe_intf.TxData[8*i+:8],m_vif.pcie_debug_intf.running_disparity,m_vif.pipe_intf.TxDataK[i],m_vif.pcie_debug_intf.running_disparity);
	  	  skp_symbol_idx ++;
		  nxt_lfsr16 = 16'hFFFF;
		  cur_lfsr16 = nxt_lfsr16;
	      m_vif.pcie_debug_intf.driver_set.lfsr16[16*i+:16] = cur_lfsr16; 
	      if (skp_symbol_idx >= symbol_pattern_local.skp_data_q.size) begin 
	        skp_insert = 0;
	        skp_symbol_idx = 0;
			if (i < tb_param::PD_WIDTH/8 -1) data_start_byte_idx = i+1;
			else 							 data_start_byte_idx = 0;
		    m_vif.pcie_debug_intf.driver_set.data_start_byte_idx = data_start_byte_idx;
		    m_vif.pcie_debug_intf.driver_set.skp_cnt ++;
		    `uvm_info("",$sformatf("skp insert done, go back to drive data, data_start_byte_idx=%0d",data_start_byte_idx),UVM_LOW);
	        break;
	      end
	    end
	  end
	  skp_start_byte_idx = 0;
	end 
	else begin
	  skp_block_cnt = 0;
	  m_vif.pcie_debug_intf.driver_set.skp_block_cnt = skp_block_cnt;
	  drv_TxDataValid_TxStartBlock_TxSyncHeader();
      if (m_vif.pipe_intf.TxDataValid) begin
	    if (skp_symbol_idx == 0) begin 
		  if (dut_cfg.pcie_gen_speed == GEN4_SPEED) skp_type_e = ~skp_type_e;
		  else 				   				 skp_type_e = STANDARD_SKP;
		  symbol_pattern_local.gen_skp();
		  // callback
		  `uvm_do_callbacks(cdn_u4_pcie_driver, cdn_callback, pre_symbol_pattern_process(symbol_pattern_local))
		  // send to scorboard
		  write2scb();
		end
	    for(int i=0;i<tb_param::PD_WIDTH/8;i++) begin
	      m_vif.pipe_intf.TxData[8*i+:8] = symbol_pattern_local.skp_data_q[skp_symbol_idx];
		  m_vif.pcie_debug_intf.driver_set.txdata_unsrc[8*i+:8] = symbol_pattern_local.skp_data_q[skp_symbol_idx];
	      skp_symbol_idx ++;
	    end
	    for (int i=0;i<tb_param::PD_WIDTH;i++) bit_buff.push_back(m_vif.pipe_intf.TxData[i]);
		// skp done
        if (skp_symbol_idx >= symbol_pattern_local.skp_data_q.size) begin
		  m_vif.pcie_debug_intf.driver_set.skp_cnt ++;
		  block_cnt ++;
		  m_vif.pcie_debug_intf.driver_set.block_cnt = block_cnt;
		  skp_insert = 0;
        end
	  end
	  drv_pd_data();
	end

endfunction

function void cdn_u4_pcie_driver::drv_block();

	m_vif.pcie_debug_intf.driver_set.skp_insert = 0;
	gen_symbol_pattern(); //genenrate packet and do scramble
    drv_TxDataValid_TxStartBlock_TxSyncHeader();
    if (m_vif.pipe_intf.TxDataValid) begin
      for(int i=0;i<tb_param::PD_WIDTH/8;i++) begin
		m_vif.pcie_debug_intf.driver_set.lfsr23[23*i+:23] = cur_lfsr_q.pop_front();
		m_vif.pcie_debug_intf.driver_set.txdata_unsrc[8*i+:8] = symbol_pattern_local.data_q.pop_front();
        m_vif.pipe_intf.TxData[8*i+:8] = symbol_pattern_local.data_scr_q.pop_front();
      end
      for (int i=0;i<tb_param::PD_WIDTH;i++) bit_buff.push_back(m_vif.pipe_intf.TxData[i]);
	  symbol_time_cnt +=tb_param::PD_WIDTH/8;  // TODO when change speed, need to reset symbol_time_cnt
	  m_vif.pcie_debug_intf.driver_set.symbol_time_cnt = symbol_time_cnt;
	  // calculate skp block interval
	  cal_skp_block_interval();
    end
    else begin
      m_vif.pipe_intf.TxData = $random();
    end
    drv_pd_data();
    
endfunction: drv_block

function void cdn_u4_pcie_driver :: drv_TxDataValid_TxStartBlock_TxSyncHeader(); // deassert for one cycle every 16 blocks
	int block_period = tb_param::PD_WIDTH/2;
	
	if (pre_valid == 1 && block_cnt%block_period==0 && (!skp_insert && symbol_time_cnt == 0 || skp_insert && skp_symbol_idx == 0) && block_cnt > 0) begin
	  m_vif.pipe_intf.TxDataValid = 1'b0;
	  // random block start and header
	  m_vif.pipe_intf.TxStartBlock = $urandom_range(0,1);
	  m_vif.pipe_intf.TxSyncHeader = $urandom_range(0,3); // 00,01,10,11
	end else begin
	  m_vif.pipe_intf.TxDataValid = 1'b1;
	  // block start
	  if (skp_insert && skp_symbol_idx == 0) begin 
		m_vif.pipe_intf.TxStartBlock = 1'b1;
	    m_vif.pipe_intf.TxSyncHeader = symbol_pattern_local.CTRL_BLOCK_HEADER;
		bit_buff.push_back(m_vif.pipe_intf.TxSyncHeader[0]);
	    bit_buff.push_back(m_vif.pipe_intf.TxSyncHeader[1]);
	  end
	  else if (!skp_insert && symbol_time_cnt == 0) begin 
		m_vif.pipe_intf.TxStartBlock = 1'b1;
	    if (symbol_pattern_local.data_en) m_vif.pipe_intf.TxSyncHeader = symbol_pattern_local.DATA_BLOCK_HEADER;
		else m_vif.pipe_intf.TxSyncHeader = symbol_pattern_local.CTRL_BLOCK_HEADER;
		bit_buff.push_back(m_vif.pipe_intf.TxSyncHeader[0]);
	    bit_buff.push_back(m_vif.pipe_intf.TxSyncHeader[1]);
	  end
	  else begin 
		m_vif.pipe_intf.TxStartBlock = 1'b0;
	    m_vif.pipe_intf.TxSyncHeader = $urandom_range(0,3); // 00,01,10,11
	  end
	end
	pre_valid = m_vif.pipe_intf.TxDataValid;
	
endfunction


function void cdn_u4_pcie_driver :: drv_pd_data(); 
	bit [7:0] pd_data;

	if (bit_buff.size < tb_param::PD_WIDTH) begin 
	  `uvm_warning("","bit_buff size is not enough to be driven on serial interface");
	  return;
	end

	for(int i=0;i<tb_param::PD_WIDTH/8;i++) begin
	  for(int j=0;j<8;j++) begin 
		pd_data >>= 1;
		pd_data[7] = bit_buff.pop_front(); 
	  end
	  m_vif.pcie_debug_intf.serdes_tx_valid = 1;
	  m_vif.pcie_debug_intf.pd_data[8*i+:8] = pd_data;
	end
	
endfunction

task cdn_u4_pcie_driver :: update_debug_itf();
	@(posedge m_vif.pclk);
	m_vif.pcie_debug_intf.driver_set.rxdetect 			= 				symbol_pattern_local.rxdetect;
	m_vif.pcie_debug_intf.driver_set.ts1 				= 				symbol_pattern_local.ts1;
	m_vif.pcie_debug_intf.driver_set.ts2 				= 				symbol_pattern_local.ts2;
	m_vif.pcie_debug_intf.driver_set.fts 				= 				symbol_pattern_local.fts;
	m_vif.pcie_debug_intf.driver_set.n_fts 				= 				symbol_pattern_local.n_fts;
	m_vif.pcie_debug_intf.driver_set.polarity_invert 	= 				symbol_pattern_local.polarity_invert;
	m_vif.pcie_debug_intf.driver_set.compliance 			= 				symbol_pattern_local.compliance;
	m_vif.pcie_debug_intf.driver_set.data_en 			= 				symbol_pattern_local.data_en;
	m_vif.pcie_debug_intf.driver_set.data_type 			= 				symbol_pattern_local.data_type;
	m_vif.pcie_debug_intf.driver_set.l0s 				= 				symbol_pattern_local.l0s;
	m_vif.pcie_debug_intf.driver_set.l1 					= 				symbol_pattern_local.l1;
	m_vif.pcie_debug_intf.driver_set.l1_exit 			= 				symbol_pattern_local.l1_exit;
	m_vif.pcie_debug_intf.driver_set.l2 					= 				symbol_pattern_local.l2;
	m_vif.pcie_debug_intf.driver_set.beacon 				= 				symbol_pattern_local.beacon;
	m_vif.pcie_debug_intf.driver_set.rate 				= 				symbol_pattern_local.rate;
	m_vif.pcie_debug_intf.driver_set.eq_en 				= 				symbol_pattern_local.eq_en;
	m_vif.pcie_debug_intf.driver_set.speed_change 		= 				symbol_pattern_local.speed_change;
	m_vif.pcie_debug_intf.driver_set.scramble_en		 	= 				symbol_pattern_local.scramble_en;
endtask

function void cdn_u4_pcie_driver :: clear_block_cnt();
	//if (symbol_pattern_local.ts1 || symbol_pattern_local.ts2) state_ff[0] = 0;
	//else if (symbol_pattern_local.data_en) state_ff[0] = 1;
	//if (|state_ff) block_cnt = 0;
	//state_ff <<=1;
endfunction

task cdn_u4_pcie_driver :: reconfig_skp_insert_period();
	m_cfg.randomize(skp_insert_period_gen12_nonl0);
	m_cfg.randomize(skp_insert_period_gen12_l0);
	m_cfg.randomize(skp_insert_period_gen34_nonl0);
	m_cfg.randomize(skp_insert_period_gen34_l0);
	m_vif.pcie_debug_intf.driver_set.skp_insert_period_gen12_nonl0  = m_cfg.skp_insert_period_gen12_nonl0;
	m_vif.pcie_debug_intf.driver_set.skp_insert_period_gen12_l0 	   = m_cfg.skp_insert_period_gen12_l0;
	m_vif.pcie_debug_intf.driver_set.skp_insert_period_gen34_nonl0  = m_cfg.skp_insert_period_gen34_nonl0;
	m_vif.pcie_debug_intf.driver_set.skp_insert_period_gen34_l0     = m_cfg.skp_insert_period_gen34_l0;
endtask

function void cdn_u4_pcie_driver::reconfig_eieos_insert_interval();
	m_cfg.randomize(eieos_transmit_interval);
	m_vif.pcie_debug_intf.driver_set.eieos_insert_period = m_cfg.eieos_transmit_interval;
endfunction

`endif // cdn_u4_pcie_driver__SV


