//*************************************************************//
//   ** File Generated Automatically
//   ** Please donot edit manually
//*************************************************************//


package cdn_illegal_reg_pkg;
  import uvm_pkg::*;
  `include "uvm_macros.svh"
  import cdns_uvmreg_utils_pkg_illegal_registers::*;

  bit no_factory = 0; 

/////////////////////////////////////////////////////
//                cmn_illegal_reg
/////////////////////////////////////////////////////
class T_cmn_illegal_reg_9 extends cdns_uvm_reg;

  `uvm_object_utils(T_cmn_illegal_reg_9)
  rand uvm_reg_field cmn_illegal_reg_31_0;
  
  covergroup wr_fld_covg;
    cmn_illegal_reg_31_0: coverpoint cmn_illegal_reg_31_0.value[31:0];
  endgroup
  covergroup rd_fld_covg;
    cmn_illegal_reg_31_0: coverpoint cmn_illegal_reg_31_0.value[31:0];
  endgroup

  protected virtual function void sample(uvm_reg_data_t data, uvm_reg_data_t byte_en, bit is_read, uvm_reg_map map);
    super.sample(data, byte_en, is_read, map);
    if (get_coverage(UVM_CVR_FIELD_VALS)) begin
      if(!is_read) begin
          wr_fld_covg.sample();
      end
      if(is_read) begin
         rd_fld_covg.sample();
      end
    end
  endfunction

  virtual function void sample_values();
    super.sample_values();
    if (get_coverage(UVM_CVR_FIELD_VALS)) begin
      wr_fld_covg.sample();
      rd_fld_covg.sample();
    end
  endfunction

  virtual function void build();
    uvm_reg_field fld_set[$];
    uvm_reg_field_config_ta ta = get_field_config(getconfigUID());
    build_uvm_reg_fields(this, ta, fld_set);
    
    cmn_illegal_reg_31_0 = fld_set[0];
  endfunction

  function new(input string name="T_cmn_illegal_reg_9");
    super.new(name, 32, build_coverage(UVM_CVR_FIELD_VALS));
    if (has_coverage(UVM_CVR_FIELD_VALS)) begin
      wr_fld_covg = new();
      rd_fld_covg = new();
    end
  endfunction

endclass


