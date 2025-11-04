//synth filelist
////////////////////////////////This is the STD cell for synthesis
$PHY_DESIGN_AREA/design/tc_synth/phy_and_synth.v
$PHY_DESIGN_AREA/design/tc_synth/phy_clk_buffer.v
$PHY_DESIGN_AREA/design/tc_synth/phy_clk_gate.v
$PHY_DESIGN_AREA/design/tc_synth/phy_clk_inv.v
$PHY_DESIGN_AREA/design/tc_synth/phy_clk_or.v
$PHY_DESIGN_AREA/design/tc_synth/phy_clock_mux.v
$PHY_DESIGN_AREA/design/tc_synth/phy_mux4to1_synth.v
$PHY_DESIGN_AREA/design/tc_synth/phy_data_sync.sv
$PHY_DESIGN_AREA/design/tc_synth/phy_reset_sync.v
$PHY_DESIGN_AREA/design/tc_synth/phy_scan_mux.v

////this is a lowest level instance that the above modules may instant this
////modules, besides the PMA would instant these modules too.

$PHY_DESIGN_AREA/design/tc_synth/common_synth/clk_gating_and_synth.v
$PHY_DESIGN_AREA/design/tc_synth/common_synth/clk_gating_cell_synth.v
$PHY_DESIGN_AREA/design/tc_synth/common_synth/data_sync_synth.v
$PHY_DESIGN_AREA/design/tc_synth/common_synth/reset_sync_synth.v
$PHY_DESIGN_AREA/design/tc_synth/common_synth/scan_mux_synth.v
$PHY_DESIGN_AREA/design/tc_synth/common_synth/clock_mux_synth.v
