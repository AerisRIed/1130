//*************************************************************//
//   ** File Generated Automatically
//   ** Please donot edit manually
//*************************************************************//


package cdn_phy_pma_lane_reg_pkg;
  import uvm_pkg::*;
  `include "uvm_macros.svh"
  import cdns_uvmreg_utils_pkg_phy_pma_lane_registers::*;

  bit no_factory = 0; 

/////////////////////////////////////////////////////
//                phy_ln_uc_event_ctr
/////////////////////////////////////////////////////
class T_phy_ln_uc_event_ctr_151 extends cdns_uvm_reg;

  `uvm_object_utils(T_phy_ln_uc_event_ctr_151)
  rand uvm_reg_field phy_ln_uc_event_ctr_15_0;
  rand uvm_reg_field phy_ln_uc_event_ctr_31_16;
  
  covergroup wr_fld_covg;
    phy_ln_uc_event_ctr_15_0: coverpoint phy_ln_uc_event_ctr_15_0.value[15:0];
    phy_ln_uc_event_ctr_31_16: coverpoint phy_ln_uc_event_ctr_31_16.value[15:0];
  endgroup
  covergroup rd_fld_covg;
    phy_ln_uc_event_ctr_15_0: coverpoint phy_ln_uc_event_ctr_15_0.value[15:0];
    phy_ln_uc_event_ctr_31_16: coverpoint phy_ln_uc_event_ctr_31_16.value[15:0];
  endgroup

  protected virtual function void sample(uvm_reg_data_t data, uvm_reg_data_t byte_en, bit is_read, uvm_reg_map map);
    super.sample(data, byte_en, is_read, map);
    if (get_coverage(UVM_CVR_FIELD_VALS)) begin
      if(!is_read) begin
          wr_fld_covg.sample();
      end
      if(is_read) begin
         rd_fld_covg.sample();
      end
    end
  endfunction

  virtual function void sample_values();
    super.sample_values();
    if (get_coverage(UVM_CVR_FIELD_VALS)) begin
      wr_fld_covg.sample();
      rd_fld_covg.sample();
    end
  endfunction

  virtual function void build();
    uvm_reg_field fld_set[$];
    uvm_reg_field_config_ta ta = get_field_config(getconfigUID());
    build_uvm_reg_fields(this, ta, fld_set);
    
    phy_ln_uc_event_ctr_15_0 = fld_set[0];
    phy_ln_uc_event_ctr_31_16 = fld_set[1];
  endfunction

  function new(input string name="T_phy_ln_uc_event_ctr_151");
    super.new(name, 32, build_coverage(UVM_CVR_FIELD_VALS));
    if (has_coverage(UVM_CVR_FIELD_VALS)) begin
      wr_fld_covg = new();
      rd_fld_covg = new();
    end
  endfunction

endclass


/////////////////////////////////////////////////////
//                phy_ln_uc_pma_en_int_sts1
/////////////////////////////////////////////////////
class T_phy_ln_uc_pma_en_int_sts1_171 extends cdns_uvm_reg;

  `uvm_object_utils(T_phy_ln_uc_pma_en_int_sts1_171)
  rand uvm_reg_field phy_ln_uc_pma_en_int_sts1_31_0;
  
  covergroup wr_fld_covg;
    phy_ln_uc_pma_en_int_sts1_31_0: coverpoint phy_ln_uc_pma_en_int_sts1_31_0.value[31:0];
  endgroup
  covergroup rd_fld_covg;
    phy_ln_uc_pma_en_int_sts1_31_0: coverpoint phy_ln_uc_pma_en_int_sts1_31_0.value[31:0];
  endgroup

  protected virtual function void sample(uvm_reg_data_t data, uvm_reg_data_t byte_en, bit is_read, uvm_reg_map map);
    super.sample(data, byte_en, is_read, map);
    if (get_coverage(UVM_CVR_FIELD_VALS)) begin
      if(!is_read) begin
          wr_fld_covg.sample();
      end
      if(is_read) begin
         rd_fld_covg.sample();
      end
    end
  endfunction

  virtual function void sample_values();
    super.sample_values();
    if (get_coverage(UVM_CVR_FIELD_VALS)) begin
      wr_fld_covg.sample();
      rd_fld_covg.sample();
    end
  endfunction

  virtual function void build();
    uvm_reg_field fld_set[$];
    uvm_reg_field_config_ta ta = get_field_config(getconfigUID());
    build_uvm_reg_fields(this, ta, fld_set);
    
    phy_ln_uc_pma_en_int_sts1_31_0 = fld_set[0];
  endfunction

  function new(input string name="T_phy_ln_uc_pma_en_int_sts1_171");
    super.new(name, 32, build_coverage(UVM_CVR_FIELD_VALS));
    if (has_coverage(UVM_CVR_FIELD_VALS)) begin
      wr_fld_covg = new();
      rd_fld_covg = new();
    end
  endfunction

endclass


/////////////////////////////////////////////////////
//                phy_ln_uc_pma_en_int_sts2
/////////////////////////////////////////////////////
class T_phy_ln_uc_pma_en_int_sts2_173 extends cdns_uvm_reg;

  `uvm_object_utils(T_phy_ln_uc_pma_en_int_sts2_173)
  rand uvm_reg_field phy_ln_uc_pma_en_int_sts2_31_0;
  
  covergroup wr_fld_covg;
    phy_ln_uc_pma_en_int_sts2_31_0: coverpoint phy_ln_uc_pma_en_int_sts2_31_0.value[31:0];
  endgroup
  covergroup rd_fld_covg;
    phy_ln_uc_pma_en_int_sts2_31_0: coverpoint phy_ln_uc_pma_en_int_sts2_31_0.value[31:0];
  endgroup

  protected virtual function void sample(uvm_reg_data_t data, uvm_reg_data_t byte_en, bit is_read, uvm_reg_map map);
    super.sample(data, byte_en, is_read, map);
    if (get_coverage(UVM_CVR_FIELD_VALS)) begin
      if(!is_read) begin
          wr_fld_covg.sample();
      end
      if(is_read) begin
         rd_fld_covg.sample();
      end
    end
  endfunction

  virtual function void sample_values();
    super.sample_values();
    if (get_coverage(UVM_CVR_FIELD_VALS)) begin
      wr_fld_covg.sample();
      rd_fld_covg.sample();
    end
  endfunction

  virtual function void build();
    uvm_reg_field fld_set[$];
    uvm_reg_field_config_ta ta = get_field_config(getconfigUID());
    build_uvm_reg_fields(this, ta, fld_set);
    
    phy_ln_uc_pma_en_int_sts2_31_0 = fld_set[0];
  endfunction

  function new(input string name="T_phy_ln_uc_pma_en_int_sts2_173");
    super.new(name, 32, build_coverage(UVM_CVR_FIELD_VALS));
    if (has_coverage(UVM_CVR_FIELD_VALS)) begin
      wr_fld_covg = new();
      rd_fld_covg = new();
    end
  endfunction

endclass


/////////////////////////////////////////////////////
//                phy_ln_uc_pma_int_sts1_en
/////////////////////////////////////////////////////
class T_phy_ln_uc_pma_int_sts1_en_167 extends cdns_uvm_reg;

  `uvm_object_utils(T_phy_ln_uc_pma_int_sts1_en_167)
  rand uvm_reg_field phy_ln_uc_pma_int_sts1_en_31_0;
  
  covergroup wr_fld_covg;
    phy_ln_uc_pma_int_sts1_en_31_0: coverpoint phy_ln_uc_pma_int_sts1_en_31_0.value[31:0];
  endgroup
  covergroup rd_fld_covg;
    phy_ln_uc_pma_int_sts1_en_31_0: coverpoint phy_ln_uc_pma_int_sts1_en_31_0.value[31:0];
  endgroup

  protected virtual function void sample(uvm_reg_data_t data, uvm_reg_data_t byte_en, bit is_read, uvm_reg_map map);
    super.sample(data, byte_en, is_read, map);
    if (get_coverage(UVM_CVR_FIELD_VALS)) begin
      if(!is_read) begin
          wr_fld_covg.sample();
      end
      if(is_read) begin
         rd_fld_covg.sample();
      end
    end
  endfunction

  virtual function void sample_values();
    super.sample_values();
    if (get_coverage(UVM_CVR_FIELD_VALS)) begin
      wr_fld_covg.sample();
      rd_fld_covg.sample();
    end
  endfunction

  virtual function void build();
    uvm_reg_field fld_set[$];
    uvm_reg_field_config_ta ta = get_field_config(getconfigUID());
    build_uvm_reg_fields(this, ta, fld_set);
    
    phy_ln_uc_pma_int_sts1_en_31_0 = fld_set[0];
  endfunction

  function new(input string name="T_phy_ln_uc_pma_int_sts1_en_167");
    super.new(name, 32, build_coverage(UVM_CVR_FIELD_VALS));
    if (has_coverage(UVM_CVR_FIELD_VALS)) begin
      wr_fld_covg = new();
      rd_fld_covg = new();
    end
  endfunction

endclass


/////////////////////////////////////////////////////
//                phy_pma_iso_lane_mode
/////////////////////////////////////////////////////
class T_phy_pma_iso_lane_mode_160 extends cdns_uvm_reg;

  `uvm_object_utils(T_phy_pma_iso_lane_mode_160)
  rand uvm_reg_field phy_pma_iso_lane_mode_5_0;
  rand uvm_reg_field phy_pma_iso_lane_mode_7_6;
  rand uvm_reg_field phy_pma_iso_lane_mode_13_8;
  rand uvm_reg_field phy_pma_iso_lane_mode_14;
  rand uvm_reg_field phy_pma_iso_lane_mode_15;
  rand uvm_reg_field phy_pma_iso_lane_mode_18_16;
  rand uvm_reg_field phy_pma_iso_lane_mode_19;
  rand uvm_reg_field phy_pma_iso_lane_mode_22_20;
  rand uvm_reg_field phy_pma_iso_lane_mode_31_23;
  
  covergroup wr_fld_covg;
    phy_pma_iso_lane_mode_5_0: coverpoint phy_pma_iso_lane_mode_5_0.value[5:0];
    phy_pma_iso_lane_mode_7_6: coverpoint phy_pma_iso_lane_mode_7_6.value[1:0];
    phy_pma_iso_lane_mode_13_8: coverpoint phy_pma_iso_lane_mode_13_8.value[5:0];
    phy_pma_iso_lane_mode_14: coverpoint phy_pma_iso_lane_mode_14.value[0:0];
    phy_pma_iso_lane_mode_15: coverpoint phy_pma_iso_lane_mode_15.value[0:0];
    phy_pma_iso_lane_mode_18_16: coverpoint phy_pma_iso_lane_mode_18_16.value[2:0];
    phy_pma_iso_lane_mode_19: coverpoint phy_pma_iso_lane_mode_19.value[0:0];
    phy_pma_iso_lane_mode_22_20: coverpoint phy_pma_iso_lane_mode_22_20.value[2:0];
    phy_pma_iso_lane_mode_31_23: coverpoint phy_pma_iso_lane_mode_31_23.value[8:0];
  endgroup
  covergroup rd_fld_covg;
    phy_pma_iso_lane_mode_5_0: coverpoint phy_pma_iso_lane_mode_5_0.value[5:0];
    phy_pma_iso_lane_mode_7_6: coverpoint phy_pma_iso_lane_mode_7_6.value[1:0];
    phy_pma_iso_lane_mode_13_8: coverpoint phy_pma_iso_lane_mode_13_8.value[5:0];
    phy_pma_iso_lane_mode_14: coverpoint phy_pma_iso_lane_mode_14.value[0:0];
    phy_pma_iso_lane_mode_15: coverpoint phy_pma_iso_lane_mode_15.value[0:0];
    phy_pma_iso_lane_mode_18_16: coverpoint phy_pma_iso_lane_mode_18_16.value[2:0];
    phy_pma_iso_lane_mode_19: coverpoint phy_pma_iso_lane_mode_19.value[0:0];
    phy_pma_iso_lane_mode_22_20: coverpoint phy_pma_iso_lane_mode_22_20.value[2:0];
    phy_pma_iso_lane_mode_31_23: coverpoint phy_pma_iso_lane_mode_31_23.value[8:0];
  endgroup

  protected virtual function void sample(uvm_reg_data_t data, uvm_reg_data_t byte_en, bit is_read, uvm_reg_map map);
    super.sample(data, byte_en, is_read, map);
    if (get_coverage(UVM_CVR_FIELD_VALS)) begin
      if(!is_read) begin
          wr_fld_covg.sample();
      end
      if(is_read) begin
         rd_fld_covg.sample();
      end
    end
  endfunction

  virtual function void sample_values();
    super.sample_values();
    if (get_coverage(UVM_CVR_FIELD_VALS)) begin
      wr_fld_covg.sample();
      rd_fld_covg.sample();
    end
  endfunction

  virtual function void build();
    uvm_reg_field fld_set[$];
    uvm_reg_field_config_ta ta = get_field_config(getconfigUID());
    build_uvm_reg_fields(this, ta, fld_set);
    
    phy_pma_iso_lane_mode_5_0 = fld_set[0];
    phy_pma_iso_lane_mode_7_6 = fld_set[1];
    phy_pma_iso_lane_mode_13_8 = fld_set[2];
    phy_pma_iso_lane_mode_14 = fld_set[3];
    phy_pma_iso_lane_mode_15 = fld_set[4];
    phy_pma_iso_lane_mode_18_16 = fld_set[5];
    phy_pma_iso_lane_mode_19 = fld_set[6];
    phy_pma_iso_lane_mode_22_20 = fld_set[7];
    phy_pma_iso_lane_mode_31_23 = fld_set[8];
  endfunction

  function new(input string name="T_phy_pma_iso_lane_mode_160");
    super.new(name, 32, build_coverage(UVM_CVR_FIELD_VALS));
    if (has_coverage(UVM_CVR_FIELD_VALS)) begin
      wr_fld_covg = new();
      rd_fld_covg = new();
    end
  endfunction

endclass


/////////////////////////////////////////////////////
//                phy_pma_iso_rx_data
/////////////////////////////////////////////////////
class T_phy_pma_iso_rx_data_161 extends cdns_uvm_reg;

  `uvm_object_utils(T_phy_pma_iso_rx_data_161)
  rand uvm_reg_field phy_pma_iso_rx_data_31_0;
  
  covergroup wr_fld_covg;
    phy_pma_iso_rx_data_31_0: coverpoint phy_pma_iso_rx_data_31_0.value[31:0];
  endgroup
  covergroup rd_fld_covg;
    phy_pma_iso_rx_data_31_0: coverpoint phy_pma_iso_rx_data_31_0.value[31:0];
  endgroup

  protected virtual function void sample(uvm_reg_data_t data, uvm_reg_data_t byte_en, bit is_read, uvm_reg_map map);
    super.sample(data, byte_en, is_read, map);
    if (get_coverage(UVM_CVR_FIELD_VALS)) begin
      if(!is_read) begin
          wr_fld_covg.sample();
      end
      if(is_read) begin
         rd_fld_covg.sample();
      end
    end
  endfunction

  virtual function void sample_values();
    super.sample_values();
    if (get_coverage(UVM_CVR_FIELD_VALS)) begin
      wr_fld_covg.sample();
      rd_fld_covg.sample();
    end
  endfunction

  virtual function void build();
    uvm_reg_field fld_set[$];
    uvm_reg_field_config_ta ta = get_field_config(getconfigUID());
    build_uvm_reg_fields(this, ta, fld_set);
    
    phy_pma_iso_rx_data_31_0 = fld_set[0];
  endfunction

  function new(input string name="T_phy_pma_iso_rx_data_161");
    super.new(name, 32, build_coverage(UVM_CVR_FIELD_VALS));
    if (has_coverage(UVM_CVR_FIELD_VALS)) begin
      wr_fld_covg = new();
      rd_fld_covg = new();
    end
  endfunction

endclass


/////////////////////////////////////////////////////
//                phy_pma_iso_tx_data
/////////////////////////////////////////////////////
class T_phy_pma_iso_tx_data_159 extends cdns_uvm_reg;

  `uvm_object_utils(T_phy_pma_iso_tx_data_159)
  rand uvm_reg_field phy_pma_iso_tx_data_31_0;
  
  covergroup wr_fld_covg;
    phy_pma_iso_tx_data_31_0: coverpoint phy_pma_iso_tx_data_31_0.value[31:0];
  endgroup
  covergroup rd_fld_covg;
    phy_pma_iso_tx_data_31_0: coverpoint phy_pma_iso_tx_data_31_0.value[31:0];
  endgroup

  protected virtual function void sample(uvm_reg_data_t data, uvm_reg_data_t byte_en, bit is_read, uvm_reg_map map);
    super.sample(data, byte_en, is_read, map);
    if (get_coverage(UVM_CVR_FIELD_VALS)) begin
      if(!is_read) begin
          wr_fld_covg.sample();
      end
      if(is_read) begin
         rd_fld_covg.sample();
      end
    end
  endfunction

  virtual function void sample_values();
    super.sample_values();
    if (get_coverage(UVM_CVR_FIELD_VALS)) begin
      wr_fld_covg.sample();
      rd_fld_covg.sample();
    end
  endfunction

  virtual function void build();
    uvm_reg_field fld_set[$];
    uvm_reg_field_config_ta ta = get_field_config(getconfigUID());
    build_uvm_reg_fields(this, ta, fld_set);
    
    phy_pma_iso_tx_data_31_0 = fld_set[0];
  endfunction

  function new(input string name="T_phy_pma_iso_tx_data_159");
    super.new(name, 32, build_coverage(UVM_CVR_FIELD_VALS));
    if (has_coverage(UVM_CVR_FIELD_VALS)) begin
      wr_fld_covg = new();
      rd_fld_covg = new();
    end
  endfunction

