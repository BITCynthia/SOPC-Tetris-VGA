`timescale 1ns/1ps

module my_pll_tb;

	reg clk, rst_n;
	
	wire clk_25M;

		my_pll	my_pll_inst (
		.areset ( ~rst_n ),
		.inclk0 ( clk ),
		.c0 ( clk_25M )
		);
	
	initial 
		begin
			clk = 1;
			rst_n = 0;
			#200.1
			rst_n = 1;
			
			#1000 $stop;
		end
	
	always #10 clk = ~clk;

endmodule