/////////////////////////////////////////////////////
//                phy_pcs_cmn_illegal_reg
/////////////////////////////////////////////////////
class T_phy_pcs_cmn_illegal_reg_12 extends cdns_uvm_reg;

  `uvm_object_utils(T_phy_pcs_cmn_illegal_reg_12)
  rand uvm_reg_field phy_pcs_cmn_illegal_reg_31_0;
  
  covergroup wr_fld_covg;
    phy_pcs_cmn_illegal_reg_31_0: coverpoint phy_pcs_cmn_illegal_reg_31_0.value[31:0];
  endgroup
  covergroup rd_fld_covg;
    phy_pcs_cmn_illegal_reg_31_0: coverpoint phy_pcs_cmn_illegal_reg_31_0.value[31:0];
  endgroup

  protected virtual function void sample(uvm_reg_data_t data, uvm_reg_data_t byte_en, bit is_read, uvm_reg_map map);
    super.sample(data, byte_en, is_read, map);
    if (get_coverage(UVM_CVR_FIELD_VALS)) begin
      if(!is_read) begin
          wr_fld_covg.sample();
      end
      if(is_read) begin
         rd_fld_covg.sample();
      end
    end
  endfunction

  virtual function void sample_values();
    super.sample_values();
    if (get_coverage(UVM_CVR_FIELD_VALS)) begin
      wr_fld_covg.sample();
      rd_fld_covg.sample();
    end
  endfunction

  virtual function void build();
    uvm_reg_field fld_set[$];
    uvm_reg_field_config_ta ta = get_field_config(getconfigUID());
    build_uvm_reg_fields(this, ta, fld_set);
    
    phy_pcs_cmn_illegal_reg_31_0 = fld_set[0];
  endfunction

  function new(input string name="T_phy_pcs_cmn_illegal_reg_12");
    super.new(name, 32, build_coverage(UVM_CVR_FIELD_VALS));
    if (has_coverage(UVM_CVR_FIELD_VALS)) begin
      wr_fld_covg = new();
      rd_fld_covg = new();
    end
  endfunction

endclass


/////////////////////////////////////////////////////
//                phy_pcs_lane_illegal_reg
/////////////////////////////////////////////////////
class T_phy_pcs_lane_illegal_reg_14 extends cdns_uvm_reg;

  `uvm_object_utils(T_phy_pcs_lane_illegal_reg_14)
  rand uvm_reg_field phy_pcs_lane_illegal_reg_31_0;
  
  covergroup wr_fld_covg;
    phy_pcs_lane_illegal_reg_31_0: coverpoint phy_pcs_lane_illegal_reg_31_0.value[31:0];
  endgroup
  covergroup rd_fld_covg;
    phy_pcs_lane_illegal_reg_31_0: coverpoint phy_pcs_lane_illegal_reg_31_0.value[31:0];
  endgroup

  protected virtual function void sample(uvm_reg_data_t data, uvm_reg_data_t byte_en, bit is_read, uvm_reg_map map);
    super.sample(data, byte_en, is_read, map);
    if (get_coverage(UVM_CVR_FIELD_VALS)) begin
      if(!is_read) begin
          wr_fld_covg.sample();
      end
      if(is_read) begin
         rd_fld_covg.sample();
      end
    end
  endfunction

  virtual function void sample_values();
    super.sample_values();
    if (get_coverage(UVM_CVR_FIELD_VALS)) begin
      wr_fld_covg.sample();
      rd_fld_covg.sample();
    end
  endfunction

  virtual function void build();
    uvm_reg_field fld_set[$];
    uvm_reg_field_config_ta ta = get_field_config(getconfigUID());
    build_uvm_reg_fields(this, ta, fld_set);
    
    phy_pcs_lane_illegal_reg_31_0 = fld_set[0];
  endfunction

  function new(input string name="T_phy_pcs_lane_illegal_reg_14");
    super.new(name, 32, build_coverage(UVM_CVR_FIELD_VALS));
    if (has_coverage(UVM_CVR_FIELD_VALS)) begin
      wr_fld_covg = new();
      rd_fld_covg = new();
    end
  endfunction

endclass


