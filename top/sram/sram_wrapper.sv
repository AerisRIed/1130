// ------------------------------------------------------------------------------------------------
//    This confidential and proprietary HDL soft description of a Hardware component may be used 
//    only as authorized by a licensing agreement from Cadence. In the event of publication,the 
//    following notice is applicable:
//
//                       (C) COPYRIGHT 2014 Cadence
//                         ALL RIGHTS RESERVED
//
//     The entire notice above must be reproduced on all authorized copies of this code.
// ------------------------------------------------------------------------------------------------
//
// Filename        : sram_wrapper.sv
// Version         : $Revision: 9810 $
// Last Changed    : $LastChangedBy: louisl $
//                 : $LastChangedDate: 2016-10-26 08:44:45 -0400 (Wed, 26 Oct 2016) $
//
// ------------------------------------------------------------------------------------------------
// Description     : Sierra product top level testbench
// ------------------------------------------------------------------------------------------------

`define MP_PHY_LN01_POP
`define MP_PHY_LN23_POP
`define TB_TOP cdn_phy_tb_top
module sram_wrapper 
  #(ADDR_WIDTH = (`SRAM_DEPTH+1),
    DATA_WIDTH = (`SRAM_WIDTH+1)
   ) 
   ();

`ifdef CDN_UCTLR_DUAL_PORT_RAM
   dpram 
     #(.ADDR_WIDTH (ADDR_WIDTH),
       .USE_CHEX_FILE (1), 
       .DATA_WIDTH (DATA_WIDTH)
       ) u_sram_cmn 
       (.clk        (`TB_TOP.sram_clk_top),
        .address0   (`TB_TOP.iram_addr_top),
        .data_in0   (`TB_TOP.iram_wr_data_top),
        .enable0    (`TB_TOP.iram_ceb_top),
        .write0     (`TB_TOP.iram_web_top),
        .byte_en0   (4'hF),
        .data_out0  (`TB_TOP.iram_rd_data_top),
        .address1   (`TB_TOP.sram_addr_top),
        .data_in1   (`TB_TOP.sram_wr_data_top),
        .enable1    (`TB_TOP.sram_ceb_top),
        .write1     (`TB_TOP.sram_web_top),
        .byte_en1   (`TB_TOP.sram_bweb_top),
        .data_out1  (`TB_TOP.sram_rd_data_top));
`else
   sram 
     #(.ADDR_WIDTH (ADDR_WIDTH),
       .USE_CHEX_FILE (1), 
       .DATA_WIDTH (DATA_WIDTH)
       ) u_sram_cmn 
       (.clk      (`TB_TOP.sram_clk_top),
        .address  (`TB_TOP.sram_addr_top),
        .data_in  (`TB_TOP.sram_wr_data_top),
        .enable   (`TB_TOP.sram_ceb_top),
        .write    (`TB_TOP.sram_web_top),
        .byte_en  (`TB_TOP.sram_bweb_top),
        .data_out (`TB_TOP.sram_rd_data_top));
`endif

`define GENERATE_LANE_SRAMS(LN)\
`ifdef MP_PHY_LN``LN``_POP\
 `ifndef  CDN_MPPHY_LANE_UC_RMV \
  `ifdef CDN_UCTLR_DUAL_PORT_RAM\
   dpram\
   #(.ADDR_WIDTH (ADDR_WIDTH),\
     .USE_CHEX_FILE (1),\
     .DATA_WIDTH (DATA_WIDTH)\
     ) u_sram_ln_``LN``\
   (.clk        (`TB_TOP.sram_clk_ln_``LN``),\
    .address0   (`TB_TOP.iram_addr_ln_``LN``),\
    .data_in0   (`TB_TOP.iram_wr_data_ln_``LN``),\
    .enable0    (`TB_TOP.iram_ceb_ln_``LN``),\
    .write0     (`TB_TOP.iram_web_ln_``LN``),\
    .byte_en0   (4'hF),\
    .data_out0  (`TB_TOP.iram_rd_data_ln_``LN``),\
    .address1   (`TB_TOP.sram_addr_ln_``LN``),\
    .data_in1   (`TB_TOP.sram_wr_data_ln_``LN``),\
    .enable1    (`TB_TOP.sram_ceb_ln_``LN``),\
    .write1     (`TB_TOP.sram_web_ln_``LN``),\
    .byte_en1   (`TB_TOP.sram_bweb_ln_``LN``),\
    .data_out1  (`TB_TOP.sram_rd_data_ln_``LN``));\
  `else\
   sram\
     #(.ADDR_WIDTH (ADDR_WIDTH),\
       .USE_CHEX_FILE (1),\
       .DATA_WIDTH (DATA_WIDTH)\
       ) u_sram_ln_``LN``\
       (.clk      (`TB_TOP.sram_clk_ln_``LN``),\
        .address  (`TB_TOP.sram_addr_ln_``LN``),\
        .data_in  (`TB_TOP.sram_wr_data_ln_``LN``),\
        .enable   (`TB_TOP.sram_ceb_ln_``LN``),\
        .write    (`TB_TOP.sram_web_ln_``LN``),\
        .byte_en  (`TB_TOP.sram_bweb_ln_``LN``),\
        .data_out (`TB_TOP.sram_rd_data_ln_``LN``));\
  //`ifdef CDN_TESTCHIP_ENABLE\
  //bind u_sram_ln_``LN`` sram_debug\
  //  #(.ADDR_WIDTH(ADDR_WIDTH),\
  //    .DATA_WIDTH('d33)\
  //    ) sram_debug_i\
  //    (.protocol    (`TB_TOP.phy_cfg_s.lane_protocols[``LN``]),\
  //     .gen_mode    (`TB_TOP.gen_mode_vec[``LN``]),\
  //     .mem         (memory),\
  //     .load_mem_en (1'b0));\
  //`else\
  //bind u_sram_ln_``LN`` sram_debug\
  //  #(.ADDR_WIDTH(ADDR_WIDTH),\
  //    .DATA_WIDTH(DATA_WIDTH)\
  //    ) sram_debug_i\
  //    (.protocol (`TB_TOP.phy_cfg_s.lane_protocols[``LN``]),\
  //     .gen_mode ({4'b0,`TB_TOP.gen_mode_vec[``LN``]}),\
  //     .*);\
  //`endif\
  `endif\
 `endif\
