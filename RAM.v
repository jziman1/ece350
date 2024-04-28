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
    output reg [15:0] LED,
    output reg remainder_led,
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
        LED[15:12] <= MemoryArray[5][3:0];
        LED[11:0] <= MemoryArray[6][11:0];
        MemoryArray[5] <= num;
        MemoryArray[10] <= remainder;
        remainder_led <= MemoryArray[7][1:0]; 
        mode <= MemoryArray[11][1:0];       
    end
endmodule
