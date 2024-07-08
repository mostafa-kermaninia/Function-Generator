module SrcB_mux(ALUSrc2, RD2, ImmExt, SrcB);
    input ALUSrc2;
    input [31:0] RD2, ImmExt;
    output reg [31:0] SrcB;
    always @(ALUSrc2, RD2, ImmExt) begin
        case (ALUSrc2)
            1'b0: SrcB= RD2;
            1'b1: SrcB= ImmExt;
            default: SrcB=32'd0;
        endcase
    end
endmodule
