//*************************************************************//
//   ** File Generated Automatically
//   ** Please donot edit manually
//*************************************************************//


package cdn_phy_pma_cmn_reg_pkg;
  import uvm_pkg::*;
  `include "uvm_macros.svh"
  import cdns_uvmreg_utils_pkg_phy_pma_cmn_registers::*;

  bit no_factory = 0; 

/////////////////////////////////////////////////////
//                dtb_ctrl
/////////////////////////////////////////////////////
class T_dtb_ctrl_119 extends cdns_uvm_reg;

  `uvm_object_utils(T_dtb_ctrl_119)
  rand uvm_reg_field dtb_ctrl_5_0;
  rand uvm_reg_field dtb_ctrl_15_6;
  rand uvm_reg_field dtb_ctrl_19_16;
  rand uvm_reg_field dtb_ctrl_23_20;
  rand uvm_reg_field dtb_ctrl_24;
  rand uvm_reg_field dtb_ctrl_31_25;
  
  covergroup wr_fld_covg;
    dtb_ctrl_5_0: coverpoint dtb_ctrl_5_0.value[5:0];
    dtb_ctrl_15_6: coverpoint dtb_ctrl_15_6.value[9:0];
    dtb_ctrl_19_16: coverpoint dtb_ctrl_19_16.value[3:0];
    dtb_ctrl_23_20: coverpoint dtb_ctrl_23_20.value[3:0];
    dtb_ctrl_24: coverpoint dtb_ctrl_24.value[0:0];
    dtb_ctrl_31_25: coverpoint dtb_ctrl_31_25.value[6:0];
  endgroup
  covergroup rd_fld_covg;
    dtb_ctrl_5_0: coverpoint dtb_ctrl_5_0.value[5:0];
    dtb_ctrl_15_6: coverpoint dtb_ctrl_15_6.value[9:0];
    dtb_ctrl_19_16: coverpoint dtb_ctrl_19_16.value[3:0];
    dtb_ctrl_23_20: coverpoint dtb_ctrl_23_20.value[3:0];
    dtb_ctrl_24: coverpoint dtb_ctrl_24.value[0:0];
    dtb_ctrl_31_25: coverpoint dtb_ctrl_31_25.value[6:0];
  endgroup

  protected virtual function void sample(uvm_reg_data_t data, uvm_reg_data_t byte_en, bit is_read, uvm_reg_map map);
    super.sample(data, byte_en, is_read, map);
    if (get_coverage(UVM_CVR_FIELD_VALS)) begin
      if(!is_read) begin
          wr_fld_covg.sample();
      end
      if(is_read) begin
         rd_fld_covg.sample();
      end
    end
  endfunction

  virtual function void sample_values();
    super.sample_values();
    if (get_coverage(UVM_CVR_FIELD_VALS)) begin
      wr_fld_covg.sample();
      rd_fld_covg.sample();
    end
  endfunction

  virtual function void build();
    uvm_reg_field fld_set[$];
    uvm_reg_field_config_ta ta = get_field_config(getconfigUID());
    build_uvm_reg_fields(this, ta, fld_set);
    
    dtb_ctrl_5_0 = fld_set[0];
    dtb_ctrl_15_6 = fld_set[1];
    dtb_ctrl_19_16 = fld_set[2];
    dtb_ctrl_23_20 = fld_set[3];
    dtb_ctrl_24 = fld_set[4];
    dtb_ctrl_31_25 = fld_set[5];
  endfunction

  function new(input string name="T_dtb_ctrl_119");
    super.new(name, 32, build_coverage(UVM_CVR_FIELD_VALS));
    if (has_coverage(UVM_CVR_FIELD_VALS)) begin
      wr_fld_covg = new();
      rd_fld_covg = new();
    end
  endfunction

endclass


/////////////////////////////////////////////////////
//                dtb_data
/////////////////////////////////////////////////////
class T_dtb_data_120 extends cdns_uvm_reg;

  `uvm_object_utils(T_dtb_data_120)
  rand uvm_reg_field dtb_data_31_0;
  
  covergroup wr_fld_covg;
    dtb_data_31_0: coverpoint dtb_data_31_0.value[31:0];
  endgroup
  covergroup rd_fld_covg;
    dtb_data_31_0: coverpoint dtb_data_31_0.value[31:0];
  endgroup

  protected virtual function void sample(uvm_reg_data_t data, uvm_reg_data_t byte_en, bit is_read, uvm_reg_map map);
    super.sample(data, byte_en, is_read, map);
    if (get_coverage(UVM_CVR_FIELD_VALS)) begin
      if(!is_read) begin
          wr_fld_covg.sample();
      end
      if(is_read) begin
         rd_fld_covg.sample();
      end
    end
  endfunction

  virtual function void sample_values();
    super.sample_values();
    if (get_coverage(UVM_CVR_FIELD_VALS)) begin
      wr_fld_covg.sample();
      rd_fld_covg.sample();
    end
  endfunction

  virtual function void build();
    uvm_reg_field fld_set[$];
    uvm_reg_field_config_ta ta = get_field_config(getconfigUID());
    build_uvm_reg_fields(this, ta, fld_set);
    
    dtb_data_31_0 = fld_set[0];
  endfunction

  function new(input string name="T_dtb_data_120");
    super.new(name, 32, build_coverage(UVM_CVR_FIELD_VALS));
    if (has_coverage(UVM_CVR_FIELD_VALS)) begin
      wr_fld_covg = new();
      rd_fld_covg = new();
    end
  endfunction

endclass


/////////////////////////////////////////////////////
//                phy_isolation_ctrl
/////////////////////////////////////////////////////
class T_phy_isolation_ctrl_121 extends cdns_uvm_reg;

  `uvm_object_utils(T_phy_isolation_ctrl_121)
  rand uvm_reg_field phy_isolation_ctrl_15_0;
  rand uvm_reg_field phy_isolation_ctrl_16;
  rand uvm_reg_field phy_isolation_ctrl_17;
  rand uvm_reg_field phy_isolation_ctrl_18;
  rand uvm_reg_field phy_isolation_ctrl_19;
  rand uvm_reg_field phy_isolation_ctrl_20;
  rand uvm_reg_field phy_isolation_ctrl_21;
  rand uvm_reg_field phy_isolation_ctrl_31_22;
  
  covergroup wr_fld_covg;
    phy_isolation_ctrl_15_0: coverpoint phy_isolation_ctrl_15_0.value[15:0];
    phy_isolation_ctrl_16: coverpoint phy_isolation_ctrl_16.value[0:0];
    phy_isolation_ctrl_17: coverpoint phy_isolation_ctrl_17.value[0:0];
    phy_isolation_ctrl_18: coverpoint phy_isolation_ctrl_18.value[0:0];
    phy_isolation_ctrl_19: coverpoint phy_isolation_ctrl_19.value[0:0];
    phy_isolation_ctrl_20: coverpoint phy_isolation_ctrl_20.value[0:0];
    phy_isolation_ctrl_21: coverpoint phy_isolation_ctrl_21.value[0:0];
    phy_isolation_ctrl_31_22: coverpoint phy_isolation_ctrl_31_22.value[9:0];
  endgroup
  covergroup rd_fld_covg;
    phy_isolation_ctrl_15_0: coverpoint phy_isolation_ctrl_15_0.value[15:0];
    phy_isolation_ctrl_16: coverpoint phy_isolation_ctrl_16.value[0:0];
    phy_isolation_ctrl_17: coverpoint phy_isolation_ctrl_17.value[0:0];
    phy_isolation_ctrl_18: coverpoint phy_isolation_ctrl_18.value[0:0];
    phy_isolation_ctrl_19: coverpoint phy_isolation_ctrl_19.value[0:0];
    phy_isolation_ctrl_20: coverpoint phy_isolation_ctrl_20.value[0:0];
    phy_isolation_ctrl_21: coverpoint phy_isolation_ctrl_21.value[0:0];
    phy_isolation_ctrl_31_22: coverpoint phy_isolation_ctrl_31_22.value[9:0];
  endgroup

  protected virtual function void sample(uvm_reg_data_t data, uvm_reg_data_t byte_en, bit is_read, uvm_reg_map map);
    super.sample(data, byte_en, is_read, map);
    if (get_coverage(UVM_CVR_FIELD_VALS)) begin
      if(!is_read) begin
          wr_fld_covg.sample();
      end
      if(is_read) begin
         rd_fld_covg.sample();
      end
    end
  endfunction

  virtual function void sample_values();
    super.sample_values();
    if (get_coverage(UVM_CVR_FIELD_VALS)) begin
      wr_fld_covg.sample();
      rd_fld_covg.sample();
    end
  endfunction

  virtual function void build();
    uvm_reg_field fld_set[$];
    uvm_reg_field_config_ta ta = get_field_config(getconfigUID());
    build_uvm_reg_fields(this, ta, fld_set);
    
    phy_isolation_ctrl_15_0 = fld_set[0];
    phy_isolation_ctrl_16 = fld_set[1];
    phy_isolation_ctrl_17 = fld_set[2];
    phy_isolation_ctrl_18 = fld_set[3];
    phy_isolation_ctrl_19 = fld_set[4];
    phy_isolation_ctrl_20 = fld_set[5];
    phy_isolation_ctrl_21 = fld_set[6];
    phy_isolation_ctrl_31_22 = fld_set[7];
  endfunction

  function new(input string name="T_phy_isolation_ctrl_121");
    super.new(name, 32, build_coverage(UVM_CVR_FIELD_VALS));
    if (has_coverage(UVM_CVR_FIELD_VALS)) begin
      wr_fld_covg = new();
      rd_fld_covg = new();
    end
  endfunction

endclass