`endif

   `GENERATE_LANE_SRAMS(01)
   `GENERATE_LANE_SRAMS(23)
  // `GENERATE_LANE_SRAMS(02)
  // `GENERATE_LANE_SRAMS(03)
  // `GENERATE_LANE_SRAMS(04)
  // `GENERATE_LANE_SRAMS(05)
  // `GENERATE_LANE_SRAMS(06)
  // `GENERATE_LANE_SRAMS(07)
  // `GENERATE_LANE_SRAMS(08)
  // `GENERATE_LANE_SRAMS(09)
  // `GENERATE_LANE_SRAMS(10)
  // `GENERATE_LANE_SRAMS(11)
  // `GENERATE_LANE_SRAMS(12)
  // `GENERATE_LANE_SRAMS(13)
  // `GENERATE_LANE_SRAMS(14)
  // `GENERATE_LANE_SRAMS(15)

//------------------------------------------------------------------------------
// FW Log Monitoring - Bind Statements
//------------------------------------------------------------------------------
// Bind fw_log_monitor to SRAM instances to capture firmware debug logs
// Monitors specific addresses where FW writes log data during execution

// Monitor for Top UC - logs to u_sram_cmn.mem[4] (address 0x4)
bind u_sram_cmn fw_log_monitor #(
    .ADDR_WIDTH     (ADDR_WIDTH),
    .DATA_WIDTH     (DATA_WIDTH),
    .TARGET_ADDR    (14'h0004),
    .LOG_FILE_NAME  ("fw_log_top_uc.txt"),
    .MONITOR_NAME   ("TOP_UC_LOG")
) fw_log_mon_top_uc (
    .clk        (clk),
    .address    (address),
    .data_in    (data_in),
    .enable     (enable),
    .write      (write)
);

`ifndef CDN_MPPHY_LANE_UC_RMV
    // Monitor for Lane 01 UC - logs to u_sram_ln_01.mem[0] (address 0x0)
    `ifdef MP_PHY_LN01_POP
        bind u_sram_ln_01 fw_log_monitor #(
            .ADDR_WIDTH     (ADDR_WIDTH),
            .DATA_WIDTH     (DATA_WIDTH),
            .TARGET_ADDR    (14'h0000),
            .LOG_FILE_NAME  ("fw_log_ln01_uc.txt"),
            .MONITOR_NAME   ("LN01_UC_LOG")
        ) fw_log_mon_ln01_uc (
            .clk        (clk),
            .address    (address),
            .data_in    (data_in),
            .enable     (enable),
            .write      (write)
        );
    `endif

    // Monitor for Lane 23 UC - logs to u_sram_ln_23.mem[0] (address 0x0)
    `ifdef MP_PHY_LN23_POP
        bind u_sram_ln_23 fw_log_monitor #(
            .ADDR_WIDTH     (ADDR_WIDTH),
            .DATA_WIDTH     (DATA_WIDTH),
            .TARGET_ADDR    (14'h0000),
            .LOG_FILE_NAME  ("fw_log_ln23_uc.txt"),
            .MONITOR_NAME   ("LN23_UC_LOG")
        ) fw_log_mon_ln23_uc (
            .clk        (clk),
            .address    (address),
            .data_in    (data_in),
            .enable     (enable),
            .write      (write)
        );
    `endif
`endif

endmodule 