/////////////////////////////////////////////////////
//                phy_pma_cmn_illegal_reg
/////////////////////////////////////////////////////
class T_phy_pma_cmn_illegal_reg_13 extends cdns_uvm_reg;

  `uvm_object_utils(T_phy_pma_cmn_illegal_reg_13)
  rand uvm_reg_field phy_pma_cmn_illegal_reg_31_0;
  
  covergroup wr_fld_covg;
    phy_pma_cmn_illegal_reg_31_0: coverpoint phy_pma_cmn_illegal_reg_31_0.value[31:0];
  endgroup
  covergroup rd_fld_covg;
    phy_pma_cmn_illegal_reg_31_0: coverpoint phy_pma_cmn_illegal_reg_31_0.value[31:0];
  endgroup

  protected virtual function void sample(uvm_reg_data_t data, uvm_reg_data_t byte_en, bit is_read, uvm_reg_map map);
    super.sample(data, byte_en, is_read, map);
    if (get_coverage(UVM_CVR_FIELD_VALS)) begin
      if(!is_read) begin
          wr_fld_covg.sample();
      end
      if(is_read) begin
         rd_fld_covg.sample();
      end
    end
  endfunction

  virtual function void sample_values();
    super.sample_values();
    if (get_coverage(UVM_CVR_FIELD_VALS)) begin
      wr_fld_covg.sample();
      rd_fld_covg.sample();
    end
  endfunction

  virtual function void build();
    uvm_reg_field fld_set[$];
    uvm_reg_field_config_ta ta = get_field_config(getconfigUID());
    build_uvm_reg_fields(this, ta, fld_set);
    
    phy_pma_cmn_illegal_reg_31_0 = fld_set[0];
  endfunction

  function new(input string name="T_phy_pma_cmn_illegal_reg_13");
    super.new(name, 32, build_coverage(UVM_CVR_FIELD_VALS));
    if (has_coverage(UVM_CVR_FIELD_VALS)) begin
      wr_fld_covg = new();
      rd_fld_covg = new();
    end
  endfunction

endclass


/////////////////////////////////////////////////////
//                phy_pma_lane_illegal_reg
/////////////////////////////////////////////////////
class T_phy_pma_lane_illegal_reg_15 extends cdns_uvm_reg;

  `uvm_object_utils(T_phy_pma_lane_illegal_reg_15)
  rand uvm_reg_field phy_pma_lane_illegal_reg_31_0;
  
  covergroup wr_fld_covg;
    phy_pma_lane_illegal_reg_31_0: coverpoint phy_pma_lane_illegal_reg_31_0.value[31:0];
  endgroup
  covergroup rd_fld_covg;
    phy_pma_lane_illegal_reg_31_0: coverpoint phy_pma_lane_illegal_reg_31_0.value[31:0];
  endgroup

  protected virtual function void sample(uvm_reg_data_t data, uvm_reg_data_t byte_en, bit is_read, uvm_reg_map map);
    super.sample(data, byte_en, is_read, map);
    if (get_coverage(UVM_CVR_FIELD_VALS)) begin
      if(!is_read) begin
          wr_fld_covg.sample();
      end
      if(is_read) begin
         rd_fld_covg.sample();
      end
    end
  endfunction

  virtual function void sample_values();
    super.sample_values();
    if (get_coverage(UVM_CVR_FIELD_VALS)) begin
      wr_fld_covg.sample();
      rd_fld_covg.sample();
    end
  endfunction

  virtual function void build();
    uvm_reg_field fld_set[$];
    uvm_reg_field_config_ta ta = get_field_config(getconfigUID());
    build_uvm_reg_fields(this, ta, fld_set);
    
    phy_pma_lane_illegal_reg_31_0 = fld_set[0];
  endfunction

  function new(input string name="T_phy_pma_lane_illegal_reg_15");
    super.new(name, 32, build_coverage(UVM_CVR_FIELD_VALS));
    if (has_coverage(UVM_CVR_FIELD_VALS)) begin
      wr_fld_covg = new();
      rd_fld_covg = new();
    end
  endfunction

endclass


