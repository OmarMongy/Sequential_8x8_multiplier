module mux4_TestBench();
 reg [3:0] dataa;
 reg [3:0] datab;
 reg [1:0] selector;
 wire [3:0] aout;
 
 mux4 mux(
.mux_in_a(dataa),
.mux_in_b(datab),
.mux_sel(selector),
.mux_out(aout)
);
initial begin
dataa = 4'b 0000;
datab = 4'b 1111;
selector = 2'b 00;
  #10
selector = 2'b 01;
  #10
dataa = 4'b 1010;
datab = 4'b 0011;
  #10
selector = 2'b 00;

end

endmodule
