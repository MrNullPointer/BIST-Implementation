module tb_MISR4bit;  
reg clock,reset;
wire [3:0] dataOut;
reg [3:0] dataIn;
MISR_4bit misr4bit1(dataIn,reset,clock,dataOut);
initial
begin
clock = 1'b0;  
end
always
#5 clock = ~clock;
initial
begin
reset = 1'b1;
#10 reset = 1'b0;
dataIn = 4'b0111;
#10 dataIn = 4'b0000;
#10 dataIn = 4'b1100;
#10 dataIn = 4'b1010;
#10 dataIn = 4'b0111;
#10 dataIn = 4'b0001;
#10 dataIn = 4'b1101;
#10 dataIn = 4'b1010;
end
endmodule
