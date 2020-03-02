module tb_ML_lfsr;
reg clock,reset;  
wire [8:0] dt_out;
wire [8:0] counter;
ML_lfsr lfsr1(dt_out, complete, reset, clock,counter);
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
end
endmodule
