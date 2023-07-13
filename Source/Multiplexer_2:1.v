module mux4 (
input [3:0] mux_in_a, mux_in_b,
input [1:0] mux_sel,
output reg [3:0] mux_out
);

always @ (*)
begin
	if (mux_sel == 0) begin
	mux_out = mux_in_a;
	end
	else begin
	mux_out = mux_in_b;
	end
end

endmodule
