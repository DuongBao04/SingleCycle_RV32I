`timescale 1ns / 1ps

module tb_RV32I();
    logic clk;
    logic reset;

    // Instantiate DUT
    RV32I uut(
        .clk(clk),
        .reset(reset)
    );

    // Clock 10ns
    always #5 clk = ~clk;
    
    // Reset 
    initial begin
    clk = 0;
    reset = 1;
    #10 reset = 0; 
    
    // 1. ADDI x1, x0, 0x10  -> x1 = 0x10
    {uut.Imm_mem.mem[3], uut.Imm_mem.mem[2],
     uut.Imm_mem.mem[1], uut.Imm_mem.mem[0]} = 32'h01000093;
     
    // 2. ADDI x2, x1, 0x10 -> x2 = 0x20
    {uut.Imm_mem.mem[7], uut.Imm_mem.mem[6],                
     uut.Imm_mem.mem[5], uut.Imm_mem.mem[4]} = 32'h01008113;
     
    // 3. SUB x3, x2, x1 -> x3 = 0x10
    {uut.Imm_mem.mem[11], uut.Imm_mem.mem[10],                
     uut.Imm_mem.mem[9], uut.Imm_mem.mem[8]} = 32'h401101B3;
     
    // 4. SLL x4, x3, x1 -> x4 = 0x00100000
    {uut.Imm_mem.mem[15], uut.Imm_mem.mem[14],                
     uut.Imm_mem.mem[13], uut.Imm_mem.mem[12]} = 32'h00119233;
     
    // 5. SW x3, 0(x1) -> Mem[x1 + 0] = x3
    {uut.Imm_mem.mem[19], uut.Imm_mem.mem[18],                
     uut.Imm_mem.mem[17], uut.Imm_mem.mem[16]} = 32'h0030A023;
     
    // 6. LW x5, 0(x4) -> x5 = 0x10
    {uut.Imm_mem.mem[23], uut.Imm_mem.mem[22],                
     uut.Imm_mem.mem[21], uut.Imm_mem.mem[20]} = 32'h0000A283;

    #1000;
end

    
endmodule
