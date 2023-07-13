module Synchronous_register_TestBench();
  reg clk;
  reg sclr_n;
  reg clk_ena;
  reg [15:0] datain;
  wire [15:0] reg_out;
  
  reg16 DUT (
    .clk(clk),
    .sclr_n(sclr_n),
    .clk_ena(clk_ena),
    .datain(datain),
    .reg_out(reg_out)
  );


  always #5 clk = ~clk;

  initial begin
    clk = 0;
    sclr_n = 1;
    clk_ena = 1;
    datain = 16'b1010_1100_0101_0011;                               
 
    #10 sclr_n = 0;
    #10 sclr_n = 1;

    #10 clk_ena = 0;
    #10 clk_ena = 1;
  
end
endmodule
