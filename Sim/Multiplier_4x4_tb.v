module Multiplier_4x4TestBench;
 
  reg [3:0] dataa;
  reg [3:0] datab;
  
  
  wire [7:0] product;
  
  mult_4x4 dut(
    .dataa(dataa),
    .datab(datab),
    .product(product)
  );
  
  initial begin
 #10
dataa = 5;
datab = 3;
 #10   
dataa = 8;
datab = 2;
 #10
dataa = 6;
datab = 4;
    
  end

endmodule
