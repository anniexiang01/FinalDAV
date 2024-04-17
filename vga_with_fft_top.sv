module vga_with_fft_top (
	input in_clock,
	input reset,
	output logic hsync,
	output logic vsync,
	output logic [3:0] red,
	output logic [3:0] green,
	output logic [3:0] blue
);

// Clocking -- eventually switch to PLL
logic out_clock;
clockDivider #(50000000) clkDiv (in_clock, 25000000, 1, out_clock); // 25 MHz clock for VGA

// Graphics -- color
logic[2:0] input_red = 3'b0;
logic[2:0] input_green = 3'b0;
logic[1:0] input_blue = 2'b0;
logic[7:0] dataRead = 8'b0;
assign input_red = dataRead[7:5];
assign input_green = dataRead[4:2];
assign input_blue = dataRead[1:0];

// Graphics -- position
logic[9:0] hc_out;
logic[9:0] vc_out;
logic[9:0] x;
logic[9:0] y;
logic[19:0] addrWrite;
logic[7:0] colorWrite;

// Graphics -- bocking
assign x = hc_out / 20;
assign y = vc_out / 20;

// VGA
vga VGA (out_clock, input_red, input_green, input_blue, reset, hc_out, vc_out, hsync, vsync, red, green, blue);
pingpongRAM RAM (out_clock, addrWrite, x, y, colorWrite, dataRead);

// Microphone
// ***TO-DO***


// FFT
logic signed [35:0] F [0:15];
logic signed [35:0] f [0:15];
logic done;
logic start;
assign start = 1'b1;
fft_16pt fft (f, out_clock, reset, start, F, done);

// Graphics Module
graphics_fft graphics_fft (F, done, x, y, colorWrite, addrWrite);

endmodule
