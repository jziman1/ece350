`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 04/12/2024 01:19:19 PM
// Design Name: 
// Module Name: keypad
// Project Name: 
// Target Devices: 
// Tool Versions: 
// Description: 
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////


module keypad(
    input wire clk,
    inout wire [3:0] col_a,
    inout wire [3:0] row_a,
    output reg [3:0] num
    );
    reg [3:0] row, col, key;
    assign row_a = row;
    assign col_a = col;
   integer i;
   
   initial begin
        key = 4'd3;
   end

   integer row_num, col_num;
   always @(posedge clk) begin
  
            if(col[0] == 0) begin
                col_num = 0;
            end
            else if(col[1] == 0) begin
                col_num = 1;
            end
            else if(col[2] == 0) begin
                col_num = 2;
            end
            else if(col[3] == 0) begin
                col_num = 3;
            end else begin
                col_num = 3; // Map to 15 which gets converted to 3
            end

            if(row[0] == 0) begin
                row_num = 0;
            end
            else if(row[1] == 0) begin
                row_num = 1;
            end
            else if(row[2] == 0) begin
                row_num = 2;
            end
            else if(row[3] == 0) begin
                row_num = 3;
//            end else begin
//                row_num = 0;
            end
            key = 4*row_num + col_num;
            
        // To match with number
        if (key == 4'd0) begin
            num = 4'd1;
        end else if (key == 4'd1) begin
            num = 4'd2;
        end else if (key == 4'd2) begin
            num = 4'd3;
        end else if (key == 4'd4) begin
            num = 4'd4;       
        end else if (key == 4'd5) begin
            num = 4'd5;
        end else if (key == 4'd6) begin
            num = 4'd6;
        end else if (key == 4'd8) begin
            num = 4'd7;  
        end else if (key == 4'd9) begin
            num = 4'd8;       
        end else if (key == 4'd10) begin
            num = 4'd9;
        end else if (key == 4'd13) begin
            num = 4'd10;
        end else if (key == 4'd15) begin
            num = 4'd0;                                                                           
        end else if (col_num == 3) begin
            num = 4'd0;                                  
        end             
        end
    
endmodule