//*************************************************************//
//   ** File Generated Automatically
//   ** Please donot edit manually
//*************************************************************//


package cdn_pma_rx_lane_reg_pkg;
  import uvm_pkg::*;
  `include "uvm_macros.svh"
  import cdns_uvmreg_utils_pkg_pma_rx_lane_registers::*;

  bit no_factory = 0; 

/////////////////////////////////////////////////////
//                rx_cdrlf_2ol_gain
/////////////////////////////////////////////////////
class T_rx_cdrlf_2ol_gain_545 extends cdns_uvm_reg;

  `uvm_object_utils(T_rx_cdrlf_2ol_gain_545)
  rand uvm_reg_field rx_cdrlf_2ol_gain_7_0;
  rand uvm_reg_field rx_cdrlf_2ol_gain_15_8;
  rand uvm_reg_field rx_cdrlf_2ol_gain_31_16;
  
  covergroup wr_fld_covg;
    rx_cdrlf_2ol_gain_7_0: coverpoint rx_cdrlf_2ol_gain_7_0.value[7:0];
    rx_cdrlf_2ol_gain_15_8: coverpoint rx_cdrlf_2ol_gain_15_8.value[7:0];
    rx_cdrlf_2ol_gain_31_16: coverpoint rx_cdrlf_2ol_gain_31_16.value[15:0];
  endgroup
  covergroup rd_fld_covg;
    rx_cdrlf_2ol_gain_7_0: coverpoint rx_cdrlf_2ol_gain_7_0.value[7:0];
    rx_cdrlf_2ol_gain_15_8: coverpoint rx_cdrlf_2ol_gain_15_8.value[7:0];
    rx_cdrlf_2ol_gain_31_16: coverpoint rx_cdrlf_2ol_gain_31_16.value[15:0];
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
    
    rx_cdrlf_2ol_gain_7_0 = fld_set[0];
    rx_cdrlf_2ol_gain_15_8 = fld_set[1];
    rx_cdrlf_2ol_gain_31_16 = fld_set[2];
  endfunction

  function new(input string name="T_rx_cdrlf_2ol_gain_545");
    super.new(name, 32, build_coverage(UVM_CVR_FIELD_VALS));
    if (has_coverage(UVM_CVR_FIELD_VALS)) begin
      wr_fld_covg = new();
      rd_fld_covg = new();
    end
  endfunction

endclass


/////////////////////////////////////////////////////
//                rx_cdrlf_cnfg0
/////////////////////////////////////////////////////
class T_rx_cdrlf_cnfg0_536 extends cdns_uvm_reg;

  `uvm_object_utils(T_rx_cdrlf_cnfg0_536)
  rand uvm_reg_field rx_cdrlf_cnfg0_4_0;
  rand uvm_reg_field rx_cdrlf_cnfg0_7_5;
  rand uvm_reg_field rx_cdrlf_cnfg0_12_8;
  rand uvm_reg_field rx_cdrlf_cnfg0_15_13;
  rand uvm_reg_field rx_cdrlf_cnfg0_20_16;
  rand uvm_reg_field rx_cdrlf_cnfg0_23_21;
  rand uvm_reg_field rx_cdrlf_cnfg0_28_24;
  rand uvm_reg_field rx_cdrlf_cnfg0_31_29;
  
  covergroup wr_fld_covg;
    rx_cdrlf_cnfg0_4_0: coverpoint rx_cdrlf_cnfg0_4_0.value[4:0];
    rx_cdrlf_cnfg0_7_5: coverpoint rx_cdrlf_cnfg0_7_5.value[2:0];
    rx_cdrlf_cnfg0_12_8: coverpoint rx_cdrlf_cnfg0_12_8.value[4:0];
    rx_cdrlf_cnfg0_15_13: coverpoint rx_cdrlf_cnfg0_15_13.value[2:0];
    rx_cdrlf_cnfg0_20_16: coverpoint rx_cdrlf_cnfg0_20_16.value[4:0];
    rx_cdrlf_cnfg0_23_21: coverpoint rx_cdrlf_cnfg0_23_21.value[2:0];
    rx_cdrlf_cnfg0_28_24: coverpoint rx_cdrlf_cnfg0_28_24.value[4:0];
    rx_cdrlf_cnfg0_31_29: coverpoint rx_cdrlf_cnfg0_31_29.value[2:0];
  endgroup
  covergroup rd_fld_covg;
    rx_cdrlf_cnfg0_4_0: coverpoint rx_cdrlf_cnfg0_4_0.value[4:0];
    rx_cdrlf_cnfg0_7_5: coverpoint rx_cdrlf_cnfg0_7_5.value[2:0];
    rx_cdrlf_cnfg0_12_8: coverpoint rx_cdrlf_cnfg0_12_8.value[4:0];
    rx_cdrlf_cnfg0_15_13: coverpoint rx_cdrlf_cnfg0_15_13.value[2:0];
    rx_cdrlf_cnfg0_20_16: coverpoint rx_cdrlf_cnfg0_20_16.value[4:0];
    rx_cdrlf_cnfg0_23_21: coverpoint rx_cdrlf_cnfg0_23_21.value[2:0];
    rx_cdrlf_cnfg0_28_24: coverpoint rx_cdrlf_cnfg0_28_24.value[4:0];
    rx_cdrlf_cnfg0_31_29: coverpoint rx_cdrlf_cnfg0_31_29.value[2:0];
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
    
    rx_cdrlf_cnfg0_4_0 = fld_set[0];
    rx_cdrlf_cnfg0_7_5 = fld_set[1];
    rx_cdrlf_cnfg0_12_8 = fld_set[2];
    rx_cdrlf_cnfg0_15_13 = fld_set[3];
    rx_cdrlf_cnfg0_20_16 = fld_set[4];
    rx_cdrlf_cnfg0_23_21 = fld_set[5];
    rx_cdrlf_cnfg0_28_24 = fld_set[6];
    rx_cdrlf_cnfg0_31_29 = fld_set[7];
  endfunction

  function new(input string name="T_rx_cdrlf_cnfg0_536");
    super.new(name, 32, build_coverage(UVM_CVR_FIELD_VALS));
    if (has_coverage(UVM_CVR_FIELD_VALS)) begin
      wr_fld_covg = new();
      rd_fld_covg = new();
    end
  endfunction

endclass


/////////////////////////////////////////////////////
//                rx_cdrlf_cnfg1
/////////////////////////////////////////////////////
class T_rx_cdrlf_cnfg1_537 extends cdns_uvm_reg;

  `uvm_object_utils(T_rx_cdrlf_cnfg1_537)
  rand uvm_reg_field rx_cdrlf_cnfg1_4_0;
  rand uvm_reg_field rx_cdrlf_cnfg1_7_5;
  rand uvm_reg_field rx_cdrlf_cnfg1_8;
  rand uvm_reg_field rx_cdrlf_cnfg1_31_9;
  
  covergroup wr_fld_covg;
    rx_cdrlf_cnfg1_4_0: coverpoint rx_cdrlf_cnfg1_4_0.value[4:0];
    rx_cdrlf_cnfg1_7_5: coverpoint rx_cdrlf_cnfg1_7_5.value[2:0];
    rx_cdrlf_cnfg1_8: coverpoint rx_cdrlf_cnfg1_8.value[0:0];
    rx_cdrlf_cnfg1_31_9: coverpoint rx_cdrlf_cnfg1_31_9.value[22:0];
  endgroup
  covergroup rd_fld_covg;
    rx_cdrlf_cnfg1_4_0: coverpoint rx_cdrlf_cnfg1_4_0.value[4:0];
    rx_cdrlf_cnfg1_7_5: coverpoint rx_cdrlf_cnfg1_7_5.value[2:0];
    rx_cdrlf_cnfg1_8: coverpoint rx_cdrlf_cnfg1_8.value[0:0];
    rx_cdrlf_cnfg1_31_9: coverpoint rx_cdrlf_cnfg1_31_9.value[22:0];
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
    
    rx_cdrlf_cnfg1_4_0 = fld_set[0];
    rx_cdrlf_cnfg1_7_5 = fld_set[1];
    rx_cdrlf_cnfg1_8 = fld_set[2];
    rx_cdrlf_cnfg1_31_9 = fld_set[3];
  endfunction

  function new(input string name="T_rx_cdrlf_cnfg1_537");
    super.new(name, 32, build_coverage(UVM_CVR_FIELD_VALS));
    if (has_coverage(UVM_CVR_FIELD_VALS)) begin
      wr_fld_covg = new();
      rd_fld_covg = new();
    end
  endfunction

endclass


/////////////////////////////////////////////////////
//                rx_cdrlf_cnfg2
/////////////////////////////////////////////////////
class T_rx_cdrlf_cnfg2_538 extends cdns_uvm_reg;

  `uvm_object_utils(T_rx_cdrlf_cnfg2_538)
  rand uvm_reg_field rx_cdrlf_cnfg2_4_0;
  rand uvm_reg_field rx_cdrlf_cnfg2_7_5;
  rand uvm_reg_field rx_cdrlf_cnfg2_12_8;
  rand uvm_reg_field rx_cdrlf_cnfg2_15_13;
  rand uvm_reg_field rx_cdrlf_cnfg2_20_16;
  rand uvm_reg_field rx_cdrlf_cnfg2_23_21;
  rand uvm_reg_field rx_cdrlf_cnfg2_28_24;
  rand uvm_reg_field rx_cdrlf_cnfg2_31_29;
  
  covergroup wr_fld_covg;
    rx_cdrlf_cnfg2_4_0: coverpoint rx_cdrlf_cnfg2_4_0.value[4:0];
    rx_cdrlf_cnfg2_7_5: coverpoint rx_cdrlf_cnfg2_7_5.value[2:0];
    rx_cdrlf_cnfg2_12_8: coverpoint rx_cdrlf_cnfg2_12_8.value[4:0];
    rx_cdrlf_cnfg2_15_13: coverpoint rx_cdrlf_cnfg2_15_13.value[2:0];
    rx_cdrlf_cnfg2_20_16: coverpoint rx_cdrlf_cnfg2_20_16.value[4:0];
    rx_cdrlf_cnfg2_23_21: coverpoint rx_cdrlf_cnfg2_23_21.value[2:0];
    rx_cdrlf_cnfg2_28_24: coverpoint rx_cdrlf_cnfg2_28_24.value[4:0];
    rx_cdrlf_cnfg2_31_29: coverpoint rx_cdrlf_cnfg2_31_29.value[2:0];
  endgroup
  covergroup rd_fld_covg;
    rx_cdrlf_cnfg2_4_0: coverpoint rx_cdrlf_cnfg2_4_0.value[4:0];
    rx_cdrlf_cnfg2_7_5: coverpoint rx_cdrlf_cnfg2_7_5.value[2:0];
    rx_cdrlf_cnfg2_12_8: coverpoint rx_cdrlf_cnfg2_12_8.value[4:0];
    rx_cdrlf_cnfg2_15_13: coverpoint rx_cdrlf_cnfg2_15_13.value[2:0];
    rx_cdrlf_cnfg2_20_16: coverpoint rx_cdrlf_cnfg2_20_16.value[4:0];
    rx_cdrlf_cnfg2_23_21: coverpoint rx_cdrlf_cnfg2_23_21.value[2:0];
    rx_cdrlf_cnfg2_28_24: coverpoint rx_cdrlf_cnfg2_28_24.value[4:0];
    rx_cdrlf_cnfg2_31_29: coverpoint rx_cdrlf_cnfg2_31_29.value[2:0];
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
    
    rx_cdrlf_cnfg2_4_0 = fld_set[0];
    rx_cdrlf_cnfg2_7_5 = fld_set[1];
    rx_cdrlf_cnfg2_12_8 = fld_set[2];
    rx_cdrlf_cnfg2_15_13 = fld_set[3];
    rx_cdrlf_cnfg2_20_16 = fld_set[4];
    rx_cdrlf_cnfg2_23_21 = fld_set[5];
    rx_cdrlf_cnfg2_28_24 = fld_set[6];
    rx_cdrlf_cnfg2_31_29 = fld_set[7];
  endfunction

  function new(input string name="T_rx_cdrlf_cnfg2_538");
    super.new(name, 32, build_coverage(UVM_CVR_FIELD_VALS));
    if (has_coverage(UVM_CVR_FIELD_VALS)) begin
      wr_fld_covg = new();
      rd_fld_covg = new();
    end
  endfunction

endclass


/////////////////////////////////////////////////////
//                rx_cdrlf_cnfg4
/////////////////////////////////////////////////////
class T_rx_cdrlf_cnfg4_539 extends cdns_uvm_reg;

  `uvm_object_utils(T_rx_cdrlf_cnfg4_539)
  rand uvm_reg_field rx_cdrlf_cnfg4_6_0;
  rand uvm_reg_field rx_cdrlf_cnfg4_7;
  rand uvm_reg_field rx_cdrlf_cnfg4_31_8;
  
  covergroup wr_fld_covg;
    rx_cdrlf_cnfg4_6_0: coverpoint rx_cdrlf_cnfg4_6_0.value[6:0];
    rx_cdrlf_cnfg4_7: coverpoint rx_cdrlf_cnfg4_7.value[0:0];
    rx_cdrlf_cnfg4_31_8: coverpoint rx_cdrlf_cnfg4_31_8.value[23:0];
  endgroup
  covergroup rd_fld_covg;
    rx_cdrlf_cnfg4_6_0: coverpoint rx_cdrlf_cnfg4_6_0.value[6:0];
    rx_cdrlf_cnfg4_7: coverpoint rx_cdrlf_cnfg4_7.value[0:0];
    rx_cdrlf_cnfg4_31_8: coverpoint rx_cdrlf_cnfg4_31_8.value[23:0];
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
    
    rx_cdrlf_cnfg4_6_0 = fld_set[0];
    rx_cdrlf_cnfg4_7 = fld_set[1];
    rx_cdrlf_cnfg4_31_8 = fld_set[2];
  endfunction

  function new(input string name="T_rx_cdrlf_cnfg4_539");
    super.new(name, 32, build_coverage(UVM_CVR_FIELD_VALS));
    if (has_coverage(UVM_CVR_FIELD_VALS)) begin
      wr_fld_covg = new();
      rd_fld_covg = new();
    end
  endfunction

endclass


/////////////////////////////////////////////////////
//                rx_cdrlf_cnfg5
/////////////////////////////////////////////////////
class T_rx_cdrlf_cnfg5_540 extends cdns_uvm_reg;

  `uvm_object_utils(T_rx_cdrlf_cnfg5_540)
  rand uvm_reg_field rx_cdrlf_cnfg5_0;
  rand uvm_reg_field rx_cdrlf_cnfg5_1;
  rand uvm_reg_field rx_cdrlf_cnfg5_2;
  rand uvm_reg_field rx_cdrlf_cnfg5_3;
  rand uvm_reg_field rx_cdrlf_cnfg5_4;
  rand uvm_reg_field rx_cdrlf_cnfg5_5;
  rand uvm_reg_field rx_cdrlf_cnfg5_6;
  rand uvm_reg_field rx_cdrlf_cnfg5_7;
  rand uvm_reg_field rx_cdrlf_cnfg5_8;
  rand uvm_reg_field rx_cdrlf_cnfg5_11_9;
  rand uvm_reg_field rx_cdrlf_cnfg5_12;
  rand uvm_reg_field rx_cdrlf_cnfg5_13;
  rand uvm_reg_field rx_cdrlf_cnfg5_14;
  rand uvm_reg_field rx_cdrlf_cnfg5_15;
  rand uvm_reg_field rx_cdrlf_cnfg5_16;
  rand uvm_reg_field rx_cdrlf_cnfg5_17;
  rand uvm_reg_field rx_cdrlf_cnfg5_18;
  rand uvm_reg_field rx_cdrlf_cnfg5_19;
  rand uvm_reg_field rx_cdrlf_cnfg5_21_20;
  rand uvm_reg_field rx_cdrlf_cnfg5_23_22;
  rand uvm_reg_field rx_cdrlf_cnfg5_25_24;
  rand uvm_reg_field rx_cdrlf_cnfg5_27_26;
  rand uvm_reg_field rx_cdrlf_cnfg5_31_28;
  
  covergroup wr_fld_covg;
    rx_cdrlf_cnfg5_0: coverpoint rx_cdrlf_cnfg5_0.value[0:0];
    rx_cdrlf_cnfg5_1: coverpoint rx_cdrlf_cnfg5_1.value[0:0];
    rx_cdrlf_cnfg5_2: coverpoint rx_cdrlf_cnfg5_2.value[0:0];
    rx_cdrlf_cnfg5_3: coverpoint rx_cdrlf_cnfg5_3.value[0:0];
    rx_cdrlf_cnfg5_4: coverpoint rx_cdrlf_cnfg5_4.value[0:0];
    rx_cdrlf_cnfg5_5: coverpoint rx_cdrlf_cnfg5_5.value[0:0];
    rx_cdrlf_cnfg5_6: coverpoint rx_cdrlf_cnfg5_6.value[0:0];
    rx_cdrlf_cnfg5_7: coverpoint rx_cdrlf_cnfg5_7.value[0:0];
    rx_cdrlf_cnfg5_8: coverpoint rx_cdrlf_cnfg5_8.value[0:0];
    rx_cdrlf_cnfg5_11_9: coverpoint rx_cdrlf_cnfg5_11_9.value[2:0];
    rx_cdrlf_cnfg5_12: coverpoint rx_cdrlf_cnfg5_12.value[0:0];
    rx_cdrlf_cnfg5_13: coverpoint rx_cdrlf_cnfg5_13.value[0:0];
    rx_cdrlf_cnfg5_14: coverpoint rx_cdrlf_cnfg5_14.value[0:0];
    rx_cdrlf_cnfg5_15: coverpoint rx_cdrlf_cnfg5_15.value[0:0];
    rx_cdrlf_cnfg5_16: coverpoint rx_cdrlf_cnfg5_16.value[0:0];
    rx_cdrlf_cnfg5_17: coverpoint rx_cdrlf_cnfg5_17.value[0:0];
    rx_cdrlf_cnfg5_18: coverpoint rx_cdrlf_cnfg5_18.value[0:0];
    rx_cdrlf_cnfg5_19: coverpoint rx_cdrlf_cnfg5_19.value[0:0];
    rx_cdrlf_cnfg5_21_20: coverpoint rx_cdrlf_cnfg5_21_20.value[1:0];
    rx_cdrlf_cnfg5_23_22: coverpoint rx_cdrlf_cnfg5_23_22.value[1:0];
    rx_cdrlf_cnfg5_25_24: coverpoint rx_cdrlf_cnfg5_25_24.value[1:0];
    rx_cdrlf_cnfg5_27_26: coverpoint rx_cdrlf_cnfg5_27_26.value[1:0];
    rx_cdrlf_cnfg5_31_28: coverpoint rx_cdrlf_cnfg5_31_28.value[3:0];
  endgroup
  covergroup rd_fld_covg;
    rx_cdrlf_cnfg5_0: coverpoint rx_cdrlf_cnfg5_0.value[0:0];
    rx_cdrlf_cnfg5_1: coverpoint rx_cdrlf_cnfg5_1.value[0:0];
    rx_cdrlf_cnfg5_2: coverpoint rx_cdrlf_cnfg5_2.value[0:0];
    rx_cdrlf_cnfg5_3: coverpoint rx_cdrlf_cnfg5_3.value[0:0];
    rx_cdrlf_cnfg5_4: coverpoint rx_cdrlf_cnfg5_4.value[0:0];
    rx_cdrlf_cnfg5_5: coverpoint rx_cdrlf_cnfg5_5.value[0:0];
    rx_cdrlf_cnfg5_6: coverpoint rx_cdrlf_cnfg5_6.value[0:0];
    rx_cdrlf_cnfg5_7: coverpoint rx_cdrlf_cnfg5_7.value[0:0];
    rx_cdrlf_cnfg5_8: coverpoint rx_cdrlf_cnfg5_8.value[0:0];
    rx_cdrlf_cnfg5_11_9: coverpoint rx_cdrlf_cnfg5_11_9.value[2:0];
    rx_cdrlf_cnfg5_12: coverpoint rx_cdrlf_cnfg5_12.value[0:0];
    rx_cdrlf_cnfg5_13: coverpoint rx_cdrlf_cnfg5_13.value[0:0];
    rx_cdrlf_cnfg5_14: coverpoint rx_cdrlf_cnfg5_14.value[0:0];
    rx_cdrlf_cnfg5_15: coverpoint rx_cdrlf_cnfg5_15.value[0:0];
    rx_cdrlf_cnfg5_16: coverpoint rx_cdrlf_cnfg5_16.value[0:0];
    rx_cdrlf_cnfg5_17: coverpoint rx_cdrlf_cnfg5_17.value[0:0];
    rx_cdrlf_cnfg5_18: coverpoint rx_cdrlf_cnfg5_18.value[0:0];
    rx_cdrlf_cnfg5_19: coverpoint rx_cdrlf_cnfg5_19.value[0:0];
    rx_cdrlf_cnfg5_21_20: coverpoint rx_cdrlf_cnfg5_21_20.value[1:0];
    rx_cdrlf_cnfg5_23_22: coverpoint rx_cdrlf_cnfg5_23_22.value[1:0];
    rx_cdrlf_cnfg5_25_24: coverpoint rx_cdrlf_cnfg5_25_24.value[1:0];
    rx_cdrlf_cnfg5_27_26: coverpoint rx_cdrlf_cnfg5_27_26.value[1:0];
    rx_cdrlf_cnfg5_31_28: coverpoint rx_cdrlf_cnfg5_31_28.value[3:0];
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
    
    rx_cdrlf_cnfg5_0 = fld_set[0];
    rx_cdrlf_cnfg5_1 = fld_set[1];
    rx_cdrlf_cnfg5_2 = fld_set[2];
    rx_cdrlf_cnfg5_3 = fld_set[3];
    rx_cdrlf_cnfg5_4 = fld_set[4];
    rx_cdrlf_cnfg5_5 = fld_set[5];
    rx_cdrlf_cnfg5_6 = fld_set[6];
    rx_cdrlf_cnfg5_7 = fld_set[7];
    rx_cdrlf_cnfg5_8 = fld_set[8];
    rx_cdrlf_cnfg5_11_9 = fld_set[9];
    rx_cdrlf_cnfg5_12 = fld_set[10];
    rx_cdrlf_cnfg5_13 = fld_set[11];
    rx_cdrlf_cnfg5_14 = fld_set[12];
    rx_cdrlf_cnfg5_15 = fld_set[13];
    rx_cdrlf_cnfg5_16 = fld_set[14];
    rx_cdrlf_cnfg5_17 = fld_set[15];
    rx_cdrlf_cnfg5_18 = fld_set[16];
    rx_cdrlf_cnfg5_19 = fld_set[17];
    rx_cdrlf_cnfg5_21_20 = fld_set[18];
    rx_cdrlf_cnfg5_23_22 = fld_set[19];
    rx_cdrlf_cnfg5_25_24 = fld_set[20];
    rx_cdrlf_cnfg5_27_26 = fld_set[21];
    rx_cdrlf_cnfg5_31_28 = fld_set[22];
  endfunction

  function new(input string name="T_rx_cdrlf_cnfg5_540");
    super.new(name, 32, build_coverage(UVM_CVR_FIELD_VALS));
    if (has_coverage(UVM_CVR_FIELD_VALS)) begin
      wr_fld_covg = new();
      rd_fld_covg = new();
    end
  endfunction

endclass


/////////////////////////////////////////////////////
//                rx_cdrlf_fpl_ctrl1
/////////////////////////////////////////////////////
class T_rx_cdrlf_fpl_ctrl1_541 extends cdns_uvm_reg;

  `uvm_object_utils(T_rx_cdrlf_fpl_ctrl1_541)
  rand uvm_reg_field rx_cdrlf_fpl_ctrl1_3_0;
  rand uvm_reg_field rx_cdrlf_fpl_ctrl1_7_4;
  rand uvm_reg_field rx_cdrlf_fpl_ctrl1_8;
  rand uvm_reg_field rx_cdrlf_fpl_ctrl1_9;
  rand uvm_reg_field rx_cdrlf_fpl_ctrl1_10;
  rand uvm_reg_field rx_cdrlf_fpl_ctrl1_11;
  rand uvm_reg_field rx_cdrlf_fpl_ctrl1_15_12;
  rand uvm_reg_field rx_cdrlf_fpl_ctrl1_19_16;
  rand uvm_reg_field rx_cdrlf_fpl_ctrl1_23_20;
  rand uvm_reg_field rx_cdrlf_fpl_ctrl1_27_24;
  rand uvm_reg_field rx_cdrlf_fpl_ctrl1_31_28;
  
  covergroup wr_fld_covg;
    rx_cdrlf_fpl_ctrl1_3_0: coverpoint rx_cdrlf_fpl_ctrl1_3_0.value[3:0];
    rx_cdrlf_fpl_ctrl1_7_4: coverpoint rx_cdrlf_fpl_ctrl1_7_4.value[3:0];
    rx_cdrlf_fpl_ctrl1_8: coverpoint rx_cdrlf_fpl_ctrl1_8.value[0:0];
    rx_cdrlf_fpl_ctrl1_9: coverpoint rx_cdrlf_fpl_ctrl1_9.value[0:0];
    rx_cdrlf_fpl_ctrl1_10: coverpoint rx_cdrlf_fpl_ctrl1_10.value[0:0];
    rx_cdrlf_fpl_ctrl1_11: coverpoint rx_cdrlf_fpl_ctrl1_11.value[0:0];
    rx_cdrlf_fpl_ctrl1_15_12: coverpoint rx_cdrlf_fpl_ctrl1_15_12.value[3:0];
    rx_cdrlf_fpl_ctrl1_19_16: coverpoint rx_cdrlf_fpl_ctrl1_19_16.value[3:0];
    rx_cdrlf_fpl_ctrl1_23_20: coverpoint rx_cdrlf_fpl_ctrl1_23_20.value[3:0];
    rx_cdrlf_fpl_ctrl1_27_24: coverpoint rx_cdrlf_fpl_ctrl1_27_24.value[3:0];
    rx_cdrlf_fpl_ctrl1_31_28: coverpoint rx_cdrlf_fpl_ctrl1_31_28.value[3:0];
  endgroup
  covergroup rd_fld_covg;
    rx_cdrlf_fpl_ctrl1_3_0: coverpoint rx_cdrlf_fpl_ctrl1_3_0.value[3:0];
    rx_cdrlf_fpl_ctrl1_7_4: coverpoint rx_cdrlf_fpl_ctrl1_7_4.value[3:0];
    rx_cdrlf_fpl_ctrl1_8: coverpoint rx_cdrlf_fpl_ctrl1_8.value[0:0];
    rx_cdrlf_fpl_ctrl1_9: coverpoint rx_cdrlf_fpl_ctrl1_9.value[0:0];
    rx_cdrlf_fpl_ctrl1_10: coverpoint rx_cdrlf_fpl_ctrl1_10.value[0:0];
    rx_cdrlf_fpl_ctrl1_11: coverpoint rx_cdrlf_fpl_ctrl1_11.value[0:0];
    rx_cdrlf_fpl_ctrl1_15_12: coverpoint rx_cdrlf_fpl_ctrl1_15_12.value[3:0];
    rx_cdrlf_fpl_ctrl1_19_16: coverpoint rx_cdrlf_fpl_ctrl1_19_16.value[3:0];
    rx_cdrlf_fpl_ctrl1_23_20: coverpoint rx_cdrlf_fpl_ctrl1_23_20.value[3:0];
    rx_cdrlf_fpl_ctrl1_27_24: coverpoint rx_cdrlf_fpl_ctrl1_27_24.value[3:0];
    rx_cdrlf_fpl_ctrl1_31_28: coverpoint rx_cdrlf_fpl_ctrl1_31_28.value[3:0];
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
    
    rx_cdrlf_fpl_ctrl1_3_0 = fld_set[0];
    rx_cdrlf_fpl_ctrl1_7_4 = fld_set[1];
    rx_cdrlf_fpl_ctrl1_8 = fld_set[2];
    rx_cdrlf_fpl_ctrl1_9 = fld_set[3];
    rx_cdrlf_fpl_ctrl1_10 = fld_set[4];
    rx_cdrlf_fpl_ctrl1_11 = fld_set[5];
    rx_cdrlf_fpl_ctrl1_15_12 = fld_set[6];
    rx_cdrlf_fpl_ctrl1_19_16 = fld_set[7];
    rx_cdrlf_fpl_ctrl1_23_20 = fld_set[8];
    rx_cdrlf_fpl_ctrl1_27_24 = fld_set[9];
    rx_cdrlf_fpl_ctrl1_31_28 = fld_set[10];
  endfunction

  function new(input string name="T_rx_cdrlf_fpl_ctrl1_541");
    super.new(name, 32, build_coverage(UVM_CVR_FIELD_VALS));
    if (has_coverage(UVM_CVR_FIELD_VALS)) begin
      wr_fld_covg = new();
      rd_fld_covg = new();
    end
  endfunction

endclass


