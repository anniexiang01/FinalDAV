`timescale 1ns/1ns

module fft_4pt_tb #(WIDTH=32) (
	output logic signed [WIDTH-1:0] F [0:3],
	output logic done,
	output logic clock
);

logic signed [31:0] f [0:3];
logic reset;
logic start;

fft_4pt UUT (f, clock, reset, start, F, done);

initial begin
	f[0] = {16'd100, 16'd0};
	f[1] = {16'd150, 16'd0};
	f[2] = {16'd200, 16'd0};
	f[3] = {16'd250, 16'd0};
	
	clock = 1'b0;
	reset = 1'b0;
	start = 1'b1;
	
	#10000 $stop;
end

always begin
	#10 clock = ~clock;
end

endmodule