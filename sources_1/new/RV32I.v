`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 10/10/2025 10:00:15 PM
// Design Name: 
// Module Name: RV32I
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


module RV32I(
    input clk, reset
    );
    
    // Program Counter
    wire [9:0] PCPlus4;
    wire [9:0] currPC;
    wire [9:0] nextPC;
    
    // Instruction Memory
    wire [31:0] instruction;
    
    // Immediate 32 Generate
    wire [31:0] immediate;
    
    // Control Unit
    wire  branch,MemRead, MemToReg;
    wire  [3:0] ALUOp;
    wire  MemWrite, ALUSrc,RegWrite;
    
    wire [31:0] Write_Data;
    
    wire [3:0] ALUControl;
    wire [31:0] Read_Data1, Read_Data2; 
    
    // ALU
    wire [31:0] ALUop2; 
    wire [31:0] ALU_result;
    wire branch_check;
    
    // Data Memory
    wire [31:0] Read_Data;
    
    // Next PC = PC + 4;
    Add_PC PCAdder (.A(currPC), .B(10'h4), .result(PCPlus4));
    
    assign nextPC = PCPlus4;
    
    Program_Counter PC(.clk(clk), .reset(reset), .nextPC(nextPC), .currPC(currPC));
    
    Instruction_Memory Imm_mem(.reset(reset), .address(currPC), .instruction(instruction));
    
    // Mux at data memory output
    MUX wdta_sel(.op1(ALU_result), .op2(Read_Data), .sel(MemToReg), .out_data(Write_Data));
    
    Register RF(.clk(clk), .reset(reset), .rs1(instruction[19:15]),
                .rs2(instruction[24:20]), .rd(instruction[11:7]),
                .Write_Data(Write_Data), .RegWrite(RegWrite),
                .Read_Data1(Read_Data1), .Read_Data2(Read_Data2));
     
    Imm_Gen Igen32(.instruction(instruction) ,.immediate(immediate));
     
    Control_unit Ctrl(.opcode(instruction[6:0]), .branch(branch),
                        .MemRead(MemRead), .MemToReg(MemToReg),
                        .ALUOp(ALUOp), .MemWrite(MemWrite),
                        .ALUSrc(ALUSrc), .RegWrite(RegWrite));
                        
    ALUControl aluctrl(.ALUOp(ALUOp), .funct3(instruction[14:12]) ,.funct7(instruction[31:25]), .ALUControl(ALUControl));
    
    MUX alu_sel(.op1(Read_Data2) , .op2(immediate), .sel(ALUSrc) , .out_data(ALUop2));
    
    ALU alu(.A(Read_Data1), .B(ALUop2),
            .ALUControl(ALUControl), .ALU_result(ALU_result), .branch_check(branch_check));
    
    Data_Memory DMem(.clk(clk), .reset(reset),
                     .MemWrite(MemWrite), .MemRead(MemRead),
                    .addr(ALU_result) , .write_data(Read_Data2), .read_data(Read_Data));
endmodule
