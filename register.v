module register(out, input_enable, clock, in, reset);

    input[31:0] in;
	input clock, input_enable, reset;

	output[31:0] out;

    genvar i;
    generate
        for (i = 0; i < 32; i=i+1) begin: loop1
            dffe_ref a_dff(.d(in[i]), .q(out[i]), .clr(reset), .clk(clock), .en(input_enable));
        end
    endgenerate

endmodule
    