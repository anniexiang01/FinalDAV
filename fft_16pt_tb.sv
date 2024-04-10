`timescale 1ns/1ns

module fft_16pt_tb #(WIDTH=36) (
	output logic signed [WIDTH-1:0] F [0:15],
	output logic done,
	output logic clock
);

logic signed [WIDTH-1:0] f [0:15];
logic reset;
logic start;

fft_16pt UUT (f, clock, reset, start, F, done);

// check whether butterfly_unit.sv or butterfly_unit_4pt was being used

initial begin
	f[0] = {16'd100, 16'd0};
	f[1] = {16'd150, 16'd0};
	f[2] = {16'd200, 16'd0};
	f[3] = {16'd250, 16'd0};
	f[4] = {16'd100, 16'd0};
	f[5] = {16'd150, 16'd0};
	f[6] = {16'd200, 16'd0};
	f[7] = {16'd250, 16'd0};
	f[8] = {16'd100, 16'd0};
	f[9] = {16'd150, 16'd0};
	f[10] = {16'd200, 16'd0};
	f[11] = {16'd250, 16'd0};
	f[12] = {16'd100, 16'd0};
	f[13] = {16'd150, 16'd0};
	f[14] = {16'd200, 16'd0};
	f[15] = {16'd250, 16'd0};
	
	clock = 1'b0;
	reset = 1'b0;
	start = 1'b1;
	
	#10000 $stop;
end

always begin
	#10 clock = ~clock;
end

endmodule