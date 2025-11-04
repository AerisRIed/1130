//*************************************************************//
//   ** File Generated Automatically
//   ** Please donot edit manually
//*************************************************************//


package cdn_phy_pcs_cmn_reg_pkg;
  import uvm_pkg::*;
  `include "uvm_macros.svh"
  import cdns_uvmreg_utils_pkg_phy_pcs_cmn_registers::*;

  bit no_factory = 0; 

/////////////////////////////////////////////////////
//                phy_apb_mstr_addr
/////////////////////////////////////////////////////
class T_phy_apb_mstr_addr_236 extends cdns_uvm_reg;

  `uvm_object_utils(T_phy_apb_mstr_addr_236)
  rand uvm_reg_field phy_apb_mstr_addr_31_0;
  
  covergroup wr_fld_covg;
    phy_apb_mstr_addr_31_0: coverpoint phy_apb_mstr_addr_31_0.value[31:0];
  endgroup
  covergroup rd_fld_covg;
    phy_apb_mstr_addr_31_0: coverpoint phy_apb_mstr_addr_31_0.value[31:0];
  endgroup

  protected virtual function void sample(uvm_reg_data_t data, uvm_reg_data_t byte_en, bit is_read, uvm_reg_map map);
    super.sample(data, byte_en, is_read, map);
    if (get_coverage(UVM_CVR_FIELD_VALS)) begin
      if(!is_read) begin
          wr_fld_covg.sample();
      end
      if(is_read) begin
         rd_fld_covg.sample();
      end
    end
  endfunction

  virtual function void sample_values();
    super.sample_values();
    if (get_coverage(UVM_CVR_FIELD_VALS)) begin
      wr_fld_covg.sample();
      rd_fld_covg.sample();
    end
  endfunction

  virtual function void build();
    uvm_reg_field fld_set[$];
    uvm_reg_field_config_ta ta = get_field_config(getconfigUID());
    build_uvm_reg_fields(this, ta, fld_set);
    
    phy_apb_mstr_addr_31_0 = fld_set[0];
  endfunction

  function new(input string name="T_phy_apb_mstr_addr_236");
    super.new(name, 32, build_coverage(UVM_CVR_FIELD_VALS));
    if (has_coverage(UVM_CVR_FIELD_VALS)) begin
      wr_fld_covg = new();
      rd_fld_covg = new();
    end
  endfunction

endclass


/////////////////////////////////////////////////////
//                phy_ctrl
/////////////////////////////////////////////////////
class T_phy_ctrl_209 extends cdns_uvm_reg;

  `uvm_object_utils(T_phy_ctrl_209)
  rand uvm_reg_field phy_ctrl_0;
  rand uvm_reg_field phy_ctrl_1;
  rand uvm_reg_field phy_ctrl_2;
  rand uvm_reg_field phy_ctrl_3;
  rand uvm_reg_field phy_ctrl_4;
  rand uvm_reg_field phy_ctrl_5;
  rand uvm_reg_field phy_ctrl_7_6;
  rand uvm_reg_field phy_ctrl_8;
  rand uvm_reg_field phy_ctrl_9;
  rand uvm_reg_field phy_ctrl_10;
  rand uvm_reg_field phy_ctrl_11;
  rand uvm_reg_field phy_ctrl_15_12;
  rand uvm_reg_field phy_ctrl_16;
  rand uvm_reg_field phy_ctrl_17;
  rand uvm_reg_field phy_ctrl_18;
  rand uvm_reg_field phy_ctrl_19;
  rand uvm_reg_field phy_ctrl_20;
  rand uvm_reg_field phy_ctrl_24_21;
  rand uvm_reg_field phy_ctrl_25;
  rand uvm_reg_field phy_ctrl_26;
  rand uvm_reg_field phy_ctrl_31_27;
  
  covergroup wr_fld_covg;
    phy_ctrl_0: coverpoint phy_ctrl_0.value[0:0];
    phy_ctrl_1: coverpoint phy_ctrl_1.value[0:0];
    phy_ctrl_2: coverpoint phy_ctrl_2.value[0:0];
    phy_ctrl_3: coverpoint phy_ctrl_3.value[0:0];
    phy_ctrl_4: coverpoint phy_ctrl_4.value[0:0];
    phy_ctrl_5: coverpoint phy_ctrl_5.value[0:0];
    phy_ctrl_7_6: coverpoint phy_ctrl_7_6.value[1:0];
    phy_ctrl_8: coverpoint phy_ctrl_8.value[0:0];
    phy_ctrl_9: coverpoint phy_ctrl_9.value[0:0];
    phy_ctrl_10: coverpoint phy_ctrl_10.value[0:0];
    phy_ctrl_11: coverpoint phy_ctrl_11.value[0:0];
    phy_ctrl_15_12: coverpoint phy_ctrl_15_12.value[3:0];
    phy_ctrl_16: coverpoint phy_ctrl_16.value[0:0];
    phy_ctrl_17: coverpoint phy_ctrl_17.value[0:0];
    phy_ctrl_18: coverpoint phy_ctrl_18.value[0:0];
    phy_ctrl_19: coverpoint phy_ctrl_19.value[0:0];
    phy_ctrl_20: coverpoint phy_ctrl_20.value[0:0];
    phy_ctrl_24_21: coverpoint phy_ctrl_24_21.value[3:0];
    phy_ctrl_25: coverpoint phy_ctrl_25.value[0:0];
    phy_ctrl_26: coverpoint phy_ctrl_26.value[0:0];
    phy_ctrl_31_27: coverpoint phy_ctrl_31_27.value[4:0];
  endgroup
  covergroup rd_fld_covg;
    phy_ctrl_0: coverpoint phy_ctrl_0.value[0:0];
    phy_ctrl_1: coverpoint phy_ctrl_1.value[0:0];
    phy_ctrl_2: coverpoint phy_ctrl_2.value[0:0];
    phy_ctrl_3: coverpoint phy_ctrl_3.value[0:0];
    phy_ctrl_4: coverpoint phy_ctrl_4.value[0:0];
    phy_ctrl_5: coverpoint phy_ctrl_5.value[0:0];
    phy_ctrl_7_6: coverpoint phy_ctrl_7_6.value[1:0];
    phy_ctrl_8: coverpoint phy_ctrl_8.value[0:0];
    phy_ctrl_9: coverpoint phy_ctrl_9.value[0:0];
    phy_ctrl_10: coverpoint phy_ctrl_10.value[0:0];
    phy_ctrl_11: coverpoint phy_ctrl_11.value[0:0];
    phy_ctrl_15_12: coverpoint phy_ctrl_15_12.value[3:0];
    phy_ctrl_16: coverpoint phy_ctrl_16.value[0:0];
    phy_ctrl_17: coverpoint phy_ctrl_17.value[0:0];
    phy_ctrl_18: coverpoint phy_ctrl_18.value[0:0];
    phy_ctrl_19: coverpoint phy_ctrl_19.value[0:0];
    phy_ctrl_20: coverpoint phy_ctrl_20.value[0:0];
    phy_ctrl_24_21: coverpoint phy_ctrl_24_21.value[3:0];
    phy_ctrl_25: coverpoint phy_ctrl_25.value[0:0];
    phy_ctrl_26: coverpoint phy_ctrl_26.value[0:0];
    phy_ctrl_31_27: coverpoint phy_ctrl_31_27.value[4:0];
  endgroup

  protected virtual function void sample(uvm_reg_data_t data, uvm_reg_data_t byte_en, bit is_read, uvm_reg_map map);
    super.sample(data, byte_en, is_read, map);
    if (get_coverage(UVM_CVR_FIELD_VALS)) begin
      if(!is_read) begin
          wr_fld_covg.sample();
      end
      if(is_read) begin
         rd_fld_covg.sample();
      end
    end
  endfunction

  virtual function void sample_values();
    super.sample_values();
    if (get_coverage(UVM_CVR_FIELD_VALS)) begin
      wr_fld_covg.sample();
      rd_fld_covg.sample();
    end
  endfunction

  virtual function void build();
    uvm_reg_field fld_set[$];
    uvm_reg_field_config_ta ta = get_field_config(getconfigUID());
    build_uvm_reg_fields(this, ta, fld_set);
    
    phy_ctrl_0 = fld_set[0];
    phy_ctrl_1 = fld_set[1];
    phy_ctrl_2 = fld_set[2];
    phy_ctrl_3 = fld_set[3];
    phy_ctrl_4 = fld_set[4];
    phy_ctrl_5 = fld_set[5];
    phy_ctrl_7_6 = fld_set[6];
    phy_ctrl_8 = fld_set[7];
    phy_ctrl_9 = fld_set[8];
    phy_ctrl_10 = fld_set[9];
    phy_ctrl_11 = fld_set[10];
    phy_ctrl_15_12 = fld_set[11];
    phy_ctrl_16 = fld_set[12];
    phy_ctrl_17 = fld_set[13];
    phy_ctrl_18 = fld_set[14];
    phy_ctrl_19 = fld_set[15];
    phy_ctrl_20 = fld_set[16];
    phy_ctrl_24_21 = fld_set[17];
    phy_ctrl_25 = fld_set[18];
    phy_ctrl_26 = fld_set[19];
    phy_ctrl_31_27 = fld_set[20];
  endfunction

  function new(input string name="T_phy_ctrl_209");
    super.new(name, 32, build_coverage(UVM_CVR_FIELD_VALS));
    if (has_coverage(UVM_CVR_FIELD_VALS)) begin
      wr_fld_covg = new();
      rd_fld_covg = new();
    end
  endfunction

endclass


/////////////////////////////////////////////////////
//                phy_ctrl_set
/////////////////////////////////////////////////////
class T_phy_ctrl_set_210 extends cdns_uvm_reg;

  `uvm_object_utils(T_phy_ctrl_set_210)
  rand uvm_reg_field phy_ctrl_set_0;
  rand uvm_reg_field phy_ctrl_set_4_1;
  rand uvm_reg_field phy_ctrl_set_5;
  rand uvm_reg_field phy_ctrl_set_31_6;
  
  covergroup wr_fld_covg;
    phy_ctrl_set_0: coverpoint phy_ctrl_set_0.value[0:0];
    phy_ctrl_set_4_1: coverpoint phy_ctrl_set_4_1.value[3:0];
    phy_ctrl_set_5: coverpoint phy_ctrl_set_5.value[0:0];
    phy_ctrl_set_31_6: coverpoint phy_ctrl_set_31_6.value[25:0];
  endgroup
  covergroup rd_fld_covg;
    phy_ctrl_set_0: coverpoint phy_ctrl_set_0.value[0:0];
    phy_ctrl_set_4_1: coverpoint phy_ctrl_set_4_1.value[3:0];
    phy_ctrl_set_5: coverpoint phy_ctrl_set_5.value[0:0];
    phy_ctrl_set_31_6: coverpoint phy_ctrl_set_31_6.value[25:0];
  endgroup

  protected virtual function void sample(uvm_reg_data_t data, uvm_reg_data_t byte_en, bit is_read, uvm_reg_map map);
    super.sample(data, byte_en, is_read, map);
    if (get_coverage(UVM_CVR_FIELD_VALS)) begin
      if(!is_read) begin
          wr_fld_covg.sample();
      end
      if(is_read) begin
         rd_fld_covg.sample();
      end
    end
  endfunction

  virtual function void sample_values();
    super.sample_values();
    if (get_coverage(UVM_CVR_FIELD_VALS)) begin
      wr_fld_covg.sample();
      rd_fld_covg.sample();
    end
  endfunction

  virtual function void build();
    uvm_reg_field fld_set[$];
    uvm_reg_field_config_ta ta = get_field_config(getconfigUID());
    build_uvm_reg_fields(this, ta, fld_set);
    
    phy_ctrl_set_0 = fld_set[0];
    phy_ctrl_set_4_1 = fld_set[1];
    phy_ctrl_set_5 = fld_set[2];
    phy_ctrl_set_31_6 = fld_set[3];
  endfunction

  function new(input string name="T_phy_ctrl_set_210");
    super.new(name, 32, build_coverage(UVM_CVR_FIELD_VALS));
    if (has_coverage(UVM_CVR_FIELD_VALS)) begin
      wr_fld_covg = new();
      rd_fld_covg = new();
    end
  endfunction

endclass


/////////////////////////////////////////////////////
//                phy_dp_interrupt_sts
/////////////////////////////////////////////////////
class T_phy_dp_interrupt_sts_221 extends cdns_uvm_reg;

  `uvm_object_utils(T_phy_dp_interrupt_sts_221)
  rand uvm_reg_field phy_dp_interrupt_sts_0;
  rand uvm_reg_field phy_dp_interrupt_sts_1;
  rand uvm_reg_field phy_dp_interrupt_sts_3_2;
  rand uvm_reg_field phy_dp_interrupt_sts_6_4;
  rand uvm_reg_field phy_dp_interrupt_sts_7;
  rand uvm_reg_field phy_dp_interrupt_sts_10_8;
  rand uvm_reg_field phy_dp_interrupt_sts_14_11;
  rand uvm_reg_field phy_dp_interrupt_sts_15;
  rand uvm_reg_field phy_dp_interrupt_sts_31_16;
  
  covergroup wr_fld_covg;
    phy_dp_interrupt_sts_0: coverpoint phy_dp_interrupt_sts_0.value[0:0];
    phy_dp_interrupt_sts_1: coverpoint phy_dp_interrupt_sts_1.value[0:0];
    phy_dp_interrupt_sts_3_2: coverpoint phy_dp_interrupt_sts_3_2.value[1:0];
    phy_dp_interrupt_sts_6_4: coverpoint phy_dp_interrupt_sts_6_4.value[2:0];
    phy_dp_interrupt_sts_7: coverpoint phy_dp_interrupt_sts_7.value[0:0];
    phy_dp_interrupt_sts_10_8: coverpoint phy_dp_interrupt_sts_10_8.value[2:0];
    phy_dp_interrupt_sts_14_11: coverpoint phy_dp_interrupt_sts_14_11.value[3:0];
    phy_dp_interrupt_sts_15: coverpoint phy_dp_interrupt_sts_15.value[0:0];
    phy_dp_interrupt_sts_31_16: coverpoint phy_dp_interrupt_sts_31_16.value[15:0];
  endgroup
  covergroup rd_fld_covg;
    phy_dp_interrupt_sts_0: coverpoint phy_dp_interrupt_sts_0.value[0:0];
    phy_dp_interrupt_sts_1: coverpoint phy_dp_interrupt_sts_1.value[0:0];
    phy_dp_interrupt_sts_3_2: coverpoint phy_dp_interrupt_sts_3_2.value[1:0];
    phy_dp_interrupt_sts_6_4: coverpoint phy_dp_interrupt_sts_6_4.value[2:0];
    phy_dp_interrupt_sts_7: coverpoint phy_dp_interrupt_sts_7.value[0:0];
    phy_dp_interrupt_sts_10_8: coverpoint phy_dp_interrupt_sts_10_8.value[2:0];
    phy_dp_interrupt_sts_14_11: coverpoint phy_dp_interrupt_sts_14_11.value[3:0];
    phy_dp_interrupt_sts_15: coverpoint phy_dp_interrupt_sts_15.value[0:0];
    phy_dp_interrupt_sts_31_16: coverpoint phy_dp_interrupt_sts_31_16.value[15:0];
  endgroup

  protected virtual function void sample(uvm_reg_data_t data, uvm_reg_data_t byte_en, bit is_read, uvm_reg_map map);
    super.sample(data, byte_en, is_read, map);
    if (get_coverage(UVM_CVR_FIELD_VALS)) begin
      if(!is_read) begin
          wr_fld_covg.sample();
      end
      if(is_read) begin
         rd_fld_covg.sample();
      end
    end
  endfunction

  virtual function void sample_values();
    super.sample_values();
    if (get_coverage(UVM_CVR_FIELD_VALS)) begin
      wr_fld_covg.sample();
      rd_fld_covg.sample();
    end
  endfunction

  virtual function void build();
    uvm_reg_field fld_set[$];
    uvm_reg_field_config_ta ta = get_field_config(getconfigUID());
    build_uvm_reg_fields(this, ta, fld_set);
    
    phy_dp_interrupt_sts_0 = fld_set[0];
    phy_dp_interrupt_sts_1 = fld_set[1];
    phy_dp_interrupt_sts_3_2 = fld_set[2];
    phy_dp_interrupt_sts_6_4 = fld_set[3];
    phy_dp_interrupt_sts_7 = fld_set[4];
    phy_dp_interrupt_sts_10_8 = fld_set[5];
    phy_dp_interrupt_sts_14_11 = fld_set[6];
    phy_dp_interrupt_sts_15 = fld_set[7];
    phy_dp_interrupt_sts_31_16 = fld_set[8];
  endfunction

  function new(input string name="T_phy_dp_interrupt_sts_221");
    super.new(name, 32, build_coverage(UVM_CVR_FIELD_VALS));
    if (has_coverage(UVM_CVR_FIELD_VALS)) begin
      wr_fld_covg = new();
      rd_fld_covg = new();
    end
  endfunction

endclass


/////////////////////////////////////////////////////
//                phy_interrupt_sts_usb4_l0_reg
/////////////////////////////////////////////////////
class T_phy_interrupt_sts_usb4_l0_reg_223 extends cdns_uvm_reg;

  `uvm_object_utils(T_phy_interrupt_sts_usb4_l0_reg_223)
  rand uvm_reg_field phy_interrupt_sts_usb4_l0_reg_0;
  rand uvm_reg_field phy_interrupt_sts_usb4_l0_reg_1;
  rand uvm_reg_field phy_interrupt_sts_usb4_l0_reg_3_2;
  rand uvm_reg_field phy_interrupt_sts_usb4_l0_reg_6_4;
  rand uvm_reg_field phy_interrupt_sts_usb4_l0_reg_7;
  rand uvm_reg_field phy_interrupt_sts_usb4_l0_reg_10_8;
  rand uvm_reg_field phy_interrupt_sts_usb4_l0_reg_15_11;
  rand uvm_reg_field phy_interrupt_sts_usb4_l0_reg_16;
  rand uvm_reg_field phy_interrupt_sts_usb4_l0_reg_31_17;
  
  covergroup wr_fld_covg;
    phy_interrupt_sts_usb4_l0_reg_0: coverpoint phy_interrupt_sts_usb4_l0_reg_0.value[0:0];
    phy_interrupt_sts_usb4_l0_reg_1: coverpoint phy_interrupt_sts_usb4_l0_reg_1.value[0:0];
    phy_interrupt_sts_usb4_l0_reg_3_2: coverpoint phy_interrupt_sts_usb4_l0_reg_3_2.value[1:0];
    phy_interrupt_sts_usb4_l0_reg_6_4: coverpoint phy_interrupt_sts_usb4_l0_reg_6_4.value[2:0];
    phy_interrupt_sts_usb4_l0_reg_7: coverpoint phy_interrupt_sts_usb4_l0_reg_7.value[0:0];
    phy_interrupt_sts_usb4_l0_reg_10_8: coverpoint phy_interrupt_sts_usb4_l0_reg_10_8.value[2:0];
    phy_interrupt_sts_usb4_l0_reg_15_11: coverpoint phy_interrupt_sts_usb4_l0_reg_15_11.value[4:0];
    phy_interrupt_sts_usb4_l0_reg_16: coverpoint phy_interrupt_sts_usb4_l0_reg_16.value[0:0];
    phy_interrupt_sts_usb4_l0_reg_31_17: coverpoint phy_interrupt_sts_usb4_l0_reg_31_17.value[14:0];
  endgroup
  covergroup rd_fld_covg;
    phy_interrupt_sts_usb4_l0_reg_0: coverpoint phy_interrupt_sts_usb4_l0_reg_0.value[0:0];
    phy_interrupt_sts_usb4_l0_reg_1: coverpoint phy_interrupt_sts_usb4_l0_reg_1.value[0:0];
    phy_interrupt_sts_usb4_l0_reg_3_2: coverpoint phy_interrupt_sts_usb4_l0_reg_3_2.value[1:0];
    phy_interrupt_sts_usb4_l0_reg_6_4: coverpoint phy_interrupt_sts_usb4_l0_reg_6_4.value[2:0];
    phy_interrupt_sts_usb4_l0_reg_7: coverpoint phy_interrupt_sts_usb4_l0_reg_7.value[0:0];
    phy_interrupt_sts_usb4_l0_reg_10_8: coverpoint phy_interrupt_sts_usb4_l0_reg_10_8.value[2:0];
    phy_interrupt_sts_usb4_l0_reg_15_11: coverpoint phy_interrupt_sts_usb4_l0_reg_15_11.value[4:0];
    phy_interrupt_sts_usb4_l0_reg_16: coverpoint phy_interrupt_sts_usb4_l0_reg_16.value[0:0];
    phy_interrupt_sts_usb4_l0_reg_31_17: coverpoint phy_interrupt_sts_usb4_l0_reg_31_17.value[14:0];
  endgroup

  protected virtual function void sample(uvm_reg_data_t data, uvm_reg_data_t byte_en, bit is_read, uvm_reg_map map);
    super.sample(data, byte_en, is_read, map);
    if (get_coverage(UVM_CVR_FIELD_VALS)) begin
      if(!is_read) begin
          wr_fld_covg.sample();
      end
      if(is_read) begin
         rd_fld_covg.sample();
      end
    end
  endfunction

  virtual function void sample_values();
    super.sample_values();
    if (get_coverage(UVM_CVR_FIELD_VALS)) begin
      wr_fld_covg.sample();
      rd_fld_covg.sample();
    end
  endfunction

  virtual function void build();
    uvm_reg_field fld_set[$];
    uvm_reg_field_config_ta ta = get_field_config(getconfigUID());
    build_uvm_reg_fields(this, ta, fld_set);
    
    phy_interrupt_sts_usb4_l0_reg_0 = fld_set[0];
    phy_interrupt_sts_usb4_l0_reg_1 = fld_set[1];
    phy_interrupt_sts_usb4_l0_reg_3_2 = fld_set[2];
    phy_interrupt_sts_usb4_l0_reg_6_4 = fld_set[3];
    phy_interrupt_sts_usb4_l0_reg_7 = fld_set[4];
    phy_interrupt_sts_usb4_l0_reg_10_8 = fld_set[5];
    phy_interrupt_sts_usb4_l0_reg_15_11 = fld_set[6];
    phy_interrupt_sts_usb4_l0_reg_16 = fld_set[7];
    phy_interrupt_sts_usb4_l0_reg_31_17 = fld_set[8];
  endfunction

  function new(input string name="T_phy_interrupt_sts_usb4_l0_reg_223");
    super.new(name, 32, build_coverage(UVM_CVR_FIELD_VALS));
    if (has_coverage(UVM_CVR_FIELD_VALS)) begin
      wr_fld_covg = new();
      rd_fld_covg = new();
    end
  endfunction

