//------------------------------------------------------------------------------
//    This confidential and proprietary HDL soft description of a Hardware
//    component may be used only as authorized by a licensing agreement from
//    Cadence. In the event of publication, the following notice is applicable:
//
//                       (C) COPYRIGHT 2025 Cadence
//                         ALL RIGHTS RESERVED
//
//     The entire notice above must be reproduced on all authorized
//     copies of this code.
//------------------------------------------------------------------------------
//
// Filename        : fw_log_monitor.sv
//
// Author          : Firmware Debug Infrastructure
// Abstract        : Monitor for firmware log writes to SRAM
//                   Captures log data and timestamps for post-processing
//
// Description     : This module monitors SRAM write transactions to a specific
//                   target address and logs the data with precise timestamps
//                   to a text file for firmware debug and analysis.
//
//                   The monitor is non-intrusive and uses SystemVerilog bind
//                   to attach to existing SRAM instances without modification.
//
// Usage           : Instantiate via bind statement:
//                   bind sram fw_log_monitor #(
//                       .TARGET_ADDR(14'h4),
//                       .LOG_FILE_NAME("fw_log.txt")
//                   ) mon_inst();
//
//------------------------------------------------------------------------------

`timescale 1ns / 1ps

module fw_log_monitor #(
    parameter ADDR_WIDTH = 14,
    parameter DATA_WIDTH = 32,
    parameter TARGET_ADDR = 0,
    parameter LOG_FILE_NAME = "fw_log.txt",
    parameter MONITOR_NAME = "FW_LOG_MON"
)(
    // Input ports connected via bind statement
    input                       clk,
    input [ADDR_WIDTH-1:0]      address,
    input [DATA_WIDTH-1:0]      data_in,
    input                       enable,
    input                       write
);

    //--------------------------------------------------------------------------
    // Internal Signal Aliases (for readability)
    //--------------------------------------------------------------------------
    wire                       mon_clk     = clk;
    wire [ADDR_WIDTH-1:0]      mon_address = address;
    wire [DATA_WIDTH-1:0]      mon_data_in = data_in;
    wire                       mon_enable  = enable;
    wire                       mon_write   = write;

    //--------------------------------------------------------------------------
    // Internal Variables
    //--------------------------------------------------------------------------
    integer log_file_handle;
    bit     enable_logging;
    bit     verbose_mode;
    time    log_timestamp;
    logic [DATA_WIDTH-1:0] log_data;
    longint log_count;

    //--------------------------------------------------------------------------
    // Initialization
    //--------------------------------------------------------------------------
    initial begin
        log_file_handle = 0;
        enable_logging = 1;
        verbose_mode = 0;
        log_count = 0;

        // Check for disable flag
        if ($test$plusargs("DISABLE_FW_LOG")) begin
            enable_logging = 0;
            $display("[%s] FW Log monitoring DISABLED via plusarg", MONITOR_NAME);
        end else begin
            enable_logging = 1;
        end

        // Check for verbose mode
        if ($test$plusargs("FW_LOG_VERBOSE")) begin
            verbose_mode = 1;
            $display("[%s] Verbose mode enabled", MONITOR_NAME);
        end

        // Open log file
        if (enable_logging) begin
            log_file_handle = $fopen(LOG_FILE_NAME, "w");
            if (log_file_handle == 0) begin
                $error("[%s] Failed to open log file: %s", MONITOR_NAME, LOG_FILE_NAME);
                enable_logging = 0;
            end else begin
                // Write header
                $fwrite(log_file_handle, "========================================\n");
                $fwrite(log_file_handle, " %s - Firmware Log Monitor\n", MONITOR_NAME);
                $fwrite(log_file_handle, "========================================\n");
                $fwrite(log_file_handle, " Target Address: 0x%0h\n", TARGET_ADDR);
                $fwrite(log_file_handle, " Data Width:     %0d bits\n", DATA_WIDTH);
                $fwrite(log_file_handle, " Start Time:     %0t\n", $time);
                $fwrite(log_file_handle, "========================================\n");
                $fwrite(log_file_handle, "\n");

                $display("[%s] Monitoring address 0x%0h -> %s",
                         MONITOR_NAME, TARGET_ADDR, LOG_FILE_NAME);
            end
        end
    end

    //--------------------------------------------------------------------------
    // Monitor Logic - Detect writes to target address
    //--------------------------------------------------------------------------
    always @(posedge mon_clk) begin
        if (enable_logging) begin
            // Detect write transaction: !enable && !write && address match
            //if (!mon_enable && !mon_write && (mon_address == TARGET_ADDR[ADDR_WIDTH-1:0])) begin
	    if (!mon_enable && !mon_write && (mon_address == TARGET_ADDR)) begin
                log_timestamp = $time;
                log_data = mon_data_in;
                log_count = log_count + 1;

                // Write to log file
                write_log_entry();

                // Verbose console output
                if (verbose_mode) begin
                    $display("[%s] @%0t: Log #%0d captured: 0x%08X",
                             MONITOR_NAME, log_timestamp, log_count, log_data);
                end
            end
        end
    end

    //--------------------------------------------------------------------------
    // Task: Write Log Entry to File
    //--------------------------------------------------------------------------
    task write_log_entry();
        if (log_file_handle != 0) begin
            // Format: [timestamp] 0xHEXVALUE
            $fwrite(log_file_handle, "[%0tns] 0x%08X\n", log_timestamp, log_data);
            $fflush(log_file_handle);  // Ensure immediate write for real-time viewing
        end
    endtask

    //--------------------------------------------------------------------------
    // Final Block - Cleanup
    //--------------------------------------------------------------------------
    final begin
        if (log_file_handle != 0) begin
            $fwrite(log_file_handle, "\n");
            $fwrite(log_file_handle, "========================================\n");
            $fwrite(log_file_handle, " Monitoring Complete\n");
            $fwrite(log_file_handle, "========================================\n");
            $fwrite(log_file_handle, " End Time:       %0t\n", $time);
            $fwrite(log_file_handle, " Total Logs:     %0d\n", log_count);
            $fwrite(log_file_handle, "========================================\n");

            $fclose(log_file_handle);

            if (enable_logging) begin
                $display("[%s] Monitoring complete. Total logs captured: %0d",
                         MONITOR_NAME, log_count);
            end
        end
    end

    //--------------------------------------------------------------------------
    // Assertions for Design Verification
    //--------------------------------------------------------------------------

    // Check that we're monitoring a valid SRAM instance
    initial begin
        #1;  // Wait for elaboration
        if (enable_logging) begin
            // Verify we can access parent signals
            if ($isunknown(mon_clk)) begin
                $warning("[%s] Clock signal appears to be unknown - check bind context",
                         MONITOR_NAME);
            end
        end
    end

    // Property: Log data should be stable when written
    property p_data_stable;
        @(posedge mon_clk)
        (!mon_enable && !mon_write && (mon_address == TARGET_ADDR[ADDR_WIDTH-1:0]))
        |-> !$isunknown(mon_data_in);
    endproperty

    // Only check assertion if monitoring is enabled
    generate
        if (1) begin : gen_assertions
            // Uncomment for strict checking (may cause false failures during reset)
            // assert_data_stable : assert property (p_data_stable)
            // else $warning("[%s] Write detected with X/Z data at address 0x%0h",
            //               MONITOR_NAME, TARGET_ADDR);
        end
    endgenerate

endmodule
