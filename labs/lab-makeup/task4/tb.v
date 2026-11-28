// tb.v -- Given, do not modify.
// Interface check only: confirms that train_count exists with the ports given in
// question B3. It does NOT check that it works.
`timescale 1ns/1ps
module tb;
  reg        clk = 0, rst_n = 0;
  reg  [1:0] t = 0;
  wire [3:0] trains;
  wire       busy;
  train_count UC (.clk(clk), .rst_n(rst_n), .t(t), .trains(trains), .busy(busy));

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
