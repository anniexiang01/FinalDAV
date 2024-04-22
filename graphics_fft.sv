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

localparam BLACK = 8'b0;
localparam WHITE = 8'b11111111;
localparam RED = 8'b11100000;

localparam HBLOCK = 20;
localparam VBLOCK = 20;

always_comb begin
	// ***TO-DO***
	// First, convert F from complex to magnitude
	// Ignore for now, just take the real part of F and shift it
	
	// determine where done check should go
	if (done == 1'b1 && h < HPIXELS/HBLOCK && v < VPIXELS/VBLOCK) begin // 16 x 96 for 40,10 -- 32x24 for 20,20
		addr = v * HPIXELS/HBLOCK + h;
		if (h < 1*HPIXELS/(16*HBLOCK)) begin
			if ($signed(v) >= ((F[0] >> 18) / 2)) begin
				color = WHITE;
			end else begin
				color = RED;
			end
		end else if (h < 2*HPIXELS/(16*HBLOCK)) begin
			if ($signed(v) >= ((F[1] >> 18) / 2)) begin
				color = WHITE;
			end else begin
				color = RED;
			end
		end else if (h < 3*HPIXELS/(16*HBLOCK)) begin
			if ($signed(v) >= ((F[2] >> 18) / 2)) begin
				color = WHITE;
			end else begin
				color = RED;
			end
		end else if (h < 4*HPIXELS/(16*HBLOCK)) begin
			if ($signed(v) >= ((F[3] >> 18) / 2)) begin
				color = WHITE;
			end else begin
				color = RED;
			end
		end else if (h < 5*HPIXELS/(16*HBLOCK)) begin
			if ($signed(v) >= ((F[4] >> 18) / 2)) begin
				color = WHITE;
			end else begin
				color = RED;
			end
		end else if (h < 6*HPIXELS/(16*HBLOCK)) begin
			if ($signed(v) >= ((F[5] >> 18) / 2)) begin
				color = WHITE;
			end else begin
				color = RED;
			end
		end else if (h < 7*HPIXELS/(16*HBLOCK)) begin
			if ($signed(v) >= ((F[6] >> 18) / 2)) begin
				color = WHITE;
			end else begin
				color = RED;
			end
		end else if (h < 8*HPIXELS/(16*HBLOCK)) begin
			if ($signed(v) >= ((F[7] >> 18) / 2)) begin
				color = WHITE;
			end else begin
				color = RED;
			end
		end else if (h < 9*HPIXELS/(16*HBLOCK)) begin
			if ($signed(v) >= ((F[8] >> 18) / 2)) begin
				color = WHITE;
			end else begin
				color = RED;
			end
		end else if (h < 10*HPIXELS/(16*HBLOCK)) begin
			if ($signed(v) >= ((F[9] >> 18) / 2)) begin
				color = WHITE;
			end else begin
				color = RED;
			end
		end else if (h < 11*HPIXELS/(16*HBLOCK)) begin
			if ($signed(v) >= ((F[10] >> 18) / 2)) begin
				color = WHITE;
			end else begin
				color = RED;
			end
		end else if (h < 12*HPIXELS/(16*HBLOCK)) begin
			if ($signed(v) >= ((F[11] >> 18) / 2)) begin
				color = WHITE;
			end else begin
				color = RED;
			end
		end else if (h < 13*HPIXELS/(16*HBLOCK)) begin
			if ($signed(v) >= ((F[12] >> 18) / 2)) begin
				color = WHITE;
			end else begin
				color = RED;
			end
		end else if (h < 14*HPIXELS/(16*HBLOCK)) begin
			if ($signed(v) >= ((F[13] >> 18) / 2)) begin
				color = WHITE;
			end else begin
				color = RED;
			end
		end else if (h < 15*HPIXELS/(16*HBLOCK)) begin
			if ($signed(v) >= ((F[14] >> 18) / 2)) begin
				color = WHITE;
			end else begin
				color = RED;
			end
		end else if (h < 16*HPIXELS/(16*HBLOCK)) begin
			if ($signed(v) >= ((F[15] >> 18) / 2)) begin
				color = WHITE;
			end else begin
				color = RED;
			end
		end else begin
			color = BLACK;
		end
	end else begin
		addr = 0;
		color = BLACK;
	end

end

endmodule