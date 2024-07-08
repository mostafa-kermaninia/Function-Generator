module Result_mux (ResultSrc, ALUres, ReadData, PC4, ImmExt, Result);
    input [1:0]ResultSrc;
    input [31:0] ALUres, ReadData, PC4, ImmExt;
    output reg [31:0] Result;
    always @(ResultSrc, ALUres, ReadData, PC4, ImmExt) begin
        case (ResultSrc)
            2'b00: Result= ALUres;
            2'b01: Result= ReadData;
            2'b10: Result= PC4;
            2'b11: Result= ImmExt;
            default: Result=32'd0;
        endcase
    end
endmodule