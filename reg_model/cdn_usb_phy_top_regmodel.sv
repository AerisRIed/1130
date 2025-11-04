`ifndef CDN_USB_PHY_TOP_REGMODEL_SV
`define CDN_USB_PHY_TOP_REGMODEL_SV


  import uvm_pkg::*;
`include "uvm_macros.svh"
  import cdn_phy_pcs_cmn_reg_pkg::*;
  import cdn_phy_pcs_lane_reg_pkg::*;
  import cdn_phy_pma_cmn_reg_pkg::*;
  import cdn_phy_pma_lane_reg_pkg::*;
  import cdn_pma_rx_lane_reg_pkg::*;
  import cdn_pma_tx_lane_reg_pkg::*;
  import cdn_pma_cmn_reg_pkg::*;
  import cdn_illegal_reg_pkg::*;

class cdn_usb_phy_top_regmodel extends uvm_reg_block;

  uvm_reg_map default_map;
  uvm_reg_map cdn_usb4_phy_top_reg_map;

  mailbox reg_access_mbx = new(1);
  int reg_access_mbx_value;
  bit pending_update = 0;
  bit di_control_write;
  bit try_read_in_progress;
  bit concurrent_reg = 0;
  bit [63:0] phy_pcs_cmn_base_addr[4] = {'h0000,'h800,'h1000,'h1800};
  bit [63:0] phy_pma_cmn_base_addr[4] = {'h0000,'h800,'h1000,'h1800};
  bit [63:0] pma_rx_lane_base_addr[4] = {'h0000,'h800,'h1000,'h1800};
  bit [63:0] pma_tx_lane_base_addr[4] = {'h0000,'h800,'h1000,'h1800};

  `uvm_object_utils(cdn_usb_phy_top_regmodel)
  rand phy_pcs_cmn_registers_vendor_cadence_library_cdns_lib_version_1685_2009    phy_pcs_cmn_reg_block;
  rand phy_pcs_lane_registers_vendor_cadence_library_cdns_lib_version_1685_2009   phy_pcs_lane_reg_block[4];
  rand phy_pma_cmn_registers_vendor_cadence_library_cdns_lib_version_1685_2009    phy_pma_cmn_reg_block;
  rand phy_pma_lane_registers_vendor_cadence_library_cdns_lib_version_1685_2009   phy_pma_lane_reg_block[4];
  rand pma_rx_lane_registers_vendor_cadence_library_cdns_lib_version_1685_2009    pma_rx_lane_reg_block[4];
  rand pma_tx_lane_registers_vendor_cadence_library_cdns_lib_version_1685_2009    pma_tx_lane_reg_block[4];
  rand pma_cmn_registers_vendor_cadence_library_cdns_lib_version_1685_2009        pma_cmn_reg_block;
  rand illegal_registers_vendor_cadence_library_cdns_lib_version_1685_2009        illegal_reg_block;

  function new(input string name="cdn_usb_phy_top_regmodel");
    super.new(name, UVM_NO_COVERAGE);
  endfunction


  virtual function void build();
    cdn_usb4_phy_top_reg_map = create_map("cdn_usb4_phy_top_reg_map", `UVM_REG_ADDR_WIDTH'h0, 4, UVM_LITTLE_ENDIAN, 0);
    default_map = cdn_usb4_phy_top_reg_map;
    
    phy_pcs_cmn_reg_block= phy_pcs_cmn_registers_vendor_cadence_library_cdns_lib_version_1685_2009::type_id::create("phy_pcs_cmn_reg_block", , get_full_name());
    phy_pma_cmn_reg_block= phy_pma_cmn_registers_vendor_cadence_library_cdns_lib_version_1685_2009::type_id::create("phy_pma_cmn_reg_block", , get_full_name());
    pma_cmn_reg_block= pma_cmn_registers_vendor_cadence_library_cdns_lib_version_1685_2009::type_id::create("pma_cmn_reg_block", , get_full_name());
    illegal_reg_block= illegal_registers_vendor_cadence_library_cdns_lib_version_1685_2009::type_id::create("illegal_reg_block", , get_full_name());
    
    foreach (phy_pcs_lane_reg_block[i]) begin
      string inst_name = $sformatf("phy_pcs_lane_reg_block_%0d", i); 
      phy_pcs_lane_reg_block[i] = phy_pcs_lane_registers_vendor_cadence_library_cdns_lib_version_1685_2009::type_id::create(inst_name);

      // Parent is this (container block)
      phy_pcs_lane_reg_block[i].configure(this);

      // Build the sub-block’s registers
      phy_pcs_lane_reg_block[i].build();
      phy_pcs_lane_reg_block[i].lock_model();

      // Add its map into the parent map at its base
      cdn_usb4_phy_top_reg_map.add_submap(phy_pcs_lane_reg_block[i].default_map, phy_pcs_cmn_base_addr[i]);
    end   

    foreach (phy_pma_lane_reg_block[i]) begin
      string inst_name = $sformatf("phy_pma_lane_reg_block_%0d", i); 
      phy_pma_lane_reg_block[i] = phy_pma_lane_registers_vendor_cadence_library_cdns_lib_version_1685_2009::type_id::create(inst_name);

      // Parent is this (container block)
      phy_pma_lane_reg_block[i].configure(this);

      // Build the sub-block’s registers
      phy_pma_lane_reg_block[i].build();
      phy_pma_lane_reg_block[i].lock_model();

      // Add its map into the parent map at its base
      cdn_usb4_phy_top_reg_map.add_submap(phy_pma_lane_reg_block[i].default_map, phy_pma_cmn_base_addr[i]);
    end 

    foreach (pma_rx_lane_reg_block[i]) begin
      string inst_name = $sformatf("pma_rx_lane_reg_block_%0d", i); 
      pma_rx_lane_reg_block[i] = pma_rx_lane_registers_vendor_cadence_library_cdns_lib_version_1685_2009::type_id::create(inst_name);

      // Parent is this (container block)
      pma_rx_lane_reg_block[i].configure(this);

      // Build the sub-block’s registers
      pma_rx_lane_reg_block[i].build();
      pma_rx_lane_reg_block[i].lock_model();

      // Add its map into the parent map at its base
      cdn_usb4_phy_top_reg_map.add_submap(pma_rx_lane_reg_block[i].default_map, pma_rx_lane_base_addr[i]);
    end 

    foreach (pma_tx_lane_reg_block[i]) begin
      string inst_name = $sformatf("pma_tx_lane_reg_block_%0d", i); 
      pma_tx_lane_reg_block[i] = pma_tx_lane_registers_vendor_cadence_library_cdns_lib_version_1685_2009::type_id::create(inst_name);

      // Parent is this (container block)
      pma_tx_lane_reg_block[i].configure(this);

      // Build the sub-block’s registers
      pma_tx_lane_reg_block[i].build();
      pma_tx_lane_reg_block[i].lock_model();

      // Add its map into the parent map at its base
      cdn_usb4_phy_top_reg_map.add_submap(pma_tx_lane_reg_block[i].default_map, pma_tx_lane_base_addr[i]);
    end 
 
    phy_pcs_cmn_reg_block.configure(this);
    phy_pcs_cmn_reg_block.build();
    phy_pma_cmn_reg_block.configure(this);
    phy_pma_cmn_reg_block.build();
    pma_cmn_reg_block.configure(this);
    pma_cmn_reg_block.build();
    illegal_reg_block.configure(this);
    illegal_reg_block.build();
    cdn_usb4_phy_top_reg_map.add_submap(phy_pcs_cmn_reg_block.default_map, `UVM_REG_ADDR_WIDTH'h0);
    cdn_usb4_phy_top_reg_map.add_submap(phy_pma_cmn_reg_block.default_map, `UVM_REG_ADDR_WIDTH'h0);
    cdn_usb4_phy_top_reg_map.add_submap(pma_cmn_reg_block.default_map, `UVM_REG_ADDR_WIDTH'h0);
    cdn_usb4_phy_top_reg_map.add_submap(illegal_reg_block.default_map, `UVM_REG_ADDR_WIDTH'h0);

    phy_pcs_cmn_reg_block.lock_model();
    //Apply hdl_paths
    //apply_hdl_paths(this);

  endfunction
endclass

`endif