/////////////////////////////////////////////////////
//                phy_pma_cmn_ctrl_sts
/////////////////////////////////////////////////////
class T_phy_pma_cmn_ctrl_sts_112 extends cdns_uvm_reg;

  `uvm_object_utils(T_phy_pma_cmn_ctrl_sts_112)
  rand uvm_reg_field phy_pma_cmn_ctrl_sts_0;
  rand uvm_reg_field phy_pma_cmn_ctrl_sts_1;
  rand uvm_reg_field phy_pma_cmn_ctrl_sts_2;
  rand uvm_reg_field phy_pma_cmn_ctrl_sts_3;
  rand uvm_reg_field phy_pma_cmn_ctrl_sts_4;
  rand uvm_reg_field phy_pma_cmn_ctrl_sts_5;
  rand uvm_reg_field phy_pma_cmn_ctrl_sts_6;
  rand uvm_reg_field phy_pma_cmn_ctrl_sts_7;
  rand uvm_reg_field phy_pma_cmn_ctrl_sts_8;
  rand uvm_reg_field phy_pma_cmn_ctrl_sts_9;
  rand uvm_reg_field phy_pma_cmn_ctrl_sts_10;
  rand uvm_reg_field phy_pma_cmn_ctrl_sts_11;
  rand uvm_reg_field phy_pma_cmn_ctrl_sts_12;
  rand uvm_reg_field phy_pma_cmn_ctrl_sts_13;
  rand uvm_reg_field phy_pma_cmn_ctrl_sts_14;
  rand uvm_reg_field phy_pma_cmn_ctrl_sts_15;
  rand uvm_reg_field phy_pma_cmn_ctrl_sts_16;
  rand uvm_reg_field phy_pma_cmn_ctrl_sts_17;
  rand uvm_reg_field phy_pma_cmn_ctrl_sts_18;
  rand uvm_reg_field phy_pma_cmn_ctrl_sts_19;
  rand uvm_reg_field phy_pma_cmn_ctrl_sts_20;
  rand uvm_reg_field phy_pma_cmn_ctrl_sts_21;
  rand uvm_reg_field phy_pma_cmn_ctrl_sts_23_22;
  rand uvm_reg_field phy_pma_cmn_ctrl_sts_24;
  rand uvm_reg_field phy_pma_cmn_ctrl_sts_25;
  rand uvm_reg_field phy_pma_cmn_ctrl_sts_27_26;
  rand uvm_reg_field phy_pma_cmn_ctrl_sts_28;
  rand uvm_reg_field phy_pma_cmn_ctrl_sts_31_29;
  
  covergroup wr_fld_covg;
    phy_pma_cmn_ctrl_sts_0: coverpoint phy_pma_cmn_ctrl_sts_0.value[0:0];
    phy_pma_cmn_ctrl_sts_1: coverpoint phy_pma_cmn_ctrl_sts_1.value[0:0];
    phy_pma_cmn_ctrl_sts_2: coverpoint phy_pma_cmn_ctrl_sts_2.value[0:0];
    phy_pma_cmn_ctrl_sts_3: coverpoint phy_pma_cmn_ctrl_sts_3.value[0:0];
    phy_pma_cmn_ctrl_sts_4: coverpoint phy_pma_cmn_ctrl_sts_4.value[0:0];
    phy_pma_cmn_ctrl_sts_5: coverpoint phy_pma_cmn_ctrl_sts_5.value[0:0];
    phy_pma_cmn_ctrl_sts_6: coverpoint phy_pma_cmn_ctrl_sts_6.value[0:0];
    phy_pma_cmn_ctrl_sts_7: coverpoint phy_pma_cmn_ctrl_sts_7.value[0:0];
    phy_pma_cmn_ctrl_sts_8: coverpoint phy_pma_cmn_ctrl_sts_8.value[0:0];
    phy_pma_cmn_ctrl_sts_9: coverpoint phy_pma_cmn_ctrl_sts_9.value[0:0];
    phy_pma_cmn_ctrl_sts_10: coverpoint phy_pma_cmn_ctrl_sts_10.value[0:0];
    phy_pma_cmn_ctrl_sts_11: coverpoint phy_pma_cmn_ctrl_sts_11.value[0:0];
    phy_pma_cmn_ctrl_sts_12: coverpoint phy_pma_cmn_ctrl_sts_12.value[0:0];
    phy_pma_cmn_ctrl_sts_13: coverpoint phy_pma_cmn_ctrl_sts_13.value[0:0];
    phy_pma_cmn_ctrl_sts_14: coverpoint phy_pma_cmn_ctrl_sts_14.value[0:0];
    phy_pma_cmn_ctrl_sts_15: coverpoint phy_pma_cmn_ctrl_sts_15.value[0:0];
    phy_pma_cmn_ctrl_sts_16: coverpoint phy_pma_cmn_ctrl_sts_16.value[0:0];
    phy_pma_cmn_ctrl_sts_17: coverpoint phy_pma_cmn_ctrl_sts_17.value[0:0];
    phy_pma_cmn_ctrl_sts_18: coverpoint phy_pma_cmn_ctrl_sts_18.value[0:0];
    phy_pma_cmn_ctrl_sts_19: coverpoint phy_pma_cmn_ctrl_sts_19.value[0:0];
    phy_pma_cmn_ctrl_sts_20: coverpoint phy_pma_cmn_ctrl_sts_20.value[0:0];
    phy_pma_cmn_ctrl_sts_21: coverpoint phy_pma_cmn_ctrl_sts_21.value[0:0];
    phy_pma_cmn_ctrl_sts_23_22: coverpoint phy_pma_cmn_ctrl_sts_23_22.value[1:0];
    phy_pma_cmn_ctrl_sts_24: coverpoint phy_pma_cmn_ctrl_sts_24.value[0:0];
    phy_pma_cmn_ctrl_sts_25: coverpoint phy_pma_cmn_ctrl_sts_25.value[0:0];
    phy_pma_cmn_ctrl_sts_27_26: coverpoint phy_pma_cmn_ctrl_sts_27_26.value[1:0];
    phy_pma_cmn_ctrl_sts_28: coverpoint phy_pma_cmn_ctrl_sts_28.value[0:0];
    phy_pma_cmn_ctrl_sts_31_29: coverpoint phy_pma_cmn_ctrl_sts_31_29.value[2:0];
  endgroup
  covergroup rd_fld_covg;
    phy_pma_cmn_ctrl_sts_0: coverpoint phy_pma_cmn_ctrl_sts_0.value[0:0];
    phy_pma_cmn_ctrl_sts_1: coverpoint phy_pma_cmn_ctrl_sts_1.value[0:0];
    phy_pma_cmn_ctrl_sts_2: coverpoint phy_pma_cmn_ctrl_sts_2.value[0:0];
    phy_pma_cmn_ctrl_sts_3: coverpoint phy_pma_cmn_ctrl_sts_3.value[0:0];
    phy_pma_cmn_ctrl_sts_4: coverpoint phy_pma_cmn_ctrl_sts_4.value[0:0];
    phy_pma_cmn_ctrl_sts_5: coverpoint phy_pma_cmn_ctrl_sts_5.value[0:0];
    phy_pma_cmn_ctrl_sts_6: coverpoint phy_pma_cmn_ctrl_sts_6.value[0:0];
    phy_pma_cmn_ctrl_sts_7: coverpoint phy_pma_cmn_ctrl_sts_7.value[0:0];
    phy_pma_cmn_ctrl_sts_8: coverpoint phy_pma_cmn_ctrl_sts_8.value[0:0];
    phy_pma_cmn_ctrl_sts_9: coverpoint phy_pma_cmn_ctrl_sts_9.value[0:0];
    phy_pma_cmn_ctrl_sts_10: coverpoint phy_pma_cmn_ctrl_sts_10.value[0:0];
    phy_pma_cmn_ctrl_sts_11: coverpoint phy_pma_cmn_ctrl_sts_11.value[0:0];
    phy_pma_cmn_ctrl_sts_12: coverpoint phy_pma_cmn_ctrl_sts_12.value[0:0];
    phy_pma_cmn_ctrl_sts_13: coverpoint phy_pma_cmn_ctrl_sts_13.value[0:0];
    phy_pma_cmn_ctrl_sts_14: coverpoint phy_pma_cmn_ctrl_sts_14.value[0:0];
    phy_pma_cmn_ctrl_sts_15: coverpoint phy_pma_cmn_ctrl_sts_15.value[0:0];
    phy_pma_cmn_ctrl_sts_16: coverpoint phy_pma_cmn_ctrl_sts_16.value[0:0];
    phy_pma_cmn_ctrl_sts_17: coverpoint phy_pma_cmn_ctrl_sts_17.value[0:0];
    phy_pma_cmn_ctrl_sts_18: coverpoint phy_pma_cmn_ctrl_sts_18.value[0:0];
    phy_pma_cmn_ctrl_sts_19: coverpoint phy_pma_cmn_ctrl_sts_19.value[0:0];
    phy_pma_cmn_ctrl_sts_20: coverpoint phy_pma_cmn_ctrl_sts_20.value[0:0];
    phy_pma_cmn_ctrl_sts_21: coverpoint phy_pma_cmn_ctrl_sts_21.value[0:0];
    phy_pma_cmn_ctrl_sts_23_22: coverpoint phy_pma_cmn_ctrl_sts_23_22.value[1:0];
    phy_pma_cmn_ctrl_sts_24: coverpoint phy_pma_cmn_ctrl_sts_24.value[0:0];
    phy_pma_cmn_ctrl_sts_25: coverpoint phy_pma_cmn_ctrl_sts_25.value[0:0];
    phy_pma_cmn_ctrl_sts_27_26: coverpoint phy_pma_cmn_ctrl_sts_27_26.value[1:0];
    phy_pma_cmn_ctrl_sts_28: coverpoint phy_pma_cmn_ctrl_sts_28.value[0:0];
    phy_pma_cmn_ctrl_sts_31_29: coverpoint phy_pma_cmn_ctrl_sts_31_29.value[2:0];
  endgroup

  protected virtual function void sample(uvm_reg_data_t data, uvm_reg_data_t byte_en, bit is_read, uvm_reg_map map);
    super.sample(data, byte_en, is_read, map);
    if (get_coverage(UVM_CVR_FIELD_VALS)) begin
      if(!is_read) begin
          wr_fld_covg.sample();
      end
      if(is_read) begin
         rd_fld_covg.sample();
      end
    end
  endfunction

  virtual function void sample_values();
    super.sample_values();
    if (get_coverage(UVM_CVR_FIELD_VALS)) begin
      wr_fld_covg.sample();
      rd_fld_covg.sample();
    end
  endfunction

  virtual function void build();
    uvm_reg_field fld_set[$];
    uvm_reg_field_config_ta ta = get_field_config(getconfigUID());
    build_uvm_reg_fields(this, ta, fld_set);
    
    phy_pma_cmn_ctrl_sts_0 = fld_set[0];
    phy_pma_cmn_ctrl_sts_1 = fld_set[1];
    phy_pma_cmn_ctrl_sts_2 = fld_set[2];
    phy_pma_cmn_ctrl_sts_3 = fld_set[3];
    phy_pma_cmn_ctrl_sts_4 = fld_set[4];
    phy_pma_cmn_ctrl_sts_5 = fld_set[5];
    phy_pma_cmn_ctrl_sts_6 = fld_set[6];
    phy_pma_cmn_ctrl_sts_7 = fld_set[7];
    phy_pma_cmn_ctrl_sts_8 = fld_set[8];
    phy_pma_cmn_ctrl_sts_9 = fld_set[9];
    phy_pma_cmn_ctrl_sts_10 = fld_set[10];
    phy_pma_cmn_ctrl_sts_11 = fld_set[11];
    phy_pma_cmn_ctrl_sts_12 = fld_set[12];
    phy_pma_cmn_ctrl_sts_13 = fld_set[13];
    phy_pma_cmn_ctrl_sts_14 = fld_set[14];
    phy_pma_cmn_ctrl_sts_15 = fld_set[15];
    phy_pma_cmn_ctrl_sts_16 = fld_set[16];
    phy_pma_cmn_ctrl_sts_17 = fld_set[17];
    phy_pma_cmn_ctrl_sts_18 = fld_set[18];
    phy_pma_cmn_ctrl_sts_19 = fld_set[19];
    phy_pma_cmn_ctrl_sts_20 = fld_set[20];
    phy_pma_cmn_ctrl_sts_21 = fld_set[21];
    phy_pma_cmn_ctrl_sts_23_22 = fld_set[22];
    phy_pma_cmn_ctrl_sts_24 = fld_set[23];
    phy_pma_cmn_ctrl_sts_25 = fld_set[24];
    phy_pma_cmn_ctrl_sts_27_26 = fld_set[25];
    phy_pma_cmn_ctrl_sts_28 = fld_set[26];
    phy_pma_cmn_ctrl_sts_31_29 = fld_set[27];
  endfunction

  function new(input string name="T_phy_pma_cmn_ctrl_sts_112");
    super.new(name, 32, build_coverage(UVM_CVR_FIELD_VALS));
    if (has_coverage(UVM_CVR_FIELD_VALS)) begin
      wr_fld_covg = new();
      rd_fld_covg = new();
    end
  endfunction

endclass


/////////////////////////////////////////////////////
//                phy_pma_cmn_ctrl_sts_clr
/////////////////////////////////////////////////////
class T_phy_pma_cmn_ctrl_sts_clr_113 extends cdns_uvm_reg;

  `uvm_object_utils(T_phy_pma_cmn_ctrl_sts_clr_113)
  rand uvm_reg_field phy_pma_cmn_ctrl_sts_clr_31_0;
  
  covergroup wr_fld_covg;
    phy_pma_cmn_ctrl_sts_clr_31_0: coverpoint phy_pma_cmn_ctrl_sts_clr_31_0.value[31:0];
  endgroup
  covergroup rd_fld_covg;
    phy_pma_cmn_ctrl_sts_clr_31_0: coverpoint phy_pma_cmn_ctrl_sts_clr_31_0.value[31:0];
  endgroup

  protected virtual function void sample(uvm_reg_data_t data, uvm_reg_data_t byte_en, bit is_read, uvm_reg_map map);
    super.sample(data, byte_en, is_read, map);
    if (get_coverage(UVM_CVR_FIELD_VALS)) begin
      if(!is_read) begin
          wr_fld_covg.sample();
      end
      if(is_read) begin
         rd_fld_covg.sample();
      end
    end
  endfunction

  virtual function void sample_values();
    super.sample_values();
    if (get_coverage(UVM_CVR_FIELD_VALS)) begin
      wr_fld_covg.sample();
      rd_fld_covg.sample();
    end
  endfunction

  virtual function void build();
    uvm_reg_field fld_set[$];
    uvm_reg_field_config_ta ta = get_field_config(getconfigUID());
    build_uvm_reg_fields(this, ta, fld_set);
    
    phy_pma_cmn_ctrl_sts_clr_31_0 = fld_set[0];
  endfunction

  function new(input string name="T_phy_pma_cmn_ctrl_sts_clr_113");
    super.new(name, 32, build_coverage(UVM_CVR_FIELD_VALS));
    if (has_coverage(UVM_CVR_FIELD_VALS)) begin
      wr_fld_covg = new();
      rd_fld_covg = new();
    end
  endfunction

