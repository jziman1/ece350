module SRA_8(S, A, f);
    input [31:0] A;
    output [31:0] S;

    input f;

    assign S[0] =  A[8];
    assign S[1] =  A[9];
    assign S[2] =  A[10];
    assign S[3] =  A[11];
    assign S[4] =  A[12];
    assign S[5] =  A[13];
    assign S[6] =  A[14];
    assign S[7] =  A[15];
    assign S[8] =  A[16];
    assign S[9] =  A[17];
    assign S[10] =  A[18];
    assign S[11] =  A[19];
    assign S[12] =  A[20];
    assign S[13] =  A[21];
    assign S[14] =  A[22];
    assign S[15] =  A[23];
    assign S[16] =  A[24];
    assign S[17] =  A[25];
    assign S[18] =  A[26];
    assign S[19] =  A[27];
    assign S[20] =  A[28];
    assign S[21] =  A[29];
    assign S[22] =  A[30];
    assign S[23] =  A[31];
    assign S[24] =  f;
    assign S[25] =  f;
    assign S[26] =  f;
    assign S[27] =  f;
    assign S[28] =  f;
    assign S[29] =  f;
    assign S[30] =  f;
    assign S[31] =  f;

endmodule