endclass


/////////////////////////////////////////////////////
//                phy_interrupt_sts_usb4_l1_reg
/////////////////////////////////////////////////////
class T_phy_interrupt_sts_usb4_l1_reg_224 extends cdns_uvm_reg;

  `uvm_object_utils(T_phy_interrupt_sts_usb4_l1_reg_224)
  rand uvm_reg_field phy_interrupt_sts_usb4_l1_reg_0;
  rand uvm_reg_field phy_interrupt_sts_usb4_l1_reg_1;
  rand uvm_reg_field phy_interrupt_sts_usb4_l1_reg_3_2;
  rand uvm_reg_field phy_interrupt_sts_usb4_l1_reg_6_4;
  rand uvm_reg_field phy_interrupt_sts_usb4_l1_reg_7;
  rand uvm_reg_field phy_interrupt_sts_usb4_l1_reg_10_8;
  rand uvm_reg_field phy_interrupt_sts_usb4_l1_reg_15_11;
  rand uvm_reg_field phy_interrupt_sts_usb4_l1_reg_16;
  rand uvm_reg_field phy_interrupt_sts_usb4_l1_reg_31_17;
  
  covergroup wr_fld_covg;
    phy_interrupt_sts_usb4_l1_reg_0: coverpoint phy_interrupt_sts_usb4_l1_reg_0.value[0:0];
    phy_interrupt_sts_usb4_l1_reg_1: coverpoint phy_interrupt_sts_usb4_l1_reg_1.value[0:0];
    phy_interrupt_sts_usb4_l1_reg_3_2: coverpoint phy_interrupt_sts_usb4_l1_reg_3_2.value[1:0];
    phy_interrupt_sts_usb4_l1_reg_6_4: coverpoint phy_interrupt_sts_usb4_l1_reg_6_4.value[2:0];
    phy_interrupt_sts_usb4_l1_reg_7: coverpoint phy_interrupt_sts_usb4_l1_reg_7.value[0:0];
    phy_interrupt_sts_usb4_l1_reg_10_8: coverpoint phy_interrupt_sts_usb4_l1_reg_10_8.value[2:0];
    phy_interrupt_sts_usb4_l1_reg_15_11: coverpoint phy_interrupt_sts_usb4_l1_reg_15_11.value[4:0];
    phy_interrupt_sts_usb4_l1_reg_16: coverpoint phy_interrupt_sts_usb4_l1_reg_16.value[0:0];
    phy_interrupt_sts_usb4_l1_reg_31_17: coverpoint phy_interrupt_sts_usb4_l1_reg_31_17.value[14:0];
  endgroup
  covergroup rd_fld_covg;
    phy_interrupt_sts_usb4_l1_reg_0: coverpoint phy_interrupt_sts_usb4_l1_reg_0.value[0:0];
    phy_interrupt_sts_usb4_l1_reg_1: coverpoint phy_interrupt_sts_usb4_l1_reg_1.value[0:0];
    phy_interrupt_sts_usb4_l1_reg_3_2: coverpoint phy_interrupt_sts_usb4_l1_reg_3_2.value[1:0];
    phy_interrupt_sts_usb4_l1_reg_6_4: coverpoint phy_interrupt_sts_usb4_l1_reg_6_4.value[2:0];
    phy_interrupt_sts_usb4_l1_reg_7: coverpoint phy_interrupt_sts_usb4_l1_reg_7.value[0:0];
    phy_interrupt_sts_usb4_l1_reg_10_8: coverpoint phy_interrupt_sts_usb4_l1_reg_10_8.value[2:0];
    phy_interrupt_sts_usb4_l1_reg_15_11: coverpoint phy_interrupt_sts_usb4_l1_reg_15_11.value[4:0];
    phy_interrupt_sts_usb4_l1_reg_16: coverpoint phy_interrupt_sts_usb4_l1_reg_16.value[0:0];
    phy_interrupt_sts_usb4_l1_reg_31_17: coverpoint phy_interrupt_sts_usb4_l1_reg_31_17.value[14:0];
  endgroup

  protected virtual function void sample(uvm_reg_data_t data, uvm_reg_data_t byte_en, bit is_read, uvm_reg_map map);
    super.sample(data, byte_en, is_read, map);
    if (get_coverage(UVM_CVR_FIELD_VALS)) begin
      if(!is_read) begin
          wr_fld_covg.sample();
      end
      if(is_read) begin
         rd_fld_covg.sample();
      end
    end
  endfunction

  virtual function void sample_values();
    super.sample_values();
    if (get_coverage(UVM_CVR_FIELD_VALS)) begin
      wr_fld_covg.sample();
      rd_fld_covg.sample();
    end
  endfunction

  virtual function void build();
    uvm_reg_field fld_set[$];
    uvm_reg_field_config_ta ta = get_field_config(getconfigUID());
    build_uvm_reg_fields(this, ta, fld_set);
    
    phy_interrupt_sts_usb4_l1_reg_0 = fld_set[0];
    phy_interrupt_sts_usb4_l1_reg_1 = fld_set[1];
    phy_interrupt_sts_usb4_l1_reg_3_2 = fld_set[2];
    phy_interrupt_sts_usb4_l1_reg_6_4 = fld_set[3];
    phy_interrupt_sts_usb4_l1_reg_7 = fld_set[4];
    phy_interrupt_sts_usb4_l1_reg_10_8 = fld_set[5];
    phy_interrupt_sts_usb4_l1_reg_15_11 = fld_set[6];
    phy_interrupt_sts_usb4_l1_reg_16 = fld_set[7];
    phy_interrupt_sts_usb4_l1_reg_31_17 = fld_set[8];
  endfunction

  function new(input string name="T_phy_interrupt_sts_usb4_l1_reg_224");
    super.new(name, 32, build_coverage(UVM_CVR_FIELD_VALS));
    if (has_coverage(UVM_CVR_FIELD_VALS)) begin
      wr_fld_covg = new();
      rd_fld_covg = new();
    end
  endfunction

endclass


/////////////////////////////////////////////////////
//                phy_iso_cmn_ctrl
/////////////////////////////////////////////////////
class T_phy_iso_cmn_ctrl_215 extends cdns_uvm_reg;

  `uvm_object_utils(T_phy_iso_cmn_ctrl_215)
  rand uvm_reg_field phy_iso_cmn_ctrl_0;
  rand uvm_reg_field phy_iso_cmn_ctrl_1;
  rand uvm_reg_field phy_iso_cmn_ctrl_2;
  rand uvm_reg_field phy_iso_cmn_ctrl_31_3;
  
  covergroup wr_fld_covg;
    phy_iso_cmn_ctrl_0: coverpoint phy_iso_cmn_ctrl_0.value[0:0];
    phy_iso_cmn_ctrl_1: coverpoint phy_iso_cmn_ctrl_1.value[0:0];
    phy_iso_cmn_ctrl_2: coverpoint phy_iso_cmn_ctrl_2.value[0:0];
    phy_iso_cmn_ctrl_31_3: coverpoint phy_iso_cmn_ctrl_31_3.value[28:0];
  endgroup
  covergroup rd_fld_covg;
    phy_iso_cmn_ctrl_0: coverpoint phy_iso_cmn_ctrl_0.value[0:0];
    phy_iso_cmn_ctrl_1: coverpoint phy_iso_cmn_ctrl_1.value[0:0];
    phy_iso_cmn_ctrl_2: coverpoint phy_iso_cmn_ctrl_2.value[0:0];
    phy_iso_cmn_ctrl_31_3: coverpoint phy_iso_cmn_ctrl_31_3.value[28:0];
  endgroup

  protected virtual function void sample(uvm_reg_data_t data, uvm_reg_data_t byte_en, bit is_read, uvm_reg_map map);
    super.sample(data, byte_en, is_read, map);
    if (get_coverage(UVM_CVR_FIELD_VALS)) begin
      if(!is_read) begin
          wr_fld_covg.sample();
      end
      if(is_read) begin
         rd_fld_covg.sample();
      end
    end
  endfunction

  virtual function void sample_values();
    super.sample_values();
    if (get_coverage(UVM_CVR_FIELD_VALS)) begin
      wr_fld_covg.sample();
      rd_fld_covg.sample();
    end
  endfunction

  virtual function void build();
    uvm_reg_field fld_set[$];
    uvm_reg_field_config_ta ta = get_field_config(getconfigUID());
    build_uvm_reg_fields(this, ta, fld_set);
    
    phy_iso_cmn_ctrl_0 = fld_set[0];
    phy_iso_cmn_ctrl_1 = fld_set[1];
    phy_iso_cmn_ctrl_2 = fld_set[2];
    phy_iso_cmn_ctrl_31_3 = fld_set[3];
  endfunction

  function new(input string name="T_phy_iso_cmn_ctrl_215");
    super.new(name, 32, build_coverage(UVM_CVR_FIELD_VALS));
    if (has_coverage(UVM_CVR_FIELD_VALS)) begin
      wr_fld_covg = new();
      rd_fld_covg = new();
    end
  endfunction

endclass