/////////////////////////////////////////////////////
//                rx_cdrlf_fpl_ctrl2
/////////////////////////////////////////////////////
class T_rx_cdrlf_fpl_ctrl2_542 extends cdns_uvm_reg;

  `uvm_object_utils(T_rx_cdrlf_fpl_ctrl2_542)
  rand uvm_reg_field rx_cdrlf_fpl_ctrl2_3_0;
  rand uvm_reg_field rx_cdrlf_fpl_ctrl2_7_4;
  rand uvm_reg_field rx_cdrlf_fpl_ctrl2_11_8;
  rand uvm_reg_field rx_cdrlf_fpl_ctrl2_15_12;
  rand uvm_reg_field rx_cdrlf_fpl_ctrl2_19_16;
  rand uvm_reg_field rx_cdrlf_fpl_ctrl2_23_20;
  rand uvm_reg_field rx_cdrlf_fpl_ctrl2_27_24;
  rand uvm_reg_field rx_cdrlf_fpl_ctrl2_31_28;
  
  covergroup wr_fld_covg;
    rx_cdrlf_fpl_ctrl2_3_0: coverpoint rx_cdrlf_fpl_ctrl2_3_0.value[3:0];
    rx_cdrlf_fpl_ctrl2_7_4: coverpoint rx_cdrlf_fpl_ctrl2_7_4.value[3:0];
    rx_cdrlf_fpl_ctrl2_11_8: coverpoint rx_cdrlf_fpl_ctrl2_11_8.value[3:0];
    rx_cdrlf_fpl_ctrl2_15_12: coverpoint rx_cdrlf_fpl_ctrl2_15_12.value[3:0];
    rx_cdrlf_fpl_ctrl2_19_16: coverpoint rx_cdrlf_fpl_ctrl2_19_16.value[3:0];
    rx_cdrlf_fpl_ctrl2_23_20: coverpoint rx_cdrlf_fpl_ctrl2_23_20.value[3:0];
    rx_cdrlf_fpl_ctrl2_27_24: coverpoint rx_cdrlf_fpl_ctrl2_27_24.value[3:0];
    rx_cdrlf_fpl_ctrl2_31_28: coverpoint rx_cdrlf_fpl_ctrl2_31_28.value[3:0];
  endgroup
  covergroup rd_fld_covg;
    rx_cdrlf_fpl_ctrl2_3_0: coverpoint rx_cdrlf_fpl_ctrl2_3_0.value[3:0];
    rx_cdrlf_fpl_ctrl2_7_4: coverpoint rx_cdrlf_fpl_ctrl2_7_4.value[3:0];
    rx_cdrlf_fpl_ctrl2_11_8: coverpoint rx_cdrlf_fpl_ctrl2_11_8.value[3:0];
    rx_cdrlf_fpl_ctrl2_15_12: coverpoint rx_cdrlf_fpl_ctrl2_15_12.value[3:0];
    rx_cdrlf_fpl_ctrl2_19_16: coverpoint rx_cdrlf_fpl_ctrl2_19_16.value[3:0];
    rx_cdrlf_fpl_ctrl2_23_20: coverpoint rx_cdrlf_fpl_ctrl2_23_20.value[3:0];
    rx_cdrlf_fpl_ctrl2_27_24: coverpoint rx_cdrlf_fpl_ctrl2_27_24.value[3:0];
    rx_cdrlf_fpl_ctrl2_31_28: coverpoint rx_cdrlf_fpl_ctrl2_31_28.value[3:0];
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
    
    rx_cdrlf_fpl_ctrl2_3_0 = fld_set[0];
    rx_cdrlf_fpl_ctrl2_7_4 = fld_set[1];
    rx_cdrlf_fpl_ctrl2_11_8 = fld_set[2];
    rx_cdrlf_fpl_ctrl2_15_12 = fld_set[3];
    rx_cdrlf_fpl_ctrl2_19_16 = fld_set[4];
    rx_cdrlf_fpl_ctrl2_23_20 = fld_set[5];
    rx_cdrlf_fpl_ctrl2_27_24 = fld_set[6];
    rx_cdrlf_fpl_ctrl2_31_28 = fld_set[7];
  endfunction

  function new(input string name="T_rx_cdrlf_fpl_ctrl2_542");
    super.new(name, 32, build_coverage(UVM_CVR_FIELD_VALS));
    if (has_coverage(UVM_CVR_FIELD_VALS)) begin
      wr_fld_covg = new();
      rd_fld_covg = new();
    end
  endfunction

endclass


/////////////////////////////////////////////////////
//                rx_cdrlf_fpl_ctrl3
/////////////////////////////////////////////////////
class T_rx_cdrlf_fpl_ctrl3_543 extends cdns_uvm_reg;

  `uvm_object_utils(T_rx_cdrlf_fpl_ctrl3_543)
  rand uvm_reg_field rx_cdrlf_fpl_ctrl3_3_0;
  rand uvm_reg_field rx_cdrlf_fpl_ctrl3_7_4;
  rand uvm_reg_field rx_cdrlf_fpl_ctrl3_11_8;
  rand uvm_reg_field rx_cdrlf_fpl_ctrl3_31_12;
  
  covergroup wr_fld_covg;
    rx_cdrlf_fpl_ctrl3_3_0: coverpoint rx_cdrlf_fpl_ctrl3_3_0.value[3:0];
    rx_cdrlf_fpl_ctrl3_7_4: coverpoint rx_cdrlf_fpl_ctrl3_7_4.value[3:0];
    rx_cdrlf_fpl_ctrl3_11_8: coverpoint rx_cdrlf_fpl_ctrl3_11_8.value[3:0];
    rx_cdrlf_fpl_ctrl3_31_12: coverpoint rx_cdrlf_fpl_ctrl3_31_12.value[19:0];
  endgroup
  covergroup rd_fld_covg;
    rx_cdrlf_fpl_ctrl3_3_0: coverpoint rx_cdrlf_fpl_ctrl3_3_0.value[3:0];
    rx_cdrlf_fpl_ctrl3_7_4: coverpoint rx_cdrlf_fpl_ctrl3_7_4.value[3:0];
    rx_cdrlf_fpl_ctrl3_11_8: coverpoint rx_cdrlf_fpl_ctrl3_11_8.value[3:0];
    rx_cdrlf_fpl_ctrl3_31_12: coverpoint rx_cdrlf_fpl_ctrl3_31_12.value[19:0];
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
    
    rx_cdrlf_fpl_ctrl3_3_0 = fld_set[0];
    rx_cdrlf_fpl_ctrl3_7_4 = fld_set[1];
    rx_cdrlf_fpl_ctrl3_11_8 = fld_set[2];
    rx_cdrlf_fpl_ctrl3_31_12 = fld_set[3];
  endfunction

  function new(input string name="T_rx_cdrlf_fpl_ctrl3_543");
    super.new(name, 32, build_coverage(UVM_CVR_FIELD_VALS));
    if (has_coverage(UVM_CVR_FIELD_VALS)) begin
      wr_fld_covg = new();
      rd_fld_covg = new();
    end
  endfunction

endclass


/////////////////////////////////////////////////////
//                rx_cdrlf_pi_php
/////////////////////////////////////////////////////
class T_rx_cdrlf_pi_php_544 extends cdns_uvm_reg;

  `uvm_object_utils(T_rx_cdrlf_pi_php_544)
  rand uvm_reg_field rx_cdrlf_pi_php_7_0;
  rand uvm_reg_field rx_cdrlf_pi_php_15_8;
  rand uvm_reg_field rx_cdrlf_pi_php_23_16;
  rand uvm_reg_field rx_cdrlf_pi_php_31_24;
  
  covergroup wr_fld_covg;
    rx_cdrlf_pi_php_7_0: coverpoint rx_cdrlf_pi_php_7_0.value[7:0];
    rx_cdrlf_pi_php_15_8: coverpoint rx_cdrlf_pi_php_15_8.value[7:0];
    rx_cdrlf_pi_php_23_16: coverpoint rx_cdrlf_pi_php_23_16.value[7:0];
    rx_cdrlf_pi_php_31_24: coverpoint rx_cdrlf_pi_php_31_24.value[7:0];
  endgroup
  covergroup rd_fld_covg;
    rx_cdrlf_pi_php_7_0: coverpoint rx_cdrlf_pi_php_7_0.value[7:0];
    rx_cdrlf_pi_php_15_8: coverpoint rx_cdrlf_pi_php_15_8.value[7:0];
    rx_cdrlf_pi_php_23_16: coverpoint rx_cdrlf_pi_php_23_16.value[7:0];
    rx_cdrlf_pi_php_31_24: coverpoint rx_cdrlf_pi_php_31_24.value[7:0];
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
    
    rx_cdrlf_pi_php_7_0 = fld_set[0];
    rx_cdrlf_pi_php_15_8 = fld_set[1];
    rx_cdrlf_pi_php_23_16 = fld_set[2];
    rx_cdrlf_pi_php_31_24 = fld_set[3];
  endfunction

  function new(input string name="T_rx_cdrlf_pi_php_544");
    super.new(name, 32, build_coverage(UVM_CVR_FIELD_VALS));
    if (has_coverage(UVM_CVR_FIELD_VALS)) begin
      wr_fld_covg = new();
      rd_fld_covg = new();
    end
  endfunction

endclass


/////////////////////////////////////////////////////
//                rx_ctlecal0_ctrl
/////////////////////////////////////////////////////
class T_rx_ctlecal0_ctrl_493 extends cdns_uvm_reg;

  `uvm_object_utils(T_rx_ctlecal0_ctrl_493)
  rand uvm_reg_field rx_ctlecal0_ctrl_4_0;
  rand uvm_reg_field rx_ctlecal0_ctrl_11_5;
  rand uvm_reg_field rx_ctlecal0_ctrl_12;
  rand uvm_reg_field rx_ctlecal0_ctrl_13;
  rand uvm_reg_field rx_ctlecal0_ctrl_14;
  rand uvm_reg_field rx_ctlecal0_ctrl_15;
  rand uvm_reg_field rx_ctlecal0_ctrl_31_16;
  
  covergroup wr_fld_covg;
    rx_ctlecal0_ctrl_4_0: coverpoint rx_ctlecal0_ctrl_4_0.value[4:0];
    rx_ctlecal0_ctrl_11_5: coverpoint rx_ctlecal0_ctrl_11_5.value[6:0];
    rx_ctlecal0_ctrl_12: coverpoint rx_ctlecal0_ctrl_12.value[0:0];
    rx_ctlecal0_ctrl_13: coverpoint rx_ctlecal0_ctrl_13.value[0:0];
    rx_ctlecal0_ctrl_14: coverpoint rx_ctlecal0_ctrl_14.value[0:0];
    rx_ctlecal0_ctrl_15: coverpoint rx_ctlecal0_ctrl_15.value[0:0];
    rx_ctlecal0_ctrl_31_16: coverpoint rx_ctlecal0_ctrl_31_16.value[15:0];
  endgroup
  covergroup rd_fld_covg;
    rx_ctlecal0_ctrl_4_0: coverpoint rx_ctlecal0_ctrl_4_0.value[4:0];
    rx_ctlecal0_ctrl_11_5: coverpoint rx_ctlecal0_ctrl_11_5.value[6:0];
    rx_ctlecal0_ctrl_12: coverpoint rx_ctlecal0_ctrl_12.value[0:0];
    rx_ctlecal0_ctrl_13: coverpoint rx_ctlecal0_ctrl_13.value[0:0];
    rx_ctlecal0_ctrl_14: coverpoint rx_ctlecal0_ctrl_14.value[0:0];
    rx_ctlecal0_ctrl_15: coverpoint rx_ctlecal0_ctrl_15.value[0:0];
    rx_ctlecal0_ctrl_31_16: coverpoint rx_ctlecal0_ctrl_31_16.value[15:0];
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
    
    rx_ctlecal0_ctrl_4_0 = fld_set[0];
    rx_ctlecal0_ctrl_11_5 = fld_set[1];
    rx_ctlecal0_ctrl_12 = fld_set[2];
    rx_ctlecal0_ctrl_13 = fld_set[3];
    rx_ctlecal0_ctrl_14 = fld_set[4];
    rx_ctlecal0_ctrl_15 = fld_set[5];
    rx_ctlecal0_ctrl_31_16 = fld_set[6];
  endfunction

  function new(input string name="T_rx_ctlecal0_ctrl_493");
    super.new(name, 32, build_coverage(UVM_CVR_FIELD_VALS));
    if (has_coverage(UVM_CVR_FIELD_VALS)) begin
      wr_fld_covg = new();
      rd_fld_covg = new();
    end
  endfunction

endclass


/////////////////////////////////////////////////////
//                rx_ctlecal0_init_tmr
/////////////////////////////////////////////////////
class T_rx_ctlecal0_init_tmr_496 extends cdns_uvm_reg;

  `uvm_object_utils(T_rx_ctlecal0_init_tmr_496)
  rand uvm_reg_field rx_ctlecal0_init_tmr_11_0;
  rand uvm_reg_field rx_ctlecal0_init_tmr_15_12;
  rand uvm_reg_field rx_ctlecal0_init_tmr_31_16;
  
  covergroup wr_fld_covg;
    rx_ctlecal0_init_tmr_11_0: coverpoint rx_ctlecal0_init_tmr_11_0.value[11:0];
    rx_ctlecal0_init_tmr_15_12: coverpoint rx_ctlecal0_init_tmr_15_12.value[3:0];
    rx_ctlecal0_init_tmr_31_16: coverpoint rx_ctlecal0_init_tmr_31_16.value[15:0];
  endgroup
  covergroup rd_fld_covg;
    rx_ctlecal0_init_tmr_11_0: coverpoint rx_ctlecal0_init_tmr_11_0.value[11:0];
    rx_ctlecal0_init_tmr_15_12: coverpoint rx_ctlecal0_init_tmr_15_12.value[3:0];
    rx_ctlecal0_init_tmr_31_16: coverpoint rx_ctlecal0_init_tmr_31_16.value[15:0];
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
    
    rx_ctlecal0_init_tmr_11_0 = fld_set[0];
    rx_ctlecal0_init_tmr_15_12 = fld_set[1];
    rx_ctlecal0_init_tmr_31_16 = fld_set[2];
  endfunction

  function new(input string name="T_rx_ctlecal0_init_tmr_496");
    super.new(name, 32, build_coverage(UVM_CVR_FIELD_VALS));
    if (has_coverage(UVM_CVR_FIELD_VALS)) begin
      wr_fld_covg = new();
      rd_fld_covg = new();
    end
  endfunction

endclass


/////////////////////////////////////////////////////
//                rx_ctlecal0_iter_tmr
/////////////////////////////////////////////////////
class T_rx_ctlecal0_iter_tmr_497 extends cdns_uvm_reg;

  `uvm_object_utils(T_rx_ctlecal0_iter_tmr_497)
  rand uvm_reg_field rx_ctlecal0_iter_tmr_11_0;
  rand uvm_reg_field rx_ctlecal0_iter_tmr_15_12;
  rand uvm_reg_field rx_ctlecal0_iter_tmr_31_16;
  
  covergroup wr_fld_covg;
    rx_ctlecal0_iter_tmr_11_0: coverpoint rx_ctlecal0_iter_tmr_11_0.value[11:0];
    rx_ctlecal0_iter_tmr_15_12: coverpoint rx_ctlecal0_iter_tmr_15_12.value[3:0];
    rx_ctlecal0_iter_tmr_31_16: coverpoint rx_ctlecal0_iter_tmr_31_16.value[15:0];
  endgroup
  covergroup rd_fld_covg;
    rx_ctlecal0_iter_tmr_11_0: coverpoint rx_ctlecal0_iter_tmr_11_0.value[11:0];
    rx_ctlecal0_iter_tmr_15_12: coverpoint rx_ctlecal0_iter_tmr_15_12.value[3:0];
    rx_ctlecal0_iter_tmr_31_16: coverpoint rx_ctlecal0_iter_tmr_31_16.value[15:0];
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
    
    rx_ctlecal0_iter_tmr_11_0 = fld_set[0];
    rx_ctlecal0_iter_tmr_15_12 = fld_set[1];
    rx_ctlecal0_iter_tmr_31_16 = fld_set[2];
  endfunction

  function new(input string name="T_rx_ctlecal0_iter_tmr_497");
    super.new(name, 32, build_coverage(UVM_CVR_FIELD_VALS));
    if (has_coverage(UVM_CVR_FIELD_VALS)) begin
      wr_fld_covg = new();
      rd_fld_covg = new();
    end
  endfunction

endclass


/////////////////////////////////////////////////////
//                rx_ctlecal0_ovrd
/////////////////////////////////////////////////////
class T_rx_ctlecal0_ovrd_494 extends cdns_uvm_reg;

  `uvm_object_utils(T_rx_ctlecal0_ovrd_494)
  rand uvm_reg_field rx_ctlecal0_ovrd_5_0;
  rand uvm_reg_field rx_ctlecal0_ovrd_13_6;
  rand uvm_reg_field rx_ctlecal0_ovrd_14;
  rand uvm_reg_field rx_ctlecal0_ovrd_15;
  rand uvm_reg_field rx_ctlecal0_ovrd_31_16;
  
  covergroup wr_fld_covg;
    rx_ctlecal0_ovrd_5_0: coverpoint rx_ctlecal0_ovrd_5_0.value[5:0];
    rx_ctlecal0_ovrd_13_6: coverpoint rx_ctlecal0_ovrd_13_6.value[7:0];
    rx_ctlecal0_ovrd_14: coverpoint rx_ctlecal0_ovrd_14.value[0:0];
    rx_ctlecal0_ovrd_15: coverpoint rx_ctlecal0_ovrd_15.value[0:0];
    rx_ctlecal0_ovrd_31_16: coverpoint rx_ctlecal0_ovrd_31_16.value[15:0];
  endgroup
  covergroup rd_fld_covg;
    rx_ctlecal0_ovrd_5_0: coverpoint rx_ctlecal0_ovrd_5_0.value[5:0];
    rx_ctlecal0_ovrd_13_6: coverpoint rx_ctlecal0_ovrd_13_6.value[7:0];
    rx_ctlecal0_ovrd_14: coverpoint rx_ctlecal0_ovrd_14.value[0:0];
    rx_ctlecal0_ovrd_15: coverpoint rx_ctlecal0_ovrd_15.value[0:0];
    rx_ctlecal0_ovrd_31_16: coverpoint rx_ctlecal0_ovrd_31_16.value[15:0];
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
    
    rx_ctlecal0_ovrd_5_0 = fld_set[0];
    rx_ctlecal0_ovrd_13_6 = fld_set[1];
    rx_ctlecal0_ovrd_14 = fld_set[2];
    rx_ctlecal0_ovrd_15 = fld_set[3];
    rx_ctlecal0_ovrd_31_16 = fld_set[4];
  endfunction

  function new(input string name="T_rx_ctlecal0_ovrd_494");
    super.new(name, 32, build_coverage(UVM_CVR_FIELD_VALS));
    if (has_coverage(UVM_CVR_FIELD_VALS)) begin
      wr_fld_covg = new();
      rd_fld_covg = new();
    end
  endfunction

endclass


/////////////////////////////////////////////////////
//                rx_ctlecal0_tune
/////////////////////////////////////////////////////
class T_rx_ctlecal0_tune_495 extends cdns_uvm_reg;

  `uvm_object_utils(T_rx_ctlecal0_tune_495)
  rand uvm_reg_field rx_ctlecal0_tune_5_0;
  rand uvm_reg_field rx_ctlecal0_tune_15_6;
  rand uvm_reg_field rx_ctlecal0_tune_31_16;
  
  covergroup wr_fld_covg;
    rx_ctlecal0_tune_5_0: coverpoint rx_ctlecal0_tune_5_0.value[5:0];
    rx_ctlecal0_tune_15_6: coverpoint rx_ctlecal0_tune_15_6.value[9:0];
    rx_ctlecal0_tune_31_16: coverpoint rx_ctlecal0_tune_31_16.value[15:0];
  endgroup
  covergroup rd_fld_covg;
    rx_ctlecal0_tune_5_0: coverpoint rx_ctlecal0_tune_5_0.value[5:0];
    rx_ctlecal0_tune_15_6: coverpoint rx_ctlecal0_tune_15_6.value[9:0];
    rx_ctlecal0_tune_31_16: coverpoint rx_ctlecal0_tune_31_16.value[15:0];
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
    
    rx_ctlecal0_tune_5_0 = fld_set[0];
    rx_ctlecal0_tune_15_6 = fld_set[1];
    rx_ctlecal0_tune_31_16 = fld_set[2];
  endfunction

  function new(input string name="T_rx_ctlecal0_tune_495");
    super.new(name, 32, build_coverage(UVM_CVR_FIELD_VALS));
    if (has_coverage(UVM_CVR_FIELD_VALS)) begin
      wr_fld_covg = new();
      rd_fld_covg = new();
    end
  endfunction

endclass


/////////////////////////////////////////////////////
//                rx_ctlecal1_ctrl
/////////////////////////////////////////////////////
class T_rx_ctlecal1_ctrl_498 extends cdns_uvm_reg;

  `uvm_object_utils(T_rx_ctlecal1_ctrl_498)
  rand uvm_reg_field rx_ctlecal1_ctrl_4_0;
  rand uvm_reg_field rx_ctlecal1_ctrl_11_5;
  rand uvm_reg_field rx_ctlecal1_ctrl_12;
  rand uvm_reg_field rx_ctlecal1_ctrl_13;
  rand uvm_reg_field rx_ctlecal1_ctrl_14;
  rand uvm_reg_field rx_ctlecal1_ctrl_15;
  rand uvm_reg_field rx_ctlecal1_ctrl_31_16;
  
  covergroup wr_fld_covg;
    rx_ctlecal1_ctrl_4_0: coverpoint rx_ctlecal1_ctrl_4_0.value[4:0];
    rx_ctlecal1_ctrl_11_5: coverpoint rx_ctlecal1_ctrl_11_5.value[6:0];
    rx_ctlecal1_ctrl_12: coverpoint rx_ctlecal1_ctrl_12.value[0:0];
    rx_ctlecal1_ctrl_13: coverpoint rx_ctlecal1_ctrl_13.value[0:0];
    rx_ctlecal1_ctrl_14: coverpoint rx_ctlecal1_ctrl_14.value[0:0];
    rx_ctlecal1_ctrl_15: coverpoint rx_ctlecal1_ctrl_15.value[0:0];
    rx_ctlecal1_ctrl_31_16: coverpoint rx_ctlecal1_ctrl_31_16.value[15:0];
  endgroup
  covergroup rd_fld_covg;
    rx_ctlecal1_ctrl_4_0: coverpoint rx_ctlecal1_ctrl_4_0.value[4:0];
    rx_ctlecal1_ctrl_11_5: coverpoint rx_ctlecal1_ctrl_11_5.value[6:0];
    rx_ctlecal1_ctrl_12: coverpoint rx_ctlecal1_ctrl_12.value[0:0];
    rx_ctlecal1_ctrl_13: coverpoint rx_ctlecal1_ctrl_13.value[0:0];
    rx_ctlecal1_ctrl_14: coverpoint rx_ctlecal1_ctrl_14.value[0:0];
    rx_ctlecal1_ctrl_15: coverpoint rx_ctlecal1_ctrl_15.value[0:0];
    rx_ctlecal1_ctrl_31_16: coverpoint rx_ctlecal1_ctrl_31_16.value[15:0];
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
    
    rx_ctlecal1_ctrl_4_0 = fld_set[0];
    rx_ctlecal1_ctrl_11_5 = fld_set[1];
    rx_ctlecal1_ctrl_12 = fld_set[2];
    rx_ctlecal1_ctrl_13 = fld_set[3];
    rx_ctlecal1_ctrl_14 = fld_set[4];
    rx_ctlecal1_ctrl_15 = fld_set[5];
    rx_ctlecal1_ctrl_31_16 = fld_set[6];
  endfunction

  function new(input string name="T_rx_ctlecal1_ctrl_498");
    super.new(name, 32, build_coverage(UVM_CVR_FIELD_VALS));
    if (has_coverage(UVM_CVR_FIELD_VALS)) begin
      wr_fld_covg = new();
      rd_fld_covg = new();
    end
  endfunction

endclass


/////////////////////////////////////////////////////
//                rx_ctlecal1_init_tmr
/////////////////////////////////////////////////////
class T_rx_ctlecal1_init_tmr_501 extends cdns_uvm_reg;

  `uvm_object_utils(T_rx_ctlecal1_init_tmr_501)
  rand uvm_reg_field rx_ctlecal1_init_tmr_11_0;
  rand uvm_reg_field rx_ctlecal1_init_tmr_15_12;
  rand uvm_reg_field rx_ctlecal1_init_tmr_31_16;
  
  covergroup wr_fld_covg;
    rx_ctlecal1_init_tmr_11_0: coverpoint rx_ctlecal1_init_tmr_11_0.value[11:0];
    rx_ctlecal1_init_tmr_15_12: coverpoint rx_ctlecal1_init_tmr_15_12.value[3:0];
    rx_ctlecal1_init_tmr_31_16: coverpoint rx_ctlecal1_init_tmr_31_16.value[15:0];
  endgroup
  covergroup rd_fld_covg;
    rx_ctlecal1_init_tmr_11_0: coverpoint rx_ctlecal1_init_tmr_11_0.value[11:0];
    rx_ctlecal1_init_tmr_15_12: coverpoint rx_ctlecal1_init_tmr_15_12.value[3:0];
    rx_ctlecal1_init_tmr_31_16: coverpoint rx_ctlecal1_init_tmr_31_16.value[15:0];
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
    
    rx_ctlecal1_init_tmr_11_0 = fld_set[0];
    rx_ctlecal1_init_tmr_15_12 = fld_set[1];
    rx_ctlecal1_init_tmr_31_16 = fld_set[2];
  endfunction

  function new(input string name="T_rx_ctlecal1_init_tmr_501");
    super.new(name, 32, build_coverage(UVM_CVR_FIELD_VALS));
    if (has_coverage(UVM_CVR_FIELD_VALS)) begin
      wr_fld_covg = new();
      rd_fld_covg = new();
    end
  endfunction

endclass


/////////////////////////////////////////////////////
//                rx_ctlecal1_iter_tmr
/////////////////////////////////////////////////////
class T_rx_ctlecal1_iter_tmr_502 extends cdns_uvm_reg;

  `uvm_object_utils(T_rx_ctlecal1_iter_tmr_502)
  rand uvm_reg_field rx_ctlecal1_iter_tmr_11_0;
  rand uvm_reg_field rx_ctlecal1_iter_tmr_15_12;
  rand uvm_reg_field rx_ctlecal1_iter_tmr_31_16;
  
  covergroup wr_fld_covg;
    rx_ctlecal1_iter_tmr_11_0: coverpoint rx_ctlecal1_iter_tmr_11_0.value[11:0];
    rx_ctlecal1_iter_tmr_15_12: coverpoint rx_ctlecal1_iter_tmr_15_12.value[3:0];
    rx_ctlecal1_iter_tmr_31_16: coverpoint rx_ctlecal1_iter_tmr_31_16.value[15:0];
  endgroup
  covergroup rd_fld_covg;
    rx_ctlecal1_iter_tmr_11_0: coverpoint rx_ctlecal1_iter_tmr_11_0.value[11:0];
    rx_ctlecal1_iter_tmr_15_12: coverpoint rx_ctlecal1_iter_tmr_15_12.value[3:0];
    rx_ctlecal1_iter_tmr_31_16: coverpoint rx_ctlecal1_iter_tmr_31_16.value[15:0];
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
    
    rx_ctlecal1_iter_tmr_11_0 = fld_set[0];
    rx_ctlecal1_iter_tmr_15_12 = fld_set[1];
    rx_ctlecal1_iter_tmr_31_16 = fld_set[2];
  endfunction

  function new(input string name="T_rx_ctlecal1_iter_tmr_502");
    super.new(name, 32, build_coverage(UVM_CVR_FIELD_VALS));
    if (has_coverage(UVM_CVR_FIELD_VALS)) begin
      wr_fld_covg = new();
      rd_fld_covg = new();
    end
  endfunction

endclass


/////////////////////////////////////////////////////
//                rx_ctlecal1_ovrd
/////////////////////////////////////////////////////
class T_rx_ctlecal1_ovrd_499 extends cdns_uvm_reg;

  `uvm_object_utils(T_rx_ctlecal1_ovrd_499)
  rand uvm_reg_field rx_ctlecal1_ovrd_5_0;
  rand uvm_reg_field rx_ctlecal1_ovrd_13_6;
  rand uvm_reg_field rx_ctlecal1_ovrd_14;
  rand uvm_reg_field rx_ctlecal1_ovrd_15;
  rand uvm_reg_field rx_ctlecal1_ovrd_31_16;
  
  covergroup wr_fld_covg;
    rx_ctlecal1_ovrd_5_0: coverpoint rx_ctlecal1_ovrd_5_0.value[5:0];
    rx_ctlecal1_ovrd_13_6: coverpoint rx_ctlecal1_ovrd_13_6.value[7:0];
    rx_ctlecal1_ovrd_14: coverpoint rx_ctlecal1_ovrd_14.value[0:0];
    rx_ctlecal1_ovrd_15: coverpoint rx_ctlecal1_ovrd_15.value[0:0];
    rx_ctlecal1_ovrd_31_16: coverpoint rx_ctlecal1_ovrd_31_16.value[15:0];
  endgroup
  covergroup rd_fld_covg;
    rx_ctlecal1_ovrd_5_0: coverpoint rx_ctlecal1_ovrd_5_0.value[5:0];
    rx_ctlecal1_ovrd_13_6: coverpoint rx_ctlecal1_ovrd_13_6.value[7:0];
    rx_ctlecal1_ovrd_14: coverpoint rx_ctlecal1_ovrd_14.value[0:0];
    rx_ctlecal1_ovrd_15: coverpoint rx_ctlecal1_ovrd_15.value[0:0];
    rx_ctlecal1_ovrd_31_16: coverpoint rx_ctlecal1_ovrd_31_16.value[15:0];
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
    
    rx_ctlecal1_ovrd_5_0 = fld_set[0];
    rx_ctlecal1_ovrd_13_6 = fld_set[1];
    rx_ctlecal1_ovrd_14 = fld_set[2];
    rx_ctlecal1_ovrd_15 = fld_set[3];
    rx_ctlecal1_ovrd_31_16 = fld_set[4];
  endfunction

  function new(input string name="T_rx_ctlecal1_ovrd_499");
    super.new(name, 32, build_coverage(UVM_CVR_FIELD_VALS));
    if (has_coverage(UVM_CVR_FIELD_VALS)) begin
      wr_fld_covg = new();
      rd_fld_covg = new();
    end
  endfunction

endclass


/////////////////////////////////////////////////////
//                rx_ctlecal1_tune
/////////////////////////////////////////////////////
class T_rx_ctlecal1_tune_500 extends cdns_uvm_reg;

  `uvm_object_utils(T_rx_ctlecal1_tune_500)
  rand uvm_reg_field rx_ctlecal1_tune_5_0;
  rand uvm_reg_field rx_ctlecal1_tune_15_6;
  rand uvm_reg_field rx_ctlecal1_tune_31_16;
  
  covergroup wr_fld_covg;
    rx_ctlecal1_tune_5_0: coverpoint rx_ctlecal1_tune_5_0.value[5:0];
    rx_ctlecal1_tune_15_6: coverpoint rx_ctlecal1_tune_15_6.value[9:0];
    rx_ctlecal1_tune_31_16: coverpoint rx_ctlecal1_tune_31_16.value[15:0];
  endgroup
  covergroup rd_fld_covg;
    rx_ctlecal1_tune_5_0: coverpoint rx_ctlecal1_tune_5_0.value[5:0];
    rx_ctlecal1_tune_15_6: coverpoint rx_ctlecal1_tune_15_6.value[9:0];
    rx_ctlecal1_tune_31_16: coverpoint rx_ctlecal1_tune_31_16.value[15:0];
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
    
    rx_ctlecal1_tune_5_0 = fld_set[0];
    rx_ctlecal1_tune_15_6 = fld_set[1];
    rx_ctlecal1_tune_31_16 = fld_set[2];
  endfunction

  function new(input string name="T_rx_ctlecal1_tune_500");
    super.new(name, 32, build_coverage(UVM_CVR_FIELD_VALS));
    if (has_coverage(UVM_CVR_FIELD_VALS)) begin
      wr_fld_covg = new();
      rd_fld_covg = new();
    end
  endfunction

endclass


/////////////////////////////////////////////////////
//                rx_diag_xcvr_rate_sel
/////////////////////////////////////////////////////
class T_rx_diag_xcvr_rate_sel_560 extends cdns_uvm_reg;

  `uvm_object_utils(T_rx_diag_xcvr_rate_sel_560)
  rand uvm_reg_field rx_diag_xcvr_rate_sel_0;
  rand uvm_reg_field rx_diag_xcvr_rate_sel_1;
  rand uvm_reg_field rx_diag_xcvr_rate_sel_2;
  rand uvm_reg_field rx_diag_xcvr_rate_sel_5_4;
  rand uvm_reg_field rx_diag_xcvr_rate_sel_9_8;
  rand uvm_reg_field rx_diag_xcvr_rate_sel_11_10;
  rand uvm_reg_field rx_diag_xcvr_rate_sel_13_12;
  rand uvm_reg_field rx_diag_xcvr_rate_sel_15_14;
  
  covergroup wr_fld_covg;
    rx_diag_xcvr_rate_sel_0: coverpoint rx_diag_xcvr_rate_sel_0.value[0:0];
    rx_diag_xcvr_rate_sel_1: coverpoint rx_diag_xcvr_rate_sel_1.value[0:0];
    rx_diag_xcvr_rate_sel_2: coverpoint rx_diag_xcvr_rate_sel_2.value[0:0];
    rx_diag_xcvr_rate_sel_5_4: coverpoint rx_diag_xcvr_rate_sel_5_4.value[1:0];
    rx_diag_xcvr_rate_sel_9_8: coverpoint rx_diag_xcvr_rate_sel_9_8.value[1:0];
    rx_diag_xcvr_rate_sel_11_10: coverpoint rx_diag_xcvr_rate_sel_11_10.value[1:0];
    rx_diag_xcvr_rate_sel_13_12: coverpoint rx_diag_xcvr_rate_sel_13_12.value[1:0];
    rx_diag_xcvr_rate_sel_15_14: coverpoint rx_diag_xcvr_rate_sel_15_14.value[1:0];
  endgroup
  covergroup rd_fld_covg;
    rx_diag_xcvr_rate_sel_0: coverpoint rx_diag_xcvr_rate_sel_0.value[0:0];
    rx_diag_xcvr_rate_sel_1: coverpoint rx_diag_xcvr_rate_sel_1.value[0:0];
    rx_diag_xcvr_rate_sel_2: coverpoint rx_diag_xcvr_rate_sel_2.value[0:0];
    rx_diag_xcvr_rate_sel_5_4: coverpoint rx_diag_xcvr_rate_sel_5_4.value[1:0];
    rx_diag_xcvr_rate_sel_9_8: coverpoint rx_diag_xcvr_rate_sel_9_8.value[1:0];
    rx_diag_xcvr_rate_sel_11_10: coverpoint rx_diag_xcvr_rate_sel_11_10.value[1:0];
    rx_diag_xcvr_rate_sel_13_12: coverpoint rx_diag_xcvr_rate_sel_13_12.value[1:0];
    rx_diag_xcvr_rate_sel_15_14: coverpoint rx_diag_xcvr_rate_sel_15_14.value[1:0];
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
    
    rx_diag_xcvr_rate_sel_0 = fld_set[0];
    rx_diag_xcvr_rate_sel_1 = fld_set[1];
    rx_diag_xcvr_rate_sel_2 = fld_set[2];
    rx_diag_xcvr_rate_sel_5_4 = fld_set[3];
    rx_diag_xcvr_rate_sel_9_8 = fld_set[4];
    rx_diag_xcvr_rate_sel_11_10 = fld_set[5];
    rx_diag_xcvr_rate_sel_13_12 = fld_set[6];
    rx_diag_xcvr_rate_sel_15_14 = fld_set[7];
  endfunction

  function new(input string name="T_rx_diag_xcvr_rate_sel_560");
    super.new(name, 32, build_coverage(UVM_CVR_FIELD_VALS));
    if (has_coverage(UVM_CVR_FIELD_VALS)) begin
      wr_fld_covg = new();
      rd_fld_covg = new();
    end
  endfunction

