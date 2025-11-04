
`ifndef CDN_U4_DP_VIRTUAL_SEQUENCE__SV
`define CDN_U4_DP_VIRTUAL_SEQUENCE__SV

class cdn_u4_dp_virtual_sequence extends cdn_phy_base_sequence # (cdn_u4_dp_transaction);
  
   //---------------------------------
   // Member config
   //---------------------------------
   cdn_u4_dp_config      host_cfg;
   cdn_u4_dp_config      device_cfg;

   `uvm_object_utils(cdn_u4_dp_virtual_sequence)
   `uvm_declare_p_sequencer(cdn_u4_dp_virtual_sequencer)

   //---------------------------------------
   // Constructor
   //---------------------------------------
   function new (string name = "cdn_u4_dp_virtual_sequence");
       super.new(name);
   endfunction : new

   extern virtual task pre_body();
   extern virtual task body();
   extern virtual function void link_trg_set(bit link_trg_enable=0);
   extern virtual function void link_trg_none();
   extern virtual function void link_trg_cr();
   extern virtual function void link_trg_eq(dp_link_tps_t tps_type=LINK_TPS2);
   extern virtual function void link_trg_128b132b_eq();
   extern virtual function void link_trg_128b132b_cds();
   extern virtual function void link_trg_done();

endclass

task cdn_u4_dp_virtual_sequence::pre_body();
  // get agent configs
  host_cfg = p_sequencer.host_cfg;
  device_cfg = p_sequencer.device_cfg;
endtask:pre_body

task cdn_u4_dp_virtual_sequence::body();

   cdn_u4_dp_base_sequence   dp_base_seq[tb_param::DP_LANE_NUM];

   `uvm_info(get_full_name(), $sformatf("This is dp virtual sequence!"), UVM_LOW);

   #50us;
   link_trg_set(1);
   link_trg_none();
   #50us;
   link_trg_cr();
   #50us;
   link_trg_eq(LINK_TPS3);
   #50us;
   link_trg_done();

   // send trans
   // TODO: threads are based on the number of working lanes
   fork
     `uvm_do_on(dp_base_seq[0], p_sequencer.host_sequencer[0]);
     `uvm_do_on(dp_base_seq[1], p_sequencer.host_sequencer[1]);
     `uvm_do_on(dp_base_seq[2], p_sequencer.host_sequencer[2]);
     `uvm_do_on(dp_base_seq[3], p_sequencer.host_sequencer[3]);
   join

   #100;

endtask : body

function void cdn_u4_dp_virtual_sequence::link_trg_set(bit link_trg_enable=0);
  host_cfg.m_bfm.status_intf.link_trg_en = link_trg_enable;
endfunction: link_trg_none

function void cdn_u4_dp_virtual_sequence::link_trg_none();
  host_cfg.m_bfm.status_intf.link_trg_stage = LINK_TRG_NONE;
endfunction: link_trg_none

function void cdn_u4_dp_virtual_sequence::link_trg_cr();
  host_cfg.m_bfm.status_intf.link_trg_stage = LINK_TRG_CR;
  host_cfg.m_bfm.status_intf.link_trg_tps   = LINK_TPS1;
  // ToDo: adjust preemphasis and vswing, and data rate/lane num in future
endfunction: link_trg_cr

function void cdn_u4_dp_virtual_sequence::link_trg_eq(dp_link_tps_t tps_type=LINK_TPS2);
  host_cfg.m_bfm.status_intf.link_trg_stage = LINK_TRG_EQ;
  host_cfg.m_bfm.status_intf.link_trg_tps   = tps_type;
endfunction: link_trg_eq

function void cdn_u4_dp_virtual_sequence::link_trg_128b132b_eq();
  host_cfg.m_bfm.status_intf.link_trg_stage = LINK_TRG_128B132B_EQ;
  host_cfg.m_bfm.status_intf.link_trg_tps   = LINK_128B132B_TPS1;
endfunction: link_trg_128b132b_eq

function void cdn_u4_dp_virtual_sequence::link_trg_128b132b_cds();
  host_cfg.m_bfm.status_intf.link_trg_stage = LINK_TRG_128B132B_CDS;
  host_cfg.m_bfm.status_intf.link_trg_tps   = LINK_128B132B_TPS2;
endfunction: link_trg_128b132b_cds

function void cdn_u4_dp_virtual_sequence::link_trg_done();
  host_cfg.m_bfm.status_intf.link_trg_stage = LINK_TRG_DONE;
  host_cfg.m_bfm.status_intf.link_trg_tps   = LINK_IDLE_PATTERN; // TODO, 8b10b or 128b132b, based on data rate
endfunction: link_trg_done

`endif // CDN_U4_DP_VIRTUAL_SEQUENCE__SV

