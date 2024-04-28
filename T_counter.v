module T_counter(out, clock, reset);

    input clock, reset;
    output[4:0] out;

    wire high;
    assign high = 1'b1;

    wire tff_out_1, tff_out_2, tff_out_3, tff_out_4, tff_out_5;

    T_flip_flop tff1(tff_out_1, high, clock, reset);
    T_flip_flop tff2(tff_out_2, tff_out_1, clock, reset);
    T_flip_flop tff3(tff_out_3, tff_out_1 & tff_out_2, clock, reset);
    T_flip_flop tff4(tff_out_4, tff_out_1 & tff_out_2 & tff_out_3, clock, reset);
    T_flip_flop tff5(tff_out_5, tff_out_1 & tff_out_2 & tff_out_3 & tff_out_4, clock, reset);

    assign out[0] = tff_out_1;
    assign out[1] = tff_out_2;
    assign out[2] = tff_out_3;
    assign out[3] = tff_out_4;
    assign out[4] = tff_out_5;

endmodule