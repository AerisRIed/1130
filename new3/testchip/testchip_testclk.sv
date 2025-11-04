

module testchip_testclk (
input                  scanen,
input                  reset_n,
// Test Clock
input                  noc_clk,
input                  uc_clk,
input                  cdb_pclk,
input                  cmn_refclk0_int,
input                  cmn_refclk1_int,
input                  tcauxda_0_pll_refclk_out, 
input                  tcauxda_1_pll_refclk_out,
input                  test_clk_phy,
input                  test_clk_pam3,
input [3:0]            test_clk_sel,
input                  test_clk_en,
output                 test_clk
);
//****************************************
//[sel=0000] test_clk_pam3             ─┐
//[sel=0001] uc_clk                     ├─┐
//[sel=0010] cmn_refclk0_int            ┤ │  ┌──────────────┐
//[sel=0011] cmn_refclk1_int            ┤ │  │ Priority     │
//[sel=0100] tcauxda_0_pll_refclk_out   ┤ │  │ if sel[3]=1  │
//[sel=0101] tcauxda_1_pll_refclk_out   ┤ │  │   → test_phy │
//[sel=0110] noc_clk                    ┤ │  │ else decode  │
//[sel=0111] cdb_pclk                   ┤ │  └──────────────┘
//[sel=1xxx] test_clk_phy             ──┘──────────→ test_clk_out
//****************************************

// Level 1: 8 inputs -> 4 (sel[0] selects even vs odd codes)
wire l1_clk_0, l1_clk_1, l1_clk_2, l1_clk_3;
phy_clock_mux u_l1_clk_mux_0(.clk_in({uc_clk,                   test_clk_pam3            }), .clk_sel(sel[0]), .clk_out(l1_clk_0)); // 0000 vs 0001
phy_clock_mux u_l1_clk_mux_1(.clk_in({cmn_refclk1_int,          cmn_refclk0_int          }), .clk_sel(sel[0]), .clk_out(l1_clk_1)); // 0010 vs 0011
phy_clock_mux u_l1_clk_mux_2(.clk_in({tcauxda_1_pll_refclk_out, tcauxda_0_pll_refclk_out }), .clk_sel(sel[0]), .clk_out(l1_clk_2)); // 0100 vs 0101
phy_clock_mux u_l1_clk_mux_3(.clk_in({cdb_pclk,                 noc_clk                  }), .clk_sel(sel[0]), .clk_out(l1_clk_3)); // 0110 vs 0111

// Level 2: 4 inputs -> 2 (sel[1])
wire l2_clk_0, l2_clk_1;
phy_clock_mux u_l2_clk_mux_0(.clk_in({l1_clk_1, l1_clk_0}), .clk_sel(sel[1]), .clk_out(l2_clk_0)); // lower half: 00xx vs 00xx
phy_clock_mux u_l2_clk_mux_1(.clk_in({l1_clk_3, l1_clk_2}), .clk_sel(sel[1]), .clk_out(l2_clk_1)); // upper half: 01xx vs 01xx

// Level 3: 2 inputs -> 1 (sel[2]) → final 8:1 result for sel[2:0]
wire l3_clk;
phy_clock_mux u_l3_clk_mux_0(.clk_in({l2_clk_1, l2_clk_0}), .clk_sel(sel[2]), .clk_out(l3_clk)); // 00xx vs 01xx

// Final priority: sel[3] overrides with test_clk_phy when =1
phy_clock_mux u_final_clk_mux(.clk_in({test_clk_phy, l3_clk}), .clk_sel(sel[3]), .clk_out(test_clk_out)); // 0xxx vs 1xxx

// Clock gating
phy_clk_gating_cell u_test_clk_gating(/*autoinst*/
        .reset_n                (reset_n                        ), //input
        .en                     (test_clk_en                    ), //input
        .scanen                 (scanen                         ), //input
        .clk_in                 (test_clk_out                   ), //input
        .en_synced              (/* unconnected */              ), //output
        .en_ack                 (/* unconnected */              ), //output
        .clk_out                (test_clk                       )  //output
    );

endmodule

// Local Variables:
// verilog-library-directories:("../../reuse/rtl_phy_misc_components")
// End:


