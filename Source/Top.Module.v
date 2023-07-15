module seq_mult8x8(
    input [7:0] dataa, datab,
    input start, reset_a, clk,
    output done,
    output seg_a, seg_b, seg_c, seg_d, seg_e, seg_f, seg_g,
    output [15:0] product8x8_out
);

    wire clk_ena, sclr_n;
    wire [1:0] sel, shift, count;
    wire [2:0] state_out;
    wire [3:0] aout, bout;
    wire [7:0] product;
    wire [15:0] shift_out, sum;

    mux4 U0(
        .mux_in_a(dataa[3:0]),
        .mux_in_b(dataa[7:4]),
        .mux_sel(sel[1]),
        .mux_out(aout)
    );

    mux4 U1(
        .mux_in_a(datab),
        .mux_in_b(datab),
        .mux_sel(sel),
        .mux_out(bout)
    );

    mult_4x4 U2(
        .dataa(aout),
        .datab(bout),
        .product(product)
    );

    shifter U3(
        .inp(product),
        .shift_cntrl(shift),
        .shift_out(shift_out)
    );

    adder U4(
        .dataa(shift_out),
        .datab(product8x8_out),
        .sum(sum)
    );

    reg16 U5(
        .clk(clk),
        .sclr_n(sclr_n),
        .clk_ena(clk_ena),
        .datain(sum),
        .reg_out(product8x8_out)
    );

    counter U6(
        .aclr_n(~start),
        .clk(clk),
        .count(count)
    );

    mult_control U7(
        .clk(clk),
        .reset_a(reset_a),
        .start(start),
        .count(count),
        .input_sel(sel),
        .shift_sel(shift),
        .state_out(state_out),
        .done(done),
        .clk_ena(clk_ena),
        .sclr_n(sclr_n)
    );

    seven_segment_cntrl U8(
        .inp(state_out),
        .seg_a(seg_a),
        .seg_b(seg_b),
        .seg_c(seg_c),
        .seg_d(seg_d),
        .seg_e(seg_e),
        .seg_f(seg_f),
        .seg_g(seg_g)
    );

endmodule
