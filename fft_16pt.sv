module fft_16pt #(WIDTH=36) (
	input signed [WIDTH-1:0] f [0:3],
	input clock,
	input reset,
	input start,
	output logic signed [WIDTH-1:0] F [0:3],
	output logic done
);

localparam RESET = 3'b000;
localparam STAGE1 = 3'b001;
localparam STAGE2 = 3'b010;
localparam STAGE3 = 3'b011;
localparam STAGE4 = 3'b100;
localparam DONE = 3'b101;

localparam W16_0 = 36'b011111111111111111000000000000000000
localparam W16_1 = 36'b011101100100000111110011110000010001
localparam W16_2 = 36'b010110101000001010101001010111110110
localparam W16_3 = 36'b001100001111101111100010011011111001
localparam W16_4 = 36'b000000000000000000100000000000000000
localparam W16_5 = 36'b110011110000010001100010011011111001
localparam W16_6 = 36'b101001010111110110101001010111110110
localparam W16_7 = 36'b100010011011111001110011110000010001

logic [1:0] state;
logic [1:0] next_state;

logic signed [WIDTH-1:0] A1;
logic signed [WIDTH-1:0] B1;
logic signed [WIDTH-1:0] W1;
logic signed [WIDTH-1:0] ApWB1;
logic signed [WIDTH-1:0] AnWB1;

logic signed [WIDTH-1:0] A2;
logic signed [WIDTH-1:0] B2;
logic signed [WIDTH-1:0] W2;
logic signed [WIDTH-1:0] ApWB2;
logic signed [WIDTH-1:0] AnWB2;

logic signed [WIDTH-1:0] A3;
logic signed [WIDTH-1:0] B3;
logic signed [WIDTH-1:0] W3;
logic signed [WIDTH-1:0] ApWB3;
logic signed [WIDTH-1:0] AnWB3;

logic signed [WIDTH-1:0] A4;
logic signed [WIDTH-1:0] B4;
logic signed [WIDTH-1:0] W4;
logic signed [WIDTH-1:0] ApWB4;
logic signed [WIDTH-1:0] AnWB4;

logic signed [WIDTH-1:0] A5;
logic signed [WIDTH-1:0] B5;
logic signed [WIDTH-1:0] W5;
logic signed [WIDTH-1:0] ApWB5;
logic signed [WIDTH-1:0] AnWB5;

logic signed [WIDTH-1:0] A6;
logic signed [WIDTH-1:0] B6;
logic signed [WIDTH-1:0] W6;
logic signed [WIDTH-1:0] ApWB6;
logic signed [WIDTH-1:0] AnWB6;

logic signed [WIDTH-1:0] A7;
logic signed [WIDTH-1:0] B7;
logic signed [WIDTH-1:0] W7;
logic signed [WIDTH-1:0] ApWB7;
logic signed [WIDTH-1:0] AnWB7;

logic signed [WIDTH-1:0] A8;
logic signed [WIDTH-1:0] B8;
logic signed [WIDTH-1:0] W8;
logic signed [WIDTH-1:0] ApWB8;
logic signed [WIDTH-1:0] AnWB8;


logic signed [WIDTH-1:0] temp [0:15];

butterfly_unit #(WIDTH) bf1 (A1,B1,W1,ApWB1, AnWB1); // default registers for these
butterfly_unit #(WIDTH) bf2 (A2,B2,W2,ApWB2, AnWB2);
butterfly_unit #(WIDTH) bf3 (A3,B3,W3,ApWB3, AnWB3);
butterfly_unit #(WIDTH) bf4 (A4,B4,W4,ApWB4, AnWB4);
butterfly_unit #(WIDTH) bf5 (A5,B5,W5,ApWB5, AnWB5);
butterfly_unit #(WIDTH) bf6 (A6,B6,W6,ApWB6, AnWB6);
butterfly_unit #(WIDTH) bf7 (A7,B7,W7,ApWB7, AnWB7);
butterfly_unit #(WIDTH) bf8 (A8,B8,W8,ApWB8, AnWB8);

