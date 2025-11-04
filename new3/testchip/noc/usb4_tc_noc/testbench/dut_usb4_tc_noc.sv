`ifndef STG_TOP_MODULE
`define STG_TOP_MODULE

`include "dut_usb4_tc_noc_usr_tb_pre_extensions.sv"

// The vip_select_itf interface is used in the Dynamic Switch mode only. Please refer to STG User Guide for more information about this mode.
// If the interface is not empty, the Dynamic Switch mode is used.
// By default, all vip_select registers are set to "1", which means that the corresponding active VIPs are active. Set to "0" to deactivate.
interface vip_select_itf;
   reg ports[string];
   initial begin
   end
endinterface

module dut_usb4_tc_noc();
   parameter tap2apb_pclk_INIT_DELAY = 0ps;
   parameter tap2apb_pclk_PHASE_LENGTH = 10000ps;
   parameter noc_clk_INIT_DELAY = 9ps;
   parameter noc_clk_PHASE_LENGTH = 10000ps;
   parameter rst_n_DEASSERT_POSITION = 0;
   parameter rst_n_INIT_DELAY = 8ns;
   parameter rst_n_CLK_PERIOD = 10000ps;
   parameter rst_n_PHASE_LENGTH = 0ns;
   parameter rst_n_NUM_CLKS_ASSERTED = 10;
   parameter apbViprst_n_DEASSERT_POSITION = 0;
   parameter apbViprst_n_INIT_DELAY = 8ns;
   parameter apbViprst_n_CLK_PERIOD = 10000ps;
   parameter apbViprst_n_PHASE_LENGTH = 0ns;
   parameter apbViprst_n_NUM_CLKS_ASSERTED = 15;
   parameter ADDRESS_WIDTH_apb_mstr = 32;
   parameter USER_RESP_WIDTH_apb_mstr = 16;
   parameter INPUT_SKEW_apb_mstr = 1;
   parameter USER_REQ_WIDTH_apb_mstr = 128;
   parameter DATA_WIDTH_apb_mstr = 32;
   parameter SUBSYSID_WIDTH_apb_mstr = 8;
   parameter OUTPUT_SKEW_apb_mstr = 2000;
   parameter USER_DATA_WIDTH_apb_mstr = 16;
   parameter ADDRESS_WIDTH_cdb = 32;
   parameter USER_RESP_WIDTH_cdb = 16;
   parameter INPUT_SKEW_cdb = 1;
   parameter USER_REQ_WIDTH_cdb = 128;
   parameter DATA_WIDTH_cdb = 32;
   parameter SUBSYSID_WIDTH_cdb = 8;
   parameter OUTPUT_SKEW_cdb = 2000;
   parameter USER_DATA_WIDTH_cdb = 16;
   parameter ADDRESS_WIDTH_cmn_cdb = 9;
   parameter USER_RESP_WIDTH_cmn_cdb = 16;
   parameter INPUT_SKEW_cmn_cdb = 1;
   parameter USER_REQ_WIDTH_cmn_cdb = 128;
   parameter DATA_WIDTH_cmn_cdb = 32;
   parameter SUBSYSID_WIDTH_cmn_cdb = 8;
   parameter OUTPUT_SKEW_cmn_cdb = 2000;
   parameter USER_DATA_WIDTH_cmn_cdb = 16;
   parameter ADDRESS_WIDTH_tc_reg = 16;
   parameter USER_RESP_WIDTH_tc_reg = 16;
   parameter INPUT_SKEW_tc_reg = 1;
   parameter USER_REQ_WIDTH_tc_reg = 128;
   parameter DATA_WIDTH_tc_reg = 32;
   parameter SUBSYSID_WIDTH_tc_reg = 8;
   parameter OUTPUT_SKEW_tc_reg = 2000;
   parameter USER_DATA_WIDTH_tc_reg = 16;
   parameter ADDRESS_WIDTH_usb_sub_sys = 16;
   parameter USER_RESP_WIDTH_usb_sub_sys = 16;
   parameter INPUT_SKEW_usb_sub_sys = 1;
   parameter USER_REQ_WIDTH_usb_sub_sys = 128;
   parameter DATA_WIDTH_usb_sub_sys = 32;
   parameter SUBSYSID_WIDTH_usb_sub_sys = 8;
   parameter OUTPUT_SKEW_usb_sub_sys = 2000;
   parameter USER_DATA_WIDTH_usb_sub_sys = 16;
   parameter ADDRESS_WIDTH_pam3_sub_sys = 16;
   parameter USER_RESP_WIDTH_pam3_sub_sys = 16;
   parameter INPUT_SKEW_pam3_sub_sys = 1;
   parameter USER_REQ_WIDTH_pam3_sub_sys = 128;
   parameter DATA_WIDTH_pam3_sub_sys = 32;
   parameter SUBSYSID_WIDTH_pam3_sub_sys = 8;
   parameter OUTPUT_SKEW_pam3_sub_sys = 2000;
   parameter USER_DATA_WIDTH_pam3_sub_sys = 16;
   parameter ADDRESS_WIDTH_apb_tgt = 18;
   parameter USER_RESP_WIDTH_apb_tgt = 16;
   parameter INPUT_SKEW_apb_tgt = 1;
   parameter USER_REQ_WIDTH_apb_tgt = 128;
   parameter DATA_WIDTH_apb_tgt = 32;
   parameter SUBSYSID_WIDTH_apb_tgt = 8;
   parameter OUTPUT_SKEW_apb_tgt = 2000;
   parameter USER_DATA_WIDTH_apb_tgt = 16;
   parameter ADDRESS_WIDTH_xcvr_ln_0 = 10;
   parameter USER_RESP_WIDTH_xcvr_ln_0 = 16;
   parameter INPUT_SKEW_xcvr_ln_0 = 1;
   parameter USER_REQ_WIDTH_xcvr_ln_0 = 128;
   parameter DATA_WIDTH_xcvr_ln_0 = 32;
   parameter SUBSYSID_WIDTH_xcvr_ln_0 = 8;
   parameter OUTPUT_SKEW_xcvr_ln_0 = 2000;
   parameter USER_DATA_WIDTH_xcvr_ln_0 = 16;

   wire clk__tap2apb_pclk;
   wire clk__noc_clk;
   wire resetN__rst_n;
   wire PSLVERR__apb_mstr_pslverr;
   wire [31:0] PRDATA__apb_mstr_prdata;
   wire PREADY__apb_mstr_pready;
   wire [2:0] tie_apb_mstr_PPROT;
   wire [3:0] PSTRB__apb_mstr_pstrb;
   wire [31:0] PWDATA__apb_mstr_pwdata;
   wire PWRITE__apb_mstr_pwrite;
   wire PENABLE__apb_mstr_penable;
   wire [31:0] PADDR__apb_mstr_paddr;
   wire tie_apb_mstr_PWAKEUP;
   wire [127:0] tie_apb_mstr_PAUSER;
   wire [15:0] tie_apb_mstr_PWUSER;
   wire [15:0] tie_apb_mstr_PRUSER;
   wire [15:0] tie_apb_mstr_PBUSER;
   wire tie_apb_mstr_PENABLECHK;
   wire [3:0] tie_apb_mstr_PWDATACHK;
   wire tie_apb_mstr_PSTRBCHK;
   wire tie_apb_mstr_PSUBSYSIDCHK;
   wire tie_apb_mstr_PREADYCHK;
   wire tie_apb_mstr_PSELCHK;
   wire [3:0] tie_apb_mstr_PADDRCHK;
   wire [3:0] tie_apb_mstr_PRDATACHK;
   wire tie_apb_mstr_PSLVERRCHK;
   wire tie_apb_mstr_PCTRLCHK;
   wire resetN__apbViprst_n;
   wire tie_apb_mstr_PNSE;
   wire [7:0] tie_apb_mstr_PSUBSYSID;
   wire tie_apb_mstr_PWAKEUPCHK;
   wire [15:0] tie_apb_mstr_PAUSERCHK;
   wire [1:0] tie_apb_mstr_PWUSERCHK;
   wire [1:0] tie_apb_mstr_PRUSERCHK;
   wire [1:0] tie_apb_mstr_PBUSERCHK;
   wire PSELX__apb_mstr_psel;
   wire PSLVERR__cdb_pslverr;
   wire [31:0] PRDATA__cdb_prdata;
   wire PREADY__cdb_pready;
   wire [2:0] tie_cdb_PPROT;
   wire [3:0] PSTRB__cdb_pstrb;
   wire [31:0] PWDATA__cdb_pwdata;
   wire PWRITE__cdb_pwrite;
   wire PENABLE__cdb_penable;
   wire [31:0] PADDR__cdb_paddr;
   wire tie_cdb_PWAKEUP;
   wire [127:0] tie_cdb_PAUSER;
   wire [15:0] tie_cdb_PWUSER;
   wire [15:0] tie_cdb_PRUSER;
   wire [15:0] tie_cdb_PBUSER;
   wire tie_cdb_PENABLECHK;
   wire [3:0] tie_cdb_PWDATACHK;
   wire tie_cdb_PSTRBCHK;
   wire tie_cdb_PSUBSYSIDCHK;
   wire tie_cdb_PREADYCHK;
   wire tie_cdb_PSELCHK;
   wire [3:0] tie_cdb_PADDRCHK;
   wire [3:0] tie_cdb_PRDATACHK;
   wire tie_cdb_PSLVERRCHK;
   wire tie_cdb_PCTRLCHK;
   wire tie_cdb_PNSE;
   wire [7:0] tie_cdb_PSUBSYSID;
   wire tie_cdb_PWAKEUPCHK;
   wire [15:0] tie_cdb_PAUSERCHK;
   wire [1:0] tie_cdb_PWUSERCHK;
   wire [1:0] tie_cdb_PRUSERCHK;
   wire [1:0] tie_cdb_PBUSERCHK;
   wire PSELX__cdb_psel;
   wire tie_cmn_cdb_PSLVERR;
   wire [31:0] PRDATA__cmn_cdb_prdata;
   wire PREADY__cmn_cdb_pready;
   wire [2:0] tie_cmn_cdb_PPROT;
   wire [3:0] PSTRB__cmn_cdb_pstrb;
   wire [31:0] PWDATA__cmn_cdb_pwdata;
   wire PWRITE__cmn_cdb_pwrite;
   wire PENABLE__cmn_cdb_penable;
   wire [8:0] PADDR__cmn_cdb_paddr;
   wire tie_cmn_cdb_PWAKEUP;
   wire [127:0] tie_cmn_cdb_PAUSER;
   wire [15:0] tie_cmn_cdb_PWUSER;
   wire [15:0] tie_cmn_cdb_PRUSER;
   wire [15:0] tie_cmn_cdb_PBUSER;
   wire tie_cmn_cdb_PENABLECHK;
   wire [3:0] tie_cmn_cdb_PWDATACHK;
   wire tie_cmn_cdb_PSTRBCHK;
   wire tie_cmn_cdb_PSUBSYSIDCHK;
   wire tie_cmn_cdb_PREADYCHK;
   wire tie_cmn_cdb_PSELCHK;
   wire [1:0] tie_cmn_cdb_PADDRCHK;
   wire [3:0] tie_cmn_cdb_PRDATACHK;
   wire tie_cmn_cdb_PSLVERRCHK;
   wire tie_cmn_cdb_PCTRLCHK;
   wire tie_cmn_cdb_PNSE;
   wire [7:0] tie_cmn_cdb_PSUBSYSID;
   wire tie_cmn_cdb_PWAKEUPCHK;
   wire [15:0] tie_cmn_cdb_PAUSERCHK;
   wire [1:0] tie_cmn_cdb_PWUSERCHK;
   wire [1:0] tie_cmn_cdb_PRUSERCHK;
   wire [1:0] tie_cmn_cdb_PBUSERCHK;
   wire PSELX__cmn_cdb_psel;
   wire tie_tc_reg_PSLVERR;
   wire [31:0] PRDATA__tc_reg_prdata;
   wire PREADY__tc_reg_pready;
   wire [2:0] tie_tc_reg_PPROT;
   wire [3:0] PSTRB__tc_reg_pstrb;
   wire [31:0] PWDATA__tc_reg_pwdata;
   wire PWRITE__tc_reg_pwrite;
   wire PENABLE__tc_reg_penable;
   wire [15:0] PADDR__tc_reg_paddr;
   wire tie_tc_reg_PWAKEUP;
   wire [127:0] tie_tc_reg_PAUSER;
   wire [15:0] tie_tc_reg_PWUSER;
   wire [15:0] tie_tc_reg_PRUSER;
   wire [15:0] tie_tc_reg_PBUSER;
   wire tie_tc_reg_PENABLECHK;
   wire [3:0] tie_tc_reg_PWDATACHK;
   wire tie_tc_reg_PSTRBCHK;
   wire tie_tc_reg_PSUBSYSIDCHK;
   wire tie_tc_reg_PREADYCHK;
   wire tie_tc_reg_PSELCHK;
   wire [1:0] tie_tc_reg_PADDRCHK;
   wire [3:0] tie_tc_reg_PRDATACHK;
   wire tie_tc_reg_PSLVERRCHK;
   wire tie_tc_reg_PCTRLCHK;
   wire tie_tc_reg_PNSE;
   wire [7:0] tie_tc_reg_PSUBSYSID;
   wire tie_tc_reg_PWAKEUPCHK;
   wire [15:0] tie_tc_reg_PAUSERCHK;
   wire [1:0] tie_tc_reg_PWUSERCHK;
   wire [1:0] tie_tc_reg_PRUSERCHK;
   wire [1:0] tie_tc_reg_PBUSERCHK;
   wire PSELX__tc_reg_psel;
   wire tie_usb_sub_sys_PSLVERR;
   wire [31:0] PRDATA__usb_sub_sys_prdata;
   wire PREADY__usb_sub_sys_pready;
   wire [2:0] tie_usb_sub_sys_PPROT;
   wire [3:0] PSTRB__usb_sub_sys_pstrb;
   wire [31:0] PWDATA__usb_sub_sys_pwdata;
   wire PWRITE__usb_sub_sys_pwrite;
   wire PENABLE__usb_sub_sys_penable;
   wire [15:0] PADDR__usb_sub_sys_paddr;
   wire tie_usb_sub_sys_PWAKEUP;
   wire [127:0] tie_usb_sub_sys_PAUSER;
   wire [15:0] tie_usb_sub_sys_PWUSER;
   wire [15:0] tie_usb_sub_sys_PRUSER;
   wire [15:0] tie_usb_sub_sys_PBUSER;
   wire tie_usb_sub_sys_PENABLECHK;
   wire [3:0] tie_usb_sub_sys_PWDATACHK;
   wire tie_usb_sub_sys_PSTRBCHK;
   wire tie_usb_sub_sys_PSUBSYSIDCHK;
   wire tie_usb_sub_sys_PREADYCHK;
   wire tie_usb_sub_sys_PSELCHK;
   wire [1:0] tie_usb_sub_sys_PADDRCHK;
   wire [3:0] tie_usb_sub_sys_PRDATACHK;
   wire tie_usb_sub_sys_PSLVERRCHK;
   wire tie_usb_sub_sys_PCTRLCHK;
   wire tie_usb_sub_sys_PNSE;
   wire [7:0] tie_usb_sub_sys_PSUBSYSID;
   wire tie_usb_sub_sys_PWAKEUPCHK;
   wire [15:0] tie_usb_sub_sys_PAUSERCHK;
   wire [1:0] tie_usb_sub_sys_PWUSERCHK;
   wire [1:0] tie_usb_sub_sys_PRUSERCHK;
   wire [1:0] tie_usb_sub_sys_PBUSERCHK;
   wire PSELX__usb_sub_sys_psel;
   wire tie_pam3_sub_sys_PSLVERR;
   wire [31:0] PRDATA__pam3_sub_sys_prdata;
   wire PREADY__pam3_sub_sys_pready;
   wire [2:0] tie_pam3_sub_sys_PPROT;
   wire [3:0] PSTRB__pam3_sub_sys_pstrb;
   wire [31:0] PWDATA__pam3_sub_sys_pwdata;
   wire PWRITE__pam3_sub_sys_pwrite;
   wire PENABLE__pam3_sub_sys_penable;
   wire [15:0] PADDR__pam3_sub_sys_paddr;
   wire tie_pam3_sub_sys_PWAKEUP;
   wire [127:0] tie_pam3_sub_sys_PAUSER;
   wire [15:0] tie_pam3_sub_sys_PWUSER;
   wire [15:0] tie_pam3_sub_sys_PRUSER;
   wire [15:0] tie_pam3_sub_sys_PBUSER;
   wire tie_pam3_sub_sys_PENABLECHK;
   wire [3:0] tie_pam3_sub_sys_PWDATACHK;
   wire tie_pam3_sub_sys_PSTRBCHK;
   wire tie_pam3_sub_sys_PSUBSYSIDCHK;
   wire tie_pam3_sub_sys_PREADYCHK;
   wire tie_pam3_sub_sys_PSELCHK;
   wire [1:0] tie_pam3_sub_sys_PADDRCHK;
   wire [3:0] tie_pam3_sub_sys_PRDATACHK;
   wire tie_pam3_sub_sys_PSLVERRCHK;
   wire tie_pam3_sub_sys_PCTRLCHK;
   wire tie_pam3_sub_sys_PNSE;
   wire [7:0] tie_pam3_sub_sys_PSUBSYSID;
   wire tie_pam3_sub_sys_PWAKEUPCHK;
   wire [15:0] tie_pam3_sub_sys_PAUSERCHK;
   wire [1:0] tie_pam3_sub_sys_PWUSERCHK;
   wire [1:0] tie_pam3_sub_sys_PRUSERCHK;
   wire [1:0] tie_pam3_sub_sys_PBUSERCHK;
   wire PSELX__pam3_sub_sys_psel;
   wire PSLVERR__apb_tgt_pslverr;
   wire [31:0] PRDATA__apb_tgt_prdata;
   wire PREADY__apb_tgt_pready;
   wire [2:0] tie_apb_tgt_PPROT;
   wire [3:0] PSTRB__apb_tgt_pstrb;
   wire [31:0] PWDATA__apb_tgt_pwdata;
   wire PWRITE__apb_tgt_pwrite;
   wire PENABLE__apb_tgt_penable;
   wire [17:0] PADDR__apb_tgt_paddr;
   wire tie_apb_tgt_PWAKEUP;
   wire [127:0] tie_apb_tgt_PAUSER;
   wire [15:0] tie_apb_tgt_PWUSER;
   wire [15:0] tie_apb_tgt_PRUSER;
   wire [15:0] tie_apb_tgt_PBUSER;
   wire tie_apb_tgt_PENABLECHK;
   wire [3:0] tie_apb_tgt_PWDATACHK;
   wire tie_apb_tgt_PSTRBCHK;
   wire tie_apb_tgt_PSUBSYSIDCHK;
   wire tie_apb_tgt_PREADYCHK;
   wire tie_apb_tgt_PSELCHK;
   wire [2:0] tie_apb_tgt_PADDRCHK;
   wire [3:0] tie_apb_tgt_PRDATACHK;
   wire tie_apb_tgt_PSLVERRCHK;
   wire tie_apb_tgt_PCTRLCHK;
   wire tie_apb_tgt_PNSE;
   wire [7:0] tie_apb_tgt_PSUBSYSID;
   wire tie_apb_tgt_PWAKEUPCHK;
   wire [15:0] tie_apb_tgt_PAUSERCHK;
   wire [1:0] tie_apb_tgt_PWUSERCHK;
   wire [1:0] tie_apb_tgt_PRUSERCHK;
   wire [1:0] tie_apb_tgt_PBUSERCHK;
   wire PSELX__apb_tgt_psel;
   wire tie_xcvr_ln_0_PSLVERR;
   wire [31:0] PRDATA__xcvr_ln_0_prdata;
   wire PREADY__xcvr_ln_0_pready;
   wire [2:0] tie_xcvr_ln_0_PPROT;
   wire [3:0] PSTRB__xcvr_ln_0_pstrb;
   wire [31:0] PWDATA__xcvr_ln_0_pwdata;
   wire PWRITE__xcvr_ln_0_pwrite;
   wire PENABLE__xcvr_ln_0_penable;
   wire [9:0] PADDR__xcvr_ln_0_paddr;
   wire tie_xcvr_ln_0_PWAKEUP;
   wire [127:0] tie_xcvr_ln_0_PAUSER;
   wire [15:0] tie_xcvr_ln_0_PWUSER;
   wire [15:0] tie_xcvr_ln_0_PRUSER;
   wire [15:0] tie_xcvr_ln_0_PBUSER;
   wire tie_xcvr_ln_0_PENABLECHK;
   wire [3:0] tie_xcvr_ln_0_PWDATACHK;
   wire tie_xcvr_ln_0_PSTRBCHK;
   wire tie_xcvr_ln_0_PSUBSYSIDCHK;
   wire tie_xcvr_ln_0_PREADYCHK;
   wire tie_xcvr_ln_0_PSELCHK;
   wire [1:0] tie_xcvr_ln_0_PADDRCHK;
   wire [3:0] tie_xcvr_ln_0_PRDATACHK;
   wire tie_xcvr_ln_0_PSLVERRCHK;
   wire tie_xcvr_ln_0_PCTRLCHK;
   wire tie_xcvr_ln_0_PNSE;
   wire [7:0] tie_xcvr_ln_0_PSUBSYSID;
   wire tie_xcvr_ln_0_PWAKEUPCHK;
   wire [15:0] tie_xcvr_ln_0_PAUSERCHK;
   wire [1:0] tie_xcvr_ln_0_PWUSERCHK;
   wire [1:0] tie_xcvr_ln_0_PRUSERCHK;
   wire [1:0] tie_xcvr_ln_0_PBUSERCHK;
   wire PSELX__xcvr_ln_0_psel;

   initial begin
      force tie_apb_mstr_PPROT = 3'b0;
      force tie_apb_mstr_PWAKEUP = 1'b0;
      force tie_apb_mstr_PAUSER = 128'b0;
      force tie_apb_mstr_PWUSER = 16'b0;
      force tie_apb_mstr_PRUSER = 16'b0;
      force tie_apb_mstr_PBUSER = 16'b0;
      force tie_apb_mstr_PENABLECHK = 1'b0;
      force tie_apb_mstr_PWDATACHK = 4'b0;
      force tie_apb_mstr_PSTRBCHK = 1'b0;
      force tie_apb_mstr_PSUBSYSIDCHK = 1'b0;
      force tie_apb_mstr_PREADYCHK = 1'b0;
      force tie_apb_mstr_PSELCHK = 1'b0;
      force tie_apb_mstr_PADDRCHK = 4'b0;
      force tie_apb_mstr_PRDATACHK = 4'b0;
      force tie_apb_mstr_PSLVERRCHK = 1'b0;
      force tie_apb_mstr_PCTRLCHK = 1'b0;
      force tie_apb_mstr_PNSE = 1'b0;
      force tie_apb_mstr_PSUBSYSID = 8'b0;
      force tie_apb_mstr_PWAKEUPCHK = 1'b0;
      force tie_apb_mstr_PAUSERCHK = 16'b0;
      force tie_apb_mstr_PWUSERCHK = 2'b0;
      force tie_apb_mstr_PRUSERCHK = 2'b0;
      force tie_apb_mstr_PBUSERCHK = 2'b0;
      force tie_cdb_PPROT = 3'b0;
      force tie_cdb_PWAKEUP = 1'b0;
      force tie_cdb_PAUSER = 128'b0;
      force tie_cdb_PWUSER = 16'b0;
      force tie_cdb_PRUSER = 16'b0;
      force tie_cdb_PBUSER = 16'b0;
      force tie_cdb_PENABLECHK = 1'b0;
      force tie_cdb_PWDATACHK = 4'b0;
      force tie_cdb_PSTRBCHK = 1'b0;
      force tie_cdb_PSUBSYSIDCHK = 1'b0;
      force tie_cdb_PREADYCHK = 1'b0;
      force tie_cdb_PSELCHK = 1'b0;
      force tie_cdb_PADDRCHK = 4'b0;
      force tie_cdb_PRDATACHK = 4'b0;
      force tie_cdb_PSLVERRCHK = 1'b0;
      force tie_cdb_PCTRLCHK = 1'b0;
      force tie_cdb_PNSE = 1'b0;
      force tie_cdb_PSUBSYSID = 8'b0;
      force tie_cdb_PWAKEUPCHK = 1'b0;
      force tie_cdb_PAUSERCHK = 16'b0;
      force tie_cdb_PWUSERCHK = 2'b0;
      force tie_cdb_PRUSERCHK = 2'b0;
      force tie_cdb_PBUSERCHK = 2'b0;
      force tie_cmn_cdb_PSLVERR = 1'b0;
      force tie_cmn_cdb_PPROT = 3'b0;
      force tie_cmn_cdb_PWAKEUP = 1'b0;
      force tie_cmn_cdb_PAUSER = 128'b0;
      force tie_cmn_cdb_PWUSER = 16'b0;
      force tie_cmn_cdb_PRUSER = 16'b0;
      force tie_cmn_cdb_PBUSER = 16'b0;
      force tie_cmn_cdb_PENABLECHK = 1'b0;
      force tie_cmn_cdb_PWDATACHK = 4'b0;
      force tie_cmn_cdb_PSTRBCHK = 1'b0;
      force tie_cmn_cdb_PSUBSYSIDCHK = 1'b0;
      force tie_cmn_cdb_PREADYCHK = 1'b0;
      force tie_cmn_cdb_PSELCHK = 1'b0;
      force tie_cmn_cdb_PADDRCHK = 2'b0;
      force tie_cmn_cdb_PRDATACHK = 4'b0;
      force tie_cmn_cdb_PSLVERRCHK = 1'b0;
      force tie_cmn_cdb_PCTRLCHK = 1'b0;
      force tie_cmn_cdb_PNSE = 1'b0;
      force tie_cmn_cdb_PSUBSYSID = 8'b0;
      force tie_cmn_cdb_PWAKEUPCHK = 1'b0;
      force tie_cmn_cdb_PAUSERCHK = 16'b0;
      force tie_cmn_cdb_PWUSERCHK = 2'b0;
      force tie_cmn_cdb_PRUSERCHK = 2'b0;
      force tie_cmn_cdb_PBUSERCHK = 2'b0;
      force tie_tc_reg_PSLVERR = 1'b0;
      force tie_tc_reg_PPROT = 3'b0;
      force tie_tc_reg_PWAKEUP = 1'b0;
      force tie_tc_reg_PAUSER = 128'b0;
      force tie_tc_reg_PWUSER = 16'b0;
      force tie_tc_reg_PRUSER = 16'b0;
      force tie_tc_reg_PBUSER = 16'b0;
      force tie_tc_reg_PENABLECHK = 1'b0;
      force tie_tc_reg_PWDATACHK = 4'b0;
      force tie_tc_reg_PSTRBCHK = 1'b0;
      force tie_tc_reg_PSUBSYSIDCHK = 1'b0;
      force tie_tc_reg_PREADYCHK = 1'b0;
      force tie_tc_reg_PSELCHK = 1'b0;
      force tie_tc_reg_PADDRCHK = 2'b0;
      force tie_tc_reg_PRDATACHK = 4'b0;
      force tie_tc_reg_PSLVERRCHK = 1'b0;
      force tie_tc_reg_PCTRLCHK = 1'b0;
      force tie_tc_reg_PNSE = 1'b0;
      force tie_tc_reg_PSUBSYSID = 8'b0;
      force tie_tc_reg_PWAKEUPCHK = 1'b0;
      force tie_tc_reg_PAUSERCHK = 16'b0;
      force tie_tc_reg_PWUSERCHK = 2'b0;
      force tie_tc_reg_PRUSERCHK = 2'b0;
      force tie_tc_reg_PBUSERCHK = 2'b0;
      force tie_usb_sub_sys_PSLVERR = 1'b0;
      force tie_usb_sub_sys_PPROT = 3'b0;
      force tie_usb_sub_sys_PWAKEUP = 1'b0;
      force tie_usb_sub_sys_PAUSER = 128'b0;
      force tie_usb_sub_sys_PWUSER = 16'b0;
      force tie_usb_sub_sys_PRUSER = 16'b0;
      force tie_usb_sub_sys_PBUSER = 16'b0;
      force tie_usb_sub_sys_PENABLECHK = 1'b0;
      force tie_usb_sub_sys_PWDATACHK = 4'b0;
      force tie_usb_sub_sys_PSTRBCHK = 1'b0;
      force tie_usb_sub_sys_PSUBSYSIDCHK = 1'b0;
      force tie_usb_sub_sys_PREADYCHK = 1'b0;
      force tie_usb_sub_sys_PSELCHK = 1'b0;
      force tie_usb_sub_sys_PADDRCHK = 2'b0;
      force tie_usb_sub_sys_PRDATACHK = 4'b0;
      force tie_usb_sub_sys_PSLVERRCHK = 1'b0;
      force tie_usb_sub_sys_PCTRLCHK = 1'b0;
      force tie_usb_sub_sys_PNSE = 1'b0;
      force tie_usb_sub_sys_PSUBSYSID = 8'b0;
      force tie_usb_sub_sys_PWAKEUPCHK = 1'b0;
      force tie_usb_sub_sys_PAUSERCHK = 16'b0;
      force tie_usb_sub_sys_PWUSERCHK = 2'b0;
      force tie_usb_sub_sys_PRUSERCHK = 2'b0;
      force tie_usb_sub_sys_PBUSERCHK = 2'b0;
      force tie_pam3_sub_sys_PSLVERR = 1'b0;
      force tie_pam3_sub_sys_PPROT = 3'b0;
      force tie_pam3_sub_sys_PWAKEUP = 1'b0;
      force tie_pam3_sub_sys_PAUSER = 128'b0;
      force tie_pam3_sub_sys_PWUSER = 16'b0;
      force tie_pam3_sub_sys_PRUSER = 16'b0;
      force tie_pam3_sub_sys_PBUSER = 16'b0;
      force tie_pam3_sub_sys_PENABLECHK = 1'b0;
      force tie_pam3_sub_sys_PWDATACHK = 4'b0;
      force tie_pam3_sub_sys_PSTRBCHK = 1'b0;
      force tie_pam3_sub_sys_PSUBSYSIDCHK = 1'b0;
      force tie_pam3_sub_sys_PREADYCHK = 1'b0;
      force tie_pam3_sub_sys_PSELCHK = 1'b0;
      force tie_pam3_sub_sys_PADDRCHK = 2'b0;
      force tie_pam3_sub_sys_PRDATACHK = 4'b0;
      force tie_pam3_sub_sys_PSLVERRCHK = 1'b0;
      force tie_pam3_sub_sys_PCTRLCHK = 1'b0;
      force tie_pam3_sub_sys_PNSE = 1'b0;
      force tie_pam3_sub_sys_PSUBSYSID = 8'b0;
      force tie_pam3_sub_sys_PWAKEUPCHK = 1'b0;
      force tie_pam3_sub_sys_PAUSERCHK = 16'b0;
      force tie_pam3_sub_sys_PWUSERCHK = 2'b0;
      force tie_pam3_sub_sys_PRUSERCHK = 2'b0;
      force tie_pam3_sub_sys_PBUSERCHK = 2'b0;
      force tie_apb_tgt_PPROT = 3'b0;
      force tie_apb_tgt_PWAKEUP = 1'b0;
      force tie_apb_tgt_PAUSER = 128'b0;
      force tie_apb_tgt_PWUSER = 16'b0;
      force tie_apb_tgt_PRUSER = 16'b0;
      force tie_apb_tgt_PBUSER = 16'b0;
      force tie_apb_tgt_PENABLECHK = 1'b0;
      force tie_apb_tgt_PWDATACHK = 4'b0;
      force tie_apb_tgt_PSTRBCHK = 1'b0;
      force tie_apb_tgt_PSUBSYSIDCHK = 1'b0;
      force tie_apb_tgt_PREADYCHK = 1'b0;
      force tie_apb_tgt_PSELCHK = 1'b0;
      force tie_apb_tgt_PADDRCHK = 3'b0;
      force tie_apb_tgt_PRDATACHK = 4'b0;
      force tie_apb_tgt_PSLVERRCHK = 1'b0;
      force tie_apb_tgt_PCTRLCHK = 1'b0;
      force tie_apb_tgt_PNSE = 1'b0;
      force tie_apb_tgt_PSUBSYSID = 8'b0;
      force tie_apb_tgt_PWAKEUPCHK = 1'b0;
      force tie_apb_tgt_PAUSERCHK = 16'b0;
      force tie_apb_tgt_PWUSERCHK = 2'b0;
      force tie_apb_tgt_PRUSERCHK = 2'b0;
      force tie_apb_tgt_PBUSERCHK = 2'b0;
      force tie_xcvr_ln_0_PSLVERR = 1'b0;
      force tie_xcvr_ln_0_PPROT = 3'b0;
      force tie_xcvr_ln_0_PWAKEUP = 1'b0;
      force tie_xcvr_ln_0_PAUSER = 128'b0;
      force tie_xcvr_ln_0_PWUSER = 16'b0;
      force tie_xcvr_ln_0_PRUSER = 16'b0;
      force tie_xcvr_ln_0_PBUSER = 16'b0;
      force tie_xcvr_ln_0_PENABLECHK = 1'b0;
      force tie_xcvr_ln_0_PWDATACHK = 4'b0;
      force tie_xcvr_ln_0_PSTRBCHK = 1'b0;
      force tie_xcvr_ln_0_PSUBSYSIDCHK = 1'b0;
      force tie_xcvr_ln_0_PREADYCHK = 1'b0;
      force tie_xcvr_ln_0_PSELCHK = 1'b0;
      force tie_xcvr_ln_0_PADDRCHK = 2'b0;
      force tie_xcvr_ln_0_PRDATACHK = 4'b0;
      force tie_xcvr_ln_0_PSLVERRCHK = 1'b0;
      force tie_xcvr_ln_0_PCTRLCHK = 1'b0;
      force tie_xcvr_ln_0_PNSE = 1'b0;
      force tie_xcvr_ln_0_PSUBSYSID = 8'b0;
      force tie_xcvr_ln_0_PWAKEUPCHK = 1'b0;
      force tie_xcvr_ln_0_PAUSERCHK = 16'b0;
      force tie_xcvr_ln_0_PWUSERCHK = 2'b0;
      force tie_xcvr_ln_0_PRUSERCHK = 2'b0;
      force tie_xcvr_ln_0_PBUSERCHK = 2'b0;
   end




  initial begin
      if ($test$plusargs("randomize_isolation_links")) begin
      end
  end


   usb4_tc_noc i_usb4_tc_noc(
      .tap2apb_pclk(clk__tap2apb_pclk),
      .noc_clk(clk__noc_clk),
      .rst_n(resetN__rst_n),
      .apb_mstr_pslverr(PSLVERR__apb_mstr_pslverr),
      .apb_mstr_prdata(PRDATA__apb_mstr_prdata),
      .apb_mstr_pready(PREADY__apb_mstr_pready),
      .apb_mstr_pstrb(PSTRB__apb_mstr_pstrb),
      .apb_mstr_pwdata(PWDATA__apb_mstr_pwdata),
      .apb_mstr_pwrite(PWRITE__apb_mstr_pwrite),
      .apb_mstr_penable(PENABLE__apb_mstr_penable),
      .apb_mstr_paddr(PADDR__apb_mstr_paddr),
      .apb_mstr_psel(PSELX__apb_mstr_psel),
      .cdb_pslverr(PSLVERR__cdb_pslverr),
      .cdb_prdata(PRDATA__cdb_prdata),
      .cdb_pready(PREADY__cdb_pready),
      .cdb_pstrb(PSTRB__cdb_pstrb),
      .cdb_pwdata(PWDATA__cdb_pwdata),
      .cdb_pwrite(PWRITE__cdb_pwrite),
      .cdb_penable(PENABLE__cdb_penable),
      .cdb_paddr(PADDR__cdb_paddr),
      .cdb_psel(PSELX__cdb_psel),
      .cmn_cdb_prdata(PREADY__cmn_cdb_pready ? PRDATA__cmn_cdb_prdata : $urandom),
      .cmn_cdb_pready(PREADY__cmn_cdb_pready),
      .cmn_cdb_pstrb(PSTRB__cmn_cdb_pstrb),
      .cmn_cdb_pwdata(PWDATA__cmn_cdb_pwdata),
      .cmn_cdb_pwrite(PWRITE__cmn_cdb_pwrite),
      .cmn_cdb_penable(PENABLE__cmn_cdb_penable),
      .cmn_cdb_paddr(PADDR__cmn_cdb_paddr),
      .cmn_cdb_psel(PSELX__cmn_cdb_psel),
      .tc_reg_prdata(PREADY__tc_reg_pready ? PRDATA__tc_reg_prdata : $urandom),
      .tc_reg_pready(PREADY__tc_reg_pready),
      .tc_reg_pstrb(PSTRB__tc_reg_pstrb),
      .tc_reg_pwdata(PWDATA__tc_reg_pwdata),
      .tc_reg_pwrite(PWRITE__tc_reg_pwrite),
      .tc_reg_penable(PENABLE__tc_reg_penable),
      .tc_reg_paddr(PADDR__tc_reg_paddr),
      .tc_reg_psel(PSELX__tc_reg_psel),
      .usb_sub_sys_prdata(PREADY__usb_sub_sys_pready ? PRDATA__usb_sub_sys_prdata : $urandom),
      .usb_sub_sys_pready(PREADY__usb_sub_sys_pready),
      .usb_sub_sys_pstrb(PSTRB__usb_sub_sys_pstrb),
      .usb_sub_sys_pwdata(PWDATA__usb_sub_sys_pwdata),
      .usb_sub_sys_pwrite(PWRITE__usb_sub_sys_pwrite),
      .usb_sub_sys_penable(PENABLE__usb_sub_sys_penable),
      .usb_sub_sys_paddr(PADDR__usb_sub_sys_paddr),
      .usb_sub_sys_psel(PSELX__usb_sub_sys_psel),
      .pam3_sub_sys_prdata(PREADY__pam3_sub_sys_pready ? PRDATA__pam3_sub_sys_prdata : $urandom),
      .pam3_sub_sys_pready(PREADY__pam3_sub_sys_pready),
      .pam3_sub_sys_pstrb(PSTRB__pam3_sub_sys_pstrb),
      .pam3_sub_sys_pwdata(PWDATA__pam3_sub_sys_pwdata),
      .pam3_sub_sys_pwrite(PWRITE__pam3_sub_sys_pwrite),
      .pam3_sub_sys_penable(PENABLE__pam3_sub_sys_penable),
      .pam3_sub_sys_paddr(PADDR__pam3_sub_sys_paddr),
      .pam3_sub_sys_psel(PSELX__pam3_sub_sys_psel),
      .apb_tgt_pslverr(PSLVERR__apb_tgt_pslverr),
      .apb_tgt_prdata(PREADY__apb_tgt_pready ? PRDATA__apb_tgt_prdata : $urandom),
      .apb_tgt_pready(PREADY__apb_tgt_pready),
      .apb_tgt_pstrb(PSTRB__apb_tgt_pstrb),
      .apb_tgt_pwdata(PWDATA__apb_tgt_pwdata),
      .apb_tgt_pwrite(PWRITE__apb_tgt_pwrite),
      .apb_tgt_penable(PENABLE__apb_tgt_penable),
      .apb_tgt_paddr(PADDR__apb_tgt_paddr),
      .apb_tgt_psel(PSELX__apb_tgt_psel),
      .xcvr_ln_0_prdata(PREADY__xcvr_ln_0_pready ? PRDATA__xcvr_ln_0_prdata : $urandom),
      .xcvr_ln_0_pready(PREADY__xcvr_ln_0_pready),
      .xcvr_ln_0_pstrb(PSTRB__xcvr_ln_0_pstrb),
      .xcvr_ln_0_pwdata(PWDATA__xcvr_ln_0_pwdata),
      .xcvr_ln_0_pwrite(PWRITE__xcvr_ln_0_pwrite),
      .xcvr_ln_0_penable(PENABLE__xcvr_ln_0_penable),
      .xcvr_ln_0_paddr(PADDR__xcvr_ln_0_paddr),
`ifdef GATE
			.test_se(1'b0),
`endif
      .xcvr_ln_0_psel(PSELX__xcvr_ln_0_psel)
   ); // end of instance i_usb4_tc_noc

   vip_select_itf vip_select();

   cdnApb4Interface #(
      .ADDRESS_WIDTH(ADDRESS_WIDTH_apb_mstr),
      .USER_RESP_WIDTH(USER_RESP_WIDTH_apb_mstr),
      .INPUT_SKEW(INPUT_SKEW_apb_mstr),
      .USER_REQ_WIDTH(USER_REQ_WIDTH_apb_mstr),
      .DATA_WIDTH(DATA_WIDTH_apb_mstr),
      .SUBSYSID_WIDTH(SUBSYSID_WIDTH_apb_mstr),
      .OUTPUT_SKEW(OUTPUT_SKEW_apb_mstr),
      .USER_DATA_WIDTH(USER_DATA_WIDTH_apb_mstr)
   ) dut_usb4_tc_noc_apb_mstr(
      .pslverr(PSLVERR__apb_mstr_pslverr),
      .prdata(PRDATA__apb_mstr_prdata),
      .pready(PREADY__apb_mstr_pready),
      .pprot(tie_apb_mstr_PPROT),
      .pstrb(PSTRB__apb_mstr_pstrb),
      .pwdata(PWDATA__apb_mstr_pwdata),
      .pwrite(PWRITE__apb_mstr_pwrite),
      .penable(PENABLE__apb_mstr_penable),
      .paddr(PADDR__apb_mstr_paddr),
      .pwakeup(tie_apb_mstr_PWAKEUP),
      .pauser(tie_apb_mstr_PAUSER),
      .pwuser(tie_apb_mstr_PWUSER),
      .pruser(tie_apb_mstr_PRUSER),
      .pbuser(tie_apb_mstr_PBUSER),
      .penablechk(tie_apb_mstr_PENABLECHK),
      .pwdatachk(tie_apb_mstr_PWDATACHK),
      .pstrbchk(tie_apb_mstr_PSTRBCHK),
      .psubsysidchk(tie_apb_mstr_PSUBSYSIDCHK),
      .preadychk(tie_apb_mstr_PREADYCHK),
      .pselchk(tie_apb_mstr_PSELCHK),
      .paddrchk(tie_apb_mstr_PADDRCHK),
      .prdatachk(tie_apb_mstr_PRDATACHK),
      .pslverrchk(tie_apb_mstr_PSLVERRCHK),
      .pctrlchk(tie_apb_mstr_PCTRLCHK),
      .clk(clk__noc_clk),
      .resetn(resetN__apbViprst_n),
      .pnse(tie_apb_mstr_PNSE),
      .psubsysid(tie_apb_mstr_PSUBSYSID),
      .pwakeupchk(tie_apb_mstr_PWAKEUPCHK),
      .pauserchk(tie_apb_mstr_PAUSERCHK),
      .pwuserchk(tie_apb_mstr_PWUSERCHK),
      .pruserchk(tie_apb_mstr_PRUSERCHK),
      .pbuserchk(tie_apb_mstr_PBUSERCHK),
      .pselx(PSELX__apb_mstr_psel)
   ); // end of instance dut_usb4_tc_noc_apb_mstr

   cdnApb4Interface #(
      .ADDRESS_WIDTH(ADDRESS_WIDTH_cdb),
      .USER_RESP_WIDTH(USER_RESP_WIDTH_cdb),
      .INPUT_SKEW(INPUT_SKEW_cdb),
      .USER_REQ_WIDTH(USER_REQ_WIDTH_cdb),
      .DATA_WIDTH(DATA_WIDTH_cdb),
      .SUBSYSID_WIDTH(SUBSYSID_WIDTH_cdb),
      .OUTPUT_SKEW(OUTPUT_SKEW_cdb),
      .USER_DATA_WIDTH(USER_DATA_WIDTH_cdb)
   ) dut_usb4_tc_noc_cdb(
      .pslverr(PSLVERR__cdb_pslverr),
      .prdata(PRDATA__cdb_prdata),
      .pready(PREADY__cdb_pready),
      .pprot(tie_cdb_PPROT),
      .pstrb(PSTRB__cdb_pstrb),
      .pwdata(PWDATA__cdb_pwdata),
      .pwrite(PWRITE__cdb_pwrite),
      .penable(PENABLE__cdb_penable),
      .paddr(PADDR__cdb_paddr),
      .pwakeup(tie_cdb_PWAKEUP),
      .pauser(tie_cdb_PAUSER),
      .pwuser(tie_cdb_PWUSER),
      .pruser(tie_cdb_PRUSER),
      .pbuser(tie_cdb_PBUSER),
      .penablechk(tie_cdb_PENABLECHK),
      .pwdatachk(tie_cdb_PWDATACHK),
      .pstrbchk(tie_cdb_PSTRBCHK),
      .psubsysidchk(tie_cdb_PSUBSYSIDCHK),
      .preadychk(tie_cdb_PREADYCHK),
      .pselchk(tie_cdb_PSELCHK),
      .paddrchk(tie_cdb_PADDRCHK),
      .prdatachk(tie_cdb_PRDATACHK),
      .pslverrchk(tie_cdb_PSLVERRCHK),
      .pctrlchk(tie_cdb_PCTRLCHK),
      .clk(clk__tap2apb_pclk),
      .resetn(resetN__apbViprst_n),
      .pnse(tie_cdb_PNSE),
      .psubsysid(tie_cdb_PSUBSYSID),
      .pwakeupchk(tie_cdb_PWAKEUPCHK),
      .pauserchk(tie_cdb_PAUSERCHK),
      .pwuserchk(tie_cdb_PWUSERCHK),
      .pruserchk(tie_cdb_PRUSERCHK),
      .pbuserchk(tie_cdb_PBUSERCHK),
      .pselx(PSELX__cdb_psel)
   ); // end of instance dut_usb4_tc_noc_cdb

   cdnApb4Interface #(
      .ADDRESS_WIDTH(ADDRESS_WIDTH_cmn_cdb),
      .USER_RESP_WIDTH(USER_RESP_WIDTH_cmn_cdb),
      .INPUT_SKEW(INPUT_SKEW_cmn_cdb),
      .USER_REQ_WIDTH(USER_REQ_WIDTH_cmn_cdb),
      .DATA_WIDTH(DATA_WIDTH_cmn_cdb),
      .SUBSYSID_WIDTH(SUBSYSID_WIDTH_cmn_cdb),
      .OUTPUT_SKEW(OUTPUT_SKEW_cmn_cdb),
      .USER_DATA_WIDTH(USER_DATA_WIDTH_cmn_cdb)
   ) dut_usb4_tc_noc_cmn_cdb(
      .pslverr(tie_cmn_cdb_PSLVERR),
      .prdata(PRDATA__cmn_cdb_prdata),
      .pready(PREADY__cmn_cdb_pready),
      .pprot(tie_cmn_cdb_PPROT),
      .pstrb(PSTRB__cmn_cdb_pstrb),
      .pwdata(PWDATA__cmn_cdb_pwdata),
      .pwrite(PWRITE__cmn_cdb_pwrite),
      .penable(PENABLE__cmn_cdb_penable),
      .paddr(PADDR__cmn_cdb_paddr),
      .pwakeup(tie_cmn_cdb_PWAKEUP),
      .pauser(tie_cmn_cdb_PAUSER),
      .pwuser(tie_cmn_cdb_PWUSER),
      .pruser(tie_cmn_cdb_PRUSER),
      .pbuser(tie_cmn_cdb_PBUSER),
      .penablechk(tie_cmn_cdb_PENABLECHK),
      .pwdatachk(tie_cmn_cdb_PWDATACHK),
      .pstrbchk(tie_cmn_cdb_PSTRBCHK),
      .psubsysidchk(tie_cmn_cdb_PSUBSYSIDCHK),
      .preadychk(tie_cmn_cdb_PREADYCHK),
      .pselchk(tie_cmn_cdb_PSELCHK),
      .paddrchk(tie_cmn_cdb_PADDRCHK),
      .prdatachk(tie_cmn_cdb_PRDATACHK),
      .pslverrchk(tie_cmn_cdb_PSLVERRCHK),
      .pctrlchk(tie_cmn_cdb_PCTRLCHK),
      .clk(clk__noc_clk),
      .resetn(resetN__rst_n),
      .pnse(tie_cmn_cdb_PNSE),
      .psubsysid(tie_cmn_cdb_PSUBSYSID),
      .pwakeupchk(tie_cmn_cdb_PWAKEUPCHK),
      .pauserchk(tie_cmn_cdb_PAUSERCHK),
      .pwuserchk(tie_cmn_cdb_PWUSERCHK),
      .pruserchk(tie_cmn_cdb_PRUSERCHK),
      .pbuserchk(tie_cmn_cdb_PBUSERCHK),
      .pselx(PSELX__cmn_cdb_psel)
   ); // end of instance dut_usb4_tc_noc_cmn_cdb

   cdnApb4Interface #(
      .ADDRESS_WIDTH(ADDRESS_WIDTH_tc_reg),
      .USER_RESP_WIDTH(USER_RESP_WIDTH_tc_reg),
      .INPUT_SKEW(INPUT_SKEW_tc_reg),
      .USER_REQ_WIDTH(USER_REQ_WIDTH_tc_reg),
      .DATA_WIDTH(DATA_WIDTH_tc_reg),
      .SUBSYSID_WIDTH(SUBSYSID_WIDTH_tc_reg),
      .OUTPUT_SKEW(OUTPUT_SKEW_tc_reg),
      .USER_DATA_WIDTH(USER_DATA_WIDTH_tc_reg)
   ) dut_usb4_tc_noc_tc_reg(
      .pslverr(tie_tc_reg_PSLVERR),
      .prdata(PRDATA__tc_reg_prdata),
      .pready(PREADY__tc_reg_pready),
      .pprot(tie_tc_reg_PPROT),
      .pstrb(PSTRB__tc_reg_pstrb),
      .pwdata(PWDATA__tc_reg_pwdata),
      .pwrite(PWRITE__tc_reg_pwrite),
      .penable(PENABLE__tc_reg_penable),
      .paddr(PADDR__tc_reg_paddr),
      .pwakeup(tie_tc_reg_PWAKEUP),
      .pauser(tie_tc_reg_PAUSER),
      .pwuser(tie_tc_reg_PWUSER),
      .pruser(tie_tc_reg_PRUSER),
      .pbuser(tie_tc_reg_PBUSER),
      .penablechk(tie_tc_reg_PENABLECHK),
      .pwdatachk(tie_tc_reg_PWDATACHK),
      .pstrbchk(tie_tc_reg_PSTRBCHK),
      .psubsysidchk(tie_tc_reg_PSUBSYSIDCHK),
      .preadychk(tie_tc_reg_PREADYCHK),
      .pselchk(tie_tc_reg_PSELCHK),
      .paddrchk(tie_tc_reg_PADDRCHK),
      .prdatachk(tie_tc_reg_PRDATACHK),
      .pslverrchk(tie_tc_reg_PSLVERRCHK),
      .pctrlchk(tie_tc_reg_PCTRLCHK),
      .clk(clk__noc_clk),
      .resetn(resetN__rst_n),
      .pnse(tie_tc_reg_PNSE),
      .psubsysid(tie_tc_reg_PSUBSYSID),
      .pwakeupchk(tie_tc_reg_PWAKEUPCHK),
      .pauserchk(tie_tc_reg_PAUSERCHK),
      .pwuserchk(tie_tc_reg_PWUSERCHK),
      .pruserchk(tie_tc_reg_PRUSERCHK),
      .pbuserchk(tie_tc_reg_PBUSERCHK),
      .pselx(PSELX__tc_reg_psel)
   ); // end of instance dut_usb4_tc_noc_tc_reg

   cdnApb4Interface #(
      .ADDRESS_WIDTH(ADDRESS_WIDTH_usb_sub_sys),
      .USER_RESP_WIDTH(USER_RESP_WIDTH_usb_sub_sys),
      .INPUT_SKEW(INPUT_SKEW_usb_sub_sys),
      .USER_REQ_WIDTH(USER_REQ_WIDTH_usb_sub_sys),
      .DATA_WIDTH(DATA_WIDTH_usb_sub_sys),
      .SUBSYSID_WIDTH(SUBSYSID_WIDTH_usb_sub_sys),
      .OUTPUT_SKEW(OUTPUT_SKEW_usb_sub_sys),
      .USER_DATA_WIDTH(USER_DATA_WIDTH_usb_sub_sys)
   ) dut_usb4_tc_noc_usb_sub_sys(
      .pslverr(tie_usb_sub_sys_PSLVERR),
      .prdata(PRDATA__usb_sub_sys_prdata),
      .pready(PREADY__usb_sub_sys_pready),
      .pprot(tie_usb_sub_sys_PPROT),
      .pstrb(PSTRB__usb_sub_sys_pstrb),
      .pwdata(PWDATA__usb_sub_sys_pwdata),
      .pwrite(PWRITE__usb_sub_sys_pwrite),
      .penable(PENABLE__usb_sub_sys_penable),
      .paddr(PADDR__usb_sub_sys_paddr),
      .pwakeup(tie_usb_sub_sys_PWAKEUP),
      .pauser(tie_usb_sub_sys_PAUSER),
      .pwuser(tie_usb_sub_sys_PWUSER),
      .pruser(tie_usb_sub_sys_PRUSER),
      .pbuser(tie_usb_sub_sys_PBUSER),
      .penablechk(tie_usb_sub_sys_PENABLECHK),
      .pwdatachk(tie_usb_sub_sys_PWDATACHK),
      .pstrbchk(tie_usb_sub_sys_PSTRBCHK),
      .psubsysidchk(tie_usb_sub_sys_PSUBSYSIDCHK),
      .preadychk(tie_usb_sub_sys_PREADYCHK),
      .pselchk(tie_usb_sub_sys_PSELCHK),
      .paddrchk(tie_usb_sub_sys_PADDRCHK),
      .prdatachk(tie_usb_sub_sys_PRDATACHK),
      .pslverrchk(tie_usb_sub_sys_PSLVERRCHK),
      .pctrlchk(tie_usb_sub_sys_PCTRLCHK),
      .clk(clk__noc_clk),
      .resetn(resetN__rst_n),
      .pnse(tie_usb_sub_sys_PNSE),
      .psubsysid(tie_usb_sub_sys_PSUBSYSID),
      .pwakeupchk(tie_usb_sub_sys_PWAKEUPCHK),
      .pauserchk(tie_usb_sub_sys_PAUSERCHK),
      .pwuserchk(tie_usb_sub_sys_PWUSERCHK),
      .pruserchk(tie_usb_sub_sys_PRUSERCHK),
      .pbuserchk(tie_usb_sub_sys_PBUSERCHK),
      .pselx(PSELX__usb_sub_sys_psel)
   ); // end of instance dut_usb4_tc_noc_usb_sub_sys

   cdnApb4Interface #(
      .ADDRESS_WIDTH(ADDRESS_WIDTH_pam3_sub_sys),
      .USER_RESP_WIDTH(USER_RESP_WIDTH_pam3_sub_sys),
      .INPUT_SKEW(INPUT_SKEW_pam3_sub_sys),
      .USER_REQ_WIDTH(USER_REQ_WIDTH_pam3_sub_sys),
      .DATA_WIDTH(DATA_WIDTH_pam3_sub_sys),
      .SUBSYSID_WIDTH(SUBSYSID_WIDTH_pam3_sub_sys),
      .OUTPUT_SKEW(OUTPUT_SKEW_pam3_sub_sys),
      .USER_DATA_WIDTH(USER_DATA_WIDTH_pam3_sub_sys)
   ) dut_usb4_tc_noc_pam3_sub_sys(
      .pslverr(tie_pam3_sub_sys_PSLVERR),
      .prdata(PRDATA__pam3_sub_sys_prdata),
      .pready(PREADY__pam3_sub_sys_pready),
      .pprot(tie_pam3_sub_sys_PPROT),
      .pstrb(PSTRB__pam3_sub_sys_pstrb),
      .pwdata(PWDATA__pam3_sub_sys_pwdata),
      .pwrite(PWRITE__pam3_sub_sys_pwrite),
      .penable(PENABLE__pam3_sub_sys_penable),
      .paddr(PADDR__pam3_sub_sys_paddr),
      .pwakeup(tie_pam3_sub_sys_PWAKEUP),
      .pauser(tie_pam3_sub_sys_PAUSER),
      .pwuser(tie_pam3_sub_sys_PWUSER),
      .pruser(tie_pam3_sub_sys_PRUSER),
      .pbuser(tie_pam3_sub_sys_PBUSER),
      .penablechk(tie_pam3_sub_sys_PENABLECHK),
      .pwdatachk(tie_pam3_sub_sys_PWDATACHK),
      .pstrbchk(tie_pam3_sub_sys_PSTRBCHK),
      .psubsysidchk(tie_pam3_sub_sys_PSUBSYSIDCHK),
      .preadychk(tie_pam3_sub_sys_PREADYCHK),
      .pselchk(tie_pam3_sub_sys_PSELCHK),
      .paddrchk(tie_pam3_sub_sys_PADDRCHK),
      .prdatachk(tie_pam3_sub_sys_PRDATACHK),
      .pslverrchk(tie_pam3_sub_sys_PSLVERRCHK),
      .pctrlchk(tie_pam3_sub_sys_PCTRLCHK),
      .clk(clk__noc_clk),
      .resetn(resetN__rst_n),
      .pnse(tie_pam3_sub_sys_PNSE),
      .psubsysid(tie_pam3_sub_sys_PSUBSYSID),
      .pwakeupchk(tie_pam3_sub_sys_PWAKEUPCHK),
      .pauserchk(tie_pam3_sub_sys_PAUSERCHK),
      .pwuserchk(tie_pam3_sub_sys_PWUSERCHK),
      .pruserchk(tie_pam3_sub_sys_PRUSERCHK),
      .pbuserchk(tie_pam3_sub_sys_PBUSERCHK),
      .pselx(PSELX__pam3_sub_sys_psel)
   ); // end of instance dut_usb4_tc_noc_pam3_sub_sys

   cdnApb4Interface #(
      .ADDRESS_WIDTH(ADDRESS_WIDTH_apb_tgt),
      .USER_RESP_WIDTH(USER_RESP_WIDTH_apb_tgt),
      .INPUT_SKEW(INPUT_SKEW_apb_tgt),
      .USER_REQ_WIDTH(USER_REQ_WIDTH_apb_tgt),
      .DATA_WIDTH(DATA_WIDTH_apb_tgt),
      .SUBSYSID_WIDTH(SUBSYSID_WIDTH_apb_tgt),
      .OUTPUT_SKEW(OUTPUT_SKEW_apb_tgt),
      .USER_DATA_WIDTH(USER_DATA_WIDTH_apb_tgt)
   ) dut_usb4_tc_noc_apb_tgt(
      .pslverr(PSLVERR__apb_tgt_pslverr),
      .prdata(PRDATA__apb_tgt_prdata),
      .pready(PREADY__apb_tgt_pready),
      .pprot(tie_apb_tgt_PPROT),
      .pstrb(PSTRB__apb_tgt_pstrb),
      .pwdata(PWDATA__apb_tgt_pwdata),
      .pwrite(PWRITE__apb_tgt_pwrite),
      .penable(PENABLE__apb_tgt_penable),
      .paddr(PADDR__apb_tgt_paddr),
      .pwakeup(tie_apb_tgt_PWAKEUP),
      .pauser(tie_apb_tgt_PAUSER),
      .pwuser(tie_apb_tgt_PWUSER),
      .pruser(tie_apb_tgt_PRUSER),
      .pbuser(tie_apb_tgt_PBUSER),
      .penablechk(tie_apb_tgt_PENABLECHK),
      .pwdatachk(tie_apb_tgt_PWDATACHK),
      .pstrbchk(tie_apb_tgt_PSTRBCHK),
      .psubsysidchk(tie_apb_tgt_PSUBSYSIDCHK),
      .preadychk(tie_apb_tgt_PREADYCHK),
      .pselchk(tie_apb_tgt_PSELCHK),
      .paddrchk(tie_apb_tgt_PADDRCHK),
      .prdatachk(tie_apb_tgt_PRDATACHK),
      .pslverrchk(tie_apb_tgt_PSLVERRCHK),
      .pctrlchk(tie_apb_tgt_PCTRLCHK),
      .clk(clk__noc_clk),
      .resetn(resetN__rst_n),
      .pnse(tie_apb_tgt_PNSE),
      .psubsysid(tie_apb_tgt_PSUBSYSID),
      .pwakeupchk(tie_apb_tgt_PWAKEUPCHK),
      .pauserchk(tie_apb_tgt_PAUSERCHK),
      .pwuserchk(tie_apb_tgt_PWUSERCHK),
      .pruserchk(tie_apb_tgt_PRUSERCHK),
      .pbuserchk(tie_apb_tgt_PBUSERCHK),
      .pselx(PSELX__apb_tgt_psel)
   ); // end of instance dut_usb4_tc_noc_apb_tgt

   cdnApb4Interface #(
      .ADDRESS_WIDTH(ADDRESS_WIDTH_xcvr_ln_0),
      .USER_RESP_WIDTH(USER_RESP_WIDTH_xcvr_ln_0),
      .INPUT_SKEW(INPUT_SKEW_xcvr_ln_0),
      .USER_REQ_WIDTH(USER_REQ_WIDTH_xcvr_ln_0),
      .DATA_WIDTH(DATA_WIDTH_xcvr_ln_0),
      .SUBSYSID_WIDTH(SUBSYSID_WIDTH_xcvr_ln_0),
      .OUTPUT_SKEW(OUTPUT_SKEW_xcvr_ln_0),
      .USER_DATA_WIDTH(USER_DATA_WIDTH_xcvr_ln_0)
   ) dut_usb4_tc_noc_xcvr_ln_0(
      .pslverr(tie_xcvr_ln_0_PSLVERR),
      .prdata(PRDATA__xcvr_ln_0_prdata),
      .pready(PREADY__xcvr_ln_0_pready),
      .pprot(tie_xcvr_ln_0_PPROT),
      .pstrb(PSTRB__xcvr_ln_0_pstrb),
      .pwdata(PWDATA__xcvr_ln_0_pwdata),
      .pwrite(PWRITE__xcvr_ln_0_pwrite),
      .penable(PENABLE__xcvr_ln_0_penable),
      .paddr(PADDR__xcvr_ln_0_paddr),
      .pwakeup(tie_xcvr_ln_0_PWAKEUP),
      .pauser(tie_xcvr_ln_0_PAUSER),
      .pwuser(tie_xcvr_ln_0_PWUSER),
      .pruser(tie_xcvr_ln_0_PRUSER),
      .pbuser(tie_xcvr_ln_0_PBUSER),
      .penablechk(tie_xcvr_ln_0_PENABLECHK),
      .pwdatachk(tie_xcvr_ln_0_PWDATACHK),
      .pstrbchk(tie_xcvr_ln_0_PSTRBCHK),
      .psubsysidchk(tie_xcvr_ln_0_PSUBSYSIDCHK),
      .preadychk(tie_xcvr_ln_0_PREADYCHK),
      .pselchk(tie_xcvr_ln_0_PSELCHK),
      .paddrchk(tie_xcvr_ln_0_PADDRCHK),
      .prdatachk(tie_xcvr_ln_0_PRDATACHK),
      .pslverrchk(tie_xcvr_ln_0_PSLVERRCHK),
      .pctrlchk(tie_xcvr_ln_0_PCTRLCHK),
      .clk(clk__noc_clk),
      .resetn(resetN__rst_n),
      .pnse(tie_xcvr_ln_0_PNSE),
      .psubsysid(tie_xcvr_ln_0_PSUBSYSID),
      .pwakeupchk(tie_xcvr_ln_0_PWAKEUPCHK),
      .pauserchk(tie_xcvr_ln_0_PAUSERCHK),
      .pwuserchk(tie_xcvr_ln_0_PWUSERCHK),
      .pruserchk(tie_xcvr_ln_0_PRUSERCHK),
      .pbuserchk(tie_xcvr_ln_0_PBUSERCHK),
      .pselx(PSELX__xcvr_ln_0_psel)
   ); // end of instance dut_usb4_tc_noc_xcvr_ln_0

   // CLOCK CONTROL
   // Instance of clock_controller_interface will drive clock using default clock parameters
   clock_controller_interface #(
      .CLK_STATUS(0),
      .CLK_INIT_VAL(0),
      .CLK_INIT_DELAY(0), // 0ps
      .CLK_HALFPERIOD(5000) // 5000ps
      ) tap2apb_pclk (
         .clk(clk__tap2apb_pclk)
   ); // end of tap2apb_pclk

   // CLOCK CONTROL
   // Instance of clock_controller_interface will drive clock using default clock parameters
   clock_controller_interface #(
      .CLK_STATUS(0),
      .CLK_INIT_VAL(0),
      .CLK_INIT_DELAY(9), // 9ps
      .CLK_HALFPERIOD(5000) // 5000ps
      ) noc_clk (
         .clk(clk__noc_clk)
   ); // end of noc_clk

   // RESET CONTROL
   // Instance of reset_controller_interface will initialize value of reset signal
   reset_controller_interface #(
      .RST_KIND(0),
      .RST_INIT_DELAY(8000), // 8000ps
      .NUM_CLKS_ASSERTED(10),
      .DEASSERT_POSITION(0)
      ) rst_n (
         .clk(clk__tap2apb_pclk),
         .reset(resetN__rst_n)
   ); // end of rst_n

   // RESET CONTROL
   // Instance of reset_controller_interface will initialize value of reset signal
   reset_controller_interface #(
      .RST_KIND(0),
      .RST_INIT_DELAY(8000), // 8000ps
      .NUM_CLKS_ASSERTED(15),
      .DEASSERT_POSITION(0)
      ) apbViprst_n (
         .clk(clk__tap2apb_pclk),
         .reset(resetN__apbViprst_n)
   ); // end of apbViprst_n


   `include "dut_usb4_tc_noc_usr_tb_connections.sv"

   // import the tests package so that it is not optimized out during elaboration
   import dut_usb4_tc_noc_tb_test_pkg::*;

   // configure the paths to interfaces instantiated in this module
   function void configure_virtual_interfaces();
      uvm_pkg::uvm_config_db#(virtual vip_select_itf)::set(null, "*", "vip_select_itf", vip_select);

      // CLOCK CONTROL
      // Pass pointer to the instance of clock_controller_interface into UVM environment
      uvm_pkg::uvm_config_db#(virtual clock_controller_interface #(
      .CLK_STATUS(0),
      .CLK_INIT_VAL(0),
      .CLK_INIT_DELAY(0), // 0ps
      .CLK_HALFPERIOD(5000) // 5000ps
      ))::set(null, "*", "tap2apb_pclk_vif", tap2apb_pclk);


      // CLOCK CONTROL
      // Pass pointer to the instance of clock_controller_interface into UVM environment
      uvm_pkg::uvm_config_db#(virtual clock_controller_interface #(
      .CLK_STATUS(0),
      .CLK_INIT_VAL(0),
      .CLK_INIT_DELAY(9), // 9ps
      .CLK_HALFPERIOD(5000) // 5000ps
      ))::set(null, "*", "noc_clk_vif", noc_clk);


      // RESET CONTROL
      // Pass pointer to the instance of reset_controller_interface into UVM environment
      uvm_pkg::uvm_config_db#(virtual reset_controller_interface #(
      .RST_KIND(0),
      .RST_INIT_DELAY(8000), // 8000ps
      .NUM_CLKS_ASSERTED(10),
      .DEASSERT_POSITION(0)
      ))::set(null, "*", "rst_n_vif", rst_n);


      // RESET CONTROL
      // Pass pointer to the instance of reset_controller_interface into UVM environment
      uvm_pkg::uvm_config_db#(virtual reset_controller_interface #(
      .RST_KIND(0),
      .RST_INIT_DELAY(8000), // 8000ps
      .NUM_CLKS_ASSERTED(15),
      .DEASSERT_POSITION(0)
      ))::set(null, "*", "apbViprst_n_vif", apbViprst_n);

   endfunction

   initial begin

	 `ifdef SDF
			$sdf_annotate("usb4_tc_noc_syn.sdf",i_usb4_tc_noc,,"sdf.log", "MAXIMUM");
	 `endif

      configure_virtual_interfaces();

      // configure this module's name as the path dut_usb4_tc_noc to VIP wrapper modules in it
      uvm_pkg::uvm_config_db#(string)::set(null, "*", "vip_wrapper_modules_path", "dut_usb4_tc_noc");

      // issue run_test
      uvm_pkg::run_test();
   end
endmodule // component dut_usb4_tc_noc();


`include "dut_usb4_tc_noc_usr_tb_post_extensions.sv"

`endif // `ifndef STG_TOP_MODULE
