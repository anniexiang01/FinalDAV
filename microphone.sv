module microphone #(WIDTH=36) (
	input clock,
	output logic signed [WIDTH-1:0] f [0:15]
);
	logic [11:0] ch0;
	logic [11:0] ch1;
	logic [11:0] ch2;
	logic [11:0] ch3;
	logic [11:0] ch4;
	logic [11:0] ch5;
	logic [11:0] ch6;
	logic [11:0] ch7;
	
	// check reset as 1'b0 or 1'b1
	micadc adc (clock, 1'b0, ch0, ch1, ch2, ch3, ch4, ch5, ch6, ch7);
	
	logic signed [WIDTH-1:0] temp [0:15];
	
	always@(posedge clock) begin
		temp[0] <= ch0;
		temp[1] <= f[0];
		temp[2] <= f[1];
		temp[3] <= f[2];
		temp[4] <= f[3];
		temp[5] <= f[4];
		temp[6] <= f[5];
		temp[7] <= f[6];
		temp[8] <= f[7];
		temp[9] <= f[8];
		temp[10] <= f[9];
		temp[11] <= f[10];
		temp[12] <= f[11];
		temp[13] <= f[12];
		temp[14] <= f[13];
		temp[15] <= f[14];
	end
	
	always_comb begin
		f[0] = temp[0];
		f[1] = temp[1];
		f[2] = temp[2];
		f[3] = temp[3];
		f[4] = temp[4];
		f[5] = temp[5];
		f[6] = temp[6];
		f[7] = temp[7];
		f[8] = temp[8];
		f[9] = temp[9];
		f[10] = temp[10];
		f[11] = temp[11];
		f[12] = temp[12];
		f[13] = temp[13];
		f[14] = temp[14];
		f[15] = temp[15];
	end

endmodule