initial begin

	state = RESET;

end

always@(posedge clock) begin
	
	if (next_state != state) begin
		temp[0] <= ApWB1;
		temp[1] <= AnWB1;
		temp[2] <= ApWB2;
		temp[3] <= AnWB2;
		temp[4] <= ApWB3;
		temp[5] <= AnWB3;
		temp[6] <= ApWB4;
		temp[7] <= AnWB4;
		temp[8] <= ApWB5;
		temp[9] <= AnWB5;
		temp[10] <= ApWB6;
		temp[11] <= AnWB6;
		temp[12] <= ApWB7;
		temp[13] <= AnWB7;
		temp[14] <= ApWB8;
		temp[15] <= AnWB8;
	end
	state <= next_state;
end

// could optimize by reuse of temp registers instead of updating W,A,B,F at every step
// then, only temp[] regs, done, and next_state would need to be updated
always_comb begin
	// FSM
	case (state)
		RESET: 
			begin
				if (start == 1'b1) begin
					W1 = W4_0;
					W2 = W4_0;
					A1 = f[0];
					B1 = f[2];
					A2 = f[1];
					B2 = f[3];
					F[0] = {WIDTH{1'b0}};
					F[1] = {WIDTH{1'b0}};
					F[2] = {WIDTH{1'b0}};
					F[3] = {WIDTH{1'b0}};
					done = 1'b0;
					next_state = STAGE1;
				end
				else begin
					W1 = W4_0;
					W2 = W4_0;
					A1 = f[0];
					B1 = f[2];
					A2 = f[1];
					B2 = f[3];
					F[0] = {WIDTH{1'b0}};
					F[1] = {WIDTH{1'b0}};
					F[2] = {WIDTH{1'b0}};
					F[3] = {WIDTH{1'b0}};
					done = 1'b0;
					next_state = state;
				end
			end
		STAGE1: 
			begin
				W1 = W4_0;
				W2 = W4_0;
				A1 = f[0];
				B1 = f[2];
				A2 = f[1];
				B2 = f[3];
				F[0] = {WIDTH{1'b0}};
				F[1] = {WIDTH{1'b0}};
				F[2] = {WIDTH{1'b0}};
				F[3] = {WIDTH{1'b0}};
				done = 1'b0;
				next_state = STAGE2;
			end
		STAGE2: 
			begin
				W1 = W4_0;
				W2 = W4_1;
				A1 = temp[0];
				B1 = temp[2];
				A2 = temp[1];
				B2 = temp[3];
				F[0] = {WIDTH{1'b0}};
				F[1] = {WIDTH{1'b0}};
				F[2] = {WIDTH{1'b0}};
				F[3] = {WIDTH{1'b0}};
				done = 1'b0;
				next_state = DONE;
			end
		DONE: 
			begin
				if (reset == 1'b1) begin
					W1 = W4_0;
					W2 = W4_0;
					A1 = f[0];
					B1 = f[2];
					A2 = f[1];
					B2 = f[3];
					F[0] = {WIDTH{1'b0}};
					F[1] = {WIDTH{1'b0}};
					F[2] = {WIDTH{1'b0}};
					F[3] = {WIDTH{1'b0}};
					done = 1'b0;
					next_state = RESET;
				end
				else begin
					W1 = W4_0;
					W2 = W4_0;
					A1 = f[0];
					B1 = f[2];
					A2 = f[1];
					B2 = f[3];
					F[0] = temp[0];
					F[1] = temp[2];
					F[2] = temp[1];
					F[3] = temp[3];
					done = 1'b1;
					next_state = state;
				end
			end
		default: 
			begin
				W1 = W4_0;
				W2 = W4_0;
				A1 = f[0];
				B1 = f[2];
				A2 = f[1];
				B2 = f[3];
				F[0] = {WIDTH{1'b0}};
				F[1] = {WIDTH{1'b0}};
				F[2] = {WIDTH{1'b0}};
				F[3] = {WIDTH{1'b0}};
				done = 1'b0;
				next_state = RESET;
			end
	endcase
end

endmodule