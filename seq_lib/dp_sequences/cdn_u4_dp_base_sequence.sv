
`ifndef CDN_U4_DP_BASE_SEQUENCE__SV
`define CDN_U4_DP_BASE_SEQUENCE__SV

class cdn_u4_dp_base_sequence extends cdn_phy_base_sequence # (cdn_u4_dp_transaction);
  
   //---------------------------------
   // Member config
   //---------------------------------
   cdn_u4_dp_config  cfg;

   `uvm_object_utils(cdn_u4_dp_base_sequence)
   `uvm_declare_p_sequencer(cdn_u4_dp_sequencer)

   //---------------------------------------
   // Constructor
   //---------------------------------------
   function new (string name = "cdn_u4_dp_base_sequence");
       super.new(name);
   endfunction : new

   extern virtual task pre_body();
   extern virtual task body();

endclass

task cdn_u4_dp_base_sequence::pre_body();
  // get cfg
  cfg = p_sequencer.m_cfg;
endtask:pre_body

task cdn_u4_dp_base_sequence::body();

   cdn_u4_dp_transaction  dp_trans;

   `uvm_info(get_full_name(), $sformatf("This is dp base sequence!"), UVM_LOW);

   #50us;

   // send trans
   repeat(10) begin
     //`uvm_do_with(req, { sa == 3; } );
     `uvm_do(dp_trans);
     // ToDo: User can add implementation here
     #100; //Dummy delay added here for test run
   end

endtask : body

`endif // CDN_U4_DP_BASE_SEQUENCE__SV

