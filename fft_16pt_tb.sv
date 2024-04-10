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


logic signed [17:0] F0_Re;
logic signed [17:0] F0_Im;
logic signed [17:0] F1_Re;
logic signed [17:0] F1_Im;
logic signed [17:0] F2_Re;
logic signed [17:0] F2_Im;
logic signed [17:0] F3_Re;
logic signed [17:0] F3_Im;

logic signed [17:0] F4_Re;
logic signed [17:0] F4_Im;
logic signed [17:0] F5_Re;
logic signed [17:0] F5_Im;
logic signed [17:0] F6_Re;
logic signed [17:0] F6_Im;
logic signed [17:0] F7_Re;
logic signed [17:0] F7_Im;

logic signed [17:0] F8_Re;
logic signed [17:0] F8_Im;
logic signed [17:0] F9_Re;
logic signed [17:0] F9_Im;
logic signed [17:0] F10_Re;
logic signed [17:0] F10_Im;
logic signed [17:0] F11_Re;
logic signed [17:0] F11_Im;

logic signed [17:0] F12_Re;
logic signed [17:0] F12_Im;
logic signed [17:0] F13_Re;
logic signed [17:0] F13_Im;
logic signed [17:0] F14_Re;
logic signed [17:0] F14_Im;
logic signed [17:0] F15_Re;
logic signed [17:0] F15_Im;

assign F0_Re = F[0][35:18];
assign F0_Im = F[0][17:0];
assign F1_Re = F[1][35:18];
assign F1_Im = F[1][17:0];
assign F2_Re = F[2][35:18];
assign F2_Im = F[2][17:0];
assign F3_Re = F[3][35:18];
assign F3_Im = F[3][17:0];

assign F4_Re = F[4][35:18];
assign F4_Im = F[4][17:0];
assign F5_Re = F[5][35:18];
assign F5_Im = F[5][17:0];
assign F6_Re = F[6][35:18];
assign F6_Im = F[6][17:0];
assign F7_Re = F[7][35:18];
assign F7_Im = F[7][17:0];

assign F8_Re = F[8][35:18];
assign F8_Im = F[8][17:0];
assign F9_Re = F[9][35:18];
assign F9_Im = F[9][17:0];
assign F10_Re = F[10][35:18];
assign F10_Im = F[10][17:0];
assign F11_Re = F[11][35:18];
assign F11_Im = F[11][17:0];

assign F12_Re = F[12][35:18];
assign F12_Im = F[12][17:0];
assign F13_Re = F[13][35:18];
assign F13_Im = F[13][17:0];
assign F14_Re = F[14][35:18];
assign F14_Im = F[14][17:0];
assign F15_Re = F[15][35:18];
assign F15_Im = F[15][17:0];

/*
logic signed [17:0] f0_Re;
logic signed [17:0] f0_Im;
logic signed [17:0] f1_Re;
logic signed [17:0] f1_Im;
logic signed [17:0] f2_Re;
logic signed [17:0] f2_Im;
logic signed [17:0] f3_Re;
logic signed [17:0] f3_Im;

logic signed [17:0] f4_Re;
logic signed [17:0] f4_Im;
logic signed [17:0] f5_Re;
logic signed [17:0] f5_Im;
logic signed [17:0] f6_Re;
logic signed [17:0] f6_Im;
logic signed [17:0] f7_Re;
logic signed [17:0] f7_Im;

assign f0_Re = f[0][35:18];
assign f0_Im = f[0][17:0];
assign f1_Re = f[1][35:18];
assign f1_Im = f[1][17:0];
assign f2_Re = f[2][35:18];
assign f2_Im = f[2][17:0];
assign f3_Re = f[3][35:18];
assign f3_Im = f[3][17:0];

assign f4_Re = f[4][35:18];
assign f4_Im = f[4][17:0];
assign f5_Re = f[5][35:18];
assign f5_Im = f[5][17:0];
assign f6_Re = f[6][35:18];
assign f6_Im = f[6][17:0];
assign f7_Re = f[7][35:18];
assign f7_Im = f[7][17:0];
*/

/*
logic signed [17:0] f_Re [0:15];
logic signed [17:0] f_Im [0:15];
logic signed [17:0] F_Re [0:15];
logic signed [17:0] F_Im [0:15];

assign f_Re[0:15] = f[0:15][35:18];
assign f_Im[0:15] = f[0:15][17:0];
assign F_Re[0:15] = F[0:15][35:18];
assign F_Im[0:15] = F[0:15][17:0];
*/

initial begin
	f[0] = {18'd1000, 18'd0};
	f[1] = {18'd1000, 18'd0};
	f[2] = {18'd0, 18'd0};
	f[3] = {18'd0, 18'd0};
	f[4] = {18'd1000, 18'd0};
	f[5] = {18'd1000, 18'd0};
	f[6] = {18'd0, 18'd0};
	f[7] = {18'd0, 18'd0};
	f[8] = {18'd1000, 18'd0};
	f[9] = {18'd1000, 18'd0};
	f[10] = {18'd0, 18'd0};
	f[11] = {18'd0, 18'd0};
	f[12] = {18'd1000, 18'd0};
	f[13] = {18'd1000, 18'd0};
	f[14] = {18'd0, 18'd0};
	f[15] = {18'd0, 18'd0};
	
	clock = 1'b0;
	reset = 1'b0;
	start = 1'b1;
	
	#10000 $stop;
end

always begin
	#10 clock = ~clock;
end

endmodule