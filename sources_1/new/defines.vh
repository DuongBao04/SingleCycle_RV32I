// ============================================================
// RISC-V ALU Control Signal Definitions
// ============================================================

`define ALU_AND             4'b0000   // Logical AND
`define ALU_OR              4'b0001   // Logical OR
`define ALU_ADD             4'b0010   // Addition
`define ALU_SUB             4'b0011   // Subtraction
`define ALU_LSHIFT_LEFT     4'b0100   // Logical Shift Left
`define ALU_LSHIFT_RIGHT    4'b0101   // Logical Shift Right
`define ALU_ASHIFT_RIGHT    4'b0110   // Arithmetic Shift Right
`define ALU_XOR             4'b0111   // Subtraction

// ============================================================
//  RISC-V Base ISA Opcode Definitions
// ============================================================

`define OPCODE_R_TYPE      7'b011_0011   // ADD, SUB, AND, OR, SLT, ...
`define OPCODE_I_TYPE      7'b001_0011   // ADDI, ANDI, ORI, SLTI, SLLI, SRLI, SRAI
`define OPCODE_LOAD        7'b000_0011   // LB, LH, LW, LBU, LHU
`define OPCODE_STORE       7'b010_0011   // SB, SH, SW
`define OPCODE_BRANCH      7'b110_0011   // BEQ, BNE, BLT, BGE, BLTU, BGEU
`define OPCODE_JAL         7'b110_1111   // JAL (Jump and Link)
`define OPCODE_JALR        7'b110_0111   // JALR (Jump and Link Register)
`define OPCODE_LUI         7'b011_0111   // LUI (Load Upper Immediate)
`define OPCODE_AUIPC       7'b001_0111   // AUIPC (Add Upper Immediate to PC)
`define OPCODE_FENCE       7'b000_1111   // FENCE, FENCE.I
`define OPCODE_SYSTEM      7'b111_0011   // ECALL, EBREAK, CSR instructions
