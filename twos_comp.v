module twos_comp(data_in, data_out);

    input[31:0] data_in;
    output[31:0] data_out;

    wire cout;

    CLA_32 cla(data_out, cout, ~data_in, 32'b0, 1'b1);

endmodule