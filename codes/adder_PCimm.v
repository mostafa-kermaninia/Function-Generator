module adder_PCimm(PC, offset, PCTarget);
    input [31:0] PC;
    input [31:0] offset;
    output [31:0] PCTarget;
    wire co;
    assign {co,PCTarget} = PC + offset;
endmodule
