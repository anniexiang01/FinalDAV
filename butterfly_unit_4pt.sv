module butterfly_unit_4pt #(WIDTH=32)(
	input signed [WIDTH-1:0] A,
	input signed [WIDTH-1:0] B,
	input signed [WIDTH-1:0] W,
	output signed [WIDTH-1:0] ApWB,
	output signed [WIDTH-1:0] AnWB
);

	wire signed [WIDTH/2-1:0] A_re = A[WIDTH/2-1:0]; 
	wire signed [WIDTH/2-1:0] A_im = A[WIDTH-1:WIDTH/2]; 
	wire signed [WIDTH/2-1:0] B_re = B[WIDTH/2-1:0];
	wire signed [WIDTH/2-1:0] B_im = B[WIDTH-1:WIDTH/2];
	wire signed [WIDTH/2-1:0] W_re = W[WIDTH/2-1:0];
	wire signed [WIDTH/2-1:0] W_im = W[WIDTH-1:WIDTH/2];
	
	wire signed [WIDTH-1:0] WB_re = W_re * B_re - W_im * B_im;
	wire signed [WIDTH-1:0] WB_im = W_im * B_re + W_re * B_im;

	wire signed [WIDTH/2-1:0] WB_re_trunc = WB_re[WIDTH-2:WIDTH/2-1]; // 31:0 -> 30:15 for WIDTH=32
	wire signed [WIDTH/2-1:0] WB_im_trunc = WB_im[WIDTH-2:WIDTH/2-1];
	
	wire signed [WIDTH/2-1:0] ApWB_re = A_re + WB_re_trunc;
	wire signed [WIDTH/2-1:0] ApWB_im = A_im + WB_im_trunc;
	
	wire signed [WIDTH/2-1:0] AnWB_re = A_re - WB_re_trunc;
	wire signed [WIDTH/2-1:0] AnWB_im = A_im - WB_im_trunc;
	
	assign ApWB = ApWB_re << WIDTH/2 + ApWB_im;
	assign AnWB = AnWB_re << WIDTH/2 + AnWB_im;
	
endmodule