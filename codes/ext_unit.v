module extension_unit (instruction, ImmSrc, ImmExt);
    input [31:0] instruction;
    input [2:0] ImmSrc;
    output [31:0] ImmExt;
    reg [31:0] ImmExt;
    always @(instruction, ImmSrc) begin
        case (ImmSrc)
            3'd0: ImmExt={{20{instruction[31]}},instruction[31:20]}; //I type
            3'd1: ImmExt={{20{instruction[31]}},instruction[31:25],instruction[11:7]}; //S type
            3'd2: ImmExt={{19{instruction[31]}},instruction[31],instruction[7],instruction[30:25],instruction[11:8],1'b0}; //B type
       	    3'd3: ImmExt={{11{instruction[31]}},instruction[31],instruction[19:12],instruction[20],instruction[30:21],1'b0}; //J type
	    3'd4: ImmExt={instruction[31:12],12'd0}; //U type
            default: ImmExt =32'd0; 
        endcase
    end
    
endmodule
