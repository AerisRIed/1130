//*************************************************************//
//   ** File Generated Automatically
//   ** Please donot edit manually
//*************************************************************//


package cdn_phy_pcs_lane_reg_pkg;
  import uvm_pkg::*;
  `include "uvm_macros.svh"
  import cdns_uvmreg_utils_pkg_phy_pcs_lane_registers::*;

  bit no_factory = 0; 

/////////////////////////////////////////////////////
//                phy_dp_iso_tx_ctrl1
/////////////////////////////////////////////////////
class T_phy_dp_iso_tx_ctrl1_206 extends cdns_uvm_reg;

  `uvm_object_utils(T_phy_dp_iso_tx_ctrl1_206)
  rand uvm_reg_field phy_dp_iso_tx_ctrl1_31_0;
  
  covergroup wr_fld_covg;
    phy_dp_iso_tx_ctrl1_31_0: coverpoint phy_dp_iso_tx_ctrl1_31_0.value[31:0];
  endgroup
  covergroup rd_fld_covg;
    phy_dp_iso_tx_ctrl1_31_0: coverpoint phy_dp_iso_tx_ctrl1_31_0.value[31:0];
  endgroup

  protected virtual function void sample(uvm_reg_data_t data, uvm_reg_data_t byte_en, bit is_read, uvm_reg_map map);
    super.sample(data, byte_en, is_read, map);
    if (get_coverage(UVM_CVR_FIELD_VALS)) begin
      if(!is_read) begin
          wr_fld_covg.sample();
      end
      if(is_read) begin
         rd_fld_covg.sample();
      end
    end
  endfunction

  virtual function void sample_values();
    super.sample_values();
    if (get_coverage(UVM_CVR_FIELD_VALS)) begin
      wr_fld_covg.sample();
      rd_fld_covg.sample();
    end
  endfunction

  virtual function void build();
    uvm_reg_field fld_set[$];
    uvm_reg_field_config_ta ta = get_field_config(getconfigUID());
    build_uvm_reg_fields(this, ta, fld_set);
    
    phy_dp_iso_tx_ctrl1_31_0 = fld_set[0];
  endfunction

  function new(input string name="T_phy_dp_iso_tx_ctrl1_206");
    super.new(name, 32, build_coverage(UVM_CVR_FIELD_VALS));
    if (has_coverage(UVM_CVR_FIELD_VALS)) begin
      wr_fld_covg = new();
      rd_fld_covg = new();
    end
  endfunction

endclass


/////////////////////////////////////////////////////
//                phy_dp_iso_tx_ctrl2
/////////////////////////////////////////////////////
class T_phy_dp_iso_tx_ctrl2_207 extends cdns_uvm_reg;

  `uvm_object_utils(T_phy_dp_iso_tx_ctrl2_207)
  rand uvm_reg_field phy_dp_iso_tx_ctrl2_14_0;
  rand uvm_reg_field phy_dp_iso_tx_ctrl2_15;
  rand uvm_reg_field phy_dp_iso_tx_ctrl2_31_16;
  
  covergroup wr_fld_covg;
    phy_dp_iso_tx_ctrl2_14_0: coverpoint phy_dp_iso_tx_ctrl2_14_0.value[14:0];
    phy_dp_iso_tx_ctrl2_15: coverpoint phy_dp_iso_tx_ctrl2_15.value[0:0];
    phy_dp_iso_tx_ctrl2_31_16: coverpoint phy_dp_iso_tx_ctrl2_31_16.value[15:0];
  endgroup
  covergroup rd_fld_covg;
    phy_dp_iso_tx_ctrl2_14_0: coverpoint phy_dp_iso_tx_ctrl2_14_0.value[14:0];
    phy_dp_iso_tx_ctrl2_15: coverpoint phy_dp_iso_tx_ctrl2_15.value[0:0];
    phy_dp_iso_tx_ctrl2_31_16: coverpoint phy_dp_iso_tx_ctrl2_31_16.value[15:0];
  endgroup

  protected virtual function void sample(uvm_reg_data_t data, uvm_reg_data_t byte_en, bit is_read, uvm_reg_map map);
    super.sample(data, byte_en, is_read, map);
    if (get_coverage(UVM_CVR_FIELD_VALS)) begin
      if(!is_read) begin
          wr_fld_covg.sample();
      end
      if(is_read) begin
         rd_fld_covg.sample();
      end
    end
  endfunction

  virtual function void sample_values();
    super.sample_values();
    if (get_coverage(UVM_CVR_FIELD_VALS)) begin
      wr_fld_covg.sample();
      rd_fld_covg.sample();
    end
  endfunction

  virtual function void build();
    uvm_reg_field fld_set[$];
    uvm_reg_field_config_ta ta = get_field_config(getconfigUID());
    build_uvm_reg_fields(this, ta, fld_set);
    
    phy_dp_iso_tx_ctrl2_14_0 = fld_set[0];
    phy_dp_iso_tx_ctrl2_15 = fld_set[1];
    phy_dp_iso_tx_ctrl2_31_16 = fld_set[2];
  endfunction

  function new(input string name="T_phy_dp_iso_tx_ctrl2_207");
    super.new(name, 32, build_coverage(UVM_CVR_FIELD_VALS));
    if (has_coverage(UVM_CVR_FIELD_VALS)) begin
      wr_fld_covg = new();
      rd_fld_covg = new();
    end
  endfunction

endclass


/////////////////////////////////////////////////////
//                phy_ln_uc_pcs_en_int_sts1
/////////////////////////////////////////////////////
class T_phy_ln_uc_pcs_en_int_sts1_213 extends cdns_uvm_reg;

  `uvm_object_utils(T_phy_ln_uc_pcs_en_int_sts1_213)
  rand uvm_reg_field phy_ln_uc_pcs_en_int_sts1_31_0;
  
  covergroup wr_fld_covg;
    phy_ln_uc_pcs_en_int_sts1_31_0: coverpoint phy_ln_uc_pcs_en_int_sts1_31_0.value[31:0];
  endgroup
  covergroup rd_fld_covg;
    phy_ln_uc_pcs_en_int_sts1_31_0: coverpoint phy_ln_uc_pcs_en_int_sts1_31_0.value[31:0];
  endgroup

  protected virtual function void sample(uvm_reg_data_t data, uvm_reg_data_t byte_en, bit is_read, uvm_reg_map map);
    super.sample(data, byte_en, is_read, map);
    if (get_coverage(UVM_CVR_FIELD_VALS)) begin
      if(!is_read) begin
          wr_fld_covg.sample();
      end
      if(is_read) begin
         rd_fld_covg.sample();
      end
    end
  endfunction

  virtual function void sample_values();
    super.sample_values();
    if (get_coverage(UVM_CVR_FIELD_VALS)) begin
      wr_fld_covg.sample();
      rd_fld_covg.sample();
    end
  endfunction

  virtual function void build();
    uvm_reg_field fld_set[$];
    uvm_reg_field_config_ta ta = get_field_config(getconfigUID());
    build_uvm_reg_fields(this, ta, fld_set);
    
    phy_ln_uc_pcs_en_int_sts1_31_0 = fld_set[0];
  endfunction

  function new(input string name="T_phy_ln_uc_pcs_en_int_sts1_213");
    super.new(name, 32, build_coverage(UVM_CVR_FIELD_VALS));
    if (has_coverage(UVM_CVR_FIELD_VALS)) begin
      wr_fld_covg = new();
      rd_fld_covg = new();
    end
  endfunction

endclass


/////////////////////////////////////////////////////
//                phy_ln_uc_pcs_en_int_sts2
/////////////////////////////////////////////////////
class T_phy_ln_uc_pcs_en_int_sts2_229 extends cdns_uvm_reg;

  `uvm_object_utils(T_phy_ln_uc_pcs_en_int_sts2_229)
  rand uvm_reg_field phy_ln_uc_pcs_en_int_sts2_31_0;
  
  covergroup wr_fld_covg;
    phy_ln_uc_pcs_en_int_sts2_31_0: coverpoint phy_ln_uc_pcs_en_int_sts2_31_0.value[31:0];
  endgroup
  covergroup rd_fld_covg;
    phy_ln_uc_pcs_en_int_sts2_31_0: coverpoint phy_ln_uc_pcs_en_int_sts2_31_0.value[31:0];
  endgroup

  protected virtual function void sample(uvm_reg_data_t data, uvm_reg_data_t byte_en, bit is_read, uvm_reg_map map);
    super.sample(data, byte_en, is_read, map);
    if (get_coverage(UVM_CVR_FIELD_VALS)) begin
      if(!is_read) begin
          wr_fld_covg.sample();
      end
      if(is_read) begin
         rd_fld_covg.sample();
      end
    end
  endfunction

  virtual function void sample_values();
    super.sample_values();
    if (get_coverage(UVM_CVR_FIELD_VALS)) begin
      wr_fld_covg.sample();
      rd_fld_covg.sample();
    end
  endfunction

  virtual function void build();
    uvm_reg_field fld_set[$];
    uvm_reg_field_config_ta ta = get_field_config(getconfigUID());
    build_uvm_reg_fields(this, ta, fld_set);
    
    phy_ln_uc_pcs_en_int_sts2_31_0 = fld_set[0];
  endfunction

  function new(input string name="T_phy_ln_uc_pcs_en_int_sts2_229");
    super.new(name, 32, build_coverage(UVM_CVR_FIELD_VALS));
    if (has_coverage(UVM_CVR_FIELD_VALS)) begin
      wr_fld_covg = new();
      rd_fld_covg = new();
    end
  endfunction

endclass


/////////////////////////////////////////////////////
//                phy_ln_uc_pcs_int_sts1_en
/////////////////////////////////////////////////////
class T_phy_ln_uc_pcs_int_sts1_en_211 extends cdns_uvm_reg;

  `uvm_object_utils(T_phy_ln_uc_pcs_int_sts1_en_211)
  rand uvm_reg_field phy_ln_uc_pcs_int_sts1_en_31_0;
  
  covergroup wr_fld_covg;
    phy_ln_uc_pcs_int_sts1_en_31_0: coverpoint phy_ln_uc_pcs_int_sts1_en_31_0.value[31:0];
  endgroup
  covergroup rd_fld_covg;
    phy_ln_uc_pcs_int_sts1_en_31_0: coverpoint phy_ln_uc_pcs_int_sts1_en_31_0.value[31:0];
  endgroup

  protected virtual function void sample(uvm_reg_data_t data, uvm_reg_data_t byte_en, bit is_read, uvm_reg_map map);
    super.sample(data, byte_en, is_read, map);
    if (get_coverage(UVM_CVR_FIELD_VALS)) begin
      if(!is_read) begin
          wr_fld_covg.sample();
      end
      if(is_read) begin
         rd_fld_covg.sample();
      end
    end
  endfunction

  virtual function void sample_values();
    super.sample_values();
    if (get_coverage(UVM_CVR_FIELD_VALS)) begin
      wr_fld_covg.sample();
      rd_fld_covg.sample();
    end
  endfunction

  virtual function void build();
    uvm_reg_field fld_set[$];
    uvm_reg_field_config_ta ta = get_field_config(getconfigUID());
    build_uvm_reg_fields(this, ta, fld_set);
    
    phy_ln_uc_pcs_int_sts1_en_31_0 = fld_set[0];
  endfunction

  function new(input string name="T_phy_ln_uc_pcs_int_sts1_en_211");
    super.new(name, 32, build_coverage(UVM_CVR_FIELD_VALS));
    if (has_coverage(UVM_CVR_FIELD_VALS)) begin
      wr_fld_covg = new();
      rd_fld_covg = new();
    end
  endfunction

endclass


/////////////////////////////////////////////////////
//                phy_ln_uc_pcs_int_sts2_en
/////////////////////////////////////////////////////
class T_phy_ln_uc_pcs_int_sts2_en_227 extends cdns_uvm_reg;

  `uvm_object_utils(T_phy_ln_uc_pcs_int_sts2_en_227)
  rand uvm_reg_field phy_ln_uc_pcs_int_sts2_en_31_0;
  
  covergroup wr_fld_covg;
    phy_ln_uc_pcs_int_sts2_en_31_0: coverpoint phy_ln_uc_pcs_int_sts2_en_31_0.value[31:0];
  endgroup
  covergroup rd_fld_covg;
    phy_ln_uc_pcs_int_sts2_en_31_0: coverpoint phy_ln_uc_pcs_int_sts2_en_31_0.value[31:0];
  endgroup

  protected virtual function void sample(uvm_reg_data_t data, uvm_reg_data_t byte_en, bit is_read, uvm_reg_map map);
    super.sample(data, byte_en, is_read, map);
    if (get_coverage(UVM_CVR_FIELD_VALS)) begin
      if(!is_read) begin
          wr_fld_covg.sample();
      end
      if(is_read) begin
         rd_fld_covg.sample();
      end
    end
  endfunction

  virtual function void sample_values();
    super.sample_values();
    if (get_coverage(UVM_CVR_FIELD_VALS)) begin
      wr_fld_covg.sample();
      rd_fld_covg.sample();
    end
  endfunction

  virtual function void build();
    uvm_reg_field fld_set[$];
    uvm_reg_field_config_ta ta = get_field_config(getconfigUID());
    build_uvm_reg_fields(this, ta, fld_set);
    
    phy_ln_uc_pcs_int_sts2_en_31_0 = fld_set[0];
  endfunction

  function new(input string name="T_phy_ln_uc_pcs_int_sts2_en_227");
    super.new(name, 32, build_coverage(UVM_CVR_FIELD_VALS));
    if (has_coverage(UVM_CVR_FIELD_VALS)) begin
      wr_fld_covg = new();
      rd_fld_covg = new();
    end
  endfunction

endclass


/////////////////////////////////////////////////////
//                phy_pipe_inputs
/////////////////////////////////////////////////////
class T_phy_pipe_inputs_192 extends cdns_uvm_reg;

  `uvm_object_utils(T_phy_pipe_inputs_192)
  rand uvm_reg_field phy_pipe_inputs_2_0;
  rand uvm_reg_field phy_pipe_inputs_3;
  rand uvm_reg_field phy_pipe_inputs_5_4;
  rand uvm_reg_field phy_pipe_inputs_7_6;
  rand uvm_reg_field phy_pipe_inputs_8;
  rand uvm_reg_field phy_pipe_inputs_9;
  rand uvm_reg_field phy_pipe_inputs_10;
  rand uvm_reg_field phy_pipe_inputs_29_11;
  rand uvm_reg_field phy_pipe_inputs_30;
  rand uvm_reg_field phy_pipe_inputs_31;
  
  covergroup wr_fld_covg;
    phy_pipe_inputs_2_0: coverpoint phy_pipe_inputs_2_0.value[2:0];
    phy_pipe_inputs_3: coverpoint phy_pipe_inputs_3.value[0:0];
    phy_pipe_inputs_5_4: coverpoint phy_pipe_inputs_5_4.value[1:0];
    phy_pipe_inputs_7_6: coverpoint phy_pipe_inputs_7_6.value[1:0];
    phy_pipe_inputs_8: coverpoint phy_pipe_inputs_8.value[0:0];
    phy_pipe_inputs_9: coverpoint phy_pipe_inputs_9.value[0:0];
    phy_pipe_inputs_10: coverpoint phy_pipe_inputs_10.value[0:0];
    phy_pipe_inputs_29_11: coverpoint phy_pipe_inputs_29_11.value[18:0];
    phy_pipe_inputs_30: coverpoint phy_pipe_inputs_30.value[0:0];
    phy_pipe_inputs_31: coverpoint phy_pipe_inputs_31.value[0:0];
  endgroup
  covergroup rd_fld_covg;
    phy_pipe_inputs_2_0: coverpoint phy_pipe_inputs_2_0.value[2:0];
    phy_pipe_inputs_3: coverpoint phy_pipe_inputs_3.value[0:0];
    phy_pipe_inputs_5_4: coverpoint phy_pipe_inputs_5_4.value[1:0];
    phy_pipe_inputs_7_6: coverpoint phy_pipe_inputs_7_6.value[1:0];
    phy_pipe_inputs_8: coverpoint phy_pipe_inputs_8.value[0:0];
    phy_pipe_inputs_9: coverpoint phy_pipe_inputs_9.value[0:0];
    phy_pipe_inputs_10: coverpoint phy_pipe_inputs_10.value[0:0];
    phy_pipe_inputs_29_11: coverpoint phy_pipe_inputs_29_11.value[18:0];
    phy_pipe_inputs_30: coverpoint phy_pipe_inputs_30.value[0:0];
    phy_pipe_inputs_31: coverpoint phy_pipe_inputs_31.value[0:0];
  endgroup

  protected virtual function void sample(uvm_reg_data_t data, uvm_reg_data_t byte_en, bit is_read, uvm_reg_map map);
    super.sample(data, byte_en, is_read, map);
    if (get_coverage(UVM_CVR_FIELD_VALS)) begin
      if(!is_read) begin
          wr_fld_covg.sample();
      end
      if(is_read) begin
         rd_fld_covg.sample();
      end
    end
  endfunction

  virtual function void sample_values();
    super.sample_values();
    if (get_coverage(UVM_CVR_FIELD_VALS)) begin
      wr_fld_covg.sample();
      rd_fld_covg.sample();
    end
  endfunction

  virtual function void build();
    uvm_reg_field fld_set[$];
    uvm_reg_field_config_ta ta = get_field_config(getconfigUID());
    build_uvm_reg_fields(this, ta, fld_set);
    
    phy_pipe_inputs_2_0 = fld_set[0];
    phy_pipe_inputs_3 = fld_set[1];
    phy_pipe_inputs_5_4 = fld_set[2];
    phy_pipe_inputs_7_6 = fld_set[3];
    phy_pipe_inputs_8 = fld_set[4];
    phy_pipe_inputs_9 = fld_set[5];
    phy_pipe_inputs_10 = fld_set[6];
    phy_pipe_inputs_29_11 = fld_set[7];
    phy_pipe_inputs_30 = fld_set[8];
    phy_pipe_inputs_31 = fld_set[9];
  endfunction

  function new(input string name="T_phy_pipe_inputs_192");
    super.new(name, 32, build_coverage(UVM_CVR_FIELD_VALS));
    if (has_coverage(UVM_CVR_FIELD_VALS)) begin
      wr_fld_covg = new();
      rd_fld_covg = new();
    end
  endfunction

endclass