/////////////////////////////////////////////////////
//                phy_iso_cmn_ctrl1_reg
/////////////////////////////////////////////////////
class T_phy_iso_cmn_ctrl1_reg_212 extends cdns_uvm_reg;

  `uvm_object_utils(T_phy_iso_cmn_ctrl1_reg_212)
  rand uvm_reg_field phy_iso_cmn_ctrl1_reg_0;
  rand uvm_reg_field phy_iso_cmn_ctrl1_reg_1;
  rand uvm_reg_field phy_iso_cmn_ctrl1_reg_3_2;
  rand uvm_reg_field phy_iso_cmn_ctrl1_reg_4;
  rand uvm_reg_field phy_iso_cmn_ctrl1_reg_8_5;
  rand uvm_reg_field phy_iso_cmn_ctrl1_reg_12_9;
  rand uvm_reg_field phy_iso_cmn_ctrl1_reg_15_13;
  rand uvm_reg_field phy_iso_cmn_ctrl1_reg_21_16;
  rand uvm_reg_field phy_iso_cmn_ctrl1_reg_22;
  rand uvm_reg_field phy_iso_cmn_ctrl1_reg_23;
  rand uvm_reg_field phy_iso_cmn_ctrl1_reg_29_24;
  rand uvm_reg_field phy_iso_cmn_ctrl1_reg_30;
  rand uvm_reg_field phy_iso_cmn_ctrl1_reg_31;
  
  covergroup wr_fld_covg;
    phy_iso_cmn_ctrl1_reg_0: coverpoint phy_iso_cmn_ctrl1_reg_0.value[0:0];
    phy_iso_cmn_ctrl1_reg_1: coverpoint phy_iso_cmn_ctrl1_reg_1.value[0:0];
    phy_iso_cmn_ctrl1_reg_3_2: coverpoint phy_iso_cmn_ctrl1_reg_3_2.value[1:0];
    phy_iso_cmn_ctrl1_reg_4: coverpoint phy_iso_cmn_ctrl1_reg_4.value[0:0];
    phy_iso_cmn_ctrl1_reg_8_5: coverpoint phy_iso_cmn_ctrl1_reg_8_5.value[3:0];
    phy_iso_cmn_ctrl1_reg_12_9: coverpoint phy_iso_cmn_ctrl1_reg_12_9.value[3:0];
    phy_iso_cmn_ctrl1_reg_15_13: coverpoint phy_iso_cmn_ctrl1_reg_15_13.value[2:0];
    phy_iso_cmn_ctrl1_reg_21_16: coverpoint phy_iso_cmn_ctrl1_reg_21_16.value[5:0];
    phy_iso_cmn_ctrl1_reg_22: coverpoint phy_iso_cmn_ctrl1_reg_22.value[0:0];
    phy_iso_cmn_ctrl1_reg_23: coverpoint phy_iso_cmn_ctrl1_reg_23.value[0:0];
    phy_iso_cmn_ctrl1_reg_29_24: coverpoint phy_iso_cmn_ctrl1_reg_29_24.value[5:0];
    phy_iso_cmn_ctrl1_reg_30: coverpoint phy_iso_cmn_ctrl1_reg_30.value[0:0];
    phy_iso_cmn_ctrl1_reg_31: coverpoint phy_iso_cmn_ctrl1_reg_31.value[0:0];
  endgroup
  covergroup rd_fld_covg;
    phy_iso_cmn_ctrl1_reg_0: coverpoint phy_iso_cmn_ctrl1_reg_0.value[0:0];
    phy_iso_cmn_ctrl1_reg_1: coverpoint phy_iso_cmn_ctrl1_reg_1.value[0:0];
    phy_iso_cmn_ctrl1_reg_3_2: coverpoint phy_iso_cmn_ctrl1_reg_3_2.value[1:0];
    phy_iso_cmn_ctrl1_reg_4: coverpoint phy_iso_cmn_ctrl1_reg_4.value[0:0];
    phy_iso_cmn_ctrl1_reg_8_5: coverpoint phy_iso_cmn_ctrl1_reg_8_5.value[3:0];
    phy_iso_cmn_ctrl1_reg_12_9: coverpoint phy_iso_cmn_ctrl1_reg_12_9.value[3:0];
    phy_iso_cmn_ctrl1_reg_15_13: coverpoint phy_iso_cmn_ctrl1_reg_15_13.value[2:0];
    phy_iso_cmn_ctrl1_reg_21_16: coverpoint phy_iso_cmn_ctrl1_reg_21_16.value[5:0];
    phy_iso_cmn_ctrl1_reg_22: coverpoint phy_iso_cmn_ctrl1_reg_22.value[0:0];
    phy_iso_cmn_ctrl1_reg_23: coverpoint phy_iso_cmn_ctrl1_reg_23.value[0:0];
    phy_iso_cmn_ctrl1_reg_29_24: coverpoint phy_iso_cmn_ctrl1_reg_29_24.value[5:0];
    phy_iso_cmn_ctrl1_reg_30: coverpoint phy_iso_cmn_ctrl1_reg_30.value[0:0];
    phy_iso_cmn_ctrl1_reg_31: coverpoint phy_iso_cmn_ctrl1_reg_31.value[0:0];
  endgroup

  protected virtual function void sample(uvm_reg_data_t data, uvm_reg_data_t byte_en, bit is_read, uvm_reg_map map);
    super.sample(data, byte_en, is_read, map);
    if (get_coverage(UVM_CVR_FIELD_VALS)) begin
      if(!is_read) begin
          wr_fld_covg.sample();
      end
      if(is_read) begin
         rd_fld_covg.sample();
      end
    end
  endfunction

  virtual function void sample_values();
    super.sample_values();
    if (get_coverage(UVM_CVR_FIELD_VALS)) begin
      wr_fld_covg.sample();
      rd_fld_covg.sample();
    end
  endfunction

  virtual function void build();
    uvm_reg_field fld_set[$];
    uvm_reg_field_config_ta ta = get_field_config(getconfigUID());
    build_uvm_reg_fields(this, ta, fld_set);
    
    phy_iso_cmn_ctrl1_reg_0 = fld_set[0];
    phy_iso_cmn_ctrl1_reg_1 = fld_set[1];
    phy_iso_cmn_ctrl1_reg_3_2 = fld_set[2];
    phy_iso_cmn_ctrl1_reg_4 = fld_set[3];
    phy_iso_cmn_ctrl1_reg_8_5 = fld_set[4];
    phy_iso_cmn_ctrl1_reg_12_9 = fld_set[5];
    phy_iso_cmn_ctrl1_reg_15_13 = fld_set[6];
    phy_iso_cmn_ctrl1_reg_21_16 = fld_set[7];
    phy_iso_cmn_ctrl1_reg_22 = fld_set[8];
    phy_iso_cmn_ctrl1_reg_23 = fld_set[9];
    phy_iso_cmn_ctrl1_reg_29_24 = fld_set[10];
    phy_iso_cmn_ctrl1_reg_30 = fld_set[11];
    phy_iso_cmn_ctrl1_reg_31 = fld_set[12];
  endfunction

  function new(input string name="T_phy_iso_cmn_ctrl1_reg_212");
    super.new(name, 32, build_coverage(UVM_CVR_FIELD_VALS));
    if (has_coverage(UVM_CVR_FIELD_VALS)) begin
      wr_fld_covg = new();
      rd_fld_covg = new();
    end
  endfunction

endclass


/////////////////////////////////////////////////////
//                phy_iso_cmn_ctrl2_reg
/////////////////////////////////////////////////////
class T_phy_iso_cmn_ctrl2_reg_213 extends cdns_uvm_reg;

  `uvm_object_utils(T_phy_iso_cmn_ctrl2_reg_213)
  rand uvm_reg_field phy_iso_cmn_ctrl2_reg_0;
  rand uvm_reg_field phy_iso_cmn_ctrl2_reg_1;
  rand uvm_reg_field phy_iso_cmn_ctrl2_reg_3_2;
  rand uvm_reg_field phy_iso_cmn_ctrl2_reg_5_4;
  rand uvm_reg_field phy_iso_cmn_ctrl2_reg_7_6;
  rand uvm_reg_field phy_iso_cmn_ctrl2_reg_8;
  rand uvm_reg_field phy_iso_cmn_ctrl2_reg_9;
  rand uvm_reg_field phy_iso_cmn_ctrl2_reg_10;
  rand uvm_reg_field phy_iso_cmn_ctrl2_reg_11;
  rand uvm_reg_field phy_iso_cmn_ctrl2_reg_12;
  rand uvm_reg_field phy_iso_cmn_ctrl2_reg_31_13;
  
  covergroup wr_fld_covg;
    phy_iso_cmn_ctrl2_reg_0: coverpoint phy_iso_cmn_ctrl2_reg_0.value[0:0];
    phy_iso_cmn_ctrl2_reg_1: coverpoint phy_iso_cmn_ctrl2_reg_1.value[0:0];
    phy_iso_cmn_ctrl2_reg_3_2: coverpoint phy_iso_cmn_ctrl2_reg_3_2.value[1:0];
    phy_iso_cmn_ctrl2_reg_5_4: coverpoint phy_iso_cmn_ctrl2_reg_5_4.value[1:0];
    phy_iso_cmn_ctrl2_reg_7_6: coverpoint phy_iso_cmn_ctrl2_reg_7_6.value[1:0];
    phy_iso_cmn_ctrl2_reg_8: coverpoint phy_iso_cmn_ctrl2_reg_8.value[0:0];
    phy_iso_cmn_ctrl2_reg_9: coverpoint phy_iso_cmn_ctrl2_reg_9.value[0:0];
    phy_iso_cmn_ctrl2_reg_10: coverpoint phy_iso_cmn_ctrl2_reg_10.value[0:0];
    phy_iso_cmn_ctrl2_reg_11: coverpoint phy_iso_cmn_ctrl2_reg_11.value[0:0];
    phy_iso_cmn_ctrl2_reg_12: coverpoint phy_iso_cmn_ctrl2_reg_12.value[0:0];
    phy_iso_cmn_ctrl2_reg_31_13: coverpoint phy_iso_cmn_ctrl2_reg_31_13.value[18:0];
  endgroup
  covergroup rd_fld_covg;
    phy_iso_cmn_ctrl2_reg_0: coverpoint phy_iso_cmn_ctrl2_reg_0.value[0:0];
    phy_iso_cmn_ctrl2_reg_1: coverpoint phy_iso_cmn_ctrl2_reg_1.value[0:0];
    phy_iso_cmn_ctrl2_reg_3_2: coverpoint phy_iso_cmn_ctrl2_reg_3_2.value[1:0];
    phy_iso_cmn_ctrl2_reg_5_4: coverpoint phy_iso_cmn_ctrl2_reg_5_4.value[1:0];
    phy_iso_cmn_ctrl2_reg_7_6: coverpoint phy_iso_cmn_ctrl2_reg_7_6.value[1:0];
    phy_iso_cmn_ctrl2_reg_8: coverpoint phy_iso_cmn_ctrl2_reg_8.value[0:0];
    phy_iso_cmn_ctrl2_reg_9: coverpoint phy_iso_cmn_ctrl2_reg_9.value[0:0];
    phy_iso_cmn_ctrl2_reg_10: coverpoint phy_iso_cmn_ctrl2_reg_10.value[0:0];
    phy_iso_cmn_ctrl2_reg_11: coverpoint phy_iso_cmn_ctrl2_reg_11.value[0:0];
    phy_iso_cmn_ctrl2_reg_12: coverpoint phy_iso_cmn_ctrl2_reg_12.value[0:0];
    phy_iso_cmn_ctrl2_reg_31_13: coverpoint phy_iso_cmn_ctrl2_reg_31_13.value[18:0];
  endgroup

  protected virtual function void sample(uvm_reg_data_t data, uvm_reg_data_t byte_en, bit is_read, uvm_reg_map map);
    super.sample(data, byte_en, is_read, map);
    if (get_coverage(UVM_CVR_FIELD_VALS)) begin
      if(!is_read) begin
          wr_fld_covg.sample();
      end
      if(is_read) begin
         rd_fld_covg.sample();
      end
    end
  endfunction

  virtual function void sample_values();
    super.sample_values();
    if (get_coverage(UVM_CVR_FIELD_VALS)) begin
      wr_fld_covg.sample();
      rd_fld_covg.sample();
    end
  endfunction

  virtual function void build();
    uvm_reg_field fld_set[$];
    uvm_reg_field_config_ta ta = get_field_config(getconfigUID());
    build_uvm_reg_fields(this, ta, fld_set);
    
    phy_iso_cmn_ctrl2_reg_0 = fld_set[0];
    phy_iso_cmn_ctrl2_reg_1 = fld_set[1];
    phy_iso_cmn_ctrl2_reg_3_2 = fld_set[2];
    phy_iso_cmn_ctrl2_reg_5_4 = fld_set[3];
    phy_iso_cmn_ctrl2_reg_7_6 = fld_set[4];
    phy_iso_cmn_ctrl2_reg_8 = fld_set[5];
    phy_iso_cmn_ctrl2_reg_9 = fld_set[6];
    phy_iso_cmn_ctrl2_reg_10 = fld_set[7];
    phy_iso_cmn_ctrl2_reg_11 = fld_set[8];
    phy_iso_cmn_ctrl2_reg_12 = fld_set[9];
    phy_iso_cmn_ctrl2_reg_31_13 = fld_set[10];
  endfunction

  function new(input string name="T_phy_iso_cmn_ctrl2_reg_213");
    super.new(name, 32, build_coverage(UVM_CVR_FIELD_VALS));
    if (has_coverage(UVM_CVR_FIELD_VALS)) begin
      wr_fld_covg = new();
      rd_fld_covg = new();
    end
  endfunction

endclass


/////////////////////////////////////////////////////
//                phy_lane_off_ctl
/////////////////////////////////////////////////////
class T_phy_lane_off_ctl_220 extends cdns_uvm_reg;

  `uvm_object_utils(T_phy_lane_off_ctl_220)
  rand uvm_reg_field phy_lane_off_ctl_3_0;
  rand uvm_reg_field phy_lane_off_ctl_7_4;
  rand uvm_reg_field phy_lane_off_ctl_8;
  rand uvm_reg_field phy_lane_off_ctl_31_9;
  
  covergroup wr_fld_covg;
    phy_lane_off_ctl_3_0: coverpoint phy_lane_off_ctl_3_0.value[3:0];
    phy_lane_off_ctl_7_4: coverpoint phy_lane_off_ctl_7_4.value[3:0];
    phy_lane_off_ctl_8: coverpoint phy_lane_off_ctl_8.value[0:0];
    phy_lane_off_ctl_31_9: coverpoint phy_lane_off_ctl_31_9.value[22:0];
  endgroup
  covergroup rd_fld_covg;
    phy_lane_off_ctl_3_0: coverpoint phy_lane_off_ctl_3_0.value[3:0];
    phy_lane_off_ctl_7_4: coverpoint phy_lane_off_ctl_7_4.value[3:0];
    phy_lane_off_ctl_8: coverpoint phy_lane_off_ctl_8.value[0:0];
    phy_lane_off_ctl_31_9: coverpoint phy_lane_off_ctl_31_9.value[22:0];
  endgroup

  protected virtual function void sample(uvm_reg_data_t data, uvm_reg_data_t byte_en, bit is_read, uvm_reg_map map);
    super.sample(data, byte_en, is_read, map);
    if (get_coverage(UVM_CVR_FIELD_VALS)) begin
      if(!is_read) begin
          wr_fld_covg.sample();
      end
      if(is_read) begin
         rd_fld_covg.sample();
      end
    end
  endfunction

  virtual function void sample_values();
    super.sample_values();
    if (get_coverage(UVM_CVR_FIELD_VALS)) begin
      wr_fld_covg.sample();
      rd_fld_covg.sample();
    end
  endfunction

  virtual function void build();
    uvm_reg_field fld_set[$];
    uvm_reg_field_config_ta ta = get_field_config(getconfigUID());
    build_uvm_reg_fields(this, ta, fld_set);
    
    phy_lane_off_ctl_3_0 = fld_set[0];
    phy_lane_off_ctl_7_4 = fld_set[1];
    phy_lane_off_ctl_8 = fld_set[2];
    phy_lane_off_ctl_31_9 = fld_set[3];
  endfunction

  function new(input string name="T_phy_lane_off_ctl_220");
    super.new(name, 32, build_coverage(UVM_CVR_FIELD_VALS));
    if (has_coverage(UVM_CVR_FIELD_VALS)) begin
      wr_fld_covg = new();
      rd_fld_covg = new();
    end
  endfunction

endclass


/////////////////////////////////////////////////////
//                phy_lane_reset
/////////////////////////////////////////////////////
class T_phy_lane_reset_204 extends cdns_uvm_reg;

  `uvm_object_utils(T_phy_lane_reset_204)
  rand uvm_reg_field phy_lane_reset_15_0;
  rand uvm_reg_field phy_lane_reset_31_16;
  
  covergroup wr_fld_covg;
    phy_lane_reset_15_0: coverpoint phy_lane_reset_15_0.value[15:0];
    phy_lane_reset_31_16: coverpoint phy_lane_reset_31_16.value[15:0];
  endgroup
  covergroup rd_fld_covg;
    phy_lane_reset_15_0: coverpoint phy_lane_reset_15_0.value[15:0];
    phy_lane_reset_31_16: coverpoint phy_lane_reset_31_16.value[15:0];
  endgroup

  protected virtual function void sample(uvm_reg_data_t data, uvm_reg_data_t byte_en, bit is_read, uvm_reg_map map);
    super.sample(data, byte_en, is_read, map);
    if (get_coverage(UVM_CVR_FIELD_VALS)) begin
      if(!is_read) begin
          wr_fld_covg.sample();
      end
      if(is_read) begin
         rd_fld_covg.sample();
      end
    end
  endfunction

  virtual function void sample_values();
    super.sample_values();
    if (get_coverage(UVM_CVR_FIELD_VALS)) begin
      wr_fld_covg.sample();
      rd_fld_covg.sample();
    end
  endfunction

  virtual function void build();
    uvm_reg_field fld_set[$];
    uvm_reg_field_config_ta ta = get_field_config(getconfigUID());
    build_uvm_reg_fields(this, ta, fld_set);
    
    phy_lane_reset_15_0 = fld_set[0];
    phy_lane_reset_31_16 = fld_set[1];
  endfunction

  function new(input string name="T_phy_lane_reset_204");
    super.new(name, 32, build_coverage(UVM_CVR_FIELD_VALS));
    if (has_coverage(UVM_CVR_FIELD_VALS)) begin
      wr_fld_covg = new();
      rd_fld_covg = new();
    end
  endfunction

endclass


