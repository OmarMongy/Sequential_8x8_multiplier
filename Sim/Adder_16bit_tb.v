module Adder16_bitTestBench;
  
  reg [15:0] dataa;
  reg [15:0] datab;
  
  wire [15:0] sum;
  
  adder dut(
    .dataa(dataa),
    .datab(datab),
    .sum(sum)
  );
  
  initial begin

#10 
dataa = 8'b 0000_1111;
datab = 8'b 0110_1000;
#10    
dataa = 8'b 0011_1100;
datab = 8'b 0100_1000;
#10     
dataa = 8'b 0000_0000;
datab = 8'b 0000_1111;  
  
  end
  
endmodule
