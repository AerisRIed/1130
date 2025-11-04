`ifndef CDN_PHY_VIRTUAL_SEQUENCER_BASE__SV
`define CDN_PHY_VIRTUAL_SEQUENCER_BASE__SV

typedef class cdn_usb_phy_top_regmodel;
class cdn_phy_virtual_sequencer_base extends uvm_sequencer;
   `uvm_component_utils(cdn_phy_virtual_sequencer_base)
     
   //---------------------------------
   // Member configs
   //---------------------------------
   cdn_phy_tb_config           tb_cfg;
   cdn_phy_dut_config          dut_cfg;
   cdn_phy_dut_config          device_dut_cfg;

   //-------------------------------------------
   // Place holder of all sequencer handles
   //-------------------------------------------

  // cdn_phy_sequencer_base   host_sequencer;
  // cdn_phy_sequencer_base   device_sequencer;

   // Member clk sequencer
   clk_sqr_t                m_clk_sqr;
    `ifndef DUT_BYPASS
   // ---------------- host ---------------- //
   cdn_jtag_sequencer           m_jtag_vsqr;
   cdn_jtag_1687_sequencer      m_1687_jtag_vsqr;
   cdn_usb_phy_top_regmodel     regmodel; 
   cdn_reset_sequencer 			m_reset_sqr[tb_param::MAX_LANE_NUM];
   
   // ---------------- device ---------------- //
   cdn_jtag_sequencer           m_device_jtag_vsqr;
   cdn_jtag_1687_sequencer      m_device_1687_jtag_vsqr;
   cdn_usb_phy_top_regmodel     device_regmodel; 
   cdn_reset_sequencer 			m_device_reset_sqr[tb_param::MAX_LANE_NUM];
   `endif 
   semaphore remap_access_sem;

   //---------------------------------
   // UVM functions and tasks
   //---------------------------------
   extern function new(string name, uvm_component parent);
   extern virtual function void build_phase(uvm_phase phase);

   //---------------------------------
   // User functions and tasks
   //---------------------------------
   extern virtual task sys_reset();

endclass

function cdn_phy_virtual_sequencer_base::new(string name, uvm_component parent);
   super.new(name, parent);
endfunction: new

function void cdn_phy_virtual_sequencer_base::build_phase(uvm_phase phase);
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
endfunction: build_phase


task cdn_phy_virtual_sequencer_base::sys_reset();
   // This is done in system reset as tasks using these may be nuked
   remap_access_sem = new(1);
  // TODO
  // void'(regmodel.reg_access_mbx.try_put(1));  // Although register model may not be reset, the task calling the regmodel task may be...
  // void'(regmodel.default_map.reset("NONE"));  // Dummy reset - restores all semaphores
endtask // sys_reset

`endif // CDN_PHY_VIRTUAL_SEQUENCER_BASE__SV