/////////////////////////////////////////////////////
//                phy_pipe_iso_cfg_ctrl
/////////////////////////////////////////////////////
class T_phy_pipe_iso_cfg_ctrl_200 extends cdns_uvm_reg;

  `uvm_object_utils(T_phy_pipe_iso_cfg_ctrl_200)
  rand uvm_reg_field phy_pipe_iso_cfg_ctrl_1_0;
  rand uvm_reg_field phy_pipe_iso_cfg_ctrl_3_2;
  rand uvm_reg_field phy_pipe_iso_cfg_ctrl_6_4;
  rand uvm_reg_field phy_pipe_iso_cfg_ctrl_7;
  rand uvm_reg_field phy_pipe_iso_cfg_ctrl_8;
  rand uvm_reg_field phy_pipe_iso_cfg_ctrl_9;
  rand uvm_reg_field phy_pipe_iso_cfg_ctrl_13_10;
  rand uvm_reg_field phy_pipe_iso_cfg_ctrl_14;
  rand uvm_reg_field phy_pipe_iso_cfg_ctrl_15;
  rand uvm_reg_field phy_pipe_iso_cfg_ctrl_16;
  rand uvm_reg_field phy_pipe_iso_cfg_ctrl_17;
  rand uvm_reg_field phy_pipe_iso_cfg_ctrl_18;
  rand uvm_reg_field phy_pipe_iso_cfg_ctrl_19;
  rand uvm_reg_field phy_pipe_iso_cfg_ctrl_31_20;
  
  covergroup wr_fld_covg;
    phy_pipe_iso_cfg_ctrl_1_0: coverpoint phy_pipe_iso_cfg_ctrl_1_0.value[1:0];
    phy_pipe_iso_cfg_ctrl_3_2: coverpoint phy_pipe_iso_cfg_ctrl_3_2.value[1:0];
    phy_pipe_iso_cfg_ctrl_6_4: coverpoint phy_pipe_iso_cfg_ctrl_6_4.value[2:0];
    phy_pipe_iso_cfg_ctrl_7: coverpoint phy_pipe_iso_cfg_ctrl_7.value[0:0];
    phy_pipe_iso_cfg_ctrl_8: coverpoint phy_pipe_iso_cfg_ctrl_8.value[0:0];
    phy_pipe_iso_cfg_ctrl_9: coverpoint phy_pipe_iso_cfg_ctrl_9.value[0:0];
    phy_pipe_iso_cfg_ctrl_13_10: coverpoint phy_pipe_iso_cfg_ctrl_13_10.value[3:0];
    phy_pipe_iso_cfg_ctrl_14: coverpoint phy_pipe_iso_cfg_ctrl_14.value[0:0];
    phy_pipe_iso_cfg_ctrl_15: coverpoint phy_pipe_iso_cfg_ctrl_15.value[0:0];
    phy_pipe_iso_cfg_ctrl_16: coverpoint phy_pipe_iso_cfg_ctrl_16.value[0:0];
    phy_pipe_iso_cfg_ctrl_17: coverpoint phy_pipe_iso_cfg_ctrl_17.value[0:0];
    phy_pipe_iso_cfg_ctrl_18: coverpoint phy_pipe_iso_cfg_ctrl_18.value[0:0];
    phy_pipe_iso_cfg_ctrl_19: coverpoint phy_pipe_iso_cfg_ctrl_19.value[0:0];
    phy_pipe_iso_cfg_ctrl_31_20: coverpoint phy_pipe_iso_cfg_ctrl_31_20.value[11:0];
  endgroup
  covergroup rd_fld_covg;
    phy_pipe_iso_cfg_ctrl_1_0: coverpoint phy_pipe_iso_cfg_ctrl_1_0.value[1:0];
    phy_pipe_iso_cfg_ctrl_3_2: coverpoint phy_pipe_iso_cfg_ctrl_3_2.value[1:0];
    phy_pipe_iso_cfg_ctrl_6_4: coverpoint phy_pipe_iso_cfg_ctrl_6_4.value[2:0];
    phy_pipe_iso_cfg_ctrl_7: coverpoint phy_pipe_iso_cfg_ctrl_7.value[0:0];
    phy_pipe_iso_cfg_ctrl_8: coverpoint phy_pipe_iso_cfg_ctrl_8.value[0:0];
    phy_pipe_iso_cfg_ctrl_9: coverpoint phy_pipe_iso_cfg_ctrl_9.value[0:0];
    phy_pipe_iso_cfg_ctrl_13_10: coverpoint phy_pipe_iso_cfg_ctrl_13_10.value[3:0];
    phy_pipe_iso_cfg_ctrl_14: coverpoint phy_pipe_iso_cfg_ctrl_14.value[0:0];
    phy_pipe_iso_cfg_ctrl_15: coverpoint phy_pipe_iso_cfg_ctrl_15.value[0:0];
    phy_pipe_iso_cfg_ctrl_16: coverpoint phy_pipe_iso_cfg_ctrl_16.value[0:0];
    phy_pipe_iso_cfg_ctrl_17: coverpoint phy_pipe_iso_cfg_ctrl_17.value[0:0];
    phy_pipe_iso_cfg_ctrl_18: coverpoint phy_pipe_iso_cfg_ctrl_18.value[0:0];
    phy_pipe_iso_cfg_ctrl_19: coverpoint phy_pipe_iso_cfg_ctrl_19.value[0:0];
    phy_pipe_iso_cfg_ctrl_31_20: coverpoint phy_pipe_iso_cfg_ctrl_31_20.value[11:0];
  endgroup

  protected virtual function void sample(uvm_reg_data_t data, uvm_reg_data_t byte_en, bit is_read, uvm_reg_map map);
    super.sample(data, byte_en, is_read, map);
    if (get_coverage(UVM_CVR_FIELD_VALS)) begin
      if(!is_read) begin
          wr_fld_covg.sample();
      end
      if(is_read) begin
         rd_fld_covg.sample();
      end
    end
  endfunction

  virtual function void sample_values();
    super.sample_values();
    if (get_coverage(UVM_CVR_FIELD_VALS)) begin
      wr_fld_covg.sample();
      rd_fld_covg.sample();
    end
  endfunction

  virtual function void build();
    uvm_reg_field fld_set[$];
    uvm_reg_field_config_ta ta = get_field_config(getconfigUID());
    build_uvm_reg_fields(this, ta, fld_set);
    
    phy_pipe_iso_cfg_ctrl_1_0 = fld_set[0];
    phy_pipe_iso_cfg_ctrl_3_2 = fld_set[1];
    phy_pipe_iso_cfg_ctrl_6_4 = fld_set[2];
    phy_pipe_iso_cfg_ctrl_7 = fld_set[3];
    phy_pipe_iso_cfg_ctrl_8 = fld_set[4];
    phy_pipe_iso_cfg_ctrl_9 = fld_set[5];
    phy_pipe_iso_cfg_ctrl_13_10 = fld_set[6];
    phy_pipe_iso_cfg_ctrl_14 = fld_set[7];
    phy_pipe_iso_cfg_ctrl_15 = fld_set[8];
    phy_pipe_iso_cfg_ctrl_16 = fld_set[9];
    phy_pipe_iso_cfg_ctrl_17 = fld_set[10];
    phy_pipe_iso_cfg_ctrl_18 = fld_set[11];
    phy_pipe_iso_cfg_ctrl_19 = fld_set[12];
    phy_pipe_iso_cfg_ctrl_31_20 = fld_set[13];
  endfunction

  function new(input string name="T_phy_pipe_iso_cfg_ctrl_200");
    super.new(name, 32, build_coverage(UVM_CVR_FIELD_VALS));
    if (has_coverage(UVM_CVR_FIELD_VALS)) begin
      wr_fld_covg = new();
      rd_fld_covg = new();
    end
  endfunction

endclass


/////////////////////////////////////////////////////
//                phy_pipe_iso_mb_mac2phy
/////////////////////////////////////////////////////
class T_phy_pipe_iso_mb_mac2phy_202 extends cdns_uvm_reg;

  `uvm_object_utils(T_phy_pipe_iso_mb_mac2phy_202)
  rand uvm_reg_field phy_pipe_iso_mb_mac2phy_7_0;
  rand uvm_reg_field phy_pipe_iso_mb_mac2phy_15_8;
  rand uvm_reg_field phy_pipe_iso_mb_mac2phy_23_16;
  rand uvm_reg_field phy_pipe_iso_mb_mac2phy_24;
  rand uvm_reg_field phy_pipe_iso_mb_mac2phy_31_25;
  
  covergroup wr_fld_covg;
    phy_pipe_iso_mb_mac2phy_7_0: coverpoint phy_pipe_iso_mb_mac2phy_7_0.value[7:0];
    phy_pipe_iso_mb_mac2phy_15_8: coverpoint phy_pipe_iso_mb_mac2phy_15_8.value[7:0];
    phy_pipe_iso_mb_mac2phy_23_16: coverpoint phy_pipe_iso_mb_mac2phy_23_16.value[7:0];
    phy_pipe_iso_mb_mac2phy_24: coverpoint phy_pipe_iso_mb_mac2phy_24.value[0:0];
    phy_pipe_iso_mb_mac2phy_31_25: coverpoint phy_pipe_iso_mb_mac2phy_31_25.value[6:0];
  endgroup
  covergroup rd_fld_covg;
    phy_pipe_iso_mb_mac2phy_7_0: coverpoint phy_pipe_iso_mb_mac2phy_7_0.value[7:0];
    phy_pipe_iso_mb_mac2phy_15_8: coverpoint phy_pipe_iso_mb_mac2phy_15_8.value[7:0];
    phy_pipe_iso_mb_mac2phy_23_16: coverpoint phy_pipe_iso_mb_mac2phy_23_16.value[7:0];
    phy_pipe_iso_mb_mac2phy_24: coverpoint phy_pipe_iso_mb_mac2phy_24.value[0:0];
    phy_pipe_iso_mb_mac2phy_31_25: coverpoint phy_pipe_iso_mb_mac2phy_31_25.value[6:0];
  endgroup

  protected virtual function void sample(uvm_reg_data_t data, uvm_reg_data_t byte_en, bit is_read, uvm_reg_map map);
    super.sample(data, byte_en, is_read, map);
    if (get_coverage(UVM_CVR_FIELD_VALS)) begin
      if(!is_read) begin
          wr_fld_covg.sample();
      end
      if(is_read) begin
         rd_fld_covg.sample();
      end
    end
  endfunction

  virtual function void sample_values();
    super.sample_values();
    if (get_coverage(UVM_CVR_FIELD_VALS)) begin
      wr_fld_covg.sample();
      rd_fld_covg.sample();
    end
  endfunction

  virtual function void build();
    uvm_reg_field fld_set[$];
    uvm_reg_field_config_ta ta = get_field_config(getconfigUID());
    build_uvm_reg_fields(this, ta, fld_set);
    
    phy_pipe_iso_mb_mac2phy_7_0 = fld_set[0];
    phy_pipe_iso_mb_mac2phy_15_8 = fld_set[1];
    phy_pipe_iso_mb_mac2phy_23_16 = fld_set[2];
    phy_pipe_iso_mb_mac2phy_24 = fld_set[3];
    phy_pipe_iso_mb_mac2phy_31_25 = fld_set[4];
  endfunction

  function new(input string name="T_phy_pipe_iso_mb_mac2phy_202");
    super.new(name, 32, build_coverage(UVM_CVR_FIELD_VALS));
    if (has_coverage(UVM_CVR_FIELD_VALS)) begin
      wr_fld_covg = new();
      rd_fld_covg = new();
    end
  endfunction

endclass


/////////////////////////////////////////////////////
//                phy_pipe_iso_mb_phy2mac0
/////////////////////////////////////////////////////
class T_phy_pipe_iso_mb_phy2mac0_203 extends cdns_uvm_reg;

  `uvm_object_utils(T_phy_pipe_iso_mb_phy2mac0_203)
  rand uvm_reg_field phy_pipe_iso_mb_phy2mac0_7_0;
  rand uvm_reg_field phy_pipe_iso_mb_phy2mac0_15_8;
  rand uvm_reg_field phy_pipe_iso_mb_phy2mac0_23_16;
  rand uvm_reg_field phy_pipe_iso_mb_phy2mac0_31_24;
  
  covergroup wr_fld_covg;
    phy_pipe_iso_mb_phy2mac0_7_0: coverpoint phy_pipe_iso_mb_phy2mac0_7_0.value[7:0];
    phy_pipe_iso_mb_phy2mac0_15_8: coverpoint phy_pipe_iso_mb_phy2mac0_15_8.value[7:0];
    phy_pipe_iso_mb_phy2mac0_23_16: coverpoint phy_pipe_iso_mb_phy2mac0_23_16.value[7:0];
    phy_pipe_iso_mb_phy2mac0_31_24: coverpoint phy_pipe_iso_mb_phy2mac0_31_24.value[7:0];
  endgroup
  covergroup rd_fld_covg;
    phy_pipe_iso_mb_phy2mac0_7_0: coverpoint phy_pipe_iso_mb_phy2mac0_7_0.value[7:0];
    phy_pipe_iso_mb_phy2mac0_15_8: coverpoint phy_pipe_iso_mb_phy2mac0_15_8.value[7:0];
    phy_pipe_iso_mb_phy2mac0_23_16: coverpoint phy_pipe_iso_mb_phy2mac0_23_16.value[7:0];
    phy_pipe_iso_mb_phy2mac0_31_24: coverpoint phy_pipe_iso_mb_phy2mac0_31_24.value[7:0];
  endgroup

  protected virtual function void sample(uvm_reg_data_t data, uvm_reg_data_t byte_en, bit is_read, uvm_reg_map map);
    super.sample(data, byte_en, is_read, map);
    if (get_coverage(UVM_CVR_FIELD_VALS)) begin
      if(!is_read) begin
          wr_fld_covg.sample();
      end
      if(is_read) begin
         rd_fld_covg.sample();
      end
    end
  endfunction

  virtual function void sample_values();
    super.sample_values();
    if (get_coverage(UVM_CVR_FIELD_VALS)) begin
      wr_fld_covg.sample();
      rd_fld_covg.sample();
    end
  endfunction

  virtual function void build();
    uvm_reg_field fld_set[$];
    uvm_reg_field_config_ta ta = get_field_config(getconfigUID());
    build_uvm_reg_fields(this, ta, fld_set);
    
    phy_pipe_iso_mb_phy2mac0_7_0 = fld_set[0];
    phy_pipe_iso_mb_phy2mac0_15_8 = fld_set[1];
    phy_pipe_iso_mb_phy2mac0_23_16 = fld_set[2];
    phy_pipe_iso_mb_phy2mac0_31_24 = fld_set[3];
  endfunction

  function new(input string name="T_phy_pipe_iso_mb_phy2mac0_203");
    super.new(name, 32, build_coverage(UVM_CVR_FIELD_VALS));
    if (has_coverage(UVM_CVR_FIELD_VALS)) begin
      wr_fld_covg = new();
      rd_fld_covg = new();
    end
  endfunction

endclass


/////////////////////////////////////////////////////
//                phy_pipe_iso_mb_phy2mac1
/////////////////////////////////////////////////////
class T_phy_pipe_iso_mb_phy2mac1_204 extends cdns_uvm_reg;

  `uvm_object_utils(T_phy_pipe_iso_mb_phy2mac1_204)
  rand uvm_reg_field phy_pipe_iso_mb_phy2mac1_7_0;
  rand uvm_reg_field phy_pipe_iso_mb_phy2mac1_15_8;
  rand uvm_reg_field phy_pipe_iso_mb_phy2mac1_23_16;
  rand uvm_reg_field phy_pipe_iso_mb_phy2mac1_31_24;
  
  covergroup wr_fld_covg;
    phy_pipe_iso_mb_phy2mac1_7_0: coverpoint phy_pipe_iso_mb_phy2mac1_7_0.value[7:0];
    phy_pipe_iso_mb_phy2mac1_15_8: coverpoint phy_pipe_iso_mb_phy2mac1_15_8.value[7:0];
    phy_pipe_iso_mb_phy2mac1_23_16: coverpoint phy_pipe_iso_mb_phy2mac1_23_16.value[7:0];
    phy_pipe_iso_mb_phy2mac1_31_24: coverpoint phy_pipe_iso_mb_phy2mac1_31_24.value[7:0];
  endgroup
  covergroup rd_fld_covg;
    phy_pipe_iso_mb_phy2mac1_7_0: coverpoint phy_pipe_iso_mb_phy2mac1_7_0.value[7:0];
    phy_pipe_iso_mb_phy2mac1_15_8: coverpoint phy_pipe_iso_mb_phy2mac1_15_8.value[7:0];
    phy_pipe_iso_mb_phy2mac1_23_16: coverpoint phy_pipe_iso_mb_phy2mac1_23_16.value[7:0];
    phy_pipe_iso_mb_phy2mac1_31_24: coverpoint phy_pipe_iso_mb_phy2mac1_31_24.value[7:0];
  endgroup

  protected virtual function void sample(uvm_reg_data_t data, uvm_reg_data_t byte_en, bit is_read, uvm_reg_map map);
    super.sample(data, byte_en, is_read, map);
    if (get_coverage(UVM_CVR_FIELD_VALS)) begin
      if(!is_read) begin
          wr_fld_covg.sample();
      end
      if(is_read) begin
         rd_fld_covg.sample();
      end
    end
  endfunction

  virtual function void sample_values();
    super.sample_values();
    if (get_coverage(UVM_CVR_FIELD_VALS)) begin
      wr_fld_covg.sample();
      rd_fld_covg.sample();
    end
  endfunction

  virtual function void build();
    uvm_reg_field fld_set[$];
    uvm_reg_field_config_ta ta = get_field_config(getconfigUID());
    build_uvm_reg_fields(this, ta, fld_set);
    
    phy_pipe_iso_mb_phy2mac1_7_0 = fld_set[0];
    phy_pipe_iso_mb_phy2mac1_15_8 = fld_set[1];
    phy_pipe_iso_mb_phy2mac1_23_16 = fld_set[2];
    phy_pipe_iso_mb_phy2mac1_31_24 = fld_set[3];
  endfunction

  function new(input string name="T_phy_pipe_iso_mb_phy2mac1_204");
    super.new(name, 32, build_coverage(UVM_CVR_FIELD_VALS));
    if (has_coverage(UVM_CVR_FIELD_VALS)) begin
      wr_fld_covg = new();
      rd_fld_covg = new();
    end
  endfunction

endclass


