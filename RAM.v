// Switch: MemoryArray[1]
// LED:  MemoryArray[2]
// Motor enable: MemoryArray[3]
// Servo: MemoryArray[4]
// Numpad: MemoryArray[5]
// Servo Time: MemoryArray[6]
// Continue: MemoryArray[7]


`timescale 1ns / 1ps
module RAM #( parameter DATA_WIDTH = 32, ADDRESS_WIDTH = 12, DEPTH = 20) (
    input wire                     clk,
    input wire                     wEn,
    input wire [ADDRESS_WIDTH-1:0] addr,
    input wire [DATA_WIDTH-1:0]    dataIn,
    output reg [DATA_WIDTH-1:0]    dataOut = 0,
    input wire [15:0] SW,
    input wire [3:0] num,
    input wire [31:0] remainder,
    output reg servo_enable,
    output reg [15:0] LED,
    output reg motor_enable,
    output reg remainder_led,
    output reg [31:0] servo_time,
    output reg mode);
    
    reg[DATA_WIDTH-1:0] MemoryArray[0:DEPTH-1];
    
    integer i;
    initial begin
        for (i = 0; i < DEPTH; i = i + 1) begin
            MemoryArray[i] <= 0;
        end
        // if(MEMFILE > 0) begin
        //     $readmemh(MEMFILE, MemoryArray);
        // end
    end
    
    wire [31:0] SW_final;
    assign SW_final[31:16] = 16'b0;
    assign SW_final[15:0] = SW;
    
    always @(posedge clk) begin
        if(wEn) begin
            MemoryArray[addr] <= dataIn;
        end else begin
            dataOut <= MemoryArray[addr];
        end
     //   MemoryArray[8] <= SW_final;
        LED[15:12] <= MemoryArray[5][3:0];
        LED[11:0] <= MemoryArray[6][11:0];
        //LED <= MemoryArray[10][15:0];
       // motor_enable <= MemoryArray[3][1:0]; // 1 to enable motor, 0 to disable
        //servo_enable <= MemoryArray[4][1:0]; // 1 to enable servo, 0 to disable
        MemoryArray[5] <= num;
        //servo_time <= MemoryArray[6][31:0];
        MemoryArray[10] <= remainder;
        remainder_led <= MemoryArray[7][1:0]; 
        mode <= MemoryArray[11][1:0];       
    end
endmodule
