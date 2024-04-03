`timescale 1ns/1ns

module fft_4pt_tb #(WIDTH=32) (
	output logic signed [WIDTH-1:0] F [3:0],
	output logic done
);

logic signed [31:0] f [3:0];
logic clock;
logic reset;
logic start;

fft_4pt UUT (f, clock, reset, start, F, done);

initial begin
	f[0] = 32'd5;
	f[1] = 32'd6;
	f[2] = 32'd7;
	f[3] = 32'd8;
	
	clock = 1'b0;
	reset = 1'b1;
	start = 1'b1;
	
	#10000 $stop;
end

always begin
	#10 clock = ~clock;
end

endmodule