module half_adder(S, Cout, A, B);
    input A, B;
    output Cout, S;

    xor x(S, A, B);
    and a(Cout, A, B);
endmodule