`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 10/10/2025 10:04:46 PM
// Design Name: 
// Module Name: Add_PC
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


module Add_PC(
    input [9:0] A,
    input [9:0] B,
    output [9:0] result
    );
    
    assign result = A + B;
    
endmodule