/////////////////////////////////////////////////////
//                phy_pcs_gen3_eie_lock_cfg
/////////////////////////////////////////////////////
class T_phy_pcs_gen3_eie_lock_cfg_203 extends cdns_uvm_reg;

  `uvm_object_utils(T_phy_pcs_gen3_eie_lock_cfg_203)
  rand uvm_reg_field phy_pcs_gen3_eie_lock_cfg_7_0;
  rand uvm_reg_field phy_pcs_gen3_eie_lock_cfg_11_8;
  rand uvm_reg_field phy_pcs_gen3_eie_lock_cfg_15_12;
  rand uvm_reg_field phy_pcs_gen3_eie_lock_cfg_31_16;
  
  covergroup wr_fld_covg;
    phy_pcs_gen3_eie_lock_cfg_7_0: coverpoint phy_pcs_gen3_eie_lock_cfg_7_0.value[7:0];
    phy_pcs_gen3_eie_lock_cfg_11_8: coverpoint phy_pcs_gen3_eie_lock_cfg_11_8.value[3:0];
    phy_pcs_gen3_eie_lock_cfg_15_12: coverpoint phy_pcs_gen3_eie_lock_cfg_15_12.value[3:0];
    phy_pcs_gen3_eie_lock_cfg_31_16: coverpoint phy_pcs_gen3_eie_lock_cfg_31_16.value[15:0];
  endgroup
  covergroup rd_fld_covg;
    phy_pcs_gen3_eie_lock_cfg_7_0: coverpoint phy_pcs_gen3_eie_lock_cfg_7_0.value[7:0];
    phy_pcs_gen3_eie_lock_cfg_11_8: coverpoint phy_pcs_gen3_eie_lock_cfg_11_8.value[3:0];
    phy_pcs_gen3_eie_lock_cfg_15_12: coverpoint phy_pcs_gen3_eie_lock_cfg_15_12.value[3:0];
    phy_pcs_gen3_eie_lock_cfg_31_16: coverpoint phy_pcs_gen3_eie_lock_cfg_31_16.value[15:0];
  endgroup

  protected virtual function void sample(uvm_reg_data_t data, uvm_reg_data_t byte_en, bit is_read, uvm_reg_map map);
    super.sample(data, byte_en, is_read, map);
    if (get_coverage(UVM_CVR_FIELD_VALS)) begin
      if(!is_read) begin
          wr_fld_covg.sample();
      end
      if(is_read) begin
         rd_fld_covg.sample();
      end
    end
  endfunction

  virtual function void sample_values();
    super.sample_values();
    if (get_coverage(UVM_CVR_FIELD_VALS)) begin
      wr_fld_covg.sample();
      rd_fld_covg.sample();
    end
  endfunction

  virtual function void build();
    uvm_reg_field fld_set[$];
    uvm_reg_field_config_ta ta = get_field_config(getconfigUID());
    build_uvm_reg_fields(this, ta, fld_set);
    
    phy_pcs_gen3_eie_lock_cfg_7_0 = fld_set[0];
    phy_pcs_gen3_eie_lock_cfg_11_8 = fld_set[1];
    phy_pcs_gen3_eie_lock_cfg_15_12 = fld_set[2];
    phy_pcs_gen3_eie_lock_cfg_31_16 = fld_set[3];
  endfunction

  function new(input string name="T_phy_pcs_gen3_eie_lock_cfg_203");
    super.new(name, 32, build_coverage(UVM_CVR_FIELD_VALS));
    if (has_coverage(UVM_CVR_FIELD_VALS)) begin
      wr_fld_covg = new();
      rd_fld_covg = new();
    end
  endfunction

endclass


/////////////////////////////////////////////////////
//                phy_pipe4_cmn_ctrl_reg
/////////////////////////////////////////////////////
class T_phy_pipe4_cmn_ctrl_reg_202 extends cdns_uvm_reg;

  `uvm_object_utils(T_phy_pipe4_cmn_ctrl_reg_202)
  rand uvm_reg_field phy_pipe4_cmn_ctrl_reg_0;
  rand uvm_reg_field phy_pipe4_cmn_ctrl_reg_1;
  rand uvm_reg_field phy_pipe4_cmn_ctrl_reg_2;
  rand uvm_reg_field phy_pipe4_cmn_ctrl_reg_3;
  rand uvm_reg_field phy_pipe4_cmn_ctrl_reg_4;
  rand uvm_reg_field phy_pipe4_cmn_ctrl_reg_5;
  rand uvm_reg_field phy_pipe4_cmn_ctrl_reg_6;
  rand uvm_reg_field phy_pipe4_cmn_ctrl_reg_7;
  rand uvm_reg_field phy_pipe4_cmn_ctrl_reg_11_8;
  rand uvm_reg_field phy_pipe4_cmn_ctrl_reg_15_12;
  rand uvm_reg_field phy_pipe4_cmn_ctrl_reg_17_16;
  rand uvm_reg_field phy_pipe4_cmn_ctrl_reg_18;
  rand uvm_reg_field phy_pipe4_cmn_ctrl_reg_19;
  rand uvm_reg_field phy_pipe4_cmn_ctrl_reg_20;
  rand uvm_reg_field phy_pipe4_cmn_ctrl_reg_21;
  rand uvm_reg_field phy_pipe4_cmn_ctrl_reg_22;
  rand uvm_reg_field phy_pipe4_cmn_ctrl_reg_31_23;
  
  covergroup wr_fld_covg;
    phy_pipe4_cmn_ctrl_reg_0: coverpoint phy_pipe4_cmn_ctrl_reg_0.value[0:0];
    phy_pipe4_cmn_ctrl_reg_1: coverpoint phy_pipe4_cmn_ctrl_reg_1.value[0:0];
    phy_pipe4_cmn_ctrl_reg_2: coverpoint phy_pipe4_cmn_ctrl_reg_2.value[0:0];
    phy_pipe4_cmn_ctrl_reg_3: coverpoint phy_pipe4_cmn_ctrl_reg_3.value[0:0];
    phy_pipe4_cmn_ctrl_reg_4: coverpoint phy_pipe4_cmn_ctrl_reg_4.value[0:0];
    phy_pipe4_cmn_ctrl_reg_5: coverpoint phy_pipe4_cmn_ctrl_reg_5.value[0:0];
    phy_pipe4_cmn_ctrl_reg_6: coverpoint phy_pipe4_cmn_ctrl_reg_6.value[0:0];
    phy_pipe4_cmn_ctrl_reg_7: coverpoint phy_pipe4_cmn_ctrl_reg_7.value[0:0];
    phy_pipe4_cmn_ctrl_reg_11_8: coverpoint phy_pipe4_cmn_ctrl_reg_11_8.value[3:0];
    phy_pipe4_cmn_ctrl_reg_15_12: coverpoint phy_pipe4_cmn_ctrl_reg_15_12.value[3:0];
    phy_pipe4_cmn_ctrl_reg_17_16: coverpoint phy_pipe4_cmn_ctrl_reg_17_16.value[1:0];
    phy_pipe4_cmn_ctrl_reg_18: coverpoint phy_pipe4_cmn_ctrl_reg_18.value[0:0];
    phy_pipe4_cmn_ctrl_reg_19: coverpoint phy_pipe4_cmn_ctrl_reg_19.value[0:0];
    phy_pipe4_cmn_ctrl_reg_20: coverpoint phy_pipe4_cmn_ctrl_reg_20.value[0:0];
    phy_pipe4_cmn_ctrl_reg_21: coverpoint phy_pipe4_cmn_ctrl_reg_21.value[0:0];
    phy_pipe4_cmn_ctrl_reg_22: coverpoint phy_pipe4_cmn_ctrl_reg_22.value[0:0];
    phy_pipe4_cmn_ctrl_reg_31_23: coverpoint phy_pipe4_cmn_ctrl_reg_31_23.value[8:0];
  endgroup
  covergroup rd_fld_covg;
    phy_pipe4_cmn_ctrl_reg_0: coverpoint phy_pipe4_cmn_ctrl_reg_0.value[0:0];
    phy_pipe4_cmn_ctrl_reg_1: coverpoint phy_pipe4_cmn_ctrl_reg_1.value[0:0];
    phy_pipe4_cmn_ctrl_reg_2: coverpoint phy_pipe4_cmn_ctrl_reg_2.value[0:0];
    phy_pipe4_cmn_ctrl_reg_3: coverpoint phy_pipe4_cmn_ctrl_reg_3.value[0:0];
    phy_pipe4_cmn_ctrl_reg_4: coverpoint phy_pipe4_cmn_ctrl_reg_4.value[0:0];
    phy_pipe4_cmn_ctrl_reg_5: coverpoint phy_pipe4_cmn_ctrl_reg_5.value[0:0];
    phy_pipe4_cmn_ctrl_reg_6: coverpoint phy_pipe4_cmn_ctrl_reg_6.value[0:0];
    phy_pipe4_cmn_ctrl_reg_7: coverpoint phy_pipe4_cmn_ctrl_reg_7.value[0:0];
    phy_pipe4_cmn_ctrl_reg_11_8: coverpoint phy_pipe4_cmn_ctrl_reg_11_8.value[3:0];
    phy_pipe4_cmn_ctrl_reg_15_12: coverpoint phy_pipe4_cmn_ctrl_reg_15_12.value[3:0];
    phy_pipe4_cmn_ctrl_reg_17_16: coverpoint phy_pipe4_cmn_ctrl_reg_17_16.value[1:0];
    phy_pipe4_cmn_ctrl_reg_18: coverpoint phy_pipe4_cmn_ctrl_reg_18.value[0:0];
    phy_pipe4_cmn_ctrl_reg_19: coverpoint phy_pipe4_cmn_ctrl_reg_19.value[0:0];
    phy_pipe4_cmn_ctrl_reg_20: coverpoint phy_pipe4_cmn_ctrl_reg_20.value[0:0];
    phy_pipe4_cmn_ctrl_reg_21: coverpoint phy_pipe4_cmn_ctrl_reg_21.value[0:0];
    phy_pipe4_cmn_ctrl_reg_22: coverpoint phy_pipe4_cmn_ctrl_reg_22.value[0:0];
    phy_pipe4_cmn_ctrl_reg_31_23: coverpoint phy_pipe4_cmn_ctrl_reg_31_23.value[8:0];
  endgroup

  protected virtual function void sample(uvm_reg_data_t data, uvm_reg_data_t byte_en, bit is_read, uvm_reg_map map);
    super.sample(data, byte_en, is_read, map);
    if (get_coverage(UVM_CVR_FIELD_VALS)) begin
      if(!is_read) begin
          wr_fld_covg.sample();
      end
      if(is_read) begin
         rd_fld_covg.sample();
      end
    end
  endfunction

  virtual function void sample_values();
    super.sample_values();
    if (get_coverage(UVM_CVR_FIELD_VALS)) begin
      wr_fld_covg.sample();
      rd_fld_covg.sample();
    end
  endfunction

  virtual function void build();
    uvm_reg_field fld_set[$];
    uvm_reg_field_config_ta ta = get_field_config(getconfigUID());
    build_uvm_reg_fields(this, ta, fld_set);
    
    phy_pipe4_cmn_ctrl_reg_0 = fld_set[0];
    phy_pipe4_cmn_ctrl_reg_1 = fld_set[1];
    phy_pipe4_cmn_ctrl_reg_2 = fld_set[2];
    phy_pipe4_cmn_ctrl_reg_3 = fld_set[3];
    phy_pipe4_cmn_ctrl_reg_4 = fld_set[4];
    phy_pipe4_cmn_ctrl_reg_5 = fld_set[5];
    phy_pipe4_cmn_ctrl_reg_6 = fld_set[6];
    phy_pipe4_cmn_ctrl_reg_7 = fld_set[7];
    phy_pipe4_cmn_ctrl_reg_11_8 = fld_set[8];
    phy_pipe4_cmn_ctrl_reg_15_12 = fld_set[9];
    phy_pipe4_cmn_ctrl_reg_17_16 = fld_set[10];
    phy_pipe4_cmn_ctrl_reg_18 = fld_set[11];
    phy_pipe4_cmn_ctrl_reg_19 = fld_set[12];
    phy_pipe4_cmn_ctrl_reg_20 = fld_set[13];
    phy_pipe4_cmn_ctrl_reg_21 = fld_set[14];
    phy_pipe4_cmn_ctrl_reg_22 = fld_set[15];
    phy_pipe4_cmn_ctrl_reg_31_23 = fld_set[16];
  endfunction

  function new(input string name="T_phy_pipe4_cmn_ctrl_reg_202");
    super.new(name, 32, build_coverage(UVM_CVR_FIELD_VALS));
    if (has_coverage(UVM_CVR_FIELD_VALS)) begin
      wr_fld_covg = new();
      rd_fld_covg = new();
    end
  endfunction

endclass


/////////////////////////////////////////////////////
//                phy_pipe_com_lock_cfg
/////////////////////////////////////////////////////
class T_phy_pipe_com_lock_cfg_216 extends cdns_uvm_reg;

  `uvm_object_utils(T_phy_pipe_com_lock_cfg_216)
  rand uvm_reg_field phy_pipe_com_lock_cfg_11_0;
  rand uvm_reg_field phy_pipe_com_lock_cfg_15_12;
  rand uvm_reg_field phy_pipe_com_lock_cfg_23_16;
  rand uvm_reg_field phy_pipe_com_lock_cfg_31_24;
  
  covergroup wr_fld_covg;
    phy_pipe_com_lock_cfg_11_0: coverpoint phy_pipe_com_lock_cfg_11_0.value[11:0];
    phy_pipe_com_lock_cfg_15_12: coverpoint phy_pipe_com_lock_cfg_15_12.value[3:0];
    phy_pipe_com_lock_cfg_23_16: coverpoint phy_pipe_com_lock_cfg_23_16.value[7:0];
    phy_pipe_com_lock_cfg_31_24: coverpoint phy_pipe_com_lock_cfg_31_24.value[7:0];
  endgroup
  covergroup rd_fld_covg;
    phy_pipe_com_lock_cfg_11_0: coverpoint phy_pipe_com_lock_cfg_11_0.value[11:0];
    phy_pipe_com_lock_cfg_15_12: coverpoint phy_pipe_com_lock_cfg_15_12.value[3:0];
    phy_pipe_com_lock_cfg_23_16: coverpoint phy_pipe_com_lock_cfg_23_16.value[7:0];
    phy_pipe_com_lock_cfg_31_24: coverpoint phy_pipe_com_lock_cfg_31_24.value[7:0];
  endgroup

  protected virtual function void sample(uvm_reg_data_t data, uvm_reg_data_t byte_en, bit is_read, uvm_reg_map map);
    super.sample(data, byte_en, is_read, map);
    if (get_coverage(UVM_CVR_FIELD_VALS)) begin
      if(!is_read) begin
          wr_fld_covg.sample();
      end
      if(is_read) begin
         rd_fld_covg.sample();
      end
    end
  endfunction

  virtual function void sample_values();
    super.sample_values();
    if (get_coverage(UVM_CVR_FIELD_VALS)) begin
      wr_fld_covg.sample();
      rd_fld_covg.sample();
    end
  endfunction

  virtual function void build();
    uvm_reg_field fld_set[$];
    uvm_reg_field_config_ta ta = get_field_config(getconfigUID());
    build_uvm_reg_fields(this, ta, fld_set);
    
    phy_pipe_com_lock_cfg_11_0 = fld_set[0];
    phy_pipe_com_lock_cfg_15_12 = fld_set[1];
    phy_pipe_com_lock_cfg_23_16 = fld_set[2];
    phy_pipe_com_lock_cfg_31_24 = fld_set[3];
  endfunction

  function new(input string name="T_phy_pipe_com_lock_cfg_216");
    super.new(name, 32, build_coverage(UVM_CVR_FIELD_VALS));
    if (has_coverage(UVM_CVR_FIELD_VALS)) begin
      wr_fld_covg = new();
      rd_fld_covg = new();
    end
  endfunction

endclass


/////////////////////////////////////////////////////
//                phy_pipe_lm_cfg0
/////////////////////////////////////////////////////
class T_phy_pipe_lm_cfg0_205 extends cdns_uvm_reg;

  `uvm_object_utils(T_phy_pipe_lm_cfg0_205)
  rand uvm_reg_field phy_pipe_lm_cfg0_7_0;
  rand uvm_reg_field phy_pipe_lm_cfg0_15_8;
  rand uvm_reg_field phy_pipe_lm_cfg0_21_16;
  rand uvm_reg_field phy_pipe_lm_cfg0_23_22;
  rand uvm_reg_field phy_pipe_lm_cfg0_27_24;
  rand uvm_reg_field phy_pipe_lm_cfg0_31_28;
  
  covergroup wr_fld_covg;
    phy_pipe_lm_cfg0_7_0: coverpoint phy_pipe_lm_cfg0_7_0.value[7:0];
    phy_pipe_lm_cfg0_15_8: coverpoint phy_pipe_lm_cfg0_15_8.value[7:0];
    phy_pipe_lm_cfg0_21_16: coverpoint phy_pipe_lm_cfg0_21_16.value[5:0];
    phy_pipe_lm_cfg0_23_22: coverpoint phy_pipe_lm_cfg0_23_22.value[1:0];
    phy_pipe_lm_cfg0_27_24: coverpoint phy_pipe_lm_cfg0_27_24.value[3:0];
    phy_pipe_lm_cfg0_31_28: coverpoint phy_pipe_lm_cfg0_31_28.value[3:0];
  endgroup
  covergroup rd_fld_covg;
    phy_pipe_lm_cfg0_7_0: coverpoint phy_pipe_lm_cfg0_7_0.value[7:0];
    phy_pipe_lm_cfg0_15_8: coverpoint phy_pipe_lm_cfg0_15_8.value[7:0];
    phy_pipe_lm_cfg0_21_16: coverpoint phy_pipe_lm_cfg0_21_16.value[5:0];
    phy_pipe_lm_cfg0_23_22: coverpoint phy_pipe_lm_cfg0_23_22.value[1:0];
    phy_pipe_lm_cfg0_27_24: coverpoint phy_pipe_lm_cfg0_27_24.value[3:0];
    phy_pipe_lm_cfg0_31_28: coverpoint phy_pipe_lm_cfg0_31_28.value[3:0];
  endgroup

  protected virtual function void sample(uvm_reg_data_t data, uvm_reg_data_t byte_en, bit is_read, uvm_reg_map map);
    super.sample(data, byte_en, is_read, map);
    if (get_coverage(UVM_CVR_FIELD_VALS)) begin
      if(!is_read) begin
          wr_fld_covg.sample();
      end
      if(is_read) begin
         rd_fld_covg.sample();
      end
    end
  endfunction

  virtual function void sample_values();
    super.sample_values();
    if (get_coverage(UVM_CVR_FIELD_VALS)) begin
      wr_fld_covg.sample();
      rd_fld_covg.sample();
    end
  endfunction

  virtual function void build();
    uvm_reg_field fld_set[$];
    uvm_reg_field_config_ta ta = get_field_config(getconfigUID());
    build_uvm_reg_fields(this, ta, fld_set);
    
    phy_pipe_lm_cfg0_7_0 = fld_set[0];
    phy_pipe_lm_cfg0_15_8 = fld_set[1];
    phy_pipe_lm_cfg0_21_16 = fld_set[2];
    phy_pipe_lm_cfg0_23_22 = fld_set[3];
    phy_pipe_lm_cfg0_27_24 = fld_set[4];
    phy_pipe_lm_cfg0_31_28 = fld_set[5];
  endfunction

  function new(input string name="T_phy_pipe_lm_cfg0_205");
    super.new(name, 32, build_coverage(UVM_CVR_FIELD_VALS));
    if (has_coverage(UVM_CVR_FIELD_VALS)) begin
      wr_fld_covg = new();
      rd_fld_covg = new();
    end
  endfunction

endclass


/////////////////////////////////////////////////////
//                phy_pipe_lm_cfg1
/////////////////////////////////////////////////////
class T_phy_pipe_lm_cfg1_206 extends cdns_uvm_reg;

  `uvm_object_utils(T_phy_pipe_lm_cfg1_206)
  rand uvm_reg_field phy_pipe_lm_cfg1_7_0;
  rand uvm_reg_field phy_pipe_lm_cfg1_15_8;
  rand uvm_reg_field phy_pipe_lm_cfg1_21_16;
  rand uvm_reg_field phy_pipe_lm_cfg1_23_22;
  rand uvm_reg_field phy_pipe_lm_cfg1_29_24;
  rand uvm_reg_field phy_pipe_lm_cfg1_31_30;
  
  covergroup wr_fld_covg;
    phy_pipe_lm_cfg1_7_0: coverpoint phy_pipe_lm_cfg1_7_0.value[7:0];
    phy_pipe_lm_cfg1_15_8: coverpoint phy_pipe_lm_cfg1_15_8.value[7:0];
    phy_pipe_lm_cfg1_21_16: coverpoint phy_pipe_lm_cfg1_21_16.value[5:0];
    phy_pipe_lm_cfg1_23_22: coverpoint phy_pipe_lm_cfg1_23_22.value[1:0];
    phy_pipe_lm_cfg1_29_24: coverpoint phy_pipe_lm_cfg1_29_24.value[5:0];
    phy_pipe_lm_cfg1_31_30: coverpoint phy_pipe_lm_cfg1_31_30.value[1:0];
  endgroup
  covergroup rd_fld_covg;
    phy_pipe_lm_cfg1_7_0: coverpoint phy_pipe_lm_cfg1_7_0.value[7:0];
    phy_pipe_lm_cfg1_15_8: coverpoint phy_pipe_lm_cfg1_15_8.value[7:0];
    phy_pipe_lm_cfg1_21_16: coverpoint phy_pipe_lm_cfg1_21_16.value[5:0];
    phy_pipe_lm_cfg1_23_22: coverpoint phy_pipe_lm_cfg1_23_22.value[1:0];
    phy_pipe_lm_cfg1_29_24: coverpoint phy_pipe_lm_cfg1_29_24.value[5:0];
    phy_pipe_lm_cfg1_31_30: coverpoint phy_pipe_lm_cfg1_31_30.value[1:0];
  endgroup

  protected virtual function void sample(uvm_reg_data_t data, uvm_reg_data_t byte_en, bit is_read, uvm_reg_map map);
    super.sample(data, byte_en, is_read, map);
    if (get_coverage(UVM_CVR_FIELD_VALS)) begin
      if(!is_read) begin
          wr_fld_covg.sample();
      end
      if(is_read) begin
         rd_fld_covg.sample();
      end
    end
  endfunction

  virtual function void sample_values();
    super.sample_values();
    if (get_coverage(UVM_CVR_FIELD_VALS)) begin
      wr_fld_covg.sample();
      rd_fld_covg.sample();
    end
  endfunction

  virtual function void build();
    uvm_reg_field fld_set[$];
    uvm_reg_field_config_ta ta = get_field_config(getconfigUID());
    build_uvm_reg_fields(this, ta, fld_set);
    
    phy_pipe_lm_cfg1_7_0 = fld_set[0];
    phy_pipe_lm_cfg1_15_8 = fld_set[1];
    phy_pipe_lm_cfg1_21_16 = fld_set[2];
    phy_pipe_lm_cfg1_23_22 = fld_set[3];
    phy_pipe_lm_cfg1_29_24 = fld_set[4];
    phy_pipe_lm_cfg1_31_30 = fld_set[5];
  endfunction

  function new(input string name="T_phy_pipe_lm_cfg1_206");
    super.new(name, 32, build_coverage(UVM_CVR_FIELD_VALS));
    if (has_coverage(UVM_CVR_FIELD_VALS)) begin
      wr_fld_covg = new();
      rd_fld_covg = new();
    end
  endfunction

endclass


/////////////////////////////////////////////////////
//                phy_pipe_lm_cfg2
/////////////////////////////////////////////////////
class T_phy_pipe_lm_cfg2_207 extends cdns_uvm_reg;

  `uvm_object_utils(T_phy_pipe_lm_cfg2_207)
  rand uvm_reg_field phy_pipe_lm_cfg2_5_0;
  rand uvm_reg_field phy_pipe_lm_cfg2_7_6;
  rand uvm_reg_field phy_pipe_lm_cfg2_14_8;
  rand uvm_reg_field phy_pipe_lm_cfg2_31_15;
  
  covergroup wr_fld_covg;
    phy_pipe_lm_cfg2_5_0: coverpoint phy_pipe_lm_cfg2_5_0.value[5:0];
    phy_pipe_lm_cfg2_7_6: coverpoint phy_pipe_lm_cfg2_7_6.value[1:0];
    phy_pipe_lm_cfg2_14_8: coverpoint phy_pipe_lm_cfg2_14_8.value[6:0];
    phy_pipe_lm_cfg2_31_15: coverpoint phy_pipe_lm_cfg2_31_15.value[16:0];
  endgroup
  covergroup rd_fld_covg;
    phy_pipe_lm_cfg2_5_0: coverpoint phy_pipe_lm_cfg2_5_0.value[5:0];
    phy_pipe_lm_cfg2_7_6: coverpoint phy_pipe_lm_cfg2_7_6.value[1:0];
    phy_pipe_lm_cfg2_14_8: coverpoint phy_pipe_lm_cfg2_14_8.value[6:0];
    phy_pipe_lm_cfg2_31_15: coverpoint phy_pipe_lm_cfg2_31_15.value[16:0];
  endgroup

  protected virtual function void sample(uvm_reg_data_t data, uvm_reg_data_t byte_en, bit is_read, uvm_reg_map map);
    super.sample(data, byte_en, is_read, map);
    if (get_coverage(UVM_CVR_FIELD_VALS)) begin
      if(!is_read) begin
          wr_fld_covg.sample();
      end
      if(is_read) begin
         rd_fld_covg.sample();
      end
    end
  endfunction

  virtual function void sample_values();
    super.sample_values();
    if (get_coverage(UVM_CVR_FIELD_VALS)) begin
      wr_fld_covg.sample();
      rd_fld_covg.sample();
    end
  endfunction

  virtual function void build();
    uvm_reg_field fld_set[$];
    uvm_reg_field_config_ta ta = get_field_config(getconfigUID());
    build_uvm_reg_fields(this, ta, fld_set);
    
    phy_pipe_lm_cfg2_5_0 = fld_set[0];
    phy_pipe_lm_cfg2_7_6 = fld_set[1];
    phy_pipe_lm_cfg2_14_8 = fld_set[2];
    phy_pipe_lm_cfg2_31_15 = fld_set[3];
  endfunction

  function new(input string name="T_phy_pipe_lm_cfg2_207");
    super.new(name, 32, build_coverage(UVM_CVR_FIELD_VALS));
    if (has_coverage(UVM_CVR_FIELD_VALS)) begin
      wr_fld_covg = new();
      rd_fld_covg = new();
    end
  endfunction

