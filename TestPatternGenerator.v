module ML_lfsr(data_out,complete,reset,clock, counter);
input reset;
input clock;
output [8:0] data_out;
output complete;
reg complete; 
reg [8:0] lfsr_reg;		//lfsr_reg is intialized as a 9 bit register
output reg [8:0] counter; 
reg tap;
always@(posedge clock or posedge reset)
begin
   if(reset == 1)
begin
lfsr_reg <= 9'b101001010;   
counter <= 9'b000000000;  //counter has been initialized to 0 and it will start counting up
end
   else
begin
tap = lfsr_reg[8] ^ lfsr_reg[5];   //tapping has been specified here for the operation of LFSR
lfsr_reg[8:0] <= { lfsr_reg[7:0], tap };
counter = counter + 1;
if(counter < 9'b111111110) //until the counter reaches the point 2^n-1, the complete signal is logic low
     complete = 0;
else
      complete = 1; 
end
   end
assign data_out = lfsr_reg;   //the output port data_out has been assigned the final sequence of lfsr_reg 
endmodule
