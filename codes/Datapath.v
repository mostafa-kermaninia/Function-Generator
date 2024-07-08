`timescale 1ns/1ns
module Datapath(clk, rst, RegWrite, MemWrite, ResultSrc, PCSrc, ALUSrc2, ALUControl,ImmSrc, lt ,bge, zero, opcode, func3, func7);
    input clk, rst, RegWrite, MemWrite, ALUSrc2;
    input[1:0] ResultSrc, PCSrc;
    input[2:0] ALUControl, ImmSrc;
    output [6:0] opcode;
    output lt, bge, zero;
    output[2:0] func3;
    output[6:0] func7;
    

    wire[31:0] ALUResult, PCPlus4, PCTarget, PCNext, PC, instr, Result, WD, RD1, RD2, ImmExt;
    wire[31:0] SrcB, ReadData;
    wire [4:0] A1, A2, A3;

    assign A1 = instr[19:15];
    assign A2 = instr[24:20];
    assign A3 = instr[11:7];
    assign WD = Result;
    assign opcode = instr[6:0];
    assign func3 = instr[14:12];
    assign func7 = instr[31:25];


    PC_mux PCMUX(PCSrc, PCPlus4, PCTarget, Result, PCNext);
    PC_register PCreg(clk, rst, PCNext, PC);
    adder_PC4 PC4(PC, PCPlus4);
    adder_PCimm PCI(PC, ImmExt, PCTarget);


    SrcB_mux SrcB_data (ALUSrc2, RD2,ImmExt, SrcB);
    ALU ALU_UNIT(RD1, SrcB, ALUControl, ALUResult, zero, bge, lt);
    Result_mux RES_M(ResultSrc, ALUResult, ReadData, PCPlus4, ImmExt, Result);

    ext_unit EXTU(instr, ImmSrc, ImmExt);

    instruction_mem inst_mem(PC, instr);
    Register_file Reg_F(clk,rst, RegWrite, A1, A2, A3, WD, RD1, RD2);
    Data_mem DM(ALUResult, RD2, MemWrite, clk, ReadData);

endmodule
