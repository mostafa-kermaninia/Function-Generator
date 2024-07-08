`timescale 1ns/1ns
module RISC_TB();
	reg clk = 1, rst = 1;
	RISC_V UUT(clk ,rst);
	
	always #50 clk = ~clk;
	initial begin
	#70 rst = 0;
	end
endmodule;