endclass


/////////////////////////////////////////////////////
//                phy_pipe_usb3_gen2_post_cfg
/////////////////////////////////////////////////////
class T_phy_pipe_usb3_gen2_post_cfg_218 extends cdns_uvm_reg;

  `uvm_object_utils(T_phy_pipe_usb3_gen2_post_cfg_218)
  rand uvm_reg_field phy_pipe_usb3_gen2_post_cfg_7_0;
  rand uvm_reg_field phy_pipe_usb3_gen2_post_cfg_15_8;
  rand uvm_reg_field phy_pipe_usb3_gen2_post_cfg_23_16;
  rand uvm_reg_field phy_pipe_usb3_gen2_post_cfg_31_24;
  
  covergroup wr_fld_covg;
    phy_pipe_usb3_gen2_post_cfg_7_0: coverpoint phy_pipe_usb3_gen2_post_cfg_7_0.value[7:0];
    phy_pipe_usb3_gen2_post_cfg_15_8: coverpoint phy_pipe_usb3_gen2_post_cfg_15_8.value[7:0];
    phy_pipe_usb3_gen2_post_cfg_23_16: coverpoint phy_pipe_usb3_gen2_post_cfg_23_16.value[7:0];
    phy_pipe_usb3_gen2_post_cfg_31_24: coverpoint phy_pipe_usb3_gen2_post_cfg_31_24.value[7:0];
  endgroup
  covergroup rd_fld_covg;
    phy_pipe_usb3_gen2_post_cfg_7_0: coverpoint phy_pipe_usb3_gen2_post_cfg_7_0.value[7:0];
    phy_pipe_usb3_gen2_post_cfg_15_8: coverpoint phy_pipe_usb3_gen2_post_cfg_15_8.value[7:0];
    phy_pipe_usb3_gen2_post_cfg_23_16: coverpoint phy_pipe_usb3_gen2_post_cfg_23_16.value[7:0];
    phy_pipe_usb3_gen2_post_cfg_31_24: coverpoint phy_pipe_usb3_gen2_post_cfg_31_24.value[7:0];
  endgroup

  protected virtual function void sample(uvm_reg_data_t data, uvm_reg_data_t byte_en, bit is_read, uvm_reg_map map);
    super.sample(data, byte_en, is_read, map);
    if (get_coverage(UVM_CVR_FIELD_VALS)) begin
      if(!is_read) begin
          wr_fld_covg.sample();
      end
      if(is_read) begin
         rd_fld_covg.sample();
      end
    end
  endfunction

  virtual function void sample_values();
    super.sample_values();
    if (get_coverage(UVM_CVR_FIELD_VALS)) begin
      wr_fld_covg.sample();
      rd_fld_covg.sample();
    end
  endfunction

  virtual function void build();
    uvm_reg_field fld_set[$];
    uvm_reg_field_config_ta ta = get_field_config(getconfigUID());
    build_uvm_reg_fields(this, ta, fld_set);
    
    phy_pipe_usb3_gen2_post_cfg_7_0 = fld_set[0];
    phy_pipe_usb3_gen2_post_cfg_15_8 = fld_set[1];
    phy_pipe_usb3_gen2_post_cfg_23_16 = fld_set[2];
    phy_pipe_usb3_gen2_post_cfg_31_24 = fld_set[3];
  endfunction

  function new(input string name="T_phy_pipe_usb3_gen2_post_cfg_218");
    super.new(name, 32, build_coverage(UVM_CVR_FIELD_VALS));
    if (has_coverage(UVM_CVR_FIELD_VALS)) begin
      wr_fld_covg = new();
      rd_fld_covg = new();
    end
  endfunction

endclass


/////////////////////////////////////////////////////
//                phy_pipe_usb3_gen2_pre_cfg
/////////////////////////////////////////////////////
class T_phy_pipe_usb3_gen2_pre_cfg_217 extends cdns_uvm_reg;

  `uvm_object_utils(T_phy_pipe_usb3_gen2_pre_cfg_217)
  rand uvm_reg_field phy_pipe_usb3_gen2_pre_cfg_7_0;
  rand uvm_reg_field phy_pipe_usb3_gen2_pre_cfg_15_8;
  rand uvm_reg_field phy_pipe_usb3_gen2_pre_cfg_23_16;
  rand uvm_reg_field phy_pipe_usb3_gen2_pre_cfg_31_24;
  
  covergroup wr_fld_covg;
    phy_pipe_usb3_gen2_pre_cfg_7_0: coverpoint phy_pipe_usb3_gen2_pre_cfg_7_0.value[7:0];
    phy_pipe_usb3_gen2_pre_cfg_15_8: coverpoint phy_pipe_usb3_gen2_pre_cfg_15_8.value[7:0];
    phy_pipe_usb3_gen2_pre_cfg_23_16: coverpoint phy_pipe_usb3_gen2_pre_cfg_23_16.value[7:0];
    phy_pipe_usb3_gen2_pre_cfg_31_24: coverpoint phy_pipe_usb3_gen2_pre_cfg_31_24.value[7:0];
  endgroup
  covergroup rd_fld_covg;
    phy_pipe_usb3_gen2_pre_cfg_7_0: coverpoint phy_pipe_usb3_gen2_pre_cfg_7_0.value[7:0];
    phy_pipe_usb3_gen2_pre_cfg_15_8: coverpoint phy_pipe_usb3_gen2_pre_cfg_15_8.value[7:0];
    phy_pipe_usb3_gen2_pre_cfg_23_16: coverpoint phy_pipe_usb3_gen2_pre_cfg_23_16.value[7:0];
    phy_pipe_usb3_gen2_pre_cfg_31_24: coverpoint phy_pipe_usb3_gen2_pre_cfg_31_24.value[7:0];
  endgroup

  protected virtual function void sample(uvm_reg_data_t data, uvm_reg_data_t byte_en, bit is_read, uvm_reg_map map);
    super.sample(data, byte_en, is_read, map);
    if (get_coverage(UVM_CVR_FIELD_VALS)) begin
      if(!is_read) begin
          wr_fld_covg.sample();
      end
      if(is_read) begin
         rd_fld_covg.sample();
      end
    end
  endfunction

  virtual function void sample_values();
    super.sample_values();
    if (get_coverage(UVM_CVR_FIELD_VALS)) begin
      wr_fld_covg.sample();
      rd_fld_covg.sample();
    end
  endfunction

  virtual function void build();
    uvm_reg_field fld_set[$];
    uvm_reg_field_config_ta ta = get_field_config(getconfigUID());
    build_uvm_reg_fields(this, ta, fld_set);
    
    phy_pipe_usb3_gen2_pre_cfg_7_0 = fld_set[0];
    phy_pipe_usb3_gen2_pre_cfg_15_8 = fld_set[1];
    phy_pipe_usb3_gen2_pre_cfg_23_16 = fld_set[2];
    phy_pipe_usb3_gen2_pre_cfg_31_24 = fld_set[3];
  endfunction

  function new(input string name="T_phy_pipe_usb3_gen2_pre_cfg_217");
    super.new(name, 32, build_coverage(UVM_CVR_FIELD_VALS));
    if (has_coverage(UVM_CVR_FIELD_VALS)) begin
      wr_fld_covg = new();
      rd_fld_covg = new();
    end
  endfunction

endclass


/////////////////////////////////////////////////////
//                phy_pma_lane_map
/////////////////////////////////////////////////////
class T_phy_pma_lane_map_219 extends cdns_uvm_reg;

  `uvm_object_utils(T_phy_pma_lane_map_219)
  rand uvm_reg_field phy_pma_lane_map_0;
  rand uvm_reg_field phy_pma_lane_map_1;
  rand uvm_reg_field phy_pma_lane_map_3_2;
  rand uvm_reg_field phy_pma_lane_map_4;
  rand uvm_reg_field phy_pma_lane_map_5;
  rand uvm_reg_field phy_pma_lane_map_7_6;
  rand uvm_reg_field phy_pma_lane_map_8;
  rand uvm_reg_field phy_pma_lane_map_9;
  rand uvm_reg_field phy_pma_lane_map_11_10;
  rand uvm_reg_field phy_pma_lane_map_12;
  rand uvm_reg_field phy_pma_lane_map_13;
  rand uvm_reg_field phy_pma_lane_map_15_14;
  rand uvm_reg_field phy_pma_lane_map_31_16;
  
  covergroup wr_fld_covg;
    phy_pma_lane_map_0: coverpoint phy_pma_lane_map_0.value[0:0];
    phy_pma_lane_map_1: coverpoint phy_pma_lane_map_1.value[0:0];
    phy_pma_lane_map_3_2: coverpoint phy_pma_lane_map_3_2.value[1:0];
    phy_pma_lane_map_4: coverpoint phy_pma_lane_map_4.value[0:0];
    phy_pma_lane_map_5: coverpoint phy_pma_lane_map_5.value[0:0];
    phy_pma_lane_map_7_6: coverpoint phy_pma_lane_map_7_6.value[1:0];
    phy_pma_lane_map_8: coverpoint phy_pma_lane_map_8.value[0:0];
    phy_pma_lane_map_9: coverpoint phy_pma_lane_map_9.value[0:0];
    phy_pma_lane_map_11_10: coverpoint phy_pma_lane_map_11_10.value[1:0];
    phy_pma_lane_map_12: coverpoint phy_pma_lane_map_12.value[0:0];
    phy_pma_lane_map_13: coverpoint phy_pma_lane_map_13.value[0:0];
    phy_pma_lane_map_15_14: coverpoint phy_pma_lane_map_15_14.value[1:0];
    phy_pma_lane_map_31_16: coverpoint phy_pma_lane_map_31_16.value[15:0];
  endgroup
  covergroup rd_fld_covg;
    phy_pma_lane_map_0: coverpoint phy_pma_lane_map_0.value[0:0];
    phy_pma_lane_map_1: coverpoint phy_pma_lane_map_1.value[0:0];
    phy_pma_lane_map_3_2: coverpoint phy_pma_lane_map_3_2.value[1:0];
    phy_pma_lane_map_4: coverpoint phy_pma_lane_map_4.value[0:0];
    phy_pma_lane_map_5: coverpoint phy_pma_lane_map_5.value[0:0];
    phy_pma_lane_map_7_6: coverpoint phy_pma_lane_map_7_6.value[1:0];
    phy_pma_lane_map_8: coverpoint phy_pma_lane_map_8.value[0:0];
    phy_pma_lane_map_9: coverpoint phy_pma_lane_map_9.value[0:0];
    phy_pma_lane_map_11_10: coverpoint phy_pma_lane_map_11_10.value[1:0];
    phy_pma_lane_map_12: coverpoint phy_pma_lane_map_12.value[0:0];
    phy_pma_lane_map_13: coverpoint phy_pma_lane_map_13.value[0:0];
    phy_pma_lane_map_15_14: coverpoint phy_pma_lane_map_15_14.value[1:0];
    phy_pma_lane_map_31_16: coverpoint phy_pma_lane_map_31_16.value[15:0];
  endgroup

  protected virtual function void sample(uvm_reg_data_t data, uvm_reg_data_t byte_en, bit is_read, uvm_reg_map map);
    super.sample(data, byte_en, is_read, map);
    if (get_coverage(UVM_CVR_FIELD_VALS)) begin
      if(!is_read) begin
          wr_fld_covg.sample();
      end
      if(is_read) begin
         rd_fld_covg.sample();
      end
    end
  endfunction

  virtual function void sample_values();
    super.sample_values();
    if (get_coverage(UVM_CVR_FIELD_VALS)) begin
      wr_fld_covg.sample();
      rd_fld_covg.sample();
    end
  endfunction

  virtual function void build();
    uvm_reg_field fld_set[$];
    uvm_reg_field_config_ta ta = get_field_config(getconfigUID());
    build_uvm_reg_fields(this, ta, fld_set);
    
    phy_pma_lane_map_0 = fld_set[0];
    phy_pma_lane_map_1 = fld_set[1];
    phy_pma_lane_map_3_2 = fld_set[2];
    phy_pma_lane_map_4 = fld_set[3];
    phy_pma_lane_map_5 = fld_set[4];
    phy_pma_lane_map_7_6 = fld_set[5];
    phy_pma_lane_map_8 = fld_set[6];
    phy_pma_lane_map_9 = fld_set[7];
    phy_pma_lane_map_11_10 = fld_set[8];
    phy_pma_lane_map_12 = fld_set[9];
    phy_pma_lane_map_13 = fld_set[10];
    phy_pma_lane_map_15_14 = fld_set[11];
    phy_pma_lane_map_31_16 = fld_set[12];
  endfunction

  function new(input string name="T_phy_pma_lane_map_219");
    super.new(name, 32, build_coverage(UVM_CVR_FIELD_VALS));
    if (has_coverage(UVM_CVR_FIELD_VALS)) begin
      wr_fld_covg = new();
      rd_fld_covg = new();
    end
  endfunction

endclass


/////////////////////////////////////////////////////
//                phy_spdup_cfg_ctrl
/////////////////////////////////////////////////////
class T_phy_spdup_cfg_ctrl_214 extends cdns_uvm_reg;

  `uvm_object_utils(T_phy_spdup_cfg_ctrl_214)
  rand uvm_reg_field phy_spdup_cfg_ctrl_0;
  rand uvm_reg_field phy_spdup_cfg_ctrl_1;
  rand uvm_reg_field phy_spdup_cfg_ctrl_2;
  rand uvm_reg_field phy_spdup_cfg_ctrl_3;
  rand uvm_reg_field phy_spdup_cfg_ctrl_31_4;
  
  covergroup wr_fld_covg;
    phy_spdup_cfg_ctrl_0: coverpoint phy_spdup_cfg_ctrl_0.value[0:0];
    phy_spdup_cfg_ctrl_1: coverpoint phy_spdup_cfg_ctrl_1.value[0:0];
    phy_spdup_cfg_ctrl_2: coverpoint phy_spdup_cfg_ctrl_2.value[0:0];
    phy_spdup_cfg_ctrl_3: coverpoint phy_spdup_cfg_ctrl_3.value[0:0];
    phy_spdup_cfg_ctrl_31_4: coverpoint phy_spdup_cfg_ctrl_31_4.value[27:0];
  endgroup
  covergroup rd_fld_covg;
    phy_spdup_cfg_ctrl_0: coverpoint phy_spdup_cfg_ctrl_0.value[0:0];
    phy_spdup_cfg_ctrl_1: coverpoint phy_spdup_cfg_ctrl_1.value[0:0];
    phy_spdup_cfg_ctrl_2: coverpoint phy_spdup_cfg_ctrl_2.value[0:0];
    phy_spdup_cfg_ctrl_3: coverpoint phy_spdup_cfg_ctrl_3.value[0:0];
    phy_spdup_cfg_ctrl_31_4: coverpoint phy_spdup_cfg_ctrl_31_4.value[27:0];
  endgroup

  protected virtual function void sample(uvm_reg_data_t data, uvm_reg_data_t byte_en, bit is_read, uvm_reg_map map);
    super.sample(data, byte_en, is_read, map);
    if (get_coverage(UVM_CVR_FIELD_VALS)) begin
      if(!is_read) begin
          wr_fld_covg.sample();
      end
      if(is_read) begin
         rd_fld_covg.sample();
      end
    end
  endfunction

  virtual function void sample_values();
    super.sample_values();
    if (get_coverage(UVM_CVR_FIELD_VALS)) begin
      wr_fld_covg.sample();
      rd_fld_covg.sample();
    end
  endfunction

  virtual function void build();
    uvm_reg_field fld_set[$];
    uvm_reg_field_config_ta ta = get_field_config(getconfigUID());
    build_uvm_reg_fields(this, ta, fld_set);
    
    phy_spdup_cfg_ctrl_0 = fld_set[0];
    phy_spdup_cfg_ctrl_1 = fld_set[1];
    phy_spdup_cfg_ctrl_2 = fld_set[2];
    phy_spdup_cfg_ctrl_3 = fld_set[3];
    phy_spdup_cfg_ctrl_31_4 = fld_set[4];
  endfunction

  function new(input string name="T_phy_spdup_cfg_ctrl_214");
    super.new(name, 32, build_coverage(UVM_CVR_FIELD_VALS));
    if (has_coverage(UVM_CVR_FIELD_VALS)) begin
      wr_fld_covg = new();
      rd_fld_covg = new();
    end
  endfunction

endclass


