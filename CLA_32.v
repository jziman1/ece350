module CLA_32(S, c32, A, B, cin);
    input [31:0] A, B;
    input cin;
    output [31:0] S;
    output c32;

    wire P0, P1, P2, P3;
    wire G0, G1, G2, G3;

    wire c8, c16, c24;

    CLA_8 CLA1(S[7:0], P0, G0, A[7:0], B[7:0], cin);
    CLA_8 CLA2(S[15:8], P1, G1, A[15:8], B[15:8], c8);
    CLA_8 CLA3(S[23:16], P2, G2, A[23:16], B[23:16], c16);
    CLA_8 CLA4(S[31:24], P3, G3, A[31:24], B[31:24], c24);

    wire c8a1;
    and c1and1(c8a1, P0, cin);
    or  c1or1(c8, c8a1, G0);

    wire c16a2, c16a1;
    and c2and1(c16a1, P1, G0);
    and c2and2(c16a2, P1, P0, cin);
    or  c2or1(c16, c16a2, c16a1, G1);

    wire c24a3, c24a2, c24a1;
    and c3and1(c24a1, P2, G1);
    and c3and2(c24a2, P2, P1, G0);
    and c3and3(c24a3, P2, P1, P0, cin);
    or  c3or1(c24, c24a3, c24a2, c24a1, G2);

    wire c32a4, c32a3, c32a2, c32a1;
    and c4and1(c32a1, P3, G2);
    and c4and2(c32a2, P3, P2, G1);
    and c4and3(c32a3, P3, P2, P1, G0);
    and c4and4(c32a4, P3, P2, P1, P0, cin);
    or  c4or1(c32, c32a4, c32a3, c32a2, c32a1, G3);

endmodule