/////////////////////////////////////////////////////
//                phy_pipe_iso_mb_phy2mac2
/////////////////////////////////////////////////////
class T_phy_pipe_iso_mb_phy2mac2_205 extends cdns_uvm_reg;

  `uvm_object_utils(T_phy_pipe_iso_mb_phy2mac2_205)
  rand uvm_reg_field phy_pipe_iso_mb_phy2mac2_7_0;
  rand uvm_reg_field phy_pipe_iso_mb_phy2mac2_15_8;
  rand uvm_reg_field phy_pipe_iso_mb_phy2mac2_23_16;
  rand uvm_reg_field phy_pipe_iso_mb_phy2mac2_31_24;
  
  covergroup wr_fld_covg;
    phy_pipe_iso_mb_phy2mac2_7_0: coverpoint phy_pipe_iso_mb_phy2mac2_7_0.value[7:0];
    phy_pipe_iso_mb_phy2mac2_15_8: coverpoint phy_pipe_iso_mb_phy2mac2_15_8.value[7:0];
    phy_pipe_iso_mb_phy2mac2_23_16: coverpoint phy_pipe_iso_mb_phy2mac2_23_16.value[7:0];
    phy_pipe_iso_mb_phy2mac2_31_24: coverpoint phy_pipe_iso_mb_phy2mac2_31_24.value[7:0];
  endgroup
  covergroup rd_fld_covg;
    phy_pipe_iso_mb_phy2mac2_7_0: coverpoint phy_pipe_iso_mb_phy2mac2_7_0.value[7:0];
    phy_pipe_iso_mb_phy2mac2_15_8: coverpoint phy_pipe_iso_mb_phy2mac2_15_8.value[7:0];
    phy_pipe_iso_mb_phy2mac2_23_16: coverpoint phy_pipe_iso_mb_phy2mac2_23_16.value[7:0];
    phy_pipe_iso_mb_phy2mac2_31_24: coverpoint phy_pipe_iso_mb_phy2mac2_31_24.value[7:0];
  endgroup

  protected virtual function void sample(uvm_reg_data_t data, uvm_reg_data_t byte_en, bit is_read, uvm_reg_map map);
    super.sample(data, byte_en, is_read, map);
    if (get_coverage(UVM_CVR_FIELD_VALS)) begin
      if(!is_read) begin
          wr_fld_covg.sample();
      end
      if(is_read) begin
         rd_fld_covg.sample();
      end
    end
  endfunction

  virtual function void sample_values();
    super.sample_values();
    if (get_coverage(UVM_CVR_FIELD_VALS)) begin
      wr_fld_covg.sample();
      rd_fld_covg.sample();
    end
  endfunction

  virtual function void build();
    uvm_reg_field fld_set[$];
    uvm_reg_field_config_ta ta = get_field_config(getconfigUID());
    build_uvm_reg_fields(this, ta, fld_set);
    
    phy_pipe_iso_mb_phy2mac2_7_0 = fld_set[0];
    phy_pipe_iso_mb_phy2mac2_15_8 = fld_set[1];
    phy_pipe_iso_mb_phy2mac2_23_16 = fld_set[2];
    phy_pipe_iso_mb_phy2mac2_31_24 = fld_set[3];
  endfunction

  function new(input string name="T_phy_pipe_iso_mb_phy2mac2_205");
    super.new(name, 32, build_coverage(UVM_CVR_FIELD_VALS));
    if (has_coverage(UVM_CVR_FIELD_VALS)) begin
      wr_fld_covg = new();
      rd_fld_covg = new();
    end
  endfunction

endclass


/////////////////////////////////////////////////////
//                phy_pipe_iso_rx_eq_eval
/////////////////////////////////////////////////////
class T_phy_pipe_iso_rx_eq_eval_198 extends cdns_uvm_reg;

  `uvm_object_utils(T_phy_pipe_iso_rx_eq_eval_198)
  rand uvm_reg_field phy_pipe_iso_rx_eq_eval_5_0;
  rand uvm_reg_field phy_pipe_iso_rx_eq_eval_6;
  rand uvm_reg_field phy_pipe_iso_rx_eq_eval_7;
  rand uvm_reg_field phy_pipe_iso_rx_eq_eval_8;
  rand uvm_reg_field phy_pipe_iso_rx_eq_eval_15_9;
  rand uvm_reg_field phy_pipe_iso_rx_eq_eval_23_16;
  rand uvm_reg_field phy_pipe_iso_rx_eq_eval_31_24;
  
  covergroup wr_fld_covg;
    phy_pipe_iso_rx_eq_eval_5_0: coverpoint phy_pipe_iso_rx_eq_eval_5_0.value[5:0];
    phy_pipe_iso_rx_eq_eval_6: coverpoint phy_pipe_iso_rx_eq_eval_6.value[0:0];
    phy_pipe_iso_rx_eq_eval_7: coverpoint phy_pipe_iso_rx_eq_eval_7.value[0:0];
    phy_pipe_iso_rx_eq_eval_8: coverpoint phy_pipe_iso_rx_eq_eval_8.value[0:0];
    phy_pipe_iso_rx_eq_eval_15_9: coverpoint phy_pipe_iso_rx_eq_eval_15_9.value[6:0];
    phy_pipe_iso_rx_eq_eval_23_16: coverpoint phy_pipe_iso_rx_eq_eval_23_16.value[7:0];
    phy_pipe_iso_rx_eq_eval_31_24: coverpoint phy_pipe_iso_rx_eq_eval_31_24.value[7:0];
  endgroup
  covergroup rd_fld_covg;
    phy_pipe_iso_rx_eq_eval_5_0: coverpoint phy_pipe_iso_rx_eq_eval_5_0.value[5:0];
    phy_pipe_iso_rx_eq_eval_6: coverpoint phy_pipe_iso_rx_eq_eval_6.value[0:0];
    phy_pipe_iso_rx_eq_eval_7: coverpoint phy_pipe_iso_rx_eq_eval_7.value[0:0];
    phy_pipe_iso_rx_eq_eval_8: coverpoint phy_pipe_iso_rx_eq_eval_8.value[0:0];
    phy_pipe_iso_rx_eq_eval_15_9: coverpoint phy_pipe_iso_rx_eq_eval_15_9.value[6:0];
    phy_pipe_iso_rx_eq_eval_23_16: coverpoint phy_pipe_iso_rx_eq_eval_23_16.value[7:0];
    phy_pipe_iso_rx_eq_eval_31_24: coverpoint phy_pipe_iso_rx_eq_eval_31_24.value[7:0];
  endgroup

  protected virtual function void sample(uvm_reg_data_t data, uvm_reg_data_t byte_en, bit is_read, uvm_reg_map map);
    super.sample(data, byte_en, is_read, map);
    if (get_coverage(UVM_CVR_FIELD_VALS)) begin
      if(!is_read) begin
          wr_fld_covg.sample();
      end
      if(is_read) begin
         rd_fld_covg.sample();
      end
    end
  endfunction

  virtual function void sample_values();
    super.sample_values();
    if (get_coverage(UVM_CVR_FIELD_VALS)) begin
      wr_fld_covg.sample();
      rd_fld_covg.sample();
    end
  endfunction

  virtual function void build();
    uvm_reg_field fld_set[$];
    uvm_reg_field_config_ta ta = get_field_config(getconfigUID());
    build_uvm_reg_fields(this, ta, fld_set);
    
    phy_pipe_iso_rx_eq_eval_5_0 = fld_set[0];
    phy_pipe_iso_rx_eq_eval_6 = fld_set[1];
    phy_pipe_iso_rx_eq_eval_7 = fld_set[2];
    phy_pipe_iso_rx_eq_eval_8 = fld_set[3];
    phy_pipe_iso_rx_eq_eval_15_9 = fld_set[4];
    phy_pipe_iso_rx_eq_eval_23_16 = fld_set[5];
    phy_pipe_iso_rx_eq_eval_31_24 = fld_set[6];
  endfunction

  function new(input string name="T_phy_pipe_iso_rx_eq_eval_198");
    super.new(name, 32, build_coverage(UVM_CVR_FIELD_VALS));
    if (has_coverage(UVM_CVR_FIELD_VALS)) begin
      wr_fld_covg = new();
      rd_fld_covg = new();
    end
  endfunction

endclass


/////////////////////////////////////////////////////
//                phy_pipe_iso_tx_lpc
/////////////////////////////////////////////////////
class T_phy_pipe_iso_tx_lpc_195 extends cdns_uvm_reg;

  `uvm_object_utils(T_phy_pipe_iso_tx_lpc_195)
  rand uvm_reg_field phy_pipe_iso_tx_lpc_17_0;
  rand uvm_reg_field phy_pipe_iso_tx_lpc_23_18;
  rand uvm_reg_field phy_pipe_iso_tx_lpc_29_24;
  rand uvm_reg_field phy_pipe_iso_tx_lpc_30;
  rand uvm_reg_field phy_pipe_iso_tx_lpc_31;
  
  covergroup wr_fld_covg;
    phy_pipe_iso_tx_lpc_17_0: coverpoint phy_pipe_iso_tx_lpc_17_0.value[17:0];
    phy_pipe_iso_tx_lpc_23_18: coverpoint phy_pipe_iso_tx_lpc_23_18.value[5:0];
    phy_pipe_iso_tx_lpc_29_24: coverpoint phy_pipe_iso_tx_lpc_29_24.value[5:0];
    phy_pipe_iso_tx_lpc_30: coverpoint phy_pipe_iso_tx_lpc_30.value[0:0];
    phy_pipe_iso_tx_lpc_31: coverpoint phy_pipe_iso_tx_lpc_31.value[0:0];
  endgroup
  covergroup rd_fld_covg;
    phy_pipe_iso_tx_lpc_17_0: coverpoint phy_pipe_iso_tx_lpc_17_0.value[17:0];
    phy_pipe_iso_tx_lpc_23_18: coverpoint phy_pipe_iso_tx_lpc_23_18.value[5:0];
    phy_pipe_iso_tx_lpc_29_24: coverpoint phy_pipe_iso_tx_lpc_29_24.value[5:0];
    phy_pipe_iso_tx_lpc_30: coverpoint phy_pipe_iso_tx_lpc_30.value[0:0];
    phy_pipe_iso_tx_lpc_31: coverpoint phy_pipe_iso_tx_lpc_31.value[0:0];
  endgroup

  protected virtual function void sample(uvm_reg_data_t data, uvm_reg_data_t byte_en, bit is_read, uvm_reg_map map);
    super.sample(data, byte_en, is_read, map);
    if (get_coverage(UVM_CVR_FIELD_VALS)) begin
      if(!is_read) begin
          wr_fld_covg.sample();
      end
      if(is_read) begin
         rd_fld_covg.sample();
      end
    end
  endfunction

  virtual function void sample_values();
    super.sample_values();
    if (get_coverage(UVM_CVR_FIELD_VALS)) begin
      wr_fld_covg.sample();
      rd_fld_covg.sample();
    end
  endfunction

  virtual function void build();
    uvm_reg_field fld_set[$];
    uvm_reg_field_config_ta ta = get_field_config(getconfigUID());
    build_uvm_reg_fields(this, ta, fld_set);
    
    phy_pipe_iso_tx_lpc_17_0 = fld_set[0];
    phy_pipe_iso_tx_lpc_23_18 = fld_set[1];
    phy_pipe_iso_tx_lpc_29_24 = fld_set[2];
    phy_pipe_iso_tx_lpc_30 = fld_set[3];
    phy_pipe_iso_tx_lpc_31 = fld_set[4];
  endfunction

  function new(input string name="T_phy_pipe_iso_tx_lpc_195");
    super.new(name, 32, build_coverage(UVM_CVR_FIELD_VALS));
    if (has_coverage(UVM_CVR_FIELD_VALS)) begin
      wr_fld_covg = new();
      rd_fld_covg = new();
    end
  endfunction

endclass


/////////////////////////////////////////////////////
//                phy_pipe_ln_ctrl_sts
/////////////////////////////////////////////////////
class T_phy_pipe_ln_ctrl_sts_196 extends cdns_uvm_reg;

  `uvm_object_utils(T_phy_pipe_ln_ctrl_sts_196)
  rand uvm_reg_field phy_pipe_ln_ctrl_sts_0;
  rand uvm_reg_field phy_pipe_ln_ctrl_sts_2_1;
  rand uvm_reg_field phy_pipe_ln_ctrl_sts_3;
  rand uvm_reg_field phy_pipe_ln_ctrl_sts_4;
  rand uvm_reg_field phy_pipe_ln_ctrl_sts_5;
  rand uvm_reg_field phy_pipe_ln_ctrl_sts_6;
  rand uvm_reg_field phy_pipe_ln_ctrl_sts_7;
  rand uvm_reg_field phy_pipe_ln_ctrl_sts_8;
  rand uvm_reg_field phy_pipe_ln_ctrl_sts_9;
  rand uvm_reg_field phy_pipe_ln_ctrl_sts_10;
  rand uvm_reg_field phy_pipe_ln_ctrl_sts_11;
  rand uvm_reg_field phy_pipe_ln_ctrl_sts_12;
  rand uvm_reg_field phy_pipe_ln_ctrl_sts_13;
  rand uvm_reg_field phy_pipe_ln_ctrl_sts_15_14;
  rand uvm_reg_field phy_pipe_ln_ctrl_sts_16;
  rand uvm_reg_field phy_pipe_ln_ctrl_sts_17;
  rand uvm_reg_field phy_pipe_ln_ctrl_sts_18;
  rand uvm_reg_field phy_pipe_ln_ctrl_sts_19;
  rand uvm_reg_field phy_pipe_ln_ctrl_sts_20;
  rand uvm_reg_field phy_pipe_ln_ctrl_sts_23_21;
  rand uvm_reg_field phy_pipe_ln_ctrl_sts_24;
  rand uvm_reg_field phy_pipe_ln_ctrl_sts_25;
  rand uvm_reg_field phy_pipe_ln_ctrl_sts_27_26;
  rand uvm_reg_field phy_pipe_ln_ctrl_sts_30_28;
  rand uvm_reg_field phy_pipe_ln_ctrl_sts_31;
  
  covergroup wr_fld_covg;
    phy_pipe_ln_ctrl_sts_0: coverpoint phy_pipe_ln_ctrl_sts_0.value[0:0];
    phy_pipe_ln_ctrl_sts_2_1: coverpoint phy_pipe_ln_ctrl_sts_2_1.value[1:0];
    phy_pipe_ln_ctrl_sts_3: coverpoint phy_pipe_ln_ctrl_sts_3.value[0:0];
    phy_pipe_ln_ctrl_sts_4: coverpoint phy_pipe_ln_ctrl_sts_4.value[0:0];
    phy_pipe_ln_ctrl_sts_5: coverpoint phy_pipe_ln_ctrl_sts_5.value[0:0];
    phy_pipe_ln_ctrl_sts_6: coverpoint phy_pipe_ln_ctrl_sts_6.value[0:0];
    phy_pipe_ln_ctrl_sts_7: coverpoint phy_pipe_ln_ctrl_sts_7.value[0:0];
    phy_pipe_ln_ctrl_sts_8: coverpoint phy_pipe_ln_ctrl_sts_8.value[0:0];
    phy_pipe_ln_ctrl_sts_9: coverpoint phy_pipe_ln_ctrl_sts_9.value[0:0];
    phy_pipe_ln_ctrl_sts_10: coverpoint phy_pipe_ln_ctrl_sts_10.value[0:0];
    phy_pipe_ln_ctrl_sts_11: coverpoint phy_pipe_ln_ctrl_sts_11.value[0:0];
    phy_pipe_ln_ctrl_sts_12: coverpoint phy_pipe_ln_ctrl_sts_12.value[0:0];
    phy_pipe_ln_ctrl_sts_13: coverpoint phy_pipe_ln_ctrl_sts_13.value[0:0];
    phy_pipe_ln_ctrl_sts_15_14: coverpoint phy_pipe_ln_ctrl_sts_15_14.value[1:0];
    phy_pipe_ln_ctrl_sts_16: coverpoint phy_pipe_ln_ctrl_sts_16.value[0:0];
    phy_pipe_ln_ctrl_sts_17: coverpoint phy_pipe_ln_ctrl_sts_17.value[0:0];
    phy_pipe_ln_ctrl_sts_18: coverpoint phy_pipe_ln_ctrl_sts_18.value[0:0];
    phy_pipe_ln_ctrl_sts_19: coverpoint phy_pipe_ln_ctrl_sts_19.value[0:0];
    phy_pipe_ln_ctrl_sts_20: coverpoint phy_pipe_ln_ctrl_sts_20.value[0:0];
    phy_pipe_ln_ctrl_sts_23_21: coverpoint phy_pipe_ln_ctrl_sts_23_21.value[2:0];
    phy_pipe_ln_ctrl_sts_24: coverpoint phy_pipe_ln_ctrl_sts_24.value[0:0];
    phy_pipe_ln_ctrl_sts_25: coverpoint phy_pipe_ln_ctrl_sts_25.value[0:0];
    phy_pipe_ln_ctrl_sts_27_26: coverpoint phy_pipe_ln_ctrl_sts_27_26.value[1:0];
    phy_pipe_ln_ctrl_sts_30_28: coverpoint phy_pipe_ln_ctrl_sts_30_28.value[2:0];
    phy_pipe_ln_ctrl_sts_31: coverpoint phy_pipe_ln_ctrl_sts_31.value[0:0];
  endgroup
  covergroup rd_fld_covg;
    phy_pipe_ln_ctrl_sts_0: coverpoint phy_pipe_ln_ctrl_sts_0.value[0:0];
    phy_pipe_ln_ctrl_sts_2_1: coverpoint phy_pipe_ln_ctrl_sts_2_1.value[1:0];
    phy_pipe_ln_ctrl_sts_3: coverpoint phy_pipe_ln_ctrl_sts_3.value[0:0];
    phy_pipe_ln_ctrl_sts_4: coverpoint phy_pipe_ln_ctrl_sts_4.value[0:0];
    phy_pipe_ln_ctrl_sts_5: coverpoint phy_pipe_ln_ctrl_sts_5.value[0:0];
    phy_pipe_ln_ctrl_sts_6: coverpoint phy_pipe_ln_ctrl_sts_6.value[0:0];
    phy_pipe_ln_ctrl_sts_7: coverpoint phy_pipe_ln_ctrl_sts_7.value[0:0];
    phy_pipe_ln_ctrl_sts_8: coverpoint phy_pipe_ln_ctrl_sts_8.value[0:0];
    phy_pipe_ln_ctrl_sts_9: coverpoint phy_pipe_ln_ctrl_sts_9.value[0:0];
    phy_pipe_ln_ctrl_sts_10: coverpoint phy_pipe_ln_ctrl_sts_10.value[0:0];
    phy_pipe_ln_ctrl_sts_11: coverpoint phy_pipe_ln_ctrl_sts_11.value[0:0];
    phy_pipe_ln_ctrl_sts_12: coverpoint phy_pipe_ln_ctrl_sts_12.value[0:0];
    phy_pipe_ln_ctrl_sts_13: coverpoint phy_pipe_ln_ctrl_sts_13.value[0:0];
    phy_pipe_ln_ctrl_sts_15_14: coverpoint phy_pipe_ln_ctrl_sts_15_14.value[1:0];
    phy_pipe_ln_ctrl_sts_16: coverpoint phy_pipe_ln_ctrl_sts_16.value[0:0];
    phy_pipe_ln_ctrl_sts_17: coverpoint phy_pipe_ln_ctrl_sts_17.value[0:0];
    phy_pipe_ln_ctrl_sts_18: coverpoint phy_pipe_ln_ctrl_sts_18.value[0:0];
    phy_pipe_ln_ctrl_sts_19: coverpoint phy_pipe_ln_ctrl_sts_19.value[0:0];
    phy_pipe_ln_ctrl_sts_20: coverpoint phy_pipe_ln_ctrl_sts_20.value[0:0];
    phy_pipe_ln_ctrl_sts_23_21: coverpoint phy_pipe_ln_ctrl_sts_23_21.value[2:0];
    phy_pipe_ln_ctrl_sts_24: coverpoint phy_pipe_ln_ctrl_sts_24.value[0:0];
    phy_pipe_ln_ctrl_sts_25: coverpoint phy_pipe_ln_ctrl_sts_25.value[0:0];
    phy_pipe_ln_ctrl_sts_27_26: coverpoint phy_pipe_ln_ctrl_sts_27_26.value[1:0];
    phy_pipe_ln_ctrl_sts_30_28: coverpoint phy_pipe_ln_ctrl_sts_30_28.value[2:0];
    phy_pipe_ln_ctrl_sts_31: coverpoint phy_pipe_ln_ctrl_sts_31.value[0:0];
  endgroup

  protected virtual function void sample(uvm_reg_data_t data, uvm_reg_data_t byte_en, bit is_read, uvm_reg_map map);
    super.sample(data, byte_en, is_read, map);
    if (get_coverage(UVM_CVR_FIELD_VALS)) begin
      if(!is_read) begin
          wr_fld_covg.sample();
      end
      if(is_read) begin
         rd_fld_covg.sample();
      end
    end
  endfunction

  virtual function void sample_values();
    super.sample_values();
    if (get_coverage(UVM_CVR_FIELD_VALS)) begin
      wr_fld_covg.sample();
      rd_fld_covg.sample();
    end
  endfunction

  virtual function void build();
    uvm_reg_field fld_set[$];
    uvm_reg_field_config_ta ta = get_field_config(getconfigUID());
    build_uvm_reg_fields(this, ta, fld_set);
    
    phy_pipe_ln_ctrl_sts_0 = fld_set[0];
    phy_pipe_ln_ctrl_sts_2_1 = fld_set[1];
    phy_pipe_ln_ctrl_sts_3 = fld_set[2];
    phy_pipe_ln_ctrl_sts_4 = fld_set[3];
    phy_pipe_ln_ctrl_sts_5 = fld_set[4];
    phy_pipe_ln_ctrl_sts_6 = fld_set[5];
    phy_pipe_ln_ctrl_sts_7 = fld_set[6];
    phy_pipe_ln_ctrl_sts_8 = fld_set[7];
    phy_pipe_ln_ctrl_sts_9 = fld_set[8];
    phy_pipe_ln_ctrl_sts_10 = fld_set[9];
    phy_pipe_ln_ctrl_sts_11 = fld_set[10];
    phy_pipe_ln_ctrl_sts_12 = fld_set[11];
    phy_pipe_ln_ctrl_sts_13 = fld_set[12];
    phy_pipe_ln_ctrl_sts_15_14 = fld_set[13];
    phy_pipe_ln_ctrl_sts_16 = fld_set[14];
    phy_pipe_ln_ctrl_sts_17 = fld_set[15];
    phy_pipe_ln_ctrl_sts_18 = fld_set[16];
    phy_pipe_ln_ctrl_sts_19 = fld_set[17];
    phy_pipe_ln_ctrl_sts_20 = fld_set[18];
    phy_pipe_ln_ctrl_sts_23_21 = fld_set[19];
    phy_pipe_ln_ctrl_sts_24 = fld_set[20];
    phy_pipe_ln_ctrl_sts_25 = fld_set[21];
    phy_pipe_ln_ctrl_sts_27_26 = fld_set[22];
    phy_pipe_ln_ctrl_sts_30_28 = fld_set[23];
    phy_pipe_ln_ctrl_sts_31 = fld_set[24];
  endfunction

  function new(input string name="T_phy_pipe_ln_ctrl_sts_196");
    super.new(name, 32, build_coverage(UVM_CVR_FIELD_VALS));
    if (has_coverage(UVM_CVR_FIELD_VALS)) begin
      wr_fld_covg = new();
      rd_fld_covg = new();
    end
  endfunction

endclass