endclass


/////////////////////////////////////////////////////
//                rx_eyesurf_ctrl
/////////////////////////////////////////////////////
class T_rx_eyesurf_ctrl_546 extends cdns_uvm_reg;

  `uvm_object_utils(T_rx_eyesurf_ctrl_546)
  rand uvm_reg_field rx_eyesurf_ctrl_0;
  rand uvm_reg_field rx_eyesurf_ctrl_1;
  rand uvm_reg_field rx_eyesurf_ctrl_7_2;
  rand uvm_reg_field rx_eyesurf_ctrl_15_8;
  rand uvm_reg_field rx_eyesurf_ctrl_23_16;
  rand uvm_reg_field rx_eyesurf_ctrl_24;
  rand uvm_reg_field rx_eyesurf_ctrl_25;
  rand uvm_reg_field rx_eyesurf_ctrl_27_26;
  rand uvm_reg_field rx_eyesurf_ctrl_29_28;
  rand uvm_reg_field rx_eyesurf_ctrl_30;
  rand uvm_reg_field rx_eyesurf_ctrl_31;
  
  covergroup wr_fld_covg;
    rx_eyesurf_ctrl_0: coverpoint rx_eyesurf_ctrl_0.value[0:0];
    rx_eyesurf_ctrl_1: coverpoint rx_eyesurf_ctrl_1.value[0:0];
    rx_eyesurf_ctrl_7_2: coverpoint rx_eyesurf_ctrl_7_2.value[5:0];
    rx_eyesurf_ctrl_15_8: coverpoint rx_eyesurf_ctrl_15_8.value[7:0];
    rx_eyesurf_ctrl_23_16: coverpoint rx_eyesurf_ctrl_23_16.value[7:0];
    rx_eyesurf_ctrl_24: coverpoint rx_eyesurf_ctrl_24.value[0:0];
    rx_eyesurf_ctrl_25: coverpoint rx_eyesurf_ctrl_25.value[0:0];
    rx_eyesurf_ctrl_27_26: coverpoint rx_eyesurf_ctrl_27_26.value[1:0];
    rx_eyesurf_ctrl_29_28: coverpoint rx_eyesurf_ctrl_29_28.value[1:0];
    rx_eyesurf_ctrl_30: coverpoint rx_eyesurf_ctrl_30.value[0:0];
    rx_eyesurf_ctrl_31: coverpoint rx_eyesurf_ctrl_31.value[0:0];
  endgroup
  covergroup rd_fld_covg;
    rx_eyesurf_ctrl_0: coverpoint rx_eyesurf_ctrl_0.value[0:0];
    rx_eyesurf_ctrl_1: coverpoint rx_eyesurf_ctrl_1.value[0:0];
    rx_eyesurf_ctrl_7_2: coverpoint rx_eyesurf_ctrl_7_2.value[5:0];
    rx_eyesurf_ctrl_15_8: coverpoint rx_eyesurf_ctrl_15_8.value[7:0];
    rx_eyesurf_ctrl_23_16: coverpoint rx_eyesurf_ctrl_23_16.value[7:0];
    rx_eyesurf_ctrl_24: coverpoint rx_eyesurf_ctrl_24.value[0:0];
    rx_eyesurf_ctrl_25: coverpoint rx_eyesurf_ctrl_25.value[0:0];
    rx_eyesurf_ctrl_27_26: coverpoint rx_eyesurf_ctrl_27_26.value[1:0];
    rx_eyesurf_ctrl_29_28: coverpoint rx_eyesurf_ctrl_29_28.value[1:0];
    rx_eyesurf_ctrl_30: coverpoint rx_eyesurf_ctrl_30.value[0:0];
    rx_eyesurf_ctrl_31: coverpoint rx_eyesurf_ctrl_31.value[0:0];
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
    
    rx_eyesurf_ctrl_0 = fld_set[0];
    rx_eyesurf_ctrl_1 = fld_set[1];
    rx_eyesurf_ctrl_7_2 = fld_set[2];
    rx_eyesurf_ctrl_15_8 = fld_set[3];
    rx_eyesurf_ctrl_23_16 = fld_set[4];
    rx_eyesurf_ctrl_24 = fld_set[5];
    rx_eyesurf_ctrl_25 = fld_set[6];
    rx_eyesurf_ctrl_27_26 = fld_set[7];
    rx_eyesurf_ctrl_29_28 = fld_set[8];
    rx_eyesurf_ctrl_30 = fld_set[9];
    rx_eyesurf_ctrl_31 = fld_set[10];
  endfunction

  function new(input string name="T_rx_eyesurf_ctrl_546");
    super.new(name, 32, build_coverage(UVM_CVR_FIELD_VALS));
    if (has_coverage(UVM_CVR_FIELD_VALS)) begin
      wr_fld_covg = new();
      rd_fld_covg = new();
    end
  endfunction

endclass


/////////////////////////////////////////////////////
//                rx_eyesurf_errcnt
/////////////////////////////////////////////////////
class T_rx_eyesurf_errcnt_549 extends cdns_uvm_reg;

  `uvm_object_utils(T_rx_eyesurf_errcnt_549)
  rand uvm_reg_field rx_eyesurf_errcnt_15_0;
  rand uvm_reg_field rx_eyesurf_errcnt_31_16;
  
  covergroup wr_fld_covg;
    rx_eyesurf_errcnt_15_0: coverpoint rx_eyesurf_errcnt_15_0.value[15:0];
    rx_eyesurf_errcnt_31_16: coverpoint rx_eyesurf_errcnt_31_16.value[15:0];
  endgroup
  covergroup rd_fld_covg;
    rx_eyesurf_errcnt_15_0: coverpoint rx_eyesurf_errcnt_15_0.value[15:0];
    rx_eyesurf_errcnt_31_16: coverpoint rx_eyesurf_errcnt_31_16.value[15:0];
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
    
    rx_eyesurf_errcnt_15_0 = fld_set[0];
    rx_eyesurf_errcnt_31_16 = fld_set[1];
  endfunction

  function new(input string name="T_rx_eyesurf_errcnt_549");
    super.new(name, 32, build_coverage(UVM_CVR_FIELD_VALS));
    if (has_coverage(UVM_CVR_FIELD_VALS)) begin
      wr_fld_covg = new();
      rd_fld_covg = new();
    end
  endfunction

endclass


/////////////////////////////////////////////////////
//                rx_eyesurf_offset
/////////////////////////////////////////////////////
class T_rx_eyesurf_offset_548 extends cdns_uvm_reg;

  `uvm_object_utils(T_rx_eyesurf_offset_548)
  rand uvm_reg_field rx_eyesurf_offset_8_0;
  rand uvm_reg_field rx_eyesurf_offset_15_9;
  rand uvm_reg_field rx_eyesurf_offset_16;
  rand uvm_reg_field rx_eyesurf_offset_31_17;
  
  covergroup wr_fld_covg;
    rx_eyesurf_offset_8_0: coverpoint rx_eyesurf_offset_8_0.value[8:0];
    rx_eyesurf_offset_15_9: coverpoint rx_eyesurf_offset_15_9.value[6:0];
    rx_eyesurf_offset_16: coverpoint rx_eyesurf_offset_16.value[0:0];
    rx_eyesurf_offset_31_17: coverpoint rx_eyesurf_offset_31_17.value[14:0];
  endgroup
  covergroup rd_fld_covg;
    rx_eyesurf_offset_8_0: coverpoint rx_eyesurf_offset_8_0.value[8:0];
    rx_eyesurf_offset_15_9: coverpoint rx_eyesurf_offset_15_9.value[6:0];
    rx_eyesurf_offset_16: coverpoint rx_eyesurf_offset_16.value[0:0];
    rx_eyesurf_offset_31_17: coverpoint rx_eyesurf_offset_31_17.value[14:0];
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
    
    rx_eyesurf_offset_8_0 = fld_set[0];
    rx_eyesurf_offset_15_9 = fld_set[1];
    rx_eyesurf_offset_16 = fld_set[2];
    rx_eyesurf_offset_31_17 = fld_set[3];
  endfunction

  function new(input string name="T_rx_eyesurf_offset_548");
    super.new(name, 32, build_coverage(UVM_CVR_FIELD_VALS));
    if (has_coverage(UVM_CVR_FIELD_VALS)) begin
      wr_fld_covg = new();
      rd_fld_covg = new();
    end
  endfunction

endclass


/////////////////////////////////////////////////////
//                rx_eyesurf_tmr_test
/////////////////////////////////////////////////////
class T_rx_eyesurf_tmr_test_547 extends cdns_uvm_reg;

  `uvm_object_utils(T_rx_eyesurf_tmr_test_547)
  rand uvm_reg_field rx_eyesurf_tmr_test_31_0;
  
  covergroup wr_fld_covg;
    rx_eyesurf_tmr_test_31_0: coverpoint rx_eyesurf_tmr_test_31_0.value[31:0];
  endgroup
  covergroup rd_fld_covg;
    rx_eyesurf_tmr_test_31_0: coverpoint rx_eyesurf_tmr_test_31_0.value[31:0];
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
    
    rx_eyesurf_tmr_test_31_0 = fld_set[0];
  endfunction

  function new(input string name="T_rx_eyesurf_tmr_test_547");
    super.new(name, 32, build_coverage(UVM_CVR_FIELD_VALS));
    if (has_coverage(UVM_CVR_FIELD_VALS)) begin
      wr_fld_covg = new();
      rd_fld_covg = new();
    end
  endfunction

endclass


/////////////////////////////////////////////////////
//                rx_feye_det_ctrl
/////////////////////////////////////////////////////
class T_rx_feye_det_ctrl_515 extends cdns_uvm_reg;

  `uvm_object_utils(T_rx_feye_det_ctrl_515)
  rand uvm_reg_field rx_feye_det_ctrl_0;
  rand uvm_reg_field rx_feye_det_ctrl_1;
  rand uvm_reg_field rx_feye_det_ctrl_2;
  rand uvm_reg_field rx_feye_det_ctrl_3;
  rand uvm_reg_field rx_feye_det_ctrl_4;
  rand uvm_reg_field rx_feye_det_ctrl_7_5;
  rand uvm_reg_field rx_feye_det_ctrl_8;
  rand uvm_reg_field rx_feye_det_ctrl_9;
  rand uvm_reg_field rx_feye_det_ctrl_11_10;
  rand uvm_reg_field rx_feye_det_ctrl_14_12;
  rand uvm_reg_field rx_feye_det_ctrl_15;
  rand uvm_reg_field rx_feye_det_ctrl_27_16;
  rand uvm_reg_field rx_feye_det_ctrl_31_28;
  
  covergroup wr_fld_covg;
    rx_feye_det_ctrl_0: coverpoint rx_feye_det_ctrl_0.value[0:0];
    rx_feye_det_ctrl_1: coverpoint rx_feye_det_ctrl_1.value[0:0];
    rx_feye_det_ctrl_2: coverpoint rx_feye_det_ctrl_2.value[0:0];
    rx_feye_det_ctrl_3: coverpoint rx_feye_det_ctrl_3.value[0:0];
    rx_feye_det_ctrl_4: coverpoint rx_feye_det_ctrl_4.value[0:0];
    rx_feye_det_ctrl_7_5: coverpoint rx_feye_det_ctrl_7_5.value[2:0];
    rx_feye_det_ctrl_8: coverpoint rx_feye_det_ctrl_8.value[0:0];
    rx_feye_det_ctrl_9: coverpoint rx_feye_det_ctrl_9.value[0:0];
    rx_feye_det_ctrl_11_10: coverpoint rx_feye_det_ctrl_11_10.value[1:0];
    rx_feye_det_ctrl_14_12: coverpoint rx_feye_det_ctrl_14_12.value[2:0];
    rx_feye_det_ctrl_15: coverpoint rx_feye_det_ctrl_15.value[0:0];
    rx_feye_det_ctrl_27_16: coverpoint rx_feye_det_ctrl_27_16.value[11:0];
    rx_feye_det_ctrl_31_28: coverpoint rx_feye_det_ctrl_31_28.value[3:0];
  endgroup
  covergroup rd_fld_covg;
    rx_feye_det_ctrl_0: coverpoint rx_feye_det_ctrl_0.value[0:0];
    rx_feye_det_ctrl_1: coverpoint rx_feye_det_ctrl_1.value[0:0];
    rx_feye_det_ctrl_2: coverpoint rx_feye_det_ctrl_2.value[0:0];
    rx_feye_det_ctrl_3: coverpoint rx_feye_det_ctrl_3.value[0:0];
    rx_feye_det_ctrl_4: coverpoint rx_feye_det_ctrl_4.value[0:0];
    rx_feye_det_ctrl_7_5: coverpoint rx_feye_det_ctrl_7_5.value[2:0];
    rx_feye_det_ctrl_8: coverpoint rx_feye_det_ctrl_8.value[0:0];
    rx_feye_det_ctrl_9: coverpoint rx_feye_det_ctrl_9.value[0:0];
    rx_feye_det_ctrl_11_10: coverpoint rx_feye_det_ctrl_11_10.value[1:0];
    rx_feye_det_ctrl_14_12: coverpoint rx_feye_det_ctrl_14_12.value[2:0];
    rx_feye_det_ctrl_15: coverpoint rx_feye_det_ctrl_15.value[0:0];
    rx_feye_det_ctrl_27_16: coverpoint rx_feye_det_ctrl_27_16.value[11:0];
    rx_feye_det_ctrl_31_28: coverpoint rx_feye_det_ctrl_31_28.value[3:0];
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
    
    rx_feye_det_ctrl_0 = fld_set[0];
    rx_feye_det_ctrl_1 = fld_set[1];
    rx_feye_det_ctrl_2 = fld_set[2];
    rx_feye_det_ctrl_3 = fld_set[3];
    rx_feye_det_ctrl_4 = fld_set[4];
    rx_feye_det_ctrl_7_5 = fld_set[5];
    rx_feye_det_ctrl_8 = fld_set[6];
    rx_feye_det_ctrl_9 = fld_set[7];
    rx_feye_det_ctrl_11_10 = fld_set[8];
    rx_feye_det_ctrl_14_12 = fld_set[9];
    rx_feye_det_ctrl_15 = fld_set[10];
    rx_feye_det_ctrl_27_16 = fld_set[11];
    rx_feye_det_ctrl_31_28 = fld_set[12];
  endfunction

  function new(input string name="T_rx_feye_det_ctrl_515");
    super.new(name, 32, build_coverage(UVM_CVR_FIELD_VALS));
    if (has_coverage(UVM_CVR_FIELD_VALS)) begin
      wr_fld_covg = new();
      rd_fld_covg = new();
    end
  endfunction

endclass


/////////////////////////////////////////////////////
//                rx_feye_det_pi_adj_1
/////////////////////////////////////////////////////
class T_rx_feye_det_pi_adj_1_518 extends cdns_uvm_reg;

  `uvm_object_utils(T_rx_feye_det_pi_adj_1_518)
  rand uvm_reg_field rx_feye_det_pi_adj_1_7_0;
  rand uvm_reg_field rx_feye_det_pi_adj_1_15_8;
  rand uvm_reg_field rx_feye_det_pi_adj_1_23_16;
  rand uvm_reg_field rx_feye_det_pi_adj_1_31_24;
  
  covergroup wr_fld_covg;
    rx_feye_det_pi_adj_1_7_0: coverpoint rx_feye_det_pi_adj_1_7_0.value[7:0];
    rx_feye_det_pi_adj_1_15_8: coverpoint rx_feye_det_pi_adj_1_15_8.value[7:0];
    rx_feye_det_pi_adj_1_23_16: coverpoint rx_feye_det_pi_adj_1_23_16.value[7:0];
    rx_feye_det_pi_adj_1_31_24: coverpoint rx_feye_det_pi_adj_1_31_24.value[7:0];
  endgroup
  covergroup rd_fld_covg;
    rx_feye_det_pi_adj_1_7_0: coverpoint rx_feye_det_pi_adj_1_7_0.value[7:0];
    rx_feye_det_pi_adj_1_15_8: coverpoint rx_feye_det_pi_adj_1_15_8.value[7:0];
    rx_feye_det_pi_adj_1_23_16: coverpoint rx_feye_det_pi_adj_1_23_16.value[7:0];
    rx_feye_det_pi_adj_1_31_24: coverpoint rx_feye_det_pi_adj_1_31_24.value[7:0];
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
    
    rx_feye_det_pi_adj_1_7_0 = fld_set[0];
    rx_feye_det_pi_adj_1_15_8 = fld_set[1];
    rx_feye_det_pi_adj_1_23_16 = fld_set[2];
    rx_feye_det_pi_adj_1_31_24 = fld_set[3];
  endfunction

  function new(input string name="T_rx_feye_det_pi_adj_1_518");
    super.new(name, 32, build_coverage(UVM_CVR_FIELD_VALS));
    if (has_coverage(UVM_CVR_FIELD_VALS)) begin
      wr_fld_covg = new();
      rd_fld_covg = new();
    end
  endfunction

endclass


/////////////////////////////////////////////////////
//                rx_feye_det_pi_adj_2
/////////////////////////////////////////////////////
class T_rx_feye_det_pi_adj_2_519 extends cdns_uvm_reg;

  `uvm_object_utils(T_rx_feye_det_pi_adj_2_519)
  rand uvm_reg_field rx_feye_det_pi_adj_2_7_0;
  rand uvm_reg_field rx_feye_det_pi_adj_2_31_8;
  
  covergroup wr_fld_covg;
    rx_feye_det_pi_adj_2_7_0: coverpoint rx_feye_det_pi_adj_2_7_0.value[7:0];
    rx_feye_det_pi_adj_2_31_8: coverpoint rx_feye_det_pi_adj_2_31_8.value[23:0];
  endgroup
  covergroup rd_fld_covg;
    rx_feye_det_pi_adj_2_7_0: coverpoint rx_feye_det_pi_adj_2_7_0.value[7:0];
    rx_feye_det_pi_adj_2_31_8: coverpoint rx_feye_det_pi_adj_2_31_8.value[23:0];
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
    
    rx_feye_det_pi_adj_2_7_0 = fld_set[0];
    rx_feye_det_pi_adj_2_31_8 = fld_set[1];
  endfunction

  function new(input string name="T_rx_feye_det_pi_adj_2_519");
    super.new(name, 32, build_coverage(UVM_CVR_FIELD_VALS));
    if (has_coverage(UVM_CVR_FIELD_VALS)) begin
      wr_fld_covg = new();
      rd_fld_covg = new();
    end
  endfunction

endclass


/////////////////////////////////////////////////////
//                rx_feye_det_thr
/////////////////////////////////////////////////////
class T_rx_feye_det_thr_517 extends cdns_uvm_reg;

  `uvm_object_utils(T_rx_feye_det_thr_517)
  rand uvm_reg_field rx_feye_det_thr_3_0;
  rand uvm_reg_field rx_feye_det_thr_7_4;
  rand uvm_reg_field rx_feye_det_thr_11_8;
  rand uvm_reg_field rx_feye_det_thr_15_12;
  rand uvm_reg_field rx_feye_det_thr_19_16;
  rand uvm_reg_field rx_feye_det_thr_31_20;
  
  covergroup wr_fld_covg;
    rx_feye_det_thr_3_0: coverpoint rx_feye_det_thr_3_0.value[3:0];
    rx_feye_det_thr_7_4: coverpoint rx_feye_det_thr_7_4.value[3:0];
    rx_feye_det_thr_11_8: coverpoint rx_feye_det_thr_11_8.value[3:0];
    rx_feye_det_thr_15_12: coverpoint rx_feye_det_thr_15_12.value[3:0];
    rx_feye_det_thr_19_16: coverpoint rx_feye_det_thr_19_16.value[3:0];
    rx_feye_det_thr_31_20: coverpoint rx_feye_det_thr_31_20.value[11:0];
  endgroup
  covergroup rd_fld_covg;
    rx_feye_det_thr_3_0: coverpoint rx_feye_det_thr_3_0.value[3:0];
    rx_feye_det_thr_7_4: coverpoint rx_feye_det_thr_7_4.value[3:0];
    rx_feye_det_thr_11_8: coverpoint rx_feye_det_thr_11_8.value[3:0];
    rx_feye_det_thr_15_12: coverpoint rx_feye_det_thr_15_12.value[3:0];
    rx_feye_det_thr_19_16: coverpoint rx_feye_det_thr_19_16.value[3:0];
    rx_feye_det_thr_31_20: coverpoint rx_feye_det_thr_31_20.value[11:0];
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
    
    rx_feye_det_thr_3_0 = fld_set[0];
    rx_feye_det_thr_7_4 = fld_set[1];
    rx_feye_det_thr_11_8 = fld_set[2];
    rx_feye_det_thr_15_12 = fld_set[3];
    rx_feye_det_thr_19_16 = fld_set[4];
    rx_feye_det_thr_31_20 = fld_set[5];
  endfunction

  function new(input string name="T_rx_feye_det_thr_517");
    super.new(name, 32, build_coverage(UVM_CVR_FIELD_VALS));
    if (has_coverage(UVM_CVR_FIELD_VALS)) begin
      wr_fld_covg = new();
      rd_fld_covg = new();
    end
  endfunction

endclass


/////////////////////////////////////////////////////
//                rx_feye_det_tmr
/////////////////////////////////////////////////////
class T_rx_feye_det_tmr_516 extends cdns_uvm_reg;

  `uvm_object_utils(T_rx_feye_det_tmr_516)
  rand uvm_reg_field rx_feye_det_tmr_15_0;
  rand uvm_reg_field rx_feye_det_tmr_31_16;
  
  covergroup wr_fld_covg;
    rx_feye_det_tmr_15_0: coverpoint rx_feye_det_tmr_15_0.value[15:0];
    rx_feye_det_tmr_31_16: coverpoint rx_feye_det_tmr_31_16.value[15:0];
  endgroup
  covergroup rd_fld_covg;
    rx_feye_det_tmr_15_0: coverpoint rx_feye_det_tmr_15_0.value[15:0];
    rx_feye_det_tmr_31_16: coverpoint rx_feye_det_tmr_31_16.value[15:0];
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
    
    rx_feye_det_tmr_15_0 = fld_set[0];
    rx_feye_det_tmr_31_16 = fld_set[1];
  endfunction

  function new(input string name="T_rx_feye_det_tmr_516");
    super.new(name, 32, build_coverage(UVM_CVR_FIELD_VALS));
    if (has_coverage(UVM_CVR_FIELD_VALS)) begin
      wr_fld_covg = new();
      rd_fld_covg = new();
    end
  endfunction

endclass


/////////////////////////////////////////////////////
//                rx_psc_a0
/////////////////////////////////////////////////////
class T_rx_psc_a0_485 extends cdns_uvm_reg;

  `uvm_object_utils(T_rx_psc_a0_485)
  rand uvm_reg_field rx_psc_a0_0;
  rand uvm_reg_field rx_psc_a0_1;
  rand uvm_reg_field rx_psc_a0_2;
  rand uvm_reg_field rx_psc_a0_3;
  rand uvm_reg_field rx_psc_a0_4;
  rand uvm_reg_field rx_psc_a0_5;
  rand uvm_reg_field rx_psc_a0_6;
  rand uvm_reg_field rx_psc_a0_7;
  rand uvm_reg_field rx_psc_a0_8;
  rand uvm_reg_field rx_psc_a0_9;
  rand uvm_reg_field rx_psc_a0_10;
  rand uvm_reg_field rx_psc_a0_11;
  rand uvm_reg_field rx_psc_a0_12;
  rand uvm_reg_field rx_psc_a0_13;
  rand uvm_reg_field rx_psc_a0_14;
  rand uvm_reg_field rx_psc_a0_15;
  rand uvm_reg_field rx_psc_a0_31_16;
  
  covergroup wr_fld_covg;
    rx_psc_a0_0: coverpoint rx_psc_a0_0.value[0:0];
    rx_psc_a0_1: coverpoint rx_psc_a0_1.value[0:0];
    rx_psc_a0_2: coverpoint rx_psc_a0_2.value[0:0];
    rx_psc_a0_3: coverpoint rx_psc_a0_3.value[0:0];
    rx_psc_a0_4: coverpoint rx_psc_a0_4.value[0:0];
    rx_psc_a0_5: coverpoint rx_psc_a0_5.value[0:0];
    rx_psc_a0_6: coverpoint rx_psc_a0_6.value[0:0];
    rx_psc_a0_7: coverpoint rx_psc_a0_7.value[0:0];
    rx_psc_a0_8: coverpoint rx_psc_a0_8.value[0:0];
    rx_psc_a0_9: coverpoint rx_psc_a0_9.value[0:0];
    rx_psc_a0_10: coverpoint rx_psc_a0_10.value[0:0];
    rx_psc_a0_11: coverpoint rx_psc_a0_11.value[0:0];
    rx_psc_a0_12: coverpoint rx_psc_a0_12.value[0:0];
    rx_psc_a0_13: coverpoint rx_psc_a0_13.value[0:0];
    rx_psc_a0_14: coverpoint rx_psc_a0_14.value[0:0];
    rx_psc_a0_15: coverpoint rx_psc_a0_15.value[0:0];
    rx_psc_a0_31_16: coverpoint rx_psc_a0_31_16.value[15:0];
  endgroup
  covergroup rd_fld_covg;
    rx_psc_a0_0: coverpoint rx_psc_a0_0.value[0:0];
    rx_psc_a0_1: coverpoint rx_psc_a0_1.value[0:0];
    rx_psc_a0_2: coverpoint rx_psc_a0_2.value[0:0];
    rx_psc_a0_3: coverpoint rx_psc_a0_3.value[0:0];
    rx_psc_a0_4: coverpoint rx_psc_a0_4.value[0:0];
    rx_psc_a0_5: coverpoint rx_psc_a0_5.value[0:0];
    rx_psc_a0_6: coverpoint rx_psc_a0_6.value[0:0];
    rx_psc_a0_7: coverpoint rx_psc_a0_7.value[0:0];
    rx_psc_a0_8: coverpoint rx_psc_a0_8.value[0:0];
    rx_psc_a0_9: coverpoint rx_psc_a0_9.value[0:0];
    rx_psc_a0_10: coverpoint rx_psc_a0_10.value[0:0];
    rx_psc_a0_11: coverpoint rx_psc_a0_11.value[0:0];
    rx_psc_a0_12: coverpoint rx_psc_a0_12.value[0:0];
    rx_psc_a0_13: coverpoint rx_psc_a0_13.value[0:0];
    rx_psc_a0_14: coverpoint rx_psc_a0_14.value[0:0];
    rx_psc_a0_15: coverpoint rx_psc_a0_15.value[0:0];
    rx_psc_a0_31_16: coverpoint rx_psc_a0_31_16.value[15:0];
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
    
    rx_psc_a0_0 = fld_set[0];
    rx_psc_a0_1 = fld_set[1];
    rx_psc_a0_2 = fld_set[2];
    rx_psc_a0_3 = fld_set[3];
    rx_psc_a0_4 = fld_set[4];
    rx_psc_a0_5 = fld_set[5];
    rx_psc_a0_6 = fld_set[6];
    rx_psc_a0_7 = fld_set[7];
    rx_psc_a0_8 = fld_set[8];
    rx_psc_a0_9 = fld_set[9];
    rx_psc_a0_10 = fld_set[10];
    rx_psc_a0_11 = fld_set[11];
    rx_psc_a0_12 = fld_set[12];
    rx_psc_a0_13 = fld_set[13];
    rx_psc_a0_14 = fld_set[14];
    rx_psc_a0_15 = fld_set[15];
    rx_psc_a0_31_16 = fld_set[16];
  endfunction

  function new(input string name="T_rx_psc_a0_485");
    super.new(name, 32, build_coverage(UVM_CVR_FIELD_VALS));
    if (has_coverage(UVM_CVR_FIELD_VALS)) begin
      wr_fld_covg = new();
      rd_fld_covg = new();
    end
  endfunction

endclass


