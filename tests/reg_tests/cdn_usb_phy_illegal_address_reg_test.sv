//
// Template for UVM-compliant testcase

`ifndef CDN_USB_PHY_ILLEGAL_ADDRESS_REG_TEST__SV
`define CDN_USB_PHY_ILLEGAL_ADDRESS_REG_TEST__SV

class cdn_usb_phy_illegal_address_reg_test extends cdn_phy_test_base;

  `uvm_component_utils(cdn_usb_phy_illegal_address_reg_test)

  //---------------------------------
  // Member components
  //---------------------------------
   cdn_phy_env_base   base_env;
   uvm_status_e status;
   cdn_usb_phy_top_regmodel   regmodel; 
 

   uvm_reg_block m_reg_blk[$];
   uvm_reg_field fields[$];
   uvm_reg       m_reg[$];
   uvm_reg_map map;
  //---------------------------------
  // Member seqs
  //---------------------------------
  //cdn_usb_phy_reg_seq   reg_seq;
   uvm_reg_hw_reset_seq     m_reg_hw_seq;
   uvm_reg_bit_bash_seq     m_reg_bit_bash_seq;
   cdn_reset_sequence  reset_seq;

  function new(string name, uvm_component parent);
    super.new(name, parent);
  endfunction

  virtual function void build_phase(uvm_phase phase);
    super.build_phase(phase);

    base_env = cdn_phy_env_base::type_id::create("base_env", this);
    reset_seq = cdn_reset_sequence::type_id::create("reset_seq");
      m_reg_hw_seq  = uvm_reg_hw_reset_seq::type_id::create("m_reg_hw_seq");
      m_reg_bit_bash_seq  = uvm_reg_bit_bash_seq::type_id::create("m_reg_bit_bash_seq");
    dut_cfg.reg_interface_sel = APB;
  endfunction

    function void connect_phase(uvm_phase phase);
      super.connect_phase(phase);
      this.regmodel = base_env.regmodel_phy;
    endfunction:connect_phase

 virtual task run_phase(uvm_phase phase);
    super.run_phase(phase);
    phase.raise_objection(this);

    `uvm_info(get_type_name(),$sformatf("Start test, %s",get_type_name() ),UVM_LOW);


    assert(randomize(reset_seq) with {reset_seq.apb_reset_en ==1;});
    reset_seq.start(base_env.vsqr.m_reset_sqr[0]);
       m_reg_hw_seq.model =regmodel.illegal_reg_block.sd3101_t4_registers_sd3101_phy_registers;  
       m_reg_bit_bash_seq.model = regmodel.illegal_reg_block.sd3101_t4_registers_sd3101_phy_registers;
       m_reg_hw_seq.start(null); 
         `uvm_info(get_full_name(),"m_reg_hw_seq done",UVM_LOW)
       #100ns;
       m_reg_bit_bash_seq.start(null);
       `uvm_info(get_full_name(),"m_reg_bit_bash_seq done",UVM_LOW)

       m_reg_hw_seq.model =regmodel.phy_pcs_cmn_reg_block.sd3101_t4_registers_sd3101_phy_registers;  
       m_reg_bit_bash_seq.model = regmodel.phy_pcs_cmn_reg_block.sd3101_t4_registers_sd3101_phy_registers;
       m_reg_hw_seq.start(null); 
         `uvm_info(get_full_name(),"m_reg_hw_seq done",UVM_LOW)
       #100ns;
       m_reg_bit_bash_seq.start(null);
       `uvm_info(get_full_name(),"m_reg_bit_bash_seq done",UVM_LOW)

    #10us;

    `uvm_info(get_type_name(),$sformatf("End test, %s",get_type_name() ),UVM_LOW); 
    phase.drop_objection(this);
  endtask


endclass : cdn_usb_phy_illegal_address_reg_test

`endif // CDN_USB_PHY_ILLEGAL_ADDRESS_REG_TEST__SV


