module mux_2(out0, select, in0, in1);
    input select;
    input [31:0] in1, in0;
    output [31:0] out0;
    assign out0 = select ? in1 : in0;
endmodule