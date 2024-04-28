module SLL_16(S, A);
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
    assign S[8] =  low;
    assign S[9] =  low;
    assign S[10] =  low;
    assign S[11] =  low;
    assign S[12] =  low;
    assign S[13] =  low;
    assign S[14] =  low;
    assign S[15] =  low;
    assign S[16] =  A[0];
    assign S[17] =  A[1];
    assign S[18] =  A[2];
    assign S[19] =  A[3];
    assign S[20] =  A[4];
    assign S[21] =  A[5];
    assign S[22] =  A[6];
    assign S[23] =  A[7];
    assign S[24] =  A[8];
    assign S[25] =  A[9];
    assign S[26] =  A[10];
    assign S[27] =  A[11];
    assign S[28] =  A[12];
    assign S[29] =  A[13];
    assign S[30] =  A[14];
    assign S[31] =  A[15];


endmodule