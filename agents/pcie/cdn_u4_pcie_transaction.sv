//
// Template for UVM-compliant transaction descriptor


`ifndef cdn_u4_pcie_transaction__SV
`define cdn_u4_pcie_transaction__SV


class cdn_u4_pcie_transaction extends cdn_phy_transaction_base;

   //typedef enum {READ, WRITE } kinds_e;
   //rand kinds_e kind;
   //typedef enum {IS_OK, ERROR} status_e;
   //rand status_e status;
   //rand byte sa;
   bit datak;
   bit[7:0] data;
   bit[1:0] block_head;
   bit[7:0] block_data[];
   bit datak_a[];
   bit skp;
   bit no_compare;

   // ToDo: Add constraint blocks to prevent error injection
   // ToDo: Add relevant class properties to define all transactions
   // ToDo: Modify/add symbolic transaction identifiers to match

   //constraint cdn_u4_pcie_transaction_valid {
   //   // ToDo: Define constraint to make descriptor valid
   //   status == IS_OK;
   //}
   `uvm_object_utils_begin(cdn_u4_pcie_transaction) 

      // ToDo: add properties using macros here
   
      `uvm_field_int(datak,UVM_ALL_ON)
      `uvm_field_int(data, UVM_ALL_ON)
	  `uvm_field_int(block_head,UVM_ALL_ON)
	  `uvm_field_int(skp,UVM_ALL_ON)
      `uvm_field_array_int(block_data, UVM_ALL_ON)
      `uvm_field_array_int(datak_a, UVM_ALL_ON)
   `uvm_object_utils_end
 
   extern function new(string name = "Trans");
endclass: cdn_u4_pcie_transaction


function cdn_u4_pcie_transaction::new(string name = "Trans");
   super.new(name);
endfunction: new

`endif // cdn_u4_pcie_transaction__SV

