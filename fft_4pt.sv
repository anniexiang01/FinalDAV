module fft_4pt #(WIDTH=32) (
	input signed [WIDTH-1:0] f [0:3],
	input clock,
	input reset,
	input start,
	output logic signed [WIDTH-1:0] F [0:3],
	output logic done
);

localparam RESET = 2'b00;
localparam STAGE1 = 2'b01;
localparam STAGE2 = 2'b10;
localparam DONE = 2'b11;

localparam W4_0 = 32'b01111111111111110000000000000000;
localparam W4_1 = 32'b00000000000000001000000000000000;

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

logic signed [WIDTH-1:0] temp [0:3];

butterfly_unit #(WIDTH) bf1 (A1,B1,W1,ApWB1, AnWB1); // default registers for these
butterfly_unit #(WIDTH) bf2 (A2,B2,W2,ApWB2, AnWB2);

initial begin

	state = RESET;

end

always@(posedge clock) begin
	
	if (next_state != state) begin
		temp[0] <= ApWB1;
		temp[1] <= AnWB1;
		temp[2] <= ApWB2;
		temp[3] <= AnWB2;
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