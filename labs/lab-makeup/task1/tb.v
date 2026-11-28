// tb.v -- Given, do not modify.
// Interface check only: confirms that track_cell, level_crossing and gate_ctrl
// exist with the ports of Figure A1. It does NOT check that they work.
`timescale 1ns/1ps
module tb;
  reg        a = 0, b = 0, c = 0, clk = 0, rst_n = 0, fault_i = 0;
  reg  [1:0] t = 0;
  reg  [5:0] sens = 0;
  wire       d, e, down1, down2, fault2;
  wire [1:0] lamp1, lamp2;
  wire [2:0] hold1, hold2;

  track_cell     UT (.a(a), .b(b), .c(c), .d(d), .e(e));
  gate_ctrl      UG (.clk(clk), .rst_n(rst_n), .t(t), .fault(fault_i),
                     .hold(hold1), .down(down1), .lamp(lamp1));
  level_crossing UL (.clk(clk), .rst_n(rst_n), .sens(sens),
                     .down(down2), .lamp(lamp2), .hold(hold2), .fault(fault2));

  string vcd_file;
  initial begin
    if ($value$plusargs("vcd=%s", vcd_file)) begin
      $dumpfile(vcd_file);
      $dumpvars(0, tb);
    end
  end

  initial begin
    #1 $display("INTERFACE CHECK DONE (compile warnings about ports, if any, must be fixed)");
    $finish;
  end
endmodule
