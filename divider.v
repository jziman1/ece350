module divider(data_result, data_exception, data_rdy, data_A, data_B, ctrl_div, clock, remainder);

    //Computing A / B
    // Step-1: First the registers are initialized with corresponding values (Q = Dividend, M = Divisor, A = 0, n = number of bits in dividend)
    // Step-2: Check the sign bit of register A
    // Step-3: If it is 1 shift left content of AQ and perform A = A+M, otherwise shift left AQ and perform A = A-M (means add 2’s complement of M to A and store it to A)
    // Step-4: Again the sign bit of register A
    // Step-5: If sign bit is 1 Q[0] become 0 otherwise Q[0] become 1 (Q[0] means least significant bit of register Q)
    // Step-6: Decrements value of N by 1
    // Step-7: If N is not equal to zero go to Step 2 otherwise go to next step
    // Step-8: If sign bit of A is 1 then perform A = A+M
    // Step-9: Register Q contains quotient and A contains remainder.

    //A is dividend
    //B is divisor

    input[31:0] data_A, data_B;
    input ctrl_div, clock;
    output[31:0] data_result, remainder;
    output data_rdy, data_exception;

    wire sign_out;
    dffe_ref dff1(sign_out, data_A[31] ^ data_B[31], clock, ctrl_div, 1'b0);

    assign data_exception = ~(data_B[0] | data_B[1] | data_B[2] | data_B[3] | data_B[4] | data_B[5] | data_B[6] | data_B[7] | data_B[8] | data_B[9] | data_B[10] | data_B[11] | data_B[12] | data_B[13] | data_B[14] | data_B[15] | data_B[16] | data_B[17] | data_B[18] | data_B[19] | data_B[20] | data_B[21] | data_B[22] | data_B[23] | data_B[24] | data_B[25] | data_B[26] | data_B[27] | data_B[28] | data_B[29] | data_B[30] | data_B[31]);

    wire[31:0] out_M; 
    wire M_enable;
    wire data_reset;
    assign data_reset = 1'b0;

    wire[31:0] choose_M;
    wire[31:0] twos_B;
    twos_comp tB(data_B, twos_B);
    assign choose_M = data_B[31] ? twos_B : data_B;
    register data_M_latch(out_M, ctrl_div, clock, choose_M, data_reset);

    wire[4:0] t_out;
    T_counter tc(t_out, clock, ctrl_div);
    wire counter_done;
    assign counter_done = t_out[4] & t_out[3] & t_out[2] & t_out[1] & t_out[0];
    assign data_rdy = counter_done;

    wire[63:0] out_AQ; 
    wire[63:0] AQ_in;
    wire[63:0] data_A_in_AQ;

    wire[31:0] twos_A, choose_AQ;
    twos_comp tA(data_A, twos_A);
    assign choose_AQ = data_A[31] ? twos_A : data_A;

    wire[31:0] choose_shifted;
    assign choose_shifted = choose_AQ << 1;

    wire dumbc;
    wire[31:0] not_B_out;
    wire[31:0] starting_bit;
    assign starting_bit = (choose_AQ >> 31);
    CLA_32 initialtc(not_B_out, dumbc, ~choose_M, starting_bit, 1'b1);

    assign data_A_in_AQ = {not_B_out, choose_shifted};  
    assign AQ_in = ctrl_div ? data_A_in_AQ : next_AQ;

    reg64 data_AQ_latch(out_AQ, 1'b1, clock, AQ_in, data_reset);

    wire[31:0] out_actual_A;
    assign {out_actual_A} = out_AQ[63:32];

    wire[31:0] out_actual_Q;
    assign {out_actual_Q} = out_AQ[31:0];

    wire[31:0] out_A;
    assign {out_A} = out_AQ[62:31];

    wire[30:0] out_Q;
    assign {out_Q} = out_AQ[30:0];

    wire sign_A;
    assign sign_A = out_AQ[62];

    wire[31:0] addOut, subOut;
    wire ac, sc;
    CLA_32 adder(addOut, ac, out_A, out_M, 1'b0);
    CLA_32 subtracter(subOut, sc, out_A, ~out_M, 1'b1);

    wire[31:0] next_A;
    assign next_A = sign_A ? addOut : subOut;

    wire[63:0] next_AQ;
    assign next_AQ[63] = next_A[31];
    assign next_AQ[62] = next_A[30];
    assign next_AQ[61] = next_A[29];
    assign next_AQ[60] = next_A[28];
    assign next_AQ[59] = next_A[27];
    assign next_AQ[58] = next_A[26];
    assign next_AQ[57] = next_A[25];
    assign next_AQ[56] = next_A[24];
    assign next_AQ[55] = next_A[23];
    assign next_AQ[54] = next_A[22];
    assign next_AQ[53] = next_A[21];
    assign next_AQ[52] = next_A[20];
    assign next_AQ[51] = next_A[19];
    assign next_AQ[50] = next_A[18];
    assign next_AQ[49] = next_A[17];
    assign next_AQ[48] = next_A[16];
    assign next_AQ[47] = next_A[15];
    assign next_AQ[46] = next_A[14];
    assign next_AQ[45] = next_A[13];
    assign next_AQ[44] = next_A[12];
    assign next_AQ[43] = next_A[11];
    assign next_AQ[42] = next_A[10];
    assign next_AQ[41] = next_A[9];
    assign next_AQ[40] = next_A[8];
    assign next_AQ[39] = next_A[7];
    assign next_AQ[38] = next_A[6];
    assign next_AQ[37] = next_A[5];
    assign next_AQ[36] = next_A[4];
    assign next_AQ[35] = next_A[3];
    assign next_AQ[34] = next_A[2];
    assign next_AQ[33] = next_A[1];
    assign next_AQ[32] = next_A[0];
    assign next_AQ[31] = out_Q[30];
    assign next_AQ[30] = out_Q[29];
    assign next_AQ[29] = out_Q[28];
    assign next_AQ[28] = out_Q[27];
    assign next_AQ[27] = out_Q[26];
    assign next_AQ[26] = out_Q[25];
    assign next_AQ[25] = out_Q[24];
    assign next_AQ[24] = out_Q[23];
    assign next_AQ[23] = out_Q[22];
    assign next_AQ[22] = out_Q[21];
    assign next_AQ[21] = out_Q[20];
    assign next_AQ[20] = out_Q[19];
    assign next_AQ[19] = out_Q[18];
    assign next_AQ[18] = out_Q[17];
    assign next_AQ[17] = out_Q[16];
    assign next_AQ[16] = out_Q[15];
    assign next_AQ[15] = out_Q[14];
    assign next_AQ[14] = out_Q[13];
    assign next_AQ[13] = out_Q[12];
    assign next_AQ[12] = out_Q[11];
    assign next_AQ[11] = out_Q[10];
    assign next_AQ[10] = out_Q[9];
    assign next_AQ[9] = out_Q[8];
    assign next_AQ[8] = out_Q[7];
    assign next_AQ[7] = out_Q[6];
    assign next_AQ[6] = out_Q[5];
    assign next_AQ[5] = out_Q[4];
    assign next_AQ[4] = out_Q[3];
    assign next_AQ[3] = out_Q[2];
    assign next_AQ[2] = out_Q[1];
    assign next_AQ[1] = ~sign_A;
    assign next_AQ[0] = 1'b0;

    wire[31:0] final_result, not_final_result;
    wire[31:0] final_final_result;
    wire randomcarry;
    assign final_result = {out_actual_Q[31:1], ~sign_A};
    CLA_32 final_not(not_final_result, randomcarry, 32'b0, ~final_result, 1'b1);

    assign final_final_result = sign_out ? not_final_result : final_result;

    assign data_result = final_final_result;
    
    assign remainder = out_actual_A[31] ? out_actual_A + out_M : out_actual_A;

endmodule