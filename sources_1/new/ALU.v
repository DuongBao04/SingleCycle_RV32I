`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 10/09/2025 01:15:34 PM
// Design Name: 
// Module Name: ALU
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

module ALU(
    input   [31:0]  A, B,
    input   [3:0]   ALUControl,
    
    output  [31:0]  ALU_result,
    output          branch_check
    );
    
    wire [31:0] and_result;
    wire [31:0] or_result;
    wire [31:0] add_result;
    wire [31:0] sub_result;
    wire [31:0] xor_result;
    wire [31:0] lls_result;
    wire [31:0] lrs_result;
    wire [31:0] ars_result;
   
    //Carry for sub
    wire Cout;
    
    // For branch instruction
    wire BEQ;
    wire BNE;
    wire BLT;
    wire BGE;
    wire BLTU;
    wire BGEU;
    
    
    assign and_result   = A & B;
    assign or_result    = A | B;
    assign add_result   = A + B;
    assign xor_result   = A ^ B;
    assign lls_result   = A << B;
    assign lrs_result   = A >> B;
    assign ars_result = $signed(A) >>> B; 
    assign {Cout, sub_result} = {1'b0, A} + ~{1'b0, B} + 1'b1; //2's Complement
    
    assign ALU_result   = (ALUControl == `ALU_AND) ? and_result :
                          (ALUControl == `ALU_OR) ? or_result :
                          (ALUControl == `ALU_ADD) ? add_result :
                          (ALUControl == `ALU_XOR) ? xor_result :
                          (ALUControl == `ALU_SUB) ? sub_result :
                          (ALUControl == `ALU_LSHIFT_LEFT) ? lls_result :
                          (ALUControl == `ALU_LSHIFT_RIGHT) ? lrs_result :
                          (ALUControl == `ALU_ASHIFT_RIGHT) ? ars_result : 32'hxxxx_xxxx;
    
    assign BEQ = (ALU_result == 32'b0) ? 1'b1 : 1'b0;
    
    assign BNE = (ALU_result != 32'b0) ? 1'b1 : 1'b0;
    
    assign BLT = (ALU_result[31] == 1'b1) ? 1'b1 : 1'b0;
    
    assign BGE = (ALU_result[31] == 1'b0) ? 1'b1 : 1'b0;
    
    assign BLTU  = ~Cout;    // nếu BLTU là 1 bit thì: assign BLTU = ~Cout;
    assign BGEU  = Cout;
endmodule
