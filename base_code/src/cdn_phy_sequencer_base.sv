//
// Template for UVM-compliant sequencer class
//


`ifndef CDN_PHY_SEQUENCER_BASE__SV
`define CDN_PHY_SEQUENCER_BASE__SV


typedef class cdn_phy_transaction_base;

class cdn_phy_sequencer_base # (type T=cdn_phy_transaction_base) extends uvm_sequencer #(T);

   //---------------------------------
   // Member configs
   //---------------------------------
   cdn_phy_tb_config           tb_cfg;
   cdn_phy_dut_config          dut_cfg;
   cdn_phy_dut_config          device_dut_cfg;

   `uvm_component_param_utils(cdn_phy_sequencer_base#(T))

   //---------------------------------
   // UVM functions and tasks
   //---------------------------------
   extern function new(string name = "cdn_phy_sequencer_base", uvm_component parent); 
   extern virtual function void build_phase(uvm_phase phase);

endclass:cdn_phy_sequencer_base

function cdn_phy_sequencer_base::new(string name = "cdn_phy_sequencer_base", uvm_component parent);
   super.new(name, parent);
endfunction: new

function void cdn_phy_sequencer_base::build_phase(uvm_phase phase);
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

`endif // CDN_PHY_SEQUENCER_BASE__SV
