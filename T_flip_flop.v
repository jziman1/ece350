module T_flip_flop(out, toggle, clock, reset);

    input clock, toggle, reset;
    output out;

    wire high, not_out;
    assign not_out = ~out;
    assign high = 1'b1;

    wire T;

    assign T = (toggle & ~out) | (~toggle & out);

    dffe_ref a_dff(.d(T), .q(out), .clr(reset), .clk(clock), .en(high));

endmodule