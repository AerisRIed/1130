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


`include "all_masters_all_slaves_test.sv"
`include "single_master_all_slaves_test.sv"
`include "all_masters_single_slave_test.sv"
`include "single_master_single_slave_test.sv"

`include "single_master_mapped_segments_test.sv"
`include "single_master_unmapped_segments_test.sv"
`include "single_master_illegal_mapped_segments_test.sv"
`include "single_master_random_segments_test.sv"
`include "single_master_internal_segments_test.sv"
`include "all_masters_mapped_segments_test.sv"
`include "all_masters_unmapped_segments_test.sv"
`include "all_masters_illegal_mapped_segments_test.sv"
`include "all_masters_random_segments_test.sv"
`include "all_masters_internal_segments_test.sv"

`include "custom_reset_and_configure_dut_event_test.sv"

`include "clock_and_reset_control_test.sv"