endclass


/////////////////////////////////////////////////////
//                phy_pma_iso_cmn_ctrl
/////////////////////////////////////////////////////
class T_phy_pma_iso_cmn_ctrl_118 extends cdns_uvm_reg;

  `uvm_object_utils(T_phy_pma_iso_cmn_ctrl_118)
  rand uvm_reg_field phy_pma_iso_cmn_ctrl_0;
  rand uvm_reg_field phy_pma_iso_cmn_ctrl_1;
  rand uvm_reg_field phy_pma_iso_cmn_ctrl_23_2;
  rand uvm_reg_field phy_pma_iso_cmn_ctrl_25_24;
  rand uvm_reg_field phy_pma_iso_cmn_ctrl_26;
  rand uvm_reg_field phy_pma_iso_cmn_ctrl_27;
  rand uvm_reg_field phy_pma_iso_cmn_ctrl_29_28;
  rand uvm_reg_field phy_pma_iso_cmn_ctrl_31_30;
  
  covergroup wr_fld_covg;
    phy_pma_iso_cmn_ctrl_0: coverpoint phy_pma_iso_cmn_ctrl_0.value[0:0];
    phy_pma_iso_cmn_ctrl_1: coverpoint phy_pma_iso_cmn_ctrl_1.value[0:0];
    phy_pma_iso_cmn_ctrl_23_2: coverpoint phy_pma_iso_cmn_ctrl_23_2.value[21:0];
    phy_pma_iso_cmn_ctrl_25_24: coverpoint phy_pma_iso_cmn_ctrl_25_24.value[1:0];
    phy_pma_iso_cmn_ctrl_26: coverpoint phy_pma_iso_cmn_ctrl_26.value[0:0];
    phy_pma_iso_cmn_ctrl_27: coverpoint phy_pma_iso_cmn_ctrl_27.value[0:0];
    phy_pma_iso_cmn_ctrl_29_28: coverpoint phy_pma_iso_cmn_ctrl_29_28.value[1:0];
    phy_pma_iso_cmn_ctrl_31_30: coverpoint phy_pma_iso_cmn_ctrl_31_30.value[1:0];
  endgroup
  covergroup rd_fld_covg;
    phy_pma_iso_cmn_ctrl_0: coverpoint phy_pma_iso_cmn_ctrl_0.value[0:0];
    phy_pma_iso_cmn_ctrl_1: coverpoint phy_pma_iso_cmn_ctrl_1.value[0:0];
    phy_pma_iso_cmn_ctrl_23_2: coverpoint phy_pma_iso_cmn_ctrl_23_2.value[21:0];
    phy_pma_iso_cmn_ctrl_25_24: coverpoint phy_pma_iso_cmn_ctrl_25_24.value[1:0];
    phy_pma_iso_cmn_ctrl_26: coverpoint phy_pma_iso_cmn_ctrl_26.value[0:0];
    phy_pma_iso_cmn_ctrl_27: coverpoint phy_pma_iso_cmn_ctrl_27.value[0:0];
    phy_pma_iso_cmn_ctrl_29_28: coverpoint phy_pma_iso_cmn_ctrl_29_28.value[1:0];
    phy_pma_iso_cmn_ctrl_31_30: coverpoint phy_pma_iso_cmn_ctrl_31_30.value[1:0];
  endgroup

  protected virtual function void sample(uvm_reg_data_t data, uvm_reg_data_t byte_en, bit is_read, uvm_reg_map map);
    super.sample(data, byte_en, is_read, map);
    if (get_coverage(UVM_CVR_FIELD_VALS)) begin
      if(!is_read) begin
          wr_fld_covg.sample();
      end
      if(is_read) begin
         rd_fld_covg.sample();
      end
    end
  endfunction

  virtual function void sample_values();
    super.sample_values();
    if (get_coverage(UVM_CVR_FIELD_VALS)) begin
      wr_fld_covg.sample();
      rd_fld_covg.sample();
    end
  endfunction

  virtual function void build();
    uvm_reg_field fld_set[$];
    uvm_reg_field_config_ta ta = get_field_config(getconfigUID());
    build_uvm_reg_fields(this, ta, fld_set);
    
    phy_pma_iso_cmn_ctrl_0 = fld_set[0];
    phy_pma_iso_cmn_ctrl_1 = fld_set[1];
    phy_pma_iso_cmn_ctrl_23_2 = fld_set[2];
    phy_pma_iso_cmn_ctrl_25_24 = fld_set[3];
    phy_pma_iso_cmn_ctrl_26 = fld_set[4];
    phy_pma_iso_cmn_ctrl_27 = fld_set[5];
    phy_pma_iso_cmn_ctrl_29_28 = fld_set[6];
    phy_pma_iso_cmn_ctrl_31_30 = fld_set[7];
  endfunction

  function new(input string name="T_phy_pma_iso_cmn_ctrl_118");
    super.new(name, 32, build_coverage(UVM_CVR_FIELD_VALS));
    if (has_coverage(UVM_CVR_FIELD_VALS)) begin
      wr_fld_covg = new();
      rd_fld_covg = new();
    end
  endfunction

endclass


/////////////////////////////////////////////////////
//                phy_soc_int_sts
/////////////////////////////////////////////////////
class T_phy_soc_int_sts_122 extends cdns_uvm_reg;

  `uvm_object_utils(T_phy_soc_int_sts_122)
  rand uvm_reg_field phy_soc_int_sts_0;
  rand uvm_reg_field phy_soc_int_sts_1;
  rand uvm_reg_field phy_soc_int_sts_2;
  rand uvm_reg_field phy_soc_int_sts_3;
  rand uvm_reg_field phy_soc_int_sts_31_4;
  
  covergroup wr_fld_covg;
    phy_soc_int_sts_0: coverpoint phy_soc_int_sts_0.value[0:0];
    phy_soc_int_sts_1: coverpoint phy_soc_int_sts_1.value[0:0];
    phy_soc_int_sts_2: coverpoint phy_soc_int_sts_2.value[0:0];
    phy_soc_int_sts_3: coverpoint phy_soc_int_sts_3.value[0:0];
    phy_soc_int_sts_31_4: coverpoint phy_soc_int_sts_31_4.value[27:0];
  endgroup
  covergroup rd_fld_covg;
    phy_soc_int_sts_0: coverpoint phy_soc_int_sts_0.value[0:0];
    phy_soc_int_sts_1: coverpoint phy_soc_int_sts_1.value[0:0];
    phy_soc_int_sts_2: coverpoint phy_soc_int_sts_2.value[0:0];
    phy_soc_int_sts_3: coverpoint phy_soc_int_sts_3.value[0:0];
    phy_soc_int_sts_31_4: coverpoint phy_soc_int_sts_31_4.value[27:0];
  endgroup

  protected virtual function void sample(uvm_reg_data_t data, uvm_reg_data_t byte_en, bit is_read, uvm_reg_map map);
    super.sample(data, byte_en, is_read, map);
    if (get_coverage(UVM_CVR_FIELD_VALS)) begin
      if(!is_read) begin
          wr_fld_covg.sample();
      end
      if(is_read) begin
         rd_fld_covg.sample();
      end
    end
  endfunction

  virtual function void sample_values();
    super.sample_values();
    if (get_coverage(UVM_CVR_FIELD_VALS)) begin
      wr_fld_covg.sample();
      rd_fld_covg.sample();
    end
  endfunction

  virtual function void build();
    uvm_reg_field fld_set[$];
    uvm_reg_field_config_ta ta = get_field_config(getconfigUID());
    build_uvm_reg_fields(this, ta, fld_set);
    
    phy_soc_int_sts_0 = fld_set[0];
    phy_soc_int_sts_1 = fld_set[1];
    phy_soc_int_sts_2 = fld_set[2];
    phy_soc_int_sts_3 = fld_set[3];
    phy_soc_int_sts_31_4 = fld_set[4];
  endfunction

  function new(input string name="T_phy_soc_int_sts_122");
    super.new(name, 32, build_coverage(UVM_CVR_FIELD_VALS));
    if (has_coverage(UVM_CVR_FIELD_VALS)) begin
      wr_fld_covg = new();
      rd_fld_covg = new();
    end
  endfunction

endclass


