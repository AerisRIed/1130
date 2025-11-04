//*************************************************************//
//   ** File Generated Automatically
//   ** Please donot edit manually
//*************************************************************//


package cdn_pma_cmn_reg_pkg;
  import uvm_pkg::*;
  `include "uvm_macros.svh"
  import cdns_uvmreg_utils_pkg_pma_cmn_registers::*;

  bit no_factory = 0; 

/////////////////////////////////////////////////////
//                cmn_bgcal_ctrl
/////////////////////////////////////////////////////
class T_cmn_bgcal_ctrl_1033 extends cdns_uvm_reg;

  `uvm_object_utils(T_cmn_bgcal_ctrl_1033)
  rand uvm_reg_field cmn_bgcal_ctrl_5_0;
  rand uvm_reg_field cmn_bgcal_ctrl_11_6;
  rand uvm_reg_field cmn_bgcal_ctrl_12;
  rand uvm_reg_field cmn_bgcal_ctrl_13;
  rand uvm_reg_field cmn_bgcal_ctrl_14;
  rand uvm_reg_field cmn_bgcal_ctrl_15;
  rand uvm_reg_field cmn_bgcal_ctrl_31_16;
  
  covergroup wr_fld_covg;
    cmn_bgcal_ctrl_5_0: coverpoint cmn_bgcal_ctrl_5_0.value[5:0];
    cmn_bgcal_ctrl_11_6: coverpoint cmn_bgcal_ctrl_11_6.value[5:0];
    cmn_bgcal_ctrl_12: coverpoint cmn_bgcal_ctrl_12.value[0:0];
    cmn_bgcal_ctrl_13: coverpoint cmn_bgcal_ctrl_13.value[0:0];
    cmn_bgcal_ctrl_14: coverpoint cmn_bgcal_ctrl_14.value[0:0];
    cmn_bgcal_ctrl_15: coverpoint cmn_bgcal_ctrl_15.value[0:0];
    cmn_bgcal_ctrl_31_16: coverpoint cmn_bgcal_ctrl_31_16.value[15:0];
  endgroup
  covergroup rd_fld_covg;
    cmn_bgcal_ctrl_5_0: coverpoint cmn_bgcal_ctrl_5_0.value[5:0];
    cmn_bgcal_ctrl_11_6: coverpoint cmn_bgcal_ctrl_11_6.value[5:0];
    cmn_bgcal_ctrl_12: coverpoint cmn_bgcal_ctrl_12.value[0:0];
    cmn_bgcal_ctrl_13: coverpoint cmn_bgcal_ctrl_13.value[0:0];
    cmn_bgcal_ctrl_14: coverpoint cmn_bgcal_ctrl_14.value[0:0];
    cmn_bgcal_ctrl_15: coverpoint cmn_bgcal_ctrl_15.value[0:0];
    cmn_bgcal_ctrl_31_16: coverpoint cmn_bgcal_ctrl_31_16.value[15:0];
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
    
    cmn_bgcal_ctrl_5_0 = fld_set[0];
    cmn_bgcal_ctrl_11_6 = fld_set[1];
    cmn_bgcal_ctrl_12 = fld_set[2];
    cmn_bgcal_ctrl_13 = fld_set[3];
    cmn_bgcal_ctrl_14 = fld_set[4];
    cmn_bgcal_ctrl_15 = fld_set[5];
    cmn_bgcal_ctrl_31_16 = fld_set[6];
  endfunction

  function new(input string name="T_cmn_bgcal_ctrl_1033");
    super.new(name, 32, build_coverage(UVM_CVR_FIELD_VALS));
    if (has_coverage(UVM_CVR_FIELD_VALS)) begin
      wr_fld_covg = new();
      rd_fld_covg = new();
    end
  endfunction

endclass


/////////////////////////////////////////////////////
//                cmn_bgcal_init_tmr
/////////////////////////////////////////////////////
class T_cmn_bgcal_init_tmr_1037 extends cdns_uvm_reg;

  `uvm_object_utils(T_cmn_bgcal_init_tmr_1037)
  rand uvm_reg_field cmn_bgcal_init_tmr_8_0;
  rand uvm_reg_field cmn_bgcal_init_tmr_15_9;
  rand uvm_reg_field cmn_bgcal_init_tmr_31_16;
  
  covergroup wr_fld_covg;
    cmn_bgcal_init_tmr_8_0: coverpoint cmn_bgcal_init_tmr_8_0.value[8:0];
    cmn_bgcal_init_tmr_15_9: coverpoint cmn_bgcal_init_tmr_15_9.value[6:0];
    cmn_bgcal_init_tmr_31_16: coverpoint cmn_bgcal_init_tmr_31_16.value[15:0];
  endgroup
  covergroup rd_fld_covg;
    cmn_bgcal_init_tmr_8_0: coverpoint cmn_bgcal_init_tmr_8_0.value[8:0];
    cmn_bgcal_init_tmr_15_9: coverpoint cmn_bgcal_init_tmr_15_9.value[6:0];
    cmn_bgcal_init_tmr_31_16: coverpoint cmn_bgcal_init_tmr_31_16.value[15:0];
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
    
    cmn_bgcal_init_tmr_8_0 = fld_set[0];
    cmn_bgcal_init_tmr_15_9 = fld_set[1];
    cmn_bgcal_init_tmr_31_16 = fld_set[2];
  endfunction

  function new(input string name="T_cmn_bgcal_init_tmr_1037");
    super.new(name, 32, build_coverage(UVM_CVR_FIELD_VALS));
    if (has_coverage(UVM_CVR_FIELD_VALS)) begin
      wr_fld_covg = new();
      rd_fld_covg = new();
    end
  endfunction

endclass


/////////////////////////////////////////////////////
//                cmn_bgcal_iter_tmr
/////////////////////////////////////////////////////
class T_cmn_bgcal_iter_tmr_1038 extends cdns_uvm_reg;

  `uvm_object_utils(T_cmn_bgcal_iter_tmr_1038)
  rand uvm_reg_field cmn_bgcal_iter_tmr_8_0;
  rand uvm_reg_field cmn_bgcal_iter_tmr_15_9;
  rand uvm_reg_field cmn_bgcal_iter_tmr_31_16;
  
  covergroup wr_fld_covg;
    cmn_bgcal_iter_tmr_8_0: coverpoint cmn_bgcal_iter_tmr_8_0.value[8:0];
    cmn_bgcal_iter_tmr_15_9: coverpoint cmn_bgcal_iter_tmr_15_9.value[6:0];
    cmn_bgcal_iter_tmr_31_16: coverpoint cmn_bgcal_iter_tmr_31_16.value[15:0];
  endgroup
  covergroup rd_fld_covg;
    cmn_bgcal_iter_tmr_8_0: coverpoint cmn_bgcal_iter_tmr_8_0.value[8:0];
    cmn_bgcal_iter_tmr_15_9: coverpoint cmn_bgcal_iter_tmr_15_9.value[6:0];
    cmn_bgcal_iter_tmr_31_16: coverpoint cmn_bgcal_iter_tmr_31_16.value[15:0];
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
    
    cmn_bgcal_iter_tmr_8_0 = fld_set[0];
    cmn_bgcal_iter_tmr_15_9 = fld_set[1];
    cmn_bgcal_iter_tmr_31_16 = fld_set[2];
  endfunction

  function new(input string name="T_cmn_bgcal_iter_tmr_1038");
    super.new(name, 32, build_coverage(UVM_CVR_FIELD_VALS));
    if (has_coverage(UVM_CVR_FIELD_VALS)) begin
      wr_fld_covg = new();
      rd_fld_covg = new();
    end
  endfunction

endclass


/////////////////////////////////////////////////////
//                cmn_bgcal_ovrd
/////////////////////////////////////////////////////
class T_cmn_bgcal_ovrd_1034 extends cdns_uvm_reg;

  `uvm_object_utils(T_cmn_bgcal_ovrd_1034)
  rand uvm_reg_field cmn_bgcal_ovrd_5_0;
  rand uvm_reg_field cmn_bgcal_ovrd_13_6;
  rand uvm_reg_field cmn_bgcal_ovrd_14;
  rand uvm_reg_field cmn_bgcal_ovrd_15;
  rand uvm_reg_field cmn_bgcal_ovrd_31_16;
  
  covergroup wr_fld_covg;
    cmn_bgcal_ovrd_5_0: coverpoint cmn_bgcal_ovrd_5_0.value[5:0];
    cmn_bgcal_ovrd_13_6: coverpoint cmn_bgcal_ovrd_13_6.value[7:0];
    cmn_bgcal_ovrd_14: coverpoint cmn_bgcal_ovrd_14.value[0:0];
    cmn_bgcal_ovrd_15: coverpoint cmn_bgcal_ovrd_15.value[0:0];
    cmn_bgcal_ovrd_31_16: coverpoint cmn_bgcal_ovrd_31_16.value[15:0];
  endgroup
  covergroup rd_fld_covg;
    cmn_bgcal_ovrd_5_0: coverpoint cmn_bgcal_ovrd_5_0.value[5:0];
    cmn_bgcal_ovrd_13_6: coverpoint cmn_bgcal_ovrd_13_6.value[7:0];
    cmn_bgcal_ovrd_14: coverpoint cmn_bgcal_ovrd_14.value[0:0];
    cmn_bgcal_ovrd_15: coverpoint cmn_bgcal_ovrd_15.value[0:0];
    cmn_bgcal_ovrd_31_16: coverpoint cmn_bgcal_ovrd_31_16.value[15:0];
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
    
    cmn_bgcal_ovrd_5_0 = fld_set[0];
    cmn_bgcal_ovrd_13_6 = fld_set[1];
    cmn_bgcal_ovrd_14 = fld_set[2];
    cmn_bgcal_ovrd_15 = fld_set[3];
    cmn_bgcal_ovrd_31_16 = fld_set[4];
  endfunction

  function new(input string name="T_cmn_bgcal_ovrd_1034");
    super.new(name, 32, build_coverage(UVM_CVR_FIELD_VALS));
    if (has_coverage(UVM_CVR_FIELD_VALS)) begin
      wr_fld_covg = new();
      rd_fld_covg = new();
    end
  endfunction

endclass


/////////////////////////////////////////////////////
//                cmn_bgcal_start
/////////////////////////////////////////////////////
class T_cmn_bgcal_start_1035 extends cdns_uvm_reg;

  `uvm_object_utils(T_cmn_bgcal_start_1035)
  rand uvm_reg_field cmn_bgcal_start_5_0;
  rand uvm_reg_field cmn_bgcal_start_14_6;
  rand uvm_reg_field cmn_bgcal_start_15;
  rand uvm_reg_field cmn_bgcal_start_31_16;
  
  covergroup wr_fld_covg;
    cmn_bgcal_start_5_0: coverpoint cmn_bgcal_start_5_0.value[5:0];
    cmn_bgcal_start_14_6: coverpoint cmn_bgcal_start_14_6.value[8:0];
    cmn_bgcal_start_15: coverpoint cmn_bgcal_start_15.value[0:0];
    cmn_bgcal_start_31_16: coverpoint cmn_bgcal_start_31_16.value[15:0];
  endgroup
  covergroup rd_fld_covg;
    cmn_bgcal_start_5_0: coverpoint cmn_bgcal_start_5_0.value[5:0];
    cmn_bgcal_start_14_6: coverpoint cmn_bgcal_start_14_6.value[8:0];
    cmn_bgcal_start_15: coverpoint cmn_bgcal_start_15.value[0:0];
    cmn_bgcal_start_31_16: coverpoint cmn_bgcal_start_31_16.value[15:0];
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
    
    cmn_bgcal_start_5_0 = fld_set[0];
    cmn_bgcal_start_14_6 = fld_set[1];
    cmn_bgcal_start_15 = fld_set[2];
    cmn_bgcal_start_31_16 = fld_set[3];
  endfunction

  function new(input string name="T_cmn_bgcal_start_1035");
    super.new(name, 32, build_coverage(UVM_CVR_FIELD_VALS));
    if (has_coverage(UVM_CVR_FIELD_VALS)) begin
      wr_fld_covg = new();
      rd_fld_covg = new();
    end
  endfunction

endclass


/////////////////////////////////////////////////////
//                cmn_bgcal_tune
/////////////////////////////////////////////////////
class T_cmn_bgcal_tune_1036 extends cdns_uvm_reg;

  `uvm_object_utils(T_cmn_bgcal_tune_1036)
  rand uvm_reg_field cmn_bgcal_tune_5_0;
  rand uvm_reg_field cmn_bgcal_tune_15_6;
  rand uvm_reg_field cmn_bgcal_tune_31_16;
  
  covergroup wr_fld_covg;
    cmn_bgcal_tune_5_0: coverpoint cmn_bgcal_tune_5_0.value[5:0];
    cmn_bgcal_tune_15_6: coverpoint cmn_bgcal_tune_15_6.value[9:0];
    cmn_bgcal_tune_31_16: coverpoint cmn_bgcal_tune_31_16.value[15:0];
  endgroup
  covergroup rd_fld_covg;
    cmn_bgcal_tune_5_0: coverpoint cmn_bgcal_tune_5_0.value[5:0];
    cmn_bgcal_tune_15_6: coverpoint cmn_bgcal_tune_15_6.value[9:0];
    cmn_bgcal_tune_31_16: coverpoint cmn_bgcal_tune_31_16.value[15:0];
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
    
    cmn_bgcal_tune_5_0 = fld_set[0];
    cmn_bgcal_tune_15_6 = fld_set[1];
    cmn_bgcal_tune_31_16 = fld_set[2];
  endfunction

  function new(input string name="T_cmn_bgcal_tune_1036");
    super.new(name, 32, build_coverage(UVM_CVR_FIELD_VALS));
    if (has_coverage(UVM_CVR_FIELD_VALS)) begin
      wr_fld_covg = new();
      rd_fld_covg = new();
    end
  endfunction

endclass


/////////////////////////////////////////////////////
//                cmn_cdiag_ccal_pwri_ovrd
/////////////////////////////////////////////////////
class T_cmn_cdiag_ccal_pwri_ovrd_1023 extends cdns_uvm_reg;

  `uvm_object_utils(T_cmn_cdiag_ccal_pwri_ovrd_1023)
  rand uvm_reg_field cmn_cdiag_ccal_pwri_ovrd_7_0;
  rand uvm_reg_field cmn_cdiag_ccal_pwri_ovrd_8;
  rand uvm_reg_field cmn_cdiag_ccal_pwri_ovrd_9;
  rand uvm_reg_field cmn_cdiag_ccal_pwri_ovrd_10;
  rand uvm_reg_field cmn_cdiag_ccal_pwri_ovrd_11;
  rand uvm_reg_field cmn_cdiag_ccal_pwri_ovrd_13_12;
  rand uvm_reg_field cmn_cdiag_ccal_pwri_ovrd_14;
  rand uvm_reg_field cmn_cdiag_ccal_pwri_ovrd_15;
  rand uvm_reg_field cmn_cdiag_ccal_pwri_ovrd_23_16;
  rand uvm_reg_field cmn_cdiag_ccal_pwri_ovrd_31_24;
  
  covergroup wr_fld_covg;
    cmn_cdiag_ccal_pwri_ovrd_7_0: coverpoint cmn_cdiag_ccal_pwri_ovrd_7_0.value[7:0];
    cmn_cdiag_ccal_pwri_ovrd_8: coverpoint cmn_cdiag_ccal_pwri_ovrd_8.value[0:0];
    cmn_cdiag_ccal_pwri_ovrd_9: coverpoint cmn_cdiag_ccal_pwri_ovrd_9.value[0:0];
    cmn_cdiag_ccal_pwri_ovrd_10: coverpoint cmn_cdiag_ccal_pwri_ovrd_10.value[0:0];
    cmn_cdiag_ccal_pwri_ovrd_11: coverpoint cmn_cdiag_ccal_pwri_ovrd_11.value[0:0];
    cmn_cdiag_ccal_pwri_ovrd_13_12: coverpoint cmn_cdiag_ccal_pwri_ovrd_13_12.value[1:0];
    cmn_cdiag_ccal_pwri_ovrd_14: coverpoint cmn_cdiag_ccal_pwri_ovrd_14.value[0:0];
    cmn_cdiag_ccal_pwri_ovrd_15: coverpoint cmn_cdiag_ccal_pwri_ovrd_15.value[0:0];
    cmn_cdiag_ccal_pwri_ovrd_23_16: coverpoint cmn_cdiag_ccal_pwri_ovrd_23_16.value[7:0];
    cmn_cdiag_ccal_pwri_ovrd_31_24: coverpoint cmn_cdiag_ccal_pwri_ovrd_31_24.value[7:0];
  endgroup
  covergroup rd_fld_covg;
    cmn_cdiag_ccal_pwri_ovrd_7_0: coverpoint cmn_cdiag_ccal_pwri_ovrd_7_0.value[7:0];
    cmn_cdiag_ccal_pwri_ovrd_8: coverpoint cmn_cdiag_ccal_pwri_ovrd_8.value[0:0];
    cmn_cdiag_ccal_pwri_ovrd_9: coverpoint cmn_cdiag_ccal_pwri_ovrd_9.value[0:0];
    cmn_cdiag_ccal_pwri_ovrd_10: coverpoint cmn_cdiag_ccal_pwri_ovrd_10.value[0:0];
    cmn_cdiag_ccal_pwri_ovrd_11: coverpoint cmn_cdiag_ccal_pwri_ovrd_11.value[0:0];
    cmn_cdiag_ccal_pwri_ovrd_13_12: coverpoint cmn_cdiag_ccal_pwri_ovrd_13_12.value[1:0];
    cmn_cdiag_ccal_pwri_ovrd_14: coverpoint cmn_cdiag_ccal_pwri_ovrd_14.value[0:0];
    cmn_cdiag_ccal_pwri_ovrd_15: coverpoint cmn_cdiag_ccal_pwri_ovrd_15.value[0:0];
    cmn_cdiag_ccal_pwri_ovrd_23_16: coverpoint cmn_cdiag_ccal_pwri_ovrd_23_16.value[7:0];
    cmn_cdiag_ccal_pwri_ovrd_31_24: coverpoint cmn_cdiag_ccal_pwri_ovrd_31_24.value[7:0];
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
    
    cmn_cdiag_ccal_pwri_ovrd_7_0 = fld_set[0];
    cmn_cdiag_ccal_pwri_ovrd_8 = fld_set[1];
    cmn_cdiag_ccal_pwri_ovrd_9 = fld_set[2];
    cmn_cdiag_ccal_pwri_ovrd_10 = fld_set[3];
    cmn_cdiag_ccal_pwri_ovrd_11 = fld_set[4];
    cmn_cdiag_ccal_pwri_ovrd_13_12 = fld_set[5];
    cmn_cdiag_ccal_pwri_ovrd_14 = fld_set[6];
    cmn_cdiag_ccal_pwri_ovrd_15 = fld_set[7];
    cmn_cdiag_ccal_pwri_ovrd_23_16 = fld_set[8];
    cmn_cdiag_ccal_pwri_ovrd_31_24 = fld_set[9];
  endfunction

  function new(input string name="T_cmn_cdiag_ccal_pwri_ovrd_1023");
    super.new(name, 32, build_coverage(UVM_CVR_FIELD_VALS));
    if (has_coverage(UVM_CVR_FIELD_VALS)) begin
      wr_fld_covg = new();
      rd_fld_covg = new();
    end
  endfunction

endclass


/////////////////////////////////////////////////////
//                cmn_cdiag_dcya
/////////////////////////////////////////////////////
class T_cmn_cdiag_dcya_1032 extends cdns_uvm_reg;

  `uvm_object_utils(T_cmn_cdiag_dcya_1032)
  rand uvm_reg_field cmn_cdiag_dcya_7_0;
  rand uvm_reg_field cmn_cdiag_dcya_15_8;
  rand uvm_reg_field cmn_cdiag_dcya_31_16;
  
  covergroup wr_fld_covg;
    cmn_cdiag_dcya_7_0: coverpoint cmn_cdiag_dcya_7_0.value[7:0];
    cmn_cdiag_dcya_15_8: coverpoint cmn_cdiag_dcya_15_8.value[7:0];
    cmn_cdiag_dcya_31_16: coverpoint cmn_cdiag_dcya_31_16.value[15:0];
  endgroup
  covergroup rd_fld_covg;
    cmn_cdiag_dcya_7_0: coverpoint cmn_cdiag_dcya_7_0.value[7:0];
    cmn_cdiag_dcya_15_8: coverpoint cmn_cdiag_dcya_15_8.value[7:0];
    cmn_cdiag_dcya_31_16: coverpoint cmn_cdiag_dcya_31_16.value[15:0];
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
    
    cmn_cdiag_dcya_7_0 = fld_set[0];
    cmn_cdiag_dcya_15_8 = fld_set[1];
    cmn_cdiag_dcya_31_16 = fld_set[2];
  endfunction

  function new(input string name="T_cmn_cdiag_dcya_1032");
    super.new(name, 32, build_coverage(UVM_CVR_FIELD_VALS));
    if (has_coverage(UVM_CVR_FIELD_VALS)) begin
      wr_fld_covg = new();
      rd_fld_covg = new();
    end
  endfunction

endclass


/////////////////////////////////////////////////////
//                cmn_cdiag_diag_pwri_ovrd
/////////////////////////////////////////////////////
class T_cmn_cdiag_diag_pwri_ovrd_1025 extends cdns_uvm_reg;

  `uvm_object_utils(T_cmn_cdiag_diag_pwri_ovrd_1025)
  rand uvm_reg_field cmn_cdiag_diag_pwri_ovrd_7_0;
  rand uvm_reg_field cmn_cdiag_diag_pwri_ovrd_8;
  rand uvm_reg_field cmn_cdiag_diag_pwri_ovrd_9;
  rand uvm_reg_field cmn_cdiag_diag_pwri_ovrd_10;
  rand uvm_reg_field cmn_cdiag_diag_pwri_ovrd_11;
  rand uvm_reg_field cmn_cdiag_diag_pwri_ovrd_13_12;
  rand uvm_reg_field cmn_cdiag_diag_pwri_ovrd_14;
  rand uvm_reg_field cmn_cdiag_diag_pwri_ovrd_15;
  rand uvm_reg_field cmn_cdiag_diag_pwri_ovrd_23_16;
  rand uvm_reg_field cmn_cdiag_diag_pwri_ovrd_31_24;
  
  covergroup wr_fld_covg;
    cmn_cdiag_diag_pwri_ovrd_7_0: coverpoint cmn_cdiag_diag_pwri_ovrd_7_0.value[7:0];
    cmn_cdiag_diag_pwri_ovrd_8: coverpoint cmn_cdiag_diag_pwri_ovrd_8.value[0:0];
    cmn_cdiag_diag_pwri_ovrd_9: coverpoint cmn_cdiag_diag_pwri_ovrd_9.value[0:0];
    cmn_cdiag_diag_pwri_ovrd_10: coverpoint cmn_cdiag_diag_pwri_ovrd_10.value[0:0];
    cmn_cdiag_diag_pwri_ovrd_11: coverpoint cmn_cdiag_diag_pwri_ovrd_11.value[0:0];
    cmn_cdiag_diag_pwri_ovrd_13_12: coverpoint cmn_cdiag_diag_pwri_ovrd_13_12.value[1:0];
    cmn_cdiag_diag_pwri_ovrd_14: coverpoint cmn_cdiag_diag_pwri_ovrd_14.value[0:0];
    cmn_cdiag_diag_pwri_ovrd_15: coverpoint cmn_cdiag_diag_pwri_ovrd_15.value[0:0];
    cmn_cdiag_diag_pwri_ovrd_23_16: coverpoint cmn_cdiag_diag_pwri_ovrd_23_16.value[7:0];
    cmn_cdiag_diag_pwri_ovrd_31_24: coverpoint cmn_cdiag_diag_pwri_ovrd_31_24.value[7:0];
  endgroup
  covergroup rd_fld_covg;
    cmn_cdiag_diag_pwri_ovrd_7_0: coverpoint cmn_cdiag_diag_pwri_ovrd_7_0.value[7:0];
    cmn_cdiag_diag_pwri_ovrd_8: coverpoint cmn_cdiag_diag_pwri_ovrd_8.value[0:0];
    cmn_cdiag_diag_pwri_ovrd_9: coverpoint cmn_cdiag_diag_pwri_ovrd_9.value[0:0];
    cmn_cdiag_diag_pwri_ovrd_10: coverpoint cmn_cdiag_diag_pwri_ovrd_10.value[0:0];
    cmn_cdiag_diag_pwri_ovrd_11: coverpoint cmn_cdiag_diag_pwri_ovrd_11.value[0:0];
    cmn_cdiag_diag_pwri_ovrd_13_12: coverpoint cmn_cdiag_diag_pwri_ovrd_13_12.value[1:0];
    cmn_cdiag_diag_pwri_ovrd_14: coverpoint cmn_cdiag_diag_pwri_ovrd_14.value[0:0];
    cmn_cdiag_diag_pwri_ovrd_15: coverpoint cmn_cdiag_diag_pwri_ovrd_15.value[0:0];
    cmn_cdiag_diag_pwri_ovrd_23_16: coverpoint cmn_cdiag_diag_pwri_ovrd_23_16.value[7:0];
    cmn_cdiag_diag_pwri_ovrd_31_24: coverpoint cmn_cdiag_diag_pwri_ovrd_31_24.value[7:0];
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
    
    cmn_cdiag_diag_pwri_ovrd_7_0 = fld_set[0];
    cmn_cdiag_diag_pwri_ovrd_8 = fld_set[1];
    cmn_cdiag_diag_pwri_ovrd_9 = fld_set[2];
    cmn_cdiag_diag_pwri_ovrd_10 = fld_set[3];
    cmn_cdiag_diag_pwri_ovrd_11 = fld_set[4];
    cmn_cdiag_diag_pwri_ovrd_13_12 = fld_set[5];
    cmn_cdiag_diag_pwri_ovrd_14 = fld_set[6];
    cmn_cdiag_diag_pwri_ovrd_15 = fld_set[7];
    cmn_cdiag_diag_pwri_ovrd_23_16 = fld_set[8];
    cmn_cdiag_diag_pwri_ovrd_31_24 = fld_set[9];
  endfunction

  function new(input string name="T_cmn_cdiag_diag_pwri_ovrd_1025");
    super.new(name, 32, build_coverage(UVM_CVR_FIELD_VALS));
    if (has_coverage(UVM_CVR_FIELD_VALS)) begin
      wr_fld_covg = new();
      rd_fld_covg = new();
    end
  endfunction

endclass


/////////////////////////////////////////////////////
//                cmn_cdiag_pllc_pwri_ovrd
/////////////////////////////////////////////////////
class T_cmn_cdiag_pllc_pwri_ovrd_1022 extends cdns_uvm_reg;

  `uvm_object_utils(T_cmn_cdiag_pllc_pwri_ovrd_1022)
  rand uvm_reg_field cmn_cdiag_pllc_pwri_ovrd_7_0;
  rand uvm_reg_field cmn_cdiag_pllc_pwri_ovrd_8;
  rand uvm_reg_field cmn_cdiag_pllc_pwri_ovrd_9;
  rand uvm_reg_field cmn_cdiag_pllc_pwri_ovrd_10;
  rand uvm_reg_field cmn_cdiag_pllc_pwri_ovrd_11;
  rand uvm_reg_field cmn_cdiag_pllc_pwri_ovrd_13_12;
  rand uvm_reg_field cmn_cdiag_pllc_pwri_ovrd_14;
  rand uvm_reg_field cmn_cdiag_pllc_pwri_ovrd_15;
  rand uvm_reg_field cmn_cdiag_pllc_pwri_ovrd_23_16;
  rand uvm_reg_field cmn_cdiag_pllc_pwri_ovrd_31_24;
  
  covergroup wr_fld_covg;
    cmn_cdiag_pllc_pwri_ovrd_7_0: coverpoint cmn_cdiag_pllc_pwri_ovrd_7_0.value[7:0];
    cmn_cdiag_pllc_pwri_ovrd_8: coverpoint cmn_cdiag_pllc_pwri_ovrd_8.value[0:0];
    cmn_cdiag_pllc_pwri_ovrd_9: coverpoint cmn_cdiag_pllc_pwri_ovrd_9.value[0:0];
    cmn_cdiag_pllc_pwri_ovrd_10: coverpoint cmn_cdiag_pllc_pwri_ovrd_10.value[0:0];
    cmn_cdiag_pllc_pwri_ovrd_11: coverpoint cmn_cdiag_pllc_pwri_ovrd_11.value[0:0];
    cmn_cdiag_pllc_pwri_ovrd_13_12: coverpoint cmn_cdiag_pllc_pwri_ovrd_13_12.value[1:0];
    cmn_cdiag_pllc_pwri_ovrd_14: coverpoint cmn_cdiag_pllc_pwri_ovrd_14.value[0:0];
    cmn_cdiag_pllc_pwri_ovrd_15: coverpoint cmn_cdiag_pllc_pwri_ovrd_15.value[0:0];
    cmn_cdiag_pllc_pwri_ovrd_23_16: coverpoint cmn_cdiag_pllc_pwri_ovrd_23_16.value[7:0];
    cmn_cdiag_pllc_pwri_ovrd_31_24: coverpoint cmn_cdiag_pllc_pwri_ovrd_31_24.value[7:0];
  endgroup
  covergroup rd_fld_covg;
    cmn_cdiag_pllc_pwri_ovrd_7_0: coverpoint cmn_cdiag_pllc_pwri_ovrd_7_0.value[7:0];
    cmn_cdiag_pllc_pwri_ovrd_8: coverpoint cmn_cdiag_pllc_pwri_ovrd_8.value[0:0];
    cmn_cdiag_pllc_pwri_ovrd_9: coverpoint cmn_cdiag_pllc_pwri_ovrd_9.value[0:0];
    cmn_cdiag_pllc_pwri_ovrd_10: coverpoint cmn_cdiag_pllc_pwri_ovrd_10.value[0:0];
    cmn_cdiag_pllc_pwri_ovrd_11: coverpoint cmn_cdiag_pllc_pwri_ovrd_11.value[0:0];
    cmn_cdiag_pllc_pwri_ovrd_13_12: coverpoint cmn_cdiag_pllc_pwri_ovrd_13_12.value[1:0];
    cmn_cdiag_pllc_pwri_ovrd_14: coverpoint cmn_cdiag_pllc_pwri_ovrd_14.value[0:0];
    cmn_cdiag_pllc_pwri_ovrd_15: coverpoint cmn_cdiag_pllc_pwri_ovrd_15.value[0:0];
    cmn_cdiag_pllc_pwri_ovrd_23_16: coverpoint cmn_cdiag_pllc_pwri_ovrd_23_16.value[7:0];
    cmn_cdiag_pllc_pwri_ovrd_31_24: coverpoint cmn_cdiag_pllc_pwri_ovrd_31_24.value[7:0];
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
    
    cmn_cdiag_pllc_pwri_ovrd_7_0 = fld_set[0];
    cmn_cdiag_pllc_pwri_ovrd_8 = fld_set[1];
    cmn_cdiag_pllc_pwri_ovrd_9 = fld_set[2];
    cmn_cdiag_pllc_pwri_ovrd_10 = fld_set[3];
    cmn_cdiag_pllc_pwri_ovrd_11 = fld_set[4];
    cmn_cdiag_pllc_pwri_ovrd_13_12 = fld_set[5];
    cmn_cdiag_pllc_pwri_ovrd_14 = fld_set[6];
    cmn_cdiag_pllc_pwri_ovrd_15 = fld_set[7];
    cmn_cdiag_pllc_pwri_ovrd_23_16 = fld_set[8];
    cmn_cdiag_pllc_pwri_ovrd_31_24 = fld_set[9];
  endfunction

  function new(input string name="T_cmn_cdiag_pllc_pwri_ovrd_1022");
    super.new(name, 32, build_coverage(UVM_CVR_FIELD_VALS));
    if (has_coverage(UVM_CVR_FIELD_VALS)) begin
      wr_fld_covg = new();
      rd_fld_covg = new();
    end
  endfunction

endclass


/////////////////////////////////////////////////////
//                cmn_cdiag_pllsm_calmc_cs
/////////////////////////////////////////////////////
class T_cmn_cdiag_pllsm_calmc_cs_1030 extends cdns_uvm_reg;

  `uvm_object_utils(T_cmn_cdiag_pllsm_calmc_cs_1030)
  rand uvm_reg_field cmn_cdiag_pllsm_calmc_cs_6_0;
  rand uvm_reg_field cmn_cdiag_pllsm_calmc_cs_31_7;
  
  covergroup wr_fld_covg;
    cmn_cdiag_pllsm_calmc_cs_6_0: coverpoint cmn_cdiag_pllsm_calmc_cs_6_0.value[6:0];
    cmn_cdiag_pllsm_calmc_cs_31_7: coverpoint cmn_cdiag_pllsm_calmc_cs_31_7.value[24:0];
  endgroup
  covergroup rd_fld_covg;
    cmn_cdiag_pllsm_calmc_cs_6_0: coverpoint cmn_cdiag_pllsm_calmc_cs_6_0.value[6:0];
    cmn_cdiag_pllsm_calmc_cs_31_7: coverpoint cmn_cdiag_pllsm_calmc_cs_31_7.value[24:0];
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
    
    cmn_cdiag_pllsm_calmc_cs_6_0 = fld_set[0];
    cmn_cdiag_pllsm_calmc_cs_31_7 = fld_set[1];
  endfunction

  function new(input string name="T_cmn_cdiag_pllsm_calmc_cs_1030");
    super.new(name, 32, build_coverage(UVM_CVR_FIELD_VALS));
    if (has_coverage(UVM_CVR_FIELD_VALS)) begin
      wr_fld_covg = new();
      rd_fld_covg = new();
    end
  endfunction

endclass


/////////////////////////////////////////////////////
//                cmn_cdiag_psmclk_ctrl
/////////////////////////////////////////////////////
class T_cmn_cdiag_psmclk_ctrl_1027 extends cdns_uvm_reg;

  `uvm_object_utils(T_cmn_cdiag_psmclk_ctrl_1027)
  rand uvm_reg_field cmn_cdiag_psmclk_ctrl_3_0;
  rand uvm_reg_field cmn_cdiag_psmclk_ctrl_15_4;
  rand uvm_reg_field cmn_cdiag_psmclk_ctrl_31_16;
  
  covergroup wr_fld_covg;
    cmn_cdiag_psmclk_ctrl_3_0: coverpoint cmn_cdiag_psmclk_ctrl_3_0.value[3:0];
    cmn_cdiag_psmclk_ctrl_15_4: coverpoint cmn_cdiag_psmclk_ctrl_15_4.value[11:0];
    cmn_cdiag_psmclk_ctrl_31_16: coverpoint cmn_cdiag_psmclk_ctrl_31_16.value[15:0];
  endgroup
  covergroup rd_fld_covg;
    cmn_cdiag_psmclk_ctrl_3_0: coverpoint cmn_cdiag_psmclk_ctrl_3_0.value[3:0];
    cmn_cdiag_psmclk_ctrl_15_4: coverpoint cmn_cdiag_psmclk_ctrl_15_4.value[11:0];
    cmn_cdiag_psmclk_ctrl_31_16: coverpoint cmn_cdiag_psmclk_ctrl_31_16.value[15:0];
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
    
    cmn_cdiag_psmclk_ctrl_3_0 = fld_set[0];
    cmn_cdiag_psmclk_ctrl_15_4 = fld_set[1];
    cmn_cdiag_psmclk_ctrl_31_16 = fld_set[2];
  endfunction

  function new(input string name="T_cmn_cdiag_psmclk_ctrl_1027");
    super.new(name, 32, build_coverage(UVM_CVR_FIELD_VALS));
    if (has_coverage(UVM_CVR_FIELD_VALS)) begin
      wr_fld_covg = new();
      rd_fld_covg = new();
    end
  endfunction

endclass


/////////////////////////////////////////////////////
//                cmn_cdiag_pwri_tmr
/////////////////////////////////////////////////////
class T_cmn_cdiag_pwri_tmr_1021 extends cdns_uvm_reg;

  `uvm_object_utils(T_cmn_cdiag_pwri_tmr_1021)
  rand uvm_reg_field cmn_cdiag_pwri_tmr_2_0;
  rand uvm_reg_field cmn_cdiag_pwri_tmr_7_3;
  rand uvm_reg_field cmn_cdiag_pwri_tmr_10_8;
  rand uvm_reg_field cmn_cdiag_pwri_tmr_15_11;
  rand uvm_reg_field cmn_cdiag_pwri_tmr_31_16;
  
  covergroup wr_fld_covg;
    cmn_cdiag_pwri_tmr_2_0: coverpoint cmn_cdiag_pwri_tmr_2_0.value[2:0];
    cmn_cdiag_pwri_tmr_7_3: coverpoint cmn_cdiag_pwri_tmr_7_3.value[4:0];
    cmn_cdiag_pwri_tmr_10_8: coverpoint cmn_cdiag_pwri_tmr_10_8.value[2:0];
    cmn_cdiag_pwri_tmr_15_11: coverpoint cmn_cdiag_pwri_tmr_15_11.value[4:0];
    cmn_cdiag_pwri_tmr_31_16: coverpoint cmn_cdiag_pwri_tmr_31_16.value[15:0];
  endgroup
  covergroup rd_fld_covg;
    cmn_cdiag_pwri_tmr_2_0: coverpoint cmn_cdiag_pwri_tmr_2_0.value[2:0];
    cmn_cdiag_pwri_tmr_7_3: coverpoint cmn_cdiag_pwri_tmr_7_3.value[4:0];
    cmn_cdiag_pwri_tmr_10_8: coverpoint cmn_cdiag_pwri_tmr_10_8.value[2:0];
    cmn_cdiag_pwri_tmr_15_11: coverpoint cmn_cdiag_pwri_tmr_15_11.value[4:0];
    cmn_cdiag_pwri_tmr_31_16: coverpoint cmn_cdiag_pwri_tmr_31_16.value[15:0];
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
    
    cmn_cdiag_pwri_tmr_2_0 = fld_set[0];
    cmn_cdiag_pwri_tmr_7_3 = fld_set[1];
    cmn_cdiag_pwri_tmr_10_8 = fld_set[2];
    cmn_cdiag_pwri_tmr_15_11 = fld_set[3];
    cmn_cdiag_pwri_tmr_31_16 = fld_set[4];
  endfunction

  function new(input string name="T_cmn_cdiag_pwri_tmr_1021");
    super.new(name, 32, build_coverage(UVM_CVR_FIELD_VALS));
    if (has_coverage(UVM_CVR_FIELD_VALS)) begin
      wr_fld_covg = new();
      rd_fld_covg = new();
    end
  endfunction

endclass


/////////////////////////////////////////////////////
//                cmn_cdiag_refclk_ctrl
/////////////////////////////////////////////////////
class T_cmn_cdiag_refclk_ctrl_1026 extends cdns_uvm_reg;

  `uvm_object_utils(T_cmn_cdiag_refclk_ctrl_1026)
  rand uvm_reg_field cmn_cdiag_refclk_ctrl_0;
  rand uvm_reg_field cmn_cdiag_refclk_ctrl_31_1;
  
  covergroup wr_fld_covg;
    cmn_cdiag_refclk_ctrl_0: coverpoint cmn_cdiag_refclk_ctrl_0.value[0:0];
    cmn_cdiag_refclk_ctrl_31_1: coverpoint cmn_cdiag_refclk_ctrl_31_1.value[30:0];
  endgroup
  covergroup rd_fld_covg;
    cmn_cdiag_refclk_ctrl_0: coverpoint cmn_cdiag_refclk_ctrl_0.value[0:0];
    cmn_cdiag_refclk_ctrl_31_1: coverpoint cmn_cdiag_refclk_ctrl_31_1.value[30:0];
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
    
    cmn_cdiag_refclk_ctrl_0 = fld_set[0];
    cmn_cdiag_refclk_ctrl_31_1 = fld_set[1];
  endfunction

  function new(input string name="T_cmn_cdiag_refclk_ctrl_1026");
    super.new(name, 32, build_coverage(UVM_CVR_FIELD_VALS));
    if (has_coverage(UVM_CVR_FIELD_VALS)) begin
      wr_fld_covg = new();
      rd_fld_covg = new();
    end
  endfunction

endclass


/////////////////////////////////////////////////////
//                cmn_cdiag_rst_diag
/////////////////////////////////////////////////////
class T_cmn_cdiag_rst_diag_1031 extends cdns_uvm_reg;

  `uvm_object_utils(T_cmn_cdiag_rst_diag_1031)
  rand uvm_reg_field cmn_cdiag_rst_diag_0;
  rand uvm_reg_field cmn_cdiag_rst_diag_1;
  rand uvm_reg_field cmn_cdiag_rst_diag_15_2;
  rand uvm_reg_field cmn_cdiag_rst_diag_31_16;
  
  covergroup wr_fld_covg;
    cmn_cdiag_rst_diag_0: coverpoint cmn_cdiag_rst_diag_0.value[0:0];
    cmn_cdiag_rst_diag_1: coverpoint cmn_cdiag_rst_diag_1.value[0:0];
    cmn_cdiag_rst_diag_15_2: coverpoint cmn_cdiag_rst_diag_15_2.value[13:0];
    cmn_cdiag_rst_diag_31_16: coverpoint cmn_cdiag_rst_diag_31_16.value[15:0];
  endgroup
  covergroup rd_fld_covg;
    cmn_cdiag_rst_diag_0: coverpoint cmn_cdiag_rst_diag_0.value[0:0];
    cmn_cdiag_rst_diag_1: coverpoint cmn_cdiag_rst_diag_1.value[0:0];
    cmn_cdiag_rst_diag_15_2: coverpoint cmn_cdiag_rst_diag_15_2.value[13:0];
    cmn_cdiag_rst_diag_31_16: coverpoint cmn_cdiag_rst_diag_31_16.value[15:0];
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
    
    cmn_cdiag_rst_diag_0 = fld_set[0];
    cmn_cdiag_rst_diag_1 = fld_set[1];
    cmn_cdiag_rst_diag_15_2 = fld_set[2];
    cmn_cdiag_rst_diag_31_16 = fld_set[3];
  endfunction

  function new(input string name="T_cmn_cdiag_rst_diag_1031");
    super.new(name, 32, build_coverage(UVM_CVR_FIELD_VALS));
    if (has_coverage(UVM_CVR_FIELD_VALS)) begin
      wr_fld_covg = new();
      rd_fld_covg = new();
    end
  endfunction

endclass


/////////////////////////////////////////////////////
//                cmn_cdiag_sdosc_ctrl
/////////////////////////////////////////////////////
class T_cmn_cdiag_sdosc_ctrl_1028 extends cdns_uvm_reg;

  `uvm_object_utils(T_cmn_cdiag_sdosc_ctrl_1028)
  rand uvm_reg_field cmn_cdiag_sdosc_ctrl_0;
  rand uvm_reg_field cmn_cdiag_sdosc_ctrl_1;
  rand uvm_reg_field cmn_cdiag_sdosc_ctrl_15_2;
  rand uvm_reg_field cmn_cdiag_sdosc_ctrl_31_16;
  
  covergroup wr_fld_covg;
    cmn_cdiag_sdosc_ctrl_0: coverpoint cmn_cdiag_sdosc_ctrl_0.value[0:0];
    cmn_cdiag_sdosc_ctrl_1: coverpoint cmn_cdiag_sdosc_ctrl_1.value[0:0];
    cmn_cdiag_sdosc_ctrl_15_2: coverpoint cmn_cdiag_sdosc_ctrl_15_2.value[13:0];
    cmn_cdiag_sdosc_ctrl_31_16: coverpoint cmn_cdiag_sdosc_ctrl_31_16.value[15:0];
  endgroup
  covergroup rd_fld_covg;
    cmn_cdiag_sdosc_ctrl_0: coverpoint cmn_cdiag_sdosc_ctrl_0.value[0:0];
    cmn_cdiag_sdosc_ctrl_1: coverpoint cmn_cdiag_sdosc_ctrl_1.value[0:0];
    cmn_cdiag_sdosc_ctrl_15_2: coverpoint cmn_cdiag_sdosc_ctrl_15_2.value[13:0];
    cmn_cdiag_sdosc_ctrl_31_16: coverpoint cmn_cdiag_sdosc_ctrl_31_16.value[15:0];
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
    
    cmn_cdiag_sdosc_ctrl_0 = fld_set[0];
    cmn_cdiag_sdosc_ctrl_1 = fld_set[1];
    cmn_cdiag_sdosc_ctrl_15_2 = fld_set[2];
    cmn_cdiag_sdosc_ctrl_31_16 = fld_set[3];
  endfunction

  function new(input string name="T_cmn_cdiag_sdosc_ctrl_1028");
    super.new(name, 32, build_coverage(UVM_CVR_FIELD_VALS));
    if (has_coverage(UVM_CVR_FIELD_VALS)) begin
      wr_fld_covg = new();
      rd_fld_covg = new();
    end
  endfunction

endclass


/////////////////////////////////////////////////////
//                cmn_cdiag_ssm_calmc_cs
/////////////////////////////////////////////////////
class T_cmn_cdiag_ssm_calmc_cs_1029 extends cdns_uvm_reg;

  `uvm_object_utils(T_cmn_cdiag_ssm_calmc_cs_1029)
  rand uvm_reg_field cmn_cdiag_ssm_calmc_cs_3_0;
  rand uvm_reg_field cmn_cdiag_ssm_calmc_cs_15_4;
  rand uvm_reg_field cmn_cdiag_ssm_calmc_cs_28_16;
  rand uvm_reg_field cmn_cdiag_ssm_calmc_cs_31_29;
  
  covergroup wr_fld_covg;
    cmn_cdiag_ssm_calmc_cs_3_0: coverpoint cmn_cdiag_ssm_calmc_cs_3_0.value[3:0];
    cmn_cdiag_ssm_calmc_cs_15_4: coverpoint cmn_cdiag_ssm_calmc_cs_15_4.value[11:0];
    cmn_cdiag_ssm_calmc_cs_28_16: coverpoint cmn_cdiag_ssm_calmc_cs_28_16.value[12:0];
    cmn_cdiag_ssm_calmc_cs_31_29: coverpoint cmn_cdiag_ssm_calmc_cs_31_29.value[2:0];
  endgroup
  covergroup rd_fld_covg;
    cmn_cdiag_ssm_calmc_cs_3_0: coverpoint cmn_cdiag_ssm_calmc_cs_3_0.value[3:0];
    cmn_cdiag_ssm_calmc_cs_15_4: coverpoint cmn_cdiag_ssm_calmc_cs_15_4.value[11:0];
    cmn_cdiag_ssm_calmc_cs_28_16: coverpoint cmn_cdiag_ssm_calmc_cs_28_16.value[12:0];
    cmn_cdiag_ssm_calmc_cs_31_29: coverpoint cmn_cdiag_ssm_calmc_cs_31_29.value[2:0];
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
    
    cmn_cdiag_ssm_calmc_cs_3_0 = fld_set[0];
    cmn_cdiag_ssm_calmc_cs_15_4 = fld_set[1];
    cmn_cdiag_ssm_calmc_cs_28_16 = fld_set[2];
    cmn_cdiag_ssm_calmc_cs_31_29 = fld_set[3];
  endfunction

  function new(input string name="T_cmn_cdiag_ssm_calmc_cs_1029");
    super.new(name, 32, build_coverage(UVM_CVR_FIELD_VALS));
    if (has_coverage(UVM_CVR_FIELD_VALS)) begin
      wr_fld_covg = new();
      rd_fld_covg = new();
    end
  endfunction

endclass


/////////////////////////////////////////////////////
//                cmn_cdiag_xcvrc_pwri_ovrd
/////////////////////////////////////////////////////
class T_cmn_cdiag_xcvrc_pwri_ovrd_1024 extends cdns_uvm_reg;

  `uvm_object_utils(T_cmn_cdiag_xcvrc_pwri_ovrd_1024)
  rand uvm_reg_field cmn_cdiag_xcvrc_pwri_ovrd_7_0;
  rand uvm_reg_field cmn_cdiag_xcvrc_pwri_ovrd_8;
  rand uvm_reg_field cmn_cdiag_xcvrc_pwri_ovrd_9;
  rand uvm_reg_field cmn_cdiag_xcvrc_pwri_ovrd_10;
  rand uvm_reg_field cmn_cdiag_xcvrc_pwri_ovrd_11;
  rand uvm_reg_field cmn_cdiag_xcvrc_pwri_ovrd_13_12;
  rand uvm_reg_field cmn_cdiag_xcvrc_pwri_ovrd_14;
  rand uvm_reg_field cmn_cdiag_xcvrc_pwri_ovrd_15;
  rand uvm_reg_field cmn_cdiag_xcvrc_pwri_ovrd_23_16;
  rand uvm_reg_field cmn_cdiag_xcvrc_pwri_ovrd_31_24;
  
  covergroup wr_fld_covg;
    cmn_cdiag_xcvrc_pwri_ovrd_7_0: coverpoint cmn_cdiag_xcvrc_pwri_ovrd_7_0.value[7:0];
    cmn_cdiag_xcvrc_pwri_ovrd_8: coverpoint cmn_cdiag_xcvrc_pwri_ovrd_8.value[0:0];
    cmn_cdiag_xcvrc_pwri_ovrd_9: coverpoint cmn_cdiag_xcvrc_pwri_ovrd_9.value[0:0];
    cmn_cdiag_xcvrc_pwri_ovrd_10: coverpoint cmn_cdiag_xcvrc_pwri_ovrd_10.value[0:0];
    cmn_cdiag_xcvrc_pwri_ovrd_11: coverpoint cmn_cdiag_xcvrc_pwri_ovrd_11.value[0:0];
    cmn_cdiag_xcvrc_pwri_ovrd_13_12: coverpoint cmn_cdiag_xcvrc_pwri_ovrd_13_12.value[1:0];
    cmn_cdiag_xcvrc_pwri_ovrd_14: coverpoint cmn_cdiag_xcvrc_pwri_ovrd_14.value[0:0];
    cmn_cdiag_xcvrc_pwri_ovrd_15: coverpoint cmn_cdiag_xcvrc_pwri_ovrd_15.value[0:0];
    cmn_cdiag_xcvrc_pwri_ovrd_23_16: coverpoint cmn_cdiag_xcvrc_pwri_ovrd_23_16.value[7:0];
    cmn_cdiag_xcvrc_pwri_ovrd_31_24: coverpoint cmn_cdiag_xcvrc_pwri_ovrd_31_24.value[7:0];
  endgroup
  covergroup rd_fld_covg;
    cmn_cdiag_xcvrc_pwri_ovrd_7_0: coverpoint cmn_cdiag_xcvrc_pwri_ovrd_7_0.value[7:0];
    cmn_cdiag_xcvrc_pwri_ovrd_8: coverpoint cmn_cdiag_xcvrc_pwri_ovrd_8.value[0:0];
    cmn_cdiag_xcvrc_pwri_ovrd_9: coverpoint cmn_cdiag_xcvrc_pwri_ovrd_9.value[0:0];
    cmn_cdiag_xcvrc_pwri_ovrd_10: coverpoint cmn_cdiag_xcvrc_pwri_ovrd_10.value[0:0];
    cmn_cdiag_xcvrc_pwri_ovrd_11: coverpoint cmn_cdiag_xcvrc_pwri_ovrd_11.value[0:0];
    cmn_cdiag_xcvrc_pwri_ovrd_13_12: coverpoint cmn_cdiag_xcvrc_pwri_ovrd_13_12.value[1:0];
    cmn_cdiag_xcvrc_pwri_ovrd_14: coverpoint cmn_cdiag_xcvrc_pwri_ovrd_14.value[0:0];
    cmn_cdiag_xcvrc_pwri_ovrd_15: coverpoint cmn_cdiag_xcvrc_pwri_ovrd_15.value[0:0];
    cmn_cdiag_xcvrc_pwri_ovrd_23_16: coverpoint cmn_cdiag_xcvrc_pwri_ovrd_23_16.value[7:0];
    cmn_cdiag_xcvrc_pwri_ovrd_31_24: coverpoint cmn_cdiag_xcvrc_pwri_ovrd_31_24.value[7:0];
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
    
    cmn_cdiag_xcvrc_pwri_ovrd_7_0 = fld_set[0];
    cmn_cdiag_xcvrc_pwri_ovrd_8 = fld_set[1];
    cmn_cdiag_xcvrc_pwri_ovrd_9 = fld_set[2];
    cmn_cdiag_xcvrc_pwri_ovrd_10 = fld_set[3];
    cmn_cdiag_xcvrc_pwri_ovrd_11 = fld_set[4];
    cmn_cdiag_xcvrc_pwri_ovrd_13_12 = fld_set[5];
    cmn_cdiag_xcvrc_pwri_ovrd_14 = fld_set[6];
    cmn_cdiag_xcvrc_pwri_ovrd_15 = fld_set[7];
    cmn_cdiag_xcvrc_pwri_ovrd_23_16 = fld_set[8];
    cmn_cdiag_xcvrc_pwri_ovrd_31_24 = fld_set[9];
  endfunction

  function new(input string name="T_cmn_cdiag_xcvrc_pwri_ovrd_1024");
    super.new(name, 32, build_coverage(UVM_CVR_FIELD_VALS));
    if (has_coverage(UVM_CVR_FIELD_VALS)) begin
      wr_fld_covg = new();
      rd_fld_covg = new();
    end
  endfunction

endclass


/////////////////////////////////////////////////////
//                cmn_cmsmt_clk_freq_msmt_ctrl
/////////////////////////////////////////////////////
class T_cmn_cmsmt_clk_freq_msmt_ctrl_1122 extends cdns_uvm_reg;

  `uvm_object_utils(T_cmn_cmsmt_clk_freq_msmt_ctrl_1122)
  rand uvm_reg_field cmn_cmsmt_clk_freq_msmt_ctrl_13_0;
  rand uvm_reg_field cmn_cmsmt_clk_freq_msmt_ctrl_14;
  rand uvm_reg_field cmn_cmsmt_clk_freq_msmt_ctrl_15;
  rand uvm_reg_field cmn_cmsmt_clk_freq_msmt_ctrl_31_16;
  
  covergroup wr_fld_covg;
    cmn_cmsmt_clk_freq_msmt_ctrl_13_0: coverpoint cmn_cmsmt_clk_freq_msmt_ctrl_13_0.value[13:0];
    cmn_cmsmt_clk_freq_msmt_ctrl_14: coverpoint cmn_cmsmt_clk_freq_msmt_ctrl_14.value[0:0];
    cmn_cmsmt_clk_freq_msmt_ctrl_15: coverpoint cmn_cmsmt_clk_freq_msmt_ctrl_15.value[0:0];
    cmn_cmsmt_clk_freq_msmt_ctrl_31_16: coverpoint cmn_cmsmt_clk_freq_msmt_ctrl_31_16.value[15:0];
  endgroup
  covergroup rd_fld_covg;
    cmn_cmsmt_clk_freq_msmt_ctrl_13_0: coverpoint cmn_cmsmt_clk_freq_msmt_ctrl_13_0.value[13:0];
    cmn_cmsmt_clk_freq_msmt_ctrl_14: coverpoint cmn_cmsmt_clk_freq_msmt_ctrl_14.value[0:0];
    cmn_cmsmt_clk_freq_msmt_ctrl_15: coverpoint cmn_cmsmt_clk_freq_msmt_ctrl_15.value[0:0];
    cmn_cmsmt_clk_freq_msmt_ctrl_31_16: coverpoint cmn_cmsmt_clk_freq_msmt_ctrl_31_16.value[15:0];
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
    
    cmn_cmsmt_clk_freq_msmt_ctrl_13_0 = fld_set[0];
    cmn_cmsmt_clk_freq_msmt_ctrl_14 = fld_set[1];
    cmn_cmsmt_clk_freq_msmt_ctrl_15 = fld_set[2];
    cmn_cmsmt_clk_freq_msmt_ctrl_31_16 = fld_set[3];
  endfunction

  function new(input string name="T_cmn_cmsmt_clk_freq_msmt_ctrl_1122");
    super.new(name, 32, build_coverage(UVM_CVR_FIELD_VALS));
    if (has_coverage(UVM_CVR_FIELD_VALS)) begin
      wr_fld_covg = new();
      rd_fld_covg = new();
    end
  endfunction

endclass


/////////////////////////////////////////////////////
//                cmn_cmsmt_ref_clk_tmr_value
/////////////////////////////////////////////////////
class T_cmn_cmsmt_ref_clk_tmr_value_1124 extends cdns_uvm_reg;

  `uvm_object_utils(T_cmn_cmsmt_ref_clk_tmr_value_1124)
  rand uvm_reg_field cmn_cmsmt_ref_clk_tmr_value_15_0;
  rand uvm_reg_field cmn_cmsmt_ref_clk_tmr_value_31_16;
  
  covergroup wr_fld_covg;
    cmn_cmsmt_ref_clk_tmr_value_15_0: coverpoint cmn_cmsmt_ref_clk_tmr_value_15_0.value[15:0];
    cmn_cmsmt_ref_clk_tmr_value_31_16: coverpoint cmn_cmsmt_ref_clk_tmr_value_31_16.value[15:0];
  endgroup
  covergroup rd_fld_covg;
    cmn_cmsmt_ref_clk_tmr_value_15_0: coverpoint cmn_cmsmt_ref_clk_tmr_value_15_0.value[15:0];
    cmn_cmsmt_ref_clk_tmr_value_31_16: coverpoint cmn_cmsmt_ref_clk_tmr_value_31_16.value[15:0];
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
    
    cmn_cmsmt_ref_clk_tmr_value_15_0 = fld_set[0];
    cmn_cmsmt_ref_clk_tmr_value_31_16 = fld_set[1];
  endfunction

  function new(input string name="T_cmn_cmsmt_ref_clk_tmr_value_1124");
    super.new(name, 32, build_coverage(UVM_CVR_FIELD_VALS));
    if (has_coverage(UVM_CVR_FIELD_VALS)) begin
      wr_fld_covg = new();
      rd_fld_covg = new();
    end
  endfunction

endclass


/////////////////////////////////////////////////////
//                cmn_cmsmt_test_clk_cnt_value
/////////////////////////////////////////////////////
class T_cmn_cmsmt_test_clk_cnt_value_1125 extends cdns_uvm_reg;

  `uvm_object_utils(T_cmn_cmsmt_test_clk_cnt_value_1125)
  rand uvm_reg_field cmn_cmsmt_test_clk_cnt_value_15_0;
  rand uvm_reg_field cmn_cmsmt_test_clk_cnt_value_31_16;
  
  covergroup wr_fld_covg;
    cmn_cmsmt_test_clk_cnt_value_15_0: coverpoint cmn_cmsmt_test_clk_cnt_value_15_0.value[15:0];
    cmn_cmsmt_test_clk_cnt_value_31_16: coverpoint cmn_cmsmt_test_clk_cnt_value_31_16.value[15:0];
  endgroup
  covergroup rd_fld_covg;
    cmn_cmsmt_test_clk_cnt_value_15_0: coverpoint cmn_cmsmt_test_clk_cnt_value_15_0.value[15:0];
    cmn_cmsmt_test_clk_cnt_value_31_16: coverpoint cmn_cmsmt_test_clk_cnt_value_31_16.value[15:0];
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
    
    cmn_cmsmt_test_clk_cnt_value_15_0 = fld_set[0];
    cmn_cmsmt_test_clk_cnt_value_31_16 = fld_set[1];
  endfunction

  function new(input string name="T_cmn_cmsmt_test_clk_cnt_value_1125");
    super.new(name, 32, build_coverage(UVM_CVR_FIELD_VALS));
    if (has_coverage(UVM_CVR_FIELD_VALS)) begin
      wr_fld_covg = new();
      rd_fld_covg = new();
    end
  endfunction

endclass


/////////////////////////////////////////////////////
//                cmn_cmsmt_test_clk_sel
/////////////////////////////////////////////////////
class T_cmn_cmsmt_test_clk_sel_1123 extends cdns_uvm_reg;

  `uvm_object_utils(T_cmn_cmsmt_test_clk_sel_1123)
  rand uvm_reg_field cmn_cmsmt_test_clk_sel_3_0;
  rand uvm_reg_field cmn_cmsmt_test_clk_sel_15_4;
  rand uvm_reg_field cmn_cmsmt_test_clk_sel_31_16;
  
  covergroup wr_fld_covg;
    cmn_cmsmt_test_clk_sel_3_0: coverpoint cmn_cmsmt_test_clk_sel_3_0.value[3:0];
    cmn_cmsmt_test_clk_sel_15_4: coverpoint cmn_cmsmt_test_clk_sel_15_4.value[11:0];
    cmn_cmsmt_test_clk_sel_31_16: coverpoint cmn_cmsmt_test_clk_sel_31_16.value[15:0];
  endgroup
  covergroup rd_fld_covg;
    cmn_cmsmt_test_clk_sel_3_0: coverpoint cmn_cmsmt_test_clk_sel_3_0.value[3:0];
    cmn_cmsmt_test_clk_sel_15_4: coverpoint cmn_cmsmt_test_clk_sel_15_4.value[11:0];
    cmn_cmsmt_test_clk_sel_31_16: coverpoint cmn_cmsmt_test_clk_sel_31_16.value[15:0];
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
    
    cmn_cmsmt_test_clk_sel_3_0 = fld_set[0];
    cmn_cmsmt_test_clk_sel_15_4 = fld_set[1];
    cmn_cmsmt_test_clk_sel_31_16 = fld_set[2];
  endfunction

  function new(input string name="T_cmn_cmsmt_test_clk_sel_1123");
    super.new(name, 32, build_coverage(UVM_CVR_FIELD_VALS));
    if (has_coverage(UVM_CVR_FIELD_VALS)) begin
      wr_fld_covg = new();
      rd_fld_covg = new();
    end
  endfunction

endclass


/////////////////////////////////////////////////////
//                cmn_diag_atb_adc_ctrl
/////////////////////////////////////////////////////
class T_cmn_diag_atb_adc_ctrl_1170 extends cdns_uvm_reg;

  `uvm_object_utils(T_cmn_diag_atb_adc_ctrl_1170)
  rand uvm_reg_field cmn_diag_atb_adc_ctrl_7_0;
  rand uvm_reg_field cmn_diag_atb_adc_ctrl_12_8;
  rand uvm_reg_field cmn_diag_atb_adc_ctrl_13;
  rand uvm_reg_field cmn_diag_atb_adc_ctrl_14;
  rand uvm_reg_field cmn_diag_atb_adc_ctrl_15;
  rand uvm_reg_field cmn_diag_atb_adc_ctrl_19_16;
  rand uvm_reg_field cmn_diag_atb_adc_ctrl_24_20;
  rand uvm_reg_field cmn_diag_atb_adc_ctrl_26_25;
  rand uvm_reg_field cmn_diag_atb_adc_ctrl_27;
  rand uvm_reg_field cmn_diag_atb_adc_ctrl_28;
  rand uvm_reg_field cmn_diag_atb_adc_ctrl_29;
  rand uvm_reg_field cmn_diag_atb_adc_ctrl_31_30;
  
  covergroup wr_fld_covg;
    cmn_diag_atb_adc_ctrl_7_0: coverpoint cmn_diag_atb_adc_ctrl_7_0.value[7:0];
    cmn_diag_atb_adc_ctrl_12_8: coverpoint cmn_diag_atb_adc_ctrl_12_8.value[4:0];
    cmn_diag_atb_adc_ctrl_13: coverpoint cmn_diag_atb_adc_ctrl_13.value[0:0];
    cmn_diag_atb_adc_ctrl_14: coverpoint cmn_diag_atb_adc_ctrl_14.value[0:0];
    cmn_diag_atb_adc_ctrl_15: coverpoint cmn_diag_atb_adc_ctrl_15.value[0:0];
    cmn_diag_atb_adc_ctrl_19_16: coverpoint cmn_diag_atb_adc_ctrl_19_16.value[3:0];
    cmn_diag_atb_adc_ctrl_24_20: coverpoint cmn_diag_atb_adc_ctrl_24_20.value[4:0];
    cmn_diag_atb_adc_ctrl_26_25: coverpoint cmn_diag_atb_adc_ctrl_26_25.value[1:0];
    cmn_diag_atb_adc_ctrl_27: coverpoint cmn_diag_atb_adc_ctrl_27.value[0:0];
    cmn_diag_atb_adc_ctrl_28: coverpoint cmn_diag_atb_adc_ctrl_28.value[0:0];
    cmn_diag_atb_adc_ctrl_29: coverpoint cmn_diag_atb_adc_ctrl_29.value[0:0];
    cmn_diag_atb_adc_ctrl_31_30: coverpoint cmn_diag_atb_adc_ctrl_31_30.value[1:0];
  endgroup
  covergroup rd_fld_covg;
    cmn_diag_atb_adc_ctrl_7_0: coverpoint cmn_diag_atb_adc_ctrl_7_0.value[7:0];
    cmn_diag_atb_adc_ctrl_12_8: coverpoint cmn_diag_atb_adc_ctrl_12_8.value[4:0];
    cmn_diag_atb_adc_ctrl_13: coverpoint cmn_diag_atb_adc_ctrl_13.value[0:0];
    cmn_diag_atb_adc_ctrl_14: coverpoint cmn_diag_atb_adc_ctrl_14.value[0:0];
    cmn_diag_atb_adc_ctrl_15: coverpoint cmn_diag_atb_adc_ctrl_15.value[0:0];
    cmn_diag_atb_adc_ctrl_19_16: coverpoint cmn_diag_atb_adc_ctrl_19_16.value[3:0];
    cmn_diag_atb_adc_ctrl_24_20: coverpoint cmn_diag_atb_adc_ctrl_24_20.value[4:0];
    cmn_diag_atb_adc_ctrl_26_25: coverpoint cmn_diag_atb_adc_ctrl_26_25.value[1:0];
    cmn_diag_atb_adc_ctrl_27: coverpoint cmn_diag_atb_adc_ctrl_27.value[0:0];
    cmn_diag_atb_adc_ctrl_28: coverpoint cmn_diag_atb_adc_ctrl_28.value[0:0];
    cmn_diag_atb_adc_ctrl_29: coverpoint cmn_diag_atb_adc_ctrl_29.value[0:0];
    cmn_diag_atb_adc_ctrl_31_30: coverpoint cmn_diag_atb_adc_ctrl_31_30.value[1:0];
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
    
    cmn_diag_atb_adc_ctrl_7_0 = fld_set[0];
    cmn_diag_atb_adc_ctrl_12_8 = fld_set[1];
    cmn_diag_atb_adc_ctrl_13 = fld_set[2];
    cmn_diag_atb_adc_ctrl_14 = fld_set[3];
    cmn_diag_atb_adc_ctrl_15 = fld_set[4];
    cmn_diag_atb_adc_ctrl_19_16 = fld_set[5];
    cmn_diag_atb_adc_ctrl_24_20 = fld_set[6];
    cmn_diag_atb_adc_ctrl_26_25 = fld_set[7];
    cmn_diag_atb_adc_ctrl_27 = fld_set[8];
    cmn_diag_atb_adc_ctrl_28 = fld_set[9];
    cmn_diag_atb_adc_ctrl_29 = fld_set[10];
    cmn_diag_atb_adc_ctrl_31_30 = fld_set[11];
  endfunction

  function new(input string name="T_cmn_diag_atb_adc_ctrl_1170");
    super.new(name, 32, build_coverage(UVM_CVR_FIELD_VALS));
    if (has_coverage(UVM_CVR_FIELD_VALS)) begin
      wr_fld_covg = new();
      rd_fld_covg = new();
    end
  endfunction

endclass


/////////////////////////////////////////////////////
//                cmn_diag_atb_ctrl
/////////////////////////////////////////////////////
class T_cmn_diag_atb_ctrl_1169 extends cdns_uvm_reg;

  `uvm_object_utils(T_cmn_diag_atb_ctrl_1169)
  rand uvm_reg_field cmn_diag_atb_ctrl_0;
  rand uvm_reg_field cmn_diag_atb_ctrl_1;
  rand uvm_reg_field cmn_diag_atb_ctrl_2;
  rand uvm_reg_field cmn_diag_atb_ctrl_3;
  rand uvm_reg_field cmn_diag_atb_ctrl_15_4;
  rand uvm_reg_field cmn_diag_atb_ctrl_21_16;
  rand uvm_reg_field cmn_diag_atb_ctrl_26_22;
  rand uvm_reg_field cmn_diag_atb_ctrl_28_27;
  rand uvm_reg_field cmn_diag_atb_ctrl_31_29;
  
  covergroup wr_fld_covg;
    cmn_diag_atb_ctrl_0: coverpoint cmn_diag_atb_ctrl_0.value[0:0];
    cmn_diag_atb_ctrl_1: coverpoint cmn_diag_atb_ctrl_1.value[0:0];
    cmn_diag_atb_ctrl_2: coverpoint cmn_diag_atb_ctrl_2.value[0:0];
    cmn_diag_atb_ctrl_3: coverpoint cmn_diag_atb_ctrl_3.value[0:0];
    cmn_diag_atb_ctrl_15_4: coverpoint cmn_diag_atb_ctrl_15_4.value[11:0];
    cmn_diag_atb_ctrl_21_16: coverpoint cmn_diag_atb_ctrl_21_16.value[5:0];
    cmn_diag_atb_ctrl_26_22: coverpoint cmn_diag_atb_ctrl_26_22.value[4:0];
    cmn_diag_atb_ctrl_28_27: coverpoint cmn_diag_atb_ctrl_28_27.value[1:0];
    cmn_diag_atb_ctrl_31_29: coverpoint cmn_diag_atb_ctrl_31_29.value[2:0];
  endgroup
  covergroup rd_fld_covg;
    cmn_diag_atb_ctrl_0: coverpoint cmn_diag_atb_ctrl_0.value[0:0];
    cmn_diag_atb_ctrl_1: coverpoint cmn_diag_atb_ctrl_1.value[0:0];
    cmn_diag_atb_ctrl_2: coverpoint cmn_diag_atb_ctrl_2.value[0:0];
    cmn_diag_atb_ctrl_3: coverpoint cmn_diag_atb_ctrl_3.value[0:0];
    cmn_diag_atb_ctrl_15_4: coverpoint cmn_diag_atb_ctrl_15_4.value[11:0];
    cmn_diag_atb_ctrl_21_16: coverpoint cmn_diag_atb_ctrl_21_16.value[5:0];
    cmn_diag_atb_ctrl_26_22: coverpoint cmn_diag_atb_ctrl_26_22.value[4:0];
    cmn_diag_atb_ctrl_28_27: coverpoint cmn_diag_atb_ctrl_28_27.value[1:0];
    cmn_diag_atb_ctrl_31_29: coverpoint cmn_diag_atb_ctrl_31_29.value[2:0];
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
    
    cmn_diag_atb_ctrl_0 = fld_set[0];
    cmn_diag_atb_ctrl_1 = fld_set[1];
    cmn_diag_atb_ctrl_2 = fld_set[2];
    cmn_diag_atb_ctrl_3 = fld_set[3];
    cmn_diag_atb_ctrl_15_4 = fld_set[4];
    cmn_diag_atb_ctrl_21_16 = fld_set[5];
    cmn_diag_atb_ctrl_26_22 = fld_set[6];
    cmn_diag_atb_ctrl_28_27 = fld_set[7];
    cmn_diag_atb_ctrl_31_29 = fld_set[8];
  endfunction

  function new(input string name="T_cmn_diag_atb_ctrl_1169");
    super.new(name, 32, build_coverage(UVM_CVR_FIELD_VALS));
    if (has_coverage(UVM_CVR_FIELD_VALS)) begin
      wr_fld_covg = new();
      rd_fld_covg = new();
    end
  endfunction

endclass


/////////////////////////////////////////////////////
//                cmn_diag_bandgap_ovrd
/////////////////////////////////////////////////////
class T_cmn_diag_bandgap_ovrd_1164 extends cdns_uvm_reg;

  `uvm_object_utils(T_cmn_diag_bandgap_ovrd_1164)
  rand uvm_reg_field cmn_diag_bandgap_ovrd_1_0;
  rand uvm_reg_field cmn_diag_bandgap_ovrd_3_2;
  rand uvm_reg_field cmn_diag_bandgap_ovrd_7_4;
  rand uvm_reg_field cmn_diag_bandgap_ovrd_11_8;
  rand uvm_reg_field cmn_diag_bandgap_ovrd_15_12;
  rand uvm_reg_field cmn_diag_bandgap_ovrd_31_16;
  
  covergroup wr_fld_covg;
    cmn_diag_bandgap_ovrd_1_0: coverpoint cmn_diag_bandgap_ovrd_1_0.value[1:0];
    cmn_diag_bandgap_ovrd_3_2: coverpoint cmn_diag_bandgap_ovrd_3_2.value[1:0];
    cmn_diag_bandgap_ovrd_7_4: coverpoint cmn_diag_bandgap_ovrd_7_4.value[3:0];
    cmn_diag_bandgap_ovrd_11_8: coverpoint cmn_diag_bandgap_ovrd_11_8.value[3:0];
    cmn_diag_bandgap_ovrd_15_12: coverpoint cmn_diag_bandgap_ovrd_15_12.value[3:0];
    cmn_diag_bandgap_ovrd_31_16: coverpoint cmn_diag_bandgap_ovrd_31_16.value[15:0];
  endgroup
  covergroup rd_fld_covg;
    cmn_diag_bandgap_ovrd_1_0: coverpoint cmn_diag_bandgap_ovrd_1_0.value[1:0];
    cmn_diag_bandgap_ovrd_3_2: coverpoint cmn_diag_bandgap_ovrd_3_2.value[1:0];
    cmn_diag_bandgap_ovrd_7_4: coverpoint cmn_diag_bandgap_ovrd_7_4.value[3:0];
    cmn_diag_bandgap_ovrd_11_8: coverpoint cmn_diag_bandgap_ovrd_11_8.value[3:0];
    cmn_diag_bandgap_ovrd_15_12: coverpoint cmn_diag_bandgap_ovrd_15_12.value[3:0];
    cmn_diag_bandgap_ovrd_31_16: coverpoint cmn_diag_bandgap_ovrd_31_16.value[15:0];
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
    
    cmn_diag_bandgap_ovrd_1_0 = fld_set[0];
    cmn_diag_bandgap_ovrd_3_2 = fld_set[1];
    cmn_diag_bandgap_ovrd_7_4 = fld_set[2];
    cmn_diag_bandgap_ovrd_11_8 = fld_set[3];
    cmn_diag_bandgap_ovrd_15_12 = fld_set[4];
    cmn_diag_bandgap_ovrd_31_16 = fld_set[5];
  endfunction

  function new(input string name="T_cmn_diag_bandgap_ovrd_1164");
    super.new(name, 32, build_coverage(UVM_CVR_FIELD_VALS));
    if (has_coverage(UVM_CVR_FIELD_VALS)) begin
      wr_fld_covg = new();
      rd_fld_covg = new();
    end
  endfunction

endclass


/////////////////////////////////////////////////////
//                cmn_diag_bias_adj
/////////////////////////////////////////////////////
class T_cmn_diag_bias_adj_1179 extends cdns_uvm_reg;

  `uvm_object_utils(T_cmn_diag_bias_adj_1179)
  rand uvm_reg_field cmn_diag_bias_adj_7_0;
  rand uvm_reg_field cmn_diag_bias_adj_10_8;
  rand uvm_reg_field cmn_diag_bias_adj_11;
  rand uvm_reg_field cmn_diag_bias_adj_13_12;
  rand uvm_reg_field cmn_diag_bias_adj_14;
  rand uvm_reg_field cmn_diag_bias_adj_15;
  rand uvm_reg_field cmn_diag_bias_adj_16;
  rand uvm_reg_field cmn_diag_bias_adj_31_17;
  
  covergroup wr_fld_covg;
    cmn_diag_bias_adj_7_0: coverpoint cmn_diag_bias_adj_7_0.value[7:0];
    cmn_diag_bias_adj_10_8: coverpoint cmn_diag_bias_adj_10_8.value[2:0];
    cmn_diag_bias_adj_11: coverpoint cmn_diag_bias_adj_11.value[0:0];
    cmn_diag_bias_adj_13_12: coverpoint cmn_diag_bias_adj_13_12.value[1:0];
    cmn_diag_bias_adj_14: coverpoint cmn_diag_bias_adj_14.value[0:0];
    cmn_diag_bias_adj_15: coverpoint cmn_diag_bias_adj_15.value[0:0];
    cmn_diag_bias_adj_16: coverpoint cmn_diag_bias_adj_16.value[0:0];
    cmn_diag_bias_adj_31_17: coverpoint cmn_diag_bias_adj_31_17.value[14:0];
  endgroup
  covergroup rd_fld_covg;
    cmn_diag_bias_adj_7_0: coverpoint cmn_diag_bias_adj_7_0.value[7:0];
    cmn_diag_bias_adj_10_8: coverpoint cmn_diag_bias_adj_10_8.value[2:0];
    cmn_diag_bias_adj_11: coverpoint cmn_diag_bias_adj_11.value[0:0];
    cmn_diag_bias_adj_13_12: coverpoint cmn_diag_bias_adj_13_12.value[1:0];
    cmn_diag_bias_adj_14: coverpoint cmn_diag_bias_adj_14.value[0:0];
    cmn_diag_bias_adj_15: coverpoint cmn_diag_bias_adj_15.value[0:0];
    cmn_diag_bias_adj_16: coverpoint cmn_diag_bias_adj_16.value[0:0];
    cmn_diag_bias_adj_31_17: coverpoint cmn_diag_bias_adj_31_17.value[14:0];
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
    
    cmn_diag_bias_adj_7_0 = fld_set[0];
    cmn_diag_bias_adj_10_8 = fld_set[1];
    cmn_diag_bias_adj_11 = fld_set[2];
    cmn_diag_bias_adj_13_12 = fld_set[3];
    cmn_diag_bias_adj_14 = fld_set[4];
    cmn_diag_bias_adj_15 = fld_set[5];
    cmn_diag_bias_adj_16 = fld_set[6];
    cmn_diag_bias_adj_31_17 = fld_set[7];
  endfunction

  function new(input string name="T_cmn_diag_bias_adj_1179");
    super.new(name, 32, build_coverage(UVM_CVR_FIELD_VALS));
    if (has_coverage(UVM_CVR_FIELD_VALS)) begin
      wr_fld_covg = new();
      rd_fld_covg = new();
    end
  endfunction

endclass


/////////////////////////////////////////////////////
//                cmn_diag_bias_ovrd
/////////////////////////////////////////////////////
class T_cmn_diag_bias_ovrd_1165 extends cdns_uvm_reg;

  `uvm_object_utils(T_cmn_diag_bias_ovrd_1165)
  rand uvm_reg_field cmn_diag_bias_ovrd_2_0;
  rand uvm_reg_field cmn_diag_bias_ovrd_3;
  rand uvm_reg_field cmn_diag_bias_ovrd_6_4;
  rand uvm_reg_field cmn_diag_bias_ovrd_7;
  rand uvm_reg_field cmn_diag_bias_ovrd_10_8;
  rand uvm_reg_field cmn_diag_bias_ovrd_11;
  rand uvm_reg_field cmn_diag_bias_ovrd_14_12;
  rand uvm_reg_field cmn_diag_bias_ovrd_15;
  rand uvm_reg_field cmn_diag_bias_ovrd_17_16;
  rand uvm_reg_field cmn_diag_bias_ovrd_19_18;
  rand uvm_reg_field cmn_diag_bias_ovrd_20;
  rand uvm_reg_field cmn_diag_bias_ovrd_21;
  rand uvm_reg_field cmn_diag_bias_ovrd_23_22;
  rand uvm_reg_field cmn_diag_bias_ovrd_27_24;
  rand uvm_reg_field cmn_diag_bias_ovrd_31_28;
  
  covergroup wr_fld_covg;
    cmn_diag_bias_ovrd_2_0: coverpoint cmn_diag_bias_ovrd_2_0.value[2:0];
    cmn_diag_bias_ovrd_3: coverpoint cmn_diag_bias_ovrd_3.value[0:0];
    cmn_diag_bias_ovrd_6_4: coverpoint cmn_diag_bias_ovrd_6_4.value[2:0];
    cmn_diag_bias_ovrd_7: coverpoint cmn_diag_bias_ovrd_7.value[0:0];
    cmn_diag_bias_ovrd_10_8: coverpoint cmn_diag_bias_ovrd_10_8.value[2:0];
    cmn_diag_bias_ovrd_11: coverpoint cmn_diag_bias_ovrd_11.value[0:0];
    cmn_diag_bias_ovrd_14_12: coverpoint cmn_diag_bias_ovrd_14_12.value[2:0];
    cmn_diag_bias_ovrd_15: coverpoint cmn_diag_bias_ovrd_15.value[0:0];
    cmn_diag_bias_ovrd_17_16: coverpoint cmn_diag_bias_ovrd_17_16.value[1:0];
    cmn_diag_bias_ovrd_19_18: coverpoint cmn_diag_bias_ovrd_19_18.value[1:0];
    cmn_diag_bias_ovrd_20: coverpoint cmn_diag_bias_ovrd_20.value[0:0];
    cmn_diag_bias_ovrd_21: coverpoint cmn_diag_bias_ovrd_21.value[0:0];
    cmn_diag_bias_ovrd_23_22: coverpoint cmn_diag_bias_ovrd_23_22.value[1:0];
    cmn_diag_bias_ovrd_27_24: coverpoint cmn_diag_bias_ovrd_27_24.value[3:0];
    cmn_diag_bias_ovrd_31_28: coverpoint cmn_diag_bias_ovrd_31_28.value[3:0];
  endgroup
  covergroup rd_fld_covg;
    cmn_diag_bias_ovrd_2_0: coverpoint cmn_diag_bias_ovrd_2_0.value[2:0];
    cmn_diag_bias_ovrd_3: coverpoint cmn_diag_bias_ovrd_3.value[0:0];
    cmn_diag_bias_ovrd_6_4: coverpoint cmn_diag_bias_ovrd_6_4.value[2:0];
    cmn_diag_bias_ovrd_7: coverpoint cmn_diag_bias_ovrd_7.value[0:0];
    cmn_diag_bias_ovrd_10_8: coverpoint cmn_diag_bias_ovrd_10_8.value[2:0];
    cmn_diag_bias_ovrd_11: coverpoint cmn_diag_bias_ovrd_11.value[0:0];
    cmn_diag_bias_ovrd_14_12: coverpoint cmn_diag_bias_ovrd_14_12.value[2:0];
    cmn_diag_bias_ovrd_15: coverpoint cmn_diag_bias_ovrd_15.value[0:0];
    cmn_diag_bias_ovrd_17_16: coverpoint cmn_diag_bias_ovrd_17_16.value[1:0];
    cmn_diag_bias_ovrd_19_18: coverpoint cmn_diag_bias_ovrd_19_18.value[1:0];
    cmn_diag_bias_ovrd_20: coverpoint cmn_diag_bias_ovrd_20.value[0:0];
    cmn_diag_bias_ovrd_21: coverpoint cmn_diag_bias_ovrd_21.value[0:0];
    cmn_diag_bias_ovrd_23_22: coverpoint cmn_diag_bias_ovrd_23_22.value[1:0];
    cmn_diag_bias_ovrd_27_24: coverpoint cmn_diag_bias_ovrd_27_24.value[3:0];
    cmn_diag_bias_ovrd_31_28: coverpoint cmn_diag_bias_ovrd_31_28.value[3:0];
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
    
    cmn_diag_bias_ovrd_2_0 = fld_set[0];
    cmn_diag_bias_ovrd_3 = fld_set[1];
    cmn_diag_bias_ovrd_6_4 = fld_set[2];
    cmn_diag_bias_ovrd_7 = fld_set[3];
    cmn_diag_bias_ovrd_10_8 = fld_set[4];
    cmn_diag_bias_ovrd_11 = fld_set[5];
    cmn_diag_bias_ovrd_14_12 = fld_set[6];
    cmn_diag_bias_ovrd_15 = fld_set[7];
    cmn_diag_bias_ovrd_17_16 = fld_set[8];
    cmn_diag_bias_ovrd_19_18 = fld_set[9];
    cmn_diag_bias_ovrd_20 = fld_set[10];
    cmn_diag_bias_ovrd_21 = fld_set[11];
    cmn_diag_bias_ovrd_23_22 = fld_set[12];
    cmn_diag_bias_ovrd_27_24 = fld_set[13];
    cmn_diag_bias_ovrd_31_28 = fld_set[14];
  endfunction

  function new(input string name="T_cmn_diag_bias_ovrd_1165");
    super.new(name, 32, build_coverage(UVM_CVR_FIELD_VALS));
    if (has_coverage(UVM_CVR_FIELD_VALS)) begin
      wr_fld_covg = new();
      rd_fld_covg = new();
    end
  endfunction

endclass


/////////////////////////////////////////////////////
//                cmn_diag_cal_filt_ctrl
/////////////////////////////////////////////////////
class T_cmn_diag_cal_filt_ctrl_1177 extends cdns_uvm_reg;

  `uvm_object_utils(T_cmn_diag_cal_filt_ctrl_1177)
  rand uvm_reg_field cmn_diag_cal_filt_ctrl_2_0;
  rand uvm_reg_field cmn_diag_cal_filt_ctrl_3;
  rand uvm_reg_field cmn_diag_cal_filt_ctrl_6_4;
  rand uvm_reg_field cmn_diag_cal_filt_ctrl_7;
  rand uvm_reg_field cmn_diag_cal_filt_ctrl_10_8;
  rand uvm_reg_field cmn_diag_cal_filt_ctrl_11;
  rand uvm_reg_field cmn_diag_cal_filt_ctrl_14_12;
  rand uvm_reg_field cmn_diag_cal_filt_ctrl_15;
  rand uvm_reg_field cmn_diag_cal_filt_ctrl_18_16;
  rand uvm_reg_field cmn_diag_cal_filt_ctrl_20_19;
  rand uvm_reg_field cmn_diag_cal_filt_ctrl_21;
  rand uvm_reg_field cmn_diag_cal_filt_ctrl_22;
  rand uvm_reg_field cmn_diag_cal_filt_ctrl_23;
  rand uvm_reg_field cmn_diag_cal_filt_ctrl_24;
  rand uvm_reg_field cmn_diag_cal_filt_ctrl_25;
  rand uvm_reg_field cmn_diag_cal_filt_ctrl_31_26;
  
  covergroup wr_fld_covg;
    cmn_diag_cal_filt_ctrl_2_0: coverpoint cmn_diag_cal_filt_ctrl_2_0.value[2:0];
    cmn_diag_cal_filt_ctrl_3: coverpoint cmn_diag_cal_filt_ctrl_3.value[0:0];
    cmn_diag_cal_filt_ctrl_6_4: coverpoint cmn_diag_cal_filt_ctrl_6_4.value[2:0];
    cmn_diag_cal_filt_ctrl_7: coverpoint cmn_diag_cal_filt_ctrl_7.value[0:0];
    cmn_diag_cal_filt_ctrl_10_8: coverpoint cmn_diag_cal_filt_ctrl_10_8.value[2:0];
    cmn_diag_cal_filt_ctrl_11: coverpoint cmn_diag_cal_filt_ctrl_11.value[0:0];
    cmn_diag_cal_filt_ctrl_14_12: coverpoint cmn_diag_cal_filt_ctrl_14_12.value[2:0];
    cmn_diag_cal_filt_ctrl_15: coverpoint cmn_diag_cal_filt_ctrl_15.value[0:0];
    cmn_diag_cal_filt_ctrl_18_16: coverpoint cmn_diag_cal_filt_ctrl_18_16.value[2:0];
    cmn_diag_cal_filt_ctrl_20_19: coverpoint cmn_diag_cal_filt_ctrl_20_19.value[1:0];
    cmn_diag_cal_filt_ctrl_21: coverpoint cmn_diag_cal_filt_ctrl_21.value[0:0];
    cmn_diag_cal_filt_ctrl_22: coverpoint cmn_diag_cal_filt_ctrl_22.value[0:0];
    cmn_diag_cal_filt_ctrl_23: coverpoint cmn_diag_cal_filt_ctrl_23.value[0:0];
    cmn_diag_cal_filt_ctrl_24: coverpoint cmn_diag_cal_filt_ctrl_24.value[0:0];
    cmn_diag_cal_filt_ctrl_25: coverpoint cmn_diag_cal_filt_ctrl_25.value[0:0];
    cmn_diag_cal_filt_ctrl_31_26: coverpoint cmn_diag_cal_filt_ctrl_31_26.value[5:0];
  endgroup
  covergroup rd_fld_covg;
    cmn_diag_cal_filt_ctrl_2_0: coverpoint cmn_diag_cal_filt_ctrl_2_0.value[2:0];
    cmn_diag_cal_filt_ctrl_3: coverpoint cmn_diag_cal_filt_ctrl_3.value[0:0];
    cmn_diag_cal_filt_ctrl_6_4: coverpoint cmn_diag_cal_filt_ctrl_6_4.value[2:0];
    cmn_diag_cal_filt_ctrl_7: coverpoint cmn_diag_cal_filt_ctrl_7.value[0:0];
    cmn_diag_cal_filt_ctrl_10_8: coverpoint cmn_diag_cal_filt_ctrl_10_8.value[2:0];
    cmn_diag_cal_filt_ctrl_11: coverpoint cmn_diag_cal_filt_ctrl_11.value[0:0];
    cmn_diag_cal_filt_ctrl_14_12: coverpoint cmn_diag_cal_filt_ctrl_14_12.value[2:0];
    cmn_diag_cal_filt_ctrl_15: coverpoint cmn_diag_cal_filt_ctrl_15.value[0:0];
    cmn_diag_cal_filt_ctrl_18_16: coverpoint cmn_diag_cal_filt_ctrl_18_16.value[2:0];
    cmn_diag_cal_filt_ctrl_20_19: coverpoint cmn_diag_cal_filt_ctrl_20_19.value[1:0];
    cmn_diag_cal_filt_ctrl_21: coverpoint cmn_diag_cal_filt_ctrl_21.value[0:0];
    cmn_diag_cal_filt_ctrl_22: coverpoint cmn_diag_cal_filt_ctrl_22.value[0:0];
    cmn_diag_cal_filt_ctrl_23: coverpoint cmn_diag_cal_filt_ctrl_23.value[0:0];
    cmn_diag_cal_filt_ctrl_24: coverpoint cmn_diag_cal_filt_ctrl_24.value[0:0];
    cmn_diag_cal_filt_ctrl_25: coverpoint cmn_diag_cal_filt_ctrl_25.value[0:0];
    cmn_diag_cal_filt_ctrl_31_26: coverpoint cmn_diag_cal_filt_ctrl_31_26.value[5:0];
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
    
    cmn_diag_cal_filt_ctrl_2_0 = fld_set[0];
    cmn_diag_cal_filt_ctrl_3 = fld_set[1];
    cmn_diag_cal_filt_ctrl_6_4 = fld_set[2];
    cmn_diag_cal_filt_ctrl_7 = fld_set[3];
    cmn_diag_cal_filt_ctrl_10_8 = fld_set[4];
    cmn_diag_cal_filt_ctrl_11 = fld_set[5];
    cmn_diag_cal_filt_ctrl_14_12 = fld_set[6];
    cmn_diag_cal_filt_ctrl_15 = fld_set[7];
    cmn_diag_cal_filt_ctrl_18_16 = fld_set[8];
    cmn_diag_cal_filt_ctrl_20_19 = fld_set[9];
    cmn_diag_cal_filt_ctrl_21 = fld_set[10];
    cmn_diag_cal_filt_ctrl_22 = fld_set[11];
    cmn_diag_cal_filt_ctrl_23 = fld_set[12];
    cmn_diag_cal_filt_ctrl_24 = fld_set[13];
    cmn_diag_cal_filt_ctrl_25 = fld_set[14];
    cmn_diag_cal_filt_ctrl_31_26 = fld_set[15];
  endfunction

  function new(input string name="T_cmn_diag_cal_filt_ctrl_1177");
    super.new(name, 32, build_coverage(UVM_CVR_FIELD_VALS));
    if (has_coverage(UVM_CVR_FIELD_VALS)) begin
      wr_fld_covg = new();
      rd_fld_covg = new();
    end
  endfunction

endclass


/////////////////////////////////////////////////////
//                cmn_diag_cya
/////////////////////////////////////////////////////
class T_cmn_diag_cya_1173 extends cdns_uvm_reg;

  `uvm_object_utils(T_cmn_diag_cya_1173)
  rand uvm_reg_field cmn_diag_cya_15_0;
  rand uvm_reg_field cmn_diag_cya_31_16;
  
  covergroup wr_fld_covg;
    cmn_diag_cya_15_0: coverpoint cmn_diag_cya_15_0.value[15:0];
    cmn_diag_cya_31_16: coverpoint cmn_diag_cya_31_16.value[15:0];
  endgroup
  covergroup rd_fld_covg;
    cmn_diag_cya_15_0: coverpoint cmn_diag_cya_15_0.value[15:0];
    cmn_diag_cya_31_16: coverpoint cmn_diag_cya_31_16.value[15:0];
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
    
    cmn_diag_cya_15_0 = fld_set[0];
    cmn_diag_cya_31_16 = fld_set[1];
  endfunction

  function new(input string name="T_cmn_diag_cya_1173");
    super.new(name, 32, build_coverage(UVM_CVR_FIELD_VALS));
    if (has_coverage(UVM_CVR_FIELD_VALS)) begin
      wr_fld_covg = new();
      rd_fld_covg = new();
    end
  endfunction

endclass


/////////////////////////////////////////////////////
//                cmn_diag_gpana_1
/////////////////////////////////////////////////////
class T_cmn_diag_gpana_1_1174 extends cdns_uvm_reg;

  `uvm_object_utils(T_cmn_diag_gpana_1_1174)
  rand uvm_reg_field cmn_diag_gpana_1_15_0;
  rand uvm_reg_field cmn_diag_gpana_1_31_16;
  
  covergroup wr_fld_covg;
    cmn_diag_gpana_1_15_0: coverpoint cmn_diag_gpana_1_15_0.value[15:0];
    cmn_diag_gpana_1_31_16: coverpoint cmn_diag_gpana_1_31_16.value[15:0];
  endgroup
  covergroup rd_fld_covg;
    cmn_diag_gpana_1_15_0: coverpoint cmn_diag_gpana_1_15_0.value[15:0];
    cmn_diag_gpana_1_31_16: coverpoint cmn_diag_gpana_1_31_16.value[15:0];
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
    
    cmn_diag_gpana_1_15_0 = fld_set[0];
    cmn_diag_gpana_1_31_16 = fld_set[1];
  endfunction

  function new(input string name="T_cmn_diag_gpana_1_1174");
    super.new(name, 32, build_coverage(UVM_CVR_FIELD_VALS));
    if (has_coverage(UVM_CVR_FIELD_VALS)) begin
      wr_fld_covg = new();
      rd_fld_covg = new();
    end
  endfunction

endclass


/////////////////////////////////////////////////////
//                cmn_diag_gpana_2
/////////////////////////////////////////////////////
class T_cmn_diag_gpana_2_1175 extends cdns_uvm_reg;

  `uvm_object_utils(T_cmn_diag_gpana_2_1175)
  rand uvm_reg_field cmn_diag_gpana_2_15_0;
  rand uvm_reg_field cmn_diag_gpana_2_31_16;
  
  covergroup wr_fld_covg;
    cmn_diag_gpana_2_15_0: coverpoint cmn_diag_gpana_2_15_0.value[15:0];
    cmn_diag_gpana_2_31_16: coverpoint cmn_diag_gpana_2_31_16.value[15:0];
  endgroup
  covergroup rd_fld_covg;
    cmn_diag_gpana_2_15_0: coverpoint cmn_diag_gpana_2_15_0.value[15:0];
    cmn_diag_gpana_2_31_16: coverpoint cmn_diag_gpana_2_31_16.value[15:0];
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
    
    cmn_diag_gpana_2_15_0 = fld_set[0];
    cmn_diag_gpana_2_31_16 = fld_set[1];
  endfunction

  function new(input string name="T_cmn_diag_gpana_2_1175");
    super.new(name, 32, build_coverage(UVM_CVR_FIELD_VALS));
    if (has_coverage(UVM_CVR_FIELD_VALS)) begin
      wr_fld_covg = new();
      rd_fld_covg = new();
    end
  endfunction

endclass


/////////////////////////////////////////////////////
//                cmn_diag_gpana_st
/////////////////////////////////////////////////////
class T_cmn_diag_gpana_st_1176 extends cdns_uvm_reg;

  `uvm_object_utils(T_cmn_diag_gpana_st_1176)
  rand uvm_reg_field cmn_diag_gpana_st_15_0;
  rand uvm_reg_field cmn_diag_gpana_st_31_16;
  
  covergroup wr_fld_covg;
    cmn_diag_gpana_st_15_0: coverpoint cmn_diag_gpana_st_15_0.value[15:0];
    cmn_diag_gpana_st_31_16: coverpoint cmn_diag_gpana_st_31_16.value[15:0];
  endgroup
  covergroup rd_fld_covg;
    cmn_diag_gpana_st_15_0: coverpoint cmn_diag_gpana_st_15_0.value[15:0];
    cmn_diag_gpana_st_31_16: coverpoint cmn_diag_gpana_st_31_16.value[15:0];
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
    
    cmn_diag_gpana_st_15_0 = fld_set[0];
    cmn_diag_gpana_st_31_16 = fld_set[1];
  endfunction

  function new(input string name="T_cmn_diag_gpana_st_1176");
    super.new(name, 32, build_coverage(UVM_CVR_FIELD_VALS));
    if (has_coverage(UVM_CVR_FIELD_VALS)) begin
      wr_fld_covg = new();
      rd_fld_covg = new();
    end
  endfunction

endclass


/////////////////////////////////////////////////////
//                cmn_diag_hsrrsm_ctrl
/////////////////////////////////////////////////////
class T_cmn_diag_hsrrsm_ctrl_1171 extends cdns_uvm_reg;

  `uvm_object_utils(T_cmn_diag_hsrrsm_ctrl_1171)
  rand uvm_reg_field cmn_diag_hsrrsm_ctrl_3_0;
  rand uvm_reg_field cmn_diag_hsrrsm_ctrl_7_4;
  rand uvm_reg_field cmn_diag_hsrrsm_ctrl_15_8;
  rand uvm_reg_field cmn_diag_hsrrsm_ctrl_31_16;
  
  covergroup wr_fld_covg;
    cmn_diag_hsrrsm_ctrl_3_0: coverpoint cmn_diag_hsrrsm_ctrl_3_0.value[3:0];
    cmn_diag_hsrrsm_ctrl_7_4: coverpoint cmn_diag_hsrrsm_ctrl_7_4.value[3:0];
    cmn_diag_hsrrsm_ctrl_15_8: coverpoint cmn_diag_hsrrsm_ctrl_15_8.value[7:0];
    cmn_diag_hsrrsm_ctrl_31_16: coverpoint cmn_diag_hsrrsm_ctrl_31_16.value[15:0];
  endgroup
  covergroup rd_fld_covg;
    cmn_diag_hsrrsm_ctrl_3_0: coverpoint cmn_diag_hsrrsm_ctrl_3_0.value[3:0];
    cmn_diag_hsrrsm_ctrl_7_4: coverpoint cmn_diag_hsrrsm_ctrl_7_4.value[3:0];
    cmn_diag_hsrrsm_ctrl_15_8: coverpoint cmn_diag_hsrrsm_ctrl_15_8.value[7:0];
    cmn_diag_hsrrsm_ctrl_31_16: coverpoint cmn_diag_hsrrsm_ctrl_31_16.value[15:0];
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
    
    cmn_diag_hsrrsm_ctrl_3_0 = fld_set[0];
    cmn_diag_hsrrsm_ctrl_7_4 = fld_set[1];
    cmn_diag_hsrrsm_ctrl_15_8 = fld_set[2];
    cmn_diag_hsrrsm_ctrl_31_16 = fld_set[3];
  endfunction

  function new(input string name="T_cmn_diag_hsrrsm_ctrl_1171");
    super.new(name, 32, build_coverage(UVM_CVR_FIELD_VALS));
    if (has_coverage(UVM_CVR_FIELD_VALS)) begin
      wr_fld_covg = new();
      rd_fld_covg = new();
    end
  endfunction

endclass


/////////////////////////////////////////////////////
//                cmn_diag_mom_osc_ctrl
/////////////////////////////////////////////////////
class T_cmn_diag_mom_osc_ctrl_1178 extends cdns_uvm_reg;

  `uvm_object_utils(T_cmn_diag_mom_osc_ctrl_1178)
  rand uvm_reg_field cmn_diag_mom_osc_ctrl_0;
  rand uvm_reg_field cmn_diag_mom_osc_ctrl_1;
  rand uvm_reg_field cmn_diag_mom_osc_ctrl_2;
  rand uvm_reg_field cmn_diag_mom_osc_ctrl_3;
  rand uvm_reg_field cmn_diag_mom_osc_ctrl_4;
  rand uvm_reg_field cmn_diag_mom_osc_ctrl_5;
  rand uvm_reg_field cmn_diag_mom_osc_ctrl_7_6;
  rand uvm_reg_field cmn_diag_mom_osc_ctrl_13_8;
  rand uvm_reg_field cmn_diag_mom_osc_ctrl_15_14;
  rand uvm_reg_field cmn_diag_mom_osc_ctrl_19_16;
  rand uvm_reg_field cmn_diag_mom_osc_ctrl_31_20;
  
  covergroup wr_fld_covg;
    cmn_diag_mom_osc_ctrl_0: coverpoint cmn_diag_mom_osc_ctrl_0.value[0:0];
    cmn_diag_mom_osc_ctrl_1: coverpoint cmn_diag_mom_osc_ctrl_1.value[0:0];
    cmn_diag_mom_osc_ctrl_2: coverpoint cmn_diag_mom_osc_ctrl_2.value[0:0];
    cmn_diag_mom_osc_ctrl_3: coverpoint cmn_diag_mom_osc_ctrl_3.value[0:0];
    cmn_diag_mom_osc_ctrl_4: coverpoint cmn_diag_mom_osc_ctrl_4.value[0:0];
    cmn_diag_mom_osc_ctrl_5: coverpoint cmn_diag_mom_osc_ctrl_5.value[0:0];
    cmn_diag_mom_osc_ctrl_7_6: coverpoint cmn_diag_mom_osc_ctrl_7_6.value[1:0];
    cmn_diag_mom_osc_ctrl_13_8: coverpoint cmn_diag_mom_osc_ctrl_13_8.value[5:0];
    cmn_diag_mom_osc_ctrl_15_14: coverpoint cmn_diag_mom_osc_ctrl_15_14.value[1:0];
    cmn_diag_mom_osc_ctrl_19_16: coverpoint cmn_diag_mom_osc_ctrl_19_16.value[3:0];
    cmn_diag_mom_osc_ctrl_31_20: coverpoint cmn_diag_mom_osc_ctrl_31_20.value[11:0];
  endgroup
  covergroup rd_fld_covg;
    cmn_diag_mom_osc_ctrl_0: coverpoint cmn_diag_mom_osc_ctrl_0.value[0:0];
    cmn_diag_mom_osc_ctrl_1: coverpoint cmn_diag_mom_osc_ctrl_1.value[0:0];
    cmn_diag_mom_osc_ctrl_2: coverpoint cmn_diag_mom_osc_ctrl_2.value[0:0];
    cmn_diag_mom_osc_ctrl_3: coverpoint cmn_diag_mom_osc_ctrl_3.value[0:0];
    cmn_diag_mom_osc_ctrl_4: coverpoint cmn_diag_mom_osc_ctrl_4.value[0:0];
    cmn_diag_mom_osc_ctrl_5: coverpoint cmn_diag_mom_osc_ctrl_5.value[0:0];
    cmn_diag_mom_osc_ctrl_7_6: coverpoint cmn_diag_mom_osc_ctrl_7_6.value[1:0];
    cmn_diag_mom_osc_ctrl_13_8: coverpoint cmn_diag_mom_osc_ctrl_13_8.value[5:0];
    cmn_diag_mom_osc_ctrl_15_14: coverpoint cmn_diag_mom_osc_ctrl_15_14.value[1:0];
    cmn_diag_mom_osc_ctrl_19_16: coverpoint cmn_diag_mom_osc_ctrl_19_16.value[3:0];
    cmn_diag_mom_osc_ctrl_31_20: coverpoint cmn_diag_mom_osc_ctrl_31_20.value[11:0];
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
    
    cmn_diag_mom_osc_ctrl_0 = fld_set[0];
    cmn_diag_mom_osc_ctrl_1 = fld_set[1];
    cmn_diag_mom_osc_ctrl_2 = fld_set[2];
    cmn_diag_mom_osc_ctrl_3 = fld_set[3];
    cmn_diag_mom_osc_ctrl_4 = fld_set[4];
    cmn_diag_mom_osc_ctrl_5 = fld_set[5];
    cmn_diag_mom_osc_ctrl_7_6 = fld_set[6];
    cmn_diag_mom_osc_ctrl_13_8 = fld_set[7];
    cmn_diag_mom_osc_ctrl_15_14 = fld_set[8];
    cmn_diag_mom_osc_ctrl_19_16 = fld_set[9];
    cmn_diag_mom_osc_ctrl_31_20 = fld_set[10];
  endfunction

  function new(input string name="T_cmn_diag_mom_osc_ctrl_1178");
    super.new(name, 32, build_coverage(UVM_CVR_FIELD_VALS));
    if (has_coverage(UVM_CVR_FIELD_VALS)) begin
      wr_fld_covg = new();
      rd_fld_covg = new();
    end
  endfunction

endclass


/////////////////////////////////////////////////////
//                cmn_diag_pm_ctrl
/////////////////////////////////////////////////////
class T_cmn_diag_pm_ctrl_1166 extends cdns_uvm_reg;

  `uvm_object_utils(T_cmn_diag_pm_ctrl_1166)
  rand uvm_reg_field cmn_diag_pm_ctrl_15_0;
  rand uvm_reg_field cmn_diag_pm_ctrl_18_16;
  rand uvm_reg_field cmn_diag_pm_ctrl_19;
  rand uvm_reg_field cmn_diag_pm_ctrl_20;
  rand uvm_reg_field cmn_diag_pm_ctrl_31_21;
  
  covergroup wr_fld_covg;
    cmn_diag_pm_ctrl_15_0: coverpoint cmn_diag_pm_ctrl_15_0.value[15:0];
    cmn_diag_pm_ctrl_18_16: coverpoint cmn_diag_pm_ctrl_18_16.value[2:0];
    cmn_diag_pm_ctrl_19: coverpoint cmn_diag_pm_ctrl_19.value[0:0];
    cmn_diag_pm_ctrl_20: coverpoint cmn_diag_pm_ctrl_20.value[0:0];
    cmn_diag_pm_ctrl_31_21: coverpoint cmn_diag_pm_ctrl_31_21.value[10:0];
  endgroup
  covergroup rd_fld_covg;
    cmn_diag_pm_ctrl_15_0: coverpoint cmn_diag_pm_ctrl_15_0.value[15:0];
    cmn_diag_pm_ctrl_18_16: coverpoint cmn_diag_pm_ctrl_18_16.value[2:0];
    cmn_diag_pm_ctrl_19: coverpoint cmn_diag_pm_ctrl_19.value[0:0];
    cmn_diag_pm_ctrl_20: coverpoint cmn_diag_pm_ctrl_20.value[0:0];
    cmn_diag_pm_ctrl_31_21: coverpoint cmn_diag_pm_ctrl_31_21.value[10:0];
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
    
    cmn_diag_pm_ctrl_15_0 = fld_set[0];
    cmn_diag_pm_ctrl_18_16 = fld_set[1];
    cmn_diag_pm_ctrl_19 = fld_set[2];
    cmn_diag_pm_ctrl_20 = fld_set[3];
    cmn_diag_pm_ctrl_31_21 = fld_set[4];
  endfunction

  function new(input string name="T_cmn_diag_pm_ctrl_1166");
    super.new(name, 32, build_coverage(UVM_CVR_FIELD_VALS));
    if (has_coverage(UVM_CVR_FIELD_VALS)) begin
      wr_fld_covg = new();
      rd_fld_covg = new();
    end
  endfunction

endclass


/////////////////////////////////////////////////////
//                cmn_diag_rst_diag
/////////////////////////////////////////////////////
class T_cmn_diag_rst_diag_1172 extends cdns_uvm_reg;

  `uvm_object_utils(T_cmn_diag_rst_diag_1172)
  rand uvm_reg_field cmn_diag_rst_diag_0;
  rand uvm_reg_field cmn_diag_rst_diag_1;
  rand uvm_reg_field cmn_diag_rst_diag_2;
  rand uvm_reg_field cmn_diag_rst_diag_3;
  rand uvm_reg_field cmn_diag_rst_diag_4;
  rand uvm_reg_field cmn_diag_rst_diag_5;
  rand uvm_reg_field cmn_diag_rst_diag_6;
  rand uvm_reg_field cmn_diag_rst_diag_7;
  rand uvm_reg_field cmn_diag_rst_diag_8;
  rand uvm_reg_field cmn_diag_rst_diag_9;
  rand uvm_reg_field cmn_diag_rst_diag_10;
  rand uvm_reg_field cmn_diag_rst_diag_11;
  rand uvm_reg_field cmn_diag_rst_diag_12;
  rand uvm_reg_field cmn_diag_rst_diag_13;
  rand uvm_reg_field cmn_diag_rst_diag_15_14;
  rand uvm_reg_field cmn_diag_rst_diag_31_16;
  
  covergroup wr_fld_covg;
    cmn_diag_rst_diag_0: coverpoint cmn_diag_rst_diag_0.value[0:0];
    cmn_diag_rst_diag_1: coverpoint cmn_diag_rst_diag_1.value[0:0];
    cmn_diag_rst_diag_2: coverpoint cmn_diag_rst_diag_2.value[0:0];
    cmn_diag_rst_diag_3: coverpoint cmn_diag_rst_diag_3.value[0:0];
    cmn_diag_rst_diag_4: coverpoint cmn_diag_rst_diag_4.value[0:0];
    cmn_diag_rst_diag_5: coverpoint cmn_diag_rst_diag_5.value[0:0];
    cmn_diag_rst_diag_6: coverpoint cmn_diag_rst_diag_6.value[0:0];
    cmn_diag_rst_diag_7: coverpoint cmn_diag_rst_diag_7.value[0:0];
    cmn_diag_rst_diag_8: coverpoint cmn_diag_rst_diag_8.value[0:0];
    cmn_diag_rst_diag_9: coverpoint cmn_diag_rst_diag_9.value[0:0];
    cmn_diag_rst_diag_10: coverpoint cmn_diag_rst_diag_10.value[0:0];
    cmn_diag_rst_diag_11: coverpoint cmn_diag_rst_diag_11.value[0:0];
    cmn_diag_rst_diag_12: coverpoint cmn_diag_rst_diag_12.value[0:0];
    cmn_diag_rst_diag_13: coverpoint cmn_diag_rst_diag_13.value[0:0];
    cmn_diag_rst_diag_15_14: coverpoint cmn_diag_rst_diag_15_14.value[1:0];
    cmn_diag_rst_diag_31_16: coverpoint cmn_diag_rst_diag_31_16.value[15:0];
  endgroup
  covergroup rd_fld_covg;
    cmn_diag_rst_diag_0: coverpoint cmn_diag_rst_diag_0.value[0:0];
    cmn_diag_rst_diag_1: coverpoint cmn_diag_rst_diag_1.value[0:0];
    cmn_diag_rst_diag_2: coverpoint cmn_diag_rst_diag_2.value[0:0];
    cmn_diag_rst_diag_3: coverpoint cmn_diag_rst_diag_3.value[0:0];
    cmn_diag_rst_diag_4: coverpoint cmn_diag_rst_diag_4.value[0:0];
    cmn_diag_rst_diag_5: coverpoint cmn_diag_rst_diag_5.value[0:0];
    cmn_diag_rst_diag_6: coverpoint cmn_diag_rst_diag_6.value[0:0];
    cmn_diag_rst_diag_7: coverpoint cmn_diag_rst_diag_7.value[0:0];
    cmn_diag_rst_diag_8: coverpoint cmn_diag_rst_diag_8.value[0:0];
    cmn_diag_rst_diag_9: coverpoint cmn_diag_rst_diag_9.value[0:0];
    cmn_diag_rst_diag_10: coverpoint cmn_diag_rst_diag_10.value[0:0];
    cmn_diag_rst_diag_11: coverpoint cmn_diag_rst_diag_11.value[0:0];
    cmn_diag_rst_diag_12: coverpoint cmn_diag_rst_diag_12.value[0:0];
    cmn_diag_rst_diag_13: coverpoint cmn_diag_rst_diag_13.value[0:0];
    cmn_diag_rst_diag_15_14: coverpoint cmn_diag_rst_diag_15_14.value[1:0];
    cmn_diag_rst_diag_31_16: coverpoint cmn_diag_rst_diag_31_16.value[15:0];
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
    
    cmn_diag_rst_diag_0 = fld_set[0];
    cmn_diag_rst_diag_1 = fld_set[1];
    cmn_diag_rst_diag_2 = fld_set[2];
    cmn_diag_rst_diag_3 = fld_set[3];
    cmn_diag_rst_diag_4 = fld_set[4];
    cmn_diag_rst_diag_5 = fld_set[5];
    cmn_diag_rst_diag_6 = fld_set[6];
    cmn_diag_rst_diag_7 = fld_set[7];
    cmn_diag_rst_diag_8 = fld_set[8];
    cmn_diag_rst_diag_9 = fld_set[9];
    cmn_diag_rst_diag_10 = fld_set[10];
    cmn_diag_rst_diag_11 = fld_set[11];
    cmn_diag_rst_diag_12 = fld_set[12];
    cmn_diag_rst_diag_13 = fld_set[13];
    cmn_diag_rst_diag_15_14 = fld_set[14];
    cmn_diag_rst_diag_31_16 = fld_set[15];
  endfunction

  function new(input string name="T_cmn_diag_rst_diag_1172");
    super.new(name, 32, build_coverage(UVM_CVR_FIELD_VALS));
    if (has_coverage(UVM_CVR_FIELD_VALS)) begin
      wr_fld_covg = new();
      rd_fld_covg = new();
    end
  endfunction

endclass


/////////////////////////////////////////////////////
//                cmn_diag_sh_bg_res
/////////////////////////////////////////////////////
class T_cmn_diag_sh_bg_res_1167 extends cdns_uvm_reg;

  `uvm_object_utils(T_cmn_diag_sh_bg_res_1167)
  rand uvm_reg_field cmn_diag_sh_bg_res_4_0;
  rand uvm_reg_field cmn_diag_sh_bg_res_5;
  rand uvm_reg_field cmn_diag_sh_bg_res_15_6;
  rand uvm_reg_field cmn_diag_sh_bg_res_20_16;
  rand uvm_reg_field cmn_diag_sh_bg_res_23_21;
  rand uvm_reg_field cmn_diag_sh_bg_res_29_24;
  rand uvm_reg_field cmn_diag_sh_bg_res_31_30;
  
  covergroup wr_fld_covg;
    cmn_diag_sh_bg_res_4_0: coverpoint cmn_diag_sh_bg_res_4_0.value[4:0];
    cmn_diag_sh_bg_res_5: coverpoint cmn_diag_sh_bg_res_5.value[0:0];
    cmn_diag_sh_bg_res_15_6: coverpoint cmn_diag_sh_bg_res_15_6.value[9:0];
    cmn_diag_sh_bg_res_20_16: coverpoint cmn_diag_sh_bg_res_20_16.value[4:0];
    cmn_diag_sh_bg_res_23_21: coverpoint cmn_diag_sh_bg_res_23_21.value[2:0];
    cmn_diag_sh_bg_res_29_24: coverpoint cmn_diag_sh_bg_res_29_24.value[5:0];
    cmn_diag_sh_bg_res_31_30: coverpoint cmn_diag_sh_bg_res_31_30.value[1:0];
  endgroup
  covergroup rd_fld_covg;
    cmn_diag_sh_bg_res_4_0: coverpoint cmn_diag_sh_bg_res_4_0.value[4:0];
    cmn_diag_sh_bg_res_5: coverpoint cmn_diag_sh_bg_res_5.value[0:0];
    cmn_diag_sh_bg_res_15_6: coverpoint cmn_diag_sh_bg_res_15_6.value[9:0];
    cmn_diag_sh_bg_res_20_16: coverpoint cmn_diag_sh_bg_res_20_16.value[4:0];
    cmn_diag_sh_bg_res_23_21: coverpoint cmn_diag_sh_bg_res_23_21.value[2:0];
    cmn_diag_sh_bg_res_29_24: coverpoint cmn_diag_sh_bg_res_29_24.value[5:0];
    cmn_diag_sh_bg_res_31_30: coverpoint cmn_diag_sh_bg_res_31_30.value[1:0];
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
    
    cmn_diag_sh_bg_res_4_0 = fld_set[0];
    cmn_diag_sh_bg_res_5 = fld_set[1];
    cmn_diag_sh_bg_res_15_6 = fld_set[2];
    cmn_diag_sh_bg_res_20_16 = fld_set[3];
    cmn_diag_sh_bg_res_23_21 = fld_set[4];
    cmn_diag_sh_bg_res_29_24 = fld_set[5];
    cmn_diag_sh_bg_res_31_30 = fld_set[6];
  endfunction

  function new(input string name="T_cmn_diag_sh_bg_res_1167");
    super.new(name, 32, build_coverage(UVM_CVR_FIELD_VALS));
    if (has_coverage(UVM_CVR_FIELD_VALS)) begin
      wr_fld_covg = new();
      rd_fld_covg = new();
    end
  endfunction

endclass


/////////////////////////////////////////////////////
//                cmn_diag_sh_sdclk
/////////////////////////////////////////////////////
class T_cmn_diag_sh_sdclk_1168 extends cdns_uvm_reg;

  `uvm_object_utils(T_cmn_diag_sh_sdclk_1168)
  rand uvm_reg_field cmn_diag_sh_sdclk_4_0;
  rand uvm_reg_field cmn_diag_sh_sdclk_15_5;
  rand uvm_reg_field cmn_diag_sh_sdclk_31_16;
  
  covergroup wr_fld_covg;
    cmn_diag_sh_sdclk_4_0: coverpoint cmn_diag_sh_sdclk_4_0.value[4:0];
    cmn_diag_sh_sdclk_15_5: coverpoint cmn_diag_sh_sdclk_15_5.value[10:0];
    cmn_diag_sh_sdclk_31_16: coverpoint cmn_diag_sh_sdclk_31_16.value[15:0];
  endgroup
  covergroup rd_fld_covg;
    cmn_diag_sh_sdclk_4_0: coverpoint cmn_diag_sh_sdclk_4_0.value[4:0];
    cmn_diag_sh_sdclk_15_5: coverpoint cmn_diag_sh_sdclk_15_5.value[10:0];
    cmn_diag_sh_sdclk_31_16: coverpoint cmn_diag_sh_sdclk_31_16.value[15:0];
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
    
    cmn_diag_sh_sdclk_4_0 = fld_set[0];
    cmn_diag_sh_sdclk_15_5 = fld_set[1];
    cmn_diag_sh_sdclk_31_16 = fld_set[2];
  endfunction

  function new(input string name="T_cmn_diag_sh_sdclk_1168");
    super.new(name, 32, build_coverage(UVM_CVR_FIELD_VALS));
    if (has_coverage(UVM_CVR_FIELD_VALS)) begin
      wr_fld_covg = new();
      rd_fld_covg = new();
    end
  endfunction

endclass


/////////////////////////////////////////////////////
//                cmn_diag_tmpsns_ana_ctrl
/////////////////////////////////////////////////////
class T_cmn_diag_tmpsns_ana_ctrl_1180 extends cdns_uvm_reg;

  `uvm_object_utils(T_cmn_diag_tmpsns_ana_ctrl_1180)
  rand uvm_reg_field cmn_diag_tmpsns_ana_ctrl_0;
  rand uvm_reg_field cmn_diag_tmpsns_ana_ctrl_1;
  rand uvm_reg_field cmn_diag_tmpsns_ana_ctrl_2;
  rand uvm_reg_field cmn_diag_tmpsns_ana_ctrl_3;
  rand uvm_reg_field cmn_diag_tmpsns_ana_ctrl_7_4;
  rand uvm_reg_field cmn_diag_tmpsns_ana_ctrl_11_8;
  rand uvm_reg_field cmn_diag_tmpsns_ana_ctrl_15_12;
  rand uvm_reg_field cmn_diag_tmpsns_ana_ctrl_20_16;
  rand uvm_reg_field cmn_diag_tmpsns_ana_ctrl_21;
  rand uvm_reg_field cmn_diag_tmpsns_ana_ctrl_23_22;
  rand uvm_reg_field cmn_diag_tmpsns_ana_ctrl_24;
  rand uvm_reg_field cmn_diag_tmpsns_ana_ctrl_31_25;
  
  covergroup wr_fld_covg;
    cmn_diag_tmpsns_ana_ctrl_0: coverpoint cmn_diag_tmpsns_ana_ctrl_0.value[0:0];
    cmn_diag_tmpsns_ana_ctrl_1: coverpoint cmn_diag_tmpsns_ana_ctrl_1.value[0:0];
    cmn_diag_tmpsns_ana_ctrl_2: coverpoint cmn_diag_tmpsns_ana_ctrl_2.value[0:0];
    cmn_diag_tmpsns_ana_ctrl_3: coverpoint cmn_diag_tmpsns_ana_ctrl_3.value[0:0];
    cmn_diag_tmpsns_ana_ctrl_7_4: coverpoint cmn_diag_tmpsns_ana_ctrl_7_4.value[3:0];
    cmn_diag_tmpsns_ana_ctrl_11_8: coverpoint cmn_diag_tmpsns_ana_ctrl_11_8.value[3:0];
    cmn_diag_tmpsns_ana_ctrl_15_12: coverpoint cmn_diag_tmpsns_ana_ctrl_15_12.value[3:0];
    cmn_diag_tmpsns_ana_ctrl_20_16: coverpoint cmn_diag_tmpsns_ana_ctrl_20_16.value[4:0];
    cmn_diag_tmpsns_ana_ctrl_21: coverpoint cmn_diag_tmpsns_ana_ctrl_21.value[0:0];
    cmn_diag_tmpsns_ana_ctrl_23_22: coverpoint cmn_diag_tmpsns_ana_ctrl_23_22.value[1:0];
    cmn_diag_tmpsns_ana_ctrl_24: coverpoint cmn_diag_tmpsns_ana_ctrl_24.value[0:0];
    cmn_diag_tmpsns_ana_ctrl_31_25: coverpoint cmn_diag_tmpsns_ana_ctrl_31_25.value[6:0];
  endgroup
  covergroup rd_fld_covg;
    cmn_diag_tmpsns_ana_ctrl_0: coverpoint cmn_diag_tmpsns_ana_ctrl_0.value[0:0];
    cmn_diag_tmpsns_ana_ctrl_1: coverpoint cmn_diag_tmpsns_ana_ctrl_1.value[0:0];
    cmn_diag_tmpsns_ana_ctrl_2: coverpoint cmn_diag_tmpsns_ana_ctrl_2.value[0:0];
    cmn_diag_tmpsns_ana_ctrl_3: coverpoint cmn_diag_tmpsns_ana_ctrl_3.value[0:0];
    cmn_diag_tmpsns_ana_ctrl_7_4: coverpoint cmn_diag_tmpsns_ana_ctrl_7_4.value[3:0];
    cmn_diag_tmpsns_ana_ctrl_11_8: coverpoint cmn_diag_tmpsns_ana_ctrl_11_8.value[3:0];
    cmn_diag_tmpsns_ana_ctrl_15_12: coverpoint cmn_diag_tmpsns_ana_ctrl_15_12.value[3:0];
    cmn_diag_tmpsns_ana_ctrl_20_16: coverpoint cmn_diag_tmpsns_ana_ctrl_20_16.value[4:0];
    cmn_diag_tmpsns_ana_ctrl_21: coverpoint cmn_diag_tmpsns_ana_ctrl_21.value[0:0];
    cmn_diag_tmpsns_ana_ctrl_23_22: coverpoint cmn_diag_tmpsns_ana_ctrl_23_22.value[1:0];
    cmn_diag_tmpsns_ana_ctrl_24: coverpoint cmn_diag_tmpsns_ana_ctrl_24.value[0:0];
    cmn_diag_tmpsns_ana_ctrl_31_25: coverpoint cmn_diag_tmpsns_ana_ctrl_31_25.value[6:0];
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
    
    cmn_diag_tmpsns_ana_ctrl_0 = fld_set[0];
    cmn_diag_tmpsns_ana_ctrl_1 = fld_set[1];
    cmn_diag_tmpsns_ana_ctrl_2 = fld_set[2];
    cmn_diag_tmpsns_ana_ctrl_3 = fld_set[3];
    cmn_diag_tmpsns_ana_ctrl_7_4 = fld_set[4];
    cmn_diag_tmpsns_ana_ctrl_11_8 = fld_set[5];
    cmn_diag_tmpsns_ana_ctrl_15_12 = fld_set[6];
    cmn_diag_tmpsns_ana_ctrl_20_16 = fld_set[7];
    cmn_diag_tmpsns_ana_ctrl_21 = fld_set[8];
    cmn_diag_tmpsns_ana_ctrl_23_22 = fld_set[9];
    cmn_diag_tmpsns_ana_ctrl_24 = fld_set[10];
    cmn_diag_tmpsns_ana_ctrl_31_25 = fld_set[11];
  endfunction

  function new(input string name="T_cmn_diag_tmpsns_ana_ctrl_1180");
    super.new(name, 32, build_coverage(UVM_CVR_FIELD_VALS));
    if (has_coverage(UVM_CVR_FIELD_VALS)) begin
      wr_fld_covg = new();
      rd_fld_covg = new();
    end
  endfunction

endclass


/////////////////////////////////////////////////////
//                cmn_diag_tmpsns_filt_ctrl
/////////////////////////////////////////////////////
class T_cmn_diag_tmpsns_filt_ctrl_1181 extends cdns_uvm_reg;

  `uvm_object_utils(T_cmn_diag_tmpsns_filt_ctrl_1181)
  rand uvm_reg_field cmn_diag_tmpsns_filt_ctrl_13_0;
  rand uvm_reg_field cmn_diag_tmpsns_filt_ctrl_15_14;
  rand uvm_reg_field cmn_diag_tmpsns_filt_ctrl_20_16;
  rand uvm_reg_field cmn_diag_tmpsns_filt_ctrl_27_21;
  rand uvm_reg_field cmn_diag_tmpsns_filt_ctrl_29_28;
  rand uvm_reg_field cmn_diag_tmpsns_filt_ctrl_30;
  rand uvm_reg_field cmn_diag_tmpsns_filt_ctrl_31;
  
  covergroup wr_fld_covg;
    cmn_diag_tmpsns_filt_ctrl_13_0: coverpoint cmn_diag_tmpsns_filt_ctrl_13_0.value[13:0];
    cmn_diag_tmpsns_filt_ctrl_15_14: coverpoint cmn_diag_tmpsns_filt_ctrl_15_14.value[1:0];
    cmn_diag_tmpsns_filt_ctrl_20_16: coverpoint cmn_diag_tmpsns_filt_ctrl_20_16.value[4:0];
    cmn_diag_tmpsns_filt_ctrl_27_21: coverpoint cmn_diag_tmpsns_filt_ctrl_27_21.value[6:0];
    cmn_diag_tmpsns_filt_ctrl_29_28: coverpoint cmn_diag_tmpsns_filt_ctrl_29_28.value[1:0];
    cmn_diag_tmpsns_filt_ctrl_30: coverpoint cmn_diag_tmpsns_filt_ctrl_30.value[0:0];
    cmn_diag_tmpsns_filt_ctrl_31: coverpoint cmn_diag_tmpsns_filt_ctrl_31.value[0:0];
  endgroup
  covergroup rd_fld_covg;
    cmn_diag_tmpsns_filt_ctrl_13_0: coverpoint cmn_diag_tmpsns_filt_ctrl_13_0.value[13:0];
    cmn_diag_tmpsns_filt_ctrl_15_14: coverpoint cmn_diag_tmpsns_filt_ctrl_15_14.value[1:0];
    cmn_diag_tmpsns_filt_ctrl_20_16: coverpoint cmn_diag_tmpsns_filt_ctrl_20_16.value[4:0];
    cmn_diag_tmpsns_filt_ctrl_27_21: coverpoint cmn_diag_tmpsns_filt_ctrl_27_21.value[6:0];
    cmn_diag_tmpsns_filt_ctrl_29_28: coverpoint cmn_diag_tmpsns_filt_ctrl_29_28.value[1:0];
    cmn_diag_tmpsns_filt_ctrl_30: coverpoint cmn_diag_tmpsns_filt_ctrl_30.value[0:0];
    cmn_diag_tmpsns_filt_ctrl_31: coverpoint cmn_diag_tmpsns_filt_ctrl_31.value[0:0];
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
    
    cmn_diag_tmpsns_filt_ctrl_13_0 = fld_set[0];
    cmn_diag_tmpsns_filt_ctrl_15_14 = fld_set[1];
    cmn_diag_tmpsns_filt_ctrl_20_16 = fld_set[2];
    cmn_diag_tmpsns_filt_ctrl_27_21 = fld_set[3];
    cmn_diag_tmpsns_filt_ctrl_29_28 = fld_set[4];
    cmn_diag_tmpsns_filt_ctrl_30 = fld_set[5];
    cmn_diag_tmpsns_filt_ctrl_31 = fld_set[6];
  endfunction

  function new(input string name="T_cmn_diag_tmpsns_filt_ctrl_1181");
    super.new(name, 32, build_coverage(UVM_CVR_FIELD_VALS));
    if (has_coverage(UVM_CVR_FIELD_VALS)) begin
      wr_fld_covg = new();
      rd_fld_covg = new();
    end
  endfunction

endclass


/////////////////////////////////////////////////////
//                cmn_diag_tmpsns_filt_out
/////////////////////////////////////////////////////
class T_cmn_diag_tmpsns_filt_out_1182 extends cdns_uvm_reg;

  `uvm_object_utils(T_cmn_diag_tmpsns_filt_out_1182)
  rand uvm_reg_field cmn_diag_tmpsns_filt_out_15_0;
  rand uvm_reg_field cmn_diag_tmpsns_filt_out_31_16;
  
  covergroup wr_fld_covg;
    cmn_diag_tmpsns_filt_out_15_0: coverpoint cmn_diag_tmpsns_filt_out_15_0.value[15:0];
    cmn_diag_tmpsns_filt_out_31_16: coverpoint cmn_diag_tmpsns_filt_out_31_16.value[15:0];
  endgroup
  covergroup rd_fld_covg;
    cmn_diag_tmpsns_filt_out_15_0: coverpoint cmn_diag_tmpsns_filt_out_15_0.value[15:0];
    cmn_diag_tmpsns_filt_out_31_16: coverpoint cmn_diag_tmpsns_filt_out_31_16.value[15:0];
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
    
    cmn_diag_tmpsns_filt_out_15_0 = fld_set[0];
    cmn_diag_tmpsns_filt_out_31_16 = fld_set[1];
  endfunction

  function new(input string name="T_cmn_diag_tmpsns_filt_out_1182");
    super.new(name, 32, build_coverage(UVM_CVR_FIELD_VALS));
    if (has_coverage(UVM_CVR_FIELD_VALS)) begin
      wr_fld_covg = new();
      rd_fld_covg = new();
    end
  endfunction

endclass


/////////////////////////////////////////////////////
//                cmn_ibcal_ctrl
/////////////////////////////////////////////////////
class T_cmn_ibcal_ctrl_1039 extends cdns_uvm_reg;

  `uvm_object_utils(T_cmn_ibcal_ctrl_1039)
  rand uvm_reg_field cmn_ibcal_ctrl_6_0;
  rand uvm_reg_field cmn_ibcal_ctrl_11_7;
  rand uvm_reg_field cmn_ibcal_ctrl_12;
  rand uvm_reg_field cmn_ibcal_ctrl_13;
  rand uvm_reg_field cmn_ibcal_ctrl_14;
  rand uvm_reg_field cmn_ibcal_ctrl_15;
  rand uvm_reg_field cmn_ibcal_ctrl_31_16;
  
  covergroup wr_fld_covg;
    cmn_ibcal_ctrl_6_0: coverpoint cmn_ibcal_ctrl_6_0.value[6:0];
    cmn_ibcal_ctrl_11_7: coverpoint cmn_ibcal_ctrl_11_7.value[4:0];
    cmn_ibcal_ctrl_12: coverpoint cmn_ibcal_ctrl_12.value[0:0];
    cmn_ibcal_ctrl_13: coverpoint cmn_ibcal_ctrl_13.value[0:0];
    cmn_ibcal_ctrl_14: coverpoint cmn_ibcal_ctrl_14.value[0:0];
    cmn_ibcal_ctrl_15: coverpoint cmn_ibcal_ctrl_15.value[0:0];
    cmn_ibcal_ctrl_31_16: coverpoint cmn_ibcal_ctrl_31_16.value[15:0];
  endgroup
  covergroup rd_fld_covg;
    cmn_ibcal_ctrl_6_0: coverpoint cmn_ibcal_ctrl_6_0.value[6:0];
    cmn_ibcal_ctrl_11_7: coverpoint cmn_ibcal_ctrl_11_7.value[4:0];
    cmn_ibcal_ctrl_12: coverpoint cmn_ibcal_ctrl_12.value[0:0];
    cmn_ibcal_ctrl_13: coverpoint cmn_ibcal_ctrl_13.value[0:0];
    cmn_ibcal_ctrl_14: coverpoint cmn_ibcal_ctrl_14.value[0:0];
    cmn_ibcal_ctrl_15: coverpoint cmn_ibcal_ctrl_15.value[0:0];
    cmn_ibcal_ctrl_31_16: coverpoint cmn_ibcal_ctrl_31_16.value[15:0];
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
    
    cmn_ibcal_ctrl_6_0 = fld_set[0];
    cmn_ibcal_ctrl_11_7 = fld_set[1];
    cmn_ibcal_ctrl_12 = fld_set[2];
    cmn_ibcal_ctrl_13 = fld_set[3];
    cmn_ibcal_ctrl_14 = fld_set[4];
    cmn_ibcal_ctrl_15 = fld_set[5];
    cmn_ibcal_ctrl_31_16 = fld_set[6];
  endfunction

  function new(input string name="T_cmn_ibcal_ctrl_1039");
    super.new(name, 32, build_coverage(UVM_CVR_FIELD_VALS));
    if (has_coverage(UVM_CVR_FIELD_VALS)) begin
      wr_fld_covg = new();
      rd_fld_covg = new();
    end
  endfunction

endclass


/////////////////////////////////////////////////////
//                cmn_ibcal_init_tmr
/////////////////////////////////////////////////////
class T_cmn_ibcal_init_tmr_1043 extends cdns_uvm_reg;

  `uvm_object_utils(T_cmn_ibcal_init_tmr_1043)
  rand uvm_reg_field cmn_ibcal_init_tmr_6_0;
  rand uvm_reg_field cmn_ibcal_init_tmr_15_7;
  rand uvm_reg_field cmn_ibcal_init_tmr_31_16;
  
  covergroup wr_fld_covg;
    cmn_ibcal_init_tmr_6_0: coverpoint cmn_ibcal_init_tmr_6_0.value[6:0];
    cmn_ibcal_init_tmr_15_7: coverpoint cmn_ibcal_init_tmr_15_7.value[8:0];
    cmn_ibcal_init_tmr_31_16: coverpoint cmn_ibcal_init_tmr_31_16.value[15:0];
  endgroup
  covergroup rd_fld_covg;
    cmn_ibcal_init_tmr_6_0: coverpoint cmn_ibcal_init_tmr_6_0.value[6:0];
    cmn_ibcal_init_tmr_15_7: coverpoint cmn_ibcal_init_tmr_15_7.value[8:0];
    cmn_ibcal_init_tmr_31_16: coverpoint cmn_ibcal_init_tmr_31_16.value[15:0];
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
    
    cmn_ibcal_init_tmr_6_0 = fld_set[0];
    cmn_ibcal_init_tmr_15_7 = fld_set[1];
    cmn_ibcal_init_tmr_31_16 = fld_set[2];
  endfunction

  function new(input string name="T_cmn_ibcal_init_tmr_1043");
    super.new(name, 32, build_coverage(UVM_CVR_FIELD_VALS));
    if (has_coverage(UVM_CVR_FIELD_VALS)) begin
      wr_fld_covg = new();
      rd_fld_covg = new();
    end
  endfunction

endclass


/////////////////////////////////////////////////////
//                cmn_ibcal_iter_tmr
/////////////////////////////////////////////////////
class T_cmn_ibcal_iter_tmr_1044 extends cdns_uvm_reg;

  `uvm_object_utils(T_cmn_ibcal_iter_tmr_1044)
  rand uvm_reg_field cmn_ibcal_iter_tmr_6_0;
  rand uvm_reg_field cmn_ibcal_iter_tmr_15_7;
  rand uvm_reg_field cmn_ibcal_iter_tmr_31_16;
  
  covergroup wr_fld_covg;
    cmn_ibcal_iter_tmr_6_0: coverpoint cmn_ibcal_iter_tmr_6_0.value[6:0];
    cmn_ibcal_iter_tmr_15_7: coverpoint cmn_ibcal_iter_tmr_15_7.value[8:0];
    cmn_ibcal_iter_tmr_31_16: coverpoint cmn_ibcal_iter_tmr_31_16.value[15:0];
  endgroup
  covergroup rd_fld_covg;
    cmn_ibcal_iter_tmr_6_0: coverpoint cmn_ibcal_iter_tmr_6_0.value[6:0];
    cmn_ibcal_iter_tmr_15_7: coverpoint cmn_ibcal_iter_tmr_15_7.value[8:0];
    cmn_ibcal_iter_tmr_31_16: coverpoint cmn_ibcal_iter_tmr_31_16.value[15:0];
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
    
    cmn_ibcal_iter_tmr_6_0 = fld_set[0];
    cmn_ibcal_iter_tmr_15_7 = fld_set[1];
    cmn_ibcal_iter_tmr_31_16 = fld_set[2];
  endfunction

  function new(input string name="T_cmn_ibcal_iter_tmr_1044");
    super.new(name, 32, build_coverage(UVM_CVR_FIELD_VALS));
    if (has_coverage(UVM_CVR_FIELD_VALS)) begin
      wr_fld_covg = new();
      rd_fld_covg = new();
    end
  endfunction

endclass


/////////////////////////////////////////////////////
//                cmn_ibcal_ovrd
/////////////////////////////////////////////////////
class T_cmn_ibcal_ovrd_1040 extends cdns_uvm_reg;

  `uvm_object_utils(T_cmn_ibcal_ovrd_1040)
  rand uvm_reg_field cmn_ibcal_ovrd_6_0;
  rand uvm_reg_field cmn_ibcal_ovrd_13_7;
  rand uvm_reg_field cmn_ibcal_ovrd_14;
  rand uvm_reg_field cmn_ibcal_ovrd_15;
  rand uvm_reg_field cmn_ibcal_ovrd_31_16;
  
  covergroup wr_fld_covg;
    cmn_ibcal_ovrd_6_0: coverpoint cmn_ibcal_ovrd_6_0.value[6:0];
    cmn_ibcal_ovrd_13_7: coverpoint cmn_ibcal_ovrd_13_7.value[6:0];
    cmn_ibcal_ovrd_14: coverpoint cmn_ibcal_ovrd_14.value[0:0];
    cmn_ibcal_ovrd_15: coverpoint cmn_ibcal_ovrd_15.value[0:0];
    cmn_ibcal_ovrd_31_16: coverpoint cmn_ibcal_ovrd_31_16.value[15:0];
  endgroup
  covergroup rd_fld_covg;
    cmn_ibcal_ovrd_6_0: coverpoint cmn_ibcal_ovrd_6_0.value[6:0];
    cmn_ibcal_ovrd_13_7: coverpoint cmn_ibcal_ovrd_13_7.value[6:0];
    cmn_ibcal_ovrd_14: coverpoint cmn_ibcal_ovrd_14.value[0:0];
    cmn_ibcal_ovrd_15: coverpoint cmn_ibcal_ovrd_15.value[0:0];
    cmn_ibcal_ovrd_31_16: coverpoint cmn_ibcal_ovrd_31_16.value[15:0];
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
    
    cmn_ibcal_ovrd_6_0 = fld_set[0];
    cmn_ibcal_ovrd_13_7 = fld_set[1];
    cmn_ibcal_ovrd_14 = fld_set[2];
    cmn_ibcal_ovrd_15 = fld_set[3];
    cmn_ibcal_ovrd_31_16 = fld_set[4];
  endfunction

  function new(input string name="T_cmn_ibcal_ovrd_1040");
    super.new(name, 32, build_coverage(UVM_CVR_FIELD_VALS));
    if (has_coverage(UVM_CVR_FIELD_VALS)) begin
      wr_fld_covg = new();
      rd_fld_covg = new();
    end
  endfunction

endclass


/////////////////////////////////////////////////////
//                cmn_ibcal_start
/////////////////////////////////////////////////////
class T_cmn_ibcal_start_1041 extends cdns_uvm_reg;

  `uvm_object_utils(T_cmn_ibcal_start_1041)
  rand uvm_reg_field cmn_ibcal_start_6_0;
  rand uvm_reg_field cmn_ibcal_start_14_7;
  rand uvm_reg_field cmn_ibcal_start_15;
  rand uvm_reg_field cmn_ibcal_start_31_16;
  
  covergroup wr_fld_covg;
    cmn_ibcal_start_6_0: coverpoint cmn_ibcal_start_6_0.value[6:0];
    cmn_ibcal_start_14_7: coverpoint cmn_ibcal_start_14_7.value[7:0];
    cmn_ibcal_start_15: coverpoint cmn_ibcal_start_15.value[0:0];
    cmn_ibcal_start_31_16: coverpoint cmn_ibcal_start_31_16.value[15:0];
  endgroup
  covergroup rd_fld_covg;
    cmn_ibcal_start_6_0: coverpoint cmn_ibcal_start_6_0.value[6:0];
    cmn_ibcal_start_14_7: coverpoint cmn_ibcal_start_14_7.value[7:0];
    cmn_ibcal_start_15: coverpoint cmn_ibcal_start_15.value[0:0];
    cmn_ibcal_start_31_16: coverpoint cmn_ibcal_start_31_16.value[15:0];
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
    
    cmn_ibcal_start_6_0 = fld_set[0];
    cmn_ibcal_start_14_7 = fld_set[1];
    cmn_ibcal_start_15 = fld_set[2];
    cmn_ibcal_start_31_16 = fld_set[3];
  endfunction

  function new(input string name="T_cmn_ibcal_start_1041");
    super.new(name, 32, build_coverage(UVM_CVR_FIELD_VALS));
    if (has_coverage(UVM_CVR_FIELD_VALS)) begin
      wr_fld_covg = new();
      rd_fld_covg = new();
    end
  endfunction

endclass


/////////////////////////////////////////////////////
//                cmn_ibcal_tune
/////////////////////////////////////////////////////
class T_cmn_ibcal_tune_1042 extends cdns_uvm_reg;

  `uvm_object_utils(T_cmn_ibcal_tune_1042)
  rand uvm_reg_field cmn_ibcal_tune_6_0;
  rand uvm_reg_field cmn_ibcal_tune_15_7;
  rand uvm_reg_field cmn_ibcal_tune_31_16;
  
  covergroup wr_fld_covg;
    cmn_ibcal_tune_6_0: coverpoint cmn_ibcal_tune_6_0.value[6:0];
    cmn_ibcal_tune_15_7: coverpoint cmn_ibcal_tune_15_7.value[8:0];
    cmn_ibcal_tune_31_16: coverpoint cmn_ibcal_tune_31_16.value[15:0];
  endgroup
  covergroup rd_fld_covg;
    cmn_ibcal_tune_6_0: coverpoint cmn_ibcal_tune_6_0.value[6:0];
    cmn_ibcal_tune_15_7: coverpoint cmn_ibcal_tune_15_7.value[8:0];
    cmn_ibcal_tune_31_16: coverpoint cmn_ibcal_tune_31_16.value[15:0];
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
    
    cmn_ibcal_tune_6_0 = fld_set[0];
    cmn_ibcal_tune_15_7 = fld_set[1];
    cmn_ibcal_tune_31_16 = fld_set[2];
  endfunction

  function new(input string name="T_cmn_ibcal_tune_1042");
    super.new(name, 32, build_coverage(UVM_CVR_FIELD_VALS));
    if (has_coverage(UVM_CVR_FIELD_VALS)) begin
      wr_fld_covg = new();
      rd_fld_covg = new();
    end
  endfunction

endclass


/////////////////////////////////////////////////////
//                cmn_pdiag_pll0_cp_iadj_m0
/////////////////////////////////////////////////////
class T_cmn_pdiag_pll0_cp_iadj_m0_1130 extends cdns_uvm_reg;

  `uvm_object_utils(T_cmn_pdiag_pll0_cp_iadj_m0_1130)
  rand uvm_reg_field cmn_pdiag_pll0_cp_iadj_m0_4_0;
  rand uvm_reg_field cmn_pdiag_pll0_cp_iadj_m0_7_5;
  rand uvm_reg_field cmn_pdiag_pll0_cp_iadj_m0_11_8;
  rand uvm_reg_field cmn_pdiag_pll0_cp_iadj_m0_31_12;
  
  covergroup wr_fld_covg;
    cmn_pdiag_pll0_cp_iadj_m0_4_0: coverpoint cmn_pdiag_pll0_cp_iadj_m0_4_0.value[4:0];
    cmn_pdiag_pll0_cp_iadj_m0_7_5: coverpoint cmn_pdiag_pll0_cp_iadj_m0_7_5.value[2:0];
    cmn_pdiag_pll0_cp_iadj_m0_11_8: coverpoint cmn_pdiag_pll0_cp_iadj_m0_11_8.value[3:0];
    cmn_pdiag_pll0_cp_iadj_m0_31_12: coverpoint cmn_pdiag_pll0_cp_iadj_m0_31_12.value[19:0];
  endgroup
  covergroup rd_fld_covg;
    cmn_pdiag_pll0_cp_iadj_m0_4_0: coverpoint cmn_pdiag_pll0_cp_iadj_m0_4_0.value[4:0];
    cmn_pdiag_pll0_cp_iadj_m0_7_5: coverpoint cmn_pdiag_pll0_cp_iadj_m0_7_5.value[2:0];
    cmn_pdiag_pll0_cp_iadj_m0_11_8: coverpoint cmn_pdiag_pll0_cp_iadj_m0_11_8.value[3:0];
    cmn_pdiag_pll0_cp_iadj_m0_31_12: coverpoint cmn_pdiag_pll0_cp_iadj_m0_31_12.value[19:0];
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
    
    cmn_pdiag_pll0_cp_iadj_m0_4_0 = fld_set[0];
    cmn_pdiag_pll0_cp_iadj_m0_7_5 = fld_set[1];
    cmn_pdiag_pll0_cp_iadj_m0_11_8 = fld_set[2];
    cmn_pdiag_pll0_cp_iadj_m0_31_12 = fld_set[3];
  endfunction

  function new(input string name="T_cmn_pdiag_pll0_cp_iadj_m0_1130");
    super.new(name, 32, build_coverage(UVM_CVR_FIELD_VALS));
    if (has_coverage(UVM_CVR_FIELD_VALS)) begin
      wr_fld_covg = new();
      rd_fld_covg = new();
    end
  endfunction

endclass


/////////////////////////////////////////////////////
//                cmn_pdiag_pll0_cp_iadj_m1
/////////////////////////////////////////////////////
class T_cmn_pdiag_pll0_cp_iadj_m1_1139 extends cdns_uvm_reg;

  `uvm_object_utils(T_cmn_pdiag_pll0_cp_iadj_m1_1139)
  rand uvm_reg_field cmn_pdiag_pll0_cp_iadj_m1_7_0;
  rand uvm_reg_field cmn_pdiag_pll0_cp_iadj_m1_15_8;
  rand uvm_reg_field cmn_pdiag_pll0_cp_iadj_m1_31_16;
  
  covergroup wr_fld_covg;
    cmn_pdiag_pll0_cp_iadj_m1_7_0: coverpoint cmn_pdiag_pll0_cp_iadj_m1_7_0.value[7:0];
    cmn_pdiag_pll0_cp_iadj_m1_15_8: coverpoint cmn_pdiag_pll0_cp_iadj_m1_15_8.value[7:0];
    cmn_pdiag_pll0_cp_iadj_m1_31_16: coverpoint cmn_pdiag_pll0_cp_iadj_m1_31_16.value[15:0];
  endgroup
  covergroup rd_fld_covg;
    cmn_pdiag_pll0_cp_iadj_m1_7_0: coverpoint cmn_pdiag_pll0_cp_iadj_m1_7_0.value[7:0];
    cmn_pdiag_pll0_cp_iadj_m1_15_8: coverpoint cmn_pdiag_pll0_cp_iadj_m1_15_8.value[7:0];
    cmn_pdiag_pll0_cp_iadj_m1_31_16: coverpoint cmn_pdiag_pll0_cp_iadj_m1_31_16.value[15:0];
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
    
    cmn_pdiag_pll0_cp_iadj_m1_7_0 = fld_set[0];
    cmn_pdiag_pll0_cp_iadj_m1_15_8 = fld_set[1];
    cmn_pdiag_pll0_cp_iadj_m1_31_16 = fld_set[2];
  endfunction

  function new(input string name="T_cmn_pdiag_pll0_cp_iadj_m1_1139");
    super.new(name, 32, build_coverage(UVM_CVR_FIELD_VALS));
    if (has_coverage(UVM_CVR_FIELD_VALS)) begin
      wr_fld_covg = new();
      rd_fld_covg = new();
    end
  endfunction

endclass


/////////////////////////////////////////////////////
//                cmn_pdiag_pll0_cp_padj_m0
/////////////////////////////////////////////////////
class T_cmn_pdiag_pll0_cp_padj_m0_1129 extends cdns_uvm_reg;

  `uvm_object_utils(T_cmn_pdiag_pll0_cp_padj_m0_1129)
  rand uvm_reg_field cmn_pdiag_pll0_cp_padj_m0_7_0;
  rand uvm_reg_field cmn_pdiag_pll0_cp_padj_m0_12_8;
  rand uvm_reg_field cmn_pdiag_pll0_cp_padj_m0_31_13;
  
  covergroup wr_fld_covg;
    cmn_pdiag_pll0_cp_padj_m0_7_0: coverpoint cmn_pdiag_pll0_cp_padj_m0_7_0.value[7:0];
    cmn_pdiag_pll0_cp_padj_m0_12_8: coverpoint cmn_pdiag_pll0_cp_padj_m0_12_8.value[4:0];
    cmn_pdiag_pll0_cp_padj_m0_31_13: coverpoint cmn_pdiag_pll0_cp_padj_m0_31_13.value[18:0];
  endgroup
  covergroup rd_fld_covg;
    cmn_pdiag_pll0_cp_padj_m0_7_0: coverpoint cmn_pdiag_pll0_cp_padj_m0_7_0.value[7:0];
    cmn_pdiag_pll0_cp_padj_m0_12_8: coverpoint cmn_pdiag_pll0_cp_padj_m0_12_8.value[4:0];
    cmn_pdiag_pll0_cp_padj_m0_31_13: coverpoint cmn_pdiag_pll0_cp_padj_m0_31_13.value[18:0];
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
    
    cmn_pdiag_pll0_cp_padj_m0_7_0 = fld_set[0];
    cmn_pdiag_pll0_cp_padj_m0_12_8 = fld_set[1];
    cmn_pdiag_pll0_cp_padj_m0_31_13 = fld_set[2];
  endfunction

  function new(input string name="T_cmn_pdiag_pll0_cp_padj_m0_1129");
    super.new(name, 32, build_coverage(UVM_CVR_FIELD_VALS));
    if (has_coverage(UVM_CVR_FIELD_VALS)) begin
      wr_fld_covg = new();
      rd_fld_covg = new();
    end
  endfunction

endclass


/////////////////////////////////////////////////////
//                cmn_pdiag_pll0_cp_padj_m1
/////////////////////////////////////////////////////
class T_cmn_pdiag_pll0_cp_padj_m1_1138 extends cdns_uvm_reg;

  `uvm_object_utils(T_cmn_pdiag_pll0_cp_padj_m1_1138)
  rand uvm_reg_field cmn_pdiag_pll0_cp_padj_m1_7_0;
  rand uvm_reg_field cmn_pdiag_pll0_cp_padj_m1_15_8;
  rand uvm_reg_field cmn_pdiag_pll0_cp_padj_m1_31_16;
  
  covergroup wr_fld_covg;
    cmn_pdiag_pll0_cp_padj_m1_7_0: coverpoint cmn_pdiag_pll0_cp_padj_m1_7_0.value[7:0];
    cmn_pdiag_pll0_cp_padj_m1_15_8: coverpoint cmn_pdiag_pll0_cp_padj_m1_15_8.value[7:0];
    cmn_pdiag_pll0_cp_padj_m1_31_16: coverpoint cmn_pdiag_pll0_cp_padj_m1_31_16.value[15:0];
  endgroup
  covergroup rd_fld_covg;
    cmn_pdiag_pll0_cp_padj_m1_7_0: coverpoint cmn_pdiag_pll0_cp_padj_m1_7_0.value[7:0];
    cmn_pdiag_pll0_cp_padj_m1_15_8: coverpoint cmn_pdiag_pll0_cp_padj_m1_15_8.value[7:0];
    cmn_pdiag_pll0_cp_padj_m1_31_16: coverpoint cmn_pdiag_pll0_cp_padj_m1_31_16.value[15:0];
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
    
    cmn_pdiag_pll0_cp_padj_m1_7_0 = fld_set[0];
    cmn_pdiag_pll0_cp_padj_m1_15_8 = fld_set[1];
    cmn_pdiag_pll0_cp_padj_m1_31_16 = fld_set[2];
  endfunction

  function new(input string name="T_cmn_pdiag_pll0_cp_padj_m1_1138");
    super.new(name, 32, build_coverage(UVM_CVR_FIELD_VALS));
    if (has_coverage(UVM_CVR_FIELD_VALS)) begin
      wr_fld_covg = new();
      rd_fld_covg = new();
    end
  endfunction

endclass


/////////////////////////////////////////////////////
//                cmn_pdiag_pll0_ctrl_m0
/////////////////////////////////////////////////////
class T_cmn_pdiag_pll0_ctrl_m0_1126 extends cdns_uvm_reg;

  `uvm_object_utils(T_cmn_pdiag_pll0_ctrl_m0_1126)
  rand uvm_reg_field cmn_pdiag_pll0_ctrl_m0_1_0;
  rand uvm_reg_field cmn_pdiag_pll0_ctrl_m0_3_2;
  rand uvm_reg_field cmn_pdiag_pll0_ctrl_m0_4;
  rand uvm_reg_field cmn_pdiag_pll0_ctrl_m0_5;
  rand uvm_reg_field cmn_pdiag_pll0_ctrl_m0_6;
  rand uvm_reg_field cmn_pdiag_pll0_ctrl_m0_7;
  rand uvm_reg_field cmn_pdiag_pll0_ctrl_m0_8;
  rand uvm_reg_field cmn_pdiag_pll0_ctrl_m0_9;
  rand uvm_reg_field cmn_pdiag_pll0_ctrl_m0_11_10;
  rand uvm_reg_field cmn_pdiag_pll0_ctrl_m0_12;
  rand uvm_reg_field cmn_pdiag_pll0_ctrl_m0_13;
  rand uvm_reg_field cmn_pdiag_pll0_ctrl_m0_14;
  rand uvm_reg_field cmn_pdiag_pll0_ctrl_m0_15;
  rand uvm_reg_field cmn_pdiag_pll0_ctrl_m0_31_16;
  
  covergroup wr_fld_covg;
    cmn_pdiag_pll0_ctrl_m0_1_0: coverpoint cmn_pdiag_pll0_ctrl_m0_1_0.value[1:0];
    cmn_pdiag_pll0_ctrl_m0_3_2: coverpoint cmn_pdiag_pll0_ctrl_m0_3_2.value[1:0];
    cmn_pdiag_pll0_ctrl_m0_4: coverpoint cmn_pdiag_pll0_ctrl_m0_4.value[0:0];
    cmn_pdiag_pll0_ctrl_m0_5: coverpoint cmn_pdiag_pll0_ctrl_m0_5.value[0:0];
    cmn_pdiag_pll0_ctrl_m0_6: coverpoint cmn_pdiag_pll0_ctrl_m0_6.value[0:0];
    cmn_pdiag_pll0_ctrl_m0_7: coverpoint cmn_pdiag_pll0_ctrl_m0_7.value[0:0];
    cmn_pdiag_pll0_ctrl_m0_8: coverpoint cmn_pdiag_pll0_ctrl_m0_8.value[0:0];
    cmn_pdiag_pll0_ctrl_m0_9: coverpoint cmn_pdiag_pll0_ctrl_m0_9.value[0:0];
    cmn_pdiag_pll0_ctrl_m0_11_10: coverpoint cmn_pdiag_pll0_ctrl_m0_11_10.value[1:0];
    cmn_pdiag_pll0_ctrl_m0_12: coverpoint cmn_pdiag_pll0_ctrl_m0_12.value[0:0];
    cmn_pdiag_pll0_ctrl_m0_13: coverpoint cmn_pdiag_pll0_ctrl_m0_13.value[0:0];
    cmn_pdiag_pll0_ctrl_m0_14: coverpoint cmn_pdiag_pll0_ctrl_m0_14.value[0:0];
    cmn_pdiag_pll0_ctrl_m0_15: coverpoint cmn_pdiag_pll0_ctrl_m0_15.value[0:0];
    cmn_pdiag_pll0_ctrl_m0_31_16: coverpoint cmn_pdiag_pll0_ctrl_m0_31_16.value[15:0];
  endgroup
  covergroup rd_fld_covg;
    cmn_pdiag_pll0_ctrl_m0_1_0: coverpoint cmn_pdiag_pll0_ctrl_m0_1_0.value[1:0];
    cmn_pdiag_pll0_ctrl_m0_3_2: coverpoint cmn_pdiag_pll0_ctrl_m0_3_2.value[1:0];
    cmn_pdiag_pll0_ctrl_m0_4: coverpoint cmn_pdiag_pll0_ctrl_m0_4.value[0:0];
    cmn_pdiag_pll0_ctrl_m0_5: coverpoint cmn_pdiag_pll0_ctrl_m0_5.value[0:0];
    cmn_pdiag_pll0_ctrl_m0_6: coverpoint cmn_pdiag_pll0_ctrl_m0_6.value[0:0];
    cmn_pdiag_pll0_ctrl_m0_7: coverpoint cmn_pdiag_pll0_ctrl_m0_7.value[0:0];
    cmn_pdiag_pll0_ctrl_m0_8: coverpoint cmn_pdiag_pll0_ctrl_m0_8.value[0:0];
    cmn_pdiag_pll0_ctrl_m0_9: coverpoint cmn_pdiag_pll0_ctrl_m0_9.value[0:0];
    cmn_pdiag_pll0_ctrl_m0_11_10: coverpoint cmn_pdiag_pll0_ctrl_m0_11_10.value[1:0];
    cmn_pdiag_pll0_ctrl_m0_12: coverpoint cmn_pdiag_pll0_ctrl_m0_12.value[0:0];
    cmn_pdiag_pll0_ctrl_m0_13: coverpoint cmn_pdiag_pll0_ctrl_m0_13.value[0:0];
    cmn_pdiag_pll0_ctrl_m0_14: coverpoint cmn_pdiag_pll0_ctrl_m0_14.value[0:0];
    cmn_pdiag_pll0_ctrl_m0_15: coverpoint cmn_pdiag_pll0_ctrl_m0_15.value[0:0];
    cmn_pdiag_pll0_ctrl_m0_31_16: coverpoint cmn_pdiag_pll0_ctrl_m0_31_16.value[15:0];
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
    
    cmn_pdiag_pll0_ctrl_m0_1_0 = fld_set[0];
    cmn_pdiag_pll0_ctrl_m0_3_2 = fld_set[1];
    cmn_pdiag_pll0_ctrl_m0_4 = fld_set[2];
    cmn_pdiag_pll0_ctrl_m0_5 = fld_set[3];
    cmn_pdiag_pll0_ctrl_m0_6 = fld_set[4];
    cmn_pdiag_pll0_ctrl_m0_7 = fld_set[5];
    cmn_pdiag_pll0_ctrl_m0_8 = fld_set[6];
    cmn_pdiag_pll0_ctrl_m0_9 = fld_set[7];
    cmn_pdiag_pll0_ctrl_m0_11_10 = fld_set[8];
    cmn_pdiag_pll0_ctrl_m0_12 = fld_set[9];
    cmn_pdiag_pll0_ctrl_m0_13 = fld_set[10];
    cmn_pdiag_pll0_ctrl_m0_14 = fld_set[11];
    cmn_pdiag_pll0_ctrl_m0_15 = fld_set[12];
    cmn_pdiag_pll0_ctrl_m0_31_16 = fld_set[13];
  endfunction

  function new(input string name="T_cmn_pdiag_pll0_ctrl_m0_1126");
    super.new(name, 32, build_coverage(UVM_CVR_FIELD_VALS));
    if (has_coverage(UVM_CVR_FIELD_VALS)) begin
      wr_fld_covg = new();
      rd_fld_covg = new();
    end
  endfunction

endclass


/////////////////////////////////////////////////////
//                cmn_pdiag_pll0_ctrl_m1
/////////////////////////////////////////////////////
class T_cmn_pdiag_pll0_ctrl_m1_1135 extends cdns_uvm_reg;

  `uvm_object_utils(T_cmn_pdiag_pll0_ctrl_m1_1135)
  rand uvm_reg_field cmn_pdiag_pll0_ctrl_m1_1_0;
  rand uvm_reg_field cmn_pdiag_pll0_ctrl_m1_3_2;
  rand uvm_reg_field cmn_pdiag_pll0_ctrl_m1_4;
  rand uvm_reg_field cmn_pdiag_pll0_ctrl_m1_5;
  rand uvm_reg_field cmn_pdiag_pll0_ctrl_m1_6;
  rand uvm_reg_field cmn_pdiag_pll0_ctrl_m1_7;
  rand uvm_reg_field cmn_pdiag_pll0_ctrl_m1_8;
  rand uvm_reg_field cmn_pdiag_pll0_ctrl_m1_9;
  rand uvm_reg_field cmn_pdiag_pll0_ctrl_m1_11_10;
  rand uvm_reg_field cmn_pdiag_pll0_ctrl_m1_12;
  rand uvm_reg_field cmn_pdiag_pll0_ctrl_m1_13;
  rand uvm_reg_field cmn_pdiag_pll0_ctrl_m1_14;
  rand uvm_reg_field cmn_pdiag_pll0_ctrl_m1_15;
  rand uvm_reg_field cmn_pdiag_pll0_ctrl_m1_31_16;
  
  covergroup wr_fld_covg;
    cmn_pdiag_pll0_ctrl_m1_1_0: coverpoint cmn_pdiag_pll0_ctrl_m1_1_0.value[1:0];
    cmn_pdiag_pll0_ctrl_m1_3_2: coverpoint cmn_pdiag_pll0_ctrl_m1_3_2.value[1:0];
    cmn_pdiag_pll0_ctrl_m1_4: coverpoint cmn_pdiag_pll0_ctrl_m1_4.value[0:0];
    cmn_pdiag_pll0_ctrl_m1_5: coverpoint cmn_pdiag_pll0_ctrl_m1_5.value[0:0];
    cmn_pdiag_pll0_ctrl_m1_6: coverpoint cmn_pdiag_pll0_ctrl_m1_6.value[0:0];
    cmn_pdiag_pll0_ctrl_m1_7: coverpoint cmn_pdiag_pll0_ctrl_m1_7.value[0:0];
    cmn_pdiag_pll0_ctrl_m1_8: coverpoint cmn_pdiag_pll0_ctrl_m1_8.value[0:0];
    cmn_pdiag_pll0_ctrl_m1_9: coverpoint cmn_pdiag_pll0_ctrl_m1_9.value[0:0];
    cmn_pdiag_pll0_ctrl_m1_11_10: coverpoint cmn_pdiag_pll0_ctrl_m1_11_10.value[1:0];
    cmn_pdiag_pll0_ctrl_m1_12: coverpoint cmn_pdiag_pll0_ctrl_m1_12.value[0:0];
    cmn_pdiag_pll0_ctrl_m1_13: coverpoint cmn_pdiag_pll0_ctrl_m1_13.value[0:0];
    cmn_pdiag_pll0_ctrl_m1_14: coverpoint cmn_pdiag_pll0_ctrl_m1_14.value[0:0];
    cmn_pdiag_pll0_ctrl_m1_15: coverpoint cmn_pdiag_pll0_ctrl_m1_15.value[0:0];
    cmn_pdiag_pll0_ctrl_m1_31_16: coverpoint cmn_pdiag_pll0_ctrl_m1_31_16.value[15:0];
  endgroup
  covergroup rd_fld_covg;
    cmn_pdiag_pll0_ctrl_m1_1_0: coverpoint cmn_pdiag_pll0_ctrl_m1_1_0.value[1:0];
    cmn_pdiag_pll0_ctrl_m1_3_2: coverpoint cmn_pdiag_pll0_ctrl_m1_3_2.value[1:0];
    cmn_pdiag_pll0_ctrl_m1_4: coverpoint cmn_pdiag_pll0_ctrl_m1_4.value[0:0];
    cmn_pdiag_pll0_ctrl_m1_5: coverpoint cmn_pdiag_pll0_ctrl_m1_5.value[0:0];
    cmn_pdiag_pll0_ctrl_m1_6: coverpoint cmn_pdiag_pll0_ctrl_m1_6.value[0:0];
    cmn_pdiag_pll0_ctrl_m1_7: coverpoint cmn_pdiag_pll0_ctrl_m1_7.value[0:0];
    cmn_pdiag_pll0_ctrl_m1_8: coverpoint cmn_pdiag_pll0_ctrl_m1_8.value[0:0];
    cmn_pdiag_pll0_ctrl_m1_9: coverpoint cmn_pdiag_pll0_ctrl_m1_9.value[0:0];
    cmn_pdiag_pll0_ctrl_m1_11_10: coverpoint cmn_pdiag_pll0_ctrl_m1_11_10.value[1:0];
    cmn_pdiag_pll0_ctrl_m1_12: coverpoint cmn_pdiag_pll0_ctrl_m1_12.value[0:0];
    cmn_pdiag_pll0_ctrl_m1_13: coverpoint cmn_pdiag_pll0_ctrl_m1_13.value[0:0];
    cmn_pdiag_pll0_ctrl_m1_14: coverpoint cmn_pdiag_pll0_ctrl_m1_14.value[0:0];
    cmn_pdiag_pll0_ctrl_m1_15: coverpoint cmn_pdiag_pll0_ctrl_m1_15.value[0:0];
    cmn_pdiag_pll0_ctrl_m1_31_16: coverpoint cmn_pdiag_pll0_ctrl_m1_31_16.value[15:0];
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
    
    cmn_pdiag_pll0_ctrl_m1_1_0 = fld_set[0];
    cmn_pdiag_pll0_ctrl_m1_3_2 = fld_set[1];
    cmn_pdiag_pll0_ctrl_m1_4 = fld_set[2];
    cmn_pdiag_pll0_ctrl_m1_5 = fld_set[3];
    cmn_pdiag_pll0_ctrl_m1_6 = fld_set[4];
    cmn_pdiag_pll0_ctrl_m1_7 = fld_set[5];
    cmn_pdiag_pll0_ctrl_m1_8 = fld_set[6];
    cmn_pdiag_pll0_ctrl_m1_9 = fld_set[7];
    cmn_pdiag_pll0_ctrl_m1_11_10 = fld_set[8];
    cmn_pdiag_pll0_ctrl_m1_12 = fld_set[9];
    cmn_pdiag_pll0_ctrl_m1_13 = fld_set[10];
    cmn_pdiag_pll0_ctrl_m1_14 = fld_set[11];
    cmn_pdiag_pll0_ctrl_m1_15 = fld_set[12];
    cmn_pdiag_pll0_ctrl_m1_31_16 = fld_set[13];
  endfunction

  function new(input string name="T_cmn_pdiag_pll0_ctrl_m1_1135");
    super.new(name, 32, build_coverage(UVM_CVR_FIELD_VALS));
    if (has_coverage(UVM_CVR_FIELD_VALS)) begin
      wr_fld_covg = new();
      rd_fld_covg = new();
    end
  endfunction

endclass


/////////////////////////////////////////////////////
//                cmn_pdiag_pll0_filt_padj_m0
/////////////////////////////////////////////////////
class T_cmn_pdiag_pll0_filt_padj_m0_1131 extends cdns_uvm_reg;

  `uvm_object_utils(T_cmn_pdiag_pll0_filt_padj_m0_1131)
  rand uvm_reg_field cmn_pdiag_pll0_filt_padj_m0_3_0;
  rand uvm_reg_field cmn_pdiag_pll0_filt_padj_m0_7_4;
  rand uvm_reg_field cmn_pdiag_pll0_filt_padj_m0_12_8;
  rand uvm_reg_field cmn_pdiag_pll0_filt_padj_m0_15_13;
  rand uvm_reg_field cmn_pdiag_pll0_filt_padj_m0_16;
  rand uvm_reg_field cmn_pdiag_pll0_filt_padj_m0_31_17;
  
  covergroup wr_fld_covg;
    cmn_pdiag_pll0_filt_padj_m0_3_0: coverpoint cmn_pdiag_pll0_filt_padj_m0_3_0.value[3:0];
    cmn_pdiag_pll0_filt_padj_m0_7_4: coverpoint cmn_pdiag_pll0_filt_padj_m0_7_4.value[3:0];
    cmn_pdiag_pll0_filt_padj_m0_12_8: coverpoint cmn_pdiag_pll0_filt_padj_m0_12_8.value[4:0];
    cmn_pdiag_pll0_filt_padj_m0_15_13: coverpoint cmn_pdiag_pll0_filt_padj_m0_15_13.value[2:0];
    cmn_pdiag_pll0_filt_padj_m0_16: coverpoint cmn_pdiag_pll0_filt_padj_m0_16.value[0:0];
    cmn_pdiag_pll0_filt_padj_m0_31_17: coverpoint cmn_pdiag_pll0_filt_padj_m0_31_17.value[14:0];
  endgroup
  covergroup rd_fld_covg;
    cmn_pdiag_pll0_filt_padj_m0_3_0: coverpoint cmn_pdiag_pll0_filt_padj_m0_3_0.value[3:0];
    cmn_pdiag_pll0_filt_padj_m0_7_4: coverpoint cmn_pdiag_pll0_filt_padj_m0_7_4.value[3:0];
    cmn_pdiag_pll0_filt_padj_m0_12_8: coverpoint cmn_pdiag_pll0_filt_padj_m0_12_8.value[4:0];
    cmn_pdiag_pll0_filt_padj_m0_15_13: coverpoint cmn_pdiag_pll0_filt_padj_m0_15_13.value[2:0];
    cmn_pdiag_pll0_filt_padj_m0_16: coverpoint cmn_pdiag_pll0_filt_padj_m0_16.value[0:0];
    cmn_pdiag_pll0_filt_padj_m0_31_17: coverpoint cmn_pdiag_pll0_filt_padj_m0_31_17.value[14:0];
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
    
    cmn_pdiag_pll0_filt_padj_m0_3_0 = fld_set[0];
    cmn_pdiag_pll0_filt_padj_m0_7_4 = fld_set[1];
    cmn_pdiag_pll0_filt_padj_m0_12_8 = fld_set[2];
    cmn_pdiag_pll0_filt_padj_m0_15_13 = fld_set[3];
    cmn_pdiag_pll0_filt_padj_m0_16 = fld_set[4];
    cmn_pdiag_pll0_filt_padj_m0_31_17 = fld_set[5];
  endfunction

  function new(input string name="T_cmn_pdiag_pll0_filt_padj_m0_1131");
    super.new(name, 32, build_coverage(UVM_CVR_FIELD_VALS));
    if (has_coverage(UVM_CVR_FIELD_VALS)) begin
      wr_fld_covg = new();
      rd_fld_covg = new();
    end
  endfunction

endclass


/////////////////////////////////////////////////////
//                cmn_pdiag_pll0_filt_padj_m1
/////////////////////////////////////////////////////
class T_cmn_pdiag_pll0_filt_padj_m1_1140 extends cdns_uvm_reg;

  `uvm_object_utils(T_cmn_pdiag_pll0_filt_padj_m1_1140)
  rand uvm_reg_field cmn_pdiag_pll0_filt_padj_m1_3_0;
  rand uvm_reg_field cmn_pdiag_pll0_filt_padj_m1_7_4;
  rand uvm_reg_field cmn_pdiag_pll0_filt_padj_m1_12_8;
  rand uvm_reg_field cmn_pdiag_pll0_filt_padj_m1_15_13;
  rand uvm_reg_field cmn_pdiag_pll0_filt_padj_m1_16;
  rand uvm_reg_field cmn_pdiag_pll0_filt_padj_m1_31_17;
  
  covergroup wr_fld_covg;
    cmn_pdiag_pll0_filt_padj_m1_3_0: coverpoint cmn_pdiag_pll0_filt_padj_m1_3_0.value[3:0];
    cmn_pdiag_pll0_filt_padj_m1_7_4: coverpoint cmn_pdiag_pll0_filt_padj_m1_7_4.value[3:0];
    cmn_pdiag_pll0_filt_padj_m1_12_8: coverpoint cmn_pdiag_pll0_filt_padj_m1_12_8.value[4:0];
    cmn_pdiag_pll0_filt_padj_m1_15_13: coverpoint cmn_pdiag_pll0_filt_padj_m1_15_13.value[2:0];
    cmn_pdiag_pll0_filt_padj_m1_16: coverpoint cmn_pdiag_pll0_filt_padj_m1_16.value[0:0];
    cmn_pdiag_pll0_filt_padj_m1_31_17: coverpoint cmn_pdiag_pll0_filt_padj_m1_31_17.value[14:0];
  endgroup
  covergroup rd_fld_covg;
    cmn_pdiag_pll0_filt_padj_m1_3_0: coverpoint cmn_pdiag_pll0_filt_padj_m1_3_0.value[3:0];
    cmn_pdiag_pll0_filt_padj_m1_7_4: coverpoint cmn_pdiag_pll0_filt_padj_m1_7_4.value[3:0];
    cmn_pdiag_pll0_filt_padj_m1_12_8: coverpoint cmn_pdiag_pll0_filt_padj_m1_12_8.value[4:0];
    cmn_pdiag_pll0_filt_padj_m1_15_13: coverpoint cmn_pdiag_pll0_filt_padj_m1_15_13.value[2:0];
    cmn_pdiag_pll0_filt_padj_m1_16: coverpoint cmn_pdiag_pll0_filt_padj_m1_16.value[0:0];
    cmn_pdiag_pll0_filt_padj_m1_31_17: coverpoint cmn_pdiag_pll0_filt_padj_m1_31_17.value[14:0];
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
    
    cmn_pdiag_pll0_filt_padj_m1_3_0 = fld_set[0];
    cmn_pdiag_pll0_filt_padj_m1_7_4 = fld_set[1];
    cmn_pdiag_pll0_filt_padj_m1_12_8 = fld_set[2];
    cmn_pdiag_pll0_filt_padj_m1_15_13 = fld_set[3];
    cmn_pdiag_pll0_filt_padj_m1_16 = fld_set[4];
    cmn_pdiag_pll0_filt_padj_m1_31_17 = fld_set[5];
  endfunction

  function new(input string name="T_cmn_pdiag_pll0_filt_padj_m1_1140");
    super.new(name, 32, build_coverage(UVM_CVR_FIELD_VALS));
    if (has_coverage(UVM_CVR_FIELD_VALS)) begin
      wr_fld_covg = new();
      rd_fld_covg = new();
    end
  endfunction

endclass


/////////////////////////////////////////////////////
//                cmn_pdiag_pll0_pkvco_bw_ctrl_m0
/////////////////////////////////////////////////////
class T_cmn_pdiag_pll0_pkvco_bw_ctrl_m0_1128 extends cdns_uvm_reg;

  `uvm_object_utils(T_cmn_pdiag_pll0_pkvco_bw_ctrl_m0_1128)
  rand uvm_reg_field cmn_pdiag_pll0_pkvco_bw_ctrl_m0_1_0;
  rand uvm_reg_field cmn_pdiag_pll0_pkvco_bw_ctrl_m0_3_2;
  rand uvm_reg_field cmn_pdiag_pll0_pkvco_bw_ctrl_m0_4;
  rand uvm_reg_field cmn_pdiag_pll0_pkvco_bw_ctrl_m0_15_5;
  rand uvm_reg_field cmn_pdiag_pll0_pkvco_bw_ctrl_m0_31_16;
  
  covergroup wr_fld_covg;
    cmn_pdiag_pll0_pkvco_bw_ctrl_m0_1_0: coverpoint cmn_pdiag_pll0_pkvco_bw_ctrl_m0_1_0.value[1:0];
    cmn_pdiag_pll0_pkvco_bw_ctrl_m0_3_2: coverpoint cmn_pdiag_pll0_pkvco_bw_ctrl_m0_3_2.value[1:0];
    cmn_pdiag_pll0_pkvco_bw_ctrl_m0_4: coverpoint cmn_pdiag_pll0_pkvco_bw_ctrl_m0_4.value[0:0];
    cmn_pdiag_pll0_pkvco_bw_ctrl_m0_15_5: coverpoint cmn_pdiag_pll0_pkvco_bw_ctrl_m0_15_5.value[10:0];
    cmn_pdiag_pll0_pkvco_bw_ctrl_m0_31_16: coverpoint cmn_pdiag_pll0_pkvco_bw_ctrl_m0_31_16.value[15:0];
  endgroup
  covergroup rd_fld_covg;
    cmn_pdiag_pll0_pkvco_bw_ctrl_m0_1_0: coverpoint cmn_pdiag_pll0_pkvco_bw_ctrl_m0_1_0.value[1:0];
    cmn_pdiag_pll0_pkvco_bw_ctrl_m0_3_2: coverpoint cmn_pdiag_pll0_pkvco_bw_ctrl_m0_3_2.value[1:0];
    cmn_pdiag_pll0_pkvco_bw_ctrl_m0_4: coverpoint cmn_pdiag_pll0_pkvco_bw_ctrl_m0_4.value[0:0];
    cmn_pdiag_pll0_pkvco_bw_ctrl_m0_15_5: coverpoint cmn_pdiag_pll0_pkvco_bw_ctrl_m0_15_5.value[10:0];
    cmn_pdiag_pll0_pkvco_bw_ctrl_m0_31_16: coverpoint cmn_pdiag_pll0_pkvco_bw_ctrl_m0_31_16.value[15:0];
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
    
    cmn_pdiag_pll0_pkvco_bw_ctrl_m0_1_0 = fld_set[0];
    cmn_pdiag_pll0_pkvco_bw_ctrl_m0_3_2 = fld_set[1];
    cmn_pdiag_pll0_pkvco_bw_ctrl_m0_4 = fld_set[2];
    cmn_pdiag_pll0_pkvco_bw_ctrl_m0_15_5 = fld_set[3];
    cmn_pdiag_pll0_pkvco_bw_ctrl_m0_31_16 = fld_set[4];
  endfunction

  function new(input string name="T_cmn_pdiag_pll0_pkvco_bw_ctrl_m0_1128");
    super.new(name, 32, build_coverage(UVM_CVR_FIELD_VALS));
    if (has_coverage(UVM_CVR_FIELD_VALS)) begin
      wr_fld_covg = new();
      rd_fld_covg = new();
    end
  endfunction

endclass


/////////////////////////////////////////////////////
//                cmn_pdiag_pll0_pkvco_bw_ctrl_m1
/////////////////////////////////////////////////////
class T_cmn_pdiag_pll0_pkvco_bw_ctrl_m1_1137 extends cdns_uvm_reg;

  `uvm_object_utils(T_cmn_pdiag_pll0_pkvco_bw_ctrl_m1_1137)
  rand uvm_reg_field cmn_pdiag_pll0_pkvco_bw_ctrl_m1_1_0;
  rand uvm_reg_field cmn_pdiag_pll0_pkvco_bw_ctrl_m1_3_2;
  rand uvm_reg_field cmn_pdiag_pll0_pkvco_bw_ctrl_m1_4;
  rand uvm_reg_field cmn_pdiag_pll0_pkvco_bw_ctrl_m1_15_5;
  rand uvm_reg_field cmn_pdiag_pll0_pkvco_bw_ctrl_m1_31_16;
  
  covergroup wr_fld_covg;
    cmn_pdiag_pll0_pkvco_bw_ctrl_m1_1_0: coverpoint cmn_pdiag_pll0_pkvco_bw_ctrl_m1_1_0.value[1:0];
    cmn_pdiag_pll0_pkvco_bw_ctrl_m1_3_2: coverpoint cmn_pdiag_pll0_pkvco_bw_ctrl_m1_3_2.value[1:0];
    cmn_pdiag_pll0_pkvco_bw_ctrl_m1_4: coverpoint cmn_pdiag_pll0_pkvco_bw_ctrl_m1_4.value[0:0];
    cmn_pdiag_pll0_pkvco_bw_ctrl_m1_15_5: coverpoint cmn_pdiag_pll0_pkvco_bw_ctrl_m1_15_5.value[10:0];
    cmn_pdiag_pll0_pkvco_bw_ctrl_m1_31_16: coverpoint cmn_pdiag_pll0_pkvco_bw_ctrl_m1_31_16.value[15:0];
  endgroup
  covergroup rd_fld_covg;
    cmn_pdiag_pll0_pkvco_bw_ctrl_m1_1_0: coverpoint cmn_pdiag_pll0_pkvco_bw_ctrl_m1_1_0.value[1:0];
    cmn_pdiag_pll0_pkvco_bw_ctrl_m1_3_2: coverpoint cmn_pdiag_pll0_pkvco_bw_ctrl_m1_3_2.value[1:0];
    cmn_pdiag_pll0_pkvco_bw_ctrl_m1_4: coverpoint cmn_pdiag_pll0_pkvco_bw_ctrl_m1_4.value[0:0];
    cmn_pdiag_pll0_pkvco_bw_ctrl_m1_15_5: coverpoint cmn_pdiag_pll0_pkvco_bw_ctrl_m1_15_5.value[10:0];
    cmn_pdiag_pll0_pkvco_bw_ctrl_m1_31_16: coverpoint cmn_pdiag_pll0_pkvco_bw_ctrl_m1_31_16.value[15:0];
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
    
    cmn_pdiag_pll0_pkvco_bw_ctrl_m1_1_0 = fld_set[0];
    cmn_pdiag_pll0_pkvco_bw_ctrl_m1_3_2 = fld_set[1];
    cmn_pdiag_pll0_pkvco_bw_ctrl_m1_4 = fld_set[2];
    cmn_pdiag_pll0_pkvco_bw_ctrl_m1_15_5 = fld_set[3];
    cmn_pdiag_pll0_pkvco_bw_ctrl_m1_31_16 = fld_set[4];
  endfunction

  function new(input string name="T_cmn_pdiag_pll0_pkvco_bw_ctrl_m1_1137");
    super.new(name, 32, build_coverage(UVM_CVR_FIELD_VALS));
    if (has_coverage(UVM_CVR_FIELD_VALS)) begin
      wr_fld_covg = new();
      rd_fld_covg = new();
    end
  endfunction

endclass


/////////////////////////////////////////////////////
//                cmn_pdiag_pll0_post_div_m0
/////////////////////////////////////////////////////
class T_cmn_pdiag_pll0_post_div_m0_1134 extends cdns_uvm_reg;

  `uvm_object_utils(T_cmn_pdiag_pll0_post_div_m0_1134)
  rand uvm_reg_field cmn_pdiag_pll0_post_div_m0_0;
  rand uvm_reg_field cmn_pdiag_pll0_post_div_m0_31_1;
  
  covergroup wr_fld_covg;
    cmn_pdiag_pll0_post_div_m0_0: coverpoint cmn_pdiag_pll0_post_div_m0_0.value[0:0];
    cmn_pdiag_pll0_post_div_m0_31_1: coverpoint cmn_pdiag_pll0_post_div_m0_31_1.value[30:0];
  endgroup
  covergroup rd_fld_covg;
    cmn_pdiag_pll0_post_div_m0_0: coverpoint cmn_pdiag_pll0_post_div_m0_0.value[0:0];
    cmn_pdiag_pll0_post_div_m0_31_1: coverpoint cmn_pdiag_pll0_post_div_m0_31_1.value[30:0];
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
    
    cmn_pdiag_pll0_post_div_m0_0 = fld_set[0];
    cmn_pdiag_pll0_post_div_m0_31_1 = fld_set[1];
  endfunction

  function new(input string name="T_cmn_pdiag_pll0_post_div_m0_1134");
    super.new(name, 32, build_coverage(UVM_CVR_FIELD_VALS));
    if (has_coverage(UVM_CVR_FIELD_VALS)) begin
      wr_fld_covg = new();
      rd_fld_covg = new();
    end
  endfunction

endclass


/////////////////////////////////////////////////////
//                cmn_pdiag_pll0_post_div_m1
/////////////////////////////////////////////////////
class T_cmn_pdiag_pll0_post_div_m1_1143 extends cdns_uvm_reg;

  `uvm_object_utils(T_cmn_pdiag_pll0_post_div_m1_1143)
  rand uvm_reg_field cmn_pdiag_pll0_post_div_m1_0;
  rand uvm_reg_field cmn_pdiag_pll0_post_div_m1_31_1;
  
  covergroup wr_fld_covg;
    cmn_pdiag_pll0_post_div_m1_0: coverpoint cmn_pdiag_pll0_post_div_m1_0.value[0:0];
    cmn_pdiag_pll0_post_div_m1_31_1: coverpoint cmn_pdiag_pll0_post_div_m1_31_1.value[30:0];
  endgroup
  covergroup rd_fld_covg;
    cmn_pdiag_pll0_post_div_m1_0: coverpoint cmn_pdiag_pll0_post_div_m1_0.value[0:0];
    cmn_pdiag_pll0_post_div_m1_31_1: coverpoint cmn_pdiag_pll0_post_div_m1_31_1.value[30:0];
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
    
    cmn_pdiag_pll0_post_div_m1_0 = fld_set[0];
    cmn_pdiag_pll0_post_div_m1_31_1 = fld_set[1];
  endfunction

  function new(input string name="T_cmn_pdiag_pll0_post_div_m1_1143");
    super.new(name, 32, build_coverage(UVM_CVR_FIELD_VALS));
    if (has_coverage(UVM_CVR_FIELD_VALS)) begin
      wr_fld_covg = new();
      rd_fld_covg = new();
    end
  endfunction

endclass


/////////////////////////////////////////////////////
//                cmn_pdiag_pll0_prog0_clk_ctrl_m0
/////////////////////////////////////////////////////
class T_cmn_pdiag_pll0_prog0_clk_ctrl_m0_1132 extends cdns_uvm_reg;

  `uvm_object_utils(T_cmn_pdiag_pll0_prog0_clk_ctrl_m0_1132)
  rand uvm_reg_field cmn_pdiag_pll0_prog0_clk_ctrl_m0_0;
  rand uvm_reg_field cmn_pdiag_pll0_prog0_clk_ctrl_m0_1;
  rand uvm_reg_field cmn_pdiag_pll0_prog0_clk_ctrl_m0_7_2;
  rand uvm_reg_field cmn_pdiag_pll0_prog0_clk_ctrl_m0_11_8;
  rand uvm_reg_field cmn_pdiag_pll0_prog0_clk_ctrl_m0_15_12;
  rand uvm_reg_field cmn_pdiag_pll0_prog0_clk_ctrl_m0_22_16;
  rand uvm_reg_field cmn_pdiag_pll0_prog0_clk_ctrl_m0_23;
  rand uvm_reg_field cmn_pdiag_pll0_prog0_clk_ctrl_m0_30_24;
  rand uvm_reg_field cmn_pdiag_pll0_prog0_clk_ctrl_m0_31;
  
  covergroup wr_fld_covg;
    cmn_pdiag_pll0_prog0_clk_ctrl_m0_0: coverpoint cmn_pdiag_pll0_prog0_clk_ctrl_m0_0.value[0:0];
    cmn_pdiag_pll0_prog0_clk_ctrl_m0_1: coverpoint cmn_pdiag_pll0_prog0_clk_ctrl_m0_1.value[0:0];
    cmn_pdiag_pll0_prog0_clk_ctrl_m0_7_2: coverpoint cmn_pdiag_pll0_prog0_clk_ctrl_m0_7_2.value[5:0];
    cmn_pdiag_pll0_prog0_clk_ctrl_m0_11_8: coverpoint cmn_pdiag_pll0_prog0_clk_ctrl_m0_11_8.value[3:0];
    cmn_pdiag_pll0_prog0_clk_ctrl_m0_15_12: coverpoint cmn_pdiag_pll0_prog0_clk_ctrl_m0_15_12.value[3:0];
    cmn_pdiag_pll0_prog0_clk_ctrl_m0_22_16: coverpoint cmn_pdiag_pll0_prog0_clk_ctrl_m0_22_16.value[6:0];
    cmn_pdiag_pll0_prog0_clk_ctrl_m0_23: coverpoint cmn_pdiag_pll0_prog0_clk_ctrl_m0_23.value[0:0];
    cmn_pdiag_pll0_prog0_clk_ctrl_m0_30_24: coverpoint cmn_pdiag_pll0_prog0_clk_ctrl_m0_30_24.value[6:0];
    cmn_pdiag_pll0_prog0_clk_ctrl_m0_31: coverpoint cmn_pdiag_pll0_prog0_clk_ctrl_m0_31.value[0:0];
  endgroup
  covergroup rd_fld_covg;
    cmn_pdiag_pll0_prog0_clk_ctrl_m0_0: coverpoint cmn_pdiag_pll0_prog0_clk_ctrl_m0_0.value[0:0];
    cmn_pdiag_pll0_prog0_clk_ctrl_m0_1: coverpoint cmn_pdiag_pll0_prog0_clk_ctrl_m0_1.value[0:0];
    cmn_pdiag_pll0_prog0_clk_ctrl_m0_7_2: coverpoint cmn_pdiag_pll0_prog0_clk_ctrl_m0_7_2.value[5:0];
    cmn_pdiag_pll0_prog0_clk_ctrl_m0_11_8: coverpoint cmn_pdiag_pll0_prog0_clk_ctrl_m0_11_8.value[3:0];
    cmn_pdiag_pll0_prog0_clk_ctrl_m0_15_12: coverpoint cmn_pdiag_pll0_prog0_clk_ctrl_m0_15_12.value[3:0];
    cmn_pdiag_pll0_prog0_clk_ctrl_m0_22_16: coverpoint cmn_pdiag_pll0_prog0_clk_ctrl_m0_22_16.value[6:0];
    cmn_pdiag_pll0_prog0_clk_ctrl_m0_23: coverpoint cmn_pdiag_pll0_prog0_clk_ctrl_m0_23.value[0:0];
    cmn_pdiag_pll0_prog0_clk_ctrl_m0_30_24: coverpoint cmn_pdiag_pll0_prog0_clk_ctrl_m0_30_24.value[6:0];
    cmn_pdiag_pll0_prog0_clk_ctrl_m0_31: coverpoint cmn_pdiag_pll0_prog0_clk_ctrl_m0_31.value[0:0];
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
    
    cmn_pdiag_pll0_prog0_clk_ctrl_m0_0 = fld_set[0];
    cmn_pdiag_pll0_prog0_clk_ctrl_m0_1 = fld_set[1];
    cmn_pdiag_pll0_prog0_clk_ctrl_m0_7_2 = fld_set[2];
    cmn_pdiag_pll0_prog0_clk_ctrl_m0_11_8 = fld_set[3];
    cmn_pdiag_pll0_prog0_clk_ctrl_m0_15_12 = fld_set[4];
    cmn_pdiag_pll0_prog0_clk_ctrl_m0_22_16 = fld_set[5];
    cmn_pdiag_pll0_prog0_clk_ctrl_m0_23 = fld_set[6];
    cmn_pdiag_pll0_prog0_clk_ctrl_m0_30_24 = fld_set[7];
    cmn_pdiag_pll0_prog0_clk_ctrl_m0_31 = fld_set[8];
  endfunction

  function new(input string name="T_cmn_pdiag_pll0_prog0_clk_ctrl_m0_1132");
    super.new(name, 32, build_coverage(UVM_CVR_FIELD_VALS));
    if (has_coverage(UVM_CVR_FIELD_VALS)) begin
      wr_fld_covg = new();
      rd_fld_covg = new();
    end
  endfunction

endclass


/////////////////////////////////////////////////////
//                cmn_pdiag_pll0_prog0_clk_ctrl_m1
/////////////////////////////////////////////////////
class T_cmn_pdiag_pll0_prog0_clk_ctrl_m1_1141 extends cdns_uvm_reg;

  `uvm_object_utils(T_cmn_pdiag_pll0_prog0_clk_ctrl_m1_1141)
  rand uvm_reg_field cmn_pdiag_pll0_prog0_clk_ctrl_m1_0;
  rand uvm_reg_field cmn_pdiag_pll0_prog0_clk_ctrl_m1_1;
  rand uvm_reg_field cmn_pdiag_pll0_prog0_clk_ctrl_m1_7_2;
  rand uvm_reg_field cmn_pdiag_pll0_prog0_clk_ctrl_m1_11_8;
  rand uvm_reg_field cmn_pdiag_pll0_prog0_clk_ctrl_m1_15_12;
  rand uvm_reg_field cmn_pdiag_pll0_prog0_clk_ctrl_m1_22_16;
  rand uvm_reg_field cmn_pdiag_pll0_prog0_clk_ctrl_m1_23;
  rand uvm_reg_field cmn_pdiag_pll0_prog0_clk_ctrl_m1_30_24;
  rand uvm_reg_field cmn_pdiag_pll0_prog0_clk_ctrl_m1_31;
  
  covergroup wr_fld_covg;
    cmn_pdiag_pll0_prog0_clk_ctrl_m1_0: coverpoint cmn_pdiag_pll0_prog0_clk_ctrl_m1_0.value[0:0];
    cmn_pdiag_pll0_prog0_clk_ctrl_m1_1: coverpoint cmn_pdiag_pll0_prog0_clk_ctrl_m1_1.value[0:0];
    cmn_pdiag_pll0_prog0_clk_ctrl_m1_7_2: coverpoint cmn_pdiag_pll0_prog0_clk_ctrl_m1_7_2.value[5:0];
    cmn_pdiag_pll0_prog0_clk_ctrl_m1_11_8: coverpoint cmn_pdiag_pll0_prog0_clk_ctrl_m1_11_8.value[3:0];
    cmn_pdiag_pll0_prog0_clk_ctrl_m1_15_12: coverpoint cmn_pdiag_pll0_prog0_clk_ctrl_m1_15_12.value[3:0];
    cmn_pdiag_pll0_prog0_clk_ctrl_m1_22_16: coverpoint cmn_pdiag_pll0_prog0_clk_ctrl_m1_22_16.value[6:0];
    cmn_pdiag_pll0_prog0_clk_ctrl_m1_23: coverpoint cmn_pdiag_pll0_prog0_clk_ctrl_m1_23.value[0:0];
    cmn_pdiag_pll0_prog0_clk_ctrl_m1_30_24: coverpoint cmn_pdiag_pll0_prog0_clk_ctrl_m1_30_24.value[6:0];
    cmn_pdiag_pll0_prog0_clk_ctrl_m1_31: coverpoint cmn_pdiag_pll0_prog0_clk_ctrl_m1_31.value[0:0];
  endgroup
  covergroup rd_fld_covg;
    cmn_pdiag_pll0_prog0_clk_ctrl_m1_0: coverpoint cmn_pdiag_pll0_prog0_clk_ctrl_m1_0.value[0:0];
    cmn_pdiag_pll0_prog0_clk_ctrl_m1_1: coverpoint cmn_pdiag_pll0_prog0_clk_ctrl_m1_1.value[0:0];
    cmn_pdiag_pll0_prog0_clk_ctrl_m1_7_2: coverpoint cmn_pdiag_pll0_prog0_clk_ctrl_m1_7_2.value[5:0];
    cmn_pdiag_pll0_prog0_clk_ctrl_m1_11_8: coverpoint cmn_pdiag_pll0_prog0_clk_ctrl_m1_11_8.value[3:0];
    cmn_pdiag_pll0_prog0_clk_ctrl_m1_15_12: coverpoint cmn_pdiag_pll0_prog0_clk_ctrl_m1_15_12.value[3:0];
    cmn_pdiag_pll0_prog0_clk_ctrl_m1_22_16: coverpoint cmn_pdiag_pll0_prog0_clk_ctrl_m1_22_16.value[6:0];
    cmn_pdiag_pll0_prog0_clk_ctrl_m1_23: coverpoint cmn_pdiag_pll0_prog0_clk_ctrl_m1_23.value[0:0];
    cmn_pdiag_pll0_prog0_clk_ctrl_m1_30_24: coverpoint cmn_pdiag_pll0_prog0_clk_ctrl_m1_30_24.value[6:0];
    cmn_pdiag_pll0_prog0_clk_ctrl_m1_31: coverpoint cmn_pdiag_pll0_prog0_clk_ctrl_m1_31.value[0:0];
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
    
    cmn_pdiag_pll0_prog0_clk_ctrl_m1_0 = fld_set[0];
    cmn_pdiag_pll0_prog0_clk_ctrl_m1_1 = fld_set[1];
    cmn_pdiag_pll0_prog0_clk_ctrl_m1_7_2 = fld_set[2];
    cmn_pdiag_pll0_prog0_clk_ctrl_m1_11_8 = fld_set[3];
    cmn_pdiag_pll0_prog0_clk_ctrl_m1_15_12 = fld_set[4];
    cmn_pdiag_pll0_prog0_clk_ctrl_m1_22_16 = fld_set[5];
    cmn_pdiag_pll0_prog0_clk_ctrl_m1_23 = fld_set[6];
    cmn_pdiag_pll0_prog0_clk_ctrl_m1_30_24 = fld_set[7];
    cmn_pdiag_pll0_prog0_clk_ctrl_m1_31 = fld_set[8];
  endfunction

  function new(input string name="T_cmn_pdiag_pll0_prog0_clk_ctrl_m1_1141");
    super.new(name, 32, build_coverage(UVM_CVR_FIELD_VALS));
    if (has_coverage(UVM_CVR_FIELD_VALS)) begin
      wr_fld_covg = new();
      rd_fld_covg = new();
    end
  endfunction

endclass


/////////////////////////////////////////////////////
//                cmn_pdiag_pll0_prog1_clk_ctrl_m0
/////////////////////////////////////////////////////
class T_cmn_pdiag_pll0_prog1_clk_ctrl_m0_1133 extends cdns_uvm_reg;

  `uvm_object_utils(T_cmn_pdiag_pll0_prog1_clk_ctrl_m0_1133)
  rand uvm_reg_field cmn_pdiag_pll0_prog1_clk_ctrl_m0_0;
  rand uvm_reg_field cmn_pdiag_pll0_prog1_clk_ctrl_m0_1;
  rand uvm_reg_field cmn_pdiag_pll0_prog1_clk_ctrl_m0_7_2;
  rand uvm_reg_field cmn_pdiag_pll0_prog1_clk_ctrl_m0_11_8;
  rand uvm_reg_field cmn_pdiag_pll0_prog1_clk_ctrl_m0_15_12;
  rand uvm_reg_field cmn_pdiag_pll0_prog1_clk_ctrl_m0_22_16;
  rand uvm_reg_field cmn_pdiag_pll0_prog1_clk_ctrl_m0_23;
  rand uvm_reg_field cmn_pdiag_pll0_prog1_clk_ctrl_m0_30_24;
  rand uvm_reg_field cmn_pdiag_pll0_prog1_clk_ctrl_m0_31;
  
  covergroup wr_fld_covg;
    cmn_pdiag_pll0_prog1_clk_ctrl_m0_0: coverpoint cmn_pdiag_pll0_prog1_clk_ctrl_m0_0.value[0:0];
    cmn_pdiag_pll0_prog1_clk_ctrl_m0_1: coverpoint cmn_pdiag_pll0_prog1_clk_ctrl_m0_1.value[0:0];
    cmn_pdiag_pll0_prog1_clk_ctrl_m0_7_2: coverpoint cmn_pdiag_pll0_prog1_clk_ctrl_m0_7_2.value[5:0];
    cmn_pdiag_pll0_prog1_clk_ctrl_m0_11_8: coverpoint cmn_pdiag_pll0_prog1_clk_ctrl_m0_11_8.value[3:0];
    cmn_pdiag_pll0_prog1_clk_ctrl_m0_15_12: coverpoint cmn_pdiag_pll0_prog1_clk_ctrl_m0_15_12.value[3:0];
    cmn_pdiag_pll0_prog1_clk_ctrl_m0_22_16: coverpoint cmn_pdiag_pll0_prog1_clk_ctrl_m0_22_16.value[6:0];
    cmn_pdiag_pll0_prog1_clk_ctrl_m0_23: coverpoint cmn_pdiag_pll0_prog1_clk_ctrl_m0_23.value[0:0];
    cmn_pdiag_pll0_prog1_clk_ctrl_m0_30_24: coverpoint cmn_pdiag_pll0_prog1_clk_ctrl_m0_30_24.value[6:0];
    cmn_pdiag_pll0_prog1_clk_ctrl_m0_31: coverpoint cmn_pdiag_pll0_prog1_clk_ctrl_m0_31.value[0:0];
  endgroup
  covergroup rd_fld_covg;
    cmn_pdiag_pll0_prog1_clk_ctrl_m0_0: coverpoint cmn_pdiag_pll0_prog1_clk_ctrl_m0_0.value[0:0];
    cmn_pdiag_pll0_prog1_clk_ctrl_m0_1: coverpoint cmn_pdiag_pll0_prog1_clk_ctrl_m0_1.value[0:0];
    cmn_pdiag_pll0_prog1_clk_ctrl_m0_7_2: coverpoint cmn_pdiag_pll0_prog1_clk_ctrl_m0_7_2.value[5:0];
    cmn_pdiag_pll0_prog1_clk_ctrl_m0_11_8: coverpoint cmn_pdiag_pll0_prog1_clk_ctrl_m0_11_8.value[3:0];
    cmn_pdiag_pll0_prog1_clk_ctrl_m0_15_12: coverpoint cmn_pdiag_pll0_prog1_clk_ctrl_m0_15_12.value[3:0];
    cmn_pdiag_pll0_prog1_clk_ctrl_m0_22_16: coverpoint cmn_pdiag_pll0_prog1_clk_ctrl_m0_22_16.value[6:0];
    cmn_pdiag_pll0_prog1_clk_ctrl_m0_23: coverpoint cmn_pdiag_pll0_prog1_clk_ctrl_m0_23.value[0:0];
    cmn_pdiag_pll0_prog1_clk_ctrl_m0_30_24: coverpoint cmn_pdiag_pll0_prog1_clk_ctrl_m0_30_24.value[6:0];
    cmn_pdiag_pll0_prog1_clk_ctrl_m0_31: coverpoint cmn_pdiag_pll0_prog1_clk_ctrl_m0_31.value[0:0];
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
    
    cmn_pdiag_pll0_prog1_clk_ctrl_m0_0 = fld_set[0];
    cmn_pdiag_pll0_prog1_clk_ctrl_m0_1 = fld_set[1];
    cmn_pdiag_pll0_prog1_clk_ctrl_m0_7_2 = fld_set[2];
    cmn_pdiag_pll0_prog1_clk_ctrl_m0_11_8 = fld_set[3];
    cmn_pdiag_pll0_prog1_clk_ctrl_m0_15_12 = fld_set[4];
    cmn_pdiag_pll0_prog1_clk_ctrl_m0_22_16 = fld_set[5];
    cmn_pdiag_pll0_prog1_clk_ctrl_m0_23 = fld_set[6];
    cmn_pdiag_pll0_prog1_clk_ctrl_m0_30_24 = fld_set[7];
    cmn_pdiag_pll0_prog1_clk_ctrl_m0_31 = fld_set[8];
  endfunction

  function new(input string name="T_cmn_pdiag_pll0_prog1_clk_ctrl_m0_1133");
    super.new(name, 32, build_coverage(UVM_CVR_FIELD_VALS));
    if (has_coverage(UVM_CVR_FIELD_VALS)) begin
      wr_fld_covg = new();
      rd_fld_covg = new();
    end
  endfunction

endclass


/////////////////////////////////////////////////////
//                cmn_pdiag_pll0_prog1_clk_ctrl_m1
/////////////////////////////////////////////////////
class T_cmn_pdiag_pll0_prog1_clk_ctrl_m1_1142 extends cdns_uvm_reg;

  `uvm_object_utils(T_cmn_pdiag_pll0_prog1_clk_ctrl_m1_1142)
  rand uvm_reg_field cmn_pdiag_pll0_prog1_clk_ctrl_m1_0;
  rand uvm_reg_field cmn_pdiag_pll0_prog1_clk_ctrl_m1_1;
  rand uvm_reg_field cmn_pdiag_pll0_prog1_clk_ctrl_m1_7_2;
  rand uvm_reg_field cmn_pdiag_pll0_prog1_clk_ctrl_m1_11_8;
  rand uvm_reg_field cmn_pdiag_pll0_prog1_clk_ctrl_m1_15_12;
  rand uvm_reg_field cmn_pdiag_pll0_prog1_clk_ctrl_m1_22_16;
  rand uvm_reg_field cmn_pdiag_pll0_prog1_clk_ctrl_m1_23;
  rand uvm_reg_field cmn_pdiag_pll0_prog1_clk_ctrl_m1_30_24;
  rand uvm_reg_field cmn_pdiag_pll0_prog1_clk_ctrl_m1_31;
  
  covergroup wr_fld_covg;
    cmn_pdiag_pll0_prog1_clk_ctrl_m1_0: coverpoint cmn_pdiag_pll0_prog1_clk_ctrl_m1_0.value[0:0];
    cmn_pdiag_pll0_prog1_clk_ctrl_m1_1: coverpoint cmn_pdiag_pll0_prog1_clk_ctrl_m1_1.value[0:0];
    cmn_pdiag_pll0_prog1_clk_ctrl_m1_7_2: coverpoint cmn_pdiag_pll0_prog1_clk_ctrl_m1_7_2.value[5:0];
    cmn_pdiag_pll0_prog1_clk_ctrl_m1_11_8: coverpoint cmn_pdiag_pll0_prog1_clk_ctrl_m1_11_8.value[3:0];
    cmn_pdiag_pll0_prog1_clk_ctrl_m1_15_12: coverpoint cmn_pdiag_pll0_prog1_clk_ctrl_m1_15_12.value[3:0];
    cmn_pdiag_pll0_prog1_clk_ctrl_m1_22_16: coverpoint cmn_pdiag_pll0_prog1_clk_ctrl_m1_22_16.value[6:0];
    cmn_pdiag_pll0_prog1_clk_ctrl_m1_23: coverpoint cmn_pdiag_pll0_prog1_clk_ctrl_m1_23.value[0:0];
    cmn_pdiag_pll0_prog1_clk_ctrl_m1_30_24: coverpoint cmn_pdiag_pll0_prog1_clk_ctrl_m1_30_24.value[6:0];
    cmn_pdiag_pll0_prog1_clk_ctrl_m1_31: coverpoint cmn_pdiag_pll0_prog1_clk_ctrl_m1_31.value[0:0];
  endgroup
  covergroup rd_fld_covg;
    cmn_pdiag_pll0_prog1_clk_ctrl_m1_0: coverpoint cmn_pdiag_pll0_prog1_clk_ctrl_m1_0.value[0:0];
    cmn_pdiag_pll0_prog1_clk_ctrl_m1_1: coverpoint cmn_pdiag_pll0_prog1_clk_ctrl_m1_1.value[0:0];
    cmn_pdiag_pll0_prog1_clk_ctrl_m1_7_2: coverpoint cmn_pdiag_pll0_prog1_clk_ctrl_m1_7_2.value[5:0];
    cmn_pdiag_pll0_prog1_clk_ctrl_m1_11_8: coverpoint cmn_pdiag_pll0_prog1_clk_ctrl_m1_11_8.value[3:0];
    cmn_pdiag_pll0_prog1_clk_ctrl_m1_15_12: coverpoint cmn_pdiag_pll0_prog1_clk_ctrl_m1_15_12.value[3:0];
    cmn_pdiag_pll0_prog1_clk_ctrl_m1_22_16: coverpoint cmn_pdiag_pll0_prog1_clk_ctrl_m1_22_16.value[6:0];
    cmn_pdiag_pll0_prog1_clk_ctrl_m1_23: coverpoint cmn_pdiag_pll0_prog1_clk_ctrl_m1_23.value[0:0];
    cmn_pdiag_pll0_prog1_clk_ctrl_m1_30_24: coverpoint cmn_pdiag_pll0_prog1_clk_ctrl_m1_30_24.value[6:0];
    cmn_pdiag_pll0_prog1_clk_ctrl_m1_31: coverpoint cmn_pdiag_pll0_prog1_clk_ctrl_m1_31.value[0:0];
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
    
    cmn_pdiag_pll0_prog1_clk_ctrl_m1_0 = fld_set[0];
    cmn_pdiag_pll0_prog1_clk_ctrl_m1_1 = fld_set[1];
    cmn_pdiag_pll0_prog1_clk_ctrl_m1_7_2 = fld_set[2];
    cmn_pdiag_pll0_prog1_clk_ctrl_m1_11_8 = fld_set[3];
    cmn_pdiag_pll0_prog1_clk_ctrl_m1_15_12 = fld_set[4];
    cmn_pdiag_pll0_prog1_clk_ctrl_m1_22_16 = fld_set[5];
    cmn_pdiag_pll0_prog1_clk_ctrl_m1_23 = fld_set[6];
    cmn_pdiag_pll0_prog1_clk_ctrl_m1_30_24 = fld_set[7];
    cmn_pdiag_pll0_prog1_clk_ctrl_m1_31 = fld_set[8];
  endfunction

  function new(input string name="T_cmn_pdiag_pll0_prog1_clk_ctrl_m1_1142");
    super.new(name, 32, build_coverage(UVM_CVR_FIELD_VALS));
    if (has_coverage(UVM_CVR_FIELD_VALS)) begin
      wr_fld_covg = new();
      rd_fld_covg = new();
    end
  endfunction

endclass


/////////////////////////////////////////////////////
//                cmn_pdiag_pll0_tune_m0
/////////////////////////////////////////////////////
class T_cmn_pdiag_pll0_tune_m0_1127 extends cdns_uvm_reg;

  `uvm_object_utils(T_cmn_pdiag_pll0_tune_m0_1127)
  rand uvm_reg_field cmn_pdiag_pll0_tune_m0_7_0;
  rand uvm_reg_field cmn_pdiag_pll0_tune_m0_9_8;
  rand uvm_reg_field cmn_pdiag_pll0_tune_m0_11_10;
  rand uvm_reg_field cmn_pdiag_pll0_tune_m0_12;
  rand uvm_reg_field cmn_pdiag_pll0_tune_m0_13;
  rand uvm_reg_field cmn_pdiag_pll0_tune_m0_14;
  rand uvm_reg_field cmn_pdiag_pll0_tune_m0_15;
  rand uvm_reg_field cmn_pdiag_pll0_tune_m0_16;
  rand uvm_reg_field cmn_pdiag_pll0_tune_m0_17;
  rand uvm_reg_field cmn_pdiag_pll0_tune_m0_23_18;
  rand uvm_reg_field cmn_pdiag_pll0_tune_m0_26_24;
  rand uvm_reg_field cmn_pdiag_pll0_tune_m0_27;
  rand uvm_reg_field cmn_pdiag_pll0_tune_m0_29_28;
  rand uvm_reg_field cmn_pdiag_pll0_tune_m0_31_30;
  
  covergroup wr_fld_covg;
    cmn_pdiag_pll0_tune_m0_7_0: coverpoint cmn_pdiag_pll0_tune_m0_7_0.value[7:0];
    cmn_pdiag_pll0_tune_m0_9_8: coverpoint cmn_pdiag_pll0_tune_m0_9_8.value[1:0];
    cmn_pdiag_pll0_tune_m0_11_10: coverpoint cmn_pdiag_pll0_tune_m0_11_10.value[1:0];
    cmn_pdiag_pll0_tune_m0_12: coverpoint cmn_pdiag_pll0_tune_m0_12.value[0:0];
    cmn_pdiag_pll0_tune_m0_13: coverpoint cmn_pdiag_pll0_tune_m0_13.value[0:0];
    cmn_pdiag_pll0_tune_m0_14: coverpoint cmn_pdiag_pll0_tune_m0_14.value[0:0];
    cmn_pdiag_pll0_tune_m0_15: coverpoint cmn_pdiag_pll0_tune_m0_15.value[0:0];
    cmn_pdiag_pll0_tune_m0_16: coverpoint cmn_pdiag_pll0_tune_m0_16.value[0:0];
    cmn_pdiag_pll0_tune_m0_17: coverpoint cmn_pdiag_pll0_tune_m0_17.value[0:0];
    cmn_pdiag_pll0_tune_m0_23_18: coverpoint cmn_pdiag_pll0_tune_m0_23_18.value[5:0];
    cmn_pdiag_pll0_tune_m0_26_24: coverpoint cmn_pdiag_pll0_tune_m0_26_24.value[2:0];
    cmn_pdiag_pll0_tune_m0_27: coverpoint cmn_pdiag_pll0_tune_m0_27.value[0:0];
    cmn_pdiag_pll0_tune_m0_29_28: coverpoint cmn_pdiag_pll0_tune_m0_29_28.value[1:0];
    cmn_pdiag_pll0_tune_m0_31_30: coverpoint cmn_pdiag_pll0_tune_m0_31_30.value[1:0];
  endgroup
  covergroup rd_fld_covg;
    cmn_pdiag_pll0_tune_m0_7_0: coverpoint cmn_pdiag_pll0_tune_m0_7_0.value[7:0];
    cmn_pdiag_pll0_tune_m0_9_8: coverpoint cmn_pdiag_pll0_tune_m0_9_8.value[1:0];
    cmn_pdiag_pll0_tune_m0_11_10: coverpoint cmn_pdiag_pll0_tune_m0_11_10.value[1:0];
    cmn_pdiag_pll0_tune_m0_12: coverpoint cmn_pdiag_pll0_tune_m0_12.value[0:0];
    cmn_pdiag_pll0_tune_m0_13: coverpoint cmn_pdiag_pll0_tune_m0_13.value[0:0];
    cmn_pdiag_pll0_tune_m0_14: coverpoint cmn_pdiag_pll0_tune_m0_14.value[0:0];
    cmn_pdiag_pll0_tune_m0_15: coverpoint cmn_pdiag_pll0_tune_m0_15.value[0:0];
    cmn_pdiag_pll0_tune_m0_16: coverpoint cmn_pdiag_pll0_tune_m0_16.value[0:0];
    cmn_pdiag_pll0_tune_m0_17: coverpoint cmn_pdiag_pll0_tune_m0_17.value[0:0];
    cmn_pdiag_pll0_tune_m0_23_18: coverpoint cmn_pdiag_pll0_tune_m0_23_18.value[5:0];
    cmn_pdiag_pll0_tune_m0_26_24: coverpoint cmn_pdiag_pll0_tune_m0_26_24.value[2:0];
    cmn_pdiag_pll0_tune_m0_27: coverpoint cmn_pdiag_pll0_tune_m0_27.value[0:0];
    cmn_pdiag_pll0_tune_m0_29_28: coverpoint cmn_pdiag_pll0_tune_m0_29_28.value[1:0];
    cmn_pdiag_pll0_tune_m0_31_30: coverpoint cmn_pdiag_pll0_tune_m0_31_30.value[1:0];
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
    
    cmn_pdiag_pll0_tune_m0_7_0 = fld_set[0];
    cmn_pdiag_pll0_tune_m0_9_8 = fld_set[1];
    cmn_pdiag_pll0_tune_m0_11_10 = fld_set[2];
    cmn_pdiag_pll0_tune_m0_12 = fld_set[3];
    cmn_pdiag_pll0_tune_m0_13 = fld_set[4];
    cmn_pdiag_pll0_tune_m0_14 = fld_set[5];
    cmn_pdiag_pll0_tune_m0_15 = fld_set[6];
    cmn_pdiag_pll0_tune_m0_16 = fld_set[7];
    cmn_pdiag_pll0_tune_m0_17 = fld_set[8];
    cmn_pdiag_pll0_tune_m0_23_18 = fld_set[9];
    cmn_pdiag_pll0_tune_m0_26_24 = fld_set[10];
    cmn_pdiag_pll0_tune_m0_27 = fld_set[11];
    cmn_pdiag_pll0_tune_m0_29_28 = fld_set[12];
    cmn_pdiag_pll0_tune_m0_31_30 = fld_set[13];
  endfunction

  function new(input string name="T_cmn_pdiag_pll0_tune_m0_1127");
    super.new(name, 32, build_coverage(UVM_CVR_FIELD_VALS));
    if (has_coverage(UVM_CVR_FIELD_VALS)) begin
      wr_fld_covg = new();
      rd_fld_covg = new();
    end
  endfunction

endclass


/////////////////////////////////////////////////////
//                cmn_pdiag_pll0_tune_m1
/////////////////////////////////////////////////////
class T_cmn_pdiag_pll0_tune_m1_1136 extends cdns_uvm_reg;

  `uvm_object_utils(T_cmn_pdiag_pll0_tune_m1_1136)
  rand uvm_reg_field cmn_pdiag_pll0_tune_m1_7_0;
  rand uvm_reg_field cmn_pdiag_pll0_tune_m1_9_8;
  rand uvm_reg_field cmn_pdiag_pll0_tune_m1_11_10;
  rand uvm_reg_field cmn_pdiag_pll0_tune_m1_12;
  rand uvm_reg_field cmn_pdiag_pll0_tune_m1_13;
  rand uvm_reg_field cmn_pdiag_pll0_tune_m1_14;
  rand uvm_reg_field cmn_pdiag_pll0_tune_m1_15;
  rand uvm_reg_field cmn_pdiag_pll0_tune_m1_16;
  rand uvm_reg_field cmn_pdiag_pll0_tune_m1_17;
  rand uvm_reg_field cmn_pdiag_pll0_tune_m1_23_18;
  rand uvm_reg_field cmn_pdiag_pll0_tune_m1_26_24;
  rand uvm_reg_field cmn_pdiag_pll0_tune_m1_27;
  rand uvm_reg_field cmn_pdiag_pll0_tune_m1_29_28;
  rand uvm_reg_field cmn_pdiag_pll0_tune_m1_31_30;
  
  covergroup wr_fld_covg;
    cmn_pdiag_pll0_tune_m1_7_0: coverpoint cmn_pdiag_pll0_tune_m1_7_0.value[7:0];
    cmn_pdiag_pll0_tune_m1_9_8: coverpoint cmn_pdiag_pll0_tune_m1_9_8.value[1:0];
    cmn_pdiag_pll0_tune_m1_11_10: coverpoint cmn_pdiag_pll0_tune_m1_11_10.value[1:0];
    cmn_pdiag_pll0_tune_m1_12: coverpoint cmn_pdiag_pll0_tune_m1_12.value[0:0];
    cmn_pdiag_pll0_tune_m1_13: coverpoint cmn_pdiag_pll0_tune_m1_13.value[0:0];
    cmn_pdiag_pll0_tune_m1_14: coverpoint cmn_pdiag_pll0_tune_m1_14.value[0:0];
    cmn_pdiag_pll0_tune_m1_15: coverpoint cmn_pdiag_pll0_tune_m1_15.value[0:0];
    cmn_pdiag_pll0_tune_m1_16: coverpoint cmn_pdiag_pll0_tune_m1_16.value[0:0];
    cmn_pdiag_pll0_tune_m1_17: coverpoint cmn_pdiag_pll0_tune_m1_17.value[0:0];
    cmn_pdiag_pll0_tune_m1_23_18: coverpoint cmn_pdiag_pll0_tune_m1_23_18.value[5:0];
    cmn_pdiag_pll0_tune_m1_26_24: coverpoint cmn_pdiag_pll0_tune_m1_26_24.value[2:0];
    cmn_pdiag_pll0_tune_m1_27: coverpoint cmn_pdiag_pll0_tune_m1_27.value[0:0];
    cmn_pdiag_pll0_tune_m1_29_28: coverpoint cmn_pdiag_pll0_tune_m1_29_28.value[1:0];
    cmn_pdiag_pll0_tune_m1_31_30: coverpoint cmn_pdiag_pll0_tune_m1_31_30.value[1:0];
  endgroup
  covergroup rd_fld_covg;
    cmn_pdiag_pll0_tune_m1_7_0: coverpoint cmn_pdiag_pll0_tune_m1_7_0.value[7:0];
    cmn_pdiag_pll0_tune_m1_9_8: coverpoint cmn_pdiag_pll0_tune_m1_9_8.value[1:0];
    cmn_pdiag_pll0_tune_m1_11_10: coverpoint cmn_pdiag_pll0_tune_m1_11_10.value[1:0];
    cmn_pdiag_pll0_tune_m1_12: coverpoint cmn_pdiag_pll0_tune_m1_12.value[0:0];
    cmn_pdiag_pll0_tune_m1_13: coverpoint cmn_pdiag_pll0_tune_m1_13.value[0:0];
    cmn_pdiag_pll0_tune_m1_14: coverpoint cmn_pdiag_pll0_tune_m1_14.value[0:0];
    cmn_pdiag_pll0_tune_m1_15: coverpoint cmn_pdiag_pll0_tune_m1_15.value[0:0];
    cmn_pdiag_pll0_tune_m1_16: coverpoint cmn_pdiag_pll0_tune_m1_16.value[0:0];
    cmn_pdiag_pll0_tune_m1_17: coverpoint cmn_pdiag_pll0_tune_m1_17.value[0:0];
    cmn_pdiag_pll0_tune_m1_23_18: coverpoint cmn_pdiag_pll0_tune_m1_23_18.value[5:0];
    cmn_pdiag_pll0_tune_m1_26_24: coverpoint cmn_pdiag_pll0_tune_m1_26_24.value[2:0];
    cmn_pdiag_pll0_tune_m1_27: coverpoint cmn_pdiag_pll0_tune_m1_27.value[0:0];
    cmn_pdiag_pll0_tune_m1_29_28: coverpoint cmn_pdiag_pll0_tune_m1_29_28.value[1:0];
    cmn_pdiag_pll0_tune_m1_31_30: coverpoint cmn_pdiag_pll0_tune_m1_31_30.value[1:0];
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
    
    cmn_pdiag_pll0_tune_m1_7_0 = fld_set[0];
    cmn_pdiag_pll0_tune_m1_9_8 = fld_set[1];
    cmn_pdiag_pll0_tune_m1_11_10 = fld_set[2];
    cmn_pdiag_pll0_tune_m1_12 = fld_set[3];
    cmn_pdiag_pll0_tune_m1_13 = fld_set[4];
    cmn_pdiag_pll0_tune_m1_14 = fld_set[5];
    cmn_pdiag_pll0_tune_m1_15 = fld_set[6];
    cmn_pdiag_pll0_tune_m1_16 = fld_set[7];
    cmn_pdiag_pll0_tune_m1_17 = fld_set[8];
    cmn_pdiag_pll0_tune_m1_23_18 = fld_set[9];
    cmn_pdiag_pll0_tune_m1_26_24 = fld_set[10];
    cmn_pdiag_pll0_tune_m1_27 = fld_set[11];
    cmn_pdiag_pll0_tune_m1_29_28 = fld_set[12];
    cmn_pdiag_pll0_tune_m1_31_30 = fld_set[13];
  endfunction

  function new(input string name="T_cmn_pdiag_pll0_tune_m1_1136");
    super.new(name, 32, build_coverage(UVM_CVR_FIELD_VALS));
    if (has_coverage(UVM_CVR_FIELD_VALS)) begin
      wr_fld_covg = new();
      rd_fld_covg = new();
    end
  endfunction

endclass


/////////////////////////////////////////////////////
//                cmn_pdiag_pll1_cp_ctrl_m0
/////////////////////////////////////////////////////
class T_cmn_pdiag_pll1_cp_ctrl_m0_1146 extends cdns_uvm_reg;

  `uvm_object_utils(T_cmn_pdiag_pll1_cp_ctrl_m0_1146)
  rand uvm_reg_field cmn_pdiag_pll1_cp_ctrl_m0_1_0;
  rand uvm_reg_field cmn_pdiag_pll1_cp_ctrl_m0_7_2;
  rand uvm_reg_field cmn_pdiag_pll1_cp_ctrl_m0_10_8;
  rand uvm_reg_field cmn_pdiag_pll1_cp_ctrl_m0_14_11;
  rand uvm_reg_field cmn_pdiag_pll1_cp_ctrl_m0_16_15;
  rand uvm_reg_field cmn_pdiag_pll1_cp_ctrl_m0_31_17;
  
  covergroup wr_fld_covg;
    cmn_pdiag_pll1_cp_ctrl_m0_1_0: coverpoint cmn_pdiag_pll1_cp_ctrl_m0_1_0.value[1:0];
    cmn_pdiag_pll1_cp_ctrl_m0_7_2: coverpoint cmn_pdiag_pll1_cp_ctrl_m0_7_2.value[5:0];
    cmn_pdiag_pll1_cp_ctrl_m0_10_8: coverpoint cmn_pdiag_pll1_cp_ctrl_m0_10_8.value[2:0];
    cmn_pdiag_pll1_cp_ctrl_m0_14_11: coverpoint cmn_pdiag_pll1_cp_ctrl_m0_14_11.value[3:0];
    cmn_pdiag_pll1_cp_ctrl_m0_16_15: coverpoint cmn_pdiag_pll1_cp_ctrl_m0_16_15.value[1:0];
    cmn_pdiag_pll1_cp_ctrl_m0_31_17: coverpoint cmn_pdiag_pll1_cp_ctrl_m0_31_17.value[14:0];
  endgroup
  covergroup rd_fld_covg;
    cmn_pdiag_pll1_cp_ctrl_m0_1_0: coverpoint cmn_pdiag_pll1_cp_ctrl_m0_1_0.value[1:0];
    cmn_pdiag_pll1_cp_ctrl_m0_7_2: coverpoint cmn_pdiag_pll1_cp_ctrl_m0_7_2.value[5:0];
    cmn_pdiag_pll1_cp_ctrl_m0_10_8: coverpoint cmn_pdiag_pll1_cp_ctrl_m0_10_8.value[2:0];
    cmn_pdiag_pll1_cp_ctrl_m0_14_11: coverpoint cmn_pdiag_pll1_cp_ctrl_m0_14_11.value[3:0];
    cmn_pdiag_pll1_cp_ctrl_m0_16_15: coverpoint cmn_pdiag_pll1_cp_ctrl_m0_16_15.value[1:0];
    cmn_pdiag_pll1_cp_ctrl_m0_31_17: coverpoint cmn_pdiag_pll1_cp_ctrl_m0_31_17.value[14:0];
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
    
    cmn_pdiag_pll1_cp_ctrl_m0_1_0 = fld_set[0];
    cmn_pdiag_pll1_cp_ctrl_m0_7_2 = fld_set[1];
    cmn_pdiag_pll1_cp_ctrl_m0_10_8 = fld_set[2];
    cmn_pdiag_pll1_cp_ctrl_m0_14_11 = fld_set[3];
    cmn_pdiag_pll1_cp_ctrl_m0_16_15 = fld_set[4];
    cmn_pdiag_pll1_cp_ctrl_m0_31_17 = fld_set[5];
  endfunction

  function new(input string name="T_cmn_pdiag_pll1_cp_ctrl_m0_1146");
    super.new(name, 32, build_coverage(UVM_CVR_FIELD_VALS));
    if (has_coverage(UVM_CVR_FIELD_VALS)) begin
      wr_fld_covg = new();
      rd_fld_covg = new();
    end
  endfunction

endclass


/////////////////////////////////////////////////////
//                cmn_pdiag_pll1_cp_ctrl_m1
/////////////////////////////////////////////////////
class T_cmn_pdiag_pll1_cp_ctrl_m1_1156 extends cdns_uvm_reg;

  `uvm_object_utils(T_cmn_pdiag_pll1_cp_ctrl_m1_1156)
  rand uvm_reg_field cmn_pdiag_pll1_cp_ctrl_m1_1_0;
  rand uvm_reg_field cmn_pdiag_pll1_cp_ctrl_m1_7_2;
  rand uvm_reg_field cmn_pdiag_pll1_cp_ctrl_m1_10_8;
  rand uvm_reg_field cmn_pdiag_pll1_cp_ctrl_m1_14_11;
  rand uvm_reg_field cmn_pdiag_pll1_cp_ctrl_m1_16_15;
  rand uvm_reg_field cmn_pdiag_pll1_cp_ctrl_m1_31_17;
  
  covergroup wr_fld_covg;
    cmn_pdiag_pll1_cp_ctrl_m1_1_0: coverpoint cmn_pdiag_pll1_cp_ctrl_m1_1_0.value[1:0];
    cmn_pdiag_pll1_cp_ctrl_m1_7_2: coverpoint cmn_pdiag_pll1_cp_ctrl_m1_7_2.value[5:0];
    cmn_pdiag_pll1_cp_ctrl_m1_10_8: coverpoint cmn_pdiag_pll1_cp_ctrl_m1_10_8.value[2:0];
    cmn_pdiag_pll1_cp_ctrl_m1_14_11: coverpoint cmn_pdiag_pll1_cp_ctrl_m1_14_11.value[3:0];
    cmn_pdiag_pll1_cp_ctrl_m1_16_15: coverpoint cmn_pdiag_pll1_cp_ctrl_m1_16_15.value[1:0];
    cmn_pdiag_pll1_cp_ctrl_m1_31_17: coverpoint cmn_pdiag_pll1_cp_ctrl_m1_31_17.value[14:0];
  endgroup
  covergroup rd_fld_covg;
    cmn_pdiag_pll1_cp_ctrl_m1_1_0: coverpoint cmn_pdiag_pll1_cp_ctrl_m1_1_0.value[1:0];
    cmn_pdiag_pll1_cp_ctrl_m1_7_2: coverpoint cmn_pdiag_pll1_cp_ctrl_m1_7_2.value[5:0];
    cmn_pdiag_pll1_cp_ctrl_m1_10_8: coverpoint cmn_pdiag_pll1_cp_ctrl_m1_10_8.value[2:0];
    cmn_pdiag_pll1_cp_ctrl_m1_14_11: coverpoint cmn_pdiag_pll1_cp_ctrl_m1_14_11.value[3:0];
    cmn_pdiag_pll1_cp_ctrl_m1_16_15: coverpoint cmn_pdiag_pll1_cp_ctrl_m1_16_15.value[1:0];
    cmn_pdiag_pll1_cp_ctrl_m1_31_17: coverpoint cmn_pdiag_pll1_cp_ctrl_m1_31_17.value[14:0];
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
    
    cmn_pdiag_pll1_cp_ctrl_m1_1_0 = fld_set[0];
    cmn_pdiag_pll1_cp_ctrl_m1_7_2 = fld_set[1];
    cmn_pdiag_pll1_cp_ctrl_m1_10_8 = fld_set[2];
    cmn_pdiag_pll1_cp_ctrl_m1_14_11 = fld_set[3];
    cmn_pdiag_pll1_cp_ctrl_m1_16_15 = fld_set[4];
    cmn_pdiag_pll1_cp_ctrl_m1_31_17 = fld_set[5];
  endfunction

  function new(input string name="T_cmn_pdiag_pll1_cp_ctrl_m1_1156");
    super.new(name, 32, build_coverage(UVM_CVR_FIELD_VALS));
    if (has_coverage(UVM_CVR_FIELD_VALS)) begin
      wr_fld_covg = new();
      rd_fld_covg = new();
    end
  endfunction

endclass


/////////////////////////////////////////////////////
//                cmn_pdiag_pll1_lock_det_ctrl_m0
/////////////////////////////////////////////////////
class T_cmn_pdiag_pll1_lock_det_ctrl_m0_1149 extends cdns_uvm_reg;

  `uvm_object_utils(T_cmn_pdiag_pll1_lock_det_ctrl_m0_1149)
  rand uvm_reg_field cmn_pdiag_pll1_lock_det_ctrl_m0_5_0;
  rand uvm_reg_field cmn_pdiag_pll1_lock_det_ctrl_m0_31_6;
  
  covergroup wr_fld_covg;
    cmn_pdiag_pll1_lock_det_ctrl_m0_5_0: coverpoint cmn_pdiag_pll1_lock_det_ctrl_m0_5_0.value[5:0];
    cmn_pdiag_pll1_lock_det_ctrl_m0_31_6: coverpoint cmn_pdiag_pll1_lock_det_ctrl_m0_31_6.value[25:0];
  endgroup
  covergroup rd_fld_covg;
    cmn_pdiag_pll1_lock_det_ctrl_m0_5_0: coverpoint cmn_pdiag_pll1_lock_det_ctrl_m0_5_0.value[5:0];
    cmn_pdiag_pll1_lock_det_ctrl_m0_31_6: coverpoint cmn_pdiag_pll1_lock_det_ctrl_m0_31_6.value[25:0];
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
    
    cmn_pdiag_pll1_lock_det_ctrl_m0_5_0 = fld_set[0];
    cmn_pdiag_pll1_lock_det_ctrl_m0_31_6 = fld_set[1];
  endfunction

  function new(input string name="T_cmn_pdiag_pll1_lock_det_ctrl_m0_1149");
    super.new(name, 32, build_coverage(UVM_CVR_FIELD_VALS));
    if (has_coverage(UVM_CVR_FIELD_VALS)) begin
      wr_fld_covg = new();
      rd_fld_covg = new();
    end
  endfunction

endclass


/////////////////////////////////////////////////////
//                cmn_pdiag_pll1_lock_det_ctrl_m1
/////////////////////////////////////////////////////
class T_cmn_pdiag_pll1_lock_det_ctrl_m1_1159 extends cdns_uvm_reg;

  `uvm_object_utils(T_cmn_pdiag_pll1_lock_det_ctrl_m1_1159)
  rand uvm_reg_field cmn_pdiag_pll1_lock_det_ctrl_m1_5_0;
  rand uvm_reg_field cmn_pdiag_pll1_lock_det_ctrl_m1_31_6;
  
  covergroup wr_fld_covg;
    cmn_pdiag_pll1_lock_det_ctrl_m1_5_0: coverpoint cmn_pdiag_pll1_lock_det_ctrl_m1_5_0.value[5:0];
    cmn_pdiag_pll1_lock_det_ctrl_m1_31_6: coverpoint cmn_pdiag_pll1_lock_det_ctrl_m1_31_6.value[25:0];
  endgroup
  covergroup rd_fld_covg;
    cmn_pdiag_pll1_lock_det_ctrl_m1_5_0: coverpoint cmn_pdiag_pll1_lock_det_ctrl_m1_5_0.value[5:0];
    cmn_pdiag_pll1_lock_det_ctrl_m1_31_6: coverpoint cmn_pdiag_pll1_lock_det_ctrl_m1_31_6.value[25:0];
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
    
    cmn_pdiag_pll1_lock_det_ctrl_m1_5_0 = fld_set[0];
    cmn_pdiag_pll1_lock_det_ctrl_m1_31_6 = fld_set[1];
  endfunction

  function new(input string name="T_cmn_pdiag_pll1_lock_det_ctrl_m1_1159");
    super.new(name, 32, build_coverage(UVM_CVR_FIELD_VALS));
    if (has_coverage(UVM_CVR_FIELD_VALS)) begin
      wr_fld_covg = new();
      rd_fld_covg = new();
    end
  endfunction

endclass


/////////////////////////////////////////////////////
//                cmn_pdiag_pll1_lpf_ctrl_m0
/////////////////////////////////////////////////////
class T_cmn_pdiag_pll1_lpf_ctrl_m0_1147 extends cdns_uvm_reg;

  `uvm_object_utils(T_cmn_pdiag_pll1_lpf_ctrl_m0_1147)
  rand uvm_reg_field cmn_pdiag_pll1_lpf_ctrl_m0_4_0;
  rand uvm_reg_field cmn_pdiag_pll1_lpf_ctrl_m0_5;
  rand uvm_reg_field cmn_pdiag_pll1_lpf_ctrl_m0_10_6;
  rand uvm_reg_field cmn_pdiag_pll1_lpf_ctrl_m0_31_11;
  
  covergroup wr_fld_covg;
    cmn_pdiag_pll1_lpf_ctrl_m0_4_0: coverpoint cmn_pdiag_pll1_lpf_ctrl_m0_4_0.value[4:0];
    cmn_pdiag_pll1_lpf_ctrl_m0_5: coverpoint cmn_pdiag_pll1_lpf_ctrl_m0_5.value[0:0];
    cmn_pdiag_pll1_lpf_ctrl_m0_10_6: coverpoint cmn_pdiag_pll1_lpf_ctrl_m0_10_6.value[4:0];
    cmn_pdiag_pll1_lpf_ctrl_m0_31_11: coverpoint cmn_pdiag_pll1_lpf_ctrl_m0_31_11.value[20:0];
  endgroup
  covergroup rd_fld_covg;
    cmn_pdiag_pll1_lpf_ctrl_m0_4_0: coverpoint cmn_pdiag_pll1_lpf_ctrl_m0_4_0.value[4:0];
    cmn_pdiag_pll1_lpf_ctrl_m0_5: coverpoint cmn_pdiag_pll1_lpf_ctrl_m0_5.value[0:0];
    cmn_pdiag_pll1_lpf_ctrl_m0_10_6: coverpoint cmn_pdiag_pll1_lpf_ctrl_m0_10_6.value[4:0];
    cmn_pdiag_pll1_lpf_ctrl_m0_31_11: coverpoint cmn_pdiag_pll1_lpf_ctrl_m0_31_11.value[20:0];
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
    
    cmn_pdiag_pll1_lpf_ctrl_m0_4_0 = fld_set[0];
    cmn_pdiag_pll1_lpf_ctrl_m0_5 = fld_set[1];
    cmn_pdiag_pll1_lpf_ctrl_m0_10_6 = fld_set[2];
    cmn_pdiag_pll1_lpf_ctrl_m0_31_11 = fld_set[3];
  endfunction

  function new(input string name="T_cmn_pdiag_pll1_lpf_ctrl_m0_1147");
    super.new(name, 32, build_coverage(UVM_CVR_FIELD_VALS));
    if (has_coverage(UVM_CVR_FIELD_VALS)) begin
      wr_fld_covg = new();
      rd_fld_covg = new();
    end
  endfunction

endclass


/////////////////////////////////////////////////////
//                cmn_pdiag_pll1_lpf_ctrl_m1
/////////////////////////////////////////////////////
class T_cmn_pdiag_pll1_lpf_ctrl_m1_1157 extends cdns_uvm_reg;

  `uvm_object_utils(T_cmn_pdiag_pll1_lpf_ctrl_m1_1157)
  rand uvm_reg_field cmn_pdiag_pll1_lpf_ctrl_m1_4_0;
  rand uvm_reg_field cmn_pdiag_pll1_lpf_ctrl_m1_5;
  rand uvm_reg_field cmn_pdiag_pll1_lpf_ctrl_m1_10_6;
  rand uvm_reg_field cmn_pdiag_pll1_lpf_ctrl_m1_31_11;
  
  covergroup wr_fld_covg;
    cmn_pdiag_pll1_lpf_ctrl_m1_4_0: coverpoint cmn_pdiag_pll1_lpf_ctrl_m1_4_0.value[4:0];
    cmn_pdiag_pll1_lpf_ctrl_m1_5: coverpoint cmn_pdiag_pll1_lpf_ctrl_m1_5.value[0:0];
    cmn_pdiag_pll1_lpf_ctrl_m1_10_6: coverpoint cmn_pdiag_pll1_lpf_ctrl_m1_10_6.value[4:0];
    cmn_pdiag_pll1_lpf_ctrl_m1_31_11: coverpoint cmn_pdiag_pll1_lpf_ctrl_m1_31_11.value[20:0];
  endgroup
  covergroup rd_fld_covg;
    cmn_pdiag_pll1_lpf_ctrl_m1_4_0: coverpoint cmn_pdiag_pll1_lpf_ctrl_m1_4_0.value[4:0];
    cmn_pdiag_pll1_lpf_ctrl_m1_5: coverpoint cmn_pdiag_pll1_lpf_ctrl_m1_5.value[0:0];
    cmn_pdiag_pll1_lpf_ctrl_m1_10_6: coverpoint cmn_pdiag_pll1_lpf_ctrl_m1_10_6.value[4:0];
    cmn_pdiag_pll1_lpf_ctrl_m1_31_11: coverpoint cmn_pdiag_pll1_lpf_ctrl_m1_31_11.value[20:0];
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
    
    cmn_pdiag_pll1_lpf_ctrl_m1_4_0 = fld_set[0];
    cmn_pdiag_pll1_lpf_ctrl_m1_5 = fld_set[1];
    cmn_pdiag_pll1_lpf_ctrl_m1_10_6 = fld_set[2];
    cmn_pdiag_pll1_lpf_ctrl_m1_31_11 = fld_set[3];
  endfunction

  function new(input string name="T_cmn_pdiag_pll1_lpf_ctrl_m1_1157");
    super.new(name, 32, build_coverage(UVM_CVR_FIELD_VALS));
    if (has_coverage(UVM_CVR_FIELD_VALS)) begin
      wr_fld_covg = new();
      rd_fld_covg = new();
    end
  endfunction

endclass


/////////////////////////////////////////////////////
//                cmn_pdiag_pll1_pfd_ctrl_m0
/////////////////////////////////////////////////////
class T_cmn_pdiag_pll1_pfd_ctrl_m0_1145 extends cdns_uvm_reg;

  `uvm_object_utils(T_cmn_pdiag_pll1_pfd_ctrl_m0_1145)
  rand uvm_reg_field cmn_pdiag_pll1_pfd_ctrl_m0_2_0;
  rand uvm_reg_field cmn_pdiag_pll1_pfd_ctrl_m0_3;
  rand uvm_reg_field cmn_pdiag_pll1_pfd_ctrl_m0_4;
  rand uvm_reg_field cmn_pdiag_pll1_pfd_ctrl_m0_7_5;
  rand uvm_reg_field cmn_pdiag_pll1_pfd_ctrl_m0_8;
  rand uvm_reg_field cmn_pdiag_pll1_pfd_ctrl_m0_31_9;
  
  covergroup wr_fld_covg;
    cmn_pdiag_pll1_pfd_ctrl_m0_2_0: coverpoint cmn_pdiag_pll1_pfd_ctrl_m0_2_0.value[2:0];
    cmn_pdiag_pll1_pfd_ctrl_m0_3: coverpoint cmn_pdiag_pll1_pfd_ctrl_m0_3.value[0:0];
    cmn_pdiag_pll1_pfd_ctrl_m0_4: coverpoint cmn_pdiag_pll1_pfd_ctrl_m0_4.value[0:0];
    cmn_pdiag_pll1_pfd_ctrl_m0_7_5: coverpoint cmn_pdiag_pll1_pfd_ctrl_m0_7_5.value[2:0];
    cmn_pdiag_pll1_pfd_ctrl_m0_8: coverpoint cmn_pdiag_pll1_pfd_ctrl_m0_8.value[0:0];
    cmn_pdiag_pll1_pfd_ctrl_m0_31_9: coverpoint cmn_pdiag_pll1_pfd_ctrl_m0_31_9.value[22:0];
  endgroup
  covergroup rd_fld_covg;
    cmn_pdiag_pll1_pfd_ctrl_m0_2_0: coverpoint cmn_pdiag_pll1_pfd_ctrl_m0_2_0.value[2:0];
    cmn_pdiag_pll1_pfd_ctrl_m0_3: coverpoint cmn_pdiag_pll1_pfd_ctrl_m0_3.value[0:0];
    cmn_pdiag_pll1_pfd_ctrl_m0_4: coverpoint cmn_pdiag_pll1_pfd_ctrl_m0_4.value[0:0];
    cmn_pdiag_pll1_pfd_ctrl_m0_7_5: coverpoint cmn_pdiag_pll1_pfd_ctrl_m0_7_5.value[2:0];
    cmn_pdiag_pll1_pfd_ctrl_m0_8: coverpoint cmn_pdiag_pll1_pfd_ctrl_m0_8.value[0:0];
    cmn_pdiag_pll1_pfd_ctrl_m0_31_9: coverpoint cmn_pdiag_pll1_pfd_ctrl_m0_31_9.value[22:0];
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
    
    cmn_pdiag_pll1_pfd_ctrl_m0_2_0 = fld_set[0];
    cmn_pdiag_pll1_pfd_ctrl_m0_3 = fld_set[1];
    cmn_pdiag_pll1_pfd_ctrl_m0_4 = fld_set[2];
    cmn_pdiag_pll1_pfd_ctrl_m0_7_5 = fld_set[3];
    cmn_pdiag_pll1_pfd_ctrl_m0_8 = fld_set[4];
    cmn_pdiag_pll1_pfd_ctrl_m0_31_9 = fld_set[5];
  endfunction

  function new(input string name="T_cmn_pdiag_pll1_pfd_ctrl_m0_1145");
    super.new(name, 32, build_coverage(UVM_CVR_FIELD_VALS));
    if (has_coverage(UVM_CVR_FIELD_VALS)) begin
      wr_fld_covg = new();
      rd_fld_covg = new();
    end
  endfunction

endclass


/////////////////////////////////////////////////////
//                cmn_pdiag_pll1_pfd_ctrl_m1
/////////////////////////////////////////////////////
class T_cmn_pdiag_pll1_pfd_ctrl_m1_1155 extends cdns_uvm_reg;

  `uvm_object_utils(T_cmn_pdiag_pll1_pfd_ctrl_m1_1155)
  rand uvm_reg_field cmn_pdiag_pll1_pfd_ctrl_m1_2_0;
  rand uvm_reg_field cmn_pdiag_pll1_pfd_ctrl_m1_3;
  rand uvm_reg_field cmn_pdiag_pll1_pfd_ctrl_m1_4;
  rand uvm_reg_field cmn_pdiag_pll1_pfd_ctrl_m1_7_5;
  rand uvm_reg_field cmn_pdiag_pll1_pfd_ctrl_m1_8;
  rand uvm_reg_field cmn_pdiag_pll1_pfd_ctrl_m1_31_9;
  
  covergroup wr_fld_covg;
    cmn_pdiag_pll1_pfd_ctrl_m1_2_0: coverpoint cmn_pdiag_pll1_pfd_ctrl_m1_2_0.value[2:0];
    cmn_pdiag_pll1_pfd_ctrl_m1_3: coverpoint cmn_pdiag_pll1_pfd_ctrl_m1_3.value[0:0];
    cmn_pdiag_pll1_pfd_ctrl_m1_4: coverpoint cmn_pdiag_pll1_pfd_ctrl_m1_4.value[0:0];
    cmn_pdiag_pll1_pfd_ctrl_m1_7_5: coverpoint cmn_pdiag_pll1_pfd_ctrl_m1_7_5.value[2:0];
    cmn_pdiag_pll1_pfd_ctrl_m1_8: coverpoint cmn_pdiag_pll1_pfd_ctrl_m1_8.value[0:0];
    cmn_pdiag_pll1_pfd_ctrl_m1_31_9: coverpoint cmn_pdiag_pll1_pfd_ctrl_m1_31_9.value[22:0];
  endgroup
  covergroup rd_fld_covg;
    cmn_pdiag_pll1_pfd_ctrl_m1_2_0: coverpoint cmn_pdiag_pll1_pfd_ctrl_m1_2_0.value[2:0];
    cmn_pdiag_pll1_pfd_ctrl_m1_3: coverpoint cmn_pdiag_pll1_pfd_ctrl_m1_3.value[0:0];
    cmn_pdiag_pll1_pfd_ctrl_m1_4: coverpoint cmn_pdiag_pll1_pfd_ctrl_m1_4.value[0:0];
    cmn_pdiag_pll1_pfd_ctrl_m1_7_5: coverpoint cmn_pdiag_pll1_pfd_ctrl_m1_7_5.value[2:0];
    cmn_pdiag_pll1_pfd_ctrl_m1_8: coverpoint cmn_pdiag_pll1_pfd_ctrl_m1_8.value[0:0];
    cmn_pdiag_pll1_pfd_ctrl_m1_31_9: coverpoint cmn_pdiag_pll1_pfd_ctrl_m1_31_9.value[22:0];
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
    
    cmn_pdiag_pll1_pfd_ctrl_m1_2_0 = fld_set[0];
    cmn_pdiag_pll1_pfd_ctrl_m1_3 = fld_set[1];
    cmn_pdiag_pll1_pfd_ctrl_m1_4 = fld_set[2];
    cmn_pdiag_pll1_pfd_ctrl_m1_7_5 = fld_set[3];
    cmn_pdiag_pll1_pfd_ctrl_m1_8 = fld_set[4];
    cmn_pdiag_pll1_pfd_ctrl_m1_31_9 = fld_set[5];
  endfunction

  function new(input string name="T_cmn_pdiag_pll1_pfd_ctrl_m1_1155");
    super.new(name, 32, build_coverage(UVM_CVR_FIELD_VALS));
    if (has_coverage(UVM_CVR_FIELD_VALS)) begin
      wr_fld_covg = new();
      rd_fld_covg = new();
    end
  endfunction

endclass


/////////////////////////////////////////////////////
//                cmn_pdiag_pll1_post_div_m0
/////////////////////////////////////////////////////
class T_cmn_pdiag_pll1_post_div_m0_1150 extends cdns_uvm_reg;

  `uvm_object_utils(T_cmn_pdiag_pll1_post_div_m0_1150)
  rand uvm_reg_field cmn_pdiag_pll1_post_div_m0_2_0;
  rand uvm_reg_field cmn_pdiag_pll1_post_div_m0_31_3;
  
  covergroup wr_fld_covg;
    cmn_pdiag_pll1_post_div_m0_2_0: coverpoint cmn_pdiag_pll1_post_div_m0_2_0.value[2:0];
    cmn_pdiag_pll1_post_div_m0_31_3: coverpoint cmn_pdiag_pll1_post_div_m0_31_3.value[28:0];
  endgroup
  covergroup rd_fld_covg;
    cmn_pdiag_pll1_post_div_m0_2_0: coverpoint cmn_pdiag_pll1_post_div_m0_2_0.value[2:0];
    cmn_pdiag_pll1_post_div_m0_31_3: coverpoint cmn_pdiag_pll1_post_div_m0_31_3.value[28:0];
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
    
    cmn_pdiag_pll1_post_div_m0_2_0 = fld_set[0];
    cmn_pdiag_pll1_post_div_m0_31_3 = fld_set[1];
  endfunction

  function new(input string name="T_cmn_pdiag_pll1_post_div_m0_1150");
    super.new(name, 32, build_coverage(UVM_CVR_FIELD_VALS));
    if (has_coverage(UVM_CVR_FIELD_VALS)) begin
      wr_fld_covg = new();
      rd_fld_covg = new();
    end
  endfunction

endclass


/////////////////////////////////////////////////////
//                cmn_pdiag_pll1_post_div_m1
/////////////////////////////////////////////////////
class T_cmn_pdiag_pll1_post_div_m1_1160 extends cdns_uvm_reg;

  `uvm_object_utils(T_cmn_pdiag_pll1_post_div_m1_1160)
  rand uvm_reg_field cmn_pdiag_pll1_post_div_m1_2_0;
  rand uvm_reg_field cmn_pdiag_pll1_post_div_m1_31_3;
  
  covergroup wr_fld_covg;
    cmn_pdiag_pll1_post_div_m1_2_0: coverpoint cmn_pdiag_pll1_post_div_m1_2_0.value[2:0];
    cmn_pdiag_pll1_post_div_m1_31_3: coverpoint cmn_pdiag_pll1_post_div_m1_31_3.value[28:0];
  endgroup
  covergroup rd_fld_covg;
    cmn_pdiag_pll1_post_div_m1_2_0: coverpoint cmn_pdiag_pll1_post_div_m1_2_0.value[2:0];
    cmn_pdiag_pll1_post_div_m1_31_3: coverpoint cmn_pdiag_pll1_post_div_m1_31_3.value[28:0];
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
    
    cmn_pdiag_pll1_post_div_m1_2_0 = fld_set[0];
    cmn_pdiag_pll1_post_div_m1_31_3 = fld_set[1];
  endfunction

  function new(input string name="T_cmn_pdiag_pll1_post_div_m1_1160");
    super.new(name, 32, build_coverage(UVM_CVR_FIELD_VALS));
    if (has_coverage(UVM_CVR_FIELD_VALS)) begin
      wr_fld_covg = new();
      rd_fld_covg = new();
    end
  endfunction

endclass


/////////////////////////////////////////////////////
//                cmn_pdiag_pll1_prog0_clk_ctrl_m0
/////////////////////////////////////////////////////
class T_cmn_pdiag_pll1_prog0_clk_ctrl_m0_1152 extends cdns_uvm_reg;

  `uvm_object_utils(T_cmn_pdiag_pll1_prog0_clk_ctrl_m0_1152)
  rand uvm_reg_field cmn_pdiag_pll1_prog0_clk_ctrl_m0_0;
  rand uvm_reg_field cmn_pdiag_pll1_prog0_clk_ctrl_m0_1;
  rand uvm_reg_field cmn_pdiag_pll1_prog0_clk_ctrl_m0_2;
  rand uvm_reg_field cmn_pdiag_pll1_prog0_clk_ctrl_m0_7_3;
  rand uvm_reg_field cmn_pdiag_pll1_prog0_clk_ctrl_m0_11_8;
  rand uvm_reg_field cmn_pdiag_pll1_prog0_clk_ctrl_m0_15_12;
  rand uvm_reg_field cmn_pdiag_pll1_prog0_clk_ctrl_m0_22_16;
  rand uvm_reg_field cmn_pdiag_pll1_prog0_clk_ctrl_m0_23;
  rand uvm_reg_field cmn_pdiag_pll1_prog0_clk_ctrl_m0_30_24;
  rand uvm_reg_field cmn_pdiag_pll1_prog0_clk_ctrl_m0_31;
  
  covergroup wr_fld_covg;
    cmn_pdiag_pll1_prog0_clk_ctrl_m0_0: coverpoint cmn_pdiag_pll1_prog0_clk_ctrl_m0_0.value[0:0];
    cmn_pdiag_pll1_prog0_clk_ctrl_m0_1: coverpoint cmn_pdiag_pll1_prog0_clk_ctrl_m0_1.value[0:0];
    cmn_pdiag_pll1_prog0_clk_ctrl_m0_2: coverpoint cmn_pdiag_pll1_prog0_clk_ctrl_m0_2.value[0:0];
    cmn_pdiag_pll1_prog0_clk_ctrl_m0_7_3: coverpoint cmn_pdiag_pll1_prog0_clk_ctrl_m0_7_3.value[4:0];
    cmn_pdiag_pll1_prog0_clk_ctrl_m0_11_8: coverpoint cmn_pdiag_pll1_prog0_clk_ctrl_m0_11_8.value[3:0];
    cmn_pdiag_pll1_prog0_clk_ctrl_m0_15_12: coverpoint cmn_pdiag_pll1_prog0_clk_ctrl_m0_15_12.value[3:0];
    cmn_pdiag_pll1_prog0_clk_ctrl_m0_22_16: coverpoint cmn_pdiag_pll1_prog0_clk_ctrl_m0_22_16.value[6:0];
    cmn_pdiag_pll1_prog0_clk_ctrl_m0_23: coverpoint cmn_pdiag_pll1_prog0_clk_ctrl_m0_23.value[0:0];
    cmn_pdiag_pll1_prog0_clk_ctrl_m0_30_24: coverpoint cmn_pdiag_pll1_prog0_clk_ctrl_m0_30_24.value[6:0];
    cmn_pdiag_pll1_prog0_clk_ctrl_m0_31: coverpoint cmn_pdiag_pll1_prog0_clk_ctrl_m0_31.value[0:0];
  endgroup
  covergroup rd_fld_covg;
    cmn_pdiag_pll1_prog0_clk_ctrl_m0_0: coverpoint cmn_pdiag_pll1_prog0_clk_ctrl_m0_0.value[0:0];
    cmn_pdiag_pll1_prog0_clk_ctrl_m0_1: coverpoint cmn_pdiag_pll1_prog0_clk_ctrl_m0_1.value[0:0];
    cmn_pdiag_pll1_prog0_clk_ctrl_m0_2: coverpoint cmn_pdiag_pll1_prog0_clk_ctrl_m0_2.value[0:0];
    cmn_pdiag_pll1_prog0_clk_ctrl_m0_7_3: coverpoint cmn_pdiag_pll1_prog0_clk_ctrl_m0_7_3.value[4:0];
    cmn_pdiag_pll1_prog0_clk_ctrl_m0_11_8: coverpoint cmn_pdiag_pll1_prog0_clk_ctrl_m0_11_8.value[3:0];
    cmn_pdiag_pll1_prog0_clk_ctrl_m0_15_12: coverpoint cmn_pdiag_pll1_prog0_clk_ctrl_m0_15_12.value[3:0];
    cmn_pdiag_pll1_prog0_clk_ctrl_m0_22_16: coverpoint cmn_pdiag_pll1_prog0_clk_ctrl_m0_22_16.value[6:0];
    cmn_pdiag_pll1_prog0_clk_ctrl_m0_23: coverpoint cmn_pdiag_pll1_prog0_clk_ctrl_m0_23.value[0:0];
    cmn_pdiag_pll1_prog0_clk_ctrl_m0_30_24: coverpoint cmn_pdiag_pll1_prog0_clk_ctrl_m0_30_24.value[6:0];
    cmn_pdiag_pll1_prog0_clk_ctrl_m0_31: coverpoint cmn_pdiag_pll1_prog0_clk_ctrl_m0_31.value[0:0];
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
    
    cmn_pdiag_pll1_prog0_clk_ctrl_m0_0 = fld_set[0];
    cmn_pdiag_pll1_prog0_clk_ctrl_m0_1 = fld_set[1];
    cmn_pdiag_pll1_prog0_clk_ctrl_m0_2 = fld_set[2];
    cmn_pdiag_pll1_prog0_clk_ctrl_m0_7_3 = fld_set[3];
    cmn_pdiag_pll1_prog0_clk_ctrl_m0_11_8 = fld_set[4];
    cmn_pdiag_pll1_prog0_clk_ctrl_m0_15_12 = fld_set[5];
    cmn_pdiag_pll1_prog0_clk_ctrl_m0_22_16 = fld_set[6];
    cmn_pdiag_pll1_prog0_clk_ctrl_m0_23 = fld_set[7];
    cmn_pdiag_pll1_prog0_clk_ctrl_m0_30_24 = fld_set[8];
    cmn_pdiag_pll1_prog0_clk_ctrl_m0_31 = fld_set[9];
  endfunction

  function new(input string name="T_cmn_pdiag_pll1_prog0_clk_ctrl_m0_1152");
    super.new(name, 32, build_coverage(UVM_CVR_FIELD_VALS));
    if (has_coverage(UVM_CVR_FIELD_VALS)) begin
      wr_fld_covg = new();
      rd_fld_covg = new();
    end
  endfunction

endclass


/////////////////////////////////////////////////////
//                cmn_pdiag_pll1_prog0_clk_ctrl_m1
/////////////////////////////////////////////////////
class T_cmn_pdiag_pll1_prog0_clk_ctrl_m1_1162 extends cdns_uvm_reg;

  `uvm_object_utils(T_cmn_pdiag_pll1_prog0_clk_ctrl_m1_1162)
  rand uvm_reg_field cmn_pdiag_pll1_prog0_clk_ctrl_m1_0;
  rand uvm_reg_field cmn_pdiag_pll1_prog0_clk_ctrl_m1_1;
  rand uvm_reg_field cmn_pdiag_pll1_prog0_clk_ctrl_m1_2;
  rand uvm_reg_field cmn_pdiag_pll1_prog0_clk_ctrl_m1_7_3;
  rand uvm_reg_field cmn_pdiag_pll1_prog0_clk_ctrl_m1_11_8;
  rand uvm_reg_field cmn_pdiag_pll1_prog0_clk_ctrl_m1_15_12;
  rand uvm_reg_field cmn_pdiag_pll1_prog0_clk_ctrl_m1_22_16;
  rand uvm_reg_field cmn_pdiag_pll1_prog0_clk_ctrl_m1_23;
  rand uvm_reg_field cmn_pdiag_pll1_prog0_clk_ctrl_m1_30_24;
  rand uvm_reg_field cmn_pdiag_pll1_prog0_clk_ctrl_m1_31;
  
  covergroup wr_fld_covg;
    cmn_pdiag_pll1_prog0_clk_ctrl_m1_0: coverpoint cmn_pdiag_pll1_prog0_clk_ctrl_m1_0.value[0:0];
    cmn_pdiag_pll1_prog0_clk_ctrl_m1_1: coverpoint cmn_pdiag_pll1_prog0_clk_ctrl_m1_1.value[0:0];
    cmn_pdiag_pll1_prog0_clk_ctrl_m1_2: coverpoint cmn_pdiag_pll1_prog0_clk_ctrl_m1_2.value[0:0];
    cmn_pdiag_pll1_prog0_clk_ctrl_m1_7_3: coverpoint cmn_pdiag_pll1_prog0_clk_ctrl_m1_7_3.value[4:0];
    cmn_pdiag_pll1_prog0_clk_ctrl_m1_11_8: coverpoint cmn_pdiag_pll1_prog0_clk_ctrl_m1_11_8.value[3:0];
    cmn_pdiag_pll1_prog0_clk_ctrl_m1_15_12: coverpoint cmn_pdiag_pll1_prog0_clk_ctrl_m1_15_12.value[3:0];
    cmn_pdiag_pll1_prog0_clk_ctrl_m1_22_16: coverpoint cmn_pdiag_pll1_prog0_clk_ctrl_m1_22_16.value[6:0];
    cmn_pdiag_pll1_prog0_clk_ctrl_m1_23: coverpoint cmn_pdiag_pll1_prog0_clk_ctrl_m1_23.value[0:0];
    cmn_pdiag_pll1_prog0_clk_ctrl_m1_30_24: coverpoint cmn_pdiag_pll1_prog0_clk_ctrl_m1_30_24.value[6:0];
    cmn_pdiag_pll1_prog0_clk_ctrl_m1_31: coverpoint cmn_pdiag_pll1_prog0_clk_ctrl_m1_31.value[0:0];
  endgroup
  covergroup rd_fld_covg;
    cmn_pdiag_pll1_prog0_clk_ctrl_m1_0: coverpoint cmn_pdiag_pll1_prog0_clk_ctrl_m1_0.value[0:0];
    cmn_pdiag_pll1_prog0_clk_ctrl_m1_1: coverpoint cmn_pdiag_pll1_prog0_clk_ctrl_m1_1.value[0:0];
    cmn_pdiag_pll1_prog0_clk_ctrl_m1_2: coverpoint cmn_pdiag_pll1_prog0_clk_ctrl_m1_2.value[0:0];
    cmn_pdiag_pll1_prog0_clk_ctrl_m1_7_3: coverpoint cmn_pdiag_pll1_prog0_clk_ctrl_m1_7_3.value[4:0];
    cmn_pdiag_pll1_prog0_clk_ctrl_m1_11_8: coverpoint cmn_pdiag_pll1_prog0_clk_ctrl_m1_11_8.value[3:0];
    cmn_pdiag_pll1_prog0_clk_ctrl_m1_15_12: coverpoint cmn_pdiag_pll1_prog0_clk_ctrl_m1_15_12.value[3:0];
    cmn_pdiag_pll1_prog0_clk_ctrl_m1_22_16: coverpoint cmn_pdiag_pll1_prog0_clk_ctrl_m1_22_16.value[6:0];
    cmn_pdiag_pll1_prog0_clk_ctrl_m1_23: coverpoint cmn_pdiag_pll1_prog0_clk_ctrl_m1_23.value[0:0];
    cmn_pdiag_pll1_prog0_clk_ctrl_m1_30_24: coverpoint cmn_pdiag_pll1_prog0_clk_ctrl_m1_30_24.value[6:0];
    cmn_pdiag_pll1_prog0_clk_ctrl_m1_31: coverpoint cmn_pdiag_pll1_prog0_clk_ctrl_m1_31.value[0:0];
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
    
    cmn_pdiag_pll1_prog0_clk_ctrl_m1_0 = fld_set[0];
    cmn_pdiag_pll1_prog0_clk_ctrl_m1_1 = fld_set[1];
    cmn_pdiag_pll1_prog0_clk_ctrl_m1_2 = fld_set[2];
    cmn_pdiag_pll1_prog0_clk_ctrl_m1_7_3 = fld_set[3];
    cmn_pdiag_pll1_prog0_clk_ctrl_m1_11_8 = fld_set[4];
    cmn_pdiag_pll1_prog0_clk_ctrl_m1_15_12 = fld_set[5];
    cmn_pdiag_pll1_prog0_clk_ctrl_m1_22_16 = fld_set[6];
    cmn_pdiag_pll1_prog0_clk_ctrl_m1_23 = fld_set[7];
    cmn_pdiag_pll1_prog0_clk_ctrl_m1_30_24 = fld_set[8];
    cmn_pdiag_pll1_prog0_clk_ctrl_m1_31 = fld_set[9];
  endfunction

  function new(input string name="T_cmn_pdiag_pll1_prog0_clk_ctrl_m1_1162");
    super.new(name, 32, build_coverage(UVM_CVR_FIELD_VALS));
    if (has_coverage(UVM_CVR_FIELD_VALS)) begin
      wr_fld_covg = new();
      rd_fld_covg = new();
    end
  endfunction

endclass


/////////////////////////////////////////////////////
//                cmn_pdiag_pll1_prog1_clk_ctrl_m0
/////////////////////////////////////////////////////
class T_cmn_pdiag_pll1_prog1_clk_ctrl_m0_1153 extends cdns_uvm_reg;

  `uvm_object_utils(T_cmn_pdiag_pll1_prog1_clk_ctrl_m0_1153)
  rand uvm_reg_field cmn_pdiag_pll1_prog1_clk_ctrl_m0_0;
  rand uvm_reg_field cmn_pdiag_pll1_prog1_clk_ctrl_m0_1;
  rand uvm_reg_field cmn_pdiag_pll1_prog1_clk_ctrl_m0_2;
  rand uvm_reg_field cmn_pdiag_pll1_prog1_clk_ctrl_m0_7_3;
  rand uvm_reg_field cmn_pdiag_pll1_prog1_clk_ctrl_m0_11_8;
  rand uvm_reg_field cmn_pdiag_pll1_prog1_clk_ctrl_m0_15_12;
  rand uvm_reg_field cmn_pdiag_pll1_prog1_clk_ctrl_m0_22_16;
  rand uvm_reg_field cmn_pdiag_pll1_prog1_clk_ctrl_m0_23;
  rand uvm_reg_field cmn_pdiag_pll1_prog1_clk_ctrl_m0_30_24;
  rand uvm_reg_field cmn_pdiag_pll1_prog1_clk_ctrl_m0_31;
  
  covergroup wr_fld_covg;
    cmn_pdiag_pll1_prog1_clk_ctrl_m0_0: coverpoint cmn_pdiag_pll1_prog1_clk_ctrl_m0_0.value[0:0];
    cmn_pdiag_pll1_prog1_clk_ctrl_m0_1: coverpoint cmn_pdiag_pll1_prog1_clk_ctrl_m0_1.value[0:0];
    cmn_pdiag_pll1_prog1_clk_ctrl_m0_2: coverpoint cmn_pdiag_pll1_prog1_clk_ctrl_m0_2.value[0:0];
    cmn_pdiag_pll1_prog1_clk_ctrl_m0_7_3: coverpoint cmn_pdiag_pll1_prog1_clk_ctrl_m0_7_3.value[4:0];
    cmn_pdiag_pll1_prog1_clk_ctrl_m0_11_8: coverpoint cmn_pdiag_pll1_prog1_clk_ctrl_m0_11_8.value[3:0];
    cmn_pdiag_pll1_prog1_clk_ctrl_m0_15_12: coverpoint cmn_pdiag_pll1_prog1_clk_ctrl_m0_15_12.value[3:0];
    cmn_pdiag_pll1_prog1_clk_ctrl_m0_22_16: coverpoint cmn_pdiag_pll1_prog1_clk_ctrl_m0_22_16.value[6:0];
    cmn_pdiag_pll1_prog1_clk_ctrl_m0_23: coverpoint cmn_pdiag_pll1_prog1_clk_ctrl_m0_23.value[0:0];
    cmn_pdiag_pll1_prog1_clk_ctrl_m0_30_24: coverpoint cmn_pdiag_pll1_prog1_clk_ctrl_m0_30_24.value[6:0];
    cmn_pdiag_pll1_prog1_clk_ctrl_m0_31: coverpoint cmn_pdiag_pll1_prog1_clk_ctrl_m0_31.value[0:0];
  endgroup
  covergroup rd_fld_covg;
    cmn_pdiag_pll1_prog1_clk_ctrl_m0_0: coverpoint cmn_pdiag_pll1_prog1_clk_ctrl_m0_0.value[0:0];
    cmn_pdiag_pll1_prog1_clk_ctrl_m0_1: coverpoint cmn_pdiag_pll1_prog1_clk_ctrl_m0_1.value[0:0];
    cmn_pdiag_pll1_prog1_clk_ctrl_m0_2: coverpoint cmn_pdiag_pll1_prog1_clk_ctrl_m0_2.value[0:0];
    cmn_pdiag_pll1_prog1_clk_ctrl_m0_7_3: coverpoint cmn_pdiag_pll1_prog1_clk_ctrl_m0_7_3.value[4:0];
    cmn_pdiag_pll1_prog1_clk_ctrl_m0_11_8: coverpoint cmn_pdiag_pll1_prog1_clk_ctrl_m0_11_8.value[3:0];
    cmn_pdiag_pll1_prog1_clk_ctrl_m0_15_12: coverpoint cmn_pdiag_pll1_prog1_clk_ctrl_m0_15_12.value[3:0];
    cmn_pdiag_pll1_prog1_clk_ctrl_m0_22_16: coverpoint cmn_pdiag_pll1_prog1_clk_ctrl_m0_22_16.value[6:0];
    cmn_pdiag_pll1_prog1_clk_ctrl_m0_23: coverpoint cmn_pdiag_pll1_prog1_clk_ctrl_m0_23.value[0:0];
    cmn_pdiag_pll1_prog1_clk_ctrl_m0_30_24: coverpoint cmn_pdiag_pll1_prog1_clk_ctrl_m0_30_24.value[6:0];
    cmn_pdiag_pll1_prog1_clk_ctrl_m0_31: coverpoint cmn_pdiag_pll1_prog1_clk_ctrl_m0_31.value[0:0];
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
    
    cmn_pdiag_pll1_prog1_clk_ctrl_m0_0 = fld_set[0];
    cmn_pdiag_pll1_prog1_clk_ctrl_m0_1 = fld_set[1];
    cmn_pdiag_pll1_prog1_clk_ctrl_m0_2 = fld_set[2];
    cmn_pdiag_pll1_prog1_clk_ctrl_m0_7_3 = fld_set[3];
    cmn_pdiag_pll1_prog1_clk_ctrl_m0_11_8 = fld_set[4];
    cmn_pdiag_pll1_prog1_clk_ctrl_m0_15_12 = fld_set[5];
    cmn_pdiag_pll1_prog1_clk_ctrl_m0_22_16 = fld_set[6];
    cmn_pdiag_pll1_prog1_clk_ctrl_m0_23 = fld_set[7];
    cmn_pdiag_pll1_prog1_clk_ctrl_m0_30_24 = fld_set[8];
    cmn_pdiag_pll1_prog1_clk_ctrl_m0_31 = fld_set[9];
  endfunction

  function new(input string name="T_cmn_pdiag_pll1_prog1_clk_ctrl_m0_1153");
    super.new(name, 32, build_coverage(UVM_CVR_FIELD_VALS));
    if (has_coverage(UVM_CVR_FIELD_VALS)) begin
      wr_fld_covg = new();
      rd_fld_covg = new();
    end
  endfunction

endclass


/////////////////////////////////////////////////////
//                cmn_pdiag_pll1_prog1_clk_ctrl_m1
/////////////////////////////////////////////////////
class T_cmn_pdiag_pll1_prog1_clk_ctrl_m1_1163 extends cdns_uvm_reg;

  `uvm_object_utils(T_cmn_pdiag_pll1_prog1_clk_ctrl_m1_1163)
  rand uvm_reg_field cmn_pdiag_pll1_prog1_clk_ctrl_m1_0;
  rand uvm_reg_field cmn_pdiag_pll1_prog1_clk_ctrl_m1_1;
  rand uvm_reg_field cmn_pdiag_pll1_prog1_clk_ctrl_m1_2;
  rand uvm_reg_field cmn_pdiag_pll1_prog1_clk_ctrl_m1_7_3;
  rand uvm_reg_field cmn_pdiag_pll1_prog1_clk_ctrl_m1_11_8;
  rand uvm_reg_field cmn_pdiag_pll1_prog1_clk_ctrl_m1_15_12;
  rand uvm_reg_field cmn_pdiag_pll1_prog1_clk_ctrl_m1_22_16;
  rand uvm_reg_field cmn_pdiag_pll1_prog1_clk_ctrl_m1_23;
  rand uvm_reg_field cmn_pdiag_pll1_prog1_clk_ctrl_m1_30_24;
  rand uvm_reg_field cmn_pdiag_pll1_prog1_clk_ctrl_m1_31;
  
  covergroup wr_fld_covg;
    cmn_pdiag_pll1_prog1_clk_ctrl_m1_0: coverpoint cmn_pdiag_pll1_prog1_clk_ctrl_m1_0.value[0:0];
    cmn_pdiag_pll1_prog1_clk_ctrl_m1_1: coverpoint cmn_pdiag_pll1_prog1_clk_ctrl_m1_1.value[0:0];
    cmn_pdiag_pll1_prog1_clk_ctrl_m1_2: coverpoint cmn_pdiag_pll1_prog1_clk_ctrl_m1_2.value[0:0];
    cmn_pdiag_pll1_prog1_clk_ctrl_m1_7_3: coverpoint cmn_pdiag_pll1_prog1_clk_ctrl_m1_7_3.value[4:0];
    cmn_pdiag_pll1_prog1_clk_ctrl_m1_11_8: coverpoint cmn_pdiag_pll1_prog1_clk_ctrl_m1_11_8.value[3:0];
    cmn_pdiag_pll1_prog1_clk_ctrl_m1_15_12: coverpoint cmn_pdiag_pll1_prog1_clk_ctrl_m1_15_12.value[3:0];
    cmn_pdiag_pll1_prog1_clk_ctrl_m1_22_16: coverpoint cmn_pdiag_pll1_prog1_clk_ctrl_m1_22_16.value[6:0];
    cmn_pdiag_pll1_prog1_clk_ctrl_m1_23: coverpoint cmn_pdiag_pll1_prog1_clk_ctrl_m1_23.value[0:0];
    cmn_pdiag_pll1_prog1_clk_ctrl_m1_30_24: coverpoint cmn_pdiag_pll1_prog1_clk_ctrl_m1_30_24.value[6:0];
    cmn_pdiag_pll1_prog1_clk_ctrl_m1_31: coverpoint cmn_pdiag_pll1_prog1_clk_ctrl_m1_31.value[0:0];
  endgroup
  covergroup rd_fld_covg;
    cmn_pdiag_pll1_prog1_clk_ctrl_m1_0: coverpoint cmn_pdiag_pll1_prog1_clk_ctrl_m1_0.value[0:0];
    cmn_pdiag_pll1_prog1_clk_ctrl_m1_1: coverpoint cmn_pdiag_pll1_prog1_clk_ctrl_m1_1.value[0:0];
    cmn_pdiag_pll1_prog1_clk_ctrl_m1_2: coverpoint cmn_pdiag_pll1_prog1_clk_ctrl_m1_2.value[0:0];
    cmn_pdiag_pll1_prog1_clk_ctrl_m1_7_3: coverpoint cmn_pdiag_pll1_prog1_clk_ctrl_m1_7_3.value[4:0];
    cmn_pdiag_pll1_prog1_clk_ctrl_m1_11_8: coverpoint cmn_pdiag_pll1_prog1_clk_ctrl_m1_11_8.value[3:0];
    cmn_pdiag_pll1_prog1_clk_ctrl_m1_15_12: coverpoint cmn_pdiag_pll1_prog1_clk_ctrl_m1_15_12.value[3:0];
    cmn_pdiag_pll1_prog1_clk_ctrl_m1_22_16: coverpoint cmn_pdiag_pll1_prog1_clk_ctrl_m1_22_16.value[6:0];
    cmn_pdiag_pll1_prog1_clk_ctrl_m1_23: coverpoint cmn_pdiag_pll1_prog1_clk_ctrl_m1_23.value[0:0];
    cmn_pdiag_pll1_prog1_clk_ctrl_m1_30_24: coverpoint cmn_pdiag_pll1_prog1_clk_ctrl_m1_30_24.value[6:0];
    cmn_pdiag_pll1_prog1_clk_ctrl_m1_31: coverpoint cmn_pdiag_pll1_prog1_clk_ctrl_m1_31.value[0:0];
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
    
    cmn_pdiag_pll1_prog1_clk_ctrl_m1_0 = fld_set[0];
    cmn_pdiag_pll1_prog1_clk_ctrl_m1_1 = fld_set[1];
    cmn_pdiag_pll1_prog1_clk_ctrl_m1_2 = fld_set[2];
    cmn_pdiag_pll1_prog1_clk_ctrl_m1_7_3 = fld_set[3];
    cmn_pdiag_pll1_prog1_clk_ctrl_m1_11_8 = fld_set[4];
    cmn_pdiag_pll1_prog1_clk_ctrl_m1_15_12 = fld_set[5];
    cmn_pdiag_pll1_prog1_clk_ctrl_m1_22_16 = fld_set[6];
    cmn_pdiag_pll1_prog1_clk_ctrl_m1_23 = fld_set[7];
    cmn_pdiag_pll1_prog1_clk_ctrl_m1_30_24 = fld_set[8];
    cmn_pdiag_pll1_prog1_clk_ctrl_m1_31 = fld_set[9];
  endfunction

  function new(input string name="T_cmn_pdiag_pll1_prog1_clk_ctrl_m1_1163");
    super.new(name, 32, build_coverage(UVM_CVR_FIELD_VALS));
    if (has_coverage(UVM_CVR_FIELD_VALS)) begin
      wr_fld_covg = new();
      rd_fld_covg = new();
    end
  endfunction

endclass


/////////////////////////////////////////////////////
//                cmn_pdiag_pll1_ref_clk_div_sel_m0
/////////////////////////////////////////////////////
class T_cmn_pdiag_pll1_ref_clk_div_sel_m0_1151 extends cdns_uvm_reg;

  `uvm_object_utils(T_cmn_pdiag_pll1_ref_clk_div_sel_m0_1151)
  rand uvm_reg_field cmn_pdiag_pll1_ref_clk_div_sel_m0_5_0;
  rand uvm_reg_field cmn_pdiag_pll1_ref_clk_div_sel_m0_31_6;
  
  covergroup wr_fld_covg;
    cmn_pdiag_pll1_ref_clk_div_sel_m0_5_0: coverpoint cmn_pdiag_pll1_ref_clk_div_sel_m0_5_0.value[5:0];
    cmn_pdiag_pll1_ref_clk_div_sel_m0_31_6: coverpoint cmn_pdiag_pll1_ref_clk_div_sel_m0_31_6.value[25:0];
  endgroup
  covergroup rd_fld_covg;
    cmn_pdiag_pll1_ref_clk_div_sel_m0_5_0: coverpoint cmn_pdiag_pll1_ref_clk_div_sel_m0_5_0.value[5:0];
    cmn_pdiag_pll1_ref_clk_div_sel_m0_31_6: coverpoint cmn_pdiag_pll1_ref_clk_div_sel_m0_31_6.value[25:0];
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
    
    cmn_pdiag_pll1_ref_clk_div_sel_m0_5_0 = fld_set[0];
    cmn_pdiag_pll1_ref_clk_div_sel_m0_31_6 = fld_set[1];
  endfunction

  function new(input string name="T_cmn_pdiag_pll1_ref_clk_div_sel_m0_1151");
    super.new(name, 32, build_coverage(UVM_CVR_FIELD_VALS));
    if (has_coverage(UVM_CVR_FIELD_VALS)) begin
      wr_fld_covg = new();
      rd_fld_covg = new();
    end
  endfunction

endclass


/////////////////////////////////////////////////////
//                cmn_pdiag_pll1_ref_clk_div_sel_m1
/////////////////////////////////////////////////////
class T_cmn_pdiag_pll1_ref_clk_div_sel_m1_1161 extends cdns_uvm_reg;

  `uvm_object_utils(T_cmn_pdiag_pll1_ref_clk_div_sel_m1_1161)
  rand uvm_reg_field cmn_pdiag_pll1_ref_clk_div_sel_m1_5_0;
  rand uvm_reg_field cmn_pdiag_pll1_ref_clk_div_sel_m1_31_6;
  
  covergroup wr_fld_covg;
    cmn_pdiag_pll1_ref_clk_div_sel_m1_5_0: coverpoint cmn_pdiag_pll1_ref_clk_div_sel_m1_5_0.value[5:0];
    cmn_pdiag_pll1_ref_clk_div_sel_m1_31_6: coverpoint cmn_pdiag_pll1_ref_clk_div_sel_m1_31_6.value[25:0];
  endgroup
  covergroup rd_fld_covg;
    cmn_pdiag_pll1_ref_clk_div_sel_m1_5_0: coverpoint cmn_pdiag_pll1_ref_clk_div_sel_m1_5_0.value[5:0];
    cmn_pdiag_pll1_ref_clk_div_sel_m1_31_6: coverpoint cmn_pdiag_pll1_ref_clk_div_sel_m1_31_6.value[25:0];
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
    
    cmn_pdiag_pll1_ref_clk_div_sel_m1_5_0 = fld_set[0];
    cmn_pdiag_pll1_ref_clk_div_sel_m1_31_6 = fld_set[1];
  endfunction

  function new(input string name="T_cmn_pdiag_pll1_ref_clk_div_sel_m1_1161");
    super.new(name, 32, build_coverage(UVM_CVR_FIELD_VALS));
    if (has_coverage(UVM_CVR_FIELD_VALS)) begin
      wr_fld_covg = new();
      rd_fld_covg = new();
    end
  endfunction

endclass


/////////////////////////////////////////////////////
//                cmn_pdiag_pll1_vco_ctrl_m0
/////////////////////////////////////////////////////
class T_cmn_pdiag_pll1_vco_ctrl_m0_1148 extends cdns_uvm_reg;

  `uvm_object_utils(T_cmn_pdiag_pll1_vco_ctrl_m0_1148)
  rand uvm_reg_field cmn_pdiag_pll1_vco_ctrl_m0_3_0;
  rand uvm_reg_field cmn_pdiag_pll1_vco_ctrl_m0_6_4;
  rand uvm_reg_field cmn_pdiag_pll1_vco_ctrl_m0_7;
  rand uvm_reg_field cmn_pdiag_pll1_vco_ctrl_m0_11_8;
  rand uvm_reg_field cmn_pdiag_pll1_vco_ctrl_m0_16_12;
  rand uvm_reg_field cmn_pdiag_pll1_vco_ctrl_m0_18_17;
  rand uvm_reg_field cmn_pdiag_pll1_vco_ctrl_m0_19;
  rand uvm_reg_field cmn_pdiag_pll1_vco_ctrl_m0_31_20;
  
  covergroup wr_fld_covg;
    cmn_pdiag_pll1_vco_ctrl_m0_3_0: coverpoint cmn_pdiag_pll1_vco_ctrl_m0_3_0.value[3:0];
    cmn_pdiag_pll1_vco_ctrl_m0_6_4: coverpoint cmn_pdiag_pll1_vco_ctrl_m0_6_4.value[2:0];
    cmn_pdiag_pll1_vco_ctrl_m0_7: coverpoint cmn_pdiag_pll1_vco_ctrl_m0_7.value[0:0];
    cmn_pdiag_pll1_vco_ctrl_m0_11_8: coverpoint cmn_pdiag_pll1_vco_ctrl_m0_11_8.value[3:0];
    cmn_pdiag_pll1_vco_ctrl_m0_16_12: coverpoint cmn_pdiag_pll1_vco_ctrl_m0_16_12.value[4:0];
    cmn_pdiag_pll1_vco_ctrl_m0_18_17: coverpoint cmn_pdiag_pll1_vco_ctrl_m0_18_17.value[1:0];
    cmn_pdiag_pll1_vco_ctrl_m0_19: coverpoint cmn_pdiag_pll1_vco_ctrl_m0_19.value[0:0];
    cmn_pdiag_pll1_vco_ctrl_m0_31_20: coverpoint cmn_pdiag_pll1_vco_ctrl_m0_31_20.value[11:0];
  endgroup
  covergroup rd_fld_covg;
    cmn_pdiag_pll1_vco_ctrl_m0_3_0: coverpoint cmn_pdiag_pll1_vco_ctrl_m0_3_0.value[3:0];
    cmn_pdiag_pll1_vco_ctrl_m0_6_4: coverpoint cmn_pdiag_pll1_vco_ctrl_m0_6_4.value[2:0];
    cmn_pdiag_pll1_vco_ctrl_m0_7: coverpoint cmn_pdiag_pll1_vco_ctrl_m0_7.value[0:0];
    cmn_pdiag_pll1_vco_ctrl_m0_11_8: coverpoint cmn_pdiag_pll1_vco_ctrl_m0_11_8.value[3:0];
    cmn_pdiag_pll1_vco_ctrl_m0_16_12: coverpoint cmn_pdiag_pll1_vco_ctrl_m0_16_12.value[4:0];
    cmn_pdiag_pll1_vco_ctrl_m0_18_17: coverpoint cmn_pdiag_pll1_vco_ctrl_m0_18_17.value[1:0];
    cmn_pdiag_pll1_vco_ctrl_m0_19: coverpoint cmn_pdiag_pll1_vco_ctrl_m0_19.value[0:0];
    cmn_pdiag_pll1_vco_ctrl_m0_31_20: coverpoint cmn_pdiag_pll1_vco_ctrl_m0_31_20.value[11:0];
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
    
    cmn_pdiag_pll1_vco_ctrl_m0_3_0 = fld_set[0];
    cmn_pdiag_pll1_vco_ctrl_m0_6_4 = fld_set[1];
    cmn_pdiag_pll1_vco_ctrl_m0_7 = fld_set[2];
    cmn_pdiag_pll1_vco_ctrl_m0_11_8 = fld_set[3];
    cmn_pdiag_pll1_vco_ctrl_m0_16_12 = fld_set[4];
    cmn_pdiag_pll1_vco_ctrl_m0_18_17 = fld_set[5];
    cmn_pdiag_pll1_vco_ctrl_m0_19 = fld_set[6];
    cmn_pdiag_pll1_vco_ctrl_m0_31_20 = fld_set[7];
  endfunction

  function new(input string name="T_cmn_pdiag_pll1_vco_ctrl_m0_1148");
    super.new(name, 32, build_coverage(UVM_CVR_FIELD_VALS));
    if (has_coverage(UVM_CVR_FIELD_VALS)) begin
      wr_fld_covg = new();
      rd_fld_covg = new();
    end
  endfunction

endclass


/////////////////////////////////////////////////////
//                cmn_pdiag_pll1_vco_ctrl_m1
/////////////////////////////////////////////////////
class T_cmn_pdiag_pll1_vco_ctrl_m1_1158 extends cdns_uvm_reg;

  `uvm_object_utils(T_cmn_pdiag_pll1_vco_ctrl_m1_1158)
  rand uvm_reg_field cmn_pdiag_pll1_vco_ctrl_m1_3_0;
  rand uvm_reg_field cmn_pdiag_pll1_vco_ctrl_m1_6_4;
  rand uvm_reg_field cmn_pdiag_pll1_vco_ctrl_m1_7;
  rand uvm_reg_field cmn_pdiag_pll1_vco_ctrl_m1_11_8;
  rand uvm_reg_field cmn_pdiag_pll1_vco_ctrl_m1_16_12;
  rand uvm_reg_field cmn_pdiag_pll1_vco_ctrl_m1_18_17;
  rand uvm_reg_field cmn_pdiag_pll1_vco_ctrl_m1_19;
  rand uvm_reg_field cmn_pdiag_pll1_vco_ctrl_m1_31_20;
  
  covergroup wr_fld_covg;
    cmn_pdiag_pll1_vco_ctrl_m1_3_0: coverpoint cmn_pdiag_pll1_vco_ctrl_m1_3_0.value[3:0];
    cmn_pdiag_pll1_vco_ctrl_m1_6_4: coverpoint cmn_pdiag_pll1_vco_ctrl_m1_6_4.value[2:0];
    cmn_pdiag_pll1_vco_ctrl_m1_7: coverpoint cmn_pdiag_pll1_vco_ctrl_m1_7.value[0:0];
    cmn_pdiag_pll1_vco_ctrl_m1_11_8: coverpoint cmn_pdiag_pll1_vco_ctrl_m1_11_8.value[3:0];
    cmn_pdiag_pll1_vco_ctrl_m1_16_12: coverpoint cmn_pdiag_pll1_vco_ctrl_m1_16_12.value[4:0];
    cmn_pdiag_pll1_vco_ctrl_m1_18_17: coverpoint cmn_pdiag_pll1_vco_ctrl_m1_18_17.value[1:0];
    cmn_pdiag_pll1_vco_ctrl_m1_19: coverpoint cmn_pdiag_pll1_vco_ctrl_m1_19.value[0:0];
    cmn_pdiag_pll1_vco_ctrl_m1_31_20: coverpoint cmn_pdiag_pll1_vco_ctrl_m1_31_20.value[11:0];
  endgroup
  covergroup rd_fld_covg;
    cmn_pdiag_pll1_vco_ctrl_m1_3_0: coverpoint cmn_pdiag_pll1_vco_ctrl_m1_3_0.value[3:0];
    cmn_pdiag_pll1_vco_ctrl_m1_6_4: coverpoint cmn_pdiag_pll1_vco_ctrl_m1_6_4.value[2:0];
    cmn_pdiag_pll1_vco_ctrl_m1_7: coverpoint cmn_pdiag_pll1_vco_ctrl_m1_7.value[0:0];
    cmn_pdiag_pll1_vco_ctrl_m1_11_8: coverpoint cmn_pdiag_pll1_vco_ctrl_m1_11_8.value[3:0];
    cmn_pdiag_pll1_vco_ctrl_m1_16_12: coverpoint cmn_pdiag_pll1_vco_ctrl_m1_16_12.value[4:0];
    cmn_pdiag_pll1_vco_ctrl_m1_18_17: coverpoint cmn_pdiag_pll1_vco_ctrl_m1_18_17.value[1:0];
    cmn_pdiag_pll1_vco_ctrl_m1_19: coverpoint cmn_pdiag_pll1_vco_ctrl_m1_19.value[0:0];
    cmn_pdiag_pll1_vco_ctrl_m1_31_20: coverpoint cmn_pdiag_pll1_vco_ctrl_m1_31_20.value[11:0];
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
    
    cmn_pdiag_pll1_vco_ctrl_m1_3_0 = fld_set[0];
    cmn_pdiag_pll1_vco_ctrl_m1_6_4 = fld_set[1];
    cmn_pdiag_pll1_vco_ctrl_m1_7 = fld_set[2];
    cmn_pdiag_pll1_vco_ctrl_m1_11_8 = fld_set[3];
    cmn_pdiag_pll1_vco_ctrl_m1_16_12 = fld_set[4];
    cmn_pdiag_pll1_vco_ctrl_m1_18_17 = fld_set[5];
    cmn_pdiag_pll1_vco_ctrl_m1_19 = fld_set[6];
    cmn_pdiag_pll1_vco_ctrl_m1_31_20 = fld_set[7];
  endfunction

  function new(input string name="T_cmn_pdiag_pll1_vco_ctrl_m1_1158");
    super.new(name, 32, build_coverage(UVM_CVR_FIELD_VALS));
    if (has_coverage(UVM_CVR_FIELD_VALS)) begin
      wr_fld_covg = new();
      rd_fld_covg = new();
    end
  endfunction

endclass


/////////////////////////////////////////////////////
//                cmn_pdiag_pll1_vreg_adj_m0
/////////////////////////////////////////////////////
class T_cmn_pdiag_pll1_vreg_adj_m0_1144 extends cdns_uvm_reg;

  `uvm_object_utils(T_cmn_pdiag_pll1_vreg_adj_m0_1144)
  rand uvm_reg_field cmn_pdiag_pll1_vreg_adj_m0_0;
  rand uvm_reg_field cmn_pdiag_pll1_vreg_adj_m0_1;
  rand uvm_reg_field cmn_pdiag_pll1_vreg_adj_m0_3_2;
  rand uvm_reg_field cmn_pdiag_pll1_vreg_adj_m0_5_4;
  rand uvm_reg_field cmn_pdiag_pll1_vreg_adj_m0_7_6;
  rand uvm_reg_field cmn_pdiag_pll1_vreg_adj_m0_12_8;
  rand uvm_reg_field cmn_pdiag_pll1_vreg_adj_m0_31_13;
  
  covergroup wr_fld_covg;
    cmn_pdiag_pll1_vreg_adj_m0_0: coverpoint cmn_pdiag_pll1_vreg_adj_m0_0.value[0:0];
    cmn_pdiag_pll1_vreg_adj_m0_1: coverpoint cmn_pdiag_pll1_vreg_adj_m0_1.value[0:0];
    cmn_pdiag_pll1_vreg_adj_m0_3_2: coverpoint cmn_pdiag_pll1_vreg_adj_m0_3_2.value[1:0];
    cmn_pdiag_pll1_vreg_adj_m0_5_4: coverpoint cmn_pdiag_pll1_vreg_adj_m0_5_4.value[1:0];
    cmn_pdiag_pll1_vreg_adj_m0_7_6: coverpoint cmn_pdiag_pll1_vreg_adj_m0_7_6.value[1:0];
    cmn_pdiag_pll1_vreg_adj_m0_12_8: coverpoint cmn_pdiag_pll1_vreg_adj_m0_12_8.value[4:0];
    cmn_pdiag_pll1_vreg_adj_m0_31_13: coverpoint cmn_pdiag_pll1_vreg_adj_m0_31_13.value[18:0];
  endgroup
  covergroup rd_fld_covg;
    cmn_pdiag_pll1_vreg_adj_m0_0: coverpoint cmn_pdiag_pll1_vreg_adj_m0_0.value[0:0];
    cmn_pdiag_pll1_vreg_adj_m0_1: coverpoint cmn_pdiag_pll1_vreg_adj_m0_1.value[0:0];
    cmn_pdiag_pll1_vreg_adj_m0_3_2: coverpoint cmn_pdiag_pll1_vreg_adj_m0_3_2.value[1:0];
    cmn_pdiag_pll1_vreg_adj_m0_5_4: coverpoint cmn_pdiag_pll1_vreg_adj_m0_5_4.value[1:0];
    cmn_pdiag_pll1_vreg_adj_m0_7_6: coverpoint cmn_pdiag_pll1_vreg_adj_m0_7_6.value[1:0];
    cmn_pdiag_pll1_vreg_adj_m0_12_8: coverpoint cmn_pdiag_pll1_vreg_adj_m0_12_8.value[4:0];
    cmn_pdiag_pll1_vreg_adj_m0_31_13: coverpoint cmn_pdiag_pll1_vreg_adj_m0_31_13.value[18:0];
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
    
    cmn_pdiag_pll1_vreg_adj_m0_0 = fld_set[0];
    cmn_pdiag_pll1_vreg_adj_m0_1 = fld_set[1];
    cmn_pdiag_pll1_vreg_adj_m0_3_2 = fld_set[2];
    cmn_pdiag_pll1_vreg_adj_m0_5_4 = fld_set[3];
    cmn_pdiag_pll1_vreg_adj_m0_7_6 = fld_set[4];
    cmn_pdiag_pll1_vreg_adj_m0_12_8 = fld_set[5];
    cmn_pdiag_pll1_vreg_adj_m0_31_13 = fld_set[6];
  endfunction

  function new(input string name="T_cmn_pdiag_pll1_vreg_adj_m0_1144");
    super.new(name, 32, build_coverage(UVM_CVR_FIELD_VALS));
    if (has_coverage(UVM_CVR_FIELD_VALS)) begin
      wr_fld_covg = new();
      rd_fld_covg = new();
    end
  endfunction

endclass


/////////////////////////////////////////////////////
//                cmn_pdiag_pll1_vreg_adj_m1
/////////////////////////////////////////////////////
class T_cmn_pdiag_pll1_vreg_adj_m1_1154 extends cdns_uvm_reg;

  `uvm_object_utils(T_cmn_pdiag_pll1_vreg_adj_m1_1154)
  rand uvm_reg_field cmn_pdiag_pll1_vreg_adj_m1_0;
  rand uvm_reg_field cmn_pdiag_pll1_vreg_adj_m1_1;
  rand uvm_reg_field cmn_pdiag_pll1_vreg_adj_m1_3_2;
  rand uvm_reg_field cmn_pdiag_pll1_vreg_adj_m1_5_4;
  rand uvm_reg_field cmn_pdiag_pll1_vreg_adj_m1_7_6;
  rand uvm_reg_field cmn_pdiag_pll1_vreg_adj_m1_12_8;
  rand uvm_reg_field cmn_pdiag_pll1_vreg_adj_m1_31_13;
  
  covergroup wr_fld_covg;
    cmn_pdiag_pll1_vreg_adj_m1_0: coverpoint cmn_pdiag_pll1_vreg_adj_m1_0.value[0:0];
    cmn_pdiag_pll1_vreg_adj_m1_1: coverpoint cmn_pdiag_pll1_vreg_adj_m1_1.value[0:0];
    cmn_pdiag_pll1_vreg_adj_m1_3_2: coverpoint cmn_pdiag_pll1_vreg_adj_m1_3_2.value[1:0];
    cmn_pdiag_pll1_vreg_adj_m1_5_4: coverpoint cmn_pdiag_pll1_vreg_adj_m1_5_4.value[1:0];
    cmn_pdiag_pll1_vreg_adj_m1_7_6: coverpoint cmn_pdiag_pll1_vreg_adj_m1_7_6.value[1:0];
    cmn_pdiag_pll1_vreg_adj_m1_12_8: coverpoint cmn_pdiag_pll1_vreg_adj_m1_12_8.value[4:0];
    cmn_pdiag_pll1_vreg_adj_m1_31_13: coverpoint cmn_pdiag_pll1_vreg_adj_m1_31_13.value[18:0];
  endgroup
  covergroup rd_fld_covg;
    cmn_pdiag_pll1_vreg_adj_m1_0: coverpoint cmn_pdiag_pll1_vreg_adj_m1_0.value[0:0];
    cmn_pdiag_pll1_vreg_adj_m1_1: coverpoint cmn_pdiag_pll1_vreg_adj_m1_1.value[0:0];
    cmn_pdiag_pll1_vreg_adj_m1_3_2: coverpoint cmn_pdiag_pll1_vreg_adj_m1_3_2.value[1:0];
    cmn_pdiag_pll1_vreg_adj_m1_5_4: coverpoint cmn_pdiag_pll1_vreg_adj_m1_5_4.value[1:0];
    cmn_pdiag_pll1_vreg_adj_m1_7_6: coverpoint cmn_pdiag_pll1_vreg_adj_m1_7_6.value[1:0];
    cmn_pdiag_pll1_vreg_adj_m1_12_8: coverpoint cmn_pdiag_pll1_vreg_adj_m1_12_8.value[4:0];
    cmn_pdiag_pll1_vreg_adj_m1_31_13: coverpoint cmn_pdiag_pll1_vreg_adj_m1_31_13.value[18:0];
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
    
    cmn_pdiag_pll1_vreg_adj_m1_0 = fld_set[0];
    cmn_pdiag_pll1_vreg_adj_m1_1 = fld_set[1];
    cmn_pdiag_pll1_vreg_adj_m1_3_2 = fld_set[2];
    cmn_pdiag_pll1_vreg_adj_m1_5_4 = fld_set[3];
    cmn_pdiag_pll1_vreg_adj_m1_7_6 = fld_set[4];
    cmn_pdiag_pll1_vreg_adj_m1_12_8 = fld_set[5];
    cmn_pdiag_pll1_vreg_adj_m1_31_13 = fld_set[6];
  endfunction

  function new(input string name="T_cmn_pdiag_pll1_vreg_adj_m1_1154");
    super.new(name, 32, build_coverage(UVM_CVR_FIELD_VALS));
    if (has_coverage(UVM_CVR_FIELD_VALS)) begin
      wr_fld_covg = new();
      rd_fld_covg = new();
    end
  endfunction

endclass


/////////////////////////////////////////////////////
//                cmn_pid_flv0
/////////////////////////////////////////////////////
class T_cmn_pid_flv0_991 extends cdns_uvm_reg;

  `uvm_object_utils(T_cmn_pid_flv0_991)
  rand uvm_reg_field cmn_pid_flv0_15_0;
  rand uvm_reg_field cmn_pid_flv0_31_16;
  
  covergroup wr_fld_covg;
    cmn_pid_flv0_15_0: coverpoint cmn_pid_flv0_15_0.value[15:0];
    cmn_pid_flv0_31_16: coverpoint cmn_pid_flv0_31_16.value[15:0];
  endgroup
  covergroup rd_fld_covg;
    cmn_pid_flv0_15_0: coverpoint cmn_pid_flv0_15_0.value[15:0];
    cmn_pid_flv0_31_16: coverpoint cmn_pid_flv0_31_16.value[15:0];
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
    
    cmn_pid_flv0_15_0 = fld_set[0];
    cmn_pid_flv0_31_16 = fld_set[1];
  endfunction

  function new(input string name="T_cmn_pid_flv0_991");
    super.new(name, 32, build_coverage(UVM_CVR_FIELD_VALS));
    if (has_coverage(UVM_CVR_FIELD_VALS)) begin
      wr_fld_covg = new();
      rd_fld_covg = new();
    end
  endfunction

endclass


/////////////////////////////////////////////////////
//                cmn_pid_flv1
/////////////////////////////////////////////////////
class T_cmn_pid_flv1_992 extends cdns_uvm_reg;

  `uvm_object_utils(T_cmn_pid_flv1_992)
  rand uvm_reg_field cmn_pid_flv1_15_0;
  rand uvm_reg_field cmn_pid_flv1_31_16;
  
  covergroup wr_fld_covg;
    cmn_pid_flv1_15_0: coverpoint cmn_pid_flv1_15_0.value[15:0];
    cmn_pid_flv1_31_16: coverpoint cmn_pid_flv1_31_16.value[15:0];
  endgroup
  covergroup rd_fld_covg;
    cmn_pid_flv1_15_0: coverpoint cmn_pid_flv1_15_0.value[15:0];
    cmn_pid_flv1_31_16: coverpoint cmn_pid_flv1_31_16.value[15:0];
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
    
    cmn_pid_flv1_15_0 = fld_set[0];
    cmn_pid_flv1_31_16 = fld_set[1];
  endfunction

  function new(input string name="T_cmn_pid_flv1_992");
    super.new(name, 32, build_coverage(UVM_CVR_FIELD_VALS));
    if (has_coverage(UVM_CVR_FIELD_VALS)) begin
      wr_fld_covg = new();
      rd_fld_covg = new();
    end
  endfunction

endclass


/////////////////////////////////////////////////////
//                cmn_pid_iov
/////////////////////////////////////////////////////
class T_cmn_pid_iov_993 extends cdns_uvm_reg;

  `uvm_object_utils(T_cmn_pid_iov_993)
  rand uvm_reg_field cmn_pid_iov_15_0;
  rand uvm_reg_field cmn_pid_iov_31_16;
  
  covergroup wr_fld_covg;
    cmn_pid_iov_15_0: coverpoint cmn_pid_iov_15_0.value[15:0];
    cmn_pid_iov_31_16: coverpoint cmn_pid_iov_31_16.value[15:0];
  endgroup
  covergroup rd_fld_covg;
    cmn_pid_iov_15_0: coverpoint cmn_pid_iov_15_0.value[15:0];
    cmn_pid_iov_31_16: coverpoint cmn_pid_iov_31_16.value[15:0];
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
    
    cmn_pid_iov_15_0 = fld_set[0];
    cmn_pid_iov_31_16 = fld_set[1];
  endfunction

  function new(input string name="T_cmn_pid_iov_993");
    super.new(name, 32, build_coverage(UVM_CVR_FIELD_VALS));
    if (has_coverage(UVM_CVR_FIELD_VALS)) begin
      wr_fld_covg = new();
      rd_fld_covg = new();
    end
  endfunction

endclass


/////////////////////////////////////////////////////
//                cmn_pid_lanes
/////////////////////////////////////////////////////
class T_cmn_pid_lanes_994 extends cdns_uvm_reg;

  `uvm_object_utils(T_cmn_pid_lanes_994)
  rand uvm_reg_field cmn_pid_lanes_7_0;
  rand uvm_reg_field cmn_pid_lanes_15_8;
  rand uvm_reg_field cmn_pid_lanes_31_16;
  
  covergroup wr_fld_covg;
    cmn_pid_lanes_7_0: coverpoint cmn_pid_lanes_7_0.value[7:0];
    cmn_pid_lanes_15_8: coverpoint cmn_pid_lanes_15_8.value[7:0];
    cmn_pid_lanes_31_16: coverpoint cmn_pid_lanes_31_16.value[15:0];
  endgroup
  covergroup rd_fld_covg;
    cmn_pid_lanes_7_0: coverpoint cmn_pid_lanes_7_0.value[7:0];
    cmn_pid_lanes_15_8: coverpoint cmn_pid_lanes_15_8.value[7:0];
    cmn_pid_lanes_31_16: coverpoint cmn_pid_lanes_31_16.value[15:0];
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
    
    cmn_pid_lanes_7_0 = fld_set[0];
    cmn_pid_lanes_15_8 = fld_set[1];
    cmn_pid_lanes_31_16 = fld_set[2];
  endfunction

  function new(input string name="T_cmn_pid_lanes_994");
    super.new(name, 32, build_coverage(UVM_CVR_FIELD_VALS));
    if (has_coverage(UVM_CVR_FIELD_VALS)) begin
      wr_fld_covg = new();
      rd_fld_covg = new();
    end
  endfunction

endclass


/////////////////////////////////////////////////////
//                cmn_pid_metal0
/////////////////////////////////////////////////////
class T_cmn_pid_metal0_995 extends cdns_uvm_reg;

  `uvm_object_utils(T_cmn_pid_metal0_995)
  rand uvm_reg_field cmn_pid_metal0_15_0;
  rand uvm_reg_field cmn_pid_metal0_31_16;
  
  covergroup wr_fld_covg;
    cmn_pid_metal0_15_0: coverpoint cmn_pid_metal0_15_0.value[15:0];
    cmn_pid_metal0_31_16: coverpoint cmn_pid_metal0_31_16.value[15:0];
  endgroup
  covergroup rd_fld_covg;
    cmn_pid_metal0_15_0: coverpoint cmn_pid_metal0_15_0.value[15:0];
    cmn_pid_metal0_31_16: coverpoint cmn_pid_metal0_31_16.value[15:0];
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
    
    cmn_pid_metal0_15_0 = fld_set[0];
    cmn_pid_metal0_31_16 = fld_set[1];
  endfunction

  function new(input string name="T_cmn_pid_metal0_995");
    super.new(name, 32, build_coverage(UVM_CVR_FIELD_VALS));
    if (has_coverage(UVM_CVR_FIELD_VALS)) begin
      wr_fld_covg = new();
      rd_fld_covg = new();
    end
  endfunction

endclass


/////////////////////////////////////////////////////
//                cmn_pid_metal1
/////////////////////////////////////////////////////
class T_cmn_pid_metal1_996 extends cdns_uvm_reg;

  `uvm_object_utils(T_cmn_pid_metal1_996)
  rand uvm_reg_field cmn_pid_metal1_15_0;
  rand uvm_reg_field cmn_pid_metal1_31_16;
  
  covergroup wr_fld_covg;
    cmn_pid_metal1_15_0: coverpoint cmn_pid_metal1_15_0.value[15:0];
    cmn_pid_metal1_31_16: coverpoint cmn_pid_metal1_31_16.value[15:0];
  endgroup
  covergroup rd_fld_covg;
    cmn_pid_metal1_15_0: coverpoint cmn_pid_metal1_15_0.value[15:0];
    cmn_pid_metal1_31_16: coverpoint cmn_pid_metal1_31_16.value[15:0];
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
    
    cmn_pid_metal1_15_0 = fld_set[0];
    cmn_pid_metal1_31_16 = fld_set[1];
  endfunction

  function new(input string name="T_cmn_pid_metal1_996");
    super.new(name, 32, build_coverage(UVM_CVR_FIELD_VALS));
    if (has_coverage(UVM_CVR_FIELD_VALS)) begin
      wr_fld_covg = new();
      rd_fld_covg = new();
    end
  endfunction

endclass


/////////////////////////////////////////////////////
//                cmn_pid_metal2
/////////////////////////////////////////////////////
class T_cmn_pid_metal2_997 extends cdns_uvm_reg;

  `uvm_object_utils(T_cmn_pid_metal2_997)
  rand uvm_reg_field cmn_pid_metal2_15_0;
  rand uvm_reg_field cmn_pid_metal2_31_16;
  
  covergroup wr_fld_covg;
    cmn_pid_metal2_15_0: coverpoint cmn_pid_metal2_15_0.value[15:0];
    cmn_pid_metal2_31_16: coverpoint cmn_pid_metal2_31_16.value[15:0];
  endgroup
  covergroup rd_fld_covg;
    cmn_pid_metal2_15_0: coverpoint cmn_pid_metal2_15_0.value[15:0];
    cmn_pid_metal2_31_16: coverpoint cmn_pid_metal2_31_16.value[15:0];
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
    
    cmn_pid_metal2_15_0 = fld_set[0];
    cmn_pid_metal2_31_16 = fld_set[1];
  endfunction

  function new(input string name="T_cmn_pid_metal2_997");
    super.new(name, 32, build_coverage(UVM_CVR_FIELD_VALS));
    if (has_coverage(UVM_CVR_FIELD_VALS)) begin
      wr_fld_covg = new();
      rd_fld_covg = new();
    end
  endfunction

endclass


/////////////////////////////////////////////////////
//                cmn_pid_metal3
/////////////////////////////////////////////////////
class T_cmn_pid_metal3_998 extends cdns_uvm_reg;

  `uvm_object_utils(T_cmn_pid_metal3_998)
  rand uvm_reg_field cmn_pid_metal3_15_0;
  rand uvm_reg_field cmn_pid_metal3_31_16;
  
  covergroup wr_fld_covg;
    cmn_pid_metal3_15_0: coverpoint cmn_pid_metal3_15_0.value[15:0];
    cmn_pid_metal3_31_16: coverpoint cmn_pid_metal3_31_16.value[15:0];
  endgroup
  covergroup rd_fld_covg;
    cmn_pid_metal3_15_0: coverpoint cmn_pid_metal3_15_0.value[15:0];
    cmn_pid_metal3_31_16: coverpoint cmn_pid_metal3_31_16.value[15:0];
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
    
    cmn_pid_metal3_15_0 = fld_set[0];
    cmn_pid_metal3_31_16 = fld_set[1];
  endfunction

  function new(input string name="T_cmn_pid_metal3_998");
    super.new(name, 32, build_coverage(UVM_CVR_FIELD_VALS));
    if (has_coverage(UVM_CVR_FIELD_VALS)) begin
      wr_fld_covg = new();
      rd_fld_covg = new();
    end
  endfunction

endclass


/////////////////////////////////////////////////////
//                cmn_pid_metald
/////////////////////////////////////////////////////
class T_cmn_pid_metald_999 extends cdns_uvm_reg;

  `uvm_object_utils(T_cmn_pid_metald_999)
  rand uvm_reg_field cmn_pid_metald_0;
  rand uvm_reg_field cmn_pid_metald_1;
  rand uvm_reg_field cmn_pid_metald_2;
  rand uvm_reg_field cmn_pid_metald_3;
  rand uvm_reg_field cmn_pid_metald_4;
  rand uvm_reg_field cmn_pid_metald_5;
  rand uvm_reg_field cmn_pid_metald_6;
  rand uvm_reg_field cmn_pid_metald_7;
  rand uvm_reg_field cmn_pid_metald_8;
  rand uvm_reg_field cmn_pid_metald_9;
  rand uvm_reg_field cmn_pid_metald_10;
  rand uvm_reg_field cmn_pid_metald_11;
  rand uvm_reg_field cmn_pid_metald_12;
  rand uvm_reg_field cmn_pid_metald_13;
  rand uvm_reg_field cmn_pid_metald_14;
  rand uvm_reg_field cmn_pid_metald_15;
  rand uvm_reg_field cmn_pid_metald_31_16;
  
  covergroup wr_fld_covg;
    cmn_pid_metald_0: coverpoint cmn_pid_metald_0.value[0:0];
    cmn_pid_metald_1: coverpoint cmn_pid_metald_1.value[0:0];
    cmn_pid_metald_2: coverpoint cmn_pid_metald_2.value[0:0];
    cmn_pid_metald_3: coverpoint cmn_pid_metald_3.value[0:0];
    cmn_pid_metald_4: coverpoint cmn_pid_metald_4.value[0:0];
    cmn_pid_metald_5: coverpoint cmn_pid_metald_5.value[0:0];
    cmn_pid_metald_6: coverpoint cmn_pid_metald_6.value[0:0];
    cmn_pid_metald_7: coverpoint cmn_pid_metald_7.value[0:0];
    cmn_pid_metald_8: coverpoint cmn_pid_metald_8.value[0:0];
    cmn_pid_metald_9: coverpoint cmn_pid_metald_9.value[0:0];
    cmn_pid_metald_10: coverpoint cmn_pid_metald_10.value[0:0];
    cmn_pid_metald_11: coverpoint cmn_pid_metald_11.value[0:0];
    cmn_pid_metald_12: coverpoint cmn_pid_metald_12.value[0:0];
    cmn_pid_metald_13: coverpoint cmn_pid_metald_13.value[0:0];
    cmn_pid_metald_14: coverpoint cmn_pid_metald_14.value[0:0];
    cmn_pid_metald_15: coverpoint cmn_pid_metald_15.value[0:0];
    cmn_pid_metald_31_16: coverpoint cmn_pid_metald_31_16.value[15:0];
  endgroup
  covergroup rd_fld_covg;
    cmn_pid_metald_0: coverpoint cmn_pid_metald_0.value[0:0];
    cmn_pid_metald_1: coverpoint cmn_pid_metald_1.value[0:0];
    cmn_pid_metald_2: coverpoint cmn_pid_metald_2.value[0:0];
    cmn_pid_metald_3: coverpoint cmn_pid_metald_3.value[0:0];
    cmn_pid_metald_4: coverpoint cmn_pid_metald_4.value[0:0];
    cmn_pid_metald_5: coverpoint cmn_pid_metald_5.value[0:0];
    cmn_pid_metald_6: coverpoint cmn_pid_metald_6.value[0:0];
    cmn_pid_metald_7: coverpoint cmn_pid_metald_7.value[0:0];
    cmn_pid_metald_8: coverpoint cmn_pid_metald_8.value[0:0];
    cmn_pid_metald_9: coverpoint cmn_pid_metald_9.value[0:0];
    cmn_pid_metald_10: coverpoint cmn_pid_metald_10.value[0:0];
    cmn_pid_metald_11: coverpoint cmn_pid_metald_11.value[0:0];
    cmn_pid_metald_12: coverpoint cmn_pid_metald_12.value[0:0];
    cmn_pid_metald_13: coverpoint cmn_pid_metald_13.value[0:0];
    cmn_pid_metald_14: coverpoint cmn_pid_metald_14.value[0:0];
    cmn_pid_metald_15: coverpoint cmn_pid_metald_15.value[0:0];
    cmn_pid_metald_31_16: coverpoint cmn_pid_metald_31_16.value[15:0];
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
    
    cmn_pid_metald_0 = fld_set[0];
    cmn_pid_metald_1 = fld_set[1];
    cmn_pid_metald_2 = fld_set[2];
    cmn_pid_metald_3 = fld_set[3];
    cmn_pid_metald_4 = fld_set[4];
    cmn_pid_metald_5 = fld_set[5];
    cmn_pid_metald_6 = fld_set[6];
    cmn_pid_metald_7 = fld_set[7];
    cmn_pid_metald_8 = fld_set[8];
    cmn_pid_metald_9 = fld_set[9];
    cmn_pid_metald_10 = fld_set[10];
    cmn_pid_metald_11 = fld_set[11];
    cmn_pid_metald_12 = fld_set[12];
    cmn_pid_metald_13 = fld_set[13];
    cmn_pid_metald_14 = fld_set[14];
    cmn_pid_metald_15 = fld_set[15];
    cmn_pid_metald_31_16 = fld_set[16];
  endfunction

  function new(input string name="T_cmn_pid_metald_999");
    super.new(name, 32, build_coverage(UVM_CVR_FIELD_VALS));
    if (has_coverage(UVM_CVR_FIELD_VALS)) begin
      wr_fld_covg = new();
      rd_fld_covg = new();
    end
  endfunction

endclass


/////////////////////////////////////////////////////
//                cmn_pid_mfg
/////////////////////////////////////////////////////
class T_cmn_pid_mfg_989 extends cdns_uvm_reg;

  `uvm_object_utils(T_cmn_pid_mfg_989)
  rand uvm_reg_field cmn_pid_mfg_15_0;
  rand uvm_reg_field cmn_pid_mfg_31_16;
  
  covergroup wr_fld_covg;
    cmn_pid_mfg_15_0: coverpoint cmn_pid_mfg_15_0.value[15:0];
    cmn_pid_mfg_31_16: coverpoint cmn_pid_mfg_31_16.value[15:0];
  endgroup
  covergroup rd_fld_covg;
    cmn_pid_mfg_15_0: coverpoint cmn_pid_mfg_15_0.value[15:0];
    cmn_pid_mfg_31_16: coverpoint cmn_pid_mfg_31_16.value[15:0];
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
    
    cmn_pid_mfg_15_0 = fld_set[0];
    cmn_pid_mfg_31_16 = fld_set[1];
  endfunction

  function new(input string name="T_cmn_pid_mfg_989");
    super.new(name, 32, build_coverage(UVM_CVR_FIELD_VALS));
    if (has_coverage(UVM_CVR_FIELD_VALS)) begin
      wr_fld_covg = new();
      rd_fld_covg = new();
    end
  endfunction

endclass


/////////////////////////////////////////////////////
//                cmn_pid_node
/////////////////////////////////////////////////////
class T_cmn_pid_node_990 extends cdns_uvm_reg;

  `uvm_object_utils(T_cmn_pid_node_990)
  rand uvm_reg_field cmn_pid_node_15_0;
  rand uvm_reg_field cmn_pid_node_31_16;
  
  covergroup wr_fld_covg;
    cmn_pid_node_15_0: coverpoint cmn_pid_node_15_0.value[15:0];
    cmn_pid_node_31_16: coverpoint cmn_pid_node_31_16.value[15:0];
  endgroup
  covergroup rd_fld_covg;
    cmn_pid_node_15_0: coverpoint cmn_pid_node_15_0.value[15:0];
    cmn_pid_node_31_16: coverpoint cmn_pid_node_31_16.value[15:0];
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
    
    cmn_pid_node_15_0 = fld_set[0];
    cmn_pid_node_31_16 = fld_set[1];
  endfunction

  function new(input string name="T_cmn_pid_node_990");
    super.new(name, 32, build_coverage(UVM_CVR_FIELD_VALS));
    if (has_coverage(UVM_CVR_FIELD_VALS)) begin
      wr_fld_covg = new();
      rd_fld_covg = new();
    end
  endfunction

endclass


/////////////////////////////////////////////////////
//                cmn_pid_num
/////////////////////////////////////////////////////
class T_cmn_pid_num_987 extends cdns_uvm_reg;

  `uvm_object_utils(T_cmn_pid_num_987)
  rand uvm_reg_field cmn_pid_num_15_0;
  rand uvm_reg_field cmn_pid_num_31_16;
  
  covergroup wr_fld_covg;
    cmn_pid_num_15_0: coverpoint cmn_pid_num_15_0.value[15:0];
    cmn_pid_num_31_16: coverpoint cmn_pid_num_31_16.value[15:0];
  endgroup
  covergroup rd_fld_covg;
    cmn_pid_num_15_0: coverpoint cmn_pid_num_15_0.value[15:0];
    cmn_pid_num_31_16: coverpoint cmn_pid_num_31_16.value[15:0];
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
    
    cmn_pid_num_15_0 = fld_set[0];
    cmn_pid_num_31_16 = fld_set[1];
  endfunction

  function new(input string name="T_cmn_pid_num_987");
    super.new(name, 32, build_coverage(UVM_CVR_FIELD_VALS));
    if (has_coverage(UVM_CVR_FIELD_VALS)) begin
      wr_fld_covg = new();
      rd_fld_covg = new();
    end
  endfunction

endclass


/////////////////////////////////////////////////////
//                cmn_pid_rev
/////////////////////////////////////////////////////
class T_cmn_pid_rev_988 extends cdns_uvm_reg;

  `uvm_object_utils(T_cmn_pid_rev_988)
  rand uvm_reg_field cmn_pid_rev_15_0;
  rand uvm_reg_field cmn_pid_rev_31_16;
  
  covergroup wr_fld_covg;
    cmn_pid_rev_15_0: coverpoint cmn_pid_rev_15_0.value[15:0];
    cmn_pid_rev_31_16: coverpoint cmn_pid_rev_31_16.value[15:0];
  endgroup
  covergroup rd_fld_covg;
    cmn_pid_rev_15_0: coverpoint cmn_pid_rev_15_0.value[15:0];
    cmn_pid_rev_31_16: coverpoint cmn_pid_rev_31_16.value[15:0];
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
    
    cmn_pid_rev_15_0 = fld_set[0];
    cmn_pid_rev_31_16 = fld_set[1];
  endfunction

  function new(input string name="T_cmn_pid_rev_988");
    super.new(name, 32, build_coverage(UVM_CVR_FIELD_VALS));
    if (has_coverage(UVM_CVR_FIELD_VALS)) begin
      wr_fld_covg = new();
      rd_fld_covg = new();
    end
  endfunction

endclass


/////////////////////////////////////////////////////
//                cmn_pid_type
/////////////////////////////////////////////////////
class T_cmn_pid_type_986 extends cdns_uvm_reg;

  `uvm_object_utils(T_cmn_pid_type_986)
  rand uvm_reg_field cmn_pid_type_15_0;
  rand uvm_reg_field cmn_pid_type_31_16;
  
  covergroup wr_fld_covg;
    cmn_pid_type_15_0: coverpoint cmn_pid_type_15_0.value[15:0];
    cmn_pid_type_31_16: coverpoint cmn_pid_type_31_16.value[15:0];
  endgroup
  covergroup rd_fld_covg;
    cmn_pid_type_15_0: coverpoint cmn_pid_type_15_0.value[15:0];
    cmn_pid_type_31_16: coverpoint cmn_pid_type_31_16.value[15:0];
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
    
    cmn_pid_type_15_0 = fld_set[0];
    cmn_pid_type_31_16 = fld_set[1];
  endfunction

  function new(input string name="T_cmn_pid_type_986");
    super.new(name, 32, build_coverage(UVM_CVR_FIELD_VALS));
    if (has_coverage(UVM_CVR_FIELD_VALS)) begin
      wr_fld_covg = new();
      rd_fld_covg = new();
    end
  endfunction

endclass


/////////////////////////////////////////////////////
//                cmn_pll0_dsm_diag
/////////////////////////////////////////////////////
class T_cmn_pll0_dsm_diag_1057 extends cdns_uvm_reg;

  `uvm_object_utils(T_cmn_pll0_dsm_diag_1057)
  rand uvm_reg_field cmn_pll0_dsm_diag_3_0;
  rand uvm_reg_field cmn_pll0_dsm_diag_13_4;
  rand uvm_reg_field cmn_pll0_dsm_diag_14;
  rand uvm_reg_field cmn_pll0_dsm_diag_15;
  rand uvm_reg_field cmn_pll0_dsm_diag_31_16;
  
  covergroup wr_fld_covg;
    cmn_pll0_dsm_diag_3_0: coverpoint cmn_pll0_dsm_diag_3_0.value[3:0];
    cmn_pll0_dsm_diag_13_4: coverpoint cmn_pll0_dsm_diag_13_4.value[9:0];
    cmn_pll0_dsm_diag_14: coverpoint cmn_pll0_dsm_diag_14.value[0:0];
    cmn_pll0_dsm_diag_15: coverpoint cmn_pll0_dsm_diag_15.value[0:0];
    cmn_pll0_dsm_diag_31_16: coverpoint cmn_pll0_dsm_diag_31_16.value[15:0];
  endgroup
  covergroup rd_fld_covg;
    cmn_pll0_dsm_diag_3_0: coverpoint cmn_pll0_dsm_diag_3_0.value[3:0];
    cmn_pll0_dsm_diag_13_4: coverpoint cmn_pll0_dsm_diag_13_4.value[9:0];
    cmn_pll0_dsm_diag_14: coverpoint cmn_pll0_dsm_diag_14.value[0:0];
    cmn_pll0_dsm_diag_15: coverpoint cmn_pll0_dsm_diag_15.value[0:0];
    cmn_pll0_dsm_diag_31_16: coverpoint cmn_pll0_dsm_diag_31_16.value[15:0];
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
    
    cmn_pll0_dsm_diag_3_0 = fld_set[0];
    cmn_pll0_dsm_diag_13_4 = fld_set[1];
    cmn_pll0_dsm_diag_14 = fld_set[2];
    cmn_pll0_dsm_diag_15 = fld_set[3];
    cmn_pll0_dsm_diag_31_16 = fld_set[4];
  endfunction

  function new(input string name="T_cmn_pll0_dsm_diag_1057");
    super.new(name, 32, build_coverage(UVM_CVR_FIELD_VALS));
    if (has_coverage(UVM_CVR_FIELD_VALS)) begin
      wr_fld_covg = new();
      rd_fld_covg = new();
    end
  endfunction

endclass


/////////////////////////////////////////////////////
//                cmn_pll0_dsm_fbh_ovrd
/////////////////////////////////////////////////////
class T_cmn_pll0_dsm_fbh_ovrd_1058 extends cdns_uvm_reg;

  `uvm_object_utils(T_cmn_pll0_dsm_fbh_ovrd_1058)
  rand uvm_reg_field cmn_pll0_dsm_fbh_ovrd_9_0;
  rand uvm_reg_field cmn_pll0_dsm_fbh_ovrd_15_10;
  rand uvm_reg_field cmn_pll0_dsm_fbh_ovrd_31_16;
  
  covergroup wr_fld_covg;
    cmn_pll0_dsm_fbh_ovrd_9_0: coverpoint cmn_pll0_dsm_fbh_ovrd_9_0.value[9:0];
    cmn_pll0_dsm_fbh_ovrd_15_10: coverpoint cmn_pll0_dsm_fbh_ovrd_15_10.value[5:0];
    cmn_pll0_dsm_fbh_ovrd_31_16: coverpoint cmn_pll0_dsm_fbh_ovrd_31_16.value[15:0];
  endgroup
  covergroup rd_fld_covg;
    cmn_pll0_dsm_fbh_ovrd_9_0: coverpoint cmn_pll0_dsm_fbh_ovrd_9_0.value[9:0];
    cmn_pll0_dsm_fbh_ovrd_15_10: coverpoint cmn_pll0_dsm_fbh_ovrd_15_10.value[5:0];
    cmn_pll0_dsm_fbh_ovrd_31_16: coverpoint cmn_pll0_dsm_fbh_ovrd_31_16.value[15:0];
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
    
    cmn_pll0_dsm_fbh_ovrd_9_0 = fld_set[0];
    cmn_pll0_dsm_fbh_ovrd_15_10 = fld_set[1];
    cmn_pll0_dsm_fbh_ovrd_31_16 = fld_set[2];
  endfunction

  function new(input string name="T_cmn_pll0_dsm_fbh_ovrd_1058");
    super.new(name, 32, build_coverage(UVM_CVR_FIELD_VALS));
    if (has_coverage(UVM_CVR_FIELD_VALS)) begin
      wr_fld_covg = new();
      rd_fld_covg = new();
    end
  endfunction

endclass


/////////////////////////////////////////////////////
//                cmn_pll0_dsm_fbl_ovrd
/////////////////////////////////////////////////////
class T_cmn_pll0_dsm_fbl_ovrd_1059 extends cdns_uvm_reg;

  `uvm_object_utils(T_cmn_pll0_dsm_fbl_ovrd_1059)
  rand uvm_reg_field cmn_pll0_dsm_fbl_ovrd_9_0;
  rand uvm_reg_field cmn_pll0_dsm_fbl_ovrd_15_10;
  rand uvm_reg_field cmn_pll0_dsm_fbl_ovrd_31_16;
  
  covergroup wr_fld_covg;
    cmn_pll0_dsm_fbl_ovrd_9_0: coverpoint cmn_pll0_dsm_fbl_ovrd_9_0.value[9:0];
    cmn_pll0_dsm_fbl_ovrd_15_10: coverpoint cmn_pll0_dsm_fbl_ovrd_15_10.value[5:0];
    cmn_pll0_dsm_fbl_ovrd_31_16: coverpoint cmn_pll0_dsm_fbl_ovrd_31_16.value[15:0];
  endgroup
  covergroup rd_fld_covg;
    cmn_pll0_dsm_fbl_ovrd_9_0: coverpoint cmn_pll0_dsm_fbl_ovrd_9_0.value[9:0];
    cmn_pll0_dsm_fbl_ovrd_15_10: coverpoint cmn_pll0_dsm_fbl_ovrd_15_10.value[5:0];
    cmn_pll0_dsm_fbl_ovrd_31_16: coverpoint cmn_pll0_dsm_fbl_ovrd_31_16.value[15:0];
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
    
    cmn_pll0_dsm_fbl_ovrd_9_0 = fld_set[0];
    cmn_pll0_dsm_fbl_ovrd_15_10 = fld_set[1];
    cmn_pll0_dsm_fbl_ovrd_31_16 = fld_set[2];
  endfunction

  function new(input string name="T_cmn_pll0_dsm_fbl_ovrd_1059");
    super.new(name, 32, build_coverage(UVM_CVR_FIELD_VALS));
    if (has_coverage(UVM_CVR_FIELD_VALS)) begin
      wr_fld_covg = new();
      rd_fld_covg = new();
    end
  endfunction

endclass


/////////////////////////////////////////////////////
//                cmn_pll0_fracdivh
/////////////////////////////////////////////////////
class T_cmn_pll0_fracdivh_1055 extends cdns_uvm_reg;

  `uvm_object_utils(T_cmn_pll0_fracdivh_1055)
  rand uvm_reg_field cmn_pll0_fracdivh_2_0;
  rand uvm_reg_field cmn_pll0_fracdivh_15_3;
  rand uvm_reg_field cmn_pll0_fracdivh_31_16;
  
  covergroup wr_fld_covg;
    cmn_pll0_fracdivh_2_0: coverpoint cmn_pll0_fracdivh_2_0.value[2:0];
    cmn_pll0_fracdivh_15_3: coverpoint cmn_pll0_fracdivh_15_3.value[12:0];
    cmn_pll0_fracdivh_31_16: coverpoint cmn_pll0_fracdivh_31_16.value[15:0];
  endgroup
  covergroup rd_fld_covg;
    cmn_pll0_fracdivh_2_0: coverpoint cmn_pll0_fracdivh_2_0.value[2:0];
    cmn_pll0_fracdivh_15_3: coverpoint cmn_pll0_fracdivh_15_3.value[12:0];
    cmn_pll0_fracdivh_31_16: coverpoint cmn_pll0_fracdivh_31_16.value[15:0];
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
    
    cmn_pll0_fracdivh_2_0 = fld_set[0];
    cmn_pll0_fracdivh_15_3 = fld_set[1];
    cmn_pll0_fracdivh_31_16 = fld_set[2];
  endfunction

  function new(input string name="T_cmn_pll0_fracdivh_1055");
    super.new(name, 32, build_coverage(UVM_CVR_FIELD_VALS));
    if (has_coverage(UVM_CVR_FIELD_VALS)) begin
      wr_fld_covg = new();
      rd_fld_covg = new();
    end
  endfunction

endclass


/////////////////////////////////////////////////////
//                cmn_pll0_fracdivl
/////////////////////////////////////////////////////
class T_cmn_pll0_fracdivl_1054 extends cdns_uvm_reg;

  `uvm_object_utils(T_cmn_pll0_fracdivl_1054)
  rand uvm_reg_field cmn_pll0_fracdivl_15_0;
  rand uvm_reg_field cmn_pll0_fracdivl_31_16;
  
  covergroup wr_fld_covg;
    cmn_pll0_fracdivl_15_0: coverpoint cmn_pll0_fracdivl_15_0.value[15:0];
    cmn_pll0_fracdivl_31_16: coverpoint cmn_pll0_fracdivl_31_16.value[15:0];
  endgroup
  covergroup rd_fld_covg;
    cmn_pll0_fracdivl_15_0: coverpoint cmn_pll0_fracdivl_15_0.value[15:0];
    cmn_pll0_fracdivl_31_16: coverpoint cmn_pll0_fracdivl_31_16.value[15:0];
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
    
    cmn_pll0_fracdivl_15_0 = fld_set[0];
    cmn_pll0_fracdivl_31_16 = fld_set[1];
  endfunction

  function new(input string name="T_cmn_pll0_fracdivl_1054");
    super.new(name, 32, build_coverage(UVM_CVR_FIELD_VALS));
    if (has_coverage(UVM_CVR_FIELD_VALS)) begin
      wr_fld_covg = new();
      rd_fld_covg = new();
    end
  endfunction

endclass


/////////////////////////////////////////////////////
//                cmn_pll0_high_thr
/////////////////////////////////////////////////////
class T_cmn_pll0_high_thr_1056 extends cdns_uvm_reg;

  `uvm_object_utils(T_cmn_pll0_high_thr_1056)
  rand uvm_reg_field cmn_pll0_high_thr_9_0;
  rand uvm_reg_field cmn_pll0_high_thr_15_10;
  rand uvm_reg_field cmn_pll0_high_thr_31_16;
  
  covergroup wr_fld_covg;
    cmn_pll0_high_thr_9_0: coverpoint cmn_pll0_high_thr_9_0.value[9:0];
    cmn_pll0_high_thr_15_10: coverpoint cmn_pll0_high_thr_15_10.value[5:0];
    cmn_pll0_high_thr_31_16: coverpoint cmn_pll0_high_thr_31_16.value[15:0];
  endgroup
  covergroup rd_fld_covg;
    cmn_pll0_high_thr_9_0: coverpoint cmn_pll0_high_thr_9_0.value[9:0];
    cmn_pll0_high_thr_15_10: coverpoint cmn_pll0_high_thr_15_10.value[5:0];
    cmn_pll0_high_thr_31_16: coverpoint cmn_pll0_high_thr_31_16.value[15:0];
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
    
    cmn_pll0_high_thr_9_0 = fld_set[0];
    cmn_pll0_high_thr_15_10 = fld_set[1];
    cmn_pll0_high_thr_31_16 = fld_set[2];
  endfunction

  function new(input string name="T_cmn_pll0_high_thr_1056");
    super.new(name, 32, build_coverage(UVM_CVR_FIELD_VALS));
    if (has_coverage(UVM_CVR_FIELD_VALS)) begin
      wr_fld_covg = new();
      rd_fld_covg = new();
    end
  endfunction

endclass


/////////////////////////////////////////////////////
//                cmn_pll0_intdiv
/////////////////////////////////////////////////////
class T_cmn_pll0_intdiv_1053 extends cdns_uvm_reg;

  `uvm_object_utils(T_cmn_pll0_intdiv_1053)
  rand uvm_reg_field cmn_pll0_intdiv_9_0;
  rand uvm_reg_field cmn_pll0_intdiv_15_10;
  rand uvm_reg_field cmn_pll0_intdiv_31_16;
  
  covergroup wr_fld_covg;
    cmn_pll0_intdiv_9_0: coverpoint cmn_pll0_intdiv_9_0.value[9:0];
    cmn_pll0_intdiv_15_10: coverpoint cmn_pll0_intdiv_15_10.value[5:0];
    cmn_pll0_intdiv_31_16: coverpoint cmn_pll0_intdiv_31_16.value[15:0];
  endgroup
  covergroup rd_fld_covg;
    cmn_pll0_intdiv_9_0: coverpoint cmn_pll0_intdiv_9_0.value[9:0];
    cmn_pll0_intdiv_15_10: coverpoint cmn_pll0_intdiv_15_10.value[5:0];
    cmn_pll0_intdiv_31_16: coverpoint cmn_pll0_intdiv_31_16.value[15:0];
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
    
    cmn_pll0_intdiv_9_0 = fld_set[0];
    cmn_pll0_intdiv_15_10 = fld_set[1];
    cmn_pll0_intdiv_31_16 = fld_set[2];
  endfunction

  function new(input string name="T_cmn_pll0_intdiv_1053");
    super.new(name, 32, build_coverage(UVM_CVR_FIELD_VALS));
    if (has_coverage(UVM_CVR_FIELD_VALS)) begin
      wr_fld_covg = new();
      rd_fld_covg = new();
    end
  endfunction

endclass


/////////////////////////////////////////////////////
//                cmn_pll0_lock_pllcnt_start
/////////////////////////////////////////////////////
class T_cmn_pll0_lock_pllcnt_start_1065 extends cdns_uvm_reg;

  `uvm_object_utils(T_cmn_pll0_lock_pllcnt_start_1065)
  rand uvm_reg_field cmn_pll0_lock_pllcnt_start_11_0;
  rand uvm_reg_field cmn_pll0_lock_pllcnt_start_15_12;
  rand uvm_reg_field cmn_pll0_lock_pllcnt_start_31_16;
  
  covergroup wr_fld_covg;
    cmn_pll0_lock_pllcnt_start_11_0: coverpoint cmn_pll0_lock_pllcnt_start_11_0.value[11:0];
    cmn_pll0_lock_pllcnt_start_15_12: coverpoint cmn_pll0_lock_pllcnt_start_15_12.value[3:0];
    cmn_pll0_lock_pllcnt_start_31_16: coverpoint cmn_pll0_lock_pllcnt_start_31_16.value[15:0];
  endgroup
  covergroup rd_fld_covg;
    cmn_pll0_lock_pllcnt_start_11_0: coverpoint cmn_pll0_lock_pllcnt_start_11_0.value[11:0];
    cmn_pll0_lock_pllcnt_start_15_12: coverpoint cmn_pll0_lock_pllcnt_start_15_12.value[3:0];
    cmn_pll0_lock_pllcnt_start_31_16: coverpoint cmn_pll0_lock_pllcnt_start_31_16.value[15:0];
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
    
    cmn_pll0_lock_pllcnt_start_11_0 = fld_set[0];
    cmn_pll0_lock_pllcnt_start_15_12 = fld_set[1];
    cmn_pll0_lock_pllcnt_start_31_16 = fld_set[2];
  endfunction

  function new(input string name="T_cmn_pll0_lock_pllcnt_start_1065");
    super.new(name, 32, build_coverage(UVM_CVR_FIELD_VALS));
    if (has_coverage(UVM_CVR_FIELD_VALS)) begin
      wr_fld_covg = new();
      rd_fld_covg = new();
    end
  endfunction

endclass


/////////////////////////////////////////////////////
//                cmn_pll0_lock_pllcnt_thr
/////////////////////////////////////////////////////
class T_cmn_pll0_lock_pllcnt_thr_1066 extends cdns_uvm_reg;

  `uvm_object_utils(T_cmn_pll0_lock_pllcnt_thr_1066)
  rand uvm_reg_field cmn_pll0_lock_pllcnt_thr_11_0;
  rand uvm_reg_field cmn_pll0_lock_pllcnt_thr_15_12;
  rand uvm_reg_field cmn_pll0_lock_pllcnt_thr_31_16;
  
  covergroup wr_fld_covg;
    cmn_pll0_lock_pllcnt_thr_11_0: coverpoint cmn_pll0_lock_pllcnt_thr_11_0.value[11:0];
    cmn_pll0_lock_pllcnt_thr_15_12: coverpoint cmn_pll0_lock_pllcnt_thr_15_12.value[3:0];
    cmn_pll0_lock_pllcnt_thr_31_16: coverpoint cmn_pll0_lock_pllcnt_thr_31_16.value[15:0];
  endgroup
  covergroup rd_fld_covg;
    cmn_pll0_lock_pllcnt_thr_11_0: coverpoint cmn_pll0_lock_pllcnt_thr_11_0.value[11:0];
    cmn_pll0_lock_pllcnt_thr_15_12: coverpoint cmn_pll0_lock_pllcnt_thr_15_12.value[3:0];
    cmn_pll0_lock_pllcnt_thr_31_16: coverpoint cmn_pll0_lock_pllcnt_thr_31_16.value[15:0];
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
    
    cmn_pll0_lock_pllcnt_thr_11_0 = fld_set[0];
    cmn_pll0_lock_pllcnt_thr_15_12 = fld_set[1];
    cmn_pll0_lock_pllcnt_thr_31_16 = fld_set[2];
  endfunction

  function new(input string name="T_cmn_pll0_lock_pllcnt_thr_1066");
    super.new(name, 32, build_coverage(UVM_CVR_FIELD_VALS));
    if (has_coverage(UVM_CVR_FIELD_VALS)) begin
      wr_fld_covg = new();
      rd_fld_covg = new();
    end
  endfunction

endclass


/////////////////////////////////////////////////////
//                cmn_pll0_lock_refcnt_idle
/////////////////////////////////////////////////////
class T_cmn_pll0_lock_refcnt_idle_1064 extends cdns_uvm_reg;

  `uvm_object_utils(T_cmn_pll0_lock_refcnt_idle_1064)
  rand uvm_reg_field cmn_pll0_lock_refcnt_idle_11_0;
  rand uvm_reg_field cmn_pll0_lock_refcnt_idle_15_12;
  rand uvm_reg_field cmn_pll0_lock_refcnt_idle_31_16;
  
  covergroup wr_fld_covg;
    cmn_pll0_lock_refcnt_idle_11_0: coverpoint cmn_pll0_lock_refcnt_idle_11_0.value[11:0];
    cmn_pll0_lock_refcnt_idle_15_12: coverpoint cmn_pll0_lock_refcnt_idle_15_12.value[3:0];
    cmn_pll0_lock_refcnt_idle_31_16: coverpoint cmn_pll0_lock_refcnt_idle_31_16.value[15:0];
  endgroup
  covergroup rd_fld_covg;
    cmn_pll0_lock_refcnt_idle_11_0: coverpoint cmn_pll0_lock_refcnt_idle_11_0.value[11:0];
    cmn_pll0_lock_refcnt_idle_15_12: coverpoint cmn_pll0_lock_refcnt_idle_15_12.value[3:0];
    cmn_pll0_lock_refcnt_idle_31_16: coverpoint cmn_pll0_lock_refcnt_idle_31_16.value[15:0];
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
    
    cmn_pll0_lock_refcnt_idle_11_0 = fld_set[0];
    cmn_pll0_lock_refcnt_idle_15_12 = fld_set[1];
    cmn_pll0_lock_refcnt_idle_31_16 = fld_set[2];
  endfunction

  function new(input string name="T_cmn_pll0_lock_refcnt_idle_1064");
    super.new(name, 32, build_coverage(UVM_CVR_FIELD_VALS));
    if (has_coverage(UVM_CVR_FIELD_VALS)) begin
      wr_fld_covg = new();
      rd_fld_covg = new();
    end
  endfunction

endclass


/////////////////////////////////////////////////////
//                cmn_pll0_lock_refcnt_start
/////////////////////////////////////////////////////
class T_cmn_pll0_lock_refcnt_start_1063 extends cdns_uvm_reg;

  `uvm_object_utils(T_cmn_pll0_lock_refcnt_start_1063)
  rand uvm_reg_field cmn_pll0_lock_refcnt_start_11_0;
  rand uvm_reg_field cmn_pll0_lock_refcnt_start_15_12;
  rand uvm_reg_field cmn_pll0_lock_refcnt_start_31_16;
  
  covergroup wr_fld_covg;
    cmn_pll0_lock_refcnt_start_11_0: coverpoint cmn_pll0_lock_refcnt_start_11_0.value[11:0];
    cmn_pll0_lock_refcnt_start_15_12: coverpoint cmn_pll0_lock_refcnt_start_15_12.value[3:0];
    cmn_pll0_lock_refcnt_start_31_16: coverpoint cmn_pll0_lock_refcnt_start_31_16.value[15:0];
  endgroup
  covergroup rd_fld_covg;
    cmn_pll0_lock_refcnt_start_11_0: coverpoint cmn_pll0_lock_refcnt_start_11_0.value[11:0];
    cmn_pll0_lock_refcnt_start_15_12: coverpoint cmn_pll0_lock_refcnt_start_15_12.value[3:0];
    cmn_pll0_lock_refcnt_start_31_16: coverpoint cmn_pll0_lock_refcnt_start_31_16.value[15:0];
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
    
    cmn_pll0_lock_refcnt_start_11_0 = fld_set[0];
    cmn_pll0_lock_refcnt_start_15_12 = fld_set[1];
    cmn_pll0_lock_refcnt_start_31_16 = fld_set[2];
  endfunction

  function new(input string name="T_cmn_pll0_lock_refcnt_start_1063");
    super.new(name, 32, build_coverage(UVM_CVR_FIELD_VALS));
    if (has_coverage(UVM_CVR_FIELD_VALS)) begin
      wr_fld_covg = new();
      rd_fld_covg = new();
    end
  endfunction

endclass


/////////////////////////////////////////////////////
//                cmn_pll0_ss_ctrl1
/////////////////////////////////////////////////////
class T_cmn_pll0_ss_ctrl1_1060 extends cdns_uvm_reg;

  `uvm_object_utils(T_cmn_pll0_ss_ctrl1_1060)
  rand uvm_reg_field cmn_pll0_ss_ctrl1_0;
  rand uvm_reg_field cmn_pll0_ss_ctrl1_1;
  rand uvm_reg_field cmn_pll0_ss_ctrl1_7_2;
  rand uvm_reg_field cmn_pll0_ss_ctrl1_14_8;
  rand uvm_reg_field cmn_pll0_ss_ctrl1_15;
  rand uvm_reg_field cmn_pll0_ss_ctrl1_30_16;
  rand uvm_reg_field cmn_pll0_ss_ctrl1_31;
  
  covergroup wr_fld_covg;
    cmn_pll0_ss_ctrl1_0: coverpoint cmn_pll0_ss_ctrl1_0.value[0:0];
    cmn_pll0_ss_ctrl1_1: coverpoint cmn_pll0_ss_ctrl1_1.value[0:0];
    cmn_pll0_ss_ctrl1_7_2: coverpoint cmn_pll0_ss_ctrl1_7_2.value[5:0];
    cmn_pll0_ss_ctrl1_14_8: coverpoint cmn_pll0_ss_ctrl1_14_8.value[6:0];
    cmn_pll0_ss_ctrl1_15: coverpoint cmn_pll0_ss_ctrl1_15.value[0:0];
    cmn_pll0_ss_ctrl1_30_16: coverpoint cmn_pll0_ss_ctrl1_30_16.value[14:0];
    cmn_pll0_ss_ctrl1_31: coverpoint cmn_pll0_ss_ctrl1_31.value[0:0];
  endgroup
  covergroup rd_fld_covg;
    cmn_pll0_ss_ctrl1_0: coverpoint cmn_pll0_ss_ctrl1_0.value[0:0];
    cmn_pll0_ss_ctrl1_1: coverpoint cmn_pll0_ss_ctrl1_1.value[0:0];
    cmn_pll0_ss_ctrl1_7_2: coverpoint cmn_pll0_ss_ctrl1_7_2.value[5:0];
    cmn_pll0_ss_ctrl1_14_8: coverpoint cmn_pll0_ss_ctrl1_14_8.value[6:0];
    cmn_pll0_ss_ctrl1_15: coverpoint cmn_pll0_ss_ctrl1_15.value[0:0];
    cmn_pll0_ss_ctrl1_30_16: coverpoint cmn_pll0_ss_ctrl1_30_16.value[14:0];
    cmn_pll0_ss_ctrl1_31: coverpoint cmn_pll0_ss_ctrl1_31.value[0:0];
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
    
    cmn_pll0_ss_ctrl1_0 = fld_set[0];
    cmn_pll0_ss_ctrl1_1 = fld_set[1];
    cmn_pll0_ss_ctrl1_7_2 = fld_set[2];
    cmn_pll0_ss_ctrl1_14_8 = fld_set[3];
    cmn_pll0_ss_ctrl1_15 = fld_set[4];
    cmn_pll0_ss_ctrl1_30_16 = fld_set[5];
    cmn_pll0_ss_ctrl1_31 = fld_set[6];
  endfunction

  function new(input string name="T_cmn_pll0_ss_ctrl1_1060");
    super.new(name, 32, build_coverage(UVM_CVR_FIELD_VALS));
    if (has_coverage(UVM_CVR_FIELD_VALS)) begin
      wr_fld_covg = new();
      rd_fld_covg = new();
    end
  endfunction

endclass


/////////////////////////////////////////////////////
//                cmn_pll0_ss_ctrl2
/////////////////////////////////////////////////////
class T_cmn_pll0_ss_ctrl2_1061 extends cdns_uvm_reg;

  `uvm_object_utils(T_cmn_pll0_ss_ctrl2_1061)
  rand uvm_reg_field cmn_pll0_ss_ctrl2_6_0;
  rand uvm_reg_field cmn_pll0_ss_ctrl2_7;
  rand uvm_reg_field cmn_pll0_ss_ctrl2_14_8;
  rand uvm_reg_field cmn_pll0_ss_ctrl2_15;
  rand uvm_reg_field cmn_pll0_ss_ctrl2_31_16;
  
  covergroup wr_fld_covg;
    cmn_pll0_ss_ctrl2_6_0: coverpoint cmn_pll0_ss_ctrl2_6_0.value[6:0];
    cmn_pll0_ss_ctrl2_7: coverpoint cmn_pll0_ss_ctrl2_7.value[0:0];
    cmn_pll0_ss_ctrl2_14_8: coverpoint cmn_pll0_ss_ctrl2_14_8.value[6:0];
    cmn_pll0_ss_ctrl2_15: coverpoint cmn_pll0_ss_ctrl2_15.value[0:0];
    cmn_pll0_ss_ctrl2_31_16: coverpoint cmn_pll0_ss_ctrl2_31_16.value[15:0];
  endgroup
  covergroup rd_fld_covg;
    cmn_pll0_ss_ctrl2_6_0: coverpoint cmn_pll0_ss_ctrl2_6_0.value[6:0];
    cmn_pll0_ss_ctrl2_7: coverpoint cmn_pll0_ss_ctrl2_7.value[0:0];
    cmn_pll0_ss_ctrl2_14_8: coverpoint cmn_pll0_ss_ctrl2_14_8.value[6:0];
    cmn_pll0_ss_ctrl2_15: coverpoint cmn_pll0_ss_ctrl2_15.value[0:0];
    cmn_pll0_ss_ctrl2_31_16: coverpoint cmn_pll0_ss_ctrl2_31_16.value[15:0];
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
    
    cmn_pll0_ss_ctrl2_6_0 = fld_set[0];
    cmn_pll0_ss_ctrl2_7 = fld_set[1];
    cmn_pll0_ss_ctrl2_14_8 = fld_set[2];
    cmn_pll0_ss_ctrl2_15 = fld_set[3];
    cmn_pll0_ss_ctrl2_31_16 = fld_set[4];
  endfunction

  function new(input string name="T_cmn_pll0_ss_ctrl2_1061");
    super.new(name, 32, build_coverage(UVM_CVR_FIELD_VALS));
    if (has_coverage(UVM_CVR_FIELD_VALS)) begin
      wr_fld_covg = new();
      rd_fld_covg = new();
    end
  endfunction

endclass


/////////////////////////////////////////////////////
//                cmn_pll0_ss_ctrl3
/////////////////////////////////////////////////////
class T_cmn_pll0_ss_ctrl3_1062 extends cdns_uvm_reg;

  `uvm_object_utils(T_cmn_pll0_ss_ctrl3_1062)
  rand uvm_reg_field cmn_pll0_ss_ctrl3_18_0;
  rand uvm_reg_field cmn_pll0_ss_ctrl3_31_19;
  
  covergroup wr_fld_covg;
    cmn_pll0_ss_ctrl3_18_0: coverpoint cmn_pll0_ss_ctrl3_18_0.value[18:0];
    cmn_pll0_ss_ctrl3_31_19: coverpoint cmn_pll0_ss_ctrl3_31_19.value[12:0];
  endgroup
  covergroup rd_fld_covg;
    cmn_pll0_ss_ctrl3_18_0: coverpoint cmn_pll0_ss_ctrl3_18_0.value[18:0];
    cmn_pll0_ss_ctrl3_31_19: coverpoint cmn_pll0_ss_ctrl3_31_19.value[12:0];
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
    
    cmn_pll0_ss_ctrl3_18_0 = fld_set[0];
    cmn_pll0_ss_ctrl3_31_19 = fld_set[1];
  endfunction

  function new(input string name="T_cmn_pll0_ss_ctrl3_1062");
    super.new(name, 32, build_coverage(UVM_CVR_FIELD_VALS));
    if (has_coverage(UVM_CVR_FIELD_VALS)) begin
      wr_fld_covg = new();
      rd_fld_covg = new();
    end
  endfunction

endclass


/////////////////////////////////////////////////////
//                cmn_pll0_varcal_ctrl
/////////////////////////////////////////////////////
class T_cmn_pll0_varcal_ctrl_1067 extends cdns_uvm_reg;

  `uvm_object_utils(T_cmn_pll0_varcal_ctrl_1067)
  rand uvm_reg_field cmn_pll0_varcal_ctrl_4_0;
  rand uvm_reg_field cmn_pll0_varcal_ctrl_7_5;
  rand uvm_reg_field cmn_pll0_varcal_ctrl_8;
  rand uvm_reg_field cmn_pll0_varcal_ctrl_11_9;
  rand uvm_reg_field cmn_pll0_varcal_ctrl_13_12;
  rand uvm_reg_field cmn_pll0_varcal_ctrl_14;
  rand uvm_reg_field cmn_pll0_varcal_ctrl_15;
  rand uvm_reg_field cmn_pll0_varcal_ctrl_31_16;
  
  covergroup wr_fld_covg;
    cmn_pll0_varcal_ctrl_4_0: coverpoint cmn_pll0_varcal_ctrl_4_0.value[4:0];
    cmn_pll0_varcal_ctrl_7_5: coverpoint cmn_pll0_varcal_ctrl_7_5.value[2:0];
    cmn_pll0_varcal_ctrl_8: coverpoint cmn_pll0_varcal_ctrl_8.value[0:0];
    cmn_pll0_varcal_ctrl_11_9: coverpoint cmn_pll0_varcal_ctrl_11_9.value[2:0];
    cmn_pll0_varcal_ctrl_13_12: coverpoint cmn_pll0_varcal_ctrl_13_12.value[1:0];
    cmn_pll0_varcal_ctrl_14: coverpoint cmn_pll0_varcal_ctrl_14.value[0:0];
    cmn_pll0_varcal_ctrl_15: coverpoint cmn_pll0_varcal_ctrl_15.value[0:0];
    cmn_pll0_varcal_ctrl_31_16: coverpoint cmn_pll0_varcal_ctrl_31_16.value[15:0];
  endgroup
  covergroup rd_fld_covg;
    cmn_pll0_varcal_ctrl_4_0: coverpoint cmn_pll0_varcal_ctrl_4_0.value[4:0];
    cmn_pll0_varcal_ctrl_7_5: coverpoint cmn_pll0_varcal_ctrl_7_5.value[2:0];
    cmn_pll0_varcal_ctrl_8: coverpoint cmn_pll0_varcal_ctrl_8.value[0:0];
    cmn_pll0_varcal_ctrl_11_9: coverpoint cmn_pll0_varcal_ctrl_11_9.value[2:0];
    cmn_pll0_varcal_ctrl_13_12: coverpoint cmn_pll0_varcal_ctrl_13_12.value[1:0];
    cmn_pll0_varcal_ctrl_14: coverpoint cmn_pll0_varcal_ctrl_14.value[0:0];
    cmn_pll0_varcal_ctrl_15: coverpoint cmn_pll0_varcal_ctrl_15.value[0:0];
    cmn_pll0_varcal_ctrl_31_16: coverpoint cmn_pll0_varcal_ctrl_31_16.value[15:0];
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
    
    cmn_pll0_varcal_ctrl_4_0 = fld_set[0];
    cmn_pll0_varcal_ctrl_7_5 = fld_set[1];
    cmn_pll0_varcal_ctrl_8 = fld_set[2];
    cmn_pll0_varcal_ctrl_11_9 = fld_set[3];
    cmn_pll0_varcal_ctrl_13_12 = fld_set[4];
    cmn_pll0_varcal_ctrl_14 = fld_set[5];
    cmn_pll0_varcal_ctrl_15 = fld_set[6];
    cmn_pll0_varcal_ctrl_31_16 = fld_set[7];
  endfunction

  function new(input string name="T_cmn_pll0_varcal_ctrl_1067");
    super.new(name, 32, build_coverage(UVM_CVR_FIELD_VALS));
    if (has_coverage(UVM_CVR_FIELD_VALS)) begin
      wr_fld_covg = new();
      rd_fld_covg = new();
    end
  endfunction

endclass


/////////////////////////////////////////////////////
//                cmn_pll0_varcal_icvf_cfg
/////////////////////////////////////////////////////
class T_cmn_pll0_varcal_icvf_cfg_1075 extends cdns_uvm_reg;

  `uvm_object_utils(T_cmn_pll0_varcal_icvf_cfg_1075)
  rand uvm_reg_field cmn_pll0_varcal_icvf_cfg_2_0;
  rand uvm_reg_field cmn_pll0_varcal_icvf_cfg_3;
  rand uvm_reg_field cmn_pll0_varcal_icvf_cfg_6_4;
  rand uvm_reg_field cmn_pll0_varcal_icvf_cfg_7;
  rand uvm_reg_field cmn_pll0_varcal_icvf_cfg_10_8;
  rand uvm_reg_field cmn_pll0_varcal_icvf_cfg_11;
  rand uvm_reg_field cmn_pll0_varcal_icvf_cfg_12;
  rand uvm_reg_field cmn_pll0_varcal_icvf_cfg_15_13;
  rand uvm_reg_field cmn_pll0_varcal_icvf_cfg_31_16;
  
  covergroup wr_fld_covg;
    cmn_pll0_varcal_icvf_cfg_2_0: coverpoint cmn_pll0_varcal_icvf_cfg_2_0.value[2:0];
    cmn_pll0_varcal_icvf_cfg_3: coverpoint cmn_pll0_varcal_icvf_cfg_3.value[0:0];
    cmn_pll0_varcal_icvf_cfg_6_4: coverpoint cmn_pll0_varcal_icvf_cfg_6_4.value[2:0];
    cmn_pll0_varcal_icvf_cfg_7: coverpoint cmn_pll0_varcal_icvf_cfg_7.value[0:0];
    cmn_pll0_varcal_icvf_cfg_10_8: coverpoint cmn_pll0_varcal_icvf_cfg_10_8.value[2:0];
    cmn_pll0_varcal_icvf_cfg_11: coverpoint cmn_pll0_varcal_icvf_cfg_11.value[0:0];
    cmn_pll0_varcal_icvf_cfg_12: coverpoint cmn_pll0_varcal_icvf_cfg_12.value[0:0];
    cmn_pll0_varcal_icvf_cfg_15_13: coverpoint cmn_pll0_varcal_icvf_cfg_15_13.value[2:0];
    cmn_pll0_varcal_icvf_cfg_31_16: coverpoint cmn_pll0_varcal_icvf_cfg_31_16.value[15:0];
  endgroup
  covergroup rd_fld_covg;
    cmn_pll0_varcal_icvf_cfg_2_0: coverpoint cmn_pll0_varcal_icvf_cfg_2_0.value[2:0];
    cmn_pll0_varcal_icvf_cfg_3: coverpoint cmn_pll0_varcal_icvf_cfg_3.value[0:0];
    cmn_pll0_varcal_icvf_cfg_6_4: coverpoint cmn_pll0_varcal_icvf_cfg_6_4.value[2:0];
    cmn_pll0_varcal_icvf_cfg_7: coverpoint cmn_pll0_varcal_icvf_cfg_7.value[0:0];
    cmn_pll0_varcal_icvf_cfg_10_8: coverpoint cmn_pll0_varcal_icvf_cfg_10_8.value[2:0];
    cmn_pll0_varcal_icvf_cfg_11: coverpoint cmn_pll0_varcal_icvf_cfg_11.value[0:0];
    cmn_pll0_varcal_icvf_cfg_12: coverpoint cmn_pll0_varcal_icvf_cfg_12.value[0:0];
    cmn_pll0_varcal_icvf_cfg_15_13: coverpoint cmn_pll0_varcal_icvf_cfg_15_13.value[2:0];
    cmn_pll0_varcal_icvf_cfg_31_16: coverpoint cmn_pll0_varcal_icvf_cfg_31_16.value[15:0];
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
    
    cmn_pll0_varcal_icvf_cfg_2_0 = fld_set[0];
    cmn_pll0_varcal_icvf_cfg_3 = fld_set[1];
    cmn_pll0_varcal_icvf_cfg_6_4 = fld_set[2];
    cmn_pll0_varcal_icvf_cfg_7 = fld_set[3];
    cmn_pll0_varcal_icvf_cfg_10_8 = fld_set[4];
    cmn_pll0_varcal_icvf_cfg_11 = fld_set[5];
    cmn_pll0_varcal_icvf_cfg_12 = fld_set[6];
    cmn_pll0_varcal_icvf_cfg_15_13 = fld_set[7];
    cmn_pll0_varcal_icvf_cfg_31_16 = fld_set[8];
  endfunction

  function new(input string name="T_cmn_pll0_varcal_icvf_cfg_1075");
    super.new(name, 32, build_coverage(UVM_CVR_FIELD_VALS));
    if (has_coverage(UVM_CVR_FIELD_VALS)) begin
      wr_fld_covg = new();
      rd_fld_covg = new();
    end
  endfunction

endclass


/////////////////////////////////////////////////////
//                cmn_pll0_varcal_icvf_hstat
/////////////////////////////////////////////////////
class T_cmn_pll0_varcal_icvf_hstat_1077 extends cdns_uvm_reg;

  `uvm_object_utils(T_cmn_pll0_varcal_icvf_hstat_1077)
  rand uvm_reg_field cmn_pll0_varcal_icvf_hstat_15_0;
  rand uvm_reg_field cmn_pll0_varcal_icvf_hstat_31_16;
  
  covergroup wr_fld_covg;
    cmn_pll0_varcal_icvf_hstat_15_0: coverpoint cmn_pll0_varcal_icvf_hstat_15_0.value[15:0];
    cmn_pll0_varcal_icvf_hstat_31_16: coverpoint cmn_pll0_varcal_icvf_hstat_31_16.value[15:0];
  endgroup
  covergroup rd_fld_covg;
    cmn_pll0_varcal_icvf_hstat_15_0: coverpoint cmn_pll0_varcal_icvf_hstat_15_0.value[15:0];
    cmn_pll0_varcal_icvf_hstat_31_16: coverpoint cmn_pll0_varcal_icvf_hstat_31_16.value[15:0];
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
    
    cmn_pll0_varcal_icvf_hstat_15_0 = fld_set[0];
    cmn_pll0_varcal_icvf_hstat_31_16 = fld_set[1];
  endfunction

  function new(input string name="T_cmn_pll0_varcal_icvf_hstat_1077");
    super.new(name, 32, build_coverage(UVM_CVR_FIELD_VALS));
    if (has_coverage(UVM_CVR_FIELD_VALS)) begin
      wr_fld_covg = new();
      rd_fld_covg = new();
    end
  endfunction

endclass


/////////////////////////////////////////////////////
//                cmn_pll0_varcal_icvf_init_tmr
/////////////////////////////////////////////////////
class T_cmn_pll0_varcal_icvf_init_tmr_1074 extends cdns_uvm_reg;

  `uvm_object_utils(T_cmn_pll0_varcal_icvf_init_tmr_1074)
  rand uvm_reg_field cmn_pll0_varcal_icvf_init_tmr_9_0;
  rand uvm_reg_field cmn_pll0_varcal_icvf_init_tmr_15_10;
  rand uvm_reg_field cmn_pll0_varcal_icvf_init_tmr_31_16;
  
  covergroup wr_fld_covg;
    cmn_pll0_varcal_icvf_init_tmr_9_0: coverpoint cmn_pll0_varcal_icvf_init_tmr_9_0.value[9:0];
    cmn_pll0_varcal_icvf_init_tmr_15_10: coverpoint cmn_pll0_varcal_icvf_init_tmr_15_10.value[5:0];
    cmn_pll0_varcal_icvf_init_tmr_31_16: coverpoint cmn_pll0_varcal_icvf_init_tmr_31_16.value[15:0];
  endgroup
  covergroup rd_fld_covg;
    cmn_pll0_varcal_icvf_init_tmr_9_0: coverpoint cmn_pll0_varcal_icvf_init_tmr_9_0.value[9:0];
    cmn_pll0_varcal_icvf_init_tmr_15_10: coverpoint cmn_pll0_varcal_icvf_init_tmr_15_10.value[5:0];
    cmn_pll0_varcal_icvf_init_tmr_31_16: coverpoint cmn_pll0_varcal_icvf_init_tmr_31_16.value[15:0];
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
    
    cmn_pll0_varcal_icvf_init_tmr_9_0 = fld_set[0];
    cmn_pll0_varcal_icvf_init_tmr_15_10 = fld_set[1];
    cmn_pll0_varcal_icvf_init_tmr_31_16 = fld_set[2];
  endfunction

  function new(input string name="T_cmn_pll0_varcal_icvf_init_tmr_1074");
    super.new(name, 32, build_coverage(UVM_CVR_FIELD_VALS));
    if (has_coverage(UVM_CVR_FIELD_VALS)) begin
      wr_fld_covg = new();
      rd_fld_covg = new();
    end
  endfunction

endclass


/////////////////////////////////////////////////////
//                cmn_pll0_varcal_icvf_lstat
/////////////////////////////////////////////////////
class T_cmn_pll0_varcal_icvf_lstat_1076 extends cdns_uvm_reg;

  `uvm_object_utils(T_cmn_pll0_varcal_icvf_lstat_1076)
  rand uvm_reg_field cmn_pll0_varcal_icvf_lstat_15_0;
  rand uvm_reg_field cmn_pll0_varcal_icvf_lstat_31_16;
  
  covergroup wr_fld_covg;
    cmn_pll0_varcal_icvf_lstat_15_0: coverpoint cmn_pll0_varcal_icvf_lstat_15_0.value[15:0];
    cmn_pll0_varcal_icvf_lstat_31_16: coverpoint cmn_pll0_varcal_icvf_lstat_31_16.value[15:0];
  endgroup
  covergroup rd_fld_covg;
    cmn_pll0_varcal_icvf_lstat_15_0: coverpoint cmn_pll0_varcal_icvf_lstat_15_0.value[15:0];
    cmn_pll0_varcal_icvf_lstat_31_16: coverpoint cmn_pll0_varcal_icvf_lstat_31_16.value[15:0];
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
    
    cmn_pll0_varcal_icvf_lstat_15_0 = fld_set[0];
    cmn_pll0_varcal_icvf_lstat_31_16 = fld_set[1];
  endfunction

  function new(input string name="T_cmn_pll0_varcal_icvf_lstat_1076");
    super.new(name, 32, build_coverage(UVM_CVR_FIELD_VALS));
    if (has_coverage(UVM_CVR_FIELD_VALS)) begin
      wr_fld_covg = new();
      rd_fld_covg = new();
    end
  endfunction

endclass


/////////////////////////////////////////////////////
//                cmn_pll0_varcal_init_tmr
/////////////////////////////////////////////////////
class T_cmn_pll0_varcal_init_tmr_1071 extends cdns_uvm_reg;

  `uvm_object_utils(T_cmn_pll0_varcal_init_tmr_1071)
  rand uvm_reg_field cmn_pll0_varcal_init_tmr_13_0;
  rand uvm_reg_field cmn_pll0_varcal_init_tmr_15_14;
  rand uvm_reg_field cmn_pll0_varcal_init_tmr_31_16;
  
  covergroup wr_fld_covg;
    cmn_pll0_varcal_init_tmr_13_0: coverpoint cmn_pll0_varcal_init_tmr_13_0.value[13:0];
    cmn_pll0_varcal_init_tmr_15_14: coverpoint cmn_pll0_varcal_init_tmr_15_14.value[1:0];
    cmn_pll0_varcal_init_tmr_31_16: coverpoint cmn_pll0_varcal_init_tmr_31_16.value[15:0];
  endgroup
  covergroup rd_fld_covg;
    cmn_pll0_varcal_init_tmr_13_0: coverpoint cmn_pll0_varcal_init_tmr_13_0.value[13:0];
    cmn_pll0_varcal_init_tmr_15_14: coverpoint cmn_pll0_varcal_init_tmr_15_14.value[1:0];
    cmn_pll0_varcal_init_tmr_31_16: coverpoint cmn_pll0_varcal_init_tmr_31_16.value[15:0];
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
    
    cmn_pll0_varcal_init_tmr_13_0 = fld_set[0];
    cmn_pll0_varcal_init_tmr_15_14 = fld_set[1];
    cmn_pll0_varcal_init_tmr_31_16 = fld_set[2];
  endfunction

  function new(input string name="T_cmn_pll0_varcal_init_tmr_1071");
    super.new(name, 32, build_coverage(UVM_CVR_FIELD_VALS));
    if (has_coverage(UVM_CVR_FIELD_VALS)) begin
      wr_fld_covg = new();
      rd_fld_covg = new();
    end
  endfunction

endclass


/////////////////////////////////////////////////////
//                cmn_pll0_varcal_iter_tmr
/////////////////////////////////////////////////////
class T_cmn_pll0_varcal_iter_tmr_1072 extends cdns_uvm_reg;

  `uvm_object_utils(T_cmn_pll0_varcal_iter_tmr_1072)
  rand uvm_reg_field cmn_pll0_varcal_iter_tmr_13_0;
  rand uvm_reg_field cmn_pll0_varcal_iter_tmr_15_14;
  rand uvm_reg_field cmn_pll0_varcal_iter_tmr_31_16;
  
  covergroup wr_fld_covg;
    cmn_pll0_varcal_iter_tmr_13_0: coverpoint cmn_pll0_varcal_iter_tmr_13_0.value[13:0];
    cmn_pll0_varcal_iter_tmr_15_14: coverpoint cmn_pll0_varcal_iter_tmr_15_14.value[1:0];
    cmn_pll0_varcal_iter_tmr_31_16: coverpoint cmn_pll0_varcal_iter_tmr_31_16.value[15:0];
  endgroup
  covergroup rd_fld_covg;
    cmn_pll0_varcal_iter_tmr_13_0: coverpoint cmn_pll0_varcal_iter_tmr_13_0.value[13:0];
    cmn_pll0_varcal_iter_tmr_15_14: coverpoint cmn_pll0_varcal_iter_tmr_15_14.value[1:0];
    cmn_pll0_varcal_iter_tmr_31_16: coverpoint cmn_pll0_varcal_iter_tmr_31_16.value[15:0];
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
    
    cmn_pll0_varcal_iter_tmr_13_0 = fld_set[0];
    cmn_pll0_varcal_iter_tmr_15_14 = fld_set[1];
    cmn_pll0_varcal_iter_tmr_31_16 = fld_set[2];
  endfunction

  function new(input string name="T_cmn_pll0_varcal_iter_tmr_1072");
    super.new(name, 32, build_coverage(UVM_CVR_FIELD_VALS));
    if (has_coverage(UVM_CVR_FIELD_VALS)) begin
      wr_fld_covg = new();
      rd_fld_covg = new();
    end
  endfunction

endclass


/////////////////////////////////////////////////////
//                cmn_pll0_varcal_ovrd
/////////////////////////////////////////////////////
class T_cmn_pll0_varcal_ovrd_1070 extends cdns_uvm_reg;

  `uvm_object_utils(T_cmn_pll0_varcal_ovrd_1070)
  rand uvm_reg_field cmn_pll0_varcal_ovrd_4_0;
  rand uvm_reg_field cmn_pll0_varcal_ovrd_14_5;
  rand uvm_reg_field cmn_pll0_varcal_ovrd_15;
  rand uvm_reg_field cmn_pll0_varcal_ovrd_31_16;
  
  covergroup wr_fld_covg;
    cmn_pll0_varcal_ovrd_4_0: coverpoint cmn_pll0_varcal_ovrd_4_0.value[4:0];
    cmn_pll0_varcal_ovrd_14_5: coverpoint cmn_pll0_varcal_ovrd_14_5.value[9:0];
    cmn_pll0_varcal_ovrd_15: coverpoint cmn_pll0_varcal_ovrd_15.value[0:0];
    cmn_pll0_varcal_ovrd_31_16: coverpoint cmn_pll0_varcal_ovrd_31_16.value[15:0];
  endgroup
  covergroup rd_fld_covg;
    cmn_pll0_varcal_ovrd_4_0: coverpoint cmn_pll0_varcal_ovrd_4_0.value[4:0];
    cmn_pll0_varcal_ovrd_14_5: coverpoint cmn_pll0_varcal_ovrd_14_5.value[9:0];
    cmn_pll0_varcal_ovrd_15: coverpoint cmn_pll0_varcal_ovrd_15.value[0:0];
    cmn_pll0_varcal_ovrd_31_16: coverpoint cmn_pll0_varcal_ovrd_31_16.value[15:0];
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
    
    cmn_pll0_varcal_ovrd_4_0 = fld_set[0];
    cmn_pll0_varcal_ovrd_14_5 = fld_set[1];
    cmn_pll0_varcal_ovrd_15 = fld_set[2];
    cmn_pll0_varcal_ovrd_31_16 = fld_set[3];
  endfunction

  function new(input string name="T_cmn_pll0_varcal_ovrd_1070");
    super.new(name, 32, build_coverage(UVM_CVR_FIELD_VALS));
    if (has_coverage(UVM_CVR_FIELD_VALS)) begin
      wr_fld_covg = new();
      rd_fld_covg = new();
    end
  endfunction

endclass


/////////////////////////////////////////////////////
//                cmn_pll0_varcal_pllcnt_ovrd
/////////////////////////////////////////////////////
class T_cmn_pll0_varcal_pllcnt_ovrd_1078 extends cdns_uvm_reg;

  `uvm_object_utils(T_cmn_pll0_varcal_pllcnt_ovrd_1078)
  rand uvm_reg_field cmn_pll0_varcal_pllcnt_ovrd_15_0;
  rand uvm_reg_field cmn_pll0_varcal_pllcnt_ovrd_31_16;
  
  covergroup wr_fld_covg;
    cmn_pll0_varcal_pllcnt_ovrd_15_0: coverpoint cmn_pll0_varcal_pllcnt_ovrd_15_0.value[15:0];
    cmn_pll0_varcal_pllcnt_ovrd_31_16: coverpoint cmn_pll0_varcal_pllcnt_ovrd_31_16.value[15:0];
  endgroup
  covergroup rd_fld_covg;
    cmn_pll0_varcal_pllcnt_ovrd_15_0: coverpoint cmn_pll0_varcal_pllcnt_ovrd_15_0.value[15:0];
    cmn_pll0_varcal_pllcnt_ovrd_31_16: coverpoint cmn_pll0_varcal_pllcnt_ovrd_31_16.value[15:0];
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
    
    cmn_pll0_varcal_pllcnt_ovrd_15_0 = fld_set[0];
    cmn_pll0_varcal_pllcnt_ovrd_31_16 = fld_set[1];
  endfunction

  function new(input string name="T_cmn_pll0_varcal_pllcnt_ovrd_1078");
    super.new(name, 32, build_coverage(UVM_CVR_FIELD_VALS));
    if (has_coverage(UVM_CVR_FIELD_VALS)) begin
      wr_fld_covg = new();
      rd_fld_covg = new();
    end
  endfunction

endclass


/////////////////////////////////////////////////////
//                cmn_pll0_varcal_reftim_start
/////////////////////////////////////////////////////
class T_cmn_pll0_varcal_reftim_start_1073 extends cdns_uvm_reg;

  `uvm_object_utils(T_cmn_pll0_varcal_reftim_start_1073)
  rand uvm_reg_field cmn_pll0_varcal_reftim_start_13_0;
  rand uvm_reg_field cmn_pll0_varcal_reftim_start_15_14;
  rand uvm_reg_field cmn_pll0_varcal_reftim_start_31_16;
  
  covergroup wr_fld_covg;
    cmn_pll0_varcal_reftim_start_13_0: coverpoint cmn_pll0_varcal_reftim_start_13_0.value[13:0];
    cmn_pll0_varcal_reftim_start_15_14: coverpoint cmn_pll0_varcal_reftim_start_15_14.value[1:0];
    cmn_pll0_varcal_reftim_start_31_16: coverpoint cmn_pll0_varcal_reftim_start_31_16.value[15:0];
  endgroup
  covergroup rd_fld_covg;
    cmn_pll0_varcal_reftim_start_13_0: coverpoint cmn_pll0_varcal_reftim_start_13_0.value[13:0];
    cmn_pll0_varcal_reftim_start_15_14: coverpoint cmn_pll0_varcal_reftim_start_15_14.value[1:0];
    cmn_pll0_varcal_reftim_start_31_16: coverpoint cmn_pll0_varcal_reftim_start_31_16.value[15:0];
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
    
    cmn_pll0_varcal_reftim_start_13_0 = fld_set[0];
    cmn_pll0_varcal_reftim_start_15_14 = fld_set[1];
    cmn_pll0_varcal_reftim_start_31_16 = fld_set[2];
  endfunction

  function new(input string name="T_cmn_pll0_varcal_reftim_start_1073");
    super.new(name, 32, build_coverage(UVM_CVR_FIELD_VALS));
    if (has_coverage(UVM_CVR_FIELD_VALS)) begin
      wr_fld_covg = new();
      rd_fld_covg = new();
    end
  endfunction

endclass


/////////////////////////////////////////////////////
//                cmn_pll0_varcal_start
/////////////////////////////////////////////////////
class T_cmn_pll0_varcal_start_1068 extends cdns_uvm_reg;

  `uvm_object_utils(T_cmn_pll0_varcal_start_1068)
  rand uvm_reg_field cmn_pll0_varcal_start_4_0;
  rand uvm_reg_field cmn_pll0_varcal_start_11_5;
  rand uvm_reg_field cmn_pll0_varcal_start_14_12;
  rand uvm_reg_field cmn_pll0_varcal_start_15;
  rand uvm_reg_field cmn_pll0_varcal_start_31_16;
  
  covergroup wr_fld_covg;
    cmn_pll0_varcal_start_4_0: coverpoint cmn_pll0_varcal_start_4_0.value[4:0];
    cmn_pll0_varcal_start_11_5: coverpoint cmn_pll0_varcal_start_11_5.value[6:0];
    cmn_pll0_varcal_start_14_12: coverpoint cmn_pll0_varcal_start_14_12.value[2:0];
    cmn_pll0_varcal_start_15: coverpoint cmn_pll0_varcal_start_15.value[0:0];
    cmn_pll0_varcal_start_31_16: coverpoint cmn_pll0_varcal_start_31_16.value[15:0];
  endgroup
  covergroup rd_fld_covg;
    cmn_pll0_varcal_start_4_0: coverpoint cmn_pll0_varcal_start_4_0.value[4:0];
    cmn_pll0_varcal_start_11_5: coverpoint cmn_pll0_varcal_start_11_5.value[6:0];
    cmn_pll0_varcal_start_14_12: coverpoint cmn_pll0_varcal_start_14_12.value[2:0];
    cmn_pll0_varcal_start_15: coverpoint cmn_pll0_varcal_start_15.value[0:0];
    cmn_pll0_varcal_start_31_16: coverpoint cmn_pll0_varcal_start_31_16.value[15:0];
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
    
    cmn_pll0_varcal_start_4_0 = fld_set[0];
    cmn_pll0_varcal_start_11_5 = fld_set[1];
    cmn_pll0_varcal_start_14_12 = fld_set[2];
    cmn_pll0_varcal_start_15 = fld_set[3];
    cmn_pll0_varcal_start_31_16 = fld_set[4];
  endfunction

  function new(input string name="T_cmn_pll0_varcal_start_1068");
    super.new(name, 32, build_coverage(UVM_CVR_FIELD_VALS));
    if (has_coverage(UVM_CVR_FIELD_VALS)) begin
      wr_fld_covg = new();
      rd_fld_covg = new();
    end
  endfunction

endclass


/////////////////////////////////////////////////////
//                cmn_pll0_varcal_tctrl
/////////////////////////////////////////////////////
class T_cmn_pll0_varcal_tctrl_1069 extends cdns_uvm_reg;

  `uvm_object_utils(T_cmn_pll0_varcal_tctrl_1069)
  rand uvm_reg_field cmn_pll0_varcal_tctrl_2_0;
  rand uvm_reg_field cmn_pll0_varcal_tctrl_15_3;
  rand uvm_reg_field cmn_pll0_varcal_tctrl_31_16;
  
  covergroup wr_fld_covg;
    cmn_pll0_varcal_tctrl_2_0: coverpoint cmn_pll0_varcal_tctrl_2_0.value[2:0];
    cmn_pll0_varcal_tctrl_15_3: coverpoint cmn_pll0_varcal_tctrl_15_3.value[12:0];
    cmn_pll0_varcal_tctrl_31_16: coverpoint cmn_pll0_varcal_tctrl_31_16.value[15:0];
  endgroup
  covergroup rd_fld_covg;
    cmn_pll0_varcal_tctrl_2_0: coverpoint cmn_pll0_varcal_tctrl_2_0.value[2:0];
    cmn_pll0_varcal_tctrl_15_3: coverpoint cmn_pll0_varcal_tctrl_15_3.value[12:0];
    cmn_pll0_varcal_tctrl_31_16: coverpoint cmn_pll0_varcal_tctrl_31_16.value[15:0];
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
    
    cmn_pll0_varcal_tctrl_2_0 = fld_set[0];
    cmn_pll0_varcal_tctrl_15_3 = fld_set[1];
    cmn_pll0_varcal_tctrl_31_16 = fld_set[2];
  endfunction

  function new(input string name="T_cmn_pll0_varcal_tctrl_1069");
    super.new(name, 32, build_coverage(UVM_CVR_FIELD_VALS));
    if (has_coverage(UVM_CVR_FIELD_VALS)) begin
      wr_fld_covg = new();
      rd_fld_covg = new();
    end
  endfunction

endclass


/////////////////////////////////////////////////////
//                cmn_pll0_vcocal_ctrl
/////////////////////////////////////////////////////
class T_cmn_pll0_vcocal_ctrl_1045 extends cdns_uvm_reg;

  `uvm_object_utils(T_cmn_pll0_vcocal_ctrl_1045)
  rand uvm_reg_field cmn_pll0_vcocal_ctrl_7_0;
  rand uvm_reg_field cmn_pll0_vcocal_ctrl_13_8;
  rand uvm_reg_field cmn_pll0_vcocal_ctrl_14;
  rand uvm_reg_field cmn_pll0_vcocal_ctrl_15;
  rand uvm_reg_field cmn_pll0_vcocal_ctrl_31_16;
  
  covergroup wr_fld_covg;
    cmn_pll0_vcocal_ctrl_7_0: coverpoint cmn_pll0_vcocal_ctrl_7_0.value[7:0];
    cmn_pll0_vcocal_ctrl_13_8: coverpoint cmn_pll0_vcocal_ctrl_13_8.value[5:0];
    cmn_pll0_vcocal_ctrl_14: coverpoint cmn_pll0_vcocal_ctrl_14.value[0:0];
    cmn_pll0_vcocal_ctrl_15: coverpoint cmn_pll0_vcocal_ctrl_15.value[0:0];
    cmn_pll0_vcocal_ctrl_31_16: coverpoint cmn_pll0_vcocal_ctrl_31_16.value[15:0];
  endgroup
  covergroup rd_fld_covg;
    cmn_pll0_vcocal_ctrl_7_0: coverpoint cmn_pll0_vcocal_ctrl_7_0.value[7:0];
    cmn_pll0_vcocal_ctrl_13_8: coverpoint cmn_pll0_vcocal_ctrl_13_8.value[5:0];
    cmn_pll0_vcocal_ctrl_14: coverpoint cmn_pll0_vcocal_ctrl_14.value[0:0];
    cmn_pll0_vcocal_ctrl_15: coverpoint cmn_pll0_vcocal_ctrl_15.value[0:0];
    cmn_pll0_vcocal_ctrl_31_16: coverpoint cmn_pll0_vcocal_ctrl_31_16.value[15:0];
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
    
    cmn_pll0_vcocal_ctrl_7_0 = fld_set[0];
    cmn_pll0_vcocal_ctrl_13_8 = fld_set[1];
    cmn_pll0_vcocal_ctrl_14 = fld_set[2];
    cmn_pll0_vcocal_ctrl_15 = fld_set[3];
    cmn_pll0_vcocal_ctrl_31_16 = fld_set[4];
  endfunction

  function new(input string name="T_cmn_pll0_vcocal_ctrl_1045");
    super.new(name, 32, build_coverage(UVM_CVR_FIELD_VALS));
    if (has_coverage(UVM_CVR_FIELD_VALS)) begin
      wr_fld_covg = new();
      rd_fld_covg = new();
    end
  endfunction

endclass


/////////////////////////////////////////////////////
//                cmn_pll0_vcocal_init_tmr
/////////////////////////////////////////////////////
class T_cmn_pll0_vcocal_init_tmr_1049 extends cdns_uvm_reg;

  `uvm_object_utils(T_cmn_pll0_vcocal_init_tmr_1049)
  rand uvm_reg_field cmn_pll0_vcocal_init_tmr_13_0;
  rand uvm_reg_field cmn_pll0_vcocal_init_tmr_15_14;
  rand uvm_reg_field cmn_pll0_vcocal_init_tmr_31_16;
  
  covergroup wr_fld_covg;
    cmn_pll0_vcocal_init_tmr_13_0: coverpoint cmn_pll0_vcocal_init_tmr_13_0.value[13:0];
    cmn_pll0_vcocal_init_tmr_15_14: coverpoint cmn_pll0_vcocal_init_tmr_15_14.value[1:0];
    cmn_pll0_vcocal_init_tmr_31_16: coverpoint cmn_pll0_vcocal_init_tmr_31_16.value[15:0];
  endgroup
  covergroup rd_fld_covg;
    cmn_pll0_vcocal_init_tmr_13_0: coverpoint cmn_pll0_vcocal_init_tmr_13_0.value[13:0];
    cmn_pll0_vcocal_init_tmr_15_14: coverpoint cmn_pll0_vcocal_init_tmr_15_14.value[1:0];
    cmn_pll0_vcocal_init_tmr_31_16: coverpoint cmn_pll0_vcocal_init_tmr_31_16.value[15:0];
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
    
    cmn_pll0_vcocal_init_tmr_13_0 = fld_set[0];
    cmn_pll0_vcocal_init_tmr_15_14 = fld_set[1];
    cmn_pll0_vcocal_init_tmr_31_16 = fld_set[2];
  endfunction

  function new(input string name="T_cmn_pll0_vcocal_init_tmr_1049");
    super.new(name, 32, build_coverage(UVM_CVR_FIELD_VALS));
    if (has_coverage(UVM_CVR_FIELD_VALS)) begin
      wr_fld_covg = new();
      rd_fld_covg = new();
    end
  endfunction

endclass


/////////////////////////////////////////////////////
//                cmn_pll0_vcocal_iter_tmr
/////////////////////////////////////////////////////
class T_cmn_pll0_vcocal_iter_tmr_1050 extends cdns_uvm_reg;

  `uvm_object_utils(T_cmn_pll0_vcocal_iter_tmr_1050)
  rand uvm_reg_field cmn_pll0_vcocal_iter_tmr_13_0;
  rand uvm_reg_field cmn_pll0_vcocal_iter_tmr_15_14;
  rand uvm_reg_field cmn_pll0_vcocal_iter_tmr_31_16;
  
  covergroup wr_fld_covg;
    cmn_pll0_vcocal_iter_tmr_13_0: coverpoint cmn_pll0_vcocal_iter_tmr_13_0.value[13:0];
    cmn_pll0_vcocal_iter_tmr_15_14: coverpoint cmn_pll0_vcocal_iter_tmr_15_14.value[1:0];
    cmn_pll0_vcocal_iter_tmr_31_16: coverpoint cmn_pll0_vcocal_iter_tmr_31_16.value[15:0];
  endgroup
  covergroup rd_fld_covg;
    cmn_pll0_vcocal_iter_tmr_13_0: coverpoint cmn_pll0_vcocal_iter_tmr_13_0.value[13:0];
    cmn_pll0_vcocal_iter_tmr_15_14: coverpoint cmn_pll0_vcocal_iter_tmr_15_14.value[1:0];
    cmn_pll0_vcocal_iter_tmr_31_16: coverpoint cmn_pll0_vcocal_iter_tmr_31_16.value[15:0];
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
    
    cmn_pll0_vcocal_iter_tmr_13_0 = fld_set[0];
    cmn_pll0_vcocal_iter_tmr_15_14 = fld_set[1];
    cmn_pll0_vcocal_iter_tmr_31_16 = fld_set[2];
  endfunction

  function new(input string name="T_cmn_pll0_vcocal_iter_tmr_1050");
    super.new(name, 32, build_coverage(UVM_CVR_FIELD_VALS));
    if (has_coverage(UVM_CVR_FIELD_VALS)) begin
      wr_fld_covg = new();
      rd_fld_covg = new();
    end
  endfunction

endclass


/////////////////////////////////////////////////////
//                cmn_pll0_vcocal_ovrd
/////////////////////////////////////////////////////
class T_cmn_pll0_vcocal_ovrd_1048 extends cdns_uvm_reg;

  `uvm_object_utils(T_cmn_pll0_vcocal_ovrd_1048)
  rand uvm_reg_field cmn_pll0_vcocal_ovrd_7_0;
  rand uvm_reg_field cmn_pll0_vcocal_ovrd_14_8;
  rand uvm_reg_field cmn_pll0_vcocal_ovrd_15;
  rand uvm_reg_field cmn_pll0_vcocal_ovrd_31_16;
  
  covergroup wr_fld_covg;
    cmn_pll0_vcocal_ovrd_7_0: coverpoint cmn_pll0_vcocal_ovrd_7_0.value[7:0];
    cmn_pll0_vcocal_ovrd_14_8: coverpoint cmn_pll0_vcocal_ovrd_14_8.value[6:0];
    cmn_pll0_vcocal_ovrd_15: coverpoint cmn_pll0_vcocal_ovrd_15.value[0:0];
    cmn_pll0_vcocal_ovrd_31_16: coverpoint cmn_pll0_vcocal_ovrd_31_16.value[15:0];
  endgroup
  covergroup rd_fld_covg;
    cmn_pll0_vcocal_ovrd_7_0: coverpoint cmn_pll0_vcocal_ovrd_7_0.value[7:0];
    cmn_pll0_vcocal_ovrd_14_8: coverpoint cmn_pll0_vcocal_ovrd_14_8.value[6:0];
    cmn_pll0_vcocal_ovrd_15: coverpoint cmn_pll0_vcocal_ovrd_15.value[0:0];
    cmn_pll0_vcocal_ovrd_31_16: coverpoint cmn_pll0_vcocal_ovrd_31_16.value[15:0];
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
    
    cmn_pll0_vcocal_ovrd_7_0 = fld_set[0];
    cmn_pll0_vcocal_ovrd_14_8 = fld_set[1];
    cmn_pll0_vcocal_ovrd_15 = fld_set[2];
    cmn_pll0_vcocal_ovrd_31_16 = fld_set[3];
  endfunction

  function new(input string name="T_cmn_pll0_vcocal_ovrd_1048");
    super.new(name, 32, build_coverage(UVM_CVR_FIELD_VALS));
    if (has_coverage(UVM_CVR_FIELD_VALS)) begin
      wr_fld_covg = new();
      rd_fld_covg = new();
    end
  endfunction

endclass


/////////////////////////////////////////////////////
//                cmn_pll0_vcocal_pllcnt_start
/////////////////////////////////////////////////////
class T_cmn_pll0_vcocal_pllcnt_start_1052 extends cdns_uvm_reg;

  `uvm_object_utils(T_cmn_pll0_vcocal_pllcnt_start_1052)
  rand uvm_reg_field cmn_pll0_vcocal_pllcnt_start_15_0;
  rand uvm_reg_field cmn_pll0_vcocal_pllcnt_start_31_16;
  
  covergroup wr_fld_covg;
    cmn_pll0_vcocal_pllcnt_start_15_0: coverpoint cmn_pll0_vcocal_pllcnt_start_15_0.value[15:0];
    cmn_pll0_vcocal_pllcnt_start_31_16: coverpoint cmn_pll0_vcocal_pllcnt_start_31_16.value[15:0];
  endgroup
  covergroup rd_fld_covg;
    cmn_pll0_vcocal_pllcnt_start_15_0: coverpoint cmn_pll0_vcocal_pllcnt_start_15_0.value[15:0];
    cmn_pll0_vcocal_pllcnt_start_31_16: coverpoint cmn_pll0_vcocal_pllcnt_start_31_16.value[15:0];
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
    
    cmn_pll0_vcocal_pllcnt_start_15_0 = fld_set[0];
    cmn_pll0_vcocal_pllcnt_start_31_16 = fld_set[1];
  endfunction

  function new(input string name="T_cmn_pll0_vcocal_pllcnt_start_1052");
    super.new(name, 32, build_coverage(UVM_CVR_FIELD_VALS));
    if (has_coverage(UVM_CVR_FIELD_VALS)) begin
      wr_fld_covg = new();
      rd_fld_covg = new();
    end
  endfunction

endclass


/////////////////////////////////////////////////////
//                cmn_pll0_vcocal_reftim_start
/////////////////////////////////////////////////////
class T_cmn_pll0_vcocal_reftim_start_1051 extends cdns_uvm_reg;

  `uvm_object_utils(T_cmn_pll0_vcocal_reftim_start_1051)
  rand uvm_reg_field cmn_pll0_vcocal_reftim_start_13_0;
  rand uvm_reg_field cmn_pll0_vcocal_reftim_start_15_14;
  rand uvm_reg_field cmn_pll0_vcocal_reftim_start_31_16;
  
  covergroup wr_fld_covg;
    cmn_pll0_vcocal_reftim_start_13_0: coverpoint cmn_pll0_vcocal_reftim_start_13_0.value[13:0];
    cmn_pll0_vcocal_reftim_start_15_14: coverpoint cmn_pll0_vcocal_reftim_start_15_14.value[1:0];
    cmn_pll0_vcocal_reftim_start_31_16: coverpoint cmn_pll0_vcocal_reftim_start_31_16.value[15:0];
  endgroup
  covergroup rd_fld_covg;
    cmn_pll0_vcocal_reftim_start_13_0: coverpoint cmn_pll0_vcocal_reftim_start_13_0.value[13:0];
    cmn_pll0_vcocal_reftim_start_15_14: coverpoint cmn_pll0_vcocal_reftim_start_15_14.value[1:0];
    cmn_pll0_vcocal_reftim_start_31_16: coverpoint cmn_pll0_vcocal_reftim_start_31_16.value[15:0];
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
    
    cmn_pll0_vcocal_reftim_start_13_0 = fld_set[0];
    cmn_pll0_vcocal_reftim_start_15_14 = fld_set[1];
    cmn_pll0_vcocal_reftim_start_31_16 = fld_set[2];
  endfunction

  function new(input string name="T_cmn_pll0_vcocal_reftim_start_1051");
    super.new(name, 32, build_coverage(UVM_CVR_FIELD_VALS));
    if (has_coverage(UVM_CVR_FIELD_VALS)) begin
      wr_fld_covg = new();
      rd_fld_covg = new();
    end
  endfunction

endclass


/////////////////////////////////////////////////////
//                cmn_pll0_vcocal_start
/////////////////////////////////////////////////////
class T_cmn_pll0_vcocal_start_1046 extends cdns_uvm_reg;

  `uvm_object_utils(T_cmn_pll0_vcocal_start_1046)
  rand uvm_reg_field cmn_pll0_vcocal_start_7_0;
  rand uvm_reg_field cmn_pll0_vcocal_start_11_8;
  rand uvm_reg_field cmn_pll0_vcocal_start_14_12;
  rand uvm_reg_field cmn_pll0_vcocal_start_15;
  rand uvm_reg_field cmn_pll0_vcocal_start_31_16;
  
  covergroup wr_fld_covg;
    cmn_pll0_vcocal_start_7_0: coverpoint cmn_pll0_vcocal_start_7_0.value[7:0];
    cmn_pll0_vcocal_start_11_8: coverpoint cmn_pll0_vcocal_start_11_8.value[3:0];
    cmn_pll0_vcocal_start_14_12: coverpoint cmn_pll0_vcocal_start_14_12.value[2:0];
    cmn_pll0_vcocal_start_15: coverpoint cmn_pll0_vcocal_start_15.value[0:0];
    cmn_pll0_vcocal_start_31_16: coverpoint cmn_pll0_vcocal_start_31_16.value[15:0];
  endgroup
  covergroup rd_fld_covg;
    cmn_pll0_vcocal_start_7_0: coverpoint cmn_pll0_vcocal_start_7_0.value[7:0];
    cmn_pll0_vcocal_start_11_8: coverpoint cmn_pll0_vcocal_start_11_8.value[3:0];
    cmn_pll0_vcocal_start_14_12: coverpoint cmn_pll0_vcocal_start_14_12.value[2:0];
    cmn_pll0_vcocal_start_15: coverpoint cmn_pll0_vcocal_start_15.value[0:0];
    cmn_pll0_vcocal_start_31_16: coverpoint cmn_pll0_vcocal_start_31_16.value[15:0];
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
    
    cmn_pll0_vcocal_start_7_0 = fld_set[0];
    cmn_pll0_vcocal_start_11_8 = fld_set[1];
    cmn_pll0_vcocal_start_14_12 = fld_set[2];
    cmn_pll0_vcocal_start_15 = fld_set[3];
    cmn_pll0_vcocal_start_31_16 = fld_set[4];
  endfunction

  function new(input string name="T_cmn_pll0_vcocal_start_1046");
    super.new(name, 32, build_coverage(UVM_CVR_FIELD_VALS));
    if (has_coverage(UVM_CVR_FIELD_VALS)) begin
      wr_fld_covg = new();
      rd_fld_covg = new();
    end
  endfunction

endclass


/////////////////////////////////////////////////////
//                cmn_pll0_vcocal_tctrl
/////////////////////////////////////////////////////
class T_cmn_pll0_vcocal_tctrl_1047 extends cdns_uvm_reg;

  `uvm_object_utils(T_cmn_pll0_vcocal_tctrl_1047)
  rand uvm_reg_field cmn_pll0_vcocal_tctrl_2_0;
  rand uvm_reg_field cmn_pll0_vcocal_tctrl_15_3;
  rand uvm_reg_field cmn_pll0_vcocal_tctrl_31_16;
  
  covergroup wr_fld_covg;
    cmn_pll0_vcocal_tctrl_2_0: coverpoint cmn_pll0_vcocal_tctrl_2_0.value[2:0];
    cmn_pll0_vcocal_tctrl_15_3: coverpoint cmn_pll0_vcocal_tctrl_15_3.value[12:0];
    cmn_pll0_vcocal_tctrl_31_16: coverpoint cmn_pll0_vcocal_tctrl_31_16.value[15:0];
  endgroup
  covergroup rd_fld_covg;
    cmn_pll0_vcocal_tctrl_2_0: coverpoint cmn_pll0_vcocal_tctrl_2_0.value[2:0];
    cmn_pll0_vcocal_tctrl_15_3: coverpoint cmn_pll0_vcocal_tctrl_15_3.value[12:0];
    cmn_pll0_vcocal_tctrl_31_16: coverpoint cmn_pll0_vcocal_tctrl_31_16.value[15:0];
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
    
    cmn_pll0_vcocal_tctrl_2_0 = fld_set[0];
    cmn_pll0_vcocal_tctrl_15_3 = fld_set[1];
    cmn_pll0_vcocal_tctrl_31_16 = fld_set[2];
  endfunction

  function new(input string name="T_cmn_pll0_vcocal_tctrl_1047");
    super.new(name, 32, build_coverage(UVM_CVR_FIELD_VALS));
    if (has_coverage(UVM_CVR_FIELD_VALS)) begin
      wr_fld_covg = new();
      rd_fld_covg = new();
    end
  endfunction

endclass


/////////////////////////////////////////////////////
//                cmn_pll1_dsm_diag
/////////////////////////////////////////////////////
class T_cmn_pll1_dsm_diag_1090 extends cdns_uvm_reg;

  `uvm_object_utils(T_cmn_pll1_dsm_diag_1090)
  rand uvm_reg_field cmn_pll1_dsm_diag_3_0;
  rand uvm_reg_field cmn_pll1_dsm_diag_13_4;
  rand uvm_reg_field cmn_pll1_dsm_diag_14;
  rand uvm_reg_field cmn_pll1_dsm_diag_15;
  rand uvm_reg_field cmn_pll1_dsm_diag_31_16;
  
  covergroup wr_fld_covg;
    cmn_pll1_dsm_diag_3_0: coverpoint cmn_pll1_dsm_diag_3_0.value[3:0];
    cmn_pll1_dsm_diag_13_4: coverpoint cmn_pll1_dsm_diag_13_4.value[9:0];
    cmn_pll1_dsm_diag_14: coverpoint cmn_pll1_dsm_diag_14.value[0:0];
    cmn_pll1_dsm_diag_15: coverpoint cmn_pll1_dsm_diag_15.value[0:0];
    cmn_pll1_dsm_diag_31_16: coverpoint cmn_pll1_dsm_diag_31_16.value[15:0];
  endgroup
  covergroup rd_fld_covg;
    cmn_pll1_dsm_diag_3_0: coverpoint cmn_pll1_dsm_diag_3_0.value[3:0];
    cmn_pll1_dsm_diag_13_4: coverpoint cmn_pll1_dsm_diag_13_4.value[9:0];
    cmn_pll1_dsm_diag_14: coverpoint cmn_pll1_dsm_diag_14.value[0:0];
    cmn_pll1_dsm_diag_15: coverpoint cmn_pll1_dsm_diag_15.value[0:0];
    cmn_pll1_dsm_diag_31_16: coverpoint cmn_pll1_dsm_diag_31_16.value[15:0];
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
    
    cmn_pll1_dsm_diag_3_0 = fld_set[0];
    cmn_pll1_dsm_diag_13_4 = fld_set[1];
    cmn_pll1_dsm_diag_14 = fld_set[2];
    cmn_pll1_dsm_diag_15 = fld_set[3];
    cmn_pll1_dsm_diag_31_16 = fld_set[4];
  endfunction

  function new(input string name="T_cmn_pll1_dsm_diag_1090");
    super.new(name, 32, build_coverage(UVM_CVR_FIELD_VALS));
    if (has_coverage(UVM_CVR_FIELD_VALS)) begin
      wr_fld_covg = new();
      rd_fld_covg = new();
    end
  endfunction

endclass


/////////////////////////////////////////////////////
//                cmn_pll1_dsm_fbh_ovrd
/////////////////////////////////////////////////////
class T_cmn_pll1_dsm_fbh_ovrd_1091 extends cdns_uvm_reg;

  `uvm_object_utils(T_cmn_pll1_dsm_fbh_ovrd_1091)
  rand uvm_reg_field cmn_pll1_dsm_fbh_ovrd_9_0;
  rand uvm_reg_field cmn_pll1_dsm_fbh_ovrd_15_10;
  rand uvm_reg_field cmn_pll1_dsm_fbh_ovrd_31_16;
  
  covergroup wr_fld_covg;
    cmn_pll1_dsm_fbh_ovrd_9_0: coverpoint cmn_pll1_dsm_fbh_ovrd_9_0.value[9:0];
    cmn_pll1_dsm_fbh_ovrd_15_10: coverpoint cmn_pll1_dsm_fbh_ovrd_15_10.value[5:0];
    cmn_pll1_dsm_fbh_ovrd_31_16: coverpoint cmn_pll1_dsm_fbh_ovrd_31_16.value[15:0];
  endgroup
  covergroup rd_fld_covg;
    cmn_pll1_dsm_fbh_ovrd_9_0: coverpoint cmn_pll1_dsm_fbh_ovrd_9_0.value[9:0];
    cmn_pll1_dsm_fbh_ovrd_15_10: coverpoint cmn_pll1_dsm_fbh_ovrd_15_10.value[5:0];
    cmn_pll1_dsm_fbh_ovrd_31_16: coverpoint cmn_pll1_dsm_fbh_ovrd_31_16.value[15:0];
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
    
    cmn_pll1_dsm_fbh_ovrd_9_0 = fld_set[0];
    cmn_pll1_dsm_fbh_ovrd_15_10 = fld_set[1];
    cmn_pll1_dsm_fbh_ovrd_31_16 = fld_set[2];
  endfunction

  function new(input string name="T_cmn_pll1_dsm_fbh_ovrd_1091");
    super.new(name, 32, build_coverage(UVM_CVR_FIELD_VALS));
    if (has_coverage(UVM_CVR_FIELD_VALS)) begin
      wr_fld_covg = new();
      rd_fld_covg = new();
    end
  endfunction

endclass


/////////////////////////////////////////////////////
//                cmn_pll1_dsm_fbl_ovrd
/////////////////////////////////////////////////////
class T_cmn_pll1_dsm_fbl_ovrd_1092 extends cdns_uvm_reg;

  `uvm_object_utils(T_cmn_pll1_dsm_fbl_ovrd_1092)
  rand uvm_reg_field cmn_pll1_dsm_fbl_ovrd_9_0;
  rand uvm_reg_field cmn_pll1_dsm_fbl_ovrd_15_10;
  rand uvm_reg_field cmn_pll1_dsm_fbl_ovrd_31_16;
  
  covergroup wr_fld_covg;
    cmn_pll1_dsm_fbl_ovrd_9_0: coverpoint cmn_pll1_dsm_fbl_ovrd_9_0.value[9:0];
    cmn_pll1_dsm_fbl_ovrd_15_10: coverpoint cmn_pll1_dsm_fbl_ovrd_15_10.value[5:0];
    cmn_pll1_dsm_fbl_ovrd_31_16: coverpoint cmn_pll1_dsm_fbl_ovrd_31_16.value[15:0];
  endgroup
  covergroup rd_fld_covg;
    cmn_pll1_dsm_fbl_ovrd_9_0: coverpoint cmn_pll1_dsm_fbl_ovrd_9_0.value[9:0];
    cmn_pll1_dsm_fbl_ovrd_15_10: coverpoint cmn_pll1_dsm_fbl_ovrd_15_10.value[5:0];
    cmn_pll1_dsm_fbl_ovrd_31_16: coverpoint cmn_pll1_dsm_fbl_ovrd_31_16.value[15:0];
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
    
    cmn_pll1_dsm_fbl_ovrd_9_0 = fld_set[0];
    cmn_pll1_dsm_fbl_ovrd_15_10 = fld_set[1];
    cmn_pll1_dsm_fbl_ovrd_31_16 = fld_set[2];
  endfunction

  function new(input string name="T_cmn_pll1_dsm_fbl_ovrd_1092");
    super.new(name, 32, build_coverage(UVM_CVR_FIELD_VALS));
    if (has_coverage(UVM_CVR_FIELD_VALS)) begin
      wr_fld_covg = new();
      rd_fld_covg = new();
    end
  endfunction

endclass


/////////////////////////////////////////////////////
//                cmn_pll1_fracdivh
/////////////////////////////////////////////////////
class T_cmn_pll1_fracdivh_1088 extends cdns_uvm_reg;

  `uvm_object_utils(T_cmn_pll1_fracdivh_1088)
  rand uvm_reg_field cmn_pll1_fracdivh_2_0;
  rand uvm_reg_field cmn_pll1_fracdivh_15_3;
  rand uvm_reg_field cmn_pll1_fracdivh_31_16;
  
  covergroup wr_fld_covg;
    cmn_pll1_fracdivh_2_0: coverpoint cmn_pll1_fracdivh_2_0.value[2:0];
    cmn_pll1_fracdivh_15_3: coverpoint cmn_pll1_fracdivh_15_3.value[12:0];
    cmn_pll1_fracdivh_31_16: coverpoint cmn_pll1_fracdivh_31_16.value[15:0];
  endgroup
  covergroup rd_fld_covg;
    cmn_pll1_fracdivh_2_0: coverpoint cmn_pll1_fracdivh_2_0.value[2:0];
    cmn_pll1_fracdivh_15_3: coverpoint cmn_pll1_fracdivh_15_3.value[12:0];
    cmn_pll1_fracdivh_31_16: coverpoint cmn_pll1_fracdivh_31_16.value[15:0];
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
    
    cmn_pll1_fracdivh_2_0 = fld_set[0];
    cmn_pll1_fracdivh_15_3 = fld_set[1];
    cmn_pll1_fracdivh_31_16 = fld_set[2];
  endfunction

  function new(input string name="T_cmn_pll1_fracdivh_1088");
    super.new(name, 32, build_coverage(UVM_CVR_FIELD_VALS));
    if (has_coverage(UVM_CVR_FIELD_VALS)) begin
      wr_fld_covg = new();
      rd_fld_covg = new();
    end
  endfunction

endclass


/////////////////////////////////////////////////////
//                cmn_pll1_fracdivl
/////////////////////////////////////////////////////
class T_cmn_pll1_fracdivl_1087 extends cdns_uvm_reg;

  `uvm_object_utils(T_cmn_pll1_fracdivl_1087)
  rand uvm_reg_field cmn_pll1_fracdivl_15_0;
  rand uvm_reg_field cmn_pll1_fracdivl_31_16;
  
  covergroup wr_fld_covg;
    cmn_pll1_fracdivl_15_0: coverpoint cmn_pll1_fracdivl_15_0.value[15:0];
    cmn_pll1_fracdivl_31_16: coverpoint cmn_pll1_fracdivl_31_16.value[15:0];
  endgroup
  covergroup rd_fld_covg;
    cmn_pll1_fracdivl_15_0: coverpoint cmn_pll1_fracdivl_15_0.value[15:0];
    cmn_pll1_fracdivl_31_16: coverpoint cmn_pll1_fracdivl_31_16.value[15:0];
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
    
    cmn_pll1_fracdivl_15_0 = fld_set[0];
    cmn_pll1_fracdivl_31_16 = fld_set[1];
  endfunction

  function new(input string name="T_cmn_pll1_fracdivl_1087");
    super.new(name, 32, build_coverage(UVM_CVR_FIELD_VALS));
    if (has_coverage(UVM_CVR_FIELD_VALS)) begin
      wr_fld_covg = new();
      rd_fld_covg = new();
    end
  endfunction

endclass


/////////////////////////////////////////////////////
//                cmn_pll1_high_thr
/////////////////////////////////////////////////////
class T_cmn_pll1_high_thr_1089 extends cdns_uvm_reg;

  `uvm_object_utils(T_cmn_pll1_high_thr_1089)
  rand uvm_reg_field cmn_pll1_high_thr_9_0;
  rand uvm_reg_field cmn_pll1_high_thr_15_10;
  rand uvm_reg_field cmn_pll1_high_thr_31_16;
  
  covergroup wr_fld_covg;
    cmn_pll1_high_thr_9_0: coverpoint cmn_pll1_high_thr_9_0.value[9:0];
    cmn_pll1_high_thr_15_10: coverpoint cmn_pll1_high_thr_15_10.value[5:0];
    cmn_pll1_high_thr_31_16: coverpoint cmn_pll1_high_thr_31_16.value[15:0];
  endgroup
  covergroup rd_fld_covg;
    cmn_pll1_high_thr_9_0: coverpoint cmn_pll1_high_thr_9_0.value[9:0];
    cmn_pll1_high_thr_15_10: coverpoint cmn_pll1_high_thr_15_10.value[5:0];
    cmn_pll1_high_thr_31_16: coverpoint cmn_pll1_high_thr_31_16.value[15:0];
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
    
    cmn_pll1_high_thr_9_0 = fld_set[0];
    cmn_pll1_high_thr_15_10 = fld_set[1];
    cmn_pll1_high_thr_31_16 = fld_set[2];
  endfunction

  function new(input string name="T_cmn_pll1_high_thr_1089");
    super.new(name, 32, build_coverage(UVM_CVR_FIELD_VALS));
    if (has_coverage(UVM_CVR_FIELD_VALS)) begin
      wr_fld_covg = new();
      rd_fld_covg = new();
    end
  endfunction

endclass


/////////////////////////////////////////////////////
//                cmn_pll1_intdiv
/////////////////////////////////////////////////////
class T_cmn_pll1_intdiv_1086 extends cdns_uvm_reg;

  `uvm_object_utils(T_cmn_pll1_intdiv_1086)
  rand uvm_reg_field cmn_pll1_intdiv_9_0;
  rand uvm_reg_field cmn_pll1_intdiv_15_10;
  rand uvm_reg_field cmn_pll1_intdiv_31_16;
  
  covergroup wr_fld_covg;
    cmn_pll1_intdiv_9_0: coverpoint cmn_pll1_intdiv_9_0.value[9:0];
    cmn_pll1_intdiv_15_10: coverpoint cmn_pll1_intdiv_15_10.value[5:0];
    cmn_pll1_intdiv_31_16: coverpoint cmn_pll1_intdiv_31_16.value[15:0];
  endgroup
  covergroup rd_fld_covg;
    cmn_pll1_intdiv_9_0: coverpoint cmn_pll1_intdiv_9_0.value[9:0];
    cmn_pll1_intdiv_15_10: coverpoint cmn_pll1_intdiv_15_10.value[5:0];
    cmn_pll1_intdiv_31_16: coverpoint cmn_pll1_intdiv_31_16.value[15:0];
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
    
    cmn_pll1_intdiv_9_0 = fld_set[0];
    cmn_pll1_intdiv_15_10 = fld_set[1];
    cmn_pll1_intdiv_31_16 = fld_set[2];
  endfunction

  function new(input string name="T_cmn_pll1_intdiv_1086");
    super.new(name, 32, build_coverage(UVM_CVR_FIELD_VALS));
    if (has_coverage(UVM_CVR_FIELD_VALS)) begin
      wr_fld_covg = new();
      rd_fld_covg = new();
    end
  endfunction

endclass


/////////////////////////////////////////////////////
//                cmn_pll1_ss_ctrl1
/////////////////////////////////////////////////////
class T_cmn_pll1_ss_ctrl1_1093 extends cdns_uvm_reg;

  `uvm_object_utils(T_cmn_pll1_ss_ctrl1_1093)
  rand uvm_reg_field cmn_pll1_ss_ctrl1_0;
  rand uvm_reg_field cmn_pll1_ss_ctrl1_1;
  rand uvm_reg_field cmn_pll1_ss_ctrl1_7_2;
  rand uvm_reg_field cmn_pll1_ss_ctrl1_14_8;
  rand uvm_reg_field cmn_pll1_ss_ctrl1_15;
  rand uvm_reg_field cmn_pll1_ss_ctrl1_30_16;
  rand uvm_reg_field cmn_pll1_ss_ctrl1_31;
  
  covergroup wr_fld_covg;
    cmn_pll1_ss_ctrl1_0: coverpoint cmn_pll1_ss_ctrl1_0.value[0:0];
    cmn_pll1_ss_ctrl1_1: coverpoint cmn_pll1_ss_ctrl1_1.value[0:0];
    cmn_pll1_ss_ctrl1_7_2: coverpoint cmn_pll1_ss_ctrl1_7_2.value[5:0];
    cmn_pll1_ss_ctrl1_14_8: coverpoint cmn_pll1_ss_ctrl1_14_8.value[6:0];
    cmn_pll1_ss_ctrl1_15: coverpoint cmn_pll1_ss_ctrl1_15.value[0:0];
    cmn_pll1_ss_ctrl1_30_16: coverpoint cmn_pll1_ss_ctrl1_30_16.value[14:0];
    cmn_pll1_ss_ctrl1_31: coverpoint cmn_pll1_ss_ctrl1_31.value[0:0];
  endgroup
  covergroup rd_fld_covg;
    cmn_pll1_ss_ctrl1_0: coverpoint cmn_pll1_ss_ctrl1_0.value[0:0];
    cmn_pll1_ss_ctrl1_1: coverpoint cmn_pll1_ss_ctrl1_1.value[0:0];
    cmn_pll1_ss_ctrl1_7_2: coverpoint cmn_pll1_ss_ctrl1_7_2.value[5:0];
    cmn_pll1_ss_ctrl1_14_8: coverpoint cmn_pll1_ss_ctrl1_14_8.value[6:0];
    cmn_pll1_ss_ctrl1_15: coverpoint cmn_pll1_ss_ctrl1_15.value[0:0];
    cmn_pll1_ss_ctrl1_30_16: coverpoint cmn_pll1_ss_ctrl1_30_16.value[14:0];
    cmn_pll1_ss_ctrl1_31: coverpoint cmn_pll1_ss_ctrl1_31.value[0:0];
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
    
    cmn_pll1_ss_ctrl1_0 = fld_set[0];
    cmn_pll1_ss_ctrl1_1 = fld_set[1];
    cmn_pll1_ss_ctrl1_7_2 = fld_set[2];
    cmn_pll1_ss_ctrl1_14_8 = fld_set[3];
    cmn_pll1_ss_ctrl1_15 = fld_set[4];
    cmn_pll1_ss_ctrl1_30_16 = fld_set[5];
    cmn_pll1_ss_ctrl1_31 = fld_set[6];
  endfunction

  function new(input string name="T_cmn_pll1_ss_ctrl1_1093");
    super.new(name, 32, build_coverage(UVM_CVR_FIELD_VALS));
    if (has_coverage(UVM_CVR_FIELD_VALS)) begin
      wr_fld_covg = new();
      rd_fld_covg = new();
    end
  endfunction

endclass


/////////////////////////////////////////////////////
//                cmn_pll1_ss_ctrl2
/////////////////////////////////////////////////////
class T_cmn_pll1_ss_ctrl2_1094 extends cdns_uvm_reg;

  `uvm_object_utils(T_cmn_pll1_ss_ctrl2_1094)
  rand uvm_reg_field cmn_pll1_ss_ctrl2_6_0;
  rand uvm_reg_field cmn_pll1_ss_ctrl2_7;
  rand uvm_reg_field cmn_pll1_ss_ctrl2_14_8;
  rand uvm_reg_field cmn_pll1_ss_ctrl2_15;
  rand uvm_reg_field cmn_pll1_ss_ctrl2_31_16;
  
  covergroup wr_fld_covg;
    cmn_pll1_ss_ctrl2_6_0: coverpoint cmn_pll1_ss_ctrl2_6_0.value[6:0];
    cmn_pll1_ss_ctrl2_7: coverpoint cmn_pll1_ss_ctrl2_7.value[0:0];
    cmn_pll1_ss_ctrl2_14_8: coverpoint cmn_pll1_ss_ctrl2_14_8.value[6:0];
    cmn_pll1_ss_ctrl2_15: coverpoint cmn_pll1_ss_ctrl2_15.value[0:0];
    cmn_pll1_ss_ctrl2_31_16: coverpoint cmn_pll1_ss_ctrl2_31_16.value[15:0];
  endgroup
  covergroup rd_fld_covg;
    cmn_pll1_ss_ctrl2_6_0: coverpoint cmn_pll1_ss_ctrl2_6_0.value[6:0];
    cmn_pll1_ss_ctrl2_7: coverpoint cmn_pll1_ss_ctrl2_7.value[0:0];
    cmn_pll1_ss_ctrl2_14_8: coverpoint cmn_pll1_ss_ctrl2_14_8.value[6:0];
    cmn_pll1_ss_ctrl2_15: coverpoint cmn_pll1_ss_ctrl2_15.value[0:0];
    cmn_pll1_ss_ctrl2_31_16: coverpoint cmn_pll1_ss_ctrl2_31_16.value[15:0];
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
    
    cmn_pll1_ss_ctrl2_6_0 = fld_set[0];
    cmn_pll1_ss_ctrl2_7 = fld_set[1];
    cmn_pll1_ss_ctrl2_14_8 = fld_set[2];
    cmn_pll1_ss_ctrl2_15 = fld_set[3];
    cmn_pll1_ss_ctrl2_31_16 = fld_set[4];
  endfunction

  function new(input string name="T_cmn_pll1_ss_ctrl2_1094");
    super.new(name, 32, build_coverage(UVM_CVR_FIELD_VALS));
    if (has_coverage(UVM_CVR_FIELD_VALS)) begin
      wr_fld_covg = new();
      rd_fld_covg = new();
    end
  endfunction

endclass


/////////////////////////////////////////////////////
//                cmn_pll1_ss_ctrl3
/////////////////////////////////////////////////////
class T_cmn_pll1_ss_ctrl3_1095 extends cdns_uvm_reg;

  `uvm_object_utils(T_cmn_pll1_ss_ctrl3_1095)
  rand uvm_reg_field cmn_pll1_ss_ctrl3_18_0;
  rand uvm_reg_field cmn_pll1_ss_ctrl3_31_19;
  
  covergroup wr_fld_covg;
    cmn_pll1_ss_ctrl3_18_0: coverpoint cmn_pll1_ss_ctrl3_18_0.value[18:0];
    cmn_pll1_ss_ctrl3_31_19: coverpoint cmn_pll1_ss_ctrl3_31_19.value[12:0];
  endgroup
  covergroup rd_fld_covg;
    cmn_pll1_ss_ctrl3_18_0: coverpoint cmn_pll1_ss_ctrl3_18_0.value[18:0];
    cmn_pll1_ss_ctrl3_31_19: coverpoint cmn_pll1_ss_ctrl3_31_19.value[12:0];
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
    
    cmn_pll1_ss_ctrl3_18_0 = fld_set[0];
    cmn_pll1_ss_ctrl3_31_19 = fld_set[1];
  endfunction

  function new(input string name="T_cmn_pll1_ss_ctrl3_1095");
    super.new(name, 32, build_coverage(UVM_CVR_FIELD_VALS));
    if (has_coverage(UVM_CVR_FIELD_VALS)) begin
      wr_fld_covg = new();
      rd_fld_covg = new();
    end
  endfunction

endclass


/////////////////////////////////////////////////////
//                cmn_pll1_vcocal_ctrl
/////////////////////////////////////////////////////
class T_cmn_pll1_vcocal_ctrl_1079 extends cdns_uvm_reg;

  `uvm_object_utils(T_cmn_pll1_vcocal_ctrl_1079)
  rand uvm_reg_field cmn_pll1_vcocal_ctrl_7_0;
  rand uvm_reg_field cmn_pll1_vcocal_ctrl_13_8;
  rand uvm_reg_field cmn_pll1_vcocal_ctrl_14;
  rand uvm_reg_field cmn_pll1_vcocal_ctrl_15;
  rand uvm_reg_field cmn_pll1_vcocal_ctrl_31_16;
  
  covergroup wr_fld_covg;
    cmn_pll1_vcocal_ctrl_7_0: coverpoint cmn_pll1_vcocal_ctrl_7_0.value[7:0];
    cmn_pll1_vcocal_ctrl_13_8: coverpoint cmn_pll1_vcocal_ctrl_13_8.value[5:0];
    cmn_pll1_vcocal_ctrl_14: coverpoint cmn_pll1_vcocal_ctrl_14.value[0:0];
    cmn_pll1_vcocal_ctrl_15: coverpoint cmn_pll1_vcocal_ctrl_15.value[0:0];
    cmn_pll1_vcocal_ctrl_31_16: coverpoint cmn_pll1_vcocal_ctrl_31_16.value[15:0];
  endgroup
  covergroup rd_fld_covg;
    cmn_pll1_vcocal_ctrl_7_0: coverpoint cmn_pll1_vcocal_ctrl_7_0.value[7:0];
    cmn_pll1_vcocal_ctrl_13_8: coverpoint cmn_pll1_vcocal_ctrl_13_8.value[5:0];
    cmn_pll1_vcocal_ctrl_14: coverpoint cmn_pll1_vcocal_ctrl_14.value[0:0];
    cmn_pll1_vcocal_ctrl_15: coverpoint cmn_pll1_vcocal_ctrl_15.value[0:0];
    cmn_pll1_vcocal_ctrl_31_16: coverpoint cmn_pll1_vcocal_ctrl_31_16.value[15:0];
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
    
    cmn_pll1_vcocal_ctrl_7_0 = fld_set[0];
    cmn_pll1_vcocal_ctrl_13_8 = fld_set[1];
    cmn_pll1_vcocal_ctrl_14 = fld_set[2];
    cmn_pll1_vcocal_ctrl_15 = fld_set[3];
    cmn_pll1_vcocal_ctrl_31_16 = fld_set[4];
  endfunction

  function new(input string name="T_cmn_pll1_vcocal_ctrl_1079");
    super.new(name, 32, build_coverage(UVM_CVR_FIELD_VALS));
    if (has_coverage(UVM_CVR_FIELD_VALS)) begin
      wr_fld_covg = new();
      rd_fld_covg = new();
    end
  endfunction

endclass


/////////////////////////////////////////////////////
//                cmn_pll1_vcocal_init_tmr
/////////////////////////////////////////////////////
class T_cmn_pll1_vcocal_init_tmr_1083 extends cdns_uvm_reg;

  `uvm_object_utils(T_cmn_pll1_vcocal_init_tmr_1083)
  rand uvm_reg_field cmn_pll1_vcocal_init_tmr_13_0;
  rand uvm_reg_field cmn_pll1_vcocal_init_tmr_15_14;
  rand uvm_reg_field cmn_pll1_vcocal_init_tmr_31_16;
  
  covergroup wr_fld_covg;
    cmn_pll1_vcocal_init_tmr_13_0: coverpoint cmn_pll1_vcocal_init_tmr_13_0.value[13:0];
    cmn_pll1_vcocal_init_tmr_15_14: coverpoint cmn_pll1_vcocal_init_tmr_15_14.value[1:0];
    cmn_pll1_vcocal_init_tmr_31_16: coverpoint cmn_pll1_vcocal_init_tmr_31_16.value[15:0];
  endgroup
  covergroup rd_fld_covg;
    cmn_pll1_vcocal_init_tmr_13_0: coverpoint cmn_pll1_vcocal_init_tmr_13_0.value[13:0];
    cmn_pll1_vcocal_init_tmr_15_14: coverpoint cmn_pll1_vcocal_init_tmr_15_14.value[1:0];
    cmn_pll1_vcocal_init_tmr_31_16: coverpoint cmn_pll1_vcocal_init_tmr_31_16.value[15:0];
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
    
    cmn_pll1_vcocal_init_tmr_13_0 = fld_set[0];
    cmn_pll1_vcocal_init_tmr_15_14 = fld_set[1];
    cmn_pll1_vcocal_init_tmr_31_16 = fld_set[2];
  endfunction

  function new(input string name="T_cmn_pll1_vcocal_init_tmr_1083");
    super.new(name, 32, build_coverage(UVM_CVR_FIELD_VALS));
    if (has_coverage(UVM_CVR_FIELD_VALS)) begin
      wr_fld_covg = new();
      rd_fld_covg = new();
    end
  endfunction

endclass


/////////////////////////////////////////////////////
//                cmn_pll1_vcocal_iter_tmr
/////////////////////////////////////////////////////
class T_cmn_pll1_vcocal_iter_tmr_1084 extends cdns_uvm_reg;

  `uvm_object_utils(T_cmn_pll1_vcocal_iter_tmr_1084)
  rand uvm_reg_field cmn_pll1_vcocal_iter_tmr_13_0;
  rand uvm_reg_field cmn_pll1_vcocal_iter_tmr_15_14;
  rand uvm_reg_field cmn_pll1_vcocal_iter_tmr_31_16;
  
  covergroup wr_fld_covg;
    cmn_pll1_vcocal_iter_tmr_13_0: coverpoint cmn_pll1_vcocal_iter_tmr_13_0.value[13:0];
    cmn_pll1_vcocal_iter_tmr_15_14: coverpoint cmn_pll1_vcocal_iter_tmr_15_14.value[1:0];
    cmn_pll1_vcocal_iter_tmr_31_16: coverpoint cmn_pll1_vcocal_iter_tmr_31_16.value[15:0];
  endgroup
  covergroup rd_fld_covg;
    cmn_pll1_vcocal_iter_tmr_13_0: coverpoint cmn_pll1_vcocal_iter_tmr_13_0.value[13:0];
    cmn_pll1_vcocal_iter_tmr_15_14: coverpoint cmn_pll1_vcocal_iter_tmr_15_14.value[1:0];
    cmn_pll1_vcocal_iter_tmr_31_16: coverpoint cmn_pll1_vcocal_iter_tmr_31_16.value[15:0];
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
    
    cmn_pll1_vcocal_iter_tmr_13_0 = fld_set[0];
    cmn_pll1_vcocal_iter_tmr_15_14 = fld_set[1];
    cmn_pll1_vcocal_iter_tmr_31_16 = fld_set[2];
  endfunction

  function new(input string name="T_cmn_pll1_vcocal_iter_tmr_1084");
    super.new(name, 32, build_coverage(UVM_CVR_FIELD_VALS));
    if (has_coverage(UVM_CVR_FIELD_VALS)) begin
      wr_fld_covg = new();
      rd_fld_covg = new();
    end
  endfunction

endclass


/////////////////////////////////////////////////////
//                cmn_pll1_vcocal_ovrd
/////////////////////////////////////////////////////
class T_cmn_pll1_vcocal_ovrd_1082 extends cdns_uvm_reg;

  `uvm_object_utils(T_cmn_pll1_vcocal_ovrd_1082)
  rand uvm_reg_field cmn_pll1_vcocal_ovrd_7_0;
  rand uvm_reg_field cmn_pll1_vcocal_ovrd_14_8;
  rand uvm_reg_field cmn_pll1_vcocal_ovrd_15;
  rand uvm_reg_field cmn_pll1_vcocal_ovrd_31_16;
  
  covergroup wr_fld_covg;
    cmn_pll1_vcocal_ovrd_7_0: coverpoint cmn_pll1_vcocal_ovrd_7_0.value[7:0];
    cmn_pll1_vcocal_ovrd_14_8: coverpoint cmn_pll1_vcocal_ovrd_14_8.value[6:0];
    cmn_pll1_vcocal_ovrd_15: coverpoint cmn_pll1_vcocal_ovrd_15.value[0:0];
    cmn_pll1_vcocal_ovrd_31_16: coverpoint cmn_pll1_vcocal_ovrd_31_16.value[15:0];
  endgroup
  covergroup rd_fld_covg;
    cmn_pll1_vcocal_ovrd_7_0: coverpoint cmn_pll1_vcocal_ovrd_7_0.value[7:0];
    cmn_pll1_vcocal_ovrd_14_8: coverpoint cmn_pll1_vcocal_ovrd_14_8.value[6:0];
    cmn_pll1_vcocal_ovrd_15: coverpoint cmn_pll1_vcocal_ovrd_15.value[0:0];
    cmn_pll1_vcocal_ovrd_31_16: coverpoint cmn_pll1_vcocal_ovrd_31_16.value[15:0];
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
    
    cmn_pll1_vcocal_ovrd_7_0 = fld_set[0];
    cmn_pll1_vcocal_ovrd_14_8 = fld_set[1];
    cmn_pll1_vcocal_ovrd_15 = fld_set[2];
    cmn_pll1_vcocal_ovrd_31_16 = fld_set[3];
  endfunction

  function new(input string name="T_cmn_pll1_vcocal_ovrd_1082");
    super.new(name, 32, build_coverage(UVM_CVR_FIELD_VALS));
    if (has_coverage(UVM_CVR_FIELD_VALS)) begin
      wr_fld_covg = new();
      rd_fld_covg = new();
    end
  endfunction

endclass


/////////////////////////////////////////////////////
//                cmn_pll1_vcocal_reftim_start
/////////////////////////////////////////////////////
class T_cmn_pll1_vcocal_reftim_start_1085 extends cdns_uvm_reg;

  `uvm_object_utils(T_cmn_pll1_vcocal_reftim_start_1085)
  rand uvm_reg_field cmn_pll1_vcocal_reftim_start_13_0;
  rand uvm_reg_field cmn_pll1_vcocal_reftim_start_15_14;
  rand uvm_reg_field cmn_pll1_vcocal_reftim_start_31_16;
  
  covergroup wr_fld_covg;
    cmn_pll1_vcocal_reftim_start_13_0: coverpoint cmn_pll1_vcocal_reftim_start_13_0.value[13:0];
    cmn_pll1_vcocal_reftim_start_15_14: coverpoint cmn_pll1_vcocal_reftim_start_15_14.value[1:0];
    cmn_pll1_vcocal_reftim_start_31_16: coverpoint cmn_pll1_vcocal_reftim_start_31_16.value[15:0];
  endgroup
  covergroup rd_fld_covg;
    cmn_pll1_vcocal_reftim_start_13_0: coverpoint cmn_pll1_vcocal_reftim_start_13_0.value[13:0];
    cmn_pll1_vcocal_reftim_start_15_14: coverpoint cmn_pll1_vcocal_reftim_start_15_14.value[1:0];
    cmn_pll1_vcocal_reftim_start_31_16: coverpoint cmn_pll1_vcocal_reftim_start_31_16.value[15:0];
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
    
    cmn_pll1_vcocal_reftim_start_13_0 = fld_set[0];
    cmn_pll1_vcocal_reftim_start_15_14 = fld_set[1];
    cmn_pll1_vcocal_reftim_start_31_16 = fld_set[2];
  endfunction

  function new(input string name="T_cmn_pll1_vcocal_reftim_start_1085");
    super.new(name, 32, build_coverage(UVM_CVR_FIELD_VALS));
    if (has_coverage(UVM_CVR_FIELD_VALS)) begin
      wr_fld_covg = new();
      rd_fld_covg = new();
    end
  endfunction

endclass


/////////////////////////////////////////////////////
//                cmn_pll1_vcocal_start
/////////////////////////////////////////////////////
class T_cmn_pll1_vcocal_start_1080 extends cdns_uvm_reg;

  `uvm_object_utils(T_cmn_pll1_vcocal_start_1080)
  rand uvm_reg_field cmn_pll1_vcocal_start_7_0;
  rand uvm_reg_field cmn_pll1_vcocal_start_11_8;
  rand uvm_reg_field cmn_pll1_vcocal_start_14_12;
  rand uvm_reg_field cmn_pll1_vcocal_start_15;
  rand uvm_reg_field cmn_pll1_vcocal_start_31_16;
  
  covergroup wr_fld_covg;
    cmn_pll1_vcocal_start_7_0: coverpoint cmn_pll1_vcocal_start_7_0.value[7:0];
    cmn_pll1_vcocal_start_11_8: coverpoint cmn_pll1_vcocal_start_11_8.value[3:0];
    cmn_pll1_vcocal_start_14_12: coverpoint cmn_pll1_vcocal_start_14_12.value[2:0];
    cmn_pll1_vcocal_start_15: coverpoint cmn_pll1_vcocal_start_15.value[0:0];
    cmn_pll1_vcocal_start_31_16: coverpoint cmn_pll1_vcocal_start_31_16.value[15:0];
  endgroup
  covergroup rd_fld_covg;
    cmn_pll1_vcocal_start_7_0: coverpoint cmn_pll1_vcocal_start_7_0.value[7:0];
    cmn_pll1_vcocal_start_11_8: coverpoint cmn_pll1_vcocal_start_11_8.value[3:0];
    cmn_pll1_vcocal_start_14_12: coverpoint cmn_pll1_vcocal_start_14_12.value[2:0];
    cmn_pll1_vcocal_start_15: coverpoint cmn_pll1_vcocal_start_15.value[0:0];
    cmn_pll1_vcocal_start_31_16: coverpoint cmn_pll1_vcocal_start_31_16.value[15:0];
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
    
    cmn_pll1_vcocal_start_7_0 = fld_set[0];
    cmn_pll1_vcocal_start_11_8 = fld_set[1];
    cmn_pll1_vcocal_start_14_12 = fld_set[2];
    cmn_pll1_vcocal_start_15 = fld_set[3];
    cmn_pll1_vcocal_start_31_16 = fld_set[4];
  endfunction

  function new(input string name="T_cmn_pll1_vcocal_start_1080");
    super.new(name, 32, build_coverage(UVM_CVR_FIELD_VALS));
    if (has_coverage(UVM_CVR_FIELD_VALS)) begin
      wr_fld_covg = new();
      rd_fld_covg = new();
    end
  endfunction

endclass


/////////////////////////////////////////////////////
//                cmn_pll1_vcocal_tctrl
/////////////////////////////////////////////////////
class T_cmn_pll1_vcocal_tctrl_1081 extends cdns_uvm_reg;

  `uvm_object_utils(T_cmn_pll1_vcocal_tctrl_1081)
  rand uvm_reg_field cmn_pll1_vcocal_tctrl_2_0;
  rand uvm_reg_field cmn_pll1_vcocal_tctrl_15_3;
  rand uvm_reg_field cmn_pll1_vcocal_tctrl_31_16;
  
  covergroup wr_fld_covg;
    cmn_pll1_vcocal_tctrl_2_0: coverpoint cmn_pll1_vcocal_tctrl_2_0.value[2:0];
    cmn_pll1_vcocal_tctrl_15_3: coverpoint cmn_pll1_vcocal_tctrl_15_3.value[12:0];
    cmn_pll1_vcocal_tctrl_31_16: coverpoint cmn_pll1_vcocal_tctrl_31_16.value[15:0];
  endgroup
  covergroup rd_fld_covg;
    cmn_pll1_vcocal_tctrl_2_0: coverpoint cmn_pll1_vcocal_tctrl_2_0.value[2:0];
    cmn_pll1_vcocal_tctrl_15_3: coverpoint cmn_pll1_vcocal_tctrl_15_3.value[12:0];
    cmn_pll1_vcocal_tctrl_31_16: coverpoint cmn_pll1_vcocal_tctrl_31_16.value[15:0];
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
    
    cmn_pll1_vcocal_tctrl_2_0 = fld_set[0];
    cmn_pll1_vcocal_tctrl_15_3 = fld_set[1];
    cmn_pll1_vcocal_tctrl_31_16 = fld_set[2];
  endfunction

  function new(input string name="T_cmn_pll1_vcocal_tctrl_1081");
    super.new(name, 32, build_coverage(UVM_CVR_FIELD_VALS));
    if (has_coverage(UVM_CVR_FIELD_VALS)) begin
      wr_fld_covg = new();
      rd_fld_covg = new();
    end
  endfunction

endclass


/////////////////////////////////////////////////////
//                cmn_pllsm0_sm_ctrl
/////////////////////////////////////////////////////
class T_cmn_pllsm0_sm_ctrl_1004 extends cdns_uvm_reg;

  `uvm_object_utils(T_cmn_pllsm0_sm_ctrl_1004)
  rand uvm_reg_field cmn_pllsm0_sm_ctrl_0;
  rand uvm_reg_field cmn_pllsm0_sm_ctrl_1;
  rand uvm_reg_field cmn_pllsm0_sm_ctrl_3_2;
  rand uvm_reg_field cmn_pllsm0_sm_ctrl_4;
  rand uvm_reg_field cmn_pllsm0_sm_ctrl_5;
  rand uvm_reg_field cmn_pllsm0_sm_ctrl_6;
  rand uvm_reg_field cmn_pllsm0_sm_ctrl_7;
  rand uvm_reg_field cmn_pllsm0_sm_ctrl_8;
  rand uvm_reg_field cmn_pllsm0_sm_ctrl_9;
  rand uvm_reg_field cmn_pllsm0_sm_ctrl_10;
  rand uvm_reg_field cmn_pllsm0_sm_ctrl_11;
  rand uvm_reg_field cmn_pllsm0_sm_ctrl_12;
  rand uvm_reg_field cmn_pllsm0_sm_ctrl_13;
  rand uvm_reg_field cmn_pllsm0_sm_ctrl_15_14;
  rand uvm_reg_field cmn_pllsm0_sm_ctrl_16;
  rand uvm_reg_field cmn_pllsm0_sm_ctrl_27_17;
  rand uvm_reg_field cmn_pllsm0_sm_ctrl_28;
  rand uvm_reg_field cmn_pllsm0_sm_ctrl_29;
  rand uvm_reg_field cmn_pllsm0_sm_ctrl_30;
  rand uvm_reg_field cmn_pllsm0_sm_ctrl_31;
  
  covergroup wr_fld_covg;
    cmn_pllsm0_sm_ctrl_0: coverpoint cmn_pllsm0_sm_ctrl_0.value[0:0];
    cmn_pllsm0_sm_ctrl_1: coverpoint cmn_pllsm0_sm_ctrl_1.value[0:0];
    cmn_pllsm0_sm_ctrl_3_2: coverpoint cmn_pllsm0_sm_ctrl_3_2.value[1:0];
    cmn_pllsm0_sm_ctrl_4: coverpoint cmn_pllsm0_sm_ctrl_4.value[0:0];
    cmn_pllsm0_sm_ctrl_5: coverpoint cmn_pllsm0_sm_ctrl_5.value[0:0];
    cmn_pllsm0_sm_ctrl_6: coverpoint cmn_pllsm0_sm_ctrl_6.value[0:0];
    cmn_pllsm0_sm_ctrl_7: coverpoint cmn_pllsm0_sm_ctrl_7.value[0:0];
    cmn_pllsm0_sm_ctrl_8: coverpoint cmn_pllsm0_sm_ctrl_8.value[0:0];
    cmn_pllsm0_sm_ctrl_9: coverpoint cmn_pllsm0_sm_ctrl_9.value[0:0];
    cmn_pllsm0_sm_ctrl_10: coverpoint cmn_pllsm0_sm_ctrl_10.value[0:0];
    cmn_pllsm0_sm_ctrl_11: coverpoint cmn_pllsm0_sm_ctrl_11.value[0:0];
    cmn_pllsm0_sm_ctrl_12: coverpoint cmn_pllsm0_sm_ctrl_12.value[0:0];
    cmn_pllsm0_sm_ctrl_13: coverpoint cmn_pllsm0_sm_ctrl_13.value[0:0];
    cmn_pllsm0_sm_ctrl_15_14: coverpoint cmn_pllsm0_sm_ctrl_15_14.value[1:0];
    cmn_pllsm0_sm_ctrl_16: coverpoint cmn_pllsm0_sm_ctrl_16.value[0:0];
    cmn_pllsm0_sm_ctrl_27_17: coverpoint cmn_pllsm0_sm_ctrl_27_17.value[10:0];
    cmn_pllsm0_sm_ctrl_28: coverpoint cmn_pllsm0_sm_ctrl_28.value[0:0];
    cmn_pllsm0_sm_ctrl_29: coverpoint cmn_pllsm0_sm_ctrl_29.value[0:0];
    cmn_pllsm0_sm_ctrl_30: coverpoint cmn_pllsm0_sm_ctrl_30.value[0:0];
    cmn_pllsm0_sm_ctrl_31: coverpoint cmn_pllsm0_sm_ctrl_31.value[0:0];
  endgroup
  covergroup rd_fld_covg;
    cmn_pllsm0_sm_ctrl_0: coverpoint cmn_pllsm0_sm_ctrl_0.value[0:0];
    cmn_pllsm0_sm_ctrl_1: coverpoint cmn_pllsm0_sm_ctrl_1.value[0:0];
    cmn_pllsm0_sm_ctrl_3_2: coverpoint cmn_pllsm0_sm_ctrl_3_2.value[1:0];
    cmn_pllsm0_sm_ctrl_4: coverpoint cmn_pllsm0_sm_ctrl_4.value[0:0];
    cmn_pllsm0_sm_ctrl_5: coverpoint cmn_pllsm0_sm_ctrl_5.value[0:0];
    cmn_pllsm0_sm_ctrl_6: coverpoint cmn_pllsm0_sm_ctrl_6.value[0:0];
    cmn_pllsm0_sm_ctrl_7: coverpoint cmn_pllsm0_sm_ctrl_7.value[0:0];
    cmn_pllsm0_sm_ctrl_8: coverpoint cmn_pllsm0_sm_ctrl_8.value[0:0];
    cmn_pllsm0_sm_ctrl_9: coverpoint cmn_pllsm0_sm_ctrl_9.value[0:0];
    cmn_pllsm0_sm_ctrl_10: coverpoint cmn_pllsm0_sm_ctrl_10.value[0:0];
    cmn_pllsm0_sm_ctrl_11: coverpoint cmn_pllsm0_sm_ctrl_11.value[0:0];
    cmn_pllsm0_sm_ctrl_12: coverpoint cmn_pllsm0_sm_ctrl_12.value[0:0];
    cmn_pllsm0_sm_ctrl_13: coverpoint cmn_pllsm0_sm_ctrl_13.value[0:0];
    cmn_pllsm0_sm_ctrl_15_14: coverpoint cmn_pllsm0_sm_ctrl_15_14.value[1:0];
    cmn_pllsm0_sm_ctrl_16: coverpoint cmn_pllsm0_sm_ctrl_16.value[0:0];
    cmn_pllsm0_sm_ctrl_27_17: coverpoint cmn_pllsm0_sm_ctrl_27_17.value[10:0];
    cmn_pllsm0_sm_ctrl_28: coverpoint cmn_pllsm0_sm_ctrl_28.value[0:0];
    cmn_pllsm0_sm_ctrl_29: coverpoint cmn_pllsm0_sm_ctrl_29.value[0:0];
    cmn_pllsm0_sm_ctrl_30: coverpoint cmn_pllsm0_sm_ctrl_30.value[0:0];
    cmn_pllsm0_sm_ctrl_31: coverpoint cmn_pllsm0_sm_ctrl_31.value[0:0];
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
    
    cmn_pllsm0_sm_ctrl_0 = fld_set[0];
    cmn_pllsm0_sm_ctrl_1 = fld_set[1];
    cmn_pllsm0_sm_ctrl_3_2 = fld_set[2];
    cmn_pllsm0_sm_ctrl_4 = fld_set[3];
    cmn_pllsm0_sm_ctrl_5 = fld_set[4];
    cmn_pllsm0_sm_ctrl_6 = fld_set[5];
    cmn_pllsm0_sm_ctrl_7 = fld_set[6];
    cmn_pllsm0_sm_ctrl_8 = fld_set[7];
    cmn_pllsm0_sm_ctrl_9 = fld_set[8];
    cmn_pllsm0_sm_ctrl_10 = fld_set[9];
    cmn_pllsm0_sm_ctrl_11 = fld_set[10];
    cmn_pllsm0_sm_ctrl_12 = fld_set[11];
    cmn_pllsm0_sm_ctrl_13 = fld_set[12];
    cmn_pllsm0_sm_ctrl_15_14 = fld_set[13];
    cmn_pllsm0_sm_ctrl_16 = fld_set[14];
    cmn_pllsm0_sm_ctrl_27_17 = fld_set[15];
    cmn_pllsm0_sm_ctrl_28 = fld_set[16];
    cmn_pllsm0_sm_ctrl_29 = fld_set[17];
    cmn_pllsm0_sm_ctrl_30 = fld_set[18];
    cmn_pllsm0_sm_ctrl_31 = fld_set[19];
  endfunction

  function new(input string name="T_cmn_pllsm0_sm_ctrl_1004");
    super.new(name, 32, build_coverage(UVM_CVR_FIELD_VALS));
    if (has_coverage(UVM_CVR_FIELD_VALS)) begin
      wr_fld_covg = new();
      rd_fld_covg = new();
    end
  endfunction

endclass


/////////////////////////////////////////////////////
//                cmn_pllsm0_st
/////////////////////////////////////////////////////
class T_cmn_pllsm0_st_1009 extends cdns_uvm_reg;

  `uvm_object_utils(T_cmn_pllsm0_st_1009)
  rand uvm_reg_field cmn_pllsm0_st_13_0;
  rand uvm_reg_field cmn_pllsm0_st_15_14;
  rand uvm_reg_field cmn_pllsm0_st_31_16;
  
  covergroup wr_fld_covg;
    cmn_pllsm0_st_13_0: coverpoint cmn_pllsm0_st_13_0.value[13:0];
    cmn_pllsm0_st_15_14: coverpoint cmn_pllsm0_st_15_14.value[1:0];
    cmn_pllsm0_st_31_16: coverpoint cmn_pllsm0_st_31_16.value[15:0];
  endgroup
  covergroup rd_fld_covg;
    cmn_pllsm0_st_13_0: coverpoint cmn_pllsm0_st_13_0.value[13:0];
    cmn_pllsm0_st_15_14: coverpoint cmn_pllsm0_st_15_14.value[1:0];
    cmn_pllsm0_st_31_16: coverpoint cmn_pllsm0_st_31_16.value[15:0];
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
    
    cmn_pllsm0_st_13_0 = fld_set[0];
    cmn_pllsm0_st_15_14 = fld_set[1];
    cmn_pllsm0_st_31_16 = fld_set[2];
  endfunction

  function new(input string name="T_cmn_pllsm0_st_1009");
    super.new(name, 32, build_coverage(UVM_CVR_FIELD_VALS));
    if (has_coverage(UVM_CVR_FIELD_VALS)) begin
      wr_fld_covg = new();
      rd_fld_covg = new();
    end
  endfunction

endclass


/////////////////////////////////////////////////////
//                cmn_pllsm0_tmr_1
/////////////////////////////////////////////////////
class T_cmn_pllsm0_tmr_1_1005 extends cdns_uvm_reg;

  `uvm_object_utils(T_cmn_pllsm0_tmr_1_1005)
  rand uvm_reg_field cmn_pllsm0_tmr_1_3_0;
  rand uvm_reg_field cmn_pllsm0_tmr_1_15_4;
  rand uvm_reg_field cmn_pllsm0_tmr_1_23_16;
  rand uvm_reg_field cmn_pllsm0_tmr_1_31_24;
  
  covergroup wr_fld_covg;
    cmn_pllsm0_tmr_1_3_0: coverpoint cmn_pllsm0_tmr_1_3_0.value[3:0];
    cmn_pllsm0_tmr_1_15_4: coverpoint cmn_pllsm0_tmr_1_15_4.value[11:0];
    cmn_pllsm0_tmr_1_23_16: coverpoint cmn_pllsm0_tmr_1_23_16.value[7:0];
    cmn_pllsm0_tmr_1_31_24: coverpoint cmn_pllsm0_tmr_1_31_24.value[7:0];
  endgroup
  covergroup rd_fld_covg;
    cmn_pllsm0_tmr_1_3_0: coverpoint cmn_pllsm0_tmr_1_3_0.value[3:0];
    cmn_pllsm0_tmr_1_15_4: coverpoint cmn_pllsm0_tmr_1_15_4.value[11:0];
    cmn_pllsm0_tmr_1_23_16: coverpoint cmn_pllsm0_tmr_1_23_16.value[7:0];
    cmn_pllsm0_tmr_1_31_24: coverpoint cmn_pllsm0_tmr_1_31_24.value[7:0];
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
    
    cmn_pllsm0_tmr_1_3_0 = fld_set[0];
    cmn_pllsm0_tmr_1_15_4 = fld_set[1];
    cmn_pllsm0_tmr_1_23_16 = fld_set[2];
    cmn_pllsm0_tmr_1_31_24 = fld_set[3];
  endfunction

  function new(input string name="T_cmn_pllsm0_tmr_1_1005");
    super.new(name, 32, build_coverage(UVM_CVR_FIELD_VALS));
    if (has_coverage(UVM_CVR_FIELD_VALS)) begin
      wr_fld_covg = new();
      rd_fld_covg = new();
    end
  endfunction

endclass


/////////////////////////////////////////////////////
//                cmn_pllsm0_tmr_2
/////////////////////////////////////////////////////
class T_cmn_pllsm0_tmr_2_1006 extends cdns_uvm_reg;

  `uvm_object_utils(T_cmn_pllsm0_tmr_2_1006)
  rand uvm_reg_field cmn_pllsm0_tmr_2_7_0;
  rand uvm_reg_field cmn_pllsm0_tmr_2_15_8;
  rand uvm_reg_field cmn_pllsm0_tmr_2_19_16;
  rand uvm_reg_field cmn_pllsm0_tmr_2_31_20;
  
  covergroup wr_fld_covg;
    cmn_pllsm0_tmr_2_7_0: coverpoint cmn_pllsm0_tmr_2_7_0.value[7:0];
    cmn_pllsm0_tmr_2_15_8: coverpoint cmn_pllsm0_tmr_2_15_8.value[7:0];
    cmn_pllsm0_tmr_2_19_16: coverpoint cmn_pllsm0_tmr_2_19_16.value[3:0];
    cmn_pllsm0_tmr_2_31_20: coverpoint cmn_pllsm0_tmr_2_31_20.value[11:0];
  endgroup
  covergroup rd_fld_covg;
    cmn_pllsm0_tmr_2_7_0: coverpoint cmn_pllsm0_tmr_2_7_0.value[7:0];
    cmn_pllsm0_tmr_2_15_8: coverpoint cmn_pllsm0_tmr_2_15_8.value[7:0];
    cmn_pllsm0_tmr_2_19_16: coverpoint cmn_pllsm0_tmr_2_19_16.value[3:0];
    cmn_pllsm0_tmr_2_31_20: coverpoint cmn_pllsm0_tmr_2_31_20.value[11:0];
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
    
    cmn_pllsm0_tmr_2_7_0 = fld_set[0];
    cmn_pllsm0_tmr_2_15_8 = fld_set[1];
    cmn_pllsm0_tmr_2_19_16 = fld_set[2];
    cmn_pllsm0_tmr_2_31_20 = fld_set[3];
  endfunction

  function new(input string name="T_cmn_pllsm0_tmr_2_1006");
    super.new(name, 32, build_coverage(UVM_CVR_FIELD_VALS));
    if (has_coverage(UVM_CVR_FIELD_VALS)) begin
      wr_fld_covg = new();
      rd_fld_covg = new();
    end
  endfunction

endclass


/////////////////////////////////////////////////////
//                cmn_pllsm0_tmr_3
/////////////////////////////////////////////////////
class T_cmn_pllsm0_tmr_3_1007 extends cdns_uvm_reg;

  `uvm_object_utils(T_cmn_pllsm0_tmr_3_1007)
  rand uvm_reg_field cmn_pllsm0_tmr_3_9_0;
  rand uvm_reg_field cmn_pllsm0_tmr_3_15_10;
  rand uvm_reg_field cmn_pllsm0_tmr_3_19_16;
  rand uvm_reg_field cmn_pllsm0_tmr_3_31_20;
  
  covergroup wr_fld_covg;
    cmn_pllsm0_tmr_3_9_0: coverpoint cmn_pllsm0_tmr_3_9_0.value[9:0];
    cmn_pllsm0_tmr_3_15_10: coverpoint cmn_pllsm0_tmr_3_15_10.value[5:0];
    cmn_pllsm0_tmr_3_19_16: coverpoint cmn_pllsm0_tmr_3_19_16.value[3:0];
    cmn_pllsm0_tmr_3_31_20: coverpoint cmn_pllsm0_tmr_3_31_20.value[11:0];
  endgroup
  covergroup rd_fld_covg;
    cmn_pllsm0_tmr_3_9_0: coverpoint cmn_pllsm0_tmr_3_9_0.value[9:0];
    cmn_pllsm0_tmr_3_15_10: coverpoint cmn_pllsm0_tmr_3_15_10.value[5:0];
    cmn_pllsm0_tmr_3_19_16: coverpoint cmn_pllsm0_tmr_3_19_16.value[3:0];
    cmn_pllsm0_tmr_3_31_20: coverpoint cmn_pllsm0_tmr_3_31_20.value[11:0];
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
    
    cmn_pllsm0_tmr_3_9_0 = fld_set[0];
    cmn_pllsm0_tmr_3_15_10 = fld_set[1];
    cmn_pllsm0_tmr_3_19_16 = fld_set[2];
    cmn_pllsm0_tmr_3_31_20 = fld_set[3];
  endfunction

  function new(input string name="T_cmn_pllsm0_tmr_3_1007");
    super.new(name, 32, build_coverage(UVM_CVR_FIELD_VALS));
    if (has_coverage(UVM_CVR_FIELD_VALS)) begin
      wr_fld_covg = new();
      rd_fld_covg = new();
    end
  endfunction

endclass


/////////////////////////////////////////////////////
//                cmn_pllsm0_tmr_4
/////////////////////////////////////////////////////
class T_cmn_pllsm0_tmr_4_1008 extends cdns_uvm_reg;

  `uvm_object_utils(T_cmn_pllsm0_tmr_4_1008)
  rand uvm_reg_field cmn_pllsm0_tmr_4_1_0;
  rand uvm_reg_field cmn_pllsm0_tmr_4_15_2;
  rand uvm_reg_field cmn_pllsm0_tmr_4_31_16;
  
  covergroup wr_fld_covg;
    cmn_pllsm0_tmr_4_1_0: coverpoint cmn_pllsm0_tmr_4_1_0.value[1:0];
    cmn_pllsm0_tmr_4_15_2: coverpoint cmn_pllsm0_tmr_4_15_2.value[13:0];
    cmn_pllsm0_tmr_4_31_16: coverpoint cmn_pllsm0_tmr_4_31_16.value[15:0];
  endgroup
  covergroup rd_fld_covg;
    cmn_pllsm0_tmr_4_1_0: coverpoint cmn_pllsm0_tmr_4_1_0.value[1:0];
    cmn_pllsm0_tmr_4_15_2: coverpoint cmn_pllsm0_tmr_4_15_2.value[13:0];
    cmn_pllsm0_tmr_4_31_16: coverpoint cmn_pllsm0_tmr_4_31_16.value[15:0];
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
    
    cmn_pllsm0_tmr_4_1_0 = fld_set[0];
    cmn_pllsm0_tmr_4_15_2 = fld_set[1];
    cmn_pllsm0_tmr_4_31_16 = fld_set[2];
  endfunction

  function new(input string name="T_cmn_pllsm0_tmr_4_1008");
    super.new(name, 32, build_coverage(UVM_CVR_FIELD_VALS));
    if (has_coverage(UVM_CVR_FIELD_VALS)) begin
      wr_fld_covg = new();
      rd_fld_covg = new();
    end
  endfunction

endclass


/////////////////////////////////////////////////////
//                cmn_pllsm1_sm_ctrl0
/////////////////////////////////////////////////////
class T_cmn_pllsm1_sm_ctrl0_1010 extends cdns_uvm_reg;

  `uvm_object_utils(T_cmn_pllsm1_sm_ctrl0_1010)
  rand uvm_reg_field cmn_pllsm1_sm_ctrl0_0;
  rand uvm_reg_field cmn_pllsm1_sm_ctrl0_1;
  rand uvm_reg_field cmn_pllsm1_sm_ctrl0_2;
  rand uvm_reg_field cmn_pllsm1_sm_ctrl0_3;
  rand uvm_reg_field cmn_pllsm1_sm_ctrl0_4;
  rand uvm_reg_field cmn_pllsm1_sm_ctrl0_5;
  rand uvm_reg_field cmn_pllsm1_sm_ctrl0_6;
  rand uvm_reg_field cmn_pllsm1_sm_ctrl0_7;
  rand uvm_reg_field cmn_pllsm1_sm_ctrl0_8;
  rand uvm_reg_field cmn_pllsm1_sm_ctrl0_9;
  rand uvm_reg_field cmn_pllsm1_sm_ctrl0_10;
  rand uvm_reg_field cmn_pllsm1_sm_ctrl0_11;
  rand uvm_reg_field cmn_pllsm1_sm_ctrl0_12;
  rand uvm_reg_field cmn_pllsm1_sm_ctrl0_13;
  rand uvm_reg_field cmn_pllsm1_sm_ctrl0_14;
  rand uvm_reg_field cmn_pllsm1_sm_ctrl0_15;
  rand uvm_reg_field cmn_pllsm1_sm_ctrl0_16;
  rand uvm_reg_field cmn_pllsm1_sm_ctrl0_17;
  rand uvm_reg_field cmn_pllsm1_sm_ctrl0_18;
  rand uvm_reg_field cmn_pllsm1_sm_ctrl0_19;
  rand uvm_reg_field cmn_pllsm1_sm_ctrl0_20;
  rand uvm_reg_field cmn_pllsm1_sm_ctrl0_21;
  rand uvm_reg_field cmn_pllsm1_sm_ctrl0_22;
  rand uvm_reg_field cmn_pllsm1_sm_ctrl0_23;
  rand uvm_reg_field cmn_pllsm1_sm_ctrl0_24;
  rand uvm_reg_field cmn_pllsm1_sm_ctrl0_25;
  rand uvm_reg_field cmn_pllsm1_sm_ctrl0_26;
  rand uvm_reg_field cmn_pllsm1_sm_ctrl0_27;
  rand uvm_reg_field cmn_pllsm1_sm_ctrl0_28;
  rand uvm_reg_field cmn_pllsm1_sm_ctrl0_29;
  rand uvm_reg_field cmn_pllsm1_sm_ctrl0_30;
  rand uvm_reg_field cmn_pllsm1_sm_ctrl0_31;
  
  covergroup wr_fld_covg;
    cmn_pllsm1_sm_ctrl0_0: coverpoint cmn_pllsm1_sm_ctrl0_0.value[0:0];
    cmn_pllsm1_sm_ctrl0_1: coverpoint cmn_pllsm1_sm_ctrl0_1.value[0:0];
    cmn_pllsm1_sm_ctrl0_2: coverpoint cmn_pllsm1_sm_ctrl0_2.value[0:0];
    cmn_pllsm1_sm_ctrl0_3: coverpoint cmn_pllsm1_sm_ctrl0_3.value[0:0];
    cmn_pllsm1_sm_ctrl0_4: coverpoint cmn_pllsm1_sm_ctrl0_4.value[0:0];
    cmn_pllsm1_sm_ctrl0_5: coverpoint cmn_pllsm1_sm_ctrl0_5.value[0:0];
    cmn_pllsm1_sm_ctrl0_6: coverpoint cmn_pllsm1_sm_ctrl0_6.value[0:0];
    cmn_pllsm1_sm_ctrl0_7: coverpoint cmn_pllsm1_sm_ctrl0_7.value[0:0];
    cmn_pllsm1_sm_ctrl0_8: coverpoint cmn_pllsm1_sm_ctrl0_8.value[0:0];
    cmn_pllsm1_sm_ctrl0_9: coverpoint cmn_pllsm1_sm_ctrl0_9.value[0:0];
    cmn_pllsm1_sm_ctrl0_10: coverpoint cmn_pllsm1_sm_ctrl0_10.value[0:0];
    cmn_pllsm1_sm_ctrl0_11: coverpoint cmn_pllsm1_sm_ctrl0_11.value[0:0];
    cmn_pllsm1_sm_ctrl0_12: coverpoint cmn_pllsm1_sm_ctrl0_12.value[0:0];
    cmn_pllsm1_sm_ctrl0_13: coverpoint cmn_pllsm1_sm_ctrl0_13.value[0:0];
    cmn_pllsm1_sm_ctrl0_14: coverpoint cmn_pllsm1_sm_ctrl0_14.value[0:0];
    cmn_pllsm1_sm_ctrl0_15: coverpoint cmn_pllsm1_sm_ctrl0_15.value[0:0];
    cmn_pllsm1_sm_ctrl0_16: coverpoint cmn_pllsm1_sm_ctrl0_16.value[0:0];
    cmn_pllsm1_sm_ctrl0_17: coverpoint cmn_pllsm1_sm_ctrl0_17.value[0:0];
    cmn_pllsm1_sm_ctrl0_18: coverpoint cmn_pllsm1_sm_ctrl0_18.value[0:0];
    cmn_pllsm1_sm_ctrl0_19: coverpoint cmn_pllsm1_sm_ctrl0_19.value[0:0];
    cmn_pllsm1_sm_ctrl0_20: coverpoint cmn_pllsm1_sm_ctrl0_20.value[0:0];
    cmn_pllsm1_sm_ctrl0_21: coverpoint cmn_pllsm1_sm_ctrl0_21.value[0:0];
    cmn_pllsm1_sm_ctrl0_22: coverpoint cmn_pllsm1_sm_ctrl0_22.value[0:0];
    cmn_pllsm1_sm_ctrl0_23: coverpoint cmn_pllsm1_sm_ctrl0_23.value[0:0];
    cmn_pllsm1_sm_ctrl0_24: coverpoint cmn_pllsm1_sm_ctrl0_24.value[0:0];
    cmn_pllsm1_sm_ctrl0_25: coverpoint cmn_pllsm1_sm_ctrl0_25.value[0:0];
    cmn_pllsm1_sm_ctrl0_26: coverpoint cmn_pllsm1_sm_ctrl0_26.value[0:0];
    cmn_pllsm1_sm_ctrl0_27: coverpoint cmn_pllsm1_sm_ctrl0_27.value[0:0];
    cmn_pllsm1_sm_ctrl0_28: coverpoint cmn_pllsm1_sm_ctrl0_28.value[0:0];
    cmn_pllsm1_sm_ctrl0_29: coverpoint cmn_pllsm1_sm_ctrl0_29.value[0:0];
    cmn_pllsm1_sm_ctrl0_30: coverpoint cmn_pllsm1_sm_ctrl0_30.value[0:0];
    cmn_pllsm1_sm_ctrl0_31: coverpoint cmn_pllsm1_sm_ctrl0_31.value[0:0];
  endgroup
  covergroup rd_fld_covg;
    cmn_pllsm1_sm_ctrl0_0: coverpoint cmn_pllsm1_sm_ctrl0_0.value[0:0];
    cmn_pllsm1_sm_ctrl0_1: coverpoint cmn_pllsm1_sm_ctrl0_1.value[0:0];
    cmn_pllsm1_sm_ctrl0_2: coverpoint cmn_pllsm1_sm_ctrl0_2.value[0:0];
    cmn_pllsm1_sm_ctrl0_3: coverpoint cmn_pllsm1_sm_ctrl0_3.value[0:0];
    cmn_pllsm1_sm_ctrl0_4: coverpoint cmn_pllsm1_sm_ctrl0_4.value[0:0];
    cmn_pllsm1_sm_ctrl0_5: coverpoint cmn_pllsm1_sm_ctrl0_5.value[0:0];
    cmn_pllsm1_sm_ctrl0_6: coverpoint cmn_pllsm1_sm_ctrl0_6.value[0:0];
    cmn_pllsm1_sm_ctrl0_7: coverpoint cmn_pllsm1_sm_ctrl0_7.value[0:0];
    cmn_pllsm1_sm_ctrl0_8: coverpoint cmn_pllsm1_sm_ctrl0_8.value[0:0];
    cmn_pllsm1_sm_ctrl0_9: coverpoint cmn_pllsm1_sm_ctrl0_9.value[0:0];
    cmn_pllsm1_sm_ctrl0_10: coverpoint cmn_pllsm1_sm_ctrl0_10.value[0:0];
    cmn_pllsm1_sm_ctrl0_11: coverpoint cmn_pllsm1_sm_ctrl0_11.value[0:0];
    cmn_pllsm1_sm_ctrl0_12: coverpoint cmn_pllsm1_sm_ctrl0_12.value[0:0];
    cmn_pllsm1_sm_ctrl0_13: coverpoint cmn_pllsm1_sm_ctrl0_13.value[0:0];
    cmn_pllsm1_sm_ctrl0_14: coverpoint cmn_pllsm1_sm_ctrl0_14.value[0:0];
    cmn_pllsm1_sm_ctrl0_15: coverpoint cmn_pllsm1_sm_ctrl0_15.value[0:0];
    cmn_pllsm1_sm_ctrl0_16: coverpoint cmn_pllsm1_sm_ctrl0_16.value[0:0];
    cmn_pllsm1_sm_ctrl0_17: coverpoint cmn_pllsm1_sm_ctrl0_17.value[0:0];
    cmn_pllsm1_sm_ctrl0_18: coverpoint cmn_pllsm1_sm_ctrl0_18.value[0:0];
    cmn_pllsm1_sm_ctrl0_19: coverpoint cmn_pllsm1_sm_ctrl0_19.value[0:0];
    cmn_pllsm1_sm_ctrl0_20: coverpoint cmn_pllsm1_sm_ctrl0_20.value[0:0];
    cmn_pllsm1_sm_ctrl0_21: coverpoint cmn_pllsm1_sm_ctrl0_21.value[0:0];
    cmn_pllsm1_sm_ctrl0_22: coverpoint cmn_pllsm1_sm_ctrl0_22.value[0:0];
    cmn_pllsm1_sm_ctrl0_23: coverpoint cmn_pllsm1_sm_ctrl0_23.value[0:0];
    cmn_pllsm1_sm_ctrl0_24: coverpoint cmn_pllsm1_sm_ctrl0_24.value[0:0];
    cmn_pllsm1_sm_ctrl0_25: coverpoint cmn_pllsm1_sm_ctrl0_25.value[0:0];
    cmn_pllsm1_sm_ctrl0_26: coverpoint cmn_pllsm1_sm_ctrl0_26.value[0:0];
    cmn_pllsm1_sm_ctrl0_27: coverpoint cmn_pllsm1_sm_ctrl0_27.value[0:0];
    cmn_pllsm1_sm_ctrl0_28: coverpoint cmn_pllsm1_sm_ctrl0_28.value[0:0];
    cmn_pllsm1_sm_ctrl0_29: coverpoint cmn_pllsm1_sm_ctrl0_29.value[0:0];
    cmn_pllsm1_sm_ctrl0_30: coverpoint cmn_pllsm1_sm_ctrl0_30.value[0:0];
    cmn_pllsm1_sm_ctrl0_31: coverpoint cmn_pllsm1_sm_ctrl0_31.value[0:0];
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
    
    cmn_pllsm1_sm_ctrl0_0 = fld_set[0];
    cmn_pllsm1_sm_ctrl0_1 = fld_set[1];
    cmn_pllsm1_sm_ctrl0_2 = fld_set[2];
    cmn_pllsm1_sm_ctrl0_3 = fld_set[3];
    cmn_pllsm1_sm_ctrl0_4 = fld_set[4];
    cmn_pllsm1_sm_ctrl0_5 = fld_set[5];
    cmn_pllsm1_sm_ctrl0_6 = fld_set[6];
    cmn_pllsm1_sm_ctrl0_7 = fld_set[7];
    cmn_pllsm1_sm_ctrl0_8 = fld_set[8];
    cmn_pllsm1_sm_ctrl0_9 = fld_set[9];
    cmn_pllsm1_sm_ctrl0_10 = fld_set[10];
    cmn_pllsm1_sm_ctrl0_11 = fld_set[11];
    cmn_pllsm1_sm_ctrl0_12 = fld_set[12];
    cmn_pllsm1_sm_ctrl0_13 = fld_set[13];
    cmn_pllsm1_sm_ctrl0_14 = fld_set[14];
    cmn_pllsm1_sm_ctrl0_15 = fld_set[15];
    cmn_pllsm1_sm_ctrl0_16 = fld_set[16];
    cmn_pllsm1_sm_ctrl0_17 = fld_set[17];
    cmn_pllsm1_sm_ctrl0_18 = fld_set[18];
    cmn_pllsm1_sm_ctrl0_19 = fld_set[19];
    cmn_pllsm1_sm_ctrl0_20 = fld_set[20];
    cmn_pllsm1_sm_ctrl0_21 = fld_set[21];
    cmn_pllsm1_sm_ctrl0_22 = fld_set[22];
    cmn_pllsm1_sm_ctrl0_23 = fld_set[23];
    cmn_pllsm1_sm_ctrl0_24 = fld_set[24];
    cmn_pllsm1_sm_ctrl0_25 = fld_set[25];
    cmn_pllsm1_sm_ctrl0_26 = fld_set[26];
    cmn_pllsm1_sm_ctrl0_27 = fld_set[27];
    cmn_pllsm1_sm_ctrl0_28 = fld_set[28];
    cmn_pllsm1_sm_ctrl0_29 = fld_set[29];
    cmn_pllsm1_sm_ctrl0_30 = fld_set[30];
    cmn_pllsm1_sm_ctrl0_31 = fld_set[31];
  endfunction

  function new(input string name="T_cmn_pllsm1_sm_ctrl0_1010");
    super.new(name, 32, build_coverage(UVM_CVR_FIELD_VALS));
    if (has_coverage(UVM_CVR_FIELD_VALS)) begin
      wr_fld_covg = new();
      rd_fld_covg = new();
    end
  endfunction

endclass


/////////////////////////////////////////////////////
//                cmn_pllsm1_sm_ctrl1
/////////////////////////////////////////////////////
class T_cmn_pllsm1_sm_ctrl1_1011 extends cdns_uvm_reg;

  `uvm_object_utils(T_cmn_pllsm1_sm_ctrl1_1011)
  rand uvm_reg_field cmn_pllsm1_sm_ctrl1_0;
  rand uvm_reg_field cmn_pllsm1_sm_ctrl1_1;
  rand uvm_reg_field cmn_pllsm1_sm_ctrl1_2;
  rand uvm_reg_field cmn_pllsm1_sm_ctrl1_3;
  rand uvm_reg_field cmn_pllsm1_sm_ctrl1_4;
  rand uvm_reg_field cmn_pllsm1_sm_ctrl1_5;
  rand uvm_reg_field cmn_pllsm1_sm_ctrl1_6;
  rand uvm_reg_field cmn_pllsm1_sm_ctrl1_7;
  rand uvm_reg_field cmn_pllsm1_sm_ctrl1_8;
  rand uvm_reg_field cmn_pllsm1_sm_ctrl1_9;
  rand uvm_reg_field cmn_pllsm1_sm_ctrl1_10;
  rand uvm_reg_field cmn_pllsm1_sm_ctrl1_11;
  rand uvm_reg_field cmn_pllsm1_sm_ctrl1_15_12;
  rand uvm_reg_field cmn_pllsm1_sm_ctrl1_16;
  rand uvm_reg_field cmn_pllsm1_sm_ctrl1_31_17;
  
  covergroup wr_fld_covg;
    cmn_pllsm1_sm_ctrl1_0: coverpoint cmn_pllsm1_sm_ctrl1_0.value[0:0];
    cmn_pllsm1_sm_ctrl1_1: coverpoint cmn_pllsm1_sm_ctrl1_1.value[0:0];
    cmn_pllsm1_sm_ctrl1_2: coverpoint cmn_pllsm1_sm_ctrl1_2.value[0:0];
    cmn_pllsm1_sm_ctrl1_3: coverpoint cmn_pllsm1_sm_ctrl1_3.value[0:0];
    cmn_pllsm1_sm_ctrl1_4: coverpoint cmn_pllsm1_sm_ctrl1_4.value[0:0];
    cmn_pllsm1_sm_ctrl1_5: coverpoint cmn_pllsm1_sm_ctrl1_5.value[0:0];
    cmn_pllsm1_sm_ctrl1_6: coverpoint cmn_pllsm1_sm_ctrl1_6.value[0:0];
    cmn_pllsm1_sm_ctrl1_7: coverpoint cmn_pllsm1_sm_ctrl1_7.value[0:0];
    cmn_pllsm1_sm_ctrl1_8: coverpoint cmn_pllsm1_sm_ctrl1_8.value[0:0];
    cmn_pllsm1_sm_ctrl1_9: coverpoint cmn_pllsm1_sm_ctrl1_9.value[0:0];
    cmn_pllsm1_sm_ctrl1_10: coverpoint cmn_pllsm1_sm_ctrl1_10.value[0:0];
    cmn_pllsm1_sm_ctrl1_11: coverpoint cmn_pllsm1_sm_ctrl1_11.value[0:0];
    cmn_pllsm1_sm_ctrl1_15_12: coverpoint cmn_pllsm1_sm_ctrl1_15_12.value[3:0];
    cmn_pllsm1_sm_ctrl1_16: coverpoint cmn_pllsm1_sm_ctrl1_16.value[0:0];
    cmn_pllsm1_sm_ctrl1_31_17: coverpoint cmn_pllsm1_sm_ctrl1_31_17.value[14:0];
  endgroup
  covergroup rd_fld_covg;
    cmn_pllsm1_sm_ctrl1_0: coverpoint cmn_pllsm1_sm_ctrl1_0.value[0:0];
    cmn_pllsm1_sm_ctrl1_1: coverpoint cmn_pllsm1_sm_ctrl1_1.value[0:0];
    cmn_pllsm1_sm_ctrl1_2: coverpoint cmn_pllsm1_sm_ctrl1_2.value[0:0];
    cmn_pllsm1_sm_ctrl1_3: coverpoint cmn_pllsm1_sm_ctrl1_3.value[0:0];
    cmn_pllsm1_sm_ctrl1_4: coverpoint cmn_pllsm1_sm_ctrl1_4.value[0:0];
    cmn_pllsm1_sm_ctrl1_5: coverpoint cmn_pllsm1_sm_ctrl1_5.value[0:0];
    cmn_pllsm1_sm_ctrl1_6: coverpoint cmn_pllsm1_sm_ctrl1_6.value[0:0];
    cmn_pllsm1_sm_ctrl1_7: coverpoint cmn_pllsm1_sm_ctrl1_7.value[0:0];
    cmn_pllsm1_sm_ctrl1_8: coverpoint cmn_pllsm1_sm_ctrl1_8.value[0:0];
    cmn_pllsm1_sm_ctrl1_9: coverpoint cmn_pllsm1_sm_ctrl1_9.value[0:0];
    cmn_pllsm1_sm_ctrl1_10: coverpoint cmn_pllsm1_sm_ctrl1_10.value[0:0];
    cmn_pllsm1_sm_ctrl1_11: coverpoint cmn_pllsm1_sm_ctrl1_11.value[0:0];
    cmn_pllsm1_sm_ctrl1_15_12: coverpoint cmn_pllsm1_sm_ctrl1_15_12.value[3:0];
    cmn_pllsm1_sm_ctrl1_16: coverpoint cmn_pllsm1_sm_ctrl1_16.value[0:0];
    cmn_pllsm1_sm_ctrl1_31_17: coverpoint cmn_pllsm1_sm_ctrl1_31_17.value[14:0];
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
    
    cmn_pllsm1_sm_ctrl1_0 = fld_set[0];
    cmn_pllsm1_sm_ctrl1_1 = fld_set[1];
    cmn_pllsm1_sm_ctrl1_2 = fld_set[2];
    cmn_pllsm1_sm_ctrl1_3 = fld_set[3];
    cmn_pllsm1_sm_ctrl1_4 = fld_set[4];
    cmn_pllsm1_sm_ctrl1_5 = fld_set[5];
    cmn_pllsm1_sm_ctrl1_6 = fld_set[6];
    cmn_pllsm1_sm_ctrl1_7 = fld_set[7];
    cmn_pllsm1_sm_ctrl1_8 = fld_set[8];
    cmn_pllsm1_sm_ctrl1_9 = fld_set[9];
    cmn_pllsm1_sm_ctrl1_10 = fld_set[10];
    cmn_pllsm1_sm_ctrl1_11 = fld_set[11];
    cmn_pllsm1_sm_ctrl1_15_12 = fld_set[12];
    cmn_pllsm1_sm_ctrl1_16 = fld_set[13];
    cmn_pllsm1_sm_ctrl1_31_17 = fld_set[14];
  endfunction

  function new(input string name="T_cmn_pllsm1_sm_ctrl1_1011");
    super.new(name, 32, build_coverage(UVM_CVR_FIELD_VALS));
    if (has_coverage(UVM_CVR_FIELD_VALS)) begin
      wr_fld_covg = new();
      rd_fld_covg = new();
    end
  endfunction

endclass


/////////////////////////////////////////////////////
//                cmn_pllsm1_st
/////////////////////////////////////////////////////
class T_cmn_pllsm1_st_1020 extends cdns_uvm_reg;

  `uvm_object_utils(T_cmn_pllsm1_st_1020)
  rand uvm_reg_field cmn_pllsm1_st_24_0;
  rand uvm_reg_field cmn_pllsm1_st_31_25;
  
  covergroup wr_fld_covg;
    cmn_pllsm1_st_24_0: coverpoint cmn_pllsm1_st_24_0.value[24:0];
    cmn_pllsm1_st_31_25: coverpoint cmn_pllsm1_st_31_25.value[6:0];
  endgroup
  covergroup rd_fld_covg;
    cmn_pllsm1_st_24_0: coverpoint cmn_pllsm1_st_24_0.value[24:0];
    cmn_pllsm1_st_31_25: coverpoint cmn_pllsm1_st_31_25.value[6:0];
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
    
    cmn_pllsm1_st_24_0 = fld_set[0];
    cmn_pllsm1_st_31_25 = fld_set[1];
  endfunction

  function new(input string name="T_cmn_pllsm1_st_1020");
    super.new(name, 32, build_coverage(UVM_CVR_FIELD_VALS));
    if (has_coverage(UVM_CVR_FIELD_VALS)) begin
      wr_fld_covg = new();
      rd_fld_covg = new();
    end
  endfunction

endclass


/////////////////////////////////////////////////////
//                cmn_pllsm1_tmr_1
/////////////////////////////////////////////////////
class T_cmn_pllsm1_tmr_1_1012 extends cdns_uvm_reg;

  `uvm_object_utils(T_cmn_pllsm1_tmr_1_1012)
  rand uvm_reg_field cmn_pllsm1_tmr_1_15_0;
  rand uvm_reg_field cmn_pllsm1_tmr_1_31_16;
  
  covergroup wr_fld_covg;
    cmn_pllsm1_tmr_1_15_0: coverpoint cmn_pllsm1_tmr_1_15_0.value[15:0];
    cmn_pllsm1_tmr_1_31_16: coverpoint cmn_pllsm1_tmr_1_31_16.value[15:0];
  endgroup
  covergroup rd_fld_covg;
    cmn_pllsm1_tmr_1_15_0: coverpoint cmn_pllsm1_tmr_1_15_0.value[15:0];
    cmn_pllsm1_tmr_1_31_16: coverpoint cmn_pllsm1_tmr_1_31_16.value[15:0];
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
    
    cmn_pllsm1_tmr_1_15_0 = fld_set[0];
    cmn_pllsm1_tmr_1_31_16 = fld_set[1];
  endfunction

  function new(input string name="T_cmn_pllsm1_tmr_1_1012");
    super.new(name, 32, build_coverage(UVM_CVR_FIELD_VALS));
    if (has_coverage(UVM_CVR_FIELD_VALS)) begin
      wr_fld_covg = new();
      rd_fld_covg = new();
    end
  endfunction

endclass


/////////////////////////////////////////////////////
//                cmn_pllsm1_tmr_2
/////////////////////////////////////////////////////
class T_cmn_pllsm1_tmr_2_1013 extends cdns_uvm_reg;

  `uvm_object_utils(T_cmn_pllsm1_tmr_2_1013)
  rand uvm_reg_field cmn_pllsm1_tmr_2_15_0;
  rand uvm_reg_field cmn_pllsm1_tmr_2_31_16;
  
  covergroup wr_fld_covg;
    cmn_pllsm1_tmr_2_15_0: coverpoint cmn_pllsm1_tmr_2_15_0.value[15:0];
    cmn_pllsm1_tmr_2_31_16: coverpoint cmn_pllsm1_tmr_2_31_16.value[15:0];
  endgroup
  covergroup rd_fld_covg;
    cmn_pllsm1_tmr_2_15_0: coverpoint cmn_pllsm1_tmr_2_15_0.value[15:0];
    cmn_pllsm1_tmr_2_31_16: coverpoint cmn_pllsm1_tmr_2_31_16.value[15:0];
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
    
    cmn_pllsm1_tmr_2_15_0 = fld_set[0];
    cmn_pllsm1_tmr_2_31_16 = fld_set[1];
  endfunction

  function new(input string name="T_cmn_pllsm1_tmr_2_1013");
    super.new(name, 32, build_coverage(UVM_CVR_FIELD_VALS));
    if (has_coverage(UVM_CVR_FIELD_VALS)) begin
      wr_fld_covg = new();
      rd_fld_covg = new();
    end
  endfunction

endclass


/////////////////////////////////////////////////////
//                cmn_pllsm1_tmr_3
/////////////////////////////////////////////////////
class T_cmn_pllsm1_tmr_3_1014 extends cdns_uvm_reg;

  `uvm_object_utils(T_cmn_pllsm1_tmr_3_1014)
  rand uvm_reg_field cmn_pllsm1_tmr_3_15_0;
  rand uvm_reg_field cmn_pllsm1_tmr_3_31_16;
  
  covergroup wr_fld_covg;
    cmn_pllsm1_tmr_3_15_0: coverpoint cmn_pllsm1_tmr_3_15_0.value[15:0];
    cmn_pllsm1_tmr_3_31_16: coverpoint cmn_pllsm1_tmr_3_31_16.value[15:0];
  endgroup
  covergroup rd_fld_covg;
    cmn_pllsm1_tmr_3_15_0: coverpoint cmn_pllsm1_tmr_3_15_0.value[15:0];
    cmn_pllsm1_tmr_3_31_16: coverpoint cmn_pllsm1_tmr_3_31_16.value[15:0];
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
    
    cmn_pllsm1_tmr_3_15_0 = fld_set[0];
    cmn_pllsm1_tmr_3_31_16 = fld_set[1];
  endfunction

  function new(input string name="T_cmn_pllsm1_tmr_3_1014");
    super.new(name, 32, build_coverage(UVM_CVR_FIELD_VALS));
    if (has_coverage(UVM_CVR_FIELD_VALS)) begin
      wr_fld_covg = new();
      rd_fld_covg = new();
    end
  endfunction

endclass


/////////////////////////////////////////////////////
//                cmn_pllsm1_tmr_4
/////////////////////////////////////////////////////
class T_cmn_pllsm1_tmr_4_1015 extends cdns_uvm_reg;

  `uvm_object_utils(T_cmn_pllsm1_tmr_4_1015)
  rand uvm_reg_field cmn_pllsm1_tmr_4_15_0;
  rand uvm_reg_field cmn_pllsm1_tmr_4_31_16;
  
  covergroup wr_fld_covg;
    cmn_pllsm1_tmr_4_15_0: coverpoint cmn_pllsm1_tmr_4_15_0.value[15:0];
    cmn_pllsm1_tmr_4_31_16: coverpoint cmn_pllsm1_tmr_4_31_16.value[15:0];
  endgroup
  covergroup rd_fld_covg;
    cmn_pllsm1_tmr_4_15_0: coverpoint cmn_pllsm1_tmr_4_15_0.value[15:0];
    cmn_pllsm1_tmr_4_31_16: coverpoint cmn_pllsm1_tmr_4_31_16.value[15:0];
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
    
    cmn_pllsm1_tmr_4_15_0 = fld_set[0];
    cmn_pllsm1_tmr_4_31_16 = fld_set[1];
  endfunction

  function new(input string name="T_cmn_pllsm1_tmr_4_1015");
    super.new(name, 32, build_coverage(UVM_CVR_FIELD_VALS));
    if (has_coverage(UVM_CVR_FIELD_VALS)) begin
      wr_fld_covg = new();
      rd_fld_covg = new();
    end
  endfunction

endclass


/////////////////////////////////////////////////////
//                cmn_pllsm1_tmr_5
/////////////////////////////////////////////////////
class T_cmn_pllsm1_tmr_5_1016 extends cdns_uvm_reg;

  `uvm_object_utils(T_cmn_pllsm1_tmr_5_1016)
  rand uvm_reg_field cmn_pllsm1_tmr_5_15_0;
  rand uvm_reg_field cmn_pllsm1_tmr_5_31_16;
  
  covergroup wr_fld_covg;
    cmn_pllsm1_tmr_5_15_0: coverpoint cmn_pllsm1_tmr_5_15_0.value[15:0];
    cmn_pllsm1_tmr_5_31_16: coverpoint cmn_pllsm1_tmr_5_31_16.value[15:0];
  endgroup
  covergroup rd_fld_covg;
    cmn_pllsm1_tmr_5_15_0: coverpoint cmn_pllsm1_tmr_5_15_0.value[15:0];
    cmn_pllsm1_tmr_5_31_16: coverpoint cmn_pllsm1_tmr_5_31_16.value[15:0];
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
    
    cmn_pllsm1_tmr_5_15_0 = fld_set[0];
    cmn_pllsm1_tmr_5_31_16 = fld_set[1];
  endfunction

  function new(input string name="T_cmn_pllsm1_tmr_5_1016");
    super.new(name, 32, build_coverage(UVM_CVR_FIELD_VALS));
    if (has_coverage(UVM_CVR_FIELD_VALS)) begin
      wr_fld_covg = new();
      rd_fld_covg = new();
    end
  endfunction

endclass


/////////////////////////////////////////////////////
//                cmn_pllsm1_tmr_6
/////////////////////////////////////////////////////
class T_cmn_pllsm1_tmr_6_1017 extends cdns_uvm_reg;

  `uvm_object_utils(T_cmn_pllsm1_tmr_6_1017)
  rand uvm_reg_field cmn_pllsm1_tmr_6_15_0;
  rand uvm_reg_field cmn_pllsm1_tmr_6_31_16;
  
  covergroup wr_fld_covg;
    cmn_pllsm1_tmr_6_15_0: coverpoint cmn_pllsm1_tmr_6_15_0.value[15:0];
    cmn_pllsm1_tmr_6_31_16: coverpoint cmn_pllsm1_tmr_6_31_16.value[15:0];
  endgroup
  covergroup rd_fld_covg;
    cmn_pllsm1_tmr_6_15_0: coverpoint cmn_pllsm1_tmr_6_15_0.value[15:0];
    cmn_pllsm1_tmr_6_31_16: coverpoint cmn_pllsm1_tmr_6_31_16.value[15:0];
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
    
    cmn_pllsm1_tmr_6_15_0 = fld_set[0];
    cmn_pllsm1_tmr_6_31_16 = fld_set[1];
  endfunction

  function new(input string name="T_cmn_pllsm1_tmr_6_1017");
    super.new(name, 32, build_coverage(UVM_CVR_FIELD_VALS));
    if (has_coverage(UVM_CVR_FIELD_VALS)) begin
      wr_fld_covg = new();
      rd_fld_covg = new();
    end
  endfunction

endclass


/////////////////////////////////////////////////////
//                cmn_pllsm1_tmr_7
/////////////////////////////////////////////////////
class T_cmn_pllsm1_tmr_7_1018 extends cdns_uvm_reg;

  `uvm_object_utils(T_cmn_pllsm1_tmr_7_1018)
  rand uvm_reg_field cmn_pllsm1_tmr_7_15_0;
  rand uvm_reg_field cmn_pllsm1_tmr_7_31_16;
  
  covergroup wr_fld_covg;
    cmn_pllsm1_tmr_7_15_0: coverpoint cmn_pllsm1_tmr_7_15_0.value[15:0];
    cmn_pllsm1_tmr_7_31_16: coverpoint cmn_pllsm1_tmr_7_31_16.value[15:0];
  endgroup
  covergroup rd_fld_covg;
    cmn_pllsm1_tmr_7_15_0: coverpoint cmn_pllsm1_tmr_7_15_0.value[15:0];
    cmn_pllsm1_tmr_7_31_16: coverpoint cmn_pllsm1_tmr_7_31_16.value[15:0];
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
    
    cmn_pllsm1_tmr_7_15_0 = fld_set[0];
    cmn_pllsm1_tmr_7_31_16 = fld_set[1];
  endfunction

  function new(input string name="T_cmn_pllsm1_tmr_7_1018");
    super.new(name, 32, build_coverage(UVM_CVR_FIELD_VALS));
    if (has_coverage(UVM_CVR_FIELD_VALS)) begin
      wr_fld_covg = new();
      rd_fld_covg = new();
    end
  endfunction

endclass


/////////////////////////////////////////////////////
//                cmn_pllsm1_tmr_8
/////////////////////////////////////////////////////
class T_cmn_pllsm1_tmr_8_1019 extends cdns_uvm_reg;

  `uvm_object_utils(T_cmn_pllsm1_tmr_8_1019)
  rand uvm_reg_field cmn_pllsm1_tmr_8_15_0;
  rand uvm_reg_field cmn_pllsm1_tmr_8_31_16;
  
  covergroup wr_fld_covg;
    cmn_pllsm1_tmr_8_15_0: coverpoint cmn_pllsm1_tmr_8_15_0.value[15:0];
    cmn_pllsm1_tmr_8_31_16: coverpoint cmn_pllsm1_tmr_8_31_16.value[15:0];
  endgroup
  covergroup rd_fld_covg;
    cmn_pllsm1_tmr_8_15_0: coverpoint cmn_pllsm1_tmr_8_15_0.value[15:0];
    cmn_pllsm1_tmr_8_31_16: coverpoint cmn_pllsm1_tmr_8_31_16.value[15:0];
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
    
    cmn_pllsm1_tmr_8_15_0 = fld_set[0];
    cmn_pllsm1_tmr_8_31_16 = fld_set[1];
  endfunction

  function new(input string name="T_cmn_pllsm1_tmr_8_1019");
    super.new(name, 32, build_coverage(UVM_CVR_FIELD_VALS));
    if (has_coverage(UVM_CVR_FIELD_VALS)) begin
      wr_fld_covg = new();
      rd_fld_covg = new();
    end
  endfunction

endclass


/////////////////////////////////////////////////////
//                cmn_rxcal_ctrl
/////////////////////////////////////////////////////
class T_cmn_rxcal_ctrl_1108 extends cdns_uvm_reg;

  `uvm_object_utils(T_cmn_rxcal_ctrl_1108)
  rand uvm_reg_field cmn_rxcal_ctrl_5_0;
  rand uvm_reg_field cmn_rxcal_ctrl_11_6;
  rand uvm_reg_field cmn_rxcal_ctrl_12;
  rand uvm_reg_field cmn_rxcal_ctrl_13;
  rand uvm_reg_field cmn_rxcal_ctrl_14;
  rand uvm_reg_field cmn_rxcal_ctrl_15;
  rand uvm_reg_field cmn_rxcal_ctrl_31_16;
  
  covergroup wr_fld_covg;
    cmn_rxcal_ctrl_5_0: coverpoint cmn_rxcal_ctrl_5_0.value[5:0];
    cmn_rxcal_ctrl_11_6: coverpoint cmn_rxcal_ctrl_11_6.value[5:0];
    cmn_rxcal_ctrl_12: coverpoint cmn_rxcal_ctrl_12.value[0:0];
    cmn_rxcal_ctrl_13: coverpoint cmn_rxcal_ctrl_13.value[0:0];
    cmn_rxcal_ctrl_14: coverpoint cmn_rxcal_ctrl_14.value[0:0];
    cmn_rxcal_ctrl_15: coverpoint cmn_rxcal_ctrl_15.value[0:0];
    cmn_rxcal_ctrl_31_16: coverpoint cmn_rxcal_ctrl_31_16.value[15:0];
  endgroup
  covergroup rd_fld_covg;
    cmn_rxcal_ctrl_5_0: coverpoint cmn_rxcal_ctrl_5_0.value[5:0];
    cmn_rxcal_ctrl_11_6: coverpoint cmn_rxcal_ctrl_11_6.value[5:0];
    cmn_rxcal_ctrl_12: coverpoint cmn_rxcal_ctrl_12.value[0:0];
    cmn_rxcal_ctrl_13: coverpoint cmn_rxcal_ctrl_13.value[0:0];
    cmn_rxcal_ctrl_14: coverpoint cmn_rxcal_ctrl_14.value[0:0];
    cmn_rxcal_ctrl_15: coverpoint cmn_rxcal_ctrl_15.value[0:0];
    cmn_rxcal_ctrl_31_16: coverpoint cmn_rxcal_ctrl_31_16.value[15:0];
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
    
    cmn_rxcal_ctrl_5_0 = fld_set[0];
    cmn_rxcal_ctrl_11_6 = fld_set[1];
    cmn_rxcal_ctrl_12 = fld_set[2];
    cmn_rxcal_ctrl_13 = fld_set[3];
    cmn_rxcal_ctrl_14 = fld_set[4];
    cmn_rxcal_ctrl_15 = fld_set[5];
    cmn_rxcal_ctrl_31_16 = fld_set[6];
  endfunction

  function new(input string name="T_cmn_rxcal_ctrl_1108");
    super.new(name, 32, build_coverage(UVM_CVR_FIELD_VALS));
    if (has_coverage(UVM_CVR_FIELD_VALS)) begin
      wr_fld_covg = new();
      rd_fld_covg = new();
    end
  endfunction

endclass


/////////////////////////////////////////////////////
//                cmn_rxcal_init_tmr
/////////////////////////////////////////////////////
class T_cmn_rxcal_init_tmr_1112 extends cdns_uvm_reg;

  `uvm_object_utils(T_cmn_rxcal_init_tmr_1112)
  rand uvm_reg_field cmn_rxcal_init_tmr_11_0;
  rand uvm_reg_field cmn_rxcal_init_tmr_15_12;
  rand uvm_reg_field cmn_rxcal_init_tmr_31_16;
  
  covergroup wr_fld_covg;
    cmn_rxcal_init_tmr_11_0: coverpoint cmn_rxcal_init_tmr_11_0.value[11:0];
    cmn_rxcal_init_tmr_15_12: coverpoint cmn_rxcal_init_tmr_15_12.value[3:0];
    cmn_rxcal_init_tmr_31_16: coverpoint cmn_rxcal_init_tmr_31_16.value[15:0];
  endgroup
  covergroup rd_fld_covg;
    cmn_rxcal_init_tmr_11_0: coverpoint cmn_rxcal_init_tmr_11_0.value[11:0];
    cmn_rxcal_init_tmr_15_12: coverpoint cmn_rxcal_init_tmr_15_12.value[3:0];
    cmn_rxcal_init_tmr_31_16: coverpoint cmn_rxcal_init_tmr_31_16.value[15:0];
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
    
    cmn_rxcal_init_tmr_11_0 = fld_set[0];
    cmn_rxcal_init_tmr_15_12 = fld_set[1];
    cmn_rxcal_init_tmr_31_16 = fld_set[2];
  endfunction

  function new(input string name="T_cmn_rxcal_init_tmr_1112");
    super.new(name, 32, build_coverage(UVM_CVR_FIELD_VALS));
    if (has_coverage(UVM_CVR_FIELD_VALS)) begin
      wr_fld_covg = new();
      rd_fld_covg = new();
    end
  endfunction

endclass


/////////////////////////////////////////////////////
//                cmn_rxcal_iter_tmr
/////////////////////////////////////////////////////
class T_cmn_rxcal_iter_tmr_1113 extends cdns_uvm_reg;

  `uvm_object_utils(T_cmn_rxcal_iter_tmr_1113)
  rand uvm_reg_field cmn_rxcal_iter_tmr_11_0;
  rand uvm_reg_field cmn_rxcal_iter_tmr_15_12;
  rand uvm_reg_field cmn_rxcal_iter_tmr_31_16;
  
  covergroup wr_fld_covg;
    cmn_rxcal_iter_tmr_11_0: coverpoint cmn_rxcal_iter_tmr_11_0.value[11:0];
    cmn_rxcal_iter_tmr_15_12: coverpoint cmn_rxcal_iter_tmr_15_12.value[3:0];
    cmn_rxcal_iter_tmr_31_16: coverpoint cmn_rxcal_iter_tmr_31_16.value[15:0];
  endgroup
  covergroup rd_fld_covg;
    cmn_rxcal_iter_tmr_11_0: coverpoint cmn_rxcal_iter_tmr_11_0.value[11:0];
    cmn_rxcal_iter_tmr_15_12: coverpoint cmn_rxcal_iter_tmr_15_12.value[3:0];
    cmn_rxcal_iter_tmr_31_16: coverpoint cmn_rxcal_iter_tmr_31_16.value[15:0];
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
    
    cmn_rxcal_iter_tmr_11_0 = fld_set[0];
    cmn_rxcal_iter_tmr_15_12 = fld_set[1];
    cmn_rxcal_iter_tmr_31_16 = fld_set[2];
  endfunction

  function new(input string name="T_cmn_rxcal_iter_tmr_1113");
    super.new(name, 32, build_coverage(UVM_CVR_FIELD_VALS));
    if (has_coverage(UVM_CVR_FIELD_VALS)) begin
      wr_fld_covg = new();
      rd_fld_covg = new();
    end
  endfunction

endclass


/////////////////////////////////////////////////////
//                cmn_rxcal_ovrd
/////////////////////////////////////////////////////
class T_cmn_rxcal_ovrd_1109 extends cdns_uvm_reg;

  `uvm_object_utils(T_cmn_rxcal_ovrd_1109)
  rand uvm_reg_field cmn_rxcal_ovrd_5_0;
  rand uvm_reg_field cmn_rxcal_ovrd_13_6;
  rand uvm_reg_field cmn_rxcal_ovrd_14;
  rand uvm_reg_field cmn_rxcal_ovrd_15;
  rand uvm_reg_field cmn_rxcal_ovrd_31_16;
  
  covergroup wr_fld_covg;
    cmn_rxcal_ovrd_5_0: coverpoint cmn_rxcal_ovrd_5_0.value[5:0];
    cmn_rxcal_ovrd_13_6: coverpoint cmn_rxcal_ovrd_13_6.value[7:0];
    cmn_rxcal_ovrd_14: coverpoint cmn_rxcal_ovrd_14.value[0:0];
    cmn_rxcal_ovrd_15: coverpoint cmn_rxcal_ovrd_15.value[0:0];
    cmn_rxcal_ovrd_31_16: coverpoint cmn_rxcal_ovrd_31_16.value[15:0];
  endgroup
  covergroup rd_fld_covg;
    cmn_rxcal_ovrd_5_0: coverpoint cmn_rxcal_ovrd_5_0.value[5:0];
    cmn_rxcal_ovrd_13_6: coverpoint cmn_rxcal_ovrd_13_6.value[7:0];
    cmn_rxcal_ovrd_14: coverpoint cmn_rxcal_ovrd_14.value[0:0];
    cmn_rxcal_ovrd_15: coverpoint cmn_rxcal_ovrd_15.value[0:0];
    cmn_rxcal_ovrd_31_16: coverpoint cmn_rxcal_ovrd_31_16.value[15:0];
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
    
    cmn_rxcal_ovrd_5_0 = fld_set[0];
    cmn_rxcal_ovrd_13_6 = fld_set[1];
    cmn_rxcal_ovrd_14 = fld_set[2];
    cmn_rxcal_ovrd_15 = fld_set[3];
    cmn_rxcal_ovrd_31_16 = fld_set[4];
  endfunction

  function new(input string name="T_cmn_rxcal_ovrd_1109");
    super.new(name, 32, build_coverage(UVM_CVR_FIELD_VALS));
    if (has_coverage(UVM_CVR_FIELD_VALS)) begin
      wr_fld_covg = new();
      rd_fld_covg = new();
    end
  endfunction

endclass


/////////////////////////////////////////////////////
//                cmn_rxcal_start
/////////////////////////////////////////////////////
class T_cmn_rxcal_start_1110 extends cdns_uvm_reg;

  `uvm_object_utils(T_cmn_rxcal_start_1110)
  rand uvm_reg_field cmn_rxcal_start_5_0;
  rand uvm_reg_field cmn_rxcal_start_14_6;
  rand uvm_reg_field cmn_rxcal_start_15;
  rand uvm_reg_field cmn_rxcal_start_31_16;
  
  covergroup wr_fld_covg;
    cmn_rxcal_start_5_0: coverpoint cmn_rxcal_start_5_0.value[5:0];
    cmn_rxcal_start_14_6: coverpoint cmn_rxcal_start_14_6.value[8:0];
    cmn_rxcal_start_15: coverpoint cmn_rxcal_start_15.value[0:0];
    cmn_rxcal_start_31_16: coverpoint cmn_rxcal_start_31_16.value[15:0];
  endgroup
  covergroup rd_fld_covg;
    cmn_rxcal_start_5_0: coverpoint cmn_rxcal_start_5_0.value[5:0];
    cmn_rxcal_start_14_6: coverpoint cmn_rxcal_start_14_6.value[8:0];
    cmn_rxcal_start_15: coverpoint cmn_rxcal_start_15.value[0:0];
    cmn_rxcal_start_31_16: coverpoint cmn_rxcal_start_31_16.value[15:0];
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
    
    cmn_rxcal_start_5_0 = fld_set[0];
    cmn_rxcal_start_14_6 = fld_set[1];
    cmn_rxcal_start_15 = fld_set[2];
    cmn_rxcal_start_31_16 = fld_set[3];
  endfunction

  function new(input string name="T_cmn_rxcal_start_1110");
    super.new(name, 32, build_coverage(UVM_CVR_FIELD_VALS));
    if (has_coverage(UVM_CVR_FIELD_VALS)) begin
      wr_fld_covg = new();
      rd_fld_covg = new();
    end
  endfunction

endclass


/////////////////////////////////////////////////////
//                cmn_rxcal_tune
/////////////////////////////////////////////////////
class T_cmn_rxcal_tune_1111 extends cdns_uvm_reg;

  `uvm_object_utils(T_cmn_rxcal_tune_1111)
  rand uvm_reg_field cmn_rxcal_tune_5_0;
  rand uvm_reg_field cmn_rxcal_tune_15_6;
  rand uvm_reg_field cmn_rxcal_tune_31_16;
  
  covergroup wr_fld_covg;
    cmn_rxcal_tune_5_0: coverpoint cmn_rxcal_tune_5_0.value[5:0];
    cmn_rxcal_tune_15_6: coverpoint cmn_rxcal_tune_15_6.value[9:0];
    cmn_rxcal_tune_31_16: coverpoint cmn_rxcal_tune_31_16.value[15:0];
  endgroup
  covergroup rd_fld_covg;
    cmn_rxcal_tune_5_0: coverpoint cmn_rxcal_tune_5_0.value[5:0];
    cmn_rxcal_tune_15_6: coverpoint cmn_rxcal_tune_15_6.value[9:0];
    cmn_rxcal_tune_31_16: coverpoint cmn_rxcal_tune_31_16.value[15:0];
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
    
    cmn_rxcal_tune_5_0 = fld_set[0];
    cmn_rxcal_tune_15_6 = fld_set[1];
    cmn_rxcal_tune_31_16 = fld_set[2];
  endfunction

  function new(input string name="T_cmn_rxcal_tune_1111");
    super.new(name, 32, build_coverage(UVM_CVR_FIELD_VALS));
    if (has_coverage(UVM_CVR_FIELD_VALS)) begin
      wr_fld_covg = new();
      rd_fld_covg = new();
    end
  endfunction

endclass


/////////////////////////////////////////////////////
//                cmn_sd_cal_ctrl
/////////////////////////////////////////////////////
class T_cmn_sd_cal_ctrl_1114 extends cdns_uvm_reg;

  `uvm_object_utils(T_cmn_sd_cal_ctrl_1114)
  rand uvm_reg_field cmn_sd_cal_ctrl_4_0;
  rand uvm_reg_field cmn_sd_cal_ctrl_13_5;
  rand uvm_reg_field cmn_sd_cal_ctrl_14;
  rand uvm_reg_field cmn_sd_cal_ctrl_15;
  rand uvm_reg_field cmn_sd_cal_ctrl_31_16;
  
  covergroup wr_fld_covg;
    cmn_sd_cal_ctrl_4_0: coverpoint cmn_sd_cal_ctrl_4_0.value[4:0];
    cmn_sd_cal_ctrl_13_5: coverpoint cmn_sd_cal_ctrl_13_5.value[8:0];
    cmn_sd_cal_ctrl_14: coverpoint cmn_sd_cal_ctrl_14.value[0:0];
    cmn_sd_cal_ctrl_15: coverpoint cmn_sd_cal_ctrl_15.value[0:0];
    cmn_sd_cal_ctrl_31_16: coverpoint cmn_sd_cal_ctrl_31_16.value[15:0];
  endgroup
  covergroup rd_fld_covg;
    cmn_sd_cal_ctrl_4_0: coverpoint cmn_sd_cal_ctrl_4_0.value[4:0];
    cmn_sd_cal_ctrl_13_5: coverpoint cmn_sd_cal_ctrl_13_5.value[8:0];
    cmn_sd_cal_ctrl_14: coverpoint cmn_sd_cal_ctrl_14.value[0:0];
    cmn_sd_cal_ctrl_15: coverpoint cmn_sd_cal_ctrl_15.value[0:0];
    cmn_sd_cal_ctrl_31_16: coverpoint cmn_sd_cal_ctrl_31_16.value[15:0];
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
    
    cmn_sd_cal_ctrl_4_0 = fld_set[0];
    cmn_sd_cal_ctrl_13_5 = fld_set[1];
    cmn_sd_cal_ctrl_14 = fld_set[2];
    cmn_sd_cal_ctrl_15 = fld_set[3];
    cmn_sd_cal_ctrl_31_16 = fld_set[4];
  endfunction

  function new(input string name="T_cmn_sd_cal_ctrl_1114");
    super.new(name, 32, build_coverage(UVM_CVR_FIELD_VALS));
    if (has_coverage(UVM_CVR_FIELD_VALS)) begin
      wr_fld_covg = new();
      rd_fld_covg = new();
    end
  endfunction

endclass


/////////////////////////////////////////////////////
//                cmn_sd_cal_init_tmr
/////////////////////////////////////////////////////
class T_cmn_sd_cal_init_tmr_1118 extends cdns_uvm_reg;

  `uvm_object_utils(T_cmn_sd_cal_init_tmr_1118)
  rand uvm_reg_field cmn_sd_cal_init_tmr_7_0;
  rand uvm_reg_field cmn_sd_cal_init_tmr_15_8;
  rand uvm_reg_field cmn_sd_cal_init_tmr_31_16;
  
  covergroup wr_fld_covg;
    cmn_sd_cal_init_tmr_7_0: coverpoint cmn_sd_cal_init_tmr_7_0.value[7:0];
    cmn_sd_cal_init_tmr_15_8: coverpoint cmn_sd_cal_init_tmr_15_8.value[7:0];
    cmn_sd_cal_init_tmr_31_16: coverpoint cmn_sd_cal_init_tmr_31_16.value[15:0];
  endgroup
  covergroup rd_fld_covg;
    cmn_sd_cal_init_tmr_7_0: coverpoint cmn_sd_cal_init_tmr_7_0.value[7:0];
    cmn_sd_cal_init_tmr_15_8: coverpoint cmn_sd_cal_init_tmr_15_8.value[7:0];
    cmn_sd_cal_init_tmr_31_16: coverpoint cmn_sd_cal_init_tmr_31_16.value[15:0];
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
    
    cmn_sd_cal_init_tmr_7_0 = fld_set[0];
    cmn_sd_cal_init_tmr_15_8 = fld_set[1];
    cmn_sd_cal_init_tmr_31_16 = fld_set[2];
  endfunction

  function new(input string name="T_cmn_sd_cal_init_tmr_1118");
    super.new(name, 32, build_coverage(UVM_CVR_FIELD_VALS));
    if (has_coverage(UVM_CVR_FIELD_VALS)) begin
      wr_fld_covg = new();
      rd_fld_covg = new();
    end
  endfunction

endclass


/////////////////////////////////////////////////////
//                cmn_sd_cal_iter_tmr
/////////////////////////////////////////////////////
class T_cmn_sd_cal_iter_tmr_1119 extends cdns_uvm_reg;

  `uvm_object_utils(T_cmn_sd_cal_iter_tmr_1119)
  rand uvm_reg_field cmn_sd_cal_iter_tmr_7_0;
  rand uvm_reg_field cmn_sd_cal_iter_tmr_15_8;
  rand uvm_reg_field cmn_sd_cal_iter_tmr_31_16;
  
  covergroup wr_fld_covg;
    cmn_sd_cal_iter_tmr_7_0: coverpoint cmn_sd_cal_iter_tmr_7_0.value[7:0];
    cmn_sd_cal_iter_tmr_15_8: coverpoint cmn_sd_cal_iter_tmr_15_8.value[7:0];
    cmn_sd_cal_iter_tmr_31_16: coverpoint cmn_sd_cal_iter_tmr_31_16.value[15:0];
  endgroup
  covergroup rd_fld_covg;
    cmn_sd_cal_iter_tmr_7_0: coverpoint cmn_sd_cal_iter_tmr_7_0.value[7:0];
    cmn_sd_cal_iter_tmr_15_8: coverpoint cmn_sd_cal_iter_tmr_15_8.value[7:0];
    cmn_sd_cal_iter_tmr_31_16: coverpoint cmn_sd_cal_iter_tmr_31_16.value[15:0];
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
    
    cmn_sd_cal_iter_tmr_7_0 = fld_set[0];
    cmn_sd_cal_iter_tmr_15_8 = fld_set[1];
    cmn_sd_cal_iter_tmr_31_16 = fld_set[2];
  endfunction

  function new(input string name="T_cmn_sd_cal_iter_tmr_1119");
    super.new(name, 32, build_coverage(UVM_CVR_FIELD_VALS));
    if (has_coverage(UVM_CVR_FIELD_VALS)) begin
      wr_fld_covg = new();
      rd_fld_covg = new();
    end
  endfunction

endclass


/////////////////////////////////////////////////////
//                cmn_sd_cal_ovrd
/////////////////////////////////////////////////////
class T_cmn_sd_cal_ovrd_1117 extends cdns_uvm_reg;

  `uvm_object_utils(T_cmn_sd_cal_ovrd_1117)
  rand uvm_reg_field cmn_sd_cal_ovrd_4_0;
  rand uvm_reg_field cmn_sd_cal_ovrd_14_5;
  rand uvm_reg_field cmn_sd_cal_ovrd_15;
  rand uvm_reg_field cmn_sd_cal_ovrd_31_16;
  
  covergroup wr_fld_covg;
    cmn_sd_cal_ovrd_4_0: coverpoint cmn_sd_cal_ovrd_4_0.value[4:0];
    cmn_sd_cal_ovrd_14_5: coverpoint cmn_sd_cal_ovrd_14_5.value[9:0];
    cmn_sd_cal_ovrd_15: coverpoint cmn_sd_cal_ovrd_15.value[0:0];
    cmn_sd_cal_ovrd_31_16: coverpoint cmn_sd_cal_ovrd_31_16.value[15:0];
  endgroup
  covergroup rd_fld_covg;
    cmn_sd_cal_ovrd_4_0: coverpoint cmn_sd_cal_ovrd_4_0.value[4:0];
    cmn_sd_cal_ovrd_14_5: coverpoint cmn_sd_cal_ovrd_14_5.value[9:0];
    cmn_sd_cal_ovrd_15: coverpoint cmn_sd_cal_ovrd_15.value[0:0];
    cmn_sd_cal_ovrd_31_16: coverpoint cmn_sd_cal_ovrd_31_16.value[15:0];
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
    
    cmn_sd_cal_ovrd_4_0 = fld_set[0];
    cmn_sd_cal_ovrd_14_5 = fld_set[1];
    cmn_sd_cal_ovrd_15 = fld_set[2];
    cmn_sd_cal_ovrd_31_16 = fld_set[3];
  endfunction

  function new(input string name="T_cmn_sd_cal_ovrd_1117");
    super.new(name, 32, build_coverage(UVM_CVR_FIELD_VALS));
    if (has_coverage(UVM_CVR_FIELD_VALS)) begin
      wr_fld_covg = new();
      rd_fld_covg = new();
    end
  endfunction

endclass


/////////////////////////////////////////////////////
//                cmn_sd_cal_pllcnt_start
/////////////////////////////////////////////////////
class T_cmn_sd_cal_pllcnt_start_1121 extends cdns_uvm_reg;

  `uvm_object_utils(T_cmn_sd_cal_pllcnt_start_1121)
  rand uvm_reg_field cmn_sd_cal_pllcnt_start_9_0;
  rand uvm_reg_field cmn_sd_cal_pllcnt_start_15_10;
  rand uvm_reg_field cmn_sd_cal_pllcnt_start_31_16;
  
  covergroup wr_fld_covg;
    cmn_sd_cal_pllcnt_start_9_0: coverpoint cmn_sd_cal_pllcnt_start_9_0.value[9:0];
    cmn_sd_cal_pllcnt_start_15_10: coverpoint cmn_sd_cal_pllcnt_start_15_10.value[5:0];
    cmn_sd_cal_pllcnt_start_31_16: coverpoint cmn_sd_cal_pllcnt_start_31_16.value[15:0];
  endgroup
  covergroup rd_fld_covg;
    cmn_sd_cal_pllcnt_start_9_0: coverpoint cmn_sd_cal_pllcnt_start_9_0.value[9:0];
    cmn_sd_cal_pllcnt_start_15_10: coverpoint cmn_sd_cal_pllcnt_start_15_10.value[5:0];
    cmn_sd_cal_pllcnt_start_31_16: coverpoint cmn_sd_cal_pllcnt_start_31_16.value[15:0];
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
    
    cmn_sd_cal_pllcnt_start_9_0 = fld_set[0];
    cmn_sd_cal_pllcnt_start_15_10 = fld_set[1];
    cmn_sd_cal_pllcnt_start_31_16 = fld_set[2];
  endfunction

  function new(input string name="T_cmn_sd_cal_pllcnt_start_1121");
    super.new(name, 32, build_coverage(UVM_CVR_FIELD_VALS));
    if (has_coverage(UVM_CVR_FIELD_VALS)) begin
      wr_fld_covg = new();
      rd_fld_covg = new();
    end
  endfunction

endclass


/////////////////////////////////////////////////////
//                cmn_sd_cal_reftim_start
/////////////////////////////////////////////////////
class T_cmn_sd_cal_reftim_start_1120 extends cdns_uvm_reg;

  `uvm_object_utils(T_cmn_sd_cal_reftim_start_1120)
  rand uvm_reg_field cmn_sd_cal_reftim_start_7_0;
  rand uvm_reg_field cmn_sd_cal_reftim_start_15_8;
  rand uvm_reg_field cmn_sd_cal_reftim_start_31_16;
  
  covergroup wr_fld_covg;
    cmn_sd_cal_reftim_start_7_0: coverpoint cmn_sd_cal_reftim_start_7_0.value[7:0];
    cmn_sd_cal_reftim_start_15_8: coverpoint cmn_sd_cal_reftim_start_15_8.value[7:0];
    cmn_sd_cal_reftim_start_31_16: coverpoint cmn_sd_cal_reftim_start_31_16.value[15:0];
  endgroup
  covergroup rd_fld_covg;
    cmn_sd_cal_reftim_start_7_0: coverpoint cmn_sd_cal_reftim_start_7_0.value[7:0];
    cmn_sd_cal_reftim_start_15_8: coverpoint cmn_sd_cal_reftim_start_15_8.value[7:0];
    cmn_sd_cal_reftim_start_31_16: coverpoint cmn_sd_cal_reftim_start_31_16.value[15:0];
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
    
    cmn_sd_cal_reftim_start_7_0 = fld_set[0];
    cmn_sd_cal_reftim_start_15_8 = fld_set[1];
    cmn_sd_cal_reftim_start_31_16 = fld_set[2];
  endfunction

  function new(input string name="T_cmn_sd_cal_reftim_start_1120");
    super.new(name, 32, build_coverage(UVM_CVR_FIELD_VALS));
    if (has_coverage(UVM_CVR_FIELD_VALS)) begin
      wr_fld_covg = new();
      rd_fld_covg = new();
    end
  endfunction

endclass


/////////////////////////////////////////////////////
//                cmn_sd_cal_start
/////////////////////////////////////////////////////
class T_cmn_sd_cal_start_1115 extends cdns_uvm_reg;

  `uvm_object_utils(T_cmn_sd_cal_start_1115)
  rand uvm_reg_field cmn_sd_cal_start_4_0;
  rand uvm_reg_field cmn_sd_cal_start_11_5;
  rand uvm_reg_field cmn_sd_cal_start_14_12;
  rand uvm_reg_field cmn_sd_cal_start_15;
  rand uvm_reg_field cmn_sd_cal_start_31_16;
  
  covergroup wr_fld_covg;
    cmn_sd_cal_start_4_0: coverpoint cmn_sd_cal_start_4_0.value[4:0];
    cmn_sd_cal_start_11_5: coverpoint cmn_sd_cal_start_11_5.value[6:0];
    cmn_sd_cal_start_14_12: coverpoint cmn_sd_cal_start_14_12.value[2:0];
    cmn_sd_cal_start_15: coverpoint cmn_sd_cal_start_15.value[0:0];
    cmn_sd_cal_start_31_16: coverpoint cmn_sd_cal_start_31_16.value[15:0];
  endgroup
  covergroup rd_fld_covg;
    cmn_sd_cal_start_4_0: coverpoint cmn_sd_cal_start_4_0.value[4:0];
    cmn_sd_cal_start_11_5: coverpoint cmn_sd_cal_start_11_5.value[6:0];
    cmn_sd_cal_start_14_12: coverpoint cmn_sd_cal_start_14_12.value[2:0];
    cmn_sd_cal_start_15: coverpoint cmn_sd_cal_start_15.value[0:0];
    cmn_sd_cal_start_31_16: coverpoint cmn_sd_cal_start_31_16.value[15:0];
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
    
    cmn_sd_cal_start_4_0 = fld_set[0];
    cmn_sd_cal_start_11_5 = fld_set[1];
    cmn_sd_cal_start_14_12 = fld_set[2];
    cmn_sd_cal_start_15 = fld_set[3];
    cmn_sd_cal_start_31_16 = fld_set[4];
  endfunction

  function new(input string name="T_cmn_sd_cal_start_1115");
    super.new(name, 32, build_coverage(UVM_CVR_FIELD_VALS));
    if (has_coverage(UVM_CVR_FIELD_VALS)) begin
      wr_fld_covg = new();
      rd_fld_covg = new();
    end
  endfunction

endclass


/////////////////////////////////////////////////////
//                cmn_sd_cal_tctrl
/////////////////////////////////////////////////////
class T_cmn_sd_cal_tctrl_1116 extends cdns_uvm_reg;

  `uvm_object_utils(T_cmn_sd_cal_tctrl_1116)
  rand uvm_reg_field cmn_sd_cal_tctrl_2_0;
  rand uvm_reg_field cmn_sd_cal_tctrl_15_3;
  rand uvm_reg_field cmn_sd_cal_tctrl_31_16;
  
  covergroup wr_fld_covg;
    cmn_sd_cal_tctrl_2_0: coverpoint cmn_sd_cal_tctrl_2_0.value[2:0];
    cmn_sd_cal_tctrl_15_3: coverpoint cmn_sd_cal_tctrl_15_3.value[12:0];
    cmn_sd_cal_tctrl_31_16: coverpoint cmn_sd_cal_tctrl_31_16.value[15:0];
  endgroup
  covergroup rd_fld_covg;
    cmn_sd_cal_tctrl_2_0: coverpoint cmn_sd_cal_tctrl_2_0.value[2:0];
    cmn_sd_cal_tctrl_15_3: coverpoint cmn_sd_cal_tctrl_15_3.value[12:0];
    cmn_sd_cal_tctrl_31_16: coverpoint cmn_sd_cal_tctrl_31_16.value[15:0];
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
    
    cmn_sd_cal_tctrl_2_0 = fld_set[0];
    cmn_sd_cal_tctrl_15_3 = fld_set[1];
    cmn_sd_cal_tctrl_31_16 = fld_set[2];
  endfunction

  function new(input string name="T_cmn_sd_cal_tctrl_1116");
    super.new(name, 32, build_coverage(UVM_CVR_FIELD_VALS));
    if (has_coverage(UVM_CVR_FIELD_VALS)) begin
      wr_fld_covg = new();
      rd_fld_covg = new();
    end
  endfunction

endclass


/////////////////////////////////////////////////////
//                cmn_ssm_sm_ctrl
/////////////////////////////////////////////////////
class T_cmn_ssm_sm_ctrl_1000 extends cdns_uvm_reg;

  `uvm_object_utils(T_cmn_ssm_sm_ctrl_1000)
  rand uvm_reg_field cmn_ssm_sm_ctrl_0;
  rand uvm_reg_field cmn_ssm_sm_ctrl_1;
  rand uvm_reg_field cmn_ssm_sm_ctrl_3_2;
  rand uvm_reg_field cmn_ssm_sm_ctrl_4;
  rand uvm_reg_field cmn_ssm_sm_ctrl_5;
  rand uvm_reg_field cmn_ssm_sm_ctrl_6;
  rand uvm_reg_field cmn_ssm_sm_ctrl_7;
  rand uvm_reg_field cmn_ssm_sm_ctrl_8;
  rand uvm_reg_field cmn_ssm_sm_ctrl_9;
  rand uvm_reg_field cmn_ssm_sm_ctrl_10;
  rand uvm_reg_field cmn_ssm_sm_ctrl_11;
  rand uvm_reg_field cmn_ssm_sm_ctrl_15_12;
  rand uvm_reg_field cmn_ssm_sm_ctrl_16;
  rand uvm_reg_field cmn_ssm_sm_ctrl_17;
  rand uvm_reg_field cmn_ssm_sm_ctrl_23_18;
  rand uvm_reg_field cmn_ssm_sm_ctrl_24;
  rand uvm_reg_field cmn_ssm_sm_ctrl_25;
  rand uvm_reg_field cmn_ssm_sm_ctrl_26;
  rand uvm_reg_field cmn_ssm_sm_ctrl_27;
  rand uvm_reg_field cmn_ssm_sm_ctrl_28;
  rand uvm_reg_field cmn_ssm_sm_ctrl_29;
  rand uvm_reg_field cmn_ssm_sm_ctrl_30;
  rand uvm_reg_field cmn_ssm_sm_ctrl_31;
  
  covergroup wr_fld_covg;
    cmn_ssm_sm_ctrl_0: coverpoint cmn_ssm_sm_ctrl_0.value[0:0];
    cmn_ssm_sm_ctrl_1: coverpoint cmn_ssm_sm_ctrl_1.value[0:0];
    cmn_ssm_sm_ctrl_3_2: coverpoint cmn_ssm_sm_ctrl_3_2.value[1:0];
    cmn_ssm_sm_ctrl_4: coverpoint cmn_ssm_sm_ctrl_4.value[0:0];
    cmn_ssm_sm_ctrl_5: coverpoint cmn_ssm_sm_ctrl_5.value[0:0];
    cmn_ssm_sm_ctrl_6: coverpoint cmn_ssm_sm_ctrl_6.value[0:0];
    cmn_ssm_sm_ctrl_7: coverpoint cmn_ssm_sm_ctrl_7.value[0:0];
    cmn_ssm_sm_ctrl_8: coverpoint cmn_ssm_sm_ctrl_8.value[0:0];
    cmn_ssm_sm_ctrl_9: coverpoint cmn_ssm_sm_ctrl_9.value[0:0];
    cmn_ssm_sm_ctrl_10: coverpoint cmn_ssm_sm_ctrl_10.value[0:0];
    cmn_ssm_sm_ctrl_11: coverpoint cmn_ssm_sm_ctrl_11.value[0:0];
    cmn_ssm_sm_ctrl_15_12: coverpoint cmn_ssm_sm_ctrl_15_12.value[3:0];
    cmn_ssm_sm_ctrl_16: coverpoint cmn_ssm_sm_ctrl_16.value[0:0];
    cmn_ssm_sm_ctrl_17: coverpoint cmn_ssm_sm_ctrl_17.value[0:0];
    cmn_ssm_sm_ctrl_23_18: coverpoint cmn_ssm_sm_ctrl_23_18.value[5:0];
    cmn_ssm_sm_ctrl_24: coverpoint cmn_ssm_sm_ctrl_24.value[0:0];
    cmn_ssm_sm_ctrl_25: coverpoint cmn_ssm_sm_ctrl_25.value[0:0];
    cmn_ssm_sm_ctrl_26: coverpoint cmn_ssm_sm_ctrl_26.value[0:0];
    cmn_ssm_sm_ctrl_27: coverpoint cmn_ssm_sm_ctrl_27.value[0:0];
    cmn_ssm_sm_ctrl_28: coverpoint cmn_ssm_sm_ctrl_28.value[0:0];
    cmn_ssm_sm_ctrl_29: coverpoint cmn_ssm_sm_ctrl_29.value[0:0];
    cmn_ssm_sm_ctrl_30: coverpoint cmn_ssm_sm_ctrl_30.value[0:0];
    cmn_ssm_sm_ctrl_31: coverpoint cmn_ssm_sm_ctrl_31.value[0:0];
  endgroup
  covergroup rd_fld_covg;
    cmn_ssm_sm_ctrl_0: coverpoint cmn_ssm_sm_ctrl_0.value[0:0];
    cmn_ssm_sm_ctrl_1: coverpoint cmn_ssm_sm_ctrl_1.value[0:0];
    cmn_ssm_sm_ctrl_3_2: coverpoint cmn_ssm_sm_ctrl_3_2.value[1:0];
    cmn_ssm_sm_ctrl_4: coverpoint cmn_ssm_sm_ctrl_4.value[0:0];
    cmn_ssm_sm_ctrl_5: coverpoint cmn_ssm_sm_ctrl_5.value[0:0];
    cmn_ssm_sm_ctrl_6: coverpoint cmn_ssm_sm_ctrl_6.value[0:0];
    cmn_ssm_sm_ctrl_7: coverpoint cmn_ssm_sm_ctrl_7.value[0:0];
    cmn_ssm_sm_ctrl_8: coverpoint cmn_ssm_sm_ctrl_8.value[0:0];
    cmn_ssm_sm_ctrl_9: coverpoint cmn_ssm_sm_ctrl_9.value[0:0];
    cmn_ssm_sm_ctrl_10: coverpoint cmn_ssm_sm_ctrl_10.value[0:0];
    cmn_ssm_sm_ctrl_11: coverpoint cmn_ssm_sm_ctrl_11.value[0:0];
    cmn_ssm_sm_ctrl_15_12: coverpoint cmn_ssm_sm_ctrl_15_12.value[3:0];
    cmn_ssm_sm_ctrl_16: coverpoint cmn_ssm_sm_ctrl_16.value[0:0];
    cmn_ssm_sm_ctrl_17: coverpoint cmn_ssm_sm_ctrl_17.value[0:0];
    cmn_ssm_sm_ctrl_23_18: coverpoint cmn_ssm_sm_ctrl_23_18.value[5:0];
    cmn_ssm_sm_ctrl_24: coverpoint cmn_ssm_sm_ctrl_24.value[0:0];
    cmn_ssm_sm_ctrl_25: coverpoint cmn_ssm_sm_ctrl_25.value[0:0];
    cmn_ssm_sm_ctrl_26: coverpoint cmn_ssm_sm_ctrl_26.value[0:0];
    cmn_ssm_sm_ctrl_27: coverpoint cmn_ssm_sm_ctrl_27.value[0:0];
    cmn_ssm_sm_ctrl_28: coverpoint cmn_ssm_sm_ctrl_28.value[0:0];
    cmn_ssm_sm_ctrl_29: coverpoint cmn_ssm_sm_ctrl_29.value[0:0];
    cmn_ssm_sm_ctrl_30: coverpoint cmn_ssm_sm_ctrl_30.value[0:0];
    cmn_ssm_sm_ctrl_31: coverpoint cmn_ssm_sm_ctrl_31.value[0:0];
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
    
    cmn_ssm_sm_ctrl_0 = fld_set[0];
    cmn_ssm_sm_ctrl_1 = fld_set[1];
    cmn_ssm_sm_ctrl_3_2 = fld_set[2];
    cmn_ssm_sm_ctrl_4 = fld_set[3];
    cmn_ssm_sm_ctrl_5 = fld_set[4];
    cmn_ssm_sm_ctrl_6 = fld_set[5];
    cmn_ssm_sm_ctrl_7 = fld_set[6];
    cmn_ssm_sm_ctrl_8 = fld_set[7];
    cmn_ssm_sm_ctrl_9 = fld_set[8];
    cmn_ssm_sm_ctrl_10 = fld_set[9];
    cmn_ssm_sm_ctrl_11 = fld_set[10];
    cmn_ssm_sm_ctrl_15_12 = fld_set[11];
    cmn_ssm_sm_ctrl_16 = fld_set[12];
    cmn_ssm_sm_ctrl_17 = fld_set[13];
    cmn_ssm_sm_ctrl_23_18 = fld_set[14];
    cmn_ssm_sm_ctrl_24 = fld_set[15];
    cmn_ssm_sm_ctrl_25 = fld_set[16];
    cmn_ssm_sm_ctrl_26 = fld_set[17];
    cmn_ssm_sm_ctrl_27 = fld_set[18];
    cmn_ssm_sm_ctrl_28 = fld_set[19];
    cmn_ssm_sm_ctrl_29 = fld_set[20];
    cmn_ssm_sm_ctrl_30 = fld_set[21];
    cmn_ssm_sm_ctrl_31 = fld_set[22];
  endfunction

  function new(input string name="T_cmn_ssm_sm_ctrl_1000");
    super.new(name, 32, build_coverage(UVM_CVR_FIELD_VALS));
    if (has_coverage(UVM_CVR_FIELD_VALS)) begin
      wr_fld_covg = new();
      rd_fld_covg = new();
    end
  endfunction

endclass


/////////////////////////////////////////////////////
//                cmn_ssm_st
/////////////////////////////////////////////////////
class T_cmn_ssm_st_1003 extends cdns_uvm_reg;

  `uvm_object_utils(T_cmn_ssm_st_1003)
  rand uvm_reg_field cmn_ssm_st_9_0;
  rand uvm_reg_field cmn_ssm_st_15_10;
  rand uvm_reg_field cmn_ssm_st_31_16;
  
  covergroup wr_fld_covg;
    cmn_ssm_st_9_0: coverpoint cmn_ssm_st_9_0.value[9:0];
    cmn_ssm_st_15_10: coverpoint cmn_ssm_st_15_10.value[5:0];
    cmn_ssm_st_31_16: coverpoint cmn_ssm_st_31_16.value[15:0];
  endgroup
  covergroup rd_fld_covg;
    cmn_ssm_st_9_0: coverpoint cmn_ssm_st_9_0.value[9:0];
    cmn_ssm_st_15_10: coverpoint cmn_ssm_st_15_10.value[5:0];
    cmn_ssm_st_31_16: coverpoint cmn_ssm_st_31_16.value[15:0];
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
    
    cmn_ssm_st_9_0 = fld_set[0];
    cmn_ssm_st_15_10 = fld_set[1];
    cmn_ssm_st_31_16 = fld_set[2];
  endfunction

  function new(input string name="T_cmn_ssm_st_1003");
    super.new(name, 32, build_coverage(UVM_CVR_FIELD_VALS));
    if (has_coverage(UVM_CVR_FIELD_VALS)) begin
      wr_fld_covg = new();
      rd_fld_covg = new();
    end
  endfunction

endclass


/////////////////////////////////////////////////////
//                cmn_ssm_tmr_1
/////////////////////////////////////////////////////
class T_cmn_ssm_tmr_1_1001 extends cdns_uvm_reg;

  `uvm_object_utils(T_cmn_ssm_tmr_1_1001)
  rand uvm_reg_field cmn_ssm_tmr_1_6_0;
  rand uvm_reg_field cmn_ssm_tmr_1_15_7;
  rand uvm_reg_field cmn_ssm_tmr_1_20_16;
  rand uvm_reg_field cmn_ssm_tmr_1_31_21;
  
  covergroup wr_fld_covg;
    cmn_ssm_tmr_1_6_0: coverpoint cmn_ssm_tmr_1_6_0.value[6:0];
    cmn_ssm_tmr_1_15_7: coverpoint cmn_ssm_tmr_1_15_7.value[8:0];
    cmn_ssm_tmr_1_20_16: coverpoint cmn_ssm_tmr_1_20_16.value[4:0];
    cmn_ssm_tmr_1_31_21: coverpoint cmn_ssm_tmr_1_31_21.value[10:0];
  endgroup
  covergroup rd_fld_covg;
    cmn_ssm_tmr_1_6_0: coverpoint cmn_ssm_tmr_1_6_0.value[6:0];
    cmn_ssm_tmr_1_15_7: coverpoint cmn_ssm_tmr_1_15_7.value[8:0];
    cmn_ssm_tmr_1_20_16: coverpoint cmn_ssm_tmr_1_20_16.value[4:0];
    cmn_ssm_tmr_1_31_21: coverpoint cmn_ssm_tmr_1_31_21.value[10:0];
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
    
    cmn_ssm_tmr_1_6_0 = fld_set[0];
    cmn_ssm_tmr_1_15_7 = fld_set[1];
    cmn_ssm_tmr_1_20_16 = fld_set[2];
    cmn_ssm_tmr_1_31_21 = fld_set[3];
  endfunction

  function new(input string name="T_cmn_ssm_tmr_1_1001");
    super.new(name, 32, build_coverage(UVM_CVR_FIELD_VALS));
    if (has_coverage(UVM_CVR_FIELD_VALS)) begin
      wr_fld_covg = new();
      rd_fld_covg = new();
    end
  endfunction

endclass


/////////////////////////////////////////////////////
//                cmn_ssm_tmr_2
/////////////////////////////////////////////////////
class T_cmn_ssm_tmr_2_1002 extends cdns_uvm_reg;

  `uvm_object_utils(T_cmn_ssm_tmr_2_1002)
  rand uvm_reg_field cmn_ssm_tmr_2_3_0;
  rand uvm_reg_field cmn_ssm_tmr_2_15_4;
  rand uvm_reg_field cmn_ssm_tmr_2_19_16;
  rand uvm_reg_field cmn_ssm_tmr_2_31_20;
  
  covergroup wr_fld_covg;
    cmn_ssm_tmr_2_3_0: coverpoint cmn_ssm_tmr_2_3_0.value[3:0];
    cmn_ssm_tmr_2_15_4: coverpoint cmn_ssm_tmr_2_15_4.value[11:0];
    cmn_ssm_tmr_2_19_16: coverpoint cmn_ssm_tmr_2_19_16.value[3:0];
    cmn_ssm_tmr_2_31_20: coverpoint cmn_ssm_tmr_2_31_20.value[11:0];
  endgroup
  covergroup rd_fld_covg;
    cmn_ssm_tmr_2_3_0: coverpoint cmn_ssm_tmr_2_3_0.value[3:0];
    cmn_ssm_tmr_2_15_4: coverpoint cmn_ssm_tmr_2_15_4.value[11:0];
    cmn_ssm_tmr_2_19_16: coverpoint cmn_ssm_tmr_2_19_16.value[3:0];
    cmn_ssm_tmr_2_31_20: coverpoint cmn_ssm_tmr_2_31_20.value[11:0];
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
    
    cmn_ssm_tmr_2_3_0 = fld_set[0];
    cmn_ssm_tmr_2_15_4 = fld_set[1];
    cmn_ssm_tmr_2_19_16 = fld_set[2];
    cmn_ssm_tmr_2_31_20 = fld_set[3];
  endfunction

  function new(input string name="T_cmn_ssm_tmr_2_1002");
    super.new(name, 32, build_coverage(UVM_CVR_FIELD_VALS));
    if (has_coverage(UVM_CVR_FIELD_VALS)) begin
      wr_fld_covg = new();
      rd_fld_covg = new();
    end
  endfunction

endclass


/////////////////////////////////////////////////////
//                cmn_txpdcal_ctrl
/////////////////////////////////////////////////////
class T_cmn_txpdcal_ctrl_1102 extends cdns_uvm_reg;

  `uvm_object_utils(T_cmn_txpdcal_ctrl_1102)
  rand uvm_reg_field cmn_txpdcal_ctrl_5_0;
  rand uvm_reg_field cmn_txpdcal_ctrl_11_6;
  rand uvm_reg_field cmn_txpdcal_ctrl_12;
  rand uvm_reg_field cmn_txpdcal_ctrl_13;
  rand uvm_reg_field cmn_txpdcal_ctrl_14;
  rand uvm_reg_field cmn_txpdcal_ctrl_15;
  rand uvm_reg_field cmn_txpdcal_ctrl_31_16;
  
  covergroup wr_fld_covg;
    cmn_txpdcal_ctrl_5_0: coverpoint cmn_txpdcal_ctrl_5_0.value[5:0];
    cmn_txpdcal_ctrl_11_6: coverpoint cmn_txpdcal_ctrl_11_6.value[5:0];
    cmn_txpdcal_ctrl_12: coverpoint cmn_txpdcal_ctrl_12.value[0:0];
    cmn_txpdcal_ctrl_13: coverpoint cmn_txpdcal_ctrl_13.value[0:0];
    cmn_txpdcal_ctrl_14: coverpoint cmn_txpdcal_ctrl_14.value[0:0];
    cmn_txpdcal_ctrl_15: coverpoint cmn_txpdcal_ctrl_15.value[0:0];
    cmn_txpdcal_ctrl_31_16: coverpoint cmn_txpdcal_ctrl_31_16.value[15:0];
  endgroup
  covergroup rd_fld_covg;
    cmn_txpdcal_ctrl_5_0: coverpoint cmn_txpdcal_ctrl_5_0.value[5:0];
    cmn_txpdcal_ctrl_11_6: coverpoint cmn_txpdcal_ctrl_11_6.value[5:0];
    cmn_txpdcal_ctrl_12: coverpoint cmn_txpdcal_ctrl_12.value[0:0];
    cmn_txpdcal_ctrl_13: coverpoint cmn_txpdcal_ctrl_13.value[0:0];
    cmn_txpdcal_ctrl_14: coverpoint cmn_txpdcal_ctrl_14.value[0:0];
    cmn_txpdcal_ctrl_15: coverpoint cmn_txpdcal_ctrl_15.value[0:0];
    cmn_txpdcal_ctrl_31_16: coverpoint cmn_txpdcal_ctrl_31_16.value[15:0];
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
    
    cmn_txpdcal_ctrl_5_0 = fld_set[0];
    cmn_txpdcal_ctrl_11_6 = fld_set[1];
    cmn_txpdcal_ctrl_12 = fld_set[2];
    cmn_txpdcal_ctrl_13 = fld_set[3];
    cmn_txpdcal_ctrl_14 = fld_set[4];
    cmn_txpdcal_ctrl_15 = fld_set[5];
    cmn_txpdcal_ctrl_31_16 = fld_set[6];
  endfunction

  function new(input string name="T_cmn_txpdcal_ctrl_1102");
    super.new(name, 32, build_coverage(UVM_CVR_FIELD_VALS));
    if (has_coverage(UVM_CVR_FIELD_VALS)) begin
      wr_fld_covg = new();
      rd_fld_covg = new();
    end
  endfunction

endclass


/////////////////////////////////////////////////////
//                cmn_txpdcal_init_tmr
/////////////////////////////////////////////////////
class T_cmn_txpdcal_init_tmr_1106 extends cdns_uvm_reg;

  `uvm_object_utils(T_cmn_txpdcal_init_tmr_1106)
  rand uvm_reg_field cmn_txpdcal_init_tmr_6_0;
  rand uvm_reg_field cmn_txpdcal_init_tmr_15_7;
  rand uvm_reg_field cmn_txpdcal_init_tmr_31_16;
  
  covergroup wr_fld_covg;
    cmn_txpdcal_init_tmr_6_0: coverpoint cmn_txpdcal_init_tmr_6_0.value[6:0];
    cmn_txpdcal_init_tmr_15_7: coverpoint cmn_txpdcal_init_tmr_15_7.value[8:0];
    cmn_txpdcal_init_tmr_31_16: coverpoint cmn_txpdcal_init_tmr_31_16.value[15:0];
  endgroup
  covergroup rd_fld_covg;
    cmn_txpdcal_init_tmr_6_0: coverpoint cmn_txpdcal_init_tmr_6_0.value[6:0];
    cmn_txpdcal_init_tmr_15_7: coverpoint cmn_txpdcal_init_tmr_15_7.value[8:0];
    cmn_txpdcal_init_tmr_31_16: coverpoint cmn_txpdcal_init_tmr_31_16.value[15:0];
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
    
    cmn_txpdcal_init_tmr_6_0 = fld_set[0];
    cmn_txpdcal_init_tmr_15_7 = fld_set[1];
    cmn_txpdcal_init_tmr_31_16 = fld_set[2];
  endfunction

  function new(input string name="T_cmn_txpdcal_init_tmr_1106");
    super.new(name, 32, build_coverage(UVM_CVR_FIELD_VALS));
    if (has_coverage(UVM_CVR_FIELD_VALS)) begin
      wr_fld_covg = new();
      rd_fld_covg = new();
    end
  endfunction

endclass


/////////////////////////////////////////////////////
//                cmn_txpdcal_iter_tmr
/////////////////////////////////////////////////////
class T_cmn_txpdcal_iter_tmr_1107 extends cdns_uvm_reg;

  `uvm_object_utils(T_cmn_txpdcal_iter_tmr_1107)
  rand uvm_reg_field cmn_txpdcal_iter_tmr_6_0;
  rand uvm_reg_field cmn_txpdcal_iter_tmr_15_7;
  rand uvm_reg_field cmn_txpdcal_iter_tmr_31_16;
  
  covergroup wr_fld_covg;
    cmn_txpdcal_iter_tmr_6_0: coverpoint cmn_txpdcal_iter_tmr_6_0.value[6:0];
    cmn_txpdcal_iter_tmr_15_7: coverpoint cmn_txpdcal_iter_tmr_15_7.value[8:0];
    cmn_txpdcal_iter_tmr_31_16: coverpoint cmn_txpdcal_iter_tmr_31_16.value[15:0];
  endgroup
  covergroup rd_fld_covg;
    cmn_txpdcal_iter_tmr_6_0: coverpoint cmn_txpdcal_iter_tmr_6_0.value[6:0];
    cmn_txpdcal_iter_tmr_15_7: coverpoint cmn_txpdcal_iter_tmr_15_7.value[8:0];
    cmn_txpdcal_iter_tmr_31_16: coverpoint cmn_txpdcal_iter_tmr_31_16.value[15:0];
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
    
    cmn_txpdcal_iter_tmr_6_0 = fld_set[0];
    cmn_txpdcal_iter_tmr_15_7 = fld_set[1];
    cmn_txpdcal_iter_tmr_31_16 = fld_set[2];
  endfunction

  function new(input string name="T_cmn_txpdcal_iter_tmr_1107");
    super.new(name, 32, build_coverage(UVM_CVR_FIELD_VALS));
    if (has_coverage(UVM_CVR_FIELD_VALS)) begin
      wr_fld_covg = new();
      rd_fld_covg = new();
    end
  endfunction

endclass


/////////////////////////////////////////////////////
//                cmn_txpdcal_ovrd
/////////////////////////////////////////////////////
class T_cmn_txpdcal_ovrd_1103 extends cdns_uvm_reg;

  `uvm_object_utils(T_cmn_txpdcal_ovrd_1103)
  rand uvm_reg_field cmn_txpdcal_ovrd_5_0;
  rand uvm_reg_field cmn_txpdcal_ovrd_13_6;
  rand uvm_reg_field cmn_txpdcal_ovrd_14;
  rand uvm_reg_field cmn_txpdcal_ovrd_15;
  rand uvm_reg_field cmn_txpdcal_ovrd_31_16;
  
  covergroup wr_fld_covg;
    cmn_txpdcal_ovrd_5_0: coverpoint cmn_txpdcal_ovrd_5_0.value[5:0];
    cmn_txpdcal_ovrd_13_6: coverpoint cmn_txpdcal_ovrd_13_6.value[7:0];
    cmn_txpdcal_ovrd_14: coverpoint cmn_txpdcal_ovrd_14.value[0:0];
    cmn_txpdcal_ovrd_15: coverpoint cmn_txpdcal_ovrd_15.value[0:0];
    cmn_txpdcal_ovrd_31_16: coverpoint cmn_txpdcal_ovrd_31_16.value[15:0];
  endgroup
  covergroup rd_fld_covg;
    cmn_txpdcal_ovrd_5_0: coverpoint cmn_txpdcal_ovrd_5_0.value[5:0];
    cmn_txpdcal_ovrd_13_6: coverpoint cmn_txpdcal_ovrd_13_6.value[7:0];
    cmn_txpdcal_ovrd_14: coverpoint cmn_txpdcal_ovrd_14.value[0:0];
    cmn_txpdcal_ovrd_15: coverpoint cmn_txpdcal_ovrd_15.value[0:0];
    cmn_txpdcal_ovrd_31_16: coverpoint cmn_txpdcal_ovrd_31_16.value[15:0];
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
    
    cmn_txpdcal_ovrd_5_0 = fld_set[0];
    cmn_txpdcal_ovrd_13_6 = fld_set[1];
    cmn_txpdcal_ovrd_14 = fld_set[2];
    cmn_txpdcal_ovrd_15 = fld_set[3];
    cmn_txpdcal_ovrd_31_16 = fld_set[4];
  endfunction

  function new(input string name="T_cmn_txpdcal_ovrd_1103");
    super.new(name, 32, build_coverage(UVM_CVR_FIELD_VALS));
    if (has_coverage(UVM_CVR_FIELD_VALS)) begin
      wr_fld_covg = new();
      rd_fld_covg = new();
    end
  endfunction

endclass


/////////////////////////////////////////////////////
//                cmn_txpdcal_start
/////////////////////////////////////////////////////
class T_cmn_txpdcal_start_1104 extends cdns_uvm_reg;

  `uvm_object_utils(T_cmn_txpdcal_start_1104)
  rand uvm_reg_field cmn_txpdcal_start_5_0;
  rand uvm_reg_field cmn_txpdcal_start_14_6;
  rand uvm_reg_field cmn_txpdcal_start_15;
  rand uvm_reg_field cmn_txpdcal_start_31_16;
  
  covergroup wr_fld_covg;
    cmn_txpdcal_start_5_0: coverpoint cmn_txpdcal_start_5_0.value[5:0];
    cmn_txpdcal_start_14_6: coverpoint cmn_txpdcal_start_14_6.value[8:0];
    cmn_txpdcal_start_15: coverpoint cmn_txpdcal_start_15.value[0:0];
    cmn_txpdcal_start_31_16: coverpoint cmn_txpdcal_start_31_16.value[15:0];
  endgroup
  covergroup rd_fld_covg;
    cmn_txpdcal_start_5_0: coverpoint cmn_txpdcal_start_5_0.value[5:0];
    cmn_txpdcal_start_14_6: coverpoint cmn_txpdcal_start_14_6.value[8:0];
    cmn_txpdcal_start_15: coverpoint cmn_txpdcal_start_15.value[0:0];
    cmn_txpdcal_start_31_16: coverpoint cmn_txpdcal_start_31_16.value[15:0];
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
    
    cmn_txpdcal_start_5_0 = fld_set[0];
    cmn_txpdcal_start_14_6 = fld_set[1];
    cmn_txpdcal_start_15 = fld_set[2];
    cmn_txpdcal_start_31_16 = fld_set[3];
  endfunction

  function new(input string name="T_cmn_txpdcal_start_1104");
    super.new(name, 32, build_coverage(UVM_CVR_FIELD_VALS));
    if (has_coverage(UVM_CVR_FIELD_VALS)) begin
      wr_fld_covg = new();
      rd_fld_covg = new();
    end
  endfunction

endclass


/////////////////////////////////////////////////////
//                cmn_txpdcal_tune
/////////////////////////////////////////////////////
class T_cmn_txpdcal_tune_1105 extends cdns_uvm_reg;

  `uvm_object_utils(T_cmn_txpdcal_tune_1105)
  rand uvm_reg_field cmn_txpdcal_tune_5_0;
  rand uvm_reg_field cmn_txpdcal_tune_15_6;
  rand uvm_reg_field cmn_txpdcal_tune_31_16;
  
  covergroup wr_fld_covg;
    cmn_txpdcal_tune_5_0: coverpoint cmn_txpdcal_tune_5_0.value[5:0];
    cmn_txpdcal_tune_15_6: coverpoint cmn_txpdcal_tune_15_6.value[9:0];
    cmn_txpdcal_tune_31_16: coverpoint cmn_txpdcal_tune_31_16.value[15:0];
  endgroup
  covergroup rd_fld_covg;
    cmn_txpdcal_tune_5_0: coverpoint cmn_txpdcal_tune_5_0.value[5:0];
    cmn_txpdcal_tune_15_6: coverpoint cmn_txpdcal_tune_15_6.value[9:0];
    cmn_txpdcal_tune_31_16: coverpoint cmn_txpdcal_tune_31_16.value[15:0];
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
    
    cmn_txpdcal_tune_5_0 = fld_set[0];
    cmn_txpdcal_tune_15_6 = fld_set[1];
    cmn_txpdcal_tune_31_16 = fld_set[2];
  endfunction

  function new(input string name="T_cmn_txpdcal_tune_1105");
    super.new(name, 32, build_coverage(UVM_CVR_FIELD_VALS));
    if (has_coverage(UVM_CVR_FIELD_VALS)) begin
      wr_fld_covg = new();
      rd_fld_covg = new();
    end
  endfunction

endclass


/////////////////////////////////////////////////////
//                cmn_txpucal_ctrl
/////////////////////////////////////////////////////
class T_cmn_txpucal_ctrl_1096 extends cdns_uvm_reg;

  `uvm_object_utils(T_cmn_txpucal_ctrl_1096)
  rand uvm_reg_field cmn_txpucal_ctrl_5_0;
  rand uvm_reg_field cmn_txpucal_ctrl_11_6;
  rand uvm_reg_field cmn_txpucal_ctrl_12;
  rand uvm_reg_field cmn_txpucal_ctrl_13;
  rand uvm_reg_field cmn_txpucal_ctrl_14;
  rand uvm_reg_field cmn_txpucal_ctrl_15;
  rand uvm_reg_field cmn_txpucal_ctrl_31_16;
  
  covergroup wr_fld_covg;
    cmn_txpucal_ctrl_5_0: coverpoint cmn_txpucal_ctrl_5_0.value[5:0];
    cmn_txpucal_ctrl_11_6: coverpoint cmn_txpucal_ctrl_11_6.value[5:0];
    cmn_txpucal_ctrl_12: coverpoint cmn_txpucal_ctrl_12.value[0:0];
    cmn_txpucal_ctrl_13: coverpoint cmn_txpucal_ctrl_13.value[0:0];
    cmn_txpucal_ctrl_14: coverpoint cmn_txpucal_ctrl_14.value[0:0];
    cmn_txpucal_ctrl_15: coverpoint cmn_txpucal_ctrl_15.value[0:0];
    cmn_txpucal_ctrl_31_16: coverpoint cmn_txpucal_ctrl_31_16.value[15:0];
  endgroup
  covergroup rd_fld_covg;
    cmn_txpucal_ctrl_5_0: coverpoint cmn_txpucal_ctrl_5_0.value[5:0];
    cmn_txpucal_ctrl_11_6: coverpoint cmn_txpucal_ctrl_11_6.value[5:0];
    cmn_txpucal_ctrl_12: coverpoint cmn_txpucal_ctrl_12.value[0:0];
    cmn_txpucal_ctrl_13: coverpoint cmn_txpucal_ctrl_13.value[0:0];
    cmn_txpucal_ctrl_14: coverpoint cmn_txpucal_ctrl_14.value[0:0];
    cmn_txpucal_ctrl_15: coverpoint cmn_txpucal_ctrl_15.value[0:0];
    cmn_txpucal_ctrl_31_16: coverpoint cmn_txpucal_ctrl_31_16.value[15:0];
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
    
    cmn_txpucal_ctrl_5_0 = fld_set[0];
    cmn_txpucal_ctrl_11_6 = fld_set[1];
    cmn_txpucal_ctrl_12 = fld_set[2];
    cmn_txpucal_ctrl_13 = fld_set[3];
    cmn_txpucal_ctrl_14 = fld_set[4];
    cmn_txpucal_ctrl_15 = fld_set[5];
    cmn_txpucal_ctrl_31_16 = fld_set[6];
  endfunction

  function new(input string name="T_cmn_txpucal_ctrl_1096");
    super.new(name, 32, build_coverage(UVM_CVR_FIELD_VALS));
    if (has_coverage(UVM_CVR_FIELD_VALS)) begin
      wr_fld_covg = new();
      rd_fld_covg = new();
    end
  endfunction

endclass


/////////////////////////////////////////////////////
//                cmn_txpucal_init_tmr
/////////////////////////////////////////////////////
class T_cmn_txpucal_init_tmr_1100 extends cdns_uvm_reg;

  `uvm_object_utils(T_cmn_txpucal_init_tmr_1100)
  rand uvm_reg_field cmn_txpucal_init_tmr_6_0;
  rand uvm_reg_field cmn_txpucal_init_tmr_15_7;
  rand uvm_reg_field cmn_txpucal_init_tmr_31_16;
  
  covergroup wr_fld_covg;
    cmn_txpucal_init_tmr_6_0: coverpoint cmn_txpucal_init_tmr_6_0.value[6:0];
    cmn_txpucal_init_tmr_15_7: coverpoint cmn_txpucal_init_tmr_15_7.value[8:0];
    cmn_txpucal_init_tmr_31_16: coverpoint cmn_txpucal_init_tmr_31_16.value[15:0];
  endgroup
  covergroup rd_fld_covg;
    cmn_txpucal_init_tmr_6_0: coverpoint cmn_txpucal_init_tmr_6_0.value[6:0];
    cmn_txpucal_init_tmr_15_7: coverpoint cmn_txpucal_init_tmr_15_7.value[8:0];
    cmn_txpucal_init_tmr_31_16: coverpoint cmn_txpucal_init_tmr_31_16.value[15:0];
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
    
    cmn_txpucal_init_tmr_6_0 = fld_set[0];
    cmn_txpucal_init_tmr_15_7 = fld_set[1];
    cmn_txpucal_init_tmr_31_16 = fld_set[2];
  endfunction

  function new(input string name="T_cmn_txpucal_init_tmr_1100");
    super.new(name, 32, build_coverage(UVM_CVR_FIELD_VALS));
    if (has_coverage(UVM_CVR_FIELD_VALS)) begin
      wr_fld_covg = new();
      rd_fld_covg = new();
    end
  endfunction

endclass


/////////////////////////////////////////////////////
//                cmn_txpucal_iter_tmr
/////////////////////////////////////////////////////
class T_cmn_txpucal_iter_tmr_1101 extends cdns_uvm_reg;

  `uvm_object_utils(T_cmn_txpucal_iter_tmr_1101)
  rand uvm_reg_field cmn_txpucal_iter_tmr_6_0;
  rand uvm_reg_field cmn_txpucal_iter_tmr_15_7;
  rand uvm_reg_field cmn_txpucal_iter_tmr_31_16;
  
  covergroup wr_fld_covg;
    cmn_txpucal_iter_tmr_6_0: coverpoint cmn_txpucal_iter_tmr_6_0.value[6:0];
    cmn_txpucal_iter_tmr_15_7: coverpoint cmn_txpucal_iter_tmr_15_7.value[8:0];
    cmn_txpucal_iter_tmr_31_16: coverpoint cmn_txpucal_iter_tmr_31_16.value[15:0];
  endgroup
  covergroup rd_fld_covg;
    cmn_txpucal_iter_tmr_6_0: coverpoint cmn_txpucal_iter_tmr_6_0.value[6:0];
    cmn_txpucal_iter_tmr_15_7: coverpoint cmn_txpucal_iter_tmr_15_7.value[8:0];
    cmn_txpucal_iter_tmr_31_16: coverpoint cmn_txpucal_iter_tmr_31_16.value[15:0];
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
    
    cmn_txpucal_iter_tmr_6_0 = fld_set[0];
    cmn_txpucal_iter_tmr_15_7 = fld_set[1];
    cmn_txpucal_iter_tmr_31_16 = fld_set[2];
  endfunction

  function new(input string name="T_cmn_txpucal_iter_tmr_1101");
    super.new(name, 32, build_coverage(UVM_CVR_FIELD_VALS));
    if (has_coverage(UVM_CVR_FIELD_VALS)) begin
      wr_fld_covg = new();
      rd_fld_covg = new();
    end
  endfunction

endclass


/////////////////////////////////////////////////////
//                cmn_txpucal_ovrd
/////////////////////////////////////////////////////
class T_cmn_txpucal_ovrd_1097 extends cdns_uvm_reg;

  `uvm_object_utils(T_cmn_txpucal_ovrd_1097)
  rand uvm_reg_field cmn_txpucal_ovrd_5_0;
  rand uvm_reg_field cmn_txpucal_ovrd_13_6;
  rand uvm_reg_field cmn_txpucal_ovrd_14;
  rand uvm_reg_field cmn_txpucal_ovrd_15;
  rand uvm_reg_field cmn_txpucal_ovrd_31_16;
  
  covergroup wr_fld_covg;
    cmn_txpucal_ovrd_5_0: coverpoint cmn_txpucal_ovrd_5_0.value[5:0];
    cmn_txpucal_ovrd_13_6: coverpoint cmn_txpucal_ovrd_13_6.value[7:0];
    cmn_txpucal_ovrd_14: coverpoint cmn_txpucal_ovrd_14.value[0:0];
    cmn_txpucal_ovrd_15: coverpoint cmn_txpucal_ovrd_15.value[0:0];
    cmn_txpucal_ovrd_31_16: coverpoint cmn_txpucal_ovrd_31_16.value[15:0];
  endgroup
  covergroup rd_fld_covg;
    cmn_txpucal_ovrd_5_0: coverpoint cmn_txpucal_ovrd_5_0.value[5:0];
    cmn_txpucal_ovrd_13_6: coverpoint cmn_txpucal_ovrd_13_6.value[7:0];
    cmn_txpucal_ovrd_14: coverpoint cmn_txpucal_ovrd_14.value[0:0];
    cmn_txpucal_ovrd_15: coverpoint cmn_txpucal_ovrd_15.value[0:0];
    cmn_txpucal_ovrd_31_16: coverpoint cmn_txpucal_ovrd_31_16.value[15:0];
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
    
    cmn_txpucal_ovrd_5_0 = fld_set[0];
    cmn_txpucal_ovrd_13_6 = fld_set[1];
    cmn_txpucal_ovrd_14 = fld_set[2];
    cmn_txpucal_ovrd_15 = fld_set[3];
    cmn_txpucal_ovrd_31_16 = fld_set[4];
  endfunction

  function new(input string name="T_cmn_txpucal_ovrd_1097");
    super.new(name, 32, build_coverage(UVM_CVR_FIELD_VALS));
    if (has_coverage(UVM_CVR_FIELD_VALS)) begin
      wr_fld_covg = new();
      rd_fld_covg = new();
    end
  endfunction

endclass


/////////////////////////////////////////////////////
//                cmn_txpucal_start
/////////////////////////////////////////////////////
class T_cmn_txpucal_start_1098 extends cdns_uvm_reg;

  `uvm_object_utils(T_cmn_txpucal_start_1098)
  rand uvm_reg_field cmn_txpucal_start_5_0;
  rand uvm_reg_field cmn_txpucal_start_14_6;
  rand uvm_reg_field cmn_txpucal_start_15;
  rand uvm_reg_field cmn_txpucal_start_31_16;
  
  covergroup wr_fld_covg;
    cmn_txpucal_start_5_0: coverpoint cmn_txpucal_start_5_0.value[5:0];
    cmn_txpucal_start_14_6: coverpoint cmn_txpucal_start_14_6.value[8:0];
    cmn_txpucal_start_15: coverpoint cmn_txpucal_start_15.value[0:0];
    cmn_txpucal_start_31_16: coverpoint cmn_txpucal_start_31_16.value[15:0];
  endgroup
  covergroup rd_fld_covg;
    cmn_txpucal_start_5_0: coverpoint cmn_txpucal_start_5_0.value[5:0];
    cmn_txpucal_start_14_6: coverpoint cmn_txpucal_start_14_6.value[8:0];
    cmn_txpucal_start_15: coverpoint cmn_txpucal_start_15.value[0:0];
    cmn_txpucal_start_31_16: coverpoint cmn_txpucal_start_31_16.value[15:0];
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
    
    cmn_txpucal_start_5_0 = fld_set[0];
    cmn_txpucal_start_14_6 = fld_set[1];
    cmn_txpucal_start_15 = fld_set[2];
    cmn_txpucal_start_31_16 = fld_set[3];
  endfunction

  function new(input string name="T_cmn_txpucal_start_1098");
    super.new(name, 32, build_coverage(UVM_CVR_FIELD_VALS));
    if (has_coverage(UVM_CVR_FIELD_VALS)) begin
      wr_fld_covg = new();
      rd_fld_covg = new();
    end
  endfunction

endclass


/////////////////////////////////////////////////////
//                cmn_txpucal_tune
/////////////////////////////////////////////////////
class T_cmn_txpucal_tune_1099 extends cdns_uvm_reg;

  `uvm_object_utils(T_cmn_txpucal_tune_1099)
  rand uvm_reg_field cmn_txpucal_tune_5_0;
  rand uvm_reg_field cmn_txpucal_tune_15_6;
  rand uvm_reg_field cmn_txpucal_tune_31_16;
  
  covergroup wr_fld_covg;
    cmn_txpucal_tune_5_0: coverpoint cmn_txpucal_tune_5_0.value[5:0];
    cmn_txpucal_tune_15_6: coverpoint cmn_txpucal_tune_15_6.value[9:0];
    cmn_txpucal_tune_31_16: coverpoint cmn_txpucal_tune_31_16.value[15:0];
  endgroup
  covergroup rd_fld_covg;
    cmn_txpucal_tune_5_0: coverpoint cmn_txpucal_tune_5_0.value[5:0];
    cmn_txpucal_tune_15_6: coverpoint cmn_txpucal_tune_15_6.value[9:0];
    cmn_txpucal_tune_31_16: coverpoint cmn_txpucal_tune_31_16.value[15:0];
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
    
    cmn_txpucal_tune_5_0 = fld_set[0];
    cmn_txpucal_tune_15_6 = fld_set[1];
    cmn_txpucal_tune_31_16 = fld_set[2];
  endfunction

  function new(input string name="T_cmn_txpucal_tune_1099");
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
class T_sd3101_phy_registers_1183 extends cdns_uvm_reg_block;

  `uvm_object_utils(T_sd3101_phy_registers_1183)
  rand T_cmn_bgcal_ctrl_1033 cmn_bgcal_ctrl;
  rand T_cmn_bgcal_init_tmr_1037 cmn_bgcal_init_tmr;
  rand T_cmn_bgcal_iter_tmr_1038 cmn_bgcal_iter_tmr;
  rand T_cmn_bgcal_ovrd_1034 cmn_bgcal_ovrd;
  rand T_cmn_bgcal_start_1035 cmn_bgcal_start;
  rand T_cmn_bgcal_tune_1036 cmn_bgcal_tune;
  rand T_cmn_cdiag_ccal_pwri_ovrd_1023 cmn_cdiag_ccal_pwri_ovrd;
  rand T_cmn_cdiag_dcya_1032 cmn_cdiag_dcya;
  rand T_cmn_cdiag_diag_pwri_ovrd_1025 cmn_cdiag_diag_pwri_ovrd;
  rand T_cmn_cdiag_pllc_pwri_ovrd_1022 cmn_cdiag_pllc_pwri_ovrd;
  rand T_cmn_cdiag_pllsm_calmc_cs_1030 cmn_cdiag_pllsm_calmc_cs;
  rand T_cmn_cdiag_psmclk_ctrl_1027 cmn_cdiag_psmclk_ctrl;
  rand T_cmn_cdiag_pwri_tmr_1021 cmn_cdiag_pwri_tmr;
  rand T_cmn_cdiag_refclk_ctrl_1026 cmn_cdiag_refclk_ctrl;
  rand T_cmn_cdiag_rst_diag_1031 cmn_cdiag_rst_diag;
  rand T_cmn_cdiag_sdosc_ctrl_1028 cmn_cdiag_sdosc_ctrl;
  rand T_cmn_cdiag_ssm_calmc_cs_1029 cmn_cdiag_ssm_calmc_cs;
  rand T_cmn_cdiag_xcvrc_pwri_ovrd_1024 cmn_cdiag_xcvrc_pwri_ovrd;
  rand T_cmn_cmsmt_clk_freq_msmt_ctrl_1122 cmn_cmsmt_clk_freq_msmt_ctrl;
  rand T_cmn_cmsmt_ref_clk_tmr_value_1124 cmn_cmsmt_ref_clk_tmr_value;
  rand T_cmn_cmsmt_test_clk_cnt_value_1125 cmn_cmsmt_test_clk_cnt_value;
  rand T_cmn_cmsmt_test_clk_sel_1123 cmn_cmsmt_test_clk_sel;
  rand T_cmn_diag_atb_adc_ctrl_1170 cmn_diag_atb_adc_ctrl;
  rand T_cmn_diag_atb_ctrl_1169 cmn_diag_atb_ctrl;
  rand T_cmn_diag_bandgap_ovrd_1164 cmn_diag_bandgap_ovrd;
  rand T_cmn_diag_bias_adj_1179 cmn_diag_bias_adj;
  rand T_cmn_diag_bias_ovrd_1165 cmn_diag_bias_ovrd;
  rand T_cmn_diag_cal_filt_ctrl_1177 cmn_diag_cal_filt_ctrl;
  rand T_cmn_diag_cya_1173 cmn_diag_cya;
  rand T_cmn_diag_gpana_1_1174 cmn_diag_gpana_1;
  rand T_cmn_diag_gpana_2_1175 cmn_diag_gpana_2;
  rand T_cmn_diag_gpana_st_1176 cmn_diag_gpana_st;
  rand T_cmn_diag_hsrrsm_ctrl_1171 cmn_diag_hsrrsm_ctrl;
  rand T_cmn_diag_mom_osc_ctrl_1178 cmn_diag_mom_osc_ctrl;
  rand T_cmn_diag_pm_ctrl_1166 cmn_diag_pm_ctrl;
  rand T_cmn_diag_rst_diag_1172 cmn_diag_rst_diag;
  rand T_cmn_diag_sh_bg_res_1167 cmn_diag_sh_bg_res;
  rand T_cmn_diag_sh_sdclk_1168 cmn_diag_sh_sdclk;
  rand T_cmn_diag_tmpsns_ana_ctrl_1180 cmn_diag_tmpsns_ana_ctrl;
  rand T_cmn_diag_tmpsns_filt_ctrl_1181 cmn_diag_tmpsns_filt_ctrl;
  rand T_cmn_diag_tmpsns_filt_out_1182 cmn_diag_tmpsns_filt_out;
  rand T_cmn_ibcal_ctrl_1039 cmn_ibcal_ctrl;
  rand T_cmn_ibcal_init_tmr_1043 cmn_ibcal_init_tmr;
  rand T_cmn_ibcal_iter_tmr_1044 cmn_ibcal_iter_tmr;
  rand T_cmn_ibcal_ovrd_1040 cmn_ibcal_ovrd;
  rand T_cmn_ibcal_start_1041 cmn_ibcal_start;
  rand T_cmn_ibcal_tune_1042 cmn_ibcal_tune;
  rand T_cmn_pdiag_pll0_cp_iadj_m0_1130 cmn_pdiag_pll0_cp_iadj_m0;
  rand T_cmn_pdiag_pll0_cp_iadj_m1_1139 cmn_pdiag_pll0_cp_iadj_m1;
  rand T_cmn_pdiag_pll0_cp_padj_m0_1129 cmn_pdiag_pll0_cp_padj_m0;
  rand T_cmn_pdiag_pll0_cp_padj_m1_1138 cmn_pdiag_pll0_cp_padj_m1;
  rand T_cmn_pdiag_pll0_ctrl_m0_1126 cmn_pdiag_pll0_ctrl_m0;
  rand T_cmn_pdiag_pll0_ctrl_m1_1135 cmn_pdiag_pll0_ctrl_m1;
  rand T_cmn_pdiag_pll0_filt_padj_m0_1131 cmn_pdiag_pll0_filt_padj_m0;
  rand T_cmn_pdiag_pll0_filt_padj_m1_1140 cmn_pdiag_pll0_filt_padj_m1;
  rand T_cmn_pdiag_pll0_pkvco_bw_ctrl_m0_1128 cmn_pdiag_pll0_pkvco_bw_ctrl_m0;
  rand T_cmn_pdiag_pll0_pkvco_bw_ctrl_m1_1137 cmn_pdiag_pll0_pkvco_bw_ctrl_m1;
  rand T_cmn_pdiag_pll0_post_div_m0_1134 cmn_pdiag_pll0_post_div_m0;
  rand T_cmn_pdiag_pll0_post_div_m1_1143 cmn_pdiag_pll0_post_div_m1;
  rand T_cmn_pdiag_pll0_prog0_clk_ctrl_m0_1132 cmn_pdiag_pll0_prog0_clk_ctrl_m0;
  rand T_cmn_pdiag_pll0_prog0_clk_ctrl_m1_1141 cmn_pdiag_pll0_prog0_clk_ctrl_m1;
  rand T_cmn_pdiag_pll0_prog1_clk_ctrl_m0_1133 cmn_pdiag_pll0_prog1_clk_ctrl_m0;
  rand T_cmn_pdiag_pll0_prog1_clk_ctrl_m1_1142 cmn_pdiag_pll0_prog1_clk_ctrl_m1;
  rand T_cmn_pdiag_pll0_tune_m0_1127 cmn_pdiag_pll0_tune_m0;
  rand T_cmn_pdiag_pll0_tune_m1_1136 cmn_pdiag_pll0_tune_m1;
  rand T_cmn_pdiag_pll1_cp_ctrl_m0_1146 cmn_pdiag_pll1_cp_ctrl_m0;
  rand T_cmn_pdiag_pll1_cp_ctrl_m1_1156 cmn_pdiag_pll1_cp_ctrl_m1;
  rand T_cmn_pdiag_pll1_lock_det_ctrl_m0_1149 cmn_pdiag_pll1_lock_det_ctrl_m0;
  rand T_cmn_pdiag_pll1_lock_det_ctrl_m1_1159 cmn_pdiag_pll1_lock_det_ctrl_m1;
  rand T_cmn_pdiag_pll1_lpf_ctrl_m0_1147 cmn_pdiag_pll1_lpf_ctrl_m0;
  rand T_cmn_pdiag_pll1_lpf_ctrl_m1_1157 cmn_pdiag_pll1_lpf_ctrl_m1;
  rand T_cmn_pdiag_pll1_pfd_ctrl_m0_1145 cmn_pdiag_pll1_pfd_ctrl_m0;
  rand T_cmn_pdiag_pll1_pfd_ctrl_m1_1155 cmn_pdiag_pll1_pfd_ctrl_m1;
  rand T_cmn_pdiag_pll1_post_div_m0_1150 cmn_pdiag_pll1_post_div_m0;
  rand T_cmn_pdiag_pll1_post_div_m1_1160 cmn_pdiag_pll1_post_div_m1;
  rand T_cmn_pdiag_pll1_prog0_clk_ctrl_m0_1152 cmn_pdiag_pll1_prog0_clk_ctrl_m0;
  rand T_cmn_pdiag_pll1_prog0_clk_ctrl_m1_1162 cmn_pdiag_pll1_prog0_clk_ctrl_m1;
  rand T_cmn_pdiag_pll1_prog1_clk_ctrl_m0_1153 cmn_pdiag_pll1_prog1_clk_ctrl_m0;
  rand T_cmn_pdiag_pll1_prog1_clk_ctrl_m1_1163 cmn_pdiag_pll1_prog1_clk_ctrl_m1;
  rand T_cmn_pdiag_pll1_ref_clk_div_sel_m0_1151 cmn_pdiag_pll1_ref_clk_div_sel_m0;
  rand T_cmn_pdiag_pll1_ref_clk_div_sel_m1_1161 cmn_pdiag_pll1_ref_clk_div_sel_m1;
  rand T_cmn_pdiag_pll1_vco_ctrl_m0_1148 cmn_pdiag_pll1_vco_ctrl_m0;
  rand T_cmn_pdiag_pll1_vco_ctrl_m1_1158 cmn_pdiag_pll1_vco_ctrl_m1;
  rand T_cmn_pdiag_pll1_vreg_adj_m0_1144 cmn_pdiag_pll1_vreg_adj_m0;
  rand T_cmn_pdiag_pll1_vreg_adj_m1_1154 cmn_pdiag_pll1_vreg_adj_m1;
  rand T_cmn_pid_flv0_991 cmn_pid_flv0;
  rand T_cmn_pid_flv1_992 cmn_pid_flv1;
  rand T_cmn_pid_iov_993 cmn_pid_iov;
  rand T_cmn_pid_lanes_994 cmn_pid_lanes;
  rand T_cmn_pid_metal0_995 cmn_pid_metal0;
  rand T_cmn_pid_metal1_996 cmn_pid_metal1;
  rand T_cmn_pid_metal2_997 cmn_pid_metal2;
  rand T_cmn_pid_metal3_998 cmn_pid_metal3;
  rand T_cmn_pid_metald_999 cmn_pid_metald;
  rand T_cmn_pid_mfg_989 cmn_pid_mfg;
  rand T_cmn_pid_node_990 cmn_pid_node;
  rand T_cmn_pid_num_987 cmn_pid_num;
  rand T_cmn_pid_rev_988 cmn_pid_rev;
  rand T_cmn_pid_type_986 cmn_pid_type;
  rand T_cmn_pll0_dsm_diag_1057 cmn_pll0_dsm_diag;
  rand T_cmn_pll0_dsm_fbh_ovrd_1058 cmn_pll0_dsm_fbh_ovrd;
  rand T_cmn_pll0_dsm_fbl_ovrd_1059 cmn_pll0_dsm_fbl_ovrd;
  rand T_cmn_pll0_fracdivh_1055 cmn_pll0_fracdivh;
  rand T_cmn_pll0_fracdivl_1054 cmn_pll0_fracdivl;
  rand T_cmn_pll0_high_thr_1056 cmn_pll0_high_thr;
  rand T_cmn_pll0_intdiv_1053 cmn_pll0_intdiv;
  rand T_cmn_pll0_lock_pllcnt_start_1065 cmn_pll0_lock_pllcnt_start;
  rand T_cmn_pll0_lock_pllcnt_thr_1066 cmn_pll0_lock_pllcnt_thr;
  rand T_cmn_pll0_lock_refcnt_idle_1064 cmn_pll0_lock_refcnt_idle;
  rand T_cmn_pll0_lock_refcnt_start_1063 cmn_pll0_lock_refcnt_start;
  rand T_cmn_pll0_ss_ctrl1_1060 cmn_pll0_ss_ctrl1;
  rand T_cmn_pll0_ss_ctrl2_1061 cmn_pll0_ss_ctrl2;
  rand T_cmn_pll0_ss_ctrl3_1062 cmn_pll0_ss_ctrl3;
  rand T_cmn_pll0_varcal_ctrl_1067 cmn_pll0_varcal_ctrl;
  rand T_cmn_pll0_varcal_icvf_cfg_1075 cmn_pll0_varcal_icvf_cfg;
  rand T_cmn_pll0_varcal_icvf_hstat_1077 cmn_pll0_varcal_icvf_hstat;
  rand T_cmn_pll0_varcal_icvf_init_tmr_1074 cmn_pll0_varcal_icvf_init_tmr;
  rand T_cmn_pll0_varcal_icvf_lstat_1076 cmn_pll0_varcal_icvf_lstat;
  rand T_cmn_pll0_varcal_init_tmr_1071 cmn_pll0_varcal_init_tmr;
  rand T_cmn_pll0_varcal_iter_tmr_1072 cmn_pll0_varcal_iter_tmr;
  rand T_cmn_pll0_varcal_ovrd_1070 cmn_pll0_varcal_ovrd;
  rand T_cmn_pll0_varcal_pllcnt_ovrd_1078 cmn_pll0_varcal_pllcnt_ovrd;
  rand T_cmn_pll0_varcal_reftim_start_1073 cmn_pll0_varcal_reftim_start;
  rand T_cmn_pll0_varcal_start_1068 cmn_pll0_varcal_start;
  rand T_cmn_pll0_varcal_tctrl_1069 cmn_pll0_varcal_tctrl;
  rand T_cmn_pll0_vcocal_ctrl_1045 cmn_pll0_vcocal_ctrl;
  rand T_cmn_pll0_vcocal_init_tmr_1049 cmn_pll0_vcocal_init_tmr;
  rand T_cmn_pll0_vcocal_iter_tmr_1050 cmn_pll0_vcocal_iter_tmr;
  rand T_cmn_pll0_vcocal_ovrd_1048 cmn_pll0_vcocal_ovrd;
  rand T_cmn_pll0_vcocal_pllcnt_start_1052 cmn_pll0_vcocal_pllcnt_start;
  rand T_cmn_pll0_vcocal_reftim_start_1051 cmn_pll0_vcocal_reftim_start;
  rand T_cmn_pll0_vcocal_start_1046 cmn_pll0_vcocal_start;
  rand T_cmn_pll0_vcocal_tctrl_1047 cmn_pll0_vcocal_tctrl;
  rand T_cmn_pll1_dsm_diag_1090 cmn_pll1_dsm_diag;
  rand T_cmn_pll1_dsm_fbh_ovrd_1091 cmn_pll1_dsm_fbh_ovrd;
  rand T_cmn_pll1_dsm_fbl_ovrd_1092 cmn_pll1_dsm_fbl_ovrd;
  rand T_cmn_pll1_fracdivh_1088 cmn_pll1_fracdivh;
  rand T_cmn_pll1_fracdivl_1087 cmn_pll1_fracdivl;
  rand T_cmn_pll1_high_thr_1089 cmn_pll1_high_thr;
  rand T_cmn_pll1_intdiv_1086 cmn_pll1_intdiv;
  rand T_cmn_pll1_ss_ctrl1_1093 cmn_pll1_ss_ctrl1;
  rand T_cmn_pll1_ss_ctrl2_1094 cmn_pll1_ss_ctrl2;
  rand T_cmn_pll1_ss_ctrl3_1095 cmn_pll1_ss_ctrl3;
  rand T_cmn_pll1_vcocal_ctrl_1079 cmn_pll1_vcocal_ctrl;
  rand T_cmn_pll1_vcocal_init_tmr_1083 cmn_pll1_vcocal_init_tmr;
  rand T_cmn_pll1_vcocal_iter_tmr_1084 cmn_pll1_vcocal_iter_tmr;
  rand T_cmn_pll1_vcocal_ovrd_1082 cmn_pll1_vcocal_ovrd;
  rand T_cmn_pll1_vcocal_reftim_start_1085 cmn_pll1_vcocal_reftim_start;
  rand T_cmn_pll1_vcocal_start_1080 cmn_pll1_vcocal_start;
  rand T_cmn_pll1_vcocal_tctrl_1081 cmn_pll1_vcocal_tctrl;
  rand T_cmn_pllsm0_sm_ctrl_1004 cmn_pllsm0_sm_ctrl;
  rand T_cmn_pllsm0_st_1009 cmn_pllsm0_st;
  rand T_cmn_pllsm0_tmr_1_1005 cmn_pllsm0_tmr_1;
  rand T_cmn_pllsm0_tmr_2_1006 cmn_pllsm0_tmr_2;
  rand T_cmn_pllsm0_tmr_3_1007 cmn_pllsm0_tmr_3;
  rand T_cmn_pllsm0_tmr_4_1008 cmn_pllsm0_tmr_4;
  rand T_cmn_pllsm1_sm_ctrl0_1010 cmn_pllsm1_sm_ctrl0;
  rand T_cmn_pllsm1_sm_ctrl1_1011 cmn_pllsm1_sm_ctrl1;
  rand T_cmn_pllsm1_st_1020 cmn_pllsm1_st;
  rand T_cmn_pllsm1_tmr_1_1012 cmn_pllsm1_tmr_1;
  rand T_cmn_pllsm1_tmr_2_1013 cmn_pllsm1_tmr_2;
  rand T_cmn_pllsm1_tmr_3_1014 cmn_pllsm1_tmr_3;
  rand T_cmn_pllsm1_tmr_4_1015 cmn_pllsm1_tmr_4;
  rand T_cmn_pllsm1_tmr_5_1016 cmn_pllsm1_tmr_5;
  rand T_cmn_pllsm1_tmr_6_1017 cmn_pllsm1_tmr_6;
  rand T_cmn_pllsm1_tmr_7_1018 cmn_pllsm1_tmr_7;
  rand T_cmn_pllsm1_tmr_8_1019 cmn_pllsm1_tmr_8;
  rand T_cmn_rxcal_ctrl_1108 cmn_rxcal_ctrl;
  rand T_cmn_rxcal_init_tmr_1112 cmn_rxcal_init_tmr;
  rand T_cmn_rxcal_iter_tmr_1113 cmn_rxcal_iter_tmr;
  rand T_cmn_rxcal_ovrd_1109 cmn_rxcal_ovrd;
  rand T_cmn_rxcal_start_1110 cmn_rxcal_start;
  rand T_cmn_rxcal_tune_1111 cmn_rxcal_tune;
  rand T_cmn_sd_cal_ctrl_1114 cmn_sd_cal_ctrl;
  rand T_cmn_sd_cal_init_tmr_1118 cmn_sd_cal_init_tmr;
  rand T_cmn_sd_cal_iter_tmr_1119 cmn_sd_cal_iter_tmr;
  rand T_cmn_sd_cal_ovrd_1117 cmn_sd_cal_ovrd;
  rand T_cmn_sd_cal_pllcnt_start_1121 cmn_sd_cal_pllcnt_start;
  rand T_cmn_sd_cal_reftim_start_1120 cmn_sd_cal_reftim_start;
  rand T_cmn_sd_cal_start_1115 cmn_sd_cal_start;
  rand T_cmn_sd_cal_tctrl_1116 cmn_sd_cal_tctrl;
  rand T_cmn_ssm_sm_ctrl_1000 cmn_ssm_sm_ctrl;
  rand T_cmn_ssm_st_1003 cmn_ssm_st;
  rand T_cmn_ssm_tmr_1_1001 cmn_ssm_tmr_1;
  rand T_cmn_ssm_tmr_2_1002 cmn_ssm_tmr_2;
  rand T_cmn_txpdcal_ctrl_1102 cmn_txpdcal_ctrl;
  rand T_cmn_txpdcal_init_tmr_1106 cmn_txpdcal_init_tmr;
  rand T_cmn_txpdcal_iter_tmr_1107 cmn_txpdcal_iter_tmr;
  rand T_cmn_txpdcal_ovrd_1103 cmn_txpdcal_ovrd;
  rand T_cmn_txpdcal_start_1104 cmn_txpdcal_start;
  rand T_cmn_txpdcal_tune_1105 cmn_txpdcal_tune;
  rand T_cmn_txpucal_ctrl_1096 cmn_txpucal_ctrl;
  rand T_cmn_txpucal_init_tmr_1100 cmn_txpucal_init_tmr;
  rand T_cmn_txpucal_iter_tmr_1101 cmn_txpucal_iter_tmr;
  rand T_cmn_txpucal_ovrd_1097 cmn_txpucal_ovrd;
  rand T_cmn_txpucal_start_1098 cmn_txpucal_start;
  rand T_cmn_txpucal_tune_1099 cmn_txpucal_tune;



  virtual function void build();
    uvm_reg  reg_set[$];
    string config_path = get_hier_path();
    default_map = create_map(get_name(), `UVM_REG_ADDR_WIDTH'h0, 4, UVM_LITTLE_ENDIAN, 1);
    begin
       uvm_reg_config_ta ta = get_reg_config("pma_cmn_registers.sd3101_t4_registers_sd3101_phy_registers");
       build_uvm_regs(default_map, this, null, ta, reg_set);
    end
    if(! $cast(cmn_bgcal_ctrl, reg_set[0]))
      `uvm_error("UVM_REG", "cmn_bgcal_ctrl register casting error")
    if(! $cast(cmn_bgcal_init_tmr, reg_set[1]))
      `uvm_error("UVM_REG", "cmn_bgcal_init_tmr register casting error")
    if(! $cast(cmn_bgcal_iter_tmr, reg_set[2]))
      `uvm_error("UVM_REG", "cmn_bgcal_iter_tmr register casting error")
    if(! $cast(cmn_bgcal_ovrd, reg_set[3]))
      `uvm_error("UVM_REG", "cmn_bgcal_ovrd register casting error")
    if(! $cast(cmn_bgcal_start, reg_set[4]))
      `uvm_error("UVM_REG", "cmn_bgcal_start register casting error")
    if(! $cast(cmn_bgcal_tune, reg_set[5]))
      `uvm_error("UVM_REG", "cmn_bgcal_tune register casting error")
    if(! $cast(cmn_cdiag_ccal_pwri_ovrd, reg_set[6]))
      `uvm_error("UVM_REG", "cmn_cdiag_ccal_pwri_ovrd register casting error")
    if(! $cast(cmn_cdiag_dcya, reg_set[7]))
      `uvm_error("UVM_REG", "cmn_cdiag_dcya register casting error")
    if(! $cast(cmn_cdiag_diag_pwri_ovrd, reg_set[8]))
      `uvm_error("UVM_REG", "cmn_cdiag_diag_pwri_ovrd register casting error")
    if(! $cast(cmn_cdiag_pllc_pwri_ovrd, reg_set[9]))
      `uvm_error("UVM_REG", "cmn_cdiag_pllc_pwri_ovrd register casting error")
    if(! $cast(cmn_cdiag_pllsm_calmc_cs, reg_set[10]))
      `uvm_error("UVM_REG", "cmn_cdiag_pllsm_calmc_cs register casting error")
    if(! $cast(cmn_cdiag_psmclk_ctrl, reg_set[11]))
      `uvm_error("UVM_REG", "cmn_cdiag_psmclk_ctrl register casting error")
    if(! $cast(cmn_cdiag_pwri_tmr, reg_set[12]))
      `uvm_error("UVM_REG", "cmn_cdiag_pwri_tmr register casting error")
    if(! $cast(cmn_cdiag_refclk_ctrl, reg_set[13]))
      `uvm_error("UVM_REG", "cmn_cdiag_refclk_ctrl register casting error")
    if(! $cast(cmn_cdiag_rst_diag, reg_set[14]))
      `uvm_error("UVM_REG", "cmn_cdiag_rst_diag register casting error")
    if(! $cast(cmn_cdiag_sdosc_ctrl, reg_set[15]))
      `uvm_error("UVM_REG", "cmn_cdiag_sdosc_ctrl register casting error")
    if(! $cast(cmn_cdiag_ssm_calmc_cs, reg_set[16]))
      `uvm_error("UVM_REG", "cmn_cdiag_ssm_calmc_cs register casting error")
    if(! $cast(cmn_cdiag_xcvrc_pwri_ovrd, reg_set[17]))
      `uvm_error("UVM_REG", "cmn_cdiag_xcvrc_pwri_ovrd register casting error")
    if(! $cast(cmn_cmsmt_clk_freq_msmt_ctrl, reg_set[18]))
      `uvm_error("UVM_REG", "cmn_cmsmt_clk_freq_msmt_ctrl register casting error")
    if(! $cast(cmn_cmsmt_ref_clk_tmr_value, reg_set[19]))
      `uvm_error("UVM_REG", "cmn_cmsmt_ref_clk_tmr_value register casting error")
    if(! $cast(cmn_cmsmt_test_clk_cnt_value, reg_set[20]))
      `uvm_error("UVM_REG", "cmn_cmsmt_test_clk_cnt_value register casting error")
    if(! $cast(cmn_cmsmt_test_clk_sel, reg_set[21]))
      `uvm_error("UVM_REG", "cmn_cmsmt_test_clk_sel register casting error")
    if(! $cast(cmn_diag_atb_adc_ctrl, reg_set[22]))
      `uvm_error("UVM_REG", "cmn_diag_atb_adc_ctrl register casting error")
    if(! $cast(cmn_diag_atb_ctrl, reg_set[23]))
      `uvm_error("UVM_REG", "cmn_diag_atb_ctrl register casting error")
    if(! $cast(cmn_diag_bandgap_ovrd, reg_set[24]))
      `uvm_error("UVM_REG", "cmn_diag_bandgap_ovrd register casting error")
    if(! $cast(cmn_diag_bias_adj, reg_set[25]))
      `uvm_error("UVM_REG", "cmn_diag_bias_adj register casting error")
    if(! $cast(cmn_diag_bias_ovrd, reg_set[26]))
      `uvm_error("UVM_REG", "cmn_diag_bias_ovrd register casting error")
    if(! $cast(cmn_diag_cal_filt_ctrl, reg_set[27]))
      `uvm_error("UVM_REG", "cmn_diag_cal_filt_ctrl register casting error")
    if(! $cast(cmn_diag_cya, reg_set[28]))
      `uvm_error("UVM_REG", "cmn_diag_cya register casting error")
    if(! $cast(cmn_diag_gpana_1, reg_set[29]))
      `uvm_error("UVM_REG", "cmn_diag_gpana_1 register casting error")
    if(! $cast(cmn_diag_gpana_2, reg_set[30]))
      `uvm_error("UVM_REG", "cmn_diag_gpana_2 register casting error")
    if(! $cast(cmn_diag_gpana_st, reg_set[31]))
      `uvm_error("UVM_REG", "cmn_diag_gpana_st register casting error")
    if(! $cast(cmn_diag_hsrrsm_ctrl, reg_set[32]))
      `uvm_error("UVM_REG", "cmn_diag_hsrrsm_ctrl register casting error")
    if(! $cast(cmn_diag_mom_osc_ctrl, reg_set[33]))
      `uvm_error("UVM_REG", "cmn_diag_mom_osc_ctrl register casting error")
    if(! $cast(cmn_diag_pm_ctrl, reg_set[34]))
      `uvm_error("UVM_REG", "cmn_diag_pm_ctrl register casting error")
    if(! $cast(cmn_diag_rst_diag, reg_set[35]))
      `uvm_error("UVM_REG", "cmn_diag_rst_diag register casting error")
    if(! $cast(cmn_diag_sh_bg_res, reg_set[36]))
      `uvm_error("UVM_REG", "cmn_diag_sh_bg_res register casting error")
    if(! $cast(cmn_diag_sh_sdclk, reg_set[37]))
      `uvm_error("UVM_REG", "cmn_diag_sh_sdclk register casting error")
    if(! $cast(cmn_diag_tmpsns_ana_ctrl, reg_set[38]))
      `uvm_error("UVM_REG", "cmn_diag_tmpsns_ana_ctrl register casting error")
    if(! $cast(cmn_diag_tmpsns_filt_ctrl, reg_set[39]))
      `uvm_error("UVM_REG", "cmn_diag_tmpsns_filt_ctrl register casting error")
    if(! $cast(cmn_diag_tmpsns_filt_out, reg_set[40]))
      `uvm_error("UVM_REG", "cmn_diag_tmpsns_filt_out register casting error")
    if(! $cast(cmn_ibcal_ctrl, reg_set[41]))
      `uvm_error("UVM_REG", "cmn_ibcal_ctrl register casting error")
    if(! $cast(cmn_ibcal_init_tmr, reg_set[42]))
      `uvm_error("UVM_REG", "cmn_ibcal_init_tmr register casting error")
    if(! $cast(cmn_ibcal_iter_tmr, reg_set[43]))
      `uvm_error("UVM_REG", "cmn_ibcal_iter_tmr register casting error")
    if(! $cast(cmn_ibcal_ovrd, reg_set[44]))
      `uvm_error("UVM_REG", "cmn_ibcal_ovrd register casting error")
    if(! $cast(cmn_ibcal_start, reg_set[45]))
      `uvm_error("UVM_REG", "cmn_ibcal_start register casting error")
    if(! $cast(cmn_ibcal_tune, reg_set[46]))
      `uvm_error("UVM_REG", "cmn_ibcal_tune register casting error")
    if(! $cast(cmn_pdiag_pll0_cp_iadj_m0, reg_set[47]))
      `uvm_error("UVM_REG", "cmn_pdiag_pll0_cp_iadj_m0 register casting error")
    if(! $cast(cmn_pdiag_pll0_cp_iadj_m1, reg_set[48]))
      `uvm_error("UVM_REG", "cmn_pdiag_pll0_cp_iadj_m1 register casting error")
    if(! $cast(cmn_pdiag_pll0_cp_padj_m0, reg_set[49]))
      `uvm_error("UVM_REG", "cmn_pdiag_pll0_cp_padj_m0 register casting error")
    if(! $cast(cmn_pdiag_pll0_cp_padj_m1, reg_set[50]))
      `uvm_error("UVM_REG", "cmn_pdiag_pll0_cp_padj_m1 register casting error")
    if(! $cast(cmn_pdiag_pll0_ctrl_m0, reg_set[51]))
      `uvm_error("UVM_REG", "cmn_pdiag_pll0_ctrl_m0 register casting error")
    if(! $cast(cmn_pdiag_pll0_ctrl_m1, reg_set[52]))
      `uvm_error("UVM_REG", "cmn_pdiag_pll0_ctrl_m1 register casting error")
    if(! $cast(cmn_pdiag_pll0_filt_padj_m0, reg_set[53]))
      `uvm_error("UVM_REG", "cmn_pdiag_pll0_filt_padj_m0 register casting error")
    if(! $cast(cmn_pdiag_pll0_filt_padj_m1, reg_set[54]))
      `uvm_error("UVM_REG", "cmn_pdiag_pll0_filt_padj_m1 register casting error")
    if(! $cast(cmn_pdiag_pll0_pkvco_bw_ctrl_m0, reg_set[55]))
      `uvm_error("UVM_REG", "cmn_pdiag_pll0_pkvco_bw_ctrl_m0 register casting error")
    if(! $cast(cmn_pdiag_pll0_pkvco_bw_ctrl_m1, reg_set[56]))
      `uvm_error("UVM_REG", "cmn_pdiag_pll0_pkvco_bw_ctrl_m1 register casting error")
    if(! $cast(cmn_pdiag_pll0_post_div_m0, reg_set[57]))
      `uvm_error("UVM_REG", "cmn_pdiag_pll0_post_div_m0 register casting error")
    if(! $cast(cmn_pdiag_pll0_post_div_m1, reg_set[58]))
      `uvm_error("UVM_REG", "cmn_pdiag_pll0_post_div_m1 register casting error")
    if(! $cast(cmn_pdiag_pll0_prog0_clk_ctrl_m0, reg_set[59]))
      `uvm_error("UVM_REG", "cmn_pdiag_pll0_prog0_clk_ctrl_m0 register casting error")
    if(! $cast(cmn_pdiag_pll0_prog0_clk_ctrl_m1, reg_set[60]))
      `uvm_error("UVM_REG", "cmn_pdiag_pll0_prog0_clk_ctrl_m1 register casting error")
    if(! $cast(cmn_pdiag_pll0_prog1_clk_ctrl_m0, reg_set[61]))
      `uvm_error("UVM_REG", "cmn_pdiag_pll0_prog1_clk_ctrl_m0 register casting error")
    if(! $cast(cmn_pdiag_pll0_prog1_clk_ctrl_m1, reg_set[62]))
      `uvm_error("UVM_REG", "cmn_pdiag_pll0_prog1_clk_ctrl_m1 register casting error")
    if(! $cast(cmn_pdiag_pll0_tune_m0, reg_set[63]))
      `uvm_error("UVM_REG", "cmn_pdiag_pll0_tune_m0 register casting error")
    if(! $cast(cmn_pdiag_pll0_tune_m1, reg_set[64]))
      `uvm_error("UVM_REG", "cmn_pdiag_pll0_tune_m1 register casting error")
    if(! $cast(cmn_pdiag_pll1_cp_ctrl_m0, reg_set[65]))
      `uvm_error("UVM_REG", "cmn_pdiag_pll1_cp_ctrl_m0 register casting error")
    if(! $cast(cmn_pdiag_pll1_cp_ctrl_m1, reg_set[66]))
      `uvm_error("UVM_REG", "cmn_pdiag_pll1_cp_ctrl_m1 register casting error")
    if(! $cast(cmn_pdiag_pll1_lock_det_ctrl_m0, reg_set[67]))
      `uvm_error("UVM_REG", "cmn_pdiag_pll1_lock_det_ctrl_m0 register casting error")
    if(! $cast(cmn_pdiag_pll1_lock_det_ctrl_m1, reg_set[68]))
      `uvm_error("UVM_REG", "cmn_pdiag_pll1_lock_det_ctrl_m1 register casting error")
    if(! $cast(cmn_pdiag_pll1_lpf_ctrl_m0, reg_set[69]))
      `uvm_error("UVM_REG", "cmn_pdiag_pll1_lpf_ctrl_m0 register casting error")
    if(! $cast(cmn_pdiag_pll1_lpf_ctrl_m1, reg_set[70]))
      `uvm_error("UVM_REG", "cmn_pdiag_pll1_lpf_ctrl_m1 register casting error")
    if(! $cast(cmn_pdiag_pll1_pfd_ctrl_m0, reg_set[71]))
      `uvm_error("UVM_REG", "cmn_pdiag_pll1_pfd_ctrl_m0 register casting error")
    if(! $cast(cmn_pdiag_pll1_pfd_ctrl_m1, reg_set[72]))
      `uvm_error("UVM_REG", "cmn_pdiag_pll1_pfd_ctrl_m1 register casting error")
    if(! $cast(cmn_pdiag_pll1_post_div_m0, reg_set[73]))
      `uvm_error("UVM_REG", "cmn_pdiag_pll1_post_div_m0 register casting error")
    if(! $cast(cmn_pdiag_pll1_post_div_m1, reg_set[74]))
      `uvm_error("UVM_REG", "cmn_pdiag_pll1_post_div_m1 register casting error")
    if(! $cast(cmn_pdiag_pll1_prog0_clk_ctrl_m0, reg_set[75]))
      `uvm_error("UVM_REG", "cmn_pdiag_pll1_prog0_clk_ctrl_m0 register casting error")
    if(! $cast(cmn_pdiag_pll1_prog0_clk_ctrl_m1, reg_set[76]))
      `uvm_error("UVM_REG", "cmn_pdiag_pll1_prog0_clk_ctrl_m1 register casting error")
    if(! $cast(cmn_pdiag_pll1_prog1_clk_ctrl_m0, reg_set[77]))
      `uvm_error("UVM_REG", "cmn_pdiag_pll1_prog1_clk_ctrl_m0 register casting error")
    if(! $cast(cmn_pdiag_pll1_prog1_clk_ctrl_m1, reg_set[78]))
      `uvm_error("UVM_REG", "cmn_pdiag_pll1_prog1_clk_ctrl_m1 register casting error")
    if(! $cast(cmn_pdiag_pll1_ref_clk_div_sel_m0, reg_set[79]))
      `uvm_error("UVM_REG", "cmn_pdiag_pll1_ref_clk_div_sel_m0 register casting error")
    if(! $cast(cmn_pdiag_pll1_ref_clk_div_sel_m1, reg_set[80]))
      `uvm_error("UVM_REG", "cmn_pdiag_pll1_ref_clk_div_sel_m1 register casting error")
    if(! $cast(cmn_pdiag_pll1_vco_ctrl_m0, reg_set[81]))
      `uvm_error("UVM_REG", "cmn_pdiag_pll1_vco_ctrl_m0 register casting error")
    if(! $cast(cmn_pdiag_pll1_vco_ctrl_m1, reg_set[82]))
      `uvm_error("UVM_REG", "cmn_pdiag_pll1_vco_ctrl_m1 register casting error")
    if(! $cast(cmn_pdiag_pll1_vreg_adj_m0, reg_set[83]))
      `uvm_error("UVM_REG", "cmn_pdiag_pll1_vreg_adj_m0 register casting error")
    if(! $cast(cmn_pdiag_pll1_vreg_adj_m1, reg_set[84]))
      `uvm_error("UVM_REG", "cmn_pdiag_pll1_vreg_adj_m1 register casting error")
    if(! $cast(cmn_pid_flv0, reg_set[85]))
      `uvm_error("UVM_REG", "cmn_pid_flv0 register casting error")
    if(! $cast(cmn_pid_flv1, reg_set[86]))
      `uvm_error("UVM_REG", "cmn_pid_flv1 register casting error")
    if(! $cast(cmn_pid_iov, reg_set[87]))
      `uvm_error("UVM_REG", "cmn_pid_iov register casting error")
    if(! $cast(cmn_pid_lanes, reg_set[88]))
      `uvm_error("UVM_REG", "cmn_pid_lanes register casting error")
    if(! $cast(cmn_pid_metal0, reg_set[89]))
      `uvm_error("UVM_REG", "cmn_pid_metal0 register casting error")
    if(! $cast(cmn_pid_metal1, reg_set[90]))
      `uvm_error("UVM_REG", "cmn_pid_metal1 register casting error")
    if(! $cast(cmn_pid_metal2, reg_set[91]))
      `uvm_error("UVM_REG", "cmn_pid_metal2 register casting error")
    if(! $cast(cmn_pid_metal3, reg_set[92]))
      `uvm_error("UVM_REG", "cmn_pid_metal3 register casting error")
    if(! $cast(cmn_pid_metald, reg_set[93]))
      `uvm_error("UVM_REG", "cmn_pid_metald register casting error")
    if(! $cast(cmn_pid_mfg, reg_set[94]))
      `uvm_error("UVM_REG", "cmn_pid_mfg register casting error")
    if(! $cast(cmn_pid_node, reg_set[95]))
      `uvm_error("UVM_REG", "cmn_pid_node register casting error")
    if(! $cast(cmn_pid_num, reg_set[96]))
      `uvm_error("UVM_REG", "cmn_pid_num register casting error")
    if(! $cast(cmn_pid_rev, reg_set[97]))
      `uvm_error("UVM_REG", "cmn_pid_rev register casting error")
    if(! $cast(cmn_pid_type, reg_set[98]))
      `uvm_error("UVM_REG", "cmn_pid_type register casting error")
    if(! $cast(cmn_pll0_dsm_diag, reg_set[99]))
      `uvm_error("UVM_REG", "cmn_pll0_dsm_diag register casting error")
    if(! $cast(cmn_pll0_dsm_fbh_ovrd, reg_set[100]))
      `uvm_error("UVM_REG", "cmn_pll0_dsm_fbh_ovrd register casting error")
    if(! $cast(cmn_pll0_dsm_fbl_ovrd, reg_set[101]))
      `uvm_error("UVM_REG", "cmn_pll0_dsm_fbl_ovrd register casting error")
    if(! $cast(cmn_pll0_fracdivh, reg_set[102]))
      `uvm_error("UVM_REG", "cmn_pll0_fracdivh register casting error")
    if(! $cast(cmn_pll0_fracdivl, reg_set[103]))
      `uvm_error("UVM_REG", "cmn_pll0_fracdivl register casting error")
    if(! $cast(cmn_pll0_high_thr, reg_set[104]))
      `uvm_error("UVM_REG", "cmn_pll0_high_thr register casting error")
    if(! $cast(cmn_pll0_intdiv, reg_set[105]))
      `uvm_error("UVM_REG", "cmn_pll0_intdiv register casting error")
    if(! $cast(cmn_pll0_lock_pllcnt_start, reg_set[106]))
      `uvm_error("UVM_REG", "cmn_pll0_lock_pllcnt_start register casting error")
    if(! $cast(cmn_pll0_lock_pllcnt_thr, reg_set[107]))
      `uvm_error("UVM_REG", "cmn_pll0_lock_pllcnt_thr register casting error")
    if(! $cast(cmn_pll0_lock_refcnt_idle, reg_set[108]))
      `uvm_error("UVM_REG", "cmn_pll0_lock_refcnt_idle register casting error")
    if(! $cast(cmn_pll0_lock_refcnt_start, reg_set[109]))
      `uvm_error("UVM_REG", "cmn_pll0_lock_refcnt_start register casting error")
    if(! $cast(cmn_pll0_ss_ctrl1, reg_set[110]))
      `uvm_error("UVM_REG", "cmn_pll0_ss_ctrl1 register casting error")
    if(! $cast(cmn_pll0_ss_ctrl2, reg_set[111]))
      `uvm_error("UVM_REG", "cmn_pll0_ss_ctrl2 register casting error")
    if(! $cast(cmn_pll0_ss_ctrl3, reg_set[112]))
      `uvm_error("UVM_REG", "cmn_pll0_ss_ctrl3 register casting error")
    if(! $cast(cmn_pll0_varcal_ctrl, reg_set[113]))
      `uvm_error("UVM_REG", "cmn_pll0_varcal_ctrl register casting error")
    if(! $cast(cmn_pll0_varcal_icvf_cfg, reg_set[114]))
      `uvm_error("UVM_REG", "cmn_pll0_varcal_icvf_cfg register casting error")
    if(! $cast(cmn_pll0_varcal_icvf_hstat, reg_set[115]))
      `uvm_error("UVM_REG", "cmn_pll0_varcal_icvf_hstat register casting error")
    if(! $cast(cmn_pll0_varcal_icvf_init_tmr, reg_set[116]))
      `uvm_error("UVM_REG", "cmn_pll0_varcal_icvf_init_tmr register casting error")
    if(! $cast(cmn_pll0_varcal_icvf_lstat, reg_set[117]))
      `uvm_error("UVM_REG", "cmn_pll0_varcal_icvf_lstat register casting error")
    if(! $cast(cmn_pll0_varcal_init_tmr, reg_set[118]))
      `uvm_error("UVM_REG", "cmn_pll0_varcal_init_tmr register casting error")
    if(! $cast(cmn_pll0_varcal_iter_tmr, reg_set[119]))
      `uvm_error("UVM_REG", "cmn_pll0_varcal_iter_tmr register casting error")
    if(! $cast(cmn_pll0_varcal_ovrd, reg_set[120]))
      `uvm_error("UVM_REG", "cmn_pll0_varcal_ovrd register casting error")
    if(! $cast(cmn_pll0_varcal_pllcnt_ovrd, reg_set[121]))
      `uvm_error("UVM_REG", "cmn_pll0_varcal_pllcnt_ovrd register casting error")
    if(! $cast(cmn_pll0_varcal_reftim_start, reg_set[122]))
      `uvm_error("UVM_REG", "cmn_pll0_varcal_reftim_start register casting error")
    if(! $cast(cmn_pll0_varcal_start, reg_set[123]))
      `uvm_error("UVM_REG", "cmn_pll0_varcal_start register casting error")
    if(! $cast(cmn_pll0_varcal_tctrl, reg_set[124]))
      `uvm_error("UVM_REG", "cmn_pll0_varcal_tctrl register casting error")
    if(! $cast(cmn_pll0_vcocal_ctrl, reg_set[125]))
      `uvm_error("UVM_REG", "cmn_pll0_vcocal_ctrl register casting error")
    if(! $cast(cmn_pll0_vcocal_init_tmr, reg_set[126]))
      `uvm_error("UVM_REG", "cmn_pll0_vcocal_init_tmr register casting error")
    if(! $cast(cmn_pll0_vcocal_iter_tmr, reg_set[127]))
      `uvm_error("UVM_REG", "cmn_pll0_vcocal_iter_tmr register casting error")
    if(! $cast(cmn_pll0_vcocal_ovrd, reg_set[128]))
      `uvm_error("UVM_REG", "cmn_pll0_vcocal_ovrd register casting error")
    if(! $cast(cmn_pll0_vcocal_pllcnt_start, reg_set[129]))
      `uvm_error("UVM_REG", "cmn_pll0_vcocal_pllcnt_start register casting error")
    if(! $cast(cmn_pll0_vcocal_reftim_start, reg_set[130]))
      `uvm_error("UVM_REG", "cmn_pll0_vcocal_reftim_start register casting error")
    if(! $cast(cmn_pll0_vcocal_start, reg_set[131]))
      `uvm_error("UVM_REG", "cmn_pll0_vcocal_start register casting error")
    if(! $cast(cmn_pll0_vcocal_tctrl, reg_set[132]))
      `uvm_error("UVM_REG", "cmn_pll0_vcocal_tctrl register casting error")
    if(! $cast(cmn_pll1_dsm_diag, reg_set[133]))
      `uvm_error("UVM_REG", "cmn_pll1_dsm_diag register casting error")
    if(! $cast(cmn_pll1_dsm_fbh_ovrd, reg_set[134]))
      `uvm_error("UVM_REG", "cmn_pll1_dsm_fbh_ovrd register casting error")
    if(! $cast(cmn_pll1_dsm_fbl_ovrd, reg_set[135]))
      `uvm_error("UVM_REG", "cmn_pll1_dsm_fbl_ovrd register casting error")
    if(! $cast(cmn_pll1_fracdivh, reg_set[136]))
      `uvm_error("UVM_REG", "cmn_pll1_fracdivh register casting error")
    if(! $cast(cmn_pll1_fracdivl, reg_set[137]))
      `uvm_error("UVM_REG", "cmn_pll1_fracdivl register casting error")
    if(! $cast(cmn_pll1_high_thr, reg_set[138]))
      `uvm_error("UVM_REG", "cmn_pll1_high_thr register casting error")
    if(! $cast(cmn_pll1_intdiv, reg_set[139]))
      `uvm_error("UVM_REG", "cmn_pll1_intdiv register casting error")
    if(! $cast(cmn_pll1_ss_ctrl1, reg_set[140]))
      `uvm_error("UVM_REG", "cmn_pll1_ss_ctrl1 register casting error")
    if(! $cast(cmn_pll1_ss_ctrl2, reg_set[141]))
      `uvm_error("UVM_REG", "cmn_pll1_ss_ctrl2 register casting error")
    if(! $cast(cmn_pll1_ss_ctrl3, reg_set[142]))
      `uvm_error("UVM_REG", "cmn_pll1_ss_ctrl3 register casting error")
    if(! $cast(cmn_pll1_vcocal_ctrl, reg_set[143]))
      `uvm_error("UVM_REG", "cmn_pll1_vcocal_ctrl register casting error")
    if(! $cast(cmn_pll1_vcocal_init_tmr, reg_set[144]))
      `uvm_error("UVM_REG", "cmn_pll1_vcocal_init_tmr register casting error")
    if(! $cast(cmn_pll1_vcocal_iter_tmr, reg_set[145]))
      `uvm_error("UVM_REG", "cmn_pll1_vcocal_iter_tmr register casting error")
    if(! $cast(cmn_pll1_vcocal_ovrd, reg_set[146]))
      `uvm_error("UVM_REG", "cmn_pll1_vcocal_ovrd register casting error")
    if(! $cast(cmn_pll1_vcocal_reftim_start, reg_set[147]))
      `uvm_error("UVM_REG", "cmn_pll1_vcocal_reftim_start register casting error")
    if(! $cast(cmn_pll1_vcocal_start, reg_set[148]))
      `uvm_error("UVM_REG", "cmn_pll1_vcocal_start register casting error")
    if(! $cast(cmn_pll1_vcocal_tctrl, reg_set[149]))
      `uvm_error("UVM_REG", "cmn_pll1_vcocal_tctrl register casting error")
    if(! $cast(cmn_pllsm0_sm_ctrl, reg_set[150]))
      `uvm_error("UVM_REG", "cmn_pllsm0_sm_ctrl register casting error")
    if(! $cast(cmn_pllsm0_st, reg_set[151]))
      `uvm_error("UVM_REG", "cmn_pllsm0_st register casting error")
    if(! $cast(cmn_pllsm0_tmr_1, reg_set[152]))
      `uvm_error("UVM_REG", "cmn_pllsm0_tmr_1 register casting error")
    if(! $cast(cmn_pllsm0_tmr_2, reg_set[153]))
      `uvm_error("UVM_REG", "cmn_pllsm0_tmr_2 register casting error")
    if(! $cast(cmn_pllsm0_tmr_3, reg_set[154]))
      `uvm_error("UVM_REG", "cmn_pllsm0_tmr_3 register casting error")
    if(! $cast(cmn_pllsm0_tmr_4, reg_set[155]))
      `uvm_error("UVM_REG", "cmn_pllsm0_tmr_4 register casting error")
    if(! $cast(cmn_pllsm1_sm_ctrl0, reg_set[156]))
      `uvm_error("UVM_REG", "cmn_pllsm1_sm_ctrl0 register casting error")
    if(! $cast(cmn_pllsm1_sm_ctrl1, reg_set[157]))
      `uvm_error("UVM_REG", "cmn_pllsm1_sm_ctrl1 register casting error")
    if(! $cast(cmn_pllsm1_st, reg_set[158]))
      `uvm_error("UVM_REG", "cmn_pllsm1_st register casting error")
    if(! $cast(cmn_pllsm1_tmr_1, reg_set[159]))
      `uvm_error("UVM_REG", "cmn_pllsm1_tmr_1 register casting error")
    if(! $cast(cmn_pllsm1_tmr_2, reg_set[160]))
      `uvm_error("UVM_REG", "cmn_pllsm1_tmr_2 register casting error")
    if(! $cast(cmn_pllsm1_tmr_3, reg_set[161]))
      `uvm_error("UVM_REG", "cmn_pllsm1_tmr_3 register casting error")
    if(! $cast(cmn_pllsm1_tmr_4, reg_set[162]))
      `uvm_error("UVM_REG", "cmn_pllsm1_tmr_4 register casting error")
    if(! $cast(cmn_pllsm1_tmr_5, reg_set[163]))
      `uvm_error("UVM_REG", "cmn_pllsm1_tmr_5 register casting error")
    if(! $cast(cmn_pllsm1_tmr_6, reg_set[164]))
      `uvm_error("UVM_REG", "cmn_pllsm1_tmr_6 register casting error")
    if(! $cast(cmn_pllsm1_tmr_7, reg_set[165]))
      `uvm_error("UVM_REG", "cmn_pllsm1_tmr_7 register casting error")
    if(! $cast(cmn_pllsm1_tmr_8, reg_set[166]))
      `uvm_error("UVM_REG", "cmn_pllsm1_tmr_8 register casting error")
    if(! $cast(cmn_rxcal_ctrl, reg_set[167]))
      `uvm_error("UVM_REG", "cmn_rxcal_ctrl register casting error")
    if(! $cast(cmn_rxcal_init_tmr, reg_set[168]))
      `uvm_error("UVM_REG", "cmn_rxcal_init_tmr register casting error")
    if(! $cast(cmn_rxcal_iter_tmr, reg_set[169]))
      `uvm_error("UVM_REG", "cmn_rxcal_iter_tmr register casting error")
    if(! $cast(cmn_rxcal_ovrd, reg_set[170]))
      `uvm_error("UVM_REG", "cmn_rxcal_ovrd register casting error")
    if(! $cast(cmn_rxcal_start, reg_set[171]))
      `uvm_error("UVM_REG", "cmn_rxcal_start register casting error")
    if(! $cast(cmn_rxcal_tune, reg_set[172]))
      `uvm_error("UVM_REG", "cmn_rxcal_tune register casting error")
    if(! $cast(cmn_sd_cal_ctrl, reg_set[173]))
      `uvm_error("UVM_REG", "cmn_sd_cal_ctrl register casting error")
    if(! $cast(cmn_sd_cal_init_tmr, reg_set[174]))
      `uvm_error("UVM_REG", "cmn_sd_cal_init_tmr register casting error")
    if(! $cast(cmn_sd_cal_iter_tmr, reg_set[175]))
      `uvm_error("UVM_REG", "cmn_sd_cal_iter_tmr register casting error")
    if(! $cast(cmn_sd_cal_ovrd, reg_set[176]))
      `uvm_error("UVM_REG", "cmn_sd_cal_ovrd register casting error")
    if(! $cast(cmn_sd_cal_pllcnt_start, reg_set[177]))
      `uvm_error("UVM_REG", "cmn_sd_cal_pllcnt_start register casting error")
    if(! $cast(cmn_sd_cal_reftim_start, reg_set[178]))
      `uvm_error("UVM_REG", "cmn_sd_cal_reftim_start register casting error")
    if(! $cast(cmn_sd_cal_start, reg_set[179]))
      `uvm_error("UVM_REG", "cmn_sd_cal_start register casting error")
    if(! $cast(cmn_sd_cal_tctrl, reg_set[180]))
      `uvm_error("UVM_REG", "cmn_sd_cal_tctrl register casting error")
    if(! $cast(cmn_ssm_sm_ctrl, reg_set[181]))
      `uvm_error("UVM_REG", "cmn_ssm_sm_ctrl register casting error")
    if(! $cast(cmn_ssm_st, reg_set[182]))
      `uvm_error("UVM_REG", "cmn_ssm_st register casting error")
    if(! $cast(cmn_ssm_tmr_1, reg_set[183]))
      `uvm_error("UVM_REG", "cmn_ssm_tmr_1 register casting error")
    if(! $cast(cmn_ssm_tmr_2, reg_set[184]))
      `uvm_error("UVM_REG", "cmn_ssm_tmr_2 register casting error")
    if(! $cast(cmn_txpdcal_ctrl, reg_set[185]))
      `uvm_error("UVM_REG", "cmn_txpdcal_ctrl register casting error")
    if(! $cast(cmn_txpdcal_init_tmr, reg_set[186]))
      `uvm_error("UVM_REG", "cmn_txpdcal_init_tmr register casting error")
    if(! $cast(cmn_txpdcal_iter_tmr, reg_set[187]))
      `uvm_error("UVM_REG", "cmn_txpdcal_iter_tmr register casting error")
    if(! $cast(cmn_txpdcal_ovrd, reg_set[188]))
      `uvm_error("UVM_REG", "cmn_txpdcal_ovrd register casting error")
    if(! $cast(cmn_txpdcal_start, reg_set[189]))
      `uvm_error("UVM_REG", "cmn_txpdcal_start register casting error")
    if(! $cast(cmn_txpdcal_tune, reg_set[190]))
      `uvm_error("UVM_REG", "cmn_txpdcal_tune register casting error")
    if(! $cast(cmn_txpucal_ctrl, reg_set[191]))
      `uvm_error("UVM_REG", "cmn_txpucal_ctrl register casting error")
    if(! $cast(cmn_txpucal_init_tmr, reg_set[192]))
      `uvm_error("UVM_REG", "cmn_txpucal_init_tmr register casting error")
    if(! $cast(cmn_txpucal_iter_tmr, reg_set[193]))
      `uvm_error("UVM_REG", "cmn_txpucal_iter_tmr register casting error")
    if(! $cast(cmn_txpucal_ovrd, reg_set[194]))
      `uvm_error("UVM_REG", "cmn_txpucal_ovrd register casting error")
    if(! $cast(cmn_txpucal_start, reg_set[195]))
      `uvm_error("UVM_REG", "cmn_txpucal_start register casting error")
    if(! $cast(cmn_txpucal_tune, reg_set[196]))
      `uvm_error("UVM_REG", "cmn_txpucal_tune register casting error")

  endfunction

  function new(input string name="sd3101_t4_registers_sd3101_phy_registers");
    super.new(name, UVM_NO_COVERAGE);
  endfunction

endclass


/////////////////////////////////////////////////////
//                pma_cmn_registers
/////////////////////////////////////////////////////
class pma_cmn_registers_vendor_cadence_library_cdns_lib_version_1685_2009 extends cdns_uvm_reg_block;

  `uvm_object_utils(pma_cmn_registers_vendor_cadence_library_cdns_lib_version_1685_2009)

  uvm_reg_map default_map;
  uvm_reg_map sd3101_t4_registers;
  rand T_sd3101_phy_registers_1183 sd3101_t4_registers_sd3101_phy_registers;

`include "cdn_regmodel_task_member.sv"
  virtual function void build();
    sd3101_t4_registers = create_map("sd3101_t4_registers", `UVM_REG_ADDR_WIDTH'h0, 4, UVM_LITTLE_ENDIAN, 1);
    default_map = sd3101_t4_registers;
    sd3101_t4_registers_sd3101_phy_registers = T_sd3101_phy_registers_1183::type_id::create("sd3101_t4_registers_sd3101_phy_registers", , get_full_name());
    sd3101_t4_registers_sd3101_phy_registers.configure(this);
    sd3101_t4_registers_sd3101_phy_registers.build();

    //Mapping sd3101_t4_registers map
    sd3101_t4_registers_sd3101_phy_registers.default_map.add_parent_map(sd3101_t4_registers,`UVM_REG_ADDR_WIDTH'h0);
    sd3101_t4_registers.set_submap_offset(sd3101_t4_registers_sd3101_phy_registers.default_map, `UVM_REG_ADDR_WIDTH'h0);
    //Apply hdl_paths
    apply_hdl_paths(this);

  endfunction



  function new(input string name="pma_cmn_registers");
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
         "T_cmn_bgcal_ctrl_1033": begin T_cmn_bgcal_ctrl_1033 cmn_bgcal_ctrl = new(objectname); create = cmn_bgcal_ctrl;  end
         "T_cmn_bgcal_init_tmr_1037": begin T_cmn_bgcal_init_tmr_1037 cmn_bgcal_init_tmr = new(objectname); create = cmn_bgcal_init_tmr;  end
         "T_cmn_bgcal_iter_tmr_1038": begin T_cmn_bgcal_iter_tmr_1038 cmn_bgcal_iter_tmr = new(objectname); create = cmn_bgcal_iter_tmr;  end
         "T_cmn_bgcal_ovrd_1034": begin T_cmn_bgcal_ovrd_1034 cmn_bgcal_ovrd = new(objectname); create = cmn_bgcal_ovrd;  end
         "T_cmn_bgcal_start_1035": begin T_cmn_bgcal_start_1035 cmn_bgcal_start = new(objectname); create = cmn_bgcal_start;  end
         "T_cmn_bgcal_tune_1036": begin T_cmn_bgcal_tune_1036 cmn_bgcal_tune = new(objectname); create = cmn_bgcal_tune;  end
         "T_cmn_cdiag_ccal_pwri_ovrd_1023": begin T_cmn_cdiag_ccal_pwri_ovrd_1023 cmn_cdiag_ccal_pwri_ovrd = new(objectname); create = cmn_cdiag_ccal_pwri_ovrd;  end
         "T_cmn_cdiag_dcya_1032": begin T_cmn_cdiag_dcya_1032 cmn_cdiag_dcya = new(objectname); create = cmn_cdiag_dcya;  end
         "T_cmn_cdiag_diag_pwri_ovrd_1025": begin T_cmn_cdiag_diag_pwri_ovrd_1025 cmn_cdiag_diag_pwri_ovrd = new(objectname); create = cmn_cdiag_diag_pwri_ovrd;  end
         "T_cmn_cdiag_pllc_pwri_ovrd_1022": begin T_cmn_cdiag_pllc_pwri_ovrd_1022 cmn_cdiag_pllc_pwri_ovrd = new(objectname); create = cmn_cdiag_pllc_pwri_ovrd;  end
         "T_cmn_cdiag_pllsm_calmc_cs_1030": begin T_cmn_cdiag_pllsm_calmc_cs_1030 cmn_cdiag_pllsm_calmc_cs = new(objectname); create = cmn_cdiag_pllsm_calmc_cs;  end
         "T_cmn_cdiag_psmclk_ctrl_1027": begin T_cmn_cdiag_psmclk_ctrl_1027 cmn_cdiag_psmclk_ctrl = new(objectname); create = cmn_cdiag_psmclk_ctrl;  end
         "T_cmn_cdiag_pwri_tmr_1021": begin T_cmn_cdiag_pwri_tmr_1021 cmn_cdiag_pwri_tmr = new(objectname); create = cmn_cdiag_pwri_tmr;  end
         "T_cmn_cdiag_refclk_ctrl_1026": begin T_cmn_cdiag_refclk_ctrl_1026 cmn_cdiag_refclk_ctrl = new(objectname); create = cmn_cdiag_refclk_ctrl;  end
         "T_cmn_cdiag_rst_diag_1031": begin T_cmn_cdiag_rst_diag_1031 cmn_cdiag_rst_diag = new(objectname); create = cmn_cdiag_rst_diag;  end
         "T_cmn_cdiag_sdosc_ctrl_1028": begin T_cmn_cdiag_sdosc_ctrl_1028 cmn_cdiag_sdosc_ctrl = new(objectname); create = cmn_cdiag_sdosc_ctrl;  end
         "T_cmn_cdiag_ssm_calmc_cs_1029": begin T_cmn_cdiag_ssm_calmc_cs_1029 cmn_cdiag_ssm_calmc_cs = new(objectname); create = cmn_cdiag_ssm_calmc_cs;  end
         "T_cmn_cdiag_xcvrc_pwri_ovrd_1024": begin T_cmn_cdiag_xcvrc_pwri_ovrd_1024 cmn_cdiag_xcvrc_pwri_ovrd = new(objectname); create = cmn_cdiag_xcvrc_pwri_ovrd;  end
         "T_cmn_cmsmt_clk_freq_msmt_ctrl_1122": begin T_cmn_cmsmt_clk_freq_msmt_ctrl_1122 cmn_cmsmt_clk_freq_msmt_ctrl = new(objectname); create = cmn_cmsmt_clk_freq_msmt_ctrl;  end
         "T_cmn_cmsmt_ref_clk_tmr_value_1124": begin T_cmn_cmsmt_ref_clk_tmr_value_1124 cmn_cmsmt_ref_clk_tmr_value = new(objectname); create = cmn_cmsmt_ref_clk_tmr_value;  end
         "T_cmn_cmsmt_test_clk_cnt_value_1125": begin T_cmn_cmsmt_test_clk_cnt_value_1125 cmn_cmsmt_test_clk_cnt_value = new(objectname); create = cmn_cmsmt_test_clk_cnt_value;  end
         "T_cmn_cmsmt_test_clk_sel_1123": begin T_cmn_cmsmt_test_clk_sel_1123 cmn_cmsmt_test_clk_sel = new(objectname); create = cmn_cmsmt_test_clk_sel;  end
         "T_cmn_diag_atb_adc_ctrl_1170": begin T_cmn_diag_atb_adc_ctrl_1170 cmn_diag_atb_adc_ctrl = new(objectname); create = cmn_diag_atb_adc_ctrl;  end
         "T_cmn_diag_atb_ctrl_1169": begin T_cmn_diag_atb_ctrl_1169 cmn_diag_atb_ctrl = new(objectname); create = cmn_diag_atb_ctrl;  end
         "T_cmn_diag_bandgap_ovrd_1164": begin T_cmn_diag_bandgap_ovrd_1164 cmn_diag_bandgap_ovrd = new(objectname); create = cmn_diag_bandgap_ovrd;  end
         "T_cmn_diag_bias_adj_1179": begin T_cmn_diag_bias_adj_1179 cmn_diag_bias_adj = new(objectname); create = cmn_diag_bias_adj;  end
         "T_cmn_diag_bias_ovrd_1165": begin T_cmn_diag_bias_ovrd_1165 cmn_diag_bias_ovrd = new(objectname); create = cmn_diag_bias_ovrd;  end
         "T_cmn_diag_cal_filt_ctrl_1177": begin T_cmn_diag_cal_filt_ctrl_1177 cmn_diag_cal_filt_ctrl = new(objectname); create = cmn_diag_cal_filt_ctrl;  end
         "T_cmn_diag_cya_1173": begin T_cmn_diag_cya_1173 cmn_diag_cya = new(objectname); create = cmn_diag_cya;  end
         "T_cmn_diag_gpana_1_1174": begin T_cmn_diag_gpana_1_1174 cmn_diag_gpana_1 = new(objectname); create = cmn_diag_gpana_1;  end
         "T_cmn_diag_gpana_2_1175": begin T_cmn_diag_gpana_2_1175 cmn_diag_gpana_2 = new(objectname); create = cmn_diag_gpana_2;  end
         "T_cmn_diag_gpana_st_1176": begin T_cmn_diag_gpana_st_1176 cmn_diag_gpana_st = new(objectname); create = cmn_diag_gpana_st;  end
         "T_cmn_diag_hsrrsm_ctrl_1171": begin T_cmn_diag_hsrrsm_ctrl_1171 cmn_diag_hsrrsm_ctrl = new(objectname); create = cmn_diag_hsrrsm_ctrl;  end
         "T_cmn_diag_mom_osc_ctrl_1178": begin T_cmn_diag_mom_osc_ctrl_1178 cmn_diag_mom_osc_ctrl = new(objectname); create = cmn_diag_mom_osc_ctrl;  end
         "T_cmn_diag_pm_ctrl_1166": begin T_cmn_diag_pm_ctrl_1166 cmn_diag_pm_ctrl = new(objectname); create = cmn_diag_pm_ctrl;  end
         "T_cmn_diag_rst_diag_1172": begin T_cmn_diag_rst_diag_1172 cmn_diag_rst_diag = new(objectname); create = cmn_diag_rst_diag;  end
         "T_cmn_diag_sh_bg_res_1167": begin T_cmn_diag_sh_bg_res_1167 cmn_diag_sh_bg_res = new(objectname); create = cmn_diag_sh_bg_res;  end
         "T_cmn_diag_sh_sdclk_1168": begin T_cmn_diag_sh_sdclk_1168 cmn_diag_sh_sdclk = new(objectname); create = cmn_diag_sh_sdclk;  end
         "T_cmn_diag_tmpsns_ana_ctrl_1180": begin T_cmn_diag_tmpsns_ana_ctrl_1180 cmn_diag_tmpsns_ana_ctrl = new(objectname); create = cmn_diag_tmpsns_ana_ctrl;  end
         "T_cmn_diag_tmpsns_filt_ctrl_1181": begin T_cmn_diag_tmpsns_filt_ctrl_1181 cmn_diag_tmpsns_filt_ctrl = new(objectname); create = cmn_diag_tmpsns_filt_ctrl;  end
         "T_cmn_diag_tmpsns_filt_out_1182": begin T_cmn_diag_tmpsns_filt_out_1182 cmn_diag_tmpsns_filt_out = new(objectname); create = cmn_diag_tmpsns_filt_out;  end
         "T_cmn_ibcal_ctrl_1039": begin T_cmn_ibcal_ctrl_1039 cmn_ibcal_ctrl = new(objectname); create = cmn_ibcal_ctrl;  end
         "T_cmn_ibcal_init_tmr_1043": begin T_cmn_ibcal_init_tmr_1043 cmn_ibcal_init_tmr = new(objectname); create = cmn_ibcal_init_tmr;  end
         "T_cmn_ibcal_iter_tmr_1044": begin T_cmn_ibcal_iter_tmr_1044 cmn_ibcal_iter_tmr = new(objectname); create = cmn_ibcal_iter_tmr;  end
         "T_cmn_ibcal_ovrd_1040": begin T_cmn_ibcal_ovrd_1040 cmn_ibcal_ovrd = new(objectname); create = cmn_ibcal_ovrd;  end
         "T_cmn_ibcal_start_1041": begin T_cmn_ibcal_start_1041 cmn_ibcal_start = new(objectname); create = cmn_ibcal_start;  end
         "T_cmn_ibcal_tune_1042": begin T_cmn_ibcal_tune_1042 cmn_ibcal_tune = new(objectname); create = cmn_ibcal_tune;  end
         "T_cmn_pdiag_pll0_cp_iadj_m0_1130": begin T_cmn_pdiag_pll0_cp_iadj_m0_1130 cmn_pdiag_pll0_cp_iadj_m0 = new(objectname); create = cmn_pdiag_pll0_cp_iadj_m0;  end
         "T_cmn_pdiag_pll0_cp_iadj_m1_1139": begin T_cmn_pdiag_pll0_cp_iadj_m1_1139 cmn_pdiag_pll0_cp_iadj_m1 = new(objectname); create = cmn_pdiag_pll0_cp_iadj_m1;  end
         "T_cmn_pdiag_pll0_cp_padj_m0_1129": begin T_cmn_pdiag_pll0_cp_padj_m0_1129 cmn_pdiag_pll0_cp_padj_m0 = new(objectname); create = cmn_pdiag_pll0_cp_padj_m0;  end
         "T_cmn_pdiag_pll0_cp_padj_m1_1138": begin T_cmn_pdiag_pll0_cp_padj_m1_1138 cmn_pdiag_pll0_cp_padj_m1 = new(objectname); create = cmn_pdiag_pll0_cp_padj_m1;  end
         "T_cmn_pdiag_pll0_ctrl_m0_1126": begin T_cmn_pdiag_pll0_ctrl_m0_1126 cmn_pdiag_pll0_ctrl_m0 = new(objectname); create = cmn_pdiag_pll0_ctrl_m0;  end
         "T_cmn_pdiag_pll0_ctrl_m1_1135": begin T_cmn_pdiag_pll0_ctrl_m1_1135 cmn_pdiag_pll0_ctrl_m1 = new(objectname); create = cmn_pdiag_pll0_ctrl_m1;  end
         "T_cmn_pdiag_pll0_filt_padj_m0_1131": begin T_cmn_pdiag_pll0_filt_padj_m0_1131 cmn_pdiag_pll0_filt_padj_m0 = new(objectname); create = cmn_pdiag_pll0_filt_padj_m0;  end
         "T_cmn_pdiag_pll0_filt_padj_m1_1140": begin T_cmn_pdiag_pll0_filt_padj_m1_1140 cmn_pdiag_pll0_filt_padj_m1 = new(objectname); create = cmn_pdiag_pll0_filt_padj_m1;  end
         "T_cmn_pdiag_pll0_pkvco_bw_ctrl_m0_1128": begin T_cmn_pdiag_pll0_pkvco_bw_ctrl_m0_1128 cmn_pdiag_pll0_pkvco_bw_ctrl_m0 = new(objectname); create = cmn_pdiag_pll0_pkvco_bw_ctrl_m0;  end
         "T_cmn_pdiag_pll0_pkvco_bw_ctrl_m1_1137": begin T_cmn_pdiag_pll0_pkvco_bw_ctrl_m1_1137 cmn_pdiag_pll0_pkvco_bw_ctrl_m1 = new(objectname); create = cmn_pdiag_pll0_pkvco_bw_ctrl_m1;  end
         "T_cmn_pdiag_pll0_post_div_m0_1134": begin T_cmn_pdiag_pll0_post_div_m0_1134 cmn_pdiag_pll0_post_div_m0 = new(objectname); create = cmn_pdiag_pll0_post_div_m0;  end
         "T_cmn_pdiag_pll0_post_div_m1_1143": begin T_cmn_pdiag_pll0_post_div_m1_1143 cmn_pdiag_pll0_post_div_m1 = new(objectname); create = cmn_pdiag_pll0_post_div_m1;  end
         "T_cmn_pdiag_pll0_prog0_clk_ctrl_m0_1132": begin T_cmn_pdiag_pll0_prog0_clk_ctrl_m0_1132 cmn_pdiag_pll0_prog0_clk_ctrl_m0 = new(objectname); create = cmn_pdiag_pll0_prog0_clk_ctrl_m0;  end
         "T_cmn_pdiag_pll0_prog0_clk_ctrl_m1_1141": begin T_cmn_pdiag_pll0_prog0_clk_ctrl_m1_1141 cmn_pdiag_pll0_prog0_clk_ctrl_m1 = new(objectname); create = cmn_pdiag_pll0_prog0_clk_ctrl_m1;  end
         "T_cmn_pdiag_pll0_prog1_clk_ctrl_m0_1133": begin T_cmn_pdiag_pll0_prog1_clk_ctrl_m0_1133 cmn_pdiag_pll0_prog1_clk_ctrl_m0 = new(objectname); create = cmn_pdiag_pll0_prog1_clk_ctrl_m0;  end
         "T_cmn_pdiag_pll0_prog1_clk_ctrl_m1_1142": begin T_cmn_pdiag_pll0_prog1_clk_ctrl_m1_1142 cmn_pdiag_pll0_prog1_clk_ctrl_m1 = new(objectname); create = cmn_pdiag_pll0_prog1_clk_ctrl_m1;  end
         "T_cmn_pdiag_pll0_tune_m0_1127": begin T_cmn_pdiag_pll0_tune_m0_1127 cmn_pdiag_pll0_tune_m0 = new(objectname); create = cmn_pdiag_pll0_tune_m0;  end
         "T_cmn_pdiag_pll0_tune_m1_1136": begin T_cmn_pdiag_pll0_tune_m1_1136 cmn_pdiag_pll0_tune_m1 = new(objectname); create = cmn_pdiag_pll0_tune_m1;  end
         "T_cmn_pdiag_pll1_cp_ctrl_m0_1146": begin T_cmn_pdiag_pll1_cp_ctrl_m0_1146 cmn_pdiag_pll1_cp_ctrl_m0 = new(objectname); create = cmn_pdiag_pll1_cp_ctrl_m0;  end
         "T_cmn_pdiag_pll1_cp_ctrl_m1_1156": begin T_cmn_pdiag_pll1_cp_ctrl_m1_1156 cmn_pdiag_pll1_cp_ctrl_m1 = new(objectname); create = cmn_pdiag_pll1_cp_ctrl_m1;  end
         "T_cmn_pdiag_pll1_lock_det_ctrl_m0_1149": begin T_cmn_pdiag_pll1_lock_det_ctrl_m0_1149 cmn_pdiag_pll1_lock_det_ctrl_m0 = new(objectname); create = cmn_pdiag_pll1_lock_det_ctrl_m0;  end
         "T_cmn_pdiag_pll1_lock_det_ctrl_m1_1159": begin T_cmn_pdiag_pll1_lock_det_ctrl_m1_1159 cmn_pdiag_pll1_lock_det_ctrl_m1 = new(objectname); create = cmn_pdiag_pll1_lock_det_ctrl_m1;  end
         "T_cmn_pdiag_pll1_lpf_ctrl_m0_1147": begin T_cmn_pdiag_pll1_lpf_ctrl_m0_1147 cmn_pdiag_pll1_lpf_ctrl_m0 = new(objectname); create = cmn_pdiag_pll1_lpf_ctrl_m0;  end
         "T_cmn_pdiag_pll1_lpf_ctrl_m1_1157": begin T_cmn_pdiag_pll1_lpf_ctrl_m1_1157 cmn_pdiag_pll1_lpf_ctrl_m1 = new(objectname); create = cmn_pdiag_pll1_lpf_ctrl_m1;  end
         "T_cmn_pdiag_pll1_pfd_ctrl_m0_1145": begin T_cmn_pdiag_pll1_pfd_ctrl_m0_1145 cmn_pdiag_pll1_pfd_ctrl_m0 = new(objectname); create = cmn_pdiag_pll1_pfd_ctrl_m0;  end
         "T_cmn_pdiag_pll1_pfd_ctrl_m1_1155": begin T_cmn_pdiag_pll1_pfd_ctrl_m1_1155 cmn_pdiag_pll1_pfd_ctrl_m1 = new(objectname); create = cmn_pdiag_pll1_pfd_ctrl_m1;  end
         "T_cmn_pdiag_pll1_post_div_m0_1150": begin T_cmn_pdiag_pll1_post_div_m0_1150 cmn_pdiag_pll1_post_div_m0 = new(objectname); create = cmn_pdiag_pll1_post_div_m0;  end
         "T_cmn_pdiag_pll1_post_div_m1_1160": begin T_cmn_pdiag_pll1_post_div_m1_1160 cmn_pdiag_pll1_post_div_m1 = new(objectname); create = cmn_pdiag_pll1_post_div_m1;  end
         "T_cmn_pdiag_pll1_prog0_clk_ctrl_m0_1152": begin T_cmn_pdiag_pll1_prog0_clk_ctrl_m0_1152 cmn_pdiag_pll1_prog0_clk_ctrl_m0 = new(objectname); create = cmn_pdiag_pll1_prog0_clk_ctrl_m0;  end
         "T_cmn_pdiag_pll1_prog0_clk_ctrl_m1_1162": begin T_cmn_pdiag_pll1_prog0_clk_ctrl_m1_1162 cmn_pdiag_pll1_prog0_clk_ctrl_m1 = new(objectname); create = cmn_pdiag_pll1_prog0_clk_ctrl_m1;  end
         "T_cmn_pdiag_pll1_prog1_clk_ctrl_m0_1153": begin T_cmn_pdiag_pll1_prog1_clk_ctrl_m0_1153 cmn_pdiag_pll1_prog1_clk_ctrl_m0 = new(objectname); create = cmn_pdiag_pll1_prog1_clk_ctrl_m0;  end
         "T_cmn_pdiag_pll1_prog1_clk_ctrl_m1_1163": begin T_cmn_pdiag_pll1_prog1_clk_ctrl_m1_1163 cmn_pdiag_pll1_prog1_clk_ctrl_m1 = new(objectname); create = cmn_pdiag_pll1_prog1_clk_ctrl_m1;  end
         "T_cmn_pdiag_pll1_ref_clk_div_sel_m0_1151": begin T_cmn_pdiag_pll1_ref_clk_div_sel_m0_1151 cmn_pdiag_pll1_ref_clk_div_sel_m0 = new(objectname); create = cmn_pdiag_pll1_ref_clk_div_sel_m0;  end
         "T_cmn_pdiag_pll1_ref_clk_div_sel_m1_1161": begin T_cmn_pdiag_pll1_ref_clk_div_sel_m1_1161 cmn_pdiag_pll1_ref_clk_div_sel_m1 = new(objectname); create = cmn_pdiag_pll1_ref_clk_div_sel_m1;  end
         "T_cmn_pdiag_pll1_vco_ctrl_m0_1148": begin T_cmn_pdiag_pll1_vco_ctrl_m0_1148 cmn_pdiag_pll1_vco_ctrl_m0 = new(objectname); create = cmn_pdiag_pll1_vco_ctrl_m0;  end
         "T_cmn_pdiag_pll1_vco_ctrl_m1_1158": begin T_cmn_pdiag_pll1_vco_ctrl_m1_1158 cmn_pdiag_pll1_vco_ctrl_m1 = new(objectname); create = cmn_pdiag_pll1_vco_ctrl_m1;  end
         "T_cmn_pdiag_pll1_vreg_adj_m0_1144": begin T_cmn_pdiag_pll1_vreg_adj_m0_1144 cmn_pdiag_pll1_vreg_adj_m0 = new(objectname); create = cmn_pdiag_pll1_vreg_adj_m0;  end
         "T_cmn_pdiag_pll1_vreg_adj_m1_1154": begin T_cmn_pdiag_pll1_vreg_adj_m1_1154 cmn_pdiag_pll1_vreg_adj_m1 = new(objectname); create = cmn_pdiag_pll1_vreg_adj_m1;  end
         "T_cmn_pid_flv0_991": begin T_cmn_pid_flv0_991 cmn_pid_flv0 = new(objectname); create = cmn_pid_flv0;  end
         "T_cmn_pid_flv1_992": begin T_cmn_pid_flv1_992 cmn_pid_flv1 = new(objectname); create = cmn_pid_flv1;  end
         "T_cmn_pid_iov_993": begin T_cmn_pid_iov_993 cmn_pid_iov = new(objectname); create = cmn_pid_iov;  end
         "T_cmn_pid_lanes_994": begin T_cmn_pid_lanes_994 cmn_pid_lanes = new(objectname); create = cmn_pid_lanes;  end
         "T_cmn_pid_metal0_995": begin T_cmn_pid_metal0_995 cmn_pid_metal0 = new(objectname); create = cmn_pid_metal0;  end
         "T_cmn_pid_metal1_996": begin T_cmn_pid_metal1_996 cmn_pid_metal1 = new(objectname); create = cmn_pid_metal1;  end
         "T_cmn_pid_metal2_997": begin T_cmn_pid_metal2_997 cmn_pid_metal2 = new(objectname); create = cmn_pid_metal2;  end
         "T_cmn_pid_metal3_998": begin T_cmn_pid_metal3_998 cmn_pid_metal3 = new(objectname); create = cmn_pid_metal3;  end
         "T_cmn_pid_metald_999": begin T_cmn_pid_metald_999 cmn_pid_metald = new(objectname); create = cmn_pid_metald;  end
         "T_cmn_pid_mfg_989": begin T_cmn_pid_mfg_989 cmn_pid_mfg = new(objectname); create = cmn_pid_mfg;  end
         "T_cmn_pid_node_990": begin T_cmn_pid_node_990 cmn_pid_node = new(objectname); create = cmn_pid_node;  end
         "T_cmn_pid_num_987": begin T_cmn_pid_num_987 cmn_pid_num = new(objectname); create = cmn_pid_num;  end
         "T_cmn_pid_rev_988": begin T_cmn_pid_rev_988 cmn_pid_rev = new(objectname); create = cmn_pid_rev;  end
         "T_cmn_pid_type_986": begin T_cmn_pid_type_986 cmn_pid_type = new(objectname); create = cmn_pid_type;  end
         "T_cmn_pll0_dsm_diag_1057": begin T_cmn_pll0_dsm_diag_1057 cmn_pll0_dsm_diag = new(objectname); create = cmn_pll0_dsm_diag;  end
         "T_cmn_pll0_dsm_fbh_ovrd_1058": begin T_cmn_pll0_dsm_fbh_ovrd_1058 cmn_pll0_dsm_fbh_ovrd = new(objectname); create = cmn_pll0_dsm_fbh_ovrd;  end
         "T_cmn_pll0_dsm_fbl_ovrd_1059": begin T_cmn_pll0_dsm_fbl_ovrd_1059 cmn_pll0_dsm_fbl_ovrd = new(objectname); create = cmn_pll0_dsm_fbl_ovrd;  end
         "T_cmn_pll0_fracdivh_1055": begin T_cmn_pll0_fracdivh_1055 cmn_pll0_fracdivh = new(objectname); create = cmn_pll0_fracdivh;  end
         "T_cmn_pll0_fracdivl_1054": begin T_cmn_pll0_fracdivl_1054 cmn_pll0_fracdivl = new(objectname); create = cmn_pll0_fracdivl;  end
         "T_cmn_pll0_high_thr_1056": begin T_cmn_pll0_high_thr_1056 cmn_pll0_high_thr = new(objectname); create = cmn_pll0_high_thr;  end
         "T_cmn_pll0_intdiv_1053": begin T_cmn_pll0_intdiv_1053 cmn_pll0_intdiv = new(objectname); create = cmn_pll0_intdiv;  end
         "T_cmn_pll0_lock_pllcnt_start_1065": begin T_cmn_pll0_lock_pllcnt_start_1065 cmn_pll0_lock_pllcnt_start = new(objectname); create = cmn_pll0_lock_pllcnt_start;  end
         "T_cmn_pll0_lock_pllcnt_thr_1066": begin T_cmn_pll0_lock_pllcnt_thr_1066 cmn_pll0_lock_pllcnt_thr = new(objectname); create = cmn_pll0_lock_pllcnt_thr;  end
         "T_cmn_pll0_lock_refcnt_idle_1064": begin T_cmn_pll0_lock_refcnt_idle_1064 cmn_pll0_lock_refcnt_idle = new(objectname); create = cmn_pll0_lock_refcnt_idle;  end
         "T_cmn_pll0_lock_refcnt_start_1063": begin T_cmn_pll0_lock_refcnt_start_1063 cmn_pll0_lock_refcnt_start = new(objectname); create = cmn_pll0_lock_refcnt_start;  end
         "T_cmn_pll0_ss_ctrl1_1060": begin T_cmn_pll0_ss_ctrl1_1060 cmn_pll0_ss_ctrl1 = new(objectname); create = cmn_pll0_ss_ctrl1;  end
         "T_cmn_pll0_ss_ctrl2_1061": begin T_cmn_pll0_ss_ctrl2_1061 cmn_pll0_ss_ctrl2 = new(objectname); create = cmn_pll0_ss_ctrl2;  end
         "T_cmn_pll0_ss_ctrl3_1062": begin T_cmn_pll0_ss_ctrl3_1062 cmn_pll0_ss_ctrl3 = new(objectname); create = cmn_pll0_ss_ctrl3;  end
         "T_cmn_pll0_varcal_ctrl_1067": begin T_cmn_pll0_varcal_ctrl_1067 cmn_pll0_varcal_ctrl = new(objectname); create = cmn_pll0_varcal_ctrl;  end
         "T_cmn_pll0_varcal_icvf_cfg_1075": begin T_cmn_pll0_varcal_icvf_cfg_1075 cmn_pll0_varcal_icvf_cfg = new(objectname); create = cmn_pll0_varcal_icvf_cfg;  end
         "T_cmn_pll0_varcal_icvf_hstat_1077": begin T_cmn_pll0_varcal_icvf_hstat_1077 cmn_pll0_varcal_icvf_hstat = new(objectname); create = cmn_pll0_varcal_icvf_hstat;  end
         "T_cmn_pll0_varcal_icvf_init_tmr_1074": begin T_cmn_pll0_varcal_icvf_init_tmr_1074 cmn_pll0_varcal_icvf_init_tmr = new(objectname); create = cmn_pll0_varcal_icvf_init_tmr;  end
         "T_cmn_pll0_varcal_icvf_lstat_1076": begin T_cmn_pll0_varcal_icvf_lstat_1076 cmn_pll0_varcal_icvf_lstat = new(objectname); create = cmn_pll0_varcal_icvf_lstat;  end
         "T_cmn_pll0_varcal_init_tmr_1071": begin T_cmn_pll0_varcal_init_tmr_1071 cmn_pll0_varcal_init_tmr = new(objectname); create = cmn_pll0_varcal_init_tmr;  end
         "T_cmn_pll0_varcal_iter_tmr_1072": begin T_cmn_pll0_varcal_iter_tmr_1072 cmn_pll0_varcal_iter_tmr = new(objectname); create = cmn_pll0_varcal_iter_tmr;  end
         "T_cmn_pll0_varcal_ovrd_1070": begin T_cmn_pll0_varcal_ovrd_1070 cmn_pll0_varcal_ovrd = new(objectname); create = cmn_pll0_varcal_ovrd;  end
         "T_cmn_pll0_varcal_pllcnt_ovrd_1078": begin T_cmn_pll0_varcal_pllcnt_ovrd_1078 cmn_pll0_varcal_pllcnt_ovrd = new(objectname); create = cmn_pll0_varcal_pllcnt_ovrd;  end
         "T_cmn_pll0_varcal_reftim_start_1073": begin T_cmn_pll0_varcal_reftim_start_1073 cmn_pll0_varcal_reftim_start = new(objectname); create = cmn_pll0_varcal_reftim_start;  end
         "T_cmn_pll0_varcal_start_1068": begin T_cmn_pll0_varcal_start_1068 cmn_pll0_varcal_start = new(objectname); create = cmn_pll0_varcal_start;  end
         "T_cmn_pll0_varcal_tctrl_1069": begin T_cmn_pll0_varcal_tctrl_1069 cmn_pll0_varcal_tctrl = new(objectname); create = cmn_pll0_varcal_tctrl;  end
         "T_cmn_pll0_vcocal_ctrl_1045": begin T_cmn_pll0_vcocal_ctrl_1045 cmn_pll0_vcocal_ctrl = new(objectname); create = cmn_pll0_vcocal_ctrl;  end
         "T_cmn_pll0_vcocal_init_tmr_1049": begin T_cmn_pll0_vcocal_init_tmr_1049 cmn_pll0_vcocal_init_tmr = new(objectname); create = cmn_pll0_vcocal_init_tmr;  end
         "T_cmn_pll0_vcocal_iter_tmr_1050": begin T_cmn_pll0_vcocal_iter_tmr_1050 cmn_pll0_vcocal_iter_tmr = new(objectname); create = cmn_pll0_vcocal_iter_tmr;  end
         "T_cmn_pll0_vcocal_ovrd_1048": begin T_cmn_pll0_vcocal_ovrd_1048 cmn_pll0_vcocal_ovrd = new(objectname); create = cmn_pll0_vcocal_ovrd;  end
         "T_cmn_pll0_vcocal_pllcnt_start_1052": begin T_cmn_pll0_vcocal_pllcnt_start_1052 cmn_pll0_vcocal_pllcnt_start = new(objectname); create = cmn_pll0_vcocal_pllcnt_start;  end
         "T_cmn_pll0_vcocal_reftim_start_1051": begin T_cmn_pll0_vcocal_reftim_start_1051 cmn_pll0_vcocal_reftim_start = new(objectname); create = cmn_pll0_vcocal_reftim_start;  end
         "T_cmn_pll0_vcocal_start_1046": begin T_cmn_pll0_vcocal_start_1046 cmn_pll0_vcocal_start = new(objectname); create = cmn_pll0_vcocal_start;  end
         "T_cmn_pll0_vcocal_tctrl_1047": begin T_cmn_pll0_vcocal_tctrl_1047 cmn_pll0_vcocal_tctrl = new(objectname); create = cmn_pll0_vcocal_tctrl;  end
         "T_cmn_pll1_dsm_diag_1090": begin T_cmn_pll1_dsm_diag_1090 cmn_pll1_dsm_diag = new(objectname); create = cmn_pll1_dsm_diag;  end
         "T_cmn_pll1_dsm_fbh_ovrd_1091": begin T_cmn_pll1_dsm_fbh_ovrd_1091 cmn_pll1_dsm_fbh_ovrd = new(objectname); create = cmn_pll1_dsm_fbh_ovrd;  end
         "T_cmn_pll1_dsm_fbl_ovrd_1092": begin T_cmn_pll1_dsm_fbl_ovrd_1092 cmn_pll1_dsm_fbl_ovrd = new(objectname); create = cmn_pll1_dsm_fbl_ovrd;  end
         "T_cmn_pll1_fracdivh_1088": begin T_cmn_pll1_fracdivh_1088 cmn_pll1_fracdivh = new(objectname); create = cmn_pll1_fracdivh;  end
         "T_cmn_pll1_fracdivl_1087": begin T_cmn_pll1_fracdivl_1087 cmn_pll1_fracdivl = new(objectname); create = cmn_pll1_fracdivl;  end
         "T_cmn_pll1_high_thr_1089": begin T_cmn_pll1_high_thr_1089 cmn_pll1_high_thr = new(objectname); create = cmn_pll1_high_thr;  end
         "T_cmn_pll1_intdiv_1086": begin T_cmn_pll1_intdiv_1086 cmn_pll1_intdiv = new(objectname); create = cmn_pll1_intdiv;  end
         "T_cmn_pll1_ss_ctrl1_1093": begin T_cmn_pll1_ss_ctrl1_1093 cmn_pll1_ss_ctrl1 = new(objectname); create = cmn_pll1_ss_ctrl1;  end
         "T_cmn_pll1_ss_ctrl2_1094": begin T_cmn_pll1_ss_ctrl2_1094 cmn_pll1_ss_ctrl2 = new(objectname); create = cmn_pll1_ss_ctrl2;  end
         "T_cmn_pll1_ss_ctrl3_1095": begin T_cmn_pll1_ss_ctrl3_1095 cmn_pll1_ss_ctrl3 = new(objectname); create = cmn_pll1_ss_ctrl3;  end
         "T_cmn_pll1_vcocal_ctrl_1079": begin T_cmn_pll1_vcocal_ctrl_1079 cmn_pll1_vcocal_ctrl = new(objectname); create = cmn_pll1_vcocal_ctrl;  end
         "T_cmn_pll1_vcocal_init_tmr_1083": begin T_cmn_pll1_vcocal_init_tmr_1083 cmn_pll1_vcocal_init_tmr = new(objectname); create = cmn_pll1_vcocal_init_tmr;  end
         "T_cmn_pll1_vcocal_iter_tmr_1084": begin T_cmn_pll1_vcocal_iter_tmr_1084 cmn_pll1_vcocal_iter_tmr = new(objectname); create = cmn_pll1_vcocal_iter_tmr;  end
         "T_cmn_pll1_vcocal_ovrd_1082": begin T_cmn_pll1_vcocal_ovrd_1082 cmn_pll1_vcocal_ovrd = new(objectname); create = cmn_pll1_vcocal_ovrd;  end
         "T_cmn_pll1_vcocal_reftim_start_1085": begin T_cmn_pll1_vcocal_reftim_start_1085 cmn_pll1_vcocal_reftim_start = new(objectname); create = cmn_pll1_vcocal_reftim_start;  end
         "T_cmn_pll1_vcocal_start_1080": begin T_cmn_pll1_vcocal_start_1080 cmn_pll1_vcocal_start = new(objectname); create = cmn_pll1_vcocal_start;  end
         "T_cmn_pll1_vcocal_tctrl_1081": begin T_cmn_pll1_vcocal_tctrl_1081 cmn_pll1_vcocal_tctrl = new(objectname); create = cmn_pll1_vcocal_tctrl;  end
         "T_cmn_pllsm0_sm_ctrl_1004": begin T_cmn_pllsm0_sm_ctrl_1004 cmn_pllsm0_sm_ctrl = new(objectname); create = cmn_pllsm0_sm_ctrl;  end
         "T_cmn_pllsm0_st_1009": begin T_cmn_pllsm0_st_1009 cmn_pllsm0_st = new(objectname); create = cmn_pllsm0_st;  end
         "T_cmn_pllsm0_tmr_1_1005": begin T_cmn_pllsm0_tmr_1_1005 cmn_pllsm0_tmr_1 = new(objectname); create = cmn_pllsm0_tmr_1;  end
         "T_cmn_pllsm0_tmr_2_1006": begin T_cmn_pllsm0_tmr_2_1006 cmn_pllsm0_tmr_2 = new(objectname); create = cmn_pllsm0_tmr_2;  end
         "T_cmn_pllsm0_tmr_3_1007": begin T_cmn_pllsm0_tmr_3_1007 cmn_pllsm0_tmr_3 = new(objectname); create = cmn_pllsm0_tmr_3;  end
         "T_cmn_pllsm0_tmr_4_1008": begin T_cmn_pllsm0_tmr_4_1008 cmn_pllsm0_tmr_4 = new(objectname); create = cmn_pllsm0_tmr_4;  end
         "T_cmn_pllsm1_sm_ctrl0_1010": begin T_cmn_pllsm1_sm_ctrl0_1010 cmn_pllsm1_sm_ctrl0 = new(objectname); create = cmn_pllsm1_sm_ctrl0;  end
         "T_cmn_pllsm1_sm_ctrl1_1011": begin T_cmn_pllsm1_sm_ctrl1_1011 cmn_pllsm1_sm_ctrl1 = new(objectname); create = cmn_pllsm1_sm_ctrl1;  end
         "T_cmn_pllsm1_st_1020": begin T_cmn_pllsm1_st_1020 cmn_pllsm1_st = new(objectname); create = cmn_pllsm1_st;  end
         "T_cmn_pllsm1_tmr_1_1012": begin T_cmn_pllsm1_tmr_1_1012 cmn_pllsm1_tmr_1 = new(objectname); create = cmn_pllsm1_tmr_1;  end
         "T_cmn_pllsm1_tmr_2_1013": begin T_cmn_pllsm1_tmr_2_1013 cmn_pllsm1_tmr_2 = new(objectname); create = cmn_pllsm1_tmr_2;  end
         "T_cmn_pllsm1_tmr_3_1014": begin T_cmn_pllsm1_tmr_3_1014 cmn_pllsm1_tmr_3 = new(objectname); create = cmn_pllsm1_tmr_3;  end
         "T_cmn_pllsm1_tmr_4_1015": begin T_cmn_pllsm1_tmr_4_1015 cmn_pllsm1_tmr_4 = new(objectname); create = cmn_pllsm1_tmr_4;  end
         "T_cmn_pllsm1_tmr_5_1016": begin T_cmn_pllsm1_tmr_5_1016 cmn_pllsm1_tmr_5 = new(objectname); create = cmn_pllsm1_tmr_5;  end
         "T_cmn_pllsm1_tmr_6_1017": begin T_cmn_pllsm1_tmr_6_1017 cmn_pllsm1_tmr_6 = new(objectname); create = cmn_pllsm1_tmr_6;  end
         "T_cmn_pllsm1_tmr_7_1018": begin T_cmn_pllsm1_tmr_7_1018 cmn_pllsm1_tmr_7 = new(objectname); create = cmn_pllsm1_tmr_7;  end
         "T_cmn_pllsm1_tmr_8_1019": begin T_cmn_pllsm1_tmr_8_1019 cmn_pllsm1_tmr_8 = new(objectname); create = cmn_pllsm1_tmr_8;  end
         "T_cmn_rxcal_ctrl_1108": begin T_cmn_rxcal_ctrl_1108 cmn_rxcal_ctrl = new(objectname); create = cmn_rxcal_ctrl;  end
         "T_cmn_rxcal_init_tmr_1112": begin T_cmn_rxcal_init_tmr_1112 cmn_rxcal_init_tmr = new(objectname); create = cmn_rxcal_init_tmr;  end
         "T_cmn_rxcal_iter_tmr_1113": begin T_cmn_rxcal_iter_tmr_1113 cmn_rxcal_iter_tmr = new(objectname); create = cmn_rxcal_iter_tmr;  end
         "T_cmn_rxcal_ovrd_1109": begin T_cmn_rxcal_ovrd_1109 cmn_rxcal_ovrd = new(objectname); create = cmn_rxcal_ovrd;  end
         "T_cmn_rxcal_start_1110": begin T_cmn_rxcal_start_1110 cmn_rxcal_start = new(objectname); create = cmn_rxcal_start;  end
         "T_cmn_rxcal_tune_1111": begin T_cmn_rxcal_tune_1111 cmn_rxcal_tune = new(objectname); create = cmn_rxcal_tune;  end
         "T_cmn_sd_cal_ctrl_1114": begin T_cmn_sd_cal_ctrl_1114 cmn_sd_cal_ctrl = new(objectname); create = cmn_sd_cal_ctrl;  end
         "T_cmn_sd_cal_init_tmr_1118": begin T_cmn_sd_cal_init_tmr_1118 cmn_sd_cal_init_tmr = new(objectname); create = cmn_sd_cal_init_tmr;  end
         "T_cmn_sd_cal_iter_tmr_1119": begin T_cmn_sd_cal_iter_tmr_1119 cmn_sd_cal_iter_tmr = new(objectname); create = cmn_sd_cal_iter_tmr;  end
         "T_cmn_sd_cal_ovrd_1117": begin T_cmn_sd_cal_ovrd_1117 cmn_sd_cal_ovrd = new(objectname); create = cmn_sd_cal_ovrd;  end
         "T_cmn_sd_cal_pllcnt_start_1121": begin T_cmn_sd_cal_pllcnt_start_1121 cmn_sd_cal_pllcnt_start = new(objectname); create = cmn_sd_cal_pllcnt_start;  end
         "T_cmn_sd_cal_reftim_start_1120": begin T_cmn_sd_cal_reftim_start_1120 cmn_sd_cal_reftim_start = new(objectname); create = cmn_sd_cal_reftim_start;  end
         "T_cmn_sd_cal_start_1115": begin T_cmn_sd_cal_start_1115 cmn_sd_cal_start = new(objectname); create = cmn_sd_cal_start;  end
         "T_cmn_sd_cal_tctrl_1116": begin T_cmn_sd_cal_tctrl_1116 cmn_sd_cal_tctrl = new(objectname); create = cmn_sd_cal_tctrl;  end
         "T_cmn_ssm_sm_ctrl_1000": begin T_cmn_ssm_sm_ctrl_1000 cmn_ssm_sm_ctrl = new(objectname); create = cmn_ssm_sm_ctrl;  end
         "T_cmn_ssm_st_1003": begin T_cmn_ssm_st_1003 cmn_ssm_st = new(objectname); create = cmn_ssm_st;  end
         "T_cmn_ssm_tmr_1_1001": begin T_cmn_ssm_tmr_1_1001 cmn_ssm_tmr_1 = new(objectname); create = cmn_ssm_tmr_1;  end
         "T_cmn_ssm_tmr_2_1002": begin T_cmn_ssm_tmr_2_1002 cmn_ssm_tmr_2 = new(objectname); create = cmn_ssm_tmr_2;  end
         "T_cmn_txpdcal_ctrl_1102": begin T_cmn_txpdcal_ctrl_1102 cmn_txpdcal_ctrl = new(objectname); create = cmn_txpdcal_ctrl;  end
         "T_cmn_txpdcal_init_tmr_1106": begin T_cmn_txpdcal_init_tmr_1106 cmn_txpdcal_init_tmr = new(objectname); create = cmn_txpdcal_init_tmr;  end
         "T_cmn_txpdcal_iter_tmr_1107": begin T_cmn_txpdcal_iter_tmr_1107 cmn_txpdcal_iter_tmr = new(objectname); create = cmn_txpdcal_iter_tmr;  end
         "T_cmn_txpdcal_ovrd_1103": begin T_cmn_txpdcal_ovrd_1103 cmn_txpdcal_ovrd = new(objectname); create = cmn_txpdcal_ovrd;  end
         "T_cmn_txpdcal_start_1104": begin T_cmn_txpdcal_start_1104 cmn_txpdcal_start = new(objectname); create = cmn_txpdcal_start;  end
         "T_cmn_txpdcal_tune_1105": begin T_cmn_txpdcal_tune_1105 cmn_txpdcal_tune = new(objectname); create = cmn_txpdcal_tune;  end
         "T_cmn_txpucal_ctrl_1096": begin T_cmn_txpucal_ctrl_1096 cmn_txpucal_ctrl = new(objectname); create = cmn_txpucal_ctrl;  end
         "T_cmn_txpucal_init_tmr_1100": begin T_cmn_txpucal_init_tmr_1100 cmn_txpucal_init_tmr = new(objectname); create = cmn_txpucal_init_tmr;  end
         "T_cmn_txpucal_iter_tmr_1101": begin T_cmn_txpucal_iter_tmr_1101 cmn_txpucal_iter_tmr = new(objectname); create = cmn_txpucal_iter_tmr;  end
         "T_cmn_txpucal_ovrd_1097": begin T_cmn_txpucal_ovrd_1097 cmn_txpucal_ovrd = new(objectname); create = cmn_txpucal_ovrd;  end
         "T_cmn_txpucal_start_1098": begin T_cmn_txpucal_start_1098 cmn_txpucal_start = new(objectname); create = cmn_txpucal_start;  end
         "T_cmn_txpucal_tune_1099": begin T_cmn_txpucal_tune_1099 cmn_txpucal_tune = new(objectname); create = cmn_txpucal_tune;  end

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
   cdns_uvmreg_utils_pkg_pma_cmn_registers::factory=cdns_factory;


   return cdns_factory;
endfunction
cdns_factory_base cdns_factory = get_factory(no_factory);

endpackage



