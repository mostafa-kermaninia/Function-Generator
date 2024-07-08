module ALU (SrcA, SrcB, ALUControl, ALUResult, zero, gte, lt);
    input [31:0] SrcA, SrcB;
    input [2:0] ALUControl;
    output reg [31:0] ALUResult;
    output  zero, gte, lt;
    wire [1:0] comp_mode;
    assign mode_choose= SrcA[31] & SrcB[31];
    always @(SrcA, SrcB, ALUControl) begin
        case (ALUControl)
            3'd0: ALUResult = SrcA+SrcB;
            3'd1: ALUResult = SrcA-SrcB;
            3'd2: ALUResult = SrcA & SrcB;
            3'd3: ALUResult = SrcA | SrcB;
            3'd4: ALUResult = SrcA ^ SrcB;
            3'd5:case (comp_mode)
                1'b0: ALUResult = (SrcA[31] == 1) ? 32'd1 :
				   (SrcB[31] == 1) ? 32'd0 :
				   (SrcA < SrcB) ? 32'd1 : 32'd0;
                1'b1: ALUResult = (SrcA > SrcB) ? 32'd1 : 32'd0; 
            endcase //slt
            3'd6: ALUResult= (SrcA < SrcB) ? 32'd1 : 32'd0; //sltu
            default: ALUResult=32'd0;
        endcase
    end
    assign zero = (ALUResult == 0)? 1'b1 :1'b0; 
    assign gte = (SrcA >= SrcB)? 1'b1 :1'b0;
    assign lt = (SrcA < SrcB)? 1'b1 :1'b0;

endmodule