/////////////////////////////////////////////////////
//                pma_rx_illegal_reg
/////////////////////////////////////////////////////
class T_pma_rx_illegal_reg_11 extends cdns_uvm_reg;

  `uvm_object_utils(T_pma_rx_illegal_reg_11)
  rand uvm_reg_field pma_rx_illegal_reg_31_0;
  
  covergroup wr_fld_covg;
    pma_rx_illegal_reg_31_0: coverpoint pma_rx_illegal_reg_31_0.value[31:0];
  endgroup
  covergroup rd_fld_covg;
    pma_rx_illegal_reg_31_0: coverpoint pma_rx_illegal_reg_31_0.value[31:0];
  endgroup

  protected virtual function void sample(uvm_reg_data_t data, uvm_reg_data_t byte_en, bit is_read, uvm_reg_map map);
    super.sample(data, byte_en, is_read, map);
    if (get_coverage(UVM_CVR_FIELD_VALS)) begin
      if(!is_read) begin
          wr_fld_covg.sample();
      end
      if(is_read) begin
         rd_fld_covg.sample();
      end
    end
  endfunction

  virtual function void sample_values();
    super.sample_values();
    if (get_coverage(UVM_CVR_FIELD_VALS)) begin
      wr_fld_covg.sample();
      rd_fld_covg.sample();
    end
  endfunction

  virtual function void build();
    uvm_reg_field fld_set[$];
    uvm_reg_field_config_ta ta = get_field_config(getconfigUID());
    build_uvm_reg_fields(this, ta, fld_set);
    
    pma_rx_illegal_reg_31_0 = fld_set[0];
  endfunction

  function new(input string name="T_pma_rx_illegal_reg_11");
    super.new(name, 32, build_coverage(UVM_CVR_FIELD_VALS));
    if (has_coverage(UVM_CVR_FIELD_VALS)) begin
      wr_fld_covg = new();
      rd_fld_covg = new();
    end
  endfunction

endclass


/////////////////////////////////////////////////////
//                pma_tx_illegal_reg
/////////////////////////////////////////////////////
class T_pma_tx_illegal_reg_10 extends cdns_uvm_reg;

  `uvm_object_utils(T_pma_tx_illegal_reg_10)
  rand uvm_reg_field pma_tx_illegal_reg_31_0;
  
  covergroup wr_fld_covg;
    pma_tx_illegal_reg_31_0: coverpoint pma_tx_illegal_reg_31_0.value[31:0];
  endgroup
  covergroup rd_fld_covg;
    pma_tx_illegal_reg_31_0: coverpoint pma_tx_illegal_reg_31_0.value[31:0];
  endgroup

  protected virtual function void sample(uvm_reg_data_t data, uvm_reg_data_t byte_en, bit is_read, uvm_reg_map map);
    super.sample(data, byte_en, is_read, map);
    if (get_coverage(UVM_CVR_FIELD_VALS)) begin
      if(!is_read) begin
          wr_fld_covg.sample();
      end
      if(is_read) begin
         rd_fld_covg.sample();
      end
    end
  endfunction

  virtual function void sample_values();
    super.sample_values();
    if (get_coverage(UVM_CVR_FIELD_VALS)) begin
      wr_fld_covg.sample();
      rd_fld_covg.sample();
    end
  endfunction

  virtual function void build();
    uvm_reg_field fld_set[$];
    uvm_reg_field_config_ta ta = get_field_config(getconfigUID());
    build_uvm_reg_fields(this, ta, fld_set);
    
    pma_tx_illegal_reg_31_0 = fld_set[0];
  endfunction

  function new(input string name="T_pma_tx_illegal_reg_10");
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
class T_sd3101_phy_registers_16 extends cdns_uvm_reg_block;

  `uvm_object_utils(T_sd3101_phy_registers_16)
  rand T_cmn_illegal_reg_9 cmn_illegal_reg;
  rand T_phy_pcs_cmn_illegal_reg_12 phy_pcs_cmn_illegal_reg;
  rand T_phy_pcs_lane_illegal_reg_14 phy_pcs_lane_illegal_reg;
  rand T_phy_pma_cmn_illegal_reg_13 phy_pma_cmn_illegal_reg;
  rand T_phy_pma_lane_illegal_reg_15 phy_pma_lane_illegal_reg;
  rand T_pma_rx_illegal_reg_11 pma_rx_illegal_reg;
  rand T_pma_tx_illegal_reg_10 pma_tx_illegal_reg;



  virtual function void build();
    uvm_reg  reg_set[$];
    string config_path = get_hier_path();
    default_map = create_map(get_name(), `UVM_REG_ADDR_WIDTH'h0, 4, UVM_LITTLE_ENDIAN, 1);
    begin
       uvm_reg_config_ta ta = get_reg_config("illegal_registers.sd3101_t4_registers_sd3101_phy_registers");
       build_uvm_regs(default_map, this, null, ta, reg_set);
    end
    if(! $cast(cmn_illegal_reg, reg_set[0]))
      `uvm_error("UVM_REG", "cmn_illegal_reg register casting error")
    if(! $cast(phy_pcs_cmn_illegal_reg, reg_set[1]))
      `uvm_error("UVM_REG", "phy_pcs_cmn_illegal_reg register casting error")
    if(! $cast(phy_pcs_lane_illegal_reg, reg_set[2]))
      `uvm_error("UVM_REG", "phy_pcs_lane_illegal_reg register casting error")
    if(! $cast(phy_pma_cmn_illegal_reg, reg_set[3]))
      `uvm_error("UVM_REG", "phy_pma_cmn_illegal_reg register casting error")
    if(! $cast(phy_pma_lane_illegal_reg, reg_set[4]))
      `uvm_error("UVM_REG", "phy_pma_lane_illegal_reg register casting error")
    if(! $cast(pma_rx_illegal_reg, reg_set[5]))
      `uvm_error("UVM_REG", "pma_rx_illegal_reg register casting error")
    if(! $cast(pma_tx_illegal_reg, reg_set[6]))
      `uvm_error("UVM_REG", "pma_tx_illegal_reg register casting error")

  endfunction

  function new(input string name="sd3101_t4_registers_sd3101_phy_registers");
    super.new(name, UVM_NO_COVERAGE);
  endfunction

endclass


/////////////////////////////////////////////////////
//                illegal_registers
/////////////////////////////////////////////////////
class illegal_registers_vendor_cadence_library_cdns_lib_version_1685_2009 extends cdns_uvm_reg_block;

  `uvm_object_utils(illegal_registers_vendor_cadence_library_cdns_lib_version_1685_2009)

  uvm_reg_map default_map;
  uvm_reg_map sd3101_t4_registers;
  rand T_sd3101_phy_registers_16 sd3101_t4_registers_sd3101_phy_registers;

