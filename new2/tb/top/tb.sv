`ifndef TB__SV
`define TB__SV
`timescale 1 ns / 100 ps

//define lib of the value used in the testbench
`include "value_defines.svh"
//define lib of the hier used in the testbench
`include "hier_defines.svh"

module tb_top();
    //parameter lib of the testbench
    `include "param_lib.svh"
    
    //dut to tb connect
    `include "dut_connect.sv"

    //Common api used int the testbech
    `include "reg_op_task.sv"
    `include "common_task.sv"

    //UPF suppyly
    `include "upf_supply.sv"

    //gatesim block and sdf annotate
    `include "gatesim.sv"
    //clock reset gen
    // `include "clock_reset_gen.sv"
    
    //Temporary tie-offs for the dut input
    `include "temp_tie_offs.sv"

    //Main sequence of the testcase
    `include "./test_main.sv"

    //TODO ..any features needed in the future

    //Wavedump & Timeout block
    initial begin
        `ifndef DISABLE_WAVES
            $shm_open("waveform_rtl.shm");
            $shm_probe("AS");
        `endif
        fork
            begin
                int time_cnt = 0;
                while(1) begin
                    #10us;
                    time_cnt = time_cnt+1;
                    $display("[running time],simulation have been running %0d us",time_cnt*10);
                end
            end
            begin
                #5ms;
            
                $display("------------------------------------------------------------------");
                $display("[%f] [INFO] - TIME_OUT !!!! ",$time);
                $display("------------------------------------------------------------------");
            
                $finish(2);
            end
        join_any
    end
endmodule
`endif