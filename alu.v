module alu(data_operandA, data_operandB, ctrl_ALUopcode, ctrl_shiftamt, data_result, isNotEqual, isLessThan, overflow);
        
    //Define Inputs and Outputs
    input [31:0] data_operandA, data_operandB;
    input [4:0] ctrl_ALUopcode, ctrl_shiftamt; 

    output [31:0] data_result;
    output isNotEqual, isLessThan, overflow;

    //Define wires for the outputs of all units
    wire[31:0] addOut, subOut, andOut, orOut, sllOut, sraOut;

    //If subtract create and use NOT B
    wire[31:0] not_data_operandB, real_data_operandB;
    not_32 notB(not_data_operandB, data_operandB);
    assign real_data_operandB = ctrl_ALUopcode[0] ? not_data_operandB : data_operandB;

    //Adder and Subtracter
    wire add_carry_out, sub_carry_out, carry_out;
    CLA_32 adder(addOut, add_carry_out, data_operandA, data_operandB, ctrl_ALUopcode[0]);
    CLA_32 subtracter(subOut, sub_carry_out, data_operandA, not_data_operandB, ctrl_ALUopcode[0]);
    assign carry_out = ctrl_ALUopcode[0] ? sub_carry_out : add_carry_out;

    //Overflow Detection
    wire is_ovf, sign_A_and_B_same;
    xor xor_ovf(is_ovf, carry_out, data_result[31]);
    xnor xnor_A_and_B(sign_A_and_B_same, data_operandA[31], real_data_operandB[31]);
    and ovf_and(overflow, sign_A_and_B_same, is_ovf);

    //NE detection
    or NEand(isNotEqual, subOut[0], subOut[1], subOut[2], subOut[3], subOut[4], subOut[5], subOut[6], subOut[7], subOut[8], subOut[9], subOut[10], subOut[11], subOut[12], subOut[13], subOut[14], subOut[15], subOut[16], subOut[17], subOut[18], subOut[19], subOut[20], subOut[21], subOut[22], subOut[23], subOut[24], subOut[25], subOut[26], subOut[27], subOut[28], subOut[29], subOut[30], subOut[31]);
    
    //Less Than detection (A < B)
    wire sub_is_neg;
    assign sub_is_neg = {subOut[31]};
    xor A_LT_B_with_ovf(isLessThan, sub_is_neg, overflow);

    //And
    and_32 A_and_B(andOut, data_operandA, data_operandB);

    //Or
    or_32 A_or_B(orOut, data_operandA, data_operandB);

    //SLL
    SLL SLL_A(sllOut, data_operandA, ctrl_shiftamt);

    //SRA
    SRA SRA_A(sraOut, data_operandA, ctrl_shiftamt);

    mux_6 mux(data_result, ctrl_ALUopcode[2:0], addOut, subOut, andOut, orOut, sllOut, sraOut);

endmodule