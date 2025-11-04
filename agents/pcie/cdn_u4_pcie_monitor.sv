//
// Template for UVM-compliant physical-level monitor
//

`ifndef cdn_u4_pcie_monitor__SV
`define cdn_u4_pcie_monitor__SV


class cdn_u4_pcie_monitor extends cdn_phy_monitor_base;

   //---------------------------------
   // Member config and interface
   //---------------------------------
   cdn_u4_pcie_config  m_cfg;
   cdn_phy_tb_config   tb_cfg;
   cdn_phy_dut_config            dut_cfg;
   cdn_phy_dut_config            device_dut_cfg;
   cdn_u4_pcie_port_status          port_status;
   cdn_u4_pcie_symbol_pattern       symbol_pattern_local;

   uvm_analysis_port #(cdn_u4_pcie_transaction) mon_serdes_analysis_port;  //TLM analysis port
   uvm_analysis_port #(cdn_u4_pcie_transaction) mon_pipe_analysis_port;  //TLM analysis port
   int rx_symbol_cnt;
   bit[15:0] cur_lfsr16 = 16'hFFFF;
   bit[15:0] nxt_lfsr16 = 16'hFFFF;
   bit[22:0] cur_lfsr23;
   bit[22:0] nxt_lfsr23;
   bit rxdata_bit_q[$];
   bit locked_rxdata_bit_q[$];
   int locked_symbol_cnt =1;
   longint sync_idx,sync_idx_q[$]; // for lock position
   int idx;
   bit sync_bit_q[$]; // for lock
   bit[8:0] symbol_q[$]; //bit[8] is k_code
   int skp_symbol_cnt;
   bit[7:0] received_os_q[$];
   bit received_k_q[$];
   ordered_set_enum os_type;
   bit os_done = 0;
   int skp_length;
   bit[1:0] block_head;
   extern function new(string name = "cdn_u4_pcie_monitor",uvm_component parent);
   `uvm_component_utils_begin(cdn_u4_pcie_monitor)
      // ToDo: Add uvm monitor member if any class property added later through field macros

   `uvm_component_utils_end
      // ToDo: Add required short hand override method


   extern virtual function void build_phase(uvm_phase phase);
   extern virtual function void connect_phase(uvm_phase phase);
   extern virtual task configure_phase(uvm_phase phase);
   extern virtual task run_phase(uvm_phase phase);
   extern virtual task sample_serial_rx_data();
   extern virtual task sample_pipe_data();
   extern virtual function void decode_8b10b();
   extern virtual function void decode_os(bit k_code, bit[7:0] rxdata_8b);
   extern virtual function void decode_os_block(bit[1:0] block_head, bit[7:0] data_8b);
   extern virtual function bit compare_os(bit[7:0] received_os_q[$], ordered_set_enum os_type);
   extern virtual function void decode_block();
   extern virtual function void symbol_lock();
   extern virtual function void block_align();
   extern virtual function void convert_pdata_to_bitstream(bit[`SERDES_WIDTH-1:0] serdes_rx_pdata);
   extern virtual function bit[7:0] descramble_lfsr16_rxdata(bit k_code, bit[7:0] rxdata_8b);
   //extern virtual function void decode_symbol();
   extern virtual function bit[7:0] descramble_lfsr23_rxdata(bit[7:0] data_8b);
   extern virtual function void sample_pipe_symbol();
   extern virtual function void sample_pipe_block();

endclass: cdn_u4_pcie_monitor


function cdn_u4_pcie_monitor::new(string name = "cdn_u4_pcie_monitor",uvm_component parent);
   super.new(name, parent);
   port_status = new();
   mon_serdes_analysis_port = new ("mon_serdes_analysis_port",this);
   mon_pipe_analysis_port = new ("mon_pipe_analysis_port",this);
endfunction: new

function void cdn_u4_pcie_monitor::build_phase(uvm_phase phase);
   super.build_phase(phase);
   symbol_pattern_local= new();
   if (!uvm_config_db#(cdn_u4_pcie_config)::get(this, "", "m_cfg", m_cfg)) begin
     `uvm_fatal(get_type_name(), "m_cfg not set")
   end
   if (!uvm_config_db#(cdn_phy_tb_config)::get(this,"","tb_cfg",tb_cfg)) begin 
	 `uvm_fatal("","monitor cannot get tb_cfg! please check.")
   end
   // dut cfg
   if (!uvm_config_db#(cdn_phy_dut_config)::get(this,"","dut_cfg",dut_cfg))
   `uvm_fatal("","monitor cannot get dut_cfg! please check.")
   if (!uvm_config_db#(cdn_phy_dut_config)::get(this,"","device_dut_cfg",device_dut_cfg))
   `uvm_fatal("","monitor cannot get device_dut_cfg! please check.")
endfunction: build_phase

function void cdn_u4_pcie_monitor::connect_phase(uvm_phase phase);
   super.connect_phase(phase);
endfunction: connect_phase

task cdn_u4_pcie_monitor::configure_phase(uvm_phase phase);
   super.configure_phase(phase);
   this.nxt_lfsr23 = m_cfg.lfsr23_initial;
   symbol_pattern_local.m_cfg = this.m_cfg;
endtask: configure_phase


task cdn_u4_pcie_monitor::run_phase(uvm_phase phase);
   super.run_phase(phase);
  // phase.raise_objection(this,""); //Raise/drop objections in sequence file
   fork
      //if (tb_cfg.b2b_dut == 0) begin 
	  //    if (m_cfg.port_mode != tb_cfg.port_mode) begin // TODO tmp because of no DUT
	  //      sample_serial_rx_data();
	  //    end else begin 
	  //      sample_pipe_data();
	  //    end
	  //end else begin 
	  //  sample_pipe_data();
	  //end
      if (tb_cfg.b2b_dut == 0) begin
		sample_serial_rx_data();
	  end
	  else begin
		sample_pipe_data();
	  end
   join
  // phase.drop_objection(this);

endtask: run_phase

//////////////////sample_serial_rx_data BEGIN///////////////////////
task cdn_u4_pcie_monitor::sample_serial_rx_data();
  bit[`SERDES_WIDTH-1:0]  serdes_rx_pdata;
  bit k_code;
  bit[7:0] rxdata;

  wait(m_vif.serdes_rx.rx_pd_valid_out);
  forever begin
	  @(posedge m_vif.serdes_rx.rx_pd_clk_out);
	  m_vif.pcie_debug_intf.mon_set.serdes_rxdata_10b_valid = 4'h0;
	  serdes_rx_pdata = m_vif.serdes_rx.rx_pd_out;
	  convert_pdata_to_bitstream(serdes_rx_pdata);
	  // sync
	  if (!dut_cfg.pcie_gen_speed[1]) symbol_lock();
    else if (!m_vif.pcie_debug_intf.mon_set.lock_flag) block_align();
	  // decode
	  if (m_vif.pcie_debug_intf.mon_set.lock_flag == 1) begin 
      if (dut_cfg.pcie_gen_speed[1]) decode_block();
	    else 					                 decode_8b10b();
    end
  end
endtask
//////////////////sample_serial_rx_data END///////////////////////
 
//////////////////convert_pdata_to_bitstream BEGIN///////////////////////
function void cdn_u4_pcie_monitor::convert_pdata_to_bitstream(bit[`SERDES_WIDTH-1:0] serdes_rx_pdata);
  for(int i=0;i<`SERDES_WIDTH;i++) begin 
    if (m_vif.pcie_debug_intf.mon_set.lock_flag == 0) begin 
	  rxdata_bit_q.push_back(serdes_rx_pdata[i]);
	end
    else begin  // locked
	  locked_rxdata_bit_q.push_back(serdes_rx_pdata[i]);
	  if(!dut_cfg.pcie_gen_speed[1]) rxdata_bit_q.push_back(serdes_rx_pdata[i]); //GEN1/GEN2 keep checking COM lock
	end
  end  
endfunction
//////////////////convert_pdata_to_bitstream END///////////////////////

/////////////////sample_pipe_data BEGIN//////////////////////////
task cdn_u4_pcie_monitor::sample_pipe_data();
  //wait(m_vif.pipe_intf.RxValid);
  forever begin 
    @(posedge m_vif.pclk) 
    if (m_vif.pipe_intf.RxValid) begin 
	  if (!dut_cfg.pcie_gen_speed[1]) sample_pipe_symbol();
      else  				                sample_pipe_block();
	end
  end
endtask
/////////////////sample_pipe_data END//////////////////////////

//////////////////sample_pipe_symbol BEGIN///////////////////////
function void cdn_u4_pcie_monitor::sample_pipe_symbol();
  cdn_u4_pcie_transaction  trans;
  bit k_code;
  bit[7:0] rxdata;
  bit[7:0] rxdata_desc;
  bit[1:0] symbol_cnt;

  for(int i=0;i<tb_param::PD_WIDTH/8;i++) begin
    k_code = m_vif.pipe_intf.RxDataK[i];
    rxdata = m_vif.pipe_intf.RxData[8*i+:8];
	decode_os(k_code,rxdata);
	if (os_done) begin 
	  trans = new();
	  trans.datak_a = new[received_k_q.size];
	  for(int i=0;i<received_k_q.size;i++) trans.datak_a[i] = received_k_q[i];
	  trans.block_data = new[received_os_q.size];
	  for(int i=0;i<received_os_q.size;i++) trans.block_data[i] = received_os_q[i];
	  if (os_type == PCIE_LINK::SKPOS) trans.skp = 1;
	  // write trans to scoreboard
      mon_pipe_analysis_port.write(trans); 
      `uvm_info("",$sformatf("now sample pipe rx datak=%p,rxdata=%p and send to scoreboard",trans.datak_a,trans.block_data),UVM_LOW);
	  os_done = 0;
	  received_k_q.delete();
	  received_os_q.delete();
	  if (os_type == PCIE_LINK::SKPOS && (m_cfg.port_mode != tb_cfg.port_mode || tb_cfg.b2b_dut == 1)) decode_os(k_code,rxdata);
	end
    // descramble
	cur_lfsr16 = nxt_lfsr16;
    m_vif.pcie_debug_intf.mon_set.lfsr16[16*i+:16] = cur_lfsr16;
    rxdata_desc = descramble_lfsr16_rxdata(k_code,rxdata);
    m_vif.pcie_debug_intf.mon_set.pipe_rxdata_des[symbol_cnt*8+:8] = rxdata_desc;		  
    symbol_cnt++;
  end
endfunction
//////////////////sample_pipe_symbol END///////////////////////

//////////////////sample_pipe_block BEGIN///////////////////////
function void cdn_u4_pcie_monitor::sample_pipe_block();
  cdn_u4_pcie_transaction  trans;
  bit[7:0] data_8b;
  bit[7:0] block_data[];
  bit[7:0] rxdata_desc;
  string print_s;

  if (m_vif.pipe_intf.RxDataValid) begin 
    if (m_vif.pipe_intf.RxStartBlock) begin 
	  if (received_os_q.size > 0) `uvm_error("",$sformatf("detect a new block start before last block finish"))
	  block_head = m_vif.pipe_intf.RxSyncHeader;
	end
	else if (received_os_q.size == 0) `uvm_error("","after last block finish, no new block start happen")
	for(int i=0;i<tb_param::PD_WIDTH/8;i++) begin 
	  data_8b = m_vif.pipe_intf.RxData[i*8+:8];
      decode_os_block(block_head,data_8b);
	  // descramble
	  cur_lfsr23 = nxt_lfsr23;
	  m_vif.pcie_debug_intf.mon_set.lfsr23[23*i+:23] = cur_lfsr23;
      rxdata_desc = descramble_lfsr23_rxdata(data_8b);
      m_vif.pcie_debug_intf.mon_set.serdes_rx_block_des[i*8+:8] = rxdata_desc;
	end
    // for compare in unit of block
    if (os_done) begin
      block_data = new[received_os_q.size]; 
      for(int i=0;i<block_data.size;i++) begin 
        block_data[i] = received_os_q[i];
        print_s = {print_s, $sformatf("'h%2h ",block_data[i])};
      end
	  os_done = 0;
      `uvm_info("",$sformatf("block_head =%2b, block_data before descramble is %0s",block_head,print_s),UVM_LOW);
      trans = new();
      trans.block_head = block_head;
      trans.block_data = block_data;
	  if (os_type == PCIE_LINK::SKPOS) trans.skp = 1;
      mon_pipe_analysis_port.write(trans);
    end
  end
endfunction
//////////////////sample_pipe_block END///////////////////////

//////////////////decode_8b10b BEGIN///////////////////////
function void cdn_u4_pcie_monitor::decode_8b10b();
  bit[9:0] rxdata_10b;
  bit[7:0] rxdata_8b;
  bit[7:0] rxdata_desc;
  bit k_code;
  cdn_u4_pcie_transaction  trans;
  bit[1:0] symbol_cnt;
  bit os_flag;

  while(locked_rxdata_bit_q.size >= 10) begin
    // get 10b data
    for(int i=0;i<10;i++) begin
      rxdata_10b >>=1;
      rxdata_10b[9] = locked_rxdata_bit_q.pop_front();
    end
    `uvm_info("",$sformatf("rxdata before decode_10b8b is %10b",rxdata_10b),UVM_HIGH);
	// for debug in waveform
	m_vif.pcie_debug_intf.mon_set.serdes_rxdata_10b_valid[symbol_cnt] = 1;
    m_vif.pcie_debug_intf.mon_set.serdes_rxdata_10b[symbol_cnt*10+:10] = rxdata_10b;
    // do 10b->8b decode
    {k_code,rxdata_8b} = datatrans_10b8b(rxdata_10b);
	// for debug in waveform
	m_vif.pcie_debug_intf.mon_set.serdes_rx_kcode[symbol_cnt] = k_code;
    m_vif.pcie_debug_intf.mon_set.serdes_rxdata_8b[symbol_cnt*8+:8] = rxdata_8b;
	// decode OS (not scrambled)
	decode_os(k_code,rxdata_8b);
	if (os_done) begin 
	  trans = new();
	  trans.datak_a = new[received_k_q.size];
	  for(int i=0;i<received_k_q.size;i++) trans.datak_a[i] = received_k_q[i];
	  trans.block_data = new[received_os_q.size];
	  for(int i=0;i<received_os_q.size;i++) trans.block_data[i] = received_os_q[i];
	  if (os_type == PCIE_LINK::SKPOS) trans.skp = 1;
	  // write trans to scoreboard
      mon_serdes_analysis_port.write(trans); 
      `uvm_info("",$sformatf("now sample serdes rx datak=%p,rxdata=%p and send to scoreboard",trans.datak_a,trans.block_data),UVM_LOW);
	  os_done = 0;
	  received_k_q.delete();
	  received_os_q.delete();
	  if (os_type == PCIE_LINK::SKPOS && m_cfg.port_mode == tb_cfg.port_mode && tb_cfg.b2b_dut == 0) decode_os(k_code,rxdata_8b);
	end
    // descramble
	cur_lfsr16 = nxt_lfsr16;
    m_vif.pcie_debug_intf.mon_set.lfsr16[16*symbol_cnt+:16] = cur_lfsr16;
    rxdata_desc = descramble_lfsr16_rxdata(k_code,rxdata_8b);
    m_vif.pcie_debug_intf.mon_set.serdes_rxdata_des[symbol_cnt*8+:8] = rxdata_desc;
	symbol_cnt++;
  end
endfunction
//////////////////decode_8b10b END///////////////////////

//////////////////decode_os BEGIN///////////////////////
function void cdn_u4_pcie_monitor::decode_os(bit k_code, bit[7:0] rxdata_8b);
  // decode os type
  received_os_q.push_back(rxdata_8b);
  received_k_q.push_back(k_code);
  if (received_os_q.size == 1) begin  //start
	if (k_code == 0 || rxdata_8b != COM_K) begin 
	  os_type = PCIE_LINK::NULL;
	end
  end else begin
    if (received_k_q[0] == 1'b1 && received_os_q[0] == COM_K && received_os_q.size == 2) begin 
  	  if (k_code == 1) begin 
          case(rxdata_8b) 
      	  IDL_K: begin os_type = PCIE_LINK::EIOS;  m_vif.pcie_debug_intf.eios_received_cnt ++; end
      	  FTS_K: begin os_type = PCIE_LINK::FTSOS; m_vif.pcie_debug_intf.fts_received_cnt ++; end
      	  SKP_K: begin os_type = PCIE_LINK::SKPOS; m_vif.pcie_debug_intf.skp_received_cnt ++; end
      	  EIE_K: begin os_type = PCIE_LINK::EIEOS; m_vif.pcie_debug_intf.eieos_received_cnt ++; end
  	      PAD_K: os_type = PCIE_LINK::TSOS;
          endcase
  	  end else os_type = PCIE_LINK::TSOS;
    end
    case(os_type)
	  PCIE_LINK::NULL:
	    if (received_os_q.size >= 4) os_done = 1;
      PCIE_LINK::EIOS: 
    	if (received_os_q.size >= $size(symbol_pattern_local.EI_OS_GEN12)) begin 
          if (!compare_os(received_os_q,os_type)) `uvm_error("",$sformatf("decode EIOS ordered set wrong! is 32'h%h",{>>{received_os_q[0:$]}}))
		  os_done = 1;
      end
      PCIE_LINK::FTSOS: 
    	if (received_os_q.size >= $size(symbol_pattern_local.FTS_OS_GEN12)) begin
          if (!compare_os(received_os_q,os_type)) `uvm_error("",$sformatf("decode FTSOS ordered set wrong! is 32'h%h",{>>{received_os_q[0:$]}}))
		  os_done = 1;
      end
      PCIE_LINK::SKPOS:
		if (m_cfg.port_mode != tb_cfg.port_mode || tb_cfg.b2b_dut == 1) begin
          if (received_os_q.size >= $size(symbol_pattern_local.SKP_OS_GEN12)) begin
            if (!compare_os(received_os_q,os_type)) `uvm_error("",$sformatf("decode SKPOS ordered set wrong! is 32'h%h",{>>{received_os_q[0:$]}}))
		    os_done = 1;
          end
		end else begin 
		  if (k_code != 1 || rxdata_8b != SKP_K) begin 
			received_os_q.pop_front();
			received_k_q.pop_front();
		    if (!(received_os_q.size inside {2,3,4,5,6})) `uvm_error("",$sformatf("SKPOS symbol num is %0d! should be inside [2:6]",received_os_q.size))
			os_done = 1;
			//received_os_q.delete();
		  end
	    end
      PCIE_LINK::EIEOS:
    	if (received_os_q.size >= $size(symbol_pattern_local.EIE_OS_GEN2)) begin 
          if (!compare_os(received_os_q,os_type)) `uvm_error("",$sformatf("decode EIEOS ordered set wrong! is 128'h%h",{>>{received_os_q[0:$]}}))
		  os_done = 1;
      end
      PCIE_LINK::TSOS:
      if (received_os_q.size >= 16) begin
        if (received_os_q[7] == TS1_ID) begin 
          m_vif.pcie_debug_intf.ts1_received_count ++;
          for(int i=8;i<received_os_q.size;i++) if (received_os_q[i] != TS1_ID) `uvm_error("",$sformatf("decode TS1OS ordered set wrong! is 8'h%h",received_os_q[i]))
        end
        else if (received_os_q[7] == TS2_ID) begin 
          m_vif.pcie_debug_intf.ts2_received_count ++;
          for(int i=8;i<received_os_q.size;i++) if (received_os_q[i] != TS2_ID) `uvm_error("",$sformatf("decode TS2OS ordered set wrong! is 8'h%h",received_os_q[i]))
        end
        else `uvm_error("",$sformatf("decode TSOS ordered set ID wrong! is 8'h%h, should be 8'h4A(TS1) or 8'h45(TS2)",received_os_q[7]))
		os_done = 1;
      end
      default:;
    endcase
  end
endfunction
//////////////////decode_os END///////////////////////

//////////////////compare_os BEGIN///////////////////////
function bit cdn_u4_pcie_monitor::compare_os(bit[7:0] received_os_q[$], ordered_set_enum os_type);
  if (dut_cfg.pcie_gen_speed[1]) begin 
    case(os_type)
      PCIE_LINK::EIOS:
        for(int i=0;i<received_os_q.size;i++) if (received_os_q[i] != symbol_pattern_local.EI_OS_GEN34[i]) return 0;
      PCIE_LINK::FTSOS:
        for(int i=0;i<received_os_q.size;i++) if (received_os_q[i] != symbol_pattern_local.FTS_OS_GEN34[i]) return 0;
      PCIE_LINK::EIEOS:
        for(int i=0;i<received_os_q.size;i++) if (received_os_q[i] != (dut_cfg.pcie_gen_speed[0] ? symbol_pattern_local.EIE_OS_GEN4[i] : symbol_pattern_local.EIE_OS_GEN3[i])) return 0;
    endcase
    return 1;
  end else begin
    case(os_type)
      PCIE_LINK::EIOS:
        for(int i=0;i<received_os_q.size;i++) if (received_os_q[i] != symbol_pattern_local.EI_OS_GEN12[i]) return 0;
      PCIE_LINK::SKPOS:
        for(int i=0;i<received_os_q.size;i++) if (received_os_q[i] != symbol_pattern_local.SKP_OS_GEN12[i]) return 0;
      PCIE_LINK::FTSOS:
        for(int i=0;i<received_os_q.size;i++) if (received_os_q[i] != symbol_pattern_local.FTS_OS_GEN12[i]) return 0;
      PCIE_LINK::EIEOS:
        for(int i=0;i<received_os_q.size;i++) if (received_os_q[i] != symbol_pattern_local.EIE_OS_GEN2[i]) return 0;
    endcase
    return 1;
  end
endfunction
//////////////////compare_os END///////////////////////


//////////////////decode_block BEGIN///////////////////////
function void cdn_u4_pcie_monitor::decode_block();
  bit[7:0] block_data[];
  bit[7:0] data_8b;
  bit[7:0] rxdata_desc;
  bit[1:0] symbol_cnt;
  cdn_u4_pcie_transaction  trans;
  string print_s;

  // print for debug 
  print_s = "";
  for(int i=0;i<locked_rxdata_bit_q.size;i++) begin 
    print_s = {print_s, $sformatf("%1b",locked_rxdata_bit_q[i])};
  end
  `uvm_info("",$sformatf("current cycle locked_rxdata_bit_q is %0s",print_s),UVM_LOW);
  m_vif.pcie_debug_intf.mon_set.serdes_rx_block_valid = 0;
  while(locked_rxdata_bit_q.size >= 8) begin
    if (received_os_q.size == 0) begin //start of block
	  if (locked_rxdata_bit_q.size < 10) return;
	  block_head = {<<{locked_rxdata_bit_q[0:1]}}; //locked_rxdata_bit_q[0:1]={10}
  	  `uvm_info("",$sformatf("current block head is %2b",block_head),UVM_LOW);
      repeat(2) locked_rxdata_bit_q.pop_front();
	  m_vif.pcie_debug_intf.mon_set.serdes_rx_block_head = block_head;
    end
	data_8b = {<<{locked_rxdata_bit_q[0:7]}}; //locked_rxdata_bit_q[0:7] <=> {LSB,...,MSB}
	repeat(8) locked_rxdata_bit_q.pop_front();
	// data before descramble
	m_vif.pcie_debug_intf.mon_set.serdes_rx_block_data[symbol_cnt*8+:8] = data_8b;
	m_vif.pcie_debug_intf.mon_set.serdes_rx_block_valid[symbol_cnt] = 1;
    decode_os_block(block_head,data_8b);
    if (m_vif.pcie_debug_intf.mon_set.lock_flag == 0) begin 
      locked_rxdata_bit_q.delete();
      os_done = 0;
      return; 
    end
	// descramble
	cur_lfsr23 = nxt_lfsr23;
	m_vif.pcie_debug_intf.mon_set.lfsr23[23*symbol_cnt+:23] = cur_lfsr23;
    rxdata_desc = descramble_lfsr23_rxdata(data_8b);
    m_vif.pcie_debug_intf.mon_set.serdes_rx_block_des[symbol_cnt*8+:8] = rxdata_desc;
	// for compare in unit of block
    if (os_done) begin
      block_data = new[received_os_q.size];
	  print_s = "";
      for(int i=0;i<block_data.size;i++) begin 
        block_data[i] = received_os_q[i];
        print_s = {print_s, $sformatf("'h%2h ",block_data[i])};
      end
      `uvm_info("",$sformatf("block_head =%2b, block_data before descramble is %0s",block_head,print_s),UVM_LOW);
      trans = new();
      trans.block_head = block_head;
      trans.block_data = block_data;
	  if (os_type == PCIE_LINK::SKPOS) trans.skp = 1;
      mon_serdes_analysis_port.write(trans);
	  received_os_q.delete();
	  os_done = 0;
    end
	symbol_cnt ++;
  end
endfunction
//////////////////decode_block END///////////////////////

//////////////////check_os_block BEGIN//////////////////
function void cdn_u4_pcie_monitor::decode_os_block(bit[1:0] block_head, bit[7:0] data_8b);

    if (received_os_q.size == 0) begin //start of block
	  if (block_head == 2'b01) begin // ordered set block 
	    if      (data_8b == SKP_START)	 begin os_type = PCIE_LINK::SKPOS; m_vif.pcie_debug_intf.skp_received_cnt ++; end
	    else if (data_8b == FTS_START) 	 begin os_type = PCIE_LINK::FTSOS; m_vif.pcie_debug_intf.fts_received_cnt ++; end
	    else if (data_8b == EIOS_START)  begin os_type = PCIE_LINK::EIOS;  m_vif.pcie_debug_intf.eios_received_cnt ++; end
	    else if (data_8b == EIEOS_START) begin os_type = PCIE_LINK::EIEOS; m_vif.pcie_debug_intf.eieos_received_cnt ++; end
	    else if (data_8b == TS1_START) 	 begin os_type = PCIE_LINK::TSOS;  m_vif.pcie_debug_intf.ts1_received_count ++; end
	    else if (data_8b == TS2_START) 	 begin os_type = PCIE_LINK::TSOS;  m_vif.pcie_debug_intf.ts2_received_count ++; end
	    else if (data_8b == SDS_START) 	 os_type = PCIE_LINK::SDSOS;
	    else `uvm_error("",$sformatf("decode illegal control block! data_8b = %h",data_8b))
	    received_os_q.push_back(data_8b);
	  end
	  else if (block_head == 2'b00) begin // data block
		os_type = PCIE_LINK::NULL;
	    received_os_q.push_back(data_8b);
	  end
	  else begin  //undefined sync header
		`uvm_info("",$sformatf("now block is unaligned!"),UVM_LOW);
	    m_vif.pcie_debug_intf.mon_set.lock_flag = 0;
	    sync_idx = 0;
	  end
    end
	else begin  // inside block
	  received_os_q.push_back(data_8b);
	  case(os_type) 
	    PCIE_LINK::SKPOS:
	    begin 
	  	if ((data_8b == STD_SKP_END || data_8b == CTL_SKP_END) && skp_length == 0) skp_length = received_os_q.size +3;
	    if (skp_length > 0 && received_os_q.size >= skp_length) begin 
	  	  for(int i=0;i<received_os_q.size-4;i++) if (received_os_q[i] != SKP_START) `uvm_error("",$sformatf("decode SKP value is %h, should be %0h",received_os_q[i],SKP_START))
	  	  os_done = 1;
	  	  // check skp symbol length
	  	  if (m_cfg.port_mode == tb_cfg.port_mode && tb_cfg.b2b_dut == 0) begin
	  	    if (!(skp_length inside {8,12,16,20,24})) `uvm_error("",$sformatf("monitor detect SKP symbol num error! skp symbol num is %0d",skp_length));
	  	  end else begin 
	  	    if (skp_length != 16) `uvm_error("",$sformatf("monitor detect SKP symbol num error! skp symbol num is %0d",skp_length));
	  	  end
		  skp_length = 0;
	  	end
		end
	    PCIE_LINK::FTSOS:
	  	if (received_os_q.size >= $size(symbol_pattern_local.FTS_OS_GEN34)) begin 
	  	  if (!compare_os(received_os_q, os_type)) `uvm_error("",$sformatf("decode FTSOS ordered set wrong! is 128'h%h",{>>{received_os_q[0:$]}}))
	      os_done = 1;
	  	end
	    PCIE_LINK::EIOS:
	  	if (received_os_q.size >= $size(symbol_pattern_local.EI_OS_GEN34)) begin 
	  	  if (!compare_os(received_os_q, os_type)) `uvm_error("",$sformatf("decode EIOS ordered set wrong! is 128'h%h",{>>{received_os_q[0:$]}}))
	  	  os_done = 1;
	  	end
	    PCIE_LINK::EIEOS:
	  	if (received_os_q.size >= $size(symbol_pattern_local.EIE_OS_GEN3)) begin 
	  	  if (!compare_os(received_os_q, os_type)) `uvm_error("",$sformatf("decode EIOS ordered set wrong! is 128'h%h",{>>{received_os_q[0:$]}}))
	  	  os_done = 1;
	  	end
	    PCIE_LINK::TSOS, PCIE_LINK::NULL:
	  	if (received_os_q.size >= 16) os_done = 1;  //data or ts
	  	default:;
	  endcase
	end

endfunction
//////////////////check_os_block END//////////////////

/////////////////block_align BEGIN/////////////////////////////
function void cdn_u4_pcie_monitor::block_align();
  bit[1:0] sync_head;
  bit[127:0] sync_block;
  string s;

  while(rxdata_bit_q.size >0) begin 
	do begin sync_bit_q.push_back(rxdata_bit_q.pop_front()); idx ++; end
	while(sync_bit_q.size<130);
	sync_head = {<<{sync_bit_q[0:1]}}; // sync_bit_q[0:1]={10}
	sync_block = {>>{sync_bit_q[2:129]}};
	s = "";
	for(int i=0;i<sync_bit_q.size;i++) s = {s,$sformatf("%1b",sync_bit_q[i])};
	`uvm_info("",$sformatf("sync_bit[0:129]=%s",s),UVM_HIGH);
	`uvm_info("",$sformatf("sync_head=%2b,sync_block=%128b",sync_head,sync_block),UVM_HIGH);
	//pre_idx = sync_idx;
	if (sync_head == 2'b01) begin
	  if (symbol_pattern_local.compare_eieos(sync_block)) begin
		`uvm_info("",$sformatf("now sync with eieos"),UVM_LOW);
		if (m_cfg.port_mode != tb_cfg.port_mode && m_vif.pcie_debug_intf.mon_set.lock_flag == 0 && sync_idx_q.size > 0 && idx%130 != 0) sync_idx_q.delete();
		sync_idx += idx;
		sync_idx_q.push_back(sync_idx);
		m_vif.pcie_debug_intf.mon_set.sync_idx = sync_idx;
		idx = 0;
	  end
	  if (m_vif.pcie_debug_intf.mon_set.lock_flag == 0 && sync_idx_q.size >= m_cfg.sync_com_num) begin
		`uvm_info("",$sformatf("now block align!"),UVM_LOW);
		locked_rxdata_bit_q = rxdata_bit_q; //for decode
		rxdata_bit_q.delete();
		foreach(sync_idx_q[i]) `uvm_info("",$sformatf("sync_idx[%0d]=%0d",i,sync_idx_q[i]),UVM_LOW);
	    // for debug
	    m_vif.pcie_debug_intf.mon_set.lock_flag = 1;
		sync_idx_q.delete();
	    sync_bit_q.pop_front();
	    //m_vif.pcie_debug_intf.mon_set.sync_idx1 = sync_idx_q[0]; 
	    //m_vif.pcie_debug_intf.mon_set.sync_idx2 = sync_idx_q[1];
	    //m_vif.pcie_debug_intf.mon_set.sync_idx3 = sync_idx_q[2];
		break;
	  end
	end
	sync_bit_q.pop_front();
  end
endfunction
/////////////////block_align END/////////////////////////////

//////////////////symbol_lock BEGIN///////////////////////
function void cdn_u4_pcie_monitor::symbol_lock();
  bit[9:0] sync_10b;

	while(rxdata_bit_q.size > 0) begin
	  do begin sync_bit_q.push_back(rxdata_bit_q.pop_front()); idx ++; end 
	  while(sync_bit_q.size <10 && rxdata_bit_q.size >0);
	  if (sync_bit_q.size < 10) break;
	  sync_10b = {>>{sync_bit_q[0:9]}};  // MSB is little eidan
	  `uvm_info("",$sformatf("sync_10b=%10b",sync_10b),UVM_HIGH);
	  if (sync_10b == 10'b001111_1010 || sync_10b == 10'b110000_0101) begin //COM
	    //must be 16 symbol interval between 2 continous COM
		if (m_vif.pcie_debug_intf.mon_set.lock_flag == 0 && sync_idx_q.size > 0 && idx != 16*10) sync_idx_q.delete();
		else if (m_vif.pcie_debug_intf.mon_set.lock_flag == 1 && idx%10 != 0) sync_idx_q.delete();
		sync_idx += idx;
		sync_idx_q.push_back(sync_idx);
	    m_vif.pcie_debug_intf.mon_set.sync_idx = sync_idx;
		idx = 0;
		`uvm_info("",$sformatf("now detect new COM sync, idx=%0d",idx),UVM_HIGH);
	  end
	  sync_bit_q.pop_front();
	  if (m_vif.pcie_debug_intf.mon_set.lock_flag == 0 && sync_idx_q.size >= m_cfg.sync_com_num) begin
		`uvm_info("",$sformatf("now symbol lock!"),UVM_LOW);
		locked_rxdata_bit_q = rxdata_bit_q; //for decode
		`uvm_info("",$sformatf("once locked, locked_rxdata_bit_q=%b(MSB is the little)",{>>{locked_rxdata_bit_q[0:$]}}),UVM_LOW);
	 	decode_os(1'b1,COM_K);
		//foreach(sync_idx_q[i]) `uvm_info("",$sformatf("sync_idx[%0d]=%0d",i,sync_idx_q[i]),UVM_LOW);
	    // for debug
	    m_vif.pcie_debug_intf.mon_set.lock_flag = 1;
	    //m_vif.pcie_debug_intf.mon_set.sync_idx1 = sync_idx_q[0]; 
	    //m_vif.pcie_debug_intf.mon_set.sync_idx2 = sync_idx_q[1];
	    //m_vif.pcie_debug_intf.mon_set.sync_idx3 = sync_idx_q[2];
	  end
	  else if (m_vif.pcie_debug_intf.mon_set.lock_flag == 1 && sync_idx_q.size == 0) begin
		`uvm_info("",$sformatf("now symbol lost lock!"),UVM_LOW);
		m_vif.pcie_debug_intf.mon_set.lock_flag = 0;
		sync_idx = 0;
		locked_rxdata_bit_q.delete();
	  end
	end
endfunction
//////////////////symbol_lock END///////////////////////

//////////////////descramble_lfsr16_rxdata BEGIN///////////////////////
function bit[7:0] cdn_u4_pcie_monitor::descramble_lfsr16_rxdata(bit k_code, bit[7:0] rxdata_8b);
  bit 	   scramble_en;
  bit[7:0] rxdata_desc;

  if (os_type == PCIE_LINK::NULL) scramble_en = k_code ? 0 : 1;
  if ((rxdata_8b == 'hBC || rxdata_8b == 'h1C) && k_code == 1) begin // COM, SKP
    nxt_lfsr16 = 'hFFFF; // reset lfsr
    rxdata_desc = rxdata_8b;
  end 
  else begin
    rxdata_desc = scramble_lfsr16(rxdata_8b, cur_lfsr16, nxt_lfsr16, scramble_en);
  end
  if (scramble_en) `uvm_info("",$sformatf("rxdata after descramble is %0h",rxdata_desc),UVM_HIGH);
  if (k_code == 0 && rxdata_desc == 8'h0 && os_type == PCIE_LINK::NULL) m_vif.pcie_debug_intf.idle_packet_received_count ++;

  return rxdata_desc;
endfunction
//////////////////descramble_lfsr16_rxdata END///////////////////////

//////////////////descramble_lfsr23_rxdata BEGIN///////////////////////
function bit[7:0] cdn_u4_pcie_monitor::descramble_lfsr23_rxdata(bit[7:0] data_8b);
  bit 	   scramble_en;
  bit[7:0] rxdata_desc;

  if (os_type != PCIE_LINK::SKPOS) begin
    if (os_type == PCIE_LINK::EIEOS && received_os_q.size >= $size(symbol_pattern_local.EIE_OS_GEN3)) begin 
      nxt_lfsr23 = m_cfg.lfsr23_initial; // reset lfsr
    end
    else if (os_type == PCIE_LINK::TSOS) begin 
      if (received_os_q.size > 1) scramble_en = 1;
    end
    else if (os_type == PCIE_LINK::NULL) begin 
      scramble_en = 1;
    end
    rxdata_desc = scramble_lfsr23(data_8b, cur_lfsr23, nxt_lfsr23, scramble_en);
    if (scramble_en) `uvm_info("",$sformatf("rxdata after descramble is %0h",rxdata_desc),UVM_LOW);
    if (os_type == PCIE_LINK::NULL && rxdata_desc == 8'h0) m_vif.pcie_debug_intf.idle_packet_received_count ++;
  end
  else rxdata_desc = data_8b;

  return rxdata_desc;

endfunction
//////////////////descramble_lfsr23_rxdata END///////////////////////

////////////////////decode_symbol BEGIN///////////////////////
//function void cdn_u4_pcie_monitor::decode_symbol();
//  while(symbol_q.size > 0) begin 
//    if (symbol_q.pop_front == 9'h0) m_vif.pcie_debug_intf.idle_packet_received_count ++;
//  end
//endfunction
////////////////////decode_symbol END///////////////////////

`endif // cdn_u4_pcie_monitor__SV
