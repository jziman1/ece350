module multdiv(
	data_operandA, data_operandB, 
	ctrl_MULT, ctrl_DIV, 
	clock, 
	data_result, data_exception, data_resultRDY, remainder);

    input [31:0] data_operandA, data_operandB;
    input ctrl_MULT, ctrl_DIV, clock;

    output [31:0] data_result, remainder;
    output data_exception, data_resultRDY;

    wire[31:0] mult_out, d2;
    wire[31:0] div_out, real_div_out;

    wire mult_RDY, div_RDY;
    wire mult_exp, div_exp;

    wallace_multiplier wal(mult_out, mult_exp, mult_RDY, data_operandA, data_operandB, ctrl_MULT, clock, d2);
    divider div(div_out, div_exp, div_RDY, data_operandA, data_operandB, ctrl_DIV, clock, remainder);

    assign real_div_out = div_exp ? 32'b0 : div_out;
    
    wire in_mult;
    dffe_ref dff(in_mult, 1'b1, clock, ctrl_MULT, ctrl_DIV);

    assign data_result = in_mult ? mult_out : real_div_out;
    assign data_resultRDY = in_mult ? mult_RDY : div_RDY;
    assign data_exception = in_mult ? mult_exp : div_exp;



endmodule