`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 10/09/2025 03:52:31 PM
// Design Name: 
// Module Name: Imm_Gen
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

module Imm_Gen(
    input   [31:0] instruction,
    output  reg [31:0] immediate
    );
    
    wire [6:0] opcode = instruction[6:0];
    wire [2:0] funct3 = instruction[14:12];
    wire [6:0] funct7 = instruction[31:25];
    
    // ========== Immediate variants ==========
    wire [31:0] I_imm   = {{20{instruction[31]}}, instruction[31:20]};                        // sign-extend
    wire [31:0] un_I_imm = {20'b0, instruction[31:20]};                                      // zero-extend
    wire [31:0] S_imm   = {{20{instruction[31]}}, instruction[31:25], instruction[11:7]};    // sign-extend
    wire [31:0] B_imm   = {{19{instruction[31]}}, instruction[31], instruction[7], instruction[30:25], instruction[11:8], 1'b0};
    wire [31:0] U_imm   = {instruction[31:12], 12'b0};
    wire [31:0] J_imm   = {{11{instruction[31]}}, instruction[31], instruction[19:12], instruction[20], instruction[30:21], 1'b0};
    wire [31:0] SH_imm  = {27'b0, instruction[24:20]}; // shift amount (zero-extended)
    
    always @(*) begin
        case (opcode)
            `OPCODE_I_TYPE: begin
                case (funct3)
                    3'b001, 3'b101: immediate = SH_imm;      // slli, srli, srai
                    3'b011:          immediate = un_I_imm;   // sltiu (unsigned compare)
                    default:         immediate = I_imm;      // addi, andi, ori, slti
                endcase
            end

            `OPCODE_LOAD: begin
                case (funct3)
                    3'b100, 3'b101: immediate = un_I_imm;    // lbu, lhu (unsigned)
                    default:        immediate = I_imm;       // lb, lh, lw (signed)
                endcase
            end

            `OPCODE_STORE:  immediate = S_imm;

            `OPCODE_BRANCH: immediate = B_imm;

            `OPCODE_JAL:    immediate = J_imm;

            `OPCODE_LUI,
            `OPCODE_AUIPC:  immediate = U_imm;

            // ---- Default ----
            default:        immediate = 32'h0000_0000;
        endcase
    end
    
endmodule