/////////////////////////////////////////////////////
//                phy_pipe_ln_ctrl_sts_clr
/////////////////////////////////////////////////////
class T_phy_pipe_ln_ctrl_sts_clr_197 extends cdns_uvm_reg;

  `uvm_object_utils(T_phy_pipe_ln_ctrl_sts_clr_197)
  rand uvm_reg_field phy_pipe_ln_ctrl_sts_clr_31_0;
  
  covergroup wr_fld_covg;
    phy_pipe_ln_ctrl_sts_clr_31_0: coverpoint phy_pipe_ln_ctrl_sts_clr_31_0.value[31:0];
  endgroup
  covergroup rd_fld_covg;
    phy_pipe_ln_ctrl_sts_clr_31_0: coverpoint phy_pipe_ln_ctrl_sts_clr_31_0.value[31:0];
  endgroup

  protected virtual function void sample(uvm_reg_data_t data, uvm_reg_data_t byte_en, bit is_read, uvm_reg_map map);
    super.sample(data, byte_en, is_read, map);
    if (get_coverage(UVM_CVR_FIELD_VALS)) begin
      if(!is_read) begin
          wr_fld_covg.sample();
      end
      if(is_read) begin
         rd_fld_covg.sample();
      end
    end
  endfunction

  virtual function void sample_values();
    super.sample_values();
    if (get_coverage(UVM_CVR_FIELD_VALS)) begin
      wr_fld_covg.sample();
      rd_fld_covg.sample();
    end
  endfunction

  virtual function void build();
    uvm_reg_field fld_set[$];
    uvm_reg_field_config_ta ta = get_field_config(getconfigUID());
    build_uvm_reg_fields(this, ta, fld_set);
    
    phy_pipe_ln_ctrl_sts_clr_31_0 = fld_set[0];
  endfunction

  function new(input string name="T_phy_pipe_ln_ctrl_sts_clr_197");
    super.new(name, 32, build_coverage(UVM_CVR_FIELD_VALS));
    if (has_coverage(UVM_CVR_FIELD_VALS)) begin
      wr_fld_covg = new();
      rd_fld_covg = new();
    end
  endfunction

endclass


/////////////////////////////////////////////////////
//                phy_pipe_mb_ctrl_sts
/////////////////////////////////////////////////////
class T_phy_pipe_mb_ctrl_sts_201 extends cdns_uvm_reg;

  `uvm_object_utils(T_phy_pipe_mb_ctrl_sts_201)
  rand uvm_reg_field phy_pipe_mb_ctrl_sts_0;
  rand uvm_reg_field phy_pipe_mb_ctrl_sts_1;
  rand uvm_reg_field phy_pipe_mb_ctrl_sts_2;
  rand uvm_reg_field phy_pipe_mb_ctrl_sts_3;
  rand uvm_reg_field phy_pipe_mb_ctrl_sts_4;
  rand uvm_reg_field phy_pipe_mb_ctrl_sts_7_5;
  rand uvm_reg_field phy_pipe_mb_ctrl_sts_8;
  rand uvm_reg_field phy_pipe_mb_ctrl_sts_9;
  rand uvm_reg_field phy_pipe_mb_ctrl_sts_10;
  rand uvm_reg_field phy_pipe_mb_ctrl_sts_11;
  rand uvm_reg_field phy_pipe_mb_ctrl_sts_15_12;
  rand uvm_reg_field phy_pipe_mb_ctrl_sts_16;
  rand uvm_reg_field phy_pipe_mb_ctrl_sts_17;
  rand uvm_reg_field phy_pipe_mb_ctrl_sts_18;
  rand uvm_reg_field phy_pipe_mb_ctrl_sts_19;
  rand uvm_reg_field phy_pipe_mb_ctrl_sts_20;
  rand uvm_reg_field phy_pipe_mb_ctrl_sts_31_21;
  
  covergroup wr_fld_covg;
    phy_pipe_mb_ctrl_sts_0: coverpoint phy_pipe_mb_ctrl_sts_0.value[0:0];
    phy_pipe_mb_ctrl_sts_1: coverpoint phy_pipe_mb_ctrl_sts_1.value[0:0];
    phy_pipe_mb_ctrl_sts_2: coverpoint phy_pipe_mb_ctrl_sts_2.value[0:0];
    phy_pipe_mb_ctrl_sts_3: coverpoint phy_pipe_mb_ctrl_sts_3.value[0:0];
    phy_pipe_mb_ctrl_sts_4: coverpoint phy_pipe_mb_ctrl_sts_4.value[0:0];
    phy_pipe_mb_ctrl_sts_7_5: coverpoint phy_pipe_mb_ctrl_sts_7_5.value[2:0];
    phy_pipe_mb_ctrl_sts_8: coverpoint phy_pipe_mb_ctrl_sts_8.value[0:0];
    phy_pipe_mb_ctrl_sts_9: coverpoint phy_pipe_mb_ctrl_sts_9.value[0:0];
    phy_pipe_mb_ctrl_sts_10: coverpoint phy_pipe_mb_ctrl_sts_10.value[0:0];
    phy_pipe_mb_ctrl_sts_11: coverpoint phy_pipe_mb_ctrl_sts_11.value[0:0];
    phy_pipe_mb_ctrl_sts_15_12: coverpoint phy_pipe_mb_ctrl_sts_15_12.value[3:0];
    phy_pipe_mb_ctrl_sts_16: coverpoint phy_pipe_mb_ctrl_sts_16.value[0:0];
    phy_pipe_mb_ctrl_sts_17: coverpoint phy_pipe_mb_ctrl_sts_17.value[0:0];
    phy_pipe_mb_ctrl_sts_18: coverpoint phy_pipe_mb_ctrl_sts_18.value[0:0];
    phy_pipe_mb_ctrl_sts_19: coverpoint phy_pipe_mb_ctrl_sts_19.value[0:0];
    phy_pipe_mb_ctrl_sts_20: coverpoint phy_pipe_mb_ctrl_sts_20.value[0:0];
    phy_pipe_mb_ctrl_sts_31_21: coverpoint phy_pipe_mb_ctrl_sts_31_21.value[10:0];
  endgroup
  covergroup rd_fld_covg;
    phy_pipe_mb_ctrl_sts_0: coverpoint phy_pipe_mb_ctrl_sts_0.value[0:0];
    phy_pipe_mb_ctrl_sts_1: coverpoint phy_pipe_mb_ctrl_sts_1.value[0:0];
    phy_pipe_mb_ctrl_sts_2: coverpoint phy_pipe_mb_ctrl_sts_2.value[0:0];
    phy_pipe_mb_ctrl_sts_3: coverpoint phy_pipe_mb_ctrl_sts_3.value[0:0];
    phy_pipe_mb_ctrl_sts_4: coverpoint phy_pipe_mb_ctrl_sts_4.value[0:0];
    phy_pipe_mb_ctrl_sts_7_5: coverpoint phy_pipe_mb_ctrl_sts_7_5.value[2:0];
    phy_pipe_mb_ctrl_sts_8: coverpoint phy_pipe_mb_ctrl_sts_8.value[0:0];
    phy_pipe_mb_ctrl_sts_9: coverpoint phy_pipe_mb_ctrl_sts_9.value[0:0];
    phy_pipe_mb_ctrl_sts_10: coverpoint phy_pipe_mb_ctrl_sts_10.value[0:0];
    phy_pipe_mb_ctrl_sts_11: coverpoint phy_pipe_mb_ctrl_sts_11.value[0:0];
    phy_pipe_mb_ctrl_sts_15_12: coverpoint phy_pipe_mb_ctrl_sts_15_12.value[3:0];
    phy_pipe_mb_ctrl_sts_16: coverpoint phy_pipe_mb_ctrl_sts_16.value[0:0];
    phy_pipe_mb_ctrl_sts_17: coverpoint phy_pipe_mb_ctrl_sts_17.value[0:0];
    phy_pipe_mb_ctrl_sts_18: coverpoint phy_pipe_mb_ctrl_sts_18.value[0:0];
    phy_pipe_mb_ctrl_sts_19: coverpoint phy_pipe_mb_ctrl_sts_19.value[0:0];
    phy_pipe_mb_ctrl_sts_20: coverpoint phy_pipe_mb_ctrl_sts_20.value[0:0];
    phy_pipe_mb_ctrl_sts_31_21: coverpoint phy_pipe_mb_ctrl_sts_31_21.value[10:0];
  endgroup

  protected virtual function void sample(uvm_reg_data_t data, uvm_reg_data_t byte_en, bit is_read, uvm_reg_map map);
    super.sample(data, byte_en, is_read, map);
    if (get_coverage(UVM_CVR_FIELD_VALS)) begin
      if(!is_read) begin
          wr_fld_covg.sample();
      end
      if(is_read) begin
         rd_fld_covg.sample();
      end
    end
  endfunction

  virtual function void sample_values();
    super.sample_values();
    if (get_coverage(UVM_CVR_FIELD_VALS)) begin
      wr_fld_covg.sample();
      rd_fld_covg.sample();
    end
  endfunction

  virtual function void build();
    uvm_reg_field fld_set[$];
    uvm_reg_field_config_ta ta = get_field_config(getconfigUID());
    build_uvm_reg_fields(this, ta, fld_set);
    
    phy_pipe_mb_ctrl_sts_0 = fld_set[0];
    phy_pipe_mb_ctrl_sts_1 = fld_set[1];
    phy_pipe_mb_ctrl_sts_2 = fld_set[2];
    phy_pipe_mb_ctrl_sts_3 = fld_set[3];
    phy_pipe_mb_ctrl_sts_4 = fld_set[4];
    phy_pipe_mb_ctrl_sts_7_5 = fld_set[5];
    phy_pipe_mb_ctrl_sts_8 = fld_set[6];
    phy_pipe_mb_ctrl_sts_9 = fld_set[7];
    phy_pipe_mb_ctrl_sts_10 = fld_set[8];
    phy_pipe_mb_ctrl_sts_11 = fld_set[9];
    phy_pipe_mb_ctrl_sts_15_12 = fld_set[10];
    phy_pipe_mb_ctrl_sts_16 = fld_set[11];
    phy_pipe_mb_ctrl_sts_17 = fld_set[12];
    phy_pipe_mb_ctrl_sts_18 = fld_set[13];
    phy_pipe_mb_ctrl_sts_19 = fld_set[14];
    phy_pipe_mb_ctrl_sts_20 = fld_set[15];
    phy_pipe_mb_ctrl_sts_31_21 = fld_set[16];
  endfunction

  function new(input string name="T_phy_pipe_mb_ctrl_sts_201");
    super.new(name, 32, build_coverage(UVM_CVR_FIELD_VALS));
    if (has_coverage(UVM_CVR_FIELD_VALS)) begin
      wr_fld_covg = new();
      rd_fld_covg = new();
    end
  endfunction

endclass


/////////////////////////////////////////////////////
//                phy_pipe_tx_dmph
/////////////////////////////////////////////////////
class T_phy_pipe_tx_dmph_194 extends cdns_uvm_reg;

  `uvm_object_utils(T_phy_pipe_tx_dmph_194)
  rand uvm_reg_field phy_pipe_tx_dmph_17_0;
  rand uvm_reg_field phy_pipe_tx_dmph_23_18;
  rand uvm_reg_field phy_pipe_tx_dmph_29_24;
  rand uvm_reg_field phy_pipe_tx_dmph_31_30;
  
  covergroup wr_fld_covg;
    phy_pipe_tx_dmph_17_0: coverpoint phy_pipe_tx_dmph_17_0.value[17:0];
    phy_pipe_tx_dmph_23_18: coverpoint phy_pipe_tx_dmph_23_18.value[5:0];
    phy_pipe_tx_dmph_29_24: coverpoint phy_pipe_tx_dmph_29_24.value[5:0];
    phy_pipe_tx_dmph_31_30: coverpoint phy_pipe_tx_dmph_31_30.value[1:0];
  endgroup
  covergroup rd_fld_covg;
    phy_pipe_tx_dmph_17_0: coverpoint phy_pipe_tx_dmph_17_0.value[17:0];
    phy_pipe_tx_dmph_23_18: coverpoint phy_pipe_tx_dmph_23_18.value[5:0];
    phy_pipe_tx_dmph_29_24: coverpoint phy_pipe_tx_dmph_29_24.value[5:0];
    phy_pipe_tx_dmph_31_30: coverpoint phy_pipe_tx_dmph_31_30.value[1:0];
  endgroup

  protected virtual function void sample(uvm_reg_data_t data, uvm_reg_data_t byte_en, bit is_read, uvm_reg_map map);
    super.sample(data, byte_en, is_read, map);
    if (get_coverage(UVM_CVR_FIELD_VALS)) begin
      if(!is_read) begin
          wr_fld_covg.sample();
      end
      if(is_read) begin
         rd_fld_covg.sample();
      end
    end
  endfunction

  virtual function void sample_values();
    super.sample_values();
    if (get_coverage(UVM_CVR_FIELD_VALS)) begin
      wr_fld_covg.sample();
      rd_fld_covg.sample();
    end
  endfunction

  virtual function void build();
    uvm_reg_field fld_set[$];
    uvm_reg_field_config_ta ta = get_field_config(getconfigUID());
    build_uvm_reg_fields(this, ta, fld_set);
    
    phy_pipe_tx_dmph_17_0 = fld_set[0];
    phy_pipe_tx_dmph_23_18 = fld_set[1];
    phy_pipe_tx_dmph_29_24 = fld_set[2];
    phy_pipe_tx_dmph_31_30 = fld_set[3];
  endfunction

  function new(input string name="T_phy_pipe_tx_dmph_194");
    super.new(name, 32, build_coverage(UVM_CVR_FIELD_VALS));
    if (has_coverage(UVM_CVR_FIELD_VALS)) begin
      wr_fld_covg = new();
      rd_fld_covg = new();
    end
  endfunction

endclass


/////////////////////////////////////////////////////
//                phy_top_uc_ln_en_int_sts1
/////////////////////////////////////////////////////
class T_phy_top_uc_ln_en_int_sts1_214 extends cdns_uvm_reg;

  `uvm_object_utils(T_phy_top_uc_ln_en_int_sts1_214)
  rand uvm_reg_field phy_top_uc_ln_en_int_sts1_31_0;
  
  covergroup wr_fld_covg;
    phy_top_uc_ln_en_int_sts1_31_0: coverpoint phy_top_uc_ln_en_int_sts1_31_0.value[31:0];
  endgroup
  covergroup rd_fld_covg;
    phy_top_uc_ln_en_int_sts1_31_0: coverpoint phy_top_uc_ln_en_int_sts1_31_0.value[31:0];
  endgroup

  protected virtual function void sample(uvm_reg_data_t data, uvm_reg_data_t byte_en, bit is_read, uvm_reg_map map);
    super.sample(data, byte_en, is_read, map);
    if (get_coverage(UVM_CVR_FIELD_VALS)) begin
      if(!is_read) begin
          wr_fld_covg.sample();
      end
      if(is_read) begin
         rd_fld_covg.sample();
      end
    end
  endfunction

  virtual function void sample_values();
    super.sample_values();
    if (get_coverage(UVM_CVR_FIELD_VALS)) begin
      wr_fld_covg.sample();
      rd_fld_covg.sample();
    end
  endfunction

  virtual function void build();
    uvm_reg_field fld_set[$];
    uvm_reg_field_config_ta ta = get_field_config(getconfigUID());
    build_uvm_reg_fields(this, ta, fld_set);
    
    phy_top_uc_ln_en_int_sts1_31_0 = fld_set[0];
  endfunction

  function new(input string name="T_phy_top_uc_ln_en_int_sts1_214");
    super.new(name, 32, build_coverage(UVM_CVR_FIELD_VALS));
    if (has_coverage(UVM_CVR_FIELD_VALS)) begin
      wr_fld_covg = new();
      rd_fld_covg = new();
    end
  endfunction

endclass


/////////////////////////////////////////////////////
//                phy_top_uc_ln_en_int_sts2
/////////////////////////////////////////////////////
class T_phy_top_uc_ln_en_int_sts2_230 extends cdns_uvm_reg;

  `uvm_object_utils(T_phy_top_uc_ln_en_int_sts2_230)
  rand uvm_reg_field phy_top_uc_ln_en_int_sts2_31_0;
  
  covergroup wr_fld_covg;
    phy_top_uc_ln_en_int_sts2_31_0: coverpoint phy_top_uc_ln_en_int_sts2_31_0.value[31:0];
  endgroup
  covergroup rd_fld_covg;
    phy_top_uc_ln_en_int_sts2_31_0: coverpoint phy_top_uc_ln_en_int_sts2_31_0.value[31:0];
  endgroup

  protected virtual function void sample(uvm_reg_data_t data, uvm_reg_data_t byte_en, bit is_read, uvm_reg_map map);
    super.sample(data, byte_en, is_read, map);
    if (get_coverage(UVM_CVR_FIELD_VALS)) begin
      if(!is_read) begin
          wr_fld_covg.sample();
      end
      if(is_read) begin
         rd_fld_covg.sample();
      end
    end
  endfunction

  virtual function void sample_values();
    super.sample_values();
    if (get_coverage(UVM_CVR_FIELD_VALS)) begin
      wr_fld_covg.sample();
      rd_fld_covg.sample();
    end
  endfunction

  virtual function void build();
    uvm_reg_field fld_set[$];
    uvm_reg_field_config_ta ta = get_field_config(getconfigUID());
    build_uvm_reg_fields(this, ta, fld_set);
    
    phy_top_uc_ln_en_int_sts2_31_0 = fld_set[0];
  endfunction

  function new(input string name="T_phy_top_uc_ln_en_int_sts2_230");
    super.new(name, 32, build_coverage(UVM_CVR_FIELD_VALS));
    if (has_coverage(UVM_CVR_FIELD_VALS)) begin
      wr_fld_covg = new();
      rd_fld_covg = new();
    end
  endfunction

endclass


/////////////////////////////////////////////////////
//                phy_top_uc_pcs_int_sts1_en
/////////////////////////////////////////////////////
class T_phy_top_uc_pcs_int_sts1_en_212 extends cdns_uvm_reg;

  `uvm_object_utils(T_phy_top_uc_pcs_int_sts1_en_212)
  rand uvm_reg_field phy_top_uc_pcs_int_sts1_en_31_0;
  
  covergroup wr_fld_covg;
    phy_top_uc_pcs_int_sts1_en_31_0: coverpoint phy_top_uc_pcs_int_sts1_en_31_0.value[31:0];
  endgroup
  covergroup rd_fld_covg;
    phy_top_uc_pcs_int_sts1_en_31_0: coverpoint phy_top_uc_pcs_int_sts1_en_31_0.value[31:0];
  endgroup

  protected virtual function void sample(uvm_reg_data_t data, uvm_reg_data_t byte_en, bit is_read, uvm_reg_map map);
    super.sample(data, byte_en, is_read, map);
    if (get_coverage(UVM_CVR_FIELD_VALS)) begin
      if(!is_read) begin
          wr_fld_covg.sample();
      end
      if(is_read) begin
         rd_fld_covg.sample();
      end
    end
  endfunction

  virtual function void sample_values();
    super.sample_values();
    if (get_coverage(UVM_CVR_FIELD_VALS)) begin
      wr_fld_covg.sample();
      rd_fld_covg.sample();
    end
  endfunction

  virtual function void build();
    uvm_reg_field fld_set[$];
    uvm_reg_field_config_ta ta = get_field_config(getconfigUID());
    build_uvm_reg_fields(this, ta, fld_set);
    
    phy_top_uc_pcs_int_sts1_en_31_0 = fld_set[0];
  endfunction

  function new(input string name="T_phy_top_uc_pcs_int_sts1_en_212");
    super.new(name, 32, build_coverage(UVM_CVR_FIELD_VALS));
    if (has_coverage(UVM_CVR_FIELD_VALS)) begin
      wr_fld_covg = new();
      rd_fld_covg = new();
    end
  endfunction

endclass