endclass


/////////////////////////////////////////////////////
//                phy_pma_iso_tx_deemph
/////////////////////////////////////////////////////
class T_phy_pma_iso_tx_deemph_157 extends cdns_uvm_reg;

  `uvm_object_utils(T_phy_pma_iso_tx_deemph_157)
  rand uvm_reg_field phy_pma_iso_tx_deemph_17_0;
  rand uvm_reg_field phy_pma_iso_tx_deemph_31_18;
  
  covergroup wr_fld_covg;
    phy_pma_iso_tx_deemph_17_0: coverpoint phy_pma_iso_tx_deemph_17_0.value[17:0];
    phy_pma_iso_tx_deemph_31_18: coverpoint phy_pma_iso_tx_deemph_31_18.value[13:0];
  endgroup
  covergroup rd_fld_covg;
    phy_pma_iso_tx_deemph_17_0: coverpoint phy_pma_iso_tx_deemph_17_0.value[17:0];
    phy_pma_iso_tx_deemph_31_18: coverpoint phy_pma_iso_tx_deemph_31_18.value[13:0];
  endgroup

  protected virtual function void sample(uvm_reg_data_t data, uvm_reg_data_t byte_en, bit is_read, uvm_reg_map map);
    super.sample(data, byte_en, is_read, map);
    if (get_coverage(UVM_CVR_FIELD_VALS)) begin
      if(!is_read) begin
          wr_fld_covg.sample();
      end
      if(is_read) begin
         rd_fld_covg.sample();
      end
    end
  endfunction

  virtual function void sample_values();
    super.sample_values();
    if (get_coverage(UVM_CVR_FIELD_VALS)) begin
      wr_fld_covg.sample();
      rd_fld_covg.sample();
    end
  endfunction

  virtual function void build();
    uvm_reg_field fld_set[$];
    uvm_reg_field_config_ta ta = get_field_config(getconfigUID());
    build_uvm_reg_fields(this, ta, fld_set);
    
    phy_pma_iso_tx_deemph_17_0 = fld_set[0];
    phy_pma_iso_tx_deemph_31_18 = fld_set[1];
  endfunction

  function new(input string name="T_phy_pma_iso_tx_deemph_157");
    super.new(name, 32, build_coverage(UVM_CVR_FIELD_VALS));
    if (has_coverage(UVM_CVR_FIELD_VALS)) begin
      wr_fld_covg = new();
      rd_fld_covg = new();
    end
  endfunction

endclass


/////////////////////////////////////////////////////
//                phy_pma_iso_tx_lpc
/////////////////////////////////////////////////////
class T_phy_pma_iso_tx_lpc_156 extends cdns_uvm_reg;

  `uvm_object_utils(T_phy_pma_iso_tx_lpc_156)
  rand uvm_reg_field phy_pma_iso_tx_lpc_17_0;
  rand uvm_reg_field phy_pma_iso_tx_lpc_21_18;
  rand uvm_reg_field phy_pma_iso_tx_lpc_27_22;
  rand uvm_reg_field phy_pma_iso_tx_lpc_28;
  rand uvm_reg_field phy_pma_iso_tx_lpc_29;
  rand uvm_reg_field phy_pma_iso_tx_lpc_30;
  rand uvm_reg_field phy_pma_iso_tx_lpc_31;
  
  covergroup wr_fld_covg;
    phy_pma_iso_tx_lpc_17_0: coverpoint phy_pma_iso_tx_lpc_17_0.value[17:0];
    phy_pma_iso_tx_lpc_21_18: coverpoint phy_pma_iso_tx_lpc_21_18.value[3:0];
    phy_pma_iso_tx_lpc_27_22: coverpoint phy_pma_iso_tx_lpc_27_22.value[5:0];
    phy_pma_iso_tx_lpc_28: coverpoint phy_pma_iso_tx_lpc_28.value[0:0];
    phy_pma_iso_tx_lpc_29: coverpoint phy_pma_iso_tx_lpc_29.value[0:0];
    phy_pma_iso_tx_lpc_30: coverpoint phy_pma_iso_tx_lpc_30.value[0:0];
    phy_pma_iso_tx_lpc_31: coverpoint phy_pma_iso_tx_lpc_31.value[0:0];
  endgroup
  covergroup rd_fld_covg;
    phy_pma_iso_tx_lpc_17_0: coverpoint phy_pma_iso_tx_lpc_17_0.value[17:0];
    phy_pma_iso_tx_lpc_21_18: coverpoint phy_pma_iso_tx_lpc_21_18.value[3:0];
    phy_pma_iso_tx_lpc_27_22: coverpoint phy_pma_iso_tx_lpc_27_22.value[5:0];
    phy_pma_iso_tx_lpc_28: coverpoint phy_pma_iso_tx_lpc_28.value[0:0];
    phy_pma_iso_tx_lpc_29: coverpoint phy_pma_iso_tx_lpc_29.value[0:0];
    phy_pma_iso_tx_lpc_30: coverpoint phy_pma_iso_tx_lpc_30.value[0:0];
    phy_pma_iso_tx_lpc_31: coverpoint phy_pma_iso_tx_lpc_31.value[0:0];
  endgroup

  protected virtual function void sample(uvm_reg_data_t data, uvm_reg_data_t byte_en, bit is_read, uvm_reg_map map);
    super.sample(data, byte_en, is_read, map);
    if (get_coverage(UVM_CVR_FIELD_VALS)) begin
      if(!is_read) begin
          wr_fld_covg.sample();
      end
      if(is_read) begin
         rd_fld_covg.sample();
      end
    end
  endfunction

  virtual function void sample_values();
    super.sample_values();
    if (get_coverage(UVM_CVR_FIELD_VALS)) begin
      wr_fld_covg.sample();
      rd_fld_covg.sample();
    end
  endfunction

  virtual function void build();
    uvm_reg_field fld_set[$];
    uvm_reg_field_config_ta ta = get_field_config(getconfigUID());
    build_uvm_reg_fields(this, ta, fld_set);
    
    phy_pma_iso_tx_lpc_17_0 = fld_set[0];
    phy_pma_iso_tx_lpc_21_18 = fld_set[1];
    phy_pma_iso_tx_lpc_27_22 = fld_set[2];
    phy_pma_iso_tx_lpc_28 = fld_set[3];
    phy_pma_iso_tx_lpc_29 = fld_set[4];
    phy_pma_iso_tx_lpc_30 = fld_set[5];
    phy_pma_iso_tx_lpc_31 = fld_set[6];
  endfunction

  function new(input string name="T_phy_pma_iso_tx_lpc_156");
    super.new(name, 32, build_coverage(UVM_CVR_FIELD_VALS));
    if (has_coverage(UVM_CVR_FIELD_VALS)) begin
      wr_fld_covg = new();
      rd_fld_covg = new();
    end
  endfunction

endclass


/////////////////////////////////////////////////////
//                phy_pma_iso_tx_mgn
/////////////////////////////////////////////////////
class T_phy_pma_iso_tx_mgn_158 extends cdns_uvm_reg;

  `uvm_object_utils(T_phy_pma_iso_tx_mgn_158)
  rand uvm_reg_field phy_pma_iso_tx_mgn_2_0;
  rand uvm_reg_field phy_pma_iso_tx_mgn_7_3;
  rand uvm_reg_field phy_pma_iso_tx_mgn_8;
  rand uvm_reg_field phy_pma_iso_tx_mgn_15_9;
  rand uvm_reg_field phy_pma_iso_tx_mgn_21_16;
  rand uvm_reg_field phy_pma_iso_tx_mgn_23_22;
  rand uvm_reg_field phy_pma_iso_tx_mgn_29_24;
  rand uvm_reg_field phy_pma_iso_tx_mgn_31_30;
  
  covergroup wr_fld_covg;
    phy_pma_iso_tx_mgn_2_0: coverpoint phy_pma_iso_tx_mgn_2_0.value[2:0];
    phy_pma_iso_tx_mgn_7_3: coverpoint phy_pma_iso_tx_mgn_7_3.value[4:0];
    phy_pma_iso_tx_mgn_8: coverpoint phy_pma_iso_tx_mgn_8.value[0:0];
    phy_pma_iso_tx_mgn_15_9: coverpoint phy_pma_iso_tx_mgn_15_9.value[6:0];
    phy_pma_iso_tx_mgn_21_16: coverpoint phy_pma_iso_tx_mgn_21_16.value[5:0];
    phy_pma_iso_tx_mgn_23_22: coverpoint phy_pma_iso_tx_mgn_23_22.value[1:0];
    phy_pma_iso_tx_mgn_29_24: coverpoint phy_pma_iso_tx_mgn_29_24.value[5:0];
    phy_pma_iso_tx_mgn_31_30: coverpoint phy_pma_iso_tx_mgn_31_30.value[1:0];
  endgroup
  covergroup rd_fld_covg;
    phy_pma_iso_tx_mgn_2_0: coverpoint phy_pma_iso_tx_mgn_2_0.value[2:0];
    phy_pma_iso_tx_mgn_7_3: coverpoint phy_pma_iso_tx_mgn_7_3.value[4:0];
    phy_pma_iso_tx_mgn_8: coverpoint phy_pma_iso_tx_mgn_8.value[0:0];
    phy_pma_iso_tx_mgn_15_9: coverpoint phy_pma_iso_tx_mgn_15_9.value[6:0];
    phy_pma_iso_tx_mgn_21_16: coverpoint phy_pma_iso_tx_mgn_21_16.value[5:0];
    phy_pma_iso_tx_mgn_23_22: coverpoint phy_pma_iso_tx_mgn_23_22.value[1:0];
    phy_pma_iso_tx_mgn_29_24: coverpoint phy_pma_iso_tx_mgn_29_24.value[5:0];
    phy_pma_iso_tx_mgn_31_30: coverpoint phy_pma_iso_tx_mgn_31_30.value[1:0];
  endgroup

  protected virtual function void sample(uvm_reg_data_t data, uvm_reg_data_t byte_en, bit is_read, uvm_reg_map map);
    super.sample(data, byte_en, is_read, map);
    if (get_coverage(UVM_CVR_FIELD_VALS)) begin
      if(!is_read) begin
          wr_fld_covg.sample();
      end
      if(is_read) begin
         rd_fld_covg.sample();
      end
    end
  endfunction

  virtual function void sample_values();
    super.sample_values();
    if (get_coverage(UVM_CVR_FIELD_VALS)) begin
      wr_fld_covg.sample();
      rd_fld_covg.sample();
    end
  endfunction

  virtual function void build();
    uvm_reg_field fld_set[$];
    uvm_reg_field_config_ta ta = get_field_config(getconfigUID());
    build_uvm_reg_fields(this, ta, fld_set);
    
    phy_pma_iso_tx_mgn_2_0 = fld_set[0];
    phy_pma_iso_tx_mgn_7_3 = fld_set[1];
    phy_pma_iso_tx_mgn_8 = fld_set[2];
    phy_pma_iso_tx_mgn_15_9 = fld_set[3];
    phy_pma_iso_tx_mgn_21_16 = fld_set[4];
    phy_pma_iso_tx_mgn_23_22 = fld_set[5];
    phy_pma_iso_tx_mgn_29_24 = fld_set[6];
    phy_pma_iso_tx_mgn_31_30 = fld_set[7];
  endfunction

  function new(input string name="T_phy_pma_iso_tx_mgn_158");
    super.new(name, 32, build_coverage(UVM_CVR_FIELD_VALS));
    if (has_coverage(UVM_CVR_FIELD_VALS)) begin
      wr_fld_covg = new();
      rd_fld_covg = new();
    end
  endfunction

endclass


/////////////////////////////////////////////////////
//                phy_pma_iso_xcvr_ctrl
/////////////////////////////////////////////////////
class T_phy_pma_iso_xcvr_ctrl_155 extends cdns_uvm_reg;

  `uvm_object_utils(T_phy_pma_iso_xcvr_ctrl_155)
  rand uvm_reg_field phy_pma_iso_xcvr_ctrl_0;
  rand uvm_reg_field phy_pma_iso_xcvr_ctrl_1;
  rand uvm_reg_field phy_pma_iso_xcvr_ctrl_2;
  rand uvm_reg_field phy_pma_iso_xcvr_ctrl_3;
  rand uvm_reg_field phy_pma_iso_xcvr_ctrl_4;
  rand uvm_reg_field phy_pma_iso_xcvr_ctrl_5;
  rand uvm_reg_field phy_pma_iso_xcvr_ctrl_6;
  rand uvm_reg_field phy_pma_iso_xcvr_ctrl_7;
  rand uvm_reg_field phy_pma_iso_xcvr_ctrl_8;
  rand uvm_reg_field phy_pma_iso_xcvr_ctrl_9;
  rand uvm_reg_field phy_pma_iso_xcvr_ctrl_10;
  rand uvm_reg_field phy_pma_iso_xcvr_ctrl_11;
  rand uvm_reg_field phy_pma_iso_xcvr_ctrl_12;
  rand uvm_reg_field phy_pma_iso_xcvr_ctrl_14_13;
  rand uvm_reg_field phy_pma_iso_xcvr_ctrl_15;
  rand uvm_reg_field phy_pma_iso_xcvr_ctrl_16;
  rand uvm_reg_field phy_pma_iso_xcvr_ctrl_17;
  rand uvm_reg_field phy_pma_iso_xcvr_ctrl_18;
  rand uvm_reg_field phy_pma_iso_xcvr_ctrl_31_19;
  
  covergroup wr_fld_covg;
    phy_pma_iso_xcvr_ctrl_0: coverpoint phy_pma_iso_xcvr_ctrl_0.value[0:0];
    phy_pma_iso_xcvr_ctrl_1: coverpoint phy_pma_iso_xcvr_ctrl_1.value[0:0];
    phy_pma_iso_xcvr_ctrl_2: coverpoint phy_pma_iso_xcvr_ctrl_2.value[0:0];
    phy_pma_iso_xcvr_ctrl_3: coverpoint phy_pma_iso_xcvr_ctrl_3.value[0:0];
    phy_pma_iso_xcvr_ctrl_4: coverpoint phy_pma_iso_xcvr_ctrl_4.value[0:0];
    phy_pma_iso_xcvr_ctrl_5: coverpoint phy_pma_iso_xcvr_ctrl_5.value[0:0];
    phy_pma_iso_xcvr_ctrl_6: coverpoint phy_pma_iso_xcvr_ctrl_6.value[0:0];
    phy_pma_iso_xcvr_ctrl_7: coverpoint phy_pma_iso_xcvr_ctrl_7.value[0:0];
    phy_pma_iso_xcvr_ctrl_8: coverpoint phy_pma_iso_xcvr_ctrl_8.value[0:0];
    phy_pma_iso_xcvr_ctrl_9: coverpoint phy_pma_iso_xcvr_ctrl_9.value[0:0];
    phy_pma_iso_xcvr_ctrl_10: coverpoint phy_pma_iso_xcvr_ctrl_10.value[0:0];
    phy_pma_iso_xcvr_ctrl_11: coverpoint phy_pma_iso_xcvr_ctrl_11.value[0:0];
    phy_pma_iso_xcvr_ctrl_12: coverpoint phy_pma_iso_xcvr_ctrl_12.value[0:0];
    phy_pma_iso_xcvr_ctrl_14_13: coverpoint phy_pma_iso_xcvr_ctrl_14_13.value[1:0];
    phy_pma_iso_xcvr_ctrl_15: coverpoint phy_pma_iso_xcvr_ctrl_15.value[0:0];
    phy_pma_iso_xcvr_ctrl_16: coverpoint phy_pma_iso_xcvr_ctrl_16.value[0:0];
    phy_pma_iso_xcvr_ctrl_17: coverpoint phy_pma_iso_xcvr_ctrl_17.value[0:0];
    phy_pma_iso_xcvr_ctrl_18: coverpoint phy_pma_iso_xcvr_ctrl_18.value[0:0];
    phy_pma_iso_xcvr_ctrl_31_19: coverpoint phy_pma_iso_xcvr_ctrl_31_19.value[12:0];
  endgroup
  covergroup rd_fld_covg;
    phy_pma_iso_xcvr_ctrl_0: coverpoint phy_pma_iso_xcvr_ctrl_0.value[0:0];
    phy_pma_iso_xcvr_ctrl_1: coverpoint phy_pma_iso_xcvr_ctrl_1.value[0:0];
    phy_pma_iso_xcvr_ctrl_2: coverpoint phy_pma_iso_xcvr_ctrl_2.value[0:0];
    phy_pma_iso_xcvr_ctrl_3: coverpoint phy_pma_iso_xcvr_ctrl_3.value[0:0];
    phy_pma_iso_xcvr_ctrl_4: coverpoint phy_pma_iso_xcvr_ctrl_4.value[0:0];
    phy_pma_iso_xcvr_ctrl_5: coverpoint phy_pma_iso_xcvr_ctrl_5.value[0:0];
    phy_pma_iso_xcvr_ctrl_6: coverpoint phy_pma_iso_xcvr_ctrl_6.value[0:0];
    phy_pma_iso_xcvr_ctrl_7: coverpoint phy_pma_iso_xcvr_ctrl_7.value[0:0];
    phy_pma_iso_xcvr_ctrl_8: coverpoint phy_pma_iso_xcvr_ctrl_8.value[0:0];
    phy_pma_iso_xcvr_ctrl_9: coverpoint phy_pma_iso_xcvr_ctrl_9.value[0:0];
    phy_pma_iso_xcvr_ctrl_10: coverpoint phy_pma_iso_xcvr_ctrl_10.value[0:0];
    phy_pma_iso_xcvr_ctrl_11: coverpoint phy_pma_iso_xcvr_ctrl_11.value[0:0];
    phy_pma_iso_xcvr_ctrl_12: coverpoint phy_pma_iso_xcvr_ctrl_12.value[0:0];
    phy_pma_iso_xcvr_ctrl_14_13: coverpoint phy_pma_iso_xcvr_ctrl_14_13.value[1:0];
    phy_pma_iso_xcvr_ctrl_15: coverpoint phy_pma_iso_xcvr_ctrl_15.value[0:0];
    phy_pma_iso_xcvr_ctrl_16: coverpoint phy_pma_iso_xcvr_ctrl_16.value[0:0];
    phy_pma_iso_xcvr_ctrl_17: coverpoint phy_pma_iso_xcvr_ctrl_17.value[0:0];
    phy_pma_iso_xcvr_ctrl_18: coverpoint phy_pma_iso_xcvr_ctrl_18.value[0:0];
    phy_pma_iso_xcvr_ctrl_31_19: coverpoint phy_pma_iso_xcvr_ctrl_31_19.value[12:0];
  endgroup

  protected virtual function void sample(uvm_reg_data_t data, uvm_reg_data_t byte_en, bit is_read, uvm_reg_map map);
    super.sample(data, byte_en, is_read, map);
    if (get_coverage(UVM_CVR_FIELD_VALS)) begin
      if(!is_read) begin
          wr_fld_covg.sample();
      end
      if(is_read) begin
         rd_fld_covg.sample();
      end
    end
  endfunction

  virtual function void sample_values();
    super.sample_values();
    if (get_coverage(UVM_CVR_FIELD_VALS)) begin
      wr_fld_covg.sample();
      rd_fld_covg.sample();
    end
  endfunction

  virtual function void build();
    uvm_reg_field fld_set[$];
    uvm_reg_field_config_ta ta = get_field_config(getconfigUID());
    build_uvm_reg_fields(this, ta, fld_set);
    
    phy_pma_iso_xcvr_ctrl_0 = fld_set[0];
    phy_pma_iso_xcvr_ctrl_1 = fld_set[1];
    phy_pma_iso_xcvr_ctrl_2 = fld_set[2];
    phy_pma_iso_xcvr_ctrl_3 = fld_set[3];
    phy_pma_iso_xcvr_ctrl_4 = fld_set[4];
    phy_pma_iso_xcvr_ctrl_5 = fld_set[5];
    phy_pma_iso_xcvr_ctrl_6 = fld_set[6];
    phy_pma_iso_xcvr_ctrl_7 = fld_set[7];
    phy_pma_iso_xcvr_ctrl_8 = fld_set[8];
    phy_pma_iso_xcvr_ctrl_9 = fld_set[9];
    phy_pma_iso_xcvr_ctrl_10 = fld_set[10];
    phy_pma_iso_xcvr_ctrl_11 = fld_set[11];
    phy_pma_iso_xcvr_ctrl_12 = fld_set[12];
    phy_pma_iso_xcvr_ctrl_14_13 = fld_set[13];
    phy_pma_iso_xcvr_ctrl_15 = fld_set[14];
    phy_pma_iso_xcvr_ctrl_16 = fld_set[15];
    phy_pma_iso_xcvr_ctrl_17 = fld_set[16];
    phy_pma_iso_xcvr_ctrl_18 = fld_set[17];
    phy_pma_iso_xcvr_ctrl_31_19 = fld_set[18];
  endfunction

  function new(input string name="T_phy_pma_iso_xcvr_ctrl_155");
    super.new(name, 32, build_coverage(UVM_CVR_FIELD_VALS));
    if (has_coverage(UVM_CVR_FIELD_VALS)) begin
      wr_fld_covg = new();
      rd_fld_covg = new();
    end
  endfunction

