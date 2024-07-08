module controller (opcode, func3, func7, zero, bge, lt, 
                    PCSrc, ResultSrc, MemWrite, ALUControl, ALUSrc2, ImmSrc, RegWrite);
    input [6:0] opcode;
    input [2:0] func3;
    input [6:0] func7;
    input zero, bge, lt;
    output reg  MemWrite,RegWrite, ALUSrc2;
    output reg [1:0] PCSrc, ResultSrc;
    output reg [2:0] ALUControl, ImmSrc;
    wire [9:0] function_choose={func7,func3};
    always @(opcode, func3, func7, zero, bge, lt) begin
        {MemWrite, RegWrite} = 2'd0;
        {PCSrc, ResultSrc, ALUSrc2} = 5'd0;
        {ALUControl, ImmSrc} = 6'd0;
        case (opcode)
            	7'd51:begin
		RegWrite=1'b1;
		ALUSrc2=1'b0; 
		ResultSrc=2'b00;
		case (function_choose)
                	0:  ALUControl = 3'b000;   //add
                	256: ALUControl = 3'b001;  //sub
			6: ALUControl = 3'b011; //or
                	7: ALUControl = 3'b010; //and
                	2: ALUControl = 3'b101; //slt
                	3: ALUControl= 3'b110; //sltu
            	endcase 
		end
            	7'd19: begin
			ResultSrc=2'b00;		
			ImmSrc = 3'b000;
		    	RegWrite = 1'b1;
                    	ALUSrc2 = 1'b1;		
			case (func3)
                	3'b000: ALUControl = 3'b000; //addi
                	3'b100: ALUControl =3'b100; //xori
                	3'b110: ALUControl = 3'b011; //ori
                	3'b010: ALUControl = 3'b101; //slti
                	3'b011: ALUControl = 3'b110; //sltui
            		endcase
		end
            	7'd3:begin
		case(func3)
			3'b010:begin
			ImmSrc = 3'b000;
                	ResultSrc=2'b01;
                	ALUSrc2=1'b1;
                	RegWrite=1'b1;
			end
			endcase
            	end          //lw	
            	7'd35:begin
		case(func3)
			3'b010:begin
                		MemWrite=1'b1;
                		ImmSrc=3'b001;
                		ALUSrc2=1'b1;
				ImmSrc = 3'b000;
 				ALUControl = 3'b000;
			end
			endcase
            	end          //sw
		7'd99:begin
			ALUSrc2=1'b0;
			ImmSrc = 3'b010; 
			case (func3)
                	3'b000: begin ALUControl = 3'b001; PCSrc = (zero==1)? 2'b01 : 2'b00; end //beq
                	3'b001: begin ALUControl = 3'b001; PCSrc = (zero==1)? 2'b00 : 2'b01; end //bne
                	3'b100: PCSrc = (lt==1)?  2'b01: 2'b00; //blt
                	3'b101: PCSrc = (bge==1)? 2'b01: 2'b00; //bge
            		endcase
		end
            	7'd55:begin
                	ResultSrc=2'b11;
			ImmSrc= 3'b100;
                	RegWrite= 1'b1;
            	end  //lui
            	7'd111:begin
               		PCSrc=2'b01;
                	ResultSrc=2'b10;
                	ImmSrc=3'b011;
                	RegWrite=1'b1;
            	end  //jal
            	7'd103:begin
			ImmSrc= 3'b000;
			ALUControl = 3'b000;
                	PCSrc=2'b10;
                	ResultSrc=2'b10;
                	RegWrite=1'b1;
               		ALUSrc2=1'b1;
            	end //jalr
        endcase
    end
endmodule