/////////////////////////////////////////////////////
//                phy_timeout_cfg
/////////////////////////////////////////////////////
class T_phy_timeout_cfg_208 extends cdns_uvm_reg;

  `uvm_object_utils(T_phy_timeout_cfg_208)
  rand uvm_reg_field phy_timeout_cfg_9_0;
  rand uvm_reg_field phy_timeout_cfg_15_10;
  rand uvm_reg_field phy_timeout_cfg_31_16;
  
  covergroup wr_fld_covg;
    phy_timeout_cfg_9_0: coverpoint phy_timeout_cfg_9_0.value[9:0];
    phy_timeout_cfg_15_10: coverpoint phy_timeout_cfg_15_10.value[5:0];
    phy_timeout_cfg_31_16: coverpoint phy_timeout_cfg_31_16.value[15:0];
  endgroup
  covergroup rd_fld_covg;
    phy_timeout_cfg_9_0: coverpoint phy_timeout_cfg_9_0.value[9:0];
    phy_timeout_cfg_15_10: coverpoint phy_timeout_cfg_15_10.value[5:0];
    phy_timeout_cfg_31_16: coverpoint phy_timeout_cfg_31_16.value[15:0];
  endgroup

  protected virtual function void sample(uvm_reg_data_t data, uvm_reg_data_t byte_en, bit is_read, uvm_reg_map map);
    super.sample(data, byte_en, is_read, map);
    if (get_coverage(UVM_CVR_FIELD_VALS)) begin
      if(!is_read) begin
          wr_fld_covg.sample();
      end
      if(is_read) begin
         rd_fld_covg.sample();
      end
    end
  endfunction

  virtual function void sample_values();
    super.sample_values();
    if (get_coverage(UVM_CVR_FIELD_VALS)) begin
      wr_fld_covg.sample();
      rd_fld_covg.sample();
    end
  endfunction

  virtual function void build();
    uvm_reg_field fld_set[$];
    uvm_reg_field_config_ta ta = get_field_config(getconfigUID());
    build_uvm_reg_fields(this, ta, fld_set);
    
    phy_timeout_cfg_9_0 = fld_set[0];
    phy_timeout_cfg_15_10 = fld_set[1];
    phy_timeout_cfg_31_16 = fld_set[2];
  endfunction

  function new(input string name="T_phy_timeout_cfg_208");
    super.new(name, 32, build_coverage(UVM_CVR_FIELD_VALS));
    if (has_coverage(UVM_CVR_FIELD_VALS)) begin
      wr_fld_covg = new();
      rd_fld_covg = new();
    end
  endfunction

endclass


/////////////////////////////////////////////////////
//                phy_usb_interrupt_sts
/////////////////////////////////////////////////////
class T_phy_usb_interrupt_sts_222 extends cdns_uvm_reg;

  `uvm_object_utils(T_phy_usb_interrupt_sts_222)
  rand uvm_reg_field phy_usb_interrupt_sts_0;
  rand uvm_reg_field phy_usb_interrupt_sts_1;
  rand uvm_reg_field phy_usb_interrupt_sts_3_2;
  rand uvm_reg_field phy_usb_interrupt_sts_6_4;
  rand uvm_reg_field phy_usb_interrupt_sts_7;
  rand uvm_reg_field phy_usb_interrupt_sts_10_8;
  rand uvm_reg_field phy_usb_interrupt_sts_14_11;
  rand uvm_reg_field phy_usb_interrupt_sts_15;
  rand uvm_reg_field phy_usb_interrupt_sts_31_16;
  
  covergroup wr_fld_covg;
    phy_usb_interrupt_sts_0: coverpoint phy_usb_interrupt_sts_0.value[0:0];
    phy_usb_interrupt_sts_1: coverpoint phy_usb_interrupt_sts_1.value[0:0];
    phy_usb_interrupt_sts_3_2: coverpoint phy_usb_interrupt_sts_3_2.value[1:0];
    phy_usb_interrupt_sts_6_4: coverpoint phy_usb_interrupt_sts_6_4.value[2:0];
    phy_usb_interrupt_sts_7: coverpoint phy_usb_interrupt_sts_7.value[0:0];
    phy_usb_interrupt_sts_10_8: coverpoint phy_usb_interrupt_sts_10_8.value[2:0];
    phy_usb_interrupt_sts_14_11: coverpoint phy_usb_interrupt_sts_14_11.value[3:0];
    phy_usb_interrupt_sts_15: coverpoint phy_usb_interrupt_sts_15.value[0:0];
    phy_usb_interrupt_sts_31_16: coverpoint phy_usb_interrupt_sts_31_16.value[15:0];
  endgroup
  covergroup rd_fld_covg;
    phy_usb_interrupt_sts_0: coverpoint phy_usb_interrupt_sts_0.value[0:0];
    phy_usb_interrupt_sts_1: coverpoint phy_usb_interrupt_sts_1.value[0:0];
    phy_usb_interrupt_sts_3_2: coverpoint phy_usb_interrupt_sts_3_2.value[1:0];
    phy_usb_interrupt_sts_6_4: coverpoint phy_usb_interrupt_sts_6_4.value[2:0];
    phy_usb_interrupt_sts_7: coverpoint phy_usb_interrupt_sts_7.value[0:0];
    phy_usb_interrupt_sts_10_8: coverpoint phy_usb_interrupt_sts_10_8.value[2:0];
    phy_usb_interrupt_sts_14_11: coverpoint phy_usb_interrupt_sts_14_11.value[3:0];
    phy_usb_interrupt_sts_15: coverpoint phy_usb_interrupt_sts_15.value[0:0];
    phy_usb_interrupt_sts_31_16: coverpoint phy_usb_interrupt_sts_31_16.value[15:0];
  endgroup

  protected virtual function void sample(uvm_reg_data_t data, uvm_reg_data_t byte_en, bit is_read, uvm_reg_map map);
    super.sample(data, byte_en, is_read, map);
    if (get_coverage(UVM_CVR_FIELD_VALS)) begin
      if(!is_read) begin
          wr_fld_covg.sample();
      end
      if(is_read) begin
         rd_fld_covg.sample();
      end
    end
  endfunction

  virtual function void sample_values();
    super.sample_values();
    if (get_coverage(UVM_CVR_FIELD_VALS)) begin
      wr_fld_covg.sample();
      rd_fld_covg.sample();
    end
  endfunction

  virtual function void build();
    uvm_reg_field fld_set[$];
    uvm_reg_field_config_ta ta = get_field_config(getconfigUID());
    build_uvm_reg_fields(this, ta, fld_set);
    
    phy_usb_interrupt_sts_0 = fld_set[0];
    phy_usb_interrupt_sts_1 = fld_set[1];
    phy_usb_interrupt_sts_3_2 = fld_set[2];
    phy_usb_interrupt_sts_6_4 = fld_set[3];
    phy_usb_interrupt_sts_7 = fld_set[4];
    phy_usb_interrupt_sts_10_8 = fld_set[5];
    phy_usb_interrupt_sts_14_11 = fld_set[6];
    phy_usb_interrupt_sts_15 = fld_set[7];
    phy_usb_interrupt_sts_31_16 = fld_set[8];
  endfunction

  function new(input string name="T_phy_usb_interrupt_sts_222");
    super.new(name, 32, build_coverage(UVM_CVR_FIELD_VALS));
    if (has_coverage(UVM_CVR_FIELD_VALS)) begin
      wr_fld_covg = new();
      rd_fld_covg = new();
    end
  endfunction

endclass


/////////////////////////////////////////////////////
//                phy_version
/////////////////////////////////////////////////////
class T_phy_version_211 extends cdns_uvm_reg;

  `uvm_object_utils(T_phy_version_211)
  rand uvm_reg_field phy_version_7_0;
  rand uvm_reg_field phy_version_15_8;
  rand uvm_reg_field phy_version_31_16;
  
  covergroup wr_fld_covg;
    phy_version_7_0: coverpoint phy_version_7_0.value[7:0];
    phy_version_15_8: coverpoint phy_version_15_8.value[7:0];
    phy_version_31_16: coverpoint phy_version_31_16.value[15:0];
  endgroup
  covergroup rd_fld_covg;
    phy_version_7_0: coverpoint phy_version_7_0.value[7:0];
    phy_version_15_8: coverpoint phy_version_15_8.value[7:0];
    phy_version_31_16: coverpoint phy_version_31_16.value[15:0];
  endgroup

  protected virtual function void sample(uvm_reg_data_t data, uvm_reg_data_t byte_en, bit is_read, uvm_reg_map map);
    super.sample(data, byte_en, is_read, map);
    if (get_coverage(UVM_CVR_FIELD_VALS)) begin
      if(!is_read) begin
          wr_fld_covg.sample();
      end
      if(is_read) begin
         rd_fld_covg.sample();
      end
    end
  endfunction

  virtual function void sample_values();
    super.sample_values();
    if (get_coverage(UVM_CVR_FIELD_VALS)) begin
      wr_fld_covg.sample();
      rd_fld_covg.sample();
    end
  endfunction

  virtual function void build();
    uvm_reg_field fld_set[$];
    uvm_reg_field_config_ta ta = get_field_config(getconfigUID());
    build_uvm_reg_fields(this, ta, fld_set);
    
    phy_version_7_0 = fld_set[0];
    phy_version_15_8 = fld_set[1];
    phy_version_31_16 = fld_set[2];
  endfunction

  function new(input string name="T_phy_version_211");
    super.new(name, 32, build_coverage(UVM_CVR_FIELD_VALS));
    if (has_coverage(UVM_CVR_FIELD_VALS)) begin
      wr_fld_covg = new();
      rd_fld_covg = new();
    end
  endfunction

endclass


/////////////////////////////////////////////////////
//                uc_top_ctrl
/////////////////////////////////////////////////////
class T_uc_top_ctrl_226 extends cdns_uvm_reg;

  `uvm_object_utils(T_uc_top_ctrl_226)
  rand uvm_reg_field uc_top_ctrl_0;
  rand uvm_reg_field uc_top_ctrl_1;
  rand uvm_reg_field uc_top_ctrl_2;
  rand uvm_reg_field uc_top_ctrl_3;
  rand uvm_reg_field uc_top_ctrl_4;
  rand uvm_reg_field uc_top_ctrl_5;
  rand uvm_reg_field uc_top_ctrl_6;
  rand uvm_reg_field uc_top_ctrl_7;
  rand uvm_reg_field uc_top_ctrl_8;
  rand uvm_reg_field uc_top_ctrl_9;
  rand uvm_reg_field uc_top_ctrl_10;
  rand uvm_reg_field uc_top_ctrl_11;
  rand uvm_reg_field uc_top_ctrl_14_12;
  rand uvm_reg_field uc_top_ctrl_19_15;
  rand uvm_reg_field uc_top_ctrl_20;
  rand uvm_reg_field uc_top_ctrl_21;
  rand uvm_reg_field uc_top_ctrl_23_22;
  rand uvm_reg_field uc_top_ctrl_27_24;
  rand uvm_reg_field uc_top_ctrl_31_28;
  
  covergroup wr_fld_covg;
    uc_top_ctrl_0: coverpoint uc_top_ctrl_0.value[0:0];
    uc_top_ctrl_1: coverpoint uc_top_ctrl_1.value[0:0];
    uc_top_ctrl_2: coverpoint uc_top_ctrl_2.value[0:0];
    uc_top_ctrl_3: coverpoint uc_top_ctrl_3.value[0:0];
    uc_top_ctrl_4: coverpoint uc_top_ctrl_4.value[0:0];
    uc_top_ctrl_5: coverpoint uc_top_ctrl_5.value[0:0];
    uc_top_ctrl_6: coverpoint uc_top_ctrl_6.value[0:0];
    uc_top_ctrl_7: coverpoint uc_top_ctrl_7.value[0:0];
    uc_top_ctrl_8: coverpoint uc_top_ctrl_8.value[0:0];
    uc_top_ctrl_9: coverpoint uc_top_ctrl_9.value[0:0];
    uc_top_ctrl_10: coverpoint uc_top_ctrl_10.value[0:0];
    uc_top_ctrl_11: coverpoint uc_top_ctrl_11.value[0:0];
    uc_top_ctrl_14_12: coverpoint uc_top_ctrl_14_12.value[2:0];
    uc_top_ctrl_19_15: coverpoint uc_top_ctrl_19_15.value[4:0];
    uc_top_ctrl_20: coverpoint uc_top_ctrl_20.value[0:0];
    uc_top_ctrl_21: coverpoint uc_top_ctrl_21.value[0:0];
    uc_top_ctrl_23_22: coverpoint uc_top_ctrl_23_22.value[1:0];
    uc_top_ctrl_27_24: coverpoint uc_top_ctrl_27_24.value[3:0];
    uc_top_ctrl_31_28: coverpoint uc_top_ctrl_31_28.value[3:0];
  endgroup
  covergroup rd_fld_covg;
    uc_top_ctrl_0: coverpoint uc_top_ctrl_0.value[0:0];
    uc_top_ctrl_1: coverpoint uc_top_ctrl_1.value[0:0];
    uc_top_ctrl_2: coverpoint uc_top_ctrl_2.value[0:0];
    uc_top_ctrl_3: coverpoint uc_top_ctrl_3.value[0:0];
    uc_top_ctrl_4: coverpoint uc_top_ctrl_4.value[0:0];
    uc_top_ctrl_5: coverpoint uc_top_ctrl_5.value[0:0];
    uc_top_ctrl_6: coverpoint uc_top_ctrl_6.value[0:0];
    uc_top_ctrl_7: coverpoint uc_top_ctrl_7.value[0:0];
    uc_top_ctrl_8: coverpoint uc_top_ctrl_8.value[0:0];
    uc_top_ctrl_9: coverpoint uc_top_ctrl_9.value[0:0];
    uc_top_ctrl_10: coverpoint uc_top_ctrl_10.value[0:0];
    uc_top_ctrl_11: coverpoint uc_top_ctrl_11.value[0:0];
    uc_top_ctrl_14_12: coverpoint uc_top_ctrl_14_12.value[2:0];
    uc_top_ctrl_19_15: coverpoint uc_top_ctrl_19_15.value[4:0];
    uc_top_ctrl_20: coverpoint uc_top_ctrl_20.value[0:0];
    uc_top_ctrl_21: coverpoint uc_top_ctrl_21.value[0:0];
    uc_top_ctrl_23_22: coverpoint uc_top_ctrl_23_22.value[1:0];
    uc_top_ctrl_27_24: coverpoint uc_top_ctrl_27_24.value[3:0];
    uc_top_ctrl_31_28: coverpoint uc_top_ctrl_31_28.value[3:0];
  endgroup

  protected virtual function void sample(uvm_reg_data_t data, uvm_reg_data_t byte_en, bit is_read, uvm_reg_map map);
    super.sample(data, byte_en, is_read, map);
    if (get_coverage(UVM_CVR_FIELD_VALS)) begin
      if(!is_read) begin
          wr_fld_covg.sample();
      end
      if(is_read) begin
         rd_fld_covg.sample();
      end
    end
  endfunction

  virtual function void sample_values();
    super.sample_values();
    if (get_coverage(UVM_CVR_FIELD_VALS)) begin
      wr_fld_covg.sample();
      rd_fld_covg.sample();
    end
  endfunction

  virtual function void build();
    uvm_reg_field fld_set[$];
    uvm_reg_field_config_ta ta = get_field_config(getconfigUID());
    build_uvm_reg_fields(this, ta, fld_set);
    
    uc_top_ctrl_0 = fld_set[0];
    uc_top_ctrl_1 = fld_set[1];
    uc_top_ctrl_2 = fld_set[2];
    uc_top_ctrl_3 = fld_set[3];
    uc_top_ctrl_4 = fld_set[4];
    uc_top_ctrl_5 = fld_set[5];
    uc_top_ctrl_6 = fld_set[6];
    uc_top_ctrl_7 = fld_set[7];
    uc_top_ctrl_8 = fld_set[8];
    uc_top_ctrl_9 = fld_set[9];
    uc_top_ctrl_10 = fld_set[10];
    uc_top_ctrl_11 = fld_set[11];
    uc_top_ctrl_14_12 = fld_set[12];
    uc_top_ctrl_19_15 = fld_set[13];
    uc_top_ctrl_20 = fld_set[14];
    uc_top_ctrl_21 = fld_set[15];
    uc_top_ctrl_23_22 = fld_set[16];
    uc_top_ctrl_27_24 = fld_set[17];
    uc_top_ctrl_31_28 = fld_set[18];
  endfunction

  function new(input string name="T_uc_top_ctrl_226");
    super.new(name, 32, build_coverage(UVM_CVR_FIELD_VALS));
    if (has_coverage(UVM_CVR_FIELD_VALS)) begin
      wr_fld_covg = new();
      rd_fld_covg = new();
    end
  endfunction

endclass


/////////////////////////////////////////////////////
//                uc_top_scrpad0
/////////////////////////////////////////////////////
class T_uc_top_scrpad0_228 extends cdns_uvm_reg;

  `uvm_object_utils(T_uc_top_scrpad0_228)
  rand uvm_reg_field uc_top_scrpad0_31_0;
  
  covergroup wr_fld_covg;
    uc_top_scrpad0_31_0: coverpoint uc_top_scrpad0_31_0.value[31:0];
  endgroup
  covergroup rd_fld_covg;
    uc_top_scrpad0_31_0: coverpoint uc_top_scrpad0_31_0.value[31:0];
  endgroup

  protected virtual function void sample(uvm_reg_data_t data, uvm_reg_data_t byte_en, bit is_read, uvm_reg_map map);
    super.sample(data, byte_en, is_read, map);
    if (get_coverage(UVM_CVR_FIELD_VALS)) begin
      if(!is_read) begin
          wr_fld_covg.sample();
      end
      if(is_read) begin
         rd_fld_covg.sample();
      end
    end
  endfunction

  virtual function void sample_values();
    super.sample_values();
    if (get_coverage(UVM_CVR_FIELD_VALS)) begin
      wr_fld_covg.sample();
      rd_fld_covg.sample();
    end
  endfunction

  virtual function void build();
    uvm_reg_field fld_set[$];
    uvm_reg_field_config_ta ta = get_field_config(getconfigUID());
    build_uvm_reg_fields(this, ta, fld_set);
    
    uc_top_scrpad0_31_0 = fld_set[0];
  endfunction

  function new(input string name="T_uc_top_scrpad0_228");
    super.new(name, 32, build_coverage(UVM_CVR_FIELD_VALS));
    if (has_coverage(UVM_CVR_FIELD_VALS)) begin
      wr_fld_covg = new();
      rd_fld_covg = new();
    end
  endfunction

endclass


/////////////////////////////////////////////////////
//                uc_top_scrpad1
/////////////////////////////////////////////////////
class T_uc_top_scrpad1_229 extends cdns_uvm_reg;

  `uvm_object_utils(T_uc_top_scrpad1_229)
  rand uvm_reg_field uc_top_scrpad1_31_0;
  
  covergroup wr_fld_covg;
    uc_top_scrpad1_31_0: coverpoint uc_top_scrpad1_31_0.value[31:0];
  endgroup
  covergroup rd_fld_covg;
    uc_top_scrpad1_31_0: coverpoint uc_top_scrpad1_31_0.value[31:0];
  endgroup

  protected virtual function void sample(uvm_reg_data_t data, uvm_reg_data_t byte_en, bit is_read, uvm_reg_map map);
    super.sample(data, byte_en, is_read, map);
    if (get_coverage(UVM_CVR_FIELD_VALS)) begin
      if(!is_read) begin
          wr_fld_covg.sample();
      end
      if(is_read) begin
         rd_fld_covg.sample();
      end
    end
  endfunction

  virtual function void sample_values();
    super.sample_values();
    if (get_coverage(UVM_CVR_FIELD_VALS)) begin
      wr_fld_covg.sample();
      rd_fld_covg.sample();
    end
  endfunction

  virtual function void build();
    uvm_reg_field fld_set[$];
    uvm_reg_field_config_ta ta = get_field_config(getconfigUID());
    build_uvm_reg_fields(this, ta, fld_set);
    
    uc_top_scrpad1_31_0 = fld_set[0];
  endfunction

  function new(input string name="T_uc_top_scrpad1_229");
    super.new(name, 32, build_coverage(UVM_CVR_FIELD_VALS));
    if (has_coverage(UVM_CVR_FIELD_VALS)) begin
      wr_fld_covg = new();
      rd_fld_covg = new();
    end
  endfunction

