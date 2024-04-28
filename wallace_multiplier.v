module wallace_multiplier(data_result, ovf, data_rdy, data_A, data_B, ctrl_mult, clock, data_result_cont);
    input[31:0] data_A, data_B;
    input ctrl_mult, clock;
    output[31:0] data_result, data_result_cont;
    output ovf;
    output data_rdy;

    wire[31:0] out_A, out_B;

    wire[4:0] t_out;
    T_counter tc(t_out, clock, ctrl_mult);
    wire counter_done;
    assign counter_done = t_out[1] & t_out[0];
    assign data_rdy = counter_done;

    wire low;
    assign low = 1'b0;

    register data_A_latch(out_A, ctrl_mult, clock, data_A, low);
    register data_B_latch(out_B, ctrl_mult, clock, data_B, low);

    //assign data_result[31] = 27'b0;

    assign data_result[0] = out_A[0] & out_B[0];

    wire c1_1;

    half_adder ha11(data_result[1], c1_1, (out_A[1] & out_B[0]), (out_A[0] & out_B[1])); //i = 1, j = 1

    wire s2_1, c2_2, c2_1;

    full_adder fa2_1(s2_1, c2_1, (out_A[2] & out_B[0]), (out_A[1] & out_B[1]), c1_1);
    half_adder ha2_2(data_result[2], c2_2, s2_1, (out_A[0] & out_B[2]));

    wire s3_2, s3_1, c3_3, c3_2, c3_1;

    full_adder fa3_1(s3_1, c3_1, (out_A[3] & out_B[0]), (out_A[2] & out_B[1]), c2_1);
    full_adder fa3_2(s3_2, c3_2, s3_1, (out_A[1] & out_B[2]), c2_2);
    half_adder ha3_3(data_result[3], c3_3, s3_2, (out_A[0] & out_B[3]));

    wire s4_3, s4_2, s4_1, c4_4, c4_3, c4_2, c4_1;

    full_adder fa4_1(s4_1, c4_1, (out_A[4] & out_B[0]), (out_A[3] & out_B[1]), c3_1);
    full_adder fa4_2(s4_2, c4_2, s4_1, (out_A[2] & out_B[2]), c3_2);
    full_adder fa4_3(s4_3, c4_3, s4_2, (out_A[1] & out_B[3]), c3_3);
    half_adder ha4_4(data_result[4], c4_4, s4_3, (out_A[0] & out_B[4]));

    wire s5_4, s5_3, s5_2, s5_1, c5_5, c5_4, c5_3, c5_2, c5_1;

    full_adder fa5_1(s5_1, c5_1, (out_A[5] & out_B[0]), (out_A[4] & out_B[1]), c4_1);
    full_adder fa5_2(s5_2, c5_2, s5_1, (out_A[3] & out_B[2]), c4_2);
    full_adder fa5_3(s5_3, c5_3, s5_2, (out_A[2] & out_B[3]), c4_3);
    full_adder fa5_4(s5_4, c5_4, s5_3, (out_A[1] & out_B[4]), c4_4);
    half_adder ha5_5(data_result[5], c5_5, s5_4, (out_A[0] & out_B[5]));

    wire s6_5, s6_4, s6_3, s6_2, s6_1, c6_6, c6_5, c6_4, c6_3, c6_2, c6_1;

    full_adder fa6_1(s6_1, c6_1, (out_A[6] & out_B[0]), (out_A[5] & out_B[1]), c5_1);
    full_adder fa6_2(s6_2, c6_2, s6_1, (out_A[4] & out_B[2]), c5_2);
    full_adder fa6_3(s6_3, c6_3, s6_2, (out_A[3] & out_B[3]), c5_3);
    full_adder fa6_4(s6_4, c6_4, s6_3, (out_A[2] & out_B[4]), c5_4);
    full_adder fa6_5(s6_5, c6_5, s6_4, (out_A[1] & out_B[5]), c5_5);
    half_adder ha6_6(data_result[6], c6_6, s6_5, (out_A[0] & out_B[6]));

    wire s7_6, s7_5, s7_4, s7_3, s7_2, s7_1, c7_7, c7_6, c7_5, c7_4, c7_3, c7_2, c7_1;        

    full_adder fa7_1(s7_1, c7_1, (out_A[7] & out_B[0]), (out_A[6] & out_B[1]), c6_1);
    full_adder fa7_2(s7_2, c7_2, s7_1, (out_A[5] & out_B[2]), c6_2);
    full_adder fa7_3(s7_3, c7_3, s7_2, (out_A[4] & out_B[3]), c6_3);
    full_adder fa7_4(s7_4, c7_4, s7_3, (out_A[3] & out_B[4]), c6_4);
    full_adder fa7_5(s7_5, c7_5, s7_4, (out_A[2] & out_B[5]), c6_5);
    full_adder fa7_6(s7_6, c7_6, s7_5, (out_A[1] & out_B[6]), c6_6);
    half_adder ha7_7(data_result[7], c7_7, s7_6, (out_A[0] & out_B[7]));

    wire s8_7, s8_6, s8_5, s8_4, s8_3, s8_2, s8_1, c8_8, c8_7, c8_6, c8_5, c8_4, c8_3, c8_2, c8_1;

    full_adder fa8_1(s8_1, c8_1, (out_A[8] & out_B[0]), (out_A[7] & out_B[1]), c7_1);
    full_adder fa8_2(s8_2, c8_2, s8_1, (out_A[6] & out_B[2]), c7_2);
    full_adder fa8_3(s8_3, c8_3, s8_2, (out_A[5] & out_B[3]), c7_3);
    full_adder fa8_4(s8_4, c8_4, s8_3, (out_A[4] & out_B[4]), c7_4);
    full_adder fa8_5(s8_5, c8_5, s8_4, (out_A[3] & out_B[5]), c7_5);
    full_adder fa8_6(s8_6, c8_6, s8_5, (out_A[2] & out_B[6]), c7_6);
    full_adder fa8_7(s8_7, c8_7, s8_6, (out_A[1] & out_B[7]), c7_7);
    half_adder ha8_8(data_result[8], c8_8, s8_7, (out_A[0] & out_B[8]));

    wire s9_8, s9_7, s9_6, s9_5, s9_4, s9_3, s9_2, s9_1, c9_9, c9_8, c9_7, c9_6, c9_5, c9_4, c9_3, c9_2, c9_1;

    full_adder fa9_1(s9_1, c9_1, (out_A[9] & out_B[0]), (out_A[8] & out_B[1]), c8_1);
    full_adder fa9_2(s9_2, c9_2, s9_1, (out_A[7] & out_B[2]), c8_2);
    full_adder fa9_3(s9_3, c9_3, s9_2, (out_A[6] & out_B[3]), c8_3);
    full_adder fa9_4(s9_4, c9_4, s9_3, (out_A[5] & out_B[4]), c8_4);
    full_adder fa9_5(s9_5, c9_5, s9_4, (out_A[4] & out_B[5]), c8_5);
    full_adder fa9_6(s9_6, c9_6, s9_5, (out_A[3] & out_B[6]), c8_6);
    full_adder fa9_7(s9_7, c9_7, s9_6, (out_A[2] & out_B[7]), c8_7);
    full_adder fa9_8(s9_8, c9_8, s9_7, (out_A[1] & out_B[8]), c8_8);
    half_adder ha9_9(data_result[9], c9_9, s9_8, (out_A[0] & out_B[9]));

    wire s10_9, s10_8, s10_7, s10_6, s10_5, s10_4, s10_3, s10_2, s10_1, c10_10, c10_9, c10_8, c10_7, c10_6, c10_5, c10_4, c10_3, c10_2, c10_1;

    full_adder fa10_1(s10_1, c10_1, (out_A[10] & out_B[0]), (out_A[9] & out_B[1]), c9_1);     
    full_adder fa10_2(s10_2, c10_2, s10_1, (out_A[8] & out_B[2]), c9_2);
    full_adder fa10_3(s10_3, c10_3, s10_2, (out_A[7] & out_B[3]), c9_3);
    full_adder fa10_4(s10_4, c10_4, s10_3, (out_A[6] & out_B[4]), c9_4);
    full_adder fa10_5(s10_5, c10_5, s10_4, (out_A[5] & out_B[5]), c9_5);
    full_adder fa10_6(s10_6, c10_6, s10_5, (out_A[4] & out_B[6]), c9_6);
    full_adder fa10_7(s10_7, c10_7, s10_6, (out_A[3] & out_B[7]), c9_7);
    full_adder fa10_8(s10_8, c10_8, s10_7, (out_A[2] & out_B[8]), c9_8);
    full_adder fa10_9(s10_9, c10_9, s10_8, (out_A[1] & out_B[9]), c9_9);
    half_adder ha10_10(data_result[10], c10_10, s10_9, (out_A[0] & out_B[10]));

    wire s11_10, s11_9, s11_8, s11_7, s11_6, s11_5, s11_4, s11_3, s11_2, s11_1, c11_11, c11_10, c11_9, c11_8, c11_7, c11_6, c11_5, c11_4, c11_3, c11_2, c11_1;

    full_adder fa11_1(s11_1, c11_1, (out_A[11] & out_B[0]), (out_A[10] & out_B[1]), c10_1);   
    full_adder fa11_2(s11_2, c11_2, s11_1, (out_A[9] & out_B[2]), c10_2);
    full_adder fa11_3(s11_3, c11_3, s11_2, (out_A[8] & out_B[3]), c10_3);
    full_adder fa11_4(s11_4, c11_4, s11_3, (out_A[7] & out_B[4]), c10_4);
    full_adder fa11_5(s11_5, c11_5, s11_4, (out_A[6] & out_B[5]), c10_5);
    full_adder fa11_6(s11_6, c11_6, s11_5, (out_A[5] & out_B[6]), c10_6);
    full_adder fa11_7(s11_7, c11_7, s11_6, (out_A[4] & out_B[7]), c10_7);
    full_adder fa11_8(s11_8, c11_8, s11_7, (out_A[3] & out_B[8]), c10_8);
    full_adder fa11_9(s11_9, c11_9, s11_8, (out_A[2] & out_B[9]), c10_9);
    full_adder fa11_10(s11_10, c11_10, s11_9, (out_A[1] & out_B[10]), c10_10);
    half_adder ha11_11(data_result[11], c11_11, s11_10, (out_A[0] & out_B[11]));

    wire s12_11, s12_10, s12_9, s12_8, s12_7, s12_6, s12_5, s12_4, s12_3, s12_2, s12_1, c12_12, c12_11, c12_10, c12_9, c12_8, c12_7, c12_6, c12_5, c12_4, c12_3, c12_2, c12_1;

    full_adder fa12_1(s12_1, c12_1, (out_A[12] & out_B[0]), (out_A[11] & out_B[1]), c11_1);   
    full_adder fa12_2(s12_2, c12_2, s12_1, (out_A[10] & out_B[2]), c11_2);
    full_adder fa12_3(s12_3, c12_3, s12_2, (out_A[9] & out_B[3]), c11_3);
    full_adder fa12_4(s12_4, c12_4, s12_3, (out_A[8] & out_B[4]), c11_4);
    full_adder fa12_5(s12_5, c12_5, s12_4, (out_A[7] & out_B[5]), c11_5);
    full_adder fa12_6(s12_6, c12_6, s12_5, (out_A[6] & out_B[6]), c11_6);
    full_adder fa12_7(s12_7, c12_7, s12_6, (out_A[5] & out_B[7]), c11_7);
    full_adder fa12_8(s12_8, c12_8, s12_7, (out_A[4] & out_B[8]), c11_8);
    full_adder fa12_9(s12_9, c12_9, s12_8, (out_A[3] & out_B[9]), c11_9);
    full_adder fa12_10(s12_10, c12_10, s12_9, (out_A[2] & out_B[10]), c11_10);
    full_adder fa12_11(s12_11, c12_11, s12_10, (out_A[1] & out_B[11]), c11_11);
    half_adder ha12_12(data_result[12], c12_12, s12_11, (out_A[0] & out_B[12]));

    wire s13_12, s13_11, s13_10, s13_9, s13_8, s13_7, s13_6, s13_5, s13_4, s13_3, s13_2, s13_1, c13_13, c13_12, c13_11, c13_10, c13_9, c13_8, c13_7, c13_6, c13_5, c13_4, c13_3, c13_2, c13_1;

    full_adder fa13_1(s13_1, c13_1, (out_A[13] & out_B[0]), (out_A[12] & out_B[1]), c12_1);   
    full_adder fa13_2(s13_2, c13_2, s13_1, (out_A[11] & out_B[2]), c12_2);
    full_adder fa13_3(s13_3, c13_3, s13_2, (out_A[10] & out_B[3]), c12_3);
    full_adder fa13_4(s13_4, c13_4, s13_3, (out_A[9] & out_B[4]), c12_4);
    full_adder fa13_5(s13_5, c13_5, s13_4, (out_A[8] & out_B[5]), c12_5);
    full_adder fa13_6(s13_6, c13_6, s13_5, (out_A[7] & out_B[6]), c12_6);
    full_adder fa13_7(s13_7, c13_7, s13_6, (out_A[6] & out_B[7]), c12_7);
    full_adder fa13_8(s13_8, c13_8, s13_7, (out_A[5] & out_B[8]), c12_8);
    full_adder fa13_9(s13_9, c13_9, s13_8, (out_A[4] & out_B[9]), c12_9);
    full_adder fa13_10(s13_10, c13_10, s13_9, (out_A[3] & out_B[10]), c12_10);
    full_adder fa13_11(s13_11, c13_11, s13_10, (out_A[2] & out_B[11]), c12_11);
    full_adder fa13_12(s13_12, c13_12, s13_11, (out_A[1] & out_B[12]), c12_12);
    half_adder ha13_13(data_result[13], c13_13, s13_12, (out_A[0] & out_B[13]));

    wire s14_13, s14_12, s14_11, s14_10, s14_9, s14_8, s14_7, s14_6, s14_5, s14_4, s14_3, s14_2, s14_1, c14_14, c14_13, c14_12, c14_11, c14_10, c14_9, c14_8, c14_7, c14_6, c14_5, c14_4, c14_3, c14_2, c14_1;

    full_adder fa14_1(s14_1, c14_1, (out_A[14] & out_B[0]), (out_A[13] & out_B[1]), c13_1);   
    full_adder fa14_2(s14_2, c14_2, s14_1, (out_A[12] & out_B[2]), c13_2);
    full_adder fa14_3(s14_3, c14_3, s14_2, (out_A[11] & out_B[3]), c13_3);
    full_adder fa14_4(s14_4, c14_4, s14_3, (out_A[10] & out_B[4]), c13_4);
    full_adder fa14_5(s14_5, c14_5, s14_4, (out_A[9] & out_B[5]), c13_5);
    full_adder fa14_6(s14_6, c14_6, s14_5, (out_A[8] & out_B[6]), c13_6);
    full_adder fa14_7(s14_7, c14_7, s14_6, (out_A[7] & out_B[7]), c13_7);
    full_adder fa14_8(s14_8, c14_8, s14_7, (out_A[6] & out_B[8]), c13_8);
    full_adder fa14_9(s14_9, c14_9, s14_8, (out_A[5] & out_B[9]), c13_9);
    full_adder fa14_10(s14_10, c14_10, s14_9, (out_A[4] & out_B[10]), c13_10);
    full_adder fa14_11(s14_11, c14_11, s14_10, (out_A[3] & out_B[11]), c13_11);
    full_adder fa14_12(s14_12, c14_12, s14_11, (out_A[2] & out_B[12]), c13_12);
    full_adder fa14_13(s14_13, c14_13, s14_12, (out_A[1] & out_B[13]), c13_13);
    half_adder ha14_14(data_result[14], c14_14, s14_13, (out_A[0] & out_B[14]));

    wire s15_14, s15_13, s15_12, s15_11, s15_10, s15_9, s15_8, s15_7, s15_6, s15_5, s15_4, s15_3, s15_2, s15_1, c15_15, c15_14, c15_13, c15_12, c15_11, c15_10, c15_9, c15_8, c15_7, c15_6, c15_5, c15_4, c15_3, c15_2, c15_1;

    full_adder fa15_1(s15_1, c15_1, (out_A[15] & out_B[0]), (out_A[14] & out_B[1]), c14_1);   
    full_adder fa15_2(s15_2, c15_2, s15_1, (out_A[13] & out_B[2]), c14_2);
    full_adder fa15_3(s15_3, c15_3, s15_2, (out_A[12] & out_B[3]), c14_3);
    full_adder fa15_4(s15_4, c15_4, s15_3, (out_A[11] & out_B[4]), c14_4);
    full_adder fa15_5(s15_5, c15_5, s15_4, (out_A[10] & out_B[5]), c14_5);
    full_adder fa15_6(s15_6, c15_6, s15_5, (out_A[9] & out_B[6]), c14_6);
    full_adder fa15_7(s15_7, c15_7, s15_6, (out_A[8] & out_B[7]), c14_7);
    full_adder fa15_8(s15_8, c15_8, s15_7, (out_A[7] & out_B[8]), c14_8);
    full_adder fa15_9(s15_9, c15_9, s15_8, (out_A[6] & out_B[9]), c14_9);
    full_adder fa15_10(s15_10, c15_10, s15_9, (out_A[5] & out_B[10]), c14_10);
    full_adder fa15_11(s15_11, c15_11, s15_10, (out_A[4] & out_B[11]), c14_11);
    full_adder fa15_12(s15_12, c15_12, s15_11, (out_A[3] & out_B[12]), c14_12);
    full_adder fa15_13(s15_13, c15_13, s15_12, (out_A[2] & out_B[13]), c14_13);
    full_adder fa15_14(s15_14, c15_14, s15_13, (out_A[1] & out_B[14]), c14_14);
    half_adder ha15_15(data_result[15], c15_15, s15_14, (out_A[0] & out_B[15]));

    wire s16_15, s16_14, s16_13, s16_12, s16_11, s16_10, s16_9, s16_8, s16_7, s16_6, s16_5, s16_4, s16_3, s16_2, s16_1, c16_16, c16_15, c16_14, c16_13, c16_12, c16_11, c16_10, c16_9, c16_8, c16_7, c16_6, c16_5, c16_4, c16_3, c16_2, c16_1;

    full_adder fa16_1(s16_1, c16_1, (out_A[16] & out_B[0]), (out_A[15] & out_B[1]), c15_1);   
    full_adder fa16_2(s16_2, c16_2, s16_1, (out_A[14] & out_B[2]), c15_2);
    full_adder fa16_3(s16_3, c16_3, s16_2, (out_A[13] & out_B[3]), c15_3);
    full_adder fa16_4(s16_4, c16_4, s16_3, (out_A[12] & out_B[4]), c15_4);
    full_adder fa16_5(s16_5, c16_5, s16_4, (out_A[11] & out_B[5]), c15_5);
    full_adder fa16_6(s16_6, c16_6, s16_5, (out_A[10] & out_B[6]), c15_6);
    full_adder fa16_7(s16_7, c16_7, s16_6, (out_A[9] & out_B[7]), c15_7);
    full_adder fa16_8(s16_8, c16_8, s16_7, (out_A[8] & out_B[8]), c15_8);
    full_adder fa16_9(s16_9, c16_9, s16_8, (out_A[7] & out_B[9]), c15_9);
    full_adder fa16_10(s16_10, c16_10, s16_9, (out_A[6] & out_B[10]), c15_10);
    full_adder fa16_11(s16_11, c16_11, s16_10, (out_A[5] & out_B[11]), c15_11);
    full_adder fa16_12(s16_12, c16_12, s16_11, (out_A[4] & out_B[12]), c15_12);
    full_adder fa16_13(s16_13, c16_13, s16_12, (out_A[3] & out_B[13]), c15_13);
    full_adder fa16_14(s16_14, c16_14, s16_13, (out_A[2] & out_B[14]), c15_14);
    full_adder fa16_15(s16_15, c16_15, s16_14, (out_A[1] & out_B[15]), c15_15);
    half_adder ha16_16(data_result[16], c16_16, s16_15, (out_A[0] & out_B[16]));

    wire s17_16, s17_15, s17_14, s17_13, s17_12, s17_11, s17_10, s17_9, s17_8, s17_7, s17_6, s17_5, s17_4, s17_3, s17_2, s17_1, c17_17, c17_16, c17_15, c17_14, c17_13, c17_12, c17_11, c17_10, c17_9, c17_8, c17_7, c17_6, c17_5, c17_4, c17_3, c17_2, c17_1;

    full_adder fa17_1(s17_1, c17_1, (out_A[17] & out_B[0]), (out_A[16] & out_B[1]), c16_1);   
    full_adder fa17_2(s17_2, c17_2, s17_1, (out_A[15] & out_B[2]), c16_2);
    full_adder fa17_3(s17_3, c17_3, s17_2, (out_A[14] & out_B[3]), c16_3);
    full_adder fa17_4(s17_4, c17_4, s17_3, (out_A[13] & out_B[4]), c16_4);
    full_adder fa17_5(s17_5, c17_5, s17_4, (out_A[12] & out_B[5]), c16_5);
    full_adder fa17_6(s17_6, c17_6, s17_5, (out_A[11] & out_B[6]), c16_6);
    full_adder fa17_7(s17_7, c17_7, s17_6, (out_A[10] & out_B[7]), c16_7);
    full_adder fa17_8(s17_8, c17_8, s17_7, (out_A[9] & out_B[8]), c16_8);
    full_adder fa17_9(s17_9, c17_9, s17_8, (out_A[8] & out_B[9]), c16_9);
    full_adder fa17_10(s17_10, c17_10, s17_9, (out_A[7] & out_B[10]), c16_10);
    full_adder fa17_11(s17_11, c17_11, s17_10, (out_A[6] & out_B[11]), c16_11);
    full_adder fa17_12(s17_12, c17_12, s17_11, (out_A[5] & out_B[12]), c16_12);
    full_adder fa17_13(s17_13, c17_13, s17_12, (out_A[4] & out_B[13]), c16_13);
    full_adder fa17_14(s17_14, c17_14, s17_13, (out_A[3] & out_B[14]), c16_14);
    full_adder fa17_15(s17_15, c17_15, s17_14, (out_A[2] & out_B[15]), c16_15);
    full_adder fa17_16(s17_16, c17_16, s17_15, (out_A[1] & out_B[16]), c16_16);
    half_adder ha17_17(data_result[17], c17_17, s17_16, (out_A[0] & out_B[17]));

    wire s18_17, s18_16, s18_15, s18_14, s18_13, s18_12, s18_11, s18_10, s18_9, s18_8, s18_7, s18_6, s18_5, s18_4, s18_3, s18_2, s18_1, c18_18, c18_17, c18_16, c18_15, c18_14, c18_13, c18_12, c18_11, c18_10, c18_9, c18_8, c18_7, c18_6, c18_5, c18_4, c18_3, c18_2, c18_1;    

    full_adder fa18_1(s18_1, c18_1, (out_A[18] & out_B[0]), (out_A[17] & out_B[1]), c17_1);   
    full_adder fa18_2(s18_2, c18_2, s18_1, (out_A[16] & out_B[2]), c17_2);
    full_adder fa18_3(s18_3, c18_3, s18_2, (out_A[15] & out_B[3]), c17_3);
    full_adder fa18_4(s18_4, c18_4, s18_3, (out_A[14] & out_B[4]), c17_4);
    full_adder fa18_5(s18_5, c18_5, s18_4, (out_A[13] & out_B[5]), c17_5);
    full_adder fa18_6(s18_6, c18_6, s18_5, (out_A[12] & out_B[6]), c17_6);
    full_adder fa18_7(s18_7, c18_7, s18_6, (out_A[11] & out_B[7]), c17_7);
    full_adder fa18_8(s18_8, c18_8, s18_7, (out_A[10] & out_B[8]), c17_8);
    full_adder fa18_9(s18_9, c18_9, s18_8, (out_A[9] & out_B[9]), c17_9);
    full_adder fa18_10(s18_10, c18_10, s18_9, (out_A[8] & out_B[10]), c17_10);
    full_adder fa18_11(s18_11, c18_11, s18_10, (out_A[7] & out_B[11]), c17_11);
    full_adder fa18_12(s18_12, c18_12, s18_11, (out_A[6] & out_B[12]), c17_12);
    full_adder fa18_13(s18_13, c18_13, s18_12, (out_A[5] & out_B[13]), c17_13);
    full_adder fa18_14(s18_14, c18_14, s18_13, (out_A[4] & out_B[14]), c17_14);
    full_adder fa18_15(s18_15, c18_15, s18_14, (out_A[3] & out_B[15]), c17_15);
    full_adder fa18_16(s18_16, c18_16, s18_15, (out_A[2] & out_B[16]), c17_16);
    full_adder fa18_17(s18_17, c18_17, s18_16, (out_A[1] & out_B[17]), c17_17);
    half_adder ha18_18(data_result[18], c18_18, s18_17, (out_A[0] & out_B[18]));

    wire s19_18, s19_17, s19_16, s19_15, s19_14, s19_13, s19_12, s19_11, s19_10, s19_9, s19_8, s19_7, s19_6, s19_5, s19_4, s19_3, s19_2, s19_1, c19_19, c19_18, c19_17, c19_16, c19_15, c19_14, c19_13, c19_12, c19_11, c19_10, c19_9, c19_8, c19_7, c19_6, c19_5, c19_4, c19_3, c19_2, c19_1;

    full_adder fa19_1(s19_1, c19_1, (out_A[19] & out_B[0]), (out_A[18] & out_B[1]), c18_1);   
    full_adder fa19_2(s19_2, c19_2, s19_1, (out_A[17] & out_B[2]), c18_2);
    full_adder fa19_3(s19_3, c19_3, s19_2, (out_A[16] & out_B[3]), c18_3);
    full_adder fa19_4(s19_4, c19_4, s19_3, (out_A[15] & out_B[4]), c18_4);
    full_adder fa19_5(s19_5, c19_5, s19_4, (out_A[14] & out_B[5]), c18_5);
    full_adder fa19_6(s19_6, c19_6, s19_5, (out_A[13] & out_B[6]), c18_6);
    full_adder fa19_7(s19_7, c19_7, s19_6, (out_A[12] & out_B[7]), c18_7);
    full_adder fa19_8(s19_8, c19_8, s19_7, (out_A[11] & out_B[8]), c18_8);
    full_adder fa19_9(s19_9, c19_9, s19_8, (out_A[10] & out_B[9]), c18_9);
    full_adder fa19_10(s19_10, c19_10, s19_9, (out_A[9] & out_B[10]), c18_10);
    full_adder fa19_11(s19_11, c19_11, s19_10, (out_A[8] & out_B[11]), c18_11);
    full_adder fa19_12(s19_12, c19_12, s19_11, (out_A[7] & out_B[12]), c18_12);
    full_adder fa19_13(s19_13, c19_13, s19_12, (out_A[6] & out_B[13]), c18_13);
    full_adder fa19_14(s19_14, c19_14, s19_13, (out_A[5] & out_B[14]), c18_14);
    full_adder fa19_15(s19_15, c19_15, s19_14, (out_A[4] & out_B[15]), c18_15);
    full_adder fa19_16(s19_16, c19_16, s19_15, (out_A[3] & out_B[16]), c18_16);
    full_adder fa19_17(s19_17, c19_17, s19_16, (out_A[2] & out_B[17]), c18_17);
    full_adder fa19_18(s19_18, c19_18, s19_17, (out_A[1] & out_B[18]), c18_18);
    half_adder ha19_19(data_result[19], c19_19, s19_18, (out_A[0] & out_B[19]));

    wire s20_19, s20_18, s20_17, s20_16, s20_15, s20_14, s20_13, s20_12, s20_11, s20_10, s20_9, s20_8, s20_7, s20_6, s20_5, s20_4, s20_3, s20_2, s20_1, c20_20, c20_19, c20_18, c20_17, c20_16, c20_15, c20_14, c20_13, c20_12, c20_11, c20_10, c20_9, c20_8, c20_7, c20_6, c20_5, c20_4, c20_3, c20_2, c20_1;

    full_adder fa20_1(s20_1, c20_1, (out_A[20] & out_B[0]), (out_A[19] & out_B[1]), c19_1);   
    full_adder fa20_2(s20_2, c20_2, s20_1, (out_A[18] & out_B[2]), c19_2);
    full_adder fa20_3(s20_3, c20_3, s20_2, (out_A[17] & out_B[3]), c19_3);
    full_adder fa20_4(s20_4, c20_4, s20_3, (out_A[16] & out_B[4]), c19_4);
    full_adder fa20_5(s20_5, c20_5, s20_4, (out_A[15] & out_B[5]), c19_5);
    full_adder fa20_6(s20_6, c20_6, s20_5, (out_A[14] & out_B[6]), c19_6);
    full_adder fa20_7(s20_7, c20_7, s20_6, (out_A[13] & out_B[7]), c19_7);
    full_adder fa20_8(s20_8, c20_8, s20_7, (out_A[12] & out_B[8]), c19_8);
    full_adder fa20_9(s20_9, c20_9, s20_8, (out_A[11] & out_B[9]), c19_9);
    full_adder fa20_10(s20_10, c20_10, s20_9, (out_A[10] & out_B[10]), c19_10);
    full_adder fa20_11(s20_11, c20_11, s20_10, (out_A[9] & out_B[11]), c19_11);
    full_adder fa20_12(s20_12, c20_12, s20_11, (out_A[8] & out_B[12]), c19_12);
    full_adder fa20_13(s20_13, c20_13, s20_12, (out_A[7] & out_B[13]), c19_13);
    full_adder fa20_14(s20_14, c20_14, s20_13, (out_A[6] & out_B[14]), c19_14);
    full_adder fa20_15(s20_15, c20_15, s20_14, (out_A[5] & out_B[15]), c19_15);
    full_adder fa20_16(s20_16, c20_16, s20_15, (out_A[4] & out_B[16]), c19_16);
    full_adder fa20_17(s20_17, c20_17, s20_16, (out_A[3] & out_B[17]), c19_17);
    full_adder fa20_18(s20_18, c20_18, s20_17, (out_A[2] & out_B[18]), c19_18);
    full_adder fa20_19(s20_19, c20_19, s20_18, (out_A[1] & out_B[19]), c19_19);
    half_adder ha20_20(data_result[20], c20_20, s20_19, (out_A[0] & out_B[20]));

    wire s21_20, s21_19, s21_18, s21_17, s21_16, s21_15, s21_14, s21_13, s21_12, s21_11, s21_10, s21_9, s21_8, s21_7, s21_6, s21_5, s21_4, s21_3, s21_2, s21_1, c21_21, c21_20, c21_19, c21_18, c21_17, c21_16, c21_15, c21_14, c21_13, c21_12, c21_11, c21_10, c21_9, c21_8, c21_7, c21_6, c21_5, c21_4, c21_3, c21_2, c21_1;

    full_adder fa21_1(s21_1, c21_1, (out_A[21] & out_B[0]), (out_A[20] & out_B[1]), c20_1);   
    full_adder fa21_2(s21_2, c21_2, s21_1, (out_A[19] & out_B[2]), c20_2);
    full_adder fa21_3(s21_3, c21_3, s21_2, (out_A[18] & out_B[3]), c20_3);
    full_adder fa21_4(s21_4, c21_4, s21_3, (out_A[17] & out_B[4]), c20_4);
    full_adder fa21_5(s21_5, c21_5, s21_4, (out_A[16] & out_B[5]), c20_5);
    full_adder fa21_6(s21_6, c21_6, s21_5, (out_A[15] & out_B[6]), c20_6);
    full_adder fa21_7(s21_7, c21_7, s21_6, (out_A[14] & out_B[7]), c20_7);
    full_adder fa21_8(s21_8, c21_8, s21_7, (out_A[13] & out_B[8]), c20_8);
    full_adder fa21_9(s21_9, c21_9, s21_8, (out_A[12] & out_B[9]), c20_9);
    full_adder fa21_10(s21_10, c21_10, s21_9, (out_A[11] & out_B[10]), c20_10);
    full_adder fa21_11(s21_11, c21_11, s21_10, (out_A[10] & out_B[11]), c20_11);
    full_adder fa21_12(s21_12, c21_12, s21_11, (out_A[9] & out_B[12]), c20_12);
    full_adder fa21_13(s21_13, c21_13, s21_12, (out_A[8] & out_B[13]), c20_13);
    full_adder fa21_14(s21_14, c21_14, s21_13, (out_A[7] & out_B[14]), c20_14);
    full_adder fa21_15(s21_15, c21_15, s21_14, (out_A[6] & out_B[15]), c20_15);
    full_adder fa21_16(s21_16, c21_16, s21_15, (out_A[5] & out_B[16]), c20_16);
    full_adder fa21_17(s21_17, c21_17, s21_16, (out_A[4] & out_B[17]), c20_17);
    full_adder fa21_18(s21_18, c21_18, s21_17, (out_A[3] & out_B[18]), c20_18);
    full_adder fa21_19(s21_19, c21_19, s21_18, (out_A[2] & out_B[19]), c20_19);
    full_adder fa21_20(s21_20, c21_20, s21_19, (out_A[1] & out_B[20]), c20_20);
    half_adder ha21_21(data_result[21], c21_21, s21_20, (out_A[0] & out_B[21]));

    wire s22_21, s22_20, s22_19, s22_18, s22_17, s22_16, s22_15, s22_14, s22_13, s22_12, s22_11, s22_10, s22_9, s22_8, s22_7, s22_6, s22_5, s22_4, s22_3, s22_2, s22_1, c22_22, c22_21, c22_20, c22_19, c22_18, c22_17, c22_16, c22_15, c22_14, c22_13, c22_12, c22_11, c22_10, c22_9, c22_8, c22_7, c22_6, c22_5, c22_4, c22_3, c22_2, c22_1;

    full_adder fa22_1(s22_1, c22_1, (out_A[22] & out_B[0]), (out_A[21] & out_B[1]), c21_1);   
    full_adder fa22_2(s22_2, c22_2, s22_1, (out_A[20] & out_B[2]), c21_2);
    full_adder fa22_3(s22_3, c22_3, s22_2, (out_A[19] & out_B[3]), c21_3);
    full_adder fa22_4(s22_4, c22_4, s22_3, (out_A[18] & out_B[4]), c21_4);
    full_adder fa22_5(s22_5, c22_5, s22_4, (out_A[17] & out_B[5]), c21_5);
    full_adder fa22_6(s22_6, c22_6, s22_5, (out_A[16] & out_B[6]), c21_6);
    full_adder fa22_7(s22_7, c22_7, s22_6, (out_A[15] & out_B[7]), c21_7);
    full_adder fa22_8(s22_8, c22_8, s22_7, (out_A[14] & out_B[8]), c21_8);
    full_adder fa22_9(s22_9, c22_9, s22_8, (out_A[13] & out_B[9]), c21_9);
    full_adder fa22_10(s22_10, c22_10, s22_9, (out_A[12] & out_B[10]), c21_10);
    full_adder fa22_11(s22_11, c22_11, s22_10, (out_A[11] & out_B[11]), c21_11);
    full_adder fa22_12(s22_12, c22_12, s22_11, (out_A[10] & out_B[12]), c21_12);
    full_adder fa22_13(s22_13, c22_13, s22_12, (out_A[9] & out_B[13]), c21_13);
    full_adder fa22_14(s22_14, c22_14, s22_13, (out_A[8] & out_B[14]), c21_14);
    full_adder fa22_15(s22_15, c22_15, s22_14, (out_A[7] & out_B[15]), c21_15);
    full_adder fa22_16(s22_16, c22_16, s22_15, (out_A[6] & out_B[16]), c21_16);
    full_adder fa22_17(s22_17, c22_17, s22_16, (out_A[5] & out_B[17]), c21_17);
    full_adder fa22_18(s22_18, c22_18, s22_17, (out_A[4] & out_B[18]), c21_18);
    full_adder fa22_19(s22_19, c22_19, s22_18, (out_A[3] & out_B[19]), c21_19);
    full_adder fa22_20(s22_20, c22_20, s22_19, (out_A[2] & out_B[20]), c21_20);
    full_adder fa22_21(s22_21, c22_21, s22_20, (out_A[1] & out_B[21]), c21_21);
    half_adder ha22_22(data_result[22], c22_22, s22_21, (out_A[0] & out_B[22]));

    wire s23_22, s23_21, s23_20, s23_19, s23_18, s23_17, s23_16, s23_15, s23_14, s23_13, s23_12, s23_11, s23_10, s23_9, s23_8, s23_7, s23_6, s23_5, s23_4, s23_3, s23_2, s23_1, c23_23, c23_22, c23_21, c23_20, c23_19, c23_18, c23_17, c23_16, c23_15, c23_14, c23_13, c23_12, c23_11, c23_10, c23_9, c23_8, c23_7, c23_6, c23_5, c23_4, c23_3, c23_2, c23_1;

    full_adder fa23_1(s23_1, c23_1, (out_A[23] & out_B[0]), (out_A[22] & out_B[1]), c22_1);   
    full_adder fa23_2(s23_2, c23_2, s23_1, (out_A[21] & out_B[2]), c22_2);
    full_adder fa23_3(s23_3, c23_3, s23_2, (out_A[20] & out_B[3]), c22_3);
    full_adder fa23_4(s23_4, c23_4, s23_3, (out_A[19] & out_B[4]), c22_4);
    full_adder fa23_5(s23_5, c23_5, s23_4, (out_A[18] & out_B[5]), c22_5);
    full_adder fa23_6(s23_6, c23_6, s23_5, (out_A[17] & out_B[6]), c22_6);
    full_adder fa23_7(s23_7, c23_7, s23_6, (out_A[16] & out_B[7]), c22_7);
    full_adder fa23_8(s23_8, c23_8, s23_7, (out_A[15] & out_B[8]), c22_8);
    full_adder fa23_9(s23_9, c23_9, s23_8, (out_A[14] & out_B[9]), c22_9);
    full_adder fa23_10(s23_10, c23_10, s23_9, (out_A[13] & out_B[10]), c22_10);
    full_adder fa23_11(s23_11, c23_11, s23_10, (out_A[12] & out_B[11]), c22_11);
    full_adder fa23_12(s23_12, c23_12, s23_11, (out_A[11] & out_B[12]), c22_12);
    full_adder fa23_13(s23_13, c23_13, s23_12, (out_A[10] & out_B[13]), c22_13);
    full_adder fa23_14(s23_14, c23_14, s23_13, (out_A[9] & out_B[14]), c22_14);
    full_adder fa23_15(s23_15, c23_15, s23_14, (out_A[8] & out_B[15]), c22_15);
    full_adder fa23_16(s23_16, c23_16, s23_15, (out_A[7] & out_B[16]), c22_16);
    full_adder fa23_17(s23_17, c23_17, s23_16, (out_A[6] & out_B[17]), c22_17);
    full_adder fa23_18(s23_18, c23_18, s23_17, (out_A[5] & out_B[18]), c22_18);
    full_adder fa23_19(s23_19, c23_19, s23_18, (out_A[4] & out_B[19]), c22_19);
    full_adder fa23_20(s23_20, c23_20, s23_19, (out_A[3] & out_B[20]), c22_20);
    full_adder fa23_21(s23_21, c23_21, s23_20, (out_A[2] & out_B[21]), c22_21);
    full_adder fa23_22(s23_22, c23_22, s23_21, (out_A[1] & out_B[22]), c22_22);
    half_adder ha23_23(data_result[23], c23_23, s23_22, (out_A[0] & out_B[23]));

    wire s24_23, s24_22, s24_21, s24_20, s24_19, s24_18, s24_17, s24_16, s24_15, s24_14, s24_13, s24_12, s24_11, s24_10, s24_9, s24_8, s24_7, s24_6, s24_5, s24_4, s24_3, s24_2, s24_1, c24_24, c24_23, c24_22, c24_21, c24_20, c24_19, c24_18, c24_17, c24_16, c24_15, c24_14, c24_13, c24_12, c24_11, c24_10, c24_9, c24_8, c24_7, c24_6, c24_5, c24_4, c24_3, c24_2, c24_1;

    full_adder fa24_1(s24_1, c24_1, (out_A[24] & out_B[0]), (out_A[23] & out_B[1]), c23_1);   
    full_adder fa24_2(s24_2, c24_2, s24_1, (out_A[22] & out_B[2]), c23_2);
    full_adder fa24_3(s24_3, c24_3, s24_2, (out_A[21] & out_B[3]), c23_3);
    full_adder fa24_4(s24_4, c24_4, s24_3, (out_A[20] & out_B[4]), c23_4);
    full_adder fa24_5(s24_5, c24_5, s24_4, (out_A[19] & out_B[5]), c23_5);
    full_adder fa24_6(s24_6, c24_6, s24_5, (out_A[18] & out_B[6]), c23_6);
    full_adder fa24_7(s24_7, c24_7, s24_6, (out_A[17] & out_B[7]), c23_7);
    full_adder fa24_8(s24_8, c24_8, s24_7, (out_A[16] & out_B[8]), c23_8);
    full_adder fa24_9(s24_9, c24_9, s24_8, (out_A[15] & out_B[9]), c23_9);
    full_adder fa24_10(s24_10, c24_10, s24_9, (out_A[14] & out_B[10]), c23_10);
    full_adder fa24_11(s24_11, c24_11, s24_10, (out_A[13] & out_B[11]), c23_11);
    full_adder fa24_12(s24_12, c24_12, s24_11, (out_A[12] & out_B[12]), c23_12);
    full_adder fa24_13(s24_13, c24_13, s24_12, (out_A[11] & out_B[13]), c23_13);
    full_adder fa24_14(s24_14, c24_14, s24_13, (out_A[10] & out_B[14]), c23_14);
    full_adder fa24_15(s24_15, c24_15, s24_14, (out_A[9] & out_B[15]), c23_15);
    full_adder fa24_16(s24_16, c24_16, s24_15, (out_A[8] & out_B[16]), c23_16);
    full_adder fa24_17(s24_17, c24_17, s24_16, (out_A[7] & out_B[17]), c23_17);
    full_adder fa24_18(s24_18, c24_18, s24_17, (out_A[6] & out_B[18]), c23_18);
    full_adder fa24_19(s24_19, c24_19, s24_18, (out_A[5] & out_B[19]), c23_19);
    full_adder fa24_20(s24_20, c24_20, s24_19, (out_A[4] & out_B[20]), c23_20);
    full_adder fa24_21(s24_21, c24_21, s24_20, (out_A[3] & out_B[21]), c23_21);
    full_adder fa24_22(s24_22, c24_22, s24_21, (out_A[2] & out_B[22]), c23_22);
    full_adder fa24_23(s24_23, c24_23, s24_22, (out_A[1] & out_B[23]), c23_23);
    half_adder ha24_24(data_result[24], c24_24, s24_23, (out_A[0] & out_B[24]));

    wire s25_24, s25_23, s25_22, s25_21, s25_20, s25_19, s25_18, s25_17, s25_16, s25_15, s25_14, s25_13, s25_12, s25_11, s25_10, s25_9, s25_8, s25_7, s25_6, s25_5, s25_4, s25_3, s25_2, s25_1, c25_25, c25_24, c25_23, c25_22, c25_21, c25_20, c25_19, c25_18, c25_17, c25_16, c25_15, c25_14, c25_13, c25_12, c25_11, c25_10, c25_9, c25_8, c25_7, c25_6, c25_5, c25_4, c25_3, c25_2, c25_1;

    full_adder fa25_1(s25_1, c25_1, (out_A[25] & out_B[0]), (out_A[24] & out_B[1]), c24_1);   
    full_adder fa25_2(s25_2, c25_2, s25_1, (out_A[23] & out_B[2]), c24_2);
    full_adder fa25_3(s25_3, c25_3, s25_2, (out_A[22] & out_B[3]), c24_3);
    full_adder fa25_4(s25_4, c25_4, s25_3, (out_A[21] & out_B[4]), c24_4);
    full_adder fa25_5(s25_5, c25_5, s25_4, (out_A[20] & out_B[5]), c24_5);
    full_adder fa25_6(s25_6, c25_6, s25_5, (out_A[19] & out_B[6]), c24_6);
    full_adder fa25_7(s25_7, c25_7, s25_6, (out_A[18] & out_B[7]), c24_7);
    full_adder fa25_8(s25_8, c25_8, s25_7, (out_A[17] & out_B[8]), c24_8);
    full_adder fa25_9(s25_9, c25_9, s25_8, (out_A[16] & out_B[9]), c24_9);
    full_adder fa25_10(s25_10, c25_10, s25_9, (out_A[15] & out_B[10]), c24_10);
    full_adder fa25_11(s25_11, c25_11, s25_10, (out_A[14] & out_B[11]), c24_11);
    full_adder fa25_12(s25_12, c25_12, s25_11, (out_A[13] & out_B[12]), c24_12);
    full_adder fa25_13(s25_13, c25_13, s25_12, (out_A[12] & out_B[13]), c24_13);
    full_adder fa25_14(s25_14, c25_14, s25_13, (out_A[11] & out_B[14]), c24_14);
    full_adder fa25_15(s25_15, c25_15, s25_14, (out_A[10] & out_B[15]), c24_15);
    full_adder fa25_16(s25_16, c25_16, s25_15, (out_A[9] & out_B[16]), c24_16);
    full_adder fa25_17(s25_17, c25_17, s25_16, (out_A[8] & out_B[17]), c24_17);
    full_adder fa25_18(s25_18, c25_18, s25_17, (out_A[7] & out_B[18]), c24_18);
    full_adder fa25_19(s25_19, c25_19, s25_18, (out_A[6] & out_B[19]), c24_19);
    full_adder fa25_20(s25_20, c25_20, s25_19, (out_A[5] & out_B[20]), c24_20);
    full_adder fa25_21(s25_21, c25_21, s25_20, (out_A[4] & out_B[21]), c24_21);
    full_adder fa25_22(s25_22, c25_22, s25_21, (out_A[3] & out_B[22]), c24_22);
    full_adder fa25_23(s25_23, c25_23, s25_22, (out_A[2] & out_B[23]), c24_23);
    full_adder fa25_24(s25_24, c25_24, s25_23, (out_A[1] & out_B[24]), c24_24);
    half_adder ha25_25(data_result[25], c25_25, s25_24, (out_A[0] & out_B[25]));

    wire s26_25, s26_24, s26_23, s26_22, s26_21, s26_20, s26_19, s26_18, s26_17, s26_16, s26_15, s26_14, s26_13, s26_12, s26_11, s26_10, s26_9, s26_8, s26_7, s26_6, s26_5, s26_4, s26_3, s26_2, s26_1, c26_26, c26_25, c26_24, c26_23, c26_22, c26_21, c26_20, c26_19, c26_18, c26_17, c26_16, c26_15, c26_14, c26_13, c26_12, c26_11, c26_10, c26_9, c26_8, c26_7, c26_6, c26_5, c26_4, c26_3, c26_2, c26_1;

    full_adder fa26_1(s26_1, c26_1, (out_A[26] & out_B[0]), (out_A[25] & out_B[1]), c25_1);   
    full_adder fa26_2(s26_2, c26_2, s26_1, (out_A[24] & out_B[2]), c25_2);
    full_adder fa26_3(s26_3, c26_3, s26_2, (out_A[23] & out_B[3]), c25_3);
    full_adder fa26_4(s26_4, c26_4, s26_3, (out_A[22] & out_B[4]), c25_4);
    full_adder fa26_5(s26_5, c26_5, s26_4, (out_A[21] & out_B[5]), c25_5);
    full_adder fa26_6(s26_6, c26_6, s26_5, (out_A[20] & out_B[6]), c25_6);
    full_adder fa26_7(s26_7, c26_7, s26_6, (out_A[19] & out_B[7]), c25_7);
    full_adder fa26_8(s26_8, c26_8, s26_7, (out_A[18] & out_B[8]), c25_8);
    full_adder fa26_9(s26_9, c26_9, s26_8, (out_A[17] & out_B[9]), c25_9);
    full_adder fa26_10(s26_10, c26_10, s26_9, (out_A[16] & out_B[10]), c25_10);
    full_adder fa26_11(s26_11, c26_11, s26_10, (out_A[15] & out_B[11]), c25_11);
    full_adder fa26_12(s26_12, c26_12, s26_11, (out_A[14] & out_B[12]), c25_12);
    full_adder fa26_13(s26_13, c26_13, s26_12, (out_A[13] & out_B[13]), c25_13);
    full_adder fa26_14(s26_14, c26_14, s26_13, (out_A[12] & out_B[14]), c25_14);
    full_adder fa26_15(s26_15, c26_15, s26_14, (out_A[11] & out_B[15]), c25_15);
    full_adder fa26_16(s26_16, c26_16, s26_15, (out_A[10] & out_B[16]), c25_16);
    full_adder fa26_17(s26_17, c26_17, s26_16, (out_A[9] & out_B[17]), c25_17);
    full_adder fa26_18(s26_18, c26_18, s26_17, (out_A[8] & out_B[18]), c25_18);
    full_adder fa26_19(s26_19, c26_19, s26_18, (out_A[7] & out_B[19]), c25_19);
    full_adder fa26_20(s26_20, c26_20, s26_19, (out_A[6] & out_B[20]), c25_20);
    full_adder fa26_21(s26_21, c26_21, s26_20, (out_A[5] & out_B[21]), c25_21);
    full_adder fa26_22(s26_22, c26_22, s26_21, (out_A[4] & out_B[22]), c25_22);
    full_adder fa26_23(s26_23, c26_23, s26_22, (out_A[3] & out_B[23]), c25_23);
    full_adder fa26_24(s26_24, c26_24, s26_23, (out_A[2] & out_B[24]), c25_24);
    full_adder fa26_25(s26_25, c26_25, s26_24, (out_A[1] & out_B[25]), c25_25);
    half_adder ha26_26(data_result[26], c26_26, s26_25, (out_A[0] & out_B[26]));

    wire s27_26, s27_25, s27_24, s27_23, s27_22, s27_21, s27_20, s27_19, s27_18, s27_17, s27_16, s27_15, s27_14, s27_13, s27_12, s27_11, s27_10, s27_9, s27_8, s27_7, s27_6, s27_5, s27_4, s27_3, s27_2, s27_1, c27_27, c27_26, c27_25, c27_24, c27_23, c27_22, c27_21, c27_20, c27_19, c27_18, c27_17, c27_16, c27_15, c27_14, c27_13, c27_12, c27_11, c27_10, c27_9, c27_8, c27_7, c27_6, c27_5, c27_4, c27_3, c27_2, c27_1;

    full_adder fa27_1(s27_1, c27_1, (out_A[27] & out_B[0]), (out_A[26] & out_B[1]), c26_1);   
    full_adder fa27_2(s27_2, c27_2, s27_1, (out_A[25] & out_B[2]), c26_2);
    full_adder fa27_3(s27_3, c27_3, s27_2, (out_A[24] & out_B[3]), c26_3);
    full_adder fa27_4(s27_4, c27_4, s27_3, (out_A[23] & out_B[4]), c26_4);
    full_adder fa27_5(s27_5, c27_5, s27_4, (out_A[22] & out_B[5]), c26_5);
    full_adder fa27_6(s27_6, c27_6, s27_5, (out_A[21] & out_B[6]), c26_6);
    full_adder fa27_7(s27_7, c27_7, s27_6, (out_A[20] & out_B[7]), c26_7);
    full_adder fa27_8(s27_8, c27_8, s27_7, (out_A[19] & out_B[8]), c26_8);
    full_adder fa27_9(s27_9, c27_9, s27_8, (out_A[18] & out_B[9]), c26_9);
    full_adder fa27_10(s27_10, c27_10, s27_9, (out_A[17] & out_B[10]), c26_10);
    full_adder fa27_11(s27_11, c27_11, s27_10, (out_A[16] & out_B[11]), c26_11);
    full_adder fa27_12(s27_12, c27_12, s27_11, (out_A[15] & out_B[12]), c26_12);
    full_adder fa27_13(s27_13, c27_13, s27_12, (out_A[14] & out_B[13]), c26_13);
    full_adder fa27_14(s27_14, c27_14, s27_13, (out_A[13] & out_B[14]), c26_14);
    full_adder fa27_15(s27_15, c27_15, s27_14, (out_A[12] & out_B[15]), c26_15);
    full_adder fa27_16(s27_16, c27_16, s27_15, (out_A[11] & out_B[16]), c26_16);
    full_adder fa27_17(s27_17, c27_17, s27_16, (out_A[10] & out_B[17]), c26_17);
    full_adder fa27_18(s27_18, c27_18, s27_17, (out_A[9] & out_B[18]), c26_18);
    full_adder fa27_19(s27_19, c27_19, s27_18, (out_A[8] & out_B[19]), c26_19);
    full_adder fa27_20(s27_20, c27_20, s27_19, (out_A[7] & out_B[20]), c26_20);
    full_adder fa27_21(s27_21, c27_21, s27_20, (out_A[6] & out_B[21]), c26_21);
    full_adder fa27_22(s27_22, c27_22, s27_21, (out_A[5] & out_B[22]), c26_22);
    full_adder fa27_23(s27_23, c27_23, s27_22, (out_A[4] & out_B[23]), c26_23);
    full_adder fa27_24(s27_24, c27_24, s27_23, (out_A[3] & out_B[24]), c26_24);
    full_adder fa27_25(s27_25, c27_25, s27_24, (out_A[2] & out_B[25]), c26_25);
    full_adder fa27_26(s27_26, c27_26, s27_25, (out_A[1] & out_B[26]), c26_26);
    half_adder ha27_27(data_result[27], c27_27, s27_26, (out_A[0] & out_B[27]));

    wire s28_27, s28_26, s28_25, s28_24, s28_23, s28_22, s28_21, s28_20, s28_19, s28_18, s28_17, s28_16, s28_15, s28_14, s28_13, s28_12, s28_11, s28_10, s28_9, s28_8, s28_7, s28_6, s28_5, s28_4, s28_3, s28_2, s28_1, c28_28, c28_27, c28_26, c28_25, c28_24, c28_23, c28_22, c28_21, c28_20, c28_19, c28_18, c28_17, c28_16, c28_15, c28_14, c28_13, c28_12, c28_11, c28_10, c28_9, c28_8, c28_7, c28_6, c28_5, c28_4, c28_3, c28_2, c28_1;

    full_adder fa28_1(s28_1, c28_1, (out_A[28] & out_B[0]), (out_A[27] & out_B[1]), c27_1);   
    full_adder fa28_2(s28_2, c28_2, s28_1, (out_A[26] & out_B[2]), c27_2);
    full_adder fa28_3(s28_3, c28_3, s28_2, (out_A[25] & out_B[3]), c27_3);
    full_adder fa28_4(s28_4, c28_4, s28_3, (out_A[24] & out_B[4]), c27_4);
    full_adder fa28_5(s28_5, c28_5, s28_4, (out_A[23] & out_B[5]), c27_5);
    full_adder fa28_6(s28_6, c28_6, s28_5, (out_A[22] & out_B[6]), c27_6);
    full_adder fa28_7(s28_7, c28_7, s28_6, (out_A[21] & out_B[7]), c27_7);
    full_adder fa28_8(s28_8, c28_8, s28_7, (out_A[20] & out_B[8]), c27_8);
    full_adder fa28_9(s28_9, c28_9, s28_8, (out_A[19] & out_B[9]), c27_9);
    full_adder fa28_10(s28_10, c28_10, s28_9, (out_A[18] & out_B[10]), c27_10);
    full_adder fa28_11(s28_11, c28_11, s28_10, (out_A[17] & out_B[11]), c27_11);
    full_adder fa28_12(s28_12, c28_12, s28_11, (out_A[16] & out_B[12]), c27_12);
    full_adder fa28_13(s28_13, c28_13, s28_12, (out_A[15] & out_B[13]), c27_13);
    full_adder fa28_14(s28_14, c28_14, s28_13, (out_A[14] & out_B[14]), c27_14);
    full_adder fa28_15(s28_15, c28_15, s28_14, (out_A[13] & out_B[15]), c27_15);
    full_adder fa28_16(s28_16, c28_16, s28_15, (out_A[12] & out_B[16]), c27_16);
    full_adder fa28_17(s28_17, c28_17, s28_16, (out_A[11] & out_B[17]), c27_17);
    full_adder fa28_18(s28_18, c28_18, s28_17, (out_A[10] & out_B[18]), c27_18);
    full_adder fa28_19(s28_19, c28_19, s28_18, (out_A[9] & out_B[19]), c27_19);
    full_adder fa28_20(s28_20, c28_20, s28_19, (out_A[8] & out_B[20]), c27_20);
    full_adder fa28_21(s28_21, c28_21, s28_20, (out_A[7] & out_B[21]), c27_21);
    full_adder fa28_22(s28_22, c28_22, s28_21, (out_A[6] & out_B[22]), c27_22);
    full_adder fa28_23(s28_23, c28_23, s28_22, (out_A[5] & out_B[23]), c27_23);
    full_adder fa28_24(s28_24, c28_24, s28_23, (out_A[4] & out_B[24]), c27_24);
    full_adder fa28_25(s28_25, c28_25, s28_24, (out_A[3] & out_B[25]), c27_25);
    full_adder fa28_26(s28_26, c28_26, s28_25, (out_A[2] & out_B[26]), c27_26);
    full_adder fa28_27(s28_27, c28_27, s28_26, (out_A[1] & out_B[27]), c27_27);
    half_adder ha28_28(data_result[28], c28_28, s28_27, (out_A[0] & out_B[28]));

    wire s29_28, s29_27, s29_26, s29_25, s29_24, s29_23, s29_22, s29_21, s29_20, s29_19, s29_18, s29_17, s29_16, s29_15, s29_14, s29_13, s29_12, s29_11, s29_10, s29_9, s29_8, s29_7, s29_6, s29_5, s29_4, s29_3, s29_2, s29_1, c29_29, c29_28, c29_27, c29_26, c29_25, c29_24, c29_23, c29_22, c29_21, c29_20, c29_19, c29_18, c29_17, c29_16, c29_15, c29_14, c29_13, c29_12, c29_11, c29_10, c29_9, c29_8, c29_7, c29_6, c29_5, c29_4, c29_3, c29_2, c29_1;        

    full_adder fa29_1(s29_1, c29_1, (out_A[29] & out_B[0]), (out_A[28] & out_B[1]), c28_1);   
    full_adder fa29_2(s29_2, c29_2, s29_1, (out_A[27] & out_B[2]), c28_2);
    full_adder fa29_3(s29_3, c29_3, s29_2, (out_A[26] & out_B[3]), c28_3);
    full_adder fa29_4(s29_4, c29_4, s29_3, (out_A[25] & out_B[4]), c28_4);
    full_adder fa29_5(s29_5, c29_5, s29_4, (out_A[24] & out_B[5]), c28_5);
    full_adder fa29_6(s29_6, c29_6, s29_5, (out_A[23] & out_B[6]), c28_6);
    full_adder fa29_7(s29_7, c29_7, s29_6, (out_A[22] & out_B[7]), c28_7);
    full_adder fa29_8(s29_8, c29_8, s29_7, (out_A[21] & out_B[8]), c28_8);
    full_adder fa29_9(s29_9, c29_9, s29_8, (out_A[20] & out_B[9]), c28_9);
    full_adder fa29_10(s29_10, c29_10, s29_9, (out_A[19] & out_B[10]), c28_10);
    full_adder fa29_11(s29_11, c29_11, s29_10, (out_A[18] & out_B[11]), c28_11);
    full_adder fa29_12(s29_12, c29_12, s29_11, (out_A[17] & out_B[12]), c28_12);
    full_adder fa29_13(s29_13, c29_13, s29_12, (out_A[16] & out_B[13]), c28_13);
    full_adder fa29_14(s29_14, c29_14, s29_13, (out_A[15] & out_B[14]), c28_14);
    full_adder fa29_15(s29_15, c29_15, s29_14, (out_A[14] & out_B[15]), c28_15);
    full_adder fa29_16(s29_16, c29_16, s29_15, (out_A[13] & out_B[16]), c28_16);
    full_adder fa29_17(s29_17, c29_17, s29_16, (out_A[12] & out_B[17]), c28_17);
    full_adder fa29_18(s29_18, c29_18, s29_17, (out_A[11] & out_B[18]), c28_18);
    full_adder fa29_19(s29_19, c29_19, s29_18, (out_A[10] & out_B[19]), c28_19);
    full_adder fa29_20(s29_20, c29_20, s29_19, (out_A[9] & out_B[20]), c28_20);
    full_adder fa29_21(s29_21, c29_21, s29_20, (out_A[8] & out_B[21]), c28_21);
    full_adder fa29_22(s29_22, c29_22, s29_21, (out_A[7] & out_B[22]), c28_22);
    full_adder fa29_23(s29_23, c29_23, s29_22, (out_A[6] & out_B[23]), c28_23);
    full_adder fa29_24(s29_24, c29_24, s29_23, (out_A[5] & out_B[24]), c28_24);
    full_adder fa29_25(s29_25, c29_25, s29_24, (out_A[4] & out_B[25]), c28_25);
    full_adder fa29_26(s29_26, c29_26, s29_25, (out_A[3] & out_B[26]), c28_26);
    full_adder fa29_27(s29_27, c29_27, s29_26, (out_A[2] & out_B[27]), c28_27);
    full_adder fa29_28(s29_28, c29_28, s29_27, (out_A[1] & out_B[28]), c28_28);
    half_adder ha29_29(data_result[29], c29_29, s29_28, (out_A[0] & out_B[29]));

    wire s30_29, s30_28, s30_27, s30_26, s30_25, s30_24, s30_23, s30_22, s30_21, s30_20, s30_19, s30_18, s30_17, s30_16, s30_15, s30_14, s30_13, s30_12, s30_11, s30_10, s30_9, s30_8, s30_7, s30_6, s30_5, s30_4, s30_3, s30_2, s30_1, c30_30, c30_29, c30_28, c30_27, c30_26, c30_25, c30_24, c30_23, c30_22, c30_21, c30_20, c30_19, c30_18, c30_17, c30_16, c30_15, c30_14, c30_13, c30_12, c30_11, c30_10, c30_9, c30_8, c30_7, c30_6, c30_5, c30_4, c30_3, c30_2, c30_1;

    full_adder fa30_1(s30_1, c30_1, (out_A[30] & out_B[0]), (out_A[29] & out_B[1]), c29_1);   
    full_adder fa30_2(s30_2, c30_2, s30_1, (out_A[28] & out_B[2]), c29_2);
    full_adder fa30_3(s30_3, c30_3, s30_2, (out_A[27] & out_B[3]), c29_3);
    full_adder fa30_4(s30_4, c30_4, s30_3, (out_A[26] & out_B[4]), c29_4);
    full_adder fa30_5(s30_5, c30_5, s30_4, (out_A[25] & out_B[5]), c29_5);
    full_adder fa30_6(s30_6, c30_6, s30_5, (out_A[24] & out_B[6]), c29_6);
    full_adder fa30_7(s30_7, c30_7, s30_6, (out_A[23] & out_B[7]), c29_7);
    full_adder fa30_8(s30_8, c30_8, s30_7, (out_A[22] & out_B[8]), c29_8);
    full_adder fa30_9(s30_9, c30_9, s30_8, (out_A[21] & out_B[9]), c29_9);
    full_adder fa30_10(s30_10, c30_10, s30_9, (out_A[20] & out_B[10]), c29_10);
    full_adder fa30_11(s30_11, c30_11, s30_10, (out_A[19] & out_B[11]), c29_11);
    full_adder fa30_12(s30_12, c30_12, s30_11, (out_A[18] & out_B[12]), c29_12);
    full_adder fa30_13(s30_13, c30_13, s30_12, (out_A[17] & out_B[13]), c29_13);
    full_adder fa30_14(s30_14, c30_14, s30_13, (out_A[16] & out_B[14]), c29_14);
    full_adder fa30_15(s30_15, c30_15, s30_14, (out_A[15] & out_B[15]), c29_15);
    full_adder fa30_16(s30_16, c30_16, s30_15, (out_A[14] & out_B[16]), c29_16);
    full_adder fa30_17(s30_17, c30_17, s30_16, (out_A[13] & out_B[17]), c29_17);
    full_adder fa30_18(s30_18, c30_18, s30_17, (out_A[12] & out_B[18]), c29_18);
    full_adder fa30_19(s30_19, c30_19, s30_18, (out_A[11] & out_B[19]), c29_19);
    full_adder fa30_20(s30_20, c30_20, s30_19, (out_A[10] & out_B[20]), c29_20);
    full_adder fa30_21(s30_21, c30_21, s30_20, (out_A[9] & out_B[21]), c29_21);
    full_adder fa30_22(s30_22, c30_22, s30_21, (out_A[8] & out_B[22]), c29_22);
    full_adder fa30_23(s30_23, c30_23, s30_22, (out_A[7] & out_B[23]), c29_23);
    full_adder fa30_24(s30_24, c30_24, s30_23, (out_A[6] & out_B[24]), c29_24);
    full_adder fa30_25(s30_25, c30_25, s30_24, (out_A[5] & out_B[25]), c29_25);
    full_adder fa30_26(s30_26, c30_26, s30_25, (out_A[4] & out_B[26]), c29_26);
    full_adder fa30_27(s30_27, c30_27, s30_26, (out_A[3] & out_B[27]), c29_27);
    full_adder fa30_28(s30_28, c30_28, s30_27, (out_A[2] & out_B[28]), c29_28);
    full_adder fa30_29(s30_29, c30_29, s30_28, (out_A[1] & out_B[29]), c29_29);
    half_adder ha30_30(data_result[30], c30_30, s30_29, (out_A[0] & out_B[30]));

    wire s31_30, s31_29, s31_28, s31_27, s31_26, s31_25, s31_24, s31_23, s31_22, s31_21, s31_20, s31_19, s31_18, s31_17, s31_16, s31_15, s31_14, s31_13, s31_12, s31_11, s31_10, s31_9, s31_8, s31_7, s31_6, s31_5, s31_4, s31_3, s31_2, s31_1, c31_31, c31_30, c31_29, c31_28, c31_27, c31_26, c31_25, c31_24, c31_23, c31_22, c31_21, c31_20, c31_19, c31_18, c31_17, c31_16, c31_15, c31_14, c31_13, c31_12, c31_11, c31_10, c31_9, c31_8, c31_7, c31_6, c31_5, c31_4, c31_3, c31_2, c31_1;

    full_adder fa31_1(s31_1, c31_1, ~(out_A[31] & out_B[0]), (out_A[30] & out_B[1]), c30_1);   
    full_adder fa31_2(s31_2, c31_2, s31_1, (out_A[29] & out_B[2]), c30_2);
    full_adder fa31_3(s31_3, c31_3, s31_2, (out_A[28] & out_B[3]), c30_3);
    full_adder fa31_4(s31_4, c31_4, s31_3, (out_A[27] & out_B[4]), c30_4);
    full_adder fa31_5(s31_5, c31_5, s31_4, (out_A[26] & out_B[5]), c30_5);
    full_adder fa31_6(s31_6, c31_6, s31_5, (out_A[25] & out_B[6]), c30_6);
    full_adder fa31_7(s31_7, c31_7, s31_6, (out_A[24] & out_B[7]), c30_7);
    full_adder fa31_8(s31_8, c31_8, s31_7, (out_A[23] & out_B[8]), c30_8);
    full_adder fa31_9(s31_9, c31_9, s31_8, (out_A[22] & out_B[9]), c30_9);
    full_adder fa31_10(s31_10, c31_10, s31_9, (out_A[21] & out_B[10]), c30_10);
    full_adder fa31_11(s31_11, c31_11, s31_10, (out_A[20] & out_B[11]), c30_11);
    full_adder fa31_12(s31_12, c31_12, s31_11, (out_A[19] & out_B[12]), c30_12);
    full_adder fa31_13(s31_13, c31_13, s31_12, (out_A[18] & out_B[13]), c30_13);
    full_adder fa31_14(s31_14, c31_14, s31_13, (out_A[17] & out_B[14]), c30_14);
    full_adder fa31_15(s31_15, c31_15, s31_14, (out_A[16] & out_B[15]), c30_15);
    full_adder fa31_16(s31_16, c31_16, s31_15, (out_A[15] & out_B[16]), c30_16);
    full_adder fa31_17(s31_17, c31_17, s31_16, (out_A[14] & out_B[17]), c30_17);
    full_adder fa31_18(s31_18, c31_18, s31_17, (out_A[13] & out_B[18]), c30_18);
    full_adder fa31_19(s31_19, c31_19, s31_18, (out_A[12] & out_B[19]), c30_19);
    full_adder fa31_20(s31_20, c31_20, s31_19, (out_A[11] & out_B[20]), c30_20);
    full_adder fa31_21(s31_21, c31_21, s31_20, (out_A[10] & out_B[21]), c30_21);
    full_adder fa31_22(s31_22, c31_22, s31_21, (out_A[9] & out_B[22]), c30_22);
    full_adder fa31_23(s31_23, c31_23, s31_22, (out_A[8] & out_B[23]), c30_23);
    full_adder fa31_24(s31_24, c31_24, s31_23, (out_A[7] & out_B[24]), c30_24);
    full_adder fa31_25(s31_25, c31_25, s31_24, (out_A[6] & out_B[25]), c30_25);
    full_adder fa31_26(s31_26, c31_26, s31_25, (out_A[5] & out_B[26]), c30_26);
    full_adder fa31_27(s31_27, c31_27, s31_26, (out_A[4] & out_B[27]), c30_27);
    full_adder fa31_28(s31_28, c31_28, s31_27, (out_A[3] & out_B[28]), c30_28);
    full_adder fa31_29(s31_29, c31_29, s31_28, (out_A[2] & out_B[29]), c30_29);
    full_adder fa31_30(s31_30, c31_30, s31_29, (out_A[1] & out_B[30]), c30_30);
    half_adder ha31_31(data_result[31], c31_31, s31_30, ~(out_A[0] & out_B[31]));

    wire s32_1, s32_2, s32_3, s32_4, s32_5, s32_6, s32_7, s32_8, s32_9, s32_10, s32_11, s32_12, s32_13, s32_14, s32_15, s32_16, s32_17, s32_18, s32_19, s32_20, s32_21, s32_22, s32_23, s32_24, s32_25, s32_26, s32_27, s32_28, s32_29, s32_30, c32_1, c32_2, c32_3, c32_4, c32_5, c32_6, c32_7, c32_8, c32_9, c32_10, c32_11, c32_12, c32_13, c32_14, c32_15, c32_16, c32_17, c32_18, c32_19, c32_20, c32_21, c32_22, c32_23, c32_24, c32_25, c32_26, c32_27, c32_28, c32_29, c32_30, c32_31;

    full_adder fa32_1(s32_1, c32_1, 1'b1, ~(out_A[31] & out_B[1]), c31_1);
    full_adder fa32_2(s32_2, c32_2, s32_1, (out_A[30] & out_B[2]), c31_2);
    full_adder fa32_3(s32_3, c32_3, s32_2, (out_A[29] & out_B[3]), c31_3);
    full_adder fa32_4(s32_4, c32_4, s32_3, (out_A[28] & out_B[4]), c31_4);
    full_adder fa32_5(s32_5, c32_5, s32_4, (out_A[27] & out_B[5]), c31_5);
    full_adder fa32_6(s32_6, c32_6, s32_5, (out_A[26] & out_B[6]), c31_6);
    full_adder fa32_7(s32_7, c32_7, s32_6, (out_A[25] & out_B[7]), c31_7);
    full_adder fa32_8(s32_8, c32_8, s32_7, (out_A[24] & out_B[8]), c31_8);
    full_adder fa32_9(s32_9, c32_9, s32_8, (out_A[23] & out_B[9]), c31_9);
    full_adder fa32_10(s32_10, c32_10, s32_9, (out_A[22] & out_B[10]), c31_10);
    full_adder fa32_11(s32_11, c32_11, s32_10, (out_A[21] & out_B[11]), c31_11);
    full_adder fa32_12(s32_12, c32_12, s32_11, (out_A[20] & out_B[12]), c31_12);
    full_adder fa32_13(s32_13, c32_13, s32_12, (out_A[19] & out_B[13]), c31_13);
    full_adder fa32_14(s32_14, c32_14, s32_13, (out_A[18] & out_B[14]), c31_14);
    full_adder fa32_15(s32_15, c32_15, s32_14, (out_A[17] & out_B[15]), c31_15);
    full_adder fa32_16(s32_16, c32_16, s32_15, (out_A[16] & out_B[16]), c31_16);
    full_adder fa32_17(s32_17, c32_17, s32_16, (out_A[15] & out_B[17]), c31_17);
    full_adder fa32_18(s32_18, c32_18, s32_17, (out_A[14] & out_B[18]), c31_18);
    full_adder fa32_19(s32_19, c32_19, s32_18, (out_A[13] & out_B[19]), c31_19);
    full_adder fa32_20(s32_20, c32_20, s32_19, (out_A[12] & out_B[20]), c31_20);
    full_adder fa32_21(s32_21, c32_21, s32_20, (out_A[11] & out_B[21]), c31_21);
    full_adder fa32_22(s32_22, c32_22, s32_21, (out_A[10] & out_B[22]), c31_22);
    full_adder fa32_23(s32_23, c32_23, s32_22, (out_A[9] & out_B[23]), c31_23);
    full_adder fa32_24(s32_24, c32_24, s32_23, (out_A[8] & out_B[24]), c31_24);
    full_adder fa32_25(s32_25, c32_25, s32_24, (out_A[7] & out_B[25]), c31_25);
    full_adder fa32_26(s32_26, c32_26, s32_25, (out_A[6] & out_B[26]), c31_26);
    full_adder fa32_27(s32_27, c32_27, s32_26, (out_A[5] & out_B[27]), c31_27);
    full_adder fa32_28(s32_28, c32_28, s32_27, (out_A[4] & out_B[28]), c31_28);
    full_adder fa32_29(s32_29, c32_29, s32_28, (out_A[3] & out_B[29]), c31_29);
    full_adder fa32_30(s32_30, c32_30, s32_29, (out_A[2] & out_B[30]), c31_30);
    full_adder fa32_31(data_result_cont[0], c32_31, s32_30, ~(out_A[1] & out_B[31]), c31_31);

    wire s33_2, s33_3, s33_4, s33_5, s33_6, s33_7, s33_8, s33_9, s33_10, s33_11, s33_12, s33_13, s33_14, s33_15, s33_16, s33_17, s33_18, s33_19, s33_20, s33_21, s33_22, s33_23, s33_24, s33_25, s33_26, s33_27, s33_28, s33_29, s33_30, c33_2, c33_3, c33_4, c33_5, c33_6, c33_7, c33_8, c33_9, c33_10, c33_11, c33_12, c33_13, c33_14, c33_15, c33_16, c33_17, c33_18, c33_19, c33_20, c33_21, c33_22, c33_23, c33_24, c33_25, c33_26, c33_27, c33_28, c33_29, c33_30, c33_31;     

    full_adder fa33_2(s33_2, c33_2, c32_1, ~(out_A[31] & out_B[2]), c32_2);
    full_adder fa33_3(s33_3, c33_3, s33_2, (out_A[30] & out_B[3]), c32_3);
    full_adder fa33_4(s33_4, c33_4, s33_3, (out_A[29] & out_B[4]), c32_4);
    full_adder fa33_5(s33_5, c33_5, s33_4, (out_A[28] & out_B[5]), c32_5);
    full_adder fa33_6(s33_6, c33_6, s33_5, (out_A[27] & out_B[6]), c32_6);
    full_adder fa33_7(s33_7, c33_7, s33_6, (out_A[26] & out_B[7]), c32_7);
    full_adder fa33_8(s33_8, c33_8, s33_7, (out_A[25] & out_B[8]), c32_8);
    full_adder fa33_9(s33_9, c33_9, s33_8, (out_A[24] & out_B[9]), c32_9);
    full_adder fa33_10(s33_10, c33_10, s33_9, (out_A[23] & out_B[10]), c32_10);
    full_adder fa33_11(s33_11, c33_11, s33_10, (out_A[22] & out_B[11]), c32_11);
    full_adder fa33_12(s33_12, c33_12, s33_11, (out_A[21] & out_B[12]), c32_12);
    full_adder fa33_13(s33_13, c33_13, s33_12, (out_A[20] & out_B[13]), c32_13);
    full_adder fa33_14(s33_14, c33_14, s33_13, (out_A[19] & out_B[14]), c32_14);
    full_adder fa33_15(s33_15, c33_15, s33_14, (out_A[18] & out_B[15]), c32_15);
    full_adder fa33_16(s33_16, c33_16, s33_15, (out_A[17] & out_B[16]), c32_16);
    full_adder fa33_17(s33_17, c33_17, s33_16, (out_A[16] & out_B[17]), c32_17);
    full_adder fa33_18(s33_18, c33_18, s33_17, (out_A[15] & out_B[18]), c32_18);
    full_adder fa33_19(s33_19, c33_19, s33_18, (out_A[14] & out_B[19]), c32_19);
    full_adder fa33_20(s33_20, c33_20, s33_19, (out_A[13] & out_B[20]), c32_20);
    full_adder fa33_21(s33_21, c33_21, s33_20, (out_A[12] & out_B[21]), c32_21);
    full_adder fa33_22(s33_22, c33_22, s33_21, (out_A[11] & out_B[22]), c32_22);
    full_adder fa33_23(s33_23, c33_23, s33_22, (out_A[10] & out_B[23]), c32_23);
    full_adder fa33_24(s33_24, c33_24, s33_23, (out_A[9] & out_B[24]), c32_24);
    full_adder fa33_25(s33_25, c33_25, s33_24, (out_A[8] & out_B[25]), c32_25);
    full_adder fa33_26(s33_26, c33_26, s33_25, (out_A[7] & out_B[26]), c32_26);
    full_adder fa33_27(s33_27, c33_27, s33_26, (out_A[6] & out_B[27]), c32_27);
    full_adder fa33_28(s33_28, c33_28, s33_27, (out_A[5] & out_B[28]), c32_28);
    full_adder fa33_29(s33_29, c33_29, s33_28, (out_A[4] & out_B[29]), c32_29);
    full_adder fa33_30(s33_30, c33_30, s33_29, (out_A[3] & out_B[30]), c32_30);
    full_adder fa33_31(data_result_cont[1], c33_31, s33_30, ~(out_A[2] & out_B[31]), c32_31);

    wire s34_3, s34_4, s34_5, s34_6, s34_7, s34_8, s34_9, s34_10, s34_11, s34_12, s34_13, s34_14, s34_15, s34_16, s34_17, s34_18, s34_19, s34_20, s34_21, s34_22, s34_23, s34_24, s34_25, s34_26, s34_27, s34_28, s34_29, s34_30, c34_3, c34_4, c34_5, c34_6, c34_7, c34_8, c34_9, c34_10, c34_11, c34_12, c34_13, c34_14, c34_15, c34_16, c34_17, c34_18, c34_19, c34_20, c34_21, c34_22, c34_23, c34_24, c34_25, c34_26, c34_27, c34_28, c34_29, c34_30, c34_31;

    full_adder fa34_3(s34_3, c34_3, c33_2, ~(out_A[31] & out_B[3]), c33_3);
    full_adder fa34_4(s34_4, c34_4, s34_3, (out_A[30] & out_B[4]), c33_4);
    full_adder fa34_5(s34_5, c34_5, s34_4, (out_A[29] & out_B[5]), c33_5);
    full_adder fa34_6(s34_6, c34_6, s34_5, (out_A[28] & out_B[6]), c33_6);
    full_adder fa34_7(s34_7, c34_7, s34_6, (out_A[27] & out_B[7]), c33_7);
    full_adder fa34_8(s34_8, c34_8, s34_7, (out_A[26] & out_B[8]), c33_8);
    full_adder fa34_9(s34_9, c34_9, s34_8, (out_A[25] & out_B[9]), c33_9);
    full_adder fa34_10(s34_10, c34_10, s34_9, (out_A[24] & out_B[10]), c33_10);
    full_adder fa34_11(s34_11, c34_11, s34_10, (out_A[23] & out_B[11]), c33_11);
    full_adder fa34_12(s34_12, c34_12, s34_11, (out_A[22] & out_B[12]), c33_12);
    full_adder fa34_13(s34_13, c34_13, s34_12, (out_A[21] & out_B[13]), c33_13);
    full_adder fa34_14(s34_14, c34_14, s34_13, (out_A[20] & out_B[14]), c33_14);
    full_adder fa34_15(s34_15, c34_15, s34_14, (out_A[19] & out_B[15]), c33_15);
    full_adder fa34_16(s34_16, c34_16, s34_15, (out_A[18] & out_B[16]), c33_16);
    full_adder fa34_17(s34_17, c34_17, s34_16, (out_A[17] & out_B[17]), c33_17);
    full_adder fa34_18(s34_18, c34_18, s34_17, (out_A[16] & out_B[18]), c33_18);
    full_adder fa34_19(s34_19, c34_19, s34_18, (out_A[15] & out_B[19]), c33_19);
    full_adder fa34_20(s34_20, c34_20, s34_19, (out_A[14] & out_B[20]), c33_20);
    full_adder fa34_21(s34_21, c34_21, s34_20, (out_A[13] & out_B[21]), c33_21);
    full_adder fa34_22(s34_22, c34_22, s34_21, (out_A[12] & out_B[22]), c33_22);
    full_adder fa34_23(s34_23, c34_23, s34_22, (out_A[11] & out_B[23]), c33_23);
    full_adder fa34_24(s34_24, c34_24, s34_23, (out_A[10] & out_B[24]), c33_24);
    full_adder fa34_25(s34_25, c34_25, s34_24, (out_A[9] & out_B[25]), c33_25);
    full_adder fa34_26(s34_26, c34_26, s34_25, (out_A[8] & out_B[26]), c33_26);
    full_adder fa34_27(s34_27, c34_27, s34_26, (out_A[7] & out_B[27]), c33_27);
    full_adder fa34_28(s34_28, c34_28, s34_27, (out_A[6] & out_B[28]), c33_28);
    full_adder fa34_29(s34_29, c34_29, s34_28, (out_A[5] & out_B[29]), c33_29);
    full_adder fa34_30(s34_30, c34_30, s34_29, (out_A[4] & out_B[30]), c33_30);
    full_adder fa34_31(data_result_cont[2], c34_31, s34_30, ~(out_A[3] & out_B[31]), c33_31);

    wire s35_4, s35_5, s35_6, s35_7, s35_8, s35_9, s35_10, s35_11, s35_12, s35_13, s35_14, s35_15, s35_16, s35_17, s35_18, s35_19, s35_20, s35_21, s35_22, s35_23, s35_24, s35_25, s35_26, s35_27, s35_28, s35_29, s35_30, c35_4, c35_5, c35_6, c35_7, c35_8, c35_9, c35_10, c35_11, c35_12, c35_13, c35_14, c35_15, c35_16, c35_17, c35_18, c35_19, c35_20, c35_21, c35_22, c35_23, c35_24, c35_25, c35_26, c35_27, c35_28, c35_29, c35_30, c35_31;

    full_adder fa35_4(s35_4, c35_4, c34_3, ~(out_A[31] & out_B[4]), c34_4);
    full_adder fa35_5(s35_5, c35_5, s35_4, (out_A[30] & out_B[5]), c34_5);
    full_adder fa35_6(s35_6, c35_6, s35_5, (out_A[29] & out_B[6]), c34_6);
    full_adder fa35_7(s35_7, c35_7, s35_6, (out_A[28] & out_B[7]), c34_7);
    full_adder fa35_8(s35_8, c35_8, s35_7, (out_A[27] & out_B[8]), c34_8);
    full_adder fa35_9(s35_9, c35_9, s35_8, (out_A[26] & out_B[9]), c34_9);
    full_adder fa35_10(s35_10, c35_10, s35_9, (out_A[25] & out_B[10]), c34_10);
    full_adder fa35_11(s35_11, c35_11, s35_10, (out_A[24] & out_B[11]), c34_11);
    full_adder fa35_12(s35_12, c35_12, s35_11, (out_A[23] & out_B[12]), c34_12);
    full_adder fa35_13(s35_13, c35_13, s35_12, (out_A[22] & out_B[13]), c34_13);
    full_adder fa35_14(s35_14, c35_14, s35_13, (out_A[21] & out_B[14]), c34_14);
    full_adder fa35_15(s35_15, c35_15, s35_14, (out_A[20] & out_B[15]), c34_15);
    full_adder fa35_16(s35_16, c35_16, s35_15, (out_A[19] & out_B[16]), c34_16);
    full_adder fa35_17(s35_17, c35_17, s35_16, (out_A[18] & out_B[17]), c34_17);
    full_adder fa35_18(s35_18, c35_18, s35_17, (out_A[17] & out_B[18]), c34_18);
    full_adder fa35_19(s35_19, c35_19, s35_18, (out_A[16] & out_B[19]), c34_19);
    full_adder fa35_20(s35_20, c35_20, s35_19, (out_A[15] & out_B[20]), c34_20);
    full_adder fa35_21(s35_21, c35_21, s35_20, (out_A[14] & out_B[21]), c34_21);
    full_adder fa35_22(s35_22, c35_22, s35_21, (out_A[13] & out_B[22]), c34_22);
    full_adder fa35_23(s35_23, c35_23, s35_22, (out_A[12] & out_B[23]), c34_23);
    full_adder fa35_24(s35_24, c35_24, s35_23, (out_A[11] & out_B[24]), c34_24);
    full_adder fa35_25(s35_25, c35_25, s35_24, (out_A[10] & out_B[25]), c34_25);
    full_adder fa35_26(s35_26, c35_26, s35_25, (out_A[9] & out_B[26]), c34_26);
    full_adder fa35_27(s35_27, c35_27, s35_26, (out_A[8] & out_B[27]), c34_27);
    full_adder fa35_28(s35_28, c35_28, s35_27, (out_A[7] & out_B[28]), c34_28);
    full_adder fa35_29(s35_29, c35_29, s35_28, (out_A[6] & out_B[29]), c34_29);
    full_adder fa35_30(s35_30, c35_30, s35_29, (out_A[5] & out_B[30]), c34_30);
    full_adder fa35_31(data_result_cont[3], c35_31, s35_30, ~(out_A[4] & out_B[31]), c34_31);

    wire s36_5, s36_6, s36_7, s36_8, s36_9, s36_10, s36_11, s36_12, s36_13, s36_14, s36_15, s36_16, s36_17, s36_18, s36_19, s36_20, s36_21, s36_22, s36_23, s36_24, s36_25, s36_26, s36_27, s36_28, s36_29, s36_30, c36_5, c36_6, c36_7, c36_8, c36_9, c36_10, c36_11, c36_12, c36_13, c36_14, c36_15, c36_16, c36_17, c36_18, c36_19, c36_20, c36_21, c36_22, c36_23, c36_24, c36_25, c36_26, c36_27, c36_28, c36_29, c36_30, c36_31;

    full_adder fa36_5(s36_5, c36_5, c35_4, ~(out_A[31] & out_B[5]), c35_5);
    full_adder fa36_6(s36_6, c36_6, s36_5, (out_A[30] & out_B[6]), c35_6);
    full_adder fa36_7(s36_7, c36_7, s36_6, (out_A[29] & out_B[7]), c35_7);
    full_adder fa36_8(s36_8, c36_8, s36_7, (out_A[28] & out_B[8]), c35_8);
    full_adder fa36_9(s36_9, c36_9, s36_8, (out_A[27] & out_B[9]), c35_9);
    full_adder fa36_10(s36_10, c36_10, s36_9, (out_A[26] & out_B[10]), c35_10);
    full_adder fa36_11(s36_11, c36_11, s36_10, (out_A[25] & out_B[11]), c35_11);
    full_adder fa36_12(s36_12, c36_12, s36_11, (out_A[24] & out_B[12]), c35_12);
    full_adder fa36_13(s36_13, c36_13, s36_12, (out_A[23] & out_B[13]), c35_13);
    full_adder fa36_14(s36_14, c36_14, s36_13, (out_A[22] & out_B[14]), c35_14);
    full_adder fa36_15(s36_15, c36_15, s36_14, (out_A[21] & out_B[15]), c35_15);
    full_adder fa36_16(s36_16, c36_16, s36_15, (out_A[20] & out_B[16]), c35_16);
    full_adder fa36_17(s36_17, c36_17, s36_16, (out_A[19] & out_B[17]), c35_17);
    full_adder fa36_18(s36_18, c36_18, s36_17, (out_A[18] & out_B[18]), c35_18);
    full_adder fa36_19(s36_19, c36_19, s36_18, (out_A[17] & out_B[19]), c35_19);
    full_adder fa36_20(s36_20, c36_20, s36_19, (out_A[16] & out_B[20]), c35_20);
    full_adder fa36_21(s36_21, c36_21, s36_20, (out_A[15] & out_B[21]), c35_21);
    full_adder fa36_22(s36_22, c36_22, s36_21, (out_A[14] & out_B[22]), c35_22);
    full_adder fa36_23(s36_23, c36_23, s36_22, (out_A[13] & out_B[23]), c35_23);
    full_adder fa36_24(s36_24, c36_24, s36_23, (out_A[12] & out_B[24]), c35_24);
    full_adder fa36_25(s36_25, c36_25, s36_24, (out_A[11] & out_B[25]), c35_25);
    full_adder fa36_26(s36_26, c36_26, s36_25, (out_A[10] & out_B[26]), c35_26);
    full_adder fa36_27(s36_27, c36_27, s36_26, (out_A[9] & out_B[27]), c35_27);
    full_adder fa36_28(s36_28, c36_28, s36_27, (out_A[8] & out_B[28]), c35_28);
    full_adder fa36_29(s36_29, c36_29, s36_28, (out_A[7] & out_B[29]), c35_29);
    full_adder fa36_30(s36_30, c36_30, s36_29, (out_A[6] & out_B[30]), c35_30);
    full_adder fa36_31(data_result_cont[4], c36_31, s36_30, ~(out_A[5] & out_B[31]), c35_31);

    wire s37_6, s37_7, s37_8, s37_9, s37_10, s37_11, s37_12, s37_13, s37_14, s37_15, s37_16, s37_17, s37_18, s37_19, s37_20, s37_21, s37_22, s37_23, s37_24, s37_25, s37_26, s37_27, s37_28, s37_29, s37_30, c37_6, c37_7, c37_8, c37_9, c37_10, c37_11, c37_12, c37_13, c37_14, c37_15, c37_16, c37_17, c37_18, c37_19, c37_20, c37_21, c37_22, c37_23, c37_24, c37_25, c37_26, c37_27, c37_28, c37_29, c37_30, c37_31;

    full_adder fa37_6(s37_6, c37_6, c36_5, ~(out_A[31] & out_B[6]), c36_6);
    full_adder fa37_7(s37_7, c37_7, s37_6, (out_A[30] & out_B[7]), c36_7);
    full_adder fa37_8(s37_8, c37_8, s37_7, (out_A[29] & out_B[8]), c36_8);
    full_adder fa37_9(s37_9, c37_9, s37_8, (out_A[28] & out_B[9]), c36_9);
    full_adder fa37_10(s37_10, c37_10, s37_9, (out_A[27] & out_B[10]), c36_10);
    full_adder fa37_11(s37_11, c37_11, s37_10, (out_A[26] & out_B[11]), c36_11);
    full_adder fa37_12(s37_12, c37_12, s37_11, (out_A[25] & out_B[12]), c36_12);
    full_adder fa37_13(s37_13, c37_13, s37_12, (out_A[24] & out_B[13]), c36_13);
    full_adder fa37_14(s37_14, c37_14, s37_13, (out_A[23] & out_B[14]), c36_14);
    full_adder fa37_15(s37_15, c37_15, s37_14, (out_A[22] & out_B[15]), c36_15);
    full_adder fa37_16(s37_16, c37_16, s37_15, (out_A[21] & out_B[16]), c36_16);
    full_adder fa37_17(s37_17, c37_17, s37_16, (out_A[20] & out_B[17]), c36_17);
    full_adder fa37_18(s37_18, c37_18, s37_17, (out_A[19] & out_B[18]), c36_18);
    full_adder fa37_19(s37_19, c37_19, s37_18, (out_A[18] & out_B[19]), c36_19);
    full_adder fa37_20(s37_20, c37_20, s37_19, (out_A[17] & out_B[20]), c36_20);
    full_adder fa37_21(s37_21, c37_21, s37_20, (out_A[16] & out_B[21]), c36_21);
    full_adder fa37_22(s37_22, c37_22, s37_21, (out_A[15] & out_B[22]), c36_22);
    full_adder fa37_23(s37_23, c37_23, s37_22, (out_A[14] & out_B[23]), c36_23);
    full_adder fa37_24(s37_24, c37_24, s37_23, (out_A[13] & out_B[24]), c36_24);
    full_adder fa37_25(s37_25, c37_25, s37_24, (out_A[12] & out_B[25]), c36_25);
    full_adder fa37_26(s37_26, c37_26, s37_25, (out_A[11] & out_B[26]), c36_26);
    full_adder fa37_27(s37_27, c37_27, s37_26, (out_A[10] & out_B[27]), c36_27);
    full_adder fa37_28(s37_28, c37_28, s37_27, (out_A[9] & out_B[28]), c36_28);
    full_adder fa37_29(s37_29, c37_29, s37_28, (out_A[8] & out_B[29]), c36_29);
    full_adder fa37_30(s37_30, c37_30, s37_29, (out_A[7] & out_B[30]), c36_30);
    full_adder fa37_31(data_result_cont[5], c37_31, s37_30, ~(out_A[6] & out_B[31]), c36_31);

    wire s38_7, s38_8, s38_9, s38_10, s38_11, s38_12, s38_13, s38_14, s38_15, s38_16, s38_17, s38_18, s38_19, s38_20, s38_21, s38_22, s38_23, s38_24, s38_25, s38_26, s38_27, s38_28, s38_29, s38_30, c38_7, c38_8, c38_9, c38_10, c38_11, c38_12, c38_13, c38_14, c38_15, c38_16, c38_17, c38_18, c38_19, c38_20, c38_21, c38_22, c38_23, c38_24, c38_25, c38_26, c38_27, c38_28, c38_29, c38_30, c38_31;

    full_adder fa38_7(s38_7, c38_7, c37_6, ~(out_A[31] & out_B[7]), c37_7);
    full_adder fa38_8(s38_8, c38_8, s38_7, (out_A[30] & out_B[8]), c37_8);
    full_adder fa38_9(s38_9, c38_9, s38_8, (out_A[29] & out_B[9]), c37_9);
    full_adder fa38_10(s38_10, c38_10, s38_9, (out_A[28] & out_B[10]), c37_10);
    full_adder fa38_11(s38_11, c38_11, s38_10, (out_A[27] & out_B[11]), c37_11);
    full_adder fa38_12(s38_12, c38_12, s38_11, (out_A[26] & out_B[12]), c37_12);
    full_adder fa38_13(s38_13, c38_13, s38_12, (out_A[25] & out_B[13]), c37_13);
    full_adder fa38_14(s38_14, c38_14, s38_13, (out_A[24] & out_B[14]), c37_14);
    full_adder fa38_15(s38_15, c38_15, s38_14, (out_A[23] & out_B[15]), c37_15);
    full_adder fa38_16(s38_16, c38_16, s38_15, (out_A[22] & out_B[16]), c37_16);
    full_adder fa38_17(s38_17, c38_17, s38_16, (out_A[21] & out_B[17]), c37_17);
    full_adder fa38_18(s38_18, c38_18, s38_17, (out_A[20] & out_B[18]), c37_18);
    full_adder fa38_19(s38_19, c38_19, s38_18, (out_A[19] & out_B[19]), c37_19);
    full_adder fa38_20(s38_20, c38_20, s38_19, (out_A[18] & out_B[20]), c37_20);
    full_adder fa38_21(s38_21, c38_21, s38_20, (out_A[17] & out_B[21]), c37_21);
    full_adder fa38_22(s38_22, c38_22, s38_21, (out_A[16] & out_B[22]), c37_22);
    full_adder fa38_23(s38_23, c38_23, s38_22, (out_A[15] & out_B[23]), c37_23);
    full_adder fa38_24(s38_24, c38_24, s38_23, (out_A[14] & out_B[24]), c37_24);
    full_adder fa38_25(s38_25, c38_25, s38_24, (out_A[13] & out_B[25]), c37_25);
    full_adder fa38_26(s38_26, c38_26, s38_25, (out_A[12] & out_B[26]), c37_26);
    full_adder fa38_27(s38_27, c38_27, s38_26, (out_A[11] & out_B[27]), c37_27);
    full_adder fa38_28(s38_28, c38_28, s38_27, (out_A[10] & out_B[28]), c37_28);
    full_adder fa38_29(s38_29, c38_29, s38_28, (out_A[9] & out_B[29]), c37_29);
    full_adder fa38_30(s38_30, c38_30, s38_29, (out_A[8] & out_B[30]), c37_30);
    full_adder fa38_31(data_result_cont[6], c38_31, s38_30, ~(out_A[7] & out_B[31]), c37_31);

    wire s39_8, s39_9, s39_10, s39_11, s39_12, s39_13, s39_14, s39_15, s39_16, s39_17, s39_18, s39_19, s39_20, s39_21, s39_22, s39_23, s39_24, s39_25, s39_26, s39_27, s39_28, s39_29, s39_30, c39_8, c39_9, c39_10, c39_11, c39_12, c39_13, c39_14, c39_15, c39_16, c39_17, c39_18, c39_19, c39_20, c39_21, c39_22, c39_23, c39_24, c39_25, c39_26, c39_27, c39_28, c39_29, c39_30, c39_31;

    full_adder fa39_8(s39_8, c39_8, c38_7, ~(out_A[31] & out_B[8]), c38_8);
    full_adder fa39_9(s39_9, c39_9, s39_8, (out_A[30] & out_B[9]), c38_9);
    full_adder fa39_10(s39_10, c39_10, s39_9, (out_A[29] & out_B[10]), c38_10);
    full_adder fa39_11(s39_11, c39_11, s39_10, (out_A[28] & out_B[11]), c38_11);
    full_adder fa39_12(s39_12, c39_12, s39_11, (out_A[27] & out_B[12]), c38_12);
    full_adder fa39_13(s39_13, c39_13, s39_12, (out_A[26] & out_B[13]), c38_13);
    full_adder fa39_14(s39_14, c39_14, s39_13, (out_A[25] & out_B[14]), c38_14);
    full_adder fa39_15(s39_15, c39_15, s39_14, (out_A[24] & out_B[15]), c38_15);
    full_adder fa39_16(s39_16, c39_16, s39_15, (out_A[23] & out_B[16]), c38_16);
    full_adder fa39_17(s39_17, c39_17, s39_16, (out_A[22] & out_B[17]), c38_17);
    full_adder fa39_18(s39_18, c39_18, s39_17, (out_A[21] & out_B[18]), c38_18);
    full_adder fa39_19(s39_19, c39_19, s39_18, (out_A[20] & out_B[19]), c38_19);
    full_adder fa39_20(s39_20, c39_20, s39_19, (out_A[19] & out_B[20]), c38_20);
    full_adder fa39_21(s39_21, c39_21, s39_20, (out_A[18] & out_B[21]), c38_21);
    full_adder fa39_22(s39_22, c39_22, s39_21, (out_A[17] & out_B[22]), c38_22);
    full_adder fa39_23(s39_23, c39_23, s39_22, (out_A[16] & out_B[23]), c38_23);
    full_adder fa39_24(s39_24, c39_24, s39_23, (out_A[15] & out_B[24]), c38_24);
    full_adder fa39_25(s39_25, c39_25, s39_24, (out_A[14] & out_B[25]), c38_25);
    full_adder fa39_26(s39_26, c39_26, s39_25, (out_A[13] & out_B[26]), c38_26);
    full_adder fa39_27(s39_27, c39_27, s39_26, (out_A[12] & out_B[27]), c38_27);
    full_adder fa39_28(s39_28, c39_28, s39_27, (out_A[11] & out_B[28]), c38_28);
    full_adder fa39_29(s39_29, c39_29, s39_28, (out_A[10] & out_B[29]), c38_29);
    full_adder fa39_30(s39_30, c39_30, s39_29, (out_A[9] & out_B[30]), c38_30);
    full_adder fa39_31(data_result_cont[7], c39_31, s39_30, ~(out_A[8] & out_B[31]), c38_31);

    wire s40_9, s40_10, s40_11, s40_12, s40_13, s40_14, s40_15, s40_16, s40_17, s40_18, s40_19, s40_20, s40_21, s40_22, s40_23, s40_24, s40_25, s40_26, s40_27, s40_28, s40_29, s40_30, c40_9, c40_10, c40_11, c40_12, c40_13, c40_14, c40_15, c40_16, c40_17, c40_18, c40_19, c40_20, c40_21, c40_22, c40_23, c40_24, c40_25, c40_26, c40_27, c40_28, c40_29, c40_30, c40_31;

    full_adder fa40_9(s40_9, c40_9, c39_8, ~(out_A[31] & out_B[9]), c39_9);
    full_adder fa40_10(s40_10, c40_10, s40_9, (out_A[30] & out_B[10]), c39_10);
    full_adder fa40_11(s40_11, c40_11, s40_10, (out_A[29] & out_B[11]), c39_11);
    full_adder fa40_12(s40_12, c40_12, s40_11, (out_A[28] & out_B[12]), c39_12);
    full_adder fa40_13(s40_13, c40_13, s40_12, (out_A[27] & out_B[13]), c39_13);
    full_adder fa40_14(s40_14, c40_14, s40_13, (out_A[26] & out_B[14]), c39_14);
    full_adder fa40_15(s40_15, c40_15, s40_14, (out_A[25] & out_B[15]), c39_15);
    full_adder fa40_16(s40_16, c40_16, s40_15, (out_A[24] & out_B[16]), c39_16);
    full_adder fa40_17(s40_17, c40_17, s40_16, (out_A[23] & out_B[17]), c39_17);
    full_adder fa40_18(s40_18, c40_18, s40_17, (out_A[22] & out_B[18]), c39_18);
    full_adder fa40_19(s40_19, c40_19, s40_18, (out_A[21] & out_B[19]), c39_19);
    full_adder fa40_20(s40_20, c40_20, s40_19, (out_A[20] & out_B[20]), c39_20);
    full_adder fa40_21(s40_21, c40_21, s40_20, (out_A[19] & out_B[21]), c39_21);
    full_adder fa40_22(s40_22, c40_22, s40_21, (out_A[18] & out_B[22]), c39_22);
    full_adder fa40_23(s40_23, c40_23, s40_22, (out_A[17] & out_B[23]), c39_23);
    full_adder fa40_24(s40_24, c40_24, s40_23, (out_A[16] & out_B[24]), c39_24);
    full_adder fa40_25(s40_25, c40_25, s40_24, (out_A[15] & out_B[25]), c39_25);
    full_adder fa40_26(s40_26, c40_26, s40_25, (out_A[14] & out_B[26]), c39_26);
    full_adder fa40_27(s40_27, c40_27, s40_26, (out_A[13] & out_B[27]), c39_27);
    full_adder fa40_28(s40_28, c40_28, s40_27, (out_A[12] & out_B[28]), c39_28);
    full_adder fa40_29(s40_29, c40_29, s40_28, (out_A[11] & out_B[29]), c39_29);
    full_adder fa40_30(s40_30, c40_30, s40_29, (out_A[10] & out_B[30]), c39_30);
    full_adder fa40_31(data_result_cont[8], c40_31, s40_30, ~(out_A[9] & out_B[31]), c39_31);

    wire s41_10, s41_11, s41_12, s41_13, s41_14, s41_15, s41_16, s41_17, s41_18, s41_19, s41_20, s41_21, s41_22, s41_23, s41_24, s41_25, s41_26, s41_27, s41_28, s41_29, s41_30, c41_10, c41_11, c41_12, c41_13, c41_14, c41_15, c41_16, c41_17, c41_18, c41_19, c41_20, c41_21, c41_22, c41_23, c41_24, c41_25, c41_26, c41_27, c41_28, c41_29, c41_30, c41_31;

    full_adder fa41_10(s41_10, c41_10, c40_9, ~(out_A[31] & out_B[10]), c40_10);
    full_adder fa41_11(s41_11, c41_11, s41_10, (out_A[30] & out_B[11]), c40_11);
    full_adder fa41_12(s41_12, c41_12, s41_11, (out_A[29] & out_B[12]), c40_12);
    full_adder fa41_13(s41_13, c41_13, s41_12, (out_A[28] & out_B[13]), c40_13);
    full_adder fa41_14(s41_14, c41_14, s41_13, (out_A[27] & out_B[14]), c40_14);
    full_adder fa41_15(s41_15, c41_15, s41_14, (out_A[26] & out_B[15]), c40_15);
    full_adder fa41_16(s41_16, c41_16, s41_15, (out_A[25] & out_B[16]), c40_16);
    full_adder fa41_17(s41_17, c41_17, s41_16, (out_A[24] & out_B[17]), c40_17);
    full_adder fa41_18(s41_18, c41_18, s41_17, (out_A[23] & out_B[18]), c40_18);
    full_adder fa41_19(s41_19, c41_19, s41_18, (out_A[22] & out_B[19]), c40_19);
    full_adder fa41_20(s41_20, c41_20, s41_19, (out_A[21] & out_B[20]), c40_20);
    full_adder fa41_21(s41_21, c41_21, s41_20, (out_A[20] & out_B[21]), c40_21);
    full_adder fa41_22(s41_22, c41_22, s41_21, (out_A[19] & out_B[22]), c40_22);
    full_adder fa41_23(s41_23, c41_23, s41_22, (out_A[18] & out_B[23]), c40_23);
    full_adder fa41_24(s41_24, c41_24, s41_23, (out_A[17] & out_B[24]), c40_24);
    full_adder fa41_25(s41_25, c41_25, s41_24, (out_A[16] & out_B[25]), c40_25);
    full_adder fa41_26(s41_26, c41_26, s41_25, (out_A[15] & out_B[26]), c40_26);
    full_adder fa41_27(s41_27, c41_27, s41_26, (out_A[14] & out_B[27]), c40_27);
    full_adder fa41_28(s41_28, c41_28, s41_27, (out_A[13] & out_B[28]), c40_28);
    full_adder fa41_29(s41_29, c41_29, s41_28, (out_A[12] & out_B[29]), c40_29);
    full_adder fa41_30(s41_30, c41_30, s41_29, (out_A[11] & out_B[30]), c40_30);
    full_adder fa41_31(data_result_cont[9], c41_31, s41_30, ~(out_A[10] & out_B[31]), c40_31);

    wire s42_11, s42_12, s42_13, s42_14, s42_15, s42_16, s42_17, s42_18, s42_19, s42_20, s42_21, s42_22, s42_23, s42_24, s42_25, s42_26, s42_27, s42_28, s42_29, s42_30, c42_11, c42_12, c42_13, c42_14, c42_15, c42_16, c42_17, c42_18, c42_19, c42_20, c42_21, c42_22, c42_23, c42_24, c42_25, c42_26, c42_27, c42_28, c42_29, c42_30, c42_31;

    full_adder fa42_11(s42_11, c42_11, c41_10, ~(out_A[31] & out_B[11]), c41_11);
    full_adder fa42_12(s42_12, c42_12, s42_11, (out_A[30] & out_B[12]), c41_12);
    full_adder fa42_13(s42_13, c42_13, s42_12, (out_A[29] & out_B[13]), c41_13);
    full_adder fa42_14(s42_14, c42_14, s42_13, (out_A[28] & out_B[14]), c41_14);
    full_adder fa42_15(s42_15, c42_15, s42_14, (out_A[27] & out_B[15]), c41_15);
    full_adder fa42_16(s42_16, c42_16, s42_15, (out_A[26] & out_B[16]), c41_16);
    full_adder fa42_17(s42_17, c42_17, s42_16, (out_A[25] & out_B[17]), c41_17);
    full_adder fa42_18(s42_18, c42_18, s42_17, (out_A[24] & out_B[18]), c41_18);
    full_adder fa42_19(s42_19, c42_19, s42_18, (out_A[23] & out_B[19]), c41_19);
    full_adder fa42_20(s42_20, c42_20, s42_19, (out_A[22] & out_B[20]), c41_20);
    full_adder fa42_21(s42_21, c42_21, s42_20, (out_A[21] & out_B[21]), c41_21);
    full_adder fa42_22(s42_22, c42_22, s42_21, (out_A[20] & out_B[22]), c41_22);
    full_adder fa42_23(s42_23, c42_23, s42_22, (out_A[19] & out_B[23]), c41_23);
    full_adder fa42_24(s42_24, c42_24, s42_23, (out_A[18] & out_B[24]), c41_24);
    full_adder fa42_25(s42_25, c42_25, s42_24, (out_A[17] & out_B[25]), c41_25);
    full_adder fa42_26(s42_26, c42_26, s42_25, (out_A[16] & out_B[26]), c41_26);
    full_adder fa42_27(s42_27, c42_27, s42_26, (out_A[15] & out_B[27]), c41_27);
    full_adder fa42_28(s42_28, c42_28, s42_27, (out_A[14] & out_B[28]), c41_28);
    full_adder fa42_29(s42_29, c42_29, s42_28, (out_A[13] & out_B[29]), c41_29);
    full_adder fa42_30(s42_30, c42_30, s42_29, (out_A[12] & out_B[30]), c41_30);
    full_adder fa42_31(data_result_cont[10], c42_31, s42_30, ~(out_A[11] & out_B[31]), c41_31);

    wire s43_12, s43_13, s43_14, s43_15, s43_16, s43_17, s43_18, s43_19, s43_20, s43_21, s43_22, s43_23, s43_24, s43_25, s43_26, s43_27, s43_28, s43_29, s43_30, c43_12, c43_13, c43_14, c43_15, c43_16, c43_17, c43_18, c43_19, c43_20, c43_21, c43_22, c43_23, c43_24, c43_25, c43_26, c43_27, c43_28, c43_29, c43_30, c43_31;

    full_adder fa43_12(s43_12, c43_12, c42_11, ~(out_A[31] & out_B[12]), c42_12);
    full_adder fa43_13(s43_13, c43_13, s43_12, (out_A[30] & out_B[13]), c42_13);
    full_adder fa43_14(s43_14, c43_14, s43_13, (out_A[29] & out_B[14]), c42_14);
    full_adder fa43_15(s43_15, c43_15, s43_14, (out_A[28] & out_B[15]), c42_15);
    full_adder fa43_16(s43_16, c43_16, s43_15, (out_A[27] & out_B[16]), c42_16);
    full_adder fa43_17(s43_17, c43_17, s43_16, (out_A[26] & out_B[17]), c42_17);
    full_adder fa43_18(s43_18, c43_18, s43_17, (out_A[25] & out_B[18]), c42_18);
    full_adder fa43_19(s43_19, c43_19, s43_18, (out_A[24] & out_B[19]), c42_19);
    full_adder fa43_20(s43_20, c43_20, s43_19, (out_A[23] & out_B[20]), c42_20);
    full_adder fa43_21(s43_21, c43_21, s43_20, (out_A[22] & out_B[21]), c42_21);
    full_adder fa43_22(s43_22, c43_22, s43_21, (out_A[21] & out_B[22]), c42_22);
    full_adder fa43_23(s43_23, c43_23, s43_22, (out_A[20] & out_B[23]), c42_23);
    full_adder fa43_24(s43_24, c43_24, s43_23, (out_A[19] & out_B[24]), c42_24);
    full_adder fa43_25(s43_25, c43_25, s43_24, (out_A[18] & out_B[25]), c42_25);
    full_adder fa43_26(s43_26, c43_26, s43_25, (out_A[17] & out_B[26]), c42_26);
    full_adder fa43_27(s43_27, c43_27, s43_26, (out_A[16] & out_B[27]), c42_27);
    full_adder fa43_28(s43_28, c43_28, s43_27, (out_A[15] & out_B[28]), c42_28);
    full_adder fa43_29(s43_29, c43_29, s43_28, (out_A[14] & out_B[29]), c42_29);
    full_adder fa43_30(s43_30, c43_30, s43_29, (out_A[13] & out_B[30]), c42_30);
    full_adder fa43_31(data_result_cont[11], c43_31, s43_30, ~(out_A[12] & out_B[31]), c42_31);

    wire s44_13, s44_14, s44_15, s44_16, s44_17, s44_18, s44_19, s44_20, s44_21, s44_22, s44_23, s44_24, s44_25, s44_26, s44_27, s44_28, s44_29, s44_30, c44_13, c44_14, c44_15, c44_16, c44_17, c44_18, c44_19, c44_20, c44_21, c44_22, c44_23, c44_24, c44_25, c44_26, c44_27, c44_28, c44_29, c44_30, c44_31;

    full_adder fa44_13(s44_13, c44_13, c43_12, ~(out_A[31] & out_B[13]), c43_13);
    full_adder fa44_14(s44_14, c44_14, s44_13, (out_A[30] & out_B[14]), c43_14);
    full_adder fa44_15(s44_15, c44_15, s44_14, (out_A[29] & out_B[15]), c43_15);
    full_adder fa44_16(s44_16, c44_16, s44_15, (out_A[28] & out_B[16]), c43_16);
    full_adder fa44_17(s44_17, c44_17, s44_16, (out_A[27] & out_B[17]), c43_17);
    full_adder fa44_18(s44_18, c44_18, s44_17, (out_A[26] & out_B[18]), c43_18);
    full_adder fa44_19(s44_19, c44_19, s44_18, (out_A[25] & out_B[19]), c43_19);
    full_adder fa44_20(s44_20, c44_20, s44_19, (out_A[24] & out_B[20]), c43_20);
    full_adder fa44_21(s44_21, c44_21, s44_20, (out_A[23] & out_B[21]), c43_21);
    full_adder fa44_22(s44_22, c44_22, s44_21, (out_A[22] & out_B[22]), c43_22);
    full_adder fa44_23(s44_23, c44_23, s44_22, (out_A[21] & out_B[23]), c43_23);
    full_adder fa44_24(s44_24, c44_24, s44_23, (out_A[20] & out_B[24]), c43_24);
    full_adder fa44_25(s44_25, c44_25, s44_24, (out_A[19] & out_B[25]), c43_25);
    full_adder fa44_26(s44_26, c44_26, s44_25, (out_A[18] & out_B[26]), c43_26);
    full_adder fa44_27(s44_27, c44_27, s44_26, (out_A[17] & out_B[27]), c43_27);
    full_adder fa44_28(s44_28, c44_28, s44_27, (out_A[16] & out_B[28]), c43_28);
    full_adder fa44_29(s44_29, c44_29, s44_28, (out_A[15] & out_B[29]), c43_29);
    full_adder fa44_30(s44_30, c44_30, s44_29, (out_A[14] & out_B[30]), c43_30);
    full_adder fa44_31(data_result_cont[12], c44_31, s44_30, ~(out_A[13] & out_B[31]), c43_31);

    wire s45_14, s45_15, s45_16, s45_17, s45_18, s45_19, s45_20, s45_21, s45_22, s45_23, s45_24, s45_25, s45_26, s45_27, s45_28, s45_29, s45_30, c45_14, c45_15, c45_16, c45_17, c45_18, c45_19, c45_20, c45_21, c45_22, c45_23, c45_24, c45_25, c45_26, c45_27, c45_28, c45_29, c45_30, c45_31;

    full_adder fa45_14(s45_14, c45_14, c44_13, ~(out_A[31] & out_B[14]), c44_14);
    full_adder fa45_15(s45_15, c45_15, s45_14, (out_A[30] & out_B[15]), c44_15);
    full_adder fa45_16(s45_16, c45_16, s45_15, (out_A[29] & out_B[16]), c44_16);
    full_adder fa45_17(s45_17, c45_17, s45_16, (out_A[28] & out_B[17]), c44_17);
    full_adder fa45_18(s45_18, c45_18, s45_17, (out_A[27] & out_B[18]), c44_18);
    full_adder fa45_19(s45_19, c45_19, s45_18, (out_A[26] & out_B[19]), c44_19);
    full_adder fa45_20(s45_20, c45_20, s45_19, (out_A[25] & out_B[20]), c44_20);
    full_adder fa45_21(s45_21, c45_21, s45_20, (out_A[24] & out_B[21]), c44_21);
    full_adder fa45_22(s45_22, c45_22, s45_21, (out_A[23] & out_B[22]), c44_22);
    full_adder fa45_23(s45_23, c45_23, s45_22, (out_A[22] & out_B[23]), c44_23);
    full_adder fa45_24(s45_24, c45_24, s45_23, (out_A[21] & out_B[24]), c44_24);
    full_adder fa45_25(s45_25, c45_25, s45_24, (out_A[20] & out_B[25]), c44_25);
    full_adder fa45_26(s45_26, c45_26, s45_25, (out_A[19] & out_B[26]), c44_26);
    full_adder fa45_27(s45_27, c45_27, s45_26, (out_A[18] & out_B[27]), c44_27);
    full_adder fa45_28(s45_28, c45_28, s45_27, (out_A[17] & out_B[28]), c44_28);
    full_adder fa45_29(s45_29, c45_29, s45_28, (out_A[16] & out_B[29]), c44_29);
    full_adder fa45_30(s45_30, c45_30, s45_29, (out_A[15] & out_B[30]), c44_30);
    full_adder fa45_31(data_result_cont[13], c45_31, s45_30, ~(out_A[14] & out_B[31]), c44_31);

    wire s46_15, s46_16, s46_17, s46_18, s46_19, s46_20, s46_21, s46_22, s46_23, s46_24, s46_25, s46_26, s46_27, s46_28, s46_29, s46_30, c46_15, c46_16, c46_17, c46_18, c46_19, c46_20, c46_21, c46_22, c46_23, c46_24, c46_25, c46_26, c46_27, c46_28, c46_29, c46_30, c46_31;

    full_adder fa46_15(s46_15, c46_15, c45_14, ~(out_A[31] & out_B[15]), c45_15);
    full_adder fa46_16(s46_16, c46_16, s46_15, (out_A[30] & out_B[16]), c45_16);
    full_adder fa46_17(s46_17, c46_17, s46_16, (out_A[29] & out_B[17]), c45_17);
    full_adder fa46_18(s46_18, c46_18, s46_17, (out_A[28] & out_B[18]), c45_18);
    full_adder fa46_19(s46_19, c46_19, s46_18, (out_A[27] & out_B[19]), c45_19);
    full_adder fa46_20(s46_20, c46_20, s46_19, (out_A[26] & out_B[20]), c45_20);
    full_adder fa46_21(s46_21, c46_21, s46_20, (out_A[25] & out_B[21]), c45_21);
    full_adder fa46_22(s46_22, c46_22, s46_21, (out_A[24] & out_B[22]), c45_22);
    full_adder fa46_23(s46_23, c46_23, s46_22, (out_A[23] & out_B[23]), c45_23);
    full_adder fa46_24(s46_24, c46_24, s46_23, (out_A[22] & out_B[24]), c45_24);
    full_adder fa46_25(s46_25, c46_25, s46_24, (out_A[21] & out_B[25]), c45_25);
    full_adder fa46_26(s46_26, c46_26, s46_25, (out_A[20] & out_B[26]), c45_26);
    full_adder fa46_27(s46_27, c46_27, s46_26, (out_A[19] & out_B[27]), c45_27);
    full_adder fa46_28(s46_28, c46_28, s46_27, (out_A[18] & out_B[28]), c45_28);
    full_adder fa46_29(s46_29, c46_29, s46_28, (out_A[17] & out_B[29]), c45_29);
    full_adder fa46_30(s46_30, c46_30, s46_29, (out_A[16] & out_B[30]), c45_30);
    full_adder fa46_31(data_result_cont[14], c46_31, s46_30, ~(out_A[15] & out_B[31]), c45_31);

    wire s47_16, s47_17, s47_18, s47_19, s47_20, s47_21, s47_22, s47_23, s47_24, s47_25, s47_26, s47_27, s47_28, s47_29, s47_30, c47_16, c47_17, c47_18, c47_19, c47_20, c47_21, c47_22, c47_23, c47_24, c47_25, c47_26, c47_27, c47_28, c47_29, c47_30, c47_31;

    full_adder fa47_16(s47_16, c47_16, c46_15, ~(out_A[31] & out_B[16]), c46_16);
    full_adder fa47_17(s47_17, c47_17, s47_16, (out_A[30] & out_B[17]), c46_17);
    full_adder fa47_18(s47_18, c47_18, s47_17, (out_A[29] & out_B[18]), c46_18);
    full_adder fa47_19(s47_19, c47_19, s47_18, (out_A[28] & out_B[19]), c46_19);
    full_adder fa47_20(s47_20, c47_20, s47_19, (out_A[27] & out_B[20]), c46_20);
    full_adder fa47_21(s47_21, c47_21, s47_20, (out_A[26] & out_B[21]), c46_21);
    full_adder fa47_22(s47_22, c47_22, s47_21, (out_A[25] & out_B[22]), c46_22);
    full_adder fa47_23(s47_23, c47_23, s47_22, (out_A[24] & out_B[23]), c46_23);
    full_adder fa47_24(s47_24, c47_24, s47_23, (out_A[23] & out_B[24]), c46_24);
    full_adder fa47_25(s47_25, c47_25, s47_24, (out_A[22] & out_B[25]), c46_25);
    full_adder fa47_26(s47_26, c47_26, s47_25, (out_A[21] & out_B[26]), c46_26);
    full_adder fa47_27(s47_27, c47_27, s47_26, (out_A[20] & out_B[27]), c46_27);
    full_adder fa47_28(s47_28, c47_28, s47_27, (out_A[19] & out_B[28]), c46_28);
    full_adder fa47_29(s47_29, c47_29, s47_28, (out_A[18] & out_B[29]), c46_29);
    full_adder fa47_30(s47_30, c47_30, s47_29, (out_A[17] & out_B[30]), c46_30);
    full_adder fa47_31(data_result_cont[15], c47_31, s47_30, ~(out_A[16] & out_B[31]), c46_31);

    wire s48_17, s48_18, s48_19, s48_20, s48_21, s48_22, s48_23, s48_24, s48_25, s48_26, s48_27, s48_28, s48_29, s48_30, c48_17, c48_18, c48_19, c48_20, c48_21, c48_22, c48_23, c48_24, c48_25, c48_26, c48_27, c48_28, c48_29, c48_30, c48_31;

    full_adder fa48_17(s48_17, c48_17, c47_16, ~(out_A[31] & out_B[17]), c47_17);
    full_adder fa48_18(s48_18, c48_18, s48_17, (out_A[30] & out_B[18]), c47_18);
    full_adder fa48_19(s48_19, c48_19, s48_18, (out_A[29] & out_B[19]), c47_19);
    full_adder fa48_20(s48_20, c48_20, s48_19, (out_A[28] & out_B[20]), c47_20);
    full_adder fa48_21(s48_21, c48_21, s48_20, (out_A[27] & out_B[21]), c47_21);
    full_adder fa48_22(s48_22, c48_22, s48_21, (out_A[26] & out_B[22]), c47_22);
    full_adder fa48_23(s48_23, c48_23, s48_22, (out_A[25] & out_B[23]), c47_23);
    full_adder fa48_24(s48_24, c48_24, s48_23, (out_A[24] & out_B[24]), c47_24);
    full_adder fa48_25(s48_25, c48_25, s48_24, (out_A[23] & out_B[25]), c47_25);
    full_adder fa48_26(s48_26, c48_26, s48_25, (out_A[22] & out_B[26]), c47_26);
    full_adder fa48_27(s48_27, c48_27, s48_26, (out_A[21] & out_B[27]), c47_27);
    full_adder fa48_28(s48_28, c48_28, s48_27, (out_A[20] & out_B[28]), c47_28);
    full_adder fa48_29(s48_29, c48_29, s48_28, (out_A[19] & out_B[29]), c47_29);
    full_adder fa48_30(s48_30, c48_30, s48_29, (out_A[18] & out_B[30]), c47_30);
    full_adder fa48_31(data_result_cont[16], c48_31, s48_30, ~(out_A[17] & out_B[31]), c47_31);

    wire s49_18, s49_19, s49_20, s49_21, s49_22, s49_23, s49_24, s49_25, s49_26, s49_27, s49_28, s49_29, s49_30, c49_18, c49_19, c49_20, c49_21, c49_22, c49_23, c49_24, c49_25, c49_26, c49_27, c49_28, c49_29, c49_30, c49_31;

    full_adder fa49_18(s49_18, c49_18, c48_17, ~(out_A[31] & out_B[18]), c48_18);
    full_adder fa49_19(s49_19, c49_19, s49_18, (out_A[30] & out_B[19]), c48_19);
    full_adder fa49_20(s49_20, c49_20, s49_19, (out_A[29] & out_B[20]), c48_20);
    full_adder fa49_21(s49_21, c49_21, s49_20, (out_A[28] & out_B[21]), c48_21);
    full_adder fa49_22(s49_22, c49_22, s49_21, (out_A[27] & out_B[22]), c48_22);
    full_adder fa49_23(s49_23, c49_23, s49_22, (out_A[26] & out_B[23]), c48_23);
    full_adder fa49_24(s49_24, c49_24, s49_23, (out_A[25] & out_B[24]), c48_24);
    full_adder fa49_25(s49_25, c49_25, s49_24, (out_A[24] & out_B[25]), c48_25);
    full_adder fa49_26(s49_26, c49_26, s49_25, (out_A[23] & out_B[26]), c48_26);
    full_adder fa49_27(s49_27, c49_27, s49_26, (out_A[22] & out_B[27]), c48_27);
    full_adder fa49_28(s49_28, c49_28, s49_27, (out_A[21] & out_B[28]), c48_28);
    full_adder fa49_29(s49_29, c49_29, s49_28, (out_A[20] & out_B[29]), c48_29);
    full_adder fa49_30(s49_30, c49_30, s49_29, (out_A[19] & out_B[30]), c48_30);
    full_adder fa49_31(data_result_cont[17], c49_31, s49_30, ~(out_A[18] & out_B[31]), c48_31);

    wire s50_19, s50_20, s50_21, s50_22, s50_23, s50_24, s50_25, s50_26, s50_27, s50_28, s50_29, s50_30, c50_19, c50_20, c50_21, c50_22, c50_23, c50_24, c50_25, c50_26, c50_27, c50_28, c50_29, c50_30, c50_31;

    full_adder fa50_19(s50_19, c50_19, c49_18, ~(out_A[31] & out_B[19]), c49_19);
    full_adder fa50_20(s50_20, c50_20, s50_19, (out_A[30] & out_B[20]), c49_20);
    full_adder fa50_21(s50_21, c50_21, s50_20, (out_A[29] & out_B[21]), c49_21);
    full_adder fa50_22(s50_22, c50_22, s50_21, (out_A[28] & out_B[22]), c49_22);
    full_adder fa50_23(s50_23, c50_23, s50_22, (out_A[27] & out_B[23]), c49_23);
    full_adder fa50_24(s50_24, c50_24, s50_23, (out_A[26] & out_B[24]), c49_24);
    full_adder fa50_25(s50_25, c50_25, s50_24, (out_A[25] & out_B[25]), c49_25);
    full_adder fa50_26(s50_26, c50_26, s50_25, (out_A[24] & out_B[26]), c49_26);
    full_adder fa50_27(s50_27, c50_27, s50_26, (out_A[23] & out_B[27]), c49_27);
    full_adder fa50_28(s50_28, c50_28, s50_27, (out_A[22] & out_B[28]), c49_28);
    full_adder fa50_29(s50_29, c50_29, s50_28, (out_A[21] & out_B[29]), c49_29);
    full_adder fa50_30(s50_30, c50_30, s50_29, (out_A[20] & out_B[30]), c49_30);
    full_adder fa50_31(data_result_cont[18], c50_31, s50_30, ~(out_A[19] & out_B[31]), c49_31);

    wire s51_20, s51_21, s51_22, s51_23, s51_24, s51_25, s51_26, s51_27, s51_28, s51_29, s51_30, c51_20, c51_21, c51_22, c51_23, c51_24, c51_25, c51_26, c51_27, c51_28, c51_29, c51_30, c51_31;

    full_adder fa51_20(s51_20, c51_20, c50_19, ~(out_A[31] & out_B[20]), c50_20);
    full_adder fa51_21(s51_21, c51_21, s51_20, (out_A[30] & out_B[21]), c50_21);
    full_adder fa51_22(s51_22, c51_22, s51_21, (out_A[29] & out_B[22]), c50_22);
    full_adder fa51_23(s51_23, c51_23, s51_22, (out_A[28] & out_B[23]), c50_23);
    full_adder fa51_24(s51_24, c51_24, s51_23, (out_A[27] & out_B[24]), c50_24);
    full_adder fa51_25(s51_25, c51_25, s51_24, (out_A[26] & out_B[25]), c50_25);
    full_adder fa51_26(s51_26, c51_26, s51_25, (out_A[25] & out_B[26]), c50_26);
    full_adder fa51_27(s51_27, c51_27, s51_26, (out_A[24] & out_B[27]), c50_27);
    full_adder fa51_28(s51_28, c51_28, s51_27, (out_A[23] & out_B[28]), c50_28);
    full_adder fa51_29(s51_29, c51_29, s51_28, (out_A[22] & out_B[29]), c50_29);
    full_adder fa51_30(s51_30, c51_30, s51_29, (out_A[21] & out_B[30]), c50_30);
    full_adder fa51_31(data_result_cont[19], c51_31, s51_30, ~(out_A[20] & out_B[31]), c50_31);

    wire s52_21, s52_22, s52_23, s52_24, s52_25, s52_26, s52_27, s52_28, s52_29, s52_30, c52_21, c52_22, c52_23, c52_24, c52_25, c52_26, c52_27, c52_28, c52_29, c52_30, c52_31;

    full_adder fa52_21(s52_21, c52_21, c51_20, ~(out_A[31] & out_B[21]), c51_21);
    full_adder fa52_22(s52_22, c52_22, s52_21, (out_A[30] & out_B[22]), c51_22);
    full_adder fa52_23(s52_23, c52_23, s52_22, (out_A[29] & out_B[23]), c51_23);
    full_adder fa52_24(s52_24, c52_24, s52_23, (out_A[28] & out_B[24]), c51_24);
    full_adder fa52_25(s52_25, c52_25, s52_24, (out_A[27] & out_B[25]), c51_25);
    full_adder fa52_26(s52_26, c52_26, s52_25, (out_A[26] & out_B[26]), c51_26);
    full_adder fa52_27(s52_27, c52_27, s52_26, (out_A[25] & out_B[27]), c51_27);
    full_adder fa52_28(s52_28, c52_28, s52_27, (out_A[24] & out_B[28]), c51_28);
    full_adder fa52_29(s52_29, c52_29, s52_28, (out_A[23] & out_B[29]), c51_29);
    full_adder fa52_30(s52_30, c52_30, s52_29, (out_A[22] & out_B[30]), c51_30);
    full_adder fa52_31(data_result_cont[20], c52_31, s52_30, ~(out_A[21] & out_B[31]), c51_31);

    wire s53_22, s53_23, s53_24, s53_25, s53_26, s53_27, s53_28, s53_29, s53_30, c53_22, c53_23, c53_24, c53_25, c53_26, c53_27, c53_28, c53_29, c53_30, c53_31;

    full_adder fa53_22(s53_22, c53_22, c52_21, ~(out_A[31] & out_B[22]), c52_22);
    full_adder fa53_23(s53_23, c53_23, s53_22, (out_A[30] & out_B[23]), c52_23);
    full_adder fa53_24(s53_24, c53_24, s53_23, (out_A[29] & out_B[24]), c52_24);
    full_adder fa53_25(s53_25, c53_25, s53_24, (out_A[28] & out_B[25]), c52_25);
    full_adder fa53_26(s53_26, c53_26, s53_25, (out_A[27] & out_B[26]), c52_26);
    full_adder fa53_27(s53_27, c53_27, s53_26, (out_A[26] & out_B[27]), c52_27);
    full_adder fa53_28(s53_28, c53_28, s53_27, (out_A[25] & out_B[28]), c52_28);
    full_adder fa53_29(s53_29, c53_29, s53_28, (out_A[24] & out_B[29]), c52_29);
    full_adder fa53_30(s53_30, c53_30, s53_29, (out_A[23] & out_B[30]), c52_30);
    full_adder fa53_31(data_result_cont[21], c53_31, s53_30, ~(out_A[22] & out_B[31]), c52_31);

    wire s54_23, s54_24, s54_25, s54_26, s54_27, s54_28, s54_29, s54_30, c54_23, c54_24, c54_25, c54_26, c54_27, c54_28, c54_29, c54_30, c54_31;

    full_adder fa54_23(s54_23, c54_23, c53_22, ~(out_A[31] & out_B[23]), c53_23);
    full_adder fa54_24(s54_24, c54_24, s54_23, (out_A[30] & out_B[24]), c53_24);
    full_adder fa54_25(s54_25, c54_25, s54_24, (out_A[29] & out_B[25]), c53_25);
    full_adder fa54_26(s54_26, c54_26, s54_25, (out_A[28] & out_B[26]), c53_26);
    full_adder fa54_27(s54_27, c54_27, s54_26, (out_A[27] & out_B[27]), c53_27);
    full_adder fa54_28(s54_28, c54_28, s54_27, (out_A[26] & out_B[28]), c53_28);
    full_adder fa54_29(s54_29, c54_29, s54_28, (out_A[25] & out_B[29]), c53_29);
    full_adder fa54_30(s54_30, c54_30, s54_29, (out_A[24] & out_B[30]), c53_30);
    full_adder fa54_31(data_result_cont[22], c54_31, s54_30, ~(out_A[23] & out_B[31]), c53_31);

    wire s55_24, s55_25, s55_26, s55_27, s55_28, s55_29, s55_30, c55_24, c55_25, c55_26, c55_27, c55_28, c55_29, c55_30, c55_31;

    full_adder fa55_24(s55_24, c55_24, c54_23, ~(out_A[31] & out_B[24]), c54_24);
    full_adder fa55_25(s55_25, c55_25, s55_24, (out_A[30] & out_B[25]), c54_25);
    full_adder fa55_26(s55_26, c55_26, s55_25, (out_A[29] & out_B[26]), c54_26);
    full_adder fa55_27(s55_27, c55_27, s55_26, (out_A[28] & out_B[27]), c54_27);
    full_adder fa55_28(s55_28, c55_28, s55_27, (out_A[27] & out_B[28]), c54_28);
    full_adder fa55_29(s55_29, c55_29, s55_28, (out_A[26] & out_B[29]), c54_29);
    full_adder fa55_30(s55_30, c55_30, s55_29, (out_A[25] & out_B[30]), c54_30);
    full_adder fa55_31(data_result_cont[23], c55_31, s55_30, ~(out_A[24] & out_B[31]), c54_31);

    wire s56_25, s56_26, s56_27, s56_28, s56_29, s56_30, c56_25, c56_26, c56_27, c56_28, c56_29, c56_30, c56_31;

    full_adder fa56_25(s56_25, c56_25, c55_24, ~(out_A[31] & out_B[25]), c55_25);
    full_adder fa56_26(s56_26, c56_26, s56_25, (out_A[30] & out_B[26]), c55_26);
    full_adder fa56_27(s56_27, c56_27, s56_26, (out_A[29] & out_B[27]), c55_27);
    full_adder fa56_28(s56_28, c56_28, s56_27, (out_A[28] & out_B[28]), c55_28);
    full_adder fa56_29(s56_29, c56_29, s56_28, (out_A[27] & out_B[29]), c55_29);
    full_adder fa56_30(s56_30, c56_30, s56_29, (out_A[26] & out_B[30]), c55_30);
    full_adder fa56_31(data_result_cont[24], c56_31, s56_30, ~(out_A[25] & out_B[31]), c55_31);

    wire s57_26, s57_27, s57_28, s57_29, s57_30, c57_26, c57_27, c57_28, c57_29, c57_30, c57_31;

    full_adder fa57_26(s57_26, c57_26, c56_25, ~(out_A[31] & out_B[26]), c56_26);
    full_adder fa57_27(s57_27, c57_27, s57_26, (out_A[30] & out_B[27]), c56_27);
    full_adder fa57_28(s57_28, c57_28, s57_27, (out_A[29] & out_B[28]), c56_28);
    full_adder fa57_29(s57_29, c57_29, s57_28, (out_A[28] & out_B[29]), c56_29);
    full_adder fa57_30(s57_30, c57_30, s57_29, (out_A[27] & out_B[30]), c56_30);
    full_adder fa57_31(data_result_cont[25], c57_31, s57_30, ~(out_A[26] & out_B[31]), c56_31);

    wire s58_27, s58_28, s58_29, s58_30, c58_27, c58_28, c58_29, c58_30, c58_31;

    full_adder fa58_27(s58_27, c58_27, c57_26, ~(out_A[31] & out_B[27]), c57_27);
    full_adder fa58_28(s58_28, c58_28, s58_27, (out_A[30] & out_B[28]), c57_28);
    full_adder fa58_29(s58_29, c58_29, s58_28, (out_A[29] & out_B[29]), c57_29);
    full_adder fa58_30(s58_30, c58_30, s58_29, (out_A[28] & out_B[30]), c57_30);
    full_adder fa58_31(data_result_cont[26], c58_31, s58_30, ~(out_A[27] & out_B[31]), c57_31);

    wire s59_28, s59_29, s59_30, c59_28, c59_29, c59_30, c59_31;

    full_adder fa59_28(s59_28, c59_28, c58_27, ~(out_A[31] & out_B[28]), c58_28);
    full_adder fa59_29(s59_29, c59_29, s59_28, (out_A[30] & out_B[29]), c58_29);
    full_adder fa59_30(s59_30, c59_30, s59_29, (out_A[29] & out_B[30]), c58_30);
    full_adder fa59_31(data_result_cont[27], c59_31, s59_30, ~(out_A[28] & out_B[31]), c58_31);

    wire s60_29, s60_30, c60_29, c60_30, c60_31;

    full_adder fa60_29(s60_29, c60_29, c59_28, ~(out_A[31] & out_B[29]), c59_29);
    full_adder fa60_30(s60_30, c60_30, s60_29, (out_A[30] & out_B[30]), c59_30);
    full_adder fa60_31(data_result_cont[28], c60_31, s60_30, ~(out_A[29] & out_B[31]), c59_31);

    wire s61_30, c61_30, c61_31;

    full_adder fa61_30(s61_30, c61_30, c60_29, ~(out_A[31] & out_B[30]), c60_30);
    full_adder fa61_31(data_result_cont[29], c61_31, s61_30, ~(out_A[30] & out_B[31]), c60_31);

    wire c62_31;

    full_adder fa62_31(data_result_cont[30], c62_31, c61_30, (out_A[31] & out_B[31]), c61_31);

    wire c63_31;

    half_adder ha63_31(data_result_cont[31], c63_31, 1'b1, c62_31);

    wire neg_cont_ovf; 
    assign neg_cont_ovf = (data_result_cont[0] & data_result_cont[1] & data_result_cont[2] & data_result_cont[3] & data_result_cont[4] & data_result_cont[5] & data_result_cont[6] & data_result_cont[7] & data_result_cont[8] & data_result_cont[9] & data_result_cont[10] & data_result_cont[11] & data_result_cont[12] & data_result_cont[13] & data_result_cont[14] & data_result_cont[15] & data_result_cont[16] & data_result_cont[17] & data_result_cont[18] & data_result_cont[19] & data_result_cont[20] & data_result_cont[21] & data_result_cont[22] & data_result_cont[23] & data_result_cont[24] & data_result_cont[25] & data_result_cont[26] & data_result_cont[27] & data_result_cont[28] & data_result_cont[29] & data_result_cont[30] & data_result_cont[31]);

    wire pos_cont_ovf;
    assign pos_cont_ovf = (data_result_cont[0] | data_result_cont[1] | data_result_cont[2] | data_result_cont[3] | data_result_cont[4] | data_result_cont[5] | data_result_cont[6] | data_result_cont[7] | data_result_cont[8] | data_result_cont[9] | data_result_cont[10] | data_result_cont[11] | data_result_cont[12] | data_result_cont[13] | data_result_cont[14] | data_result_cont[15] | data_result_cont[16] | data_result_cont[17] | data_result_cont[18] | data_result_cont[19] | data_result_cont[20] | data_result_cont[21] | data_result_cont[22] | data_result_cont[23] | data_result_cont[24] | data_result_cont[25] | data_result_cont[26] | data_result_cont[27] | data_result_cont[28] | data_result_cont[29] | data_result_cont[30] | data_result_cont[31]);

    wire ovf_from_sig;
    assign ovf_from_sig = ~(neg_cont_ovf | ~pos_cont_ovf);

    wire sign_A, sign_B, sign_result;
    assign sign_A = out_A[31];
    assign sign_B = out_B[31];
    assign sign_result = data_result[31];

    wire ovf_from_sign;
    assign ovf_from_sign = (sign_A & ~sign_B & ~sign_result) | (~sign_A & sign_B & ~sign_result) | (~sign_A & ~sign_B & sign_result) | (sign_A & sign_B & sign_result);

    wire A_zero = out_A[0] | out_A[1] | out_A[2] | out_A[3] | out_A[4] | out_A[5] | out_A[6] | out_A[7] | out_A[8] | out_A[9] | out_A[10] | out_A[11] | out_A[12] | out_A[13] | out_A[14] | out_A[15] | out_A[16] | out_A[17] | out_A[18] | out_A[19] | out_A[20] | out_A[21] | out_A[22] | out_A[23] | out_A[24] | out_A[25] | out_A[26] | out_A[27] | out_A[28] | out_A[29] | out_A[30] | out_A[31];
    wire B_zero = out_B[0] | out_B[1] | out_B[2] | out_B[3] | out_B[4] | out_B[5] | out_B[6] | out_B[7] | out_B[8] | out_B[9] | out_B[10] | out_B[11] | out_B[12] | out_B[13] | out_B[14] | out_B[15] | out_B[16] | out_B[17] | out_B[18] | out_B[19] | out_B[20] | out_B[21] | out_B[22] | out_B[23] | out_B[24] | out_B[25] | out_B[26] | out_B[27] | out_B[28] | out_B[29] | out_B[30] | out_B[31];
    assign ovf = (ovf_from_sig | ovf_from_sign) & A_zero & B_zero;

    // 4 bit
    // 1111 1000 or 0000 1100 don't ovf
    // neg = 1  pos = 0
    // ovf = !(neg | ~pos)

    // true 




endmodule