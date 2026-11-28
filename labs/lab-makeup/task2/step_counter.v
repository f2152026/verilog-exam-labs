// next_steps: works out the step count after the next clock edge
module next_steps (input [3:0] n, input step, clear, output reg [3:0] next);
  always @(*) begin
    if (clear)                     next = 4'd0;
    else if (step && n != 4'd15)   next = n + 4'd1;
    else                           next = n;
  end
endmodule

// step_reg: stores the count and the count before the last clock edge; rst_n clears both
module step_reg (input clk, rst_n, input [3:0] d, output reg [3:0] q, prev);
  always @(posedge clk or negedge rst_n)
    if (!rst_n) begin
      q    <= 4'd0;
      prev <= 4'd0;
    end else begin
      q    = d;
      prev = q;
    end
endmodule

// step_status: zero while the count is 0; still while the count did not change
module step_status (input [3:0] n, prev, output zero, still);
  assign zero  = ~n;
  assign still = (n == prev);
endmodule

// step_counter: top level
module step_counter (input clk, rst_n, step, clear,
                     output [3:0] n, output zero, still);
  wire [3:0] next, prev;
  next_steps  U1 (n, step, clear, next);
  step_reg    U2 (clk, rst_n, next, n, prev);
  step_status U3 (n, prev, zero, still);
endmodule