endclass


/////////////////////////////////////////////////////
//                phy_pma_override
/////////////////////////////////////////////////////
class T_phy_pma_override_162 extends cdns_uvm_reg;

  `uvm_object_utils(T_phy_pma_override_162)
  rand uvm_reg_field phy_pma_override_2_0;
  rand uvm_reg_field phy_pma_override_3;
  rand uvm_reg_field phy_pma_override_4;
  rand uvm_reg_field phy_pma_override_7_5;
  rand uvm_reg_field phy_pma_override_10_8;
  rand uvm_reg_field phy_pma_override_11;
  rand uvm_reg_field phy_pma_override_12;
  rand uvm_reg_field phy_pma_override_31_13;
  
  covergroup wr_fld_covg;
    phy_pma_override_2_0: coverpoint phy_pma_override_2_0.value[2:0];
    phy_pma_override_3: coverpoint phy_pma_override_3.value[0:0];
    phy_pma_override_4: coverpoint phy_pma_override_4.value[0:0];
    phy_pma_override_7_5: coverpoint phy_pma_override_7_5.value[2:0];
    phy_pma_override_10_8: coverpoint phy_pma_override_10_8.value[2:0];
    phy_pma_override_11: coverpoint phy_pma_override_11.value[0:0];
    phy_pma_override_12: coverpoint phy_pma_override_12.value[0:0];
    phy_pma_override_31_13: coverpoint phy_pma_override_31_13.value[18:0];
  endgroup
  covergroup rd_fld_covg;
    phy_pma_override_2_0: coverpoint phy_pma_override_2_0.value[2:0];
    phy_pma_override_3: coverpoint phy_pma_override_3.value[0:0];
    phy_pma_override_4: coverpoint phy_pma_override_4.value[0:0];
    phy_pma_override_7_5: coverpoint phy_pma_override_7_5.value[2:0];
    phy_pma_override_10_8: coverpoint phy_pma_override_10_8.value[2:0];
    phy_pma_override_11: coverpoint phy_pma_override_11.value[0:0];
    phy_pma_override_12: coverpoint phy_pma_override_12.value[0:0];
    phy_pma_override_31_13: coverpoint phy_pma_override_31_13.value[18:0];
  endgroup

  protected virtual function void sample(uvm_reg_data_t data, uvm_reg_data_t byte_en, bit is_read, uvm_reg_map map);
    super.sample(data, byte_en, is_read, map);
    if (get_coverage(UVM_CVR_FIELD_VALS)) begin
      if(!is_read) begin
          wr_fld_covg.sample();
      end
      if(is_read) begin
         rd_fld_covg.sample();
      end
    end
  endfunction

  virtual function void sample_values();
    super.sample_values();
    if (get_coverage(UVM_CVR_FIELD_VALS)) begin
      wr_fld_covg.sample();
      rd_fld_covg.sample();
    end
  endfunction

  virtual function void build();
    uvm_reg_field fld_set[$];
    uvm_reg_field_config_ta ta = get_field_config(getconfigUID());
    build_uvm_reg_fields(this, ta, fld_set);
    
    phy_pma_override_2_0 = fld_set[0];
    phy_pma_override_3 = fld_set[1];
    phy_pma_override_4 = fld_set[2];
    phy_pma_override_7_5 = fld_set[3];
    phy_pma_override_10_8 = fld_set[4];
    phy_pma_override_11 = fld_set[5];
    phy_pma_override_12 = fld_set[6];
    phy_pma_override_31_13 = fld_set[7];
  endfunction

  function new(input string name="T_phy_pma_override_162");
    super.new(name, 32, build_coverage(UVM_CVR_FIELD_VALS));
    if (has_coverage(UVM_CVR_FIELD_VALS)) begin
      wr_fld_covg = new();
      rd_fld_covg = new();
    end
  endfunction

endclass


/////////////////////////////////////////////////////
//                phy_pma_psm_state
/////////////////////////////////////////////////////
class T_phy_pma_psm_state_152 extends cdns_uvm_reg;

  `uvm_object_utils(T_phy_pma_psm_state_152)
  rand uvm_reg_field phy_pma_psm_state_25_0;
  rand uvm_reg_field phy_pma_psm_state_30_26;
  rand uvm_reg_field phy_pma_psm_state_31;
  
  covergroup wr_fld_covg;
    phy_pma_psm_state_25_0: coverpoint phy_pma_psm_state_25_0.value[25:0];
    phy_pma_psm_state_30_26: coverpoint phy_pma_psm_state_30_26.value[4:0];
    phy_pma_psm_state_31: coverpoint phy_pma_psm_state_31.value[0:0];
  endgroup
  covergroup rd_fld_covg;
    phy_pma_psm_state_25_0: coverpoint phy_pma_psm_state_25_0.value[25:0];
    phy_pma_psm_state_30_26: coverpoint phy_pma_psm_state_30_26.value[4:0];
    phy_pma_psm_state_31: coverpoint phy_pma_psm_state_31.value[0:0];
  endgroup

  protected virtual function void sample(uvm_reg_data_t data, uvm_reg_data_t byte_en, bit is_read, uvm_reg_map map);
    super.sample(data, byte_en, is_read, map);
    if (get_coverage(UVM_CVR_FIELD_VALS)) begin
      if(!is_read) begin
          wr_fld_covg.sample();
      end
      if(is_read) begin
         rd_fld_covg.sample();
      end
    end
  endfunction

  virtual function void sample_values();
    super.sample_values();
    if (get_coverage(UVM_CVR_FIELD_VALS)) begin
      wr_fld_covg.sample();
      rd_fld_covg.sample();
    end
  endfunction

  virtual function void build();
    uvm_reg_field fld_set[$];
    uvm_reg_field_config_ta ta = get_field_config(getconfigUID());
    build_uvm_reg_fields(this, ta, fld_set);
    
    phy_pma_psm_state_25_0 = fld_set[0];
    phy_pma_psm_state_30_26 = fld_set[1];
    phy_pma_psm_state_31 = fld_set[2];
  endfunction

  function new(input string name="T_phy_pma_psm_state_152");
    super.new(name, 32, build_coverage(UVM_CVR_FIELD_VALS));
    if (has_coverage(UVM_CVR_FIELD_VALS)) begin
      wr_fld_covg = new();
      rd_fld_covg = new();
    end
  endfunction

endclass