`include "cdn_regmodel_task_member.sv"
  virtual function void build();
    sd3101_t4_registers = create_map("sd3101_t4_registers", `UVM_REG_ADDR_WIDTH'h0, 4, UVM_LITTLE_ENDIAN, 1);
    default_map = sd3101_t4_registers;
    sd3101_t4_registers_sd3101_phy_registers = T_sd3101_phy_registers_16::type_id::create("sd3101_t4_registers_sd3101_phy_registers", , get_full_name());
    sd3101_t4_registers_sd3101_phy_registers.configure(this);
    sd3101_t4_registers_sd3101_phy_registers.build();

    //Mapping sd3101_t4_registers map
    sd3101_t4_registers_sd3101_phy_registers.default_map.add_parent_map(sd3101_t4_registers,`UVM_REG_ADDR_WIDTH'h0);
    sd3101_t4_registers.set_submap_offset(sd3101_t4_registers_sd3101_phy_registers.default_map, `UVM_REG_ADDR_WIDTH'h0);
    //Apply hdl_paths
    apply_hdl_paths(this);

  endfunction



  function new(input string name="illegal_registers");
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
         "T_cmn_illegal_reg_9": begin T_cmn_illegal_reg_9 cmn_illegal_reg = new(objectname); create = cmn_illegal_reg;  end
         "T_phy_pcs_cmn_illegal_reg_12": begin T_phy_pcs_cmn_illegal_reg_12 phy_pcs_cmn_illegal_reg = new(objectname); create = phy_pcs_cmn_illegal_reg;  end
         "T_phy_pcs_lane_illegal_reg_14": begin T_phy_pcs_lane_illegal_reg_14 phy_pcs_lane_illegal_reg = new(objectname); create = phy_pcs_lane_illegal_reg;  end
         "T_phy_pma_cmn_illegal_reg_13": begin T_phy_pma_cmn_illegal_reg_13 phy_pma_cmn_illegal_reg = new(objectname); create = phy_pma_cmn_illegal_reg;  end
         "T_phy_pma_lane_illegal_reg_15": begin T_phy_pma_lane_illegal_reg_15 phy_pma_lane_illegal_reg = new(objectname); create = phy_pma_lane_illegal_reg;  end
         "T_pma_rx_illegal_reg_11": begin T_pma_rx_illegal_reg_11 pma_rx_illegal_reg = new(objectname); create = pma_rx_illegal_reg;  end
         "T_pma_tx_illegal_reg_10": begin T_pma_tx_illegal_reg_10 pma_tx_illegal_reg = new(objectname); create = pma_tx_illegal_reg;  end

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
   cdns_uvmreg_utils_pkg_illegal_registers::factory=cdns_factory;


   return cdns_factory;
endfunction
cdns_factory_base cdns_factory = get_factory(no_factory);

endpackage