/////////////////////////////////////////////////////
//                phy_top_uc_pcs_int_sts2_en
/////////////////////////////////////////////////////
class T_phy_top_uc_pcs_int_sts2_en_228 extends cdns_uvm_reg;

  `uvm_object_utils(T_phy_top_uc_pcs_int_sts2_en_228)
  rand uvm_reg_field phy_top_uc_pcs_int_sts2_en_31_0;
  
  covergroup wr_fld_covg;
    phy_top_uc_pcs_int_sts2_en_31_0: coverpoint phy_top_uc_pcs_int_sts2_en_31_0.value[31:0];
  endgroup
  covergroup rd_fld_covg;
    phy_top_uc_pcs_int_sts2_en_31_0: coverpoint phy_top_uc_pcs_int_sts2_en_31_0.value[31:0];
  endgroup

  protected virtual function void sample(uvm_reg_data_t data, uvm_reg_data_t byte_en, bit is_read, uvm_reg_map map);
    super.sample(data, byte_en, is_read, map);
    if (get_coverage(UVM_CVR_FIELD_VALS)) begin
      if(!is_read) begin
          wr_fld_covg.sample();
      end
      if(is_read) begin
         rd_fld_covg.sample();
      end
    end
  endfunction

  virtual function void sample_values();
    super.sample_values();
    if (get_coverage(UVM_CVR_FIELD_VALS)) begin
      wr_fld_covg.sample();
      rd_fld_covg.sample();
    end
  endfunction

  virtual function void build();
    uvm_reg_field fld_set[$];
    uvm_reg_field_config_ta ta = get_field_config(getconfigUID());
    build_uvm_reg_fields(this, ta, fld_set);
    
    phy_top_uc_pcs_int_sts2_en_31_0 = fld_set[0];
  endfunction

  function new(input string name="T_phy_top_uc_pcs_int_sts2_en_228");
    super.new(name, 32, build_coverage(UVM_CVR_FIELD_VALS));
    if (has_coverage(UVM_CVR_FIELD_VALS)) begin
      wr_fld_covg = new();
      rd_fld_covg = new();
    end
  endfunction

endclass


/////////////////////////////////////////////////////
//                phy_uc_pcs_int_sts1
/////////////////////////////////////////////////////
class T_phy_uc_pcs_int_sts1_209 extends cdns_uvm_reg;

  `uvm_object_utils(T_phy_uc_pcs_int_sts1_209)
  rand uvm_reg_field phy_uc_pcs_int_sts1_0;
  rand uvm_reg_field phy_uc_pcs_int_sts1_1;
  rand uvm_reg_field phy_uc_pcs_int_sts1_2;
  rand uvm_reg_field phy_uc_pcs_int_sts1_3;
  rand uvm_reg_field phy_uc_pcs_int_sts1_4;
  rand uvm_reg_field phy_uc_pcs_int_sts1_5;
  rand uvm_reg_field phy_uc_pcs_int_sts1_6;
  rand uvm_reg_field phy_uc_pcs_int_sts1_7;
  rand uvm_reg_field phy_uc_pcs_int_sts1_8;
  rand uvm_reg_field phy_uc_pcs_int_sts1_9;
  rand uvm_reg_field phy_uc_pcs_int_sts1_10;
  rand uvm_reg_field phy_uc_pcs_int_sts1_11;
  rand uvm_reg_field phy_uc_pcs_int_sts1_12;
  rand uvm_reg_field phy_uc_pcs_int_sts1_13;
  rand uvm_reg_field phy_uc_pcs_int_sts1_14;
  rand uvm_reg_field phy_uc_pcs_int_sts1_15;
  rand uvm_reg_field phy_uc_pcs_int_sts1_16;
  rand uvm_reg_field phy_uc_pcs_int_sts1_17;
  rand uvm_reg_field phy_uc_pcs_int_sts1_18;
  rand uvm_reg_field phy_uc_pcs_int_sts1_19;
  rand uvm_reg_field phy_uc_pcs_int_sts1_21_20;
  rand uvm_reg_field phy_uc_pcs_int_sts1_22;
  rand uvm_reg_field phy_uc_pcs_int_sts1_23;
  rand uvm_reg_field phy_uc_pcs_int_sts1_25_24;
  rand uvm_reg_field phy_uc_pcs_int_sts1_26;
  rand uvm_reg_field phy_uc_pcs_int_sts1_27;
  rand uvm_reg_field phy_uc_pcs_int_sts1_30_28;
  rand uvm_reg_field phy_uc_pcs_int_sts1_31;
  
  covergroup wr_fld_covg;
    phy_uc_pcs_int_sts1_0: coverpoint phy_uc_pcs_int_sts1_0.value[0:0];
    phy_uc_pcs_int_sts1_1: coverpoint phy_uc_pcs_int_sts1_1.value[0:0];
    phy_uc_pcs_int_sts1_2: coverpoint phy_uc_pcs_int_sts1_2.value[0:0];
    phy_uc_pcs_int_sts1_3: coverpoint phy_uc_pcs_int_sts1_3.value[0:0];
    phy_uc_pcs_int_sts1_4: coverpoint phy_uc_pcs_int_sts1_4.value[0:0];
    phy_uc_pcs_int_sts1_5: coverpoint phy_uc_pcs_int_sts1_5.value[0:0];
    phy_uc_pcs_int_sts1_6: coverpoint phy_uc_pcs_int_sts1_6.value[0:0];
    phy_uc_pcs_int_sts1_7: coverpoint phy_uc_pcs_int_sts1_7.value[0:0];
    phy_uc_pcs_int_sts1_8: coverpoint phy_uc_pcs_int_sts1_8.value[0:0];
    phy_uc_pcs_int_sts1_9: coverpoint phy_uc_pcs_int_sts1_9.value[0:0];
    phy_uc_pcs_int_sts1_10: coverpoint phy_uc_pcs_int_sts1_10.value[0:0];
    phy_uc_pcs_int_sts1_11: coverpoint phy_uc_pcs_int_sts1_11.value[0:0];
    phy_uc_pcs_int_sts1_12: coverpoint phy_uc_pcs_int_sts1_12.value[0:0];
    phy_uc_pcs_int_sts1_13: coverpoint phy_uc_pcs_int_sts1_13.value[0:0];
    phy_uc_pcs_int_sts1_14: coverpoint phy_uc_pcs_int_sts1_14.value[0:0];
    phy_uc_pcs_int_sts1_15: coverpoint phy_uc_pcs_int_sts1_15.value[0:0];
    phy_uc_pcs_int_sts1_16: coverpoint phy_uc_pcs_int_sts1_16.value[0:0];
    phy_uc_pcs_int_sts1_17: coverpoint phy_uc_pcs_int_sts1_17.value[0:0];
    phy_uc_pcs_int_sts1_18: coverpoint phy_uc_pcs_int_sts1_18.value[0:0];
    phy_uc_pcs_int_sts1_19: coverpoint phy_uc_pcs_int_sts1_19.value[0:0];
    phy_uc_pcs_int_sts1_21_20: coverpoint phy_uc_pcs_int_sts1_21_20.value[1:0];
    phy_uc_pcs_int_sts1_22: coverpoint phy_uc_pcs_int_sts1_22.value[0:0];
    phy_uc_pcs_int_sts1_23: coverpoint phy_uc_pcs_int_sts1_23.value[0:0];
    phy_uc_pcs_int_sts1_25_24: coverpoint phy_uc_pcs_int_sts1_25_24.value[1:0];
    phy_uc_pcs_int_sts1_26: coverpoint phy_uc_pcs_int_sts1_26.value[0:0];
    phy_uc_pcs_int_sts1_27: coverpoint phy_uc_pcs_int_sts1_27.value[0:0];
    phy_uc_pcs_int_sts1_30_28: coverpoint phy_uc_pcs_int_sts1_30_28.value[2:0];
    phy_uc_pcs_int_sts1_31: coverpoint phy_uc_pcs_int_sts1_31.value[0:0];
  endgroup
  covergroup rd_fld_covg;
    phy_uc_pcs_int_sts1_0: coverpoint phy_uc_pcs_int_sts1_0.value[0:0];
    phy_uc_pcs_int_sts1_1: coverpoint phy_uc_pcs_int_sts1_1.value[0:0];
    phy_uc_pcs_int_sts1_2: coverpoint phy_uc_pcs_int_sts1_2.value[0:0];
    phy_uc_pcs_int_sts1_3: coverpoint phy_uc_pcs_int_sts1_3.value[0:0];
    phy_uc_pcs_int_sts1_4: coverpoint phy_uc_pcs_int_sts1_4.value[0:0];
    phy_uc_pcs_int_sts1_5: coverpoint phy_uc_pcs_int_sts1_5.value[0:0];
    phy_uc_pcs_int_sts1_6: coverpoint phy_uc_pcs_int_sts1_6.value[0:0];
    phy_uc_pcs_int_sts1_7: coverpoint phy_uc_pcs_int_sts1_7.value[0:0];
    phy_uc_pcs_int_sts1_8: coverpoint phy_uc_pcs_int_sts1_8.value[0:0];
    phy_uc_pcs_int_sts1_9: coverpoint phy_uc_pcs_int_sts1_9.value[0:0];
    phy_uc_pcs_int_sts1_10: coverpoint phy_uc_pcs_int_sts1_10.value[0:0];
    phy_uc_pcs_int_sts1_11: coverpoint phy_uc_pcs_int_sts1_11.value[0:0];
    phy_uc_pcs_int_sts1_12: coverpoint phy_uc_pcs_int_sts1_12.value[0:0];
    phy_uc_pcs_int_sts1_13: coverpoint phy_uc_pcs_int_sts1_13.value[0:0];
    phy_uc_pcs_int_sts1_14: coverpoint phy_uc_pcs_int_sts1_14.value[0:0];
    phy_uc_pcs_int_sts1_15: coverpoint phy_uc_pcs_int_sts1_15.value[0:0];
    phy_uc_pcs_int_sts1_16: coverpoint phy_uc_pcs_int_sts1_16.value[0:0];
    phy_uc_pcs_int_sts1_17: coverpoint phy_uc_pcs_int_sts1_17.value[0:0];
    phy_uc_pcs_int_sts1_18: coverpoint phy_uc_pcs_int_sts1_18.value[0:0];
    phy_uc_pcs_int_sts1_19: coverpoint phy_uc_pcs_int_sts1_19.value[0:0];
    phy_uc_pcs_int_sts1_21_20: coverpoint phy_uc_pcs_int_sts1_21_20.value[1:0];
    phy_uc_pcs_int_sts1_22: coverpoint phy_uc_pcs_int_sts1_22.value[0:0];
    phy_uc_pcs_int_sts1_23: coverpoint phy_uc_pcs_int_sts1_23.value[0:0];
    phy_uc_pcs_int_sts1_25_24: coverpoint phy_uc_pcs_int_sts1_25_24.value[1:0];
    phy_uc_pcs_int_sts1_26: coverpoint phy_uc_pcs_int_sts1_26.value[0:0];
    phy_uc_pcs_int_sts1_27: coverpoint phy_uc_pcs_int_sts1_27.value[0:0];
    phy_uc_pcs_int_sts1_30_28: coverpoint phy_uc_pcs_int_sts1_30_28.value[2:0];
    phy_uc_pcs_int_sts1_31: coverpoint phy_uc_pcs_int_sts1_31.value[0:0];
  endgroup

  protected virtual function void sample(uvm_reg_data_t data, uvm_reg_data_t byte_en, bit is_read, uvm_reg_map map);
    super.sample(data, byte_en, is_read, map);
    if (get_coverage(UVM_CVR_FIELD_VALS)) begin
      if(!is_read) begin
          wr_fld_covg.sample();
      end
      if(is_read) begin
         rd_fld_covg.sample();
      end
    end
  endfunction

  virtual function void sample_values();
    super.sample_values();
    if (get_coverage(UVM_CVR_FIELD_VALS)) begin
      wr_fld_covg.sample();
      rd_fld_covg.sample();
    end
  endfunction

  virtual function void build();
    uvm_reg_field fld_set[$];
    uvm_reg_field_config_ta ta = get_field_config(getconfigUID());
    build_uvm_reg_fields(this, ta, fld_set);
    
    phy_uc_pcs_int_sts1_0 = fld_set[0];
    phy_uc_pcs_int_sts1_1 = fld_set[1];
    phy_uc_pcs_int_sts1_2 = fld_set[2];
    phy_uc_pcs_int_sts1_3 = fld_set[3];
    phy_uc_pcs_int_sts1_4 = fld_set[4];
    phy_uc_pcs_int_sts1_5 = fld_set[5];
    phy_uc_pcs_int_sts1_6 = fld_set[6];
    phy_uc_pcs_int_sts1_7 = fld_set[7];
    phy_uc_pcs_int_sts1_8 = fld_set[8];
    phy_uc_pcs_int_sts1_9 = fld_set[9];
    phy_uc_pcs_int_sts1_10 = fld_set[10];
    phy_uc_pcs_int_sts1_11 = fld_set[11];
    phy_uc_pcs_int_sts1_12 = fld_set[12];
    phy_uc_pcs_int_sts1_13 = fld_set[13];
    phy_uc_pcs_int_sts1_14 = fld_set[14];
    phy_uc_pcs_int_sts1_15 = fld_set[15];
    phy_uc_pcs_int_sts1_16 = fld_set[16];
    phy_uc_pcs_int_sts1_17 = fld_set[17];
    phy_uc_pcs_int_sts1_18 = fld_set[18];
    phy_uc_pcs_int_sts1_19 = fld_set[19];
    phy_uc_pcs_int_sts1_21_20 = fld_set[20];
    phy_uc_pcs_int_sts1_22 = fld_set[21];
    phy_uc_pcs_int_sts1_23 = fld_set[22];
    phy_uc_pcs_int_sts1_25_24 = fld_set[23];
    phy_uc_pcs_int_sts1_26 = fld_set[24];
    phy_uc_pcs_int_sts1_27 = fld_set[25];
    phy_uc_pcs_int_sts1_30_28 = fld_set[26];
    phy_uc_pcs_int_sts1_31 = fld_set[27];
  endfunction

  function new(input string name="T_phy_uc_pcs_int_sts1_209");
    super.new(name, 32, build_coverage(UVM_CVR_FIELD_VALS));
    if (has_coverage(UVM_CVR_FIELD_VALS)) begin
      wr_fld_covg = new();
      rd_fld_covg = new();
    end
  endfunction

endclass


/////////////////////////////////////////////////////
//                phy_uc_pcs_int_sts1_set
/////////////////////////////////////////////////////
class T_phy_uc_pcs_int_sts1_set_210 extends cdns_uvm_reg;

  `uvm_object_utils(T_phy_uc_pcs_int_sts1_set_210)
  rand uvm_reg_field phy_uc_pcs_int_sts1_set_19_0;
  rand uvm_reg_field phy_uc_pcs_int_sts1_set_21_20;
  rand uvm_reg_field phy_uc_pcs_int_sts1_set_23_22;
  rand uvm_reg_field phy_uc_pcs_int_sts1_set_25_24;
  rand uvm_reg_field phy_uc_pcs_int_sts1_set_27_26;
  rand uvm_reg_field phy_uc_pcs_int_sts1_set_31_28;
  
  covergroup wr_fld_covg;
    phy_uc_pcs_int_sts1_set_19_0: coverpoint phy_uc_pcs_int_sts1_set_19_0.value[19:0];
    phy_uc_pcs_int_sts1_set_21_20: coverpoint phy_uc_pcs_int_sts1_set_21_20.value[1:0];
    phy_uc_pcs_int_sts1_set_23_22: coverpoint phy_uc_pcs_int_sts1_set_23_22.value[1:0];
    phy_uc_pcs_int_sts1_set_25_24: coverpoint phy_uc_pcs_int_sts1_set_25_24.value[1:0];
    phy_uc_pcs_int_sts1_set_27_26: coverpoint phy_uc_pcs_int_sts1_set_27_26.value[1:0];
    phy_uc_pcs_int_sts1_set_31_28: coverpoint phy_uc_pcs_int_sts1_set_31_28.value[3:0];
  endgroup
  covergroup rd_fld_covg;
    phy_uc_pcs_int_sts1_set_19_0: coverpoint phy_uc_pcs_int_sts1_set_19_0.value[19:0];
    phy_uc_pcs_int_sts1_set_21_20: coverpoint phy_uc_pcs_int_sts1_set_21_20.value[1:0];
    phy_uc_pcs_int_sts1_set_23_22: coverpoint phy_uc_pcs_int_sts1_set_23_22.value[1:0];
    phy_uc_pcs_int_sts1_set_25_24: coverpoint phy_uc_pcs_int_sts1_set_25_24.value[1:0];
    phy_uc_pcs_int_sts1_set_27_26: coverpoint phy_uc_pcs_int_sts1_set_27_26.value[1:0];
    phy_uc_pcs_int_sts1_set_31_28: coverpoint phy_uc_pcs_int_sts1_set_31_28.value[3:0];
  endgroup

  protected virtual function void sample(uvm_reg_data_t data, uvm_reg_data_t byte_en, bit is_read, uvm_reg_map map);
    super.sample(data, byte_en, is_read, map);
    if (get_coverage(UVM_CVR_FIELD_VALS)) begin
      if(!is_read) begin
          wr_fld_covg.sample();
      end
      if(is_read) begin
         rd_fld_covg.sample();
      end
    end
  endfunction

  virtual function void sample_values();
    super.sample_values();
    if (get_coverage(UVM_CVR_FIELD_VALS)) begin
      wr_fld_covg.sample();
      rd_fld_covg.sample();
    end
  endfunction

  virtual function void build();
    uvm_reg_field fld_set[$];
    uvm_reg_field_config_ta ta = get_field_config(getconfigUID());
    build_uvm_reg_fields(this, ta, fld_set);
    
    phy_uc_pcs_int_sts1_set_19_0 = fld_set[0];
    phy_uc_pcs_int_sts1_set_21_20 = fld_set[1];
    phy_uc_pcs_int_sts1_set_23_22 = fld_set[2];
    phy_uc_pcs_int_sts1_set_25_24 = fld_set[3];
    phy_uc_pcs_int_sts1_set_27_26 = fld_set[4];
    phy_uc_pcs_int_sts1_set_31_28 = fld_set[5];
  endfunction

  function new(input string name="T_phy_uc_pcs_int_sts1_set_210");
    super.new(name, 32, build_coverage(UVM_CVR_FIELD_VALS));
    if (has_coverage(UVM_CVR_FIELD_VALS)) begin
      wr_fld_covg = new();
      rd_fld_covg = new();
    end
  endfunction

endclass


/////////////////////////////////////////////////////
//                phy_uc_pcs_int_sts2
/////////////////////////////////////////////////////
class T_phy_uc_pcs_int_sts2_225 extends cdns_uvm_reg;

  `uvm_object_utils(T_phy_uc_pcs_int_sts2_225)
  rand uvm_reg_field phy_uc_pcs_int_sts2_0;
  rand uvm_reg_field phy_uc_pcs_int_sts2_1;
  rand uvm_reg_field phy_uc_pcs_int_sts2_31_2;
  
  covergroup wr_fld_covg;
    phy_uc_pcs_int_sts2_0: coverpoint phy_uc_pcs_int_sts2_0.value[0:0];
    phy_uc_pcs_int_sts2_1: coverpoint phy_uc_pcs_int_sts2_1.value[0:0];
    phy_uc_pcs_int_sts2_31_2: coverpoint phy_uc_pcs_int_sts2_31_2.value[29:0];
  endgroup
  covergroup rd_fld_covg;
    phy_uc_pcs_int_sts2_0: coverpoint phy_uc_pcs_int_sts2_0.value[0:0];
    phy_uc_pcs_int_sts2_1: coverpoint phy_uc_pcs_int_sts2_1.value[0:0];
    phy_uc_pcs_int_sts2_31_2: coverpoint phy_uc_pcs_int_sts2_31_2.value[29:0];
  endgroup

  protected virtual function void sample(uvm_reg_data_t data, uvm_reg_data_t byte_en, bit is_read, uvm_reg_map map);
    super.sample(data, byte_en, is_read, map);
    if (get_coverage(UVM_CVR_FIELD_VALS)) begin
      if(!is_read) begin
          wr_fld_covg.sample();
      end
      if(is_read) begin
         rd_fld_covg.sample();
      end
    end
  endfunction

  virtual function void sample_values();
    super.sample_values();
    if (get_coverage(UVM_CVR_FIELD_VALS)) begin
      wr_fld_covg.sample();
      rd_fld_covg.sample();
    end
  endfunction

  virtual function void build();
    uvm_reg_field fld_set[$];
    uvm_reg_field_config_ta ta = get_field_config(getconfigUID());
    build_uvm_reg_fields(this, ta, fld_set);
    
    phy_uc_pcs_int_sts2_0 = fld_set[0];
    phy_uc_pcs_int_sts2_1 = fld_set[1];
    phy_uc_pcs_int_sts2_31_2 = fld_set[2];
  endfunction

  function new(input string name="T_phy_uc_pcs_int_sts2_225");
    super.new(name, 32, build_coverage(UVM_CVR_FIELD_VALS));
    if (has_coverage(UVM_CVR_FIELD_VALS)) begin
      wr_fld_covg = new();
      rd_fld_covg = new();
    end
  endfunction

