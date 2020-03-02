module controller_new (clk, rst, BIST_mode, data_in, finish, fault_detected, result_dut, misr_output);
input [8:0] data_in;
input clk; //clock
input rst; //reset
input finish; //finish flag
input BIST_mode; //BIST mode
output reg fault_detected; //fault detected flag
wire [3:0] a_dut; //4 bits of 9 bit LFSR output
wire [3:0] b_dut;
wire sel;	  //assign 1 bit of LFSR output to select
wire output_dut; //carry output of DUT 
input [3:0] result_dut; //result of DUT fed to MISR for compaction to compare with the Golden Signature
parameter golden_signature = 4'b0101; // golden signature as derived from the tapping of LFSR bits
output [3:0] misr_output;	//output of the misr
reg [3:0] a,b;

//port-mapping LFSR with controller
ML_lfsr lfsr (.data_out(data_in), .complete(finish), .reset(rst), .clock(clk));

//assignment of data_in bits to different bits of a, b and Sel
assign a_dut = data_in[8:5];
assign b_dut = data_in[4:1];
assign sel = data_in[0];

//port-mapping DUT with controller
AU DUT (.A(a), .B(b), .Sel(sel), .Result(result_dut), .Output(output_dut));

//port-mapping MISR with controller
MISR_4bit MISR (.dataIn(result_dut), .reset(rst), .clock(clk), .dataOut(misr_output));

always @ (posedge clk)
begin
	if(BIST_mode == 0)	//when bist mode is not on, faults can't be detected
	fault_detected = 0;
else
begin
	assign a = a_dut;  //assigning values of a
	assign b = b_dut;  //assigning values of b	 
	if(rst == 1)	  //when reset is high, faults can't be detected
	fault_detected = 0;
	
	else
	begin
	if(finish == 1)
	begin

//match the golden signature with misr_output, if the mtch is found then fault is not detected and fault_detected bit is 0

		if(golden_signature == misr_output) 
		fault_detected = 0;
		else
		fault_detected = 1;
end
end
end
end
endmodule
