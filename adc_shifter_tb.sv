`timescale 1ns/1ns

module adc_shifter_tb #(WIDTH=36) (
	output logic signed [WIDTH-1:0] f [0:15],
	output logic clock
);

logic signed [11:0] adc_out = 12'b0;

adc_shifter UUT (clock, adc_out, f);

initial begin
	
	clock = 1'b0;
	
	#10000 $stop;
end

always begin
	#10 clock = ~clock;
end

always @(posedge clock) begin
	adc_out <= adc_out + 1'b1;
end

endmodule