//
// Template for UVM-compliant Coverage Class
//

`ifndef CDN_PHY_COV__SV
`define CDN_PHY_COV__SV

class cdn_phy_cov extends uvm_component;
   event cov_event;
   cdn_phy_transaction_base tr;
   uvm_analysis_imp #(cdn_phy_transaction_base, cdn_phy_cov) cov_export;
   `uvm_component_utils(cdn_phy_cov)
 
   covergroup cg_trans @(cov_event);
      //coverpoint tr.kind;
      // ToDo: Add required coverpoints, coverbins
   endgroup: cg_trans


   function new(string name, uvm_component parent);
      super.new(name,parent);
      cg_trans = new;
      cov_export = new("Coverage Analysis",this);
   endfunction: new

   virtual function write(cdn_phy_transaction_base tr);
      this.tr = tr;
      -> cov_event;
   endfunction: write

endclass: cdn_phy_cov

`endif // CDN_PHY_COV__SV

