class sd3101_t4_proj_params(object):
   """SD3101 T4  Project Parameters to drive reg generation - done this way to prevent needing to parse/read a file"""

   def __init__(self, lft_lns, rght_lns):
      import os
      # TODO: Use correct paths
      #ipxact_path            = os.environ['PHY_DESIGN_AREA']+'/ipxact/'
      #ipxact_pma_path        = os.environ['PMA_WORK_AREA']+'/ipxact/'
      ipxact_path            = os.environ['PHY_VERIF_AREA']+'/reg_model/ipxact/t4/'
      ipxact_pma_path        = os.environ['PHY_DESIGN_AREA']+'/ipxact/'
      pma_const_path         = os.environ['PHY_VERIF_AREA']+'/verif/tb_directed/tb/'
      self.const_gen         = 1
      self.ln_cfg            = str(lft_lns)+str(rght_lns)
      self.const_file        = pma_const_path+'pma_'+self.ln_cfg+'_regs_const.v'
      self.sve               = 'sd_cve_sve_u'
      self.reg_width         = 32
      self.addr_width        = 16
      self.addr_offset       = 4

      self.adr_map_dict = {}
      self.adr_map_dict['cmn_cdb_psel']     = '0000000' 
      self.adr_map_dict['xcvr_cdb_psel_tx'] = '0100000' 
      self.adr_map_dict['xcvr_cdb_psel_rx'] = '1000000'

      self.src_files         = []
      self.src_files.append(ipxact_pma_path+'cdns_usb_phy_regs.xml')

      self.dest_file         = ipxact_path+'sd3101_t4gp_'
      self.num_lft_lns       = lft_lns
      self.num_rght_lns      = rght_lns
      self.mem_library       = 'sd3101_t4'
      self.mem_name          = 'sd3101_t4_registers'
      self.mem_map_name      = 'sd3101_phy_registers'
      self.pma_xml_is_ipxact = False
      self.phy_xml_is_ipxact = False

      self.ln_adr_blk_dict  = {}
      self.cmn_adr_blk_dict = {}

      #Address Block Ranges - Indicates the Base Address and Range of the Register File List
      self.adr_blk_dict = {}
      #PMA Address Range --- address range = base +rng such as : 'base': 0x00000, 'rng': 0x1fff -----> reg address will be selected from 0x0 to 0x1fff
      self.adr_blk_dict['pma_cmn_registers']      = {'base': 0x00000, 'rng': 0x1fff} 
      self.adr_blk_dict['pma_tx_lane_registers']  = {'base': 0x10000, 'rng': 0x7ff}
      self.adr_blk_dict['pma_rx_lane_registers']  = {'base': 0x20000, 'rng': 0x7ff}
      #PHY Address Range
      self.adr_blk_dict['phy_pcs_cmn_registers']  = {'base': 0x30000, 'rng': 0x3ff}
      self.adr_blk_dict['phy_pcs_lane_registers'] = {'base': 0x34000, 'rng': 0x3ff}
      self.adr_blk_dict['phy_pma_cmn_registers']  = {'base': 0x38000, 'rng': 0x3ff}
      self.adr_blk_dict['phy_pma_lane_registers'] = {'base': 0x3C000, 'rng': 0x3ff}

      self.override_dict     = {}
# TODO: Change default values based on process, and number of lanes
      # self.override_dict['cmn_pid_num']           = 0x1601 
      #self.override_dict['cmn_pid_lanes']         = (lft_lns * 0x100) + rght_lns
      # self.override_dict['cmn_pid_rev']           = 0x100
      # self.override_dict['cmn_pid_metal0']        = 0x0002
      # self.override_dict['cmn_pid_metal1']        = 0x0
      # self.override_dict['cmn_pid_metal2']        = 0x213
      # self.override_dict['cmn_pid_metal3']        = 0x20