/////////////////////////////////////////////////////
//                rx_psc_a1
/////////////////////////////////////////////////////
class T_rx_psc_a1_486 extends cdns_uvm_reg;

  `uvm_object_utils(T_rx_psc_a1_486)
  rand uvm_reg_field rx_psc_a1_0;
  rand uvm_reg_field rx_psc_a1_1;
  rand uvm_reg_field rx_psc_a1_2;
  rand uvm_reg_field rx_psc_a1_3;
  rand uvm_reg_field rx_psc_a1_4;
  rand uvm_reg_field rx_psc_a1_5;
  rand uvm_reg_field rx_psc_a1_6;
  rand uvm_reg_field rx_psc_a1_7;
  rand uvm_reg_field rx_psc_a1_8;
  rand uvm_reg_field rx_psc_a1_9;
  rand uvm_reg_field rx_psc_a1_10;
  rand uvm_reg_field rx_psc_a1_11;
  rand uvm_reg_field rx_psc_a1_12;
  rand uvm_reg_field rx_psc_a1_13;
  rand uvm_reg_field rx_psc_a1_14;
  rand uvm_reg_field rx_psc_a1_15;
  rand uvm_reg_field rx_psc_a1_31_16;
  
  covergroup wr_fld_covg;
    rx_psc_a1_0: coverpoint rx_psc_a1_0.value[0:0];
    rx_psc_a1_1: coverpoint rx_psc_a1_1.value[0:0];
    rx_psc_a1_2: coverpoint rx_psc_a1_2.value[0:0];
    rx_psc_a1_3: coverpoint rx_psc_a1_3.value[0:0];
    rx_psc_a1_4: coverpoint rx_psc_a1_4.value[0:0];
    rx_psc_a1_5: coverpoint rx_psc_a1_5.value[0:0];
    rx_psc_a1_6: coverpoint rx_psc_a1_6.value[0:0];
    rx_psc_a1_7: coverpoint rx_psc_a1_7.value[0:0];
    rx_psc_a1_8: coverpoint rx_psc_a1_8.value[0:0];
    rx_psc_a1_9: coverpoint rx_psc_a1_9.value[0:0];
    rx_psc_a1_10: coverpoint rx_psc_a1_10.value[0:0];
    rx_psc_a1_11: coverpoint rx_psc_a1_11.value[0:0];
    rx_psc_a1_12: coverpoint rx_psc_a1_12.value[0:0];
    rx_psc_a1_13: coverpoint rx_psc_a1_13.value[0:0];
    rx_psc_a1_14: coverpoint rx_psc_a1_14.value[0:0];
    rx_psc_a1_15: coverpoint rx_psc_a1_15.value[0:0];
    rx_psc_a1_31_16: coverpoint rx_psc_a1_31_16.value[15:0];
  endgroup
  covergroup rd_fld_covg;
    rx_psc_a1_0: coverpoint rx_psc_a1_0.value[0:0];
    rx_psc_a1_1: coverpoint rx_psc_a1_1.value[0:0];
    rx_psc_a1_2: coverpoint rx_psc_a1_2.value[0:0];
    rx_psc_a1_3: coverpoint rx_psc_a1_3.value[0:0];
    rx_psc_a1_4: coverpoint rx_psc_a1_4.value[0:0];
    rx_psc_a1_5: coverpoint rx_psc_a1_5.value[0:0];
    rx_psc_a1_6: coverpoint rx_psc_a1_6.value[0:0];
    rx_psc_a1_7: coverpoint rx_psc_a1_7.value[0:0];
    rx_psc_a1_8: coverpoint rx_psc_a1_8.value[0:0];
    rx_psc_a1_9: coverpoint rx_psc_a1_9.value[0:0];
    rx_psc_a1_10: coverpoint rx_psc_a1_10.value[0:0];
    rx_psc_a1_11: coverpoint rx_psc_a1_11.value[0:0];
    rx_psc_a1_12: coverpoint rx_psc_a1_12.value[0:0];
    rx_psc_a1_13: coverpoint rx_psc_a1_13.value[0:0];
    rx_psc_a1_14: coverpoint rx_psc_a1_14.value[0:0];
    rx_psc_a1_15: coverpoint rx_psc_a1_15.value[0:0];
    rx_psc_a1_31_16: coverpoint rx_psc_a1_31_16.value[15:0];
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
    
    rx_psc_a1_0 = fld_set[0];
    rx_psc_a1_1 = fld_set[1];
    rx_psc_a1_2 = fld_set[2];
    rx_psc_a1_3 = fld_set[3];
    rx_psc_a1_4 = fld_set[4];
    rx_psc_a1_5 = fld_set[5];
    rx_psc_a1_6 = fld_set[6];
    rx_psc_a1_7 = fld_set[7];
    rx_psc_a1_8 = fld_set[8];
    rx_psc_a1_9 = fld_set[9];
    rx_psc_a1_10 = fld_set[10];
    rx_psc_a1_11 = fld_set[11];
    rx_psc_a1_12 = fld_set[12];
    rx_psc_a1_13 = fld_set[13];
    rx_psc_a1_14 = fld_set[14];
    rx_psc_a1_15 = fld_set[15];
    rx_psc_a1_31_16 = fld_set[16];
  endfunction

  function new(input string name="T_rx_psc_a1_486");
    super.new(name, 32, build_coverage(UVM_CVR_FIELD_VALS));
    if (has_coverage(UVM_CVR_FIELD_VALS)) begin
      wr_fld_covg = new();
      rd_fld_covg = new();
    end
  endfunction

endclass


/////////////////////////////////////////////////////
//                rx_psc_a2
/////////////////////////////////////////////////////
class T_rx_psc_a2_487 extends cdns_uvm_reg;

  `uvm_object_utils(T_rx_psc_a2_487)
  rand uvm_reg_field rx_psc_a2_0;
  rand uvm_reg_field rx_psc_a2_1;
  rand uvm_reg_field rx_psc_a2_2;
  rand uvm_reg_field rx_psc_a2_3;
  rand uvm_reg_field rx_psc_a2_4;
  rand uvm_reg_field rx_psc_a2_5;
  rand uvm_reg_field rx_psc_a2_6;
  rand uvm_reg_field rx_psc_a2_7;
  rand uvm_reg_field rx_psc_a2_8;
  rand uvm_reg_field rx_psc_a2_9;
  rand uvm_reg_field rx_psc_a2_10;
  rand uvm_reg_field rx_psc_a2_11;
  rand uvm_reg_field rx_psc_a2_12;
  rand uvm_reg_field rx_psc_a2_13;
  rand uvm_reg_field rx_psc_a2_14;
  rand uvm_reg_field rx_psc_a2_15;
  rand uvm_reg_field rx_psc_a2_31_16;
  
  covergroup wr_fld_covg;
    rx_psc_a2_0: coverpoint rx_psc_a2_0.value[0:0];
    rx_psc_a2_1: coverpoint rx_psc_a2_1.value[0:0];
    rx_psc_a2_2: coverpoint rx_psc_a2_2.value[0:0];
    rx_psc_a2_3: coverpoint rx_psc_a2_3.value[0:0];
    rx_psc_a2_4: coverpoint rx_psc_a2_4.value[0:0];
    rx_psc_a2_5: coverpoint rx_psc_a2_5.value[0:0];
    rx_psc_a2_6: coverpoint rx_psc_a2_6.value[0:0];
    rx_psc_a2_7: coverpoint rx_psc_a2_7.value[0:0];
    rx_psc_a2_8: coverpoint rx_psc_a2_8.value[0:0];
    rx_psc_a2_9: coverpoint rx_psc_a2_9.value[0:0];
    rx_psc_a2_10: coverpoint rx_psc_a2_10.value[0:0];
    rx_psc_a2_11: coverpoint rx_psc_a2_11.value[0:0];
    rx_psc_a2_12: coverpoint rx_psc_a2_12.value[0:0];
    rx_psc_a2_13: coverpoint rx_psc_a2_13.value[0:0];
    rx_psc_a2_14: coverpoint rx_psc_a2_14.value[0:0];
    rx_psc_a2_15: coverpoint rx_psc_a2_15.value[0:0];
    rx_psc_a2_31_16: coverpoint rx_psc_a2_31_16.value[15:0];
  endgroup
  covergroup rd_fld_covg;
    rx_psc_a2_0: coverpoint rx_psc_a2_0.value[0:0];
    rx_psc_a2_1: coverpoint rx_psc_a2_1.value[0:0];
    rx_psc_a2_2: coverpoint rx_psc_a2_2.value[0:0];
    rx_psc_a2_3: coverpoint rx_psc_a2_3.value[0:0];
    rx_psc_a2_4: coverpoint rx_psc_a2_4.value[0:0];
    rx_psc_a2_5: coverpoint rx_psc_a2_5.value[0:0];
    rx_psc_a2_6: coverpoint rx_psc_a2_6.value[0:0];
    rx_psc_a2_7: coverpoint rx_psc_a2_7.value[0:0];
    rx_psc_a2_8: coverpoint rx_psc_a2_8.value[0:0];
    rx_psc_a2_9: coverpoint rx_psc_a2_9.value[0:0];
    rx_psc_a2_10: coverpoint rx_psc_a2_10.value[0:0];
    rx_psc_a2_11: coverpoint rx_psc_a2_11.value[0:0];
    rx_psc_a2_12: coverpoint rx_psc_a2_12.value[0:0];
    rx_psc_a2_13: coverpoint rx_psc_a2_13.value[0:0];
    rx_psc_a2_14: coverpoint rx_psc_a2_14.value[0:0];
    rx_psc_a2_15: coverpoint rx_psc_a2_15.value[0:0];
    rx_psc_a2_31_16: coverpoint rx_psc_a2_31_16.value[15:0];
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
    
    rx_psc_a2_0 = fld_set[0];
    rx_psc_a2_1 = fld_set[1];
    rx_psc_a2_2 = fld_set[2];
    rx_psc_a2_3 = fld_set[3];
    rx_psc_a2_4 = fld_set[4];
    rx_psc_a2_5 = fld_set[5];
    rx_psc_a2_6 = fld_set[6];
    rx_psc_a2_7 = fld_set[7];
    rx_psc_a2_8 = fld_set[8];
    rx_psc_a2_9 = fld_set[9];
    rx_psc_a2_10 = fld_set[10];
    rx_psc_a2_11 = fld_set[11];
    rx_psc_a2_12 = fld_set[12];
    rx_psc_a2_13 = fld_set[13];
    rx_psc_a2_14 = fld_set[14];
    rx_psc_a2_15 = fld_set[15];
    rx_psc_a2_31_16 = fld_set[16];
  endfunction

  function new(input string name="T_rx_psc_a2_487");
    super.new(name, 32, build_coverage(UVM_CVR_FIELD_VALS));
    if (has_coverage(UVM_CVR_FIELD_VALS)) begin
      wr_fld_covg = new();
      rd_fld_covg = new();
    end
  endfunction

endclass


/////////////////////////////////////////////////////
//                rx_psc_a3
/////////////////////////////////////////////////////
class T_rx_psc_a3_488 extends cdns_uvm_reg;

  `uvm_object_utils(T_rx_psc_a3_488)
  rand uvm_reg_field rx_psc_a3_0;
  rand uvm_reg_field rx_psc_a3_1;
  rand uvm_reg_field rx_psc_a3_2;
  rand uvm_reg_field rx_psc_a3_3;
  rand uvm_reg_field rx_psc_a3_4;
  rand uvm_reg_field rx_psc_a3_5;
  rand uvm_reg_field rx_psc_a3_6;
  rand uvm_reg_field rx_psc_a3_7;
  rand uvm_reg_field rx_psc_a3_8;
  rand uvm_reg_field rx_psc_a3_9;
  rand uvm_reg_field rx_psc_a3_10;
  rand uvm_reg_field rx_psc_a3_11;
  rand uvm_reg_field rx_psc_a3_12;
  rand uvm_reg_field rx_psc_a3_13;
  rand uvm_reg_field rx_psc_a3_14;
  rand uvm_reg_field rx_psc_a3_15;
  rand uvm_reg_field rx_psc_a3_31_16;
  
  covergroup wr_fld_covg;
    rx_psc_a3_0: coverpoint rx_psc_a3_0.value[0:0];
    rx_psc_a3_1: coverpoint rx_psc_a3_1.value[0:0];
    rx_psc_a3_2: coverpoint rx_psc_a3_2.value[0:0];
    rx_psc_a3_3: coverpoint rx_psc_a3_3.value[0:0];
    rx_psc_a3_4: coverpoint rx_psc_a3_4.value[0:0];
    rx_psc_a3_5: coverpoint rx_psc_a3_5.value[0:0];
    rx_psc_a3_6: coverpoint rx_psc_a3_6.value[0:0];
    rx_psc_a3_7: coverpoint rx_psc_a3_7.value[0:0];
    rx_psc_a3_8: coverpoint rx_psc_a3_8.value[0:0];
    rx_psc_a3_9: coverpoint rx_psc_a3_9.value[0:0];
    rx_psc_a3_10: coverpoint rx_psc_a3_10.value[0:0];
    rx_psc_a3_11: coverpoint rx_psc_a3_11.value[0:0];
    rx_psc_a3_12: coverpoint rx_psc_a3_12.value[0:0];
    rx_psc_a3_13: coverpoint rx_psc_a3_13.value[0:0];
    rx_psc_a3_14: coverpoint rx_psc_a3_14.value[0:0];
    rx_psc_a3_15: coverpoint rx_psc_a3_15.value[0:0];
    rx_psc_a3_31_16: coverpoint rx_psc_a3_31_16.value[15:0];
  endgroup
  covergroup rd_fld_covg;
    rx_psc_a3_0: coverpoint rx_psc_a3_0.value[0:0];
    rx_psc_a3_1: coverpoint rx_psc_a3_1.value[0:0];
    rx_psc_a3_2: coverpoint rx_psc_a3_2.value[0:0];
    rx_psc_a3_3: coverpoint rx_psc_a3_3.value[0:0];
    rx_psc_a3_4: coverpoint rx_psc_a3_4.value[0:0];
    rx_psc_a3_5: coverpoint rx_psc_a3_5.value[0:0];
    rx_psc_a3_6: coverpoint rx_psc_a3_6.value[0:0];
    rx_psc_a3_7: coverpoint rx_psc_a3_7.value[0:0];
    rx_psc_a3_8: coverpoint rx_psc_a3_8.value[0:0];
    rx_psc_a3_9: coverpoint rx_psc_a3_9.value[0:0];
    rx_psc_a3_10: coverpoint rx_psc_a3_10.value[0:0];
    rx_psc_a3_11: coverpoint rx_psc_a3_11.value[0:0];
    rx_psc_a3_12: coverpoint rx_psc_a3_12.value[0:0];
    rx_psc_a3_13: coverpoint rx_psc_a3_13.value[0:0];
    rx_psc_a3_14: coverpoint rx_psc_a3_14.value[0:0];
    rx_psc_a3_15: coverpoint rx_psc_a3_15.value[0:0];
    rx_psc_a3_31_16: coverpoint rx_psc_a3_31_16.value[15:0];
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
    
    rx_psc_a3_0 = fld_set[0];
    rx_psc_a3_1 = fld_set[1];
    rx_psc_a3_2 = fld_set[2];
    rx_psc_a3_3 = fld_set[3];
    rx_psc_a3_4 = fld_set[4];
    rx_psc_a3_5 = fld_set[5];
    rx_psc_a3_6 = fld_set[6];
    rx_psc_a3_7 = fld_set[7];
    rx_psc_a3_8 = fld_set[8];
    rx_psc_a3_9 = fld_set[9];
    rx_psc_a3_10 = fld_set[10];
    rx_psc_a3_11 = fld_set[11];
    rx_psc_a3_12 = fld_set[12];
    rx_psc_a3_13 = fld_set[13];
    rx_psc_a3_14 = fld_set[14];
    rx_psc_a3_15 = fld_set[15];
    rx_psc_a3_31_16 = fld_set[16];
  endfunction

  function new(input string name="T_rx_psc_a3_488");
    super.new(name, 32, build_coverage(UVM_CVR_FIELD_VALS));
    if (has_coverage(UVM_CVR_FIELD_VALS)) begin
      wr_fld_covg = new();
      rd_fld_covg = new();
    end
  endfunction

endclass


/////////////////////////////////////////////////////
//                rx_psc_a4
/////////////////////////////////////////////////////
class T_rx_psc_a4_489 extends cdns_uvm_reg;

  `uvm_object_utils(T_rx_psc_a4_489)
  rand uvm_reg_field rx_psc_a4_0;
  rand uvm_reg_field rx_psc_a4_1;
  rand uvm_reg_field rx_psc_a4_2;
  rand uvm_reg_field rx_psc_a4_3;
  rand uvm_reg_field rx_psc_a4_4;
  rand uvm_reg_field rx_psc_a4_5;
  rand uvm_reg_field rx_psc_a4_6;
  rand uvm_reg_field rx_psc_a4_7;
  rand uvm_reg_field rx_psc_a4_8;
  rand uvm_reg_field rx_psc_a4_9;
  rand uvm_reg_field rx_psc_a4_10;
  rand uvm_reg_field rx_psc_a4_11;
  rand uvm_reg_field rx_psc_a4_12;
  rand uvm_reg_field rx_psc_a4_13;
  rand uvm_reg_field rx_psc_a4_14;
  rand uvm_reg_field rx_psc_a4_15;
  rand uvm_reg_field rx_psc_a4_31_16;
  
  covergroup wr_fld_covg;
    rx_psc_a4_0: coverpoint rx_psc_a4_0.value[0:0];
    rx_psc_a4_1: coverpoint rx_psc_a4_1.value[0:0];
    rx_psc_a4_2: coverpoint rx_psc_a4_2.value[0:0];
    rx_psc_a4_3: coverpoint rx_psc_a4_3.value[0:0];
    rx_psc_a4_4: coverpoint rx_psc_a4_4.value[0:0];
    rx_psc_a4_5: coverpoint rx_psc_a4_5.value[0:0];
    rx_psc_a4_6: coverpoint rx_psc_a4_6.value[0:0];
    rx_psc_a4_7: coverpoint rx_psc_a4_7.value[0:0];
    rx_psc_a4_8: coverpoint rx_psc_a4_8.value[0:0];
    rx_psc_a4_9: coverpoint rx_psc_a4_9.value[0:0];
    rx_psc_a4_10: coverpoint rx_psc_a4_10.value[0:0];
    rx_psc_a4_11: coverpoint rx_psc_a4_11.value[0:0];
    rx_psc_a4_12: coverpoint rx_psc_a4_12.value[0:0];
    rx_psc_a4_13: coverpoint rx_psc_a4_13.value[0:0];
    rx_psc_a4_14: coverpoint rx_psc_a4_14.value[0:0];
    rx_psc_a4_15: coverpoint rx_psc_a4_15.value[0:0];
    rx_psc_a4_31_16: coverpoint rx_psc_a4_31_16.value[15:0];
  endgroup
  covergroup rd_fld_covg;
    rx_psc_a4_0: coverpoint rx_psc_a4_0.value[0:0];
    rx_psc_a4_1: coverpoint rx_psc_a4_1.value[0:0];
    rx_psc_a4_2: coverpoint rx_psc_a4_2.value[0:0];
    rx_psc_a4_3: coverpoint rx_psc_a4_3.value[0:0];
    rx_psc_a4_4: coverpoint rx_psc_a4_4.value[0:0];
    rx_psc_a4_5: coverpoint rx_psc_a4_5.value[0:0];
    rx_psc_a4_6: coverpoint rx_psc_a4_6.value[0:0];
    rx_psc_a4_7: coverpoint rx_psc_a4_7.value[0:0];
    rx_psc_a4_8: coverpoint rx_psc_a4_8.value[0:0];
    rx_psc_a4_9: coverpoint rx_psc_a4_9.value[0:0];
    rx_psc_a4_10: coverpoint rx_psc_a4_10.value[0:0];
    rx_psc_a4_11: coverpoint rx_psc_a4_11.value[0:0];
    rx_psc_a4_12: coverpoint rx_psc_a4_12.value[0:0];
    rx_psc_a4_13: coverpoint rx_psc_a4_13.value[0:0];
    rx_psc_a4_14: coverpoint rx_psc_a4_14.value[0:0];
    rx_psc_a4_15: coverpoint rx_psc_a4_15.value[0:0];
    rx_psc_a4_31_16: coverpoint rx_psc_a4_31_16.value[15:0];
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
    
    rx_psc_a4_0 = fld_set[0];
    rx_psc_a4_1 = fld_set[1];
    rx_psc_a4_2 = fld_set[2];
    rx_psc_a4_3 = fld_set[3];
    rx_psc_a4_4 = fld_set[4];
    rx_psc_a4_5 = fld_set[5];
    rx_psc_a4_6 = fld_set[6];
    rx_psc_a4_7 = fld_set[7];
    rx_psc_a4_8 = fld_set[8];
    rx_psc_a4_9 = fld_set[9];
    rx_psc_a4_10 = fld_set[10];
    rx_psc_a4_11 = fld_set[11];
    rx_psc_a4_12 = fld_set[12];
    rx_psc_a4_13 = fld_set[13];
    rx_psc_a4_14 = fld_set[14];
    rx_psc_a4_15 = fld_set[15];
    rx_psc_a4_31_16 = fld_set[16];
  endfunction

  function new(input string name="T_rx_psc_a4_489");
    super.new(name, 32, build_coverage(UVM_CVR_FIELD_VALS));
    if (has_coverage(UVM_CVR_FIELD_VALS)) begin
      wr_fld_covg = new();
      rd_fld_covg = new();
    end
  endfunction

endclass


/////////////////////////////////////////////////////
//                rx_psc_a5
/////////////////////////////////////////////////////
class T_rx_psc_a5_490 extends cdns_uvm_reg;

  `uvm_object_utils(T_rx_psc_a5_490)
  rand uvm_reg_field rx_psc_a5_0;
  rand uvm_reg_field rx_psc_a5_1;
  rand uvm_reg_field rx_psc_a5_2;
  rand uvm_reg_field rx_psc_a5_3;
  rand uvm_reg_field rx_psc_a5_4;
  rand uvm_reg_field rx_psc_a5_5;
  rand uvm_reg_field rx_psc_a5_6;
  rand uvm_reg_field rx_psc_a5_7;
  rand uvm_reg_field rx_psc_a5_8;
  rand uvm_reg_field rx_psc_a5_9;
  rand uvm_reg_field rx_psc_a5_10;
  rand uvm_reg_field rx_psc_a5_11;
  rand uvm_reg_field rx_psc_a5_12;
  rand uvm_reg_field rx_psc_a5_13;
  rand uvm_reg_field rx_psc_a5_14;
  rand uvm_reg_field rx_psc_a5_15;
  rand uvm_reg_field rx_psc_a5_31_16;
  
  covergroup wr_fld_covg;
    rx_psc_a5_0: coverpoint rx_psc_a5_0.value[0:0];
    rx_psc_a5_1: coverpoint rx_psc_a5_1.value[0:0];
    rx_psc_a5_2: coverpoint rx_psc_a5_2.value[0:0];
    rx_psc_a5_3: coverpoint rx_psc_a5_3.value[0:0];
    rx_psc_a5_4: coverpoint rx_psc_a5_4.value[0:0];
    rx_psc_a5_5: coverpoint rx_psc_a5_5.value[0:0];
    rx_psc_a5_6: coverpoint rx_psc_a5_6.value[0:0];
    rx_psc_a5_7: coverpoint rx_psc_a5_7.value[0:0];
    rx_psc_a5_8: coverpoint rx_psc_a5_8.value[0:0];
    rx_psc_a5_9: coverpoint rx_psc_a5_9.value[0:0];
    rx_psc_a5_10: coverpoint rx_psc_a5_10.value[0:0];
    rx_psc_a5_11: coverpoint rx_psc_a5_11.value[0:0];
    rx_psc_a5_12: coverpoint rx_psc_a5_12.value[0:0];
    rx_psc_a5_13: coverpoint rx_psc_a5_13.value[0:0];
    rx_psc_a5_14: coverpoint rx_psc_a5_14.value[0:0];
    rx_psc_a5_15: coverpoint rx_psc_a5_15.value[0:0];
    rx_psc_a5_31_16: coverpoint rx_psc_a5_31_16.value[15:0];
  endgroup
  covergroup rd_fld_covg;
    rx_psc_a5_0: coverpoint rx_psc_a5_0.value[0:0];
    rx_psc_a5_1: coverpoint rx_psc_a5_1.value[0:0];
    rx_psc_a5_2: coverpoint rx_psc_a5_2.value[0:0];
    rx_psc_a5_3: coverpoint rx_psc_a5_3.value[0:0];
    rx_psc_a5_4: coverpoint rx_psc_a5_4.value[0:0];
    rx_psc_a5_5: coverpoint rx_psc_a5_5.value[0:0];
    rx_psc_a5_6: coverpoint rx_psc_a5_6.value[0:0];
    rx_psc_a5_7: coverpoint rx_psc_a5_7.value[0:0];
    rx_psc_a5_8: coverpoint rx_psc_a5_8.value[0:0];
    rx_psc_a5_9: coverpoint rx_psc_a5_9.value[0:0];
    rx_psc_a5_10: coverpoint rx_psc_a5_10.value[0:0];
    rx_psc_a5_11: coverpoint rx_psc_a5_11.value[0:0];
    rx_psc_a5_12: coverpoint rx_psc_a5_12.value[0:0];
    rx_psc_a5_13: coverpoint rx_psc_a5_13.value[0:0];
    rx_psc_a5_14: coverpoint rx_psc_a5_14.value[0:0];
    rx_psc_a5_15: coverpoint rx_psc_a5_15.value[0:0];
    rx_psc_a5_31_16: coverpoint rx_psc_a5_31_16.value[15:0];
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
    
    rx_psc_a5_0 = fld_set[0];
    rx_psc_a5_1 = fld_set[1];
    rx_psc_a5_2 = fld_set[2];
    rx_psc_a5_3 = fld_set[3];
    rx_psc_a5_4 = fld_set[4];
    rx_psc_a5_5 = fld_set[5];
    rx_psc_a5_6 = fld_set[6];
    rx_psc_a5_7 = fld_set[7];
    rx_psc_a5_8 = fld_set[8];
    rx_psc_a5_9 = fld_set[9];
    rx_psc_a5_10 = fld_set[10];
    rx_psc_a5_11 = fld_set[11];
    rx_psc_a5_12 = fld_set[12];
    rx_psc_a5_13 = fld_set[13];
    rx_psc_a5_14 = fld_set[14];
    rx_psc_a5_15 = fld_set[15];
    rx_psc_a5_31_16 = fld_set[16];
  endfunction

  function new(input string name="T_rx_psc_a5_490");
    super.new(name, 32, build_coverage(UVM_CVR_FIELD_VALS));
    if (has_coverage(UVM_CVR_FIELD_VALS)) begin
      wr_fld_covg = new();
      rd_fld_covg = new();
    end
  endfunction

endclass


/////////////////////////////////////////////////////
//                rx_psc_cal
/////////////////////////////////////////////////////
class T_rx_psc_cal_491 extends cdns_uvm_reg;

  `uvm_object_utils(T_rx_psc_cal_491)
  rand uvm_reg_field rx_psc_cal_0;
  rand uvm_reg_field rx_psc_cal_1;
  rand uvm_reg_field rx_psc_cal_2;
  rand uvm_reg_field rx_psc_cal_3;
  rand uvm_reg_field rx_psc_cal_4;
  rand uvm_reg_field rx_psc_cal_5;
  rand uvm_reg_field rx_psc_cal_6;
  rand uvm_reg_field rx_psc_cal_7;
  rand uvm_reg_field rx_psc_cal_8;
  rand uvm_reg_field rx_psc_cal_9;
  rand uvm_reg_field rx_psc_cal_10;
  rand uvm_reg_field rx_psc_cal_11;
  rand uvm_reg_field rx_psc_cal_12;
  rand uvm_reg_field rx_psc_cal_13;
  rand uvm_reg_field rx_psc_cal_14;
  rand uvm_reg_field rx_psc_cal_15;
  rand uvm_reg_field rx_psc_cal_31_16;
  
  covergroup wr_fld_covg;
    rx_psc_cal_0: coverpoint rx_psc_cal_0.value[0:0];
    rx_psc_cal_1: coverpoint rx_psc_cal_1.value[0:0];
    rx_psc_cal_2: coverpoint rx_psc_cal_2.value[0:0];
    rx_psc_cal_3: coverpoint rx_psc_cal_3.value[0:0];
    rx_psc_cal_4: coverpoint rx_psc_cal_4.value[0:0];
    rx_psc_cal_5: coverpoint rx_psc_cal_5.value[0:0];
    rx_psc_cal_6: coverpoint rx_psc_cal_6.value[0:0];
    rx_psc_cal_7: coverpoint rx_psc_cal_7.value[0:0];
    rx_psc_cal_8: coverpoint rx_psc_cal_8.value[0:0];
    rx_psc_cal_9: coverpoint rx_psc_cal_9.value[0:0];
    rx_psc_cal_10: coverpoint rx_psc_cal_10.value[0:0];
    rx_psc_cal_11: coverpoint rx_psc_cal_11.value[0:0];
    rx_psc_cal_12: coverpoint rx_psc_cal_12.value[0:0];
    rx_psc_cal_13: coverpoint rx_psc_cal_13.value[0:0];
    rx_psc_cal_14: coverpoint rx_psc_cal_14.value[0:0];
    rx_psc_cal_15: coverpoint rx_psc_cal_15.value[0:0];
    rx_psc_cal_31_16: coverpoint rx_psc_cal_31_16.value[15:0];
  endgroup
  covergroup rd_fld_covg;
    rx_psc_cal_0: coverpoint rx_psc_cal_0.value[0:0];
    rx_psc_cal_1: coverpoint rx_psc_cal_1.value[0:0];
    rx_psc_cal_2: coverpoint rx_psc_cal_2.value[0:0];
    rx_psc_cal_3: coverpoint rx_psc_cal_3.value[0:0];
    rx_psc_cal_4: coverpoint rx_psc_cal_4.value[0:0];
    rx_psc_cal_5: coverpoint rx_psc_cal_5.value[0:0];
    rx_psc_cal_6: coverpoint rx_psc_cal_6.value[0:0];
    rx_psc_cal_7: coverpoint rx_psc_cal_7.value[0:0];
    rx_psc_cal_8: coverpoint rx_psc_cal_8.value[0:0];
    rx_psc_cal_9: coverpoint rx_psc_cal_9.value[0:0];
    rx_psc_cal_10: coverpoint rx_psc_cal_10.value[0:0];
    rx_psc_cal_11: coverpoint rx_psc_cal_11.value[0:0];
    rx_psc_cal_12: coverpoint rx_psc_cal_12.value[0:0];
    rx_psc_cal_13: coverpoint rx_psc_cal_13.value[0:0];
    rx_psc_cal_14: coverpoint rx_psc_cal_14.value[0:0];
    rx_psc_cal_15: coverpoint rx_psc_cal_15.value[0:0];
    rx_psc_cal_31_16: coverpoint rx_psc_cal_31_16.value[15:0];
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
    
    rx_psc_cal_0 = fld_set[0];
    rx_psc_cal_1 = fld_set[1];
    rx_psc_cal_2 = fld_set[2];
    rx_psc_cal_3 = fld_set[3];
    rx_psc_cal_4 = fld_set[4];
    rx_psc_cal_5 = fld_set[5];
    rx_psc_cal_6 = fld_set[6];
    rx_psc_cal_7 = fld_set[7];
    rx_psc_cal_8 = fld_set[8];
    rx_psc_cal_9 = fld_set[9];
    rx_psc_cal_10 = fld_set[10];
    rx_psc_cal_11 = fld_set[11];
    rx_psc_cal_12 = fld_set[12];
    rx_psc_cal_13 = fld_set[13];
    rx_psc_cal_14 = fld_set[14];
    rx_psc_cal_15 = fld_set[15];
    rx_psc_cal_31_16 = fld_set[16];
  endfunction

  function new(input string name="T_rx_psc_cal_491");
    super.new(name, 32, build_coverage(UVM_CVR_FIELD_VALS));
    if (has_coverage(UVM_CVR_FIELD_VALS)) begin
      wr_fld_covg = new();
      rd_fld_covg = new();
    end
  endfunction

endclass