endclass


/////////////////////////////////////////////////////
//                uc_top_scrpad15
/////////////////////////////////////////////////////
class T_uc_top_scrpad15_225 extends cdns_uvm_reg;

  `uvm_object_utils(T_uc_top_scrpad15_225)
  rand uvm_reg_field uc_top_scrpad15_31_0;
  
  covergroup wr_fld_covg;
    uc_top_scrpad15_31_0: coverpoint uc_top_scrpad15_31_0.value[31:0];
  endgroup
  covergroup rd_fld_covg;
    uc_top_scrpad15_31_0: coverpoint uc_top_scrpad15_31_0.value[31:0];
  endgroup

  protected virtual function void sample(uvm_reg_data_t data, uvm_reg_data_t byte_en, bit is_read, uvm_reg_map map);
    super.sample(data, byte_en, is_read, map);
    if (get_coverage(UVM_CVR_FIELD_VALS)) begin
      if(!is_read) begin
          wr_fld_covg.sample();
      end
      if(is_read) begin
         rd_fld_covg.sample();
      end
    end
  endfunction

  virtual function void sample_values();
    super.sample_values();
    if (get_coverage(UVM_CVR_FIELD_VALS)) begin
      wr_fld_covg.sample();
      rd_fld_covg.sample();
    end
  endfunction

  virtual function void build();
    uvm_reg_field fld_set[$];
    uvm_reg_field_config_ta ta = get_field_config(getconfigUID());
    build_uvm_reg_fields(this, ta, fld_set);
    
    uc_top_scrpad15_31_0 = fld_set[0];
  endfunction

  function new(input string name="T_uc_top_scrpad15_225");
    super.new(name, 32, build_coverage(UVM_CVR_FIELD_VALS));
    if (has_coverage(UVM_CVR_FIELD_VALS)) begin
      wr_fld_covg = new();
      rd_fld_covg = new();
    end
  endfunction

endclass


/////////////////////////////////////////////////////
//                uc_top_scrpad2
/////////////////////////////////////////////////////
class T_uc_top_scrpad2_230 extends cdns_uvm_reg;

  `uvm_object_utils(T_uc_top_scrpad2_230)
  rand uvm_reg_field uc_top_scrpad2_31_0;
  
  covergroup wr_fld_covg;
    uc_top_scrpad2_31_0: coverpoint uc_top_scrpad2_31_0.value[31:0];
  endgroup
  covergroup rd_fld_covg;
    uc_top_scrpad2_31_0: coverpoint uc_top_scrpad2_31_0.value[31:0];
  endgroup

  protected virtual function void sample(uvm_reg_data_t data, uvm_reg_data_t byte_en, bit is_read, uvm_reg_map map);
    super.sample(data, byte_en, is_read, map);
    if (get_coverage(UVM_CVR_FIELD_VALS)) begin
      if(!is_read) begin
          wr_fld_covg.sample();
      end
      if(is_read) begin
         rd_fld_covg.sample();
      end
    end
  endfunction

  virtual function void sample_values();
    super.sample_values();
    if (get_coverage(UVM_CVR_FIELD_VALS)) begin
      wr_fld_covg.sample();
      rd_fld_covg.sample();
    end
  endfunction

  virtual function void build();
    uvm_reg_field fld_set[$];
    uvm_reg_field_config_ta ta = get_field_config(getconfigUID());
    build_uvm_reg_fields(this, ta, fld_set);
    
    uc_top_scrpad2_31_0 = fld_set[0];
  endfunction

  function new(input string name="T_uc_top_scrpad2_230");
    super.new(name, 32, build_coverage(UVM_CVR_FIELD_VALS));
    if (has_coverage(UVM_CVR_FIELD_VALS)) begin
      wr_fld_covg = new();
      rd_fld_covg = new();
    end
  endfunction

endclass


/////////////////////////////////////////////////////
//                uc_top_scrpad3
/////////////////////////////////////////////////////
class T_uc_top_scrpad3_231 extends cdns_uvm_reg;

  `uvm_object_utils(T_uc_top_scrpad3_231)
  rand uvm_reg_field uc_top_scrpad3_31_0;
  
  covergroup wr_fld_covg;
    uc_top_scrpad3_31_0: coverpoint uc_top_scrpad3_31_0.value[31:0];
  endgroup
  covergroup rd_fld_covg;
    uc_top_scrpad3_31_0: coverpoint uc_top_scrpad3_31_0.value[31:0];
  endgroup

  protected virtual function void sample(uvm_reg_data_t data, uvm_reg_data_t byte_en, bit is_read, uvm_reg_map map);
    super.sample(data, byte_en, is_read, map);
    if (get_coverage(UVM_CVR_FIELD_VALS)) begin
      if(!is_read) begin
          wr_fld_covg.sample();
      end
      if(is_read) begin
         rd_fld_covg.sample();
      end
    end
  endfunction

  virtual function void sample_values();
    super.sample_values();
    if (get_coverage(UVM_CVR_FIELD_VALS)) begin
      wr_fld_covg.sample();
      rd_fld_covg.sample();
    end
  endfunction

  virtual function void build();
    uvm_reg_field fld_set[$];
    uvm_reg_field_config_ta ta = get_field_config(getconfigUID());
    build_uvm_reg_fields(this, ta, fld_set);
    
    uc_top_scrpad3_31_0 = fld_set[0];
  endfunction

  function new(input string name="T_uc_top_scrpad3_231");
    super.new(name, 32, build_coverage(UVM_CVR_FIELD_VALS));
    if (has_coverage(UVM_CVR_FIELD_VALS)) begin
      wr_fld_covg = new();
      rd_fld_covg = new();
    end
  endfunction

endclass


/////////////////////////////////////////////////////
//                uc_top_scrpad4
/////////////////////////////////////////////////////
class T_uc_top_scrpad4_232 extends cdns_uvm_reg;

  `uvm_object_utils(T_uc_top_scrpad4_232)
  rand uvm_reg_field uc_top_scrpad4_31_0;
  
  covergroup wr_fld_covg;
    uc_top_scrpad4_31_0: coverpoint uc_top_scrpad4_31_0.value[31:0];
  endgroup
  covergroup rd_fld_covg;
    uc_top_scrpad4_31_0: coverpoint uc_top_scrpad4_31_0.value[31:0];
  endgroup

  protected virtual function void sample(uvm_reg_data_t data, uvm_reg_data_t byte_en, bit is_read, uvm_reg_map map);
    super.sample(data, byte_en, is_read, map);
    if (get_coverage(UVM_CVR_FIELD_VALS)) begin
      if(!is_read) begin
          wr_fld_covg.sample();
      end
      if(is_read) begin
         rd_fld_covg.sample();
      end
    end
  endfunction

  virtual function void sample_values();
    super.sample_values();
    if (get_coverage(UVM_CVR_FIELD_VALS)) begin
      wr_fld_covg.sample();
      rd_fld_covg.sample();
    end
  endfunction

  virtual function void build();
    uvm_reg_field fld_set[$];
    uvm_reg_field_config_ta ta = get_field_config(getconfigUID());
    build_uvm_reg_fields(this, ta, fld_set);
    
    uc_top_scrpad4_31_0 = fld_set[0];
  endfunction

  function new(input string name="T_uc_top_scrpad4_232");
    super.new(name, 32, build_coverage(UVM_CVR_FIELD_VALS));
    if (has_coverage(UVM_CVR_FIELD_VALS)) begin
      wr_fld_covg = new();
      rd_fld_covg = new();
    end
  endfunction

endclass


/////////////////////////////////////////////////////
//                uc_top_scrpad5
/////////////////////////////////////////////////////
class T_uc_top_scrpad5_233 extends cdns_uvm_reg;

  `uvm_object_utils(T_uc_top_scrpad5_233)
  rand uvm_reg_field uc_top_scrpad5_31_0;
  
  covergroup wr_fld_covg;
    uc_top_scrpad5_31_0: coverpoint uc_top_scrpad5_31_0.value[31:0];
  endgroup
  covergroup rd_fld_covg;
    uc_top_scrpad5_31_0: coverpoint uc_top_scrpad5_31_0.value[31:0];
  endgroup

  protected virtual function void sample(uvm_reg_data_t data, uvm_reg_data_t byte_en, bit is_read, uvm_reg_map map);
    super.sample(data, byte_en, is_read, map);
    if (get_coverage(UVM_CVR_FIELD_VALS)) begin
      if(!is_read) begin
          wr_fld_covg.sample();
      end
      if(is_read) begin
         rd_fld_covg.sample();
      end
    end
  endfunction

  virtual function void sample_values();
    super.sample_values();
    if (get_coverage(UVM_CVR_FIELD_VALS)) begin
      wr_fld_covg.sample();
      rd_fld_covg.sample();
    end
  endfunction

  virtual function void build();
    uvm_reg_field fld_set[$];
    uvm_reg_field_config_ta ta = get_field_config(getconfigUID());
    build_uvm_reg_fields(this, ta, fld_set);
    
    uc_top_scrpad5_31_0 = fld_set[0];
  endfunction

  function new(input string name="T_uc_top_scrpad5_233");
    super.new(name, 32, build_coverage(UVM_CVR_FIELD_VALS));
    if (has_coverage(UVM_CVR_FIELD_VALS)) begin
      wr_fld_covg = new();
      rd_fld_covg = new();
    end
  endfunction

endclass


/////////////////////////////////////////////////////
//                uc_top_scrpad6
/////////////////////////////////////////////////////
class T_uc_top_scrpad6_234 extends cdns_uvm_reg;

  `uvm_object_utils(T_uc_top_scrpad6_234)
  rand uvm_reg_field uc_top_scrpad6_31_0;
  
  covergroup wr_fld_covg;
    uc_top_scrpad6_31_0: coverpoint uc_top_scrpad6_31_0.value[31:0];
  endgroup
  covergroup rd_fld_covg;
    uc_top_scrpad6_31_0: coverpoint uc_top_scrpad6_31_0.value[31:0];
  endgroup

  protected virtual function void sample(uvm_reg_data_t data, uvm_reg_data_t byte_en, bit is_read, uvm_reg_map map);
    super.sample(data, byte_en, is_read, map);
    if (get_coverage(UVM_CVR_FIELD_VALS)) begin
      if(!is_read) begin
          wr_fld_covg.sample();
      end
      if(is_read) begin
         rd_fld_covg.sample();
      end
    end
  endfunction

  virtual function void sample_values();
    super.sample_values();
    if (get_coverage(UVM_CVR_FIELD_VALS)) begin
      wr_fld_covg.sample();
      rd_fld_covg.sample();
    end
  endfunction

  virtual function void build();
    uvm_reg_field fld_set[$];
    uvm_reg_field_config_ta ta = get_field_config(getconfigUID());
    build_uvm_reg_fields(this, ta, fld_set);
    
    uc_top_scrpad6_31_0 = fld_set[0];
  endfunction

  function new(input string name="T_uc_top_scrpad6_234");
    super.new(name, 32, build_coverage(UVM_CVR_FIELD_VALS));
    if (has_coverage(UVM_CVR_FIELD_VALS)) begin
      wr_fld_covg = new();
      rd_fld_covg = new();
    end
  endfunction

endclass


/////////////////////////////////////////////////////
//                uc_top_scrpad7
/////////////////////////////////////////////////////
class T_uc_top_scrpad7_235 extends cdns_uvm_reg;

  `uvm_object_utils(T_uc_top_scrpad7_235)
  rand uvm_reg_field uc_top_scrpad7_31_0;
  
  covergroup wr_fld_covg;
    uc_top_scrpad7_31_0: coverpoint uc_top_scrpad7_31_0.value[31:0];
  endgroup
  covergroup rd_fld_covg;
    uc_top_scrpad7_31_0: coverpoint uc_top_scrpad7_31_0.value[31:0];
  endgroup

  protected virtual function void sample(uvm_reg_data_t data, uvm_reg_data_t byte_en, bit is_read, uvm_reg_map map);
    super.sample(data, byte_en, is_read, map);
    if (get_coverage(UVM_CVR_FIELD_VALS)) begin
      if(!is_read) begin
          wr_fld_covg.sample();
      end
      if(is_read) begin
         rd_fld_covg.sample();
      end
    end
  endfunction

  virtual function void sample_values();
    super.sample_values();
    if (get_coverage(UVM_CVR_FIELD_VALS)) begin
      wr_fld_covg.sample();
      rd_fld_covg.sample();
    end
  endfunction

  virtual function void build();
    uvm_reg_field fld_set[$];
    uvm_reg_field_config_ta ta = get_field_config(getconfigUID());
    build_uvm_reg_fields(this, ta, fld_set);
    
    uc_top_scrpad7_31_0 = fld_set[0];
  endfunction

  function new(input string name="T_uc_top_scrpad7_235");
    super.new(name, 32, build_coverage(UVM_CVR_FIELD_VALS));
    if (has_coverage(UVM_CVR_FIELD_VALS)) begin
      wr_fld_covg = new();
      rd_fld_covg = new();
    end
  endfunction

endclass


/////////////////////////////////////////////////////
//                uc_top_sram_access
/////////////////////////////////////////////////////
class T_uc_top_sram_access_237 extends cdns_uvm_reg;

  `uvm_object_utils(T_uc_top_sram_access_237)
  rand uvm_reg_field uc_top_sram_access_31_0;
  
  covergroup wr_fld_covg;
    uc_top_sram_access_31_0: coverpoint uc_top_sram_access_31_0.value[31:0];
  endgroup
  covergroup rd_fld_covg;
    uc_top_sram_access_31_0: coverpoint uc_top_sram_access_31_0.value[31:0];
  endgroup

  protected virtual function void sample(uvm_reg_data_t data, uvm_reg_data_t byte_en, bit is_read, uvm_reg_map map);
    super.sample(data, byte_en, is_read, map);
    if (get_coverage(UVM_CVR_FIELD_VALS)) begin
      if(!is_read) begin
          wr_fld_covg.sample();
      end
      if(is_read) begin
         rd_fld_covg.sample();
      end
    end
  endfunction

  virtual function void sample_values();
    super.sample_values();
    if (get_coverage(UVM_CVR_FIELD_VALS)) begin
      wr_fld_covg.sample();
      rd_fld_covg.sample();
    end
  endfunction

  virtual function void build();
    uvm_reg_field fld_set[$];
    uvm_reg_field_config_ta ta = get_field_config(getconfigUID());
    build_uvm_reg_fields(this, ta, fld_set);
    
    uc_top_sram_access_31_0 = fld_set[0];
  endfunction

  function new(input string name="T_uc_top_sram_access_237");
    super.new(name, 32, build_coverage(UVM_CVR_FIELD_VALS));
    if (has_coverage(UVM_CVR_FIELD_VALS)) begin
      wr_fld_covg = new();
      rd_fld_covg = new();
    end
  endfunction

endclass


