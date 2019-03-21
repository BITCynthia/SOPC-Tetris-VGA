
`timescale 1ns/1ps
module v_speed_debouncer_tb;
  reg clk, rst_n;
  reg key_n;
  wire click_n;
  
  v_speed_debouncer DUT(.clk(clk), .rst_n(rst_n), .invs(key_n), .outvs(click_n));
  
  initial  
    begin
	   clk = 1;
	   rst_n = 0;
	   key_n = 1;
	   #200.1 rst_n = 1;
	   #200 key_n = 0;
	   #10 key_n = 1;
	   #5 key_n = 0;
	   #80 key_n = 1;
	   #200 key_n = 0;
	   #400 key_n = 1; //key hold time is long enough
	   #10 key_n = 0;
	   #20 key_n = 1;
	   #80 key_n = 0;
	   #200 key_n = 1;
	   #200 	//key hold time is long enough
	   #200 $stop;
  end
  
always #10 clk = ~clk;

endmodule