/////////////////////////////////////////////////////
//                phy_pma_rx_eq_ctrl
/////////////////////////////////////////////////////
class T_phy_pma_rx_eq_ctrl_153 extends cdns_uvm_reg;

  `uvm_object_utils(T_phy_pma_rx_eq_ctrl_153)
  rand uvm_reg_field phy_pma_rx_eq_ctrl_0;
  rand uvm_reg_field phy_pma_rx_eq_ctrl_1;
  rand uvm_reg_field phy_pma_rx_eq_ctrl_2;
  rand uvm_reg_field phy_pma_rx_eq_ctrl_3;
  rand uvm_reg_field phy_pma_rx_eq_ctrl_4;
  rand uvm_reg_field phy_pma_rx_eq_ctrl_7_5;
  rand uvm_reg_field phy_pma_rx_eq_ctrl_13_8;
  rand uvm_reg_field phy_pma_rx_eq_ctrl_15_14;
  rand uvm_reg_field phy_pma_rx_eq_ctrl_23_16;
  rand uvm_reg_field phy_pma_rx_eq_ctrl_31_24;
  
  covergroup wr_fld_covg;
    phy_pma_rx_eq_ctrl_0: coverpoint phy_pma_rx_eq_ctrl_0.value[0:0];
    phy_pma_rx_eq_ctrl_1: coverpoint phy_pma_rx_eq_ctrl_1.value[0:0];
    phy_pma_rx_eq_ctrl_2: coverpoint phy_pma_rx_eq_ctrl_2.value[0:0];
    phy_pma_rx_eq_ctrl_3: coverpoint phy_pma_rx_eq_ctrl_3.value[0:0];
    phy_pma_rx_eq_ctrl_4: coverpoint phy_pma_rx_eq_ctrl_4.value[0:0];
    phy_pma_rx_eq_ctrl_7_5: coverpoint phy_pma_rx_eq_ctrl_7_5.value[2:0];
    phy_pma_rx_eq_ctrl_13_8: coverpoint phy_pma_rx_eq_ctrl_13_8.value[5:0];
    phy_pma_rx_eq_ctrl_15_14: coverpoint phy_pma_rx_eq_ctrl_15_14.value[1:0];
    phy_pma_rx_eq_ctrl_23_16: coverpoint phy_pma_rx_eq_ctrl_23_16.value[7:0];
    phy_pma_rx_eq_ctrl_31_24: coverpoint phy_pma_rx_eq_ctrl_31_24.value[7:0];
  endgroup
  covergroup rd_fld_covg;
    phy_pma_rx_eq_ctrl_0: coverpoint phy_pma_rx_eq_ctrl_0.value[0:0];
    phy_pma_rx_eq_ctrl_1: coverpoint phy_pma_rx_eq_ctrl_1.value[0:0];
    phy_pma_rx_eq_ctrl_2: coverpoint phy_pma_rx_eq_ctrl_2.value[0:0];
    phy_pma_rx_eq_ctrl_3: coverpoint phy_pma_rx_eq_ctrl_3.value[0:0];
    phy_pma_rx_eq_ctrl_4: coverpoint phy_pma_rx_eq_ctrl_4.value[0:0];
    phy_pma_rx_eq_ctrl_7_5: coverpoint phy_pma_rx_eq_ctrl_7_5.value[2:0];
    phy_pma_rx_eq_ctrl_13_8: coverpoint phy_pma_rx_eq_ctrl_13_8.value[5:0];
    phy_pma_rx_eq_ctrl_15_14: coverpoint phy_pma_rx_eq_ctrl_15_14.value[1:0];
    phy_pma_rx_eq_ctrl_23_16: coverpoint phy_pma_rx_eq_ctrl_23_16.value[7:0];
    phy_pma_rx_eq_ctrl_31_24: coverpoint phy_pma_rx_eq_ctrl_31_24.value[7:0];
  endgroup

  protected virtual function void sample(uvm_reg_data_t data, uvm_reg_data_t byte_en, bit is_read, uvm_reg_map map);
    super.sample(data, byte_en, is_read, map);
    if (get_coverage(UVM_CVR_FIELD_VALS)) begin
      if(!is_read) begin
          wr_fld_covg.sample();
      end
      if(is_read) begin
         rd_fld_covg.sample();
      end
    end
  endfunction

  virtual function void sample_values();
    super.sample_values();
    if (get_coverage(UVM_CVR_FIELD_VALS)) begin
      wr_fld_covg.sample();
      rd_fld_covg.sample();
    end
  endfunction

  virtual function void build();
    uvm_reg_field fld_set[$];
    uvm_reg_field_config_ta ta = get_field_config(getconfigUID());
    build_uvm_reg_fields(this, ta, fld_set);
    
    phy_pma_rx_eq_ctrl_0 = fld_set[0];
    phy_pma_rx_eq_ctrl_1 = fld_set[1];
    phy_pma_rx_eq_ctrl_2 = fld_set[2];
    phy_pma_rx_eq_ctrl_3 = fld_set[3];
    phy_pma_rx_eq_ctrl_4 = fld_set[4];
    phy_pma_rx_eq_ctrl_7_5 = fld_set[5];
    phy_pma_rx_eq_ctrl_13_8 = fld_set[6];
    phy_pma_rx_eq_ctrl_15_14 = fld_set[7];
    phy_pma_rx_eq_ctrl_23_16 = fld_set[8];
    phy_pma_rx_eq_ctrl_31_24 = fld_set[9];
  endfunction

  function new(input string name="T_phy_pma_rx_eq_ctrl_153");
    super.new(name, 32, build_coverage(UVM_CVR_FIELD_VALS));
    if (has_coverage(UVM_CVR_FIELD_VALS)) begin
      wr_fld_covg = new();
      rd_fld_covg = new();
    end
  endfunction

endclass


/////////////////////////////////////////////////////
//                phy_pma_rx_mrgn_ctrl
/////////////////////////////////////////////////////
class T_phy_pma_rx_mrgn_ctrl_154 extends cdns_uvm_reg;

  `uvm_object_utils(T_phy_pma_rx_mrgn_ctrl_154)
  rand uvm_reg_field phy_pma_rx_mrgn_ctrl_0;
  rand uvm_reg_field phy_pma_rx_mrgn_ctrl_3_1;
  rand uvm_reg_field phy_pma_rx_mrgn_ctrl_5_4;
  rand uvm_reg_field phy_pma_rx_mrgn_ctrl_7_6;
  rand uvm_reg_field phy_pma_rx_mrgn_ctrl_14_8;
  rand uvm_reg_field phy_pma_rx_mrgn_ctrl_15;
  rand uvm_reg_field phy_pma_rx_mrgn_ctrl_16;
  rand uvm_reg_field phy_pma_rx_mrgn_ctrl_19_17;
  rand uvm_reg_field phy_pma_rx_mrgn_ctrl_25_20;
  rand uvm_reg_field phy_pma_rx_mrgn_ctrl_31_26;
  
  covergroup wr_fld_covg;
    phy_pma_rx_mrgn_ctrl_0: coverpoint phy_pma_rx_mrgn_ctrl_0.value[0:0];
    phy_pma_rx_mrgn_ctrl_3_1: coverpoint phy_pma_rx_mrgn_ctrl_3_1.value[2:0];
    phy_pma_rx_mrgn_ctrl_5_4: coverpoint phy_pma_rx_mrgn_ctrl_5_4.value[1:0];
    phy_pma_rx_mrgn_ctrl_7_6: coverpoint phy_pma_rx_mrgn_ctrl_7_6.value[1:0];
    phy_pma_rx_mrgn_ctrl_14_8: coverpoint phy_pma_rx_mrgn_ctrl_14_8.value[6:0];
    phy_pma_rx_mrgn_ctrl_15: coverpoint phy_pma_rx_mrgn_ctrl_15.value[0:0];
    phy_pma_rx_mrgn_ctrl_16: coverpoint phy_pma_rx_mrgn_ctrl_16.value[0:0];
    phy_pma_rx_mrgn_ctrl_19_17: coverpoint phy_pma_rx_mrgn_ctrl_19_17.value[2:0];
    phy_pma_rx_mrgn_ctrl_25_20: coverpoint phy_pma_rx_mrgn_ctrl_25_20.value[5:0];
    phy_pma_rx_mrgn_ctrl_31_26: coverpoint phy_pma_rx_mrgn_ctrl_31_26.value[5:0];
  endgroup
  covergroup rd_fld_covg;
    phy_pma_rx_mrgn_ctrl_0: coverpoint phy_pma_rx_mrgn_ctrl_0.value[0:0];
    phy_pma_rx_mrgn_ctrl_3_1: coverpoint phy_pma_rx_mrgn_ctrl_3_1.value[2:0];
    phy_pma_rx_mrgn_ctrl_5_4: coverpoint phy_pma_rx_mrgn_ctrl_5_4.value[1:0];
    phy_pma_rx_mrgn_ctrl_7_6: coverpoint phy_pma_rx_mrgn_ctrl_7_6.value[1:0];
    phy_pma_rx_mrgn_ctrl_14_8: coverpoint phy_pma_rx_mrgn_ctrl_14_8.value[6:0];
    phy_pma_rx_mrgn_ctrl_15: coverpoint phy_pma_rx_mrgn_ctrl_15.value[0:0];
    phy_pma_rx_mrgn_ctrl_16: coverpoint phy_pma_rx_mrgn_ctrl_16.value[0:0];
    phy_pma_rx_mrgn_ctrl_19_17: coverpoint phy_pma_rx_mrgn_ctrl_19_17.value[2:0];
    phy_pma_rx_mrgn_ctrl_25_20: coverpoint phy_pma_rx_mrgn_ctrl_25_20.value[5:0];
    phy_pma_rx_mrgn_ctrl_31_26: coverpoint phy_pma_rx_mrgn_ctrl_31_26.value[5:0];
  endgroup

  protected virtual function void sample(uvm_reg_data_t data, uvm_reg_data_t byte_en, bit is_read, uvm_reg_map map);
    super.sample(data, byte_en, is_read, map);
    if (get_coverage(UVM_CVR_FIELD_VALS)) begin
      if(!is_read) begin
          wr_fld_covg.sample();
      end
      if(is_read) begin
         rd_fld_covg.sample();
      end
    end
  endfunction

  virtual function void sample_values();
    super.sample_values();
    if (get_coverage(UVM_CVR_FIELD_VALS)) begin
      wr_fld_covg.sample();
      rd_fld_covg.sample();
    end
  endfunction

  virtual function void build();
    uvm_reg_field fld_set[$];
    uvm_reg_field_config_ta ta = get_field_config(getconfigUID());
    build_uvm_reg_fields(this, ta, fld_set);
    
    phy_pma_rx_mrgn_ctrl_0 = fld_set[0];
    phy_pma_rx_mrgn_ctrl_3_1 = fld_set[1];
    phy_pma_rx_mrgn_ctrl_5_4 = fld_set[2];
    phy_pma_rx_mrgn_ctrl_7_6 = fld_set[3];
    phy_pma_rx_mrgn_ctrl_14_8 = fld_set[4];
    phy_pma_rx_mrgn_ctrl_15 = fld_set[5];
    phy_pma_rx_mrgn_ctrl_16 = fld_set[6];
    phy_pma_rx_mrgn_ctrl_19_17 = fld_set[7];
    phy_pma_rx_mrgn_ctrl_25_20 = fld_set[8];
    phy_pma_rx_mrgn_ctrl_31_26 = fld_set[9];
  endfunction

  function new(input string name="T_phy_pma_rx_mrgn_ctrl_154");
    super.new(name, 32, build_coverage(UVM_CVR_FIELD_VALS));
    if (has_coverage(UVM_CVR_FIELD_VALS)) begin
      wr_fld_covg = new();
      rd_fld_covg = new();
    end
  endfunction

endclass


