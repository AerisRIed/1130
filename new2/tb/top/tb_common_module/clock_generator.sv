`ifndef CLOCK_GENERATOR__SV
`define CLOCK_GENERATOR__SV

module clock_generator #(
  parameter DUTY_CYCLE,          // Duty cycle (0.0 to 1.0)
  parameter JITTER,              // Jitter range ± in ns
  parameter SKEW                 // Fixed phase offset (skew) in ns
)(
  output logic clk,               // Output clock signal
  input  logic rst_n,             // Active-low asynchronous reset
  // Dynamic configuration inputs
  input real PERIOD              // Clock period in ns
);

  timeunit 1ns; timeprecision 1ps;

  // Internal variables for timing control
  real jitter;
  real period;
  real skew;
  real high_time, low_time;

  initial begin
    clk = 0;
    period = PERIOD;
    skew   = SKEW;

    // Initial skew delay (if enabled)
    #(skew);

    // Clock generation loop
    forever begin
      // Random jitter sampled within ± range
      jitter = ($urandom_range(-JITTER*1000, JITTER*1000)) / 1000.0;
      
      // Calculate high and low times based on duty cycle and jitter
      high_time = ((period + jitter) * DUTY_CYCLE);
      low_time  = ((period + jitter) * (1.0 - DUTY_CYCLE));

      // Toggle clock with calculated delays
      clk = 1;
      #(high_time);
      
      clk = 0;
      #(low_time);
    end
  end

endmodule
`endif