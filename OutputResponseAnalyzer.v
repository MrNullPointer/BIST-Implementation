module MISR_4bit(dataIn,reset,clock,dataOut);
input [3:0] dataIn;
input reset,clock;  
output reg [3:0] dataOut;
reg [3:0] misr_temp;
always@(posedge clock or posedge reset)
begin
   if(reset == 1)
dataOut <= 4'b0000;
else
  begin
misr_temp = dataOut;
dataOut[0] = misr_temp[3] ^ dataIn[0];
dataOut[1] = misr_temp[3] ^ misr_temp[0] ^ dataIn[1];
dataOut[2] = misr_temp[1] ^ dataIn[2];
dataOut[3] = misr_temp[2] ^ dataIn[3];
  end
end
endmodule
