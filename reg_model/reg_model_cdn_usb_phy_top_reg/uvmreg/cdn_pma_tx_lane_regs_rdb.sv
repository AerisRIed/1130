//*************************************************************//
//   ** File Generated Automatically
//   ** Please donot edit manually
//*************************************************************//


package cdn_pma_tx_lane_reg_pkg;
  import uvm_pkg::*;
  `include "uvm_macros.svh"
  import cdns_uvmreg_utils_pkg_pma_tx_lane_registers::*;

  bit no_factory = 0; 

/////////////////////////////////////////////////////
//                tx_bist_ctrl
/////////////////////////////////////////////////////
class T_tx_bist_ctrl_644 extends cdns_uvm_reg;

  `uvm_object_utils(T_tx_bist_ctrl_644)
  rand uvm_reg_field tx_bist_ctrl_0;
  rand uvm_reg_field tx_bist_ctrl_1;
  rand uvm_reg_field tx_bist_ctrl_3_2;
  rand uvm_reg_field tx_bist_ctrl_4;
  rand uvm_reg_field tx_bist_ctrl_7_5;
  rand uvm_reg_field tx_bist_ctrl_11_8;
  rand uvm_reg_field tx_bist_ctrl_15_12;
  rand uvm_reg_field tx_bist_ctrl_31_16;
  
  covergroup wr_fld_covg;
    tx_bist_ctrl_0: coverpoint tx_bist_ctrl_0.value[0:0];
    tx_bist_ctrl_1: coverpoint tx_bist_ctrl_1.value[0:0];
    tx_bist_ctrl_3_2: coverpoint tx_bist_ctrl_3_2.value[1:0];
    tx_bist_ctrl_4: coverpoint tx_bist_ctrl_4.value[0:0];
    tx_bist_ctrl_7_5: coverpoint tx_bist_ctrl_7_5.value[2:0];
    tx_bist_ctrl_11_8: coverpoint tx_bist_ctrl_11_8.value[3:0];
    tx_bist_ctrl_15_12: coverpoint tx_bist_ctrl_15_12.value[3:0];
    tx_bist_ctrl_31_16: coverpoint tx_bist_ctrl_31_16.value[15:0];
  endgroup
  covergroup rd_fld_covg;
    tx_bist_ctrl_0: coverpoint tx_bist_ctrl_0.value[0:0];
    tx_bist_ctrl_1: coverpoint tx_bist_ctrl_1.value[0:0];
    tx_bist_ctrl_3_2: coverpoint tx_bist_ctrl_3_2.value[1:0];
    tx_bist_ctrl_4: coverpoint tx_bist_ctrl_4.value[0:0];
    tx_bist_ctrl_7_5: coverpoint tx_bist_ctrl_7_5.value[2:0];
    tx_bist_ctrl_11_8: coverpoint tx_bist_ctrl_11_8.value[3:0];
    tx_bist_ctrl_15_12: coverpoint tx_bist_ctrl_15_12.value[3:0];
    tx_bist_ctrl_31_16: coverpoint tx_bist_ctrl_31_16.value[15:0];
  endgroup

  protected virtual function void sample(uvm_reg_data_t data, uvm_reg_data_t byte_en, bit is_read, uvm_reg_map map);
    super.sample(data, byte_en, is_read, map);
    if (get_coverage(UVM_CVR_FIELD_VALS)) begin
      if(!is_read) begin
          wr_fld_covg.sample();
      end
      if(is_read) begin
         rd_fld_covg.sample();
      end
    end
  endfunction

  virtual function void sample_values();
    super.sample_values();
    if (get_coverage(UVM_CVR_FIELD_VALS)) begin
      wr_fld_covg.sample();
      rd_fld_covg.sample();
    end
  endfunction

  virtual function void build();
    uvm_reg_field fld_set[$];
    uvm_reg_field_config_ta ta = get_field_config(getconfigUID());
    build_uvm_reg_fields(this, ta, fld_set);
    
    tx_bist_ctrl_0 = fld_set[0];
    tx_bist_ctrl_1 = fld_set[1];
    tx_bist_ctrl_3_2 = fld_set[2];
    tx_bist_ctrl_4 = fld_set[3];
    tx_bist_ctrl_7_5 = fld_set[4];
    tx_bist_ctrl_11_8 = fld_set[5];
    tx_bist_ctrl_15_12 = fld_set[6];
    tx_bist_ctrl_31_16 = fld_set[7];
  endfunction

  function new(input string name="T_tx_bist_ctrl_644");
    super.new(name, 32, build_coverage(UVM_CVR_FIELD_VALS));
    if (has_coverage(UVM_CVR_FIELD_VALS)) begin
      wr_fld_covg = new();
      rd_fld_covg = new();
    end
  endfunction

endclass


/////////////////////////////////////////////////////
//                tx_bist_seed0
/////////////////////////////////////////////////////
class T_tx_bist_seed0_646 extends cdns_uvm_reg;

  `uvm_object_utils(T_tx_bist_seed0_646)
  rand uvm_reg_field tx_bist_seed0_2_0;
  rand uvm_reg_field tx_bist_seed0_15_3;
  rand uvm_reg_field tx_bist_seed0_31_16;
  
  covergroup wr_fld_covg;
    tx_bist_seed0_2_0: coverpoint tx_bist_seed0_2_0.value[2:0];
    tx_bist_seed0_15_3: coverpoint tx_bist_seed0_15_3.value[12:0];
    tx_bist_seed0_31_16: coverpoint tx_bist_seed0_31_16.value[15:0];
  endgroup
  covergroup rd_fld_covg;
    tx_bist_seed0_2_0: coverpoint tx_bist_seed0_2_0.value[2:0];
    tx_bist_seed0_15_3: coverpoint tx_bist_seed0_15_3.value[12:0];
    tx_bist_seed0_31_16: coverpoint tx_bist_seed0_31_16.value[15:0];
  endgroup

  protected virtual function void sample(uvm_reg_data_t data, uvm_reg_data_t byte_en, bit is_read, uvm_reg_map map);
    super.sample(data, byte_en, is_read, map);
    if (get_coverage(UVM_CVR_FIELD_VALS)) begin
      if(!is_read) begin
          wr_fld_covg.sample();
      end
      if(is_read) begin
         rd_fld_covg.sample();
      end
    end
  endfunction

  virtual function void sample_values();
    super.sample_values();
    if (get_coverage(UVM_CVR_FIELD_VALS)) begin
      wr_fld_covg.sample();
      rd_fld_covg.sample();
    end
  endfunction

  virtual function void build();
    uvm_reg_field fld_set[$];
    uvm_reg_field_config_ta ta = get_field_config(getconfigUID());
    build_uvm_reg_fields(this, ta, fld_set);
    
    tx_bist_seed0_2_0 = fld_set[0];
    tx_bist_seed0_15_3 = fld_set[1];
    tx_bist_seed0_31_16 = fld_set[2];
  endfunction

  function new(input string name="T_tx_bist_seed0_646");
    super.new(name, 32, build_coverage(UVM_CVR_FIELD_VALS));
    if (has_coverage(UVM_CVR_FIELD_VALS)) begin
      wr_fld_covg = new();
      rd_fld_covg = new();
    end
  endfunction

endclass


/////////////////////////////////////////////////////
//                tx_bist_seed1
/////////////////////////////////////////////////////
class T_tx_bist_seed1_647 extends cdns_uvm_reg;

  `uvm_object_utils(T_tx_bist_seed1_647)
  rand uvm_reg_field tx_bist_seed1_14_0;
  rand uvm_reg_field tx_bist_seed1_15;
  rand uvm_reg_field tx_bist_seed1_31_16;
  
  covergroup wr_fld_covg;
    tx_bist_seed1_14_0: coverpoint tx_bist_seed1_14_0.value[14:0];
    tx_bist_seed1_15: coverpoint tx_bist_seed1_15.value[0:0];
    tx_bist_seed1_31_16: coverpoint tx_bist_seed1_31_16.value[15:0];
  endgroup
  covergroup rd_fld_covg;
    tx_bist_seed1_14_0: coverpoint tx_bist_seed1_14_0.value[14:0];
    tx_bist_seed1_15: coverpoint tx_bist_seed1_15.value[0:0];
    tx_bist_seed1_31_16: coverpoint tx_bist_seed1_31_16.value[15:0];
  endgroup

  protected virtual function void sample(uvm_reg_data_t data, uvm_reg_data_t byte_en, bit is_read, uvm_reg_map map);
    super.sample(data, byte_en, is_read, map);
    if (get_coverage(UVM_CVR_FIELD_VALS)) begin
      if(!is_read) begin
          wr_fld_covg.sample();
      end
      if(is_read) begin
         rd_fld_covg.sample();
      end
    end
  endfunction

  virtual function void sample_values();
    super.sample_values();
    if (get_coverage(UVM_CVR_FIELD_VALS)) begin
      wr_fld_covg.sample();
      rd_fld_covg.sample();
    end
  endfunction

  virtual function void build();
    uvm_reg_field fld_set[$];
    uvm_reg_field_config_ta ta = get_field_config(getconfigUID());
    build_uvm_reg_fields(this, ta, fld_set);
    
    tx_bist_seed1_14_0 = fld_set[0];
    tx_bist_seed1_15 = fld_set[1];
    tx_bist_seed1_31_16 = fld_set[2];
  endfunction

  function new(input string name="T_tx_bist_seed1_647");
    super.new(name, 32, build_coverage(UVM_CVR_FIELD_VALS));
    if (has_coverage(UVM_CVR_FIELD_VALS)) begin
      wr_fld_covg = new();
      rd_fld_covg = new();
    end
  endfunction

endclass


/////////////////////////////////////////////////////
//                tx_bist_uddwr
/////////////////////////////////////////////////////
class T_tx_bist_uddwr_645 extends cdns_uvm_reg;

  `uvm_object_utils(T_tx_bist_uddwr_645)
  rand uvm_reg_field tx_bist_uddwr_9_0;
  rand uvm_reg_field tx_bist_uddwr_15_10;
  rand uvm_reg_field tx_bist_uddwr_31_16;
  
  covergroup wr_fld_covg;
    tx_bist_uddwr_9_0: coverpoint tx_bist_uddwr_9_0.value[9:0];
    tx_bist_uddwr_15_10: coverpoint tx_bist_uddwr_15_10.value[5:0];
    tx_bist_uddwr_31_16: coverpoint tx_bist_uddwr_31_16.value[15:0];
  endgroup
  covergroup rd_fld_covg;
    tx_bist_uddwr_9_0: coverpoint tx_bist_uddwr_9_0.value[9:0];
    tx_bist_uddwr_15_10: coverpoint tx_bist_uddwr_15_10.value[5:0];
    tx_bist_uddwr_31_16: coverpoint tx_bist_uddwr_31_16.value[15:0];
  endgroup

  protected virtual function void sample(uvm_reg_data_t data, uvm_reg_data_t byte_en, bit is_read, uvm_reg_map map);
    super.sample(data, byte_en, is_read, map);
    if (get_coverage(UVM_CVR_FIELD_VALS)) begin
      if(!is_read) begin
          wr_fld_covg.sample();
      end
      if(is_read) begin
         rd_fld_covg.sample();
      end
    end
  endfunction

  virtual function void sample_values();
    super.sample_values();
    if (get_coverage(UVM_CVR_FIELD_VALS)) begin
      wr_fld_covg.sample();
      rd_fld_covg.sample();
    end
  endfunction

  virtual function void build();
    uvm_reg_field fld_set[$];
    uvm_reg_field_config_ta ta = get_field_config(getconfigUID());
    build_uvm_reg_fields(this, ta, fld_set);
    
    tx_bist_uddwr_9_0 = fld_set[0];
    tx_bist_uddwr_15_10 = fld_set[1];
    tx_bist_uddwr_31_16 = fld_set[2];
  endfunction

  function new(input string name="T_tx_bist_uddwr_645");
    super.new(name, 32, build_coverage(UVM_CVR_FIELD_VALS));
    if (has_coverage(UVM_CVR_FIELD_VALS)) begin
      wr_fld_covg = new();
      rd_fld_covg = new();
    end
  endfunction

endclass


/////////////////////////////////////////////////////
//                tx_duty_cycle_cal_ctrl
/////////////////////////////////////////////////////
class T_tx_duty_cycle_cal_ctrl_648 extends cdns_uvm_reg;

  `uvm_object_utils(T_tx_duty_cycle_cal_ctrl_648)
  rand uvm_reg_field tx_duty_cycle_cal_ctrl_6_0;
  rand uvm_reg_field tx_duty_cycle_cal_ctrl_11_7;
  rand uvm_reg_field tx_duty_cycle_cal_ctrl_12;
  rand uvm_reg_field tx_duty_cycle_cal_ctrl_13;
  rand uvm_reg_field tx_duty_cycle_cal_ctrl_14;
  rand uvm_reg_field tx_duty_cycle_cal_ctrl_15;
  rand uvm_reg_field tx_duty_cycle_cal_ctrl_31_16;
  
  covergroup wr_fld_covg;
    tx_duty_cycle_cal_ctrl_6_0: coverpoint tx_duty_cycle_cal_ctrl_6_0.value[6:0];
    tx_duty_cycle_cal_ctrl_11_7: coverpoint tx_duty_cycle_cal_ctrl_11_7.value[4:0];
    tx_duty_cycle_cal_ctrl_12: coverpoint tx_duty_cycle_cal_ctrl_12.value[0:0];
    tx_duty_cycle_cal_ctrl_13: coverpoint tx_duty_cycle_cal_ctrl_13.value[0:0];
    tx_duty_cycle_cal_ctrl_14: coverpoint tx_duty_cycle_cal_ctrl_14.value[0:0];
    tx_duty_cycle_cal_ctrl_15: coverpoint tx_duty_cycle_cal_ctrl_15.value[0:0];
    tx_duty_cycle_cal_ctrl_31_16: coverpoint tx_duty_cycle_cal_ctrl_31_16.value[15:0];
  endgroup
  covergroup rd_fld_covg;
    tx_duty_cycle_cal_ctrl_6_0: coverpoint tx_duty_cycle_cal_ctrl_6_0.value[6:0];
    tx_duty_cycle_cal_ctrl_11_7: coverpoint tx_duty_cycle_cal_ctrl_11_7.value[4:0];
    tx_duty_cycle_cal_ctrl_12: coverpoint tx_duty_cycle_cal_ctrl_12.value[0:0];
    tx_duty_cycle_cal_ctrl_13: coverpoint tx_duty_cycle_cal_ctrl_13.value[0:0];
    tx_duty_cycle_cal_ctrl_14: coverpoint tx_duty_cycle_cal_ctrl_14.value[0:0];
    tx_duty_cycle_cal_ctrl_15: coverpoint tx_duty_cycle_cal_ctrl_15.value[0:0];
    tx_duty_cycle_cal_ctrl_31_16: coverpoint tx_duty_cycle_cal_ctrl_31_16.value[15:0];
  endgroup

  protected virtual function void sample(uvm_reg_data_t data, uvm_reg_data_t byte_en, bit is_read, uvm_reg_map map);
    super.sample(data, byte_en, is_read, map);
    if (get_coverage(UVM_CVR_FIELD_VALS)) begin
      if(!is_read) begin
          wr_fld_covg.sample();
      end
      if(is_read) begin
         rd_fld_covg.sample();
      end
    end
  endfunction

  virtual function void sample_values();
    super.sample_values();
    if (get_coverage(UVM_CVR_FIELD_VALS)) begin
      wr_fld_covg.sample();
      rd_fld_covg.sample();
    end
  endfunction

  virtual function void build();
    uvm_reg_field fld_set[$];
    uvm_reg_field_config_ta ta = get_field_config(getconfigUID());
    build_uvm_reg_fields(this, ta, fld_set);
    
    tx_duty_cycle_cal_ctrl_6_0 = fld_set[0];
    tx_duty_cycle_cal_ctrl_11_7 = fld_set[1];
    tx_duty_cycle_cal_ctrl_12 = fld_set[2];
    tx_duty_cycle_cal_ctrl_13 = fld_set[3];
    tx_duty_cycle_cal_ctrl_14 = fld_set[4];
    tx_duty_cycle_cal_ctrl_15 = fld_set[5];
    tx_duty_cycle_cal_ctrl_31_16 = fld_set[6];
  endfunction

  function new(input string name="T_tx_duty_cycle_cal_ctrl_648");
    super.new(name, 32, build_coverage(UVM_CVR_FIELD_VALS));
    if (has_coverage(UVM_CVR_FIELD_VALS)) begin
      wr_fld_covg = new();
      rd_fld_covg = new();
    end
  endfunction

endclass


/////////////////////////////////////////////////////
//                tx_duty_cycle_cal_init_tmr
/////////////////////////////////////////////////////
class T_tx_duty_cycle_cal_init_tmr_652 extends cdns_uvm_reg;

  `uvm_object_utils(T_tx_duty_cycle_cal_init_tmr_652)
  rand uvm_reg_field tx_duty_cycle_cal_init_tmr_8_0;
  rand uvm_reg_field tx_duty_cycle_cal_init_tmr_15_9;
  rand uvm_reg_field tx_duty_cycle_cal_init_tmr_31_16;
  
  covergroup wr_fld_covg;
    tx_duty_cycle_cal_init_tmr_8_0: coverpoint tx_duty_cycle_cal_init_tmr_8_0.value[8:0];
    tx_duty_cycle_cal_init_tmr_15_9: coverpoint tx_duty_cycle_cal_init_tmr_15_9.value[6:0];
    tx_duty_cycle_cal_init_tmr_31_16: coverpoint tx_duty_cycle_cal_init_tmr_31_16.value[15:0];
  endgroup
  covergroup rd_fld_covg;
    tx_duty_cycle_cal_init_tmr_8_0: coverpoint tx_duty_cycle_cal_init_tmr_8_0.value[8:0];
    tx_duty_cycle_cal_init_tmr_15_9: coverpoint tx_duty_cycle_cal_init_tmr_15_9.value[6:0];
    tx_duty_cycle_cal_init_tmr_31_16: coverpoint tx_duty_cycle_cal_init_tmr_31_16.value[15:0];
  endgroup

  protected virtual function void sample(uvm_reg_data_t data, uvm_reg_data_t byte_en, bit is_read, uvm_reg_map map);
    super.sample(data, byte_en, is_read, map);
    if (get_coverage(UVM_CVR_FIELD_VALS)) begin
      if(!is_read) begin
          wr_fld_covg.sample();
      end
      if(is_read) begin
         rd_fld_covg.sample();
      end
    end
  endfunction

  virtual function void sample_values();
    super.sample_values();
    if (get_coverage(UVM_CVR_FIELD_VALS)) begin
      wr_fld_covg.sample();
      rd_fld_covg.sample();
    end
  endfunction

  virtual function void build();
    uvm_reg_field fld_set[$];
    uvm_reg_field_config_ta ta = get_field_config(getconfigUID());
    build_uvm_reg_fields(this, ta, fld_set);
    
    tx_duty_cycle_cal_init_tmr_8_0 = fld_set[0];
    tx_duty_cycle_cal_init_tmr_15_9 = fld_set[1];
    tx_duty_cycle_cal_init_tmr_31_16 = fld_set[2];
  endfunction

  function new(input string name="T_tx_duty_cycle_cal_init_tmr_652");
    super.new(name, 32, build_coverage(UVM_CVR_FIELD_VALS));
    if (has_coverage(UVM_CVR_FIELD_VALS)) begin
      wr_fld_covg = new();
      rd_fld_covg = new();
    end
  endfunction

endclass


/////////////////////////////////////////////////////
//                tx_duty_cycle_cal_iter_tmr
/////////////////////////////////////////////////////
class T_tx_duty_cycle_cal_iter_tmr_653 extends cdns_uvm_reg;

  `uvm_object_utils(T_tx_duty_cycle_cal_iter_tmr_653)
  rand uvm_reg_field tx_duty_cycle_cal_iter_tmr_8_0;
  rand uvm_reg_field tx_duty_cycle_cal_iter_tmr_11_9;
  rand uvm_reg_field tx_duty_cycle_cal_iter_tmr_31_12;
  
  covergroup wr_fld_covg;
    tx_duty_cycle_cal_iter_tmr_8_0: coverpoint tx_duty_cycle_cal_iter_tmr_8_0.value[8:0];
    tx_duty_cycle_cal_iter_tmr_11_9: coverpoint tx_duty_cycle_cal_iter_tmr_11_9.value[2:0];
    tx_duty_cycle_cal_iter_tmr_31_12: coverpoint tx_duty_cycle_cal_iter_tmr_31_12.value[19:0];
  endgroup
  covergroup rd_fld_covg;
    tx_duty_cycle_cal_iter_tmr_8_0: coverpoint tx_duty_cycle_cal_iter_tmr_8_0.value[8:0];
    tx_duty_cycle_cal_iter_tmr_11_9: coverpoint tx_duty_cycle_cal_iter_tmr_11_9.value[2:0];
    tx_duty_cycle_cal_iter_tmr_31_12: coverpoint tx_duty_cycle_cal_iter_tmr_31_12.value[19:0];
  endgroup

  protected virtual function void sample(uvm_reg_data_t data, uvm_reg_data_t byte_en, bit is_read, uvm_reg_map map);
    super.sample(data, byte_en, is_read, map);
    if (get_coverage(UVM_CVR_FIELD_VALS)) begin
      if(!is_read) begin
          wr_fld_covg.sample();
      end
      if(is_read) begin
         rd_fld_covg.sample();
      end
    end
  endfunction

  virtual function void sample_values();
    super.sample_values();
    if (get_coverage(UVM_CVR_FIELD_VALS)) begin
      wr_fld_covg.sample();
      rd_fld_covg.sample();
    end
  endfunction

  virtual function void build();
    uvm_reg_field fld_set[$];
    uvm_reg_field_config_ta ta = get_field_config(getconfigUID());
    build_uvm_reg_fields(this, ta, fld_set);
    
    tx_duty_cycle_cal_iter_tmr_8_0 = fld_set[0];
    tx_duty_cycle_cal_iter_tmr_11_9 = fld_set[1];
    tx_duty_cycle_cal_iter_tmr_31_12 = fld_set[2];
  endfunction

  function new(input string name="T_tx_duty_cycle_cal_iter_tmr_653");
    super.new(name, 32, build_coverage(UVM_CVR_FIELD_VALS));
    if (has_coverage(UVM_CVR_FIELD_VALS)) begin
      wr_fld_covg = new();
      rd_fld_covg = new();
    end
  endfunction

endclass


/////////////////////////////////////////////////////
//                tx_duty_cycle_cal_ovrd
/////////////////////////////////////////////////////
class T_tx_duty_cycle_cal_ovrd_649 extends cdns_uvm_reg;

  `uvm_object_utils(T_tx_duty_cycle_cal_ovrd_649)
  rand uvm_reg_field tx_duty_cycle_cal_ovrd_6_0;
  rand uvm_reg_field tx_duty_cycle_cal_ovrd_13_7;
  rand uvm_reg_field tx_duty_cycle_cal_ovrd_14;
  rand uvm_reg_field tx_duty_cycle_cal_ovrd_15;
  rand uvm_reg_field tx_duty_cycle_cal_ovrd_31_16;
  
  covergroup wr_fld_covg;
    tx_duty_cycle_cal_ovrd_6_0: coverpoint tx_duty_cycle_cal_ovrd_6_0.value[6:0];
    tx_duty_cycle_cal_ovrd_13_7: coverpoint tx_duty_cycle_cal_ovrd_13_7.value[6:0];
    tx_duty_cycle_cal_ovrd_14: coverpoint tx_duty_cycle_cal_ovrd_14.value[0:0];
    tx_duty_cycle_cal_ovrd_15: coverpoint tx_duty_cycle_cal_ovrd_15.value[0:0];
    tx_duty_cycle_cal_ovrd_31_16: coverpoint tx_duty_cycle_cal_ovrd_31_16.value[15:0];
  endgroup
  covergroup rd_fld_covg;
    tx_duty_cycle_cal_ovrd_6_0: coverpoint tx_duty_cycle_cal_ovrd_6_0.value[6:0];
    tx_duty_cycle_cal_ovrd_13_7: coverpoint tx_duty_cycle_cal_ovrd_13_7.value[6:0];
    tx_duty_cycle_cal_ovrd_14: coverpoint tx_duty_cycle_cal_ovrd_14.value[0:0];
    tx_duty_cycle_cal_ovrd_15: coverpoint tx_duty_cycle_cal_ovrd_15.value[0:0];
    tx_duty_cycle_cal_ovrd_31_16: coverpoint tx_duty_cycle_cal_ovrd_31_16.value[15:0];
  endgroup

  protected virtual function void sample(uvm_reg_data_t data, uvm_reg_data_t byte_en, bit is_read, uvm_reg_map map);
    super.sample(data, byte_en, is_read, map);
    if (get_coverage(UVM_CVR_FIELD_VALS)) begin
      if(!is_read) begin
          wr_fld_covg.sample();
      end
      if(is_read) begin
         rd_fld_covg.sample();
      end
    end
  endfunction

  virtual function void sample_values();
    super.sample_values();
    if (get_coverage(UVM_CVR_FIELD_VALS)) begin
      wr_fld_covg.sample();
      rd_fld_covg.sample();
    end
  endfunction

  virtual function void build();
    uvm_reg_field fld_set[$];
    uvm_reg_field_config_ta ta = get_field_config(getconfigUID());
    build_uvm_reg_fields(this, ta, fld_set);
    
    tx_duty_cycle_cal_ovrd_6_0 = fld_set[0];
    tx_duty_cycle_cal_ovrd_13_7 = fld_set[1];
    tx_duty_cycle_cal_ovrd_14 = fld_set[2];
    tx_duty_cycle_cal_ovrd_15 = fld_set[3];
    tx_duty_cycle_cal_ovrd_31_16 = fld_set[4];
  endfunction

  function new(input string name="T_tx_duty_cycle_cal_ovrd_649");
    super.new(name, 32, build_coverage(UVM_CVR_FIELD_VALS));
    if (has_coverage(UVM_CVR_FIELD_VALS)) begin
      wr_fld_covg = new();
      rd_fld_covg = new();
    end
  endfunction

endclass


/////////////////////////////////////////////////////
//                tx_duty_cycle_cal_start
/////////////////////////////////////////////////////
class T_tx_duty_cycle_cal_start_650 extends cdns_uvm_reg;

  `uvm_object_utils(T_tx_duty_cycle_cal_start_650)
  rand uvm_reg_field tx_duty_cycle_cal_start_6_0;
  rand uvm_reg_field tx_duty_cycle_cal_start_14_7;
  rand uvm_reg_field tx_duty_cycle_cal_start_15;
  rand uvm_reg_field tx_duty_cycle_cal_start_31_16;
  
  covergroup wr_fld_covg;
    tx_duty_cycle_cal_start_6_0: coverpoint tx_duty_cycle_cal_start_6_0.value[6:0];
    tx_duty_cycle_cal_start_14_7: coverpoint tx_duty_cycle_cal_start_14_7.value[7:0];
    tx_duty_cycle_cal_start_15: coverpoint tx_duty_cycle_cal_start_15.value[0:0];
    tx_duty_cycle_cal_start_31_16: coverpoint tx_duty_cycle_cal_start_31_16.value[15:0];
  endgroup
  covergroup rd_fld_covg;
    tx_duty_cycle_cal_start_6_0: coverpoint tx_duty_cycle_cal_start_6_0.value[6:0];
    tx_duty_cycle_cal_start_14_7: coverpoint tx_duty_cycle_cal_start_14_7.value[7:0];
    tx_duty_cycle_cal_start_15: coverpoint tx_duty_cycle_cal_start_15.value[0:0];
    tx_duty_cycle_cal_start_31_16: coverpoint tx_duty_cycle_cal_start_31_16.value[15:0];
  endgroup

  protected virtual function void sample(uvm_reg_data_t data, uvm_reg_data_t byte_en, bit is_read, uvm_reg_map map);
    super.sample(data, byte_en, is_read, map);
    if (get_coverage(UVM_CVR_FIELD_VALS)) begin
      if(!is_read) begin
          wr_fld_covg.sample();
      end
      if(is_read) begin
         rd_fld_covg.sample();
      end
    end
  endfunction

  virtual function void sample_values();
    super.sample_values();
    if (get_coverage(UVM_CVR_FIELD_VALS)) begin
      wr_fld_covg.sample();
      rd_fld_covg.sample();
    end
  endfunction

  virtual function void build();
    uvm_reg_field fld_set[$];
    uvm_reg_field_config_ta ta = get_field_config(getconfigUID());
    build_uvm_reg_fields(this, ta, fld_set);
    
    tx_duty_cycle_cal_start_6_0 = fld_set[0];
    tx_duty_cycle_cal_start_14_7 = fld_set[1];
    tx_duty_cycle_cal_start_15 = fld_set[2];
    tx_duty_cycle_cal_start_31_16 = fld_set[3];
  endfunction

  function new(input string name="T_tx_duty_cycle_cal_start_650");
    super.new(name, 32, build_coverage(UVM_CVR_FIELD_VALS));
    if (has_coverage(UVM_CVR_FIELD_VALS)) begin
      wr_fld_covg = new();
      rd_fld_covg = new();
    end
  endfunction

endclass


/////////////////////////////////////////////////////
//                tx_duty_cycle_cal_tune
/////////////////////////////////////////////////////
class T_tx_duty_cycle_cal_tune_651 extends cdns_uvm_reg;

  `uvm_object_utils(T_tx_duty_cycle_cal_tune_651)
  rand uvm_reg_field tx_duty_cycle_cal_tune_5_0;
  rand uvm_reg_field tx_duty_cycle_cal_tune_15_6;
  rand uvm_reg_field tx_duty_cycle_cal_tune_31_16;
  
  covergroup wr_fld_covg;
    tx_duty_cycle_cal_tune_5_0: coverpoint tx_duty_cycle_cal_tune_5_0.value[5:0];
    tx_duty_cycle_cal_tune_15_6: coverpoint tx_duty_cycle_cal_tune_15_6.value[9:0];
    tx_duty_cycle_cal_tune_31_16: coverpoint tx_duty_cycle_cal_tune_31_16.value[15:0];
  endgroup
  covergroup rd_fld_covg;
    tx_duty_cycle_cal_tune_5_0: coverpoint tx_duty_cycle_cal_tune_5_0.value[5:0];
    tx_duty_cycle_cal_tune_15_6: coverpoint tx_duty_cycle_cal_tune_15_6.value[9:0];
    tx_duty_cycle_cal_tune_31_16: coverpoint tx_duty_cycle_cal_tune_31_16.value[15:0];
  endgroup

  protected virtual function void sample(uvm_reg_data_t data, uvm_reg_data_t byte_en, bit is_read, uvm_reg_map map);
    super.sample(data, byte_en, is_read, map);
    if (get_coverage(UVM_CVR_FIELD_VALS)) begin
      if(!is_read) begin
          wr_fld_covg.sample();
      end
      if(is_read) begin
         rd_fld_covg.sample();
      end
    end
  endfunction

  virtual function void sample_values();
    super.sample_values();
    if (get_coverage(UVM_CVR_FIELD_VALS)) begin
      wr_fld_covg.sample();
      rd_fld_covg.sample();
    end
  endfunction

  virtual function void build();
    uvm_reg_field fld_set[$];
    uvm_reg_field_config_ta ta = get_field_config(getconfigUID());
    build_uvm_reg_fields(this, ta, fld_set);
    
    tx_duty_cycle_cal_tune_5_0 = fld_set[0];
    tx_duty_cycle_cal_tune_15_6 = fld_set[1];
    tx_duty_cycle_cal_tune_31_16 = fld_set[2];
  endfunction

  function new(input string name="T_tx_duty_cycle_cal_tune_651");
    super.new(name, 32, build_coverage(UVM_CVR_FIELD_VALS));
    if (has_coverage(UVM_CVR_FIELD_VALS)) begin
      wr_fld_covg = new();
      rd_fld_covg = new();
    end
  endfunction

endclass


/////////////////////////////////////////////////////
//                tx_psc_a0
/////////////////////////////////////////////////////
class T_tx_psc_a0_632 extends cdns_uvm_reg;

  `uvm_object_utils(T_tx_psc_a0_632)
  rand uvm_reg_field tx_psc_a0_0;
  rand uvm_reg_field tx_psc_a0_1;
  rand uvm_reg_field tx_psc_a0_2;
  rand uvm_reg_field tx_psc_a0_3;
  rand uvm_reg_field tx_psc_a0_4;
  rand uvm_reg_field tx_psc_a0_5;
  rand uvm_reg_field tx_psc_a0_6;
  rand uvm_reg_field tx_psc_a0_7;
  rand uvm_reg_field tx_psc_a0_8;
  rand uvm_reg_field tx_psc_a0_9;
  rand uvm_reg_field tx_psc_a0_10;
  rand uvm_reg_field tx_psc_a0_11;
  rand uvm_reg_field tx_psc_a0_15_12;
  rand uvm_reg_field tx_psc_a0_31_16;
  
  covergroup wr_fld_covg;
    tx_psc_a0_0: coverpoint tx_psc_a0_0.value[0:0];
    tx_psc_a0_1: coverpoint tx_psc_a0_1.value[0:0];
    tx_psc_a0_2: coverpoint tx_psc_a0_2.value[0:0];
    tx_psc_a0_3: coverpoint tx_psc_a0_3.value[0:0];
    tx_psc_a0_4: coverpoint tx_psc_a0_4.value[0:0];
    tx_psc_a0_5: coverpoint tx_psc_a0_5.value[0:0];
    tx_psc_a0_6: coverpoint tx_psc_a0_6.value[0:0];
    tx_psc_a0_7: coverpoint tx_psc_a0_7.value[0:0];
    tx_psc_a0_8: coverpoint tx_psc_a0_8.value[0:0];
    tx_psc_a0_9: coverpoint tx_psc_a0_9.value[0:0];
    tx_psc_a0_10: coverpoint tx_psc_a0_10.value[0:0];
    tx_psc_a0_11: coverpoint tx_psc_a0_11.value[0:0];
    tx_psc_a0_15_12: coverpoint tx_psc_a0_15_12.value[3:0];
    tx_psc_a0_31_16: coverpoint tx_psc_a0_31_16.value[15:0];
  endgroup
  covergroup rd_fld_covg;
    tx_psc_a0_0: coverpoint tx_psc_a0_0.value[0:0];
    tx_psc_a0_1: coverpoint tx_psc_a0_1.value[0:0];
    tx_psc_a0_2: coverpoint tx_psc_a0_2.value[0:0];
    tx_psc_a0_3: coverpoint tx_psc_a0_3.value[0:0];
    tx_psc_a0_4: coverpoint tx_psc_a0_4.value[0:0];
    tx_psc_a0_5: coverpoint tx_psc_a0_5.value[0:0];
    tx_psc_a0_6: coverpoint tx_psc_a0_6.value[0:0];
    tx_psc_a0_7: coverpoint tx_psc_a0_7.value[0:0];
    tx_psc_a0_8: coverpoint tx_psc_a0_8.value[0:0];
    tx_psc_a0_9: coverpoint tx_psc_a0_9.value[0:0];
    tx_psc_a0_10: coverpoint tx_psc_a0_10.value[0:0];
    tx_psc_a0_11: coverpoint tx_psc_a0_11.value[0:0];
    tx_psc_a0_15_12: coverpoint tx_psc_a0_15_12.value[3:0];
    tx_psc_a0_31_16: coverpoint tx_psc_a0_31_16.value[15:0];
  endgroup

  protected virtual function void sample(uvm_reg_data_t data, uvm_reg_data_t byte_en, bit is_read, uvm_reg_map map);
    super.sample(data, byte_en, is_read, map);
    if (get_coverage(UVM_CVR_FIELD_VALS)) begin
      if(!is_read) begin
          wr_fld_covg.sample();
      end
      if(is_read) begin
         rd_fld_covg.sample();
      end
    end
  endfunction

  virtual function void sample_values();
    super.sample_values();
    if (get_coverage(UVM_CVR_FIELD_VALS)) begin
      wr_fld_covg.sample();
      rd_fld_covg.sample();
    end
  endfunction

  virtual function void build();
    uvm_reg_field fld_set[$];
    uvm_reg_field_config_ta ta = get_field_config(getconfigUID());
    build_uvm_reg_fields(this, ta, fld_set);
    
    tx_psc_a0_0 = fld_set[0];
    tx_psc_a0_1 = fld_set[1];
    tx_psc_a0_2 = fld_set[2];
    tx_psc_a0_3 = fld_set[3];
    tx_psc_a0_4 = fld_set[4];
    tx_psc_a0_5 = fld_set[5];
    tx_psc_a0_6 = fld_set[6];
    tx_psc_a0_7 = fld_set[7];
    tx_psc_a0_8 = fld_set[8];
    tx_psc_a0_9 = fld_set[9];
    tx_psc_a0_10 = fld_set[10];
    tx_psc_a0_11 = fld_set[11];
    tx_psc_a0_15_12 = fld_set[12];
    tx_psc_a0_31_16 = fld_set[13];
  endfunction

  function new(input string name="T_tx_psc_a0_632");
    super.new(name, 32, build_coverage(UVM_CVR_FIELD_VALS));
    if (has_coverage(UVM_CVR_FIELD_VALS)) begin
      wr_fld_covg = new();
      rd_fld_covg = new();
    end
  endfunction

endclass


/////////////////////////////////////////////////////
//                tx_psc_a1
/////////////////////////////////////////////////////
class T_tx_psc_a1_633 extends cdns_uvm_reg;

  `uvm_object_utils(T_tx_psc_a1_633)
  rand uvm_reg_field tx_psc_a1_0;
  rand uvm_reg_field tx_psc_a1_1;
  rand uvm_reg_field tx_psc_a1_2;
  rand uvm_reg_field tx_psc_a1_3;
  rand uvm_reg_field tx_psc_a1_4;
  rand uvm_reg_field tx_psc_a1_5;
  rand uvm_reg_field tx_psc_a1_6;
  rand uvm_reg_field tx_psc_a1_7;
  rand uvm_reg_field tx_psc_a1_8;
  rand uvm_reg_field tx_psc_a1_9;
  rand uvm_reg_field tx_psc_a1_10;
  rand uvm_reg_field tx_psc_a1_11;
  rand uvm_reg_field tx_psc_a1_15_12;
  rand uvm_reg_field tx_psc_a1_31_16;
  
  covergroup wr_fld_covg;
    tx_psc_a1_0: coverpoint tx_psc_a1_0.value[0:0];
    tx_psc_a1_1: coverpoint tx_psc_a1_1.value[0:0];
    tx_psc_a1_2: coverpoint tx_psc_a1_2.value[0:0];
    tx_psc_a1_3: coverpoint tx_psc_a1_3.value[0:0];
    tx_psc_a1_4: coverpoint tx_psc_a1_4.value[0:0];
    tx_psc_a1_5: coverpoint tx_psc_a1_5.value[0:0];
    tx_psc_a1_6: coverpoint tx_psc_a1_6.value[0:0];
    tx_psc_a1_7: coverpoint tx_psc_a1_7.value[0:0];
    tx_psc_a1_8: coverpoint tx_psc_a1_8.value[0:0];
    tx_psc_a1_9: coverpoint tx_psc_a1_9.value[0:0];
    tx_psc_a1_10: coverpoint tx_psc_a1_10.value[0:0];
    tx_psc_a1_11: coverpoint tx_psc_a1_11.value[0:0];
    tx_psc_a1_15_12: coverpoint tx_psc_a1_15_12.value[3:0];
    tx_psc_a1_31_16: coverpoint tx_psc_a1_31_16.value[15:0];
  endgroup
  covergroup rd_fld_covg;
    tx_psc_a1_0: coverpoint tx_psc_a1_0.value[0:0];
    tx_psc_a1_1: coverpoint tx_psc_a1_1.value[0:0];
    tx_psc_a1_2: coverpoint tx_psc_a1_2.value[0:0];
    tx_psc_a1_3: coverpoint tx_psc_a1_3.value[0:0];
    tx_psc_a1_4: coverpoint tx_psc_a1_4.value[0:0];
    tx_psc_a1_5: coverpoint tx_psc_a1_5.value[0:0];
    tx_psc_a1_6: coverpoint tx_psc_a1_6.value[0:0];
    tx_psc_a1_7: coverpoint tx_psc_a1_7.value[0:0];
    tx_psc_a1_8: coverpoint tx_psc_a1_8.value[0:0];
    tx_psc_a1_9: coverpoint tx_psc_a1_9.value[0:0];
    tx_psc_a1_10: coverpoint tx_psc_a1_10.value[0:0];
    tx_psc_a1_11: coverpoint tx_psc_a1_11.value[0:0];
    tx_psc_a1_15_12: coverpoint tx_psc_a1_15_12.value[3:0];
    tx_psc_a1_31_16: coverpoint tx_psc_a1_31_16.value[15:0];
  endgroup

  protected virtual function void sample(uvm_reg_data_t data, uvm_reg_data_t byte_en, bit is_read, uvm_reg_map map);
    super.sample(data, byte_en, is_read, map);
    if (get_coverage(UVM_CVR_FIELD_VALS)) begin
      if(!is_read) begin
          wr_fld_covg.sample();
      end
      if(is_read) begin
         rd_fld_covg.sample();
      end
    end
  endfunction

  virtual function void sample_values();
    super.sample_values();
    if (get_coverage(UVM_CVR_FIELD_VALS)) begin
      wr_fld_covg.sample();
      rd_fld_covg.sample();
    end
  endfunction

  virtual function void build();
    uvm_reg_field fld_set[$];
    uvm_reg_field_config_ta ta = get_field_config(getconfigUID());
    build_uvm_reg_fields(this, ta, fld_set);
    
    tx_psc_a1_0 = fld_set[0];
    tx_psc_a1_1 = fld_set[1];
    tx_psc_a1_2 = fld_set[2];
    tx_psc_a1_3 = fld_set[3];
    tx_psc_a1_4 = fld_set[4];
    tx_psc_a1_5 = fld_set[5];
    tx_psc_a1_6 = fld_set[6];
    tx_psc_a1_7 = fld_set[7];
    tx_psc_a1_8 = fld_set[8];
    tx_psc_a1_9 = fld_set[9];
    tx_psc_a1_10 = fld_set[10];
    tx_psc_a1_11 = fld_set[11];
    tx_psc_a1_15_12 = fld_set[12];
    tx_psc_a1_31_16 = fld_set[13];
  endfunction

  function new(input string name="T_tx_psc_a1_633");
    super.new(name, 32, build_coverage(UVM_CVR_FIELD_VALS));
    if (has_coverage(UVM_CVR_FIELD_VALS)) begin
      wr_fld_covg = new();
      rd_fld_covg = new();
    end
  endfunction

endclass


/////////////////////////////////////////////////////
//                tx_psc_a2
/////////////////////////////////////////////////////
class T_tx_psc_a2_634 extends cdns_uvm_reg;

  `uvm_object_utils(T_tx_psc_a2_634)
  rand uvm_reg_field tx_psc_a2_0;
  rand uvm_reg_field tx_psc_a2_1;
  rand uvm_reg_field tx_psc_a2_2;
  rand uvm_reg_field tx_psc_a2_3;
  rand uvm_reg_field tx_psc_a2_4;
  rand uvm_reg_field tx_psc_a2_5;
  rand uvm_reg_field tx_psc_a2_6;
  rand uvm_reg_field tx_psc_a2_7;
  rand uvm_reg_field tx_psc_a2_8;
  rand uvm_reg_field tx_psc_a2_9;
  rand uvm_reg_field tx_psc_a2_10;
  rand uvm_reg_field tx_psc_a2_11;
  rand uvm_reg_field tx_psc_a2_15_12;
  rand uvm_reg_field tx_psc_a2_31_16;
  
  covergroup wr_fld_covg;
    tx_psc_a2_0: coverpoint tx_psc_a2_0.value[0:0];
    tx_psc_a2_1: coverpoint tx_psc_a2_1.value[0:0];
    tx_psc_a2_2: coverpoint tx_psc_a2_2.value[0:0];
    tx_psc_a2_3: coverpoint tx_psc_a2_3.value[0:0];
    tx_psc_a2_4: coverpoint tx_psc_a2_4.value[0:0];
    tx_psc_a2_5: coverpoint tx_psc_a2_5.value[0:0];
    tx_psc_a2_6: coverpoint tx_psc_a2_6.value[0:0];
    tx_psc_a2_7: coverpoint tx_psc_a2_7.value[0:0];
    tx_psc_a2_8: coverpoint tx_psc_a2_8.value[0:0];
    tx_psc_a2_9: coverpoint tx_psc_a2_9.value[0:0];
    tx_psc_a2_10: coverpoint tx_psc_a2_10.value[0:0];
    tx_psc_a2_11: coverpoint tx_psc_a2_11.value[0:0];
    tx_psc_a2_15_12: coverpoint tx_psc_a2_15_12.value[3:0];
    tx_psc_a2_31_16: coverpoint tx_psc_a2_31_16.value[15:0];
  endgroup
  covergroup rd_fld_covg;
    tx_psc_a2_0: coverpoint tx_psc_a2_0.value[0:0];
    tx_psc_a2_1: coverpoint tx_psc_a2_1.value[0:0];
    tx_psc_a2_2: coverpoint tx_psc_a2_2.value[0:0];
    tx_psc_a2_3: coverpoint tx_psc_a2_3.value[0:0];
    tx_psc_a2_4: coverpoint tx_psc_a2_4.value[0:0];
    tx_psc_a2_5: coverpoint tx_psc_a2_5.value[0:0];
    tx_psc_a2_6: coverpoint tx_psc_a2_6.value[0:0];
    tx_psc_a2_7: coverpoint tx_psc_a2_7.value[0:0];
    tx_psc_a2_8: coverpoint tx_psc_a2_8.value[0:0];
    tx_psc_a2_9: coverpoint tx_psc_a2_9.value[0:0];
    tx_psc_a2_10: coverpoint tx_psc_a2_10.value[0:0];
    tx_psc_a2_11: coverpoint tx_psc_a2_11.value[0:0];
    tx_psc_a2_15_12: coverpoint tx_psc_a2_15_12.value[3:0];
    tx_psc_a2_31_16: coverpoint tx_psc_a2_31_16.value[15:0];
  endgroup

  protected virtual function void sample(uvm_reg_data_t data, uvm_reg_data_t byte_en, bit is_read, uvm_reg_map map);
    super.sample(data, byte_en, is_read, map);
    if (get_coverage(UVM_CVR_FIELD_VALS)) begin
      if(!is_read) begin
          wr_fld_covg.sample();
      end
      if(is_read) begin
         rd_fld_covg.sample();
      end
    end
  endfunction

  virtual function void sample_values();
    super.sample_values();
    if (get_coverage(UVM_CVR_FIELD_VALS)) begin
      wr_fld_covg.sample();
      rd_fld_covg.sample();
    end
  endfunction

  virtual function void build();
    uvm_reg_field fld_set[$];
    uvm_reg_field_config_ta ta = get_field_config(getconfigUID());
    build_uvm_reg_fields(this, ta, fld_set);
    
    tx_psc_a2_0 = fld_set[0];
    tx_psc_a2_1 = fld_set[1];
    tx_psc_a2_2 = fld_set[2];
    tx_psc_a2_3 = fld_set[3];
    tx_psc_a2_4 = fld_set[4];
    tx_psc_a2_5 = fld_set[5];
    tx_psc_a2_6 = fld_set[6];
    tx_psc_a2_7 = fld_set[7];
    tx_psc_a2_8 = fld_set[8];
    tx_psc_a2_9 = fld_set[9];
    tx_psc_a2_10 = fld_set[10];
    tx_psc_a2_11 = fld_set[11];
    tx_psc_a2_15_12 = fld_set[12];
    tx_psc_a2_31_16 = fld_set[13];
  endfunction

  function new(input string name="T_tx_psc_a2_634");
    super.new(name, 32, build_coverage(UVM_CVR_FIELD_VALS));
    if (has_coverage(UVM_CVR_FIELD_VALS)) begin
      wr_fld_covg = new();
      rd_fld_covg = new();
    end
  endfunction

endclass


/////////////////////////////////////////////////////
//                tx_psc_a3
/////////////////////////////////////////////////////
class T_tx_psc_a3_635 extends cdns_uvm_reg;

  `uvm_object_utils(T_tx_psc_a3_635)
  rand uvm_reg_field tx_psc_a3_0;
  rand uvm_reg_field tx_psc_a3_1;
  rand uvm_reg_field tx_psc_a3_2;
  rand uvm_reg_field tx_psc_a3_3;
  rand uvm_reg_field tx_psc_a3_4;
  rand uvm_reg_field tx_psc_a3_5;
  rand uvm_reg_field tx_psc_a3_6;
  rand uvm_reg_field tx_psc_a3_7;
  rand uvm_reg_field tx_psc_a3_8;
  rand uvm_reg_field tx_psc_a3_9;
  rand uvm_reg_field tx_psc_a3_10;
  rand uvm_reg_field tx_psc_a3_11;
  rand uvm_reg_field tx_psc_a3_15_12;
  rand uvm_reg_field tx_psc_a3_31_16;
  
  covergroup wr_fld_covg;
    tx_psc_a3_0: coverpoint tx_psc_a3_0.value[0:0];
    tx_psc_a3_1: coverpoint tx_psc_a3_1.value[0:0];
    tx_psc_a3_2: coverpoint tx_psc_a3_2.value[0:0];
    tx_psc_a3_3: coverpoint tx_psc_a3_3.value[0:0];
    tx_psc_a3_4: coverpoint tx_psc_a3_4.value[0:0];
    tx_psc_a3_5: coverpoint tx_psc_a3_5.value[0:0];
    tx_psc_a3_6: coverpoint tx_psc_a3_6.value[0:0];
    tx_psc_a3_7: coverpoint tx_psc_a3_7.value[0:0];
    tx_psc_a3_8: coverpoint tx_psc_a3_8.value[0:0];
    tx_psc_a3_9: coverpoint tx_psc_a3_9.value[0:0];
    tx_psc_a3_10: coverpoint tx_psc_a3_10.value[0:0];
    tx_psc_a3_11: coverpoint tx_psc_a3_11.value[0:0];
    tx_psc_a3_15_12: coverpoint tx_psc_a3_15_12.value[3:0];
    tx_psc_a3_31_16: coverpoint tx_psc_a3_31_16.value[15:0];
  endgroup
  covergroup rd_fld_covg;
    tx_psc_a3_0: coverpoint tx_psc_a3_0.value[0:0];
    tx_psc_a3_1: coverpoint tx_psc_a3_1.value[0:0];
    tx_psc_a3_2: coverpoint tx_psc_a3_2.value[0:0];
    tx_psc_a3_3: coverpoint tx_psc_a3_3.value[0:0];
    tx_psc_a3_4: coverpoint tx_psc_a3_4.value[0:0];
    tx_psc_a3_5: coverpoint tx_psc_a3_5.value[0:0];
    tx_psc_a3_6: coverpoint tx_psc_a3_6.value[0:0];
    tx_psc_a3_7: coverpoint tx_psc_a3_7.value[0:0];
    tx_psc_a3_8: coverpoint tx_psc_a3_8.value[0:0];
    tx_psc_a3_9: coverpoint tx_psc_a3_9.value[0:0];
    tx_psc_a3_10: coverpoint tx_psc_a3_10.value[0:0];
    tx_psc_a3_11: coverpoint tx_psc_a3_11.value[0:0];
    tx_psc_a3_15_12: coverpoint tx_psc_a3_15_12.value[3:0];
    tx_psc_a3_31_16: coverpoint tx_psc_a3_31_16.value[15:0];
  endgroup

  protected virtual function void sample(uvm_reg_data_t data, uvm_reg_data_t byte_en, bit is_read, uvm_reg_map map);
    super.sample(data, byte_en, is_read, map);
    if (get_coverage(UVM_CVR_FIELD_VALS)) begin
      if(!is_read) begin
          wr_fld_covg.sample();
      end
      if(is_read) begin
         rd_fld_covg.sample();
      end
    end
  endfunction

  virtual function void sample_values();
    super.sample_values();
    if (get_coverage(UVM_CVR_FIELD_VALS)) begin
      wr_fld_covg.sample();
      rd_fld_covg.sample();
    end
  endfunction

  virtual function void build();
    uvm_reg_field fld_set[$];
    uvm_reg_field_config_ta ta = get_field_config(getconfigUID());
    build_uvm_reg_fields(this, ta, fld_set);
    
    tx_psc_a3_0 = fld_set[0];
    tx_psc_a3_1 = fld_set[1];
    tx_psc_a3_2 = fld_set[2];
    tx_psc_a3_3 = fld_set[3];
    tx_psc_a3_4 = fld_set[4];
    tx_psc_a3_5 = fld_set[5];
    tx_psc_a3_6 = fld_set[6];
    tx_psc_a3_7 = fld_set[7];
    tx_psc_a3_8 = fld_set[8];
    tx_psc_a3_9 = fld_set[9];
    tx_psc_a3_10 = fld_set[10];
    tx_psc_a3_11 = fld_set[11];
    tx_psc_a3_15_12 = fld_set[12];
    tx_psc_a3_31_16 = fld_set[13];
  endfunction

  function new(input string name="T_tx_psc_a3_635");
    super.new(name, 32, build_coverage(UVM_CVR_FIELD_VALS));
    if (has_coverage(UVM_CVR_FIELD_VALS)) begin
      wr_fld_covg = new();
      rd_fld_covg = new();
    end
  endfunction

endclass


/////////////////////////////////////////////////////
//                tx_psc_a4
/////////////////////////////////////////////////////
class T_tx_psc_a4_636 extends cdns_uvm_reg;

  `uvm_object_utils(T_tx_psc_a4_636)
  rand uvm_reg_field tx_psc_a4_0;
  rand uvm_reg_field tx_psc_a4_1;
  rand uvm_reg_field tx_psc_a4_2;
  rand uvm_reg_field tx_psc_a4_3;
  rand uvm_reg_field tx_psc_a4_4;
  rand uvm_reg_field tx_psc_a4_5;
  rand uvm_reg_field tx_psc_a4_6;
  rand uvm_reg_field tx_psc_a4_7;
  rand uvm_reg_field tx_psc_a4_8;
  rand uvm_reg_field tx_psc_a4_9;
  rand uvm_reg_field tx_psc_a4_10;
  rand uvm_reg_field tx_psc_a4_11;
  rand uvm_reg_field tx_psc_a4_15_12;
  rand uvm_reg_field tx_psc_a4_31_16;
  
  covergroup wr_fld_covg;
    tx_psc_a4_0: coverpoint tx_psc_a4_0.value[0:0];
    tx_psc_a4_1: coverpoint tx_psc_a4_1.value[0:0];
    tx_psc_a4_2: coverpoint tx_psc_a4_2.value[0:0];
    tx_psc_a4_3: coverpoint tx_psc_a4_3.value[0:0];
    tx_psc_a4_4: coverpoint tx_psc_a4_4.value[0:0];
    tx_psc_a4_5: coverpoint tx_psc_a4_5.value[0:0];
    tx_psc_a4_6: coverpoint tx_psc_a4_6.value[0:0];
    tx_psc_a4_7: coverpoint tx_psc_a4_7.value[0:0];
    tx_psc_a4_8: coverpoint tx_psc_a4_8.value[0:0];
    tx_psc_a4_9: coverpoint tx_psc_a4_9.value[0:0];
    tx_psc_a4_10: coverpoint tx_psc_a4_10.value[0:0];
    tx_psc_a4_11: coverpoint tx_psc_a4_11.value[0:0];
    tx_psc_a4_15_12: coverpoint tx_psc_a4_15_12.value[3:0];
    tx_psc_a4_31_16: coverpoint tx_psc_a4_31_16.value[15:0];
  endgroup
  covergroup rd_fld_covg;
    tx_psc_a4_0: coverpoint tx_psc_a4_0.value[0:0];
    tx_psc_a4_1: coverpoint tx_psc_a4_1.value[0:0];
    tx_psc_a4_2: coverpoint tx_psc_a4_2.value[0:0];
    tx_psc_a4_3: coverpoint tx_psc_a4_3.value[0:0];
    tx_psc_a4_4: coverpoint tx_psc_a4_4.value[0:0];
    tx_psc_a4_5: coverpoint tx_psc_a4_5.value[0:0];
    tx_psc_a4_6: coverpoint tx_psc_a4_6.value[0:0];
    tx_psc_a4_7: coverpoint tx_psc_a4_7.value[0:0];
    tx_psc_a4_8: coverpoint tx_psc_a4_8.value[0:0];
    tx_psc_a4_9: coverpoint tx_psc_a4_9.value[0:0];
    tx_psc_a4_10: coverpoint tx_psc_a4_10.value[0:0];
    tx_psc_a4_11: coverpoint tx_psc_a4_11.value[0:0];
    tx_psc_a4_15_12: coverpoint tx_psc_a4_15_12.value[3:0];
    tx_psc_a4_31_16: coverpoint tx_psc_a4_31_16.value[15:0];
  endgroup

  protected virtual function void sample(uvm_reg_data_t data, uvm_reg_data_t byte_en, bit is_read, uvm_reg_map map);
    super.sample(data, byte_en, is_read, map);
    if (get_coverage(UVM_CVR_FIELD_VALS)) begin
      if(!is_read) begin
          wr_fld_covg.sample();
      end
      if(is_read) begin
         rd_fld_covg.sample();
      end
    end
  endfunction

  virtual function void sample_values();
    super.sample_values();
    if (get_coverage(UVM_CVR_FIELD_VALS)) begin
      wr_fld_covg.sample();
      rd_fld_covg.sample();
    end
  endfunction

  virtual function void build();
    uvm_reg_field fld_set[$];
    uvm_reg_field_config_ta ta = get_field_config(getconfigUID());
    build_uvm_reg_fields(this, ta, fld_set);
    
    tx_psc_a4_0 = fld_set[0];
    tx_psc_a4_1 = fld_set[1];
    tx_psc_a4_2 = fld_set[2];
    tx_psc_a4_3 = fld_set[3];
    tx_psc_a4_4 = fld_set[4];
    tx_psc_a4_5 = fld_set[5];
    tx_psc_a4_6 = fld_set[6];
    tx_psc_a4_7 = fld_set[7];
    tx_psc_a4_8 = fld_set[8];
    tx_psc_a4_9 = fld_set[9];
    tx_psc_a4_10 = fld_set[10];
    tx_psc_a4_11 = fld_set[11];
    tx_psc_a4_15_12 = fld_set[12];
    tx_psc_a4_31_16 = fld_set[13];
  endfunction

  function new(input string name="T_tx_psc_a4_636");
    super.new(name, 32, build_coverage(UVM_CVR_FIELD_VALS));
    if (has_coverage(UVM_CVR_FIELD_VALS)) begin
      wr_fld_covg = new();
      rd_fld_covg = new();
    end
  endfunction

endclass


/////////////////////////////////////////////////////
//                tx_psc_a5
/////////////////////////////////////////////////////
class T_tx_psc_a5_637 extends cdns_uvm_reg;

  `uvm_object_utils(T_tx_psc_a5_637)
  rand uvm_reg_field tx_psc_a5_0;
  rand uvm_reg_field tx_psc_a5_1;
  rand uvm_reg_field tx_psc_a5_2;
  rand uvm_reg_field tx_psc_a5_3;
  rand uvm_reg_field tx_psc_a5_4;
  rand uvm_reg_field tx_psc_a5_5;
  rand uvm_reg_field tx_psc_a5_6;
  rand uvm_reg_field tx_psc_a5_7;
  rand uvm_reg_field tx_psc_a5_8;
  rand uvm_reg_field tx_psc_a5_9;
  rand uvm_reg_field tx_psc_a5_10;
  rand uvm_reg_field tx_psc_a5_11;
  rand uvm_reg_field tx_psc_a5_15_12;
  rand uvm_reg_field tx_psc_a5_31_16;
  
  covergroup wr_fld_covg;
    tx_psc_a5_0: coverpoint tx_psc_a5_0.value[0:0];
    tx_psc_a5_1: coverpoint tx_psc_a5_1.value[0:0];
    tx_psc_a5_2: coverpoint tx_psc_a5_2.value[0:0];
    tx_psc_a5_3: coverpoint tx_psc_a5_3.value[0:0];
    tx_psc_a5_4: coverpoint tx_psc_a5_4.value[0:0];
    tx_psc_a5_5: coverpoint tx_psc_a5_5.value[0:0];
    tx_psc_a5_6: coverpoint tx_psc_a5_6.value[0:0];
    tx_psc_a5_7: coverpoint tx_psc_a5_7.value[0:0];
    tx_psc_a5_8: coverpoint tx_psc_a5_8.value[0:0];
    tx_psc_a5_9: coverpoint tx_psc_a5_9.value[0:0];
    tx_psc_a5_10: coverpoint tx_psc_a5_10.value[0:0];
    tx_psc_a5_11: coverpoint tx_psc_a5_11.value[0:0];
    tx_psc_a5_15_12: coverpoint tx_psc_a5_15_12.value[3:0];
    tx_psc_a5_31_16: coverpoint tx_psc_a5_31_16.value[15:0];
  endgroup
  covergroup rd_fld_covg;
    tx_psc_a5_0: coverpoint tx_psc_a5_0.value[0:0];
    tx_psc_a5_1: coverpoint tx_psc_a5_1.value[0:0];
    tx_psc_a5_2: coverpoint tx_psc_a5_2.value[0:0];
    tx_psc_a5_3: coverpoint tx_psc_a5_3.value[0:0];
    tx_psc_a5_4: coverpoint tx_psc_a5_4.value[0:0];
    tx_psc_a5_5: coverpoint tx_psc_a5_5.value[0:0];
    tx_psc_a5_6: coverpoint tx_psc_a5_6.value[0:0];
    tx_psc_a5_7: coverpoint tx_psc_a5_7.value[0:0];
    tx_psc_a5_8: coverpoint tx_psc_a5_8.value[0:0];
    tx_psc_a5_9: coverpoint tx_psc_a5_9.value[0:0];
    tx_psc_a5_10: coverpoint tx_psc_a5_10.value[0:0];
    tx_psc_a5_11: coverpoint tx_psc_a5_11.value[0:0];
    tx_psc_a5_15_12: coverpoint tx_psc_a5_15_12.value[3:0];
    tx_psc_a5_31_16: coverpoint tx_psc_a5_31_16.value[15:0];
  endgroup

  protected virtual function void sample(uvm_reg_data_t data, uvm_reg_data_t byte_en, bit is_read, uvm_reg_map map);
    super.sample(data, byte_en, is_read, map);
    if (get_coverage(UVM_CVR_FIELD_VALS)) begin
      if(!is_read) begin
          wr_fld_covg.sample();
      end
      if(is_read) begin
         rd_fld_covg.sample();
      end
    end
  endfunction

  virtual function void sample_values();
    super.sample_values();
    if (get_coverage(UVM_CVR_FIELD_VALS)) begin
      wr_fld_covg.sample();
      rd_fld_covg.sample();
    end
  endfunction

  virtual function void build();
    uvm_reg_field fld_set[$];
    uvm_reg_field_config_ta ta = get_field_config(getconfigUID());
    build_uvm_reg_fields(this, ta, fld_set);
    
    tx_psc_a5_0 = fld_set[0];
    tx_psc_a5_1 = fld_set[1];
    tx_psc_a5_2 = fld_set[2];
    tx_psc_a5_3 = fld_set[3];
    tx_psc_a5_4 = fld_set[4];
    tx_psc_a5_5 = fld_set[5];
    tx_psc_a5_6 = fld_set[6];
    tx_psc_a5_7 = fld_set[7];
    tx_psc_a5_8 = fld_set[8];
    tx_psc_a5_9 = fld_set[9];
    tx_psc_a5_10 = fld_set[10];
    tx_psc_a5_11 = fld_set[11];
    tx_psc_a5_15_12 = fld_set[12];
    tx_psc_a5_31_16 = fld_set[13];
  endfunction

  function new(input string name="T_tx_psc_a5_637");
    super.new(name, 32, build_coverage(UVM_CVR_FIELD_VALS));
    if (has_coverage(UVM_CVR_FIELD_VALS)) begin
      wr_fld_covg = new();
      rd_fld_covg = new();
    end
  endfunction

endclass


/////////////////////////////////////////////////////
//                tx_psc_cal
/////////////////////////////////////////////////////
class T_tx_psc_cal_638 extends cdns_uvm_reg;

  `uvm_object_utils(T_tx_psc_cal_638)
  rand uvm_reg_field tx_psc_cal_0;
  rand uvm_reg_field tx_psc_cal_1;
  rand uvm_reg_field tx_psc_cal_2;
  rand uvm_reg_field tx_psc_cal_3;
  rand uvm_reg_field tx_psc_cal_4;
  rand uvm_reg_field tx_psc_cal_5;
  rand uvm_reg_field tx_psc_cal_6;
  rand uvm_reg_field tx_psc_cal_7;
  rand uvm_reg_field tx_psc_cal_8;
  rand uvm_reg_field tx_psc_cal_9;
  rand uvm_reg_field tx_psc_cal_10;
  rand uvm_reg_field tx_psc_cal_11;
  rand uvm_reg_field tx_psc_cal_15_12;
  rand uvm_reg_field tx_psc_cal_31_16;
  
  covergroup wr_fld_covg;
    tx_psc_cal_0: coverpoint tx_psc_cal_0.value[0:0];
    tx_psc_cal_1: coverpoint tx_psc_cal_1.value[0:0];
    tx_psc_cal_2: coverpoint tx_psc_cal_2.value[0:0];
    tx_psc_cal_3: coverpoint tx_psc_cal_3.value[0:0];
    tx_psc_cal_4: coverpoint tx_psc_cal_4.value[0:0];
    tx_psc_cal_5: coverpoint tx_psc_cal_5.value[0:0];
    tx_psc_cal_6: coverpoint tx_psc_cal_6.value[0:0];
    tx_psc_cal_7: coverpoint tx_psc_cal_7.value[0:0];
    tx_psc_cal_8: coverpoint tx_psc_cal_8.value[0:0];
    tx_psc_cal_9: coverpoint tx_psc_cal_9.value[0:0];
    tx_psc_cal_10: coverpoint tx_psc_cal_10.value[0:0];
    tx_psc_cal_11: coverpoint tx_psc_cal_11.value[0:0];
    tx_psc_cal_15_12: coverpoint tx_psc_cal_15_12.value[3:0];
    tx_psc_cal_31_16: coverpoint tx_psc_cal_31_16.value[15:0];
  endgroup
  covergroup rd_fld_covg;
    tx_psc_cal_0: coverpoint tx_psc_cal_0.value[0:0];
    tx_psc_cal_1: coverpoint tx_psc_cal_1.value[0:0];
    tx_psc_cal_2: coverpoint tx_psc_cal_2.value[0:0];
    tx_psc_cal_3: coverpoint tx_psc_cal_3.value[0:0];
    tx_psc_cal_4: coverpoint tx_psc_cal_4.value[0:0];
    tx_psc_cal_5: coverpoint tx_psc_cal_5.value[0:0];
    tx_psc_cal_6: coverpoint tx_psc_cal_6.value[0:0];
    tx_psc_cal_7: coverpoint tx_psc_cal_7.value[0:0];
    tx_psc_cal_8: coverpoint tx_psc_cal_8.value[0:0];
    tx_psc_cal_9: coverpoint tx_psc_cal_9.value[0:0];
    tx_psc_cal_10: coverpoint tx_psc_cal_10.value[0:0];
    tx_psc_cal_11: coverpoint tx_psc_cal_11.value[0:0];
    tx_psc_cal_15_12: coverpoint tx_psc_cal_15_12.value[3:0];
    tx_psc_cal_31_16: coverpoint tx_psc_cal_31_16.value[15:0];
  endgroup

  protected virtual function void sample(uvm_reg_data_t data, uvm_reg_data_t byte_en, bit is_read, uvm_reg_map map);
    super.sample(data, byte_en, is_read, map);
    if (get_coverage(UVM_CVR_FIELD_VALS)) begin
      if(!is_read) begin
          wr_fld_covg.sample();
      end
      if(is_read) begin
         rd_fld_covg.sample();
      end
    end
  endfunction

  virtual function void sample_values();
    super.sample_values();
    if (get_coverage(UVM_CVR_FIELD_VALS)) begin
      wr_fld_covg.sample();
      rd_fld_covg.sample();
    end
  endfunction

  virtual function void build();
    uvm_reg_field fld_set[$];
    uvm_reg_field_config_ta ta = get_field_config(getconfigUID());
    build_uvm_reg_fields(this, ta, fld_set);
    
    tx_psc_cal_0 = fld_set[0];
    tx_psc_cal_1 = fld_set[1];
    tx_psc_cal_2 = fld_set[2];
    tx_psc_cal_3 = fld_set[3];
    tx_psc_cal_4 = fld_set[4];
    tx_psc_cal_5 = fld_set[5];
    tx_psc_cal_6 = fld_set[6];
    tx_psc_cal_7 = fld_set[7];
    tx_psc_cal_8 = fld_set[8];
    tx_psc_cal_9 = fld_set[9];
    tx_psc_cal_10 = fld_set[10];
    tx_psc_cal_11 = fld_set[11];
    tx_psc_cal_15_12 = fld_set[12];
    tx_psc_cal_31_16 = fld_set[13];
  endfunction

  function new(input string name="T_tx_psc_cal_638");
    super.new(name, 32, build_coverage(UVM_CVR_FIELD_VALS));
    if (has_coverage(UVM_CVR_FIELD_VALS)) begin
      wr_fld_covg = new();
      rd_fld_covg = new();
    end
  endfunction

endclass


/////////////////////////////////////////////////////
//                tx_psc_rdy
/////////////////////////////////////////////////////
class T_tx_psc_rdy_639 extends cdns_uvm_reg;

  `uvm_object_utils(T_tx_psc_rdy_639)
  rand uvm_reg_field tx_psc_rdy_0;
  rand uvm_reg_field tx_psc_rdy_1;
  rand uvm_reg_field tx_psc_rdy_2;
  rand uvm_reg_field tx_psc_rdy_3;
  rand uvm_reg_field tx_psc_rdy_4;
  rand uvm_reg_field tx_psc_rdy_5;
  rand uvm_reg_field tx_psc_rdy_6;
  rand uvm_reg_field tx_psc_rdy_7;
  rand uvm_reg_field tx_psc_rdy_8;
  rand uvm_reg_field tx_psc_rdy_9;
  rand uvm_reg_field tx_psc_rdy_10;
  rand uvm_reg_field tx_psc_rdy_11;
  rand uvm_reg_field tx_psc_rdy_15_12;
  rand uvm_reg_field tx_psc_rdy_31_16;
  
  covergroup wr_fld_covg;
    tx_psc_rdy_0: coverpoint tx_psc_rdy_0.value[0:0];
    tx_psc_rdy_1: coverpoint tx_psc_rdy_1.value[0:0];
    tx_psc_rdy_2: coverpoint tx_psc_rdy_2.value[0:0];
    tx_psc_rdy_3: coverpoint tx_psc_rdy_3.value[0:0];
    tx_psc_rdy_4: coverpoint tx_psc_rdy_4.value[0:0];
    tx_psc_rdy_5: coverpoint tx_psc_rdy_5.value[0:0];
    tx_psc_rdy_6: coverpoint tx_psc_rdy_6.value[0:0];
    tx_psc_rdy_7: coverpoint tx_psc_rdy_7.value[0:0];
    tx_psc_rdy_8: coverpoint tx_psc_rdy_8.value[0:0];
    tx_psc_rdy_9: coverpoint tx_psc_rdy_9.value[0:0];
    tx_psc_rdy_10: coverpoint tx_psc_rdy_10.value[0:0];
    tx_psc_rdy_11: coverpoint tx_psc_rdy_11.value[0:0];
    tx_psc_rdy_15_12: coverpoint tx_psc_rdy_15_12.value[3:0];
    tx_psc_rdy_31_16: coverpoint tx_psc_rdy_31_16.value[15:0];
  endgroup
  covergroup rd_fld_covg;
    tx_psc_rdy_0: coverpoint tx_psc_rdy_0.value[0:0];
    tx_psc_rdy_1: coverpoint tx_psc_rdy_1.value[0:0];
    tx_psc_rdy_2: coverpoint tx_psc_rdy_2.value[0:0];
    tx_psc_rdy_3: coverpoint tx_psc_rdy_3.value[0:0];
    tx_psc_rdy_4: coverpoint tx_psc_rdy_4.value[0:0];
    tx_psc_rdy_5: coverpoint tx_psc_rdy_5.value[0:0];
    tx_psc_rdy_6: coverpoint tx_psc_rdy_6.value[0:0];
    tx_psc_rdy_7: coverpoint tx_psc_rdy_7.value[0:0];
    tx_psc_rdy_8: coverpoint tx_psc_rdy_8.value[0:0];
    tx_psc_rdy_9: coverpoint tx_psc_rdy_9.value[0:0];
    tx_psc_rdy_10: coverpoint tx_psc_rdy_10.value[0:0];
    tx_psc_rdy_11: coverpoint tx_psc_rdy_11.value[0:0];
    tx_psc_rdy_15_12: coverpoint tx_psc_rdy_15_12.value[3:0];
    tx_psc_rdy_31_16: coverpoint tx_psc_rdy_31_16.value[15:0];
  endgroup

  protected virtual function void sample(uvm_reg_data_t data, uvm_reg_data_t byte_en, bit is_read, uvm_reg_map map);
    super.sample(data, byte_en, is_read, map);
    if (get_coverage(UVM_CVR_FIELD_VALS)) begin
      if(!is_read) begin
          wr_fld_covg.sample();
      end
      if(is_read) begin
         rd_fld_covg.sample();
      end
    end
  endfunction

  virtual function void sample_values();
    super.sample_values();
    if (get_coverage(UVM_CVR_FIELD_VALS)) begin
      wr_fld_covg.sample();
      rd_fld_covg.sample();
    end
  endfunction

  virtual function void build();
    uvm_reg_field fld_set[$];
    uvm_reg_field_config_ta ta = get_field_config(getconfigUID());
    build_uvm_reg_fields(this, ta, fld_set);
    
    tx_psc_rdy_0 = fld_set[0];
    tx_psc_rdy_1 = fld_set[1];
    tx_psc_rdy_2 = fld_set[2];
    tx_psc_rdy_3 = fld_set[3];
    tx_psc_rdy_4 = fld_set[4];
    tx_psc_rdy_5 = fld_set[5];
    tx_psc_rdy_6 = fld_set[6];
    tx_psc_rdy_7 = fld_set[7];
    tx_psc_rdy_8 = fld_set[8];
    tx_psc_rdy_9 = fld_set[9];
    tx_psc_rdy_10 = fld_set[10];
    tx_psc_rdy_11 = fld_set[11];
    tx_psc_rdy_15_12 = fld_set[12];
    tx_psc_rdy_31_16 = fld_set[13];
  endfunction

  function new(input string name="T_tx_psc_rdy_639");
    super.new(name, 32, build_coverage(UVM_CVR_FIELD_VALS));
    if (has_coverage(UVM_CVR_FIELD_VALS)) begin
      wr_fld_covg = new();
      rd_fld_covg = new();
    end
  endfunction

endclass


/////////////////////////////////////////////////////
//                tx_rcvdet_ctrl
/////////////////////////////////////////////////////
class T_tx_rcvdet_ctrl_640 extends cdns_uvm_reg;

  `uvm_object_utils(T_tx_rcvdet_ctrl_640)
  rand uvm_reg_field tx_rcvdet_ctrl_12_0;
  rand uvm_reg_field tx_rcvdet_ctrl_13;
  rand uvm_reg_field tx_rcvdet_ctrl_14;
  rand uvm_reg_field tx_rcvdet_ctrl_15;
  rand uvm_reg_field tx_rcvdet_ctrl_31_16;
  
  covergroup wr_fld_covg;
    tx_rcvdet_ctrl_12_0: coverpoint tx_rcvdet_ctrl_12_0.value[12:0];
    tx_rcvdet_ctrl_13: coverpoint tx_rcvdet_ctrl_13.value[0:0];
    tx_rcvdet_ctrl_14: coverpoint tx_rcvdet_ctrl_14.value[0:0];
    tx_rcvdet_ctrl_15: coverpoint tx_rcvdet_ctrl_15.value[0:0];
    tx_rcvdet_ctrl_31_16: coverpoint tx_rcvdet_ctrl_31_16.value[15:0];
  endgroup
  covergroup rd_fld_covg;
    tx_rcvdet_ctrl_12_0: coverpoint tx_rcvdet_ctrl_12_0.value[12:0];
    tx_rcvdet_ctrl_13: coverpoint tx_rcvdet_ctrl_13.value[0:0];
    tx_rcvdet_ctrl_14: coverpoint tx_rcvdet_ctrl_14.value[0:0];
    tx_rcvdet_ctrl_15: coverpoint tx_rcvdet_ctrl_15.value[0:0];
    tx_rcvdet_ctrl_31_16: coverpoint tx_rcvdet_ctrl_31_16.value[15:0];
  endgroup

  protected virtual function void sample(uvm_reg_data_t data, uvm_reg_data_t byte_en, bit is_read, uvm_reg_map map);
    super.sample(data, byte_en, is_read, map);
    if (get_coverage(UVM_CVR_FIELD_VALS)) begin
      if(!is_read) begin
          wr_fld_covg.sample();
      end
      if(is_read) begin
         rd_fld_covg.sample();
      end
    end
  endfunction

  virtual function void sample_values();
    super.sample_values();
    if (get_coverage(UVM_CVR_FIELD_VALS)) begin
      wr_fld_covg.sample();
      rd_fld_covg.sample();
    end
  endfunction

  virtual function void build();
    uvm_reg_field fld_set[$];
    uvm_reg_field_config_ta ta = get_field_config(getconfigUID());
    build_uvm_reg_fields(this, ta, fld_set);
    
    tx_rcvdet_ctrl_12_0 = fld_set[0];
    tx_rcvdet_ctrl_13 = fld_set[1];
    tx_rcvdet_ctrl_14 = fld_set[2];
    tx_rcvdet_ctrl_15 = fld_set[3];
    tx_rcvdet_ctrl_31_16 = fld_set[4];
  endfunction

  function new(input string name="T_tx_rcvdet_ctrl_640");
    super.new(name, 32, build_coverage(UVM_CVR_FIELD_VALS));
    if (has_coverage(UVM_CVR_FIELD_VALS)) begin
      wr_fld_covg = new();
      rd_fld_covg = new();
    end
  endfunction

endclass


/////////////////////////////////////////////////////
//                tx_rcvdet_en_tmr
/////////////////////////////////////////////////////
class T_tx_rcvdet_en_tmr_642 extends cdns_uvm_reg;

  `uvm_object_utils(T_tx_rcvdet_en_tmr_642)
  rand uvm_reg_field tx_rcvdet_en_tmr_15_0;
  rand uvm_reg_field tx_rcvdet_en_tmr_31_16;
  
  covergroup wr_fld_covg;
    tx_rcvdet_en_tmr_15_0: coverpoint tx_rcvdet_en_tmr_15_0.value[15:0];
    tx_rcvdet_en_tmr_31_16: coverpoint tx_rcvdet_en_tmr_31_16.value[15:0];
  endgroup
  covergroup rd_fld_covg;
    tx_rcvdet_en_tmr_15_0: coverpoint tx_rcvdet_en_tmr_15_0.value[15:0];
    tx_rcvdet_en_tmr_31_16: coverpoint tx_rcvdet_en_tmr_31_16.value[15:0];
  endgroup

  protected virtual function void sample(uvm_reg_data_t data, uvm_reg_data_t byte_en, bit is_read, uvm_reg_map map);
    super.sample(data, byte_en, is_read, map);
    if (get_coverage(UVM_CVR_FIELD_VALS)) begin
      if(!is_read) begin
          wr_fld_covg.sample();
      end
      if(is_read) begin
         rd_fld_covg.sample();
      end
    end
  endfunction

  virtual function void sample_values();
    super.sample_values();
    if (get_coverage(UVM_CVR_FIELD_VALS)) begin
      wr_fld_covg.sample();
      rd_fld_covg.sample();
    end
  endfunction

  virtual function void build();
    uvm_reg_field fld_set[$];
    uvm_reg_field_config_ta ta = get_field_config(getconfigUID());
    build_uvm_reg_fields(this, ta, fld_set);
    
    tx_rcvdet_en_tmr_15_0 = fld_set[0];
    tx_rcvdet_en_tmr_31_16 = fld_set[1];
  endfunction

  function new(input string name="T_tx_rcvdet_en_tmr_642");
    super.new(name, 32, build_coverage(UVM_CVR_FIELD_VALS));
    if (has_coverage(UVM_CVR_FIELD_VALS)) begin
      wr_fld_covg = new();
      rd_fld_covg = new();
    end
  endfunction

endclass


/////////////////////////////////////////////////////
//                tx_rcvdet_ovrd
/////////////////////////////////////////////////////
class T_tx_rcvdet_ovrd_641 extends cdns_uvm_reg;

  `uvm_object_utils(T_tx_rcvdet_ovrd_641)
  rand uvm_reg_field tx_rcvdet_ovrd_13_0;
  rand uvm_reg_field tx_rcvdet_ovrd_14;
  rand uvm_reg_field tx_rcvdet_ovrd_15;
  rand uvm_reg_field tx_rcvdet_ovrd_31_16;
  
  covergroup wr_fld_covg;
    tx_rcvdet_ovrd_13_0: coverpoint tx_rcvdet_ovrd_13_0.value[13:0];
    tx_rcvdet_ovrd_14: coverpoint tx_rcvdet_ovrd_14.value[0:0];
    tx_rcvdet_ovrd_15: coverpoint tx_rcvdet_ovrd_15.value[0:0];
    tx_rcvdet_ovrd_31_16: coverpoint tx_rcvdet_ovrd_31_16.value[15:0];
  endgroup
  covergroup rd_fld_covg;
    tx_rcvdet_ovrd_13_0: coverpoint tx_rcvdet_ovrd_13_0.value[13:0];
    tx_rcvdet_ovrd_14: coverpoint tx_rcvdet_ovrd_14.value[0:0];
    tx_rcvdet_ovrd_15: coverpoint tx_rcvdet_ovrd_15.value[0:0];
    tx_rcvdet_ovrd_31_16: coverpoint tx_rcvdet_ovrd_31_16.value[15:0];
  endgroup

  protected virtual function void sample(uvm_reg_data_t data, uvm_reg_data_t byte_en, bit is_read, uvm_reg_map map);
    super.sample(data, byte_en, is_read, map);
    if (get_coverage(UVM_CVR_FIELD_VALS)) begin
      if(!is_read) begin
          wr_fld_covg.sample();
      end
      if(is_read) begin
         rd_fld_covg.sample();
      end
    end
  endfunction

  virtual function void sample_values();
    super.sample_values();
    if (get_coverage(UVM_CVR_FIELD_VALS)) begin
      wr_fld_covg.sample();
      rd_fld_covg.sample();
    end
  endfunction

  virtual function void build();
    uvm_reg_field fld_set[$];
    uvm_reg_field_config_ta ta = get_field_config(getconfigUID());
    build_uvm_reg_fields(this, ta, fld_set);
    
    tx_rcvdet_ovrd_13_0 = fld_set[0];
    tx_rcvdet_ovrd_14 = fld_set[1];
    tx_rcvdet_ovrd_15 = fld_set[2];
    tx_rcvdet_ovrd_31_16 = fld_set[3];
  endfunction

  function new(input string name="T_tx_rcvdet_ovrd_641");
    super.new(name, 32, build_coverage(UVM_CVR_FIELD_VALS));
    if (has_coverage(UVM_CVR_FIELD_VALS)) begin
      wr_fld_covg = new();
      rd_fld_covg = new();
    end
  endfunction

endclass


/////////////////////////////////////////////////////
//                tx_rcvdet_st_tmr
/////////////////////////////////////////////////////
class T_tx_rcvdet_st_tmr_643 extends cdns_uvm_reg;

  `uvm_object_utils(T_tx_rcvdet_st_tmr_643)
  rand uvm_reg_field tx_rcvdet_st_tmr_15_0;
  rand uvm_reg_field tx_rcvdet_st_tmr_31_16;
  
  covergroup wr_fld_covg;
    tx_rcvdet_st_tmr_15_0: coverpoint tx_rcvdet_st_tmr_15_0.value[15:0];
    tx_rcvdet_st_tmr_31_16: coverpoint tx_rcvdet_st_tmr_31_16.value[15:0];
  endgroup
  covergroup rd_fld_covg;
    tx_rcvdet_st_tmr_15_0: coverpoint tx_rcvdet_st_tmr_15_0.value[15:0];
    tx_rcvdet_st_tmr_31_16: coverpoint tx_rcvdet_st_tmr_31_16.value[15:0];
  endgroup

  protected virtual function void sample(uvm_reg_data_t data, uvm_reg_data_t byte_en, bit is_read, uvm_reg_map map);
    super.sample(data, byte_en, is_read, map);
    if (get_coverage(UVM_CVR_FIELD_VALS)) begin
      if(!is_read) begin
          wr_fld_covg.sample();
      end
      if(is_read) begin
         rd_fld_covg.sample();
      end
    end
  endfunction

  virtual function void sample_values();
    super.sample_values();
    if (get_coverage(UVM_CVR_FIELD_VALS)) begin
      wr_fld_covg.sample();
      rd_fld_covg.sample();
    end
  endfunction

  virtual function void build();
    uvm_reg_field fld_set[$];
    uvm_reg_field_config_ta ta = get_field_config(getconfigUID());
    build_uvm_reg_fields(this, ta, fld_set);
    
    tx_rcvdet_st_tmr_15_0 = fld_set[0];
    tx_rcvdet_st_tmr_31_16 = fld_set[1];
  endfunction

  function new(input string name="T_tx_rcvdet_st_tmr_643");
    super.new(name, 32, build_coverage(UVM_CVR_FIELD_VALS));
    if (has_coverage(UVM_CVR_FIELD_VALS)) begin
      wr_fld_covg = new();
      rd_fld_covg = new();
    end
  endfunction

endclass


/////////////////////////////////////////////////////
//                tx_txcc_cpost_mult_00
/////////////////////////////////////////////////////
class T_tx_txcc_cpost_mult_00_575 extends cdns_uvm_reg;

  `uvm_object_utils(T_tx_txcc_cpost_mult_00_575)
  rand uvm_reg_field tx_txcc_cpost_mult_00_7_0;
  rand uvm_reg_field tx_txcc_cpost_mult_00_15_8;
  rand uvm_reg_field tx_txcc_cpost_mult_00_31_16;
  
  covergroup wr_fld_covg;
    tx_txcc_cpost_mult_00_7_0: coverpoint tx_txcc_cpost_mult_00_7_0.value[7:0];
    tx_txcc_cpost_mult_00_15_8: coverpoint tx_txcc_cpost_mult_00_15_8.value[7:0];
    tx_txcc_cpost_mult_00_31_16: coverpoint tx_txcc_cpost_mult_00_31_16.value[15:0];
  endgroup
  covergroup rd_fld_covg;
    tx_txcc_cpost_mult_00_7_0: coverpoint tx_txcc_cpost_mult_00_7_0.value[7:0];
    tx_txcc_cpost_mult_00_15_8: coverpoint tx_txcc_cpost_mult_00_15_8.value[7:0];
    tx_txcc_cpost_mult_00_31_16: coverpoint tx_txcc_cpost_mult_00_31_16.value[15:0];
  endgroup

  protected virtual function void sample(uvm_reg_data_t data, uvm_reg_data_t byte_en, bit is_read, uvm_reg_map map);
    super.sample(data, byte_en, is_read, map);
    if (get_coverage(UVM_CVR_FIELD_VALS)) begin
      if(!is_read) begin
          wr_fld_covg.sample();
      end
      if(is_read) begin
         rd_fld_covg.sample();
      end
    end
  endfunction

  virtual function void sample_values();
    super.sample_values();
    if (get_coverage(UVM_CVR_FIELD_VALS)) begin
      wr_fld_covg.sample();
      rd_fld_covg.sample();
    end
  endfunction

  virtual function void build();
    uvm_reg_field fld_set[$];
    uvm_reg_field_config_ta ta = get_field_config(getconfigUID());
    build_uvm_reg_fields(this, ta, fld_set);
    
    tx_txcc_cpost_mult_00_7_0 = fld_set[0];
    tx_txcc_cpost_mult_00_15_8 = fld_set[1];
    tx_txcc_cpost_mult_00_31_16 = fld_set[2];
  endfunction

  function new(input string name="T_tx_txcc_cpost_mult_00_575");
    super.new(name, 32, build_coverage(UVM_CVR_FIELD_VALS));
    if (has_coverage(UVM_CVR_FIELD_VALS)) begin
      wr_fld_covg = new();
      rd_fld_covg = new();
    end
  endfunction

endclass


/////////////////////////////////////////////////////
//                tx_txcc_cpost_mult_01
/////////////////////////////////////////////////////
class T_tx_txcc_cpost_mult_01_576 extends cdns_uvm_reg;

  `uvm_object_utils(T_tx_txcc_cpost_mult_01_576)
  rand uvm_reg_field tx_txcc_cpost_mult_01_7_0;
  rand uvm_reg_field tx_txcc_cpost_mult_01_15_8;
  rand uvm_reg_field tx_txcc_cpost_mult_01_31_16;
  
  covergroup wr_fld_covg;
    tx_txcc_cpost_mult_01_7_0: coverpoint tx_txcc_cpost_mult_01_7_0.value[7:0];
    tx_txcc_cpost_mult_01_15_8: coverpoint tx_txcc_cpost_mult_01_15_8.value[7:0];
    tx_txcc_cpost_mult_01_31_16: coverpoint tx_txcc_cpost_mult_01_31_16.value[15:0];
  endgroup
  covergroup rd_fld_covg;
    tx_txcc_cpost_mult_01_7_0: coverpoint tx_txcc_cpost_mult_01_7_0.value[7:0];
    tx_txcc_cpost_mult_01_15_8: coverpoint tx_txcc_cpost_mult_01_15_8.value[7:0];
    tx_txcc_cpost_mult_01_31_16: coverpoint tx_txcc_cpost_mult_01_31_16.value[15:0];
  endgroup

  protected virtual function void sample(uvm_reg_data_t data, uvm_reg_data_t byte_en, bit is_read, uvm_reg_map map);
    super.sample(data, byte_en, is_read, map);
    if (get_coverage(UVM_CVR_FIELD_VALS)) begin
      if(!is_read) begin
          wr_fld_covg.sample();
      end
      if(is_read) begin
         rd_fld_covg.sample();
      end
    end
  endfunction

  virtual function void sample_values();
    super.sample_values();
    if (get_coverage(UVM_CVR_FIELD_VALS)) begin
      wr_fld_covg.sample();
      rd_fld_covg.sample();
    end
  endfunction

  virtual function void build();
    uvm_reg_field fld_set[$];
    uvm_reg_field_config_ta ta = get_field_config(getconfigUID());
    build_uvm_reg_fields(this, ta, fld_set);
    
    tx_txcc_cpost_mult_01_7_0 = fld_set[0];
    tx_txcc_cpost_mult_01_15_8 = fld_set[1];
    tx_txcc_cpost_mult_01_31_16 = fld_set[2];
  endfunction

  function new(input string name="T_tx_txcc_cpost_mult_01_576");
    super.new(name, 32, build_coverage(UVM_CVR_FIELD_VALS));
    if (has_coverage(UVM_CVR_FIELD_VALS)) begin
      wr_fld_covg = new();
      rd_fld_covg = new();
    end
  endfunction

endclass


/////////////////////////////////////////////////////
//                tx_txcc_cpost_mult_10
/////////////////////////////////////////////////////
class T_tx_txcc_cpost_mult_10_577 extends cdns_uvm_reg;

  `uvm_object_utils(T_tx_txcc_cpost_mult_10_577)
  rand uvm_reg_field tx_txcc_cpost_mult_10_7_0;
  rand uvm_reg_field tx_txcc_cpost_mult_10_15_8;
  rand uvm_reg_field tx_txcc_cpost_mult_10_31_16;
  
  covergroup wr_fld_covg;
    tx_txcc_cpost_mult_10_7_0: coverpoint tx_txcc_cpost_mult_10_7_0.value[7:0];
    tx_txcc_cpost_mult_10_15_8: coverpoint tx_txcc_cpost_mult_10_15_8.value[7:0];
    tx_txcc_cpost_mult_10_31_16: coverpoint tx_txcc_cpost_mult_10_31_16.value[15:0];
  endgroup
  covergroup rd_fld_covg;
    tx_txcc_cpost_mult_10_7_0: coverpoint tx_txcc_cpost_mult_10_7_0.value[7:0];
    tx_txcc_cpost_mult_10_15_8: coverpoint tx_txcc_cpost_mult_10_15_8.value[7:0];
    tx_txcc_cpost_mult_10_31_16: coverpoint tx_txcc_cpost_mult_10_31_16.value[15:0];
  endgroup

  protected virtual function void sample(uvm_reg_data_t data, uvm_reg_data_t byte_en, bit is_read, uvm_reg_map map);
    super.sample(data, byte_en, is_read, map);
    if (get_coverage(UVM_CVR_FIELD_VALS)) begin
      if(!is_read) begin
          wr_fld_covg.sample();
      end
      if(is_read) begin
         rd_fld_covg.sample();
      end
    end
  endfunction

  virtual function void sample_values();
    super.sample_values();
    if (get_coverage(UVM_CVR_FIELD_VALS)) begin
      wr_fld_covg.sample();
      rd_fld_covg.sample();
    end
  endfunction

  virtual function void build();
    uvm_reg_field fld_set[$];
    uvm_reg_field_config_ta ta = get_field_config(getconfigUID());
    build_uvm_reg_fields(this, ta, fld_set);
    
    tx_txcc_cpost_mult_10_7_0 = fld_set[0];
    tx_txcc_cpost_mult_10_15_8 = fld_set[1];
    tx_txcc_cpost_mult_10_31_16 = fld_set[2];
  endfunction

  function new(input string name="T_tx_txcc_cpost_mult_10_577");
    super.new(name, 32, build_coverage(UVM_CVR_FIELD_VALS));
    if (has_coverage(UVM_CVR_FIELD_VALS)) begin
      wr_fld_covg = new();
      rd_fld_covg = new();
    end
  endfunction

endclass


/////////////////////////////////////////////////////
//                tx_txcc_cpost_mult_11
/////////////////////////////////////////////////////
class T_tx_txcc_cpost_mult_11_578 extends cdns_uvm_reg;

  `uvm_object_utils(T_tx_txcc_cpost_mult_11_578)
  rand uvm_reg_field tx_txcc_cpost_mult_11_7_0;
  rand uvm_reg_field tx_txcc_cpost_mult_11_15_8;
  rand uvm_reg_field tx_txcc_cpost_mult_11_31_16;
  
  covergroup wr_fld_covg;
    tx_txcc_cpost_mult_11_7_0: coverpoint tx_txcc_cpost_mult_11_7_0.value[7:0];
    tx_txcc_cpost_mult_11_15_8: coverpoint tx_txcc_cpost_mult_11_15_8.value[7:0];
    tx_txcc_cpost_mult_11_31_16: coverpoint tx_txcc_cpost_mult_11_31_16.value[15:0];
  endgroup
  covergroup rd_fld_covg;
    tx_txcc_cpost_mult_11_7_0: coverpoint tx_txcc_cpost_mult_11_7_0.value[7:0];
    tx_txcc_cpost_mult_11_15_8: coverpoint tx_txcc_cpost_mult_11_15_8.value[7:0];
    tx_txcc_cpost_mult_11_31_16: coverpoint tx_txcc_cpost_mult_11_31_16.value[15:0];
  endgroup

  protected virtual function void sample(uvm_reg_data_t data, uvm_reg_data_t byte_en, bit is_read, uvm_reg_map map);
    super.sample(data, byte_en, is_read, map);
    if (get_coverage(UVM_CVR_FIELD_VALS)) begin
      if(!is_read) begin
          wr_fld_covg.sample();
      end
      if(is_read) begin
         rd_fld_covg.sample();
      end
    end
  endfunction

  virtual function void sample_values();
    super.sample_values();
    if (get_coverage(UVM_CVR_FIELD_VALS)) begin
      wr_fld_covg.sample();
      rd_fld_covg.sample();
    end
  endfunction

  virtual function void build();
    uvm_reg_field fld_set[$];
    uvm_reg_field_config_ta ta = get_field_config(getconfigUID());
    build_uvm_reg_fields(this, ta, fld_set);
    
    tx_txcc_cpost_mult_11_7_0 = fld_set[0];
    tx_txcc_cpost_mult_11_15_8 = fld_set[1];
    tx_txcc_cpost_mult_11_31_16 = fld_set[2];
  endfunction

  function new(input string name="T_tx_txcc_cpost_mult_11_578");
    super.new(name, 32, build_coverage(UVM_CVR_FIELD_VALS));
    if (has_coverage(UVM_CVR_FIELD_VALS)) begin
      wr_fld_covg = new();
      rd_fld_covg = new();
    end
  endfunction

endclass


/////////////////////////////////////////////////////
//                tx_txcc_cpre_mult_00
/////////////////////////////////////////////////////
class T_tx_txcc_cpre_mult_00_571 extends cdns_uvm_reg;

  `uvm_object_utils(T_tx_txcc_cpre_mult_00_571)
  rand uvm_reg_field tx_txcc_cpre_mult_00_7_0;
  rand uvm_reg_field tx_txcc_cpre_mult_00_15_8;
  rand uvm_reg_field tx_txcc_cpre_mult_00_31_16;
  
  covergroup wr_fld_covg;
    tx_txcc_cpre_mult_00_7_0: coverpoint tx_txcc_cpre_mult_00_7_0.value[7:0];
    tx_txcc_cpre_mult_00_15_8: coverpoint tx_txcc_cpre_mult_00_15_8.value[7:0];
    tx_txcc_cpre_mult_00_31_16: coverpoint tx_txcc_cpre_mult_00_31_16.value[15:0];
  endgroup
  covergroup rd_fld_covg;
    tx_txcc_cpre_mult_00_7_0: coverpoint tx_txcc_cpre_mult_00_7_0.value[7:0];
    tx_txcc_cpre_mult_00_15_8: coverpoint tx_txcc_cpre_mult_00_15_8.value[7:0];
    tx_txcc_cpre_mult_00_31_16: coverpoint tx_txcc_cpre_mult_00_31_16.value[15:0];
  endgroup

  protected virtual function void sample(uvm_reg_data_t data, uvm_reg_data_t byte_en, bit is_read, uvm_reg_map map);
    super.sample(data, byte_en, is_read, map);
    if (get_coverage(UVM_CVR_FIELD_VALS)) begin
      if(!is_read) begin
          wr_fld_covg.sample();
      end
      if(is_read) begin
         rd_fld_covg.sample();
      end
    end
  endfunction

  virtual function void sample_values();
    super.sample_values();
    if (get_coverage(UVM_CVR_FIELD_VALS)) begin
      wr_fld_covg.sample();
      rd_fld_covg.sample();
    end
  endfunction

  virtual function void build();
    uvm_reg_field fld_set[$];
    uvm_reg_field_config_ta ta = get_field_config(getconfigUID());
    build_uvm_reg_fields(this, ta, fld_set);
    
    tx_txcc_cpre_mult_00_7_0 = fld_set[0];
    tx_txcc_cpre_mult_00_15_8 = fld_set[1];
    tx_txcc_cpre_mult_00_31_16 = fld_set[2];
  endfunction

  function new(input string name="T_tx_txcc_cpre_mult_00_571");
    super.new(name, 32, build_coverage(UVM_CVR_FIELD_VALS));
    if (has_coverage(UVM_CVR_FIELD_VALS)) begin
      wr_fld_covg = new();
      rd_fld_covg = new();
    end
  endfunction

endclass


/////////////////////////////////////////////////////
//                tx_txcc_cpre_mult_01
/////////////////////////////////////////////////////
class T_tx_txcc_cpre_mult_01_572 extends cdns_uvm_reg;

  `uvm_object_utils(T_tx_txcc_cpre_mult_01_572)
  rand uvm_reg_field tx_txcc_cpre_mult_01_7_0;
  rand uvm_reg_field tx_txcc_cpre_mult_01_15_8;
  rand uvm_reg_field tx_txcc_cpre_mult_01_31_16;
  
  covergroup wr_fld_covg;
    tx_txcc_cpre_mult_01_7_0: coverpoint tx_txcc_cpre_mult_01_7_0.value[7:0];
    tx_txcc_cpre_mult_01_15_8: coverpoint tx_txcc_cpre_mult_01_15_8.value[7:0];
    tx_txcc_cpre_mult_01_31_16: coverpoint tx_txcc_cpre_mult_01_31_16.value[15:0];
  endgroup
  covergroup rd_fld_covg;
    tx_txcc_cpre_mult_01_7_0: coverpoint tx_txcc_cpre_mult_01_7_0.value[7:0];
    tx_txcc_cpre_mult_01_15_8: coverpoint tx_txcc_cpre_mult_01_15_8.value[7:0];
    tx_txcc_cpre_mult_01_31_16: coverpoint tx_txcc_cpre_mult_01_31_16.value[15:0];
  endgroup

  protected virtual function void sample(uvm_reg_data_t data, uvm_reg_data_t byte_en, bit is_read, uvm_reg_map map);
    super.sample(data, byte_en, is_read, map);
    if (get_coverage(UVM_CVR_FIELD_VALS)) begin
      if(!is_read) begin
          wr_fld_covg.sample();
      end
      if(is_read) begin
         rd_fld_covg.sample();
      end
    end
  endfunction

  virtual function void sample_values();
    super.sample_values();
    if (get_coverage(UVM_CVR_FIELD_VALS)) begin
      wr_fld_covg.sample();
      rd_fld_covg.sample();
    end
  endfunction

  virtual function void build();
    uvm_reg_field fld_set[$];
    uvm_reg_field_config_ta ta = get_field_config(getconfigUID());
    build_uvm_reg_fields(this, ta, fld_set);
    
    tx_txcc_cpre_mult_01_7_0 = fld_set[0];
    tx_txcc_cpre_mult_01_15_8 = fld_set[1];
    tx_txcc_cpre_mult_01_31_16 = fld_set[2];
  endfunction

  function new(input string name="T_tx_txcc_cpre_mult_01_572");
    super.new(name, 32, build_coverage(UVM_CVR_FIELD_VALS));
    if (has_coverage(UVM_CVR_FIELD_VALS)) begin
      wr_fld_covg = new();
      rd_fld_covg = new();
    end
  endfunction

endclass


/////////////////////////////////////////////////////
//                tx_txcc_cpre_mult_10
/////////////////////////////////////////////////////
class T_tx_txcc_cpre_mult_10_573 extends cdns_uvm_reg;

  `uvm_object_utils(T_tx_txcc_cpre_mult_10_573)
  rand uvm_reg_field tx_txcc_cpre_mult_10_7_0;
  rand uvm_reg_field tx_txcc_cpre_mult_10_15_8;
  rand uvm_reg_field tx_txcc_cpre_mult_10_31_16;
  
  covergroup wr_fld_covg;
    tx_txcc_cpre_mult_10_7_0: coverpoint tx_txcc_cpre_mult_10_7_0.value[7:0];
    tx_txcc_cpre_mult_10_15_8: coverpoint tx_txcc_cpre_mult_10_15_8.value[7:0];
    tx_txcc_cpre_mult_10_31_16: coverpoint tx_txcc_cpre_mult_10_31_16.value[15:0];
  endgroup
  covergroup rd_fld_covg;
    tx_txcc_cpre_mult_10_7_0: coverpoint tx_txcc_cpre_mult_10_7_0.value[7:0];
    tx_txcc_cpre_mult_10_15_8: coverpoint tx_txcc_cpre_mult_10_15_8.value[7:0];
    tx_txcc_cpre_mult_10_31_16: coverpoint tx_txcc_cpre_mult_10_31_16.value[15:0];
  endgroup

  protected virtual function void sample(uvm_reg_data_t data, uvm_reg_data_t byte_en, bit is_read, uvm_reg_map map);
    super.sample(data, byte_en, is_read, map);
    if (get_coverage(UVM_CVR_FIELD_VALS)) begin
      if(!is_read) begin
          wr_fld_covg.sample();
      end
      if(is_read) begin
         rd_fld_covg.sample();
      end
    end
  endfunction

  virtual function void sample_values();
    super.sample_values();
    if (get_coverage(UVM_CVR_FIELD_VALS)) begin
      wr_fld_covg.sample();
      rd_fld_covg.sample();
    end
  endfunction

  virtual function void build();
    uvm_reg_field fld_set[$];
    uvm_reg_field_config_ta ta = get_field_config(getconfigUID());
    build_uvm_reg_fields(this, ta, fld_set);
    
    tx_txcc_cpre_mult_10_7_0 = fld_set[0];
    tx_txcc_cpre_mult_10_15_8 = fld_set[1];
    tx_txcc_cpre_mult_10_31_16 = fld_set[2];
  endfunction

  function new(input string name="T_tx_txcc_cpre_mult_10_573");
    super.new(name, 32, build_coverage(UVM_CVR_FIELD_VALS));
    if (has_coverage(UVM_CVR_FIELD_VALS)) begin
      wr_fld_covg = new();
      rd_fld_covg = new();
    end
  endfunction

endclass


/////////////////////////////////////////////////////
//                tx_txcc_cpre_mult_11
/////////////////////////////////////////////////////
class T_tx_txcc_cpre_mult_11_574 extends cdns_uvm_reg;

  `uvm_object_utils(T_tx_txcc_cpre_mult_11_574)
  rand uvm_reg_field tx_txcc_cpre_mult_11_7_0;
  rand uvm_reg_field tx_txcc_cpre_mult_11_15_8;
  rand uvm_reg_field tx_txcc_cpre_mult_11_31_16;
  
  covergroup wr_fld_covg;
    tx_txcc_cpre_mult_11_7_0: coverpoint tx_txcc_cpre_mult_11_7_0.value[7:0];
    tx_txcc_cpre_mult_11_15_8: coverpoint tx_txcc_cpre_mult_11_15_8.value[7:0];
    tx_txcc_cpre_mult_11_31_16: coverpoint tx_txcc_cpre_mult_11_31_16.value[15:0];
  endgroup
  covergroup rd_fld_covg;
    tx_txcc_cpre_mult_11_7_0: coverpoint tx_txcc_cpre_mult_11_7_0.value[7:0];
    tx_txcc_cpre_mult_11_15_8: coverpoint tx_txcc_cpre_mult_11_15_8.value[7:0];
    tx_txcc_cpre_mult_11_31_16: coverpoint tx_txcc_cpre_mult_11_31_16.value[15:0];
  endgroup

  protected virtual function void sample(uvm_reg_data_t data, uvm_reg_data_t byte_en, bit is_read, uvm_reg_map map);
    super.sample(data, byte_en, is_read, map);
    if (get_coverage(UVM_CVR_FIELD_VALS)) begin
      if(!is_read) begin
          wr_fld_covg.sample();
      end
      if(is_read) begin
         rd_fld_covg.sample();
      end
    end
  endfunction

  virtual function void sample_values();
    super.sample_values();
    if (get_coverage(UVM_CVR_FIELD_VALS)) begin
      wr_fld_covg.sample();
      rd_fld_covg.sample();
    end
  endfunction

  virtual function void build();
    uvm_reg_field fld_set[$];
    uvm_reg_field_config_ta ta = get_field_config(getconfigUID());
    build_uvm_reg_fields(this, ta, fld_set);
    
    tx_txcc_cpre_mult_11_7_0 = fld_set[0];
    tx_txcc_cpre_mult_11_15_8 = fld_set[1];
    tx_txcc_cpre_mult_11_31_16 = fld_set[2];
  endfunction

  function new(input string name="T_tx_txcc_cpre_mult_11_574");
    super.new(name, 32, build_coverage(UVM_CVR_FIELD_VALS));
    if (has_coverage(UVM_CVR_FIELD_VALS)) begin
      wr_fld_covg = new();
      rd_fld_covg = new();
    end
  endfunction

endclass


/////////////////////////////////////////////////////
//                tx_txcc_ctrl
/////////////////////////////////////////////////////
class T_tx_txcc_ctrl_563 extends cdns_uvm_reg;

  `uvm_object_utils(T_tx_txcc_ctrl_563)
  rand uvm_reg_field tx_txcc_ctrl_0;
  rand uvm_reg_field tx_txcc_ctrl_1;
  rand uvm_reg_field tx_txcc_ctrl_2;
  rand uvm_reg_field tx_txcc_ctrl_3;
  rand uvm_reg_field tx_txcc_ctrl_5_4;
  rand uvm_reg_field tx_txcc_ctrl_7_6;
  rand uvm_reg_field tx_txcc_ctrl_9_8;
  rand uvm_reg_field tx_txcc_ctrl_11_10;
  rand uvm_reg_field tx_txcc_ctrl_13_12;
  rand uvm_reg_field tx_txcc_ctrl_15_14;
  rand uvm_reg_field tx_txcc_ctrl_31_16;
  
  covergroup wr_fld_covg;
    tx_txcc_ctrl_0: coverpoint tx_txcc_ctrl_0.value[0:0];
    tx_txcc_ctrl_1: coverpoint tx_txcc_ctrl_1.value[0:0];
    tx_txcc_ctrl_2: coverpoint tx_txcc_ctrl_2.value[0:0];
    tx_txcc_ctrl_3: coverpoint tx_txcc_ctrl_3.value[0:0];
    tx_txcc_ctrl_5_4: coverpoint tx_txcc_ctrl_5_4.value[1:0];
    tx_txcc_ctrl_7_6: coverpoint tx_txcc_ctrl_7_6.value[1:0];
    tx_txcc_ctrl_9_8: coverpoint tx_txcc_ctrl_9_8.value[1:0];
    tx_txcc_ctrl_11_10: coverpoint tx_txcc_ctrl_11_10.value[1:0];
    tx_txcc_ctrl_13_12: coverpoint tx_txcc_ctrl_13_12.value[1:0];
    tx_txcc_ctrl_15_14: coverpoint tx_txcc_ctrl_15_14.value[1:0];
    tx_txcc_ctrl_31_16: coverpoint tx_txcc_ctrl_31_16.value[15:0];
  endgroup
  covergroup rd_fld_covg;
    tx_txcc_ctrl_0: coverpoint tx_txcc_ctrl_0.value[0:0];
    tx_txcc_ctrl_1: coverpoint tx_txcc_ctrl_1.value[0:0];
    tx_txcc_ctrl_2: coverpoint tx_txcc_ctrl_2.value[0:0];
    tx_txcc_ctrl_3: coverpoint tx_txcc_ctrl_3.value[0:0];
    tx_txcc_ctrl_5_4: coverpoint tx_txcc_ctrl_5_4.value[1:0];
    tx_txcc_ctrl_7_6: coverpoint tx_txcc_ctrl_7_6.value[1:0];
    tx_txcc_ctrl_9_8: coverpoint tx_txcc_ctrl_9_8.value[1:0];
    tx_txcc_ctrl_11_10: coverpoint tx_txcc_ctrl_11_10.value[1:0];
    tx_txcc_ctrl_13_12: coverpoint tx_txcc_ctrl_13_12.value[1:0];
    tx_txcc_ctrl_15_14: coverpoint tx_txcc_ctrl_15_14.value[1:0];
    tx_txcc_ctrl_31_16: coverpoint tx_txcc_ctrl_31_16.value[15:0];
  endgroup

  protected virtual function void sample(uvm_reg_data_t data, uvm_reg_data_t byte_en, bit is_read, uvm_reg_map map);
    super.sample(data, byte_en, is_read, map);
    if (get_coverage(UVM_CVR_FIELD_VALS)) begin
      if(!is_read) begin
          wr_fld_covg.sample();
      end
      if(is_read) begin
         rd_fld_covg.sample();
      end
    end
  endfunction

  virtual function void sample_values();
    super.sample_values();
    if (get_coverage(UVM_CVR_FIELD_VALS)) begin
      wr_fld_covg.sample();
      rd_fld_covg.sample();
    end
  endfunction

  virtual function void build();
    uvm_reg_field fld_set[$];
    uvm_reg_field_config_ta ta = get_field_config(getconfigUID());
    build_uvm_reg_fields(this, ta, fld_set);
    
    tx_txcc_ctrl_0 = fld_set[0];
    tx_txcc_ctrl_1 = fld_set[1];
    tx_txcc_ctrl_2 = fld_set[2];
    tx_txcc_ctrl_3 = fld_set[3];
    tx_txcc_ctrl_5_4 = fld_set[4];
    tx_txcc_ctrl_7_6 = fld_set[5];
    tx_txcc_ctrl_9_8 = fld_set[6];
    tx_txcc_ctrl_11_10 = fld_set[7];
    tx_txcc_ctrl_13_12 = fld_set[8];
    tx_txcc_ctrl_15_14 = fld_set[9];
    tx_txcc_ctrl_31_16 = fld_set[10];
  endfunction

  function new(input string name="T_tx_txcc_ctrl_563");
    super.new(name, 32, build_coverage(UVM_CVR_FIELD_VALS));
    if (has_coverage(UVM_CVR_FIELD_VALS)) begin
      wr_fld_covg = new();
      rd_fld_covg = new();
    end
  endfunction

endclass


/////////////////////////////////////////////////////
//                tx_txcc_ipost_coef_value
/////////////////////////////////////////////////////
class T_tx_txcc_ipost_coef_value_616 extends cdns_uvm_reg;

  `uvm_object_utils(T_tx_txcc_ipost_coef_value_616)
  rand uvm_reg_field tx_txcc_ipost_coef_value_5_0;
  rand uvm_reg_field tx_txcc_ipost_coef_value_15_6;
  rand uvm_reg_field tx_txcc_ipost_coef_value_31_16;
  
  covergroup wr_fld_covg;
    tx_txcc_ipost_coef_value_5_0: coverpoint tx_txcc_ipost_coef_value_5_0.value[5:0];
    tx_txcc_ipost_coef_value_15_6: coverpoint tx_txcc_ipost_coef_value_15_6.value[9:0];
    tx_txcc_ipost_coef_value_31_16: coverpoint tx_txcc_ipost_coef_value_31_16.value[15:0];
  endgroup
  covergroup rd_fld_covg;
    tx_txcc_ipost_coef_value_5_0: coverpoint tx_txcc_ipost_coef_value_5_0.value[5:0];
    tx_txcc_ipost_coef_value_15_6: coverpoint tx_txcc_ipost_coef_value_15_6.value[9:0];
    tx_txcc_ipost_coef_value_31_16: coverpoint tx_txcc_ipost_coef_value_31_16.value[15:0];
  endgroup

  protected virtual function void sample(uvm_reg_data_t data, uvm_reg_data_t byte_en, bit is_read, uvm_reg_map map);
    super.sample(data, byte_en, is_read, map);
    if (get_coverage(UVM_CVR_FIELD_VALS)) begin
      if(!is_read) begin
          wr_fld_covg.sample();
      end
      if(is_read) begin
         rd_fld_covg.sample();
      end
    end
  endfunction

  virtual function void sample_values();
    super.sample_values();
    if (get_coverage(UVM_CVR_FIELD_VALS)) begin
      wr_fld_covg.sample();
      rd_fld_covg.sample();
    end
  endfunction

  virtual function void build();
    uvm_reg_field fld_set[$];
    uvm_reg_field_config_ta ta = get_field_config(getconfigUID());
    build_uvm_reg_fields(this, ta, fld_set);
    
    tx_txcc_ipost_coef_value_5_0 = fld_set[0];
    tx_txcc_ipost_coef_value_15_6 = fld_set[1];
    tx_txcc_ipost_coef_value_31_16 = fld_set[2];
  endfunction

  function new(input string name="T_tx_txcc_ipost_coef_value_616");
    super.new(name, 32, build_coverage(UVM_CVR_FIELD_VALS));
    if (has_coverage(UVM_CVR_FIELD_VALS)) begin
      wr_fld_covg = new();
      rd_fld_covg = new();
    end
  endfunction

endclass


/////////////////////////////////////////////////////
//                tx_txcc_ipre_coef_value
/////////////////////////////////////////////////////
class T_tx_txcc_ipre_coef_value_605 extends cdns_uvm_reg;

  `uvm_object_utils(T_tx_txcc_ipre_coef_value_605)
  rand uvm_reg_field tx_txcc_ipre_coef_value_5_0;
  rand uvm_reg_field tx_txcc_ipre_coef_value_7_6;
  rand uvm_reg_field tx_txcc_ipre_coef_value_13_8;
  rand uvm_reg_field tx_txcc_ipre_coef_value_15_14;
  rand uvm_reg_field tx_txcc_ipre_coef_value_31_16;
  
  covergroup wr_fld_covg;
    tx_txcc_ipre_coef_value_5_0: coverpoint tx_txcc_ipre_coef_value_5_0.value[5:0];
    tx_txcc_ipre_coef_value_7_6: coverpoint tx_txcc_ipre_coef_value_7_6.value[1:0];
    tx_txcc_ipre_coef_value_13_8: coverpoint tx_txcc_ipre_coef_value_13_8.value[5:0];
    tx_txcc_ipre_coef_value_15_14: coverpoint tx_txcc_ipre_coef_value_15_14.value[1:0];
    tx_txcc_ipre_coef_value_31_16: coverpoint tx_txcc_ipre_coef_value_31_16.value[15:0];
  endgroup
  covergroup rd_fld_covg;
    tx_txcc_ipre_coef_value_5_0: coverpoint tx_txcc_ipre_coef_value_5_0.value[5:0];
    tx_txcc_ipre_coef_value_7_6: coverpoint tx_txcc_ipre_coef_value_7_6.value[1:0];
    tx_txcc_ipre_coef_value_13_8: coverpoint tx_txcc_ipre_coef_value_13_8.value[5:0];
    tx_txcc_ipre_coef_value_15_14: coverpoint tx_txcc_ipre_coef_value_15_14.value[1:0];
    tx_txcc_ipre_coef_value_31_16: coverpoint tx_txcc_ipre_coef_value_31_16.value[15:0];
  endgroup

  protected virtual function void sample(uvm_reg_data_t data, uvm_reg_data_t byte_en, bit is_read, uvm_reg_map map);
    super.sample(data, byte_en, is_read, map);
    if (get_coverage(UVM_CVR_FIELD_VALS)) begin
      if(!is_read) begin
          wr_fld_covg.sample();
      end
      if(is_read) begin
         rd_fld_covg.sample();
      end
    end
  endfunction

  virtual function void sample_values();
    super.sample_values();
    if (get_coverage(UVM_CVR_FIELD_VALS)) begin
      wr_fld_covg.sample();
      rd_fld_covg.sample();
    end
  endfunction

  virtual function void build();
    uvm_reg_field fld_set[$];
    uvm_reg_field_config_ta ta = get_field_config(getconfigUID());
    build_uvm_reg_fields(this, ta, fld_set);
    
    tx_txcc_ipre_coef_value_5_0 = fld_set[0];
    tx_txcc_ipre_coef_value_7_6 = fld_set[1];
    tx_txcc_ipre_coef_value_13_8 = fld_set[2];
    tx_txcc_ipre_coef_value_15_14 = fld_set[3];
    tx_txcc_ipre_coef_value_31_16 = fld_set[4];
  endfunction

  function new(input string name="T_tx_txcc_ipre_coef_value_605");
    super.new(name, 32, build_coverage(UVM_CVR_FIELD_VALS));
    if (has_coverage(UVM_CVR_FIELD_VALS)) begin
      wr_fld_covg = new();
      rd_fld_covg = new();
    end
  endfunction

endclass


/////////////////////////////////////////////////////
//                tx_txcc_lf_mult
/////////////////////////////////////////////////////
class T_tx_txcc_lf_mult_570 extends cdns_uvm_reg;

  `uvm_object_utils(T_tx_txcc_lf_mult_570)
  rand uvm_reg_field tx_txcc_lf_mult_7_0;
  rand uvm_reg_field tx_txcc_lf_mult_15_8;
  rand uvm_reg_field tx_txcc_lf_mult_31_16;
  
  covergroup wr_fld_covg;
    tx_txcc_lf_mult_7_0: coverpoint tx_txcc_lf_mult_7_0.value[7:0];
    tx_txcc_lf_mult_15_8: coverpoint tx_txcc_lf_mult_15_8.value[7:0];
    tx_txcc_lf_mult_31_16: coverpoint tx_txcc_lf_mult_31_16.value[15:0];
  endgroup
  covergroup rd_fld_covg;
    tx_txcc_lf_mult_7_0: coverpoint tx_txcc_lf_mult_7_0.value[7:0];
    tx_txcc_lf_mult_15_8: coverpoint tx_txcc_lf_mult_15_8.value[7:0];
    tx_txcc_lf_mult_31_16: coverpoint tx_txcc_lf_mult_31_16.value[15:0];
  endgroup

  protected virtual function void sample(uvm_reg_data_t data, uvm_reg_data_t byte_en, bit is_read, uvm_reg_map map);
    super.sample(data, byte_en, is_read, map);
    if (get_coverage(UVM_CVR_FIELD_VALS)) begin
      if(!is_read) begin
          wr_fld_covg.sample();
      end
      if(is_read) begin
         rd_fld_covg.sample();
      end
    end
  endfunction

  virtual function void sample_values();
    super.sample_values();
    if (get_coverage(UVM_CVR_FIELD_VALS)) begin
      wr_fld_covg.sample();
      rd_fld_covg.sample();
    end
  endfunction

  virtual function void build();
    uvm_reg_field fld_set[$];
    uvm_reg_field_config_ta ta = get_field_config(getconfigUID());
    build_uvm_reg_fields(this, ta, fld_set);
    
    tx_txcc_lf_mult_7_0 = fld_set[0];
    tx_txcc_lf_mult_15_8 = fld_set[1];
    tx_txcc_lf_mult_31_16 = fld_set[2];
  endfunction

  function new(input string name="T_tx_txcc_lf_mult_570");
    super.new(name, 32, build_coverage(UVM_CVR_FIELD_VALS));
    if (has_coverage(UVM_CVR_FIELD_VALS)) begin
      wr_fld_covg = new();
      rd_fld_covg = new();
    end
  endfunction

endclass


/////////////////////////////////////////////////////
//                tx_txcc_main_cval
/////////////////////////////////////////////////////
class T_tx_txcc_main_cval_568 extends cdns_uvm_reg;

  `uvm_object_utils(T_tx_txcc_main_cval_568)
  rand uvm_reg_field tx_txcc_main_cval_5_0;
  rand uvm_reg_field tx_txcc_main_cval_15_6;
  rand uvm_reg_field tx_txcc_main_cval_31_16;
  
  covergroup wr_fld_covg;
    tx_txcc_main_cval_5_0: coverpoint tx_txcc_main_cval_5_0.value[5:0];
    tx_txcc_main_cval_15_6: coverpoint tx_txcc_main_cval_15_6.value[9:0];
    tx_txcc_main_cval_31_16: coverpoint tx_txcc_main_cval_31_16.value[15:0];
  endgroup
  covergroup rd_fld_covg;
    tx_txcc_main_cval_5_0: coverpoint tx_txcc_main_cval_5_0.value[5:0];
    tx_txcc_main_cval_15_6: coverpoint tx_txcc_main_cval_15_6.value[9:0];
    tx_txcc_main_cval_31_16: coverpoint tx_txcc_main_cval_31_16.value[15:0];
  endgroup

  protected virtual function void sample(uvm_reg_data_t data, uvm_reg_data_t byte_en, bit is_read, uvm_reg_map map);
    super.sample(data, byte_en, is_read, map);
    if (get_coverage(UVM_CVR_FIELD_VALS)) begin
      if(!is_read) begin
          wr_fld_covg.sample();
      end
      if(is_read) begin
         rd_fld_covg.sample();
      end
    end
  endfunction

  virtual function void sample_values();
    super.sample_values();
    if (get_coverage(UVM_CVR_FIELD_VALS)) begin
      wr_fld_covg.sample();
      rd_fld_covg.sample();
    end
  endfunction

  virtual function void build();
    uvm_reg_field fld_set[$];
    uvm_reg_field_config_ta ta = get_field_config(getconfigUID());
    build_uvm_reg_fields(this, ta, fld_set);
    
    tx_txcc_main_cval_5_0 = fld_set[0];
    tx_txcc_main_cval_15_6 = fld_set[1];
    tx_txcc_main_cval_31_16 = fld_set[2];
  endfunction

  function new(input string name="T_tx_txcc_main_cval_568");
    super.new(name, 32, build_coverage(UVM_CVR_FIELD_VALS));
    if (has_coverage(UVM_CVR_FIELD_VALS)) begin
      wr_fld_covg = new();
      rd_fld_covg = new();
    end
  endfunction

endclass


/////////////////////////////////////////////////////
//                tx_txcc_main_ovrd
/////////////////////////////////////////////////////
class T_tx_txcc_main_ovrd_565 extends cdns_uvm_reg;

  `uvm_object_utils(T_tx_txcc_main_ovrd_565)
  rand uvm_reg_field tx_txcc_main_ovrd_5_0;
  rand uvm_reg_field tx_txcc_main_ovrd_7_6;
  rand uvm_reg_field tx_txcc_main_ovrd_8;
  rand uvm_reg_field tx_txcc_main_ovrd_15_9;
  rand uvm_reg_field tx_txcc_main_ovrd_31_16;
  
  covergroup wr_fld_covg;
    tx_txcc_main_ovrd_5_0: coverpoint tx_txcc_main_ovrd_5_0.value[5:0];
    tx_txcc_main_ovrd_7_6: coverpoint tx_txcc_main_ovrd_7_6.value[1:0];
    tx_txcc_main_ovrd_8: coverpoint tx_txcc_main_ovrd_8.value[0:0];
    tx_txcc_main_ovrd_15_9: coverpoint tx_txcc_main_ovrd_15_9.value[6:0];
    tx_txcc_main_ovrd_31_16: coverpoint tx_txcc_main_ovrd_31_16.value[15:0];
  endgroup
  covergroup rd_fld_covg;
    tx_txcc_main_ovrd_5_0: coverpoint tx_txcc_main_ovrd_5_0.value[5:0];
    tx_txcc_main_ovrd_7_6: coverpoint tx_txcc_main_ovrd_7_6.value[1:0];
    tx_txcc_main_ovrd_8: coverpoint tx_txcc_main_ovrd_8.value[0:0];
    tx_txcc_main_ovrd_15_9: coverpoint tx_txcc_main_ovrd_15_9.value[6:0];
    tx_txcc_main_ovrd_31_16: coverpoint tx_txcc_main_ovrd_31_16.value[15:0];
  endgroup

  protected virtual function void sample(uvm_reg_data_t data, uvm_reg_data_t byte_en, bit is_read, uvm_reg_map map);
    super.sample(data, byte_en, is_read, map);
    if (get_coverage(UVM_CVR_FIELD_VALS)) begin
      if(!is_read) begin
          wr_fld_covg.sample();
      end
      if(is_read) begin
         rd_fld_covg.sample();
      end
    end
  endfunction

  virtual function void sample_values();
    super.sample_values();
    if (get_coverage(UVM_CVR_FIELD_VALS)) begin
      wr_fld_covg.sample();
      rd_fld_covg.sample();
    end
  endfunction

  virtual function void build();
    uvm_reg_field fld_set[$];
    uvm_reg_field_config_ta ta = get_field_config(getconfigUID());
    build_uvm_reg_fields(this, ta, fld_set);
    
    tx_txcc_main_ovrd_5_0 = fld_set[0];
    tx_txcc_main_ovrd_7_6 = fld_set[1];
    tx_txcc_main_ovrd_8 = fld_set[2];
    tx_txcc_main_ovrd_15_9 = fld_set[3];
    tx_txcc_main_ovrd_31_16 = fld_set[4];
  endfunction

  function new(input string name="T_tx_txcc_main_ovrd_565");
    super.new(name, 32, build_coverage(UVM_CVR_FIELD_VALS));
    if (has_coverage(UVM_CVR_FIELD_VALS)) begin
      wr_fld_covg = new();
      rd_fld_covg = new();
    end
  endfunction

endclass


/////////////////////////////////////////////////////
//                tx_txcc_mgnfs_mult_000
/////////////////////////////////////////////////////
class T_tx_txcc_mgnfs_mult_000_579 extends cdns_uvm_reg;

  `uvm_object_utils(T_tx_txcc_mgnfs_mult_000_579)
  rand uvm_reg_field tx_txcc_mgnfs_mult_000_7_0;
  rand uvm_reg_field tx_txcc_mgnfs_mult_000_15_8;
  rand uvm_reg_field tx_txcc_mgnfs_mult_000_31_16;
  
  covergroup wr_fld_covg;
    tx_txcc_mgnfs_mult_000_7_0: coverpoint tx_txcc_mgnfs_mult_000_7_0.value[7:0];
    tx_txcc_mgnfs_mult_000_15_8: coverpoint tx_txcc_mgnfs_mult_000_15_8.value[7:0];
    tx_txcc_mgnfs_mult_000_31_16: coverpoint tx_txcc_mgnfs_mult_000_31_16.value[15:0];
  endgroup
  covergroup rd_fld_covg;
    tx_txcc_mgnfs_mult_000_7_0: coverpoint tx_txcc_mgnfs_mult_000_7_0.value[7:0];
    tx_txcc_mgnfs_mult_000_15_8: coverpoint tx_txcc_mgnfs_mult_000_15_8.value[7:0];
    tx_txcc_mgnfs_mult_000_31_16: coverpoint tx_txcc_mgnfs_mult_000_31_16.value[15:0];
  endgroup

  protected virtual function void sample(uvm_reg_data_t data, uvm_reg_data_t byte_en, bit is_read, uvm_reg_map map);
    super.sample(data, byte_en, is_read, map);
    if (get_coverage(UVM_CVR_FIELD_VALS)) begin
      if(!is_read) begin
          wr_fld_covg.sample();
      end
      if(is_read) begin
         rd_fld_covg.sample();
      end
    end
  endfunction

  virtual function void sample_values();
    super.sample_values();
    if (get_coverage(UVM_CVR_FIELD_VALS)) begin
      wr_fld_covg.sample();
      rd_fld_covg.sample();
    end
  endfunction

  virtual function void build();
    uvm_reg_field fld_set[$];
    uvm_reg_field_config_ta ta = get_field_config(getconfigUID());
    build_uvm_reg_fields(this, ta, fld_set);
    
    tx_txcc_mgnfs_mult_000_7_0 = fld_set[0];
    tx_txcc_mgnfs_mult_000_15_8 = fld_set[1];
    tx_txcc_mgnfs_mult_000_31_16 = fld_set[2];
  endfunction

  function new(input string name="T_tx_txcc_mgnfs_mult_000_579");
    super.new(name, 32, build_coverage(UVM_CVR_FIELD_VALS));
    if (has_coverage(UVM_CVR_FIELD_VALS)) begin
      wr_fld_covg = new();
      rd_fld_covg = new();
    end
  endfunction

endclass


/////////////////////////////////////////////////////
//                tx_txcc_mgnfs_mult_001
/////////////////////////////////////////////////////
class T_tx_txcc_mgnfs_mult_001_580 extends cdns_uvm_reg;

  `uvm_object_utils(T_tx_txcc_mgnfs_mult_001_580)
  rand uvm_reg_field tx_txcc_mgnfs_mult_001_7_0;
  rand uvm_reg_field tx_txcc_mgnfs_mult_001_15_8;
  rand uvm_reg_field tx_txcc_mgnfs_mult_001_31_16;
  
  covergroup wr_fld_covg;
    tx_txcc_mgnfs_mult_001_7_0: coverpoint tx_txcc_mgnfs_mult_001_7_0.value[7:0];
    tx_txcc_mgnfs_mult_001_15_8: coverpoint tx_txcc_mgnfs_mult_001_15_8.value[7:0];
    tx_txcc_mgnfs_mult_001_31_16: coverpoint tx_txcc_mgnfs_mult_001_31_16.value[15:0];
  endgroup
  covergroup rd_fld_covg;
    tx_txcc_mgnfs_mult_001_7_0: coverpoint tx_txcc_mgnfs_mult_001_7_0.value[7:0];
    tx_txcc_mgnfs_mult_001_15_8: coverpoint tx_txcc_mgnfs_mult_001_15_8.value[7:0];
    tx_txcc_mgnfs_mult_001_31_16: coverpoint tx_txcc_mgnfs_mult_001_31_16.value[15:0];
  endgroup

  protected virtual function void sample(uvm_reg_data_t data, uvm_reg_data_t byte_en, bit is_read, uvm_reg_map map);
    super.sample(data, byte_en, is_read, map);
    if (get_coverage(UVM_CVR_FIELD_VALS)) begin
      if(!is_read) begin
          wr_fld_covg.sample();
      end
      if(is_read) begin
         rd_fld_covg.sample();
      end
    end
  endfunction

  virtual function void sample_values();
    super.sample_values();
    if (get_coverage(UVM_CVR_FIELD_VALS)) begin
      wr_fld_covg.sample();
      rd_fld_covg.sample();
    end
  endfunction

  virtual function void build();
    uvm_reg_field fld_set[$];
    uvm_reg_field_config_ta ta = get_field_config(getconfigUID());
    build_uvm_reg_fields(this, ta, fld_set);
    
    tx_txcc_mgnfs_mult_001_7_0 = fld_set[0];
    tx_txcc_mgnfs_mult_001_15_8 = fld_set[1];
    tx_txcc_mgnfs_mult_001_31_16 = fld_set[2];
  endfunction

  function new(input string name="T_tx_txcc_mgnfs_mult_001_580");
    super.new(name, 32, build_coverage(UVM_CVR_FIELD_VALS));
    if (has_coverage(UVM_CVR_FIELD_VALS)) begin
      wr_fld_covg = new();
      rd_fld_covg = new();
    end
  endfunction

endclass


/////////////////////////////////////////////////////
//                tx_txcc_mgnfs_mult_010
/////////////////////////////////////////////////////
class T_tx_txcc_mgnfs_mult_010_581 extends cdns_uvm_reg;

  `uvm_object_utils(T_tx_txcc_mgnfs_mult_010_581)
  rand uvm_reg_field tx_txcc_mgnfs_mult_010_7_0;
  rand uvm_reg_field tx_txcc_mgnfs_mult_010_15_8;
  rand uvm_reg_field tx_txcc_mgnfs_mult_010_31_16;
  
  covergroup wr_fld_covg;
    tx_txcc_mgnfs_mult_010_7_0: coverpoint tx_txcc_mgnfs_mult_010_7_0.value[7:0];
    tx_txcc_mgnfs_mult_010_15_8: coverpoint tx_txcc_mgnfs_mult_010_15_8.value[7:0];
    tx_txcc_mgnfs_mult_010_31_16: coverpoint tx_txcc_mgnfs_mult_010_31_16.value[15:0];
  endgroup
  covergroup rd_fld_covg;
    tx_txcc_mgnfs_mult_010_7_0: coverpoint tx_txcc_mgnfs_mult_010_7_0.value[7:0];
    tx_txcc_mgnfs_mult_010_15_8: coverpoint tx_txcc_mgnfs_mult_010_15_8.value[7:0];
    tx_txcc_mgnfs_mult_010_31_16: coverpoint tx_txcc_mgnfs_mult_010_31_16.value[15:0];
  endgroup

  protected virtual function void sample(uvm_reg_data_t data, uvm_reg_data_t byte_en, bit is_read, uvm_reg_map map);
    super.sample(data, byte_en, is_read, map);
    if (get_coverage(UVM_CVR_FIELD_VALS)) begin
      if(!is_read) begin
          wr_fld_covg.sample();
      end
      if(is_read) begin
         rd_fld_covg.sample();
      end
    end
  endfunction

  virtual function void sample_values();
    super.sample_values();
    if (get_coverage(UVM_CVR_FIELD_VALS)) begin
      wr_fld_covg.sample();
      rd_fld_covg.sample();
    end
  endfunction

  virtual function void build();
    uvm_reg_field fld_set[$];
    uvm_reg_field_config_ta ta = get_field_config(getconfigUID());
    build_uvm_reg_fields(this, ta, fld_set);
    
    tx_txcc_mgnfs_mult_010_7_0 = fld_set[0];
    tx_txcc_mgnfs_mult_010_15_8 = fld_set[1];
    tx_txcc_mgnfs_mult_010_31_16 = fld_set[2];
  endfunction

  function new(input string name="T_tx_txcc_mgnfs_mult_010_581");
    super.new(name, 32, build_coverage(UVM_CVR_FIELD_VALS));
    if (has_coverage(UVM_CVR_FIELD_VALS)) begin
      wr_fld_covg = new();
      rd_fld_covg = new();
    end
  endfunction

endclass


/////////////////////////////////////////////////////
//                tx_txcc_mgnfs_mult_011
/////////////////////////////////////////////////////
class T_tx_txcc_mgnfs_mult_011_582 extends cdns_uvm_reg;

  `uvm_object_utils(T_tx_txcc_mgnfs_mult_011_582)
  rand uvm_reg_field tx_txcc_mgnfs_mult_011_7_0;
  rand uvm_reg_field tx_txcc_mgnfs_mult_011_15_8;
  rand uvm_reg_field tx_txcc_mgnfs_mult_011_31_16;
  
  covergroup wr_fld_covg;
    tx_txcc_mgnfs_mult_011_7_0: coverpoint tx_txcc_mgnfs_mult_011_7_0.value[7:0];
    tx_txcc_mgnfs_mult_011_15_8: coverpoint tx_txcc_mgnfs_mult_011_15_8.value[7:0];
    tx_txcc_mgnfs_mult_011_31_16: coverpoint tx_txcc_mgnfs_mult_011_31_16.value[15:0];
  endgroup
  covergroup rd_fld_covg;
    tx_txcc_mgnfs_mult_011_7_0: coverpoint tx_txcc_mgnfs_mult_011_7_0.value[7:0];
    tx_txcc_mgnfs_mult_011_15_8: coverpoint tx_txcc_mgnfs_mult_011_15_8.value[7:0];
    tx_txcc_mgnfs_mult_011_31_16: coverpoint tx_txcc_mgnfs_mult_011_31_16.value[15:0];
  endgroup

  protected virtual function void sample(uvm_reg_data_t data, uvm_reg_data_t byte_en, bit is_read, uvm_reg_map map);
    super.sample(data, byte_en, is_read, map);
    if (get_coverage(UVM_CVR_FIELD_VALS)) begin
      if(!is_read) begin
          wr_fld_covg.sample();
      end
      if(is_read) begin
         rd_fld_covg.sample();
      end
    end
  endfunction

  virtual function void sample_values();
    super.sample_values();
    if (get_coverage(UVM_CVR_FIELD_VALS)) begin
      wr_fld_covg.sample();
      rd_fld_covg.sample();
    end
  endfunction

  virtual function void build();
    uvm_reg_field fld_set[$];
    uvm_reg_field_config_ta ta = get_field_config(getconfigUID());
    build_uvm_reg_fields(this, ta, fld_set);
    
    tx_txcc_mgnfs_mult_011_7_0 = fld_set[0];
    tx_txcc_mgnfs_mult_011_15_8 = fld_set[1];
    tx_txcc_mgnfs_mult_011_31_16 = fld_set[2];
  endfunction

  function new(input string name="T_tx_txcc_mgnfs_mult_011_582");
    super.new(name, 32, build_coverage(UVM_CVR_FIELD_VALS));
    if (has_coverage(UVM_CVR_FIELD_VALS)) begin
      wr_fld_covg = new();
      rd_fld_covg = new();
    end
  endfunction

endclass


/////////////////////////////////////////////////////
//                tx_txcc_mgnfs_mult_100
/////////////////////////////////////////////////////
class T_tx_txcc_mgnfs_mult_100_583 extends cdns_uvm_reg;

  `uvm_object_utils(T_tx_txcc_mgnfs_mult_100_583)
  rand uvm_reg_field tx_txcc_mgnfs_mult_100_7_0;
  rand uvm_reg_field tx_txcc_mgnfs_mult_100_15_8;
  rand uvm_reg_field tx_txcc_mgnfs_mult_100_31_16;
  
  covergroup wr_fld_covg;
    tx_txcc_mgnfs_mult_100_7_0: coverpoint tx_txcc_mgnfs_mult_100_7_0.value[7:0];
    tx_txcc_mgnfs_mult_100_15_8: coverpoint tx_txcc_mgnfs_mult_100_15_8.value[7:0];
    tx_txcc_mgnfs_mult_100_31_16: coverpoint tx_txcc_mgnfs_mult_100_31_16.value[15:0];
  endgroup
  covergroup rd_fld_covg;
    tx_txcc_mgnfs_mult_100_7_0: coverpoint tx_txcc_mgnfs_mult_100_7_0.value[7:0];
    tx_txcc_mgnfs_mult_100_15_8: coverpoint tx_txcc_mgnfs_mult_100_15_8.value[7:0];
    tx_txcc_mgnfs_mult_100_31_16: coverpoint tx_txcc_mgnfs_mult_100_31_16.value[15:0];
  endgroup

  protected virtual function void sample(uvm_reg_data_t data, uvm_reg_data_t byte_en, bit is_read, uvm_reg_map map);
    super.sample(data, byte_en, is_read, map);
    if (get_coverage(UVM_CVR_FIELD_VALS)) begin
      if(!is_read) begin
          wr_fld_covg.sample();
      end
      if(is_read) begin
         rd_fld_covg.sample();
      end
    end
  endfunction

  virtual function void sample_values();
    super.sample_values();
    if (get_coverage(UVM_CVR_FIELD_VALS)) begin
      wr_fld_covg.sample();
      rd_fld_covg.sample();
    end
  endfunction

  virtual function void build();
    uvm_reg_field fld_set[$];
    uvm_reg_field_config_ta ta = get_field_config(getconfigUID());
    build_uvm_reg_fields(this, ta, fld_set);
    
    tx_txcc_mgnfs_mult_100_7_0 = fld_set[0];
    tx_txcc_mgnfs_mult_100_15_8 = fld_set[1];
    tx_txcc_mgnfs_mult_100_31_16 = fld_set[2];
  endfunction

  function new(input string name="T_tx_txcc_mgnfs_mult_100_583");
    super.new(name, 32, build_coverage(UVM_CVR_FIELD_VALS));
    if (has_coverage(UVM_CVR_FIELD_VALS)) begin
      wr_fld_covg = new();
      rd_fld_covg = new();
    end
  endfunction

endclass


/////////////////////////////////////////////////////
//                tx_txcc_mgnfs_mult_101
/////////////////////////////////////////////////////
class T_tx_txcc_mgnfs_mult_101_584 extends cdns_uvm_reg;

  `uvm_object_utils(T_tx_txcc_mgnfs_mult_101_584)
  rand uvm_reg_field tx_txcc_mgnfs_mult_101_7_0;
  rand uvm_reg_field tx_txcc_mgnfs_mult_101_15_8;
  rand uvm_reg_field tx_txcc_mgnfs_mult_101_31_16;
  
  covergroup wr_fld_covg;
    tx_txcc_mgnfs_mult_101_7_0: coverpoint tx_txcc_mgnfs_mult_101_7_0.value[7:0];
    tx_txcc_mgnfs_mult_101_15_8: coverpoint tx_txcc_mgnfs_mult_101_15_8.value[7:0];
    tx_txcc_mgnfs_mult_101_31_16: coverpoint tx_txcc_mgnfs_mult_101_31_16.value[15:0];
  endgroup
  covergroup rd_fld_covg;
    tx_txcc_mgnfs_mult_101_7_0: coverpoint tx_txcc_mgnfs_mult_101_7_0.value[7:0];
    tx_txcc_mgnfs_mult_101_15_8: coverpoint tx_txcc_mgnfs_mult_101_15_8.value[7:0];
    tx_txcc_mgnfs_mult_101_31_16: coverpoint tx_txcc_mgnfs_mult_101_31_16.value[15:0];
  endgroup

  protected virtual function void sample(uvm_reg_data_t data, uvm_reg_data_t byte_en, bit is_read, uvm_reg_map map);
    super.sample(data, byte_en, is_read, map);
    if (get_coverage(UVM_CVR_FIELD_VALS)) begin
      if(!is_read) begin
          wr_fld_covg.sample();
      end
      if(is_read) begin
         rd_fld_covg.sample();
      end
    end
  endfunction

  virtual function void sample_values();
    super.sample_values();
    if (get_coverage(UVM_CVR_FIELD_VALS)) begin
      wr_fld_covg.sample();
      rd_fld_covg.sample();
    end
  endfunction

  virtual function void build();
    uvm_reg_field fld_set[$];
    uvm_reg_field_config_ta ta = get_field_config(getconfigUID());
    build_uvm_reg_fields(this, ta, fld_set);
    
    tx_txcc_mgnfs_mult_101_7_0 = fld_set[0];
    tx_txcc_mgnfs_mult_101_15_8 = fld_set[1];
    tx_txcc_mgnfs_mult_101_31_16 = fld_set[2];
  endfunction

  function new(input string name="T_tx_txcc_mgnfs_mult_101_584");
    super.new(name, 32, build_coverage(UVM_CVR_FIELD_VALS));
    if (has_coverage(UVM_CVR_FIELD_VALS)) begin
      wr_fld_covg = new();
      rd_fld_covg = new();
    end
  endfunction

endclass


/////////////////////////////////////////////////////
//                tx_txcc_mgnfs_mult_110
/////////////////////////////////////////////////////
class T_tx_txcc_mgnfs_mult_110_585 extends cdns_uvm_reg;

  `uvm_object_utils(T_tx_txcc_mgnfs_mult_110_585)
  rand uvm_reg_field tx_txcc_mgnfs_mult_110_7_0;
  rand uvm_reg_field tx_txcc_mgnfs_mult_110_15_8;
  rand uvm_reg_field tx_txcc_mgnfs_mult_110_31_16;
  
  covergroup wr_fld_covg;
    tx_txcc_mgnfs_mult_110_7_0: coverpoint tx_txcc_mgnfs_mult_110_7_0.value[7:0];
    tx_txcc_mgnfs_mult_110_15_8: coverpoint tx_txcc_mgnfs_mult_110_15_8.value[7:0];
    tx_txcc_mgnfs_mult_110_31_16: coverpoint tx_txcc_mgnfs_mult_110_31_16.value[15:0];
  endgroup
  covergroup rd_fld_covg;
    tx_txcc_mgnfs_mult_110_7_0: coverpoint tx_txcc_mgnfs_mult_110_7_0.value[7:0];
    tx_txcc_mgnfs_mult_110_15_8: coverpoint tx_txcc_mgnfs_mult_110_15_8.value[7:0];
    tx_txcc_mgnfs_mult_110_31_16: coverpoint tx_txcc_mgnfs_mult_110_31_16.value[15:0];
  endgroup

  protected virtual function void sample(uvm_reg_data_t data, uvm_reg_data_t byte_en, bit is_read, uvm_reg_map map);
    super.sample(data, byte_en, is_read, map);
    if (get_coverage(UVM_CVR_FIELD_VALS)) begin
      if(!is_read) begin
          wr_fld_covg.sample();
      end
      if(is_read) begin
         rd_fld_covg.sample();
      end
    end
  endfunction

  virtual function void sample_values();
    super.sample_values();
    if (get_coverage(UVM_CVR_FIELD_VALS)) begin
      wr_fld_covg.sample();
      rd_fld_covg.sample();
    end
  endfunction

  virtual function void build();
    uvm_reg_field fld_set[$];
    uvm_reg_field_config_ta ta = get_field_config(getconfigUID());
    build_uvm_reg_fields(this, ta, fld_set);
    
    tx_txcc_mgnfs_mult_110_7_0 = fld_set[0];
    tx_txcc_mgnfs_mult_110_15_8 = fld_set[1];
    tx_txcc_mgnfs_mult_110_31_16 = fld_set[2];
  endfunction

  function new(input string name="T_tx_txcc_mgnfs_mult_110_585");
    super.new(name, 32, build_coverage(UVM_CVR_FIELD_VALS));
    if (has_coverage(UVM_CVR_FIELD_VALS)) begin
      wr_fld_covg = new();
      rd_fld_covg = new();
    end
  endfunction

endclass


/////////////////////////////////////////////////////
//                tx_txcc_mgnfs_mult_111
/////////////////////////////////////////////////////
class T_tx_txcc_mgnfs_mult_111_586 extends cdns_uvm_reg;

  `uvm_object_utils(T_tx_txcc_mgnfs_mult_111_586)
  rand uvm_reg_field tx_txcc_mgnfs_mult_111_7_0;
  rand uvm_reg_field tx_txcc_mgnfs_mult_111_15_8;
  rand uvm_reg_field tx_txcc_mgnfs_mult_111_31_16;
  
  covergroup wr_fld_covg;
    tx_txcc_mgnfs_mult_111_7_0: coverpoint tx_txcc_mgnfs_mult_111_7_0.value[7:0];
    tx_txcc_mgnfs_mult_111_15_8: coverpoint tx_txcc_mgnfs_mult_111_15_8.value[7:0];
    tx_txcc_mgnfs_mult_111_31_16: coverpoint tx_txcc_mgnfs_mult_111_31_16.value[15:0];
  endgroup
  covergroup rd_fld_covg;
    tx_txcc_mgnfs_mult_111_7_0: coverpoint tx_txcc_mgnfs_mult_111_7_0.value[7:0];
    tx_txcc_mgnfs_mult_111_15_8: coverpoint tx_txcc_mgnfs_mult_111_15_8.value[7:0];
    tx_txcc_mgnfs_mult_111_31_16: coverpoint tx_txcc_mgnfs_mult_111_31_16.value[15:0];
  endgroup

  protected virtual function void sample(uvm_reg_data_t data, uvm_reg_data_t byte_en, bit is_read, uvm_reg_map map);
    super.sample(data, byte_en, is_read, map);
    if (get_coverage(UVM_CVR_FIELD_VALS)) begin
      if(!is_read) begin
          wr_fld_covg.sample();
      end
      if(is_read) begin
         rd_fld_covg.sample();
      end
    end
  endfunction

  virtual function void sample_values();
    super.sample_values();
    if (get_coverage(UVM_CVR_FIELD_VALS)) begin
      wr_fld_covg.sample();
      rd_fld_covg.sample();
    end
  endfunction

  virtual function void build();
    uvm_reg_field fld_set[$];
    uvm_reg_field_config_ta ta = get_field_config(getconfigUID());
    build_uvm_reg_fields(this, ta, fld_set);
    
    tx_txcc_mgnfs_mult_111_7_0 = fld_set[0];
    tx_txcc_mgnfs_mult_111_15_8 = fld_set[1];
    tx_txcc_mgnfs_mult_111_31_16 = fld_set[2];
  endfunction

  function new(input string name="T_tx_txcc_mgnfs_mult_111_586");
    super.new(name, 32, build_coverage(UVM_CVR_FIELD_VALS));
    if (has_coverage(UVM_CVR_FIELD_VALS)) begin
      wr_fld_covg = new();
      rd_fld_covg = new();
    end
  endfunction

endclass


/////////////////////////////////////////////////////
//                tx_txcc_mgnhs_mult_000
/////////////////////////////////////////////////////
class T_tx_txcc_mgnhs_mult_000_587 extends cdns_uvm_reg;

  `uvm_object_utils(T_tx_txcc_mgnhs_mult_000_587)
  rand uvm_reg_field tx_txcc_mgnhs_mult_000_7_0;
  rand uvm_reg_field tx_txcc_mgnhs_mult_000_15_8;
  rand uvm_reg_field tx_txcc_mgnhs_mult_000_31_16;
  
  covergroup wr_fld_covg;
    tx_txcc_mgnhs_mult_000_7_0: coverpoint tx_txcc_mgnhs_mult_000_7_0.value[7:0];
    tx_txcc_mgnhs_mult_000_15_8: coverpoint tx_txcc_mgnhs_mult_000_15_8.value[7:0];
    tx_txcc_mgnhs_mult_000_31_16: coverpoint tx_txcc_mgnhs_mult_000_31_16.value[15:0];
  endgroup
  covergroup rd_fld_covg;
    tx_txcc_mgnhs_mult_000_7_0: coverpoint tx_txcc_mgnhs_mult_000_7_0.value[7:0];
    tx_txcc_mgnhs_mult_000_15_8: coverpoint tx_txcc_mgnhs_mult_000_15_8.value[7:0];
    tx_txcc_mgnhs_mult_000_31_16: coverpoint tx_txcc_mgnhs_mult_000_31_16.value[15:0];
  endgroup

  protected virtual function void sample(uvm_reg_data_t data, uvm_reg_data_t byte_en, bit is_read, uvm_reg_map map);
    super.sample(data, byte_en, is_read, map);
    if (get_coverage(UVM_CVR_FIELD_VALS)) begin
      if(!is_read) begin
          wr_fld_covg.sample();
      end
      if(is_read) begin
         rd_fld_covg.sample();
      end
    end
  endfunction

  virtual function void sample_values();
    super.sample_values();
    if (get_coverage(UVM_CVR_FIELD_VALS)) begin
      wr_fld_covg.sample();
      rd_fld_covg.sample();
    end
  endfunction

  virtual function void build();
    uvm_reg_field fld_set[$];
    uvm_reg_field_config_ta ta = get_field_config(getconfigUID());
    build_uvm_reg_fields(this, ta, fld_set);
    
    tx_txcc_mgnhs_mult_000_7_0 = fld_set[0];
    tx_txcc_mgnhs_mult_000_15_8 = fld_set[1];
    tx_txcc_mgnhs_mult_000_31_16 = fld_set[2];
  endfunction

  function new(input string name="T_tx_txcc_mgnhs_mult_000_587");
    super.new(name, 32, build_coverage(UVM_CVR_FIELD_VALS));
    if (has_coverage(UVM_CVR_FIELD_VALS)) begin
      wr_fld_covg = new();
      rd_fld_covg = new();
    end
  endfunction

endclass


/////////////////////////////////////////////////////
//                tx_txcc_mgnhs_mult_001
/////////////////////////////////////////////////////
class T_tx_txcc_mgnhs_mult_001_588 extends cdns_uvm_reg;

  `uvm_object_utils(T_tx_txcc_mgnhs_mult_001_588)
  rand uvm_reg_field tx_txcc_mgnhs_mult_001_7_0;
  rand uvm_reg_field tx_txcc_mgnhs_mult_001_15_8;
  rand uvm_reg_field tx_txcc_mgnhs_mult_001_31_16;
  
  covergroup wr_fld_covg;
    tx_txcc_mgnhs_mult_001_7_0: coverpoint tx_txcc_mgnhs_mult_001_7_0.value[7:0];
    tx_txcc_mgnhs_mult_001_15_8: coverpoint tx_txcc_mgnhs_mult_001_15_8.value[7:0];
    tx_txcc_mgnhs_mult_001_31_16: coverpoint tx_txcc_mgnhs_mult_001_31_16.value[15:0];
  endgroup
  covergroup rd_fld_covg;
    tx_txcc_mgnhs_mult_001_7_0: coverpoint tx_txcc_mgnhs_mult_001_7_0.value[7:0];
    tx_txcc_mgnhs_mult_001_15_8: coverpoint tx_txcc_mgnhs_mult_001_15_8.value[7:0];
    tx_txcc_mgnhs_mult_001_31_16: coverpoint tx_txcc_mgnhs_mult_001_31_16.value[15:0];
  endgroup

  protected virtual function void sample(uvm_reg_data_t data, uvm_reg_data_t byte_en, bit is_read, uvm_reg_map map);
    super.sample(data, byte_en, is_read, map);
    if (get_coverage(UVM_CVR_FIELD_VALS)) begin
      if(!is_read) begin
          wr_fld_covg.sample();
      end
      if(is_read) begin
         rd_fld_covg.sample();
      end
    end
  endfunction

  virtual function void sample_values();
    super.sample_values();
    if (get_coverage(UVM_CVR_FIELD_VALS)) begin
      wr_fld_covg.sample();
      rd_fld_covg.sample();
    end
  endfunction

  virtual function void build();
    uvm_reg_field fld_set[$];
    uvm_reg_field_config_ta ta = get_field_config(getconfigUID());
    build_uvm_reg_fields(this, ta, fld_set);
    
    tx_txcc_mgnhs_mult_001_7_0 = fld_set[0];
    tx_txcc_mgnhs_mult_001_15_8 = fld_set[1];
    tx_txcc_mgnhs_mult_001_31_16 = fld_set[2];
  endfunction

  function new(input string name="T_tx_txcc_mgnhs_mult_001_588");
    super.new(name, 32, build_coverage(UVM_CVR_FIELD_VALS));
    if (has_coverage(UVM_CVR_FIELD_VALS)) begin
      wr_fld_covg = new();
      rd_fld_covg = new();
    end
  endfunction

endclass


/////////////////////////////////////////////////////
//                tx_txcc_mgnhs_mult_010
/////////////////////////////////////////////////////
class T_tx_txcc_mgnhs_mult_010_589 extends cdns_uvm_reg;

  `uvm_object_utils(T_tx_txcc_mgnhs_mult_010_589)
  rand uvm_reg_field tx_txcc_mgnhs_mult_010_7_0;
  rand uvm_reg_field tx_txcc_mgnhs_mult_010_15_8;
  rand uvm_reg_field tx_txcc_mgnhs_mult_010_31_16;
  
  covergroup wr_fld_covg;
    tx_txcc_mgnhs_mult_010_7_0: coverpoint tx_txcc_mgnhs_mult_010_7_0.value[7:0];
    tx_txcc_mgnhs_mult_010_15_8: coverpoint tx_txcc_mgnhs_mult_010_15_8.value[7:0];
    tx_txcc_mgnhs_mult_010_31_16: coverpoint tx_txcc_mgnhs_mult_010_31_16.value[15:0];
  endgroup
  covergroup rd_fld_covg;
    tx_txcc_mgnhs_mult_010_7_0: coverpoint tx_txcc_mgnhs_mult_010_7_0.value[7:0];
    tx_txcc_mgnhs_mult_010_15_8: coverpoint tx_txcc_mgnhs_mult_010_15_8.value[7:0];
    tx_txcc_mgnhs_mult_010_31_16: coverpoint tx_txcc_mgnhs_mult_010_31_16.value[15:0];
  endgroup

  protected virtual function void sample(uvm_reg_data_t data, uvm_reg_data_t byte_en, bit is_read, uvm_reg_map map);
    super.sample(data, byte_en, is_read, map);
    if (get_coverage(UVM_CVR_FIELD_VALS)) begin
      if(!is_read) begin
          wr_fld_covg.sample();
      end
      if(is_read) begin
         rd_fld_covg.sample();
      end
    end
  endfunction

  virtual function void sample_values();
    super.sample_values();
    if (get_coverage(UVM_CVR_FIELD_VALS)) begin
      wr_fld_covg.sample();
      rd_fld_covg.sample();
    end
  endfunction

  virtual function void build();
    uvm_reg_field fld_set[$];
    uvm_reg_field_config_ta ta = get_field_config(getconfigUID());
    build_uvm_reg_fields(this, ta, fld_set);
    
    tx_txcc_mgnhs_mult_010_7_0 = fld_set[0];
    tx_txcc_mgnhs_mult_010_15_8 = fld_set[1];
    tx_txcc_mgnhs_mult_010_31_16 = fld_set[2];
  endfunction

  function new(input string name="T_tx_txcc_mgnhs_mult_010_589");
    super.new(name, 32, build_coverage(UVM_CVR_FIELD_VALS));
    if (has_coverage(UVM_CVR_FIELD_VALS)) begin
      wr_fld_covg = new();
      rd_fld_covg = new();
    end
  endfunction

endclass


/////////////////////////////////////////////////////
//                tx_txcc_mgnhs_mult_011
/////////////////////////////////////////////////////
class T_tx_txcc_mgnhs_mult_011_590 extends cdns_uvm_reg;

  `uvm_object_utils(T_tx_txcc_mgnhs_mult_011_590)
  rand uvm_reg_field tx_txcc_mgnhs_mult_011_7_0;
  rand uvm_reg_field tx_txcc_mgnhs_mult_011_15_8;
  rand uvm_reg_field tx_txcc_mgnhs_mult_011_31_16;
  
  covergroup wr_fld_covg;
    tx_txcc_mgnhs_mult_011_7_0: coverpoint tx_txcc_mgnhs_mult_011_7_0.value[7:0];
    tx_txcc_mgnhs_mult_011_15_8: coverpoint tx_txcc_mgnhs_mult_011_15_8.value[7:0];
    tx_txcc_mgnhs_mult_011_31_16: coverpoint tx_txcc_mgnhs_mult_011_31_16.value[15:0];
  endgroup
  covergroup rd_fld_covg;
    tx_txcc_mgnhs_mult_011_7_0: coverpoint tx_txcc_mgnhs_mult_011_7_0.value[7:0];
    tx_txcc_mgnhs_mult_011_15_8: coverpoint tx_txcc_mgnhs_mult_011_15_8.value[7:0];
    tx_txcc_mgnhs_mult_011_31_16: coverpoint tx_txcc_mgnhs_mult_011_31_16.value[15:0];
  endgroup

  protected virtual function void sample(uvm_reg_data_t data, uvm_reg_data_t byte_en, bit is_read, uvm_reg_map map);
    super.sample(data, byte_en, is_read, map);
    if (get_coverage(UVM_CVR_FIELD_VALS)) begin
      if(!is_read) begin
          wr_fld_covg.sample();
      end
      if(is_read) begin
         rd_fld_covg.sample();
      end
    end
  endfunction

  virtual function void sample_values();
    super.sample_values();
    if (get_coverage(UVM_CVR_FIELD_VALS)) begin
      wr_fld_covg.sample();
      rd_fld_covg.sample();
    end
  endfunction

  virtual function void build();
    uvm_reg_field fld_set[$];
    uvm_reg_field_config_ta ta = get_field_config(getconfigUID());
    build_uvm_reg_fields(this, ta, fld_set);
    
    tx_txcc_mgnhs_mult_011_7_0 = fld_set[0];
    tx_txcc_mgnhs_mult_011_15_8 = fld_set[1];
    tx_txcc_mgnhs_mult_011_31_16 = fld_set[2];
  endfunction

  function new(input string name="T_tx_txcc_mgnhs_mult_011_590");
    super.new(name, 32, build_coverage(UVM_CVR_FIELD_VALS));
    if (has_coverage(UVM_CVR_FIELD_VALS)) begin
      wr_fld_covg = new();
      rd_fld_covg = new();
    end
  endfunction

endclass


/////////////////////////////////////////////////////
//                tx_txcc_mgnhs_mult_100
/////////////////////////////////////////////////////
class T_tx_txcc_mgnhs_mult_100_591 extends cdns_uvm_reg;

  `uvm_object_utils(T_tx_txcc_mgnhs_mult_100_591)
  rand uvm_reg_field tx_txcc_mgnhs_mult_100_7_0;
  rand uvm_reg_field tx_txcc_mgnhs_mult_100_15_8;
  rand uvm_reg_field tx_txcc_mgnhs_mult_100_31_16;
  
  covergroup wr_fld_covg;
    tx_txcc_mgnhs_mult_100_7_0: coverpoint tx_txcc_mgnhs_mult_100_7_0.value[7:0];
    tx_txcc_mgnhs_mult_100_15_8: coverpoint tx_txcc_mgnhs_mult_100_15_8.value[7:0];
    tx_txcc_mgnhs_mult_100_31_16: coverpoint tx_txcc_mgnhs_mult_100_31_16.value[15:0];
  endgroup
  covergroup rd_fld_covg;
    tx_txcc_mgnhs_mult_100_7_0: coverpoint tx_txcc_mgnhs_mult_100_7_0.value[7:0];
    tx_txcc_mgnhs_mult_100_15_8: coverpoint tx_txcc_mgnhs_mult_100_15_8.value[7:0];
    tx_txcc_mgnhs_mult_100_31_16: coverpoint tx_txcc_mgnhs_mult_100_31_16.value[15:0];
  endgroup

  protected virtual function void sample(uvm_reg_data_t data, uvm_reg_data_t byte_en, bit is_read, uvm_reg_map map);
    super.sample(data, byte_en, is_read, map);
    if (get_coverage(UVM_CVR_FIELD_VALS)) begin
      if(!is_read) begin
          wr_fld_covg.sample();
      end
      if(is_read) begin
         rd_fld_covg.sample();
      end
    end
  endfunction

  virtual function void sample_values();
    super.sample_values();
    if (get_coverage(UVM_CVR_FIELD_VALS)) begin
      wr_fld_covg.sample();
      rd_fld_covg.sample();
    end
  endfunction

  virtual function void build();
    uvm_reg_field fld_set[$];
    uvm_reg_field_config_ta ta = get_field_config(getconfigUID());
    build_uvm_reg_fields(this, ta, fld_set);
    
    tx_txcc_mgnhs_mult_100_7_0 = fld_set[0];
    tx_txcc_mgnhs_mult_100_15_8 = fld_set[1];
    tx_txcc_mgnhs_mult_100_31_16 = fld_set[2];
  endfunction

  function new(input string name="T_tx_txcc_mgnhs_mult_100_591");
    super.new(name, 32, build_coverage(UVM_CVR_FIELD_VALS));
    if (has_coverage(UVM_CVR_FIELD_VALS)) begin
      wr_fld_covg = new();
      rd_fld_covg = new();
    end
  endfunction

endclass


/////////////////////////////////////////////////////
//                tx_txcc_mgnhs_mult_101
/////////////////////////////////////////////////////
class T_tx_txcc_mgnhs_mult_101_592 extends cdns_uvm_reg;

  `uvm_object_utils(T_tx_txcc_mgnhs_mult_101_592)
  rand uvm_reg_field tx_txcc_mgnhs_mult_101_7_0;
  rand uvm_reg_field tx_txcc_mgnhs_mult_101_15_8;
  rand uvm_reg_field tx_txcc_mgnhs_mult_101_31_16;
  
  covergroup wr_fld_covg;
    tx_txcc_mgnhs_mult_101_7_0: coverpoint tx_txcc_mgnhs_mult_101_7_0.value[7:0];
    tx_txcc_mgnhs_mult_101_15_8: coverpoint tx_txcc_mgnhs_mult_101_15_8.value[7:0];
    tx_txcc_mgnhs_mult_101_31_16: coverpoint tx_txcc_mgnhs_mult_101_31_16.value[15:0];
  endgroup
  covergroup rd_fld_covg;
    tx_txcc_mgnhs_mult_101_7_0: coverpoint tx_txcc_mgnhs_mult_101_7_0.value[7:0];
    tx_txcc_mgnhs_mult_101_15_8: coverpoint tx_txcc_mgnhs_mult_101_15_8.value[7:0];
    tx_txcc_mgnhs_mult_101_31_16: coverpoint tx_txcc_mgnhs_mult_101_31_16.value[15:0];
  endgroup

  protected virtual function void sample(uvm_reg_data_t data, uvm_reg_data_t byte_en, bit is_read, uvm_reg_map map);
    super.sample(data, byte_en, is_read, map);
    if (get_coverage(UVM_CVR_FIELD_VALS)) begin
      if(!is_read) begin
          wr_fld_covg.sample();
      end
      if(is_read) begin
         rd_fld_covg.sample();
      end
    end
  endfunction

  virtual function void sample_values();
    super.sample_values();
    if (get_coverage(UVM_CVR_FIELD_VALS)) begin
      wr_fld_covg.sample();
      rd_fld_covg.sample();
    end
  endfunction

  virtual function void build();
    uvm_reg_field fld_set[$];
    uvm_reg_field_config_ta ta = get_field_config(getconfigUID());
    build_uvm_reg_fields(this, ta, fld_set);
    
    tx_txcc_mgnhs_mult_101_7_0 = fld_set[0];
    tx_txcc_mgnhs_mult_101_15_8 = fld_set[1];
    tx_txcc_mgnhs_mult_101_31_16 = fld_set[2];
  endfunction

  function new(input string name="T_tx_txcc_mgnhs_mult_101_592");
    super.new(name, 32, build_coverage(UVM_CVR_FIELD_VALS));
    if (has_coverage(UVM_CVR_FIELD_VALS)) begin
      wr_fld_covg = new();
      rd_fld_covg = new();
    end
  endfunction

endclass


/////////////////////////////////////////////////////
//                tx_txcc_mgnhs_mult_110
/////////////////////////////////////////////////////
class T_tx_txcc_mgnhs_mult_110_593 extends cdns_uvm_reg;

  `uvm_object_utils(T_tx_txcc_mgnhs_mult_110_593)
  rand uvm_reg_field tx_txcc_mgnhs_mult_110_7_0;
  rand uvm_reg_field tx_txcc_mgnhs_mult_110_15_8;
  rand uvm_reg_field tx_txcc_mgnhs_mult_110_31_16;
  
  covergroup wr_fld_covg;
    tx_txcc_mgnhs_mult_110_7_0: coverpoint tx_txcc_mgnhs_mult_110_7_0.value[7:0];
    tx_txcc_mgnhs_mult_110_15_8: coverpoint tx_txcc_mgnhs_mult_110_15_8.value[7:0];
    tx_txcc_mgnhs_mult_110_31_16: coverpoint tx_txcc_mgnhs_mult_110_31_16.value[15:0];
  endgroup
  covergroup rd_fld_covg;
    tx_txcc_mgnhs_mult_110_7_0: coverpoint tx_txcc_mgnhs_mult_110_7_0.value[7:0];
    tx_txcc_mgnhs_mult_110_15_8: coverpoint tx_txcc_mgnhs_mult_110_15_8.value[7:0];
    tx_txcc_mgnhs_mult_110_31_16: coverpoint tx_txcc_mgnhs_mult_110_31_16.value[15:0];
  endgroup

  protected virtual function void sample(uvm_reg_data_t data, uvm_reg_data_t byte_en, bit is_read, uvm_reg_map map);
    super.sample(data, byte_en, is_read, map);
    if (get_coverage(UVM_CVR_FIELD_VALS)) begin
      if(!is_read) begin
          wr_fld_covg.sample();
      end
      if(is_read) begin
         rd_fld_covg.sample();
      end
    end
  endfunction

  virtual function void sample_values();
    super.sample_values();
    if (get_coverage(UVM_CVR_FIELD_VALS)) begin
      wr_fld_covg.sample();
      rd_fld_covg.sample();
    end
  endfunction

  virtual function void build();
    uvm_reg_field fld_set[$];
    uvm_reg_field_config_ta ta = get_field_config(getconfigUID());
    build_uvm_reg_fields(this, ta, fld_set);
    
    tx_txcc_mgnhs_mult_110_7_0 = fld_set[0];
    tx_txcc_mgnhs_mult_110_15_8 = fld_set[1];
    tx_txcc_mgnhs_mult_110_31_16 = fld_set[2];
  endfunction

  function new(input string name="T_tx_txcc_mgnhs_mult_110_593");
    super.new(name, 32, build_coverage(UVM_CVR_FIELD_VALS));
    if (has_coverage(UVM_CVR_FIELD_VALS)) begin
      wr_fld_covg = new();
      rd_fld_covg = new();
    end
  endfunction

endclass


/////////////////////////////////////////////////////
//                tx_txcc_mgnhs_mult_111
/////////////////////////////////////////////////////
class T_tx_txcc_mgnhs_mult_111_594 extends cdns_uvm_reg;

  `uvm_object_utils(T_tx_txcc_mgnhs_mult_111_594)
  rand uvm_reg_field tx_txcc_mgnhs_mult_111_7_0;
  rand uvm_reg_field tx_txcc_mgnhs_mult_111_15_8;
  rand uvm_reg_field tx_txcc_mgnhs_mult_111_31_16;
  
  covergroup wr_fld_covg;
    tx_txcc_mgnhs_mult_111_7_0: coverpoint tx_txcc_mgnhs_mult_111_7_0.value[7:0];
    tx_txcc_mgnhs_mult_111_15_8: coverpoint tx_txcc_mgnhs_mult_111_15_8.value[7:0];
    tx_txcc_mgnhs_mult_111_31_16: coverpoint tx_txcc_mgnhs_mult_111_31_16.value[15:0];
  endgroup
  covergroup rd_fld_covg;
    tx_txcc_mgnhs_mult_111_7_0: coverpoint tx_txcc_mgnhs_mult_111_7_0.value[7:0];
    tx_txcc_mgnhs_mult_111_15_8: coverpoint tx_txcc_mgnhs_mult_111_15_8.value[7:0];
    tx_txcc_mgnhs_mult_111_31_16: coverpoint tx_txcc_mgnhs_mult_111_31_16.value[15:0];
  endgroup

  protected virtual function void sample(uvm_reg_data_t data, uvm_reg_data_t byte_en, bit is_read, uvm_reg_map map);
    super.sample(data, byte_en, is_read, map);
    if (get_coverage(UVM_CVR_FIELD_VALS)) begin
      if(!is_read) begin
          wr_fld_covg.sample();
      end
      if(is_read) begin
         rd_fld_covg.sample();
      end
    end
  endfunction

  virtual function void sample_values();
    super.sample_values();
    if (get_coverage(UVM_CVR_FIELD_VALS)) begin
      wr_fld_covg.sample();
      rd_fld_covg.sample();
    end
  endfunction

  virtual function void build();
    uvm_reg_field fld_set[$];
    uvm_reg_field_config_ta ta = get_field_config(getconfigUID());
    build_uvm_reg_fields(this, ta, fld_set);
    
    tx_txcc_mgnhs_mult_111_7_0 = fld_set[0];
    tx_txcc_mgnhs_mult_111_15_8 = fld_set[1];
    tx_txcc_mgnhs_mult_111_31_16 = fld_set[2];
  endfunction

  function new(input string name="T_tx_txcc_mgnhs_mult_111_594");
    super.new(name, 32, build_coverage(UVM_CVR_FIELD_VALS));
    if (has_coverage(UVM_CVR_FIELD_VALS)) begin
      wr_fld_covg = new();
      rd_fld_covg = new();
    end
  endfunction

endclass


/////////////////////////////////////////////////////
//                tx_txcc_p0post_coef_mult
/////////////////////////////////////////////////////
class T_tx_txcc_p0post_coef_mult_606 extends cdns_uvm_reg;

  `uvm_object_utils(T_tx_txcc_p0post_coef_mult_606)
  rand uvm_reg_field tx_txcc_p0post_coef_mult_7_0;
  rand uvm_reg_field tx_txcc_p0post_coef_mult_15_8;
  rand uvm_reg_field tx_txcc_p0post_coef_mult_31_16;
  
  covergroup wr_fld_covg;
    tx_txcc_p0post_coef_mult_7_0: coverpoint tx_txcc_p0post_coef_mult_7_0.value[7:0];
    tx_txcc_p0post_coef_mult_15_8: coverpoint tx_txcc_p0post_coef_mult_15_8.value[7:0];
    tx_txcc_p0post_coef_mult_31_16: coverpoint tx_txcc_p0post_coef_mult_31_16.value[15:0];
  endgroup
  covergroup rd_fld_covg;
    tx_txcc_p0post_coef_mult_7_0: coverpoint tx_txcc_p0post_coef_mult_7_0.value[7:0];
    tx_txcc_p0post_coef_mult_15_8: coverpoint tx_txcc_p0post_coef_mult_15_8.value[7:0];
    tx_txcc_p0post_coef_mult_31_16: coverpoint tx_txcc_p0post_coef_mult_31_16.value[15:0];
  endgroup

  protected virtual function void sample(uvm_reg_data_t data, uvm_reg_data_t byte_en, bit is_read, uvm_reg_map map);
    super.sample(data, byte_en, is_read, map);
    if (get_coverage(UVM_CVR_FIELD_VALS)) begin
      if(!is_read) begin
          wr_fld_covg.sample();
      end
      if(is_read) begin
         rd_fld_covg.sample();
      end
    end
  endfunction

  virtual function void sample_values();
    super.sample_values();
    if (get_coverage(UVM_CVR_FIELD_VALS)) begin
      wr_fld_covg.sample();
      rd_fld_covg.sample();
    end
  endfunction

  virtual function void build();
    uvm_reg_field fld_set[$];
    uvm_reg_field_config_ta ta = get_field_config(getconfigUID());
    build_uvm_reg_fields(this, ta, fld_set);
    
    tx_txcc_p0post_coef_mult_7_0 = fld_set[0];
    tx_txcc_p0post_coef_mult_15_8 = fld_set[1];
    tx_txcc_p0post_coef_mult_31_16 = fld_set[2];
  endfunction

  function new(input string name="T_tx_txcc_p0post_coef_mult_606");
    super.new(name, 32, build_coverage(UVM_CVR_FIELD_VALS));
    if (has_coverage(UVM_CVR_FIELD_VALS)) begin
      wr_fld_covg = new();
      rd_fld_covg = new();
    end
  endfunction

endclass


/////////////////////////////////////////////////////
//                tx_txcc_p0pre_coef_mult
/////////////////////////////////////////////////////
class T_tx_txcc_p0pre_coef_mult_595 extends cdns_uvm_reg;

  `uvm_object_utils(T_tx_txcc_p0pre_coef_mult_595)
  rand uvm_reg_field tx_txcc_p0pre_coef_mult_7_0;
  rand uvm_reg_field tx_txcc_p0pre_coef_mult_15_8;
  rand uvm_reg_field tx_txcc_p0pre_coef_mult_31_16;
  
  covergroup wr_fld_covg;
    tx_txcc_p0pre_coef_mult_7_0: coverpoint tx_txcc_p0pre_coef_mult_7_0.value[7:0];
    tx_txcc_p0pre_coef_mult_15_8: coverpoint tx_txcc_p0pre_coef_mult_15_8.value[7:0];
    tx_txcc_p0pre_coef_mult_31_16: coverpoint tx_txcc_p0pre_coef_mult_31_16.value[15:0];
  endgroup
  covergroup rd_fld_covg;
    tx_txcc_p0pre_coef_mult_7_0: coverpoint tx_txcc_p0pre_coef_mult_7_0.value[7:0];
    tx_txcc_p0pre_coef_mult_15_8: coverpoint tx_txcc_p0pre_coef_mult_15_8.value[7:0];
    tx_txcc_p0pre_coef_mult_31_16: coverpoint tx_txcc_p0pre_coef_mult_31_16.value[15:0];
  endgroup

  protected virtual function void sample(uvm_reg_data_t data, uvm_reg_data_t byte_en, bit is_read, uvm_reg_map map);
    super.sample(data, byte_en, is_read, map);
    if (get_coverage(UVM_CVR_FIELD_VALS)) begin
      if(!is_read) begin
          wr_fld_covg.sample();
      end
      if(is_read) begin
         rd_fld_covg.sample();
      end
    end
  endfunction

  virtual function void sample_values();
    super.sample_values();
    if (get_coverage(UVM_CVR_FIELD_VALS)) begin
      wr_fld_covg.sample();
      rd_fld_covg.sample();
    end
  endfunction

  virtual function void build();
    uvm_reg_field fld_set[$];
    uvm_reg_field_config_ta ta = get_field_config(getconfigUID());
    build_uvm_reg_fields(this, ta, fld_set);
    
    tx_txcc_p0pre_coef_mult_7_0 = fld_set[0];
    tx_txcc_p0pre_coef_mult_15_8 = fld_set[1];
    tx_txcc_p0pre_coef_mult_31_16 = fld_set[2];
  endfunction

  function new(input string name="T_tx_txcc_p0pre_coef_mult_595");
    super.new(name, 32, build_coverage(UVM_CVR_FIELD_VALS));
    if (has_coverage(UVM_CVR_FIELD_VALS)) begin
      wr_fld_covg = new();
      rd_fld_covg = new();
    end
  endfunction

endclass


/////////////////////////////////////////////////////
//                tx_txcc_p1post_coef_mult
/////////////////////////////////////////////////////
class T_tx_txcc_p1post_coef_mult_607 extends cdns_uvm_reg;

  `uvm_object_utils(T_tx_txcc_p1post_coef_mult_607)
  rand uvm_reg_field tx_txcc_p1post_coef_mult_7_0;
  rand uvm_reg_field tx_txcc_p1post_coef_mult_15_8;
  rand uvm_reg_field tx_txcc_p1post_coef_mult_31_16;
  
  covergroup wr_fld_covg;
    tx_txcc_p1post_coef_mult_7_0: coverpoint tx_txcc_p1post_coef_mult_7_0.value[7:0];
    tx_txcc_p1post_coef_mult_15_8: coverpoint tx_txcc_p1post_coef_mult_15_8.value[7:0];
    tx_txcc_p1post_coef_mult_31_16: coverpoint tx_txcc_p1post_coef_mult_31_16.value[15:0];
  endgroup
  covergroup rd_fld_covg;
    tx_txcc_p1post_coef_mult_7_0: coverpoint tx_txcc_p1post_coef_mult_7_0.value[7:0];
    tx_txcc_p1post_coef_mult_15_8: coverpoint tx_txcc_p1post_coef_mult_15_8.value[7:0];
    tx_txcc_p1post_coef_mult_31_16: coverpoint tx_txcc_p1post_coef_mult_31_16.value[15:0];
  endgroup

  protected virtual function void sample(uvm_reg_data_t data, uvm_reg_data_t byte_en, bit is_read, uvm_reg_map map);
    super.sample(data, byte_en, is_read, map);
    if (get_coverage(UVM_CVR_FIELD_VALS)) begin
      if(!is_read) begin
          wr_fld_covg.sample();
      end
      if(is_read) begin
         rd_fld_covg.sample();
      end
    end
  endfunction

  virtual function void sample_values();
    super.sample_values();
    if (get_coverage(UVM_CVR_FIELD_VALS)) begin
      wr_fld_covg.sample();
      rd_fld_covg.sample();
    end
  endfunction

  virtual function void build();
    uvm_reg_field fld_set[$];
    uvm_reg_field_config_ta ta = get_field_config(getconfigUID());
    build_uvm_reg_fields(this, ta, fld_set);
    
    tx_txcc_p1post_coef_mult_7_0 = fld_set[0];
    tx_txcc_p1post_coef_mult_15_8 = fld_set[1];
    tx_txcc_p1post_coef_mult_31_16 = fld_set[2];
  endfunction

  function new(input string name="T_tx_txcc_p1post_coef_mult_607");
    super.new(name, 32, build_coverage(UVM_CVR_FIELD_VALS));
    if (has_coverage(UVM_CVR_FIELD_VALS)) begin
      wr_fld_covg = new();
      rd_fld_covg = new();
    end
  endfunction

endclass


/////////////////////////////////////////////////////
//                tx_txcc_p1pre_coef_mult
/////////////////////////////////////////////////////
class T_tx_txcc_p1pre_coef_mult_596 extends cdns_uvm_reg;

  `uvm_object_utils(T_tx_txcc_p1pre_coef_mult_596)
  rand uvm_reg_field tx_txcc_p1pre_coef_mult_7_0;
  rand uvm_reg_field tx_txcc_p1pre_coef_mult_15_8;
  rand uvm_reg_field tx_txcc_p1pre_coef_mult_31_16;
  
  covergroup wr_fld_covg;
    tx_txcc_p1pre_coef_mult_7_0: coverpoint tx_txcc_p1pre_coef_mult_7_0.value[7:0];
    tx_txcc_p1pre_coef_mult_15_8: coverpoint tx_txcc_p1pre_coef_mult_15_8.value[7:0];
    tx_txcc_p1pre_coef_mult_31_16: coverpoint tx_txcc_p1pre_coef_mult_31_16.value[15:0];
  endgroup
  covergroup rd_fld_covg;
    tx_txcc_p1pre_coef_mult_7_0: coverpoint tx_txcc_p1pre_coef_mult_7_0.value[7:0];
    tx_txcc_p1pre_coef_mult_15_8: coverpoint tx_txcc_p1pre_coef_mult_15_8.value[7:0];
    tx_txcc_p1pre_coef_mult_31_16: coverpoint tx_txcc_p1pre_coef_mult_31_16.value[15:0];
  endgroup

  protected virtual function void sample(uvm_reg_data_t data, uvm_reg_data_t byte_en, bit is_read, uvm_reg_map map);
    super.sample(data, byte_en, is_read, map);
    if (get_coverage(UVM_CVR_FIELD_VALS)) begin
      if(!is_read) begin
          wr_fld_covg.sample();
      end
      if(is_read) begin
         rd_fld_covg.sample();
      end
    end
  endfunction

  virtual function void sample_values();
    super.sample_values();
    if (get_coverage(UVM_CVR_FIELD_VALS)) begin
      wr_fld_covg.sample();
      rd_fld_covg.sample();
    end
  endfunction

  virtual function void build();
    uvm_reg_field fld_set[$];
    uvm_reg_field_config_ta ta = get_field_config(getconfigUID());
    build_uvm_reg_fields(this, ta, fld_set);
    
    tx_txcc_p1pre_coef_mult_7_0 = fld_set[0];
    tx_txcc_p1pre_coef_mult_15_8 = fld_set[1];
    tx_txcc_p1pre_coef_mult_31_16 = fld_set[2];
  endfunction

  function new(input string name="T_tx_txcc_p1pre_coef_mult_596");
    super.new(name, 32, build_coverage(UVM_CVR_FIELD_VALS));
    if (has_coverage(UVM_CVR_FIELD_VALS)) begin
      wr_fld_covg = new();
      rd_fld_covg = new();
    end
  endfunction

endclass


/////////////////////////////////////////////////////
//                tx_txcc_p2post_coef_mult
/////////////////////////////////////////////////////
class T_tx_txcc_p2post_coef_mult_608 extends cdns_uvm_reg;

  `uvm_object_utils(T_tx_txcc_p2post_coef_mult_608)
  rand uvm_reg_field tx_txcc_p2post_coef_mult_7_0;
  rand uvm_reg_field tx_txcc_p2post_coef_mult_15_8;
  rand uvm_reg_field tx_txcc_p2post_coef_mult_31_16;
  
  covergroup wr_fld_covg;
    tx_txcc_p2post_coef_mult_7_0: coverpoint tx_txcc_p2post_coef_mult_7_0.value[7:0];
    tx_txcc_p2post_coef_mult_15_8: coverpoint tx_txcc_p2post_coef_mult_15_8.value[7:0];
    tx_txcc_p2post_coef_mult_31_16: coverpoint tx_txcc_p2post_coef_mult_31_16.value[15:0];
  endgroup
  covergroup rd_fld_covg;
    tx_txcc_p2post_coef_mult_7_0: coverpoint tx_txcc_p2post_coef_mult_7_0.value[7:0];
    tx_txcc_p2post_coef_mult_15_8: coverpoint tx_txcc_p2post_coef_mult_15_8.value[7:0];
    tx_txcc_p2post_coef_mult_31_16: coverpoint tx_txcc_p2post_coef_mult_31_16.value[15:0];
  endgroup

  protected virtual function void sample(uvm_reg_data_t data, uvm_reg_data_t byte_en, bit is_read, uvm_reg_map map);
    super.sample(data, byte_en, is_read, map);
    if (get_coverage(UVM_CVR_FIELD_VALS)) begin
      if(!is_read) begin
          wr_fld_covg.sample();
      end
      if(is_read) begin
         rd_fld_covg.sample();
      end
    end
  endfunction

  virtual function void sample_values();
    super.sample_values();
    if (get_coverage(UVM_CVR_FIELD_VALS)) begin
      wr_fld_covg.sample();
      rd_fld_covg.sample();
    end
  endfunction

  virtual function void build();
    uvm_reg_field fld_set[$];
    uvm_reg_field_config_ta ta = get_field_config(getconfigUID());
    build_uvm_reg_fields(this, ta, fld_set);
    
    tx_txcc_p2post_coef_mult_7_0 = fld_set[0];
    tx_txcc_p2post_coef_mult_15_8 = fld_set[1];
    tx_txcc_p2post_coef_mult_31_16 = fld_set[2];
  endfunction

  function new(input string name="T_tx_txcc_p2post_coef_mult_608");
    super.new(name, 32, build_coverage(UVM_CVR_FIELD_VALS));
    if (has_coverage(UVM_CVR_FIELD_VALS)) begin
      wr_fld_covg = new();
      rd_fld_covg = new();
    end
  endfunction

endclass


/////////////////////////////////////////////////////
//                tx_txcc_p2pre_coef_mult
/////////////////////////////////////////////////////
class T_tx_txcc_p2pre_coef_mult_597 extends cdns_uvm_reg;

  `uvm_object_utils(T_tx_txcc_p2pre_coef_mult_597)
  rand uvm_reg_field tx_txcc_p2pre_coef_mult_7_0;
  rand uvm_reg_field tx_txcc_p2pre_coef_mult_15_8;
  rand uvm_reg_field tx_txcc_p2pre_coef_mult_31_16;
  
  covergroup wr_fld_covg;
    tx_txcc_p2pre_coef_mult_7_0: coverpoint tx_txcc_p2pre_coef_mult_7_0.value[7:0];
    tx_txcc_p2pre_coef_mult_15_8: coverpoint tx_txcc_p2pre_coef_mult_15_8.value[7:0];
    tx_txcc_p2pre_coef_mult_31_16: coverpoint tx_txcc_p2pre_coef_mult_31_16.value[15:0];
  endgroup
  covergroup rd_fld_covg;
    tx_txcc_p2pre_coef_mult_7_0: coverpoint tx_txcc_p2pre_coef_mult_7_0.value[7:0];
    tx_txcc_p2pre_coef_mult_15_8: coverpoint tx_txcc_p2pre_coef_mult_15_8.value[7:0];
    tx_txcc_p2pre_coef_mult_31_16: coverpoint tx_txcc_p2pre_coef_mult_31_16.value[15:0];
  endgroup

  protected virtual function void sample(uvm_reg_data_t data, uvm_reg_data_t byte_en, bit is_read, uvm_reg_map map);
    super.sample(data, byte_en, is_read, map);
    if (get_coverage(UVM_CVR_FIELD_VALS)) begin
      if(!is_read) begin
          wr_fld_covg.sample();
      end
      if(is_read) begin
         rd_fld_covg.sample();
      end
    end
  endfunction

  virtual function void sample_values();
    super.sample_values();
    if (get_coverage(UVM_CVR_FIELD_VALS)) begin
      wr_fld_covg.sample();
      rd_fld_covg.sample();
    end
  endfunction

  virtual function void build();
    uvm_reg_field fld_set[$];
    uvm_reg_field_config_ta ta = get_field_config(getconfigUID());
    build_uvm_reg_fields(this, ta, fld_set);
    
    tx_txcc_p2pre_coef_mult_7_0 = fld_set[0];
    tx_txcc_p2pre_coef_mult_15_8 = fld_set[1];
    tx_txcc_p2pre_coef_mult_31_16 = fld_set[2];
  endfunction

  function new(input string name="T_tx_txcc_p2pre_coef_mult_597");
    super.new(name, 32, build_coverage(UVM_CVR_FIELD_VALS));
    if (has_coverage(UVM_CVR_FIELD_VALS)) begin
      wr_fld_covg = new();
      rd_fld_covg = new();
    end
  endfunction

endclass


/////////////////////////////////////////////////////
//                tx_txcc_p3post_coef_mult
/////////////////////////////////////////////////////
class T_tx_txcc_p3post_coef_mult_609 extends cdns_uvm_reg;

  `uvm_object_utils(T_tx_txcc_p3post_coef_mult_609)
  rand uvm_reg_field tx_txcc_p3post_coef_mult_7_0;
  rand uvm_reg_field tx_txcc_p3post_coef_mult_15_8;
  rand uvm_reg_field tx_txcc_p3post_coef_mult_31_16;
  
  covergroup wr_fld_covg;
    tx_txcc_p3post_coef_mult_7_0: coverpoint tx_txcc_p3post_coef_mult_7_0.value[7:0];
    tx_txcc_p3post_coef_mult_15_8: coverpoint tx_txcc_p3post_coef_mult_15_8.value[7:0];
    tx_txcc_p3post_coef_mult_31_16: coverpoint tx_txcc_p3post_coef_mult_31_16.value[15:0];
  endgroup
  covergroup rd_fld_covg;
    tx_txcc_p3post_coef_mult_7_0: coverpoint tx_txcc_p3post_coef_mult_7_0.value[7:0];
    tx_txcc_p3post_coef_mult_15_8: coverpoint tx_txcc_p3post_coef_mult_15_8.value[7:0];
    tx_txcc_p3post_coef_mult_31_16: coverpoint tx_txcc_p3post_coef_mult_31_16.value[15:0];
  endgroup

  protected virtual function void sample(uvm_reg_data_t data, uvm_reg_data_t byte_en, bit is_read, uvm_reg_map map);
    super.sample(data, byte_en, is_read, map);
    if (get_coverage(UVM_CVR_FIELD_VALS)) begin
      if(!is_read) begin
          wr_fld_covg.sample();
      end
      if(is_read) begin
         rd_fld_covg.sample();
      end
    end
  endfunction

  virtual function void sample_values();
    super.sample_values();
    if (get_coverage(UVM_CVR_FIELD_VALS)) begin
      wr_fld_covg.sample();
      rd_fld_covg.sample();
    end
  endfunction

  virtual function void build();
    uvm_reg_field fld_set[$];
    uvm_reg_field_config_ta ta = get_field_config(getconfigUID());
    build_uvm_reg_fields(this, ta, fld_set);
    
    tx_txcc_p3post_coef_mult_7_0 = fld_set[0];
    tx_txcc_p3post_coef_mult_15_8 = fld_set[1];
    tx_txcc_p3post_coef_mult_31_16 = fld_set[2];
  endfunction

  function new(input string name="T_tx_txcc_p3post_coef_mult_609");
    super.new(name, 32, build_coverage(UVM_CVR_FIELD_VALS));
    if (has_coverage(UVM_CVR_FIELD_VALS)) begin
      wr_fld_covg = new();
      rd_fld_covg = new();
    end
  endfunction

endclass


/////////////////////////////////////////////////////
//                tx_txcc_p3pre_coef_mult
/////////////////////////////////////////////////////
class T_tx_txcc_p3pre_coef_mult_598 extends cdns_uvm_reg;

  `uvm_object_utils(T_tx_txcc_p3pre_coef_mult_598)
  rand uvm_reg_field tx_txcc_p3pre_coef_mult_7_0;
  rand uvm_reg_field tx_txcc_p3pre_coef_mult_15_8;
  rand uvm_reg_field tx_txcc_p3pre_coef_mult_31_16;
  
  covergroup wr_fld_covg;
    tx_txcc_p3pre_coef_mult_7_0: coverpoint tx_txcc_p3pre_coef_mult_7_0.value[7:0];
    tx_txcc_p3pre_coef_mult_15_8: coverpoint tx_txcc_p3pre_coef_mult_15_8.value[7:0];
    tx_txcc_p3pre_coef_mult_31_16: coverpoint tx_txcc_p3pre_coef_mult_31_16.value[15:0];
  endgroup
  covergroup rd_fld_covg;
    tx_txcc_p3pre_coef_mult_7_0: coverpoint tx_txcc_p3pre_coef_mult_7_0.value[7:0];
    tx_txcc_p3pre_coef_mult_15_8: coverpoint tx_txcc_p3pre_coef_mult_15_8.value[7:0];
    tx_txcc_p3pre_coef_mult_31_16: coverpoint tx_txcc_p3pre_coef_mult_31_16.value[15:0];
  endgroup

  protected virtual function void sample(uvm_reg_data_t data, uvm_reg_data_t byte_en, bit is_read, uvm_reg_map map);
    super.sample(data, byte_en, is_read, map);
    if (get_coverage(UVM_CVR_FIELD_VALS)) begin
      if(!is_read) begin
          wr_fld_covg.sample();
      end
      if(is_read) begin
         rd_fld_covg.sample();
      end
    end
  endfunction

  virtual function void sample_values();
    super.sample_values();
    if (get_coverage(UVM_CVR_FIELD_VALS)) begin
      wr_fld_covg.sample();
      rd_fld_covg.sample();
    end
  endfunction

  virtual function void build();
    uvm_reg_field fld_set[$];
    uvm_reg_field_config_ta ta = get_field_config(getconfigUID());
    build_uvm_reg_fields(this, ta, fld_set);
    
    tx_txcc_p3pre_coef_mult_7_0 = fld_set[0];
    tx_txcc_p3pre_coef_mult_15_8 = fld_set[1];
    tx_txcc_p3pre_coef_mult_31_16 = fld_set[2];
  endfunction

  function new(input string name="T_tx_txcc_p3pre_coef_mult_598");
    super.new(name, 32, build_coverage(UVM_CVR_FIELD_VALS));
    if (has_coverage(UVM_CVR_FIELD_VALS)) begin
      wr_fld_covg = new();
      rd_fld_covg = new();
    end
  endfunction

endclass


/////////////////////////////////////////////////////
//                tx_txcc_p4post_coef_mult
/////////////////////////////////////////////////////
class T_tx_txcc_p4post_coef_mult_610 extends cdns_uvm_reg;

  `uvm_object_utils(T_tx_txcc_p4post_coef_mult_610)
  rand uvm_reg_field tx_txcc_p4post_coef_mult_7_0;
  rand uvm_reg_field tx_txcc_p4post_coef_mult_15_8;
  rand uvm_reg_field tx_txcc_p4post_coef_mult_31_16;
  
  covergroup wr_fld_covg;
    tx_txcc_p4post_coef_mult_7_0: coverpoint tx_txcc_p4post_coef_mult_7_0.value[7:0];
    tx_txcc_p4post_coef_mult_15_8: coverpoint tx_txcc_p4post_coef_mult_15_8.value[7:0];
    tx_txcc_p4post_coef_mult_31_16: coverpoint tx_txcc_p4post_coef_mult_31_16.value[15:0];
  endgroup
  covergroup rd_fld_covg;
    tx_txcc_p4post_coef_mult_7_0: coverpoint tx_txcc_p4post_coef_mult_7_0.value[7:0];
    tx_txcc_p4post_coef_mult_15_8: coverpoint tx_txcc_p4post_coef_mult_15_8.value[7:0];
    tx_txcc_p4post_coef_mult_31_16: coverpoint tx_txcc_p4post_coef_mult_31_16.value[15:0];
  endgroup

  protected virtual function void sample(uvm_reg_data_t data, uvm_reg_data_t byte_en, bit is_read, uvm_reg_map map);
    super.sample(data, byte_en, is_read, map);
    if (get_coverage(UVM_CVR_FIELD_VALS)) begin
      if(!is_read) begin
          wr_fld_covg.sample();
      end
      if(is_read) begin
         rd_fld_covg.sample();
      end
    end
  endfunction

  virtual function void sample_values();
    super.sample_values();
    if (get_coverage(UVM_CVR_FIELD_VALS)) begin
      wr_fld_covg.sample();
      rd_fld_covg.sample();
    end
  endfunction

  virtual function void build();
    uvm_reg_field fld_set[$];
    uvm_reg_field_config_ta ta = get_field_config(getconfigUID());
    build_uvm_reg_fields(this, ta, fld_set);
    
    tx_txcc_p4post_coef_mult_7_0 = fld_set[0];
    tx_txcc_p4post_coef_mult_15_8 = fld_set[1];
    tx_txcc_p4post_coef_mult_31_16 = fld_set[2];
  endfunction

  function new(input string name="T_tx_txcc_p4post_coef_mult_610");
    super.new(name, 32, build_coverage(UVM_CVR_FIELD_VALS));
    if (has_coverage(UVM_CVR_FIELD_VALS)) begin
      wr_fld_covg = new();
      rd_fld_covg = new();
    end
  endfunction

endclass


/////////////////////////////////////////////////////
//                tx_txcc_p4pre_coef_mult
/////////////////////////////////////////////////////
class T_tx_txcc_p4pre_coef_mult_599 extends cdns_uvm_reg;

  `uvm_object_utils(T_tx_txcc_p4pre_coef_mult_599)
  rand uvm_reg_field tx_txcc_p4pre_coef_mult_7_0;
  rand uvm_reg_field tx_txcc_p4pre_coef_mult_15_8;
  rand uvm_reg_field tx_txcc_p4pre_coef_mult_31_16;
  
  covergroup wr_fld_covg;
    tx_txcc_p4pre_coef_mult_7_0: coverpoint tx_txcc_p4pre_coef_mult_7_0.value[7:0];
    tx_txcc_p4pre_coef_mult_15_8: coverpoint tx_txcc_p4pre_coef_mult_15_8.value[7:0];
    tx_txcc_p4pre_coef_mult_31_16: coverpoint tx_txcc_p4pre_coef_mult_31_16.value[15:0];
  endgroup
  covergroup rd_fld_covg;
    tx_txcc_p4pre_coef_mult_7_0: coverpoint tx_txcc_p4pre_coef_mult_7_0.value[7:0];
    tx_txcc_p4pre_coef_mult_15_8: coverpoint tx_txcc_p4pre_coef_mult_15_8.value[7:0];
    tx_txcc_p4pre_coef_mult_31_16: coverpoint tx_txcc_p4pre_coef_mult_31_16.value[15:0];
  endgroup

  protected virtual function void sample(uvm_reg_data_t data, uvm_reg_data_t byte_en, bit is_read, uvm_reg_map map);
    super.sample(data, byte_en, is_read, map);
    if (get_coverage(UVM_CVR_FIELD_VALS)) begin
      if(!is_read) begin
          wr_fld_covg.sample();
      end
      if(is_read) begin
         rd_fld_covg.sample();
      end
    end
  endfunction

  virtual function void sample_values();
    super.sample_values();
    if (get_coverage(UVM_CVR_FIELD_VALS)) begin
      wr_fld_covg.sample();
      rd_fld_covg.sample();
    end
  endfunction

  virtual function void build();
    uvm_reg_field fld_set[$];
    uvm_reg_field_config_ta ta = get_field_config(getconfigUID());
    build_uvm_reg_fields(this, ta, fld_set);
    
    tx_txcc_p4pre_coef_mult_7_0 = fld_set[0];
    tx_txcc_p4pre_coef_mult_15_8 = fld_set[1];
    tx_txcc_p4pre_coef_mult_31_16 = fld_set[2];
  endfunction

  function new(input string name="T_tx_txcc_p4pre_coef_mult_599");
    super.new(name, 32, build_coverage(UVM_CVR_FIELD_VALS));
    if (has_coverage(UVM_CVR_FIELD_VALS)) begin
      wr_fld_covg = new();
      rd_fld_covg = new();
    end
  endfunction

endclass


/////////////////////////////////////////////////////
//                tx_txcc_p5post_coef_mult
/////////////////////////////////////////////////////
class T_tx_txcc_p5post_coef_mult_611 extends cdns_uvm_reg;

  `uvm_object_utils(T_tx_txcc_p5post_coef_mult_611)
  rand uvm_reg_field tx_txcc_p5post_coef_mult_7_0;
  rand uvm_reg_field tx_txcc_p5post_coef_mult_15_8;
  rand uvm_reg_field tx_txcc_p5post_coef_mult_31_16;
  
  covergroup wr_fld_covg;
    tx_txcc_p5post_coef_mult_7_0: coverpoint tx_txcc_p5post_coef_mult_7_0.value[7:0];
    tx_txcc_p5post_coef_mult_15_8: coverpoint tx_txcc_p5post_coef_mult_15_8.value[7:0];
    tx_txcc_p5post_coef_mult_31_16: coverpoint tx_txcc_p5post_coef_mult_31_16.value[15:0];
  endgroup
  covergroup rd_fld_covg;
    tx_txcc_p5post_coef_mult_7_0: coverpoint tx_txcc_p5post_coef_mult_7_0.value[7:0];
    tx_txcc_p5post_coef_mult_15_8: coverpoint tx_txcc_p5post_coef_mult_15_8.value[7:0];
    tx_txcc_p5post_coef_mult_31_16: coverpoint tx_txcc_p5post_coef_mult_31_16.value[15:0];
  endgroup

  protected virtual function void sample(uvm_reg_data_t data, uvm_reg_data_t byte_en, bit is_read, uvm_reg_map map);
    super.sample(data, byte_en, is_read, map);
    if (get_coverage(UVM_CVR_FIELD_VALS)) begin
      if(!is_read) begin
          wr_fld_covg.sample();
      end
      if(is_read) begin
         rd_fld_covg.sample();
      end
    end
  endfunction

  virtual function void sample_values();
    super.sample_values();
    if (get_coverage(UVM_CVR_FIELD_VALS)) begin
      wr_fld_covg.sample();
      rd_fld_covg.sample();
    end
  endfunction

  virtual function void build();
    uvm_reg_field fld_set[$];
    uvm_reg_field_config_ta ta = get_field_config(getconfigUID());
    build_uvm_reg_fields(this, ta, fld_set);
    
    tx_txcc_p5post_coef_mult_7_0 = fld_set[0];
    tx_txcc_p5post_coef_mult_15_8 = fld_set[1];
    tx_txcc_p5post_coef_mult_31_16 = fld_set[2];
  endfunction

  function new(input string name="T_tx_txcc_p5post_coef_mult_611");
    super.new(name, 32, build_coverage(UVM_CVR_FIELD_VALS));
    if (has_coverage(UVM_CVR_FIELD_VALS)) begin
      wr_fld_covg = new();
      rd_fld_covg = new();
    end
  endfunction

endclass


/////////////////////////////////////////////////////
//                tx_txcc_p5pre_coef_mult
/////////////////////////////////////////////////////
class T_tx_txcc_p5pre_coef_mult_600 extends cdns_uvm_reg;

  `uvm_object_utils(T_tx_txcc_p5pre_coef_mult_600)
  rand uvm_reg_field tx_txcc_p5pre_coef_mult_7_0;
  rand uvm_reg_field tx_txcc_p5pre_coef_mult_15_8;
  rand uvm_reg_field tx_txcc_p5pre_coef_mult_31_16;
  
  covergroup wr_fld_covg;
    tx_txcc_p5pre_coef_mult_7_0: coverpoint tx_txcc_p5pre_coef_mult_7_0.value[7:0];
    tx_txcc_p5pre_coef_mult_15_8: coverpoint tx_txcc_p5pre_coef_mult_15_8.value[7:0];
    tx_txcc_p5pre_coef_mult_31_16: coverpoint tx_txcc_p5pre_coef_mult_31_16.value[15:0];
  endgroup
  covergroup rd_fld_covg;
    tx_txcc_p5pre_coef_mult_7_0: coverpoint tx_txcc_p5pre_coef_mult_7_0.value[7:0];
    tx_txcc_p5pre_coef_mult_15_8: coverpoint tx_txcc_p5pre_coef_mult_15_8.value[7:0];
    tx_txcc_p5pre_coef_mult_31_16: coverpoint tx_txcc_p5pre_coef_mult_31_16.value[15:0];
  endgroup

  protected virtual function void sample(uvm_reg_data_t data, uvm_reg_data_t byte_en, bit is_read, uvm_reg_map map);
    super.sample(data, byte_en, is_read, map);
    if (get_coverage(UVM_CVR_FIELD_VALS)) begin
      if(!is_read) begin
          wr_fld_covg.sample();
      end
      if(is_read) begin
         rd_fld_covg.sample();
      end
    end
  endfunction

  virtual function void sample_values();
    super.sample_values();
    if (get_coverage(UVM_CVR_FIELD_VALS)) begin
      wr_fld_covg.sample();
      rd_fld_covg.sample();
    end
  endfunction

  virtual function void build();
    uvm_reg_field fld_set[$];
    uvm_reg_field_config_ta ta = get_field_config(getconfigUID());
    build_uvm_reg_fields(this, ta, fld_set);
    
    tx_txcc_p5pre_coef_mult_7_0 = fld_set[0];
    tx_txcc_p5pre_coef_mult_15_8 = fld_set[1];
    tx_txcc_p5pre_coef_mult_31_16 = fld_set[2];
  endfunction

  function new(input string name="T_tx_txcc_p5pre_coef_mult_600");
    super.new(name, 32, build_coverage(UVM_CVR_FIELD_VALS));
    if (has_coverage(UVM_CVR_FIELD_VALS)) begin
      wr_fld_covg = new();
      rd_fld_covg = new();
    end
  endfunction

endclass


/////////////////////////////////////////////////////
//                tx_txcc_p6post_coef_mult
/////////////////////////////////////////////////////
class T_tx_txcc_p6post_coef_mult_612 extends cdns_uvm_reg;

  `uvm_object_utils(T_tx_txcc_p6post_coef_mult_612)
  rand uvm_reg_field tx_txcc_p6post_coef_mult_7_0;
  rand uvm_reg_field tx_txcc_p6post_coef_mult_15_8;
  rand uvm_reg_field tx_txcc_p6post_coef_mult_31_16;
  
  covergroup wr_fld_covg;
    tx_txcc_p6post_coef_mult_7_0: coverpoint tx_txcc_p6post_coef_mult_7_0.value[7:0];
    tx_txcc_p6post_coef_mult_15_8: coverpoint tx_txcc_p6post_coef_mult_15_8.value[7:0];
    tx_txcc_p6post_coef_mult_31_16: coverpoint tx_txcc_p6post_coef_mult_31_16.value[15:0];
  endgroup
  covergroup rd_fld_covg;
    tx_txcc_p6post_coef_mult_7_0: coverpoint tx_txcc_p6post_coef_mult_7_0.value[7:0];
    tx_txcc_p6post_coef_mult_15_8: coverpoint tx_txcc_p6post_coef_mult_15_8.value[7:0];
    tx_txcc_p6post_coef_mult_31_16: coverpoint tx_txcc_p6post_coef_mult_31_16.value[15:0];
  endgroup

  protected virtual function void sample(uvm_reg_data_t data, uvm_reg_data_t byte_en, bit is_read, uvm_reg_map map);
    super.sample(data, byte_en, is_read, map);
    if (get_coverage(UVM_CVR_FIELD_VALS)) begin
      if(!is_read) begin
          wr_fld_covg.sample();
      end
      if(is_read) begin
         rd_fld_covg.sample();
      end
    end
  endfunction

  virtual function void sample_values();
    super.sample_values();
    if (get_coverage(UVM_CVR_FIELD_VALS)) begin
      wr_fld_covg.sample();
      rd_fld_covg.sample();
    end
  endfunction

  virtual function void build();
    uvm_reg_field fld_set[$];
    uvm_reg_field_config_ta ta = get_field_config(getconfigUID());
    build_uvm_reg_fields(this, ta, fld_set);
    
    tx_txcc_p6post_coef_mult_7_0 = fld_set[0];
    tx_txcc_p6post_coef_mult_15_8 = fld_set[1];
    tx_txcc_p6post_coef_mult_31_16 = fld_set[2];
  endfunction

  function new(input string name="T_tx_txcc_p6post_coef_mult_612");
    super.new(name, 32, build_coverage(UVM_CVR_FIELD_VALS));
    if (has_coverage(UVM_CVR_FIELD_VALS)) begin
      wr_fld_covg = new();
      rd_fld_covg = new();
    end
  endfunction

endclass


/////////////////////////////////////////////////////
//                tx_txcc_p6pre_coef_mult
/////////////////////////////////////////////////////
class T_tx_txcc_p6pre_coef_mult_601 extends cdns_uvm_reg;

  `uvm_object_utils(T_tx_txcc_p6pre_coef_mult_601)
  rand uvm_reg_field tx_txcc_p6pre_coef_mult_7_0;
  rand uvm_reg_field tx_txcc_p6pre_coef_mult_15_8;
  rand uvm_reg_field tx_txcc_p6pre_coef_mult_31_16;
  
  covergroup wr_fld_covg;
    tx_txcc_p6pre_coef_mult_7_0: coverpoint tx_txcc_p6pre_coef_mult_7_0.value[7:0];
    tx_txcc_p6pre_coef_mult_15_8: coverpoint tx_txcc_p6pre_coef_mult_15_8.value[7:0];
    tx_txcc_p6pre_coef_mult_31_16: coverpoint tx_txcc_p6pre_coef_mult_31_16.value[15:0];
  endgroup
  covergroup rd_fld_covg;
    tx_txcc_p6pre_coef_mult_7_0: coverpoint tx_txcc_p6pre_coef_mult_7_0.value[7:0];
    tx_txcc_p6pre_coef_mult_15_8: coverpoint tx_txcc_p6pre_coef_mult_15_8.value[7:0];
    tx_txcc_p6pre_coef_mult_31_16: coverpoint tx_txcc_p6pre_coef_mult_31_16.value[15:0];
  endgroup

  protected virtual function void sample(uvm_reg_data_t data, uvm_reg_data_t byte_en, bit is_read, uvm_reg_map map);
    super.sample(data, byte_en, is_read, map);
    if (get_coverage(UVM_CVR_FIELD_VALS)) begin
      if(!is_read) begin
          wr_fld_covg.sample();
      end
      if(is_read) begin
         rd_fld_covg.sample();
      end
    end
  endfunction

  virtual function void sample_values();
    super.sample_values();
    if (get_coverage(UVM_CVR_FIELD_VALS)) begin
      wr_fld_covg.sample();
      rd_fld_covg.sample();
    end
  endfunction

  virtual function void build();
    uvm_reg_field fld_set[$];
    uvm_reg_field_config_ta ta = get_field_config(getconfigUID());
    build_uvm_reg_fields(this, ta, fld_set);
    
    tx_txcc_p6pre_coef_mult_7_0 = fld_set[0];
    tx_txcc_p6pre_coef_mult_15_8 = fld_set[1];
    tx_txcc_p6pre_coef_mult_31_16 = fld_set[2];
  endfunction

  function new(input string name="T_tx_txcc_p6pre_coef_mult_601");
    super.new(name, 32, build_coverage(UVM_CVR_FIELD_VALS));
    if (has_coverage(UVM_CVR_FIELD_VALS)) begin
      wr_fld_covg = new();
      rd_fld_covg = new();
    end
  endfunction

endclass


/////////////////////////////////////////////////////
//                tx_txcc_p7post_coef_mult
/////////////////////////////////////////////////////
class T_tx_txcc_p7post_coef_mult_613 extends cdns_uvm_reg;

  `uvm_object_utils(T_tx_txcc_p7post_coef_mult_613)
  rand uvm_reg_field tx_txcc_p7post_coef_mult_7_0;
  rand uvm_reg_field tx_txcc_p7post_coef_mult_15_8;
  rand uvm_reg_field tx_txcc_p7post_coef_mult_31_16;
  
  covergroup wr_fld_covg;
    tx_txcc_p7post_coef_mult_7_0: coverpoint tx_txcc_p7post_coef_mult_7_0.value[7:0];
    tx_txcc_p7post_coef_mult_15_8: coverpoint tx_txcc_p7post_coef_mult_15_8.value[7:0];
    tx_txcc_p7post_coef_mult_31_16: coverpoint tx_txcc_p7post_coef_mult_31_16.value[15:0];
  endgroup
  covergroup rd_fld_covg;
    tx_txcc_p7post_coef_mult_7_0: coverpoint tx_txcc_p7post_coef_mult_7_0.value[7:0];
    tx_txcc_p7post_coef_mult_15_8: coverpoint tx_txcc_p7post_coef_mult_15_8.value[7:0];
    tx_txcc_p7post_coef_mult_31_16: coverpoint tx_txcc_p7post_coef_mult_31_16.value[15:0];
  endgroup

  protected virtual function void sample(uvm_reg_data_t data, uvm_reg_data_t byte_en, bit is_read, uvm_reg_map map);
    super.sample(data, byte_en, is_read, map);
    if (get_coverage(UVM_CVR_FIELD_VALS)) begin
      if(!is_read) begin
          wr_fld_covg.sample();
      end
      if(is_read) begin
         rd_fld_covg.sample();
      end
    end
  endfunction

  virtual function void sample_values();
    super.sample_values();
    if (get_coverage(UVM_CVR_FIELD_VALS)) begin
      wr_fld_covg.sample();
      rd_fld_covg.sample();
    end
  endfunction

  virtual function void build();
    uvm_reg_field fld_set[$];
    uvm_reg_field_config_ta ta = get_field_config(getconfigUID());
    build_uvm_reg_fields(this, ta, fld_set);
    
    tx_txcc_p7post_coef_mult_7_0 = fld_set[0];
    tx_txcc_p7post_coef_mult_15_8 = fld_set[1];
    tx_txcc_p7post_coef_mult_31_16 = fld_set[2];
  endfunction

  function new(input string name="T_tx_txcc_p7post_coef_mult_613");
    super.new(name, 32, build_coverage(UVM_CVR_FIELD_VALS));
    if (has_coverage(UVM_CVR_FIELD_VALS)) begin
      wr_fld_covg = new();
      rd_fld_covg = new();
    end
  endfunction

endclass


/////////////////////////////////////////////////////
//                tx_txcc_p7pre_coef_mult
/////////////////////////////////////////////////////
class T_tx_txcc_p7pre_coef_mult_602 extends cdns_uvm_reg;

  `uvm_object_utils(T_tx_txcc_p7pre_coef_mult_602)
  rand uvm_reg_field tx_txcc_p7pre_coef_mult_7_0;
  rand uvm_reg_field tx_txcc_p7pre_coef_mult_15_8;
  rand uvm_reg_field tx_txcc_p7pre_coef_mult_31_16;
  
  covergroup wr_fld_covg;
    tx_txcc_p7pre_coef_mult_7_0: coverpoint tx_txcc_p7pre_coef_mult_7_0.value[7:0];
    tx_txcc_p7pre_coef_mult_15_8: coverpoint tx_txcc_p7pre_coef_mult_15_8.value[7:0];
    tx_txcc_p7pre_coef_mult_31_16: coverpoint tx_txcc_p7pre_coef_mult_31_16.value[15:0];
  endgroup
  covergroup rd_fld_covg;
    tx_txcc_p7pre_coef_mult_7_0: coverpoint tx_txcc_p7pre_coef_mult_7_0.value[7:0];
    tx_txcc_p7pre_coef_mult_15_8: coverpoint tx_txcc_p7pre_coef_mult_15_8.value[7:0];
    tx_txcc_p7pre_coef_mult_31_16: coverpoint tx_txcc_p7pre_coef_mult_31_16.value[15:0];
  endgroup

  protected virtual function void sample(uvm_reg_data_t data, uvm_reg_data_t byte_en, bit is_read, uvm_reg_map map);
    super.sample(data, byte_en, is_read, map);
    if (get_coverage(UVM_CVR_FIELD_VALS)) begin
      if(!is_read) begin
          wr_fld_covg.sample();
      end
      if(is_read) begin
         rd_fld_covg.sample();
      end
    end
  endfunction

  virtual function void sample_values();
    super.sample_values();
    if (get_coverage(UVM_CVR_FIELD_VALS)) begin
      wr_fld_covg.sample();
      rd_fld_covg.sample();
    end
  endfunction

  virtual function void build();
    uvm_reg_field fld_set[$];
    uvm_reg_field_config_ta ta = get_field_config(getconfigUID());
    build_uvm_reg_fields(this, ta, fld_set);
    
    tx_txcc_p7pre_coef_mult_7_0 = fld_set[0];
    tx_txcc_p7pre_coef_mult_15_8 = fld_set[1];
    tx_txcc_p7pre_coef_mult_31_16 = fld_set[2];
  endfunction

  function new(input string name="T_tx_txcc_p7pre_coef_mult_602");
    super.new(name, 32, build_coverage(UVM_CVR_FIELD_VALS));
    if (has_coverage(UVM_CVR_FIELD_VALS)) begin
      wr_fld_covg = new();
      rd_fld_covg = new();
    end
  endfunction

endclass


/////////////////////////////////////////////////////
//                tx_txcc_p8post_coef_mult
/////////////////////////////////////////////////////
class T_tx_txcc_p8post_coef_mult_614 extends cdns_uvm_reg;

  `uvm_object_utils(T_tx_txcc_p8post_coef_mult_614)
  rand uvm_reg_field tx_txcc_p8post_coef_mult_7_0;
  rand uvm_reg_field tx_txcc_p8post_coef_mult_15_8;
  rand uvm_reg_field tx_txcc_p8post_coef_mult_31_16;
  
  covergroup wr_fld_covg;
    tx_txcc_p8post_coef_mult_7_0: coverpoint tx_txcc_p8post_coef_mult_7_0.value[7:0];
    tx_txcc_p8post_coef_mult_15_8: coverpoint tx_txcc_p8post_coef_mult_15_8.value[7:0];
    tx_txcc_p8post_coef_mult_31_16: coverpoint tx_txcc_p8post_coef_mult_31_16.value[15:0];
  endgroup
  covergroup rd_fld_covg;
    tx_txcc_p8post_coef_mult_7_0: coverpoint tx_txcc_p8post_coef_mult_7_0.value[7:0];
    tx_txcc_p8post_coef_mult_15_8: coverpoint tx_txcc_p8post_coef_mult_15_8.value[7:0];
    tx_txcc_p8post_coef_mult_31_16: coverpoint tx_txcc_p8post_coef_mult_31_16.value[15:0];
  endgroup

  protected virtual function void sample(uvm_reg_data_t data, uvm_reg_data_t byte_en, bit is_read, uvm_reg_map map);
    super.sample(data, byte_en, is_read, map);
    if (get_coverage(UVM_CVR_FIELD_VALS)) begin
      if(!is_read) begin
          wr_fld_covg.sample();
      end
      if(is_read) begin
         rd_fld_covg.sample();
      end
    end
  endfunction

  virtual function void sample_values();
    super.sample_values();
    if (get_coverage(UVM_CVR_FIELD_VALS)) begin
      wr_fld_covg.sample();
      rd_fld_covg.sample();
    end
  endfunction

  virtual function void build();
    uvm_reg_field fld_set[$];
    uvm_reg_field_config_ta ta = get_field_config(getconfigUID());
    build_uvm_reg_fields(this, ta, fld_set);
    
    tx_txcc_p8post_coef_mult_7_0 = fld_set[0];
    tx_txcc_p8post_coef_mult_15_8 = fld_set[1];
    tx_txcc_p8post_coef_mult_31_16 = fld_set[2];
  endfunction

  function new(input string name="T_tx_txcc_p8post_coef_mult_614");
    super.new(name, 32, build_coverage(UVM_CVR_FIELD_VALS));
    if (has_coverage(UVM_CVR_FIELD_VALS)) begin
      wr_fld_covg = new();
      rd_fld_covg = new();
    end
  endfunction

endclass


/////////////////////////////////////////////////////
//                tx_txcc_p8pre_coef_mult
/////////////////////////////////////////////////////
class T_tx_txcc_p8pre_coef_mult_603 extends cdns_uvm_reg;

  `uvm_object_utils(T_tx_txcc_p8pre_coef_mult_603)
  rand uvm_reg_field tx_txcc_p8pre_coef_mult_7_0;
  rand uvm_reg_field tx_txcc_p8pre_coef_mult_15_8;
  rand uvm_reg_field tx_txcc_p8pre_coef_mult_31_16;
  
  covergroup wr_fld_covg;
    tx_txcc_p8pre_coef_mult_7_0: coverpoint tx_txcc_p8pre_coef_mult_7_0.value[7:0];
    tx_txcc_p8pre_coef_mult_15_8: coverpoint tx_txcc_p8pre_coef_mult_15_8.value[7:0];
    tx_txcc_p8pre_coef_mult_31_16: coverpoint tx_txcc_p8pre_coef_mult_31_16.value[15:0];
  endgroup
  covergroup rd_fld_covg;
    tx_txcc_p8pre_coef_mult_7_0: coverpoint tx_txcc_p8pre_coef_mult_7_0.value[7:0];
    tx_txcc_p8pre_coef_mult_15_8: coverpoint tx_txcc_p8pre_coef_mult_15_8.value[7:0];
    tx_txcc_p8pre_coef_mult_31_16: coverpoint tx_txcc_p8pre_coef_mult_31_16.value[15:0];
  endgroup

  protected virtual function void sample(uvm_reg_data_t data, uvm_reg_data_t byte_en, bit is_read, uvm_reg_map map);
    super.sample(data, byte_en, is_read, map);
    if (get_coverage(UVM_CVR_FIELD_VALS)) begin
      if(!is_read) begin
          wr_fld_covg.sample();
      end
      if(is_read) begin
         rd_fld_covg.sample();
      end
    end
  endfunction

  virtual function void sample_values();
    super.sample_values();
    if (get_coverage(UVM_CVR_FIELD_VALS)) begin
      wr_fld_covg.sample();
      rd_fld_covg.sample();
    end
  endfunction

  virtual function void build();
    uvm_reg_field fld_set[$];
    uvm_reg_field_config_ta ta = get_field_config(getconfigUID());
    build_uvm_reg_fields(this, ta, fld_set);
    
    tx_txcc_p8pre_coef_mult_7_0 = fld_set[0];
    tx_txcc_p8pre_coef_mult_15_8 = fld_set[1];
    tx_txcc_p8pre_coef_mult_31_16 = fld_set[2];
  endfunction

  function new(input string name="T_tx_txcc_p8pre_coef_mult_603");
    super.new(name, 32, build_coverage(UVM_CVR_FIELD_VALS));
    if (has_coverage(UVM_CVR_FIELD_VALS)) begin
      wr_fld_covg = new();
      rd_fld_covg = new();
    end
  endfunction

endclass


/////////////////////////////////////////////////////
//                tx_txcc_p9post_coef_mult
/////////////////////////////////////////////////////
class T_tx_txcc_p9post_coef_mult_615 extends cdns_uvm_reg;

  `uvm_object_utils(T_tx_txcc_p9post_coef_mult_615)
  rand uvm_reg_field tx_txcc_p9post_coef_mult_7_0;
  rand uvm_reg_field tx_txcc_p9post_coef_mult_15_8;
  rand uvm_reg_field tx_txcc_p9post_coef_mult_31_16;
  
  covergroup wr_fld_covg;
    tx_txcc_p9post_coef_mult_7_0: coverpoint tx_txcc_p9post_coef_mult_7_0.value[7:0];
    tx_txcc_p9post_coef_mult_15_8: coverpoint tx_txcc_p9post_coef_mult_15_8.value[7:0];
    tx_txcc_p9post_coef_mult_31_16: coverpoint tx_txcc_p9post_coef_mult_31_16.value[15:0];
  endgroup
  covergroup rd_fld_covg;
    tx_txcc_p9post_coef_mult_7_0: coverpoint tx_txcc_p9post_coef_mult_7_0.value[7:0];
    tx_txcc_p9post_coef_mult_15_8: coverpoint tx_txcc_p9post_coef_mult_15_8.value[7:0];
    tx_txcc_p9post_coef_mult_31_16: coverpoint tx_txcc_p9post_coef_mult_31_16.value[15:0];
  endgroup

  protected virtual function void sample(uvm_reg_data_t data, uvm_reg_data_t byte_en, bit is_read, uvm_reg_map map);
    super.sample(data, byte_en, is_read, map);
    if (get_coverage(UVM_CVR_FIELD_VALS)) begin
      if(!is_read) begin
          wr_fld_covg.sample();
      end
      if(is_read) begin
         rd_fld_covg.sample();
      end
    end
  endfunction

  virtual function void sample_values();
    super.sample_values();
    if (get_coverage(UVM_CVR_FIELD_VALS)) begin
      wr_fld_covg.sample();
      rd_fld_covg.sample();
    end
  endfunction

  virtual function void build();
    uvm_reg_field fld_set[$];
    uvm_reg_field_config_ta ta = get_field_config(getconfigUID());
    build_uvm_reg_fields(this, ta, fld_set);
    
    tx_txcc_p9post_coef_mult_7_0 = fld_set[0];
    tx_txcc_p9post_coef_mult_15_8 = fld_set[1];
    tx_txcc_p9post_coef_mult_31_16 = fld_set[2];
  endfunction

  function new(input string name="T_tx_txcc_p9post_coef_mult_615");
    super.new(name, 32, build_coverage(UVM_CVR_FIELD_VALS));
    if (has_coverage(UVM_CVR_FIELD_VALS)) begin
      wr_fld_covg = new();
      rd_fld_covg = new();
    end
  endfunction

endclass


/////////////////////////////////////////////////////
//                tx_txcc_p9pre_coef_mult
/////////////////////////////////////////////////////
class T_tx_txcc_p9pre_coef_mult_604 extends cdns_uvm_reg;

  `uvm_object_utils(T_tx_txcc_p9pre_coef_mult_604)
  rand uvm_reg_field tx_txcc_p9pre_coef_mult_7_0;
  rand uvm_reg_field tx_txcc_p9pre_coef_mult_15_8;
  rand uvm_reg_field tx_txcc_p9pre_coef_mult_31_16;
  
  covergroup wr_fld_covg;
    tx_txcc_p9pre_coef_mult_7_0: coverpoint tx_txcc_p9pre_coef_mult_7_0.value[7:0];
    tx_txcc_p9pre_coef_mult_15_8: coverpoint tx_txcc_p9pre_coef_mult_15_8.value[7:0];
    tx_txcc_p9pre_coef_mult_31_16: coverpoint tx_txcc_p9pre_coef_mult_31_16.value[15:0];
  endgroup
  covergroup rd_fld_covg;
    tx_txcc_p9pre_coef_mult_7_0: coverpoint tx_txcc_p9pre_coef_mult_7_0.value[7:0];
    tx_txcc_p9pre_coef_mult_15_8: coverpoint tx_txcc_p9pre_coef_mult_15_8.value[7:0];
    tx_txcc_p9pre_coef_mult_31_16: coverpoint tx_txcc_p9pre_coef_mult_31_16.value[15:0];
  endgroup

  protected virtual function void sample(uvm_reg_data_t data, uvm_reg_data_t byte_en, bit is_read, uvm_reg_map map);
    super.sample(data, byte_en, is_read, map);
    if (get_coverage(UVM_CVR_FIELD_VALS)) begin
      if(!is_read) begin
          wr_fld_covg.sample();
      end
      if(is_read) begin
         rd_fld_covg.sample();
      end
    end
  endfunction

  virtual function void sample_values();
    super.sample_values();
    if (get_coverage(UVM_CVR_FIELD_VALS)) begin
      wr_fld_covg.sample();
      rd_fld_covg.sample();
    end
  endfunction

  virtual function void build();
    uvm_reg_field fld_set[$];
    uvm_reg_field_config_ta ta = get_field_config(getconfigUID());
    build_uvm_reg_fields(this, ta, fld_set);
    
    tx_txcc_p9pre_coef_mult_7_0 = fld_set[0];
    tx_txcc_p9pre_coef_mult_15_8 = fld_set[1];
    tx_txcc_p9pre_coef_mult_31_16 = fld_set[2];
  endfunction

  function new(input string name="T_tx_txcc_p9pre_coef_mult_604");
    super.new(name, 32, build_coverage(UVM_CVR_FIELD_VALS));
    if (has_coverage(UVM_CVR_FIELD_VALS)) begin
      wr_fld_covg = new();
      rd_fld_covg = new();
    end
  endfunction

endclass


/////////////////////////////////////////////////////
//                tx_txcc_post_cval
/////////////////////////////////////////////////////
class T_tx_txcc_post_cval_569 extends cdns_uvm_reg;

  `uvm_object_utils(T_tx_txcc_post_cval_569)
  rand uvm_reg_field tx_txcc_post_cval_5_0;
  rand uvm_reg_field tx_txcc_post_cval_15_6;
  rand uvm_reg_field tx_txcc_post_cval_31_16;
  
  covergroup wr_fld_covg;
    tx_txcc_post_cval_5_0: coverpoint tx_txcc_post_cval_5_0.value[5:0];
    tx_txcc_post_cval_15_6: coverpoint tx_txcc_post_cval_15_6.value[9:0];
    tx_txcc_post_cval_31_16: coverpoint tx_txcc_post_cval_31_16.value[15:0];
  endgroup
  covergroup rd_fld_covg;
    tx_txcc_post_cval_5_0: coverpoint tx_txcc_post_cval_5_0.value[5:0];
    tx_txcc_post_cval_15_6: coverpoint tx_txcc_post_cval_15_6.value[9:0];
    tx_txcc_post_cval_31_16: coverpoint tx_txcc_post_cval_31_16.value[15:0];
  endgroup

  protected virtual function void sample(uvm_reg_data_t data, uvm_reg_data_t byte_en, bit is_read, uvm_reg_map map);
    super.sample(data, byte_en, is_read, map);
    if (get_coverage(UVM_CVR_FIELD_VALS)) begin
      if(!is_read) begin
          wr_fld_covg.sample();
      end
      if(is_read) begin
         rd_fld_covg.sample();
      end
    end
  endfunction

  virtual function void sample_values();
    super.sample_values();
    if (get_coverage(UVM_CVR_FIELD_VALS)) begin
      wr_fld_covg.sample();
      rd_fld_covg.sample();
    end
  endfunction

  virtual function void build();
    uvm_reg_field fld_set[$];
    uvm_reg_field_config_ta ta = get_field_config(getconfigUID());
    build_uvm_reg_fields(this, ta, fld_set);
    
    tx_txcc_post_cval_5_0 = fld_set[0];
    tx_txcc_post_cval_15_6 = fld_set[1];
    tx_txcc_post_cval_31_16 = fld_set[2];
  endfunction

  function new(input string name="T_tx_txcc_post_cval_569");
    super.new(name, 32, build_coverage(UVM_CVR_FIELD_VALS));
    if (has_coverage(UVM_CVR_FIELD_VALS)) begin
      wr_fld_covg = new();
      rd_fld_covg = new();
    end
  endfunction

endclass


/////////////////////////////////////////////////////
//                tx_txcc_post_ovrd
/////////////////////////////////////////////////////
class T_tx_txcc_post_ovrd_566 extends cdns_uvm_reg;

  `uvm_object_utils(T_tx_txcc_post_ovrd_566)
  rand uvm_reg_field tx_txcc_post_ovrd_5_0;
  rand uvm_reg_field tx_txcc_post_ovrd_7_6;
  rand uvm_reg_field tx_txcc_post_ovrd_8;
  rand uvm_reg_field tx_txcc_post_ovrd_15_9;
  rand uvm_reg_field tx_txcc_post_ovrd_31_16;
  
  covergroup wr_fld_covg;
    tx_txcc_post_ovrd_5_0: coverpoint tx_txcc_post_ovrd_5_0.value[5:0];
    tx_txcc_post_ovrd_7_6: coverpoint tx_txcc_post_ovrd_7_6.value[1:0];
    tx_txcc_post_ovrd_8: coverpoint tx_txcc_post_ovrd_8.value[0:0];
    tx_txcc_post_ovrd_15_9: coverpoint tx_txcc_post_ovrd_15_9.value[6:0];
    tx_txcc_post_ovrd_31_16: coverpoint tx_txcc_post_ovrd_31_16.value[15:0];
  endgroup
  covergroup rd_fld_covg;
    tx_txcc_post_ovrd_5_0: coverpoint tx_txcc_post_ovrd_5_0.value[5:0];
    tx_txcc_post_ovrd_7_6: coverpoint tx_txcc_post_ovrd_7_6.value[1:0];
    tx_txcc_post_ovrd_8: coverpoint tx_txcc_post_ovrd_8.value[0:0];
    tx_txcc_post_ovrd_15_9: coverpoint tx_txcc_post_ovrd_15_9.value[6:0];
    tx_txcc_post_ovrd_31_16: coverpoint tx_txcc_post_ovrd_31_16.value[15:0];
  endgroup

  protected virtual function void sample(uvm_reg_data_t data, uvm_reg_data_t byte_en, bit is_read, uvm_reg_map map);
    super.sample(data, byte_en, is_read, map);
    if (get_coverage(UVM_CVR_FIELD_VALS)) begin
      if(!is_read) begin
          wr_fld_covg.sample();
      end
      if(is_read) begin
         rd_fld_covg.sample();
      end
    end
  endfunction

  virtual function void sample_values();
    super.sample_values();
    if (get_coverage(UVM_CVR_FIELD_VALS)) begin
      wr_fld_covg.sample();
      rd_fld_covg.sample();
    end
  endfunction

  virtual function void build();
    uvm_reg_field fld_set[$];
    uvm_reg_field_config_ta ta = get_field_config(getconfigUID());
    build_uvm_reg_fields(this, ta, fld_set);
    
    tx_txcc_post_ovrd_5_0 = fld_set[0];
    tx_txcc_post_ovrd_7_6 = fld_set[1];
    tx_txcc_post_ovrd_8 = fld_set[2];
    tx_txcc_post_ovrd_15_9 = fld_set[3];
    tx_txcc_post_ovrd_31_16 = fld_set[4];
  endfunction

  function new(input string name="T_tx_txcc_post_ovrd_566");
    super.new(name, 32, build_coverage(UVM_CVR_FIELD_VALS));
    if (has_coverage(UVM_CVR_FIELD_VALS)) begin
      wr_fld_covg = new();
      rd_fld_covg = new();
    end
  endfunction

endclass


/////////////////////////////////////////////////////
//                tx_txcc_pre_cval
/////////////////////////////////////////////////////
class T_tx_txcc_pre_cval_567 extends cdns_uvm_reg;

  `uvm_object_utils(T_tx_txcc_pre_cval_567)
  rand uvm_reg_field tx_txcc_pre_cval_5_0;
  rand uvm_reg_field tx_txcc_pre_cval_15_6;
  rand uvm_reg_field tx_txcc_pre_cval_31_16;
  
  covergroup wr_fld_covg;
    tx_txcc_pre_cval_5_0: coverpoint tx_txcc_pre_cval_5_0.value[5:0];
    tx_txcc_pre_cval_15_6: coverpoint tx_txcc_pre_cval_15_6.value[9:0];
    tx_txcc_pre_cval_31_16: coverpoint tx_txcc_pre_cval_31_16.value[15:0];
  endgroup
  covergroup rd_fld_covg;
    tx_txcc_pre_cval_5_0: coverpoint tx_txcc_pre_cval_5_0.value[5:0];
    tx_txcc_pre_cval_15_6: coverpoint tx_txcc_pre_cval_15_6.value[9:0];
    tx_txcc_pre_cval_31_16: coverpoint tx_txcc_pre_cval_31_16.value[15:0];
  endgroup

  protected virtual function void sample(uvm_reg_data_t data, uvm_reg_data_t byte_en, bit is_read, uvm_reg_map map);
    super.sample(data, byte_en, is_read, map);
    if (get_coverage(UVM_CVR_FIELD_VALS)) begin
      if(!is_read) begin
          wr_fld_covg.sample();
      end
      if(is_read) begin
         rd_fld_covg.sample();
      end
    end
  endfunction

  virtual function void sample_values();
    super.sample_values();
    if (get_coverage(UVM_CVR_FIELD_VALS)) begin
      wr_fld_covg.sample();
      rd_fld_covg.sample();
    end
  endfunction

  virtual function void build();
    uvm_reg_field fld_set[$];
    uvm_reg_field_config_ta ta = get_field_config(getconfigUID());
    build_uvm_reg_fields(this, ta, fld_set);
    
    tx_txcc_pre_cval_5_0 = fld_set[0];
    tx_txcc_pre_cval_15_6 = fld_set[1];
    tx_txcc_pre_cval_31_16 = fld_set[2];
  endfunction

  function new(input string name="T_tx_txcc_pre_cval_567");
    super.new(name, 32, build_coverage(UVM_CVR_FIELD_VALS));
    if (has_coverage(UVM_CVR_FIELD_VALS)) begin
      wr_fld_covg = new();
      rd_fld_covg = new();
    end
  endfunction

endclass


/////////////////////////////////////////////////////
//                tx_txcc_pre_ovrd
/////////////////////////////////////////////////////
class T_tx_txcc_pre_ovrd_564 extends cdns_uvm_reg;

  `uvm_object_utils(T_tx_txcc_pre_ovrd_564)
  rand uvm_reg_field tx_txcc_pre_ovrd_5_0;
  rand uvm_reg_field tx_txcc_pre_ovrd_7_6;
  rand uvm_reg_field tx_txcc_pre_ovrd_8;
  rand uvm_reg_field tx_txcc_pre_ovrd_15_9;
  rand uvm_reg_field tx_txcc_pre_ovrd_31_16;
  
  covergroup wr_fld_covg;
    tx_txcc_pre_ovrd_5_0: coverpoint tx_txcc_pre_ovrd_5_0.value[5:0];
    tx_txcc_pre_ovrd_7_6: coverpoint tx_txcc_pre_ovrd_7_6.value[1:0];
    tx_txcc_pre_ovrd_8: coverpoint tx_txcc_pre_ovrd_8.value[0:0];
    tx_txcc_pre_ovrd_15_9: coverpoint tx_txcc_pre_ovrd_15_9.value[6:0];
    tx_txcc_pre_ovrd_31_16: coverpoint tx_txcc_pre_ovrd_31_16.value[15:0];
  endgroup
  covergroup rd_fld_covg;
    tx_txcc_pre_ovrd_5_0: coverpoint tx_txcc_pre_ovrd_5_0.value[5:0];
    tx_txcc_pre_ovrd_7_6: coverpoint tx_txcc_pre_ovrd_7_6.value[1:0];
    tx_txcc_pre_ovrd_8: coverpoint tx_txcc_pre_ovrd_8.value[0:0];
    tx_txcc_pre_ovrd_15_9: coverpoint tx_txcc_pre_ovrd_15_9.value[6:0];
    tx_txcc_pre_ovrd_31_16: coverpoint tx_txcc_pre_ovrd_31_16.value[15:0];
  endgroup

  protected virtual function void sample(uvm_reg_data_t data, uvm_reg_data_t byte_en, bit is_read, uvm_reg_map map);
    super.sample(data, byte_en, is_read, map);
    if (get_coverage(UVM_CVR_FIELD_VALS)) begin
      if(!is_read) begin
          wr_fld_covg.sample();
      end
      if(is_read) begin
         rd_fld_covg.sample();
      end
    end
  endfunction

  virtual function void sample_values();
    super.sample_values();
    if (get_coverage(UVM_CVR_FIELD_VALS)) begin
      wr_fld_covg.sample();
      rd_fld_covg.sample();
    end
  endfunction

  virtual function void build();
    uvm_reg_field fld_set[$];
    uvm_reg_field_config_ta ta = get_field_config(getconfigUID());
    build_uvm_reg_fields(this, ta, fld_set);
    
    tx_txcc_pre_ovrd_5_0 = fld_set[0];
    tx_txcc_pre_ovrd_7_6 = fld_set[1];
    tx_txcc_pre_ovrd_8 = fld_set[2];
    tx_txcc_pre_ovrd_15_9 = fld_set[3];
    tx_txcc_pre_ovrd_31_16 = fld_set[4];
  endfunction

  function new(input string name="T_tx_txcc_pre_ovrd_564");
    super.new(name, 32, build_coverage(UVM_CVR_FIELD_VALS));
    if (has_coverage(UVM_CVR_FIELD_VALS)) begin
      wr_fld_covg = new();
      rd_fld_covg = new();
    end
  endfunction

endclass


/////////////////////////////////////////////////////
//                xcvr_diag_bidi_ctrl
/////////////////////////////////////////////////////
class T_xcvr_diag_bidi_ctrl_627 extends cdns_uvm_reg;

  `uvm_object_utils(T_xcvr_diag_bidi_ctrl_627)
  rand uvm_reg_field xcvr_diag_bidi_ctrl_0;
  rand uvm_reg_field xcvr_diag_bidi_ctrl_1;
  rand uvm_reg_field xcvr_diag_bidi_ctrl_15_2;
  rand uvm_reg_field xcvr_diag_bidi_ctrl_31_16;
  
  covergroup wr_fld_covg;
    xcvr_diag_bidi_ctrl_0: coverpoint xcvr_diag_bidi_ctrl_0.value[0:0];
    xcvr_diag_bidi_ctrl_1: coverpoint xcvr_diag_bidi_ctrl_1.value[0:0];
    xcvr_diag_bidi_ctrl_15_2: coverpoint xcvr_diag_bidi_ctrl_15_2.value[13:0];
    xcvr_diag_bidi_ctrl_31_16: coverpoint xcvr_diag_bidi_ctrl_31_16.value[15:0];
  endgroup
  covergroup rd_fld_covg;
    xcvr_diag_bidi_ctrl_0: coverpoint xcvr_diag_bidi_ctrl_0.value[0:0];
    xcvr_diag_bidi_ctrl_1: coverpoint xcvr_diag_bidi_ctrl_1.value[0:0];
    xcvr_diag_bidi_ctrl_15_2: coverpoint xcvr_diag_bidi_ctrl_15_2.value[13:0];
    xcvr_diag_bidi_ctrl_31_16: coverpoint xcvr_diag_bidi_ctrl_31_16.value[15:0];
  endgroup

  protected virtual function void sample(uvm_reg_data_t data, uvm_reg_data_t byte_en, bit is_read, uvm_reg_map map);
    super.sample(data, byte_en, is_read, map);
    if (get_coverage(UVM_CVR_FIELD_VALS)) begin
      if(!is_read) begin
          wr_fld_covg.sample();
      end
      if(is_read) begin
         rd_fld_covg.sample();
      end
    end
  endfunction

  virtual function void sample_values();
    super.sample_values();
    if (get_coverage(UVM_CVR_FIELD_VALS)) begin
      wr_fld_covg.sample();
      rd_fld_covg.sample();
    end
  endfunction

  virtual function void build();
    uvm_reg_field fld_set[$];
    uvm_reg_field_config_ta ta = get_field_config(getconfigUID());
    build_uvm_reg_fields(this, ta, fld_set);
    
    xcvr_diag_bidi_ctrl_0 = fld_set[0];
    xcvr_diag_bidi_ctrl_1 = fld_set[1];
    xcvr_diag_bidi_ctrl_15_2 = fld_set[2];
    xcvr_diag_bidi_ctrl_31_16 = fld_set[3];
  endfunction

  function new(input string name="T_xcvr_diag_bidi_ctrl_627");
    super.new(name, 32, build_coverage(UVM_CVR_FIELD_VALS));
    if (has_coverage(UVM_CVR_FIELD_VALS)) begin
      wr_fld_covg = new();
      rd_fld_covg = new();
    end
  endfunction

endclass


/////////////////////////////////////////////////////
//                xcvr_diag_enb_ana_dcd_test
/////////////////////////////////////////////////////
class T_xcvr_diag_enb_ana_dcd_test_631 extends cdns_uvm_reg;

  `uvm_object_utils(T_xcvr_diag_enb_ana_dcd_test_631)
  rand uvm_reg_field xcvr_diag_enb_ana_dcd_test_0;
  rand uvm_reg_field xcvr_diag_enb_ana_dcd_test_1;
  rand uvm_reg_field xcvr_diag_enb_ana_dcd_test_2;
  rand uvm_reg_field xcvr_diag_enb_ana_dcd_test_3;
  rand uvm_reg_field xcvr_diag_enb_ana_dcd_test_4;
  rand uvm_reg_field xcvr_diag_enb_ana_dcd_test_31_5;
  
  covergroup wr_fld_covg;
    xcvr_diag_enb_ana_dcd_test_0: coverpoint xcvr_diag_enb_ana_dcd_test_0.value[0:0];
    xcvr_diag_enb_ana_dcd_test_1: coverpoint xcvr_diag_enb_ana_dcd_test_1.value[0:0];
    xcvr_diag_enb_ana_dcd_test_2: coverpoint xcvr_diag_enb_ana_dcd_test_2.value[0:0];
    xcvr_diag_enb_ana_dcd_test_3: coverpoint xcvr_diag_enb_ana_dcd_test_3.value[0:0];
    xcvr_diag_enb_ana_dcd_test_4: coverpoint xcvr_diag_enb_ana_dcd_test_4.value[0:0];
    xcvr_diag_enb_ana_dcd_test_31_5: coverpoint xcvr_diag_enb_ana_dcd_test_31_5.value[26:0];
  endgroup
  covergroup rd_fld_covg;
    xcvr_diag_enb_ana_dcd_test_0: coverpoint xcvr_diag_enb_ana_dcd_test_0.value[0:0];
    xcvr_diag_enb_ana_dcd_test_1: coverpoint xcvr_diag_enb_ana_dcd_test_1.value[0:0];
    xcvr_diag_enb_ana_dcd_test_2: coverpoint xcvr_diag_enb_ana_dcd_test_2.value[0:0];
    xcvr_diag_enb_ana_dcd_test_3: coverpoint xcvr_diag_enb_ana_dcd_test_3.value[0:0];
    xcvr_diag_enb_ana_dcd_test_4: coverpoint xcvr_diag_enb_ana_dcd_test_4.value[0:0];
    xcvr_diag_enb_ana_dcd_test_31_5: coverpoint xcvr_diag_enb_ana_dcd_test_31_5.value[26:0];
  endgroup

  protected virtual function void sample(uvm_reg_data_t data, uvm_reg_data_t byte_en, bit is_read, uvm_reg_map map);
    super.sample(data, byte_en, is_read, map);
    if (get_coverage(UVM_CVR_FIELD_VALS)) begin
      if(!is_read) begin
          wr_fld_covg.sample();
      end
      if(is_read) begin
         rd_fld_covg.sample();
      end
    end
  endfunction

  virtual function void sample_values();
    super.sample_values();
    if (get_coverage(UVM_CVR_FIELD_VALS)) begin
      wr_fld_covg.sample();
      rd_fld_covg.sample();
    end
  endfunction

  virtual function void build();
    uvm_reg_field fld_set[$];
    uvm_reg_field_config_ta ta = get_field_config(getconfigUID());
    build_uvm_reg_fields(this, ta, fld_set);
    
    xcvr_diag_enb_ana_dcd_test_0 = fld_set[0];
    xcvr_diag_enb_ana_dcd_test_1 = fld_set[1];
    xcvr_diag_enb_ana_dcd_test_2 = fld_set[2];
    xcvr_diag_enb_ana_dcd_test_3 = fld_set[3];
    xcvr_diag_enb_ana_dcd_test_4 = fld_set[4];
    xcvr_diag_enb_ana_dcd_test_31_5 = fld_set[5];
  endfunction

  function new(input string name="T_xcvr_diag_enb_ana_dcd_test_631");
    super.new(name, 32, build_coverage(UVM_CVR_FIELD_VALS));
    if (has_coverage(UVM_CVR_FIELD_VALS)) begin
      wr_fld_covg = new();
      rd_fld_covg = new();
    end
  endfunction

endclass


/////////////////////////////////////////////////////
//                xcvr_diag_hsclk_div
/////////////////////////////////////////////////////
class T_xcvr_diag_hsclk_div_624 extends cdns_uvm_reg;

  `uvm_object_utils(T_xcvr_diag_hsclk_div_624)
  rand uvm_reg_field xcvr_diag_hsclk_div_1_0;
  rand uvm_reg_field xcvr_diag_hsclk_div_3_2;
  rand uvm_reg_field xcvr_diag_hsclk_div_5_4;
  rand uvm_reg_field xcvr_diag_hsclk_div_7_6;
  rand uvm_reg_field xcvr_diag_hsclk_div_8;
  rand uvm_reg_field xcvr_diag_hsclk_div_14_9;
  rand uvm_reg_field xcvr_diag_hsclk_div_15;
  rand uvm_reg_field xcvr_diag_hsclk_div_31_16;
  
  covergroup wr_fld_covg;
    xcvr_diag_hsclk_div_1_0: coverpoint xcvr_diag_hsclk_div_1_0.value[1:0];
    xcvr_diag_hsclk_div_3_2: coverpoint xcvr_diag_hsclk_div_3_2.value[1:0];
    xcvr_diag_hsclk_div_5_4: coverpoint xcvr_diag_hsclk_div_5_4.value[1:0];
    xcvr_diag_hsclk_div_7_6: coverpoint xcvr_diag_hsclk_div_7_6.value[1:0];
    xcvr_diag_hsclk_div_8: coverpoint xcvr_diag_hsclk_div_8.value[0:0];
    xcvr_diag_hsclk_div_14_9: coverpoint xcvr_diag_hsclk_div_14_9.value[5:0];
    xcvr_diag_hsclk_div_15: coverpoint xcvr_diag_hsclk_div_15.value[0:0];
    xcvr_diag_hsclk_div_31_16: coverpoint xcvr_diag_hsclk_div_31_16.value[15:0];
  endgroup
  covergroup rd_fld_covg;
    xcvr_diag_hsclk_div_1_0: coverpoint xcvr_diag_hsclk_div_1_0.value[1:0];
    xcvr_diag_hsclk_div_3_2: coverpoint xcvr_diag_hsclk_div_3_2.value[1:0];
    xcvr_diag_hsclk_div_5_4: coverpoint xcvr_diag_hsclk_div_5_4.value[1:0];
    xcvr_diag_hsclk_div_7_6: coverpoint xcvr_diag_hsclk_div_7_6.value[1:0];
    xcvr_diag_hsclk_div_8: coverpoint xcvr_diag_hsclk_div_8.value[0:0];
    xcvr_diag_hsclk_div_14_9: coverpoint xcvr_diag_hsclk_div_14_9.value[5:0];
    xcvr_diag_hsclk_div_15: coverpoint xcvr_diag_hsclk_div_15.value[0:0];
    xcvr_diag_hsclk_div_31_16: coverpoint xcvr_diag_hsclk_div_31_16.value[15:0];
  endgroup

  protected virtual function void sample(uvm_reg_data_t data, uvm_reg_data_t byte_en, bit is_read, uvm_reg_map map);
    super.sample(data, byte_en, is_read, map);
    if (get_coverage(UVM_CVR_FIELD_VALS)) begin
      if(!is_read) begin
          wr_fld_covg.sample();
      end
      if(is_read) begin
         rd_fld_covg.sample();
      end
    end
  endfunction

  virtual function void sample_values();
    super.sample_values();
    if (get_coverage(UVM_CVR_FIELD_VALS)) begin
      wr_fld_covg.sample();
      rd_fld_covg.sample();
    end
  endfunction

  virtual function void build();
    uvm_reg_field fld_set[$];
    uvm_reg_field_config_ta ta = get_field_config(getconfigUID());
    build_uvm_reg_fields(this, ta, fld_set);
    
    xcvr_diag_hsclk_div_1_0 = fld_set[0];
    xcvr_diag_hsclk_div_3_2 = fld_set[1];
    xcvr_diag_hsclk_div_5_4 = fld_set[2];
    xcvr_diag_hsclk_div_7_6 = fld_set[3];
    xcvr_diag_hsclk_div_8 = fld_set[4];
    xcvr_diag_hsclk_div_14_9 = fld_set[5];
    xcvr_diag_hsclk_div_15 = fld_set[6];
    xcvr_diag_hsclk_div_31_16 = fld_set[7];
  endfunction

  function new(input string name="T_xcvr_diag_hsclk_div_624");
    super.new(name, 32, build_coverage(UVM_CVR_FIELD_VALS));
    if (has_coverage(UVM_CVR_FIELD_VALS)) begin
      wr_fld_covg = new();
      rd_fld_covg = new();
    end
  endfunction

endclass


/////////////////////////////////////////////////////
//                xcvr_diag_hsclk_sel
/////////////////////////////////////////////////////
class T_xcvr_diag_hsclk_sel_623 extends cdns_uvm_reg;

  `uvm_object_utils(T_xcvr_diag_hsclk_sel_623)
  rand uvm_reg_field xcvr_diag_hsclk_sel_1_0;
  rand uvm_reg_field xcvr_diag_hsclk_sel_3_2;
  rand uvm_reg_field xcvr_diag_hsclk_sel_5_4;
  rand uvm_reg_field xcvr_diag_hsclk_sel_7_6;
  rand uvm_reg_field xcvr_diag_hsclk_sel_9_8;
  rand uvm_reg_field xcvr_diag_hsclk_sel_11_10;
  rand uvm_reg_field xcvr_diag_hsclk_sel_13_12;
  rand uvm_reg_field xcvr_diag_hsclk_sel_15_14;
  rand uvm_reg_field xcvr_diag_hsclk_sel_31_16;
  
  covergroup wr_fld_covg;
    xcvr_diag_hsclk_sel_1_0: coverpoint xcvr_diag_hsclk_sel_1_0.value[1:0];
    xcvr_diag_hsclk_sel_3_2: coverpoint xcvr_diag_hsclk_sel_3_2.value[1:0];
    xcvr_diag_hsclk_sel_5_4: coverpoint xcvr_diag_hsclk_sel_5_4.value[1:0];
    xcvr_diag_hsclk_sel_7_6: coverpoint xcvr_diag_hsclk_sel_7_6.value[1:0];
    xcvr_diag_hsclk_sel_9_8: coverpoint xcvr_diag_hsclk_sel_9_8.value[1:0];
    xcvr_diag_hsclk_sel_11_10: coverpoint xcvr_diag_hsclk_sel_11_10.value[1:0];
    xcvr_diag_hsclk_sel_13_12: coverpoint xcvr_diag_hsclk_sel_13_12.value[1:0];
    xcvr_diag_hsclk_sel_15_14: coverpoint xcvr_diag_hsclk_sel_15_14.value[1:0];
    xcvr_diag_hsclk_sel_31_16: coverpoint xcvr_diag_hsclk_sel_31_16.value[15:0];
  endgroup
  covergroup rd_fld_covg;
    xcvr_diag_hsclk_sel_1_0: coverpoint xcvr_diag_hsclk_sel_1_0.value[1:0];
    xcvr_diag_hsclk_sel_3_2: coverpoint xcvr_diag_hsclk_sel_3_2.value[1:0];
    xcvr_diag_hsclk_sel_5_4: coverpoint xcvr_diag_hsclk_sel_5_4.value[1:0];
    xcvr_diag_hsclk_sel_7_6: coverpoint xcvr_diag_hsclk_sel_7_6.value[1:0];
    xcvr_diag_hsclk_sel_9_8: coverpoint xcvr_diag_hsclk_sel_9_8.value[1:0];
    xcvr_diag_hsclk_sel_11_10: coverpoint xcvr_diag_hsclk_sel_11_10.value[1:0];
    xcvr_diag_hsclk_sel_13_12: coverpoint xcvr_diag_hsclk_sel_13_12.value[1:0];
    xcvr_diag_hsclk_sel_15_14: coverpoint xcvr_diag_hsclk_sel_15_14.value[1:0];
    xcvr_diag_hsclk_sel_31_16: coverpoint xcvr_diag_hsclk_sel_31_16.value[15:0];
  endgroup

  protected virtual function void sample(uvm_reg_data_t data, uvm_reg_data_t byte_en, bit is_read, uvm_reg_map map);
    super.sample(data, byte_en, is_read, map);
    if (get_coverage(UVM_CVR_FIELD_VALS)) begin
      if(!is_read) begin
          wr_fld_covg.sample();
      end
      if(is_read) begin
         rd_fld_covg.sample();
      end
    end
  endfunction

  virtual function void sample_values();
    super.sample_values();
    if (get_coverage(UVM_CVR_FIELD_VALS)) begin
      wr_fld_covg.sample();
      rd_fld_covg.sample();
    end
  endfunction

  virtual function void build();
    uvm_reg_field fld_set[$];
    uvm_reg_field_config_ta ta = get_field_config(getconfigUID());
    build_uvm_reg_fields(this, ta, fld_set);
    
    xcvr_diag_hsclk_sel_1_0 = fld_set[0];
    xcvr_diag_hsclk_sel_3_2 = fld_set[1];
    xcvr_diag_hsclk_sel_5_4 = fld_set[2];
    xcvr_diag_hsclk_sel_7_6 = fld_set[3];
    xcvr_diag_hsclk_sel_9_8 = fld_set[4];
    xcvr_diag_hsclk_sel_11_10 = fld_set[5];
    xcvr_diag_hsclk_sel_13_12 = fld_set[6];
    xcvr_diag_hsclk_sel_15_14 = fld_set[7];
    xcvr_diag_hsclk_sel_31_16 = fld_set[8];
  endfunction

  function new(input string name="T_xcvr_diag_hsclk_sel_623");
    super.new(name, 32, build_coverage(UVM_CVR_FIELD_VALS));
    if (has_coverage(UVM_CVR_FIELD_VALS)) begin
      wr_fld_covg = new();
      rd_fld_covg = new();
    end
  endfunction

endclass


/////////////////////////////////////////////////////
//                xcvr_diag_plldrc_ctrl
/////////////////////////////////////////////////////
class T_xcvr_diag_plldrc_ctrl_622 extends cdns_uvm_reg;

  `uvm_object_utils(T_xcvr_diag_plldrc_ctrl_622)
  rand uvm_reg_field xcvr_diag_plldrc_ctrl_1_0;
  rand uvm_reg_field xcvr_diag_plldrc_ctrl_3_2;
  rand uvm_reg_field xcvr_diag_plldrc_ctrl_5_4;
  rand uvm_reg_field xcvr_diag_plldrc_ctrl_7_6;
  rand uvm_reg_field xcvr_diag_plldrc_ctrl_9_8;
  rand uvm_reg_field xcvr_diag_plldrc_ctrl_11_10;
  rand uvm_reg_field xcvr_diag_plldrc_ctrl_13_12;
  rand uvm_reg_field xcvr_diag_plldrc_ctrl_15_14;
  rand uvm_reg_field xcvr_diag_plldrc_ctrl_31_16;
  
  covergroup wr_fld_covg;
    xcvr_diag_plldrc_ctrl_1_0: coverpoint xcvr_diag_plldrc_ctrl_1_0.value[1:0];
    xcvr_diag_plldrc_ctrl_3_2: coverpoint xcvr_diag_plldrc_ctrl_3_2.value[1:0];
    xcvr_diag_plldrc_ctrl_5_4: coverpoint xcvr_diag_plldrc_ctrl_5_4.value[1:0];
    xcvr_diag_plldrc_ctrl_7_6: coverpoint xcvr_diag_plldrc_ctrl_7_6.value[1:0];
    xcvr_diag_plldrc_ctrl_9_8: coverpoint xcvr_diag_plldrc_ctrl_9_8.value[1:0];
    xcvr_diag_plldrc_ctrl_11_10: coverpoint xcvr_diag_plldrc_ctrl_11_10.value[1:0];
    xcvr_diag_plldrc_ctrl_13_12: coverpoint xcvr_diag_plldrc_ctrl_13_12.value[1:0];
    xcvr_diag_plldrc_ctrl_15_14: coverpoint xcvr_diag_plldrc_ctrl_15_14.value[1:0];
    xcvr_diag_plldrc_ctrl_31_16: coverpoint xcvr_diag_plldrc_ctrl_31_16.value[15:0];
  endgroup
  covergroup rd_fld_covg;
    xcvr_diag_plldrc_ctrl_1_0: coverpoint xcvr_diag_plldrc_ctrl_1_0.value[1:0];
    xcvr_diag_plldrc_ctrl_3_2: coverpoint xcvr_diag_plldrc_ctrl_3_2.value[1:0];
    xcvr_diag_plldrc_ctrl_5_4: coverpoint xcvr_diag_plldrc_ctrl_5_4.value[1:0];
    xcvr_diag_plldrc_ctrl_7_6: coverpoint xcvr_diag_plldrc_ctrl_7_6.value[1:0];
    xcvr_diag_plldrc_ctrl_9_8: coverpoint xcvr_diag_plldrc_ctrl_9_8.value[1:0];
    xcvr_diag_plldrc_ctrl_11_10: coverpoint xcvr_diag_plldrc_ctrl_11_10.value[1:0];
    xcvr_diag_plldrc_ctrl_13_12: coverpoint xcvr_diag_plldrc_ctrl_13_12.value[1:0];
    xcvr_diag_plldrc_ctrl_15_14: coverpoint xcvr_diag_plldrc_ctrl_15_14.value[1:0];
    xcvr_diag_plldrc_ctrl_31_16: coverpoint xcvr_diag_plldrc_ctrl_31_16.value[15:0];
  endgroup

  protected virtual function void sample(uvm_reg_data_t data, uvm_reg_data_t byte_en, bit is_read, uvm_reg_map map);
    super.sample(data, byte_en, is_read, map);
    if (get_coverage(UVM_CVR_FIELD_VALS)) begin
      if(!is_read) begin
          wr_fld_covg.sample();
      end
      if(is_read) begin
         rd_fld_covg.sample();
      end
    end
  endfunction

  virtual function void sample_values();
    super.sample_values();
    if (get_coverage(UVM_CVR_FIELD_VALS)) begin
      wr_fld_covg.sample();
      rd_fld_covg.sample();
    end
  endfunction

  virtual function void build();
    uvm_reg_field fld_set[$];
    uvm_reg_field_config_ta ta = get_field_config(getconfigUID());
    build_uvm_reg_fields(this, ta, fld_set);
    
    xcvr_diag_plldrc_ctrl_1_0 = fld_set[0];
    xcvr_diag_plldrc_ctrl_3_2 = fld_set[1];
    xcvr_diag_plldrc_ctrl_5_4 = fld_set[2];
    xcvr_diag_plldrc_ctrl_7_6 = fld_set[3];
    xcvr_diag_plldrc_ctrl_9_8 = fld_set[4];
    xcvr_diag_plldrc_ctrl_11_10 = fld_set[5];
    xcvr_diag_plldrc_ctrl_13_12 = fld_set[6];
    xcvr_diag_plldrc_ctrl_15_14 = fld_set[7];
    xcvr_diag_plldrc_ctrl_31_16 = fld_set[8];
  endfunction

  function new(input string name="T_xcvr_diag_plldrc_ctrl_622");
    super.new(name, 32, build_coverage(UVM_CVR_FIELD_VALS));
    if (has_coverage(UVM_CVR_FIELD_VALS)) begin
      wr_fld_covg = new();
      rd_fld_covg = new();
    end
  endfunction

endclass


/////////////////////////////////////////////////////
//                xcvr_diag_psc_ovrd
/////////////////////////////////////////////////////
class T_xcvr_diag_psc_ovrd_628 extends cdns_uvm_reg;

  `uvm_object_utils(T_xcvr_diag_psc_ovrd_628)
  rand uvm_reg_field xcvr_diag_psc_ovrd_0;
  rand uvm_reg_field xcvr_diag_psc_ovrd_1;
  rand uvm_reg_field xcvr_diag_psc_ovrd_2;
  rand uvm_reg_field xcvr_diag_psc_ovrd_3;
  rand uvm_reg_field xcvr_diag_psc_ovrd_4;
  rand uvm_reg_field xcvr_diag_psc_ovrd_15_5;
  rand uvm_reg_field xcvr_diag_psc_ovrd_31_16;
  
  covergroup wr_fld_covg;
    xcvr_diag_psc_ovrd_0: coverpoint xcvr_diag_psc_ovrd_0.value[0:0];
    xcvr_diag_psc_ovrd_1: coverpoint xcvr_diag_psc_ovrd_1.value[0:0];
    xcvr_diag_psc_ovrd_2: coverpoint xcvr_diag_psc_ovrd_2.value[0:0];
    xcvr_diag_psc_ovrd_3: coverpoint xcvr_diag_psc_ovrd_3.value[0:0];
    xcvr_diag_psc_ovrd_4: coverpoint xcvr_diag_psc_ovrd_4.value[0:0];
    xcvr_diag_psc_ovrd_15_5: coverpoint xcvr_diag_psc_ovrd_15_5.value[10:0];
    xcvr_diag_psc_ovrd_31_16: coverpoint xcvr_diag_psc_ovrd_31_16.value[15:0];
  endgroup
  covergroup rd_fld_covg;
    xcvr_diag_psc_ovrd_0: coverpoint xcvr_diag_psc_ovrd_0.value[0:0];
    xcvr_diag_psc_ovrd_1: coverpoint xcvr_diag_psc_ovrd_1.value[0:0];
    xcvr_diag_psc_ovrd_2: coverpoint xcvr_diag_psc_ovrd_2.value[0:0];
    xcvr_diag_psc_ovrd_3: coverpoint xcvr_diag_psc_ovrd_3.value[0:0];
    xcvr_diag_psc_ovrd_4: coverpoint xcvr_diag_psc_ovrd_4.value[0:0];
    xcvr_diag_psc_ovrd_15_5: coverpoint xcvr_diag_psc_ovrd_15_5.value[10:0];
    xcvr_diag_psc_ovrd_31_16: coverpoint xcvr_diag_psc_ovrd_31_16.value[15:0];
  endgroup

  protected virtual function void sample(uvm_reg_data_t data, uvm_reg_data_t byte_en, bit is_read, uvm_reg_map map);
    super.sample(data, byte_en, is_read, map);
    if (get_coverage(UVM_CVR_FIELD_VALS)) begin
      if(!is_read) begin
          wr_fld_covg.sample();
      end
      if(is_read) begin
         rd_fld_covg.sample();
      end
    end
  endfunction

  virtual function void sample_values();
    super.sample_values();
    if (get_coverage(UVM_CVR_FIELD_VALS)) begin
      wr_fld_covg.sample();
      rd_fld_covg.sample();
    end
  endfunction

  virtual function void build();
    uvm_reg_field fld_set[$];
    uvm_reg_field_config_ta ta = get_field_config(getconfigUID());
    build_uvm_reg_fields(this, ta, fld_set);
    
    xcvr_diag_psc_ovrd_0 = fld_set[0];
    xcvr_diag_psc_ovrd_1 = fld_set[1];
    xcvr_diag_psc_ovrd_2 = fld_set[2];
    xcvr_diag_psc_ovrd_3 = fld_set[3];
    xcvr_diag_psc_ovrd_4 = fld_set[4];
    xcvr_diag_psc_ovrd_15_5 = fld_set[5];
    xcvr_diag_psc_ovrd_31_16 = fld_set[6];
  endfunction

  function new(input string name="T_xcvr_diag_psc_ovrd_628");
    super.new(name, 32, build_coverage(UVM_CVR_FIELD_VALS));
    if (has_coverage(UVM_CVR_FIELD_VALS)) begin
      wr_fld_covg = new();
      rd_fld_covg = new();
    end
  endfunction

endclass


/////////////////////////////////////////////////////
//                xcvr_diag_pwri_tmr
/////////////////////////////////////////////////////
class T_xcvr_diag_pwri_tmr_617 extends cdns_uvm_reg;

  `uvm_object_utils(T_xcvr_diag_pwri_tmr_617)
  rand uvm_reg_field xcvr_diag_pwri_tmr_4_0;
  rand uvm_reg_field xcvr_diag_pwri_tmr_7_5;
  rand uvm_reg_field xcvr_diag_pwri_tmr_12_8;
  rand uvm_reg_field xcvr_diag_pwri_tmr_15_13;
  rand uvm_reg_field xcvr_diag_pwri_tmr_31_16;
  
  covergroup wr_fld_covg;
    xcvr_diag_pwri_tmr_4_0: coverpoint xcvr_diag_pwri_tmr_4_0.value[4:0];
    xcvr_diag_pwri_tmr_7_5: coverpoint xcvr_diag_pwri_tmr_7_5.value[2:0];
    xcvr_diag_pwri_tmr_12_8: coverpoint xcvr_diag_pwri_tmr_12_8.value[4:0];
    xcvr_diag_pwri_tmr_15_13: coverpoint xcvr_diag_pwri_tmr_15_13.value[2:0];
    xcvr_diag_pwri_tmr_31_16: coverpoint xcvr_diag_pwri_tmr_31_16.value[15:0];
  endgroup
  covergroup rd_fld_covg;
    xcvr_diag_pwri_tmr_4_0: coverpoint xcvr_diag_pwri_tmr_4_0.value[4:0];
    xcvr_diag_pwri_tmr_7_5: coverpoint xcvr_diag_pwri_tmr_7_5.value[2:0];
    xcvr_diag_pwri_tmr_12_8: coverpoint xcvr_diag_pwri_tmr_12_8.value[4:0];
    xcvr_diag_pwri_tmr_15_13: coverpoint xcvr_diag_pwri_tmr_15_13.value[2:0];
    xcvr_diag_pwri_tmr_31_16: coverpoint xcvr_diag_pwri_tmr_31_16.value[15:0];
  endgroup

  protected virtual function void sample(uvm_reg_data_t data, uvm_reg_data_t byte_en, bit is_read, uvm_reg_map map);
    super.sample(data, byte_en, is_read, map);
    if (get_coverage(UVM_CVR_FIELD_VALS)) begin
      if(!is_read) begin
          wr_fld_covg.sample();
      end
      if(is_read) begin
         rd_fld_covg.sample();
      end
    end
  endfunction

  virtual function void sample_values();
    super.sample_values();
    if (get_coverage(UVM_CVR_FIELD_VALS)) begin
      wr_fld_covg.sample();
      rd_fld_covg.sample();
    end
  endfunction

  virtual function void build();
    uvm_reg_field fld_set[$];
    uvm_reg_field_config_ta ta = get_field_config(getconfigUID());
    build_uvm_reg_fields(this, ta, fld_set);
    
    xcvr_diag_pwri_tmr_4_0 = fld_set[0];
    xcvr_diag_pwri_tmr_7_5 = fld_set[1];
    xcvr_diag_pwri_tmr_12_8 = fld_set[2];
    xcvr_diag_pwri_tmr_15_13 = fld_set[3];
    xcvr_diag_pwri_tmr_31_16 = fld_set[4];
  endfunction

  function new(input string name="T_xcvr_diag_pwri_tmr_617");
    super.new(name, 32, build_coverage(UVM_CVR_FIELD_VALS));
    if (has_coverage(UVM_CVR_FIELD_VALS)) begin
      wr_fld_covg = new();
      rd_fld_covg = new();
    end
  endfunction

endclass


/////////////////////////////////////////////////////
//                xcvr_diag_rst_diag
/////////////////////////////////////////////////////
class T_xcvr_diag_rst_diag_629 extends cdns_uvm_reg;

  `uvm_object_utils(T_xcvr_diag_rst_diag_629)
  rand uvm_reg_field xcvr_diag_rst_diag_0;
  rand uvm_reg_field xcvr_diag_rst_diag_1;
  rand uvm_reg_field xcvr_diag_rst_diag_2;
  rand uvm_reg_field xcvr_diag_rst_diag_15_3;
  rand uvm_reg_field xcvr_diag_rst_diag_31_16;
  
  covergroup wr_fld_covg;
    xcvr_diag_rst_diag_0: coverpoint xcvr_diag_rst_diag_0.value[0:0];
    xcvr_diag_rst_diag_1: coverpoint xcvr_diag_rst_diag_1.value[0:0];
    xcvr_diag_rst_diag_2: coverpoint xcvr_diag_rst_diag_2.value[0:0];
    xcvr_diag_rst_diag_15_3: coverpoint xcvr_diag_rst_diag_15_3.value[12:0];
    xcvr_diag_rst_diag_31_16: coverpoint xcvr_diag_rst_diag_31_16.value[15:0];
  endgroup
  covergroup rd_fld_covg;
    xcvr_diag_rst_diag_0: coverpoint xcvr_diag_rst_diag_0.value[0:0];
    xcvr_diag_rst_diag_1: coverpoint xcvr_diag_rst_diag_1.value[0:0];
    xcvr_diag_rst_diag_2: coverpoint xcvr_diag_rst_diag_2.value[0:0];
    xcvr_diag_rst_diag_15_3: coverpoint xcvr_diag_rst_diag_15_3.value[12:0];
    xcvr_diag_rst_diag_31_16: coverpoint xcvr_diag_rst_diag_31_16.value[15:0];
  endgroup

  protected virtual function void sample(uvm_reg_data_t data, uvm_reg_data_t byte_en, bit is_read, uvm_reg_map map);
    super.sample(data, byte_en, is_read, map);
    if (get_coverage(UVM_CVR_FIELD_VALS)) begin
      if(!is_read) begin
          wr_fld_covg.sample();
      end
      if(is_read) begin
         rd_fld_covg.sample();
      end
    end
  endfunction

  virtual function void sample_values();
    super.sample_values();
    if (get_coverage(UVM_CVR_FIELD_VALS)) begin
      wr_fld_covg.sample();
      rd_fld_covg.sample();
    end
  endfunction

  virtual function void build();
    uvm_reg_field fld_set[$];
    uvm_reg_field_config_ta ta = get_field_config(getconfigUID());
    build_uvm_reg_fields(this, ta, fld_set);
    
    xcvr_diag_rst_diag_0 = fld_set[0];
    xcvr_diag_rst_diag_1 = fld_set[1];
    xcvr_diag_rst_diag_2 = fld_set[2];
    xcvr_diag_rst_diag_15_3 = fld_set[3];
    xcvr_diag_rst_diag_31_16 = fld_set[4];
  endfunction

  function new(input string name="T_xcvr_diag_rst_diag_629");
    super.new(name, 32, build_coverage(UVM_CVR_FIELD_VALS));
    if (has_coverage(UVM_CVR_FIELD_VALS)) begin
      wr_fld_covg = new();
      rd_fld_covg = new();
    end
  endfunction

endclass


/////////////////////////////////////////////////////
//                xcvr_diag_rxclk_ctrl
/////////////////////////////////////////////////////
class T_xcvr_diag_rxclk_ctrl_626 extends cdns_uvm_reg;

  `uvm_object_utils(T_xcvr_diag_rxclk_ctrl_626)
  rand uvm_reg_field xcvr_diag_rxclk_ctrl_14_0;
  rand uvm_reg_field xcvr_diag_rxclk_ctrl_15;
  rand uvm_reg_field xcvr_diag_rxclk_ctrl_31_16;
  
  covergroup wr_fld_covg;
    xcvr_diag_rxclk_ctrl_14_0: coverpoint xcvr_diag_rxclk_ctrl_14_0.value[14:0];
    xcvr_diag_rxclk_ctrl_15: coverpoint xcvr_diag_rxclk_ctrl_15.value[0:0];
    xcvr_diag_rxclk_ctrl_31_16: coverpoint xcvr_diag_rxclk_ctrl_31_16.value[15:0];
  endgroup
  covergroup rd_fld_covg;
    xcvr_diag_rxclk_ctrl_14_0: coverpoint xcvr_diag_rxclk_ctrl_14_0.value[14:0];
    xcvr_diag_rxclk_ctrl_15: coverpoint xcvr_diag_rxclk_ctrl_15.value[0:0];
    xcvr_diag_rxclk_ctrl_31_16: coverpoint xcvr_diag_rxclk_ctrl_31_16.value[15:0];
  endgroup

  protected virtual function void sample(uvm_reg_data_t data, uvm_reg_data_t byte_en, bit is_read, uvm_reg_map map);
    super.sample(data, byte_en, is_read, map);
    if (get_coverage(UVM_CVR_FIELD_VALS)) begin
      if(!is_read) begin
          wr_fld_covg.sample();
      end
      if(is_read) begin
         rd_fld_covg.sample();
      end
    end
  endfunction

  virtual function void sample_values();
    super.sample_values();
    if (get_coverage(UVM_CVR_FIELD_VALS)) begin
      wr_fld_covg.sample();
      rd_fld_covg.sample();
    end
  endfunction

  virtual function void build();
    uvm_reg_field fld_set[$];
    uvm_reg_field_config_ta ta = get_field_config(getconfigUID());
    build_uvm_reg_fields(this, ta, fld_set);
    
    xcvr_diag_rxclk_ctrl_14_0 = fld_set[0];
    xcvr_diag_rxclk_ctrl_15 = fld_set[1];
    xcvr_diag_rxclk_ctrl_31_16 = fld_set[2];
  endfunction

  function new(input string name="T_xcvr_diag_rxclk_ctrl_626");
    super.new(name, 32, build_coverage(UVM_CVR_FIELD_VALS));
    if (has_coverage(UVM_CVR_FIELD_VALS)) begin
      wr_fld_covg = new();
      rd_fld_covg = new();
    end
  endfunction

endclass


/////////////////////////////////////////////////////
//                xcvr_diag_txclk_ctrl
/////////////////////////////////////////////////////
class T_xcvr_diag_txclk_ctrl_625 extends cdns_uvm_reg;

  `uvm_object_utils(T_xcvr_diag_txclk_ctrl_625)
  rand uvm_reg_field xcvr_diag_txclk_ctrl_14_0;
  rand uvm_reg_field xcvr_diag_txclk_ctrl_15;
  rand uvm_reg_field xcvr_diag_txclk_ctrl_31_16;
  
  covergroup wr_fld_covg;
    xcvr_diag_txclk_ctrl_14_0: coverpoint xcvr_diag_txclk_ctrl_14_0.value[14:0];
    xcvr_diag_txclk_ctrl_15: coverpoint xcvr_diag_txclk_ctrl_15.value[0:0];
    xcvr_diag_txclk_ctrl_31_16: coverpoint xcvr_diag_txclk_ctrl_31_16.value[15:0];
  endgroup
  covergroup rd_fld_covg;
    xcvr_diag_txclk_ctrl_14_0: coverpoint xcvr_diag_txclk_ctrl_14_0.value[14:0];
    xcvr_diag_txclk_ctrl_15: coverpoint xcvr_diag_txclk_ctrl_15.value[0:0];
    xcvr_diag_txclk_ctrl_31_16: coverpoint xcvr_diag_txclk_ctrl_31_16.value[15:0];
  endgroup

  protected virtual function void sample(uvm_reg_data_t data, uvm_reg_data_t byte_en, bit is_read, uvm_reg_map map);
    super.sample(data, byte_en, is_read, map);
    if (get_coverage(UVM_CVR_FIELD_VALS)) begin
      if(!is_read) begin
          wr_fld_covg.sample();
      end
      if(is_read) begin
         rd_fld_covg.sample();
      end
    end
  endfunction

  virtual function void sample_values();
    super.sample_values();
    if (get_coverage(UVM_CVR_FIELD_VALS)) begin
      wr_fld_covg.sample();
      rd_fld_covg.sample();
    end
  endfunction

  virtual function void build();
    uvm_reg_field fld_set[$];
    uvm_reg_field_config_ta ta = get_field_config(getconfigUID());
    build_uvm_reg_fields(this, ta, fld_set);
    
    xcvr_diag_txclk_ctrl_14_0 = fld_set[0];
    xcvr_diag_txclk_ctrl_15 = fld_set[1];
    xcvr_diag_txclk_ctrl_31_16 = fld_set[2];
  endfunction

  function new(input string name="T_xcvr_diag_txclk_ctrl_625");
    super.new(name, 32, build_coverage(UVM_CVR_FIELD_VALS));
    if (has_coverage(UVM_CVR_FIELD_VALS)) begin
      wr_fld_covg = new();
      rd_fld_covg = new();
    end
  endfunction

endclass


/////////////////////////////////////////////////////
//                xcvr_diag_xcal_pwri_ovrd
/////////////////////////////////////////////////////
class T_xcvr_diag_xcal_pwri_ovrd_618 extends cdns_uvm_reg;

  `uvm_object_utils(T_xcvr_diag_xcal_pwri_ovrd_618)
  rand uvm_reg_field xcvr_diag_xcal_pwri_ovrd_7_0;
  rand uvm_reg_field xcvr_diag_xcal_pwri_ovrd_8;
  rand uvm_reg_field xcvr_diag_xcal_pwri_ovrd_9;
  rand uvm_reg_field xcvr_diag_xcal_pwri_ovrd_10;
  rand uvm_reg_field xcvr_diag_xcal_pwri_ovrd_11;
  rand uvm_reg_field xcvr_diag_xcal_pwri_ovrd_13_12;
  rand uvm_reg_field xcvr_diag_xcal_pwri_ovrd_14;
  rand uvm_reg_field xcvr_diag_xcal_pwri_ovrd_15;
  rand uvm_reg_field xcvr_diag_xcal_pwri_ovrd_31_16;
  
  covergroup wr_fld_covg;
    xcvr_diag_xcal_pwri_ovrd_7_0: coverpoint xcvr_diag_xcal_pwri_ovrd_7_0.value[7:0];
    xcvr_diag_xcal_pwri_ovrd_8: coverpoint xcvr_diag_xcal_pwri_ovrd_8.value[0:0];
    xcvr_diag_xcal_pwri_ovrd_9: coverpoint xcvr_diag_xcal_pwri_ovrd_9.value[0:0];
    xcvr_diag_xcal_pwri_ovrd_10: coverpoint xcvr_diag_xcal_pwri_ovrd_10.value[0:0];
    xcvr_diag_xcal_pwri_ovrd_11: coverpoint xcvr_diag_xcal_pwri_ovrd_11.value[0:0];
    xcvr_diag_xcal_pwri_ovrd_13_12: coverpoint xcvr_diag_xcal_pwri_ovrd_13_12.value[1:0];
    xcvr_diag_xcal_pwri_ovrd_14: coverpoint xcvr_diag_xcal_pwri_ovrd_14.value[0:0];
    xcvr_diag_xcal_pwri_ovrd_15: coverpoint xcvr_diag_xcal_pwri_ovrd_15.value[0:0];
    xcvr_diag_xcal_pwri_ovrd_31_16: coverpoint xcvr_diag_xcal_pwri_ovrd_31_16.value[15:0];
  endgroup
  covergroup rd_fld_covg;
    xcvr_diag_xcal_pwri_ovrd_7_0: coverpoint xcvr_diag_xcal_pwri_ovrd_7_0.value[7:0];
    xcvr_diag_xcal_pwri_ovrd_8: coverpoint xcvr_diag_xcal_pwri_ovrd_8.value[0:0];
    xcvr_diag_xcal_pwri_ovrd_9: coverpoint xcvr_diag_xcal_pwri_ovrd_9.value[0:0];
    xcvr_diag_xcal_pwri_ovrd_10: coverpoint xcvr_diag_xcal_pwri_ovrd_10.value[0:0];
    xcvr_diag_xcal_pwri_ovrd_11: coverpoint xcvr_diag_xcal_pwri_ovrd_11.value[0:0];
    xcvr_diag_xcal_pwri_ovrd_13_12: coverpoint xcvr_diag_xcal_pwri_ovrd_13_12.value[1:0];
    xcvr_diag_xcal_pwri_ovrd_14: coverpoint xcvr_diag_xcal_pwri_ovrd_14.value[0:0];
    xcvr_diag_xcal_pwri_ovrd_15: coverpoint xcvr_diag_xcal_pwri_ovrd_15.value[0:0];
    xcvr_diag_xcal_pwri_ovrd_31_16: coverpoint xcvr_diag_xcal_pwri_ovrd_31_16.value[15:0];
  endgroup

  protected virtual function void sample(uvm_reg_data_t data, uvm_reg_data_t byte_en, bit is_read, uvm_reg_map map);
    super.sample(data, byte_en, is_read, map);
    if (get_coverage(UVM_CVR_FIELD_VALS)) begin
      if(!is_read) begin
          wr_fld_covg.sample();
      end
      if(is_read) begin
         rd_fld_covg.sample();
      end
    end
  endfunction

  virtual function void sample_values();
    super.sample_values();
    if (get_coverage(UVM_CVR_FIELD_VALS)) begin
      wr_fld_covg.sample();
      rd_fld_covg.sample();
    end
  endfunction

  virtual function void build();
    uvm_reg_field fld_set[$];
    uvm_reg_field_config_ta ta = get_field_config(getconfigUID());
    build_uvm_reg_fields(this, ta, fld_set);
    
    xcvr_diag_xcal_pwri_ovrd_7_0 = fld_set[0];
    xcvr_diag_xcal_pwri_ovrd_8 = fld_set[1];
    xcvr_diag_xcal_pwri_ovrd_9 = fld_set[2];
    xcvr_diag_xcal_pwri_ovrd_10 = fld_set[3];
    xcvr_diag_xcal_pwri_ovrd_11 = fld_set[4];
    xcvr_diag_xcal_pwri_ovrd_13_12 = fld_set[5];
    xcvr_diag_xcal_pwri_ovrd_14 = fld_set[6];
    xcvr_diag_xcal_pwri_ovrd_15 = fld_set[7];
    xcvr_diag_xcal_pwri_ovrd_31_16 = fld_set[8];
  endfunction

  function new(input string name="T_xcvr_diag_xcal_pwri_ovrd_618");
    super.new(name, 32, build_coverage(UVM_CVR_FIELD_VALS));
    if (has_coverage(UVM_CVR_FIELD_VALS)) begin
      wr_fld_covg = new();
      rd_fld_covg = new();
    end
  endfunction

endclass


/////////////////////////////////////////////////////
//                xcvr_diag_xcal_pwri_stat
/////////////////////////////////////////////////////
class T_xcvr_diag_xcal_pwri_stat_619 extends cdns_uvm_reg;

  `uvm_object_utils(T_xcvr_diag_xcal_pwri_stat_619)
  rand uvm_reg_field xcvr_diag_xcal_pwri_stat_7_0;
  rand uvm_reg_field xcvr_diag_xcal_pwri_stat_15_8;
  rand uvm_reg_field xcvr_diag_xcal_pwri_stat_31_16;
  
  covergroup wr_fld_covg;
    xcvr_diag_xcal_pwri_stat_7_0: coverpoint xcvr_diag_xcal_pwri_stat_7_0.value[7:0];
    xcvr_diag_xcal_pwri_stat_15_8: coverpoint xcvr_diag_xcal_pwri_stat_15_8.value[7:0];
    xcvr_diag_xcal_pwri_stat_31_16: coverpoint xcvr_diag_xcal_pwri_stat_31_16.value[15:0];
  endgroup
  covergroup rd_fld_covg;
    xcvr_diag_xcal_pwri_stat_7_0: coverpoint xcvr_diag_xcal_pwri_stat_7_0.value[7:0];
    xcvr_diag_xcal_pwri_stat_15_8: coverpoint xcvr_diag_xcal_pwri_stat_15_8.value[7:0];
    xcvr_diag_xcal_pwri_stat_31_16: coverpoint xcvr_diag_xcal_pwri_stat_31_16.value[15:0];
  endgroup

  protected virtual function void sample(uvm_reg_data_t data, uvm_reg_data_t byte_en, bit is_read, uvm_reg_map map);
    super.sample(data, byte_en, is_read, map);
    if (get_coverage(UVM_CVR_FIELD_VALS)) begin
      if(!is_read) begin
          wr_fld_covg.sample();
      end
      if(is_read) begin
         rd_fld_covg.sample();
      end
    end
  endfunction

  virtual function void sample_values();
    super.sample_values();
    if (get_coverage(UVM_CVR_FIELD_VALS)) begin
      wr_fld_covg.sample();
      rd_fld_covg.sample();
    end
  endfunction

  virtual function void build();
    uvm_reg_field fld_set[$];
    uvm_reg_field_config_ta ta = get_field_config(getconfigUID());
    build_uvm_reg_fields(this, ta, fld_set);
    
    xcvr_diag_xcal_pwri_stat_7_0 = fld_set[0];
    xcvr_diag_xcal_pwri_stat_15_8 = fld_set[1];
    xcvr_diag_xcal_pwri_stat_31_16 = fld_set[2];
  endfunction

  function new(input string name="T_xcvr_diag_xcal_pwri_stat_619");
    super.new(name, 32, build_coverage(UVM_CVR_FIELD_VALS));
    if (has_coverage(UVM_CVR_FIELD_VALS)) begin
      wr_fld_covg = new();
      rd_fld_covg = new();
    end
  endfunction

endclass


/////////////////////////////////////////////////////
//                xcvr_diag_xcvr_clk_ctrl
/////////////////////////////////////////////////////
class T_xcvr_diag_xcvr_clk_ctrl_630 extends cdns_uvm_reg;

  `uvm_object_utils(T_xcvr_diag_xcvr_clk_ctrl_630)
  rand uvm_reg_field xcvr_diag_xcvr_clk_ctrl_5_0;
  rand uvm_reg_field xcvr_diag_xcvr_clk_ctrl_15_6;
  rand uvm_reg_field xcvr_diag_xcvr_clk_ctrl_31_16;
  
  covergroup wr_fld_covg;
    xcvr_diag_xcvr_clk_ctrl_5_0: coverpoint xcvr_diag_xcvr_clk_ctrl_5_0.value[5:0];
    xcvr_diag_xcvr_clk_ctrl_15_6: coverpoint xcvr_diag_xcvr_clk_ctrl_15_6.value[9:0];
    xcvr_diag_xcvr_clk_ctrl_31_16: coverpoint xcvr_diag_xcvr_clk_ctrl_31_16.value[15:0];
  endgroup
  covergroup rd_fld_covg;
    xcvr_diag_xcvr_clk_ctrl_5_0: coverpoint xcvr_diag_xcvr_clk_ctrl_5_0.value[5:0];
    xcvr_diag_xcvr_clk_ctrl_15_6: coverpoint xcvr_diag_xcvr_clk_ctrl_15_6.value[9:0];
    xcvr_diag_xcvr_clk_ctrl_31_16: coverpoint xcvr_diag_xcvr_clk_ctrl_31_16.value[15:0];
  endgroup

  protected virtual function void sample(uvm_reg_data_t data, uvm_reg_data_t byte_en, bit is_read, uvm_reg_map map);
    super.sample(data, byte_en, is_read, map);
    if (get_coverage(UVM_CVR_FIELD_VALS)) begin
      if(!is_read) begin
          wr_fld_covg.sample();
      end
      if(is_read) begin
         rd_fld_covg.sample();
      end
    end
  endfunction

  virtual function void sample_values();
    super.sample_values();
    if (get_coverage(UVM_CVR_FIELD_VALS)) begin
      wr_fld_covg.sample();
      rd_fld_covg.sample();
    end
  endfunction

  virtual function void build();
    uvm_reg_field fld_set[$];
    uvm_reg_field_config_ta ta = get_field_config(getconfigUID());
    build_uvm_reg_fields(this, ta, fld_set);
    
    xcvr_diag_xcvr_clk_ctrl_5_0 = fld_set[0];
    xcvr_diag_xcvr_clk_ctrl_15_6 = fld_set[1];
    xcvr_diag_xcvr_clk_ctrl_31_16 = fld_set[2];
  endfunction

  function new(input string name="T_xcvr_diag_xcvr_clk_ctrl_630");
    super.new(name, 32, build_coverage(UVM_CVR_FIELD_VALS));
    if (has_coverage(UVM_CVR_FIELD_VALS)) begin
      wr_fld_covg = new();
      rd_fld_covg = new();
    end
  endfunction

endclass


/////////////////////////////////////////////////////
//                xcvr_diag_xdp_pwri_ovrd
/////////////////////////////////////////////////////
class T_xcvr_diag_xdp_pwri_ovrd_620 extends cdns_uvm_reg;

  `uvm_object_utils(T_xcvr_diag_xdp_pwri_ovrd_620)
  rand uvm_reg_field xcvr_diag_xdp_pwri_ovrd_7_0;
  rand uvm_reg_field xcvr_diag_xdp_pwri_ovrd_8;
  rand uvm_reg_field xcvr_diag_xdp_pwri_ovrd_9;
  rand uvm_reg_field xcvr_diag_xdp_pwri_ovrd_10;
  rand uvm_reg_field xcvr_diag_xdp_pwri_ovrd_11;
  rand uvm_reg_field xcvr_diag_xdp_pwri_ovrd_13_12;
  rand uvm_reg_field xcvr_diag_xdp_pwri_ovrd_14;
  rand uvm_reg_field xcvr_diag_xdp_pwri_ovrd_15;
  rand uvm_reg_field xcvr_diag_xdp_pwri_ovrd_31_16;
  
  covergroup wr_fld_covg;
    xcvr_diag_xdp_pwri_ovrd_7_0: coverpoint xcvr_diag_xdp_pwri_ovrd_7_0.value[7:0];
    xcvr_diag_xdp_pwri_ovrd_8: coverpoint xcvr_diag_xdp_pwri_ovrd_8.value[0:0];
    xcvr_diag_xdp_pwri_ovrd_9: coverpoint xcvr_diag_xdp_pwri_ovrd_9.value[0:0];
    xcvr_diag_xdp_pwri_ovrd_10: coverpoint xcvr_diag_xdp_pwri_ovrd_10.value[0:0];
    xcvr_diag_xdp_pwri_ovrd_11: coverpoint xcvr_diag_xdp_pwri_ovrd_11.value[0:0];
    xcvr_diag_xdp_pwri_ovrd_13_12: coverpoint xcvr_diag_xdp_pwri_ovrd_13_12.value[1:0];
    xcvr_diag_xdp_pwri_ovrd_14: coverpoint xcvr_diag_xdp_pwri_ovrd_14.value[0:0];
    xcvr_diag_xdp_pwri_ovrd_15: coverpoint xcvr_diag_xdp_pwri_ovrd_15.value[0:0];
    xcvr_diag_xdp_pwri_ovrd_31_16: coverpoint xcvr_diag_xdp_pwri_ovrd_31_16.value[15:0];
  endgroup
  covergroup rd_fld_covg;
    xcvr_diag_xdp_pwri_ovrd_7_0: coverpoint xcvr_diag_xdp_pwri_ovrd_7_0.value[7:0];
    xcvr_diag_xdp_pwri_ovrd_8: coverpoint xcvr_diag_xdp_pwri_ovrd_8.value[0:0];
    xcvr_diag_xdp_pwri_ovrd_9: coverpoint xcvr_diag_xdp_pwri_ovrd_9.value[0:0];
    xcvr_diag_xdp_pwri_ovrd_10: coverpoint xcvr_diag_xdp_pwri_ovrd_10.value[0:0];
    xcvr_diag_xdp_pwri_ovrd_11: coverpoint xcvr_diag_xdp_pwri_ovrd_11.value[0:0];
    xcvr_diag_xdp_pwri_ovrd_13_12: coverpoint xcvr_diag_xdp_pwri_ovrd_13_12.value[1:0];
    xcvr_diag_xdp_pwri_ovrd_14: coverpoint xcvr_diag_xdp_pwri_ovrd_14.value[0:0];
    xcvr_diag_xdp_pwri_ovrd_15: coverpoint xcvr_diag_xdp_pwri_ovrd_15.value[0:0];
    xcvr_diag_xdp_pwri_ovrd_31_16: coverpoint xcvr_diag_xdp_pwri_ovrd_31_16.value[15:0];
  endgroup

  protected virtual function void sample(uvm_reg_data_t data, uvm_reg_data_t byte_en, bit is_read, uvm_reg_map map);
    super.sample(data, byte_en, is_read, map);
    if (get_coverage(UVM_CVR_FIELD_VALS)) begin
      if(!is_read) begin
          wr_fld_covg.sample();
      end
      if(is_read) begin
         rd_fld_covg.sample();
      end
    end
  endfunction

  virtual function void sample_values();
    super.sample_values();
    if (get_coverage(UVM_CVR_FIELD_VALS)) begin
      wr_fld_covg.sample();
      rd_fld_covg.sample();
    end
  endfunction

  virtual function void build();
    uvm_reg_field fld_set[$];
    uvm_reg_field_config_ta ta = get_field_config(getconfigUID());
    build_uvm_reg_fields(this, ta, fld_set);
    
    xcvr_diag_xdp_pwri_ovrd_7_0 = fld_set[0];
    xcvr_diag_xdp_pwri_ovrd_8 = fld_set[1];
    xcvr_diag_xdp_pwri_ovrd_9 = fld_set[2];
    xcvr_diag_xdp_pwri_ovrd_10 = fld_set[3];
    xcvr_diag_xdp_pwri_ovrd_11 = fld_set[4];
    xcvr_diag_xdp_pwri_ovrd_13_12 = fld_set[5];
    xcvr_diag_xdp_pwri_ovrd_14 = fld_set[6];
    xcvr_diag_xdp_pwri_ovrd_15 = fld_set[7];
    xcvr_diag_xdp_pwri_ovrd_31_16 = fld_set[8];
  endfunction

  function new(input string name="T_xcvr_diag_xdp_pwri_ovrd_620");
    super.new(name, 32, build_coverage(UVM_CVR_FIELD_VALS));
    if (has_coverage(UVM_CVR_FIELD_VALS)) begin
      wr_fld_covg = new();
      rd_fld_covg = new();
    end
  endfunction

endclass


/////////////////////////////////////////////////////
//                xcvr_diag_xdp_pwri_stat
/////////////////////////////////////////////////////
class T_xcvr_diag_xdp_pwri_stat_621 extends cdns_uvm_reg;

  `uvm_object_utils(T_xcvr_diag_xdp_pwri_stat_621)
  rand uvm_reg_field xcvr_diag_xdp_pwri_stat_7_0;
  rand uvm_reg_field xcvr_diag_xdp_pwri_stat_15_8;
  rand uvm_reg_field xcvr_diag_xdp_pwri_stat_31_16;
  
  covergroup wr_fld_covg;
    xcvr_diag_xdp_pwri_stat_7_0: coverpoint xcvr_diag_xdp_pwri_stat_7_0.value[7:0];
    xcvr_diag_xdp_pwri_stat_15_8: coverpoint xcvr_diag_xdp_pwri_stat_15_8.value[7:0];
    xcvr_diag_xdp_pwri_stat_31_16: coverpoint xcvr_diag_xdp_pwri_stat_31_16.value[15:0];
  endgroup
  covergroup rd_fld_covg;
    xcvr_diag_xdp_pwri_stat_7_0: coverpoint xcvr_diag_xdp_pwri_stat_7_0.value[7:0];
    xcvr_diag_xdp_pwri_stat_15_8: coverpoint xcvr_diag_xdp_pwri_stat_15_8.value[7:0];
    xcvr_diag_xdp_pwri_stat_31_16: coverpoint xcvr_diag_xdp_pwri_stat_31_16.value[15:0];
  endgroup

  protected virtual function void sample(uvm_reg_data_t data, uvm_reg_data_t byte_en, bit is_read, uvm_reg_map map);
    super.sample(data, byte_en, is_read, map);
    if (get_coverage(UVM_CVR_FIELD_VALS)) begin
      if(!is_read) begin
          wr_fld_covg.sample();
      end
      if(is_read) begin
         rd_fld_covg.sample();
      end
    end
  endfunction

  virtual function void sample_values();
    super.sample_values();
    if (get_coverage(UVM_CVR_FIELD_VALS)) begin
      wr_fld_covg.sample();
      rd_fld_covg.sample();
    end
  endfunction

  virtual function void build();
    uvm_reg_field fld_set[$];
    uvm_reg_field_config_ta ta = get_field_config(getconfigUID());
    build_uvm_reg_fields(this, ta, fld_set);
    
    xcvr_diag_xdp_pwri_stat_7_0 = fld_set[0];
    xcvr_diag_xdp_pwri_stat_15_8 = fld_set[1];
    xcvr_diag_xdp_pwri_stat_31_16 = fld_set[2];
  endfunction

  function new(input string name="T_xcvr_diag_xdp_pwri_stat_621");
    super.new(name, 32, build_coverage(UVM_CVR_FIELD_VALS));
    if (has_coverage(UVM_CVR_FIELD_VALS)) begin
      wr_fld_covg = new();
      rd_fld_covg = new();
    end
  endfunction

endclass


/////////////////////////////////////////////////////
//                xcvr_psm_a0byp_tmr
/////////////////////////////////////////////////////
class T_xcvr_psm_a0byp_tmr_545 extends cdns_uvm_reg;

  `uvm_object_utils(T_xcvr_psm_a0byp_tmr_545)
  rand uvm_reg_field xcvr_psm_a0byp_tmr_5_0;
  rand uvm_reg_field xcvr_psm_a0byp_tmr_15_6;
  rand uvm_reg_field xcvr_psm_a0byp_tmr_31_16;
  
  covergroup wr_fld_covg;
    xcvr_psm_a0byp_tmr_5_0: coverpoint xcvr_psm_a0byp_tmr_5_0.value[5:0];
    xcvr_psm_a0byp_tmr_15_6: coverpoint xcvr_psm_a0byp_tmr_15_6.value[9:0];
    xcvr_psm_a0byp_tmr_31_16: coverpoint xcvr_psm_a0byp_tmr_31_16.value[15:0];
  endgroup
  covergroup rd_fld_covg;
    xcvr_psm_a0byp_tmr_5_0: coverpoint xcvr_psm_a0byp_tmr_5_0.value[5:0];
    xcvr_psm_a0byp_tmr_15_6: coverpoint xcvr_psm_a0byp_tmr_15_6.value[9:0];
    xcvr_psm_a0byp_tmr_31_16: coverpoint xcvr_psm_a0byp_tmr_31_16.value[15:0];
  endgroup

  protected virtual function void sample(uvm_reg_data_t data, uvm_reg_data_t byte_en, bit is_read, uvm_reg_map map);
    super.sample(data, byte_en, is_read, map);
    if (get_coverage(UVM_CVR_FIELD_VALS)) begin
      if(!is_read) begin
          wr_fld_covg.sample();
      end
      if(is_read) begin
         rd_fld_covg.sample();
      end
    end
  endfunction

  virtual function void sample_values();
    super.sample_values();
    if (get_coverage(UVM_CVR_FIELD_VALS)) begin
      wr_fld_covg.sample();
      rd_fld_covg.sample();
    end
  endfunction

  virtual function void build();
    uvm_reg_field fld_set[$];
    uvm_reg_field_config_ta ta = get_field_config(getconfigUID());
    build_uvm_reg_fields(this, ta, fld_set);
    
    xcvr_psm_a0byp_tmr_5_0 = fld_set[0];
    xcvr_psm_a0byp_tmr_15_6 = fld_set[1];
    xcvr_psm_a0byp_tmr_31_16 = fld_set[2];
  endfunction

  function new(input string name="T_xcvr_psm_a0byp_tmr_545");
    super.new(name, 32, build_coverage(UVM_CVR_FIELD_VALS));
    if (has_coverage(UVM_CVR_FIELD_VALS)) begin
      wr_fld_covg = new();
      rd_fld_covg = new();
    end
  endfunction

endclass


/////////////////////////////////////////////////////
//                xcvr_psm_a0in_tmr
/////////////////////////////////////////////////////
class T_xcvr_psm_a0in_tmr_544 extends cdns_uvm_reg;

  `uvm_object_utils(T_xcvr_psm_a0in_tmr_544)
  rand uvm_reg_field xcvr_psm_a0in_tmr_9_0;
  rand uvm_reg_field xcvr_psm_a0in_tmr_15_10;
  rand uvm_reg_field xcvr_psm_a0in_tmr_31_16;
  
  covergroup wr_fld_covg;
    xcvr_psm_a0in_tmr_9_0: coverpoint xcvr_psm_a0in_tmr_9_0.value[9:0];
    xcvr_psm_a0in_tmr_15_10: coverpoint xcvr_psm_a0in_tmr_15_10.value[5:0];
    xcvr_psm_a0in_tmr_31_16: coverpoint xcvr_psm_a0in_tmr_31_16.value[15:0];
  endgroup
  covergroup rd_fld_covg;
    xcvr_psm_a0in_tmr_9_0: coverpoint xcvr_psm_a0in_tmr_9_0.value[9:0];
    xcvr_psm_a0in_tmr_15_10: coverpoint xcvr_psm_a0in_tmr_15_10.value[5:0];
    xcvr_psm_a0in_tmr_31_16: coverpoint xcvr_psm_a0in_tmr_31_16.value[15:0];
  endgroup

  protected virtual function void sample(uvm_reg_data_t data, uvm_reg_data_t byte_en, bit is_read, uvm_reg_map map);
    super.sample(data, byte_en, is_read, map);
    if (get_coverage(UVM_CVR_FIELD_VALS)) begin
      if(!is_read) begin
          wr_fld_covg.sample();
      end
      if(is_read) begin
         rd_fld_covg.sample();
      end
    end
  endfunction

  virtual function void sample_values();
    super.sample_values();
    if (get_coverage(UVM_CVR_FIELD_VALS)) begin
      wr_fld_covg.sample();
      rd_fld_covg.sample();
    end
  endfunction

  virtual function void build();
    uvm_reg_field fld_set[$];
    uvm_reg_field_config_ta ta = get_field_config(getconfigUID());
    build_uvm_reg_fields(this, ta, fld_set);
    
    xcvr_psm_a0in_tmr_9_0 = fld_set[0];
    xcvr_psm_a0in_tmr_15_10 = fld_set[1];
    xcvr_psm_a0in_tmr_31_16 = fld_set[2];
  endfunction

  function new(input string name="T_xcvr_psm_a0in_tmr_544");
    super.new(name, 32, build_coverage(UVM_CVR_FIELD_VALS));
    if (has_coverage(UVM_CVR_FIELD_VALS)) begin
      wr_fld_covg = new();
      rd_fld_covg = new();
    end
  endfunction

endclass


/////////////////////////////////////////////////////
//                xcvr_psm_a0out_tmr
/////////////////////////////////////////////////////
class T_xcvr_psm_a0out_tmr_552 extends cdns_uvm_reg;

  `uvm_object_utils(T_xcvr_psm_a0out_tmr_552)
  rand uvm_reg_field xcvr_psm_a0out_tmr_5_0;
  rand uvm_reg_field xcvr_psm_a0out_tmr_15_6;
  rand uvm_reg_field xcvr_psm_a0out_tmr_31_16;
  
  covergroup wr_fld_covg;
    xcvr_psm_a0out_tmr_5_0: coverpoint xcvr_psm_a0out_tmr_5_0.value[5:0];
    xcvr_psm_a0out_tmr_15_6: coverpoint xcvr_psm_a0out_tmr_15_6.value[9:0];
    xcvr_psm_a0out_tmr_31_16: coverpoint xcvr_psm_a0out_tmr_31_16.value[15:0];
  endgroup
  covergroup rd_fld_covg;
    xcvr_psm_a0out_tmr_5_0: coverpoint xcvr_psm_a0out_tmr_5_0.value[5:0];
    xcvr_psm_a0out_tmr_15_6: coverpoint xcvr_psm_a0out_tmr_15_6.value[9:0];
    xcvr_psm_a0out_tmr_31_16: coverpoint xcvr_psm_a0out_tmr_31_16.value[15:0];
  endgroup

  protected virtual function void sample(uvm_reg_data_t data, uvm_reg_data_t byte_en, bit is_read, uvm_reg_map map);
    super.sample(data, byte_en, is_read, map);
    if (get_coverage(UVM_CVR_FIELD_VALS)) begin
      if(!is_read) begin
          wr_fld_covg.sample();
      end
      if(is_read) begin
         rd_fld_covg.sample();
      end
    end
  endfunction

  virtual function void sample_values();
    super.sample_values();
    if (get_coverage(UVM_CVR_FIELD_VALS)) begin
      wr_fld_covg.sample();
      rd_fld_covg.sample();
    end
  endfunction

  virtual function void build();
    uvm_reg_field fld_set[$];
    uvm_reg_field_config_ta ta = get_field_config(getconfigUID());
    build_uvm_reg_fields(this, ta, fld_set);
    
    xcvr_psm_a0out_tmr_5_0 = fld_set[0];
    xcvr_psm_a0out_tmr_15_6 = fld_set[1];
    xcvr_psm_a0out_tmr_31_16 = fld_set[2];
  endfunction

  function new(input string name="T_xcvr_psm_a0out_tmr_552");
    super.new(name, 32, build_coverage(UVM_CVR_FIELD_VALS));
    if (has_coverage(UVM_CVR_FIELD_VALS)) begin
      wr_fld_covg = new();
      rd_fld_covg = new();
    end
  endfunction

endclass


/////////////////////////////////////////////////////
//                xcvr_psm_a1in_tmr
/////////////////////////////////////////////////////
class T_xcvr_psm_a1in_tmr_546 extends cdns_uvm_reg;

  `uvm_object_utils(T_xcvr_psm_a1in_tmr_546)
  rand uvm_reg_field xcvr_psm_a1in_tmr_5_0;
  rand uvm_reg_field xcvr_psm_a1in_tmr_15_6;
  rand uvm_reg_field xcvr_psm_a1in_tmr_31_16;
  
  covergroup wr_fld_covg;
    xcvr_psm_a1in_tmr_5_0: coverpoint xcvr_psm_a1in_tmr_5_0.value[5:0];
    xcvr_psm_a1in_tmr_15_6: coverpoint xcvr_psm_a1in_tmr_15_6.value[9:0];
    xcvr_psm_a1in_tmr_31_16: coverpoint xcvr_psm_a1in_tmr_31_16.value[15:0];
  endgroup
  covergroup rd_fld_covg;
    xcvr_psm_a1in_tmr_5_0: coverpoint xcvr_psm_a1in_tmr_5_0.value[5:0];
    xcvr_psm_a1in_tmr_15_6: coverpoint xcvr_psm_a1in_tmr_15_6.value[9:0];
    xcvr_psm_a1in_tmr_31_16: coverpoint xcvr_psm_a1in_tmr_31_16.value[15:0];
  endgroup

  protected virtual function void sample(uvm_reg_data_t data, uvm_reg_data_t byte_en, bit is_read, uvm_reg_map map);
    super.sample(data, byte_en, is_read, map);
    if (get_coverage(UVM_CVR_FIELD_VALS)) begin
      if(!is_read) begin
          wr_fld_covg.sample();
      end
      if(is_read) begin
         rd_fld_covg.sample();
      end
    end
  endfunction

  virtual function void sample_values();
    super.sample_values();
    if (get_coverage(UVM_CVR_FIELD_VALS)) begin
      wr_fld_covg.sample();
      rd_fld_covg.sample();
    end
  endfunction

  virtual function void build();
    uvm_reg_field fld_set[$];
    uvm_reg_field_config_ta ta = get_field_config(getconfigUID());
    build_uvm_reg_fields(this, ta, fld_set);
    
    xcvr_psm_a1in_tmr_5_0 = fld_set[0];
    xcvr_psm_a1in_tmr_15_6 = fld_set[1];
    xcvr_psm_a1in_tmr_31_16 = fld_set[2];
  endfunction

  function new(input string name="T_xcvr_psm_a1in_tmr_546");
    super.new(name, 32, build_coverage(UVM_CVR_FIELD_VALS));
    if (has_coverage(UVM_CVR_FIELD_VALS)) begin
      wr_fld_covg = new();
      rd_fld_covg = new();
    end
  endfunction

endclass


/////////////////////////////////////////////////////
//                xcvr_psm_a1out_tmr
/////////////////////////////////////////////////////
class T_xcvr_psm_a1out_tmr_553 extends cdns_uvm_reg;

  `uvm_object_utils(T_xcvr_psm_a1out_tmr_553)
  rand uvm_reg_field xcvr_psm_a1out_tmr_5_0;
  rand uvm_reg_field xcvr_psm_a1out_tmr_15_6;
  rand uvm_reg_field xcvr_psm_a1out_tmr_31_16;
  
  covergroup wr_fld_covg;
    xcvr_psm_a1out_tmr_5_0: coverpoint xcvr_psm_a1out_tmr_5_0.value[5:0];
    xcvr_psm_a1out_tmr_15_6: coverpoint xcvr_psm_a1out_tmr_15_6.value[9:0];
    xcvr_psm_a1out_tmr_31_16: coverpoint xcvr_psm_a1out_tmr_31_16.value[15:0];
  endgroup
  covergroup rd_fld_covg;
    xcvr_psm_a1out_tmr_5_0: coverpoint xcvr_psm_a1out_tmr_5_0.value[5:0];
    xcvr_psm_a1out_tmr_15_6: coverpoint xcvr_psm_a1out_tmr_15_6.value[9:0];
    xcvr_psm_a1out_tmr_31_16: coverpoint xcvr_psm_a1out_tmr_31_16.value[15:0];
  endgroup

  protected virtual function void sample(uvm_reg_data_t data, uvm_reg_data_t byte_en, bit is_read, uvm_reg_map map);
    super.sample(data, byte_en, is_read, map);
    if (get_coverage(UVM_CVR_FIELD_VALS)) begin
      if(!is_read) begin
          wr_fld_covg.sample();
      end
      if(is_read) begin
         rd_fld_covg.sample();
      end
    end
  endfunction

  virtual function void sample_values();
    super.sample_values();
    if (get_coverage(UVM_CVR_FIELD_VALS)) begin
      wr_fld_covg.sample();
      rd_fld_covg.sample();
    end
  endfunction

  virtual function void build();
    uvm_reg_field fld_set[$];
    uvm_reg_field_config_ta ta = get_field_config(getconfigUID());
    build_uvm_reg_fields(this, ta, fld_set);
    
    xcvr_psm_a1out_tmr_5_0 = fld_set[0];
    xcvr_psm_a1out_tmr_15_6 = fld_set[1];
    xcvr_psm_a1out_tmr_31_16 = fld_set[2];
  endfunction

  function new(input string name="T_xcvr_psm_a1out_tmr_553");
    super.new(name, 32, build_coverage(UVM_CVR_FIELD_VALS));
    if (has_coverage(UVM_CVR_FIELD_VALS)) begin
      wr_fld_covg = new();
      rd_fld_covg = new();
    end
  endfunction

endclass


/////////////////////////////////////////////////////
//                xcvr_psm_a2in_tmr
/////////////////////////////////////////////////////
class T_xcvr_psm_a2in_tmr_547 extends cdns_uvm_reg;

  `uvm_object_utils(T_xcvr_psm_a2in_tmr_547)
  rand uvm_reg_field xcvr_psm_a2in_tmr_7_0;
  rand uvm_reg_field xcvr_psm_a2in_tmr_15_8;
  rand uvm_reg_field xcvr_psm_a2in_tmr_31_16;
  
  covergroup wr_fld_covg;
    xcvr_psm_a2in_tmr_7_0: coverpoint xcvr_psm_a2in_tmr_7_0.value[7:0];
    xcvr_psm_a2in_tmr_15_8: coverpoint xcvr_psm_a2in_tmr_15_8.value[7:0];
    xcvr_psm_a2in_tmr_31_16: coverpoint xcvr_psm_a2in_tmr_31_16.value[15:0];
  endgroup
  covergroup rd_fld_covg;
    xcvr_psm_a2in_tmr_7_0: coverpoint xcvr_psm_a2in_tmr_7_0.value[7:0];
    xcvr_psm_a2in_tmr_15_8: coverpoint xcvr_psm_a2in_tmr_15_8.value[7:0];
    xcvr_psm_a2in_tmr_31_16: coverpoint xcvr_psm_a2in_tmr_31_16.value[15:0];
  endgroup

  protected virtual function void sample(uvm_reg_data_t data, uvm_reg_data_t byte_en, bit is_read, uvm_reg_map map);
    super.sample(data, byte_en, is_read, map);
    if (get_coverage(UVM_CVR_FIELD_VALS)) begin
      if(!is_read) begin
          wr_fld_covg.sample();
      end
      if(is_read) begin
         rd_fld_covg.sample();
      end
    end
  endfunction

  virtual function void sample_values();
    super.sample_values();
    if (get_coverage(UVM_CVR_FIELD_VALS)) begin
      wr_fld_covg.sample();
      rd_fld_covg.sample();
    end
  endfunction

  virtual function void build();
    uvm_reg_field fld_set[$];
    uvm_reg_field_config_ta ta = get_field_config(getconfigUID());
    build_uvm_reg_fields(this, ta, fld_set);
    
    xcvr_psm_a2in_tmr_7_0 = fld_set[0];
    xcvr_psm_a2in_tmr_15_8 = fld_set[1];
    xcvr_psm_a2in_tmr_31_16 = fld_set[2];
  endfunction

  function new(input string name="T_xcvr_psm_a2in_tmr_547");
    super.new(name, 32, build_coverage(UVM_CVR_FIELD_VALS));
    if (has_coverage(UVM_CVR_FIELD_VALS)) begin
      wr_fld_covg = new();
      rd_fld_covg = new();
    end
  endfunction

endclass


/////////////////////////////////////////////////////
//                xcvr_psm_a2out_tmr
/////////////////////////////////////////////////////
class T_xcvr_psm_a2out_tmr_554 extends cdns_uvm_reg;

  `uvm_object_utils(T_xcvr_psm_a2out_tmr_554)
  rand uvm_reg_field xcvr_psm_a2out_tmr_5_0;
  rand uvm_reg_field xcvr_psm_a2out_tmr_15_6;
  rand uvm_reg_field xcvr_psm_a2out_tmr_31_16;
  
  covergroup wr_fld_covg;
    xcvr_psm_a2out_tmr_5_0: coverpoint xcvr_psm_a2out_tmr_5_0.value[5:0];
    xcvr_psm_a2out_tmr_15_6: coverpoint xcvr_psm_a2out_tmr_15_6.value[9:0];
    xcvr_psm_a2out_tmr_31_16: coverpoint xcvr_psm_a2out_tmr_31_16.value[15:0];
  endgroup
  covergroup rd_fld_covg;
    xcvr_psm_a2out_tmr_5_0: coverpoint xcvr_psm_a2out_tmr_5_0.value[5:0];
    xcvr_psm_a2out_tmr_15_6: coverpoint xcvr_psm_a2out_tmr_15_6.value[9:0];
    xcvr_psm_a2out_tmr_31_16: coverpoint xcvr_psm_a2out_tmr_31_16.value[15:0];
  endgroup

  protected virtual function void sample(uvm_reg_data_t data, uvm_reg_data_t byte_en, bit is_read, uvm_reg_map map);
    super.sample(data, byte_en, is_read, map);
    if (get_coverage(UVM_CVR_FIELD_VALS)) begin
      if(!is_read) begin
          wr_fld_covg.sample();
      end
      if(is_read) begin
         rd_fld_covg.sample();
      end
    end
  endfunction

  virtual function void sample_values();
    super.sample_values();
    if (get_coverage(UVM_CVR_FIELD_VALS)) begin
      wr_fld_covg.sample();
      rd_fld_covg.sample();
    end
  endfunction

  virtual function void build();
    uvm_reg_field fld_set[$];
    uvm_reg_field_config_ta ta = get_field_config(getconfigUID());
    build_uvm_reg_fields(this, ta, fld_set);
    
    xcvr_psm_a2out_tmr_5_0 = fld_set[0];
    xcvr_psm_a2out_tmr_15_6 = fld_set[1];
    xcvr_psm_a2out_tmr_31_16 = fld_set[2];
  endfunction

  function new(input string name="T_xcvr_psm_a2out_tmr_554");
    super.new(name, 32, build_coverage(UVM_CVR_FIELD_VALS));
    if (has_coverage(UVM_CVR_FIELD_VALS)) begin
      wr_fld_covg = new();
      rd_fld_covg = new();
    end
  endfunction

endclass


/////////////////////////////////////////////////////
//                xcvr_psm_a3in_tmr
/////////////////////////////////////////////////////
class T_xcvr_psm_a3in_tmr_548 extends cdns_uvm_reg;

  `uvm_object_utils(T_xcvr_psm_a3in_tmr_548)
  rand uvm_reg_field xcvr_psm_a3in_tmr_5_0;
  rand uvm_reg_field xcvr_psm_a3in_tmr_15_6;
  rand uvm_reg_field xcvr_psm_a3in_tmr_31_16;
  
  covergroup wr_fld_covg;
    xcvr_psm_a3in_tmr_5_0: coverpoint xcvr_psm_a3in_tmr_5_0.value[5:0];
    xcvr_psm_a3in_tmr_15_6: coverpoint xcvr_psm_a3in_tmr_15_6.value[9:0];
    xcvr_psm_a3in_tmr_31_16: coverpoint xcvr_psm_a3in_tmr_31_16.value[15:0];
  endgroup
  covergroup rd_fld_covg;
    xcvr_psm_a3in_tmr_5_0: coverpoint xcvr_psm_a3in_tmr_5_0.value[5:0];
    xcvr_psm_a3in_tmr_15_6: coverpoint xcvr_psm_a3in_tmr_15_6.value[9:0];
    xcvr_psm_a3in_tmr_31_16: coverpoint xcvr_psm_a3in_tmr_31_16.value[15:0];
  endgroup

  protected virtual function void sample(uvm_reg_data_t data, uvm_reg_data_t byte_en, bit is_read, uvm_reg_map map);
    super.sample(data, byte_en, is_read, map);
    if (get_coverage(UVM_CVR_FIELD_VALS)) begin
      if(!is_read) begin
          wr_fld_covg.sample();
      end
      if(is_read) begin
         rd_fld_covg.sample();
      end
    end
  endfunction

  virtual function void sample_values();
    super.sample_values();
    if (get_coverage(UVM_CVR_FIELD_VALS)) begin
      wr_fld_covg.sample();
      rd_fld_covg.sample();
    end
  endfunction

  virtual function void build();
    uvm_reg_field fld_set[$];
    uvm_reg_field_config_ta ta = get_field_config(getconfigUID());
    build_uvm_reg_fields(this, ta, fld_set);
    
    xcvr_psm_a3in_tmr_5_0 = fld_set[0];
    xcvr_psm_a3in_tmr_15_6 = fld_set[1];
    xcvr_psm_a3in_tmr_31_16 = fld_set[2];
  endfunction

  function new(input string name="T_xcvr_psm_a3in_tmr_548");
    super.new(name, 32, build_coverage(UVM_CVR_FIELD_VALS));
    if (has_coverage(UVM_CVR_FIELD_VALS)) begin
      wr_fld_covg = new();
      rd_fld_covg = new();
    end
  endfunction

endclass


/////////////////////////////////////////////////////
//                xcvr_psm_a3out_tmr
/////////////////////////////////////////////////////
class T_xcvr_psm_a3out_tmr_555 extends cdns_uvm_reg;

  `uvm_object_utils(T_xcvr_psm_a3out_tmr_555)
  rand uvm_reg_field xcvr_psm_a3out_tmr_5_0;
  rand uvm_reg_field xcvr_psm_a3out_tmr_15_6;
  rand uvm_reg_field xcvr_psm_a3out_tmr_31_16;
  
  covergroup wr_fld_covg;
    xcvr_psm_a3out_tmr_5_0: coverpoint xcvr_psm_a3out_tmr_5_0.value[5:0];
    xcvr_psm_a3out_tmr_15_6: coverpoint xcvr_psm_a3out_tmr_15_6.value[9:0];
    xcvr_psm_a3out_tmr_31_16: coverpoint xcvr_psm_a3out_tmr_31_16.value[15:0];
  endgroup
  covergroup rd_fld_covg;
    xcvr_psm_a3out_tmr_5_0: coverpoint xcvr_psm_a3out_tmr_5_0.value[5:0];
    xcvr_psm_a3out_tmr_15_6: coverpoint xcvr_psm_a3out_tmr_15_6.value[9:0];
    xcvr_psm_a3out_tmr_31_16: coverpoint xcvr_psm_a3out_tmr_31_16.value[15:0];
  endgroup

  protected virtual function void sample(uvm_reg_data_t data, uvm_reg_data_t byte_en, bit is_read, uvm_reg_map map);
    super.sample(data, byte_en, is_read, map);
    if (get_coverage(UVM_CVR_FIELD_VALS)) begin
      if(!is_read) begin
          wr_fld_covg.sample();
      end
      if(is_read) begin
         rd_fld_covg.sample();
      end
    end
  endfunction

  virtual function void sample_values();
    super.sample_values();
    if (get_coverage(UVM_CVR_FIELD_VALS)) begin
      wr_fld_covg.sample();
      rd_fld_covg.sample();
    end
  endfunction

  virtual function void build();
    uvm_reg_field fld_set[$];
    uvm_reg_field_config_ta ta = get_field_config(getconfigUID());
    build_uvm_reg_fields(this, ta, fld_set);
    
    xcvr_psm_a3out_tmr_5_0 = fld_set[0];
    xcvr_psm_a3out_tmr_15_6 = fld_set[1];
    xcvr_psm_a3out_tmr_31_16 = fld_set[2];
  endfunction

  function new(input string name="T_xcvr_psm_a3out_tmr_555");
    super.new(name, 32, build_coverage(UVM_CVR_FIELD_VALS));
    if (has_coverage(UVM_CVR_FIELD_VALS)) begin
      wr_fld_covg = new();
      rd_fld_covg = new();
    end
  endfunction

endclass


/////////////////////////////////////////////////////
//                xcvr_psm_a4in_tmr
/////////////////////////////////////////////////////
class T_xcvr_psm_a4in_tmr_549 extends cdns_uvm_reg;

  `uvm_object_utils(T_xcvr_psm_a4in_tmr_549)
  rand uvm_reg_field xcvr_psm_a4in_tmr_5_0;
  rand uvm_reg_field xcvr_psm_a4in_tmr_15_6;
  rand uvm_reg_field xcvr_psm_a4in_tmr_31_16;
  
  covergroup wr_fld_covg;
    xcvr_psm_a4in_tmr_5_0: coverpoint xcvr_psm_a4in_tmr_5_0.value[5:0];
    xcvr_psm_a4in_tmr_15_6: coverpoint xcvr_psm_a4in_tmr_15_6.value[9:0];
    xcvr_psm_a4in_tmr_31_16: coverpoint xcvr_psm_a4in_tmr_31_16.value[15:0];
  endgroup
  covergroup rd_fld_covg;
    xcvr_psm_a4in_tmr_5_0: coverpoint xcvr_psm_a4in_tmr_5_0.value[5:0];
    xcvr_psm_a4in_tmr_15_6: coverpoint xcvr_psm_a4in_tmr_15_6.value[9:0];
    xcvr_psm_a4in_tmr_31_16: coverpoint xcvr_psm_a4in_tmr_31_16.value[15:0];
  endgroup

  protected virtual function void sample(uvm_reg_data_t data, uvm_reg_data_t byte_en, bit is_read, uvm_reg_map map);
    super.sample(data, byte_en, is_read, map);
    if (get_coverage(UVM_CVR_FIELD_VALS)) begin
      if(!is_read) begin
          wr_fld_covg.sample();
      end
      if(is_read) begin
         rd_fld_covg.sample();
      end
    end
  endfunction

  virtual function void sample_values();
    super.sample_values();
    if (get_coverage(UVM_CVR_FIELD_VALS)) begin
      wr_fld_covg.sample();
      rd_fld_covg.sample();
    end
  endfunction

  virtual function void build();
    uvm_reg_field fld_set[$];
    uvm_reg_field_config_ta ta = get_field_config(getconfigUID());
    build_uvm_reg_fields(this, ta, fld_set);
    
    xcvr_psm_a4in_tmr_5_0 = fld_set[0];
    xcvr_psm_a4in_tmr_15_6 = fld_set[1];
    xcvr_psm_a4in_tmr_31_16 = fld_set[2];
  endfunction

  function new(input string name="T_xcvr_psm_a4in_tmr_549");
    super.new(name, 32, build_coverage(UVM_CVR_FIELD_VALS));
    if (has_coverage(UVM_CVR_FIELD_VALS)) begin
      wr_fld_covg = new();
      rd_fld_covg = new();
    end
  endfunction

endclass


/////////////////////////////////////////////////////
//                xcvr_psm_a4out_tmr
/////////////////////////////////////////////////////
class T_xcvr_psm_a4out_tmr_556 extends cdns_uvm_reg;

  `uvm_object_utils(T_xcvr_psm_a4out_tmr_556)
  rand uvm_reg_field xcvr_psm_a4out_tmr_5_0;
  rand uvm_reg_field xcvr_psm_a4out_tmr_15_6;
  rand uvm_reg_field xcvr_psm_a4out_tmr_31_16;
  
  covergroup wr_fld_covg;
    xcvr_psm_a4out_tmr_5_0: coverpoint xcvr_psm_a4out_tmr_5_0.value[5:0];
    xcvr_psm_a4out_tmr_15_6: coverpoint xcvr_psm_a4out_tmr_15_6.value[9:0];
    xcvr_psm_a4out_tmr_31_16: coverpoint xcvr_psm_a4out_tmr_31_16.value[15:0];
  endgroup
  covergroup rd_fld_covg;
    xcvr_psm_a4out_tmr_5_0: coverpoint xcvr_psm_a4out_tmr_5_0.value[5:0];
    xcvr_psm_a4out_tmr_15_6: coverpoint xcvr_psm_a4out_tmr_15_6.value[9:0];
    xcvr_psm_a4out_tmr_31_16: coverpoint xcvr_psm_a4out_tmr_31_16.value[15:0];
  endgroup

  protected virtual function void sample(uvm_reg_data_t data, uvm_reg_data_t byte_en, bit is_read, uvm_reg_map map);
    super.sample(data, byte_en, is_read, map);
    if (get_coverage(UVM_CVR_FIELD_VALS)) begin
      if(!is_read) begin
          wr_fld_covg.sample();
      end
      if(is_read) begin
         rd_fld_covg.sample();
      end
    end
  endfunction

  virtual function void sample_values();
    super.sample_values();
    if (get_coverage(UVM_CVR_FIELD_VALS)) begin
      wr_fld_covg.sample();
      rd_fld_covg.sample();
    end
  endfunction

  virtual function void build();
    uvm_reg_field fld_set[$];
    uvm_reg_field_config_ta ta = get_field_config(getconfigUID());
    build_uvm_reg_fields(this, ta, fld_set);
    
    xcvr_psm_a4out_tmr_5_0 = fld_set[0];
    xcvr_psm_a4out_tmr_15_6 = fld_set[1];
    xcvr_psm_a4out_tmr_31_16 = fld_set[2];
  endfunction

  function new(input string name="T_xcvr_psm_a4out_tmr_556");
    super.new(name, 32, build_coverage(UVM_CVR_FIELD_VALS));
    if (has_coverage(UVM_CVR_FIELD_VALS)) begin
      wr_fld_covg = new();
      rd_fld_covg = new();
    end
  endfunction

endclass


/////////////////////////////////////////////////////
//                xcvr_psm_a5in_tmr
/////////////////////////////////////////////////////
class T_xcvr_psm_a5in_tmr_550 extends cdns_uvm_reg;

  `uvm_object_utils(T_xcvr_psm_a5in_tmr_550)
  rand uvm_reg_field xcvr_psm_a5in_tmr_5_0;
  rand uvm_reg_field xcvr_psm_a5in_tmr_15_6;
  rand uvm_reg_field xcvr_psm_a5in_tmr_31_16;
  
  covergroup wr_fld_covg;
    xcvr_psm_a5in_tmr_5_0: coverpoint xcvr_psm_a5in_tmr_5_0.value[5:0];
    xcvr_psm_a5in_tmr_15_6: coverpoint xcvr_psm_a5in_tmr_15_6.value[9:0];
    xcvr_psm_a5in_tmr_31_16: coverpoint xcvr_psm_a5in_tmr_31_16.value[15:0];
  endgroup
  covergroup rd_fld_covg;
    xcvr_psm_a5in_tmr_5_0: coverpoint xcvr_psm_a5in_tmr_5_0.value[5:0];
    xcvr_psm_a5in_tmr_15_6: coverpoint xcvr_psm_a5in_tmr_15_6.value[9:0];
    xcvr_psm_a5in_tmr_31_16: coverpoint xcvr_psm_a5in_tmr_31_16.value[15:0];
  endgroup

  protected virtual function void sample(uvm_reg_data_t data, uvm_reg_data_t byte_en, bit is_read, uvm_reg_map map);
    super.sample(data, byte_en, is_read, map);
    if (get_coverage(UVM_CVR_FIELD_VALS)) begin
      if(!is_read) begin
          wr_fld_covg.sample();
      end
      if(is_read) begin
         rd_fld_covg.sample();
      end
    end
  endfunction

  virtual function void sample_values();
    super.sample_values();
    if (get_coverage(UVM_CVR_FIELD_VALS)) begin
      wr_fld_covg.sample();
      rd_fld_covg.sample();
    end
  endfunction

  virtual function void build();
    uvm_reg_field fld_set[$];
    uvm_reg_field_config_ta ta = get_field_config(getconfigUID());
    build_uvm_reg_fields(this, ta, fld_set);
    
    xcvr_psm_a5in_tmr_5_0 = fld_set[0];
    xcvr_psm_a5in_tmr_15_6 = fld_set[1];
    xcvr_psm_a5in_tmr_31_16 = fld_set[2];
  endfunction

  function new(input string name="T_xcvr_psm_a5in_tmr_550");
    super.new(name, 32, build_coverage(UVM_CVR_FIELD_VALS));
    if (has_coverage(UVM_CVR_FIELD_VALS)) begin
      wr_fld_covg = new();
      rd_fld_covg = new();
    end
  endfunction

endclass


/////////////////////////////////////////////////////
//                xcvr_psm_a5out_tmr
/////////////////////////////////////////////////////
class T_xcvr_psm_a5out_tmr_557 extends cdns_uvm_reg;

  `uvm_object_utils(T_xcvr_psm_a5out_tmr_557)
  rand uvm_reg_field xcvr_psm_a5out_tmr_5_0;
  rand uvm_reg_field xcvr_psm_a5out_tmr_15_6;
  rand uvm_reg_field xcvr_psm_a5out_tmr_31_16;
  
  covergroup wr_fld_covg;
    xcvr_psm_a5out_tmr_5_0: coverpoint xcvr_psm_a5out_tmr_5_0.value[5:0];
    xcvr_psm_a5out_tmr_15_6: coverpoint xcvr_psm_a5out_tmr_15_6.value[9:0];
    xcvr_psm_a5out_tmr_31_16: coverpoint xcvr_psm_a5out_tmr_31_16.value[15:0];
  endgroup
  covergroup rd_fld_covg;
    xcvr_psm_a5out_tmr_5_0: coverpoint xcvr_psm_a5out_tmr_5_0.value[5:0];
    xcvr_psm_a5out_tmr_15_6: coverpoint xcvr_psm_a5out_tmr_15_6.value[9:0];
    xcvr_psm_a5out_tmr_31_16: coverpoint xcvr_psm_a5out_tmr_31_16.value[15:0];
  endgroup

  protected virtual function void sample(uvm_reg_data_t data, uvm_reg_data_t byte_en, bit is_read, uvm_reg_map map);
    super.sample(data, byte_en, is_read, map);
    if (get_coverage(UVM_CVR_FIELD_VALS)) begin
      if(!is_read) begin
          wr_fld_covg.sample();
      end
      if(is_read) begin
         rd_fld_covg.sample();
      end
    end
  endfunction

  virtual function void sample_values();
    super.sample_values();
    if (get_coverage(UVM_CVR_FIELD_VALS)) begin
      wr_fld_covg.sample();
      rd_fld_covg.sample();
    end
  endfunction

  virtual function void build();
    uvm_reg_field fld_set[$];
    uvm_reg_field_config_ta ta = get_field_config(getconfigUID());
    build_uvm_reg_fields(this, ta, fld_set);
    
    xcvr_psm_a5out_tmr_5_0 = fld_set[0];
    xcvr_psm_a5out_tmr_15_6 = fld_set[1];
    xcvr_psm_a5out_tmr_31_16 = fld_set[2];
  endfunction

  function new(input string name="T_xcvr_psm_a5out_tmr_557");
    super.new(name, 32, build_coverage(UVM_CVR_FIELD_VALS));
    if (has_coverage(UVM_CVR_FIELD_VALS)) begin
      wr_fld_covg = new();
      rd_fld_covg = new();
    end
  endfunction

endclass


/////////////////////////////////////////////////////
//                xcvr_psm_calin_tmr
/////////////////////////////////////////////////////
class T_xcvr_psm_calin_tmr_543 extends cdns_uvm_reg;

  `uvm_object_utils(T_xcvr_psm_calin_tmr_543)
  rand uvm_reg_field xcvr_psm_calin_tmr_9_0;
  rand uvm_reg_field xcvr_psm_calin_tmr_15_10;
  rand uvm_reg_field xcvr_psm_calin_tmr_31_16;
  
  covergroup wr_fld_covg;
    xcvr_psm_calin_tmr_9_0: coverpoint xcvr_psm_calin_tmr_9_0.value[9:0];
    xcvr_psm_calin_tmr_15_10: coverpoint xcvr_psm_calin_tmr_15_10.value[5:0];
    xcvr_psm_calin_tmr_31_16: coverpoint xcvr_psm_calin_tmr_31_16.value[15:0];
  endgroup
  covergroup rd_fld_covg;
    xcvr_psm_calin_tmr_9_0: coverpoint xcvr_psm_calin_tmr_9_0.value[9:0];
    xcvr_psm_calin_tmr_15_10: coverpoint xcvr_psm_calin_tmr_15_10.value[5:0];
    xcvr_psm_calin_tmr_31_16: coverpoint xcvr_psm_calin_tmr_31_16.value[15:0];
  endgroup

  protected virtual function void sample(uvm_reg_data_t data, uvm_reg_data_t byte_en, bit is_read, uvm_reg_map map);
    super.sample(data, byte_en, is_read, map);
    if (get_coverage(UVM_CVR_FIELD_VALS)) begin
      if(!is_read) begin
          wr_fld_covg.sample();
      end
      if(is_read) begin
         rd_fld_covg.sample();
      end
    end
  endfunction

  virtual function void sample_values();
    super.sample_values();
    if (get_coverage(UVM_CVR_FIELD_VALS)) begin
      wr_fld_covg.sample();
      rd_fld_covg.sample();
    end
  endfunction

  virtual function void build();
    uvm_reg_field fld_set[$];
    uvm_reg_field_config_ta ta = get_field_config(getconfigUID());
    build_uvm_reg_fields(this, ta, fld_set);
    
    xcvr_psm_calin_tmr_9_0 = fld_set[0];
    xcvr_psm_calin_tmr_15_10 = fld_set[1];
    xcvr_psm_calin_tmr_31_16 = fld_set[2];
  endfunction

  function new(input string name="T_xcvr_psm_calin_tmr_543");
    super.new(name, 32, build_coverage(UVM_CVR_FIELD_VALS));
    if (has_coverage(UVM_CVR_FIELD_VALS)) begin
      wr_fld_covg = new();
      rd_fld_covg = new();
    end
  endfunction

endclass


/////////////////////////////////////////////////////
//                xcvr_psm_calout_tmr
/////////////////////////////////////////////////////
class T_xcvr_psm_calout_tmr_551 extends cdns_uvm_reg;

  `uvm_object_utils(T_xcvr_psm_calout_tmr_551)
  rand uvm_reg_field xcvr_psm_calout_tmr_5_0;
  rand uvm_reg_field xcvr_psm_calout_tmr_15_6;
  rand uvm_reg_field xcvr_psm_calout_tmr_31_16;
  
  covergroup wr_fld_covg;
    xcvr_psm_calout_tmr_5_0: coverpoint xcvr_psm_calout_tmr_5_0.value[5:0];
    xcvr_psm_calout_tmr_15_6: coverpoint xcvr_psm_calout_tmr_15_6.value[9:0];
    xcvr_psm_calout_tmr_31_16: coverpoint xcvr_psm_calout_tmr_31_16.value[15:0];
  endgroup
  covergroup rd_fld_covg;
    xcvr_psm_calout_tmr_5_0: coverpoint xcvr_psm_calout_tmr_5_0.value[5:0];
    xcvr_psm_calout_tmr_15_6: coverpoint xcvr_psm_calout_tmr_15_6.value[9:0];
    xcvr_psm_calout_tmr_31_16: coverpoint xcvr_psm_calout_tmr_31_16.value[15:0];
  endgroup

  protected virtual function void sample(uvm_reg_data_t data, uvm_reg_data_t byte_en, bit is_read, uvm_reg_map map);
    super.sample(data, byte_en, is_read, map);
    if (get_coverage(UVM_CVR_FIELD_VALS)) begin
      if(!is_read) begin
          wr_fld_covg.sample();
      end
      if(is_read) begin
         rd_fld_covg.sample();
      end
    end
  endfunction

  virtual function void sample_values();
    super.sample_values();
    if (get_coverage(UVM_CVR_FIELD_VALS)) begin
      wr_fld_covg.sample();
      rd_fld_covg.sample();
    end
  endfunction

  virtual function void build();
    uvm_reg_field fld_set[$];
    uvm_reg_field_config_ta ta = get_field_config(getconfigUID());
    build_uvm_reg_fields(this, ta, fld_set);
    
    xcvr_psm_calout_tmr_5_0 = fld_set[0];
    xcvr_psm_calout_tmr_15_6 = fld_set[1];
    xcvr_psm_calout_tmr_31_16 = fld_set[2];
  endfunction

  function new(input string name="T_xcvr_psm_calout_tmr_551");
    super.new(name, 32, build_coverage(UVM_CVR_FIELD_VALS));
    if (has_coverage(UVM_CVR_FIELD_VALS)) begin
      wr_fld_covg = new();
      rd_fld_covg = new();
    end
  endfunction

endclass


/////////////////////////////////////////////////////
//                xcvr_psm_ctrl
/////////////////////////////////////////////////////
class T_xcvr_psm_ctrl_541 extends cdns_uvm_reg;

  `uvm_object_utils(T_xcvr_psm_ctrl_541)
  rand uvm_reg_field xcvr_psm_ctrl_0;
  rand uvm_reg_field xcvr_psm_ctrl_7_1;
  rand uvm_reg_field xcvr_psm_ctrl_8;
  rand uvm_reg_field xcvr_psm_ctrl_9;
  rand uvm_reg_field xcvr_psm_ctrl_10;
  rand uvm_reg_field xcvr_psm_ctrl_11;
  rand uvm_reg_field xcvr_psm_ctrl_12;
  rand uvm_reg_field xcvr_psm_ctrl_13;
  rand uvm_reg_field xcvr_psm_ctrl_14;
  rand uvm_reg_field xcvr_psm_ctrl_15;
  rand uvm_reg_field xcvr_psm_ctrl_31_16;
  
  covergroup wr_fld_covg;
    xcvr_psm_ctrl_0: coverpoint xcvr_psm_ctrl_0.value[0:0];
    xcvr_psm_ctrl_7_1: coverpoint xcvr_psm_ctrl_7_1.value[6:0];
    xcvr_psm_ctrl_8: coverpoint xcvr_psm_ctrl_8.value[0:0];
    xcvr_psm_ctrl_9: coverpoint xcvr_psm_ctrl_9.value[0:0];
    xcvr_psm_ctrl_10: coverpoint xcvr_psm_ctrl_10.value[0:0];
    xcvr_psm_ctrl_11: coverpoint xcvr_psm_ctrl_11.value[0:0];
    xcvr_psm_ctrl_12: coverpoint xcvr_psm_ctrl_12.value[0:0];
    xcvr_psm_ctrl_13: coverpoint xcvr_psm_ctrl_13.value[0:0];
    xcvr_psm_ctrl_14: coverpoint xcvr_psm_ctrl_14.value[0:0];
    xcvr_psm_ctrl_15: coverpoint xcvr_psm_ctrl_15.value[0:0];
    xcvr_psm_ctrl_31_16: coverpoint xcvr_psm_ctrl_31_16.value[15:0];
  endgroup
  covergroup rd_fld_covg;
    xcvr_psm_ctrl_0: coverpoint xcvr_psm_ctrl_0.value[0:0];
    xcvr_psm_ctrl_7_1: coverpoint xcvr_psm_ctrl_7_1.value[6:0];
    xcvr_psm_ctrl_8: coverpoint xcvr_psm_ctrl_8.value[0:0];
    xcvr_psm_ctrl_9: coverpoint xcvr_psm_ctrl_9.value[0:0];
    xcvr_psm_ctrl_10: coverpoint xcvr_psm_ctrl_10.value[0:0];
    xcvr_psm_ctrl_11: coverpoint xcvr_psm_ctrl_11.value[0:0];
    xcvr_psm_ctrl_12: coverpoint xcvr_psm_ctrl_12.value[0:0];
    xcvr_psm_ctrl_13: coverpoint xcvr_psm_ctrl_13.value[0:0];
    xcvr_psm_ctrl_14: coverpoint xcvr_psm_ctrl_14.value[0:0];
    xcvr_psm_ctrl_15: coverpoint xcvr_psm_ctrl_15.value[0:0];
    xcvr_psm_ctrl_31_16: coverpoint xcvr_psm_ctrl_31_16.value[15:0];
  endgroup

  protected virtual function void sample(uvm_reg_data_t data, uvm_reg_data_t byte_en, bit is_read, uvm_reg_map map);
    super.sample(data, byte_en, is_read, map);
    if (get_coverage(UVM_CVR_FIELD_VALS)) begin
      if(!is_read) begin
          wr_fld_covg.sample();
      end
      if(is_read) begin
         rd_fld_covg.sample();
      end
    end
  endfunction

  virtual function void sample_values();
    super.sample_values();
    if (get_coverage(UVM_CVR_FIELD_VALS)) begin
      wr_fld_covg.sample();
      rd_fld_covg.sample();
    end
  endfunction

  virtual function void build();
    uvm_reg_field fld_set[$];
    uvm_reg_field_config_ta ta = get_field_config(getconfigUID());
    build_uvm_reg_fields(this, ta, fld_set);
    
    xcvr_psm_ctrl_0 = fld_set[0];
    xcvr_psm_ctrl_7_1 = fld_set[1];
    xcvr_psm_ctrl_8 = fld_set[2];
    xcvr_psm_ctrl_9 = fld_set[3];
    xcvr_psm_ctrl_10 = fld_set[4];
    xcvr_psm_ctrl_11 = fld_set[5];
    xcvr_psm_ctrl_12 = fld_set[6];
    xcvr_psm_ctrl_13 = fld_set[7];
    xcvr_psm_ctrl_14 = fld_set[8];
    xcvr_psm_ctrl_15 = fld_set[9];
    xcvr_psm_ctrl_31_16 = fld_set[10];
  endfunction

  function new(input string name="T_xcvr_psm_ctrl_541");
    super.new(name, 32, build_coverage(UVM_CVR_FIELD_VALS));
    if (has_coverage(UVM_CVR_FIELD_VALS)) begin
      wr_fld_covg = new();
      rd_fld_covg = new();
    end
  endfunction

endclass


/////////////////////////////////////////////////////
//                xcvr_psm_diag
/////////////////////////////////////////////////////
class T_xcvr_psm_diag_559 extends cdns_uvm_reg;

  `uvm_object_utils(T_xcvr_psm_diag_559)
  rand uvm_reg_field xcvr_psm_diag_0;
  rand uvm_reg_field xcvr_psm_diag_1;
  rand uvm_reg_field xcvr_psm_diag_2;
  rand uvm_reg_field xcvr_psm_diag_3;
  rand uvm_reg_field xcvr_psm_diag_4;
  rand uvm_reg_field xcvr_psm_diag_5;
  rand uvm_reg_field xcvr_psm_diag_6;
  rand uvm_reg_field xcvr_psm_diag_7;
  rand uvm_reg_field xcvr_psm_diag_8;
  rand uvm_reg_field xcvr_psm_diag_9;
  rand uvm_reg_field xcvr_psm_diag_10;
  rand uvm_reg_field xcvr_psm_diag_11;
  rand uvm_reg_field xcvr_psm_diag_12;
  rand uvm_reg_field xcvr_psm_diag_13;
  rand uvm_reg_field xcvr_psm_diag_14;
  rand uvm_reg_field xcvr_psm_diag_15;
  rand uvm_reg_field xcvr_psm_diag_31_16;
  
  covergroup wr_fld_covg;
    xcvr_psm_diag_0: coverpoint xcvr_psm_diag_0.value[0:0];
    xcvr_psm_diag_1: coverpoint xcvr_psm_diag_1.value[0:0];
    xcvr_psm_diag_2: coverpoint xcvr_psm_diag_2.value[0:0];
    xcvr_psm_diag_3: coverpoint xcvr_psm_diag_3.value[0:0];
    xcvr_psm_diag_4: coverpoint xcvr_psm_diag_4.value[0:0];
    xcvr_psm_diag_5: coverpoint xcvr_psm_diag_5.value[0:0];
    xcvr_psm_diag_6: coverpoint xcvr_psm_diag_6.value[0:0];
    xcvr_psm_diag_7: coverpoint xcvr_psm_diag_7.value[0:0];
    xcvr_psm_diag_8: coverpoint xcvr_psm_diag_8.value[0:0];
    xcvr_psm_diag_9: coverpoint xcvr_psm_diag_9.value[0:0];
    xcvr_psm_diag_10: coverpoint xcvr_psm_diag_10.value[0:0];
    xcvr_psm_diag_11: coverpoint xcvr_psm_diag_11.value[0:0];
    xcvr_psm_diag_12: coverpoint xcvr_psm_diag_12.value[0:0];
    xcvr_psm_diag_13: coverpoint xcvr_psm_diag_13.value[0:0];
    xcvr_psm_diag_14: coverpoint xcvr_psm_diag_14.value[0:0];
    xcvr_psm_diag_15: coverpoint xcvr_psm_diag_15.value[0:0];
    xcvr_psm_diag_31_16: coverpoint xcvr_psm_diag_31_16.value[15:0];
  endgroup
  covergroup rd_fld_covg;
    xcvr_psm_diag_0: coverpoint xcvr_psm_diag_0.value[0:0];
    xcvr_psm_diag_1: coverpoint xcvr_psm_diag_1.value[0:0];
    xcvr_psm_diag_2: coverpoint xcvr_psm_diag_2.value[0:0];
    xcvr_psm_diag_3: coverpoint xcvr_psm_diag_3.value[0:0];
    xcvr_psm_diag_4: coverpoint xcvr_psm_diag_4.value[0:0];
    xcvr_psm_diag_5: coverpoint xcvr_psm_diag_5.value[0:0];
    xcvr_psm_diag_6: coverpoint xcvr_psm_diag_6.value[0:0];
    xcvr_psm_diag_7: coverpoint xcvr_psm_diag_7.value[0:0];
    xcvr_psm_diag_8: coverpoint xcvr_psm_diag_8.value[0:0];
    xcvr_psm_diag_9: coverpoint xcvr_psm_diag_9.value[0:0];
    xcvr_psm_diag_10: coverpoint xcvr_psm_diag_10.value[0:0];
    xcvr_psm_diag_11: coverpoint xcvr_psm_diag_11.value[0:0];
    xcvr_psm_diag_12: coverpoint xcvr_psm_diag_12.value[0:0];
    xcvr_psm_diag_13: coverpoint xcvr_psm_diag_13.value[0:0];
    xcvr_psm_diag_14: coverpoint xcvr_psm_diag_14.value[0:0];
    xcvr_psm_diag_15: coverpoint xcvr_psm_diag_15.value[0:0];
    xcvr_psm_diag_31_16: coverpoint xcvr_psm_diag_31_16.value[15:0];
  endgroup

  protected virtual function void sample(uvm_reg_data_t data, uvm_reg_data_t byte_en, bit is_read, uvm_reg_map map);
    super.sample(data, byte_en, is_read, map);
    if (get_coverage(UVM_CVR_FIELD_VALS)) begin
      if(!is_read) begin
          wr_fld_covg.sample();
      end
      if(is_read) begin
         rd_fld_covg.sample();
      end
    end
  endfunction

  virtual function void sample_values();
    super.sample_values();
    if (get_coverage(UVM_CVR_FIELD_VALS)) begin
      wr_fld_covg.sample();
      rd_fld_covg.sample();
    end
  endfunction

  virtual function void build();
    uvm_reg_field fld_set[$];
    uvm_reg_field_config_ta ta = get_field_config(getconfigUID());
    build_uvm_reg_fields(this, ta, fld_set);
    
    xcvr_psm_diag_0 = fld_set[0];
    xcvr_psm_diag_1 = fld_set[1];
    xcvr_psm_diag_2 = fld_set[2];
    xcvr_psm_diag_3 = fld_set[3];
    xcvr_psm_diag_4 = fld_set[4];
    xcvr_psm_diag_5 = fld_set[5];
    xcvr_psm_diag_6 = fld_set[6];
    xcvr_psm_diag_7 = fld_set[7];
    xcvr_psm_diag_8 = fld_set[8];
    xcvr_psm_diag_9 = fld_set[9];
    xcvr_psm_diag_10 = fld_set[10];
    xcvr_psm_diag_11 = fld_set[11];
    xcvr_psm_diag_12 = fld_set[12];
    xcvr_psm_diag_13 = fld_set[13];
    xcvr_psm_diag_14 = fld_set[14];
    xcvr_psm_diag_15 = fld_set[15];
    xcvr_psm_diag_31_16 = fld_set[16];
  endfunction

  function new(input string name="T_xcvr_psm_diag_559");
    super.new(name, 32, build_coverage(UVM_CVR_FIELD_VALS));
    if (has_coverage(UVM_CVR_FIELD_VALS)) begin
      wr_fld_covg = new();
      rd_fld_covg = new();
    end
  endfunction

endclass


/////////////////////////////////////////////////////
//                xcvr_psm_rctrl
/////////////////////////////////////////////////////
class T_xcvr_psm_rctrl_542 extends cdns_uvm_reg;

  `uvm_object_utils(T_xcvr_psm_rctrl_542)
  rand uvm_reg_field xcvr_psm_rctrl_0;
  rand uvm_reg_field xcvr_psm_rctrl_1;
  rand uvm_reg_field xcvr_psm_rctrl_2;
  rand uvm_reg_field xcvr_psm_rctrl_3;
  rand uvm_reg_field xcvr_psm_rctrl_4;
  rand uvm_reg_field xcvr_psm_rctrl_5;
  rand uvm_reg_field xcvr_psm_rctrl_6;
  rand uvm_reg_field xcvr_psm_rctrl_7;
  rand uvm_reg_field xcvr_psm_rctrl_8;
  rand uvm_reg_field xcvr_psm_rctrl_9;
  rand uvm_reg_field xcvr_psm_rctrl_10;
  rand uvm_reg_field xcvr_psm_rctrl_11;
  rand uvm_reg_field xcvr_psm_rctrl_12;
  rand uvm_reg_field xcvr_psm_rctrl_13;
  rand uvm_reg_field xcvr_psm_rctrl_14;
  rand uvm_reg_field xcvr_psm_rctrl_15;
  rand uvm_reg_field xcvr_psm_rctrl_31_16;
  
  covergroup wr_fld_covg;
    xcvr_psm_rctrl_0: coverpoint xcvr_psm_rctrl_0.value[0:0];
    xcvr_psm_rctrl_1: coverpoint xcvr_psm_rctrl_1.value[0:0];
    xcvr_psm_rctrl_2: coverpoint xcvr_psm_rctrl_2.value[0:0];
    xcvr_psm_rctrl_3: coverpoint xcvr_psm_rctrl_3.value[0:0];
    xcvr_psm_rctrl_4: coverpoint xcvr_psm_rctrl_4.value[0:0];
    xcvr_psm_rctrl_5: coverpoint xcvr_psm_rctrl_5.value[0:0];
    xcvr_psm_rctrl_6: coverpoint xcvr_psm_rctrl_6.value[0:0];
    xcvr_psm_rctrl_7: coverpoint xcvr_psm_rctrl_7.value[0:0];
    xcvr_psm_rctrl_8: coverpoint xcvr_psm_rctrl_8.value[0:0];
    xcvr_psm_rctrl_9: coverpoint xcvr_psm_rctrl_9.value[0:0];
    xcvr_psm_rctrl_10: coverpoint xcvr_psm_rctrl_10.value[0:0];
    xcvr_psm_rctrl_11: coverpoint xcvr_psm_rctrl_11.value[0:0];
    xcvr_psm_rctrl_12: coverpoint xcvr_psm_rctrl_12.value[0:0];
    xcvr_psm_rctrl_13: coverpoint xcvr_psm_rctrl_13.value[0:0];
    xcvr_psm_rctrl_14: coverpoint xcvr_psm_rctrl_14.value[0:0];
    xcvr_psm_rctrl_15: coverpoint xcvr_psm_rctrl_15.value[0:0];
    xcvr_psm_rctrl_31_16: coverpoint xcvr_psm_rctrl_31_16.value[15:0];
  endgroup
  covergroup rd_fld_covg;
    xcvr_psm_rctrl_0: coverpoint xcvr_psm_rctrl_0.value[0:0];
    xcvr_psm_rctrl_1: coverpoint xcvr_psm_rctrl_1.value[0:0];
    xcvr_psm_rctrl_2: coverpoint xcvr_psm_rctrl_2.value[0:0];
    xcvr_psm_rctrl_3: coverpoint xcvr_psm_rctrl_3.value[0:0];
    xcvr_psm_rctrl_4: coverpoint xcvr_psm_rctrl_4.value[0:0];
    xcvr_psm_rctrl_5: coverpoint xcvr_psm_rctrl_5.value[0:0];
    xcvr_psm_rctrl_6: coverpoint xcvr_psm_rctrl_6.value[0:0];
    xcvr_psm_rctrl_7: coverpoint xcvr_psm_rctrl_7.value[0:0];
    xcvr_psm_rctrl_8: coverpoint xcvr_psm_rctrl_8.value[0:0];
    xcvr_psm_rctrl_9: coverpoint xcvr_psm_rctrl_9.value[0:0];
    xcvr_psm_rctrl_10: coverpoint xcvr_psm_rctrl_10.value[0:0];
    xcvr_psm_rctrl_11: coverpoint xcvr_psm_rctrl_11.value[0:0];
    xcvr_psm_rctrl_12: coverpoint xcvr_psm_rctrl_12.value[0:0];
    xcvr_psm_rctrl_13: coverpoint xcvr_psm_rctrl_13.value[0:0];
    xcvr_psm_rctrl_14: coverpoint xcvr_psm_rctrl_14.value[0:0];
    xcvr_psm_rctrl_15: coverpoint xcvr_psm_rctrl_15.value[0:0];
    xcvr_psm_rctrl_31_16: coverpoint xcvr_psm_rctrl_31_16.value[15:0];
  endgroup

  protected virtual function void sample(uvm_reg_data_t data, uvm_reg_data_t byte_en, bit is_read, uvm_reg_map map);
    super.sample(data, byte_en, is_read, map);
    if (get_coverage(UVM_CVR_FIELD_VALS)) begin
      if(!is_read) begin
          wr_fld_covg.sample();
      end
      if(is_read) begin
         rd_fld_covg.sample();
      end
    end
  endfunction

  virtual function void sample_values();
    super.sample_values();
    if (get_coverage(UVM_CVR_FIELD_VALS)) begin
      wr_fld_covg.sample();
      rd_fld_covg.sample();
    end
  endfunction

  virtual function void build();
    uvm_reg_field fld_set[$];
    uvm_reg_field_config_ta ta = get_field_config(getconfigUID());
    build_uvm_reg_fields(this, ta, fld_set);
    
    xcvr_psm_rctrl_0 = fld_set[0];
    xcvr_psm_rctrl_1 = fld_set[1];
    xcvr_psm_rctrl_2 = fld_set[2];
    xcvr_psm_rctrl_3 = fld_set[3];
    xcvr_psm_rctrl_4 = fld_set[4];
    xcvr_psm_rctrl_5 = fld_set[5];
    xcvr_psm_rctrl_6 = fld_set[6];
    xcvr_psm_rctrl_7 = fld_set[7];
    xcvr_psm_rctrl_8 = fld_set[8];
    xcvr_psm_rctrl_9 = fld_set[9];
    xcvr_psm_rctrl_10 = fld_set[10];
    xcvr_psm_rctrl_11 = fld_set[11];
    xcvr_psm_rctrl_12 = fld_set[12];
    xcvr_psm_rctrl_13 = fld_set[13];
    xcvr_psm_rctrl_14 = fld_set[14];
    xcvr_psm_rctrl_15 = fld_set[15];
    xcvr_psm_rctrl_31_16 = fld_set[16];
  endfunction

  function new(input string name="T_xcvr_psm_rctrl_542");
    super.new(name, 32, build_coverage(UVM_CVR_FIELD_VALS));
    if (has_coverage(UVM_CVR_FIELD_VALS)) begin
      wr_fld_covg = new();
      rd_fld_covg = new();
    end
  endfunction

endclass


/////////////////////////////////////////////////////
//                xcvr_psm_rdy_tmr
/////////////////////////////////////////////////////
class T_xcvr_psm_rdy_tmr_558 extends cdns_uvm_reg;

  `uvm_object_utils(T_xcvr_psm_rdy_tmr_558)
  rand uvm_reg_field xcvr_psm_rdy_tmr_5_0;
  rand uvm_reg_field xcvr_psm_rdy_tmr_15_6;
  rand uvm_reg_field xcvr_psm_rdy_tmr_31_16;
  
  covergroup wr_fld_covg;
    xcvr_psm_rdy_tmr_5_0: coverpoint xcvr_psm_rdy_tmr_5_0.value[5:0];
    xcvr_psm_rdy_tmr_15_6: coverpoint xcvr_psm_rdy_tmr_15_6.value[9:0];
    xcvr_psm_rdy_tmr_31_16: coverpoint xcvr_psm_rdy_tmr_31_16.value[15:0];
  endgroup
  covergroup rd_fld_covg;
    xcvr_psm_rdy_tmr_5_0: coverpoint xcvr_psm_rdy_tmr_5_0.value[5:0];
    xcvr_psm_rdy_tmr_15_6: coverpoint xcvr_psm_rdy_tmr_15_6.value[9:0];
    xcvr_psm_rdy_tmr_31_16: coverpoint xcvr_psm_rdy_tmr_31_16.value[15:0];
  endgroup

  protected virtual function void sample(uvm_reg_data_t data, uvm_reg_data_t byte_en, bit is_read, uvm_reg_map map);
    super.sample(data, byte_en, is_read, map);
    if (get_coverage(UVM_CVR_FIELD_VALS)) begin
      if(!is_read) begin
          wr_fld_covg.sample();
      end
      if(is_read) begin
         rd_fld_covg.sample();
      end
    end
  endfunction

  virtual function void sample_values();
    super.sample_values();
    if (get_coverage(UVM_CVR_FIELD_VALS)) begin
      wr_fld_covg.sample();
      rd_fld_covg.sample();
    end
  endfunction

  virtual function void build();
    uvm_reg_field fld_set[$];
    uvm_reg_field_config_ta ta = get_field_config(getconfigUID());
    build_uvm_reg_fields(this, ta, fld_set);
    
    xcvr_psm_rdy_tmr_5_0 = fld_set[0];
    xcvr_psm_rdy_tmr_15_6 = fld_set[1];
    xcvr_psm_rdy_tmr_31_16 = fld_set[2];
  endfunction

  function new(input string name="T_xcvr_psm_rdy_tmr_558");
    super.new(name, 32, build_coverage(UVM_CVR_FIELD_VALS));
    if (has_coverage(UVM_CVR_FIELD_VALS)) begin
      wr_fld_covg = new();
      rd_fld_covg = new();
    end
  endfunction

endclass


/////////////////////////////////////////////////////
//                xcvr_psm_st_0
/////////////////////////////////////////////////////
class T_xcvr_psm_st_0_560 extends cdns_uvm_reg;

  `uvm_object_utils(T_xcvr_psm_st_0_560)
  rand uvm_reg_field xcvr_psm_st_0_15_0;
  rand uvm_reg_field xcvr_psm_st_0_31_16;
  
  covergroup wr_fld_covg;
    xcvr_psm_st_0_15_0: coverpoint xcvr_psm_st_0_15_0.value[15:0];
    xcvr_psm_st_0_31_16: coverpoint xcvr_psm_st_0_31_16.value[15:0];
  endgroup
  covergroup rd_fld_covg;
    xcvr_psm_st_0_15_0: coverpoint xcvr_psm_st_0_15_0.value[15:0];
    xcvr_psm_st_0_31_16: coverpoint xcvr_psm_st_0_31_16.value[15:0];
  endgroup

  protected virtual function void sample(uvm_reg_data_t data, uvm_reg_data_t byte_en, bit is_read, uvm_reg_map map);
    super.sample(data, byte_en, is_read, map);
    if (get_coverage(UVM_CVR_FIELD_VALS)) begin
      if(!is_read) begin
          wr_fld_covg.sample();
      end
      if(is_read) begin
         rd_fld_covg.sample();
      end
    end
  endfunction

  virtual function void sample_values();
    super.sample_values();
    if (get_coverage(UVM_CVR_FIELD_VALS)) begin
      wr_fld_covg.sample();
      rd_fld_covg.sample();
    end
  endfunction

  virtual function void build();
    uvm_reg_field fld_set[$];
    uvm_reg_field_config_ta ta = get_field_config(getconfigUID());
    build_uvm_reg_fields(this, ta, fld_set);
    
    xcvr_psm_st_0_15_0 = fld_set[0];
    xcvr_psm_st_0_31_16 = fld_set[1];
  endfunction

  function new(input string name="T_xcvr_psm_st_0_560");
    super.new(name, 32, build_coverage(UVM_CVR_FIELD_VALS));
    if (has_coverage(UVM_CVR_FIELD_VALS)) begin
      wr_fld_covg = new();
      rd_fld_covg = new();
    end
  endfunction

endclass


/////////////////////////////////////////////////////
//                xcvr_psm_st_1
/////////////////////////////////////////////////////
class T_xcvr_psm_st_1_561 extends cdns_uvm_reg;

  `uvm_object_utils(T_xcvr_psm_st_1_561)
  rand uvm_reg_field xcvr_psm_st_1_9_0;
  rand uvm_reg_field xcvr_psm_st_1_15_10;
  rand uvm_reg_field xcvr_psm_st_1_31_16;
  
  covergroup wr_fld_covg;
    xcvr_psm_st_1_9_0: coverpoint xcvr_psm_st_1_9_0.value[9:0];
    xcvr_psm_st_1_15_10: coverpoint xcvr_psm_st_1_15_10.value[5:0];
    xcvr_psm_st_1_31_16: coverpoint xcvr_psm_st_1_31_16.value[15:0];
  endgroup
  covergroup rd_fld_covg;
    xcvr_psm_st_1_9_0: coverpoint xcvr_psm_st_1_9_0.value[9:0];
    xcvr_psm_st_1_15_10: coverpoint xcvr_psm_st_1_15_10.value[5:0];
    xcvr_psm_st_1_31_16: coverpoint xcvr_psm_st_1_31_16.value[15:0];
  endgroup

  protected virtual function void sample(uvm_reg_data_t data, uvm_reg_data_t byte_en, bit is_read, uvm_reg_map map);
    super.sample(data, byte_en, is_read, map);
    if (get_coverage(UVM_CVR_FIELD_VALS)) begin
      if(!is_read) begin
          wr_fld_covg.sample();
      end
      if(is_read) begin
         rd_fld_covg.sample();
      end
    end
  endfunction

  virtual function void sample_values();
    super.sample_values();
    if (get_coverage(UVM_CVR_FIELD_VALS)) begin
      wr_fld_covg.sample();
      rd_fld_covg.sample();
    end
  endfunction

  virtual function void build();
    uvm_reg_field fld_set[$];
    uvm_reg_field_config_ta ta = get_field_config(getconfigUID());
    build_uvm_reg_fields(this, ta, fld_set);
    
    xcvr_psm_st_1_9_0 = fld_set[0];
    xcvr_psm_st_1_15_10 = fld_set[1];
    xcvr_psm_st_1_31_16 = fld_set[2];
  endfunction

  function new(input string name="T_xcvr_psm_st_1_561");
    super.new(name, 32, build_coverage(UVM_CVR_FIELD_VALS));
    if (has_coverage(UVM_CVR_FIELD_VALS)) begin
      wr_fld_covg = new();
      rd_fld_covg = new();
    end
  endfunction

endclass


/////////////////////////////////////////////////////
//                xcvr_psm_user_def_ctrl
/////////////////////////////////////////////////////
class T_xcvr_psm_user_def_ctrl_562 extends cdns_uvm_reg;

  `uvm_object_utils(T_xcvr_psm_user_def_ctrl_562)
  rand uvm_reg_field xcvr_psm_user_def_ctrl_0;
  rand uvm_reg_field xcvr_psm_user_def_ctrl_8_1;
  rand uvm_reg_field xcvr_psm_user_def_ctrl_9;
  rand uvm_reg_field xcvr_psm_user_def_ctrl_10;
  rand uvm_reg_field xcvr_psm_user_def_ctrl_11;
  rand uvm_reg_field xcvr_psm_user_def_ctrl_12;
  rand uvm_reg_field xcvr_psm_user_def_ctrl_13;
  rand uvm_reg_field xcvr_psm_user_def_ctrl_14;
  rand uvm_reg_field xcvr_psm_user_def_ctrl_15;
  rand uvm_reg_field xcvr_psm_user_def_ctrl_31_16;
  
  covergroup wr_fld_covg;
    xcvr_psm_user_def_ctrl_0: coverpoint xcvr_psm_user_def_ctrl_0.value[0:0];
    xcvr_psm_user_def_ctrl_8_1: coverpoint xcvr_psm_user_def_ctrl_8_1.value[7:0];
    xcvr_psm_user_def_ctrl_9: coverpoint xcvr_psm_user_def_ctrl_9.value[0:0];
    xcvr_psm_user_def_ctrl_10: coverpoint xcvr_psm_user_def_ctrl_10.value[0:0];
    xcvr_psm_user_def_ctrl_11: coverpoint xcvr_psm_user_def_ctrl_11.value[0:0];
    xcvr_psm_user_def_ctrl_12: coverpoint xcvr_psm_user_def_ctrl_12.value[0:0];
    xcvr_psm_user_def_ctrl_13: coverpoint xcvr_psm_user_def_ctrl_13.value[0:0];
    xcvr_psm_user_def_ctrl_14: coverpoint xcvr_psm_user_def_ctrl_14.value[0:0];
    xcvr_psm_user_def_ctrl_15: coverpoint xcvr_psm_user_def_ctrl_15.value[0:0];
    xcvr_psm_user_def_ctrl_31_16: coverpoint xcvr_psm_user_def_ctrl_31_16.value[15:0];
  endgroup
  covergroup rd_fld_covg;
    xcvr_psm_user_def_ctrl_0: coverpoint xcvr_psm_user_def_ctrl_0.value[0:0];
    xcvr_psm_user_def_ctrl_8_1: coverpoint xcvr_psm_user_def_ctrl_8_1.value[7:0];
    xcvr_psm_user_def_ctrl_9: coverpoint xcvr_psm_user_def_ctrl_9.value[0:0];
    xcvr_psm_user_def_ctrl_10: coverpoint xcvr_psm_user_def_ctrl_10.value[0:0];
    xcvr_psm_user_def_ctrl_11: coverpoint xcvr_psm_user_def_ctrl_11.value[0:0];
    xcvr_psm_user_def_ctrl_12: coverpoint xcvr_psm_user_def_ctrl_12.value[0:0];
    xcvr_psm_user_def_ctrl_13: coverpoint xcvr_psm_user_def_ctrl_13.value[0:0];
    xcvr_psm_user_def_ctrl_14: coverpoint xcvr_psm_user_def_ctrl_14.value[0:0];
    xcvr_psm_user_def_ctrl_15: coverpoint xcvr_psm_user_def_ctrl_15.value[0:0];
    xcvr_psm_user_def_ctrl_31_16: coverpoint xcvr_psm_user_def_ctrl_31_16.value[15:0];
  endgroup

  protected virtual function void sample(uvm_reg_data_t data, uvm_reg_data_t byte_en, bit is_read, uvm_reg_map map);
    super.sample(data, byte_en, is_read, map);
    if (get_coverage(UVM_CVR_FIELD_VALS)) begin
      if(!is_read) begin
          wr_fld_covg.sample();
      end
      if(is_read) begin
         rd_fld_covg.sample();
      end
    end
  endfunction

  virtual function void sample_values();
    super.sample_values();
    if (get_coverage(UVM_CVR_FIELD_VALS)) begin
      wr_fld_covg.sample();
      rd_fld_covg.sample();
    end
  endfunction

  virtual function void build();
    uvm_reg_field fld_set[$];
    uvm_reg_field_config_ta ta = get_field_config(getconfigUID());
    build_uvm_reg_fields(this, ta, fld_set);
    
    xcvr_psm_user_def_ctrl_0 = fld_set[0];
    xcvr_psm_user_def_ctrl_8_1 = fld_set[1];
    xcvr_psm_user_def_ctrl_9 = fld_set[2];
    xcvr_psm_user_def_ctrl_10 = fld_set[3];
    xcvr_psm_user_def_ctrl_11 = fld_set[4];
    xcvr_psm_user_def_ctrl_12 = fld_set[5];
    xcvr_psm_user_def_ctrl_13 = fld_set[6];
    xcvr_psm_user_def_ctrl_14 = fld_set[7];
    xcvr_psm_user_def_ctrl_15 = fld_set[8];
    xcvr_psm_user_def_ctrl_31_16 = fld_set[9];
  endfunction

  function new(input string name="T_xcvr_psm_user_def_ctrl_562");
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
class T_sd3101_phy_registers_654 extends cdns_uvm_reg_block;

  `uvm_object_utils(T_sd3101_phy_registers_654)
  rand T_tx_bist_ctrl_644 tx_bist_ctrl;
  rand T_tx_bist_seed0_646 tx_bist_seed0;
  rand T_tx_bist_seed1_647 tx_bist_seed1;
  rand T_tx_bist_uddwr_645 tx_bist_uddwr;
  rand T_tx_duty_cycle_cal_ctrl_648 tx_duty_cycle_cal_ctrl;
  rand T_tx_duty_cycle_cal_init_tmr_652 tx_duty_cycle_cal_init_tmr;
  rand T_tx_duty_cycle_cal_iter_tmr_653 tx_duty_cycle_cal_iter_tmr;
  rand T_tx_duty_cycle_cal_ovrd_649 tx_duty_cycle_cal_ovrd;
  rand T_tx_duty_cycle_cal_start_650 tx_duty_cycle_cal_start;
  rand T_tx_duty_cycle_cal_tune_651 tx_duty_cycle_cal_tune;
  rand T_tx_psc_a0_632 tx_psc_a0;
  rand T_tx_psc_a1_633 tx_psc_a1;
  rand T_tx_psc_a2_634 tx_psc_a2;
  rand T_tx_psc_a3_635 tx_psc_a3;
  rand T_tx_psc_a4_636 tx_psc_a4;
  rand T_tx_psc_a5_637 tx_psc_a5;
  rand T_tx_psc_cal_638 tx_psc_cal;
  rand T_tx_psc_rdy_639 tx_psc_rdy;
  rand T_tx_rcvdet_ctrl_640 tx_rcvdet_ctrl;
  rand T_tx_rcvdet_en_tmr_642 tx_rcvdet_en_tmr;
  rand T_tx_rcvdet_ovrd_641 tx_rcvdet_ovrd;
  rand T_tx_rcvdet_st_tmr_643 tx_rcvdet_st_tmr;
  rand T_tx_txcc_cpost_mult_00_575 tx_txcc_cpost_mult_00;
  rand T_tx_txcc_cpost_mult_01_576 tx_txcc_cpost_mult_01;
  rand T_tx_txcc_cpost_mult_10_577 tx_txcc_cpost_mult_10;
  rand T_tx_txcc_cpost_mult_11_578 tx_txcc_cpost_mult_11;
  rand T_tx_txcc_cpre_mult_00_571 tx_txcc_cpre_mult_00;
  rand T_tx_txcc_cpre_mult_01_572 tx_txcc_cpre_mult_01;
  rand T_tx_txcc_cpre_mult_10_573 tx_txcc_cpre_mult_10;
  rand T_tx_txcc_cpre_mult_11_574 tx_txcc_cpre_mult_11;
  rand T_tx_txcc_ctrl_563 tx_txcc_ctrl;
  rand T_tx_txcc_ipost_coef_value_616 tx_txcc_ipost_coef_value;
  rand T_tx_txcc_ipre_coef_value_605 tx_txcc_ipre_coef_value;
  rand T_tx_txcc_lf_mult_570 tx_txcc_lf_mult;
  rand T_tx_txcc_main_cval_568 tx_txcc_main_cval;
  rand T_tx_txcc_main_ovrd_565 tx_txcc_main_ovrd;
  rand T_tx_txcc_mgnfs_mult_000_579 tx_txcc_mgnfs_mult_000;
  rand T_tx_txcc_mgnfs_mult_001_580 tx_txcc_mgnfs_mult_001;
  rand T_tx_txcc_mgnfs_mult_010_581 tx_txcc_mgnfs_mult_010;
  rand T_tx_txcc_mgnfs_mult_011_582 tx_txcc_mgnfs_mult_011;
  rand T_tx_txcc_mgnfs_mult_100_583 tx_txcc_mgnfs_mult_100;
  rand T_tx_txcc_mgnfs_mult_101_584 tx_txcc_mgnfs_mult_101;
  rand T_tx_txcc_mgnfs_mult_110_585 tx_txcc_mgnfs_mult_110;
  rand T_tx_txcc_mgnfs_mult_111_586 tx_txcc_mgnfs_mult_111;
  rand T_tx_txcc_mgnhs_mult_000_587 tx_txcc_mgnhs_mult_000;
  rand T_tx_txcc_mgnhs_mult_001_588 tx_txcc_mgnhs_mult_001;
  rand T_tx_txcc_mgnhs_mult_010_589 tx_txcc_mgnhs_mult_010;
  rand T_tx_txcc_mgnhs_mult_011_590 tx_txcc_mgnhs_mult_011;
  rand T_tx_txcc_mgnhs_mult_100_591 tx_txcc_mgnhs_mult_100;
  rand T_tx_txcc_mgnhs_mult_101_592 tx_txcc_mgnhs_mult_101;
  rand T_tx_txcc_mgnhs_mult_110_593 tx_txcc_mgnhs_mult_110;
  rand T_tx_txcc_mgnhs_mult_111_594 tx_txcc_mgnhs_mult_111;
  rand T_tx_txcc_p0post_coef_mult_606 tx_txcc_p0post_coef_mult;
  rand T_tx_txcc_p0pre_coef_mult_595 tx_txcc_p0pre_coef_mult;
  rand T_tx_txcc_p1post_coef_mult_607 tx_txcc_p1post_coef_mult;
  rand T_tx_txcc_p1pre_coef_mult_596 tx_txcc_p1pre_coef_mult;
  rand T_tx_txcc_p2post_coef_mult_608 tx_txcc_p2post_coef_mult;
  rand T_tx_txcc_p2pre_coef_mult_597 tx_txcc_p2pre_coef_mult;
  rand T_tx_txcc_p3post_coef_mult_609 tx_txcc_p3post_coef_mult;
  rand T_tx_txcc_p3pre_coef_mult_598 tx_txcc_p3pre_coef_mult;
  rand T_tx_txcc_p4post_coef_mult_610 tx_txcc_p4post_coef_mult;
  rand T_tx_txcc_p4pre_coef_mult_599 tx_txcc_p4pre_coef_mult;
  rand T_tx_txcc_p5post_coef_mult_611 tx_txcc_p5post_coef_mult;
  rand T_tx_txcc_p5pre_coef_mult_600 tx_txcc_p5pre_coef_mult;
  rand T_tx_txcc_p6post_coef_mult_612 tx_txcc_p6post_coef_mult;
  rand T_tx_txcc_p6pre_coef_mult_601 tx_txcc_p6pre_coef_mult;
  rand T_tx_txcc_p7post_coef_mult_613 tx_txcc_p7post_coef_mult;
  rand T_tx_txcc_p7pre_coef_mult_602 tx_txcc_p7pre_coef_mult;
  rand T_tx_txcc_p8post_coef_mult_614 tx_txcc_p8post_coef_mult;
  rand T_tx_txcc_p8pre_coef_mult_603 tx_txcc_p8pre_coef_mult;
  rand T_tx_txcc_p9post_coef_mult_615 tx_txcc_p9post_coef_mult;
  rand T_tx_txcc_p9pre_coef_mult_604 tx_txcc_p9pre_coef_mult;
  rand T_tx_txcc_post_cval_569 tx_txcc_post_cval;
  rand T_tx_txcc_post_ovrd_566 tx_txcc_post_ovrd;
  rand T_tx_txcc_pre_cval_567 tx_txcc_pre_cval;
  rand T_tx_txcc_pre_ovrd_564 tx_txcc_pre_ovrd;
  rand T_xcvr_diag_bidi_ctrl_627 xcvr_diag_bidi_ctrl;
  rand T_xcvr_diag_enb_ana_dcd_test_631 xcvr_diag_enb_ana_dcd_test;
  rand T_xcvr_diag_hsclk_div_624 xcvr_diag_hsclk_div;
  rand T_xcvr_diag_hsclk_sel_623 xcvr_diag_hsclk_sel;
  rand T_xcvr_diag_plldrc_ctrl_622 xcvr_diag_plldrc_ctrl;
  rand T_xcvr_diag_psc_ovrd_628 xcvr_diag_psc_ovrd;
  rand T_xcvr_diag_pwri_tmr_617 xcvr_diag_pwri_tmr;
  rand T_xcvr_diag_rst_diag_629 xcvr_diag_rst_diag;
  rand T_xcvr_diag_rxclk_ctrl_626 xcvr_diag_rxclk_ctrl;
  rand T_xcvr_diag_txclk_ctrl_625 xcvr_diag_txclk_ctrl;
  rand T_xcvr_diag_xcal_pwri_ovrd_618 xcvr_diag_xcal_pwri_ovrd;
  rand T_xcvr_diag_xcal_pwri_stat_619 xcvr_diag_xcal_pwri_stat;
  rand T_xcvr_diag_xcvr_clk_ctrl_630 xcvr_diag_xcvr_clk_ctrl;
  rand T_xcvr_diag_xdp_pwri_ovrd_620 xcvr_diag_xdp_pwri_ovrd;
  rand T_xcvr_diag_xdp_pwri_stat_621 xcvr_diag_xdp_pwri_stat;
  rand T_xcvr_psm_a0byp_tmr_545 xcvr_psm_a0byp_tmr;
  rand T_xcvr_psm_a0in_tmr_544 xcvr_psm_a0in_tmr;
  rand T_xcvr_psm_a0out_tmr_552 xcvr_psm_a0out_tmr;
  rand T_xcvr_psm_a1in_tmr_546 xcvr_psm_a1in_tmr;
  rand T_xcvr_psm_a1out_tmr_553 xcvr_psm_a1out_tmr;
  rand T_xcvr_psm_a2in_tmr_547 xcvr_psm_a2in_tmr;
  rand T_xcvr_psm_a2out_tmr_554 xcvr_psm_a2out_tmr;
  rand T_xcvr_psm_a3in_tmr_548 xcvr_psm_a3in_tmr;
  rand T_xcvr_psm_a3out_tmr_555 xcvr_psm_a3out_tmr;
  rand T_xcvr_psm_a4in_tmr_549 xcvr_psm_a4in_tmr;
  rand T_xcvr_psm_a4out_tmr_556 xcvr_psm_a4out_tmr;
  rand T_xcvr_psm_a5in_tmr_550 xcvr_psm_a5in_tmr;
  rand T_xcvr_psm_a5out_tmr_557 xcvr_psm_a5out_tmr;
  rand T_xcvr_psm_calin_tmr_543 xcvr_psm_calin_tmr;
  rand T_xcvr_psm_calout_tmr_551 xcvr_psm_calout_tmr;
  rand T_xcvr_psm_ctrl_541 xcvr_psm_ctrl;
  rand T_xcvr_psm_diag_559 xcvr_psm_diag;
  rand T_xcvr_psm_rctrl_542 xcvr_psm_rctrl;
  rand T_xcvr_psm_rdy_tmr_558 xcvr_psm_rdy_tmr;
  rand T_xcvr_psm_st_0_560 xcvr_psm_st_0;
  rand T_xcvr_psm_st_1_561 xcvr_psm_st_1;
  rand T_xcvr_psm_user_def_ctrl_562 xcvr_psm_user_def_ctrl;



  virtual function void build();
    uvm_reg  reg_set[$];
    string config_path = get_hier_path();
    default_map = create_map(get_name(), `UVM_REG_ADDR_WIDTH'h10000, 4, UVM_LITTLE_ENDIAN, 1);
    begin
       uvm_reg_config_ta ta = get_reg_config("pma_tx_lane_registers.sd3101_t4_registers_sd3101_phy_registers");
       build_uvm_regs(default_map, this, null, ta, reg_set);
    end
    if(! $cast(tx_bist_ctrl, reg_set[0]))
      `uvm_error("UVM_REG", "tx_bist_ctrl register casting error")
    if(! $cast(tx_bist_seed0, reg_set[1]))
      `uvm_error("UVM_REG", "tx_bist_seed0 register casting error")
    if(! $cast(tx_bist_seed1, reg_set[2]))
      `uvm_error("UVM_REG", "tx_bist_seed1 register casting error")
    if(! $cast(tx_bist_uddwr, reg_set[3]))
      `uvm_error("UVM_REG", "tx_bist_uddwr register casting error")
    if(! $cast(tx_duty_cycle_cal_ctrl, reg_set[4]))
      `uvm_error("UVM_REG", "tx_duty_cycle_cal_ctrl register casting error")
    if(! $cast(tx_duty_cycle_cal_init_tmr, reg_set[5]))
      `uvm_error("UVM_REG", "tx_duty_cycle_cal_init_tmr register casting error")
    if(! $cast(tx_duty_cycle_cal_iter_tmr, reg_set[6]))
      `uvm_error("UVM_REG", "tx_duty_cycle_cal_iter_tmr register casting error")
    if(! $cast(tx_duty_cycle_cal_ovrd, reg_set[7]))
      `uvm_error("UVM_REG", "tx_duty_cycle_cal_ovrd register casting error")
    if(! $cast(tx_duty_cycle_cal_start, reg_set[8]))
      `uvm_error("UVM_REG", "tx_duty_cycle_cal_start register casting error")
    if(! $cast(tx_duty_cycle_cal_tune, reg_set[9]))
      `uvm_error("UVM_REG", "tx_duty_cycle_cal_tune register casting error")
    if(! $cast(tx_psc_a0, reg_set[10]))
      `uvm_error("UVM_REG", "tx_psc_a0 register casting error")
    if(! $cast(tx_psc_a1, reg_set[11]))
      `uvm_error("UVM_REG", "tx_psc_a1 register casting error")
    if(! $cast(tx_psc_a2, reg_set[12]))
      `uvm_error("UVM_REG", "tx_psc_a2 register casting error")
    if(! $cast(tx_psc_a3, reg_set[13]))
      `uvm_error("UVM_REG", "tx_psc_a3 register casting error")
    if(! $cast(tx_psc_a4, reg_set[14]))
      `uvm_error("UVM_REG", "tx_psc_a4 register casting error")
    if(! $cast(tx_psc_a5, reg_set[15]))
      `uvm_error("UVM_REG", "tx_psc_a5 register casting error")
    if(! $cast(tx_psc_cal, reg_set[16]))
      `uvm_error("UVM_REG", "tx_psc_cal register casting error")
    if(! $cast(tx_psc_rdy, reg_set[17]))
      `uvm_error("UVM_REG", "tx_psc_rdy register casting error")
    if(! $cast(tx_rcvdet_ctrl, reg_set[18]))
      `uvm_error("UVM_REG", "tx_rcvdet_ctrl register casting error")
    if(! $cast(tx_rcvdet_en_tmr, reg_set[19]))
      `uvm_error("UVM_REG", "tx_rcvdet_en_tmr register casting error")
    if(! $cast(tx_rcvdet_ovrd, reg_set[20]))
      `uvm_error("UVM_REG", "tx_rcvdet_ovrd register casting error")
    if(! $cast(tx_rcvdet_st_tmr, reg_set[21]))
      `uvm_error("UVM_REG", "tx_rcvdet_st_tmr register casting error")
    if(! $cast(tx_txcc_cpost_mult_00, reg_set[22]))
      `uvm_error("UVM_REG", "tx_txcc_cpost_mult_00 register casting error")
    if(! $cast(tx_txcc_cpost_mult_01, reg_set[23]))
      `uvm_error("UVM_REG", "tx_txcc_cpost_mult_01 register casting error")
    if(! $cast(tx_txcc_cpost_mult_10, reg_set[24]))
      `uvm_error("UVM_REG", "tx_txcc_cpost_mult_10 register casting error")
    if(! $cast(tx_txcc_cpost_mult_11, reg_set[25]))
      `uvm_error("UVM_REG", "tx_txcc_cpost_mult_11 register casting error")
    if(! $cast(tx_txcc_cpre_mult_00, reg_set[26]))
      `uvm_error("UVM_REG", "tx_txcc_cpre_mult_00 register casting error")
    if(! $cast(tx_txcc_cpre_mult_01, reg_set[27]))
      `uvm_error("UVM_REG", "tx_txcc_cpre_mult_01 register casting error")
    if(! $cast(tx_txcc_cpre_mult_10, reg_set[28]))
      `uvm_error("UVM_REG", "tx_txcc_cpre_mult_10 register casting error")
    if(! $cast(tx_txcc_cpre_mult_11, reg_set[29]))
      `uvm_error("UVM_REG", "tx_txcc_cpre_mult_11 register casting error")
    if(! $cast(tx_txcc_ctrl, reg_set[30]))
      `uvm_error("UVM_REG", "tx_txcc_ctrl register casting error")
    if(! $cast(tx_txcc_ipost_coef_value, reg_set[31]))
      `uvm_error("UVM_REG", "tx_txcc_ipost_coef_value register casting error")
    if(! $cast(tx_txcc_ipre_coef_value, reg_set[32]))
      `uvm_error("UVM_REG", "tx_txcc_ipre_coef_value register casting error")
    if(! $cast(tx_txcc_lf_mult, reg_set[33]))
      `uvm_error("UVM_REG", "tx_txcc_lf_mult register casting error")
    if(! $cast(tx_txcc_main_cval, reg_set[34]))
      `uvm_error("UVM_REG", "tx_txcc_main_cval register casting error")
    if(! $cast(tx_txcc_main_ovrd, reg_set[35]))
      `uvm_error("UVM_REG", "tx_txcc_main_ovrd register casting error")
    if(! $cast(tx_txcc_mgnfs_mult_000, reg_set[36]))
      `uvm_error("UVM_REG", "tx_txcc_mgnfs_mult_000 register casting error")
    if(! $cast(tx_txcc_mgnfs_mult_001, reg_set[37]))
      `uvm_error("UVM_REG", "tx_txcc_mgnfs_mult_001 register casting error")
    if(! $cast(tx_txcc_mgnfs_mult_010, reg_set[38]))
      `uvm_error("UVM_REG", "tx_txcc_mgnfs_mult_010 register casting error")
    if(! $cast(tx_txcc_mgnfs_mult_011, reg_set[39]))
      `uvm_error("UVM_REG", "tx_txcc_mgnfs_mult_011 register casting error")
    if(! $cast(tx_txcc_mgnfs_mult_100, reg_set[40]))
      `uvm_error("UVM_REG", "tx_txcc_mgnfs_mult_100 register casting error")
    if(! $cast(tx_txcc_mgnfs_mult_101, reg_set[41]))
      `uvm_error("UVM_REG", "tx_txcc_mgnfs_mult_101 register casting error")
    if(! $cast(tx_txcc_mgnfs_mult_110, reg_set[42]))
      `uvm_error("UVM_REG", "tx_txcc_mgnfs_mult_110 register casting error")
    if(! $cast(tx_txcc_mgnfs_mult_111, reg_set[43]))
      `uvm_error("UVM_REG", "tx_txcc_mgnfs_mult_111 register casting error")
    if(! $cast(tx_txcc_mgnhs_mult_000, reg_set[44]))
      `uvm_error("UVM_REG", "tx_txcc_mgnhs_mult_000 register casting error")
    if(! $cast(tx_txcc_mgnhs_mult_001, reg_set[45]))
      `uvm_error("UVM_REG", "tx_txcc_mgnhs_mult_001 register casting error")
    if(! $cast(tx_txcc_mgnhs_mult_010, reg_set[46]))
      `uvm_error("UVM_REG", "tx_txcc_mgnhs_mult_010 register casting error")
    if(! $cast(tx_txcc_mgnhs_mult_011, reg_set[47]))
      `uvm_error("UVM_REG", "tx_txcc_mgnhs_mult_011 register casting error")
    if(! $cast(tx_txcc_mgnhs_mult_100, reg_set[48]))
      `uvm_error("UVM_REG", "tx_txcc_mgnhs_mult_100 register casting error")
    if(! $cast(tx_txcc_mgnhs_mult_101, reg_set[49]))
      `uvm_error("UVM_REG", "tx_txcc_mgnhs_mult_101 register casting error")
    if(! $cast(tx_txcc_mgnhs_mult_110, reg_set[50]))
      `uvm_error("UVM_REG", "tx_txcc_mgnhs_mult_110 register casting error")
    if(! $cast(tx_txcc_mgnhs_mult_111, reg_set[51]))
      `uvm_error("UVM_REG", "tx_txcc_mgnhs_mult_111 register casting error")
    if(! $cast(tx_txcc_p0post_coef_mult, reg_set[52]))
      `uvm_error("UVM_REG", "tx_txcc_p0post_coef_mult register casting error")
    if(! $cast(tx_txcc_p0pre_coef_mult, reg_set[53]))
      `uvm_error("UVM_REG", "tx_txcc_p0pre_coef_mult register casting error")
    if(! $cast(tx_txcc_p1post_coef_mult, reg_set[54]))
      `uvm_error("UVM_REG", "tx_txcc_p1post_coef_mult register casting error")
    if(! $cast(tx_txcc_p1pre_coef_mult, reg_set[55]))
      `uvm_error("UVM_REG", "tx_txcc_p1pre_coef_mult register casting error")
    if(! $cast(tx_txcc_p2post_coef_mult, reg_set[56]))
      `uvm_error("UVM_REG", "tx_txcc_p2post_coef_mult register casting error")
    if(! $cast(tx_txcc_p2pre_coef_mult, reg_set[57]))
      `uvm_error("UVM_REG", "tx_txcc_p2pre_coef_mult register casting error")
    if(! $cast(tx_txcc_p3post_coef_mult, reg_set[58]))
      `uvm_error("UVM_REG", "tx_txcc_p3post_coef_mult register casting error")
    if(! $cast(tx_txcc_p3pre_coef_mult, reg_set[59]))
      `uvm_error("UVM_REG", "tx_txcc_p3pre_coef_mult register casting error")
    if(! $cast(tx_txcc_p4post_coef_mult, reg_set[60]))
      `uvm_error("UVM_REG", "tx_txcc_p4post_coef_mult register casting error")
    if(! $cast(tx_txcc_p4pre_coef_mult, reg_set[61]))
      `uvm_error("UVM_REG", "tx_txcc_p4pre_coef_mult register casting error")
    if(! $cast(tx_txcc_p5post_coef_mult, reg_set[62]))
      `uvm_error("UVM_REG", "tx_txcc_p5post_coef_mult register casting error")
    if(! $cast(tx_txcc_p5pre_coef_mult, reg_set[63]))
      `uvm_error("UVM_REG", "tx_txcc_p5pre_coef_mult register casting error")
    if(! $cast(tx_txcc_p6post_coef_mult, reg_set[64]))
      `uvm_error("UVM_REG", "tx_txcc_p6post_coef_mult register casting error")
    if(! $cast(tx_txcc_p6pre_coef_mult, reg_set[65]))
      `uvm_error("UVM_REG", "tx_txcc_p6pre_coef_mult register casting error")
    if(! $cast(tx_txcc_p7post_coef_mult, reg_set[66]))
      `uvm_error("UVM_REG", "tx_txcc_p7post_coef_mult register casting error")
    if(! $cast(tx_txcc_p7pre_coef_mult, reg_set[67]))
      `uvm_error("UVM_REG", "tx_txcc_p7pre_coef_mult register casting error")
    if(! $cast(tx_txcc_p8post_coef_mult, reg_set[68]))
      `uvm_error("UVM_REG", "tx_txcc_p8post_coef_mult register casting error")
    if(! $cast(tx_txcc_p8pre_coef_mult, reg_set[69]))
      `uvm_error("UVM_REG", "tx_txcc_p8pre_coef_mult register casting error")
    if(! $cast(tx_txcc_p9post_coef_mult, reg_set[70]))
      `uvm_error("UVM_REG", "tx_txcc_p9post_coef_mult register casting error")
    if(! $cast(tx_txcc_p9pre_coef_mult, reg_set[71]))
      `uvm_error("UVM_REG", "tx_txcc_p9pre_coef_mult register casting error")
    if(! $cast(tx_txcc_post_cval, reg_set[72]))
      `uvm_error("UVM_REG", "tx_txcc_post_cval register casting error")
    if(! $cast(tx_txcc_post_ovrd, reg_set[73]))
      `uvm_error("UVM_REG", "tx_txcc_post_ovrd register casting error")
    if(! $cast(tx_txcc_pre_cval, reg_set[74]))
      `uvm_error("UVM_REG", "tx_txcc_pre_cval register casting error")
    if(! $cast(tx_txcc_pre_ovrd, reg_set[75]))
      `uvm_error("UVM_REG", "tx_txcc_pre_ovrd register casting error")
    if(! $cast(xcvr_diag_bidi_ctrl, reg_set[76]))
      `uvm_error("UVM_REG", "xcvr_diag_bidi_ctrl register casting error")
    if(! $cast(xcvr_diag_enb_ana_dcd_test, reg_set[77]))
      `uvm_error("UVM_REG", "xcvr_diag_enb_ana_dcd_test register casting error")
    if(! $cast(xcvr_diag_hsclk_div, reg_set[78]))
      `uvm_error("UVM_REG", "xcvr_diag_hsclk_div register casting error")
    if(! $cast(xcvr_diag_hsclk_sel, reg_set[79]))
      `uvm_error("UVM_REG", "xcvr_diag_hsclk_sel register casting error")
    if(! $cast(xcvr_diag_plldrc_ctrl, reg_set[80]))
      `uvm_error("UVM_REG", "xcvr_diag_plldrc_ctrl register casting error")
    if(! $cast(xcvr_diag_psc_ovrd, reg_set[81]))
      `uvm_error("UVM_REG", "xcvr_diag_psc_ovrd register casting error")
    if(! $cast(xcvr_diag_pwri_tmr, reg_set[82]))
      `uvm_error("UVM_REG", "xcvr_diag_pwri_tmr register casting error")
    if(! $cast(xcvr_diag_rst_diag, reg_set[83]))
      `uvm_error("UVM_REG", "xcvr_diag_rst_diag register casting error")
    if(! $cast(xcvr_diag_rxclk_ctrl, reg_set[84]))
      `uvm_error("UVM_REG", "xcvr_diag_rxclk_ctrl register casting error")
    if(! $cast(xcvr_diag_txclk_ctrl, reg_set[85]))
      `uvm_error("UVM_REG", "xcvr_diag_txclk_ctrl register casting error")
    if(! $cast(xcvr_diag_xcal_pwri_ovrd, reg_set[86]))
      `uvm_error("UVM_REG", "xcvr_diag_xcal_pwri_ovrd register casting error")
    if(! $cast(xcvr_diag_xcal_pwri_stat, reg_set[87]))
      `uvm_error("UVM_REG", "xcvr_diag_xcal_pwri_stat register casting error")
    if(! $cast(xcvr_diag_xcvr_clk_ctrl, reg_set[88]))
      `uvm_error("UVM_REG", "xcvr_diag_xcvr_clk_ctrl register casting error")
    if(! $cast(xcvr_diag_xdp_pwri_ovrd, reg_set[89]))
      `uvm_error("UVM_REG", "xcvr_diag_xdp_pwri_ovrd register casting error")
    if(! $cast(xcvr_diag_xdp_pwri_stat, reg_set[90]))
      `uvm_error("UVM_REG", "xcvr_diag_xdp_pwri_stat register casting error")
    if(! $cast(xcvr_psm_a0byp_tmr, reg_set[91]))
      `uvm_error("UVM_REG", "xcvr_psm_a0byp_tmr register casting error")
    if(! $cast(xcvr_psm_a0in_tmr, reg_set[92]))
      `uvm_error("UVM_REG", "xcvr_psm_a0in_tmr register casting error")
    if(! $cast(xcvr_psm_a0out_tmr, reg_set[93]))
      `uvm_error("UVM_REG", "xcvr_psm_a0out_tmr register casting error")
    if(! $cast(xcvr_psm_a1in_tmr, reg_set[94]))
      `uvm_error("UVM_REG", "xcvr_psm_a1in_tmr register casting error")
    if(! $cast(xcvr_psm_a1out_tmr, reg_set[95]))
      `uvm_error("UVM_REG", "xcvr_psm_a1out_tmr register casting error")
    if(! $cast(xcvr_psm_a2in_tmr, reg_set[96]))
      `uvm_error("UVM_REG", "xcvr_psm_a2in_tmr register casting error")
    if(! $cast(xcvr_psm_a2out_tmr, reg_set[97]))
      `uvm_error("UVM_REG", "xcvr_psm_a2out_tmr register casting error")
    if(! $cast(xcvr_psm_a3in_tmr, reg_set[98]))
      `uvm_error("UVM_REG", "xcvr_psm_a3in_tmr register casting error")
    if(! $cast(xcvr_psm_a3out_tmr, reg_set[99]))
      `uvm_error("UVM_REG", "xcvr_psm_a3out_tmr register casting error")
    if(! $cast(xcvr_psm_a4in_tmr, reg_set[100]))
      `uvm_error("UVM_REG", "xcvr_psm_a4in_tmr register casting error")
    if(! $cast(xcvr_psm_a4out_tmr, reg_set[101]))
      `uvm_error("UVM_REG", "xcvr_psm_a4out_tmr register casting error")
    if(! $cast(xcvr_psm_a5in_tmr, reg_set[102]))
      `uvm_error("UVM_REG", "xcvr_psm_a5in_tmr register casting error")
    if(! $cast(xcvr_psm_a5out_tmr, reg_set[103]))
      `uvm_error("UVM_REG", "xcvr_psm_a5out_tmr register casting error")
    if(! $cast(xcvr_psm_calin_tmr, reg_set[104]))
      `uvm_error("UVM_REG", "xcvr_psm_calin_tmr register casting error")
    if(! $cast(xcvr_psm_calout_tmr, reg_set[105]))
      `uvm_error("UVM_REG", "xcvr_psm_calout_tmr register casting error")
    if(! $cast(xcvr_psm_ctrl, reg_set[106]))
      `uvm_error("UVM_REG", "xcvr_psm_ctrl register casting error")
    if(! $cast(xcvr_psm_diag, reg_set[107]))
      `uvm_error("UVM_REG", "xcvr_psm_diag register casting error")
    if(! $cast(xcvr_psm_rctrl, reg_set[108]))
      `uvm_error("UVM_REG", "xcvr_psm_rctrl register casting error")
    if(! $cast(xcvr_psm_rdy_tmr, reg_set[109]))
      `uvm_error("UVM_REG", "xcvr_psm_rdy_tmr register casting error")
    if(! $cast(xcvr_psm_st_0, reg_set[110]))
      `uvm_error("UVM_REG", "xcvr_psm_st_0 register casting error")
    if(! $cast(xcvr_psm_st_1, reg_set[111]))
      `uvm_error("UVM_REG", "xcvr_psm_st_1 register casting error")
    if(! $cast(xcvr_psm_user_def_ctrl, reg_set[112]))
      `uvm_error("UVM_REG", "xcvr_psm_user_def_ctrl register casting error")

  endfunction

  function new(input string name="sd3101_t4_registers_sd3101_phy_registers");
    super.new(name, UVM_NO_COVERAGE);
  endfunction

endclass


/////////////////////////////////////////////////////
//                pma_tx_lane_registers
/////////////////////////////////////////////////////
class pma_tx_lane_registers_vendor_cadence_library_cdns_lib_version_1685_2009 extends cdns_uvm_reg_block;

  `uvm_object_utils(pma_tx_lane_registers_vendor_cadence_library_cdns_lib_version_1685_2009)

  uvm_reg_map default_map;
  uvm_reg_map sd3101_t4_registers;
  rand T_sd3101_phy_registers_654 sd3101_t4_registers_sd3101_phy_registers;

`include "cdn_regmodel_task_member.sv"
  virtual function void build();
    sd3101_t4_registers = create_map("sd3101_t4_registers", `UVM_REG_ADDR_WIDTH'h0, 4, UVM_LITTLE_ENDIAN, 1);
    default_map = sd3101_t4_registers;
    sd3101_t4_registers_sd3101_phy_registers = T_sd3101_phy_registers_654::type_id::create("sd3101_t4_registers_sd3101_phy_registers", , get_full_name());
    sd3101_t4_registers_sd3101_phy_registers.configure(this);
    sd3101_t4_registers_sd3101_phy_registers.build();

    //Mapping sd3101_t4_registers map
    sd3101_t4_registers_sd3101_phy_registers.default_map.add_parent_map(sd3101_t4_registers,`UVM_REG_ADDR_WIDTH'h10000);
    sd3101_t4_registers.set_submap_offset(sd3101_t4_registers_sd3101_phy_registers.default_map, `UVM_REG_ADDR_WIDTH'h10000);
    //Apply hdl_paths
    apply_hdl_paths(this);

  endfunction



  function new(input string name="pma_tx_lane_registers");
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
         "T_tx_bist_ctrl_644": begin T_tx_bist_ctrl_644 tx_bist_ctrl = new(objectname); create = tx_bist_ctrl;  end
         "T_tx_bist_seed0_646": begin T_tx_bist_seed0_646 tx_bist_seed0 = new(objectname); create = tx_bist_seed0;  end
         "T_tx_bist_seed1_647": begin T_tx_bist_seed1_647 tx_bist_seed1 = new(objectname); create = tx_bist_seed1;  end
         "T_tx_bist_uddwr_645": begin T_tx_bist_uddwr_645 tx_bist_uddwr = new(objectname); create = tx_bist_uddwr;  end
         "T_tx_duty_cycle_cal_ctrl_648": begin T_tx_duty_cycle_cal_ctrl_648 tx_duty_cycle_cal_ctrl = new(objectname); create = tx_duty_cycle_cal_ctrl;  end
         "T_tx_duty_cycle_cal_init_tmr_652": begin T_tx_duty_cycle_cal_init_tmr_652 tx_duty_cycle_cal_init_tmr = new(objectname); create = tx_duty_cycle_cal_init_tmr;  end
         "T_tx_duty_cycle_cal_iter_tmr_653": begin T_tx_duty_cycle_cal_iter_tmr_653 tx_duty_cycle_cal_iter_tmr = new(objectname); create = tx_duty_cycle_cal_iter_tmr;  end
         "T_tx_duty_cycle_cal_ovrd_649": begin T_tx_duty_cycle_cal_ovrd_649 tx_duty_cycle_cal_ovrd = new(objectname); create = tx_duty_cycle_cal_ovrd;  end
         "T_tx_duty_cycle_cal_start_650": begin T_tx_duty_cycle_cal_start_650 tx_duty_cycle_cal_start = new(objectname); create = tx_duty_cycle_cal_start;  end
         "T_tx_duty_cycle_cal_tune_651": begin T_tx_duty_cycle_cal_tune_651 tx_duty_cycle_cal_tune = new(objectname); create = tx_duty_cycle_cal_tune;  end
         "T_tx_psc_a0_632": begin T_tx_psc_a0_632 tx_psc_a0 = new(objectname); create = tx_psc_a0;  end
         "T_tx_psc_a1_633": begin T_tx_psc_a1_633 tx_psc_a1 = new(objectname); create = tx_psc_a1;  end
         "T_tx_psc_a2_634": begin T_tx_psc_a2_634 tx_psc_a2 = new(objectname); create = tx_psc_a2;  end
         "T_tx_psc_a3_635": begin T_tx_psc_a3_635 tx_psc_a3 = new(objectname); create = tx_psc_a3;  end
         "T_tx_psc_a4_636": begin T_tx_psc_a4_636 tx_psc_a4 = new(objectname); create = tx_psc_a4;  end
         "T_tx_psc_a5_637": begin T_tx_psc_a5_637 tx_psc_a5 = new(objectname); create = tx_psc_a5;  end
         "T_tx_psc_cal_638": begin T_tx_psc_cal_638 tx_psc_cal = new(objectname); create = tx_psc_cal;  end
         "T_tx_psc_rdy_639": begin T_tx_psc_rdy_639 tx_psc_rdy = new(objectname); create = tx_psc_rdy;  end
         "T_tx_rcvdet_ctrl_640": begin T_tx_rcvdet_ctrl_640 tx_rcvdet_ctrl = new(objectname); create = tx_rcvdet_ctrl;  end
         "T_tx_rcvdet_en_tmr_642": begin T_tx_rcvdet_en_tmr_642 tx_rcvdet_en_tmr = new(objectname); create = tx_rcvdet_en_tmr;  end
         "T_tx_rcvdet_ovrd_641": begin T_tx_rcvdet_ovrd_641 tx_rcvdet_ovrd = new(objectname); create = tx_rcvdet_ovrd;  end
         "T_tx_rcvdet_st_tmr_643": begin T_tx_rcvdet_st_tmr_643 tx_rcvdet_st_tmr = new(objectname); create = tx_rcvdet_st_tmr;  end
         "T_tx_txcc_cpost_mult_00_575": begin T_tx_txcc_cpost_mult_00_575 tx_txcc_cpost_mult_00 = new(objectname); create = tx_txcc_cpost_mult_00;  end
         "T_tx_txcc_cpost_mult_01_576": begin T_tx_txcc_cpost_mult_01_576 tx_txcc_cpost_mult_01 = new(objectname); create = tx_txcc_cpost_mult_01;  end
         "T_tx_txcc_cpost_mult_10_577": begin T_tx_txcc_cpost_mult_10_577 tx_txcc_cpost_mult_10 = new(objectname); create = tx_txcc_cpost_mult_10;  end
         "T_tx_txcc_cpost_mult_11_578": begin T_tx_txcc_cpost_mult_11_578 tx_txcc_cpost_mult_11 = new(objectname); create = tx_txcc_cpost_mult_11;  end
         "T_tx_txcc_cpre_mult_00_571": begin T_tx_txcc_cpre_mult_00_571 tx_txcc_cpre_mult_00 = new(objectname); create = tx_txcc_cpre_mult_00;  end
         "T_tx_txcc_cpre_mult_01_572": begin T_tx_txcc_cpre_mult_01_572 tx_txcc_cpre_mult_01 = new(objectname); create = tx_txcc_cpre_mult_01;  end
         "T_tx_txcc_cpre_mult_10_573": begin T_tx_txcc_cpre_mult_10_573 tx_txcc_cpre_mult_10 = new(objectname); create = tx_txcc_cpre_mult_10;  end
         "T_tx_txcc_cpre_mult_11_574": begin T_tx_txcc_cpre_mult_11_574 tx_txcc_cpre_mult_11 = new(objectname); create = tx_txcc_cpre_mult_11;  end
         "T_tx_txcc_ctrl_563": begin T_tx_txcc_ctrl_563 tx_txcc_ctrl = new(objectname); create = tx_txcc_ctrl;  end
         "T_tx_txcc_ipost_coef_value_616": begin T_tx_txcc_ipost_coef_value_616 tx_txcc_ipost_coef_value = new(objectname); create = tx_txcc_ipost_coef_value;  end
         "T_tx_txcc_ipre_coef_value_605": begin T_tx_txcc_ipre_coef_value_605 tx_txcc_ipre_coef_value = new(objectname); create = tx_txcc_ipre_coef_value;  end
         "T_tx_txcc_lf_mult_570": begin T_tx_txcc_lf_mult_570 tx_txcc_lf_mult = new(objectname); create = tx_txcc_lf_mult;  end
         "T_tx_txcc_main_cval_568": begin T_tx_txcc_main_cval_568 tx_txcc_main_cval = new(objectname); create = tx_txcc_main_cval;  end
         "T_tx_txcc_main_ovrd_565": begin T_tx_txcc_main_ovrd_565 tx_txcc_main_ovrd = new(objectname); create = tx_txcc_main_ovrd;  end
         "T_tx_txcc_mgnfs_mult_000_579": begin T_tx_txcc_mgnfs_mult_000_579 tx_txcc_mgnfs_mult_000 = new(objectname); create = tx_txcc_mgnfs_mult_000;  end
         "T_tx_txcc_mgnfs_mult_001_580": begin T_tx_txcc_mgnfs_mult_001_580 tx_txcc_mgnfs_mult_001 = new(objectname); create = tx_txcc_mgnfs_mult_001;  end
         "T_tx_txcc_mgnfs_mult_010_581": begin T_tx_txcc_mgnfs_mult_010_581 tx_txcc_mgnfs_mult_010 = new(objectname); create = tx_txcc_mgnfs_mult_010;  end
         "T_tx_txcc_mgnfs_mult_011_582": begin T_tx_txcc_mgnfs_mult_011_582 tx_txcc_mgnfs_mult_011 = new(objectname); create = tx_txcc_mgnfs_mult_011;  end
         "T_tx_txcc_mgnfs_mult_100_583": begin T_tx_txcc_mgnfs_mult_100_583 tx_txcc_mgnfs_mult_100 = new(objectname); create = tx_txcc_mgnfs_mult_100;  end
         "T_tx_txcc_mgnfs_mult_101_584": begin T_tx_txcc_mgnfs_mult_101_584 tx_txcc_mgnfs_mult_101 = new(objectname); create = tx_txcc_mgnfs_mult_101;  end
         "T_tx_txcc_mgnfs_mult_110_585": begin T_tx_txcc_mgnfs_mult_110_585 tx_txcc_mgnfs_mult_110 = new(objectname); create = tx_txcc_mgnfs_mult_110;  end
         "T_tx_txcc_mgnfs_mult_111_586": begin T_tx_txcc_mgnfs_mult_111_586 tx_txcc_mgnfs_mult_111 = new(objectname); create = tx_txcc_mgnfs_mult_111;  end
         "T_tx_txcc_mgnhs_mult_000_587": begin T_tx_txcc_mgnhs_mult_000_587 tx_txcc_mgnhs_mult_000 = new(objectname); create = tx_txcc_mgnhs_mult_000;  end
         "T_tx_txcc_mgnhs_mult_001_588": begin T_tx_txcc_mgnhs_mult_001_588 tx_txcc_mgnhs_mult_001 = new(objectname); create = tx_txcc_mgnhs_mult_001;  end
         "T_tx_txcc_mgnhs_mult_010_589": begin T_tx_txcc_mgnhs_mult_010_589 tx_txcc_mgnhs_mult_010 = new(objectname); create = tx_txcc_mgnhs_mult_010;  end
         "T_tx_txcc_mgnhs_mult_011_590": begin T_tx_txcc_mgnhs_mult_011_590 tx_txcc_mgnhs_mult_011 = new(objectname); create = tx_txcc_mgnhs_mult_011;  end
         "T_tx_txcc_mgnhs_mult_100_591": begin T_tx_txcc_mgnhs_mult_100_591 tx_txcc_mgnhs_mult_100 = new(objectname); create = tx_txcc_mgnhs_mult_100;  end
         "T_tx_txcc_mgnhs_mult_101_592": begin T_tx_txcc_mgnhs_mult_101_592 tx_txcc_mgnhs_mult_101 = new(objectname); create = tx_txcc_mgnhs_mult_101;  end
         "T_tx_txcc_mgnhs_mult_110_593": begin T_tx_txcc_mgnhs_mult_110_593 tx_txcc_mgnhs_mult_110 = new(objectname); create = tx_txcc_mgnhs_mult_110;  end
         "T_tx_txcc_mgnhs_mult_111_594": begin T_tx_txcc_mgnhs_mult_111_594 tx_txcc_mgnhs_mult_111 = new(objectname); create = tx_txcc_mgnhs_mult_111;  end
         "T_tx_txcc_p0post_coef_mult_606": begin T_tx_txcc_p0post_coef_mult_606 tx_txcc_p0post_coef_mult = new(objectname); create = tx_txcc_p0post_coef_mult;  end
         "T_tx_txcc_p0pre_coef_mult_595": begin T_tx_txcc_p0pre_coef_mult_595 tx_txcc_p0pre_coef_mult = new(objectname); create = tx_txcc_p0pre_coef_mult;  end
         "T_tx_txcc_p1post_coef_mult_607": begin T_tx_txcc_p1post_coef_mult_607 tx_txcc_p1post_coef_mult = new(objectname); create = tx_txcc_p1post_coef_mult;  end
         "T_tx_txcc_p1pre_coef_mult_596": begin T_tx_txcc_p1pre_coef_mult_596 tx_txcc_p1pre_coef_mult = new(objectname); create = tx_txcc_p1pre_coef_mult;  end
         "T_tx_txcc_p2post_coef_mult_608": begin T_tx_txcc_p2post_coef_mult_608 tx_txcc_p2post_coef_mult = new(objectname); create = tx_txcc_p2post_coef_mult;  end
         "T_tx_txcc_p2pre_coef_mult_597": begin T_tx_txcc_p2pre_coef_mult_597 tx_txcc_p2pre_coef_mult = new(objectname); create = tx_txcc_p2pre_coef_mult;  end
         "T_tx_txcc_p3post_coef_mult_609": begin T_tx_txcc_p3post_coef_mult_609 tx_txcc_p3post_coef_mult = new(objectname); create = tx_txcc_p3post_coef_mult;  end
         "T_tx_txcc_p3pre_coef_mult_598": begin T_tx_txcc_p3pre_coef_mult_598 tx_txcc_p3pre_coef_mult = new(objectname); create = tx_txcc_p3pre_coef_mult;  end
         "T_tx_txcc_p4post_coef_mult_610": begin T_tx_txcc_p4post_coef_mult_610 tx_txcc_p4post_coef_mult = new(objectname); create = tx_txcc_p4post_coef_mult;  end
         "T_tx_txcc_p4pre_coef_mult_599": begin T_tx_txcc_p4pre_coef_mult_599 tx_txcc_p4pre_coef_mult = new(objectname); create = tx_txcc_p4pre_coef_mult;  end
         "T_tx_txcc_p5post_coef_mult_611": begin T_tx_txcc_p5post_coef_mult_611 tx_txcc_p5post_coef_mult = new(objectname); create = tx_txcc_p5post_coef_mult;  end
         "T_tx_txcc_p5pre_coef_mult_600": begin T_tx_txcc_p5pre_coef_mult_600 tx_txcc_p5pre_coef_mult = new(objectname); create = tx_txcc_p5pre_coef_mult;  end
         "T_tx_txcc_p6post_coef_mult_612": begin T_tx_txcc_p6post_coef_mult_612 tx_txcc_p6post_coef_mult = new(objectname); create = tx_txcc_p6post_coef_mult;  end
         "T_tx_txcc_p6pre_coef_mult_601": begin T_tx_txcc_p6pre_coef_mult_601 tx_txcc_p6pre_coef_mult = new(objectname); create = tx_txcc_p6pre_coef_mult;  end
         "T_tx_txcc_p7post_coef_mult_613": begin T_tx_txcc_p7post_coef_mult_613 tx_txcc_p7post_coef_mult = new(objectname); create = tx_txcc_p7post_coef_mult;  end
         "T_tx_txcc_p7pre_coef_mult_602": begin T_tx_txcc_p7pre_coef_mult_602 tx_txcc_p7pre_coef_mult = new(objectname); create = tx_txcc_p7pre_coef_mult;  end
         "T_tx_txcc_p8post_coef_mult_614": begin T_tx_txcc_p8post_coef_mult_614 tx_txcc_p8post_coef_mult = new(objectname); create = tx_txcc_p8post_coef_mult;  end
         "T_tx_txcc_p8pre_coef_mult_603": begin T_tx_txcc_p8pre_coef_mult_603 tx_txcc_p8pre_coef_mult = new(objectname); create = tx_txcc_p8pre_coef_mult;  end
         "T_tx_txcc_p9post_coef_mult_615": begin T_tx_txcc_p9post_coef_mult_615 tx_txcc_p9post_coef_mult = new(objectname); create = tx_txcc_p9post_coef_mult;  end
         "T_tx_txcc_p9pre_coef_mult_604": begin T_tx_txcc_p9pre_coef_mult_604 tx_txcc_p9pre_coef_mult = new(objectname); create = tx_txcc_p9pre_coef_mult;  end
         "T_tx_txcc_post_cval_569": begin T_tx_txcc_post_cval_569 tx_txcc_post_cval = new(objectname); create = tx_txcc_post_cval;  end
         "T_tx_txcc_post_ovrd_566": begin T_tx_txcc_post_ovrd_566 tx_txcc_post_ovrd = new(objectname); create = tx_txcc_post_ovrd;  end
         "T_tx_txcc_pre_cval_567": begin T_tx_txcc_pre_cval_567 tx_txcc_pre_cval = new(objectname); create = tx_txcc_pre_cval;  end
         "T_tx_txcc_pre_ovrd_564": begin T_tx_txcc_pre_ovrd_564 tx_txcc_pre_ovrd = new(objectname); create = tx_txcc_pre_ovrd;  end
         "T_xcvr_diag_bidi_ctrl_627": begin T_xcvr_diag_bidi_ctrl_627 xcvr_diag_bidi_ctrl = new(objectname); create = xcvr_diag_bidi_ctrl;  end
         "T_xcvr_diag_enb_ana_dcd_test_631": begin T_xcvr_diag_enb_ana_dcd_test_631 xcvr_diag_enb_ana_dcd_test = new(objectname); create = xcvr_diag_enb_ana_dcd_test;  end
         "T_xcvr_diag_hsclk_div_624": begin T_xcvr_diag_hsclk_div_624 xcvr_diag_hsclk_div = new(objectname); create = xcvr_diag_hsclk_div;  end
         "T_xcvr_diag_hsclk_sel_623": begin T_xcvr_diag_hsclk_sel_623 xcvr_diag_hsclk_sel = new(objectname); create = xcvr_diag_hsclk_sel;  end
         "T_xcvr_diag_plldrc_ctrl_622": begin T_xcvr_diag_plldrc_ctrl_622 xcvr_diag_plldrc_ctrl = new(objectname); create = xcvr_diag_plldrc_ctrl;  end
         "T_xcvr_diag_psc_ovrd_628": begin T_xcvr_diag_psc_ovrd_628 xcvr_diag_psc_ovrd = new(objectname); create = xcvr_diag_psc_ovrd;  end
         "T_xcvr_diag_pwri_tmr_617": begin T_xcvr_diag_pwri_tmr_617 xcvr_diag_pwri_tmr = new(objectname); create = xcvr_diag_pwri_tmr;  end
         "T_xcvr_diag_rst_diag_629": begin T_xcvr_diag_rst_diag_629 xcvr_diag_rst_diag = new(objectname); create = xcvr_diag_rst_diag;  end
         "T_xcvr_diag_rxclk_ctrl_626": begin T_xcvr_diag_rxclk_ctrl_626 xcvr_diag_rxclk_ctrl = new(objectname); create = xcvr_diag_rxclk_ctrl;  end
         "T_xcvr_diag_txclk_ctrl_625": begin T_xcvr_diag_txclk_ctrl_625 xcvr_diag_txclk_ctrl = new(objectname); create = xcvr_diag_txclk_ctrl;  end
         "T_xcvr_diag_xcal_pwri_ovrd_618": begin T_xcvr_diag_xcal_pwri_ovrd_618 xcvr_diag_xcal_pwri_ovrd = new(objectname); create = xcvr_diag_xcal_pwri_ovrd;  end
         "T_xcvr_diag_xcal_pwri_stat_619": begin T_xcvr_diag_xcal_pwri_stat_619 xcvr_diag_xcal_pwri_stat = new(objectname); create = xcvr_diag_xcal_pwri_stat;  end
         "T_xcvr_diag_xcvr_clk_ctrl_630": begin T_xcvr_diag_xcvr_clk_ctrl_630 xcvr_diag_xcvr_clk_ctrl = new(objectname); create = xcvr_diag_xcvr_clk_ctrl;  end
         "T_xcvr_diag_xdp_pwri_ovrd_620": begin T_xcvr_diag_xdp_pwri_ovrd_620 xcvr_diag_xdp_pwri_ovrd = new(objectname); create = xcvr_diag_xdp_pwri_ovrd;  end
         "T_xcvr_diag_xdp_pwri_stat_621": begin T_xcvr_diag_xdp_pwri_stat_621 xcvr_diag_xdp_pwri_stat = new(objectname); create = xcvr_diag_xdp_pwri_stat;  end
         "T_xcvr_psm_a0byp_tmr_545": begin T_xcvr_psm_a0byp_tmr_545 xcvr_psm_a0byp_tmr = new(objectname); create = xcvr_psm_a0byp_tmr;  end
         "T_xcvr_psm_a0in_tmr_544": begin T_xcvr_psm_a0in_tmr_544 xcvr_psm_a0in_tmr = new(objectname); create = xcvr_psm_a0in_tmr;  end
         "T_xcvr_psm_a0out_tmr_552": begin T_xcvr_psm_a0out_tmr_552 xcvr_psm_a0out_tmr = new(objectname); create = xcvr_psm_a0out_tmr;  end
         "T_xcvr_psm_a1in_tmr_546": begin T_xcvr_psm_a1in_tmr_546 xcvr_psm_a1in_tmr = new(objectname); create = xcvr_psm_a1in_tmr;  end
         "T_xcvr_psm_a1out_tmr_553": begin T_xcvr_psm_a1out_tmr_553 xcvr_psm_a1out_tmr = new(objectname); create = xcvr_psm_a1out_tmr;  end
         "T_xcvr_psm_a2in_tmr_547": begin T_xcvr_psm_a2in_tmr_547 xcvr_psm_a2in_tmr = new(objectname); create = xcvr_psm_a2in_tmr;  end
         "T_xcvr_psm_a2out_tmr_554": begin T_xcvr_psm_a2out_tmr_554 xcvr_psm_a2out_tmr = new(objectname); create = xcvr_psm_a2out_tmr;  end
         "T_xcvr_psm_a3in_tmr_548": begin T_xcvr_psm_a3in_tmr_548 xcvr_psm_a3in_tmr = new(objectname); create = xcvr_psm_a3in_tmr;  end
         "T_xcvr_psm_a3out_tmr_555": begin T_xcvr_psm_a3out_tmr_555 xcvr_psm_a3out_tmr = new(objectname); create = xcvr_psm_a3out_tmr;  end
         "T_xcvr_psm_a4in_tmr_549": begin T_xcvr_psm_a4in_tmr_549 xcvr_psm_a4in_tmr = new(objectname); create = xcvr_psm_a4in_tmr;  end
         "T_xcvr_psm_a4out_tmr_556": begin T_xcvr_psm_a4out_tmr_556 xcvr_psm_a4out_tmr = new(objectname); create = xcvr_psm_a4out_tmr;  end
         "T_xcvr_psm_a5in_tmr_550": begin T_xcvr_psm_a5in_tmr_550 xcvr_psm_a5in_tmr = new(objectname); create = xcvr_psm_a5in_tmr;  end
         "T_xcvr_psm_a5out_tmr_557": begin T_xcvr_psm_a5out_tmr_557 xcvr_psm_a5out_tmr = new(objectname); create = xcvr_psm_a5out_tmr;  end
         "T_xcvr_psm_calin_tmr_543": begin T_xcvr_psm_calin_tmr_543 xcvr_psm_calin_tmr = new(objectname); create = xcvr_psm_calin_tmr;  end
         "T_xcvr_psm_calout_tmr_551": begin T_xcvr_psm_calout_tmr_551 xcvr_psm_calout_tmr = new(objectname); create = xcvr_psm_calout_tmr;  end
         "T_xcvr_psm_ctrl_541": begin T_xcvr_psm_ctrl_541 xcvr_psm_ctrl = new(objectname); create = xcvr_psm_ctrl;  end
         "T_xcvr_psm_diag_559": begin T_xcvr_psm_diag_559 xcvr_psm_diag = new(objectname); create = xcvr_psm_diag;  end
         "T_xcvr_psm_rctrl_542": begin T_xcvr_psm_rctrl_542 xcvr_psm_rctrl = new(objectname); create = xcvr_psm_rctrl;  end
         "T_xcvr_psm_rdy_tmr_558": begin T_xcvr_psm_rdy_tmr_558 xcvr_psm_rdy_tmr = new(objectname); create = xcvr_psm_rdy_tmr;  end
         "T_xcvr_psm_st_0_560": begin T_xcvr_psm_st_0_560 xcvr_psm_st_0 = new(objectname); create = xcvr_psm_st_0;  end
         "T_xcvr_psm_st_1_561": begin T_xcvr_psm_st_1_561 xcvr_psm_st_1 = new(objectname); create = xcvr_psm_st_1;  end
         "T_xcvr_psm_user_def_ctrl_562": begin T_xcvr_psm_user_def_ctrl_562 xcvr_psm_user_def_ctrl = new(objectname); create = xcvr_psm_user_def_ctrl;  end

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
   cdns_uvmreg_utils_pkg_pma_tx_lane_registers::factory=cdns_factory;


   return cdns_factory;
endfunction
cdns_factory_base cdns_factory = get_factory(no_factory);

endpackage