/////////////////////////////////////////////////////
//                rx_psc_rdy
/////////////////////////////////////////////////////
class T_rx_psc_rdy_492 extends cdns_uvm_reg;

  `uvm_object_utils(T_rx_psc_rdy_492)
  rand uvm_reg_field rx_psc_rdy_0;
  rand uvm_reg_field rx_psc_rdy_1;
  rand uvm_reg_field rx_psc_rdy_2;
  rand uvm_reg_field rx_psc_rdy_3;
  rand uvm_reg_field rx_psc_rdy_4;
  rand uvm_reg_field rx_psc_rdy_5;
  rand uvm_reg_field rx_psc_rdy_6;
  rand uvm_reg_field rx_psc_rdy_7;
  rand uvm_reg_field rx_psc_rdy_8;
  rand uvm_reg_field rx_psc_rdy_9;
  rand uvm_reg_field rx_psc_rdy_10;
  rand uvm_reg_field rx_psc_rdy_11;
  rand uvm_reg_field rx_psc_rdy_12;
  rand uvm_reg_field rx_psc_rdy_13;
  rand uvm_reg_field rx_psc_rdy_14;
  rand uvm_reg_field rx_psc_rdy_15;
  rand uvm_reg_field rx_psc_rdy_31_16;
  
  covergroup wr_fld_covg;
    rx_psc_rdy_0: coverpoint rx_psc_rdy_0.value[0:0];
    rx_psc_rdy_1: coverpoint rx_psc_rdy_1.value[0:0];
    rx_psc_rdy_2: coverpoint rx_psc_rdy_2.value[0:0];
    rx_psc_rdy_3: coverpoint rx_psc_rdy_3.value[0:0];
    rx_psc_rdy_4: coverpoint rx_psc_rdy_4.value[0:0];
    rx_psc_rdy_5: coverpoint rx_psc_rdy_5.value[0:0];
    rx_psc_rdy_6: coverpoint rx_psc_rdy_6.value[0:0];
    rx_psc_rdy_7: coverpoint rx_psc_rdy_7.value[0:0];
    rx_psc_rdy_8: coverpoint rx_psc_rdy_8.value[0:0];
    rx_psc_rdy_9: coverpoint rx_psc_rdy_9.value[0:0];
    rx_psc_rdy_10: coverpoint rx_psc_rdy_10.value[0:0];
    rx_psc_rdy_11: coverpoint rx_psc_rdy_11.value[0:0];
    rx_psc_rdy_12: coverpoint rx_psc_rdy_12.value[0:0];
    rx_psc_rdy_13: coverpoint rx_psc_rdy_13.value[0:0];
    rx_psc_rdy_14: coverpoint rx_psc_rdy_14.value[0:0];
    rx_psc_rdy_15: coverpoint rx_psc_rdy_15.value[0:0];
    rx_psc_rdy_31_16: coverpoint rx_psc_rdy_31_16.value[15:0];
  endgroup
  covergroup rd_fld_covg;
    rx_psc_rdy_0: coverpoint rx_psc_rdy_0.value[0:0];
    rx_psc_rdy_1: coverpoint rx_psc_rdy_1.value[0:0];
    rx_psc_rdy_2: coverpoint rx_psc_rdy_2.value[0:0];
    rx_psc_rdy_3: coverpoint rx_psc_rdy_3.value[0:0];
    rx_psc_rdy_4: coverpoint rx_psc_rdy_4.value[0:0];
    rx_psc_rdy_5: coverpoint rx_psc_rdy_5.value[0:0];
    rx_psc_rdy_6: coverpoint rx_psc_rdy_6.value[0:0];
    rx_psc_rdy_7: coverpoint rx_psc_rdy_7.value[0:0];
    rx_psc_rdy_8: coverpoint rx_psc_rdy_8.value[0:0];
    rx_psc_rdy_9: coverpoint rx_psc_rdy_9.value[0:0];
    rx_psc_rdy_10: coverpoint rx_psc_rdy_10.value[0:0];
    rx_psc_rdy_11: coverpoint rx_psc_rdy_11.value[0:0];
    rx_psc_rdy_12: coverpoint rx_psc_rdy_12.value[0:0];
    rx_psc_rdy_13: coverpoint rx_psc_rdy_13.value[0:0];
    rx_psc_rdy_14: coverpoint rx_psc_rdy_14.value[0:0];
    rx_psc_rdy_15: coverpoint rx_psc_rdy_15.value[0:0];
    rx_psc_rdy_31_16: coverpoint rx_psc_rdy_31_16.value[15:0];
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
    
    rx_psc_rdy_0 = fld_set[0];
    rx_psc_rdy_1 = fld_set[1];
    rx_psc_rdy_2 = fld_set[2];
    rx_psc_rdy_3 = fld_set[3];
    rx_psc_rdy_4 = fld_set[4];
    rx_psc_rdy_5 = fld_set[5];
    rx_psc_rdy_6 = fld_set[6];
    rx_psc_rdy_7 = fld_set[7];
    rx_psc_rdy_8 = fld_set[8];
    rx_psc_rdy_9 = fld_set[9];
    rx_psc_rdy_10 = fld_set[10];
    rx_psc_rdy_11 = fld_set[11];
    rx_psc_rdy_12 = fld_set[12];
    rx_psc_rdy_13 = fld_set[13];
    rx_psc_rdy_14 = fld_set[14];
    rx_psc_rdy_15 = fld_set[15];
    rx_psc_rdy_31_16 = fld_set[16];
  endfunction

  function new(input string name="T_rx_psc_rdy_492");
    super.new(name, 32, build_coverage(UVM_CVR_FIELD_VALS));
    if (has_coverage(UVM_CVR_FIELD_VALS)) begin
      wr_fld_covg = new();
      rd_fld_covg = new();
    end
  endfunction

endclass


/////////////////////////////////////////////////////
//                rx_qcccal_ctrl
/////////////////////////////////////////////////////
class T_rx_qcccal_ctrl_550 extends cdns_uvm_reg;

  `uvm_object_utils(T_rx_qcccal_ctrl_550)
  rand uvm_reg_field rx_qcccal_ctrl_4_0;
  rand uvm_reg_field rx_qcccal_ctrl_11_5;
  rand uvm_reg_field rx_qcccal_ctrl_12;
  rand uvm_reg_field rx_qcccal_ctrl_13;
  rand uvm_reg_field rx_qcccal_ctrl_14;
  rand uvm_reg_field rx_qcccal_ctrl_15;
  rand uvm_reg_field rx_qcccal_ctrl_31_16;
  
  covergroup wr_fld_covg;
    rx_qcccal_ctrl_4_0: coverpoint rx_qcccal_ctrl_4_0.value[4:0];
    rx_qcccal_ctrl_11_5: coverpoint rx_qcccal_ctrl_11_5.value[6:0];
    rx_qcccal_ctrl_12: coverpoint rx_qcccal_ctrl_12.value[0:0];
    rx_qcccal_ctrl_13: coverpoint rx_qcccal_ctrl_13.value[0:0];
    rx_qcccal_ctrl_14: coverpoint rx_qcccal_ctrl_14.value[0:0];
    rx_qcccal_ctrl_15: coverpoint rx_qcccal_ctrl_15.value[0:0];
    rx_qcccal_ctrl_31_16: coverpoint rx_qcccal_ctrl_31_16.value[15:0];
  endgroup
  covergroup rd_fld_covg;
    rx_qcccal_ctrl_4_0: coverpoint rx_qcccal_ctrl_4_0.value[4:0];
    rx_qcccal_ctrl_11_5: coverpoint rx_qcccal_ctrl_11_5.value[6:0];
    rx_qcccal_ctrl_12: coverpoint rx_qcccal_ctrl_12.value[0:0];
    rx_qcccal_ctrl_13: coverpoint rx_qcccal_ctrl_13.value[0:0];
    rx_qcccal_ctrl_14: coverpoint rx_qcccal_ctrl_14.value[0:0];
    rx_qcccal_ctrl_15: coverpoint rx_qcccal_ctrl_15.value[0:0];
    rx_qcccal_ctrl_31_16: coverpoint rx_qcccal_ctrl_31_16.value[15:0];
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
    
    rx_qcccal_ctrl_4_0 = fld_set[0];
    rx_qcccal_ctrl_11_5 = fld_set[1];
    rx_qcccal_ctrl_12 = fld_set[2];
    rx_qcccal_ctrl_13 = fld_set[3];
    rx_qcccal_ctrl_14 = fld_set[4];
    rx_qcccal_ctrl_15 = fld_set[5];
    rx_qcccal_ctrl_31_16 = fld_set[6];
  endfunction

  function new(input string name="T_rx_qcccal_ctrl_550");
    super.new(name, 32, build_coverage(UVM_CVR_FIELD_VALS));
    if (has_coverage(UVM_CVR_FIELD_VALS)) begin
      wr_fld_covg = new();
      rd_fld_covg = new();
    end
  endfunction

endclass


/////////////////////////////////////////////////////
//                rx_qcccal_init_tmr
/////////////////////////////////////////////////////
class T_rx_qcccal_init_tmr_554 extends cdns_uvm_reg;

  `uvm_object_utils(T_rx_qcccal_init_tmr_554)
  rand uvm_reg_field rx_qcccal_init_tmr_8_0;
  rand uvm_reg_field rx_qcccal_init_tmr_15_9;
  rand uvm_reg_field rx_qcccal_init_tmr_31_16;
  
  covergroup wr_fld_covg;
    rx_qcccal_init_tmr_8_0: coverpoint rx_qcccal_init_tmr_8_0.value[8:0];
    rx_qcccal_init_tmr_15_9: coverpoint rx_qcccal_init_tmr_15_9.value[6:0];
    rx_qcccal_init_tmr_31_16: coverpoint rx_qcccal_init_tmr_31_16.value[15:0];
  endgroup
  covergroup rd_fld_covg;
    rx_qcccal_init_tmr_8_0: coverpoint rx_qcccal_init_tmr_8_0.value[8:0];
    rx_qcccal_init_tmr_15_9: coverpoint rx_qcccal_init_tmr_15_9.value[6:0];
    rx_qcccal_init_tmr_31_16: coverpoint rx_qcccal_init_tmr_31_16.value[15:0];
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
    
    rx_qcccal_init_tmr_8_0 = fld_set[0];
    rx_qcccal_init_tmr_15_9 = fld_set[1];
    rx_qcccal_init_tmr_31_16 = fld_set[2];
  endfunction

  function new(input string name="T_rx_qcccal_init_tmr_554");
    super.new(name, 32, build_coverage(UVM_CVR_FIELD_VALS));
    if (has_coverage(UVM_CVR_FIELD_VALS)) begin
      wr_fld_covg = new();
      rd_fld_covg = new();
    end
  endfunction

endclass


/////////////////////////////////////////////////////
//                rx_qcccal_iter_tmr
/////////////////////////////////////////////////////
class T_rx_qcccal_iter_tmr_555 extends cdns_uvm_reg;

  `uvm_object_utils(T_rx_qcccal_iter_tmr_555)
  rand uvm_reg_field rx_qcccal_iter_tmr_8_0;
  rand uvm_reg_field rx_qcccal_iter_tmr_15_9;
  rand uvm_reg_field rx_qcccal_iter_tmr_31_16;
  
  covergroup wr_fld_covg;
    rx_qcccal_iter_tmr_8_0: coverpoint rx_qcccal_iter_tmr_8_0.value[8:0];
    rx_qcccal_iter_tmr_15_9: coverpoint rx_qcccal_iter_tmr_15_9.value[6:0];
    rx_qcccal_iter_tmr_31_16: coverpoint rx_qcccal_iter_tmr_31_16.value[15:0];
  endgroup
  covergroup rd_fld_covg;
    rx_qcccal_iter_tmr_8_0: coverpoint rx_qcccal_iter_tmr_8_0.value[8:0];
    rx_qcccal_iter_tmr_15_9: coverpoint rx_qcccal_iter_tmr_15_9.value[6:0];
    rx_qcccal_iter_tmr_31_16: coverpoint rx_qcccal_iter_tmr_31_16.value[15:0];
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
    
    rx_qcccal_iter_tmr_8_0 = fld_set[0];
    rx_qcccal_iter_tmr_15_9 = fld_set[1];
    rx_qcccal_iter_tmr_31_16 = fld_set[2];
  endfunction

  function new(input string name="T_rx_qcccal_iter_tmr_555");
    super.new(name, 32, build_coverage(UVM_CVR_FIELD_VALS));
    if (has_coverage(UVM_CVR_FIELD_VALS)) begin
      wr_fld_covg = new();
      rd_fld_covg = new();
    end
  endfunction

endclass


/////////////////////////////////////////////////////
//                rx_qcccal_ovrd
/////////////////////////////////////////////////////
class T_rx_qcccal_ovrd_551 extends cdns_uvm_reg;

  `uvm_object_utils(T_rx_qcccal_ovrd_551)
  rand uvm_reg_field rx_qcccal_ovrd_4_0;
  rand uvm_reg_field rx_qcccal_ovrd_13_5;
  rand uvm_reg_field rx_qcccal_ovrd_14;
  rand uvm_reg_field rx_qcccal_ovrd_15;
  rand uvm_reg_field rx_qcccal_ovrd_31_16;
  
  covergroup wr_fld_covg;
    rx_qcccal_ovrd_4_0: coverpoint rx_qcccal_ovrd_4_0.value[4:0];
    rx_qcccal_ovrd_13_5: coverpoint rx_qcccal_ovrd_13_5.value[8:0];
    rx_qcccal_ovrd_14: coverpoint rx_qcccal_ovrd_14.value[0:0];
    rx_qcccal_ovrd_15: coverpoint rx_qcccal_ovrd_15.value[0:0];
    rx_qcccal_ovrd_31_16: coverpoint rx_qcccal_ovrd_31_16.value[15:0];
  endgroup
  covergroup rd_fld_covg;
    rx_qcccal_ovrd_4_0: coverpoint rx_qcccal_ovrd_4_0.value[4:0];
    rx_qcccal_ovrd_13_5: coverpoint rx_qcccal_ovrd_13_5.value[8:0];
    rx_qcccal_ovrd_14: coverpoint rx_qcccal_ovrd_14.value[0:0];
    rx_qcccal_ovrd_15: coverpoint rx_qcccal_ovrd_15.value[0:0];
    rx_qcccal_ovrd_31_16: coverpoint rx_qcccal_ovrd_31_16.value[15:0];
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
    
    rx_qcccal_ovrd_4_0 = fld_set[0];
    rx_qcccal_ovrd_13_5 = fld_set[1];
    rx_qcccal_ovrd_14 = fld_set[2];
    rx_qcccal_ovrd_15 = fld_set[3];
    rx_qcccal_ovrd_31_16 = fld_set[4];
  endfunction

  function new(input string name="T_rx_qcccal_ovrd_551");
    super.new(name, 32, build_coverage(UVM_CVR_FIELD_VALS));
    if (has_coverage(UVM_CVR_FIELD_VALS)) begin
      wr_fld_covg = new();
      rd_fld_covg = new();
    end
  endfunction

endclass


/////////////////////////////////////////////////////
//                rx_qcccal_start
/////////////////////////////////////////////////////
class T_rx_qcccal_start_552 extends cdns_uvm_reg;

  `uvm_object_utils(T_rx_qcccal_start_552)
  rand uvm_reg_field rx_qcccal_start_4_0;
  rand uvm_reg_field rx_qcccal_start_14_5;
  rand uvm_reg_field rx_qcccal_start_15;
  rand uvm_reg_field rx_qcccal_start_31_16;
  
  covergroup wr_fld_covg;
    rx_qcccal_start_4_0: coverpoint rx_qcccal_start_4_0.value[4:0];
    rx_qcccal_start_14_5: coverpoint rx_qcccal_start_14_5.value[9:0];
    rx_qcccal_start_15: coverpoint rx_qcccal_start_15.value[0:0];
    rx_qcccal_start_31_16: coverpoint rx_qcccal_start_31_16.value[15:0];
  endgroup
  covergroup rd_fld_covg;
    rx_qcccal_start_4_0: coverpoint rx_qcccal_start_4_0.value[4:0];
    rx_qcccal_start_14_5: coverpoint rx_qcccal_start_14_5.value[9:0];
    rx_qcccal_start_15: coverpoint rx_qcccal_start_15.value[0:0];
    rx_qcccal_start_31_16: coverpoint rx_qcccal_start_31_16.value[15:0];
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
    
    rx_qcccal_start_4_0 = fld_set[0];
    rx_qcccal_start_14_5 = fld_set[1];
    rx_qcccal_start_15 = fld_set[2];
    rx_qcccal_start_31_16 = fld_set[3];
  endfunction

  function new(input string name="T_rx_qcccal_start_552");
    super.new(name, 32, build_coverage(UVM_CVR_FIELD_VALS));
    if (has_coverage(UVM_CVR_FIELD_VALS)) begin
      wr_fld_covg = new();
      rd_fld_covg = new();
    end
  endfunction

endclass


/////////////////////////////////////////////////////
//                rx_qcccal_tune
/////////////////////////////////////////////////////
class T_rx_qcccal_tune_553 extends cdns_uvm_reg;

  `uvm_object_utils(T_rx_qcccal_tune_553)
  rand uvm_reg_field rx_qcccal_tune_4_0;
  rand uvm_reg_field rx_qcccal_tune_15_5;
  rand uvm_reg_field rx_qcccal_tune_31_16;
  
  covergroup wr_fld_covg;
    rx_qcccal_tune_4_0: coverpoint rx_qcccal_tune_4_0.value[4:0];
    rx_qcccal_tune_15_5: coverpoint rx_qcccal_tune_15_5.value[10:0];
    rx_qcccal_tune_31_16: coverpoint rx_qcccal_tune_31_16.value[15:0];
  endgroup
  covergroup rd_fld_covg;
    rx_qcccal_tune_4_0: coverpoint rx_qcccal_tune_4_0.value[4:0];
    rx_qcccal_tune_15_5: coverpoint rx_qcccal_tune_15_5.value[10:0];
    rx_qcccal_tune_31_16: coverpoint rx_qcccal_tune_31_16.value[15:0];
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
    
    rx_qcccal_tune_4_0 = fld_set[0];
    rx_qcccal_tune_15_5 = fld_set[1];
    rx_qcccal_tune_31_16 = fld_set[2];
  endfunction

  function new(input string name="T_rx_qcccal_tune_553");
    super.new(name, 32, build_coverage(UVM_CVR_FIELD_VALS));
    if (has_coverage(UVM_CVR_FIELD_VALS)) begin
      wr_fld_covg = new();
      rd_fld_covg = new();
    end
  endfunction

endclass


/////////////////////////////////////////////////////
//                rx_sdcal0_ctrl
/////////////////////////////////////////////////////
class T_rx_sdcal0_ctrl_503 extends cdns_uvm_reg;

  `uvm_object_utils(T_rx_sdcal0_ctrl_503)
  rand uvm_reg_field rx_sdcal0_ctrl_4_0;
  rand uvm_reg_field rx_sdcal0_ctrl_11_5;
  rand uvm_reg_field rx_sdcal0_ctrl_12;
  rand uvm_reg_field rx_sdcal0_ctrl_13;
  rand uvm_reg_field rx_sdcal0_ctrl_14;
  rand uvm_reg_field rx_sdcal0_ctrl_15;
  rand uvm_reg_field rx_sdcal0_ctrl_31_16;
  
  covergroup wr_fld_covg;
    rx_sdcal0_ctrl_4_0: coverpoint rx_sdcal0_ctrl_4_0.value[4:0];
    rx_sdcal0_ctrl_11_5: coverpoint rx_sdcal0_ctrl_11_5.value[6:0];
    rx_sdcal0_ctrl_12: coverpoint rx_sdcal0_ctrl_12.value[0:0];
    rx_sdcal0_ctrl_13: coverpoint rx_sdcal0_ctrl_13.value[0:0];
    rx_sdcal0_ctrl_14: coverpoint rx_sdcal0_ctrl_14.value[0:0];
    rx_sdcal0_ctrl_15: coverpoint rx_sdcal0_ctrl_15.value[0:0];
    rx_sdcal0_ctrl_31_16: coverpoint rx_sdcal0_ctrl_31_16.value[15:0];
  endgroup
  covergroup rd_fld_covg;
    rx_sdcal0_ctrl_4_0: coverpoint rx_sdcal0_ctrl_4_0.value[4:0];
    rx_sdcal0_ctrl_11_5: coverpoint rx_sdcal0_ctrl_11_5.value[6:0];
    rx_sdcal0_ctrl_12: coverpoint rx_sdcal0_ctrl_12.value[0:0];
    rx_sdcal0_ctrl_13: coverpoint rx_sdcal0_ctrl_13.value[0:0];
    rx_sdcal0_ctrl_14: coverpoint rx_sdcal0_ctrl_14.value[0:0];
    rx_sdcal0_ctrl_15: coverpoint rx_sdcal0_ctrl_15.value[0:0];
    rx_sdcal0_ctrl_31_16: coverpoint rx_sdcal0_ctrl_31_16.value[15:0];
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
    
    rx_sdcal0_ctrl_4_0 = fld_set[0];
    rx_sdcal0_ctrl_11_5 = fld_set[1];
    rx_sdcal0_ctrl_12 = fld_set[2];
    rx_sdcal0_ctrl_13 = fld_set[3];
    rx_sdcal0_ctrl_14 = fld_set[4];
    rx_sdcal0_ctrl_15 = fld_set[5];
    rx_sdcal0_ctrl_31_16 = fld_set[6];
  endfunction

  function new(input string name="T_rx_sdcal0_ctrl_503");
    super.new(name, 32, build_coverage(UVM_CVR_FIELD_VALS));
    if (has_coverage(UVM_CVR_FIELD_VALS)) begin
      wr_fld_covg = new();
      rd_fld_covg = new();
    end
  endfunction

endclass


/////////////////////////////////////////////////////
//                rx_sdcal0_init_tmr
/////////////////////////////////////////////////////
class T_rx_sdcal0_init_tmr_507 extends cdns_uvm_reg;

  `uvm_object_utils(T_rx_sdcal0_init_tmr_507)
  rand uvm_reg_field rx_sdcal0_init_tmr_8_0;
  rand uvm_reg_field rx_sdcal0_init_tmr_15_9;
  rand uvm_reg_field rx_sdcal0_init_tmr_31_16;
  
  covergroup wr_fld_covg;
    rx_sdcal0_init_tmr_8_0: coverpoint rx_sdcal0_init_tmr_8_0.value[8:0];
    rx_sdcal0_init_tmr_15_9: coverpoint rx_sdcal0_init_tmr_15_9.value[6:0];
    rx_sdcal0_init_tmr_31_16: coverpoint rx_sdcal0_init_tmr_31_16.value[15:0];
  endgroup
  covergroup rd_fld_covg;
    rx_sdcal0_init_tmr_8_0: coverpoint rx_sdcal0_init_tmr_8_0.value[8:0];
    rx_sdcal0_init_tmr_15_9: coverpoint rx_sdcal0_init_tmr_15_9.value[6:0];
    rx_sdcal0_init_tmr_31_16: coverpoint rx_sdcal0_init_tmr_31_16.value[15:0];
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
    
    rx_sdcal0_init_tmr_8_0 = fld_set[0];
    rx_sdcal0_init_tmr_15_9 = fld_set[1];
    rx_sdcal0_init_tmr_31_16 = fld_set[2];
  endfunction

  function new(input string name="T_rx_sdcal0_init_tmr_507");
    super.new(name, 32, build_coverage(UVM_CVR_FIELD_VALS));
    if (has_coverage(UVM_CVR_FIELD_VALS)) begin
      wr_fld_covg = new();
      rd_fld_covg = new();
    end
  endfunction

endclass


/////////////////////////////////////////////////////
//                rx_sdcal0_iter_tmr
/////////////////////////////////////////////////////
class T_rx_sdcal0_iter_tmr_508 extends cdns_uvm_reg;

  `uvm_object_utils(T_rx_sdcal0_iter_tmr_508)
  rand uvm_reg_field rx_sdcal0_iter_tmr_8_0;
  rand uvm_reg_field rx_sdcal0_iter_tmr_15_9;
  rand uvm_reg_field rx_sdcal0_iter_tmr_31_16;
  
  covergroup wr_fld_covg;
    rx_sdcal0_iter_tmr_8_0: coverpoint rx_sdcal0_iter_tmr_8_0.value[8:0];
    rx_sdcal0_iter_tmr_15_9: coverpoint rx_sdcal0_iter_tmr_15_9.value[6:0];
    rx_sdcal0_iter_tmr_31_16: coverpoint rx_sdcal0_iter_tmr_31_16.value[15:0];
  endgroup
  covergroup rd_fld_covg;
    rx_sdcal0_iter_tmr_8_0: coverpoint rx_sdcal0_iter_tmr_8_0.value[8:0];
    rx_sdcal0_iter_tmr_15_9: coverpoint rx_sdcal0_iter_tmr_15_9.value[6:0];
    rx_sdcal0_iter_tmr_31_16: coverpoint rx_sdcal0_iter_tmr_31_16.value[15:0];
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
    
    rx_sdcal0_iter_tmr_8_0 = fld_set[0];
    rx_sdcal0_iter_tmr_15_9 = fld_set[1];
    rx_sdcal0_iter_tmr_31_16 = fld_set[2];
  endfunction

  function new(input string name="T_rx_sdcal0_iter_tmr_508");
    super.new(name, 32, build_coverage(UVM_CVR_FIELD_VALS));
    if (has_coverage(UVM_CVR_FIELD_VALS)) begin
      wr_fld_covg = new();
      rd_fld_covg = new();
    end
  endfunction

endclass


/////////////////////////////////////////////////////
//                rx_sdcal0_ovrd
/////////////////////////////////////////////////////
class T_rx_sdcal0_ovrd_504 extends cdns_uvm_reg;

  `uvm_object_utils(T_rx_sdcal0_ovrd_504)
  rand uvm_reg_field rx_sdcal0_ovrd_4_0;
  rand uvm_reg_field rx_sdcal0_ovrd_13_5;
  rand uvm_reg_field rx_sdcal0_ovrd_14;
  rand uvm_reg_field rx_sdcal0_ovrd_15;
  rand uvm_reg_field rx_sdcal0_ovrd_31_16;
  
  covergroup wr_fld_covg;
    rx_sdcal0_ovrd_4_0: coverpoint rx_sdcal0_ovrd_4_0.value[4:0];
    rx_sdcal0_ovrd_13_5: coverpoint rx_sdcal0_ovrd_13_5.value[8:0];
    rx_sdcal0_ovrd_14: coverpoint rx_sdcal0_ovrd_14.value[0:0];
    rx_sdcal0_ovrd_15: coverpoint rx_sdcal0_ovrd_15.value[0:0];
    rx_sdcal0_ovrd_31_16: coverpoint rx_sdcal0_ovrd_31_16.value[15:0];
  endgroup
  covergroup rd_fld_covg;
    rx_sdcal0_ovrd_4_0: coverpoint rx_sdcal0_ovrd_4_0.value[4:0];
    rx_sdcal0_ovrd_13_5: coverpoint rx_sdcal0_ovrd_13_5.value[8:0];
    rx_sdcal0_ovrd_14: coverpoint rx_sdcal0_ovrd_14.value[0:0];
    rx_sdcal0_ovrd_15: coverpoint rx_sdcal0_ovrd_15.value[0:0];
    rx_sdcal0_ovrd_31_16: coverpoint rx_sdcal0_ovrd_31_16.value[15:0];
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
    
    rx_sdcal0_ovrd_4_0 = fld_set[0];
    rx_sdcal0_ovrd_13_5 = fld_set[1];
    rx_sdcal0_ovrd_14 = fld_set[2];
    rx_sdcal0_ovrd_15 = fld_set[3];
    rx_sdcal0_ovrd_31_16 = fld_set[4];
  endfunction

  function new(input string name="T_rx_sdcal0_ovrd_504");
    super.new(name, 32, build_coverage(UVM_CVR_FIELD_VALS));
    if (has_coverage(UVM_CVR_FIELD_VALS)) begin
      wr_fld_covg = new();
      rd_fld_covg = new();
    end
  endfunction

endclass


/////////////////////////////////////////////////////
//                rx_sdcal0_start
/////////////////////////////////////////////////////
class T_rx_sdcal0_start_505 extends cdns_uvm_reg;

  `uvm_object_utils(T_rx_sdcal0_start_505)
  rand uvm_reg_field rx_sdcal0_start_4_0;
  rand uvm_reg_field rx_sdcal0_start_14_5;
  rand uvm_reg_field rx_sdcal0_start_15;
  rand uvm_reg_field rx_sdcal0_start_31_16;
  
  covergroup wr_fld_covg;
    rx_sdcal0_start_4_0: coverpoint rx_sdcal0_start_4_0.value[4:0];
    rx_sdcal0_start_14_5: coverpoint rx_sdcal0_start_14_5.value[9:0];
    rx_sdcal0_start_15: coverpoint rx_sdcal0_start_15.value[0:0];
    rx_sdcal0_start_31_16: coverpoint rx_sdcal0_start_31_16.value[15:0];
  endgroup
  covergroup rd_fld_covg;
    rx_sdcal0_start_4_0: coverpoint rx_sdcal0_start_4_0.value[4:0];
    rx_sdcal0_start_14_5: coverpoint rx_sdcal0_start_14_5.value[9:0];
    rx_sdcal0_start_15: coverpoint rx_sdcal0_start_15.value[0:0];
    rx_sdcal0_start_31_16: coverpoint rx_sdcal0_start_31_16.value[15:0];
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
    
    rx_sdcal0_start_4_0 = fld_set[0];
    rx_sdcal0_start_14_5 = fld_set[1];
    rx_sdcal0_start_15 = fld_set[2];
    rx_sdcal0_start_31_16 = fld_set[3];
  endfunction

  function new(input string name="T_rx_sdcal0_start_505");
    super.new(name, 32, build_coverage(UVM_CVR_FIELD_VALS));
    if (has_coverage(UVM_CVR_FIELD_VALS)) begin
      wr_fld_covg = new();
      rd_fld_covg = new();
    end
  endfunction

endclass


/////////////////////////////////////////////////////
//                rx_sdcal0_tune
/////////////////////////////////////////////////////
class T_rx_sdcal0_tune_506 extends cdns_uvm_reg;

  `uvm_object_utils(T_rx_sdcal0_tune_506)
  rand uvm_reg_field rx_sdcal0_tune_4_0;
  rand uvm_reg_field rx_sdcal0_tune_15_5;
  rand uvm_reg_field rx_sdcal0_tune_31_16;
  
  covergroup wr_fld_covg;
    rx_sdcal0_tune_4_0: coverpoint rx_sdcal0_tune_4_0.value[4:0];
    rx_sdcal0_tune_15_5: coverpoint rx_sdcal0_tune_15_5.value[10:0];
    rx_sdcal0_tune_31_16: coverpoint rx_sdcal0_tune_31_16.value[15:0];
  endgroup
  covergroup rd_fld_covg;
    rx_sdcal0_tune_4_0: coverpoint rx_sdcal0_tune_4_0.value[4:0];
    rx_sdcal0_tune_15_5: coverpoint rx_sdcal0_tune_15_5.value[10:0];
    rx_sdcal0_tune_31_16: coverpoint rx_sdcal0_tune_31_16.value[15:0];
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
    
    rx_sdcal0_tune_4_0 = fld_set[0];
    rx_sdcal0_tune_15_5 = fld_set[1];
    rx_sdcal0_tune_31_16 = fld_set[2];
  endfunction

  function new(input string name="T_rx_sdcal0_tune_506");
    super.new(name, 32, build_coverage(UVM_CVR_FIELD_VALS));
    if (has_coverage(UVM_CVR_FIELD_VALS)) begin
      wr_fld_covg = new();
      rd_fld_covg = new();
    end
  endfunction

endclass


/////////////////////////////////////////////////////
//                rx_sdcal1_ctrl
/////////////////////////////////////////////////////
class T_rx_sdcal1_ctrl_509 extends cdns_uvm_reg;

  `uvm_object_utils(T_rx_sdcal1_ctrl_509)
  rand uvm_reg_field rx_sdcal1_ctrl_4_0;
  rand uvm_reg_field rx_sdcal1_ctrl_11_5;
  rand uvm_reg_field rx_sdcal1_ctrl_12;
  rand uvm_reg_field rx_sdcal1_ctrl_13;
  rand uvm_reg_field rx_sdcal1_ctrl_14;
  rand uvm_reg_field rx_sdcal1_ctrl_15;
  rand uvm_reg_field rx_sdcal1_ctrl_31_16;
  
  covergroup wr_fld_covg;
    rx_sdcal1_ctrl_4_0: coverpoint rx_sdcal1_ctrl_4_0.value[4:0];
    rx_sdcal1_ctrl_11_5: coverpoint rx_sdcal1_ctrl_11_5.value[6:0];
    rx_sdcal1_ctrl_12: coverpoint rx_sdcal1_ctrl_12.value[0:0];
    rx_sdcal1_ctrl_13: coverpoint rx_sdcal1_ctrl_13.value[0:0];
    rx_sdcal1_ctrl_14: coverpoint rx_sdcal1_ctrl_14.value[0:0];
    rx_sdcal1_ctrl_15: coverpoint rx_sdcal1_ctrl_15.value[0:0];
    rx_sdcal1_ctrl_31_16: coverpoint rx_sdcal1_ctrl_31_16.value[15:0];
  endgroup
  covergroup rd_fld_covg;
    rx_sdcal1_ctrl_4_0: coverpoint rx_sdcal1_ctrl_4_0.value[4:0];
    rx_sdcal1_ctrl_11_5: coverpoint rx_sdcal1_ctrl_11_5.value[6:0];
    rx_sdcal1_ctrl_12: coverpoint rx_sdcal1_ctrl_12.value[0:0];
    rx_sdcal1_ctrl_13: coverpoint rx_sdcal1_ctrl_13.value[0:0];
    rx_sdcal1_ctrl_14: coverpoint rx_sdcal1_ctrl_14.value[0:0];
    rx_sdcal1_ctrl_15: coverpoint rx_sdcal1_ctrl_15.value[0:0];
    rx_sdcal1_ctrl_31_16: coverpoint rx_sdcal1_ctrl_31_16.value[15:0];
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
    
    rx_sdcal1_ctrl_4_0 = fld_set[0];
    rx_sdcal1_ctrl_11_5 = fld_set[1];
    rx_sdcal1_ctrl_12 = fld_set[2];
    rx_sdcal1_ctrl_13 = fld_set[3];
    rx_sdcal1_ctrl_14 = fld_set[4];
    rx_sdcal1_ctrl_15 = fld_set[5];
    rx_sdcal1_ctrl_31_16 = fld_set[6];
  endfunction

  function new(input string name="T_rx_sdcal1_ctrl_509");
    super.new(name, 32, build_coverage(UVM_CVR_FIELD_VALS));
    if (has_coverage(UVM_CVR_FIELD_VALS)) begin
      wr_fld_covg = new();
      rd_fld_covg = new();
    end
  endfunction