endclass


/////////////////////////////////////////////////////
//                phy_uc_pcs_int_sts2_set
/////////////////////////////////////////////////////
class T_phy_uc_pcs_int_sts2_set_226 extends cdns_uvm_reg;

  `uvm_object_utils(T_phy_uc_pcs_int_sts2_set_226)
  rand uvm_reg_field phy_uc_pcs_int_sts2_set_1_0;
  rand uvm_reg_field phy_uc_pcs_int_sts2_set_31_2;
  
  covergroup wr_fld_covg;
    phy_uc_pcs_int_sts2_set_1_0: coverpoint phy_uc_pcs_int_sts2_set_1_0.value[1:0];
    phy_uc_pcs_int_sts2_set_31_2: coverpoint phy_uc_pcs_int_sts2_set_31_2.value[29:0];
  endgroup
  covergroup rd_fld_covg;
    phy_uc_pcs_int_sts2_set_1_0: coverpoint phy_uc_pcs_int_sts2_set_1_0.value[1:0];
    phy_uc_pcs_int_sts2_set_31_2: coverpoint phy_uc_pcs_int_sts2_set_31_2.value[29:0];
  endgroup

  protected virtual function void sample(uvm_reg_data_t data, uvm_reg_data_t byte_en, bit is_read, uvm_reg_map map);
    super.sample(data, byte_en, is_read, map);
    if (get_coverage(UVM_CVR_FIELD_VALS)) begin
      if(!is_read) begin
          wr_fld_covg.sample();
      end
      if(is_read) begin
         rd_fld_covg.sample();
      end
    end
  endfunction

  virtual function void sample_values();
    super.sample_values();
    if (get_coverage(UVM_CVR_FIELD_VALS)) begin
      wr_fld_covg.sample();
      rd_fld_covg.sample();
    end
  endfunction

  virtual function void build();
    uvm_reg_field fld_set[$];
    uvm_reg_field_config_ta ta = get_field_config(getconfigUID());
    build_uvm_reg_fields(this, ta, fld_set);
    
    phy_uc_pcs_int_sts2_set_1_0 = fld_set[0];
    phy_uc_pcs_int_sts2_set_31_2 = fld_set[1];
  endfunction

  function new(input string name="T_phy_uc_pcs_int_sts2_set_226");
    super.new(name, 32, build_coverage(UVM_CVR_FIELD_VALS));
    if (has_coverage(UVM_CVR_FIELD_VALS)) begin
      wr_fld_covg = new();
      rd_fld_covg = new();
    end
  endfunction

endclass


/////////////////////////////////////////////////////
//                phy_usb3_iso_rx_ctrl
/////////////////////////////////////////////////////
class T_phy_usb3_iso_rx_ctrl_193 extends cdns_uvm_reg;

  `uvm_object_utils(T_phy_usb3_iso_rx_ctrl_193)
  rand uvm_reg_field phy_usb3_iso_rx_ctrl_2_0;
  rand uvm_reg_field phy_usb3_iso_rx_ctrl_3;
  rand uvm_reg_field phy_usb3_iso_rx_ctrl_4;
  rand uvm_reg_field phy_usb3_iso_rx_ctrl_5;
  rand uvm_reg_field phy_usb3_iso_rx_ctrl_6;
  rand uvm_reg_field phy_usb3_iso_rx_ctrl_7;
  rand uvm_reg_field phy_usb3_iso_rx_ctrl_8;
  rand uvm_reg_field phy_usb3_iso_rx_ctrl_9;
  rand uvm_reg_field phy_usb3_iso_rx_ctrl_11_10;
  rand uvm_reg_field phy_usb3_iso_rx_ctrl_15_12;
  rand uvm_reg_field phy_usb3_iso_rx_ctrl_31_16;
  
  covergroup wr_fld_covg;
    phy_usb3_iso_rx_ctrl_2_0: coverpoint phy_usb3_iso_rx_ctrl_2_0.value[2:0];
    phy_usb3_iso_rx_ctrl_3: coverpoint phy_usb3_iso_rx_ctrl_3.value[0:0];
    phy_usb3_iso_rx_ctrl_4: coverpoint phy_usb3_iso_rx_ctrl_4.value[0:0];
    phy_usb3_iso_rx_ctrl_5: coverpoint phy_usb3_iso_rx_ctrl_5.value[0:0];
    phy_usb3_iso_rx_ctrl_6: coverpoint phy_usb3_iso_rx_ctrl_6.value[0:0];
    phy_usb3_iso_rx_ctrl_7: coverpoint phy_usb3_iso_rx_ctrl_7.value[0:0];
    phy_usb3_iso_rx_ctrl_8: coverpoint phy_usb3_iso_rx_ctrl_8.value[0:0];
    phy_usb3_iso_rx_ctrl_9: coverpoint phy_usb3_iso_rx_ctrl_9.value[0:0];
    phy_usb3_iso_rx_ctrl_11_10: coverpoint phy_usb3_iso_rx_ctrl_11_10.value[1:0];
    phy_usb3_iso_rx_ctrl_15_12: coverpoint phy_usb3_iso_rx_ctrl_15_12.value[3:0];
    phy_usb3_iso_rx_ctrl_31_16: coverpoint phy_usb3_iso_rx_ctrl_31_16.value[15:0];
  endgroup
  covergroup rd_fld_covg;
    phy_usb3_iso_rx_ctrl_2_0: coverpoint phy_usb3_iso_rx_ctrl_2_0.value[2:0];
    phy_usb3_iso_rx_ctrl_3: coverpoint phy_usb3_iso_rx_ctrl_3.value[0:0];
    phy_usb3_iso_rx_ctrl_4: coverpoint phy_usb3_iso_rx_ctrl_4.value[0:0];
    phy_usb3_iso_rx_ctrl_5: coverpoint phy_usb3_iso_rx_ctrl_5.value[0:0];
    phy_usb3_iso_rx_ctrl_6: coverpoint phy_usb3_iso_rx_ctrl_6.value[0:0];
    phy_usb3_iso_rx_ctrl_7: coverpoint phy_usb3_iso_rx_ctrl_7.value[0:0];
    phy_usb3_iso_rx_ctrl_8: coverpoint phy_usb3_iso_rx_ctrl_8.value[0:0];
    phy_usb3_iso_rx_ctrl_9: coverpoint phy_usb3_iso_rx_ctrl_9.value[0:0];
    phy_usb3_iso_rx_ctrl_11_10: coverpoint phy_usb3_iso_rx_ctrl_11_10.value[1:0];
    phy_usb3_iso_rx_ctrl_15_12: coverpoint phy_usb3_iso_rx_ctrl_15_12.value[3:0];
    phy_usb3_iso_rx_ctrl_31_16: coverpoint phy_usb3_iso_rx_ctrl_31_16.value[15:0];
  endgroup

  protected virtual function void sample(uvm_reg_data_t data, uvm_reg_data_t byte_en, bit is_read, uvm_reg_map map);
    super.sample(data, byte_en, is_read, map);
    if (get_coverage(UVM_CVR_FIELD_VALS)) begin
      if(!is_read) begin
          wr_fld_covg.sample();
      end
      if(is_read) begin
         rd_fld_covg.sample();
      end
    end
  endfunction

  virtual function void sample_values();
    super.sample_values();
    if (get_coverage(UVM_CVR_FIELD_VALS)) begin
      wr_fld_covg.sample();
      rd_fld_covg.sample();
    end
  endfunction

  virtual function void build();
    uvm_reg_field fld_set[$];
    uvm_reg_field_config_ta ta = get_field_config(getconfigUID());
    build_uvm_reg_fields(this, ta, fld_set);
    
    phy_usb3_iso_rx_ctrl_2_0 = fld_set[0];
    phy_usb3_iso_rx_ctrl_3 = fld_set[1];
    phy_usb3_iso_rx_ctrl_4 = fld_set[2];
    phy_usb3_iso_rx_ctrl_5 = fld_set[3];
    phy_usb3_iso_rx_ctrl_6 = fld_set[4];
    phy_usb3_iso_rx_ctrl_7 = fld_set[5];
    phy_usb3_iso_rx_ctrl_8 = fld_set[6];
    phy_usb3_iso_rx_ctrl_9 = fld_set[7];
    phy_usb3_iso_rx_ctrl_11_10 = fld_set[8];
    phy_usb3_iso_rx_ctrl_15_12 = fld_set[9];
    phy_usb3_iso_rx_ctrl_31_16 = fld_set[10];
  endfunction

  function new(input string name="T_phy_usb3_iso_rx_ctrl_193");
    super.new(name, 32, build_coverage(UVM_CVR_FIELD_VALS));
    if (has_coverage(UVM_CVR_FIELD_VALS)) begin
      wr_fld_covg = new();
      rd_fld_covg = new();
    end
  endfunction

endclass


/////////////////////////////////////////////////////
//                phy_usb3_iso_tx_data
/////////////////////////////////////////////////////
class T_phy_usb3_iso_tx_data_199 extends cdns_uvm_reg;

  `uvm_object_utils(T_phy_usb3_iso_tx_data_199)
  rand uvm_reg_field phy_usb3_iso_tx_data_31_0;
  
  covergroup wr_fld_covg;
    phy_usb3_iso_tx_data_31_0: coverpoint phy_usb3_iso_tx_data_31_0.value[31:0];
  endgroup
  covergroup rd_fld_covg;
    phy_usb3_iso_tx_data_31_0: coverpoint phy_usb3_iso_tx_data_31_0.value[31:0];
  endgroup

  protected virtual function void sample(uvm_reg_data_t data, uvm_reg_data_t byte_en, bit is_read, uvm_reg_map map);
    super.sample(data, byte_en, is_read, map);
    if (get_coverage(UVM_CVR_FIELD_VALS)) begin
      if(!is_read) begin
          wr_fld_covg.sample();
      end
      if(is_read) begin
         rd_fld_covg.sample();
      end
    end
  endfunction

  virtual function void sample_values();
    super.sample_values();
    if (get_coverage(UVM_CVR_FIELD_VALS)) begin
      wr_fld_covg.sample();
      rd_fld_covg.sample();
    end
  endfunction

  virtual function void build();
    uvm_reg_field fld_set[$];
    uvm_reg_field_config_ta ta = get_field_config(getconfigUID());
    build_uvm_reg_fields(this, ta, fld_set);
    
    phy_usb3_iso_tx_data_31_0 = fld_set[0];
  endfunction

  function new(input string name="T_phy_usb3_iso_tx_data_199");
    super.new(name, 32, build_coverage(UVM_CVR_FIELD_VALS));
    if (has_coverage(UVM_CVR_FIELD_VALS)) begin
      wr_fld_covg = new();
      rd_fld_covg = new();
    end
  endfunction

endclass


/////////////////////////////////////////////////////
//                phy_usb3_iso_usb_ber_cnt
/////////////////////////////////////////////////////
class T_phy_usb3_iso_usb_ber_cnt_208 extends cdns_uvm_reg;

  `uvm_object_utils(T_phy_usb3_iso_usb_ber_cnt_208)
  rand uvm_reg_field phy_usb3_iso_usb_ber_cnt_7_0;
  rand uvm_reg_field phy_usb3_iso_usb_ber_cnt_31_8;
  
  covergroup wr_fld_covg;
    phy_usb3_iso_usb_ber_cnt_7_0: coverpoint phy_usb3_iso_usb_ber_cnt_7_0.value[7:0];
    phy_usb3_iso_usb_ber_cnt_31_8: coverpoint phy_usb3_iso_usb_ber_cnt_31_8.value[23:0];
  endgroup
  covergroup rd_fld_covg;
    phy_usb3_iso_usb_ber_cnt_7_0: coverpoint phy_usb3_iso_usb_ber_cnt_7_0.value[7:0];
    phy_usb3_iso_usb_ber_cnt_31_8: coverpoint phy_usb3_iso_usb_ber_cnt_31_8.value[23:0];
  endgroup

  protected virtual function void sample(uvm_reg_data_t data, uvm_reg_data_t byte_en, bit is_read, uvm_reg_map map);
    super.sample(data, byte_en, is_read, map);
    if (get_coverage(UVM_CVR_FIELD_VALS)) begin
      if(!is_read) begin
          wr_fld_covg.sample();
      end
      if(is_read) begin
         rd_fld_covg.sample();
      end
    end
  endfunction

  virtual function void sample_values();
    super.sample_values();
    if (get_coverage(UVM_CVR_FIELD_VALS)) begin
      wr_fld_covg.sample();
      rd_fld_covg.sample();
    end
  endfunction

  virtual function void build();
    uvm_reg_field fld_set[$];
    uvm_reg_field_config_ta ta = get_field_config(getconfigUID());
    build_uvm_reg_fields(this, ta, fld_set);
    
    phy_usb3_iso_usb_ber_cnt_7_0 = fld_set[0];
    phy_usb3_iso_usb_ber_cnt_31_8 = fld_set[1];
  endfunction

  function new(input string name="T_phy_usb3_iso_usb_ber_cnt_208");
    super.new(name, 32, build_coverage(UVM_CVR_FIELD_VALS));
    if (has_coverage(UVM_CVR_FIELD_VALS)) begin
      wr_fld_covg = new();
      rd_fld_covg = new();
    end
  endfunction

endclass


/////////////////////////////////////////////////////
//                uc_ln_ctrl
/////////////////////////////////////////////////////
class T_uc_ln_ctrl_215 extends cdns_uvm_reg;

  `uvm_object_utils(T_uc_ln_ctrl_215)
  rand uvm_reg_field uc_ln_ctrl_0;
  rand uvm_reg_field uc_ln_ctrl_1;
  rand uvm_reg_field uc_ln_ctrl_2;
  rand uvm_reg_field uc_ln_ctrl_3;
  rand uvm_reg_field uc_ln_ctrl_4;
  rand uvm_reg_field uc_ln_ctrl_5;
  rand uvm_reg_field uc_ln_ctrl_6;
  rand uvm_reg_field uc_ln_ctrl_7;
  rand uvm_reg_field uc_ln_ctrl_8;
  rand uvm_reg_field uc_ln_ctrl_9;
  rand uvm_reg_field uc_ln_ctrl_10;
  rand uvm_reg_field uc_ln_ctrl_11;
  rand uvm_reg_field uc_ln_ctrl_14_12;
  rand uvm_reg_field uc_ln_ctrl_31_15;
  
  covergroup wr_fld_covg;
    uc_ln_ctrl_0: coverpoint uc_ln_ctrl_0.value[0:0];
    uc_ln_ctrl_1: coverpoint uc_ln_ctrl_1.value[0:0];
    uc_ln_ctrl_2: coverpoint uc_ln_ctrl_2.value[0:0];
    uc_ln_ctrl_3: coverpoint uc_ln_ctrl_3.value[0:0];
    uc_ln_ctrl_4: coverpoint uc_ln_ctrl_4.value[0:0];
    uc_ln_ctrl_5: coverpoint uc_ln_ctrl_5.value[0:0];
    uc_ln_ctrl_6: coverpoint uc_ln_ctrl_6.value[0:0];
    uc_ln_ctrl_7: coverpoint uc_ln_ctrl_7.value[0:0];
    uc_ln_ctrl_8: coverpoint uc_ln_ctrl_8.value[0:0];
    uc_ln_ctrl_9: coverpoint uc_ln_ctrl_9.value[0:0];
    uc_ln_ctrl_10: coverpoint uc_ln_ctrl_10.value[0:0];
    uc_ln_ctrl_11: coverpoint uc_ln_ctrl_11.value[0:0];
    uc_ln_ctrl_14_12: coverpoint uc_ln_ctrl_14_12.value[2:0];
    uc_ln_ctrl_31_15: coverpoint uc_ln_ctrl_31_15.value[16:0];
  endgroup
  covergroup rd_fld_covg;
    uc_ln_ctrl_0: coverpoint uc_ln_ctrl_0.value[0:0];
    uc_ln_ctrl_1: coverpoint uc_ln_ctrl_1.value[0:0];
    uc_ln_ctrl_2: coverpoint uc_ln_ctrl_2.value[0:0];
    uc_ln_ctrl_3: coverpoint uc_ln_ctrl_3.value[0:0];
    uc_ln_ctrl_4: coverpoint uc_ln_ctrl_4.value[0:0];
    uc_ln_ctrl_5: coverpoint uc_ln_ctrl_5.value[0:0];
    uc_ln_ctrl_6: coverpoint uc_ln_ctrl_6.value[0:0];
    uc_ln_ctrl_7: coverpoint uc_ln_ctrl_7.value[0:0];
    uc_ln_ctrl_8: coverpoint uc_ln_ctrl_8.value[0:0];
    uc_ln_ctrl_9: coverpoint uc_ln_ctrl_9.value[0:0];
    uc_ln_ctrl_10: coverpoint uc_ln_ctrl_10.value[0:0];
    uc_ln_ctrl_11: coverpoint uc_ln_ctrl_11.value[0:0];
    uc_ln_ctrl_14_12: coverpoint uc_ln_ctrl_14_12.value[2:0];
    uc_ln_ctrl_31_15: coverpoint uc_ln_ctrl_31_15.value[16:0];
  endgroup

  protected virtual function void sample(uvm_reg_data_t data, uvm_reg_data_t byte_en, bit is_read, uvm_reg_map map);
    super.sample(data, byte_en, is_read, map);
    if (get_coverage(UVM_CVR_FIELD_VALS)) begin
      if(!is_read) begin
          wr_fld_covg.sample();
      end
      if(is_read) begin
         rd_fld_covg.sample();
      end
    end
  endfunction

  virtual function void sample_values();
    super.sample_values();
    if (get_coverage(UVM_CVR_FIELD_VALS)) begin
      wr_fld_covg.sample();
      rd_fld_covg.sample();
    end
  endfunction

  virtual function void build();
    uvm_reg_field fld_set[$];
    uvm_reg_field_config_ta ta = get_field_config(getconfigUID());
    build_uvm_reg_fields(this, ta, fld_set);
    
    uc_ln_ctrl_0 = fld_set[0];
    uc_ln_ctrl_1 = fld_set[1];
    uc_ln_ctrl_2 = fld_set[2];
    uc_ln_ctrl_3 = fld_set[3];
    uc_ln_ctrl_4 = fld_set[4];
    uc_ln_ctrl_5 = fld_set[5];
    uc_ln_ctrl_6 = fld_set[6];
    uc_ln_ctrl_7 = fld_set[7];
    uc_ln_ctrl_8 = fld_set[8];
    uc_ln_ctrl_9 = fld_set[9];
    uc_ln_ctrl_10 = fld_set[10];
    uc_ln_ctrl_11 = fld_set[11];
    uc_ln_ctrl_14_12 = fld_set[12];
    uc_ln_ctrl_31_15 = fld_set[13];
  endfunction

  function new(input string name="T_uc_ln_ctrl_215");
    super.new(name, 32, build_coverage(UVM_CVR_FIELD_VALS));
    if (has_coverage(UVM_CVR_FIELD_VALS)) begin
      wr_fld_covg = new();
      rd_fld_covg = new();
    end
  endfunction

endclass


/////////////////////////////////////////////////////
//                uc_ln_scrpad0
/////////////////////////////////////////////////////
class T_uc_ln_scrpad0_217 extends cdns_uvm_reg;

  `uvm_object_utils(T_uc_ln_scrpad0_217)
  rand uvm_reg_field uc_ln_scrpad0_31_0;
  
  covergroup wr_fld_covg;
    uc_ln_scrpad0_31_0: coverpoint uc_ln_scrpad0_31_0.value[31:0];
  endgroup
  covergroup rd_fld_covg;
    uc_ln_scrpad0_31_0: coverpoint uc_ln_scrpad0_31_0.value[31:0];
  endgroup

  protected virtual function void sample(uvm_reg_data_t data, uvm_reg_data_t byte_en, bit is_read, uvm_reg_map map);
    super.sample(data, byte_en, is_read, map);
    if (get_coverage(UVM_CVR_FIELD_VALS)) begin
      if(!is_read) begin
          wr_fld_covg.sample();
      end
      if(is_read) begin
         rd_fld_covg.sample();
      end
    end
  endfunction

  virtual function void sample_values();
    super.sample_values();
    if (get_coverage(UVM_CVR_FIELD_VALS)) begin
      wr_fld_covg.sample();
      rd_fld_covg.sample();
    end
  endfunction

  virtual function void build();
    uvm_reg_field fld_set[$];
    uvm_reg_field_config_ta ta = get_field_config(getconfigUID());
    build_uvm_reg_fields(this, ta, fld_set);
    
    uc_ln_scrpad0_31_0 = fld_set[0];
  endfunction

  function new(input string name="T_uc_ln_scrpad0_217");
    super.new(name, 32, build_coverage(UVM_CVR_FIELD_VALS));
    if (has_coverage(UVM_CVR_FIELD_VALS)) begin
      wr_fld_covg = new();
      rd_fld_covg = new();
    end
  endfunction

