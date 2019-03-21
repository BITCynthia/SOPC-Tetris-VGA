`timescale 1ns / 1ps
module show_next(clk,rst_n,col_addr_sig,row_addr_sig,next_c);

input clk;
input rst_n;
input[10:0] col_addr_sig;
input[10:0] row_addr_sig;
output next_c;

reg[12:0] addra;
wire[17:0] next;

reg next_c;
always@(posedge clk or negedge rst_n)
begin
	if(!rst_n)
	begin
		addra<=0;
	end
	else
	begin
		if(col_addr_sig>=12'd100&&col_addr_sig<12'd211&&row_addr_sig>=12'd10&&row_addr_sig<12'd53)
		begin
			addra<=(row_addr_sig-12'd10)*111+col_addr_sig-12'd111;
		end		
	else
		addra<=0;
	end
end

always@(posedge clk or negedge rst_n)
begin
	if(!rst_n)
	begin
		next_c<=0;
	end
	else
	begin
		if(col_addr_sig>=12'd100&&col_addr_sig<12'd211&&row_addr_sig>=12'd10&&row_addr_sig<12'd53)
		begin
			next_c<=~next;
		end		
		else
			next_c<=0;
		end
end


next_rom next_rom (
  .address(addra), // input [12 : 0] addra
  .clock(clk), // input clka
  .q(next) // output [0 : 0] douta
);


endmodule
