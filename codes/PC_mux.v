module PC_mux(PCSrc, PC4, PCImm, ALUres, PCNext);
    input [1:0] PCSrc;
    input [31:0] PC4, PCImm, ALUres;
    output reg [31:0] PCNext;
    always @(PCSrc, PC4, PCImm, ALUres) begin
        case (PCSrc)
            2'b00: PCNext = PC4;
            2'b01: PCNext = PCImm;
            2'b10: PCNext = ALUres;
            default: PCNext = 32'd0;
        endcase
    end
endmodule