//
// Template for UVM-compliant configuration class
//

`ifndef CDN_PHY_CONFIG_BASE__SV
`define CDN_PHY_CONFIG_BASE__SV

class cdn_phy_config_base extends uvm_object; 

   // Define virtual interface base
   cdn_phy_vif_t    m_bfm;
   component_type_enum port_mode;

   // ToDo: Add other environment configuration varaibles

   // ToDo: Add constraint blocks to prevent error injection

   `uvm_object_utils_begin(cdn_phy_config_base)
      // ToDo: add properties using macros here
	  `uvm_field_enum(component_type_enum,port_mode, UVM_ALL_ON)
   `uvm_object_utils_end

   extern function new(string name = "");
  
endclass: cdn_phy_config_base

function cdn_phy_config_base::new(string name = "");
   super.new(name);
endfunction: new


`endif // CDN_PHY_CONFIG_BASE__SV