/////////////////////////////////////////////////////
//                phy_soc_int_sts_en
/////////////////////////////////////////////////////
class T_phy_soc_int_sts_en_124 extends cdns_uvm_reg;

  `uvm_object_utils(T_phy_soc_int_sts_en_124)
  rand uvm_reg_field phy_soc_int_sts_en_3_0;
  rand uvm_reg_field phy_soc_int_sts_en_31_4;
  
  covergroup wr_fld_covg;
    phy_soc_int_sts_en_3_0: coverpoint phy_soc_int_sts_en_3_0.value[3:0];
    phy_soc_int_sts_en_31_4: coverpoint phy_soc_int_sts_en_31_4.value[27:0];
  endgroup
  covergroup rd_fld_covg;
    phy_soc_int_sts_en_3_0: coverpoint phy_soc_int_sts_en_3_0.value[3:0];
    phy_soc_int_sts_en_31_4: coverpoint phy_soc_int_sts_en_31_4.value[27:0];
  endgroup

  protected virtual function void sample(uvm_reg_data_t data, uvm_reg_data_t byte_en, bit is_read, uvm_reg_map map);
    super.sample(data, byte_en, is_read, map);
    if (get_coverage(UVM_CVR_FIELD_VALS)) begin
      if(!is_read) begin
          wr_fld_covg.sample();
      end
      if(is_read) begin
         rd_fld_covg.sample();
      end
    end
  endfunction

  virtual function void sample_values();
    super.sample_values();
    if (get_coverage(UVM_CVR_FIELD_VALS)) begin
      wr_fld_covg.sample();
      rd_fld_covg.sample();
    end
  endfunction

  virtual function void build();
    uvm_reg_field fld_set[$];
    uvm_reg_field_config_ta ta = get_field_config(getconfigUID());
    build_uvm_reg_fields(this, ta, fld_set);
    
    phy_soc_int_sts_en_3_0 = fld_set[0];
    phy_soc_int_sts_en_31_4 = fld_set[1];
  endfunction

  function new(input string name="T_phy_soc_int_sts_en_124");
    super.new(name, 32, build_coverage(UVM_CVR_FIELD_VALS));
    if (has_coverage(UVM_CVR_FIELD_VALS)) begin
      wr_fld_covg = new();
      rd_fld_covg = new();
    end
  endfunction

endclass


/////////////////////////////////////////////////////
//                phy_soc_int_sts_set
/////////////////////////////////////////////////////
class T_phy_soc_int_sts_set_123 extends cdns_uvm_reg;

  `uvm_object_utils(T_phy_soc_int_sts_set_123)
  rand uvm_reg_field phy_soc_int_sts_set_3_0;
  rand uvm_reg_field phy_soc_int_sts_set_31_4;
  
  covergroup wr_fld_covg;
    phy_soc_int_sts_set_3_0: coverpoint phy_soc_int_sts_set_3_0.value[3:0];
    phy_soc_int_sts_set_31_4: coverpoint phy_soc_int_sts_set_31_4.value[27:0];
  endgroup
  covergroup rd_fld_covg;
    phy_soc_int_sts_set_3_0: coverpoint phy_soc_int_sts_set_3_0.value[3:0];
    phy_soc_int_sts_set_31_4: coverpoint phy_soc_int_sts_set_31_4.value[27:0];
  endgroup

  protected virtual function void sample(uvm_reg_data_t data, uvm_reg_data_t byte_en, bit is_read, uvm_reg_map map);
    super.sample(data, byte_en, is_read, map);
    if (get_coverage(UVM_CVR_FIELD_VALS)) begin
      if(!is_read) begin
          wr_fld_covg.sample();
      end
      if(is_read) begin
         rd_fld_covg.sample();
      end
    end
  endfunction

  virtual function void sample_values();
    super.sample_values();
    if (get_coverage(UVM_CVR_FIELD_VALS)) begin
      wr_fld_covg.sample();
      rd_fld_covg.sample();
    end
  endfunction

  virtual function void build();
    uvm_reg_field fld_set[$];
    uvm_reg_field_config_ta ta = get_field_config(getconfigUID());
    build_uvm_reg_fields(this, ta, fld_set);
    
    phy_soc_int_sts_set_3_0 = fld_set[0];
    phy_soc_int_sts_set_31_4 = fld_set[1];
  endfunction

  function new(input string name="T_phy_soc_int_sts_set_123");
    super.new(name, 32, build_coverage(UVM_CVR_FIELD_VALS));
    if (has_coverage(UVM_CVR_FIELD_VALS)) begin
      wr_fld_covg = new();
      rd_fld_covg = new();
    end
  endfunction

endclass


/////////////////////////////////////////////////////
//                phy_top_uc_event_ctr
/////////////////////////////////////////////////////
class T_phy_top_uc_event_ctr_130 extends cdns_uvm_reg;

  `uvm_object_utils(T_phy_top_uc_event_ctr_130)
  rand uvm_reg_field phy_top_uc_event_ctr_15_0;
  rand uvm_reg_field phy_top_uc_event_ctr_31_16;
  
  covergroup wr_fld_covg;
    phy_top_uc_event_ctr_15_0: coverpoint phy_top_uc_event_ctr_15_0.value[15:0];
    phy_top_uc_event_ctr_31_16: coverpoint phy_top_uc_event_ctr_31_16.value[15:0];
  endgroup
  covergroup rd_fld_covg;
    phy_top_uc_event_ctr_15_0: coverpoint phy_top_uc_event_ctr_15_0.value[15:0];
    phy_top_uc_event_ctr_31_16: coverpoint phy_top_uc_event_ctr_31_16.value[15:0];
  endgroup

  protected virtual function void sample(uvm_reg_data_t data, uvm_reg_data_t byte_en, bit is_read, uvm_reg_map map);
    super.sample(data, byte_en, is_read, map);
    if (get_coverage(UVM_CVR_FIELD_VALS)) begin
      if(!is_read) begin
          wr_fld_covg.sample();
      end
      if(is_read) begin
         rd_fld_covg.sample();
      end
    end
  endfunction

  virtual function void sample_values();
    super.sample_values();
    if (get_coverage(UVM_CVR_FIELD_VALS)) begin
      wr_fld_covg.sample();
      rd_fld_covg.sample();
    end
  endfunction

  virtual function void build();
    uvm_reg_field fld_set[$];
    uvm_reg_field_config_ta ta = get_field_config(getconfigUID());
    build_uvm_reg_fields(this, ta, fld_set);
    
    phy_top_uc_event_ctr_15_0 = fld_set[0];
    phy_top_uc_event_ctr_31_16 = fld_set[1];
  endfunction

  function new(input string name="T_phy_top_uc_event_ctr_130");
    super.new(name, 32, build_coverage(UVM_CVR_FIELD_VALS));
    if (has_coverage(UVM_CVR_FIELD_VALS)) begin
      wr_fld_covg = new();
      rd_fld_covg = new();
    end
  endfunction

endclass


/////////////////////////////////////////////////////
//                phy_top_uc_watchdog
/////////////////////////////////////////////////////
class T_phy_top_uc_watchdog_131 extends cdns_uvm_reg;

  `uvm_object_utils(T_phy_top_uc_watchdog_131)
  rand uvm_reg_field phy_top_uc_watchdog_23_0;
  rand uvm_reg_field phy_top_uc_watchdog_31_24;
  
  covergroup wr_fld_covg;
    phy_top_uc_watchdog_23_0: coverpoint phy_top_uc_watchdog_23_0.value[23:0];
    phy_top_uc_watchdog_31_24: coverpoint phy_top_uc_watchdog_31_24.value[7:0];
  endgroup
  covergroup rd_fld_covg;
    phy_top_uc_watchdog_23_0: coverpoint phy_top_uc_watchdog_23_0.value[23:0];
    phy_top_uc_watchdog_31_24: coverpoint phy_top_uc_watchdog_31_24.value[7:0];
  endgroup

  protected virtual function void sample(uvm_reg_data_t data, uvm_reg_data_t byte_en, bit is_read, uvm_reg_map map);
    super.sample(data, byte_en, is_read, map);
    if (get_coverage(UVM_CVR_FIELD_VALS)) begin
      if(!is_read) begin
          wr_fld_covg.sample();
      end
      if(is_read) begin
         rd_fld_covg.sample();
      end
    end
  endfunction

  virtual function void sample_values();
    super.sample_values();
    if (get_coverage(UVM_CVR_FIELD_VALS)) begin
      wr_fld_covg.sample();
      rd_fld_covg.sample();
    end
  endfunction

  virtual function void build();
    uvm_reg_field fld_set[$];
    uvm_reg_field_config_ta ta = get_field_config(getconfigUID());
    build_uvm_reg_fields(this, ta, fld_set);
    
    phy_top_uc_watchdog_23_0 = fld_set[0];
    phy_top_uc_watchdog_31_24 = fld_set[1];
  endfunction

  function new(input string name="T_phy_top_uc_watchdog_131");
    super.new(name, 32, build_coverage(UVM_CVR_FIELD_VALS));
    if (has_coverage(UVM_CVR_FIELD_VALS)) begin
      wr_fld_covg = new();
      rd_fld_covg = new();
    end
  endfunction

endclass


/////////////////////////////////////////////////////
//                phy_top_uc_watchdog_cfg
/////////////////////////////////////////////////////
class T_phy_top_uc_watchdog_cfg_132 extends cdns_uvm_reg;

  `uvm_object_utils(T_phy_top_uc_watchdog_cfg_132)
  rand uvm_reg_field phy_top_uc_watchdog_cfg_23_0;
  rand uvm_reg_field phy_top_uc_watchdog_cfg_30_24;
  rand uvm_reg_field phy_top_uc_watchdog_cfg_31;
  
  covergroup wr_fld_covg;
    phy_top_uc_watchdog_cfg_23_0: coverpoint phy_top_uc_watchdog_cfg_23_0.value[23:0];
    phy_top_uc_watchdog_cfg_30_24: coverpoint phy_top_uc_watchdog_cfg_30_24.value[6:0];
    phy_top_uc_watchdog_cfg_31: coverpoint phy_top_uc_watchdog_cfg_31.value[0:0];
  endgroup
  covergroup rd_fld_covg;
    phy_top_uc_watchdog_cfg_23_0: coverpoint phy_top_uc_watchdog_cfg_23_0.value[23:0];
    phy_top_uc_watchdog_cfg_30_24: coverpoint phy_top_uc_watchdog_cfg_30_24.value[6:0];
    phy_top_uc_watchdog_cfg_31: coverpoint phy_top_uc_watchdog_cfg_31.value[0:0];
  endgroup

  protected virtual function void sample(uvm_reg_data_t data, uvm_reg_data_t byte_en, bit is_read, uvm_reg_map map);
    super.sample(data, byte_en, is_read, map);
    if (get_coverage(UVM_CVR_FIELD_VALS)) begin
      if(!is_read) begin
          wr_fld_covg.sample();
      end
      if(is_read) begin
         rd_fld_covg.sample();
      end
    end
  endfunction

  virtual function void sample_values();
    super.sample_values();
    if (get_coverage(UVM_CVR_FIELD_VALS)) begin
      wr_fld_covg.sample();
      rd_fld_covg.sample();
    end
  endfunction

  virtual function void build();
    uvm_reg_field fld_set[$];
    uvm_reg_field_config_ta ta = get_field_config(getconfigUID());
    build_uvm_reg_fields(this, ta, fld_set);
    
    phy_top_uc_watchdog_cfg_23_0 = fld_set[0];
    phy_top_uc_watchdog_cfg_30_24 = fld_set[1];
    phy_top_uc_watchdog_cfg_31 = fld_set[2];
  endfunction

  function new(input string name="T_phy_top_uc_watchdog_cfg_132");
    super.new(name, 32, build_coverage(UVM_CVR_FIELD_VALS));
    if (has_coverage(UVM_CVR_FIELD_VALS)) begin
      wr_fld_covg = new();
      rd_fld_covg = new();
    end
  endfunction

endclass


/////////////////////////////////////////////////////
//                phy_uc_cmn_en_int_sts
/////////////////////////////////////////////////////
class T_phy_uc_cmn_en_int_sts_127 extends cdns_uvm_reg;

  `uvm_object_utils(T_phy_uc_cmn_en_int_sts_127)
  rand uvm_reg_field phy_uc_cmn_en_int_sts_31_0;
  
  covergroup wr_fld_covg;
    phy_uc_cmn_en_int_sts_31_0: coverpoint phy_uc_cmn_en_int_sts_31_0.value[31:0];
  endgroup
  covergroup rd_fld_covg;
    phy_uc_cmn_en_int_sts_31_0: coverpoint phy_uc_cmn_en_int_sts_31_0.value[31:0];
  endgroup

  protected virtual function void sample(uvm_reg_data_t data, uvm_reg_data_t byte_en, bit is_read, uvm_reg_map map);
    super.sample(data, byte_en, is_read, map);
    if (get_coverage(UVM_CVR_FIELD_VALS)) begin
      if(!is_read) begin
          wr_fld_covg.sample();
      end
      if(is_read) begin
         rd_fld_covg.sample();
      end
    end
  endfunction

  virtual function void sample_values();
    super.sample_values();
    if (get_coverage(UVM_CVR_FIELD_VALS)) begin
      wr_fld_covg.sample();
      rd_fld_covg.sample();
    end
  endfunction

  virtual function void build();
    uvm_reg_field fld_set[$];
    uvm_reg_field_config_ta ta = get_field_config(getconfigUID());
    build_uvm_reg_fields(this, ta, fld_set);
    
    phy_uc_cmn_en_int_sts_31_0 = fld_set[0];
  endfunction

  function new(input string name="T_phy_uc_cmn_en_int_sts_127");
    super.new(name, 32, build_coverage(UVM_CVR_FIELD_VALS));
    if (has_coverage(UVM_CVR_FIELD_VALS)) begin
      wr_fld_covg = new();
      rd_fld_covg = new();
    end
  endfunction

