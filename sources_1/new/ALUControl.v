`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 10/09/2025 02:00:46 PM
// Design Name: 
// Module Name: ALUControl
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
module ALUControl(
    input   [3:0]     ALUOp,
    input   [14:12]   funct3,
    input   [31:25]   funct7,
    
    output reg [3:0] ALUControl
    );
    
    always@(ALUOp or funct3 or funct7) begin
        case(ALUOp)
            //LB, LH, LW, LBU, LHU
            4'b0000: begin ALUControl <= `ALU_ADD; end
            //ADDI, SLTI, SLTIU, XORI, ORI, ANDI, SLLI, SRLI, SRAI
            4'b0001: begin
                case(funct3)
                    //ADDI
                    3'h0: begin ALUControl <= `ALU_ADD; end
                    3'h1: begin
                        if (funct7 == 0) begin ALUControl <= `ALU_LSHIFT_LEFT; end
                        else begin  ALUControl <= 4'bxxxx; end
                    end
                    3'h2: begin ALUControl <= `ALU_SUB; end 
                    3'h3: begin ALUControl <= `ALU_SUB; end
                    3'h4: begin ALUControl <= `ALU_XOR; end
                    3'h5: begin 
                        if (funct7 == 7'h20) begin ALUControl <= `ALU_ASHIFT_RIGHT; end
                        else if (funct7 == 7'h00) begin ALUControl <= `ALU_LSHIFT_RIGHT; end
                        else begin  ALUControl <= 4'bxxxx; end
                    end
                    3'h6: begin ALUControl <= `ALU_OR; end
                    3'h7: begin ALUControl <= `ALU_AND; end
                    default: begin ALUControl <= 4'bxxxx; end
                endcase                
             end
             
             //AUIPC
            4'b0010: begin ALUControl <= `ALU_ADD; end
             
            ////SB, SH, SW
            4'b0011: begin
                if ((funct3 == 3'h0) | (funct3 == 3'h1) | (funct3 == 3'h2)) begin ALUControl <= `ALU_ADD; end
                else begin  ALUControl <= 4'bxxxx; end
             end
             
            //ADD, SUB, SLL, SLT, SLTU, XOR, SRL, SRA, OR, AND
            4'b0100: begin
                case(funct3)
                    // ADD / SUB
                    3'h0: begin 
                        ALUControl <= (funct7 == 7'h00) ? `ALU_ADD : 
                                      (funct7 == 7'h20) ? `ALU_SUB :
                                      4'bxxxx; 
                    end
                    // SLL
                    3'h1: begin 
                        ALUControl <= (funct7 == 7'h00) ? `ALU_LSHIFT_LEFT : 4'bxxxx; 
                    end
                    // SLT
                    3'h2: begin 
                        ALUControl <= (funct7 == 7'h00) ? `ALU_SUB : 4'bxxxx; 
                    end
                    // SLTU
                    3'h3: begin 
                        ALUControl <= (funct7 == 7'h00) ? `ALU_SUB : 4'bxxxx; 
                    end
                    // XOR
                    3'h4: begin 
                        ALUControl <= (funct7 == 7'h00) ? `ALU_XOR : 4'bxxxx; 
                    end
                    // SRL / SRA
                    3'h5: begin 
                        ALUControl <= (funct7 == 7'h00) ? `ALU_LSHIFT_RIGHT : 
                                      (funct7 == 7'h20) ? `ALU_ASHIFT_RIGHT :
                                      4'bxxxx; 
                    end
                    // OR
                    3'h6: begin 
                        ALUControl <= (funct7 == 7'h00) ? `ALU_OR : 4'bxxxx; 
                    end
                    // AND
                    3'h7: begin 
                        ALUControl <= (funct7 == 7'h00) ? `ALU_AND : 4'bxxxx; 
                    end
                    default: begin ALUControl <= 4'bxxxx; end
                endcase
             end
            
            //LUI
            4'b0101: begin ALUControl <= `ALU_LSHIFT_LEFT; end
            
            //BEQ, BNE, BLT, BGE, BLTU, BGEU
            4'b0110: begin ALUControl <= `ALU_SUB; end
            
            //JALR
            4'b0111: begin ALUControl <= `ALU_ADD; end
            
            //JAL
            4'b1000: begin ALUControl <= 4'bxxxx; end
            
            default: begin ALUControl <= 4'bxxxx; end
        endcase
    end
endmodule
