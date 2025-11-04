class cdn_u4_dp_virtual_sequencer extends cdn_phy_virtual_sequencer_base;
   `uvm_component_utils(cdn_u4_dp_virtual_sequencer)
     
   //------------------------------------
   // Member component                            
   //------------------------------------
   cdn_u4_dp_sequencer   host_sequencer[tb_param::DP_LANE_NUM];
   cdn_u4_dp_sequencer   device_sequencer[tb_param::DP_LANE_NUM];
   cdn_phy_virtual_sequencer_base base_vsqr;
   //------------------------------------
   // Member config
   //------------------------------------
   cdn_u4_dp_config      host_cfg;
   cdn_u4_dp_config      device_cfg;

   function new (string name,
                 uvm_component parent);
   super.new(name,parent);
   endfunction:new 

endclass
