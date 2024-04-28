`timescale 1ns / 1ps
/**
 * 
 * READ THIS DESCRIPTION:
 *
 * This is the Wrapper module that will serve as the header file combining your processor, 
 * RegFile and Memory elements together.
 *
 * This file will be used to generate the bitstream to upload to the FPGA.
 * We have provided a sibling file, Wrapper_tb.v so that you can test your processor's functionality.
 * 
 * We will be using our own separate Wrapper_tb.v to test your code. You are allowed to make changes to the Wrapper files 
 * for your own individual testing, but we expect your final processor.v and memory modules to work with the 
 * provided Wrapper interface.
 * 
 * Refer to Lab 5 documents for detailed instructions on how to interface 
 * with the memory elements. Each imem and dmem modules will take 12-bit 
 * addresses and will allow for storing of 32-bit values at each address. 
 * Each memory module should receive a single clock. At which edges, is 
 * purely a design choice (and thereby up to you). 
 * 
 * You must change line 36 to add the memory file of the test you created using the assembler
 * For example, you would add sample inside of the quotes on line 38 after assembling sample.s
 *
 **/
module Wrapper (
    input wire CLK100MHZ,
    input wire CPU_RESETN,
    input wire [15:0] SW,
    inout wire [3:0] row,
    inout wire [3:0] col,
    output wire motor_pwm,
    output wire servo_pwm,
    output wire [15:0] LED,
    output wire remainder_led,
    output wire mode);
	
	wire reset;
	assign reset = ~CPU_RESETN;
	
	reg clock = 0;
	always @(posedge CLK100MHZ) begin
        clock <= ~clock;
    end

	wire rwe, mwe;
	wire[4:0] rd, rs1, rs2;
	wire[31:0] instAddr, instData, 
		rData, regA, regB,
		memAddr, memDataIn, memDataOut;

	// ADD YOUR MEMORY FILE HERE
	localparam INSTR_FILE = "final";
	
	// Main Processing Unit
	processor CPU(.clock(clock), .reset(reset), 
								
		// ROM
		.address_imem(instAddr), .q_imem(instData),
									
		// Regfile
		.ctrl_writeEnable(rwe),     .ctrl_writeReg(rd),
		.ctrl_readRegA(rs1),     .ctrl_readRegB(rs2), 
		.data_writeReg(rData), .data_readRegA(regA), .data_readRegB(regB),
									
		// RAM
		.wren(mwe), .address_dmem(memAddr), 
		.data(memDataIn), .q_dmem(memDataOut),
		
		.motor_enable(motor_enable),
		.servo_enable(servo_enable),
		.delayed_remainder_2(remainder)); 
	
	// Instruction Memory (ROM)
	ROM #(.MEMFILE({INSTR_FILE, ".mem"}))
	InstMem(.clk(clock), 
		.addr(instAddr[11:0]), 
		.dataOut(instData));
		
	// Register File
	regfile RegisterFile(.clock(clock), 
		.ctrl_writeEnable(rwe), .ctrl_reset(reset), 
		.ctrl_writeReg(rd),
		.ctrl_readRegA(rs1), .ctrl_readRegB(rs2), 
		.data_writeReg(rData), .data_readRegA(regA), .data_readRegB(regB));
						
	// Processor Memory (RAM)
	RAM ProcMem(.clk(clock), 
		.wEn(mwe), 
		.addr(memAddr[11:0]), 
		.dataIn(memDataIn), 
		.dataOut(memDataOut),
		.SW(SW),
		.LED(LED),
		.motor_enable(old_motor_enable), // not used
		.servo_enable(old_servo_enable), // not used
		.num(num),
		.servo_time(servo_time),
		.remainder(remainder),
		.remainder_led(remainder_led),
		.mode(mode));

    // remainder contains remainder (store in memory for desired use)
    // remainder_led controls the LED
	wire [31:0] remainder;
		
	wire old_motor_enable;
	wire [6:0] motor_duty_cycle;
	assign motor_duty_cycle = 7'd40; // 1-100
	
    MotorPWMSerializer motor(.clk(clock),
        .reset(motor_enable), // 1 is enable
        .duty_cycle(motor_duty_cycle),
        .signal(motor_pwm));
 
 	wire old_servo_enable;
	wire [19:0] servo_duty_cycle;
	assign servo_duty_cycle = 20'd100000; //  // 1 to 1,000,000
	
    ServoPWMSerializer servo(.clk(clock),
        .reset(~servo_enable), // 0 is enable
        .duty_cycle(servo_duty_cycle),
        .signal(servo_pwm));
       
    wire [3:0] num;
    keypad number(clock, col, row, num);
    
    wire [31:0] servo_time;
    wire servo_enable, motor_enable;

endmodule
