`timescale 1ns/1ns

module butterfly_unit_tb(
	output logic signed [35:0] ApWB_out,
	output logic signed [35:0] AnWB_out
);

logic signed [17:0] ApWB_re;
logic signed [17:0] ApWB_im;
logic signed [17:0] AnWB_re;
logic signed [17:0] AnWB_im;

assign ApWB_re = ApWB_out[35:18];
assign ApWB_im = ApWB_out[17:0];
assign AnWB_re = AnWB_out[35:18];
assign AnWB_im = AnWB_out[17:0];

localparam signed [35:0] A_re_in = 18'd55 << 17;
localparam signed [35:0] A_im_in = 18'd33;

localparam signed [35:0] B_re_in = 18'd1 << 17;
localparam signed [35:0] B_im_in = 18'd77;

localparam signed [35:0] W_re_in = 18'b010110101000001000 << 17; // 1 / sqrt(2) times 2e15 in binary
localparam signed [35:0] W_im_in = 18'b010110101000001000; // W_re_in and W_im_in must be pre-shifted by 2^15

logic signed [35:0] A_in = A_re_in + A_im_in;
logic signed [35:0] B_in = B_re_in + B_im_in;
logic signed [35:0] W_in = W_re_in + W_im_in;

butterfly_unit UUT (A_in,B_in,W_in,ApWB_out, AnWB_out);



endmodule