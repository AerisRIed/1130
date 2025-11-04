//
// Template for UVM-compliant Monitor to Coverage Connector Callbacks
//

`ifndef CDN_PHY_MONITOR_BASE_2COV_CONNECT
`define CDN_PHY_MONITOR_BASE_2COV_CONNECT
class cdn_phy_monitor_base_2cov_connect extends uvm_component;
   cdn_phy_cov cov;
   uvm_analysis_export # (cdn_phy_transaction_base) an_exp;
   `uvm_component_utils(cdn_phy_monitor_base_2cov_connect)
   function new(string name="", uvm_component parent=null);
   	super.new(name, parent);
   endfunction: new

   virtual function void write(cdn_phy_transaction_base tr);
      cov.tr = tr;
      -> cov.cov_event;
   endfunction:write 
endclass: cdn_phy_monitor_base_2cov_connect

`endif // CDN_PHY_MONITOR_BASE_2COV_CONNECT
