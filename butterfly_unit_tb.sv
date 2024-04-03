`timescale 1ns/1ns

module butterfly_unit_tb(
	output logic signed [31:0] ApWB_out,
	output logic signed [31:0] AnWB_out
);

localparam signed [31:0] A_re_in = 16'd55 << 16;
localparam signed [31:0] A_im_in = 16'd33;

localparam signed [31:0] B_re_in = 16'd1 << 16;
localparam signed [31:0] B_im_in = 16'd77;

localparam signed [31:0] W_re_in = 16'b0101101010000010 << 16; // 1 / sqrt(2) times 2e15 in binary
localparam signed [31:0] W_im_in = 16'b0101101010000010; // W_re_in and W_im_in must be pre-shifted by 2^15

logic signed [31:0] A_in = A_re_in + A_im_in;
logic signed [31:0] B_in = B_re_in + B_im_in;
logic signed [31:0] W_in = W_re_in + W_im_in;

butterfly_unit UUT (A_in,B_in,W_in,ApWB_out, AnWB_out);

endmodule