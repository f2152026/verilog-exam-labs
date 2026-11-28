// model.v -- Given, do not modify.
// step_model: a purely behavioural model of the step counter, written only to
// generate the correct expected outputs. It is not built like step_counter.
module step_model (input clk, rst_n, step, clear,
                   output reg [3:0] n, output reg zero, still);
  reg [3:0] n_old;
  always @(posedge clk or negedge rst_n)
    if (!rst_n) begin
      n <= 4'd0; n_old <= 4'd0;
    end else begin
      n_old <= n;
      if (clear)                  n <= 4'd0;
      else if (step && n < 4'd15) n <= n + 4'd1;
    end
  always @(*) begin
    zero  = (n == 4'd0);
    still = (n == n_old);
  end
endmodule
