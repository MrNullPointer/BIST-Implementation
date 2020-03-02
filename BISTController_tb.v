`timescale 1ns/100ps
module tb_controller_new;
reg [8:0] data_in;
reg clk; //clock
reg rst; //reset
reg finish; //finish flag
reg BIST_mode; //BIST mode
//reg misr_ouput; 
reg [3:0] a,b;
reg [3:0]golden_signature = 4'b0101;
wire [3:0] misr_output;
wire [3:0] result_dut;

controller_new controller_test(clk, rst, BIST_mode, data_in, finish, fault_detected, misr_output, result_dut);

initial
begin 
	clk = 0;
	rst = 1;
	forever #5 clk = ~clk;
end

initial
begin
	forever #8 rst = ~rst;
end


always @(posedge clk)
begin
	BIST_mode = 0;
	a = 4'b0010;
	b = 4'b0101;
	#5 a = 4'b1011;
	#5 b = 4'b1111;
	#5 a = 4'b1011;
	#5 b = 4'b1011;
	#5 a = 4'b1001;
	#5 b = 4'b1110;
	data_in = 9'b 101100110;
	#10 finish = 1;
	#40 BIST_mode = 1;
	#12 data_in = 9'b 001101001;
	#12 data_in = 9'b 101101101;
	#12 data_in = 9'b 001111111;
	#12 data_in = 9'b 111101001;
	#5 a = 4'b1011;
	#5 b = 4'b1111;
	#5 a = 4'b1011;
	#5 b = 4'b1011;
	#5 a = 4'b1001;
	#5 b = 4'b1110;
end
endmodule