endclass


/////////////////////////////////////////////////////
//                phy_uc_cmn_int_sts
/////////////////////////////////////////////////////
class T_phy_uc_cmn_int_sts_125 extends cdns_uvm_reg;

  `uvm_object_utils(T_phy_uc_cmn_int_sts_125)
  rand uvm_reg_field phy_uc_cmn_int_sts_0;
  rand uvm_reg_field phy_uc_cmn_int_sts_1;
  rand uvm_reg_field phy_uc_cmn_int_sts_3_2;
  rand uvm_reg_field phy_uc_cmn_int_sts_4;
  rand uvm_reg_field phy_uc_cmn_int_sts_5;
  rand uvm_reg_field phy_uc_cmn_int_sts_6;
  rand uvm_reg_field phy_uc_cmn_int_sts_7;
  rand uvm_reg_field phy_uc_cmn_int_sts_8;
  rand uvm_reg_field phy_uc_cmn_int_sts_9;
  rand uvm_reg_field phy_uc_cmn_int_sts_10;
  rand uvm_reg_field phy_uc_cmn_int_sts_11;
  rand uvm_reg_field phy_uc_cmn_int_sts_12;
  rand uvm_reg_field phy_uc_cmn_int_sts_13;
  rand uvm_reg_field phy_uc_cmn_int_sts_14;
  rand uvm_reg_field phy_uc_cmn_int_sts_15;
  rand uvm_reg_field phy_uc_cmn_int_sts_16;
  rand uvm_reg_field phy_uc_cmn_int_sts_17;
  rand uvm_reg_field phy_uc_cmn_int_sts_19_18;
  rand uvm_reg_field phy_uc_cmn_int_sts_20;
  rand uvm_reg_field phy_uc_cmn_int_sts_21;
  rand uvm_reg_field phy_uc_cmn_int_sts_22;
  rand uvm_reg_field phy_uc_cmn_int_sts_23;
  rand uvm_reg_field phy_uc_cmn_int_sts_25_24;
  rand uvm_reg_field phy_uc_cmn_int_sts_26;
  rand uvm_reg_field phy_uc_cmn_int_sts_27;
  rand uvm_reg_field phy_uc_cmn_int_sts_28;
  rand uvm_reg_field phy_uc_cmn_int_sts_29;
  rand uvm_reg_field phy_uc_cmn_int_sts_30;
  rand uvm_reg_field phy_uc_cmn_int_sts_31;
  
  covergroup wr_fld_covg;
    phy_uc_cmn_int_sts_0: coverpoint phy_uc_cmn_int_sts_0.value[0:0];
    phy_uc_cmn_int_sts_1: coverpoint phy_uc_cmn_int_sts_1.value[0:0];
    phy_uc_cmn_int_sts_3_2: coverpoint phy_uc_cmn_int_sts_3_2.value[1:0];
    phy_uc_cmn_int_sts_4: coverpoint phy_uc_cmn_int_sts_4.value[0:0];
    phy_uc_cmn_int_sts_5: coverpoint phy_uc_cmn_int_sts_5.value[0:0];
    phy_uc_cmn_int_sts_6: coverpoint phy_uc_cmn_int_sts_6.value[0:0];
    phy_uc_cmn_int_sts_7: coverpoint phy_uc_cmn_int_sts_7.value[0:0];
    phy_uc_cmn_int_sts_8: coverpoint phy_uc_cmn_int_sts_8.value[0:0];
    phy_uc_cmn_int_sts_9: coverpoint phy_uc_cmn_int_sts_9.value[0:0];
    phy_uc_cmn_int_sts_10: coverpoint phy_uc_cmn_int_sts_10.value[0:0];
    phy_uc_cmn_int_sts_11: coverpoint phy_uc_cmn_int_sts_11.value[0:0];
    phy_uc_cmn_int_sts_12: coverpoint phy_uc_cmn_int_sts_12.value[0:0];
    phy_uc_cmn_int_sts_13: coverpoint phy_uc_cmn_int_sts_13.value[0:0];
    phy_uc_cmn_int_sts_14: coverpoint phy_uc_cmn_int_sts_14.value[0:0];
    phy_uc_cmn_int_sts_15: coverpoint phy_uc_cmn_int_sts_15.value[0:0];
    phy_uc_cmn_int_sts_16: coverpoint phy_uc_cmn_int_sts_16.value[0:0];
    phy_uc_cmn_int_sts_17: coverpoint phy_uc_cmn_int_sts_17.value[0:0];
    phy_uc_cmn_int_sts_19_18: coverpoint phy_uc_cmn_int_sts_19_18.value[1:0];
    phy_uc_cmn_int_sts_20: coverpoint phy_uc_cmn_int_sts_20.value[0:0];
    phy_uc_cmn_int_sts_21: coverpoint phy_uc_cmn_int_sts_21.value[0:0];
    phy_uc_cmn_int_sts_22: coverpoint phy_uc_cmn_int_sts_22.value[0:0];
    phy_uc_cmn_int_sts_23: coverpoint phy_uc_cmn_int_sts_23.value[0:0];
    phy_uc_cmn_int_sts_25_24: coverpoint phy_uc_cmn_int_sts_25_24.value[1:0];
    phy_uc_cmn_int_sts_26: coverpoint phy_uc_cmn_int_sts_26.value[0:0];
    phy_uc_cmn_int_sts_27: coverpoint phy_uc_cmn_int_sts_27.value[0:0];
    phy_uc_cmn_int_sts_28: coverpoint phy_uc_cmn_int_sts_28.value[0:0];
    phy_uc_cmn_int_sts_29: coverpoint phy_uc_cmn_int_sts_29.value[0:0];
    phy_uc_cmn_int_sts_30: coverpoint phy_uc_cmn_int_sts_30.value[0:0];
    phy_uc_cmn_int_sts_31: coverpoint phy_uc_cmn_int_sts_31.value[0:0];
  endgroup
  covergroup rd_fld_covg;
    phy_uc_cmn_int_sts_0: coverpoint phy_uc_cmn_int_sts_0.value[0:0];
    phy_uc_cmn_int_sts_1: coverpoint phy_uc_cmn_int_sts_1.value[0:0];
    phy_uc_cmn_int_sts_3_2: coverpoint phy_uc_cmn_int_sts_3_2.value[1:0];
    phy_uc_cmn_int_sts_4: coverpoint phy_uc_cmn_int_sts_4.value[0:0];
    phy_uc_cmn_int_sts_5: coverpoint phy_uc_cmn_int_sts_5.value[0:0];
    phy_uc_cmn_int_sts_6: coverpoint phy_uc_cmn_int_sts_6.value[0:0];
    phy_uc_cmn_int_sts_7: coverpoint phy_uc_cmn_int_sts_7.value[0:0];
    phy_uc_cmn_int_sts_8: coverpoint phy_uc_cmn_int_sts_8.value[0:0];
    phy_uc_cmn_int_sts_9: coverpoint phy_uc_cmn_int_sts_9.value[0:0];
    phy_uc_cmn_int_sts_10: coverpoint phy_uc_cmn_int_sts_10.value[0:0];
    phy_uc_cmn_int_sts_11: coverpoint phy_uc_cmn_int_sts_11.value[0:0];
    phy_uc_cmn_int_sts_12: coverpoint phy_uc_cmn_int_sts_12.value[0:0];
    phy_uc_cmn_int_sts_13: coverpoint phy_uc_cmn_int_sts_13.value[0:0];
    phy_uc_cmn_int_sts_14: coverpoint phy_uc_cmn_int_sts_14.value[0:0];
    phy_uc_cmn_int_sts_15: coverpoint phy_uc_cmn_int_sts_15.value[0:0];
    phy_uc_cmn_int_sts_16: coverpoint phy_uc_cmn_int_sts_16.value[0:0];
    phy_uc_cmn_int_sts_17: coverpoint phy_uc_cmn_int_sts_17.value[0:0];
    phy_uc_cmn_int_sts_19_18: coverpoint phy_uc_cmn_int_sts_19_18.value[1:0];
    phy_uc_cmn_int_sts_20: coverpoint phy_uc_cmn_int_sts_20.value[0:0];
    phy_uc_cmn_int_sts_21: coverpoint phy_uc_cmn_int_sts_21.value[0:0];
    phy_uc_cmn_int_sts_22: coverpoint phy_uc_cmn_int_sts_22.value[0:0];
    phy_uc_cmn_int_sts_23: coverpoint phy_uc_cmn_int_sts_23.value[0:0];
    phy_uc_cmn_int_sts_25_24: coverpoint phy_uc_cmn_int_sts_25_24.value[1:0];
    phy_uc_cmn_int_sts_26: coverpoint phy_uc_cmn_int_sts_26.value[0:0];
    phy_uc_cmn_int_sts_27: coverpoint phy_uc_cmn_int_sts_27.value[0:0];
    phy_uc_cmn_int_sts_28: coverpoint phy_uc_cmn_int_sts_28.value[0:0];
    phy_uc_cmn_int_sts_29: coverpoint phy_uc_cmn_int_sts_29.value[0:0];
    phy_uc_cmn_int_sts_30: coverpoint phy_uc_cmn_int_sts_30.value[0:0];
    phy_uc_cmn_int_sts_31: coverpoint phy_uc_cmn_int_sts_31.value[0:0];
  endgroup

  protected virtual function void sample(uvm_reg_data_t data, uvm_reg_data_t byte_en, bit is_read, uvm_reg_map map);
    super.sample(data, byte_en, is_read, map);
    if (get_coverage(UVM_CVR_FIELD_VALS)) begin
      if(!is_read) begin
          wr_fld_covg.sample();
      end
      if(is_read) begin
         rd_fld_covg.sample();
      end
    end
  endfunction

  virtual function void sample_values();
    super.sample_values();
    if (get_coverage(UVM_CVR_FIELD_VALS)) begin
      wr_fld_covg.sample();
      rd_fld_covg.sample();
    end
  endfunction

  virtual function void build();
    uvm_reg_field fld_set[$];
    uvm_reg_field_config_ta ta = get_field_config(getconfigUID());
    build_uvm_reg_fields(this, ta, fld_set);
    
    phy_uc_cmn_int_sts_0 = fld_set[0];
    phy_uc_cmn_int_sts_1 = fld_set[1];
    phy_uc_cmn_int_sts_3_2 = fld_set[2];
    phy_uc_cmn_int_sts_4 = fld_set[3];
    phy_uc_cmn_int_sts_5 = fld_set[4];
    phy_uc_cmn_int_sts_6 = fld_set[5];
    phy_uc_cmn_int_sts_7 = fld_set[6];
    phy_uc_cmn_int_sts_8 = fld_set[7];
    phy_uc_cmn_int_sts_9 = fld_set[8];
    phy_uc_cmn_int_sts_10 = fld_set[9];
    phy_uc_cmn_int_sts_11 = fld_set[10];
    phy_uc_cmn_int_sts_12 = fld_set[11];
    phy_uc_cmn_int_sts_13 = fld_set[12];
    phy_uc_cmn_int_sts_14 = fld_set[13];
    phy_uc_cmn_int_sts_15 = fld_set[14];
    phy_uc_cmn_int_sts_16 = fld_set[15];
    phy_uc_cmn_int_sts_17 = fld_set[16];
    phy_uc_cmn_int_sts_19_18 = fld_set[17];
    phy_uc_cmn_int_sts_20 = fld_set[18];
    phy_uc_cmn_int_sts_21 = fld_set[19];
    phy_uc_cmn_int_sts_22 = fld_set[20];
    phy_uc_cmn_int_sts_23 = fld_set[21];
    phy_uc_cmn_int_sts_25_24 = fld_set[22];
    phy_uc_cmn_int_sts_26 = fld_set[23];
    phy_uc_cmn_int_sts_27 = fld_set[24];
    phy_uc_cmn_int_sts_28 = fld_set[25];
    phy_uc_cmn_int_sts_29 = fld_set[26];
    phy_uc_cmn_int_sts_30 = fld_set[27];
    phy_uc_cmn_int_sts_31 = fld_set[28];
  endfunction

  function new(input string name="T_phy_uc_cmn_int_sts_125");
    super.new(name, 32, build_coverage(UVM_CVR_FIELD_VALS));
    if (has_coverage(UVM_CVR_FIELD_VALS)) begin
      wr_fld_covg = new();
      rd_fld_covg = new();
    end
  endfunction

endclass


/////////////////////////////////////////////////////
//                phy_uc_cmn_int_sts_en
/////////////////////////////////////////////////////
class T_phy_uc_cmn_int_sts_en_128 extends cdns_uvm_reg;

  `uvm_object_utils(T_phy_uc_cmn_int_sts_en_128)
  rand uvm_reg_field phy_uc_cmn_int_sts_en_31_0;
  
  covergroup wr_fld_covg;
    phy_uc_cmn_int_sts_en_31_0: coverpoint phy_uc_cmn_int_sts_en_31_0.value[31:0];
  endgroup
  covergroup rd_fld_covg;
    phy_uc_cmn_int_sts_en_31_0: coverpoint phy_uc_cmn_int_sts_en_31_0.value[31:0];
  endgroup

  protected virtual function void sample(uvm_reg_data_t data, uvm_reg_data_t byte_en, bit is_read, uvm_reg_map map);
    super.sample(data, byte_en, is_read, map);
    if (get_coverage(UVM_CVR_FIELD_VALS)) begin
      if(!is_read) begin
          wr_fld_covg.sample();
      end
      if(is_read) begin
         rd_fld_covg.sample();
      end
    end
  endfunction

  virtual function void sample_values();
    super.sample_values();
    if (get_coverage(UVM_CVR_FIELD_VALS)) begin
      wr_fld_covg.sample();
      rd_fld_covg.sample();
    end
  endfunction

  virtual function void build();
    uvm_reg_field fld_set[$];
    uvm_reg_field_config_ta ta = get_field_config(getconfigUID());
    build_uvm_reg_fields(this, ta, fld_set);
    
    phy_uc_cmn_int_sts_en_31_0 = fld_set[0];
  endfunction

  function new(input string name="T_phy_uc_cmn_int_sts_en_128");
    super.new(name, 32, build_coverage(UVM_CVR_FIELD_VALS));
    if (has_coverage(UVM_CVR_FIELD_VALS)) begin
      wr_fld_covg = new();
      rd_fld_covg = new();
    end
  endfunction

