// tb.v -- Part B1: complete this self-checking testbench for step_counter.
// Keep the instance name dut. Do not change model.v.
// It must end by printing one line: RESULT: PASS or RESULT: FAIL
`timescale 1ns/1ps
module tb;
  reg        clk = 0, rst_n = 0, step = 0, clear = 0;
  wire [3:0] n;
  wire       zero, still;
  step_counter dut (.clk(clk), .rst_n(rst_n), .step(step), .clear(clear),
                    .n(n), .zero(zero), .still(still));

  always #5 clk = ~clk;

  // (a) TODO: instantiate step_model (in model.v) as the reference model,
  //     driven by the same inputs as dut.

  // (a) TODO: after every clock edge, compare n, zero and still of dut with the
  //     model's outputs; on a mismatch add 1 to errors ($display helps debug).
  integer errors = 0;

  // (b) TODO: test cases. Change inputs only at falling clock edges.
  //     Cover every rule in the specification.
  initial begin
    #12 rst_n = 1;
    @(negedge clk) step = 1;
    @(negedge clk) step = 0;
    // ... your test cases here ...
    @(negedge clk); #1;                       // let the last check finish
    if (errors == 0) $display("RESULT: PASS");
    else             $display("RESULT: FAIL");
    $finish;
  end

  // waveform dump for the Run button: keep this block
  string vcd_file;
  initial begin
    if ($value$plusargs("vcd=%s", vcd_file)) begin
      $dumpfile(vcd_file);
      $dumpvars(0, tb);
    end
  end
endmodule
