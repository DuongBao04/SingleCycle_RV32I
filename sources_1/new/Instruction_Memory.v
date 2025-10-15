`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 10/09/2025 03:22:52 PM
// Design Name: 
// Module Name: Instruction_Memory
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


module Instruction_Memory(
    input  reset,
    input  [9:0] address,
    output [31:0] instruction
    );
    
    reg [7:0] mem [0:1023]; // Max is 2^10
    integer k;
    
    assign instruction = {mem[address + 3], mem[address + 2], mem[address + 1], mem[address]};
    
    always @(posedge reset) begin
        if (reset) begin
            for (k = 0;k<1024;k = k+1) begin
                mem[k] = 8'b0;
            end
        end
    end
    
endmodule
