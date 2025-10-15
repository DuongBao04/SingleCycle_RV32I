`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 10/10/2025 05:45:21 PM
// Design Name: 
// Module Name: Program_Counter
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


module Program_Counter(
    input clk,
    input reset,
    input [9:0] nextPC, //10 bit address -> 2^10 byte of memory
    output reg [9:0] currPC
    );
    
    always @ (posedge clk or posedge reset) begin
        if (reset) begin
            currPC <= 0;
        end
        else begin
            currPC <= nextPC;
        end
    end
endmodule