/////////////////////////////////////////////////////
//                phy_pma_xcvr_ctrl_sts
/////////////////////////////////////////////////////
class T_phy_pma_xcvr_ctrl_sts_163 extends cdns_uvm_reg;

  `uvm_object_utils(T_phy_pma_xcvr_ctrl_sts_163)
  rand uvm_reg_field phy_pma_xcvr_ctrl_sts_0;
  rand uvm_reg_field phy_pma_xcvr_ctrl_sts_1;
  rand uvm_reg_field phy_pma_xcvr_ctrl_sts_2;
  rand uvm_reg_field phy_pma_xcvr_ctrl_sts_3;
  rand uvm_reg_field phy_pma_xcvr_ctrl_sts_4;
  rand uvm_reg_field phy_pma_xcvr_ctrl_sts_5;
  rand uvm_reg_field phy_pma_xcvr_ctrl_sts_6;
  rand uvm_reg_field phy_pma_xcvr_ctrl_sts_7;
  rand uvm_reg_field phy_pma_xcvr_ctrl_sts_8;
  rand uvm_reg_field phy_pma_xcvr_ctrl_sts_11_9;
  rand uvm_reg_field phy_pma_xcvr_ctrl_sts_12;
  rand uvm_reg_field phy_pma_xcvr_ctrl_sts_13;
  rand uvm_reg_field phy_pma_xcvr_ctrl_sts_14;
  rand uvm_reg_field phy_pma_xcvr_ctrl_sts_15;
  rand uvm_reg_field phy_pma_xcvr_ctrl_sts_16;
  rand uvm_reg_field phy_pma_xcvr_ctrl_sts_17;
  rand uvm_reg_field phy_pma_xcvr_ctrl_sts_18;
  rand uvm_reg_field phy_pma_xcvr_ctrl_sts_19;
  rand uvm_reg_field phy_pma_xcvr_ctrl_sts_20;
  rand uvm_reg_field phy_pma_xcvr_ctrl_sts_21;
  rand uvm_reg_field phy_pma_xcvr_ctrl_sts_23_22;
  rand uvm_reg_field phy_pma_xcvr_ctrl_sts_24;
  rand uvm_reg_field phy_pma_xcvr_ctrl_sts_29_25;
  rand uvm_reg_field phy_pma_xcvr_ctrl_sts_30;
  rand uvm_reg_field phy_pma_xcvr_ctrl_sts_31;
  
  covergroup wr_fld_covg;
    phy_pma_xcvr_ctrl_sts_0: coverpoint phy_pma_xcvr_ctrl_sts_0.value[0:0];
    phy_pma_xcvr_ctrl_sts_1: coverpoint phy_pma_xcvr_ctrl_sts_1.value[0:0];
    phy_pma_xcvr_ctrl_sts_2: coverpoint phy_pma_xcvr_ctrl_sts_2.value[0:0];
    phy_pma_xcvr_ctrl_sts_3: coverpoint phy_pma_xcvr_ctrl_sts_3.value[0:0];
    phy_pma_xcvr_ctrl_sts_4: coverpoint phy_pma_xcvr_ctrl_sts_4.value[0:0];
    phy_pma_xcvr_ctrl_sts_5: coverpoint phy_pma_xcvr_ctrl_sts_5.value[0:0];
    phy_pma_xcvr_ctrl_sts_6: coverpoint phy_pma_xcvr_ctrl_sts_6.value[0:0];
    phy_pma_xcvr_ctrl_sts_7: coverpoint phy_pma_xcvr_ctrl_sts_7.value[0:0];
    phy_pma_xcvr_ctrl_sts_8: coverpoint phy_pma_xcvr_ctrl_sts_8.value[0:0];
    phy_pma_xcvr_ctrl_sts_11_9: coverpoint phy_pma_xcvr_ctrl_sts_11_9.value[2:0];
    phy_pma_xcvr_ctrl_sts_12: coverpoint phy_pma_xcvr_ctrl_sts_12.value[0:0];
    phy_pma_xcvr_ctrl_sts_13: coverpoint phy_pma_xcvr_ctrl_sts_13.value[0:0];
    phy_pma_xcvr_ctrl_sts_14: coverpoint phy_pma_xcvr_ctrl_sts_14.value[0:0];
    phy_pma_xcvr_ctrl_sts_15: coverpoint phy_pma_xcvr_ctrl_sts_15.value[0:0];
    phy_pma_xcvr_ctrl_sts_16: coverpoint phy_pma_xcvr_ctrl_sts_16.value[0:0];
    phy_pma_xcvr_ctrl_sts_17: coverpoint phy_pma_xcvr_ctrl_sts_17.value[0:0];
    phy_pma_xcvr_ctrl_sts_18: coverpoint phy_pma_xcvr_ctrl_sts_18.value[0:0];
    phy_pma_xcvr_ctrl_sts_19: coverpoint phy_pma_xcvr_ctrl_sts_19.value[0:0];
    phy_pma_xcvr_ctrl_sts_20: coverpoint phy_pma_xcvr_ctrl_sts_20.value[0:0];
    phy_pma_xcvr_ctrl_sts_21: coverpoint phy_pma_xcvr_ctrl_sts_21.value[0:0];
    phy_pma_xcvr_ctrl_sts_23_22: coverpoint phy_pma_xcvr_ctrl_sts_23_22.value[1:0];
    phy_pma_xcvr_ctrl_sts_24: coverpoint phy_pma_xcvr_ctrl_sts_24.value[0:0];
    phy_pma_xcvr_ctrl_sts_29_25: coverpoint phy_pma_xcvr_ctrl_sts_29_25.value[4:0];
    phy_pma_xcvr_ctrl_sts_30: coverpoint phy_pma_xcvr_ctrl_sts_30.value[0:0];
    phy_pma_xcvr_ctrl_sts_31: coverpoint phy_pma_xcvr_ctrl_sts_31.value[0:0];
  endgroup
  covergroup rd_fld_covg;
    phy_pma_xcvr_ctrl_sts_0: coverpoint phy_pma_xcvr_ctrl_sts_0.value[0:0];
    phy_pma_xcvr_ctrl_sts_1: coverpoint phy_pma_xcvr_ctrl_sts_1.value[0:0];
    phy_pma_xcvr_ctrl_sts_2: coverpoint phy_pma_xcvr_ctrl_sts_2.value[0:0];
    phy_pma_xcvr_ctrl_sts_3: coverpoint phy_pma_xcvr_ctrl_sts_3.value[0:0];
    phy_pma_xcvr_ctrl_sts_4: coverpoint phy_pma_xcvr_ctrl_sts_4.value[0:0];
    phy_pma_xcvr_ctrl_sts_5: coverpoint phy_pma_xcvr_ctrl_sts_5.value[0:0];
    phy_pma_xcvr_ctrl_sts_6: coverpoint phy_pma_xcvr_ctrl_sts_6.value[0:0];
    phy_pma_xcvr_ctrl_sts_7: coverpoint phy_pma_xcvr_ctrl_sts_7.value[0:0];
    phy_pma_xcvr_ctrl_sts_8: coverpoint phy_pma_xcvr_ctrl_sts_8.value[0:0];
    phy_pma_xcvr_ctrl_sts_11_9: coverpoint phy_pma_xcvr_ctrl_sts_11_9.value[2:0];
    phy_pma_xcvr_ctrl_sts_12: coverpoint phy_pma_xcvr_ctrl_sts_12.value[0:0];
    phy_pma_xcvr_ctrl_sts_13: coverpoint phy_pma_xcvr_ctrl_sts_13.value[0:0];
    phy_pma_xcvr_ctrl_sts_14: coverpoint phy_pma_xcvr_ctrl_sts_14.value[0:0];
    phy_pma_xcvr_ctrl_sts_15: coverpoint phy_pma_xcvr_ctrl_sts_15.value[0:0];
    phy_pma_xcvr_ctrl_sts_16: coverpoint phy_pma_xcvr_ctrl_sts_16.value[0:0];
    phy_pma_xcvr_ctrl_sts_17: coverpoint phy_pma_xcvr_ctrl_sts_17.value[0:0];
    phy_pma_xcvr_ctrl_sts_18: coverpoint phy_pma_xcvr_ctrl_sts_18.value[0:0];
    phy_pma_xcvr_ctrl_sts_19: coverpoint phy_pma_xcvr_ctrl_sts_19.value[0:0];
    phy_pma_xcvr_ctrl_sts_20: coverpoint phy_pma_xcvr_ctrl_sts_20.value[0:0];
    phy_pma_xcvr_ctrl_sts_21: coverpoint phy_pma_xcvr_ctrl_sts_21.value[0:0];
    phy_pma_xcvr_ctrl_sts_23_22: coverpoint phy_pma_xcvr_ctrl_sts_23_22.value[1:0];
    phy_pma_xcvr_ctrl_sts_24: coverpoint phy_pma_xcvr_ctrl_sts_24.value[0:0];
    phy_pma_xcvr_ctrl_sts_29_25: coverpoint phy_pma_xcvr_ctrl_sts_29_25.value[4:0];
    phy_pma_xcvr_ctrl_sts_30: coverpoint phy_pma_xcvr_ctrl_sts_30.value[0:0];
    phy_pma_xcvr_ctrl_sts_31: coverpoint phy_pma_xcvr_ctrl_sts_31.value[0:0];
  endgroup

  protected virtual function void sample(uvm_reg_data_t data, uvm_reg_data_t byte_en, bit is_read, uvm_reg_map map);
    super.sample(data, byte_en, is_read, map);
    if (get_coverage(UVM_CVR_FIELD_VALS)) begin
      if(!is_read) begin
          wr_fld_covg.sample();
      end
      if(is_read) begin
         rd_fld_covg.sample();
      end
    end
  endfunction

  virtual function void sample_values();
    super.sample_values();
    if (get_coverage(UVM_CVR_FIELD_VALS)) begin
      wr_fld_covg.sample();
      rd_fld_covg.sample();
    end
  endfunction

  virtual function void build();
    uvm_reg_field fld_set[$];
    uvm_reg_field_config_ta ta = get_field_config(getconfigUID());
    build_uvm_reg_fields(this, ta, fld_set);
    
    phy_pma_xcvr_ctrl_sts_0 = fld_set[0];
    phy_pma_xcvr_ctrl_sts_1 = fld_set[1];
    phy_pma_xcvr_ctrl_sts_2 = fld_set[2];
    phy_pma_xcvr_ctrl_sts_3 = fld_set[3];
    phy_pma_xcvr_ctrl_sts_4 = fld_set[4];
    phy_pma_xcvr_ctrl_sts_5 = fld_set[5];
    phy_pma_xcvr_ctrl_sts_6 = fld_set[6];
    phy_pma_xcvr_ctrl_sts_7 = fld_set[7];
    phy_pma_xcvr_ctrl_sts_8 = fld_set[8];
    phy_pma_xcvr_ctrl_sts_11_9 = fld_set[9];
    phy_pma_xcvr_ctrl_sts_12 = fld_set[10];
    phy_pma_xcvr_ctrl_sts_13 = fld_set[11];
    phy_pma_xcvr_ctrl_sts_14 = fld_set[12];
    phy_pma_xcvr_ctrl_sts_15 = fld_set[13];
    phy_pma_xcvr_ctrl_sts_16 = fld_set[14];
    phy_pma_xcvr_ctrl_sts_17 = fld_set[15];
    phy_pma_xcvr_ctrl_sts_18 = fld_set[16];
    phy_pma_xcvr_ctrl_sts_19 = fld_set[17];
    phy_pma_xcvr_ctrl_sts_20 = fld_set[18];
    phy_pma_xcvr_ctrl_sts_21 = fld_set[19];
    phy_pma_xcvr_ctrl_sts_23_22 = fld_set[20];
    phy_pma_xcvr_ctrl_sts_24 = fld_set[21];
    phy_pma_xcvr_ctrl_sts_29_25 = fld_set[22];
    phy_pma_xcvr_ctrl_sts_30 = fld_set[23];
    phy_pma_xcvr_ctrl_sts_31 = fld_set[24];
  endfunction

  function new(input string name="T_phy_pma_xcvr_ctrl_sts_163");
    super.new(name, 32, build_coverage(UVM_CVR_FIELD_VALS));
    if (has_coverage(UVM_CVR_FIELD_VALS)) begin
      wr_fld_covg = new();
      rd_fld_covg = new();
    end
  endfunction

endclass


/////////////////////////////////////////////////////
//                phy_pma_xcvr_ctrl_sts_clr
/////////////////////////////////////////////////////
class T_phy_pma_xcvr_ctrl_sts_clr_164 extends cdns_uvm_reg;

  `uvm_object_utils(T_phy_pma_xcvr_ctrl_sts_clr_164)
  rand uvm_reg_field phy_pma_xcvr_ctrl_sts_clr_31_0;
  
  covergroup wr_fld_covg;
    phy_pma_xcvr_ctrl_sts_clr_31_0: coverpoint phy_pma_xcvr_ctrl_sts_clr_31_0.value[31:0];
  endgroup
  covergroup rd_fld_covg;
    phy_pma_xcvr_ctrl_sts_clr_31_0: coverpoint phy_pma_xcvr_ctrl_sts_clr_31_0.value[31:0];
  endgroup

  protected virtual function void sample(uvm_reg_data_t data, uvm_reg_data_t byte_en, bit is_read, uvm_reg_map map);
    super.sample(data, byte_en, is_read, map);
    if (get_coverage(UVM_CVR_FIELD_VALS)) begin
      if(!is_read) begin
          wr_fld_covg.sample();
      end
      if(is_read) begin
         rd_fld_covg.sample();
      end
    end
  endfunction

  virtual function void sample_values();
    super.sample_values();
    if (get_coverage(UVM_CVR_FIELD_VALS)) begin
      wr_fld_covg.sample();
      rd_fld_covg.sample();
    end
  endfunction

  virtual function void build();
    uvm_reg_field fld_set[$];
    uvm_reg_field_config_ta ta = get_field_config(getconfigUID());
    build_uvm_reg_fields(this, ta, fld_set);
    
    phy_pma_xcvr_ctrl_sts_clr_31_0 = fld_set[0];
  endfunction

  function new(input string name="T_phy_pma_xcvr_ctrl_sts_clr_164");
    super.new(name, 32, build_coverage(UVM_CVR_FIELD_VALS));
    if (has_coverage(UVM_CVR_FIELD_VALS)) begin
      wr_fld_covg = new();
      rd_fld_covg = new();
    end
  endfunction

endclass


/////////////////////////////////////////////////////
//                phy_top_uc_pma_en_int_sts1
/////////////////////////////////////////////////////
class T_phy_top_uc_pma_en_int_sts1_172 extends cdns_uvm_reg;

  `uvm_object_utils(T_phy_top_uc_pma_en_int_sts1_172)
  rand uvm_reg_field phy_top_uc_pma_en_int_sts1_31_0;
  
  covergroup wr_fld_covg;
    phy_top_uc_pma_en_int_sts1_31_0: coverpoint phy_top_uc_pma_en_int_sts1_31_0.value[31:0];
  endgroup
  covergroup rd_fld_covg;
    phy_top_uc_pma_en_int_sts1_31_0: coverpoint phy_top_uc_pma_en_int_sts1_31_0.value[31:0];
  endgroup

  protected virtual function void sample(uvm_reg_data_t data, uvm_reg_data_t byte_en, bit is_read, uvm_reg_map map);
    super.sample(data, byte_en, is_read, map);
    if (get_coverage(UVM_CVR_FIELD_VALS)) begin
      if(!is_read) begin
          wr_fld_covg.sample();
      end
      if(is_read) begin
         rd_fld_covg.sample();
      end
    end
  endfunction

  virtual function void sample_values();
    super.sample_values();
    if (get_coverage(UVM_CVR_FIELD_VALS)) begin
      wr_fld_covg.sample();
      rd_fld_covg.sample();
    end
  endfunction

  virtual function void build();
    uvm_reg_field fld_set[$];
    uvm_reg_field_config_ta ta = get_field_config(getconfigUID());
    build_uvm_reg_fields(this, ta, fld_set);
    
    phy_top_uc_pma_en_int_sts1_31_0 = fld_set[0];
  endfunction

  function new(input string name="T_phy_top_uc_pma_en_int_sts1_172");
    super.new(name, 32, build_coverage(UVM_CVR_FIELD_VALS));
    if (has_coverage(UVM_CVR_FIELD_VALS)) begin
      wr_fld_covg = new();
      rd_fld_covg = new();
    end
  endfunction

endclass


/////////////////////////////////////////////////////
//                phy_top_uc_pma_en_int_sts2
/////////////////////////////////////////////////////
class T_phy_top_uc_pma_en_int_sts2_174 extends cdns_uvm_reg;

  `uvm_object_utils(T_phy_top_uc_pma_en_int_sts2_174)
  rand uvm_reg_field phy_top_uc_pma_en_int_sts2_31_0;
  
  covergroup wr_fld_covg;
    phy_top_uc_pma_en_int_sts2_31_0: coverpoint phy_top_uc_pma_en_int_sts2_31_0.value[31:0];
  endgroup
  covergroup rd_fld_covg;
    phy_top_uc_pma_en_int_sts2_31_0: coverpoint phy_top_uc_pma_en_int_sts2_31_0.value[31:0];
  endgroup

  protected virtual function void sample(uvm_reg_data_t data, uvm_reg_data_t byte_en, bit is_read, uvm_reg_map map);
    super.sample(data, byte_en, is_read, map);
    if (get_coverage(UVM_CVR_FIELD_VALS)) begin
      if(!is_read) begin
          wr_fld_covg.sample();
      end
      if(is_read) begin
         rd_fld_covg.sample();
      end
    end
  endfunction

  virtual function void sample_values();
    super.sample_values();
    if (get_coverage(UVM_CVR_FIELD_VALS)) begin
      wr_fld_covg.sample();
      rd_fld_covg.sample();
    end
  endfunction

  virtual function void build();
    uvm_reg_field fld_set[$];
    uvm_reg_field_config_ta ta = get_field_config(getconfigUID());
    build_uvm_reg_fields(this, ta, fld_set);
    
    phy_top_uc_pma_en_int_sts2_31_0 = fld_set[0];
  endfunction

  function new(input string name="T_phy_top_uc_pma_en_int_sts2_174");
    super.new(name, 32, build_coverage(UVM_CVR_FIELD_VALS));
    if (has_coverage(UVM_CVR_FIELD_VALS)) begin
      wr_fld_covg = new();
      rd_fld_covg = new();
    end
  endfunction

endclass