endclass


/////////////////////////////////////////////////////
//                phy_uc_cmn_int_sts_set
/////////////////////////////////////////////////////
class T_phy_uc_cmn_int_sts_set_126 extends cdns_uvm_reg;

  `uvm_object_utils(T_phy_uc_cmn_int_sts_set_126)
  rand uvm_reg_field phy_uc_cmn_int_sts_set_30_0;
  rand uvm_reg_field phy_uc_cmn_int_sts_set_31;
  
  covergroup wr_fld_covg;
    phy_uc_cmn_int_sts_set_30_0: coverpoint phy_uc_cmn_int_sts_set_30_0.value[30:0];
    phy_uc_cmn_int_sts_set_31: coverpoint phy_uc_cmn_int_sts_set_31.value[0:0];
  endgroup
  covergroup rd_fld_covg;
    phy_uc_cmn_int_sts_set_30_0: coverpoint phy_uc_cmn_int_sts_set_30_0.value[30:0];
    phy_uc_cmn_int_sts_set_31: coverpoint phy_uc_cmn_int_sts_set_31.value[0:0];
  endgroup

  protected virtual function void sample(uvm_reg_data_t data, uvm_reg_data_t byte_en, bit is_read, uvm_reg_map map);
    super.sample(data, byte_en, is_read, map);
    if (get_coverage(UVM_CVR_FIELD_VALS)) begin
      if(!is_read) begin
          wr_fld_covg.sample();
      end
      if(is_read) begin
         rd_fld_covg.sample();
      end
    end
  endfunction

  virtual function void sample_values();
    super.sample_values();
    if (get_coverage(UVM_CVR_FIELD_VALS)) begin
      wr_fld_covg.sample();
      rd_fld_covg.sample();
    end
  endfunction

  virtual function void build();
    uvm_reg_field fld_set[$];
    uvm_reg_field_config_ta ta = get_field_config(getconfigUID());
    build_uvm_reg_fields(this, ta, fld_set);
    
    phy_uc_cmn_int_sts_set_30_0 = fld_set[0];
    phy_uc_cmn_int_sts_set_31 = fld_set[1];
  endfunction

  function new(input string name="T_phy_uc_cmn_int_sts_set_126");
    super.new(name, 32, build_coverage(UVM_CVR_FIELD_VALS));
    if (has_coverage(UVM_CVR_FIELD_VALS)) begin
      wr_fld_covg = new();
      rd_fld_covg = new();
    end
  endfunction

endclass


/////////////////////////////////////////////////////
//                phy_uc_ln_int_sts
/////////////////////////////////////////////////////
class T_phy_uc_ln_int_sts_129 extends cdns_uvm_reg;

  `uvm_object_utils(T_phy_uc_ln_int_sts_129)
  rand uvm_reg_field phy_uc_ln_int_sts_15_0;
  rand uvm_reg_field phy_uc_ln_int_sts_31_16;
  
  covergroup wr_fld_covg;
    phy_uc_ln_int_sts_15_0: coverpoint phy_uc_ln_int_sts_15_0.value[15:0];
    phy_uc_ln_int_sts_31_16: coverpoint phy_uc_ln_int_sts_31_16.value[15:0];
  endgroup
  covergroup rd_fld_covg;
    phy_uc_ln_int_sts_15_0: coverpoint phy_uc_ln_int_sts_15_0.value[15:0];
    phy_uc_ln_int_sts_31_16: coverpoint phy_uc_ln_int_sts_31_16.value[15:0];
  endgroup

  protected virtual function void sample(uvm_reg_data_t data, uvm_reg_data_t byte_en, bit is_read, uvm_reg_map map);
    super.sample(data, byte_en, is_read, map);
    if (get_coverage(UVM_CVR_FIELD_VALS)) begin
      if(!is_read) begin
          wr_fld_covg.sample();
      end
      if(is_read) begin
         rd_fld_covg.sample();
      end
    end
  endfunction

  virtual function void sample_values();
    super.sample_values();
    if (get_coverage(UVM_CVR_FIELD_VALS)) begin
      wr_fld_covg.sample();
      rd_fld_covg.sample();
    end
  endfunction

  virtual function void build();
    uvm_reg_field fld_set[$];
    uvm_reg_field_config_ta ta = get_field_config(getconfigUID());
    build_uvm_reg_fields(this, ta, fld_set);
    
    phy_uc_ln_int_sts_15_0 = fld_set[0];
    phy_uc_ln_int_sts_31_16 = fld_set[1];
  endfunction

  function new(input string name="T_phy_uc_ln_int_sts_129");
    super.new(name, 32, build_coverage(UVM_CVR_FIELD_VALS));
    if (has_coverage(UVM_CVR_FIELD_VALS)) begin
      wr_fld_covg = new();
      rd_fld_covg = new();
    end
  endfunction

endclass


/////////////////////////////////////////////////////
//                uc_top_scrpad10
/////////////////////////////////////////////////////
class T_uc_top_scrpad10_116 extends cdns_uvm_reg;

  `uvm_object_utils(T_uc_top_scrpad10_116)
  rand uvm_reg_field uc_top_scrpad10_31_0;
  
  covergroup wr_fld_covg;
    uc_top_scrpad10_31_0: coverpoint uc_top_scrpad10_31_0.value[31:0];
  endgroup
  covergroup rd_fld_covg;
    uc_top_scrpad10_31_0: coverpoint uc_top_scrpad10_31_0.value[31:0];
  endgroup

  protected virtual function void sample(uvm_reg_data_t data, uvm_reg_data_t byte_en, bit is_read, uvm_reg_map map);
    super.sample(data, byte_en, is_read, map);
    if (get_coverage(UVM_CVR_FIELD_VALS)) begin
      if(!is_read) begin
          wr_fld_covg.sample();
      end
      if(is_read) begin
         rd_fld_covg.sample();
      end
    end
  endfunction

  virtual function void sample_values();
    super.sample_values();
    if (get_coverage(UVM_CVR_FIELD_VALS)) begin
      wr_fld_covg.sample();
      rd_fld_covg.sample();
    end
  endfunction

  virtual function void build();
    uvm_reg_field fld_set[$];
    uvm_reg_field_config_ta ta = get_field_config(getconfigUID());
    build_uvm_reg_fields(this, ta, fld_set);
    
    uc_top_scrpad10_31_0 = fld_set[0];
  endfunction

  function new(input string name="T_uc_top_scrpad10_116");
    super.new(name, 32, build_coverage(UVM_CVR_FIELD_VALS));
    if (has_coverage(UVM_CVR_FIELD_VALS)) begin
      wr_fld_covg = new();
      rd_fld_covg = new();
    end
  endfunction

endclass


/////////////////////////////////////////////////////
//                uc_top_scrpad11
/////////////////////////////////////////////////////
class T_uc_top_scrpad11_117 extends cdns_uvm_reg;

  `uvm_object_utils(T_uc_top_scrpad11_117)
  rand uvm_reg_field uc_top_scrpad11_31_0;
  
  covergroup wr_fld_covg;
    uc_top_scrpad11_31_0: coverpoint uc_top_scrpad11_31_0.value[31:0];
  endgroup
  covergroup rd_fld_covg;
    uc_top_scrpad11_31_0: coverpoint uc_top_scrpad11_31_0.value[31:0];
  endgroup

  protected virtual function void sample(uvm_reg_data_t data, uvm_reg_data_t byte_en, bit is_read, uvm_reg_map map);
    super.sample(data, byte_en, is_read, map);
    if (get_coverage(UVM_CVR_FIELD_VALS)) begin
      if(!is_read) begin
          wr_fld_covg.sample();
      end
      if(is_read) begin
         rd_fld_covg.sample();
      end
    end
  endfunction

  virtual function void sample_values();
    super.sample_values();
    if (get_coverage(UVM_CVR_FIELD_VALS)) begin
      wr_fld_covg.sample();
      rd_fld_covg.sample();
    end
  endfunction

  virtual function void build();
    uvm_reg_field fld_set[$];
    uvm_reg_field_config_ta ta = get_field_config(getconfigUID());
    build_uvm_reg_fields(this, ta, fld_set);
    
    uc_top_scrpad11_31_0 = fld_set[0];
  endfunction

  function new(input string name="T_uc_top_scrpad11_117");
    super.new(name, 32, build_coverage(UVM_CVR_FIELD_VALS));
    if (has_coverage(UVM_CVR_FIELD_VALS)) begin
      wr_fld_covg = new();
      rd_fld_covg = new();
    end
  endfunction

