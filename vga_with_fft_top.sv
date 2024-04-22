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
logic [2:0] input_red = 3'b0;
logic [2:0] input_green = 3'b0;
logic [1:0] input_blue = 2'b0;
logic [7:0] dataRead = 8'b0;
assign input_red = dataRead[7:5];
assign input_green = dataRead[4:2];
assign input_blue = dataRead[1:0];

// Graphics -- position
logic [9:0] hc_out;
logic [9:0] vc_out;
logic [9:0] x;
logic [9:0] y;
logic [19:0] addrWrite;
logic [7:0] colorWrite;

// Graphics -- bocking
localparam HBLOCK = 20;
localparam VBLOCK = 20;

assign x = hc_out / HBLOCK;
assign y = vc_out / VBLOCK;

// VGA
vga VGA (out_clock, input_red, input_green, input_blue, reset, hc_out, vc_out, hsync, vsync, red, green, blue);
pingpongRAM RAM (out_clock, addrWrite, x, y, colorWrite, dataRead);

// FFT
logic signed [35:0] F [0:15];
logic signed [35:0] f [0:15];
logic done;
logic start;
assign start = 1'b1;
fft_16pt fft (f, out_clock, 1'b0, start, F, done);

// Microphone
// ***TO-DO***
logic [11:0] adc_out;
clockDivider #(50000000) adcClkDiv (in_clock, 5000, 1, adc_clock);
micadc mic (.CLOCK(adc_clock), .RESET(1'b0), .CH0(adc_out));
adc_shifter shifter (adc_clock, adc_out, f);

// Graphics Module
graphics_fft graphics_fft (F, done, x, y, colorWrite, addrWrite);

initial begin
	f[0] = {18'd100, 18'd0};
	f[1] = {18'd100, 18'd0};
	f[2] = {18'd100, 18'd0};
	f[3] = {18'd100, 18'd0};
	f[4] = {18'd100, 18'd0};
	f[5] = {18'd100, 18'd0};
	f[6] = {18'd100, 18'd0};
	f[7] = {18'd100, 18'd0};
	f[8] = {18'd100, 18'd0};
	f[9] = {18'd100, 18'd0};
	f[10] = {18'd100, 18'd0};
	f[11] = {18'd100, 18'd0};
	f[12] = {18'd100, 18'd0};
	f[13] = {18'd100, 18'd0};
	f[14] = {18'd100, 18'd0};
	f[15] = {18'd100, 18'd0};
end

endmodule
