module counter (
  input wire clk,
  input wire aclr_n,
  output reg [1:0] count
);


  always @(posedge clk or negedge aclr_n) begin
    if (!aclr_n)
      count <= 2'b00;
    else
      count <= count + 1;
  end

endmodule
