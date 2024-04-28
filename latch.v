module latch(outA, outB, outPC, outIR, inA, inB, inPC, inIR, clock, reset, we);

    output[31:0] outA, outB, outPC, outIR;
    input[31:0] inA, inB, inPC, inIR;
    input clock, reset, we;

    register A(outA, we, clock, inA, reset);
    register B(outB, we, clock, inB, reset);
    register PC(outPC, we, clock, inPC, reset);
    register IR(outIR, we, clock, inIR, reset);

endmodule
    