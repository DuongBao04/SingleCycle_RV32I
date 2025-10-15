`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 10/10/2025 06:05:49 PM
// Design Name: 
// Module Name: Data_Memory
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


module Data_Memory(
    input clk, reset,
    input MemRead,
    input MemWrite,
    input   [31:0] addr,
    input   [31:0] write_data,
    output  [31:0] read_data
    );
    
    reg [7:0] memory [0:1023]; // 1024 bytes = 1KB, max of memory can be 2^32 bytes
    integer k;
    
    always@(posedge clk or posedge reset) begin
        if (MemWrite) begin
            memory[addr]     <= write_data[7:0];
            memory[addr+1]   <= write_data[15:8];
            memory[addr+2]   <= write_data[23:16];
            memory[addr+3]   <= write_data[31:24];
        end
        else if (reset) begin
            for (k = 0;k<1024;k = k+ 1) begin
                memory[k] <= 8'b0000_0000;
            end
        end
    end
    
    assign read_data = (MemRead) ? 
                       {memory[addr+3], memory[addr+2], memory[addr+1], memory[addr]} :
                       32'hxxxx_xxxx;
    
endmodule
