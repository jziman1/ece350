module SLL_8(S, A);
    input [31:0] A;
    output [31:0] S;

    wire low;
    assign low = 1'b0;

    assign S[0] =  low;
    assign S[1] =  low;
    assign S[2] =  low;
    assign S[3] =  low;
    assign S[4] =  low;
    assign S[5] =  low;
    assign S[6] =  low;
    assign S[7] =  low;
    assign S[8] =  A[0];
    assign S[9] =  A[1];
    assign S[10] =  A[2];
    assign S[11] =  A[3];
    assign S[12] =  A[4];
    assign S[13] =  A[5];
    assign S[14] =  A[6];
    assign S[15] =  A[7];
    assign S[16] =  A[8];
    assign S[17] =  A[9];
    assign S[18] =  A[10];
    assign S[19] =  A[11];
    assign S[20] =  A[12];
    assign S[21] =  A[13];
    assign S[22] =  A[14];
    assign S[23] =  A[15];
    assign S[24] =  A[16];
    assign S[25] =  A[17];
    assign S[26] =  A[18];
    assign S[27] =  A[19];
    assign S[28] =  A[20];
    assign S[29] =  A[21];
    assign S[30] =  A[22];
    assign S[31] =  A[23];


endmodule