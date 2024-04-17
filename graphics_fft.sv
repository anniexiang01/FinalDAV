module graphics_fft (
	input logic signed [35:0] F [0:15],
	input logic done,
	input logic [9:0] h,
	input logic [9:0] v,
	output logic [7:0] color,
	output logic [19:0] addr
);

localparam HPIXELS = 640;    // number of visible pixels per horizontal line
localparam HFP = 16; 	      // length (in pixels) of horizontal front porch
localparam HSPULSE = 96; 	// length (in pixels) of hsync pulse
localparam HBP = 48; 	      // length (in pixels) of horizontal back porch

localparam VPIXELS = 480;    // number of visible horizontal lines per frame
localparam VFP = 10; 	      // length (in pixels) of vertical front porch
localparam VSPULSE = 2;    // length (in pixels) of vsync pulse
localparam VBP = 33; 		   // length (in pixels) of vertical back porch

logic signed [5:0] F_small [0:15];

always_comb begin
	// ***TO-DO***
	// First, convert F from complex to magnitude
	// Ignore for now, just take the real part of F and shift it
	
	F_small[0] = F[0] >> 30; // check if this truncation works for one bar
	
	if (h < HPIXELS/20 && v < VPIXELS/20) begin // 32 x 24
		addr = v * 32 + h;
		if (h >= 4) begin
			if (F_small[0] > 0) begin
				color = 8'b11111111;
			end else begin
				color = 8'b00011100;
			end
		end else begin
			color = 8'b00000000;
		end
	end else begin
		addr = 0;
		color = 8'b00000000;
	end
	
/*
	// Draw our pixel shapes here
	if (h < HPIXELS/20 && v < VPIXELS/20) begin // 32 x 24
		addr = v * 32 + h;
		if (h < 16 && v < 12) begin
			color = 8'b00000011;
		end else if (h < 16 && v >= 12) begin
			color = 8'b00011100;
		end else if (h >= 16 && v < 12) begin
			color = 8'b11100000;
		end else if (h >= 16 && v >= 12) begin
			color = 8'b11111111;
		end else begin
			color = 8'b0;
		end

	end else begin
		addr = 0;
		color = 8'b00000000;
	end
*/

end

endmodule