endclass


/////////////////////////////////////////////////////
//                uc_top_scrpad12
/////////////////////////////////////////////////////
class T_uc_top_scrpad12_133 extends cdns_uvm_reg;

  `uvm_object_utils(T_uc_top_scrpad12_133)
  rand uvm_reg_field uc_top_scrpad12_31_0;
  
  covergroup wr_fld_covg;
    uc_top_scrpad12_31_0: coverpoint uc_top_scrpad12_31_0.value[31:0];
  endgroup
  covergroup rd_fld_covg;
    uc_top_scrpad12_31_0: coverpoint uc_top_scrpad12_31_0.value[31:0];
  endgroup

  protected virtual function void sample(uvm_reg_data_t data, uvm_reg_data_t byte_en, bit is_read, uvm_reg_map map);
    super.sample(data, byte_en, is_read, map);
    if (get_coverage(UVM_CVR_FIELD_VALS)) begin
      if(!is_read) begin
          wr_fld_covg.sample();
      end
      if(is_read) begin
         rd_fld_covg.sample();
      end
    end
  endfunction

  virtual function void sample_values();
    super.sample_values();
    if (get_coverage(UVM_CVR_FIELD_VALS)) begin
      wr_fld_covg.sample();
      rd_fld_covg.sample();
    end
  endfunction

  virtual function void build();
    uvm_reg_field fld_set[$];
    uvm_reg_field_config_ta ta = get_field_config(getconfigUID());
    build_uvm_reg_fields(this, ta, fld_set);
    
    uc_top_scrpad12_31_0 = fld_set[0];
  endfunction

  function new(input string name="T_uc_top_scrpad12_133");
    super.new(name, 32, build_coverage(UVM_CVR_FIELD_VALS));
    if (has_coverage(UVM_CVR_FIELD_VALS)) begin
      wr_fld_covg = new();
      rd_fld_covg = new();
    end
  endfunction

endclass


/////////////////////////////////////////////////////
//                uc_top_scrpad13
/////////////////////////////////////////////////////
class T_uc_top_scrpad13_134 extends cdns_uvm_reg;

  `uvm_object_utils(T_uc_top_scrpad13_134)
  rand uvm_reg_field uc_top_scrpad13_31_0;
  
  covergroup wr_fld_covg;
    uc_top_scrpad13_31_0: coverpoint uc_top_scrpad13_31_0.value[31:0];
  endgroup
  covergroup rd_fld_covg;
    uc_top_scrpad13_31_0: coverpoint uc_top_scrpad13_31_0.value[31:0];
  endgroup

  protected virtual function void sample(uvm_reg_data_t data, uvm_reg_data_t byte_en, bit is_read, uvm_reg_map map);
    super.sample(data, byte_en, is_read, map);
    if (get_coverage(UVM_CVR_FIELD_VALS)) begin
      if(!is_read) begin
          wr_fld_covg.sample();
      end
      if(is_read) begin
         rd_fld_covg.sample();
      end
    end
  endfunction

  virtual function void sample_values();
    super.sample_values();
    if (get_coverage(UVM_CVR_FIELD_VALS)) begin
      wr_fld_covg.sample();
      rd_fld_covg.sample();
    end
  endfunction

  virtual function void build();
    uvm_reg_field fld_set[$];
    uvm_reg_field_config_ta ta = get_field_config(getconfigUID());
    build_uvm_reg_fields(this, ta, fld_set);
    
    uc_top_scrpad13_31_0 = fld_set[0];
  endfunction

  function new(input string name="T_uc_top_scrpad13_134");
    super.new(name, 32, build_coverage(UVM_CVR_FIELD_VALS));
    if (has_coverage(UVM_CVR_FIELD_VALS)) begin
      wr_fld_covg = new();
      rd_fld_covg = new();
    end
  endfunction

endclass


/////////////////////////////////////////////////////
//                uc_top_scrpad14
/////////////////////////////////////////////////////
class T_uc_top_scrpad14_135 extends cdns_uvm_reg;

  `uvm_object_utils(T_uc_top_scrpad14_135)
  rand uvm_reg_field uc_top_scrpad14_31_0;
  
  covergroup wr_fld_covg;
    uc_top_scrpad14_31_0: coverpoint uc_top_scrpad14_31_0.value[31:0];
  endgroup
  covergroup rd_fld_covg;
    uc_top_scrpad14_31_0: coverpoint uc_top_scrpad14_31_0.value[31:0];
  endgroup

  protected virtual function void sample(uvm_reg_data_t data, uvm_reg_data_t byte_en, bit is_read, uvm_reg_map map);
    super.sample(data, byte_en, is_read, map);
    if (get_coverage(UVM_CVR_FIELD_VALS)) begin
      if(!is_read) begin
          wr_fld_covg.sample();
      end
      if(is_read) begin
         rd_fld_covg.sample();
      end
    end
  endfunction

  virtual function void sample_values();
    super.sample_values();
    if (get_coverage(UVM_CVR_FIELD_VALS)) begin
      wr_fld_covg.sample();
      rd_fld_covg.sample();
    end
  endfunction

  virtual function void build();
    uvm_reg_field fld_set[$];
    uvm_reg_field_config_ta ta = get_field_config(getconfigUID());
    build_uvm_reg_fields(this, ta, fld_set);
    
    uc_top_scrpad14_31_0 = fld_set[0];
  endfunction

  function new(input string name="T_uc_top_scrpad14_135");
    super.new(name, 32, build_coverage(UVM_CVR_FIELD_VALS));
    if (has_coverage(UVM_CVR_FIELD_VALS)) begin
      wr_fld_covg = new();
      rd_fld_covg = new();
    end
  endfunction

endclass


/////////////////////////////////////////////////////
//                uc_top_scrpad8
/////////////////////////////////////////////////////
class T_uc_top_scrpad8_114 extends cdns_uvm_reg;

  `uvm_object_utils(T_uc_top_scrpad8_114)
  rand uvm_reg_field uc_top_scrpad8_31_0;
  
  covergroup wr_fld_covg;
    uc_top_scrpad8_31_0: coverpoint uc_top_scrpad8_31_0.value[31:0];
  endgroup
  covergroup rd_fld_covg;
    uc_top_scrpad8_31_0: coverpoint uc_top_scrpad8_31_0.value[31:0];
  endgroup

  protected virtual function void sample(uvm_reg_data_t data, uvm_reg_data_t byte_en, bit is_read, uvm_reg_map map);
    super.sample(data, byte_en, is_read, map);
    if (get_coverage(UVM_CVR_FIELD_VALS)) begin
      if(!is_read) begin
          wr_fld_covg.sample();
      end
      if(is_read) begin
         rd_fld_covg.sample();
      end
    end
  endfunction

  virtual function void sample_values();
    super.sample_values();
    if (get_coverage(UVM_CVR_FIELD_VALS)) begin
      wr_fld_covg.sample();
      rd_fld_covg.sample();
    end
  endfunction

  virtual function void build();
    uvm_reg_field fld_set[$];
    uvm_reg_field_config_ta ta = get_field_config(getconfigUID());
    build_uvm_reg_fields(this, ta, fld_set);
    
    uc_top_scrpad8_31_0 = fld_set[0];
  endfunction

  function new(input string name="T_uc_top_scrpad8_114");
    super.new(name, 32, build_coverage(UVM_CVR_FIELD_VALS));
    if (has_coverage(UVM_CVR_FIELD_VALS)) begin
      wr_fld_covg = new();
      rd_fld_covg = new();
    end
  endfunction

endclass


