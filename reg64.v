module reg64(out, input_enable, clock, in, reset);

    input[63:0] in;
	input clock, input_enable, reset;

	output[63:0] out;

    register reg1(out[31:0], input_enable, clock, in[31:0], reset);
    register reg2(out[63:32], input_enable, clock, in[63:32], reset);

endmodule
    