/////////////////////////////////////////////////////
//                phy_top_uc_pma_int_sts1_en
/////////////////////////////////////////////////////
class T_phy_top_uc_pma_int_sts1_en_168 extends cdns_uvm_reg;

  `uvm_object_utils(T_phy_top_uc_pma_int_sts1_en_168)
  rand uvm_reg_field phy_top_uc_pma_int_sts1_en_31_0;
  
  covergroup wr_fld_covg;
    phy_top_uc_pma_int_sts1_en_31_0: coverpoint phy_top_uc_pma_int_sts1_en_31_0.value[31:0];
  endgroup
  covergroup rd_fld_covg;
    phy_top_uc_pma_int_sts1_en_31_0: coverpoint phy_top_uc_pma_int_sts1_en_31_0.value[31:0];
  endgroup

  protected virtual function void sample(uvm_reg_data_t data, uvm_reg_data_t byte_en, bit is_read, uvm_reg_map map);
    super.sample(data, byte_en, is_read, map);
    if (get_coverage(UVM_CVR_FIELD_VALS)) begin
      if(!is_read) begin
          wr_fld_covg.sample();
      end
      if(is_read) begin
         rd_fld_covg.sample();
      end
    end
  endfunction

  virtual function void sample_values();
    super.sample_values();
    if (get_coverage(UVM_CVR_FIELD_VALS)) begin
      wr_fld_covg.sample();
      rd_fld_covg.sample();
    end
  endfunction

  virtual function void build();
    uvm_reg_field fld_set[$];
    uvm_reg_field_config_ta ta = get_field_config(getconfigUID());
    build_uvm_reg_fields(this, ta, fld_set);
    
    phy_top_uc_pma_int_sts1_en_31_0 = fld_set[0];
  endfunction

  function new(input string name="T_phy_top_uc_pma_int_sts1_en_168");
    super.new(name, 32, build_coverage(UVM_CVR_FIELD_VALS));
    if (has_coverage(UVM_CVR_FIELD_VALS)) begin
      wr_fld_covg = new();
      rd_fld_covg = new();
    end
  endfunction

endclass


/////////////////////////////////////////////////////
//                phy_uc_pma_int_sts1
/////////////////////////////////////////////////////
class T_phy_uc_pma_int_sts1_165 extends cdns_uvm_reg;

  `uvm_object_utils(T_phy_uc_pma_int_sts1_165)
  rand uvm_reg_field phy_uc_pma_int_sts1_4_0;
  rand uvm_reg_field phy_uc_pma_int_sts1_9_5;
  rand uvm_reg_field phy_uc_pma_int_sts1_10;
  rand uvm_reg_field phy_uc_pma_int_sts1_11;
  rand uvm_reg_field phy_uc_pma_int_sts1_12;
  rand uvm_reg_field phy_uc_pma_int_sts1_13;
  rand uvm_reg_field phy_uc_pma_int_sts1_14;
  rand uvm_reg_field phy_uc_pma_int_sts1_15;
  rand uvm_reg_field phy_uc_pma_int_sts1_16;
  rand uvm_reg_field phy_uc_pma_int_sts1_17;
  rand uvm_reg_field phy_uc_pma_int_sts1_18;
  rand uvm_reg_field phy_uc_pma_int_sts1_19;
  rand uvm_reg_field phy_uc_pma_int_sts1_20;
  rand uvm_reg_field phy_uc_pma_int_sts1_21;
  rand uvm_reg_field phy_uc_pma_int_sts1_22;
  rand uvm_reg_field phy_uc_pma_int_sts1_23;
  rand uvm_reg_field phy_uc_pma_int_sts1_24;
  rand uvm_reg_field phy_uc_pma_int_sts1_25;
  rand uvm_reg_field phy_uc_pma_int_sts1_26;
  rand uvm_reg_field phy_uc_pma_int_sts1_28_27;
  rand uvm_reg_field phy_uc_pma_int_sts1_30_29;
  rand uvm_reg_field phy_uc_pma_int_sts1_31;
  
  covergroup wr_fld_covg;
    phy_uc_pma_int_sts1_4_0: coverpoint phy_uc_pma_int_sts1_4_0.value[4:0];
    phy_uc_pma_int_sts1_9_5: coverpoint phy_uc_pma_int_sts1_9_5.value[4:0];
    phy_uc_pma_int_sts1_10: coverpoint phy_uc_pma_int_sts1_10.value[0:0];
    phy_uc_pma_int_sts1_11: coverpoint phy_uc_pma_int_sts1_11.value[0:0];
    phy_uc_pma_int_sts1_12: coverpoint phy_uc_pma_int_sts1_12.value[0:0];
    phy_uc_pma_int_sts1_13: coverpoint phy_uc_pma_int_sts1_13.value[0:0];
    phy_uc_pma_int_sts1_14: coverpoint phy_uc_pma_int_sts1_14.value[0:0];
    phy_uc_pma_int_sts1_15: coverpoint phy_uc_pma_int_sts1_15.value[0:0];
    phy_uc_pma_int_sts1_16: coverpoint phy_uc_pma_int_sts1_16.value[0:0];
    phy_uc_pma_int_sts1_17: coverpoint phy_uc_pma_int_sts1_17.value[0:0];
    phy_uc_pma_int_sts1_18: coverpoint phy_uc_pma_int_sts1_18.value[0:0];
    phy_uc_pma_int_sts1_19: coverpoint phy_uc_pma_int_sts1_19.value[0:0];
    phy_uc_pma_int_sts1_20: coverpoint phy_uc_pma_int_sts1_20.value[0:0];
    phy_uc_pma_int_sts1_21: coverpoint phy_uc_pma_int_sts1_21.value[0:0];
    phy_uc_pma_int_sts1_22: coverpoint phy_uc_pma_int_sts1_22.value[0:0];
    phy_uc_pma_int_sts1_23: coverpoint phy_uc_pma_int_sts1_23.value[0:0];
    phy_uc_pma_int_sts1_24: coverpoint phy_uc_pma_int_sts1_24.value[0:0];
    phy_uc_pma_int_sts1_25: coverpoint phy_uc_pma_int_sts1_25.value[0:0];
    phy_uc_pma_int_sts1_26: coverpoint phy_uc_pma_int_sts1_26.value[0:0];
    phy_uc_pma_int_sts1_28_27: coverpoint phy_uc_pma_int_sts1_28_27.value[1:0];
    phy_uc_pma_int_sts1_30_29: coverpoint phy_uc_pma_int_sts1_30_29.value[1:0];
    phy_uc_pma_int_sts1_31: coverpoint phy_uc_pma_int_sts1_31.value[0:0];
  endgroup
  covergroup rd_fld_covg;
    phy_uc_pma_int_sts1_4_0: coverpoint phy_uc_pma_int_sts1_4_0.value[4:0];
    phy_uc_pma_int_sts1_9_5: coverpoint phy_uc_pma_int_sts1_9_5.value[4:0];
    phy_uc_pma_int_sts1_10: coverpoint phy_uc_pma_int_sts1_10.value[0:0];
    phy_uc_pma_int_sts1_11: coverpoint phy_uc_pma_int_sts1_11.value[0:0];
    phy_uc_pma_int_sts1_12: coverpoint phy_uc_pma_int_sts1_12.value[0:0];
    phy_uc_pma_int_sts1_13: coverpoint phy_uc_pma_int_sts1_13.value[0:0];
    phy_uc_pma_int_sts1_14: coverpoint phy_uc_pma_int_sts1_14.value[0:0];
    phy_uc_pma_int_sts1_15: coverpoint phy_uc_pma_int_sts1_15.value[0:0];
    phy_uc_pma_int_sts1_16: coverpoint phy_uc_pma_int_sts1_16.value[0:0];
    phy_uc_pma_int_sts1_17: coverpoint phy_uc_pma_int_sts1_17.value[0:0];
    phy_uc_pma_int_sts1_18: coverpoint phy_uc_pma_int_sts1_18.value[0:0];
    phy_uc_pma_int_sts1_19: coverpoint phy_uc_pma_int_sts1_19.value[0:0];
    phy_uc_pma_int_sts1_20: coverpoint phy_uc_pma_int_sts1_20.value[0:0];
    phy_uc_pma_int_sts1_21: coverpoint phy_uc_pma_int_sts1_21.value[0:0];
    phy_uc_pma_int_sts1_22: coverpoint phy_uc_pma_int_sts1_22.value[0:0];
    phy_uc_pma_int_sts1_23: coverpoint phy_uc_pma_int_sts1_23.value[0:0];
    phy_uc_pma_int_sts1_24: coverpoint phy_uc_pma_int_sts1_24.value[0:0];
    phy_uc_pma_int_sts1_25: coverpoint phy_uc_pma_int_sts1_25.value[0:0];
    phy_uc_pma_int_sts1_26: coverpoint phy_uc_pma_int_sts1_26.value[0:0];
    phy_uc_pma_int_sts1_28_27: coverpoint phy_uc_pma_int_sts1_28_27.value[1:0];
    phy_uc_pma_int_sts1_30_29: coverpoint phy_uc_pma_int_sts1_30_29.value[1:0];
    phy_uc_pma_int_sts1_31: coverpoint phy_uc_pma_int_sts1_31.value[0:0];
  endgroup

  protected virtual function void sample(uvm_reg_data_t data, uvm_reg_data_t byte_en, bit is_read, uvm_reg_map map);
    super.sample(data, byte_en, is_read, map);
    if (get_coverage(UVM_CVR_FIELD_VALS)) begin
      if(!is_read) begin
          wr_fld_covg.sample();
      end
      if(is_read) begin
         rd_fld_covg.sample();
      end
    end
  endfunction

  virtual function void sample_values();
    super.sample_values();
    if (get_coverage(UVM_CVR_FIELD_VALS)) begin
      wr_fld_covg.sample();
      rd_fld_covg.sample();
    end
  endfunction

  virtual function void build();
    uvm_reg_field fld_set[$];
    uvm_reg_field_config_ta ta = get_field_config(getconfigUID());
    build_uvm_reg_fields(this, ta, fld_set);
    
    phy_uc_pma_int_sts1_4_0 = fld_set[0];
    phy_uc_pma_int_sts1_9_5 = fld_set[1];
    phy_uc_pma_int_sts1_10 = fld_set[2];
    phy_uc_pma_int_sts1_11 = fld_set[3];
    phy_uc_pma_int_sts1_12 = fld_set[4];
    phy_uc_pma_int_sts1_13 = fld_set[5];
    phy_uc_pma_int_sts1_14 = fld_set[6];
    phy_uc_pma_int_sts1_15 = fld_set[7];
    phy_uc_pma_int_sts1_16 = fld_set[8];
    phy_uc_pma_int_sts1_17 = fld_set[9];
    phy_uc_pma_int_sts1_18 = fld_set[10];
    phy_uc_pma_int_sts1_19 = fld_set[11];
    phy_uc_pma_int_sts1_20 = fld_set[12];
    phy_uc_pma_int_sts1_21 = fld_set[13];
    phy_uc_pma_int_sts1_22 = fld_set[14];
    phy_uc_pma_int_sts1_23 = fld_set[15];
    phy_uc_pma_int_sts1_24 = fld_set[16];
    phy_uc_pma_int_sts1_25 = fld_set[17];
    phy_uc_pma_int_sts1_26 = fld_set[18];
    phy_uc_pma_int_sts1_28_27 = fld_set[19];
    phy_uc_pma_int_sts1_30_29 = fld_set[20];
    phy_uc_pma_int_sts1_31 = fld_set[21];
  endfunction

  function new(input string name="T_phy_uc_pma_int_sts1_165");
    super.new(name, 32, build_coverage(UVM_CVR_FIELD_VALS));
    if (has_coverage(UVM_CVR_FIELD_VALS)) begin
      wr_fld_covg = new();
      rd_fld_covg = new();
    end
  endfunction

endclass


/////////////////////////////////////////////////////
//                phy_uc_pma_int_sts1_set
/////////////////////////////////////////////////////
class T_phy_uc_pma_int_sts1_set_166 extends cdns_uvm_reg;

  `uvm_object_utils(T_phy_uc_pma_int_sts1_set_166)
  rand uvm_reg_field phy_uc_pma_int_sts1_set_31_0;
  
  covergroup wr_fld_covg;
    phy_uc_pma_int_sts1_set_31_0: coverpoint phy_uc_pma_int_sts1_set_31_0.value[31:0];
  endgroup
  covergroup rd_fld_covg;
    phy_uc_pma_int_sts1_set_31_0: coverpoint phy_uc_pma_int_sts1_set_31_0.value[31:0];
  endgroup

  protected virtual function void sample(uvm_reg_data_t data, uvm_reg_data_t byte_en, bit is_read, uvm_reg_map map);
    super.sample(data, byte_en, is_read, map);
    if (get_coverage(UVM_CVR_FIELD_VALS)) begin
      if(!is_read) begin
          wr_fld_covg.sample();
      end
      if(is_read) begin
         rd_fld_covg.sample();
      end
    end
  endfunction

  virtual function void sample_values();
    super.sample_values();
    if (get_coverage(UVM_CVR_FIELD_VALS)) begin
      wr_fld_covg.sample();
      rd_fld_covg.sample();
    end
  endfunction

  virtual function void build();
    uvm_reg_field fld_set[$];
    uvm_reg_field_config_ta ta = get_field_config(getconfigUID());
    build_uvm_reg_fields(this, ta, fld_set);
    
    phy_uc_pma_int_sts1_set_31_0 = fld_set[0];
  endfunction

  function new(input string name="T_phy_uc_pma_int_sts1_set_166");
    super.new(name, 32, build_coverage(UVM_CVR_FIELD_VALS));
    if (has_coverage(UVM_CVR_FIELD_VALS)) begin
      wr_fld_covg = new();
      rd_fld_covg = new();
    end
  endfunction

endclass


/////////////////////////////////////////////////////
//                phy_uc_pma_int_sts2
/////////////////////////////////////////////////////
class T_phy_uc_pma_int_sts2_169 extends cdns_uvm_reg;

  `uvm_object_utils(T_phy_uc_pma_int_sts2_169)
  rand uvm_reg_field phy_uc_pma_int_sts2_0;
  rand uvm_reg_field phy_uc_pma_int_sts2_1;
  rand uvm_reg_field phy_uc_pma_int_sts2_2;
  rand uvm_reg_field phy_uc_pma_int_sts2_3;
  rand uvm_reg_field phy_uc_pma_int_sts2_31_4;
  
  covergroup wr_fld_covg;
    phy_uc_pma_int_sts2_0: coverpoint phy_uc_pma_int_sts2_0.value[0:0];
    phy_uc_pma_int_sts2_1: coverpoint phy_uc_pma_int_sts2_1.value[0:0];
    phy_uc_pma_int_sts2_2: coverpoint phy_uc_pma_int_sts2_2.value[0:0];
    phy_uc_pma_int_sts2_3: coverpoint phy_uc_pma_int_sts2_3.value[0:0];
    phy_uc_pma_int_sts2_31_4: coverpoint phy_uc_pma_int_sts2_31_4.value[27:0];
  endgroup
  covergroup rd_fld_covg;
    phy_uc_pma_int_sts2_0: coverpoint phy_uc_pma_int_sts2_0.value[0:0];
    phy_uc_pma_int_sts2_1: coverpoint phy_uc_pma_int_sts2_1.value[0:0];
    phy_uc_pma_int_sts2_2: coverpoint phy_uc_pma_int_sts2_2.value[0:0];
    phy_uc_pma_int_sts2_3: coverpoint phy_uc_pma_int_sts2_3.value[0:0];
    phy_uc_pma_int_sts2_31_4: coverpoint phy_uc_pma_int_sts2_31_4.value[27:0];
  endgroup

  protected virtual function void sample(uvm_reg_data_t data, uvm_reg_data_t byte_en, bit is_read, uvm_reg_map map);
    super.sample(data, byte_en, is_read, map);
    if (get_coverage(UVM_CVR_FIELD_VALS)) begin
      if(!is_read) begin
          wr_fld_covg.sample();
      end
      if(is_read) begin
         rd_fld_covg.sample();
      end
    end
  endfunction

  virtual function void sample_values();
    super.sample_values();
    if (get_coverage(UVM_CVR_FIELD_VALS)) begin
      wr_fld_covg.sample();
      rd_fld_covg.sample();
    end
  endfunction

  virtual function void build();
    uvm_reg_field fld_set[$];
    uvm_reg_field_config_ta ta = get_field_config(getconfigUID());
    build_uvm_reg_fields(this, ta, fld_set);
    
    phy_uc_pma_int_sts2_0 = fld_set[0];
    phy_uc_pma_int_sts2_1 = fld_set[1];
    phy_uc_pma_int_sts2_2 = fld_set[2];
    phy_uc_pma_int_sts2_3 = fld_set[3];
    phy_uc_pma_int_sts2_31_4 = fld_set[4];
  endfunction

  function new(input string name="T_phy_uc_pma_int_sts2_169");
    super.new(name, 32, build_coverage(UVM_CVR_FIELD_VALS));
    if (has_coverage(UVM_CVR_FIELD_VALS)) begin
      wr_fld_covg = new();
      rd_fld_covg = new();
    end
  endfunction

endclass


/////////////////////////////////////////////////////
//                phy_uc_pma_int_sts2_set
/////////////////////////////////////////////////////
class T_phy_uc_pma_int_sts2_set_170 extends cdns_uvm_reg;

  `uvm_object_utils(T_phy_uc_pma_int_sts2_set_170)
  rand uvm_reg_field phy_uc_pma_int_sts2_set_31_0;
  
  covergroup wr_fld_covg;
    phy_uc_pma_int_sts2_set_31_0: coverpoint phy_uc_pma_int_sts2_set_31_0.value[31:0];
  endgroup
  covergroup rd_fld_covg;
    phy_uc_pma_int_sts2_set_31_0: coverpoint phy_uc_pma_int_sts2_set_31_0.value[31:0];
  endgroup

  protected virtual function void sample(uvm_reg_data_t data, uvm_reg_data_t byte_en, bit is_read, uvm_reg_map map);
    super.sample(data, byte_en, is_read, map);
    if (get_coverage(UVM_CVR_FIELD_VALS)) begin
      if(!is_read) begin
          wr_fld_covg.sample();
      end
      if(is_read) begin
         rd_fld_covg.sample();
      end
    end
  endfunction

  virtual function void sample_values();
    super.sample_values();
    if (get_coverage(UVM_CVR_FIELD_VALS)) begin
      wr_fld_covg.sample();
      rd_fld_covg.sample();
    end
  endfunction

  virtual function void build();
    uvm_reg_field fld_set[$];
    uvm_reg_field_config_ta ta = get_field_config(getconfigUID());
    build_uvm_reg_fields(this, ta, fld_set);
    
    phy_uc_pma_int_sts2_set_31_0 = fld_set[0];
  endfunction

  function new(input string name="T_phy_uc_pma_int_sts2_set_170");
    super.new(name, 32, build_coverage(UVM_CVR_FIELD_VALS));
    if (has_coverage(UVM_CVR_FIELD_VALS)) begin
      wr_fld_covg = new();
      rd_fld_covg = new();
    end
  endfunction

endclass


/////////////////////////////////////////////////////
//                uc_ln_scrpad10
/////////////////////////////////////////////////////
class T_uc_ln_scrpad10_177 extends cdns_uvm_reg;

  `uvm_object_utils(T_uc_ln_scrpad10_177)
  rand uvm_reg_field uc_ln_scrpad10_31_0;
  
  covergroup wr_fld_covg;
    uc_ln_scrpad10_31_0: coverpoint uc_ln_scrpad10_31_0.value[31:0];
  endgroup
  covergroup rd_fld_covg;
    uc_ln_scrpad10_31_0: coverpoint uc_ln_scrpad10_31_0.value[31:0];
  endgroup

  protected virtual function void sample(uvm_reg_data_t data, uvm_reg_data_t byte_en, bit is_read, uvm_reg_map map);
    super.sample(data, byte_en, is_read, map);
    if (get_coverage(UVM_CVR_FIELD_VALS)) begin
      if(!is_read) begin
          wr_fld_covg.sample();
      end
      if(is_read) begin
         rd_fld_covg.sample();
      end
    end
  endfunction

  virtual function void sample_values();
    super.sample_values();
    if (get_coverage(UVM_CVR_FIELD_VALS)) begin
      wr_fld_covg.sample();
      rd_fld_covg.sample();
    end
  endfunction

  virtual function void build();
    uvm_reg_field fld_set[$];
    uvm_reg_field_config_ta ta = get_field_config(getconfigUID());
    build_uvm_reg_fields(this, ta, fld_set);
    
    uc_ln_scrpad10_31_0 = fld_set[0];
  endfunction

  function new(input string name="T_uc_ln_scrpad10_177");
    super.new(name, 32, build_coverage(UVM_CVR_FIELD_VALS));
    if (has_coverage(UVM_CVR_FIELD_VALS)) begin
      wr_fld_covg = new();
      rd_fld_covg = new();
    end
  endfunction

