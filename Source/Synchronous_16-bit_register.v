module reg16 (
input clk ,sclr_n ,clk_ena ,
input [15:0] datain,
output reg[15:0] reg_out
);

always @(posedge clk) begin
 
 case ({clk_ena,sclr_n}) 
  2'b00 : reg_out = reg_out;
  2'b01 : reg_out = reg_out;
  2'b10 : reg_out = 16'b 0000_0000_0000_0000;
  2'b11 : reg_out = datain ;
endcase

end

endmodule