endclass


/////////////////////////////////////////////////////
//                uc_ln_scrpad1
/////////////////////////////////////////////////////
class T_uc_ln_scrpad1_218 extends cdns_uvm_reg;

  `uvm_object_utils(T_uc_ln_scrpad1_218)
  rand uvm_reg_field uc_ln_scrpad1_31_0;
  
  covergroup wr_fld_covg;
    uc_ln_scrpad1_31_0: coverpoint uc_ln_scrpad1_31_0.value[31:0];
  endgroup
  covergroup rd_fld_covg;
    uc_ln_scrpad1_31_0: coverpoint uc_ln_scrpad1_31_0.value[31:0];
  endgroup

  protected virtual function void sample(uvm_reg_data_t data, uvm_reg_data_t byte_en, bit is_read, uvm_reg_map map);
    super.sample(data, byte_en, is_read, map);
    if (get_coverage(UVM_CVR_FIELD_VALS)) begin
      if(!is_read) begin
          wr_fld_covg.sample();
      end
      if(is_read) begin
         rd_fld_covg.sample();
      end
    end
  endfunction

  virtual function void sample_values();
    super.sample_values();
    if (get_coverage(UVM_CVR_FIELD_VALS)) begin
      wr_fld_covg.sample();
      rd_fld_covg.sample();
    end
  endfunction

  virtual function void build();
    uvm_reg_field fld_set[$];
    uvm_reg_field_config_ta ta = get_field_config(getconfigUID());
    build_uvm_reg_fields(this, ta, fld_set);
    
    uc_ln_scrpad1_31_0 = fld_set[0];
  endfunction

  function new(input string name="T_uc_ln_scrpad1_218");
    super.new(name, 32, build_coverage(UVM_CVR_FIELD_VALS));
    if (has_coverage(UVM_CVR_FIELD_VALS)) begin
      wr_fld_covg = new();
      rd_fld_covg = new();
    end
  endfunction

endclass


/////////////////////////////////////////////////////
//                uc_ln_scrpad2
/////////////////////////////////////////////////////
class T_uc_ln_scrpad2_219 extends cdns_uvm_reg;

  `uvm_object_utils(T_uc_ln_scrpad2_219)
  rand uvm_reg_field uc_ln_scrpad2_31_0;
  
  covergroup wr_fld_covg;
    uc_ln_scrpad2_31_0: coverpoint uc_ln_scrpad2_31_0.value[31:0];
  endgroup
  covergroup rd_fld_covg;
    uc_ln_scrpad2_31_0: coverpoint uc_ln_scrpad2_31_0.value[31:0];
  endgroup

  protected virtual function void sample(uvm_reg_data_t data, uvm_reg_data_t byte_en, bit is_read, uvm_reg_map map);
    super.sample(data, byte_en, is_read, map);
    if (get_coverage(UVM_CVR_FIELD_VALS)) begin
      if(!is_read) begin
          wr_fld_covg.sample();
      end
      if(is_read) begin
         rd_fld_covg.sample();
      end
    end
  endfunction

  virtual function void sample_values();
    super.sample_values();
    if (get_coverage(UVM_CVR_FIELD_VALS)) begin
      wr_fld_covg.sample();
      rd_fld_covg.sample();
    end
  endfunction

  virtual function void build();
    uvm_reg_field fld_set[$];
    uvm_reg_field_config_ta ta = get_field_config(getconfigUID());
    build_uvm_reg_fields(this, ta, fld_set);
    
    uc_ln_scrpad2_31_0 = fld_set[0];
  endfunction

  function new(input string name="T_uc_ln_scrpad2_219");
    super.new(name, 32, build_coverage(UVM_CVR_FIELD_VALS));
    if (has_coverage(UVM_CVR_FIELD_VALS)) begin
      wr_fld_covg = new();
      rd_fld_covg = new();
    end
  endfunction

endclass


/////////////////////////////////////////////////////
//                uc_ln_scrpad3
/////////////////////////////////////////////////////
class T_uc_ln_scrpad3_220 extends cdns_uvm_reg;

  `uvm_object_utils(T_uc_ln_scrpad3_220)
  rand uvm_reg_field uc_ln_scrpad3_31_0;
  
  covergroup wr_fld_covg;
    uc_ln_scrpad3_31_0: coverpoint uc_ln_scrpad3_31_0.value[31:0];
  endgroup
  covergroup rd_fld_covg;
    uc_ln_scrpad3_31_0: coverpoint uc_ln_scrpad3_31_0.value[31:0];
  endgroup

  protected virtual function void sample(uvm_reg_data_t data, uvm_reg_data_t byte_en, bit is_read, uvm_reg_map map);
    super.sample(data, byte_en, is_read, map);
    if (get_coverage(UVM_CVR_FIELD_VALS)) begin
      if(!is_read) begin
          wr_fld_covg.sample();
      end
      if(is_read) begin
         rd_fld_covg.sample();
      end
    end
  endfunction

  virtual function void sample_values();
    super.sample_values();
    if (get_coverage(UVM_CVR_FIELD_VALS)) begin
      wr_fld_covg.sample();
      rd_fld_covg.sample();
    end
  endfunction

  virtual function void build();
    uvm_reg_field fld_set[$];
    uvm_reg_field_config_ta ta = get_field_config(getconfigUID());
    build_uvm_reg_fields(this, ta, fld_set);
    
    uc_ln_scrpad3_31_0 = fld_set[0];
  endfunction

  function new(input string name="T_uc_ln_scrpad3_220");
    super.new(name, 32, build_coverage(UVM_CVR_FIELD_VALS));
    if (has_coverage(UVM_CVR_FIELD_VALS)) begin
      wr_fld_covg = new();
      rd_fld_covg = new();
    end
  endfunction

endclass


/////////////////////////////////////////////////////
//                uc_ln_scrpad4
/////////////////////////////////////////////////////
class T_uc_ln_scrpad4_221 extends cdns_uvm_reg;

  `uvm_object_utils(T_uc_ln_scrpad4_221)
  rand uvm_reg_field uc_ln_scrpad4_31_0;
  
  covergroup wr_fld_covg;
    uc_ln_scrpad4_31_0: coverpoint uc_ln_scrpad4_31_0.value[31:0];
  endgroup
  covergroup rd_fld_covg;
    uc_ln_scrpad4_31_0: coverpoint uc_ln_scrpad4_31_0.value[31:0];
  endgroup

  protected virtual function void sample(uvm_reg_data_t data, uvm_reg_data_t byte_en, bit is_read, uvm_reg_map map);
    super.sample(data, byte_en, is_read, map);
    if (get_coverage(UVM_CVR_FIELD_VALS)) begin
      if(!is_read) begin
          wr_fld_covg.sample();
      end
      if(is_read) begin
         rd_fld_covg.sample();
      end
    end
  endfunction

  virtual function void sample_values();
    super.sample_values();
    if (get_coverage(UVM_CVR_FIELD_VALS)) begin
      wr_fld_covg.sample();
      rd_fld_covg.sample();
    end
  endfunction

  virtual function void build();
    uvm_reg_field fld_set[$];
    uvm_reg_field_config_ta ta = get_field_config(getconfigUID());
    build_uvm_reg_fields(this, ta, fld_set);
    
    uc_ln_scrpad4_31_0 = fld_set[0];
  endfunction

  function new(input string name="T_uc_ln_scrpad4_221");
    super.new(name, 32, build_coverage(UVM_CVR_FIELD_VALS));
    if (has_coverage(UVM_CVR_FIELD_VALS)) begin
      wr_fld_covg = new();
      rd_fld_covg = new();
    end
  endfunction

endclass


/////////////////////////////////////////////////////
//                uc_ln_scrpad5
/////////////////////////////////////////////////////
class T_uc_ln_scrpad5_222 extends cdns_uvm_reg;

  `uvm_object_utils(T_uc_ln_scrpad5_222)
  rand uvm_reg_field uc_ln_scrpad5_31_0;
  
  covergroup wr_fld_covg;
    uc_ln_scrpad5_31_0: coverpoint uc_ln_scrpad5_31_0.value[31:0];
  endgroup
  covergroup rd_fld_covg;
    uc_ln_scrpad5_31_0: coverpoint uc_ln_scrpad5_31_0.value[31:0];
  endgroup

  protected virtual function void sample(uvm_reg_data_t data, uvm_reg_data_t byte_en, bit is_read, uvm_reg_map map);
    super.sample(data, byte_en, is_read, map);
    if (get_coverage(UVM_CVR_FIELD_VALS)) begin
      if(!is_read) begin
          wr_fld_covg.sample();
      end
      if(is_read) begin
         rd_fld_covg.sample();
      end
    end
  endfunction

  virtual function void sample_values();
    super.sample_values();
    if (get_coverage(UVM_CVR_FIELD_VALS)) begin
      wr_fld_covg.sample();
      rd_fld_covg.sample();
    end
  endfunction

  virtual function void build();
    uvm_reg_field fld_set[$];
    uvm_reg_field_config_ta ta = get_field_config(getconfigUID());
    build_uvm_reg_fields(this, ta, fld_set);
    
    uc_ln_scrpad5_31_0 = fld_set[0];
  endfunction

  function new(input string name="T_uc_ln_scrpad5_222");
    super.new(name, 32, build_coverage(UVM_CVR_FIELD_VALS));
    if (has_coverage(UVM_CVR_FIELD_VALS)) begin
      wr_fld_covg = new();
      rd_fld_covg = new();
    end
  endfunction

endclass


/////////////////////////////////////////////////////
//                uc_ln_scrpad6
/////////////////////////////////////////////////////
class T_uc_ln_scrpad6_223 extends cdns_uvm_reg;

  `uvm_object_utils(T_uc_ln_scrpad6_223)
  rand uvm_reg_field uc_ln_scrpad6_31_0;
  
  covergroup wr_fld_covg;
    uc_ln_scrpad6_31_0: coverpoint uc_ln_scrpad6_31_0.value[31:0];
  endgroup
  covergroup rd_fld_covg;
    uc_ln_scrpad6_31_0: coverpoint uc_ln_scrpad6_31_0.value[31:0];
  endgroup

  protected virtual function void sample(uvm_reg_data_t data, uvm_reg_data_t byte_en, bit is_read, uvm_reg_map map);
    super.sample(data, byte_en, is_read, map);
    if (get_coverage(UVM_CVR_FIELD_VALS)) begin
      if(!is_read) begin
          wr_fld_covg.sample();
      end
      if(is_read) begin
         rd_fld_covg.sample();
      end
    end
  endfunction

  virtual function void sample_values();
    super.sample_values();
    if (get_coverage(UVM_CVR_FIELD_VALS)) begin
      wr_fld_covg.sample();
      rd_fld_covg.sample();
    end
  endfunction

  virtual function void build();
    uvm_reg_field fld_set[$];
    uvm_reg_field_config_ta ta = get_field_config(getconfigUID());
    build_uvm_reg_fields(this, ta, fld_set);
    
    uc_ln_scrpad6_31_0 = fld_set[0];
  endfunction

  function new(input string name="T_uc_ln_scrpad6_223");
    super.new(name, 32, build_coverage(UVM_CVR_FIELD_VALS));
    if (has_coverage(UVM_CVR_FIELD_VALS)) begin
      wr_fld_covg = new();
      rd_fld_covg = new();
    end
  endfunction

endclass


/////////////////////////////////////////////////////
//                uc_ln_scrpad7
/////////////////////////////////////////////////////
class T_uc_ln_scrpad7_224 extends cdns_uvm_reg;

  `uvm_object_utils(T_uc_ln_scrpad7_224)
  rand uvm_reg_field uc_ln_scrpad7_31_0;
  
  covergroup wr_fld_covg;
    uc_ln_scrpad7_31_0: coverpoint uc_ln_scrpad7_31_0.value[31:0];
  endgroup
  covergroup rd_fld_covg;
    uc_ln_scrpad7_31_0: coverpoint uc_ln_scrpad7_31_0.value[31:0];
  endgroup

  protected virtual function void sample(uvm_reg_data_t data, uvm_reg_data_t byte_en, bit is_read, uvm_reg_map map);
    super.sample(data, byte_en, is_read, map);
    if (get_coverage(UVM_CVR_FIELD_VALS)) begin
      if(!is_read) begin
          wr_fld_covg.sample();
      end
      if(is_read) begin
         rd_fld_covg.sample();
      end
    end
  endfunction

  virtual function void sample_values();
    super.sample_values();
    if (get_coverage(UVM_CVR_FIELD_VALS)) begin
      wr_fld_covg.sample();
      rd_fld_covg.sample();
    end
  endfunction

  virtual function void build();
    uvm_reg_field fld_set[$];
    uvm_reg_field_config_ta ta = get_field_config(getconfigUID());
    build_uvm_reg_fields(this, ta, fld_set);
    
    uc_ln_scrpad7_31_0 = fld_set[0];
  endfunction

  function new(input string name="T_uc_ln_scrpad7_224");
    super.new(name, 32, build_coverage(UVM_CVR_FIELD_VALS));
    if (has_coverage(UVM_CVR_FIELD_VALS)) begin
      wr_fld_covg = new();
      rd_fld_covg = new();
    end
  endfunction

endclass


/////////////////////////////////////////////////////
//                uc_ln_sram_access
/////////////////////////////////////////////////////
class T_uc_ln_sram_access_231 extends cdns_uvm_reg;

  `uvm_object_utils(T_uc_ln_sram_access_231)
  rand uvm_reg_field uc_ln_sram_access_31_0;
  
  covergroup wr_fld_covg;
    uc_ln_sram_access_31_0: coverpoint uc_ln_sram_access_31_0.value[31:0];
  endgroup
  covergroup rd_fld_covg;
    uc_ln_sram_access_31_0: coverpoint uc_ln_sram_access_31_0.value[31:0];
  endgroup

  protected virtual function void sample(uvm_reg_data_t data, uvm_reg_data_t byte_en, bit is_read, uvm_reg_map map);
    super.sample(data, byte_en, is_read, map);
    if (get_coverage(UVM_CVR_FIELD_VALS)) begin
      if(!is_read) begin
          wr_fld_covg.sample();
      end
      if(is_read) begin
         rd_fld_covg.sample();
      end
    end
  endfunction

  virtual function void sample_values();
    super.sample_values();
    if (get_coverage(UVM_CVR_FIELD_VALS)) begin
      wr_fld_covg.sample();
      rd_fld_covg.sample();
    end
  endfunction

  virtual function void build();
    uvm_reg_field fld_set[$];
    uvm_reg_field_config_ta ta = get_field_config(getconfigUID());
    build_uvm_reg_fields(this, ta, fld_set);
    
    uc_ln_sram_access_31_0 = fld_set[0];
  endfunction

  function new(input string name="T_uc_ln_sram_access_231");
    super.new(name, 32, build_coverage(UVM_CVR_FIELD_VALS));
    if (has_coverage(UVM_CVR_FIELD_VALS)) begin
      wr_fld_covg = new();
      rd_fld_covg = new();
    end
  endfunction

endclass


