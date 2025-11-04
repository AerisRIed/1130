//********************************************************
//* Cadence.
//*
//*Author                   : chao.huang 
//*Email                    : chaoh@cadence.com
//*Filename                 : clk_if_pkg.sv
//*Description  :                                         
//
//
//--------------------------------------------------------
//* Date	          Modified By		   Reason
//2025-05-22 01:40
//
//--------------------------------------------------------
//*******************************************************
package clk_if_pkg;

    import tb_param::*;

    typedef virtual clk_if #(
        .NUM_CLK_EN(tb_param::NUM_CLK_EN) 
    ) clk_vif_t;
  
endpackage : clk_if_pkg

