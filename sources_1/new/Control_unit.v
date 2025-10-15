`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 10/09/2025 02:29:55 PM
// Design Name: 
// Module Name: Control_unit
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

`include "defines.vh"
module Control_unit(
    input [6:0] opcode,
    
    output  branch,
    output  MemRead,
    output  MemToReg,
    output  [3:0]ALUOp,
    output  MemWrite,
    output  ALUSrc,
    output  RegWrite
    );
    assign {MemWrite, RegWrite, branch, MemRead, ALUSrc, MemToReg} =  
        (opcode == `OPCODE_LOAD)      ? {1'b0, 1'b1, 1'b0, 1'b1, 1'b1, 1'b1} :         // Load
        (opcode == `OPCODE_I_TYPE)    ? {1'b0, 1'b1, 1'b0, 1'b0, 1'b1, 1'b0} :       // ADDI, ANDI, ORI, ...
        (opcode == `OPCODE_AUIPC)     ? {1'b0, 1'b1, 1'b0, 1'b0, 1'bx, 1'b1} :         // AUIPC
        (opcode == `OPCODE_STORE)     ? {1'b1, 1'b0, 1'b0, 1'b0, 1'b1, 1'bx} :         // Store
        (opcode == `OPCODE_R_TYPE)    ? {1'b0, 1'b1, 1'b0, 1'b0, 1'b0, 1'b0} :         // R-type
        (opcode == `OPCODE_LUI)       ? {1'b0, 1'b1, 1'b0, 1'b0, 1'bx, 1'b0} :         // LUI
        (opcode == `OPCODE_BRANCH)    ? {1'b0, 1'b0, 1'b1, 1'b0, 1'b0, 1'b0} :         // Branch
        (opcode == `OPCODE_JALR)      ? {1'b0, 1'b1, 1'b0, 1'b0, 1'b1, 1'b0} :         // JALR
        (opcode == `OPCODE_JAL)       ? {1'b0, 1'b1, 1'b0, 1'b0, 1'bx, 1'b0} :         // JAL
                                         6'bxx_xxxx;
    
    assign ALUOp =  (opcode == `OPCODE_LOAD)    ? 4'b0000 :
                    (opcode == `OPCODE_I_TYPE)  ? 4'b0001 :
                    (opcode == `OPCODE_AUIPC)   ? 4'b0010 :
                    (opcode == `OPCODE_STORE)   ? 4'b0011 :
                    (opcode == `OPCODE_R_TYPE)  ? 4'b0100 :
                    (opcode == `OPCODE_LUI)     ? 4'b0101 :
                    (opcode == `OPCODE_BRANCH)  ? 4'b0110 :
                    (opcode == `OPCODE_JALR)    ? 4'b0111 :
                    (opcode == `OPCODE_JAL)     ? 4'b1000 : 4'bxxxx;
endmodule