/////////////////////////////////////////////////////
//                uc_ln_sram_addr
/////////////////////////////////////////////////////
class T_uc_ln_sram_addr_216 extends cdns_uvm_reg;

  `uvm_object_utils(T_uc_ln_sram_addr_216)
  rand uvm_reg_field uc_ln_sram_addr_15_0;
  rand uvm_reg_field uc_ln_sram_addr_31_16;
  
  covergroup wr_fld_covg;
    uc_ln_sram_addr_15_0: coverpoint uc_ln_sram_addr_15_0.value[15:0];
    uc_ln_sram_addr_31_16: coverpoint uc_ln_sram_addr_31_16.value[15:0];
  endgroup
  covergroup rd_fld_covg;
    uc_ln_sram_addr_15_0: coverpoint uc_ln_sram_addr_15_0.value[15:0];
    uc_ln_sram_addr_31_16: coverpoint uc_ln_sram_addr_31_16.value[15:0];
  endgroup

  protected virtual function void sample(uvm_reg_data_t data, uvm_reg_data_t byte_en, bit is_read, uvm_reg_map map);
    super.sample(data, byte_en, is_read, map);
    if (get_coverage(UVM_CVR_FIELD_VALS)) begin
      if(!is_read) begin
          wr_fld_covg.sample();
      end
      if(is_read) begin
         rd_fld_covg.sample();
      end
    end
  endfunction

  virtual function void sample_values();
    super.sample_values();
    if (get_coverage(UVM_CVR_FIELD_VALS)) begin
      wr_fld_covg.sample();
      rd_fld_covg.sample();
    end
  endfunction

  virtual function void build();
    uvm_reg_field fld_set[$];
    uvm_reg_field_config_ta ta = get_field_config(getconfigUID());
    build_uvm_reg_fields(this, ta, fld_set);
    
    uc_ln_sram_addr_15_0 = fld_set[0];
    uc_ln_sram_addr_31_16 = fld_set[1];
  endfunction

  function new(input string name="T_uc_ln_sram_addr_216");
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
class T_sd3101_phy_registers_232 extends cdns_uvm_reg_block;

  `uvm_object_utils(T_sd3101_phy_registers_232)
  rand T_phy_dp_iso_tx_ctrl1_206 phy_dp_iso_tx_ctrl1;
  rand T_phy_dp_iso_tx_ctrl2_207 phy_dp_iso_tx_ctrl2;
  rand T_phy_ln_uc_pcs_en_int_sts1_213 phy_ln_uc_pcs_en_int_sts1;
  rand T_phy_ln_uc_pcs_en_int_sts2_229 phy_ln_uc_pcs_en_int_sts2;
  rand T_phy_ln_uc_pcs_int_sts1_en_211 phy_ln_uc_pcs_int_sts1_en;
  rand T_phy_ln_uc_pcs_int_sts2_en_227 phy_ln_uc_pcs_int_sts2_en;
  rand T_phy_pipe_inputs_192 phy_pipe_inputs;
  rand T_phy_pipe_iso_cfg_ctrl_200 phy_pipe_iso_cfg_ctrl;
  rand T_phy_pipe_iso_mb_mac2phy_202 phy_pipe_iso_mb_mac2phy;
  rand T_phy_pipe_iso_mb_phy2mac0_203 phy_pipe_iso_mb_phy2mac0;
  rand T_phy_pipe_iso_mb_phy2mac1_204 phy_pipe_iso_mb_phy2mac1;
  rand T_phy_pipe_iso_mb_phy2mac2_205 phy_pipe_iso_mb_phy2mac2;
  rand T_phy_pipe_iso_rx_eq_eval_198 phy_pipe_iso_rx_eq_eval;
  rand T_phy_pipe_iso_tx_lpc_195 phy_pipe_iso_tx_lpc;
  rand T_phy_pipe_ln_ctrl_sts_196 phy_pipe_ln_ctrl_sts;
  rand T_phy_pipe_ln_ctrl_sts_clr_197 phy_pipe_ln_ctrl_sts_clr;
  rand T_phy_pipe_mb_ctrl_sts_201 phy_pipe_mb_ctrl_sts;
  rand T_phy_pipe_tx_dmph_194 phy_pipe_tx_dmph;
  rand T_phy_top_uc_ln_en_int_sts1_214 phy_top_uc_ln_en_int_sts1;
  rand T_phy_top_uc_ln_en_int_sts2_230 phy_top_uc_ln_en_int_sts2;
  rand T_phy_top_uc_pcs_int_sts1_en_212 phy_top_uc_pcs_int_sts1_en;
  rand T_phy_top_uc_pcs_int_sts2_en_228 phy_top_uc_pcs_int_sts2_en;
  rand T_phy_uc_pcs_int_sts1_209 phy_uc_pcs_int_sts1;
  rand T_phy_uc_pcs_int_sts1_set_210 phy_uc_pcs_int_sts1_set;
  rand T_phy_uc_pcs_int_sts2_225 phy_uc_pcs_int_sts2;
  rand T_phy_uc_pcs_int_sts2_set_226 phy_uc_pcs_int_sts2_set;
  rand T_phy_usb3_iso_rx_ctrl_193 phy_usb3_iso_rx_ctrl;
  rand T_phy_usb3_iso_tx_data_199 phy_usb3_iso_tx_data;
  rand T_phy_usb3_iso_usb_ber_cnt_208 phy_usb3_iso_usb_ber_cnt;
  rand T_uc_ln_ctrl_215 uc_ln_ctrl;
  rand T_uc_ln_scrpad0_217 uc_ln_scrpad0;
  rand T_uc_ln_scrpad1_218 uc_ln_scrpad1;
  rand T_uc_ln_scrpad2_219 uc_ln_scrpad2;
  rand T_uc_ln_scrpad3_220 uc_ln_scrpad3;
  rand T_uc_ln_scrpad4_221 uc_ln_scrpad4;
  rand T_uc_ln_scrpad5_222 uc_ln_scrpad5;
  rand T_uc_ln_scrpad6_223 uc_ln_scrpad6;
  rand T_uc_ln_scrpad7_224 uc_ln_scrpad7;
  rand T_uc_ln_sram_access_231 uc_ln_sram_access;
  rand T_uc_ln_sram_addr_216 uc_ln_sram_addr;



  virtual function void build();
    uvm_reg  reg_set[$];
    string config_path = get_hier_path();
    default_map = create_map(get_name(), `UVM_REG_ADDR_WIDTH'h34000, 4, UVM_LITTLE_ENDIAN, 1);
    begin
       uvm_reg_config_ta ta = get_reg_config("phy_pcs_lane_registers.sd3101_t4_registers_sd3101_phy_registers");
       build_uvm_regs(default_map, this, null, ta, reg_set);
    end
    if(! $cast(phy_dp_iso_tx_ctrl1, reg_set[0]))
      `uvm_error("UVM_REG", "phy_dp_iso_tx_ctrl1 register casting error")
    if(! $cast(phy_dp_iso_tx_ctrl2, reg_set[1]))
      `uvm_error("UVM_REG", "phy_dp_iso_tx_ctrl2 register casting error")
    if(! $cast(phy_ln_uc_pcs_en_int_sts1, reg_set[2]))
      `uvm_error("UVM_REG", "phy_ln_uc_pcs_en_int_sts1 register casting error")
    if(! $cast(phy_ln_uc_pcs_en_int_sts2, reg_set[3]))
      `uvm_error("UVM_REG", "phy_ln_uc_pcs_en_int_sts2 register casting error")
    if(! $cast(phy_ln_uc_pcs_int_sts1_en, reg_set[4]))
      `uvm_error("UVM_REG", "phy_ln_uc_pcs_int_sts1_en register casting error")
    if(! $cast(phy_ln_uc_pcs_int_sts2_en, reg_set[5]))
      `uvm_error("UVM_REG", "phy_ln_uc_pcs_int_sts2_en register casting error")
    if(! $cast(phy_pipe_inputs, reg_set[6]))
      `uvm_error("UVM_REG", "phy_pipe_inputs register casting error")
    if(! $cast(phy_pipe_iso_cfg_ctrl, reg_set[7]))
      `uvm_error("UVM_REG", "phy_pipe_iso_cfg_ctrl register casting error")
    if(! $cast(phy_pipe_iso_mb_mac2phy, reg_set[8]))
      `uvm_error("UVM_REG", "phy_pipe_iso_mb_mac2phy register casting error")
    if(! $cast(phy_pipe_iso_mb_phy2mac0, reg_set[9]))
      `uvm_error("UVM_REG", "phy_pipe_iso_mb_phy2mac0 register casting error")
    if(! $cast(phy_pipe_iso_mb_phy2mac1, reg_set[10]))
      `uvm_error("UVM_REG", "phy_pipe_iso_mb_phy2mac1 register casting error")
    if(! $cast(phy_pipe_iso_mb_phy2mac2, reg_set[11]))
      `uvm_error("UVM_REG", "phy_pipe_iso_mb_phy2mac2 register casting error")
    if(! $cast(phy_pipe_iso_rx_eq_eval, reg_set[12]))
      `uvm_error("UVM_REG", "phy_pipe_iso_rx_eq_eval register casting error")
    if(! $cast(phy_pipe_iso_tx_lpc, reg_set[13]))
      `uvm_error("UVM_REG", "phy_pipe_iso_tx_lpc register casting error")
    if(! $cast(phy_pipe_ln_ctrl_sts, reg_set[14]))
      `uvm_error("UVM_REG", "phy_pipe_ln_ctrl_sts register casting error")
    if(! $cast(phy_pipe_ln_ctrl_sts_clr, reg_set[15]))
      `uvm_error("UVM_REG", "phy_pipe_ln_ctrl_sts_clr register casting error")
    if(! $cast(phy_pipe_mb_ctrl_sts, reg_set[16]))
      `uvm_error("UVM_REG", "phy_pipe_mb_ctrl_sts register casting error")
    if(! $cast(phy_pipe_tx_dmph, reg_set[17]))
      `uvm_error("UVM_REG", "phy_pipe_tx_dmph register casting error")
    if(! $cast(phy_top_uc_ln_en_int_sts1, reg_set[18]))
      `uvm_error("UVM_REG", "phy_top_uc_ln_en_int_sts1 register casting error")
    if(! $cast(phy_top_uc_ln_en_int_sts2, reg_set[19]))
      `uvm_error("UVM_REG", "phy_top_uc_ln_en_int_sts2 register casting error")
    if(! $cast(phy_top_uc_pcs_int_sts1_en, reg_set[20]))
      `uvm_error("UVM_REG", "phy_top_uc_pcs_int_sts1_en register casting error")
    if(! $cast(phy_top_uc_pcs_int_sts2_en, reg_set[21]))
      `uvm_error("UVM_REG", "phy_top_uc_pcs_int_sts2_en register casting error")
    if(! $cast(phy_uc_pcs_int_sts1, reg_set[22]))
      `uvm_error("UVM_REG", "phy_uc_pcs_int_sts1 register casting error")
    if(! $cast(phy_uc_pcs_int_sts1_set, reg_set[23]))
      `uvm_error("UVM_REG", "phy_uc_pcs_int_sts1_set register casting error")
    if(! $cast(phy_uc_pcs_int_sts2, reg_set[24]))
      `uvm_error("UVM_REG", "phy_uc_pcs_int_sts2 register casting error")
    if(! $cast(phy_uc_pcs_int_sts2_set, reg_set[25]))
      `uvm_error("UVM_REG", "phy_uc_pcs_int_sts2_set register casting error")
    if(! $cast(phy_usb3_iso_rx_ctrl, reg_set[26]))
      `uvm_error("UVM_REG", "phy_usb3_iso_rx_ctrl register casting error")
    if(! $cast(phy_usb3_iso_tx_data, reg_set[27]))
      `uvm_error("UVM_REG", "phy_usb3_iso_tx_data register casting error")
    if(! $cast(phy_usb3_iso_usb_ber_cnt, reg_set[28]))
      `uvm_error("UVM_REG", "phy_usb3_iso_usb_ber_cnt register casting error")
    if(! $cast(uc_ln_ctrl, reg_set[29]))
      `uvm_error("UVM_REG", "uc_ln_ctrl register casting error")
    if(! $cast(uc_ln_scrpad0, reg_set[30]))
      `uvm_error("UVM_REG", "uc_ln_scrpad0 register casting error")
    if(! $cast(uc_ln_scrpad1, reg_set[31]))
      `uvm_error("UVM_REG", "uc_ln_scrpad1 register casting error")
    if(! $cast(uc_ln_scrpad2, reg_set[32]))
      `uvm_error("UVM_REG", "uc_ln_scrpad2 register casting error")
    if(! $cast(uc_ln_scrpad3, reg_set[33]))
      `uvm_error("UVM_REG", "uc_ln_scrpad3 register casting error")
    if(! $cast(uc_ln_scrpad4, reg_set[34]))
      `uvm_error("UVM_REG", "uc_ln_scrpad4 register casting error")
    if(! $cast(uc_ln_scrpad5, reg_set[35]))
      `uvm_error("UVM_REG", "uc_ln_scrpad5 register casting error")
    if(! $cast(uc_ln_scrpad6, reg_set[36]))
      `uvm_error("UVM_REG", "uc_ln_scrpad6 register casting error")
    if(! $cast(uc_ln_scrpad7, reg_set[37]))
      `uvm_error("UVM_REG", "uc_ln_scrpad7 register casting error")
    if(! $cast(uc_ln_sram_access, reg_set[38]))
      `uvm_error("UVM_REG", "uc_ln_sram_access register casting error")
    if(! $cast(uc_ln_sram_addr, reg_set[39]))
      `uvm_error("UVM_REG", "uc_ln_sram_addr register casting error")

  endfunction

  function new(input string name="sd3101_t4_registers_sd3101_phy_registers");
    super.new(name, UVM_NO_COVERAGE);
  endfunction

endclass


/////////////////////////////////////////////////////
//                phy_pcs_lane_registers
/////////////////////////////////////////////////////
class phy_pcs_lane_registers_vendor_cadence_library_cdns_lib_version_1685_2009 extends cdns_uvm_reg_block;

  `uvm_object_utils(phy_pcs_lane_registers_vendor_cadence_library_cdns_lib_version_1685_2009)

  uvm_reg_map default_map;
  uvm_reg_map sd3101_t4_registers;
  rand T_sd3101_phy_registers_232 sd3101_t4_registers_sd3101_phy_registers;

`include "cdn_regmodel_task_member.sv"
  virtual function void build();
    sd3101_t4_registers = create_map("sd3101_t4_registers", `UVM_REG_ADDR_WIDTH'h0, 4, UVM_LITTLE_ENDIAN, 1);
    default_map = sd3101_t4_registers;
    sd3101_t4_registers_sd3101_phy_registers = T_sd3101_phy_registers_232::type_id::create("sd3101_t4_registers_sd3101_phy_registers", , get_full_name());
    sd3101_t4_registers_sd3101_phy_registers.configure(this);
    sd3101_t4_registers_sd3101_phy_registers.build();

    //Mapping sd3101_t4_registers map
    sd3101_t4_registers_sd3101_phy_registers.default_map.add_parent_map(sd3101_t4_registers,`UVM_REG_ADDR_WIDTH'h34000);
    sd3101_t4_registers.set_submap_offset(sd3101_t4_registers_sd3101_phy_registers.default_map, `UVM_REG_ADDR_WIDTH'h34000);
    //Apply hdl_paths
    apply_hdl_paths(this);

  endfunction



  function new(input string name="phy_pcs_lane_registers");
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
         "T_phy_dp_iso_tx_ctrl1_206": begin T_phy_dp_iso_tx_ctrl1_206 phy_dp_iso_tx_ctrl1 = new(objectname); create = phy_dp_iso_tx_ctrl1;  end
         "T_phy_dp_iso_tx_ctrl2_207": begin T_phy_dp_iso_tx_ctrl2_207 phy_dp_iso_tx_ctrl2 = new(objectname); create = phy_dp_iso_tx_ctrl2;  end
         "T_phy_ln_uc_pcs_en_int_sts1_213": begin T_phy_ln_uc_pcs_en_int_sts1_213 phy_ln_uc_pcs_en_int_sts1 = new(objectname); create = phy_ln_uc_pcs_en_int_sts1;  end
         "T_phy_ln_uc_pcs_en_int_sts2_229": begin T_phy_ln_uc_pcs_en_int_sts2_229 phy_ln_uc_pcs_en_int_sts2 = new(objectname); create = phy_ln_uc_pcs_en_int_sts2;  end
         "T_phy_ln_uc_pcs_int_sts1_en_211": begin T_phy_ln_uc_pcs_int_sts1_en_211 phy_ln_uc_pcs_int_sts1_en = new(objectname); create = phy_ln_uc_pcs_int_sts1_en;  end
         "T_phy_ln_uc_pcs_int_sts2_en_227": begin T_phy_ln_uc_pcs_int_sts2_en_227 phy_ln_uc_pcs_int_sts2_en = new(objectname); create = phy_ln_uc_pcs_int_sts2_en;  end
         "T_phy_pipe_inputs_192": begin T_phy_pipe_inputs_192 phy_pipe_inputs = new(objectname); create = phy_pipe_inputs;  end
         "T_phy_pipe_iso_cfg_ctrl_200": begin T_phy_pipe_iso_cfg_ctrl_200 phy_pipe_iso_cfg_ctrl = new(objectname); create = phy_pipe_iso_cfg_ctrl;  end
         "T_phy_pipe_iso_mb_mac2phy_202": begin T_phy_pipe_iso_mb_mac2phy_202 phy_pipe_iso_mb_mac2phy = new(objectname); create = phy_pipe_iso_mb_mac2phy;  end
         "T_phy_pipe_iso_mb_phy2mac0_203": begin T_phy_pipe_iso_mb_phy2mac0_203 phy_pipe_iso_mb_phy2mac0 = new(objectname); create = phy_pipe_iso_mb_phy2mac0;  end
         "T_phy_pipe_iso_mb_phy2mac1_204": begin T_phy_pipe_iso_mb_phy2mac1_204 phy_pipe_iso_mb_phy2mac1 = new(objectname); create = phy_pipe_iso_mb_phy2mac1;  end
         "T_phy_pipe_iso_mb_phy2mac2_205": begin T_phy_pipe_iso_mb_phy2mac2_205 phy_pipe_iso_mb_phy2mac2 = new(objectname); create = phy_pipe_iso_mb_phy2mac2;  end
         "T_phy_pipe_iso_rx_eq_eval_198": begin T_phy_pipe_iso_rx_eq_eval_198 phy_pipe_iso_rx_eq_eval = new(objectname); create = phy_pipe_iso_rx_eq_eval;  end
         "T_phy_pipe_iso_tx_lpc_195": begin T_phy_pipe_iso_tx_lpc_195 phy_pipe_iso_tx_lpc = new(objectname); create = phy_pipe_iso_tx_lpc;  end
         "T_phy_pipe_ln_ctrl_sts_196": begin T_phy_pipe_ln_ctrl_sts_196 phy_pipe_ln_ctrl_sts = new(objectname); create = phy_pipe_ln_ctrl_sts;  end
         "T_phy_pipe_ln_ctrl_sts_clr_197": begin T_phy_pipe_ln_ctrl_sts_clr_197 phy_pipe_ln_ctrl_sts_clr = new(objectname); create = phy_pipe_ln_ctrl_sts_clr;  end
         "T_phy_pipe_mb_ctrl_sts_201": begin T_phy_pipe_mb_ctrl_sts_201 phy_pipe_mb_ctrl_sts = new(objectname); create = phy_pipe_mb_ctrl_sts;  end
         "T_phy_pipe_tx_dmph_194": begin T_phy_pipe_tx_dmph_194 phy_pipe_tx_dmph = new(objectname); create = phy_pipe_tx_dmph;  end
         "T_phy_top_uc_ln_en_int_sts1_214": begin T_phy_top_uc_ln_en_int_sts1_214 phy_top_uc_ln_en_int_sts1 = new(objectname); create = phy_top_uc_ln_en_int_sts1;  end
         "T_phy_top_uc_ln_en_int_sts2_230": begin T_phy_top_uc_ln_en_int_sts2_230 phy_top_uc_ln_en_int_sts2 = new(objectname); create = phy_top_uc_ln_en_int_sts2;  end
         "T_phy_top_uc_pcs_int_sts1_en_212": begin T_phy_top_uc_pcs_int_sts1_en_212 phy_top_uc_pcs_int_sts1_en = new(objectname); create = phy_top_uc_pcs_int_sts1_en;  end
         "T_phy_top_uc_pcs_int_sts2_en_228": begin T_phy_top_uc_pcs_int_sts2_en_228 phy_top_uc_pcs_int_sts2_en = new(objectname); create = phy_top_uc_pcs_int_sts2_en;  end
         "T_phy_uc_pcs_int_sts1_209": begin T_phy_uc_pcs_int_sts1_209 phy_uc_pcs_int_sts1 = new(objectname); create = phy_uc_pcs_int_sts1;  end
         "T_phy_uc_pcs_int_sts1_set_210": begin T_phy_uc_pcs_int_sts1_set_210 phy_uc_pcs_int_sts1_set = new(objectname); create = phy_uc_pcs_int_sts1_set;  end
         "T_phy_uc_pcs_int_sts2_225": begin T_phy_uc_pcs_int_sts2_225 phy_uc_pcs_int_sts2 = new(objectname); create = phy_uc_pcs_int_sts2;  end
         "T_phy_uc_pcs_int_sts2_set_226": begin T_phy_uc_pcs_int_sts2_set_226 phy_uc_pcs_int_sts2_set = new(objectname); create = phy_uc_pcs_int_sts2_set;  end
         "T_phy_usb3_iso_rx_ctrl_193": begin T_phy_usb3_iso_rx_ctrl_193 phy_usb3_iso_rx_ctrl = new(objectname); create = phy_usb3_iso_rx_ctrl;  end
         "T_phy_usb3_iso_tx_data_199": begin T_phy_usb3_iso_tx_data_199 phy_usb3_iso_tx_data = new(objectname); create = phy_usb3_iso_tx_data;  end
         "T_phy_usb3_iso_usb_ber_cnt_208": begin T_phy_usb3_iso_usb_ber_cnt_208 phy_usb3_iso_usb_ber_cnt = new(objectname); create = phy_usb3_iso_usb_ber_cnt;  end
         "T_uc_ln_ctrl_215": begin T_uc_ln_ctrl_215 uc_ln_ctrl = new(objectname); create = uc_ln_ctrl;  end
         "T_uc_ln_scrpad0_217": begin T_uc_ln_scrpad0_217 uc_ln_scrpad0 = new(objectname); create = uc_ln_scrpad0;  end
         "T_uc_ln_scrpad1_218": begin T_uc_ln_scrpad1_218 uc_ln_scrpad1 = new(objectname); create = uc_ln_scrpad1;  end
         "T_uc_ln_scrpad2_219": begin T_uc_ln_scrpad2_219 uc_ln_scrpad2 = new(objectname); create = uc_ln_scrpad2;  end
         "T_uc_ln_scrpad3_220": begin T_uc_ln_scrpad3_220 uc_ln_scrpad3 = new(objectname); create = uc_ln_scrpad3;  end
         "T_uc_ln_scrpad4_221": begin T_uc_ln_scrpad4_221 uc_ln_scrpad4 = new(objectname); create = uc_ln_scrpad4;  end
         "T_uc_ln_scrpad5_222": begin T_uc_ln_scrpad5_222 uc_ln_scrpad5 = new(objectname); create = uc_ln_scrpad5;  end
         "T_uc_ln_scrpad6_223": begin T_uc_ln_scrpad6_223 uc_ln_scrpad6 = new(objectname); create = uc_ln_scrpad6;  end
         "T_uc_ln_scrpad7_224": begin T_uc_ln_scrpad7_224 uc_ln_scrpad7 = new(objectname); create = uc_ln_scrpad7;  end
         "T_uc_ln_sram_access_231": begin T_uc_ln_sram_access_231 uc_ln_sram_access = new(objectname); create = uc_ln_sram_access;  end
         "T_uc_ln_sram_addr_216": begin T_uc_ln_sram_addr_216 uc_ln_sram_addr = new(objectname); create = uc_ln_sram_addr;  end

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
   cdns_uvmreg_utils_pkg_phy_pcs_lane_registers::factory=cdns_factory;


   return cdns_factory;
endfunction
cdns_factory_base cdns_factory = get_factory(no_factory);

endpackage



