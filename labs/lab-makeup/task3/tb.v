// tb.v -- Part B2. Do NOT change the input sequence.
// You may add $display / $monitor statements here and inside step_counter.v.
`timescale 1ns/1ps
module tb;
  reg clk = 0, rst_n = 0, step = 0, clear = 0;
  wire [3:0] n;
  wire       zero, still;
  step_counter dut (.clk(clk), .rst_n(rst_n), .step(step), .clear(clear),
                    .n(n), .zero(zero), .still(still));
  string vcd_file;
  initial begin
    if ($value$plusargs("vcd=%s", vcd_file)) begin
      $dumpfile(vcd_file);
      $dumpvars(0, tb);
    end
  end

  always #5 clk = ~clk;
  initial begin
    #12 rst_n = 1;
    repeat (2) @(negedge clk);
    repeat (4) begin
      step = 1;
      @(negedge clk) step = 0;
      @(negedge clk);
    end
    @(negedge clk) clear = 1;
    @(negedge clk) clear = 0;
    repeat (2) @(negedge clk);
    $finish;
  end
endmodule
