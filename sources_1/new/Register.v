`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 10/09/2025 03:03:44 PM
// Design Name: 
// Module Name: Register
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


module Register(
    input clk, reset,
    input [19:15] rs1,
    input [24:20] rs2,
    input [11:7]  rd,
    input [31:0]  Write_Data,
    input RegWrite,
    
    output [31:0] Read_Data1, Read_Data2
    );
    
    reg [31:0] register [31:0];
    integer k;
    
    assign Read_Data1 = register[rs1];
    assign Read_Data2 = register[rs2];    
    
    always@(posedge clk or Write_Data) begin
        if (reset) begin
            for (k = 0; k < 32; k = k + 1) begin
                register[k] = 32'b0;
            end    
        end
        else if (RegWrite) register[rd] <= Write_Data;
    end  
endmodule
