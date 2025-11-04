//
// Template for UVM-compliant generic agent
//

`ifndef CDN_PHY_AGENT_BASE__SV
`define CDN_PHY_AGENT_BASE__SV


class cdn_phy_agent_base extends uvm_agent;

   //---------------------------------
   // Member configs
   //---------------------------------
   cdn_phy_tb_config           tb_cfg;
   cdn_phy_dut_config          dut_cfg;
   cdn_phy_dut_config          device_dut_cfg;

   //---------------------------------
   // Member virtual interface
   //---------------------------------
   cdn_phy_vif_t  pipe_agt_if[tb_param :: MAX_LANE_NUM]; 

   `uvm_component_utils_begin(cdn_phy_agent_base)
   //ToDo: add field utils macros here if required
   `uvm_component_utils_end

   //---------------------------------
   // UVM functions and tasks
   //---------------------------------
   extern function new(string name="cdn_phy_agent_base", uvm_component parent=null);
   extern virtual function void build_phase(uvm_phase phase);
   extern virtual function void connect_phase(uvm_phase phase);
   extern virtual task run_phase(uvm_phase phase);
   extern virtual function void report_phase(uvm_phase phase);

   //---------------------------------
   // User functions and tasks
   //---------------------------------
   extern virtual function void build_by_std();
   extern virtual function void connect_by_std();

endclass: cdn_phy_agent_base
 
function cdn_phy_agent_base::new(string name = "cdn_phy_agent_base", uvm_component parent = null);
   super.new(name, parent);
endfunction

function void cdn_phy_agent_base::build_phase(uvm_phase phase);
   super.build_phase(phase);
   // get configs
   if (!uvm_config_db#(cdn_phy_tb_config)::get(this, "", "tb_cfg", tb_cfg)) begin
     `uvm_fatal(get_type_name(), "tb_cfg not set")
   end
   if (!uvm_config_db#(cdn_phy_dut_config)::get(this, "", "dut_cfg", dut_cfg)) begin
     `uvm_fatal(get_type_name(), "dut_cfg not set")
   end
   if (!uvm_config_db#(cdn_phy_dut_config)::get(this, "", "device_dut_cfg", device_dut_cfg)) begin
     `uvm_fatal(get_type_name(), "device_dut_cfg not set")
   end
   build_by_std();
endfunction: build_phase

function void cdn_phy_agent_base::connect_phase(uvm_phase phase);
   super.connect_phase(phase);
   connect_by_std();
endfunction

task cdn_phy_agent_base::run_phase(uvm_phase phase);
   super.run_phase(phase);
   // phase.raise_objection(this,"slv_agt_run"); //Raise/drop objections in sequence file

   //ToDo :: Implement here

   // phase.drop_objection(this);
endtask

function void cdn_phy_agent_base::report_phase(uvm_phase phase);
   super.report_phase(phase);

   //ToDo :: Implement here

endfunction


function void cdn_phy_agent_base::build_by_std();
  if(tb_cfg.std_mode == USB4_MODE) begin
    for(int i = 0; i < tb_param::USB4_LANE_NUM; i++) begin //set interface
      if(!uvm_config_db#(cdn_phy_vif_t)::get(this, "", $psprintf("m_agt_if[%0d]",i),pipe_agt_if[i])) begin
        `uvm_fatal(get_full_name(), "No virtual interface specified for this agent instance")
      end
    end
  end else if(tb_cfg.std_mode == USB32_MODE) begin
    for(int i = 0; i < tb_param::USB32_LANE_NUM; i++) begin //set interface
      if(!uvm_config_db#(cdn_phy_vif_t)::get(this, "", $psprintf("m_agt_if[%0d]",i),pipe_agt_if[i])) begin
        `uvm_fatal(get_full_name(), "No virtual interface specified for this agent instance")
      end
    end
  end else if(tb_cfg.std_mode == DP_MODE) begin
    for(int i = 0; i < tb_param::DP_LANE_NUM; i++) begin //set interface
      if(!uvm_config_db#(cdn_phy_vif_t)::get(this, "", $psprintf("m_agt_if[%0d]",i),pipe_agt_if[i])) begin
        `uvm_fatal(get_full_name(), "No virtual interface specified for this agent instance")
      end
    end
  end else if(tb_cfg.std_mode == PCIE_MODE) begin
    for(int i = 0; i < tb_param::PCIE_LANE_NUM; i++) begin //set interface
      if(!uvm_config_db#(cdn_phy_vif_t)::get(this, "", $psprintf("m_agt_if[%0d]",i),pipe_agt_if[i])) begin
        `uvm_fatal(get_full_name(), "No virtual interface specified for this agent instance")
      end
    end
  end else if(tb_cfg.std_mode == ALT_MODE) begin
    if(dut_cfg.alt_mode == USB32_MODE) begin
      for(int i = 0; i < tb_param::USB32_LANE_NUM; i++) begin //set interface
        if(!uvm_config_db#(cdn_phy_vif_t)::get(this, "", $psprintf("usb32_if[%0d]",i),pipe_agt_if[i])) begin
          `uvm_fatal(get_full_name(), "No virtual interface specified for this agent instance")
        end
      end
    end else if(dut_cfg.alt_mode == DP_MODE) begin
      for(int i = 0; i < tb_param::DP_LANE_NUM; i++) begin //set interface
        if(!uvm_config_db#(cdn_phy_vif_t)::get(this, "", $psprintf("dp_if[%0d]",i),pipe_agt_if[i])) begin
          `uvm_fatal(get_full_name(), "No virtual interface specified for this agent instance")
        end
      end
    end else begin
      `uvm_fatal(get_full_name(), $sformatf("dut_cfg.alt_mode: %s is invalid for ALT_MODE", dut_cfg.alt_mode.name()))
    end
  end
endfunction: build_by_std

function void cdn_phy_agent_base::connect_by_std();
  //if(tb_cfg.std_mode.usb4_enable == 1) begin
  //  if(is_active == UVM_ACTIVE) begin
  //    for(int i = 0; i < tb_param::USB4_LANE_NUM; i++ ) begin
  //     // pipe_drv[i].seq_item_port.connect(pipe_sqr[i].seq_item_export);
  //    end
  //  end
  //end else if(tb_cfg.std_mode.usb32_enable == 1) begin
  //  if(is_active == UVM_ACTIVE) begin
  //    for(int i = 0; i < tb_param::USB32_LANE_NUM; i++ ) begin
  //     // pipe_drv[i].seq_item_port.connect(pipe_sqr[i].seq_item_export);
  //    end
  //  end
  //end else if(tb_cfg.std_mode.dp_enable == 1) begin
  //  if(is_active == UVM_ACTIVE) begin
  //    for(int i = 0; i < tb_param::DP_LANE_NUM; i++ ) begin
  //     // pipe_drv[i].seq_item_port.connect(pipe_sqr[i].seq_item_export);
  //    end
  //  end
  //end else if(tb_cfg.std_mode.pcie_enable == 1) begin
  //  if(is_active == UVM_ACTIVE) begin
  //    for(int i = 0; i < tb_param::PCIE_LANE_NUM; i++ ) begin
  //     // pipe_drv[i].seq_item_port.connect(pipe_sqr[i].seq_item_export);
  //    end
  //  end
  //end
endfunction: connect_by_std

`endif // CDN_PHY_AGENT_BASE__SV