endclass


/////////////////////////////////////////////////////
//                uc_ln_scrpad11
/////////////////////////////////////////////////////
class T_uc_ln_scrpad11_178 extends cdns_uvm_reg;

  `uvm_object_utils(T_uc_ln_scrpad11_178)
  rand uvm_reg_field uc_ln_scrpad11_31_0;
  
  covergroup wr_fld_covg;
    uc_ln_scrpad11_31_0: coverpoint uc_ln_scrpad11_31_0.value[31:0];
  endgroup
  covergroup rd_fld_covg;
    uc_ln_scrpad11_31_0: coverpoint uc_ln_scrpad11_31_0.value[31:0];
  endgroup

  protected virtual function void sample(uvm_reg_data_t data, uvm_reg_data_t byte_en, bit is_read, uvm_reg_map map);
    super.sample(data, byte_en, is_read, map);
    if (get_coverage(UVM_CVR_FIELD_VALS)) begin
      if(!is_read) begin
          wr_fld_covg.sample();
      end
      if(is_read) begin
         rd_fld_covg.sample();
      end
    end
  endfunction

  virtual function void sample_values();
    super.sample_values();
    if (get_coverage(UVM_CVR_FIELD_VALS)) begin
      wr_fld_covg.sample();
      rd_fld_covg.sample();
    end
  endfunction

  virtual function void build();
    uvm_reg_field fld_set[$];
    uvm_reg_field_config_ta ta = get_field_config(getconfigUID());
    build_uvm_reg_fields(this, ta, fld_set);
    
    uc_ln_scrpad11_31_0 = fld_set[0];
  endfunction

  function new(input string name="T_uc_ln_scrpad11_178");
    super.new(name, 32, build_coverage(UVM_CVR_FIELD_VALS));
    if (has_coverage(UVM_CVR_FIELD_VALS)) begin
      wr_fld_covg = new();
      rd_fld_covg = new();
    end
  endfunction

endclass


/////////////////////////////////////////////////////
//                uc_ln_scrpad12
/////////////////////////////////////////////////////
class T_uc_ln_scrpad12_179 extends cdns_uvm_reg;

  `uvm_object_utils(T_uc_ln_scrpad12_179)
  rand uvm_reg_field uc_ln_scrpad12_31_0;
  
  covergroup wr_fld_covg;
    uc_ln_scrpad12_31_0: coverpoint uc_ln_scrpad12_31_0.value[31:0];
  endgroup
  covergroup rd_fld_covg;
    uc_ln_scrpad12_31_0: coverpoint uc_ln_scrpad12_31_0.value[31:0];
  endgroup

  protected virtual function void sample(uvm_reg_data_t data, uvm_reg_data_t byte_en, bit is_read, uvm_reg_map map);
    super.sample(data, byte_en, is_read, map);
    if (get_coverage(UVM_CVR_FIELD_VALS)) begin
      if(!is_read) begin
          wr_fld_covg.sample();
      end
      if(is_read) begin
         rd_fld_covg.sample();
      end
    end
  endfunction

  virtual function void sample_values();
    super.sample_values();
    if (get_coverage(UVM_CVR_FIELD_VALS)) begin
      wr_fld_covg.sample();
      rd_fld_covg.sample();
    end
  endfunction

  virtual function void build();
    uvm_reg_field fld_set[$];
    uvm_reg_field_config_ta ta = get_field_config(getconfigUID());
    build_uvm_reg_fields(this, ta, fld_set);
    
    uc_ln_scrpad12_31_0 = fld_set[0];
  endfunction

  function new(input string name="T_uc_ln_scrpad12_179");
    super.new(name, 32, build_coverage(UVM_CVR_FIELD_VALS));
    if (has_coverage(UVM_CVR_FIELD_VALS)) begin
      wr_fld_covg = new();
      rd_fld_covg = new();
    end
  endfunction

endclass


/////////////////////////////////////////////////////
//                uc_ln_scrpad13
/////////////////////////////////////////////////////
class T_uc_ln_scrpad13_180 extends cdns_uvm_reg;

  `uvm_object_utils(T_uc_ln_scrpad13_180)
  rand uvm_reg_field uc_ln_scrpad13_31_0;
  
  covergroup wr_fld_covg;
    uc_ln_scrpad13_31_0: coverpoint uc_ln_scrpad13_31_0.value[31:0];
  endgroup
  covergroup rd_fld_covg;
    uc_ln_scrpad13_31_0: coverpoint uc_ln_scrpad13_31_0.value[31:0];
  endgroup

  protected virtual function void sample(uvm_reg_data_t data, uvm_reg_data_t byte_en, bit is_read, uvm_reg_map map);
    super.sample(data, byte_en, is_read, map);
    if (get_coverage(UVM_CVR_FIELD_VALS)) begin
      if(!is_read) begin
          wr_fld_covg.sample();
      end
      if(is_read) begin
         rd_fld_covg.sample();
      end
    end
  endfunction

  virtual function void sample_values();
    super.sample_values();
    if (get_coverage(UVM_CVR_FIELD_VALS)) begin
      wr_fld_covg.sample();
      rd_fld_covg.sample();
    end
  endfunction

  virtual function void build();
    uvm_reg_field fld_set[$];
    uvm_reg_field_config_ta ta = get_field_config(getconfigUID());
    build_uvm_reg_fields(this, ta, fld_set);
    
    uc_ln_scrpad13_31_0 = fld_set[0];
  endfunction

  function new(input string name="T_uc_ln_scrpad13_180");
    super.new(name, 32, build_coverage(UVM_CVR_FIELD_VALS));
    if (has_coverage(UVM_CVR_FIELD_VALS)) begin
      wr_fld_covg = new();
      rd_fld_covg = new();
    end
  endfunction

endclass


/////////////////////////////////////////////////////
//                uc_ln_scrpad14
/////////////////////////////////////////////////////
class T_uc_ln_scrpad14_181 extends cdns_uvm_reg;

  `uvm_object_utils(T_uc_ln_scrpad14_181)
  rand uvm_reg_field uc_ln_scrpad14_31_0;
  
  covergroup wr_fld_covg;
    uc_ln_scrpad14_31_0: coverpoint uc_ln_scrpad14_31_0.value[31:0];
  endgroup
  covergroup rd_fld_covg;
    uc_ln_scrpad14_31_0: coverpoint uc_ln_scrpad14_31_0.value[31:0];
  endgroup

  protected virtual function void sample(uvm_reg_data_t data, uvm_reg_data_t byte_en, bit is_read, uvm_reg_map map);
    super.sample(data, byte_en, is_read, map);
    if (get_coverage(UVM_CVR_FIELD_VALS)) begin
      if(!is_read) begin
          wr_fld_covg.sample();
      end
      if(is_read) begin
         rd_fld_covg.sample();
      end
    end
  endfunction

  virtual function void sample_values();
    super.sample_values();
    if (get_coverage(UVM_CVR_FIELD_VALS)) begin
      wr_fld_covg.sample();
      rd_fld_covg.sample();
    end
  endfunction

  virtual function void build();
    uvm_reg_field fld_set[$];
    uvm_reg_field_config_ta ta = get_field_config(getconfigUID());
    build_uvm_reg_fields(this, ta, fld_set);
    
    uc_ln_scrpad14_31_0 = fld_set[0];
  endfunction

  function new(input string name="T_uc_ln_scrpad14_181");
    super.new(name, 32, build_coverage(UVM_CVR_FIELD_VALS));
    if (has_coverage(UVM_CVR_FIELD_VALS)) begin
      wr_fld_covg = new();
      rd_fld_covg = new();
    end
  endfunction

endclass


/////////////////////////////////////////////////////
//                uc_ln_scrpad15
/////////////////////////////////////////////////////
class T_uc_ln_scrpad15_182 extends cdns_uvm_reg;

  `uvm_object_utils(T_uc_ln_scrpad15_182)
  rand uvm_reg_field uc_ln_scrpad15_31_0;
  
  covergroup wr_fld_covg;
    uc_ln_scrpad15_31_0: coverpoint uc_ln_scrpad15_31_0.value[31:0];
  endgroup
  covergroup rd_fld_covg;
    uc_ln_scrpad15_31_0: coverpoint uc_ln_scrpad15_31_0.value[31:0];
  endgroup

  protected virtual function void sample(uvm_reg_data_t data, uvm_reg_data_t byte_en, bit is_read, uvm_reg_map map);
    super.sample(data, byte_en, is_read, map);
    if (get_coverage(UVM_CVR_FIELD_VALS)) begin
      if(!is_read) begin
          wr_fld_covg.sample();
      end
      if(is_read) begin
         rd_fld_covg.sample();
      end
    end
  endfunction

  virtual function void sample_values();
    super.sample_values();
    if (get_coverage(UVM_CVR_FIELD_VALS)) begin
      wr_fld_covg.sample();
      rd_fld_covg.sample();
    end
  endfunction

  virtual function void build();
    uvm_reg_field fld_set[$];
    uvm_reg_field_config_ta ta = get_field_config(getconfigUID());
    build_uvm_reg_fields(this, ta, fld_set);
    
    uc_ln_scrpad15_31_0 = fld_set[0];
  endfunction

  function new(input string name="T_uc_ln_scrpad15_182");
    super.new(name, 32, build_coverage(UVM_CVR_FIELD_VALS));
    if (has_coverage(UVM_CVR_FIELD_VALS)) begin
      wr_fld_covg = new();
      rd_fld_covg = new();
    end
  endfunction

endclass


/////////////////////////////////////////////////////
//                uc_ln_scrpad8
/////////////////////////////////////////////////////
class T_uc_ln_scrpad8_175 extends cdns_uvm_reg;

  `uvm_object_utils(T_uc_ln_scrpad8_175)
  rand uvm_reg_field uc_ln_scrpad8_31_0;
  
  covergroup wr_fld_covg;
    uc_ln_scrpad8_31_0: coverpoint uc_ln_scrpad8_31_0.value[31:0];
  endgroup
  covergroup rd_fld_covg;
    uc_ln_scrpad8_31_0: coverpoint uc_ln_scrpad8_31_0.value[31:0];
  endgroup

  protected virtual function void sample(uvm_reg_data_t data, uvm_reg_data_t byte_en, bit is_read, uvm_reg_map map);
    super.sample(data, byte_en, is_read, map);
    if (get_coverage(UVM_CVR_FIELD_VALS)) begin
      if(!is_read) begin
          wr_fld_covg.sample();
      end
      if(is_read) begin
         rd_fld_covg.sample();
      end
    end
  endfunction

  virtual function void sample_values();
    super.sample_values();
    if (get_coverage(UVM_CVR_FIELD_VALS)) begin
      wr_fld_covg.sample();
      rd_fld_covg.sample();
    end
  endfunction

  virtual function void build();
    uvm_reg_field fld_set[$];
    uvm_reg_field_config_ta ta = get_field_config(getconfigUID());
    build_uvm_reg_fields(this, ta, fld_set);
    
    uc_ln_scrpad8_31_0 = fld_set[0];
  endfunction

  function new(input string name="T_uc_ln_scrpad8_175");
    super.new(name, 32, build_coverage(UVM_CVR_FIELD_VALS));
    if (has_coverage(UVM_CVR_FIELD_VALS)) begin
      wr_fld_covg = new();
      rd_fld_covg = new();
    end
  endfunction

endclass


