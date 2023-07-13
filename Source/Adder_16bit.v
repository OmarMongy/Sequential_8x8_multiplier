module adder (
  input [15:0] dataa,
  input [15:0] datab,
  output [15:0] sum
);

  assign sum = dataa + datab;

endmodule