endclass


/////////////////////////////////////////////////////
//                rx_sdcal1_init_tmr
/////////////////////////////////////////////////////
class T_rx_sdcal1_init_tmr_513 extends cdns_uvm_reg;

  `uvm_object_utils(T_rx_sdcal1_init_tmr_513)
  rand uvm_reg_field rx_sdcal1_init_tmr_8_0;
  rand uvm_reg_field rx_sdcal1_init_tmr_15_9;
  rand uvm_reg_field rx_sdcal1_init_tmr_31_16;
  
  covergroup wr_fld_covg;
    rx_sdcal1_init_tmr_8_0: coverpoint rx_sdcal1_init_tmr_8_0.value[8:0];
    rx_sdcal1_init_tmr_15_9: coverpoint rx_sdcal1_init_tmr_15_9.value[6:0];
    rx_sdcal1_init_tmr_31_16: coverpoint rx_sdcal1_init_tmr_31_16.value[15:0];
  endgroup
  covergroup rd_fld_covg;
    rx_sdcal1_init_tmr_8_0: coverpoint rx_sdcal1_init_tmr_8_0.value[8:0];
    rx_sdcal1_init_tmr_15_9: coverpoint rx_sdcal1_init_tmr_15_9.value[6:0];
    rx_sdcal1_init_tmr_31_16: coverpoint rx_sdcal1_init_tmr_31_16.value[15:0];
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
    
    rx_sdcal1_init_tmr_8_0 = fld_set[0];
    rx_sdcal1_init_tmr_15_9 = fld_set[1];
    rx_sdcal1_init_tmr_31_16 = fld_set[2];
  endfunction

  function new(input string name="T_rx_sdcal1_init_tmr_513");
    super.new(name, 32, build_coverage(UVM_CVR_FIELD_VALS));
    if (has_coverage(UVM_CVR_FIELD_VALS)) begin
      wr_fld_covg = new();
      rd_fld_covg = new();
    end
  endfunction

endclass


/////////////////////////////////////////////////////
//                rx_sdcal1_iter_tmr
/////////////////////////////////////////////////////
class T_rx_sdcal1_iter_tmr_514 extends cdns_uvm_reg;

  `uvm_object_utils(T_rx_sdcal1_iter_tmr_514)
  rand uvm_reg_field rx_sdcal1_iter_tmr_8_0;
  rand uvm_reg_field rx_sdcal1_iter_tmr_15_9;
  rand uvm_reg_field rx_sdcal1_iter_tmr_31_16;
  
  covergroup wr_fld_covg;
    rx_sdcal1_iter_tmr_8_0: coverpoint rx_sdcal1_iter_tmr_8_0.value[8:0];
    rx_sdcal1_iter_tmr_15_9: coverpoint rx_sdcal1_iter_tmr_15_9.value[6:0];
    rx_sdcal1_iter_tmr_31_16: coverpoint rx_sdcal1_iter_tmr_31_16.value[15:0];
  endgroup
  covergroup rd_fld_covg;
    rx_sdcal1_iter_tmr_8_0: coverpoint rx_sdcal1_iter_tmr_8_0.value[8:0];
    rx_sdcal1_iter_tmr_15_9: coverpoint rx_sdcal1_iter_tmr_15_9.value[6:0];
    rx_sdcal1_iter_tmr_31_16: coverpoint rx_sdcal1_iter_tmr_31_16.value[15:0];
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
    
    rx_sdcal1_iter_tmr_8_0 = fld_set[0];
    rx_sdcal1_iter_tmr_15_9 = fld_set[1];
    rx_sdcal1_iter_tmr_31_16 = fld_set[2];
  endfunction

  function new(input string name="T_rx_sdcal1_iter_tmr_514");
    super.new(name, 32, build_coverage(UVM_CVR_FIELD_VALS));
    if (has_coverage(UVM_CVR_FIELD_VALS)) begin
      wr_fld_covg = new();
      rd_fld_covg = new();
    end
  endfunction

endclass


/////////////////////////////////////////////////////
//                rx_sdcal1_ovrd
/////////////////////////////////////////////////////
class T_rx_sdcal1_ovrd_510 extends cdns_uvm_reg;

  `uvm_object_utils(T_rx_sdcal1_ovrd_510)
  rand uvm_reg_field rx_sdcal1_ovrd_4_0;
  rand uvm_reg_field rx_sdcal1_ovrd_13_5;
  rand uvm_reg_field rx_sdcal1_ovrd_14;
  rand uvm_reg_field rx_sdcal1_ovrd_15;
  rand uvm_reg_field rx_sdcal1_ovrd_31_16;
  
  covergroup wr_fld_covg;
    rx_sdcal1_ovrd_4_0: coverpoint rx_sdcal1_ovrd_4_0.value[4:0];
    rx_sdcal1_ovrd_13_5: coverpoint rx_sdcal1_ovrd_13_5.value[8:0];
    rx_sdcal1_ovrd_14: coverpoint rx_sdcal1_ovrd_14.value[0:0];
    rx_sdcal1_ovrd_15: coverpoint rx_sdcal1_ovrd_15.value[0:0];
    rx_sdcal1_ovrd_31_16: coverpoint rx_sdcal1_ovrd_31_16.value[15:0];
  endgroup
  covergroup rd_fld_covg;
    rx_sdcal1_ovrd_4_0: coverpoint rx_sdcal1_ovrd_4_0.value[4:0];
    rx_sdcal1_ovrd_13_5: coverpoint rx_sdcal1_ovrd_13_5.value[8:0];
    rx_sdcal1_ovrd_14: coverpoint rx_sdcal1_ovrd_14.value[0:0];
    rx_sdcal1_ovrd_15: coverpoint rx_sdcal1_ovrd_15.value[0:0];
    rx_sdcal1_ovrd_31_16: coverpoint rx_sdcal1_ovrd_31_16.value[15:0];
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
    
    rx_sdcal1_ovrd_4_0 = fld_set[0];
    rx_sdcal1_ovrd_13_5 = fld_set[1];
    rx_sdcal1_ovrd_14 = fld_set[2];
    rx_sdcal1_ovrd_15 = fld_set[3];
    rx_sdcal1_ovrd_31_16 = fld_set[4];
  endfunction

  function new(input string name="T_rx_sdcal1_ovrd_510");
    super.new(name, 32, build_coverage(UVM_CVR_FIELD_VALS));
    if (has_coverage(UVM_CVR_FIELD_VALS)) begin
      wr_fld_covg = new();
      rd_fld_covg = new();
    end
  endfunction

endclass


/////////////////////////////////////////////////////
//                rx_sdcal1_start
/////////////////////////////////////////////////////
class T_rx_sdcal1_start_511 extends cdns_uvm_reg;

  `uvm_object_utils(T_rx_sdcal1_start_511)
  rand uvm_reg_field rx_sdcal1_start_4_0;
  rand uvm_reg_field rx_sdcal1_start_14_5;
  rand uvm_reg_field rx_sdcal1_start_15;
  rand uvm_reg_field rx_sdcal1_start_31_16;
  
  covergroup wr_fld_covg;
    rx_sdcal1_start_4_0: coverpoint rx_sdcal1_start_4_0.value[4:0];
    rx_sdcal1_start_14_5: coverpoint rx_sdcal1_start_14_5.value[9:0];
    rx_sdcal1_start_15: coverpoint rx_sdcal1_start_15.value[0:0];
    rx_sdcal1_start_31_16: coverpoint rx_sdcal1_start_31_16.value[15:0];
  endgroup
  covergroup rd_fld_covg;
    rx_sdcal1_start_4_0: coverpoint rx_sdcal1_start_4_0.value[4:0];
    rx_sdcal1_start_14_5: coverpoint rx_sdcal1_start_14_5.value[9:0];
    rx_sdcal1_start_15: coverpoint rx_sdcal1_start_15.value[0:0];
    rx_sdcal1_start_31_16: coverpoint rx_sdcal1_start_31_16.value[15:0];
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
    
    rx_sdcal1_start_4_0 = fld_set[0];
    rx_sdcal1_start_14_5 = fld_set[1];
    rx_sdcal1_start_15 = fld_set[2];
    rx_sdcal1_start_31_16 = fld_set[3];
  endfunction

  function new(input string name="T_rx_sdcal1_start_511");
    super.new(name, 32, build_coverage(UVM_CVR_FIELD_VALS));
    if (has_coverage(UVM_CVR_FIELD_VALS)) begin
      wr_fld_covg = new();
      rd_fld_covg = new();
    end
  endfunction

endclass


/////////////////////////////////////////////////////
//                rx_sdcal1_tune
/////////////////////////////////////////////////////
class T_rx_sdcal1_tune_512 extends cdns_uvm_reg;

  `uvm_object_utils(T_rx_sdcal1_tune_512)
  rand uvm_reg_field rx_sdcal1_tune_4_0;
  rand uvm_reg_field rx_sdcal1_tune_15_5;
  rand uvm_reg_field rx_sdcal1_tune_31_16;
  
  covergroup wr_fld_covg;
    rx_sdcal1_tune_4_0: coverpoint rx_sdcal1_tune_4_0.value[4:0];
    rx_sdcal1_tune_15_5: coverpoint rx_sdcal1_tune_15_5.value[10:0];
    rx_sdcal1_tune_31_16: coverpoint rx_sdcal1_tune_31_16.value[15:0];
  endgroup
  covergroup rd_fld_covg;
    rx_sdcal1_tune_4_0: coverpoint rx_sdcal1_tune_4_0.value[4:0];
    rx_sdcal1_tune_15_5: coverpoint rx_sdcal1_tune_15_5.value[10:0];
    rx_sdcal1_tune_31_16: coverpoint rx_sdcal1_tune_31_16.value[15:0];
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
    
    rx_sdcal1_tune_4_0 = fld_set[0];
    rx_sdcal1_tune_15_5 = fld_set[1];
    rx_sdcal1_tune_31_16 = fld_set[2];
  endfunction

  function new(input string name="T_rx_sdcal1_tune_512");
    super.new(name, 32, build_coverage(UVM_CVR_FIELD_VALS));
    if (has_coverage(UVM_CVR_FIELD_VALS)) begin
      wr_fld_covg = new();
      rd_fld_covg = new();
    end
  endfunction

endclass


/////////////////////////////////////////////////////
//                rx_slc_ctrl
/////////////////////////////////////////////////////
class T_rx_slc_ctrl_520 extends cdns_uvm_reg;

  `uvm_object_utils(T_rx_slc_ctrl_520)
  rand uvm_reg_field rx_slc_ctrl_1_0;
  rand uvm_reg_field rx_slc_ctrl_13_2;
  rand uvm_reg_field rx_slc_ctrl_14;
  rand uvm_reg_field rx_slc_ctrl_15;
  rand uvm_reg_field rx_slc_ctrl_31_16;
  
  covergroup wr_fld_covg;
    rx_slc_ctrl_1_0: coverpoint rx_slc_ctrl_1_0.value[1:0];
    rx_slc_ctrl_13_2: coverpoint rx_slc_ctrl_13_2.value[11:0];
    rx_slc_ctrl_14: coverpoint rx_slc_ctrl_14.value[0:0];
    rx_slc_ctrl_15: coverpoint rx_slc_ctrl_15.value[0:0];
    rx_slc_ctrl_31_16: coverpoint rx_slc_ctrl_31_16.value[15:0];
  endgroup
  covergroup rd_fld_covg;
    rx_slc_ctrl_1_0: coverpoint rx_slc_ctrl_1_0.value[1:0];
    rx_slc_ctrl_13_2: coverpoint rx_slc_ctrl_13_2.value[11:0];
    rx_slc_ctrl_14: coverpoint rx_slc_ctrl_14.value[0:0];
    rx_slc_ctrl_15: coverpoint rx_slc_ctrl_15.value[0:0];
    rx_slc_ctrl_31_16: coverpoint rx_slc_ctrl_31_16.value[15:0];
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
    
    rx_slc_ctrl_1_0 = fld_set[0];
    rx_slc_ctrl_13_2 = fld_set[1];
    rx_slc_ctrl_14 = fld_set[2];
    rx_slc_ctrl_15 = fld_set[3];
    rx_slc_ctrl_31_16 = fld_set[4];
  endfunction

  function new(input string name="T_rx_slc_ctrl_520");
    super.new(name, 32, build_coverage(UVM_CVR_FIELD_VALS));
    if (has_coverage(UVM_CVR_FIELD_VALS)) begin
      wr_fld_covg = new();
      rd_fld_covg = new();
    end
  endfunction

endclass


/////////////////////////////////////////////////////
//                rx_slc_diag_ctrl
/////////////////////////////////////////////////////
class T_rx_slc_diag_ctrl_534 extends cdns_uvm_reg;

  `uvm_object_utils(T_rx_slc_diag_ctrl_534)
  rand uvm_reg_field rx_slc_diag_ctrl_3_0;
  rand uvm_reg_field rx_slc_diag_ctrl_4;
  rand uvm_reg_field rx_slc_diag_ctrl_5;
  rand uvm_reg_field rx_slc_diag_ctrl_6;
  rand uvm_reg_field rx_slc_diag_ctrl_14_7;
  rand uvm_reg_field rx_slc_diag_ctrl_15;
  rand uvm_reg_field rx_slc_diag_ctrl_31_16;
  
  covergroup wr_fld_covg;
    rx_slc_diag_ctrl_3_0: coverpoint rx_slc_diag_ctrl_3_0.value[3:0];
    rx_slc_diag_ctrl_4: coverpoint rx_slc_diag_ctrl_4.value[0:0];
    rx_slc_diag_ctrl_5: coverpoint rx_slc_diag_ctrl_5.value[0:0];
    rx_slc_diag_ctrl_6: coverpoint rx_slc_diag_ctrl_6.value[0:0];
    rx_slc_diag_ctrl_14_7: coverpoint rx_slc_diag_ctrl_14_7.value[7:0];
    rx_slc_diag_ctrl_15: coverpoint rx_slc_diag_ctrl_15.value[0:0];
    rx_slc_diag_ctrl_31_16: coverpoint rx_slc_diag_ctrl_31_16.value[15:0];
  endgroup
  covergroup rd_fld_covg;
    rx_slc_diag_ctrl_3_0: coverpoint rx_slc_diag_ctrl_3_0.value[3:0];
    rx_slc_diag_ctrl_4: coverpoint rx_slc_diag_ctrl_4.value[0:0];
    rx_slc_diag_ctrl_5: coverpoint rx_slc_diag_ctrl_5.value[0:0];
    rx_slc_diag_ctrl_6: coverpoint rx_slc_diag_ctrl_6.value[0:0];
    rx_slc_diag_ctrl_14_7: coverpoint rx_slc_diag_ctrl_14_7.value[7:0];
    rx_slc_diag_ctrl_15: coverpoint rx_slc_diag_ctrl_15.value[0:0];
    rx_slc_diag_ctrl_31_16: coverpoint rx_slc_diag_ctrl_31_16.value[15:0];
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
    
    rx_slc_diag_ctrl_3_0 = fld_set[0];
    rx_slc_diag_ctrl_4 = fld_set[1];
    rx_slc_diag_ctrl_5 = fld_set[2];
    rx_slc_diag_ctrl_6 = fld_set[3];
    rx_slc_diag_ctrl_14_7 = fld_set[4];
    rx_slc_diag_ctrl_15 = fld_set[5];
    rx_slc_diag_ctrl_31_16 = fld_set[6];
  endfunction

  function new(input string name="T_rx_slc_diag_ctrl_534");
    super.new(name, 32, build_coverage(UVM_CVR_FIELD_VALS));
    if (has_coverage(UVM_CVR_FIELD_VALS)) begin
      wr_fld_covg = new();
      rd_fld_covg = new();
    end
  endfunction

endclass


/////////////////////////////////////////////////////
//                rx_slc_dis
/////////////////////////////////////////////////////
class T_rx_slc_dis_535 extends cdns_uvm_reg;

  `uvm_object_utils(T_rx_slc_dis_535)
  rand uvm_reg_field rx_slc_dis_0;
  rand uvm_reg_field rx_slc_dis_1;
  rand uvm_reg_field rx_slc_dis_2;
  rand uvm_reg_field rx_slc_dis_3;
  rand uvm_reg_field rx_slc_dis_4;
  rand uvm_reg_field rx_slc_dis_5;
  rand uvm_reg_field rx_slc_dis_6;
  rand uvm_reg_field rx_slc_dis_7;
  rand uvm_reg_field rx_slc_dis_8;
  rand uvm_reg_field rx_slc_dis_9;
  rand uvm_reg_field rx_slc_dis_10;
  rand uvm_reg_field rx_slc_dis_11;
  rand uvm_reg_field rx_slc_dis_12;
  rand uvm_reg_field rx_slc_dis_13;
  rand uvm_reg_field rx_slc_dis_14;
  rand uvm_reg_field rx_slc_dis_15;
  rand uvm_reg_field rx_slc_dis_31_16;
  
  covergroup wr_fld_covg;
    rx_slc_dis_0: coverpoint rx_slc_dis_0.value[0:0];
    rx_slc_dis_1: coverpoint rx_slc_dis_1.value[0:0];
    rx_slc_dis_2: coverpoint rx_slc_dis_2.value[0:0];
    rx_slc_dis_3: coverpoint rx_slc_dis_3.value[0:0];
    rx_slc_dis_4: coverpoint rx_slc_dis_4.value[0:0];
    rx_slc_dis_5: coverpoint rx_slc_dis_5.value[0:0];
    rx_slc_dis_6: coverpoint rx_slc_dis_6.value[0:0];
    rx_slc_dis_7: coverpoint rx_slc_dis_7.value[0:0];
    rx_slc_dis_8: coverpoint rx_slc_dis_8.value[0:0];
    rx_slc_dis_9: coverpoint rx_slc_dis_9.value[0:0];
    rx_slc_dis_10: coverpoint rx_slc_dis_10.value[0:0];
    rx_slc_dis_11: coverpoint rx_slc_dis_11.value[0:0];
    rx_slc_dis_12: coverpoint rx_slc_dis_12.value[0:0];
    rx_slc_dis_13: coverpoint rx_slc_dis_13.value[0:0];
    rx_slc_dis_14: coverpoint rx_slc_dis_14.value[0:0];
    rx_slc_dis_15: coverpoint rx_slc_dis_15.value[0:0];
    rx_slc_dis_31_16: coverpoint rx_slc_dis_31_16.value[15:0];
  endgroup
  covergroup rd_fld_covg;
    rx_slc_dis_0: coverpoint rx_slc_dis_0.value[0:0];
    rx_slc_dis_1: coverpoint rx_slc_dis_1.value[0:0];
    rx_slc_dis_2: coverpoint rx_slc_dis_2.value[0:0];
    rx_slc_dis_3: coverpoint rx_slc_dis_3.value[0:0];
    rx_slc_dis_4: coverpoint rx_slc_dis_4.value[0:0];
    rx_slc_dis_5: coverpoint rx_slc_dis_5.value[0:0];
    rx_slc_dis_6: coverpoint rx_slc_dis_6.value[0:0];
    rx_slc_dis_7: coverpoint rx_slc_dis_7.value[0:0];
    rx_slc_dis_8: coverpoint rx_slc_dis_8.value[0:0];
    rx_slc_dis_9: coverpoint rx_slc_dis_9.value[0:0];
    rx_slc_dis_10: coverpoint rx_slc_dis_10.value[0:0];
    rx_slc_dis_11: coverpoint rx_slc_dis_11.value[0:0];
    rx_slc_dis_12: coverpoint rx_slc_dis_12.value[0:0];
    rx_slc_dis_13: coverpoint rx_slc_dis_13.value[0:0];
    rx_slc_dis_14: coverpoint rx_slc_dis_14.value[0:0];
    rx_slc_dis_15: coverpoint rx_slc_dis_15.value[0:0];
    rx_slc_dis_31_16: coverpoint rx_slc_dis_31_16.value[15:0];
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
    
    rx_slc_dis_0 = fld_set[0];
    rx_slc_dis_1 = fld_set[1];
    rx_slc_dis_2 = fld_set[2];
    rx_slc_dis_3 = fld_set[3];
    rx_slc_dis_4 = fld_set[4];
    rx_slc_dis_5 = fld_set[5];
    rx_slc_dis_6 = fld_set[6];
    rx_slc_dis_7 = fld_set[7];
    rx_slc_dis_8 = fld_set[8];
    rx_slc_dis_9 = fld_set[9];
    rx_slc_dis_10 = fld_set[10];
    rx_slc_dis_11 = fld_set[11];
    rx_slc_dis_12 = fld_set[12];
    rx_slc_dis_13 = fld_set[13];
    rx_slc_dis_14 = fld_set[14];
    rx_slc_dis_15 = fld_set[15];
    rx_slc_dis_31_16 = fld_set[16];
  endfunction

  function new(input string name="T_rx_slc_dis_535");
    super.new(name, 32, build_coverage(UVM_CVR_FIELD_VALS));
    if (has_coverage(UVM_CVR_FIELD_VALS)) begin
      wr_fld_covg = new();
      rd_fld_covg = new();
    end
  endfunction

endclass


/////////////////////////////////////////////////////
//                rx_slc_epm_ovrd
/////////////////////////////////////////////////////
class T_rx_slc_epm_ovrd_531 extends cdns_uvm_reg;

  `uvm_object_utils(T_rx_slc_epm_ovrd_531)
  rand uvm_reg_field rx_slc_epm_ovrd_6_0;
  rand uvm_reg_field rx_slc_epm_ovrd_7;
  rand uvm_reg_field rx_slc_epm_ovrd_14_8;
  rand uvm_reg_field rx_slc_epm_ovrd_15;
  rand uvm_reg_field rx_slc_epm_ovrd_31_16;
  
  covergroup wr_fld_covg;
    rx_slc_epm_ovrd_6_0: coverpoint rx_slc_epm_ovrd_6_0.value[6:0];
    rx_slc_epm_ovrd_7: coverpoint rx_slc_epm_ovrd_7.value[0:0];
    rx_slc_epm_ovrd_14_8: coverpoint rx_slc_epm_ovrd_14_8.value[6:0];
    rx_slc_epm_ovrd_15: coverpoint rx_slc_epm_ovrd_15.value[0:0];
    rx_slc_epm_ovrd_31_16: coverpoint rx_slc_epm_ovrd_31_16.value[15:0];
  endgroup
  covergroup rd_fld_covg;
    rx_slc_epm_ovrd_6_0: coverpoint rx_slc_epm_ovrd_6_0.value[6:0];
    rx_slc_epm_ovrd_7: coverpoint rx_slc_epm_ovrd_7.value[0:0];
    rx_slc_epm_ovrd_14_8: coverpoint rx_slc_epm_ovrd_14_8.value[6:0];
    rx_slc_epm_ovrd_15: coverpoint rx_slc_epm_ovrd_15.value[0:0];
    rx_slc_epm_ovrd_31_16: coverpoint rx_slc_epm_ovrd_31_16.value[15:0];
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
    
    rx_slc_epm_ovrd_6_0 = fld_set[0];
    rx_slc_epm_ovrd_7 = fld_set[1];
    rx_slc_epm_ovrd_14_8 = fld_set[2];
    rx_slc_epm_ovrd_15 = fld_set[3];
    rx_slc_epm_ovrd_31_16 = fld_set[4];
  endfunction

  function new(input string name="T_rx_slc_epm_ovrd_531");
    super.new(name, 32, build_coverage(UVM_CVR_FIELD_VALS));
    if (has_coverage(UVM_CVR_FIELD_VALS)) begin
      wr_fld_covg = new();
      rd_fld_covg = new();
    end
  endfunction

endclass


/////////////////////////////////////////////////////
//                rx_slc_epm_stat
/////////////////////////////////////////////////////
class T_rx_slc_epm_stat_530 extends cdns_uvm_reg;

  `uvm_object_utils(T_rx_slc_epm_stat_530)
  rand uvm_reg_field rx_slc_epm_stat_6_0;
  rand uvm_reg_field rx_slc_epm_stat_7;
  rand uvm_reg_field rx_slc_epm_stat_14_8;
  rand uvm_reg_field rx_slc_epm_stat_15;
  rand uvm_reg_field rx_slc_epm_stat_31_16;
  
  covergroup wr_fld_covg;
    rx_slc_epm_stat_6_0: coverpoint rx_slc_epm_stat_6_0.value[6:0];
    rx_slc_epm_stat_7: coverpoint rx_slc_epm_stat_7.value[0:0];
    rx_slc_epm_stat_14_8: coverpoint rx_slc_epm_stat_14_8.value[6:0];
    rx_slc_epm_stat_15: coverpoint rx_slc_epm_stat_15.value[0:0];
    rx_slc_epm_stat_31_16: coverpoint rx_slc_epm_stat_31_16.value[15:0];
  endgroup
  covergroup rd_fld_covg;
    rx_slc_epm_stat_6_0: coverpoint rx_slc_epm_stat_6_0.value[6:0];
    rx_slc_epm_stat_7: coverpoint rx_slc_epm_stat_7.value[0:0];
    rx_slc_epm_stat_14_8: coverpoint rx_slc_epm_stat_14_8.value[6:0];
    rx_slc_epm_stat_15: coverpoint rx_slc_epm_stat_15.value[0:0];
    rx_slc_epm_stat_31_16: coverpoint rx_slc_epm_stat_31_16.value[15:0];
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
    
    rx_slc_epm_stat_6_0 = fld_set[0];
    rx_slc_epm_stat_7 = fld_set[1];
    rx_slc_epm_stat_14_8 = fld_set[2];
    rx_slc_epm_stat_15 = fld_set[3];
    rx_slc_epm_stat_31_16 = fld_set[4];
  endfunction

  function new(input string name="T_rx_slc_epm_stat_530");
    super.new(name, 32, build_coverage(UVM_CVR_FIELD_VALS));
    if (has_coverage(UVM_CVR_FIELD_VALS)) begin
      wr_fld_covg = new();
      rd_fld_covg = new();
    end
  endfunction

endclass


/////////////////////////////////////////////////////
//                rx_slc_epp_ovrd
/////////////////////////////////////////////////////
class T_rx_slc_epp_ovrd_529 extends cdns_uvm_reg;

  `uvm_object_utils(T_rx_slc_epp_ovrd_529)
  rand uvm_reg_field rx_slc_epp_ovrd_6_0;
  rand uvm_reg_field rx_slc_epp_ovrd_7;
  rand uvm_reg_field rx_slc_epp_ovrd_14_8;
  rand uvm_reg_field rx_slc_epp_ovrd_15;
  rand uvm_reg_field rx_slc_epp_ovrd_31_16;
  
  covergroup wr_fld_covg;
    rx_slc_epp_ovrd_6_0: coverpoint rx_slc_epp_ovrd_6_0.value[6:0];
    rx_slc_epp_ovrd_7: coverpoint rx_slc_epp_ovrd_7.value[0:0];
    rx_slc_epp_ovrd_14_8: coverpoint rx_slc_epp_ovrd_14_8.value[6:0];
    rx_slc_epp_ovrd_15: coverpoint rx_slc_epp_ovrd_15.value[0:0];
    rx_slc_epp_ovrd_31_16: coverpoint rx_slc_epp_ovrd_31_16.value[15:0];
  endgroup
  covergroup rd_fld_covg;
    rx_slc_epp_ovrd_6_0: coverpoint rx_slc_epp_ovrd_6_0.value[6:0];
    rx_slc_epp_ovrd_7: coverpoint rx_slc_epp_ovrd_7.value[0:0];
    rx_slc_epp_ovrd_14_8: coverpoint rx_slc_epp_ovrd_14_8.value[6:0];
    rx_slc_epp_ovrd_15: coverpoint rx_slc_epp_ovrd_15.value[0:0];
    rx_slc_epp_ovrd_31_16: coverpoint rx_slc_epp_ovrd_31_16.value[15:0];
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
    
    rx_slc_epp_ovrd_6_0 = fld_set[0];
    rx_slc_epp_ovrd_7 = fld_set[1];
    rx_slc_epp_ovrd_14_8 = fld_set[2];
    rx_slc_epp_ovrd_15 = fld_set[3];
    rx_slc_epp_ovrd_31_16 = fld_set[4];
  endfunction

  function new(input string name="T_rx_slc_epp_ovrd_529");
    super.new(name, 32, build_coverage(UVM_CVR_FIELD_VALS));
    if (has_coverage(UVM_CVR_FIELD_VALS)) begin
      wr_fld_covg = new();
      rd_fld_covg = new();
    end
  endfunction

endclass


/////////////////////////////////////////////////////
//                rx_slc_epp_stat
/////////////////////////////////////////////////////
class T_rx_slc_epp_stat_528 extends cdns_uvm_reg;

  `uvm_object_utils(T_rx_slc_epp_stat_528)
  rand uvm_reg_field rx_slc_epp_stat_6_0;
  rand uvm_reg_field rx_slc_epp_stat_7;
  rand uvm_reg_field rx_slc_epp_stat_14_8;
  rand uvm_reg_field rx_slc_epp_stat_15;
  rand uvm_reg_field rx_slc_epp_stat_31_16;
  
  covergroup wr_fld_covg;
    rx_slc_epp_stat_6_0: coverpoint rx_slc_epp_stat_6_0.value[6:0];
    rx_slc_epp_stat_7: coverpoint rx_slc_epp_stat_7.value[0:0];
    rx_slc_epp_stat_14_8: coverpoint rx_slc_epp_stat_14_8.value[6:0];
    rx_slc_epp_stat_15: coverpoint rx_slc_epp_stat_15.value[0:0];
    rx_slc_epp_stat_31_16: coverpoint rx_slc_epp_stat_31_16.value[15:0];
  endgroup
  covergroup rd_fld_covg;
    rx_slc_epp_stat_6_0: coverpoint rx_slc_epp_stat_6_0.value[6:0];
    rx_slc_epp_stat_7: coverpoint rx_slc_epp_stat_7.value[0:0];
    rx_slc_epp_stat_14_8: coverpoint rx_slc_epp_stat_14_8.value[6:0];
    rx_slc_epp_stat_15: coverpoint rx_slc_epp_stat_15.value[0:0];
    rx_slc_epp_stat_31_16: coverpoint rx_slc_epp_stat_31_16.value[15:0];
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
    
    rx_slc_epp_stat_6_0 = fld_set[0];
    rx_slc_epp_stat_7 = fld_set[1];
    rx_slc_epp_stat_14_8 = fld_set[2];
    rx_slc_epp_stat_15 = fld_set[3];
    rx_slc_epp_stat_31_16 = fld_set[4];
  endfunction

  function new(input string name="T_rx_slc_epp_stat_528");
    super.new(name, 32, build_coverage(UVM_CVR_FIELD_VALS));
    if (has_coverage(UVM_CVR_FIELD_VALS)) begin
      wr_fld_covg = new();
      rd_fld_covg = new();
    end
  endfunction

endclass


