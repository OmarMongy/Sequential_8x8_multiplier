module seq_mult8x8(
	input [7:0] dataa, datab,
	input start, reset_a, clk,
	output done_flag, seg_a, seg_b, seg_c, seg_d, seg_e, seg_f, seg_g,
	output [15:0] product8x8_out
);

wire clk_ena ,sclr_n  ;
wire [1:0] sel, shift, count;
wire [2:0] state_out;
wire[3:0] aout, bout;
wire [7:0] product;
wire [15:0] shift_out, sum;

mux4 A(
	.mux_in_a(dataa[3:0]),
	.mux_in_b(dataa[7:4]),
	.mux_sel(sel[1]),
	.mux_out(aout)
);

mux4 B(
	.mux_in_a(datab[3:0]),
	.mux_in_b(datab[7:4]),
	.mux_sel(sel[0]),
	.mux_out(bout[3:0])
);

mult4x4 MA(
	.dataa(aout[3:0]),
	.datab(bout[3:0]),
	.product(product[7:0])
);

shifter SA(
	.inp(product[7:0]),
	.shift_cntrl(shift[1:0]),
	.shift_out(shift_out[15:0])
);

adder AA(
	.dataa(shift_out[15:0]),
	.datab(product8x8_out[15:0]),
	.sum(sum[15:0])
);

reg16 RA(
	.clk(clk),
	.sclr_n(sclr_n),
	.clk_ena(clk_ena),
	.datain(sum[15:0]),
	.reg_out(product8x8_out[15:0])
);

counter CA(
	.aclr_n(~start),
	.clk(clk),
	.count_out(count[1:0])
);

mult_control MCA(
	.clk(clk),
	.reset_a(reset_a),
	.start(start),
	.count(count[1:0]),
	.input_sel(sel[1:0]),
	.shift_sel(shift[1:0]),
	.state_out(state_out[2:0]),
	.done(done_flag),
	.clk_ena(clk_ena),
	.sclr_n(sclr_n)
);

seven_segment_cntrl SSCA(
	.inp(state_out[2:0]),
	.seg_a(seg_a),
	.seg_b(seg_b),
	.seg_c(seg_c),
	.seg_d(seg_d),
	.seg_e(seg_e),
	.seg_f(seg_f),
	.seg_g(seg_g)
);

endmodule
