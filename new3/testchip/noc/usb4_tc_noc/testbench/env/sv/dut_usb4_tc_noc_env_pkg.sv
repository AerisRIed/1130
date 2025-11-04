/* ------------------------------------------------------------------------------
--
-- CADENCE Copyright (c) 2025
-- Cadence Design Systems, Inc.
-- All rights reserved.
--
-- 
-- This work may not be copied, modified, re-published, uploaded, executed, or
-- distributed in any way, in any medium, whether in whole or in part, without
-- prior written permission from Cadence Design Systems, Inc.
--------------------------------------------------------------------------------- */

`include "uvm_macros.svh"

// The following code enables this example to support multiple UVM versions, including the new UVM-IEEE.
// If your testbench targets only the new UVM-IEEE, you can skip this, and adapt the example code to use
// only UVM-IEEE constructs.

`ifdef UVM_VERSION
   `ifndef UVM_ENABLE_DEPRECATED_API

      // enable changes added for UVM 1.2
      `define UVM_POST_VERSION_1_1

      // include the sequence macros as a convenience layer
      `include "deprecated/macros/uvm_sequence_defines.svh"

   `endif // UVM_ENABLE_DEPRECATED_API
`endif // UVM_VERSION

package dut_usb4_tc_noc_env_pkg;

   // Utility packages
   import uvm_pkg::*;
   import cdn_stg_pkg::*;

   // VIP packages
   import DenaliSvMem::*;
   // SVD VIP packages
   import DenaliSvSvd::*;
   import cdnSvdUvm::*;

   `ifdef STG_ENABLE_UR
      // Unified Recorder
      import CdnURec::*;
   `endif // STG_ENABLE_UR

   // cdn_ace VIP package(s)
   import DenaliSvCdn_apb::*;
   import cdnApbUvm::*;

   // classes derived from VIP base types
   `include "cdn_stg/plugins/cdn_stg_plugins_h.sv"
   `include "cdn_stg/plugins/apb/cdn_stg_plugin_apb.sv"

   // environment implementation
   `include "dut_usb4_tc_noc_env_routing_model_port.sv"
   `include "dut_usb4_tc_noc_env_routing_model.sv"
   `include "cdn_stg/sv/cdn_stg_basic_env_scoreboard_agent.sv"
   `include "cdnSvdUvmUserCoverage.sv"
   `include "dut_usb4_tc_noc_env_scoreboard_inst.sv"

   `include "dut_usb4_tc_noc_env_vsequencer.sv"
   `include "dut_usb4_tc_noc_env_vseq_lib.sv"


   `include "dut_usb4_tc_noc_env_apb_top.sv"
   `include "scoreboardCfg.sv"
   `include "cdn_stg/plugins/apb/cdn_stg_apb_basic_env_port.sv"

   `include "dut_usb4_tc_noc_env_cfg.sv"
   `include "dut_usb4_tc_noc_env_vip_container.sv"
   `include "dut_usb4_tc_noc_env_apb_build_code.sv"
   `include "dut_usb4_tc_noc_env_apb_config_code.sv"
   `include "dut_usb4_tc_noc_env_scoreboard_container.sv"
   `include "dut_usb4_tc_noc_env_base.sv"
   `include "dut_usb4_tc_noc_env_apb_connect_code.sv"


   // User extensions file must be `included last
   `include "dut_usb4_tc_noc_env_pkg_usr.sv"

endpackage