/////////////////////////////////////////////////////
//                uc_top_scrpad9
/////////////////////////////////////////////////////
class T_uc_top_scrpad9_115 extends cdns_uvm_reg;

  `uvm_object_utils(T_uc_top_scrpad9_115)
  rand uvm_reg_field uc_top_scrpad9_31_0;
  
  covergroup wr_fld_covg;
    uc_top_scrpad9_31_0: coverpoint uc_top_scrpad9_31_0.value[31:0];
  endgroup
  covergroup rd_fld_covg;
    uc_top_scrpad9_31_0: coverpoint uc_top_scrpad9_31_0.value[31:0];
  endgroup

  protected virtual function void sample(uvm_reg_data_t data, uvm_reg_data_t byte_en, bit is_read, uvm_reg_map map);
    super.sample(data, byte_en, is_read, map);
    if (get_coverage(UVM_CVR_FIELD_VALS)) begin
      if(!is_read) begin
          wr_fld_covg.sample();
      end
      if(is_read) begin
         rd_fld_covg.sample();
      end
    end
  endfunction

  virtual function void sample_values();
    super.sample_values();
    if (get_coverage(UVM_CVR_FIELD_VALS)) begin
      wr_fld_covg.sample();
      rd_fld_covg.sample();
    end
  endfunction

  virtual function void build();
    uvm_reg_field fld_set[$];
    uvm_reg_field_config_ta ta = get_field_config(getconfigUID());
    build_uvm_reg_fields(this, ta, fld_set);
    
    uc_top_scrpad9_31_0 = fld_set[0];
  endfunction

  function new(input string name="T_uc_top_scrpad9_115");
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
class T_sd3101_phy_registers_136 extends cdns_uvm_reg_block;

  `uvm_object_utils(T_sd3101_phy_registers_136)
  rand T_dtb_ctrl_119 dtb_ctrl;
  rand T_dtb_data_120 dtb_data;
  rand T_phy_isolation_ctrl_121 phy_isolation_ctrl;
  rand T_phy_pma_cmn_ctrl_sts_112 phy_pma_cmn_ctrl_sts;
  rand T_phy_pma_cmn_ctrl_sts_clr_113 phy_pma_cmn_ctrl_sts_clr;
  rand T_phy_pma_iso_cmn_ctrl_118 phy_pma_iso_cmn_ctrl;
  rand T_phy_soc_int_sts_122 phy_soc_int_sts;
  rand T_phy_soc_int_sts_en_124 phy_soc_int_sts_en;
  rand T_phy_soc_int_sts_set_123 phy_soc_int_sts_set;
  rand T_phy_top_uc_event_ctr_130 phy_top_uc_event_ctr;
  rand T_phy_top_uc_watchdog_131 phy_top_uc_watchdog;
  rand T_phy_top_uc_watchdog_cfg_132 phy_top_uc_watchdog_cfg;
  rand T_phy_uc_cmn_en_int_sts_127 phy_uc_cmn_en_int_sts;
  rand T_phy_uc_cmn_int_sts_125 phy_uc_cmn_int_sts;
  rand T_phy_uc_cmn_int_sts_en_128 phy_uc_cmn_int_sts_en;
  rand T_phy_uc_cmn_int_sts_set_126 phy_uc_cmn_int_sts_set;
  rand T_phy_uc_ln_int_sts_129 phy_uc_ln_int_sts;
  rand T_uc_top_scrpad10_116 uc_top_scrpad10;
  rand T_uc_top_scrpad11_117 uc_top_scrpad11;
  rand T_uc_top_scrpad12_133 uc_top_scrpad12;
  rand T_uc_top_scrpad13_134 uc_top_scrpad13;
  rand T_uc_top_scrpad14_135 uc_top_scrpad14;
  rand T_uc_top_scrpad8_114 uc_top_scrpad8;
  rand T_uc_top_scrpad9_115 uc_top_scrpad9;



  virtual function void build();
    uvm_reg  reg_set[$];
    string config_path = get_hier_path();
    default_map = create_map(get_name(), `UVM_REG_ADDR_WIDTH'h38000, 4, UVM_LITTLE_ENDIAN, 1);
    begin
       uvm_reg_config_ta ta = get_reg_config("phy_pma_cmn_registers.sd3101_t4_registers_sd3101_phy_registers");
       build_uvm_regs(default_map, this, null, ta, reg_set);
    end
    if(! $cast(dtb_ctrl, reg_set[0]))
      `uvm_error("UVM_REG", "dtb_ctrl register casting error")
    if(! $cast(dtb_data, reg_set[1]))
      `uvm_error("UVM_REG", "dtb_data register casting error")
    if(! $cast(phy_isolation_ctrl, reg_set[2]))
      `uvm_error("UVM_REG", "phy_isolation_ctrl register casting error")
    if(! $cast(phy_pma_cmn_ctrl_sts, reg_set[3]))
      `uvm_error("UVM_REG", "phy_pma_cmn_ctrl_sts register casting error")
    if(! $cast(phy_pma_cmn_ctrl_sts_clr, reg_set[4]))
      `uvm_error("UVM_REG", "phy_pma_cmn_ctrl_sts_clr register casting error")
    if(! $cast(phy_pma_iso_cmn_ctrl, reg_set[5]))
      `uvm_error("UVM_REG", "phy_pma_iso_cmn_ctrl register casting error")
    if(! $cast(phy_soc_int_sts, reg_set[6]))
      `uvm_error("UVM_REG", "phy_soc_int_sts register casting error")
    if(! $cast(phy_soc_int_sts_en, reg_set[7]))
      `uvm_error("UVM_REG", "phy_soc_int_sts_en register casting error")
    if(! $cast(phy_soc_int_sts_set, reg_set[8]))
      `uvm_error("UVM_REG", "phy_soc_int_sts_set register casting error")
    if(! $cast(phy_top_uc_event_ctr, reg_set[9]))
      `uvm_error("UVM_REG", "phy_top_uc_event_ctr register casting error")
    if(! $cast(phy_top_uc_watchdog, reg_set[10]))
      `uvm_error("UVM_REG", "phy_top_uc_watchdog register casting error")
    if(! $cast(phy_top_uc_watchdog_cfg, reg_set[11]))
      `uvm_error("UVM_REG", "phy_top_uc_watchdog_cfg register casting error")
    if(! $cast(phy_uc_cmn_en_int_sts, reg_set[12]))
      `uvm_error("UVM_REG", "phy_uc_cmn_en_int_sts register casting error")
    if(! $cast(phy_uc_cmn_int_sts, reg_set[13]))
      `uvm_error("UVM_REG", "phy_uc_cmn_int_sts register casting error")
    if(! $cast(phy_uc_cmn_int_sts_en, reg_set[14]))
      `uvm_error("UVM_REG", "phy_uc_cmn_int_sts_en register casting error")
    if(! $cast(phy_uc_cmn_int_sts_set, reg_set[15]))
      `uvm_error("UVM_REG", "phy_uc_cmn_int_sts_set register casting error")
    if(! $cast(phy_uc_ln_int_sts, reg_set[16]))
      `uvm_error("UVM_REG", "phy_uc_ln_int_sts register casting error")
    if(! $cast(uc_top_scrpad10, reg_set[17]))
      `uvm_error("UVM_REG", "uc_top_scrpad10 register casting error")
    if(! $cast(uc_top_scrpad11, reg_set[18]))
      `uvm_error("UVM_REG", "uc_top_scrpad11 register casting error")
    if(! $cast(uc_top_scrpad12, reg_set[19]))
      `uvm_error("UVM_REG", "uc_top_scrpad12 register casting error")
    if(! $cast(uc_top_scrpad13, reg_set[20]))
      `uvm_error("UVM_REG", "uc_top_scrpad13 register casting error")
    if(! $cast(uc_top_scrpad14, reg_set[21]))
      `uvm_error("UVM_REG", "uc_top_scrpad14 register casting error")
    if(! $cast(uc_top_scrpad8, reg_set[22]))
      `uvm_error("UVM_REG", "uc_top_scrpad8 register casting error")
    if(! $cast(uc_top_scrpad9, reg_set[23]))
      `uvm_error("UVM_REG", "uc_top_scrpad9 register casting error")

  endfunction

  function new(input string name="sd3101_t4_registers_sd3101_phy_registers");
    super.new(name, UVM_NO_COVERAGE);
  endfunction

endclass


/////////////////////////////////////////////////////
//                phy_pma_cmn_registers
/////////////////////////////////////////////////////
class phy_pma_cmn_registers_vendor_cadence_library_cdns_lib_version_1685_2009 extends cdns_uvm_reg_block;

  `uvm_object_utils(phy_pma_cmn_registers_vendor_cadence_library_cdns_lib_version_1685_2009)

  uvm_reg_map default_map;
  uvm_reg_map sd3101_t4_registers;
  rand T_sd3101_phy_registers_136 sd3101_t4_registers_sd3101_phy_registers;

`include "cdn_regmodel_task_member.sv"
  virtual function void build();
    sd3101_t4_registers = create_map("sd3101_t4_registers", `UVM_REG_ADDR_WIDTH'h0, 4, UVM_LITTLE_ENDIAN, 1);
    default_map = sd3101_t4_registers;
    sd3101_t4_registers_sd3101_phy_registers = T_sd3101_phy_registers_136::type_id::create("sd3101_t4_registers_sd3101_phy_registers", , get_full_name());
    sd3101_t4_registers_sd3101_phy_registers.configure(this);
    sd3101_t4_registers_sd3101_phy_registers.build();

    //Mapping sd3101_t4_registers map
    sd3101_t4_registers_sd3101_phy_registers.default_map.add_parent_map(sd3101_t4_registers,`UVM_REG_ADDR_WIDTH'h38000);
    sd3101_t4_registers.set_submap_offset(sd3101_t4_registers_sd3101_phy_registers.default_map, `UVM_REG_ADDR_WIDTH'h38000);
    //Apply hdl_paths
    apply_hdl_paths(this);

  endfunction



  function new(input string name="phy_pma_cmn_registers");
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
         "T_dtb_ctrl_119": begin T_dtb_ctrl_119 dtb_ctrl = new(objectname); create = dtb_ctrl;  end
         "T_dtb_data_120": begin T_dtb_data_120 dtb_data = new(objectname); create = dtb_data;  end
         "T_phy_isolation_ctrl_121": begin T_phy_isolation_ctrl_121 phy_isolation_ctrl = new(objectname); create = phy_isolation_ctrl;  end
         "T_phy_pma_cmn_ctrl_sts_112": begin T_phy_pma_cmn_ctrl_sts_112 phy_pma_cmn_ctrl_sts = new(objectname); create = phy_pma_cmn_ctrl_sts;  end
         "T_phy_pma_cmn_ctrl_sts_clr_113": begin T_phy_pma_cmn_ctrl_sts_clr_113 phy_pma_cmn_ctrl_sts_clr = new(objectname); create = phy_pma_cmn_ctrl_sts_clr;  end
         "T_phy_pma_iso_cmn_ctrl_118": begin T_phy_pma_iso_cmn_ctrl_118 phy_pma_iso_cmn_ctrl = new(objectname); create = phy_pma_iso_cmn_ctrl;  end
         "T_phy_soc_int_sts_122": begin T_phy_soc_int_sts_122 phy_soc_int_sts = new(objectname); create = phy_soc_int_sts;  end
         "T_phy_soc_int_sts_en_124": begin T_phy_soc_int_sts_en_124 phy_soc_int_sts_en = new(objectname); create = phy_soc_int_sts_en;  end
         "T_phy_soc_int_sts_set_123": begin T_phy_soc_int_sts_set_123 phy_soc_int_sts_set = new(objectname); create = phy_soc_int_sts_set;  end
         "T_phy_top_uc_event_ctr_130": begin T_phy_top_uc_event_ctr_130 phy_top_uc_event_ctr = new(objectname); create = phy_top_uc_event_ctr;  end
         "T_phy_top_uc_watchdog_131": begin T_phy_top_uc_watchdog_131 phy_top_uc_watchdog = new(objectname); create = phy_top_uc_watchdog;  end
         "T_phy_top_uc_watchdog_cfg_132": begin T_phy_top_uc_watchdog_cfg_132 phy_top_uc_watchdog_cfg = new(objectname); create = phy_top_uc_watchdog_cfg;  end
         "T_phy_uc_cmn_en_int_sts_127": begin T_phy_uc_cmn_en_int_sts_127 phy_uc_cmn_en_int_sts = new(objectname); create = phy_uc_cmn_en_int_sts;  end
         "T_phy_uc_cmn_int_sts_125": begin T_phy_uc_cmn_int_sts_125 phy_uc_cmn_int_sts = new(objectname); create = phy_uc_cmn_int_sts;  end
         "T_phy_uc_cmn_int_sts_en_128": begin T_phy_uc_cmn_int_sts_en_128 phy_uc_cmn_int_sts_en = new(objectname); create = phy_uc_cmn_int_sts_en;  end
         "T_phy_uc_cmn_int_sts_set_126": begin T_phy_uc_cmn_int_sts_set_126 phy_uc_cmn_int_sts_set = new(objectname); create = phy_uc_cmn_int_sts_set;  end
         "T_phy_uc_ln_int_sts_129": begin T_phy_uc_ln_int_sts_129 phy_uc_ln_int_sts = new(objectname); create = phy_uc_ln_int_sts;  end
         "T_uc_top_scrpad10_116": begin T_uc_top_scrpad10_116 uc_top_scrpad10 = new(objectname); create = uc_top_scrpad10;  end
         "T_uc_top_scrpad11_117": begin T_uc_top_scrpad11_117 uc_top_scrpad11 = new(objectname); create = uc_top_scrpad11;  end
         "T_uc_top_scrpad12_133": begin T_uc_top_scrpad12_133 uc_top_scrpad12 = new(objectname); create = uc_top_scrpad12;  end
         "T_uc_top_scrpad13_134": begin T_uc_top_scrpad13_134 uc_top_scrpad13 = new(objectname); create = uc_top_scrpad13;  end
         "T_uc_top_scrpad14_135": begin T_uc_top_scrpad14_135 uc_top_scrpad14 = new(objectname); create = uc_top_scrpad14;  end
         "T_uc_top_scrpad8_114": begin T_uc_top_scrpad8_114 uc_top_scrpad8 = new(objectname); create = uc_top_scrpad8;  end
         "T_uc_top_scrpad9_115": begin T_uc_top_scrpad9_115 uc_top_scrpad9 = new(objectname); create = uc_top_scrpad9;  end

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
   cdns_uvmreg_utils_pkg_phy_pma_cmn_registers::factory=cdns_factory;


   return cdns_factory;
endfunction
cdns_factory_base cdns_factory = get_factory(no_factory);

endpackage