/////////////////////////////////////////////////////
//                rx_slc_init_tmr
/////////////////////////////////////////////////////
class T_rx_slc_init_tmr_532 extends cdns_uvm_reg;

  `uvm_object_utils(T_rx_slc_init_tmr_532)
  rand uvm_reg_field rx_slc_init_tmr_15_0;
  rand uvm_reg_field rx_slc_init_tmr_31_16;
  
  covergroup wr_fld_covg;
    rx_slc_init_tmr_15_0: coverpoint rx_slc_init_tmr_15_0.value[15:0];
    rx_slc_init_tmr_31_16: coverpoint rx_slc_init_tmr_31_16.value[15:0];
  endgroup
  covergroup rd_fld_covg;
    rx_slc_init_tmr_15_0: coverpoint rx_slc_init_tmr_15_0.value[15:0];
    rx_slc_init_tmr_31_16: coverpoint rx_slc_init_tmr_31_16.value[15:0];
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
    
    rx_slc_init_tmr_15_0 = fld_set[0];
    rx_slc_init_tmr_31_16 = fld_set[1];
  endfunction

  function new(input string name="T_rx_slc_init_tmr_532");
    super.new(name, 32, build_coverage(UVM_CVR_FIELD_VALS));
    if (has_coverage(UVM_CVR_FIELD_VALS)) begin
      wr_fld_covg = new();
      rd_fld_covg = new();
    end
  endfunction

endclass


/////////////////////////////////////////////////////
//                rx_slc_ipm_ovrd
/////////////////////////////////////////////////////
class T_rx_slc_ipm_ovrd_523 extends cdns_uvm_reg;

  `uvm_object_utils(T_rx_slc_ipm_ovrd_523)
  rand uvm_reg_field rx_slc_ipm_ovrd_6_0;
  rand uvm_reg_field rx_slc_ipm_ovrd_7;
  rand uvm_reg_field rx_slc_ipm_ovrd_14_8;
  rand uvm_reg_field rx_slc_ipm_ovrd_15;
  rand uvm_reg_field rx_slc_ipm_ovrd_31_16;
  
  covergroup wr_fld_covg;
    rx_slc_ipm_ovrd_6_0: coverpoint rx_slc_ipm_ovrd_6_0.value[6:0];
    rx_slc_ipm_ovrd_7: coverpoint rx_slc_ipm_ovrd_7.value[0:0];
    rx_slc_ipm_ovrd_14_8: coverpoint rx_slc_ipm_ovrd_14_8.value[6:0];
    rx_slc_ipm_ovrd_15: coverpoint rx_slc_ipm_ovrd_15.value[0:0];
    rx_slc_ipm_ovrd_31_16: coverpoint rx_slc_ipm_ovrd_31_16.value[15:0];
  endgroup
  covergroup rd_fld_covg;
    rx_slc_ipm_ovrd_6_0: coverpoint rx_slc_ipm_ovrd_6_0.value[6:0];
    rx_slc_ipm_ovrd_7: coverpoint rx_slc_ipm_ovrd_7.value[0:0];
    rx_slc_ipm_ovrd_14_8: coverpoint rx_slc_ipm_ovrd_14_8.value[6:0];
    rx_slc_ipm_ovrd_15: coverpoint rx_slc_ipm_ovrd_15.value[0:0];
    rx_slc_ipm_ovrd_31_16: coverpoint rx_slc_ipm_ovrd_31_16.value[15:0];
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
    
    rx_slc_ipm_ovrd_6_0 = fld_set[0];
    rx_slc_ipm_ovrd_7 = fld_set[1];
    rx_slc_ipm_ovrd_14_8 = fld_set[2];
    rx_slc_ipm_ovrd_15 = fld_set[3];
    rx_slc_ipm_ovrd_31_16 = fld_set[4];
  endfunction

  function new(input string name="T_rx_slc_ipm_ovrd_523");
    super.new(name, 32, build_coverage(UVM_CVR_FIELD_VALS));
    if (has_coverage(UVM_CVR_FIELD_VALS)) begin
      wr_fld_covg = new();
      rd_fld_covg = new();
    end
  endfunction

endclass


/////////////////////////////////////////////////////
//                rx_slc_ipm_stat
/////////////////////////////////////////////////////
class T_rx_slc_ipm_stat_522 extends cdns_uvm_reg;

  `uvm_object_utils(T_rx_slc_ipm_stat_522)
  rand uvm_reg_field rx_slc_ipm_stat_6_0;
  rand uvm_reg_field rx_slc_ipm_stat_7;
  rand uvm_reg_field rx_slc_ipm_stat_14_8;
  rand uvm_reg_field rx_slc_ipm_stat_31_15;
  
  covergroup wr_fld_covg;
    rx_slc_ipm_stat_6_0: coverpoint rx_slc_ipm_stat_6_0.value[6:0];
    rx_slc_ipm_stat_7: coverpoint rx_slc_ipm_stat_7.value[0:0];
    rx_slc_ipm_stat_14_8: coverpoint rx_slc_ipm_stat_14_8.value[6:0];
    rx_slc_ipm_stat_31_15: coverpoint rx_slc_ipm_stat_31_15.value[16:0];
  endgroup
  covergroup rd_fld_covg;
    rx_slc_ipm_stat_6_0: coverpoint rx_slc_ipm_stat_6_0.value[6:0];
    rx_slc_ipm_stat_7: coverpoint rx_slc_ipm_stat_7.value[0:0];
    rx_slc_ipm_stat_14_8: coverpoint rx_slc_ipm_stat_14_8.value[6:0];
    rx_slc_ipm_stat_31_15: coverpoint rx_slc_ipm_stat_31_15.value[16:0];
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
    
    rx_slc_ipm_stat_6_0 = fld_set[0];
    rx_slc_ipm_stat_7 = fld_set[1];
    rx_slc_ipm_stat_14_8 = fld_set[2];
    rx_slc_ipm_stat_31_15 = fld_set[3];
  endfunction

  function new(input string name="T_rx_slc_ipm_stat_522");
    super.new(name, 32, build_coverage(UVM_CVR_FIELD_VALS));
    if (has_coverage(UVM_CVR_FIELD_VALS)) begin
      wr_fld_covg = new();
      rd_fld_covg = new();
    end
  endfunction

endclass


/////////////////////////////////////////////////////
//                rx_slc_ipp_ovrd
/////////////////////////////////////////////////////
class T_rx_slc_ipp_ovrd_521 extends cdns_uvm_reg;

  `uvm_object_utils(T_rx_slc_ipp_ovrd_521)
  rand uvm_reg_field rx_slc_ipp_ovrd_6_0;
  rand uvm_reg_field rx_slc_ipp_ovrd_7;
  rand uvm_reg_field rx_slc_ipp_ovrd_14_8;
  rand uvm_reg_field rx_slc_ipp_ovrd_15;
  rand uvm_reg_field rx_slc_ipp_ovrd_31_16;
  
  covergroup wr_fld_covg;
    rx_slc_ipp_ovrd_6_0: coverpoint rx_slc_ipp_ovrd_6_0.value[6:0];
    rx_slc_ipp_ovrd_7: coverpoint rx_slc_ipp_ovrd_7.value[0:0];
    rx_slc_ipp_ovrd_14_8: coverpoint rx_slc_ipp_ovrd_14_8.value[6:0];
    rx_slc_ipp_ovrd_15: coverpoint rx_slc_ipp_ovrd_15.value[0:0];
    rx_slc_ipp_ovrd_31_16: coverpoint rx_slc_ipp_ovrd_31_16.value[15:0];
  endgroup
  covergroup rd_fld_covg;
    rx_slc_ipp_ovrd_6_0: coverpoint rx_slc_ipp_ovrd_6_0.value[6:0];
    rx_slc_ipp_ovrd_7: coverpoint rx_slc_ipp_ovrd_7.value[0:0];
    rx_slc_ipp_ovrd_14_8: coverpoint rx_slc_ipp_ovrd_14_8.value[6:0];
    rx_slc_ipp_ovrd_15: coverpoint rx_slc_ipp_ovrd_15.value[0:0];
    rx_slc_ipp_ovrd_31_16: coverpoint rx_slc_ipp_ovrd_31_16.value[15:0];
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
    
    rx_slc_ipp_ovrd_6_0 = fld_set[0];
    rx_slc_ipp_ovrd_7 = fld_set[1];
    rx_slc_ipp_ovrd_14_8 = fld_set[2];
    rx_slc_ipp_ovrd_15 = fld_set[3];
    rx_slc_ipp_ovrd_31_16 = fld_set[4];
  endfunction

  function new(input string name="T_rx_slc_ipp_ovrd_521");
    super.new(name, 32, build_coverage(UVM_CVR_FIELD_VALS));
    if (has_coverage(UVM_CVR_FIELD_VALS)) begin
      wr_fld_covg = new();
      rd_fld_covg = new();
    end
  endfunction

endclass


/////////////////////////////////////////////////////
//                rx_slc_qpm_ovrd
/////////////////////////////////////////////////////
class T_rx_slc_qpm_ovrd_527 extends cdns_uvm_reg;

  `uvm_object_utils(T_rx_slc_qpm_ovrd_527)
  rand uvm_reg_field rx_slc_qpm_ovrd_6_0;
  rand uvm_reg_field rx_slc_qpm_ovrd_7;
  rand uvm_reg_field rx_slc_qpm_ovrd_14_8;
  rand uvm_reg_field rx_slc_qpm_ovrd_15;
  rand uvm_reg_field rx_slc_qpm_ovrd_31_16;
  
  covergroup wr_fld_covg;
    rx_slc_qpm_ovrd_6_0: coverpoint rx_slc_qpm_ovrd_6_0.value[6:0];
    rx_slc_qpm_ovrd_7: coverpoint rx_slc_qpm_ovrd_7.value[0:0];
    rx_slc_qpm_ovrd_14_8: coverpoint rx_slc_qpm_ovrd_14_8.value[6:0];
    rx_slc_qpm_ovrd_15: coverpoint rx_slc_qpm_ovrd_15.value[0:0];
    rx_slc_qpm_ovrd_31_16: coverpoint rx_slc_qpm_ovrd_31_16.value[15:0];
  endgroup
  covergroup rd_fld_covg;
    rx_slc_qpm_ovrd_6_0: coverpoint rx_slc_qpm_ovrd_6_0.value[6:0];
    rx_slc_qpm_ovrd_7: coverpoint rx_slc_qpm_ovrd_7.value[0:0];
    rx_slc_qpm_ovrd_14_8: coverpoint rx_slc_qpm_ovrd_14_8.value[6:0];
    rx_slc_qpm_ovrd_15: coverpoint rx_slc_qpm_ovrd_15.value[0:0];
    rx_slc_qpm_ovrd_31_16: coverpoint rx_slc_qpm_ovrd_31_16.value[15:0];
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
    
    rx_slc_qpm_ovrd_6_0 = fld_set[0];
    rx_slc_qpm_ovrd_7 = fld_set[1];
    rx_slc_qpm_ovrd_14_8 = fld_set[2];
    rx_slc_qpm_ovrd_15 = fld_set[3];
    rx_slc_qpm_ovrd_31_16 = fld_set[4];
  endfunction

  function new(input string name="T_rx_slc_qpm_ovrd_527");
    super.new(name, 32, build_coverage(UVM_CVR_FIELD_VALS));
    if (has_coverage(UVM_CVR_FIELD_VALS)) begin
      wr_fld_covg = new();
      rd_fld_covg = new();
    end
  endfunction

endclass


/////////////////////////////////////////////////////
//                rx_slc_qpm_stat
/////////////////////////////////////////////////////
class T_rx_slc_qpm_stat_526 extends cdns_uvm_reg;

  `uvm_object_utils(T_rx_slc_qpm_stat_526)
  rand uvm_reg_field rx_slc_qpm_stat_6_0;
  rand uvm_reg_field rx_slc_qpm_stat_7;
  rand uvm_reg_field rx_slc_qpm_stat_14_8;
  rand uvm_reg_field rx_slc_qpm_stat_15;
  rand uvm_reg_field rx_slc_qpm_stat_31_16;
  
  covergroup wr_fld_covg;
    rx_slc_qpm_stat_6_0: coverpoint rx_slc_qpm_stat_6_0.value[6:0];
    rx_slc_qpm_stat_7: coverpoint rx_slc_qpm_stat_7.value[0:0];
    rx_slc_qpm_stat_14_8: coverpoint rx_slc_qpm_stat_14_8.value[6:0];
    rx_slc_qpm_stat_15: coverpoint rx_slc_qpm_stat_15.value[0:0];
    rx_slc_qpm_stat_31_16: coverpoint rx_slc_qpm_stat_31_16.value[15:0];
  endgroup
  covergroup rd_fld_covg;
    rx_slc_qpm_stat_6_0: coverpoint rx_slc_qpm_stat_6_0.value[6:0];
    rx_slc_qpm_stat_7: coverpoint rx_slc_qpm_stat_7.value[0:0];
    rx_slc_qpm_stat_14_8: coverpoint rx_slc_qpm_stat_14_8.value[6:0];
    rx_slc_qpm_stat_15: coverpoint rx_slc_qpm_stat_15.value[0:0];
    rx_slc_qpm_stat_31_16: coverpoint rx_slc_qpm_stat_31_16.value[15:0];
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
    
    rx_slc_qpm_stat_6_0 = fld_set[0];
    rx_slc_qpm_stat_7 = fld_set[1];
    rx_slc_qpm_stat_14_8 = fld_set[2];
    rx_slc_qpm_stat_15 = fld_set[3];
    rx_slc_qpm_stat_31_16 = fld_set[4];
  endfunction

  function new(input string name="T_rx_slc_qpm_stat_526");
    super.new(name, 32, build_coverage(UVM_CVR_FIELD_VALS));
    if (has_coverage(UVM_CVR_FIELD_VALS)) begin
      wr_fld_covg = new();
      rd_fld_covg = new();
    end
  endfunction

endclass


/////////////////////////////////////////////////////
//                rx_slc_qpp_ovrd
/////////////////////////////////////////////////////
class T_rx_slc_qpp_ovrd_525 extends cdns_uvm_reg;

  `uvm_object_utils(T_rx_slc_qpp_ovrd_525)
  rand uvm_reg_field rx_slc_qpp_ovrd_6_0;
  rand uvm_reg_field rx_slc_qpp_ovrd_7;
  rand uvm_reg_field rx_slc_qpp_ovrd_14_8;
  rand uvm_reg_field rx_slc_qpp_ovrd_15;
  rand uvm_reg_field rx_slc_qpp_ovrd_31_16;
  
  covergroup wr_fld_covg;
    rx_slc_qpp_ovrd_6_0: coverpoint rx_slc_qpp_ovrd_6_0.value[6:0];
    rx_slc_qpp_ovrd_7: coverpoint rx_slc_qpp_ovrd_7.value[0:0];
    rx_slc_qpp_ovrd_14_8: coverpoint rx_slc_qpp_ovrd_14_8.value[6:0];
    rx_slc_qpp_ovrd_15: coverpoint rx_slc_qpp_ovrd_15.value[0:0];
    rx_slc_qpp_ovrd_31_16: coverpoint rx_slc_qpp_ovrd_31_16.value[15:0];
  endgroup
  covergroup rd_fld_covg;
    rx_slc_qpp_ovrd_6_0: coverpoint rx_slc_qpp_ovrd_6_0.value[6:0];
    rx_slc_qpp_ovrd_7: coverpoint rx_slc_qpp_ovrd_7.value[0:0];
    rx_slc_qpp_ovrd_14_8: coverpoint rx_slc_qpp_ovrd_14_8.value[6:0];
    rx_slc_qpp_ovrd_15: coverpoint rx_slc_qpp_ovrd_15.value[0:0];
    rx_slc_qpp_ovrd_31_16: coverpoint rx_slc_qpp_ovrd_31_16.value[15:0];
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
    
    rx_slc_qpp_ovrd_6_0 = fld_set[0];
    rx_slc_qpp_ovrd_7 = fld_set[1];
    rx_slc_qpp_ovrd_14_8 = fld_set[2];
    rx_slc_qpp_ovrd_15 = fld_set[3];
    rx_slc_qpp_ovrd_31_16 = fld_set[4];
  endfunction

  function new(input string name="T_rx_slc_qpp_ovrd_525");
    super.new(name, 32, build_coverage(UVM_CVR_FIELD_VALS));
    if (has_coverage(UVM_CVR_FIELD_VALS)) begin
      wr_fld_covg = new();
      rd_fld_covg = new();
    end
  endfunction

endclass


/////////////////////////////////////////////////////
//                rx_slc_qpp_stat
/////////////////////////////////////////////////////
class T_rx_slc_qpp_stat_524 extends cdns_uvm_reg;

  `uvm_object_utils(T_rx_slc_qpp_stat_524)
  rand uvm_reg_field rx_slc_qpp_stat_6_0;
  rand uvm_reg_field rx_slc_qpp_stat_7;
  rand uvm_reg_field rx_slc_qpp_stat_14_8;
  rand uvm_reg_field rx_slc_qpp_stat_15;
  rand uvm_reg_field rx_slc_qpp_stat_31_16;
  
  covergroup wr_fld_covg;
    rx_slc_qpp_stat_6_0: coverpoint rx_slc_qpp_stat_6_0.value[6:0];
    rx_slc_qpp_stat_7: coverpoint rx_slc_qpp_stat_7.value[0:0];
    rx_slc_qpp_stat_14_8: coverpoint rx_slc_qpp_stat_14_8.value[6:0];
    rx_slc_qpp_stat_15: coverpoint rx_slc_qpp_stat_15.value[0:0];
    rx_slc_qpp_stat_31_16: coverpoint rx_slc_qpp_stat_31_16.value[15:0];
  endgroup
  covergroup rd_fld_covg;
    rx_slc_qpp_stat_6_0: coverpoint rx_slc_qpp_stat_6_0.value[6:0];
    rx_slc_qpp_stat_7: coverpoint rx_slc_qpp_stat_7.value[0:0];
    rx_slc_qpp_stat_14_8: coverpoint rx_slc_qpp_stat_14_8.value[6:0];
    rx_slc_qpp_stat_15: coverpoint rx_slc_qpp_stat_15.value[0:0];
    rx_slc_qpp_stat_31_16: coverpoint rx_slc_qpp_stat_31_16.value[15:0];
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
    
    rx_slc_qpp_stat_6_0 = fld_set[0];
    rx_slc_qpp_stat_7 = fld_set[1];
    rx_slc_qpp_stat_14_8 = fld_set[2];
    rx_slc_qpp_stat_15 = fld_set[3];
    rx_slc_qpp_stat_31_16 = fld_set[4];
  endfunction

  function new(input string name="T_rx_slc_qpp_stat_524");
    super.new(name, 32, build_coverage(UVM_CVR_FIELD_VALS));
    if (has_coverage(UVM_CVR_FIELD_VALS)) begin
      wr_fld_covg = new();
      rd_fld_covg = new();
    end
  endfunction

endclass


/////////////////////////////////////////////////////
//                rx_slc_run_tmr
/////////////////////////////////////////////////////
class T_rx_slc_run_tmr_533 extends cdns_uvm_reg;

  `uvm_object_utils(T_rx_slc_run_tmr_533)
  rand uvm_reg_field rx_slc_run_tmr_15_0;
  rand uvm_reg_field rx_slc_run_tmr_31_16;
  
  covergroup wr_fld_covg;
    rx_slc_run_tmr_15_0: coverpoint rx_slc_run_tmr_15_0.value[15:0];
    rx_slc_run_tmr_31_16: coverpoint rx_slc_run_tmr_31_16.value[15:0];
  endgroup
  covergroup rd_fld_covg;
    rx_slc_run_tmr_15_0: coverpoint rx_slc_run_tmr_15_0.value[15:0];
    rx_slc_run_tmr_31_16: coverpoint rx_slc_run_tmr_31_16.value[15:0];
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
    
    rx_slc_run_tmr_15_0 = fld_set[0];
    rx_slc_run_tmr_31_16 = fld_set[1];
  endfunction

  function new(input string name="T_rx_slc_run_tmr_533");
    super.new(name, 32, build_coverage(UVM_CVR_FIELD_VALS));
    if (has_coverage(UVM_CVR_FIELD_VALS)) begin
      wr_fld_covg = new();
      rd_fld_covg = new();
    end
  endfunction

endclass


/////////////////////////////////////////////////////
//                xcvr_cmsmt_clk_freq_msmt_ctrl
/////////////////////////////////////////////////////
class T_xcvr_cmsmt_clk_freq_msmt_ctrl_556 extends cdns_uvm_reg;

  `uvm_object_utils(T_xcvr_cmsmt_clk_freq_msmt_ctrl_556)
  rand uvm_reg_field xcvr_cmsmt_clk_freq_msmt_ctrl_13_0;
  rand uvm_reg_field xcvr_cmsmt_clk_freq_msmt_ctrl_14;
  rand uvm_reg_field xcvr_cmsmt_clk_freq_msmt_ctrl_15;
  rand uvm_reg_field xcvr_cmsmt_clk_freq_msmt_ctrl_31_16;
  
  covergroup wr_fld_covg;
    xcvr_cmsmt_clk_freq_msmt_ctrl_13_0: coverpoint xcvr_cmsmt_clk_freq_msmt_ctrl_13_0.value[13:0];
    xcvr_cmsmt_clk_freq_msmt_ctrl_14: coverpoint xcvr_cmsmt_clk_freq_msmt_ctrl_14.value[0:0];
    xcvr_cmsmt_clk_freq_msmt_ctrl_15: coverpoint xcvr_cmsmt_clk_freq_msmt_ctrl_15.value[0:0];
    xcvr_cmsmt_clk_freq_msmt_ctrl_31_16: coverpoint xcvr_cmsmt_clk_freq_msmt_ctrl_31_16.value[15:0];
  endgroup
  covergroup rd_fld_covg;
    xcvr_cmsmt_clk_freq_msmt_ctrl_13_0: coverpoint xcvr_cmsmt_clk_freq_msmt_ctrl_13_0.value[13:0];
    xcvr_cmsmt_clk_freq_msmt_ctrl_14: coverpoint xcvr_cmsmt_clk_freq_msmt_ctrl_14.value[0:0];
    xcvr_cmsmt_clk_freq_msmt_ctrl_15: coverpoint xcvr_cmsmt_clk_freq_msmt_ctrl_15.value[0:0];
    xcvr_cmsmt_clk_freq_msmt_ctrl_31_16: coverpoint xcvr_cmsmt_clk_freq_msmt_ctrl_31_16.value[15:0];
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
    
    xcvr_cmsmt_clk_freq_msmt_ctrl_13_0 = fld_set[0];
    xcvr_cmsmt_clk_freq_msmt_ctrl_14 = fld_set[1];
    xcvr_cmsmt_clk_freq_msmt_ctrl_15 = fld_set[2];
    xcvr_cmsmt_clk_freq_msmt_ctrl_31_16 = fld_set[3];
  endfunction

  function new(input string name="T_xcvr_cmsmt_clk_freq_msmt_ctrl_556");
    super.new(name, 32, build_coverage(UVM_CVR_FIELD_VALS));
    if (has_coverage(UVM_CVR_FIELD_VALS)) begin
      wr_fld_covg = new();
      rd_fld_covg = new();
    end
  endfunction

endclass


/////////////////////////////////////////////////////
//                xcvr_cmsmt_ref_clk_tmr_value
/////////////////////////////////////////////////////
class T_xcvr_cmsmt_ref_clk_tmr_value_558 extends cdns_uvm_reg;

  `uvm_object_utils(T_xcvr_cmsmt_ref_clk_tmr_value_558)
  rand uvm_reg_field xcvr_cmsmt_ref_clk_tmr_value_15_0;
  rand uvm_reg_field xcvr_cmsmt_ref_clk_tmr_value_31_16;
  
  covergroup wr_fld_covg;
    xcvr_cmsmt_ref_clk_tmr_value_15_0: coverpoint xcvr_cmsmt_ref_clk_tmr_value_15_0.value[15:0];
    xcvr_cmsmt_ref_clk_tmr_value_31_16: coverpoint xcvr_cmsmt_ref_clk_tmr_value_31_16.value[15:0];
  endgroup
  covergroup rd_fld_covg;
    xcvr_cmsmt_ref_clk_tmr_value_15_0: coverpoint xcvr_cmsmt_ref_clk_tmr_value_15_0.value[15:0];
    xcvr_cmsmt_ref_clk_tmr_value_31_16: coverpoint xcvr_cmsmt_ref_clk_tmr_value_31_16.value[15:0];
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
    
    xcvr_cmsmt_ref_clk_tmr_value_15_0 = fld_set[0];
    xcvr_cmsmt_ref_clk_tmr_value_31_16 = fld_set[1];
  endfunction

  function new(input string name="T_xcvr_cmsmt_ref_clk_tmr_value_558");
    super.new(name, 32, build_coverage(UVM_CVR_FIELD_VALS));
    if (has_coverage(UVM_CVR_FIELD_VALS)) begin
      wr_fld_covg = new();
      rd_fld_covg = new();
    end
  endfunction

endclass


/////////////////////////////////////////////////////
//                xcvr_cmsmt_test_clk_cnt_value
/////////////////////////////////////////////////////
class T_xcvr_cmsmt_test_clk_cnt_value_559 extends cdns_uvm_reg;

  `uvm_object_utils(T_xcvr_cmsmt_test_clk_cnt_value_559)
  rand uvm_reg_field xcvr_cmsmt_test_clk_cnt_value_15_0;
  rand uvm_reg_field xcvr_cmsmt_test_clk_cnt_value_31_16;
  
  covergroup wr_fld_covg;
    xcvr_cmsmt_test_clk_cnt_value_15_0: coverpoint xcvr_cmsmt_test_clk_cnt_value_15_0.value[15:0];
    xcvr_cmsmt_test_clk_cnt_value_31_16: coverpoint xcvr_cmsmt_test_clk_cnt_value_31_16.value[15:0];
  endgroup
  covergroup rd_fld_covg;
    xcvr_cmsmt_test_clk_cnt_value_15_0: coverpoint xcvr_cmsmt_test_clk_cnt_value_15_0.value[15:0];
    xcvr_cmsmt_test_clk_cnt_value_31_16: coverpoint xcvr_cmsmt_test_clk_cnt_value_31_16.value[15:0];
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
    
    xcvr_cmsmt_test_clk_cnt_value_15_0 = fld_set[0];
    xcvr_cmsmt_test_clk_cnt_value_31_16 = fld_set[1];
  endfunction

  function new(input string name="T_xcvr_cmsmt_test_clk_cnt_value_559");
    super.new(name, 32, build_coverage(UVM_CVR_FIELD_VALS));
    if (has_coverage(UVM_CVR_FIELD_VALS)) begin
      wr_fld_covg = new();
      rd_fld_covg = new();
    end
  endfunction

endclass


