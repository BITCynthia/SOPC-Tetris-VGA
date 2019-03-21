`timescale 1ns / 1ps
module start_vga_control_module
 (clk, rst_n, ready_col_addr_sig, ready_row_addr_sig, ready_sig, gameready_sig,
  tetris_rom_data, tetris_rom_addr, ready_red_sig, ready_green_sig, ready_blue_sig  
 );
 input clk;
 input rst_n;
 input[10:0] ready_col_addr_sig;
 input[10:0] ready_row_addr_sig;
 input ready_sig;
 input gameready_sig;
 input[16:0] tetris_rom_data;
 output[16:0] tetris_rom_addr;
 output ready_red_sig;
 output ready_green_sig;
 output ready_blue_sig;
 
 
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
     else if( ready_sig && ready_row_addr_sig < 259 )
		begin
			m <= ready_row_addr_sig[8:0];
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
     else if( ready_sig && ready_col_addr_sig < 305 )
		begin
			n <= ready_col_addr_sig[8:0];
			n_avail <= 1'd1;
		end
	 else
		n_avail <= 1'd0;
   end
   
 /**************************************************/
 
 
 assign tetris_rom_addr = m*305 + n;
 //assign ready_red_sig = (ready_sig && gameready_sig && show_block)? tetris_rom_data[0]: 1'b0;
 //assign ready_green_sig = (ready_sig && gameready_sig && show_block)? tetris_rom_data[1]: 1'b0;
 //assign ready_blue_sig = (ready_sig && gameready_sig && show_block)? tetris_rom_data[2]: 1'b0;
 assign ready_red_sig = ( ready_sig && gameready_sig && m_avail && n_avail ) ? ~tetris_rom_data[ 0 ] : 1'b0;
 assign ready_green_sig = ( ready_sig && gameready_sig && m_avail && n_avail ) ? ~tetris_rom_data[ 0 ] : 1'b0;
 assign ready_blue_sig = ( ready_sig && gameready_sig && m_avail && n_avail ) ? ~tetris_rom_data[ 0 ] : 1'b0;
 
 /**************************************************/
 
 
 endmodule
