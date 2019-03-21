`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    22:12:35 05/04/2016 
// Design Name: 
// Module Name:    over_vga_control_module 
// Project Name: 
// Target Devices: 
// Tool versions: 
// Description: 
//
// Dependencies: 
//
// Revision: 
// Revision 0.01 - File Created
// Additional Comments: 
//
//////////////////////////////////////////////////////////////////////////////////
module over_vga_control_module
 (clk, rst_n, over_col_addr_sig, over_row_addr_sig, ready_sig, over_sig,
	over_rom_data, red, green, blue, over_rom_addr, 
	over_red_sig, over_green_sig, over_blue_sig
 );
 input clk;
 input rst_n;
 input[10:0] over_col_addr_sig;
 input[10:0] over_row_addr_sig;
 input ready_sig;
 input over_sig;
 input[16:0] over_rom_data;
 input red;
 input green;
 input blue;
 output[13:0] over_rom_addr;
 output over_red_sig;
 output over_green_sig;
 output over_blue_sig;

 //&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&
 
 reg[8:0] m;
 reg m_avail;
 
 always @ ( posedge clk or negedge rst_n )
   begin
     if( !rst_n )
		begin
			m <= 9'd0;
			m_avail <= 1'd0;
		end
     else if( over_sig && over_row_addr_sig < 104 )
		begin
			m <= over_row_addr_sig[8:0];
			m_avail <= 1'd1;
		end
	 else
		m_avail <= 1'd0;
   end
   
 /**************************************************/
 
 reg[8:0] n;
 reg n_avail;
 
 always @ ( posedge clk or negedge rst_n )
   begin
     if( !rst_n )
		begin
			n <= 9'd0;
			n_avail <= 1'd0;
		end
     else if( over_sig && over_col_addr_sig < 318 )
		begin
			n <= over_col_addr_sig[8:0];
			n_avail <= 1'd1;
		end
	 else
		n_avail <= 1'd0;
   end
   
 /**************************************************/
 
 
 assign over_rom_addr = (m/2)*159 + (n/2);
 assign over_red_sig = (over_sig && m_avail && n_avail) ? over_rom_data[0] : 1'b0;
 assign over_green_sig = 1'b0;
 assign over_blue_sig = 1'b0;
 //assign over_green_sig = (over_sig && m_avail && n_avail ) ? over_rom_data[0] : 1'b0;
 //assign over_blue_sig = (over_sig && m_avail && n_avail ) ? over_rom_data[0] : 1'b0;
 
 
endmodule 