/////////////////////////////////////////////////////
//                xcvr_cmsmt_test_clk_sel
/////////////////////////////////////////////////////
class T_xcvr_cmsmt_test_clk_sel_557 extends cdns_uvm_reg;

  `uvm_object_utils(T_xcvr_cmsmt_test_clk_sel_557)
  rand uvm_reg_field xcvr_cmsmt_test_clk_sel_3_0;
  rand uvm_reg_field xcvr_cmsmt_test_clk_sel_15_4;
  rand uvm_reg_field xcvr_cmsmt_test_clk_sel_31_16;
  
  covergroup wr_fld_covg;
    xcvr_cmsmt_test_clk_sel_3_0: coverpoint xcvr_cmsmt_test_clk_sel_3_0.value[3:0];
    xcvr_cmsmt_test_clk_sel_15_4: coverpoint xcvr_cmsmt_test_clk_sel_15_4.value[11:0];
    xcvr_cmsmt_test_clk_sel_31_16: coverpoint xcvr_cmsmt_test_clk_sel_31_16.value[15:0];
  endgroup
  covergroup rd_fld_covg;
    xcvr_cmsmt_test_clk_sel_3_0: coverpoint xcvr_cmsmt_test_clk_sel_3_0.value[3:0];
    xcvr_cmsmt_test_clk_sel_15_4: coverpoint xcvr_cmsmt_test_clk_sel_15_4.value[11:0];
    xcvr_cmsmt_test_clk_sel_31_16: coverpoint xcvr_cmsmt_test_clk_sel_31_16.value[15:0];
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
    
    xcvr_cmsmt_test_clk_sel_3_0 = fld_set[0];
    xcvr_cmsmt_test_clk_sel_15_4 = fld_set[1];
    xcvr_cmsmt_test_clk_sel_31_16 = fld_set[2];
  endfunction

  function new(input string name="T_xcvr_cmsmt_test_clk_sel_557");
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
class T_sd3101_phy_registers_561 extends cdns_uvm_reg_block;

  `uvm_object_utils(T_sd3101_phy_registers_561)
  rand T_rx_cdrlf_2ol_gain_545 rx_cdrlf_2ol_gain;
  rand T_rx_cdrlf_cnfg0_536 rx_cdrlf_cnfg0;
  rand T_rx_cdrlf_cnfg1_537 rx_cdrlf_cnfg1;
  rand T_rx_cdrlf_cnfg2_538 rx_cdrlf_cnfg2;
  rand T_rx_cdrlf_cnfg4_539 rx_cdrlf_cnfg4;
  rand T_rx_cdrlf_cnfg5_540 rx_cdrlf_cnfg5;
  rand T_rx_cdrlf_fpl_ctrl1_541 rx_cdrlf_fpl_ctrl1;
  rand T_rx_cdrlf_fpl_ctrl2_542 rx_cdrlf_fpl_ctrl2;
  rand T_rx_cdrlf_fpl_ctrl3_543 rx_cdrlf_fpl_ctrl3;
  rand T_rx_cdrlf_pi_php_544 rx_cdrlf_pi_php;
  rand T_rx_ctlecal0_ctrl_493 rx_ctlecal0_ctrl;
  rand T_rx_ctlecal0_init_tmr_496 rx_ctlecal0_init_tmr;
  rand T_rx_ctlecal0_iter_tmr_497 rx_ctlecal0_iter_tmr;
  rand T_rx_ctlecal0_ovrd_494 rx_ctlecal0_ovrd;
  rand T_rx_ctlecal0_tune_495 rx_ctlecal0_tune;
  rand T_rx_ctlecal1_ctrl_498 rx_ctlecal1_ctrl;
  rand T_rx_ctlecal1_init_tmr_501 rx_ctlecal1_init_tmr;
  rand T_rx_ctlecal1_iter_tmr_502 rx_ctlecal1_iter_tmr;
  rand T_rx_ctlecal1_ovrd_499 rx_ctlecal1_ovrd;
  rand T_rx_ctlecal1_tune_500 rx_ctlecal1_tune;
  rand T_rx_diag_xcvr_rate_sel_560 rx_diag_xcvr_rate_sel;
  rand T_rx_eyesurf_ctrl_546 rx_eyesurf_ctrl;
  rand T_rx_eyesurf_errcnt_549 rx_eyesurf_errcnt;
  rand T_rx_eyesurf_offset_548 rx_eyesurf_offset;
  rand T_rx_eyesurf_tmr_test_547 rx_eyesurf_tmr_test;
  rand T_rx_feye_det_ctrl_515 rx_feye_det_ctrl;
  rand T_rx_feye_det_pi_adj_1_518 rx_feye_det_pi_adj_1;
  rand T_rx_feye_det_pi_adj_2_519 rx_feye_det_pi_adj_2;
  rand T_rx_feye_det_thr_517 rx_feye_det_thr;
  rand T_rx_feye_det_tmr_516 rx_feye_det_tmr;
  rand T_rx_psc_a0_485 rx_psc_a0;
  rand T_rx_psc_a1_486 rx_psc_a1;
  rand T_rx_psc_a2_487 rx_psc_a2;
  rand T_rx_psc_a3_488 rx_psc_a3;
  rand T_rx_psc_a4_489 rx_psc_a4;
  rand T_rx_psc_a5_490 rx_psc_a5;
  rand T_rx_psc_cal_491 rx_psc_cal;
  rand T_rx_psc_rdy_492 rx_psc_rdy;
  rand T_rx_qcccal_ctrl_550 rx_qcccal_ctrl;
  rand T_rx_qcccal_init_tmr_554 rx_qcccal_init_tmr;
  rand T_rx_qcccal_iter_tmr_555 rx_qcccal_iter_tmr;
  rand T_rx_qcccal_ovrd_551 rx_qcccal_ovrd;
  rand T_rx_qcccal_start_552 rx_qcccal_start;
  rand T_rx_qcccal_tune_553 rx_qcccal_tune;
  rand T_rx_sdcal0_ctrl_503 rx_sdcal0_ctrl;
  rand T_rx_sdcal0_init_tmr_507 rx_sdcal0_init_tmr;
  rand T_rx_sdcal0_iter_tmr_508 rx_sdcal0_iter_tmr;
  rand T_rx_sdcal0_ovrd_504 rx_sdcal0_ovrd;
  rand T_rx_sdcal0_start_505 rx_sdcal0_start;
  rand T_rx_sdcal0_tune_506 rx_sdcal0_tune;
  rand T_rx_sdcal1_ctrl_509 rx_sdcal1_ctrl;
  rand T_rx_sdcal1_init_tmr_513 rx_sdcal1_init_tmr;
  rand T_rx_sdcal1_iter_tmr_514 rx_sdcal1_iter_tmr;
  rand T_rx_sdcal1_ovrd_510 rx_sdcal1_ovrd;
  rand T_rx_sdcal1_start_511 rx_sdcal1_start;
  rand T_rx_sdcal1_tune_512 rx_sdcal1_tune;
  rand T_rx_slc_ctrl_520 rx_slc_ctrl;
  rand T_rx_slc_diag_ctrl_534 rx_slc_diag_ctrl;
  rand T_rx_slc_dis_535 rx_slc_dis;
  rand T_rx_slc_epm_ovrd_531 rx_slc_epm_ovrd;
  rand T_rx_slc_epm_stat_530 rx_slc_epm_stat;
  rand T_rx_slc_epp_ovrd_529 rx_slc_epp_ovrd;
  rand T_rx_slc_epp_stat_528 rx_slc_epp_stat;
  rand T_rx_slc_init_tmr_532 rx_slc_init_tmr;
  rand T_rx_slc_ipm_ovrd_523 rx_slc_ipm_ovrd;
  rand T_rx_slc_ipm_stat_522 rx_slc_ipm_stat;
  rand T_rx_slc_ipp_ovrd_521 rx_slc_ipp_ovrd;
  rand T_rx_slc_qpm_ovrd_527 rx_slc_qpm_ovrd;
  rand T_rx_slc_qpm_stat_526 rx_slc_qpm_stat;
  rand T_rx_slc_qpp_ovrd_525 rx_slc_qpp_ovrd;
  rand T_rx_slc_qpp_stat_524 rx_slc_qpp_stat;
  rand T_rx_slc_run_tmr_533 rx_slc_run_tmr;
  rand T_xcvr_cmsmt_clk_freq_msmt_ctrl_556 xcvr_cmsmt_clk_freq_msmt_ctrl;
  rand T_xcvr_cmsmt_ref_clk_tmr_value_558 xcvr_cmsmt_ref_clk_tmr_value;
  rand T_xcvr_cmsmt_test_clk_cnt_value_559 xcvr_cmsmt_test_clk_cnt_value;
  rand T_xcvr_cmsmt_test_clk_sel_557 xcvr_cmsmt_test_clk_sel;



  virtual function void build();
    uvm_reg  reg_set[$];
    string config_path = get_hier_path();
    default_map = create_map(get_name(), `UVM_REG_ADDR_WIDTH'h20000, 4, UVM_LITTLE_ENDIAN, 1);
    begin
       uvm_reg_config_ta ta = get_reg_config("pma_rx_lane_registers.sd3101_t4_registers_sd3101_phy_registers");
       build_uvm_regs(default_map, this, null, ta, reg_set);
    end
    if(! $cast(rx_cdrlf_2ol_gain, reg_set[0]))
      `uvm_error("UVM_REG", "rx_cdrlf_2ol_gain register casting error")
    if(! $cast(rx_cdrlf_cnfg0, reg_set[1]))
      `uvm_error("UVM_REG", "rx_cdrlf_cnfg0 register casting error")
    if(! $cast(rx_cdrlf_cnfg1, reg_set[2]))
      `uvm_error("UVM_REG", "rx_cdrlf_cnfg1 register casting error")
    if(! $cast(rx_cdrlf_cnfg2, reg_set[3]))
      `uvm_error("UVM_REG", "rx_cdrlf_cnfg2 register casting error")
    if(! $cast(rx_cdrlf_cnfg4, reg_set[4]))
      `uvm_error("UVM_REG", "rx_cdrlf_cnfg4 register casting error")
    if(! $cast(rx_cdrlf_cnfg5, reg_set[5]))
      `uvm_error("UVM_REG", "rx_cdrlf_cnfg5 register casting error")
    if(! $cast(rx_cdrlf_fpl_ctrl1, reg_set[6]))
      `uvm_error("UVM_REG", "rx_cdrlf_fpl_ctrl1 register casting error")
    if(! $cast(rx_cdrlf_fpl_ctrl2, reg_set[7]))
      `uvm_error("UVM_REG", "rx_cdrlf_fpl_ctrl2 register casting error")
    if(! $cast(rx_cdrlf_fpl_ctrl3, reg_set[8]))
      `uvm_error("UVM_REG", "rx_cdrlf_fpl_ctrl3 register casting error")
    if(! $cast(rx_cdrlf_pi_php, reg_set[9]))
      `uvm_error("UVM_REG", "rx_cdrlf_pi_php register casting error")
    if(! $cast(rx_ctlecal0_ctrl, reg_set[10]))
      `uvm_error("UVM_REG", "rx_ctlecal0_ctrl register casting error")
    if(! $cast(rx_ctlecal0_init_tmr, reg_set[11]))
      `uvm_error("UVM_REG", "rx_ctlecal0_init_tmr register casting error")
    if(! $cast(rx_ctlecal0_iter_tmr, reg_set[12]))
      `uvm_error("UVM_REG", "rx_ctlecal0_iter_tmr register casting error")
    if(! $cast(rx_ctlecal0_ovrd, reg_set[13]))
      `uvm_error("UVM_REG", "rx_ctlecal0_ovrd register casting error")
    if(! $cast(rx_ctlecal0_tune, reg_set[14]))
      `uvm_error("UVM_REG", "rx_ctlecal0_tune register casting error")
    if(! $cast(rx_ctlecal1_ctrl, reg_set[15]))
      `uvm_error("UVM_REG", "rx_ctlecal1_ctrl register casting error")
    if(! $cast(rx_ctlecal1_init_tmr, reg_set[16]))
      `uvm_error("UVM_REG", "rx_ctlecal1_init_tmr register casting error")
    if(! $cast(rx_ctlecal1_iter_tmr, reg_set[17]))
      `uvm_error("UVM_REG", "rx_ctlecal1_iter_tmr register casting error")
    if(! $cast(rx_ctlecal1_ovrd, reg_set[18]))
      `uvm_error("UVM_REG", "rx_ctlecal1_ovrd register casting error")
    if(! $cast(rx_ctlecal1_tune, reg_set[19]))
      `uvm_error("UVM_REG", "rx_ctlecal1_tune register casting error")
    if(! $cast(rx_diag_xcvr_rate_sel, reg_set[20]))
      `uvm_error("UVM_REG", "rx_diag_xcvr_rate_sel register casting error")
    if(! $cast(rx_eyesurf_ctrl, reg_set[21]))
      `uvm_error("UVM_REG", "rx_eyesurf_ctrl register casting error")
    if(! $cast(rx_eyesurf_errcnt, reg_set[22]))
      `uvm_error("UVM_REG", "rx_eyesurf_errcnt register casting error")
    if(! $cast(rx_eyesurf_offset, reg_set[23]))
      `uvm_error("UVM_REG", "rx_eyesurf_offset register casting error")
    if(! $cast(rx_eyesurf_tmr_test, reg_set[24]))
      `uvm_error("UVM_REG", "rx_eyesurf_tmr_test register casting error")
    if(! $cast(rx_feye_det_ctrl, reg_set[25]))
      `uvm_error("UVM_REG", "rx_feye_det_ctrl register casting error")
    if(! $cast(rx_feye_det_pi_adj_1, reg_set[26]))
      `uvm_error("UVM_REG", "rx_feye_det_pi_adj_1 register casting error")
    if(! $cast(rx_feye_det_pi_adj_2, reg_set[27]))
      `uvm_error("UVM_REG", "rx_feye_det_pi_adj_2 register casting error")
    if(! $cast(rx_feye_det_thr, reg_set[28]))
      `uvm_error("UVM_REG", "rx_feye_det_thr register casting error")
    if(! $cast(rx_feye_det_tmr, reg_set[29]))
      `uvm_error("UVM_REG", "rx_feye_det_tmr register casting error")
    if(! $cast(rx_psc_a0, reg_set[30]))
      `uvm_error("UVM_REG", "rx_psc_a0 register casting error")
    if(! $cast(rx_psc_a1, reg_set[31]))
      `uvm_error("UVM_REG", "rx_psc_a1 register casting error")
    if(! $cast(rx_psc_a2, reg_set[32]))
      `uvm_error("UVM_REG", "rx_psc_a2 register casting error")
    if(! $cast(rx_psc_a3, reg_set[33]))
      `uvm_error("UVM_REG", "rx_psc_a3 register casting error")
    if(! $cast(rx_psc_a4, reg_set[34]))
      `uvm_error("UVM_REG", "rx_psc_a4 register casting error")
    if(! $cast(rx_psc_a5, reg_set[35]))
      `uvm_error("UVM_REG", "rx_psc_a5 register casting error")
    if(! $cast(rx_psc_cal, reg_set[36]))
      `uvm_error("UVM_REG", "rx_psc_cal register casting error")
    if(! $cast(rx_psc_rdy, reg_set[37]))
      `uvm_error("UVM_REG", "rx_psc_rdy register casting error")
    if(! $cast(rx_qcccal_ctrl, reg_set[38]))
      `uvm_error("UVM_REG", "rx_qcccal_ctrl register casting error")
    if(! $cast(rx_qcccal_init_tmr, reg_set[39]))
      `uvm_error("UVM_REG", "rx_qcccal_init_tmr register casting error")
    if(! $cast(rx_qcccal_iter_tmr, reg_set[40]))
      `uvm_error("UVM_REG", "rx_qcccal_iter_tmr register casting error")
    if(! $cast(rx_qcccal_ovrd, reg_set[41]))
      `uvm_error("UVM_REG", "rx_qcccal_ovrd register casting error")
    if(! $cast(rx_qcccal_start, reg_set[42]))
      `uvm_error("UVM_REG", "rx_qcccal_start register casting error")
    if(! $cast(rx_qcccal_tune, reg_set[43]))
      `uvm_error("UVM_REG", "rx_qcccal_tune register casting error")
    if(! $cast(rx_sdcal0_ctrl, reg_set[44]))
      `uvm_error("UVM_REG", "rx_sdcal0_ctrl register casting error")
    if(! $cast(rx_sdcal0_init_tmr, reg_set[45]))
      `uvm_error("UVM_REG", "rx_sdcal0_init_tmr register casting error")
    if(! $cast(rx_sdcal0_iter_tmr, reg_set[46]))
      `uvm_error("UVM_REG", "rx_sdcal0_iter_tmr register casting error")
    if(! $cast(rx_sdcal0_ovrd, reg_set[47]))
      `uvm_error("UVM_REG", "rx_sdcal0_ovrd register casting error")
    if(! $cast(rx_sdcal0_start, reg_set[48]))
      `uvm_error("UVM_REG", "rx_sdcal0_start register casting error")
    if(! $cast(rx_sdcal0_tune, reg_set[49]))
      `uvm_error("UVM_REG", "rx_sdcal0_tune register casting error")
    if(! $cast(rx_sdcal1_ctrl, reg_set[50]))
      `uvm_error("UVM_REG", "rx_sdcal1_ctrl register casting error")
    if(! $cast(rx_sdcal1_init_tmr, reg_set[51]))
      `uvm_error("UVM_REG", "rx_sdcal1_init_tmr register casting error")
    if(! $cast(rx_sdcal1_iter_tmr, reg_set[52]))
      `uvm_error("UVM_REG", "rx_sdcal1_iter_tmr register casting error")
    if(! $cast(rx_sdcal1_ovrd, reg_set[53]))
      `uvm_error("UVM_REG", "rx_sdcal1_ovrd register casting error")
    if(! $cast(rx_sdcal1_start, reg_set[54]))
      `uvm_error("UVM_REG", "rx_sdcal1_start register casting error")
    if(! $cast(rx_sdcal1_tune, reg_set[55]))
      `uvm_error("UVM_REG", "rx_sdcal1_tune register casting error")
    if(! $cast(rx_slc_ctrl, reg_set[56]))
      `uvm_error("UVM_REG", "rx_slc_ctrl register casting error")
    if(! $cast(rx_slc_diag_ctrl, reg_set[57]))
      `uvm_error("UVM_REG", "rx_slc_diag_ctrl register casting error")
    if(! $cast(rx_slc_dis, reg_set[58]))
      `uvm_error("UVM_REG", "rx_slc_dis register casting error")
    if(! $cast(rx_slc_epm_ovrd, reg_set[59]))
      `uvm_error("UVM_REG", "rx_slc_epm_ovrd register casting error")
    if(! $cast(rx_slc_epm_stat, reg_set[60]))
      `uvm_error("UVM_REG", "rx_slc_epm_stat register casting error")
    if(! $cast(rx_slc_epp_ovrd, reg_set[61]))
      `uvm_error("UVM_REG", "rx_slc_epp_ovrd register casting error")
    if(! $cast(rx_slc_epp_stat, reg_set[62]))
      `uvm_error("UVM_REG", "rx_slc_epp_stat register casting error")
    if(! $cast(rx_slc_init_tmr, reg_set[63]))
      `uvm_error("UVM_REG", "rx_slc_init_tmr register casting error")
    if(! $cast(rx_slc_ipm_ovrd, reg_set[64]))
      `uvm_error("UVM_REG", "rx_slc_ipm_ovrd register casting error")
    if(! $cast(rx_slc_ipm_stat, reg_set[65]))
      `uvm_error("UVM_REG", "rx_slc_ipm_stat register casting error")
    if(! $cast(rx_slc_ipp_ovrd, reg_set[66]))
      `uvm_error("UVM_REG", "rx_slc_ipp_ovrd register casting error")
    if(! $cast(rx_slc_qpm_ovrd, reg_set[67]))
      `uvm_error("UVM_REG", "rx_slc_qpm_ovrd register casting error")
    if(! $cast(rx_slc_qpm_stat, reg_set[68]))
      `uvm_error("UVM_REG", "rx_slc_qpm_stat register casting error")
    if(! $cast(rx_slc_qpp_ovrd, reg_set[69]))
      `uvm_error("UVM_REG", "rx_slc_qpp_ovrd register casting error")
    if(! $cast(rx_slc_qpp_stat, reg_set[70]))
      `uvm_error("UVM_REG", "rx_slc_qpp_stat register casting error")
    if(! $cast(rx_slc_run_tmr, reg_set[71]))
      `uvm_error("UVM_REG", "rx_slc_run_tmr register casting error")
    if(! $cast(xcvr_cmsmt_clk_freq_msmt_ctrl, reg_set[72]))
      `uvm_error("UVM_REG", "xcvr_cmsmt_clk_freq_msmt_ctrl register casting error")
    if(! $cast(xcvr_cmsmt_ref_clk_tmr_value, reg_set[73]))
      `uvm_error("UVM_REG", "xcvr_cmsmt_ref_clk_tmr_value register casting error")
    if(! $cast(xcvr_cmsmt_test_clk_cnt_value, reg_set[74]))
      `uvm_error("UVM_REG", "xcvr_cmsmt_test_clk_cnt_value register casting error")
    if(! $cast(xcvr_cmsmt_test_clk_sel, reg_set[75]))
      `uvm_error("UVM_REG", "xcvr_cmsmt_test_clk_sel register casting error")

  endfunction

  function new(input string name="sd3101_t4_registers_sd3101_phy_registers");
    super.new(name, UVM_NO_COVERAGE);
  endfunction

endclass


/////////////////////////////////////////////////////
//                pma_rx_lane_registers
/////////////////////////////////////////////////////
class pma_rx_lane_registers_vendor_cadence_library_cdns_lib_version_1685_2009 extends cdns_uvm_reg_block;

  `uvm_object_utils(pma_rx_lane_registers_vendor_cadence_library_cdns_lib_version_1685_2009)

  uvm_reg_map default_map;
  uvm_reg_map sd3101_t4_registers;
  rand T_sd3101_phy_registers_561 sd3101_t4_registers_sd3101_phy_registers;

`include "cdn_regmodel_task_member.sv"
  virtual function void build();
    sd3101_t4_registers = create_map("sd3101_t4_registers", `UVM_REG_ADDR_WIDTH'h0, 4, UVM_LITTLE_ENDIAN, 1);
    default_map = sd3101_t4_registers;
    sd3101_t4_registers_sd3101_phy_registers = T_sd3101_phy_registers_561::type_id::create("sd3101_t4_registers_sd3101_phy_registers", , get_full_name());
    sd3101_t4_registers_sd3101_phy_registers.configure(this);
    sd3101_t4_registers_sd3101_phy_registers.build();

    //Mapping sd3101_t4_registers map
    sd3101_t4_registers_sd3101_phy_registers.default_map.add_parent_map(sd3101_t4_registers,`UVM_REG_ADDR_WIDTH'h20000);
    sd3101_t4_registers.set_submap_offset(sd3101_t4_registers_sd3101_phy_registers.default_map, `UVM_REG_ADDR_WIDTH'h20000);
    //Apply hdl_paths
    apply_hdl_paths(this);

  endfunction



  function new(input string name="pma_rx_lane_registers");
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
         "T_rx_cdrlf_2ol_gain_545": begin T_rx_cdrlf_2ol_gain_545 rx_cdrlf_2ol_gain = new(objectname); create = rx_cdrlf_2ol_gain;  end
         "T_rx_cdrlf_cnfg0_536": begin T_rx_cdrlf_cnfg0_536 rx_cdrlf_cnfg0 = new(objectname); create = rx_cdrlf_cnfg0;  end
         "T_rx_cdrlf_cnfg1_537": begin T_rx_cdrlf_cnfg1_537 rx_cdrlf_cnfg1 = new(objectname); create = rx_cdrlf_cnfg1;  end
         "T_rx_cdrlf_cnfg2_538": begin T_rx_cdrlf_cnfg2_538 rx_cdrlf_cnfg2 = new(objectname); create = rx_cdrlf_cnfg2;  end
         "T_rx_cdrlf_cnfg4_539": begin T_rx_cdrlf_cnfg4_539 rx_cdrlf_cnfg4 = new(objectname); create = rx_cdrlf_cnfg4;  end
         "T_rx_cdrlf_cnfg5_540": begin T_rx_cdrlf_cnfg5_540 rx_cdrlf_cnfg5 = new(objectname); create = rx_cdrlf_cnfg5;  end
         "T_rx_cdrlf_fpl_ctrl1_541": begin T_rx_cdrlf_fpl_ctrl1_541 rx_cdrlf_fpl_ctrl1 = new(objectname); create = rx_cdrlf_fpl_ctrl1;  end
         "T_rx_cdrlf_fpl_ctrl2_542": begin T_rx_cdrlf_fpl_ctrl2_542 rx_cdrlf_fpl_ctrl2 = new(objectname); create = rx_cdrlf_fpl_ctrl2;  end
         "T_rx_cdrlf_fpl_ctrl3_543": begin T_rx_cdrlf_fpl_ctrl3_543 rx_cdrlf_fpl_ctrl3 = new(objectname); create = rx_cdrlf_fpl_ctrl3;  end
         "T_rx_cdrlf_pi_php_544": begin T_rx_cdrlf_pi_php_544 rx_cdrlf_pi_php = new(objectname); create = rx_cdrlf_pi_php;  end
         "T_rx_ctlecal0_ctrl_493": begin T_rx_ctlecal0_ctrl_493 rx_ctlecal0_ctrl = new(objectname); create = rx_ctlecal0_ctrl;  end
         "T_rx_ctlecal0_init_tmr_496": begin T_rx_ctlecal0_init_tmr_496 rx_ctlecal0_init_tmr = new(objectname); create = rx_ctlecal0_init_tmr;  end
         "T_rx_ctlecal0_iter_tmr_497": begin T_rx_ctlecal0_iter_tmr_497 rx_ctlecal0_iter_tmr = new(objectname); create = rx_ctlecal0_iter_tmr;  end
         "T_rx_ctlecal0_ovrd_494": begin T_rx_ctlecal0_ovrd_494 rx_ctlecal0_ovrd = new(objectname); create = rx_ctlecal0_ovrd;  end
         "T_rx_ctlecal0_tune_495": begin T_rx_ctlecal0_tune_495 rx_ctlecal0_tune = new(objectname); create = rx_ctlecal0_tune;  end
         "T_rx_ctlecal1_ctrl_498": begin T_rx_ctlecal1_ctrl_498 rx_ctlecal1_ctrl = new(objectname); create = rx_ctlecal1_ctrl;  end
         "T_rx_ctlecal1_init_tmr_501": begin T_rx_ctlecal1_init_tmr_501 rx_ctlecal1_init_tmr = new(objectname); create = rx_ctlecal1_init_tmr;  end
         "T_rx_ctlecal1_iter_tmr_502": begin T_rx_ctlecal1_iter_tmr_502 rx_ctlecal1_iter_tmr = new(objectname); create = rx_ctlecal1_iter_tmr;  end
         "T_rx_ctlecal1_ovrd_499": begin T_rx_ctlecal1_ovrd_499 rx_ctlecal1_ovrd = new(objectname); create = rx_ctlecal1_ovrd;  end
         "T_rx_ctlecal1_tune_500": begin T_rx_ctlecal1_tune_500 rx_ctlecal1_tune = new(objectname); create = rx_ctlecal1_tune;  end
         "T_rx_diag_xcvr_rate_sel_560": begin T_rx_diag_xcvr_rate_sel_560 rx_diag_xcvr_rate_sel = new(objectname); create = rx_diag_xcvr_rate_sel;  end
         "T_rx_eyesurf_ctrl_546": begin T_rx_eyesurf_ctrl_546 rx_eyesurf_ctrl = new(objectname); create = rx_eyesurf_ctrl;  end
         "T_rx_eyesurf_errcnt_549": begin T_rx_eyesurf_errcnt_549 rx_eyesurf_errcnt = new(objectname); create = rx_eyesurf_errcnt;  end
         "T_rx_eyesurf_offset_548": begin T_rx_eyesurf_offset_548 rx_eyesurf_offset = new(objectname); create = rx_eyesurf_offset;  end
         "T_rx_eyesurf_tmr_test_547": begin T_rx_eyesurf_tmr_test_547 rx_eyesurf_tmr_test = new(objectname); create = rx_eyesurf_tmr_test;  end
         "T_rx_feye_det_ctrl_515": begin T_rx_feye_det_ctrl_515 rx_feye_det_ctrl = new(objectname); create = rx_feye_det_ctrl;  end
         "T_rx_feye_det_pi_adj_1_518": begin T_rx_feye_det_pi_adj_1_518 rx_feye_det_pi_adj_1 = new(objectname); create = rx_feye_det_pi_adj_1;  end
         "T_rx_feye_det_pi_adj_2_519": begin T_rx_feye_det_pi_adj_2_519 rx_feye_det_pi_adj_2 = new(objectname); create = rx_feye_det_pi_adj_2;  end
         "T_rx_feye_det_thr_517": begin T_rx_feye_det_thr_517 rx_feye_det_thr = new(objectname); create = rx_feye_det_thr;  end
         "T_rx_feye_det_tmr_516": begin T_rx_feye_det_tmr_516 rx_feye_det_tmr = new(objectname); create = rx_feye_det_tmr;  end
         "T_rx_psc_a0_485": begin T_rx_psc_a0_485 rx_psc_a0 = new(objectname); create = rx_psc_a0;  end
         "T_rx_psc_a1_486": begin T_rx_psc_a1_486 rx_psc_a1 = new(objectname); create = rx_psc_a1;  end
         "T_rx_psc_a2_487": begin T_rx_psc_a2_487 rx_psc_a2 = new(objectname); create = rx_psc_a2;  end
         "T_rx_psc_a3_488": begin T_rx_psc_a3_488 rx_psc_a3 = new(objectname); create = rx_psc_a3;  end
         "T_rx_psc_a4_489": begin T_rx_psc_a4_489 rx_psc_a4 = new(objectname); create = rx_psc_a4;  end
         "T_rx_psc_a5_490": begin T_rx_psc_a5_490 rx_psc_a5 = new(objectname); create = rx_psc_a5;  end
         "T_rx_psc_cal_491": begin T_rx_psc_cal_491 rx_psc_cal = new(objectname); create = rx_psc_cal;  end
         "T_rx_psc_rdy_492": begin T_rx_psc_rdy_492 rx_psc_rdy = new(objectname); create = rx_psc_rdy;  end
         "T_rx_qcccal_ctrl_550": begin T_rx_qcccal_ctrl_550 rx_qcccal_ctrl = new(objectname); create = rx_qcccal_ctrl;  end
         "T_rx_qcccal_init_tmr_554": begin T_rx_qcccal_init_tmr_554 rx_qcccal_init_tmr = new(objectname); create = rx_qcccal_init_tmr;  end
         "T_rx_qcccal_iter_tmr_555": begin T_rx_qcccal_iter_tmr_555 rx_qcccal_iter_tmr = new(objectname); create = rx_qcccal_iter_tmr;  end
         "T_rx_qcccal_ovrd_551": begin T_rx_qcccal_ovrd_551 rx_qcccal_ovrd = new(objectname); create = rx_qcccal_ovrd;  end
         "T_rx_qcccal_start_552": begin T_rx_qcccal_start_552 rx_qcccal_start = new(objectname); create = rx_qcccal_start;  end
         "T_rx_qcccal_tune_553": begin T_rx_qcccal_tune_553 rx_qcccal_tune = new(objectname); create = rx_qcccal_tune;  end
         "T_rx_sdcal0_ctrl_503": begin T_rx_sdcal0_ctrl_503 rx_sdcal0_ctrl = new(objectname); create = rx_sdcal0_ctrl;  end
         "T_rx_sdcal0_init_tmr_507": begin T_rx_sdcal0_init_tmr_507 rx_sdcal0_init_tmr = new(objectname); create = rx_sdcal0_init_tmr;  end
         "T_rx_sdcal0_iter_tmr_508": begin T_rx_sdcal0_iter_tmr_508 rx_sdcal0_iter_tmr = new(objectname); create = rx_sdcal0_iter_tmr;  end
         "T_rx_sdcal0_ovrd_504": begin T_rx_sdcal0_ovrd_504 rx_sdcal0_ovrd = new(objectname); create = rx_sdcal0_ovrd;  end
         "T_rx_sdcal0_start_505": begin T_rx_sdcal0_start_505 rx_sdcal0_start = new(objectname); create = rx_sdcal0_start;  end
         "T_rx_sdcal0_tune_506": begin T_rx_sdcal0_tune_506 rx_sdcal0_tune = new(objectname); create = rx_sdcal0_tune;  end
         "T_rx_sdcal1_ctrl_509": begin T_rx_sdcal1_ctrl_509 rx_sdcal1_ctrl = new(objectname); create = rx_sdcal1_ctrl;  end
         "T_rx_sdcal1_init_tmr_513": begin T_rx_sdcal1_init_tmr_513 rx_sdcal1_init_tmr = new(objectname); create = rx_sdcal1_init_tmr;  end
         "T_rx_sdcal1_iter_tmr_514": begin T_rx_sdcal1_iter_tmr_514 rx_sdcal1_iter_tmr = new(objectname); create = rx_sdcal1_iter_tmr;  end
         "T_rx_sdcal1_ovrd_510": begin T_rx_sdcal1_ovrd_510 rx_sdcal1_ovrd = new(objectname); create = rx_sdcal1_ovrd;  end
         "T_rx_sdcal1_start_511": begin T_rx_sdcal1_start_511 rx_sdcal1_start = new(objectname); create = rx_sdcal1_start;  end
         "T_rx_sdcal1_tune_512": begin T_rx_sdcal1_tune_512 rx_sdcal1_tune = new(objectname); create = rx_sdcal1_tune;  end
         "T_rx_slc_ctrl_520": begin T_rx_slc_ctrl_520 rx_slc_ctrl = new(objectname); create = rx_slc_ctrl;  end
         "T_rx_slc_diag_ctrl_534": begin T_rx_slc_diag_ctrl_534 rx_slc_diag_ctrl = new(objectname); create = rx_slc_diag_ctrl;  end
         "T_rx_slc_dis_535": begin T_rx_slc_dis_535 rx_slc_dis = new(objectname); create = rx_slc_dis;  end
         "T_rx_slc_epm_ovrd_531": begin T_rx_slc_epm_ovrd_531 rx_slc_epm_ovrd = new(objectname); create = rx_slc_epm_ovrd;  end
         "T_rx_slc_epm_stat_530": begin T_rx_slc_epm_stat_530 rx_slc_epm_stat = new(objectname); create = rx_slc_epm_stat;  end
         "T_rx_slc_epp_ovrd_529": begin T_rx_slc_epp_ovrd_529 rx_slc_epp_ovrd = new(objectname); create = rx_slc_epp_ovrd;  end
         "T_rx_slc_epp_stat_528": begin T_rx_slc_epp_stat_528 rx_slc_epp_stat = new(objectname); create = rx_slc_epp_stat;  end
         "T_rx_slc_init_tmr_532": begin T_rx_slc_init_tmr_532 rx_slc_init_tmr = new(objectname); create = rx_slc_init_tmr;  end
         "T_rx_slc_ipm_ovrd_523": begin T_rx_slc_ipm_ovrd_523 rx_slc_ipm_ovrd = new(objectname); create = rx_slc_ipm_ovrd;  end
         "T_rx_slc_ipm_stat_522": begin T_rx_slc_ipm_stat_522 rx_slc_ipm_stat = new(objectname); create = rx_slc_ipm_stat;  end
         "T_rx_slc_ipp_ovrd_521": begin T_rx_slc_ipp_ovrd_521 rx_slc_ipp_ovrd = new(objectname); create = rx_slc_ipp_ovrd;  end
         "T_rx_slc_qpm_ovrd_527": begin T_rx_slc_qpm_ovrd_527 rx_slc_qpm_ovrd = new(objectname); create = rx_slc_qpm_ovrd;  end
         "T_rx_slc_qpm_stat_526": begin T_rx_slc_qpm_stat_526 rx_slc_qpm_stat = new(objectname); create = rx_slc_qpm_stat;  end
         "T_rx_slc_qpp_ovrd_525": begin T_rx_slc_qpp_ovrd_525 rx_slc_qpp_ovrd = new(objectname); create = rx_slc_qpp_ovrd;  end
         "T_rx_slc_qpp_stat_524": begin T_rx_slc_qpp_stat_524 rx_slc_qpp_stat = new(objectname); create = rx_slc_qpp_stat;  end
         "T_rx_slc_run_tmr_533": begin T_rx_slc_run_tmr_533 rx_slc_run_tmr = new(objectname); create = rx_slc_run_tmr;  end
         "T_xcvr_cmsmt_clk_freq_msmt_ctrl_556": begin T_xcvr_cmsmt_clk_freq_msmt_ctrl_556 xcvr_cmsmt_clk_freq_msmt_ctrl = new(objectname); create = xcvr_cmsmt_clk_freq_msmt_ctrl;  end
         "T_xcvr_cmsmt_ref_clk_tmr_value_558": begin T_xcvr_cmsmt_ref_clk_tmr_value_558 xcvr_cmsmt_ref_clk_tmr_value = new(objectname); create = xcvr_cmsmt_ref_clk_tmr_value;  end
         "T_xcvr_cmsmt_test_clk_cnt_value_559": begin T_xcvr_cmsmt_test_clk_cnt_value_559 xcvr_cmsmt_test_clk_cnt_value = new(objectname); create = xcvr_cmsmt_test_clk_cnt_value;  end
         "T_xcvr_cmsmt_test_clk_sel_557": begin T_xcvr_cmsmt_test_clk_sel_557 xcvr_cmsmt_test_clk_sel = new(objectname); create = xcvr_cmsmt_test_clk_sel;  end

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
   cdns_uvmreg_utils_pkg_pma_rx_lane_registers::factory=cdns_factory;


   return cdns_factory;
endfunction
cdns_factory_base cdns_factory = get_factory(no_factory);

endpackage



