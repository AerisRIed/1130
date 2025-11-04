`ifndef HIER_DEFINES__SVH
`define HIER_DEFINES__SVH
//NOTE:just a demo from torrent
    `define DUT          i_dut
    `define PHY_REV      `DUT.u_mp_phy_rev
    `define PCS_ISO_CMN  `PHY_REV.u_pcs_iso_ctrl_cmn
`endif