/////////////////////////////////////////////////////
//                uc_top_sram_addr
/////////////////////////////////////////////////////
class T_uc_top_sram_addr_227 extends cdns_uvm_reg;

  `uvm_object_utils(T_uc_top_sram_addr_227)
  rand uvm_reg_field uc_top_sram_addr_15_0;
  rand uvm_reg_field uc_top_sram_addr_31_16;
  
  covergroup wr_fld_covg;
    uc_top_sram_addr_15_0: coverpoint uc_top_sram_addr_15_0.value[15:0];
    uc_top_sram_addr_31_16: coverpoint uc_top_sram_addr_31_16.value[15:0];
  endgroup
  covergroup rd_fld_covg;
    uc_top_sram_addr_15_0: coverpoint uc_top_sram_addr_15_0.value[15:0];
    uc_top_sram_addr_31_16: coverpoint uc_top_sram_addr_31_16.value[15:0];
  endgroup

  protected virtual function void sample(uvm_reg_data_t data, uvm_reg_data_t byte_en, bit is_read, uvm_reg_map map);
    super.sample(data, byte_en, is_read, map);
    if (get_coverage(UVM_CVR_FIELD_VALS)) begin
      if(!is_read) begin
          wr_fld_covg.sample();
      end
      if(is_read) begin
         rd_fld_covg.sample();
      end
    end
  endfunction

  virtual function void sample_values();
    super.sample_values();
    if (get_coverage(UVM_CVR_FIELD_VALS)) begin
      wr_fld_covg.sample();
      rd_fld_covg.sample();
    end
  endfunction

  virtual function void build();
    uvm_reg_field fld_set[$];
    uvm_reg_field_config_ta ta = get_field_config(getconfigUID());
    build_uvm_reg_fields(this, ta, fld_set);
    
    uc_top_sram_addr_15_0 = fld_set[0];
    uc_top_sram_addr_31_16 = fld_set[1];
  endfunction

  function new(input string name="T_uc_top_sram_addr_227");
    super.new(name, 32, build_coverage(UVM_CVR_FIELD_VALS));
    if (has_coverage(UVM_CVR_FIELD_VALS)) begin
      wr_fld_covg = new();
      rd_fld_covg = new();
    end
  endfunction

endclass


/////////////////////////////////////////////////////
//                sd3101_t4_registers_sd3101_phy_registers
/////////////////////////////////////////////////////
class T_sd3101_phy_registers_238 extends cdns_uvm_reg_block;

  `uvm_object_utils(T_sd3101_phy_registers_238)
  rand T_phy_apb_mstr_addr_236 phy_apb_mstr_addr;
  rand T_phy_ctrl_209 phy_ctrl;
  rand T_phy_ctrl_set_210 phy_ctrl_set;
  rand T_phy_dp_interrupt_sts_221 phy_dp_interrupt_sts;
  rand T_phy_interrupt_sts_usb4_l0_reg_223 phy_interrupt_sts_usb4_l0_reg;
  rand T_phy_interrupt_sts_usb4_l1_reg_224 phy_interrupt_sts_usb4_l1_reg;
  rand T_phy_iso_cmn_ctrl_215 phy_iso_cmn_ctrl;
  rand T_phy_iso_cmn_ctrl1_reg_212 phy_iso_cmn_ctrl1_reg;
  rand T_phy_iso_cmn_ctrl2_reg_213 phy_iso_cmn_ctrl2_reg;
  rand T_phy_lane_off_ctl_220 phy_lane_off_ctl;
  rand T_phy_lane_reset_204 phy_lane_reset;
  rand T_phy_pcs_gen3_eie_lock_cfg_203 phy_pcs_gen3_eie_lock_cfg;
  rand T_phy_pipe4_cmn_ctrl_reg_202 phy_pipe4_cmn_ctrl_reg;
  rand T_phy_pipe_com_lock_cfg_216 phy_pipe_com_lock_cfg;
  rand T_phy_pipe_lm_cfg0_205 phy_pipe_lm_cfg0;
  rand T_phy_pipe_lm_cfg1_206 phy_pipe_lm_cfg1;
  rand T_phy_pipe_lm_cfg2_207 phy_pipe_lm_cfg2;
  rand T_phy_pipe_usb3_gen2_post_cfg_218 phy_pipe_usb3_gen2_post_cfg;
  rand T_phy_pipe_usb3_gen2_pre_cfg_217 phy_pipe_usb3_gen2_pre_cfg;
  rand T_phy_pma_lane_map_219 phy_pma_lane_map;
  rand T_phy_spdup_cfg_ctrl_214 phy_spdup_cfg_ctrl;
  rand T_phy_timeout_cfg_208 phy_timeout_cfg;
  rand T_phy_usb_interrupt_sts_222 phy_usb_interrupt_sts;
  rand T_phy_version_211 phy_version;
  rand T_uc_top_ctrl_226 uc_top_ctrl;
  rand T_uc_top_scrpad0_228 uc_top_scrpad0;
  rand T_uc_top_scrpad1_229 uc_top_scrpad1;
  rand T_uc_top_scrpad15_225 uc_top_scrpad15;
  rand T_uc_top_scrpad2_230 uc_top_scrpad2;
  rand T_uc_top_scrpad3_231 uc_top_scrpad3;
  rand T_uc_top_scrpad4_232 uc_top_scrpad4;
  rand T_uc_top_scrpad5_233 uc_top_scrpad5;
  rand T_uc_top_scrpad6_234 uc_top_scrpad6;
  rand T_uc_top_scrpad7_235 uc_top_scrpad7;
  rand T_uc_top_sram_access_237 uc_top_sram_access;
  rand T_uc_top_sram_addr_227 uc_top_sram_addr;



  virtual function void build();
    uvm_reg  reg_set[$];
    string config_path = get_hier_path();
    default_map = create_map(get_name(), `UVM_REG_ADDR_WIDTH'h30000, 4, UVM_LITTLE_ENDIAN, 1);
    begin
       uvm_reg_config_ta ta = get_reg_config("phy_pcs_cmn_registers.sd3101_t4_registers_sd3101_phy_registers");
       build_uvm_regs(default_map, this, null, ta, reg_set);
    end
    if(! $cast(phy_apb_mstr_addr, reg_set[0]))
      `uvm_error("UVM_REG", "phy_apb_mstr_addr register casting error")
    if(! $cast(phy_ctrl, reg_set[1]))
      `uvm_error("UVM_REG", "phy_ctrl register casting error")
    if(! $cast(phy_ctrl_set, reg_set[2]))
      `uvm_error("UVM_REG", "phy_ctrl_set register casting error")
    if(! $cast(phy_dp_interrupt_sts, reg_set[3]))
      `uvm_error("UVM_REG", "phy_dp_interrupt_sts register casting error")
    if(! $cast(phy_interrupt_sts_usb4_l0_reg, reg_set[4]))
      `uvm_error("UVM_REG", "phy_interrupt_sts_usb4_l0_reg register casting error")
    if(! $cast(phy_interrupt_sts_usb4_l1_reg, reg_set[5]))
      `uvm_error("UVM_REG", "phy_interrupt_sts_usb4_l1_reg register casting error")
    if(! $cast(phy_iso_cmn_ctrl, reg_set[6]))
      `uvm_error("UVM_REG", "phy_iso_cmn_ctrl register casting error")
    if(! $cast(phy_iso_cmn_ctrl1_reg, reg_set[7]))
      `uvm_error("UVM_REG", "phy_iso_cmn_ctrl1_reg register casting error")
    if(! $cast(phy_iso_cmn_ctrl2_reg, reg_set[8]))
      `uvm_error("UVM_REG", "phy_iso_cmn_ctrl2_reg register casting error")
    if(! $cast(phy_lane_off_ctl, reg_set[9]))
      `uvm_error("UVM_REG", "phy_lane_off_ctl register casting error")
    if(! $cast(phy_lane_reset, reg_set[10]))
      `uvm_error("UVM_REG", "phy_lane_reset register casting error")
    if(! $cast(phy_pcs_gen3_eie_lock_cfg, reg_set[11]))
      `uvm_error("UVM_REG", "phy_pcs_gen3_eie_lock_cfg register casting error")
    if(! $cast(phy_pipe4_cmn_ctrl_reg, reg_set[12]))
      `uvm_error("UVM_REG", "phy_pipe4_cmn_ctrl_reg register casting error")
    if(! $cast(phy_pipe_com_lock_cfg, reg_set[13]))
      `uvm_error("UVM_REG", "phy_pipe_com_lock_cfg register casting error")
    if(! $cast(phy_pipe_lm_cfg0, reg_set[14]))
      `uvm_error("UVM_REG", "phy_pipe_lm_cfg0 register casting error")
    if(! $cast(phy_pipe_lm_cfg1, reg_set[15]))
      `uvm_error("UVM_REG", "phy_pipe_lm_cfg1 register casting error")
    if(! $cast(phy_pipe_lm_cfg2, reg_set[16]))
      `uvm_error("UVM_REG", "phy_pipe_lm_cfg2 register casting error")
    if(! $cast(phy_pipe_usb3_gen2_post_cfg, reg_set[17]))
      `uvm_error("UVM_REG", "phy_pipe_usb3_gen2_post_cfg register casting error")
    if(! $cast(phy_pipe_usb3_gen2_pre_cfg, reg_set[18]))
      `uvm_error("UVM_REG", "phy_pipe_usb3_gen2_pre_cfg register casting error")
    if(! $cast(phy_pma_lane_map, reg_set[19]))
      `uvm_error("UVM_REG", "phy_pma_lane_map register casting error")
    if(! $cast(phy_spdup_cfg_ctrl, reg_set[20]))
      `uvm_error("UVM_REG", "phy_spdup_cfg_ctrl register casting error")
    if(! $cast(phy_timeout_cfg, reg_set[21]))
      `uvm_error("UVM_REG", "phy_timeout_cfg register casting error")
    if(! $cast(phy_usb_interrupt_sts, reg_set[22]))
      `uvm_error("UVM_REG", "phy_usb_interrupt_sts register casting error")
    if(! $cast(phy_version, reg_set[23]))
      `uvm_error("UVM_REG", "phy_version register casting error")
    if(! $cast(uc_top_ctrl, reg_set[24]))
      `uvm_error("UVM_REG", "uc_top_ctrl register casting error")
    if(! $cast(uc_top_scrpad0, reg_set[25]))
      `uvm_error("UVM_REG", "uc_top_scrpad0 register casting error")
    if(! $cast(uc_top_scrpad1, reg_set[26]))
      `uvm_error("UVM_REG", "uc_top_scrpad1 register casting error")
    if(! $cast(uc_top_scrpad15, reg_set[27]))
      `uvm_error("UVM_REG", "uc_top_scrpad15 register casting error")
    if(! $cast(uc_top_scrpad2, reg_set[28]))
      `uvm_error("UVM_REG", "uc_top_scrpad2 register casting error")
    if(! $cast(uc_top_scrpad3, reg_set[29]))
      `uvm_error("UVM_REG", "uc_top_scrpad3 register casting error")
    if(! $cast(uc_top_scrpad4, reg_set[30]))
      `uvm_error("UVM_REG", "uc_top_scrpad4 register casting error")
    if(! $cast(uc_top_scrpad5, reg_set[31]))
      `uvm_error("UVM_REG", "uc_top_scrpad5 register casting error")
    if(! $cast(uc_top_scrpad6, reg_set[32]))
      `uvm_error("UVM_REG", "uc_top_scrpad6 register casting error")
    if(! $cast(uc_top_scrpad7, reg_set[33]))
      `uvm_error("UVM_REG", "uc_top_scrpad7 register casting error")
    if(! $cast(uc_top_sram_access, reg_set[34]))
      `uvm_error("UVM_REG", "uc_top_sram_access register casting error")
    if(! $cast(uc_top_sram_addr, reg_set[35]))
      `uvm_error("UVM_REG", "uc_top_sram_addr register casting error")

  endfunction

  function new(input string name="sd3101_t4_registers_sd3101_phy_registers");
    super.new(name, UVM_NO_COVERAGE);
  endfunction

endclass


/////////////////////////////////////////////////////
//                phy_pcs_cmn_registers
/////////////////////////////////////////////////////
class phy_pcs_cmn_registers_vendor_cadence_library_cdns_lib_version_1685_2009 extends cdns_uvm_reg_block;

  `uvm_object_utils(phy_pcs_cmn_registers_vendor_cadence_library_cdns_lib_version_1685_2009)

  uvm_reg_map default_map;
  uvm_reg_map sd3101_t4_registers;
  rand T_sd3101_phy_registers_238 sd3101_t4_registers_sd3101_phy_registers;

`include "cdn_regmodel_task_member.sv"
  virtual function void build();
    sd3101_t4_registers = create_map("sd3101_t4_registers", `UVM_REG_ADDR_WIDTH'h0, 4, UVM_LITTLE_ENDIAN, 1);
    default_map = sd3101_t4_registers;
    sd3101_t4_registers_sd3101_phy_registers = T_sd3101_phy_registers_238::type_id::create("sd3101_t4_registers_sd3101_phy_registers", , get_full_name());
    sd3101_t4_registers_sd3101_phy_registers.configure(this);
    sd3101_t4_registers_sd3101_phy_registers.build();

    //Mapping sd3101_t4_registers map
    sd3101_t4_registers_sd3101_phy_registers.default_map.add_parent_map(sd3101_t4_registers,`UVM_REG_ADDR_WIDTH'h30000);
    sd3101_t4_registers.set_submap_offset(sd3101_t4_registers_sd3101_phy_registers.default_map, `UVM_REG_ADDR_WIDTH'h30000);
    //Apply hdl_paths
    apply_hdl_paths(this);

  endfunction



  function new(input string name="phy_pcs_cmn_registers");
    super.new(name, UVM_NO_COVERAGE);
  endfunction

`include "cdn_regmodel_task.sv"
endclass


//*************************************************//
//Factory Methods
//*************************************************//
class reg_verifier_factory extends cdns_factory_base;
   virtual function uvm_object create(string typename, string pathname,string objectname);
      case(typename)
         "T_phy_apb_mstr_addr_236": begin T_phy_apb_mstr_addr_236 phy_apb_mstr_addr = new(objectname); create = phy_apb_mstr_addr;  end
         "T_phy_ctrl_209": begin T_phy_ctrl_209 phy_ctrl = new(objectname); create = phy_ctrl;  end
         "T_phy_ctrl_set_210": begin T_phy_ctrl_set_210 phy_ctrl_set = new(objectname); create = phy_ctrl_set;  end
         "T_phy_dp_interrupt_sts_221": begin T_phy_dp_interrupt_sts_221 phy_dp_interrupt_sts = new(objectname); create = phy_dp_interrupt_sts;  end
         "T_phy_interrupt_sts_usb4_l0_reg_223": begin T_phy_interrupt_sts_usb4_l0_reg_223 phy_interrupt_sts_usb4_l0_reg = new(objectname); create = phy_interrupt_sts_usb4_l0_reg;  end
         "T_phy_interrupt_sts_usb4_l1_reg_224": begin T_phy_interrupt_sts_usb4_l1_reg_224 phy_interrupt_sts_usb4_l1_reg = new(objectname); create = phy_interrupt_sts_usb4_l1_reg;  end
         "T_phy_iso_cmn_ctrl_215": begin T_phy_iso_cmn_ctrl_215 phy_iso_cmn_ctrl = new(objectname); create = phy_iso_cmn_ctrl;  end
         "T_phy_iso_cmn_ctrl1_reg_212": begin T_phy_iso_cmn_ctrl1_reg_212 phy_iso_cmn_ctrl1_reg = new(objectname); create = phy_iso_cmn_ctrl1_reg;  end
         "T_phy_iso_cmn_ctrl2_reg_213": begin T_phy_iso_cmn_ctrl2_reg_213 phy_iso_cmn_ctrl2_reg = new(objectname); create = phy_iso_cmn_ctrl2_reg;  end
         "T_phy_lane_off_ctl_220": begin T_phy_lane_off_ctl_220 phy_lane_off_ctl = new(objectname); create = phy_lane_off_ctl;  end
         "T_phy_lane_reset_204": begin T_phy_lane_reset_204 phy_lane_reset = new(objectname); create = phy_lane_reset;  end
         "T_phy_pcs_gen3_eie_lock_cfg_203": begin T_phy_pcs_gen3_eie_lock_cfg_203 phy_pcs_gen3_eie_lock_cfg = new(objectname); create = phy_pcs_gen3_eie_lock_cfg;  end
         "T_phy_pipe4_cmn_ctrl_reg_202": begin T_phy_pipe4_cmn_ctrl_reg_202 phy_pipe4_cmn_ctrl_reg = new(objectname); create = phy_pipe4_cmn_ctrl_reg;  end
         "T_phy_pipe_com_lock_cfg_216": begin T_phy_pipe_com_lock_cfg_216 phy_pipe_com_lock_cfg = new(objectname); create = phy_pipe_com_lock_cfg;  end
         "T_phy_pipe_lm_cfg0_205": begin T_phy_pipe_lm_cfg0_205 phy_pipe_lm_cfg0 = new(objectname); create = phy_pipe_lm_cfg0;  end
         "T_phy_pipe_lm_cfg1_206": begin T_phy_pipe_lm_cfg1_206 phy_pipe_lm_cfg1 = new(objectname); create = phy_pipe_lm_cfg1;  end
         "T_phy_pipe_lm_cfg2_207": begin T_phy_pipe_lm_cfg2_207 phy_pipe_lm_cfg2 = new(objectname); create = phy_pipe_lm_cfg2;  end
         "T_phy_pipe_usb3_gen2_post_cfg_218": begin T_phy_pipe_usb3_gen2_post_cfg_218 phy_pipe_usb3_gen2_post_cfg = new(objectname); create = phy_pipe_usb3_gen2_post_cfg;  end
         "T_phy_pipe_usb3_gen2_pre_cfg_217": begin T_phy_pipe_usb3_gen2_pre_cfg_217 phy_pipe_usb3_gen2_pre_cfg = new(objectname); create = phy_pipe_usb3_gen2_pre_cfg;  end
         "T_phy_pma_lane_map_219": begin T_phy_pma_lane_map_219 phy_pma_lane_map = new(objectname); create = phy_pma_lane_map;  end
         "T_phy_spdup_cfg_ctrl_214": begin T_phy_spdup_cfg_ctrl_214 phy_spdup_cfg_ctrl = new(objectname); create = phy_spdup_cfg_ctrl;  end
         "T_phy_timeout_cfg_208": begin T_phy_timeout_cfg_208 phy_timeout_cfg = new(objectname); create = phy_timeout_cfg;  end
         "T_phy_usb_interrupt_sts_222": begin T_phy_usb_interrupt_sts_222 phy_usb_interrupt_sts = new(objectname); create = phy_usb_interrupt_sts;  end
         "T_phy_version_211": begin T_phy_version_211 phy_version = new(objectname); create = phy_version;  end
         "T_uc_top_ctrl_226": begin T_uc_top_ctrl_226 uc_top_ctrl = new(objectname); create = uc_top_ctrl;  end
         "T_uc_top_scrpad0_228": begin T_uc_top_scrpad0_228 uc_top_scrpad0 = new(objectname); create = uc_top_scrpad0;  end
         "T_uc_top_scrpad1_229": begin T_uc_top_scrpad1_229 uc_top_scrpad1 = new(objectname); create = uc_top_scrpad1;  end
         "T_uc_top_scrpad15_225": begin T_uc_top_scrpad15_225 uc_top_scrpad15 = new(objectname); create = uc_top_scrpad15;  end
         "T_uc_top_scrpad2_230": begin T_uc_top_scrpad2_230 uc_top_scrpad2 = new(objectname); create = uc_top_scrpad2;  end
         "T_uc_top_scrpad3_231": begin T_uc_top_scrpad3_231 uc_top_scrpad3 = new(objectname); create = uc_top_scrpad3;  end
         "T_uc_top_scrpad4_232": begin T_uc_top_scrpad4_232 uc_top_scrpad4 = new(objectname); create = uc_top_scrpad4;  end
         "T_uc_top_scrpad5_233": begin T_uc_top_scrpad5_233 uc_top_scrpad5 = new(objectname); create = uc_top_scrpad5;  end
         "T_uc_top_scrpad6_234": begin T_uc_top_scrpad6_234 uc_top_scrpad6 = new(objectname); create = uc_top_scrpad6;  end
         "T_uc_top_scrpad7_235": begin T_uc_top_scrpad7_235 uc_top_scrpad7 = new(objectname); create = uc_top_scrpad7;  end
         "T_uc_top_sram_access_237": begin T_uc_top_sram_access_237 uc_top_sram_access = new(objectname); create = uc_top_sram_access;  end
         "T_uc_top_sram_addr_227": begin T_uc_top_sram_addr_227 uc_top_sram_addr = new(objectname); create = uc_top_sram_addr;  end

      endcase
   endfunction
endclass


//get_factory() function to select the factory
function automatic cdns_factory_base get_factory(bit no_factory);
   static cdns_factory_base cdns_factory;
   if(cdns_factory == null) begin
      if(no_factory == 1) begin
         reg_verifier_factory rv_factory = new;
         cdns_factory = rv_factory;
      end
      else begin
         uvm_factory_proxy rv_factory = new;
         cdns_factory = rv_factory;
      end
   end
   cdns_uvmreg_utils_pkg_phy_pcs_cmn_registers::factory=cdns_factory;


   return cdns_factory;
endfunction
cdns_factory_base cdns_factory = get_factory(no_factory);

endpackage