/////////////////////////////////////////////////////
//                uc_ln_scrpad9
/////////////////////////////////////////////////////
class T_uc_ln_scrpad9_176 extends cdns_uvm_reg;

  `uvm_object_utils(T_uc_ln_scrpad9_176)
  rand uvm_reg_field uc_ln_scrpad9_31_0;
  
  covergroup wr_fld_covg;
    uc_ln_scrpad9_31_0: coverpoint uc_ln_scrpad9_31_0.value[31:0];
  endgroup
  covergroup rd_fld_covg;
    uc_ln_scrpad9_31_0: coverpoint uc_ln_scrpad9_31_0.value[31:0];
  endgroup

  protected virtual function void sample(uvm_reg_data_t data, uvm_reg_data_t byte_en, bit is_read, uvm_reg_map map);
    super.sample(data, byte_en, is_read, map);
    if (get_coverage(UVM_CVR_FIELD_VALS)) begin
      if(!is_read) begin
          wr_fld_covg.sample();
      end
      if(is_read) begin
         rd_fld_covg.sample();
      end
    end
  endfunction

  virtual function void sample_values();
    super.sample_values();
    if (get_coverage(UVM_CVR_FIELD_VALS)) begin
      wr_fld_covg.sample();
      rd_fld_covg.sample();
    end
  endfunction

  virtual function void build();
    uvm_reg_field fld_set[$];
    uvm_reg_field_config_ta ta = get_field_config(getconfigUID());
    build_uvm_reg_fields(this, ta, fld_set);
    
    uc_ln_scrpad9_31_0 = fld_set[0];
  endfunction

  function new(input string name="T_uc_ln_scrpad9_176");
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
class T_sd3101_phy_registers_183 extends cdns_uvm_reg_block;

  `uvm_object_utils(T_sd3101_phy_registers_183)
  rand T_phy_ln_uc_event_ctr_151 phy_ln_uc_event_ctr;
  rand T_phy_ln_uc_pma_en_int_sts1_171 phy_ln_uc_pma_en_int_sts1;
  rand T_phy_ln_uc_pma_en_int_sts2_173 phy_ln_uc_pma_en_int_sts2;
  rand T_phy_ln_uc_pma_int_sts1_en_167 phy_ln_uc_pma_int_sts1_en;
  rand T_phy_pma_iso_lane_mode_160 phy_pma_iso_lane_mode;
  rand T_phy_pma_iso_rx_data_161 phy_pma_iso_rx_data;
  rand T_phy_pma_iso_tx_data_159 phy_pma_iso_tx_data;
  rand T_phy_pma_iso_tx_deemph_157 phy_pma_iso_tx_deemph;
  rand T_phy_pma_iso_tx_lpc_156 phy_pma_iso_tx_lpc;
  rand T_phy_pma_iso_tx_mgn_158 phy_pma_iso_tx_mgn;
  rand T_phy_pma_iso_xcvr_ctrl_155 phy_pma_iso_xcvr_ctrl;
  rand T_phy_pma_override_162 phy_pma_override;
  rand T_phy_pma_psm_state_152 phy_pma_psm_state;
  rand T_phy_pma_rx_eq_ctrl_153 phy_pma_rx_eq_ctrl;
  rand T_phy_pma_rx_mrgn_ctrl_154 phy_pma_rx_mrgn_ctrl;
  rand T_phy_pma_xcvr_ctrl_sts_163 phy_pma_xcvr_ctrl_sts;
  rand T_phy_pma_xcvr_ctrl_sts_clr_164 phy_pma_xcvr_ctrl_sts_clr;
  rand T_phy_top_uc_pma_en_int_sts1_172 phy_top_uc_pma_en_int_sts1;
  rand T_phy_top_uc_pma_en_int_sts2_174 phy_top_uc_pma_en_int_sts2;
  rand T_phy_top_uc_pma_int_sts1_en_168 phy_top_uc_pma_int_sts1_en;
  rand T_phy_uc_pma_int_sts1_165 phy_uc_pma_int_sts1;
  rand T_phy_uc_pma_int_sts1_set_166 phy_uc_pma_int_sts1_set;
  rand T_phy_uc_pma_int_sts2_169 phy_uc_pma_int_sts2;
  rand T_phy_uc_pma_int_sts2_set_170 phy_uc_pma_int_sts2_set;
  rand T_uc_ln_scrpad10_177 uc_ln_scrpad10;
  rand T_uc_ln_scrpad11_178 uc_ln_scrpad11;
  rand T_uc_ln_scrpad12_179 uc_ln_scrpad12;
  rand T_uc_ln_scrpad13_180 uc_ln_scrpad13;
  rand T_uc_ln_scrpad14_181 uc_ln_scrpad14;
  rand T_uc_ln_scrpad15_182 uc_ln_scrpad15;
  rand T_uc_ln_scrpad8_175 uc_ln_scrpad8;
  rand T_uc_ln_scrpad9_176 uc_ln_scrpad9;



  virtual function void build();
    uvm_reg  reg_set[$];
    string config_path = get_hier_path();
    default_map = create_map(get_name(), `UVM_REG_ADDR_WIDTH'h3C000, 4, UVM_LITTLE_ENDIAN, 1);
    begin
       uvm_reg_config_ta ta = get_reg_config("phy_pma_lane_registers.sd3101_t4_registers_sd3101_phy_registers");
       build_uvm_regs(default_map, this, null, ta, reg_set);
    end
    if(! $cast(phy_ln_uc_event_ctr, reg_set[0]))
      `uvm_error("UVM_REG", "phy_ln_uc_event_ctr register casting error")
    if(! $cast(phy_ln_uc_pma_en_int_sts1, reg_set[1]))
      `uvm_error("UVM_REG", "phy_ln_uc_pma_en_int_sts1 register casting error")
    if(! $cast(phy_ln_uc_pma_en_int_sts2, reg_set[2]))
      `uvm_error("UVM_REG", "phy_ln_uc_pma_en_int_sts2 register casting error")
    if(! $cast(phy_ln_uc_pma_int_sts1_en, reg_set[3]))
      `uvm_error("UVM_REG", "phy_ln_uc_pma_int_sts1_en register casting error")
    if(! $cast(phy_pma_iso_lane_mode, reg_set[4]))
      `uvm_error("UVM_REG", "phy_pma_iso_lane_mode register casting error")
    if(! $cast(phy_pma_iso_rx_data, reg_set[5]))
      `uvm_error("UVM_REG", "phy_pma_iso_rx_data register casting error")
    if(! $cast(phy_pma_iso_tx_data, reg_set[6]))
      `uvm_error("UVM_REG", "phy_pma_iso_tx_data register casting error")
    if(! $cast(phy_pma_iso_tx_deemph, reg_set[7]))
      `uvm_error("UVM_REG", "phy_pma_iso_tx_deemph register casting error")
    if(! $cast(phy_pma_iso_tx_lpc, reg_set[8]))
      `uvm_error("UVM_REG", "phy_pma_iso_tx_lpc register casting error")
    if(! $cast(phy_pma_iso_tx_mgn, reg_set[9]))
      `uvm_error("UVM_REG", "phy_pma_iso_tx_mgn register casting error")
    if(! $cast(phy_pma_iso_xcvr_ctrl, reg_set[10]))
      `uvm_error("UVM_REG", "phy_pma_iso_xcvr_ctrl register casting error")
    if(! $cast(phy_pma_override, reg_set[11]))
      `uvm_error("UVM_REG", "phy_pma_override register casting error")
    if(! $cast(phy_pma_psm_state, reg_set[12]))
      `uvm_error("UVM_REG", "phy_pma_psm_state register casting error")
    if(! $cast(phy_pma_rx_eq_ctrl, reg_set[13]))
      `uvm_error("UVM_REG", "phy_pma_rx_eq_ctrl register casting error")
    if(! $cast(phy_pma_rx_mrgn_ctrl, reg_set[14]))
      `uvm_error("UVM_REG", "phy_pma_rx_mrgn_ctrl register casting error")
    if(! $cast(phy_pma_xcvr_ctrl_sts, reg_set[15]))
      `uvm_error("UVM_REG", "phy_pma_xcvr_ctrl_sts register casting error")
    if(! $cast(phy_pma_xcvr_ctrl_sts_clr, reg_set[16]))
      `uvm_error("UVM_REG", "phy_pma_xcvr_ctrl_sts_clr register casting error")
    if(! $cast(phy_top_uc_pma_en_int_sts1, reg_set[17]))
      `uvm_error("UVM_REG", "phy_top_uc_pma_en_int_sts1 register casting error")
    if(! $cast(phy_top_uc_pma_en_int_sts2, reg_set[18]))
      `uvm_error("UVM_REG", "phy_top_uc_pma_en_int_sts2 register casting error")
    if(! $cast(phy_top_uc_pma_int_sts1_en, reg_set[19]))
      `uvm_error("UVM_REG", "phy_top_uc_pma_int_sts1_en register casting error")
    if(! $cast(phy_uc_pma_int_sts1, reg_set[20]))
      `uvm_error("UVM_REG", "phy_uc_pma_int_sts1 register casting error")
    if(! $cast(phy_uc_pma_int_sts1_set, reg_set[21]))
      `uvm_error("UVM_REG", "phy_uc_pma_int_sts1_set register casting error")
    if(! $cast(phy_uc_pma_int_sts2, reg_set[22]))
      `uvm_error("UVM_REG", "phy_uc_pma_int_sts2 register casting error")
    if(! $cast(phy_uc_pma_int_sts2_set, reg_set[23]))
      `uvm_error("UVM_REG", "phy_uc_pma_int_sts2_set register casting error")
    if(! $cast(uc_ln_scrpad10, reg_set[24]))
      `uvm_error("UVM_REG", "uc_ln_scrpad10 register casting error")
    if(! $cast(uc_ln_scrpad11, reg_set[25]))
      `uvm_error("UVM_REG", "uc_ln_scrpad11 register casting error")
    if(! $cast(uc_ln_scrpad12, reg_set[26]))
      `uvm_error("UVM_REG", "uc_ln_scrpad12 register casting error")
    if(! $cast(uc_ln_scrpad13, reg_set[27]))
      `uvm_error("UVM_REG", "uc_ln_scrpad13 register casting error")
    if(! $cast(uc_ln_scrpad14, reg_set[28]))
      `uvm_error("UVM_REG", "uc_ln_scrpad14 register casting error")
    if(! $cast(uc_ln_scrpad15, reg_set[29]))
      `uvm_error("UVM_REG", "uc_ln_scrpad15 register casting error")
    if(! $cast(uc_ln_scrpad8, reg_set[30]))
      `uvm_error("UVM_REG", "uc_ln_scrpad8 register casting error")
    if(! $cast(uc_ln_scrpad9, reg_set[31]))
      `uvm_error("UVM_REG", "uc_ln_scrpad9 register casting error")

  endfunction

  function new(input string name="sd3101_t4_registers_sd3101_phy_registers");
    super.new(name, UVM_NO_COVERAGE);
  endfunction

endclass


/////////////////////////////////////////////////////
//                phy_pma_lane_registers
/////////////////////////////////////////////////////
class phy_pma_lane_registers_vendor_cadence_library_cdns_lib_version_1685_2009 extends cdns_uvm_reg_block;

  `uvm_object_utils(phy_pma_lane_registers_vendor_cadence_library_cdns_lib_version_1685_2009)

  uvm_reg_map default_map;
  uvm_reg_map sd3101_t4_registers;
  rand T_sd3101_phy_registers_183 sd3101_t4_registers_sd3101_phy_registers;

`include "cdn_regmodel_task_member.sv"
  virtual function void build();
    sd3101_t4_registers = create_map("sd3101_t4_registers", `UVM_REG_ADDR_WIDTH'h0, 4, UVM_LITTLE_ENDIAN, 1);
    default_map = sd3101_t4_registers;
    sd3101_t4_registers_sd3101_phy_registers = T_sd3101_phy_registers_183::type_id::create("sd3101_t4_registers_sd3101_phy_registers", , get_full_name());
    sd3101_t4_registers_sd3101_phy_registers.configure(this);
    sd3101_t4_registers_sd3101_phy_registers.build();

    //Mapping sd3101_t4_registers map
    sd3101_t4_registers_sd3101_phy_registers.default_map.add_parent_map(sd3101_t4_registers,`UVM_REG_ADDR_WIDTH'h3C000);
    sd3101_t4_registers.set_submap_offset(sd3101_t4_registers_sd3101_phy_registers.default_map, `UVM_REG_ADDR_WIDTH'h3C000);
    //Apply hdl_paths
    apply_hdl_paths(this);

  endfunction



  function new(input string name="phy_pma_lane_registers");
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
         "T_phy_ln_uc_event_ctr_151": begin T_phy_ln_uc_event_ctr_151 phy_ln_uc_event_ctr = new(objectname); create = phy_ln_uc_event_ctr;  end
         "T_phy_ln_uc_pma_en_int_sts1_171": begin T_phy_ln_uc_pma_en_int_sts1_171 phy_ln_uc_pma_en_int_sts1 = new(objectname); create = phy_ln_uc_pma_en_int_sts1;  end
         "T_phy_ln_uc_pma_en_int_sts2_173": begin T_phy_ln_uc_pma_en_int_sts2_173 phy_ln_uc_pma_en_int_sts2 = new(objectname); create = phy_ln_uc_pma_en_int_sts2;  end
         "T_phy_ln_uc_pma_int_sts1_en_167": begin T_phy_ln_uc_pma_int_sts1_en_167 phy_ln_uc_pma_int_sts1_en = new(objectname); create = phy_ln_uc_pma_int_sts1_en;  end
         "T_phy_pma_iso_lane_mode_160": begin T_phy_pma_iso_lane_mode_160 phy_pma_iso_lane_mode = new(objectname); create = phy_pma_iso_lane_mode;  end
         "T_phy_pma_iso_rx_data_161": begin T_phy_pma_iso_rx_data_161 phy_pma_iso_rx_data = new(objectname); create = phy_pma_iso_rx_data;  end
         "T_phy_pma_iso_tx_data_159": begin T_phy_pma_iso_tx_data_159 phy_pma_iso_tx_data = new(objectname); create = phy_pma_iso_tx_data;  end
         "T_phy_pma_iso_tx_deemph_157": begin T_phy_pma_iso_tx_deemph_157 phy_pma_iso_tx_deemph = new(objectname); create = phy_pma_iso_tx_deemph;  end
         "T_phy_pma_iso_tx_lpc_156": begin T_phy_pma_iso_tx_lpc_156 phy_pma_iso_tx_lpc = new(objectname); create = phy_pma_iso_tx_lpc;  end
         "T_phy_pma_iso_tx_mgn_158": begin T_phy_pma_iso_tx_mgn_158 phy_pma_iso_tx_mgn = new(objectname); create = phy_pma_iso_tx_mgn;  end
         "T_phy_pma_iso_xcvr_ctrl_155": begin T_phy_pma_iso_xcvr_ctrl_155 phy_pma_iso_xcvr_ctrl = new(objectname); create = phy_pma_iso_xcvr_ctrl;  end
         "T_phy_pma_override_162": begin T_phy_pma_override_162 phy_pma_override = new(objectname); create = phy_pma_override;  end
         "T_phy_pma_psm_state_152": begin T_phy_pma_psm_state_152 phy_pma_psm_state = new(objectname); create = phy_pma_psm_state;  end
         "T_phy_pma_rx_eq_ctrl_153": begin T_phy_pma_rx_eq_ctrl_153 phy_pma_rx_eq_ctrl = new(objectname); create = phy_pma_rx_eq_ctrl;  end
         "T_phy_pma_rx_mrgn_ctrl_154": begin T_phy_pma_rx_mrgn_ctrl_154 phy_pma_rx_mrgn_ctrl = new(objectname); create = phy_pma_rx_mrgn_ctrl;  end
         "T_phy_pma_xcvr_ctrl_sts_163": begin T_phy_pma_xcvr_ctrl_sts_163 phy_pma_xcvr_ctrl_sts = new(objectname); create = phy_pma_xcvr_ctrl_sts;  end
         "T_phy_pma_xcvr_ctrl_sts_clr_164": begin T_phy_pma_xcvr_ctrl_sts_clr_164 phy_pma_xcvr_ctrl_sts_clr = new(objectname); create = phy_pma_xcvr_ctrl_sts_clr;  end
         "T_phy_top_uc_pma_en_int_sts1_172": begin T_phy_top_uc_pma_en_int_sts1_172 phy_top_uc_pma_en_int_sts1 = new(objectname); create = phy_top_uc_pma_en_int_sts1;  end
         "T_phy_top_uc_pma_en_int_sts2_174": begin T_phy_top_uc_pma_en_int_sts2_174 phy_top_uc_pma_en_int_sts2 = new(objectname); create = phy_top_uc_pma_en_int_sts2;  end
         "T_phy_top_uc_pma_int_sts1_en_168": begin T_phy_top_uc_pma_int_sts1_en_168 phy_top_uc_pma_int_sts1_en = new(objectname); create = phy_top_uc_pma_int_sts1_en;  end
         "T_phy_uc_pma_int_sts1_165": begin T_phy_uc_pma_int_sts1_165 phy_uc_pma_int_sts1 = new(objectname); create = phy_uc_pma_int_sts1;  end
         "T_phy_uc_pma_int_sts1_set_166": begin T_phy_uc_pma_int_sts1_set_166 phy_uc_pma_int_sts1_set = new(objectname); create = phy_uc_pma_int_sts1_set;  end
         "T_phy_uc_pma_int_sts2_169": begin T_phy_uc_pma_int_sts2_169 phy_uc_pma_int_sts2 = new(objectname); create = phy_uc_pma_int_sts2;  end
         "T_phy_uc_pma_int_sts2_set_170": begin T_phy_uc_pma_int_sts2_set_170 phy_uc_pma_int_sts2_set = new(objectname); create = phy_uc_pma_int_sts2_set;  end
         "T_uc_ln_scrpad10_177": begin T_uc_ln_scrpad10_177 uc_ln_scrpad10 = new(objectname); create = uc_ln_scrpad10;  end
         "T_uc_ln_scrpad11_178": begin T_uc_ln_scrpad11_178 uc_ln_scrpad11 = new(objectname); create = uc_ln_scrpad11;  end
         "T_uc_ln_scrpad12_179": begin T_uc_ln_scrpad12_179 uc_ln_scrpad12 = new(objectname); create = uc_ln_scrpad12;  end
         "T_uc_ln_scrpad13_180": begin T_uc_ln_scrpad13_180 uc_ln_scrpad13 = new(objectname); create = uc_ln_scrpad13;  end
         "T_uc_ln_scrpad14_181": begin T_uc_ln_scrpad14_181 uc_ln_scrpad14 = new(objectname); create = uc_ln_scrpad14;  end
         "T_uc_ln_scrpad15_182": begin T_uc_ln_scrpad15_182 uc_ln_scrpad15 = new(objectname); create = uc_ln_scrpad15;  end
         "T_uc_ln_scrpad8_175": begin T_uc_ln_scrpad8_175 uc_ln_scrpad8 = new(objectname); create = uc_ln_scrpad8;  end
         "T_uc_ln_scrpad9_176": begin T_uc_ln_scrpad9_176 uc_ln_scrpad9 = new(objectname); create = uc_ln_scrpad9;  end

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
   cdns_uvmreg_utils_pkg_phy_pma_lane_registers::factory=cdns_factory;


   return cdns_factory;
endfunction
cdns_factory_base cdns_factory = get_factory(no_factory);

endpackage



